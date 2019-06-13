<?xml version="1.0" encoding="UTF-8"?>
<!--
*********************************************************
Stylesheet: hypotheek_rabobank.xsl
Version: 5.0.0
(AA-4413: Rabobank - bijwerken naar nieuwste versies tekstblokken)	
*********************************************************
Description:
Hypotheek Rabobank Modeldocument versie 4.1.0

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
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:tia="http://www.kadaster.nl/schemas/KIK/TIA_Algemeen" xmlns:rabo="http://www.kadaster.nl/schemas/KIK/RabobankHypotheekakte/v20180901" xmlns:kef="nl.kadaster.xslt.XslExtensionFunctions" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:gc="http://docs.oasis-open.org/codelist/ns/genericode/1.0/" exclude-result-prefixes="tia rabo kef xsl xlink gc" version="1.0">
	<xsl:include href="generiek-1.08.xsl"/>
	<xsl:include href="tekstblok_aanhef-1.20.xsl"/>
	<xsl:include href="tekstblok_burgerlijke_staat-1.03.xsl"/>
	<xsl:include href="tekstblok_equivalentieverklaring-1.28.xsl"/>
	<xsl:include href="tekstblok_gevolmachtigde-1.26.xsl"/>
	<xsl:include href="tekstblok_legitimatie-2.00.xsl"/>
	<xsl:include href="tekstblok_natuurlijk_persoon-1.13.xsl"/>
	<xsl:include href="tekstblok_overbruggingshypotheek-1.08.xsl"/>
	<xsl:include href="tekstblok_personalia_van_natuurlijk_persoon-1.06.xsl"/>
	<xsl:include href="tekstblok_partij_natuurlijk_persoon-1.39.xsl"/>
	<xsl:include href="tekstblok_partij_niet_natuurlijk_persoon-1.53.xsl"/>
	<xsl:include href="tekstblok_partijnamen_in_hypotheekakten-1.15.xsl"/>
	<xsl:include href="tekstblok_recht-1.17.xsl"/>
	<xsl:include href="tekstblok_rechtspersoon-1.15.0.xsl"/>
	<xsl:include href="tekstblok_registergoed-1.29.xsl"/>
	<xsl:include href="tekstblok_titel_hypotheekakten-1.01.xsl"/>
	<xsl:include href="tekstblok_woonadres-1.05.xsl"/>
	<xsl:include href="tweededeel-1.05.xsl"/>
	<!-- Rabobank specific global variables -->
	<xsl:variable name="keuzeteksten" select="document('keuzeteksten_hypotheek_rabobank-4.0.1.xml')"/>
	<xsl:variable name="keuzetekstenTbBurgelijkeStaat" select="document('keuzeteksten-tb-burgerlijkestaat-1.1.0.xml')"/>
	<xsl:variable name="legalPersonNames" select="document('nnp-kodes.xml')/gc:CodeList/SimpleCodeList/Row"/>
	<xsl:variable name="RegistergoedTonenPerPerceel">
		<!-- t.b.v. TB Registergoed -->
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
			<xsl:apply-templates select="tia:IMKAD_AangebodenStuk" mode="do-statement-of-equivalence"/>
			<!-- Two empty lines after Statement of equivalence -->
			<p>
				<br/>
			</p>
			<p>
				<br/>
			</p>
		</xsl:if>
		<a name="hyp3.header" class="location">&#160;</a>
		<!-- Text block Mortgage deed title -->
		<xsl:apply-templates select="tia:IMKAD_AangebodenStuk" mode="do-mortgage-deed-title"/>
		<!-- Text block Header -->
		<xsl:apply-templates select="tia:IMKAD_AangebodenStuk" mode="do-header"/>
		<!-- Parties -->
		<xsl:apply-templates select="tia:IMKAD_AangebodenStuk/tia:Partij" mode="do-parties"/>
		<p>
			<xsl:text>Van het bestaan van de volmacht</xsl:text>
			<xsl:value-of select="tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoudvolmachten']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
					translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoudvolmachten']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
					translate(normalize-space(current()/tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoudvolmachten']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
			<xsl:text> aan de comparant</xsl:text>
			<xsl:choose>
				<xsl:when test="(tia:IMKAD_AangebodenStuk/tia:Partij[@id = substring-after(current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:Gevolmachtigde
						and translate(tia:IMKAD_AangebodenStuk/tia:Partij[@id = substring-after(current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:Gevolmachtigde/tia:gegevens/tia:persoonGegevens/tia:geslacht/tia:geslachtsaanduiding, $upper, $lower) = 'vrouw')">
					<xsl:text>e</xsl:text>
				</xsl:when>
			</xsl:choose>
			<xsl:text> onder 2. genoemd is mij, notaris, genoegzaam gebleken.</xsl:text>
		</p>
		<h2 class="header">
			<xsl:text>Hypotheek- en pandrechten</xsl:text>
		</h2>
		<p>
			<xsl:text>Hypotheek- en pandrechten zijn zekerheden voor de bank. In deze akte en de algemene voorwaarden die van toepassing zijn, staan regels waaraan de bank en de hypotheekgever zich moeten houden.</xsl:text>
			<br/>
			<xsl:text>Hypotheek- en pandrechten geven de bank het recht het onderpand te executeren. Executeren betekent dat de bank het onderpand mag verkopen. En de opbrengst mag gebruiken voor wat de debiteur aan de bank moet betalen. Executeren mag alleen in de gevallen die zijn of worden afgesproken tussen de bank en de hypotheekgever of de debiteur. In deze akte en de algemene voorwaarden die van toepassing zijn wordt dit verder uitgewerkt.
</xsl:text>
		</p>
		<h2 class="header">
			<xsl:text>Overeenkomst tot het vestigen van hypotheek- en pandrechten</xsl:text>
		</h2>
		<p>
			<xsl:text>De hypotheekgever en de bank spreken hierbij af dat de hypotheekgever het hypotheekrecht en pandrechten aan de bank geeft op de goederen die worden omschreven in deze akte en in de Algemene voorwaarden voor hypotheken van de Rabobank 2018. Hierna staat waarvoor het hypotheekrecht en de pandrechten als zekerheid gelden.</xsl:text>
		</p>
		<a name="hyp3.rabobankMortgageProvision" class="location">&#160;</a>
		<h2 class="header">
			<xsl:text>Hypotheekverlening</xsl:text>
		</h2>
		<xsl:choose>
			<xsl:when test="tia:partnerSpecifiek/rabo:VasteHypotheekGeenSchip">
				<xsl:call-template name="vasteHypotheekGeenSchip"/>
			</xsl:when>
			<xsl:when test="tia:partnerSpecifiek/rabo:VasteHypotheekSchip">
				<xsl:call-template name="vasteHypotheekSchip"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="bankHypotheek"/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:if test="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht/tia:Schip">
			<xsl:call-template name="opeisbaarheid"/>
		</xsl:if>
		<xsl:call-template name="hypotheekbedrag"/>
		<xsl:call-template name="onderpand"/>
		<xsl:apply-templates select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[translate(tia:aanduidingHypotheek, $upper, $lower) = 'overbruggingshypotheek']" mode="do-bridging-mortgage"/>
		<xsl:if test="not(tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[translate(tia:aanduidingHypotheek, $upper, $lower) = 'overbruggingshypotheek'])">
			<a name="hyp3.bridgingMortgage" class="location">&#160;</a>
		</xsl:if>
		<h2 class="header">
			<xsl:text>Opzegging</xsl:text>
		</h2>
		<p>
			<xsl:text>De bank mag het hypotheekrecht en de pandrechten helemaal of voor een deel opzeggen. De hypotheekgever mag dit niet.</xsl:text>
		</p>
		<a name="hyp3.electionOfDomicile" class="location">&#160;</a>
		<xsl:variable name="woonplaatskeuze" select="tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_woonplaatskeuze']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
				translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_woonplaatskeuze']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
				translate(normalize-space(current()/tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_woonplaatskeuze']/tia:tekst), $upper, $lower)]), $upper, $lower)]" />
		<xsl:if test="$woonplaatskeuze != ''">
			<h2 class="header">
				<u>
					<xsl:text>Woonplaatskeuze</xsl:text>
				</u>
			</h2>
			<p>
				<xsl:value-of select="$woonplaatskeuze"/>
			</p>
		</xsl:if>	
		<h3>
			<xsl:text>EINDE KADASTERDEEL</xsl:text>
		</h3>
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
		<xsl:variable name="numberOfLegalPersonPairs" select="count(tia:IMKAD_Persoon[tia:tia_Gegevens/tia:NHR_Rechtspersoon and tia:GerelateerdPersoon[tia:rol = 'volmachtgever']])"/>
		<xsl:variable name="hoedanigheidId" select="substring-after(tia:Gevolmachtigde/tia:vertegenwoordigtRef/@xlink:href, '#')"/>
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
											<xsl:value-of select="count(preceding-sibling::tia:Partij) + 1"/>
											<xsl:text>.</xsl:text>
										</td>
										<td>
											<xsl:apply-templates select="tia:Gevolmachtigde" mode="do-legal-representative"/>
											<xsl:text>: </xsl:text>
										</td>
									</tr>
								</tbody>
							</table>
						</td>
					</tr>
				</xsl:if>
				<xsl:choose>
					<xsl:when test="@id = substring-after(../tia:StukdeelHypotheek/tia:vervreemderRechtRef/@xlink:href, '#')">
						<!-- Hypotheekgever -->
						<xsl:choose>
							<!-- If only one person pair, or legal person with warrantors is present - do not create list -->
							<xsl:when test="(tia:IMKAD_Persoon[(tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene) and tia:GerelateerdPersoon[tia:rol]]
								or $numberOfLegalPersonPairs > 0) and not(count(tia:IMKAD_Persoon) > 1)">
								<xsl:apply-templates select="tia:IMKAD_Persoon" mode="do-party-person"/>
							</xsl:when>
							<xsl:when test="count(tia:IMKAD_Persoon) = 1">
								<xsl:apply-templates select="tia:IMKAD_Persoon" mode="do-party-person"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:for-each select="tia:IMKAD_Persoon">
									<xsl:apply-templates select="." mode="do-party-person"/>
								</xsl:for-each>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<!-- Hypotheeknemer -->
						<tr>
							<td>
								<table>
									<tbody>
										<xsl:for-each select="tia:IMKAD_Persoon[tia:tia_Gegevens/tia:NHR_Rechtspersoon]">
											<tr>
												<td class="number" valign="top">
													<xsl:text>&#xFEFF;</xsl:text>
												</td>
												<td>
													<xsl:apply-templates select="." mode="do-legal-person"/>
													<xsl:if test="tia:IMKAD_PostlocatiePersoon">
														<xsl:text> (correspondentieadres: </xsl:text>
														<xsl:apply-templates select="tia:IMKAD_PostlocatiePersoon" mode="do-rabo-correspondant-address"/>
														<xsl:text>)</xsl:text>
													</xsl:if>
													<xsl:text>;</xsl:text>
												</td>
											</tr>
										</xsl:for-each>
									</tbody>
								</table>
							</td>
						</tr>
					</xsl:otherwise>
				</xsl:choose>
			</tbody>
		</table>
		<p style="margin-left:30px">
			<xsl:choose>
				<xsl:when test="@id = substring-after(../tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:vervreemderRechtRef/@xlink:href, '#')">
					<xsl:text>voor zover in deze akte niet anders genoemd, </xsl:text>
					<xsl:apply-templates select="." mode="do-mortgage-deed-party-name"/>
					<xsl:text>;</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>hierna te noemen: '</xsl:text>
					<u>
						<xsl:text>bank</xsl:text>
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
		<xsl:apply-templates select="." mode="do-party-natural-person"/>
	</xsl:template>
	<!--
	**** matching template   ******************************************************************************
	**** NATURAL PERSON PAIR ******************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon[(tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene) and tia:GerelateerdPersoon]" mode="do-party-person">
		<xsl:apply-templates select="." mode="do-party-natural-person"/>
	</xsl:template>
	<!--
	**** matching template ********************************************************************************
	**** LEGAL PERSON      ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon[tia:tia_Gegevens/tia:NHR_Rechtspersoon]" mode="do-party-person">
		<xsl:apply-templates select="." mode="do-party-legal-person"/>
	</xsl:template>
	<!--
	**** named template TekstHypotheekverlening ********************************************************************************
	-->
	<xsl:template name="TekstHypotheekverlening">
		<xsl:text>Ter uitvoering van de afspraak om een hypotheekrecht te geven geeft de hypotheekgever een hypotheekrecht aan de bank. Dit hypotheekrecht wordt gevestigd tot het bedrag dat hierna onder ‘Hypotheekbedrag’ staat op het onderpand dat hierna onder ‘Onderpand’ staat. Dit hypotheekrecht geldt als zekerheid voor </xsl:text>
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
			<xsl:apply-templates select="rabo:tia_Gegevens/rabo:GBA_Ingezetene | rabo:tia_Gegevens/rabo:IMKAD_NietIngezetene" mode="do-gender-salutation-rabo"/>
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:choose>
			<xsl:when test="rabo:tia_Gegevens/rabo:IMKAD_KadNatuurlijkPersoon">
				<xsl:apply-templates select="rabo:tia_Gegevens/rabo:IMKAD_KadNatuurlijkPersoon" mode="do-person-data-rabo"/>
				<xsl:text>, bij de gemeentelijke basisregistratie bekend als </xsl:text>
				<xsl:apply-templates select="rabo:tia_Gegevens/rabo:GBA_Ingezetene" mode="do-person-data-rabo"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="rabo:tia_Gegevens/rabo:GBA_Ingezetene | rabo:tia_Gegevens/rabo:IMKAD_NietIngezetene" mode="do-person-data-rabo"/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:text>, </xsl:text>
		<xsl:apply-templates select="rabo:tia_Gegevens/rabo:GBA_Ingezetene | rabo:tia_Gegevens/rabo:IMKAD_NietIngezetene" mode="do-birth-data-rabo"/>
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
					translate(normalize-space(current()/rabo:tia_TekstKeuze[translate(rabo:tagNaam, $upper, $lower) = 'k_professor']/rabo:tekst), $upper, $lower)]), $upper, $lower)]"/>
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:if test="(rabo:tia_AdellijkeTitel or rabo:adellijkeTitelOfPredikaat) and (normalize-space(rabo:tia_AdellijkeTitel) != '' or normalize-space(rabo:adellijkeTitelOfPredikaat) != '')">
			<xsl:value-of select="rabo:tia_AdellijkeTitel | rabo:adellijkeTitelOfPredikaat"/>
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:if test="rabo:tia_Titel and normalize-space(rabo:tia_Titel) != ''">
			<xsl:value-of select="rabo:tia_Titel"/>
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:value-of select="rabo:naam/rabo:voornamen | rabo:voornamen"/>
		<xsl:text> </xsl:text>
		<xsl:if test="rabo:tia_AdellijkeTitel2 and normalize-space(rabo:tia_AdellijkeTitel2) != ''">
			<xsl:value-of select="rabo:tia_AdellijkeTitel2"/>
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:if test="(rabo:tia_VoorvoegselsNaam or rabo:voorvoegsels or rabo:voorvoegselsgeslachtsnaam)
				and normalize-space(rabo:tia_VoorvoegselsNaam | rabo:voorvoegsels | rabo:voorvoegselsgeslachtsnaam) != ''">
			<xsl:value-of select="rabo:tia_VoorvoegselsNaam | rabo:voorvoegsels | rabo:voorvoegselsgeslachtsnaam"/>
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:value-of select="rabo:tia_NaamZonderVoorvoegsels | rabo:geslachtsnaam"/>
		<xsl:if test="rabo:tia_Titel2 and normalize-space(rabo:tia_Titel2) != ''">
			<xsl:text> </xsl:text>
			<xsl:value-of select="rabo:tia_Titel2"/>
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
		<xsl:variable name="Datum_DATE" select="substring(string(rabo:geboorte/rabo:geboortedatum | rabo:geboortedatum), 0, 11)"/>
		<xsl:variable name="Datum_STRING">
			<xsl:if test="$Datum_DATE != ''">
				<xsl:value-of select="kef:convertDateToText($Datum_DATE)"/>
			</xsl:if>
		</xsl:variable>
		<xsl:text>geboren te </xsl:text>
		<xsl:value-of select="rabo:geboorte/rabo:geboorteplaatsOmschrijving | rabo:geboorteplaats"/>
		<xsl:text> op </xsl:text>
		<xsl:value-of select="$Datum_STRING"/>
	</xsl:template>
	<xsl:template match="tia:IMKAD_PostlocatiePersoon" mode="do-rabo-correspondant-address">
		<xsl:if test="tia:tia_label and normalize-space(tia:tia_label) != ''">
			<xsl:value-of select="tia:tia_label"/>
			<xsl:text>, </xsl:text>
		</xsl:if>
		<xsl:if test="tia:tia_afdeling and normalize-space(tia:tia_afdeling) != ''">
			<xsl:value-of select="tia:tia_afdeling"/>
			<xsl:text>, </xsl:text>
		</xsl:if>
		<xsl:apply-templates select="tia:adres/tia:postbusAdres" mode="do-rabo-correspondant-address"/>
		<xsl:apply-templates select="tia:adres/tia:binnenlandsAdres
			| tia:adres/tia:buitenlandsAdres" mode="do-correspondant-address"/>
	</xsl:template>
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:postbusAdres" mode="do-rabo-correspondant-address">
		<xsl:text>postbus </xsl:text>
		<xsl:value-of select="tia:postbusnummer"/>
		<xsl:text>, </xsl:text>
		<!-- Insert space between numbers and letters of post code -->
		<xsl:value-of select="concat(normalize-space(substring(tia:postcode, 1, 4)), ' ',
			normalize-space(substring(tia:postcode, 5)))"/>
		<xsl:text> </xsl:text>
		<xsl:value-of select="tia:woonplaatsnaam"/>
	</xsl:template>
	<xsl:template name="opeisbaarheid">
		<h2 class="header">
			<xsl:text>Opeisbaarheid</xsl:text>
		</h2>
		<table>
			<tbody>
				<tr>
					<td colspan="2">
						<xsl:text>In de algemene voorwaarden die hierna worden genoemd, staat wanneer schulden van de debiteur aan de bank meteen opeisbaar zijn en wanneer deze schulden meteen door de bank mogen worden opgeëist:</xsl:text>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>-</xsl:text>
					</td>
					<td>
						<xsl:text>de Algemene Bankvoorwaarden, ingeschreven op vijftien juni tweeduizend achttien ten kantore van de Dienst voor het Kadaster en de Openbare Registers in Register Hypotheken 3 deel 73854 nummer 119 en in Register Schepen Hypotheken 3 deel 50199 nummer 70</xsl:text>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>-</xsl:text>
					</td>
					<td>
						<xsl:text>de Algemene Basisvoorwaarden voor particuliere leningen van de Rabobank 2018, ingeschreven op vijftien juni tweeduizend achttien ten kantore van de Dienst voor het Kadaster en de Openbare Registers in Register Hypotheken 3 deel 73866 nummer 71 en in Register Schepen Hypotheken  3 deel 50199 nummer 71</xsl:text>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>-</xsl:text>
					</td>
					<td>
						<xsl:text>de Algemene Plusvoorwaarden voor particuliere leningen van de Rabobank 2018, ingeschreven op vijftien juni tweeduizend achttien ten kantore van de Dienst voor het Kadaster en de Openbare Registers in Register Hypotheken 3 deel 73866 nummer 72 en in Register Schepen Hypotheken  3 deel 50199 nummer 72</xsl:text>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>-</xsl:text>
					</td>
					<td>
						<xsl:text>de Voorwaarden voor betalen  en online diensten van de Rabobank 2018, ingeschreven op vijftien juni tweeduizend achttien ten kantore van de Dienst voor het Kadaster en de Openbare Registers in Register Hypotheken 3 deel 73866 nummer 74 en in Register Schepen Hypotheken  3 deel 50199 nummer 73</xsl:text>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>-</xsl:text>
					</td>
					<td>
						<xsl:text>de Algemene voorwaarden voor bedrijfsfinancieringen van de Rabobank 2018, ingeschreven op vijftien juni tweeduizend achttien ten kantore van de Dienst voor het Kadaster en de Openbare Registers in Register Hypotheken 3 deel 73866 nummer 79 en in Register Schepen Hypotheken  3 deel 50199 nummer 74.</xsl:text>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<xsl:text>De schulden van de debiteur aan de bank zijn in ieder geval opeisbaar:</xsl:text>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>-</xsl:text>
					</td>
					<td>
						<xsl:text>drie maanden nadat de bank een vordering heeft opgezegd waarvoor het hypotheekrecht als zekerheid geldt,</xsl:text>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>-</xsl:text>
					</td>
					<td>
						<xsl:text>wanneer de bank de debiteur als borg heeft aangesproken, of</xsl:text>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>-</xsl:text>
					</td>
					<td>
						<xsl:text>wanneer een rechtspersoon voor een andere rechtspersoon een verklaring als bedoeld in artikel 403 Boek 2 van het Burgerlijk Wetboek heeft verstrekt en deze intrekt of deze wil gaan intrekken.</xsl:text>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<xsl:text>Dit geldt niet als hierover andere afspraken zijn gemaakt.</xsl:text>
					</td>
				</tr>
			</tbody>
		</table>
	</xsl:template>
	<xsl:template name="hypotheekbedrag">
		<a name="hyp3.mortgageAmountAndAdditionalCosts" class="location">&#160;</a>
		<h2 class="header">
			<xsl:text>Hypotheekbedrag</xsl:text>
		</h2>
		<p>
			<xsl:text>De hypotheekgever geeft het hypotheekrecht tot:</xsl:text>
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
							<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:hoofdsom/tia:som"/>
							<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:hoofdsom/tia:valuta"/>
						</xsl:call-template>
						<xsl:text> </xsl:text>
						<xsl:call-template name="amountNumber">
							<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:hoofdsom/tia:som"/>
							<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:hoofdsom/tia:valuta"/>
						</xsl:call-template>
						<xsl:text> plus</xsl:text>
					</td>
				</tr>
				<xsl:choose>
					<xsl:when test="tia:partnerSpecifiek/rabo:AanvullendeKosten/rabo:RegistergoedGeenSchip">
						<tr>
							<td class="number" valign="top">
								<xsl:text>b)</xsl:text>
							</td>
							<td>
								<xsl:text>renten, vergoedingen, boeten en kosten, samen begroot op vijfendertig procent (35%) van het bedrag hiervoor onder a, dat is </xsl:text>
								<xsl:call-template name="amountText">
									<xsl:with-param name="amount" select="tia:partnerSpecifiek/rabo:AanvullendeKosten/rabo:RegistergoedGeenSchip/rabo:bedragRente/rabo:som"/>
									<xsl:with-param name="valuta" select="tia:partnerSpecifiek/rabo:AanvullendeKosten/rabo:RegistergoedGeenSchip/rabo:bedragRente/rabo:valuta"/>
								</xsl:call-template>
								<xsl:text> </xsl:text>
								<xsl:call-template name="amountNumber">
									<xsl:with-param name="amount" select="tia:partnerSpecifiek/rabo:AanvullendeKosten/rabo:RegistergoedGeenSchip/rabo:bedragRente/rabo:som"/>
									<xsl:with-param name="valuta" select="tia:partnerSpecifiek/rabo:AanvullendeKosten/rabo:RegistergoedGeenSchip/rabo:bedragRente/rabo:valuta"/>
								</xsl:call-template>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<xsl:text>dus tot een totaalbedrag van </xsl:text>
								<xsl:call-template name="amountText">
									<xsl:with-param name="amount" select="tia:partnerSpecifiek/rabo:AanvullendeKosten/rabo:RegistergoedGeenSchip/rabo:bedragTotaal/rabo:som"/>
									<xsl:with-param name="valuta" select="tia:partnerSpecifiek/rabo:AanvullendeKosten/rabo:RegistergoedGeenSchip/rabo:bedragTotaal/rabo:valuta"/>
								</xsl:call-template>
								<xsl:text> </xsl:text>
								<xsl:call-template name="amountNumber">
									<xsl:with-param name="amount" select="tia:partnerSpecifiek/rabo:AanvullendeKosten/rabo:RegistergoedGeenSchip/rabo:bedragTotaal/rabo:som"/>
									<xsl:with-param name="valuta" select="tia:partnerSpecifiek/rabo:AanvullendeKosten/rabo:RegistergoedGeenSchip/rabo:bedragTotaal/rabo:valuta"/>
								</xsl:call-template>
								<xsl:text>, op:</xsl:text>
							</td>
						</tr>
					</xsl:when>
					<xsl:otherwise>
						<tr>
							<td class="number" valign="top">
								<xsl:text>b)</xsl:text>
							</td>
							<td>
								<xsl:text>renten, vergoedingen, boeten en kosten, samen begroot op vijftig procent (50%) van het bedrag hiervoor onder a, dat is </xsl:text>
								<xsl:call-template name="amountText">
									<xsl:with-param name="amount" select="tia:partnerSpecifiek/rabo:AanvullendeKosten/rabo:HypotheekMedeOpSchip/rabo:bedragRente/rabo:som"/>
									<xsl:with-param name="valuta" select="tia:partnerSpecifiek/rabo:AanvullendeKosten/rabo:HypotheekMedeOpSchip/rabo:bedragRente/rabo:valuta"/>
								</xsl:call-template>
								<xsl:text> </xsl:text>
								<xsl:call-template name="amountNumber">
									<xsl:with-param name="amount" select="tia:partnerSpecifiek/rabo:AanvullendeKosten/rabo:HypotheekMedeOpSchip/rabo:bedragRente/rabo:som"/>
									<xsl:with-param name="valuta" select="tia:partnerSpecifiek/rabo:AanvullendeKosten/rabo:HypotheekMedeOpSchip/rabo:bedragRente/rabo:valuta"/>
								</xsl:call-template>
								<xsl:text> waarbij geldt dat het hypotheekrecht alleen ook als zekerheid geldt voor de rente voor zover deze is vervallen tijdens de laatste drie jaar voor het begin van de uitwinning van het onderpand en de rente tijdens de loop van de uitwinning van het onderpand,</xsl:text>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<xsl:text>dus tot een totaalbedrag van </xsl:text>
								<xsl:call-template name="amountText">
									<xsl:with-param name="amount" select="tia:partnerSpecifiek/rabo:AanvullendeKosten/rabo:HypotheekMedeOpSchip/rabo:bedragTotaal/rabo:som"/>
									<xsl:with-param name="valuta" select="tia:partnerSpecifiek/rabo:AanvullendeKosten/rabo:HypotheekMedeOpSchip/rabo:bedragTotaal/rabo:valuta"/>
								</xsl:call-template>
								<xsl:text> </xsl:text>
								<xsl:call-template name="amountNumber">
									<xsl:with-param name="amount" select="tia:partnerSpecifiek/rabo:AanvullendeKosten/rabo:HypotheekMedeOpSchip/rabo:bedragTotaal/rabo:som"/>
									<xsl:with-param name="valuta" select="tia:partnerSpecifiek/rabo:AanvullendeKosten/rabo:HypotheekMedeOpSchip/rabo:bedragTotaal/rabo:valuta"/>
								</xsl:call-template>
								<xsl:text>, op:</xsl:text>
							</td>
						</tr>
					</xsl:otherwise>
				</xsl:choose>
			</tbody>
		</table>
	</xsl:template>
	<xsl:template name="onderpand">
		<xsl:variable name="allProcessedRights" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht"/>
		<a name="hyp3.rights" class="location">&#160;</a>
		<h2 class="header">
			<xsl:text>Onderpand</xsl:text>
		</h2>
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
					<br/>
					<xsl:text>hierna te noemen: onderpand.</xsl:text>
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
						and ((tia:tia_Aantal_Rechten
								= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:tia_Aantal_Rechten)
							or (not(tia:tia_Aantal_Rechten)
								and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:tia_Aantal_Rechten)))
						and ((tia:tia_Aantal_RechtenVariant
								= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:tia_Aantal_RechtenVariant)
							or (not(tia:tia_Aantal_RechtenVariant)
								and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:tia_Aantal_RechtenVariant)))
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
					<br/>
					<xsl:text>hierna (zowel samen als ieder apart) te noemen: onderpand.</xsl:text>
				</p>
			</xsl:when>
			<xsl:otherwise>
				<table cellpadding="0" cellspacing="0">
					<tbody>
						<xsl:call-template name="processRights">
							<xsl:with-param name="positionOfProcessedRight" select="1"/>
							<xsl:with-param name="position" select="1"/>
							<xsl:with-param name="haveAdditionalText" select="'true'"/>
							<!-- forceer de ; na elke aanroep recht/registergoed -->
							<xsl:with-param name="registeredObjects" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']"/>
						</xsl:call-template>
					</tbody>
				</table>
				<p>
					<xsl:text>hierna (zowel samen als ieder apart) te noemen: onderpand.</xsl:text>
				</p>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="vasteHypotheekSchip">
		<xsl:variable name="vasteHypotheekSchip" select="tia:partnerSpecifiek/rabo:VasteHypotheekSchip"/>
		<p>
			<xsl:call-template name="TekstHypotheekverlening"/>
			<xsl:choose>
				<xsl:when test="count($vasteHypotheekSchip/rabo:KredietenInclRente/rabo:Kredieten/rabo:bedrag) = 1">
					<xsl:text>het in </xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>de in </xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="$vasteHypotheekSchip/rabo:vasteHypotheek/rabo:OnderhandseAkte">
					<xsl:text>de onderhandse akte</xsl:text>
					<xsl:if test="count($vasteHypotheekSchip/rabo:vasteHypotheek/rabo:OnderhandseAkte/rabo:datum) > 1">
						<xsl:text>n respectievelijk</xsl:text>
					</xsl:if>
					<xsl:text> van </xsl:text>
					<xsl:for-each select="$vasteHypotheekSchip/rabo:vasteHypotheek/rabo:OnderhandseAkte/rabo:datum">
						<xsl:call-template name="rabo-datum"/>
					</xsl:for-each>
				</xsl:when>
				<xsl:when test="$vasteHypotheekSchip/rabo:vasteHypotheek/rabo:Offerte">
					<xsl:choose>
						<xsl:when test="count($vasteHypotheekSchip/rabo:vasteHypotheek/rabo:Offerte/rabo:datum) > 1">
							<xsl:text>de offertes en overeenkomsten lening respectievelijk van </xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>de offerte en overeenkomst lening van </xsl:text>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:for-each select="$vasteHypotheekSchip/rabo:vasteHypotheek/rabo:Offerte/rabo:datum">
						<xsl:call-template name="rabo-datum"/>
					</xsl:for-each>
					<xsl:text> en</xsl:text>
					<xsl:if test="$vasteHypotheekSchip/rabo:vasteHypotheek/rabo:OfferteAcceptatie">
						<xsl:if test="count($vasteHypotheekSchip/rabo:vasteHypotheek/rabo:OfferteAcceptatie/rabo:datum) > 1">
							<xsl:text> respectievelijk</xsl:text>
						</xsl:if>
						<xsl:text> geaccepteerd op </xsl:text>
						<xsl:for-each select="$vasteHypotheekSchip/rabo:vasteHypotheek/rabo:OfferteAcceptatie/rabo:datum">
							<xsl:call-template name="rabo-datum"/>
						</xsl:for-each>
					</xsl:if>
				</xsl:when>
				<xsl:when test="$vasteHypotheekSchip/rabo:vasteHypotheek/rabo:Financieringsvoorstel or $vasteHypotheekSchip/rabo:vasteHypotheek/rabo:FinancieringsvoorstelAcceptatie">
					<xsl:text>de overeenkomst</xsl:text>
					<xsl:if test="count($vasteHypotheekSchip/rabo:vasteHypotheek/rabo:Financieringsvoorstel/rabo:datum) > 1">
						<xsl:text>en</xsl:text>
					</xsl:if>
					<xsl:text> zakelijke financiering </xsl:text>
					<xsl:if test="count($vasteHypotheekSchip/rabo:vasteHypotheek/rabo:Financieringsvoorstel/rabo:datum) > 1">
						<xsl:text>respectievelijk </xsl:text>
					</xsl:if>
					<xsl:text>van </xsl:text>
					<xsl:for-each select="$vasteHypotheekSchip/rabo:vasteHypotheek/rabo:Financieringsvoorstel/rabo:datum">
						<xsl:call-template name="rabo-datum"/>
					</xsl:for-each>
					<xsl:text> en</xsl:text>
					<xsl:if test="$vasteHypotheekSchip/rabo:vasteHypotheek/rabo:FinancieringsvoorstelAcceptatie">
						<xsl:if test="count($vasteHypotheekSchip/rabo:vasteHypotheek/rabo:FinancieringsvoorstelAcceptatie/rabo:datum) > 1">
							<xsl:text> respectievelijk</xsl:text>
						</xsl:if>
						<xsl:text> geaccepteerd op </xsl:text>
						<xsl:for-each select="$vasteHypotheekSchip/rabo:vasteHypotheek/rabo:FinancieringsvoorstelAcceptatie/rabo:datum">
							<xsl:call-template name="rabo-datum"/>
						</xsl:for-each>
					</xsl:if>
				</xsl:when>
			</xsl:choose>
			<xsl:text> afgesproken</xsl:text>
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
								<xsl:choose>
									<xsl:when test="count($vasteHypotheekSchip/rabo:GeldleningenInclRente/rabo:Geldleningen/rabo:bedrag) = 1">
										<xsl:text> geldlening van de bank aan de debiteur groot </xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text> geldleningen van de bank aan de debiteur respectievelijk groot </xsl:text>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:for-each select="$vasteHypotheekSchip/rabo:GeldleningenInclRente/rabo:Geldleningen/rabo:bedrag">
									<xsl:call-template name="rabo-bedrag"/>
								</xsl:for-each>
								<xsl:text>. Zolang de rente niet wijzigt, is de rente voor deze geldlening</xsl:text>
								<xsl:choose>
									<xsl:when test="count($vasteHypotheekSchip/rabo:GeldleningenInclRente/rabo:Geldleningen/rabo:bedrag) > 1">
										<xsl:text>en respectievelijk </xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text> </xsl:text>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:for-each select="$vasteHypotheekSchip/rabo:GeldleningenInclRente/rabo:rente/rabo:Rentepercentage/rabo:percentage">
									<xsl:call-template name="rabo-percentage"/>
								</xsl:for-each>
								<xsl:text> per jaar, vervallende </xsl:text>
								<xsl:if test="count($vasteHypotheekSchip/rabo:GeldleningenInclRente/rabo:rente/rabo:VervalDatum/rabo:datum) > 1">
									<xsl:text>respectievelijk </xsl:text>
								</xsl:if>
								<xsl:text>op </xsl:text>
								<xsl:for-each select="$vasteHypotheekSchip/rabo:GeldleningenInclRente/rabo:rente/rabo:VervalDatum/rabo:datum">
									<xsl:call-template name="rabo-datum"/>
								</xsl:for-each>
								<xsl:text> van elk jaar, voor het eerst op </xsl:text>
								<xsl:for-each select="$vasteHypotheekSchip/rabo:GeldleningenInclRente/rabo:rente/rabo:EersteVervalDatum/rabo:datum">
									<xsl:call-template name="rabo-datum"/>
								</xsl:for-each>
								<xsl:text>.</xsl:text>						
							</td>
						</tr>
					</xsl:if>
					<xsl:if test="$vasteHypotheekSchip/rabo:KredietenInclRente">
						<xsl:variable name="position">
							<xsl:value-of select="count($vasteHypotheekSchip/rabo:GeldleningenInclRente) + 1"/>
						</xsl:variable>
						<tr>
							<td class="number" valign="top">
								<xsl:value-of select="$position"/>
								<xsl:text>)</xsl:text>
							</td>
							<td>
								<xsl:choose>
									<xsl:when test="count($vasteHypotheekSchip/rabo:KredietenInclRente/rabo:Kredieten/rabo:bedrag) = 1">
										<xsl:text> krediet van de bank aan de debiteur groot </xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text> kredieten van de bank aan de debiteur respectievelijk groot </xsl:text>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:for-each select="$vasteHypotheekSchip/rabo:KredietenInclRente/rabo:Kredieten/rabo:bedrag">
									<xsl:call-template name="rabo-bedrag"/>
								</xsl:for-each>
								<xsl:text>. Zolang de rente niet wijzigt, is de rente voor </xsl:text>
								<xsl:choose>
									<xsl:when test="count($vasteHypotheekSchip/rabo:KredietenInclRente/rabo:Kredieten/rabo:bedrag) > 1">
										<xsl:text>deze kredieten respectievelijk </xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text>dit krediet </xsl:text>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:for-each select="$vasteHypotheekSchip/rabo:KredietenInclRente/rabo:rente/rabo:Rentepercentage/rabo:percentage">
									<xsl:call-template name="rabo-percentage"/>
								</xsl:for-each>
								<xsl:choose>
									<xsl:when test="count($vasteHypotheekSchip/rabo:KredietenInclRente/rabo:rente/rabo:VervalDatum/rabo:datum) > 1">
										<xsl:text> per jaar, vervallende respectievelijk op </xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text> per jaar, vervallende op </xsl:text>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:for-each select="$vasteHypotheekSchip/rabo:KredietenInclRente/rabo:rente/rabo:VervalDatum/rabo:datum">
									<xsl:call-template name="rabo-datum"/>
								</xsl:for-each>
								<xsl:text> van elk jaar, voor het eerst op </xsl:text>
								<xsl:for-each select="$vasteHypotheekSchip/rabo:KredietenInclRente/rabo:rente/rabo:EersteVervalDatum/rabo:datum">
									<xsl:call-template name="rabo-datum"/>
								</xsl:for-each>
								<xsl:text>.</xsl:text>
							</td>
						</tr>
					</xsl:if>
						<tr>
							<td colspan="2"><xsl:text>Wie de debiteur is, staat hierna.</xsl:text></td>
						</tr>
				</tbody>
			</table>
		</xsl:if>
	</xsl:template>
	<xsl:template name="vasteHypotheekGeenSchip">
		<xsl:variable name="vasteHypotheekGeenSchip" select="tia:partnerSpecifiek/rabo:VasteHypotheekGeenSchip"/>
		<table cellpadding="0" cellspacing="0">
			<tbody>
				<tr>
					<td colspan="2">
						<xsl:call-template name="TekstHypotheekverlening"/>
					</td>
				</tr>
				<xsl:if test="$vasteHypotheekGeenSchip/rabo:Geldleningen or $vasteHypotheekGeenSchip/rabo:Kredieten or $vasteHypotheekGeenSchip/rabo:Borgtochten">
					<xsl:if test="$vasteHypotheekGeenSchip/rabo:Geldleningen">
						<tr>
							<td class="number" valign="top">
								<xsl:text>1)</xsl:text>
							</td>
							<td>
								<xsl:text/>
								<xsl:choose>
									<xsl:when test="count($vasteHypotheekGeenSchip/rabo:Geldleningen/rabo:bedrag) = 1">
										<xsl:text>de geldlening van de bank aan de debiteur groot </xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text>de geldleningen van de bank aan de debiteur respectievelijk groot </xsl:text>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:for-each select="$vasteHypotheekGeenSchip/rabo:Geldleningen/rabo:bedrag">
									<xsl:call-template name="rabo-bedrag"/>
								</xsl:for-each>
							</td>
						</tr>
					</xsl:if>
					<xsl:if test="$vasteHypotheekGeenSchip/rabo:Kredieten">
						<tr>
							<xsl:variable name="position">
								<xsl:value-of select="count($vasteHypotheekGeenSchip/rabo:Geldleningen) + 1"/>
							</xsl:variable>
							<td class="number" valign="top">
								<xsl:value-of select="$position"/>
								<xsl:text>)</xsl:text>
							</td>
							<td>
								<xsl:text/>
								<xsl:choose>
									<xsl:when test="count($vasteHypotheekGeenSchip/rabo:Kredieten/rabo:bedrag) = 1">
										<xsl:text>het krediet van de bank aan de debiteur groot </xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text>de kredieten van de bank aan de debiteur respectievelijk groot </xsl:text>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:for-each select="$vasteHypotheekGeenSchip/rabo:Kredieten/rabo:bedrag">
									<xsl:call-template name="rabo-bedrag"/>
								</xsl:for-each>
							</td>
						</tr>
					</xsl:if>
					<xsl:if test="$vasteHypotheekGeenSchip/rabo:Borgtochten">
						<xsl:variable name="position">
							<xsl:value-of select="count($vasteHypotheekGeenSchip/rabo:Geldleningen) + count($vasteHypotheekGeenSchip/rabo:Kredieten) + 1"/>
						</xsl:variable>
						<tr>
							<td class="number" valign="top">
								<xsl:value-of select="$position"/>
								<xsl:text>)</xsl:text>
							</td>
							<td>
								<xsl:choose>
									<xsl:when test="count($vasteHypotheekGeenSchip/rabo:Borgtochten/rabo:IMKAD_Persoon) = 1">
										<xsl:text> de borgtocht </xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text> de borgtochten </xsl:text>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:text>van de debiteur aan de bank voor de verplichtingen van </xsl:text>
								<xsl:for-each select="$vasteHypotheekGeenSchip/rabo:Borgtochten/rabo:IMKAD_Persoon">
									<xsl:apply-templates select="." mode="do-natural-person-rabo"/>
									<xsl:choose>
										<xsl:when test="position() = (last() - 1)">
											<xsl:text> en </xsl:text>
										</xsl:when>
										<xsl:when test="position() != last()">
											<xsl:text>, </xsl:text>
										</xsl:when>
									</xsl:choose>
								</xsl:for-each>
							</td>
						</tr>
					</xsl:if>
					<tr>
						<td colspan="2">
							<xsl:text>zoals afgesproken in </xsl:text>
							<xsl:choose>
								<xsl:when test="$vasteHypotheekGeenSchip/rabo:vasteHypotheek/rabo:OnderhandseAkte">
									<xsl:text>de onderhandse akte</xsl:text>
									<xsl:if test="count($vasteHypotheekGeenSchip/rabo:vasteHypotheek/rabo:OnderhandseAkte/rabo:datum) > 1">
										<xsl:text>n respectievelijk</xsl:text>
									</xsl:if>
									<xsl:text> van </xsl:text>
									<xsl:for-each select="$vasteHypotheekGeenSchip/rabo:vasteHypotheek/rabo:OnderhandseAkte/rabo:datum">
										<xsl:call-template name="rabo-datum"/>
									</xsl:for-each>
								</xsl:when>
								<xsl:when test="$vasteHypotheekGeenSchip/rabo:vasteHypotheek/rabo:Offerte">
									<xsl:choose>
										<xsl:when test="count($vasteHypotheekGeenSchip/rabo:vasteHypotheek/rabo:Offerte/rabo:datum) > 1">
											<xsl:text>de offertes en overeenkomsten lening respectievelijk van </xsl:text>
										</xsl:when>
										<xsl:otherwise>
											<xsl:text>de offerte en overeenkomst lening van </xsl:text>
										</xsl:otherwise>
									</xsl:choose>
									<xsl:for-each select="$vasteHypotheekGeenSchip/rabo:vasteHypotheek/rabo:Offerte/rabo:datum">
										<xsl:call-template name="rabo-datum"/>
									</xsl:for-each>
									<xsl:text> en</xsl:text>
									<xsl:if test="$vasteHypotheekGeenSchip/rabo:vasteHypotheek/rabo:OfferteAcceptatie">
										<xsl:if test="count($vasteHypotheekGeenSchip/rabo:vasteHypotheek/rabo:OfferteAcceptatie/rabo:datum) > 1">
											<xsl:text> respectievelijk</xsl:text>
										</xsl:if>
										<xsl:text> geaccepteerd op </xsl:text>
										<xsl:for-each select="$vasteHypotheekGeenSchip/rabo:vasteHypotheek/rabo:OfferteAcceptatie/rabo:datum">
											<xsl:call-template name="rabo-datum"/>
										</xsl:for-each>
									</xsl:if>
								</xsl:when>
								<xsl:when test="$vasteHypotheekGeenSchip/rabo:vasteHypotheek/rabo:Financieringsvoorstel or $vasteHypotheekGeenSchip/rabo:vasteHypotheek/rabo:FinancieringsvoorstelAcceptatie">
									<xsl:text>de overeenkomst</xsl:text>
									<xsl:if test="count($vasteHypotheekGeenSchip/rabo:vasteHypotheek/rabo:Financieringsvoorstel/rabo:datum) > 1">
										<xsl:text>en</xsl:text>
									</xsl:if>
									<xsl:text> zakelijke financiering </xsl:text>
									<xsl:if test="count($vasteHypotheekGeenSchip/rabo:vasteHypotheek/rabo:Financieringsvoorstel/rabo:datum) > 1">
										<xsl:text>respectievelijk </xsl:text>
									</xsl:if>
									<xsl:text>van </xsl:text>
									<xsl:for-each select="$vasteHypotheekGeenSchip/rabo:vasteHypotheek/rabo:Financieringsvoorstel/rabo:datum">
										<xsl:call-template name="rabo-datum"/>
									</xsl:for-each>
									<xsl:if test="$vasteHypotheekGeenSchip/rabo:vasteHypotheek/rabo:FinancieringsvoorstelAcceptatie">
										<xsl:text> en</xsl:text>
										<xsl:if test="count($vasteHypotheekGeenSchip/rabo:vasteHypotheek/rabo:FinancieringsvoorstelAcceptatie/rabo:datum) > 1">
											<xsl:text> respectievelijk</xsl:text>
										</xsl:if>
										<xsl:text> geaccepteerd op </xsl:text>
										<xsl:for-each select="$vasteHypotheekGeenSchip/rabo:vasteHypotheek/rabo:FinancieringsvoorstelAcceptatie/rabo:datum">
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
							<xsl:text>. Wie de debiteur is, staat hierna.</xsl:text>
						</td>
					</tr>
				</xsl:if>
			</tbody>
		</table>
	</xsl:template>
	<xsl:template name="bankHypotheek">
		<table>
			<tbody>
				<tr>
					<td colspan="2">
						<xsl:call-template name="TekstHypotheekverlening"/>
						<xsl:text>alle schulden van de debiteur aan de bank. Wie de debiteur is, staat hierna. Zijn er meer debiteuren? Dan geldt het hypotheekrecht als zekerheid voor de schulden van de debiteuren samen. Maar ook voor de schulden van iedere debiteur apart. Het kunnen schulden zijn die de debiteur nu al heeft en schulden die de debiteur later krijgt aan de bank. Een schuld kan ontstaan uit elke rechtsverhouding tussen de debiteur en de bank. Bijvoorbeeld uit:
								</xsl:text>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>-</xsl:text>
					</td>
					<td>
						<xsl:text>geldleningen en kredieten</xsl:text>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>-</xsl:text>
					</td>
					<td>
						<xsl:text>borgtochten, bankgaranties en contragaranties</xsl:text>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>-</xsl:text>
					</td>
					<td>
						<xsl:text>regresvorderingen</xsl:text>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>-</xsl:text>
					</td>
					<td>
						<xsl:text>financiële instrumenten, waaronder derivatencontracten.</xsl:text>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top" colspan="2">
						<xsl:text>De hypotheekgever gaat ermee akkoord dat de bank borgtochten, garanties en vergelijkbare (persoonlijke) zekerheden mag afgeven aan andere rechtspersonen binnen de Rabobank Groep voor schulden die de debiteur bij die andere rechtspersonen heeft of zal krijgen. Dit heeft tot gevolg dat de bank het hypotheekrecht ook kan gebruiken wanneer de debiteur zijn schulden aan die andere rechtspersoon binnen de Rabobank Groep niet (op tijd) betaalt.</xsl:text>
					</td>
				</tr>
			</tbody>
		</table>
	</xsl:template>
	<xsl:template name="rabo-datum">
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
	</xsl:template>
	<xsl:template name="rabo-bedrag">
		<xsl:call-template name="amountText">
			<xsl:with-param name="amount" select="rabo:som"/>
			<xsl:with-param name="valuta" select="rabo:valuta"/>
		</xsl:call-template>
		<xsl:text> </xsl:text>
		<xsl:call-template name="amountNumber">
			<xsl:with-param name="amount" select="rabo:som"/>
			<xsl:with-param name="valuta" select="rabo:valuta"/>
		</xsl:call-template>
		<xsl:choose>
			<xsl:when test="position() = (last() - 1)">
				<xsl:text> en </xsl:text>
			</xsl:when>
			<xsl:when test="position() != last()">
				<xsl:text>, </xsl:text>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="rabo-percentage">
		<xsl:call-template name="percentText">
			<xsl:with-param name="percent" select="."/>
		</xsl:call-template>
		<xsl:text> </xsl:text>
		<xsl:call-template name="percentNumber">
			<xsl:with-param name="percent" select="."/>
		</xsl:call-template>
		<xsl:choose>
			<xsl:when test="position() = (last() - 1)">
				<xsl:text> en </xsl:text>
			</xsl:when>
			<xsl:when test="position() != last()">
				<xsl:text>, </xsl:text>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
