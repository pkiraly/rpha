package com.kirunews.rpha.util;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.index.IndexReader;
import org.apache.lucene.index.IndexWriter;

public class ConvertV61 {

	public static void main(String[] args) throws IOException {
		if(args.length != 1){
			System.out.println("Usage: java ConvertV61 <index>");
			return;
		}
		IndexReader reader = null;
		try {
			String dir = args[0];
			if(!(new File(dir)).exists()) {
				System.out.println("No index dir exists in " + dir);
			}
			System.out.println("Transforming index in " + dir);

			reader = IndexReader.open(dir);
			List<Document> docs = new ArrayList<Document>();
			int counter = 0;
			for(int i=0, l=reader.numDocs(); i<l; i++) {
				Document doc = reader.document(i);
				Field v61;
				if((v61 = doc.getField("v61")) != null){
					counter++;
					reader.deleteDocument(i);
					String record = doc.getField("record")
										.stringValue()
										.replaceAll("<v61 value=", "<v61 s1=");
					doc.removeField("v61");
					doc.removeField("record");
					doc.add(new Field("v61_s1", v61.stringValue(), 
							Field.Store.YES, Field.Index.TOKENIZED));
					doc.add(new Field("record", record, 
							Field.Store.YES, Field.Index.UN_TOKENIZED));
					docs.add(doc);
				}
			}
        	reader.close();
        	IndexWriter writer = new IndexWriter(args[0], new StandardAnalyzer());
        	for(Document doc : docs) {
        		writer.addDocument(doc);
        	}
        	writer.optimize();
        	writer.close();
			System.out.println("Transforming " + counter + " documents.");

		} catch (FileNotFoundException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
	}
}
