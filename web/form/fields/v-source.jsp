<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<label for="v50-booktype-1" title="v50-booktype">típus</label>
<table id="v50-booktype" class="fields">
	<tr id="v50-booktype-1" class="unit">
		<td class="inputs">
			<label for="print" onclick="Source.showType('print');">nyomtatvány</label>
			<input id="print" type="radio" name="booktype" value="print" 
				onclick="Source.showType('print');"/>
			<label for="ms" onclick="Source.showType('ms');">kézirat</label>
			<input id="ms" type="radio" name="booktype" value="ms" 
				onclick="Source.showType('ms');"/>
			<p id="booktype_print" style="margin: 0; display: none;">
				<label for="RMK1">RMK I.</label>
				<input id="RMK1" type="radio" name="printtype" value="RMK1" 
				onclick="Source.showBookList()" />
				<label for="RMNY">RMNy</label>
				<input id="RMNY" type="radio" name="printtype" value="RMNY" 
				onclick="Source.showBookList()" />
				<label for="RMG">HH-lista</label>
				<input id="RMG" type="radio" name="printtype" value="RMG" 
				onclick="Source.showBookList()" />
			</p>
			<p id="booktype_ms"  style="margin: 0; display: none;">
				<label for="MKEVB0" onclick="Source.showBookList()">Stoll-lista</label>
				<input id="MKEVB0" type="radio" name="mstype" value="MKEVB0" 
				onclick="Source.showBookList()" />
				<label for="MKEVB1">H-lista</label>
				<input id="MKEVB1" type="radio" name="mstype" value="MKEVB1" 
				onclick="Source.showBookList()"/>
			</p>
		</td>
<%@ include file="/form/row_controll.jsp" %>
	</tr>
</table>

<label for="v50-bookid-1" title="bookid">sorszám</label>
<table id="v50-bookid" class="fields">
	<tr id="v50-bookid-1" class="unit">
		<td class="inputs">
			fő: <input type="text" name="bookid" disabled="disabled" title="" 
				style="width: 80px;" />
			kiegészítő: <input type="text" name="itemSubId" disabled="disabled" title="" style="width: 20px;" />
		</td>
<%@ include file="/form/row_controll.jsp" %>
	</tr>
</table>

<label for="v-pagenr-1" title="pagenr">oldalszám</label>
<table id="v-pagenr" class="fields">
	<tr id="v-pagenr-1" class="unit">
		<td class="inputs">
			<input type="text" name="pagenr" />
		</td>
<%@ include file="/form/row_controll.jsp" %>
	</tr>
</table>

<label for="v-pagetype-1" title="pagetype">lap</label>
<table id="v-pagetype" class="fields">
	<tr id="v-pagetype-1" class="unit">
		<td class="inputs">
			<label for="recto">recto</label>
			<input id="recto" type="radio" name="pagetype" value="A" />
			<label for="verso">verso</label>
			<input id="verso" type="radio" name="pagetype" value="B" />
			<label for="none">egyik sem</label>
			<input id="none" type="radio" name="pagetype" value="" />
		</td>
<%@ include file="/form/row_controll.jsp" %>
	</tr>
</table>
