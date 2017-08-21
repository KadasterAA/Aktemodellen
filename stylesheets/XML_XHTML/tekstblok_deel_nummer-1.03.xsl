<?xml version="1.0" encoding="UTF-8"?>
<!--
*********************************************************
Stylesheet: tekstblok_deel_nummer.xsl
Version: 1.03
*********************************************************
Description:
Part and number text block.

Public:
(mode) do-part-and-number

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
	Mode: do-part-and-number
	*********************************************************
	Public: yes

	Identity transform: no

	Description: Part and number text block.

	Input: tia:algemeneVoorwaarden, tia:doorTeHalenStuk, tia:vervallenInschrijving, tia:stukTeHandhavenBeperking, tia:gegevensInschrijving, tia:deelEnNummer

	Output: text

	Calls:
	none

	Called by:
	(mode) do-deed
	(mode) do-replacement-area
	(mode) do-continue-document
	(mode) do-purchase-registration
	(mode) do-document-cancellation
	(name) additionCancellationOfRestrictionTextBlock
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:algemeneVoorwaarden | tia:doorTeHalenStuk | tia:vervallenInschrijving | tia:stukTeHandhavenBeperking | tia:gegevensInschrijving | tia:deelEnNummer" mode="do-part-and-number">
		<xsl:value-of select="tia:soortRegister"/>
		<xsl:text> </xsl:text>
		<xsl:if test="tia:reeks != ''">
		    <xsl:text>te </xsl:text>
		    <xsl:value-of select="tia:reeks"/>
		    <xsl:text> </xsl:text>
		</xsl:if>
		<xsl:text>in deel </xsl:text>
		<xsl:value-of select="tia:deel"/>
		<xsl:text> en nummer </xsl:text>
		<xsl:value-of select="tia:nummer"/>
	</xsl:template>

</xsl:stylesheet>
