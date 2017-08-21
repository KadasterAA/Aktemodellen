<?xml version="1.0" encoding="UTF-8"?>
<!--
*********************************************************
Stylesheet: tekstblok_titel_hypotheekakten.xsl
Version: 1.01
*********************************************************
Description:
Mortgage deed title text block.
Also defines global variable $documentTitle used in generiek.xsl style sheet.

Public:
(mode) do-mortgage-deed-title

Private:
none
-->
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
	xmlns:tia="http://www.kadaster.nl/schemas/KIK/TIA_Algemeen"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	exclude-result-prefixes="tia xsl"
	version="1.0">

	<xsl:variable name="root" select="tia:Bericht_TIA_Stuk"/>
	<xsl:variable name="documentTitle">
		<xsl:choose>
			<xsl:when test="tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_titelhypotheek']/tia:tekst and
							normalize-space(tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_titelhypotheek']/tia:tekst) != ''">
				<xsl:choose>
					<!-- If text choice is a non-zero number, take value from $keuzeteksten on the position indicated by numbered value and replace text within {...} with the address of the first registered object-->
					<xsl:when test="number(tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_titelhypotheek']/tia:tekst)">
						<xsl:choose>
							<xsl:when test="tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = ''][1]/tia:IMKAD_ZakelijkRecht[1]/*/tia:IMKAD_OZLocatie">
								<xsl:value-of select="normalize-space(substring-before($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_titelhypotheek']/tia:tekst[number(tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_titelhypotheek']/tia:tekst)], '{street name house number huisletter toevoeging}'))"/>
								<xsl:text> </xsl:text>
								<xsl:value-of select="tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = ''][1]/tia:IMKAD_ZakelijkRecht[1]/*/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam"/>
								<xsl:if test="tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = ''][1]/tia:IMKAD_ZakelijkRecht[1]/*/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer
										and normalize-space(tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = ''][1]/tia:IMKAD_ZakelijkRecht[1]/*/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer) != ''">
									<xsl:text> </xsl:text>
									<xsl:value-of select="tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = ''][1]/tia:IMKAD_ZakelijkRecht[1]/*/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer"/>
								</xsl:if>
								<xsl:if test="tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = ''][1]/tia:IMKAD_ZakelijkRecht[1]/*/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter
										and normalize-space(tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = ''][1]/tia:IMKAD_ZakelijkRecht[1]/*/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter) != ''">
									<xsl:text> </xsl:text>
									<xsl:value-of select="tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = ''][1]/tia:IMKAD_ZakelijkRecht[1]/*/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter"/>
								</xsl:if>
								<xsl:if test="tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = ''][1]/tia:IMKAD_ZakelijkRecht[1]/*/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging
										and normalize-space(tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = ''][1]/tia:IMKAD_ZakelijkRecht[1]/*/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging) != ''">
									<xsl:text> </xsl:text>
									<xsl:value-of select="tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = ''][1]/tia:IMKAD_ZakelijkRecht[1]/*/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging"/>
								</xsl:if>
								<xsl:text> </xsl:text>
								<xsl:value-of select="normalize-space(substring-before(substring-after($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_titelhypotheek']/tia:tekst[number(tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_titelhypotheek']/tia:tekst)], '{street name house number huisletter toevoeging}'), '{town}'))"/>
								<xsl:text> </xsl:text>
								<xsl:value-of select="tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = ''][1]/tia:IMKAD_ZakelijkRecht[1]/*/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam"/>
								<xsl:value-of select="substring-after($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_titelhypotheek']/tia:tekst[number(tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_titelhypotheek']/tia:tekst)], '{town}')"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="normalize-space(substring-before($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_titelhypotheek']/tia:tekst[number(tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_titelhypotheek']/tia:tekst)], '{street name house number huisletter toevoeging}'))"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_titelhypotheek']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
							translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_titelhypotheek']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
							translate(normalize-space($root/tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_titelhypotheek']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise><xsl:text>-</xsl:text></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<!--
	*********************************************************
	Mode: do-mortgage-deed-title
	*********************************************************
	Public: yes

	Identity transform: no

	Description: Mortgage deed title text block.

	Input: tia:IMKAD_AangebodenStuk

	Output: XHTML structure.

	Calls:
	none

	Called by:
	(mode) do-deed
	(mode) do-header (from style sheet hypotheek_abn_amro_generiek.xsl)
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_AangebodenStuk" mode="do-mortgage-deed-title">
		<!-- Document title -->
		<xsl:if test="normalize-space($documentTitle) != '' and $documentTitle != '-'">
			<p style="text-align:center" title="without_dashes"><xsl:value-of select="$documentTitle"/></p>
			<!-- Empty line after title -->
			<p title="without_dashes"><br/></p>
		</xsl:if>
		<!-- Offertenummer -->
		<xsl:if test="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_offertenummer']/tia:tekst
				and normalize-space(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_offertenummer']/tia:tekst) != ''">
			<p title="without_dashes">
				<xsl:text>Offertenummer: </xsl:text>
				<xsl:value-of select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_offertenummer']/tia:tekst"/>
			</p>
		</xsl:if>
		<!-- Kenmerk -->
		<xsl:if test="tia:tia_OmschrijvingKenmerk
				and normalize-space(tia:tia_OmschrijvingKenmerk) != ''">
			<p title="without_dashes">
				<xsl:text>Kenmerk: </xsl:text>
				<xsl:value-of select="tia:tia_OmschrijvingKenmerk"/>
			</p>
		</xsl:if>
		<!-- Zaaknummer -->
		<xsl:if test="tia:tia_OmschrijvingZaak
				and normalize-space(tia:tia_OmschrijvingZaak) != ''">
			<p title="without_dashes">
				<xsl:text>Zaaknummer: </xsl:text>
				<xsl:value-of select="tia:tia_OmschrijvingZaak"/>
			</p>
		</xsl:if>
		<xsl:if test="(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_offertenummer']/tia:tekst
					and normalize-space(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_offertenummer']/tia:tekst) != '')
				or (tia:tia_OmschrijvingKenmerk
					and normalize-space(tia:tia_OmschrijvingKenmerk) != '')
				or (tia:tia_OmschrijvingZaak
					and normalize-space(tia:tia_OmschrijvingZaak) != '')">
			<!-- Empty line after Offertenummer/Kenmerk/Zaaknummer -->
			<p title="without_dashes"><br/></p>
		</xsl:if>
	</xsl:template>

</xsl:stylesheet>
