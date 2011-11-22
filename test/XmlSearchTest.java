import java.io.IOException;

import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.index.IndexReader;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.index.Term;
import org.apache.lucene.queryParser.ParseException;
import org.apache.lucene.queryParser.QueryParser;
import org.apache.lucene.search.BooleanClause;
import org.apache.lucene.search.BooleanQuery;
import org.apache.lucene.search.Hits;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.PhraseQuery;
import org.apache.lucene.search.PrefixQuery;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.Searcher;
import org.apache.lucene.search.TermQuery;
import org.apache.lucene.search.WildcardQuery;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;

import junit.framework.TestCase;


public class XmlSearchTest extends TestCase {
	private static String baseDir = "E:/web_projects/repert/";
	private static String indexDir = baseDir + "/lucene-index";
	private static Searcher searcher;
	private static boolean showDocs = false;

	protected void setUp() throws Exception {
		Directory dir = FSDirectory.getDirectory(indexDir);
		searcher = new IndexSearcher(dir);
	}

	public void testSearch() {
		try {
			String[] queries = {
				"id", "0001", 
				"v1", "0001", 
				"v2", "beteg", "v2", "bűnök", 
				"v3", "31", "v3", "Ps", 
				"v11", "2", 
				"v12", "absoluti", 
				"v13", "31", "v13", "Ps", "v13", "Ps 31 32", 
				"v14", "AH*", "v14", "52*", 
				"v51_bookId", "RMNY-0160", 
				"id", "RMNY-0160"
			};
			Analyzer analyzer = new StandardAnalyzer();
			for(int i=0; i<queries.length; i+=2) {
				Query q;
				if(queries[i].equals("v51")) {
					showDocs = true;
					PhraseQuery pq = new PhraseQuery();
					pq.add(new Term(queries[i], queries[i+1].replace("*", "")));
					q = pq;
				} else {
					QueryParser p = new QueryParser(queries[i], analyzer);
					q = p.parse(queries[i+1]);
				}
				//Query q = new TermQuery(new Term(queries[i], queries[i+1]));
				Hits hits = searcher.search(q);
				System.out.println(q + " -> " + hits.length());
				if(hits.length() == 0) {
					System.out.println(q.toString() + " hits: " + hits.length());
				}
				if(hits.length() > 0 && showDocs) {
					Document d = hits.doc(0);
					System.out.println(d.get("record"));
				}
			}

		} catch(ParseException e) {
			e.printStackTrace();
		} catch(IOException e) {
			e.printStackTrace();
		}
	}

	public void xtestBookSearch() throws IOException {
		BooleanQuery bq = new BooleanQuery();
		TermQuery t1 = new TermQuery(new Term("v51_bookId", "RMNY-0160"));
		TermQuery t2 = new TermQuery(new Term("v51_forrasTipusKod", "28"));
		bq.add(new BooleanClause(t1, BooleanClause.Occur.MUST));
		bq.add(new BooleanClause(t2, BooleanClause.Occur.MUST));
		Hits hits = searcher.search(bq);
		System.out.println(bq + " -> " + hits.length());
	}
}
