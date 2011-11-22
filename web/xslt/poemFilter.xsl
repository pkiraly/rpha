<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0"
                xmlns:marc="http://www.loc.gov/MARC21/slim"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:php="http://php.net/xsl"
                exclude-result-prefixes="php marc">

<xsl:output method="xml" indent="yes" encoding="utf-8" omit-xml-declaration="yes" />
<xsl:param name="bookId"/>

<xsl:template match="/">
	<xsl:for-each select="//rec[v91/@value = '0']">
		<xsl:call-template name="rec">
			<xsl:with-param name="rec" select="." />
			<xsl:with-param name="bookId" select="$bookId" />
		</xsl:call-template>
	</xsl:for-each>
</xsl:template>

<xsl:template match="rec" name="rec">
	<xsl:param name="rec"/>
	<xsl:param name="bookId"/>

	<rec>
		<xsl:attribute name="id" select="@id" />

		<xsl:for-each select="*">
			<xsl:if test="name(.) = 'v1' or name(.) = 'v2' or name(.) = 'v3' or name(.) = 'v5' or name(.) = 'v91' or @bookId = $bookId">
				<xsl:copy-of select="." />
			</xsl:if>
		</xsl:for-each>
	</rec>
</xsl:template>

</xsl:stylesheet>