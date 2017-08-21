<?xml version="1.0" encoding="UTF-8"?>
<!--
*********************************************************
Stylesheet: tekstblok_aanhef_notariele_verklaring.xsl
Version: 1.03
*********************************************************
Description:
Header text block. Used by Notary statement deed.

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

	Description: Header text block for Notary statement deed.

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
		<p>
			<xsl:value-of select="$indicationToday"/>
			<xsl:if test="translate($indicationToday, $upper, $lower) != 'op'">
				<xsl:text>,</xsl:text>
			</xsl:if>
			<xsl:text> </xsl:text>
			<xsl:value-of select="$Datum_STRING"/>
			<xsl:text>, </xsl:text>
			<xsl:text>verklaart </xsl:text>
			<xsl:apply-templates select="tia:ondertekenaar/tia:tia_Ondertekenaar" mode="do-natural-person-personal-data" />
			<xsl:if test="tia:ondertekenaar/tia:tia_WaarnemerVoor">
				<!-- Waarnamer notaris -->
				<xsl:text> hierna te noemen:</xsl:text>
				<br/>
				<xsl:text>'</xsl:text>
				<u>notaris</u>
				<xsl:text>', als waarnemer van </xsl:text>
				<xsl:apply-templates select="tia:ondertekenaar/tia:tia_WaarnemerVoor" mode="do-natural-person-personal-data" />
			</xsl:if>			
			<xsl:text>, notaris </xsl:text>
			<xsl:choose>
				<xsl:when test="contains(translate($declarerPlace, $upper, $lower), '{tia_gemeente}')">
					<xsl:value-of select="concat(substring-before($declarerPlace, '{'), tia:ondertekenaar/tia:tia_Gemeente, substring-after($declarerPlace, '}'))"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$declarerPlace"/>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text> </xsl:text>
			<xsl:value-of select="tia:ondertekenaar/tia:standplaats"/>
			<xsl:text> als volgt.</xsl:text>
		</p>
	</xsl:template>

</xsl:stylesheet>
