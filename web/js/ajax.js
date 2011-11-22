var Ajax = function() {
	function getXHR() {
	    var http;
	    try {
	    	http = new XMLHttpRequest;
	    	getXHR = function() {
	    		return new XMLHttpRequest;
	    	};
	    } catch(e) {
	    	var msxml = [
	    		'MSXML2.XMLHTTP.5.0', 'MSXML2.XMLHTTP.4.0', 
	    		'MSXML2.XMLHTTP.3.0', 'MSXML2.XMLHTTP', 
	    		'Microsoft.XMLHTTP'
	    	];
	    	for (var i=0, len = msxml.length; i < len; ++i) {
	    		try {
	    			http = new ActiveXObject(msxml[i]);
	    			getXHR = function() {
	    				return new ActiveXObject(msxml[i]);
	    			};
	    			break;
	    		} catch(e) {}
	    	}
	    }
	    return http;
	}

	function handleReadyState(request, callback) {
		if (request && request.readyState == 4
			&& (request.status == 200 || request.status == 304))
		{
			callback(request.responseText);
		}
	}

	return {
		handleAjax : function(url, callback) {
			var request = getXHR();
			if (request) {
				request.open("GET", url, true);
				request.onreadystatechange = function() {
					handleReadyState(request, callback);
				};
				//request.setRequestHeader("Content-Type", "text/html; charset=utf-8");
				request.send(null);
				return true;
			} else {
				return false;
			}
		}
	}
}();
