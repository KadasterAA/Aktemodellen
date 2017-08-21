<?xml version="1.0" encoding="UTF-8"?>
<!--
*********************************************************
Stylesheet: tekstblok_natuurlijk_persoon.xsl
Version: 1.09
*********************************************************
Description:
Natural person text block.

Public:
(mode) do-natural-person
(mode) do-gender-salutation
(mode) do-birth-data
(mode) do-marital-status
(mode) do-marital-status-partners

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
		<xsl:apply-templates select="tia:tia_Gegevens[1]/tia:GBA_Ingezetene | tia:tia_Gegevens[1]/tia:IMKAD_NietIngezetene | tia:verklaarder" mode="do-gender-salutation" />
		<xsl:text> </xsl:text>
		<xsl:choose>
			<xsl:when test="tia:tia_Gegevens[2]/tia:IMKAD_KadNatuurlijkPersoon | tia:kadGegevensVerklaarder">
				<xsl:apply-templates select="tia:tia_Gegevens[2]/tia:IMKAD_KadNatuurlijkPersoon | tia:kadGegevensVerklaarder" mode="do-natural-person-personal-data" />
				<xsl:text>, bij de gemeentelijke basisregistratie bekend als </xsl:text>
				<xsl:apply-templates select="tia:tia_Gegevens[1]/tia:GBA_Ingezetene | tia:verklaarder" mode="do-natural-person-personal-data" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="tia:tia_Gegevens[1]/tia:GBA_Ingezetene | tia:tia_Gegevens[1]/tia:IMKAD_NietIngezetene | tia:verklaarder" mode="do-natural-person-personal-data" />
			</xsl:otherwise>
		</xsl:choose>
		<xsl:text>, </xsl:text>
		<xsl:apply-templates select="tia:tia_Gegevens[1]/tia:GBA_Ingezetene | tia:tia_Gegevens[1]/tia:IMKAD_NietIngezetene | tia:verklaarder" mode="do-birth-data" />
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
		<xsl:apply-templates select="tia:gegevens/tia:persoonGegevens" mode="do-gender-salutation"/>
		<xsl:text> </xsl:text>
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
		<xsl:text> op </xsl:text>
		<xsl:value-of select="$Datum_STRING"/>
	</xsl:template>

	<!--
	*********************************************************
	Mode: do-marital-status
	*********************************************************
	Public: yes

	Identity transform: no

	Description: Marital status.

	Input: tia:IMKAD_Persoon

	Params: none

	Output: text

	Calls:
	none

	Called by:
	(mode) do-manager
	(mode) do-party-natural-person-single
	(mode) do-person-pair-representative
	(mode) do-person-pair-housemate
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon" mode="do-marital-status">
		<xsl:variable name="marital-status-text" select="$keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_burgerlijkestaattekst']/tia:tekst[
			position() = translate(normalize-space(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_burgerlijkestaattekst']/tia:tekst), $upper, $lower)]" />
		<xsl:variable name="marital-status-text-copy">
			<xsl:choose>
				<xsl:when test="contains(translate($marital-status-text, $upper, $lower), 'weduwe/weduwnaar')">
					<xsl:choose>
						<xsl:when test="translate(tia:tia_Gegevens/tia:GBA_Ingezetene/tia:geslacht/tia:geslachtsaanduiding, $upper, $lower) = 'vrouw' or translate(tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:geslacht, $upper, $lower) = 'vrouw'">
							<xsl:value-of select="concat(substring-before($marital-status-text, 'weduwe/weduwnaar'), 'weduwe', substring-after($marital-status-text, 'weduwe/weduwnaar'))"/>
						</xsl:when>
						<xsl:when test="translate(tia:tia_Gegevens/tia:GBA_Ingezetene/tia:geslacht/tia:geslachtsaanduiding, $upper, $lower) = 'man' or translate(tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:geslacht, $upper, $lower) = 'man'">
							<xsl:value-of select="concat(substring-before($marital-status-text, 'weduwe/weduwnaar'), 'weduwnaar', substring-after($marital-status-text, 'weduwe/weduwnaar'))"/>
						</xsl:when>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$marital-status-text"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>		
			
		<xsl:choose>
			<xsl:when test="contains(translate($marital-status-text-copy, $upper, $lower), '{tia_partnergegevens}') and not(contains(translate($marital-status-text-copy, $upper, $lower), '{tia_burgerlijkestaattekst}'))">
				<xsl:value-of select="concat(substring-before($marital-status-text-copy, '{tia_PartnerGegevens}'), tia:tia_PartnerGegevens, substring-after($marital-status-text-copy, '{tia_PartnerGegevens}'))"/>
			</xsl:when>		
			<xsl:when test="contains(translate($marital-status-text-copy, $upper, $lower), '{tia_burgerlijkestaattekst}') and not(contains(translate($marital-status-text-copy, $upper, $lower), '{tia_partnergegevens}'))"> 
				<xsl:value-of select="concat(substring-before($marital-status-text-copy, '{tia_BurgerlijkeStaatTekst}'), tia:tia_BurgerlijkeStaatTekst, substring-after($marital-status-text-copy, '{tia_BurgerlijkeStaatTekst}'))"/>
			</xsl:when>
			<xsl:when test="contains(translate($marital-status-text-copy, $upper, $lower), '{tia_partnergegevens}') and contains(translate($marital-status-text-copy, $upper, $lower), '{tia_burgerlijkestaattekst}')">
				<xsl:variable name="middleText">
					<xsl:value-of select="substring-after(substring-before($marital-status-text-copy, '{tia_PartnerGegevens}'), '{tia_BurgerlijkeStaatTekst}')"></xsl:value-of>
				</xsl:variable>
				<xsl:value-of select="concat(substring-before($marital-status-text-copy, '{tia_BurgerlijkeStaatTekst}'), tia:tia_BurgerlijkeStaatTekst, $middleText, tia:tia_PartnerGegevens, substring-after($marital-status-text-copy, '{tia_PartnerGegevens}'))"/>
			</xsl:when>
			<xsl:when test="not(contains(translate($marital-status-text-copy, $upper, $lower), '{tia_partnergegevens}')) and not(contains(translate($marital-status-text-copy, $upper, $lower), '{tia_burgerlijkestaattekst}'))">
				<xsl:value-of select="$marital-status-text-copy"/>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	
	<!--
	*********************************************************
	Mode: do-marital-status-partners
	*********************************************************
	Public: yes

	Identity transform: no

	Description: Marital status of partners.

	Input: tia:IMKAD_Persoon

	Params: none

	Output: text

	Calls:
	none

	Called by:
	(mode) do-person-pair-partner
	(mode) do-person-pair-partner-representative
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon" mode="do-marital-status-partners">
		<xsl:variable name="marital-status-text" select="$keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_burgerlijkestaattekstpartners']/tia:tekst[
			position() = translate(normalize-space(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_burgerlijkestaattekstpartners']/tia:tekst), $upper, $lower)]" />
		<xsl:value-of select="concat(substring-before($marital-status-text, '{tia_BurgerlijkeStaatTekst}'), tia:tia_BurgerlijkeStaatTekst, substring-after($marital-status-text, '{tia_BurgerlijkeStaatTekst}'))"/>
	</xsl:template>

</xsl:stylesheet>
