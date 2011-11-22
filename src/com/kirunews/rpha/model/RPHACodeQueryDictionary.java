package com.kirunews.rpha.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

public class RPHACodeQueryDictionary implements QueryDictionary {
	
	private static Map<String, String> rphaCode2rpha = new HashMap<String, String>();
	private static Map<String, Map<String, String>> rphaCode2rphaVals 
		= new HashMap<String, Map<String, String>>();
	
	/**
	 * Extension: Addtitional field name and value. The field is valid only with this info.
	 * an example: number_of_lines:8 ahould be translated to (v42:8 AND v43:2)
	 */
	private static Map<String, Map<String, String>> rphaCode2rphaExt 
		= new HashMap<String, Map<String, String>>();

	/**
	 * Alternative fields
	 * an example: author:john ahould be translated to (v5_s1:john OR v5_s2:john OR v5_s3:john)
	 */
	private static Map<String, List<String>> rphaCode2rphaAlt = new HashMap<String, List<String>>();

	private static Map<String, String> rpha2rphaCode = new HashMap<String, String>();
	
	static {
		rphaCode2rpha.put("rpha", "v1");
		rphaCode2rpha.put("inc", "v2");
		rphaCode2rpha.put("titre", "v3");
		rphaCode2rpha.put("aut", "v5");
		rphaCode2rpha.put("aut1", "v5_s1");
		rphaCode2rpha.put("aut2", "v5_s2");
		rphaCode2rpha.put("aut3", "v5_s3");
		rphaCode2rpha.put("trad", "v11");
		rphaCode2rpha.put("incor", "v12");
		rphaCode2rpha.put("titor", "v13");
		rphaCode2rpha.put("hymnus", "v14");
		rphaCode2rpha.put("autet", "v15");
		rphaCode2rpha.put("lanor", "v18");
		rphaCode2rpha.put("an", "v21");
		rphaCode2rpha.put("prec", "v22");
		rphaCode2rpha.put("chans", "v23");
		rphaCode2rpha.put("signe", "v24");
		rphaCode2rpha.put("genre", "v28");
		rphaCode2rpha.put("colo", "v30");
		rphaCode2rpha.put("dedie", "v31");
		rphaCode2rpha.put("dedie1", "v31_s1");
		rphaCode2rpha.put("dedie2", "v31_s2");
		rphaCode2rpha.put("dedie3", "v31_s3");
		rphaCode2rpha.put("doncolo", "v32");
		rphaCode2rpha.put("doncolo1", "v32_s1");
		rphaCode2rpha.put("doncolod", "v32_sd");
		rphaCode2rpha.put("doncolol", "v32_sl");
		rphaCode2rpha.put("acr", "v33");
		rphaCode2rpha.put("acrost", "v34");
		rphaCode2rpha.put("donacr", "v35");
		rphaCode2rpha.put("donacr1", "v35_s1");
		rphaCode2rpha.put("donacrd", "v35_sd");
		rphaCode2rpha.put("donacrl", "v35_sl");
		rphaCode2rpha.put("comment", "v39");
		rphaCode2rpha.put("int", "v41");
		rphaCode2rpha.put("lon", "v42");
		rphaCode2rpha.put("pre", "v43");
		rphaCode2rpha.put("typme", "v44");
		rphaCode2rpha.put("metr", "v45");
		rphaCode2rpha.put("rime", "v46");
		rphaCode2rpha.put("syll", "v47");
		rphaCode2rpha.put("relsek", "v48_sk");
		rphaCode2rpha.put("relsep", "v48_sp");
		rphaCode2rpha.put("relser", "v48_sr");
		rphaCode2rpha.put("relsee", "v48_se");
		rphaCode2rpha.put("relses", "v48_ss");
		rphaCode2rpha.put("relseu", "v48_su");
		rphaCode2rpha.put("relsem", "v48_sm");
		rphaCode2rpha.put("relsev", "v48_sv");
		rphaCode2rpha.put("relsex", "v48_sx");
		rphaCode2rpha.put("refren", "v163");
		
		for(Entry<String, String> entry : rphaCode2rpha.entrySet()) {
			rpha2rphaCode.put(entry.getValue(), entry.getKey());
		}
	}
	
	public String toRpha(String megarep) {
		return rphaCode2rpha.get(megarep);
	}

	public String toRphaVals(String megarep, String val) {
		if(rphaCode2rphaVals.get(megarep) != null 
			&& rphaCode2rphaVals.get(megarep).get(val) != null) {
			return rphaCode2rphaVals.get(megarep).get(val);
		} else {
			return val;
		}
	}
	
	public List<String> toRphaAlt(String fieldName) {
		return rphaCode2rphaAlt.get(fieldName);
	}

	public Map<String, String> getRphaExt(String megarep) {
		return rphaCode2rphaExt.get(megarep);
	}

	public String toExternal(String rpha) {
		return rpha2rphaCode.get(rpha);
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
