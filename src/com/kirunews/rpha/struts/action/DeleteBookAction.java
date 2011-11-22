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
import com.kirunews.rpha.struts.form.DeleteBookForm;
import com.kirunews.rpha.util.Logging;

/** 
 * MyEclipse Struts
 * Creation date: 12-28-2007
 * 
 * XDoclet definition:
 * @struts.action path="/deleteBook" name="deleteBookForm" input="/form/deleteBook.jsp" scope="request" validate="true"
 */
public class DeleteBookAction extends Action {
	private static Logger logger = Logging.getLogger();

	/** 
	 * Method execute
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return ActionForward
	 */
	public ActionForward execute(ActionMapping mapping, ActionForm deleteBookForm,
			HttpServletRequest request, HttpServletResponse response) {
		DeleteBookForm form = (DeleteBookForm) deleteBookForm;
		XmlIndexer indexer = new XmlIndexer();
		try {
			if(form.getId() != null) {
				indexer.deleteBook(form.getId());
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
				String redirectUrl = request.getContextPath() + "/listbooks";
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