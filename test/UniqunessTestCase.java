import java.io.IOException;

import org.apache.lucene.index.IndexReader;
import org.apache.lucene.index.Term;
import org.apache.lucene.search.Hits;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.Searcher;
import org.apache.lucene.search.TermQuery;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;

import junit.framework.TestCase;


public class UniqunessTestCase extends TestCase {

	private static String baseDir = "E:/web_projects/rpha/";
	private static String indexDir		= baseDir + "index";
	private static Searcher searcher;
	private static IndexReader reader;

	protected void setUp() throws Exception {
		Directory dir = FSDirectory.getDirectory(indexDir);
		searcher = new IndexSearcher(dir);
		reader = IndexReader.open(dir);
	}
	
	public void testUniquness() throws IOException {
		int numDocs = reader.numDocs();
		for(int i=0; i<numDocs; i++) {
			String id = reader.document(i).get("id");
			Query query = new TermQuery(new Term("id", id.toLowerCase()));
			Hits hits = searcher.search(query);
			if(hits.length() != 1) {
				System.out.println(id);
			}
		}
	}
}
