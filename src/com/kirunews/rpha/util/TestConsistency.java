package com.kirunews.rpha.util;

import java.io.IOException;

import org.apache.lucene.index.IndexReader;
import org.apache.lucene.index.Term;
import org.apache.lucene.search.Hits;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.TermQuery;

public class TestConsistency {
	public static void main(String[] args) {
		if(args.length != 1){
			System.out.println("Usage: java TestConsistency <applBasePath>");
			return;
		}

		String applBasePath = args[0];
		
		try {
			Configuration.init(applBasePath 
					+ "/tomcat/common/classes/rpha.properties");
			IndexReader reader = IndexReader.open(Configuration.params.getIndexDir());
			IndexSearcher searcher = new IndexSearcher(Configuration.params.getIndexDir());
			
			String id;
			Hits hits;
			int errorCounter = 0;
			for(int i=0, len=reader.numDocs(); i<len; i++){
				id = reader.document(i).get("id");
				hits = searcher.search(new TermQuery(new Term("id", id.toLowerCase())));
				if(hits.length() != 1) {
					System.out.println("inconsistency with id: " 
							+ id + " (" + hits.length() + ")");
					errorCounter++;
				}
			}
			searcher.close();
			reader.close();
			
			if(errorCounter == 0)
				System.out.println("Congratulation! The index is consistent.");
			else 
				System.out.println("WARNING! The index has " + errorCounter + " errors");


		} catch(ConfigurationException e) {
			System.out.println(e.getMessage());
		} catch(IOException e) {
			System.out.println(e.getMessage());
		}

	}
}
