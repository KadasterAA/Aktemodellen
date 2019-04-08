<?xml version="1.0" encoding="UTF-8"?>
<!--
*********************************************************
Stylesheet: tekstblok_legitimatie.xsl
Version: 2.00 (AA-2850)
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
		<xsl:variable name="DatumGeldigTot_DATE" select="substring(string(tia:datumGeldigTot), 0, 11)"/>
		<xsl:variable name="DatumGeldigTot_STRING">
 			<xsl:if test="$DatumGeldigTot_DATE != ''">
				<xsl:value-of select="kef:convertDateToText($DatumGeldigTot_DATE)"/>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="plaatsUitgegeven">
			<xsl:choose>
				<xsl:when test="string-length(tia:plaatsUitgegeven) != 0">
					<xsl:value-of select="true()"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="false()"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="landUitgegeven">
			<xsl:choose>
				<xsl:when test="string-length(tia:landUitgegeven) != 0">
					<xsl:value-of select="true()"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="false()"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="datumUitgegeven">
			<xsl:choose>
				<xsl:when test="string-length(tia:datumUitgegeven) != 0">
					<xsl:value-of select="true()"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="false()"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="datumGeldigTot">
			<xsl:choose>
				<xsl:when test="string-length(tia:datumGeldigTot) != 0">
					<xsl:value-of select="true()"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="false()"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="instantieUitgegeven">
			<xsl:choose>
				<xsl:when test="string-length(tia:instantieUitgegeven) != 0">
					<xsl:value-of select="true()"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="false()"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:text>zich identificerende met </xsl:text>
		<xsl:choose>
			<xsl:when test="$gender = 'Man'"><xsl:text>zijn </xsl:text></xsl:when>
			<xsl:when test="$gender = 'Vrouw'"><xsl:text>haar </xsl:text></xsl:when>
		</xsl:choose>
		<xsl:value-of select="tia:soort"/>
		<xsl:text>, met kenmerk </xsl:text>
		<xsl:value-of select="tia:kenmerk"/>
		<xsl:if test="$instantieUitgegeven = 'true' or $plaatsUitgegeven = 'true' or $landUitgegeven = 'true' or $datumUitgegeven = 'true' or $datumGeldigTot = 'true'">
			<xsl:text>,</xsl:text>
		</xsl:if>
		<xsl:if test="$instantieUitgegeven = 'true' or $plaatsUitgegeven = 'true' or $landUitgegeven = 'true' or $datumUitgegeven = 'true'">
			<xsl:text> uitgegeven</xsl:text>
		</xsl:if>	
		<xsl:if test="$instantieUitgegeven = 'true'">
			<xsl:text> door </xsl:text>
			<xsl:value-of select="tia:instantieUitgegeven"/>
		</xsl:if>	
		<xsl:if test="$plaatsUitgegeven = 'true' or $landUitgegeven = 'true'">
			<xsl:text> te </xsl:text>
		</xsl:if>
		<xsl:if test="$plaatsUitgegeven = 'true'">
			<xsl:value-of select="tia:plaatsUitgegeven"/>
			<xsl:if test="$landUitgegeven ='true'">
				<xsl:text>, </xsl:text>
			</xsl:if>
		</xsl:if>
		<xsl:if test="$landUitgegeven = 'true'">
			<xsl:value-of select="tia:landUitgegeven"/>
		</xsl:if>
		<xsl:if test="$datumUitgegeven = 'true'">
			<xsl:text> op </xsl:text>
			<xsl:value-of select="$Datum_STRING"/>
		</xsl:if>
		<xsl:if test="$datumGeldigTot = 'true'">
			<xsl:text> geldig tot </xsl:text>
			<xsl:value-of select="$DatumGeldigTot_STRING"/>
		</xsl:if>
	</xsl:template>

</xsl:stylesheet>
