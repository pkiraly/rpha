<%@ page language="java" pageEncoding="UTF-8" %><%@ 
taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %><%@ 
taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %><%@ 
taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" 
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>repert</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/rpha.css" />
    <script type="text/javascript">
<bean:write property="js" name="searchForm" filter="false"/>
    </script>
  </head>
<body>
<p class="nav">
	<strong>RPHA</strong> ::
	<a href="<%=request.getContextPath()%>/">[forrásjegyzék]</a> ::
	<a href="<%=request.getContextPath()%>/search/rpha5">[mezők szerinti keresés]</a> ::
	<a href="<%=request.getContextPath()%>/search/field">[összetett keresés]</a>
</p>

<h1>RPHA editor &mdash; 
<logic:notEmpty name="searchForm" property="id"><a href="<%=
request.getContextPath() 
%>/xml/<bean:write name="searchForm" property="id" />">[xml]</a></logic:notEmpty></h1>

<logic:empty name="searchForm" property="error" >
<bean:write property="html" name="searchForm" filter="false" />
<bean:write property="analizis" name="searchForm" filter="false" />
</logic:empty>
<logic:notEmpty name="searchForm" property="error" >
<bean:write name="searchForm" property="error" filter="false" />
</logic:notEmpty>

</body>
</html>
