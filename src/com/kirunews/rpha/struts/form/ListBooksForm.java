package com.kirunews.rpha.struts.form;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

/** 
 * MyEclipse Struts
 * Creation date: 11-18-2007
 * 
 * XDoclet definition:
 * @struts.form name="listBooksForm"
 */
public class ListBooksForm extends ActionForm {

	static final long serialVersionUID = 23134426L;
	
	private String type;

	/** html property */
	private String html;

	/** 
	 * Method validate
	 * @param mapping
	 * @param request
	 * @return ActionErrors
	 */
	public ActionErrors validate(ActionMapping mapping,
			HttpServletRequest request) {
		// TODO Auto-generated method stub
		return null;
	}

	/** 
	 * Method reset
	 * @param mapping
	 * @param request
	 */
	public void reset(ActionMapping mapping, HttpServletRequest request) {
		try {
			request.setCharacterEncoding("utf-8");
		} catch(UnsupportedEncodingException e) {
			;
		}
	}

	/** 
	 * Returns the html.
	 * @return String
	 */
	public String getHtml() {
		return html;
	}

	/** 
	 * Set the html.
	 * @param html The html to set
	 */
	public void setHtml(String html) {
		this.html = html;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
}