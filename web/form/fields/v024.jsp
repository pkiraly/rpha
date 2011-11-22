<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<label for="v24-1" title="v24">szignáltság</label>
<table id="v24" class="fields">
	<tr id="v24-1" class="unit">
		<td class="inputs">
			<select name="v24[]" style="width: 200px;">
		        <option value="">-- [ válasszon! ] --</option>
		        <option value="1">a szerző névmegjelölésével</option>
		        <option value="2">szerzőjét nem ismerjük</option>
		        <option value="3">a szerzőnek tulajdonították</option>
		        <option value="4">modern kutatás alapján</option>
		        <option value="5">gyűjtemény a szerző neve alatt</option>
		        <option value="6">anagrammatikusan szignált</option>
			</select>
		</td>
<%@ include file="/form/row_controll.jsp" %>
	</tr>
</table>
