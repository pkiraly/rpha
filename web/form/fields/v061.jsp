<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<label for="v61-1" title="v61">nótajelzései</label>
<table id="v61" class="fields">
	<tr id="v61-1" class="unit">
		<td class="inputs">
			<input type="text" name="v61s1[]" size="30" 
			onkeyup="v61onKeyUp(this);" />
			kotta van?
			<input type="checkbox" name="v61s2[]" value="1" /><br/>
			megjegyzés<br/>
			<textarea name="v61s3[]" style="width: 200px; height: 20px;"
				onfocus="this.style.height='60px';"
				onblur="this.style.height='20px';"></textarea>
		</td>
<%@ include file="/form/row_controll.jsp" %>
	</tr>
</table>
