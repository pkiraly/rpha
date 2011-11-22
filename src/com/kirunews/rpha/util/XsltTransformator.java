package com.kirunews.rpha.util;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.io.StringWriter;
import java.io.Writer;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

public class XsltTransformator {
	private Map<String, String> params;

	public String transform(String xmlSource, String xsltFileName)
			throws FileNotFoundException, TransformerConfigurationException,
			TransformerException {
		// String fileNameToShow =
		// xsltFileName.substring(xsltFileName.lastIndexOf("/")+1);

		InputStream xslStr = new FileInputStream(xsltFileName);

		TransformerFactory tFactory = TransformerFactory.newInstance();
		Transformer transformer = tFactory.newTransformer(new StreamSource(
				xslStr));

		Writer out = new StringWriter();
		StreamResult dest = new StreamResult(out);

		Source src = new StreamSource(new java.io.StringReader(xmlSource));
		if (params != null && params.size() > 0) {
			Set<String> keys = params.keySet();
			Iterator<String> it = keys.iterator();
			while (it.hasNext()) {
				String key = it.next();
				transformer.setParameter(key, params.get(key));
			}
		}

		transformer.transform(src, dest);
		return out.toString();
	}

	public void setParams(Map<String, String> params) {
		this.params = params;
	}
}
