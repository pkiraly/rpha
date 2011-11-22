<%@ page language="java" pageEncoding="UTF-8" contentType="text/xml; charset=utf-8"
%><%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean"
%><%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"
%><%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic"
%><?xml version="1.0" encoding="UTF-8"?>
<!-- application/rss+xml -->
<rss version="2.0" xmlns:opensearch="http://a9.com/-/spec/opensearch/1.1/" xmlns:atom="http://www.w3.org/2005/Atom">
<channel>
	<title><bean:write name="openSearchForm" property="title" /></title>
	<link><bean:write name="openSearchForm" property="link" /></link>
	<description><bean:write name="openSearchForm" property="description" /></description>
	<opensearch:totalResults><bean:write name="openSearchForm" property="totalResults" /></opensearch:totalResults>
	<opensearch:startIndex><bean:write name="openSearchForm" property="startIndex" /></opensearch:startIndex>
	<opensearch:itemsPerPage><bean:write name="openSearchForm" property="count" /></opensearch:itemsPerPage>
	<atom:link rel="search" type="application/opensearchdescription+xml" href="http://tesuji.eu/rpha/opensearchdescription.xml"/>
	<opensearch:Query role="request" searchTerms="<bean:write name="openSearchForm" property="searchTerms" />" 
		startPage="<bean:write name="openSearchForm" property="startPage" />" />
<logic:notEmpty name="openSearchForm" property="items"
><logic:iterate id="item" name="openSearchForm" property="items"
>	<item>
		<title><bean:write name="item" property="title" /></title>
		<link><bean:write name="item" property="link" /></link>
		<description><bean:write name="item" property="description" filter="false"/></description>
	</item>
</logic:iterate
></logic:notEmpty>
</channel>
</rss>

