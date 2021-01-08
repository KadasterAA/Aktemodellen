<?xml version="1.0" encoding="UTF-8"?>
<!--
*********************************************************
Stylesheet: hypotheek_vista.xsl
Version: 2.0.0
AA-4887 - aanpassingen in modeltekst Vista o.b.v. van nieuw bankmodel
*********************************************************


-->
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:tia="http://www.kadaster.nl/schemas/KIK/TIA_Algemeen" xmlns:kef="nl.kadaster.xslt.XslExtensionFunctions" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:gc="http://docs.oasis-open.org/codelist/ns/genericode/1.0/" exclude-result-prefixes="tia kef xsl xlink gc" version="1.0">
	<xsl:include href="generiek-1.08.xsl"/>
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
	<!-- Rabobank specific global variables -->
	<xsl:variable name="keuzeteksten" select="document('keuzeteksten_hypotheek_vista-1.0.0.xml')"/>
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

	Description: Vista mortgage deed.

	Input: tia:Bericht_TIA_Stuk

	Params: none

	Output: XHTML structure

	Calls:
	(mode) do-statement-of-equivalence
	(mode) do-mortgage-deed-title
	(mode) do-header
	(mode) do-comparitie
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
		<!-- Comparitie -->
		<xsl:apply-templates select="tia:IMKAD_AangebodenStuk/tia:Partij" mode="do-comparitie"/>
		<xsl:call-template name="lening"/>
		<xsl:call-template name="hypotheekPandrechten"/>
		<xsl:call-template name="overeenkomst"/>
		<xsl:call-template name="hypotheekverlening"/>	
		<xsl:call-template name="onderpand"/>
		<xsl:call-template name="opzegging"/>
		<xsl:call-template name="woonplaatskeuze"/>

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

	Description: Vista mortgage deed parties.

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
	<xsl:template match="tia:Partij" mode="do-comparitie">
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
											<tr>
												<td class="number" valign="top">
													<xsl:text>&#xFEFF;</xsl:text>
												</td>
												<td>
													<xsl:apply-templates select="tia:IMKAD_Persoon[tia:tia_Gegevens/tia:NHR_Rechtspersoon]" mode="do-legal-person"/>
													<xsl:if test="tia:IMKAD_Persoon[tia:tia_Gegevens/tia:NHR_Rechtspersoon]/tia:IMKAD_PostlocatiePersoon">
														<xsl:text> (correspondentieadres voor alle aangelegenheden betreffende de hierna te vermelden rechtshandelingen: </xsl:text>
														<xsl:apply-templates select="tia:IMKAD_Persoon[tia:tia_Gegevens/tia:NHR_Rechtspersoon]/tia:IMKAD_PostlocatiePersoon" mode="do-vista-correspondant-address"/>
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
			</tbody>
		</table>
		<xsl:choose>
			<xsl:when test="position() = 1">
				<p style="margin-left:30px">
					<xsl:text>voor zover in deze akte niet anders genoemd</xsl:text>
					<xsl:if test="(count(tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true']) 
						+ count(tia:IMKAD_Persoon/tia:GerelateerdPersoon[translate(tia:IMKAD_Persoon/tia:tia_IndGerechtigde, $upper, $lower) = 'true'])
						+ count(tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon[translate(tia:IMKAD_Persoon/tia:tia_IndGerechtigde, $upper, $lower) = 'true'])) > 1">
					<xsl:text> zowel samen als ieder apart</xsl:text>
				</xsl:if>
					<xsl:text>, hierna te noemen: "hypotheekgever";</xsl:text>
				</p>
			</xsl:when>
			<xsl:otherwise>
				<p style="margin-left:30px">
					<xsl:text>hierna te noemen: "geldverstrekker".</xsl:text>
				</p>
				<xsl:text>Van het bestaan van de volmacht aan de comparant onder 2. genoemd is mij, notaris, genoegzaam gebleken.</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
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
	<!-- ************* -->
	<xsl:template match="tia:IMKAD_PostlocatiePersoon" mode="do-vista-correspondant-address">
		<xsl:if test="tia:tia_label and normalize-space(tia:tia_label) != ''">
			<xsl:value-of select="tia:tia_label"/>
			<xsl:text>, </xsl:text>
		</xsl:if>
		<xsl:if test="tia:tia_afdeling and normalize-space(tia:tia_afdeling) != ''">
			<xsl:value-of select="tia:tia_afdeling"/>
			<xsl:text>, </xsl:text>
		</xsl:if>
		<xsl:apply-templates select="tia:adres/tia:postbusAdres" mode="do-vista-correspondant-address"/>
		<xsl:apply-templates select="tia:adres/tia:binnenlandsAdres
			| tia:adres/tia:buitenlandsAdres" mode="do-correspondant-address"/>
	</xsl:template>
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:postbusAdres" mode="do-vista-correspondant-address">
		<xsl:text>postbus </xsl:text>
		<xsl:value-of select="tia:postbusnummer"/>
		<xsl:text>, </xsl:text>
		<!-- Insert space between numbers and letters of post code -->
		<xsl:value-of select="concat(normalize-space(substring(tia:postcode, 1, 4)), ' ',
			normalize-space(substring(tia:postcode, 5)))"/>
		<xsl:text> </xsl:text>
		<xsl:value-of select="tia:woonplaatsnaam"/>
	</xsl:template>
<!-- ************************************* -->
	<xsl:template name="lening">
		<xsl:variable name="Datum_DATE" select="substring(string(tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek/tia:datumLeningOntvangen), 0, 11)"/>
		<xsl:variable name="Datum_STRING">
			<xsl:value-of select="kef:convertDateToText($Datum_DATE)"/>
		</xsl:variable>		
		<h3>
			<xsl:text>1. Lening</xsl:text>
		</h3>
		<p>
			<xsl:text>Geldnemer heeft op </xsl:text>
			<xsl:value-of select="$Datum_STRING"/>
			<xsl:text> een bedrag van </xsl:text>
			<xsl:call-template name="amountText">
				<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek/tia:bedragLening/tia:som"/>
				<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek/tia:bedragLening/tia:valuta"/>
			</xsl:call-template>
			<xsl:text> </xsl:text>
			<xsl:call-template name="amountNumber">
				<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek/tia:bedragLening/tia:som"/>
				<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek/tia:bedragLening/tia:valuta"/>
			</xsl:call-template>
			<xsl:text> ontvangen en is dit bedrag schuldig aan de geldverstrekker. Wie de geldnemer is, staat hierna onder debiteur.</xsl:text>
		</p>			
	</xsl:template>
<!-- ************************************* -->
	<xsl:template name="hypotheekPandrechten">
	<h3>
			<xsl:text>2. Hypotheek- en pandrechten</xsl:text>
		</h3>
		<p>
			<xsl:text>Hypotheek- en pandrechten zijn zekerheden voor de geldverstrekker. In deze akte en de algemene voorwaarden die van toepassing zijn op deze akte, staan regels waaraan de geldverstrekker en de hypotheekgever zich moeten houden.</xsl:text>
			<br/>
			<xsl:text>Hypotheek- en pandrechten geven de geldverstrekker het recht het onderpand te executeren. Executeren betekent dat de geldverstrekker het onderpand mag verkopen. En de opbrengst mag gebruiken voor wat de debiteur aan de geldverstrekker moet betalen. Executeren mag alleen in de gevallen die zijn of worden afgesproken tussen de geldverstrekker en de hypotheekgever of de debiteur. In deze akte en de algemene voorwaarden die van toepassing zijn wordt dit verder uitgewerkt.</xsl:text>
		</p>	
	</xsl:template>
<!-- ************************************* -->
	<xsl:template name="overeenkomst">
		<h3>
			<xsl:text>3. Overeenkomst tot het vestigen van hypotheek- en pandrechten</xsl:text>
		</h3>
		<p>
			<xsl:text>De hypotheekgever en de geldverstrekker hebben afgesproken dan wel spreken voor zover nodig hierbij af dat de hypotheekgever het hypotheekrecht en pandrechten aan de geldverstrekker geeft op de goederen die worden omschreven in deze akte en in de Algemene voorwaarden Vista Hypotheken die van toepassing zijn. Hierna staat waarvoor het hypotheekrecht en de pandrechten als zekerheid gelden.</xsl:text>
		</p>	
	</xsl:template>
<!-- ************************************* -->
	<xsl:template name="hypotheekverlening">
		<a name="hyp3.vistaMortgageProvision" class="location">&#160;</a>
		<h3>
			<xsl:text>4. Hypotheekverlening</xsl:text>
		</h3>
		<p>
			<xsl:text>Ter uitvoering van de afspraak om een hypotheekrecht te geven geeft de hypotheekgever een hypotheekrecht aan de geldverstrekker. Dit hypotheekrecht wordt gevestigd tot het bedrag dat hierna onder ‘Hypotheekbedrag’ staat op het onderpand dat hierna onder ‘Onderpand’ staat en indien daar meerdere onderpanden staan, op elk van de onderpanden voor het bedrag dat hierna onder 'Hypotheekbedrag' staat. Dit hypotheekrecht geldt als zekerheid voor alle schulden van de debiteur aan de geldverstrekker. Wie de debiteur is, staat hierna. Zijn er meer debiteuren? Dan geldt het hypotheekrecht als zekerheid voor de schulden van de debiteuren samen. Maar ook voor de schulden van iedere debiteur apart. Het kunnen schulden zijn die de debiteur nu al heeft en schulden die de debiteur later krijgt aan de geldverstrekker. Een schuld kan ontstaan uit elke rechtsverhouding tussen de debiteur en de geldverstrekker. Bijvoorbeeld uit geldleningen en kredieten, borgtochten of regresrechten.</xsl:text>
		</p>
		<p><u><xsl:text>Hypotheekbedrag</xsl:text></u></p>
		<p><xsl:text>De hypotheekgever geeft het hypotheekrecht tot:</xsl:text></p>
		<table>
			<tbody>
				<tr>
					<td class="number" valign="top">
						<xsl:text>1.</xsl:text>
					</td>
					<td>
						<xsl:text>een bedrag van </xsl:text>
						<xsl:call-template name="amountText">
							<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek/tia:hoofdsom/tia:som"/>
							<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek/tia:hoofdsom/tia:valuta"/>
						</xsl:call-template>
						<xsl:text> </xsl:text>
						<xsl:call-template name="amountNumber">
							<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek/tia:hoofdsom/tia:som"/>
							<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek/tia:hoofdsom/tia:valuta"/>
						</xsl:call-template>
						<xsl:text> plus</xsl:text>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>2.</xsl:text>
					</td>
					<td>
						<xsl:text>renten, vergoedingen, boeten en kosten, samen begroot op vijftig procent (50%) van het bedrag hiervoor onder 1., dat is </xsl:text>
						<xsl:call-template name="amountText">
							<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek/tia:bedragRente/tia:som"/>
							<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek/tia:bedragRente/tia:valuta"/>
						</xsl:call-template>
						<xsl:text> </xsl:text>
						<xsl:call-template name="amountNumber">
							<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek/tia:bedragRente/tia:som"/>
							<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek/tia:bedragRente/tia:valuta"/>
						</xsl:call-template>
						<xsl:text>, dus tot een totaalbedrag van </xsl:text>
						<xsl:call-template name="amountText">
							<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek/tia:bedragTotaal/tia:som"/>
							<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek/tia:bedragTotaal/tia:valuta"/>
						</xsl:call-template>
						<xsl:text> </xsl:text>
						<xsl:call-template name="amountNumber">
							<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek/tia:bedragTotaal/tia:som"/>
							<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek/tia:bedragTotaal/tia:valuta"/>
						</xsl:call-template>
						<xsl:text>, op:</xsl:text>					
					</td>
				</tr>
			</tbody>
		</table>	
	</xsl:template>	
<!-- ************************************* -->
	<xsl:template name="onderpand">
		<xsl:variable name="allProcessedRights" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek/tia:IMKAD_ZakelijkRecht"/>
		<a name="hyp3.rights" class="location">&#160;</a>
		<h3>
			<xsl:text>5. Onderpand</xsl:text>
		</h3>
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
					<xsl:text>,</xsl:text>
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
					<xsl:text>,</xsl:text>
				</p>
			</xsl:when>
			<xsl:otherwise>
				<table cellpadding="0" cellspacing="0">
					<tbody>
						<xsl:call-template name="processRights">
							<xsl:with-param name="positionOfProcessedRight" select="1"/>
							<xsl:with-param name="position" select="1"/>
							<xsl:with-param name="registeredObjects" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek"/>
							<xsl:with-param name="endMark" select="','"/>
							<xsl:with-param name="colspan" select="'2'"/>
						</xsl:call-template>
					</tbody>
				</table>
			</xsl:otherwise>
		</xsl:choose>
			<p>
					<xsl:text>hierna</xsl:text>
			<xsl:if test="translate(tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederentezamen']/tia:tekst, $upper, $lower) = 'true'">
						<xsl:text> (zowel samen als ieder apart)</xsl:text>
					</xsl:if>
					<xsl:text> te noemen: onderpand.</xsl:text>
				</p>		
	</xsl:template>
<!-- ************************** -->
	<xsl:template name="opzegging">
		<h3>
			<xsl:text>6. Opzegging</xsl:text>
		</h3>
		<p>
			<xsl:text>De geldverstrekker mag het hypotheekrecht en de pandrechten helemaal of voor een deel opzeggen. De hypotheekgever mag dit niet.</xsl:text>
		</p>	
	</xsl:template>
<!-- ************************************* -->
	<xsl:template name="woonplaatskeuze">
		<a name="hyp3.electionOfDomicile" class="location">&#160;</a>
		<xsl:if test="translate(tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_woonplaatskeuze']/tia:tekst, $upper, $lower) != ''">	
			<h3>
				<xsl:text>7. Woonplaatskeuze</xsl:text>
			</h3>
			<p>
				<xsl:value-of select="tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_woonplaatskeuze']/tia:tekst[translate(normalize-space(.), $upper, $lower)]"/>
				<xsl:text>.</xsl:text>
			</p>
		</xsl:if>	
	</xsl:template>
</xsl:stylesheet>
