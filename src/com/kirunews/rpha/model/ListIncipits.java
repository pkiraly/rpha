package com.kirunews.rpha.model;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import org.apache.lucene.document.Document;
import org.apache.lucene.index.Term;
import org.apache.lucene.search.Hits;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.PrefixQuery;
import org.apache.lucene.search.Searcher;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;

import com.kirunews.rpha.util.Configuration;
import java.lang.String;

public class ListIncipits {
	
	private static String indexDir = Configuration.params.getIndexDir(); 
	private static Searcher searcher;
	//private static Logger logger = Logging.getLogger();
	public Directory dir;

	public ListIncipits() throws FileNotFoundException, IOException {
		dir = FSDirectory.getDirectory(indexDir);
		searcher = new IndexSearcher(dir);
	}

	public ArrayList<HashMap<String, String>> list(String prefix) {
		ArrayList<HashMap<String, String>> incipits = new ArrayList<HashMap<String, String>>();
		try {
			Term t = new Term("v2", prefix);
			PrefixQuery query = new PrefixQuery(t);
			Hits hits = searcher.search(query);
			for(int i=0, len=hits.length(); i<len; i++) {
				Document d = hits.doc(i);
				HashMap<String, String> m = new HashMap<String, String>();
				m.put(d.get("v2"), d.get("id"));
				incipits.add(m);
			}
		} catch(IOException e){
			e.printStackTrace();
		}
		
		return incipits;
	}
}
