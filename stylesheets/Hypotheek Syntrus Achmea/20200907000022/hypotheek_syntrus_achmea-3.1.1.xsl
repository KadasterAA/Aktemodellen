<?xml version="1.0" encoding="UTF-8"?>
<!--
*********************************************************
AA-5031 Syntrus achmea - afleiden meervoud moet ook in geval van 1 registergoed en 1 overbrugging
*********************************************************
-->
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:tia="http://www.kadaster.nl/schemas/KIK/TIA_Algemeen" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exslt="http://exslt.org/common" xmlns:kef="nl.kadaster.xslt.XslExtensionFunctions" xmlns:gc="http://docs.oasis-open.org/codelist/ns/genericode/1.0/" exclude-result-prefixes="tia xsl exslt xlink gc" version="1.0">
	<xsl:include href="generiek-1.08.xsl"/>
	<xsl:include href="keuzeblok_partijnamen_hypotheekakte_syntrus_achmea-1.0.0.xsl"/>
	<xsl:include href="tekstblok_aanhef-1.20.xsl"/>
	<xsl:include href="tekstblok_burgerlijke_staat-1.03.xsl"/>
	<xsl:include href="tekstblok_equivalentieverklaring-1.28.xsl"/>
	<xsl:include href="tekstblok_gevolmachtigde-1.26.xsl"/>
	<xsl:include href="tekstblok_legitimatie-2.00.xsl"/>
	<xsl:include href="tekstblok_natuurlijk_persoon-1.13.xsl"/>
	<xsl:include href="tekstblok_personalia_van_natuurlijk_persoon-1.06.xsl"/>
	<xsl:include href="tekstblok_partij_natuurlijk_persoon-1.39.xsl"/>
	<xsl:include href="tekstblok_partij_niet_natuurlijk_persoon-1.53.xsl"/>
	<xsl:include href="tekstblok_recht-1.17.xsl"/>
	<xsl:include href="tekstblok_rechtspersoon-1.15.0.xsl"/>
	<xsl:include href="tekstblok_registergoed-1.30.xsl"/>
	<xsl:include href="tekstblok_titel_hypotheekakten-1.02.xsl"/>
	<xsl:include href="tekstblok_woonadres-1.05.xsl"/>
	<xsl:include href="tweededeel-1.05.xsl"/>
	<!-- ING specific global variables -->
	<xsl:variable name="keuzeteksten" select="document('keuzeteksten_hypotheek_syntrus_achmea-2.0.0.xml')"/>
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
	<xsl:variable name="partijVerzekeraarAanwezig">
		<xsl:choose>
			<xsl:when test="count(tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:Partij/tia:Partij) = 2">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>false</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<!--
	*********************************************************
	Mode: do-deed
	*********************************************************
	Public: yes

	Identity transform: no

	Description: Hypotheek Syntrus Achmea.

	Input: tia:Bericht_TIA_Stuk

	Params: none

	Output: XHTML structure

	Calls:
	(mode) do-statement-of-equivalence
	(mode) do-mortgage-deed-title
	(mode) do-header
	(mode) do-comparitie
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
		<xsl:variable name="_partyRestructured">
			<xsl:apply-templates select="tia:IMKAD_AangebodenStuk" mode="do-copy"/>
		</xsl:variable>
		<xsl:variable name="partyRestructured" select="exslt:node-set($_partyRestructured)"/>
		<xsl:variable name="parties" select="tia:IMKAD_AangebodenStuk/tia:Partij"/>
		<xsl:for-each select="$partyRestructured/tia:IMKAD_AangebodenStuk/tia:Partij">
			<xsl:variable name="position" select="position()"/>
			<xsl:variable name="numberOfPersonsInFirstNestedParty" select="count($parties[$position]/tia:Partij[1]/tia:IMKAD_Persoon)"/>
			<xsl:variable name="numberOfPersonsInSecondNestedParty" select="count($parties[$position]/tia:Partij[2]/tia:IMKAD_Persoon)"/>
			<xsl:variable name="numberOfPersonsWithIndGerechtigdeInFirstNestedParty" select="count($parties[$position]/tia:Partij[1]/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true'])"/>
			<xsl:variable name="numberOfPersonsWithIndGerechtigdeInSecondNestedParty" select="count($parties[$position]/tia:Partij[2]/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true'])"/>
			<xsl:apply-templates select="." mode="do-comparitie">
				<xsl:with-param name="numberOfPersonsInFirstNestedParty" select="$numberOfPersonsInFirstNestedParty"/>
				<xsl:with-param name="numberOfPersonsInSecondNestedParty" select="$numberOfPersonsInSecondNestedParty"/>
				<xsl:with-param name="numberOfPersonsWithIndGerechtigdeInFirstNestedParty" select="$numberOfPersonsWithIndGerechtigdeInFirstNestedParty"/>
				<xsl:with-param name="numberOfPersonsWithIndGerechtigdeInSecondNestedParty" select="$numberOfPersonsWithIndGerechtigdeInSecondNestedParty"/>
			</xsl:apply-templates>
		</xsl:for-each>
		<p>
			<xsl:text>Van het bestaan van de</xsl:text>
			<xsl:if test="translate(tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[tia:tagNaam='k_Mondelinge']/tia:tekst,$upper, $lower)='true'">
				<xsl:text> mondelinge</xsl:text>
			</xsl:if>
			<xsl:text> volmacht(en) is mij, notaris, genoegzaam gebleken.</xsl:text>
		</p>
		<p>
			<xsl:text>De comparanten, handelend als gemeld, verklaarden: </xsl:text>
		</p>
		<h3>
			<xsl:text>I OVEREENKOMST</xsl:text>
		</h3>
		<p>
			<xsl:text>De hypotheekgever en de schuldeiser zijn in de na te noemen offerte overeengekomen dat ten behoeve van de schuldeiser een recht van hypotheek respectievelijk pand zal worden verleend op de in deze akte vermelde goederen tot zekerheid zoals in deze akte omschreven.</xsl:text>
		</p>
		<h3>
			<xsl:text>II GELDLENING EN ZEKERHEDEN </xsl:text>
		</h3>
		<table cellspacing="0" cellpadding="0">
			<tbody>
				<tr>
					<td class="number" valign="top">
						<xsl:text>A</xsl:text>
					</td>
					<td class="number" valign="top">
						<u>
							<xsl:text>Lening</xsl:text>
						</u>
					</td>
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<td valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>					
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<td valign="top" colspan="3">
						<xsl:text>De comparanten verklaren dat de schuldeiser aan de hypotheekgever en/of schuldenaar een geldlening heeft verstrekt onder het beding van hypotheek– en pandverlening overeenkomstig de door de schuldeiser gedane en door de schuldenaar geaccepteerde offerte met hypotheeknummer </xsl:text>
						<xsl:value-of select="tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[tia:tagNaam='k_Offertenummer']/tia:tekst"/>
						<xsl:text>, waarvan blijkt uit het eveneens op heden door de schuldenaar getekende en aan deze akte te hechten exemplaar, in deze akte (tezamen) te noemen: “(de) offerte”. De schuldenaar verklaart aan de schuldeiser wegens de op heden ontvangen gelden schuldig te zijn de hoofdsom groot </xsl:text>
						<xsl:call-template name="amountText">
							<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragLening/tia:som"/>
							<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragLening/tia:valuta"/>
						</xsl:call-template>
						<xsl:text> </xsl:text>
						<xsl:call-template name="amountNumber">
							<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragLening/tia:som"/>
							<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragLening/tia:valuta"/>
						</xsl:call-template>
						<xsl:text>. De offerte wordt geacht integraal onderdeel uit te maken van deze akte.</xsl:text>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<td valign="top" colspan="3">
						<xsl:text>Voorzover daarvan niet uitdrukkelijk bij deze akte is afgeweken, zijn op deze geldlening en na te noemen hypotheek– en pandverlening van toepassing:</xsl:text>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<td class="number" valign="top">
						<xsl:text>a.</xsl:text>
					</td>
					<td valign="top" colspan="2">
						<xsl:text>de bepalingen in de offerte, en</xsl:text>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<td class="number" valign="top">
						<xsl:text>b.</xsl:text>
					</td>
					<td valign="top" colspan="2">
						<xsl:text>de overige bepalingen vervat in de bij de offerte aan schuldenaar verstrekte documenten, en</xsl:text>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<td class="number" valign="top">
						<xsl:text>c.</xsl:text>
					</td>
					<td valign="top" colspan="2">
						<xsl:text>de na te noemen Algemene Voorwaarden.</xsl:text>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>B</xsl:text>
					</td>
					<td valign="top" colspan="3">
						<u>
							<xsl:text>Looptijd en aflossing</xsl:text>
						</u>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<td valign="top" colspan="3">
						<xsl:text>De lening heeft een looptijd zoals in deze akte is overeengekomen. De aflossing van de lening vindt plaats op de wijze zoals is overeengekomen, respectievelijk zoals eventueel nader tussen partijen zal worden overeengekomen.</xsl:text>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>C</xsl:text>
					</td>
					<td valign="top" colspan="3">
						<u>
							<xsl:text>Rente</xsl:text>
						</u>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<td valign="top" colspan="3">
						<xsl:text>De schuldenaar is aan de schuldeiser over de hoofdsom of het restant daarvan een rente verschuldigd zoals overeengekomen in de offerte, per maand achteraf te voldoen, welk percentage is vastgesteld tot de eerste renteherzieningsdatum zoals overeengekomen in de offerte.</xsl:text>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>D</xsl:text>
					</td>
					<td valign="top" colspan="3">
						<u>
							<xsl:text>Hypotheekstelling</xsl:text>
						</u>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<td valign="top" colspan="3">
						<xsl:text>Ter uitvoering van de hiervoor vermelde overeenkomst en de daarop van toepassing verklaarde Algemene Voorwaarden (als hierna gemeld), tot zekerheid voor de betaling van:</xsl:text>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<td class="number" valign="top">
						<xsl:text>-</xsl:text>
					</td>
					<td valign="top" colspan="2">
						<xsl:text>al wat schuldenaar aan de schuldeiser verschuldigd is of te eniger tijd zal zijn uit hoofde van de geldlening of uit welke hoofde ook, waaronder doch niet beperkt tot de hoofdsom, renten, boeten, kosten en vergoedingen van welke aard dan ook, waaronder vergoedingen voor al hetgeen de schuldeiser voor de hypotheekgever en/of schuldenaar (verder) heeft voldaan zoals voorschotten, verzekeringspremies en dergelijke, alsmede voor de kosten die de schuldeiser heeft gemaakt in verband met de niet (tijdige) nakoming door de schuldenaar van zijn verplichtingen jegens de schuldeiser, tot een gezamenlijk bedrag begroot op </xsl:text>
						<xsl:call-template name="amountText">
							<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:hoofdsom/tia:som"/>
							<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:hoofdsom/tia:valuta"/>
						</xsl:call-template>
						<xsl:text> </xsl:text>
						<xsl:call-template name="amountNumber">
							<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:hoofdsom/tia:som"/>
							<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:hoofdsom/tia:valuta"/>
						</xsl:call-template>
						<xsl:text>; alsmede</xsl:text>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<td class="number" valign="top">
						<xsl:text>-</xsl:text>
					</td>
					<td valign="top" colspan="2">
						<xsl:text>de bedongen rente en eventueel later overeen te komen verhogingen daarvan en al wat de schuldeiser in verband met het vorenstaande aan renten, boeten, kosten, premies of anderszins, verder te vorderen heeft of zal hebben, tezamen begroot op </xsl:text>
						<xsl:call-template name="amountText">
							<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragRente/tia:som"/>
							<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragRente/tia:valuta"/>
						</xsl:call-template>
						<xsl:text> </xsl:text>
						<xsl:call-template name="amountNumber">
							<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragRente/tia:som"/>
							<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragRente/tia:valuta"/>
						</xsl:call-template>
						<xsl:text>,</xsl:text>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<td colspan="3" valign="top">
						<xsl:text> voor een maximumbedrag van </xsl:text>
						<xsl:call-template name="amountText">
							<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragTotaal/tia:som"/>
							<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragTotaal/tia:valuta"/>
						</xsl:call-template>
						<xsl:text> </xsl:text>
						<xsl:call-template name="amountNumber">
							<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragTotaal/tia:som"/>
							<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragTotaal/tia:valuta"/>
						</xsl:call-template>
						<xsl:text>, wordt door de hypotheekgever ten behoeve van de schuldeiser het recht van hypotheek verleend op </xsl:text>
						<xsl:choose>
							<xsl:when test="count(tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek/tia:IMKAD_ZakelijkRecht) > 1">
								<xsl:text>de </xsl:text>
							</xsl:when>
							<xsl:otherwise>
								<xsl:text>het </xsl:text>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:text>onder E genoemde aan de hypotheekgever toebehorende registergoed</xsl:text>
						<xsl:if test="count(tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek/tia:IMKAD_ZakelijkRecht) > 1">
							<xsl:text>eren</xsl:text>
						</xsl:if>
						<xsl:text>.</xsl:text>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>E</xsl:text>
					</td>
					<td valign="top" colspan="3">
						<u>
							<xsl:text>Registergoed</xsl:text>
							<xsl:if test="count(tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek/tia:IMKAD_ZakelijkRecht) > 1">
								<xsl:text>eren</xsl:text>
							</xsl:if>
						</u>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<td valign="top" colspan="3">
						<xsl:text>Schuldenaar verleent bij deze aan de schuldeiser, die dit van schuldenaar aanvaardt, het recht van </xsl:text>
						<xsl:value-of select="kef:convertOrdinalToText(tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:rangordeHypotheek)"/>
						<xsl:text> hypotheek op het hierna te beschrijven onderpand: </xsl:text>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<td valign="top" colspan="3">
						<a name="hyp3.rights" class="location">&#160;</a>
						<xsl:apply-templates select="." mode="do-rights">
							<xsl:with-param name="stukdeel" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']"/>
						</xsl:apply-templates>
					</td>
				</tr>
				<xsl:apply-templates select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[translate(tia:aanduidingHypotheek, $upper, $lower) = 'overbruggingshypotheek']" mode="do-overbruggingshypotheek"/>
				<tr>
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<td valign="top" colspan="3">
						<xsl:text>hierna </xsl:text>
						<xsl:if test="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[translate(tia:aanduidingHypotheek, $upper, $lower) = 'overbruggingshypotheek']">
							<xsl:text>zowel samen als afzonderlijk </xsl:text>
						</xsl:if>
						<xsl:text>te noemen het: 'Onderpand'.</xsl:text>
					</td>
				</tr>
				<xsl:if test="translate(tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_svnstarterslening']/tia:tekst, $upper, $lower) = 'true'">
					<tr>
						<td class="number" valign="top">
							<xsl:text>&#xFEFF;</xsl:text>
						</td>
						<td valign="top" colspan="3">
							<u>
								<xsl:text>SVn Starterslening</xsl:text>
							</u>
						</td>
					</tr>
					<tr>
						<td class="number" valign="top">
							<xsl:text/>
						</td>
						<td valign="top" colspan="3">
							<xsl:text>In verband met de door de Stichting Stimuleringsfonds Volkshuisvesting Nederlandse Gemeenten (SVn) te verstrekken Starterslening, heeft de schuldeiser zich jegens SVn en Stichting Waarborgfonds Eigen Woningen (WEW) verplicht, na het ingaan van de lening geen gelden meer onder verband van de eerste hypotheekstelling ter leen te verstrekken aan de schuldenaar. Tevens heeft de schuldeiser zich jegens SVn en WEW verplicht reeds afgeloste bedragen op de lening, onder verband van de eerste hypotheekstelling, niet opnieuw te laten opnemen door de schuldenaar. Voormelde verplichtingen rusten op de schuldeiser uitsluitend zolang de bij SVn aangegane Starterslening niet volledig is afgelost.
</xsl:text>
						</td>
					</tr>
				</xsl:if>
				<tr>
					<td class="number" valign="top">
						<xsl:text>F</xsl:text>
					</td>
					<td valign="top" colspan="3">
						<u>
							<xsl:text>Aanvaarding</xsl:text>
						</u>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<td valign="top" colspan="3">
						<xsl:text>De schuldeiser aanvaardt, voor zover nodig bij voorbaat, de schuldigerkenning, de zekerheidstellingen, alle aangegane verbintenissen en alle verleende bevoegdheden en volmachten voortvloeiende uit deze akte en/of de Algemene Voorwaarden.</xsl:text>
					</td>
				</tr>
				<xsl:variable name="woonplaatskeuze" select="tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_woonplaatskeuze']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
				translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_woonplaatskeuze']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
				translate(normalize-space(current()/tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_woonplaatskeuze']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
				<a name="hyp3.electionOfDomicile" class="location">&#160;</a>
				<xsl:if test="$woonplaatskeuze != ''">
					<tr>
						<td class="number" valign="top">
							<xsl:text>G</xsl:text>
						</td>
						<td valign="top" colspan="3">
							<u>
								<xsl:text>Woonplaats</xsl:text>
							</u>
						</td>
					</tr>
					<tr>
						<td class="number" valign="top">
							<xsl:text>&#xFEFF;</xsl:text>
						</td>
						<td valign="top" colspan="3">
							<xsl:value-of select="$woonplaatskeuze"/>
						</td>
					</tr>
				</xsl:if>
			</tbody>
		</table>
		<h3>
			<xsl:text>EINDE KADASTERDEEL</xsl:text>
		</h3>
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

	Description: ING mortgage deed parties.

	Input: tia:Partij

	Params: numberOfPersonsInFirstNestedParty - number of persons in first nested party
			numberOfPersonsInSecondNestedParty - number of persons in second nested party
			numberOfPersonsInThirdNestedParty - number of persons in third nested party
			numberOfPersonsWithIndGerechtigdeInFirstNestedParty - number of persons with IndGerechtigde in first nested party
			numberOfPersonsWithIndGerechtigdeInSecondNestedParty - number of persons with IndGerechtigde in second nested party
			numberOfPersonsWithIndGerechtigdeInThirdNestedParty - number of persons with IndGerechtigde in third nested party

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
	<xsl:template match="tia:Partij" mode="do-comparitie">
		<xsl:param name="numberOfPersonsInFirstNestedParty" select="number('0')"/>
		<xsl:param name="numberOfPersonsInSecondNestedParty" select="number('0')"/>
		<xsl:param name="numberOfPersonsWithIndGerechtigdeInFirstNestedParty" select="number('0')"/>
		<xsl:param name="numberOfPersonsWithIndGerechtigdeInSecondNestedParty" select="number('0')"/>
		<xsl:variable name="numberOfPersons" select="count(tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true'])
					+ count(tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true'])
					+ count(tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true'])"/>
		<xsl:variable name="anchorName">
			<xsl:text>party.</xsl:text>
			<xsl:value-of select="count(preceding-sibling::tia:Partij) + 1"/>
		</xsl:variable>
		<xsl:variable name="hoedanigheidId" select="substring-after(tia:Gevolmachtigde/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'], '#')"/>
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
											<xsl:number value="count(preceding-sibling::tia:Partij) + 1" format="1"/>
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
					<!-- If only one person pair is present do not create list -->
					<xsl:when test="tia:IMKAD_Persoon[(tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene)
								and tia:GerelateerdPersoon[tia:rol]]
							and not(count(tia:IMKAD_Persoon) > 1)">
						<xsl:call-template name="tekstblokPartijOfRechtspersoon">
							<xsl:with-param name="anchorName" select="$anchorName"/>
							<xsl:with-param name="persoon" select="tia:IMKAD_Persoon"/>
							<xsl:with-param name="partij" select="@id"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="count(tia:IMKAD_Persoon) = 1">
						<xsl:call-template name="tekstblokPartijOfRechtspersoon">
							<xsl:with-param name="anchorName" select="$anchorName"/>
							<xsl:with-param name="persoon" select="tia:IMKAD_Persoon"/>
							<xsl:with-param name="partij" select="@id"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:for-each select="tia:IMKAD_Persoon">
							<xsl:variable name="anchorNameParty">
								<xsl:choose>
									<xsl:when test="($numberOfPersonsInFirstNestedParty + $numberOfPersonsInSecondNestedParty) > 0">
										<xsl:choose>
											<xsl:when test="$numberOfPersonsInFirstNestedParty >= position()">
												<xsl:text>party.2</xsl:text>
											</xsl:when>
											<xsl:when test="($numberOfPersonsInFirstNestedParty + $numberOfPersonsInSecondNestedParty) >= position()">
												<xsl:text>hyp3.insurerPersons</xsl:text>
											</xsl:when>
										</xsl:choose>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="$anchorName"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:variable>
							<xsl:call-template name="tekstblokPartijOfRechtspersoon">
								<xsl:with-param name="anchorName" select="$anchorNameParty"/>
								<xsl:with-param name="persoon" select="."/>
								<xsl:with-param name="partij" select="ancestor::tia:Partij/@id"/>
							</xsl:call-template>
							<xsl:if test="($numberOfPersonsInFirstNestedParty + $numberOfPersonsInSecondNestedParty > 0)">
								<xsl:choose>
									<xsl:when test="$numberOfPersonsInFirstNestedParty = position()">
										<tr>
											<td>
												<table>
													<tbody>
														<tr>
															<td class="number" valign="top">
																<xsl:text>&#xFEFF;</xsl:text>
															</td>
															<td>
																<xsl:text>hierna ook te noemen: de 'schuldeiser' of 'hypotheekhouder'</xsl:text>
																<xsl:choose>
																	<xsl:when test="$partijVerzekeraarAanwezig='true'">
																		<xsl:text>;</xsl:text>
																	</xsl:when>
																	<xsl:otherwise>
																		<xsl:text>.</xsl:text>
																	</xsl:otherwise>
																</xsl:choose>
															</td>
														</tr>
													</tbody>
												</table>
											</td>
										</tr>
									</xsl:when>
									<xsl:when test="($numberOfPersonsInFirstNestedParty + $numberOfPersonsInSecondNestedParty) = position()">
										<tr>
											<td>
												<table>
													<tbody>
														<tr>
															<td class="number" valign="top">
																<xsl:text>&#xFEFF;</xsl:text>
															</td>
															<td>
																<xsl:text>hierna ook te noemen: de 'verzekeraar'.</xsl:text>
															</td>
														</tr>
													</tbody>
												</table>
											</td>
										</tr>
									</xsl:when>
								</xsl:choose>
							</xsl:if>
						</xsl:for-each>
					</xsl:otherwise>
				</xsl:choose>
			</tbody>
		</table>
		<xsl:if test="($numberOfPersonsInFirstNestedParty + $numberOfPersonsInSecondNestedParty) = 0">
			<p style="margin-left:30px">
				<xsl:choose>
					<xsl:when test="@id = substring-after(../tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:vervreemderRechtRef/@*[translate(local-name(), $upper, $lower) = 'href'], '#')">
						<xsl:apply-templates select="." mode="do-keuzeblok-partijnamen-hypotheekakte"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>hierna ook te noemen: de 'schuldeiser' of 'hypotheekhouder'</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:choose>
					<xsl:when test="$partijVerzekeraarAanwezig='true' or @id = substring-after(../tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:vervreemderRechtRef/@*[translate(local-name(), $upper, $lower) = 'href'], '#')">
						<xsl:text>;</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>.</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</p>
		</xsl:if>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-party-person
	*********************************************************
	Public: no

	Identity transform: no

	Description: ING mortgage deed party persons.

	Input: tia:IMKAD_Persoon

	Params: start - order number of person in nested party
			anchorName - name of the anchor that will be positioned in first <td> element

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
		<xsl:param name="start" select="number('0')"/>
		<xsl:param name="anchorName" select="''"/>
		<xsl:apply-templates select="." mode="do-party-natural-person">
			<xsl:with-param name="start" select="$start"/>
			<xsl:with-param name="anchorName" select="$anchorName"/>
		</xsl:apply-templates>
	</xsl:template>
	<!--
	**** matching template   ******************************************************************************
	**** NATURAL PERSON PAIR ******************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon[(tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene) and tia:GerelateerdPersoon]" mode="do-party-person">
		<xsl:param name="start" select="number('0')"/>
		<xsl:param name="anchorName" select="''"/>
		<xsl:apply-templates select="." mode="do-party-natural-person">
			<xsl:with-param name="start" select="$start"/>
			<xsl:with-param name="anchorName" select="$anchorName"/>
		</xsl:apply-templates>
	</xsl:template>
	<!--
	**** matching template ********************************************************************************
	**** LEGAL PERSON      ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon[tia:tia_Gegevens/tia:NHR_Rechtspersoon]" mode="do-party-person">
		<xsl:param name="start" select="number('0')"/>
		<xsl:param name="anchorName" select="''"/>
		<xsl:apply-templates select="." mode="do-party-legal-person">
			<xsl:with-param name="start" select="$start"/>
			<xsl:with-param name="anchorName" select="$anchorName"/>
		</xsl:apply-templates>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-copy
	*********************************************************
	Public: no

	Identity transform: no

	Description: Recursive template used for creation/copy of structure that is exactly the same as matched one, except for the nested party structures specific for ING deed.
				 Nested parties wrapper element (tia:Partij) is not copied into new structure, in order to create usual party-person XML structure that can be used in any following logic.

	Input: @*|node()

	Params: none

	Output: XHTML structure

	Calls:
	(mode) do-copy

	Called by:
	(mode) do-deed
	-->
	<!--
	**** matching template     ****************************************************************************
	**** ATTRIBUTES/NODES/TEXT ****************************************************************************
	-->
	<xsl:template match="@*|node()" mode="do-copy">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" mode="do-copy"/>
		</xsl:copy>
	</xsl:template>
	<!--
	**** matching template ********************************************************************************
	**** NESTED PARTY      ********************************************************************************
	-->
	<xsl:template match="tia:Partij[parent::tia:Partij]" mode="do-copy">
		<xsl:apply-templates select="tia:Hoedanigheid" mode="do-copy"/>
		<xsl:apply-templates select="tia:IMKAD_Persoon" mode="do-copy"/>
	</xsl:template>
	<!-- *********************** -->
	<xsl:template name="tekstblokPartijOfRechtspersoon">
		<xsl:param name="anchorName"/>
		<xsl:param name="persoon"/>
		<xsl:param name="partij"/>
		<xsl:choose>
			<xsl:when test="$partij = substring-after(ancestor::tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:vervreemderRechtRef/@*[translate(local-name(), $upper, $lower) = 'href'], '#')">
				<xsl:apply-templates select="$persoon" mode="do-party-person">
					<xsl:with-param name="anchorName" select="$anchorName"/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:otherwise>
				<tr>
					<td>
						<table>
							<tbody>
								<tr>
									<td class="number"/>
									<xsl:if test="$partijVerzekeraarAanwezig='true'">
										<td class="number">
											<xsl:number value="position()" format="a"/>
											<xsl:text>.</xsl:text>
										</td>
									</xsl:if>
									<td>
										<xsl:apply-templates select="$persoon" mode="do-legal-person"/>
										<xsl:if test="$persoon/tia:IMKAD_PostlocatiePersoon">
											<xsl:text> (correspondentieadres voor alle aangelegenheden betreffende de hierna te vermelden rechtshandelingen: </xsl:text>
											<xsl:apply-templates select="$persoon/tia:IMKAD_PostlocatiePersoon" mode="do-correspondant-address"/>
											<xsl:text>)</xsl:text>
										</xsl:if>
										<xsl:text>;</xsl:text>
									</td>
								</tr>
							</tbody>
						</table>
					</td>
				</tr>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--
	**** matching template ********************************************************************************
	**** Overbruggingshypotheek      ********************************************************************************
	-->
	<xsl:template match="tia:StukdeelHypotheek" mode="do-overbruggingshypotheek">
		<tr>
			<td class="number" valign="top">
				<xsl:text>&#xFEFF;</xsl:text>
			</td>
			<td class="number" valign="top" colspan="3">
				<xsl:text>Overbrugging</xsl:text>
			</td>
		</tr>
		<tr>
			<td class="number" valign="top">
				<xsl:text>&#xFEFF;</xsl:text>
			</td>
			<td class="number" valign="top" colspan="3">
				<xsl:text>Voorts verleent schuldenaar, tot meerdere zekerheid voor de betaling van de Lening als hierboven vermeld, bij deze aan de schuldeiser, die van de schuldenaar aanvaardt, het recht van </xsl:text>
				<xsl:value-of select="kef:convertOrdinalToText(tia:rangordeHypotheek)"/>
				<xsl:text> hypotheek op het hierna te omschrijven onderpand:  </xsl:text>
			</td>
		</tr>
		<xsl:choose>
			<xsl:when test="count(tia:IMKAD_ZakelijkRecht) = 1">
				<tr>
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<td class="number" valign="top" colspan="3">
						<xsl:variable name="rightText">
							<xsl:apply-templates select="tia:IMKAD_ZakelijkRecht" mode="do-right"/>
						</xsl:variable>
						<xsl:if test="normalize-space($rightText) != ''">
							<xsl:value-of select="$rightText"/>
							<xsl:text> </xsl:text>
						</xsl:if>
						<xsl:apply-templates select="tia:IMKAD_ZakelijkRecht" mode="do-registered-object"/>
						<xsl:text>,</xsl:text>
					</td>
				</tr>
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
				<tr>
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<td class="number" valign="top" colspan="3">
						<xsl:variable name="rightText">
							<xsl:apply-templates select="tia:IMKAD_ZakelijkRecht[1]" mode="do-right"/>
						</xsl:variable>
						<xsl:if test="normalize-space($rightText) != ''">
							<xsl:value-of select="$rightText"/>
							<xsl:text> </xsl:text>
						</xsl:if>
						<xsl:apply-templates select="tia:IMKAD_ZakelijkRecht[1]" mode="do-registered-object"/>
						<xsl:text>,</xsl:text>
					</td>
				</tr>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="processRights">
					<xsl:with-param name="positionOfProcessedRight" select="1"/>
					<xsl:with-param name="position" select="1"/>
					<xsl:with-param name="registeredObjects" select="."/>
					<xsl:with-param name="indentLevel" select="1"/>
					<xsl:with-param name="endMark" select="','"/>
					<xsl:with-param name="colspan" select="2"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
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
		<xsl:variable name="afsluiter">
			<xsl:choose>
				<xsl:when test="count(tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[translate(tia:aanduidingHypotheek, $upper, $lower) = 'overbruggingshypotheek'])>0">
					<xsl:text>;</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>,</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
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
					<xsl:value-of select="$afsluiter"/>
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
					<xsl:value-of select="$afsluiter"/>
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
							<xsl:with-param name="endMark" select="$afsluiter"/>
						</xsl:call-template>
					</tbody>
				</table>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
