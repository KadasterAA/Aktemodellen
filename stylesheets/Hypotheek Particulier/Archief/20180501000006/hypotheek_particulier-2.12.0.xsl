<?xml version="1.0" encoding="UTF-8"?>
<!--
*********************************************************
Stylesheet: hypotheek_particulier.xsl
Version: 2.12.0 (AA-4198: komma verwijderd)
Date: 2018-04-06
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
	xmlns:part="http://www.kadaster.nl/schemas/KIK/ParticuliereHypotheekakte/v20140515"
	xmlns:kef="nl.kadaster.xslt.XslExtensionFunctions"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:gc="http://docs.oasis-open.org/codelist/ns/genericode/1.0/"
	exclude-result-prefixes="tia part kef xsl xlink gc"
	version="1.0">

	<xsl:include href="generiek-1.08.xsl" />
	<xsl:include href="tekstblok_aanhef-1.18.xsl" />
	<xsl:include href="tekstblok_burgerlijke_staat-1.03.xsl" />
	<xsl:include href="tekstblok_equivalentieverklaring-1.26.xsl" />
	<xsl:include href="tekstblok_gevolmachtigde-1.26.xsl" />
	<xsl:include href="tekstblok_legitimatie-1.01.xsl" />
	<xsl:include href="tekstblok_personalia_van_natuurlijk_persoon-1.06.xsl" />
	<xsl:include href="tekstblok_natuurlijk_persoon-1.12.xsl" />
	<xsl:include href="tekstblok_overbruggingshypotheek-1.07.xsl" />
	<xsl:include href="tekstblok_partij_natuurlijk_persoon-1.39.xsl" />
	<xsl:include href="tekstblok_partij_niet_natuurlijk_persoon-1.52.xsl" />
	<xsl:include href="tekstblok_partijnamen_in_hypotheekakten-1.14.xsl" />
	<xsl:include href="tekstblok_recht-1.17.xsl" />
	<xsl:include href="tekstblok_rechtspersoon-1.14.0.xsl" />
	<xsl:include href="tekstblok_registergoed-1.27.xsl" />
	<xsl:include href="tekstblok_titel_hypotheekakten-1.01.xsl" />
	<xsl:include href="tekstblok_woonadres-1.05.xsl" />
	<xsl:include href="tweededeel-1.05.xsl" />

	<!-- Particuliere Hypotheek specific global variables -->
	<xsl:variable name="keuzeteksten" select="document('keuzeteksten_hypotheek_particulier-2.9.0.xml')" />
	<xsl:variable name="keuzetekstenTbBurgelijkeStaat" select="document('keuzeteksten-tb-burgerlijkestaat-1.1.0.xml')"/>
	<xsl:variable name="legalPersonNames" select="document('nnp-kodes_hypotheek.xml')/gc:CodeList/SimpleCodeList/Row" />
	<xsl:variable name="partijIdVervreemderRechtRef" select="tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek/tia:vervreemderRechtRef/@*[translate(local-name(), $upper, $lower) = 'href']" />
	<xsl:variable name="partijIdVerkrijgerRechtRef" select="tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek/tia:verkrijgerRechtRef/@*[translate(local-name(), $upper, $lower) = 'href']" />
	<xsl:variable name="partyOneName">
		<xsl:choose>
			<xsl:when test="tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:Partij[$partijIdVervreemderRechtRef = concat('#',@id)]/tia:aanduidingPartij = 'de Schuldenaar' or tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:Partij[$partijIdVervreemderRechtRef = concat('#',@id)]/tia:aanduidingPartij = 'de Hypotheekgever'">
				<xsl:value-of select="tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:Partij[$partijIdVervreemderRechtRef = concat('#',@id)]/tia:aanduidingPartij" />
			</xsl:when>
			<xsl:when test="tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:tekstkeuze[tia:tagNaam = 'k_SchuldenaarHypotheekgever']/tia:tekst = 'de Schuldenaar' or tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:tekstkeuze[tia:tagNaam = 'k_SchuldenaarHypotheekgever']/tia:tekst = 'de Hypotheekgever'">
				<xsl:value-of select="tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:tekstkeuze[tia:tagNaam = 'k_SchuldenaarHypotheekgever']/tia:tekst" />
			</xsl:when>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="partyTwoName">
		<xsl:if test="tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:Partij[$partijIdVerkrijgerRechtRef = concat('#',@id)]/tia:aanduidingPartij = 'de Schuldeiser' or tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:Partij[$partijIdVerkrijgerRechtRef = concat('#',@id)]/tia:aanduidingPartij = 'de Hypotheeknemer' or tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:Partij[$partijIdVerkrijgerRechtRef = concat('#',@id)]/tia:aanduidingPartij = 'de Bank'">
			<xsl:value-of select="tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:Partij[$partijIdVerkrijgerRechtRef = concat('#',@id)]/tia:aanduidingPartij" />
		</xsl:if>
	</xsl:variable>
	<xsl:variable name="RegistergoedTonenPerPerceel"> <!-- t.b.v. TB Registergoed -->
		<xsl:choose>
			<xsl:when test="tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedtonenperperceel']">
				<xsl:value-of select="translate(tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedtonenperperceel']/tia:tekst, $upper, $lower)"/>
			</xsl:when>
			<xsl:otherwise>false</xsl:otherwise>
		</xsl:choose>
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
	(mode) do-mortgage-deed-title
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
			<xsl:apply-templates select="tia:IMKAD_AangebodenStuk" mode="do-statement-of-equivalence" />
			<!-- Two empty lines after Statement of equivalence -->
			<p>
				<br />
			</p>
			<p>
				<br />
			</p>
		</xsl:if>
		<a name="hyp3.header" class="location">&#160;</a>
		<!-- Text block Mortgage deed title -->
		<xsl:apply-templates select="tia:IMKAD_AangebodenStuk" mode="do-mortgage-deed-title" />
		<!-- Text block Header -->
		<xsl:apply-templates select="tia:IMKAD_AangebodenStuk" mode="do-header" />
		<!-- Parties -->
		<xsl:apply-templates select="tia:IMKAD_AangebodenStuk/tia:Partij" mode="do-parties" />
		<p>
			<xsl:if test="tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_genoegzaam']/tia:tekst = 'true'">
				<xsl:text>Van het bestaan van de volmacht</xsl:text>
				<xsl:value-of select="tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoudvolmachten']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
						translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoudvolmachten']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
						translate(normalize-space(current()/tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoudvolmachten']/tia:tekst), $upper, $lower)]), $upper, $lower)]" />
				<xsl:text> aan de </xsl:text>
				<xsl:variable name="currentParty" select="tia:IMKAD_AangebodenStuk/tia:Partij[@id = substring-after(current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:verkrijgerRechtRef/@xlink:href, '#')]"/>
				<xsl:choose>
					<xsl:when test="($currentParty/tia:Gevolmachtigde
										and count($currentParty/tia:Gevolmachtigde) = 1
										and count($currentParty/tia:Gevolmachtigde/tia:GerelateerdPersoon) &lt; 1)
									or (not($currentParty/tia:Gevolmachtigde)
											and count($currentParty//tia:IMKAD_Persoon[not(tia:tia_Gegevens/tia:NHR_Rechtspersoon)]) = 1)">
						<xsl:text>comparant</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>comparanten</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:text> onder 2. genoemd is mij, notaris, genoegzaam gebleken.</xsl:text>
				<br />
			</xsl:if>
			<xsl:text>De verschenen personen</xsl:text>
			<xsl:value-of select="tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_handelendals']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
					translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_handelendals']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
					translate(normalize-space(current()/tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_handelendals']/tia:tekst), $upper, $lower)]), $upper, $lower)]" />
			<xsl:text> verklaarden als volgt.</xsl:text>
		</p>
		<!-- Contract of sale -->
		<xsl:apply-templates select="tia:IMKAD_AangebodenStuk" mode="do-contract-of-sale" />
		<!-- Mortgage loan -->
		<a name="hyp3.privateMortgageProvisionAndGrantGiver" class="location">&#160;</a>
		<xsl:apply-templates select="tia:IMKAD_AangebodenStuk" mode="do-mortgage-provision" />
		<!-- Type of Mortgage -->
		<a name="hyp3.privateMortgageType" class="location">&#160;</a>
		<xsl:choose>
			<xsl:when test="tia:partnerSpecifiek/part:BankHypotheek">
				<xsl:if test="count(tia:partnerSpecifiek/part:BankHypotheek/part:omschrijving) > 0">
					<table cellpadding="0" cellspacing="0">
						<tbody>
							<xsl:variable name="numberOfBankHypotheekOmschrijving" select="count(tia:partnerSpecifiek/part:BankHypotheek/part:omschrijving)"/>
							<xsl:for-each select="tia:partnerSpecifiek/part:BankHypotheek/part:omschrijving">
								<tr>
									<td class="number" valign="top">
										<xsl:text>-</xsl:text>
									</td>
									<td>
										<xsl:choose>
											<xsl:when test="current() = '1'">
												<xsl:text>verstrekte en/of te verstrekken geldleningen</xsl:text>
											</xsl:when>
											<xsl:when test="current() = '2'">
												<xsl:text>verleende en/of te verlenen kredieten</xsl:text>
											</xsl:when>
											<xsl:when test="current() = '3'">
												<xsl:text>door </xsl:text>
												<xsl:value-of select="$partyOneName" />
												<xsl:text> ten behoeve van </xsl:text>
												<xsl:value-of select="$partyTwoName" />
												<xsl:text> gestelde en/of te stellen borgtochten en/of contragaranties</xsl:text>
											</xsl:when>
											<xsl:when test="current() = '4'">
												<xsl:text>door </xsl:text>
												<xsl:value-of select="$partyTwoName" />
												<xsl:text> afgegeven en/of af te geven borgtochten en/of (bank)garanties</xsl:text>
											</xsl:when>
											<xsl:when test="current() = '5'">
												<xsl:text>huidige en/of toekomstige parallelle schulden jegens </xsl:text>
												<xsl:value-of select="$partyTwoName" />
												<xsl:text> als zekerhedenagent</xsl:text>
											</xsl:when>
											<xsl:when test="current() = '6'">
												<xsl:text>huidige en/of toekomstige regresvorderingen</xsl:text>
											</xsl:when>
											<xsl:when test="current() = '7'">
												<xsl:text>huidige en/of toekomstige vorderingen krachtens subrogatie</xsl:text>
											</xsl:when>
											<xsl:when test="current() = '8'">
												<xsl:text>huidige en/of toekomstige financi&#x00eb;le instrumenten</xsl:text>
											</xsl:when>
											<xsl:when test="current() = '9'">
												<xsl:text>uit welken anderen hoofde dan ook</xsl:text>
											</xsl:when>
										</xsl:choose>
										<xsl:choose>
											<xsl:when test="position() = $numberOfBankHypotheekOmschrijving">
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
				<xsl:variable name="vasteHypotheekGeenSchip" select="tia:partnerSpecifiek/part:VasteHypotheekGeenSchip" />
				<xsl:variable name="numberOfOnderhandseAkteDatum" select="count($vasteHypotheekGeenSchip/part:vasteHypotheek/part:OnderhandseAkte/part:datum)"/>

				<xsl:choose>
					<xsl:when test="$vasteHypotheekGeenSchip/part:vasteHypotheek/part:OnderhandseAkte/part:datum and $vasteHypotheekGeenSchip/part:vasteHypotheek/part:OnderhandseAkte/part:datum != ''">
						<p>
							<xsl:text>de onderhandse akte(n) </xsl:text>
							<xsl:if test="count($vasteHypotheekGeenSchip/part:vasteHypotheek/part:OnderhandseAkte/part:datum) > 1">
								<xsl:text>respectievelijk </xsl:text>
							</xsl:if>
							<xsl:text>gedateerd: </xsl:text>
							<xsl:for-each select="$vasteHypotheekGeenSchip/part:vasteHypotheek/part:OnderhandseAkte/part:datum">
								<xsl:variable name="Datum_DATE" select="substring(string(.), 0, 11)" />
								<xsl:variable name="Datum_STRING">
									<xsl:if test="$Datum_DATE != ''">
										<xsl:value-of select="kef:convertDateToText($Datum_DATE)" />
									</xsl:if>
								</xsl:variable>
								<xsl:value-of select="$Datum_STRING" />
								<xsl:choose>
									<xsl:when test="position() = ($numberOfOnderhandseAkteDatum - 1)">
										<xsl:text> en </xsl:text>
									</xsl:when>
									<xsl:when test="position() != $numberOfOnderhandseAkteDatum">
										<xsl:text>, </xsl:text>
									</xsl:when>
								</xsl:choose>
							</xsl:for-each>
						</p>
					</xsl:when>
					<xsl:when test="($vasteHypotheekGeenSchip/part:vasteHypotheek/part:Financieringsvoorstel/part:datum and $vasteHypotheekGeenSchip/part:vasteHypotheek/part:Financieringsvoorstel/part:datum != '')
									or ($vasteHypotheekGeenSchip/part:vasteHypotheek/part:FinancieringsvoorstelAcceptatie/part:datum and $vasteHypotheekGeenSchip/part:vasteHypotheek/part:FinancieringsvoorstelAcceptatie/part:datum != '')">
						<xsl:variable name="numberOfFinancieringsvoorstelDatum" select="count($vasteHypotheekGeenSchip/part:vasteHypotheek/part:Financieringsvoorstel/part:datum)"/>
						<xsl:variable name="numberOfFinancieringsvoorstelAcceptatieDatum" select="count($vasteHypotheekGeenSchip/part:vasteHypotheek/part:FinancieringsvoorstelAcceptatie/part:datum)"/>

						<p>
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
								<xsl:variable name="Datum_DATE" select="substring(string(.), 0, 11)" />
								<xsl:variable name="Datum_STRING">
									<xsl:if test="$Datum_DATE != ''">
										<xsl:value-of select="kef:convertDateToText($Datum_DATE)" />
									</xsl:if>
								</xsl:variable>
								<xsl:value-of select="$Datum_STRING" />
								<xsl:choose>
									<xsl:when test="position() = ($numberOfFinancieringsvoorstelDatum - 1)">
										<xsl:text> en </xsl:text>
									</xsl:when>
									<xsl:when test="position() != $numberOfFinancieringsvoorstelDatum">
										<xsl:text>, </xsl:text>
									</xsl:when>
								</xsl:choose>
							</xsl:for-each>
							<xsl:if test="$vasteHypotheekGeenSchip/part:vasteHypotheek/part:FinancieringsvoorstelAcceptatie">
								<xsl:text> en</xsl:text>
								<xsl:if test="count($vasteHypotheekGeenSchip/part:vasteHypotheek/part:FinancieringsvoorstelAcceptatie/part:datum) > 1">
									<xsl:text> respectievelijk</xsl:text>
								</xsl:if>
								<xsl:text> geaccepteerd op </xsl:text>
								<xsl:for-each select="$vasteHypotheekGeenSchip/part:vasteHypotheek/part:FinancieringsvoorstelAcceptatie/part:datum">
									<xsl:variable name="Datum_DATE" select="substring(string(.), 0, 11)" />
									<xsl:variable name="Datum_STRING">
										<xsl:if test="$Datum_DATE != ''">
											<xsl:value-of select="kef:convertDateToText($Datum_DATE)" />
										</xsl:if>
									</xsl:variable>
									<xsl:value-of select="$Datum_STRING" />
									<xsl:choose>
										<xsl:when test="position() = ($numberOfFinancieringsvoorstelAcceptatieDatum - 1)">
											<xsl:text> en </xsl:text>
										</xsl:when>
										<xsl:when test="position() != $numberOfFinancieringsvoorstelAcceptatieDatum">
											<xsl:text>, </xsl:text>
										</xsl:when>
									</xsl:choose>
								</xsl:for-each>
							</xsl:if>
						</p>
					</xsl:when>
				</xsl:choose>
				<xsl:if test="$vasteHypotheekGeenSchip/part:Geldleningen or $vasteHypotheekGeenSchip/part:Kredieten or $vasteHypotheekGeenSchip/part:Borgtochten">
					<xsl:variable name="numberOfGeldleningenBedrag" select="count($vasteHypotheekGeenSchip/part:Geldleningen/part:bedrag)"/>
					<xsl:variable name="numberOfKredietenBedrag" select="count($vasteHypotheekGeenSchip/part:Kredieten/part:bedrag)"/>
					<xsl:variable name="numberOfBorgtochten" select="count($vasteHypotheekGeenSchip/part:Borgtochten/part:IMKAD_Persoon)"/>
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
												translate(normalize-space($vasteHypotheekGeenSchip/part:Geldleningen/part:tekstKeuze[translate(part:tagNaam, $upper, $lower) = 'k_hyp_verstrekt']/part:tekst), $upper, $lower)]), $upper, $lower)]" />
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
												<xsl:when test="position() = ($numberOfGeldleningenBedrag - 1)">
													<xsl:text> en </xsl:text>
												</xsl:when>
												<xsl:when test="position() != $numberOfGeldleningenBedrag">
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
									<xsl:value-of select="count($vasteHypotheekGeenSchip/part:Geldleningen) + 1" />
								</xsl:variable>
								<tr>
									<td class="number" valign="top">
										<xsl:value-of select="$position" />
										<xsl:text>)</xsl:text>
									</td>
									<td>
										<xsl:value-of select="$vasteHypotheekGeenSchip/part:Kredieten/part:tekstKeuze[translate(part:tagNaam, $upper, $lower) = 'k_hyp_verleend']/part:tekst[translate(normalize-space(.), $upper, $lower) =
												translate(normalize-space($keuzeteksten/*/part:tekstKeuze[translate(part:tagNaam, $upper, $lower) = 'k_hyp_verleend']/part:tekst[translate(normalize-space(.), $upper, $lower) =
												translate(normalize-space($vasteHypotheekGeenSchip/part:Kredieten/part:tekstKeuze[translate(part:tagNaam, $upper, $lower) = 'k_hyp_verleend']/part:tekst), $upper, $lower)]), $upper, $lower)]" />
										<xsl:choose>
											<xsl:when test="count($vasteHypotheekGeenSchip/part:Kredieten/part:bedrag) = 1">
												<xsl:text> krediet groot </xsl:text>
											</xsl:when>
											<xsl:when test="$vasteHypotheekGeenSchip/part:Kredieten/part:tekstKeuze[translate(part:tagNaam, $upper, $lower) = 'k_hyp_verleend']/part:tekst[translate(normalize-space(.), $upper, $lower) ='te verlenen']">
												<xsl:text> kredieten respectievelijk groot </xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text>e kredieten respectievelijk groot </xsl:text>
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
												<xsl:when test="position() = ($numberOfKredietenBedrag - 1)">
													<xsl:text> en </xsl:text>
												</xsl:when>
												<xsl:when test="position() != $numberOfKredietenBedrag">
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
									<xsl:value-of select="count($vasteHypotheekGeenSchip/part:Geldleningen) + count($vasteHypotheekGeenSchip/part:Kredieten) + 1" />
								</xsl:variable>
								<tr>
									<td class="number" valign="top">
										<xsl:value-of select="$position" />
										<xsl:text>)</xsl:text>
									</td>
									<td>
										<xsl:value-of select="$vasteHypotheekGeenSchip/part:Borgtochten/part:tekstKeuze[translate(part:tagNaam, $upper, $lower) = 'k_hyp_gesteld']/part:tekst[translate(normalize-space(.), $upper, $lower) =
												translate(normalize-space($keuzeteksten/*/part:tekstKeuze[translate(part:tagNaam, $upper, $lower) = 'k_hyp_gesteld']/part:tekst[translate(normalize-space(.), $upper, $lower) =
												translate(normalize-space($vasteHypotheekGeenSchip/part:Borgtochten/part:tekstKeuze[translate(part:tagNaam, $upper, $lower) = 'k_hyp_gesteld']/part:tekst), $upper, $lower)]), $upper, $lower)]" />
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
											<xsl:apply-templates select="." mode="do-natural-person-part" />
											<xsl:text> </xsl:text>
											<xsl:text> wonende te </xsl:text>
											<xsl:apply-templates select="part:IMKAD_WoonlocatiePersoon" mode="do-address-part" />
											<xsl:choose>
												<xsl:when test="position() = ($numberOfBorgtochten - 1)">
													<xsl:text> en </xsl:text>
												</xsl:when>
												<xsl:when test="position() != $numberOfBorgtochten">
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
				<xsl:variable name="vasteHypotheekSchip" select="tia:partnerSpecifiek/part:VasteHypotheekSchip" />
				<xsl:variable name="numberOfOnderhandseAkte" select="count($vasteHypotheekSchip/part:vasteHypotheek/part:OnderhandseAkte/part:datum)"/>
				<xsl:variable name="numberOfFinancieringsvoorstel" select="count($vasteHypotheekSchip/part:vasteHypotheek/part:Financieringsvoorstel/part:datum)"/>
				<xsl:variable name="numberOfGeldleningenInclGeldleningen" select="count($vasteHypotheekSchip/part:GeldleningenInclRente/part:Geldleningen/part:bedrag)"/>

				<xsl:if test="$vasteHypotheekSchip/part:vasteHypotheek/part:OnderhandseAkte/part:datum and $vasteHypotheekSchip/part:vasteHypotheek/part:OnderhandseAkte/part:datum != ''">
					<p>
						<xsl:text>de onderhandse akte(n) </xsl:text>
						<xsl:if test="count($vasteHypotheekSchip/part:vasteHypotheek/part:OnderhandseAkte/part:datum) > 1">
							<xsl:text>respectievelijk </xsl:text>
						</xsl:if>
						<xsl:text>gedateerd: </xsl:text>
						<xsl:for-each select="$vasteHypotheekSchip/part:vasteHypotheek/part:OnderhandseAkte/part:datum">
							<xsl:variable name="Datum_DATE" select="substring(string(.), 0, 11)" />
							<xsl:variable name="Datum_STRING">
								<xsl:if test="$Datum_DATE != ''">
									<xsl:value-of select="kef:convertDateToText($Datum_DATE)" />
								</xsl:if>
							</xsl:variable>
							<xsl:value-of select="$Datum_STRING" />
							<xsl:choose>
								<xsl:when test="position() = ($numberOfOnderhandseAkte - 1)">
									<xsl:text> en </xsl:text>
								</xsl:when>
								<xsl:when test="position() != $numberOfOnderhandseAkte">
									<xsl:text>, </xsl:text>
								</xsl:when>
							</xsl:choose>
						</xsl:for-each>
					</p>
				</xsl:if>
				<xsl:if test="($vasteHypotheekSchip/part:vasteHypotheek/part:Financieringsvoorstel/part:datum and $vasteHypotheekSchip/part:vasteHypotheek/part:Financieringsvoorstel/part:datum !='')
								or ($vasteHypotheekSchip/part:vasteHypotheek/part:FinancieringsvoorstelAcceptatie/part:datum and $vasteHypotheekSchip/part:vasteHypotheek/part:FinancieringsvoorstelAcceptatie/part:datum != '')">
					<p>
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
							<xsl:variable name="Datum_DATE" select="substring(string(.), 0, 11)" />
							<xsl:variable name="Datum_STRING">
								<xsl:if test="$Datum_DATE != ''">
									<xsl:value-of select="kef:convertDateToText($Datum_DATE)" />
								</xsl:if>
							</xsl:variable>
							<xsl:value-of select="$Datum_STRING" />
							<xsl:choose>
								<xsl:when test="position() = ($numberOfFinancieringsvoorstel - 1)">
									<xsl:text> en </xsl:text>
								</xsl:when>
								<xsl:when test="position() != $numberOfFinancieringsvoorstel">
									<xsl:text>, </xsl:text>
								</xsl:when>
							</xsl:choose>
						</xsl:for-each>
						<xsl:if test="$vasteHypotheekSchip/part:vasteHypotheek/part:FinancieringsvoorstelAcceptatie">
							<xsl:text> en</xsl:text>
							<xsl:if test="count($vasteHypotheekSchip/part:vasteHypotheek/part:FinancieringsvoorstelAcceptatie/part:datum) > 1">
								<xsl:text> respectievelijk</xsl:text>
							</xsl:if>
							<xsl:text> geaccepteerd op </xsl:text>
							<xsl:variable name="numberOfFinancieringsvoorstelAcceptatie" select="count($vasteHypotheekSchip/part:vasteHypotheek/part:FinancieringsvoorstelAcceptatie/part:datum)"/>
							<xsl:for-each select="$vasteHypotheekSchip/part:vasteHypotheek/part:FinancieringsvoorstelAcceptatie/part:datum">
								<xsl:variable name="Datum_DATE" select="substring(string(.), 0, 11)" />
								<xsl:variable name="Datum_STRING">
									<xsl:if test="$Datum_DATE != ''">
										<xsl:value-of select="kef:convertDateToText($Datum_DATE)" />
									</xsl:if>
								</xsl:variable>
								<xsl:value-of select="$Datum_STRING" />
								<xsl:choose>
									<xsl:when test="position() = ($numberOfFinancieringsvoorstelAcceptatie - 1)">
										<xsl:text> en </xsl:text>
									</xsl:when>
									<xsl:when test="position() != $numberOfFinancieringsvoorstelAcceptatie">
										<xsl:text>, </xsl:text>
									</xsl:when>
								</xsl:choose>
							</xsl:for-each>
						</xsl:if>
					</p>
				</xsl:if>
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
												translate(normalize-space($vasteHypotheekSchip/part:GeldleningenInclRente/part:Geldleningen/part:tekstKeuze[translate(part:tagNaam, $upper, $lower) = 'k_hyp_verstrekt']/part:tekst), $upper, $lower)]), $upper, $lower)]" />
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
												<xsl:when test="position() = ($numberOfGeldleningenInclGeldleningen - 1)">
													<xsl:text> en </xsl:text>
												</xsl:when>
												<xsl:when test="position() != $numberOfGeldleningenInclGeldleningen">
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
										<xsl:variable name="numberOfGeldleningenInclRentepercentage" select="count($vasteHypotheekSchip/part:GeldleningenInclRente/part:rente/part:Rentepercentage/part:percentage)"/>
										<xsl:for-each select="$vasteHypotheekSchip/part:GeldleningenInclRente/part:rente/part:Rentepercentage/part:percentage">
											<xsl:call-template name="percentText">
												<xsl:with-param name="percent" select="." />
											</xsl:call-template>
											<xsl:text> </xsl:text>
											<xsl:call-template name="percentNumber">
												<xsl:with-param name="percent" select="." />
											</xsl:call-template>
											<xsl:choose>
												<xsl:when test="position() = ($numberOfGeldleningenInclRentepercentage - 1)">
													<xsl:text> en </xsl:text>
												</xsl:when>
												<xsl:when test="position() != $numberOfGeldleningenInclRentepercentage">
													<xsl:text>, </xsl:text>
												</xsl:when>
											</xsl:choose>
										</xsl:for-each>
										<xsl:text> per jaar, vervallende </xsl:text>
										<xsl:if test="count($vasteHypotheekSchip/part:GeldleningenInclRente/part:rente/part:VervalDatum/part:datum) > 1">
											<xsl:text>respectievelijk </xsl:text>
										</xsl:if>
										<xsl:text>op </xsl:text>
										<xsl:variable name="numberOfGeldleningenInclRenteVervalDatum" select="count($vasteHypotheekSchip/part:GeldleningenInclRente/part:rente/part:VervalDatum/part:datum)"/>
										<xsl:for-each select="$vasteHypotheekSchip/part:GeldleningenInclRente/part:rente/part:VervalDatum/part:datum">
											<xsl:variable name="Datum_DATE" select="substring(string(.), 0, 11)" />
											<xsl:variable name="Datum_STRING">
												<xsl:if test="$Datum_DATE != ''">
													<xsl:value-of select="kef:convertDateToText($Datum_DATE)" />
												</xsl:if>
											</xsl:variable>
											<xsl:value-of select="$Datum_STRING" />
											<xsl:choose>
												<xsl:when test="position() = ($numberOfGeldleningenInclRenteVervalDatum - 1)">
													<xsl:text> en </xsl:text>
												</xsl:when>
												<xsl:when test="position() != $numberOfGeldleningenInclRenteVervalDatum">
													<xsl:text>, </xsl:text>
												</xsl:when>
											</xsl:choose>
										</xsl:for-each>
										<xsl:text> van elk jaar, voor het eerst op </xsl:text>
										<xsl:variable name="numberOfEersteVervalDatum" select="count($vasteHypotheekSchip/part:GeldleningenInclRente/part:rente/part:EersteVervalDatum/part:datum)"/>
										<xsl:for-each select="$vasteHypotheekSchip/part:GeldleningenInclRente/part:rente/part:EersteVervalDatum/part:datum">
											<xsl:variable name="Datum_DATE" select="substring(string(.), 0, 11)" />
											<xsl:variable name="Datum_STRING">
												<xsl:if test="$Datum_DATE != ''">
													<xsl:value-of select="kef:convertDateToText($Datum_DATE)" />
												</xsl:if>
											</xsl:variable>
											<xsl:value-of select="$Datum_STRING" />
											<xsl:choose>
												<xsl:when test="position() = ($numberOfEersteVervalDatum - 1)">
													<xsl:text> en </xsl:text>
												</xsl:when>
												<xsl:when test="position() != $numberOfEersteVervalDatum">
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
									<xsl:value-of select="count($vasteHypotheekSchip/part:GeldleningenInclRente) + 1" />
								</xsl:variable>
								<tr>
									<td class="number" valign="top">
										<xsl:value-of select="$position" />
										<xsl:text>)</xsl:text>
									</td>
									<td>
										<xsl:value-of select="$vasteHypotheekSchip/part:KredietenInclRente/part:Kredieten/part:tekstKeuze[translate(part:tagNaam, $upper, $lower) = 'k_hyp_verleend']/part:tekst[translate(normalize-space(.), $upper, $lower) =
												translate(normalize-space($keuzeteksten/*/part:tekstKeuze[translate(part:tagNaam, $upper, $lower) = 'k_hyp_verleend']/part:tekst[translate(normalize-space(.), $upper, $lower) =
												translate(normalize-space($vasteHypotheekSchip/part:KredietenInclRente/part:Kredieten/part:tekstKeuze[translate(part:tagNaam, $upper, $lower) = 'k_hyp_verleend']/part:tekst), $upper, $lower)]), $upper, $lower)]" />
										<xsl:choose>
											<xsl:when test="count($vasteHypotheekSchip/part:KredietenInclRente/part:Kredieten/part:bedrag) = 1">
												<xsl:text> krediet groot </xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text> kredieten respectievelijk groot </xsl:text>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:variable name="numberOfKredietenInclRente" select="count($vasteHypotheekSchip/part:KredietenInclRente/part:Kredieten/part:bedrag)"/>
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
												<xsl:when test="position() = ($numberOfKredietenInclRente - 1)">
													<xsl:text> en </xsl:text>
												</xsl:when>
												<xsl:when test="position() != $numberOfKredietenInclRente">
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
										<xsl:variable name="numberOfRentepercentage" select="count($vasteHypotheekSchip/part:KredietenInclRente/part:rente/part:Rentepercentage/part:percentage)"/>
										<xsl:for-each select="$vasteHypotheekSchip/part:KredietenInclRente/part:rente/part:Rentepercentage/part:percentage">
											<xsl:call-template name="percentText">
												<xsl:with-param name="percent" select="." />
											</xsl:call-template>
											<xsl:text> </xsl:text>
											<xsl:call-template name="percentNumber">
												<xsl:with-param name="percent" select="." />
											</xsl:call-template>
											<xsl:choose>
												<xsl:when test="position() = ($numberOfRentepercentage - 1)">
													<xsl:text> en </xsl:text>
												</xsl:when>
												<xsl:when test="position() != $numberOfRentepercentage">
													<xsl:text>, </xsl:text>
												</xsl:when>
											</xsl:choose>
										</xsl:for-each>
										<xsl:text> per jaar, vervallende </xsl:text>
										<xsl:if test="count($vasteHypotheekSchip/part:KredietenInclRente/part:rente/part:VervalDatum/part:datum) > 1">
											<xsl:text>respectievelijk </xsl:text>
										</xsl:if>
										<xsl:text>op </xsl:text>
										<xsl:variable name="numberOfVervalDatum" select="count($vasteHypotheekSchip/part:KredietenInclRente/part:rente/part:VervalDatum/part:datum)"/>
										<xsl:for-each select="$vasteHypotheekSchip/part:KredietenInclRente/part:rente/part:VervalDatum/part:datum">
											<xsl:variable name="Datum_DATE" select="substring(string(.), 0, 11)" />
											<xsl:variable name="Datum_STRING">
												<xsl:if test="$Datum_DATE != ''">
													<xsl:value-of select="kef:convertDateToText($Datum_DATE)" />
												</xsl:if>
											</xsl:variable>
											<xsl:value-of select="$Datum_STRING" />
											<xsl:choose>
												<xsl:when test="position() = ($numberOfVervalDatum - 1)">
													<xsl:text> en </xsl:text>
												</xsl:when>
												<xsl:when test="position() != $numberOfVervalDatum">
													<xsl:text>, </xsl:text>
												</xsl:when>
											</xsl:choose>
										</xsl:for-each>
										<xsl:text> van elk jaar, voor het eerst op </xsl:text>
										<xsl:variable name="numberOfEersteVervalDatum" select="count($vasteHypotheekSchip/part:KredietenInclRente/part:rente/part:EersteVervalDatum/part:datum)"/>
										<xsl:for-each select="$vasteHypotheekSchip/part:KredietenInclRente/part:rente/part:EersteVervalDatum/part:datum">
											<xsl:variable name="Datum_DATE" select="substring(string(.), 0, 11)" />
											<xsl:variable name="Datum_STRING">
												<xsl:if test="$Datum_DATE != ''">
													<xsl:value-of select="kef:convertDateToText($Datum_DATE)" />
												</xsl:if>
											</xsl:variable>
											<xsl:value-of select="$Datum_STRING" />
											<xsl:choose>
												<xsl:when test="position() = ($numberOfEersteVervalDatum - 1)">
													<xsl:text> en </xsl:text>
												</xsl:when>
												<xsl:when test="position() != $numberOfEersteVervalDatum">
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
			<xsl:value-of select="concat(translate(substring($partyOneName,1,1),$lower,$upper),substring($partyOneName,2))" />
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
								<xsl:text>renten, vergoedingen, boeten en kosten, welke samen worden begroot op </xsl:text>
								<xsl:call-template name="percentText">
									<xsl:with-param name="percent" select="tia:partnerSpecifiek/part:AanvullendeKosten/part:RegistergoedGeenSchip/part:percentage" />
								</xsl:call-template>
								<xsl:text> </xsl:text>
								<xsl:call-template name="percentNumber">
									<xsl:with-param name="percent" select="tia:partnerSpecifiek/part:AanvullendeKosten/part:RegistergoedGeenSchip/part:percentage" />
								</xsl:call-template>
								<xsl:text> van het hiervoor onder a vermelde bedrag, derhalve tot een bedrag van </xsl:text>
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
								<xsl:text>renten, vergoedingen, boeten en kosten, welke samen worden begroot op </xsl:text>
								<xsl:call-template name="percentText">
									<xsl:with-param name="percent" select="tia:partnerSpecifiek/part:AanvullendeKosten/part:HypotheekMedeOpSchip/part:percentage" />
								</xsl:call-template>
								<xsl:text> </xsl:text>
								<xsl:call-template name="percentNumber">
									<xsl:with-param name="percent" select="tia:partnerSpecifiek/part:AanvullendeKosten/part:HypotheekMedeOpSchip/part:percentage" />
								</xsl:call-template>
								<xsl:text> van het hiervoor onder a vermelde bedrag, derhalve tot een bedrag van </xsl:text>
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
		<xsl:variable name="allProcessedRights" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht"/>
		<a name="hyp3.rights" class="location">&#160;</a>
		<h2 class="header"><xsl:text>Onderpand</xsl:text></h2>
		<xsl:choose>
			<!-- Only one registered object -->
			<xsl:when test="count($allProcessedRights) = 1">
				<p>
					<xsl:variable name="rightText">
						<xsl:apply-templates select="$allProcessedRights" mode="do-right"/>
					</xsl:variable>
					<xsl:if test="normalize-space($rightText) != ''">
						<xsl:value-of select="$rightText" />
						<xsl:text> </xsl:text>
					</xsl:if>
					<xsl:apply-templates select="$allProcessedRights" mode="do-registered-object"/>
					<xsl:text>;</xsl:text>
					<br />
					<xsl:text>hierna te noemen: '</xsl:text>
					<u><xsl:text>het onderpand</xsl:text></u>
					<xsl:text>'.</xsl:text>
				</p>
			</xsl:when>
			<!-- Multiple registered objects, all parcels with same data -->
			<xsl:when test="count($allProcessedRights)
					= count($allProcessedRights[
						tia:aardVerkregen = $allProcessedRights[tia:IMKAD_Perceel][1]/tia:aardVerkregen
						and normalize-space(tia:aardVerkregen) != ''
						and ((tia:aardVerkregenVariant 
							= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:aardVerkregenVariant)
							or (not(tia:aardVerkregenVariant)
							and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:aardVerkregenVariant)))					
					and ((tia:tia_Aantal_BP_Rechten
								= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:tia_Aantal_BP_Rechten)
							or (not(tia:tia_Aantal_BP_Rechten)
								and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:tia_Aantal_BP_Rechten)))
						and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven']/tia:tekst
								= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven']/tia:tekst)
							or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven'])
								and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven'])))
						and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom']/tia:tekst
								= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom']/tia:tekst)
							or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom'])
							and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom'])))
						and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoud']/tia:tekst
								= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoud']/tia:tekst)
							or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoud'])
							and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoud'])))
						and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurend']/tia:tekst
								= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurend']/tia:tekst)
							or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurend'])
							and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurend'])))
						and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijvenvariant']/tia:tekst
								= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijvenvariant']/tia:tekst)
							or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijvenvariant'])
							and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijvenvariant'])))
						and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoudvariant']/tia:tekst
								= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoudvariant']/tia:tekst)
							or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoudvariant'])
							and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoudvariant'])))
						and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurendvariant']/tia:tekst
								= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurendvariant']/tia:tekst)
							or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurendvariant'])
							and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurendvariant'])))
						and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aantal_bp_rechtenvariant']/tia:tekst
								= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aantal_bp_rechtenvariant']/tia:tekst)
							or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aantal_bp_rechtenvariant'])
							and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aantal_bp_rechtenvariant'])))
						and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen']/tia:tekst
								= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen']/tia:tekst)
							or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen'])
								and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen'])))
						and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_wijzevanlevering']/tia:tekst
								= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_wijzevanlevering']/tia:tekst)
							or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_wijzevanlevering'])
								and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_wijzevanlevering'])))
						and ((tia:aandeelInRecht/tia:teller = $allProcessedRights[tia:IMKAD_Perceel][1]/tia:aandeelInRecht/tia:teller
							and tia:aandeelInRecht/tia:noemer = $allProcessedRights[tia:IMKAD_Perceel][1]/tia:aandeelInRecht/tia:noemer)
							or (not(tia:aandeelInRecht)
								and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:aandeelInRecht)))
						and tia:IMKAD_Perceel[
							tia:tia_OmschrijvingEigendom
								= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_OmschrijvingEigendom
							and normalize-space(tia:tia_OmschrijvingEigendom) != ''
							and ((tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid']/tia:tekst
									= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid']/tia:tekst)
								or (not(tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid'])
									and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid'])))
							and ((tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aanduiding']/tia:tekst
									= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aanduiding']/tia:tekst)
								or (not(tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aanduiding'])
								and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aanduiding'])))
							and ((tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_nabij']/tia:tekst
									= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_nabij']/tia:tekst)
								or (not(tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_nabij'])
								and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_nabij'])))
							and ((tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_komma']/tia:tekst
									= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_komma']/tia:tekst)
								or (not(tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_komma'])
								and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_komma'])))
							and ((tia:tia_SplitsingsverzoekOrdernummer
									= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_SplitsingsverzoekOrdernummer)
								or (not(tia:tia_SplitsingsverzoekOrdernummer)
									and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_SplitsingsverzoekOrdernummer)))
			and ((tia:stukVerificatiekosten/tia:reeks
						= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:reeks)
					or (not(tia:stukVerificatiekosten/tia:reeks)
						and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:reeks)))
				and ((tia:stukVerificatiekosten/tia:deel
						= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:deel)
					or (not(tia:stukVerificatiekosten/tia:deel)
						and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:deel)))
				and ((tia:stukVerificatiekosten/tia:nummer
						= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:nummer)
					or (not(tia:stukVerificatiekosten/tia:nummer)
						and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:nummer)))
				and tia:kadastraleAanduiding/tia:gemeente
					= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:kadastraleAanduiding/tia:gemeente
				and normalize-space(tia:kadastraleAanduiding/tia:gemeente) != ''
				and tia:kadastraleAanduiding/tia:sectie
					= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:kadastraleAanduiding/tia:sectie
				and normalize-space(tia:kadastraleAanduiding/tia:sectie) != ''
				and tia:IMKAD_OZLocatie/tia:ligging
					= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:ligging
				and normalize-space(tia:IMKAD_OZLocatie/tia:ligging) != ''
				and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer
					= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer)
					or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer)
						and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer)))
				and  ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter
						= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter)
					or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter)
						and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter)))
				and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging
						= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging)
					or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging)
						and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging)))
				and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode
						= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode)
					or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode)
						and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode)))
				and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam
					= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam)
					or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam)
						and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam)))
			and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam
					= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam)
					or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam)
						and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam)))
				and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:postcode
					= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:postcode)
					or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:postcode)
						and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:kadBinnenlandsAdres/tia:postcode)))
				and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:woonplaatsNaam
					= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:woonplaatsNaam)
					or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:woonplaatsNaam)
						and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:kadBinnenlandsAdres/tia:woonplaatsNaam)))
				and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:openbareRuimteNaam
					= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:openbareRuimteNaam)
					or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:openbareRuimteNaam)
						and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:kadBinnenlandsAdres/tia:openbareRuimteNaam)))				
				and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummer
					= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummer)
					or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummer)
						and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:kadBinnenlandsAdres/tia:huisNummer)))
				and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisLetter
					= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisLetter)
					or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisLetter)
						and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:kadBinnenlandsAdres/tia:huisLetter)))
				and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummerToevoeging
					= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummerToevoeging)
					or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummerToevoeging)
						and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:kadBinnenlandsAdres/tia:huisNummerToevoeging)))]]) and $RegistergoedTonenPerPerceel='false' ">
				<p>
					<xsl:variable name="rightText">
						<xsl:apply-templates select="$allProcessedRights[1]" mode="do-right"/>
					</xsl:variable>
					<xsl:if test="normalize-space($rightText) != ''">
						<xsl:value-of select="$rightText" />
						<xsl:text> </xsl:text>
					</xsl:if>
					<xsl:apply-templates select="$allProcessedRights[1]" mode="do-registered-object"/>
					<xsl:text>;</xsl:text>
					<br />
					<xsl:text>hierna zowel samen als ieder afzonderlijk te noemen: '</xsl:text>
					<u><xsl:text>het onderpand</xsl:text></u>
					<xsl:text>'.</xsl:text>
				</p>
			</xsl:when>
			<xsl:otherwise>
				<table cellpadding="0" cellspacing="0">
					<tbody>
						<xsl:call-template name="processRights">
							<xsl:with-param name="positionOfProcessedRight" select="1" />
							<xsl:with-param name="position" select="1" />
							<xsl:with-param name="haveAdditionalText" select="'true'"/> <!-- forceer de ; na elke aanroep recht/registergoed -->
							<xsl:with-param name="registeredObjects" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']" />
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
		<xsl:apply-templates select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[translate(tia:aanduidingHypotheek, $upper, $lower) = 'overbruggingshypotheek']" mode="do-bridging-mortgage" />
		<xsl:if test="not(tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[translate(tia:aanduidingHypotheek, $upper, $lower) = 'overbruggingshypotheek'])">
			<a name="hyp3.bridgingMortgage" class="location">&#160;</a>
		</xsl:if>
		<!-- Closure -->
		<p>
			<xsl:value-of select="concat(translate(substring($partyTwoName,1,1),$lower,$upper),substring($partyTwoName,2))" />
			<xsl:text> verklaarde het vorenstaande aan te nemen.</xsl:text>
		</p>
		<h2 class="header"><xsl:text>Opzegging</xsl:text></h2>
		<p>
			<xsl:value-of select="concat(translate(substring($partyOneName,1,1),$lower,$upper),substring($partyOneName,2))" />
			<xsl:text> en </xsl:text>
			<xsl:value-of select="$partyTwoName" />
			<xsl:text> verklaarden dat </xsl:text>
			<xsl:value-of select="$partyTwoName" />
			<xsl:text> door opzegging de aan haar verleende hypotheek- en pandrechten geheel of gedeeltelijk kan be&#x00eb;indigen.</xsl:text>
		</p>
		<!-- Election of domicile -->
		<xsl:variable name="woonplaatskeuze" select="tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_woonplaatskeuze']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
				translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_woonplaatskeuze']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
				translate(normalize-space(current()/tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_woonplaatskeuze']/tia:tekst), $upper, $lower)]), $upper, $lower)]" />
		<a name="hyp3.electionOfDomicile" class="location">&#160;</a>
		<xsl:if test="$woonplaatskeuze != ''">
			<h2 class="header"><u><xsl:text>Woonplaatskeuze</xsl:text></u></h2>
			<p><xsl:value-of select="$woonplaatskeuze" /></p>
		</xsl:if>
		<h3><xsl:text>EINDE KADASTERDEEL</xsl:text></h3>
		<!-- Free text part -->
		<a name="hyp3.part2" class="location">&#160;</a>
		<xsl:apply-templates select="tia:IMKAD_AangebodenStuk/tia:tia_TekstTweedeDeel" mode="do-free-text" />
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
		<xsl:variable name="numberOfPersonsWithIndGerechtigde" select="count(tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true']) + count(tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true'])" />
		<xsl:variable name="numberOfLegalPersonPairs" select="count(tia:IMKAD_Persoon[tia:tia_Gegevens/tia:NHR_Rechtspersoon and tia:GerelateerdPersoon[tia:rol = 'volmachtgever']])" />
		<xsl:variable name="hoedanigheidId" select="substring-after(tia:Gevolmachtigde/tia:vertegenwoordigtRef/@xlink:href, '#')" />

		<table cellspacing="0" cellpadding="0">
			<tbody>
				<xsl:if test="tia:Gevolmachtigde and count(tia:Hoedanigheid[@id = $hoedanigheidId]/tia:wordtVertegenwoordigdRef) = 0">
					<tr>
						<td>
							<table>
								<tbody>
									<tr>
										<td class="number" valign="top">
											<a name="{@id}" class="location" style="_position: relative;">&#xFEFF;</a>
											<xsl:value-of select="count(preceding-sibling::tia:Partij) + 1" />
											<xsl:text>.</xsl:text>
										</td>
										<td>
											<xsl:apply-templates select="tia:Gevolmachtigde" mode="do-legal-representative" />
											<xsl:text>: </xsl:text>
										</td>
									</tr>
								</tbody>
							</table>
						</td>
					</tr>
				</xsl:if>
				<!--
					TODO Code improvement.
					Restructure following CHOOSE structure, as it is no longer valid. It made sense when list structure was used.
					As table is used now, exactly the same code is called from 3 different branches (2 WHEN's and 1 OTHERWISE), needlessly.
					Therefore, FOR-EACH logic in OTHERWISE branch should be used instead of complete CHOOSE structure.
				-->
				<xsl:choose>
					<!-- If only one person pair, or legal person with warrantors is present - do not create list -->
					<xsl:when test="(tia:IMKAD_Persoon[(tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene) and tia:GerelateerdPersoon[tia:rol]]
							or $numberOfLegalPersonPairs > 0) and not(count(tia:IMKAD_Persoon) > 1)">
						<xsl:apply-templates select="tia:IMKAD_Persoon" mode="do-party-person" />
					</xsl:when>
					<xsl:when test="count(tia:IMKAD_Persoon) = 1">
						<xsl:apply-templates select="tia:IMKAD_Persoon" mode="do-party-person" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:for-each select="tia:IMKAD_Persoon">
							<xsl:apply-templates select="." mode="do-party-person" />
						</xsl:for-each>
					</xsl:otherwise>
				</xsl:choose>
			</tbody>
		</table>
		<p style="margin-left:30px">
			<xsl:choose>
				<xsl:when test="@id = substring-after(../tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:vervreemderRechtRef/@xlink:href, '#')">
					<xsl:apply-templates select="." mode="do-mortgage-deed-party-name" />
					<br />
					<xsl:text>en</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>hierna </xsl:text>
					<xsl:if test="$numberOfPersonsWithIndGerechtigde > 1">
						<xsl:text>zowel tezamen als ieder afzonderlijk </xsl:text>
					</xsl:if>
					<xsl:text>te noemen: '</xsl:text>
					<u>
						<xsl:value-of select="tia:aanduidingPartij" />
					</u>
					<xsl:text>'.</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</p>
	</xsl:template>

	<!--
	*********************************************************
	Mode: do-party-person
	*********************************************************
	Public: no

	Identity transform: no

	Description: Private mortgage deed party persons.

	Input: tia:IMKAD_Persoon

	Params: none

	Output: XHTML structure

	Calls:
	(mode) do-party-natural-person
	(mode) do-party-legal-person

	Called by:
	(mode) do-parties
	-->

	<!--
	**** matching template ********************************************************************************
	**** NATURAL PERSON    ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon[(tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene) and not(tia:GerelateerdPersoon)]" mode="do-party-person">
		<xsl:apply-templates select="." mode="do-party-natural-person" />
	</xsl:template>

	<!--
	**** matching template   ******************************************************************************
	**** NATURAL PERSON PAIR ******************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon[(tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene) and tia:GerelateerdPersoon]" mode="do-party-person">
		<xsl:apply-templates select="." mode="do-party-natural-person" />
	</xsl:template>

	<!--
	**** matching template ********************************************************************************
	**** LEGAL PERSON      ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon[tia:tia_Gegevens/tia:NHR_Rechtspersoon]" mode="do-party-person">
		<xsl:apply-templates select="." mode="do-party-legal-person" />
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
			<xsl:value-of select="concat(translate(substring($partyOneName,1,1),$lower,$upper),substring($partyOneName,2))" />
			<xsl:text> en </xsl:text>
			<xsl:value-of select="$partyTwoName" />
			<xsl:choose>
				<xsl:when test="translate(normalize-space(tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_overeenkomsthyprecht']/tia:tekst), $upper, $lower) = 'verklaarden te zijn overeengekomen dat door de'">
					<xsl:text> verklaarden te zijn overeengekomen dat door </xsl:text>
					<xsl:value-of select="$partyOneName" />
				</xsl:when>
				<xsl:when test="translate(normalize-space(tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_overeenkomsthyprecht']/tia:tekst), $upper, $lower) = 'komen overeen dat'">
					<xsl:text> komen overeen dat</xsl:text>
				</xsl:when>
			</xsl:choose>
			<xsl:text> ten behoeve van </xsl:text>
			<xsl:value-of select="$partyTwoName" />
			<xsl:text> het recht van hypotheek en pandrechten worden </xsl:text>
			<xsl:choose>
				<xsl:when test="translate(normalize-space(tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_overeenkomsthyprechtvestiging']/tia:tekst), $upper, $lower) = 'gevestigd'">
					<xsl:text>gevestigd</xsl:text>
				</xsl:when>
				<xsl:when test="translate(normalize-space(tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_overeenkomsthyprechtvestiging']/tia:tekst), $upper, $lower) = 'verleend'">
					<xsl:text>verleend</xsl:text>
				</xsl:when>
			</xsl:choose>
			<xsl:text> op de in deze akte omschreven goederen, tot zekerheid </xsl:text>
			<xsl:choose>
				<xsl:when test="translate(normalize-space(tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_overeenkomsthyprechtomschrijving']/tia:tekst), $upper, $lower) = 'als in deze akte omschreven'">
					<xsl:text>als in deze akte omschreven.</xsl:text>
				</xsl:when>
				<xsl:when test="translate(normalize-space(tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_overeenkomsthyprechtomschrijving']/tia:tekst), $upper, $lower) = 'zoals hierna vermeld'">
					<xsl:text>zoals hierna vermeld.</xsl:text>
				</xsl:when>
			</xsl:choose>
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
			<xsl:text>Ter uitvoering van voormelde overeenkomst verklaarde </xsl:text>
			<xsl:value-of select="$partyOneName" />
			<xsl:text> aan </xsl:text>
			<xsl:value-of select="$partyTwoName" />
			<xsl:text> hypotheek te verlenen tot het hierna te noemen bedrag op het hierna te noemen onderpand, tot zekerheid voor de betaling van al hetgeen </xsl:text>
			<xsl:value-of select="$partyTwoName" />
			<xsl:text> blijkens haar administratie van de hierna te noemen </xsl:text>
			<xsl:value-of select="substring($partyOneName,4)" />
			<xsl:text>,</xsl:text>
			<xsl:if test="translate(normalize-space(tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_iederafzonderlijk']/tia:tekst), $upper, $lower) = translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_iederafzonderlijk']/tia:tekst), $upper, $lower)">
				<xsl:text> </xsl:text>
				<xsl:value-of select="normalize-space(tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_iederafzonderlijk']/tia:tekst)" />
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
		<xsl:variable name="genderShouldBePrinted">
			<xsl:choose>
				<xsl:when test="normalize-space(translate(part:tia_Gegevens/part:IMKAD_KadNatuurlijkPersoon/part:adellijkeTitelOfPredikaat, $upper, $lower)) != '' 
						or normalize-space(translate(part:tia_Gegevens/part:IMKAD_KadNatuurlijkPersoon/part:tia_AdellijkeTitel2, $upper, $lower)) != ''">
					<xsl:text>false</xsl:text>
				</xsl:when>
				<xsl:when test="not(part:tia_Gegevens/part:IMKAD_KadNatuurlijkPersoon)
						and (normalize-space(translate(part:tia_Gegevens/part:GBA_Ingezetene/part:tia_AdellijkeTitel, $upper, $lower)) != ''
						or normalize-space(translate(part:tia_Gegevens/part:GBA_Ingezetene/part:tia_AdellijkeTitel2, $upper, $lower)) != '')">
					<xsl:text>false</xsl:text>
				</xsl:when>
				<xsl:when test="not(part:tia_Gegevens/part:IMKAD_KadNatuurlijkPersoon)
						and (normalize-space(translate(part:tia_Gegevens/part:IMKAD_NietIngezetene/part:tia_AdellijkeTitel, $upper, $lower)) != '' 
						or normalize-space(translate(part:tia_Gegevens/part:IMKAD_NietIngezetene/part:tia_AdellijkeTitel2, $upper, $lower)) != '')">
					<xsl:text>false</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>true</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<xsl:if test="$genderShouldBePrinted = 'true'">
			<xsl:apply-templates select="part:tia_Gegevens/part:GBA_Ingezetene | part:tia_Gegevens/part:IMKAD_NietIngezetene" mode="do-gender-salutation-part" />
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:choose>
			<xsl:when test="part:tia_Gegevens/part:IMKAD_KadNatuurlijkPersoon">
				<xsl:apply-templates select="part:tia_Gegevens/part:IMKAD_KadNatuurlijkPersoon" mode="do-person-data-part" />
				<xsl:text>, bij de gemeentelijke basisregistratie bekend als </xsl:text>
				<xsl:apply-templates select="part:tia_Gegevens/part:GBA_Ingezetene" mode="do-person-data-part" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="part:tia_Gegevens/part:GBA_Ingezetene | part:tia_Gegevens/part:IMKAD_NietIngezetene" mode="do-person-data-part" />
			</xsl:otherwise>
		</xsl:choose>
		<xsl:text>, </xsl:text>
		<xsl:apply-templates select="part:tia_Gegevens/part:GBA_Ingezetene | part:tia_Gegevens/part:IMKAD_NietIngezetene" mode="do-birth-data-part" />	
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
					translate(normalize-space(current()/part:tia_TekstKeuze[translate(part:tagNaam, $upper, $lower) = 'k_professor']/part:tekst), $upper, $lower)]), $upper, $lower)]" />
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:if test="(part:tia_AdellijkeTitel or part:adellijkeTitelOfPredikaat) and (normalize-space(part:tia_AdellijkeTitel) != '' or normalize-space(part:adellijkeTitelOfPredikaat) != '')">
			<xsl:value-of select="part:tia_AdellijkeTitel | part:adellijkeTitelOfPredikaat" />
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:if test="part:tia_Titel and normalize-space(part:tia_Titel) != ''">
			<xsl:value-of select="part:tia_Titel" />
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:value-of select="part:naam/part:voornamen | part:voornamen" />
		<xsl:text> </xsl:text>
		<xsl:if test="part:tia_AdellijkeTitel2 and normalize-space(part:tia_AdellijkeTitel2) != ''">
			<xsl:value-of select="part:tia_AdellijkeTitel2" />
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:if test="(part:tia_VoorvoegselsNaam or part:voorvoegsels or part:voorvoegselsgeslachtsnaam)
				and normalize-space(part:tia_VoorvoegselsNaam | part:voorvoegsels | part:voorvoegselsgeslachtsnaam) != ''">
			<xsl:value-of select="part:tia_VoorvoegselsNaam | part:voorvoegsels | part:voorvoegselsgeslachtsnaam" />
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:value-of select="part:tia_NaamZonderVoorvoegsels | part:geslachtsnaam" />
		<xsl:if test="part:tia_Titel2 and normalize-space(part:tia_Titel2) != ''">
			<xsl:text> </xsl:text>
			<xsl:value-of select="part:tia_Titel2" />
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
		<xsl:variable name="Datum_DATE" select="substring(string(part:geboorte/part:geboortedatum | part:geboortedatum), 0, 11)" />
		<xsl:variable name="Datum_STRING">
			<xsl:if test="$Datum_DATE != ''">
				<xsl:value-of select="kef:convertDateToText($Datum_DATE)" />
			</xsl:if>
		</xsl:variable>
		<xsl:text>geboren te </xsl:text>
		<xsl:value-of select="part:geboorte/part:geboorteplaatsOmschrijving | part:geboorteplaats" />
		<xsl:text> op </xsl:text>
		<xsl:value-of select="$Datum_STRING" />
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
		<xsl:apply-templates select="part:adres/part:binnenlandsAdres | part:adres/part:buitenlandsAdres" mode="do-address-part" />
	</xsl:template>

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="part:binnenlandsAdres" mode="do-address-part">
		<!-- Insert space between numbers and letters of post code -->
		<xsl:value-of select="concat(normalize-space(substring(part:BAG_NummerAanduiding/part:postcode, 1, 4)), ' ', normalize-space(substring(part:BAG_NummerAanduiding/part:postcode, 5)))" />
		<xsl:text> </xsl:text>
		<xsl:value-of select="part:BAG_Woonplaats/part:woonplaatsNaam" />
		<xsl:text>, </xsl:text>
		<xsl:value-of select="part:BAG_OpenbareRuimte/part:openbareRuimteNaam" />
		<xsl:text> </xsl:text>
		<xsl:value-of select="part:BAG_NummerAanduiding/part:huisnummer" />
		<xsl:if test="part:BAG_NummerAanduiding/part:huisletter and normalize-space(part:BAG_NummerAanduiding/part:huisletter) != ''">
			<xsl:text> </xsl:text>
			<xsl:value-of select="part:BAG_NummerAanduiding/part:huisletter" />
		</xsl:if>
		<xsl:if test="part:BAG_NummerAanduiding/part:huisnummertoevoeging and normalize-space(part:BAG_NummerAanduiding/part:huisnummertoevoeging) != ''">
			<xsl:text> </xsl:text>
			<xsl:value-of select="part:BAG_NummerAanduiding/part:huisnummertoevoeging" />
		</xsl:if>
	</xsl:template>

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="part:buitenlandsAdres" mode="do-address-part">
		<xsl:value-of select="part:woonplaats" />
		<xsl:text>, </xsl:text>
		<xsl:value-of select="part:adres" />
		<xsl:text> </xsl:text>
		<xsl:if test="part:regio and normalize-space(part:regio) != ''">
			<xsl:value-of select="part:regio" />
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:value-of select="part:land" />
	</xsl:template>

</xsl:stylesheet>
