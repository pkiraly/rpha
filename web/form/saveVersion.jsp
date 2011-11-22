<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%@ 
taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %><%@ 
taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %><%@ 
taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" 
%><bean:define id="poem" name="saveVersionForm" property="poem" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <title>Változat mentése</title>
</head>
<body>
<logic:notEmpty name="saveVersionForm" property="error">
Hiba: <bean:write name="saveVersionForm" property="error"/>
</logic:notEmpty> 
<logic:empty name="saveVersionForm" property="error">
Sikeres mentés. <a href="<%= request.getContextPath() %>/id/<bean:write name="saveVersionForm" 
property="poem" />">vissza a vershez</a>
</logic:empty> 
</body>
</html>

