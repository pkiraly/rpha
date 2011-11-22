package com.kirunews.rpha.model.fixedvalues;

import java.util.Map;
import java.util.TreeMap;

/**
 * v30 - COLO - kolofon?
 * @author Király Péter
 */
public class ColoValues {

	private static Map<String, String> values = new TreeMap<String, String>();

	static {
		values.put("1", "A versnek van kolofonja");
		values.put("2", "A versnek nincs kolofonja");
		values.put("3", "Nem tudjuk");
	}

	public static Map<String, String> getAll() {
		return values;
	}

}
