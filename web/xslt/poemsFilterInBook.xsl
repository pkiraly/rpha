<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" indent="yes" encoding="utf-8"/>

<xsl:template match="/">
	<html>
	<head>
		<meta name="generator" content="RPHA - poemsFilterInBook.xsl" />
		<title><xsl:apply-templates select="//rec[v91/@value = '9']" mode="title"/></title>
		<style type="text/css">
		body, td, th {font-family: sans-serif; font-size: 10pt;}
		a {text-decoration: none; color: maroon;}
		</style>
	</head>
	<body>
		<xsl:apply-templates select="//rec[v91/@value = '9']" mode="book"/>
		<p>
			<a>
				<xsl:attribute name="href">
					<xsl:value-of select="concat('BASE_PATH/editbook/', //rec[v91/@value = '9']/@id)"/>
				</xsl:attribute>
				<xsl:text>[szerkesztés]</xsl:text>
			</a>
			<xsl:text> :: </xsl:text>
			<a href="BASE_PATH/listbooks">[vissza a listához]</a>
		</p>

		<table width="100%">
			<tr>
				<th></th>
				<th valign="top">oldalszám</th>
				<th valign="top">RPHA azonosító</th>
				<th valign="top">szerző(k)</th>
				<th valign="top">incipit</th>
				<th valign="top">cím</th>
			</tr>
			<xsl:apply-templates select="//rec[v91/@value = '0']" mode="poem">
			   <xsl:sort select="v51[1]/@value"/>
			   <xsl:sort select="v52[1]/@value"/>
			</xsl:apply-templates>
		</table>
		
	</body>
	</html>
</xsl:template>

<xsl:template match="rec" mode="title">
	<xsl:choose>
		<!-- eredeti cím -->
		<xsl:when test="v122/@value != ''"><xsl:value-of select="v122/@value"/></xsl:when>
		<!-- új cím -->
		<xsl:otherwise><xsl:value-of select="v121/@value"/></xsl:otherwise>
	</xsl:choose>

	<!-- nyomdahely -->
	<xsl:if test="not(starts-with(v101, 'MKEVB'))">
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

	<xsl:if test="v142">
		<xsl:text> (</xsl:text>
		<xsl:value-of select="v142/@value"/>
		<xsl:text>)</xsl:text>
	</xsl:if>
</xsl:template>

<xsl:template match="rec" mode="book">
	<h1>
		<i>
			<xsl:choose>
				<!-- eredeti cím -->
				<xsl:when test="v122/@value != ''"><xsl:value-of select="v122/@value"/></xsl:when>
				<!-- új cím -->
				<xsl:otherwise><xsl:value-of select="v121/@value"/></xsl:otherwise>
			</xsl:choose>
		</i>

		<!-- nyomdahely -->
		<xsl:if test="not(starts-with(v101, 'MKEVB'))">
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

		<xsl:if test="v142">
			<xsl:text> (</xsl:text>
			<xsl:value-of select="v142/@value"/>
			<xsl:text>)</xsl:text>
		</xsl:if>
	</h1>
</xsl:template>

<xsl:template match="rec" mode="poem">
	<tr valign="top">
		<td align="right" class="position" valign="top">
			<xsl:value-of select="position()" />
			<xsl:text>.) </xsl:text>
		</td><!-- position -->

		<!-- page -->
		<td width="160" valign="top">
			<xsl:if test="v51">
				<xsl:for-each select="v51">
					<xsl:if test="position() > 1">
						<br/>
					</xsl:if>
				
					<xsl:variable name="reference">
						<xsl:if test="./@itemSubId and ./@itemSubId != ''">
							<xsl:value-of select="./@itemSubId" />
							<xsl:text>. kötet </xsl:text>	
						</xsl:if>

						<xsl:text>p. </xsl:text>

						<xsl:choose>
							<xsl:when test="string(number(./@page)) = 'NaN' and starts-with(./@page, '000')">
								<xsl:value-of select="substring(./@page, 4, 1)" />
							</xsl:when>
							<xsl:when test="string(number(./@page)) = 'NaN' and starts-with(./@page, '00')">
								<xsl:value-of select="substring(./@page, 3, 2)" />
							</xsl:when>
							<xsl:when test="string(number(./@page)) = 'NaN' and starts-with(./@page, '0')">
								<xsl:value-of select="substring(./@page, 3, 3)" />
							</xsl:when>
							<xsl:when test="string(number(./@page)) = 'NaN'">
								<xsl:value-of select="./@page" />
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="number(./@page)" />
							</xsl:otherwise>
						</xsl:choose>
			
						<xsl:if test="./@pageSubid">
							<sup>
								<xsl:choose>
									<xsl:when test="./@pageSubid = 'A'">r</xsl:when>
									<xsl:when test="./@pageSubid = 'B'">v</xsl:when>
									<xsl:otherwise><xsl:value-of select="./@pageSubid" /></xsl:otherwise>
								</xsl:choose>
							</sup>
						</xsl:if>
					</xsl:variable>
					
					<xsl:copy-of select="$reference"/>
					<xsl:if test="./@bookId = 'RMK1-0332' or ./@bookId = 'RMNY-0353'">
						<xsl:text> </xsl:text>
						<a>
							<xsl:attribute name="href">
								<xsl:text>http://mek.oszk.hu/rmk/1/332/</xsl:text>
								<xsl:value-of select="concat(./@itemSubId, '/', ./@page)"/>
								<xsl:if test="./@pageSubid">
									<xsl:value-of select="./@pageSubid" />
								</xsl:if>
							</xsl:attribute>
							<xsl:text>&#187;MEK</xsl:text>
						</a>
					</xsl:if>
				</xsl:for-each><!-- v51 -->
			</xsl:if>

			<xsl:if test="v52">
				<xsl:text>p. </xsl:text>
			
				<xsl:for-each select="v52">
					<xsl:if test="position() > 1">
						<xsl:text>, </xsl:text>	
					</xsl:if>
			
					<xsl:choose>
						<xsl:when test="string(number(./@page)) = 'NaN' and starts-with(./@page, '000')">
							<xsl:value-of select="substring(./@page, 4, 1)" />
						</xsl:when>
						<xsl:when test="string(number(./@page)) = 'NaN' and starts-with(./@page, '00')">
							<xsl:value-of select="substring(./@page, 3, 2)" />
						</xsl:when>
						<xsl:when test="string(number(./@page)) = 'NaN' and starts-with(./@page, '0')">
							<xsl:value-of select="substring(./@page, 3, 3)" />
						</xsl:when>
						<xsl:when test="string(number(./@page)) = 'NaN'">
							<xsl:value-of select="./@page" />
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="number(./@page)" />
						</xsl:otherwise>
					</xsl:choose>

					<xsl:if test="./@pageSubid">
						<sup>
							<xsl:value-of select="./@pageSubid" />
						</sup>
					</xsl:if>
				</xsl:for-each>
			</xsl:if><!-- v52 -->
		</td><!-- page -->
		
		
		<td width="80" class="rpha_id">
			<a>
				<xsl:attribute name="href">
					<xsl:value-of select="concat('BASE_PATH/id/', @id)" />
				</xsl:attribute>
				<xsl:text>RPHA </xsl:text>
				<xsl:value-of select="@id" />
			</a>
		</td><!-- RPHA id -->

		<td class="author">
			<xsl:if test="v5">
				<xsl:for-each select="v5">
					<xsl:if test="position() &gt; 1">
						<xsl:text>, </xsl:text>
					</xsl:if>

					<xsl:if test="@s3">
						<xsl:text> </xsl:text>
						<xsl:value-of select="@s3" />
					</xsl:if>
					<xsl:if test="@s1">
						<xsl:text> </xsl:text>
						<xsl:value-of select="@s1" />
					</xsl:if>
					<xsl:if test="@s2">
						<xsl:text> </xsl:text>
						<xsl:value-of select="@s2" />
					</xsl:if>
				</xsl:for-each>
				<xsl:text>:</xsl:text>
			</xsl:if>
		</td><!-- author -->

		<td class="incipit">
			<xsl:if test="v2">
				<xsl:text> </xsl:text>
				<em>
					<xsl:value-of select="v2/@value" />
					<xsl:text>&#x2026;</xsl:text>
				</em>
			</xsl:if>
		</td><!-- incipit -->

		<td class="title">
			<xsl:if test="v3">
				<xsl:for-each select="v3">
					<xsl:if test="position() &gt; 1">
						<xsl:text>; </xsl:text>
					</xsl:if>
					<xsl:text>(</xsl:text>
					<xsl:choose>
						<xsl:when test="substring(./@value, 1, 2) = 'Ps'">
							<xsl:value-of select="substring(./@value, 1, 3)" />
							<xsl:value-of select="number(substring(./@value, 4, 3))" />
							<xsl:text>=</xsl:text>
							<xsl:value-of select="number(substring(./@value, 8, 3))" />
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="./@value" />
						</xsl:otherwise>
					</xsl:choose>
					<xsl:text>)</xsl:text>
				</xsl:for-each>
			</xsl:if>
		</td><!-- title -->
	</tr>
</xsl:template>

</xsl:stylesheet>