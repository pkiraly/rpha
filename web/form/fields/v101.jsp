<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<label for="v101-1" title="v101">típus</label>
<table id="v101" class="fields">
	<tr id="v101-1" class="unit">
		<td class="inputs">
			<label for="print" onclick="Source.showType('print');">nyomtatvány</label>
			<input id="print" type="radio" name="booktype" value="print" 
				onclick="Source.showType('print');"/>
			<label for="ms" onclick="Source.showType('ms');">kézirat</label>
			<input id="ms" type="radio" name="booktype" value="ms" 
				onclick="Source.showType('ms');"/>
			<p id="booktype_print" style="margin: 0; display: none;">
				<label for="RMK1">RMK I.</label>
				<input id="RMK1" type="radio" name="printtype" value="RMK1" />
				<label for="RMNY">RMNy</label>
				<input id="RMNY" type="radio" name="printtype" value="RMNY" />
				<label for="RMG">HH-lista</label>
				<input id="RMG" type="radio" name="printtype" value="RMG" />
			</p>
			<p id="booktype_ms"  style="margin: 0; display: none;">
				<label for="MKEVB0">Stoll-lista</label>
				<input id="MKEVB0" type="radio" name="mstype" value="MKEVB0" />
				<label for="MKEVB1">H-lista</label>
				<input id="MKEVB1" type="radio" name="mstype" value="MKEVB1" />
			</p>
		</td>
<%@ include file="/form/row_controll.jsp" %>
	</tr>
</table>
