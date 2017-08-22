<?xml version="1.0" encoding="UTF-8"?>
<!--
*********************************************************
Stylesheet: hypotheek_particulier.xsl
Version: 1.14
*********************************************************
Description:
Private mortgage deed.

Public:
(mode) do-deed

Private:
(mode) do-parties
(mode) do-party-person
(mode) do-contract-of-sale
(mode) do-mortgage-provision
(mode) do-natural-person-part
(mode) do-gender-salutation-part
(mode) do-person-data-part
(mode) do-birth-data-part
(mode) do-address-part
-->
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
	xmlns:tia="http://www.kadaster.nl/schemas/KIK/TIA_Algemeen"
	xmlns:xlink="http://www.w3.org/1999/xlink"
	xmlns:part="http://www.kadaster.nl/schemas/KIK/ParticuliereHypotheekakte/v20110701"
	xmlns:kef="nl.kadaster.xslt.XslExtensionFunctions"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	exclude-result-prefixes="tia part kef xsl xlink"
	version="1.0">

	<xsl:include href="generiek-1.08.xsl"/>
	<xsl:include href="tekstblok_aanhef-1.05.xsl"/>
	<xsl:include href="tekstblok_equivalentieverklaring-1.09.02.xsl"/>
	<xsl:include href="tekstblok_gevolmachtigde-1.09.xsl"/>
	<xsl:include href="tekstblok_legitimatie-1.01.xsl"/>
	<xsl:include href="tekstblok_personalia_van_natuurlijk_persoon-1.05.xsl"/>
	<xsl:include href="tekstblok_natuurlijk_persoon-1.09.xsl"/>
	<xsl:include href="tekstblok_overbruggingshypotheek-1.05.xsl"/>
	<xsl:include href="tekstblok_partij_natuurlijk_persoon-1.10.xsl"/>
	<xsl:include href="tekstblok_partij_niet_natuurlijk_persoon-1.10.xsl"/>
	<xsl:include href="tekstblok_partijnamen_in_hypotheekakten-1.03.xsl"/>
	<xsl:include href="tekstblok_recht-1.05.xsl"/>
	<xsl:include href="tekstblok_rechtspersoon-1.07.xsl"/>
	<xsl:include href="tekstblok_registergoed-1.14.xsl"/>
	<xsl:include href="tekstblok_woonadres-1.04.xsl"/>
	<xsl:include href="tweededeel-1.05.xsl"/>

	<!-- Particuliere Hypotheek specific global variables -->
	<xsl:variable name="keuzeteksten" select="document('keuzeteksten_hypotheek_particulier-1.05.xml')"/>
	<xsl:variable name="documentTitle">
		<xsl:choose>
			<xsl:when test="tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_titelhypotheek']/tia:tekst and
							normalize-space(tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_titelhypotheek']/tia:tekst) != ''">
				<xsl:choose>
					<xsl:when test="translate(tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_titelhypotheek']/tia:tekst, $upper, $lower) = 'hypotheek levering adres'">
						<xsl:choose>
							<xsl:when test="tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = ''][1]/tia:IMKAD_ZakelijkRecht[1]/*/tia:IMKAD_OZLocatie">
								<xsl:text>Hypotheek LEVERING </xsl:text>
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
								<xsl:text> te </xsl:text>
								<xsl:value-of select="tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = ''][1]/tia:IMKAD_ZakelijkRecht[1]/*/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam"/>
							</xsl:when>
							<xsl:when test="tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = ''][1]/tia:IMKAD_ZakelijkRecht">
								<xsl:text>Hypotheek LEVERING</xsl:text>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_titelhypotheek']/tia:tekst"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_titelhypotheek']/tia:tekst" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise><xsl:text>Particuliere Hypotheek</xsl:text></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="partyOneName">
		<xsl:choose>
			<xsl:when test="translate(tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:Partij[1]/tia:aanduidingPartij, $upper, $lower) = 'de schuldenaar' or translate(tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:Partij[1]/tia:aanduidingPartij, $upper, $lower) = 'de hypotheekgever'">
				<xsl:value-of select="substring-after(tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:Partij[1]/tia:aanduidingPartij, 'de ')"/>	
			</xsl:when>
			<xsl:when test="tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_schuldenaarhypotheekgever']/tia:tekst">
				<xsl:value-of select="tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_schuldenaarhypotheekgever']/tia:tekst"/>
			</xsl:when>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="partyTwoName">
		<xsl:value-of select="tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:Partij[2]/tia:aanduidingPartij"/>
	</xsl:variable>

	<!--
	*********************************************************
	Mode: do-deed
	*********************************************************
	Public: yes

	Identity transform: no

	Description: Private mortgage deed.

	Input: tia:Bericht_TIA_Stuk

	Params: none

	Output: XHTML structure

	Calls:
	(mode) do-statement-of-equivalence
	(mode) do-header
	(mode) do-parties
	(mode) do-natural-person-part
	(mode) do-address-part
	(mode) do-right
	(mode) do-registered-object
	(mode) do-bridging-mortgage
	(mode) do-free-text
	(name) amountText
	(name) amountNumber
	(name) percentText
	(name) percentNumber
	(name) processRights

	Called by:
	Root template
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:Bericht_TIA_Stuk" mode="do-deed">
		<!-- Text block Statement of equivalence -->
		<xsl:if test="translate($type-document, $upper, $lower) = 'afschrift'">
			<a name="hyp3.statementOfEquivalence" class="location">&#160;</a>
			<xsl:apply-templates select="tia:IMKAD_AangebodenStuk" mode="do-statement-of-equivalence"/>
			<!-- Two empty lines after Statement of equivalence -->
			<p><br/></p>
			<p><br/></p>
		</xsl:if>
		<a name="hyp3.header" class="location">&#160;</a>
		<!-- Document title -->
		<xsl:if test="normalize-space($documentTitle) != '' and translate($documentTitle, $upper, $lower) != 'particuliere hypotheek'">
			<p style="text-align:center" title="without_dashes"><xsl:value-of select="$documentTitle"/></p>
			<!-- Empty line after title -->
			<p title="without_dashes"><br/></p>
		</xsl:if>
		<!-- Kenmerk -->
		<xsl:if test="tia:IMKAD_AangebodenStuk/tia:tia_OmschrijvingKenmerk
				and normalize-space(tia:IMKAD_AangebodenStuk/tia:tia_OmschrijvingKenmerk) != ''">
			<p title="without_dashes">
				<xsl:text>Kenmerk: </xsl:text>
				<xsl:value-of select="tia:IMKAD_AangebodenStuk/tia:tia_OmschrijvingKenmerk"/>
			</p>
		</xsl:if>
		<!-- Zaaknummer -->
		<xsl:if test="tia:IMKAD_AangebodenStuk/tia:tia_OmschrijvingZaak
				and normalize-space(tia:IMKAD_AangebodenStuk/tia:tia_OmschrijvingZaak) != ''">
			<p title="without_dashes">
				<xsl:text>Zaaknummer: </xsl:text>
				<xsl:value-of select="tia:IMKAD_AangebodenStuk/tia:tia_OmschrijvingZaak"/>
			</p>
		</xsl:if>
		<xsl:if test="(tia:IMKAD_AangebodenStuk/tia:tia_OmschrijvingKenmerk
					and normalize-space(tia:IMKAD_AangebodenStuk/tia:tia_OmschrijvingKenmerk) != '')
				or (tia:IMKAD_AangebodenStuk/tia:tia_OmschrijvingZaak
					and normalize-space(tia:IMKAD_AangebodenStuk/tia:tia_OmschrijvingZaak) != '')">
			<!-- Empty line after Offertenummer/Zaaknummer -->
			<p title="without_dashes"><br/></p>
		</xsl:if>
		<!-- Text block Header -->
		<xsl:apply-templates select="tia:IMKAD_AangebodenStuk" mode="do-header"/>
		<!-- Parties -->
		<table cellspacing="0" cellpadding="0">
			<tbody>
				<xsl:apply-templates select="tia:IMKAD_AangebodenStuk/tia:Partij" mode="do-parties"/>
			</tbody>
		</table>
		<p>
			<xsl:text>Van het bestaan van de volmacht</xsl:text>
			<xsl:value-of select="tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoudvolmachten']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
				translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoudvolmachten']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
				translate(normalize-space(current()/tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoudvolmachten']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
			<xsl:text> aan de comparant</xsl:text>
			<xsl:choose>
				<xsl:when test="not(tia:IMKAD_AangebodenStuk/tia:Partij[@id = substring-after(current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:Gevolmachtigde) 
									and (count(tia:IMKAD_AangebodenStuk/tia:Partij[@id = substring-after(current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:IMKAD_Persoon) +
									count(tia:IMKAD_AangebodenStuk/tia:Partij[@id = substring-after(current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:IMKAD_Persoon[tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene]/tia:GerelateerdPersoon) + 
									count(tia:IMKAD_AangebodenStuk/tia:Partij[@id = substring-after(current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:IMKAD_Persoon[tia:tia_Gegevens/tia:NHR_Rechtspersoon]/tia:GerelateerdPersoon[translate(tia:tia_IndPartij, $upper, $lower) = 'true'])) > 1">
					<xsl:text>en</xsl:text>
				</xsl:when>
				<xsl:when test="(tia:IMKAD_AangebodenStuk/tia:Partij[@id = substring-after(current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:Gevolmachtigde 
									and translate(tia:IMKAD_AangebodenStuk/tia:Partij[@id = substring-after(current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:Gevolmachtigde/tia:gegevens/tia:persoonGegevens/tia:geslacht/tia:geslachtsaanduiding, $upper, $lower) = 'vrouw')
								or (not(tia:IMKAD_AangebodenStuk/tia:Partij[@id = substring-after(current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:Gevolmachtigde) 
									and count(tia:IMKAD_AangebodenStuk/tia:Partij[@id = substring-after(current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:IMKAD_Persoon) = 1 
									and tia:IMKAD_AangebodenStuk/tia:Partij[@id = substring-after(current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:IMKAD_Persoon[1]/tia:tia_Gegevens/tia:NHR_Rechtspersoon 
									and tia:IMKAD_AangebodenStuk/tia:Partij[@id = substring-after(current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:IMKAD_Persoon[1]/tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder']/tia:IMKAD_Persoon/tia:tia_Gegevens[translate(tia:GBA_Ingezetene/tia:geslacht/tia:geslachtsaanduiding, $upper, $lower) = 'vrouw' or translate(tia:IMKAD_NietIngezetene/tia:geslacht, $upper, $lower) = 'vrouw'])
								or (not(tia:IMKAD_AangebodenStuk/tia:Partij[@id = substring-after(current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:Gevolmachtigde) 
									and count(tia:IMKAD_AangebodenStuk/tia:Partij[@id = substring-after(current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:IMKAD_Persoon) = 1 
									and tia:IMKAD_AangebodenStuk/tia:Partij[@id = substring-after(current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:IMKAD_Persoon[1]/tia:tia_Gegevens[translate(tia:GBA_Ingezetene/tia:geslacht/tia:geslachtsaanduiding, $upper, $lower) = 'vrouw' or translate(tia:IMKAD_NietIngezetene/tia:geslacht, $upper, $lower) = 'vrouw'])">
					<xsl:text>e</xsl:text>
				</xsl:when>
			</xsl:choose>
			<xsl:text> onder 2. genoemd is mij, notaris, genoegzaam gebleken.</xsl:text>
			<br/>
			<xsl:text>De verschenen personen</xsl:text>
			<xsl:value-of select="tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_handelendals']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
				translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_handelendals']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
				translate(normalize-space(current()/tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_handelendals']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
			<xsl:text> verklaarden als volgt.</xsl:text>
		</p>
		<!-- Contract of sale -->
		<xsl:apply-templates select="tia:IMKAD_AangebodenStuk" mode="do-contract-of-sale"/>
		<!-- Mortgage loan -->
		<a name="hyp3.privateMortgageProvisionAndGrantGiver" class="location">&#160;</a>
		<xsl:apply-templates select="tia:IMKAD_AangebodenStuk" mode="do-mortgage-provision"/>
		<!-- Type of Mortgage -->
		<a name="hyp3.privateMortgageType" class="location">&#160;</a>
		<xsl:choose>
			<xsl:when test="tia:partnerSpecifiek/part:BankHypotheek">
				<xsl:if test="count(tia:partnerSpecifiek/part:BankHypotheek/part:omschrijving) > 0">
					<table cellpadding="0" cellspacing="0">
						<tbody>
							<xsl:for-each select="tia:partnerSpecifiek/part:BankHypotheek/part:omschrijving">
								<tr>
								    <td class="number" valign="top">
								    	<xsl:text>-</xsl:text>
								    </td>
								    <td>
								    	<xsl:value-of select="."/>
										<xsl:choose>
											<xsl:when test="position() = last()">
												<xsl:text>.</xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text>;</xsl:text>
											</xsl:otherwise>
										</xsl:choose>
								    </td>
								</tr>
							</xsl:for-each>
						</tbody>
					</table>
				</xsl:if>
			</xsl:when>
			<xsl:when test="tia:partnerSpecifiek/part:VasteHypotheekGeenSchip">
				<xsl:variable name="vasteHypotheekGeenSchip" select="tia:partnerSpecifiek/part:VasteHypotheekGeenSchip"/>
				<p>
					<xsl:choose>					
						<xsl:when test="$vasteHypotheekGeenSchip/part:vasteHypotheek/part:OnderhandseAkte">
							<xsl:text>de blijkens onderhandse akte(n) </xsl:text>
							<xsl:if test="count($vasteHypotheekGeenSchip/part:vasteHypotheek/part:OnderhandseAkte/part:datum) > 1">
								<xsl:text>respectievelijk </xsl:text>
							</xsl:if>
							<xsl:text>gedateerd: </xsl:text>
							<xsl:for-each select="$vasteHypotheekGeenSchip/part:vasteHypotheek/part:OnderhandseAkte/part:datum">
								<xsl:variable name="Datum_DATE" select="substring(string(.), 0, 11)"/>
								<xsl:variable name="Datum_STRING">
									<xsl:if test="$Datum_DATE != ''">
										<xsl:value-of select="kef:convertDateToText($Datum_DATE)"/>
									</xsl:if>
								</xsl:variable>
								<xsl:value-of select="$Datum_STRING"/>
								<xsl:choose>
									<xsl:when test="position() = (last() - 1)">
										<xsl:text> en </xsl:text>
									</xsl:when>
									<xsl:when test="position() != last()">
										<xsl:text>, </xsl:text>
									</xsl:when>
								</xsl:choose>
							</xsl:for-each>
						</xsl:when>
						<xsl:when test="$vasteHypotheekGeenSchip/part:vasteHypotheek/part:Financieringsvoorstel or $vasteHypotheekGeenSchip/part:vasteHypotheek/part:FinancieringsvoorstelAcceptatie">
							<xsl:choose>
								<xsl:when test="count($vasteHypotheekGeenSchip/part:vasteHypotheek/part:Financieringsvoorstel/part:datum) = 1">
									<xsl:text>het financieringsvoorstel </xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>de financieringsvoorstellen </xsl:text>
								</xsl:otherwise>
							</xsl:choose>							
							<xsl:if test="count($vasteHypotheekGeenSchip/part:vasteHypotheek/part:Financieringsvoorstel/part:datum) > 1">
								<xsl:text>respectievelijk </xsl:text>
							</xsl:if>
							<xsl:text>gedateerd </xsl:text>
							<xsl:for-each select="$vasteHypotheekGeenSchip/part:vasteHypotheek/part:Financieringsvoorstel/part:datum">
								<xsl:variable name="Datum_DATE" select="substring(string(.), 0, 11)"/>
								<xsl:variable name="Datum_STRING">
									<xsl:if test="$Datum_DATE != ''">
										<xsl:value-of select="kef:convertDateToText($Datum_DATE)"/>
									</xsl:if>
								</xsl:variable>
								<xsl:value-of select="$Datum_STRING"/>
								<xsl:choose>
									<xsl:when test="position() = (last() - 1)">
										<xsl:text> en </xsl:text>
									</xsl:when>
									<xsl:when test="position() != last()">
										<xsl:text>, </xsl:text>
									</xsl:when>
								</xsl:choose>
							</xsl:for-each>
							<xsl:if test="$vasteHypotheekGeenSchip/part:vasteHypotheek/part:FinancieringsvoorstelAcceptatie">
								<xsl:if test="count($vasteHypotheekGeenSchip/part:vasteHypotheek/part:FinancieringsvoorstelAcceptatie/part:datum) > 1">
									<xsl:text> respectievelijk</xsl:text>
								</xsl:if>
								<xsl:text> geaccepteerd op </xsl:text>
								<xsl:for-each select="$vasteHypotheekGeenSchip/part:vasteHypotheek/part:FinancieringsvoorstelAcceptatie/part:datum">
									<xsl:variable name="Datum_DATE" select="substring(string(.), 0, 11)"/>
									<xsl:variable name="Datum_STRING">
										<xsl:if test="$Datum_DATE != ''">
											<xsl:value-of select="kef:convertDateToText($Datum_DATE)"/>
										</xsl:if>
									</xsl:variable>
									<xsl:value-of select="$Datum_STRING"/>
									<xsl:choose>
										<xsl:when test="position() = (last() - 1)">
											<xsl:text> en </xsl:text>
										</xsl:when>
										<xsl:when test="position() != last()">
											<xsl:text>, </xsl:text>
										</xsl:when>
									</xsl:choose>
								</xsl:for-each>
							</xsl:if>
						</xsl:when>
					</xsl:choose>	
				</p>
				<xsl:if test="$vasteHypotheekGeenSchip/part:Geldleningen or $vasteHypotheekGeenSchip/part:Kredieten or $vasteHypotheekGeenSchip/part:Borgtochten">
					<table cellpadding="0" cellspacing="0">
						<tbody>
							<xsl:if test="$vasteHypotheekGeenSchip/part:Geldleningen">
								<tr>
									<td class="number" valign="top">
										<xsl:text>1)</xsl:text>
									</td>
									<td>
										<xsl:value-of select="$vasteHypotheekGeenSchip/part:Geldleningen/part:tekstKeuze[translate(part:tagNaam, $upper, $lower) = 'k_hyp_verstrekt']/part:tekst[translate(normalize-space(.), $upper, $lower) = 
											translate(normalize-space($keuzeteksten/*/part:tekstKeuze[translate(part:tagNaam, $upper, $lower) = 'k_hyp_verstrekt']/part:tekst[translate(normalize-space(.), $upper, $lower) = 
											translate(normalize-space($vasteHypotheekGeenSchip/part:Geldleningen/part:tekstKeuze[translate(part:tagNaam, $upper, $lower) = 'k_hyp_verstrekt']/part:tekst), $upper, $lower)]), $upper, $lower)]"/>
										<xsl:choose>
											<xsl:when test="count($vasteHypotheekGeenSchip/part:Geldleningen/part:bedrag) = 1">
												<xsl:text> geldlening groot </xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text> geldleningen respectievelijk groot </xsl:text>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:for-each select="$vasteHypotheekGeenSchip/part:Geldleningen/part:bedrag">
											<xsl:call-template name="amountText">
												<xsl:with-param name="amount" select="part:som" />
												<xsl:with-param name="valuta" select="part:valuta" />
											</xsl:call-template>
											<xsl:text> </xsl:text>
											<xsl:call-template name="amountNumber">
												<xsl:with-param name="amount" select="part:som" />
												<xsl:with-param name="valuta" select="part:valuta" />
											</xsl:call-template>
											<xsl:choose>
												<xsl:when test="position() = (last() - 1)">
													<xsl:text> en </xsl:text>
												</xsl:when>
												<xsl:when test="position() != last()">
													<xsl:text>, </xsl:text>
												</xsl:when>
											</xsl:choose>
										</xsl:for-each>
										<xsl:choose>
											<xsl:when test="$vasteHypotheekGeenSchip/part:Kredieten or $vasteHypotheekGeenSchip/part:Borgtochten">
												<xsl:text>;</xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text>.</xsl:text>
											</xsl:otherwise>
										</xsl:choose>
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="$vasteHypotheekGeenSchip/part:Kredieten">
								<xsl:variable name="position">
									<xsl:value-of select="count($vasteHypotheekGeenSchip/part:Geldleningen) + 1"/>
								</xsl:variable>
								<tr>
									<td class="number" valign="top">
										<xsl:value-of select="$position"/>
										<xsl:text>)</xsl:text>
									</td>
									<td>
										<xsl:value-of select="$vasteHypotheekGeenSchip/part:Kredieten/part:tekstKeuze[translate(part:tagNaam, $upper, $lower) = 'k_hyp_verleend']/part:tekst[translate(normalize-space(.), $upper, $lower) = 
											translate(normalize-space($keuzeteksten/*/part:tekstKeuze[translate(part:tagNaam, $upper, $lower) = 'k_hyp_verleend']/part:tekst[translate(normalize-space(.), $upper, $lower) = 
											translate(normalize-space($vasteHypotheekGeenSchip/part:Kredieten/part:tekstKeuze[translate(part:tagNaam, $upper, $lower) = 'k_hyp_verleend']/part:tekst), $upper, $lower)]), $upper, $lower)]"/>
										<xsl:choose>
											<xsl:when test="count($vasteHypotheekGeenSchip/part:Kredieten/part:bedrag) = 1">
												<xsl:text> krediet groot </xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text> kredieten respectievelijk groot </xsl:text>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:for-each select="$vasteHypotheekGeenSchip/part:Kredieten/part:bedrag">
											<xsl:call-template name="amountText">
												<xsl:with-param name="amount" select="part:som" />
												<xsl:with-param name="valuta" select="part:valuta" />
											</xsl:call-template>
											<xsl:text> </xsl:text>
											<xsl:call-template name="amountNumber">
												<xsl:with-param name="amount" select="part:som" />
												<xsl:with-param name="valuta" select="part:valuta" />
											</xsl:call-template>
											<xsl:choose>
												<xsl:when test="position() = (last() - 1)">
													<xsl:text> en </xsl:text>
												</xsl:when>
												<xsl:when test="position() != last()">
													<xsl:text>, </xsl:text>
												</xsl:when>
											</xsl:choose>
										</xsl:for-each>
										<xsl:choose>
											<xsl:when test="$vasteHypotheekGeenSchip/part:Borgtochten">
												<xsl:text>;</xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text>.</xsl:text>
											</xsl:otherwise>
										</xsl:choose>
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="$vasteHypotheekGeenSchip/part:Borgtochten">
								<xsl:variable name="position">
									<xsl:value-of select="count($vasteHypotheekGeenSchip/part:Geldleningen) + count($vasteHypotheekGeenSchip/part:Kredieten) + 1"/>
								</xsl:variable>
								<tr>
									<td class="number" valign="top">
										<xsl:value-of select="$position"/>
										<xsl:text>)</xsl:text>
									</td>
									<td>
										<xsl:value-of select="$vasteHypotheekGeenSchip/part:Borgtochten/part:tekstKeuze[translate(part:tagNaam, $upper, $lower) = 'k_hyp_gesteld']/part:tekst[translate(normalize-space(.), $upper, $lower) = 
											translate(normalize-space($keuzeteksten/*/part:tekstKeuze[translate(part:tagNaam, $upper, $lower) = 'k_hyp_gesteld']/part:tekst[translate(normalize-space(.), $upper, $lower) = 
											translate(normalize-space($vasteHypotheekGeenSchip/part:Borgtochten/part:tekstKeuze[translate(part:tagNaam, $upper, $lower) = 'k_hyp_gesteld']/part:tekst), $upper, $lower)]), $upper, $lower)]"/>
										<xsl:choose>
											<xsl:when test="count($vasteHypotheekGeenSchip/part:Borgtochten/part:IMKAD_Persoon) = 1">
												<xsl:text> borgtocht </xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text> borgtochten </xsl:text>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:text>voor </xsl:text>
										<xsl:for-each select="$vasteHypotheekGeenSchip/part:Borgtochten/part:IMKAD_Persoon">
											<xsl:apply-templates select="." mode="do-natural-person-part"/>
											<xsl:text> wonende te </xsl:text>
											<xsl:apply-templates select="part:IMKAD_WoonlocatiePersoon" mode="do-address-part"/>
											<xsl:choose>
												<xsl:when test="position() = (last() - 1)">
													<xsl:text> en </xsl:text>
												</xsl:when>
												<xsl:when test="position() != last()">
													<xsl:text>, </xsl:text>
												</xsl:when>
											</xsl:choose>
										</xsl:for-each>
										<xsl:text>.</xsl:text>
									</td>
								</tr>
							</xsl:if>
						</tbody>
					</table>					
				</xsl:if>
			</xsl:when>
			<xsl:when test="tia:partnerSpecifiek/part:VasteHypotheekSchip">
				<xsl:variable name="vasteHypotheekSchip" select="tia:partnerSpecifiek/part:VasteHypotheekSchip"/>
				<p>
					<xsl:choose>
						<xsl:when test="$vasteHypotheekSchip/part:vasteHypotheek/part:OnderhandseAkte">
							<xsl:text>de blijkens onderhandse akte(n) </xsl:text>
							<xsl:if test="count($vasteHypotheekSchip/part:vasteHypotheek/part:OnderhandseAkte/part:datum) > 1">
								<xsl:text>respectievelijk </xsl:text>
							</xsl:if>
							<xsl:text>gedateerd: </xsl:text>
							<xsl:for-each select="$vasteHypotheekSchip/part:vasteHypotheek/part:OnderhandseAkte/part:datum">
								<xsl:variable name="Datum_DATE" select="substring(string(.), 0, 11)"/>
								<xsl:variable name="Datum_STRING">
									<xsl:if test="$Datum_DATE != ''">
										<xsl:value-of select="kef:convertDateToText($Datum_DATE)"/>
									</xsl:if>
								</xsl:variable>
								<xsl:value-of select="$Datum_STRING"/>
								<xsl:choose>
									<xsl:when test="position() = (last() - 1)">
										<xsl:text> en </xsl:text>
									</xsl:when>
									<xsl:when test="position() != last()">
										<xsl:text>, </xsl:text>
									</xsl:when>
								</xsl:choose>
							</xsl:for-each>
						</xsl:when>
						<xsl:when test="$vasteHypotheekSchip/part:vasteHypotheek/part:Financieringsvoorstel or $vasteHypotheekSchip/part:vasteHypotheek/part:FinancieringsvoorstelAcceptatie">
							<xsl:choose>
								<xsl:when test="count($vasteHypotheekSchip/part:vasteHypotheek/part:Financieringsvoorstel/part:datum) = 1">
									<xsl:text>het financieringsvoorstel </xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>de financieringsvoorstellen </xsl:text>
								</xsl:otherwise>
							</xsl:choose>							
							<xsl:if test="count($vasteHypotheekSchip/part:vasteHypotheek/part:Financieringsvoorstel/part:datum) > 1">
								<xsl:text>respectievelijk </xsl:text>
							</xsl:if>
							<xsl:text>gedateerd </xsl:text>
							<xsl:for-each select="$vasteHypotheekSchip/part:vasteHypotheek/part:Financieringsvoorstel/part:datum">
								<xsl:variable name="Datum_DATE" select="substring(string(.), 0, 11)"/>
								<xsl:variable name="Datum_STRING">
									<xsl:if test="$Datum_DATE != ''">
										<xsl:value-of select="kef:convertDateToText($Datum_DATE)"/>
									</xsl:if>
								</xsl:variable>
								<xsl:value-of select="$Datum_STRING"/>
								<xsl:choose>
									<xsl:when test="position() = (last() - 1)">
										<xsl:text> en </xsl:text>
									</xsl:when>
									<xsl:when test="position() != last()">
										<xsl:text>, </xsl:text>
									</xsl:when>
								</xsl:choose>
							</xsl:for-each>							
							<xsl:if test="$vasteHypotheekSchip/part:vasteHypotheek/part:FinancieringsvoorstelAcceptatie">
								<xsl:if test="count($vasteHypotheekSchip/part:vasteHypotheek/part:FinancieringsvoorstelAcceptatie/part:datum) > 1">
									<xsl:text> respectievelijk</xsl:text>
								</xsl:if>
								<xsl:text> geaccepteerd op </xsl:text>
								<xsl:for-each select="$vasteHypotheekSchip/part:vasteHypotheek/part:FinancieringsvoorstelAcceptatie/part:datum">
									<xsl:variable name="Datum_DATE" select="substring(string(.), 0, 11)"/>
									<xsl:variable name="Datum_STRING">
										<xsl:if test="$Datum_DATE != ''">
											<xsl:value-of select="kef:convertDateToText($Datum_DATE)"/>
										</xsl:if>
									</xsl:variable>
									<xsl:value-of select="$Datum_STRING"/>
									<xsl:choose>
										<xsl:when test="position() = (last() - 1)">
											<xsl:text> en </xsl:text>
										</xsl:when>
										<xsl:when test="position() != last()">
											<xsl:text>, </xsl:text>
										</xsl:when>
									</xsl:choose>
								</xsl:for-each>
							</xsl:if>
						</xsl:when>
					</xsl:choose>
				</p>
				<xsl:if test="$vasteHypotheekSchip/part:GeldleningenInclRente or $vasteHypotheekSchip/part:KredietenInclRente">
					<table cellpadding="0" cellspacing="0">
						<tbody>
							<xsl:if test="$vasteHypotheekSchip/part:GeldleningenInclRente">
								<tr>
									<td class="number" valign="top">
										<xsl:text>1)</xsl:text>
									</td>
									<td>
										<xsl:value-of select="$vasteHypotheekSchip/part:GeldleningenInclRente/part:Geldleningen/part:tekstKeuze[translate(part:tagNaam, $upper, $lower) = 'k_hyp_verstrekt']/part:tekst[translate(normalize-space(.), $upper, $lower) = 
											translate(normalize-space($keuzeteksten/*/part:tekstKeuze[translate(part:tagNaam, $upper, $lower) = 'k_hyp_verstrekt']/part:tekst[translate(normalize-space(.), $upper, $lower) = 
											translate(normalize-space($vasteHypotheekSchip/part:GeldleningenInclRente/part:Geldleningen/part:tekstKeuze[translate(part:tagNaam, $upper, $lower) = 'k_hyp_verstrekt']/part:tekst), $upper, $lower)]), $upper, $lower)]"/>
										<xsl:choose>
											<xsl:when test="count($vasteHypotheekSchip/part:GeldleningenInclRente/part:Geldleningen/part:bedrag) = 1">
												<xsl:text> geldlening groot </xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text> geldleningen respectievelijk groot </xsl:text>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:for-each select="$vasteHypotheekSchip/part:GeldleningenInclRente/part:Geldleningen/part:bedrag">
											<xsl:call-template name="amountText">
												<xsl:with-param name="amount" select="part:som" />
												<xsl:with-param name="valuta" select="part:valuta" />
											</xsl:call-template>
											<xsl:text> </xsl:text>
											<xsl:call-template name="amountNumber">
												<xsl:with-param name="amount" select="part:som" />
												<xsl:with-param name="valuta" select="part:valuta" />
											</xsl:call-template>
											<xsl:choose>
												<xsl:when test="position() = (last() - 1)">
													<xsl:text> en </xsl:text>
												</xsl:when>
												<xsl:when test="position() != last()">
													<xsl:text>, </xsl:text>
												</xsl:when>
											</xsl:choose>
										</xsl:for-each>
										<xsl:text>. Behoudens wijziging </xsl:text>
										<xsl:choose>
											<xsl:when test="count($vasteHypotheekSchip/part:GeldleningenInclRente/part:rente/part:Rentepercentage/part:percentage) = 1">
												<xsl:text>bedraagt de bedongen rente voor deze geldlening </xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text>bedragen de bedongen renten voor deze geldleningen respectievelijk </xsl:text>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:for-each select="$vasteHypotheekSchip/part:GeldleningenInclRente/part:rente/part:Rentepercentage/part:percentage">
											<xsl:call-template name="percentText">
												<xsl:with-param name="percent" select="." />
											</xsl:call-template>
											<xsl:text> </xsl:text>
											<xsl:call-template name="percentNumber">
												<xsl:with-param name="percent" select="." />
											</xsl:call-template>
											<xsl:choose>
												<xsl:when test="position() = (last() - 1)">
													<xsl:text> en </xsl:text>
												</xsl:when>
												<xsl:when test="position() != last()">
													<xsl:text>, </xsl:text>
												</xsl:when>
											</xsl:choose>																		
										</xsl:for-each>
										<xsl:text> per jaar, vervallende </xsl:text>
										<xsl:if test="count($vasteHypotheekSchip/part:GeldleningenInclRente/part:rente/part:VervalDatum/part:datum) > 1">
											<xsl:text>respectievelijk </xsl:text>
										</xsl:if>
										<xsl:text>op </xsl:text>
										<xsl:for-each select="$vasteHypotheekSchip/part:GeldleningenInclRente/part:rente/part:VervalDatum/part:datum">
											<xsl:variable name="Datum_DATE" select="substring(string(.), 0, 11)"/>
											<xsl:variable name="Datum_STRING">
												<xsl:if test="$Datum_DATE != ''">
													<xsl:value-of select="kef:convertDateToText($Datum_DATE)"/>
												</xsl:if>
											</xsl:variable>
											<xsl:value-of select="$Datum_STRING"/>
											<xsl:choose>
												<xsl:when test="position() = (last() - 1)">
													<xsl:text> en </xsl:text>
												</xsl:when>
												<xsl:when test="position() != last()">
													<xsl:text>, </xsl:text>
												</xsl:when>
											</xsl:choose>
										</xsl:for-each>
										<xsl:text> van elk jaar, voor het eerst op </xsl:text>
											<xsl:for-each select="$vasteHypotheekSchip/part:GeldleningenInclRente/part:rente/part:EersteVervalDatum/part:datum">
											<xsl:variable name="Datum_DATE" select="substring(string(.), 0, 11)"/>
											<xsl:variable name="Datum_STRING">
												<xsl:if test="$Datum_DATE != ''">
													<xsl:value-of select="kef:convertDateToText($Datum_DATE)"/>
												</xsl:if>
											</xsl:variable>
											<xsl:value-of select="$Datum_STRING"/>
											<xsl:choose>
												<xsl:when test="position() = (last() - 1)">
													<xsl:text> en </xsl:text>
												</xsl:when>
												<xsl:when test="position() != last()">
													<xsl:text>, </xsl:text>
												</xsl:when>
											</xsl:choose>
										</xsl:for-each>
										<xsl:choose>
											<xsl:when test="$vasteHypotheekSchip/part:KredietenInclRente">
												<xsl:text>;</xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text>.</xsl:text>
											</xsl:otherwise>
										</xsl:choose>
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="$vasteHypotheekSchip/part:KredietenInclRente">
								<xsl:variable name="position">
									<xsl:value-of select="count($vasteHypotheekSchip/part:GeldleningenInclRente) + 1"/>
								</xsl:variable>
								<tr>
									<td class="number" valign="top">
										<xsl:value-of select="$position"/>
										<xsl:text>)</xsl:text>
									</td>
									<td>
										<xsl:value-of select="$vasteHypotheekSchip/part:KredietenInclRente/part:Kredieten/part:tekstKeuze[translate(part:tagNaam, $upper, $lower) = 'k_hyp_verleend']/part:tekst[translate(normalize-space(.), $upper, $lower) = 
											translate(normalize-space($keuzeteksten/*/part:tekstKeuze[translate(part:tagNaam, $upper, $lower) = 'k_hyp_verleend']/part:tekst[translate(normalize-space(.), $upper, $lower) = 
											translate(normalize-space($vasteHypotheekSchip/part:KredietenInclRente/part:Kredieten/part:tekstKeuze[translate(part:tagNaam, $upper, $lower) = 'k_hyp_verleend']/part:tekst), $upper, $lower)]), $upper, $lower)]"/>
										<xsl:choose>
											<xsl:when test="count($vasteHypotheekSchip/part:KredietenInclRente/part:Kredieten/part:bedrag) = 1">
												<xsl:text> krediet groot </xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text> kredieten respectievelijk groot </xsl:text>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:for-each select="$vasteHypotheekSchip/part:KredietenInclRente/part:Kredieten/part:bedrag">
											<xsl:call-template name="amountText">
												<xsl:with-param name="amount" select="part:som" />
												<xsl:with-param name="valuta" select="part:valuta" />
											</xsl:call-template>
											<xsl:text> </xsl:text>
											<xsl:call-template name="amountNumber">
												<xsl:with-param name="amount" select="part:som" />
												<xsl:with-param name="valuta" select="part:valuta" />
											</xsl:call-template>
											<xsl:choose>
												<xsl:when test="position() = (last() - 1)">
													<xsl:text> en </xsl:text>
												</xsl:when>
												<xsl:when test="position() != last()">
													<xsl:text>, </xsl:text>
												</xsl:when>
											</xsl:choose>
										</xsl:for-each>
										<xsl:text>. Behoudens wijziging </xsl:text>
										<xsl:choose>
											<xsl:when test="count($vasteHypotheekSchip/part:KredietenInclRente/part:rente/part:Rentepercentage/part:percentage) = 1">
												<xsl:text>bedraagt de bedongen rente voor dit krediet </xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text>bedragen de bedongen renten voor deze kredieten respectievelijk </xsl:text>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:for-each select="$vasteHypotheekSchip/part:KredietenInclRente/part:rente/part:Rentepercentage/part:percentage">
											<xsl:call-template name="percentText">
												<xsl:with-param name="percent" select="." />
											</xsl:call-template>
											<xsl:text> </xsl:text>
											<xsl:call-template name="percentNumber">
												<xsl:with-param name="percent" select="." />
											</xsl:call-template>
											<xsl:choose>
												<xsl:when test="position() = (last() - 1)">
													<xsl:text> en </xsl:text>
												</xsl:when>
												<xsl:when test="position() != last()">
													<xsl:text>, </xsl:text>
												</xsl:when>
											</xsl:choose>		
										</xsl:for-each>
										<xsl:text> per jaar, vervallende </xsl:text>
										<xsl:if test="count($vasteHypotheekSchip/part:KredietenInclRente/part:rente/part:VervalDatum/part:datum) > 1">
											<xsl:text>respectievelijk </xsl:text>
										</xsl:if>
										<xsl:text>op </xsl:text>
										<xsl:for-each select="$vasteHypotheekSchip/part:KredietenInclRente/part:rente/part:VervalDatum/part:datum">
											<xsl:variable name="Datum_DATE" select="substring(string(.), 0, 11)"/>
											<xsl:variable name="Datum_STRING">
												<xsl:if test="$Datum_DATE != ''">
													<xsl:value-of select="kef:convertDateToText($Datum_DATE)"/>
												</xsl:if>
											</xsl:variable>
											<xsl:value-of select="$Datum_STRING"/>
											<xsl:choose>
												<xsl:when test="position() = (last() - 1)">
													<xsl:text> en </xsl:text>
												</xsl:when>
												<xsl:when test="position() != last()">
													<xsl:text>, </xsl:text>
												</xsl:when>
											</xsl:choose>
										</xsl:for-each>
										<xsl:text> van elk jaar, voor het eerst op </xsl:text>
										<xsl:for-each select="$vasteHypotheekSchip/part:KredietenInclRente/part:rente/part:EersteVervalDatum/part:datum">
											<xsl:variable name="Datum_DATE" select="substring(string(.), 0, 11)"/>
											<xsl:variable name="Datum_STRING">
												<xsl:if test="$Datum_DATE != ''">
													<xsl:value-of select="kef:convertDateToText($Datum_DATE)"/>
												</xsl:if>
											</xsl:variable>
											<xsl:value-of select="$Datum_STRING"/>
											<xsl:choose>
												<xsl:when test="position() = (last() - 1)">
													<xsl:text> en </xsl:text>
												</xsl:when>
												<xsl:when test="position() != last()">
													<xsl:text>, </xsl:text>
												</xsl:when>
											</xsl:choose>
										</xsl:for-each>
										<xsl:text>.</xsl:text>
									</td>
								</tr>
							</xsl:if>
						</tbody>
					</table>		
				</xsl:if>
			</xsl:when>
		</xsl:choose>
		<!-- Mortgage amount -->
		<a name="hyp3.mortgageAmountAndAdditionalCosts" class="location">&#160;</a>
		<h2 class="header"><xsl:text>Hypotheekbedrag</xsl:text></h2>
		<p>
			<xsl:text>De </xsl:text>
			<xsl:value-of select="$partyOneName"/> 
			<xsl:text> verklaarde dat het recht van hypotheek is verleend tot:</xsl:text>
		</p>
		<table cellpadding="0" cellspacing="0">
			<tbody>
				<tr>
					<td class="number" valign="top">
						<xsl:text>a)</xsl:text>
					</td>
					<td>
						<xsl:text>een bedrag van </xsl:text>
						<xsl:call-template name="amountText">
							<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:hoofdsom/tia:som" />
							<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:hoofdsom/tia:valuta" />
						</xsl:call-template>
						<xsl:text> </xsl:text>
						<xsl:call-template name="amountNumber">
							<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:hoofdsom/tia:som" />
							<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:hoofdsom/tia:valuta" />
						</xsl:call-template>
						<xsl:text> te vermeerderen met</xsl:text>
					</td>
				</tr>
				<!-- Additional costs -->
				<xsl:choose>
					<xsl:when test="tia:partnerSpecifiek/part:AanvullendeKosten/part:RegistergoedGeenSchip">
						<tr>
							<td class="number" valign="top">
								<xsl:text>b)</xsl:text>
							</td>
							<td>
								<xsl:text>renten, vergoedingen, boeten en kosten, welke samen worden begroot op vijfendertig procent (35 %) van het hiervoor onder a vermelde bedrag, derhalve tot een bedrag van </xsl:text>
								<xsl:call-template name="amountText">
									<xsl:with-param name="amount" select="tia:partnerSpecifiek/part:AanvullendeKosten/part:RegistergoedGeenSchip/part:bedragRente/part:som" />
									<xsl:with-param name="valuta" select="tia:partnerSpecifiek/part:AanvullendeKosten/part:RegistergoedGeenSchip/part:bedragRente/part:valuta" />
								</xsl:call-template>
								<xsl:text> </xsl:text>
								<xsl:call-template name="amountNumber">
									<xsl:with-param name="amount" select="tia:partnerSpecifiek/part:AanvullendeKosten/part:RegistergoedGeenSchip/part:bedragRente/part:som" />
									<xsl:with-param name="valuta" select="tia:partnerSpecifiek/part:AanvullendeKosten/part:RegistergoedGeenSchip/part:bedragRente/part:valuta" />
								</xsl:call-template>
							</td>
						</tr>
					</xsl:when>
					<xsl:when test="tia:partnerSpecifiek/part:AanvullendeKosten/part:HypotheekMedeOpSchip">
						<tr>
							<td class="number" valign="top">
								<xsl:text>b)</xsl:text>
							</td>
							<td>
								<xsl:text>renten, vergoedingen, boeten en kosten, welke samen worden begroot op vijftig procent (50%) van het hiervoor onder a vermelde bedrag, derhalve tot een bedrag van </xsl:text>
								<xsl:call-template name="amountText">
									<xsl:with-param name="amount" select="tia:partnerSpecifiek/part:AanvullendeKosten/part:HypotheekMedeOpSchip/part:bedragRente/part:som" />
									<xsl:with-param name="valuta" select="tia:partnerSpecifiek/part:AanvullendeKosten/part:HypotheekMedeOpSchip/part:bedragRente/part:valuta" />
								</xsl:call-template>
								<xsl:text> </xsl:text>
								<xsl:call-template name="amountNumber">
									<xsl:with-param name="amount" select="tia:partnerSpecifiek/part:AanvullendeKosten/part:HypotheekMedeOpSchip/part:bedragRente/part:som" />
									<xsl:with-param name="valuta" select="tia:partnerSpecifiek/part:AanvullendeKosten/part:HypotheekMedeOpSchip/part:bedragRente/part:valuta" />
								</xsl:call-template>
								<xsl:text> met dien verstande dat het hypotheekrecht slechts mede tot zekerheid voor de rente strekt voor zover deze is vervallen gedurende de laatste drie jaren voorafgaand aan het begin van de uitwinning van het onderpand, alsmede voor de rente gedurende de loop van de uitwinning van het onderpand,</xsl:text>
							</td>
						</tr>
					</xsl:when>
				</xsl:choose>
			</tbody>
		</table>
		<!-- Total costs -->
		<p>
			<xsl:text>derhalve tot een totaalbedrag van </xsl:text>
			<xsl:choose>
				<xsl:when test="tia:partnerSpecifiek/part:AanvullendeKosten/part:RegistergoedGeenSchip">
					<xsl:call-template name="amountText">
						<xsl:with-param name="amount" select="tia:partnerSpecifiek/part:AanvullendeKosten/part:RegistergoedGeenSchip/part:bedragTotaal/part:som" />
						<xsl:with-param name="valuta" select="tia:partnerSpecifiek/part:AanvullendeKosten/part:RegistergoedGeenSchip/part:bedragTotaal/part:valuta" />
					</xsl:call-template>
					<xsl:text> </xsl:text>
					<xsl:call-template name="amountNumber">
						<xsl:with-param name="amount" select="tia:partnerSpecifiek/part:AanvullendeKosten/part:RegistergoedGeenSchip/part:bedragTotaal/part:som" />
						<xsl:with-param name="valuta" select="tia:partnerSpecifiek/part:AanvullendeKosten/part:RegistergoedGeenSchip/part:bedragTotaal/part:valuta" />
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="tia:partnerSpecifiek/part:AanvullendeKosten/part:HypotheekMedeOpSchip">
					<xsl:call-template name="amountText">
						<xsl:with-param name="amount" select="tia:partnerSpecifiek/part:AanvullendeKosten/part:HypotheekMedeOpSchip/part:bedragTotaal/part:som" />
						<xsl:with-param name="valuta" select="tia:partnerSpecifiek/part:AanvullendeKosten/part:HypotheekMedeOpSchip/part:bedragTotaal/part:valuta" />
					</xsl:call-template>
					<xsl:text> </xsl:text>
					<xsl:call-template name="amountNumber">
						<xsl:with-param name="amount" select="tia:partnerSpecifiek/part:AanvullendeKosten/part:HypotheekMedeOpSchip/part:bedragTotaal/part:som" />
						<xsl:with-param name="valuta" select="tia:partnerSpecifiek/part:AanvullendeKosten/part:HypotheekMedeOpSchip/part:bedragTotaal/part:valuta" />
					</xsl:call-template>
				</xsl:when>
			</xsl:choose>
			<xsl:text>, op:</xsl:text>
		</p>
		<!-- Registered objects -->
		<a name="hyp3.rights" class="location">&#160;</a>
		<h2 class="header"><xsl:text>Onderpand</xsl:text></h2>
		<xsl:choose>
			<!-- Only one registered object -->
			<xsl:when test="count(tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht) = 1">
				<p>
					<xsl:variable name="rightText">
						<xsl:apply-templates select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht" mode="do-right"/>
					</xsl:variable>
					<xsl:if test="normalize-space($rightText) != ''">
						<xsl:value-of select="$rightText"/>
						<xsl:text> </xsl:text>
					</xsl:if>
					<xsl:apply-templates select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht" mode="do-registered-object"/>
					<xsl:text>;</xsl:text>
					<br/>
					<xsl:text>hierna te noemen: '</xsl:text>
					<u><xsl:text>het onderpand</xsl:text></u>
					<xsl:text>'.</xsl:text>
				</p>
			</xsl:when>
			<!-- Multiple registered objects, all parcels with same data -->
			<xsl:when test="count(tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht)
					= count(tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht[
						((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen']/tia:tekst
								= current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen']/tia:tekst)
							or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen'])
								and not(current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen'])))
						and tia:aardVerkregen = current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:aardVerkregen
						and normalize-space(tia:aardVerkregen) != ''
						and ((tia:tia_Aantal_BP_Rechten
								= current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_Aantal_BP_Rechten)
							or (not(tia:tia_Aantal_BP_Rechten)
								and not(current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_Aantal_BP_Rechten)))
						and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven']/tia:tekst
								= current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven']/tia:tekst)
							or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven'])
								and not(current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven'])))
						and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom']/tia:tekst
								= current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom']/tia:tekst)
							or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom'])
								and not(current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom'])))
						and tia:IMKAD_Perceel[
							tia:tia_OmschrijvingEigendom
								= current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_OmschrijvingEigendom
							and normalize-space(tia:tia_OmschrijvingEigendom) != ''
							and ((tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid']/tia:tekst
									= current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid']/tia:tekst)
								or (not(tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid'])
									and not(current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid'])))
							and ((tia:tia_SplitsingsverzoekOrdernummer
									= current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_SplitsingsverzoekOrdernummer)
								or (not(tia:tia_SplitsingsverzoekOrdernummer)
									and not(current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_SplitsingsverzoekOrdernummer)))
							and tia:kadastraleAanduiding/tia:gemeente
								= current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:kadastraleAanduiding/tia:gemeente
							and normalize-space(tia:kadastraleAanduiding/tia:gemeente) != ''
							and tia:kadastraleAanduiding/tia:sectie
								= current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:kadastraleAanduiding/tia:sectie
							and normalize-space(tia:kadastraleAanduiding/tia:sectie) != ''
							and tia:IMKAD_OZLocatie/tia:ligging
								= current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:ligging
							and normalize-space(tia:IMKAD_OZLocatie/tia:ligging) != ''
							and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer
								= current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer)
								or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer)
									and not(current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer)))
							and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter
									= current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter)
								or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter)
									and not(current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter)))
							and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging
									= current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging)
								or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging)
									and not(current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging)))
							and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode
									= current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode)
								or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode)
									and not(current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode)))
							and tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam
								= current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam
							and normalize-space(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam) != ''
							and tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam
								= current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam
							and normalize-space(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam) != '']])">
				<p>
					<xsl:variable name="rightText">
						<xsl:apply-templates select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht[1]" mode="do-right"/>
					</xsl:variable>
					<xsl:if test="normalize-space($rightText) != ''">
						<xsl:value-of select="$rightText"/>
						<xsl:text> </xsl:text>
					</xsl:if>
					<xsl:apply-templates select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht[1]" mode="do-registered-object"/>
					<xsl:text>;</xsl:text>
					<br/>
					<xsl:text>hierna zowel samen als ieder afzonderlijk te noemen: '</xsl:text>
					<u><xsl:text>het onderpand</xsl:text></u>
					<xsl:text>'.</xsl:text>
				</p>
			</xsl:when>
			<xsl:otherwise>
				<table cellpadding="0" cellspacing="0">
					<tbody>
						<xsl:call-template name="processRights">
							<xsl:with-param name="positionOfProcessedRight" select="1"/>
							<xsl:with-param name="position" select="1"/>
							<xsl:with-param name="registeredObjects" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']"/>
						</xsl:call-template>
					</tbody>
				</table>
				<p>
					<xsl:text>hierna zowel samen als ieder afzonderlijk te noemen: '</xsl:text>
					<u><xsl:text>het onderpand</xsl:text></u>
					<xsl:text>'.</xsl:text>									
				</p>
			</xsl:otherwise>
		</xsl:choose>
		<!-- Bridging mortgage -->
		<xsl:apply-templates select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[translate(tia:aanduidingHypotheek, $upper, $lower) = 'overbruggingshypotheek']" mode="do-bridging-mortgage"/>
		<xsl:if test="not(tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[translate(tia:aanduidingHypotheek, $upper, $lower) = 'overbruggingshypotheek'])">
			<a name="hyp3.bridgingMortgage" class="location">&#160;</a>
		</xsl:if>
		<!-- Closure -->
		<p>
			<xsl:text>De </xsl:text>
			<xsl:value-of select="$partyTwoName"/>
			<xsl:text> verklaarde het vorenstaande aan te nemen.</xsl:text>
		</p>
		<h2 class="header"><xsl:text>Opzegging</xsl:text></h2>
		<p>
			<xsl:text>De </xsl:text>
			 <xsl:value-of select="$partyOneName"/>
			<xsl:text> en de </xsl:text>
			<xsl:value-of select="$partyTwoName"/>
			<xsl:text> verklaarden dat de </xsl:text>
			<xsl:value-of select="$partyTwoName"/>
			<xsl:text> door opzegging de aan haar verleende hypotheek- en pandrechten geheel of gedeeltelijk kan be&#x00eb;indigen.</xsl:text>
		</p>
		<!-- Election of domicile -->
		<xsl:variable name="woonplaatskeuze" select="tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_woonplaatskeuze']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_woonplaatskeuze']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space(current()/tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_woonplaatskeuze']/tia:tekst), $upper, $lower)]), $upper, $lower)]" />
		<a name="hyp3.electionOfDomicile" class="location">&#160;</a>
		<xsl:if test="$woonplaatskeuze != ''">
			<h2 class="header"><u><xsl:text>Woonplaatskeuze</xsl:text></u></h2>
			<p><xsl:value-of select="$woonplaatskeuze"/></p>
		</xsl:if>
		<h3><xsl:text>EINDE KADASTERDEEL</xsl:text></h3>
		<!-- Free text part -->
		<a name="hyp3.part2" class="location">&#160;</a>
		<xsl:apply-templates select="tia:IMKAD_AangebodenStuk/tia:tia_TekstTweedeDeel" mode="do-free-text"/>
	</xsl:template>

	<!--
	*********************************************************
	Mode: do-parties
	*********************************************************
	Public: no

	Identity transform: no

	Description: Private mortgage deed parties.

	Input: tia:Partij

	Params: none

	Output: XHTML structure

	Calls:
	(mode) do-legal-representative
	(mode) do-party-person
	(mode) do-mortgage-deed-party-name

	Called by:
	(mode) do-deed
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:Partij" mode="do-parties">
		<xsl:variable name="numberOfPersonsInFirstParty" select="count(../tia:Partij[1]/tia:IMKAD_Persoon)"/>
		<xsl:variable name="numberOfPersonsInSecondParty" select="count(../tia:Partij[2]/tia:IMKAD_Persoon)"/>
		<xsl:variable name="numberOfPersonPairsInFirstParty" select="count(../tia:Partij[1]/tia:IMKAD_Persoon[tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene]/tia:GerelateerdPersoon[tia:rol])"/>
		<xsl:variable name="numberOfPersonPairsInSecondParty" select="count(../tia:Partij[2]/tia:IMKAD_Persoon[tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene]/tia:GerelateerdPersoon[tia:rol])"/>
		<xsl:variable name="numberOfPersons" select="count(tia:IMKAD_Persoon)
			+ count(tia:IMKAD_Persoon/tia:GerelateerdPersoon[translate(tia:tia_IndPartij, $upper, $lower) = 'true'])"/>
		<xsl:variable name="colspan">
			<xsl:choose>
				<xsl:when test="($numberOfPersonsInFirstParty > 1 and $numberOfPersonPairsInFirstParty >= 1) or
					($numberOfPersonsInSecondParty > 1 and $numberOfPersonPairsInSecondParty >= 1)">
					<xsl:text>3</xsl:text>
				</xsl:when>
				<xsl:when test="($numberOfPersonsInFirstParty = 1 and $numberOfPersonPairsInFirstParty = 1) or
					($numberOfPersonsInSecondParty = 1 and $numberOfPersonPairsInSecondParty = 1) or
					$numberOfPersonsInFirstParty > 1 or $numberOfPersonsInSecondParty > 1">
					<xsl:text>2</xsl:text>
				</xsl:when>
			</xsl:choose>
		</xsl:variable>
		
		<xsl:if test="tia:Gevolmachtigde">
			<tr>
				<td class="number" valign="top">
					<a name="{@id}" class="location" style="_position: relative;">&#xFEFF;</a>
					<xsl:value-of select="count(preceding-sibling::tia:Partij) + 1"/>
					<xsl:text>.</xsl:text>
				</td>
				<td>
					<xsl:if test="$colspan != ''">
						<xsl:attribute name="colspan">
							<xsl:value-of select="$colspan"/>
						</xsl:attribute>
					</xsl:if>
					<xsl:apply-templates select="tia:Gevolmachtigde" mode="do-legal-representative"/>
				</td>
			</tr>
		</xsl:if>
		<xsl:choose>
			<!-- If only one person pair is present do not create list -->
			<xsl:when test="tia:IMKAD_Persoon[(tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene)
						and tia:GerelateerdPersoon[tia:rol]]
					and not(count(tia:IMKAD_Persoon) > 1)">
				<xsl:apply-templates select="tia:IMKAD_Persoon" mode="do-party-person">
					<xsl:with-param name="maxColspan" select="$colspan"/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:when test="count(tia:IMKAD_Persoon) = 1">
				<xsl:apply-templates select="tia:IMKAD_Persoon" mode="do-party-person">
					<xsl:with-param name="maxColspan" select="$colspan"/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:otherwise>
				<xsl:for-each select="tia:IMKAD_Persoon">
					<xsl:apply-templates select="." mode="do-party-person">
						<xsl:with-param name="maxColspan" select="$colspan"/>
					</xsl:apply-templates>
				</xsl:for-each>
			</xsl:otherwise>
		</xsl:choose>
		<tr>	
			<td class="number" valign="top">
				<xsl:text>&#xFEFF;</xsl:text>
			</td>
			<td>
				<xsl:if test="$colspan != ''">
					<xsl:attribute name="colspan">
						<xsl:value-of select="$colspan"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:choose>
					<xsl:when test="@id = substring-after(../tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:vervreemderRechtRef/@xlink:href, '#')">
						<xsl:apply-templates select="." mode="do-mortgage-deed-party-name"/>
						<br/>
						<xsl:text>en</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>hierna </xsl:text>
						<xsl:if test="$numberOfPersons > 1">
							<xsl:text>zowel tezamen als ieder afzonderlijk </xsl:text>
						</xsl:if>
						<xsl:text>te noemen: '</xsl:text>
						<u>
							<xsl:text>de </xsl:text>
							<xsl:value-of select="tia:aanduidingPartij"/>
						</u>
						<xsl:text>'.</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</td>
		</tr>
	</xsl:template>

	<!--
	*********************************************************
	Mode: do-party-person
	*********************************************************
	Public: no

	Identity transform: no

	Description: Private mortgage deed party persons.

	Input: tia:IMKAD_Persoon

	Params: maxColspan - maximal colspan in table

	Output: XHTML structure

	Calls:
	(mode) do-party-natural-person
	(mode) do-party-legal-person

	Called by:
	(mode) do-parties
	-->

	<!--
	**** matching template ********************************************************************************
	****   NATURAL PERSON  ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon[(tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene) and not(tia:GerelateerdPersoon)]" mode="do-party-person">
		<xsl:param name="maxColspan" select="number('0')"/>
		
		<xsl:apply-templates select="." mode="do-party-natural-person">
			<xsl:with-param name="maxColspan" select="$maxColspan"/>
		</xsl:apply-templates>
	</xsl:template>

	<!--
	****   matching template ******************************************************************************
	**** NATURAL PERSON PAIR ******************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon[(tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene) and tia:GerelateerdPersoon]" mode="do-party-person">
		<xsl:param name="maxColspan" select="number('0')"/>
		
		<xsl:apply-templates select="." mode="do-party-natural-person">
			<xsl:with-param name="maxColspan" select="$maxColspan"/>
		</xsl:apply-templates>
	</xsl:template>

	<!--
	**** matching template ********************************************************************************
	****    LEGAL PERSON   ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon[tia:tia_Gegevens/tia:NHR_Rechtspersoon]" mode="do-party-person">
		<xsl:param name="maxColspan" select="number('0')"/>
		
		<xsl:apply-templates select="." mode="do-party-legal-person">	
			<xsl:with-param name="maxColspan" select="$maxColspan"/>
		</xsl:apply-templates>
	</xsl:template>
	
	<!--
	*********************************************************
	Mode: do-contract-of-sale
	*********************************************************
	Public: no

	Identity transform: no

	Description: Contract of sale text block.

	Input: tia:IMKAD_AangebodenStuk

	Params: none

	Output: XHTML structure

	Calls:
	none

	Called by:
	(mode) do-deed
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_AangebodenStuk" mode="do-contract-of-sale">
		<h2 class="header"><xsl:text>Overeenkomst tot het vestigen van hypotheek- en pandrechten</xsl:text></h2>
		<p>
			<xsl:text>De </xsl:text>
			<xsl:value-of select="$partyOneName"/>
			<xsl:text> en de </xsl:text>
			<xsl:value-of select="$partyTwoName"/>
			<xsl:text> verklaarden te zijn overeengekomen dat door de </xsl:text>
			<xsl:value-of select="$partyOneName"/>
			<xsl:text> ten behoeve van de </xsl:text>
			<xsl:value-of select="$partyTwoName"/>
			<xsl:text> het recht van hypotheek en pandrechten worden gevestigd op de in deze akte omschreven goederen, tot zekerheid als in deze akte omschreven.</xsl:text>
		</p>
	</xsl:template>
	
	<!--
	*********************************************************
	Mode: do-mortgage-provision
	*********************************************************
	Public: no

	Identity transform: no

	Description: Mortgage provision text block.

	Input: tia:IMKAD_AangebodenStuk

	Params: none

	Output: XHTML structure

	Calls:
	none

	Called by:
	(mode) do-deed
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_AangebodenStuk" mode="do-mortgage-provision">
		<h2 class="header"><xsl:text>Hypotheekverlening</xsl:text></h2>
		<p>
			<xsl:text>Ter uitvoering van voormelde overeenkomst verklaarde de </xsl:text>
			<xsl:value-of select="$partyOneName"/>
			<xsl:text> aan de </xsl:text>
			<xsl:value-of select="$partyTwoName"/>
			<xsl:text> hypotheek te verlenen tot het hierna te noemen bedrag op het hierna te noemen onderpand, tot zekerheid voor de betaling van al hetgeen de </xsl:text>
			<xsl:value-of select="$partyTwoName"/>
			<xsl:text> blijkens haar administratie van de hierna te noemen debiteur,</xsl:text>
			<xsl:if test="translate(normalize-space(tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_iederafzonderlijk']/tia:tekst), $upper, $lower) = translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_iederafzonderlijk']/tia:tekst), $upper, $lower)">
				<xsl:text> </xsl:text>	
				<xsl:value-of select="normalize-space(tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_iederafzonderlijk']/tia:tekst)"/>
				<xsl:text>,</xsl:text>
			</xsl:if>
			<xsl:text> te vorderen heeft of mocht hebben uit hoofde van:</xsl:text>
		</p>
	</xsl:template>
	
	<!--
	*********************************************************
	Mode: do-natural-person-part
	*********************************************************
	Public: no

	Identity transform: no

	Description: Natural person text block (Particuliere hypotheek stylesheet).

	Input: part:IMKAD_Persoon

	Params: none

	Output: text

	Calls:
	(mode) do-gender-salutation-part
	(mode) do-person-data-part
	(mode) do-birth-data-part

	Called by:
	(mode) do-deed
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="part:IMKAD_Persoon" mode="do-natural-person-part">
		<xsl:apply-templates select="part:tia_Gegevens[1]/part:GBA_Ingezetene | part:tia_Gegevens[1]/part:IMKAD_NietIngezetene" mode="do-gender-salutation-part" />
		<xsl:text> </xsl:text>
		<xsl:choose>
			<xsl:when test="part:tia_Gegevens[2]/part:IMKAD_KadNatuurlijkPersoon">
				<xsl:apply-templates select="part:tia_Gegevens[2]/part:IMKAD_KadNatuurlijkPersoon" mode="do-person-data-part" />
				<xsl:text>, bij de gemeentelijke basisregistratie bekend als </xsl:text>
				<xsl:apply-templates select="part:tia_Gegevens[1]/part:GBA_Ingezetene" mode="do-person-data-part" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="part:tia_Gegevens[1]/part:GBA_Ingezetene | part:tia_Gegevens[1]/part:IMKAD_NietIngezetene" mode="do-person-data-part" />
			</xsl:otherwise>
		</xsl:choose>
		<xsl:text>, </xsl:text>
		<xsl:apply-templates select="part:tia_Gegevens[1]/part:GBA_Ingezetene | part:tia_Gegevens[1]/part:IMKAD_NietIngezetene" mode="do-birth-data-part" />
	</xsl:template>
	
	<!--
	*********************************************************
	Mode: do-person-data-part
	*********************************************************
	Public: no

	Identity transform: no

	Description: Basic data regarding natural person (Particuliere hypotheek stylesheet).

	Input: part:GBA_Ingezetene, part:IMKAD_NietIngezetene or part:IMKAD_KadNatuurlijkPersoon

	Params: none

	Output: text

	Calls:
	none

	Called by:
	(mode) do-natural-person-part
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="part:GBA_Ingezetene | part:IMKAD_NietIngezetene | part:IMKAD_KadNatuurlijkPersoon" mode="do-person-data-part">
		<xsl:if test="part:tia_TekstKeuze[translate(part:tagNaam, $upper, $lower) = 'k_professor']/part:tekst[translate(normalize-space(.), $upper, $lower) = 
				translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_professor']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
				translate(normalize-space(current()/part:tia_TekstKeuze[translate(part:tagNaam, $upper, $lower) = 'k_professor']/part:tekst), $upper, $lower)]), $upper, $lower)]">
			<xsl:value-of select="part:tia_TekstKeuze[translate(part:tagNaam, $upper, $lower) = 'k_professor']/part:tekst[translate(normalize-space(.), $upper, $lower) = 
					translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_professor']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
					translate(normalize-space(current()/part:tia_TekstKeuze[translate(part:tagNaam, $upper, $lower) = 'k_professor']/part:tekst), $upper, $lower)]), $upper, $lower)]"/>
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:if test="(part:tia_AdellijkeTitel or part:adellijkeTitelOfPredikaat) and (normalize-space(part:tia_AdellijkeTitel) != '' or normalize-space(part:adellijkeTitelOfPredikaat) != '')">
			<xsl:value-of select="part:tia_AdellijkeTitel | part:adellijkeTitelOfPredikaat"/>
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:if test="part:tia_Titel and normalize-space(part:tia_Titel) != ''">
			<xsl:value-of select="part:tia_Titel"/>
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:value-of select="part:naam/part:voornamen | part:voornamen"/>
		<xsl:text> </xsl:text>
		<xsl:if test="part:tia_AdellijkeTitel2 and normalize-space(part:tia_AdellijkeTitel2) != ''">
			<xsl:value-of select="part:tia_AdellijkeTitel2"/>
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:if test="(part:tia_VoorvoegselsNaam or part:voorvoegsels or part:voorvoegselsgeslachtsnaam)
				and normalize-space(part:tia_VoorvoegselsNaam | part:voorvoegsels | part:voorvoegselsgeslachtsnaam) != ''">
			<xsl:value-of select="part:tia_VoorvoegselsNaam | part:voorvoegsels | part:voorvoegselsgeslachtsnaam"/>
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:value-of select="part:tia_NaamZonderVoorvoegsels | part:geslachtsnaam"/>
		<xsl:if test="part:tia_Titel2 and normalize-space(part:tia_Titel2) != ''">
			<xsl:text> </xsl:text>
			<xsl:value-of select="part:tia_Titel2"/>
		</xsl:if>
	</xsl:template>

	<!--
	*********************************************************
	Mode: do-gender-salutation-part
	*********************************************************
	Public: no

	Identity transform: no

	Description: Gender salutation for natural person (Particuliere hypotheek stylesheet).

	Input: part:GBA_Ingezetene or part:IMKAD_NietIngezetene

	Params: none

	Output: text

	Calls:
	none

	Called by:
	(mode) do-natural-person-part
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="part:GBA_Ingezetene | part:IMKAD_NietIngezetene" mode="do-gender-salutation-part">
		<xsl:choose>
			<xsl:when test="translate(part:geslacht/part:geslachtsaanduiding, $upper, $lower) = 'man' or translate(part:geslacht, $upper, $lower) = 'man'">
				<xsl:text>de heer</xsl:text>
			</xsl:when>
			<xsl:when test="translate(part:geslacht/part:geslachtsaanduiding, $upper, $lower) = 'vrouw' or translate(part:geslacht, $upper, $lower) = 'vrouw'">
				<xsl:text>mevrouw</xsl:text>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<!--
	*********************************************************
	Mode: do-birth-data-part
	*********************************************************
	Public: no

	Identity transform: no

	Description: Birth data regarding natural person (Particuliere hypotheek stylesheet).

	Input: part:GBA_Ingezetene or part:IMKAD_NietIngezetene

	Params: none

	Output: text

	Calls:
	none

	Called by:
	(mode) do-natural-person-part
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="part:GBA_Ingezetene | part:IMKAD_NietIngezetene" mode="do-birth-data-part">
		<xsl:variable name="Datum_DATE" select="substring(string(part:geboorte/part:geboortedatum
			| part:geboortedatum), 0, 11)"/>
		<xsl:variable name="Datum_STRING">
			<xsl:if test="$Datum_DATE != ''">
				<xsl:value-of select="kef:convertDateToText($Datum_DATE)"/>
			</xsl:if>
		</xsl:variable>
		<xsl:text>geboren te </xsl:text>
		<xsl:value-of select="part:geboorte/part:geboorteplaatsOmschrijving | part:geboorteplaats"/>
		<xsl:text> op </xsl:text>
		<xsl:value-of select="$Datum_STRING"/>
	</xsl:template>
	
	<!--
	*********************************************************
	Mode: do-address-part
	*********************************************************
	Public: no

	Identity transform: no

	Description: Address text block (Particuliere hypotheek stylesheet).

	Input: part:IMKAD_WoonlocatiePersoon, part:binnenlandsAdres, part:buitenlandsAdres

	Params: none

	Output: text

	Calls:
	none

	Called by:
	(mode) do-deed
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="part:IMKAD_WoonlocatiePersoon" mode="do-address-part">
		<xsl:apply-templates select="part:adres/part:binnenlandsAdres | part:adres/part:buitenlandsAdres" mode="do-address-part"/>
	</xsl:template>

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="part:binnenlandsAdres" mode="do-address-part">
		<!-- Insert space between numbers and letters of post code -->
		<xsl:value-of select="concat(normalize-space(substring(part:BAG_NummerAanduiding/part:postcode, 1, 4)), ' ',
			normalize-space(substring(part:BAG_NummerAanduiding/part:postcode, 5)))"/>
		<xsl:text> </xsl:text>
		<xsl:value-of select="part:BAG_Woonplaats/part:woonplaatsNaam"/>
		<xsl:text>, </xsl:text>
		<xsl:value-of select="part:BAG_OpenbareRuimte/part:openbareRuimteNaam"/>
		<xsl:text> </xsl:text>
		<xsl:value-of select="part:BAG_NummerAanduiding/part:huisnummer"/>
		<xsl:if test="part:BAG_NummerAanduiding/part:huisletter
				and normalize-space(part:BAG_NummerAanduiding/part:huisletter) != ''">
			<xsl:text> </xsl:text>
			<xsl:value-of select="part:BAG_NummerAanduiding/part:huisletter"/>
		</xsl:if>
		<xsl:if test="part:BAG_NummerAanduiding/part:huisnummertoevoeging
				and normalize-space(part:BAG_NummerAanduiding/part:huisnummertoevoeging) != ''">
			<xsl:text> </xsl:text>
			<xsl:value-of select="part:BAG_NummerAanduiding/part:huisnummertoevoeging"/>
		</xsl:if>
	</xsl:template>

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="part:buitenlandsAdres" mode="do-address-part">
		<xsl:value-of select="part:woonplaats"/>
		<xsl:text>, </xsl:text>
		<xsl:value-of select="part:adres"/>
		<xsl:text> </xsl:text>
		<xsl:if test="part:regio and normalize-space(part:regio) != ''">
			<xsl:value-of select="part:regio"/>
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:value-of select="part:land"/>
	</xsl:template>
	
</xsl:stylesheet>
