<?xml version="1.0" encoding="UTF-8"?>
<!--
*************************************************************
Stylesheet: hypotheek_svenska-1.0.xsl
Version: 1.0.0
[AA-6505] Nieuw KIK model voor Handelsbanken
*************************************************************

Public:
(mode) do-deed
-->
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:tia="http://www.kadaster.nl/schemas/KIK/TIA_Algemeen" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:kef="nl.kadaster.xslt.XslExtensionFunctions" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:gc="http://docs.oasis-open.org/codelist/ns/genericode/1.0/" exclude-result-prefixes="tia xsl xlink kef gc" version="1.0">
	<xsl:include href="generiek-1.08.xsl"/>
	<xsl:include href="tekstblok_aanhef-1.20.xsl"/>
	<xsl:include href="tekstblok_burgerlijke_staat-1.03.xsl"/>
	<xsl:include href="tekstblok_equivalentieverklaring-1.30.xsl"/>
	<xsl:include href="tekstblok_gevolmachtigde-1.26.xsl"/>
	<xsl:include href="tekstblok_legitimatie-2.00.xsl"/>
	<xsl:include href="tekstblok_natuurlijk_persoon-1.13.xsl"/>
	<xsl:include href="tekstblok_partij_natuurlijk_persoon-1.39.xsl"/>
	<xsl:include href="tekstblok_partij_niet_natuurlijk_persoon-1.53.xsl"/>
	<xsl:include href="tekstblok_personalia_van_natuurlijk_persoon-1.06.xsl"/>
	<xsl:include href="tekstblok_recht-1.17.xsl"/>
	<xsl:include href="tekstblok_rechtspersoon-1.16.0.xsl"/>
	<xsl:include href="tekstblok_registergoed-1.29.xsl"/>
	<xsl:include href="tekstblok_titel_hypotheekakten-1.02.xsl"/>
	<xsl:include href="tekstblok_woonadres-1.05.xsl"/>
	<xsl:include href="tweededeel-1.05.xsl"/>
	<xsl:variable name="keuzeteksten" select="document('keuzeteksten_hypotheek_svenska-1.0.0.xml')"/>
	<xsl:variable name="legalPersonNames" select="document('nnp-kodes.xml')/gc:CodeList/SimpleCodeList/Row"/>
	<xsl:variable name="keuzetekstenTbBurgelijkeStaat" select="document('keuzeteksten-tb-burgerlijkestaat-1.1.0.xml')"/>
	<xsl:variable name="RegistergoedTonenPerPerceel">
		<!-- t.b.v. TB Registergoed -->
		<xsl:choose>
			<xsl:when test="tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedtonenperperceel']">
				<xsl:value-of select="translate(tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedtonenperperceel']/tia:tekst, $upper, $lower)"/>
			</xsl:when>
			<xsl:otherwise>false</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="werktuigen"
				  select="tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_werktuigen']/tia:tekst"/>
	<xsl:variable name="kredietovereenkomstMeervoud"
				  select="tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_kredietovereenkomst']/tia:tekst"/>
	<xsl:variable name="elk"
				  select="tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_elk']/tia:tekst"/>
	<xsl:variable name="rangordepand"
				  select="tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_rangordepand']/tia:tekst"/>
	<!--
	*********************************************************
	Mode: do-deed
	*********************************************************
	Public: yes

	Identity transform: no

	Description: svenska mortgage deed.

	Input: tia:Bericht_TIA_Stuk

	Params: none

	Output: XHTML structure

	Calls:
	(mode) do-statement-of-equivalence
	(mode) do-header
	(mode) do-parties
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
		<xsl:apply-templates select="tia:IMKAD_AangebodenStuk/tia:Partij" mode="do-parties"/>
		<p>
			<strong>
				<xsl:text>DEFINITIES</xsl:text>
			</strong>
		</p>
		<p>
			<xsl:text>De comparanten, handelend als vermeld, verklaren dat hierna wordt verstaan onder:</xsl:text>
		</p>
		<table cellspacing="0" cellpadding="0">
		<tbody>
		<tr>
			<td class="number" valign="top">
				<xsl:text>-</xsl:text>
			</td>
			<td valign="top">
				<strong>
				<xsl:text>Algemene Voorwaarden:</xsl:text>
				</strong>
				<xsl:text> de actuele versie van de Algemene Voorwaarden van Handelsbanken Nederland, zoals gedeponeerd bij de Kamer van Koophandel te Amsterdam en ook beschikbaar is gesteld op de website www.handelsbanken.nl, welke set voorwaarden aan de Onderzetter/Schuldenaar ter hand is gesteld;</xsl:text>
			</td>
		</tr>
		<tr>
			<td class="number" valign="top">
				<xsl:text>-</xsl:text>
			</td>
			<td valign="top">
				<xsl:text>het </xsl:text>
				<strong>
				<xsl:text>Onderpand: </xsl:text>
				</strong>
				<xsl:text>het (de) in deze akte nader te omschrijven registergoed(eren) waarop door de Onderzetter een recht van hypotheek aan Handelsbanken wordt verleend, alsmede al hetgeen daarvan volgens verkeersopvatting onderdeel uitmaakt, ongeacht of dit voor of na de hypotheekvestiging is aangebracht, de roerende zaken die volgens verkeeropvatting bestemd zijn het Onderpand duurzaam te dienen en door hun vorm als zodanig zijn te herkennen, de machinerieën of werktuigen als bedoeld in artikel 254 Boek 3 van het Burgerlijk Wetboek en alle vorderingen tot vergoeding die in de plaats van het Onderpand treden, waaronder begrepen de vorderingen ter zake van waardevermindering van het Onderpand, alsmede alle overige goederen waarop door de Onderzetter een recht van pand aan Handelsbanken wordt verleend. Alle veranderingen en toevoegingen aan het Onderpand zullen mede tot zekerheid strekken.</xsl:text>
			</td>
		</tr>
		</tbody>
		</table>
		<p>
			<strong>
				<xsl:text>OVEREENKOMST TOT HET VESTIGEN VAN HYPOTHEEK- EN PANDRECHTEN</xsl:text>
			</strong>
		</p>
		<p>
			<xsl:text>De comparanten, handelend als vermeld, verklaren dat de Onderzetter/Schuldenaar en Handelsbanken zijn overeengekomen dat de Onderzetter ten behoeve van Handelsbanken de rechten van hypotheek en pand op de in deze akte en op de in de Algemene Voorwaarden omschreven goederen zal vestigen, tot zekerheid als in deze akte vermeld.</xsl:text>
		</p>
		<p>
			<strong>
				<xsl:text>ZEKERHEIDSTELLING</xsl:text>
			</strong>
		</p>
		<p>
			<xsl:text>Tot (meerdere) zekerheid voor de betaling van alle verplichtingen die de Schuldenaar nu of te eniger tijd jegens Handelsbanken heeft of zal hebben uit hoofde van een rechtsverhouding tussen Handelsbanken en de Schuldenaar, waarbij Handelsbanken onder bepaalde eventueel later aan te passen of te wijzigen voorwaarden en condities kredietfaciliteiten ter beschikking heeft gesteld of zal stellen, van welke rechtsverhouding onder meer blijkt uit de getekende kredietovereenkomst</xsl:text>
			<xsl:if test="normalize-space($kredietovereenkomstMeervoud) = 'kredietovereenkomsten'">
				<xsl:text>en</xsl:text>
			</xsl:if>
			<xsl:text>, waarvan </xsl:text>
			<xsl:if test="normalize-space($elk) = 'true'">
				<xsl:text>elk </xsl:text>
			</xsl:if>
			<xsl:text>een exemplaar aan deze akte wordt gehecht </xsl:text>
				<strong>
					<xsl:text>(Bijlage)</xsl:text>
				</strong>
			<xsl:text>, alsmede tot zekerheid voor al hetgeen de Schuldenaar aan Handelsbanken, nu of te eniger tijd uit welken hoofde ook, al dan niet onder tijdsbepaling of voorwaarde, verschuldigd is of zal zijn zowel in als buiten rekening-courant en al of niet in het gewone bankverkeer, heeft de Onderzetter zich bereid verklaard om na te melden zekerheden te verstrekken.</xsl:text>
		</p>
		<p>
			<strong>
				<xsl:text>HYPOTHEEKVERLENING</xsl:text>
			</strong>
		</p>
		<p>
			<xsl:text>Ter uitvoering van voormelde kredietovereenkomst</xsl:text>
			<xsl:if test="normalize-space($kredietovereenkomstMeervoud) = 'kredietovereenkomsten'">
				<xsl:text>en</xsl:text>
			</xsl:if>
			<xsl:text> verleent de Onderzetter tot zekerheid als hiervoor vermeld aan Handelsbanken tot een bedrag van </xsl:text>
			<xsl:call-template name="amountText">
				<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:hoofdsom/tia:som"/>
				<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:hoofdsom/tia:valuta"/>
			</xsl:call-template>
			<xsl:text> </xsl:text>
			<xsl:call-template name="amountNumber">
				<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:hoofdsom/tia:som"/>
				<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:hoofdsom/tia:valuta"/>
			</xsl:call-template>
			<xsl:text> in hoofdsom, te vermeerderen met een bedrag aan rente en kosten, welke rente en kosten worden begroot op veertig procent (40%) van het hiervoor vermelde bedrag, derhalve tot een totaalbedrag van </xsl:text>
			<xsl:call-template name="amountText">
				<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragTotaal/tia:som"/>
				<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragTotaal/tia:valuta"/>
			</xsl:call-template>
			<xsl:text> </xsl:text>
			<xsl:call-template name="amountNumber">
				<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragTotaal/tia:som"/>
				<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragTotaal/tia:valuta"/>
			</xsl:call-template>
			<xsl:text>:</xsl:text>
		</p>
		<table cellspacing="0" cellpadding="0">
			<tbody>
				<tr>
					<td class="number" valign="top">
						<xsl:text>A.</xsl:text>
					</td>
					<td colspan="2">
						<xsl:text>een recht van </xsl:text>
						<xsl:value-of select="kef:convertOrdinalToText(tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:rangordeHypotheek)"/>
						<xsl:text> hypotheek op het hierna onder "Omschrijving Registergoed" vermelde registergoed, dat verder zal worden genoemd: het Registergoed, met al hetgeen daarvan naar verkeersopvatting onderdeel uitmaakt;</xsl:text>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>B.</xsl:text>
					</td>
					<td colspan="2">
						<xsl:text>een recht van </xsl:text>
						<xsl:value-of select="kef:convertOrdinalToText($rangordepand)"/>
						<xsl:text> pand op:</xsl:text>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top"><xsl:text> </xsl:text></td>
					<td class="number" valign="top"><xsl:text>-</xsl:text></td>
					<td>
						<xsl:text>alle roerende zaken die volgens verkeersopvatting bestemd zijn of zullen worden om het Registergoed duurzaam te dienen en door hun vorm als zodanig zijn te herkennen;</xsl:text>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top"><xsl:text> </xsl:text></td>
					<td class="number" valign="top"><xsl:text>-</xsl:text></td>
					<td>
						<xsl:text>alle roerende zaken die van het Registergoed worden afgescheiden;</xsl:text>
						<xsl:if test="normalize-space($werktuigen) != 'true'">
							<xsl:text> en</xsl:text>
						</xsl:if>
					</td>
				</tr>
				<xsl:if test="normalize-space($werktuigen) = 'true'">
					<tr>
						<td class="number" valign="top"><xsl:text> </xsl:text></td>
						<td class="number" valign="top"><xsl:text>-</xsl:text></td>
						<td>
							<xsl:text>de machinerieën of werktuigen die bestemd zijn om daarmee een bedrijf uit te oefenen in de hiertoe ingerichte fabriek of werkplaats die bij deze akte hypothecair wordt verbonden; en</xsl:text>
						</td>
					</tr>
				</xsl:if>
				<tr>
					<td class="number" valign="top">
						<xsl:text>C.</xsl:text>
					</td>
					<td colspan="2">
						<xsl:text>een recht van pand op de rechten als bedoeld in hoofdstuk 10 artikel 2 van de Algemene Voorwaarden; en</xsl:text>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>D.</xsl:text>
					</td>
					<td colspan="2">
						<xsl:text>een recht van eerste pand op de rechten als bedoeld in voornoemde kredietovereenkomst</xsl:text>
						<xsl:if test="normalize-space($kredietovereenkomstMeervoud) = 'kredietovereenkomsten'">
							<xsl:text>en</xsl:text>
						</xsl:if>
						<xsl:text> onder de bepalingen betreffende Zekerheden. Voor zover de genoemde rechten nog niet voor verpanding vatbaar zijn en niet van rechtswege ten gunste van Handelsbanken met een pandrecht zijn belast, is de Onderzetter verplicht deze rechten zodra zij voor verpanding vatbaar zijn geworden, terstond aan Handelsbanken te verpanden, waarbij de Onderzetter hierbij tevens een onherroepelijke volmacht met het recht van substitutie aan Handelsbanken geeft om mede namens hem deze verpanding tot stand te brengen.</xsl:text>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text> </xsl:text>
					</td>
					<td colspan="2">
						<xsl:text>De Onderzetter verleent hierbij voorts aan Handelsbanken het recht om mededeling te doen van die verpanding aan de schuldenaren en aan derden.</xsl:text>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text> </xsl:text>
					</td>
					<td colspan="2">
						<xsl:text>Handelsbanken is steeds bevoegd de goederen die zij in pand heeft op basis van deze akte te herverpanden.</xsl:text>
					</td>
				</tr>
			</tbody>
		</table>
		<p>
			<strong>
				<xsl:text>OMSCHRIJVING REGISTERGOED</xsl:text>
			</strong>
		</p>
		<xsl:apply-templates select="." mode="do-rights">
			<xsl:with-param name="stukdeel" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']"/>
			<xsl:with-param name="endMark" select="';'"/>
		</xsl:apply-templates>
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

	Description: sns mortgage deed rights.

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
		<xsl:param name="endMark"/>
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
					<xsl:value-of select="$endMark"/>
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
					<xsl:value-of select="$endMark"/>
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
							<xsl:with-param name="endMark" select="$endMark"/>
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

	Description: svenska mortgage deed election of domicile.

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
		<!-- Election of domicile -->
		<a name="hyp3.electionOfDomicile" class="location">&#160;</a>
		<xsl:if test="$woonplaatskeuze != ''">
			<p>
				<u>
					<xsl:text>WOONPLAATSKEUZE</xsl:text>
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

	Description: svenska mortgage deed free text part.

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
	Mode: do-parties
	*********************************************************
	Public: no

	Identity transform: no

	Description: svenska mortgage deed parties.

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
	<xsl:template match="tia:Partij" mode="do-parties">
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
						or $numberOfLegalPersonPairs > 0) and not(count(tia:IMKAD_Persoon) > 1) and position() =1 ">
						<xsl:apply-templates select="tia:IMKAD_Persoon" mode="do-party-person"/>
					</xsl:when>
					<xsl:when test="count(tia:IMKAD_Persoon) = 1 and position() = 1">
						<xsl:apply-templates select="tia:IMKAD_Persoon" mode="do-party-person"/>
					</xsl:when>
					<xsl:when test="position() =1">
						<xsl:for-each select="tia:IMKAD_Persoon">
							<xsl:apply-templates select="." mode="do-party-person"/>
						</xsl:for-each>
					</xsl:when>
				</xsl:choose>
				<xsl:if test="position() = 2">
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
												<!-- Tekstblok PNNP -->
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
					<xsl:text>voor zover in deze akte niet anders aangeduid, hierna</xsl:text>
					<xsl:if test="$numberOfPersons > 1">
						<xsl:text>, zowel tezamen als ieder afzonderlijk,</xsl:text>
					</xsl:if>
					<xsl:text> te noemen de Onderzetter/Schuldenaar;</xsl:text>
				</p>
			</xsl:when>
			<xsl:when test="position() = 2">
				<p style="margin-left:30px">
					<xsl:text>hierna ook te noemen: Handelsbanken.</xsl:text>
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

	Description: svenska mortgage deed party persons.

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
</xsl:stylesheet>