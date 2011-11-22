package com.kirunews.rpha.model.fixedvalues;

import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;

/**
 * v43 - PRE - terjedelem mértékegysége
 * @author Király Péter
 */
public class PreValues {

	private static Map<String, String> values = new HashMap<String, String>();

	static {
		values.put("1", "versszak");
		values.put("2", "sor");
		values.put("3", "bekezdés");
	}

	public static Map<String, String> getAll() {
		return values;
	}

}
