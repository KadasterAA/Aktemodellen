<?xml version="1.0" encoding="UTF-8"?>
<!--
*********************************************************
Stylesheet: tekstblok_legitimatie.xsl
Version: 1.01
*********************************************************
Description:
Identity document text block.

Public:
(mode) do-identity-document

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
	Mode: do-identity-document
	*********************************************************
	Public: yes

	Identity transform: no

	Description: Identity document text block.

	Input: tia:tia_Legitimatiebewijs and tia:legitimatiebewijs

	Params: gender - Gender of person, used to determine choice zijn/haar.

	Output: text

	Calls:
	none

	Called by:
	(mode) do-legal-representative
	(mode) do-person-pair-partner
	(mode) do-party-natural-person-common
	(mode) do-person-pair-partner
	(mode) do-manager
	(mode) do-party-natural-person-first-person
	(mode) do-party-natural-person-second-person
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:tia_Legitimatiebewijs | tia:legitimatiebewijs" mode="do-identity-document">
		<xsl:param name="gender"/>
		<xsl:variable name="Datum_DATE" select="substring(string(tia:datumUitgegeven), 0, 11)"/>
		<xsl:variable name="Datum_STRING">
 			<xsl:if test="$Datum_DATE != ''">
				<xsl:value-of select="kef:convertDateToText($Datum_DATE)"/>
			</xsl:if>
		</xsl:variable>
		<xsl:text>zich identificerende met </xsl:text>
		<xsl:choose>
			<xsl:when test="$gender = 'Man'"><xsl:text>zijn </xsl:text></xsl:when>
			<xsl:when test="$gender = 'Vrouw'"><xsl:text>haar </xsl:text></xsl:when>
		</xsl:choose>
		<xsl:value-of select="tia:soort"/>
		<xsl:text>, met kenmerk </xsl:text>
		<xsl:value-of select="tia:kenmerk"/>
		<xsl:text>, uitgegeven te </xsl:text>
		<xsl:value-of select="tia:plaatsUitgegeven"/>
		<xsl:if test="tia:landUitgegeven and string-length(tia:landUitgegeven) != 0">
			<xsl:text>, </xsl:text>
			<xsl:value-of select="tia:landUitgegeven"/>
		</xsl:if>
		<xsl:text>, op </xsl:text>
		<xsl:value-of select="$Datum_STRING"/>
	</xsl:template>

</xsl:stylesheet>
