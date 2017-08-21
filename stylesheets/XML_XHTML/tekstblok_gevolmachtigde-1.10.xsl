<?xml version="1.0" encoding="UTF-8"?>
<!--
*********************************************************
Stylesheet: tekstblok_gevolmachtigde.xsl
Version: 1.10
*********************************************************
Description:
Legal representative text block. 

Public:
(mode) do-legal-representative

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
	Mode: do-legal-representative
	*********************************************************
	Public: yes

	Identity transform: no

	Description: Legal representative text block.

	Input: tia:Gevolmachtigde

	Params: none

	Output: text

	Calls:
	(mode) do-natural-person
	(mode) do-address
	(mode) do-identity-document

	Called by:
	(mode) do-parties
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:Gevolmachtigde" mode="do-legal-representative">
		<xsl:apply-templates select="." mode="do-natural-person"/>
		<xsl:choose>
			<xsl:when test="tia:gegevens/tia:adresPersoon/tia:binnenlandsAdres or tia:gegevens/tia:adresPersoon/tia:buitenlandsAdres">
				<xsl:variable name="maritalStatus" select="tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_burgerlijkestaatpersoon']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
					translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_burgerlijkestaatpersoon']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
					translate(normalize-space(current()/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_burgerlijkestaatpersoon']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
				<xsl:text>, wonende te </xsl:text>
				<xsl:apply-templates select="tia:gegevens" mode="do-address" />
				<xsl:text>, </xsl:text>
				<xsl:if test="tia:gegevens/tia:legitimatiebewijs">
					<xsl:apply-templates select="tia:gegevens/tia:legitimatiebewijs" mode="do-identity-document">
						<xsl:with-param name="gender" select="tia:gegevens/tia:persoonGegevens/tia:geslacht/tia:geslachtsaanduiding"/>
					</xsl:apply-templates>	
					<xsl:text>, </xsl:text>
				</xsl:if>
				<xsl:value-of select="$maritalStatus" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>, werkzaam ten kantore van mij, notaris,</xsl:text>
				<xsl:if test="tia:gegevens/tia:adresKantoor">
					<xsl:text> kantoorhoudende te </xsl:text>
					<!-- Insert space between numbers and letters of post code -->
					<xsl:value-of select="concat(normalize-space(substring(tia:gegevens/tia:adresKantoor/tia:BAG_NummerAanduiding/tia:postcode, 1, 4)), ' ',
						normalize-space(substring(tia:gegevens/tia:adresKantoor/tia:BAG_NummerAanduiding/tia:postcode, 5)))"/>
					<xsl:text> </xsl:text>
					<xsl:value-of select="tia:gegevens/tia:adresKantoor/tia:BAG_Woonplaats/tia:woonplaatsNaam"/>
					<xsl:text>, </xsl:text>
					<xsl:value-of select="tia:gegevens/tia:adresKantoor/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam"/>
					<xsl:text> </xsl:text>
					<xsl:value-of select="tia:gegevens/tia:adresKantoor/tia:BAG_NummerAanduiding/tia:huisnummer"/>
					<xsl:if test="tia:gegevens/tia:adresKantoor/tia:BAG_NummerAanduiding/tia:huisletter
							and normalize-space(tia:gegevens/tia:adresKantoor/tia:BAG_NummerAanduiding/tia:huisletter) != ''">
						<xsl:text> </xsl:text>
						<xsl:value-of select="tia:gegevens/tia:adresKantoor/tia:BAG_NummerAanduiding/tia:huisletter"/>
					</xsl:if>
					<xsl:if test="tia:gegevens/tia:adresKantoor/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging
							and normalize-space(tia:gegevens/tia:adresKantoor/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging) != ''">
						<xsl:text> </xsl:text>
						<xsl:value-of select="tia:gegevens/tia:adresKantoor/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging"/>
					</xsl:if>
					<xsl:text>,</xsl:text>
				</xsl:if>
				<xsl:text> te dezen handelend</xsl:text>
				<xsl:if test="translate(tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verantwoordelijkheidnotaris']/tia:tekst, $upper, $lower) = 'true'">
					<xsl:text> </xsl:text>
					<xsl:value-of select="normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verantwoordelijkheidnotaris']/tia:tekst)"/>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:text> als </xsl:text>
		<xsl:value-of select="tia:gegevens/tia:bevoegdheid"/>
		<xsl:text> gevolmachtigde van:</xsl:text>
	</xsl:template>

</xsl:stylesheet>
