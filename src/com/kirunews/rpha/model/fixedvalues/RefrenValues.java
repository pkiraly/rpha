package com.kirunews.rpha.model.fixedvalues;

import java.util.Map;
import java.util.TreeMap;

/**
 * v30 - COLO - kolofon?
 * @author Király Péter
 */
public class RefrenValues {

	private static Map<String, String> values = new TreeMap<String, String>();

	static {
		values.put("0", "A sorban nincs refrén");
		values.put("R0", "Refrénes sor");
		values.put("R1", "Szabályosan váltakozó rímes refrén");
		values.put("R2", "Időnként refrénnel ellátott sor");
		values.put("R3", "Szabálytalanul váltakozó refrén");
		values.put("R4", "Metrumot nem tudunk megállapítani, de a vers refrénes szerkezetű");
		values.put("I0", "Megismételt sor");
	}

	public static Map<String, String> getAll() {
		return values;
	}

}
