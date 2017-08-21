<?xml version="1.0" encoding="UTF-8"?>
<!--
*********************************************************
Stylesheet: tekstblok_woonadres.xsl
Version: 1.05
*********************************************************
Description:
Address text block.

Public:
(mode) do-address

Private:
none
-->
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
	xmlns:tia="http://www.kadaster.nl/schemas/KIK/TIA_Algemeen"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	exclude-result-prefixes="tia xsl"
	version="1.0">

	<!--
	*********************************************************
	Mode: do-address
	*********************************************************
	Public: yes

	Identity transform: no

	Description: Address text block.

	Input: tia:adresKantoor, tia:IMKAD_WoonlocatiePersoon, tia:toekomstigAdres, tia:gegevens, tia:binnenlandsAdres or tia:buitenlandsAdres

	Params: none

	Output: text

	Calls:
	none

	Called by:
	(mode) do-legal-representative
	(mode) do-legal-person
	(mode) do-party-natural-person
	(mode) do-party-natural-person-pair
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_WoonlocatiePersoon | tia:toekomstigAdres" mode="do-address">
		<xsl:choose>
			<xsl:when test="tia:adres/tia:kadBinnenlandsAdres">
				<xsl:apply-templates select="tia:adres/tia:kadBinnenlandsAdres" mode="do-address"/>
				<xsl:text>, volgens gegevens van de basisregistratie adressen bekend als: </xsl:text>
				<xsl:apply-templates select="tia:adres/tia:binnenlandsAdres" mode="do-address"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="tia:adres/tia:binnenlandsAdres | tia:adres/tia:buitenlandsAdres" mode="do-address"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="tia:gegevens" mode="do-address">
		<xsl:choose>
			<xsl:when test="tia:adresPersoon/tia:kadBinnenlandsAdres">
				<xsl:apply-templates select="tia:adresPersoon/tia:kadBinnenlandsAdres" mode="do-address"/>
				<xsl:text>, volgens gegevens van de basisregistratie adressen bekend als: </xsl:text>
				<xsl:apply-templates select="tia:adresPersoon/tia:binnenlandsAdres" mode="do-address"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="tia:adresPersoon/tia:binnenlandsAdres | tia:adresPersoon/tia:buitenlandsAdres" mode="do-address"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:adresKantoor | tia:binnenlandsAdres" mode="do-address">
		<!-- Insert space between numbers and letters of post code -->
		<xsl:value-of select="concat(normalize-space(substring(tia:BAG_NummerAanduiding/tia:postcode, 1, 4)), ' ',
			normalize-space(substring(tia:BAG_NummerAanduiding/tia:postcode, 5)))"/>
		<xsl:text> </xsl:text>
		<xsl:value-of select="tia:BAG_Woonplaats/tia:woonplaatsNaam"/>
		<xsl:text>, </xsl:text>
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
	</xsl:template>

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:kadBinnenlandsAdres" mode="do-address">
		<!-- Insert space between numbers and letters of post code -->
		<xsl:value-of select="concat(normalize-space(substring(tia:postcode, 1, 4)), ' ',
			normalize-space(substring(tia:postcode, 5)))"/>
		<xsl:text> </xsl:text>
		<xsl:value-of select="tia:woonplaatsNaam"/>
		<xsl:text>, </xsl:text>
		<xsl:value-of select="tia:openbareRuimteNaam"/>
		<xsl:text> </xsl:text>
		<xsl:value-of select="tia:huisNummer"/>
		<xsl:if test="tia:huisLetter and normalize-space(tia:huisLetter) != ''">
			<xsl:text> </xsl:text>
			<xsl:value-of select="tia:huisLetter"/>
		</xsl:if>
		<xsl:if test="tia:huisNummerToevoeging and normalize-space(tia:huisNummerToevoeging) != ''">
			<xsl:text> </xsl:text>
			<xsl:value-of select="tia:huisNummerToevoeging"/>
		</xsl:if>
	</xsl:template>

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:buitenlandsAdres" mode="do-address">
		<xsl:value-of select="tia:woonplaats"/>
		<xsl:text>, </xsl:text>
		<xsl:value-of select="tia:adres"/>
		<xsl:text> </xsl:text>
		<xsl:if test="tia:regio and normalize-space(tia:regio) != ''">
			<xsl:value-of select="tia:regio"/>
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:value-of select="tia:land"/>
	</xsl:template>

</xsl:stylesheet>
