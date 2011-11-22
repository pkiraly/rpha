<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0"
                xmlns:marc="http://www.loc.gov/MARC21/slim"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:php="http://php.net/xsl"
                exclude-result-prefixes="php marc">

<xsl:output method="xml" indent="yes" encoding="utf-8" omit-xml-declaration="no" />
<xsl:param name="bookId"/>

<xsl:template match="/">
	<repert>
		<xsl:for-each select="//rec">
			<xsl:apply-templates select="." />
		</xsl:for-each>
	</repert>
</xsl:template>

<xsl:template match="rec">
	<rec>
		<xsl:attribute name="id" select="@id" />

		<xsl:for-each select="*">
			<xsl:variable name="tag">
				<xsl:call-template name="code2tag">
					<xsl:with-param name="code"><xsl:value-of select="name(.)" /></xsl:with-param>
				</xsl:call-template>
			</xsl:variable>

			<xsl:if test="name(.) = $tag">
				<xsl:comment><xsl:value-of select="$tag" /></xsl:comment>
			</xsl:if>

			<xsl:element name="{$tag}">
				<xsl:copy-of select="@*" />
			</xsl:element>
		</xsl:for-each>
	</rec>
</xsl:template>

<xsl:template name="code2tag">
	<xsl:param name="code" />

	<xsl:choose>
		<xsl:when test="$code = 'v1'"><xsl:text>rpha</xsl:text></xsl:when>
		<xsl:when test="$code = 'v2'"><xsl:text>inc</xsl:text></xsl:when>
		<xsl:when test="$code = 'v3'"><xsl:text>titre</xsl:text></xsl:when>
		<xsl:when test="$code = 'v5'"><xsl:text>aut</xsl:text></xsl:when>
		<xsl:when test="$code = 'v11'"><xsl:text>trad</xsl:text></xsl:when>
		<xsl:when test="$code = 'v12'"><xsl:text>incor</xsl:text></xsl:when>
		<xsl:when test="$code = 'v13'"><xsl:text>titor</xsl:text></xsl:when>
		<xsl:when test="$code = 'v14'"><xsl:text>hymnus</xsl:text></xsl:when>
		<xsl:when test="$code = 'v15'"><xsl:text>autet</xsl:text></xsl:when>
		<xsl:when test="$code = 'v18'"><xsl:text>lanor</xsl:text></xsl:when>
		<xsl:when test="$code = 'v21'"><xsl:text>an</xsl:text></xsl:when>
		<xsl:when test="$code = 'v22'"><xsl:text>prec</xsl:text></xsl:when>
		<xsl:when test="$code = 'v23'"><xsl:text>chans</xsl:text></xsl:when>
		<xsl:when test="$code = 'v24'"><xsl:text>signe</xsl:text></xsl:when>
		<xsl:when test="$code = 'v28'"><xsl:text>genre</xsl:text></xsl:when>
		<xsl:when test="$code = 'v30'"><xsl:text>colo</xsl:text></xsl:when>
		<xsl:when test="$code = 'v31'"><xsl:text>dedie</xsl:text></xsl:when>
		<xsl:when test="$code = 'v32'"><xsl:text>doncolo</xsl:text></xsl:when>
		<xsl:when test="$code = 'v33'"><xsl:text>acr</xsl:text></xsl:when>
		<xsl:when test="$code = 'v34'"><xsl:text>acrost</xsl:text></xsl:when>
		<xsl:when test="$code = 'v35'"><xsl:text>donacr</xsl:text></xsl:when>
		<xsl:when test="$code = 'v39'"><xsl:text>comment</xsl:text></xsl:when>
		<xsl:when test="$code = 'v41'"><xsl:text>int</xsl:text></xsl:when>
		<xsl:when test="$code = 'v42'"><xsl:text>lon</xsl:text></xsl:when>
		<xsl:when test="$code = 'v43'"><xsl:text>pre</xsl:text></xsl:when>
		<xsl:when test="$code = 'v44'"><xsl:text>typme</xsl:text></xsl:when>
		<xsl:when test="$code = 'v45'"><xsl:text>metr</xsl:text></xsl:when>
		<xsl:when test="$code = 'v46'"><xsl:text>rime</xsl:text></xsl:when>
		<xsl:when test="$code = 'v47'"><xsl:text>syll</xsl:text></xsl:when>
		<xsl:when test="$code = 'v48'"><xsl:text>relse</xsl:text></xsl:when>
		<xsl:when test="$code = 'v51'"><xsl:text>rmny</xsl:text></xsl:when>
		<xsl:when test="$code = 'v52'"><xsl:text>mkevb</xsl:text></xsl:when>
		<xsl:when test="$code = 'v53'"><xsl:text>ed-mel</xsl:text></xsl:when>
		<xsl:when test="$code = 'v54'"><xsl:text>ed-cr</xsl:text></xsl:when>
		<xsl:when test="$code = 'v55'"><xsl:text>fasc</xsl:text></xsl:when>
		<xsl:when test="$code = 'v61'"><xsl:text>dal-con</xsl:text></xsl:when>
		<xsl:when test="$code = 'v65'"><xsl:text>dal-mod</xsl:text></xsl:when>
		<xsl:when test="$code = 'v91'"><xsl:text>rectyp</xsl:text></xsl:when>
		<xsl:when test="$code = 'v161'"><xsl:text>cf-encore</xsl:text></xsl:when>
		<xsl:when test="$code = 'v162'"><xsl:text>vide</xsl:text></xsl:when>
		<xsl:when test="$code = 'v163'"><xsl:text>refren</xsl:text></xsl:when>
		<xsl:when test="$code = 'v164'"><xsl:text>echo</xsl:text></xsl:when>
		<xsl:when test="$code = 'v165'"><xsl:text>belso-cf</xsl:text></xsl:when>
		<xsl:when test="$code = 'v166'"><xsl:text>elofej</xsl:text></xsl:when><!-- -->
		<xsl:when test="$code = 'v101'"><xsl:text>tipus</xsl:text></xsl:when>
		<xsl:when test="$code = 'v111'"><xsl:text>sorszam</xsl:text></xsl:when>
		<xsl:when test="$code = 'v112'"><xsl:text>szerzo</xsl:text></xsl:when>
		<xsl:when test="$code = 'v113'"><xsl:text>fordito</xsl:text></xsl:when>
		<xsl:when test="$code = 'v121'"><xsl:text>uj-cim</xsl:text></xsl:when>
		<xsl:when test="$code = 'v122'"><xsl:text>cim-er</xsl:text></xsl:when>
		<xsl:when test="$code = 'v131'"><xsl:text>nyomdahely</xsl:text></xsl:when>
		<xsl:when test="$code = 'v132'"><xsl:text>idopont</xsl:text></xsl:when>
		<xsl:when test="$code = 'v133'"><xsl:text>nyomdasz</xsl:text></xsl:when>
		<xsl:when test="$code = 'v141'"><xsl:text>mufaj</xsl:text></xsl:when>
		<xsl:when test="$code = 'v142'"><xsl:text>felekezet</xsl:text></xsl:when>
		<xsl:when test="$code = 'v151'"><xsl:text>varos</xsl:text></xsl:when>
		<xsl:when test="$code = 'v152'"><xsl:text>konyvtar</xsl:text></xsl:when>
		<xsl:when test="$code = 'v153'"><xsl:text>gyujtemeny</xsl:text></xsl:when>
		<xsl:when test="$code = 'v154'"><xsl:text>kotet-jelzet</xsl:text></xsl:when>
		<xsl:when test="$code = 'v155'"><xsl:text>szoveges-feloldasa</xsl:text></xsl:when>
		<xsl:when test="$code = 'v156'"><xsl:text>raktari-jelzet</xsl:text></xsl:when>
		<xsl:when test="$code = 'v160'"><xsl:text>megjegyzes</xsl:text></xsl:when>
		<xsl:otherwise>
			<xsl:if test="$code != 'v6' and 
			                   $code != 'v25' and 
			                   $code != 'v26' and 
			                   $code != 'v27' and 
			                   $code != 'v49' and 
			                   $code != 'v56' and 
			                   $code != 'v167' and 
			                   $code != 'v200' and 
			                   $code != 'v201'">
				<xsl:message>Unhandled element: <xsl:value-of select="$code" /></xsl:message>
			</xsl:if>
			<xsl:value-of select="$code" />
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>