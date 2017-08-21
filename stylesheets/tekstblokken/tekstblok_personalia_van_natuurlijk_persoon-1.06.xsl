<?xml version="1.0" encoding="UTF-8"?>
<!--
*********************************************************
Stylesheet: tekstblok_personalia_van_natuurlijk_persoon.xsl
Version: 1.06
*********************************************************
Description:
Personal data text block.

Public:
(mode) do-natural-person-personal-data

Private: none
-->

<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
	xmlns:tia="http://www.kadaster.nl/schemas/KIK/TIA_Algemeen"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	exclude-result-prefixes="tia xsl"
	version="1.0">
	
	<!--
	*********************************************************
	Mode: do-natural-person-personal-data
	*********************************************************
	Public: yes

	Identity transform: no

	Description: Particulars of an individual.

	Input: tia:verklaarder, tia:waarnemerVoor, tia:tia_WaarnemerVoor, tia:tia_Ondertekenaar, tia:GBA_Ingezetene, tia:IMKAD_NietIngezetene, tia:persoonGegevens, tia:kadGegevensPersoon, tia:kadGegevensVerklaarder, tia:IMKAD_KadNatuurlijkPersoon

	Params: none

	Output: text

	Calls: none

	Called by: 
	(mode) do-header
	(mode) do-statement-of-equivalence
	(mode) do-natural-person

	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template  match="tia:persoonsgegevens | tia:verklaarder | tia:waarnemerVoor | tia:tia_WaarnemerVoor | tia:tia_Ondertekenaar | tia:GBA_Ingezetene | tia:IMKAD_NietIngezetene | tia:persoonGegevens | tia:kadGegevensPersoon | tia:kadGegevensVerklaarder | tia:IMKAD_KadNatuurlijkPersoon" mode="do-natural-person-personal-data">
		<xsl:if test="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_professor']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
				translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_professor']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
				translate(normalize-space(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_professor']/tia:tekst), $upper, $lower)]), $upper, $lower)]">
			<xsl:value-of select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_professor']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
				translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_professor']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
				translate(normalize-space(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_professor']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:if test="tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_professor']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
				translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_professor']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
				translate(normalize-space(current()/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_professor']/tia:tekst), $upper, $lower)]), $upper, $lower)]">
			<xsl:value-of select="tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_professor']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
				translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_professor']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
				translate(normalize-space(current()/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_professor']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:if test="(tia:tia_AdellijkeTitel or tia:adellijkeTitelOfPredikaat) 
				and (normalize-space(tia:tia_AdellijkeTitel) != '' or normalize-space(tia:adellijkeTitelOfPredikaat) != '')">
			<xsl:value-of select="tia:tia_AdellijkeTitel | tia:adellijkeTitelOfPredikaat"/>
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:if test="tia:tia_Titel and normalize-space(tia:tia_Titel) != ''">
			<xsl:value-of select="tia:tia_Titel"/>
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:value-of select="tia:naam/tia:voornamen | tia:voornamen"/>
		<xsl:text> </xsl:text>
		<xsl:if test="tia:tia_AdellijkeTitel2 and normalize-space(tia:tia_AdellijkeTitel2) != ''">
			<xsl:value-of select="tia:tia_AdellijkeTitel2"/>
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:if test="(tia:tia_VoorvoegselsNaam or tia:voorvoegsels or tia:voorvoegselsgeslachtsnaam)
				and normalize-space(tia:tia_VoorvoegselsNaam | tia:voorvoegsels | tia:voorvoegselsgeslachtsnaam) != ''">
			<xsl:value-of select="tia:tia_VoorvoegselsNaam | tia:voorvoegsels | tia:voorvoegselsgeslachtsnaam"/>
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:value-of select="tia:tia_NaamZonderVoorvoegsels | tia:geslachtsnaam"/>
		<xsl:if test="tia:tia_Titel2 and normalize-space(tia:tia_Titel2) != ''">
			<xsl:text> </xsl:text>
			<xsl:value-of select="tia:tia_Titel2"/>
		</xsl:if>
	</xsl:template>

</xsl:stylesheet>
	