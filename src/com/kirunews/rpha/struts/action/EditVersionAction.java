package com.kirunews.rpha.struts.action;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;

import org.apache.log4j.Logger;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.kirunews.rpha.model.SearchVersion;
import com.kirunews.rpha.struts.form.EditVersionForm;
import com.kirunews.rpha.util.Configuration;
import com.kirunews.rpha.util.Logging;
import com.kirunews.rpha.util.XsltTransformator;

/**
 * MyEclipse Struts Creation date: 11-14-2007
 * 
 * XDoclet definition:
 * 
 * @struts.action path="/editVersion" name="editVersionForm"
 *                input="/form/editVersion.jsp" scope="request" validate="true"
 */
public class EditVersionAction extends Action {

	private static Logger logger = Logging.getLogger();
	private EditVersionForm form;
	private String contextPath;

	/**
	 * Method execute
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return ActionForward
	 */
	public ActionForward execute(ActionMapping mapping, ActionForm actionForm,
			HttpServletRequest request, HttpServletResponse response) {
		form = (EditVersionForm) actionForm;

		String xsltDir = Configuration.params.getConfigDir() + "/xslt/";

		try {
			SearchVersion searchData = new SearchVersion();
			// poem
			// book
			// version
			Map<String, String> xslParams = new HashMap<String, String>();
			HashMap<String, String> query = new HashMap<String, String>();
			query.put("id", form.getPoem());
			query.put("v91", "0");
			String xml = searchData.search(query, false);
			xslParams.put("varName", "syntheticum");
			form.setSyntheticum(transform(xml, xsltDir + "/xml2js.xsl", xslParams));

			String versionId = form.getPoem() + "-" + form.getSource();
			query.clear();
			query.put("id", versionId);
			xml = searchData.search(query, false);
			xslParams.clear();
			xslParams.put("varName", "analyticum");
			form.setAnalyticum(transform(xml, xsltDir + "/xml2js.xsl", xslParams));
			form.setXml(xml);
		} catch (IOException e) {
			logger.error(e.getMessage());
		}

		return mapping.getInputForward();
	}

	private String transform(String xmlSource, String xsltFileName, 
			Map<String, String> xslParams) {
		String fileNameToShow = xsltFileName.substring(xsltFileName.lastIndexOf("/")+1);
		try {
			XsltTransformator t = new XsltTransformator();
			t.setParams(xslParams);
			String output = t.transform(xmlSource, xsltFileName);
			return output.replaceAll("BASE_PATH", contextPath);
		} catch (FileNotFoundException e) {
			form.setError(fileNameToShow + " [File not found error] " 
					+ e.getMessage());
		} catch (TransformerConfigurationException e) {
			form.setError(fileNameToShow + " [Transformer configuration error] " 
					+ e.getMessageAndLocation());
		} catch (TransformerException e) {
			form.setError(fileNameToShow + " [Transformer error] " 
					+ e.getMessageAndLocation());
		}
		return "";
	}
}