<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0"
                xmlns:mr="http://www.megarep.org"
                xmlns:rpha="http://tesuji.eu/rpha"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml" indent="yes" encoding="utf-8" omit-xml-declaration="yes" />
<xsl:param name="bookId"/>

<xsl:template match="/">
	<xsl:for-each select="//rec">
		<xsl:apply-templates select="." />
	</xsl:for-each>
</xsl:template>

<xsl:template match="rec">
	<table>
		<xsl:attribute name="id" select="@id" />

		<xsl:for-each select="*">
			<xsl:if test="name(.) = 'v2'
			           or name(.) = 'v3'
			           or name(.) = 'v5'
			           or name(.) = 'v18'
			           or name(.) = 'v20'
			           or name(.) = 'v21'
			           or name(.) = 'v23'
			           or name(.) = 'v28'
			           or name(.) = 'v42'
			           or name(.) = 'v44'
			           or name(.) = 'v46'
			           or name(.) = 'v47'
			">
				<tr>
					<td>
						<xsl:call-template name="code2tag">
							<xsl:with-param name="code">
								<xsl:value-of select="name(.)" />
							</xsl:with-param>
						</xsl:call-template>
					</td>
					<td>
						<xsl:choose>
							<xsl:when test="name(.) = 'v2'">
								<xsl:value-of select="concat('&#x201E;', @value, '&#x2026;&#x201D;')" />
							</xsl:when>
							<xsl:when test="name(.) = 'v5'">
								<xsl:value-of select="@s1" />
								<xsl:value-of select="' '" />
								<xsl:value-of select="@s2" />
								<xsl:value-of select="@s3" />
							</xsl:when>
							<xsl:when test="name(.) = 'v21'">
								<xsl:call-template name="v22">
									<xsl:with-param name="value" select="../v22/@value" />
								</xsl:call-template>
								<xsl:value-of select="@value" />
							</xsl:when>
							<xsl:when test="name(.) = 'v23'">
								<xsl:call-template name="v23">
									<xsl:with-param name="value" select="@value" />
								</xsl:call-template>
							</xsl:when>
							<xsl:when test="name(.) = 'v28'">
								<xsl:variable name="tags" select="@value" />
								<xsl:for-each select="tokenize(@value, ',')">
									<xsl:if test="position() > 1">
										<xsl:text> &gt; </xsl:text>
									</xsl:if>

									<a>
										<xsl:attribute name="href" select="concat('?genre1=', .)" />
										<xsl:call-template name="v28">
											<xsl:with-param name="code" select="number(.)" />
										</xsl:call-template>
									</a>
								</xsl:for-each>
							</xsl:when>
							
							<xsl:when test="name(.) = 'v42'">
								<xsl:value-of select="concat(@value, ' ')" />
								<xsl:call-template name="v43">
									<xsl:with-param name="value" select="../v43/@value" />
								</xsl:call-template>
							</xsl:when>
							<xsl:when test="name(.) = 'v44'">
								<xsl:call-template name="v44">
									<xsl:with-param name="value" select="@value" />
								</xsl:call-template>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="@value" />
							</xsl:otherwise>
						</xsl:choose>
					</td>
				</tr>
			</xsl:if>
			<!-- 
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

			<xsl:if test="$tag != '' and not(starts-with($tag, 'rpha')) 
						and not($tag = 'mr:language' and @value = 'hun')">
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
			 -->
		</xsl:for-each>
	</table>
</xsl:template>

<xsl:template name="code2tag">
	<xsl:param name="code" />

	<xsl:choose>
		<xsl:when test="$code = 'v1'"><xsl:text>rpha</xsl:text></xsl:when>
		<xsl:when test="$code = 'v2'"><xsl:text>kezdősor</xsl:text></xsl:when>
		<xsl:when test="$code = 'v3'"><xsl:text>cím</xsl:text></xsl:when>
		<xsl:when test="$code = 'v5'"><xsl:text>szerző</xsl:text></xsl:when>
		<xsl:when test="$code = 'v11'"><xsl:text>minta</xsl:text></xsl:when>
		<xsl:when test="$code = 'v12'"><xsl:text>minta kezdősora</xsl:text></xsl:when>
		<xsl:when test="$code = 'v13'"><xsl:text>minta címe</xsl:text></xsl:when>
		<xsl:when test="$code = 'v14'"><xsl:text>himnusz utalószáma</xsl:text></xsl:when>
		<xsl:when test="$code = 'v15'"><xsl:text>minta szerzője</xsl:text></xsl:when>
		<xsl:when test="$code = 'v18'"><xsl:text>eredeti nyelv</xsl:text></xsl:when>
		<xsl:when test="$code = 'v21'"><xsl:text>szereztetés ideje</xsl:text></xsl:when>
		<xsl:when test="$code = 'v22'"><xsl:text>szereztetés idejének pontosítása</xsl:text></xsl:when>
		<xsl:when test="$code = 'v23'"><xsl:text>ének/szöveg?</xsl:text></xsl:when>
		<xsl:when test="$code = 'v24'"><xsl:text>szignáltság</xsl:text></xsl:when>
		<xsl:when test="$code = 'v28'"><xsl:text>műfaj</xsl:text></xsl:when>
		<xsl:when test="$code = 'v30'"><xsl:text>kolofon?</xsl:text></xsl:when>
		<xsl:when test="$code = 'v31'"><xsl:text>ajánlás</xsl:text></xsl:when>
		<xsl:when test="$code = 'v32'"><xsl:text>doncolo</xsl:text></xsl:when>
		<xsl:when test="$code = 'v33'"><xsl:text>acr</xsl:text></xsl:when>
		<xsl:when test="$code = 'v34'"><xsl:text>acrost</xsl:text></xsl:when>
		<xsl:when test="$code = 'v35'"><xsl:text>donacr</xsl:text></xsl:when>
		<xsl:when test="$code = 'v39'"><xsl:text>comment</xsl:text></xsl:when>
		<xsl:when test="$code = 'v41'"><xsl:text>int</xsl:text></xsl:when>
		<xsl:when test="$code = 'v42'"><xsl:text>terjedelem</xsl:text></xsl:when>
		<xsl:when test="$code = 'v43'"><xsl:text>terjedelem mértékegysége</xsl:text></xsl:when>
		<xsl:when test="$code = 'v44'"><xsl:text>metrum típus</xsl:text></xsl:when>
		<xsl:when test="$code = 'v45'"><xsl:text>metrum</xsl:text></xsl:when>
		<xsl:when test="$code = 'v46'"><xsl:text>rímképlet</xsl:text></xsl:when>
		<xsl:when test="$code = 'v47'"><xsl:text>szótagszám</xsl:text></xsl:when>
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

<xsl:template name="v22">
	<xsl:param name="value" />
	<xsl:if test="$value = 1"></xsl:if>
	<xsl:if test="$value = 2">nem később, mint </xsl:if>
	<xsl:if test="$value = 3">nem korábban, mint </xsl:if>
	<xsl:if test="$value = 4">kb. </xsl:if>
	<xsl:if test="$value = 5">korábban, mint kb. </xsl:if>
	<xsl:if test="$value = 6"></xsl:if>
	<xsl:if test="$value = 7">vagy </xsl:if>
</xsl:template>

<xsl:template name="v23">
	<xsl:param name="value" />
	<xsl:if test="$value = 1">szövegvers</xsl:if>
	<xsl:if test="$value = 2">énekvers</xsl:if>
	<xsl:if test="$value = 3">bizonytalan, hogy énekelték-e</xsl:if>
</xsl:template>

<xsl:template name="v43">
	<xsl:param name="value" />
	<xsl:if test="$value = 1">versszak</xsl:if>
	<xsl:if test="$value = 2">sor</xsl:if>
	<xsl:if test="$value = 3">bekezdés</xsl:if>
</xsl:template>

<xsl:template name="v44">
	<xsl:param name="value" />
	<xsl:if test="$value = 1">Szótagszámláló, izo-strofikus, </xsl:if>
	<xsl:if test="$value = 3">Bizonytalan, hogy vers vagy próza, </xsl:if>
	<xsl:if test="$value = 4">Bizonytalan verselésű, időmértékes, </xsl:if>
	<xsl:if test="$value = 5">Bizonytalan verselésű, szótagszámláló, izostofikus, </xsl:if>
	<xsl:if test="$value = 6">Hexameter </xsl:if>
	<xsl:if test="$value = 7">Disztichon </xsl:if>
	<xsl:if test="$value = 8">Időmértékes, de nem hexameter vagy disztichon, </xsl:if>
	<xsl:if test="$value = 10">Hangsúlyos, nem strofikus, nem szótagszámláló rímtelen, </xsl:if>
	<xsl:if test="$value = 11">Bizonytalan, hogy vers vagy ritmikus próza, </xsl:if>
	<xsl:if test="$value = 12">Verssorok és próza váltakozása, </xsl:if>
	<xsl:if test="$value = 15">Váltakozó metrumú </xsl:if>
	<xsl:if test="$value = 16">Szótagszámláló tendenciát mutató, </xsl:if>
	<xsl:if test="$value = 17">Szótagszámláló, </xsl:if>
	<xsl:if test="$value = 18">Szószámláló, </xsl:if>
	<xsl:if test="$value = 19">Szekvenciát imitáló, </xsl:if>
	<xsl:if test="$value = 30">Nótajelzés, a metruma kikövetkeztetett, </xsl:if>
</xsl:template>

<xsl:template name="v28">
	<xsl:param name="code" />
	<xsl:choose>
		<xsl:when test="$code = 1"><xsl:text>vallásos</xsl:text></xsl:when>
		<xsl:when test="$code = 2"><xsl:text>história</xsl:text></xsl:when>
		<xsl:when test="$code = 3"><xsl:text>nem história</xsl:text></xsl:when>
		<xsl:when test="$code = 4"><xsl:text>elbeszélő</xsl:text></xsl:when>
		<xsl:when test="$code = 5"><xsl:text>leíró vagy értekező</xsl:text></xsl:when>
		<xsl:when test="$code = 6"><xsl:text>bibliai</xsl:text></xsl:when>
		<xsl:when test="$code = 8"><xsl:text>liturgikus vagy paraliturgikus eredetű</xsl:text></xsl:when>
		<xsl:when test="$code = 9"><xsl:text>bibliai</xsl:text></xsl:when>
		<xsl:when test="$code = 10"><xsl:text>prédikációs ének</xsl:text></xsl:when>
		<xsl:when test="$code = 13"><xsl:text>zsoltár</xsl:text></xsl:when>
		<xsl:when test="$code = 14"><xsl:text>jeremiád</xsl:text></xsl:when>
		<xsl:when test="$code = 15"><xsl:text>rövid foglalat</xsl:text></xsl:when>
		<xsl:when test="$code = 16"><xsl:text>himnusz</xsl:text></xsl:when>
		<xsl:when test="$code = 17"><xsl:text>antifona</xsl:text></xsl:when>
		<xsl:when test="$code = 18"><xsl:text>szekvencia</xsl:text></xsl:when>
		<xsl:when test="$code = 23"><xsl:text>dogmatika</xsl:text></xsl:when>
		<xsl:when test="$code = 24"><xsl:text>alkalmi ének</xsl:text></xsl:when>
		<xsl:when test="$code = 25"><xsl:text>mindennapi vagy ünnepnapi lelki ének</xsl:text></xsl:when>
		<xsl:when test="$code = 26"><xsl:text>Urvacsora-ének</xsl:text></xsl:when>
		<xsl:when test="$code = 27"><xsl:text>káté-ének</xsl:text></xsl:when>
		<xsl:when test="$code = 28"><xsl:text>Szent Háromság-ének</xsl:text></xsl:when>
		<xsl:when test="$code = 29"><xsl:text>Credo magyarázat</xsl:text></xsl:when>
		<xsl:when test="$code = 30"><xsl:text>Miatyánk-ének</xsl:text></xsl:when>
		<xsl:when test="$code = 31"><xsl:text>Tízparancsolat-ének</xsl:text></xsl:when>
		<xsl:when test="$code = 32"><xsl:text>házasének</xsl:text></xsl:when>
		<xsl:when test="$code = 33"><xsl:text>keresztelési ének</xsl:text></xsl:when>
		<xsl:when test="$code = 34"><xsl:text>bölcsődal</xsl:text></xsl:when>
		<xsl:when test="$code = 35"><xsl:text>temetési ének</xsl:text></xsl:when>
		<xsl:when test="$code = 36"><xsl:text>dicséret</xsl:text></xsl:when>
		<xsl:when test="$code = 37"><xsl:text>hálaadó ének</xsl:text></xsl:when>
		<xsl:when test="$code = 38"><xsl:text>könyörgés</xsl:text></xsl:when>
		<xsl:when test="$code = 39"><xsl:text>vallástétel</xsl:text></xsl:when>
		<xsl:when test="$code = 40"><xsl:text>Szentlélek invokáció</xsl:text></xsl:when>
		<xsl:when test="$code = 41"><xsl:text>tanulság</xsl:text></xsl:when>
		<xsl:when test="$code = 42"><xsl:text>jó keresztyéni cselekedetre intő ének</xsl:text></xsl:when>
		<xsl:when test="$code = 43"><xsl:text>hívők biztatása</xsl:text></xsl:when>
		<xsl:when test="$code = 44"><xsl:text>siralom</xsl:text></xsl:when>
		<xsl:when test="$code = 45"><xsl:text>hívők vigasztalása</xsl:text></xsl:when>
		<xsl:when test="$code = 47"><xsl:text>a világ hiábavalóságáról szóló ének</xsl:text></xsl:when>

		<xsl:when test="$code = 48"><xsl:text>világi</xsl:text></xsl:when>
		<xsl:when test="$code = 49"><xsl:text>história</xsl:text></xsl:when>
		<xsl:when test="$code = 50"><xsl:text>nem história</xsl:text></xsl:when>
		<xsl:when test="$code = 51"><xsl:text>elbeszélő</xsl:text></xsl:when>
		<xsl:when test="$code = 52"><xsl:text>leíró vagy értekező</xsl:text></xsl:when>
		<xsl:when test="$code = 53"><xsl:text>morális vagy politikai</xsl:text></xsl:when>
		<xsl:when test="$code = 54"><xsl:text>erotikus</xsl:text></xsl:when>
		<xsl:when test="$code = 56"><xsl:text>nem fiktív</xsl:text></xsl:when>
		<xsl:when test="$code = 57"><xsl:text>kitalált történetmondás</xsl:text></xsl:when>
		<xsl:when test="$code = 58"><xsl:text>arisztokratikus regiszter</xsl:text></xsl:when>
		<xsl:when test="$code = 59"><xsl:text>populáris vagy vágáns</xsl:text></xsl:when>
		<xsl:when test="$code = 61"><xsl:text>humanista iskolai</xsl:text></xsl:when>
		<xsl:when test="$code = 63"><xsl:text>udvari</xsl:text></xsl:when>
		<xsl:when test="$code = 64"><xsl:text>populáris</xsl:text></xsl:when>
		<xsl:when test="$code = 66"><xsl:text>humanista iskolai</xsl:text></xsl:when>
		<xsl:when test="$code = 68"><xsl:text>történelmi</xsl:text></xsl:when>
		<xsl:when test="$code = 69"><xsl:text>kortársi tudósító</xsl:text></xsl:when>
		<xsl:when test="$code = 74"><xsl:text>naptárvers</xsl:text></xsl:when>
		<xsl:when test="$code = 76"><xsl:text>partimen</xsl:text></xsl:when>
		<xsl:when test="$code = 77"><xsl:text>embléma</xsl:text></xsl:when>
		<xsl:when test="$code = 78"><xsl:text>szerelmi köszöntés</xsl:text></xsl:when>
		<xsl:when test="$code = 80"><xsl:text>török beyt fordítása</xsl:text></xsl:when>
		<xsl:when test="$code = 81"><xsl:text>aenigma</xsl:text></xsl:when>
		<xsl:when test="$code = 82"><xsl:text>női dal</xsl:text></xsl:when>
		<xsl:when test="$code = 83"><xsl:text>latrikánus vers</xsl:text></xsl:when>
		<xsl:when test="$code = 84"><xsl:text>gab</xsl:text></xsl:when>
		<xsl:when test="$code = 86"><xsl:text>in laudem</xsl:text></xsl:when>
		<xsl:when test="$code = 87"><xsl:text>hegedős ének</xsl:text></xsl:when>
		<xsl:when test="$code = 88"><xsl:text>vágáns szatíra</xsl:text></xsl:when>
		<xsl:when test="$code = 89"><xsl:text>politikai propaganda</xsl:text></xsl:when>
		<xsl:when test="$code = 90"><xsl:text>epistola dedicatoria</xsl:text></xsl:when>
		<xsl:when test="$code = 91"><xsl:text>tanulság</xsl:text></xsl:when>
		<xsl:when test="$code = 92"><xsl:text>idézet</xsl:text></xsl:when>
		<xsl:when test="$code = 93"><xsl:text>sententia</xsl:text></xsl:when>
		<xsl:when test="$code = 95"><xsl:text>epicedium</xsl:text></xsl:when>

		<xsl:when test="$code = 100"><xsl:text>benedicamus</xsl:text></xsl:when>
		<xsl:when test="$code = 102"><xsl:text>imádság</xsl:text></xsl:when>
		<xsl:when test="$code = 103"><xsl:text>muzulmán</xsl:text></xsl:when>
		<xsl:when test="$code = 104"><xsl:text>szerzetesi regula</xsl:text></xsl:when>
		<xsl:when test="$code = 107"><xsl:text>hitvita</xsl:text></xsl:when>
		<xsl:when test="$code = 109"><xsl:text>halotti</xsl:text></xsl:when>

		<xsl:when test="$code = 115"><xsl:text>utazási vers</xsl:text></xsl:when>
		<xsl:when test="$code = 118"><xsl:text>missilis levél</xsl:text></xsl:when>
		<xsl:when test="$code = 119"><xsl:text>alba</xsl:text></xsl:when>
		<xsl:when test="$code = 120"><xsl:text>Horatius-paródia</xsl:text></xsl:when>
		<xsl:when test="$code = 121"><xsl:text>táncdal</xsl:text></xsl:when>

		<xsl:when test="$code = 123"><xsl:text>varázsige</xsl:text></xsl:when>
		<xsl:when test="$code = 124"><xsl:text>Szent király-himnusz</xsl:text></xsl:when>
		<xsl:when test="$code = 125"><xsl:text>legenda</xsl:text></xsl:when>
		<xsl:when test="$code = 126"><xsl:text>Mária-siralom</xsl:text></xsl:when>

		<xsl:when test="$code = 127"><xsl:text>jogszabály</xsl:text></xsl:when>
		<xsl:when test="$code = 128"><xsl:text>játék</xsl:text></xsl:when>
		<xsl:when test="$code = 129"><xsl:text>csízió</xsl:text></xsl:when>

		<xsl:when test="$code = 130"><xsl:text>Mária-ének</xsl:text></xsl:when>
		<xsl:when test="$code = 134"><xsl:text>bibliai világkrónika</xsl:text></xsl:when>
		<xsl:when test="$code = 200"><xsl:text>cantio</xsl:text></xsl:when>
		<xsl:when test="$code = 201"><xsl:text>bibliai dráma</xsl:text></xsl:when>
		<xsl:when test="$code = 202"><xsl:text>doxológia</xsl:text></xsl:when>
		<xsl:when test="$code = 203"><xsl:text>vallásos embléma</xsl:text></xsl:when>

		<xsl:when test="$code = 210"><xsl:text>epigramma</xsl:text></xsl:when>
		<xsl:when test="$code = 211"><xsl:text>udvari dráma</xsl:text></xsl:when>
		<xsl:when test="$code = 212"><xsl:text>mezőgazdasági költemény</xsl:text></xsl:when>

		<xsl:when test="$code = 255"><xsl:text>Urfelmutatási ének</xsl:text></xsl:when>
		<xsl:when test="$code = 256"><xsl:text>benedicamus parafrázis</xsl:text></xsl:when>
		<xsl:when test="$code = 257"><xsl:text>asztali áldás</xsl:text></xsl:when>
		<xsl:when test="$code = 258"><xsl:text>Énekek éneke</xsl:text></xsl:when>
		<xsl:when test="$code = 259"><xsl:text>útonjáróknak éneke</xsl:text></xsl:when>
		<xsl:when test="$code = 260"><xsl:text>rabének</xsl:text></xsl:when>
		<xsl:when test="$code = 300"><xsl:text>egyháztörténeti kivonat</xsl:text></xsl:when>
		<xsl:when test="$code = 301"><xsl:text>közel kortársi</xsl:text></xsl:when>
		<xsl:when test="$code = 302"><xsl:text>régi</xsl:text></xsl:when>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>