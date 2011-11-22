package com.kirunews.rpha.struts.form;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

/** 
 * MyEclipse Struts
 * Creation date: 12-11-2007
 * 
 * XDoclet definition:
 * @struts.form name="deleteVersionForm"
 */
public class DeleteVersionForm extends ActionForm {

	static final long serialVersionUID = 23134424L;

	private String poem;
	private String source;
	private String error;

	public String getPoem() {
		return poem;
	}

	public void setPoem(String poem) {
		this.poem = poem;
	}

	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}

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

	public String getError() {
		return error;
	}

	public void setError(String error) {
		this.error = error;
	}
}