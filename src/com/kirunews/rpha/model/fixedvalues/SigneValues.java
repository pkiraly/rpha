package com.kirunews.rpha.model.fixedvalues;

import java.util.Map;
import java.util.TreeMap;

/**
 * v24 - SIGNE - szignáltság
 * @author Király Péter
 */
public class SigneValues {

	private static Map<String, String> values = new TreeMap<String, String>();

	static {
		values.put("1", "a szerző névmegjelölésével");
		values.put("2", "szerzőjét nem ismerjük");
		values.put("3", "a szerzőnek tulajdonították");
		values.put("4", "modern kutatás alapján");
		values.put("5", "gyűjtemény a szerző neve alatt");
		values.put("6", "anagrammatikusan szignált");
	}

	public static Map<String, String> getAll() {
		return values;
	}

}
