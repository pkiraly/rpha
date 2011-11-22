<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0"
                xmlns:mr="http://www.megarep.org"
                xmlns:rpha="http://tesuji.eu/rpha"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:php="http://php.net/xsl"
                exclude-result-prefixes="php">

<xsl:output method="html" indent="yes" encoding="utf-8" omit-xml-declaration="yes" />

<xsl:param name="lang" select="'hu'" />

<xsl:variable name="doc" select="concat('language.', $lang, '.xml')" />

<xsl:template match="/">
	<xsl:for-each select="rss/channel/item">
		<xsl:apply-templates select="." />
	</xsl:for-each>
</xsl:template>

<xsl:template match="item">
	<div>
		<a>
			<xsl:attribute name="href" select="link" />
			
			<xsl:if test="description/mr:record/mr:author">
				<xsl:value-of select="description/mr:record/mr:author" />
				<xsl:text>: </xsl:text>
			</xsl:if>

			<xsl:if test="description/mr:record/mr:title">
				<xsl:value-of select="description/mr:record/mr:title" />
			</xsl:if>

			<xsl:if test="description/mr:record/mr:incipit">
				<xsl:text> (</xsl:text>
				<i>
					<xsl:value-of select="description/mr:record/mr:incipit" />
					<xsl:text>&#x2026;</xsl:text>
				</i>
				<xsl:text>)</xsl:text>
			</xsl:if>

			<xsl:if test="description/mr:record/mr:id">
				<xsl:text> [ID:</xsl:text>
				<xsl:value-of select="description/mr:record/mr:id" />
				<xsl:text>]</xsl:text>
			</xsl:if>
		</a>
		<br/>
		
		<xsl:if test="description/mr:record/mr:language">
			<i><xsl:value-of select="document($doc)/keys/key[@id = 'language']/text()" /></i>
			<xsl:text>: </xsl:text>
			<xsl:for-each select="description/mr:record/mr:language">
				<xsl:if test="position() > 1">, </xsl:if>
				<xsl:value-of select="." />
			</xsl:for-each>
			<br/>
		</xsl:if>

		<xsl:if test="description/mr:record/mr:caesuras">
			<i><xsl:value-of select="document($doc)/keys/key[@id = 'caesuras']/text()" /></i>
			<xsl:text>: </xsl:text>
			<xsl:value-of select="description/mr:record/mr:caesuras" />
			<br/>
		</xsl:if>

		<xsl:if test="description/mr:record/mr:date">
			<i><xsl:value-of select="document($doc)/keys/key[@id = 'date']/text()" /></i>
			<xsl:text>: </xsl:text>
			<xsl:value-of select="description/mr:record/mr:date" />
			<xsl:if test="description/mr:record/mr:date_qualifier">
				<xsl:text> (</xsl:text>
				<xsl:value-of select="description/mr:record/mr:date_qualifier" />
				<xsl:text>)</xsl:text>
			</xsl:if>
			<br/>
		</xsl:if>

		<xsl:if test="description/mr:record/mr:melody">
			<i><xsl:value-of select="document($doc)/keys/key[@id = 'melody']/text()" /></i>
			<xsl:text>: </xsl:text>
			<xsl:variable name="key" select="concat('melody.', description/mr:record/mr:melody)" />
			<xsl:value-of select="document($doc)/keys/key[@id = $key]/text()" />
			<br/>
		</xsl:if>

		<xsl:if test="description/mr:record/mr:genre">
			<i><xsl:value-of select="document($doc)/keys/key[@id = 'genre']/text()" /></i>
			<xsl:text>: </xsl:text>
			<xsl:value-of select="description/mr:record/mr:genre" />
			<br/>
		</xsl:if>

		<xsl:if test="description/mr:record/mr:number_of_lines or description/mr:record/mr:number_of_strophes">
			<xsl:if test="description/mr:record/mr:number_of_lines">
				<i><xsl:value-of select="document($doc)/keys/key[@id = 'number_of_lines']/text()" /></i>
				<xsl:text>: </xsl:text>
				<xsl:for-each select="description/mr:record/mr:number_of_lines">
					<xsl:if test="position() > 1">, </xsl:if>
					<xsl:value-of select="." />
				</xsl:for-each>
			</xsl:if>

			<xsl:if test="description/mr:record/mr:number_of_lines and description/mr:record/mr:number_of_strophes">
				<xsl:text>, </xsl:text>
			</xsl:if>

			<xsl:if test="description/mr:record/mr:number_of_strophes">
				<i><xsl:value-of select="document($doc)/keys/key[@id = 'number_of_strophes']/text()" /></i>
				<xsl:text>: </xsl:text>
				<xsl:for-each select="description/mr:record/mr:number_of_strophes">
					<xsl:if test="position() > 1">, </xsl:if>
					<xsl:value-of select="." />
				</xsl:for-each>
			</xsl:if>
			<br/>
		</xsl:if>

		<xsl:if test="description/mr:record/mr:meter">
			<i><xsl:value-of select="document($doc)/keys/key[@id = 'meter']/text()" /></i>
			<xsl:text>: </xsl:text>
			<xsl:variable name="key" select="concat('meter.', description/mr:record/mr:meter)" />
			<xsl:value-of select="document($doc)/keys/key[@id = $key]/text()" />
			<br/>
		</xsl:if>

		<xsl:if test="description/mr:record/mr:rhyme_scheme">
			<i><xsl:value-of select="document($doc)/keys/key[@id = 'rhyme_scheme']/text()" /></i>
			<xsl:text>: </xsl:text>
			<xsl:value-of select="description/mr:record/mr:rhyme_scheme" />
			<br/>
		</xsl:if>

		<xsl:if test="description/mr:record/mr:metrical_scheme">
			<i><xsl:value-of select="document($doc)/keys/key[@id = 'metrical_scheme']/text()" /></i>
			<xsl:text>: </xsl:text>
			<xsl:value-of select="description/mr:record/mr:metrical_scheme" />
			<br/>
		</xsl:if>
	</div>
</xsl:template>

</xsl:stylesheet>