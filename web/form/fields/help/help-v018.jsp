<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<p><b>v18</b> - A fordítás alapjául szolgáló nyelv (<b>LANOR</b>). Fejlesztés
alatt álló rovat. Pillanatnyilag (a 3.1 verzióban) akkor van kitöltve, ha a vers
fordítás, tudjuk is, hogy milyen nyelvből, de ez a szokásos adatokból (INCOR,
TITOR, AUTET) nem derül ki. Ez például akkor fordul elő, ha az eredeti mű nem
azonosítható pontosan (Gergei Albert: <i>Árgirus históriája</i>,
<a href="<%=request.getContextPath() %>/id/0053">RPHA 53</a>). A rovat
kódolt, előforduló kódjai és jelentései a következők:</p>
<ul type="square">
	<li>"all" - német</li>
	<li>"gre" - görög</li>
	<li>"cro" - horvát</li>
	<li>"hon" - magyar</li>
	<li>"lat" - latin</li>
</ul>
<p>A magyar nyelv előfordulását az indokolja, hogy van olyan eset, amikor
nyilvánvaló, hogy a szerző magyar forrásokra alapozva írja művét. Ez tehát az
idegen nyelvű forrás tagadása. A rovatnak mindig három betűnyi kódot kell
tartalmaznia, ha nem üres.</p>
