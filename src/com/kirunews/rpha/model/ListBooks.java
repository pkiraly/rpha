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
import org.apache.lucene.index.Term;
import org.apache.lucene.queryParser.ParseException;
import org.apache.lucene.queryParser.QueryParser;
import org.apache.lucene.search.BooleanClause;
import org.apache.lucene.search.BooleanQuery;
import org.apache.lucene.search.Hits;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.Searcher;
import org.apache.lucene.search.Sort;
import org.apache.lucene.search.TermQuery;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;

import com.kirunews.rpha.util.Configuration;
import com.kirunews.rpha.util.DateUtil;
import com.kirunews.rpha.util.Logging;
import com.kirunews.rpha.util.XsltTransformator;
import java.lang.String;

public class ListBooks {

	private static String xsltDir = Configuration.params.getConfigDir() + "/xslt/";
	private static String indexDir = Configuration.params.getIndexDir(); 
	private static Searcher searcher;
	private static Analyzer analyzer;
	private static Logger logger = Logging.getLogger();
	public Directory dir;

	public ListBooks() throws FileNotFoundException, IOException {
		dir = FSDirectory.getDirectory(indexDir);
		searcher = new IndexSearcher(dir);
		analyzer = new StandardAnalyzer();
	}
	
	public String simpleList() {
		long start = System.currentTimeMillis();
		StringBuffer sb = new StringBuffer("");
		XsltTransformator t = new XsltTransformator();
		String xsltFile = xsltDir + "listBooks.xsl";
		String html = "";
		try {
			IndexSearcher r = new IndexSearcher(dir);
			
			QueryParser p = new QueryParser("v91", new StandardAnalyzer());
			Query q = p.parse("9");
			Hits hits = r.search(q, new Sort("id"));
			//String xsltFile = xsltDir + "listBookEntry.xsl";

			int len = hits.length();
			sb.append("<repert>");
			for(int i=0; i<len; i++){
				//String xml = hits.doc(i).get("record");
				//String html = t.transform(xml, xsltFile);
				// sb.append(html);
				sb.append(hits.doc(i).get("record"));
			}
			r.close();
			sb.append("</repert>");
			html = t.transform(sb.toString(), xsltFile); 

		} catch(TransformerConfigurationException e){
			e.printStackTrace();
		} catch(TransformerException e) {
			e.printStackTrace();
		} catch(IOException e){
			e.printStackTrace();
		} catch(ParseException e){
			e.printStackTrace();
		}
		long end = System.currentTimeMillis();
		return html;
		//String html = xml, xsltFile);
	}

	public String typeList(String type) {
		StringBuffer sb = new StringBuffer("");
		XsltTransformator t = new XsltTransformator();
		String xsltFile = xsltDir + "listBooksByType.xsl";
		String html = "";
		try {
			IndexSearcher r = new IndexSearcher(dir);
			
			TermQuery qBooks = new TermQuery(new Term("v91","9"));
			TermQuery qType = new TermQuery(new Term("v101",type.toLowerCase()));
			
			BooleanQuery q = new BooleanQuery();
			q.add(qBooks, BooleanClause.Occur.MUST);
			q.add(qType, BooleanClause.Occur.MUST);
			Hits hits = r.search(q, new Sort("id"));

			int len = hits.length();
			sb.append("<repert>");
			for(int i=0; i<len; i++){
				sb.append(hits.doc(i).get("record"));
			}
			r.close();
			sb.append("</repert>");
			html = t.transform(sb.toString(), xsltFile); 

		} catch(TransformerConfigurationException e){
			e.printStackTrace();
		} catch(TransformerException e) {
			e.printStackTrace();
		} catch(IOException e){
			e.printStackTrace();
		}
		return html;
	}

	private ArrayList<Document> execute(String field, String value)
		throws ParseException, IOException {
		ArrayList<Document> result = new ArrayList<Document>();
		QueryParser p = new QueryParser(field, analyzer);
		Query q = p.parse(value);
		Hits hits = searcher.search(q);
		logger.info(q.toString() + " -> " + hits.length());
	
		if(hits.length() > 0) {
			for(int i=0; i<hits.length(); i++)
				result.add(hits.doc(i));
		}
		return result;
	}

	private ArrayList<Document> execute(String[] fields, String[] values) 
	throws ParseException, IOException {
        ArrayList<Document> result = new ArrayList<Document>();
        BooleanQuery bq = new BooleanQuery();
        for(int i = 0; i < fields.length; i++)
        {
            QueryParser p = new QueryParser(fields[i], analyzer);
            Query q = p.parse(values[i]);
            bq.add(q, BooleanClause.Occur.MUST);
        }

        Hits hits = searcher.search(bq);
        logger.info(bq.toString() + " -> " + hits.length());
        if(hits.length() > 0)
        {
            for(int i = 0; i < hits.length(); i++)
                result.add(hits.doc(i));
        }
        return result;
	}

	private ArrayList<Document> getPoems(ArrayList<Document> result) {
        ArrayList<Document> results = new ArrayList<Document>();
        for(Iterator<Document> it = result.iterator(); it.hasNext();)
        {
            Document d = it.next();
            try {
                String fieldName = d.getField("v101").stringValue()
                					.startsWith("MKEVB") 
                				? "v52_bookId" 
                				: "v51_bookId";
                results.addAll(execute(fieldName, d.getField("id").stringValue()));
            } catch(IOException e) {
                e.printStackTrace();
            } catch(ParseException e) {
                e.printStackTrace();
            }
        }

        return results;
	}

	private String transform(String xmlSource, String xsltFileName, String bookId) 
		throws FileNotFoundException, TransformerConfigurationException, 
		TransformerException 
	{
		HashMap<String, String> params = new HashMap<String, String>();
		params.put("bookId", bookId);
		XsltTransformator t = new XsltTransformator();
		t.setParams(params);
		String output = t.transform(xmlSource, xsltFileName);
		return output;
	}

	public String search(String[] fields, String[] values, boolean getReferences) 
	throws IOException {
        StringBuffer xml = new StringBuffer();
        try {
            xml.append("<repert>");
            ArrayList<Document> result = execute(fields, values);
            logger.info(DateUtil.getTime() + " - execute");
            for(Iterator itResult = result.iterator(); itResult.hasNext();)
            {
                xml.append(((Document)itResult.next()).get("record"));
                if(getReferences) {
                    ArrayList referenceDocs = getPoems(result);
                    if(referenceDocs.size() > 0) {
                        String rec;
                        Iterator itRefs = referenceDocs.iterator();
                        while(itRefs.hasNext()) {
                            Document d = (Document)itRefs.next();
                            rec = d.get("record");
                            rec = transform(rec, xsltDir + "poemFilter.xsl", 
                            		values[0]);
                            xml.append("\n").append(rec);
                        }
                    }
                }
            }

            logger.info(DateUtil.getTime() + " - dump");
            xml.append("</repert>\n");
        } catch(Exception e) {
            e.printStackTrace();
        }
        return xml.toString();
	}
}
