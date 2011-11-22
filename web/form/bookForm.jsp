<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ 
taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %><%@ 
taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %><%@ 
taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<logic:empty name="id">
<form action="<%=request.getContextPath() %>/saveBook" 
	method="POST" name="versionForm" id="versionForm" 
	onsubmit="return saveData();">
</logic:empty>
<logic:notEmpty name="id">
<form action="<%=request.getContextPath() %>/saveBook/<%= id %>" 
	method="POST" name="versionForm" id="versionForm" 
	onsubmit="return saveData();">
</logic:notEmpty>

<input type="submit" value="mentés" />
<input type="button" value="törlés" onclick="callDelete();" />

<input type="hidden" name="id" value="<%= id %>"/>
<input type="hidden" name="xml" value=""/>

<h4>a forrás adatai</h4>
<!-- forrás adatok -->
<!-- típus -->
<%@ include file="/form/fields/v101.jsp" %>
<!-- sorszám -->
<%@ include file="/form/fields/v111.jsp" %>

<!-- szerző -->
<%@ include file="/form/fields/v112.jsp" %>
<!-- fordító -->
<%@ include file="/form/fields/v113.jsp" %>
<!-- új cím -->
<%@ include file="/form/fields/v121.jsp" %>
<!-- eredeti cím -->
<%@ include file="/form/fields/v122.jsp" %>
<!-- nyomtatási hely -->
<%@ include file="/form/fields/v131.jsp" %>
<!-- keletkezési idő -->
<%@ include file="/form/fields/v132.jsp" %>
<!-- nyomdász -->
<%@ include file="/form/fields/v133.jsp" %>
<!-- műfaj -->
<%@ include file="/form/fields/v141.jsp" %>
<!-- felekezet -->
<%@ include file="/form/fields/v142.jsp" %>
<!-- őrzési hely -->
<%@ include file="/form/fields/v151.jsp" %>
<!-- könyvtár -->
<%@ include file="/form/fields/v152.jsp" %>
<!-- gyűjtemény -->
<%@ include file="/form/fields/v153.jsp" %>
<!-- eredeti nyelv -->
<%@ include file="/form/fields/v154.jsp" %>
<!-- jelzet -->
<%@ include file="/form/fields/v155.jsp" %>
<!-- kötet megnevezése -->
<%@ include file="/form/fields/v156.jsp" %>
<!-- raktári jelzet -->
<%@ include file="/form/fields/v160.jsp" %>

<input type="submit" value="mentés" />
<input type="button" value="törlés" onclick="callDelete();" />
</form>

<div id="messages"></div>
