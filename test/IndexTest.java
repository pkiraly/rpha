import java.io.IOException;

import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.index.IndexReader;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.index.Term;
import org.apache.lucene.index.TermEnum;

import junit.framework.TestCase;


public class IndexTest extends TestCase {
	
	private String dir = "e:/web_projects/rpha/index";

	public void xtestReaderDel() throws IOException {
		String poem = "0001";
		String bookId = "MKEVB1"; //-0031";
		// writer = new IndexWriter(dir, new StandardAnalyzer(), false);
		IndexReader reader = IndexReader.open(dir);
		int before = reader.numDocs();
		System.out.println("before delete: " + before);
		Term term;
		Term[] terms = new Term[1];
		term = new Term("v91", "5");
		System.out.println(term.field()+":"+term.text() 
				+ ", " + reader.termDocs(term).doc());

		term = new Term("id", poem + "-" + bookId.toLowerCase());
		System.out.println(term.field()+":"+term.text() 
				+ ", " + reader.termDocs(term).doc());

		term = new Term("v201", poem.toLowerCase());
		System.out.println(term.field()+":"+term.text() 
				+ ", " + reader.termDocs(term).doc());

		term = new Term("v200", bookId.toLowerCase());
		System.out.println(term.field()+":"+term.text() 
				+ ", " + reader.termDocs(term).doc());

		term = new Term("v3", "beteg");
		System.out.println(term.field()+":"+term.text() 
				+ ", " + reader.termPositions(term).doc());
		
		TermEnum termEnum = reader.terms();
		System.out.println(termEnum.docFreq());
		
		// int after = reader.numDocs();
		// writer.
//		 System.out.println("deletedDocs: " + (before-after));
//		 System.out.println("after delete: " + after);
		reader.close();
		// return (before-after);
	}
	
	public void testReadDel() throws IOException {
		String id = "id0001MKEVB10033";
		IndexReader r = IndexReader.open(dir);
		int len = r.numDocs();
		for(int i=2600; i<len; i++){
			System.out.println(r.document(i).get("id"));
			if(r.document(i).get("id").startsWith("id0001")){
				r.deleteDocument(i);
			}
		}
		System.out.println(r.numDocs());
		r.close();
	}
	
	public static void main(String[] args){
		String dir = "/var/anacleto/rpha/index";
		try {
			IndexReader r = IndexReader.open(dir);
			int len = r.numDocs();
			for(int i=2600; i<len; i++){
				System.out.println(r.document(i).get("id"));
				if(r.document(i).get("id").startsWith("id0001")){
					r.deleteDocument(i);
				}
			}
			System.out.println(r.numDocs());
			r.close();
		} catch(IOException e){
			e.printStackTrace();
		}
	}

	public void xtestWriterDel() throws IOException {
		String poem = "0001";
		String bookId = "MKEVB1-0031";
		String id = "id0001MKEVB10033";
		IndexWriter writer = new IndexWriter(dir, new StandardAnalyzer(), false);

		int before = writer.docCount();
		System.out.println("before delete: " + before);
		/*
		Term[] terms = new Term[3];
		terms[0] = new Term("v91", "5");
		terms[1] = new Term("v200", bookId);
		terms[2] = new Term("v201", poem);
		writer.deleteDocuments(terms);
		*/
		writer.deleteDocuments(new Term("id", id));
		
		writer.flush();
		writer.optimize();
		int after = writer.docCount();
		System.out.println("deletedDocs: " + (before - after));
		writer.close();
	}
}
