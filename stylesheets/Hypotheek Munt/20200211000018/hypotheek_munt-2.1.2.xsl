<?xml version="1.0" encoding="UTF-8"?>
<!--
*************************************************************
Stylesheet: hypotheek_munt.xsl
Version: 2.1.2 
AA-4731 - WordML probleem opgelost
*************************************************************

Description:
Munt hypotheek.

Public:
(mode) do-deed
-->
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:tia="http://www.kadaster.nl/schemas/KIK/TIA_Algemeen" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:kef="nl.kadaster.xslt.XslExtensionFunctions" xmlns:exslt="http://exslt.org/common" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:gc="http://docs.oasis-open.org/codelist/ns/genericode/1.0/" exclude-result-prefixes="tia xsl xlink kef gc" version="1.0">
	<xsl:include href="generiek-1.08.xsl"/>
	<xsl:include href="tekstblok_aanhef-1.20.xsl"/>
	<xsl:include href="tekstblok_burgerlijke_staat-1.03.xsl"/>
	<xsl:include href="tekstblok_equivalentieverklaring-1.28.xsl"/>
	<xsl:include href="tekstblok_gevolmachtigde-1.26.xsl"/>
	<xsl:include href="tekstblok_legitimatie-2.00.xsl"/>
	<xsl:include href="tekstblok_natuurlijk_persoon-1.13.xsl"/>
	<xsl:include href="tekstblok_partij_natuurlijk_persoon-1.39.xsl"/>
	<xsl:include href="tekstblok_partij_niet_natuurlijk_persoon-1.53.xsl"/>
	<xsl:include href="tekstblok_personalia_van_natuurlijk_persoon-1.06.xsl"/>
	<xsl:include href="tekstblok_recht-1.17.xsl"/>
	<xsl:include href="tekstblok_rechtspersoon-1.15.0.xsl"/>
	<xsl:include href="tekstblok_registergoed-1.29.xsl"/>
	<xsl:include href="tekstblok_titel_hypotheekakten-1.01.xsl"/>
	<xsl:include href="tekstblok_woonadres-1.05.xsl"/>
	<xsl:include href="tweededeel-1.05.xsl"/>
	<xsl:variable name="keuzeteksten" select="document('keuzeteksten_hypotheek_munt-1.2.0.xml')"/>
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

	Description: munt mortgage deed.

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
		<p>
			<xsl:text>De comparanten verklaarden als volgt:</xsl:text>
		</p>
		<table cellspacing="0" cellpadding="0">
			<tbody>
				<tr>
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<td class="number" valign="top">
						<xsl:text>-</xsl:text>
					</td>
					<td>MUNT Hypotheken en de Schuldenaar zijn een leningsovereenkomst aangegaan,  hierna te noemen: de "Leningsovereenkomst", van welke overeenkomst blijkt uit een door MUNT Hypotheken uitgebracht en door de Schuldenaar geaccepteerd hypotheekaanbod. Een afschrift van het door MUNT Hypotheken en Schuldenaar ondertekende hypotheekaanbod wordt aan deze akte gehecht. </td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<td class="number" valign="top">
						<xsl:text>-</xsl:text>
					</td>
					<td>Blijkens de Leningsovereenkomst verstrekt MUNT Hypotheken aan de Schuldenaar een geldlening voor het hierna te noemen bedrag en is de Schuldenaar verplicht aan MUNT Hypotheken de in deze akte omschreven rechten van hypotheek en pand te (doen) verlenen op de wijze en onder de bepalingen en voorwaarden als uiteengezet in deze akte. </td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<td class="number" valign="top">
						<xsl:text>-</xsl:text>
					</td>
					<td>Partijen zijn derhalve het navolgende overeengekomen.</td>
				</tr>
			</tbody>
		</table>
		<p>
			<xsl:text>A. LENING</xsl:text>
		</p>
		<p>
			<xsl:text>De Schuldenaar verklaarde wegens van MUNT Hypotheken ter leen ontvangen gelden hoofdelijk schuldig te zijn aan MUNT Hypotheken een bedrag van: </xsl:text>
			<xsl:call-template name="amountText">
				<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragLening/tia:som"/>
				<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragLening/tia:valuta"/>
			</xsl:call-template>
			<xsl:text> </xsl:text>
			<xsl:call-template name="amountNumber">
				<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragLening/tia:som"/>
				<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragLening/tia:valuta"/>
			</xsl:call-template>
			<xsl:text> (hierna te noemen: de "Lening").</xsl:text>
		</p>
		<p>
			<xsl:text>MUNT Hypotheken verklaarde de hiervoor vermelde schuldbekentenis te aanvaarden. 
Tot zekerheid voor de betaling van de Schuld is de Schuldenaar met MUNT Hypotheken overeengekomen en heeft zich jegens MUNT Hypotheken verbonden en, voor zover nodig verklaart hierbij met MUNT Hypotheken overeen te komen en zich te verbinden, tot het vestigen en tot het bij voorbaat vestigen van het recht van hypotheek en recht van pand zoals hierna wordt omschreven, ten behoeve van MUNT Hypotheken.
</xsl:text>
		</p>
		<p>
			<u>
				<xsl:text>Looptijd en aflossing</xsl:text>
			</u>
		</p>
		<p>
			<xsl:text>De Lening heeft een looptijd zoals in de Leningsovereenkomst is overeengekomen, dan wel eventueel nader tussen partijen (zal worden) overeengekomen. De aflossing van de Lening vindt plaats op de wijze als bepaald in de aan deze akte gehechte Leningsovereenkomst, de algemene voorwaarden van geldlening en zekerheidsstelling van MUNT Hypotheken (hierna te noemen: de "Algemene Voorwaarden") welke zijn gehecht aan de Leningsovereenkomst, en / of op een nader door partijen overeen te komen wijze.
			</xsl:text>
		</p>
		<p>
			<u>
				<xsl:text>Rente</xsl:text>
			</u>
		</p>
		<p>
			<xsl:text>De Schuldenaar is rente over de Lening tegen het overeengekomen rentepercentage verschuldigd. De voor het eerst te betalen rente wordt berekend vanaf de datum waarop MUNT Hypotheken het bedrag van de Lening heeft overgeboekt naar de rekening van de notaris en / of naar de Bouwdepotrekening tot de laatste dag van de desbetreffende maand. Voor iedere volgende maand wordt de door de Schuldenaar te betalen rente berekend over het Uitstaande Bedrag per het einde van de daaraan voorafgaande maand.
			</xsl:text>
		</p>
		<p>
			<u>
				<xsl:text>Algemene Voorwaarden</xsl:text>
			</u>
		</p>
		<p>
			<xsl:text>Op de Leningsovereenkomst en op deze akte en de daarbij te verstrekken rechten van hypotheek en pand zijn van toepassing de Algemene Voorwaarden. De Algemene Voorwaarden worden geacht een onderdeel te zijn van de Leningsovereenkomst en deze akte als waren zij in de Leningsovereenkomst en deze akte woordelijk opgenomen. De Hypotheekgever verklaart een exemplaar van de Algemene Voorwaarden te hebben ontvangen, daarvan kennis te hebben genomen en daarmee in te stemmen. 
			</xsl:text>
		</p>
		<p>
			<u>
				<xsl:text>Begrippen</xsl:text>
			</u>
		</p>
		<p>
			<xsl:text>Begrippen die in deze akte worden gebruikt, hebben de betekenis die daaraan is toegekend in de Algemene Voorwaarden, tenzij in deze akte anders is bepaald of uit de strekking van deze akte het tegendeel voortvloeit.</xsl:text>
			<br/>
			<xsl:text>Onder het begrip "Schuld" wordt in deze akte verstaan: de schulden en verplichtingen tot zekerheid voor de betaling waarvan de Schuldenaar blijkens deze akte aan MUNT Hypotheken het recht van hypotheek op het in deze akte genoemde Onderpand verleent of behoort te verlenen.
			</xsl:text>
		</p>
		<xsl:if test="translate(tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_svnstarterslening']/tia:tekst, $upper, $lower) = 'true'">
			<p>
				<u>
					<xsl:text>SVn Starterslening</xsl:text>
				</u>
			</p>
			<p>
				<xsl:text>In verband met de door de Stichting Stimuleringsfonds Volkshuisvesting Nederlandse Gemeenten (SVn) te verstrekken Starterslening, heeft MUNT Hypotheken zich jegens SVn en Stichting Waarborgfonds Eigen Woningen (WEW) verplicht, na het ingaan van de lening geen gelden meer onder verband van de eerste hypotheekstelling ter leen te verstrekken aan de Schuldenaar. Tevens heeft MUNT Hypotheken zich jegens SVn en WEW verplicht reeds afgeloste bedragen op de lening, onder verband van de eerste hypotheekstelling, niet opnieuw te laten opnemen door de Schuldenaar. Voormelde verplichtingen rusten op MUNT Hypotheken uitsluitend zolang de bij SVn aangegane Starterslening niet volledig is afgelost.
</xsl:text>
			</p>
		</xsl:if>
		<p>
			<xsl:text>B. HYPOTHEEKRECHT</xsl:text>
		</p>
		<p>
			<u>
				<xsl:text>Hypotheekstelling</xsl:text>
			</u>
		</p>
		<p>
			<xsl:text>Tot zekerheid voor:</xsl:text>
		</p>
		<table cellspacing="0" cellpadding="0">
			<tbody>
				<tr>
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<td class="number" valign="top">
						<xsl:text>a.</xsl:text>
					</td>
					<td valign="top">
						<xsl:text>de terugbetaling van de hoofdsom van de Lening </xsl:text>
						<xsl:call-template name="amountText">
							<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragLening/tia:som"/>
							<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragLening/tia:valuta"/>
						</xsl:call-template>
						<xsl:text> </xsl:text>
						<xsl:call-template name="amountNumber">
							<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragLening/tia:som"/>
							<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragLening/tia:valuta"/>
						</xsl:call-template>
						<xsl:text>, (daaronder begrepen de eventueel aan de Schuldenaar terugbetaalde aflossingsbedragen) en voorts de betaling van al hetgeen de Schuldenaar nu of op enig tijdstip in de toekomst al dan niet opeisbaar, voorwaardelijk of onder tijdsbepaling aan MUNT Hypotheken verschuldigd is of zal worden uit hoofde van de Leningsovereenkomst, deze akte, de Algemene Voorwaarden, eerdere met betrekking tot het hierna te noemen Onderpand verstrekte geldleningen, dan wel uit welke hoofde dan ook, tot een bedrag van </xsl:text>
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
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<td class="number" valign="top">
						<xsl:text>b.</xsl:text>
					</td>
					<td valign="top">
						<xsl:text>de betaling van de rente (inclusief overeen te komen verhogingen), vertragingsrente, kosten, schadevergoedingen en/of andere vergoedingen nu of in de toekomst aan MUNT Hypotheken verschuldigd  uit hoofde van de Leningsovereenkomst en de betaling van al hetgeen MUNT Hypotheken overigens uit hoofde van de Leningsovereenkomst, deze akte of de Algemene Voorwaarden van de Schuldenaar te vorderen mocht hebben, welke in deze paragraaf b bedoelde bedragen gezamenlijk worden begroot op een bedrag van  </xsl:text>
						<xsl:call-template name="amountText">
							<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragRente/tia:som"/>
							<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragRente/tia:valuta"/>
						</xsl:call-template>
						<xsl:text> </xsl:text>
						<xsl:call-template name="amountNumber">
							<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragRente/tia:som"/>
							<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragRente/tia:valuta"/>
						</xsl:call-template>
						<xsl:text>, zijnde veertig procent (40%) van het laatst  genoemde bedrag;</xsl:text>
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
			<xsl:text>, verleent de Hypotheekgever bij deze aan MUNT Hypotheken die van de Hypotheekgever aanvaardt, het recht van </xsl:text>
			<xsl:value-of select="kef:convertOrdinalToText(tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:rangordeHypotheek)"/>
			<xsl:text> hypotheek op het hierna te omschrijven registergoed (hierna te noemen het "Onderpand"): </xsl:text>
		</p>
		<!-- Registered objects -->
		<a name="hyp3.rights" class="location">&#160;</a>
		<xsl:apply-templates select="." mode="do-rights">
			<xsl:with-param name="stukdeel" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']"/>
		</xsl:apply-templates>
		<p>
			<xsl:text>Hierna wordt onder Onderpand tevens verstaan ieder ander registergoed waarop hypothecaire zekerheid is gevestigd ten behoeve van MUNT Hypotheken in verband met de Lening.</xsl:text>
			<br/>
			<xsl:text>De Hypotheekgever staat er voorts jegens MUNT Hypotheken voor in:</xsl:text>
		</p>
		<table cellspacing="0" cellpadding="0">
			<tbody>
				<tr>
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<td class="number" valign="top">
						<xsl:text>a.</xsl:text>
					</td>
					<td valign="top">
						<xsl:text>dat het voormelde Onderpand hem in volle en onbezwaarde eigendom toebehoort, behoudens het (de) eventuele ten behoeve van MUNT Hypotheken eerder gevestigde hypotheekrecht(en) ten laste van de Hypotheekgever, en dat hij daarover de onvoorwaardelijke beschikking heeft; </xsl:text>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<td class="number" valign="top">
						<xsl:text>b.</xsl:text>
					</td>
					<td valign="top">
						<xsl:text>dat het voormelde Onderpand niet is belast met beslagen of met een recht van vruchtgebruik en niet is verhuurd noch anderszins in gebruik of genot is afgestaan aan derden; en </xsl:text>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<td class="number" valign="top">
						<xsl:text>c.</xsl:text>
					</td>
					<td valign="top">
						<xsl:text>dat het voormelde Onderpand niet anders met recht van hypotheek is of met een tweede recht van hypotheek zal worden bezwaard dan krachtens deze akte, behoudens het (de) eventuele ten behoeve van MUNT Hypotheken eerder gevestigde hypotheekrecht(en) ten laste van de Hypotheekgever.</xsl:text>
					</td>
				</tr>
			</tbody>
		</table>
		<p>
			<xsl:text>De Hypotheekgever en MUNT Hypotheken komen hierbij overeen dat, voor zover dit al niet van rechtswege geschiedt en voor zover derhalve rechtens vereist, MUNT Hypotheken bij overdracht aan een derde van (een deel van) haar vordering(en), tot zekerheid waarvan onderhavig hypotheekrecht wordt gevestigd, op deze derde tevens (een met het overgedragen deel van deze vordering(en) evenredig deel van) het hiervoor bedoelde hypotheekrecht als nevenrecht zal overgaan.</xsl:text>
		</p>
		<!-- Overbrugginshypotheek -->
		<xsl:apply-templates select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[translate(tia:aanduidingHypotheek, $upper, $lower) = 'overbruggingshypotheek']" mode="do-overbruggingshypotheek"/>
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

	Description: blg mortgage deed rights.

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

	Description: blg mortgage deed election of domicile.

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
		<xsl:variable name="woonplaatskeuze" select="tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_woonplaatskeuze']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
				translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_woonplaatskeuze']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
				translate(normalize-space(current()/tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_woonplaatskeuze']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
		<!-- Election of domicile -->
		<a name="hyp3.electionOfDomicile" class="location">&#160;</a>
		<xsl:if test="$woonplaatskeuze != ''">
			<p>
				<u>
					<xsl:text>Woonplaats</xsl:text>
				</u>
			</p>
			<p>
				<xsl:value-of select="$woonplaatskeuze"/>
				<xsl:text>.</xsl:text>
			</p>
		</xsl:if>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-free-text
	*********************************************************
	Public: yes

	Identity transform: no

	Description: blg mortgage deed free text part.

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

	Description: blg mortgage deed parties.

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
		<p style="margin-left:30px">
			<xsl:choose>
				<xsl:when test="position() = 1">
					<xsl:text>hierna te noemen "MUNT hypotheken";</xsl:text>
				</xsl:when>
				<xsl:when test="position() = 2">
					<xsl:apply-templates select="." mode="do-keuzeblok-partijnamen-hypotheekakte">
						<xsl:with-param name="partyNumber" select="'2'"/>
					</xsl:apply-templates>
					<xsl:text>.</xsl:text>
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

	Description: blg mortgage deed party persons.

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
			<xsl:text>Voorts verleent de Hypotheekgever tot zekerheid voor de betaling van de Schuld als hiervoor omschreven, bij deze aan MUNT Hypotheken, die van de Hypotheekgever aanvaardt, het recht van </xsl:text>
			<xsl:value-of select="kef:convertOrdinalToText(tia:rangordeHypotheek)"/>
			<xsl:text> hypotheek op het hierna te omschrijven Onderpand:  </xsl:text>
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
						</xsl:call-template>
					</tbody>
				</table>
			</xsl:otherwise>
		</xsl:choose>
		<p><xsl:text>De Hypotheekgever staat er voorts jegens MUNT Hypotheken voor in:</xsl:text></p>
		<table cellspacing="0" cellpadding="0">
			<tbody>
				<tr>
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<td class="number" valign="top">
						<xsl:text>a.</xsl:text>
					</td>
					<td valign="top">
						<xsl:text>dat het voormelde Onderpand hem in volle en onbezwaarde eigendom toebehoort, behoudens het (de) eventuele ten behoeve van MUNT Hypotheken eerder gevestigde hypotheekrecht(en) ten laste van de Hypotheekgever, en dat hij daarover de onvoorwaardelijke beschikking heeft;</xsl:text>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<td class="number" valign="top">
						<xsl:text>b.</xsl:text>
					</td>
					<td valign="top">
						<xsl:text>dat het voormelde Onderpand niet is belast met beslagen of met een recht van vruchtgebruik en niet is verhuurd noch anderszins in gebruik of genot is afgestaan aan derden; en</xsl:text>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<td class="number" valign="top">
						<xsl:text>c.</xsl:text>
					</td>
					<td valign="top">
						<xsl:text>dat het voormelde Onderpand niet anders met recht van hypotheek is of met een tweede recht van hypotheek zal worden bezwaard dan krachtens deze akte, behoudens het (de) eventuele ten behoeve van MUNT Hypotheken eerder gevestigde hypotheekrecht(en) ten laste van de Hypotheekgever.</xsl:text>
					</td>
				</tr>
				<tr>
					<td colspan="3">
						<xsl:text>De Hypotheekgever en MUNT Hypotheken komen hierbij overeen dat, voor zover dit al niet van rechtswege geschiedt en voor zover derhalve rechtens vereist, MUNT Hypotheken bij overdracht aan een derde van (een deel van) haar vordering(en), tot zekerheid waarvan onderhavig overbruggingshypotheekrecht wordt gevestigd, op deze derde tevens (een met het overgedragen deel van deze vordering(en) evenredig deel van) het hiervoor bedoelde hypotheekrecht als nevenrecht zal overgaan.</xsl:text>
					</td>
				</tr>
			</tbody>
		</table>
	</xsl:template>
	<xsl:template match="tia:Partij" mode="do-keuzeblok-partijnamen-hypotheekakte">
		<xsl:param name="partyNumber" select="number('1')"/>
		<xsl:variable name="currentPartij" select="."/>
		<xsl:variable name="debtor" select="'hypotheekgever'"/>
		<xsl:variable name="mortgager" select="'schuldenaar'"/>
		<xsl:variable name="both" select="'beiden'"/>
		<xsl:variable name="_debtorPersons">
			<tia:groups>
				<xsl:apply-templates select="." mode="do-person-numbering">
					<xsl:with-param name="partyNumber" select="$partyNumber"/>
					<xsl:with-param name="debtorPersonsProcessed" select="'true'"/>
					<xsl:with-param name="mortgagerPersonsProcessed" select="'false'"/>
				</xsl:apply-templates>
			</tia:groups>
		</xsl:variable>
		<xsl:variable name="debtorPersons" select="exslt:node-set($_debtorPersons)"/>
		<xsl:variable name="_mortgagerPersons">
			<tia:groups>
				<xsl:apply-templates select="." mode="do-person-numbering">
					<xsl:with-param name="partyNumber" select="$partyNumber"/>
					<xsl:with-param name="debtorPersonsProcessed" select="'false'"/>
					<xsl:with-param name="mortgagerPersonsProcessed" select="'true'"/>
				</xsl:apply-templates>
			</tia:groups>
		</xsl:variable>
		<xsl:variable name="mortgagerPersons" select="exslt:node-set($_mortgagerPersons)"/>
		<!-- Verplichte keuze uit de volgende 2 opties -->
		<xsl:choose>
			<!-- Optie 1: Geldnemer of Hypotheekgever' -->
			<xsl:when test="translate(tia:aanduidingPartij, $upper, $lower) = 'hypotheekgever en schuldenaar'">
				<xsl:text>hierna </xsl:text>
				<xsl:if test="(count(tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true']) 
						+ count(tia:IMKAD_Persoon/tia:GerelateerdPersoon[translate(tia:IMKAD_Persoon/tia:tia_IndGerechtigde, $upper, $lower) = 'true'])
						+ count(tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon[translate(tia:IMKAD_Persoon/tia:tia_IndGerechtigde, $upper, $lower) = 'true'])) > 1">
					<xsl:text>zowel tezamen als ieder afzonderlijk </xsl:text>
				</xsl:if>
				<xsl:text>te noemen: de 'Hypotheekgever' en 'Schuldenaar'</xsl:text>
			</xsl:when>
			<!-- Optie 2: Aanduiding per persoon -->
			<xsl:when test="translate(tia:aanduidingPartij, $upper, $lower) = 'aanduiding per persoon'">
				<!-- gebruikte variabelen -->
				<xsl:variable name="numberOfPersonPairs" select="count(tia:IMKAD_Persoon/tia:GerelateerdPersoon[tia:rol and tia:rol != 'bestuurder'])"/>
				<xsl:variable name="numberOfDebtorPersons" select="count(tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true' and translate(tia:tia_PartijOnderdeel, $upper, $lower) = translate($debtor, $upper, $lower) or translate(tia:tia_PartijOnderdeel, $upper, $lower) = translate($both, $upper, $lower)])
						+ count(tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true' and translate(tia:tia_PartijOnderdeel, $upper, $lower) = translate($debtor, $upper, $lower) or translate(tia:tia_PartijOnderdeel, $upper, $lower) = translate($both, $upper, $lower)])
						+ count(tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true' and translate(tia:tia_PartijOnderdeel, $upper, $lower) = translate($debtor, $upper, $lower) or translate(tia:tia_PartijOnderdeel, $upper, $lower) = translate($both, $upper, $lower)])"/>
				<xsl:variable name="numberOfMortgagerPersons" select="count(tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true' and translate(tia:tia_PartijOnderdeel, $upper, $lower) = translate($mortgager, $upper, $lower) or translate(tia:tia_PartijOnderdeel, $upper, $lower) = translate($both, $upper, $lower)])
						+ count(tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true' and translate(tia:tia_PartijOnderdeel, $upper, $lower) = translate($mortgager, $upper, $lower) or translate(tia:tia_PartijOnderdeel, $upper, $lower) = translate($both, $upper, $lower)])
						+ count(tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true' and translate(tia:tia_PartijOnderdeel, $upper, $lower) = translate($mortgager, $upper, $lower) or translate(tia:tia_PartijOnderdeel, $upper, $lower) = translate($both, $upper, $lower)])"/>
				<xsl:variable name="voornoemdHypotheekgever" select="tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hypotheekgevervoornoemd']"/>
				<xsl:variable name="voornoemdSchuldenaar" select="tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_schuldenaarvoornoemd']"/>
				<xsl:variable name="verwijzingPersoon" select="tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verwijzingpersoon']"/>
				<xsl:variable name="number" select="translate(normalize-space($verwijzingPersoon/tia:tekst), $upper, $lower) = 'nummer'"/>
				<xsl:variable name="name" select="translate(normalize-space($verwijzingPersoon/tia:tekst), $upper, $lower) = 'naam'"/>
				<xsl:variable name="existGevolmachtigde" select="(count(tia:Hoedanigheid[concat('#',@id) = $currentPartij/tia:Gevolmachtigde/tia:vertegenwoordigtRef/@xlink:href]) + count($currentPartij/descendant::tia:IMKAD_Persoon/tia:vertegenwoordigtRef) + count(tia:vertegenwoordigtRef)) > 0"/>
				<xsl:if test="(not($existGevolmachtigde) and $number) or $name">
					<!-- 2.5.2.1.1	Aanduiding persoon met nummer -->
					<xsl:if test="$number">
						<xsl:text>de verschenen </xsl:text>
						<xsl:choose>
							<xsl:when test="$numberOfDebtorPersons > 1">
								<xsl:text>personen </xsl:text>
							</xsl:when>
							<xsl:otherwise>
								<xsl:text>persoon </xsl:text>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:text>sub </xsl:text>
					</xsl:if>
					<!-- 2.5.2.1.2	Aanduiding persoon met naam -->
					<xsl:for-each select="$debtorPersons/tia:groups/tia:group">
						<xsl:value-of select="."/>
						<xsl:choose>
							<xsl:when test="position() = last() - 1">
								<xsl:text> en </xsl:text>
							</xsl:when>
							<xsl:when test="position() != last()">
								<xsl:text>, </xsl:text>
							</xsl:when>
						</xsl:choose>
					</xsl:for-each>
					<xsl:if test="$name and translate(normalize-space($voornoemdSchuldenaar/tia:tekst), $upper, $lower) = 'voornoemd'">
						<xsl:text> voornoemd,</xsl:text>
					</xsl:if>
					<xsl:text> hierna </xsl:text>
					<xsl:if test="$numberOfDebtorPersons > 1">
						<xsl:text>zowel tezamen als ieder afzonderlijk </xsl:text>
					</xsl:if>
					<xsl:text>te noemen: de 'Hypotheekgever' en </xsl:text>
					<xsl:if test="$number">
						<xsl:text>de verschenen </xsl:text>
						<xsl:choose>
							<xsl:when test="$numberOfMortgagerPersons > 1">
								<xsl:text>personen </xsl:text>
							</xsl:when>
							<xsl:otherwise>
								<xsl:text>persoon </xsl:text>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:text>sub </xsl:text>
					</xsl:if>
					<xsl:for-each select="$mortgagerPersons/tia:groups/tia:group">
						<xsl:value-of select="."/>
						<xsl:choose>
							<xsl:when test="position() = last() - 1">
								<xsl:text> en </xsl:text>
							</xsl:when>
							<xsl:when test="position() != last()">
								<xsl:text>, </xsl:text>
							</xsl:when>
						</xsl:choose>
					</xsl:for-each>
					<xsl:if test="$name and translate(normalize-space($voornoemdHypotheekgever/tia:tekst), $upper, $lower) = 'voornoemd'">
						<xsl:text> voornoemd,</xsl:text>
					</xsl:if>
					<xsl:text> hierna </xsl:text>
					<xsl:if test="$numberOfMortgagerPersons > 1">
						<xsl:text>zowel tezamen als ieder afzonderlijk </xsl:text>
					</xsl:if>
					<xsl:text>te noemen: de 'Schuldenaar'</xsl:text>
				</xsl:if>
			</xsl:when>
			<!-- Alle andere gevallen -->
			<xsl:otherwise>
				<xsl:text>KEUZEBLOK PARTIJNAMEN HYPOTHEEKAKTE</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-person-numbering
	*********************************************************
	Public: yes

	Identity transform: no

	Description: Numbering of person within party.

	Input: tia:IMKAD_Persoon

	Params: partyNumber - number of the party
	        debtorPersonsProcessed - indicator if debtor persons are processed
	        mortgagerPersonsProcessed - indicator if mortager persons are processed
	        allPersonsProcessed - indicator if all persons are processed, regardless of the presence of tia:tia_PartijOnderdeel and it's value 

	Output: Tree fragment:
			<tia:groups>
				<tia:group>
					person name
				</tia:group>
				...
			</tia:groups>

	Calls:
	(mode) do-person-name

	Called by:
	(mode) do-keuzeblok-partijnamen-hypotheekakte
	(mode) do-deed
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:Partij" mode="do-person-numbering">
		<xsl:param name="partyNumber"/>
		<xsl:param name="debtorPersonsProcessed" select="'false'"/>
		<xsl:param name="mortgagerPersonsProcessed" select="'false'"/>
		<xsl:param name="allPersonsProcessed" select="'false'"/>
		<xsl:variable name="currentParty" select="."/>
		<xsl:variable name="debtor" select="'hypotheekgever'"/>
		<xsl:variable name="mortgager" select="'schuldenaar'"/>
		<xsl:variable name="both" select="'beiden'"/>
		<xsl:variable name="verwijzingPersoon" select="tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verwijzingpersoon']"/>
		<xsl:variable name="number" select="translate(normalize-space($verwijzingPersoon/tia:tekst), $upper, $lower) = 'nummer'"/>
		<xsl:variable name="name" select="translate(normalize-space($verwijzingPersoon/tia:tekst), $upper, $lower) = 'naam'"/>
		<xsl:variable name="onlyPersonInParty">
			<xsl:choose>
				<xsl:when test="count($currentParty/tia:IMKAD_Persoon) = 1">
					<xsl:text>true</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>false</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:for-each select="tia:IMKAD_Persoon">
			<xsl:variable name="personIsMortgager">
				<xsl:choose>
					<xsl:when test="translate(tia:tia_PartijOnderdeel, $upper, $lower) = translate($mortgager, $upper, $lower) or translate(tia:tia_PartijOnderdeel, $upper, $lower) = translate($both, $upper, $lower)">
						<xsl:text>true</xsl:text>
					</xsl:when>
					<xsl:when test="$allPersonsProcessed = 'true'">
						<xsl:text>true</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>false</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="personIsDebtor">
				<xsl:choose>
					<xsl:when test="translate(tia:tia_PartijOnderdeel, $upper, $lower) = translate($debtor, $upper, $lower) or translate(tia:tia_PartijOnderdeel, $upper, $lower) = translate($both, $upper, $lower)">
						<xsl:text>true</xsl:text>
					</xsl:when>
					<xsl:when test="$allPersonsProcessed = 'true'">
						<xsl:text>true</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>false</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="personIsBothDebtorAndMortgager">
				<xsl:choose>
					<xsl:when test="translate(tia:tia_PartijOnderdeel, $upper, $lower) = translate($both, $upper, $lower)">
						<xsl:text>true</xsl:text>
					</xsl:when>
					<xsl:when test="$allPersonsProcessed = 'true'">
						<xsl:text>true</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>false</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="ordinalNumberOfPersonInParty" select="count(preceding-sibling::tia:IMKAD_Persoon) + 1"/>
			<xsl:variable name="positionWithinParty" select="count($currentParty/tia:IMKAD_Persoon[$ordinalNumberOfPersonInParty]/preceding-sibling::tia:IMKAD_Persoon[not(tia:tia_Gegevens/tia:NHR_Rechtspersoon and (count(tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder']) = 0) and (tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidaanduiding']/tia:tekst) and count(preceding-sibling::tia:IMKAD_Persoon) > 0)])
			+ count($currentParty/tia:IMKAD_Persoon[$ordinalNumberOfPersonInParty]/preceding-sibling::tia:IMKAD_Persoon[count(tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder']) > 1]/tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder' and preceding-sibling::tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder']])												
			+ 1"/>
			<xsl:variable name="existGevolmachtigde" select="count(tia:Hoedanigheid[$currentParty/tia:Gevolmachtigde/tia:vertegenwoordigtRef/@xlink:href = concat('#',@id)]) + 
														count($currentParty/tia:IMKAD_Persoon[not(tia:tia_Gegevens/tia:NHR_Rechtspersoon)]/tia:vertegenwoordigtRef) + 
														count($currentParty/tia:IMKAD_Persoon[not(tia:tia_Gegevens/tia:NHR_Rechtspersoon)]/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:vertegenwoordigtRef)"/>
			<xsl:choose>
				<!-- printing NAME of persons-->
				<xsl:when test="$name">
					<xsl:choose>
						<!-- PNP -->
						<xsl:when test="tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene">
							<!-- main person -->
							<xsl:if test="translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true' and 
											(($debtorPersonsProcessed = 'true' and $personIsDebtor = 'true') or ($mortgagerPersonsProcessed = 'true' and $personIsMortgager = 'true'))">
								<tia:group>
									<xsl:apply-templates select="tia:tia_Gegevens" mode="do-person-name"/>
								</tia:group>
							</xsl:if>
							<!-- related person(s) -->
							<xsl:for-each select="tia:GerelateerdPersoon">
								<xsl:variable name="currentPerson" select="tia:IMKAD_Persoon"/>
								<xsl:variable name="currentPersonIsDebtor">
									<xsl:choose>
										<xsl:when test="translate(tia:IMKAD_Persoon/tia:tia_PartijOnderdeel, $upper, $lower) = translate($debtor, $upper, $lower) or translate(tia:IMKAD_Persoon/tia:tia_PartijOnderdeel, $upper, $lower) = translate($both, $upper, $lower)">
											<xsl:text>true</xsl:text>
										</xsl:when>
										<xsl:when test="$allPersonsProcessed = 'true'">
											<xsl:text>true</xsl:text>
										</xsl:when>
										<xsl:otherwise>
											<xsl:text>false</xsl:text>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:variable>
								<xsl:variable name="currentPersonIsMortgager">
									<xsl:choose>
										<xsl:when test="translate(tia:IMKAD_Persoon/tia:tia_PartijOnderdeel, $upper, $lower) = translate($mortgager, $upper, $lower) or translate(tia:IMKAD_Persoon/tia:tia_PartijOnderdeel, $upper, $lower) = translate($both, $upper, $lower)">
											<xsl:text>true</xsl:text>
										</xsl:when>
										<xsl:when test="$allPersonsProcessed = 'true'">
											<xsl:text>true</xsl:text>
										</xsl:when>
										<xsl:otherwise>
											<xsl:text>false</xsl:text>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:variable>
								<xsl:if test="translate(tia:IMKAD_Persoon/tia:tia_IndGerechtigde, $upper, $lower) = 'true' and 
												(($debtorPersonsProcessed = 'true' and $currentPersonIsDebtor = 'true') or ($mortgagerPersonsProcessed = 'true' and $currentPersonIsMortgager = 'true'))">
									<xsl:variable name="relatedPersonAuthorizedRepresentative" select="$currentParty/tia:Gevolmachtigde[tia:vertegenwoordigtRef/@xlink:href = concat('#', $currentParty/tia:Hoedanigheid[tia:wordtVertegenwoordigdRef/@xlink:href=concat('#',$currentPerson/@id)]/@id)]"/>
									<xsl:variable name="allreadyProcessed">
										<xsl:choose>
											<xsl:when test="$relatedPersonAuthorizedRepresentative/tia:volmachtgeverRef[@xlink:href = concat('#',current()/preceding-sibling::tia:GerelateerdPersoon/tia:IMKAD_Persoon/@id)]">
												<xsl:text>true</xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text>false</xsl:text>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:variable>
									<xsl:if test="$allreadyProcessed = 'false'">
										<tia:group>
											<xsl:apply-templates select="tia:IMKAD_Persoon/tia:tia_Gegevens" mode="do-person-name"/>
										</tia:group>
									</xsl:if>
								</xsl:if>
							</xsl:for-each>
						</xsl:when>
						<!-- PNNP -->
						<xsl:when test="tia:tia_Gegevens/tia:NHR_Rechtspersoon">
							<!-- bestuurder -->
							<xsl:for-each select="tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder']">
								<xsl:variable name="positionInSecondNestedLevel" select="count(preceding-sibling::tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder']) + 1"/>
								<xsl:variable name="positionWithinPerson" select="position() - 1"/>
								<xsl:variable name="mainPersonInManagerIsMortgager">
									<xsl:choose>
										<xsl:when test="translate(tia:IMKAD_Persoon/tia:tia_PartijOnderdeel, $upper, $lower) = translate($mortgager, $upper, $lower) or translate(tia:IMKAD_Persoon/tia:tia_PartijOnderdeel, $upper, $lower) = translate($both, $upper, $lower)">
											<xsl:text>true</xsl:text>
										</xsl:when>
										<xsl:when test="$allPersonsProcessed = 'true'">
											<xsl:text>true</xsl:text>
										</xsl:when>
										<xsl:otherwise>
											<xsl:text>false</xsl:text>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:variable>
								<xsl:variable name="mainPersonInManagerIsDebtor">
									<xsl:choose>
										<xsl:when test="translate(tia:IMKAD_Persoon/tia:tia_PartijOnderdeel, $upper, $lower) = translate($debtor, $upper, $lower) or translate(tia:IMKAD_Persoon/tia:tia_PartijOnderdeel, $upper, $lower) = translate($both, $upper, $lower)">
											<xsl:text>true</xsl:text>
										</xsl:when>
										<xsl:when test="$allPersonsProcessed = 'true'">
											<xsl:text>true</xsl:text>
										</xsl:when>
										<xsl:otherwise>
											<xsl:text>false</xsl:text>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:variable>
								<!-- main person of bestuurder -->
								<xsl:if test="translate(tia:IMKAD_Persoon/tia:tia_IndGerechtigde, $upper, $lower) = 'true' and 
												(($debtorPersonsProcessed = 'true' and $mainPersonInManagerIsDebtor = 'true') or
													($mortgagerPersonsProcessed = 'true' and $mainPersonInManagerIsMortgager = 'true'))">
									<tia:group>
										<xsl:apply-templates select="tia:IMKAD_Persoon/tia:tia_Gegevens" mode="do-person-name"/>
									</tia:group>
								</xsl:if>
								<!-- related bestuurder person(s) -->
								<xsl:for-each select="tia:IMKAD_Persoon/tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'partner' or translate(tia:rol, $upper, $lower) = 'huisgenoot']">
									<xsl:variable name="positionInThirdNestedLevel" select="count(preceding-sibling::tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'partner' or translate(tia:rol, $upper, $lower) = 'huisgenoot']) + 1"/>
									<xsl:variable name="currentPersonInManagerIsDebtor">
										<xsl:choose>
											<xsl:when test="translate(tia:IMKAD_Persoon/tia:tia_PartijOnderdeel, $upper, $lower) = translate($debtor, $upper, $lower) or translate(tia:IMKAD_Persoon/tia:tia_PartijOnderdeel, $upper, $lower) = translate($both, $upper, $lower)">
												<xsl:text>true</xsl:text>
											</xsl:when>
											<xsl:when test="$allPersonsProcessed = 'true'">
												<xsl:text>true</xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text>false</xsl:text>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:variable>
									<xsl:variable name="currentPersonInManagerIsMortgager">
										<xsl:choose>
											<xsl:when test="translate(tia:IMKAD_Persoon/tia:tia_PartijOnderdeel, $upper, $lower) = translate($mortgager, $upper, $lower) or translate(tia:IMKAD_Persoon/tia:tia_PartijOnderdeel, $upper, $lower) = translate($both, $upper, $lower)">
												<xsl:text>true</xsl:text>
											</xsl:when>
											<xsl:when test="$allPersonsProcessed = 'true'">
												<xsl:text>true</xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text>false</xsl:text>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:variable>
									<xsl:if test="translate(tia:IMKAD_Persoon/tia:tia_IndGerechtigde, $upper, $lower) = 'true' and 
													(($debtorPersonsProcessed = 'true' and $currentPersonInManagerIsDebtor = 'true') or 
														($mortgagerPersonsProcessed = 'true' and $currentPersonInManagerIsMortgager = 'true'))">
										<tia:group>
											<xsl:apply-templates select="tia:IMKAD_Persoon/tia:tia_Gegevens" mode="do-person-name"/>
										</tia:group>
									</xsl:if>
								</xsl:for-each>
							</xsl:for-each>
							<!-- main person -->
							<xsl:if test="translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true' and 
											(($debtorPersonsProcessed = 'true' and $personIsDebtor = 'true') or ($mortgagerPersonsProcessed = 'true' and $personIsMortgager = 'true'))">
								<tia:group>
									<xsl:apply-templates select="tia:tia_Gegevens" mode="do-person-name"/>
								</tia:group>
							</xsl:if>
							<!-- related person(s) -->
							<xsl:for-each select="tia:GerelateerdPersoon[not(translate(tia:rol, $upper, $lower) = 'bestuurder')]">
								<xsl:variable name="currentPerson" select="tia:IMKAD_Persoon"/>
								<xsl:variable name="currentPersonIsDebtor">
									<xsl:choose>
										<xsl:when test="translate(tia:IMKAD_Persoon/tia:tia_PartijOnderdeel, $upper, $lower) = translate($debtor, $upper, $lower) or translate(tia:IMKAD_Persoon/tia:tia_PartijOnderdeel, $upper, $lower) = translate($both, $upper, $lower)">
											<xsl:text>true</xsl:text>
										</xsl:when>
										<xsl:when test="$allPersonsProcessed = 'true'">
											<xsl:text>true</xsl:text>
										</xsl:when>
										<xsl:otherwise>
											<xsl:text>false</xsl:text>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:variable>
								<xsl:variable name="currentPersonIsMortgager">
									<xsl:choose>
										<xsl:when test="translate(tia:IMKAD_Persoon/tia:tia_PartijOnderdeel, $upper, $lower) = translate($mortgager, $upper, $lower) or translate(tia:IMKAD_Persoon/tia:tia_PartijOnderdeel, $upper, $lower) = translate($both, $upper, $lower)">
											<xsl:text>true</xsl:text>
										</xsl:when>
										<xsl:when test="$allPersonsProcessed = 'true'">
											<xsl:text>true</xsl:text>
										</xsl:when>
										<xsl:otherwise>
											<xsl:text>false</xsl:text>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:variable>
								<xsl:if test="translate(tia:IMKAD_Persoon/tia:tia_IndGerechtigde, $upper, $lower) = 'true' and 
												(($debtorPersonsProcessed = 'true' and $currentPersonIsDebtor = 'true') or ($mortgagerPersonsProcessed = 'true' and $currentPersonIsMortgager = 'true'))">
									<xsl:variable name="relatedPersonAuthorizedRepresentative" select="$currentParty/tia:Gevolmachtigde[tia:vertegenwoordigtRef/@xlink:href = concat('#', $currentParty/tia:Hoedanigheid[tia:wordtVertegenwoordigdRef/@xlink:href=concat('#',$currentPerson/@id)]/@id)]"/>
									<xsl:variable name="allreadyProcessed">
										<xsl:choose>
											<xsl:when test="$relatedPersonAuthorizedRepresentative/tia:volmachtgeverRef[@xlink:href = concat('#',current()/preceding-sibling::tia:GerelateerdPersoon/tia:IMKAD_Persoon/@id)]">
												<xsl:text>true</xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text>false</xsl:text>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:variable>
									<!-- print only if Gevolmachtigde (per person) number is not printed already -->
									<xsl:if test="$allreadyProcessed = 'false'">
										<tia:group>
											<xsl:apply-templates select="tia:IMKAD_Persoon/tia:tia_Gegevens" mode="do-person-name"/>
										</tia:group>
									</xsl:if>
								</xsl:if>
							</xsl:for-each>
						</xsl:when>
					</xsl:choose>
				</xsl:when>
				<!-- printing NUMBER for persons-->
				<xsl:when test="$number and $existGevolmachtigde = 0">
					<!-- PNP -->
					<xsl:if test="tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene">
						<!-- main person -->
						<xsl:if test="translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true' and 
										(($debtorPersonsProcessed = 'true' and $personIsDebtor = 'true') or ($mortgagerPersonsProcessed = 'true' and $personIsMortgager = 'true'))">
							<tia:group>
								<xsl:value-of select="$partyNumber"/>
								<xsl:choose>
									<xsl:when test="$onlyPersonInParty = 'true'">
										<xsl:if test="tia:GerelateerdPersoon">
											<xsl:number value="1" format="a"/>
										</xsl:if>
									</xsl:when>
									<xsl:otherwise>
										<xsl:number value="$positionWithinParty" format="a"/>
										<xsl:if test="tia:GerelateerdPersoon">
											<xsl:number value="1" format="1"/>
										</xsl:if>
									</xsl:otherwise>
								</xsl:choose>
							</tia:group>
						</xsl:if>
						<!-- related person(s) -->
						<xsl:for-each select="tia:GerelateerdPersoon">
							<xsl:variable name="currentPerson" select="tia:IMKAD_Persoon"/>
							<xsl:variable name="currentPersonIsDebtor">
								<xsl:choose>
									<xsl:when test="translate(tia:IMKAD_Persoon/tia:tia_PartijOnderdeel, $upper, $lower) = translate($debtor, $upper, $lower) or translate(tia:IMKAD_Persoon/tia:tia_PartijOnderdeel, $upper, $lower) = translate($both, $upper, $lower)">
										<xsl:text>true</xsl:text>
									</xsl:when>
									<xsl:when test="$allPersonsProcessed = 'true'">
										<xsl:text>true</xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text>false</xsl:text>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:variable>
							<xsl:variable name="currentPersonIsMortgager">
								<xsl:choose>
									<xsl:when test="translate(tia:IMKAD_Persoon/tia:tia_PartijOnderdeel, $upper, $lower) = translate($mortgager, $upper, $lower) or translate(tia:IMKAD_Persoon/tia:tia_PartijOnderdeel, $upper, $lower) = translate($both, $upper, $lower)">
										<xsl:text>true</xsl:text>
									</xsl:when>
									<xsl:when test="$allPersonsProcessed = 'true'">
										<xsl:text>true</xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text>false</xsl:text>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:variable>
							<xsl:if test="translate(tia:IMKAD_Persoon/tia:tia_IndGerechtigde, $upper, $lower) = 'true' and 
											(($debtorPersonsProcessed = 'true' and $currentPersonIsDebtor = 'true') or ($mortgagerPersonsProcessed = 'true' and $currentPersonIsMortgager = 'true'))">
								<tia:group>
									<xsl:value-of select="$partyNumber"/>
									<xsl:choose>
										<xsl:when test="$onlyPersonInParty = 'true'">
											<xsl:number value="position() + 1" format="a"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:number value="$positionWithinParty" format="a"/>
											<xsl:number value="position() + 1" format="1"/>
										</xsl:otherwise>
									</xsl:choose>
								</tia:group>
							</xsl:if>
						</xsl:for-each>
					</xsl:if>
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-person-name
	*********************************************************
	Public: yes

	Identity transform: no

	Description: Print name from tia:GBA_Ingezetene, tia:IMKAD_KadNatuurlijkPersoon, tia:IMKAD_NietIngezetene, tia:NHR_Rechtspersoon

	Input: tia:tia_Gegevens

	Params: none

	Output: text

	Calls:
	(mode) do-gender-salutation

	Called by:
	(mode) do-person-numbering
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:tia_Gegevens" mode="do-person-name">
		<xsl:choose>
			<xsl:when test="tia:GBA_Ingezetene">
				<xsl:apply-templates select="tia:GBA_Ingezetene" mode="do-gender-salutation"/>
				<xsl:text> </xsl:text>
				<xsl:variable name="kadNatuurlijkPersoon" select="../tia:tia_Gegevens[tia:IMKAD_KadNatuurlijkPersoon]/tia:IMKAD_KadNatuurlijkPersoon"/>
				<xsl:choose>
					<xsl:when test="$kadNatuurlijkPersoon">
						<xsl:value-of select="$kadNatuurlijkPersoon/tia:voornamen"/>
						<xsl:if test="$kadNatuurlijkPersoon/tia:voorvoegselsgeslachtsnaam
								and normalize-space($kadNatuurlijkPersoon/tia:voorvoegselsgeslachtsnaam) != ''">
							<xsl:text> </xsl:text>
							<xsl:value-of select="$kadNatuurlijkPersoon/tia:voorvoegselsgeslachtsnaam"/>
						</xsl:if>
						<xsl:text> </xsl:text>
						<xsl:value-of select="$kadNatuurlijkPersoon/tia:geslachtsnaam"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="tia:GBA_Ingezetene/tia:naam/tia:voornamen"/>
						<xsl:if test="tia:GBA_Ingezetene/tia:tia_VoorvoegselsNaam
								and normalize-space(tia:GBA_Ingezetene/tia:tia_VoorvoegselsNaam) != ''">
							<xsl:text> </xsl:text>
							<xsl:value-of select="tia:GBA_Ingezetene/tia:tia_VoorvoegselsNaam"/>
						</xsl:if>
						<xsl:text> </xsl:text>
						<xsl:value-of select="tia:GBA_Ingezetene/tia:tia_NaamZonderVoorvoegsels"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="tia:IMKAD_NietIngezetene">
				<xsl:apply-templates select="tia:IMKAD_NietIngezetene" mode="do-gender-salutation"/>
				<xsl:text> </xsl:text>
				<xsl:value-of select="tia:IMKAD_NietIngezetene/tia:voornamen"/>
				<xsl:if test="tia:IMKAD_NietIngezetene/tia:voorvoegsels
						and normalize-space(tia:IMKAD_NietIngezetene/tia:voorvoegsels) != ''">
					<xsl:text> </xsl:text>
					<xsl:value-of select="tia:IMKAD_NietIngezetene/tia:voorvoegsels"/>
				</xsl:if>
				<xsl:text> </xsl:text>
				<xsl:value-of select="tia:IMKAD_NietIngezetene/tia:geslachtsnaam"/>
			</xsl:when>
			<xsl:when test="tia:NHR_Rechtspersoon">
				<xsl:choose>
					<xsl:when test="../tia:tia_AanduidingPersoon">
						<xsl:value-of select="../tia:tia_AanduidingPersoon"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="tia:NHR_Rechtspersoon/tia:statutaireNaam"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
