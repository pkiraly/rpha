package com.kirunews.rpha.util;

import java.io.BufferedWriter;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;

import org.apache.lucene.document.Document;
import org.apache.lucene.index.IndexReader;

public class ExportXML {
	// private static String indexDir = Configuration.params.getIndexDir();
	
	public static void main(String[] args) throws IOException, ConfigurationException {
		if(args.length != 2){
			System.out.println("Usage: java ExportXML <applBasePath>" +
					" <xml file>");
			return;
		}

		String applBasePath = args[0];
		String xmlFileName = args[1];

		Configuration.init(applBasePath 
				+ "/tomcat/common/classes/rpha.properties");

		BufferedWriter bw = null;
		IndexReader reader = null;
		try {
			reader = IndexReader.open(Configuration.params.getIndexDir());
			/*
			Iterator it = reader.document(0).getFields().iterator();
			while(it.hasNext()){
				System.out.println(((Field)it.next()).name());
			}
			*/
			
			bw = new BufferedWriter(
					new OutputStreamWriter(
						new FileOutputStream(
							Configuration.params.getConfigDir()
							+ "/" + xmlFileName),
						"utf-8"));
			bw.append("<?xml version=\"1.0\" encoding=\"utf-8\"?>\n");
			bw.append("<repert>\n");
			Document doc;
			for(int i=0, l=reader.numDocs(); i<l; i++) {
				doc = reader.document(i);
				bw.append(doc.get("record").replaceAll(">", ">\n"));
			}
			bw.append("</repert>\n");
        } catch (FileNotFoundException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        } finally {
            //Close the BufferedWriter
            try {
                if (bw != null) {
                    bw.flush();
                    bw.close();
                }
                if(reader != null){
                	reader.close();
                }
            } catch (IOException ex) {
                ex.printStackTrace();
            }
        }
	}
}
