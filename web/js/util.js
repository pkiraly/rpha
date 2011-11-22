var Util = function() {
	return {
		showEl : function(id, bShowable) {
			var oDiv = document.getElementById(id);
			if(oDiv === null) {
				return;
			}
			if(bShowable === true){
				oDiv.style.display = "block";
			} else {
				oDiv.style.display = "none";
			}
		},
		
		
		setRadio : function(oRadio, sValue) {
			for(var i=0, len=oRadio.length; i<len; i+=1) {
				if(oRadio[i].value == sValue) {
					oRadio[i].checked = true;
					break;
				}
			}
		},
		
		getRadio : function(oRadio) {
			for(var i=0, len=oRadio.length; i<len; i+=1) {
				if(oRadio[i].checked === true) {
					return oRadio[i].value;
				}
			}
			return null;
		},
		
		fromXml : function(text) {
			if(text == null) {
				return "";
			}
			return text.replace("&quot;", "\"")
				.replace("&lt;", "<")
				.replace("&gt;", ">")
				.replace("&amp;", "&")
				.replace("&apos;", "'");
		},
		
		toXml : function(text) {
			if(text == null) {
				return "";
			}
			return text.replace("\"", "&quot;")
				.replace("<", "&lt;")
				.replace(">", "&gt;")
				.replace("&", "&amp;")
				.replace("'", "&apos;");
		}
	};
}();