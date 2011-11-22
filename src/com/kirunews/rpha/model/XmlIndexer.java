package com.kirunews.rpha.model;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.log4j.Logger;
import org.apache.lucene.analysis.PerFieldAnalyzerWrapper;
import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.index.CorruptIndexException;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.index.Term;

import com.kirunews.rpha.util.Configuration;
import com.kirunews.rpha.util.DigitAnalyzer;
import com.kirunews.rpha.util.Logging;

public class XmlIndexer {
	private static Logger logger = Logging.getLogger();

	private String indexDir;
	private String xmlFileName;

	private static Pattern rec = Pattern.compile("<rec id=\"([^\"]+)\">");
	private static Pattern fieldPattern = Pattern
			.compile("<(v\\d+) value=\"([^\"]*?)\"/>");
	private static Pattern subFieldPattern = Pattern
			.compile("<(v\\d+)(( ([^=]+?)=\"([^\"]*?)\")+)/>");
	private static Pattern attributePattern = Pattern
			.compile("^ ([^=]+?)=\"([^\"]*?)\"");
	private String lastInsertedID = null;
	private IndexWriter writer;
	private HashMap<String, String> untokenizedFieldHash = 
										new HashMap<String, String>();
	private String xmlString;
	private static int[] untokenizedFields = {
		1, 11
	};
	
	public XmlIndexer() {
		if(Configuration.params.getIndexDir() != null){
			indexDir	= Configuration.params.getIndexDir();
			xmlFileName	= Configuration.params.getConfigDir() 
									+ "/properties3.xml";
		}
	}

	public XmlIndexer(String indexDir, String xmlFileName) {
		this.indexDir = indexDir;
		this.xmlFileName = xmlFileName;
	}

	public void index() throws IOException, FileNotFoundException, CorruptIndexException {
		index(false);
	}

	public void index(boolean create) throws IOException, FileNotFoundException, CorruptIndexException {
		try {
			long start = System.currentTimeMillis();
			PerFieldAnalyzerWrapper analyzer = new PerFieldAnalyzerWrapper(new StandardAnalyzer());
			analyzer.addAnalyzer("v28", new DigitAnalyzer());
			writer = new IndexWriter(indexDir, analyzer, create);
			writer.setMergeFactor(1000);
			writer.setUseCompoundFile(false);
			setupUntokenizedFieldHash();
			
			BufferedReader reader = getBufferedReader();
			String line;
			StringBuffer recordBuffer = new StringBuffer();
			HashMap<String, String> uniqueIds = new HashMap<String, String>();
			Document doc = new Document();
			int lineNr = 0;
			logger.info("docCount: " + writer.docCount());
			while((line = reader.readLine()) != null) {
				lineNr++;
				if(lineNr > 1) {

					if(line.indexOf("<rec ") > -1) {
						
						String id = "";
						Matcher matcher = rec.matcher(line);
						if(matcher.find()){
							id = matcher.group(1);
							
						} else {
							logger.info("rec without id: " + line);
						}
						recordBuffer = new StringBuffer();
						uniqueIds = null;
						uniqueIds = new HashMap<String, String>();
						doc = new Document();
						recordBuffer.append(line);
						doc.add(new Field("id", id, Field.Store.YES, Field.Index.TOKENIZED));
						doc.add(new Field("rpha", id, Field.Store.YES, Field.Index.UN_TOKENIZED));
					} else if(line.indexOf("</rec>") > -1) {
						recordBuffer.append(line);
						String record = recordBuffer.toString();
						doc.add(new Field("record", record, Field.Store.YES, Field.Index.UN_TOKENIZED));
						writer.addDocument(doc);
						lastInsertedID = doc.get("id");
						logger.info("add doc with id: " + doc.get("id") + ", " + doc.get("rpha"));
					} else {
						Matcher matcher = fieldPattern.matcher(line);
						if(matcher.find()) {
							String fieldName = matcher.group(1);
							String value = fromXml(matcher.group(2));
							doc.add(new Field(fieldName, value, Field.Store.YES, Field.Index.TOKENIZED));
						} else {
							matcher = subFieldPattern.matcher(line);
							if(matcher.find()) {
								String fieldName = matcher.group(1);
								int counter = (uniqueIds.containsKey(fieldName)) 
									? Integer.parseInt(uniqueIds.get(fieldName)) + 1
									: 0;
								uniqueIds.put(fieldName, ""+counter);
									
								String attributes = matcher.group(2);
								int prevLength = 0;
								while(attributes.length() > 0 && prevLength != attributes.length()) {
									prevLength = attributes.length();
									matcher = attributePattern.matcher(attributes);
									if(matcher.find()) {
										String attribName = matcher.group(1);
										String value = fromXml(matcher.group(2));
										String subFieldName = (attribName.equals("value")) 
											? fieldName 
											: fieldName + "_" + attribName;
										attributes = attributes.substring(matcher.end());
									
										doc.add(new Field(subFieldName, value, Field.Store.YES, Field.Index.TOKENIZED));
										doc.add(new Field(subFieldName + "_" + counter, value, Field.Store.YES, Field.Index.TOKENIZED));
									}
								}
							} else {
								logger.info("else: " + line);
							}
						}
						recordBuffer.append(line);
					}
				}
			}
			logger.info("docCount: " + writer.docCount());
			//writer.optimize();
			writer.close();
			long end = System.currentTimeMillis();
			logger.info("takes: " + (end-start) + " ms");
		} catch(FileNotFoundException e) {
			throw new FileNotFoundException(e.getMessage());
		}
	}
	
	public int deleteDocs(String poem, String bookId) throws IOException {
		logger.info("deleteDocs: " + poem + ", " + bookId);
		writer = new IndexWriter(indexDir, new StandardAnalyzer(), false);
		int before = writer.docCount();

		logger.info("before delete: " + before);
		Term term = new Term("rpha", poem + "-" + bookId);
		logger.info(term.toString());
		writer.deleteDocuments(term);

		writer.optimize();

		int after = writer.docCount();
		logger.info("deletedDocs: " + (before-after));
		logger.info("after delete: " + after);
		writer.close();
		return (before-after);
	}

	public int deleteBook(String bookId) throws IOException {
		logger.info("deleteBook: " + bookId);
		writer = new IndexWriter(indexDir, new StandardAnalyzer(), false);
		int before = writer.docCount();

		logger.info("before delete: " + before);
		Term term = new Term("id", bookId.toLowerCase());
		logger.info(term.toString());
		writer.deleteDocuments(term);

		writer.optimize();

		int after = writer.docCount();
		logger.info("deletedDocs: " + (before-after));
		logger.info("after delete: " + after);
		writer.close();
		return (before-after);
	}

	private void setupUntokenizedFieldHash() {
		for(int i = 0; i<untokenizedFields.length; i++) {
			untokenizedFieldHash.put("v" + untokenizedFields[i], "true");
		}
	}
	
	public void setXmlString(String xml) {
		xmlString = xml;
	}

	public void setXmlFile(String fileName) {
		xmlFileName = fileName;
	}
	
	public void setIndexDir(String indexDir) {
		this.indexDir = indexDir;
	}

	public InputStreamReader getStreamReader() throws FileNotFoundException, UnsupportedEncodingException {
		InputStream fileStream = new FileInputStream(xmlFileName);
		InputStreamReader in = new InputStreamReader(fileStream, "UTF-8");
		return in;
	}

	public BufferedReader getBufferedReader() throws FileNotFoundException, UnsupportedEncodingException {
		BufferedReader reader = (xmlString != null)
			? new BufferedReader(new StringReader(xmlString))
			: new BufferedReader(getStreamReader());
		return reader;
	}
	
	public String getLastInsertedId() {
		return lastInsertedID;
	}
	
	private String fromXml(String text) {
		return text.replace("&quot;", "\"")
			.replace("&lt;", "<")
			.replace("&gt;", ">")
			.replace("&amp;", "&")
			.replace("&apos;", "'")
		;
	}

	private String toXml(String text) {
		return text
			.replace("\"", "&quot;")
			.replace("<", "&lt;")
			.replace(">", "&gt;")
			.replace("&", "&amp;")
			.replace("'", "&apos;")
		;
	}
}
