package com.kirunews.rpha.struts.form;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

/** 
 * MyEclipse Struts
 * Creation date: 04-28-2009
 * 
 * XDoclet definition:
 * @struts.form name="openSearchForm"
 */
public class OpenSearchForm extends ActionForm {
	/**
	 * 
	 */
	private static final long serialVersionUID = -6103281324515212853L;

	/*
	 * Generated fields
	 */
	
	private String title;
	private String link;
	private String description;

	/** searchTerms property */
	private String searchTerms;
	
	/** the number of search results per page */
	private int count = 10;
	
	private int startIndex = 1;
	
	/** startPage property */
	private int startPage = 1;

	private String language;
	
	private String inputEncoding;
	
	private String outputEncoding;
	
	private List<Item> items;
	
	private int totalResults;

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

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getLink() {
		return link;
	}

	public void setLink(String link) {
		this.link = link;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	/** 
	 * Returns the startPage.
	 * @return int
	 */
	public int getStartPage() {
		return startPage;
	}

	/** 
	 * Set the startPage.
	 * @param startPage The startPage to set
	 */
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	/** 
	 * Returns the searchTerms.
	 * @return String
	 */
	public String getSearchTerms() {
		return searchTerms;
	}

	/** 
	 * Set the searchTerms.
	 * @param searchTerms The searchTerms to set
	 */
	public void setSearchTerms(String searchTerms) {
		this.searchTerms = searchTerms;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public int getStartIndex() {
		return startIndex;
	}

	public void setStartIndex(int startIndex) {
		this.startIndex = startIndex;
	}

	public String getLanguage() {
		return language;
	}

	public void setLanguage(String language) {
		this.language = language;
	}

	public String getInputEncoding() {
		return inputEncoding;
	}

	public void setInputEncoding(String inputEncoding) {
		this.inputEncoding = inputEncoding;
	}

	public String getOutputEncoding() {
		return outputEncoding;
	}

	public void setOutputEncoding(String outputEncoding) {
		this.outputEncoding = outputEncoding;
	}

	public int getTotalResults() {
		return totalResults;
	}

	public void setTotalResults(int totalResults) {
		this.totalResults = totalResults;
	}

	public List<Item> getItems() {
		return items;
	}

	public void setItems(List<Item> items) {
		this.items = items;
	}

	public void addItem(Item item) {
		if(items == null){
			items = new ArrayList<Item>();
		}
		items.add(item);
	}
}