package com.kirunews.rpha.struts.form;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

/** 
 * MyEclipse Struts
 * Creation date: 11-14-2007
 * 
 * XDoclet definition:
 * @struts.form name="saveVersionForm"
 */
public class SaveVersionForm extends ActionForm {

	static final long serialVersionUID = 23134423L;
	
	private String type;

	/** poem property */
	private String poem;

	/** source property */
	private String source;

	/** xml property */
	private String xml;
	
	private String error;

	/*
	 * Generated Methods
	 */

	public String getError() {
		return error;
	}

	public void setError(String error) {
		this.error = error;
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

	/** 
	 * Returns the poem.
	 * @return String
	 */
	public String getPoem() {
		return poem;
	}

	/** 
	 * Set the poem.
	 * @param poem The poem to set
	 */
	public void setPoem(String poem) {
		this.poem = poem;
	}

	/** 
	 * Returns the source.
	 * @return String
	 */
	public String getSource() {
		return source;
	}

	/** 
	 * Set the source.
	 * @param source The source to set
	 */
	public void setSource(String source) {
		this.source = source;
	}

	public String getXml() {
		return xml;
	}

	public void setXml(String xml) {
		this.xml = xml;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
}