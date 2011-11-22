<%@ page language="java" pageEncoding="UTF-8" %><%@ 
taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %><%@ 
taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %><%@ 
taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" 
%><bean:define id="poem" name="editVersionForm" property="poem" 
/><bean:define id="source" name="editVersionForm" property="source" 
/><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <title>Versváltozat szerkesztése</title>
  <script type="text/javascript" src="<%=request.getContextPath() %>/js/form.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath() %>/js/ajax.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath() %>/js/util.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath() %>/js/formSource.js"></script>
  <script type="text/javascript">
var contextPath = "<%=request.getContextPath() %>";
var mode = "edit";
var formType = "version";
var bookId = "<bean:write name="editVersionForm" property="source" />";
// syntheticum analyticum
<bean:write name="editVersionForm" property="syntheticum" filter="false" />
<bean:write name="editVersionForm" property="analyticum" filter="false" />
  </script>
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/form.css" />
</head>
<body>

<p><a href="<%=request.getContextPath() %>/id/<%= poem %>">[vissza a vershez]</a></p>
<!-- 
<bean:write name="editVersionForm" property="xml" filter="false" />
 -->
<%@ include file="/form/versionForm.jsp" %>

</body>
</html>

