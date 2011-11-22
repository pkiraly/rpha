<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="fields">
	<xsl:param name="key" />
	<xsl:choose>
		<xsl:when test="$key = 'author'">Szerző</xsl:when>
		<xsl:when test="$key = 'caesuras'">Sorok belső felosztása - cezúrák</xsl:when>
		<xsl:when test="$key = 'date'">Datálás</xsl:when>
		<xsl:when test="$key = 'declination'">Lejtés (milyen a sorok végződése)</xsl:when>
		<xsl:when test="$key = 'metrical_scheme'">Metrikai képlet</xsl:when>
		<xsl:when test="$key = 'number_of_lines'">Sorok száma</xsl:when>
		<xsl:when test="$key = 'number_of_strophes'">Versszakok száma</xsl:when>
		<xsl:when test="$key = 'rhyme'">Rímelés</xsl:when>
		<xsl:when test="$key = 'rhyme_scheme'">Rímképlet</xsl:when>
		<xsl:when test="$key = 'segmentation'">Szakaszok</xsl:when>
		<xsl:when test="$key = 'declination.line'">A verssorok lejtése (egy egész versre érvényes módon)</xsl:when>
		<xsl:when test="$key = 'declination.scheme'">lejtési képlet</xsl:when>
		<xsl:when test="$key = 'declination.strophe'">versszakok lejtése</xsl:when>
		<xsl:when test="$key = 'genre'">Műfaj</xsl:when>
		<xsl:when test="$key = 'language'">Nyelv</xsl:when>
		<xsl:when test="$key = 'language.qualifier'">típus</xsl:when>
		<xsl:when test="$key = 'melody'">Dallam</xsl:when>
		<xsl:when test="$key = 'meter'">Metrika</xsl:when>
		<xsl:otherwise></xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="declination_lineValue">
	<xsl:param name="key" />
	<xsl:choose>
		<xsl:when test="$key = '01'">ereszkedő sor</xsl:when>
		<xsl:when test="$key = '02'">emelkedő sor</xsl:when>
		<xsl:when test="$key = '03'">nem releváns a verselés szempontjából</xsl:when>
		<xsl:otherwise></xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="declination_stropheValue">
	<xsl:param name="key" />
	<xsl:choose>
		<xsl:when test="$key = '01'">homogonikus</xsl:when>
		<xsl:when test="$key = '02'">heterogonikus</xsl:when>
		<xsl:otherwise></xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="languageValue">
	<xsl:param name="key" />
	<xsl:choose>
		<xsl:when test="$key = '01'">sporadikus kétnyelvűség</xsl:when>
		<xsl:when test="$key = '02'">nyelvváltás soronként</xsl:when>
		<xsl:when test="$key = '03'">nyelvváltás versszakonként</xsl:when>
		<xsl:when test="$key = '04'">a refrén más nyelvű, mint a strófa teste</xsl:when>
		<xsl:otherwise></xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="melodyValue">
	<xsl:param name="key" />
	<xsl:choose>
		<xsl:when test="$key = '01'">énekelt volt</xsl:when>
		<xsl:when test="$key = '01.01'">van kotta</xsl:when>
		<xsl:when test="$key = '01.02'">nincs kotta</xsl:when>
		<xsl:when test="$key = '02'">nem volt énekelt</xsl:when>
		<xsl:when test="$key = '03'">nem tudjuk</xsl:when>
		<xsl:otherwise></xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="meterValue">
	<xsl:param name="key" />
	<xsl:choose>
		<xsl:when test="$key = '01'">rímtelen</xsl:when>
		<xsl:when test="$key = '01.01'">rímtelen és alliteráló</xsl:when>
		<xsl:when test="$key = '01.02'">rímtelen, de nem az alliteráción alapul</xsl:when>
		<xsl:when test="$key = '02'">rímes</xsl:when>
		<xsl:when test="$key = '03'">asszonáncos</xsl:when>
		<xsl:when test="$key = '04'">szórefrénes (önrímek vannak az egymást követő strófákban, rendszerszerűen (pl. szextina))</xsl:when>
		<xsl:otherwise></xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="rhymeValue">
	<xsl:param name="key" />
	<xsl:choose>
		<xsl:when test="$key = '01'">időmértékes</xsl:when>
		<xsl:when test="$key = '01.01-01'">hexameter - egysoros vers - monosztichon</xsl:when>
		<xsl:when test="$key = '01.01-02'">hexameter &#x2013; több soros vers</xsl:when>
		<xsl:when test="$key = '01.02-01'">disztichon &#x2013; 1</xsl:when>
		<xsl:when test="$key = '01.02-02'">disztichon több</xsl:when>
		<xsl:when test="$key = '01.03'">meghatározható időmértékes, nem hexameter sem disztichon (az antik tradícióban szereplő sorfajták)</xsl:when>
		<xsl:when test="$key = '01.04'">bizonytalan időmértékes (nem hagyományos, vagy nem pontosan meghatározható sorfajta)</xsl:when>
		<xsl:when test="$key = '02'">szótagszámláló</xsl:when>
		<xsl:when test="$key = '03'">szótagszámláló tendenciájú</xsl:when>
		<xsl:when test="$key = '04'">ütemszámláló</xsl:when>
		<xsl:when test="$key = '05'">szószámláló</xsl:when>
		<xsl:when test="$key = '06'">szabadvers</xsl:when>
		<xsl:when test="$key = '07'">egyszerre időmértékes és szótagszámláló</xsl:when>
		<xsl:when test="$key = '07.01'">németes</xsl:when>
		<xsl:when test="$key = '07.02'">ritmikus görög-latin</xsl:when>
		<xsl:when test="$key = '08'">kevert kompozíciók (a vers egyes részei más-más metrikai rendszerbe illeszkednek)</xsl:when>
		<xsl:otherwise></xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="segmentationValue">
	<xsl:param name="key" />
	<xsl:choose>
		<xsl:when test="$key = '01'">strofikus &#x2013; több versszak</xsl:when>
		<xsl:when test="$key = '01.01'">izostrofikus</xsl:when>
		<xsl:when test="$key = '01.02'">heterostrofikus</xsl:when>
		<xsl:when test="$key = '02'">strofikus &#x2013; egy versszak</xsl:when>
		<xsl:when test="$key = '03'">párrímes</xsl:when>
		<xsl:when test="$key = '04'">laisse-ekben, változó hosszúságú szakaszokban</xsl:when>
		<xsl:when test="$key = '05'">rimes couées</xsl:when>
		<xsl:when test="$key = '06'">terza rima</xsl:when>
		<xsl:otherwise></xsl:otherwise>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>