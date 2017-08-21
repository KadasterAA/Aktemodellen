<?xml version="1.0" encoding="UTF-8"?>
<!--
*********************************************************
Stylesheet: hypotheek_rabobank.xsl
Version: 3.9.0 (AA-910: TB Burgerlijke Staat en TB Gevolmachtigde)
*********************************************************
Description:
Rabobank mortgage deed.

Public:
(mode) do-deed

Private:
(mode) do-parties
(mode) do-party-person
(mode) do-natural-person-rabo
(mode) do-gender-salutation-rabo
(mode) do-person-data-rabo
(mode) do-birth-data-rabo
(mode) do-address-rabo
-->
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
	xmlns:tia="http://www.kadaster.nl/schemas/KIK/TIA_Algemeen"
	xmlns:rabo="http://www.kadaster.nl/schemas/KIK/RabobankHypotheekakte/v20100406"
	xmlns:kef="nl.kadaster.xslt.XslExtensionFunctions"
	xmlns:xlink="http://www.w3.org/1999/xlink"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:gc="http://docs.oasis-open.org/codelist/ns/genericode/1.0/"
	exclude-result-prefixes="tia rabo kef xsl xlink gc"
	version="1.0">

	<xsl:include href="generiek-1.08.xsl" />
	<xsl:include href="tekstblok_aanhef-1.17.xsl" />
	<xsl:include href="tekstblok_burgerlijke_staat-1.02.xsl" />
	<xsl:include href="tekstblok_equivalentieverklaring-1.25.xsl" />
	<xsl:include href="tekstblok_gevolmachtigde-1.26.xsl" />
	<xsl:include href="tekstblok_legitimatie-1.01.xsl" />
	<xsl:include href="tekstblok_natuurlijk_persoon-1.12.xsl" />
	<xsl:include href="tekstblok_overbruggingshypotheek-1.07.xsl" />
	<xsl:include href="tekstblok_personalia_van_natuurlijk_persoon-1.06.xsl" />
	<xsl:include href="tekstblok_partij_natuurlijk_persoon-1.39.xsl" />
	<xsl:include href="tekstblok_partij_niet_natuurlijk_persoon-1.52.xsl" />
	<xsl:include href="tekstblok_partijnamen_in_hypotheekakten-1.14.xsl" />
	<xsl:include href="tekstblok_recht-1.16.xsl" />
	<xsl:include href="tekstblok_rechtspersoon-1.14.0.xsl" />
	<xsl:include href="tekstblok_registergoed-1.26.xsl" />
	<xsl:include href="tekstblok_titel_hypotheekakten-1.01.xsl" />
	<xsl:include href="tekstblok_woonadres-1.05.xsl" />
	<xsl:include href="tweededeel-1.05.xsl" />

	<!-- Rabobank specific global variables -->
	<xsl:variable name="keuzeteksten" select="document('keuzeteksten_hypotheek_rabobank-3.9.0.xml')" />
	<xsl:variable name="legalPersonNames" select="document('nnp-kodes_hypotheek.xml')/gc:CodeList/SimpleCodeList/Row" />
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

	Description: Rabobank mortgage deed.

	Input: tia:Bericht_TIA_Stuk

	Params: none

	Output: XHTML structure

	Calls:
	(mode) do-statement-of-equivalence
	(mode) do-mortgage-deed-title
	(mode) do-header
	(mode) do-parties
	(mode) do-natural-person-rabo
	(mode) do-address-rabo
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
			<xsl:text>Van het bestaan van de volmacht</xsl:text>
			<xsl:value-of select="tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoudvolmachten']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
					translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoudvolmachten']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
					translate(normalize-space(current()/tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoudvolmachten']/tia:tekst), $upper, $lower)]), $upper, $lower)]" />
			<xsl:text> aan de comparant</xsl:text>
			<xsl:choose>
				<xsl:when test="(tia:IMKAD_AangebodenStuk/tia:Partij[@id = substring-after(current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:Gevolmachtigde
						and translate(tia:IMKAD_AangebodenStuk/tia:Partij[@id = substring-after(current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:Gevolmachtigde/tia:gegevens/tia:persoonGegevens/tia:geslacht/tia:geslachtsaanduiding, $upper, $lower) = 'vrouw')">
					<xsl:text>e</xsl:text>
				</xsl:when>
			</xsl:choose>
			<xsl:text> onder 2. genoemd is mij, notaris, genoegzaam gebleken.</xsl:text>
		</p>
		<!-- Contract of sale -->
		<h2 class="header"><xsl:text>Overeenkomst tot het vestigen van hypotheek- en pandrechten</xsl:text></h2>
		<p>
			<xsl:text>De hypotheekgever en de bank verklaarden te zijn overeengekomen dat door de hypotheekgever ten behoeve van de bank het recht van hypotheek en pandrechten worden gevestigd op de in deze akte en de hierna vermelde Algemene voorwaarden voor hypotheken van de Rabobank 2009 omschreven goederen, tot zekerheid als in deze akte omschreven.</xsl:text>
		</p>
		<!-- Mortgage loan -->
		<a name="hyp3.rabobankMortgageProvision" class="location">&#160;</a>
		<h2 class="header"><xsl:text>Hypotheekverlening</xsl:text></h2>
		<p>
			<xsl:text>Ter uitvoering van voormelde overeenkomst verklaarde de hypotheekgever aan de bank hypotheek te verlenen tot het hierna te noemen bedrag op het hierna te noemen onderpand, tot zekerheid voor de betaling van al hetgeen de bank blijkens haar administratie van de hierna te noemen debiteur,</xsl:text>
			<xsl:if test="translate(tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_rabo_iederafzonderlijk']/tia:tekst, $upper, $lower) = 'true'">
				<xsl:text> </xsl:text>
				<xsl:value-of select="normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_rabo_iederafzonderlijk']/tia:tekst)" />
			</xsl:if>
			<xsl:text> te vorderen heeft of mocht hebben uit hoofde van:</xsl:text>
		</p>
		<!-- Type of Mortgage -->
		<a name="hyp3.rabobankMortgageType" class="location">&#160;</a>
		<xsl:choose>
			<xsl:when test="tia:partnerSpecifiek/rabo:BankHypotheek">
				<xsl:if test="count(tia:partnerSpecifiek/rabo:BankHypotheek/rabo:omschrijving) > 0">
					<table cellpadding="0" cellspacing="0">
						<tbody>
							<xsl:for-each select="tia:partnerSpecifiek/rabo:BankHypotheek/rabo:omschrijving">
								<tr>
									<td class="number" valign="top">
										<xsl:text>-</xsl:text>
									</td>
									<td>
										<xsl:value-of select="." />
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
				<p>
					<xsl:text>De bank is bevoegd -en de hypotheekgever stemt er bij voorbaat mee in- om borgtochten, garanties en vergelijkbare (persoonlijke) zekerheden af te geven aan andere rechtspersonen die op het moment van afgifte tot de Rabobank Groep behoren tot zekerheid voor (toekomstige) vorderingen van een dergelijke rechtspersoon op de debiteur uit welken hoofde dan ook.</xsl:text>
				</p>
			</xsl:when>
			<xsl:when test="tia:partnerSpecifiek/rabo:VasteHypotheekGeenSchip">
				<xsl:variable name="vasteHypotheekGeenSchip" select="tia:partnerSpecifiek/rabo:VasteHypotheekGeenSchip" />
				<p>
					<xsl:choose>
						<xsl:when test="$vasteHypotheekGeenSchip/rabo:vasteHypotheek/rabo:OnderhandseAkte">
							<xsl:text>de blijkens onderhandse akte(n) </xsl:text>
							<xsl:if test="count($vasteHypotheekGeenSchip/rabo:vasteHypotheek/rabo:OnderhandseAkte/rabo:datum) > 1">
								<xsl:text>respectievelijk </xsl:text>
							</xsl:if>
							<xsl:text>gedateerd: </xsl:text>
							<xsl:for-each select="$vasteHypotheekGeenSchip/rabo:vasteHypotheek/rabo:OnderhandseAkte/rabo:datum">
								<xsl:variable name="Datum_DATE" select="substring(string(.), 0, 11)" />
								<xsl:variable name="Datum_STRING">
									<xsl:if test="$Datum_DATE != ''">
										<xsl:value-of select="kef:convertDateToText($Datum_DATE)" />
									</xsl:if>
								</xsl:variable>
								<xsl:value-of select="$Datum_STRING" />
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
						<xsl:when test="$vasteHypotheekGeenSchip/rabo:vasteHypotheek/rabo:Financieringsvoorstel or $vasteHypotheekGeenSchip/rabo:vasteHypotheek/rabo:FinancieringsvoorstelAcceptatie">
							<xsl:choose>
								<xsl:when test="count($vasteHypotheekGeenSchip/rabo:vasteHypotheek/rabo:Financieringsvoorstel/rabo:datum) = 1">
									<xsl:text>het financieringsvoorstel </xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>de financieringsvoorstellen </xsl:text>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:if test="count($vasteHypotheekGeenSchip/rabo:vasteHypotheek/rabo:Financieringsvoorstel/rabo:datum) > 1">
								<xsl:text>respectievelijk </xsl:text>
							</xsl:if>
							<xsl:text>gedateerd </xsl:text>
							<xsl:for-each select="$vasteHypotheekGeenSchip/rabo:vasteHypotheek/rabo:Financieringsvoorstel/rabo:datum">
								<xsl:variable name="Datum_DATE" select="substring(string(.), 0, 11)" />
								<xsl:variable name="Datum_STRING">
									<xsl:if test="$Datum_DATE != ''">
										<xsl:value-of select="kef:convertDateToText($Datum_DATE)" />
									</xsl:if>
								</xsl:variable>
								<xsl:value-of select="$Datum_STRING" />
								<xsl:choose>
									<xsl:when test="position() = (last() - 1)">
										<xsl:text> en </xsl:text>
									</xsl:when>
									<xsl:when test="position() != last()">
										<xsl:text>, </xsl:text>
									</xsl:when>
								</xsl:choose>
							</xsl:for-each>
							<xsl:if test="$vasteHypotheekGeenSchip/rabo:vasteHypotheek/rabo:FinancieringsvoorstelAcceptatie">
								<xsl:if test="count($vasteHypotheekGeenSchip/rabo:vasteHypotheek/rabo:FinancieringsvoorstelAcceptatie/rabo:datum) > 1">
									<xsl:text> respectievelijk</xsl:text>
								</xsl:if>
								<xsl:text> geaccepteerd op </xsl:text>
								<xsl:for-each select="$vasteHypotheekGeenSchip/rabo:vasteHypotheek/rabo:FinancieringsvoorstelAcceptatie/rabo:datum">
									<xsl:variable name="Datum_DATE" select="substring(string(.), 0, 11)" />
									<xsl:variable name="Datum_STRING">
										<xsl:if test="$Datum_DATE != ''">
											<xsl:value-of select="kef:convertDateToText($Datum_DATE)" />
										</xsl:if>
									</xsl:variable>
									<xsl:value-of select="$Datum_STRING" />
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
				<xsl:if test="$vasteHypotheekGeenSchip/rabo:Geldleningen or $vasteHypotheekGeenSchip/rabo:Kredieten or $vasteHypotheekGeenSchip/rabo:Borgtochten">
					<table cellpadding="0" cellspacing="0">
						<tbody>
							<xsl:if test="$vasteHypotheekGeenSchip/rabo:Geldleningen">
								<tr>
									<td class="number" valign="top">
										<xsl:text>1)</xsl:text>
									</td>
									<td>
										<xsl:value-of select="$vasteHypotheekGeenSchip/rabo:Geldleningen/rabo:tekstKeuze[translate(rabo:tagNaam, $upper, $lower) = 'k_hyp_verstrekt']/rabo:tekst[translate(normalize-space(.), $upper, $lower) =
												translate(normalize-space($keuzeteksten/*/rabo:tekstKeuze[translate(rabo:tagNaam, $upper, $lower) = 'k_hyp_verstrekt']/rabo:tekst[translate(normalize-space(.), $upper, $lower) =
												translate(normalize-space($vasteHypotheekGeenSchip/rabo:Geldleningen/rabo:tekstKeuze[translate(rabo:tagNaam, $upper, $lower) = 'k_hyp_verstrekt']/rabo:tekst), $upper, $lower)]), $upper, $lower)]" />
										<xsl:choose>
											<xsl:when test="count($vasteHypotheekGeenSchip/rabo:Geldleningen/rabo:bedrag) = 1">
												<xsl:text> geldlening groot </xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text> geldleningen respectievelijk groot </xsl:text>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:for-each select="$vasteHypotheekGeenSchip/rabo:Geldleningen/rabo:bedrag">
											<xsl:call-template name="amountText">
												<xsl:with-param name="amount" select="rabo:som" />
												<xsl:with-param name="valuta" select="rabo:valuta" />
											</xsl:call-template>
											<xsl:text> </xsl:text>
											<xsl:call-template name="amountNumber">
												<xsl:with-param name="amount" select="rabo:som" />
												<xsl:with-param name="valuta" select="rabo:valuta" />
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
											<xsl:when test="$vasteHypotheekGeenSchip/rabo:Kredieten or $vasteHypotheekGeenSchip/rabo:Borgtochten">
												<xsl:text>;</xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text>.</xsl:text>
											</xsl:otherwise>
										</xsl:choose>
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="$vasteHypotheekGeenSchip/rabo:Kredieten">
								<xsl:variable name="position">
									<xsl:value-of select="count($vasteHypotheekGeenSchip/rabo:Geldleningen) + 1" />
								</xsl:variable>
								<tr>
									<td class="number" valign="top">
										<xsl:value-of select="$position" />
										<xsl:text>)</xsl:text>
									</td>
									<td>
										<xsl:value-of select="$vasteHypotheekGeenSchip/rabo:Kredieten/rabo:tekstKeuze[translate(rabo:tagNaam, $upper, $lower) = 'k_hyp_verleend']/rabo:tekst[translate(normalize-space(.), $upper, $lower) =
												translate(normalize-space($keuzeteksten/*/rabo:tekstKeuze[translate(rabo:tagNaam, $upper, $lower) = 'k_hyp_verleend']/rabo:tekst[translate(normalize-space(.), $upper, $lower) =
												translate(normalize-space($vasteHypotheekGeenSchip/rabo:Kredieten/rabo:tekstKeuze[translate(rabo:tagNaam, $upper, $lower) = 'k_hyp_verleend']/rabo:tekst), $upper, $lower)]), $upper, $lower)]" />
										<xsl:choose>
											<xsl:when test="count($vasteHypotheekGeenSchip/rabo:Kredieten/rabo:bedrag) = 1">
												<xsl:text> krediet groot </xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text> kredieten respectievelijk groot </xsl:text>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:for-each select="$vasteHypotheekGeenSchip/rabo:Kredieten/rabo:bedrag">
											<xsl:call-template name="amountText">
												<xsl:with-param name="amount" select="rabo:som" />
												<xsl:with-param name="valuta" select="rabo:valuta" />
											</xsl:call-template>
											<xsl:text> </xsl:text>
											<xsl:call-template name="amountNumber">
												<xsl:with-param name="amount" select="rabo:som" />
												<xsl:with-param name="valuta" select="rabo:valuta" />
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
											<xsl:when test="$vasteHypotheekGeenSchip/rabo:Borgtochten">
												<xsl:text>;</xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text>.</xsl:text>
											</xsl:otherwise>
										</xsl:choose>
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="$vasteHypotheekGeenSchip/rabo:Borgtochten">
								<xsl:variable name="position">
									<xsl:value-of select="count($vasteHypotheekGeenSchip/rabo:Geldleningen) + count($vasteHypotheekGeenSchip/rabo:Kredieten) + 1" />
								</xsl:variable>
								<tr>
									<td class="number" valign="top">
										<xsl:value-of select="$position" />
										<xsl:text>)</xsl:text>
									</td>
									<td>
										<xsl:value-of select="$vasteHypotheekGeenSchip/rabo:Borgtochten/rabo:tekstKeuze[translate(rabo:tagNaam, $upper, $lower) = 'k_hyp_gesteld']/rabo:tekst[translate(normalize-space(.), $upper, $lower) =
												translate(normalize-space($keuzeteksten/*/rabo:tekstKeuze[translate(rabo:tagNaam, $upper, $lower) = 'k_hyp_gesteld']/rabo:tekst[translate(normalize-space(.), $upper, $lower) =
												translate(normalize-space($vasteHypotheekGeenSchip/rabo:Borgtochten/rabo:tekstKeuze[translate(rabo:tagNaam, $upper, $lower) = 'k_hyp_gesteld']/rabo:tekst), $upper, $lower)]), $upper, $lower)]" />
										<xsl:choose>
											<xsl:when test="count($vasteHypotheekGeenSchip/rabo:Borgtochten/rabo:IMKAD_Persoon) = 1">
												<xsl:text> borgtocht </xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text> borgtochten </xsl:text>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:text>voor </xsl:text>
										<xsl:for-each select="$vasteHypotheekGeenSchip/rabo:Borgtochten/rabo:IMKAD_Persoon">
											<xsl:apply-templates select="." mode="do-natural-person-rabo" />
											<xsl:text> wonende te </xsl:text>
											<xsl:apply-templates select="rabo:IMKAD_WoonlocatiePersoon" mode="do-address-rabo" />
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
			<xsl:when test="tia:partnerSpecifiek/rabo:VasteHypotheekSchip">
				<xsl:variable name="vasteHypotheekSchip" select="tia:partnerSpecifiek/rabo:VasteHypotheekSchip" />
				<p>
					<xsl:choose>
						<xsl:when test="$vasteHypotheekSchip/rabo:vasteHypotheek/rabo:OnderhandseAkte">
							<xsl:text>de blijkens onderhandse akte(n) </xsl:text>
							<xsl:if test="count($vasteHypotheekSchip/rabo:vasteHypotheek/rabo:OnderhandseAkte/rabo:datum) > 1">
								<xsl:text>respectievelijk </xsl:text>
							</xsl:if>
							<xsl:text>gedateerd: </xsl:text>
							<xsl:for-each select="$vasteHypotheekSchip/rabo:vasteHypotheek/rabo:OnderhandseAkte/rabo:datum">
								<xsl:variable name="Datum_DATE" select="substring(string(.), 0, 11)" />
								<xsl:variable name="Datum_STRING">
									<xsl:if test="$Datum_DATE != ''">
										<xsl:value-of select="kef:convertDateToText($Datum_DATE)" />
									</xsl:if>
								</xsl:variable>
								<xsl:value-of select="$Datum_STRING" />
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
						<xsl:when test="$vasteHypotheekSchip/rabo:vasteHypotheek/rabo:Financieringsvoorstel or $vasteHypotheekSchip/rabo:vasteHypotheek/rabo:FinancieringsvoorstelAcceptatie">
							<xsl:choose>
								<xsl:when test="count($vasteHypotheekSchip/rabo:vasteHypotheek/rabo:Financieringsvoorstel/rabo:datum) = 1">
									<xsl:text>het financieringsvoorstel </xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>de financieringsvoorstellen </xsl:text>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:if test="count($vasteHypotheekSchip/rabo:vasteHypotheek/rabo:Financieringsvoorstel/rabo:datum) > 1">
								<xsl:text>respectievelijk </xsl:text>
							</xsl:if>
							<xsl:text>gedateerd </xsl:text>
							<xsl:for-each select="$vasteHypotheekSchip/rabo:vasteHypotheek/rabo:Financieringsvoorstel/rabo:datum">
								<xsl:variable name="Datum_DATE" select="substring(string(.), 0, 11)" />
								<xsl:variable name="Datum_STRING">
									<xsl:if test="$Datum_DATE != ''">
										<xsl:value-of select="kef:convertDateToText($Datum_DATE)" />
									</xsl:if>
								</xsl:variable>
								<xsl:value-of select="$Datum_STRING" />
								<xsl:choose>
									<xsl:when test="position() = (last() - 1)">
										<xsl:text> en </xsl:text>
									</xsl:when>
									<xsl:when test="position() != last()">
										<xsl:text>, </xsl:text>
									</xsl:when>
								</xsl:choose>
							</xsl:for-each>
							<xsl:if test="$vasteHypotheekSchip/rabo:vasteHypotheek/rabo:FinancieringsvoorstelAcceptatie">
								<xsl:if test="count($vasteHypotheekSchip/rabo:vasteHypotheek/rabo:FinancieringsvoorstelAcceptatie/rabo:datum) > 1">
									<xsl:text> respectievelijk</xsl:text>
								</xsl:if>
								<xsl:text> geaccepteerd op </xsl:text>
								<xsl:for-each select="$vasteHypotheekSchip/rabo:vasteHypotheek/rabo:FinancieringsvoorstelAcceptatie/rabo:datum">
									<xsl:variable name="Datum_DATE" select="substring(string(.), 0, 11)" />
									<xsl:variable name="Datum_STRING">
										<xsl:if test="$Datum_DATE != ''">
											<xsl:value-of select="kef:convertDateToText($Datum_DATE)" />
										</xsl:if>
									</xsl:variable>
									<xsl:value-of select="$Datum_STRING" />
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
				<xsl:if test="$vasteHypotheekSchip/rabo:GeldleningenInclRente or $vasteHypotheekSchip/rabo:KredietenInclRente">
					<table cellpadding="0" cellspacing="0">
						<tbody>
							<xsl:if test="$vasteHypotheekSchip/rabo:GeldleningenInclRente">
								<tr>
									<td class="number" valign="top">
										<xsl:text>1)</xsl:text>
									</td>
									<td>
										<xsl:value-of select="$vasteHypotheekSchip/rabo:GeldleningenInclRente/rabo:Geldleningen/rabo:tekstKeuze[translate(rabo:tagNaam, $upper, $lower) = 'k_hyp_verstrekt']/rabo:tekst[translate(normalize-space(.), $upper, $lower) =
												translate(normalize-space($keuzeteksten/*/rabo:tekstKeuze[translate(rabo:tagNaam, $upper, $lower) = 'k_hyp_verstrekt']/rabo:tekst[translate(normalize-space(.), $upper, $lower) =
												translate(normalize-space($vasteHypotheekSchip/rabo:GeldleningenInclRente/rabo:Geldleningen/rabo:tekstKeuze[translate(rabo:tagNaam, $upper, $lower) = 'k_hyp_verstrekt']/rabo:tekst), $upper, $lower)]), $upper, $lower)]" />
										<xsl:choose>
											<xsl:when test="count($vasteHypotheekSchip/rabo:GeldleningenInclRente/rabo:Geldleningen/rabo:bedrag) = 1">
												<xsl:text> geldlening groot </xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text> geldleningen respectievelijk groot </xsl:text>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:for-each select="$vasteHypotheekSchip/rabo:GeldleningenInclRente/rabo:Geldleningen/rabo:bedrag">
											<xsl:call-template name="amountText">
												<xsl:with-param name="amount" select="rabo:som" />
												<xsl:with-param name="valuta" select="rabo:valuta" />
											</xsl:call-template>
											<xsl:text> </xsl:text>
											<xsl:call-template name="amountNumber">
												<xsl:with-param name="amount" select="rabo:som" />
												<xsl:with-param name="valuta" select="rabo:valuta" />
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
											<xsl:when test="count($vasteHypotheekSchip/rabo:GeldleningenInclRente/rabo:rente/rabo:Rentepercentage/rabo:percentage) = 1">
												<xsl:text>bedraagt de bedongen rente voor deze geldlening </xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text>bedragen de bedongen renten voor deze geldleningen respectievelijk </xsl:text>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:for-each select="$vasteHypotheekSchip/rabo:GeldleningenInclRente/rabo:rente/rabo:Rentepercentage/rabo:percentage">
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
										<xsl:if test="count($vasteHypotheekSchip/rabo:GeldleningenInclRente/rabo:rente/rabo:VervalDatum/rabo:datum) > 1">
											<xsl:text>respectievelijk </xsl:text>
										</xsl:if>
										<xsl:text>op </xsl:text>
										<xsl:for-each select="$vasteHypotheekSchip/rabo:GeldleningenInclRente/rabo:rente/rabo:VervalDatum/rabo:datum">
											<xsl:variable name="Datum_DATE" select="substring(string(.), 0, 11)" />
											<xsl:variable name="Datum_STRING">
												<xsl:if test="$Datum_DATE != ''">
													<xsl:value-of select="kef:convertDateToText($Datum_DATE)" />
												</xsl:if>
											</xsl:variable>
											<xsl:value-of select="$Datum_STRING" />
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
										<xsl:for-each select="$vasteHypotheekSchip/rabo:GeldleningenInclRente/rabo:rente/rabo:EersteVervalDatum/rabo:datum">
											<xsl:variable name="Datum_DATE" select="substring(string(.), 0, 11)" />
											<xsl:variable name="Datum_STRING">
												<xsl:if test="$Datum_DATE != ''">
													<xsl:value-of select="kef:convertDateToText($Datum_DATE)" />
												</xsl:if>
											</xsl:variable>
											<xsl:value-of select="$Datum_STRING" />
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
											<xsl:when test="$vasteHypotheekSchip/rabo:KredietenInclRente">
												<xsl:text>;</xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text>.</xsl:text>
											</xsl:otherwise>
										</xsl:choose>
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="$vasteHypotheekSchip/rabo:KredietenInclRente">
								<xsl:variable name="position">
									<xsl:value-of select="count($vasteHypotheekSchip/rabo:GeldleningenInclRente) + 1" />
								</xsl:variable>
								<tr>
									<td class="number" valign="top">
										<xsl:value-of select="$position" />
										<xsl:text>)</xsl:text>
									</td>
									<td>
										<xsl:value-of select="$vasteHypotheekSchip/rabo:KredietenInclRente/rabo:Kredieten/rabo:tekstKeuze[translate(rabo:tagNaam, $upper, $lower) = 'k_hyp_verleend']/rabo:tekst[translate(normalize-space(.), $upper, $lower) =
												translate(normalize-space($keuzeteksten/*/rabo:tekstKeuze[translate(rabo:tagNaam, $upper, $lower) = 'k_hyp_verleend']/rabo:tekst[translate(normalize-space(.), $upper, $lower) =
												translate(normalize-space($vasteHypotheekSchip/rabo:KredietenInclRente/rabo:Kredieten/rabo:tekstKeuze[translate(rabo:tagNaam, $upper, $lower) = 'k_hyp_verleend']/rabo:tekst), $upper, $lower)]), $upper, $lower)]" />
										<xsl:choose>
											<xsl:when test="count($vasteHypotheekSchip/rabo:KredietenInclRente/rabo:Kredieten/rabo:bedrag) = 1">
												<xsl:text> krediet groot </xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text> kredieten respectievelijk groot </xsl:text>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:for-each select="$vasteHypotheekSchip/rabo:KredietenInclRente/rabo:Kredieten/rabo:bedrag">
											<xsl:call-template name="amountText">
												<xsl:with-param name="amount" select="rabo:som" />
												<xsl:with-param name="valuta" select="rabo:valuta" />
											</xsl:call-template>
											<xsl:text> </xsl:text>
											<xsl:call-template name="amountNumber">
												<xsl:with-param name="amount" select="rabo:som" />
												<xsl:with-param name="valuta" select="rabo:valuta" />
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
											<xsl:when test="count($vasteHypotheekSchip/rabo:KredietenInclRente/rabo:rente/rabo:Rentepercentage/rabo:percentage) = 1">
												<xsl:text>bedraagt de bedongen rente voor dit krediet </xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text>bedragen de bedongen renten voor deze kredieten respectievelijk </xsl:text>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:for-each select="$vasteHypotheekSchip/rabo:KredietenInclRente/rabo:rente/rabo:Rentepercentage/rabo:percentage">
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
										<xsl:if test="count($vasteHypotheekSchip/rabo:KredietenInclRente/rabo:rente/rabo:VervalDatum/rabo:datum) > 1">
											<xsl:text>respectievelijk </xsl:text>
										</xsl:if>
										<xsl:text>op </xsl:text>
										<xsl:for-each select="$vasteHypotheekSchip/rabo:KredietenInclRente/rabo:rente/rabo:VervalDatum/rabo:datum">
											<xsl:variable name="Datum_DATE" select="substring(string(.), 0, 11)" />
											<xsl:variable name="Datum_STRING">
												<xsl:if test="$Datum_DATE != ''">
													<xsl:value-of select="kef:convertDateToText($Datum_DATE)" />
												</xsl:if>
											</xsl:variable>
											<xsl:value-of select="$Datum_STRING" />
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
										<xsl:for-each select="$vasteHypotheekSchip/rabo:KredietenInclRente/rabo:rente/rabo:EersteVervalDatum/rabo:datum">
											<xsl:variable name="Datum_DATE" select="substring(string(.), 0, 11)" />
											<xsl:variable name="Datum_STRING">
												<xsl:if test="$Datum_DATE != ''">
													<xsl:value-of select="kef:convertDateToText($Datum_DATE)" />
												</xsl:if>
											</xsl:variable>
											<xsl:value-of select="$Datum_STRING" />
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
				<h2 class="header"><xsl:text>Opeisbaarheid</xsl:text></h2>
				<p>
					<xsl:text>De hypotheekgever en de bank verklaarden dat het door een debiteur aan de bank verschuldigde onmiddellijk opeisbaar is of met onmiddellijke ingang door de bank kan worden opge&#x00EB;ist als zich een opeisingsgrond en/of omstandigheid die tot opeisbaarheid leidt voordoet welke is opgenomen in de hierna genoemde, in de openbare registers ingeschreven, algemene voorwaarden.</xsl:text>
					<br />
					<xsl:for-each select="$vasteHypotheekSchip/rabo:AlgemeneVoorwaarden/rabo:AlgemeneVoorwaardenBank">
						<xsl:variable name="Datum_DATE" select="substring(string(rabo:datumInschrijving), 0, 11)" />
						<xsl:variable name="Datum_STRING">
							<xsl:if test="$Datum_DATE != ''">
								<xsl:value-of select="kef:convertDateToText($Datum_DATE)" />
							</xsl:if>
						</xsl:variable>
						<xsl:choose>
							<xsl:when test="translate(rabo:soortVoorwaarden, $upper, $lower) = 'bank'">
								<xsl:text>De Algemene Bankvoorwaarden welke zijn ingeschreven op </xsl:text>
							</xsl:when>
							<xsl:when test="translate(rabo:soortVoorwaarden, $upper, $lower) = 'hypotheken'">
								<xsl:text>De Algemene voorwaarden voor hypotheken van de Rabobank 2009 welke zijn ingeschreven op </xsl:text>
							</xsl:when>
							<xsl:when test="translate(rabo:soortVoorwaarden, $upper, $lower) = 'particuliere geldleningen'">
								<xsl:text>De Algemene voorwaarden voor particuliere geldleningen van de Rabobank 2008 welke zijn ingeschreven op </xsl:text>
							</xsl:when>
							<xsl:when test="translate(rabo:soortVoorwaarden, $upper, $lower) = 'betaalrekeningen'">
								<xsl:text>De Algemene voorwaarden voor betaalrekeningen en betaaldiensten van de Rabobank 2009 welke zijn ingeschreven op </xsl:text>
							</xsl:when>
							<xsl:when test="translate(rabo:soortVoorwaarden, $upper, $lower) = 'zakelijke geldleningen'">
								<xsl:text>De Algemene voorwaarden voor zakelijke geldleningen van de Rabobank 2008 welke zijn ingeschreven op </xsl:text>
							</xsl:when>
							<xsl:when test="translate(rabo:soortVoorwaarden, $upper, $lower) = 'rekening-courant'">
								<xsl:text>De Algemene voorwaarden voor rekening-courant en krediet van de Rabobank 2009 welke zijn ingeschreven op </xsl:text>
							</xsl:when>
						</xsl:choose>
						<xsl:value-of select="$Datum_STRING" />
						<xsl:text> ten kantore van de Dienst voor het Kadaster en de openbare registers in Register Hypotheken 4 deel </xsl:text>
						<xsl:value-of select="rabo:deel" />
						<xsl:text> nummer </xsl:text>
						<xsl:value-of select="rabo:nummer" />
						<xsl:text>.</xsl:text>
						<br />
					</xsl:for-each>
					<xsl:text>De hypotheekgever en de bank verklaarden dat onverminderd het vorenstaande het door een debiteur aan de bank verschuldigde - tenzij schriftelijk anders is overeengekomen - altijd opeisbaar is:</xsl:text>
				</p>
				<table cellpadding="0" cellspacing="0">
					<tbody>
						<tr>
							<td class="number" valign="top">
								<xsl:text>-</xsl:text>
							</td>
							<td>
								<xsl:text>drie maanden na door de bank gedane opzegging van een vordering waarvoor deze hypotheek tot zekerheid strekt, of</xsl:text>
							</td>
						</tr>
						<tr>
							<td class="number" valign="top">
								<xsl:text>-</xsl:text>
							</td>
							<td>
								<xsl:text>de bank de debiteur als borg heeft aangesproken, of</xsl:text>
							</td>
						</tr>
						<tr>
							<td class="number" valign="top">
								<xsl:text>-</xsl:text>
							</td>
							<td>
								<xsl:text>wanneer een rechtspersoon of vennootschap in wiens geconsolideerde jaarrekening de financiële gegevens van een debiteur zijn geconsolideerd, de aansprakelijkheidstelling als bedoeld in artikel 2:403 Burgerlijk Wetboek intrekt.</xsl:text>
							</td>
						</tr>
					</tbody>
				</table>
			</xsl:when>
		</xsl:choose>
		<!-- Mortgage amount -->
		<a name="hyp3.mortgageAmountAndAdditionalCosts" class="location">&#160;</a>
		<h2 class="header"><xsl:text>Hypotheekbedrag</xsl:text></h2>
		<p>
			<xsl:text>De hypotheekgever verklaarde dat het recht van hypotheek is verleend tot:</xsl:text>
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
					<xsl:when test="tia:partnerSpecifiek/rabo:AanvullendeKosten/rabo:RegistergoedGeenSchip">
						<tr>
							<td class="number" valign="top">
								<xsl:text>b)</xsl:text>
							</td>
							<td>
								<xsl:text>renten, vergoedingen, boeten en kosten, welke samen worden begroot op vijfendertig procent (35%) van het hiervoor onder a vermelde bedrag, derhalve tot een bedrag van </xsl:text>
								<xsl:call-template name="amountText">
									<xsl:with-param name="amount" select="tia:partnerSpecifiek/rabo:AanvullendeKosten/rabo:RegistergoedGeenSchip/rabo:bedragRente/rabo:som" />
									<xsl:with-param name="valuta" select="tia:partnerSpecifiek/rabo:AanvullendeKosten/rabo:RegistergoedGeenSchip/rabo:bedragRente/rabo:valuta" />
								</xsl:call-template>
								<xsl:text> </xsl:text>
								<xsl:call-template name="amountNumber">
									<xsl:with-param name="amount" select="tia:partnerSpecifiek/rabo:AanvullendeKosten/rabo:RegistergoedGeenSchip/rabo:bedragRente/rabo:som" />
									<xsl:with-param name="valuta" select="tia:partnerSpecifiek/rabo:AanvullendeKosten/rabo:RegistergoedGeenSchip/rabo:bedragRente/rabo:valuta" />
								</xsl:call-template>
							</td>
						</tr>
					</xsl:when>
					<xsl:when test="tia:partnerSpecifiek/rabo:AanvullendeKosten/rabo:HypotheekMedeOpSchip">
						<tr>
							<td class="number" valign="top">
								<xsl:text>b)</xsl:text>
							</td>
							<td>
								<xsl:text>renten, vergoedingen, boeten en kosten, welke samen worden begroot op vijftig procent (50%) van het hiervoor onder a vermelde bedrag, derhalve tot een bedrag van </xsl:text>
								<xsl:call-template name="amountText">
									<xsl:with-param name="amount" select="tia:partnerSpecifiek/rabo:AanvullendeKosten/rabo:HypotheekMedeOpSchip/rabo:bedragRente/rabo:som" />
									<xsl:with-param name="valuta" select="tia:partnerSpecifiek/rabo:AanvullendeKosten/rabo:HypotheekMedeOpSchip/rabo:bedragRente/rabo:valuta" />
								</xsl:call-template>
								<xsl:text> </xsl:text>
								<xsl:call-template name="amountNumber">
									<xsl:with-param name="amount" select="tia:partnerSpecifiek/rabo:AanvullendeKosten/rabo:HypotheekMedeOpSchip/rabo:bedragRente/rabo:som" />
									<xsl:with-param name="valuta" select="tia:partnerSpecifiek/rabo:AanvullendeKosten/rabo:HypotheekMedeOpSchip/rabo:bedragRente/rabo:valuta" />
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
				<xsl:when test="tia:partnerSpecifiek/rabo:AanvullendeKosten/rabo:RegistergoedGeenSchip">
					<xsl:call-template name="amountText">
						<xsl:with-param name="amount" select="tia:partnerSpecifiek/rabo:AanvullendeKosten/rabo:RegistergoedGeenSchip/rabo:bedragTotaal/rabo:som" />
						<xsl:with-param name="valuta" select="tia:partnerSpecifiek/rabo:AanvullendeKosten/rabo:RegistergoedGeenSchip/rabo:bedragTotaal/rabo:valuta" />
					</xsl:call-template>
					<xsl:text> </xsl:text>
					<xsl:call-template name="amountNumber">
						<xsl:with-param name="amount" select="tia:partnerSpecifiek/rabo:AanvullendeKosten/rabo:RegistergoedGeenSchip/rabo:bedragTotaal/rabo:som" />
						<xsl:with-param name="valuta" select="tia:partnerSpecifiek/rabo:AanvullendeKosten/rabo:RegistergoedGeenSchip/rabo:bedragTotaal/rabo:valuta" />
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="tia:partnerSpecifiek/rabo:AanvullendeKosten/rabo:HypotheekMedeOpSchip">
					<xsl:call-template name="amountText">
						<xsl:with-param name="amount" select="tia:partnerSpecifiek/rabo:AanvullendeKosten/rabo:HypotheekMedeOpSchip/rabo:bedragTotaal/rabo:som" />
						<xsl:with-param name="valuta" select="tia:partnerSpecifiek/rabo:AanvullendeKosten/rabo:HypotheekMedeOpSchip/rabo:bedragTotaal/rabo:valuta" />
					</xsl:call-template>
					<xsl:text> </xsl:text>
					<xsl:call-template name="amountNumber">
						<xsl:with-param name="amount" select="tia:partnerSpecifiek/rabo:AanvullendeKosten/rabo:HypotheekMedeOpSchip/rabo:bedragTotaal/rabo:som" />
						<xsl:with-param name="valuta" select="tia:partnerSpecifiek/rabo:AanvullendeKosten/rabo:HypotheekMedeOpSchip/rabo:bedragTotaal/rabo:valuta" />
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
						<xsl:value-of select="$rightText"/>
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
						<xsl:value-of select="$rightText"/>
						<xsl:text> </xsl:text>
					</xsl:if>
					<xsl:apply-templates select="$allProcessedRights[1]" mode="do-registered-object"/>
					<xsl:text>;</xsl:text>
						<br />
					<xsl:text>hierna (zowel samen als ieder afzonderlijk) te noemen: '</xsl:text>
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
					<xsl:text>hierna (zowel samen als ieder afzonderlijk) te noemen: '</xsl:text>
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
			<xsl:text>De bank verklaarde het vorenstaande aan te nemen.</xsl:text>
		</p>
		<h2 class="header"><xsl:text>Opzegging</xsl:text></h2>
		<p>
			<xsl:text>De hypotheekgever en de bank verklaarden dat de bank door opzegging de aan haar verleende hypotheek- en pandrechten geheel of gedeeltelijk kan be&#x00eb;indigen.</xsl:text>
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

	Description: Rabobank mortgage deed parties.

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
					<xsl:text>;</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>hierna </xsl:text>
					<xsl:if test="$numberOfPersonsWithIndGerechtigde > 1">
						<xsl:text>zowel tezamen als ieder afzonderlijk </xsl:text>
					</xsl:if>
					<xsl:text>te noemen: '</xsl:text>
					<u><xsl:text>de bank</xsl:text></u>
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

	Description: Rabobank mortgage deed party persons.

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
	Mode: do-natural-person-rabo
	*********************************************************
	Public: no

	Identity transform: no

	Description: Natural person text block (Rabobank stylesheet).

	Input: rabo:IMKAD_Persoon

	Params: none

	Output: text

	Calls:
	(mode) do-gender-salutation-rabo
	(mode) do-person-data-rabo
	(mode) do-birth-data-rabo

	Called by:
	(mode) do-deed
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="rabo:IMKAD_Persoon" mode="do-natural-person-rabo">
		<xsl:variable name="genderShouldBePrinted">
			<xsl:choose>
				<xsl:when test="normalize-space(translate(rabo:tia_Gegevens/rabo:IMKAD_KadNatuurlijkPersoon/rabo:adellijkeTitelOfPredikaat, $upper, $lower)) != '' 
						or normalize-space(translate(rabo:tia_Gegevens/rabo:IMKAD_KadNatuurlijkPersoon/rabo:tia_AdellijkeTitel2, $upper, $lower)) != ''">
					<xsl:text>false</xsl:text>
				</xsl:when>
				<xsl:when test="not(rabo:tia_Gegevens/rabo:IMKAD_KadNatuurlijkPersoon)
						and (normalize-space(translate(rabo:tia_Gegevens/rabo:GBA_Ingezetene/rabo:tia_AdellijkeTitel, $upper, $lower)) != ''
						or normalize-space(translate(rabo:tia_Gegevens/rabo:GBA_Ingezetene/rabo:tia_AdellijkeTitel2, $upper, $lower)) != '')">
					<xsl:text>false</xsl:text>
				</xsl:when>
				<xsl:when test="not(rabo:tia_Gegevens/rabo:IMKAD_KadNatuurlijkPersoon)
						and (normalize-space(translate(rabo:tia_Gegevens/rabo:IMKAD_NietIngezetene/rabo:tia_AdellijkeTitel, $upper, $lower)) != '' 
						or normalize-space(translate(rabo:tia_Gegevens/rabo:IMKAD_NietIngezetene/rabo:tia_AdellijkeTitel2, $upper, $lower)) != '')">
					<xsl:text>false</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>true</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<xsl:if test="$genderShouldBePrinted = 'true'">
			<xsl:apply-templates select="rabo:tia_Gegevens/rabo:GBA_Ingezetene | rabo:tia_Gegevens/rabo:IMKAD_NietIngezetene" mode="do-gender-salutation-rabo" />
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:choose>
			<xsl:when test="rabo:tia_Gegevens/rabo:IMKAD_KadNatuurlijkPersoon">
				<xsl:apply-templates select="rabo:tia_Gegevens/rabo:IMKAD_KadNatuurlijkPersoon" mode="do-person-data-rabo" />
				<xsl:text>, bij de gemeentelijke basisregistratie bekend als </xsl:text>
				<xsl:apply-templates select="rabo:tia_Gegevens/rabo:GBA_Ingezetene" mode="do-person-data-rabo" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="rabo:tia_Gegevens/rabo:GBA_Ingezetene | rabo:tia_Gegevens/rabo:IMKAD_NietIngezetene" mode="do-person-data-rabo" />
			</xsl:otherwise>
		</xsl:choose>
		<xsl:text>, </xsl:text>
		<xsl:apply-templates select="rabo:tia_Gegevens/rabo:GBA_Ingezetene | rabo:tia_Gegevens/rabo:IMKAD_NietIngezetene" mode="do-birth-data-rabo" />	
	</xsl:template>

	<!--
	*********************************************************
	Mode: do-person-data-rabo
	*********************************************************
	Public: no

	Identity transform: no

	Description: Basic data regarding natural person (Rabobank stylesheet).

	Input: rabo:GBA_Ingezetene, rabo:IMKAD_NietIngezetene or rabo:IMKAD_KadNatuurlijkPersoon

	Params: none

	Output: text

	Calls:
	none

	Called by:
	(mode) do-natural-person-rabo
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="rabo:GBA_Ingezetene | rabo:IMKAD_NietIngezetene | rabo:IMKAD_KadNatuurlijkPersoon" mode="do-person-data-rabo">
		<xsl:if test="rabo:tia_TekstKeuze[translate(rabo:tagNaam, $upper, $lower) = 'k_professor']/rabo:tekst[translate(normalize-space(.), $upper, $lower) =
				translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_professor']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
				translate(normalize-space(current()/rabo:tia_TekstKeuze[translate(rabo:tagNaam, $upper, $lower) = 'k_professor']/rabo:tekst), $upper, $lower)]), $upper, $lower)]">
			<xsl:value-of select="rabo:tia_TekstKeuze[translate(rabo:tagNaam, $upper, $lower) = 'k_professor']/rabo:tekst[translate(normalize-space(.), $upper, $lower) =
					translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_professor']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
					translate(normalize-space(current()/rabo:tia_TekstKeuze[translate(rabo:tagNaam, $upper, $lower) = 'k_professor']/rabo:tekst), $upper, $lower)]), $upper, $lower)]" />
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:if test="(rabo:tia_AdellijkeTitel or rabo:adellijkeTitelOfPredikaat) and (normalize-space(rabo:tia_AdellijkeTitel) != '' or normalize-space(rabo:adellijkeTitelOfPredikaat) != '')">
			<xsl:value-of select="rabo:tia_AdellijkeTitel | rabo:adellijkeTitelOfPredikaat" />
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:if test="rabo:tia_Titel and normalize-space(rabo:tia_Titel) != ''">
			<xsl:value-of select="rabo:tia_Titel" />
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:value-of select="rabo:naam/rabo:voornamen | rabo:voornamen" />
		<xsl:text> </xsl:text>
		<xsl:if test="rabo:tia_AdellijkeTitel2 and normalize-space(rabo:tia_AdellijkeTitel2) != ''">
			<xsl:value-of select="rabo:tia_AdellijkeTitel2" />
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:if test="(rabo:tia_VoorvoegselsNaam or rabo:voorvoegsels or rabo:voorvoegselsgeslachtsnaam)
				and normalize-space(rabo:tia_VoorvoegselsNaam | rabo:voorvoegsels | rabo:voorvoegselsgeslachtsnaam) != ''">
			<xsl:value-of select="rabo:tia_VoorvoegselsNaam | rabo:voorvoegsels | rabo:voorvoegselsgeslachtsnaam" />
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:value-of select="rabo:tia_NaamZonderVoorvoegsels | rabo:geslachtsnaam" />
		<xsl:if test="rabo:tia_Titel2 and normalize-space(rabo:tia_Titel2) != ''">
			<xsl:text> </xsl:text>
			<xsl:value-of select="rabo:tia_Titel2" />
		</xsl:if>
	</xsl:template>

	<!--
	*********************************************************
	Mode: do-gender-salutation-rabo
	*********************************************************
	Public: no

	Identity transform: no

	Description: Gender salutation for natural person (Rabobank stylesheet).

	Input: rabo:GBA_Ingezetene or rabo:IMKAD_NietIngezetene

	Params: none

	Output: text

	Calls:
	none

	Called by:
	(mode) do-natural-person-rabo
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="rabo:GBA_Ingezetene | rabo:IMKAD_NietIngezetene" mode="do-gender-salutation-rabo">
		<xsl:choose>
			<xsl:when test="translate(rabo:geslacht/rabo:geslachtsaanduiding, $upper, $lower) = 'man' or translate(rabo:geslacht, $upper, $lower) = 'man'">
				<xsl:text>de heer</xsl:text>
			</xsl:when>
			<xsl:when test="translate(rabo:geslacht/rabo:geslachtsaanduiding, $upper, $lower) = 'vrouw' or translate(rabo:geslacht, $upper, $lower) = 'vrouw'">
				<xsl:text>mevrouw</xsl:text>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<!--
	*********************************************************
	Mode: do-birth-data-rabo
	*********************************************************
	Public: no

	Identity transform: no

	Description: Birth data regarding natural person (Rabobank stylesheet).

	Input: rabo:GBA_Ingezetene or rabo:IMKAD_NietIngezetene

	Params: none

	Output: text

	Calls:
	none

	Called by:
	(mode) do-natural-person-rabo
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="rabo:GBA_Ingezetene | rabo:IMKAD_NietIngezetene" mode="do-birth-data-rabo">
		<xsl:variable name="Datum_DATE" select="substring(string(rabo:geboorte/rabo:geboortedatum | rabo:geboortedatum), 0, 11)" />
		<xsl:variable name="Datum_STRING">
			<xsl:if test="$Datum_DATE != ''">
				<xsl:value-of select="kef:convertDateToText($Datum_DATE)" />
			</xsl:if>
		</xsl:variable>
		<xsl:text>geboren te </xsl:text>
		<xsl:value-of select="rabo:geboorte/rabo:geboorteplaatsOmschrijving | rabo:geboorteplaats" />
		<xsl:text> op </xsl:text>
		<xsl:value-of select="$Datum_STRING" />
	</xsl:template>

	<!--
	*********************************************************
	Mode: do-address-rabo
	*********************************************************
	Public: no

	Identity transform: no

	Description: Address text block (Rabobank stylesheet).

	Input: rabo:IMKAD_WoonlocatiePersoon, rabo:binnenlandsAdres, rabo:buitenlandsAdres

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
	<xsl:template match="rabo:IMKAD_WoonlocatiePersoon" mode="do-address-rabo">
		<xsl:apply-templates select="rabo:adres/rabo:binnenlandsAdres | rabo:adres/rabo:buitenlandsAdres" mode="do-address-rabo" />
	</xsl:template>

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="rabo:binnenlandsAdres" mode="do-address-rabo">
		<!-- Insert space between numbers and letters of post code -->
		<xsl:value-of select="concat(normalize-space(substring(rabo:BAG_NummerAanduiding/rabo:postcode, 1, 4)), ' ',
			normalize-space(substring(rabo:BAG_NummerAanduiding/rabo:postcode, 5)))" />
		<xsl:text> </xsl:text>
		<xsl:value-of select="rabo:BAG_Woonplaats/rabo:woonplaatsNaam" />
		<xsl:text>, </xsl:text>
		<xsl:value-of select="rabo:BAG_OpenbareRuimte/rabo:openbareRuimteNaam" />
		<xsl:text> </xsl:text>
		<xsl:value-of select="rabo:BAG_NummerAanduiding/rabo:huisnummer" />
		<xsl:if test="rabo:BAG_NummerAanduiding/rabo:huisletter
				and normalize-space(rabo:BAG_NummerAanduiding/rabo:huisletter) != ''">
			<xsl:text> </xsl:text>
			<xsl:value-of select="rabo:BAG_NummerAanduiding/rabo:huisletter" />
		</xsl:if>
		<xsl:if test="rabo:BAG_NummerAanduiding/rabo:huisnummertoevoeging
				and normalize-space(rabo:BAG_NummerAanduiding/rabo:huisnummertoevoeging) != ''">
			<xsl:text> </xsl:text>
			<xsl:value-of select="rabo:BAG_NummerAanduiding/rabo:huisnummertoevoeging" />
		</xsl:if>
	</xsl:template>

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="rabo:buitenlandsAdres" mode="do-address-rabo">
		<xsl:value-of select="rabo:woonplaats" />
		<xsl:text>, </xsl:text>
		<xsl:value-of select="rabo:adres" />
		<xsl:text> </xsl:text>
		<xsl:if test="rabo:regio and normalize-space(rabo:regio) != ''">
			<xsl:value-of select="rabo:regio" />
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:value-of select="rabo:land" />
	</xsl:template>

</xsl:stylesheet>
