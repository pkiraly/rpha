<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ 
taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %><%@ 
taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %><%@ 
taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" 
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html:html>
<head>
	<meta http-equiv="contentType" content="text/html; charset=UTF-8" />
	<meta http-equiv="pragma" content="no-cache" />
	<meta http-equiv="cache-control" content="no-cache" />
	<meta http-equiv="expires" content="0" />
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
	<meta http-equiv="description" content="RPHA keresőkérdés-szerkesztő" />
	<title>RPHA keresőkérdés-szerkesztő</title>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
</head>
<body>
<h1>RPHA keresőkérdés szerkesztő</h1>
<html:form action="/search.do" method="GET">
	<html:hidden property="searchType"   value="LUCENE" />
	<html:hidden property="outputFormat" value="xml" />
	<html:hidden property="action"       value="search" />
	<html:hidden property="recordType"   value="poem" />
	<html:textarea property="query" rows="10" cols="40" value="v5_s1:Pesti NOT v5_s2:Gábor"></html:textarea><br/>
	<html:submit>Submit</html:submit>
</html:form>

</body>
</html:html>
