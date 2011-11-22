package com.kirunews.rpha.model;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;

import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;

import org.apache.log4j.Logger;
import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.queryParser.ParseException;
import org.apache.lucene.queryParser.QueryParser;
import org.apache.lucene.search.BooleanClause;
import org.apache.lucene.search.BooleanQuery;
import org.apache.lucene.search.Hits;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.Searcher;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;

import com.kirunews.rpha.util.Configuration;
import com.kirunews.rpha.util.DateUtil;
import com.kirunews.rpha.util.Logging;
import com.kirunews.rpha.util.XsltTransformator;
import java.lang.String;

public class SearchBook {

	private static String xsltDir = Configuration.params.getConfigDir()
			+ "/xslt/";
	private static String indexDir = Configuration.params.getIndexDir();
	private static Searcher searcher;
	private static Analyzer analyzer;
	private static Logger logger = Logging.getLogger();

	public SearchBook() throws FileNotFoundException, IOException {
		Directory dir = FSDirectory.getDirectory(indexDir);
		searcher = new IndexSearcher(dir);
		analyzer = new StandardAnalyzer();
	}

	public ArrayList<Document> execute(String field, String value)
			throws ParseException, IOException {
		ArrayList<Document> result = new ArrayList<Document>();
		QueryParser p = new QueryParser(field, analyzer);
		Query q = p.parse(value);
		Hits hits = searcher.search(q);
		logger.info(q.toString() + " -> " + hits.length());

		if (hits.length() > 0) {
			for (int i = 0; i < hits.length(); i++) {
				result.add(hits.doc(i));
			}
		}
		return result;
	}

	private ArrayList<Document> execute(String[] fields, String[] values)
			throws ParseException, IOException {
		ArrayList<Document> result = new ArrayList<Document>();
		BooleanQuery bq = new BooleanQuery();
		for (int i = 0; i < fields.length; i++) {
			QueryParser p = new QueryParser(fields[i], analyzer);
			Query q = p.parse(values[i]);
			bq.add(q, BooleanClause.Occur.MUST);
		}

		Hits hits = searcher.search(bq);
		logger.info(bq.toString() + " -> " + hits.length());
		System.out.println(bq.toString() + " -> " + hits.length());
		if (hits.length() > 0) {
			for (int i = 0; i < hits.length(); i++){
				result.add(hits.doc(i));
			}
		}
		return result;
	}

	private String transform(String xmlSource, String xsltFileName,
			String bookId) throws FileNotFoundException,
			TransformerConfigurationException, TransformerException {
		// logger.info(xmlSource);
		HashMap<String, String> params = new HashMap<String, String>();
		params.put("bookId", bookId);
		XsltTransformator t = new XsltTransformator();
		t.setParams(params);
		String output = t.transform(xmlSource, xsltFileName);
		return output;
	}

	private ArrayList<Document> getPoems(ArrayList<Document> result) {
		ArrayList<Document> results = new ArrayList<Document>();
		for (Iterator<Document> it = result.iterator(); it.hasNext();) {
			Document d = it.next();
			try {
				String fieldName = d.getField("v101").stringValue().startsWith(
						"MKEVB") ? "v52_bookId" : "v51_bookId";
				results.addAll(execute(fieldName, d.getField("id")
						.stringValue()));
			} catch (IOException e) {
				e.printStackTrace();
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}

		return results;
	}

	public String search(String fields[], String values[], boolean getReferences)
			throws IOException {
		logger.info("=== search(" + fields[0] + ", " + values[0] + ")");
		
		StringBuffer xml = new StringBuffer();
		try {
			xml.append("<repert>");
			ArrayList<Document> result = execute(fields, values);
			logger.info(DateUtil.getTime() + " - execute");
			for (Iterator<Document> itResult = result.iterator(); itResult.hasNext();) {
				Document doc = itResult.next();
				logger.info("doc id: " + doc.get("id"));
				xml.append(doc.get("record"));
				if (getReferences) {
					ArrayList<Document> referenceDocs = getPoems(result);
					if (referenceDocs.size() > 0) {
						String rec;
						Iterator itRefs = referenceDocs.iterator();
						Document reference;
						while(itRefs.hasNext()) {
							reference = (Document) itRefs.next();
							logger.info("ref id: " + reference.get("id"));
							rec = reference.get("record");
							rec = transform(rec, xsltDir + "poemFilter.xsl",
									values[0]);
							xml.append("\n").append(rec);
						}
					}
				}
			}

			logger.info(DateUtil.getTime() + " - dump");
			xml.append("</repert>\n");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return xml.toString();
	}
}
