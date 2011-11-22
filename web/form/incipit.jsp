<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean"%> 
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic"%>
[<logic:iterate id="inc" name="incipitForm" property="incipits" 
indexId="id"><logic:greaterThan name="id" value="0" >,</logic:greaterThan>
<logic:iterate 
id="entry" name="inc">["<bean:write name="entry" property="key" 
/>", "<bean:write name="entry" property="value" />"]</logic:iterate></logic:iterate>]