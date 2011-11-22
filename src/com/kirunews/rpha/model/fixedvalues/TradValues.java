package com.kirunews.rpha.model.fixedvalues;

import java.util.Map;
import java.util.TreeMap;

/**
 * v11 - TRAD - minta
 * @author Király Péter
 */
public class TradValues {

	private static Map<String, String> values = new TreeMap<String, String>();

	static {
		values.put("1", "nem tudjuk megállapítani");
		values.put("2", "meghatározható közvetlen minta");
		values.put("3", "bizonyosan közvetlen minta");
		values.put("4", "Nem tudjuk, hogy volt-e mintája");
	}

	public static Map<String, String> getAll() {
		return values;
	}

}
