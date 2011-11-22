package com.kirunews.rpha.model.fixedvalues;

import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;

/**
 * v23	CHANS	ének/szöveg?
 * @author Király Péter
 */
public class ChansValues {

	private static Map<String, String> values = new HashMap<String, String>();

	static {
		values.put("1", "A vers szövegvers");
		values.put("2", "A vers énekvers");
		values.put("3", "Bizonytalan, hogy énekelték-e");
	}

	public static Map<String, String> getAll() {
		return values;
	}

}
