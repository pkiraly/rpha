<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<p><b>v163</b> - A vers refrénszerkezete (<b>REFRÉN</b>). Fejlesztés alatt 
álló rovat. A metrikai osztályozás rendszerének finomítását szolgálja, de 
ennél részletesebb jelölésre törekszünk az adatbázis későbbi verzióiban. 
Ha a vers nem refrénes, akkor kitöltetlen. Ha versnek van refrénje,
akkor a rovat szorosan igazodik a metrikai szerkezetet leíró rovatokhoz 
(METR, RIME, SYLL). Minden metrikai sornak két betűhelynyi pozíció felel 
meg a rovaton belül. A rovat hossza 200 betűhelynyi.
Ezen a jelölt sornak megfelelően a következő jelölések állhatnak:</p>
<ul type="square">
	<li>"--" - A sorban nincs refrén</li>
	<li>"R0" - Refrénes sor</li>
	<li>"R1" - Szabályosan váltakozó rímes refrén</li>
	<li>"R2" - Időnként refrénnel ellátott sor</li>
	<li>"R3" - Szabálytalanul váltakozó refrén</li>
	<li>"R4" - Metrumot nem tudunk megállapítani, de a vers refrénes 
				szerkezetű lehetett</li>
	<li>"I0" - Megismételt sor</li>
</ul>