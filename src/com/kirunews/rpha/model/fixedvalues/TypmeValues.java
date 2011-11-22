package com.kirunews.rpha.model.fixedvalues;

import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;

/**
 * v44 - TYPME - metrum típus
 * @author Király Péter
 */
public class TypmeValues {

	private static Map<String, String> values = new TreeMap<String, String>();

	static {
		values.put("1", "Szótagszámláló, izostrofikus vers");
		values.put("3", "Bizonytalan, hogy vers-e, vagy próza");
		values.put("4", "Bizonytalan verselésű időmértékes vers");
		values.put("5", "Bizonytalan verselésű szótagszámláló, izostrofikus vers");
		values.put("6", "Hexameter");
		values.put("7", "Disztichon");
		values.put("8", "Időmértékes vers, de nem hexameter vagy disztichon");
		values.put("10", "Hangsúlyos, nem strofikus, nem szótagszámláló rímtelen vers");
		values.put("11", "Bizonytalan, hogy vers-e, vagy ritmikus próza");
		values.put("12", "Verssorok és próza váltakozása");
		values.put("15", "Váltakozó metrumú (ld. a Mellékadatlapok leírásánál!)");
		values.put("16", "Pesti Gábor-féle metrum");
		values.put("17", "Szótagszámláló vers");
		values.put("18", "Szószámláló vers");
		values.put("19", "Sequentiát imitáló vers");
		values.put("30", "Nótajelzés (metruma más vers metruma alapján van kikövetkeztetve)");
	}

	public static Map<String, String> getAll() {
		return values;
	}

}
