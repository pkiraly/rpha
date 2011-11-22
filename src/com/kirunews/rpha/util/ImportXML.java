package com.kirunews.rpha.util;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;

import org.apache.lucene.index.CorruptIndexException;

import com.kirunews.rpha.model.XmlIndexer;

public class ImportXML {
	
	public static void main(String[] args) throws ConfigurationException, 
			CorruptIndexException, FileNotFoundException, IOException {
		if(args.length != 2){
			System.out.println("Usage: java ExportXML <applBaseDir> <xml file name>");
			System.out.println("<applBaseDir>: like 'e:/web_projects/rpha'");
			System.out.println("<xml file name>: like 'exportAfter.xml' in the appl. config dir");
			return;
		}
		
		String applBasePath = args[0];
		String xmlFileName  = args[1];
		String propertiesPath = "/tomcat/common/classes/rpha.properties";
		if(!(new File(applBasePath, propertiesPath)).exists()) {
			System.out.println("Not a correct <applBaseDir>: " + applBasePath);
			return;
		}

		long start = System.currentTimeMillis();
		Configuration.init(applBasePath + "/tomcat/common/classes/rpha.properties");
		if(!(new File(Configuration.params.getConfigDir(), xmlFileName)).exists()) {
			System.out.println("Inexistent xml file: " + xmlFileName);
			return;
		}

		System.out.println("Importing " + xmlFileName);
		XmlIndexer indexer = new XmlIndexer(
			Configuration.params.getIndexDir(),
			Configuration.params.getConfigDir() + "/" + xmlFileName
		);
		indexer.index(true);
		long end = System.currentTimeMillis();
		System.out.println("takes: " + (end-start) + " ms");
	}
}
