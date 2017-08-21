<?xml version="1.0" encoding="UTF-8"?>
<!--
*********************************************************
Stylesheet: tekstblok_overbruggingshypotheek.xsl
Version: 1.07
*********************************************************
Description:
Bridging mortgage text block.

Public:
(mode) do-bridging-mortgage

Private:
(mode) do-bridging-mortgage-text
-->
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
	xmlns:tia="http://www.kadaster.nl/schemas/KIK/TIA_Algemeen"
	xmlns:kef="nl.kadaster.xslt.XslExtensionFunctions"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	exclude-result-prefixes="tia kef xsl"
	version="1.0">

	<!--
	*********************************************************
	Mode: do-bridging-mortgage
	*********************************************************
	Public: yes

	Identity transform: no

	Description: Bridging mortgage main template.

	Input: tia:StukdeelHypotheek

	Params: indentLevel - indicates how many empty TDs are inserted before text TD, default is zero
			indentLabel - indicates label that is used in the last indented TD, default is zero-length non-breaking space
			colspan - colspan value in case of indented text block that only has one right in the list of rights

	Output: XHTML structure

	Calls:
	(mode) do-bridging-mortgage-text
	(mode) do-right
	(mode) do-registered-object
	(name) processRights
	(name) indent

	Called by:
	(mode) do-deed
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:StukdeelHypotheek" mode="do-bridging-mortgage">
		<xsl:param name="indentLevel" select="number('0')"/>
		<xsl:param name="indentLabel" select="'&#xFEFF;'"/>
		<xsl:param name="colspan" select="number('0')"/>

		<xsl:choose>
			<xsl:when test="$indentLevel > 0">
				<tr>
					<xsl:call-template name="indent">
						<xsl:with-param name="current" select="number('1')"/>
						<xsl:with-param name="indentLevel" select="$indentLevel - 1"/>
					</xsl:call-template>
					<td class="number" valign="top">
						<xsl:value-of select="$indentLabel"/>
					</td>
					<td>
						<xsl:if test="$colspan > 2">
							<xsl:attribute name="colspan"><xsl:value-of select="$colspan - 1"/></xsl:attribute>
						</xsl:if>
						<a name="hyp3.bridgingMortgage" class="location" style="_position: relative;">&#160;</a>
						<u><xsl:value-of select="tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_titeloverbrugging']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
							translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_titeloverbrugging']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
							translate(normalize-space(current()/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_titeloverbrugging']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/></u>
					</td>
				</tr>
				<tr>
					<xsl:call-template name="indent">
						<xsl:with-param name="current" select="number('1')"/>
						<xsl:with-param name="indentLevel" select="$indentLevel - 1"/>
					</xsl:call-template>
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<td>
						<xsl:if test="$colspan > 2">
							<xsl:attribute name="colspan"><xsl:value-of select="$colspan - 1"/></xsl:attribute>
						</xsl:if>
						<xsl:apply-templates select="." mode="do-bridging-mortgage-text"/>
					</td>
				</tr>
				<xsl:choose>
					<xsl:when test="count(tia:IMKAD_ZakelijkRecht) = 1">
						<tr>
							<xsl:call-template name="indent">
								<xsl:with-param name="current" select="number('1')"/>
								<xsl:with-param name="indentLevel" select="$indentLevel - 1"/>
							</xsl:call-template>
							<td class="number" valign="top">
								<xsl:text>&#xFEFF;</xsl:text>
							</td>
							<td>
								<xsl:if test="$colspan > 2">
									<xsl:attribute name="colspan"><xsl:value-of select="$colspan - 1"/></xsl:attribute>
								</xsl:if>
								<xsl:variable name="rightText">
									<xsl:apply-templates select="tia:IMKAD_ZakelijkRecht" mode="do-right"/>
								</xsl:variable>
								<xsl:if test="normalize-space($rightText) != ''">
									<xsl:value-of select="$rightText"/>
									<xsl:text> </xsl:text>
								</xsl:if>
								<xsl:apply-templates select="tia:IMKAD_ZakelijkRecht" mode="do-registered-object"/>
								<xsl:text>.</xsl:text>
							</td>
						</tr>
					</xsl:when>
					<!-- Multiple registered objects, all parcels with same data -->
					<xsl:when test="count(tia:IMKAD_ZakelijkRecht)
							= count(tia:IMKAD_ZakelijkRecht[
								((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen']/tia:tekst
										= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen']/tia:tekst)
									or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen'])
										and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen'])))
								and tia:aardVerkregen = current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:aardVerkregen
								and normalize-space(tia:aardVerkregen) != ''
								and ((tia:tia_Aantal_BP_Rechten
										= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_Aantal_BP_Rechten)
									or (not(tia:tia_Aantal_BP_Rechten)
										and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_Aantal_BP_Rechten)))
								and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven']/tia:tekst
										= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven']/tia:tekst)
									or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven'])
										and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven'])))
								and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom']/tia:tekst
										= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom']/tia:tekst)
									or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom'])
										and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom'])))
								and ((tia:aandeelInRecht/tia:teller	= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:aandeelInRecht/tia:teller 
									and tia:aandeelInRecht/tia:noemer = current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:aandeelInRecht/tia:noemer)
									or (not(tia:aandeelInRecht)
										and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:aandeelInRecht)))
								and tia:IMKAD_Perceel[
									tia:tia_OmschrijvingEigendom
										= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_OmschrijvingEigendom
									and normalize-space(tia:tia_OmschrijvingEigendom) != ''
									and ((tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid']/tia:tekst
											= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid']/tia:tekst)
										or (not(tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid'])
											and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid'])))
									and ((tia:tia_SplitsingsverzoekOrdernummer
											= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_SplitsingsverzoekOrdernummer)
										or (not(tia:tia_SplitsingsverzoekOrdernummer)
											and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_SplitsingsverzoekOrdernummer)))
									and tia:kadastraleAanduiding/tia:gemeente
										= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:kadastraleAanduiding/tia:gemeente
									and normalize-space(tia:kadastraleAanduiding/tia:gemeente) != ''
									and tia:kadastraleAanduiding/tia:sectie
										= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:kadastraleAanduiding/tia:sectie
									and normalize-space(tia:kadastraleAanduiding/tia:sectie) != ''
									and tia:IMKAD_OZLocatie/tia:ligging
										= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:ligging
									and normalize-space(tia:IMKAD_OZLocatie/tia:ligging) != ''
									and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer
										= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer)
										or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer)
											and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer)))
									and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter
											= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter)
										or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter)
											and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter)))
									and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging
											= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging)
										or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging)
											and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging)))
									and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode
											= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode)
										or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode)
											and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode)))
									and tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam
										= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam
									and normalize-space(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam) != ''
									and tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam
										= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam
									and normalize-space(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam) != '']])">
						<tr>
							<xsl:call-template name="indent">
								<xsl:with-param name="current" select="number('1')"/>
								<xsl:with-param name="indentLevel" select="$indentLevel - 1"/>
							</xsl:call-template>
							<td class="number" valign="top">
								<xsl:text>&#xFEFF;</xsl:text>
							</td>
							<td>
								<xsl:if test="$colspan > 2">
									<xsl:attribute name="colspan"><xsl:value-of select="$colspan - 1"/></xsl:attribute>
								</xsl:if>
								<xsl:variable name="rightText">
									<xsl:apply-templates select="tia:IMKAD_ZakelijkRecht[1]" mode="do-right"/>
								</xsl:variable>
								<xsl:if test="normalize-space($rightText) != ''">
									<xsl:value-of select="$rightText"/>
									<xsl:text> </xsl:text>
								</xsl:if>
								<xsl:apply-templates select="tia:IMKAD_ZakelijkRecht[1]" mode="do-registered-object"/>
								<xsl:text>.</xsl:text>
							</td>
						</tr>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="processRights">
							<xsl:with-param name="positionOfProcessedRight" select="1"/>
							<xsl:with-param name="position" select="1"/>
							<xsl:with-param name="registeredObjects" select="."/>
							<xsl:with-param name="indentLevel" select="$indentLevel"/>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<a name="hyp3.bridgingMortgage" class="location">&#160;</a>
				<p>
					<u><xsl:value-of select="tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_titeloverbrugging']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
						translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_titeloverbrugging']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
						translate(normalize-space(current()/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_titeloverbrugging']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/></u>
					<br />
					<xsl:apply-templates select="." mode="do-bridging-mortgage-text"/>
				</p>
				<xsl:choose>
					<xsl:when test="count(tia:IMKAD_ZakelijkRecht) = 1">
						<p>
							<xsl:variable name="rightText">
								<xsl:apply-templates select="tia:IMKAD_ZakelijkRecht" mode="do-right"/>
							</xsl:variable>
							<xsl:if test="normalize-space($rightText) != ''">
								<xsl:value-of select="$rightText"/>
								<xsl:text> </xsl:text>
							</xsl:if>
							<xsl:apply-templates select="tia:IMKAD_ZakelijkRecht" mode="do-registered-object"/>
							<xsl:text>.</xsl:text>
						</p>
					</xsl:when>
					<!-- Multiple registered objects, all parcels with same data -->
					<xsl:when test="count(tia:IMKAD_ZakelijkRecht)
							= count(tia:IMKAD_ZakelijkRecht[
								((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen']/tia:tekst
										= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen']/tia:tekst)
									or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen'])
										and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen'])))
								and tia:aardVerkregen = current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:aardVerkregen
								and normalize-space(tia:aardVerkregen) != ''
								and ((tia:tia_Aantal_BP_Rechten
										= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_Aantal_BP_Rechten)
									or (not(tia:tia_Aantal_BP_Rechten)
										and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_Aantal_BP_Rechten)))
								and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven']/tia:tekst
										= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven']/tia:tekst)
									or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven'])
										and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven'])))
								and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom']/tia:tekst
										= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom']/tia:tekst)
									or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom'])
										and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom'])))
								and ((tia:aandeelInRecht/tia:teller	= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:aandeelInRecht/tia:teller 
									and tia:aandeelInRecht/tia:noemer = current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:aandeelInRecht/tia:noemer)
									or (not(tia:aandeelInRecht)
										and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:aandeelInRecht)))
								and tia:IMKAD_Perceel[
									tia:tia_OmschrijvingEigendom
										= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_OmschrijvingEigendom
									and normalize-space(tia:tia_OmschrijvingEigendom) != ''
									and ((tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid']/tia:tekst
											= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid']/tia:tekst)
										or (not(tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid'])
											and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid'])))
									and ((tia:tia_SplitsingsverzoekOrdernummer
											= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_SplitsingsverzoekOrdernummer)
										or (not(tia:tia_SplitsingsverzoekOrdernummer)
											and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_SplitsingsverzoekOrdernummer)))
									and tia:kadastraleAanduiding/tia:gemeente
										= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:kadastraleAanduiding/tia:gemeente
									and normalize-space(tia:kadastraleAanduiding/tia:gemeente) != ''
									and tia:kadastraleAanduiding/tia:sectie
										= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:kadastraleAanduiding/tia:sectie
									and normalize-space(tia:kadastraleAanduiding/tia:sectie) != ''
									and tia:IMKAD_OZLocatie/tia:ligging
										= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:ligging
									and normalize-space(tia:IMKAD_OZLocatie/tia:ligging) != ''
									and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer
										= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer)
										or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer)
											and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer)))
									and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter
											= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter)
										or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter)
											and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter)))
									and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging
											= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging)
										or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging)
											and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging)))
									and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode
											= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode)
										or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode)
											and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode)))
									and tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam
										= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam
									and normalize-space(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam) != ''
									and tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam
										= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam
									and normalize-space(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam) != '']])">
						<p>
							<xsl:variable name="rightText">
								<xsl:apply-templates select="tia:IMKAD_ZakelijkRecht[1]" mode="do-right"/>
							</xsl:variable>
							<xsl:if test="normalize-space($rightText) != ''">
								<xsl:value-of select="$rightText"/>
								<xsl:text> </xsl:text>
							</xsl:if>
							<xsl:apply-templates select="tia:IMKAD_ZakelijkRecht[1]" mode="do-registered-object"/>
							<xsl:text>.</xsl:text>
						</p>
					</xsl:when>
					<xsl:otherwise>
						<table cellpadding="0" cellspacing="0">
							<tbody>
								<xsl:call-template name="processRights">
									<xsl:with-param name="positionOfProcessedRight" select="1"/>
									<xsl:with-param name="position" select="1"/>
									<xsl:with-param name="registeredObjects" select="."/>
								</xsl:call-template>
							</tbody>
						</table>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--
	*********************************************************
	Mode: do-bridging-mortgage-text
	*********************************************************
	Public: no

	Identity transform: no

	Description: Bridging mortgage text.

	Input: tia:StukdeelHypotheek

	Params: none

	Output: text

	Calls:
	none.

	Called by:
	(mode) do-bridging-mortgage
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:StukdeelHypotheek" mode="do-bridging-mortgage-text">
		<xsl:variable name="debtor" select="tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_vervreemderoverbrugging']/tia:tekst" />
		<xsl:variable name="bridgingOptionalText" select="tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_zekerheidoverbrugging']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_zekerheidoverbrugging']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space(current()/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_zekerheidoverbrugging']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>

		<xsl:text>Voorts verleent de </xsl:text>
		<xsl:value-of select="$debtor"/>
		<xsl:text>, tot </xsl:text>
		<xsl:value-of select="$bridgingOptionalText"/>
		<xsl:if test="$bridgingOptionalText">
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:text>zekerheid voor de betaling van de </xsl:text>
		<xsl:value-of select="tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aardoverbrugging']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aardoverbrugging']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space(current()/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aardoverbrugging']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
		<xsl:text> als hierboven vermeld, bij deze aan </xsl:text>
		<xsl:value-of select="tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verkrijgeroverbrugging']/tia:tekst"/>
		<xsl:text>, die van de </xsl:text>
		<xsl:value-of select="$debtor"/>
		<xsl:text>, aanvaardt, het recht van </xsl:text>
		<xsl:if test="tia:rangordeHypotheek	and normalize-space(tia:rangordeHypotheek) != ''">
			<xsl:value-of select="kef:convertOrdinalToText(tia:rangordeHypotheek)"/>
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:text>hypotheek op het hierna te omschrijven onderpand:</xsl:text>
	</xsl:template>

</xsl:stylesheet>
