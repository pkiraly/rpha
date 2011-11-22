<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0"
                xmlns:mr="http://www.megarep.org"
                xmlns:rpha="http://tesuji.eu/rpha"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:php="http://php.net/xsl"
                exclude-result-prefixes="php">

<xsl:output method="xml" indent="yes" encoding="utf-8" omit-xml-declaration="yes" />
<xsl:param name="bookId"/>

<xsl:template match="/">
	<xsl:for-each select="//rec">
		<xsl:apply-templates select="." />
	</xsl:for-each>
</xsl:template>

<xsl:template match="rec">
	<mr:record>
		<xsl:attribute name="id" select="@id" />

		<xsl:for-each select="*">
			<xsl:variable name="tag">
				<xsl:choose>
					<xsl:when test="name(.) = 'v1'">mr:id</xsl:when>
					<xsl:when test="name(.) = 'v2'">mr:incipit</xsl:when>
					<xsl:when test="name(.) = 'v3'">mr:title</xsl:when>
					<xsl:when test="name(.) = 'v5'">mr:author</xsl:when>
					<xsl:when test="name(.) = 'v18'">mr:language</xsl:when>
					<xsl:when test="name(.) = 'v20'">mr:caesuras</xsl:when>
					<xsl:when test="name(.) = 'v21'">mr:date</xsl:when>
					<xsl:when test="name(.) = 'v22'">mr:date_qualifier</xsl:when>
					<xsl:when test="name(.) = 'v23'">mr:melody</xsl:when>
					<xsl:when test="name(.) = 'v28'">mr:genre</xsl:when>
					<xsl:when test="name(.) = 'v42' and ../v43/@value = 2"><xsl:text>mr:number_of_lines</xsl:text></xsl:when>
					<xsl:when test="name(.) = 'v42' and ../v43/@value = 1"><xsl:text>mr:number_of_strophes</xsl:text></xsl:when>
					<xsl:when test="name(.) = 'v44'"><xsl:text>mr:meter</xsl:text></xsl:when>
					<xsl:when test="name(.) = 'v46'"><xsl:text>mr:rhyme_scheme</xsl:text></xsl:when>
					<xsl:when test="name(.) = 'v47'"><xsl:text>mr:metrical_scheme</xsl:text></xsl:when>
					<xsl:otherwise>rpha:<xsl:value-of select="name(.)" /></xsl:otherwise>
				</xsl:choose>
			</xsl:variable>

			<xsl:if test="$tag != '' and not(starts-with($tag, 'rpha'))  and not($tag = 'mr:language' and @value = 'hun')">
				<xsl:element name="{$tag}">
					<xsl:choose>
						<xsl:when test="count(@*) = 1 and @value">
							<xsl:choose>
								<xsl:when test="$tag = 'mr:language' and @value = 'lat'">la</xsl:when>
								<xsl:when test="$tag = 'mr:language' and @value = 'ger'">de</xsl:when>
								<xsl:when test="$tag = 'mr:language' and @value = 'gre'">el</xsl:when>
								<xsl:when test="$tag = 'mr:language' and @value = 'hrv'">hr</xsl:when>
								<xsl:when test="$tag = 'mr:language' and @value = 'hun'">hu</xsl:when>
								<xsl:when test="$tag = 'mr:melody' and @value = '1'">02</xsl:when>
								<xsl:when test="$tag = 'mr:melody' and @value = '2'">01</xsl:when>
								<xsl:when test="$tag = 'mr:melody' and @value = '3'">03</xsl:when>
								<xsl:when test="$tag = 'mr:meter' and @value = '8'">01</xsl:when>
								<xsl:when test="$tag = 'mr:meter' and @value = '6'">01-01-01</xsl:when>
								<xsl:when test="$tag = 'mr:meter' and @value = '7'">01-02-01</xsl:when>
								<xsl:when test="$tag = 'mr:meter' and @value = '4'">01-04</xsl:when>
								<xsl:when test="$tag = 'mr:meter' and @value = '1'">02</xsl:when>
								<xsl:when test="$tag = 'mr:meter' and @value = '16'">03</xsl:when>
								<xsl:when test="$tag = 'mr:meter' and @value = '18'">05</xsl:when>
								<xsl:when test="$tag = 'mr:meter' and @value = '15'">08</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="@value" />
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:when test="$tag = 'mr:author'">
							<xsl:value-of select="@s1" />
							<xsl:value-of select="' '" />
							<xsl:value-of select="@s2" />
							<xsl:value-of select="@s3" />
						</xsl:when>
						<xsl:otherwise>
							<xsl:comment><xsl:value-of select="count(@*)" /></xsl:comment>
							<xsl:copy-of select="@*" />
						</xsl:otherwise>
					</xsl:choose>
				</xsl:element>
			</xsl:if>
		</xsl:for-each>
		<!-- default for all -->
		<mr:language>hu</mr:language>
	</mr:record>
</xsl:template>

</xsl:stylesheet>