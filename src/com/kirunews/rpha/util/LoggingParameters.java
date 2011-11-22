package com.kirunews.rpha.util;

import java.io.File;

/**
 * Bean to store logging related parameters
 * 
 * @author Tesuji Magyarország Kft., 2007
 */
public class LoggingParameters {

	/**
	 * The directory where the log files are stored
	 */
	private String logDir;
	
	/**
	 * The file to write log information 
	 */
	private String logFile       = "indexing.log";
	
	/**
	 * The base level of logging
	 */
	private String logLevel   = "DEBUG";

	public LoggingParameters(){
	}
	
	public LoggingParameters(String logDir){
		this.logDir = logDir;
	}
	
	/** 
	 * Validate whether the log directory does exist or not
	 * @return boolean value
	 * @throws ConfigurationException
	 */
	public boolean validate() throws ConfigurationException {
		File logDirectory = new File(logDir);
		
		if (!logDirectory.exists())
			throw new ConfigurationException("Inexistent logging directory: "
					+ logDir +". Please create it or specify an other one.");
		
		return true;
	}
		
	/**
	 * Return the level of logging
	 * @return Returns the logLevel.
	 */
	public String getLogLevel() {
		return logLevel;
	}
	
	/**
	 * @param indexingLogLevel The logLevel to set.
	 */
	public void setLogLevel(String logLevel) {
		if (logLevel != null)
			this.logLevel = logLevel;
	}

	/**
	 * @return Returns the logDir.
	 */
	public String getLogDir() {
		return logDir;
	}

	/**
	 * @param logDir The logDir to set.
	 */
	public void setLogDir(String logDir) {
		if (logDir != null)
			this.logDir = logDir;
	}
	
	/**
	 * @return Returns the logFile.
	 */
	public String getLogFile() {
		return logFile;
	}
	
	/**
	 * Returns the logFile's absolute path
	 * @return logFile The logFile's absolute path.
	 */
	public String getLogFileAbs() {
		return logDir + "/" + logFile;
	}
	
	/**
	 * @param logFile The logFile to set.
	 */
	public void setLogFile(String logFile) {
		if (logFile != null)
			this.logFile = logFile;
	}
	
}
