<?xml version="1.0" encoding="UTF-8"?>
<!--
*************************************************************
Stylesheet: hypotheek_credo.xsl
Version: 2.0.0
Laatste wijziging;
- [AA-7712] Genderneutraal maken Hypotheekakten - ABP, Aegon Stater, Argenta, Credo
*************************************************************
Public:
(mode) do-deed
-->
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:tia="http://www.kadaster.nl/schemas/KIK/TIA_Algemeen" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:kef="nl.kadaster.xslt.XslExtensionFunctions" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:gc="http://docs.oasis-open.org/codelist/ns/genericode/1.0/" exclude-result-prefixes="tia xsl xlink kef gc" version="1.0">
	<xsl:include href="generiek-1.08.xsl"/>
	<xsl:include href="tekstblok_aanhef-1.20.xsl"/>
	<xsl:include href="tekstblok_burgerlijke_staat-2.0.xsl"/>
	<xsl:include href="tekstblok_equivalentieverklaring-1.30.xsl"/>
	<xsl:include href="tekstblok_gevolmachtigde-2.00.xsl"/>
	<xsl:include href="tekstblok_natuurlijk_persoon-2.0.xsl"/>
	<xsl:include href="tekstblok_partij_natuurlijk_persoon-2.0.xsl"/>
	<xsl:include href="tekstblok_partij_niet_natuurlijk_persoon-2.0.xsl"/>
	<xsl:include href="tekstblok_personalia_van_natuurlijk_persoon-1.06.xsl"/>
	<xsl:include href="tekstblok_recht-1.17.xsl"/>
	<xsl:include href="tekstblok_rechtspersoon-1.16.0.xsl"/>
	<xsl:include href="tekstblok_registergoed-1.30.xsl"/>
	<xsl:include href="tekstblok_titel_hypotheekakten-1.02.xsl"/>
	<xsl:include href="tekstblok_woonadres-1.05.xsl"/>
	<xsl:include href="tweededeel-1.05.xsl"/>
	<xsl:variable name="keuzeteksten" select="document('keuzeteksten_hypotheek_credo-2.0.0.xml')"/>
	<xsl:variable name="keuzetekstenTbBurgelijkeStaat" select="document('keuzeteksten-tb-burgerlijkestaat-2.0.xml')"/>
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

	Description: Credo Hypotheken mortgage deed.

	Input: tia:Bericht_TIA_Stuk

	Params: none

	Output: XHTML structure

	Calls:
	(mode) do-statement-of-equivalence
	(mode) do-header
	(mode) do-comparitie
	(mode) do-rights
	(mode) do-bridging-mortgage
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
		<p><xsl:text>De comparanten verklaarden als volgt:</xsl:text></p>
		<table cellspacing="0" cellpadding="0">
			<tbody>
				<tr>
					<td class="number" valign="top">
						<xsl:text>-</xsl:text>
					</td>
					<td>
						<xsl:text>Credo Hypotheken en de Schuldenaar zijn een leningsovereenkomst aangegaan, hierna te noemen: de "Leningsovereenkomst", van welke overeenkomst blijkt uit een door Credo Hypotheken uitgebracht en door de Schuldenaar geaccepteerd hypotheekaanbod. Een afschrift van het door Credo Hypotheken en Schuldenaar ondertekend hypotheekaanbod wordt aan deze akte gehecht.</xsl:text>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>-</xsl:text>
					</td>
					<td>
						<xsl:text>Blijkens de Leningsovereenkomst verstrekt Credo Hypotheken aan de Schuldenaar een geldlening voor het hierna te noemen bedrag en is de Schuldenaar verplicht aan Credo Hypotheken de in deze akte omschreven rechten van hypotheek en pand te (doen) verlenen op de wijze en onder de bepalingen en voorwaarden als uiteengezet in deze akte.</xsl:text>
					</td>
				</tr>
				<tr>
				<td class="number" valign="top">
					<xsl:text>-</xsl:text>
				</td>
				<td>
					<xsl:text>Partijen zijn derhalve het navolgende overeengekomen.</xsl:text>
				</td>
			</tr>
			</tbody>
		</table>
		<p>
			<u><xsl:text>LENING</xsl:text></u>
		</p>
		<p>
			<xsl:text>De Schuldenaar verklaarde wegens van Credo Hypotheken ter leen ontvangen gelden hoofdelijk schuldig te zijn aan Credo Hypotheken een bedrag van: </xsl:text>
			<xsl:call-template name="amountText">
				<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragLening/tia:som"/>
				<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragLening/tia:valuta"/>
			</xsl:call-template>
			<xsl:text> </xsl:text>
			<xsl:call-template name="amountNumber">
				<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragLening/tia:som"/>
				<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragLening/tia:valuta"/>
			</xsl:call-template>
			<xsl:text> (hierna te noemen: de ”Lening”).</xsl:text><br />
			<xsl:text>Credo Hypotheken verklaarde de hiervoor vermelde schuldbekentenis te aanvaarden.</xsl:text><br />
			<xsl:text>Tot zekerheid voor de betaling van de Schuld is de Schuldenaar met Credo Hypotheken overeengekomen en heeft zich jegens Credo Hypotheken verbonden en, voor zover nodig verklaart hierbij met Credo Hypotheken overeen te komen en zich te verbinden, tot het vestigen en tot het bij voorbaat vestigen van het recht van hypotheek casu quo recht van pand zoals hierna wordt omschreven, ten behoeve van Credo Hypotheken.</xsl:text>
		</p>
		<p>
			<u><xsl:text>Looptijd en aflossing</xsl:text></u>
		</p>
		<p>
			<xsl:text>De Lening heeft een looptijd zoals in de Leningsovereenkomst is overeengekomen, dan wel eventueel nader tussen partijen (zal worden) overeengekomen. De aflossing van de Lening vindt plaats op de wijze als bepaald in de aan deze akte gehechte Leningsovereenkomst, de algemene voorwaarden van geldlening en zekerheidsstelling van Credo Hypotheken (hierna te noemen: de "Algemene Voorwaarden") welke zijn gehecht aan de Leningsovereenkomst, en/of op een nader door partijen overeen te komen wijze.</xsl:text>
		</p>
		<p>
			<u><xsl:text>Rente</xsl:text></u>
		</p>
		<p>
			<xsl:text>De Schuldenaar is rente over de Lening tegen het overeengekomen rentepercentage verschuldigd. De voor het eerst te betalen rente wordt berekend vanaf de datum waarop Credo Hypotheken het bedrag van de Lening heeft overgeboekt naar de rekening van de notaris en/of naar de Bouwdepotrekening tot de laatste dag van de desbetreffende maand. Voor iedere volgende maand wordt de door de Schuldenaar te betalen rente berekend over het Uitstaande Bedrag per het einde van de daaraan voorafgaande maand.</xsl:text>
		</p>
		<p>
			<u><xsl:text>Algemene Voorwaarden</xsl:text></u>
		</p>
		<p>
			<xsl:text>Op de Leningsovereenkomst en op deze akte en de daarbij te verstrekken rechten van hypotheek en pand zijn van toepassing de Algemene Voorwaarden. De Algemene Voorwaarden worden geacht een onderdeel te zijn van de Leningsovereenkomst en deze akte als waren zij in de Leningsovereenkomst en deze akte woordelijk opgenomen. De Hypotheekgever verklaart een exemplaar van de Algemene Voorwaarden te hebben ontvangen, daarvan kennis te hebben genomen en daarmee in te stemmen.</xsl:text>
		</p>
		<p>
			<u><xsl:text>Begrippen</xsl:text></u>
		</p>
		<p>
			<xsl:text>Begrippen die in deze akte worden gebruikt, hebben de betekenis die daaraan is toegekend in de Algemene Voorwaarden, tenzij in deze akte anders is bepaald of uit de strekking van deze akte het tegendeel voortvloeit.</xsl:text><br />
			<xsl:text>Onder het begrip "Schuld" wordt in deze akte verstaan: de schulden en verplichtingen tot zekerheid voor de betaling waarvan de Schuldenaar blijkens deze akte aan Credo Hypotheken het recht van hypotheek op het in deze akte genoemde Onderpand verleent of behoort te verlenen.</xsl:text>
		</p>
		<xsl:if test="translate(tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_svnstarterslening']/tia:tekst, $upper, $lower) = 'true'">
		<p>
			<u><xsl:text>SVn Starterslening</xsl:text></u>
		</p>
		<p>
			<xsl:text>In verband met de door de Stichting Stimuleringsfonds Volkshuisvesting Nederlandse Gemeenten (SVn) te verstrekken Starterslening, heeft Credo Hypotheken zich jegens SVn en Stichting Waarborgfonds Eigen Woningen (WEW) verplicht, na het ingaan van de lening geen gelden meer onder verband van de eerste hypotheekstelling ter leen te verstrekken aan de Schuldenaar. Tevens heeft Credo Hypotheken zich jegens SVn en WEW verplicht reeds afgeloste bedragen op de lening, onder verband van de eerste hypotheekstelling, niet opnieuw te laten opnemen door de Schuldenaar. Voormelde verplichtingen rusten op Credo Hypotheken uitsluitend zolang de bij SVn aangegane Starterslening niet volledig is afgelost.</xsl:text>
		</p>
		</xsl:if>
		<p>
			<u><xsl:text>HYPOTHEEKSTELLING</xsl:text></u>
		</p>
		<p>
			<xsl:text>Tot zekerheid voor:</xsl:text>
		</p>
		<table cellspacing="0" cellpadding="0">
			<tbody>
				<tr>
					<td class="number" valign="top">
						<xsl:text>a.</xsl:text>
					</td>
					<td valign="top">
						<xsl:text>de terugbetaling van de hoofdsom van de lening </xsl:text>
						<xsl:call-template name="amountText">
							<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragLening/tia:som"/>
							<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragLening/tia:valuta"/>
						</xsl:call-template>
						<xsl:text> </xsl:text>
						<xsl:call-template name="amountNumber">
							<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragLening/tia:som"/>
							<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragLening/tia:valuta"/>
						</xsl:call-template>
						<xsl:text>, (daaronder begrepen de eventueel aan de Schuldenaar terugbetaalde aflossingsbedragen) en voorts de betaling van al hetgeen de Schuldenaar nu of op enig tijdstip in de toekomst al dan niet opeisbaar, voorwaardelijk of onder tijdsbepaling aan Credo Hypotheken verschuldigd is of zal worden uit hoofde van de Leningsovereenkomst, deze akte, de Algemene Voorwaarden, eerdere met betrekking tot het hierna te noemen Onderpand verstrekte geldleningen, dan wel uit welke hoofde dan ook, tot een bedrag van </xsl:text>
						<xsl:call-template name="amountText">
							<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:hoofdsom/tia:som"/>
							<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:hoofdsom/tia:valuta"/>
						</xsl:call-template>
						<xsl:text> </xsl:text>
						<xsl:call-template name="amountNumber">
							<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:hoofdsom/tia:som"/>
							<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:hoofdsom/tia:valuta"/>
						</xsl:call-template>
						<xsl:text>, en</xsl:text>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>b.</xsl:text>
					</td>
					<td valign="top">
						<xsl:text>de betaling van de rente (inclusief overeen te komen verhogingen), vertragingsrente, kosten, schadevergoedingen en/of andere vergoedingen nu of in de toekomst aan Credo Hypotheken verschuldigd uit hoofde van de Leningsovereenkomst en de betaling van al hetgeen Credo Hypotheken overigens uit hoofde van de Leningsovereenkomst, deze akte of de Algemene Voorwaarden van de Schuldenaar te vorderen mocht hebben, welke in deze paragraaf b bedoelde bedragen gezamenlijk worden begroot op een bedrag van </xsl:text>
						<xsl:call-template name="amountText">
							<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragRente/tia:som"/>
							<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragRente/tia:valuta"/>
						</xsl:call-template>
						<xsl:text> </xsl:text>
						<xsl:call-template name="amountNumber">
							<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragRente/tia:som"/>
							<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragRente/tia:valuta"/>
						</xsl:call-template>
						<xsl:text>, zijnde veertig procent (40%) van het laatst genoemde bedrag;</xsl:text>
					</td>
				</tr>
			</tbody>
		</table>
		<p>
		<xsl:text>derhalve tot een totaalbedrag ad </xsl:text>
		<xsl:call-template name="amountText">
			<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragTotaal/tia:som"/>
			<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragTotaal/tia:valuta"/>
		</xsl:call-template>
		<xsl:text> </xsl:text>
		<xsl:call-template name="amountNumber">
			<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragTotaal/tia:som"/>
			<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragTotaal/tia:valuta"/>
		</xsl:call-template>
		<xsl:text>, verleent de Hypotheekgever bij deze aan Credo Hypotheken die van de Hypotheekgever aanvaardt, het recht van </xsl:text>
		<xsl:value-of select="kef:convertOrdinalToText(tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:rangordeHypotheek)"/>
		<xsl:text> hypotheek op het hierna te omschrijven registergoed (hierna te noemen het “Onderpand”):</xsl:text>
		</p>
		<!-- Registered objects -->
		<a name="hyp3.rights" class="location">&#160;</a>
		<xsl:apply-templates select="." mode="do-rights">
			<xsl:with-param name="stukdeel" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']"/>
		</xsl:apply-templates>
		<p>
			<xsl:text>Hierna wordt onder Onderpand tevens verstaan ieder ander registergoed waarop hypothecaire zekerheid is gevestigd ten behoeve van Credo Hypotheken in verband met de Lening.</xsl:text><br />
			<xsl:text>De Hypotheekgever staat er voorts jegens Credo Hypotheken voor in:</xsl:text>
		</p>
		<table cellspacing="0" cellpadding="0">
			<tbody>
				<tr>
					<td class="number" valign="top">
						<xsl:text>a.</xsl:text>
					</td>
					<td valign="top">
						<xsl:text>dat het voormelde Onderpand hem in volle en onbezwaarde eigendom toebehoort, behoudens het (de) eventuele ten behoeve van Credo Hypotheken eerder gevestigde hypotheekrecht(en) ten laste van de Hypotheekgever, en dat hij daarover de onvoorwaardelijke beschikking heeft;</xsl:text>
					</td>
				</tr><tr>
				<td class="number" valign="top">
					<xsl:text>b.</xsl:text>
				</td>
				<td valign="top">
					<xsl:text>dat het voormelde Onderpand niet is belast met beslagen of met een recht van vruchtgebruik en niet is verhuurd noch anderszins in gebruik of genot is afgestaan aan derden; en</xsl:text>
				</td>
			</tr><tr>
				<td class="number" valign="top">
					<xsl:text>c.</xsl:text>
				</td>
				<td valign="top">
					<xsl:text>dat het voormelde Onderpand niet anders met recht van hypotheek is of kan worden bezwaard dan krachtens deze akte, behoudens het (de) eventuele ten behoeve van Credo Hypotheken eerder gevestigde hypotheekrecht(en) ten laste van de Hypotheekgever.</xsl:text>
				</td>
			</tr>
			</tbody>
		</table>
		<p><xsl:text>De Hypotheekgever en Credo Hypotheken komen hierbij overeen dat, indien Credo Hypotheken (een deel van) haar vordering(en) tot zekerheid waarvan onderhavig hypotheekrecht wordt gevestigd, overdraagt aan een derde, op deze derde tevens een met (het overgedragen deel van) deze vordering(en) evenredig deel van het hiervoor bedoelde hypotheekrecht als nevenrecht zal overgaan.</xsl:text></p>
		<!-- Overbrugginshypotheek -->
		<xsl:apply-templates select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[translate(tia:aanduidingHypotheek, $upper, $lower) = 'overbruggingshypotheek']" mode="do-overbruggingshypotheek"/>
		<xsl:if test="translate(tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_woonplaatskeuze']/tia:tekst, $upper, $lower) != ''">
			<p>
				<u>
					<xsl:text>Woonplaats</xsl:text>
				</u>
			</p>
			<p>
				<xsl:value-of select="normalize-space(tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_woonplaatskeuze']/tia:tekst[translate(normalize-space(.), $upper, $lower)])"/>
				<xsl:text>.</xsl:text>
			</p>
		</xsl:if>
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

	Description: Credo Hypotheken mortgage deed rights.

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
		<xsl:param name="stukdeel"/>
		<xsl:variable name="allProcessedRights" select="$stukdeel/tia:IMKAD_ZakelijkRecht"/>
		<xsl:choose>
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
					<xsl:text>.</xsl:text>
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
					<xsl:text>.</xsl:text>
				</p>
			</xsl:when>
			<xsl:otherwise>
				<table cellpadding="0" cellspacing="0">
					<tbody>
						<xsl:call-template name="processRights">
							<xsl:with-param name="positionOfProcessedRight" select="1"/>
							<xsl:with-param name="position" select="1"/>
							<xsl:with-param name="registeredObjects" select="$stukdeel"/>
							<xsl:with-param name="haveAdditionalText" select="'false'"/>
							<xsl:with-param name="endMark" select="'.'"/>
							<xsl:with-param name="colspan" select="2"/>
						</xsl:call-template>
					</tbody>
				</table>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-free-text
	*********************************************************
	Public: yes

	Identity transform: no

	Description: Credo Hypotheken mortgage deed free text part.

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

	Description: Credo Hypotheken mortgage deed parties.

	Input: tia:Partij

	Output: XHTML structure

	Calls:
	(mode) do-party-person

	Called by:
	(mode) do-deed
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:Partij" mode="do-comparitie">
		<xsl:variable name="currentParty" select="."/>
		<xsl:variable name="numberOfPersons" select="count(tia:IMKAD_Persoon[normalize-space(tia:tia_IndGerechtigde) = 'true']) + count(tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[normalize-space(tia:tia_IndGerechtigde) = 'true'])"/>
		<!-- tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon hoeft niet meegeteld te worden omdat er dan toch al meer dan 1 gerechtigde aanwezig is -->
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
				<!--
					TODO Code improvement.
					Restructure following CHOOSE structure, as it is no longer valid. It made sense when list structure was used.
					As table is used now, exactly the same code is called from 3 different branches (2 WHEN's and 1 OTHERWISE), needlessly.
					Therefore, FOR-EACH logic in OTHERWISE branch should be used instead of complete CHOOSE structure.
				-->
				<xsl:choose>
					<!-- If only one person pair, or legal person with warrantors is present - do not create list -->
					<xsl:when test="(tia:IMKAD_Persoon[(tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene) and tia:GerelateerdPersoon[tia:rol]]
						or $numberOfLegalPersonPairs > 0) and not(count(tia:IMKAD_Persoon) > 1) and position() =2 ">
						<xsl:apply-templates select="tia:IMKAD_Persoon" mode="do-party-person"/>
					</xsl:when>
					<xsl:when test="count(tia:IMKAD_Persoon) = 1 and position() = 2">
						<xsl:apply-templates select="tia:IMKAD_Persoon" mode="do-party-person"/>
					</xsl:when>
					<xsl:when test="position() =2">
						<xsl:for-each select="tia:IMKAD_Persoon">
							<xsl:apply-templates select="." mode="do-party-person"/>
						</xsl:for-each>
					</xsl:when>
				</xsl:choose>
				<xsl:if test="position() = 1">
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
				</xsl:if>
			</tbody>
		</table>
		<xsl:choose>
			<xsl:when test="position() = 1">
				<p style="margin-left:30px">
					<xsl:text>hierna te noemen: "Credo Hypotheken";</xsl:text>
				</p>
			</xsl:when>
			<xsl:when test="position() = 2">
				<p style="margin-left:30px">
					<xsl:text>hierna</xsl:text>
					<xsl:if test="$numberOfPersons > 1">
						<xsl:text>, zowel tezamen als ieder afzonderlijk,</xsl:text>
					</xsl:if>
					<xsl:text> te noemen: de "Hypotheekgever" en "Schuldenaar".</xsl:text>
				</p>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-party-person
	*********************************************************
	Public: no

	Identity transform: no

	Description: Credo mortgage deed party persons.

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
	<!--
	**** matching template ********************************************************************************
	**** Overbruggingshypotheek      ********************************************************************************
	-->
	<xsl:template match="tia:StukdeelHypotheek" mode="do-overbruggingshypotheek">
		<a name="hyp3.bridgingMortgage" class="location">&#160;</a>
		<p>
			<u>
				<xsl:text>Overbruggingshypotheek</xsl:text>
			</u>
		</p>
		<p>
			<xsl:text>Voorts verleent de Hypotheekgever tot zekerheid voor de betaling van de Schuld als hiervoor omschreven, bij deze aan Credo Hypotheken, die van de Hypotheekgever aanvaardt, het recht van </xsl:text>
			<xsl:value-of select="kef:convertOrdinalToText(tia:rangordeHypotheek)"/>
			<xsl:text> hypotheek op het hierna te omschrijven Onderpand:</xsl:text>
		</p>
		<xsl:choose>
			<xsl:when test="count(tia:IMKAD_ZakelijkRecht) = 1">
				<p>
					<xsl:variable name="rightText">
						<xsl:apply-templates select="tia:IMKAD_ZakelijkRecht" mode="do-right"/>
					</xsl:variable>
					<xsl:if test="normalize-space($rightText) != ''">
						<xsl:value-of select="$rightText"/>
						<xsl:text> </xsl:text>
					</xsl:if>
					<xsl:apply-templates select="tia:IMKAD_ZakelijkRecht" mode="do-registered-object"/>
					<xsl:text>.</xsl:text>
				</p>
			</xsl:when>
			<!-- Multiple registered objects, all parcels with same data -->
			<xsl:when test="count(tia:IMKAD_ZakelijkRecht)
							= count(tia:IMKAD_ZakelijkRecht[
								((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen']/tia:tekst
										= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen']/tia:tekst)
									or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen'])
										and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen'])))
								and tia:aardVerkregen = current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:aardVerkregen
								and normalize-space(tia:aardVerkregen) != ''
								and ((tia:tia_Aantal_BP_Rechten
										= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_Aantal_BP_Rechten)
									or (not(tia:tia_Aantal_BP_Rechten)
										and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_Aantal_BP_Rechten)))
								and ((tia:tia_Aantal_Rechten
										= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_Aantal_Rechten)
									or (not(tia:tia_Aantal_Rechten)
										and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_Aantal_Rechten)))
								and ((tia:tia_Aantal_RechtenVariant
										= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_Aantal_RechtenVariant)
									or (not(tia:tia_Aantal_RechtenVariant)
										and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_Aantal_RechtenVariant)))
								and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven']/tia:tekst
										= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven']/tia:tekst)
									or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven'])
										and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven'])))
								and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom']/tia:tekst
										= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom']/tia:tekst)
									or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom'])
										and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom'])))
								and ((tia:aandeelInRecht/tia:teller	= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:aandeelInRecht/tia:teller 
									and tia:aandeelInRecht/tia:noemer = current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:aandeelInRecht/tia:noemer)
									or (not(tia:aandeelInRecht)
										and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:aandeelInRecht)))
								and tia:IMKAD_Perceel[
									tia:tia_OmschrijvingEigendom
										= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_OmschrijvingEigendom
									and normalize-space(tia:tia_OmschrijvingEigendom) != ''
									and ((tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid']/tia:tekst
											= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid']/tia:tekst)
										or (not(tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid'])
											and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid'])))
									and ((tia:tia_SplitsingsverzoekOrdernummer
											= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_SplitsingsverzoekOrdernummer)
										or (not(tia:tia_SplitsingsverzoekOrdernummer)
											and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_SplitsingsverzoekOrdernummer)))
									and tia:kadastraleAanduiding/tia:gemeente
										= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:kadastraleAanduiding/tia:gemeente
									and normalize-space(tia:kadastraleAanduiding/tia:gemeente) != ''
									and tia:kadastraleAanduiding/tia:sectie
										= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:kadastraleAanduiding/tia:sectie
									and normalize-space(tia:kadastraleAanduiding/tia:sectie) != ''
									and tia:IMKAD_OZLocatie/tia:ligging
										= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:ligging
									and normalize-space(tia:IMKAD_OZLocatie/tia:ligging) != ''
									and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer
										= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer)
										or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer)
											and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer)))
									and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter
											= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter)
										or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter)
											and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter)))
									and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging
											= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging)
										or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging)
											and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging)))
									and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode
											= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode)
										or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode)
											and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode)))
									and tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam
										= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam
									and normalize-space(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam) != ''
									and tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam
										= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam
									and normalize-space(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam) != '']]) and $RegistergoedTonenPerPerceel='false'">
				<p>
					<xsl:variable name="rightText">
						<xsl:apply-templates select="tia:IMKAD_ZakelijkRecht[1]" mode="do-right"/>
					</xsl:variable>
					<xsl:if test="normalize-space($rightText) != ''">
						<xsl:value-of select="$rightText"/>
						<xsl:text> </xsl:text>
					</xsl:if>
					<xsl:apply-templates select="tia:IMKAD_ZakelijkRecht[1]" mode="do-registered-object"/>
					<xsl:text>.</xsl:text>
				</p>
			</xsl:when>
			<xsl:otherwise>
				<table cellpadding="0" cellspacing="0">
					<tbody>
						<xsl:call-template name="processRights">
							<xsl:with-param name="positionOfProcessedRight" select="1"/>
							<xsl:with-param name="position" select="1"/>
							<xsl:with-param name="registeredObjects" select="."/>
							<xsl:with-param name="colspan" select="2"/>
						</xsl:call-template>
					</tbody>
				</table>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
