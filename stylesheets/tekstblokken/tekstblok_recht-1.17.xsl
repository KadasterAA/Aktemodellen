<?xml version="1.0" encoding="UTF-8"?>
<!--
*********************************************************
Stylesheet: tekstblok_recht.xsl
Version: 1.17 (AA-3724)
*********************************************************
Description:
Type of right text block.

Public:
(mode) do-right

Private:
(mode) do-variant
-->
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
	xmlns:tia="http://www.kadaster.nl/schemas/KIK/TIA_Algemeen"
	xmlns:kef="nl.kadaster.xslt.XslExtensionFunctions"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	exclude-result-prefixes="tia kef xsl"
	version="1.0">

	<!--
	*********************************************************
	Mode: do-right
	*********************************************************
	Public: yes

	Identity transform: no

	Description: Right text block.

	Input: tia:IMKAD_ZakelijkRecht

	Params: none

	Output: text

	Calls:
	(mode) do-variant

	Called by:
	(mode) do-deed
	(mode) do-registered-objects-deed-of-transfer
	(mode) do-properties
	(mode) do-bridging-mortgage
	(mode) do-renouncement-of-mortgage-right
	(mode) do-termination-of-mortgage-right
	(name) processRights
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_ZakelijkRecht" mode="do-right">
		<xsl:variable name="eigendomText" >
			<xsl:if test="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom']">
				<xsl:value-of select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
					translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
					translate(normalize-space(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom']/tia:tekst), $upper, $lower)]), $upper, $lower)]" />
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="aardVerkregen" select="translate(normalize-space(tia:aardVerkregen), $lower, $upper)"/>
		<xsl:variable name="nadarTeOmschrijvenText" select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven']/tia:tekst), $upper, $lower)]), $upper, $lower)]" />
		<xsl:variable name="breukdeel" select="concat(kef:convertNumberToText(string(tia:aandeelInRecht/tia:teller)),'/',kef:convertOrdinalToText(string(tia:aandeelInRecht/tia:noemer)),
					' (', tia:aandeelInRecht/tia:teller,'/',tia:aandeelInRecht/tia:noemer, ')')"/>
		<xsl:variable name="aardVerkregenVariant" select="translate(tia:aardVerkregenVariant, $upper, $lower)"/>
		<xsl:variable name="numberOfRights" select="number(tia:tia_Aantal_Rechten)" />
		<xsl:variable name="numberOfRightsText" select="kef:convertNumberToText(tia:tia_Aantal_Rechten)" />
		<xsl:variable name="plurality" select="normalize-space(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoud']/tia:tekst)"/>
		<xsl:variable name="external" select="normalize-space(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurend']/tia:tekst)"/>
		<xsl:variable name="isOrAre">
			<xsl:choose>
				<xsl:when test="$plurality = 'true'">
					<xsl:text>zijn</xsl:text>
				</xsl:when>
				<xsl:when test="$plurality = 'false' or $plurality = ''">
					<xsl:text>is</xsl:text>
				</xsl:when>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="onderAppartementsRecht" select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onderappartementsrecht']"/>
		<xsl:variable name="eigendomAppartementsrecht" select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendomappartementsrecht']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendomappartementsrecht']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendomappartementsrecht']/tia:tekst), $upper, $lower)]), $upper, $lower)]" />
		
		<xsl:choose>
			<xsl:when test="tia:aandeelInRecht/tia:teller and normalize-space(tia:aandeelInRecht/tia:teller) != '' and 
					  tia:aandeelInRecht/tia:noemer and normalize-space(tia:aandeelInRecht/tia:noemer) != ''">
				<xsl:text>het </xsl:text>
				<xsl:value-of select="$breukdeel"/>
				<xsl:text> onverdeeld aandeel in </xsl:text> 
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="translate($aardVerkregen, $upper, $lower) = 'eigendom' and tia:IMKAD_Appartementsrecht and tia:IMKAD_Appartementsrecht/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid']/tia:tekst">
					<xsl:value-of select="$eigendomAppartementsrecht"/>
					<xsl:text> </xsl:text>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:choose>
			 <!-- a. option -->
			 <xsl:when test="translate($aardVerkregen, $upper, $lower) = 'eigendom' and tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom']/tia:tekst and not(tia:IMKAD_Appartementsrecht)">
				<xsl:choose>
					<xsl:when test="tia:aandeelInRecht/tia:teller and normalize-space(tia:aandeelInRecht/tia:teller) != '' and 
					  				tia:aandeelInRecht/tia:noemer and normalize-space(tia:aandeelInRecht/tia:noemer) != ''">
						<xsl:if test="translate($eigendomText, $upper, $lower) = 'het recht van eigendom met betrekking tot'">
							<xsl:value-of select="$eigendomText"/>
						</xsl:if>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$eigendomText"/>
					</xsl:otherwise>
				</xsl:choose>
			 </xsl:when>
			<!-- b. option -->
			<xsl:when test="translate($aardVerkregen, $upper, $lower) = 'eigendom belast met opstal' or
							translate($aardVerkregen, $upper, $lower) = 'eigendom belast met opstal nutsvoorzieningen' or
							translate($aardVerkregen, $upper, $lower) = 'eigendom belast met opstal leidingen' or
							translate($aardVerkregen, $upper, $lower) = 'eigendom belast met erfpacht' or
							translate($aardVerkregen, $upper, $lower) = 'eigendom belast met vruchtgebruik' or
							translate($aardVerkregen, $upper, $lower) = 'eigendom belast met bp recht' or
							translate($aardVerkregen, $upper, $lower) = 'eigendom belast met gebruik en bewoning'"> 
				<xsl:text>het recht van eigendom, belast met</xsl:text>
				<xsl:choose>
					<!-- Variants 5 and 7 -->
					<xsl:when test="translate($aardVerkregen, $upper, $lower) = 'eigendom belast met vruchtgebruik' or
							translate($aardVerkregen, $upper, $lower) = 'eigendom belast met gebruik en bewoning'">
						<xsl:choose>
							<xsl:when test="$plurality = 'true'">
								<xsl:text> de</xsl:text>
							</xsl:when>
							<xsl:when test="$plurality = 'false' or $plurality = ''">
								<xsl:text> het</xsl:text>
							</xsl:when>
						</xsl:choose>	
						<xsl:if test="$nadarTeOmschrijvenText != ''">
							<xsl:text> </xsl:text>
							<xsl:value-of select="$nadarTeOmschrijvenText"/>
						</xsl:if>
						<xsl:text> recht</xsl:text>	
						<xsl:if test="$plurality = 'true'">
							<xsl:text>en</xsl:text>
						</xsl:if>
						<xsl:text> van</xsl:text>		
						<xsl:choose>
							<!-- Variant 5 -->
							<xsl:when test="translate($aardVerkregen, $upper, $lower) = 'eigendom belast met vruchtgebruik'">
								<xsl:text> vruchtgebruik</xsl:text>
							</xsl:when>
							<!-- Variant 7 -->
							<xsl:when test="translate($aardVerkregen, $upper, $lower) = 'eigendom belast met gebruik en bewoning'">
								<xsl:text> gebruik en bewoning</xsl:text>
							</xsl:when>
						</xsl:choose>
					</xsl:when>
					<!-- Variant 1,2,3,4,6 -->
					<xsl:when test="translate($aardVerkregen, $upper, $lower) = 'eigendom belast met opstal' or
									translate($aardVerkregen, $upper, $lower) = 'eigendom belast met opstal nutsvoorzieningen' or
									translate($aardVerkregen, $upper, $lower) = 'eigendom belast met opstal leidingen' or
									translate($aardVerkregen, $upper, $lower) = 'eigendom belast met erfpacht' or
									translate($aardVerkregen, $upper, $lower) = 'eigendom belast met bp recht' ">
						<xsl:choose>
							<xsl:when test="$numberOfRights = 1">
								<xsl:text> het</xsl:text>
							</xsl:when>
							<xsl:when test="$numberOfRights > 1">
								<xsl:text> een</xsl:text>
							</xsl:when>
						</xsl:choose>	
						<xsl:if test="$numberOfRights > 1">
							<xsl:text> </xsl:text>
							<xsl:value-of select="$numberOfRightsText"/>
							<xsl:text>tal</xsl:text>
						</xsl:if>	
						<xsl:if test="$nadarTeOmschrijvenText != ''">
							<xsl:text> </xsl:text>
							<xsl:value-of select="$nadarTeOmschrijvenText"/>
						</xsl:if>
						<!-- Variant 6 -->
						<xsl:if test="translate($aardVerkregen, $upper, $lower) = 'eigendom belast met bp recht'">
							<xsl:text> zakelijk</xsl:text>
							<xsl:if test="$numberOfRights > 1">
								<xsl:text>e</xsl:text>
							</xsl:if>
						</xsl:if>
						<xsl:text> recht</xsl:text>
						<xsl:if test="$numberOfRights > 1">
							<xsl:text>en</xsl:text>
						</xsl:if>
						<xsl:choose>
							<!-- Variants 1, 2 and 3 -->
							<xsl:when test="translate($aardVerkregen, $upper, $lower) = 'eigendom belast met opstal' or
											translate($aardVerkregen, $upper, $lower) = 'eigendom belast met opstal nutsvoorzieningen' or
											translate($aardVerkregen, $upper, $lower) = 'eigendom belast met opstal leidingen'">
								<xsl:text> van opstal</xsl:text>
								<xsl:choose>
									<xsl:when test="translate($aardVerkregen, $upper, $lower) = 'eigendom belast met opstal nutsvoorzieningen'">
										<xsl:text> nutsvoorzieningen</xsl:text>
									</xsl:when>
									<xsl:when test="translate($aardVerkregen, $upper, $lower) = 'eigendom belast met opstal leidingen'">
										<xsl:text> leidingen</xsl:text>
									</xsl:when>
								</xsl:choose>
							</xsl:when>
							<!-- Variant 4 -->
							<xsl:when test="translate($aardVerkregen, $upper, $lower) = 'eigendom belast met erfpacht'">
								<xsl:text> van erfpacht</xsl:text>
								<xsl:if test="$external = 'true'">
									<xsl:text>, welke eeuwigdurend </xsl:text>
									<xsl:value-of select="$isOrAre"/>
									<xsl:text> gevestigd</xsl:text>
								</xsl:if>
							</xsl:when>
							<!-- Variant 6 -->
							<xsl:when test="translate($aardVerkregen, $upper, $lower) = 'eigendom belast met bp recht'">
								<xsl:text> als bedoeld in artikel 5 lid 3 onder b van de Belemmeringenwet Privaatrecht zoals deze luidde tot een januari negentienhonderdtweeënnegentig</xsl:text>
							</xsl:when>
						</xsl:choose>
					</xsl:when>
				</xsl:choose>
				<xsl:if test="(translate($aardVerkregen, $upper, $lower) = 'eigendom belast met opstal' 
								and (normalize-space($aardVerkregenVariant) = 'erfpacht' 
									or normalize-space($aardVerkregenVariant) = 'vruchtgebruik' 
									or normalize-space($aardVerkregenVariant) = 'bp recht' 
									or normalize-space($aardVerkregenVariant) = 'opstal' 
									or normalize-space($aardVerkregenVariant) = 'onderopstal' 
									or normalize-space($aardVerkregenVariant) = 'opstal nutsvoorzieningen' 
									or normalize-space($aardVerkregenVariant) = 'opstal leidingen' 
									or normalize-space($aardVerkregenVariant) = 'gebruik en bewoning'))
							   or (translate($aardVerkregen, $upper, $lower) = 'eigendom belast met opstal nutsvoorzieningen' 
								and (normalize-space($aardVerkregenVariant) = 'erfpacht' 
									or normalize-space($aardVerkregenVariant) = 'vruchtgebruik' 
									or normalize-space($aardVerkregenVariant) = 'bp recht' 
									or normalize-space($aardVerkregenVariant) = 'opstal' 
									or normalize-space($aardVerkregenVariant) = 'gebruik en bewoning'))
							   or (translate($aardVerkregen, $upper, $lower) = 'eigendom belast met opstal leidingen' 
								and (normalize-space($aardVerkregenVariant) = 'erfpacht' 
									or normalize-space($aardVerkregenVariant) = 'vruchtgebruik' 
									or normalize-space($aardVerkregenVariant) = 'bp recht' 
									or normalize-space($aardVerkregenVariant) = 'opstal' 
									or normalize-space($aardVerkregenVariant) = 'gebruik en bewoning'))
							   or (translate($aardVerkregen, $upper, $lower) = 'eigendom belast met erfpacht' 
								and (normalize-space($aardVerkregenVariant) = 'erfpacht' 
									or normalize-space($aardVerkregenVariant) = 'vruchtgebruik' 
									or normalize-space($aardVerkregenVariant) = 'bp recht' 
									or normalize-space($aardVerkregenVariant) = 'opstal' 
									or normalize-space($aardVerkregenVariant) = 'opstal nutsvoorzieningen' 
									or normalize-space($aardVerkregenVariant) = 'opstal leidingen' 
									or normalize-space($aardVerkregenVariant) = 'gebruik en bewoning'))
							   or (translate($aardVerkregen, $upper, $lower) = 'eigendom belast met vruchtgebruik' 
								and (normalize-space($aardVerkregenVariant) = 'erfpacht' 
									or normalize-space($aardVerkregenVariant) = 'bp recht' 
									or normalize-space($aardVerkregenVariant) = 'opstal' 
									or normalize-space($aardVerkregenVariant) = 'opstal nutsvoorzieningen' 
									or normalize-space($aardVerkregenVariant) = 'opstal leidingen' 
									or normalize-space($aardVerkregenVariant) = 'gebruik en bewoning'))
							   or (translate($aardVerkregen, $upper, $lower) = 'eigendom belast met bp recht' 
								and (normalize-space($aardVerkregenVariant) = 'erfpacht' 
									or normalize-space($aardVerkregenVariant) = 'vruchtgebruik' 
									or normalize-space($aardVerkregenVariant) = 'bp recht' 
									or normalize-space($aardVerkregenVariant) = 'opstal' 
									or normalize-space($aardVerkregenVariant) = 'opstal nutsvoorzieningen' 
									or normalize-space($aardVerkregenVariant) = 'opstal leidingen' 
									or normalize-space($aardVerkregenVariant) = 'gebruik en bewoning'))
							   or (translate($aardVerkregen, $upper, $lower) = 'eigendom belast met gebruik en bewoning' 
								and (normalize-space($aardVerkregenVariant) = 'erfpacht' 
									or normalize-space($aardVerkregenVariant) = 'vruchtgebruik' 
									or normalize-space($aardVerkregenVariant) = 'bp recht' 
									or normalize-space($aardVerkregenVariant) = 'opstal' 
									or normalize-space($aardVerkregenVariant) = 'opstal nutsvoorzieningen' 
									or normalize-space($aardVerkregenVariant) = 'opstal leidingen' 
									or normalize-space($aardVerkregenVariant) = 'gebruik en bewoning'))">
					<xsl:text> en </xsl:text>
					<xsl:apply-templates select="." mode="do-variant"/>
				</xsl:if>
				<xsl:text>, met betrekking tot</xsl:text>
			</xsl:when>
			<!-- c. option -->
			<xsl:when test="(translate($aardVerkregen, $upper, $lower) = 'opstal' or translate($aardVerkregen, $upper, $lower) = 'onderopstal') and not(tia:IMKAD_Appartementsrecht)"> 
				<xsl:text>het </xsl:text>
				<xsl:if test="$nadarTeOmschrijvenText != ''">
					<xsl:value-of select="$nadarTeOmschrijvenText"/>
					<xsl:text> </xsl:text>
				</xsl:if>
				<xsl:text>recht van </xsl:text>
				<xsl:if test="translate($aardVerkregen, $upper, $lower) = 'onderopstal'">
					<xsl:text>onder</xsl:text>
				</xsl:if>
				<xsl:text>opstal</xsl:text>
				<xsl:if test="normalize-space($aardVerkregenVariant) = 'erfpacht' 
								or normalize-space($aardVerkregenVariant) = 'vruchtgebruik' 
								or normalize-space($aardVerkregenVariant) = 'bp recht' 
								or normalize-space($aardVerkregenVariant) = 'opstal' 
								or normalize-space($aardVerkregenVariant) = 'opstal nutsvoorzieningen' 
								or normalize-space($aardVerkregenVariant) = 'opstal leidingen' 
								or normalize-space($aardVerkregenVariant) = 'gebruik en bewoning'">
					<xsl:text>, belast met </xsl:text>
					<xsl:apply-templates select="." mode="do-variant" />
					<xsl:text>,</xsl:text> 
				</xsl:if>
				<xsl:text> met betrekking tot</xsl:text>
			</xsl:when>	 
			<!-- d. option -->
			<xsl:when test="(translate($aardVerkregen, $upper, $lower) = 'erfpacht' or translate($aardVerkregen, $upper, $lower) = 'ondererfpacht') and not(tia:IMKAD_Appartementsrecht)"> 
				<xsl:text>het </xsl:text>
				<xsl:if test="$nadarTeOmschrijvenText != ''">
					<xsl:value-of select="$nadarTeOmschrijvenText"/>
					<xsl:text> </xsl:text>
				</xsl:if>
				<xsl:text>recht van </xsl:text>
				<xsl:if test="translate($aardVerkregen, $upper, $lower) = 'ondererfpacht'">
					<xsl:text>onder</xsl:text>
				</xsl:if>
				<xsl:text>erfpacht</xsl:text>
				<xsl:if test="normalize-space(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurend']/tia:tekst) = 'true'" >
					<xsl:text>, welke eeuwigdurend is gevestigd</xsl:text>
				</xsl:if>
				<xsl:if test="normalize-space($aardVerkregenVariant) = 'erfpacht' 
								or normalize-space($aardVerkregenVariant) = 'vruchtgebruik' 
								or normalize-space($aardVerkregenVariant) = 'bp recht' 
								or normalize-space($aardVerkregenVariant) = 'opstal' 
								or normalize-space($aardVerkregenVariant) = 'opstal nutsvoorzieningen' 
								or normalize-space($aardVerkregenVariant) = 'opstal leidingen' 
								or normalize-space($aardVerkregenVariant) = 'gebruik en bewoning'">
					<xsl:text>, belast met </xsl:text>
					<xsl:apply-templates select="." mode="do-variant" />
					<xsl:text>,</xsl:text> 
				</xsl:if>
				<xsl:text> met betrekking tot</xsl:text>
			</xsl:when>		
			<!-- e. option -->
			<xsl:when test="translate($aardVerkregen, $upper, $lower) = 'erfpacht op opstal'"> 
				<xsl:text>het </xsl:text>
				<xsl:if test="$nadarTeOmschrijvenText != ''">
					<xsl:value-of select="$nadarTeOmschrijvenText"/>
					<xsl:text> </xsl:text>
				</xsl:if>
				<xsl:text>recht van erfpacht, op het recht van opstal</xsl:text>
				<xsl:if test="normalize-space($aardVerkregenVariant) = 'erfpacht' 
								or normalize-space($aardVerkregenVariant) = 'vruchtgebruik' 
								or normalize-space($aardVerkregenVariant) = 'bp recht' 
								or normalize-space($aardVerkregenVariant) = 'opstal' 
								or normalize-space($aardVerkregenVariant) = 'opstal nutsvoorzieningen' 
								or normalize-space($aardVerkregenVariant) = 'opstal leidingen' 
								or normalize-space($aardVerkregenVariant) = 'gebruik en bewoning'">
					<xsl:text>, belast met </xsl:text>
					<xsl:apply-templates select="." mode="do-variant" />
				</xsl:if>
				<xsl:text>,</xsl:text> 
				<xsl:text> met betrekking tot</xsl:text>
			</xsl:when>		
			<!-- f. option --> 
			<xsl:when test="translate($aardVerkregen, $upper, $lower) = 'opstal op erfpacht' and not(tia:IMKAD_Appartementsrecht)"> 
				<xsl:text>het </xsl:text>
				<xsl:if test="$nadarTeOmschrijvenText != ''">
					<xsl:value-of select="$nadarTeOmschrijvenText"/>
					<xsl:text> </xsl:text>
				</xsl:if>
				<xsl:text>recht van opstal, op het recht van erfpacht</xsl:text>
				<xsl:if test="(translate($aardVerkregen, $upper, $lower) = 'opstal op erfpacht' 
								and (normalize-space($aardVerkregenVariant) = 'erfpacht' 
									or normalize-space($aardVerkregenVariant) = 'vruchtgebruik' 
									or normalize-space($aardVerkregenVariant) = 'bp recht' 
									or normalize-space($aardVerkregenVariant) = 'opstal' 
									or normalize-space($aardVerkregenVariant) = 'opstal nutsvoorzieningen' 
									or normalize-space($aardVerkregenVariant) = 'opstal leidingen' 
									or normalize-space($aardVerkregenVariant) = 'gebruik en bewoning'))">
					<xsl:text>, belast met </xsl:text>
					<xsl:apply-templates select="." mode="do-variant" />
				</xsl:if>
				<xsl:text>,</xsl:text>
				<xsl:text> met betrekking tot</xsl:text>
			</xsl:when>
			<!-- g. option -->
			<xsl:when test="(translate($aardVerkregen, $upper, $lower) = 'erfpacht' or translate($aardVerkregen, $upper, $lower) = 'ondererfpacht') and tia:IMKAD_Appartementsrecht">
				<xsl:text>het</xsl:text>
				<xsl:if test="normalize-space($nadarTeOmschrijvenText) != ''">
					<xsl:text> </xsl:text>
					<xsl:value-of select="$nadarTeOmschrijvenText" />
				</xsl:if>
				<xsl:text> recht van </xsl:text>
				<xsl:if test="translate($aardVerkregen, $upper, $lower) = 'ondererfpacht'">
					<xsl:text>onder</xsl:text>
				</xsl:if>
				<xsl:text>erfpacht</xsl:text>
				<xsl:if test="normalize-space(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurend']/tia:tekst) = 'true'" >
					<xsl:text>, welke eeuwigdurend is gevestigd</xsl:text>
				</xsl:if>
				<xsl:if test="(translate($aardVerkregen, $upper, $lower) = 'erfpacht' 
								and (normalize-space($aardVerkregenVariant) = 'erfpacht' 
									or normalize-space($aardVerkregenVariant) = 'ondererfpacht' 
									or normalize-space($aardVerkregenVariant) = 'vruchtgebruik' 
									or normalize-space($aardVerkregenVariant) = 'bp recht' 
									or normalize-space($aardVerkregenVariant) = 'opstal' 
									or normalize-space($aardVerkregenVariant) = 'opstal nutsvoorzieningen' 
									or normalize-space($aardVerkregenVariant) = 'opstal leidingen' 
									or normalize-space($aardVerkregenVariant) = 'gebruik en bewoning'))
							or (translate($aardVerkregen, $upper, $lower) = 'ondererfpacht' 
								and (normalize-space($aardVerkregenVariant) = 'vruchtgebruik' 
									or normalize-space($aardVerkregenVariant) = 'bp recht' 
									or normalize-space($aardVerkregenVariant) = 'opstal' 
									or normalize-space($aardVerkregenVariant) = 'opstal nutsvoorzieningen' 
									or normalize-space($aardVerkregenVariant) = 'opstal leidingen' 
									or normalize-space($aardVerkregenVariant) = 'gebruik en bewoning'))">
					<xsl:text>, belast met </xsl:text>
					<xsl:apply-templates select="." mode="do-variant" />
					<xsl:text>,</xsl:text> 
				</xsl:if>
				<xsl:text> met betrekking tot het </xsl:text>
				<xsl:if test="normalize-space($onderAppartementsRecht/tia:tekst) = 'true'">
					<xsl:text>(onder-)</xsl:text>
				</xsl:if>
				<xsl:text>appartementsrecht, rechtgevende op het uitsluitend gebruik van</xsl:text>
			</xsl:when> 
			<!-- h. option -->
			<xsl:when test="(translate($aardVerkregen, $upper, $lower) = 'opstal' or translate($aardVerkregen, $upper, $lower) = 'onderopstal') and tia:IMKAD_Appartementsrecht">
				<xsl:text>het</xsl:text>
				<xsl:if test="normalize-space($nadarTeOmschrijvenText) != ''">
					<xsl:text> </xsl:text>
					<xsl:value-of select="$nadarTeOmschrijvenText" />
				</xsl:if>
				<xsl:text> recht van </xsl:text>
				<xsl:if test="translate($aardVerkregen, $upper, $lower) = 'onderopstal'">
					<xsl:text>onder</xsl:text>
				</xsl:if>
				<xsl:text>opstal</xsl:text>
				<xsl:if test="(translate($aardVerkregen, $upper, $lower) = 'opstal' 
								and (normalize-space($aardVerkregenVariant) = 'erfpacht' 
									or normalize-space($aardVerkregenVariant) = 'ondererfpacht' 
									or normalize-space($aardVerkregenVariant) = 'vruchtgebruik' 
									or normalize-space($aardVerkregenVariant) = 'bp recht' 
									or normalize-space($aardVerkregenVariant) = 'opstal' 
									or normalize-space($aardVerkregenVariant) = 'opstal nutsvoorzieningen' 
									or normalize-space($aardVerkregenVariant) = 'opstal leidingen' 
									or normalize-space($aardVerkregenVariant) = 'gebruik en bewoning')) 
							or (translate($aardVerkregen, $upper, $lower) = 'onderopstal'
								and (normalize-space($aardVerkregenVariant) = 'erfpacht' 
									or normalize-space($aardVerkregenVariant) = 'vruchtgebruik' 
									or normalize-space($aardVerkregenVariant) = 'bp recht' 
									or normalize-space($aardVerkregenVariant) = 'opstal' 
									or normalize-space($aardVerkregenVariant) = 'opstal nutsvoorzieningen' 
									or normalize-space($aardVerkregenVariant) = 'opstal leidingen' 
									or normalize-space($aardVerkregenVariant) = 'gebruik en bewoning'))">
					<xsl:text>, belast met </xsl:text>
					<xsl:apply-templates select="." mode="do-variant" />
					<xsl:text>,</xsl:text> 
				</xsl:if>
				<xsl:text> met betrekking tot het </xsl:text>
				<xsl:if test="normalize-space($onderAppartementsRecht/tia:tekst) = 'true'">
					<xsl:text>(onder-)</xsl:text>
				</xsl:if>
				<xsl:text>appartementsrecht, rechtgevende op het uitsluitend gebruik van</xsl:text>
			</xsl:when>
			<!-- i. option -->
			<xsl:when test="translate($aardVerkregen, $upper, $lower) = 'eigendom' and not(tia:IMKAD_Appartementsrecht/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid']/tia:tekst) and tia:IMKAD_Appartementsrecht">
				<xsl:text>het </xsl:text>
				<xsl:if test="normalize-space($onderAppartementsRecht/tia:tekst) = 'true'">
					<xsl:text>(onder-)</xsl:text>
				</xsl:if>
				<xsl:text>appartementsrecht</xsl:text>
				<xsl:if test="normalize-space($aardVerkregenVariant) = 'erfpacht' 
								or normalize-space($aardVerkregenVariant) = 'vruchtgebruik' 
								or normalize-space($aardVerkregenVariant) = 'bp recht' 
								or normalize-space($aardVerkregenVariant) = 'opstal' 
								or normalize-space($aardVerkregenVariant) = 'opstal nutsvoorzieningen' 
								or normalize-space($aardVerkregenVariant) = 'opstal leidingen' 
								or normalize-space($aardVerkregenVariant) = 'gebruik en bewoning'">
					<xsl:text>, belast met </xsl:text>
					<xsl:apply-templates select="." mode="do-variant" />
				</xsl:if>
				<xsl:text>, rechtgevende op het uitsluitend gebruik van</xsl:text>
			</xsl:when>
			<!-- j. option -->
			<xsl:when test="translate($aardVerkregen, $upper, $lower) = 'eigendom' and tia:IMKAD_Appartementsrecht and tia:IMKAD_Appartementsrecht/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid']/tia:tekst">
				<xsl:text>het </xsl:text>
				<xsl:if test="normalize-space($onderAppartementsRecht/tia:tekst) = 'true'">
					<xsl:text>(onder-)</xsl:text>
				</xsl:if>
				<xsl:text>appartementsrecht</xsl:text>
				<xsl:if test="normalize-space($aardVerkregenVariant) = 'erfpacht' 
								or normalize-space($aardVerkregenVariant) = 'vruchtgebruik' 
								or normalize-space($aardVerkregenVariant) = 'bp recht' 
								or normalize-space($aardVerkregenVariant) = 'opstal' 
								or normalize-space($aardVerkregenVariant) = 'opstal nutsvoorzieningen' 
								or normalize-space($aardVerkregenVariant) = 'opstal leidingen' 
								or normalize-space($aardVerkregenVariant) = 'gebruik en bewoning'">
					<xsl:text>, belast met </xsl:text>
					<xsl:apply-templates select="." mode="do-variant" />
				</xsl:if>
				<xsl:text>, rechtgevende op het uitsluitend gebruik van</xsl:text>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	
	<!--
	*********************************************************
	Mode: do-variant
	*********************************************************
	Public: no

	Identity transform: no

	Description: Variant.

	Input: tia:IMKAD_ZakelijkRecht

	Params: none

	Output: text

	Calls:
	none

	Called by:
	(mode) do-right
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_ZakelijkRecht" mode="do-variant">
		<xsl:variable name="aardVerkregenVariant" select="translate(tia:aardVerkregenVariant, $upper, $lower)"/>
		<xsl:variable name="nadarTeOmschrijvenVarText" select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijvenvariant']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijvenvariant']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijvenvariant']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
		<xsl:variable name="aantalRechtMeegegeven">
			<xsl:choose>
				<xsl:when test="$aardVerkregenVariant = 'vruchtgebruik' or $aardVerkregenVariant = 'gebruik en bewoning'">
					<xsl:text>false</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>true</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$aantalRechtMeegegeven = 'true'">
				<xsl:variable name="numberOfRightsVariant" select="number(tia:tia_Aantal_RechtenVariant)" />
				<xsl:variable name="numberOfRightsVariantText" select="kef:convertNumberToText(tia:tia_Aantal_RechtenVariant)" />
				<xsl:choose>
					<xsl:when test="number($numberOfRightsVariant) > 1">
						<xsl:text>een</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>het</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:text> </xsl:text>
				<xsl:if test="number($numberOfRightsVariant) > 1">
					<xsl:value-of select="$numberOfRightsVariantText"/>
					<xsl:text>tal</xsl:text>
				</xsl:if>
				<xsl:if test="$nadarTeOmschrijvenVarText != ''">
					<xsl:text> </xsl:text>
					<xsl:value-of select="$nadarTeOmschrijvenVarText"/>
				</xsl:if>
				<xsl:if test="$aardVerkregenVariant = 'bp recht'">
					<xsl:text> zakelijk</xsl:text>
					<xsl:if test="number($numberOfRightsVariant) > 1">
						<xsl:text>e</xsl:text>
					</xsl:if>
				</xsl:if>
				<xsl:text> recht</xsl:text>
				<xsl:if test="number($numberOfRightsVariant) > 1">
					<xsl:text>en</xsl:text>
				</xsl:if>
				<xsl:choose>
					<xsl:when test="$aardVerkregenVariant = 'erfpacht'">
					    <xsl:text> van erfpacht</xsl:text>
					    <xsl:if test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurendvariant']/tia:tekst, $upper, $lower) = 'true'">
							<xsl:text>, welke eeuwigdurend </xsl:text>
							<xsl:choose>
								<xsl:when test="number($numberOfRightsVariant) > 1">
									<xsl:text>zijn </xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>is </xsl:text>
										</xsl:otherwise>
							</xsl:choose>
							<xsl:text>gevestigd</xsl:text>
						</xsl:if>
					</xsl:when>
					<xsl:when test="$aardVerkregenVariant = 'ondererfpacht'">
						<xsl:text> van ondererfpacht</xsl:text>
						<xsl:if test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurendvariant']/tia:tekst, $upper, $lower) = 'true'">
							<xsl:text>, welke eeuwigdurend </xsl:text>
							<xsl:choose>
								<xsl:when test="number($numberOfRightsVariant) > 1">
									<xsl:text>zijn </xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>is </xsl:text>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:text>gevestigd</xsl:text>
						</xsl:if>
					</xsl:when>
					<xsl:when test="$aardVerkregenVariant = 'bp recht'">
						<xsl:text> als bedoeld in artikel 5 lid 3 onder b van de Belemmeringenwet Privaatrecht zoals deze luidde tot een januari negentienhonderdtweeënnegentig</xsl:text>
					</xsl:when>
					<xsl:when test="$aardVerkregenVariant = 'opstal'">
						<xsl:text> van opstal</xsl:text>
					</xsl:when>
					<xsl:when test="$aardVerkregenVariant = 'onderopstal'">
						<xsl:text> van onderopstal</xsl:text>
					</xsl:when>
					<xsl:when test="$aardVerkregenVariant = 'opstal nutsvoorzieningen'">
						<xsl:text> van opstal nutsvoorzieningen</xsl:text>
					</xsl:when>
					<xsl:when test="$aardVerkregenVariant = 'opstal leidingen'">
						<xsl:text> van opstal leidingen</xsl:text>
					</xsl:when>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$aantalRechtMeegegeven = 'false'">
				<xsl:variable name="hetOrDe">
					<xsl:choose>
						<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoudvariant']/tia:tekst, $upper, $lower) = 'true'">
							<xsl:text>de </xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>het </xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<xsl:choose>
					<xsl:when test="$aardVerkregenVariant = 'vruchtgebruik'">
						<xsl:value-of select="$hetOrDe"/>
						<xsl:value-of select="$nadarTeOmschrijvenVarText"/>
						<xsl:text> recht</xsl:text>
						<xsl:if test="$hetOrDe = 'de '">
							<xsl:text>en</xsl:text>
						</xsl:if>
						<xsl:text> van vruchtgebruik</xsl:text>
					</xsl:when>
					<xsl:when test="$aardVerkregenVariant = 'gebruik en bewoning'">
						<xsl:value-of select="$hetOrDe"/>
						<xsl:value-of select="$nadarTeOmschrijvenVarText"/>
						<xsl:text> recht</xsl:text>
						<xsl:if test="$hetOrDe = 'de '">
							<xsl:text>en</xsl:text>
						</xsl:if>
						<xsl:text> van gebruik en bewoning</xsl:text>
					</xsl:when>
				</xsl:choose>
			</xsl:when>
		</xsl:choose>
 	</xsl:template>
</xsl:stylesheet>
