<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:kef="nl.kadaster.xslt.XslExtensionFunctions" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="kef xsl" version="1.0">
	<xsl:include href="vve-tekstblok_personalia_van_natuurlijk_persoon-1.00.xsl"/>
	<xsl:template match="IMKAD_Persoon" mode="do-natural-person">
		<xsl:apply-templates select="gegevens/GBA_Ingezetene" mode="do-gender-salutation"/>
		<xsl:text> </xsl:text>
		<xsl:apply-templates select="gegevens/GBA_Ingezetene" mode="do-natural-person-personal-data"/>
		<xsl:text>, </xsl:text>
		<xsl:apply-templates select="gegevens/GBA_Ingezetene" mode="do-birth-data"/>
	</xsl:template>
	<xsl:template match="GBA_Ingezetene" mode="do-gender-salutation">
		<xsl:choose>
			<xsl:when test="translate(geslacht/geslachtsaanduiding, $upper, $lower) = 'man'">
				<xsl:text>de heer</xsl:text>
			</xsl:when>
			<xsl:when test="translate(geslacht/geslachtsaanduiding, $upper, $lower) = 'vrouw'">
				<xsl:text>mevrouw</xsl:text>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="GBA_Ingezetene" mode="do-birth-data">
		<xsl:variable name="Datum_DATE" select="substring(string(geboorte/geboortedatum), 0, 11)"/>
		<xsl:variable name="Datum_STRING">
			<xsl:if test="$Datum_DATE != ''">
				<xsl:value-of select="kef:convertDateToText($Datum_DATE)"/>
			</xsl:if>
		</xsl:variable>
		<xsl:text>geboren te </xsl:text>
		<xsl:value-of select="geboorte/geboorteplaatsOmschrijving"/>
		<xsl:choose>
			<xsl:when test="geboorte/geboorteland">
				<xsl:text>, </xsl:text>
				<xsl:value-of select="geboorte/geboorteland"/>
			</xsl:when>
		</xsl:choose>
		<xsl:text> op </xsl:text>
		<xsl:value-of select="$Datum_STRING"/>
	</xsl:template>
</xsl:stylesheet>