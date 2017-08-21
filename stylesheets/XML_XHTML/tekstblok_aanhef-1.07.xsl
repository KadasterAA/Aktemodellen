<?xml version="1.0" encoding="UTF-8"?>
<!--
*********************************************************
Stylesheet: tekstblok_aanhef.xsl
Version: 1.07
*********************************************************
Description:
Header text block.

Public:
(mode) do-header

Private:
none
-->
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
	xmlns:tia="http://www.kadaster.nl/schemas/KIK/TIA_Algemeen"
	xmlns:kef="nl.kadaster.xslt.XslExtensionFunctions"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	exclude-result-prefixes="tia kef xsl"
	version="1.0">

	<!--
	*********************************************************
	Mode: do-header
	*********************************************************
	Public: yes

	Identity transform: no

	Description: Header text block.

	Input: tia:IMKAD_AangebodenStuk

	Params: none

	Output: XHTML structure (<p/>)

	Calls:
	(mode) do-natural-person-personal-data

	Called by:
	(mode) do-deed
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_AangebodenStuk" mode="do-header">
		<xsl:variable name="Datum_DATE" select="substring(string(tia:tia_DatumOndertekening), 0, 11)"/>
		<xsl:variable name="Datum_STRING">
			<xsl:if test="$Datum_DATE != ''">
				<xsl:value-of select="kef:convertDateToText($Datum_DATE)"/>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="indicationToday" select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_dagaanduiding']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_dagaanduiding']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_dagaanduiding']/tia:tekst), $upper, $lower)]), $upper, $lower)]" />
		<xsl:variable name="declarerPlace" select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_ondertekenaarplaatsaanduiding']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_ondertekenaarplaatsaanduiding']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_ondertekenaarplaatsaanduiding']/tia:tekst), $upper, $lower)]), $upper, $lower)]" />
		<xsl:variable name="notaryCandidate" select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_kandidaat']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_kandidaat']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_kandidaat']/tia:tekst), $upper, $lower)]), $upper, $lower)]" />	
		<xsl:variable name="vacantOffice" select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_vacantkantoor']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_vacantkantoor']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_vacantkantoor']/tia:tekst), $upper, $lower)]), $upper, $lower)]" />
			
		<p>
			<xsl:value-of select="$indicationToday"/>
			<xsl:if test="translate($indicationToday, $upper, $lower) != 'op'">
				<xsl:text>,</xsl:text>
			</xsl:if>
			<xsl:text> </xsl:text>
			<xsl:value-of select="$Datum_STRING"/>
			<xsl:text>, </xsl:text>
			<xsl:choose>
				<!-- One representative for all parties -->
				<xsl:when test="tia:Gevolmachtigde"><xsl:text>verscheen</xsl:text></xsl:when>
				<!-- No representative or representative is per party -->
				<xsl:otherwise><xsl:text>verschenen</xsl:text></xsl:otherwise>
			</xsl:choose>
			<xsl:text> voor mij, </xsl:text>
			<xsl:apply-templates select="tia:ondertekenaar/tia:tia_Ondertekenaar" mode="do-natural-person-personal-data" />
			<xsl:if test="tia:ondertekenaar/tia:tia_WaarnemerVoor">
				<xsl:text>, </xsl:text>
				<xsl:if test="$notaryCandidate">
					<xsl:value-of select="$notaryCandidate"/>
					<xsl:text> </xsl:text>
				</xsl:if>
				<!-- Waarnamer notaris -->
				<xsl:text>hierna te noemen:</xsl:text>
				<br/>
				<xsl:text>'</xsl:text>
				<u>notaris</u>
				<xsl:text>', als waarnemer </xsl:text>
				<xsl:if test="$vacantOffice">
					<xsl:value-of select="$vacantOffice"/>
					<xsl:text> </xsl:text>
				</xsl:if>
				<xsl:text>van </xsl:text>
				<xsl:apply-templates select="tia:ondertekenaar/tia:tia_WaarnemerVoor" mode="do-natural-person-personal-data" />
			</xsl:if>			
			<xsl:text>, </xsl:text>
			<xsl:if test="$vacantOffice">
				<xsl:text>destijds </xsl:text>
			</xsl:if>
			<xsl:text>notaris </xsl:text>
			<xsl:choose>
				<xsl:when test="$declarerPlace = '1'">
					<xsl:text>in de gemeente </xsl:text>
					<xsl:value-of select="tia:ondertekenaar/tia:tia_Gemeente"/>
					<xsl:text> kantoorhoudende te</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$declarerPlace"/>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text> </xsl:text>
			<xsl:value-of select="tia:ondertekenaar/tia:standplaats"/>
			<xsl:text>:</xsl:text>
		</p>
	</xsl:template>

</xsl:stylesheet>
