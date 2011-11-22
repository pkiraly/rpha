package com.kirunews.rpha.model;

import org.apache.log4j.Logger;
import org.apache.lucene.document.FieldSelector;
import org.apache.lucene.document.FieldSelectorResult;

import com.kirunews.rpha.util.Logging;

public class SearchPoemFieldSelector  implements FieldSelector {

	private static final long serialVersionUID = 367243768603074171L;
	private static Logger logger = Logging.getLogger();
	
	public FieldSelectorResult accept(String fieldName) {
		
		if(PoemSearcher.referenceFields.contains(fieldName)
			|| PoemSearcher.bookReferenceFields.contains(fieldName)
			|| PoemSearcher.versionFields.contains(fieldName)
			|| fieldName.startsWith("v51_bookId_")
			|| fieldName.startsWith("v52_bookId_")
			|| fieldName.equals("v61_s1")
			|| fieldName.equals("record")
			|| fieldName.equals("id")
		) {
			return FieldSelectorResult.LOAD;
		} else if(fieldName.equals("v91")
			|| fieldName.equals("v201")
			|| fieldName.equals("v200")
		) {
			return FieldSelectorResult.LAZY_LOAD;
		} else {
			return FieldSelectorResult.NO_LOAD;
		}
	}
}

