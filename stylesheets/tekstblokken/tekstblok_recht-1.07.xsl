<?xml version="1.0" encoding="UTF-8"?>
<!--
*********************************************************
Stylesheet: tekstblok_recht.xsl
Version: 1.07
*********************************************************
Description:
Type of right text block.

Public:
(mode) do-right

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
	Mode: do-right
	*********************************************************
	Public: yes

	Identity transform: no

	Description: Right text block.

	Input: tia:IMKAD_ZakelijkRecht

	Params: none

	Output: text

	Calls:
	none

	Called by:
	(mode) do-deed
	(mode) do-registered-objects-deed-of-transfer
	(mode) do-properties
	(mode) do-bridging-mortgage
	(mode) do-renouncement-of-mortgage-right
	(mode) do-termination-of-mortgage-right
	(name) processRights
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_ZakelijkRecht" mode="do-right">
		<xsl:variable name="aardVerkregen" select="translate(tia:aardVerkregen, $lower, $upper)"/>
		<xsl:variable name="nadarTeOmschrijvenText">
			<xsl:choose>
				<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven']/tia:tekst, $upper, $lower) = 'true'">
					<xsl:text>nader te omschrijven </xsl:text>
				</xsl:when>
				<xsl:otherwise><xsl:text/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:if test="tia:aandeelInRecht/tia:teller and normalize-space(tia:aandeelInRecht/tia:teller) != '' 
					and tia:aandeelInRecht/tia:noemer and normalize-space(tia:aandeelInRecht/tia:noemer) != ''">
			<xsl:text>het </xsl:text>
			<xsl:value-of select="kef:convertNumberToText(string(tia:aandeelInRecht/tia:teller))"/>
			<xsl:text>/</xsl:text>
			<xsl:value-of select="kef:convertOrdinalToText(string(tia:aandeelInRecht/tia:noemer))"/>
			<xsl:text> (</xsl:text>
			<xsl:value-of select="tia:aandeelInRecht/tia:teller"/>
			<xsl:text>/</xsl:text>
			<xsl:value-of select="tia:aandeelInRecht/tia:noemer"/>
			<xsl:text>) onverdeeld aandeel in</xsl:text>
			<xsl:if test="translate($aardVerkregen, $upper, $lower) != 'eigendom' or (translate($aardVerkregen, $upper, $lower) = 'eigendom' and (translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = translate('k_Eigendom', $upper, $lower)]/tia:tekst, $upper, $lower) = 'true' or tia:IMKAD_Appartementsrecht))">
				<xsl:text> </xsl:text>
			</xsl:if>
		</xsl:if>
		<xsl:choose>
			<xsl:when test="translate($aardVerkregen, $upper, $lower) = 'eigendom' and tia:IMKAD_Appartementsrecht"> 
				<xsl:text>het appartementsrecht, rechtgevende op het uitsluitend gebruik van</xsl:text>
			</xsl:when>
			<xsl:when test="translate($aardVerkregen, $upper, $lower) = 'eigendom' and translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom']/tia:tekst, $upper, $lower) = 'true'">
				<xsl:text>het recht van eigendom met betrekking tot</xsl:text>
			</xsl:when>
			<xsl:when test="translate($aardVerkregen, $upper, $lower) = 'eigendom'" />
			<xsl:when test="translate($aardVerkregen, $upper, $lower) = 'eigendom belast met opstal'"> 
				<xsl:text>het recht van eigendom, belast met het </xsl:text>
				<xsl:value-of select="$nadarTeOmschrijvenText"/>
				<xsl:text>recht van opstal, met betrekking tot</xsl:text>
			</xsl:when>
			<xsl:when test="translate($aardVerkregen, $upper, $lower) = 'eigendom belast met opstal nutsvoorzieningen'">
				<xsl:text>het recht van eigendom, belast met het </xsl:text>
				<xsl:value-of select="$nadarTeOmschrijvenText"/>
				<xsl:text>recht van opstal nutsvoorzieningen, met betrekking tot</xsl:text>
			</xsl:when>
			<xsl:when test="translate($aardVerkregen, $upper, $lower) = 'eigendom belast met opstal leidingen'">
				<xsl:text>het recht van eigendom, belast met het </xsl:text>
				<xsl:value-of select="$nadarTeOmschrijvenText"/>
				<xsl:text>recht van opstal leidingen, met betrekking tot</xsl:text>
			</xsl:when>
			<xsl:when test="translate($aardVerkregen, $upper, $lower) = 'eigendom belast met erfpacht'"> 
				<xsl:text>het recht van eigendom, belast met het </xsl:text>
				<xsl:value-of select="$nadarTeOmschrijvenText"/>
				<xsl:text>recht van erfpacht, met betrekking tot</xsl:text>
			</xsl:when> 			 
			<xsl:when test="translate($aardVerkregen, $upper, $lower) = 'eigendom belast met vruchtgebruik'"> 
				<xsl:text>het recht van eigendom, belast met het </xsl:text>
				<xsl:value-of select="$nadarTeOmschrijvenText"/>
				<xsl:text>recht van vruchtgebruik, met betrekking tot</xsl:text>
			</xsl:when>				
			<xsl:when test="translate($aardVerkregen, $upper, $lower) = 'eigendom belast met zakelijk recht als bedoeld in art.5,lid 3,onder b, van de belemmeringenwet privaatrecht'">
				<xsl:text>het recht van eigendom, belast met</xsl:text> 
				<xsl:choose>
       			    <xsl:when test="tia:tia_Aantal_BP_Rechten = 1">
       			    	<xsl:text> het nader te omschrijven zakelijk recht als bedoeld</xsl:text>
       			    </xsl:when>
       			    <xsl:when test="tia:tia_Aantal_BP_Rechten > 1">
						<xsl:text> een </xsl:text>
						<xsl:value-of select="kef:convertNumberToText(tia:tia_Aantal_BP_Rechten)"/>
						<xsl:text>tal nader te omschrijven zakelijke rechten als bedoeld</xsl:text>
					</xsl:when>
       			    <xsl:otherwise><tia:tekst/></xsl:otherwise>
       			</xsl:choose>
				<xsl:text> in artikel 5 lid 3 onder b van de Belemmeringenwet Privaatrecht zoals deze luidde tot een januari negentienhonderdtwee&#x00EB;nnegentig, met betrekking tot</xsl:text>
			</xsl:when> 							 
			<xsl:when test="translate($aardVerkregen, $upper, $lower) = 'opstal'"> 
				<xsl:text>het recht van opstal met betrekking tot</xsl:text>
			</xsl:when>						  
			<xsl:when test="translate($aardVerkregen, $upper, $lower) = 'erfpacht' and tia:IMKAD_Appartementsrecht"> 
				<xsl:text>het recht van erfpacht met betrekking tot het appartementsrecht, rechtgevende op het uitsluitend gebruik van</xsl:text>
			</xsl:when>						   
			<xsl:when test="translate($aardVerkregen, $upper, $lower) = 'erfpacht' or translate($aardVerkregen, $upper, $lower) = 'ondererfpacht'"> 
				<xsl:text>het recht van </xsl:text>
				<xsl:if test="translate($aardVerkregen, $upper, $lower) = 'ondererfpacht'">
					<xsl:text>onder</xsl:text>
				</xsl:if> 
				<xsl:text>erfpacht met betrekking tot</xsl:text>
			</xsl:when>						          
			<xsl:when test="translate($aardVerkregen, $upper, $lower) = 'erfpacht op opstal'"> 
				<xsl:text>het recht van erfpacht, op het recht van opstal, met betrekking tot</xsl:text>
			</xsl:when>			
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>
