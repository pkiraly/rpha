package com.kirunews.rpha.util;

import java.io.Reader;

import org.apache.lucene.analysis.CharTokenizer;

public class DigitTokenizer extends CharTokenizer {
	public DigitTokenizer(Reader in) {
		super(in);
	}
	
	protected boolean isTokenChar(char c) {
		return Character.isDigit(c);
	}
}
