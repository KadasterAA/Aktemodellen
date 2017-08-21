<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:tia="http://www.kadaster.nl/schemas/KIK/TIA_Algemeen"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:kef="nl.kadaster.xslt.XslExtensionFunctions"
	exclude-result-prefixes="tia xsl kef"
    version="1.0">

	<!-- 
		*************************************************************************
		Template for signer block (ondertekenaar)
		*************************************************************************
	-->
	<xsl:template name="ondertekenaar">
		<xsl:param name="aangebodenstuk"/>
		<xsl:param name="aardondertekenaar"/>
		<xsl:param name="type"/>

		<xsl:if test="$aangebodenstuk/tia:tia_OmschrijvingKenmerk = ''">
			<xsl:choose>
				<xsl:when test="translate($type,$upper,$lower) = 'dot' or translate($type,$upper,$lower) = 'dotnn'">
					<a name="hyp4.header" class="location">&#160;</a>
				</xsl:when>
				<xsl:when test="translate($type,$upper,$lower) = 'dom'">
					<a name="hyp3.header" class="location">&#160;</a>
				</xsl:when>
				<xsl:when test="translate($type,$upper,$lower) = 'doc'">
					<a name="mortgagecancellationdeed.header" class="location">&#160;</a>
				</xsl:when>
			</xsl:choose>
		</xsl:if>
		<p>
			<xsl:variable name="Datum_DATE" select="substring(string($aangebodenstuk/tia:tia_DatumOndertekening),0,11)"/>
			<xsl:variable name="Datum_STRING">
				<xsl:choose>
					<xsl:when test="$Datum_DATE != ''"><xsl:value-of select="kef:convertDateToText($Datum_DATE)"/></xsl:when>
				</xsl:choose>
			</xsl:variable>
			<!-- HEDEN (Date) -->
			<xsl:variable name="txt" select="$aangebodenstuk/tia:tia_TekstKeuze[translate(tia:tagNaam,$upper,$lower) = 'k_dagaanduiding']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
				translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam,$upper,$lower) = 'k_dagaanduiding']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
				translate(normalize-space($aangebodenstuk/tia:tia_TekstKeuze[translate(tia:tagNaam,$upper,$lower) = 'k_dagaanduiding']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
			<xsl:value-of select="$txt"/>
			<xsl:if test="translate($txt,$upper,$lower) != 'op' or translate($type,$upper,$lower) = 'dotnn'"><xsl:text>,</xsl:text></xsl:if>
			<xsl:text> </xsl:text>
			<xsl:value-of select="$Datum_STRING"/>
			<xsl:text>, </xsl:text>
			<!-- END HEDEN (Date) -->
			<xsl:choose>
				<xsl:when test="translate($type,$upper,$lower) = 'doc'"><xsl:text>is voor mij, </xsl:text></xsl:when>
				<xsl:otherwise><xsl:text>verschenen voor mij, </xsl:text></xsl:otherwise>
			</xsl:choose>
			<xsl:call-template name="person_data">
				<xsl:with-param name="person" select="$aangebodenstuk/tia:ondertekenaar/tia:tia_Ondertekenaar"/>
				<xsl:with-param name="include-birth-data" select="'false'"/>
			</xsl:call-template>
			<xsl:if test="$aangebodenstuk/tia:ondertekenaar/tia:tia_Aard = $aardondertekenaar">
				<!-- Waarnamer notaris -->
				<xsl:text>, hierna te noemen: 'notaris', als waarnemer van </xsl:text>
				<xsl:call-template name="person_data">
					<xsl:with-param name="person" select="$aangebodenstuk/tia:ondertekenaar/tia:tia_WaarnemerVoor"/>
					<xsl:with-param name="include-birth-data" select="'false'"/>
				</xsl:call-template>
			</xsl:if>
			<xsl:text>, notaris </xsl:text>
			<!-- keuzetekst netwerk notarissen -->
			<xsl:choose>
				<xsl:when test="translate($type,$upper,$lower) = 'dotnn'">
					<xsl:choose>
						<xsl:when test="$aangebodenstuk/tia:tia_TekstKeuze[translate(tia:tagNaam,$upper,$lower) = 'k_vestigingnotaris']">
							<xsl:value-of select="$aangebodenstuk/tia:tia_TekstKeuze[translate(tia:tagNaam,$upper,$lower) = 'k_vestigingnotaris']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
								translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam,$upper,$lower) = 'k_vestigingnotaris']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
								translate(normalize-space($aangebodenstuk/tia:tia_TekstKeuze[translate(tia:tagNaam,$upper,$lower) = 'k_vestigingnotaris']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
						</xsl:when>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="$aangebodenstuk/tia:tia_TekstKeuze[translate(tia:tagNaam,$upper,$lower) = 'k_vestigingnotaris']">
							<xsl:value-of select="$aangebodenstuk/tia:tia_TekstKeuze[translate(tia:tagNaam,$upper,$lower) = 'k_vestigingnotaris']/tia:tekst"/>
						</xsl:when>
						<xsl:otherwise><xsl:text>te</xsl:text></xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text> </xsl:text>
			<xsl:value-of select="$aangebodenstuk/tia:ondertekenaar/tia:standplaats"/>
			<xsl:if test="translate($type,$upper,$lower) = 'doc'">
				<xsl:text> verschenen</xsl:text>
			</xsl:if>
			<xsl:text>:</xsl:text>
		</p>
	</xsl:template>

</xsl:stylesheet>
