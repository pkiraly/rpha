import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.lucene.analysis.SimpleAnalyzer;
import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.index.CorruptIndexException;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;

import com.kirunews.rpha.model.XmlIndexer;
import com.kirunews.rpha.util.Configuration;
import com.kirunews.rpha.util.ConfigurationException;

import junit.framework.TestCase;


public class XmlImportTest extends TestCase {

	private static String baseDir = "E:/web_projects/rpha/";
	private static String indexDir		= baseDir + "index";
	private static String xmlFileName	= baseDir + "config/exportAfter.xml";
	private static Pattern rec = Pattern.compile("<rec id=\"([^\"]+)\">");
	private static Pattern pId = Pattern.compile("<rec id=\"([^\"]+)\">");
	private static Pattern v101 = Pattern.compile("<v101 value=\"([^\"]+)\"");
	private static Pattern v111 = Pattern.compile("<v111 value=\"([^\"]+)\"");
	private static Pattern fieldPattern = 
		Pattern.compile("<(v\\d+) value=\"([^\"]*?)\"/>");
	private static Pattern subFieldPattern = 
		Pattern.compile("<(v\\d+)(( ([^=]+?)=\"([^\"]*?)\")+)/>");
	private static Pattern attributePattern = 
		Pattern.compile("^ ([^=]+?)=\"([^\"]*?)\"");
	private Directory dir;
	private IndexWriter writer;
	private HashMap<String, String> untokenizedFieldHash = 
		new HashMap<String, String>();
	private static int[] untokenizedFields = {
		1, 11
	};
	
	public void setUp() {
		try {
			dir = FSDirectory.getDirectory(indexDir);
			writer = new IndexWriter(dir, new StandardAnalyzer(), true);
			writer.setMergeFactor(1000);
			setupUntokenizedFieldHash();
		} catch(IOException e) {
			e.printStackTrace();
		}
	}
	
	public void testImport() throws ConfigurationException, CorruptIndexException, 
		FileNotFoundException, IOException {
		long start = System.currentTimeMillis();
		Configuration.init("e:/web_projects/rpha/tomcat/common/classes/rpha.properties");
		XmlIndexer indexer = new XmlIndexer(
			Configuration.params.getIndexDir(),
			Configuration.params.getConfigDir() + "/exportAfter.xml"
		);
		indexer.index(true);
		long end = System.currentTimeMillis();
		System.out.println("takes: " + (end-start) + " ms");
	}

	public void testImportLocal() {
		try {
			long start = System.currentTimeMillis(); 
	        InputStream fileStream = new FileInputStream(xmlFileName);
	        InputStreamReader in = new InputStreamReader(fileStream, "UTF-8");

			BufferedReader reader = new BufferedReader(in);
			String line;
			StringBuffer recordBuffer = new StringBuffer();
			HashMap<String, String> uniqueIds = new HashMap<String, String>();
			Document doc = new Document();
			int lineNr = 0;
			while((line = reader.readLine()) != null) {
				lineNr++;
				if(lineNr > 1) {
					
					if(line.indexOf("<rec ") > -1) {
						
						String id = "";
						Matcher m = rec.matcher(line);
						if(m.find()){
							id = m.group(1);
						} else {
							System.out.println("unmatched rec " + lineNr + ": " + line);
						}

						recordBuffer = new StringBuffer();
						uniqueIds = null;
						uniqueIds = new HashMap<String, String>();

						doc = new Document();
						recordBuffer.append(line);
						doc.add(text("id", id));
					} else if(line.indexOf("</rec>") > -1) {
						recordBuffer.append(line);
						String record = recordBuffer.toString();
						String id;
						Matcher m = pId.matcher(record);
						if(m.find()) {
							id = m.group(1);
						} else {
							StringBuffer idBuffer = new StringBuffer();
							m = v101.matcher(record);
							if(m.find()) {
								idBuffer.append(m.group(1));
							} else {
								System.out.println("ERROR: nincs v101!!");
							}
							m = v111.matcher(record);
							if(m.find()) {
								idBuffer.append(m.group(1));
							} else {
								System.out.println("ERROR: nincs v111!: " + lineNr);
							}
							id = idBuffer.toString();
						}
						doc.add(keyword("record", record));
						writer.addDocument(doc);
					} else {
						Matcher m = fieldPattern.matcher(line);
						if(m.find()) {
							String f = m.group(1);
							String v = m.group(2);
							doc.add(text(f, v));
						} else {
							m = subFieldPattern.matcher(line);
							if(m.find()) {
								String f = m.group(1);
								int counter = (uniqueIds.containsKey(f)) 
									? Integer.parseInt(uniqueIds.get(f)) + 1
									: 0;
								uniqueIds.put(f, ""+counter);
									
								String attributes = m.group(2);
								int prevLength = 0;
								while(attributes.length() > 0 
										&& prevLength != attributes.length()) {
									prevLength = attributes.length();
									m = attributePattern.matcher(attributes);
									if(m.find()) {
										String sf = (m.group(1).equals("value")) 
											? f 
											: f + "_" + m.group(1);
										String v = m.group(2);
										attributes = attributes.substring(m.end());
									
										doc.add(text(sf, v));
										doc.add(text(sf + "_" + counter, v));
									}
								}
							} else {
								System.out.println("subFieldPattern not match: " 
										+ lineNr + ": " + line);
							}
						}
						recordBuffer.append(line);
					}
				}
			}
			writer.optimize();
			writer.close();
			long end = System.currentTimeMillis();
			System.out.println("takes: " + (end-start) + " ms");

		} catch(FileNotFoundException e) {
			e.printStackTrace();
		} catch(IOException e) {
			e.printStackTrace();
		}
	}
	
	private boolean isUntokenized(String field) {
		if(untokenizedFieldHash.containsKey(field)){
			return true;
		} 
		return false;
	}

	private void setupUntokenizedFieldHash() {
		for(int i = 0; i<untokenizedFields.length; i++) {
			untokenizedFieldHash.put("v" + untokenizedFields[i], "true");
		}
	}
	
	private Field text(String name, String value){
		return new Field(name, value, Field.Store.YES, Field.Index.TOKENIZED);
	}

	private Field keyword(String name, String value){
		return new Field(name, value, Field.Store.YES, Field.Index.UN_TOKENIZED);
	}
}
