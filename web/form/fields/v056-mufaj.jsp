<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<label for="v56-1" title="v56">műfaj</label>
<table id="v56" class="fields">
	<tr id="v56-1" class="unit">
		<td class="inputs">
			<p style="margin: 0;">
				<label for="vallasi">vallásos</label>
				<input id="vallasi" type="radio" name="v56[]" value="1" 
					onclick="Util.showEl('v56_subfields', true);"/>
				<label for="vilagi">világi</label>
				<input id="vilagi" type="radio" name="v56[]" value="48" 
					onclick="Util.showEl('v56_subfields', false);"/>
			</p>
			<p id="v56_subfields" style="margin: 0; display: none;">
				ünnep <input type="text" name="v56sa[]" size="30" />
				közönséges időben <input type="text" name="v56sj[]" size="30" />
				hét napjai <input type="text" name="v56sb[]" size="30" />
				napszakok <input type="text" name="v56sc[]" size="30" />
				istentisztelet <input type="text" name="v56sd[]" size="30" />
				dogmatika <input type="text" name="v56se[]" size="30" />
				alkalom <input type="text" name="v56sf[]" size="30" />
				egykorú műfaj <input type="text" name="v56sk[]" size="30" />
				tartalom 1 <input type="text" name="v56sg[]" size="30" />
				tartalom 2 <input type="text" name="v56sh[]" size="30" />
				modern <input type="text" name="v56si[]" size="30" />
			</p>
		</td>
<%@ include file="/form/row_controll.jsp" %>
	</tr>
</table>
