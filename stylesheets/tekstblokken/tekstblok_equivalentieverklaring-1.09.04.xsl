<?xml version="1.0" encoding="UTF-8"?>
<!--
*********************************************************
Stylesheet: tekstblok_equivalentieverklaring.xsl
Version: 1.09.04
*********************************************************
Description:
Statement of equivalence text block.

Public:
(mode) do-statement-of-equivalence

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
	Mode: do-statement-of-equivalence
	*********************************************************
	Public: yes

	Identity transform: no

	Description: Statement of equivalence text block.

	Input: tia:IMKAD_AangebodenStuk

	Params: none

	Output: XHTML structure

	Calls:
	(mode) do-natural-person-personal-data

	Called by:
	(mode) do-deed
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_AangebodenStuk" mode="do-statement-of-equivalence">
		<xsl:param name="includeTime" select="'true'"/>

		<xsl:variable name="Signiture_Time_TIME" select="substring(string(tia:tia_TijdOndertekening), 1, 5)"/>
		<xsl:variable name="Signiture_Time_STRING">
			<xsl:if test="normalize-space($Signiture_Time_TIME) != ''">
				<xsl:value-of select="kef:convertTimeToText($Signiture_Time_TIME)"/>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="declarerPlace" select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verklaarderplaatsaanduiding']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verklaarderplaatsaanduiding']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verklaarderplaatsaanduiding']/tia:tekst), $upper, $lower)]), $upper, $lower)]" />
		<xsl:variable name="time" select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_tijdondertekening']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_tijdondertekening']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_tijdondertekening']/tia:tekst), $upper, $lower)]), $upper, $lower)]" />
		<xsl:variable name="verklaringWvg">
			<xsl:choose>
				<xsl:when test="tia:tia_TekstKeuze[tia:tagNaam = 'k_VerklaringWvg']/tia:tekst = 'false'">
					<xsl:text>1</xsl:text>
				</xsl:when>
				<xsl:when test="tia:tia_TekstKeuze[tia:tagNaam = 'k_VerklaringWvg']/tia:tekst = 'true'">
					<xsl:text>2</xsl:text>
				</xsl:when>
				<xsl:otherwise><xsl:text/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<p>
			<xsl:text>Ondergetekende, </xsl:text>
			<xsl:apply-templates select="tia:tia_Verklaarder/tia:verklaarder" mode="do-natural-person-personal-data" />
			<xsl:if test="tia:tia_Verklaarder/tia:waarnemerVoor">
				<!-- Waarnamer notaris -->
				<xsl:text>, hierna te noemen: notaris als waarnemer van </xsl:text>
				<xsl:apply-templates select="tia:tia_Verklaarder/tia:waarnemerVoor" mode="do-natural-person-personal-data" />
			</xsl:if>
			<xsl:text>, notaris </xsl:text>
			<xsl:choose>
				<xsl:when test="$declarerPlace = '1'">
					<xsl:text>in de gemeente </xsl:text>
					<xsl:value-of select="tia:tia_Verklaarder/tia:gemeente"/>
					<xsl:text> kantoorhoudende te</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$declarerPlace"/>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text> </xsl:text>
			<xsl:value-of select="tia:tia_Verklaarder/tia:standplaats"/>
			<xsl:text>, verklaart</xsl:text>
			<xsl:choose>
				<xsl:when test="((translate($includeTime, $upper, $lower) = 'false' or not(tia:tia_TijdOndertekening) or normalize-space(tia:tia_TijdOndertekening) = '' or normalize-space($time) = '') and normalize-space($verklaringWvg) = '')">
					<xsl:text> dat dit afschrift</xsl:text>
					<xsl:if test="tia:tia_DepotnummerTekening and normalize-space(tia:tia_DepotnummerTekening) != ''">
						<xsl:text> samen met de tekening die in bewaring is genomen met depotnummer </xsl:text>
						<xsl:value-of select="tia:tia_DepotnummerTekening"/>
					</xsl:if>
					<xsl:text> inhoudelijk een volledig en juiste weergave is van de inhoud van het stuk waarvan het een afschrift is;</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>:</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</p>
		<xsl:if test="(translate($includeTime, $upper, $lower) = 'true' and tia:tia_TijdOndertekening and normalize-space(tia:tia_TijdOndertekening) != '' and normalize-space($time) != '') or normalize-space($verklaringWvg) != ''">
			<table cellpadding="0" cellspacing="0">
				<tbody>
					<tr>
						<td class="number" valign="top">
							<xsl:text>-</xsl:text>
						</td>
						<td>
							<xsl:text>dat dit afschrift</xsl:text>
							<xsl:if test="tia:tia_DepotnummerTekening and normalize-space(tia:tia_DepotnummerTekening) != ''">
								<xsl:text> samen met de tekening die in bewaring is genomen met depotnummer </xsl:text>
								<xsl:value-of select="tia:tia_DepotnummerTekening"/>
							</xsl:if>
							<xsl:text> inhoudelijk een volledig en juiste weergave is van de inhoud van het stuk waarvan het een afschrift is;</xsl:text>
						</td>
					</tr>
					<xsl:if test="translate($includeTime, $upper, $lower) = 'true' and tia:tia_TijdOndertekening and normalize-space(tia:tia_TijdOndertekening) != '' and normalize-space($time) != ''">
						<tr>
							<td class="number" valign="top">
								<xsl:text>-</xsl:text>
							</td>
							<td>
								<xsl:text>dat het stuk waarvan dit stuk een afschrift is om </xsl:text>
								<xsl:value-of select="concat($Signiture_Time_STRING, ' (' , $Signiture_Time_TIME, ' uur) ')"/>
								<xsl:text> is ondertekend</xsl:text>
				    			<xsl:choose>
				    				<xsl:when test="$verklaringWvg != ''"><xsl:text>;</xsl:text></xsl:when>
				    				<xsl:otherwise><xsl:text>.</xsl:text></xsl:otherwise>
				    			</xsl:choose>
							</td>
						</tr>
					</xsl:if>
					<xsl:if test="$verklaringWvg != ''">
						<tr>
							<td class="number" valign="top">
								<xsl:text>-</xsl:text>
							</td>
							<td>
								<xsl:value-of select="normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verklaringwvg']/tia:tekst[position() = $verklaringWvg])"/>
							</td>
						</tr>
					</xsl:if>
				</tbody>
			</table>
	    </xsl:if>
	</xsl:template>

</xsl:stylesheet>
