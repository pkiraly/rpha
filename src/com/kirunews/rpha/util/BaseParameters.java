package com.kirunews.rpha.util;

import java.io.File;
import java.io.IOException;

import org.apache.commons.configuration.PropertiesConfiguration;

/**
 * Base configuration parameters for the application.
 * 
 * @author Tesuji Magyarország Kft., 2007
 */
public class BaseParameters {
	
	/**
	 * The path of the index directory
	 */
	private String indexDir;

	/**
	 * The path of the configuration directory
	 */
	private String configDir;

	/**
	 * The path of the directory where the sites should be downloaded  
	 */
	private String downloadDir;

	/**
	 * The path of the logging directory  
	 */
	private String logDir;
	
	/**
	 * {@link LoggingParameters}
	 */
	private LoggingParameters logParams;
	
	/** 
	 * The name of the the xml file that contains the list of sites 
	 * to download and theirs parameters. It must be in the {@link #configDir}
	 */
	public synchronized void load(String configFileName)
			throws ConfigurationException {

		File configFile = new File(configFileName);
		try {
			if (!configFile.exists())
				configFile.createNewFile();
		} catch (IOException e) {
			throw new ConfigurationException(
					"Unable to create configuration file: " + configFileName);
		}

		try {
			PropertiesConfiguration props = new PropertiesConfiguration(
					configFile);
			configDir	= (String) props.getProperty("rpha.configDir");
			System.out.println(SimpleLogger.line(this) + "configDir: " + configDir);
			indexDir	= (String) props.getProperty("rpha.indexDir");
			System.out.println(SimpleLogger.line(this) + "indexDir: " + indexDir);
			logDir		= (String) props.getProperty("rpha.logDir");
			System.out.println(SimpleLogger.line(this) + "logDir: " + logDir);
		
			logParams = new LoggingParameters(logDir);
			
		} catch (org.apache.commons.configuration.ConfigurationException e) {
			throw new ConfigurationException(e);
		}
	}

	public synchronized void save(String configFileName)
			throws ConfigurationException {

		try {
			PropertiesConfiguration props = new PropertiesConfiguration(
					configFileName);

			props.setProperty("rpha.configDir", configDir);
			props.setProperty("rpha.indexDir", indexDir);
			props.setProperty("rpha.logDir", logDir);
			
			props.save();

		} catch (org.apache.commons.configuration.ConfigurationException e) {
			throw new ConfigurationException(e);
		}
	}

	/**
	 * Return the index directory {@link #indexDir}
	 * @return indexDir
	 */
	public String getIndexDir() {
		return indexDir;
	}

	/**
	 * Set the index directory {@link #indexDir}
	 * @param indexDir
	 */
	public void setIndexDir(String indexDir) {
		this.indexDir = indexDir;
	}

	/**
	 * Get the configuration directory {@link #configDir}
	 * @return
	 */
	public String getConfigDir() {
		return configDir;
	}

	/**
	 * Set the configuration directory {@link #configDir}
	 * @param configDir
	 */
	public void setConfigDir(String configDir) {
		this.configDir = configDir;
	}

	/**
	 * Returns download directory {@link #downloadDir}
	 * @return downloadDir
	 */
	public String getDownloadDir() {
		return downloadDir;
	}

	/**
	 * Set download directory {@link #downloadDir}
	 * @param downloadDir
	 */
	public void setDownloadDir(String downloadDir) {
		this.downloadDir = downloadDir;
	}

	/**
	 * Returns the directory to log {@link #logDir}
	 * @return logDir
	 */
	public String getLogDir() {
		return logDir;
	}

	/**
	 * set the directory to log {@link #logDir}
	 * @param logDir
	 */
	public void setLogDir(String logDir) {
		this.logDir = logDir;
	}

	public LoggingParameters getLogParams() {
		return logParams;
	}

	public void setLogParams(LoggingParameters logParams) {
		this.logParams = logParams;
	}
}
