var currentId;
var currentValue;
var currentFieldId;
var currentV61;
var currentV61Value = null;
var timeouted = false;
var CurrentOffset = 0;
// var oBookTypeNode = null;
var oForm = null;

var v43 = {
	1: "versszak", 
	2: "sor", 
	3: "bekezdés"
};

var v22 = {
	1: "pontosan", 
	2: "nem később, mint", 
	3: "nem korábban, mint", 
	4: "kb.", 
	5: "korábban, mint kb.", 
	6: "x és y között", 
	7: "vagy"
};

window.onload = function(){
	fillInputsFromXML();
	this.oForm = document.getElementById("versionForm");
	Source.disablePlusMinusLinks();
	Source.parseJSON();
}

function callDelete() {
	if(formType == "book") {
		oForm.action = oForm.action.replace(/saveBook/, "deletebook");
	} else {
		oForm.action = oForm.action.replace(/saveversion/, "deleteversion");
	}
	oForm.onsubmit = function() {};
	oForm.submit();
}

function fillInputsFromXML() {
	if(typeof analyticum == "undefined") {
		return;
	}
	var text = "";
	var oDiv = document.getElementById("messages");
	for(var fieldName in analyticum) {
		if(!fieldName.match(/^v(91|200|201)$/)) {
			var stdNodeId = (fieldName == "v22") ? "v21" 
						: (fieldName == "v43") ? "v42"
						: fieldName;
			var fieldCounter = 1;
			
			// ismétlődő mezők kezelése: ha több van, a másodiknál létre kell
			// hozni az űrlapot
			var isRepeatingField = false;
			if(typeof analyticum[fieldName] == "object" 
				&& typeof analyticum[fieldName].length == "number") 
			{
				isRepeatingField = true;
				var len = analyticum[fieldName].length;
				var oTr, oLinkEl;
				for(var i=1; i<len; i+=1) {
					oTr = document.getElementById(stdNodeId + "-" + i);
					oLinkEl = oTr.getElementsByTagName("TD")[1]
								.getElementsByTagName("A")[1];
					addInputField(oLinkEl);
				}
			}

			var data = new Array();
			if(isRepeatingField == false) {
				data[0] = analyticum[fieldName];
			} else {
				data = analyticum[fieldName];
			}
			
			var len = data.length;
			for(var i=0; i<len; i+=1) {
				var nodeId = stdNodeId + "-" + (i+1);
				if(typeof data[i] == "string") {
					var currentFieldId = (fieldName == "v61") 
										? fieldName + "-" + fieldCounter
										: fieldName;
					oDiv.innerHTML = '<span id="value-' + currentFieldId 
								+ '" style="display: none;">' 
								+ data[i]
								+ "</span>";
					if(fieldName == "v61") {
						oDiv.innerHTML += '<span id="inc-' + currentFieldId 
								+ '" style="display: none;"></span>';
					};
					insertFromXML(nodeId, currentFieldId)
					text += fieldName + ": " + data[i] + "\n";
				} else {
					for(subfield in data[i]) {
						var currentFieldId = fieldName + subfield;
						if(subfield == "value") {
							oDiv.innerHTML = '<span id="value-' + fieldName + '">' 
							+ data[i][subfield] + '</span>';
							insertFromXML(nodeId, fieldName);
						} else {
							oDiv.innerHTML = '<span id="value-' + currentFieldId + '">' 
								+ data[i][subfield] + '</span>';
							insertFromXML(nodeId, currentFieldId);
						}
						text += currentFieldId + ": " + data[i][subfield] + "\n";
					}
				}
			}
		}
	}
	oDiv.innerHTML = '';
}

function handleIncipit(response) {
	var data = eval('('+response+')');
	var text = "";
	var matches = this.currentV61.match(/^(v\d+)-(\d+)/);
	var field = matches[1];
	for(i in data) {
		text += '<a href="#"'
			+ ' onclick="'
			+ 'return insertFromXML(\'' + this.currentV61 + "', '" 
			+ field + "-" + i + "');\">" 
			+ '<span id="value-' + field + '-' + i + '">' + data[i][1] + "</span></a> " 
			+ '<span id="inc-' + field + '-' + i + '">' + data[i][0] + "</span><br/>";
	}
	showMessage(text);
}

function handleBookList(response) {
	showMessage(response);
}

function v61onKeyUp(oInput) {
	if(this.timeouted == false 
		&& oInput.value != "" 
		&& this.currentV61Value != oInput.value)
	{
		this.currentV61Value = oInput.value;
		this.timeouted = true;
		setTimeout(function(){v61updateValues(oInput.parentNode.parentNode.id);}, 1000);
	}
}

function v61updateValues(id) {
	var oTr = document.getElementById(id);
	var oLinkEl = oTr.getElementsByTagName("TD")[1].getElementsByTagName("A")[0];
	getFromXML(oLinkEl);
	this.timeouted = false;
}

function getFromXML(oLinkEl) {
	setCurrentOffset(oLinkEl);
	var id = oLinkEl.parentNode.parentNode.id;
	this.currentId = id;
	
	var matches = id.match(/^(v\d+)-(\d+)/);
	var fieldId;
	if(matches) {
		fieldId = matches[1];
	} else {
		matches = id.match(/^(v50-.+?)-\d+$/);
		if(matches)
			fieldId = matches[1];
		else
			return false;
	}
	if(fieldId == "v61" || fieldId == "v65" || fieldId == "v161" 
		|| fieldId == "v162" || fieldId == "v165") 
	{
		var oTr = oLinkEl.parentNode.parentNode;
		var sInc = oTr.getElementsByTagName("INPUT")[0].value;
		if(sInc == "") {
			alert("Az incipit-lista előállításához szükséges egy szót beírnia");
			return false;
		} else {
			var sUrl = contextPath + "/inc/" + sInc;
			this.currentV61 = id;
			Ajax.handleAjax(sUrl, handleIncipit);
		}
		return false;
	} else if(fieldId == "v50-bookid") {
		return Source.showBookList();
	}
	
	this.currentFieldId = fieldId;
	if(typeof syntheticum != "undefined" && syntheticum[fieldId]) {
		var field = syntheticum[fieldId];
		if(typeof field == "string") {
			if(fieldId == 'v42') {
				var js = [
					"insertFromXML('" + id + "', '" + fieldId + "');",
					"return insertFromXML('" + id + "', 'v43');"
				];
					
				var text = '<a href="#" onclick="' + js[0] + '">[OK]</a> ' 
						+ 'terjedelem = <span id="value-' + fieldId + '">' + field + '</span><br/>';
				text += '<a href="#" onclick="' + js[1] + '">[OK]</a> ' 
						+ 'mértékegység = <span id="value-v43" style="display: none">' + syntheticum['v43'] + '</span>' + v43[syntheticum['v43']] + '<br/>';

				text += '<a href="#" onclick="' + js.join('') + '">[OK]</a> mindkettő<br/>'; 
				showMessage(text);
			}
			else if(fieldId == 'v21') {
				var js = [
					"insertFromXML('" + id + "', '" + fieldId + "');",
					"return insertFromXML('" + id + "', 'v22');"
				];
				
				var text = '<a href="#" onclick="' + js[0] + '">[OK]</a> ' 
						+ '<span id="value-' + fieldId + '">' + field + '</span><br/>';
				text += '<a href="#" onclick="' + js[1] + '">[OK]</a> ' 
						+ '<span id="value-v22" style="display: none">' + syntheticum['v22'] + '</span>' + v22[syntheticum['v22']] + '<br/>';

				text += '<a href="#" onclick="' + js.join('') + '">[OK]</a> mindkettő<br/>'; 
				showMessage(text);
			} else {
				showMessage('<a href="#"'
					+ ' onclick="return insertFromXML(\'' + id + "', '" + fieldId + '\');">'
					+ '[OK]</a> ' 
					+ '<span id="value-' + fieldId + '">' + field + '</span>');
			}
		}
		else {
			var text = "";
			var js = new Array();
			var j = 0;
			for(i in field) {
				js[j] = "return insertFromXML('" + id + "', '" + fieldId + i + "');";
				text += '<a href="#" onclick="' + js[j] + '">[OK]</a> '
						+ i + " = " 
						+ '<span id="value-' + fieldId + i + '">' + field[i] + '</span>' 
						+ "<br/>";
				j+=1;
			}
			text += '<a href="#" onclick="' + js.join('') + '">[OK]</a> mind<br/>'; 
			showMessage(text);
		}
	} else {
		showAlert("A szintetikus rekordban nincs erre vonatkozó adat!");
	}
	return false;
}

function insertFromXML(nodeId, currentFieldId) {
	var oNode = document.getElementById(nodeId);
	if(oNode == null) {
		if(nodeId != 'v51-1' && nodeId != 'v52-1')
			alert("no node with this id: " + nodeId);
		return;
	}
	var oCurrentValue = document.getElementById('value-' + currentFieldId);
	var currentValue = "";
	if(oCurrentValue != null) {
		currentValue = oCurrentValue.innerHTML;
	} else {
		alert("no value with this id: value-" + currentFieldId);
		return;
	}
	
	// selection lists
	if(currentFieldId.match(/^(v11|v18|v22|v23|v24|v30|v33|v41|v43|v44)$/) ) {
		var oSel = oNode.getElementsByTagName('SELECT')[0];
		for(var i=0; i<oSel.length; i+=1) {
			if(oSel[i].value == currentValue) {
				oSel.selectedIndex = i;
				break;
			}
		}
	}

	else if(currentFieldId.match(/^v(61|65|161|162|165)-/)){
		var inputs = oNode.getElementsByTagName('INPUT');
		var inc = document.getElementById('inc-' + currentFieldId).innerHTML;
		var matches = currentFieldId.match(/^(v\d+)-(\d+)/);
		currentFieldId = matches[1]; //"v61";
		for(var i = 0; i<inputs.length; i+=1) {
			if((currentFieldId == "v61" && inputs[i].name.match(/v61s[13]\[\]/)) 
				|| inputs[i].name == currentFieldId + "[]") 
			{
				inputs[i].value = currentValue;
				inputs[i].title = inc;
				break;
			} else if(currentFieldId == "v61" && inputs[i].name == "v61s2[]") {
				inputs[i].checked = "checked";
			}
		}
	}

	else if(currentFieldId.match(/^v(34|39)$/)){
		inputs = oNode.getElementsByTagName('TEXTAREA');
		for(var i = 0; i<inputs.length; i+=1) {
			if(inputs[i].name == currentFieldId + "[]") {
				inputs[i].value = currentValue;
				break;
			}
		}
	}
	// text inputs
	else {
		var inputs = oNode.getElementsByTagName('INPUT');
		for(var i = 0; i<inputs.length; i+=1) {
			if(inputs[i].name == currentFieldId + "[]") {
				if(inputs[i].type == "text") {
					inputs[i].value = currentValue;
				} else if (inputs[i].type == "checkbox") {
					inputs[i].checked = "checked";
				} else if (inputs[i].type == "radio") {
					if(inputs[i].name == "v56[]") {
						Util.setRadio(document.forms[0].elements['v56[]'], 
										currentValue);
						if(currentValue == 1) {
							Util.showEl('v56_subfields', true);
						}
					} else 
						Util.setRadio(inputs[i], currentValue);
				} else {
					alert("unhandled type: " + inputs[i].type);
				}
				break;
			}
		}
		var inputs = oNode.getElementsByTagName('TEXTAREA');
		for(var i = 0; i<inputs.length; i+=1) {
			if(inputs[i].name == currentFieldId + "[]") {
				if(inputs[i].type == "textarea") {
					inputs[i].value = currentValue;
				} else {
					alert("unhandled type: " + inputs[i].type);
				}
				break;
			}
		}
	}
	return false;
}

function saveData() {
	if(oForm == null) {
		oForm = document.getElementById("versionForm");
	}

	var text = '<?xml version="1.0" encoding="UTF-8" ?>' + "\n";
	text += '<repert>' + "\n";
	if(typeof oForm.elements.poem != "undefined") {
		var retVal = Source.createJSON();
		if(retVal == false) {
			return false;
		}

		var bookId;
		if(oForm.elements.source.value != "") {
			bookId = oForm.elements.source.value;
		} else {
			bookId = Source.getBookId();
			oForm.action += bookId;
		}

		text += '<rec id="' + oForm.elements.poem.value + "-" + bookId + '">' + "\n";
		text += '  <v91 value="5"/>' + "\n";
		text += '  <v200 value="' + Util.toXml(bookId) + '"/>' + "\n";
		text += '  <v201 value="' + Util.toXml(oForm.elements.poem.value) + '"/>' + "\n";
		text += '  ' + retVal;
	} else {
		var retVal = Source.createJSON();
		if(retVal == false) {
			return false;
		}
		text += '  ' + retVal;
		text += '  <v91 value="9"/>' + "\n";
	}
	
	// complex fields
	var map = {v5:{}, v32:{}, v31:{}, v35:{}, v48:{}, v61:{}, v56:{}};

	// text and hidden inputs
	var inputs = oForm.getElementsByTagName('INPUT');
	for(var i = 0; i<inputs.length; i+=1) {
		// text inputs
		if(inputs[i].type == "text") {
			// nem összetett mezők
			if(inputs[i].name.match(/^v(2|3|166|167|21|31|42|45|46|47|65|161|162|163|165|11[23]|12[12]|13[1-3]|14[12]|15[1-6])\[\]$/)){
				if(inputs[i].value != "") {
					text += "  <" + inputs[i].name.replace(/\[\]/, "") 
						+ ' value="' + Util.toXml(inputs[i].value) + '"'
						+ '/>' + "\n";
				}
			// összetett mezők
			} else if(inputs[i].name.match(/^v(5s[12]|32s[1dl]|31s[12]|35s[1dl]|48s[kpresumvx]|56s[a-k]|61s[1])\[\]$/)){
				if(inputs[i].value != "") {
					var name = inputs[i].name.replace(/\[\]/, "");
					var pos = name.indexOf("s");
					var field = name.substring(0, pos);
					var subfield = name.substring(pos);
					var id = inputs[i].parentNode.parentNode.id;
					if(id != null) {
						if(typeof map[field][id] == "undefined")
							map[field][id] = {};
						map[field][id][subfield] = inputs[i].value;
					}
				}
			// nem kezelt esetek
			} else if(inputs[i].name.match(/bookid|itemSubId|pagenr/)){
				//
			} else {
				alert(inputs[i].name + " unhandled text input");
				return false;
				/*
				text += "  <" + inputs[i].name 
					+ ' value="' + inputs[i].value + '"'
					+ ' id="' + inputs[i].parentNode.parentNode.id + '"'
					+ '/>' + "\n";
				*/
			
			}
		} else if(inputs[i].type == "checkbox") {
			if(inputs[i].name.match(/^v(5s3|61s2)\[\]$/)){
				if(inputs[i].checked) {
					var name = inputs[i].name.replace(/\[\]/, "");
					var pos = name.indexOf("s");
					var field = name.substring(0, pos);
					var subfield = name.substring(pos);
					var id = inputs[i].parentNode.parentNode.id;
					if(typeof map[field][id] == "undefined")
						map[field][id] = {};
					map[field][id][subfield] = inputs[i].value;
				}
			} else {
				alert(inputs[i].name + "  unhandled checkbox");
			
			}
		} else if(inputs[i].type == "radio") {
			if(inputs[i].name.match(/^v(56)\[\]$/)){
				var v56 = Util.getRadio(oForm.elements['v56[]']);
				if(v56 != null) {
					var id = inputs[i].parentNode.parentNode.id;
					var field = "v56";
					if(typeof map[field][id] == "undefined")
						map[field][id] = {};
					map[field][id]["value"] = v56;
				}
			}
		
		} else {
			// do nothing
		}
	}

	// selections
	inputs = oForm.getElementsByTagName('SELECT');
	for(var i = 0; i<inputs.length; i+=1) {
		var fieldName = inputs[i].name.replace(/\[\]/, "");
		var value = inputs[i].options[inputs[i].selectedIndex].value
		if(fieldName.match(/^v(11|18|22|23|24|30|33|41|43|44|164)$/)){
			if(value != "") {
				text += "  <" + fieldName
					+ ' value="' + Util.toXml(value) + '"'
					+ '/>' + "\n";
			}
		} else {
			alert("unhandled select: " + fieldName);
			text += "  <" + fieldName
				+ ' value="' + Util.toXml(value) + '"'
				+ '/>' + "\n";
		}
	}
	
	// textareas
	var inputs = oForm.getElementsByTagName('TEXTAREA');
	for(var i = 0; i<inputs.length; i+=1) {
		var fieldName = inputs[i].name.replace(/\[\]/, "");
		var value = inputs[i].value;
		if(fieldName.match(/^v(34|39|160)$/)){
			if(value != "") {
				text += "  <" + fieldName
					+ ' value="' + Util.toXml(value) + '"'
					+ '/>' + "\n";
			}
		} else if(fieldName == "v61s3"){
			if(value != "") {
				var name = fieldName;
				var pos = name.indexOf("s");
				var field = name.substring(0, pos);
				var subfield = name.substring(pos);
				var id = inputs[i].parentNode.parentNode.id;
				if(typeof map[field][id] == "undefined")
						map[field][id] = {};
				map[field][id][subfield] = value;
			}
		} else {
			alert("unhandled select: " + fieldName);
			text += "  <" + fieldName
				+ ' value="' + Util.toXml(value) + '"'
				+ '/>' + "\n";
		}
	}

	for(field in map) {
		for(id in map[field]) {
			text += "  <" + field;
			for(subfield in map[field][id]) {
				if(field == "v56") {
					// v56 == 1 vannak almezők, v56 == 48 nincsenek almezők
					if(map[field][id]["value"] == 1) {
						text += " " + subfield + '="' 
							+ Util.toXml(map[field][id][subfield]) + '"';
					} else if(subfield == "value") {
						text += " " + subfield + '="' 
							+ Util.toXml(map[field][id][subfield]) + '"';
					}
				} else {
					text += " " + subfield + '="' 
						+ Util.toXml(map[field][id][subfield]) + '"';
				}
			}
			text += "/>\n";
		}
	}

	text += "</rec>\n";
	text += '</repert>' + "\n";
	showMessage(text.replace(/</g, "&lt;")
					.replace(/>/g, "&gt;")
					.replace(/\n/g, "<br/>"));
	try {
		oForm.elements.xml.value = text;
		return true;
	} catch(e) {
		alert(e);
		return false;
	}
}

function addInputField(oLinkEl) {
	var oDivUnit = oLinkEl.parentNode.parentNode.cloneNode(true);
	var HTML = oDivUnit.innerHTML;
	
	var matches = oDivUnit.id.match(/^((?:v\d+)-)(\d+)/);
	if(matches) {
		oDivUnit.id = matches[1] + (parseInt(matches[2])+1);
	}
	for(var i=0, len=oDivUnit.childNodes.length; i<len; i+=1) {
		if(oDivUnit.childNodes[i].nodeType == 1 &&
			oDivUnit.childNodes[i].tagName == "INPUT" &&
			oDivUnit.childNodes[i].type.match(/(hidden|text)/)) {
			oDivUnit.childNodes[i].value = "";
		}
	}
	oLinkEl.parentNode.parentNode.parentNode.appendChild(oDivUnit);
	return false;
}

function delInputField(oLinkEl) {
	oLinkEl.parentNode.parentNode.parentNode.removeChild(oLinkEl.parentNode.parentNode);
}

function showDescription(id){
	var oDesc = document.getElementById('description');
	var title = document.getElementById('link' + id).title;
	var href = document.getElementById('link' + id).href;
	var description = document.getElementById('desc' + id).innerHTML;
	oDesc.innerHTML = '<h2>' + title + '</h2>'
					+ '<p>' + description + '</p>'
					+ '<p><a href="' + href + '">tovább</a></p>';
	return false;
}

function showMessage(message){
	var oMsg = document.getElementById('messages');
	oMsg.style.top = ((this.CurrentOffset > 70) ? this.CurrentOffset-50 : 20 ) + "px";
	oMsg.style.position = "absolute";
	oMsg.innerHTML = message;
}

function showAlert(message) {
	message = '<span style="color: maroon">' + message + '</span>';
	showMessage(message);
}

function showHelp(oLinkEl) {
	setCurrentOffset(oLinkEl);
	var p = oLinkEl.parentNode;
	while(p.nodeName != 'TABLE') {
		p = p.parentNode;
	}
	var id = p.id;
	var url = contextPath + "/form/fields/help/help-" + id + ".jsp";
	Ajax.handleAjax(url, showHelpMsg);
	return false;
}

function showHelpMsg(helpText) {
	showMessage(helpText);
	return false;
}

function setCurrentOffset(obj){
	var curleft = curtop = 0;
	if (obj.offsetParent) {
		curleft = obj.offsetLeft
		curtop = obj.offsetTop
		while (obj = obj.offsetParent) {
			curleft += obj.offsetLeft
			curtop += obj.offsetTop
		}
	}
	
	this.CurrentOffset = curtop;
}
