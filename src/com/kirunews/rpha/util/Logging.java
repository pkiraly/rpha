package com.kirunews.rpha.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

/**
 * Initialize application logging.
 * Three category of logging are foreseen: admin, indexing and userevents. 
 * Each category is logged in a dailyRollingFileAppeder. When a program 
 * wants to log an event, first it has to decide witch category to use, 
 * and has to call the appropriate function:
 * {@link #getAdminLogger()}, {@link #getIndexingLogger()} or {@link #getUserEventsLogger()}
 * 
 * @author Tesuji Magyarország Kft., 2007
 */
public class Logging {
	
	public static final String indexing   = "indexing";
	
	/**
	 * 
	 * @param params
	 * @param propsFile
	 * @throws IOException
	 */
	public static void initLogging(
			LoggingParameters params, 
			InputStream propsFile) {

		Logger logger = Logging.getLogger();
		
    	if (propsFile != null){
    	
			try {
				Properties props = new Properties();
				props.load(propsFile);
				
				props.setProperty("log4j.appender.indexing.File", 
						params.getLogFileAbs());
				props.setProperty("log4j.logger.indexing",
						params.getLogLevel() + ", indexing");
				
				PropertyConfigurator.configure(props);
				logger.info("Logging started in directory: " 
						+ params.getLogDir());
			} catch (IOException e1) {
				logger.error("Unable to init logging. Root Cause: " + e1);
			} finally {
				try {
					propsFile.close();
				} catch (IOException e) {
					logger.error("Unable to close logfile. Root Cause: " + e);
				}
			}
		} else {
			logger.error("Unable to init logging. Root casuse: init file" +
					" not found" );
		}
	}
	
	public static Logger getLogger(){
		return Logger.getLogger(Logging.indexing);
	}
}
