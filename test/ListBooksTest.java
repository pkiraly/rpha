import java.io.IOException;

import junit.framework.TestCase;

import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.index.IndexReader;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.queryParser.ParseException;
import org.apache.lucene.queryParser.QueryParser;
import org.apache.lucene.search.Hits;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.Sort;

import com.kirunews.rpha.util.Configuration;
import com.kirunews.rpha.util.ConfigurationException;

public class ListBooksTest extends TestCase {
	
	public void testListBooks(){
		String dir = "e:/web_projects/rpha/index";
		StringBuffer sb = new StringBuffer("");

		try {
			Configuration.init("e:/web_projects/rpha/tomcat/common/classes/rpha.properties");
			IndexSearcher r = new IndexSearcher(dir);
			
			QueryParser p = new QueryParser("v91", new StandardAnalyzer());
			Query q = p.parse("9");
			Hits hits = r.search(q, new Sort("id"));

			int len = hits.length();
			System.out.println("len: " + len);
			for(int i=0; i<len; i++){
				Document doc = hits.doc(i);
				System.out.print("i: " + i);
				System.out.println(", id: " + doc.get("id") + ", " + doc.get("v91"));
				sb.append(doc.get("record"));

			}
			r.close();

		} catch(ConfigurationException e){
			e.printStackTrace();
		} catch(IOException e){
			e.printStackTrace();
		} catch(ParseException e){
			e.printStackTrace();
		}
		System.out.println(sb.length());
	}

}
