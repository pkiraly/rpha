package com.kirunews.rpha.util;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;

import org.apache.log4j.Logger;

/**
 * The configuration of the crawler application
 * 
 * @author Tesuji Magyarország Kft., 2007
 */
public class Configuration {
	
	/**
	 * The configuration file
	 */
	private static final String CONFIGFILENAME = "rpha.properties";
	
	/**
	 * The path of config file
	 */
	public static String configFile;
	
	/**
	 * The storage object of base parameters {@link BaseParameters}
	 */
	public static BaseParameters params = new BaseParameters();
	
	/**
	 * logger
	 */
	private static Logger logger = Logging.getLogger();
	
	/**
	 * Find the crawler.properties config file. This file defines the 
	 * base parameters 
	 * @throws ConfigurationException
	 */
	public static void init() throws ConfigurationException {
		System.out.println(Configuration.class.getSimpleName() 
				+ ":" + new Exception().getStackTrace()[0].getLineNumber() 
				+ " Configuration.init()");
		
		URL configURL = Configuration.class.getClassLoader()
						.getResource(CONFIGFILENAME);
		
		if (configURL == null){
			configFile = System.getProperty("user.home")
						+ "/" + CONFIGFILENAME;
		} else
			configFile = configURL.getFile();

		if (configFile == null) {
			logger.error("Please create a file called: "
					+ "<" + CONFIGFILENAME + "> in your classpath.");
			throw new ConfigurationException("Please create a file called: "
					+ "<" + CONFIGFILENAME + "> in your classpath.");
		} else {
			File confF = new File(configFile);
			try {
				if (!confF.exists())
					confF.createNewFile();
			} catch (IOException e) {
				throw new ConfigurationException("Unable to create " +
						"<" + CONFIGFILENAME + "> " +
						"config file. Root cause: " + e.getMessage());
			}
			Configuration.configFile = configFile;
		}
		
		init(configFile);
	}

	/**
	 * Load the basic values from the config file. Set up download parameters,
	 * start logging ({@link #startLogging()}), start scheduler ({@link #startScheduler()}),
	 * and parse the site list file ({@link #parseSiteListFile})
	 * @throws ConfigurationException
	 */
	public static void init(String configFile) throws ConfigurationException {
		File cfg = new File(configFile);
		
		if (!cfg.exists()) {
			throw new ConfigurationException("Inexistent configuration file: "
							+ configFile);
		} else
			Configuration.configFile = configFile;

		params.load(Configuration.configFile);
		if (!(new File(params.getConfigDir()).exists())) {
			throw new ConfigurationException("Inexistent configuration dir: "
							+ params.getConfigDir());
		}
		if (!(new File(params.getIndexDir()).exists())) {
			throw new ConfigurationException("Inexistent index dir: "
							+ params.getIndexDir());
		}
		if (!(new File(params.getLogDir()).exists())) {
			throw new ConfigurationException("Inexistent log dir: "
							+ params.getLogDir());
		}
		
		startLogging();
	}
	
	/**
	 * start logging
	 */
	public static void startLogging() {
		ClassLoader cloader = Configuration.class.getClassLoader();
		InputStream logProps = cloader.getResourceAsStream(
		"com/kirunews/rpha/struts/log4j.properties");
		Logging.initLogging(params.getLogParams(), logProps);
	}
	
	/**
	 * destroy the configuration object, stop scheduler and close index writer
	 * @throws ConfigurationException
	 */
	public static void destroy() throws ConfigurationException {
	}

	/**
	 * Returns the config file's path
	 * @return
	 */
	public static String getConfigFile() {
		return configFile;
	}

	public static void main(String[] args) {
        try {
			Configuration.init();
		} catch (ConfigurationException e) {
			;
		}
	}
}
