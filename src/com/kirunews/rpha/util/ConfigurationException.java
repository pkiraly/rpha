package com.kirunews.rpha.util;

/**
 * Configuration exception
 * 
 * @author Tesuji Magyarország Kft., 2007
 */
public class ConfigurationException extends Exception {

	private static final long serialVersionUID = -4220088035482631544L;

    public ConfigurationException() {
        super();
    }

    public ConfigurationException(String arg0) {
        super(arg0);
    }

    public ConfigurationException(String arg0, Throwable arg1) {
        super(arg0, arg1);
    }

    public ConfigurationException(Throwable arg0) {
        super(arg0);
    }
}