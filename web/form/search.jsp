<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %> 
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<html>
<head>
<script type="text/javascript">
<bean:write property="js" name="searchForm" filter="false"/>
</script>
</head>
<body>
<bean:write property="html" name="searchForm" filter="false"/>
</body>
</html>
