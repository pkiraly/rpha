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
 * @struts.form name="editVersionForm"
 */
public class EditVersionForm extends ActionForm {
	
	static final long serialVersionUID = 23134422L;


	/** poem property */
	private String poem;

	/** source property */
	private String source;
	
	/** the xml presentation of the data */
	private String xml;
	
	/** the js presentation of the data */
	private String js;

	/** the js presentation of sysnthetic data */
	private String syntheticum;

	/** the js presentation of analythic data */
	private String analyticum;

	/** the error */
	private String error;
	
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

	public String getJs() {
		return js;
	}

	public void setJs(String js) {
		this.js = js;
	}

	public String getError() {
		return error;
	}

	public void setError(String error) {
		this.error = error;
	}

	public String getXml() {
		return xml;
	}

	public void setXml(String xml) {
		this.xml = xml;
	}

	public String getAnalyticum() {
		return analyticum;
	}

	public void setAnalyticum(String analyticum) {
		this.analyticum = analyticum;
	}

	public String getSyntheticum() {
		return syntheticum;
	}

	public void setSyntheticum(String syntheticum) {
		this.syntheticum = syntheticum;
	}

}