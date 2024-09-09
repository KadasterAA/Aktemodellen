<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="xsl" version="1.0">
<xsl:template match="IMKAD_WoonlocatiePersoon" mode="do-address">
		<xsl:choose>
			<xsl:when test="adres/kadBinnenlandsAdres">
				<xsl:apply-templates select="adres/kadBinnenlandsAdres" mode="do-address"/>
				<xsl:text>, volgens gegevens van de basisregistratie adressen bekend als: </xsl:text>
				<xsl:apply-templates select="adres/binnenlandsAdres" mode="do-address"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="adres/binnenlandsAdres | adres/buitenlandsAdres" mode="do-address"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="binnenlandsAdres" mode="do-address">
		<!-- Insert space between numbers and letters of post code -->
		<xsl:value-of select="concat(normalize-space(substring(BAG_NummerAanduiding/postcode, 1, 4)), ' ',
			normalize-space(substring(BAG_NummerAanduiding/postcode, 5)))"/>
		<xsl:text> </xsl:text>
		<xsl:value-of select="BAG_Woonplaats/woonplaatsNaam"/>
		<xsl:text>, </xsl:text>
		<xsl:value-of select="BAG_OpenbareRuimte/openbareRuimteNaam"/>
		<xsl:text> </xsl:text>
		<xsl:value-of select="BAG_NummerAanduiding/huisnummer"/>
		<xsl:if test="BAG_NummerAanduiding/huisletter
				and normalize-space(BAG_NummerAanduiding/huisletter) != ''">
			<xsl:text> </xsl:text>
			<xsl:value-of select="BAG_NummerAanduiding/huisletter"/>
		</xsl:if>
		<xsl:if test="BAG_NummerAanduiding/huisnummertoevoeging
				and normalize-space(BAG_NummerAanduiding/huisnummertoevoeging) != ''">
			<xsl:text> </xsl:text>
			<xsl:value-of select="BAG_NummerAanduiding/huisnummertoevoeging"/>
		</xsl:if>
	</xsl:template>
		<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="kadBinnenlandsAdres" mode="do-address">
		<!-- Insert space between numbers and letters of post code -->
		<xsl:value-of select="concat(normalize-space(substring(postcode, 1, 4)), ' ',
			normalize-space(substring(postcode, 5)))"/>
		<xsl:text> </xsl:text>
		<xsl:value-of select="woonplaatsNaam"/>
		<xsl:text>, </xsl:text>
		<xsl:value-of select="openbareRuimteNaam"/>
		<xsl:text> </xsl:text>
		<xsl:value-of select="huisNummer"/>
		<xsl:if test="huisLetter and normalize-space(huisLetter) != ''">
			<xsl:text> </xsl:text>
			<xsl:value-of select="huisLetter"/>
		</xsl:if>
		<xsl:if test="huisNummerToevoeging and normalize-space(huisNummerToevoeging) != ''">
			<xsl:text> </xsl:text>
			<xsl:value-of select="huisNummerToevoeging"/>
		</xsl:if>
	</xsl:template>
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="buitenlandsAdres" mode="do-address">
		<xsl:value-of select="woonplaats"/>
		<xsl:text>, </xsl:text>
		<xsl:value-of select="adres"/>
		<xsl:text> </xsl:text>
		<xsl:if test="regio and normalize-space(regio) != ''">
			<xsl:value-of select="regio"/>
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:value-of select="land"/>
	</xsl:template>
</xsl:stylesheet>