package com.kirunews.rpha.model;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

public class MegarepQueryDictionary implements QueryDictionary {
	
	private static Map<String, String> megarep2rpha = new HashMap<String, String>();
	private static Map<String, Map<String, String>> megarep2rphaVals 
		= new HashMap<String, Map<String, String>>();
	
	/**
	 * Extension: Addtitional field name and value. The field is valid only with this info.
	 * an example: number_of_lines:8 ahould be translated to (v42:8 AND v43:2)
	 */
	private static Map<String, Map<String, String>> megarep2rphaExt 
		= new HashMap<String, Map<String, String>>();

	/**
	 * Alternative fields
	 * an example: author:john ahould be translated to (v5_s1:john OR v5_s2:john OR v5_s3:john)
	 */
	private static Map<String, List<String>> megarep2rphaAlt = new HashMap<String, List<String>>();

	private static Map<String, String> rpha2megarep = new HashMap<String, String>();
	
	static {
		megarep2rpha.put("meter", "v44");
		megarep2rphaVals.put("meter", toMap(new String[]{
				"01", "8", 
				"01-01-01", "6", 
				"01-01-02", "6",
				"01-02-01", "7",
				"01-02-02", "7",
				"01-03", "8",
				"01-04", "4",
				"02", "1",
				"03", "16",
				"05", "18",
				"08", "15"
		}));
		megarep2rpha.put("meter_qualifier", null);
		megarep2rpha.put("segmentation", null);
		megarep2rpha.put("segmentation_qualifier", null);
		megarep2rpha.put("rhyme", null);
		megarep2rpha.put("rhyme_qualifier", null);
		megarep2rpha.put("rhyme_scheme", "v46");
		megarep2rpha.put("metrical_scheme", "v47");
		megarep2rpha.put("declination_line", null);
		megarep2rpha.put("declination_strophe", null);
		megarep2rpha.put("declination_scheme", null);
		megarep2rpha.put("number_of_lines", "v42"); // and v43:2
		megarep2rphaExt.put("number_of_lines", toMap(new String[]{"v43", "2"}));
		megarep2rpha.put("number_of_strophes", "v42"); // and v43:1
		megarep2rphaExt.put("number_of_strophes", toMap(new String[]{"v43", "1"}));
		//megarep2rpha.put("author", "v5"); // OK
		megarep2rphaAlt.put("author", Arrays.asList("v5_s1", "v5_s2"));
		megarep2rpha.put("date", "v21"); // OK
		megarep2rpha.put("date_qualifier", "v22"); // OK
		megarep2rpha.put("melody", "v23");
		megarep2rphaVals.put("melody", toMap(new String[]{"01", "2", "02", "1", "03", "3"}));
		megarep2rpha.put("melody_qualifier", null);
		megarep2rpha.put("genre", "v28"); // OK
		megarep2rpha.put("caesuras", "v20");
		megarep2rpha.put("language", "v18"); // OK
		megarep2rphaVals.put("language", toMap(new String[]{"de", "ger", "el", "gre", "hr", "hrv", 
				"hu", "hun", "la", "lat"}));
		megarep2rpha.put("language_qualifier", null);
		
		for(Entry<String, String> entry : megarep2rpha.entrySet()) {
			rpha2megarep.put(entry.getValue(), entry.getKey());
		}
	}
	
	public String toRpha(String megarep) {
		return megarep2rpha.get(megarep);
	}

	public String toRphaVals(String megarep, String val) {
		if(megarep2rphaVals.get(megarep) != null 
			&& megarep2rphaVals.get(megarep).get(val) != null) {
			return megarep2rphaVals.get(megarep).get(val);
		} else {
			return val;
		}
	}
	
	public List<String> toRphaAlt(String fieldName) {
		return megarep2rphaAlt.get(fieldName);
	}

	public Map<String, String> getRphaExt(String megarep) {
		return megarep2rphaExt.get(megarep);
	}

	public String toExternal(String rpha) {
		return rpha2megarep.get(rpha);
	}
	
	private static Map<String, String> toMap(String[] args) {
		Map<String, String> map = new HashMap<String, String>();
		for(int i=0; i<args.length; i+=2) {
			map.put(args[i], args[i+1]);
		}
		return map;
	}

	public String toExternalVals(String key) {
		// TODO Auto-generated method stub
		return null;
	}

	public String toRphaVals(String key) {
		// TODO Auto-generated method stub
		return null;
	}

	public String toExternalVals(String fieldName, String val) {
		// TODO Auto-generated method stub
		return null;
	}

}
