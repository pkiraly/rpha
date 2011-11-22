<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0"
                xmlns:marc="http://www.loc.gov/MARC21/slim"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:php="http://php.net/xsl"
                exclude-result-prefixes="php marc">

  <xsl:output method="html" indent="yes" encoding="utf-8"/>
  <xsl:param name="recNum" select="0001"/>

<xsl:template match="/">
<div class="analizis">
	<xsl:if test="repert/rec[1]/v1">
		<xsl:attribute name="id">
			<xsl:text>analizis</xsl:text>
			<xsl:value-of select="number(substring(repert/rec[1]/v1/@value, 1, 4))" />
		</xsl:attribute>
	</xsl:if>
	
	<h3><span>analyticum</span></h3>
	<xsl:apply-templates select="repert/rec[1]" mode="books"/>
	
	<h4 style="clear: both">
		<a>
			<xsl:attribute name="href" select="concat('/rpha/newversion/', repert/rec[1]/v1/@value)" />
			<xsl:text>új változat</xsl:text>
		</a>
		//
		<a href="/rpha/newbook">új forrás</a>
	</h4>

	<xsl:apply-templates select="repert" mode="versions_by_book"/>
	<xsl:apply-templates select="repert" mode="versions_by_title"/>
</div>
</xsl:template>
  
<xsl:template match="repert" mode="versions_by_book">
	<xsl:if test="rec[v91/@value=5]">
		<h4 style="clear: both">változatok forrásonként</h4>
		<table width="100%" cellspacing="0">
			<tr>
	 			<th width="20%">forrás</th>
	 			<th width="20%">mező</th>
	 			<th>változat</th>
			</tr>
			<xsl:for-each select="rec[v91/@value=5]">
				<xsl:variable name="bookId" select="v200/@value"/>
				<!-- a v43 együtt a v42-vel, ezért nem írjuk külön -->
				<xsl:for-each select="*[name(.) != 'v43' and name(.) != 'v91' and name(.) != 'v200' and name(.) != 'v201' and name(.) != 'v52']">
					<tr valign="top">
						<td>
							<xsl:if test="position() = 1">
								<xsl:attribute name="style">border-top: 1px solid #ccc; color: cornflowerblue; font-weight: bold;</xsl:attribute>
					 			<xsl:value-of select="//rec[@id = $bookId]/v122/@value"/>
							</xsl:if>
				 		</td>
		 				<td>
							<xsl:attribute name="style"><xsl:text>border-top: 1px solid #ccc; text-align: right; padding-right: 2px;</xsl:text></xsl:attribute>
	 						<em>
			 					<xsl:call-template name="fieldNameConverter">
			 						<xsl:with-param name="fieldName" select="name(.)"/>
			 					</xsl:call-template>
		 						<xsl:text>: </xsl:text>
	 						</em>
		 				</td>
		 				<td>
		 					<!-- ÉRTÉKEK -->
							<xsl:attribute name="style"><xsl:text>border-top: 1px dotted #ccc;</xsl:text></xsl:attribute>
		 					<xsl:choose>
				 				<xsl:when test="name(.) = 'v5'">
				 					<xsl:call-template name="v5">
				 						<xsl:with-param name="s1" select="@s1"/>
				 						<xsl:with-param name="s2" select="@s2"/>
				 						<xsl:with-param name="s3" select="@s3"/>
				 					</xsl:call-template>
								</xsl:when>
				 				<xsl:when test="name(.) = 'v11'">
				 					<xsl:call-template name="v11"><xsl:with-param name="value" select="@value"/></xsl:call-template>
								</xsl:when>
				 				<xsl:when test="name(.) = 'v18'">
				 					<xsl:call-template name="v18"><xsl:with-param name="value" select="@value"/></xsl:call-template>
								</xsl:when>
				 				<xsl:when test="name(.) = 'v21'">
				 					<xsl:call-template name="v21"><xsl:with-param name="value" select="@value"/></xsl:call-template>
								</xsl:when>
				 				<xsl:when test="name(.) = 'v23'">
				 					<xsl:call-template name="v23"><xsl:with-param name="value" select="@value"/></xsl:call-template>
								</xsl:when>
				 				<xsl:when test="name(.) = 'v24'">
				 					<xsl:call-template name="v24"><xsl:with-param name="value" select="@value"/></xsl:call-template>
								</xsl:when>
				 				<xsl:when test="name(.) = 'v30'">
				 					<xsl:call-template name="v30"><xsl:with-param name="value" select="@value"/></xsl:call-template>
								</xsl:when>
				 				<xsl:when test="name(.) = 'v32'">
				 					<xsl:for-each select="@*">
				 						<xsl:if test="position() > 1">
				 							<xsl:text>, </xsl:text>
				 						</xsl:if>
					 					<xsl:call-template name="v32">
					 						<xsl:with-param name="name" select="name(.)"/>
					 					</xsl:call-template>
				 						<xsl:value-of select="."/>
				 					</xsl:for-each>
								</xsl:when>
				 				<xsl:when test="name(.) = 'v33'">
				 					<xsl:call-template name="v33"><xsl:with-param name="value" select="@value"/></xsl:call-template>
								</xsl:when>
				 				<xsl:when test="name(.) = 'v35'">
				 					<xsl:for-each select="@*[. != '' and . != '']">
				 						<xsl:if test="position() > 1">
				 							<xsl:text>, </xsl:text>
				 						</xsl:if>
					 					<xsl:call-template name="v35">
					 						<xsl:with-param name="name" select="name(.)"/>
					 					</xsl:call-template>
				 						<xsl:value-of select="."/>
				 					</xsl:for-each>
								</xsl:when>
				 				<xsl:when test="name(.) = 'v41'">
				 					<xsl:call-template name="v41"><xsl:with-param name="value" select="@value"/></xsl:call-template>
								</xsl:when>
				 				<xsl:when test="name(.) = 'v42'">
				 					<xsl:value-of select="@value"/>
				 					<xsl:call-template name="v43"><xsl:with-param name="value" select="../v43/@value"/></xsl:call-template>
								</xsl:when>
				 				<xsl:when test="name(.) = 'v43'"></xsl:when>
				 				<xsl:when test="name(.) = 'v44'">
				 					<xsl:call-template name="v44"><xsl:with-param name="value" select="@value"/></xsl:call-template>
								</xsl:when>
								<xsl:when test="name(.) = 'v48'">
									<xsl:for-each select="@*">
										<xsl:if test="position() > 1">
											<br/>
										</xsl:if>
										<xsl:call-template name="v48attribs">
											<xsl:with-param name="name" select="name(.)"/>
											<xsl:with-param name="value" select="."/>
										</xsl:call-template>
									</xsl:for-each>
								</xsl:when>
				 				<xsl:when test="name(.) = 'v61'">
									<xsl:if test="@s1">
					 					<!-- a>
					 						<xsl:attribute name="href" select="concat('/rpha/id/', .)" / -->
							 				<xsl:value-of select="@s1"/>
					 					<!-- /a -->
					 				</xsl:if>
					 				<xsl:if test="@s2 and @s2=1">(kotta)</xsl:if>
					 				<xsl:if test="@s3">megjegyzés: <xsl:value-of select="@s3"/></xsl:if>
								</xsl:when>
				 				<xsl:when test="name(.) = 'v56'">
				 					<xsl:if test="@value != 'null'">
										<xsl:call-template name="v56">
											<xsl:with-param name="value" select="@value"/>
										</xsl:call-template>
										<xsl:for-each select="@*">
											<xsl:if test="name(.) != 'value'">
												<xsl:if test="position() > 1">
													<br/>
												</xsl:if>
												<em>
													<xsl:call-template name="v56Attribs">
														<xsl:with-param name="name" select="name(.)"/>
														<xsl:with-param name="value" select="."/>
													</xsl:call-template>
												</em>
											</xsl:if>
										</xsl:for-each>
									</xsl:if>
								</xsl:when>
				 				<xsl:when test="name(.) = 'v164'">
				 					<xsl:call-template name="v164"><xsl:with-param name="value" select="@value"/></xsl:call-template>
								</xsl:when>
				 				<xsl:otherwise>
					 				<xsl:value-of select="@value"/>
								</xsl:otherwise>
		 					</xsl:choose>
		 				</td>
					</tr>
				</xsl:for-each>
			</xsl:for-each>
		</table>
	</xsl:if>
</xsl:template>

<xsl:template match="repert" mode="versions_by_title">
	<xsl:if test="rec[v91/@value=5]">
		<h4>változatok mezőnként</h4>
		<table width="100%" cellspacing="0">
			<tr valign="top">
	 			<th width="20%">mező</th>
	 			<th width="60%">változat</th>
	 			<th width="20%">forrás</th>
			</tr>
			<xsl:call-template name="fields"><xsl:with-param name="fieldName" select="'v2'"/></xsl:call-template>
			<xsl:call-template name="fields"><xsl:with-param name="fieldName" select="'v167'"/></xsl:call-template>
			<xsl:call-template name="fields"><xsl:with-param name="fieldName" select="'v166'"/></xsl:call-template>
			<xsl:call-template name="fields"><xsl:with-param name="fieldName" select="'v3'"/></xsl:call-template>
			<xsl:call-template name="fields"><xsl:with-param name="fieldName" select="'v5'"/></xsl:call-template>
			<xsl:call-template name="fields"><xsl:with-param name="fieldName" select="'v11'"/></xsl:call-template>
			<xsl:call-template name="fields"><xsl:with-param name="fieldName" select="'v18'"/></xsl:call-template>
			<xsl:call-template name="fields"><xsl:with-param name="fieldName" select="'v21'"/></xsl:call-template>
			<xsl:call-template name="fields"><xsl:with-param name="fieldName" select="'v22'"/></xsl:call-template>
			<xsl:call-template name="fields"><xsl:with-param name="fieldName" select="'v23'"/></xsl:call-template>
			<xsl:call-template name="fields"><xsl:with-param name="fieldName" select="'v24'"/></xsl:call-template>
			<xsl:call-template name="fields"><xsl:with-param name="fieldName" select="'v30'"/></xsl:call-template>
			<xsl:call-template name="fields"><xsl:with-param name="fieldName" select="'v32'"/></xsl:call-template>
			<xsl:call-template name="fields"><xsl:with-param name="fieldName" select="'v31'"/></xsl:call-template>
			<xsl:call-template name="fields"><xsl:with-param name="fieldName" select="'v33'"/></xsl:call-template>
			<xsl:call-template name="fields"><xsl:with-param name="fieldName" select="'v34'"/></xsl:call-template>
			<xsl:call-template name="fields"><xsl:with-param name="fieldName" select="'v35'"/></xsl:call-template>
			<xsl:call-template name="fields"><xsl:with-param name="fieldName" select="'v39'"/></xsl:call-template>
			<xsl:call-template name="fields"><xsl:with-param name="fieldName" select="'v41'"/></xsl:call-template>
			<xsl:call-template name="fields"><xsl:with-param name="fieldName" select="'v42'"/></xsl:call-template>
			<!-- a v43-at együtt kezeljük a v42-vel -->
			<!-- xsl:call-template name="fields"><xsl:with-param name="fieldName" select="'v43'"/></xsl:call-template -->
			<xsl:call-template name="fields"><xsl:with-param name="fieldName" select="'v44'"/></xsl:call-template>
			<xsl:call-template name="fields"><xsl:with-param name="fieldName" select="'v45'"/></xsl:call-template>
			<xsl:call-template name="fields"><xsl:with-param name="fieldName" select="'v56'"/></xsl:call-template>
			<xsl:call-template name="fields"><xsl:with-param name="fieldName" select="'v61'"/></xsl:call-template>
		</table>
	</xsl:if>
</xsl:template>

<xsl:template name="fields">
	<xsl:param name="fieldName"/>
	<xsl:variable name="fieldTitle">
		<xsl:call-template name="fieldNameConverter">
			<xsl:with-param name="fieldName" select="$fieldName"/>
		</xsl:call-template>
	</xsl:variable>

	<xsl:for-each select="//rec[v91/@value=5 and child::*[name() = $fieldName]]">
		<xsl:variable name="bookId" select="v200/@value"/>
		<tr valign="top">
			<td>
				<xsl:if test="position() = 1">
					<xsl:attribute name="style">border-top: 1px solid #ccc; color: cornflowerblue; font-weight: bold;</xsl:attribute>
		 			<xsl:value-of select="$fieldTitle"/>
				</xsl:if>
			</td>
 			<td>
				<xsl:attribute name="style"><xsl:text>border-top: 1px dotted #ccc;</xsl:text></xsl:attribute>
 				<xsl:choose>
	 				<xsl:when test="$fieldName = 'v5'">
	 					<xsl:call-template name="v5">
	 						<xsl:with-param name="s1" select="child::*[name() = $fieldName]/@s1"/>
	 						<xsl:with-param name="s2" select="child::*[name() = $fieldName]/@s2"/>
	 						<xsl:with-param name="s3" select="child::*[name() = $fieldName]/@s3"/>
	 					</xsl:call-template>
					</xsl:when>
	 				<xsl:when test="$fieldName = 'v11'">
	 					<xsl:call-template name="v11"><xsl:with-param name="value" select="child::*[name() = $fieldName]/@value"/></xsl:call-template>
					</xsl:when>
	 				<xsl:when test="$fieldName = 'v18'">
	 					<xsl:call-template name="v18"><xsl:with-param name="value" select="child::*[name() = $fieldName]/@value"/></xsl:call-template>
					</xsl:when>
	 				<xsl:when test="$fieldName = 'v21'">
	 					<xsl:call-template name="v21"><xsl:with-param name="value" select="child::*[name() = $fieldName]/@value"/></xsl:call-template>
					</xsl:when>
	 				<xsl:when test="$fieldName = 'v23'">
	 					<xsl:call-template name="v23"><xsl:with-param name="value" select="child::*[name() = $fieldName]/@value"/></xsl:call-template>
					</xsl:when>
	 				<xsl:when test="$fieldName = 'v24'">
	 					<xsl:call-template name="v24"><xsl:with-param name="value" select="child::*[name() = $fieldName]/@value"/></xsl:call-template>
					</xsl:when>
	 				<xsl:when test="$fieldName = 'v30'">
	 					<xsl:call-template name="v30"><xsl:with-param name="value" select="child::*[name() = $fieldName]/@value"/></xsl:call-template>
					</xsl:when>
	 				<xsl:when test="$fieldName = 'v32'">
	 					<xsl:for-each select="child::*[name() = $fieldName]/@*">
	 						<xsl:if test="position() > 1">
	 							<xsl:text>, </xsl:text>
	 						</xsl:if>
		 					<xsl:call-template name="v32">
		 						<xsl:with-param name="name" select="name(.)"/>
		 					</xsl:call-template>
	 						<xsl:value-of select="."/>
	 					</xsl:for-each>
					</xsl:when>
	 				<xsl:when test="$fieldName = 'v33'">
	 					<xsl:call-template name="v33"><xsl:with-param name="value" select="child::*[name() = $fieldName]/@value"/></xsl:call-template>
					</xsl:when>
	 				<xsl:when test="$fieldName = 'v35'">
	 					<xsl:for-each select="child::*[name() = $fieldName]/@*">
	 						<xsl:if test="position() > 1">
	 							<xsl:text>, </xsl:text>
	 						</xsl:if>
		 					<xsl:call-template name="v35">
		 						<xsl:with-param name="name" select="name(.)"/>
		 					</xsl:call-template>
	 						<xsl:value-of select="."/>
	 					</xsl:for-each>
					</xsl:when>
	 				<xsl:when test="$fieldName = 'v41'">
	 					<xsl:call-template name="v41"><xsl:with-param name="value" select="child::*[name() = $fieldName]/@value"/></xsl:call-template>
					</xsl:when>
	 				<xsl:when test="$fieldName = 'v42'">
	 					<xsl:value-of select="child::*[name() = $fieldName]/@value"/>
	 					<xsl:call-template name="v43"><xsl:with-param name="value" select="child::*[name() = 'v43']/@value"/></xsl:call-template>
					</xsl:when>
	 				<xsl:when test="$fieldName = 'v43'"></xsl:when>
	 				<xsl:when test="$fieldName = 'v44'">
	 					<xsl:call-template name="v44"><xsl:with-param name="value" select="child::*[name() = $fieldName]/@value"/></xsl:call-template>
					</xsl:when>
					<xsl:when test="name(.) = 'v48'">
						<xsl:for-each select="child::*[name() = $fieldName]/@*">
							<xsl:if test="position() > 1">
								<br/>
							</xsl:if>
							<xsl:call-template name="v48attribs">
								<xsl:with-param name="name" select="name(.)"/>
								<xsl:with-param name="value" select="."/>
							</xsl:call-template>
						</xsl:for-each>
					</xsl:when>
 					<xsl:when test="$fieldName = 'v61'">
		 				<xsl:if test="child::*[name() = $fieldName]/@s1">
		 					<!--a>
								<xsl:attribute name="href" select="concat('/rpha/id/', child::*[name() = $fieldName]/@value)" / -->
								<xsl:value-of select="child::*[name() = $fieldName]/@s1"/>
		 					<!-- /a -->
		 				</xsl:if>
		 				<xsl:if test="child::*[name() = $fieldName]/@s2 and child::*[name() = $fieldName]/@s2 = 1">(kotta)</xsl:if>
		 				<xsl:if test="child::*[name() = $fieldName]/@s3">
		 					<xsl:value-of select="child::*[name() = $fieldName]/@s3"/>
	 					</xsl:if>
					</xsl:when>
 					<xsl:when test="$fieldName = 'v56'">
	 					<xsl:if test="child::*[name() = $fieldName]/@value != 'null'">
							<xsl:call-template name="v56">
								<xsl:with-param name="value" select="child::*[name() = $fieldName]/@value"/>
							</xsl:call-template>
							<xsl:for-each select="child::*[name() = $fieldName]/@*">
								<xsl:if test="name(.) != 'value'">
									<xsl:if test="position() > 1">
										<br/>
									</xsl:if>
									<em>
										<xsl:call-template name="v56Attribs">
											<xsl:with-param name="name" select="name(.)"/>
											<xsl:with-param name="value" select="."/>
										</xsl:call-template>
									</em>
								</xsl:if>
							</xsl:for-each>
						</xsl:if>
					</xsl:when>
	 				<xsl:when test="name(.) = 'v164'">
	 					<xsl:call-template name="v164"><xsl:with-param name="value" select="child::*[name() = $fieldName]/@value"/></xsl:call-template>
					</xsl:when>
					<xsl:otherwise><xsl:value-of select="child::*[name() = $fieldName]/@value"/></xsl:otherwise>
 				</xsl:choose>
			</td>

 			<!-- xsl:value-of select="child::*[name() = $fieldName]/@value"/></td-->
 			<td>
				<xsl:attribute name="style"><xsl:text>border-top: 1px solid #ccc;</xsl:text></xsl:attribute>
 				<xsl:value-of select="//rec[@id = $bookId]/v122/@value"/>
 			</td>
		</tr>
	</xsl:for-each>
</xsl:template>

<xsl:template match="rec" mode="books">

	<xsl:if test="v52">
		<xsl:for-each select="v52">
			<xsl:variable name="versionId" select="concat(../@id, '-', @bookId)" />
			<xsl:variable name="version" select="//rec[@id = $versionId]" />
			<div class="box ms">
				<xsl:attribute name="class">
					<xsl:text>box ms</xsl:text>
					<xsl:if test="(position() mod 6) = 1">
						<xsl:text> first</xsl:text>
					</xsl:if>
					<xsl:if test="(position() mod 6) = 0">
						<xsl:text> last</xsl:text>
					</xsl:if>
					
					<xsl:if test="count($version) != 0">
						<xsl:text> version</xsl:text>
					</xsl:if>
				</xsl:attribute>
				
				<a>
					<xsl:attribute name="href">
						<xsl:text>BASE_PATH/editversion/</xsl:text>
						<xsl:value-of select="../v1/@value" />
						<xsl:text>/</xsl:text>
						<xsl:value-of select="@bookId"/>
					</xsl:attribute>
				
					<xsl:call-template name="hubook">
						<xsl:with-param name="id" select="../v1/@value"/>
						<xsl:with-param name="value" select="@value"/>
					</xsl:call-template>
				</a>
			</div>
		</xsl:for-each>
	</xsl:if>

	<xsl:if test="v51">
		<xsl:for-each select="v51">
			<xsl:variable name="versionId" select="concat(../@id, '-', @bookId)" />
			<xsl:variable name="version" select="//rec[@id = $versionId]" />
			<div class="box book">
				<xsl:attribute name="class">
					<xsl:text>box book</xsl:text>
					<xsl:if test="(position() mod 6) = 1">
						<xsl:text> first</xsl:text>
					</xsl:if>
					<xsl:if test="(position() mod 6) = 0">
						<xsl:text> last</xsl:text>
					</xsl:if>
					
					<xsl:if test="count($version) != 0">
						<xsl:text> version</xsl:text>
					</xsl:if>
				</xsl:attribute>

				<a>
					<xsl:attribute name="href">
						<xsl:text>BASE_PATH/editversion/</xsl:text>
						<xsl:value-of select="../v1/@value" />
						<xsl:text>/</xsl:text>
						<xsl:value-of select="@bookId"/>
					</xsl:attribute>

					<xsl:call-template name="hubook">
						<xsl:with-param name="id" select="../v1/@value"/>
						<xsl:with-param name="value" select="@value"/>
					</xsl:call-template>
				</a>
			</div>
		</xsl:for-each>
	</xsl:if>
</xsl:template>

<xsl:template name="hubook">
	<xsl:param name="id"/>
	<xsl:param name="value"/>
	
    <xsl:variable name="mainRec" select="//rec[v1/@value = $id]" />
    <xsl:variable name="n" select="$id"/>
    <xsl:variable name="z1" select="$value"/>
    <xsl:variable name="forrasTipusKod" select="substring($value, 1, 2)"/>
    <xsl:variable name="itemMainId" select="substring($value, 4, 4)"/>
    <xsl:variable name="itemSubnote" select="substring($value, 8, 1)"/>
    <xsl:variable name="itemSubId" select="substring($value, 9, 1)"/>
    <xsl:variable name="page" select="substring($value, 14, 4)"/>
    <xsl:variable name="pageSubnote" select="substring($value, 18, 1)"/>
    <xsl:variable name="pageSubid" select="substring($value, 19)"/>
    
    <xsl:variable name="v101">
	    <xsl:choose>
			<xsl:when test="$forrasTipusKod = '18'"><xsl:text>MKEVB1</xsl:text></xsl:when>
			<xsl:when test="$forrasTipusKod = '19'"><xsl:text>MKEVB0</xsl:text></xsl:when>
			<xsl:when test="$forrasTipusKod = '27'"><xsl:text>RMG</xsl:text></xsl:when>
			<xsl:when test="$forrasTipusKod = '28'"><xsl:text>RMNY</xsl:text></xsl:when>
			<xsl:when test="$forrasTipusKod = '29'"><xsl:text>RMK1</xsl:text></xsl:when>
		</xsl:choose>
    </xsl:variable>

    <xsl:variable name="itemId">
		<xsl:value-of select="$itemMainId" />
		<xsl:if test="$itemSubnote = '/'">
			<xsl:value-of select="$itemSubId" />
		</xsl:if>
    </xsl:variable>

    <xsl:variable name="forrasAzonosito">
		<xsl:value-of select="$v101" />
		<xsl:text>-</xsl:text>
		<xsl:value-of select="$itemId" />
    </xsl:variable>

	<xsl:variable name="book">
		<xsl:choose>
			<xsl:when test="//rec[v101/@value = $v101 and v111/@value = $itemId]">
				<xsl:copy-of select="//rec[v101/@value = $v101 and v111/@value = $itemId]/*" />
			</xsl:when>
			<xsl:when test="//rec[v101/@value = $v101 and v111/@value = $itemMainId]">
				<xsl:copy-of select="//rec[v101/@value = $v101 and v111/@value = $itemMainId]/*" />
			</xsl:when>
		</xsl:choose>
	</xsl:variable>

    <xsl:variable name="forrasRovidites">
		<xsl:text> </xsl:text>
	    <xsl:choose>
			<xsl:when test="$forrasTipusKod = '18'">(S </xsl:when>
			<xsl:when test="$forrasTipusKod = '19'">(H </xsl:when>
			<xsl:when test="$forrasTipusKod = '27'">(HH </xsl:when>
			<xsl:when test="$forrasTipusKod = '28'">(RMNy </xsl:when>
			<xsl:when test="$forrasTipusKod = '29'">(RMK I </xsl:when>
		</xsl:choose>
		<xsl:value-of select="number($itemMainId)" />
		<xsl:if test="$itemSubnote = '/'">
			<xsl:value-of select="concat($itemSubnote, $itemSubId)" />
		</xsl:if>
		<xsl:if test="$itemSubnote = '-'">
			<xsl:value-of select="concat('/', $itemSubId)" />
		</xsl:if>
		<xsl:if test="$book/v55"><!-- FACS, facsimile kiadások -->
			<xsl:text>, [fakszimile kiadás]</xsl:text>
		</xsl:if>
		<xsl:text>)</xsl:text>
    </xsl:variable>
	
	<!-- KIIRATÁS -->
	<i>
		<xsl:choose>
			<!-- eredeti cím -->
			<xsl:when test="$book/v122/@value != ''"><xsl:value-of select="$book/v122/@value"/></xsl:when>
			<!-- új cím -->
			<xsl:otherwise><xsl:value-of select="$book/v121/@value"/></xsl:otherwise>
		</xsl:choose>
	</i>

	<!-- nyomdahely -->
	<xsl:if test="substring($forrasTipusKod, 1, 1) = '2'">
		<xsl:text> </xsl:text>
		<xsl:choose>
			<xsl:when test="$book/v131/@value != ''"><xsl:value-of select="$book/v131/@value"/></xsl:when>
			<xsl:otherwise><xsl:text>***</xsl:text></xsl:otherwise>
		</xsl:choose>
	</xsl:if>

	<!-- idopont -->
	<xsl:text>, </xsl:text>
	<xsl:choose>
		<xsl:when test="$book/v132/@value != ''"><xsl:value-of select="$book/v132/@value"/></xsl:when>
		<xsl:otherwise><xsl:text>***</xsl:text></xsl:otherwise>
	</xsl:choose>

	<!-- felekezet -->
	<xsl:for-each select="$book/v142">
		<xsl:variable name="felekezetCode" select="substring(., 1, 1)" />
		<xsl:choose>
			<xsl:when test="$felekezetCode = 'p'"><xsl:text> {protestáns}</xsl:text></xsl:when>
			<xsl:when test="$felekezetCode = 'e'"><xsl:text> {evangélikus}</xsl:text></xsl:when>
			<xsl:when test="$felekezetCode = 'r'"><xsl:text> {református}</xsl:text></xsl:when>
			<xsl:when test="$felekezetCode = 'm'"><xsl:text> {muzulmán}</xsl:text></xsl:when>
			<xsl:when test="$felekezetCode = 'v'"><xsl:text> {világi}</xsl:text></xsl:when>
			<xsl:when test="$felekezetCode = 'k'"><xsl:text> {katolikus}</xsl:text></xsl:when>
			<xsl:when test="$felekezetCode = 'u'"><xsl:text> {unitárius}</xsl:text></xsl:when>
			<xsl:when test="$felekezetCode = 's'"><xsl:text> {szombatos}</xsl:text></xsl:when>
		</xsl:choose>
	</xsl:for-each>

	<xsl:value-of select="$forrasRovidites"/>
	
	<!-- page nr -->
	<xsl:if test="string-length($page) > 0">
		<xsl:choose>
			<xsl:when test="$forrasRovidites = ''"><xsl:text>p. </xsl:text></xsl:when>
			<xsl:otherwise><xsl:text> p. </xsl:text></xsl:otherwise>
		</xsl:choose>
		<xsl:value-of select="number($page)"/>
		<xsl:if test="$pageSubnote != ''">
			<xsl:element name="sup">
			    <xsl:if test="$pageSubid = 'A'"><xsl:text>r</xsl:text></xsl:if>
			    <xsl:if test="$pageSubid = 'B'"><xsl:text>v</xsl:text></xsl:if>
			</xsl:element>
		</xsl:if>
	</xsl:if>

</xsl:template>

<xsl:template name="fieldNameConverter">
	<xsl:param name="fieldName"/>
	<xsl:choose>
		<xsl:when test="$fieldName = 'v2'">kezdősor</xsl:when>
		<xsl:when test="$fieldName = 'v3'">cím</xsl:when>
		<xsl:when test="$fieldName = 'v166'">élőfej</xsl:when>
		<xsl:when test="$fieldName = 'v167'">főcím</xsl:when>
		<xsl:when test="$fieldName = 'v5'">szerző</xsl:when>
		<xsl:when test="$fieldName = 'v11'">irodalmi minta</xsl:when>
		<xsl:when test="$fieldName = 'v18'">nyelv</xsl:when>
		<xsl:when test="$fieldName = 'v21'">ideje</xsl:when>
		<xsl:when test="$fieldName = 'v22'">ideje</xsl:when>
		<xsl:when test="$fieldName = 'v23'">ének/szöveg?</xsl:when>
		<xsl:when test="$fieldName = 'v24'">szignáltság?</xsl:when>
		<xsl:when test="$fieldName = 'v30'">kolofon?</xsl:when>
		<xsl:when test="$fieldName = 'v32'">kolofon</xsl:when>
		<xsl:when test="$fieldName = 'v31'">ajánlás</xsl:when>
		<xsl:when test="$fieldName = 'v33'">akrosztikon?</xsl:when>
		<xsl:when test="$fieldName = 'v34'">akrosztikon</xsl:when>
		<xsl:when test="$fieldName = 'v35'">akrosztikon adatai</xsl:when>
		<xsl:when test="$fieldName = 'v39'">megjegyzések</xsl:when>
		<xsl:when test="$fieldName = 'v41'">teljes-e?</xsl:when>
		<xsl:when test="$fieldName = 'v42'">terjedelem</xsl:when>
		<xsl:when test="$fieldName = 'v43'">mértékegysége</xsl:when>
		<xsl:when test="$fieldName = 'v44'">metrum típus</xsl:when>
		<xsl:when test="$fieldName = 'v45'">metrum</xsl:when>
		<xsl:when test="$fieldName = 'v51'">nyomtatott forrás</xsl:when>
		<xsl:when test="$fieldName = 'v56'">műfaj</xsl:when>
		<xsl:when test="$fieldName = 'v61'">nótajelzés</xsl:when>
		<xsl:otherwise><xsl:value-of select="$fieldName" /></xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="v5">
	<xsl:param name="s1"/>
	<xsl:param name="s2"/>
	<xsl:param name="s3"/>
	<xsl:comment>* v5: '<xsl:value-of select="$s1"/>', '<xsl:value-of select="$s2"/>', '<xsl:value-of select="$s3"/>' *</xsl:comment>
	<xsl:if test="$s1">
		<xsl:value-of select="$s1"/>
	</xsl:if>
	<xsl:if test="$s2">
		<xsl:if test="$s1"> </xsl:if>
		<xsl:value-of select="$s2"/>
	</xsl:if>
	<xsl:if test="$s3">
		<xsl:value-of select="$s3"/>
	</xsl:if>
</xsl:template>

<xsl:template name="v11">
	<xsl:param name="value"/>
	<xsl:comment><xsl:value-of select="$value"/></xsl:comment>
	<xsl:choose>
		<xsl:when test="$value = '1'">nem tudjuk megállapítani</xsl:when>
		<xsl:when test="$value = '2'">meghatározható közvetlen minta</xsl:when>
		<xsl:when test="$value = '3'">bizonyosan közvetlen minta</xsl:when>
		<xsl:when test="$value = '4'">nem tudjuk, hogy volt-e mintája</xsl:when>
	</xsl:choose>
</xsl:template>

<xsl:template name="v18">
	<xsl:param name="value"/>
	<xsl:comment><xsl:value-of select="$value"/></xsl:comment>
	<xsl:choose>
		<xsl:when test="$value = 'all'">német</xsl:when>
		<xsl:when test="$value = 'gre'">gre</xsl:when>
		<xsl:when test="$value = 'cro'">horvát</xsl:when>
		<xsl:when test="$value = 'hon'">magyar</xsl:when>
		<xsl:when test="$value = 'lat'">latin</xsl:when>
	</xsl:choose>
</xsl:template>

<xsl:template name="v21">
	<xsl:param name="value"/>
	<xsl:comment><xsl:value-of select="$value"/></xsl:comment>
	<xsl:choose>
		<xsl:when test="$value = '1'">pontosan</xsl:when>
		<xsl:when test="$value = '2'">nem később, mint</xsl:when>
		<xsl:when test="$value = '3'">nem korábban, mint</xsl:when>
		<xsl:when test="$value = '4'">kb.</xsl:when>
		<xsl:when test="$value = '5'">korábban, mint kb.</xsl:when>
		<xsl:when test="$value = '6'">x és y között</xsl:when>
		<xsl:when test="$value = '7'">vagy</xsl:when>
	</xsl:choose>
</xsl:template>

<xsl:template name="v23">
	<xsl:param name="value"/>
	<xsl:comment><xsl:value-of select="$value"/></xsl:comment>
	<xsl:choose>
		<xsl:when test="$value = '1'">A vers szövegvers</xsl:when>
		<xsl:when test="$value = '2'">A vers énekvers</xsl:when>
		<xsl:when test="$value = '3'">Bizonytalan, hogy énekelték-e</xsl:when>
	</xsl:choose>
</xsl:template>

<xsl:template name="v24">
	<xsl:param name="value"/>
	<xsl:comment><xsl:value-of select="$value"/></xsl:comment>
	<xsl:choose>
		<xsl:when test="$value = '1'">a szerző névmegjelölésével</xsl:when>
		<xsl:when test="$value = '2'">szerzőjét nem ismerjük</xsl:when>
		<xsl:when test="$value = '3'">a szerzőnek tulajdonították</xsl:when>
		<xsl:when test="$value = '4'">modern kutatás alapján</xsl:when>
		<xsl:when test="$value = '5'">gyűjtemény a szerző neve alatt</xsl:when>
		<xsl:when test="$value = '6'">anagrammatikusan szignált</xsl:when>
	</xsl:choose>
</xsl:template>

<xsl:template name="v30">
	<xsl:param name="value"/>
	<xsl:comment><xsl:value-of select="$value"/></xsl:comment>
	<xsl:choose>
		<xsl:when test="$value = '1'">A versnek van kolofonja</xsl:when>
		<xsl:when test="$value = '2'">A versnek nincs kolofonja</xsl:when>
		<xsl:when test="$value = '3'">Nem tudjuk</xsl:when>
	</xsl:choose>
</xsl:template>

<xsl:template name="v32">
	<xsl:param name="name"/>
	<xsl:choose>
		<xsl:when test="$name = 's1'">név</xsl:when>
		<xsl:when test="$name = 'sd'">idő</xsl:when>
		<xsl:when test="$name = 'sl'">hely</xsl:when>
	</xsl:choose>
	<xsl:text>: </xsl:text>
</xsl:template>

<xsl:template name="v33">
	<xsl:param name="value"/>
	<xsl:comment><xsl:value-of select="$value"/></xsl:comment>
	<xsl:choose>
		<xsl:when test="$value = '1'">A versnek van akrosztichonja</xsl:when>
		<xsl:when test="$value = '2'">A versnek nincs akrosztichonja</xsl:when>
		<xsl:when test="$value = '3'">Nem tudjuk</xsl:when>
	</xsl:choose>
</xsl:template>

<xsl:template name="v35">
	<xsl:param name="name"/>
	<xsl:choose>
		<xsl:when test="$name = 's1'">név</xsl:when>
		<xsl:when test="$name = 'sd'">idő</xsl:when>
		<xsl:when test="$name = 'sl'">hely</xsl:when>
	</xsl:choose>
	<xsl:text>: </xsl:text>
</xsl:template>

<xsl:template name="v41">
	<xsl:param name="value"/>
	<xsl:comment><xsl:value-of select="$value"/></xsl:comment>
	<xsl:choose>
		<xsl:when test="$value = '1'">A vers szövege teljes</xsl:when>
		<xsl:when test="$value = '2'">töredék - töredék terjedelme</xsl:when>
		<xsl:when test="$value = '3'">töredék - a vers terjedelme</xsl:when>
		<xsl:when test="$value = '4'">bizonytalan</xsl:when>
	</xsl:choose>
</xsl:template>

<xsl:template name="v43">
	<xsl:param name="value"/>
	<xsl:comment><xsl:value-of select="$value"/></xsl:comment>
	<xsl:choose>
		<xsl:when test="$value = '1'">versszak</xsl:when>
		<xsl:when test="$value = '2'">sor</xsl:when>
		<xsl:when test="$value = '3'">bekezdés</xsl:when>
	</xsl:choose>
</xsl:template>

<xsl:template name="v44">
	<xsl:param name="value"/>
	<xsl:comment><xsl:value-of select="$value"/></xsl:comment>
	<xsl:choose>
		<xsl:when test="$value = '1'">Szótagszámláló, izostrofikus vers</xsl:when>
		<xsl:when test="$value = '3'">Bizonytalan, hogy vers-e, vagy próza</xsl:when>
		<xsl:when test="$value = '4'">Bizonytalan verselésű időmértékes vers</xsl:when>
		<xsl:when test="$value = '5'">Bizonytalan verselésű szótagszámláló, izostrofikus vers</xsl:when>
		<xsl:when test="$value = '6'">Hexameter</xsl:when>
		<xsl:when test="$value = '7'">Disztichon</xsl:when>
		<xsl:when test="$value = '8'">Időmértékes vers, de nem hexameter vagy disztichon</xsl:when>
		<xsl:when test="$value = '10'">Hangsúlyos, nem strofikus, nem szótagszámláló rímtelen vers</xsl:when>
		<xsl:when test="$value = '11'">Bizonytalan, hogy vers-e, vagy ritmikus próza</xsl:when>
		<xsl:when test="$value = '12'">Verssorok és próza váltakozása</xsl:when>
		<xsl:when test="$value = '15'">Váltakozó metrumú</xsl:when>
		<xsl:when test="$value = '16'">Pesti Gábor-féle metrum</xsl:when>
		<xsl:when test="$value = '17'">Szótagszámláló vers</xsl:when>
		<xsl:when test="$value = '18'">Szószámláló vers</xsl:when>
		<xsl:when test="$value = '19'">Sequentiát imitáló vers</xsl:when>
		<xsl:when test="$value = '30'">Nótajelzés (metruma más vers metruma alapján van kikövetkeztetve)</xsl:when>
	</xsl:choose>
</xsl:template>

<xsl:template name="v48attribs">
	<xsl:param name="name"/>
	<xsl:param name="value"/>
	<xsl:choose>
		<xsl:when test="$name = 'sk'">katolikus: </xsl:when>
		<xsl:when test="$name = 'sp'">protestáns: </xsl:when>
		<xsl:when test="$name = 'sr'">református: </xsl:when>
		<xsl:when test="$name = 'se'">evangélikus: </xsl:when>
		<xsl:when test="$name = 'ss'">szombatos: </xsl:when>
		<xsl:when test="$name = 'su'">unitárius: </xsl:when>
		<xsl:when test="$name = 'sm'">muzulmán: </xsl:when>
		<xsl:when test="$name = 'sv'">világi: </xsl:when>
		<xsl:when test="$name = 'sx'">közelebről meg nem határozott: </xsl:when>
	</xsl:choose>
	<xsl:value-of select="$value" />
</xsl:template>

<xsl:template name="v56">
	<xsl:param name="value"/>
	<xsl:choose>
		<xsl:when test="$value = '1'">vallásos</xsl:when>
		<xsl:when test="$value = '48'">világi</xsl:when>
	</xsl:choose>
</xsl:template>

<xsl:template name="v56Attribs">
	<xsl:param name="name"/>
	<xsl:param name="value"/>
	<xsl:choose>
		<xsl:when test="$name = 'sa'">ünnep</xsl:when>
		<xsl:when test="$name = 'sj'">közönséges időben</xsl:when>
		<xsl:when test="$name = 'sb'">hét napjai</xsl:when>
		<xsl:when test="$name = 'sc'">napszakok</xsl:when>
		<xsl:when test="$name = 'sd'">istentisztelet</xsl:when>
		<xsl:when test="$name = 'se'">dogmatika</xsl:when>
		<xsl:when test="$name = 'sf'">alkalom</xsl:when>
		<xsl:when test="$name = 'sk'">egykorú műfaj</xsl:when>
		<xsl:when test="$name = 'sg'">tartalom 1</xsl:when>
		<xsl:when test="$name = 'sh'">tartalom 2</xsl:when>
		<xsl:when test="$name = 'si'">modern</xsl:when>
		<xsl:otherwise><xsl:value-of select="$name" /></xsl:otherwise>
	</xsl:choose>
	<xsl:text>: </xsl:text>
	<xsl:value-of select="$value" />
</xsl:template>

<xsl:template name="v61Attribs">
	<xsl:param name="name"/>
	<xsl:param name="value"/>
	<xsl:choose>
		<xsl:when test="$name = 's1'"></xsl:when>
		<xsl:when test="$name = 's2'">kotta van? </xsl:when>
		<xsl:when test="$name = 's3'">megjegyzés: </xsl:when>
	</xsl:choose>
	<xsl:value-of select="$value" />
</xsl:template>

<xsl:template name="v164">
	<xsl:param name="value"/>
	<xsl:choose>
		<xsl:when test="$value = '1'">Echós, a strófák végén</xsl:when>
		<xsl:when test="$value = '2'">Echós, a vers legvégén</xsl:when>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>