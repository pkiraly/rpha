package com.kirunews.rpha.model;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.apache.log4j.Logger;
import org.apache.lucene.index.Term;
import org.apache.lucene.search.BooleanClause;
import org.apache.lucene.search.BooleanQuery;
import org.apache.lucene.search.ConstantScoreRangeQuery;
import org.apache.lucene.search.FuzzyQuery;
import org.apache.lucene.search.PhraseQuery;
import org.apache.lucene.search.PrefixQuery;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.TermQuery;
import org.apache.lucene.search.BooleanClause.Occur;

public class RPHAQueryTranslator {

	private Logger logger = Logger.getLogger(this.getClass());
	
	private Query query;
	private Query translatedQuery;
	private QueryDictionary dict;

	public RPHAQueryTranslator(QueryDictionary dict) {
		this.dict = dict;
	}

	public RPHAQueryTranslator(QueryDictionary dict, Query query) {
		this.dict = dict;
		this.query = query;
		translatedQuery = translateQuery(this.query);
	}
	
	public Query translateQuery() {
		return translateQuery(query);
	}

	public Query translateQuery(Query query) {
		this.query = query;
		translatedQuery = translateQuery(query, true);
		return translatedQuery;
	}
	
	private Query translateQuery(Query query, boolean isFirst) {
		try {
			if (query instanceof BooleanQuery){
				return extractBooleanQuery((BooleanQuery) query);
			} else if (query instanceof PhraseQuery){
				return extractPhraseQuery((PhraseQuery) query);
			} else if (query instanceof TermQuery){
				return extractTermQuery((TermQuery) query);
			} else if (query instanceof FuzzyQuery){
				return extractFuzzyQuery((FuzzyQuery) query);
			} else if (query instanceof ConstantScoreRangeQuery){
				return extractRangeQuery((ConstantScoreRangeQuery) query);
			} else if (query instanceof PrefixQuery){
				return extractPrefixQuery((PrefixQuery) query);
			} else {
				logger.error("Unhandled query type: " + query + " " + query.getClass());
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return query;
	}
	
	private Query extractBooleanQuery(BooleanQuery query) throws IOException {
		BooleanQuery rewritenQuery = new BooleanQuery();
		BooleanClause[] queryClauses = query.getClauses();
		for (BooleanClause currClause : queryClauses) {
			Query q = translateQuery(currClause.getQuery(), false);
			if(q != null) {
				rewritenQuery.add(
					translateQuery(currClause.getQuery(), false),
					currClause.getOccur());
			}
		}
		rewritenQuery.setBoost(query.getBoost());
		return rewritenQuery;
	}

	private Query extractTermQuery(TermQuery query) throws IOException {
		Term term = query.getTerm();
		List<String> alt = dict.toRphaAlt(term.field());
		if(dict.toRpha(term.field()) == null && alt == null) {
			return null;
		}
		Query rewritenQuery;
		Map<String, String> ext = dict.getRphaExt(term.field());
		if(ext == null) {
			if(alt == null) {
				rewritenQuery = new TermQuery(new Term(
					dict.toRpha(term.field()), 
					dict.toRphaVals(term.field(), term.text())
				));
			} else {
				BooleanQuery booleanQuery = new BooleanQuery();
				for(String fieldName : alt) {
					booleanQuery.add(new TermQuery(new Term(fieldName, 
							dict.toRphaVals(term.field(), term.text())
							)), Occur.SHOULD);
				}
				rewritenQuery = booleanQuery;
			}
		} else {
			BooleanQuery booleanQuery = new BooleanQuery();
			booleanQuery.add(new TermQuery(new Term(
					dict.toRpha(term.field()), 
					dict.toRphaVals(term.field(), term.text())
					)), Occur.MUST);
			for(Entry<String, String> entry : ext.entrySet()) {
				booleanQuery.add(new TermQuery(new Term(entry.getKey(), entry.getValue())), Occur.MUST);
			}
			rewritenQuery = booleanQuery;
		}
		rewritenQuery.setBoost(query.getBoost());
		return rewritenQuery;
	}

	private Query extractPhraseQuery(PhraseQuery query) throws IOException {
		Query rewritenQuery;
		Term[] terms = query.getTerms();
		List<String> alt = dict.toRphaAlt(terms[0].field());
		if(alt == null) {
			PhraseQuery phraseQuery = new PhraseQuery();
			for(Term term : terms) {
				phraseQuery.add(new Term(
					dict.toRpha(term.field()), 
					term.text()
				));
			}
			phraseQuery.setSlop(query.getSlop());
			phraseQuery.setBoost(query.getBoost());
			rewritenQuery = phraseQuery;
		} else {
			BooleanQuery booleanQuery = new BooleanQuery();
			for(String fieldName : alt) {
				PhraseQuery phraseQuery = new PhraseQuery();
				for(Term term : terms) {
					phraseQuery.add(new Term(fieldName, term.text()));
				}
				phraseQuery.setSlop(query.getSlop());
				phraseQuery.setBoost(query.getBoost());
				booleanQuery.add(phraseQuery, Occur.SHOULD);
			}
			rewritenQuery = booleanQuery;
		}
		return rewritenQuery;
	}

	private Query extractFuzzyQuery(FuzzyQuery query) throws IOException {
		Query rewritenQuery;
		Term term = query.getTerm();
		List<String> alt = dict.toRphaAlt(term.field());
		if(alt == null) {
			FuzzyQuery fuzzyQuery = new FuzzyQuery(
				new Term(
						dict.toRpha(term.field()), 
						dict.toRphaVals(term.field(), term.text())
				),
				query.getMinSimilarity());
			rewritenQuery = fuzzyQuery;
		} else {
			BooleanQuery booleanQuery = new BooleanQuery();
			for(String fieldName : alt) {
				FuzzyQuery fuzzyQuery = new FuzzyQuery(
					new Term(fieldName, dict.toRphaVals(term.field(), term.text())),
					query.getMinSimilarity());
				booleanQuery.add(fuzzyQuery, Occur.SHOULD);
			}
			rewritenQuery = booleanQuery;
		}
		rewritenQuery.setBoost(query.getBoost());
		return rewritenQuery;
	}

	private Query extractRangeQuery(ConstantScoreRangeQuery query) throws IOException {
		ConstantScoreRangeQuery rewritenQuery = new ConstantScoreRangeQuery(
				dict.toRpha(query.getField()),
				query.getLowerVal(),
				query.getUpperVal(),
				query.includesLower(),
				query.includesUpper()
		);
		rewritenQuery.setBoost(query.getBoost());
		return rewritenQuery;
	}

	private Query extractPrefixQuery(PrefixQuery query) throws IOException {
		Query rewritenQuery;
		List<String> alt = dict.toRphaAlt(query.getPrefix().field());
		if(alt == null) {
			PrefixQuery prefixQuery = new PrefixQuery(new Term(
				dict.toRpha(query.getPrefix().field()),
				query.getPrefix().text()
			));
			rewritenQuery = prefixQuery;
		} else {
			BooleanQuery booleanQuery = new BooleanQuery();
			for(String fieldName : alt) {
				PrefixQuery prefixQuery = new PrefixQuery(new Term(fieldName, query.getPrefix().text()));
				booleanQuery.add(prefixQuery, Occur.SHOULD);
			}
			rewritenQuery = booleanQuery;
		}
		rewritenQuery.setBoost(query.getBoost());
		return rewritenQuery;
	}

	public void setQuery(Query query) {
		this.query = query;
	}

	public Query getQuery() {
		return query;
	}

	public Query getTranslatedQuery() {
		return translatedQuery;
	}
}
