<%@ page language="java" pageEncoding="UTF-8"
%><%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean"
%><%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"
%><%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic"
%><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Mezők szerinti keresés</title>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/rpha.css" />
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.cookie.js" ></script>
	
	<script type="text/javascript">
		var COOKIE_NAME = 'rpha';
		var COOKIE_OPTIONS = { path: '/', expires: 10 };
		
		$(document).ready(function(){
			var cache = [];
			var cookieStr = $.cookie(COOKIE_NAME);
			alert('on load: ' + cookieStr);
			if(cookieStr != null) {
				cache = cookieStr.split(',');
			}
			alert('on load: ' + cache.join('#'));
			
			for(var i=0, len=cache.length; i<len; i++) {
				var ID = cache[i];
				if(ID == null || ID == '') {
					continue;
				}
				alert(ID);
				$('#l-' + ID).toggleClass('it');
				$('#' + ID).toggleClass('hidden');
			}
		});
		
		function show(ID) {
			var rID = ID.substr(2);
			var cache = [];
			var cookieStr = $.cookie(COOKIE_NAME);
			if(cookieStr != null) {
				cache = cookieStr.split(',');
			}
			var obj = $('#' + ID.substr(2));
			
			$('#' + ID).toggleClass('it');
			obj.toggleClass('hidden');
			state = obj.hasClass('hidden');
			if(state == true) {
				if(jQuery.inArray(rID, cache) == -1) {
					cache.push(rID);
				}
			} else {
				if(jQuery.inArray(rID, cache) > -1) {
					cache = jQuery.grep(cache, function (a) { return a != rID; });
				}
			}
			cookieStr = cache.join(',');
			alert('show: ' + cookieStr);
			$.cookie(COOKIE_NAME, cookieStr, COOKIE_OPTIONS);
		}
	</script>
	<style type="text/css">
	h3 {
		margin-bottom: 0;
		font-size: 80%;
		font-weight: normal;
	}
	h3 a {
		font-weight: bold;
		font-size: 120%;
	}
	.hidden {
		display: none;
	}
	.it {
		color: green;
	}
	</style>
</head>
<body>
<p class="nav">
	<strong>RPHA</strong> ::
	<a href="<%=request.getContextPath()%>/">[forrásjegyzék]</a>
	::
	<a href="<%=request.getContextPath()%>/search/field">[összetett keresés]</a>
</p>

<h1>mező szerinti keresés</h1>

<div style="float: right; width: 200px;">
<strong>kereshető mezők ki/be kapcsolása</strong><br/>
<a id="l-rpha" href="#" onclick="show(this.id);">rpha</a>, 
<a id="l-aut" href="#" onclick="show(this.id);">szerző</a>, 
<a id="l-inc" href="#" onclick="show(this.id);">incipit</a>, 
<a id="l-titre" href="#" onclick="show(this.id);">cím</a>, 
<a id="l-acr" href="#" onclick="show(this.id);">akrostichon</a>, 
<a id="l-chans" href="#" onclick="show(this.id);">énekelt?</a>, 
<a id="l-signe" href="#" onclick="show(this.id);">szignáltság</a>, 
<a id="l-inte" href="#" onclick="show(this.id);">teljes</a>, 
<a id="l-lon" href="#" onclick="show(this.id);">terjedelem</a>, 
<a id="l-colo" href="#" onclick="show(this.id);">kolofon</a>, 
<a id="l-rime" href="#" onclick="show(this.id);">rímképlet</a>, 
<a id="l-syll" href="#" onclick="show(this.id);">szótagszám</a>, 
<a id="l-typme" href="#" onclick="show(this.id);">metrumtípus</a>, 
<a id="l-metr" href="#" onclick="show(this.id);">metrum</a>, 
<a id="l-refren" href="#" onclick="show(this.id);">refrénszerkezet</a>, 
<a id="l-genre" href="#" onclick="show(this.id);">műfaj</a>, 
<a id="l-an" href="#" onclick="show(this.id);">évszám</a>, 
<a id="l-comment" href="#" onclick="show(this.id);">megjegyzés</a>, 
<a id="l-relse" href="#" onclick="show(this.id);">felekezetek</a>, 
<a id="l-ord" href="#" onclick="show(this.id);">rendezés</a> 
</div>
<html:form action="/multifieldSearch" method="GET">
<table>
	<tr id="rpha">
		<td>RPHA azonosító szám</td>
		<td>
			<html:text property="rpha"/><html:errors property="rpha"/>
		</td>
	</tr>
	<tr id="aut">
		<td>szerző vezeték és keresztneve</td>
		<td>
			<html:text property="aut1"/><html:errors property="aut1"/>
			<html:text property="aut2"/><html:errors property="aut2"/>
		</td>
	</tr>
	<tr id="inc">
		<td>incipit</td>
		<td><html:text property="inc"/><html:errors property="inc"/></td>
	</tr>
	<tr id="titre">
		<td>cím+</td>
		<td><html:text property="titre"/><html:errors property="titre"/></td>
	</tr>
	<tr id="acr">
		<td>akrostichon</td>
		<td>
			<html:select property="acr">
				<option value="">--</option>
				<bean:define id="acrValues" name="multifieldSearchForm" property="acrValues"/>
				<html:options collection="acrValues" property="key" labelProperty="value" />
			</html:select>
			<html:errors property="acr"/>
			<html:text property="acrost"/><html:errors property="acrost"/>
		</td>
	</tr>
	<tr id="chans">
		<td>énekelt vers vagy szövegvers?</td>
		<td>
			<html:select property="chans">
				<option value="">--</option>
				<bean:define id="chansValues" name="multifieldSearchForm" property="chansValues"/>
				<html:options collection="chansValues" property="key" labelProperty="value" />
			</html:select>
			<html:errors property="chans"/>
		</td>
	</tr>
	<tr id="signe">
		<td>szignáltság</td>
		<td>
			<html:select property="signe">
				<option value="">--</option>
				<bean:define id="signeValues" name="multifieldSearchForm" property="signeValues"/>
				<html:options collection="signeValues" property="key" labelProperty="value" />
			</html:select>
			<html:errors property="signe"/>
		</td>
	</tr>
	<tr id="inte">
		<td>teljes-e a vers szövege?</td>
		<td>
			<html:select property="inte">
				<option value="">--</option>
				<bean:define id="intValues" name="multifieldSearchForm" property="intValues"/>
				<html:options collection="intValues" property="key" labelProperty="value" />
			</html:select>
			<html:errors property="inte"/>
		</td>
	</tr>
	<tr id="lon">
		<td>terjedelem</td>
		<td>
			<html:text property="lon"/><html:errors property="lon"/>
			<html:select property="pre">
				<option value="">--</option>
				<bean:define id="preValues" name="multifieldSearchForm" property="preValues"/>
				<html:options collection="preValues" property="key" labelProperty="value" />
			</html:select>
			<html:errors property="colo"/>
		</td>
	</tr>
	<tr id="colo">
		<td>kolofon</td>
		<td>
			<html:select property="colo">
				<option value="">--</option>
				<bean:define id="coloValues" name="multifieldSearchForm" property="coloValues"/>
				<html:options collection="coloValues" property="key" labelProperty="value" />
			</html:select>
			<html:errors property="colo"/>
			<html:text property="doncolo"/><html:errors property="doncolo"/>
		</td>
	</tr>
	<tr id="rime">
		<td>rímképlet</td>
		<td>
			<html:text property="rime"/><html:errors property="rime"/>
		</td>
	</tr>
	<tr id="syll">
		<td>szótagszám</td>
		<td>
			<html:text property="syll"/><html:errors property="syll"/>
		</td>
	</tr>
	<tr id="typme">
		<td>metrumtípus</td>
		<td>
			<html:select property="typme">
				<option value="">--</option>
				<bean:define id="typmeValues" name="multifieldSearchForm" property="typmeValues"/>
				<html:options collection="typmeValues" property="key" labelProperty="value" />
			</html:select>
			<html:errors property="typme"/>
			
		</td>
	</tr>
	<tr id="metr">
		<td>metrum</td>
		<td><html:text property="metr"/><html:errors property="metr"/></td>
	</tr>
	<tr id="refren">
		<td>refrénszerkezet</td>
		<td>
			<html:select property="refren">
				<option value="">--</option>
				<bean:define id="refrenValues" name="multifieldSearchForm" property="refrenValues"/>
				<html:options collection="refrenValues" property="key" labelProperty="value" />
			</html:select>
			<html:errors property="refren"/>
		</td>
	</tr>
	<tr valign="top" id="genre">
		<td>műfaj</td>
		<td>
			<html:text property="genre1"/><html:errors property="genre1"/><br/>
			<html:text property="genre2"/><html:errors property="genre2"/>
		</td>
	</tr>
	<tr id="an">
		<td>évszám</td>
		<td>
			<html:text property="an"/><html:errors property="an"/>
			<html:checkbox property="prec"/>pontosan 
			<html:errors property="prec"/>
		</td>
	</tr>
	<tr id="comment">
		<td>megjegyzés</td>
		<td><html:text property="comment"/><html:errors property="comment"/></td>
	</tr>
	<tr valign="top" id="relse">
		<td>felekezeti megoszlás</td>
		<td>
			<html:select property="relse1Type">
				<option value="">--</option>
				<bean:define id="relseValues" name="multifieldSearchForm" property="relseValues"/>
				<html:options collection="relseValues" property="key" labelProperty="value" />
			</html:select>
			<html:errors property="relse1Type"/>
			<html:text property="relse1"/><html:errors property="relse1"/><br/>
			
			<html:select property="relse2Type">
				<option value="">--</option>
				<bean:define id="relseValues" name="multifieldSearchForm" property="relseValues"/>
				<html:options collection="relseValues" property="key" labelProperty="value" />
			</html:select>
			<html:errors property="relse2Type"/>
			<html:text property="relse2"/><html:errors property="relse2"/><br/>

			<html:select property="relse3Type">
				<option value="">--</option>
				<bean:define id="relseValues" name="multifieldSearchForm" property="relseValues"/>
				<html:options collection="relseValues" property="key" labelProperty="value" />
			</html:select>
			<html:errors property="relse3Type"/>
			<html:text property="relse3"/><html:errors property="relse3"/><br/>
		</td>
	</tr>
	<tr id="ord">
		<td>rendezés</td>
		<td>
			<html:text property="ordering_field"/><html:errors property="ordering_field"/>
			<html:select property="ordering_type">
				<bean:define id="ordering_types" name="multifieldSearchForm" property="ordering_types"/>
				<html:options collection="ordering_types" property="key" labelProperty="value" />
			</html:select>
			<html:errors property="ordering_type"/>
		</td>
	</tr>
	<tr>
		<td></td>
		<td>
			<html:submit/>
			<html:cancel/>
		</td>
	</tr>
</table>
<bean:write name="multifieldSearchForm" property="formState" filter="false"/><br/>
<logic:notEmpty name="multifieldSearchForm" property="links">
	<p class="nav">
		<bean:write name="multifieldSearchForm" property="links" filter="false"/>
	</p>
</logic:notEmpty>

<!-- bean:write name="multifieldSearchForm" property="queryString" filter="false"/><br/- -->
<bean:write name="multifieldSearchForm" property="resultList" filter="false"/>

<logic:notEmpty name="multifieldSearchForm" property="links">
	<p class="nav">
		<bean:write name="multifieldSearchForm" property="links" filter="false"/>
	</p>
</logic:notEmpty>
</html:form>
</body>
</html>

