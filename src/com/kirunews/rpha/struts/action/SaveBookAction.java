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
import com.kirunews.rpha.struts.form.SaveBookForm;
import com.kirunews.rpha.util.Logging;

/** 
 * MyEclipse Struts
 * Creation date: 12-28-2007
 * 
 * XDoclet definition:
 * @struts.action path="/saveBook" name="saveBookForm" input="/form/saveBook.jsp" scope="request" validate="true"
 */
public class SaveBookAction extends Action {
	private static Logger logger = Logging.getLogger();

	/** 
	 * Method execute
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return ActionForward
	 */
	public ActionForward execute(ActionMapping mapping, ActionForm saveBookForm,
			HttpServletRequest request, HttpServletResponse response) {
		SaveBookForm form = (SaveBookForm) saveBookForm;
		
		logger.info("id: " + form.getId());
		logger.info("xml: " + form.getXml());

		XmlIndexer indexer = new XmlIndexer();
		indexer.setXmlString(form.getXml());
		try {
			if(form.getId() != null) {
				indexer.deleteBook(form.getId());
			}
			indexer.index();
			if(form.getId() != null) {
				form.setId(indexer.getLastInsertedId());
			}
		} catch(FileNotFoundException e) {
			logger.error(e.getMessage());
			form.setError(e.getMessage());
		} catch(IOException e) {
			logger.error(e.getMessage());
			form.setError(e.getMessage());
		}

		if(form.getError() == null) {
			try {
				String redirectUrl = request.getContextPath() 
									+ "/book/" + form.getId();
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