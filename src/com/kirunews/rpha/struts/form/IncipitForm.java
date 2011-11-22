package com.kirunews.rpha.struts.form;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

/** 
 * MyEclipse Struts
 * Creation date: 12-06-2007
 * 
 * XDoclet definition:
 * @struts.form name="incipitForm"
 */
public class IncipitForm extends ActionForm {

	static final long serialVersionUID = 23134425L;

	/** inc property */
	private String inc;
	
	private ArrayList<HashMap<String, String>> incipits;

	/*
	 * Generated Methods
	 */

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
	 * Returns the inc.
	 * @return String
	 */
	public String getInc() {
		return inc;
	}

	/** 
	 * Set the inc.
	 * @param inc The inc to set
	 */
	public void setInc(String inc) {
		this.inc = inc;
	}

	public ArrayList<HashMap<String, String>> getIncipits() {
		return incipits;
	}

	public void setIncipits(ArrayList<HashMap<String, String>> incipits) {
		this.incipits = incipits;
	}
}