<%@ page language="java" pageEncoding="UTF-8" %><%@ 
taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %><%@ 
taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %><%@ 
taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" 
%><bean:define id="id" name="editBookForm" property="id"
/><bean:define id="PATH" value="<%= request.getContextPath() %>" 
/><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <title>Versváltozat szerkesztése</title>
  <script type="text/javascript" src="<%=PATH%>/js/form.js"></script>
  <script type="text/javascript" src="<%=PATH%>/js/ajax.js"></script>
  <script type="text/javascript" src="<%=PATH%>/js/util.js"></script>
  <script type="text/javascript" src="<%=PATH%>/js/formSource.js"></script>
  <script type="text/javascript">
var contextPath = "<%=PATH%>";
var mode = "edit";
var formType = "book";
<bean:write name="editBookForm" property="js" filter="none"/>
// syntheticum analyticum
  </script>
  <link rel="stylesheet" type="text/css" href="<%=PATH%>/css/form.css" />
</head>
<body>

<p><a href="<%=PATH%>/id/">[vissza a vershez]</a></p>
<!-- bean:write name="editBookForm" property="xml" /-->

<%@ include file="/form/bookForm.jsp" %>

</body>
</html>
