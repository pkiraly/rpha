package com.kirunews.rpha.model.fixedvalues;

import java.util.Map;
import java.util.TreeMap;

public class Values {

	protected static Map<String, String> values = new TreeMap<String, String>();

	public static Map<String, String> getAll() {
		return values;
	}

}
