<?xml version="1.0" encoding="UTF-8"?>
<!--
*********************************************************
Stylesheet: hypotheek_ing.xsl
Version: 1.19
*********************************************************
Description:
ING mortgage deed.

Public:
(mode) do-deed

Private:
(mode) do-parties
(mode) do-party-person
-->
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
	xmlns:tia="http://www.kadaster.nl/schemas/KIK/TIA_Algemeen"
	xmlns:xlink="http://www.w3.org/1999/xlink"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	exclude-result-prefixes="tia xsl xlink"
	version="1.0">

	<xsl:include href="generiek-1.08.xsl"/>
	<xsl:include href="tekstblok_aanhef-1.05.xsl"/>
	<xsl:include href="tekstblok_equivalentieverklaring-1.09.02.xsl"/>
	<xsl:include href="tekstblok_gevolmachtigde-1.09.xsl"/>
	<xsl:include href="tekstblok_legitimatie-1.01.xsl"/>
	<xsl:include href="tekstblok_natuurlijk_persoon-1.09.xsl"/>
	<xsl:include href="tekstblok_overbruggingshypotheek-1.05.xsl"/>
	<xsl:include href="tekstblok_personalia_van_natuurlijk_persoon-1.05.xsl"/>
	<xsl:include href="tekstblok_partij_natuurlijk_persoon-1.10.xsl"/>
	<xsl:include href="tekstblok_partij_niet_natuurlijk_persoon-1.10.xsl"/>
	<xsl:include href="tekstblok_partijnamen_in_hypotheekakten-1.03.xsl"/>
	<xsl:include href="tekstblok_recht-1.05.xsl"/>
	<xsl:include href="tekstblok_rechtspersoon-1.07.xsl"/>
	<xsl:include href="tekstblok_registergoed-1.14.xsl"/>
	<xsl:include href="tekstblok_woonadres-1.04.xsl"/>
	<xsl:include href="tweededeel-1.05.xsl"/>

	<!-- ING specific global variables -->
	<xsl:variable name="keuzeteksten" select="document('keuzeteksten_hypotheek_ing-1.05.xml')"/>
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
			<xsl:otherwise><xsl:text>ING Hypotheek</xsl:text></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<!--
	*********************************************************
	Mode: do-deed
	*********************************************************
	Public: yes

	Identity transform: no

	Description: ING mortgage deed.

	Input: tia:Bericht_TIA_Stuk

	Params: none

	Output: XHTML structure

	Calls:
	(mode) do-statement-of-equivalence
	(mode) do-header
	(mode) do-parties
	(mode) do-right
	(mode) do-registered-object
	(mode) do-bridging-mortgage
	(mode) do-free-text
	(name) amountText
	(name) amountNumber
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
		<xsl:if test="normalize-space($documentTitle) != '' and translate($documentTitle, $upper, $lower) != 'ing hypotheek'">
			<p style="text-align:center" title="without_dashes"><xsl:value-of select="$documentTitle"/></p>
			<!-- Empty line after title -->
			<p title="without_dashes"><br/></p>
		</xsl:if>
		<!-- Offertenummer -->
		<xsl:if test="tia:IMKAD_AangebodenStuk/tia:tia_OmschrijvingKenmerk
				and normalize-space(tia:IMKAD_AangebodenStuk/tia:tia_OmschrijvingKenmerk) != ''">
			<p title="without_dashes">
				<xsl:text>Offertenummer: </xsl:text>
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
			<xsl:text>Van gemelde mondelinge volmacht(en) is mij, notaris genoegzaam gebleken.</xsl:text>
		</p>
		<!-- Contract of sale -->
		<h3><xsl:text>OVEREENKOMST</xsl:text></h3>
		<p>
			<xsl:choose>
				<xsl:when test="translate(tia:IMKAD_AangebodenStuk/tia:Partij/tia:Partij[3]/tia:aanduidingPartij, $upper, $lower) = 'de stichting'">
					<xsl:text>De comparanten, handelend als voormeld, verklaarden dat de Hypotheekgever en de Bank in de Offerte zijn overeengekomen en dat door de Hypotheekgever en de Stichting bij deze is overeengekomen dat door de Hypotheekgever ten behoeve van de Bank en de Stichting het recht van hypotheek en pandrechten worden gevestigd op de in deze akte en de Algemene Voorwaarden ING Hypotheken omschreven goederen, tot zekerheid als in deze akte omschreven.</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>De comparanten, handelend als voormeld, verklaarden dat de Hypotheekgever en de Bank in de Offerte zijn overeengekomen dat door de Hypotheekgever ten behoeve van de Bank het recht van hypotheek en pandrechten worden gevestigd op de in deze akte en de Algemene Voorwaarden ING Hypotheken omschreven goederen, tot zekerheid als in deze akte omschreven.</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</p>
		<!-- Election of domicile -->
		<xsl:variable name="woonplaatskeuze" select="tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_woonplaatskeuze']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_woonplaatskeuze']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space(current()/tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_woonplaatskeuze']/tia:tekst), $upper, $lower)]), $upper, $lower)]" />
		<a name="hyp3.electionOfDomicile" class="location">&#160;</a>
		<xsl:if test="$woonplaatskeuze != ''">
			<h3><xsl:text>WOONPLAATSKEUZE</xsl:text></h3>
			<p><xsl:value-of select="$woonplaatskeuze"/></p>
		</xsl:if>
		<!-- Mortgage charges -->
		<a name="hyp3.mortgageAmountAndAdditionalCosts" class="location">&#160;</a>
		<h3><xsl:text>HYPOTHEEKSTELLING</xsl:text></h3>
		<p>
			<xsl:text>Ter uitvoerlegging van hetgeen in de Offerte is overeengekomen verleent de Hypotheekgever tot zekerheid voor de betaling van:</xsl:text>
		</p>
		<!-- Mortgage Amount -->
		<p><u><xsl:text>Hypotheekbedrag</xsl:text></u></p>
		<table cellpadding="0" cellspacing="0">
			<tbody>
				<tr>
					<td class="number" valign="top">
						<xsl:text>a.</xsl:text>
					</td>
					<td>
				<xsl:text>Het Verschuldigde, een en ander tot maximaal </xsl:text>
				<xsl:call-template name="amountText">
					<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:hoofdsom/tia:som" />
					<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:hoofdsom/tia:valuta" />
				</xsl:call-template>
				<xsl:text> </xsl:text>
				<xsl:call-template name="amountNumber">
					<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:hoofdsom/tia:som" />
					<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:hoofdsom/tia:valuta" />
				</xsl:call-template>
				<xsl:text>;</xsl:text>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>b.</xsl:text>
					</td>
					<td>
						<xsl:choose>
							<xsl:when test="translate(tia:IMKAD_AangebodenStuk/tia:Partij/tia:Partij[3]/tia:aanduidingPartij, $upper, $lower) = 'de stichting'">
								<xsl:text>Al wat de Bank en de Stichting uit welken hoofde ook in verband met het vorenstaande aan renten, boeten, kosten en premies of anderszins te vorderen hebben, tot een maximum van vijfendertig procent (35%) van al hetgeen ingevolge sub a verschuldigd is, zijnde </xsl:text>
								<xsl:call-template name="amountText">
									<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragRente/tia:som" />
									<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragRente/tia:valuta" />
								</xsl:call-template>
								<xsl:text> </xsl:text>
								<xsl:call-template name="amountNumber">
									<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragRente/tia:som" />
									<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragRente/tia:valuta" />
								</xsl:call-template>
								<xsl:text> in totaal </xsl:text>
								<xsl:call-template name="amountText">
									<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragTotaal/tia:som" />
									<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragTotaal/tia:valuta" />
								</xsl:call-template>
								<xsl:text> </xsl:text>
								<xsl:call-template name="amountNumber">
									<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragTotaal/tia:som" />
									<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragTotaal/tia:valuta" />
								</xsl:call-template>
								<xsl:text> bij deze aan de Bank en de Stichting recht van hypotheek op het Onderpand met de daaraan te eniger tijd aangebrachte veranderingen en toevoegingen:</xsl:text>
							</xsl:when>
							<xsl:otherwise>
								<xsl:text>Al wat de Bank uit welken hoofde ook in verband met het vorenstaande aan renten, boeten, kosten en premies of anderszins te vorderen heeft, tot een maximum van vijfendertig procent (35%) van al hetgeen ingevolge sub a verschuldigd is, zijnde </xsl:text>
								<xsl:call-template name="amountText">
									<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragRente/tia:som" />
									<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragRente/tia:valuta" />
								</xsl:call-template>
								<xsl:text> </xsl:text>
								<xsl:call-template name="amountNumber">
									<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragRente/tia:som" />
									<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragRente/tia:valuta" />
								</xsl:call-template>
								<xsl:text> in totaal </xsl:text>
								<xsl:call-template name="amountText">
									<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragTotaal/tia:som" />
									<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragTotaal/tia:valuta" />
								</xsl:call-template>
								<xsl:text> </xsl:text>
								<xsl:call-template name="amountNumber">
									<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragTotaal/tia:som" />
									<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragTotaal/tia:valuta" />
								</xsl:call-template>
								<xsl:text> bij deze aan de Bank recht van hypotheek op het Onderpand met de daaraan te eniger tijd aangebrachte veranderingen en toevoegingen:</xsl:text>
							</xsl:otherwise>
						</xsl:choose>
					</td>
				</tr>
			</tbody>
		</table>
		<!-- Registered objects -->
		<a name="hyp3.rights" class="location">&#160;</a>
		<p><u><xsl:text>Onderpand</xsl:text></u></p>
		<xsl:choose>
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
					<xsl:text>in deze akte tezamen met de in de Algemene Voorwaarden ING Hypotheken omschreven roerende zaken te noemen: '</xsl:text>
					<u><xsl:text>het Onderpand</xsl:text></u>
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
					<xsl:text>in deze akte tezamen met de in de Algemene Voorwaarden ING Hypotheken omschreven roerende zaken te noemen: '</xsl:text>
					<u><xsl:text>het Onderpand</xsl:text></u>
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
					<xsl:text>in deze akte tezamen met de in de Algemene Voorwaarden ING Hypotheken omschreven roerende zaken te noemen: '</xsl:text>
					<u><xsl:text>het Onderpand</xsl:text></u>
					<xsl:text>'.</xsl:text>									
				</p>
			</xsl:otherwise>
		</xsl:choose>
		<!-- Closure -->
		<h3><xsl:text>AANNEMING</xsl:text></h3>
		<!-- Bridging mortgage -->
		<xsl:apply-templates select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[translate(tia:aanduidingHypotheek, $upper, $lower) = 'overbruggingshypotheek']" mode="do-bridging-mortgage"/>
		<xsl:if test="not(tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[translate(tia:aanduidingHypotheek, $upper, $lower) = 'overbruggingshypotheek'])">
			<a name="hyp3.bridgingMortgage" class="location">&#160;</a>
		</xsl:if>
		<p>
			<xsl:choose>
				<xsl:when test="translate(tia:IMKAD_AangebodenStuk/tia:Partij/tia:Partij[3]/tia:aanduidingPartij, $upper, $lower) = 'de stichting'">
					<xsl:text>De Bank en de Stichting verklaren bij deze de vorenstaande hypotheekverlening aan te nemen onder de voorwaarden als hierna bepaald.</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>De Bank verklaart bij deze de vorenstaande hypotheekverlening aan te nemen onder de voorwaarden als hierna bepaald.</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</p>
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

	Description: ING mortgage deed parties.

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
		<xsl:variable name="numberOfPersonPairsInFirstParty" select="count(../tia:Partij[1]/tia:IMKAD_Persoon[tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene]/tia:GerelateerdPersoon[tia:rol])"/>
		<xsl:variable name="numberOfPersonsInSecondParty" select="count(../tia:Partij[2]/tia:IMKAD_Persoon) + count(../tia:Partij[2]/tia:Partij[1]/tia:IMKAD_Persoon)"/>
		<xsl:variable name="numberOfPersonPairsInSecondParty" select="count(../tia:Partij[2]/tia:IMKAD_Persoon[tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene]/tia:GerelateerdPersoon[tia:rol])
			+ count(../tia:Partij[2]/tia:Partij[1]/tia:IMKAD_Persoon[tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene]/tia:GerelateerdPersoon[tia:rol])"/>
		<xsl:variable name="numberOfPersonsInThirdParty" select="count(../tia:Partij[2]/tia:Partij[2]/tia:IMKAD_Persoon)"/>
		<xsl:variable name="numberOfPersonPairsInThirdParty" select="count(../tia:Partij[2]/tia:Partij[2]/tia:IMKAD_Persoon[tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene]/tia:GerelateerdPersoon[tia:rol])"/>
		<xsl:variable name="numberOfPersonsInFourthParty" select="count(../tia:Partij[2]/tia:Partij[3]/tia:IMKAD_Persoon)"/>
		<xsl:variable name="numberOfPersonPairsInFourthParty" select="count(../tia:Partij[2]/tia:Partij[3]/tia:IMKAD_Persoon[tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene]/tia:GerelateerdPersoon[tia:rol])"/>
		<xsl:variable name="colspan">
			<xsl:choose>
				<xsl:when test="($numberOfPersonsInFirstParty > 1 and $numberOfPersonPairsInFirstParty >= 1) or
					($numberOfPersonsInSecondParty > 1 and $numberOfPersonPairsInSecondParty >= 1) or
					($numberOfPersonsInThirdParty > 1 and $numberOfPersonPairsInThirdParty >= 1) or 
					($numberOfPersonsInFourthParty > 1 and $numberOfPersonPairsInFourthParty >= 1)">
					<xsl:text>3</xsl:text>
				</xsl:when>
				<xsl:when test="($numberOfPersonsInFirstParty = 1 and $numberOfPersonPairsInFirstParty = 1) or
					($numberOfPersonsInSecondParty = 1 and $numberOfPersonPairsInSecondParty = 1) or
					($numberOfPersonsInThirdParty = 1 and $numberOfPersonPairsInThirdParty = 1) or
					($numberOfPersonsInFourthParty = 1 and $numberOfPersonPairsInFourthParty = 1) or
					$numberOfPersonsInFirstParty > 1 or ($numberOfPersonsInSecondParty > 1 and not(../tia:Partij/tia:Partij)) or ($numberOfPersonsInSecondParty >= 1 and ../tia:Partij/tia:Partij) or $numberOfPersonsInThirdParty >= 1 or $numberOfPersonsInFourthParty >= 1">
					<xsl:text>2</xsl:text>
				</xsl:when>
			</xsl:choose>
		</xsl:variable>
		
		<xsl:if test="tia:Gevolmachtigde">
			<tr>
				<td class="number" valign="top">
					<xsl:choose>
						<xsl:when test="tia:Partij">
							<a name="{tia:Partij[1]/@id}" class="location" style="_position: relative;">&#xFEFF;</a>
						</xsl:when>
						<xsl:otherwise>
							<a name="{@id}" class="location" style="_position: relative;">&#xFEFF;</a>
						</xsl:otherwise>
					</xsl:choose>
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
			<!-- Nested party -->
			<xsl:when test="tia:Partij">
				<xsl:for-each select="tia:Partij">
					<xsl:variable name="numberOfPersons" select="count(tia:IMKAD_Persoon) + count(tia:IMKAD_Persoon/tia:GerelateerdPersoon[translate(tia:tia_IndPartij, $upper, $lower) = 'true'])"/>
					<xsl:variable name="partyName">
						<xsl:choose>
							<xsl:when test="position() = 1">
								<xsl:text>de Bank</xsl:text>
							</xsl:when>
							<xsl:when test="position() = 2">
								<xsl:text>de Verzekeraar</xsl:text>
							</xsl:when>
							<xsl:when test="position() = 3">
								<xsl:text>de Stichting</xsl:text>
							</xsl:when>
						</xsl:choose>
					</xsl:variable>
					<xsl:variable name="start">
						<xsl:choose>
							<xsl:when test="position() = 2">
								<xsl:choose>
									<!-- Special case - only one person pair within previous party -->
									<xsl:when test="((preceding-sibling::tia:Partij/tia:IMKAD_Persoon/tia:tia_Gegevens/tia:GBA_Ingezetene or preceding-sibling::tia:Partij/tia:IMKAD_Persoon/tia:tia_Gegevens/tia:IMKAD_NietIngezetene)
														and preceding-sibling::tia:Partij/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:rol)
														and count(preceding-sibling::tia:Partij/tia:IMKAD_Persoon) = 1">
										<xsl:value-of select="3"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="count(preceding-sibling::tia:Partij/tia:IMKAD_Persoon) + 1"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:when>
							<xsl:when test="position() = 3">
								<!-- Count persons in de Bank (special case - only one person pair within de Bank) -->
								<xsl:variable name="numberOfPersonsInDeBank">
									<xsl:choose>
										<xsl:when test="count(../tia:Partij[1]/tia:IMKAD_Persoon) = 1 and ../tia:Partij[1]/tia:IMKAD_Persoon[(tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene) and tia:GerelateerdPersoon/tia:rol]">
											<xsl:value-of select="2"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="count(../tia:Partij[1]/tia:IMKAD_Persoon)"/>											
										</xsl:otherwise>
									</xsl:choose>
								</xsl:variable>
								<!-- Count persons in de Verzekeraar (special case - only one person pair within de Verzekeraar) -->
								<xsl:variable name="numberOfPersonsInDeVerzekeraar">
									<xsl:choose>
										<xsl:when test="count(../tia:Partij[2]/tia:IMKAD_Persoon) = 1 and ../tia:Partij[2]/tia:IMKAD_Persoon[(tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene) and tia:GerelateerdPersoon/tia:rol]">
											<xsl:value-of select="2"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="count(../tia:Partij[2]/tia:IMKAD_Persoon)"/>											
										</xsl:otherwise>
									</xsl:choose>
								</xsl:variable>
								<xsl:value-of select="$numberOfPersonsInDeBank + $numberOfPersonsInDeVerzekeraar + 1"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="0"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
					<xsl:variable name="position" select="position()"/>
					<xsl:variable name="anchorName">
						<xsl:choose>
							<xsl:when test="position() = 1">
								<xsl:text>party.2</xsl:text>
							</xsl:when>
							<xsl:when test="position() = 2">
								<xsl:text>hyp3.insurerPersons</xsl:text>
							</xsl:when>
							<xsl:when test="position() = 3">
								<xsl:text>hyp3.foundationPersons</xsl:text>
							</xsl:when>
						</xsl:choose>
					</xsl:variable>
					
					<xsl:for-each select="tia:IMKAD_Persoon">
						<xsl:apply-templates select="." mode="do-party-person">
							<xsl:with-param name="maxColspan" select="$colspan"/>
							<xsl:with-param name="start" select="$start"/>
							<xsl:with-param name="nestedParty" select="'true'"/>
							<xsl:with-param name="anchorName" select="$anchorName"/>
						</xsl:apply-templates>
					</xsl:for-each>
					
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
							<xsl:text>hierna </xsl:text>
							<xsl:if test="$numberOfPersons > 1">
								<xsl:text>zowel tezamen als ieder afzonderlijk </xsl:text>
							</xsl:if>
							<xsl:text>te noemen: '</xsl:text>
							<u><xsl:value-of select="$partyName"/></u>
							<xsl:text>'</xsl:text>
							<xsl:text>.</xsl:text>
						</td>
					</tr>
				</xsl:for-each>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="numberOfPersons" select="count(tia:IMKAD_Persoon) + count(tia:IMKAD_Persoon/tia:GerelateerdPersoon[translate(tia:tia_IndPartij, $upper, $lower) = 'true'])"/>
				<xsl:variable name="anchorName">
					<xsl:choose>
						<xsl:when test="position() = 1">
							<xsl:text>party.1</xsl:text>
						</xsl:when>
						<xsl:when test="position() = 2">
							<xsl:text>party.2</xsl:text>
						</xsl:when>
					</xsl:choose>
				</xsl:variable>
				
				<xsl:choose>
					<!-- If only one person pair is present do not create list -->
					<xsl:when test="tia:IMKAD_Persoon[(tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene)
								and tia:GerelateerdPersoon[tia:rol]]
							and not(count(tia:IMKAD_Persoon) > 1)">
						<xsl:apply-templates select="tia:IMKAD_Persoon" mode="do-party-person">
							<xsl:with-param name="maxColspan" select="$colspan"/>
							<xsl:with-param name="anchorName" select="$anchorName"/>
						</xsl:apply-templates>
					</xsl:when>
					<xsl:when test="count(tia:IMKAD_Persoon) = 1">
						<xsl:apply-templates select="tia:IMKAD_Persoon" mode="do-party-person">
							<xsl:with-param name="maxColspan" select="$colspan"/>
							<xsl:with-param name="anchorName" select="$anchorName"/>
						</xsl:apply-templates>
					</xsl:when>
					<xsl:otherwise>
						<xsl:for-each select="tia:IMKAD_Persoon">
							<xsl:apply-templates select="." mode="do-party-person">
								<xsl:with-param name="maxColspan" select="$colspan"/>
								<xsl:with-param name="anchorName" select="$anchorName"/>
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
							</xsl:when>
							<xsl:otherwise>
								<xsl:text>hierna </xsl:text>
								<xsl:if test="$numberOfPersons > 1">
									<xsl:text>zowel tezamen als ieder afzonderlijk </xsl:text>
								</xsl:if>
								<xsl:if test="position() = 1">
									<xsl:text>ook </xsl:text>
								</xsl:if>
								<xsl:text>te noemen: '</xsl:text>
								<u><xsl:text>de Bank</xsl:text></u>
								<xsl:text>'</xsl:text>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:text>.</xsl:text>
					</td>
				</tr>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--
	*********************************************************
	Mode: do-party-person
	*********************************************************
	Public: no

	Identity transform: no

	Description: ING mortgage deed party persons.

	Input: tia:IMKAD_Persoon

	Params: maxColspan - maximal colspan in table
			start - order number of person in nested party
			nestedParty - indicator if current person's party is nested one
			anchorName - name of the anchor that will be positioned in first <td> element

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
		<xsl:param name="start" select="number('0')"/>
		<xsl:param name="nestedParty" select="'false'"/>
		<xsl:param name="anchorName" select="''"/>
		
		<xsl:apply-templates select="." mode="do-party-natural-person">
			<xsl:with-param name="maxColspan" select="$maxColspan"/>
			<xsl:with-param name="start" select="$start"/>
			<xsl:with-param name="nestedParty" select="$nestedParty"/>
			<xsl:with-param name="anchorName" select="$anchorName"/>
		</xsl:apply-templates>
	</xsl:template>

	<!--
	****   matching template ******************************************************************************
	**** NATURAL PERSON PAIR ******************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon[(tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene) and tia:GerelateerdPersoon]" mode="do-party-person">
		<xsl:param name="maxColspan" select="number('0')"/>
		<xsl:param name="start" select="number('0')"/>
		<xsl:param name="nestedParty" select="'false'"/>
		<xsl:param name="anchorName" select="''"/>
		
		<xsl:apply-templates select="." mode="do-party-natural-person">
			<xsl:with-param name="maxColspan" select="$maxColspan"/>
			<xsl:with-param name="start" select="$start"/>
			<xsl:with-param name="nestedParty" select="$nestedParty"/>
			<xsl:with-param name="anchorName" select="$anchorName"/>
		</xsl:apply-templates>
	</xsl:template>

	<!--
	**** matching template ********************************************************************************
	****    LEGAL PERSON   ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon[tia:tia_Gegevens/tia:NHR_Rechtspersoon]" mode="do-party-person">
		<xsl:param name="maxColspan" select="number('0')"/>
		<xsl:param name="start" select="number('0')"/>
		<xsl:param name="nestedParty" select="'false'"/>
		<xsl:param name="anchorName" select="''"/>
		
		<xsl:apply-templates select="." mode="do-party-legal-person">
			<xsl:with-param name="maxColspan" select="$maxColspan"/>
			<xsl:with-param name="start" select="$start"/>
			<xsl:with-param name="nestedParty" select="$nestedParty"/>
			<xsl:with-param name="anchorName" select="$anchorName"/>
		</xsl:apply-templates>
	</xsl:template>

</xsl:stylesheet>
