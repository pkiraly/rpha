package com.kirunews.rpha.struts.form;

public class Item {
	private String title;
	private String link;
	private String description;
	private String doctype;
	private String bookId;
	private String syntId;
	
	/**
	 * Creates a new item in the feed
	 * 
	 * @param title
	 *   The title of the item
	 * @param link
	 *   The URL of the item
	 * @param description
	 *   The actual content of the item
	 */
	public Item(String title, String link, String description) {
		this.title       = title;
		this.link        = link;
		this.description = description;
	}

	public Item(String title, String link, String description, String doctype, 
			String bookId, String syntId) {
		this.title       = title;
		this.link        = link;
		this.description = description;
		this.doctype     = doctype;
		this.bookId      = bookId;
		this.syntId      = syntId;
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

	public void setDoctype(String doctype) {
		this.doctype = doctype;
	}

	public String getDoctype() {
		return doctype;
	}

	public void setSyntId(String syntId) {
		this.syntId = syntId;
	}

	public String getSyntId() {
		return syntId;
	}

	public void setBookId(String bookId) {
		this.bookId = bookId;
	}

	public String getBookId() {
		return bookId;
	}
}
