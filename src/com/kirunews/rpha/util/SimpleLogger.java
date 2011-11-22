package com.kirunews.rpha.util;

public class SimpleLogger {
	
	/**
	 * Return the current place of the caller, in format 'SimpleLogger:6'
	 * @param obj The caller object
	 * @return The object name's and the line number where from the object called this method
	 */
	public static String line(Object obj) {
		return obj.getClass().getSimpleName() 
			+ ":" + new Exception().getStackTrace()[1].getLineNumber() + " ";
	}

}
