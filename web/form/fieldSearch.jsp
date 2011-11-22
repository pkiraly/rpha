<%@ page language="java" pageEncoding="UTF-8"
%><%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean"
%><%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"
%><%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic"
%><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html> 
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Mezők szerinti keresés</title>
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.js"></script>
<script type="text/javascript">
var BASE_URL = "<%=request.getContextPath() %>";
$(document).ready(function() {
	$("select[name=fields]").change(function() {
		id = this.id.substring(5);
		fieldName = this.options[this.selectedIndex].value;
		
		if(!fieldName.match(/^v(1[18]|2[234]|3[03]|4[134]|164)$/)) {
			$('#td' + id).html('<input type="text" name="values" />');
			return;
		}
		url = BASE_URL + '/form/fields/options/' + fieldName + '.txt';
		$.get(url, null, function(xml) {
			html = '<select name="values" style="width: 200px;">';
			html += xml;
			html += '</select>';
			$('#td' + id).html(html);
		});
	});
});
</script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/rpha.css" />
<style type="text/css">
	h3 {
		margin-top: 10px;
		margin-bottom: 0;
		font-size: 80%;
		font-weight: normal;
	}
	h3 a {
		font-weight: bold;
		font-size: 120%;
	}
</style>
</head>
<body>

<p class="nav">
	<strong>RPHA</strong> ::
	<a href="<%=request.getContextPath()%>/">[forrásjegyzék]</a>
	::
	<a href="<%=request.getContextPath()%>/search/rpha5">[mező szerinti keresés]</a>
</p>

<h1>összetett keresés</h1>

<html:form action="/fieldSearch" method="GET">
<table>
	<tr>
		<td><html:submit value="keresés" /></td>
		<td>
			<html:select property="fields" styleId="field1">
				<logic:iterate id="field" name="fieldSearchForm" property="fieldNames" 
					type="java.lang.String[]"
				><option value="<%= field[0] %>"><%= field[1] %></option></logic:iterate>
			</html:select>
		</td>
		<td id="td1">
			<input type="text" name="values" id="value1" />
		</td>
	</tr>
	<tr>
		<td>
			<html:select property="operators">
				<bean:define id="operator" name="fieldSearchForm" property="operatorValues"/>
				<html:options collection="operator" property="key" labelProperty="value" filter="false" />
			</html:select>
		</td>
		<td>
			<html:select property="fields" styleId="field2">
				<logic:iterate id="field" name="fieldSearchForm" property="fieldNames" 
					type="java.lang.String[]"
				><option value="<%= field[0] %>"><%= field[1] %></option></logic:iterate>
			</html:select>
		</td>
		<td id="td2">
			<input type="text" name="values" id="value2" />
		</td>
	</tr>
	<tr>
		<td>
			<html:select property="operators">
				<bean:define id="operator" name="fieldSearchForm" property="operatorValues"/>
				<html:options collection="operator" property="key" labelProperty="value" />
			</html:select>
		</td>
		<td>
			<html:select property="fields" styleId="field3">
				<logic:iterate id="field" name="fieldSearchForm" property="fieldNames" 
					type="java.lang.String[]"
				><option value="<%= field[0] %>"><%= field[1] %></option></logic:iterate>
			</html:select>
		</td>
		<td id="td3">
			<input type="text" name="values"id="value3" />
		</td>
	</tr>
	<tr>
		<td>
			<html:select property="operators">
				<bean:define id="operator" name="fieldSearchForm" property="operatorValues"/>
				<html:options collection="operator" property="key" labelProperty="value" />
			</html:select>
		</td>
		<td>
			<html:select property="fields" styleId="field4">
				<logic:iterate id="field" name="fieldSearchForm" property="fieldNames" 
					type="java.lang.String[]"
				><option value="<%= field[0] %>"><%= field[1] %></option></logic:iterate>
			</html:select>
		</td>
		<td id="td4">
			<input type="text" name="values" id="value4" />
		</td>
	</tr>
	<tr>
		<td>
			<html:select property="operators">
				<bean:define id="operator" name="fieldSearchForm" property="operatorValues"/>
				<html:options collection="operator" property="key" labelProperty="value" />
			</html:select>
		</td>
		<td>
			<html:select property="fields" styleId="field5">
				<logic:iterate id="field" name="fieldSearchForm" property="fieldNames" 
					type="java.lang.String[]"
				><option value="<%= field[0] %>"><%= field[1] %></option></logic:iterate>
			</html:select>
		</td>
		<td id="td5">
			<input type="text" name="values" id="value5" />
		</td>
	</tr>
</table>

</html:form>

<bean:write name="fieldSearchForm" property="message"    filter="false" />
<logic:notEmpty name="fieldSearchForm" property="links">
	<p class="nav">
		<bean:write name="fieldSearchForm" property="links" filter="false"/>
	</p>
</logic:notEmpty>

<bean:write name="fieldSearchForm" property="resultList" filter="false" />

<logic:notEmpty name="fieldSearchForm" property="links">
	<p class="nav">
		<bean:write name="fieldSearchForm" property="links" filter="false"/>
	</p>
</logic:notEmpty>

</body>
</html>

