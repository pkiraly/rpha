package com.kirunews.rpha.model;

import java.util.List;
import java.util.Map;

public interface QueryDictionary {

	/**
	 * Translates external field name to RPHA field name
	 * @param fieldName External field name
	 * @return RPHA field name
	 */
	public String toRpha(String fieldName);
	
	/**
	 * Translates external field value to RPHA field value
	 * @param fieldName External field name
	 * @param key External field value
	 * @return RPHA field value
	 */
	public String toRphaVals(String fieldName, String val);

	/**
	 * Alternative fields
	 * @param fieldName
	 * @return
	 */
	public List<String> toRphaAlt(String fieldName);

	/**
	 * Translates RPHA field name to external field name
	 * @param fieldName RPHA field name
	 * @return external field name
	 */
	public String toExternal(String fieldName);

	/**
	 * Translates RPHA field value to external field value
	 * @param fieldName RPHA field value
	 * @return External field value
	 */
	public String toExternalVals(String fieldName, String val);
	
	public Map<String, String> getRphaExt(String fieldName);

	

}
