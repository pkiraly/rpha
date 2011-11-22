<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0"
                xmlns:marc="http://www.loc.gov/MARC21/slim"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:php="http://php.net/xsl"
                exclude-result-prefixes="php marc">

  <xsl:output method="text" indent="yes" encoding="utf-8"/>
  <xsl:param name="varName" select="''" />

<xsl:template match="/">
	<xsl:apply-templates select="repert/rec[1]" />
</xsl:template>
  
<xsl:template match="rec">
	<xsl:text>var </xsl:text>
	<xsl:if test="$varName = ''">
		<xsl:text>record</xsl:text>
	</xsl:if>
	<xsl:if test="$varName != ''">
		<xsl:value-of select="$varName" />
	</xsl:if>
	<xsl:text> = {&#xa;</xsl:text>

	<xsl:for-each select="*">
		<xsl:if test="position() = 1 or name(.) != name(preceding-sibling::*[1])">
			<xsl:text>  </xsl:text>
			<xsl:value-of select="name(.)"/>
			<xsl:text>: </xsl:text>
		</xsl:if>

		<xsl:if test="name(.) != name(preceding-sibling::*[1]) and name(.) = name(following-sibling::*[1])">
			<xsl:text>[</xsl:text>
		</xsl:if>

		<xsl:if test="name(.) = name(preceding-sibling::*[1])">
			<xsl:text>, </xsl:text>
		</xsl:if>
			
		<xsl:if test="count(*) = 0">
			<xsl:choose>
				<xsl:when test="count(@*) = 1 and @value">
					<xsl:text>"</xsl:text><xsl:value-of select="replace(@value, '&#x22;', '\\&#x22;')"/><xsl:text>"</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>{</xsl:text>
					<xsl:for-each select="@*">
						<xsl:if test="position() > 1">
							<xsl:text>, </xsl:text>
						</xsl:if>
						<xsl:text>"</xsl:text><xsl:value-of select="name(.)"/><xsl:text>": </xsl:text>
						<xsl:text>"</xsl:text><xsl:value-of select="replace(., '&#x22;', '\\&#x22;')"/><xsl:text>"</xsl:text>
					</xsl:for-each>
					<xsl:text>}</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>

		<xsl:if test="count(*) > 0">
			<xsl:text>/* count > 0 */</xsl:text>
			<xsl:text>{</xsl:text>
			<xsl:for-each select="*">
				<xsl:if test="position() > 1">
					<xsl:text>, </xsl:text>
				</xsl:if>
				<xsl:text>"</xsl:text>
				<xsl:value-of select="name(.)"/>
				<xsl:text>"</xsl:text>
				<xsl:text>: "</xsl:text>
				<xsl:value-of select="replace(@value, '&#x22;', '\\&#x22;')"/>
				<xsl:text>"</xsl:text>
			</xsl:for-each>
			<xsl:text>}</xsl:text>
		</xsl:if>
			
		<xsl:if test="name(.) = name(preceding-sibling::*[1]) and name(.) != name(following-sibling::*[1])">
			<xsl:text>]</xsl:text>
		</xsl:if>

		<xsl:if test="position() != last() and name(.) != name(following-sibling::*[1])">
			<xsl:text>,&#xa;</xsl:text>
		</xsl:if>
	</xsl:for-each>
	<xsl:text>&#xa;};</xsl:text>
</xsl:template>

</xsl:stylesheet>