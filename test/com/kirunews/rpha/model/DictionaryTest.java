package com.kirunews.rpha.model;

import junit.framework.TestCase;

public class DictionaryTest extends TestCase {
	QueryDictionary dict = new MegarepQueryDictionary();

	public void testGetRpha() {
		assertEquals("v1", dict.toRpha("meter"));
	}

	public void testGetMegarep() {
		assertEquals("meter", dict.toExternal("v1"));
	}
}
