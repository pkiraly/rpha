package com.kirunews.rpha.struts.action;

import java.io.FileNotFoundException;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.kirunews.rpha.model.XmlIndexer;
import com.kirunews.rpha.struts.form.SaveVersionForm;
import com.kirunews.rpha.util.Logging;

/** 
 * MyEclipse Struts
 * Creation date: 11-14-2007
 * 
 * XDoclet definition:
 * @struts.action path="/saveVersion" name="saveVersionForm" input="/form/saveVersion.jsp" scope="request" validate="true"
 */
public class SaveVersionAction extends Action {

	private static Logger logger = Logging.getLogger();

	/** 
	 * Method execute
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return ActionForward
	 */
	public ActionForward execute(ActionMapping mapping, ActionForm actionForm,
			HttpServletRequest request, HttpServletResponse response) {
		SaveVersionForm form = (SaveVersionForm) actionForm;
		
		logger.info("url: " + request.getRequestURI() + " " + request.getQueryString());
		logger.info("type: " + form.getType());
		logger.info("poem: " + form.getPoem());
		logger.info("source: " + form.getSource());
		logger.info("xml: " + form.getXml());

		XmlIndexer indexer = new XmlIndexer();
		indexer.setXmlString(form.getXml());
		try {
			indexer.deleteDocs(form.getPoem(), form.getSource());
			indexer.index();
		} catch(FileNotFoundException e) {
			logger.error(e.getMessage());
			form.setError(e.getMessage());
		} catch(IOException e) {
			logger.error(e.getMessage());
			form.setError(e.getMessage());
		}

		if(form.getError() == null) {
			try {
				String redirectUrl = request.getContextPath() + "/id/" + form.getPoem(); 
				logger.info("redirectUrl: " + redirectUrl);
				response.sendRedirect(redirectUrl);
			} catch(IOException e) {
				logger.error(e);
			}
			return null;
			//return mapping.getInputForward();
		} else {
			return mapping.getInputForward();
		}
	}
}