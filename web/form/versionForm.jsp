<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ 
taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %><%@ 
taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %><%@ 
taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<form action="<%=request.getContextPath() %>/saveversion/<%= poem %>/<%= source %>" 
	method="POST" name="versionForm" id="versionForm" 
	onsubmit="return saveData();">

<input type="submit" value="mentés" />
<input type="button" value="törlés" onclick="callDelete();" />

<input type="hidden" name="poem" value="<%= poem %>"/>
<input type="hidden" name="source" value="<%= source %>"/>
<input type="hidden" name="xml" value=""/>

<h4>a forrás adatai</h4>
<!-- forrás adatok -->
<%@ include file="/form/fields/v-source.jsp" %>

<h4>a változat adatai</h4>
<!-- [kezdősor] -->
<%@ include file="/form/fields/v002.jsp" %>
<!-- [főcím] -->
<%@ include file="/form/fields/v167.jsp" %>
<!-- [élőfej] -->
<%@ include file="/form/fields/v166.jsp" %>
<!-- [cím] -->
<%@ include file="/form/fields/v003.jsp" %>
<!-- [szerző] -->
<%@ include file="/form/fields/v005.jsp" %>
<!-- [irodalmi minta] -->
<%@ include file="/form/fields/v011.jsp" %>

<!-- TODO: v12 minta kezdősora -->
<!-- TODO: v13 minta címe -->
<!-- TODO: v14 himnusz utalószáma -->
<!-- TODO: v15 minta szerzője -->

<!-- eredeti nyelv -->
<%@ include file="/form/fields/v018.jsp" %>
<!-- szerezt. ideje -->
<%@ include file="/form/fields/v021-v022.jsp" %>
<!-- ének/szöveg? -->
<%@ include file="/form/fields/v023.jsp" %>
<!-- szignáltság? -->
<%@ include file="/form/fields/v024.jsp" %>

<!-- TODO: v28 műfaj-lista -->

<!-- kolofon? -->
<%@ include file="/form/fields/v030.jsp" %>
<!-- kolofon -->
<%@ include file="/form/fields/v032.jsp" %>
<!-- ajánlás -->
<%@ include file="/form/fields/v031.jsp" %>
<!-- akrosztikon? -->
<%@ include file="/form/fields/v033.jsp" %>
<!-- akrosztikon -->
<%@ include file="/form/fields/v034.jsp" %>
<!-- akrosztikon adatai -->
<%@ include file="/form/fields/v035.jsp" %>
<!-- megjegyzések -->
<%@ include file="/form/fields/v039.jsp" %>
<!-- teljes-e? -->
<%@ include file="/form/fields/v041.jsp" %>
<!-- terjedelem, terjedelem mértékegysége -->
<%@ include file="/form/fields/v042-v043.jsp" %>
<!-- metrum típus -->
<%@ include file="/form/fields/v044.jsp" %>
<!-- metrum -->
<%@ include file="/form/fields/v045.jsp" %>
<!-- rímképlet -->
<%@ include file="/form/fields/v046.jsp" %>
<!-- szótagszám -->
<%@ include file="/form/fields/v047.jsp" %>
<!-- felekezet -->
<%@ include file="/form/fields/v048.jsp" %>
<!-- refrénszerkezete -->
<%@ include file="/form/fields/v163.jsp" %>
<!-- echós-e? -->
<%@ include file="/form/fields/v164.jsp" %>
<!-- nótajelzés -->
<%@ include file="/form/fields/v061.jsp" %>
<!-- nótajelzésként használó versek -->
<%@ include file="/form/fields/v065.jsp" %>
<!-- rész/egész hivatkozása -->
<%@ include file="/form/fields/v161.jsp" %>
<!-- vers-hivatkozása -->
<%@ include file="/form/fields/v162.jsp" %>
<!-- belső hivatkozás -->
<%@ include file="/form/fields/v165.jsp" %>
<!-- műfaj -->
<%@ include file="/form/fields/v056-mufaj.jsp" %>

<input type="submit" value="mentés" />
<input type="button" value="törlés" onclick="callDelete();" />
</form>

<div id="messages"></div>
