package com.kirunews.rpha.struts.form;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

import com.kirunews.rpha.util.Logging;

/** 
 * XDoclet definition:
 * @struts.form name="searchForm"
 */
public class SearchForm extends ActionForm {
	
	private static Logger logger = Logging.getLogger();

	public enum SearchTypes {
		LUCENE, NORMAL, LISTS
	}
	
	static final long serialVersionUID = 23134421L;

	/** values property */
	private String[] values;

	/** fields property */
	private String[] fields;
	
	private String xml;
	private String error;
	private String html;
	private String js;
	private String analizis;
	private String outputFormat = "html";
	private String id;
	private String recordType = "poem";
	private SearchTypes innerSearchType;
	private String searchType;
	private String query;
	private String searchFormID;
	private String action = "search";

	/*
	 * Generated Methods
	 */

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getOutputFormat() {
		return outputFormat;
	}

	public void setOutputFormat(String outputFormat) {
		this.outputFormat = outputFormat;
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
		/*
		try {
			request.setCharacterEncoding("utf-8");
		} catch(UnsupportedEncodingException e) {
			;
		}
		*/
	}

	/** 
	 * Returns the values.
	 * @return String[]
	 */
	public String[] getValues() {
		return values;
	}

	/** 
	 * Set the values.
	 * @param values The values to set
	 */
	public void setValues(String[] values) {
		this.values = values;
	}

	/** 
	 * Returns the fields.
	 * @return String[]
	 */
	public String[] getFields() {
		return fields;
	}

	/** 
	 * Set the fields.
	 * @param fields The fields to set
	 */
	public void setFields(String[] fields) {
		this.fields = fields;
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

	public String getHtml() {
		return html;
	}

	public void setHtml(String html) {
		this.html = html;
	}

	public String getJs() {
		return js;
	}

	public void setJs(String js) {
		this.js = js;
	}

	public String getAnalizis() {
		return analizis;
	}

	public void setAnalizis(String analizis) {
		this.analizis = analizis;
	}

	public String getRecordType() {
		return recordType;
	}

	public void setRecordType(String recordType) {
		this.recordType = recordType;
	}

	public SearchTypes getInnerSearchType() {
		if(innerSearchType != null)
			return innerSearchType;
		if(searchType != null) {
			try {
				return SearchTypes.valueOf(searchType);
			} catch(IllegalArgumentException e){
				logger.error("Illegal search type parameter: '" + searchType 
						+ "'. Restore to default. (" + e.getMessage() + ")");
			}
		}
		return SearchTypes.LISTS;
	}

	public void setInnerSearchType(SearchTypes innerSearchType) {
		this.innerSearchType = innerSearchType;
	}

	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchtype) {
		this.searchType = searchtype;
	}

	public String getQuery() {
		return query;
	}

	public void setQuery(String query) {
		this.query = query;
	}

	/**
	 * @param searchFormID the searchFormID to set
	 */
	public void setSearchFormID(String searchFormID) {
		this.searchFormID = searchFormID;
	}

	/**
	 * @return the searchFormID
	 */
	public String getSearchFormID() {
		return searchFormID;
	}

	/**
	 * @param action the action to set
	 */
	public void setAction(String action) {
		this.action = action;
	}

	/**
	 * @return the action
	 */
	public String getAction() {
		return action;
	}
}