package com.kirunews.rpha.struts.form;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

/** 
 * MyEclipse Struts
 * Creation date: 12-28-2007
 * 
 * XDoclet definition:
 * @struts.form name="newVersionForm"
 */
public class NewVersionForm extends ActionForm {
	static final long serialVersionUID = 23134428L;

	private String poem;
	private String source;
	private String syntheticum;
	private String analyticum; 

	public String getAnalyticum() {
		return analyticum;
	}

	public void setAnalyticum(String analyticum) {
		this.analyticum = analyticum;
	}

	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}

	public String getPoem() {
		return poem;
	}

	public void setPoem(String poem) {
		this.poem = poem;
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

	public String getSyntheticum() {
		return syntheticum;
	}

	public void setSyntheticum(String syntheticum) {
		this.syntheticum = syntheticum;
	}
}