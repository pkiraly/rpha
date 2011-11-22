<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<label for="v21-1" title="v21-v22">szerezt. ideje</label>
<table id="v21" class="fields">
	<tr id="v21-1" class="unit">
		<td class="inputs">
			<select name="v22[]" style="float: left;">
		        <option value="">-- [ válasszon! ] --</option>
		        <option value="1">pontosan</option>
		        <option value="2">nem később, mint</option>
		        <option value="3">nem korábban, mint</option>
		        <option value="4">kb.</option>
		        <option value="5">korábban, mint kb.</option>
		        <option value="6">x és y között</option>
		        <option value="7">vagy</option>
			</select>
			<input type="text" name="v21[]" style="width: 40px; float: left;" />
		</td>
<%@ include file="/form/row_controll.jsp" %>
	</tr>
</table>
