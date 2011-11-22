package com.kirunews.rpha.util;

import java.io.IOException;
import java.io.Reader;

import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.TokenStream;
import org.apache.lucene.analysis.Tokenizer;

public final class DigitAnalyzer extends Analyzer {
	
	public TokenStream tokenStream(String fieldName, Reader reader) {
		return new DigitTokenizer(reader);
	}

	public TokenStream reusableTokenStream(String fieldName, Reader reader) 
			throws IOException 
	{
		Tokenizer tokenizer = (Tokenizer) getPreviousTokenStream();
		if (tokenizer == null) {
			tokenizer = new DigitTokenizer(reader);
			setPreviousTokenStream(tokenizer);
		} else {
			tokenizer.reset(reader);
		}
		return tokenizer;
	}
}

