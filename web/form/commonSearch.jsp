<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
%><%@ taglib uri="http://jakarta.apache.org/struts/tags-bean"  prefix="bean"
%><%@ taglib uri="http://jakarta.apache.org/struts/tags-html"  prefix="html"
%><%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic"
%><html>
<head>
	<title>common search</title>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/form.css" />
<style type="text/css">
td {font-size: x-small; vertical-align: top;}
td span {display: none;}
td.fieldname {color: #666;}
legend {color: #666; background-color: #fff;}
a.dbnotyet {color: #666; background-color: #fff;}
div#help {overflow: auto; height: 200px;}
</style>
<script type="text/javascript">
	var actualID = null;
	var help = null;
	function show(id) {
		if(help == null) {
			help = document.getElementById("help");
		}
		if(actualID != null) {
			help.style.display  = "none";
		}
		if(actualID == null || (actualID != null && actualID.id != id)) {
			actualID = document.getElementById(id);
			if(actualID != null) {
				help.innerHTML = actualID.innerHTML;
				help.style.display = "block";
			}
		} else {
			alert("null");
			actualID = null;
		}
	}
</script>
</head>
<body>

<p>
	<a href="changeLocale.do?language=en">[English]</a>
	<a href="changeLocale.do?language=fr">[French]</a>
	<a href="changeLocale.do?language=gl">[Galego]</a>
	<a href="changeLocale.do?language=hu">[Hungarian]</a>
</p>

<h1>Federated Search of the European Poetical Databases</h1>

<html:form action="/commonSearch.do">
<table>
	<tr>
		<td width="50%">
			<table width="100%">
				<tr>
					<td width="200" class="fieldname">
						<bean:message key="app.rhymeScheme" />
					</td>
					<td width="200">
						<html:text property="rhymeScheme" />
						<a href="#" onclick="show('rhymeScheme-help');">[?]</a>
					</td>
					<td>
						<span id="rhymeScheme-help"><bean:message key="app.rhymeScheme.help" />
						</span>
					</td>
				</tr>
				<tr>
					<td width="200" class="fieldname">
						<bean:message key="app.metricalScheme" />
					</td>
					<td>
						<html:text property="metricalScheme" />
						<a href="#" onclick="show('metricalScheme-help');">[?]</a>
					</td>
					<td>
						<span id="metricalScheme-help">
							<bean:message key="app.metricalScheme.help" />
						</span>
					</td>
				</tr>
				<tr>
					<td width="200" class="fieldname">
						<bean:message key="app.gonicStructure" />
					</td>
					<td>
						<html:text property="gonicStructure" />
						<a href="#" onclick="show('gonicStructure-help');">[?]</a>
					</td>
					<td>
						<span id="gonicStructure-help">
							<bean:message key="app.gonicStructure.help" />
						</span>
					</td>
				</tr>
				<tr>
					<td width="200" class="fieldname">
						<bean:message key="app.refrain" />
					</td>
					<td>
						<html:text property="refrain" />
						<a href="#" onclick="show('refrain-help');">[?]</a>
					</td>
					<td>
						<span id="refrain-help">
							<bean:message key="app.refrain.help" />
						</span>
					</td>
				</tr>
				<tr>
					<td width="200" class="fieldname">
						<bean:message key="app.reference" />
					</td>
					<td>
						<html:text property="reference" />
						<a href="#" onclick="show('reference-help');">[?]</a>
					</td>
					<td>
						<span id="reference-help">
							<bean:message key="app.reference.help" />
						</span>
					</td>
				</tr>
				<tr>
					<td width="200" class="fieldname">
						<bean:message key="app.author" />
					</td>
					<td>
						<html:text property="author" />
						<a href="#" onclick="show('author-help');">[?]</a>
					</td>
					<td>
						<span id="author-help">
							<bean:message key="app.author.help" />
						</span>
					</td>
				</tr>
				<tr>
					<td width="200" class="fieldname">
						<bean:message key="app.incipit" />
					</td>
					<td>
						<html:text property="incipit" />
						<a href="#" onclick="show('incipit-help');">[?]</a>
					</td>
					<td>
						<span id="incipit-help">
							<bean:message key="app.incipit.help" />
						</span>
					</td>
				</tr>
				<tr>
					<td width="200" class="fieldname"><bean:message 
						key="app.source" /></td>
					<td><html:text property="source" />
						<a href="#" onclick="show('source-help');">[?]</a>
					</td>
					<td><span id="source-help"><bean:message 
						key="app.source.help" /></span>
					</td>
				</tr>
				<tr>
					<td width="200" class="fieldname"><bean:message 
						key="app.genre" /></td>
					<td><html:text property="genre" />
						<a href="#" onclick="show('genre-help');">[?]</a>
					</td>
					<td>
						<span id="genre-help"><bean:message 
						key="app.genre.help" /></span>
					</td>
				</tr>
				<tr>
								<td width="200" class="fieldname">
									<bean:message key="app.internalGenre" />
								</td>
								<td>
									<html:text property="internalGenre" />
									<a href="#" onclick="show('internalGenre-help');">[?]</a>
								</td>
								<td>
									<span id="internalGenre-help"><bean:message
											key="app.internalGenre.help" />
									</span>
								</td>
				</tr>
				<tr>
								<td width="200" class="fieldname">
									<bean:message key="app.externalGenre" />
								</td>
								<td>
									<html:text property="externalGenre" />
									<a href="#" onclick="show('externalGenre-help');">[?]</a>
								</td>
								<td>
									<span id="externalGenre-help"><bean:message
											key="app.externalGenre.help" />
									</span>
								</td>
				</tr>
				<tr>
								<td width="200" class="fieldname">
									<bean:message key="app.numberOfStanzas" />
								</td>
								<td>
									<html:text property="numberOfStanzas" />
									<a href="#" onclick="show('numberOfStanzas-help');">[?]</a>
								</td>
								<td>
									<span id="numberOfStanzas-help"><bean:message
											key="app.numberOfStanzas.help" />
									</span>
								</td>
				</tr>
				<tr>
								<td width="200" class="fieldname">
									<bean:message key="app.tornadas" />
								</td>
								<td>
									<html:text property="tornadas" />
									<a href="#" onclick="show('tornadas-help');">[?]</a>
								</td>
								<td>
									<span id="tornadas-help"><bean:message
											key="app.tornadas.help" />
									</span>
								</td>
				</tr>
				<tr>
								<td width="200" class="fieldname">
									<bean:message key="app.specialRhymes" />
								</td>
								<td>
									<html:text property="specialRhymes" />
									<a href="#" onclick="show('specialRhymes-help');">[?]</a>
								</td>
								<td>
									<span id="specialRhymes-help"><bean:message
											key="app.specialRhymes.help" />
									</span>
								</td>
				</tr>
				<tr>
								<td width="200" class="fieldname">
									<bean:message key="app.rhymes" />
								</td>
								<td>
									<html:text property="rhymes" />
									<a href="#" onclick="show('rhymes-help');">[?]</a>
								</td>
								<td>
									<span id="rhymes-help"><bean:message
											key="app.rhymes.help" />
									</span>
								</td>
				</tr>
				<tr>
					<td width="200" class="fieldname">
						<bean:message key="app.rhetoricalProcedures" />
					</td>
					<td>
						<html:text property="rhetoricalProcedures" />
						<a href="#" onclick="show('rhetoricalProcedures-help');">[?]</a>
					</td>
					<td>
						<span id="rhetoricalProcedures-help"><bean:message
							key="app.rhetoricalProcedures.help" />
						</span>
					</td>
				</tr>
			</table>
		</td>
		<td>
			<fieldset>
				<legend>Select databases</legend>
				<html:checkbox property="database" value="nouveaunaetebus">
					<a href="http://nouveaunaetebus.elte.hu" target="_blank">Le 
					Nouveau Naetebus - Répertoire des poèmes strophiques
					non-lyriques en langue française d'avant 1400</a>
				</html:checkbox><br />
				<html:checkbox property="database" value="rpha">
					<a href="http://tesuji.eu" target="_blank">Répertoire de la
					poésie hongroise ancienne</a>
				</html:checkbox><br />
				<html:checkbox property="database" value="rmnt">
					<a href="http://www.umr7023.cnrs.fr/spip.php?article247" 
					target="_blank">Répertoire métrique et bibliographique de la 
					poésie néo-troubadouresque des XIV-XVe siècles</a>
				</html:checkbox><br />
				<html:checkbox property="database" value="oxford">
					<a href="http://csm.mml.ox.ac.uk/" target="_blank"
					class="dbnotyet"> The Oxford Cantigas de Santa Maria
					database </a>
				</html:checkbox><br />
				<html:checkbox property="database" value="bedt">
					<a href="http://www.bedt.it" target="_blank" 
					class="dbnotyet">Bibliografia Elettronica dei Trovatori</a>
				</html:checkbox><br />
				<html:checkbox property="database" value="meddb">
					<a href="http://www.cirp.es/pls/bdo2/f?p=MEDDB2" target="_blank"
					class="dbnotyet"> MedDB: Base de datos da Lírica Profana
					Galego-Portuguesa </a>
				</html:checkbox><br />
			</fieldset>
						
			<fieldset>
				<legend>help</legend>
				<div id="help"></div>
			</fieldset>
				
			<html:submit>search</html:submit>
		</td>
	</tr>
</table>
</html:form>
</body>
</html>
