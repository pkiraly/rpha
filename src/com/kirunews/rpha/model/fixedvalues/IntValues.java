package com.kirunews.rpha.model.fixedvalues;

import java.util.Map;
import java.util.TreeMap;

/**
 * v41 - INT - teljes-e?
 * @author Király Péter
 */
public class IntValues {

	private static Map<String, String> values = new TreeMap<String, String>();

	static {
		values.put("1", "A vers szövege teljes");
		values.put("2", "töredék - töredék terjedelme");
		values.put("3", "töredék - a vers terjedelme");
		values.put("4", "bizonytalan");
	}

	public static Map<String, String> getAll() {
		return values;
	}

}
