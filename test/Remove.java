import java.io.IOException;

import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.index.IndexReader;
import org.apache.lucene.index.IndexWriter;

public class Remove {
	
	public static void main(String[] args){
		String dir = "/var/anacleto/rpha/index";
		
		try {
			IndexWriter writer = new IndexWriter(dir, new StandardAnalyzer(), false);
			writer.optimize();
			writer.close();

			IndexReader r = IndexReader.open(dir);
			int len = r.numDocs();
			System.out.println("len: " + len);
			for(int i=2600; i<len; i++){
				System.out.println("i: " + i);
				if(r.document(i) != null){
					System.out.println("id: " + r.document(i).get("id") + ", " + r.document(i).get("v91"));
					System.out.println("xml: " + r.document(i).get("record"));
					if(r.document(i).get("id") == null){
						// r.deleteDocument(i);
					}
					else if(r.document(i).get("id").startsWith("id0001")){
						// r.deleteDocument(i);
					}
					else if(r.document(i).get("v91") != null && 
							r.document(i).get("v91").equals("5")){
						r.deleteDocument(i);
					}
				}
			}
			System.out.println("len: " + r.numDocs());
			r.close();

			writer = new IndexWriter(dir, new StandardAnalyzer(), false);
			writer.optimize();
			writer.close();
		} catch(IOException e){
			e.printStackTrace();
		}
	}

}
