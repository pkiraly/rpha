package com.kirunews.rpha.model.fixedvalues;

import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;

/**
 * v18 - LANOR - eredeti nyelv
 * @author Király Péter
 */
public class LanorValues {

	private static Map<String, String> values = new HashMap<String, String>();

	static {
		values.put("all", "német");
		values.put("gre", "görög");
		values.put("cro", "horvát");
		values.put("hon", "magyar");
		values.put("lat", "latin");
	}

	public static Map<String, String> getAll() {
		return values;
	}

}
