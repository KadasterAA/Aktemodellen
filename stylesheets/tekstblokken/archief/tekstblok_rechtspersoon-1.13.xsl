<?xml version="1.0" encoding="UTF-8"?>
<!--
*********************************************************
Stylesheet: tekstblok_rechtspersoon.xsl
Version: 1.13 : AA-2284
*********************************************************
Description:
Legal person text block.

Public:
(mode) do-legal-person

Private:
(mode) do-legal-person-data
(mode) do-legal-person-same-residence-address
(mode) do-chamber-of-commerce-data
-->
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
	xmlns:kef="nl.kadaster.xslt.XslExtensionFunctions"
	xmlns:tia="http://www.kadaster.nl/schemas/KIK/TIA_Algemeen"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	exclude-result-prefixes="tia xsl kef"
	version="1.0">

	<!--
	*********************************************************
	Mode: do-legal-person
	*********************************************************
	Public: yes

	Identity transform: no

	Description: Legal person text block.

	Input: tia:IMKAD_Persoon or tia:vofCvMs

	Params: none

	Output: text

	Calls:
	(mode) do-legal-person-data
	(mode) do-address
	(mode) do-legal-person-same-residence-address
	(mode) do-chamber-of-commerce-data

	Called by:
	(mode) do-party-legal-person
	(mode) do-vof-cv-ms
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon | tia:vofCvMs" mode="do-legal-person">
		<xsl:variable name="addressChoice" select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_kantoorhoudende']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_kantoorhoudende']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_kantoorhoudende']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
		<xsl:variable name="addressPreposition" select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_kantoorhoudendelidwoord']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_kantoorhoudendelidwoord']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_kantoorhoudendelidwoord']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
		<xsl:variable name="statutory" select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_statutair']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_statutair']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_statutair']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
		<xsl:variable name="municipalities" select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_gemeentewet']/tia:tekst"/>
		<xsl:choose>
			<xsl:when test="tia:tia_Gegevens/tia:NHR_Rechtspersoon">
				<xsl:apply-templates select="tia:tia_Gegevens/tia:NHR_Rechtspersoon" mode="do-legal-person-data">
					<xsl:with-param name="statutory" select="$statutory"/>
					<xsl:with-param name="municipalities" select="$municipalities"/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="." mode="do-legal-person-data">
					<xsl:with-param name="statutory" select="$statutory"/>
					<xsl:with-param name="municipalities" select="$municipalities"/>
				</xsl:apply-templates>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:if test="translate($addressChoice, $upper, $lower) = 'kantoorhoudende te' or translate($addressChoice, $upper, $lower) = 'mede kantoorhoudende te'">
			<xsl:text>,</xsl:text>
		</xsl:if>
		<xsl:text> </xsl:text>
		<xsl:value-of select="$addressChoice"/>
		<xsl:text> </xsl:text>
		<xsl:choose>
			<!-- TODO: use value lists -->
			<xsl:when test="translate($addressChoice, $upper, $lower) = 'kantoorhoudende te' or translate($addressChoice, $upper, $lower) = 'mede kantoorhoudende te' ">
				<xsl:apply-templates select="tia:IMKAD_WoonlocatiePersoon" mode="do-address" />
			</xsl:when>
			<xsl:when test="translate($addressChoice, $upper, $lower) = 'en aldaar kantoorhoudende aan'">
				<xsl:value-of select="$addressPreposition"/>
				<xsl:text> </xsl:text>
				<!-- Must be domestic (binnenlands) address -->
				<xsl:apply-templates select="tia:IMKAD_WoonlocatiePersoon/tia:adres/tia:binnenlandsAdres" mode="do-legal-person-same-residence-address" />
			</xsl:when>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="tia:tia_Gegevens/tia:NHR_Rechtspersoon">
				<xsl:apply-templates select="tia:tia_Gegevens/tia:NHR_Rechtspersoon" mode="do-chamber-of-commerce-data"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="." mode="do-chamber-of-commerce-data"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--
	*********************************************************
	Mode: do-legal-person-data
	*********************************************************
	Public: no

	Identity transform: no

	Description: Basic data for legal person.

	Input: tia:NHR_Rechtspersoon or tia:vofCvMs

	Params: statutory - optional statutory text
			municipalities - optional municipalities text

	Output: text

	Calls:
	none

	Called by:
	(mode) do-legal-person
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:NHR_Rechtspersoon | tia:vofCvMs" mode="do-legal-person-data">
		<xsl:param name="statutory" select="''"/>
		<xsl:param name="municipalities" select="''"/>
		<xsl:choose>
			<xsl:when test="translate(tia:rechtsvormSub, $upper, $lower) = 'de staat' or tia:rechtsvormSub = ''"/>
			<xsl:when test="contains(translate(tia:rechtsvormSub, $upper, $lower), 'kerkgenootschap')">
				<xsl:text>het </xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>de </xsl:text>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:value-of select="tia:rechtsvormSub"/>
		<xsl:if test="translate(tia:rechtsvormSub, $upper, $lower) = 'publiekrechtelijk rechtspersoon' 
					  and translate(normalize-space($municipalities), $upper, $lower) = 'true'">
				<xsl:text>, ingevolge het bepaalde in artikel 171 van de Gemeentewet</xsl:text>
		</xsl:if>
		<xsl:text>: </xsl:text>
		<xsl:value-of select="tia:statutaireNaam"/>
		<xsl:text>, </xsl:text>
		<xsl:if test="normalize-space(tia:tia_HandelendOnderNaam) != ''">
			<xsl:text>handelend onder de naam </xsl:text>
			<xsl:value-of select="tia:tia_HandelendOnderNaam"/>
			<xsl:text>, </xsl:text>
		</xsl:if>
		<xsl:if test="$statutory">
			<xsl:value-of select="$statutory"/>
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:text>gevestigd te </xsl:text>
		<xsl:value-of select="tia:statutaireZetel"/>
		<xsl:if test="tia:tia_LandStatutaireZetel
				and normalize-space(tia:tia_LandStatutaireZetel) != ''">
			<xsl:text> </xsl:text>
			<xsl:value-of select="tia:tia_LandStatutaireZetel"/>
		</xsl:if>
	</xsl:template>

	<!--
	*********************************************************
	Mode: do-legal-person-same-residence-address
	*********************************************************
	Public: no

	Identity transform: no

	Description: Alternative address of legal person, when residence place is the same as location.

	Input: tia:binnenlandsAdres

	Params: none

	Output: text

	Calls:
	none

	Called by:
	(mode) do-legal-person
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:binnenlandsAdres" mode="do-legal-person-same-residence-address">
		<xsl:value-of select="tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam"/>
		<xsl:text> </xsl:text>
		<xsl:value-of select="tia:BAG_NummerAanduiding/tia:huisnummer"/>
		<xsl:if test="tia:BAG_NummerAanduiding/tia:huisletter
				and normalize-space(tia:BAG_NummerAanduiding/tia:huisletter) != ''">
			<xsl:text> </xsl:text>
			<xsl:value-of select="tia:BAG_NummerAanduiding/tia:huisletter"/>
		</xsl:if>
		<xsl:if test="tia:BAG_NummerAanduiding/tia:huisnummertoevoeging
				and normalize-space(tia:BAG_NummerAanduiding/tia:huisnummertoevoeging) != ''">
			<xsl:text> </xsl:text>
			<xsl:value-of select="tia:BAG_NummerAanduiding/tia:huisnummertoevoeging"/>
		</xsl:if>
		<xsl:text> (postcode </xsl:text>
		<!-- Insert space between numbers and letters of post code -->
		<xsl:value-of select="concat(normalize-space(substring(tia:BAG_NummerAanduiding/tia:postcode, 1, 4)), ' ',
			normalize-space(substring(tia:BAG_NummerAanduiding/tia:postcode, 5)))"/>
		<xsl:text>)</xsl:text>
	</xsl:template>

	<!--
	*********************************************************
	Mode: do-chamber-of-commerce-data
	*********************************************************
	Public: no

	Identity transform: no

	Description: Chamber of commerce data for legal person.

	Input: tia:NHR_Rechtspersoon or tia:vofCvMs

	Params: none

	Output: text

	Calls:
	none

	Called by:
	(mode) do-legal-person
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:NHR_Rechtspersoon | tia:vofCvMs" mode="do-chamber-of-commerce-data">
		<xsl:variable name="kvkOptionalText" select="current()/../../tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_kvk']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
				translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_kvk']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
				translate(normalize-space(current()/../../tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_kvk']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
		<xsl:variable name="gegevensOndertekening" select="../../tia:tia_GegevensOndertekening[translate(tia:soortOndertekening, $upper, $lower) = 'besluit benw']" />
		<xsl:variable name="Datum_DATE" select="substring(string($gegevensOndertekening/tia:datum), 0, 11)"/>
		<xsl:variable name="Datum_STRING">
 			<xsl:if test="$Datum_DATE != ''">
				<xsl:value-of select="kef:convertDateToText($Datum_DATE)"/>
			</xsl:if>
		</xsl:variable>
	
		<xsl:if test="tia:FINummer and normalize-space(tia:FINummer) != ''">
			<xsl:text>, ingeschreven in het handelsregister </xsl:text>
			<xsl:value-of select="$kvkOptionalText"/>
			<xsl:if test="$kvkOptionalText">
				<xsl:text> </xsl:text>
			</xsl:if>
			<xsl:text>onder nummer: </xsl:text>
			<xsl:value-of select="tia:FINummer"/>
		</xsl:if>	
		<xsl:if test="translate(tia:rechtsvormSub, $upper, $lower) = 'publiekrechtelijk rechtspersoon' and normalize-space($gegevensOndertekening/tia:naamGemeente) != ''">
			<xsl:text>, ter uitvoering van het besluit van het College van Burgemeester en Wethouders van de gemeente </xsl:text>
			<xsl:value-of select="$gegevensOndertekening/tia:naamGemeente"/>
			<xsl:text>, de dato </xsl:text>
			<xsl:value-of select="$Datum_STRING"/>
		</xsl:if>
		
	</xsl:template>

</xsl:stylesheet>
