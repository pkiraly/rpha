package com.kirunews.rpha.struts.action;

import java.io.FileNotFoundException;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;

//import org.apache.commons.logging.Log;
//import org.apache.commons.logging.LogFactory;
import org.apache.log4j.Logger;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.kirunews.rpha.model.SearchBook;
import com.kirunews.rpha.model.PoemSearcher;
import com.kirunews.rpha.struts.form.SearchForm;
import com.kirunews.rpha.util.Configuration;
import com.kirunews.rpha.util.DateUtil;
import com.kirunews.rpha.util.Logging;
import com.kirunews.rpha.util.XsltTransformator;

/**
 * MyEclipse Struts Creation date: 11-04-2007
 * 
 * XDoclet definition:
 * 
 * @struts.action path="/search" name="searchForm" input="/form/search.jsp"
 *                scope="request" validate="true"
 */
public class SearchAction extends Action {

	private static Logger logger = Logging.getLogger();
	private SearchForm searchForm;
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
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		logger.info(request.getQueryString());
		searchForm = (SearchForm) form;
		String[] fields = searchForm.getFields();
		String[] values = searchForm.getValues();
		contextPath = request.getContextPath();
		if(fields != null && fields.length == 1 && fields[0].equals("v1")){
			searchForm.setId(values[0]);
		}
		System.setProperty("javax.xml.transform.TransformerFactory",
				"net.sf.saxon.TransformerFactoryImpl"); 

		String xsltDir = Configuration.params.getConfigDir() + "/xslt/";
		
		logger.info("RecordType: " + searchForm.getRecordType());
		logger.info("SearchType: " + searchForm.getInnerSearchType());
		logger.info("Query: "      + searchForm.getQuery());

		try {
			String xml = "";
			if((searchForm.getInnerSearchType() == SearchForm.SearchTypes.LISTS && values != null)
					|| (searchForm.getInnerSearchType() == SearchForm.SearchTypes.LUCENE 
							&& searchForm.getQuery() != null)) {
				if(searchForm.getRecordType().equals("poem")){
					PoemSearcher searchData = new PoemSearcher();
					if(searchForm.getInnerSearchType() == SearchForm.SearchTypes.LISTS) {
						xml = searchData.search(fields, values, true);
					} else if(searchForm.getInnerSearchType() == SearchForm.SearchTypes.LUCENE) {
						xml = searchData.searchByQuery(searchForm.getQuery(), true);
					}
				} else if(searchForm.getRecordType().equals("book")){
					SearchBook searchData = new SearchBook();
					xml = searchData.search(fields, values, true);
				}
				if(searchForm.getOutputFormat().equals("xml")) {
					searchForm.setXml(xml);
				} else if(searchForm.getOutputFormat().equals("book")) {
					searchForm.setXml(transform(xml, xsltDir + "/poemsFilterInBook.xsl"));
				} else if(searchForm.getOutputFormat().equals("bookxml")) {
					searchForm.setXml(xml);
				} else {
					searchForm.setHtml(transform(xml, xsltDir + "/xml2html.xsl"));
					searchForm.setAnalizis(transform(xml, xsltDir + "/xml2analizis.xsl"));
					searchForm.setJs(transform(xml, xsltDir + "/xml2js.xsl"));
				}
			}

		} catch (IOException e) {
			logger.error(e.getMessage());
			searchForm.setError(e.getMessage());
		}
		logger.info(DateUtil.getTime() + " - end");

		if(searchForm.getAction().equals("form")) {
			if(searchForm.getSearchFormID().equals("advanced")) {
				logger.info("advanced");
				return mapping.findForward("search-advanced");
			} else if(searchForm.getSearchFormID().equals("rpha5")) {
				logger.info("rpha5");
				return mapping.findForward("search-rpha5");
			}
		} else if(searchForm.getOutputFormat().equals("xml")) {
			logger.info("xml");
			return mapping.findForward("xml");
		} else if(searchForm.getOutputFormat().equals("html")) {
			logger.info("html");
			return mapping.findForward("html");
		} else if(searchForm.getOutputFormat().equals("book")) {
			logger.info("book");
			return mapping.findForward("book");
		}
		
		logger.info("default");
		return mapping.findForward("default");
	}

	private String transform(String xmlSource, String xsltFileName) {
		//logger.info(xmlSource);
		String fileNameToShow = xsltFileName.substring(xsltFileName.lastIndexOf("/")+1);
		try {
			XsltTransformator t = new XsltTransformator();
			String output = t.transform(xmlSource, xsltFileName);
			return output.replaceAll("BASE_PATH", contextPath);
		} catch (FileNotFoundException e) {
			searchForm.setError(fileNameToShow + " [File not found error] " + e.getMessage());
		} catch (TransformerConfigurationException e) {
			searchForm.setError(fileNameToShow + " [Transformer configuration error] " + e.getMessageAndLocation());
		} catch (TransformerException e) {
			logger.error(xmlSource);
			searchForm.setError(fileNameToShow + " [Transformer error] " + e.getMessageAndLocation() + xmlSource);
		}
		return "";
	}
}