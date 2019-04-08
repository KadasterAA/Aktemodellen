<?xml version="1.0" encoding="UTF-8"?>
<!--
*********************************************************
Stylesheet: tekstblok_natuurlijk_persoon.xsl
Version: 1.12
*********************************************************
Description:
Natural person text block.

Public:
(mode) do-natural-person
(mode) do-gender-salutation
(mode) do-birth-data

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
	Mode: do-natural-person
	*********************************************************
	Public: yes

	Identity transform: no

	Description: Natural person text block.

	Input: tia:IMKAD_Persoon, tia:tia_Verklaarder

	Params: none

	Output: text

	Calls:
	(mode) do-gender-salutation
	(mode) do-natural-person-personal-data
	(mode) do-birth-data

	Called by:
	(mode) do-manager
	(mode) do-party-natural-person-common
	(mode) do-person-pair-partner
	(mode) do-party-natural-person-first-person
	(mode) do-party-natural-person-second-person
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon | tia:tia_Verklaarder" mode="do-natural-person">
<!-- LET OP : voor de Particuliere en Rabo hypotheek is tbv het partnerspecifieke gedeelte een kopie van dit template opgenomen: do-natural-person-part en do-natural-person-rabo. 
				Dus bij aanpassingen moeten ook de Rabo en Particuliere Hypotheek aangepast worden -->
	
		<xsl:variable name="genderShouldBePrinted">
			<xsl:choose>
				<xsl:when test="normalize-space(translate(tia:tia_Gegevens/tia:IMKAD_KadNatuurlijkPersoon/tia:adellijkeTitelOfPredikaat, $upper, $lower)) != '' 
						or normalize-space(translate(tia:tia_Gegevens/tia:IMKAD_KadNatuurlijkPersoon/tia:tia_AdellijkeTitel2, $upper, $lower)) != ''">
					<xsl:text>false</xsl:text>
				</xsl:when>
				<xsl:when test="not(tia:tia_Gegevens/tia:IMKAD_KadNatuurlijkPersoon)
						and (normalize-space(translate(tia:tia_Gegevens/tia:GBA_Ingezetene/tia:tia_AdellijkeTitel, $upper, $lower)) != ''
						or normalize-space(translate(tia:tia_Gegevens/tia:GBA_Ingezetene/tia:tia_AdellijkeTitel2, $upper, $lower)) != '')">
					<xsl:text>false</xsl:text>
				</xsl:when>
				<xsl:when test="not(tia:tia_Gegevens/tia:IMKAD_KadNatuurlijkPersoon)
						and (normalize-space(translate(tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:tia_AdellijkeTitel, $upper, $lower)) != '' 
						or normalize-space(translate(tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:tia_AdellijkeTitel2, $upper, $lower)) != '')">
					<xsl:text>false</xsl:text>
				</xsl:when>
				<xsl:when test="normalize-space(translate(tia:verklaarder/tia:tia_AdellijkeTitel, $upper, $lower)) != '' 
					or normalize-space(translate(tia:verklaarder/tia:tia_AdellijkeTitel2, $upper, $lower)) != ''">
					<xsl:text>false</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>true</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<xsl:if test="$genderShouldBePrinted = 'true'">
			<xsl:apply-templates select="tia:tia_Gegevens/tia:GBA_Ingezetene | tia:tia_Gegevens/tia:IMKAD_NietIngezetene | tia:verklaarder" mode="do-gender-salutation" />
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:choose>
			<xsl:when test="tia:tia_Gegevens/tia:IMKAD_KadNatuurlijkPersoon | tia:kadGegevensVerklaarder">
				<xsl:apply-templates select="tia:tia_Gegevens/tia:IMKAD_KadNatuurlijkPersoon | tia:kadGegevensVerklaarder" mode="do-natural-person-personal-data" />
				<xsl:text>, bij de gemeentelijke basisregistratie bekend als </xsl:text>
				<xsl:apply-templates select="tia:tia_Gegevens/tia:GBA_Ingezetene | tia:verklaarder" mode="do-natural-person-personal-data" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="tia:tia_Gegevens/tia:GBA_Ingezetene | tia:tia_Gegevens/tia:IMKAD_NietIngezetene | tia:verklaarder" mode="do-natural-person-personal-data" />
			</xsl:otherwise>
		</xsl:choose>
		<xsl:text>, </xsl:text>
		<xsl:apply-templates select="tia:tia_Gegevens/tia:GBA_Ingezetene | tia:tia_Gegevens/tia:IMKAD_NietIngezetene | tia:verklaarder" mode="do-birth-data" />
	</xsl:template>

	<!--
	*********************************************************
	Mode: do-natural-person
	*********************************************************
	Public: yes

	Identity transform: no

	Description: Natural person text block.

	Input: tia:Gevolmachtigde

	Params: none

	Output: text

	Calls:
	(mode) do-gender-salutation
	(mode) do-natural-person-personal-data
	(mode) do-birth-data

	Called by:
	(mode) do-legal-representative
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:Gevolmachtigde" mode="do-natural-person">
		<xsl:variable name="genderShouldBePrinted">
			<xsl:choose>
				<xsl:when test="normalize-space(translate(tia:gegevens/tia:persoonGegevens/tia:tia_AdellijkeTitel, $upper, $lower)) != '' 
					or normalize-space(translate(tia:gegevens/tia:persoonGegevens/tia:tia_AdellijkeTitel2, $upper, $lower)) != ''">
					<xsl:text>false</xsl:text>
				</xsl:when>
				<xsl:when test="normalize-space(translate(tia:gegevens/tia:kadGegevensPersoon/tia:adellijkeTitelOfPredikaat, $upper, $lower)) != '' 
					or normalize-space(translate(tia:gegevens/tia:kadGegevensPersoon/tia:tia_AdellijkeTitel2, $upper, $lower)) != ''">
					<xsl:text>false</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>true</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<xsl:if test="$genderShouldBePrinted = 'true'">
			<xsl:apply-templates select="tia:gegevens/tia:persoonGegevens" mode="do-gender-salutation"/>
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:choose>
			<xsl:when test="tia:gegevens/tia:kadGegevensPersoon">
				<xsl:apply-templates select="tia:gegevens/tia:kadGegevensPersoon" mode="do-natural-person-personal-data" />
				<xsl:text>, bij de gemeentelijke basisregistratie bekend als </xsl:text>
				<xsl:apply-templates select="tia:gegevens/tia:persoonGegevens" mode="do-natural-person-personal-data" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="tia:gegevens/tia:persoonGegevens" mode="do-natural-person-personal-data" />
			</xsl:otherwise>
		</xsl:choose>
		<xsl:text>, </xsl:text>
		<xsl:apply-templates select="tia:gegevens/tia:persoonGegevens" mode="do-birth-data" />
	</xsl:template>

	<!--
	*********************************************************
	Mode: do-gender-salutation
	*********************************************************
	Public: yes

	Identity transform: no

	Description: Gender salutation for natural person.

	Input: tia:persoonGegevens,	tia:GBA_Ingezetene, tia:IMKAD_NietIngezetene or tia:verklaarder

	Params: none

	Output: text

	Calls:
	none

	Called by:
	(mode) do-natural-person
	(mode) do-person-pair-partner-variant-two
	(mode) do-person-pair-housemate-variant-three
	(mode) do-person-pair-partner-variant-four
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:persoonGegevens | tia:GBA_Ingezetene | tia:IMKAD_NietIngezetene | tia:verklaarder" mode="do-gender-salutation">
		<xsl:choose>
			<xsl:when test="translate(tia:geslacht/tia:geslachtsaanduiding, $upper, $lower) = 'man' or translate(tia:geslacht, $upper, $lower) = 'man'">
				<xsl:text>de heer</xsl:text>
			</xsl:when>
			<xsl:when test="translate(tia:geslacht/tia:geslachtsaanduiding, $upper, $lower) = 'vrouw' or translate(tia:geslacht, $upper, $lower) = 'vrouw'">
				<xsl:text>mevrouw</xsl:text>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<!--
	*********************************************************
	Mode: do-birth-data
	*********************************************************
	Public: yes

	Identity transform: no

	Description: Birth data regarding natural person.

	Input: tia:persoonGegevens,	tia:GBA_Ingezetene, tia:IMKAD_NietIngezetene or  tia:verklaarder

	Params: none

	Output: text

	Calls:
	none

	Called by:
	(mode) do-natural-person
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:persoonGegevens | tia:GBA_Ingezetene | tia:IMKAD_NietIngezetene | tia:verklaarder" mode="do-birth-data">
		<xsl:variable name="Datum_DATE" select="substring(string(tia:geboorte/tia:geboortedatum
			| tia:geboortedatum), 0, 11)"/>
		<xsl:variable name="Datum_STRING">
			<xsl:if test="$Datum_DATE != ''">
				<xsl:value-of select="kef:convertDateToText($Datum_DATE)"/>
			</xsl:if>
		</xsl:variable>
		<xsl:text>geboren te </xsl:text>
		<xsl:value-of select="tia:geboorte/tia:geboorteplaatsOmschrijving | tia:geboorteplaats"/>
		<xsl:choose>
			<xsl:when test="tia:geboorte/tia:geboorteland | tia:geboorteland">
				<xsl:text>, </xsl:text>
				<xsl:value-of select="tia:geboorte/tia:geboorteland | tia:geboorteland"/>
			</xsl:when>
		</xsl:choose>
		<xsl:text> op </xsl:text>
		<xsl:value-of select="$Datum_STRING"/>
	</xsl:template>

</xsl:stylesheet>
