<%@ page language="java" pageEncoding="UTF-8" %><%@ 
taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %><%@ 
taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %><%@ 
taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" 
%><bean:define id="PATH" value="<%= request.getContextPath() %>" /><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<logic:notEmpty name="listBooksForm" property="type">
	<meta http-equiv="Cache-Control" content="max-age=0" />
	<meta http-equiv="Cache-Control" content="no-cache" />
	<meta http-equiv="expires" content="0" />
	<meta http-equiv="Expires" content="Tue, 01 Jan 1980 1:00:00 GMT" />
	<meta http-equiv="Pragma" content="no-cache" />
</logic:notEmpty>
    <title>Az adatbázisban szereplő források jegyzéke</title>
    <link rel="stylesheet" type="text/css" href="<%= PATH %>/css/rpha.css" />
  </head>
<body>

<p class="nav">
	<strong>RPHA</strong> ::
	<a href="<%=request.getContextPath()%>/">[forrásjegyzék]</a> ::
	<a href="<%=request.getContextPath()%>/search/rpha5">[mező szerinti keresés]</a> ::
	<a href="<%=request.getContextPath()%>/search/field">[összetett keresés]</a>
</p>

<logic:empty name="listBooksForm" property="type">
<h1>Az adatbázisban szereplő források jegyzéke</h1>
</logic:empty>

<ul type="square">
<bean:write name="listBooksForm" property="html" filter="false" />
</ul>

<a href="<%= PATH %>/newbook">új forrás felvétele</a>
</body>
</html>