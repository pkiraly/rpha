package com.kirunews.rpha.util;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;

import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.index.IndexWriter;

public class Optimize {
	
	public static void main(String[] args) {
		if(args.length != 1){
			System.out.println("Usage: java Optimize <index>");
			return;
		}
		try {
			String dir = args[0];
			if(!(new File(dir)).exists()) {
				System.out.println("No index dir exists in " + dir);
			}
			System.out.println("Optimize index in " + dir);
        	IndexWriter writer = new IndexWriter(dir, 
        			new StandardAnalyzer());
        	writer.optimize();
        	writer.close();
		} catch (FileNotFoundException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
	}
}

