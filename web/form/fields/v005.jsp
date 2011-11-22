<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<label for="v5-1" title="v5">szerző</label>
<table id="v5" class="fields">
	<tr id="v5-1" class="unit">
		<td class="inputs">
			vezetéknév/keresztnév/kérdéses?<br/>
			<input type="text" name="v5s1[]" style="width: 80px" />
			<input type="text" name="v5s2[]" style="width: 80px" />
			<input type="checkbox" name="v5s3[]" value="?" />
		</td>
<%@ include file="/form/row_controll.jsp" %>
	</tr>
</table>
