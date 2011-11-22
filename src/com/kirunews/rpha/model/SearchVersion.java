package com.kirunews.rpha.model;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;

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

public class SearchVersion {

	private static Logger logger = Logging.getLogger();
	private static String[] referenceFields = { "v61", "v65", "v161", "v162", "v165" };
	private static String[] bookReferenceFields = { "v51", "v52" };
	private static String indexDir = Configuration.params.getIndexDir();
	private static Searcher searcher;
	private static Analyzer analyzer;

	public SearchVersion() throws IOException {
		Directory dir = FSDirectory.getDirectory(indexDir);
		searcher = new IndexSearcher(dir);
		analyzer = new StandardAnalyzer();
	}

	public static void main(String[] args) throws IOException {
		SearchVersion clq = new SearchVersion();
		HashMap<String, String> query = new HashMap<String, String>();
		query.put("id", "0101");
		query.put("v91", "9");
		String xml = clq.search(query, true);
		logger.info(xml);
	}

	public String search(HashMap<String, String> query) 
		throws IOException {
		return search(query, false);
	}

	public String search(HashMap<String, String> query, boolean getReferences) 
		throws IOException 
	{
		StringBuffer xml = new StringBuffer();
		try {
			xml.append("<repert>");

			ArrayList<Document> result = execute(query);
			logger.info(DateUtil.getTime() + " - execute");
			Iterator<Document> itResult = result.iterator();
			while (itResult.hasNext()) {
				xml.append(itResult.next().get("record"));
				if(getReferences == true) {
					ArrayList<Document> referenceDocs = getReferenceQueries(result);
					if(referenceDocs.size() > 0) {
						Iterator<Document> itRefs = referenceDocs.iterator();
						while (itRefs.hasNext()) {
							Document d = itRefs.next();
							xml.append("\n" + d.get("record"));
						}
					}
				}
			}
			
			logger.info(DateUtil.getTime() + " - dump");
			xml.append("</repert>\n");

		} catch (Exception e) {
			e.printStackTrace();
		}
		// logout(session);
		return xml.toString();
	}
	
	private ArrayList<Document> execute(HashMap<String, String> query)
		throws ParseException, IOException {
		ArrayList<Document> result = new ArrayList<Document>();
		BooleanQuery bq = new BooleanQuery();
		for(String key : query.keySet()){
			QueryParser p = new QueryParser(key, analyzer);
			Query q = p.parse(query.get(key));
			bq.add(q, BooleanClause.Occur.MUST);
		}
		Hits hits = searcher.search(bq);
		logger.info(bq.toString() + " has " + hits.length() + " record(s)");
		
		if(hits.length() > 0) {
			for(int i=0; i<hits.length(); i++) {
				result.add(hits.doc(i));
			}
		}
		return result;
	}

	private ArrayList<Document> getReferenceQueries(ArrayList<Document> result) {
		ArrayList<Document> results = new ArrayList<Document>();
		HashMap<String, String> uniqueIds = new HashMap<String, String>();
		HashMap<String, String> query = new HashMap<String, String>();
		Iterator<Document> it = result.iterator();
		while (it.hasNext()) {
			Document d = it.next();
			try {
				for (int j = 0; j < referenceFields.length; j++) {
					String field = referenceFields[j];
					if (d.get(field) != null) {
						String[] values = d.getValues(field);
						for(int i=0; i<values.length; i++) {
							String v1 = values[i];
							if(!uniqueIds.containsKey(v1)){
								query.put("id", v1);
								results.addAll(execute(query));
								query.clear();
								uniqueIds.put(v1, "t");
							}
						}
					}
				}

				for (int j = 0; j < bookReferenceFields.length; j++) {
					String field = bookReferenceFields[j];
					if (d.get(field) != null) {
						String[] values = d.getValues(field);
						for(int i=0; i<values.length; i++) {
							String bookId = d.get(field + "_bookId_" + i);
							if(!uniqueIds.containsKey(bookId)){
								query.put("id", bookId);
								results.addAll(execute(query));
								query.clear();
								uniqueIds.put(bookId, "t");
							}
						}
					}
				}
			} catch(IOException e) {
				e.printStackTrace();
			} catch(ParseException e) {
				e.printStackTrace();
			}
		}
		return results;
	}
}
