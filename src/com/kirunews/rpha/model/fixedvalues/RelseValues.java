package com.kirunews.rpha.model.fixedvalues;

import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;

/**
 * v48 - RELSE - felekezeti megoszlás
 * @author Király Péter
 */
public class RelseValues {

	private static Map<String, String> values = new TreeMap<String, String>();

	static {
		values.put("relsek", "katolikus");
		values.put("relsep", "protestáns");
		values.put("relser", "református");
		values.put("relsee", "evangélikus");
		values.put("relses", "szombatos");
		values.put("relseu", "unitárius");
		values.put("relsem", "muzulmán");
		values.put("relsev", "világi");
		values.put("relsex", "közelebről meg nem határozott");
	}

	public static Map<String, String> getAll() {
		return values;
	}

}
