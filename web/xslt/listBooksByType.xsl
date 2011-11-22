<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0"
                xmlns:marc="http://www.loc.gov/MARC21/slim"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:php="http://php.net/xsl"
                exclude-result-prefixes="php marc">

  <xsl:output method="html" 
  	indent="no" 
  	encoding="utf-8" />

<xsl:template match="/">
	<xsl:apply-templates select="//rec" />
</xsl:template>

<xsl:template match="rec">
	
	<li>
	<xsl:variable name="forrasRovidites">
		<xsl:text> </xsl:text>
		<xsl:choose>
			<xsl:when test="v101/@value = 'MKEVB1'">(S </xsl:when>
			<xsl:when test="v101/@value = 'MKEVB0'">(H </xsl:when>
			<xsl:when test="v101/@value = 'RMG'">(HH </xsl:when>
			<xsl:when test="v101/@value = 'RMNY'">(RMNy </xsl:when>
			<xsl:when test="v101/@value = 'RMK1'">(RMK I </xsl:when>
		</xsl:choose>

		<xsl:call-template name="getNumber"><xsl:with-param name="input" select="v111/@value"/></xsl:call-template>

		<xsl:text>)</xsl:text>
	</xsl:variable>

	<xsl:variable name="title">
		<xsl:choose>
			<xsl:when test="v122/@value != ''"><xsl:value-of select="v122/@value"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="v121/@value"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	
	<a href="#">
		<xsl:attribute name="onclick">
			<xsl:text>return Source.setSource('</xsl:text>
			<xsl:value-of select="@id"/>
			<xsl:text>','</xsl:text>
			<xsl:value-of select="replace($title, &quot;&apos;&quot;, &quot;\\&apos;&quot;)"/>
			<xsl:text>');</xsl:text>
		</xsl:attribute>
		<i><xsl:value-of select="$title"/></i>
	</a>

	<!-- nyomdahely -->
	<xsl:if test="not(starts-with(v101/@value, 'MKEVB'))">
		<xsl:text> </xsl:text>
		<xsl:choose>
			<xsl:when test="v131/@value != ''"><xsl:value-of select="v131/@value"/></xsl:when>
			<xsl:otherwise><xsl:text>***</xsl:text></xsl:otherwise>
		</xsl:choose>
	</xsl:if>

	<!-- idopont -->
	<xsl:text>, </xsl:text>
	<xsl:choose>
		<xsl:when test="v132/@value != ''"><xsl:value-of select="v132/@value"/></xsl:when>
		<xsl:otherwise><xsl:text>***</xsl:text></xsl:otherwise>
	</xsl:choose>

	<xsl:value-of select="$forrasRovidites"/>

	<xsl:for-each select="v142">
		<xsl:if test="position() = 1">
			<xsl:text> -- </xsl:text>	
		</xsl:if>
		<xsl:if test="position() > 1">
			<xsl:text>, </xsl:text>	
		</xsl:if>
		<xsl:value-of select="@value" />
	</xsl:for-each>
	
	<xsl:if test="v151|v152|v153|v155|v155|v156">
		<xsl:text> (</xsl:text>
		<xsl:if test="v151">
			<xsl:value-of select="v151/@value"/>
		</xsl:if>

		<xsl:if test="v152">
			<xsl:text>, </xsl:text>	
			<xsl:value-of select="v152/@value"/>
		</xsl:if>

		<xsl:if test="v153">
			<xsl:text>, </xsl:text>	
			<xsl:value-of select="v153/@value"/>
		</xsl:if>

		<xsl:if test="v154">
			<xsl:text>, </xsl:text>	
			<xsl:value-of select="v154/@value"/>
		</xsl:if>

		<xsl:if test="v155">
			<xsl:text>, </xsl:text>	
			<xsl:value-of select="v155/@value"/>
		</xsl:if>

		<xsl:if test="v156">
			<xsl:text>, </xsl:text>	
			<xsl:value-of select="v156/@value"/>
		</xsl:if>

		<xsl:text>)</xsl:text>
	</xsl:if>

	<xsl:if test="v160">
		<xsl:text>, </xsl:text>	
		<i>
		<xsl:value-of select="v160/@value"/>
		</i>
	</xsl:if>

	</li>
	<xsl:text>&#xa;</xsl:text>
</xsl:template>

<xsl:template name="getNumber">
	<xsl:param name="input"/>
	<xsl:choose>
		<xsl:when test="string(number($input)) = 'NaN' and starts-with($input, '000')">
			<xsl:value-of select="substring($input, 4, 1)" />
		</xsl:when>
		<xsl:when test="string(number($input)) = 'NaN' and starts-with($input, '00')">
			<xsl:value-of select="substring($input, 3, 2)" />
		</xsl:when>
		<xsl:when test="string(number($input)) = 'NaN' and starts-with($input, '0')">
			<xsl:value-of select="substring($input, 3, 3)" />
		</xsl:when>
		<xsl:when test="string(number($input)) = 'NaN'">
			<xsl:value-of select="$input" />
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="number($input)" />
			</xsl:otherwise>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>