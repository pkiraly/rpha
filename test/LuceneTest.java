import junit.framework.TestCase;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import org.apache.lucene.analysis.*;
import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.document.*;
import org.apache.lucene.index.*;
import org.apache.lucene.search.*;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;
import org.apache.lucene.queryParser.*;
import java.net.URLEncoder;

public class LuceneTest extends TestCase {

	protected String[] keywords = {"1", "2"};
	protected String[] unindexed = {"Netherlands", "Italy"};
	protected String[] unstored = {
		"Amsterdam has lots of bridges",
		"Venice has lots of canals"};
	protected String[] text = {"Amsterdam", "Venice"};
	protected String[] cities = {"Paris", "London"};
	
	private Directory dir;
	private IndexWriter writer;

	protected void setUp() throws IOException {
		String indexDir = System.getProperty("java.io.tmpdir", "tmp")
				+ System.getProperty("file.separator") + "index-dir";
		dir = FSDirectory.getDirectory(indexDir);
		writer = new IndexWriter(dir, new StandardAnalyzer(), true);
		writer.setMergeFactor(1000);
		addDocuments(dir);
	}
	
	public void testSearch() throws IOException {
		IndexReader reader = IndexReader.open(dir);
		FieldSelector fieldSelector = new FieldSelector(){
				public FieldSelectorResult accept(String fieldName){
					if(fieldName.equals("id") || fieldName.equals("city")){
						return FieldSelectorResult.LOAD;
					} else {
						return FieldSelectorResult.NO_LOAD;
					}
				};
		};
		Document[] docs = new Document[2];
		for(int i=0, len=reader.numDocs(); i<len; i++) {
			Document newdoc = reader.document(i); //, fieldSelector);
			newdoc.removeField("city");
			newdoc.add(new Field("city", cities[i], Field.Store.YES, Field.Index.TOKENIZED));
			System.out.println(newdoc.get("city"));
			docs[i] = newdoc;
			reader.deleteDocument(i);
		}
		reader.close();
		writer = new IndexWriter(dir, getAnalyzer(), false);
		for(Document doc : docs) {
			writer.addDocument(doc);
		}
		writer.optimize();
		writer.close();
		reader = IndexReader.open(dir);
		assertEquals(2, reader.maxDoc());
		assertEquals(2, reader.numDocs());
		System.out.println(reader.document(0));
		assertEquals(2, reader.maxDoc());
		assertEquals(2, reader.numDocs());
	}
	
	public void xtestDeleteBeforeIndexMerge() throws IOException {
		IndexReader reader = IndexReader.open(dir);
		assertEquals(2, reader.maxDoc());
		assertEquals(2, reader.numDocs());
		reader.deleteDocument(1);
		assertTrue(reader.isDeleted(1));
		assertTrue(reader.hasDeletions());
		assertEquals(2, reader.maxDoc());
		assertEquals(1, reader.numDocs());
		reader.close();
		reader = IndexReader.open(dir);
		assertEquals(2, reader.maxDoc());
		assertEquals(1, reader.numDocs());
		reader.close();
	}

	protected void addDocuments(Directory dir) throws IOException {
		IndexWriter writer = new IndexWriter(dir, getAnalyzer(), true);
		writer.setUseCompoundFile(isCompound());
		for (int i = 0; i < keywords.length; i++) {
			Document doc = new Document();
			doc.add(new Field("id", keywords[i], Field.Store.YES, Field.Index.UN_TOKENIZED));
			doc.add(new Field("country", unindexed[i], Field.Store.YES, Field.Index.NO));
			doc.add(new Field("contents", unstored[i], Field.Store.NO, Field.Index.TOKENIZED));
			doc.add(new Field("city", text[i], Field.Store.YES, Field.Index.TOKENIZED));
			writer.addDocument(doc);
		}
		writer.optimize();
		writer.close();
	}

	protected Analyzer getAnalyzer() {
		return new SimpleAnalyzer();
	}
	
	protected boolean isCompound() {
		return true;
	}

	public String escapeHTML(String s) {
		s = s.replaceAll("&", "&amp;");
		s = s.replaceAll("<", "&lt;");
		s = s.replaceAll(">", "&gt;");
		s = s.replaceAll("\"", "&quot;");
		s = s.replaceAll("'", "&apos;");
		return s;
	}

	public void a() {

		boolean error = false;
		String indexName = "E:/web_projects/repert/lucene-index";
		IndexSearcher searcher = null;
		Query query = null;
		Hits hits = null;
		int startindex = 0;
		int maxpage = 50;
		String queryString = null;
		String startVal = null;
		String maxresults = null;
		int thispage = 0;

		try {
			searcher = new IndexSearcher(indexName);
			queryString = "id:0001";
			startVal = "0";
			maxresults = "10";
			maxpage = Integer.parseInt(maxresults);
			startindex = Integer.parseInt(startVal);
			if (queryString == null)
				System.out.println("no query specified");
			Analyzer analyzer = new StopAnalyzer();
			QueryParser parser = new QueryParser("contents", analyzer);
			query = parser.parse(queryString);
			if (error == false && searcher != null) {
				thispage = maxpage;
				hits = searcher.search(query);
				if (hits.length() == 0) {
					System.out
							.println("I'm sorry I couldn't find what you were looking for.");
					error = true;
				}
				if ((startindex + maxpage) > hits.length()) {
					thispage = hits.length() - startindex;
				}
				for (int i = startindex; i < (thispage + startindex); i++) {
					Document doc = hits.doc(i);
					String doctitle = doc.get("title");
					String url = doc.get("url");
					if ((doctitle == null) || doctitle.equals(""))
						doctitle = url;
				}
				if ((startindex + maxpage) < hits.length()) {
					String moreurl = "results.jsp?query="
							+ URLEncoder.encode(queryString)
							+ "&amp;maxresults=" + maxpage + "&amp;startat="
							+ (startindex + maxpage);
				}
				if (searcher != null)
					searcher.close();
			}
		} catch (ParseException e) {
			error = true;
		} catch (Exception e) {
			error = true;
		}
	}
}
