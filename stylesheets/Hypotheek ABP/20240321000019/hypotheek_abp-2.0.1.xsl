<?xml version="1.0" encoding="UTF-8"?>
<!--
*************************************************************
Stylesheet: hypotheek_abp.xsl
Version: 2.0.1
- [AA-6530] ABP: stylesheet: lidwoord bij geldnemer partij en titelkopje Woonplaatskeuze is verkeerd
*************************************************************
Public:
(mode) do-deed
-->
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:tia="http://www.kadaster.nl/schemas/KIK/TIA_Algemeen" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:kef="nl.kadaster.xslt.XslExtensionFunctions" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exslt="http://exslt.org/common" xmlns:gc="http://docs.oasis-open.org/codelist/ns/genericode/1.0/" exclude-result-prefixes="tia xsl xlink kef gc" version="1.0">
	<xsl:include href="generiek-1.08.xsl"/>
	<xsl:include href="tekstblok_aanhef-1.20.xsl"/>
	<xsl:include href="tekstblok_burgerlijke_staat-1.03.xsl"/>
	<xsl:include href="tekstblok_equivalentieverklaring-1.30.xsl"/>
	<xsl:include href="tekstblok_gevolmachtigde-1.26.xsl"/>
	<xsl:include href="tekstblok_legitimatie-2.00.xsl"/>
	<xsl:include href="tekstblok_personalia_van_natuurlijk_persoon-1.06.xsl"/>
	<xsl:include href="tekstblok_natuurlijk_persoon-1.13.xsl"/>
	<xsl:include href="tekstblok_partij_natuurlijk_persoon-1.39.xsl"/>
	<xsl:include href="tekstblok_partij_niet_natuurlijk_persoon-1.53.xsl"/>
	<xsl:include href="tekstblok_recht-1.17.xsl"/>
	<xsl:include href="tekstblok_rechtspersoon-1.15.0.xsl"/>
	<xsl:include href="tekstblok_registergoed-1.29.xsl"/>
	<xsl:include href="tekstblok_titel_hypotheekakten-1.02.xsl"/>
	<xsl:include href="tekstblok_woonadres-1.05.xsl"/>
	<xsl:include href="tweededeel-1.05.xsl"/>
	<!-- ABP specific global variables -->
	<xsl:variable name="keuzeteksten" select="document('keuzeteksten_hypotheek_abp-1.0.0.xml')"/>
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

	Description: ABP mortgage deed.

	Input: tia:Bericht_TIA_Stuk

	Params: none

	Output: XHTML structure

	Calls:
	(mode) do-statement-of-equivalence
	(mode) do-header
	(mode) do-comparitie
	(mode) do-rights
	(mode) do-overbruggingshypotheek
	(mode) do-election-of-domicile
	(mode) do-free-text
	(name) amountText
	(name) amountNumber

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
		<!-- (Titel) Text block Mortgage deed title -->
		<xsl:apply-templates select="tia:IMKAD_AangebodenStuk" mode="do-mortgage-deed-title"/>
		<!-- (Aanhef) Text block Header -->
		<xsl:apply-templates select="tia:IMKAD_AangebodenStuk" mode="do-header"/>
		<xsl:apply-templates select="tia:IMKAD_AangebodenStuk/tia:Partij" mode="do-comparitie"/>
		<xsl:variable name="personAppearing">
			<xsl:choose>
				<xsl:when test="tia:IMKAD_AangebodenStuk/tia:Partij[@id = substring-after(../tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:vervreemderRechtRef/@*[translate(local-name(), $upper, $lower) = 'href'], '#')]/tia:Gevolmachtigde[count(tia:GerelateerdPersoon) = 0 and tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#', ../tia:Hoedanigheid[count(tia:wordtVertegenwoordigdRef) = 0]/@id)]/tia:gegevens/tia:persoonGegevens/tia:geslacht/tia:geslachtsaanduiding[translate(normalize-space(.), $upper, $lower) = 'man']
						or tia:IMKAD_AangebodenStuk/tia:Partij[@id = substring-after(../tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:vervreemderRechtRef/@*[translate(local-name(), $upper, $lower) = 'href'], '#') and not(tia:Gevolmachtigde) and (count(tia:IMKAD_Persoon) = 1 and count(tia:IMKAD_Persoon[count(descendant::tia:IMKAD_Persoon) = 0]) = 1 and (count(tia:IMKAD_Persoon[tia:tia_Gegevens/tia:GBA_Ingezetene/tia:geslacht/tia:geslachtsaanduiding[translate(normalize-space(.), $upper, $lower) = 'man']]) = 1 or count(tia:IMKAD_Persoon[tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:geslacht[translate(normalize-space(.), $upper, $lower) = 'man']]) = 1))]
						or tia:IMKAD_AangebodenStuk/tia:Partij[@id = substring-after(../tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:vervreemderRechtRef/@*[translate(local-name(), $upper, $lower) = 'href'], '#') and not(tia:Gevolmachtigde) and count(tia:IMKAD_Persoon) > 0 and count(tia:IMKAD_Persoon[(tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene)]) = 0]/tia:IMKAD_Persoon[count(tia:GerelateerdPersoon) = 1 and tia:tia_Gegevens/tia:NHR_Rechtspersoon and (count(tia:GerelateerdPersoon/tia:IMKAD_Persoon[not(tia:GerelateerdPersoon) and tia:tia_Gegevens/tia:GBA_Ingezetene/tia:geslacht/tia:geslachtsaanduiding[translate(normalize-space(.), $upper, $lower) = 'man']]) = 1 or count(tia:GerelateerdPersoon/tia:IMKAD_Persoon[tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:geslacht[translate(normalize-space(.), $upper, $lower) = 'man']]) = 1)]">
					<xsl:text>Comparant</xsl:text>
				</xsl:when>
				<xsl:when test="tia:IMKAD_AangebodenStuk/tia:Partij[@id = substring-after(../tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:vervreemderRechtRef/@*[translate(local-name(), $upper, $lower) = 'href'], '#')]/tia:Gevolmachtigde[count(tia:GerelateerdPersoon) = 0 and tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#', ../tia:Hoedanigheid[count(tia:wordtVertegenwoordigdRef) = 0]/@id)]/tia:gegevens/tia:persoonGegevens/tia:geslacht/tia:geslachtsaanduiding[translate(normalize-space(.), $upper, $lower) = 'vrouw']
						or tia:IMKAD_AangebodenStuk/tia:Partij[@id = substring-after(../tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:vervreemderRechtRef/@*[translate(local-name(), $upper, $lower) = 'href'], '#') and not(tia:Gevolmachtigde) and (count(tia:IMKAD_Persoon) = 1 and count(tia:IMKAD_Persoon[count(descendant::tia:IMKAD_Persoon) = 0]) = 1 and (count(tia:IMKAD_Persoon[tia:tia_Gegevens/tia:GBA_Ingezetene/tia:geslacht/tia:geslachtsaanduiding[translate(normalize-space(.), $upper, $lower) = 'vrouw']]) = 1 or count(tia:IMKAD_Persoon[tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:geslacht[translate(normalize-space(.), $upper, $lower) = 'vrouw']]) = 1))]
						or tia:IMKAD_AangebodenStuk/tia:Partij[@id = substring-after(../tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:vervreemderRechtRef/@*[translate(local-name(), $upper, $lower) = 'href'], '#') and not(tia:Gevolmachtigde) and count(tia:IMKAD_Persoon) > 0 and count(tia:IMKAD_Persoon[(tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene)]) = 0]/tia:IMKAD_Persoon[count(tia:GerelateerdPersoon) = 1 and tia:tia_Gegevens/tia:NHR_Rechtspersoon and (count(tia:GerelateerdPersoon/tia:IMKAD_Persoon[not(tia:GerelateerdPersoon) and tia:tia_Gegevens/tia:GBA_Ingezetene/tia:geslacht/tia:geslachtsaanduiding[translate(normalize-space(.), $upper, $lower) = 'vrouw']]) = 1 or count(tia:GerelateerdPersoon/tia:IMKAD_Persoon[tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:geslacht[translate(normalize-space(.), $upper, $lower) = 'vrouw']]) = 1)]">
					<xsl:text>Comparante</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>Comparanten</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- par.2.4.3: Afsluiting partijen -->
		<p>
			<xsl:text>Van het bestaan van de aan de </xsl:text>
			<xsl:choose>
				<xsl:when test="tia:IMKAD_AangebodenStuk/tia:Partij[translate(tia:aanduidingPartij, $upper, $lower) = 'geldgever']/tia:Gevolmachtigde/tia:gegevens/tia:persoonGegevens/tia:geslacht[translate(normalize-space(tia:geslachtsaanduiding), $upper, $lower) = 'man']">
					<xsl:text>comparant</xsl:text>
				</xsl:when>
				<xsl:when test="tia:IMKAD_AangebodenStuk/tia:Partij[translate(tia:aanduidingPartij, $upper, $lower) = 'geldgever']/tia:Gevolmachtigde/tia:gegevens/tia:persoonGegevens/tia:geslacht[translate(normalize-space(tia:geslachtsaanduiding), $upper, $lower) = 'vrouw']">
					<xsl:text>comparante</xsl:text>
				</xsl:when>
			</xsl:choose>
			<xsl:text> onder 1 genoemd verleende volmacht is mij, notaris, genoegzaam gebleken.</xsl:text>
		</p>
		<p>
			<xsl:text>De comparanten verklaren dat hypotheekgever en geldgever zijn overeengekomen en zo nodig komen zij hierbij overeen dat door hypotheekgever ten behoeve van geldgever tot zekerheid als in deze akte omschreven het recht van hypotheek en pandrechten zal worden gevestigd op de in deze akte en na te melden Algemene Voorwaarden omschreven goederen. Deze overeenkomst blijkt uit een aan deze akte gehechte, door hypotheekgever geaccepteerde, bindend aanbod ter uitvoering waarvan het navolgende is overeengekomen:</xsl:text>
		</p>
		<!-- Details of Mortgage -->
		<a name="hyp3.detailsOfMortgage" class="location">&#160;</a>
		<table cellspacing="0" cellpadding="0">
			<tbody>
				<tr>
					<td class="number" valign="top">
						<xsl:text>2.</xsl:text>
					</td>
					<td colspan="2">
						<u>
							<xsl:text>LENING</xsl:text>
						</u>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<td colspan="2">
						<xsl:text>Geldnemer verklaart ter leen te hebben ontvangen van geldgever en mitsdien aan geldgever schuldig te zijn een bedrag van </xsl:text>
						<xsl:call-template name="amountText">
							<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragLening/tia:som"/>
							<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragLening/tia:valuta"/>
						</xsl:call-template>
						<xsl:text> </xsl:text>
						<xsl:call-template name="amountNumber">
							<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragLening/tia:som"/>
							<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragLening/tia:valuta"/>
						</xsl:call-template>
						<xsl:text> hierna te noemen: hoofdsom.</xsl:text>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>3.</xsl:text>
					</td>
					<td colspan="2">
						<u>
							<xsl:text>LENINGGEGEVENS</xsl:text>
						</u>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<td class="number" valign="top">
						<xsl:text>I.</xsl:text>
					</td>
					<td>
						<u>
							<xsl:text>Looptijd en aflossing</xsl:text>
						</u>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<td>
						<xsl:text>De lening heeft een looptijd en een aflossingswijze zoals in het bindend aanbod is bepaald, danwel eventueel nader tussen partijen zal worden overeengekomen.</xsl:text>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<td class="number" valign="top">
						<xsl:text>II.</xsl:text>
					</td>
					<td>
						<u>
							<xsl:text>Rente</xsl:text>
						</u>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<td>
						<xsl:text>Geldnemer is voor het eerst vanaf de datum omschreven in de Algemene Voorwaarden tot het einde van de desbetreffende maand naar het overeengekomen percentage rente verschuldigd, berekend over de hoofdsom. De rente wordt voor iedere volgende maand tot en met het einde van de looptijd van de geldlening naar het overeengekomen percentage berekend over de schuld per het einde van de daaraan voorafgaande maand. Bij de saldobepaling van de schuld zullen eventueel verschuldigde maar niet betaalde rente, kosten en andere bedragen bij de schuld worden geteld.</xsl:text>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<td class="number" valign="top">
						<xsl:text>III.</xsl:text>
					</td>
					<td>
						<u>
							<xsl:text>Verhogingen</xsl:text>
						</u>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<td>
						<xsl:text>De lening kan worden verhoogd als voldaan wordt aan de door geldgever op dat moment voor soortgelijke geldleningen vastgestelde financieringscriteria. Geldgever is niet verplicht om in te stemmen met een verzoek tot verhoging. Een verhoging van de lening wordt verwerkt door het toevoegen van één of meer nieuwe leningdelen. Bij een verhoging worden op alle leningdelen de op dat moment geldende (nieuwe) Algemene Voorwaarden van geldgever van kracht.</xsl:text>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<td class="number" valign="top">
						<xsl:text>IV.</xsl:text>
					</td>
					<td>
						<u>
							<xsl:text>Overige bepalingen</xsl:text>
						</u>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<td>
						<xsl:text>Op deze lening en deze hypotheekakte zijn van toepassing de Algemene Voorwaarden zoals in de aan deze akte gehechte bindend aanbod genoemd. </xsl:text>
						<xsl:value-of select="$personAppearing"/>
						<xsl:text> sub 2 (en/of hypotheekgever)</xsl:text>
						<xsl:choose>
							<xsl:when test="$personAppearing = 'Comparant' or $personAppearing = 'Comparante'">
								<xsl:text> verklaart</xsl:text>
							</xsl:when>
							<xsl:when test="$personAppearing = 'Comparanten'">
								<xsl:text> verklaren</xsl:text>
							</xsl:when>
						</xsl:choose>
						<xsl:text> een exemplaar van deze Algemene Voorwaarden te hebben ontvangen en met de inhoud daarvan akkoord te gaan. De Algemene Voorwaarden worden geacht woordelijk in deze hypotheekakte te zijn opgenomen en daarmee één geheel te vormen.</xsl:text>
					</td>
				</tr>
				<xsl:if test="translate(tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_svnstarterslening']/tia:tekst, $upper, $lower) = 'true'">
					<tr>
						<td class="number" valign="top">
							<xsl:text>&#xFEFF;</xsl:text>
						</td>
						<td class="number" valign="top">
							<xsl:text>V.</xsl:text>
						</td>
						<td>
							<u>
								<xsl:text>SVn Starterslening</xsl:text>
							</u>
						</td>
					</tr>
					<tr>
						<td class="number" valign="top">
							<xsl:text>&#xFEFF;</xsl:text>
						</td>
						<td class="number" valign="top">
							<xsl:text>&#xFEFF;</xsl:text>
						</td>
						<td>
							<xsl:text>In verband met de door de Stichting Stimuleringsfonds Volkshuisvesting Nederlandse Gemeenten (SVn) te verstrekken Starterslening, heeft geldgever zich jegens SVn en Stichting Waarborgfonds Eigen Woningen (WEW) verplicht, na het ingaan van de lening geen gelden meer onder verband van de eerste hypotheekstelling ter leen te verstrekken aan de geldnemer. Tevens heeft geldgever zich jegens SVn en WEW verplicht reeds afgeloste bedragen op de lening, onder verband van de eerste hypotheekstelling, niet opnieuw te laten opnemen door de geldnemer. Voormelde verplichtingen rusten op geldgever uitsluitend zolang de bij SVn aangegane Starterslening niet volledig is afgelost.</xsl:text>
						</td>
					</tr>
				</xsl:if>
				<tr>
					<td class="number" valign="top">
						<xsl:text>4.</xsl:text>
					</td>
					<td colspan="2">
						<u>
							<xsl:text>HYPOTHEEKSTELLING</xsl:text>
						</u>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<td colspan="2">
						<xsl:text>Tot zekerheid voor de terugbetaling van al hetgeen geldgever blijkens zijn administratie nu of in de toekomst van hypotheekgever te vorderen heeft of zal hebben uit welke hoofde ook, waaronder met name begrepen maar niet beperkt tot hetgeen geldgever te vorderen heeft of zal hebben op grond van de in deze akte geconstateerde geldlening en (eventueel) nog te verstrekken geldlening(en), de betaling van de verschuldigde rente, vergoedingen en kosten, verleent hypotheekgever tot een bedrag van </xsl:text>
						<xsl:call-template name="amountText">
							<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:hoofdsom/tia:som"/>
							<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:hoofdsom/tia:valuta"/>
						</xsl:call-template>
						<xsl:text> </xsl:text>
						<xsl:call-template name="amountNumber">
							<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:hoofdsom/tia:som"/>
							<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:hoofdsom/tia:valuta"/>
						</xsl:call-template>
						<xsl:text>, te vermeerderen met de rente over drie jaren, vergoedingen en kosten, die tezamen worden begroot op </xsl:text>
						<xsl:call-template name="amountText">
							<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragRente/tia:som"/>
							<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragRente/tia:valuta"/>
						</xsl:call-template>
						<xsl:text> </xsl:text>
						<xsl:call-template name="amountNumber">
							<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragRente/tia:som"/>
							<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragRente/tia:valuta"/>
						</xsl:call-template>
						<xsl:text>, zijnde veertig procent (40%) van het hiervoor genoemde bedrag, derhalve in totaal voor een bedrag van </xsl:text>
						<xsl:call-template name="amountText">
							<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragTotaal/tia:som"/>
							<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragTotaal/tia:valuta"/>
						</xsl:call-template>
						<xsl:text> </xsl:text>
						<xsl:call-template name="amountNumber">
							<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragTotaal/tia:som"/>
							<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragTotaal/tia:valuta"/>
						</xsl:call-template>
						<xsl:text>, recht van </xsl:text>
						<xsl:if test="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:rangordeHypotheek">
							<xsl:value-of select="kef:convertOrdinalToText(tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:rangordeHypotheek)"/>
							<xsl:text> </xsl:text>
						</xsl:if>
						<xsl:text>hypotheek op het navolgende registergoed:</xsl:text>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<td colspan="2">
						<xsl:apply-templates select="." mode="do-rights">
							<xsl:with-param name="stukdeelHypotheek" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']"/>
						</xsl:apply-templates>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<td colspan="2">
						<xsl:text>(hierna te noemen onderpand).</xsl:text>
					</td>
				</tr>
				<xsl:if test="translate(tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[translate(tia:aanduidingHypotheek, $upper, $lower) = 'overbruggingshypotheek'], $upper, $lower) != ''">
					<tr>
						<td class="number" valign="top">
							<xsl:text>5.</xsl:text>
						</td>
						<td colspan="2">
							<u>
								<xsl:text>OVERBRUGGINGSHYPOTHEEK</xsl:text>
							</u>
						</td>
					</tr>
					<tr>
						<td class="number" valign="top">
							<xsl:text>&#xFEFF;</xsl:text>
						</td>
						<td colspan="2">
							<xsl:text>Voorts verleent geldnemer, tot zekerheid voor de betaling van de schuld als hierboven vermeld bij deze aan geldgever, die van geldnemer aanvaardt, het recht van</xsl:text>
							<xsl:if test="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[normalize-space(tia:aanduidingHypotheek) = 'overbruggingshypotheek']/tia:rangordeHypotheek">
								<xsl:text> </xsl:text>						
								<xsl:value-of select="kef:convertOrdinalToText(tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[normalize-space(tia:aanduidingHypotheek) = 'overbruggingshypotheek']/tia:rangordeHypotheek)"/>
							</xsl:if>														
							<xsl:text> hypotheek op het navolgende registergoed:</xsl:text>
						</td>
					</tr>
					<tr>
						<td class="number" valign="top">
							<xsl:text>&#xFEFF;</xsl:text>
						</td>
						<td colspan="2">
							<xsl:apply-templates select="." mode="do-rights">
								<xsl:with-param name="stukdeelHypotheek" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[normalize-space(tia:aanduidingHypotheek) = 'overbruggingshypotheek']"/>
							</xsl:apply-templates>
						</td>
					</tr>
					<tr>
						<td class="number" valign="top">
							<xsl:text>&#xFEFF;</xsl:text>
						</td>
						<td colspan="2">
							<xsl:text>(hierna eveneens te noemen onderpand).</xsl:text>
						</td>
					</tr>
				</xsl:if>
				<tr>
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<td colspan="2">
						<xsl:text>De </xsl:text>
						<xsl:choose>
							<xsl:when test="tia:IMKAD_AangebodenStuk/tia:Partij[translate(tia:aanduidingPartij, $upper, $lower) = 'geldgever']/tia:Gevolmachtigde/tia:gegevens/tia:persoonGegevens/tia:geslacht[translate(normalize-space(tia:geslachtsaanduiding), $upper, $lower) = 'man']">
								<xsl:text>comparant</xsl:text>
							</xsl:when>
							<xsl:when test="tia:IMKAD_AangebodenStuk/tia:Partij[translate(tia:aanduidingPartij, $upper, $lower) = 'geldgever']/tia:Gevolmachtigde/tia:gegevens/tia:persoonGegevens/tia:geslacht[translate(normalize-space(tia:geslachtsaanduiding), $upper, $lower) = 'vrouw']">
								<xsl:text>comparante</xsl:text>
							</xsl:when>
						</xsl:choose>
						<xsl:text> onder 1 genoemd verklaart de hiervoor vermelde schuldbekentenis met hypotheekstelling alsmede de hierna vermelde verpandingen en overdracht van rechten onder de daarbij gemaakte bedingen alsmede de (eventuele) borgstelling(en) voor en ten behoeve van geldgever aan te nemen.</xsl:text>
					</td>
				</tr>
			</tbody>
		</table>
		<xsl:apply-templates select="." mode="do-election-of-domicile"/>
		<p>
			<xsl:text>EINDE KADASTERDEEL</xsl:text>
		</p>
		<xsl:apply-templates select="." mode="do-free-text"/>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-rights
	*********************************************************
	Public: yes

	Identity transform: no

	Description: Obvion mortgage deed rights.

	Input: tia:Bericht_TIA_Stuk

	Params: none

	Output: XHTML structure

	Calls:
	(mode) do-right
	(mode) do-registered-object
	(name) processRights

	Called by:
	(mode) do-deed
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:Bericht_TIA_Stuk" mode="do-rights">
		<xsl:param name="stukdeelHypotheek"/>
		<xsl:variable name="allProcessedRights" select="$stukdeelHypotheek/tia:IMKAD_ZakelijkRecht"/>
		<xsl:choose>
			<xsl:when test="count($allProcessedRights) = 1">
				<xsl:variable name="rightText">
					<xsl:apply-templates select="$allProcessedRights" mode="do-right"/>
				</xsl:variable>
				<xsl:if test="normalize-space($rightText) != ''">
					<xsl:value-of select="$rightText"/>
					<xsl:text> </xsl:text>
				</xsl:if>
				<xsl:apply-templates select="$allProcessedRights" mode="do-registered-object"/>
				<xsl:text>;</xsl:text>
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
						and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:kadBinnenlandsAdres/tia:huisNummerToevoeging)))]]) and $RegistergoedTonenPerPerceel='false'">
				<xsl:variable name="rightText">
					<xsl:apply-templates select="$allProcessedRights[1]" mode="do-right"/>
				</xsl:variable>
				<xsl:if test="normalize-space($rightText) != ''">
					<xsl:value-of select="$rightText"/>
					<xsl:text> </xsl:text>
				</xsl:if>
				<xsl:apply-templates select="$allProcessedRights[1]" mode="do-registered-object"/>
				<xsl:text>;</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<table cellpadding="0" cellspacing="0">
					<tbody>
						<xsl:call-template name="processRights">
							<xsl:with-param name="positionOfProcessedRight" select="1"/>
							<xsl:with-param name="position" select="1"/>
							<xsl:with-param name="haveAdditionalText" select="'true'"/>
							<!-- forceer de ; na elke aanroep recht/registergoed -->
							<xsl:with-param name="registeredObjects" select="$stukdeelHypotheek"/>
						</xsl:call-template>
					</tbody>
				</table>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-election-of-domicile
	*********************************************************
	Public: yes

	Identity transform: no

	Description: Obvion mortgage deed election of domicile.

	Input: tia:Bericht_TIA_Stuk

	Params: none

	Output: XHTML structure

	Calls: none

	Called by:
	(mode) do-deed
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:Bericht_TIA_Stuk" mode="do-election-of-domicile">
		<xsl:variable name="woonplaatskeuze" select="tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_woonplaatskeuze']/tia:tekst"/>
		<a name="hyp3.electionOfDomicile" class="location">&#160;</a>
		<xsl:if test="$woonplaatskeuze != ''">
			<p>
				<u>
					<xsl:text>WOONPLAATS</xsl:text>
				</u>
			</p>
			<p>
				<xsl:value-of select="$woonplaatskeuze"/>
			</p>
		</xsl:if>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-free-text
	*********************************************************
	Public: yes

	Identity transform: no

	Description: Obvion mortgage deed free text part.

	Input: tia:Bericht_TIA_Stuk

	Params: none

	Output: XHTML structure

	Calls:
	(mode) do-free-text

	Called by:
	(mode) do-deed
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:Bericht_TIA_Stuk" mode="do-free-text">
		<!-- Free text part -->
		<a name="hyp3.part2" class="location">&#160;</a>
		<xsl:apply-templates select="tia:IMKAD_AangebodenStuk/tia:tia_TekstTweedeDeel" mode="do-free-text"/>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-comparitie
	*********************************************************
	Public: no

	Identity transform: no

	Description: Obvion mortgage deed parties.

	Input: tia:Partij

	Output: XHTML structure

	Calls:
	(mode) do-party-person
	(mode) do-mortgage-deed-party-name

	Called by:
	(mode) do-deed
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:Partij" mode="do-comparitie">
		<xsl:variable name="numberOfPersons" select="count(tia:IMKAD_Persoon[normalize-space(tia:tia_IndGerechtigde) = 'true']) + count(tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[normalize-space(tia:tia_IndGerechtigde) = 'true'])"/>
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
					<xsl:when test="position() = 1">
						<tr>
							<td>
								<table>
									<tbody>
										<tr>
											<td class="number"/>
											<td>
												<xsl:apply-templates select="tia:IMKAD_Persoon" mode="do-legal-person"/>
												<xsl:if test="tia:IMKAD_Persoon/tia:IMKAD_PostlocatiePersoon">
													<xsl:text> (correspondentieadres voor alle aangelegenheden betreffende de hierna te vermelden rechtshandelingen: </xsl:text>
													<xsl:apply-templates select="tia:IMKAD_Persoon/tia:IMKAD_PostlocatiePersoon" mode="do-correspondant-address"/>
													<xsl:text>)</xsl:text>
												</xsl:if>
												<xsl:text>;</xsl:text>
											</td>
										</tr>
									</tbody>
								</table>
							</td>
						</tr>
					</xsl:when>
					<xsl:when test="position() = 2">
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
				</xsl:choose>
			</tbody>
		</table>
		<p style="margin-left:30px">
			<xsl:choose>
				<!-- bij de eerste aanroep gaat het om de geldgever -->
				<xsl:when test="position() = 1">
					<xsl:text>hierna te noemen: geldgever</xsl:text>
					<xsl:if test="translate(tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_rechtsopvolgers']/tia:tekst, $upper, $lower) = 'true'">
						<xsl:text> (waaronder begrepen haar rechtsopvolgers onder algemene en bijzondere titel)</xsl:text>
					</xsl:if>
					<xsl:text>;</xsl:text>
				</xsl:when>
				<!-- bij de tweede aanroep gaat het om de geldnemer -->
				<xsl:when test="position() = 2">
					<xsl:text>hierna</xsl:text>
					<xsl:if test="$numberOfPersons > 1">
						<xsl:text> zowel gezamenlijk als ieder afzonderlijk</xsl:text>
					</xsl:if>
					<xsl:text> te noemen: geldnemer of hypotheekgever;</xsl:text>
				</xsl:when>
			</xsl:choose>
		</p>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-party-person
	*********************************************************
	Public: no

	Identity transform: no

	Description: Obvion mortgage deed party persons.

	Input: tia:IMKAD_Persoon

	Params: none

	Output: XHTML structure

	Calls:
	(mode) do-party-natural-person
	(mode) do-party-legal-person

	Called by:
	(mode) do-comparitie
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
</xsl:stylesheet>