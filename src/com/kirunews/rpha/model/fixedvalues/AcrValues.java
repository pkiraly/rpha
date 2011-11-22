package com.kirunews.rpha.model.fixedvalues;

import java.util.Map;
import java.util.TreeMap;

/**
 * v33 - ACR - akrosztichon?
 * @author Király Péter
 */
public class AcrValues {

	private static Map<String, String> values = new TreeMap<String, String>();

	static {
		values.put("1", "A versnek van akrosztichonja");
		values.put("2", "A versnek nincs akrosztichonja");
		values.put("3", "Nem tudjuk");
	}

	public static Map<String, String> getAll() {
		return values;
	}

}
