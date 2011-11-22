package com.kirunews.rpha.model;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.FieldSelector;
import org.apache.lucene.queryParser.ParseException;
import org.apache.lucene.queryParser.QueryParser;
import org.apache.lucene.queryParser.QueryParser.Operator;
import org.apache.lucene.search.BooleanClause;
import org.apache.lucene.search.BooleanQuery;
import org.apache.lucene.search.Hits;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.Searcher;
import org.apache.lucene.search.Sort;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;

import com.kirunews.rpha.struts.form.Item;
import com.kirunews.rpha.util.Configuration;
import com.kirunews.rpha.util.DateUtil;
import com.kirunews.rpha.util.Logging;
import java.lang.String;

public class PoemSearcher {

	/**
	 * reference fields - azon versek azonosító számai (id, v1) vannak ezekben a
	 * mezőkben, melyek valahogyan kapcsolódnak az adott vershez
	 * <ul>
	 * <li>v61 - a vers nótajelzései</li>
	 * <li>v65 - a verset nótajelzésként használó versek</li>
	 * <li>v161 - rész-egész viszony két vers között</li>
	 * <li>v162 - azonos forrásból készített átdolgozások, fordítások</li>
	 * <li>v165 - mellékadatlapok</li>
	 * </ul>
	 */
	public static final List<String> referenceFields = Arrays.asList(
			"v61", "v65", "v161", "v162", "v165"
	);

	/**
	 * ugyanennek a versnek a különféle változatai
	 */
	public static final List<String> versionFields = Arrays.asList(
			"v1" 
	);

	/**
	 * a könyv forrásai: v51) kéziratok, v52) nyomtatványok
	 */
	public static final List<String> bookReferenceFields = Arrays.asList(
			"v51", "v52"
	);
	
	
	private static Logger logger = Logging.getLogger();
	private static String indexDir = Configuration.params.getIndexDir();
	private static Searcher searcher;
	private static Analyzer analyzer;
	
	private List<Query> queries = new ArrayList<Query>();

	public PoemSearcher() throws FileNotFoundException, IOException {
		logger.info("indexDir: " + indexDir);
		if (!(new File(indexDir)).exists()) {
			throw new FileNotFoundException("indexDir " + indexDir
					+ " is not found");
		} else {
			Directory dir = FSDirectory.getDirectory(indexDir);
			searcher = new IndexSearcher(dir);
			analyzer = new StandardAnalyzer();
		}
	}

	static public void main(String[] args) throws FileNotFoundException,
			IOException {
		PoemSearcher clq = new PoemSearcher();
		String fields[] = { "v1" };
		String values[] = { "0101" };
		String xml = clq.search(fields, values, true);
		System.out.println(xml);
	}

	public String search(String[] fields, String[] values) throws IOException {
		return search(fields, values, false);
	}

	public String search(String[] fields, String[] values, boolean needReferences)
			throws IOException {
		queries.clear();
		logger.info("=== search(" + fields[0] + ", " + values[0] + ") references?: " + needReferences);
		StringBuffer xml = new StringBuffer();
		try {
			xml.append("<repert>");
			ArrayList<Document> results = execute(fields, values);
			long start = System.currentTimeMillis();
			logger.info(DateUtil.getTime() + " - execute");
			displayResults(xml, results, needReferences);
			logger.info(DateUtil.getTime() + " - " + DateUtil.format(System.currentTimeMillis()-start) + " - dump");
			xml.append("<!-- " + DateUtil.format(System.currentTimeMillis()-start) + " -->\n");
			xml.append("</repert>\n");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return xml.toString();
	}

	public String searchByQuery(String query, boolean needReferences) throws IOException {
		queries.clear();
		logger.info("=== search(" + query + ")");
		StringBuffer xml = new StringBuffer();
		try {
			xml.append("<repert>");
			ArrayList<Document> results = execute(query);
			long start = System.currentTimeMillis();
			logger.info(DateUtil.getTime() + " - execute");
			displayResults(xml, results, needReferences);
			logger.info(DateUtil.getTime() + " - " + DateUtil.format(System.currentTimeMillis()-start) + " - dump");
			xml.append("<!-- " + DateUtil.format(System.currentTimeMillis()-start) + " -->\n");
			xml.append("</repert>\n");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return xml.toString();
		
	}

	public Map<String, Object> searchByQuery(Query query, boolean needReferences, 
			int limit, int offset) throws IOException {
		return searchByQuery(query, needReferences, limit, offset, null);
	}

	public Map<String, Object> searchByQuery(Query query, boolean needReferences, 
			int limit, int offset, Sort sort) throws IOException {
		queries.clear();
		logger.info("=== search(" + query + ") limit: " + limit + ", offset: " + offset);
		System.out.println("=== search(" + query + ") limit: " + limit + ", offset: " + offset);
		Map<String, Object> results = new HashMap<String, Object>();
		try {
			ArrayList<Document> rawResults = makeResults(query, sort);
			results.put("totalResults", rawResults.size());
			long start = System.currentTimeMillis();
			logger.info(DateUtil.getTime() + " - execute");
			System.out.println(DateUtil.getTime() + " - execute");
			List<Item> xmls = collectResults(rawResults, needReferences, limit, offset);
			results.put("items", xmls);
			logger.info(xmls.size() + " hits to serve");
			System.out.println(xmls.size() + " hits to serve");
			logger.info(DateUtil.getTime() + " - " + DateUtil.format(System.currentTimeMillis()-start) 
					+ " - dump");
			System.out.println(DateUtil.getTime() + " - " + DateUtil.format(System.currentTimeMillis()-start) 
					+ " - dump");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return results;
	}

	private void displayResults(StringBuffer xml, ArrayList<Document> results, boolean needReferences) {
		ArrayList<String> referencedIDs = new ArrayList<String>();
		for (Document doc : results) {
			//Document doc = itResult.next();
			String docId = doc.get("id");
			//logger.info("doc id: " + docId);
			xml.append("<!-- orig -->\n");
			xml.append(doc.get("record"));
			if (needReferences) {
				ArrayList<Document> referenceDocs = getReferenceQueries(results);
				if (referenceDocs.size() > 0) {
					for (Document reference : referenceDocs) {
						//reference = (Document) itRefs.next();
						String refId = reference.get("id");
						logger.info("ref id: " + refId);
						if(!refId.equals(docId)) {
							if(!referencedIDs.contains(refId)) {
								xml.append("\n")
									.append("<!-- referenced -->\n")
									.append(reference.get("record"));
								referencedIDs.add(refId);
							}
						}
					}
				} else {
					logger.info("There is no references");
				}
			}
		}
	}

	private List<Item> collectResults(ArrayList<Document> results, boolean needReferences, 
			int limit, int offset) {
		List<Item> items = new ArrayList<Item>();
		ArrayList<String> referencedIDs = new ArrayList<String>();
		int i = 0;
		for (Document doc : results) {
			i++;
			if(i < offset) {
				//logger.info("less than offset");
				continue;
			} else if(i >= (offset+limit)) {
				//logger.info("greater/equal than offset+limit");
				break;
			}
			StringBuffer xml = new StringBuffer();
			//Document doc = itResult.next();
			String docId = doc.get("id");
			//logger.info("doc id: " + docId);
			xml.append("<!-- orig -->\n");
			xml.append(doc.get("record"));
			if (needReferences) {
				ArrayList<Document> referenceDocs = getReferenceQueries(results);
				if (referenceDocs.size() > 0) {
					for (Document reference : referenceDocs) {
						//reference = (Document) itRefs.next();
						String refId = reference.get("id");
						logger.info("ref id: " + refId);
						if(!refId.equals(docId)) {
							if(!referencedIDs.contains(refId)) {
								xml.append("\n")
									.append("<!-- referenced -->\n")
									.append(reference.get("record"));
								referencedIDs.add(refId);
							}
						}
					}
				} else {
					logger.info("There is no references");
				}
			}
			items.add(new Item(docId, "", xml.toString(), doc.get("v91"), 
					doc.get("v200"), doc.get("v201")));
		} // end of results cycle
		return items;
	}

	private ArrayList<Document> execute(String[] fields, String[] values)
			throws ParseException, IOException {
		Query query = makeQuery(fields, values);
		return makeResults(query, null);
	}

	private ArrayList<Document> execute(String luceneQuery) throws ParseException, IOException {
		Query query = makeQuery(luceneQuery);
		return makeResults(query, null);
	}
	
	private Query makeQuery(String[] fields, String[] values) throws ParseException {
		BooleanQuery bq = new BooleanQuery();
		for (int i = 0; i < fields.length; i++) {
			QueryParser p = new QueryParser(fields[i], analyzer);
			Query q = p.parse(values[i]);
			bq.add(q, BooleanClause.Occur.MUST);
		}
		return bq;
	}

	private Query makeQuery(String luceneQuery) throws ParseException {
		QueryParser p = new QueryParser("v1", analyzer);
		p.setDefaultOperator(Operator.AND);
		return p.parse(luceneQuery);
	}

	private ArrayList<Document> makeResults(Query query, Sort sort) throws IOException {
		ArrayList<Document> result = new ArrayList<Document>();
		if(queries.contains(query)) {
			return result;
		} else {
			queries.add(query);
		}
		
		Hits hits;
		if(sort != null) {
			hits = searcher.search(query, sort);
		} else {
			hits = searcher.search(query);
		}
		logger.info("query = " + query.toString() + " -> " + hits.length() + " hits");
		FieldSelector fieldSelector = new SearchPoemFieldSelector();
		if (hits.length() > 0) {
			for (int i = 0; i < hits.length(); i++)
				result.add(searcher.doc(hits.id(i), fieldSelector)); //hits.doc(i));
		}
		return result;
	}

	private ArrayList<Document> getReferenceQueries(ArrayList<Document> result) {
		ArrayList<Document> results = new ArrayList<Document>();
		HashMap<String, String> uniqueIds = new HashMap<String, String>();

		for (Document d : result) {
			String id = d.get("id");
			try {
				
				/*
				 * v61 - a vers nótajelzései
				 * v65 - a verset nótajelzésként használó versek
				 * v161 - rész-egész viszony két vers között
				 * v162 - azonos forrásból készített átdolgozások, fordítások
				 * v165 - mellékadatlapok
				 */
				for (String field : referenceFields) {
					if(field.equals("v61"))
						field += "_s1";
					
					logger.info("querying referenceField: " + field 
							+ " " + d.getValues(field));
					if (d.get(field) != null) {
						String values[] = d.getValues(field);
						for (int i = 0; i < values.length; i++) {
							String v1 = values[i];
							if(v1.equals(id))
								continue;
							if (!uniqueIds.containsKey(v1)) {
								String fields[] = { "v1" };
								String searchValues[] = { v1 };
								results.addAll(execute(fields, searchValues));
								uniqueIds.put(v1, "t");
							}
						}
					} else {
						//logger.info(field + " is null");
					}
				}

				// ugyanennek a versnek a különféle változatai (v1)
				for (String field : versionFields) {
					if (d.get(field) != null) {
						String values[] = d.getValues(field);
						logger.info("querying versionField: " + field);
						for (int i = 0; i < values.length; i++) {
							String v1 = values[i];
							String fields[] = { "v201", "v91" };
							String searchValues[] = { v1, "5" };
							results.addAll(execute(fields, searchValues));
							uniqueIds.put(v1, "t");
						}
					}
				}

				// a könyv forrásai: v51) kéziratok, v52) nyomtatványok
				for (String field : bookReferenceFields) {
					if (d.get(field) != null) {
						
						String values[] = d.getValues(field);
						logger.info("querying bookReferenceField: " + field  + " length: " + values.length);
						for (int i = 0; i < values.length; i++) {
							String fieldName = (new StringBuilder(field))
												.append("_bookId_")
												.append(i).toString();
							logger.info("book field: " + fieldName);
							String bookId = d.get(fieldName);
							logger.info("bookId: " + bookId);
							if (!uniqueIds.containsKey(bookId)) {
								String fields[] = { "id" };
								String searchValues[] = { bookId };
								ArrayList<Document> books = 
									execute(fields, searchValues);
								results.addAll(books);
								uniqueIds.put(bookId, "t");
							}
						}
					}
				}

			} catch (IOException e) {
				e.printStackTrace();
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		return results;
	}
}
