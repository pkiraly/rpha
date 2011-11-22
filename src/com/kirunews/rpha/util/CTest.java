package com.kirunews.rpha.util;

public class CTest {

	public static void main(String[] args) throws ConfigurationException {
		Configuration.init(args[0] + "/tomcat/common/classes/rpha.properties");
		System.out.println(Configuration.params.getIndexDir());
	}
}
