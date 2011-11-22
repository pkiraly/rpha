<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<label for="v23-1" title="v23">ének/szöveg?</label>
<table id="v23" class="fields">
	<tr id="v23-1" class="unit">
		<td class="inputs">
			<select name="v23[]" style="width: 200px;">
		        <option value="">-- [ válasszon! ] --</option>
		        <option value="1">A vers szövegvers</option>
		        <option value="2">A vers énekvers</option>
		        <option value="3">Bizonytalan, hogy énekelték-e</option>
			</select>
		</td>
<%@ include file="/form/row_controll.jsp" %>
	</tr>
</table>
