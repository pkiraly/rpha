/**
 * 
 */
package com.kirunews.rpha.model;

import junit.framework.TestCase;

import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.queryParser.ParseException;
import org.apache.lucene.queryParser.QueryParser;
import org.apache.lucene.queryParser.QueryParser.Operator;
import org.apache.lucene.search.Hits;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.Query;

/**
 * @author kiru
 *
 */
public class QueryTranslatorTest extends TestCase {

	private static final String INDEXDIR = "E:/web_projects/rpha/index";
	QueryParser parser;
	/**
	 * @param name
	 */
	public QueryTranslatorTest(String name) {
		super(name);
		parser = new QueryParser("v1", new StandardAnalyzer());
		parser.setDefaultOperator(Operator.AND);
	}

	/* (non-Javadoc)
	 * @see junit.framework.TestCase#setUp()
	 */
	protected void setUp() throws Exception {
		super.setUp();
	}

	/* (non-Javadoc)
	 * @see junit.framework.TestCase#tearDown()
	 */
	protected void tearDown() throws Exception {
		super.tearDown();
	}

	/**
	 * Test method for {@link com.kirunews.rpha.model.RPHAQueryTranslator#MegarepQueryTranslator(org.apache.lucene.search.Query)}.
	 */
	public void xtestMegarepQueryTranslator() {
		try {
			Query origQuery = parser.parse("meter:01");
			RPHAQueryTranslator translator = new RPHAQueryTranslator(new MegarepQueryDictionary());
			assertNotNull(translator);
		} catch (ParseException e) {
			e.printStackTrace();
		}
	}

	/**
	 * Test method for {@link com.kirunews.rpha.model.RPHAQueryTranslator#translateQuery()}.
	 */
	public void testTranslateQuery() {
		String[] queries = {
			/*
			"meter:01", "v44:8",             // TermQuery
			"meter:\"01\"", "v44:\"8\"",     // TermQuery
			"meter:01~0.5", "v44:8~0.5",     // FuzzyQuery
			"meter:[a TO z]", "v44:[a TO z]", // ConstantScoreRangeQuery
			"meter:{a TO z}", "v44:{a TO z}", // ConstantScoreRangeQuery
			"meter:[1 TO 9]", "v44:[1 TO 9]", // ConstantScoreRangeQuery
			"meter:{1 TO 9}", "v44:{1 TO 9}", // ConstantScoreRangeQuery
			"meter:[1 TO 9] meter_qualifier:01", "+v44:[1 TO 9]", // ConstantScoreRangeQuery
			"meter:az*", "v44:az*",           // PrefixQuery
			"meter:\"qqq kkk\"", "v44:\"qqq kkk\"", // PhraseQuery
			"meter:\"qqq kkk\"~3", "v44:\"qqq kkk\"~3", // PhraseQuery with slop
			"meter:\"Microsoft app*\"", "v44:\"Microsoft app*\"",

			// test boosting
			"meter:01^3", "v44:8^3",             // TermQuery
			"meter:\"qqq kkk\"^3", "v44:\"qqq kkk\"^3", // PhraseQuery
			"meter:01~0.5^3", "v44:8~0.5^3",     // FurryQuery
			"meter:[a TO z]^3", "v44:[a TO z]^3", // ConstantScoreRangeQuery
			
			// test boolean operators
			"meter:01^3 NOT melody:01", "v44:8^3 NOT v23:2", // TermQuery
			"meter:01^3 AND melody:01", "v44:8^3 AND v23:2", // TermQuery
			"meter:01^3 OR melody:01", "v44:8^3 OR v23:2", // TermQuery
			
			// test value-translation
			"melody:01", "v23:2",
			"melody:01 melody_qualifier:01", "+v23:2",
			"melody_qualifier:01", null, // nincs megfeleltetés
			"language:de", "v18:ger",
			"number_of_lines:8", "+v42:8 +v43:2",
			"number_of_strophes:8", "+v42:8 +v43:1",
			"language:de number_of_strophes:8", "v18:ger (v42:8 v43:1)",
			"meter:01-01-01", "v44:6",
			*/
			
			// test alternatives
			"author:gábor", "v5_s1:gábor OR v5_s2:gábor",
			"author:gábor*", "v5_s1:gábor* OR v5_s2:gábor*",
			"author:(nagy gábor)", "(v5_s1:nagy OR v5_s2:nagy) AND (v5_s1:gábor OR v5_s2:gábor)",
			"author:\"nagy gábor\"", "v5_s1:\"nagy gábor\" OR v5_s2:\"nagy gábor\"",
		};
		
		RPHAQueryTranslator translator = new RPHAQueryTranslator(new MegarepQueryDictionary());
		for(int i=0; i<queries.length; i+=2) {
			try {
				Query origQuery = parser.parse(queries[i]);
				Query expected  = (queries[i+1] != null) ? parser.parse(queries[i+1]) : null;
				Query tQuery = translator.translateQuery(origQuery);
				System.out.println(origQuery + " -> " + tQuery);
				//assertNotNull(tQuery);
				assertEquals(expected, tQuery);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
	}
	
	public void xtestTestSearch() throws Exception {
		IndexSearcher searcher = new IndexSearcher(INDEXDIR);
		String[] queries = {
			"meter:01-01-01",
			"language:de",
			"melody:01", 
			"number_of_lines:8", 
			"number_of_strophes:8", 
		};
		RPHAQueryTranslator translator = new RPHAQueryTranslator(new MegarepQueryDictionary());
		for(String q : queries) {
			Query phaQuery = translator.translateQuery(parser.parse(q));
			Hits hits = searcher.search(phaQuery);
			System.out.println(translator.getQuery() + " (" + phaQuery + ") produced " 
					+ hits.length() + " hits");
		}
	}
}
