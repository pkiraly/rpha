/**
 * handling source events, managing source data
 */

var Source = function() {

	var oBookTypeNode = null,
		elements = new Array('v50-booktype-1', 'v50-bookid-1', 'v-pagenr-1',
			'v-pagetype-1'),
		DBfields = new Array('v51', 'v52', 'v101', 'v111'),
		bookTypes = {27:'RMK1', 28:'RMNY', 29:'RMG', 18:'MKEVB0', 19:'MKEVB1'},
		oBookType = null, oPrintType = null, oMsType = null,
		oBookId = null, oPageNr = null, oPageType = null,
		savedBookType = null, bookId = null;

	function init() {
		if(oBookId == null) {
			oBookType = oForm.elements['booktype'];
			oPrintType = oForm.elements['printtype'];
			oMsType = oForm.elements['mstype'];
			oBookId = oForm.elements['bookid'];
			oItemSubId = oForm.elements['itemSubId'];
			oPageNr = oForm.elements['pagenr'];
			oPageType = oForm.elements['pagetype'];
		}
	};
	
	function getSourceCodeByBookType(bookType) {
		for(sourceCode in bookTypes) {
			if(bookTypes[sourceCode] == bookType) {
				return sourceCode;
			}
		}
	};

	function getTagByBookType(bookType) {
		switch(bookType) {
			case 'RMK1': 
			case 'RMNY':
			case 'RMG' :
				return "v51"; break;
			case 'MKEVB0': 
			case 'MKEVB1':
				return "v52"; break;
		}
	};

	function getPageType() {
		return Util.getRadio(oPageType);
	};

	function setPageType(sValue) {
		Util.setRadio(oPageType, sValue);
	};
	
	function setBookType(forrasTipusKod, v101) {
		if(forrasTipusKod.match(/^(27|28|29)$/)) {
			Util.setRadio(oBookType, "print");
			Util.setRadio(oPrintType, v101);
			Source.showType("print");
		} else if(forrasTipusKod.match(/^(18|19)$/)) {
			Util.setRadio(oBookType, "ms");
			Util.setRadio(oMsType, v101);
			Source.showType("ms");
		}
	};
	
	return {
		showType : function(type) {
			if(!type.match(/^(print|ms)$/)) {
				return false;
			}
			if(oBookTypeNode !== null) {
				oBookTypeNode.style.display = "none";
			}
			oBookTypeNode = document.getElementById('booktype_' + type);
			if(oBookTypeNode !== null) {
				oBookTypeNode.style.display = "block";
			}
			return false;
		},

		setSource : function(bookId, bookTitle) {
			var matches = bookId.match(/^(RMNY|RMK1|RMG|MKEVB[01])-(\d{4})(.*)$/);
			if(matches) {
				var v101 = matches[1];
				var itemId = matches[2];
				var itemSubId = matches[3];
				oBookId.value = itemId;
				oItemSubId.value = itemSubId;
			} else {
				oBookId.value = bookId;
			}
			oBookId.title = bookTitle;
			return false;
		},
		
		createJSON : function() {
			if(typeof window.formType != "undefined" 
				&& window.formType == "book") 
			{
				var bookId = oBookId.value;
				if(bookId == "") {
					showAlert("Adja meg a forrás azonosítóját!");
					return false;
				}
				var itemSubId = oItemSubId.value;
				var bookType = Util.getRadio(oBookType);
				var sourceAbbr = (bookType == "ms") 
								? Util.getRadio(oMsType) 
								: Util.getRadio(oPrintType);

				if(itemSubId != "" && itemSubId != " ") {
					bookId += itemSubId;
				}
				XMLentry = '<rec id="' + sourceAbbr+'-'+bookId + '">' + "\n";
				XMLentry += '  <v101 value="' + sourceAbbr + '"/>' + "\n";
				XMLentry += '  <v111 value="' + bookId + '"/>' + "\n";
			} else {
				if(savedBookType == null) {
					showAlert("Adja meg a forrás típusát!");
					return false;
				}

				var bookId = oBookId.value;
				if(bookId == "") {
					showAlert("Adja meg a forrás azonosítóját!");
					return false;
				}
				var itemSubId = oItemSubId.value;
				var pageNr = oPageNr.value;
				var pageType = Util.getRadio(oPageType);
				var forrasTipusKod = getSourceCodeByBookType(savedBookType);

				var XMLentry = '<' + getTagByBookType(savedBookType);
				XMLentry += ' forrasTipusKod="' + forrasTipusKod + '"';
				var valueAttr = forrasTipusKod + ':' + bookId;
				XMLentry += ' itemMainId="' + bookId + '"';
				var itemId = bookId;
				if(itemSubId != "" && itemSubId != " ") {
					valueAttr += '/' + itemSubId;
					var len = 4 - itemSubId.length;
					while(len > 0) {
						valueAttr += ' ';
						len--;
					}
					XMLentry += ' itemSubnote="/"';
					XMLentry += ' itemSubId="' + itemSubId + '"';
					itemId += itemSubId;
				} else {
					valueAttr += '    ';
					XMLentry += ' itemSubnote=" "';
					XMLentry += ' itemSubId=" "';
				}
				valueAttr += 'P:';
				while(pageNr.length < 4) {
					pageNr = '0' + pageNr;
				}
				valueAttr += pageNr;
				XMLentry += ' page="' + pageNr + '"';
				if(pageType != "") {
					XMLentry += ' pageSubnote="-"';
					XMLentry += ' pageSubid="' + pageType + '"';
					valueAttr += '-' + pageType;
				} else {
					XMLentry += ' pageSubnote=""';
					XMLentry += ' pageSubid=""';
				}
				XMLentry += ' itemId="' + itemId + '"';
				XMLentry += ' v111="' + itemId + '"';
				XMLentry += ' bookId="' + savedBookType + '-' + itemId + '"';
				this.setBookId(savedBookType + '-' + itemId);
				XMLentry += ' value="' + valueAttr + '"';
				XMLentry += ' v101="' + savedBookType + '"';
				XMLentry += '/>' + "\n";
				// alert(XMLentry);
			}
			return XMLentry;
		},
		
		setBookId : function(_bookId) {
			bookId = _bookId;
		},

		getBookId : function() {
			return bookId;
		},
		
		parseJSON : function() {
			init();
			if(typeof analyticum == "undefined" &&
				typeof syntheticum == "undefined") {
				return;
			}
			var dataSources = new Array();
			if(typeof analyticum != "undefined" ) {
				dataSources[dataSources.length] = analyticum;
			}
			if(typeof syntheticum != "undefined" ) {
				dataSources[dataSources.length] = syntheticum;
			}
			for(i in dataSources){
				var dataSource = dataSources[i];
				for(var i=0; i<DBfields.length; i++) {
					var fieldName = DBfields[i];
					if(typeof dataSource[fieldName] == "undefined"){
						continue;
					}
					if(fieldName == "v51" || fieldName == "v52") {
						var oField = dataSource[fieldName];
						var sources = new Array();
						if(typeof oField.length == "undefined") {
							sources[0] = oField;
						} else {
							sources = oField;
						}
						for(var j=0,len=sources.length; j<len; j++) {
							var source = sources[j];
							if(window.bookId == source.bookId) {
								savedBookType = source.v101;
								setBookType("" + source.forrasTipusKod, source.v101);
								this.setSource(source.itemMainId, "");
								oItemSubId.value = source.itemSubId;
								oPageNr.value = source.page;
								Util.setRadio(oPageType, source.pageSubid);
							}
						}
					} else if(fieldName == "v101") {
						var v101 = dataSource[fieldName];
						setBookType(getSourceCodeByBookType(v101), v101);
					} else if(fieldName == "v111") {
						var v111 = dataSource[fieldName];
						this.setSource(v111.substr(0,4), "");
						if(v111.length > 4) {
							oItemSubId.value = v111.substr(4);
						}
					}
				}
			}
		},
		
		disablePlusMinusLinks : function() {
			var oDiv = null, oTd, oLinks;
			for(var i=0,len=elements.length; i<len; i++) {
				oDiv = document.getElementById(elements[i]);
				if(oDiv != null) {
					oTd = oDiv.getElementsByTagName("TD")[1];
					oLinks = oTd.getElementsByTagName("A");
					oLinks[1].onclick = function(){return false;};
					oLinks[2].onclick = function(){return false;};
				}
			}
		},
		
		showBookList : function() {
			var bookType = Util.getRadio(oBookType);
			if(bookType == null) {
				showAlert("Jelölje meg, hogy a forrás kézirat vagy nyomtatvány!");
				return false;
			}
			var bookTypeFilter = (bookType == "ms") 
								? Util.getRadio(oMsType) 
								: Util.getRadio(oPrintType);
			if(bookTypeFilter == null) {
				showAlert("Jelölje meg, hogy melyik listát választja!");
				return false;
			}
			savedBookType = bookTypeFilter;
			var sUrl = contextPath + "/booktype/" + bookTypeFilter;
			Ajax.handleAjax(sUrl, handleBookList);
			return false;
		}
	}
}();
