package com.kirunews.rpha.model.fixedvalues;

import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;

/**
 * v22 - PREC - szereztetés idejének pontosítása
 * @author Király Péter
 */
public class PrecValues {

	private static Map<String, String> values = new HashMap<String, String>();

	static {
		values.put("1", "pontosan");
		values.put("2", "nem később, mint");
		values.put("3", "nem korábban, mint");
		values.put("4", "kb.");
		values.put("5", "korábban, mint kb.");
		values.put("6", "x és y között");
		values.put("7", "vagy");
	}

	public static Map<String, String> getAll() {
		return values;
	}

}
