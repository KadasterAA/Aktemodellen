<?xml version="1.0" encoding="UTF-8"?>
<!--
*********************************************************
Stylesheet: levering.xsl
Version: 1.93 (JIRA: AA-2366,2386)
*********************************************************
Description:
Deed of transfer.

Public:
(mode) do-deed

Private:
(mode) do-parties
(mode) do-party-person
(mode) do-party-person-indication
(mode) do-purchase-and-transfer
(mode) do-purchase-and-transfer-standaardlevering
(mode) do-purchase-and-transfer-tweeleveringen
(mode) do-purchase-and-transfer-verkooprechtenmetcessie
(mode) do-purchase-and-transfer-verkooprechtenmetindeplaatsstelling
(mode) do-purchase-and-transfer-objects
(mode) do-registered-objects-deed-of-transfer
(mode) do-purchase-registration
(mode) do-purchase-price
(mode) do-purchase-option
(mode) do-easements
(mode) do-qualitative-obligations
(mode) do-common-ownership
(mode) do-energy-performance-certificate
(mode) do-election-of-domicile
(mode) do-purchase-distribution-paragraph-part
(mode) do-distribution-person-name
(mode) do-distribution-part
(mode) do-get-serial-number
(name) capitalizePartyAlias
(name) groupParcels
(name) groupApartments
-->
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:tia="http://www.kadaster.nl/schemas/KIK/TIA_Algemeen" xmlns:kef="nl.kadaster.xslt.XslExtensionFunctions" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exslt="http://exslt.org/common" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:gc="http://docs.oasis-open.org/codelist/ns/genericode/1.0/" exclude-result-prefixes="tia kef xsl exslt xlink gc" version="1.0">
	<xsl:include href="generiek-1.08.xsl"/>
	<xsl:include href="tekstblok_aanhef-1.17.xsl"/>
	<xsl:include href="tekstblok_burgerlijke_staat-1.01.xsl"/>
	<xsl:include href="tekstblok_equivalentieverklaring-1.25.xsl"/>
	<xsl:include href="tekstblok_erfpachtcanon-1.11.xsl"/>
	<xsl:include href="tekstblok_gevolmachtigde-1.25.xsl"/>
	<xsl:include href="tekstblok_legitimatie-1.01.xsl"/>
	<xsl:include href="tekstblok_personalia_van_natuurlijk_persoon-1.06.xsl"/>
	<xsl:include href="tekstblok_natuurlijk_persoon-1.12.xsl"/>
	<xsl:include href="tekstblok_partij_natuurlijk_persoon-1.39.xsl"/>
	<xsl:include href="tekstblok_partij_niet_natuurlijk_persoon-1.51.xsl"/>
	<xsl:include href="tekstblok_recht-1.16.xsl"/>
	<xsl:include href="tekstblok_rechtspersoon-1.13.xsl"/>
	<xsl:include href="tekstblok_registergoed-1.26.xsl"/>
	<xsl:include href="tekstblok_woonadres-1.05.xsl"/>
	<xsl:include href="tekstblok_deel_nummer-1.03.xsl"/>
	<xsl:include href="tweededeel-1.05.xsl"/>
	<!-- Levering specific global variables -->
	<xsl:variable name="keuzeteksten" select="document('keuzeteksten-levering-1.39.xml')"/>
	<xsl:variable name="legalPersonNames" select="document('nnp-kodes_levering.xml')/gc:CodeList/SimpleCodeList/Row"/>
	<xsl:variable name="documentTitle">
		<xsl:choose>
			<xsl:when test="tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_titellevering']/tia:tekst and
							normalize-space(tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_titellevering']/tia:tekst) != ''">
				<xsl:choose>
					<xsl:when test="translate(tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_titellevering']/tia:tekst, $upper, $lower) = 'levering adres'">
						<xsl:choose>
							<xsl:when test="tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:StukdeelLevering/tia:IMKAD_ZakelijkRecht[1]/*/tia:IMKAD_OZLocatie">
								<xsl:text>LEVERING </xsl:text>
								<xsl:value-of select="tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:StukdeelLevering/tia:IMKAD_ZakelijkRecht[1]/*/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam"/>
								<xsl:if test="tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:StukdeelLevering/tia:IMKAD_ZakelijkRecht[1]/*/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer
										and normalize-space(tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:StukdeelLevering/tia:IMKAD_ZakelijkRecht[1]/*/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer) != ''">
									<xsl:text> </xsl:text>
									<xsl:value-of select="tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:StukdeelLevering/tia:IMKAD_ZakelijkRecht[1]/*/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer"/>
								</xsl:if>
								<xsl:if test="tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:StukdeelLevering/tia:IMKAD_ZakelijkRecht[1]/*/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter
										and normalize-space(tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:StukdeelLevering/tia:IMKAD_ZakelijkRecht[1]/*/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter) != ''">
									<xsl:text> </xsl:text>
									<xsl:value-of select="tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:StukdeelLevering/tia:IMKAD_ZakelijkRecht[1]/*/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter"/>
								</xsl:if>
								<xsl:if test="tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:StukdeelLevering/tia:IMKAD_ZakelijkRecht[1]/*/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging
										and normalize-space(tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:StukdeelLevering/tia:IMKAD_ZakelijkRecht[1]/*/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging) != ''">
									<xsl:text> </xsl:text>
									<xsl:value-of select="tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:StukdeelLevering/tia:IMKAD_ZakelijkRecht[1]/*/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging"/>
								</xsl:if>
								<xsl:text> te </xsl:text>
								<xsl:value-of select="tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:StukdeelLevering/tia:IMKAD_ZakelijkRecht[1]/*/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam"/>
							</xsl:when>
							<xsl:when test="tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:StukdeelLevering/tia:IMKAD_ZakelijkRecht">
								<xsl:text>LEVERING</xsl:text>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_titellevering']/tia:tekst"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_titellevering']/tia:tekst"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="RegistergoedTonenPerPerceel">
		<xsl:choose>
			<xsl:when test="tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:StukdeelLevering/tia:IMKAD_ZakelijkRecht/tia:tia_BedragKoopprijs/tia:som != ''">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:when test="tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedtonenperperceel']">
				<xsl:value-of select="translate(tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedtonenperperceel']/tia:tekst, $upper, $lower)"/>
			</xsl:when>
			<xsl:otherwise>false</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="SoortLevering">
		<xsl:value-of select="tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:tia_StukVariant"/>
	</xsl:variable>
	<!--
	*********************************************************
	Mode: do-deed
	*********************************************************
	Public: yes

	Identity transform: no

	Description: Deed of transfer.

	Input: tia:Bericht_TIA_Stuk

	Params: none

	Output: XHTML structure

	Calls:
	(mode) do-statement-of-equivalence
	(mode) do-header
	(mode) do-parties
	(mode) do-purchase-and-transfer
	(mode) do-purchase-registration
	(mode) do-purchase-price
	(mode) do-purchase-option
	(mode) do-easements
	(mode) do-qualitative-obligations
	(mode) do-common-ownership
	(mode) do-energy-performance-certificate
	(mode) do-election-of-domicile
	(mode) do-free-text
	(mode) do-long-lease-ground-rent

	Called by:
	Root template
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:Bericht_TIA_Stuk" mode="do-deed">
		<xsl:variable name="handelend" select="tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_handelend']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_handelend']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space(current()/tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_handelend']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
		<!-- Text block Statement of equivalence -->
		<xsl:if test="$type-document = 'AFSCHRIFT'">
			<a name="hyp4.statementOfEquivalence" class="location">&#160;</a>
			<xsl:apply-templates select="tia:IMKAD_AangebodenStuk" mode="do-statement-of-equivalence">
				<xsl:with-param name="punctuationMark" select="';'"/>
			</xsl:apply-templates>
			<!-- Two empty lines after Statement of equivalence -->
			<p>
				<br/>
			</p>
			<p>
				<br/>
			</p>
		</xsl:if>
		<a name="hyp4.header" class="location">&#160;</a>
		<!-- Document title -->
		<xsl:if test="normalize-space($documentTitle) != ''">
			<p style="text-align:center" title="without_dashes">
				<xsl:value-of select="$documentTitle"/>
			</p>
			<!-- Empty line after title -->
			<p title="without_dashes">
				<br/>
			</p>
		</xsl:if>
		<xsl:if test="tia:IMKAD_AangebodenStuk/tia:tia_OmschrijvingKenmerk
				and normalize-space(tia:IMKAD_AangebodenStuk/tia:tia_OmschrijvingKenmerk) != ''">
			<p title="without_dashes">
				<xsl:text>Kenmerk: </xsl:text>
				<xsl:value-of select="tia:IMKAD_AangebodenStuk/tia:tia_OmschrijvingKenmerk"/>
			</p>
			<!-- Empty line after Kenmerk -->
			<p title="without_dashes">
				<br/>
			</p>
		</xsl:if>
		<!-- Text block Header -->
		<xsl:apply-templates select="tia:IMKAD_AangebodenStuk" mode="do-header"/>
		<!-- Parties -->
		<xsl:apply-templates select="tia:IMKAD_AangebodenStuk/tia:Partij" mode="do-parties"/>
		<xsl:variable name="aantalVerschenenGevolmachtigden">
			<xsl:value-of select="(count(tia:IMKAD_AangebodenStuk/tia:Partij/tia:Gevolmachtigde) + count(tia:IMKAD_AangebodenStuk/tia:Partij/tia:Gevolmachtigde/tia:GerelateerdPersoon))"/>
		</xsl:variable>
		<xsl:variable name="aantalVerschenenNP">
			<xsl:value-of select="(count(tia:IMKAD_AangebodenStuk/tia:Partij[not(tia:Gevolmachtigde)]//tia:IMKAD_Persoon/tia:tia_Gegevens/tia:GBA_Ingezetene) + 		count(tia:IMKAD_AangebodenStuk/tia:Partij[not(tia:Gevolmachtigde)]//tia:IMKAD_Persoon/tia:tia_Gegevens/tia:IMKAD_NietIngezetene))"/>
		</xsl:variable>
		<xsl:variable name="aantalPartijen">
			<xsl:value-of select="count(tia:IMKAD_AangebodenStuk/tia:Partij)"/>
		</xsl:variable>
		<p>
			<xsl:text>De verschenen </xsl:text>
			<xsl:choose>
				<xsl:when test="$aantalPartijen = 1 and ($aantalVerschenenGevolmachtigden = 1 or $aantalVerschenenNP = 1)">
					<xsl:text>persoon </xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>personen </xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:if test="$handelend != ''">
				<xsl:value-of select="$handelend"/>
			</xsl:if>
			<xsl:text> verklaarde</xsl:text>
			<xsl:choose>
				<xsl:when test="$aantalPartijen = 1 and ($aantalVerschenenGevolmachtigden = 1 or $aantalVerschenenNP = 1)">
					<xsl:text>: </xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>n: </xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</p>
		<!-- Purchase and transfer -->
		<xsl:apply-templates select="tia:IMKAD_AangebodenStuk" mode="do-purchase-and-transfer"/>
		<!-- Purchase registration -->
		<xsl:apply-templates select="tia:IMKAD_AangebodenStuk" mode="do-purchase-registration"/>
		<!-- Purchase price -->
		<xsl:apply-templates select="tia:IMKAD_AangebodenStuk" mode="do-purchase-price"/>
		<!-- Assignment directors association of owners -->
		<xsl:apply-templates select="tia:IMKAD_AangebodenStuk" mode="do-assignment-directors-associattion-of-owners"/>
		<!-- Long lease ground rent -->
		<xsl:if test="tia:IMKAD_AangebodenStuk/tia:StukdeelErfpachtcanon or tia:IMKAD_AangebodenStuk/tia:StukdeelErfpachtcanonTijdelijkAfgekocht or tia:IMKAD_AangebodenStuk/tia:StukdeelErfpachtcanonEeuwigAfgekocht">
			<a name="hyp4.rentCharge" class="location">&#160;</a>
			<h2 class="header">
				<xsl:text>ERFPACHTCANON</xsl:text>
			</h2>
			<xsl:apply-templates select="tia:IMKAD_AangebodenStuk/tia:StukdeelErfpachtcanon | tia:IMKAD_AangebodenStuk/tia:StukdeelErfpachtcanonTijdelijkAfgekocht | tia:IMKAD_AangebodenStuk/tia:StukdeelErfpachtcanonEeuwigAfgekocht" mode="do-long-lease-ground-rent">
				<xsl:with-param name="rights" select="tia:IMKAD_AangebodenStuk/tia:StukdeelLevering/tia:IMKAD_ZakelijkRecht"/>
			</xsl:apply-templates>
		</xsl:if>
		<!-- Purchase option -->
		<xsl:apply-templates select="tia:IMKAD_AangebodenStuk" mode="do-purchase-option"/>
		<!-- Easements -->
		<xsl:apply-templates select="tia:IMKAD_AangebodenStuk" mode="do-easements"/>
		<!-- Qualitative obligations -->
		<xsl:apply-templates select="tia:IMKAD_AangebodenStuk" mode="do-qualitative-obligations"/>
		<!-- Common ownership -->
		<xsl:apply-templates select="tia:IMKAD_AangebodenStuk" mode="do-common-ownership"/>
		<!-- Energy performance certificate -->
		<xsl:apply-templates select="tia:IMKAD_AangebodenStuk" mode="do-energy-performance-certificate"/>
		<!-- Election of domicile -->
		<xsl:apply-templates select="tia:IMKAD_AangebodenStuk" mode="do-election-of-domicile"/>
		<h3>
			<xsl:text>EINDE KADASTERDEEL</xsl:text>
		</h3>
		<!-- Free text part -->
		<a name="hyp4.part2" class="location">&#160;</a>
		<xsl:apply-templates select="tia:IMKAD_AangebodenStuk/tia:tia_TekstTweedeDeel" mode="do-free-text"/>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-parties
	*********************************************************
	Public: no

	Identity transform: no

	Description: Deed of transfer parties.

	Input: tia:Partij

	Params: none

	Output: XHTML structure

	Calls:
	(mode) do-legal-representative
	(mode) do-party-person
	(mode) do-party-person-indication

	Called by:
	(mode) do-deed
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:Partij" mode="do-parties">
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
											<xsl:text>:</xsl:text>
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
						<xsl:apply-templates select="tia:IMKAD_Persoon" mode="do-party-person"/>
						<xsl:apply-templates select="tia:IMKAD_Persoon" mode="do-party-person-indication"/>
					</xsl:when>
					<xsl:when test="count(tia:IMKAD_Persoon) = 1">
						<xsl:apply-templates select="tia:IMKAD_Persoon" mode="do-party-person"/>
						<xsl:apply-templates select="tia:IMKAD_Persoon" mode="do-party-person-indication"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:for-each select="tia:IMKAD_Persoon">
							<xsl:apply-templates select="." mode="do-party-person"/>
							<xsl:apply-templates select="." mode="do-party-person-indication"/>
						</xsl:for-each>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:if test="tia:aanduidingPartij != 'Aanduiding per gerelateerde partij'">
					<xsl:if test="tia:IndRegistergoedBewonen = 'true'">
						<tr>
							<td>
								<table>
									<tbody>
										<tr>
											<td class="number" valign="top">
												<xsl:text>&#xFEFF;</xsl:text>
											</td>
											<td>
												<xsl:text>en voornemens het hierna te vermelden registergoed te gaan bewonen,</xsl:text>
											</td>
										</tr>
									</tbody>
								</table>
							</td>
						</tr>
					</xsl:if>
					<tr>
						<td>
							<table>
								<tbody>
									<tr>
										<td class="number" valign="top">
											<xsl:text>&#xFEFF;</xsl:text>
										</td>
										<td>
											<xsl:text>hierna </xsl:text>
											<xsl:if test="$numberOfPersons > 1">
												<xsl:text>zowel tezamen als ieder afzonderlijk </xsl:text>
											</xsl:if>
											<xsl:text>te noemen: "</xsl:text>
											<u>
												<xsl:value-of select="tia:aanduidingPartij"/>
											</u>
											<xsl:text>"</xsl:text>
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
								</tbody>
							</table>
						</td>
					</tr>
				</xsl:if>
			</tbody>
		</table>
		<xsl:if test="position() != last()">
			<p style="margin-left:30px">
				<xsl:text>en</xsl:text>
			</p>
		</xsl:if>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-party-person
	*********************************************************
	Public: no

	Identity transform: no

	Description: Deed of transfer party persons.

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
	*********************************************************
	Mode: do-party-person-indication
	*********************************************************
	Public: no

	Identity transform: no

	Description: Deed of transfer party persons indication on person(s) level.

	Input: tia:IMKAD_Persoon

	Params: none

	Output: XHTML structure

	Calls:
	(mode) do-gender-salutation

	Called by:
	(mode) do-parties
	-->
	<!--
	**** matching template ********************************************************************************
	**** NATURAL PERSON    ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon" mode="do-party-person-indication">
		<xsl:variable name="currentPerson" select="."/>
		<xsl:variable name="onlyPersonInParty">
			<xsl:choose>
				<xsl:when test="(count(preceding-sibling::tia:IMKAD_Persoon) + count(following-sibling::tia:IMKAD_Persoon)) = 0">
					<xsl:text>true</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>false</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:if test="../tia:Partij[substring-after(tia:partijPersoonRef/@xlink:href, '#') = $currentPerson/@id
							or substring-after(tia:partijPersoonRef/@xlink:href, '#') = $currentPerson/tia:GerelateerdPersoon/tia:IMKAD_Persoon/@id
							or substring-after(tia:partijPersoonRef/@xlink:href, '#') = $currentPerson/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon/@id]">
			<xsl:for-each select="../tia:Partij[substring-after(tia:partijPersoonRef/@xlink:href, '#') = $currentPerson/@id
							or substring-after(tia:partijPersoonRef/@xlink:href, '#') = $currentPerson/tia:GerelateerdPersoon/tia:IMKAD_Persoon/@id
							or substring-after(tia:partijPersoonRef/@xlink:href, '#') = $currentPerson/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon/@id]">
				<xsl:variable name="relatedParty" select="."/>
				<xsl:variable name="currentPersonInIteration" select="../../tia:Partij/tia:IMKAD_Persoon[@id = substring-after($relatedParty/tia:partijPersoonRef/@xlink:href, '#')]"/>
				<tr>
					<td>
						<table>
							<tbody>
								<tr>
									<td class="number" valign="top">
										<xsl:text>&#xFEFF;</xsl:text>
									</td>
									<xsl:if test="$onlyPersonInParty = 'false'">
										<td class="number" valign="top">
											<xsl:text>&#xFEFF;</xsl:text>
										</td>
									</xsl:if>
									<td>
										<xsl:if test="$relatedParty/tia:IndRegistergoedBewonen = 'true'">
											<xsl:text>en voornemens het hierna te vermelden registergoed te gaan bewonen,</xsl:text>
											<br/>
										</xsl:if>
										<xsl:for-each select="$relatedParty/tia:partijPersoonRef">
											<xsl:variable name="relatedPersonReferenced">
												<xsl:choose>
													<xsl:when test="$currentPersonInIteration/@id = substring-after(@xlink:href, '#')">
														<xsl:text>false</xsl:text>
													</xsl:when>
													<xsl:otherwise>
														<xsl:text>true</xsl:text>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:variable>
											<xsl:choose>
												<xsl:when test="$relatedPersonReferenced = 'true'">
													<xsl:variable name="currentlyProcessedRelatedPerson" select="$currentPerson/tia:GerelateerdPersoon/tia:IMKAD_Persoon/descendant-or-self::tia:IMKAD_Persoon[@id = substring-after(current()/@xlink:href, '#')]"/>
													<xsl:choose>
														<xsl:when test="$currentlyProcessedRelatedPerson/tia:tia_Gegevens/tia:GBA_Ingezetene or $currentlyProcessedRelatedPerson/tia:tia_Gegevens/tia:IMKAD_NietIngezetene">
															<xsl:apply-templates select="$currentlyProcessedRelatedPerson/tia:tia_Gegevens/tia:GBA_Ingezetene | $currentlyProcessedRelatedPerson/tia:tia_Gegevens/tia:IMKAD_NietIngezetene" mode="do-gender-salutation"/>
															<xsl:text> </xsl:text>
															<xsl:choose>
																<xsl:when test="$currentlyProcessedRelatedPerson/tia:tia_Gegevens/tia:IMKAD_KadNatuurlijkPersoon and $currentlyProcessedRelatedPerson/tia:tia_Gegevens/tia:GBA_Ingezetene">
																	<xsl:value-of select="$currentlyProcessedRelatedPerson/tia:tia_Gegevens/tia:IMKAD_KadNatuurlijkPersoon/tia:voornamen"/>
																	<xsl:if test="$currentlyProcessedRelatedPerson/tia:tia_Gegevens/tia:IMKAD_KadNatuurlijkPersoon/tia:voorvoegselsgeslachtsnaam
																			and normalize-space($currentlyProcessedRelatedPerson/tia:tia_Gegevens/tia:IMKAD_KadNatuurlijkPersoon/tia:voorvoegselsgeslachtsnaam) != ''">
																		<xsl:text> </xsl:text>
																		<xsl:value-of select="$currentlyProcessedRelatedPerson/tia:tia_Gegevens/tia:IMKAD_KadNatuurlijkPersoon/tia:voorvoegselsgeslachtsnaam"/>
																	</xsl:if>
																	<xsl:text> </xsl:text>
																	<xsl:value-of select="$currentlyProcessedRelatedPerson/tia:tia_Gegevens/tia:IMKAD_KadNatuurlijkPersoon/tia:geslachtsnaam"/>
																</xsl:when>
																<xsl:otherwise>
																	<xsl:value-of select="$currentlyProcessedRelatedPerson/tia:tia_Gegevens/tia:GBA_Ingezetene/tia:naam/tia:voornamen | $currentlyProcessedRelatedPerson/tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:voornamen"/>
																	<xsl:text> </xsl:text>
																	<xsl:if test="normalize-space($currentlyProcessedRelatedPerson/tia:tia_Gegevens/tia:GBA_Ingezetene/tia:tia_VoorvoegselsNaam) != ''">
																		<xsl:value-of select="$currentlyProcessedRelatedPerson/tia:tia_Gegevens/tia:GBA_Ingezetene/tia:tia_VoorvoegselsNaam"/>
																		<xsl:text> </xsl:text>
																	</xsl:if>
																	<xsl:if test="normalize-space($currentlyProcessedRelatedPerson/tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:voorvoegsels) != ''">
																		<xsl:value-of select="$currentlyProcessedRelatedPerson/tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:voorvoegsels"/>
																		<xsl:text> </xsl:text>
																	</xsl:if>
																	<xsl:value-of select="$currentlyProcessedRelatedPerson/tia:tia_Gegevens/tia:GBA_Ingezetene/tia:tia_NaamZonderVoorvoegsels | $currentlyProcessedRelatedPerson/tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:geslachtsnaam"/>
																</xsl:otherwise>
															</xsl:choose>
														</xsl:when>
														<xsl:when test="$currentlyProcessedRelatedPerson/tia:tia_Gegevens/tia:NHR_Rechtspersoon">
															<xsl:choose>
																<xsl:when test="$currentlyProcessedRelatedPerson/tia:tia_AanduidingPersoon">
																	<xsl:value-of select="$currentlyProcessedRelatedPerson/tia:tia_AanduidingPersoon"/>
																</xsl:when>
																<xsl:otherwise>
																	<xsl:value-of select="$currentlyProcessedRelatedPerson/tia:tia_Gegevens/tia:NHR_Rechtspersoon/tia:statutaireNaam"/>
																</xsl:otherwise>
															</xsl:choose>
														</xsl:when>
													</xsl:choose>
												</xsl:when>
												<xsl:when test="$relatedPersonReferenced = 'false'">
													<xsl:choose>
														<xsl:when test="$currentPersonInIteration/tia:tia_Gegevens/tia:GBA_Ingezetene or $currentPersonInIteration/tia:tia_Gegevens/tia:IMKAD_NietIngezetene">
															<xsl:apply-templates select="$currentPersonInIteration/tia:tia_Gegevens/tia:GBA_Ingezetene | $currentPersonInIteration/tia:tia_Gegevens/tia:IMKAD_NietIngezetene" mode="do-gender-salutation"/>
															<xsl:text> </xsl:text>
															<xsl:choose>
																<xsl:when test="$currentPersonInIteration/tia:tia_Gegevens/tia:IMKAD_KadNatuurlijkPersoon and $currentPersonInIteration/tia:tia_Gegevens/tia:GBA_Ingezetene">
																	<xsl:value-of select="$currentPersonInIteration/tia:tia_Gegevens/tia:IMKAD_KadNatuurlijkPersoon/tia:voornamen"/>
																	<xsl:if test="$currentPersonInIteration/tia:tia_Gegevens/tia:IMKAD_KadNatuurlijkPersoon/tia:voorvoegselsgeslachtsnaam
																			and normalize-space($currentPersonInIteration/tia:tia_Gegevens/tia:IMKAD_KadNatuurlijkPersoon/tia:voorvoegselsgeslachtsnaam) != ''">
																		<xsl:text> </xsl:text>
																		<xsl:value-of select="$currentPersonInIteration/tia:tia_Gegevens/tia:IMKAD_KadNatuurlijkPersoon/tia:voorvoegselsgeslachtsnaam"/>
																	</xsl:if>
																	<xsl:text> </xsl:text>
																	<xsl:value-of select="$currentPersonInIteration/tia:tia_Gegevens/tia:IMKAD_KadNatuurlijkPersoon/tia:geslachtsnaam"/>
																</xsl:when>
																<xsl:otherwise>
																	<xsl:value-of select="$currentPersonInIteration/tia:tia_Gegevens/tia:GBA_Ingezetene/tia:naam/tia:voornamen | $currentPersonInIteration/tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:voornamen"/>
																	<xsl:text> </xsl:text>
																	<xsl:if test="normalize-space($currentPersonInIteration/tia:tia_Gegevens/tia:GBA_Ingezetene/tia:tia_VoorvoegselsNaam) != ''">
																		<xsl:value-of select="$currentPersonInIteration/tia:tia_Gegevens/tia:GBA_Ingezetene/tia:tia_VoorvoegselsNaam"/>
																		<xsl:text> </xsl:text>
																	</xsl:if>
																	<xsl:if test="normalize-space($currentPersonInIteration/tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:voorvoegsels) != ''">
																		<xsl:value-of select="$currentPersonInIteration/tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:voorvoegsels"/>
																		<xsl:text> </xsl:text>
																	</xsl:if>
																	<xsl:value-of select="$currentPersonInIteration/tia:tia_Gegevens/tia:GBA_Ingezetene/tia:tia_NaamZonderVoorvoegsels | $currentPersonInIteration/tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:geslachtsnaam"/>
																</xsl:otherwise>
															</xsl:choose>
														</xsl:when>
														<xsl:when test="$currentPersonInIteration/tia:tia_Gegevens/tia:NHR_Rechtspersoon">
															<xsl:choose>
																<xsl:when test="$currentPersonInIteration/tia:tia_AanduidingPersoon">
																	<xsl:value-of select="$currentPersonInIteration/tia:tia_AanduidingPersoon"/>
																</xsl:when>
																<xsl:otherwise>
																	<xsl:value-of select="$currentPersonInIteration/tia:tia_Gegevens/tia:NHR_Rechtspersoon/tia:statutaireNaam"/>
																</xsl:otherwise>
															</xsl:choose>
														</xsl:when>
													</xsl:choose>
												</xsl:when>
											</xsl:choose>
											<xsl:choose>
												<xsl:when test="position() = last() - 1">
													<xsl:text> en </xsl:text>
												</xsl:when>
												<xsl:when test="position() != last()">
													<xsl:text>, </xsl:text>
												</xsl:when>
											</xsl:choose>
										</xsl:for-each>
										<xsl:text> hierna </xsl:text>
										<xsl:if test="count($relatedParty/tia:partijPersoonRef) > 1">
											<xsl:text>zowel tezamen als ieder afzonderlijk </xsl:text>
										</xsl:if>
										<xsl:text>te noemen: "</xsl:text>
										<u>
											<xsl:value-of select="$relatedParty/tia:aanduidingPartij"/>
										</u>
										<xsl:text>";</xsl:text>
									</td>
								</tr>
							</tbody>
						</table>
					</td>
				</tr>
			</xsl:for-each>
		</xsl:if>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-purchase-and-transfer
	*********************************************************
	Public: no

	Identity transform: no

	Description: Deed of transfer purchase and transfer blocks.

	Input: tia:IMKAD_AangebodenStuk

	Params: none

	Output: XHTML structure

	Calls:
	(mode) do-purchase-and-transfer-standaardlevering
	(mode) do-purchase-and-transfer-tweeleveringen
	(mode) do-purchase-and-transfer-verkooprechtenmetcessie
	(mode) do-purchase-and-transfer-verkooprechtenmetindeplaatsstelling
	(mode) do-purchase-and-transfer-objects

	Called by:
	(mode) do-deed
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_AangebodenStuk" mode="do-purchase-and-transfer">
		<a name="hyp4.purchaseTransferType" class="location">&#160;</a>
		<xsl:choose>
			<xsl:when test="translate(tia:tia_StukVariant, $upper, $lower) = 'standaardlevering'">
				<xsl:apply-templates select="." mode="do-purchase-and-transfer-standaardlevering"/>
			</xsl:when>
			<xsl:when test="translate(tia:tia_StukVariant, $upper, $lower) = 'twee leveringen'">
				<xsl:apply-templates select="." mode="do-purchase-and-transfer-tweeleveringen"/>
			</xsl:when>
			<xsl:when test="translate(tia:tia_StukVariant, $upper, $lower) = 'verkoop rechten met cessie'">
				<xsl:apply-templates select="." mode="do-purchase-and-transfer-verkooprechtenmetcessie"/>
			</xsl:when>
			<xsl:when test="translate(tia:tia_StukVariant, $upper, $lower) = 'verkoop rechten met indeplaatsstelling'">
				<xsl:apply-templates select="." mode="do-purchase-and-transfer-verkooprechtenmetindeplaatsstelling"/>
			</xsl:when>
			<xsl:when test="tia:StukdeelLevering[tia:IMKAD_ZakelijkRecht]">
				<xsl:apply-templates select="." mode="do-purchase-and-transfer-objects"/>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-purchase-distribution-paragraph-part
	*********************************************************
	Public: no

	Identity transform: no

	Description: Deed of transfer purchase distribution blocks - paragraph part.

	Input: tia:IMKAD_AangebodenStuk

	Params: numberOfBuyers - total number of persons that act as buyer
			undivided - static text
			acquirerParty - party that acts as acquirer

	Output: text

	Calls:
	(mode) do-gender-salutation
	(mode) do-distribution-person-name
	(mode) do-distribution-part

	Called by:
	(mode) do-purchase-and-transfer-standaardlevering
	(mode) do-purchase-and-transfer-tweeleveringen
	(mode) do-purchase-and-transfer-verkooprechtenmetcessie
	(mode) do-purchase-and-transfer-verkooprechtenmetindeplaatsstelling
	(mode) do-purchase-and-transfer-objects
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_AangebodenStuk" mode="do-purchase-distribution-paragraph-part">
		<xsl:param name="numberOfBuyers" select="''"/>
		<xsl:param name="undivided" select="''"/>
		<xsl:param name="acquirerParty" select="self::node()[false()]"/>
		<xsl:param name="acquirerPersons" select="self::node()[false()]"/>
		<xsl:variable name="gevoltmachtigdePerParty" select="$acquirerParty/tia:Gevolmachtigde"/>
		<xsl:variable name="hoedanigheidOfAcquirerPerson" select="tia:Partij/tia:Hoedanigheid[tia:wordtVertegenwoordigdRef/@xlink:href = concat('#',$acquirerPersons[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true'][1]/@id)]"/>
		<xsl:variable name="gevoltmachtigdePerPerson" select="tia:Partij/tia:Gevolmachtigde[substring-after(tia:vertegenwoordigtRef/@xlink:href, '#') = $hoedanigheidOfAcquirerPerson/@id]"/>
		<xsl:variable name="parentNode" select="."/>
		<xsl:variable name="acquirerPartyHasAuthorizedRepresentative">
			<xsl:choose>
				<xsl:when test="$acquirerParty/tia:Gevolmachtigde">
					<xsl:text>true</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>false</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="partyMariatalStatusText" select="$acquirerParty/tia:IMKAD_Persoon/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_burgerlijkestaattekstpartners']/tia:tekst"/>
		<xsl:variable name="personMariatalStatusText" select="$acquirerPersons[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true'][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_burgerlijkestaattekstpartners']/tia:tekst"/>
		<xsl:choose>
			<!-- Variant 2: Unequal shares -->
			<xsl:when test="(count($acquirerParty/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true']/tia:tia_AandeelInRechten)
							+ count($acquirerParty/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true']/tia:tia_AandeelInRechten)
							+ count($acquirerParty/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true']/tia:tia_AandeelInRechten)) > 0 or
							(count($acquirerPersons[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true']/tia:tia_AandeelInRechten)
							+ count($acquirerPersons/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true']/tia:tia_AandeelInRechten)
							+ count($acquirerPersons/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true']/tia:tia_AandeelInRechten)) > 0">
				<xsl:choose>
					<xsl:when test="$acquirerParty">
						<xsl:choose>
							<xsl:when test="count($acquirerParty/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true'])
										+ count($acquirerParty/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true'])
										+ count($acquirerParty/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true']) = 1">
								<xsl:choose>
									<xsl:when test="translate($acquirerPartyHasAuthorizedRepresentative, $upper, $lower) = 'false'">
										<xsl:apply-templates select="$acquirerParty/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true']" mode="do-distribution-person-name"/>
										<xsl:text> voornoemd, die hierbij aanvaardt het </xsl:text>
										<xsl:value-of select="kef:convertNumberToText(string($acquirerParty/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true']/tia:tia_AandeelInRechten/tia:teller))"/>
										<xsl:text>/</xsl:text>
										<xsl:value-of select="kef:convertOrdinalToText(string($acquirerParty/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true']/tia:tia_AandeelInRechten/tia:noemer))"/>
										<xsl:text> (</xsl:text>
										<xsl:value-of select="$acquirerParty/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true']/tia:tia_AandeelInRechten/tia:teller"/>
										<xsl:text>/</xsl:text>
										<xsl:value-of select="$acquirerParty/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true']/tia:tia_AandeelInRechten/tia:noemer"/>
										<xsl:text>) </xsl:text>
										<xsl:text> onverdeeld aandeel</xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:apply-templates select="$acquirerParty" mode="do-gevoltmachtigde-per-party">
											<xsl:with-param name="gevoltmachtigdePerParty" select="$gevoltmachtigdePerParty"/>
										</xsl:apply-templates>
										<xsl:apply-templates select="$acquirerParty/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true']" mode="do-distribution-person-name"/>
										<xsl:apply-templates select="$acquirerParty/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true']" mode="do-distribution-part"/>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:choose>
									<xsl:when test="(count(../tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true'])
														+ count(../tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true']))= 0">
										<xsl:text> in:</xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text>; en aan</xsl:text>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:when>
							<xsl:when test="$acquirerParty/tia:Gevolmachtigde[substring-after(tia:vertegenwoordigtRef/@xlink:href, '#') = $acquirerParty/tia:Hoedanigheid[tia:wordtVertegenwoordigdRef]/@id]">
								<xsl:variable name="countPersons" select="count($acquirerParty/descendant::tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true'])"/>
								<!-- IMKAD_Persoon NOT represented by the Gevolmachtigde -->
								<table cellspacing="0" cellpadding="0">
									<tbody>
										<xsl:for-each select="$acquirerParty/descendant::tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true']">
											<xsl:variable name="position" select="position()"/>
											<xsl:variable name="last" select="last()"/>
											<xsl:variable name="personId" select="@id"/>
											<xsl:if test="not($acquirerParty/tia:Gevolmachtigde[substring-after(tia:vertegenwoordigtRef/@xlink:href, '#') = $acquirerParty/tia:Hoedanigheid[tia:wordtVertegenwoordigdRef[@xlink:href=concat('#', $personId)]]/@id])">
												<tr>
													<xsl:if test="$countPersons > 1">
														<td class="number" valign="top">
															<xsl:text>-</xsl:text>
														</td>
													</xsl:if>
													<td>
														<xsl:choose>
															<xsl:when test="translate($acquirerPartyHasAuthorizedRepresentative, $upper, $lower) = 'false'">
																<xsl:apply-templates select="." mode="do-distribution-person-name"/>
																<xsl:text> voornoemd, die hierbij aanvaardt het </xsl:text>
																<xsl:value-of select="kef:convertNumberToText(string(tia:tia_AandeelInRechten/tia:teller))"/>
																<xsl:text>/</xsl:text>
																<xsl:value-of select="kef:convertOrdinalToText(string(tia:tia_AandeelInRechten/tia:noemer))"/>
																<xsl:text> (</xsl:text>
																<xsl:value-of select="tia:tia_AandeelInRechten/tia:teller"/>
																<xsl:text>/</xsl:text>
																<xsl:value-of select="tia:tia_AandeelInRechten/tia:noemer"/>
																<xsl:text>) </xsl:text>
																<xsl:text> onverdeeld aandeel </xsl:text>
															</xsl:when>
															<xsl:otherwise>
																<xsl:apply-templates select="." mode="do-distribution-person-name"/>
																<xsl:apply-templates select="." mode="do-distribution-part"/>
															</xsl:otherwise>
														</xsl:choose>
														<xsl:choose>
															<xsl:when test="position() = last() and
																	not($acquirerParty/tia:Gevolmachtigde)">
																<xsl:text> in:</xsl:text>
															</xsl:when>
															<xsl:otherwise>
																<xsl:text>; en aan </xsl:text>
															</xsl:otherwise>
														</xsl:choose>
													</td>
												</tr>
											</xsl:if>
										</xsl:for-each>
									</tbody>
								</table>
								<!-- IMKAD_Persoon represented by the Gevolmachtigde -->
								<table cellspacing="0" cellpadding="0">
									<tbody>
										<xsl:for-each select="$acquirerParty/tia:Gevolmachtigde">
											<xsl:variable name="isCurrentlyProcessedGevolmachtigdeLastOne">
												<xsl:choose>
													<xsl:when test="position() = last()">
														<xsl:text>true</xsl:text>
													</xsl:when>
													<xsl:otherwise>
														<xsl:text>false</xsl:text>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:variable>
											<xsl:variable name="gevolmachtigdeRefHoedanigheidId" select="tia:vertegenwoordigtRef/@xlink:href"/>
											<xsl:variable name="hoedanigheidRefPersonId" select="$acquirerParty/tia:Hoedanigheid[concat('#', @id) = $gevolmachtigdeRefHoedanigheidId]/tia:wordtVertegenwoordigdRef/@xlink:href"/>
											<tr>
												<td>
													<xsl:if test="$countPersons > 1">
														<xsl:attribute name="colspan"><xsl:value-of select="2"/></xsl:attribute>
													</xsl:if>
													<!-- if acquirer party contains authorized representative -->
													<xsl:apply-templates select="$acquirerParty" mode="do-gevoltmachtigde-per-party">
														<xsl:with-param name="gevoltmachtigdePerParty" select="."/>
													</xsl:apply-templates>
													<!-- Just one IMKAD_Persoon represented by the Gevolmachtigde -->
													<xsl:if test="$countPersons = 1">
														<xsl:apply-templates select="$acquirerParty/descendant::tia:IMKAD_Persoon[@id=substring-after($hoedanigheidRefPersonId, '#')]" mode="do-distribution-person-name"/>
														<xsl:apply-templates select="$acquirerParty/descendant::tia:IMKAD_Persoon[@id=substring-after($hoedanigheidRefPersonId, '#')]" mode="do-distribution-part"/>
														<xsl:text> in:</xsl:text>
													</xsl:if>
												</td>
											</tr>
											<!-- Just one IMKAD_Persoon represented by the Gevolmachtigde -->
											<xsl:if test="$countPersons > 1">
												<xsl:for-each select="$acquirerParty/tia:Hoedanigheid[concat('#', @id) = $gevolmachtigdeRefHoedanigheidId]/tia:wordtVertegenwoordigdRef">
													<xsl:variable name="position" select="position()"/>
													<xsl:variable name="last" select="last()"/>
													<tr>
														<td class="number" valign="top">
															<xsl:text>-</xsl:text>
														</td>
														<td>
															<xsl:variable name="gevolmachtigdeId" select="substring-after(@xlink:href, '#')"/>
															<xsl:variable name="personWithID" select="$acquirerParty/descendant::tia:IMKAD_Persoon[@id=$gevolmachtigdeId]"/>
															<xsl:apply-templates select="$personWithID" mode="do-distribution-person-name"/>
															<xsl:apply-templates select="$personWithID" mode="do-distribution-part"/>
															<xsl:choose>
																<xsl:when test="position() = last() and $isCurrentlyProcessedGevolmachtigdeLastOne = 'true'">
																	<xsl:text> in:</xsl:text>
																</xsl:when>
																<xsl:otherwise>
																	<xsl:text>; en aan </xsl:text>
																</xsl:otherwise>
															</xsl:choose>
														</td>
													</tr>
												</xsl:for-each>
											</xsl:if>
										</xsl:for-each>
									</tbody>
								</table>
							</xsl:when>
							<xsl:otherwise>
								<xsl:if test="$acquirerParty/tia:Gevolmachtigde">
									<br/>
									<xsl:apply-templates select="$acquirerParty" mode="do-gevoltmachtigde-per-party">
										<xsl:with-param name="gevoltmachtigdePerParty" select="$gevoltmachtigdePerParty"/>
									</xsl:apply-templates>
								</xsl:if>
								<table cellspacing="0" cellpadding="0">
									<tbody>
										<xsl:for-each select="$acquirerParty/tia:IMKAD_Persoon">
											<xsl:variable name="position" select="position()"/>
											<xsl:variable name="last" select="last()"/>
											<xsl:if test="translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true'">
												<tr>
													<xsl:if test="(count($acquirerParty/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true'])
														+ count($acquirerParty/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true'])
														+ count($acquirerParty/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true'])) > 1">
														<td class="number" valign="top">
															<xsl:text>-</xsl:text>
														</td>
													</xsl:if>
													<td>
														<xsl:choose>
															<xsl:when test="translate($acquirerPartyHasAuthorizedRepresentative, $upper, $lower) = 'false'">
																<xsl:apply-templates select="." mode="do-distribution-person-name"/>
																<xsl:text> voornoemd, die hierbij aanvaardt het </xsl:text>
																<xsl:value-of select="kef:convertNumberToText(string(tia:tia_AandeelInRechten/tia:teller))"/>
																<xsl:text>/</xsl:text>
																<xsl:value-of select="kef:convertOrdinalToText(string(tia:tia_AandeelInRechten/tia:noemer))"/>
																<xsl:text> (</xsl:text>
																<xsl:value-of select="tia:tia_AandeelInRechten/tia:teller"/>
																<xsl:text>/</xsl:text>
																<xsl:value-of select="tia:tia_AandeelInRechten/tia:noemer"/>
																<xsl:text>) </xsl:text>
																<xsl:text> onverdeeld aandeel</xsl:text>
															</xsl:when>
															<xsl:otherwise>
																<xsl:apply-templates select="." mode="do-distribution-person-name"/>
																<xsl:apply-templates select="." mode="do-distribution-part"/>
															</xsl:otherwise>
														</xsl:choose>
														<xsl:choose>
															<xsl:when test="position() = last() and
																(count(tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true'])
																	+ count(tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true'])) = 0">
																<xsl:text> in:</xsl:text>
															</xsl:when>
															<xsl:otherwise>
																<xsl:text>; en aan</xsl:text>
															</xsl:otherwise>
														</xsl:choose>
													</td>
												</tr>
											</xsl:if>
											<xsl:for-each select="tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true']">
												<tr>
													<td class="number" valign="top">
														<xsl:text>-</xsl:text>
													</td>
													<td>
														<xsl:choose>
															<xsl:when test="translate($acquirerPartyHasAuthorizedRepresentative, $upper, $lower) = 'false'">
																<xsl:apply-templates select="." mode="do-distribution-person-name"/>
																<xsl:text> voornoemd, die hierbij aanvaardt het </xsl:text>
																<xsl:value-of select="kef:convertNumberToText(string(tia:tia_AandeelInRechten/tia:teller))"/>
																<xsl:text>/</xsl:text>
																<xsl:value-of select="kef:convertOrdinalToText(string(tia:tia_AandeelInRechten/tia:noemer))"/>
																<xsl:text> (</xsl:text>
																<xsl:value-of select="tia:tia_AandeelInRechten/tia:teller"/>
																<xsl:text>/</xsl:text>
																<xsl:value-of select="tia:tia_AandeelInRechten/tia:noemer"/>
																<xsl:text>) </xsl:text>
																<xsl:text> onverdeeld aandeel</xsl:text>
															</xsl:when>
															<xsl:otherwise>
																<xsl:apply-templates select="." mode="do-distribution-person-name"/>
																<xsl:apply-templates select="." mode="do-distribution-part"/>
															</xsl:otherwise>
														</xsl:choose>
														<xsl:choose>
															<xsl:when test="$position = $last and position() = last() and
																		count(tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true']) = 0">
																<xsl:text> in:</xsl:text>
															</xsl:when>
															<xsl:otherwise>
																<xsl:text>; en aan</xsl:text>
															</xsl:otherwise>
														</xsl:choose>
													</td>
												</tr>
												<xsl:for-each select="tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true']">
													<tr>
														<td class="number" valign="top">
															<xsl:text>-</xsl:text>
														</td>
														<td>
															<xsl:choose>
																<xsl:when test="translate($acquirerPartyHasAuthorizedRepresentative, $upper, $lower) = 'false'">
																	<xsl:apply-templates select="." mode="do-distribution-person-name"/>
																	<xsl:text> voornoemd, die hierbij aanvaardt het </xsl:text>
																	<xsl:value-of select="kef:convertNumberToText(string(tia:tia_AandeelInRechten/tia:teller))"/>
																	<xsl:text>/</xsl:text>
																	<xsl:value-of select="kef:convertOrdinalToText(string(tia:tia_AandeelInRechten/tia:noemer))"/>
																	<xsl:text> (</xsl:text>
																	<xsl:value-of select="tia:tia_AandeelInRechten/tia:teller"/>
																	<xsl:text>/</xsl:text>
																	<xsl:value-of select="tia:tia_AandeelInRechten/tia:noemer"/>
																	<xsl:text>) </xsl:text>
																	<xsl:text> onverdeeld aandeel</xsl:text>
																</xsl:when>
																<xsl:otherwise>
																	<xsl:apply-templates select="." mode="do-distribution-person-name"/>
																	<xsl:apply-templates select="." mode="do-distribution-part"/>
																</xsl:otherwise>
															</xsl:choose>
															<xsl:choose>
																<xsl:when test="$position = $last and position() = last()">
																	<xsl:text> in:</xsl:text>
																</xsl:when>
																<xsl:otherwise>
																	<xsl:text>; en aan</xsl:text>
																</xsl:otherwise>
															</xsl:choose>
														</td>
													</tr>
												</xsl:for-each>
											</xsl:for-each>
										</xsl:for-each>
									</tbody>
								</table>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<!-- nested Partij in verkrijgerRechtRef of StukdeelLevering -->
					<xsl:when test="$acquirerPersons">
						<xsl:choose>
							<xsl:when test="count($acquirerPersons) = 1">
								<xsl:choose>
									<xsl:when test="not($gevoltmachtigdePerPerson)">
										<xsl:apply-templates select="$acquirerPersons[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true'][1]" mode="do-distribution-person-name"/>
										<xsl:text> voornoemd, die hierbij aanvaardt het </xsl:text>
										<xsl:value-of select="kef:convertNumberToText(string($acquirerPersons[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true'][1]/tia:tia_AandeelInRechten/tia:teller))"/>
										<xsl:text>/</xsl:text>
										<xsl:value-of select="kef:convertOrdinalToText(string($acquirerPersons[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true'][1]/tia:tia_AandeelInRechten/tia:noemer))"/>
										<xsl:text> (</xsl:text>
										<xsl:value-of select="$acquirerPersons[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true'][1]/tia:tia_AandeelInRechten/tia:teller"/>
										<xsl:text>/</xsl:text>
										<xsl:value-of select="$acquirerPersons[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true'][1]/tia:tia_AandeelInRechten/tia:noemer"/>
										<xsl:text>) </xsl:text>
										<xsl:text> onverdeeld aandeel</xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:apply-templates select="$parentNode/tia:Partij[tia:Gevolmachtigde]" mode="do-gevoltmachtigde-per-party">
											<xsl:with-param name="gevoltmachtigdePerParty" select="$gevoltmachtigdePerPerson"/>
										</xsl:apply-templates>
										<xsl:apply-templates select="$acquirerPersons[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true'][1]" mode="do-distribution-person-name"/>
										<xsl:apply-templates select="$acquirerPersons[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true'][1]" mode="do-distribution-part"/>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:text> in:</xsl:text>
							</xsl:when>
							<xsl:otherwise>
								<!-- IMKAD_Persoon NOT represented by the Hoedanigheid -->
								<xsl:variable name="containPersonNotReferencedInHoedanigheid">
									<xsl:choose>
										<xsl:when test="$acquirerPersons[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true' and not(concat('#', @id) = $parentNode/tia:Partij/tia:Hoedanigheid[concat('#', @id) = $parentNode/tia:Partij/tia:Gevolmachtigde/tia:vertegenwoordigtRef/@xlink:href]/tia:wordtVertegenwoordigdRef/@xlink:href)]">
											<xsl:text>true</xsl:text>
										</xsl:when>
										<xsl:otherwise>
											<xsl:text>false</xsl:text>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:variable>
								<xsl:variable name="containPersonInHoedanigheid">
									<xsl:choose>
										<xsl:when test="$acquirerPersons[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true' and concat('#', @id) = $parentNode/tia:Partij/tia:Hoedanigheid[concat('#', @id) = $parentNode/tia:Partij/tia:Gevolmachtigde/tia:vertegenwoordigtRef/@xlink:href]/tia:wordtVertegenwoordigdRef/@xlink:href]">
											<xsl:text>true</xsl:text>
										</xsl:when>
										<xsl:otherwise>
											<xsl:text>false</xsl:text>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:variable>
								<!-- Table with person NOT contained in Gevolmachtigde -->
								<xsl:if test="$containPersonNotReferencedInHoedanigheid = 'true'">
									<table cellspacing="0" cellpadding="0">
										<tbody>
											<xsl:for-each select="$acquirerPersons[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true']">
												<xsl:variable name="acquirerPersonsId" select="@id"/>
												<xsl:variable name="gevoltmachtigdePerSinglePerson" select="$parentNode/descendant::tia:Partij/tia:Gevolmachtigde[tia:vertegenwoordigtRef/@xlink:href = concat('#', $parentNode/tia:Partij/tia:Hoedanigheid[tia:wordtVertegenwoordigdRef/@xlink:href=concat('#', $acquirerPersonsId)]/@id)]"/>
												<xsl:if test="not($gevoltmachtigdePerSinglePerson)">
													<tr>
														<td class="number" valign="top">
															<xsl:text>-</xsl:text>
														</td>
														<td>
															<xsl:apply-templates select="." mode="do-distribution-person-name"/>
															<xsl:text> voornoemd, die hierbij aanvaardt het </xsl:text>
															<xsl:value-of select="kef:convertNumberToText(string(tia:tia_AandeelInRechten/tia:teller))"/>
															<xsl:text>/</xsl:text>
															<xsl:value-of select="kef:convertOrdinalToText(string(tia:tia_AandeelInRechten/tia:noemer))"/>
															<xsl:text> (</xsl:text>
															<xsl:value-of select="tia:tia_AandeelInRechten/tia:teller"/>
															<xsl:text>/</xsl:text>
															<xsl:value-of select="tia:tia_AandeelInRechten/tia:noemer"/>
															<xsl:text>) </xsl:text>
															<xsl:text> onverdeeld aandeel</xsl:text>
															<xsl:choose>
																<xsl:when test="position() = last() and $containPersonInHoedanigheid = 'false'">
																	<xsl:text> in:</xsl:text>
																</xsl:when>
																<xsl:otherwise>
																	<xsl:text>; en aan</xsl:text>
																</xsl:otherwise>
															</xsl:choose>
														</td>
													</tr>
												</xsl:if>
											</xsl:for-each>
										</tbody>
									</table>
								</xsl:if>
								<!-- IMKAD_Persoon represented by the Gevolmachtigde -->
								<xsl:variable name="hoedanigheidIdOfLastGevolmachtigde" select="$parentNode/tia:Partij/tia:Gevolmachtigde[count(following-sibling::tia:Gevolmachtigde) = 0 and tia:vertegenwoordigtRef]/tia:vertegenwoordigtRef[count(following-sibling::tia:vertegenwoordigtRef) = 0]/@xlink:href"/>
								<xsl:variable name="idOfLastPersonContainedInHoedanigheid" select="$acquirerPersons[concat('#', @id) = $parentNode/tia:Partij/tia:Hoedanigheid[concat('#', @id) = $hoedanigheidIdOfLastGevolmachtigde]/tia:wordtVertegenwoordigdRef[count(following-sibling::tia:wordtVertegenwoordigdRef) = 0]/@xlink:href]/@id"/>
								<xsl:for-each select="tia:Partij[tia:Gevolmachtigde]/tia:Gevolmachtigde">
									<xsl:variable name="currentlyProcessedGevolmachtigde" select="."/>
									<xsl:variable name="containAcquirerPersonsInHoedanigheid">
										<xsl:choose>
											<xsl:when test="$acquirerPersons[concat('#', @id) = $parentNode/tia:Partij/tia:Hoedanigheid[concat('#', @id) = $currentlyProcessedGevolmachtigde/tia:vertegenwoordigtRef/@xlink:href]/tia:wordtVertegenwoordigdRef/@xlink:href]">
												<xsl:text>true</xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text>false</xsl:text>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:variable>
									<xsl:variable name="gevolmachtigdeRefHoedanigheidId" select="tia:vertegenwoordigtRef/@xlink:href"/>
									<!-- Table with person contained in Gevolmachtigde -->
									<xsl:if test="$containAcquirerPersonsInHoedanigheid = 'true'">
										<table cellspacing="0" cellpadding="0">
											<tbody>
												<tr>
													<td>
														<xsl:if test="count($acquirerPersons) > 1">
															<xsl:attribute name="colspan"><xsl:value-of select="2"/></xsl:attribute>
														</xsl:if>
														<xsl:apply-templates select=".." mode="do-gevoltmachtigde-per-party">
															<xsl:with-param name="gevoltmachtigdePerParty" select="."/>
														</xsl:apply-templates>
													</td>
												</tr>
												<xsl:for-each select="$parentNode/tia:Partij/tia:Hoedanigheid[concat('#', @id) = $gevolmachtigdeRefHoedanigheidId]/tia:wordtVertegenwoordigdRef">
													<xsl:variable name="refPersonFromGevolmachtigde" select="@xlink:href"/>
													<xsl:if test="$acquirerPersons[@id = substring-after($refPersonFromGevolmachtigde, '#')]">
														<tr>
															<td class="number" valign="top">
																<xsl:text>-</xsl:text>
															</td>
															<td>
																<xsl:variable name="person" select="$acquirerPersons[@id = substring-after($refPersonFromGevolmachtigde, '#')]"/>
																<xsl:apply-templates select="$person[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true']" mode="do-distribution-person-name"/>
																<xsl:apply-templates select="$person[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true']" mode="do-distribution-part"/>
																<xsl:choose>
																	<xsl:when test="$person[@id = $idOfLastPersonContainedInHoedanigheid]">
																		<xsl:text> in:</xsl:text>
																	</xsl:when>
																	<xsl:otherwise>
																		<xsl:text>; en aan</xsl:text>
																	</xsl:otherwise>
																</xsl:choose>
															</td>
														</tr>
													</xsl:if>
												</xsl:for-each>
											</tbody>
										</table>
									</xsl:if>
								</xsl:for-each>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
				</xsl:choose>
			</xsl:when>
			<!-- Variant 3: Unequal distribution of shares in the acquiring parties (at party level) -->
			<xsl:when test="count($acquirerParty/tia:Partij) > 1 and count($acquirerParty/tia:Partij/tia:aandeelinRechten) > 0">
				<xsl:for-each select="$acquirerParty/tia:Partij[translate(tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_partijongelijkeverdeling']/tia:tekst, $upper, $lower) = 'true']">
					<br/>
					<xsl:value-of select="tia:aanduidingPartij"/>
					<xsl:text>, die hierbij aanvaardt het </xsl:text>
					<xsl:value-of select="kef:convertNumberToText(string(tia:aandeelinRechten/tia:teller))"/>
					<xsl:text>/</xsl:text>
					<xsl:value-of select="kef:convertOrdinalToText(string(tia:aandeelinRechten/tia:noemer))"/>
					<xsl:text> (</xsl:text>
					<xsl:value-of select="tia:aandeelinRechten/tia:teller"/>
					<xsl:text>/</xsl:text>
					<xsl:value-of select="tia:aandeelinRechten/tia:noemer"/>
					<xsl:text>) </xsl:text>
					<xsl:text> onverdeeld aandeel</xsl:text>
					<xsl:choose>
						<xsl:when test="position() = last()">
							<xsl:text> in:</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>; en aan</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
			</xsl:when>
			<!-- Variant 1: Equal shares -->
			<xsl:when test="(count($acquirerParty/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true']/tia:tia_AandeelInRechten)
							+ count($acquirerParty/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true']/tia:tia_AandeelInRechten)) = 0 or
							(count($acquirerPersons[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true']/tia:tia_AandeelInRechten)
							+ count($acquirerPersons/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true']/tia:tia_AandeelInRechten)) = 0">
				<xsl:choose>
					<xsl:when test="$acquirerParty">
						<xsl:value-of select="$acquirerParty/tia:aanduidingPartij"/>
					</xsl:when>
					<xsl:when test="$acquirerPersons[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true']">
						<xsl:value-of select="$parentNode/descendant::tia:Partij[substring-after(tia:partijPersoonRef/@xlink:href, '#') = $acquirerPersons[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true'][1]/@id]/tia:aanduidingPartij"/>
					</xsl:when>
				</xsl:choose>
				<xsl:text>, die hierbij aanvaardt</xsl:text>
				<xsl:choose>
					<xsl:when test="$numberOfBuyers = 2">
						<xsl:if test="$acquirerParty">
							<xsl:if test="$partyMariatalStatusText = '5' or
											$partyMariatalStatusText = '6' or
											$partyMariatalStatusText = '7' or
											$partyMariatalStatusText = '10' or
											$partyMariatalStatusText = '11' or
											$partyMariatalStatusText = '12' or
											$partyMariatalStatusText = '15' or
											$partyMariatalStatusText = '18'">
								<xsl:text>, gezamenlijk</xsl:text>
							</xsl:if>
						</xsl:if>
						<xsl:if test="$acquirerPersons[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true']">
							<xsl:if test="$personMariatalStatusText = '5' or
											$personMariatalStatusText = '6' or
											$personMariatalStatusText = '7' or
											$personMariatalStatusText = '10' or
											$personMariatalStatusText = '11' or
											$personMariatalStatusText = '12' or
											$personMariatalStatusText = '15' or
											$personMariatalStatusText = '18'">
								<xsl:text>, gezamenlijk</xsl:text>
							</xsl:if>
						</xsl:if>
						<xsl:text>, ieder voor de </xsl:text>
						<xsl:value-of select="$undivided"/>
						<xsl:text>helft</xsl:text>
					</xsl:when>
					<xsl:when test="$numberOfBuyers > 2">
						<xsl:text>, ieder voor het een/</xsl:text>
						<xsl:value-of select="kef:convertOrdinalToText(string($numberOfBuyers))"/>
						<xsl:text> (1/</xsl:text>
						<xsl:value-of select="$numberOfBuyers"/>
						<xsl:text>) </xsl:text>
						<xsl:value-of select="$undivided"/>
						<xsl:text>aandeel</xsl:text>
					</xsl:when>
				</xsl:choose>
				<xsl:text>:</xsl:text>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-gevoltmachtigde-per-party
	*********************************************************
	Public: no

	Identity transform: no

	Description: Deed of transfer purchase distribution blocks - person name.

	Input: tia:Partij

	Params: gevoltmachtigdePerParty - tia:Gevolmachtigde

	Output: text

	Calls:
	none

	Called by:
	(mode) do-gender-salutation
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:Partij" mode="do-gevoltmachtigde-per-party">
		<xsl:param name="gevoltmachtigdePerParty" select="self::node()[false()]"/>
		<xsl:if test="$gevoltmachtigdePerParty">
			<xsl:apply-templates select="$gevoltmachtigdePerParty/tia:gegevens/tia:persoonGegevens" mode="do-gender-salutation"/>
			<xsl:text> </xsl:text>
			<xsl:choose>
				<xsl:when test="$gevoltmachtigdePerParty/tia:gegevens/tia:kadGegevensPersoon">
					<xsl:value-of select="$gevoltmachtigdePerParty/tia:gegevens/tia:kadGegevensPersoon/tia:voornamen"/>
					<xsl:text> </xsl:text>
					<xsl:if test="normalize-space($gevoltmachtigdePerParty/tia:gegevens/tia:kadGegevensPersoon/tia:voorvoegselsgeslachtsnaam) != ''">
						<xsl:value-of select="$gevoltmachtigdePerParty/tia:gegevens/tia:kadGegevensPersoon/tia:voorvoegselsgeslachtsnaam"/>
						<xsl:text> </xsl:text>
					</xsl:if>
					<xsl:value-of select="$gevoltmachtigdePerParty/tia:gegevens/tia:kadGegevensPersoon/tia:geslachtsnaam"/>
					<xsl:choose>
						<xsl:when test="count($gevoltmachtigdePerParty/tia:GerelateerdPersoon) = 1">
							<xsl:text> en </xsl:text>
						</xsl:when>
						<xsl:when test="count($gevoltmachtigdePerParty/tia:GerelateerdPersoon) > 1">
							<xsl:text>, </xsl:text>
						</xsl:when>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$gevoltmachtigdePerParty/tia:gegevens/tia:persoonGegevens/tia:naam/tia:voornamen"/>
					<xsl:text> </xsl:text>
					<xsl:if test="normalize-space($gevoltmachtigdePerParty/tia:gegevens/tia:persoonGegevens/tia:tia_VoorvoegselsNaam) != ''">
						<xsl:value-of select="$gevoltmachtigdePerParty/tia:gegevens/tia:persoonGegevens/tia:tia_VoorvoegselsNaam"/>
						<xsl:text> </xsl:text>
					</xsl:if>
					<xsl:value-of select="$gevoltmachtigdePerParty/tia:gegevens/tia:persoonGegevens/tia:tia_NaamZonderVoorvoegsels"/>
					<xsl:choose>
						<xsl:when test="count($gevoltmachtigdePerParty/tia:GerelateerdPersoon) = 1">
							<xsl:text> en </xsl:text>
						</xsl:when>
						<xsl:when test="count($gevoltmachtigdePerParty/tia:GerelateerdPersoon) > 1">
							<xsl:text>, </xsl:text>
						</xsl:when>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:for-each select="$gevoltmachtigdePerParty/tia:GerelateerdPersoon">
				<xsl:apply-templates select="tia:IMKAD_Persoon/tia:tia_Gegevens/tia:GBA_Ingezetene | tia:IMKAD_Persoon/tia:tia_Gegevens/tia:IMKAD_NietIngezetene" mode="do-gender-salutation"/>
				<xsl:text> </xsl:text>
				<xsl:choose>
					<xsl:when test="tia:IMKAD_Persoon/tia:tia_Gegevens/tia:IMKAD_KadNatuurlijkPersoon and tia:IMKAD_Persoon/tia:tia_Gegevens/tia:GBA_Ingezetene">
						<xsl:value-of select="tia:IMKAD_Persoon/tia:tia_Gegevens/tia:IMKAD_KadNatuurlijkPersoon/tia:voornamen"/>
						<xsl:if test="tia:IMKAD_Persoon/tia:tia_Gegevens/tia:IMKAD_KadNatuurlijkPersoon/tia:voorvoegselsgeslachtsnaam
									and normalize-space(tia:IMKAD_Persoon/tia:tia_Gegevens/tia:IMKAD_KadNatuurlijkPersoon/tia:voorvoegselsgeslachtsnaam) != ''">
							<xsl:text> </xsl:text>
							<xsl:value-of select="tia:IMKAD_Persoon/tia:tia_Gegevens/tia:IMKAD_KadNatuurlijkPersoon/tia:voorvoegselsgeslachtsnaam"/>
						</xsl:if>
						<xsl:text> </xsl:text>
						<xsl:value-of select="tia:IMKAD_Persoon/tia:tia_Gegevens/tia:IMKAD_KadNatuurlijkPersoon/tia:geslachtsnaam"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="tia:IMKAD_Persoon/tia:tia_Gegevens/tia:GBA_Ingezetene/tia:naam/tia:voornamen | tia:IMKAD_Persoon/tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:voornamen"/>
						<xsl:text> </xsl:text>
						<xsl:if test="normalize-space(tia:IMKAD_Persoon/tia:tia_Gegevens/tia:GBA_Ingezetene/tia:tia_VoorvoegselsNaam | tia:IMKAD_Persoon/tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:voorvoegsels) != ''">
							<xsl:value-of select="tia:IMKAD_Persoon/tia:tia_Gegevens/tia:GBA_Ingezetene/tia:tia_VoorvoegselsNaam | tia:IMKAD_Persoon/tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:voorvoegsels"/>
							<xsl:text> </xsl:text>
						</xsl:if>
						<xsl:value-of select="tia:IMKAD_Persoon/tia:tia_Gegevens/tia:GBA_Ingezetene/tia:tia_NaamZonderVoorvoegsels | tia:IMKAD_Persoon/tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:geslachtsnaam"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:choose>
					<xsl:when test="position() = last()"/>
					<xsl:when test="position() + 1 = last()">
						<xsl:text> en </xsl:text>
					</xsl:when>
					<xsl:when test="position() + 1 &lt; last()">
						<xsl:text>, </xsl:text>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
			<xsl:text> voornoemd, die hierbij</xsl:text>
			<xsl:if test="count($gevoltmachtigdePerParty/tia:GerelateerdPersoon) = 0">
				<xsl:text> aanvaardt</xsl:text>
			</xsl:if>
			<xsl:if test="count($gevoltmachtigdePerParty/tia:GerelateerdPersoon) > 0">
				<xsl:text> aanvaarden</xsl:text>
			</xsl:if>
			<xsl:text> namens, </xsl:text>
		</xsl:if>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-distribution-person-name
	*********************************************************
	Public: no

	Identity transform: no

	Description: Deed of transfer purchase distribution blocks - person name.

	Input: tia:IMKAD_Persoon

	Params: none

	Output: text

	Calls:
	none

	Called by:
	(mode) do-purchase-distribution-paragraph-part
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon[tia:tia_Gegevens/tia:IMKAD_KadNatuurlijkPersoon or tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene]" mode="do-distribution-person-name">
		<xsl:apply-templates select="tia:tia_Gegevens/tia:GBA_Ingezetene | tia:tia_Gegevens/tia:IMKAD_NietIngezetene" mode="do-gender-salutation"/>
		<xsl:text> </xsl:text>
		<xsl:choose>
			<!-- tia:IMKAD_KadNatuurlijkPersoon has a higher priority -->
			<xsl:when test="tia:tia_Gegevens[tia:IMKAD_KadNatuurlijkPersoon]">
				<xsl:value-of select="tia:tia_Gegevens[tia:IMKAD_KadNatuurlijkPersoon]/tia:IMKAD_KadNatuurlijkPersoon/tia:voornamen"/>
				<xsl:text> </xsl:text>
				<xsl:if test="normalize-space(tia:tia_Gegevens[tia:IMKAD_KadNatuurlijkPersoon]/tia:IMKAD_KadNatuurlijkPersoon/tia:voorvoegselsgeslachtsnaam) != ''">
					<xsl:value-of select="tia:tia_Gegevens[tia:IMKAD_KadNatuurlijkPersoon]/tia:IMKAD_KadNatuurlijkPersoon/tia:voorvoegselsgeslachtsnaam"/>
					<xsl:text> </xsl:text>
				</xsl:if>
				<xsl:value-of select="tia:tia_Gegevens[tia:IMKAD_KadNatuurlijkPersoon]/tia:IMKAD_KadNatuurlijkPersoon/tia:geslachtsnaam"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="tia:tia_Gegevens/tia:GBA_Ingezetene/tia:naam/tia:voornamen | tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:voornamen"/>
				<xsl:text> </xsl:text>
				<xsl:if test="normalize-space(tia:tia_Gegevens/tia:GBA_Ingezetene/tia:tia_VoorvoegselsNaam | tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:voorvoegsels) != ''">
					<xsl:value-of select="tia:tia_Gegevens/tia:GBA_Ingezetene/tia:tia_VoorvoegselsNaam | tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:voorvoegsels"/>
					<xsl:text> </xsl:text>
				</xsl:if>
				<xsl:value-of select="tia:tia_Gegevens/tia:GBA_Ingezetene/tia:tia_NaamZonderVoorvoegsels | tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:geslachtsnaam"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon[tia:tia_Gegevens/tia:NHR_Rechtspersoon]" mode="do-distribution-person-name">
		<xsl:value-of select="$legalPersonNames[translate(Value[@ColumnRef = 'C']/SimpleValue, $upper, $lower)
			= translate(current()/tia:tia_Gegevens/tia:NHR_Rechtspersoon/tia:rechtsvormSub, $upper, $lower)]/Value[@ColumnRef = 'D']"/>
		<xsl:text> </xsl:text>
		<xsl:value-of select="tia:tia_Gegevens/tia:NHR_Rechtspersoon/tia:statutaireNaam"/>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-distribution-part
	*********************************************************
	Public: no

	Identity transform: no

	Description: Deed of transfer purchase distribution blocks - distribution part.

	Input: tia:IMKAD_Persoon

	Params: none

	Output: text

	Calls:
	none

	Called by:
	(mode) do-purchase-distribution-paragraph-part
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon" mode="do-distribution-part">
		<xsl:text> voornoemd het </xsl:text>
		<xsl:value-of select="kef:convertNumberToText(string(tia:tia_AandeelInRechten/tia:teller))"/>
		<xsl:text>/</xsl:text>
		<xsl:value-of select="kef:convertOrdinalToText(string(tia:tia_AandeelInRechten/tia:noemer))"/>
		<xsl:text> (</xsl:text>
		<xsl:value-of select="tia:tia_AandeelInRechten/tia:teller"/>
		<xsl:text>/</xsl:text>
		<xsl:value-of select="tia:tia_AandeelInRechten/tia:noemer"/>
		<xsl:text>) </xsl:text>
		<xsl:text> onverdeeld aandeel</xsl:text>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-purchase-and-transfer-objects
	*********************************************************
	Public: no

	Identity transform: no

	Description: Deed of transfer purchase and transfer blocks.

	Input: tia:IMKAD_AangebodenStuk

	Params: none

	Output: XHTML structure

	Calls:
	(mode) do-registered-objects-deed-of-transfer

	Called by:
	(mode) do-purchase-and-transfer
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_AangebodenStuk" mode="do-purchase-and-transfer-objects">
		<xsl:variable name="numberOfRegisteredObjects" select="count(tia:StukdeelLevering/tia:IMKAD_ZakelijkRecht)"/>
		<p>
			<xsl:text>OMSCHRIJVING REGISTERGOED</xsl:text>
			<xsl:if test="$numberOfRegisteredObjects > 1">
				<xsl:text>EREN</xsl:text>
			</xsl:if>
		</p>
		<xsl:apply-templates select="tia:StukdeelLevering" mode="do-registered-objects-deed-of-transfer"/>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-purchase-and-transfer-standaardlevering
	*********************************************************
	Public: no

	Identity transform: no

	Description: Deed of transfer purchase and transfer blocks.

	Input: tia:IMKAD_AangebodenStuk

	Params: none

	Output: XHTML structure

	Calls:
	(name) capitalizePartyAlias
	(mode) do-purchase-distribution-paragraph-part
	(mode) do-registered-objects-deed-of-transfer

	Called by:
	(mode) do-purchase-and-transfer
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_AangebodenStuk" mode="do-purchase-and-transfer-standaardlevering">
		<h2 class="header">
			<xsl:text>KOOP</xsl:text>
		</h2>
		<xsl:for-each select="tia:StukdeelKoop[tia:tia_Volgnummer]">
			<xsl:variable name="Datum_DATE" select="substring(string(tia:koopovereenkomst/tia:datumOndertekening), 0, 11)"/>
			<xsl:variable name="Datum_STRING">
				<xsl:if test="$Datum_DATE != ''">
					<xsl:value-of select="kef:convertDateToText($Datum_DATE)"/>
				</xsl:if>
			</xsl:variable>
			<xsl:variable name="numberOfRegisteredObjects" select="count(../tia:StukdeelLevering[tia:tia_Volgnummer = current()/tia:tia_Volgnummer]/tia:IMKAD_ZakelijkRecht)"/>
			<xsl:variable name="koopakte" select="tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
				translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
				translate(normalize-space(current()/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
			<xsl:variable name="koopAkteCapitalized" select="concat(translate(substring($koopakte, 1, 1), $lower, $upper), substring($koopakte, 2))"/>
			<xsl:variable name="deHet">
				<xsl:choose>
					<xsl:when test="normalize-space(tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst) = normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst[1])">
						<xsl:text>het </xsl:text>
					</xsl:when>
					<xsl:when test="normalize-space($koopakte) != ''">
						<xsl:text>de </xsl:text>
					</xsl:when>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="deHetKoopakte">
				<xsl:value-of select="$deHet"/>
				<xsl:value-of select="$koopakte"/>
			</xsl:variable>
			<xsl:variable name="deHetKoopakteCapitalized">
				<xsl:value-of select="$deHet"/>
				<xsl:value-of select="$koopAkteCapitalized"/>
			</xsl:variable>
			<xsl:variable name="vervreemderName">
				<xsl:choose>
					<xsl:when test="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
						<xsl:call-template name="capitalizePartyAlias">
							<xsl:with-param name="party" select="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
						<xsl:call-template name="capitalizePartyAlias">
							<xsl:with-param name="party" select="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]"/>
						</xsl:call-template>
					</xsl:when>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="verkrijgerName">
				<xsl:choose>
					<xsl:when test="../tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij">
						<xsl:value-of select="../tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
					</xsl:when>
					<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij">
						<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
					</xsl:when>
				</xsl:choose>
			</xsl:variable>
			<p>
				<xsl:value-of select="$vervreemderName"/>
				<xsl:text> en </xsl:text>
				<xsl:value-of select="$verkrijgerName"/>
				<xsl:text> hebben op </xsl:text>
				<xsl:value-of select="$Datum_STRING"/>
				<xsl:text> een </xsl:text>
				<xsl:value-of select="$koopakte"/>
				<xsl:text> gesloten met betrekking tot </xsl:text>
				<xsl:choose>
					<xsl:when test="$numberOfRegisteredObjects > 1">
						<xsl:text>de </xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>het </xsl:text>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:text>hierna te vermelden registergoed</xsl:text>
				<xsl:if test="$numberOfRegisteredObjects > 1">
					<xsl:text>eren</xsl:text>
				</xsl:if>
				<xsl:text>. Van </xsl:text>
				<xsl:value-of select="$deHetKoopakte"/>
				<xsl:text> blijkt uit een onderhandse akte die </xsl:text>
				<xsl:if test="translate(tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_akteaangehecht']/tia:tekst, $upper, $lower) = 'true'">
					<xsl:text>aan deze akte wordt gehecht en </xsl:text>
				</xsl:if>
				<xsl:text>hierna wordt aangeduid met "</xsl:text>
				<u>
					<xsl:choose>
						<xsl:when test="tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopaktevolgnummer']/tia:tekst = 'true'">
							<xsl:value-of select="$koopAkteCapitalized"/>
							<xsl:text> </xsl:text>
							<xsl:apply-templates select="." mode="do-get-serial-number"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$deHetKoopakteCapitalized"/>
						</xsl:otherwise>
					</xsl:choose>
				</u>
				<xsl:text>".</xsl:text>
			</p>
		</xsl:for-each>
		<h2 class="header">LEVERING</h2>
		<xsl:for-each select="tia:StukdeelLevering[tia:tia_Volgnummer]">
			<xsl:variable name="stukdeelKoop" select="../tia:StukdeelKoop[tia:tia_Volgnummer = current()/tia:tia_Volgnummer]"/>
			<xsl:variable name="acquirerParty" select="../tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]"/>
			<xsl:variable name="nestedParty" select="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]"/>
			<xsl:variable name="acquirerPersons" select="../tia:Partij/descendant::tia:IMKAD_Persoon[concat('#', @id) = $nestedParty/tia:partijPersoonRef/@xlink:href]"/>
			<xsl:variable name="numberOfRegisteredObjects" select="count(tia:IMKAD_ZakelijkRecht)"/>
			<xsl:variable name="numberOfBuyers" select="count(../tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true'])
	+ count(../tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:IMKAD_Persoon/tia:GerelateerdPersoon[translate(tia:IMKAD_Persoon/tia:tia_IndGerechtigde, $upper, $lower) = 'true'])
				+ count(../tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon[translate(tia:IMKAD_Persoon/tia:tia_IndGerechtigde, $upper, $lower) = 'true'])
				+ count($acquirerPersons[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true'])"/>
			<xsl:variable name="undivided">
				<xsl:choose>
					<xsl:when test="translate(tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst, $upper, $lower) = 'true'">
						<xsl:choose>
							<xsl:when test="$numberOfBuyers = 2">
								<xsl:text>onverdeelde </xsl:text>
							</xsl:when>
							<xsl:when test="$numberOfBuyers > 2">
								<xsl:text>onverdeeld </xsl:text>
							</xsl:when>
							<xsl:otherwise>
								<xsl:text/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="koopakte" select="$stukdeelKoop/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
				translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
				translate(normalize-space($stukdeelKoop/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
			<xsl:variable name="koopAkteCapitalized" select="concat(translate(substring($koopakte, 1, 1), $lower, $upper), substring($koopakte, 2))"/>
			<xsl:variable name="deHetKoopakte">
				<xsl:choose>
					<xsl:when test="normalize-space($stukdeelKoop/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst) = normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst[1])">
						<xsl:text>het </xsl:text>
					</xsl:when>
					<xsl:when test="normalize-space($koopakte) != ''">
						<xsl:text>de </xsl:text>
					</xsl:when>
				</xsl:choose>
				<xsl:value-of select="$koopAkteCapitalized"/>
			</xsl:variable>
			<xsl:variable name="vervreemderName">
				<xsl:choose>
					<xsl:when test="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij">
						<xsl:value-of select="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
					</xsl:when>
					<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij">
						<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
					</xsl:when>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="verkrijgerName">
				<xsl:choose>
					<xsl:when test="../tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij">
						<xsl:value-of select="../tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
					</xsl:when>
					<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij">
						<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
					</xsl:when>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="registergoedAanduidingHetRegistergoed" select="tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst, $upper, $lower) = 'het registergoed'][1]"/>
			<xsl:variable name="registergoedAanduidingDeRegistergoederen" select="tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst, $upper, $lower) = 'de registergoederen'][1]"/>
			<xsl:variable name="registergoedAanduidingHetVerkochte" select="tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst, $upper, $lower) = 'het verkochte'][1]"/>
			<xsl:variable name="aantalZelfdeObjecten">
				<xsl:choose>
					<xsl:when test="tia:IMKAD_ZakelijkRecht">
						<xsl:call-template name="bepaalAantalZelfde">
							<xsl:with-param name="positionOfProcessedRight" select="number('1')"/>
							<xsl:with-param name="registeredObjects" select="."/>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="number('0')"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="aantalTeTonenHetRegistergoed" select="$numberOfRegisteredObjects - $aantalZelfdeObjecten"/>
			<p>
				<xsl:text>Ter uitvoering van </xsl:text>
				<xsl:choose>
					<xsl:when test="$stukdeelKoop/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopaktevolgnummer']/tia:tekst = 'true'">
						<xsl:value-of select="$koopAkteCapitalized"/>
						<xsl:text> </xsl:text>
						<xsl:apply-templates select="$stukdeelKoop" mode="do-get-serial-number"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$deHetKoopakte"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:text> levert </xsl:text>
				<xsl:value-of select="$vervreemderName"/>
				<xsl:text> hierbij aan </xsl:text>
				<xsl:apply-templates select=".." mode="do-purchase-distribution-paragraph-part">
					<xsl:with-param name="numberOfBuyers" select="$numberOfBuyers"/>
					<xsl:with-param name="undivided" select="$undivided"/>
					<xsl:with-param name="acquirerParty" select="$acquirerParty"/>
					<xsl:with-param name="acquirerPersons" select="$acquirerPersons"/>
				</xsl:apply-templates>
			</p>
			<p>
				<xsl:text>OMSCHRIJVING REGISTERGOED</xsl:text>
				<xsl:if test="$numberOfRegisteredObjects > 1">
					<xsl:text>EREN</xsl:text>
				</xsl:if>
			</p>
			<xsl:apply-templates select="." mode="do-registered-objects-deed-of-transfer"/>
			<xsl:if test="tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekst']/tia:tekst, $upper, $lower) = 'true']">
				<xsl:if test="$registergoedAanduidingHetRegistergoed">
					<p>
						<xsl:if test="translate($registergoedAanduidingHetRegistergoed/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedvolgnummeropsomming']/tia:tekst, $upper, $lower) = 'true'">
							<xsl:for-each select="tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst, $upper, $lower)
													= translate($registergoedAanduidingHetRegistergoed/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst, $upper, $lower)]">
								<xsl:text>Registergoed </xsl:text>
								<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
								<xsl:choose>
									<xsl:when test="position() = last() - 1">
										<xsl:text> en </xsl:text>
									</xsl:when>
									<xsl:when test="position() != last()">
										<xsl:text>, </xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text> </xsl:text>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:for-each>
						</xsl:if>
						<xsl:text>hierna</xsl:text>
						<xsl:if test="translate(normalize-space($registergoedAanduidingHetRegistergoed/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekstfragment']/tia:tekst), $upper, $lower)
									= translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekstfragment']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
												translate(normalize-space($registergoedAanduidingHetRegistergoed/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekstfragment']/tia:tekst), $upper, $lower)]), $upper, $lower)">
							<xsl:text> </xsl:text>
							<xsl:value-of select="translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekstfragment']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
									translate(normalize-space($registergoedAanduidingHetRegistergoed/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekstfragment']/tia:tekst), $upper, $lower)]), $upper, $lower)"/>
						</xsl:if>
						<xsl:text>: "</xsl:text>
						<u>
							<xsl:value-of select="$registergoedAanduidingHetRegistergoed/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst"/>
						</u>
						<xsl:text>".</xsl:text>
					</p>
				</xsl:if>
				<xsl:if test="$registergoedAanduidingDeRegistergoederen">
					<p>
						<xsl:if test="translate($registergoedAanduidingDeRegistergoederen/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedvolgnummeropsomming']/tia:tekst, $upper, $lower) = 'true'">
							<xsl:for-each select="tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst, $upper, $lower)
													= translate($registergoedAanduidingDeRegistergoederen/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst, $upper, $lower)]">
								<xsl:text>Registergoed </xsl:text>
								<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
								<xsl:choose>
									<xsl:when test="position() = last() - 1">
										<xsl:text> en </xsl:text>
									</xsl:when>
									<xsl:when test="position() != last()">
										<xsl:text>, </xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text> </xsl:text>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:for-each>
						</xsl:if>
						<xsl:text>hierna</xsl:text>
						<xsl:if test="translate(normalize-space($registergoedAanduidingDeRegistergoederen/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekstfragment']/tia:tekst), $upper, $lower)
									= translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekstfragment']/tia:tekst[translate(normalize-space(.), $upper, $lower) = translate(normalize-space($registergoedAanduidingDeRegistergoederen/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekstfragment']/tia:tekst), $upper, $lower)]), $upper, $lower)">
							<xsl:text> </xsl:text>
							<xsl:value-of select="translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekstfragment']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
									translate(normalize-space($registergoedAanduidingDeRegistergoederen/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekstfragment']/tia:tekst), $upper, $lower)]), $upper, $lower)"/>
						</xsl:if>
						<xsl:text>: "</xsl:text>
						<u>
							<xsl:value-of select="$registergoedAanduidingDeRegistergoederen/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst"/>
						</u>
						<xsl:text>".</xsl:text>
					</p>
				</xsl:if>
				<xsl:if test="$registergoedAanduidingHetVerkochte">
					<p>
						<xsl:if test="translate($registergoedAanduidingHetVerkochte/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedvolgnummeropsomming']/tia:tekst, $upper, $lower) = 'true'">
							<xsl:choose>
								<xsl:when test="$aantalTeTonenHetRegistergoed > 1">
									<xsl:variable name="numberOfRegisteredObjectsVorigeLevering">
										<xsl:choose>
											<xsl:when test="preceding-sibling::tia:StukdeelLevering[tia:IMKAD_ZakelijkRecht]">
												<xsl:value-of select="count(preceding-sibling::tia:StukdeelLevering/tia:IMKAD_ZakelijkRecht)"/>
											</xsl:when>
											<xsl:otherwise>0</xsl:otherwise>
										</xsl:choose>
									</xsl:variable>
									<xsl:variable name="aantalZelfdeObjectenVorigeLevering">
										<xsl:choose>
											<xsl:when test="preceding-sibling::tia:StukdeelLevering[tia:IMKAD_ZakelijkRecht]">
												<xsl:call-template name="bepaalAantalZelfde">
													<xsl:with-param name="positionOfProcessedRight" select="number('1')"/>
													<xsl:with-param name="registeredObjects" select="preceding-sibling::tia:StukdeelLevering[tia:IMKAD_ZakelijkRecht]"/>
												</xsl:call-template>
											</xsl:when>
											<xsl:otherwise>0</xsl:otherwise>
										</xsl:choose>
									</xsl:variable>
									<xsl:variable name="aantalTeTonenHetRegistergoedVorigeLevering">
										<xsl:choose>
											<xsl:when test="preceding-sibling::tia:StukdeelLevering[tia:IMKAD_ZakelijkRecht]">
												<xsl:value-of select="$numberOfRegisteredObjectsVorigeLevering - $aantalZelfdeObjectenVorigeLevering"/>
											</xsl:when>
											<xsl:otherwise>0</xsl:otherwise>
										</xsl:choose>
									</xsl:variable>
									<xsl:call-template name="toon-het-registergoed">
										<xsl:with-param name="index" select="$aantalTeTonenHetRegistergoedVorigeLevering + 1"/>
										<xsl:with-param name="totaal" select="$aantalTeTonenHetRegistergoed + $aantalTeTonenHetRegistergoedVorigeLevering"/>
									</xsl:call-template>
								</xsl:when>
								<xsl:otherwise>
									<xsl:for-each select="tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst, $upper, $lower)
													= translate($registergoedAanduidingHetVerkochte/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst, $upper, $lower)]">
										<xsl:text>Registergoed </xsl:text>
										<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
										<xsl:choose>
											<xsl:when test="position() = last() - 1">
												<xsl:text> en </xsl:text>
											</xsl:when>
											<xsl:when test="position() != last()">
												<xsl:text>, </xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text> </xsl:text>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:for-each>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:if>
						<xsl:text>hierna</xsl:text>
						<xsl:if test="translate(normalize-space($registergoedAanduidingHetVerkochte/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekstfragment']/tia:tekst), $upper, $lower)
									= translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekstfragment']/tia:tekst[translate(normalize-space(.), $upper, $lower) = translate(normalize-space($registergoedAanduidingHetVerkochte/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekstfragment']/tia:tekst), $upper, $lower)]), $upper, $lower)">
							<xsl:text> </xsl:text>
							<xsl:value-of select="translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekstfragment']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
									translate(normalize-space($registergoedAanduidingHetVerkochte/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekstfragment']/tia:tekst), $upper, $lower)]), $upper, $lower)"/>
						</xsl:if>
						<xsl:text>: "</xsl:text>
						<u>
							<xsl:value-of select="$registergoedAanduidingHetVerkochte/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst"/>
						</u>
						<xsl:text>".</xsl:text>
					</p>
				</xsl:if>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-get-serial-number
	*********************************************************
	Public: no

	Identity transform: no

	Description: Get serial number of the Koop.

	Input: tia:StukdeelKoop

	Params: none

	Output: XHTML structure

	Calls: none

	Called by:
	(mode) do-purchase-and-transfer-standaardlevering
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:StukdeelKoop" mode="do-get-serial-number">
		<xsl:value-of select="count(preceding-sibling::tia:StukdeelKoop) + 1"/>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-purchase-and-transfer-tweeleveringen
	*********************************************************
	Public: no

	Identity transform: no

	Description: Deed of transfer purchase and transfer blocks.

	Input: tia:IMKAD_AangebodenStuk

	Params: none

	Output: XHTML structure

	Calls:
	(mode) do-registered-objects-deed-of-transfer
	(mode) do-purchase-distribution-paragraph-part

	Called by:
	(mode) do-purchase-and-transfer
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_AangebodenStuk" mode="do-purchase-and-transfer-tweeleveringen">
		<xsl:for-each select="tia:StukdeelKoop[count(preceding-sibling::tia:StukdeelKoop) mod 2 = 0]">
			<xsl:variable name="Datum_DATE1" select="substring(string(tia:koopovereenkomst/tia:datumOndertekening), 0, 11)"/>
			<xsl:variable name="Datum_STRING1">
				<xsl:if test="$Datum_DATE1 != ''">
					<xsl:value-of select="kef:convertDateToText($Datum_DATE1)"/>
				</xsl:if>
			</xsl:variable>
			<xsl:variable name="nextKoop" select="following-sibling::tia:StukdeelKoop[1]"/>
			<xsl:variable name="levering" select="../tia:StukdeelLevering[tia:tia_Volgnummer = current()/tia:tia_Volgnummer]"/>
			<xsl:variable name="nextLevering" select="../tia:StukdeelLevering[tia:tia_Volgnummer = $nextKoop/tia:tia_Volgnummer]"/>
			<xsl:variable name="Datum_DATE2" select="substring(string($nextKoop/tia:koopovereenkomst/tia:datumOndertekening), 0, 11)"/>
			<xsl:variable name="Datum_STRING2">
				<xsl:if test="$Datum_DATE2 != ''">
					<xsl:value-of select="kef:convertDateToText($Datum_DATE2)"/>
				</xsl:if>
			</xsl:variable>
			<xsl:variable name="numberOfRegisteredObjects" select="count($nextLevering/tia:IMKAD_ZakelijkRecht)"/>
			<xsl:variable name="koopakte" select="tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
				translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
				translate(normalize-space(current()/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
			<xsl:variable name="koopakteNext" select="$nextKoop/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
				translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
				translate(normalize-space($nextKoop/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
			<xsl:variable name="koopAkteCapitalized" select="concat(translate(substring($koopakte, 1, 1), $lower, $upper), substring($koopakte, 2))"/>
			<xsl:variable name="koopAkteCapitalizedNext" select="concat(translate(substring($koopakteNext, 1, 1), $lower, $upper), substring($koopakteNext, 2))"/>
			<xsl:variable name="ditDezeKoopakte">
				<xsl:choose>
					<xsl:when test="normalize-space(tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst) = normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst[1])">
						<xsl:text>Dit </xsl:text>
					</xsl:when>
					<xsl:when test="normalize-space($koopakte) != ''">
						<xsl:text>Deze </xsl:text>
					</xsl:when>
				</xsl:choose>
				<xsl:value-of select="$koopakte"/>
			</xsl:variable>
			<xsl:variable name="deHet">
				<xsl:choose>
					<xsl:when test="normalize-space(tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst) = normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst[1])">
						<xsl:text>het </xsl:text>
					</xsl:when>
					<xsl:when test="normalize-space($koopakte) != ''">
						<xsl:text>de </xsl:text>
					</xsl:when>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="deHetNext">
				<xsl:choose>
					<xsl:when test="normalize-space($nextKoop/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst) = normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst[1])">
						<xsl:text>het </xsl:text>
					</xsl:when>
					<xsl:when test="normalize-space($koopakteNext) != ''">
						<xsl:text>de </xsl:text>
					</xsl:when>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="deHetKoopakte">
				<xsl:value-of select="$deHet"/>
				<xsl:value-of select="$koopAkteCapitalized"/>
			</xsl:variable>
			<xsl:variable name="deHetKoopakteNext">
				<xsl:value-of select="$deHetNext"/>
				<xsl:value-of select="$koopAkteCapitalizedNext"/>
			</xsl:variable>
			<xsl:variable name="ditDezeKoopakteNext">
				<xsl:choose>
					<xsl:when test="normalize-space(tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst) = normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst[1])">
						<xsl:text>Dit </xsl:text>
					</xsl:when>
					<xsl:when test="normalize-space($koopakteNext) != ''">
						<xsl:text>Deze </xsl:text>
					</xsl:when>
				</xsl:choose>
				<xsl:value-of select="$koopakteNext"/>
			</xsl:variable>
			<h2 class="header">
				<xsl:text>KOOP</xsl:text>
			</h2>
			<table cellpadding="0" cellspacing="0">
				<tbody>
					<tr>
						<td class="number" valign="top">
							<xsl:text>1.</xsl:text>
						</td>
						<td>
							<xsl:text>Door </xsl:text>
							<xsl:choose>
								<xsl:when test="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
									<xsl:value-of select="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
								</xsl:when>
								<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
									<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
								</xsl:when>
							</xsl:choose>
							<xsl:text> is met </xsl:text>
							<xsl:choose>
								<xsl:when test="../tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]">
									<xsl:value-of select="../tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
								</xsl:when>
								<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]">
									<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
								</xsl:when>
							</xsl:choose>
							<xsl:text> op </xsl:text>
							<xsl:value-of select="$Datum_STRING1"/>
							<xsl:text> een </xsl:text>
							<xsl:value-of select="$koopakte"/>
							<xsl:text> gesloten betreffende </xsl:text>
							<xsl:choose>
								<xsl:when test="count($nextLevering/tia:IMKAD_ZakelijkRecht) > 1">
									<xsl:text>de </xsl:text>
								</xsl:when>
								<xsl:when test="count($nextLevering/tia:IMKAD_ZakelijkRecht) = 1">
									<xsl:text>het </xsl:text>
								</xsl:when>
							</xsl:choose>
							<xsl:text>hierna te vermelden registergoed</xsl:text>
							<xsl:if test="count($nextLevering/tia:IMKAD_ZakelijkRecht) > 1">
								<xsl:text>eren</xsl:text>
							</xsl:if>
							<xsl:text>, hierna te noemen: "</xsl:text>
							<u>
								<xsl:choose>
									<xsl:when test="tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopaktevolgnummer']/tia:tekst = 'true'">
										<xsl:value-of select="$koopAkteCapitalized"/>
										<xsl:text> </xsl:text>
										<xsl:value-of select="count(preceding-sibling::tia:StukdeelKoop) + 1"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="$deHetKoopakte"/>
									</xsl:otherwise>
								</xsl:choose>
							</u>
							<xsl:text>".</xsl:text>
							<xsl:if test="tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_akteaangehecht']/tia:tekst = 'true'">
								<xsl:text> </xsl:text>
								<xsl:choose>
									<xsl:when test="(count(preceding-sibling::tia:StukdeelKoop[count(preceding-sibling::tia:StukdeelKoop) mod 2 = 0]) + 1) = 0
										or not(tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopaktevolgnummer']/tia:tekst = 'true')">
										<xsl:value-of select="$ditDezeKoopakte"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="$koopAkteCapitalized"/>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:if test="tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopaktevolgnummer']/tia:tekst = 'true'">
									<xsl:text> </xsl:text>
									<xsl:value-of select="count(preceding-sibling::tia:StukdeelKoop) + 1"/>
									<xsl:text> </xsl:text>
								</xsl:if>
								<xsl:text>is als bijlage aan deze akte gehecht.</xsl:text>
							</xsl:if>
						</td>
					</tr>
					<tr>
						<td class="number" valign="top">
							<xsl:text>2.</xsl:text>
						</td>
						<td>
							<xsl:text>Vervolgens is door </xsl:text>
							<xsl:choose>
								<xsl:when test="../tia:Partij[@id = substring-after($nextKoop/tia:vervreemderRechtRef/@xlink:href, '#')]">
									<xsl:value-of select="../tia:Partij[@id = substring-after($nextKoop/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
								</xsl:when>
								<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after($nextKoop/tia:vervreemderRechtRef/@xlink:href, '#')]">
									<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after($nextKoop/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
								</xsl:when>
							</xsl:choose>
							<xsl:text> met </xsl:text>
							<xsl:choose>
								<xsl:when test="../tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]">
									<xsl:value-of select="../tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
								</xsl:when>
								<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]">
									<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
								</xsl:when>
							</xsl:choose>
							<xsl:text> op </xsl:text>
							<xsl:value-of select="$Datum_STRING2"/>
							<xsl:text> een </xsl:text>
							<xsl:value-of select="$koopakteNext"/>
							<xsl:text> gesloten betreffende </xsl:text>
							<xsl:choose>
								<xsl:when test="count($nextLevering/tia:IMKAD_ZakelijkRecht) > 1">
									<xsl:text>de</xsl:text>
								</xsl:when>
								<xsl:when test="count($nextLevering/tia:IMKAD_ZakelijkRecht) = 1">
									<xsl:text>het</xsl:text>
								</xsl:when>
							</xsl:choose>
							<xsl:text> hierna te vermelden registergoed</xsl:text>
							<xsl:if test="count(../tia:StukdeelLevering[tia:tia_Volgnummer = $nextKoop/tia:tia_Volgnummer]/tia:IMKAD_ZakelijkRecht) > 1">
								<xsl:text>eren</xsl:text>
							</xsl:if>
							<xsl:text>, hierna te noemen: "</xsl:text>
							<u>
								<xsl:choose>
									<xsl:when test="$nextKoop/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopaktevolgnummer']/tia:tekst = 'true'">
										<xsl:value-of select="$koopAkteCapitalizedNext"/>
										<xsl:text> </xsl:text>
										<xsl:value-of select="count($nextKoop/preceding-sibling::tia:StukdeelKoop) + 1"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="$deHetKoopakteNext"/>
									</xsl:otherwise>
								</xsl:choose>
							</u>
							<xsl:text>".</xsl:text>
							<xsl:if test="$nextKoop/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_akteaangehecht']/tia:tekst = 'true'">
								<xsl:text> </xsl:text>
								<xsl:choose>
									<xsl:when test="(count($nextKoop/preceding-sibling::tia:StukdeelKoop[count(preceding-sibling::tia:StukdeelKoop) mod 2 = 0]) + 1) = 0
										or not($nextKoop/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopaktevolgnummer']/tia:tekst = 'true')">
										<xsl:value-of select="$ditDezeKoopakteNext"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="$koopAkteCapitalizedNext"/>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:if test="$nextKoop/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopaktevolgnummer']/tia:tekst = 'true'">
									<xsl:text> </xsl:text>
									<xsl:value-of select="count($nextKoop/preceding-sibling::tia:StukdeelKoop) + 1"/>
									<xsl:text> </xsl:text>
								</xsl:if>
								<xsl:text> is </xsl:text>
								<xsl:if test="tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_akteaangehecht']/tia:tekst = 'true'">
									<xsl:text>eveneens </xsl:text>
								</xsl:if>
								<xsl:text>als bijlage aan deze akte gehecht.</xsl:text>
							</xsl:if>
						</td>
					</tr>
					<tr>
						<td class="number" valign="top">
							<xsl:text>3.</xsl:text>
						</td>
						<td>
							<xsl:text>Bij deze akte levert </xsl:text>
							<xsl:choose>
								<xsl:when test="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
									<xsl:value-of select="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
								</xsl:when>
								<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
									<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
								</xsl:when>
							</xsl:choose>
							<xsl:text> aan </xsl:text>
							<xsl:choose>
								<xsl:when test="../tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]">
									<xsl:value-of select="../tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
								</xsl:when>
								<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]">
									<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
								</xsl:when>
							</xsl:choose>
							<xsl:text> ter uitvoering van </xsl:text>
							<xsl:choose>
								<xsl:when test="tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopaktevolgnummer']/tia:tekst = 'true'">
									<xsl:value-of select="$koopAkteCapitalized"/>
									<xsl:text> </xsl:text>
									<xsl:value-of select="count(preceding-sibling::tia:StukdeelKoop) + 1"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$deHetKoopakte"/>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:text> en </xsl:text>
							<xsl:choose>
								<xsl:when test="../tia:Partij[@id = substring-after($nextKoop/tia:vervreemderRechtRef/@xlink:href, '#')]">
									<xsl:value-of select="../tia:Partij[@id = substring-after($nextKoop/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
								</xsl:when>
								<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after($nextKoop/tia:vervreemderRechtRef/@xlink:href, '#')]">
									<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after($nextKoop/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
								</xsl:when>
							</xsl:choose>
							<xsl:text> levert aan </xsl:text>
							<xsl:choose>
								<xsl:when test="../tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]">
									<xsl:value-of select="../tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
								</xsl:when>
								<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]">
									<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
								</xsl:when>
							</xsl:choose>
							<xsl:text> ter uitvoering van </xsl:text>
							<xsl:choose>
								<xsl:when test="tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopaktevolgnummer']/tia:tekst = 'true'">
									<xsl:value-of select="$koopAkteCapitalizedNext"/>
									<xsl:text> </xsl:text>
									<xsl:value-of select="count($nextKoop/preceding-sibling::tia:StukdeelKoop) + 1"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$deHetKoopakteNext"/>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:text>.</xsl:text>
						</td>
					</tr>
				</tbody>
			</table>
		</xsl:for-each>
		<xsl:for-each select="tia:StukdeelLevering[count(preceding-sibling::tia:StukdeelLevering) mod 2 = 0]">
			<xsl:variable name="koopLevering" select="../tia:StukdeelKoop[tia:tia_Volgnummer = current()/tia:tia_Volgnummer]"/>
			<xsl:variable name="koopakteLevering" select="$koopLevering/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
				translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
				translate(normalize-space($koopLevering/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
			<xsl:variable name="nextLevering" select="following-sibling::tia:StukdeelLevering[1]"/>
			<xsl:variable name="koopLeveringNext" select="../tia:StukdeelKoop[tia:tia_Volgnummer = $nextLevering/tia:tia_Volgnummer]"/>
			<xsl:variable name="koopakteLeveringNext" select="$koopLeveringNext/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
				translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
				translate(normalize-space($koopLeveringNext/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
			<xsl:variable name="koopAkteCapitalizedLevering" select="concat(translate(substring($koopakteLevering, 1, 1), $lower, $upper), substring($koopakteLevering, 2))"/>
			<xsl:variable name="koopAkteCapitalizedLeveringNext" select="concat(translate(substring($koopakteLeveringNext, 1, 1), $lower, $upper), substring($koopakteLeveringNext, 2))"/>
			<xsl:variable name="deHetLevering">
				<xsl:choose>
					<xsl:when test="normalize-space(../tia:StukdeelKoop[tia:tia_Volgnummer = current()/tia:tia_Volgnummer]/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst) = normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst[1])">
						<xsl:text>het </xsl:text>
					</xsl:when>
					<xsl:when test="normalize-space($koopakteLevering) != ''">
						<xsl:text>de </xsl:text>
					</xsl:when>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="deHetLeveringNext">
				<xsl:choose>
					<xsl:when test="normalize-space(../tia:StukdeelKoop[tia:tia_Volgnummer = $nextLevering/tia:tia_Volgnummer]/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst) = normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst[1])">
						<xsl:text>het </xsl:text>
					</xsl:when>
					<xsl:when test="normalize-space($koopakteLeveringNext) != ''">
						<xsl:text>de </xsl:text>
					</xsl:when>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="deHetKoopakteLevering">
				<xsl:value-of select="$deHetLevering"/>
				<xsl:value-of select="$koopAkteCapitalizedLevering"/>
			</xsl:variable>
			<xsl:variable name="deHetKoopakteLeveringNext">
				<xsl:value-of select="$deHetLeveringNext"/>
				<xsl:value-of select="$koopAkteCapitalizedLeveringNext"/>
			</xsl:variable>
			<xsl:variable name="numberOfBuyersLevering" select="count(../tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true'])
				+ count(../tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:IMKAD_Persoon/tia:GerelateerdPersoon[translate(tia:IMKAD_Persoon/tia:tia_IndGerechtigde, $upper, $lower) = 'true'])
				+ count(../tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon[translate(tia:IMKAD_Persoon/tia:tia_IndGerechtigde, $upper, $lower) = 'true'])"/>
			<xsl:variable name="undividedLevering">
				<xsl:choose>
					<xsl:when test="translate(tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst, $upper, $lower) = 'true'">
						<xsl:choose>
							<xsl:when test="$numberOfBuyersLevering = 2">
								<xsl:text>onverdeelde </xsl:text>
							</xsl:when>
							<xsl:when test="$numberOfBuyersLevering > 2">
								<xsl:text>onverdeeld </xsl:text>
							</xsl:when>
							<xsl:otherwise>
								<xsl:text/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="acquirerPartyLevering" select="../tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]"/>
			<xsl:variable name="nestedPartyLevering" select="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]"/>
			<xsl:variable name="acquirerPersonsLevering" select="../tia:Partij/tia:IMKAD_Persoon/descendant-or-self::tia:IMKAD_Persoon[concat('#', @id) = $nestedPartyLevering/tia:partijPersoonRef/@xlink:href]"/>
			<xsl:variable name="numberOfBuyersLeveringNext" select="count(../tia:Partij[@id = substring-after($nextLevering/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true'])
				+ count(../tia:Partij[@id = substring-after($nextLevering/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:IMKAD_Persoon/tia:GerelateerdPersoon[translate(tia:IMKAD_Persoon/tia:tia_IndGerechtigde, $upper, $lower) = 'true'])
				+ count(../tia:Partij[@id = substring-after($nextLevering/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon[translate(tia:IMKAD_Persoon/tia:tia_IndGerechtigde, $upper, $lower) = 'true'])"/>
			<xsl:variable name="undividedLeveringNext">
				<xsl:choose>
					<xsl:when test="translate($nextLevering/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst, $upper, $lower) = 'true'">
						<xsl:choose>
							<xsl:when test="$numberOfBuyersLevering = 2">
								<xsl:text>onverdeelde </xsl:text>
							</xsl:when>
							<xsl:when test="$numberOfBuyersLevering > 2">
								<xsl:text>onverdeeld </xsl:text>
							</xsl:when>
							<xsl:otherwise>
								<xsl:text/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="acquirerPartyLeveringNext" select="../tia:Partij[@id = substring-after($koopLeveringNext/tia:verkrijgerRechtRef/@xlink:href, '#')]"/>
			<xsl:variable name="nestedPartyLeveringNext" select="../tia:Partij/tia:Partij[@id = substring-after($koopLeveringNext/tia:verkrijgerRechtRef/@xlink:href, '#')]"/>
			<xsl:variable name="acquirerPersonsLeveringNext" select="../tia:Partij/tia:IMKAD_Persoon/descendant-or-self::tia:IMKAD_Persoon[concat('#', @id) = $nestedPartyLeveringNext/tia:partijPersoonRef/@xlink:href]"/>
			<xsl:variable name="numberOfRegisteredObjectsLevering" select="count($nextLevering/tia:IMKAD_ZakelijkRecht)"/>
			<xsl:variable name="registergoedAanduidingHetRegistergoed" select="$nextLevering/tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst, $upper, $lower) = 'het registergoed'][1]"/>
			<xsl:variable name="registergoedAanduidingDeRegistergoederen" select="$nextLevering/tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst, $upper, $lower) = 'de registergoederen'][1]"/>
			<xsl:variable name="registergoedAanduidingHetVerkochte" select="$nextLevering/tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst, $upper, $lower) = 'het verkochte'][1]"/>
			<h2 class="header">LEVERING</h2>
			<p>
				<xsl:text>Vervolgens levert </xsl:text>
				<xsl:choose>
					<xsl:when test="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
						<xsl:value-of select="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
					</xsl:when>
					<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
						<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
					</xsl:when>
				</xsl:choose>
				<xsl:text>, ter uitvoering van </xsl:text>
				<xsl:choose>
					<xsl:when test="$koopLevering/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopaktevolgnummer']/tia:tekst = 'true'">
						<xsl:value-of select="$koopAkteCapitalizedLevering"/>
						<xsl:text> </xsl:text>
						<xsl:value-of select="count($koopLevering/preceding-sibling::tia:StukdeelKoop) + 1"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$deHetKoopakteLevering"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:text>, hierbij aan </xsl:text>
				<xsl:apply-templates select=".." mode="do-purchase-distribution-paragraph-part">
					<xsl:with-param name="numberOfBuyers" select="$numberOfBuyersLevering"/>
					<xsl:with-param name="undivided" select="$undividedLevering"/>
					<xsl:with-param name="acquirerParty" select="$acquirerPartyLevering"/>
					<xsl:with-param name="acquirerPersons" select="$acquirerPersonsLevering"/>
				</xsl:apply-templates>
				<xsl:text> </xsl:text>
				<xsl:choose>
					<xsl:when test="count($nextLevering/tia:IMKAD_ZakelijkRecht) > 1">
						<xsl:text>de</xsl:text>
					</xsl:when>
					<xsl:when test="count($nextLevering/tia:IMKAD_ZakelijkRecht) = 1">
						<xsl:text>het</xsl:text>
					</xsl:when>
				</xsl:choose>
				<xsl:text> hierna te vermelden registergoed</xsl:text>
				<xsl:if test="count(../tia:StukdeelLevering[tia:tia_Volgnummer = $koopLeveringNext/tia:tia_Volgnummer]/tia:IMKAD_ZakelijkRecht) > 1">
					<xsl:text>eren</xsl:text>
				</xsl:if>
				<xsl:text>, en levert </xsl:text>
				<xsl:choose>
					<xsl:when test="../tia:Partij[@id = substring-after($nextLevering/tia:vervreemderRechtRef/@xlink:href, '#')]">
						<xsl:value-of select="../tia:Partij[@id = substring-after($nextLevering/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
					</xsl:when>
					<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after($nextLevering/tia:vervreemderRechtRef/@xlink:href, '#')]">
						<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after($nextLevering/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
					</xsl:when>
				</xsl:choose>
				<xsl:text>, ter uitvoering van </xsl:text>
				<xsl:choose>
					<xsl:when test="$koopLeveringNext/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopaktevolgnummer']/tia:tekst = 'true'">
						<xsl:value-of select="$koopAkteCapitalizedLeveringNext"/>
						<xsl:text> </xsl:text>
						<xsl:value-of select="count($koopLeveringNext/preceding-sibling::tia:StukdeelKoop) + 1"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$deHetKoopakteLeveringNext"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:text>, hierbij aan </xsl:text>
				<xsl:apply-templates select=".." mode="do-purchase-distribution-paragraph-part">
					<xsl:with-param name="numberOfBuyers" select="$numberOfBuyersLeveringNext"/>
					<xsl:with-param name="undivided" select="$undividedLeveringNext"/>
					<xsl:with-param name="acquirerParty" select="$acquirerPartyLeveringNext"/>
					<xsl:with-param name="acquirerPersons" select="$acquirerPersonsLeveringNext"/>
				</xsl:apply-templates>
			</p>
			<p>
				<xsl:text>OMSCHRIJVING REGISTERGOED</xsl:text>
				<xsl:if test="$numberOfRegisteredObjectsLevering > 1">
					<xsl:text>EREN</xsl:text>
				</xsl:if>
			</p>
			<xsl:apply-templates select="$nextLevering" mode="do-registered-objects-deed-of-transfer"/>
			<xsl:if test="$nextLevering/tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekst']/tia:tekst, $upper, $lower) = 'true']">
				<xsl:if test="$registergoedAanduidingHetRegistergoed">
					<p>
						<xsl:if test="translate($registergoedAanduidingHetRegistergoed/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedvolgnummeropsomming']/tia:tekst, $upper, $lower) = 'true'">
							<xsl:for-each select="$nextLevering/tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst, $upper, $lower)
													= translate($registergoedAanduidingHetRegistergoed/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst, $upper, $lower)]">
								<xsl:text>Registergoed </xsl:text>
								<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
								<xsl:choose>
									<xsl:when test="position() = last() - 1">
										<xsl:text> en </xsl:text>
									</xsl:when>
									<xsl:when test="position() != last()">
										<xsl:text>, </xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text> </xsl:text>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:for-each>
						</xsl:if>
						<xsl:text>hierna</xsl:text>
						<xsl:if test="translate(normalize-space($registergoedAanduidingHetRegistergoed/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekstfragment']/tia:tekst), $upper, $lower)
									= translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekstfragment']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
												translate(normalize-space($registergoedAanduidingHetRegistergoed/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekstfragment']/tia:tekst), $upper, $lower)]), $upper, $lower)">
							<xsl:text> </xsl:text>
							<xsl:value-of select="translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekstfragment']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
									translate(normalize-space($registergoedAanduidingHetRegistergoed/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekstfragment']/tia:tekst), $upper, $lower)]), $upper, $lower)"/>
						</xsl:if>
						<xsl:text>: "</xsl:text>
						<u>
							<xsl:value-of select="$registergoedAanduidingHetRegistergoed/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst"/>
						</u>
						<xsl:text>".</xsl:text>
					</p>
				</xsl:if>
				<xsl:if test="$registergoedAanduidingDeRegistergoederen">
					<p>
						<xsl:if test="translate($registergoedAanduidingDeRegistergoederen/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedvolgnummeropsomming']/tia:tekst, $upper, $lower) = 'true'">
							<xsl:for-each select="$nextLevering/tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst, $upper, $lower)
													= translate($registergoedAanduidingDeRegistergoederen/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst, $upper, $lower)]">
								<xsl:text>Registergoed </xsl:text>
								<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
								<xsl:choose>
									<xsl:when test="position() = last() - 1">
										<xsl:text> en </xsl:text>
									</xsl:when>
									<xsl:when test="position() != last()">
										<xsl:text>, </xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text> </xsl:text>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:for-each>
						</xsl:if>
						<xsl:text>hierna</xsl:text>
						<xsl:if test="translate(normalize-space($registergoedAanduidingDeRegistergoederen/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekstfragment']/tia:tekst), $upper, $lower)
									= translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekstfragment']/tia:tekst[translate(normalize-space(.), $upper, $lower) = translate(normalize-space($registergoedAanduidingDeRegistergoederen/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekstfragment']/tia:tekst), $upper, $lower)]), $upper, $lower)">
							<xsl:text> </xsl:text>
							<xsl:value-of select="translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekstfragment']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
									translate(normalize-space($registergoedAanduidingDeRegistergoederen/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekstfragment']/tia:tekst), $upper, $lower)]), $upper, $lower)"/>
						</xsl:if>
						<xsl:text>: "</xsl:text>
						<u>
							<xsl:value-of select="$registergoedAanduidingDeRegistergoederen/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst"/>
						</u>
						<xsl:text>".</xsl:text>
					</p>
				</xsl:if>
				<xsl:if test="$registergoedAanduidingHetVerkochte">
					<p>
						<xsl:if test="translate($registergoedAanduidingHetVerkochte/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedvolgnummeropsomming']/tia:tekst, $upper, $lower) = 'true'">
							<xsl:for-each select="$nextLevering/tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst, $upper, $lower)
													= translate($registergoedAanduidingHetVerkochte/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst, $upper, $lower)]">
								<xsl:text>Registergoed </xsl:text>
								<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
								<xsl:choose>
									<xsl:when test="position() = last() - 1">
										<xsl:text> en </xsl:text>
									</xsl:when>
									<xsl:when test="position() != last()">
										<xsl:text>, </xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text> </xsl:text>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:for-each>
						</xsl:if>
						<xsl:text>hierna</xsl:text>
						<xsl:if test="translate(normalize-space($registergoedAanduidingHetVerkochte/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekstfragment']/tia:tekst), $upper, $lower)
									= translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekstfragment']/tia:tekst[translate(normalize-space(.), $upper, $lower) = translate(normalize-space($registergoedAanduidingHetVerkochte/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekstfragment']/tia:tekst), $upper, $lower)]), $upper, $lower)">
							<xsl:text> </xsl:text>
							<xsl:value-of select="translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekstfragment']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
									translate(normalize-space($registergoedAanduidingHetVerkochte/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekstfragment']/tia:tekst), $upper, $lower)]), $upper, $lower)"/>
						</xsl:if>
						<xsl:text>: "</xsl:text>
						<u>
							<xsl:value-of select="$registergoedAanduidingHetVerkochte/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst"/>
						</u>
						<xsl:text>".</xsl:text>
					</p>
				</xsl:if>
			</xsl:if>
			<p>De bepalingen in deze akte zijn zowel op de eerste levering als op de tweede levering van toepassing, tenzij hierna anders is bepaald.</p>
		</xsl:for-each>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-purchase-and-transfer-verkooprechtenmetcessie
	*********************************************************
	Public: no

	Identity transform: no

	Description: Deed of transfer purchase and transfer blocks.

	Input: tia:IMKAD_AangebodenStuk

	Params: none

	Output: XHTML structure

	Calls:
	(name) capitalizePartyAlias
	(mode) do-purchase-distribution-paragraph-part
	(mode) do-registered-objects-deed-of-transfer

	Called by:
	(mode) do-purchase-and-transfer
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_AangebodenStuk" mode="do-purchase-and-transfer-verkooprechtenmetcessie">
		<xsl:for-each select="tia:StukdeelKoop[count(preceding-sibling::tia:StukdeelKoop) mod 2 = 0]">
			<xsl:variable name="nextKoop" select="following-sibling::tia:StukdeelKoop[1]"/>
			<xsl:variable name="Datum_DATE1" select="substring(string(tia:koopovereenkomst/tia:datumOndertekening), 0, 11)"/>
			<xsl:variable name="Datum_STRING1">
				<xsl:if test="$Datum_DATE1 != ''">
					<xsl:value-of select="kef:convertDateToText($Datum_DATE1)"/>
				</xsl:if>
			</xsl:variable>
			<xsl:variable name="Datum_DATE2" select="substring(string($nextKoop/tia:koopovereenkomst/tia:datumOndertekening), 0, 11)"/>
			<xsl:variable name="Datum_STRING2">
				<xsl:if test="$Datum_DATE2 != ''">
					<xsl:value-of select="kef:convertDateToText($Datum_DATE2)"/>
				</xsl:if>
			</xsl:variable>
			<xsl:variable name="leveringnummer" select="(number(current()/tia:tia_Volgnummer) + 1) div 2"/>
			<xsl:variable name="numberOfRegisteredObjects" select="count(../tia:StukdeelLevering[tia:tia_Volgnummer = $leveringnummer]/tia:IMKAD_ZakelijkRecht)"/>
			<xsl:variable name="numberOfBuyers" select="count(../tia:Partij[@id = substring-after(current()/../tia:StukdeelLevering[tia:tia_Volgnummer = $leveringnummer]/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true'])
				+ count(../tia:Partij[@id = substring-after(current()/../tia:StukdeelLevering[tia:tia_Volgnummer = $leveringnummer]/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:IMKAD_Persoon/tia:GerelateerdPersoon[translate(tia:IMKAD_Persoon/tia:tia_IndGerechtigde, $upper, $lower) = 'true'])
				+ count(../tia:Partij[@id = substring-after(current()/../tia:StukdeelLevering[tia:tia_Volgnummer = $leveringnummer]/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon[translate(tia:IMKAD_Persoon/tia:tia_IndGerechtigde, $upper, $lower) = 'true'])"/>
			<xsl:variable name="acquirerParty" select="../tia:Partij[@id = substring-after(current()/../tia:StukdeelLevering[tia:tia_Volgnummer = $leveringnummer]/tia:verkrijgerRechtRef/@xlink:href, '#')]"/>
			<xsl:variable name="koopakte" select="tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
				translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
				translate(normalize-space(current()/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
			<xsl:variable name="koopAkteCapitalized" select="concat(translate(substring($koopakte, 1, 1), $lower, $upper), substring($koopakte, 2))"/>
			<xsl:variable name="ditDezeKoopakte">
				<xsl:choose>
					<xsl:when test="normalize-space(tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst) = normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst[1])">
						<xsl:text>Dit </xsl:text>
					</xsl:when>
					<xsl:when test="normalize-space($koopakte) != ''">
						<xsl:text>Deze </xsl:text>
					</xsl:when>
				</xsl:choose>
				<xsl:value-of select="$koopakte"/>
			</xsl:variable>
			<xsl:variable name="deHet">
				<xsl:choose>
					<xsl:when test="normalize-space(tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst) = normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst[1])">
						<xsl:text>het </xsl:text>
					</xsl:when>
					<xsl:when test="normalize-space($koopakte) != ''">
						<xsl:text>de </xsl:text>
					</xsl:when>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="deHetKoopakte">
				<xsl:value-of select="$deHet"/>
				<xsl:value-of select="$koopAkteCapitalized"/>
			</xsl:variable>
			<xsl:variable name="koopakteNext" select="tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
				translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
				translate(normalize-space(current()/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
			<xsl:variable name="koopAkteCapitalizedNext" select="concat(translate(substring($koopakteNext, 1, 1), $lower, $upper), substring($koopakteNext, 2))"/>
			<xsl:variable name="deHetNext">
				<xsl:choose>
					<xsl:when test="normalize-space(tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst) = normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst[1])">
						<xsl:text>het </xsl:text>
					</xsl:when>
					<xsl:when test="normalize-space($koopakteNext) != ''">
						<xsl:text>de </xsl:text>
					</xsl:when>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="deHetKoopakteNext">
				<xsl:value-of select="$deHetNext"/>
				<xsl:value-of select="$koopAkteCapitalizedNext"/>
			</xsl:variable>
			<xsl:variable name="ditDezeKoopakteNext">
				<xsl:choose>
					<xsl:when test="normalize-space(tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst) = normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst[1])">
						<xsl:text>Dit </xsl:text>
					</xsl:when>
					<xsl:when test="normalize-space($koopakteNext) != ''">
						<xsl:text>Deze </xsl:text>
					</xsl:when>
				</xsl:choose>
				<xsl:value-of select="$koopakteNext"/>
			</xsl:variable>
			<xsl:variable name="colspan">
				<xsl:choose>
					<xsl:when test="translate(tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_cessie']/tia:tekst, $upper, $lower) = 'true'">
						<xsl:text>2</xsl:text>
					</xsl:when>
				</xsl:choose>
			</xsl:variable>
			<h2 class="header">
				<xsl:text>KOOP</xsl:text>
			</h2>
			<table cellpadding="0" cellspacing="0">
				<tbody>
					<tr>
						<td class="number" valign="top">
							<xsl:text>1.</xsl:text>
						</td>
						<td>
							<xsl:if test="$colspan != ''">
								<xsl:attribute name="colspan"><xsl:value-of select="$colspan"/></xsl:attribute>
							</xsl:if>
							<xsl:text>Door </xsl:text>
							<xsl:choose>
								<xsl:when test="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
									<xsl:value-of select="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
								</xsl:when>
								<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
									<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
								</xsl:when>
							</xsl:choose>
							<xsl:text> is met </xsl:text>
							<xsl:choose>
								<xsl:when test="../tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]">
									<xsl:value-of select="../tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
								</xsl:when>
								<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]">
									<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
								</xsl:when>
							</xsl:choose>
							<xsl:text> op </xsl:text>
							<xsl:value-of select="$Datum_STRING1"/>
							<xsl:text> een </xsl:text>
							<xsl:value-of select="$koopakte"/>
							<xsl:text> gesloten betreffende </xsl:text>
							<xsl:choose>
								<xsl:when test="count(../tia:StukdeelLevering[tia:tia_Volgnummer = $leveringnummer]/tia:IMKAD_ZakelijkRecht) > 1">
									<xsl:text>de </xsl:text>
								</xsl:when>
								<xsl:when test="count(../tia:StukdeelLevering[tia:tia_Volgnummer = $leveringnummer]/tia:IMKAD_ZakelijkRecht) = 1">
									<xsl:text>het </xsl:text>
								</xsl:when>
							</xsl:choose>
							<xsl:text>hierna te vermelden registergoed</xsl:text>
							<xsl:if test="count(../tia:StukdeelLevering[tia:tia_Volgnummer = $leveringnummer]/tia:IMKAD_ZakelijkRecht) > 1">
								<xsl:text>eren</xsl:text>
							</xsl:if>
							<xsl:text>, hierna te noemen: "</xsl:text>
							<u>
								<xsl:choose>
									<xsl:when test="tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopaktevolgnummer']/tia:tekst = 'true'">
										<xsl:value-of select="$koopAkteCapitalized"/>
										<xsl:text> </xsl:text>
										<xsl:value-of select="count(preceding-sibling::tia:StukdeelKoop) + 1"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="$deHetKoopakte"/>
									</xsl:otherwise>
								</xsl:choose>
							</u>
							<xsl:text>". </xsl:text>
							<xsl:if test="tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_akteaangehecht']/tia:tekst = 'true'">
								<xsl:choose>
									<xsl:when test="(count(preceding-sibling::tia:StukdeelKoop[count(preceding-sibling::tia:StukdeelKoop) mod 2 = 0]) + 1) = 0
										or not(tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopaktevolgnummer']/tia:tekst = 'true')">
										<xsl:value-of select="$ditDezeKoopakte"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="$koopAkteCapitalized"/>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:if test="tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopaktevolgnummer']/tia:tekst = 'true'">
									<xsl:text> </xsl:text>
									<xsl:value-of select="count(preceding-sibling::tia:StukdeelKoop) + 1"/>
									<xsl:text> </xsl:text>
								</xsl:if>
								<xsl:text> is als bijlage aan deze akte gehecht.</xsl:text>
							</xsl:if>
						</td>
					</tr>
					<tr>
						<td class="number" valign="top">
							<xsl:text>2.</xsl:text>
						</td>
						<td>
							<xsl:if test="$colspan != ''">
								<xsl:attribute name="colspan"><xsl:value-of select="$colspan"/></xsl:attribute>
							</xsl:if>
							<xsl:text>Vervolgens is door </xsl:text>
							<xsl:choose>
								<xsl:when test="../tia:Partij[@id = substring-after($nextKoop/tia:vervreemderRechtRef/@xlink:href, '#')]">
									<xsl:value-of select="../tia:Partij[@id = substring-after($nextKoop/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
								</xsl:when>
								<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after($nextKoop/tia:vervreemderRechtRef/@xlink:href, '#')]">
									<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after($nextKoop/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
								</xsl:when>
							</xsl:choose>
							<xsl:text> met </xsl:text>
							<xsl:choose>
								<xsl:when test="../tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]">
									<xsl:value-of select="../tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
								</xsl:when>
								<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]">
									<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
								</xsl:when>
							</xsl:choose>
							<xsl:text> op </xsl:text>
							<xsl:value-of select="$Datum_STRING2"/>
							<xsl:text> een </xsl:text>
							<xsl:value-of select="$koopakte"/>
							<xsl:text> gesloten betreffende zijn rechten uit </xsl:text>
							<xsl:choose>
								<xsl:when test="$nextKoop/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopaktevolgnummer']/tia:tekst = 'true'">
									<xsl:value-of select="$koopAkteCapitalizedNext"/>
									<xsl:text> </xsl:text>
									<xsl:value-of select="count(preceding-sibling::tia:StukdeelKoop) + 1"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$deHetKoopakteNext"/>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:text> met </xsl:text>
							<xsl:choose>
								<xsl:when test="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
									<xsl:value-of select="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
								</xsl:when>
								<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
									<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
								</xsl:when>
							</xsl:choose>
							<xsl:text> met betrekking tot </xsl:text>
							<xsl:choose>
								<xsl:when test="count(../tia:StukdeelLevering[tia:tia_Volgnummer = $leveringnummer]/tia:IMKAD_ZakelijkRecht) > 1">
									<xsl:text>de</xsl:text>
								</xsl:when>
								<xsl:when test="count(../tia:StukdeelLevering[tia:tia_Volgnummer = $leveringnummer]/tia:IMKAD_ZakelijkRecht) = 1">
									<xsl:text>het</xsl:text>
								</xsl:when>
							</xsl:choose>
							<xsl:text> hierna te vermelden registergoed</xsl:text>
							<xsl:if test="count(../tia:StukdeelLevering[tia:tia_Volgnummer = $leveringnummer]/tia:IMKAD_ZakelijkRecht) > 1">
								<xsl:text>eren</xsl:text>
							</xsl:if>
							<xsl:text>, hierna te noemen: "</xsl:text>
							<u>
								<xsl:choose>
									<xsl:when test="$nextKoop/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopaktevolgnummer']/tia:tekst = 'true'">
										<xsl:value-of select="$koopAkteCapitalizedNext"/>
										<xsl:text> </xsl:text>
										<xsl:value-of select="count($nextKoop/preceding-sibling::tia:StukdeelKoop) + 1"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="$deHetKoopakteNext"/>
									</xsl:otherwise>
								</xsl:choose>
							</u>
							<xsl:text>". </xsl:text>
							<xsl:if test="$nextKoop/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_akteaangehecht']/tia:tekst = 'true'">
								<xsl:choose>
									<xsl:when test="(count($nextKoop/preceding-sibling::tia:StukdeelKoop[count(preceding-sibling::tia:StukdeelKoop) mod 2 = 0]) + 1) = 0
										or not($nextKoop/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopaktevolgnummer']/tia:tekst = 'true')">
										<xsl:value-of select="$ditDezeKoopakteNext"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="$koopAkteCapitalizedNext"/>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:if test="$nextKoop/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopaktevolgnummer']/tia:tekst = 'true'">
									<xsl:text> </xsl:text>
									<xsl:value-of select="count($nextKoop/preceding-sibling::tia:StukdeelKoop) + 1"/>
									<xsl:text> </xsl:text>
								</xsl:if>
								<xsl:text> is </xsl:text>
								<xsl:if test="tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_akteaangehecht']/tia:tekst = 'true'">
									<xsl:text>eveneens </xsl:text>
								</xsl:if>
								<xsl:text>als bijlage aan deze akte gehecht.</xsl:text>
							</xsl:if>
						</td>
					</tr>
					<xsl:choose>
						<xsl:when test="translate(tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_cessie']/tia:tekst, $upper, $lower) = 'false'">
							<tr>
								<td class="number" valign="top">
									<xsl:text>3.</xsl:text>
								</td>
								<td>
									<xsl:choose>
										<xsl:when test="../tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]">
											<xsl:call-template name="capitalizePartyAlias">
												<xsl:with-param name="party" select="../tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]"/>
											</xsl:call-template>
										</xsl:when>
										<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]">
											<xsl:call-template name="capitalizePartyAlias">
												<xsl:with-param name="party" select="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]"/>
											</xsl:call-template>
										</xsl:when>
									</xsl:choose>
									<xsl:text> heeft vervolgens de rechten uit </xsl:text>
									<xsl:choose>
										<xsl:when test="$nextKoop/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopaktevolgnummer']/tia:tekst = 'true'">
											<xsl:value-of select="$koopAkteCapitalizedNext"/>
											<xsl:text> </xsl:text>
											<xsl:value-of select="count(preceding-sibling::tia:StukdeelKoop) + 1"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="$deHetKoopakteNext"/>
										</xsl:otherwise>
									</xsl:choose>
									<xsl:text> met </xsl:text>
									<xsl:choose>
										<xsl:when test="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
										<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
									</xsl:choose>
									<xsl:text> ter voldoening aan </xsl:text>
									<xsl:value-of select="$koopAkteCapitalizedNext"/>
									<xsl:if test="$nextKoop/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopaktevolgnummer']/tia:tekst = 'true'">
										<xsl:text> </xsl:text>
										<xsl:value-of select="count($nextKoop/preceding-sibling::tia:StukdeelKoop) + 1"/>
									</xsl:if>
									<xsl:text> aan </xsl:text>
									<xsl:choose>
										<xsl:when test="../tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
										<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
									</xsl:choose>
									<xsl:text> geleverd, waarvan mededeling is gedaan aan </xsl:text>
									<xsl:choose>
										<xsl:when test="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
										<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
									</xsl:choose>
									<xsl:text>. Bij deze akte </xsl:text>
									<xsl:choose>
										<xsl:when test="$numberOfRegisteredObjects = 1">
											<xsl:text>wordt het hierna te vermelden registergoed door </xsl:text>
										</xsl:when>
										<xsl:when test="$numberOfRegisteredObjects > 1">
											<xsl:text>worden de hierna te vermelden registergoederen door </xsl:text>
										</xsl:when>
									</xsl:choose>
									<xsl:choose>
										<xsl:when test="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
										<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
									</xsl:choose>
									<xsl:text> rechtstreeks aan </xsl:text>
									<xsl:choose>
										<xsl:when test="../tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
										<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
									</xsl:choose>
									<xsl:text> geleverd.</xsl:text>
								</td>
							</tr>
						</xsl:when>
						<xsl:when test="translate(tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_cessie']/tia:tekst, $upper, $lower) = 'true'">
							<tr>
								<td class="number" valign="top">
									<xsl:text>3.</xsl:text>
								</td>
								<td>
									<xsl:if test="$colspan != ''">
										<xsl:attribute name="colspan"><xsl:value-of select="$colspan"/></xsl:attribute>
									</xsl:if>
									<xsl:call-template name="capitalizePartyAlias">
										<xsl:with-param name="party" select="../tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]"/>
									</xsl:call-template>
									<xsl:text> draagt hierbij alle rechten uit </xsl:text>
									<xsl:choose>
										<xsl:when test="tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopaktevolgnummer']/tia:tekst = 'true'">
											<xsl:value-of select="$koopAkteCapitalized"/>
											<xsl:text> </xsl:text>
											<xsl:value-of select="count(preceding-sibling::tia:StukdeelKoop) + 1"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="$deHetKoopakte"/>
										</xsl:otherwise>
									</xsl:choose>
									<xsl:text> met </xsl:text>
									<xsl:choose>
										<xsl:when test="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
										<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
									</xsl:choose>
									<xsl:text>, in het bijzonder het recht om van </xsl:text>
									<xsl:choose>
										<xsl:when test="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
										<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
									</xsl:choose>
									<xsl:text> de levering in onvoorwaardelijke, volle en vrije eigendom van </xsl:text>
									<xsl:choose>
										<xsl:when test="count(../tia:StukdeelLevering[tia:tia_Volgnummer = $leveringnummer]/tia:IMKAD_ZakelijkRecht) > 1">
											<xsl:text>de</xsl:text>
										</xsl:when>
										<xsl:when test="count(../tia:StukdeelLevering[tia:tia_Volgnummer = $leveringnummer]/tia:IMKAD_ZakelijkRecht) = 1">
											<xsl:text>het</xsl:text>
										</xsl:when>
									</xsl:choose>
									<xsl:text> hierna vermelde registergoed</xsl:text>
									<xsl:if test="count(../tia:StukdeelLevering[tia:tia_Volgnummer = $leveringnummer]/tia:IMKAD_ZakelijkRecht) > 1">
										<xsl:text>eren</xsl:text>
									</xsl:if>
									<xsl:text> te vorderen, over aan </xsl:text>
									<xsl:choose>
										<xsl:when test="../tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
										<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
									</xsl:choose>
									<xsl:text>, welke overdracht </xsl:text>
									<xsl:choose>
										<xsl:when test="../tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
										<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
									</xsl:choose>
									<xsl:text> hierbij aanvaardt, een en ander op grond van </xsl:text>
									<xsl:choose>
										<xsl:when test="tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopaktevolgnummer']/tia:tekst = 'true'">
											<xsl:value-of select="$koopAkteCapitalized"/>
											<xsl:text> </xsl:text>
											<xsl:value-of select="count(preceding-sibling::tia:StukdeelKoop) + 1"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="$deHetKoopakte"/>
										</xsl:otherwise>
									</xsl:choose>
									<xsl:text> en met dien verstande dat een mededeling, als bedoeld hierna, nog gedaan dient te worden.</xsl:text>
									<br/>
									<xsl:text>Alle rechten en nevenrechten die uit </xsl:text>
									<xsl:choose>
										<xsl:when test="tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopaktevolgnummer']/tia:tekst = 'true'">
											<xsl:value-of select="$koopAkteCapitalized"/>
											<xsl:text> </xsl:text>
											<xsl:value-of select="count(preceding-sibling::tia:StukdeelKoop) + 1"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="$deHetKoopakte"/>
										</xsl:otherwise>
									</xsl:choose>
									<xsl:text> tussen </xsl:text>
									<xsl:choose>
										<xsl:when test="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
										<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
									</xsl:choose>
									<xsl:text> en </xsl:text>
									<xsl:choose>
										<xsl:when test="../tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
										<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
									</xsl:choose>
									<xsl:text> voortvloeien, waaronder begrepen de rechten uit hoofde van eventuele arbitrage- en bindend-adviesclausules, een en ander met inbegrip van de daaraan verbonden verplichtingen, gaan bij deze van rechtswege over op </xsl:text>
									<xsl:choose>
										<xsl:when test="../tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
										<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
									</xsl:choose>
									<xsl:text>.</xsl:text>
									<br/>
									<xsl:choose>
										<xsl:when test="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
											<xsl:call-template name="capitalizePartyAlias">
												<xsl:with-param name="party" select="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]"/>
											</xsl:call-template>
										</xsl:when>
										<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
											<xsl:call-template name="capitalizePartyAlias">
												<xsl:with-param name="party" select="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]"/>
											</xsl:call-template>
										</xsl:when>
									</xsl:choose>
									<xsl:text> verklaart dat deze cessie aan hem is medegedeeld en deze door </xsl:text>
									<xsl:choose>
										<xsl:when test="../tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
										<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
									</xsl:choose>
									<xsl:text> gedane cessie te erkennen.</xsl:text>
									<br/>
									<xsl:choose>
										<xsl:when test="../tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]">
											<xsl:call-template name="capitalizePartyAlias">
												<xsl:with-param name="party" select="../tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]"/>
											</xsl:call-template>
										</xsl:when>
										<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]">
											<xsl:call-template name="capitalizePartyAlias">
												<xsl:with-param name="party" select="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]"/>
											</xsl:call-template>
										</xsl:when>
									</xsl:choose>
									<xsl:text> staat er voor in:</xsl:text>
								</td>
							</tr>
							<tr>
								<td class="number" valign="top">
									<xsl:text>&#xFEFF;</xsl:text>
								</td>
								<td class="number" valign="top">
									<xsl:text>-</xsl:text>
								</td>
								<td>
									<xsl:text>dat </xsl:text>
									<xsl:choose>
										<xsl:when test="tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopaktevolgnummer']/tia:tekst = 'true'">
											<xsl:value-of select="$koopAkteCapitalized"/>
											<xsl:text> </xsl:text>
											<xsl:value-of select="count(preceding-sibling::tia:StukdeelKoop) + 1"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="$deHetKoopakte"/>
										</xsl:otherwise>
									</xsl:choose>
									<xsl:text> bestaat en dat de rechten daaruit overdraagbaar zijn en dat zij niet aantastbaar is op grond van juridische verweren van </xsl:text>
									<xsl:choose>
										<xsl:when test="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
										<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
									</xsl:choose>
									<xsl:text>;</xsl:text>
								</td>
							</tr>
							<tr>
								<td class="number" valign="top">
									<xsl:text>&#xFEFF;</xsl:text>
								</td>
								<td class="number" valign="top">
									<xsl:text>-</xsl:text>
								</td>
								<td>
									<xsl:text>dat hij volledig bevoegd is de rechten uit voornoemde </xsl:text>
									<xsl:choose>
										<xsl:when test="tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopaktevolgnummer']/tia:tekst = 'true'">
											<xsl:value-of select="$koopAkteCapitalized"/>
											<xsl:text> </xsl:text>
											<xsl:value-of select="count(preceding-sibling::tia:StukdeelKoop) + 1"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="$deHetKoopakte"/>
										</xsl:otherwise>
									</xsl:choose>
									<xsl:text> over te dragen en dat die rechten onbeslagen zijn en ook niet bezwaard zijn met enig zekerheidsrecht.</xsl:text>
								</td>
							</tr>
						</xsl:when>
					</xsl:choose>
				</tbody>
			</table>
		</xsl:for-each>
		<xsl:for-each select="tia:StukdeelLevering">
			<xsl:variable name="koopovereenkomstnummer" select="number(current()/tia:tia_Volgnummer) * 2 - 1"/>
			<xsl:variable name="koopLevering" select="../tia:StukdeelKoop[tia:tia_Volgnummer = $koopovereenkomstnummer]"/>
			<xsl:variable name="koopakteLevering" select="$koopLevering/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
				translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
				translate(normalize-space($koopLevering/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
			<xsl:variable name="koopAkteCapitalizedLevering" select="concat(translate(substring($koopakteLevering, 1, 1), $lower, $upper), substring($koopakteLevering, 2))"/>
			<xsl:variable name="deHetLevering">
				<xsl:choose>
					<xsl:when test="normalize-space(../tia:StukdeelKoop[tia:tia_Volgnummer = $koopovereenkomstnummer]/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst) = normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst[1])">
						<xsl:text>het </xsl:text>
					</xsl:when>
					<xsl:when test="normalize-space($koopakteLevering) != ''">
						<xsl:text>de </xsl:text>
					</xsl:when>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="deHetKoopakteLevering">
				<xsl:value-of select="$deHetLevering"/>
				<xsl:value-of select="$koopAkteCapitalizedLevering"/>
			</xsl:variable>
			<xsl:variable name="numberOfBuyersLevering" select="count(../tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true'])
				+ count(../tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:IMKAD_Persoon/tia:GerelateerdPersoon[translate(tia:IMKAD_Persoon/tia:tia_IndGerechtigde, $upper, $lower) = 'true'])
				+ count(../tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon[translate(tia:IMKAD_Persoon/tia:tia_IndGerechtigde, $upper, $lower) = 'true'])"/>
			<xsl:variable name="undividedLevering">
				<xsl:choose>
					<xsl:when test="translate(tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst, $upper, $lower) = 'true'">
						<xsl:choose>
							<xsl:when test="$numberOfBuyersLevering = 2">
								<xsl:text>onverdeelde </xsl:text>
							</xsl:when>
							<xsl:when test="$numberOfBuyersLevering > 2">
								<xsl:text>onverdeeld </xsl:text>
							</xsl:when>
							<xsl:otherwise>
								<xsl:text/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="acquirerPartyLevering" select="../tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]"/>
			<xsl:variable name="nestedPartyLevering" select="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]"/>
			<xsl:variable name="acquirerPersonsLevering" select="../tia:Partij/descendant-or-self::tia:IMKAD_Persoon[concat('#', @id) = $nestedPartyLevering/tia:partijPersoonRef/@xlink:href]"/>
			<xsl:variable name="numberOfRegisteredObjectsLevering" select="count(tia:IMKAD_ZakelijkRecht)"/>
			<xsl:variable name="registergoedAanduidingHetRegistergoed" select="tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst, $upper, $lower) = 'het registergoed'][1]"/>
			<xsl:variable name="registergoedAanduidingDeRegistergoederen" select="tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst, $upper, $lower) = 'de registergoederen'][1]"/>
			<xsl:variable name="registergoedAanduidingHetVerkochte" select="tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst, $upper, $lower) = 'het verkochte'][1]"/>
			<h2 class="header">LEVERING</h2>
			<p>
				<xsl:text>Vervolgens levert </xsl:text>
				<xsl:choose>
					<xsl:when test="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
						<xsl:value-of select="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
					</xsl:when>
					<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
						<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
					</xsl:when>
				</xsl:choose>
				<xsl:text>, ter uitvoering van </xsl:text>
				<xsl:choose>
					<xsl:when test="$koopLevering/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopaktevolgnummer']/tia:tekst = 'true'">
						<xsl:value-of select="$koopAkteCapitalizedLevering"/>
						<xsl:text> </xsl:text>
						<xsl:value-of select="$koopovereenkomstnummer"/>
						<xsl:text> en </xsl:text>
						<xsl:value-of select="$koopAkteCapitalizedLevering"/>
						<xsl:text> </xsl:text>
						<xsl:value-of select="$koopovereenkomstnummer + 1"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$deHetKoopakteLevering"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:text>, hierbij aan </xsl:text>
				<xsl:apply-templates select=".." mode="do-purchase-distribution-paragraph-part">
					<xsl:with-param name="numberOfBuyers" select="$numberOfBuyersLevering"/>
					<xsl:with-param name="undivided" select="$undividedLevering"/>
					<xsl:with-param name="acquirerParty" select="$acquirerPartyLevering"/>
					<xsl:with-param name="acquirerPersons" select="$acquirerPersonsLevering"/>
				</xsl:apply-templates>
			</p>
			<p>
				<xsl:text>OMSCHRIJVING REGISTERGOED</xsl:text>
				<xsl:if test="$numberOfRegisteredObjectsLevering > 1">
					<xsl:text>EREN</xsl:text>
				</xsl:if>
			</p>
			<xsl:apply-templates select="." mode="do-registered-objects-deed-of-transfer"/>
			<xsl:if test="tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekst']/tia:tekst, $upper, $lower) = 'true']">
				<xsl:if test="$registergoedAanduidingHetRegistergoed">
					<p>
						<xsl:if test="translate($registergoedAanduidingHetRegistergoed/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedvolgnummeropsomming']/tia:tekst, $upper, $lower) = 'true'">
							<xsl:for-each select="tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst, $upper, $lower)
													= translate($registergoedAanduidingHetRegistergoed/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst, $upper, $lower)]">
								<xsl:text>Registergoed </xsl:text>
								<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
								<xsl:choose>
									<xsl:when test="position() = last() - 1">
										<xsl:text> en </xsl:text>
									</xsl:when>
									<xsl:when test="position() != last()">
										<xsl:text>, </xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text> </xsl:text>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:for-each>
						</xsl:if>
						<xsl:text>hierna</xsl:text>
						<xsl:if test="translate(normalize-space($registergoedAanduidingHetRegistergoed/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekstfragment']/tia:tekst), $upper, $lower)
									= translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekstfragment']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
												translate(normalize-space($registergoedAanduidingHetRegistergoed/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekstfragment']/tia:tekst), $upper, $lower)]), $upper, $lower)">
							<xsl:text> </xsl:text>
							<xsl:value-of select="translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekstfragment']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
									translate(normalize-space($registergoedAanduidingHetRegistergoed/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekstfragment']/tia:tekst), $upper, $lower)]), $upper, $lower)"/>
						</xsl:if>
						<xsl:text>: "</xsl:text>
						<u>
							<xsl:value-of select="$registergoedAanduidingHetRegistergoed/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst"/>
						</u>
						<xsl:text>".</xsl:text>
					</p>
				</xsl:if>
				<xsl:if test="$registergoedAanduidingDeRegistergoederen">
					<p>
						<xsl:if test="translate($registergoedAanduidingDeRegistergoederen/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedvolgnummeropsomming']/tia:tekst, $upper, $lower) = 'true'">
							<xsl:for-each select="tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst, $upper, $lower)
													= translate($registergoedAanduidingDeRegistergoederen/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst, $upper, $lower)]">
								<xsl:text>Registergoed </xsl:text>
								<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
								<xsl:choose>
									<xsl:when test="position() = last() - 1">
										<xsl:text> en </xsl:text>
									</xsl:when>
									<xsl:when test="position() != last()">
										<xsl:text>, </xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text> </xsl:text>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:for-each>
						</xsl:if>
						<xsl:text>hierna</xsl:text>
						<xsl:if test="translate(normalize-space($registergoedAanduidingDeRegistergoederen/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekstfragment']/tia:tekst), $upper, $lower)
									= translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekstfragment']/tia:tekst[translate(normalize-space(.), $upper, $lower) = translate(normalize-space($registergoedAanduidingDeRegistergoederen/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekstfragment']/tia:tekst), $upper, $lower)]), $upper, $lower)">
							<xsl:text> </xsl:text>
							<xsl:value-of select="translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekstfragment']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
									translate(normalize-space($registergoedAanduidingDeRegistergoederen/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekstfragment']/tia:tekst), $upper, $lower)]), $upper, $lower)"/>
						</xsl:if>
						<xsl:text>: "</xsl:text>
						<u>
							<xsl:value-of select="$registergoedAanduidingDeRegistergoederen/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst"/>
						</u>
						<xsl:text>".</xsl:text>
					</p>
				</xsl:if>
				<xsl:if test="$registergoedAanduidingHetVerkochte">
					<p>
						<xsl:if test="translate($registergoedAanduidingHetVerkochte/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedvolgnummeropsomming']/tia:tekst, $upper, $lower) = 'true'">
							<xsl:for-each select="tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst, $upper, $lower)
													= translate($registergoedAanduidingHetVerkochte/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst, $upper, $lower)]">
								<xsl:text>Registergoed </xsl:text>
								<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
								<xsl:choose>
									<xsl:when test="position() = last() - 1">
										<xsl:text> en </xsl:text>
									</xsl:when>
									<xsl:when test="position() != last()">
										<xsl:text>, </xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text> </xsl:text>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:for-each>
						</xsl:if>
						<xsl:text>hierna</xsl:text>
						<xsl:if test="translate(normalize-space($registergoedAanduidingHetVerkochte/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekstfragment']/tia:tekst), $upper, $lower)
									= translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekstfragment']/tia:tekst[translate(normalize-space(.), $upper, $lower) = translate(normalize-space($registergoedAanduidingHetVerkochte/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekstfragment']/tia:tekst), $upper, $lower)]), $upper, $lower)">
							<xsl:text> </xsl:text>
							<xsl:value-of select="translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekstfragment']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
									translate(normalize-space($registergoedAanduidingHetVerkochte/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekstfragment']/tia:tekst), $upper, $lower)]), $upper, $lower)"/>
						</xsl:if>
						<xsl:text>: "</xsl:text>
						<u>
							<xsl:value-of select="$registergoedAanduidingHetVerkochte/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst"/>
						</u>
						<xsl:text>".</xsl:text>
					</p>
				</xsl:if>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-purchase-and-transfer-verkooprechtenmetindeplaatsstelling
	*********************************************************
	Public: no

	Identity transform: no

	Description: Deed of transfer purchase and transfer blocks.

	Input: tia:IMKAD_AangebodenStuk

	Params: none

	Output: XHTML structure

	Calls:
	(name) capitalizePartyAlias
	(mode) do-purchase-distribution-paragraph-part
	(mode) do-registered-objects-deed-of-transfer

	Called by:
	(mode) do-purchase-and-transfer
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_AangebodenStuk" mode="do-purchase-and-transfer-verkooprechtenmetindeplaatsstelling">
		<xsl:for-each select="tia:StukdeelKoop[count(preceding-sibling::tia:StukdeelKoop) mod 2 = 0]">
			<xsl:variable name="nextKoop" select="following-sibling::tia:StukdeelKoop[1]"/>
			<xsl:variable name="Datum_DATE1" select="substring(string(tia:koopovereenkomst/tia:datumOndertekening), 0, 11)"/>
			<xsl:variable name="Datum_STRING1">
				<xsl:if test="$Datum_DATE1 != ''">
					<xsl:value-of select="kef:convertDateToText($Datum_DATE1)"/>
				</xsl:if>
			</xsl:variable>
			<xsl:variable name="Datum_DATE2" select="substring(string($nextKoop/tia:koopovereenkomst/tia:datumOndertekening), 0, 11)"/>
			<xsl:variable name="Datum_STRING2">
				<xsl:if test="$Datum_DATE2 != ''">
					<xsl:value-of select="kef:convertDateToText($Datum_DATE2)"/>
				</xsl:if>
			</xsl:variable>
			<xsl:variable name="leveringnummer" select="(number(current()/tia:tia_Volgnummer) + 1) div 2"/>
			<xsl:variable name="numberOfRegisteredObjects" select="count(../tia:StukdeelLevering[tia:tia_Volgnummer = $leveringnummer]/tia:IMKAD_ZakelijkRecht)"/>
			<xsl:variable name="numberOfBuyers" select="count(tia:Partij[@id = substring-after(current()/../tia:StukdeelLevering[tia:tia_Volgnummer = $leveringnummer]/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true'])
				+ count(tia:Partij[@id = substring-after(current()/../tia:StukdeelLevering[tia:tia_Volgnummer = $leveringnummer]/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:IMKAD_Persoon/tia:GerelateerdPersoon[translate(tia:IMKAD_Persoon/tia:tia_IndGerechtigde, $upper, $lower) = 'true'])
				+ count(tia:Partij[@id = substring-after(current()/../tia:StukdeelLevering[tia:tia_Volgnummer = $leveringnummer]/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon[translate(tia:IMKAD_Persoon/tia:tia_IndGerechtigde, $upper, $lower) = 'true'])"/>
			<xsl:variable name="acquirerParty" select="tia:Partij[@id = substring-after(current()/../tia:StukdeelLevering[tia:tia_Volgnummer = $leveringnummer]/tia:verkrijgerRechtRef/@xlink:href, '#')]"/>
			<xsl:variable name="koopakte" select="tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
				translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
				translate(normalize-space(current()/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
			<xsl:variable name="koopAkteCapitalized" select="concat(translate(substring($koopakte, 1, 1), $lower, $upper), substring($koopakte, 2))"/>
			<xsl:variable name="ditDezeKoopakte">
				<xsl:choose>
					<xsl:when test="normalize-space(tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst) = normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst[1])">
						<xsl:text> Dit </xsl:text>
					</xsl:when>
					<xsl:when test="normalize-space($koopakte) != ''">
						<xsl:text> Deze </xsl:text>
					</xsl:when>
				</xsl:choose>
				<xsl:value-of select="$koopakte"/>
			</xsl:variable>
			<xsl:variable name="deHet">
				<xsl:choose>
					<xsl:when test="normalize-space(tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst) = normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst[1])">
						<xsl:text>het </xsl:text>
					</xsl:when>
					<xsl:when test="normalize-space($koopakte) != ''">
						<xsl:text>de </xsl:text>
					</xsl:when>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="deHetKoopakte">
				<xsl:value-of select="$deHet"/>
				<xsl:value-of select="$koopAkteCapitalized"/>
			</xsl:variable>
			<xsl:variable name="koopakteNext" select="tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
				translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
				translate(normalize-space(current()/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
			<xsl:variable name="koopAkteCapitalizedNext" select="concat(translate(substring($koopakteNext, 1, 1), $lower, $upper), substring($koopakteNext, 2))"/>
			<xsl:variable name="deHetNext">
				<xsl:choose>
					<xsl:when test="normalize-space(tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst) = normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst[1])">
						<xsl:text>het </xsl:text>
					</xsl:when>
					<xsl:when test="normalize-space($koopakteNext) != ''">
						<xsl:text>de </xsl:text>
					</xsl:when>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="deHetKoopakteNext">
				<xsl:value-of select="$deHetNext"/>
				<xsl:value-of select="$koopAkteCapitalizedNext"/>
			</xsl:variable>
			<xsl:variable name="ditDezeKoopakteNext">
				<xsl:choose>
					<xsl:when test="normalize-space(tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst) = normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst[1])">
						<xsl:text> Dit </xsl:text>
					</xsl:when>
					<xsl:when test="normalize-space($koopakteNext) != ''">
						<xsl:text> Deze </xsl:text>
					</xsl:when>
				</xsl:choose>
				<xsl:value-of select="$koopakteNext"/>
			</xsl:variable>
			<h2 class="header">
				<xsl:text>KOOP</xsl:text>
			</h2>
			<table cellpadding="0" cellspacing="0">
				<tbody>
					<tr>
						<td class="number" valign="top">
							<xsl:text>1.</xsl:text>
						</td>
						<td>
							<xsl:text>Door </xsl:text>
							<xsl:choose>
								<xsl:when test="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
									<xsl:value-of select="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
								</xsl:when>
								<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
									<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
								</xsl:when>
							</xsl:choose>
							<xsl:text> is met </xsl:text>
							<xsl:choose>
								<xsl:when test="../tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]">
									<xsl:value-of select="../tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
								</xsl:when>
								<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]">
									<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
								</xsl:when>
							</xsl:choose>
							<xsl:text> op </xsl:text>
							<xsl:value-of select="$Datum_STRING1"/>
							<xsl:text> een </xsl:text>
							<xsl:value-of select="$koopakte"/>
							<xsl:text> gesloten betreffende </xsl:text>
							<xsl:choose>
								<xsl:when test="count(current()/../tia:StukdeelLevering[tia:tia_Volgnummer = $leveringnummer]/tia:IMKAD_ZakelijkRecht) > 1">
									<xsl:text>de </xsl:text>
								</xsl:when>
								<xsl:when test="count(current()/../tia:StukdeelLevering[tia:tia_Volgnummer = $leveringnummer]/tia:IMKAD_ZakelijkRecht) = 1">
									<xsl:text>het </xsl:text>
								</xsl:when>
							</xsl:choose>
							<xsl:text>hierna te vermelden registergoed</xsl:text>
							<xsl:if test="count(../tia:StukdeelLevering[tia:tia_Volgnummer = $leveringnummer]/tia:IMKAD_ZakelijkRecht) > 1">
								<xsl:text>eren</xsl:text>
							</xsl:if>
							<xsl:text>, hierna te noemen: "</xsl:text>
							<u>
								<xsl:choose>
									<xsl:when test="tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopaktevolgnummer']/tia:tekst = 'true'">
										<xsl:value-of select="$koopAkteCapitalized"/>
										<xsl:text> </xsl:text>
										<xsl:value-of select="count(preceding-sibling::tia:StukdeelKoop) + 1"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="$deHetKoopakte"/>
									</xsl:otherwise>
								</xsl:choose>
							</u>
							<xsl:text>". </xsl:text>
							<xsl:choose>
								<xsl:when test="(count(preceding-sibling::tia:StukdeelKoop[count(preceding-sibling::tia:StukdeelKoop) mod 2 = 0]) + 1) = 0
									or not(tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopaktevolgnummer']/tia:tekst = 'true')">
									<xsl:value-of select="$ditDezeKoopakte"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$koopAkteCapitalized"/>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:if test="tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopaktevolgnummer']/tia:tekst = 'true'">
								<xsl:text> </xsl:text>
								<xsl:value-of select="count(preceding-sibling::tia:StukdeelKoop) + 1"/>
								<xsl:text> </xsl:text>
							</xsl:if>
							<xsl:text> is als bijlage aan deze akte gehecht.</xsl:text>
						</td>
					</tr>
					<tr>
						<td class="number" valign="top">
							<xsl:text>2.</xsl:text>
						</td>
						<td>
							<xsl:text>Vervolgens is door </xsl:text>
							<xsl:choose>
								<xsl:when test="../tia:Partij[@id = substring-after($nextKoop/tia:vervreemderRechtRef/@xlink:href, '#')]">
									<xsl:value-of select="../tia:Partij[@id = substring-after($nextKoop/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
								</xsl:when>
								<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after($nextKoop/tia:vervreemderRechtRef/@xlink:href, '#')]">
									<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after($nextKoop/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
								</xsl:when>
							</xsl:choose>
							<xsl:text> met </xsl:text>
							<xsl:choose>
								<xsl:when test="../tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]">
									<xsl:value-of select="../tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
								</xsl:when>
								<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]">
									<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
								</xsl:when>
							</xsl:choose>
							<xsl:text> op </xsl:text>
							<xsl:value-of select="$Datum_STRING2"/>
							<xsl:text> een </xsl:text>
							<xsl:value-of select="$koopakteNext"/>
							<xsl:text> gesloten betreffende </xsl:text>
							<xsl:choose>
								<xsl:when test="$nextKoop/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopaktevolgnummer']/tia:tekst = 'true'">
									<xsl:value-of select="$koopAkteCapitalizedNext"/>
									<xsl:text> </xsl:text>
									<xsl:value-of select="count($nextKoop/preceding-sibling::tia:StukdeelKoop) + 1"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$deHetKoopakteNext"/>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:text> met betrekking tot </xsl:text>
							<xsl:choose>
								<xsl:when test="count(../tia:StukdeelLevering[tia:tia_Volgnummer = $leveringnummer]/tia:IMKAD_ZakelijkRecht) > 1">
									<xsl:text>de</xsl:text>
								</xsl:when>
								<xsl:when test="count(../tia:StukdeelLevering[tia:tia_Volgnummer = $leveringnummer]/tia:IMKAD_ZakelijkRecht) = 1">
									<xsl:text>het</xsl:text>
								</xsl:when>
							</xsl:choose>
							<xsl:text> hierna te vermelden registergoed</xsl:text>
							<xsl:if test="count(../tia:StukdeelLevering[tia:tia_Volgnummer = $leveringnummer]/tia:IMKAD_ZakelijkRecht) > 1">
								<xsl:text>eren</xsl:text>
							</xsl:if>
							<xsl:text>, hierna te noemen: "</xsl:text>
							<u>
								<xsl:choose>
									<xsl:when test="$nextKoop/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopaktevolgnummer']/tia:tekst = 'true'">
										<xsl:value-of select="$koopAkteCapitalizedNext"/>
										<xsl:text> </xsl:text>
										<xsl:value-of select="count($nextKoop/preceding-sibling::tia:StukdeelKoop) + 1"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="$deHetKoopakteNext"/>
									</xsl:otherwise>
								</xsl:choose>
							</u>
							<xsl:text>". </xsl:text>
							<xsl:choose>
								<xsl:when test="(count($nextKoop/preceding-sibling::tia:StukdeelKoop[count(preceding-sibling::tia:StukdeelKoop) mod 2 = 0]) + 1) = 0
										or not($nextKoop/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopaktevolgnummer']/tia:tekst = 'true')">
									<xsl:value-of select="$ditDezeKoopakteNext"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$koopAkteCapitalizedNext"/>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:if test="$nextKoop/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopaktevolgnummer']/tia:tekst = 'true'">
								<xsl:text> </xsl:text>
								<xsl:value-of select="count($nextKoop/preceding-sibling::tia:StukdeelKoop) + 1"/>
								<xsl:text> </xsl:text>
							</xsl:if>
							<xsl:text> is eveneens als bijlage aan deze akte gehecht.</xsl:text>
						</td>
					</tr>
					<xsl:choose>
						<xsl:when test="translate(tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_contractsoverneming']/tia:tekst, $upper, $lower) = 'false'">
							<tr>
								<td class="number" valign="top">
									<xsl:text>3.</xsl:text>
								</td>
								<td>
									<xsl:text>Bij overeenkomst tussen </xsl:text>
									<xsl:choose>
										<xsl:when test="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
										<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
									</xsl:choose>
									<xsl:text>, </xsl:text>
									<xsl:choose>
										<xsl:when test="../tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
										<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
									</xsl:choose>
									<xsl:text> en </xsl:text>
									<xsl:choose>
										<xsl:when test="../tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
										<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
									</xsl:choose>
									<xsl:text> heeft </xsl:text>
									<xsl:choose>
										<xsl:when test="../tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
										<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
									</xsl:choose>
									<xsl:text> de volledige contractspositie van </xsl:text>
									<xsl:choose>
										<xsl:when test="../tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
										<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
									</xsl:choose>
									<xsl:text> in de overeenkomst met </xsl:text>
									<xsl:choose>
										<xsl:when test="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
										<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
									</xsl:choose>
									<xsl:text> overgenomen. Bij deze akte wordt ter uitvoering van </xsl:text>
									<xsl:choose>
										<xsl:when test="$nextKoop/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopaktevolgnummer']/tia:tekst = 'true'">
											<xsl:value-of select="$koopAkteCapitalizedNext"/>
											<xsl:text> </xsl:text>
											<xsl:value-of select="count($nextKoop/preceding-sibling::tia:StukdeelKoop) + 1"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="$deHetKoopakteNext"/>
										</xsl:otherwise>
									</xsl:choose>
									<xsl:text> tussen </xsl:text>
									<xsl:choose>
										<xsl:when test="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
										<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
									</xsl:choose>
									<xsl:text> en </xsl:text>
									<xsl:choose>
										<xsl:when test="../tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
										<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
									</xsl:choose>
									<xsl:choose>
										<xsl:when test="$numberOfRegisteredObjects = 1">
											<xsl:text> het hierna te vermelden registergoed aan </xsl:text>
										</xsl:when>
										<xsl:when test="$numberOfRegisteredObjects > 1">
											<xsl:text> de hierna te vermelden registergoederen aan </xsl:text>
										</xsl:when>
									</xsl:choose>
									<xsl:choose>
										<xsl:when test="../tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
										<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
									</xsl:choose>
									<xsl:text> geleverd.</xsl:text>
								</td>
							</tr>
						</xsl:when>
						<xsl:when test="translate(tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_contractsoverneming']/tia:tekst, $upper, $lower) = 'true'">
							<tr>
								<td class="number" valign="top">
									<xsl:text>3.</xsl:text>
								</td>
								<td>
									<xsl:text>Partijen komen overeen dat </xsl:text>
									<xsl:choose>
										<xsl:when test="../tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
										<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
									</xsl:choose>
									<xsl:text> de rechtsverhouding van </xsl:text>
									<xsl:choose>
										<xsl:when test="../tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
										<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
									</xsl:choose>
									<xsl:text> in de overeenkomst met </xsl:text>
									<xsl:choose>
										<xsl:when test="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
										<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
									</xsl:choose>
									<xsl:text> overneemt. Alle rechten met inbegrip van wilsrechten en verplichtingen uit hoofde van het contract van </xsl:text>
									<xsl:choose>
										<xsl:when test="../tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
										<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
									</xsl:choose>
									<xsl:text> op </xsl:text>
									<xsl:choose>
										<xsl:when test="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
										<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
									</xsl:choose>
									<xsl:text>, in het bijzonder het recht om van </xsl:text>
									<xsl:choose>
										<xsl:when test="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
										<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
									</xsl:choose>
									<xsl:text> de levering in onvoorwaardelijke, volle en vrije eigendom van </xsl:text>
									<xsl:choose>
										<xsl:when test="$numberOfRegisteredObjects = 1">
											<xsl:text> het hierna te vermelden registergoed te vorderen, gaan derhalve bij deze over op </xsl:text>
										</xsl:when>
										<xsl:when test="$numberOfRegisteredObjects > 1">
											<xsl:text> de hierna te vermelden registergoederen te vorderen, gaan derhalve bij deze over op </xsl:text>
										</xsl:when>
									</xsl:choose>
									<xsl:choose>
										<xsl:when test="../tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
										<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
									</xsl:choose>
									<xsl:text>. De verweermiddelen die </xsl:text>
									<xsl:choose>
										<xsl:when test="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
										<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
									</xsl:choose>
									<xsl:text> jegens </xsl:text>
									<xsl:choose>
										<xsl:when test="../tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
										<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
									</xsl:choose>
									<xsl:text> met betrekking tot zijn vorderingen kon doen gelden, kan hij voortaan jegens </xsl:text>
									<xsl:choose>
										<xsl:when test="../tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
										<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
									</xsl:choose>
									<xsl:text> doen gelden, zoals ook </xsl:text>
									<xsl:choose>
										<xsl:when test="../tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
										<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
									</xsl:choose>
									<xsl:text> de verweermiddelen die </xsl:text>
									<xsl:choose>
										<xsl:when test="../tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
										<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
									</xsl:choose>
									<xsl:text> tot nu toe jegens </xsl:text>
									<xsl:choose>
										<xsl:when test="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
										<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
									</xsl:choose>
									<xsl:text> kon inroepen, voortaan zelf tegen </xsl:text>
									<xsl:choose>
										<xsl:when test="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
										<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
									</xsl:choose>
									<xsl:text> kan inroepen.</xsl:text>
									<br/>
									<xsl:choose>
										<xsl:when test="../tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]">
											<xsl:call-template name="capitalizePartyAlias">
												<xsl:with-param name="party" select="../tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]"/>
											</xsl:call-template>
										</xsl:when>
										<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]">
											<xsl:call-template name="capitalizePartyAlias">
												<xsl:with-param name="party" select="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]"/>
											</xsl:call-template>
										</xsl:when>
									</xsl:choose>
									<xsl:text> verschaft aan </xsl:text>
									<xsl:choose>
										<xsl:when test="../tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
										<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
									</xsl:choose>
									<xsl:text> hierbij zo veel mogelijk alle bewijsstukken en eventuele executoriale titels met betrekking tot de op </xsl:text>
									<xsl:choose>
										<xsl:when test="../tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
										<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after($nextKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
									</xsl:choose>
									<xsl:text> overgaande hoofd-, wils- en nevenrechten, waaronder begrepen de akte van het hierbij overgenomen contract, in origineel. Voor het geval enig bewijsstuk of enige executoriale titel onder een derde berust, althans van een derde te verkrijgen is, machtigt </xsl:text>
									<xsl:choose>
										<xsl:when test="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
										<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
									</xsl:choose>
									<xsl:text> hierbij </xsl:text>
									<xsl:choose>
										<xsl:when test="../tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
										<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]">
											<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
										</xsl:when>
									</xsl:choose>
									<xsl:text> onherroepelijk om zelf dit stuk bij die derde op te vragen en eventueel in rechte op te vorderen.</xsl:text>
								</td>
							</tr>
						</xsl:when>
					</xsl:choose>
				</tbody>
			</table>
		</xsl:for-each>
		<xsl:for-each select="tia:StukdeelLevering">
			<xsl:variable name="koopovereenkomstnummer" select="number(current()/tia:tia_Volgnummer) * 2 - 1"/>
			<xsl:variable name="koopLevering" select="../tia:StukdeelKoop[tia:tia_Volgnummer = $koopovereenkomstnummer]"/>
			<xsl:variable name="koopakteLevering" select="$koopLevering/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
				translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
				translate(normalize-space($koopLevering/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
			<xsl:variable name="koopAkteCapitalizedLevering" select="concat(translate(substring($koopakteLevering, 1, 1), $lower, $upper), substring($koopakteLevering, 2))"/>
			<xsl:variable name="deHetLevering">
				<xsl:choose>
					<xsl:when test="normalize-space(../tia:StukdeelKoop[tia:tia_Volgnummer = $koopovereenkomstnummer]/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst) = normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst[1])">
						<xsl:text>het </xsl:text>
					</xsl:when>
					<xsl:when test="normalize-space($koopakteLevering) != ''">
						<xsl:text>de </xsl:text>
					</xsl:when>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="deHetKoopakteLevering">
				<xsl:value-of select="$deHetLevering"/>
				<xsl:value-of select="$koopAkteCapitalizedLevering"/>
			</xsl:variable>
			<xsl:variable name="numberOfBuyersLevering" select="count(../tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true'])
				+ count(../tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:IMKAD_Persoon/tia:GerelateerdPersoon[translate(tia:IMKAD_Persoon/tia:tia_IndGerechtigde, $upper, $lower) = 'true'])
				+ count(../tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon[translate(tia:IMKAD_Persoon/tia:tia_IndGerechtigde, $upper, $lower) = 'true'])"/>
			<xsl:variable name="undividedLevering">
				<xsl:choose>
					<xsl:when test="translate(tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst, $upper, $lower) = 'true'">
						<xsl:choose>
							<xsl:when test="$numberOfBuyersLevering = 2">
								<xsl:text>onverdeelde </xsl:text>
							</xsl:when>
							<xsl:when test="$numberOfBuyersLevering > 2">
								<xsl:text>onverdeeld </xsl:text>
							</xsl:when>
							<xsl:otherwise>
								<xsl:text/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="acquirerPartyLevering" select="../tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]"/>
			<xsl:variable name="nestedPartyLevering" select="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]"/>
			<xsl:variable name="acquirerPersonsLevering" select="../tia:Partij/tia:IMKAD_Persoon[concat('#', @id) = $nestedPartyLevering/tia:partijPersoonRef/@xlink:href]"/>
			<xsl:variable name="numberOfRegisteredObjectsLevering" select="count(tia:IMKAD_ZakelijkRecht)"/>
			<h2 class="header">LEVERING</h2>
			<xsl:variable name="registergoedAanduidingHetRegistergoed" select="tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst, $upper, $lower) = 'het registergoed'][1]"/>
			<xsl:variable name="registergoedAanduidingDeRegistergoederen" select="tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst, $upper, $lower) = 'de registergoederen'][1]"/>
			<xsl:variable name="registergoedAanduidingHetVerkochte" select="tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst, $upper, $lower) = 'het verkochte'][1]"/>
			<p>
				<xsl:text>Vervolgens levert </xsl:text>
				<xsl:choose>
					<xsl:when test="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
						<xsl:value-of select="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
					</xsl:when>
					<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
						<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
					</xsl:when>
				</xsl:choose>
				<xsl:text>, ter uitvoering van </xsl:text>
				<xsl:choose>
					<xsl:when test="$koopLevering/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopaktevolgnummer']/tia:tekst = 'true'">
						<xsl:value-of select="$koopAkteCapitalizedLevering"/>
						<xsl:text> </xsl:text>
						<xsl:value-of select="$koopovereenkomstnummer"/>
						<xsl:text> en </xsl:text>
						<xsl:value-of select="$koopAkteCapitalizedLevering"/>
						<xsl:text> </xsl:text>
						<xsl:value-of select="$koopovereenkomstnummer + 1"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$deHetKoopakteLevering"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:text>, hierbij aan </xsl:text>
				<xsl:apply-templates select=".." mode="do-purchase-distribution-paragraph-part">
					<xsl:with-param name="numberOfBuyers" select="$numberOfBuyersLevering"/>
					<xsl:with-param name="undivided" select="$undividedLevering"/>
					<xsl:with-param name="acquirerParty" select="$acquirerPartyLevering"/>
					<xsl:with-param name="acquirerPersons" select="$acquirerPersonsLevering"/>
				</xsl:apply-templates>
			</p>
			<p>
				<xsl:text>OMSCHRIJVING REGISTERGOED</xsl:text>
				<xsl:if test="$numberOfRegisteredObjectsLevering > 1">
					<xsl:text>EREN</xsl:text>
				</xsl:if>
			</p>
			<xsl:apply-templates select="." mode="do-registered-objects-deed-of-transfer"/>
			<xsl:if test="tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekst']/tia:tekst, $upper, $lower) = 'true']">
				<xsl:if test="$registergoedAanduidingHetRegistergoed">
					<p>
						<xsl:if test="translate($registergoedAanduidingHetRegistergoed/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedvolgnummeropsomming']/tia:tekst, $upper, $lower) = 'true'">
							<xsl:for-each select="tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst, $upper, $lower)
													= translate($registergoedAanduidingHetRegistergoed/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst, $upper, $lower)]">
								<xsl:text>Registergoed </xsl:text>
								<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
								<xsl:choose>
									<xsl:when test="position() = last() - 1">
										<xsl:text> en </xsl:text>
									</xsl:when>
									<xsl:when test="position() != last()">
										<xsl:text>, </xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text> </xsl:text>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:for-each>
						</xsl:if>
						<xsl:text>hierna</xsl:text>
						<xsl:if test="translate(normalize-space($registergoedAanduidingHetRegistergoed/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekstfragment']/tia:tekst), $upper, $lower)
									= translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekstfragment']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
												translate(normalize-space($registergoedAanduidingHetRegistergoed/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekstfragment']/tia:tekst), $upper, $lower)]), $upper, $lower)">
							<xsl:text> </xsl:text>
							<xsl:value-of select="translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekstfragment']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
									translate(normalize-space($registergoedAanduidingHetRegistergoed/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekstfragment']/tia:tekst), $upper, $lower)]), $upper, $lower)"/>
						</xsl:if>
						<xsl:text>: "</xsl:text>
						<u>
							<xsl:value-of select="$registergoedAanduidingHetRegistergoed/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst"/>
						</u>
						<xsl:text>".</xsl:text>
					</p>
				</xsl:if>
				<xsl:if test="$registergoedAanduidingDeRegistergoederen">
					<p>
						<xsl:if test="translate($registergoedAanduidingDeRegistergoederen/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedvolgnummeropsomming']/tia:tekst, $upper, $lower) = 'true'">
							<xsl:for-each select="tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst, $upper, $lower)
													= translate($registergoedAanduidingDeRegistergoederen/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst, $upper, $lower)]">
								<xsl:text>Registergoed </xsl:text>
								<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
								<xsl:choose>
									<xsl:when test="position() = last() - 1">
										<xsl:text> en </xsl:text>
									</xsl:when>
									<xsl:when test="position() != last()">
										<xsl:text>, </xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text> </xsl:text>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:for-each>
						</xsl:if>
						<xsl:text>hierna</xsl:text>
						<xsl:if test="translate(normalize-space($registergoedAanduidingDeRegistergoederen/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekstfragment']/tia:tekst), $upper, $lower)
									= translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekstfragment']/tia:tekst[translate(normalize-space(.), $upper, $lower) = translate(normalize-space($registergoedAanduidingDeRegistergoederen/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekstfragment']/tia:tekst), $upper, $lower)]), $upper, $lower)">
							<xsl:text> </xsl:text>
							<xsl:value-of select="translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekstfragment']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
									translate(normalize-space($registergoedAanduidingDeRegistergoederen/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekstfragment']/tia:tekst), $upper, $lower)]), $upper, $lower)"/>
						</xsl:if>
						<xsl:text>: "</xsl:text>
						<u>
							<xsl:value-of select="$registergoedAanduidingDeRegistergoederen/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst"/>
						</u>
						<xsl:text>".</xsl:text>
					</p>
				</xsl:if>
				<xsl:if test="$registergoedAanduidingHetVerkochte">
					<p>
						<xsl:if test="translate($registergoedAanduidingHetVerkochte/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedvolgnummeropsomming']/tia:tekst, $upper, $lower) = 'true'">
							<xsl:for-each select="tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst, $upper, $lower)
													= translate($registergoedAanduidingHetVerkochte/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst, $upper, $lower)]">
								<xsl:text>Registergoed </xsl:text>
								<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
								<xsl:choose>
									<xsl:when test="position() = last() - 1">
										<xsl:text> en </xsl:text>
									</xsl:when>
									<xsl:when test="position() != last()">
										<xsl:text>, </xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text> </xsl:text>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:for-each>
						</xsl:if>
						<xsl:text>hierna</xsl:text>
						<xsl:if test="translate(normalize-space($registergoedAanduidingHetVerkochte/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekstfragment']/tia:tekst), $upper, $lower)
									= translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekstfragment']/tia:tekst[translate(normalize-space(.), $upper, $lower) = translate(normalize-space($registergoedAanduidingHetVerkochte/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekstfragment']/tia:tekst), $upper, $lower)]), $upper, $lower)">
							<xsl:text> </xsl:text>
							<xsl:value-of select="translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekstfragment']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
									translate(normalize-space($registergoedAanduidingHetVerkochte/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekstfragment']/tia:tekst), $upper, $lower)]), $upper, $lower)"/>
						</xsl:if>
						<xsl:text>: "</xsl:text>
						<u>
							<xsl:value-of select="$registergoedAanduidingHetVerkochte/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst"/>
						</u>
						<xsl:text>".</xsl:text>
					</p>
				</xsl:if>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-registered-objects-deed-of-transfer
	*********************************************************
	Public: no

	Identity transform: no

	Description: Deed of transfer registered objects.

	Input: tia:StukdeelLevering

	Params: none

	Output: XHTML structure

	Calls:
	(mode) do-right
	(mode) do-registered-object
	(name) processRights

	Called by:
	(mode) do-purchase-and-transfer
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:StukdeelLevering" mode="do-registered-objects-deed-of-transfer">
		<xsl:variable name="numberOfRegisteredObjectsVorigeLevering">
			<xsl:choose>
				<xsl:when test="preceding-sibling::tia:StukdeelLevering[tia:IMKAD_ZakelijkRecht]">
					<xsl:value-of select="count(preceding-sibling::tia:StukdeelLevering/tia:IMKAD_ZakelijkRecht)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="number('0')"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="aantalZelfdeObjectenVorigeLevering">
			<xsl:choose>
				<xsl:when test="preceding-sibling::tia:StukdeelLevering[tia:IMKAD_ZakelijkRecht]">
					<xsl:call-template name="bepaalAantalZelfde">
						<xsl:with-param name="positionOfProcessedRight" select="number('1')"/>
						<xsl:with-param name="registeredObjects" select="preceding-sibling::tia:StukdeelLevering[tia:IMKAD_ZakelijkRecht]"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="number('0')"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="aantalTeTonenHetRegistergoedVorigeLevering">
			<xsl:choose>
				<xsl:when test="preceding-sibling::tia:StukdeelLevering[tia:IMKAD_ZakelijkRecht]">
					<xsl:value-of select="$numberOfRegisteredObjectsVorigeLevering - $aantalZelfdeObjectenVorigeLevering"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="number('0')"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:choose>
			<!-- Only one registered object -->
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
					<xsl:text>,</xsl:text>
					<xsl:if test="translate(tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedvolgnummer']/tia:tekst, $upper, $lower) = 'true'">
						<br/>
						<xsl:text>hierna </xsl:text>
						<xsl:value-of select="translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedvolgnummertekst']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
								translate(normalize-space(current()/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedvolgnummertekst']/tia:tekst), $upper, $lower)]), $upper, $lower)"/>
						<xsl:text>: "</xsl:text>
						<u>
							<xsl:if test="translate(tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedvolgnummerlidwoord']/tia:tekst, $upper, $lower) = 'true'">
								<xsl:text>het </xsl:text>
							</xsl:if>
							<xsl:text>Registergoed </xsl:text>
							<xsl:value-of select="$aantalTeTonenHetRegistergoedVorigeLevering + 1"/>
						</u>
						<xsl:text>".</xsl:text>
					</xsl:if>
				</p>
			</xsl:when>
			<!-- Multiple registered objects, all parcels with same data -->
			<xsl:when test="count(tia:IMKAD_ZakelijkRecht)= count(tia:IMKAD_ZakelijkRecht[
						tia:aardVerkregen = current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:aardVerkregen
						and normalize-space(tia:aardVerkregen) != ''
						and ((tia:aardVerkregenVariant 
							= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:aardVerkregenVariant)
							or (not(tia:aardVerkregenVariant)
							and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:aardVerkregenVariant)))					
						and ((tia:tia_Aantal_BP_Rechten
								= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_Aantal_BP_Rechten)
							or (not(tia:tia_Aantal_BP_Rechten)
								and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_Aantal_BP_Rechten)))
						and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven']/tia:tekst
								= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven']/tia:tekst)
							or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven'])
								and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven'])))
						and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom']/tia:tekst
								= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom']/tia:tekst)
							or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom'])
							and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom'])))
						and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoud']/tia:tekst
								= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoud']/tia:tekst)
							or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoud'])
							and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoud'])))
						and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurend']/tia:tekst
								= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurend']/tia:tekst)
							or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurend'])
							and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurend'])))
						and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijvenvariant']/tia:tekst
								= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijvenvariant']/tia:tekst)
							or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijvenvariant'])
							and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijvenvariant'])))
						and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoudvariant']/tia:tekst
								= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoudvariant']/tia:tekst)
							or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoudvariant'])
							and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoudvariant'])))
						and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurendvariant']/tia:tekst
								= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurendvariant']/tia:tekst)
							or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurendvariant'])
							and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurendvariant'])))
						and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aantal_bp_rechtenvariant']/tia:tekst
								= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aantal_bp_rechtenvariant']/tia:tekst)
							or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aantal_bp_rechtenvariant'])
							and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aantal_bp_rechtenvariant'])))
						and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen']/tia:tekst
								= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen']/tia:tekst)
							or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen'])
								and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen'])))
						and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_wijzevanlevering']/tia:tekst
								= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_wijzevanlevering']/tia:tekst)
							or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_wijzevanlevering'])
								and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_wijzevanlevering'])))
						and ((tia:aandeelInRecht/tia:teller = current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:aandeelInRecht/tia:teller
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
							and ((tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aanduiding']/tia:tekst
									= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aanduiding']/tia:tekst)
								or (not(tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aanduiding'])
								and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aanduiding'])))
							and ((tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_nabij']/tia:tekst
									= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_nabij']/tia:tekst)
								or (not(tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_nabij'])
								and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_nabij'])))
							and ((tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_komma']/tia:tekst
									= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_komma']/tia:tekst)
								or (not(tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_komma'])
								and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_komma'])))
							and ((tia:tia_SplitsingsverzoekOrdernummer
									= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_SplitsingsverzoekOrdernummer)
								or (not(tia:tia_SplitsingsverzoekOrdernummer)
									and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_SplitsingsverzoekOrdernummer)))
			and ((tia:stukVerificatiekosten/tia:reeks
						= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:reeks)
					or (not(tia:stukVerificatiekosten/tia:reeks)
						and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:reeks)))
				and ((tia:stukVerificatiekosten/tia:deel
						= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:deel)
					or (not(tia:stukVerificatiekosten/tia:deel)
						and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:deel)))
				and ((tia:stukVerificatiekosten/tia:nummer
						= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:nummer)
					or (not(tia:stukVerificatiekosten/tia:nummer)
						and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:nummer)))
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
				and  ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter
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
				and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam
					= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam)
					or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam)
						and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam)))
			and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam
					= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam)
					or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam)
						and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam)))
				and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:postcode
					= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:postcode)
					or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:postcode)
						and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:kadBinnenlandsAdres/tia:postcode)))
				and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:woonplaatsNaam
					= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:woonplaatsNaam)
					or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:woonplaatsNaam)
						and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:kadBinnenlandsAdres/tia:woonplaatsNaam)))
				and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:openbareRuimteNaam
					= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:openbareRuimteNaam)
					or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:openbareRuimteNaam)
						and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:kadBinnenlandsAdres/tia:openbareRuimteNaam)))				
				and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummer
					= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummer)
					or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummer)
						and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:kadBinnenlandsAdres/tia:huisNummer)))
				and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisLetter
					= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisLetter)
					or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisLetter)
						and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:kadBinnenlandsAdres/tia:huisLetter)))
				and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummerToevoeging
					= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummerToevoeging)
					or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummerToevoeging)
						and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:kadBinnenlandsAdres/tia:huisNummerToevoeging)))]]) and $RegistergoedTonenPerPerceel='false' ">
				<p>
					<xsl:variable name="rightText">
						<xsl:apply-templates select="tia:IMKAD_ZakelijkRecht[1]" mode="do-right"/>
					</xsl:variable>
					<xsl:if test="normalize-space($rightText) != ''">
						<xsl:value-of select="$rightText"/>
						<xsl:text> </xsl:text>
					</xsl:if>
					<xsl:apply-templates select="tia:IMKAD_ZakelijkRecht[1]" mode="do-registered-object"/>
					<xsl:text>,</xsl:text>
					<xsl:if test="translate(tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedvolgnummer']/tia:tekst, $upper, $lower) = 'true'">
						<br/>
						<xsl:text>hierna </xsl:text>
						<xsl:value-of select="translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedvolgnummertekst']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
								translate(normalize-space(current()/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedvolgnummertekst']/tia:tekst), $upper, $lower)]), $upper, $lower)"/>
						<xsl:text>: "</xsl:text>
						<u>
							<xsl:if test="translate(tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedvolgnummerlidwoord']/tia:tekst, $upper, $lower) = 'true'">
								<xsl:text>het </xsl:text>
							</xsl:if>
							<xsl:text>Registergoed </xsl:text>
							<xsl:value-of select="$aantalTeTonenHetRegistergoedVorigeLevering + 1"/>
						</u>
						<xsl:text>".</xsl:text>
					</xsl:if>
				</p>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="existAanduiding">
					<xsl:choose>
						<xsl:when test="tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekst']/tia:tekst, $upper, $lower) = 'true']">
							<xsl:text>true</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>false</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<table cellpadding="0" cellspacing="0">
					<tbody>
						<xsl:call-template name="processRights">
							<xsl:with-param name="positionOfProcessedRight" select="1"/>
							<xsl:with-param name="position" select="1"/>
							<xsl:with-param name="registeredObjects" select="."/>
							<xsl:with-param name="punctuationMark" select="','"/>
							<xsl:with-param name="haveAdditionalText" select="'true'"/>
							<xsl:with-param name="semicolon" select="$existAanduiding"/>
							<xsl:with-param name="aantalGetoondeRegistergoederen" select="$aantalTeTonenHetRegistergoedVorigeLevering"/>
						</xsl:call-template>
					</tbody>
				</table>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-purchase-registration
	*********************************************************
	Public: no

	Identity transform: no

	Description: Deed of transfer purchase registration.

	Input: tia:IMKAD_AangebodenStuk

	Params: none

	Output: XHTML structure

	Calls:
	(mode) do-part-and-number

	Called by:
	(mode) do-deed
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_AangebodenStuk" mode="do-purchase-registration">
		<a name="hyp4.purchaseRegistration" class="location">&#160;</a>
		<!-- Empty default template -->
	</xsl:template>
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_AangebodenStuk[tia:StukdeelKoop/tia:koopovereenkomst/tia:datumInschrijving and tia:StukdeelKoop/tia:koopovereenkomst/tia:gegevensInschrijving]" mode="do-purchase-registration">
		<xsl:if test="count(tia:StukdeelKoop[translate(tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_inschrijvingkoop']/tia:tekst, $upper, $lower) = 'true']) > 0">
			<a name="hyp4.purchaseRegistration" class="location">&#160;</a>
			<h2 class="header">
				<xsl:text>INSCHRIJVING KOOP</xsl:text>
			</h2>
			<xsl:for-each select="tia:StukdeelKoop[tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_inschrijvingkoop']/tia:tekst = 'true']">
				<xsl:variable name="koopakte" select="tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
					translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
					translate(normalize-space(current()/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
				<xsl:variable name="koopAkteCapitalized" select="concat(translate(substring($koopakte, 1, 1), $lower, $upper), substring($koopakte, 2))"/>
				<xsl:variable name="deHetLevering">
					<xsl:choose>
						<xsl:when test="translate(normalize-space(tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst), $upper, $lower) = translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst[1]), $upper, $lower)">
							<xsl:text>het </xsl:text>
						</xsl:when>
						<xsl:when test="normalize-space($koopakte) != ''">
							<xsl:text>de </xsl:text>
						</xsl:when>
					</xsl:choose>
				</xsl:variable>
				<xsl:variable name="deHetKoopakteLevering">
					<xsl:value-of select="$deHetLevering"/>
					<xsl:value-of select="$koopAkteCapitalized"/>
				</xsl:variable>
				<xsl:variable name="Datum_DATE" select="substring(string(tia:koopovereenkomst/tia:datumInschrijving), 0, 11)"/>
				<xsl:variable name="Datum_STRING">
					<xsl:if test="$Datum_DATE != ''">
						<xsl:value-of select="kef:convertDateToText($Datum_DATE)"/>
					</xsl:if>
				</xsl:variable>
				<p>
					<xsl:text>De koop</xsl:text>
					<xsl:if test="tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_inschrijvingkoopaanduiding'] and tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_inschrijvingkoopaanduiding']/tia:tekst = 'true'">
						<xsl:text>, zoals bedoeld in </xsl:text>
						<xsl:choose>
							<xsl:when test="tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_inschrijvingkoopvolgnummer']/tia:tekst = 'true'">
								<xsl:value-of select="$koopAkteCapitalized"/>
								<xsl:text> </xsl:text>
								<xsl:value-of select="count(preceding-sibling::tia:StukdeelKoop) + 1"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="$deHetKoopakteLevering"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:if>
					<xsl:text> is ingeschreven </xsl:text>
					<xsl:if test="tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_inschrijvingkoopkadastertekst']">
						<xsl:text> </xsl:text>
						<xsl:value-of select="$keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_inschrijvingkoopkadastertekst']/tia:tekst[
							position() = translate(normalize-space(current()/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_inschrijvingkoopkadastertekst']/tia:tekst), $upper, $lower)]"/>
					</xsl:if>
					<xsl:text> op </xsl:text>
					<xsl:value-of select="$Datum_STRING"/>
					<xsl:text> in </xsl:text>
					<xsl:apply-templates select="tia:koopovereenkomst/tia:gegevensInschrijving" mode="do-part-and-number"/>
					<xsl:if test="translate(tia:vervallen, $upper, $lower) = 'true'">
						<xsl:text> welke inschrijving door de inschrijving van een afschrift van deze akte waardeloos zal worden</xsl:text>
					</xsl:if>
					<xsl:text>.</xsl:text>
				</p>
			</xsl:for-each>
		</xsl:if>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-purchase-price
	*********************************************************
	Public: no

	Identity transform: no

	Description: Deed of transfer purchase price.

	Input: tia:IMKAD_AangebodenStuk

	Params: none

	Output: XHTML structure

	Calls:
	(name) amountText
	(name) amountNumber

	Called by:
	(mode) do-deed
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_AangebodenStuk" mode="do-purchase-price">
		<h2 class="header">
			<xsl:text>KOOPPRIJS</xsl:text>
		</h2>
		<xsl:choose>
			<xsl:when test="tia:tia_StukVariant = 'Twee leveringen'">
				<xsl:for-each select="tia:StukdeelLevering[tia:tia_Volgnummer and count(preceding-sibling::tia:StukdeelLevering) mod 2 = 0]">
					<xsl:variable name="stukdeelKoop" select="../tia:StukdeelKoop[tia:tia_Volgnummer = current()/tia:tia_Volgnummer]"/>
					<xsl:variable name="nextStukdeelKoop" select="../tia:StukdeelKoop[tia:tia_Volgnummer = (current()/tia:tia_Volgnummer + 1)]"/>
					<xsl:variable name="koopprijsLidwoord" select="$stukdeelKoop/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijslidwoord']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
							translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijslidwoord']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
							translate(normalize-space($stukdeelKoop/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijslidwoord']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
					<xsl:variable name="tweeLeveringPartyText">
						<xsl:choose>
							<xsl:when test="$stukdeelKoop/tia:koopprijsSpecificatie/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_partijkeuzekoopprijs']/tia:tekst = '1'">
								<xsl:choose>
									<xsl:when test="../tia:Partij[@id = substring-after($stukdeelKoop/tia:vervreemderRechtRef/@xlink:href, '#')]">
										<xsl:call-template name="capitalizePartyAlias">
											<xsl:with-param name="party" select="../tia:Partij[@id = substring-after($stukdeelKoop/tia:vervreemderRechtRef/@xlink:href, '#')]"/>
										</xsl:call-template>
									</xsl:when>
									<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after($stukdeelKoop/tia:vervreemderRechtRef/@xlink:href, '#')]">
										<xsl:call-template name="capitalizePartyAlias">
											<xsl:with-param name="party" select="../tia:Partij/tia:Partij[@id = substring-after($stukdeelKoop/tia:vervreemderRechtRef/@xlink:href, '#')]"/>
										</xsl:call-template>
									</xsl:when>
								</xsl:choose>
							</xsl:when>
							<xsl:when test="$stukdeelKoop/tia:koopprijsSpecificatie/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_partijkeuzekoopprijs']/tia:tekst = '2'">
								<xsl:choose>
									<xsl:when test="../tia:Partij[@id = substring-after($stukdeelKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]">
										<xsl:call-template name="capitalizePartyAlias">
											<xsl:with-param name="party" select="../tia:Partij[@id = substring-after($stukdeelKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]"/>
										</xsl:call-template>
									</xsl:when>
									<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after($stukdeelKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]">
										<xsl:call-template name="capitalizePartyAlias">
											<xsl:with-param name="party" select="../tia:Partij/tia:Partij[@id = substring-after($stukdeelKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]"/>
										</xsl:call-template>
									</xsl:when>
								</xsl:choose>
							</xsl:when>
							<xsl:when test="$stukdeelKoop/tia:koopprijsSpecificatie/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_partijkeuzekoopprijs']/tia:tekst = '3'">
								<xsl:choose>
									<xsl:when test="../tia:Partij[@id = substring-after($stukdeelKoop/tia:vervreemderRechtRef/@xlink:href, '#')]">
										<xsl:call-template name="capitalizePartyAlias">
											<xsl:with-param name="party" select="../tia:Partij[@id = substring-after($stukdeelKoop/tia:vervreemderRechtRef/@xlink:href, '#')]"/>
										</xsl:call-template>
										<xsl:text> en </xsl:text>
										<xsl:value-of select="../tia:Partij[@id = substring-after($stukdeelKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
									</xsl:when>
									<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after($stukdeelKoop/tia:vervreemderRechtRef/@xlink:href, '#')]">
										<xsl:call-template name="capitalizePartyAlias">
											<xsl:with-param name="party" select="../tia:Partij/tia:Partij[@id = substring-after($stukdeelKoop/tia:vervreemderRechtRef/@xlink:href, '#')]"/>
										</xsl:call-template>
										<xsl:text> en </xsl:text>
										<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after($stukdeelKoop/verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
									</xsl:when>
								</xsl:choose>
							</xsl:when>
						</xsl:choose>
					</xsl:variable>
					<xsl:variable name="partyNameVariantVrijOpNaam">
						<xsl:choose>
							<xsl:when test="../tia:Partij[@id = substring-after($stukdeelKoop/tia:vervreemderRechtRef/@xlink:href, '#')]">
								<xsl:value-of select="../tia:Partij[@id = substring-after($stukdeelKoop/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
							</xsl:when>
							<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after($stukdeelKoop/tia:vervreemderRechtRef/@xlink:href, '#')]">
								<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after($stukdeelKoop/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
							</xsl:when>
						</xsl:choose>
					</xsl:variable>
					<xsl:variable name="partyNameVariantKoopAanneemsom">
						<xsl:choose>
							<xsl:when test="../tia:Partij[@id = substring-after($stukdeelKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]">
								<xsl:value-of select="../tia:Partij[@id = substring-after($stukdeelKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
							</xsl:when>
							<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after($stukdeelKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]">
								<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after($stukdeelKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
							</xsl:when>
						</xsl:choose>
					</xsl:variable>
					<xsl:variable name="stukdeelLeveringNext" select="following-sibling::tia:StukdeelLevering[1]"/>
					<xsl:variable name="stukdeelKoopNext" select="../tia:StukdeelKoop[tia:tia_Volgnummer = $stukdeelLeveringNext/tia:tia_Volgnummer]"/>
					<xsl:variable name="partyNameVariantVrijOpNaamNext">
						<xsl:choose>
							<xsl:when test="../tia:Partij[@id = substring-after($stukdeelKoopNext/tia:vervreemderRechtRef/@xlink:href, '#')]">
								<xsl:value-of select="../tia:Partij[@id = substring-after($stukdeelKoopNext/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
							</xsl:when>
							<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after($stukdeelKoopNext/tia:vervreemderRechtRef/@xlink:href, '#')]">
								<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after($stukdeelKoopNext/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
							</xsl:when>
						</xsl:choose>
					</xsl:variable>
					<xsl:variable name="partyNameVariantKoopAanneemsomNext">
						<xsl:choose>
							<xsl:when test="../tia:Partij[@id = substring-after($stukdeelKoopNext/tia:verkrijgerRechtRef/@xlink:href, '#')]">
								<xsl:value-of select="../tia:Partij[@id = substring-after($stukdeelKoopNext/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
							</xsl:when>
							<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after($stukdeelKoopNext/tia:verkrijgerRechtRef/@xlink:href, '#')]">
								<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after($stukdeelKoopNext/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
							</xsl:when>
						</xsl:choose>
					</xsl:variable>
					<xsl:variable name="tweeLeveringPartyTextNext">
						<xsl:choose>
							<xsl:when test="$stukdeelKoopNext/tia:koopprijsSpecificatie/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_partijkeuzekoopprijs']/tia:tekst = '1'">
								<xsl:choose>
									<xsl:when test="../tia:Partij[@id = substring-after($stukdeelKoopNext/tia:vervreemderRechtRef/@xlink:href, '#')]">
										<xsl:call-template name="capitalizePartyAlias">
											<xsl:with-param name="party" select="../tia:Partij[@id = substring-after($stukdeelKoopNext/tia:vervreemderRechtRef/@xlink:href, '#')]"/>
										</xsl:call-template>
									</xsl:when>
									<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after($stukdeelKoopNext/tia:vervreemderRechtRef/@xlink:href, '#')]">
										<xsl:call-template name="capitalizePartyAlias">
											<xsl:with-param name="party" select="../tia:Partij/tia:Partij[@id = substring-after($stukdeelKoopNext/tia:vervreemderRechtRef/@xlink:href, '#')]"/>
										</xsl:call-template>
									</xsl:when>
								</xsl:choose>
							</xsl:when>
							<xsl:when test="$stukdeelKoopNext/tia:koopprijsSpecificatie/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_partijkeuzekoopprijs']/tia:tekst = '2'">
								<xsl:choose>
									<xsl:when test="../tia:Partij[@id = substring-after($stukdeelKoopNext/tia:verkrijgerRechtRef/@xlink:href, '#')]">
										<xsl:call-template name="capitalizePartyAlias">
											<xsl:with-param name="party" select="../tia:Partij[@id = substring-after($stukdeelKoopNext/tia:verkrijgerRechtRef/@xlink:href, '#')]"/>
										</xsl:call-template>
									</xsl:when>
									<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after($stukdeelKoopNext/tia:verkrijgerRechtRef/@xlink:href, '#')]">
										<xsl:call-template name="capitalizePartyAlias">
											<xsl:with-param name="party" select="../tia:Partij/tia:Partij[@id = substring-after($stukdeelKoopNext/tia:verkrijgerRechtRef/@xlink:href, '#')]"/>
										</xsl:call-template>
									</xsl:when>
								</xsl:choose>
							</xsl:when>
							<xsl:when test="$stukdeelKoopNext/tia:koopprijsSpecificatie/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_partijkeuzekoopprijs']/tia:tekst = '3'">
								<xsl:choose>
									<xsl:when test="../tia:Partij[@id = substring-after($stukdeelKoopNext/tia:vervreemderRechtRef/@xlink:href, '#')]">
										<xsl:call-template name="capitalizePartyAlias">
											<xsl:with-param name="party" select="../tia:Partij[@id = substring-after($stukdeelKoopNext/tia:vervreemderRechtRef/@xlink:href, '#')]"/>
										</xsl:call-template>
										<xsl:text> en </xsl:text>
										<xsl:value-of select="../tia:Partij[@id = substring-after($stukdeelKoopNext/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
									</xsl:when>
									<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after($stukdeelKoopNext/tia:vervreemderRechtRef/@xlink:href, '#')]">
										<xsl:call-template name="capitalizePartyAlias">
											<xsl:with-param name="party" select="../tia:Partij/tia:Partij[@id = substring-after($stukdeelKoopNext/tia:vervreemderRechtRef/@xlink:href, '#')]"/>
										</xsl:call-template>
										<xsl:text> en </xsl:text>
										<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after($stukdeelKoopNext/verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
									</xsl:when>
								</xsl:choose>
							</xsl:when>
						</xsl:choose>
					</xsl:variable>
					<xsl:variable name="registergoedAanduidingNext" select="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht[1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst"/>
					<xsl:variable name="registergoederenTonenRoerendeZakenNext" select="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht[1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederentonenroerendezaken']/tia:tekst"/>
					<xsl:variable name="registergoederenOpsommingAangehechtNext" select="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht[1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederenopsommingaangehecht']/tia:tekst"/>
					<xsl:variable name="registergoederenOpsommingAangehechtTekstNext" select="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht[1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederenopsommingaangehechttekst']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
							translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederenopsommingaangehechttekst']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
							translate(normalize-space($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht[1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederenopsommingaangehechttekst']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
					<xsl:variable name="tweeLeveringGroupNext" select="(count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'kaal']) = count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) and $stukdeelKoopNext/tia:transactiesom)
										or (count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'roerende zaken exclusief']) = count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) and $stukdeelKoopNext/tia:transactiesom
											and count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'roerende zaken exclusief' and tia:tia_BedragKoopprijs]) = 0)
										or (count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'roerende zaken inclusief']) = count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) and $stukdeelKoopNext/tia:transactiesom
											and count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'roerende zaken inclusief' and tia:tia_BedragKoopprijs]) = 0)
										or (count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'vrij op naam']) = count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) and $stukdeelKoopNext/tia:transactiesom
											and count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'vrij op naam' and tia:tia_BedragKoopprijs]) = 0)
										or (count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'exclusief omzetbelasting']) = count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) and $stukdeelKoopNext/tia:transactiesom
											and count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'exclusief omzetbelasting' and tia:tia_BedragKoopprijs]) = 0)
										or (count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'koop aanneemsom']) = count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) and $stukdeelKoopNext/tia:transactiesom
											and count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'koop aanneemsom' and tia:tia_BedragKoopprijs]) = 0)"/>
					<xsl:if test="$tweeLeveringGroupNext">
						<xsl:apply-templates select="." mode="do-purchase-price-twee-levering-group">
							<xsl:with-param name="stukdeelLeveringNext" select="$stukdeelLeveringNext"/>
							<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
							<xsl:with-param name="registergoedAanduiding" select="$registergoedAanduidingNext"/>
							<xsl:with-param name="partyNameVariantVrijOpNaam" select="$partyNameVariantVrijOpNaam"/>
							<xsl:with-param name="partyNameVariantKoopAanneemsom" select="$partyNameVariantKoopAanneemsom"/>
							<xsl:with-param name="tweeLeveringPartyText" select="$tweeLeveringPartyText"/>
							<xsl:with-param name="registergoederenTonenRoerendeZaken" select="$registergoederenTonenRoerendeZakenNext"/>
							<xsl:with-param name="registergoederenOpsommingAangehecht" select="$registergoederenOpsommingAangehechtNext"/>
							<xsl:with-param name="registergoederenOpsommingAangehechtTekst" select="$registergoederenOpsommingAangehechtTekstNext"/>
							<xsl:with-param name="koopprijsLidwoord" select="$koopprijsLidwoord"/>
						</xsl:apply-templates>
						<xsl:apply-templates select="." mode="do-purchase-price-twee-levering-group-next">
							<xsl:with-param name="stukdeelLeveringNext" select="$stukdeelLeveringNext"/>
							<xsl:with-param name="stukdeelKoopNext" select="$stukdeelKoopNext"/>
							<xsl:with-param name="registergoedAanduidingNext" select="$registergoedAanduidingNext"/>
							<xsl:with-param name="partyNameVariantVrijOpNaamNext" select="$partyNameVariantVrijOpNaamNext"/>
							<xsl:with-param name="partyNameVariantKoopAanneemsomNext" select="$partyNameVariantKoopAanneemsomNext"/>
							<xsl:with-param name="tweeLeveringPartyTextNext" select="$tweeLeveringPartyTextNext"/>
							<xsl:with-param name="registergoederenTonenRoerendeZakenNext" select="$registergoederenTonenRoerendeZakenNext"/>
							<xsl:with-param name="registergoederenOpsommingAangehechtNext" select="$registergoederenOpsommingAangehechtNext"/>
							<xsl:with-param name="registergoederenOpsommingAangehechtTekstNext" select="$registergoederenOpsommingAangehechtTekstNext"/>
							<xsl:with-param name="koopprijsLidwoordNext" select="$koopprijsLidwoord"/>
						</xsl:apply-templates>
					</xsl:if>
					<xsl:for-each select="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht">
						<xsl:if test="not($tweeLeveringGroupNext)">
							<xsl:apply-templates select="." mode="do-purchase-price-twee-levering-individual">
								<xsl:with-param name="stukdeelLeveringNext" select="$stukdeelLeveringNext"/>
								<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
								<xsl:with-param name="partyNameVariantVrijOpNaam" select="$partyNameVariantVrijOpNaam"/>
								<xsl:with-param name="partyNameVariantKoopAanneemsom" select="$partyNameVariantKoopAanneemsom"/>
								<xsl:with-param name="tweeLeveringPartyText" select="$tweeLeveringPartyText"/>
								<xsl:with-param name="registergoederenOpsommingAangehecht" select="$registergoederenOpsommingAangehechtNext"/>
								<xsl:with-param name="registergoederenOpsommingAangehechtTekst" select="$registergoederenOpsommingAangehechtTekstNext"/>
								<xsl:with-param name="koopprijsLidwoord" select="$koopprijsLidwoord"/>
							</xsl:apply-templates>
							<xsl:apply-templates select="." mode="do-purchase-price-twee-levering-individual-next">
								<xsl:with-param name="stukdeelLeveringNext" select="$stukdeelLeveringNext"/>
								<xsl:with-param name="stukdeelKoopNext" select="$stukdeelKoopNext"/>
								<xsl:with-param name="partyNameVariantVrijOpNaamNext" select="$partyNameVariantVrijOpNaamNext"/>
								<xsl:with-param name="partyNameVariantKoopAanneemsomNext" select="$partyNameVariantKoopAanneemsomNext"/>
								<xsl:with-param name="tweeLeveringPartyTextNext" select="$tweeLeveringPartyTextNext"/>
								<xsl:with-param name="registergoederenTonenRoerendeZakenNext" select="$registergoederenTonenRoerendeZakenNext"/>
								<xsl:with-param name="registergoederenOpsommingAangehechtNext" select="$registergoederenOpsommingAangehechtNext"/>
								<xsl:with-param name="registergoederenOpsommingAangehechtTekstNext" select="$registergoederenOpsommingAangehechtTekstNext"/>
								<xsl:with-param name="koopprijsLidwoordNext" select="$koopprijsLidwoord"/>
							</xsl:apply-templates>
							<xsl:if test="position() != last()">
								<br/>
							</xsl:if>
						</xsl:if>
					</xsl:for-each>
				</xsl:for-each>
			</xsl:when>
			<xsl:when test="tia:tia_StukVariant = 'Standaardlevering'">
				<xsl:for-each select="tia:StukdeelLevering[tia:tia_Volgnummer]">
					<xsl:variable name="stukdeelKoop" select="../tia:StukdeelKoop[tia:tia_Volgnummer = current()/tia:tia_Volgnummer]"/>
					<xsl:variable name="nextStukdeelKoop" select="../tia:StukdeelKoop[tia:tia_Volgnummer = (current()/tia:tia_Volgnummer + 1)]"/>
					<xsl:variable name="koopprijsLidwoord" select="$stukdeelKoop/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijslidwoord']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
							translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijslidwoord']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
							translate(normalize-space($stukdeelKoop/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijslidwoord']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
					<xsl:variable name="registergoedAanduiding" select="tia:IMKAD_ZakelijkRecht[1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst"/>
					<xsl:variable name="registergoederenTonenRoerendeZaken" select="tia:IMKAD_ZakelijkRecht[1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederentonenroerendezaken']/tia:tekst"/>
					<xsl:variable name="registergoederenOpsommingAangehecht" select="tia:IMKAD_ZakelijkRecht[1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederenopsommingaangehecht']/tia:tekst"/>
					<xsl:variable name="registergoederenOpsommingAangehechtTekst" select="tia:IMKAD_ZakelijkRecht[1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederenopsommingaangehechttekst']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
							translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederenopsommingaangehechttekst']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
							translate(normalize-space(current()/tia:IMKAD_ZakelijkRecht[1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederenopsommingaangehechttekst']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
					<xsl:variable name="partyText">
						<xsl:choose>
							<xsl:when test="$stukdeelKoop/tia:koopprijsSpecificatie/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_partijkeuzekoopprijs']/tia:tekst = '2'">
								<xsl:choose>
									<xsl:when test="../tia:Partij[@id = substring-after($stukdeelKoop/tia:vervreemderRechtRef/@xlink:href, '#')]">
										<xsl:call-template name="capitalizePartyAlias">
											<xsl:with-param name="party" select="../tia:Partij[@id = substring-after($stukdeelKoop/tia:vervreemderRechtRef/@xlink:href, '#')]"/>
										</xsl:call-template>
									</xsl:when>
									<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after($stukdeelKoop/tia:vervreemderRechtRef/@xlink:href, '#')]">
										<xsl:call-template name="capitalizePartyAlias">
											<xsl:with-param name="party" select="../tia:Partij/tia:Partij[@id = substring-after($stukdeelKoop/tia:vervreemderRechtRef/@xlink:href, '#')]"/>
										</xsl:call-template>
									</xsl:when>
								</xsl:choose>
							</xsl:when>
							<xsl:when test="$stukdeelKoop/tia:koopprijsSpecificatie/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_partijkeuzekoopprijs']/tia:tekst = '1'">
								<xsl:choose>
									<xsl:when test="../tia:Partij[@id = substring-after($stukdeelKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]">
										<xsl:call-template name="capitalizePartyAlias">
											<xsl:with-param name="party" select="../tia:Partij[@id = substring-after($stukdeelKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]"/>
										</xsl:call-template>
									</xsl:when>
									<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after($stukdeelKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]">
										<xsl:call-template name="capitalizePartyAlias">
											<xsl:with-param name="party" select="../tia:Partij/tia:Partij[@id = substring-after($stukdeelKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]"/>
										</xsl:call-template>
									</xsl:when>
								</xsl:choose>
							</xsl:when>
							<xsl:when test="$stukdeelKoop/tia:koopprijsSpecificatie/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_partijkeuzekoopprijs']/tia:tekst = '3'">
								<xsl:choose>
									<xsl:when test="../tia:Partij[@id = substring-after($stukdeelKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]">
										<xsl:call-template name="capitalizePartyAlias">
											<xsl:with-param name="party" select="../tia:Partij[@id = substring-after($stukdeelKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]"/>
										</xsl:call-template>
										<xsl:text> en </xsl:text>
										<xsl:value-of select="../tia:Partij[@id = substring-after($stukdeelKoop/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
									</xsl:when>
									<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after($stukdeelKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]">
										<xsl:call-template name="capitalizePartyAlias">
											<xsl:with-param name="party" select="../tia:Partij/tia:Partij[@id = substring-after($stukdeelKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]"/>
										</xsl:call-template>
										<xsl:text> en </xsl:text>
										<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after($stukdeelKoop/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
									</xsl:when>
								</xsl:choose>
							</xsl:when>
						</xsl:choose>
					</xsl:variable>
					<xsl:variable name="partyNameVariantVrijOpNaam">
						<xsl:choose>
							<xsl:when test="../tia:Partij[@id = substring-after($stukdeelKoop/tia:vervreemderRechtRef/@xlink:href, '#')]">
								<xsl:value-of select="../tia:Partij[@id = substring-after($stukdeelKoop/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
							</xsl:when>
							<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after($stukdeelKoop/tia:vervreemderRechtRef/@xlink:href, '#')]">
								<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after($stukdeelKoop/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
							</xsl:when>
						</xsl:choose>
					</xsl:variable>
					<xsl:variable name="partyNameVariantKoopAanneemsom">
						<xsl:choose>
							<xsl:when test="../tia:Partij[@id = substring-after($stukdeelKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]">
								<xsl:call-template name="capitalizePartyAlias">
									<xsl:with-param name="party" select="../tia:Partij[@id = substring-after($stukdeelKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]"/>
								</xsl:call-template>
							</xsl:when>
							<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after($stukdeelKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]">
								<xsl:call-template name="capitalizePartyAlias">
									<xsl:with-param name="party" select="../tia:Partij/tia:Partij[@id = substring-after($stukdeelKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]"/>
								</xsl:call-template>
							</xsl:when>
						</xsl:choose>
					</xsl:variable>
					<xsl:choose>
						<xsl:when test="(count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'kaal']) = count(tia:IMKAD_ZakelijkRecht) and $stukdeelKoop/tia:transactiesom)
									or (count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'roerende zaken exclusief']) = count(tia:IMKAD_ZakelijkRecht) and $stukdeelKoop/tia:transactiesom
										and count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'roerende zaken exclusief' and tia:tia_BedragKoopprijs]) = 0)
									or (count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'roerende zaken inclusief']) = count(tia:IMKAD_ZakelijkRecht) and $stukdeelKoop/tia:transactiesom
										and count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'roerende zaken inclusief' and tia:tia_BedragKoopprijs]) = 0)
									or (count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'vrij op naam']) = count(tia:IMKAD_ZakelijkRecht) and $stukdeelKoop/tia:transactiesom
										and count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'vrij op naam' and tia:tia_BedragKoopprijs]) = 0)
									or (count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'exclusief omzetbelasting']) = count(tia:IMKAD_ZakelijkRecht) and $stukdeelKoop/tia:transactiesom
										and count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'exclusief omzetbelasting' and tia:tia_BedragKoopprijs]) = 0)
									or (count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'koop aanneemsom']) = count(tia:IMKAD_ZakelijkRecht) and $stukdeelKoop/tia:transactiesom
										and count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'koop aanneemsom' and tia:tia_BedragKoopprijs]) = 0)">
							<xsl:choose>
								<!-- Variant 1.a Koopprijs 'kaal' -->
								<xsl:when test="count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'kaal']) = count(tia:IMKAD_ZakelijkRecht)
											and $stukdeelKoop/tia:transactiesom">
									<p>
										<xsl:text>De koopprijs </xsl:text>
										<xsl:if test="tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true']">
											<xsl:text>van </xsl:text>
											<xsl:choose>
												<xsl:when test="count(tia:IMKAD_ZakelijkRecht) = 1 and tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true']">
													<xsl:text>het Registergoed </xsl:text>
													<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
													<xsl:text> </xsl:text>
												</xsl:when>
												<xsl:when test="count(tia:IMKAD_ZakelijkRecht) = 1 or
																(count(tia:IMKAD_ZakelijkRecht) = count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst, $upper, $lower) = $registergoedAanduiding])) or
																tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'false']">
													<xsl:value-of select="$registergoedAanduiding"/>
													<xsl:text> </xsl:text>
												</xsl:when>
												<xsl:otherwise>
													<xsl:text>de Registergoederen </xsl:text>
													<xsl:for-each select="tia:IMKAD_ZakelijkRecht">
														<xsl:if test="count(../tia:IMKAD_ZakelijkRecht) = count(../tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true'])">
															<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
															<xsl:choose>
																<xsl:when test="position() = last() - 1">
																	<xsl:text> en </xsl:text>
																</xsl:when>
																<xsl:when test="position() != last()">
																	<xsl:text>, </xsl:text>
																</xsl:when>
															</xsl:choose>
														</xsl:if>
													</xsl:for-each>
													<xsl:text> </xsl:text>
												</xsl:otherwise>
											</xsl:choose>
										</xsl:if>
										<xsl:if test="$stukdeelKoop/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijstezamen']/tia:tekst = 'true'">
											<xsl:text>tezamen </xsl:text>
										</xsl:if>
										<xsl:text>is: </xsl:text>
										<xsl:choose>
											<xsl:when test="count(tia:IMKAD_ZakelijkRecht) = 1">
												<xsl:apply-templates select="tia:IMKAD_ZakelijkRecht" mode="do-choose-amount-for-variant-a">
													<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
													<xsl:with-param name="bedragKoopprijs" select="tia:IMKAD_ZakelijkRecht/tia:tia_BedragKoopprijs[1]"/>
												</xsl:apply-templates>
											</xsl:when>
											<xsl:when test="tia:IMKAD_ZakelijkRecht[tia:tia_BedragKoopprijs and tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst = 'true'
															and tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'true'
															and $stukdeelKoop/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsperregistergoed']/tia:tekst = 'false']">
												<xsl:for-each select="tia:IMKAD_ZakelijkRecht">
													<xsl:apply-templates select="." mode="do-bedragKoopprijs-amount">
														<xsl:with-param name="bedragKoopprijs" select="tia:tia_BedragKoopprijs[1]"/>
														<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
														<xsl:with-param name="standaardLevering" select="true"/>
													</xsl:apply-templates>
												</xsl:for-each>
											</xsl:when>
											<xsl:otherwise>
												<xsl:apply-templates select="tia:IMKAD_ZakelijkRecht[1]" mode="do-transactiesom-amount">
													<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
												</xsl:apply-templates>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:if test="$stukdeelKoop/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsperregistergoed']/tia:tekst = 'true' and
													tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true']">
											<xsl:text>, te weten:</xsl:text>
											<ul class="arrow">
												<xsl:for-each select="tia:IMKAD_ZakelijkRecht">
													<li class="arrow">
														<xsl:text>voor Registergoed </xsl:text>
														<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
														<xsl:text>: </xsl:text>
														<xsl:call-template name="amountText">
															<xsl:with-param name="amount" select="tia:tia_BedragKoopprijs/tia:som"/>
															<xsl:with-param name="valuta" select="tia:tia_BedragKoopprijs/tia:valuta"/>
														</xsl:call-template>
														<xsl:text> </xsl:text>
														<xsl:call-template name="amountNumber">
															<xsl:with-param name="amount" select="tia:tia_BedragKoopprijs/tia:som"/>
															<xsl:with-param name="valuta" select="tia:tia_BedragKoopprijs/tia:valuta"/>
														</xsl:call-template>
														<xsl:choose>
															<xsl:when test="position() = last()">
																<xsl:text>.</xsl:text>
															</xsl:when>
															<xsl:otherwise>
																<xsl:text>;</xsl:text>
															</xsl:otherwise>
														</xsl:choose>
													</li>
												</xsl:for-each>
											</ul>
										</xsl:if>
										<xsl:if test="$stukdeelKoop/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsperregistergoed']/tia:tekst != 'true'">
											<xsl:text>.</xsl:text>
										</xsl:if>
										<xsl:if test="$stukdeelKoop/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_geenroerendezaken']/tia:tekst = 'true'">
											<xsl:text> Er zijn geen roerende zaken meeverkocht.</xsl:text>
										</xsl:if>
									</p>
								</xsl:when>
								<!-- Variant 1.b Koopprijs 'met daarnaast een bedrag aan roerende zaken' -->
								<xsl:when test="count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'roerende zaken exclusief']) = count(tia:IMKAD_ZakelijkRecht)
											and $stukdeelKoop/tia:transactiesom">
									<p>
										<xsl:text>De koopprijs </xsl:text>
										<xsl:if test="tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true']">
											<xsl:text>van </xsl:text>
											<xsl:choose>
												<xsl:when test="count(tia:IMKAD_ZakelijkRecht) = 1 and tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true']">
													<xsl:text>het Registergoed </xsl:text>
													<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
													<xsl:text> </xsl:text>
												</xsl:when>
												<xsl:when test="count(tia:IMKAD_ZakelijkRecht) = 1 or
																(count(tia:IMKAD_ZakelijkRecht) = count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst, $upper, $lower) = $registergoedAanduiding])) or
																tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'false']">
													<xsl:value-of select="$registergoedAanduiding"/>
													<xsl:text> </xsl:text>
												</xsl:when>
												<xsl:otherwise>
													<xsl:text>de Registergoederen </xsl:text>
													<xsl:for-each select="tia:IMKAD_ZakelijkRecht">
														<xsl:if test="count(../tia:IMKAD_ZakelijkRecht) = count(../tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true'])">
															<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
															<xsl:choose>
																<xsl:when test="position() = last() - 1">
																	<xsl:text> en </xsl:text>
																</xsl:when>
																<xsl:when test="position() != last()">
																	<xsl:text>, </xsl:text>
																</xsl:when>
															</xsl:choose>
														</xsl:if>
													</xsl:for-each>
													<xsl:text> </xsl:text>
												</xsl:otherwise>
											</xsl:choose>
										</xsl:if>
										<xsl:text>is: </xsl:text>
										<xsl:choose>
											<xsl:when test="count(tia:IMKAD_ZakelijkRecht) = 1">
												<xsl:apply-templates select="tia:IMKAD_ZakelijkRecht" mode="do-choose-amount-for-variant-x">
													<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
													<xsl:with-param name="bedragKoopprijs" select="tia:IMKAD_ZakelijkRecht/tia:tia_BedragKoopprijs"/>
												</xsl:apply-templates>
											</xsl:when>
											<xsl:otherwise>
												<xsl:apply-templates select="tia:IMKAD_ZakelijkRecht[1]" mode="do-transactiesom-amount">
													<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
												</xsl:apply-templates>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:text>. </xsl:text>
										<xsl:value-of select="$partyText"/>
										<xsl:choose>
											<xsl:when test="contains(translate($partyText, $upper, $lower), 'en')">
												<xsl:text> hebben </xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text> heeft </xsl:text>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:text>aan de </xsl:text>
										<xsl:choose>
											<xsl:when test="translate($registergoederenTonenRoerendeZaken, $upper, $lower) = 'true' and count(tia:IMKAD_ZakelijkRecht) = count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederentonenroerendezaken']/tia:tekst, $upper, $lower) = 'true'])">
												<xsl:text>in </xsl:text>
												<xsl:if test="tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true']">
													<xsl:choose>
														<xsl:when test="count(tia:IMKAD_ZakelijkRecht) = 1 and tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true']">
															<xsl:text>het Registergoed </xsl:text>
															<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
															<xsl:text> </xsl:text>
														</xsl:when>
														<xsl:when test="count(tia:IMKAD_ZakelijkRecht) = 1 or
																		(count(tia:IMKAD_ZakelijkRecht) = count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst, $upper, $lower) = $registergoedAanduiding])) or
																		tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'false']">
															<xsl:value-of select="$registergoedAanduiding"/>
															<xsl:text> </xsl:text>
														</xsl:when>
														<xsl:otherwise>
															<xsl:text>de Registergoederen </xsl:text>
															<xsl:for-each select="tia:IMKAD_ZakelijkRecht">
																<xsl:if test="count(../tia:IMKAD_ZakelijkRecht) = count(../tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true'])">
																	<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
																	<xsl:choose>
																		<xsl:when test="position() = last() - 1">
																			<xsl:text> en </xsl:text>
																		</xsl:when>
																		<xsl:when test="position() != last()">
																			<xsl:text>, </xsl:text>
																		</xsl:when>
																	</xsl:choose>
																</xsl:if>
															</xsl:for-each>
															<xsl:text> </xsl:text>
														</xsl:otherwise>
													</xsl:choose>
												</xsl:if>
												<xsl:text>begrepen </xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text>meeverkochte </xsl:text>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:text>roerende zaken een waarde toegekend groot </xsl:text>
										<xsl:call-template name="amountText">
											<xsl:with-param name="amount" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'false']/tia:roerendezakenWaarde/tia:som"/>
											<xsl:with-param name="valuta" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'false']/tia:roerendezakenWaarde/tia:valuta"/>
										</xsl:call-template>
										<xsl:text> </xsl:text>
										<xsl:call-template name="amountNumber">
											<xsl:with-param name="amount" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'false']/tia:roerendezakenWaarde/tia:som"/>
											<xsl:with-param name="valuta" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'false']/tia:roerendezakenWaarde/tia:valuta"/>
										</xsl:call-template>
										<xsl:text>. De koopprijs </xsl:text>
										<xsl:if test="translate($registergoederenTonenRoerendeZaken, $upper, $lower) = 'true' and count(tia:IMKAD_ZakelijkRecht) = count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederentonenroerendezaken']/tia:tekst, $upper, $lower) = 'true'])">
											<xsl:if test="tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true']">
												<xsl:text>van </xsl:text>
												<xsl:choose>
													<xsl:when test="count(tia:IMKAD_ZakelijkRecht) = 1 and tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true']">
														<xsl:text>het Registergoed </xsl:text>
														<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
														<xsl:text> </xsl:text>
													</xsl:when>
													<xsl:when test="count(tia:IMKAD_ZakelijkRecht) = 1 or
																	(count(tia:IMKAD_ZakelijkRecht) = count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst, $upper, $lower) = $registergoedAanduiding])) or
																	tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'false']">
														<xsl:value-of select="$registergoedAanduiding"/>
														<xsl:text> </xsl:text>
													</xsl:when>
													<xsl:otherwise>
														<xsl:text>de Registergoederen </xsl:text>
														<xsl:for-each select="tia:IMKAD_ZakelijkRecht">
															<xsl:if test="count(../tia:IMKAD_ZakelijkRecht) = count(../tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true'])">
																<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
																<xsl:choose>
																	<xsl:when test="position() = last() - 1">
																		<xsl:text> en </xsl:text>
																	</xsl:when>
																	<xsl:when test="position() != last()">
																		<xsl:text>, </xsl:text>
																	</xsl:when>
																</xsl:choose>
															</xsl:if>
														</xsl:for-each>
														<xsl:text> </xsl:text>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:if>
										</xsl:if>
										<xsl:text>wordt met dit bedrag verhoogd. </xsl:text>
										<xsl:if test="$registergoederenOpsommingAangehecht = 'true' and count(tia:IMKAD_ZakelijkRecht) = count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederenopsommingaangehecht']/tia:tekst, $upper, $lower) = 'true'])">
											<xsl:text>Van welke roerende zaken een opsomming </xsl:text>
											<xsl:value-of select="$registergoederenOpsommingAangehechtTekst"/>
											<xsl:text> gehecht aan deze akte.</xsl:text>
										</xsl:if>
									</p>
								</xsl:when>
								<!-- Variant 1.c Koopprijs 'met inbegrip van een bedrag aan roerende zaken' -->
								<xsl:when test="count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'roerende zaken inclusief']) = count(tia:IMKAD_ZakelijkRecht)
											and $stukdeelKoop/tia:transactiesom">
									<p>
										<xsl:text>De koopprijs </xsl:text>
										<xsl:if test="tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true']">
											<xsl:text>van </xsl:text>
											<xsl:choose>
												<xsl:when test="count(tia:IMKAD_ZakelijkRecht) = 1 and tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true']">
													<xsl:text>het Registergoed </xsl:text>
													<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
													<xsl:text> </xsl:text>
												</xsl:when>
												<xsl:when test="count(tia:IMKAD_ZakelijkRecht) = 1
																or (count(tia:IMKAD_ZakelijkRecht) = count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst, $upper, $lower) = $registergoedAanduiding]))
																or tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'false']">
													<xsl:value-of select="$registergoedAanduiding"/>
													<xsl:text> </xsl:text>
												</xsl:when>
												<xsl:otherwise>
													<xsl:text>de Registergoederen </xsl:text>
													<xsl:for-each select="tia:IMKAD_ZakelijkRecht">
														<xsl:if test="count(../tia:IMKAD_ZakelijkRecht) = count(../tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true'])">
															<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
															<xsl:choose>
																<xsl:when test="position() = last() - 1">
																	<xsl:text> en </xsl:text>
																</xsl:when>
																<xsl:when test="position() != last()">
																	<xsl:text>, </xsl:text>
																</xsl:when>
															</xsl:choose>
														</xsl:if>
													</xsl:for-each>
													<xsl:text> </xsl:text>
												</xsl:otherwise>
											</xsl:choose>
										</xsl:if>
										<xsl:text>is: </xsl:text>
										<xsl:choose>
											<xsl:when test="count(tia:IMKAD_ZakelijkRecht) = 1">
												<xsl:apply-templates select="tia:IMKAD_ZakelijkRecht" mode="do-choose-amount-for-variant-x">
													<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
													<xsl:with-param name="bedragKoopprijs" select="tia:IMKAD_ZakelijkRecht/tia:tia_BedragKoopprijs"/>
												</xsl:apply-templates>
											</xsl:when>
											<xsl:otherwise>
												<xsl:apply-templates select="tia:IMKAD_ZakelijkRecht[1]" mode="do-transactiesom-amount">
													<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
												</xsl:apply-templates>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:text>. In </xsl:text>
										<xsl:value-of select="$koopprijsLidwoord"/>
										<xsl:text> koopprijs is een bedrag van </xsl:text>
										<xsl:call-template name="amountText">
											<xsl:with-param name="amount" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'true']/tia:roerendezakenWaarde/tia:som"/>
											<xsl:with-param name="valuta" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'true']/tia:roerendezakenWaarde/tia:valuta"/>
										</xsl:call-template>
										<xsl:text> </xsl:text>
										<xsl:call-template name="amountNumber">
											<xsl:with-param name="amount" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'true']/tia:roerendezakenWaarde/tia:som"/>
											<xsl:with-param name="valuta" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'true']/tia:roerendezakenWaarde/tia:valuta"/>
										</xsl:call-template>
										<xsl:text> voor roerende zaken begrepen. </xsl:text>
										<xsl:if test="$registergoederenOpsommingAangehecht = 'true' and count(tia:IMKAD_ZakelijkRecht) = count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederenopsommingaangehecht']/tia:tekst, $upper, $lower) = 'true'])">
											<xsl:text>Van welke roerende zaken een opsomming </xsl:text>
											<xsl:value-of select="$registergoederenOpsommingAangehechtTekst"/>
											<xsl:text> gehecht aan deze akte.</xsl:text>
										</xsl:if>
									</p>
								</xsl:when>
								<!-- Variant 1.d Koopprijs 'vrij op naam' -->
								<xsl:when test="count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'vrij op naam']) = count(tia:IMKAD_ZakelijkRecht)
											and $stukdeelKoop/tia:transactiesom">
									<p>
										<xsl:text>De koopprijs </xsl:text>
										<xsl:if test="tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true']">
											<xsl:text>van </xsl:text>
											<xsl:choose>
												<xsl:when test="count(tia:IMKAD_ZakelijkRecht) = 1 and tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true']">
													<xsl:text>het Registergoed </xsl:text>
													<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
													<xsl:text> </xsl:text>
												</xsl:when>
												<xsl:when test="count(tia:IMKAD_ZakelijkRecht) = 1 or
																(count(tia:IMKAD_ZakelijkRecht) = count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst, $upper, $lower) = $registergoedAanduiding])) or
																tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'false']">
													<xsl:value-of select="$registergoedAanduiding"/>
													<xsl:text> </xsl:text>
												</xsl:when>
												<xsl:otherwise>
													<xsl:text>de Registergoederen </xsl:text>
													<xsl:for-each select="tia:IMKAD_ZakelijkRecht">
														<xsl:if test="count(../tia:IMKAD_ZakelijkRecht) = count(../tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true'])">
															<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
															<xsl:choose>
																<xsl:when test="position() = last() - 1">
																	<xsl:text> en </xsl:text>
																</xsl:when>
																<xsl:when test="position() != last()">
																	<xsl:text>, </xsl:text>
																</xsl:when>
															</xsl:choose>
														</xsl:if>
													</xsl:for-each>
													<xsl:text> </xsl:text>
												</xsl:otherwise>
											</xsl:choose>
										</xsl:if>
										<xsl:text>is: </xsl:text>
										<xsl:choose>
											<xsl:when test="count(tia:IMKAD_ZakelijkRecht) = 1">
												<xsl:apply-templates select="tia:IMKAD_ZakelijkRecht" mode="do-choose-amount-for-variant-x">
													<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
													<xsl:with-param name="bedragKoopprijs" select="tia:IMKAD_ZakelijkRecht/tia:tia_BedragKoopprijs"/>
												</xsl:apply-templates>
											</xsl:when>
											<xsl:otherwise>
												<xsl:apply-templates select="tia:IMKAD_ZakelijkRecht[1]" mode="do-transactiesom-amount">
													<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
												</xsl:apply-templates>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:text>, inclusief een bedrag van </xsl:text>
										<xsl:call-template name="amountText">
											<xsl:with-param name="amount" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']/tia:omzetbelasting/tia:som"/>
											<xsl:with-param name="valuta" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']/tia:omzetbelasting/tia:valuta"/>
										</xsl:call-template>
										<xsl:text> </xsl:text>
										<xsl:call-template name="amountNumber">
											<xsl:with-param name="amount" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']/tia:omzetbelasting/tia:som"/>
											<xsl:with-param name="valuta" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']/tia:omzetbelasting/tia:valuta"/>
										</xsl:call-template>
										<xsl:text> aan omzetbelasting. De notari&#x00EB;le kosten, de daarover verschuldigde omzetbelasting en het kadastraal recht wegens de levering van </xsl:text>
										<xsl:if test="tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true']">
											<xsl:choose>
												<xsl:when test="count(tia:IMKAD_ZakelijkRecht) = 1 and tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true']">
													<xsl:text>het Registergoed </xsl:text>
													<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
													<xsl:text> </xsl:text>
												</xsl:when>
												<xsl:when test="count(tia:IMKAD_ZakelijkRecht) = 1 or
																(count(tia:IMKAD_ZakelijkRecht) = count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst, $upper, $lower) = $registergoedAanduiding])) or
																tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'false']">
													<xsl:value-of select="$registergoedAanduiding"/>
													<xsl:text> </xsl:text>
												</xsl:when>
												<xsl:otherwise>
													<xsl:text>de Registergoederen </xsl:text>
													<xsl:for-each select="tia:IMKAD_ZakelijkRecht">
														<xsl:if test="count(../tia:IMKAD_ZakelijkRecht) = count(../tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true'])">
															<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
															<xsl:choose>
																<xsl:when test="position() = last() - 1">
																	<xsl:text> en </xsl:text>
																</xsl:when>
																<xsl:when test="position() != last()">
																	<xsl:text>, </xsl:text>
																</xsl:when>
															</xsl:choose>
														</xsl:if>
													</xsl:for-each>
													<xsl:text> </xsl:text>
												</xsl:otherwise>
											</xsl:choose>
										</xsl:if>
										<xsl:text>zijn voor rekening van </xsl:text>
										<xsl:value-of select="$partyNameVariantVrijOpNaam"/>
										<xsl:text>.</xsl:text>
									</p>
								</xsl:when>
								<!-- Variant 1.e Koopprijs 'exclusief omzetbelasting' -->
								<xsl:when test="count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'exclusief omzetbelasting']) = count(tia:IMKAD_ZakelijkRecht)
											and $stukdeelKoop/tia:transactiesom">
									<p>
										<xsl:text>De koopprijs </xsl:text>
										<xsl:if test="tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true']">
											<xsl:text>van </xsl:text>
											<xsl:choose>
												<xsl:when test="count(tia:IMKAD_ZakelijkRecht) = 1 and tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true']">
													<xsl:text>het Registergoed </xsl:text>
													<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
													<xsl:text> </xsl:text>
												</xsl:when>
												<xsl:when test="count(tia:IMKAD_ZakelijkRecht) = 1 or
																(count(tia:IMKAD_ZakelijkRecht) = count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst, $upper, $lower) = $registergoedAanduiding])) or
																tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'false']">
													<xsl:value-of select="$registergoedAanduiding"/>
													<xsl:text> </xsl:text>
												</xsl:when>
												<xsl:otherwise>
													<xsl:text>de Registergoederen </xsl:text>
													<xsl:for-each select="tia:IMKAD_ZakelijkRecht">
														<xsl:if test="count(../tia:IMKAD_ZakelijkRecht) = count(../tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true'])">
															<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
															<xsl:choose>
																<xsl:when test="position() = last() - 1">
																	<xsl:text> en </xsl:text>
																</xsl:when>
																<xsl:when test="position() != last()">
																	<xsl:text>, </xsl:text>
																</xsl:when>
															</xsl:choose>
														</xsl:if>
													</xsl:for-each>
													<xsl:text> </xsl:text>
												</xsl:otherwise>
											</xsl:choose>
										</xsl:if>
										<xsl:text>is: </xsl:text>
										<xsl:choose>
											<xsl:when test="count(tia:IMKAD_ZakelijkRecht) = 1">
												<xsl:apply-templates select="tia:IMKAD_ZakelijkRecht" mode="do-choose-amount-for-variant-x">
													<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
													<xsl:with-param name="bedragKoopprijs" select="tia:IMKAD_ZakelijkRecht/tia:tia_BedragKoopprijs"/>
												</xsl:apply-templates>
											</xsl:when>
											<xsl:otherwise>
												<xsl:apply-templates select="tia:IMKAD_ZakelijkRecht[1]" mode="do-transactiesom-amount">
													<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
												</xsl:apply-templates>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:text>, te vermeerderen met een bedrag van </xsl:text>
										<xsl:call-template name="amountText">
											<xsl:with-param name="amount" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']/tia:omzetbelasting/tia:som"/>
											<xsl:with-param name="valuta" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']/tia:omzetbelasting/tia:valuta"/>
										</xsl:call-template>
										<xsl:text> </xsl:text>
										<xsl:call-template name="amountNumber">
											<xsl:with-param name="amount" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']/tia:omzetbelasting/tia:som"/>
											<xsl:with-param name="valuta" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']/tia:omzetbelasting/tia:valuta"/>
										</xsl:call-template>
										<xsl:text> aan omzetbelasting.</xsl:text>
									</p>
								</xsl:when>
								<!-- Variant 1.f Koopprijs 'koop aanneemsom' -->
								<xsl:when test="count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'koop aanneemsom']) = count(tia:IMKAD_ZakelijkRecht)
											and $stukdeelKoop/tia:transactiesom">
									<p>
										<xsl:text>De koopprijs </xsl:text>
										<xsl:if test="tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true']">
											<xsl:text>van </xsl:text>
											<xsl:choose>
												<xsl:when test="count(tia:IMKAD_ZakelijkRecht) = 1 and tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true']">
													<xsl:text>het Registergoed </xsl:text>
													<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
													<xsl:text> </xsl:text>
												</xsl:when>
												<xsl:when test="count(tia:IMKAD_ZakelijkRecht) = 1 or
																(count(tia:IMKAD_ZakelijkRecht) = count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst, $upper, $lower) = $registergoedAanduiding])) or
																tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'false']">
													<xsl:value-of select="$registergoedAanduiding"/>
													<xsl:text> </xsl:text>
												</xsl:when>
												<xsl:otherwise>
													<xsl:text>de Registergoederen </xsl:text>
													<xsl:for-each select="tia:IMKAD_ZakelijkRecht">
														<xsl:if test="count(../tia:IMKAD_ZakelijkRecht) = count(../tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true'])">
															<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
															<xsl:choose>
																<xsl:when test="position() = last() - 1">
																	<xsl:text> en </xsl:text>
																</xsl:when>
																<xsl:when test="position() != last()">
																	<xsl:text>, </xsl:text>
																</xsl:when>
															</xsl:choose>
														</xsl:if>
													</xsl:for-each>
													<xsl:text> </xsl:text>
												</xsl:otherwise>
											</xsl:choose>
										</xsl:if>
										<xsl:text>is: </xsl:text>
										<xsl:choose>
											<xsl:when test="count(tia:IMKAD_ZakelijkRecht) = 1">
												<xsl:apply-templates select="tia:IMKAD_ZakelijkRecht" mode="do-choose-amount-for-variant-x">
													<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
													<xsl:with-param name="bedragKoopprijs" select="tia:IMKAD_ZakelijkRecht/tia:tia_BedragKoopprijs"/>
												</xsl:apply-templates>
											</xsl:when>
											<xsl:otherwise>
												<xsl:apply-templates select="tia:IMKAD_ZakelijkRecht[1]" mode="do-transactiesom-amount">
													<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
												</xsl:apply-templates>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:text>, terwijl de aanneemsom bedraagt </xsl:text>
										<xsl:call-template name="amountText">
											<xsl:with-param name="amount" select="$stukdeelKoop/tia:koopprijsSpecificatie/tia:aanneemsom/tia:som"/>
											<xsl:with-param name="valuta" select="$stukdeelKoop/tia:koopprijsSpecificatie/tia:aanneemsom/tia:valuta"/>
										</xsl:call-template>
										<xsl:text> </xsl:text>
										<xsl:call-template name="amountNumber">
											<xsl:with-param name="amount" select="$stukdeelKoop/tia:koopprijsSpecificatie/tia:aanneemsom/tia:som"/>
											<xsl:with-param name="valuta" select="$stukdeelKoop/tia:koopprijsSpecificatie/tia:aanneemsom/tia:valuta"/>
										</xsl:call-template>
										<xsl:text>, derhalve in totaal </xsl:text>
										<xsl:call-template name="amountText">
											<xsl:with-param name="amount" select="$stukdeelKoop/tia:koopprijsSpecificatie/tia:koopprijsTotaal/tia:som"/>
											<xsl:with-param name="valuta" select="$stukdeelKoop/tia:koopprijsSpecificatie/tia:koopprijsTotaal/tia:valuta"/>
										</xsl:call-template>
										<xsl:text> </xsl:text>
										<xsl:call-template name="amountNumber">
											<xsl:with-param name="amount" select="$stukdeelKoop/tia:koopprijsSpecificatie/tia:koopprijsTotaal/tia:som"/>
											<xsl:with-param name="valuta" select="$stukdeelKoop/tia:koopprijsSpecificatie/tia:koopprijsTotaal/tia:valuta"/>
										</xsl:call-template>
										<xsl:text>, </xsl:text>
										<xsl:choose>
											<xsl:when test="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']">
												<xsl:text>inclusief een bedrag van </xsl:text>
												<xsl:call-template name="amountText">
													<xsl:with-param name="amount" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']/tia:omzetbelasting/tia:som"/>
													<xsl:with-param name="valuta" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']/tia:omzetbelasting/tia:valuta"/>
												</xsl:call-template>
												<xsl:text> </xsl:text>
												<xsl:call-template name="amountNumber">
													<xsl:with-param name="amount" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']/tia:omzetbelasting/tia:som"/>
													<xsl:with-param name="valuta" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']/tia:omzetbelasting/tia:valuta"/>
												</xsl:call-template>
												<xsl:text> aan omzetbelasting. </xsl:text>
											</xsl:when>
											<xsl:when test="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']">
												<xsl:text>te vermeerderen met een bedrag van </xsl:text>
												<xsl:call-template name="amountText">
													<xsl:with-param name="amount" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']/tia:omzetbelasting/tia:som"/>
													<xsl:with-param name="valuta" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']/tia:omzetbelasting/tia:valuta"/>
												</xsl:call-template>
												<xsl:text> </xsl:text>
												<xsl:call-template name="amountNumber">
													<xsl:with-param name="amount" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']/tia:omzetbelasting/tia:som"/>
													<xsl:with-param name="valuta" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']/tia:omzetbelasting/tia:valuta"/>
												</xsl:call-template>
												<xsl:text> aan omzetbelasting. </xsl:text>
											</xsl:when>
										</xsl:choose>
										<xsl:if test="translate($stukdeelKoop/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopaanneemsomvoldaan']/tia:tekst, $upper, $lower) = 'true'">
											<xsl:text>Het per heden krachtens de koop</xsl:text>
											<xsl:if test="translate($stukdeelKoop/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aannemingsovereenkomst']/tia:tekst, $upper, $lower) = 'true'">
												<xsl:text>-/aannemingsovereenkomst</xsl:text>
											</xsl:if>
											<xsl:text> door koper verschuldigde bedrag ad </xsl:text>
											<xsl:choose>
												<xsl:when test="count(tia:IMKAD_ZakelijkRecht) = 1">
													<xsl:apply-templates select="tia:IMKAD_ZakelijkRecht" mode="do-choose-amount-for-variant-x">
														<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
														<xsl:with-param name="bedragKoopprijs" select="tia:IMKAD_ZakelijkRecht/tia:tia_BedragKoopprijs"/>
													</xsl:apply-templates>
												</xsl:when>
												<xsl:when test="tia:IMKAD_ZakelijkRecht[tia:tia_BedragKoopprijs and tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst = 'true'
																and tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'true']">
													<xsl:for-each select="tia:IMKAD_ZakelijkRecht">
														<xsl:apply-templates select="." mode="do-bedragKoopprijs-amount">
															<xsl:with-param name="bedragKoopprijs" select="tia:tia_BedragKoopprijs"/>
															<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
														</xsl:apply-templates>
													</xsl:for-each>
												</xsl:when>
												<xsl:otherwise>
													<xsl:apply-templates select="tia:IMKAD_ZakelijkRecht[1]" mode="do-transactiesom-amount">
														<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
													</xsl:apply-templates>
												</xsl:otherwise>
											</xsl:choose>
											<xsl:text>, zijnde de koopprijs van </xsl:text>
											<xsl:if test="tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true']">
												<xsl:choose>
													<xsl:when test="count(tia:IMKAD_ZakelijkRecht) = 1 and tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true']">
														<xsl:text>het Registergoed </xsl:text>
														<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
														<xsl:text>, </xsl:text>
													</xsl:when>
													<xsl:when test="count(tia:IMKAD_ZakelijkRecht) = 1 or
																	(count(tia:IMKAD_ZakelijkRecht) = count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst, $upper, $lower) = $registergoedAanduiding])) or
																	tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'false']">
														<xsl:value-of select="$registergoedAanduiding"/>
														<xsl:text>, </xsl:text>
													</xsl:when>
													<xsl:otherwise>
														<xsl:text>de Registergoederen </xsl:text>
														<xsl:for-each select="tia:IMKAD_ZakelijkRecht">
															<xsl:if test="count(../tia:IMKAD_ZakelijkRecht) = count(../tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true'])">
																<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
																<xsl:choose>
																	<xsl:when test="position() = last() - 1">
																		<xsl:text> en </xsl:text>
																	</xsl:when>
																	<xsl:when test="position() != last()">
																		<xsl:text>, </xsl:text>
																	</xsl:when>
																</xsl:choose>
															</xsl:if>
														</xsl:for-each>
														<xsl:text>, </xsl:text>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:if>
											<xsl:text>de vervallen termijnen van de aanneming en de overeenkomstig de koop</xsl:text>
											<xsl:if test="translate($stukdeelKoop/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aannemingsovereenkomst']/tia:tekst, $upper, $lower) = 'true'">
												<xsl:text>-/aannemingsovereenkomst</xsl:text>
											</xsl:if>
											<xsl:text> verschuldigde rente, een en ander inclusief omzetbelasting, is door </xsl:text>
											<xsl:value-of select="$partyNameVariantKoopAanneemsom"/>
											<xsl:text> aan de notaris voldaan.</xsl:text>
										</xsl:if>
									</p>
								</xsl:when>
							</xsl:choose>
						</xsl:when>
						<xsl:otherwise>
							<xsl:for-each select="tia:IMKAD_ZakelijkRecht">
								<xsl:choose>
									<!-- Variant 1.a Koopprijs 'kaal' -->
									<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'kaal'">
										<p>
											<xsl:text>De koopprijs </xsl:text>
											<xsl:if test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
												<xsl:text>van </xsl:text>
												<xsl:choose>
													<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true'">
														<xsl:text>het Registergoed </xsl:text>
														<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
														<xsl:text> </xsl:text>
													</xsl:when>
													<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
														<xsl:value-of select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst"/>
														<xsl:text> </xsl:text>
													</xsl:when>
												</xsl:choose>
											</xsl:if>
											<xsl:if test="$stukdeelKoop/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijstezamen']/tia:tekst = 'true'">
												<xsl:text>tezamen </xsl:text>
											</xsl:if>
											<xsl:text>is: </xsl:text>
											<xsl:apply-templates select="." mode="do-choose-amount-for-variant-a">
												<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
												<xsl:with-param name="bedragKoopprijs" select="tia:tia_BedragKoopprijs"/>
											</xsl:apply-templates>
											<xsl:text>.</xsl:text>
											<xsl:if test="$stukdeelKoop/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_geenroerendezaken']/tia:tekst = 'true'">
												<xsl:text> Er zijn geen roerende zaken meeverkocht.</xsl:text>
											</xsl:if>
										</p>
									</xsl:when>
									<!-- Variant 1.b Koopprijs 'met daarnaast een bedrag aan roerende zaken' -->
									<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'roerende zaken exclusief'">
										<p>
											<xsl:text>De koopprijs </xsl:text>
											<xsl:if test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
												<xsl:text>van </xsl:text>
												<xsl:choose>
													<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true'">
														<xsl:text>het Registergoed </xsl:text>
														<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
														<xsl:text> </xsl:text>
													</xsl:when>
													<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
														<xsl:value-of select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst"/>
														<xsl:text> </xsl:text>
													</xsl:when>
												</xsl:choose>
											</xsl:if>
											<xsl:text>is: </xsl:text>
											<xsl:apply-templates select="." mode="do-choose-amount-for-variant-x">
												<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
												<xsl:with-param name="bedragKoopprijs" select="tia:tia_BedragKoopprijs"/>
											</xsl:apply-templates>
											<xsl:text>.</xsl:text>
											<xsl:value-of select="$partyText"/>
											<xsl:choose>
												<xsl:when test="contains(translate($partyText, $upper, $lower), 'en')">
													<xsl:text> hebben </xsl:text>
												</xsl:when>
												<xsl:otherwise>
													<xsl:text> heeft </xsl:text>
												</xsl:otherwise>
											</xsl:choose>
											<xsl:text>aan de </xsl:text>
											<xsl:choose>
												<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederentonenroerendezaken']/tia:tekst, $upper, $lower) = 'true'">
													<xsl:text>in </xsl:text>
													<xsl:if test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
														<xsl:choose>
															<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true'">
																<xsl:text>het Registergoed </xsl:text>
																<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
																<xsl:text> </xsl:text>
															</xsl:when>
															<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
																<xsl:value-of select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst"/>
																<xsl:text> </xsl:text>
															</xsl:when>
														</xsl:choose>
													</xsl:if>
													<xsl:text> begrepen </xsl:text>
												</xsl:when>
												<xsl:otherwise>
													<xsl:text>meeverkochte </xsl:text>
												</xsl:otherwise>
											</xsl:choose>
											<xsl:text>roerende zaken een waarde toegekend groot </xsl:text>
											<xsl:call-template name="amountText">
												<xsl:with-param name="amount" select="tia:tia_KoopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'false']/tia:roerendezakenWaarde/tia:som"/>
												<xsl:with-param name="valuta" select="tia:tia_KoopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'false']/tia:roerendezakenWaarde/tia:valuta"/>
											</xsl:call-template>
											<xsl:text> </xsl:text>
											<xsl:call-template name="amountNumber">
												<xsl:with-param name="amount" select="tia:tia_KoopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'false']/tia:roerendezakenWaarde/tia:som"/>
												<xsl:with-param name="valuta" select="tia:tia_KoopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'false']/tia:roerendezakenWaarde/tia:valuta"/>
											</xsl:call-template>
											<xsl:text>. De koopprijs </xsl:text>
											<xsl:if test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederentonenroerendezaken']/tia:tekst, $upper, $lower) = 'true'">
												<xsl:if test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
													<xsl:text>van </xsl:text>
													<xsl:choose>
														<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true'">
															<xsl:text>het Registergoed </xsl:text>
															<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
															<xsl:text> </xsl:text>
														</xsl:when>
														<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
															<xsl:value-of select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst"/>
															<xsl:text> </xsl:text>
														</xsl:when>
													</xsl:choose>
												</xsl:if>
											</xsl:if>
											<xsl:text>wordt met dit bedrag verhoogd. </xsl:text>
											<xsl:if test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederenopsommingaangehecht']/tia:tekst, $upper, $lower) = 'true'">
												<xsl:text>Van welke roerende zaken een opsomming </xsl:text>
												<xsl:if test="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederenopsommingaangehechttekst']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
														translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederenopsommingaangehechttekst']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
														translate(normalize-space(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederenopsommingaangehechttekst']/tia:tekst), $upper, $lower)]), $upper, $lower)]">
													<xsl:value-of select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederenopsommingaangehechttekst']/tia:tekst"/>
												</xsl:if>
												<xsl:text> gehecht aan deze akte.</xsl:text>
											</xsl:if>
										</p>
									</xsl:when>
									<!-- Variant 1.c Koopprijs 'met inbegrip van een bedrag aan roerende zaken' -->
									<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'roerende zaken inclusief'">
										<p>
											<xsl:text>De koopprijs </xsl:text>
											<xsl:if test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
												<xsl:text>van </xsl:text>
												<xsl:choose>
													<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true'">
														<xsl:text>het Registergoed </xsl:text>
														<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
														<xsl:text> </xsl:text>
													</xsl:when>
													<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
														<xsl:value-of select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst"/>
														<xsl:text> </xsl:text>
													</xsl:when>
												</xsl:choose>
											</xsl:if>
											<xsl:text>is: </xsl:text>
											<xsl:apply-templates select="." mode="do-choose-amount-for-variant-x">
												<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
												<xsl:with-param name="bedragKoopprijs" select="tia:tia_BedragKoopprijs"/>
											</xsl:apply-templates>
											<xsl:text>. In </xsl:text>
											<xsl:value-of select="$koopprijsLidwoord"/>
											<xsl:text> koopprijs is een bedrag van </xsl:text>
											<xsl:call-template name="amountText">
												<xsl:with-param name="amount" select="tia:tia_KoopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'true']/tia:roerendezakenWaarde/tia:som"/>
												<xsl:with-param name="valuta" select="tia:tia_KoopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'true']/tia:roerendezakenWaarde/tia:valuta"/>
											</xsl:call-template>
											<xsl:text> </xsl:text>
											<xsl:call-template name="amountNumber">
												<xsl:with-param name="amount" select="tia:tia_KoopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'true']/tia:roerendezakenWaarde/tia:som"/>
												<xsl:with-param name="valuta" select="tia:tia_KoopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'true']/tia:roerendezakenWaarde/tia:valuta"/>
											</xsl:call-template>
											<xsl:text> voor roerende zaken begrepen. </xsl:text>
											<xsl:if test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederenopsommingaangehecht']/tia:tekst, $upper, $lower) = 'true'">
												<xsl:text>Van welke roerende zaken een opsomming </xsl:text>
												<xsl:if test="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederenopsommingaangehechttekst']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
														translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederenopsommingaangehechttekst']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
														translate(normalize-space(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederenopsommingaangehechttekst']/tia:tekst), $upper, $lower)]), $upper, $lower)]">
													<xsl:value-of select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederenopsommingaangehechttekst']/tia:tekst"/>
												</xsl:if>
												<xsl:text> gehecht aan deze akte.</xsl:text>
											</xsl:if>
										</p>
									</xsl:when>
									<!-- Variant 1.d Koopprijs 'vrij op naam' -->
									<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'vrij op naam'">
										<p>
											<xsl:text>De koopprijs </xsl:text>
											<xsl:if test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
												<xsl:text>van </xsl:text>
												<xsl:choose>
													<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true'">
														<xsl:text>het Registergoed </xsl:text>
														<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
														<xsl:text> </xsl:text>
													</xsl:when>
													<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
														<xsl:value-of select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst"/>
														<xsl:text> </xsl:text>
													</xsl:when>
												</xsl:choose>
											</xsl:if>
											<xsl:text>is: </xsl:text>
											<xsl:apply-templates select="." mode="do-choose-amount-for-variant-x">
												<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
												<xsl:with-param name="bedragKoopprijs" select="tia:tia_BedragKoopprijs"/>
											</xsl:apply-templates>
											<xsl:text>, inclusief een bedrag van </xsl:text>
											<xsl:call-template name="amountText">
												<xsl:with-param name="amount" select="tia:tia_KoopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']/tia:omzetbelasting/tia:som"/>
												<xsl:with-param name="valuta" select="tia:tia_KoopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']/tia:omzetbelasting/tia:valuta"/>
											</xsl:call-template>
											<xsl:text> </xsl:text>
											<xsl:call-template name="amountNumber">
												<xsl:with-param name="amount" select="tia:tia_KoopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']/tia:omzetbelasting/tia:som"/>
												<xsl:with-param name="valuta" select="tia:tia_KoopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']/tia:omzetbelasting/tia:valuta"/>
											</xsl:call-template>
											<xsl:text> aan omzetbelasting. De notari&#x00EB;le kosten, de daarover verschuldigde omzetbelasting en het kadastraal recht wegens de levering van </xsl:text>
											<xsl:if test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
												<xsl:choose>
													<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true'">
														<xsl:text>het Registergoed </xsl:text>
														<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
														<xsl:text> </xsl:text>
													</xsl:when>
													<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
														<xsl:value-of select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst"/>
														<xsl:text> </xsl:text>
													</xsl:when>
												</xsl:choose>
											</xsl:if>
											<xsl:text>zijn voor rekening van </xsl:text>
											<xsl:value-of select="$partyNameVariantVrijOpNaam"/>
											<xsl:text>.</xsl:text>
										</p>
									</xsl:when>
									<!-- Variant 1.e Koopprijs 'exclusief omzetbelasting' -->
									<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'exclusief omzetbelasting'">
										<p>
											<xsl:text>De koopprijs </xsl:text>
											<xsl:if test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
												<xsl:text>van </xsl:text>
												<xsl:choose>
													<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true'">
														<xsl:text>het Registergoed </xsl:text>
														<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
														<xsl:text> </xsl:text>
													</xsl:when>
													<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
														<xsl:value-of select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst"/>
														<xsl:text> </xsl:text>
													</xsl:when>
												</xsl:choose>
											</xsl:if>
											<xsl:text>is: </xsl:text>
											<xsl:apply-templates select="." mode="do-choose-amount-for-variant-x">
												<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
												<xsl:with-param name="bedragKoopprijs" select="tia:tia_BedragKoopprijs"/>
											</xsl:apply-templates>
											<xsl:text>, te vermeerderen met een bedrag van </xsl:text>
											<xsl:call-template name="amountText">
												<xsl:with-param name="amount" select="tia:tia_KoopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']/tia:omzetbelasting/tia:som"/>
												<xsl:with-param name="valuta" select="tia:tia_KoopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']/tia:omzetbelasting/tia:valuta"/>
											</xsl:call-template>
											<xsl:text> </xsl:text>
											<xsl:call-template name="amountNumber">
												<xsl:with-param name="amount" select="tia:tia_KoopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']/tia:omzetbelasting/tia:som"/>
												<xsl:with-param name="valuta" select="tia:tia_KoopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']/tia:omzetbelasting/tia:valuta"/>
											</xsl:call-template>
											<xsl:text> aan omzetbelasting.</xsl:text>
										</p>
									</xsl:when>
									<!-- Variant 1.f Koopprijs 'koop aanneemsom' -->
									<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'koop aanneemsom'">
										<p>
											<xsl:text>De koopprijs </xsl:text>
											<xsl:if test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
												<xsl:text>van </xsl:text>
												<xsl:choose>
													<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true'">
														<xsl:text>het Registergoed </xsl:text>
														<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
														<xsl:text> </xsl:text>
													</xsl:when>
													<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
														<xsl:value-of select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst"/>
														<xsl:text> </xsl:text>
													</xsl:when>
												</xsl:choose>
											</xsl:if>
											<xsl:text>is: </xsl:text>
											<xsl:apply-templates select="." mode="do-choose-amount-for-variant-x">
												<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
												<xsl:with-param name="bedragKoopprijs" select="tia:tia_BedragKoopprijs"/>
											</xsl:apply-templates>
											<xsl:text>, terwijl de aanneemsom bedraagt </xsl:text>
											<xsl:call-template name="amountText">
												<xsl:with-param name="amount" select="tia:tia_KoopprijsSpecificatie/tia:aanneemsom/tia:som"/>
												<xsl:with-param name="valuta" select="tia:tia_KoopprijsSpecificatie/tia:aanneemsom/tia:valuta"/>
											</xsl:call-template>
											<xsl:text> </xsl:text>
											<xsl:call-template name="amountNumber">
												<xsl:with-param name="amount" select="tia:tia_KoopprijsSpecificatie/tia:aanneemsom/tia:som"/>
												<xsl:with-param name="valuta" select="tia:tia_KoopprijsSpecificatie/tia:aanneemsom/tia:valuta"/>
											</xsl:call-template>
											<xsl:text>, derhalve in totaal </xsl:text>
											<xsl:call-template name="amountText">
												<xsl:with-param name="amount" select="tia:tia_KoopprijsSpecificatie/tia:koopprijsTotaal/tia:som"/>
												<xsl:with-param name="valuta" select="tia:tia_KoopprijsSpecificatie/tia:koopprijsTotaal/tia:valuta"/>
											</xsl:call-template>
											<xsl:text> </xsl:text>
											<xsl:call-template name="amountNumber">
												<xsl:with-param name="amount" select="tia:tia_KoopprijsSpecificatie/tia:koopprijsTotaal/tia:som"/>
												<xsl:with-param name="valuta" select="tia:tia_KoopprijsSpecificatie/tia:koopprijsTotaal/tia:valuta"/>
											</xsl:call-template>
											<xsl:text>, </xsl:text>
											<xsl:choose>
												<xsl:when test="tia:tia_KoopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']">
													<xsl:text>inclusief een bedrag van </xsl:text>
													<xsl:call-template name="amountText">
														<xsl:with-param name="amount" select="tia:tia_KoopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']/tia:omzetbelasting/tia:som"/>
														<xsl:with-param name="valuta" select="tia:tia_KoopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']/tia:omzetbelasting/tia:valuta"/>
													</xsl:call-template>
													<xsl:text> </xsl:text>
													<xsl:call-template name="amountNumber">
														<xsl:with-param name="amount" select="tia:tia_KoopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']/tia:omzetbelasting/tia:som"/>
														<xsl:with-param name="valuta" select="tia:tia_KoopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']/tia:omzetbelasting/tia:valuta"/>
													</xsl:call-template>
													<xsl:text> aan omzetbelasting. </xsl:text>
												</xsl:when>
												<xsl:when test="tia:tia_KoopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']">
													<xsl:text>te vermeerderen met een bedrag van </xsl:text>
													<xsl:call-template name="amountText">
														<xsl:with-param name="amount" select="tia:tia_KoopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']/tia:omzetbelasting/tia:som"/>
														<xsl:with-param name="valuta" select="tia:tia_KoopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']/tia:omzetbelasting/tia:valuta"/>
													</xsl:call-template>
													<xsl:text> </xsl:text>
													<xsl:call-template name="amountNumber">
														<xsl:with-param name="amount" select="tia:tia_KoopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']/tia:omzetbelasting/tia:som"/>
														<xsl:with-param name="valuta" select="tia:tia_KoopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']/tia:omzetbelasting/tia:valuta"/>
													</xsl:call-template>
													<xsl:text> aan omzetbelasting. </xsl:text>
												</xsl:when>
											</xsl:choose>
											<xsl:if test="translate($stukdeelKoop/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopaanneemsomvoldaan']/tia:tekst, $upper, $lower) = 'true'">
												<xsl:text>Het per heden krachtens de koop</xsl:text>
												<xsl:if test="translate($stukdeelKoop/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aannemingsovereenkomst']/tia:tekst, $upper, $lower) = 'true'">
													<xsl:text>-/aannemingsovereenkomst</xsl:text>
												</xsl:if>
												<xsl:text> door koper verschuldigde bedrag ad </xsl:text>
												<xsl:apply-templates select="." mode="do-choose-amount-for-variant-x">
													<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
													<xsl:with-param name="bedragKoopprijs" select="tia:tia_BedragKoopprijs"/>
												</xsl:apply-templates>
												<xsl:text>, zijnde de koopprijs van </xsl:text>
												<xsl:if test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
													<xsl:choose>
														<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true'">
															<xsl:text>het Registergoed </xsl:text>
															<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
															<xsl:text> </xsl:text>
														</xsl:when>
														<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
															<xsl:value-of select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst"/>
															<xsl:text> </xsl:text>
														</xsl:when>
													</xsl:choose>
												</xsl:if>
												<xsl:text>de vervallen termijnen van de aanneming en de overeenkomstig de koop</xsl:text>
												<xsl:if test="translate($stukdeelKoop/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aannemingsovereenkomst']/tia:tekst, $upper, $lower) = 'true'">
													<xsl:text>-/aannemingsovereenkomst</xsl:text>
												</xsl:if>
												<xsl:text> verschuldigde rente, een en ander inclusief omzetbelasting, is door </xsl:text>
												<xsl:value-of select="$partyNameVariantKoopAanneemsom"/>
												<xsl:text> aan de notaris voldaan.</xsl:text>
											</xsl:if>
										</p>
									</xsl:when>
								</xsl:choose>
							</xsl:for-each>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:if test="position() != last()">
						<br/>
					</xsl:if>
				</xsl:for-each>
			</xsl:when>
			<xsl:otherwise>
				<xsl:for-each select="tia:StukdeelLevering[tia:tia_Volgnummer]">
					<xsl:variable name="stukdeelkoop-volgnr" select="number(current()/tia:tia_Volgnummer) *2 - 1"/>
					<xsl:variable name="stukdeelKoop" select="../tia:StukdeelKoop[tia:tia_Volgnummer = $stukdeelkoop-volgnr]"/>
					<xsl:variable name="nextStukdeelKoop" select="../tia:StukdeelKoop[tia:tia_Volgnummer = $stukdeelkoop-volgnr + 1]"/>
					<xsl:variable name="koopprijsLidwoord" select="$stukdeelKoop/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijslidwoord']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
							translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijslidwoord']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
							translate(normalize-space($stukdeelKoop/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijslidwoord']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
					<xsl:variable name="registergoedAanduiding" select="tia:IMKAD_ZakelijkRecht[1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst"/>
					<xsl:variable name="registergoederenTonenRoerendeZaken" select="tia:IMKAD_ZakelijkRecht[1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederentonenroerendezaken']/tia:tekst"/>
					<xsl:variable name="registergoederenOpsommingAangehecht" select="tia:IMKAD_ZakelijkRecht[1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederenopsommingaangehecht']/tia:tekst"/>
					<xsl:variable name="registergoederenOpsommingAangehechtTekst" select="tia:IMKAD_ZakelijkRecht[1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederenopsommingaangehechttekst']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
							translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederenopsommingaangehechttekst']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
							translate(normalize-space(current()/tia:IMKAD_ZakelijkRecht[1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederenopsommingaangehechttekst']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
					<xsl:variable name="partyText">
						<xsl:choose>
							<xsl:when test="$stukdeelKoop/tia:koopprijsSpecificatie/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_partijkeuzekoopprijs']/tia:tekst = '2'">
								<xsl:choose>
									<xsl:when test="../tia:Partij[@id = substring-after($stukdeelKoop/tia:vervreemderRechtRef/@xlink:href, '#')]">
										<xsl:call-template name="capitalizePartyAlias">
											<xsl:with-param name="party" select="../tia:Partij[@id = substring-after($stukdeelKoop/tia:vervreemderRechtRef/@xlink:href, '#')]"/>
										</xsl:call-template>
									</xsl:when>
									<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after($stukdeelKoop/tia:vervreemderRechtRef/@xlink:href, '#')]">
										<xsl:call-template name="capitalizePartyAlias">
											<xsl:with-param name="party" select="../tia:Partij/tia:Partij[@id = substring-after($stukdeelKoop/tia:vervreemderRechtRef/@xlink:href, '#')]"/>
										</xsl:call-template>
									</xsl:when>
								</xsl:choose>
							</xsl:when>
							<xsl:when test="$stukdeelKoop/tia:koopprijsSpecificatie/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_partijkeuzekoopprijs']/tia:tekst = '1'">
								<xsl:choose>
									<xsl:when test="../tia:Partij[@id = substring-after($nextStukdeelKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]">
										<xsl:call-template name="capitalizePartyAlias">
											<xsl:with-param name="party" select="../tia:Partij[@id = substring-after($nextStukdeelKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]"/>
										</xsl:call-template>
									</xsl:when>
									<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after($nextStukdeelKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]">
										<xsl:call-template name="capitalizePartyAlias">
											<xsl:with-param name="party" select="../tia:Partij/tia:Partij[@id = substring-after($nextStukdeelKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]"/>
										</xsl:call-template>
									</xsl:when>
								</xsl:choose>
							</xsl:when>
							<xsl:when test="$stukdeelKoop/tia:koopprijsSpecificatie/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_partijkeuzekoopprijs']/tia:tekst = '3'">
								<xsl:choose>
									<xsl:when test="../tia:Partij[@id = substring-after($nextStukdeelKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]">
										<xsl:call-template name="capitalizePartyAlias">
											<xsl:with-param name="party" select="../tia:Partij[@id = substring-after($nextStukdeelKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]"/>
										</xsl:call-template>
										<xsl:text> en </xsl:text>
										<xsl:value-of select="../tia:Partij[@id = substring-after($stukdeelKoop/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
									</xsl:when>
									<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after($nextStukdeelKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]">
										<xsl:call-template name="capitalizePartyAlias">
											<xsl:with-param name="party" select="../tia:Partij/tia:Partij[@id = substring-after($nextStukdeelKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]"/>
										</xsl:call-template>
										<xsl:text> en </xsl:text>
										<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after($stukdeelKoop/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
									</xsl:when>
								</xsl:choose>
							</xsl:when>
						</xsl:choose>
					</xsl:variable>
					<xsl:variable name="partyNameVariantVrijOpNaam">
						<xsl:choose>
							<xsl:when test="../tia:Partij[@id = substring-after($stukdeelKoop/tia:vervreemderRechtRef/@xlink:href, '#')]">
								<xsl:value-of select="../tia:Partij[@id = substring-after($stukdeelKoop/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
							</xsl:when>
							<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after($stukdeelKoop/tia:vervreemderRechtRef/@xlink:href, '#')]">
								<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after($stukdeelKoop/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
							</xsl:when>
						</xsl:choose>
					</xsl:variable>
					<xsl:variable name="partyNameVariantKoopAanneemsom">
						<xsl:choose>
							<xsl:when test="../tia:Partij[@id = substring-after($stukdeelKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]">
								<xsl:call-template name="capitalizePartyAlias">
									<xsl:with-param name="party" select="../tia:Partij[@id = substring-after($stukdeelKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]"/>
								</xsl:call-template>
							</xsl:when>
							<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after($stukdeelKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]">
								<xsl:call-template name="capitalizePartyAlias">
									<xsl:with-param name="party" select="../tia:Partij/tia:Partij[@id = substring-after($stukdeelKoop/tia:verkrijgerRechtRef/@xlink:href, '#')]"/>
								</xsl:call-template>
							</xsl:when>
						</xsl:choose>
					</xsl:variable>
					<xsl:choose>
						<xsl:when test="(count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'kaal']) = count(tia:IMKAD_ZakelijkRecht) and $stukdeelKoop/tia:transactiesom)
									or (count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'roerende zaken exclusief']) = count(tia:IMKAD_ZakelijkRecht) and $stukdeelKoop/tia:transactiesom
										and count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'roerende zaken exclusief' and tia:tia_BedragKoopprijs]) = 0)
									or (count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'roerende zaken inclusief']) = count(tia:IMKAD_ZakelijkRecht) and $stukdeelKoop/tia:transactiesom
										and count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'roerende zaken inclusief' and tia:tia_BedragKoopprijs]) = 0)
									or (count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'vrij op naam']) = count(tia:IMKAD_ZakelijkRecht) and $stukdeelKoop/tia:transactiesom
										and count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'vrij op naam' and tia:tia_BedragKoopprijs]) = 0)
									or (count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'exclusief omzetbelasting']) = count(tia:IMKAD_ZakelijkRecht) and $stukdeelKoop/tia:transactiesom
										and count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'exclusief omzetbelasting' and tia:tia_BedragKoopprijs]) = 0)
									or (count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'koop aanneemsom']) = count(tia:IMKAD_ZakelijkRecht) and $stukdeelKoop/tia:transactiesom
										and count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'koop aanneemsom' and tia:tia_BedragKoopprijs]) = 0)">
							<xsl:choose>
								<!-- Variant 1.a Koopprijs 'kaal' -->
								<xsl:when test="count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'kaal']) = count(tia:IMKAD_ZakelijkRecht)
											and $stukdeelKoop/tia:transactiesom">
									<p>
										<xsl:text>De koopprijs </xsl:text>
										<xsl:if test="tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true']">
											<xsl:text>van </xsl:text>
											<xsl:choose>
												<xsl:when test="count(tia:IMKAD_ZakelijkRecht) = 1 and tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true']">
													<xsl:text>het Registergoed </xsl:text>
													<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
													<xsl:text> </xsl:text>
												</xsl:when>
												<xsl:when test="count(tia:IMKAD_ZakelijkRecht) = 1 or
																(count(tia:IMKAD_ZakelijkRecht) = count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst, $upper, $lower) = $registergoedAanduiding])) or
																tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'false']">
													<xsl:value-of select="$registergoedAanduiding"/>
													<xsl:text> </xsl:text>
												</xsl:when>
												<xsl:otherwise>
													<xsl:text>de Registergoederen </xsl:text>
													<xsl:for-each select="tia:IMKAD_ZakelijkRecht">
														<xsl:if test="count(../tia:IMKAD_ZakelijkRecht) = count(../tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true'])">
															<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
															<xsl:choose>
																<xsl:when test="position() = last() - 1">
																	<xsl:text> en </xsl:text>
																</xsl:when>
																<xsl:when test="position() != last()">
																	<xsl:text>, </xsl:text>
																</xsl:when>
															</xsl:choose>
														</xsl:if>
													</xsl:for-each>
													<xsl:text> </xsl:text>
												</xsl:otherwise>
											</xsl:choose>
										</xsl:if>
										<xsl:if test="$stukdeelKoop/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijstezamen']/tia:tekst = 'true'">
											<xsl:text>tezamen </xsl:text>
										</xsl:if>
										<xsl:text>is: </xsl:text>
										<xsl:choose>
											<xsl:when test="count(tia:IMKAD_ZakelijkRecht) = 1">
												<xsl:apply-templates select="tia:IMKAD_ZakelijkRecht" mode="do-choose-amount-for-variant-a">
													<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
													<xsl:with-param name="bedragKoopprijs" select="tia:IMKAD_ZakelijkRecht/tia:tia_BedragKoopprijs[1]"/>
												</xsl:apply-templates>
											</xsl:when>
											<xsl:when test="tia:IMKAD_ZakelijkRecht[tia:tia_BedragKoopprijs and tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst = 'true'
															and tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'true'
															and $stukdeelKoop/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsperregistergoed']/tia:tekst = 'false']">
												<xsl:for-each select="tia:IMKAD_ZakelijkRecht">
													<xsl:apply-templates select="." mode="do-bedragKoopprijs-amount">
														<xsl:with-param name="bedragKoopprijs" select="tia:tia_BedragKoopprijs[1]"/>
														<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
														<xsl:with-param name="standaardLevering" select="true"/>
													</xsl:apply-templates>
												</xsl:for-each>
											</xsl:when>
											<xsl:otherwise>
												<xsl:apply-templates select="tia:IMKAD_ZakelijkRecht[1]" mode="do-transactiesom-amount">
													<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
												</xsl:apply-templates>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:if test="$stukdeelKoop/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsperregistergoed']/tia:tekst = 'true' and
													tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true']">
											<xsl:text>, te weten:</xsl:text>
											<ul class="arrow">
												<xsl:for-each select="tia:IMKAD_ZakelijkRecht">
													<li class="arrow">
														<xsl:text>voor Registergoed </xsl:text>
														<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
														<xsl:text>: </xsl:text>
														<xsl:call-template name="amountText">
															<xsl:with-param name="amount" select="tia:tia_BedragKoopprijs/tia:som"/>
															<xsl:with-param name="valuta" select="tia:tia_BedragKoopprijs/tia:valuta"/>
														</xsl:call-template>
														<xsl:text> </xsl:text>
														<xsl:call-template name="amountNumber">
															<xsl:with-param name="amount" select="tia:tia_BedragKoopprijs/tia:som"/>
															<xsl:with-param name="valuta" select="tia:tia_BedragKoopprijs/tia:valuta"/>
														</xsl:call-template>
														<xsl:choose>
															<xsl:when test="position() = last()">
																<xsl:text>.</xsl:text>
															</xsl:when>
															<xsl:otherwise>
																<xsl:text>;</xsl:text>
															</xsl:otherwise>
														</xsl:choose>
													</li>
												</xsl:for-each>
											</ul>
										</xsl:if>
										<xsl:if test="$stukdeelKoop/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsperregistergoed']/tia:tekst != 'true'">
											<xsl:text>.</xsl:text>
										</xsl:if>
										<xsl:if test="$stukdeelKoop/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_geenroerendezaken']/tia:tekst = 'true'">
											<xsl:text> Er zijn geen roerende zaken meeverkocht.</xsl:text>
										</xsl:if>
									</p>
								</xsl:when>
								<!-- Variant 1.b Koopprijs 'met daarnaast een bedrag aan roerende zaken' -->
								<xsl:when test="count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'roerende zaken exclusief']) = count(tia:IMKAD_ZakelijkRecht)
											and $stukdeelKoop/tia:transactiesom">
									<p>
										<xsl:text>De koopprijs </xsl:text>
										<xsl:if test="tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true']">
											<xsl:text>van </xsl:text>
											<xsl:choose>
												<xsl:when test="count(tia:IMKAD_ZakelijkRecht) = 1 and tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true']">
													<xsl:text>het Registergoed </xsl:text>
													<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
													<xsl:text> </xsl:text>
												</xsl:when>
												<xsl:when test="count(tia:IMKAD_ZakelijkRecht) = 1 or
																(count(tia:IMKAD_ZakelijkRecht) = count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst, $upper, $lower) = $registergoedAanduiding])) or
																tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'false']">
													<xsl:value-of select="$registergoedAanduiding"/>
													<xsl:text> </xsl:text>
												</xsl:when>
												<xsl:otherwise>
													<xsl:text>de Registergoederen </xsl:text>
													<xsl:for-each select="tia:IMKAD_ZakelijkRecht">
														<xsl:if test="count(../tia:IMKAD_ZakelijkRecht) = count(../tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true'])">
															<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
															<xsl:choose>
																<xsl:when test="position() = last() - 1">
																	<xsl:text> en </xsl:text>
																</xsl:when>
																<xsl:when test="position() != last()">
																	<xsl:text>, </xsl:text>
																</xsl:when>
															</xsl:choose>
														</xsl:if>
													</xsl:for-each>
													<xsl:text> </xsl:text>
												</xsl:otherwise>
											</xsl:choose>
										</xsl:if>
										<xsl:text>is: </xsl:text>
										<xsl:choose>
											<xsl:when test="count(tia:IMKAD_ZakelijkRecht) = 1">
												<xsl:apply-templates select="tia:IMKAD_ZakelijkRecht" mode="do-choose-amount-for-variant-x">
													<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
													<xsl:with-param name="bedragKoopprijs" select="tia:IMKAD_ZakelijkRecht/tia:tia_BedragKoopprijs"/>
												</xsl:apply-templates>
											</xsl:when>
											<xsl:otherwise>
												<xsl:apply-templates select="tia:IMKAD_ZakelijkRecht[1]" mode="do-transactiesom-amount">
													<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
												</xsl:apply-templates>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:text>. </xsl:text>
										<xsl:value-of select="$partyText"/>
										<xsl:choose>
											<xsl:when test="contains(translate($partyText, $upper, $lower), 'en')">
												<xsl:text> hebben </xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text> heeft </xsl:text>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:text>aan de </xsl:text>
										<xsl:choose>
											<xsl:when test="translate($registergoederenTonenRoerendeZaken, $upper, $lower) = 'true' and count(tia:IMKAD_ZakelijkRecht) = count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederentonenroerendezaken']/tia:tekst, $upper, $lower) = 'true'])">
												<xsl:text>in </xsl:text>
												<xsl:if test="tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true']">
													<xsl:choose>
														<xsl:when test="count(tia:IMKAD_ZakelijkRecht) = 1 and tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true']">
															<xsl:text>het Registergoed </xsl:text>
															<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
															<xsl:text> </xsl:text>
														</xsl:when>
														<xsl:when test="count(tia:IMKAD_ZakelijkRecht) = 1 or
																		(count(tia:IMKAD_ZakelijkRecht) = count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst, $upper, $lower) = $registergoedAanduiding])) or
																		tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'false']">
															<xsl:value-of select="$registergoedAanduiding"/>
															<xsl:text> </xsl:text>
														</xsl:when>
														<xsl:otherwise>
															<xsl:text>de Registergoederen </xsl:text>
															<xsl:for-each select="tia:IMKAD_ZakelijkRecht">
																<xsl:if test="count(../tia:IMKAD_ZakelijkRecht) = count(../tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true'])">
																	<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
																	<xsl:choose>
																		<xsl:when test="position() = last() - 1">
																			<xsl:text> en </xsl:text>
																		</xsl:when>
																		<xsl:when test="position() != last()">
																			<xsl:text>, </xsl:text>
																		</xsl:when>
																	</xsl:choose>
																</xsl:if>
															</xsl:for-each>
															<xsl:text> </xsl:text>
														</xsl:otherwise>
													</xsl:choose>
												</xsl:if>
												<xsl:text>begrepen </xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text>meeverkochte </xsl:text>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:text>roerende zaken een waarde toegekend groot </xsl:text>
										<xsl:call-template name="amountText">
											<xsl:with-param name="amount" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'false']/tia:roerendezakenWaarde/tia:som"/>
											<xsl:with-param name="valuta" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'false']/tia:roerendezakenWaarde/tia:valuta"/>
										</xsl:call-template>
										<xsl:text> </xsl:text>
										<xsl:call-template name="amountNumber">
											<xsl:with-param name="amount" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'false']/tia:roerendezakenWaarde/tia:som"/>
											<xsl:with-param name="valuta" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'false']/tia:roerendezakenWaarde/tia:valuta"/>
										</xsl:call-template>
										<xsl:text>. De koopprijs </xsl:text>
										<xsl:if test="translate($registergoederenTonenRoerendeZaken, $upper, $lower) = 'true' and count(tia:IMKAD_ZakelijkRecht) = count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederentonenroerendezaken']/tia:tekst, $upper, $lower) = 'true'])">
											<xsl:if test="tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true']">
												<xsl:text>van </xsl:text>
												<xsl:choose>
													<xsl:when test="count(tia:IMKAD_ZakelijkRecht) = 1 and tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true']">
														<xsl:text>het Registergoed </xsl:text>
														<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
														<xsl:text> </xsl:text>
													</xsl:when>
													<xsl:when test="count(tia:IMKAD_ZakelijkRecht) = 1 or
																	(count(tia:IMKAD_ZakelijkRecht) = count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst, $upper, $lower) = $registergoedAanduiding])) or
																	tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'false']">
														<xsl:value-of select="$registergoedAanduiding"/>
														<xsl:text> </xsl:text>
													</xsl:when>
													<xsl:otherwise>
														<xsl:text>de Registergoederen </xsl:text>
														<xsl:for-each select="tia:IMKAD_ZakelijkRecht">
															<xsl:if test="count(../tia:IMKAD_ZakelijkRecht) = count(../tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true'])">
																<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
																<xsl:choose>
																	<xsl:when test="position() = last() - 1">
																		<xsl:text> en </xsl:text>
																	</xsl:when>
																	<xsl:when test="position() != last()">
																		<xsl:text>, </xsl:text>
																	</xsl:when>
																</xsl:choose>
															</xsl:if>
														</xsl:for-each>
														<xsl:text> </xsl:text>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:if>
										</xsl:if>
										<xsl:text>wordt met dit bedrag verhoogd. </xsl:text>
										<xsl:if test="$registergoederenOpsommingAangehecht = 'true' and count(tia:IMKAD_ZakelijkRecht) = count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederenopsommingaangehecht']/tia:tekst, $upper, $lower) = 'true'])">
											<xsl:text>Van welke roerende zaken een opsomming </xsl:text>
											<xsl:value-of select="$registergoederenOpsommingAangehechtTekst"/>
											<xsl:text> gehecht aan deze akte.</xsl:text>
										</xsl:if>
									</p>
								</xsl:when>
								<!-- Variant 1.c Koopprijs 'met inbegrip van een bedrag aan roerende zaken' -->
								<xsl:when test="count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'roerende zaken inclusief']) = count(tia:IMKAD_ZakelijkRecht)
											and $stukdeelKoop/tia:transactiesom">
									<p>
										<xsl:text>De koopprijs </xsl:text>
										<xsl:if test="tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true']">
											<xsl:text>van </xsl:text>
											<xsl:choose>
												<xsl:when test="count(tia:IMKAD_ZakelijkRecht) = 1 and tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true']">
													<xsl:text>het Registergoed </xsl:text>
													<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
													<xsl:text> </xsl:text>
												</xsl:when>
												<xsl:when test="count(tia:IMKAD_ZakelijkRecht) = 1
																or (count(tia:IMKAD_ZakelijkRecht) = count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst, $upper, $lower) = $registergoedAanduiding]))
																or tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'false']">
													<xsl:value-of select="$registergoedAanduiding"/>
													<xsl:text> </xsl:text>
												</xsl:when>
												<xsl:otherwise>
													<xsl:text>de Registergoederen </xsl:text>
													<xsl:for-each select="tia:IMKAD_ZakelijkRecht">
														<xsl:if test="count(../tia:IMKAD_ZakelijkRecht) = count(../tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true'])">
															<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
															<xsl:choose>
																<xsl:when test="position() = last() - 1">
																	<xsl:text> en </xsl:text>
																</xsl:when>
																<xsl:when test="position() != last()">
																	<xsl:text>, </xsl:text>
																</xsl:when>
															</xsl:choose>
														</xsl:if>
													</xsl:for-each>
													<xsl:text> </xsl:text>
												</xsl:otherwise>
											</xsl:choose>
										</xsl:if>
										<xsl:text>is: </xsl:text>
										<xsl:choose>
											<xsl:when test="count(tia:IMKAD_ZakelijkRecht) = 1">
												<xsl:apply-templates select="tia:IMKAD_ZakelijkRecht" mode="do-choose-amount-for-variant-x">
													<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
													<xsl:with-param name="bedragKoopprijs" select="tia:IMKAD_ZakelijkRecht/tia:tia_BedragKoopprijs"/>
												</xsl:apply-templates>
											</xsl:when>
											<xsl:otherwise>
												<xsl:apply-templates select="tia:IMKAD_ZakelijkRecht[1]" mode="do-transactiesom-amount">
													<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
												</xsl:apply-templates>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:text>. In </xsl:text>
										<xsl:value-of select="$koopprijsLidwoord"/>
										<xsl:text> koopprijs is een bedrag van </xsl:text>
										<xsl:call-template name="amountText">
											<xsl:with-param name="amount" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'true']/tia:roerendezakenWaarde/tia:som"/>
											<xsl:with-param name="valuta" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'true']/tia:roerendezakenWaarde/tia:valuta"/>
										</xsl:call-template>
										<xsl:text> </xsl:text>
										<xsl:call-template name="amountNumber">
											<xsl:with-param name="amount" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'true']/tia:roerendezakenWaarde/tia:som"/>
											<xsl:with-param name="valuta" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'true']/tia:roerendezakenWaarde/tia:valuta"/>
										</xsl:call-template>
										<xsl:text> voor roerende zaken begrepen. </xsl:text>
										<xsl:if test="$registergoederenOpsommingAangehecht = 'true' and count(tia:IMKAD_ZakelijkRecht) = count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederenopsommingaangehecht']/tia:tekst, $upper, $lower) = 'true'])">
											<xsl:text>Van welke roerende zaken een opsomming </xsl:text>
											<xsl:value-of select="$registergoederenOpsommingAangehechtTekst"/>
											<xsl:text> gehecht aan deze akte.</xsl:text>
										</xsl:if>
									</p>
								</xsl:when>
								<!-- Variant 1.d Koopprijs 'vrij op naam' -->
								<xsl:when test="count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'vrij op naam']) = count(tia:IMKAD_ZakelijkRecht)
											and $stukdeelKoop/tia:transactiesom">
									<p>
										<xsl:text>De koopprijs </xsl:text>
										<xsl:if test="tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true']">
											<xsl:text>van </xsl:text>
											<xsl:choose>
												<xsl:when test="count(tia:IMKAD_ZakelijkRecht) = 1 and tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true']">
													<xsl:text>het Registergoed </xsl:text>
													<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
													<xsl:text> </xsl:text>
												</xsl:when>
												<xsl:when test="count(tia:IMKAD_ZakelijkRecht) = 1 or
																(count(tia:IMKAD_ZakelijkRecht) = count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst, $upper, $lower) = $registergoedAanduiding])) or
																tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'false']">
													<xsl:value-of select="$registergoedAanduiding"/>
													<xsl:text> </xsl:text>
												</xsl:when>
												<xsl:otherwise>
													<xsl:text>de Registergoederen </xsl:text>
													<xsl:for-each select="tia:IMKAD_ZakelijkRecht">
														<xsl:if test="count(../tia:IMKAD_ZakelijkRecht) = count(../tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true'])">
															<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
															<xsl:choose>
																<xsl:when test="position() = last() - 1">
																	<xsl:text> en </xsl:text>
																</xsl:when>
																<xsl:when test="position() != last()">
																	<xsl:text>, </xsl:text>
																</xsl:when>
															</xsl:choose>
														</xsl:if>
													</xsl:for-each>
													<xsl:text> </xsl:text>
												</xsl:otherwise>
											</xsl:choose>
										</xsl:if>
										<xsl:text>is: </xsl:text>
										<xsl:choose>
											<xsl:when test="count(tia:IMKAD_ZakelijkRecht) = 1">
												<xsl:apply-templates select="tia:IMKAD_ZakelijkRecht" mode="do-choose-amount-for-variant-x">
													<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
													<xsl:with-param name="bedragKoopprijs" select="tia:IMKAD_ZakelijkRecht/tia:tia_BedragKoopprijs"/>
												</xsl:apply-templates>
											</xsl:when>
											<xsl:otherwise>
												<xsl:apply-templates select="tia:IMKAD_ZakelijkRecht[1]" mode="do-transactiesom-amount">
													<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
												</xsl:apply-templates>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:text>, inclusief een bedrag van </xsl:text>
										<xsl:call-template name="amountText">
											<xsl:with-param name="amount" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']/tia:omzetbelasting/tia:som"/>
											<xsl:with-param name="valuta" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']/tia:omzetbelasting/tia:valuta"/>
										</xsl:call-template>
										<xsl:text> </xsl:text>
										<xsl:call-template name="amountNumber">
											<xsl:with-param name="amount" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']/tia:omzetbelasting/tia:som"/>
											<xsl:with-param name="valuta" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']/tia:omzetbelasting/tia:valuta"/>
										</xsl:call-template>
										<xsl:text> aan omzetbelasting. De notari&#x00EB;le kosten, de daarover verschuldigde omzetbelasting en het kadastraal recht wegens de levering van </xsl:text>
										<xsl:if test="tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true']">
											<xsl:choose>
												<xsl:when test="count(tia:IMKAD_ZakelijkRecht) = 1 and tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true']">
													<xsl:text>het Registergoed </xsl:text>
													<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
													<xsl:text> </xsl:text>
												</xsl:when>
												<xsl:when test="count(tia:IMKAD_ZakelijkRecht) = 1 or
																(count(tia:IMKAD_ZakelijkRecht) = count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst, $upper, $lower) = $registergoedAanduiding])) or
																tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'false']">
													<xsl:value-of select="$registergoedAanduiding"/>
													<xsl:text> </xsl:text>
												</xsl:when>
												<xsl:otherwise>
													<xsl:text>de Registergoederen </xsl:text>
													<xsl:for-each select="tia:IMKAD_ZakelijkRecht">
														<xsl:if test="count(../tia:IMKAD_ZakelijkRecht) = count(../tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true'])">
															<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
															<xsl:choose>
																<xsl:when test="position() = last() - 1">
																	<xsl:text> en </xsl:text>
																</xsl:when>
																<xsl:when test="position() != last()">
																	<xsl:text>, </xsl:text>
																</xsl:when>
															</xsl:choose>
														</xsl:if>
													</xsl:for-each>
													<xsl:text> </xsl:text>
												</xsl:otherwise>
											</xsl:choose>
										</xsl:if>
										<xsl:text>zijn voor rekening van </xsl:text>
										<xsl:value-of select="$partyNameVariantVrijOpNaam"/>
										<xsl:text>.</xsl:text>
									</p>
								</xsl:when>
								<!-- Variant 1.e Koopprijs 'exclusief omzetbelasting' -->
								<xsl:when test="count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'exclusief omzetbelasting']) = count(tia:IMKAD_ZakelijkRecht)
											and $stukdeelKoop/tia:transactiesom">
									<p>
										<xsl:text>De koopprijs </xsl:text>
										<xsl:if test="tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true']">
											<xsl:text>van </xsl:text>
											<xsl:choose>
												<xsl:when test="count(tia:IMKAD_ZakelijkRecht) = 1 and tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true']">
													<xsl:text>het Registergoed </xsl:text>
													<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
													<xsl:text> </xsl:text>
												</xsl:when>
												<xsl:when test="count(tia:IMKAD_ZakelijkRecht) = 1 or
																(count(tia:IMKAD_ZakelijkRecht) = count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst, $upper, $lower) = $registergoedAanduiding])) or
																tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'false']">
													<xsl:value-of select="$registergoedAanduiding"/>
													<xsl:text> </xsl:text>
												</xsl:when>
												<xsl:otherwise>
													<xsl:text>de Registergoederen </xsl:text>
													<xsl:for-each select="tia:IMKAD_ZakelijkRecht">
														<xsl:if test="count(../tia:IMKAD_ZakelijkRecht) = count(../tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true'])">
															<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
															<xsl:choose>
																<xsl:when test="position() = last() - 1">
																	<xsl:text> en </xsl:text>
																</xsl:when>
																<xsl:when test="position() != last()">
																	<xsl:text>, </xsl:text>
																</xsl:when>
															</xsl:choose>
														</xsl:if>
													</xsl:for-each>
													<xsl:text> </xsl:text>
												</xsl:otherwise>
											</xsl:choose>
										</xsl:if>
										<xsl:text>is: </xsl:text>
										<xsl:choose>
											<xsl:when test="count(tia:IMKAD_ZakelijkRecht) = 1">
												<xsl:apply-templates select="tia:IMKAD_ZakelijkRecht" mode="do-choose-amount-for-variant-x">
													<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
													<xsl:with-param name="bedragKoopprijs" select="tia:IMKAD_ZakelijkRecht/tia:tia_BedragKoopprijs"/>
												</xsl:apply-templates>
											</xsl:when>
											<xsl:otherwise>
												<xsl:apply-templates select="tia:IMKAD_ZakelijkRecht[1]" mode="do-transactiesom-amount">
													<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
												</xsl:apply-templates>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:text>, te vermeerderen met een bedrag van </xsl:text>
										<xsl:call-template name="amountText">
											<xsl:with-param name="amount" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']/tia:omzetbelasting/tia:som"/>
											<xsl:with-param name="valuta" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']/tia:omzetbelasting/tia:valuta"/>
										</xsl:call-template>
										<xsl:text> </xsl:text>
										<xsl:call-template name="amountNumber">
											<xsl:with-param name="amount" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']/tia:omzetbelasting/tia:som"/>
											<xsl:with-param name="valuta" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']/tia:omzetbelasting/tia:valuta"/>
										</xsl:call-template>
										<xsl:text> aan omzetbelasting.</xsl:text>
									</p>
								</xsl:when>
								<!-- Variant 1.f Koopprijs 'koop aanneemsom' -->
								<xsl:when test="count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'koop aanneemsom']) = count(tia:IMKAD_ZakelijkRecht)
											and $stukdeelKoop/tia:transactiesom">
									<p>
										<xsl:text>De koopprijs </xsl:text>
										<xsl:if test="tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true']">
											<xsl:text>van </xsl:text>
											<xsl:choose>
												<xsl:when test="count(tia:IMKAD_ZakelijkRecht) = 1 and tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true']">
													<xsl:text>het Registergoed </xsl:text>
													<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
													<xsl:text> </xsl:text>
												</xsl:when>
												<xsl:when test="count(tia:IMKAD_ZakelijkRecht) = 1 or
																(count(tia:IMKAD_ZakelijkRecht) = count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst, $upper, $lower) = $registergoedAanduiding])) or
																tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'false']">
													<xsl:value-of select="$registergoedAanduiding"/>
													<xsl:text> </xsl:text>
												</xsl:when>
												<xsl:otherwise>
													<xsl:text>de Registergoederen </xsl:text>
													<xsl:for-each select="tia:IMKAD_ZakelijkRecht">
														<xsl:if test="count(../tia:IMKAD_ZakelijkRecht) = count(../tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true'])">
															<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
															<xsl:choose>
																<xsl:when test="position() = last() - 1">
																	<xsl:text> en </xsl:text>
																</xsl:when>
																<xsl:when test="position() != last()">
																	<xsl:text>, </xsl:text>
																</xsl:when>
															</xsl:choose>
														</xsl:if>
													</xsl:for-each>
													<xsl:text> </xsl:text>
												</xsl:otherwise>
											</xsl:choose>
										</xsl:if>
										<xsl:text>is: </xsl:text>
										<xsl:choose>
											<xsl:when test="count(tia:IMKAD_ZakelijkRecht) = 1">
												<xsl:apply-templates select="tia:IMKAD_ZakelijkRecht" mode="do-choose-amount-for-variant-x">
													<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
													<xsl:with-param name="bedragKoopprijs" select="tia:IMKAD_ZakelijkRecht/tia:tia_BedragKoopprijs"/>
												</xsl:apply-templates>
											</xsl:when>
											<xsl:otherwise>
												<xsl:apply-templates select="tia:IMKAD_ZakelijkRecht[1]" mode="do-transactiesom-amount">
													<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
												</xsl:apply-templates>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:text>, terwijl de aanneemsom bedraagt </xsl:text>
										<xsl:call-template name="amountText">
											<xsl:with-param name="amount" select="$stukdeelKoop/tia:koopprijsSpecificatie/tia:aanneemsom/tia:som"/>
											<xsl:with-param name="valuta" select="$stukdeelKoop/tia:koopprijsSpecificatie/tia:aanneemsom/tia:valuta"/>
										</xsl:call-template>
										<xsl:text> </xsl:text>
										<xsl:call-template name="amountNumber">
											<xsl:with-param name="amount" select="$stukdeelKoop/tia:koopprijsSpecificatie/tia:aanneemsom/tia:som"/>
											<xsl:with-param name="valuta" select="$stukdeelKoop/tia:koopprijsSpecificatie/tia:aanneemsom/tia:valuta"/>
										</xsl:call-template>
										<xsl:text>, derhalve in totaal </xsl:text>
										<xsl:call-template name="amountText">
											<xsl:with-param name="amount" select="$stukdeelKoop/tia:koopprijsSpecificatie/tia:koopprijsTotaal/tia:som"/>
											<xsl:with-param name="valuta" select="$stukdeelKoop/tia:koopprijsSpecificatie/tia:koopprijsTotaal/tia:valuta"/>
										</xsl:call-template>
										<xsl:text> </xsl:text>
										<xsl:call-template name="amountNumber">
											<xsl:with-param name="amount" select="$stukdeelKoop/tia:koopprijsSpecificatie/tia:koopprijsTotaal/tia:som"/>
											<xsl:with-param name="valuta" select="$stukdeelKoop/tia:koopprijsSpecificatie/tia:koopprijsTotaal/tia:valuta"/>
										</xsl:call-template>
										<xsl:text>, </xsl:text>
										<xsl:choose>
											<xsl:when test="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']">
												<xsl:text>inclusief een bedrag van </xsl:text>
												<xsl:call-template name="amountText">
													<xsl:with-param name="amount" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']/tia:omzetbelasting/tia:som"/>
													<xsl:with-param name="valuta" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']/tia:omzetbelasting/tia:valuta"/>
												</xsl:call-template>
												<xsl:text> </xsl:text>
												<xsl:call-template name="amountNumber">
													<xsl:with-param name="amount" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']/tia:omzetbelasting/tia:som"/>
													<xsl:with-param name="valuta" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']/tia:omzetbelasting/tia:valuta"/>
												</xsl:call-template>
												<xsl:text> aan omzetbelasting. </xsl:text>
											</xsl:when>
											<xsl:when test="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']">
												<xsl:text>te vermeerderen met een bedrag van </xsl:text>
												<xsl:call-template name="amountText">
													<xsl:with-param name="amount" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']/tia:omzetbelasting/tia:som"/>
													<xsl:with-param name="valuta" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']/tia:omzetbelasting/tia:valuta"/>
												</xsl:call-template>
												<xsl:text> </xsl:text>
												<xsl:call-template name="amountNumber">
													<xsl:with-param name="amount" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']/tia:omzetbelasting/tia:som"/>
													<xsl:with-param name="valuta" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']/tia:omzetbelasting/tia:valuta"/>
												</xsl:call-template>
												<xsl:text> aan omzetbelasting. </xsl:text>
											</xsl:when>
										</xsl:choose>
										<xsl:if test="translate($stukdeelKoop/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopaanneemsomvoldaan']/tia:tekst, $upper, $lower) = 'true'">
											<xsl:text>Het per heden krachtens de koop</xsl:text>
											<xsl:if test="translate($stukdeelKoop/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aannemingsovereenkomst']/tia:tekst, $upper, $lower) = 'true'">
												<xsl:text>-/aannemingsovereenkomst</xsl:text>
											</xsl:if>
											<xsl:text> door koper verschuldigde bedrag ad </xsl:text>
											<xsl:choose>
												<xsl:when test="count(tia:IMKAD_ZakelijkRecht) = 1">
													<xsl:apply-templates select="tia:IMKAD_ZakelijkRecht" mode="do-choose-amount-for-variant-x">
														<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
														<xsl:with-param name="bedragKoopprijs" select="tia:IMKAD_ZakelijkRecht/tia:tia_BedragKoopprijs"/>
													</xsl:apply-templates>
												</xsl:when>
												<xsl:when test="tia:IMKAD_ZakelijkRecht[tia:tia_BedragKoopprijs and tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst = 'true'
																and tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'true']">
													<xsl:for-each select="tia:IMKAD_ZakelijkRecht">
														<xsl:apply-templates select="." mode="do-bedragKoopprijs-amount">
															<xsl:with-param name="bedragKoopprijs" select="tia:tia_BedragKoopprijs"/>
															<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
														</xsl:apply-templates>
													</xsl:for-each>
												</xsl:when>
												<xsl:otherwise>
													<xsl:apply-templates select="tia:IMKAD_ZakelijkRecht[1]" mode="do-transactiesom-amount">
														<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
													</xsl:apply-templates>
												</xsl:otherwise>
											</xsl:choose>
											<xsl:text>, zijnde de koopprijs van </xsl:text>
											<xsl:if test="tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true']">
												<xsl:choose>
													<xsl:when test="count(tia:IMKAD_ZakelijkRecht) = 1 and tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true']">
														<xsl:text>het Registergoed </xsl:text>
														<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
														<xsl:text>, </xsl:text>
													</xsl:when>
													<xsl:when test="count(tia:IMKAD_ZakelijkRecht) = 1 or
																	(count(tia:IMKAD_ZakelijkRecht) = count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst, $upper, $lower) = $registergoedAanduiding])) or
																	tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'false']">
														<xsl:value-of select="$registergoedAanduiding"/>
														<xsl:text>, </xsl:text>
													</xsl:when>
													<xsl:otherwise>
														<xsl:text>de Registergoederen </xsl:text>
														<xsl:for-each select="tia:IMKAD_ZakelijkRecht">
															<xsl:if test="count(../tia:IMKAD_ZakelijkRecht) = count(../tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true'])">
																<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
																<xsl:choose>
																	<xsl:when test="position() = last() - 1">
																		<xsl:text> en </xsl:text>
																	</xsl:when>
																	<xsl:when test="position() != last()">
																		<xsl:text>, </xsl:text>
																	</xsl:when>
																</xsl:choose>
															</xsl:if>
														</xsl:for-each>
														<xsl:text>, </xsl:text>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:if>
											<xsl:text>de vervallen termijnen van de aanneming en de overeenkomstig de koop</xsl:text>
											<xsl:if test="translate($stukdeelKoop/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aannemingsovereenkomst']/tia:tekst, $upper, $lower) = 'true'">
												<xsl:text>-/aannemingsovereenkomst</xsl:text>
											</xsl:if>
											<xsl:text> verschuldigde rente, een en ander inclusief omzetbelasting, is door </xsl:text>
											<xsl:value-of select="$partyNameVariantKoopAanneemsom"/>
											<xsl:text> aan de notaris voldaan.</xsl:text>
										</xsl:if>
									</p>
								</xsl:when>
							</xsl:choose>
						</xsl:when>
						<xsl:otherwise>
							<xsl:for-each select="tia:IMKAD_ZakelijkRecht">
								<xsl:choose>
									<!-- Variant 1.a Koopprijs 'kaal' -->
									<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'kaal'">
										<p>
											<xsl:text>De koopprijs </xsl:text>
											<xsl:if test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
												<xsl:text>van </xsl:text>
												<xsl:choose>
													<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true'">
														<xsl:text>het Registergoed </xsl:text>
														<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
														<xsl:text> </xsl:text>
													</xsl:when>
													<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
														<xsl:value-of select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst"/>
														<xsl:text> </xsl:text>
													</xsl:when>
												</xsl:choose>
											</xsl:if>
											<xsl:if test="$stukdeelKoop/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijstezamen']/tia:tekst = 'true'">
												<xsl:text>tezamen </xsl:text>
											</xsl:if>
											<xsl:text>is: </xsl:text>
											<xsl:apply-templates select="." mode="do-choose-amount-for-variant-a">
												<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
												<xsl:with-param name="bedragKoopprijs" select="tia:tia_BedragKoopprijs"/>
											</xsl:apply-templates>
											<xsl:text>.</xsl:text>
											<xsl:if test="$stukdeelKoop/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_geenroerendezaken']/tia:tekst = 'true'">
												<xsl:text> Er zijn geen roerende zaken meeverkocht.</xsl:text>
											</xsl:if>
										</p>
									</xsl:when>
									<!-- Variant 1.b Koopprijs 'met daarnaast een bedrag aan roerende zaken' -->
									<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'roerende zaken exclusief'">
										<p>
											<xsl:text>De koopprijs </xsl:text>
											<xsl:if test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
												<xsl:text>van </xsl:text>
												<xsl:choose>
													<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true'">
														<xsl:text>het Registergoed </xsl:text>
														<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
														<xsl:text> </xsl:text>
													</xsl:when>
													<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
														<xsl:value-of select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst"/>
														<xsl:text> </xsl:text>
													</xsl:when>
												</xsl:choose>
											</xsl:if>
											<xsl:text>is: </xsl:text>
											<xsl:apply-templates select="." mode="do-choose-amount-for-variant-x">
												<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
												<xsl:with-param name="bedragKoopprijs" select="tia:tia_BedragKoopprijs"/>
											</xsl:apply-templates>
											<xsl:text>.</xsl:text>
											<xsl:value-of select="$partyText"/>
											<xsl:choose>
												<xsl:when test="contains(translate($partyText, $upper, $lower), 'en')">
													<xsl:text> hebben </xsl:text>
												</xsl:when>
												<xsl:otherwise>
													<xsl:text> heeft </xsl:text>
												</xsl:otherwise>
											</xsl:choose>
											<xsl:text>aan de </xsl:text>
											<xsl:choose>
												<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederentonenroerendezaken']/tia:tekst, $upper, $lower) = 'true'">
													<xsl:text>in </xsl:text>
													<xsl:if test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
														<xsl:choose>
															<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true'">
																<xsl:text>het Registergoed </xsl:text>
																<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
																<xsl:text> </xsl:text>
															</xsl:when>
															<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
																<xsl:value-of select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst"/>
																<xsl:text> </xsl:text>
															</xsl:when>
														</xsl:choose>
													</xsl:if>
													<xsl:text> begrepen </xsl:text>
												</xsl:when>
												<xsl:otherwise>
													<xsl:text>meeverkochte </xsl:text>
												</xsl:otherwise>
											</xsl:choose>
											<xsl:text>roerende zaken een waarde toegekend groot </xsl:text>
											<xsl:call-template name="amountText">
												<xsl:with-param name="amount" select="tia:tia_KoopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'false']/tia:roerendezakenWaarde/tia:som"/>
												<xsl:with-param name="valuta" select="tia:tia_KoopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'false']/tia:roerendezakenWaarde/tia:valuta"/>
											</xsl:call-template>
											<xsl:text> </xsl:text>
											<xsl:call-template name="amountNumber">
												<xsl:with-param name="amount" select="tia:tia_KoopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'false']/tia:roerendezakenWaarde/tia:som"/>
												<xsl:with-param name="valuta" select="tia:tia_KoopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'false']/tia:roerendezakenWaarde/tia:valuta"/>
											</xsl:call-template>
											<xsl:text>. De koopprijs </xsl:text>
											<xsl:if test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederentonenroerendezaken']/tia:tekst, $upper, $lower) = 'true'">
												<xsl:if test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
													<xsl:text>van </xsl:text>
													<xsl:choose>
														<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true'">
															<xsl:text>het Registergoed </xsl:text>
															<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
															<xsl:text> </xsl:text>
														</xsl:when>
														<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
															<xsl:value-of select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst"/>
															<xsl:text> </xsl:text>
														</xsl:when>
													</xsl:choose>
												</xsl:if>
											</xsl:if>
											<xsl:text>wordt met dit bedrag verhoogd. </xsl:text>
											<xsl:if test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederenopsommingaangehecht']/tia:tekst, $upper, $lower) = 'true'">
												<xsl:text>Van welke roerende zaken een opsomming </xsl:text>
												<xsl:if test="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederenopsommingaangehechttekst']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
														translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederenopsommingaangehechttekst']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
														translate(normalize-space(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederenopsommingaangehechttekst']/tia:tekst), $upper, $lower)]), $upper, $lower)]">
													<xsl:value-of select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederenopsommingaangehechttekst']/tia:tekst"/>
												</xsl:if>
												<xsl:text> gehecht aan deze akte.</xsl:text>
											</xsl:if>
										</p>
									</xsl:when>
									<!-- Variant 1.c Koopprijs 'met inbegrip van een bedrag aan roerende zaken' -->
									<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'roerende zaken inclusief'">
										<p>
											<xsl:text>De koopprijs </xsl:text>
											<xsl:if test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
												<xsl:text>van </xsl:text>
												<xsl:choose>
													<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true'">
														<xsl:text>het Registergoed </xsl:text>
														<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
														<xsl:text> </xsl:text>
													</xsl:when>
													<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
														<xsl:value-of select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst"/>
														<xsl:text> </xsl:text>
													</xsl:when>
												</xsl:choose>
											</xsl:if>
											<xsl:text>is: </xsl:text>
											<xsl:apply-templates select="." mode="do-choose-amount-for-variant-x">
												<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
												<xsl:with-param name="bedragKoopprijs" select="tia:tia_BedragKoopprijs"/>
											</xsl:apply-templates>
											<xsl:text>. In </xsl:text>
											<xsl:value-of select="$koopprijsLidwoord"/>
											<xsl:text> koopprijs is een bedrag van </xsl:text>
											<xsl:call-template name="amountText">
												<xsl:with-param name="amount" select="tia:tia_KoopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'true']/tia:roerendezakenWaarde/tia:som"/>
												<xsl:with-param name="valuta" select="tia:tia_KoopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'true']/tia:roerendezakenWaarde/tia:valuta"/>
											</xsl:call-template>
											<xsl:text> </xsl:text>
											<xsl:call-template name="amountNumber">
												<xsl:with-param name="amount" select="tia:tia_KoopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'true']/tia:roerendezakenWaarde/tia:som"/>
												<xsl:with-param name="valuta" select="tia:tia_KoopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'true']/tia:roerendezakenWaarde/tia:valuta"/>
											</xsl:call-template>
											<xsl:text> voor roerende zaken begrepen. </xsl:text>
											<xsl:if test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederenopsommingaangehecht']/tia:tekst, $upper, $lower) = 'true'">
												<xsl:text>Van welke roerende zaken een opsomming </xsl:text>
												<xsl:if test="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederenopsommingaangehechttekst']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
														translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederenopsommingaangehechttekst']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
														translate(normalize-space(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederenopsommingaangehechttekst']/tia:tekst), $upper, $lower)]), $upper, $lower)]">
													<xsl:value-of select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederenopsommingaangehechttekst']/tia:tekst"/>
												</xsl:if>
												<xsl:text> gehecht aan deze akte.</xsl:text>
											</xsl:if>
										</p>
									</xsl:when>
									<!-- Variant 1.d Koopprijs 'vrij op naam' -->
									<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'vrij op naam'">
										<p>
											<xsl:text>De koopprijs </xsl:text>
											<xsl:if test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
												<xsl:text>van </xsl:text>
												<xsl:choose>
													<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true'">
														<xsl:text>het Registergoed </xsl:text>
														<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
														<xsl:text> </xsl:text>
													</xsl:when>
													<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
														<xsl:value-of select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst"/>
														<xsl:text> </xsl:text>
													</xsl:when>
												</xsl:choose>
											</xsl:if>
											<xsl:text>is: </xsl:text>
											<xsl:apply-templates select="." mode="do-choose-amount-for-variant-x">
												<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
												<xsl:with-param name="bedragKoopprijs" select="tia:tia_BedragKoopprijs"/>
											</xsl:apply-templates>
											<xsl:text>, inclusief een bedrag van </xsl:text>
											<xsl:call-template name="amountText">
												<xsl:with-param name="amount" select="tia:tia_KoopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']/tia:omzetbelasting/tia:som"/>
												<xsl:with-param name="valuta" select="tia:tia_KoopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']/tia:omzetbelasting/tia:valuta"/>
											</xsl:call-template>
											<xsl:text> </xsl:text>
											<xsl:call-template name="amountNumber">
												<xsl:with-param name="amount" select="tia:tia_KoopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']/tia:omzetbelasting/tia:som"/>
												<xsl:with-param name="valuta" select="tia:tia_KoopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']/tia:omzetbelasting/tia:valuta"/>
											</xsl:call-template>
											<xsl:text> aan omzetbelasting. De notari&#x00EB;le kosten, de daarover verschuldigde omzetbelasting en het kadastraal recht wegens de levering van </xsl:text>
											<xsl:if test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
												<xsl:choose>
													<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true'">
														<xsl:text>het Registergoed </xsl:text>
														<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
														<xsl:text> </xsl:text>
													</xsl:when>
													<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
														<xsl:value-of select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst"/>
														<xsl:text> </xsl:text>
													</xsl:when>
												</xsl:choose>
											</xsl:if>
											<xsl:text>zijn voor rekening van </xsl:text>
											<xsl:value-of select="$partyNameVariantVrijOpNaam"/>
											<xsl:text>.</xsl:text>
										</p>
									</xsl:when>
									<!-- Variant 1.e Koopprijs 'exclusief omzetbelasting' -->
									<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'exclusief omzetbelasting'">
										<p>
											<xsl:text>De koopprijs </xsl:text>
											<xsl:if test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
												<xsl:text>van </xsl:text>
												<xsl:choose>
													<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true'">
														<xsl:text>het Registergoed </xsl:text>
														<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
														<xsl:text> </xsl:text>
													</xsl:when>
													<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
														<xsl:value-of select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst"/>
														<xsl:text> </xsl:text>
													</xsl:when>
												</xsl:choose>
											</xsl:if>
											<xsl:text>is: </xsl:text>
											<xsl:apply-templates select="." mode="do-choose-amount-for-variant-x">
												<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
												<xsl:with-param name="bedragKoopprijs" select="tia:tia_BedragKoopprijs"/>
											</xsl:apply-templates>
											<xsl:text>, te vermeerderen met een bedrag van </xsl:text>
											<xsl:call-template name="amountText">
												<xsl:with-param name="amount" select="tia:tia_KoopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']/tia:omzetbelasting/tia:som"/>
												<xsl:with-param name="valuta" select="tia:tia_KoopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']/tia:omzetbelasting/tia:valuta"/>
											</xsl:call-template>
											<xsl:text> </xsl:text>
											<xsl:call-template name="amountNumber">
												<xsl:with-param name="amount" select="tia:tia_KoopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']/tia:omzetbelasting/tia:som"/>
												<xsl:with-param name="valuta" select="tia:tia_KoopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']/tia:omzetbelasting/tia:valuta"/>
											</xsl:call-template>
											<xsl:text> aan omzetbelasting.</xsl:text>
										</p>
									</xsl:when>
									<!-- Variant 1.f Koopprijs 'koop aanneemsom' -->
									<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'koop aanneemsom'">
										<p>
											<xsl:text>De koopprijs </xsl:text>
											<xsl:if test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
												<xsl:text>van </xsl:text>
												<xsl:choose>
													<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true'">
														<xsl:text>het Registergoed </xsl:text>
														<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
														<xsl:text> </xsl:text>
													</xsl:when>
													<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
														<xsl:value-of select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst"/>
														<xsl:text> </xsl:text>
													</xsl:when>
												</xsl:choose>
											</xsl:if>
											<xsl:text>is: </xsl:text>
											<xsl:apply-templates select="." mode="do-choose-amount-for-variant-x">
												<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
												<xsl:with-param name="bedragKoopprijs" select="tia:tia_BedragKoopprijs"/>
											</xsl:apply-templates>
											<xsl:text>, terwijl de aanneemsom bedraagt </xsl:text>
											<xsl:call-template name="amountText">
												<xsl:with-param name="amount" select="tia:tia_KoopprijsSpecificatie/tia:aanneemsom/tia:som"/>
												<xsl:with-param name="valuta" select="tia:tia_KoopprijsSpecificatie/tia:aanneemsom/tia:valuta"/>
											</xsl:call-template>
											<xsl:text> </xsl:text>
											<xsl:call-template name="amountNumber">
												<xsl:with-param name="amount" select="tia:tia_KoopprijsSpecificatie/tia:aanneemsom/tia:som"/>
												<xsl:with-param name="valuta" select="tia:tia_KoopprijsSpecificatie/tia:aanneemsom/tia:valuta"/>
											</xsl:call-template>
											<xsl:text>, derhalve in totaal </xsl:text>
											<xsl:call-template name="amountText">
												<xsl:with-param name="amount" select="tia:tia_KoopprijsSpecificatie/tia:koopprijsTotaal/tia:som"/>
												<xsl:with-param name="valuta" select="tia:tia_KoopprijsSpecificatie/tia:koopprijsTotaal/tia:valuta"/>
											</xsl:call-template>
											<xsl:text> </xsl:text>
											<xsl:call-template name="amountNumber">
												<xsl:with-param name="amount" select="tia:tia_KoopprijsSpecificatie/tia:koopprijsTotaal/tia:som"/>
												<xsl:with-param name="valuta" select="tia:tia_KoopprijsSpecificatie/tia:koopprijsTotaal/tia:valuta"/>
											</xsl:call-template>
											<xsl:text>, </xsl:text>
											<xsl:choose>
												<xsl:when test="tia:tia_KoopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']">
													<xsl:text>inclusief een bedrag van </xsl:text>
													<xsl:call-template name="amountText">
														<xsl:with-param name="amount" select="tia:tia_KoopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']/tia:omzetbelasting/tia:som"/>
														<xsl:with-param name="valuta" select="tia:tia_KoopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']/tia:omzetbelasting/tia:valuta"/>
													</xsl:call-template>
													<xsl:text> </xsl:text>
													<xsl:call-template name="amountNumber">
														<xsl:with-param name="amount" select="tia:tia_KoopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']/tia:omzetbelasting/tia:som"/>
														<xsl:with-param name="valuta" select="tia:tia_KoopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']/tia:omzetbelasting/tia:valuta"/>
													</xsl:call-template>
													<xsl:text> aan omzetbelasting. </xsl:text>
												</xsl:when>
												<xsl:when test="tia:tia_KoopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']">
													<xsl:text>te vermeerderen met een bedrag van </xsl:text>
													<xsl:call-template name="amountText">
														<xsl:with-param name="amount" select="tia:tia_KoopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']/tia:omzetbelasting/tia:som"/>
														<xsl:with-param name="valuta" select="tia:tia_KoopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']/tia:omzetbelasting/tia:valuta"/>
													</xsl:call-template>
													<xsl:text> </xsl:text>
													<xsl:call-template name="amountNumber">
														<xsl:with-param name="amount" select="tia:tia_KoopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']/tia:omzetbelasting/tia:som"/>
														<xsl:with-param name="valuta" select="tia:tia_KoopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']/tia:omzetbelasting/tia:valuta"/>
													</xsl:call-template>
													<xsl:text> aan omzetbelasting. </xsl:text>
												</xsl:when>
											</xsl:choose>
											<xsl:if test="translate($stukdeelKoop/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopaanneemsomvoldaan']/tia:tekst, $upper, $lower) = 'true'">
												<xsl:text>Het per heden krachtens de koop</xsl:text>
												<xsl:if test="translate($stukdeelKoop/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aannemingsovereenkomst']/tia:tekst, $upper, $lower) = 'true'">
													<xsl:text>-/aannemingsovereenkomst</xsl:text>
												</xsl:if>
												<xsl:text> door koper verschuldigde bedrag ad </xsl:text>
												<xsl:apply-templates select="." mode="do-choose-amount-for-variant-x">
													<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
													<xsl:with-param name="bedragKoopprijs" select="tia:tia_BedragKoopprijs"/>
												</xsl:apply-templates>
												<xsl:text>, zijnde de koopprijs van </xsl:text>
												<xsl:if test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
													<xsl:choose>
														<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true'">
															<xsl:text>het Registergoed </xsl:text>
															<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
															<xsl:text> </xsl:text>
														</xsl:when>
														<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
															<xsl:value-of select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst"/>
															<xsl:text> </xsl:text>
														</xsl:when>
													</xsl:choose>
												</xsl:if>
												<xsl:text>de vervallen termijnen van de aanneming en de overeenkomstig de koop</xsl:text>
												<xsl:if test="translate($stukdeelKoop/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aannemingsovereenkomst']/tia:tekst, $upper, $lower) = 'true'">
													<xsl:text>-/aannemingsovereenkomst</xsl:text>
												</xsl:if>
												<xsl:text> verschuldigde rente, een en ander inclusief omzetbelasting, is door </xsl:text>
												<xsl:value-of select="$partyNameVariantKoopAanneemsom"/>
												<xsl:text> aan de notaris voldaan.</xsl:text>
											</xsl:if>
										</p>
									</xsl:when>
								</xsl:choose>
							</xsl:for-each>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:if test="position() != last()">
						<br/>
					</xsl:if>
				</xsl:for-each>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="tia:StukdeelLevering" mode="do-purchase-price-twee-levering-group">
		<xsl:param name="stukdeelLeveringNext" select="self::node()[false()]"/>
		<xsl:param name="stukdeelKoop" select="self::node()[false()]"/>
		<xsl:param name="registergoedAanduiding" select="''"/>
		<xsl:param name="partyNameVariantVrijOpNaam" select="''"/>
		<xsl:param name="partyNameVariantKoopAanneemsom" select="''"/>
		<xsl:param name="tweeLeveringPartyText" select="''"/>
		<xsl:param name="registergoederenTonenRoerendeZaken" select="''"/>
		<xsl:param name="registergoederenOpsommingAangehecht" select="''"/>
		<xsl:param name="registergoederenOpsommingAangehechtTekst" select="''"/>
		<xsl:param name="koopprijsLidwoord" select="''"/>
		<xsl:choose>
			<!-- Variant 2.a Koopprijs 'kaal' -->
			<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'kaal']) = count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht)
						and $stukdeelKoop/tia:transactiesom">
				<p>
					<xsl:text>De koopprijs </xsl:text>
					<xsl:if test="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true']">
						<xsl:text>van </xsl:text>
						<xsl:choose>
							<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) = 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'false'">
								<xsl:value-of select="$registergoedAanduiding"/>
								<xsl:text> </xsl:text>
							</xsl:when>
							<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) = 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'true'">
								<xsl:text>het Registergoed </xsl:text>
								<xsl:value-of select="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
								<xsl:text> </xsl:text>
							</xsl:when>
							<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) > 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'false'">
								<xsl:value-of select="$registergoedAanduiding"/>
								<xsl:text> </xsl:text>
							</xsl:when>
							<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) > 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'true'">
								<xsl:text> de Registergoederen </xsl:text>
								<xsl:for-each select="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht">
									<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
									<xsl:choose>
										<xsl:when test="position() = last() - 1">
											<xsl:text> en </xsl:text>
										</xsl:when>
										<xsl:when test="position() != last()">
											<xsl:text>, </xsl:text>
										</xsl:when>
									</xsl:choose>
								</xsl:for-each>
								<xsl:text> </xsl:text>
							</xsl:when>
						</xsl:choose>
					</xsl:if>
					<xsl:text>die tussen </xsl:text>
					<xsl:value-of select="$partyNameVariantVrijOpNaam"/>
					<xsl:text> en </xsl:text>
					<xsl:value-of select="$partyNameVariantKoopAanneemsom"/>
					<xsl:text> is overeengekomen, bedraagt: </xsl:text>
					<xsl:choose>
						<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) = 1">
							<xsl:apply-templates select="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht" mode="do-choose-amount-for-variant-a">
								<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
								<xsl:with-param name="bedragKoopprijs" select="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_BedragKoopprijs[1]"/>
							</xsl:apply-templates>
						</xsl:when>
						<xsl:when test="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht[tia:tia_BedragKoopprijs and tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst = 'true'
										and tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'true']">
							<xsl:for-each select="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht">
								<xsl:apply-templates select="." mode="do-bedragKoopprijs-amount">
									<xsl:with-param name="bedragKoopprijs" select="tia:tia_BedragKoopprijs[1]"/>
									<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
								</xsl:apply-templates>
							</xsl:for-each>
						</xsl:when>
						<xsl:otherwise>
							<xsl:apply-templates select="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht[1]" mode="do-transactiesom-amount">
								<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
							</xsl:apply-templates>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:text>.</xsl:text>
					<br/>
				</p>
			</xsl:when>
			<!-- Variant 2.b Koopprijs 'met daarnaast een bedrag aan roerende zaken' -->
			<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'roerende zaken exclusief']) = count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht)
						and $stukdeelKoop/tia:transactiesom">
				<p>
					<xsl:text>De koopprijs </xsl:text>
					<xsl:if test="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true']">
						<xsl:text>van </xsl:text>
						<xsl:choose>
							<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) = 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'false'">
								<xsl:value-of select="$registergoedAanduiding"/>
								<xsl:text> </xsl:text>
							</xsl:when>
							<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) = 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'true'">
								<xsl:text>het Registergoed </xsl:text>
								<xsl:value-of select="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
								<xsl:text> </xsl:text>
							</xsl:when>
							<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) > 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'false'">
								<xsl:value-of select="$registergoedAanduiding"/>
								<xsl:text> </xsl:text>
							</xsl:when>
							<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) > 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'true'">
								<xsl:text> de Registergoederen </xsl:text>
								<xsl:for-each select="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht">
									<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
									<xsl:choose>
										<xsl:when test="position() = last() - 1">
											<xsl:text> en </xsl:text>
										</xsl:when>
										<xsl:when test="position() != last()">
											<xsl:text>, </xsl:text>
										</xsl:when>
									</xsl:choose>
								</xsl:for-each>
								<xsl:text> </xsl:text>
							</xsl:when>
						</xsl:choose>
					</xsl:if>
					<xsl:text>die tussen </xsl:text>
					<xsl:value-of select="$partyNameVariantVrijOpNaam"/>
					<xsl:text> en </xsl:text>
					<xsl:value-of select="$partyNameVariantKoopAanneemsom"/>
					<xsl:text> is overeengekomen, bedraagt: </xsl:text>
					<xsl:choose>
						<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) = 1">
							<xsl:apply-templates select="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht" mode="do-choose-amount-for-variant-x">
								<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
								<xsl:with-param name="bedragKoopprijs" select="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_BedragKoopprijs"/>
							</xsl:apply-templates>
						</xsl:when>
						<xsl:otherwise>
							<xsl:apply-templates select="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht[1]" mode="do-transactiesom-amount">
								<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
							</xsl:apply-templates>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:text>. </xsl:text>
					<xsl:value-of select="$tweeLeveringPartyText"/>
					<xsl:choose>
						<xsl:when test="contains(translate($tweeLeveringPartyText, $upper, $lower), 'en')">
							<xsl:text> hebben </xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text> heeft </xsl:text>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:text>aan de </xsl:text>
					<xsl:choose>
						<xsl:when test="translate($registergoederenTonenRoerendeZaken, $upper, $lower) = 'true'">
							<xsl:text>in </xsl:text>
							<xsl:if test="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true']">
								<xsl:choose>
									<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) = 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'false'">
										<xsl:value-of select="$registergoedAanduiding"/>
										<xsl:text> </xsl:text>
									</xsl:when>
									<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) = 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'true'">
										<xsl:text>het Registergoed </xsl:text>
										<xsl:value-of select="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
										<xsl:text> </xsl:text>
									</xsl:when>
									<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) > 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'false'">
										<xsl:value-of select="$registergoedAanduiding"/>
										<xsl:text> </xsl:text>
									</xsl:when>
									<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) > 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'true'">
										<xsl:text> de Registergoederen </xsl:text>
										<xsl:for-each select="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht">
											<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
											<xsl:choose>
												<xsl:when test="position() = last() - 1">
													<xsl:text> en </xsl:text>
												</xsl:when>
												<xsl:when test="position() != last()">
													<xsl:text>, </xsl:text>
												</xsl:when>
											</xsl:choose>
										</xsl:for-each>
										<xsl:text> </xsl:text>
									</xsl:when>
								</xsl:choose>
							</xsl:if>
							<xsl:text>begrepen </xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>meeverkochte </xsl:text>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:text>roerende zaken een waarde toegekend groot </xsl:text>
					<xsl:call-template name="amountText">
						<xsl:with-param name="amount" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'false']/tia:roerendezakenWaarde/tia:som"/>
						<xsl:with-param name="valuta" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'false']/tia:roerendezakenWaarde/tia:valuta"/>
					</xsl:call-template>
					<xsl:text> </xsl:text>
					<xsl:call-template name="amountNumber">
						<xsl:with-param name="amount" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'false']/tia:roerendezakenWaarde/tia:som"/>
						<xsl:with-param name="valuta" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'false']/tia:roerendezakenWaarde/tia:valuta"/>
					</xsl:call-template>
					<xsl:text>. De koopprijs </xsl:text>
					<xsl:if test="translate($registergoederenTonenRoerendeZaken, $upper, $lower) = 'true' and count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) = count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederentonenroerendezaken']/tia:tekst, $upper, $lower) = 'true'])">
						<xsl:text>van </xsl:text>
						<xsl:if test="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true']">
							<xsl:choose>
								<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) = 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'false'">
									<xsl:value-of select="$registergoedAanduiding"/>
									<xsl:text> </xsl:text>
								</xsl:when>
								<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) = 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'true'">
									<xsl:text>het Registergoed </xsl:text>
									<xsl:value-of select="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
									<xsl:text> </xsl:text>
								</xsl:when>
								<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) > 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'false'">
									<xsl:value-of select="$registergoedAanduiding"/>
									<xsl:text> </xsl:text>
								</xsl:when>
								<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) > 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'true'">
									<xsl:text> de Registergoederen </xsl:text>
									<xsl:for-each select="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht">
										<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
										<xsl:choose>
											<xsl:when test="position() = last() - 1">
												<xsl:text> en </xsl:text>
											</xsl:when>
											<xsl:when test="position() != last()">
												<xsl:text>, </xsl:text>
											</xsl:when>
										</xsl:choose>
									</xsl:for-each>
									<xsl:text> </xsl:text>
								</xsl:when>
							</xsl:choose>
						</xsl:if>
					</xsl:if>
					<xsl:text>wordt met dit bedrag verhoogd. </xsl:text>
					<xsl:if test="$registergoederenOpsommingAangehecht = 'true' and count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) = count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederenopsommingaangehecht']/tia:tekst, $upper, $lower) = 'true'])">
						<xsl:text>Van welke roerende zaken een opsomming </xsl:text>
						<xsl:value-of select="$registergoederenOpsommingAangehechtTekst"/>
						<xsl:text> gehecht aan deze akte.</xsl:text>
					</xsl:if>
					<br/>
				</p>
			</xsl:when>
			<!-- Variant 2.c Koopprijs 'met inbegrip van een bedrag aan roerende zaken' -->
			<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'roerende zaken inclusief']) = count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht)
						and $stukdeelKoop/tia:transactiesom">
				<p>
					<xsl:text>De koopprijs </xsl:text>
					<xsl:if test="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true']">
						<xsl:text>van </xsl:text>
						<xsl:choose>
							<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) = 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'false'">
								<xsl:value-of select="$registergoedAanduiding"/>
								<xsl:text> </xsl:text>
							</xsl:when>
							<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) = 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'true'">
								<xsl:text>het Registergoed </xsl:text>
								<xsl:value-of select="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
								<xsl:text> </xsl:text>
							</xsl:when>
							<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) > 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'false'">
								<xsl:value-of select="$registergoedAanduiding"/>
								<xsl:text> </xsl:text>
							</xsl:when>
							<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) > 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'true'">
								<xsl:text> de Registergoederen </xsl:text>
								<xsl:for-each select="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht">
									<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
									<xsl:choose>
										<xsl:when test="position() = last() - 1">
											<xsl:text> en </xsl:text>
										</xsl:when>
										<xsl:when test="position() != last()">
											<xsl:text>, </xsl:text>
										</xsl:when>
									</xsl:choose>
								</xsl:for-each>
								<xsl:text> </xsl:text>
							</xsl:when>
						</xsl:choose>
					</xsl:if>
					<xsl:text>die tussen </xsl:text>
					<xsl:value-of select="$partyNameVariantVrijOpNaam"/>
					<xsl:text> en </xsl:text>
					<xsl:value-of select="$partyNameVariantKoopAanneemsom"/>
					<xsl:text> is overeengekomen, bedraagt: </xsl:text>
					<xsl:choose>
						<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) = 1">
							<xsl:apply-templates select="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht" mode="do-choose-amount-for-variant-x">
								<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
								<xsl:with-param name="bedragKoopprijs" select="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_BedragKoopprijs"/>
							</xsl:apply-templates>
						</xsl:when>
						<xsl:otherwise>
							<xsl:apply-templates select="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht[1]" mode="do-transactiesom-amount">
								<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
							</xsl:apply-templates>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:text>. In </xsl:text>
					<xsl:value-of select="$koopprijsLidwoord"/>
					<xsl:text> koopprijs is een bedrag van </xsl:text>
					<xsl:call-template name="amountText">
						<xsl:with-param name="amount" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'true']/tia:roerendezakenWaarde/tia:som"/>
						<xsl:with-param name="valuta" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'true']/tia:roerendezakenWaarde/tia:valuta"/>
					</xsl:call-template>
					<xsl:text> </xsl:text>
					<xsl:call-template name="amountNumber">
						<xsl:with-param name="amount" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'true']/tia:roerendezakenWaarde/tia:som"/>
						<xsl:with-param name="valuta" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'true']/tia:roerendezakenWaarde/tia:valuta"/>
					</xsl:call-template>
					<xsl:text> voor roerende zaken begrepen. </xsl:text>
					<xsl:if test="$registergoederenOpsommingAangehecht = 'true' and count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) = count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederenopsommingaangehecht']/tia:tekst, $upper, $lower) = 'true'])">
						<xsl:text>Van welke roerende zaken een opsomming </xsl:text>
						<xsl:value-of select="$registergoederenOpsommingAangehechtTekst"/>
						<xsl:text> gehecht aan deze akte.</xsl:text>
					</xsl:if>
					<br/>
				</p>
			</xsl:when>
			<!-- Variant 2.d Koopprijs 'vrij op naam' -->
			<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'vrij op naam']) = count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht)
						and $stukdeelKoop/tia:transactiesom">
				<p>
					<xsl:text>De koopprijs </xsl:text>
					<xsl:if test="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true']">
						<xsl:text>van </xsl:text>
						<xsl:choose>
							<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) = 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'false'">
								<xsl:value-of select="$registergoedAanduiding"/>
								<xsl:text> </xsl:text>
							</xsl:when>
							<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) = 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'true'">
								<xsl:text>het Registergoed </xsl:text>
								<xsl:value-of select="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
								<xsl:text> </xsl:text>
							</xsl:when>
							<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) > 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'false'">
								<xsl:value-of select="$registergoedAanduiding"/>
								<xsl:text> </xsl:text>
							</xsl:when>
							<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) > 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'true'">
								<xsl:text> de Registergoederen </xsl:text>
								<xsl:for-each select="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht">
									<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
									<xsl:choose>
										<xsl:when test="position() = last() - 1">
											<xsl:text> en </xsl:text>
										</xsl:when>
										<xsl:when test="position() != last()">
											<xsl:text>, </xsl:text>
										</xsl:when>
									</xsl:choose>
								</xsl:for-each>
								<xsl:text> </xsl:text>
							</xsl:when>
						</xsl:choose>
					</xsl:if>
					<xsl:text>die tussen </xsl:text>
					<xsl:value-of select="$partyNameVariantVrijOpNaam"/>
					<xsl:text> en </xsl:text>
					<xsl:value-of select="$partyNameVariantKoopAanneemsom"/>
					<xsl:text> is overeengekomen, bedraagt: </xsl:text>
					<xsl:choose>
						<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) = 1">
							<xsl:apply-templates select="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht" mode="do-choose-amount-for-variant-x">
								<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
								<xsl:with-param name="bedragKoopprijs" select="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_BedragKoopprijs"/>
							</xsl:apply-templates>
						</xsl:when>
						<xsl:otherwise>
							<xsl:apply-templates select="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht[1]" mode="do-transactiesom-amount">
								<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
							</xsl:apply-templates>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:text>, inclusief een bedrag van </xsl:text>
					<xsl:call-template name="amountText">
						<xsl:with-param name="amount" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']/tia:omzetbelasting/tia:som"/>
						<xsl:with-param name="valuta" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']/tia:omzetbelasting/tia:valuta"/>
					</xsl:call-template>
					<xsl:text> </xsl:text>
					<xsl:call-template name="amountNumber">
						<xsl:with-param name="amount" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']/tia:omzetbelasting/tia:som"/>
						<xsl:with-param name="valuta" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']/tia:omzetbelasting/tia:valuta"/>
					</xsl:call-template>
					<xsl:text> aan omzetbelasting. De notari&#x00EB;le kosten, de daarover verschuldigde omzetbelasting en het kadastraal recht wegens de levering van </xsl:text>
					<xsl:if test="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true']">
						<xsl:choose>
							<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) = 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'false'">
								<xsl:value-of select="$registergoedAanduiding"/>
								<xsl:text> </xsl:text>
							</xsl:when>
							<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) = 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'true'">
								<xsl:text>het Registergoed </xsl:text>
								<xsl:value-of select="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
								<xsl:text> </xsl:text>
							</xsl:when>
							<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) > 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'false'">
								<xsl:value-of select="$registergoedAanduiding"/>
								<xsl:text> </xsl:text>
							</xsl:when>
							<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) > 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'true'">
								<xsl:text> de Registergoederen </xsl:text>
								<xsl:for-each select="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht">
									<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
									<xsl:choose>
										<xsl:when test="position() = last() - 1">
											<xsl:text> en </xsl:text>
										</xsl:when>
										<xsl:when test="position() != last()">
											<xsl:text>, </xsl:text>
										</xsl:when>
									</xsl:choose>
								</xsl:for-each>
								<xsl:text> </xsl:text>
							</xsl:when>
						</xsl:choose>
					</xsl:if>
					<xsl:text>zijn voor rekening van </xsl:text>
					<xsl:value-of select="$partyNameVariantVrijOpNaam"/>
					<xsl:text>.</xsl:text>
				</p>
			</xsl:when>
			<!-- Variant 2.e Koopprijs 'exclusief omzetbelasting' -->
			<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'exclusief omzetbelasting']) = count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht)
						and $stukdeelKoop/tia:transactiesom">
				<p>
					<xsl:text>De koopprijs </xsl:text>
					<xsl:if test="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true']">
						<xsl:text>van </xsl:text>
						<xsl:choose>
							<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) = 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'false'">
								<xsl:value-of select="$registergoedAanduiding"/>
								<xsl:text> </xsl:text>
							</xsl:when>
							<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) = 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'true'">
								<xsl:text>het Registergoed </xsl:text>
								<xsl:value-of select="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
								<xsl:text> </xsl:text>
							</xsl:when>
							<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) > 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'false'">
								<xsl:value-of select="$registergoedAanduiding"/>
								<xsl:text> </xsl:text>
							</xsl:when>
							<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) > 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'true'">
								<xsl:text> de Registergoederen </xsl:text>
								<xsl:for-each select="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht">
									<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
									<xsl:choose>
										<xsl:when test="position() = last() - 1">
											<xsl:text> en </xsl:text>
										</xsl:when>
										<xsl:when test="position() != last()">
											<xsl:text>, </xsl:text>
										</xsl:when>
									</xsl:choose>
								</xsl:for-each>
								<xsl:text> </xsl:text>
							</xsl:when>
						</xsl:choose>
					</xsl:if>
					<xsl:text>die tussen </xsl:text>
					<xsl:value-of select="$partyNameVariantVrijOpNaam"/>
					<xsl:text> en </xsl:text>
					<xsl:value-of select="$partyNameVariantKoopAanneemsom"/>
					<xsl:text> is overeengekomen, bedraagt: </xsl:text>
					<xsl:choose>
						<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) = 1">
							<xsl:apply-templates select="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht" mode="do-choose-amount-for-variant-x">
								<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
								<xsl:with-param name="bedragKoopprijs" select="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_BedragKoopprijs"/>
							</xsl:apply-templates>
						</xsl:when>
						<xsl:otherwise>
							<xsl:apply-templates select="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht[1]" mode="do-transactiesom-amount">
								<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
							</xsl:apply-templates>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:text>, te vermeerderen met een bedrag van </xsl:text>
					<xsl:call-template name="amountText">
						<xsl:with-param name="amount" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']/tia:omzetbelasting/tia:som"/>
						<xsl:with-param name="valuta" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']/tia:omzetbelasting/tia:valuta"/>
					</xsl:call-template>
					<xsl:text> </xsl:text>
					<xsl:call-template name="amountNumber">
						<xsl:with-param name="amount" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']/tia:omzetbelasting/tia:som"/>
						<xsl:with-param name="valuta" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']/tia:omzetbelasting/tia:valuta"/>
					</xsl:call-template>
					<xsl:text> aan omzetbelasting.</xsl:text>
				</p>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="tia:IMKAD_ZakelijkRecht" mode="do-purchase-price-twee-levering-individual">
		<xsl:param name="stukdeelLeveringNext" select="self::node()[false()]"/>
		<xsl:param name="stukdeelKoop" select="self::node()[false()]"/>
		<xsl:param name="partyNameVariantVrijOpNaam" select="''"/>
		<xsl:param name="partyNameVariantKoopAanneemsom" select="''"/>
		<xsl:param name="tweeLeveringPartyText" select="''"/>
		<xsl:param name="registergoederenOpsommingAangehecht" select="''"/>
		<xsl:param name="registergoederenOpsommingAangehechtTekst" select="''"/>
		<xsl:param name="koopprijsLidwoord" select="''"/>
		<xsl:variable name="registergoederenTonenRoerendeZaken" select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederentonenroerendezaken']/tia:tekst"/>
		<xsl:choose>
			<!-- Variant 2.a Koopprijs 'kaal' -->
			<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'kaal'">
				<p>
					<xsl:text>De koopprijs </xsl:text>
					<xsl:if test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
						<xsl:text>van </xsl:text>
						<xsl:choose>
							<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true'">
								<xsl:text>het Registergoed </xsl:text>
								<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
								<xsl:text> </xsl:text>
							</xsl:when>
							<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
								<xsl:value-of select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst"/>
								<xsl:text> </xsl:text>
							</xsl:when>
						</xsl:choose>
					</xsl:if>
					<xsl:text>die tussen </xsl:text>
					<xsl:value-of select="$partyNameVariantVrijOpNaam"/>
					<xsl:text> en </xsl:text>
					<xsl:value-of select="$partyNameVariantKoopAanneemsom"/>
					<xsl:text> is overeengekomen, bedraagt: </xsl:text>
					<xsl:apply-templates select="." mode="do-choose-amount-for-variant-a">
						<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
						<xsl:with-param name="bedragKoopprijs" select="descendant-or-self::tia:tia_BedragKoopprijs[1]"/>
					</xsl:apply-templates>
					<xsl:text>.</xsl:text>
					<br/>
				</p>
			</xsl:when>
			<!-- Variant 2.b Koopprijs 'met daarnaast een bedrag aan roerende zaken' -->
			<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'roerende zaken exclusief'">
				<p>
					<xsl:text>De koopprijs </xsl:text>
					<xsl:if test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
						<xsl:text>van </xsl:text>
						<xsl:choose>
							<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true'">
								<xsl:text>het Registergoed </xsl:text>
								<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
								<xsl:text> </xsl:text>
							</xsl:when>
							<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
								<xsl:value-of select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst"/>
								<xsl:text> </xsl:text>
							</xsl:when>
						</xsl:choose>
					</xsl:if>
					<xsl:text>die tussen </xsl:text>
					<xsl:value-of select="$partyNameVariantVrijOpNaam"/>
					<xsl:text> en </xsl:text>
					<xsl:value-of select="$partyNameVariantKoopAanneemsom"/>
					<xsl:text> is overeengekomen, bedraagt: </xsl:text>
					<xsl:apply-templates select="." mode="do-choose-amount-for-variant-x">
						<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
						<xsl:with-param name="bedragKoopprijs" select="descendant-or-self::tia:tia_BedragKoopprijs[1]"/>
					</xsl:apply-templates>
					<xsl:text>. </xsl:text>
					<xsl:value-of select="$tweeLeveringPartyText"/>
					<xsl:choose>
						<xsl:when test="contains(translate($tweeLeveringPartyText, $upper, $lower), 'en')">
							<xsl:text> hebben </xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text> heeft </xsl:text>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:text>aan de </xsl:text>
					<xsl:choose>
						<xsl:when test="translate($registergoederenTonenRoerendeZaken, $upper, $lower) = 'true' and count(../tia:IMKAD_ZakelijkRecht) = count(../tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederentonenroerendezaken']/tia:tekst, $upper, $lower) = 'true'])">
							<xsl:text>in </xsl:text>
							<xsl:if test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
								<xsl:choose>
									<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true'">
										<xsl:text>het Registergoed </xsl:text>
										<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
										<xsl:text> </xsl:text>
									</xsl:when>
									<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
										<xsl:value-of select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst"/>
										<xsl:text> </xsl:text>
									</xsl:when>
								</xsl:choose>
							</xsl:if>
							<xsl:text>begrepen </xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>meeverkochte </xsl:text>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:text>roerende zaken een waarde toegekend groot </xsl:text>
					<xsl:choose>
						<xsl:when test="tia:tia_KoopprijsSpecificatie[1][translate(tia:roerendezakenInclusief, $upper, $lower) = 'false']/tia:roerendezakenWaarde">
							<xsl:call-template name="amountText">
								<xsl:with-param name="amount" select="tia:tia_KoopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'false']/tia:roerendezakenWaarde/tia:som"/>
								<xsl:with-param name="valuta" select="tia:tia_KoopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'false']/tia:roerendezakenWaarde/tia:valuta"/>
							</xsl:call-template>
							<xsl:text> </xsl:text>
							<xsl:call-template name="amountNumber">
								<xsl:with-param name="amount" select="tia:tia_KoopprijsSpecificatie[1][translate(tia:roerendezakenInclusief, $upper, $lower) = 'false']/tia:roerendezakenWaarde/tia:som"/>
								<xsl:with-param name="valuta" select="tia:tia_KoopprijsSpecificatie[1][translate(tia:roerendezakenInclusief, $upper, $lower) = 'false']/tia:roerendezakenWaarde/tia:valuta"/>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test="not(tia:tia_KoopprijsSpecificatie[1][translate(tia:roerendezakenInclusief, $upper, $lower) = 'false']/tia:roerendezakenWaarde)">
							<xsl:call-template name="amountText">
								<xsl:with-param name="amount" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'false']/tia:roerendezakenWaarde/tia:som"/>
								<xsl:with-param name="valuta" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'false']/tia:roerendezakenWaarde/tia:valuta"/>
							</xsl:call-template>
							<xsl:text> </xsl:text>
							<xsl:call-template name="amountNumber">
								<xsl:with-param name="amount" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'false']/tia:roerendezakenWaarde/tia:som"/>
								<xsl:with-param name="valuta" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'false']/tia:roerendezakenWaarde/tia:valuta"/>
							</xsl:call-template>
						</xsl:when>
					</xsl:choose>
					<xsl:text>. De koopprijs </xsl:text>
					<xsl:if test="translate($registergoederenTonenRoerendeZaken, $upper, $lower) = 'true' and count(tia:IMKAD_ZakelijkRecht) = count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederentonenroerendezaken']/tia:tekst, $upper, $lower) = 'true'])">
						<xsl:text>van </xsl:text>
						<xsl:choose>
							<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true'">
								<xsl:text>het Registergoed </xsl:text>
								<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
								<xsl:text> </xsl:text>
							</xsl:when>
							<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
								<xsl:value-of select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst"/>
								<xsl:text> </xsl:text>
							</xsl:when>
						</xsl:choose>
					</xsl:if>
					<xsl:text>wordt met dit bedrag verhoogd. </xsl:text>
					<xsl:if test="$registergoederenOpsommingAangehecht = 'true' and count(tia:IMKAD_ZakelijkRecht) = count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederenopsommingaangehecht']/tia:tekst, $upper, $lower) = 'true'])">
						<xsl:text>Van welke roerende zaken een opsomming </xsl:text>
						<xsl:value-of select="$registergoederenOpsommingAangehechtTekst"/>
						<xsl:text> gehecht aan deze akte.</xsl:text>
					</xsl:if>
				</p>
			</xsl:when>
			<!-- Variant 2.c Koopprijs 'met inbegrip van een bedrag aan roerende zaken' -->
			<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'roerende zaken inclusief'">
				<p>
					<xsl:text>De koopprijs </xsl:text>
					<xsl:if test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
						<xsl:text>van </xsl:text>
						<xsl:choose>
							<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true'">
								<xsl:text>het Registergoed </xsl:text>
								<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
								<xsl:text> </xsl:text>
							</xsl:when>
							<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
								<xsl:value-of select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst"/>
								<xsl:text> </xsl:text>
							</xsl:when>
						</xsl:choose>
					</xsl:if>
					<xsl:text>die tussen </xsl:text>
					<xsl:value-of select="$partyNameVariantVrijOpNaam"/>
					<xsl:text> en </xsl:text>
					<xsl:value-of select="$partyNameVariantKoopAanneemsom"/>
					<xsl:text> is overeengekomen, bedraagt: </xsl:text>
					<xsl:apply-templates select="." mode="do-choose-amount-for-variant-x">
						<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
						<xsl:with-param name="bedragKoopprijs" select="descendant-or-self::tia:tia_BedragKoopprijs[1]"/>
					</xsl:apply-templates>
					<xsl:text>. In </xsl:text>
					<xsl:value-of select="$koopprijsLidwoord"/>
					<xsl:text> koopprijs is een bedrag van </xsl:text>
					<xsl:choose>
						<xsl:when test="tia:tia_KoopprijsSpecificatie[1][translate(tia:roerendezakenInclusief, $upper, $lower) = 'true']/tia:roerendezakenWaarde">
							<xsl:call-template name="amountText">
								<xsl:with-param name="amount" select="tia:tia_KoopprijsSpecificatie[1][translate(tia:roerendezakenInclusief, $upper, $lower) = 'true']/tia:roerendezakenWaarde/tia:som"/>
								<xsl:with-param name="valuta" select="tia:tia_KoopprijsSpecificatie[1][translate(tia:roerendezakenInclusief, $upper, $lower) = 'true']/tia:roerendezakenWaarde/tia:valuta"/>
							</xsl:call-template>
							<xsl:text> </xsl:text>
							<xsl:call-template name="amountNumber">
								<xsl:with-param name="amount" select="tia:tia_KoopprijsSpecificatie[1][translate(tia:roerendezakenInclusief, $upper, $lower) = 'true']/tia:roerendezakenWaarde/tia:som"/>
								<xsl:with-param name="valuta" select="tia:tia_KoopprijsSpecificatie[1][translate(tia:roerendezakenInclusief, $upper, $lower) = 'true']/tia:roerendezakenWaarde/tia:valuta"/>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test="not(tia:tia_KoopprijsSpecificatie[1][translate(tia:roerendezakenInclusief, $upper, $lower) = 'true']/tia:roerendezakenWaarde)">
							<xsl:call-template name="amountText">
								<xsl:with-param name="amount" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'true']/tia:roerendezakenWaarde/tia:som"/>
								<xsl:with-param name="valuta" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'true']/tia:roerendezakenWaarde/tia:valuta"/>
							</xsl:call-template>
							<xsl:text> </xsl:text>
							<xsl:call-template name="amountNumber">
								<xsl:with-param name="amount" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'true']/tia:roerendezakenWaarde/tia:som"/>
								<xsl:with-param name="valuta" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'true']/tia:roerendezakenWaarde/tia:valuta"/>
							</xsl:call-template>
						</xsl:when>
					</xsl:choose>
					<xsl:text> voor roerende zaken begrepen. </xsl:text>
					<xsl:if test="$registergoederenOpsommingAangehecht = 'true' and count(tia:IMKAD_ZakelijkRecht) = count(tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederenopsommingaangehecht']/tia:tekst, $upper, $lower) = 'true'])">
						<xsl:text>Van welke roerende zaken een opsomming </xsl:text>
						<xsl:value-of select="$registergoederenOpsommingAangehechtTekst"/>
						<xsl:text> gehecht aan deze akte.</xsl:text>
					</xsl:if>
				</p>
			</xsl:when>
			<!-- Variant 2.d Koopprijs 'vrij op naam' -->
			<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'vrij op naam'">
				<p>
					<xsl:text>De koopprijs </xsl:text>
					<xsl:if test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
						<xsl:text>van </xsl:text>
						<xsl:choose>
							<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true'">
								<xsl:text>het Registergoed </xsl:text>
								<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
								<xsl:text> </xsl:text>
							</xsl:when>
							<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
								<xsl:value-of select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst"/>
								<xsl:text> </xsl:text>
							</xsl:when>
						</xsl:choose>
					</xsl:if>
					<xsl:text>die tussen </xsl:text>
					<xsl:value-of select="$partyNameVariantVrijOpNaam"/>
					<xsl:text> en </xsl:text>
					<xsl:value-of select="$partyNameVariantKoopAanneemsom"/>
					<xsl:text> is overeengekomen, bedraagt: </xsl:text>
					<xsl:apply-templates select="." mode="do-choose-amount-for-variant-x">
						<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
						<xsl:with-param name="bedragKoopprijs" select="descendant-or-self::tia:tia_BedragKoopprijs[1]"/>
					</xsl:apply-templates>
					<xsl:text>, inclusief een bedrag van </xsl:text>
					<xsl:choose>
						<xsl:when test="tia:tia_KoopprijsSpecificatie[1][translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']/tia:omzetbelasting">
							<xsl:call-template name="amountText">
								<xsl:with-param name="amount" select="tia:tia_KoopprijsSpecificatie[1][translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']/tia:omzetbelasting/tia:som"/>
								<xsl:with-param name="valuta" select="tia:tia_KoopprijsSpecificatie[1][translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']/tia:omzetbelasting/tia:valuta"/>
							</xsl:call-template>
							<xsl:text> </xsl:text>
							<xsl:call-template name="amountNumber">
								<xsl:with-param name="amount" select="tia:tia_KoopprijsSpecificatie[1][translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']/tia:omzetbelasting/tia:som"/>
								<xsl:with-param name="valuta" select="tia:tia_KoopprijsSpecificatie[1][translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']/tia:omzetbelasting/tia:valuta"/>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test="not(tia:tia_KoopprijsSpecificatie[1][translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']/tia:omzetbelasting)">
							<xsl:call-template name="amountText">
								<xsl:with-param name="amount" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']/tia:omzetbelasting/tia:som"/>
								<xsl:with-param name="valuta" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']/tia:omzetbelasting/tia:valuta"/>
							</xsl:call-template>
							<xsl:text> </xsl:text>
							<xsl:call-template name="amountNumber">
								<xsl:with-param name="amount" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']/tia:omzetbelasting/tia:som"/>
								<xsl:with-param name="valuta" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']/tia:omzetbelasting/tia:valuta"/>
							</xsl:call-template>
						</xsl:when>
					</xsl:choose>
					<xsl:text> aan omzetbelasting. De notari&#x00EB;le kosten, de daarover verschuldigde omzetbelasting en het kadastraal recht wegens de levering van </xsl:text>
					<xsl:choose>
						<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true'">
							<xsl:text>het Registergoed </xsl:text>
							<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
							<xsl:text> </xsl:text>
						</xsl:when>
						<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
							<xsl:value-of select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst"/>
							<xsl:text> </xsl:text>
						</xsl:when>
					</xsl:choose>
					<xsl:text>zijn voor rekening van </xsl:text>
					<xsl:value-of select="$partyNameVariantVrijOpNaam"/>
					<xsl:text>.</xsl:text>
				</p>
			</xsl:when>
			<!-- Variant 2.e Koopprijs 'exclusief omzetbelasting' -->
			<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'exclusief omzetbelasting'">
				<p>
					<xsl:text>De koopprijs </xsl:text>
					<xsl:if test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
						<xsl:text>van </xsl:text>
						<xsl:choose>
							<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true'">
								<xsl:text>het Registergoed </xsl:text>
								<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
								<xsl:text> </xsl:text>
							</xsl:when>
							<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
								<xsl:value-of select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst"/>
								<xsl:text> </xsl:text>
							</xsl:when>
						</xsl:choose>
					</xsl:if>
					<xsl:text>die tussen </xsl:text>
					<xsl:value-of select="$partyNameVariantVrijOpNaam"/>
					<xsl:text> en </xsl:text>
					<xsl:value-of select="$partyNameVariantKoopAanneemsom"/>
					<xsl:text> is overeengekomen, bedraagt: </xsl:text>
					<xsl:apply-templates select="." mode="do-choose-amount-for-variant-x">
						<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
						<xsl:with-param name="bedragKoopprijs" select="descendant-or-self::tia:tia_BedragKoopprijs[1]"/>
					</xsl:apply-templates>
					<xsl:text>, te vermeerderen met een bedrag van </xsl:text>
					<xsl:choose>
						<xsl:when test="tia:tia_KoopprijsSpecificatie[1][translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']/tia:omzetbelasting">
							<xsl:call-template name="amountText">
								<xsl:with-param name="amount" select="tia:tia_KoopprijsSpecificatie[1][translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']/tia:omzetbelasting/tia:som"/>
								<xsl:with-param name="valuta" select="tia:tia_KoopprijsSpecificatie[1][translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']/tia:omzetbelasting/tia:valuta"/>
							</xsl:call-template>
							<xsl:text> </xsl:text>
							<xsl:call-template name="amountNumber">
								<xsl:with-param name="amount" select="tia:tia_KoopprijsSpecificatie[1][translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']/tia:omzetbelasting/tia:som"/>
								<xsl:with-param name="valuta" select="tia:tia_KoopprijsSpecificatie[1][translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']/tia:omzetbelasting/tia:valuta"/>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test="not(tia:tia_KoopprijsSpecificatie[1][translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']/tia:omzetbelasting)">
							<xsl:call-template name="amountText">
								<xsl:with-param name="amount" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']/tia:omzetbelasting/tia:som"/>
								<xsl:with-param name="valuta" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']/tia:omzetbelasting/tia:valuta"/>
							</xsl:call-template>
							<xsl:text> </xsl:text>
							<xsl:call-template name="amountNumber">
								<xsl:with-param name="amount" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']/tia:omzetbelasting/tia:som"/>
								<xsl:with-param name="valuta" select="$stukdeelKoop/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']/tia:omzetbelasting/tia:valuta"/>
							</xsl:call-template>
						</xsl:when>
					</xsl:choose>
					<xsl:text> aan omzetbelasting.</xsl:text>
				</p>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="tia:StukdeelLevering" mode="do-purchase-price-twee-levering-group-next">
		<xsl:param name="stukdeelLeveringNext" select="self::node()[false()]"/>
		<xsl:param name="stukdeelKoopNext" select="self::node()[false()]"/>
		<xsl:param name="registergoedAanduidingNext" select="''"/>
		<xsl:param name="partyNameVariantVrijOpNaamNext" select="''"/>
		<xsl:param name="partyNameVariantKoopAanneemsomNext" select="''"/>
		<xsl:param name="tweeLeveringPartyTextNext" select="''"/>
		<xsl:param name="registergoederenTonenRoerendeZakenNext" select="''"/>
		<xsl:param name="registergoederenOpsommingAangehechtNext" select="''"/>
		<xsl:param name="registergoederenOpsommingAangehechtTekstNext" select="''"/>
		<xsl:param name="koopprijsLidwoordNext" select="''"/>
		<xsl:choose>
			<!-- Variant 2.a Koopprijs 'kaal' -->
			<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'kaal']) = count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht)
						and $stukdeelKoopNext/tia:transactiesom">
				<p>
					<xsl:text>De koopprijs </xsl:text>
					<xsl:if test="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true']">
						<xsl:text>van </xsl:text>
						<xsl:choose>
							<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) = 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'false'">
								<xsl:value-of select="$registergoedAanduidingNext"/>
								<xsl:text> </xsl:text>
							</xsl:when>
							<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) = 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'true'">
								<xsl:text>het Registergoed </xsl:text>
								<xsl:value-of select="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
								<xsl:text> </xsl:text>
							</xsl:when>
							<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) > 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'false'">
								<xsl:value-of select="$registergoedAanduidingNext"/>
								<xsl:text> </xsl:text>
							</xsl:when>
							<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) > 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'true'">
								<xsl:text> de Registergoederen </xsl:text>
								<xsl:for-each select="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht">
									<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
									<xsl:choose>
										<xsl:when test="position() = last() - 1">
											<xsl:text> en </xsl:text>
										</xsl:when>
										<xsl:when test="position() != last()">
											<xsl:text>, </xsl:text>
										</xsl:when>
									</xsl:choose>
								</xsl:for-each>
								<xsl:text> </xsl:text>
							</xsl:when>
						</xsl:choose>
					</xsl:if>
					<xsl:text>die tussen </xsl:text>
					<xsl:value-of select="$partyNameVariantVrijOpNaamNext"/>
					<xsl:text> en </xsl:text>
					<xsl:value-of select="$partyNameVariantKoopAanneemsomNext"/>
					<xsl:text> is overeengekomen, bedraagt: </xsl:text>
					<xsl:choose>
						<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) = 1">
							<xsl:apply-templates select="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht" mode="do-choose-amount-for-variant-a">
								<xsl:with-param name="stukdeelKoop" select="$stukdeelKoopNext"/>
								<xsl:with-param name="bedragKoopprijs" select="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_BedragKoopprijs[2]"/>
							</xsl:apply-templates>
						</xsl:when>
						<xsl:when test="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht[tia:tia_BedragKoopprijs and tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst = 'true'
										and tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'true']">
							<xsl:for-each select="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht">
								<xsl:apply-templates select="." mode="do-bedragKoopprijs-amount">
									<xsl:with-param name="bedragKoopprijs" select="tia:tia_BedragKoopprijs[2]"/>
									<xsl:with-param name="stukdeelKoop" select="$stukdeelKoopNext"/>
								</xsl:apply-templates>
							</xsl:for-each>
						</xsl:when>
						<xsl:otherwise>
							<xsl:apply-templates select="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht[1]" mode="do-transactiesom-amount">
								<xsl:with-param name="stukdeelKoop" select="$stukdeelKoopNext"/>
							</xsl:apply-templates>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:text>.</xsl:text>
					<br/>
				</p>
			</xsl:when>
			<!-- Variant 2.b Koopprijs 'met daarnaast een bedrag aan roerende zaken' -->
			<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'roerende zaken exclusief']) = count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht)
						and $stukdeelKoopNext/tia:transactiesom">
				<p>
					<xsl:text>De koopprijs </xsl:text>
					<xsl:if test="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true']">
						<xsl:text>van </xsl:text>
						<xsl:choose>
							<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) = 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'false'">
								<xsl:value-of select="$registergoedAanduidingNext"/>
								<xsl:text> </xsl:text>
							</xsl:when>
							<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) = 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'true'">
								<xsl:text>het Registergoed </xsl:text>
								<xsl:value-of select="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
								<xsl:text> </xsl:text>
							</xsl:when>
							<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) > 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'false'">
								<xsl:value-of select="$registergoedAanduidingNext"/>
								<xsl:text> </xsl:text>
							</xsl:when>
							<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) > 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'true'">
								<xsl:text> de Registergoederen </xsl:text>
								<xsl:for-each select="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht">
									<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
									<xsl:choose>
										<xsl:when test="position() = last() - 1">
											<xsl:text> en </xsl:text>
										</xsl:when>
										<xsl:when test="position() != last()">
											<xsl:text>, </xsl:text>
										</xsl:when>
									</xsl:choose>
								</xsl:for-each>
								<xsl:text> </xsl:text>
							</xsl:when>
						</xsl:choose>
					</xsl:if>
					<xsl:text>die tussen </xsl:text>
					<xsl:value-of select="$partyNameVariantVrijOpNaamNext"/>
					<xsl:text> en </xsl:text>
					<xsl:value-of select="$partyNameVariantKoopAanneemsomNext"/>
					<xsl:text> is overeengekomen, bedraagt: </xsl:text>
					<xsl:choose>
						<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) = 1">
							<xsl:apply-templates select="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht" mode="do-choose-amount-for-variant-x">
								<xsl:with-param name="stukdeelKoop" select="$stukdeelKoopNext"/>
								<xsl:with-param name="bedragKoopprijs" select="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_BedragKoopprijs[2]"/>
							</xsl:apply-templates>
						</xsl:when>
						<xsl:otherwise>
							<xsl:apply-templates select="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht[1]" mode="do-transactiesom-amount">
								<xsl:with-param name="stukdeelKoop" select="$stukdeelKoopNext"/>
							</xsl:apply-templates>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:text>. </xsl:text>
					<xsl:value-of select="$tweeLeveringPartyTextNext"/>
					<xsl:choose>
						<xsl:when test="contains(translate($tweeLeveringPartyTextNext, $upper, $lower), 'en')">
							<xsl:text> hebben </xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text> heeft </xsl:text>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:text>aan de </xsl:text>
					<xsl:choose>
						<xsl:when test="translate($registergoederenTonenRoerendeZakenNext, $upper, $lower) = 'true' and count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) = count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederentonenroerendezaken']/tia:tekst, $upper, $lower) = 'true'])">
							<xsl:text>in </xsl:text>
							<xsl:if test="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true']">
								<xsl:choose>
									<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) = 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'false'">
										<xsl:value-of select="$registergoedAanduidingNext"/>
										<xsl:text> </xsl:text>
									</xsl:when>
									<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) = 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'true'">
										<xsl:text>het Registergoed </xsl:text>
										<xsl:value-of select="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
										<xsl:text> </xsl:text>
									</xsl:when>
									<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) > 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'false'">
										<xsl:value-of select="$registergoedAanduidingNext"/>
										<xsl:text> </xsl:text>
									</xsl:when>
									<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) > 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'true'">
										<xsl:text> de Registergoederen </xsl:text>
										<xsl:for-each select="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht">
											<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
											<xsl:choose>
												<xsl:when test="position() = last() - 1">
													<xsl:text> en </xsl:text>
												</xsl:when>
												<xsl:when test="position() != last()">
													<xsl:text>, </xsl:text>
												</xsl:when>
											</xsl:choose>
										</xsl:for-each>
										<xsl:text> </xsl:text>
									</xsl:when>
								</xsl:choose>
							</xsl:if>
							<xsl:text>begrepen </xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>meeverkochte </xsl:text>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:text>roerende zaken een waarde toegekend groot </xsl:text>
					<xsl:call-template name="amountText">
						<xsl:with-param name="amount" select="$stukdeelKoopNext/tia:koopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'false']/tia:roerendezakenWaarde/tia:som"/>
						<xsl:with-param name="valuta" select="$stukdeelKoopNext/tia:koopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'false']/tia:roerendezakenWaarde/tia:valuta"/>
					</xsl:call-template>
					<xsl:text> </xsl:text>
					<xsl:call-template name="amountNumber">
						<xsl:with-param name="amount" select="$stukdeelKoopNext/tia:koopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'false']/tia:roerendezakenWaarde/tia:som"/>
						<xsl:with-param name="valuta" select="$stukdeelKoopNext/tia:koopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'false']/tia:roerendezakenWaarde/tia:valuta"/>
					</xsl:call-template>
					<xsl:text>. De koopprijs </xsl:text>
					<xsl:if test="translate($registergoederenTonenRoerendeZakenNext, $upper, $lower) = 'true' and count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) = count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederentonenroerendezaken']/tia:tekst, $upper, $lower) = 'true'])">
						<xsl:text>van </xsl:text>
						<xsl:if test="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true']">
							<xsl:choose>
								<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) = 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'false'">
									<xsl:value-of select="$registergoedAanduidingNext"/>
									<xsl:text> </xsl:text>
								</xsl:when>
								<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) = 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'true'">
									<xsl:text>het Registergoed </xsl:text>
									<xsl:value-of select="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
									<xsl:text> </xsl:text>
								</xsl:when>
								<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) > 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'false'">
									<xsl:value-of select="$registergoedAanduidingNext"/>
									<xsl:text> </xsl:text>
								</xsl:when>
								<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) > 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'true'">
									<xsl:text> de Registergoederen </xsl:text>
									<xsl:for-each select="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht">
										<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
										<xsl:choose>
											<xsl:when test="position() = last() - 1">
												<xsl:text> en </xsl:text>
											</xsl:when>
											<xsl:when test="position() != last()">
												<xsl:text>, </xsl:text>
											</xsl:when>
										</xsl:choose>
									</xsl:for-each>
									<xsl:text> </xsl:text>
								</xsl:when>
							</xsl:choose>
						</xsl:if>
					</xsl:if>
					<xsl:text>wordt met dit bedrag verhoogd. </xsl:text>
					<xsl:if test="$registergoederenOpsommingAangehechtNext = 'true' and count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) = count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederenopsommingaangehecht']/tia:tekst, $upper, $lower) = 'true'])">
						<xsl:text>Van welke roerende zaken een opsomming </xsl:text>
						<xsl:value-of select="$registergoederenOpsommingAangehechtTekstNext"/>
						<xsl:text> gehecht aan deze akte.</xsl:text>
					</xsl:if>
				</p>
			</xsl:when>
			<!-- Variant 2.c Koopprijs 'met inbegrip van een bedrag aan roerende zaken' -->
			<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'roerende zaken inclusief']) = count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht)
						and $stukdeelKoopNext/tia:transactiesom">
				<p>
					<xsl:text>De koopprijs </xsl:text>
					<xsl:if test="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true']">
						<xsl:text>van </xsl:text>
						<xsl:choose>
							<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) = 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'false'">
								<xsl:value-of select="$registergoedAanduidingNext"/>
								<xsl:text> </xsl:text>
							</xsl:when>
							<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) = 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'true'">
								<xsl:text>het Registergoed </xsl:text>
								<xsl:value-of select="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
								<xsl:text> </xsl:text>
							</xsl:when>
							<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) > 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'false'">
								<xsl:value-of select="$registergoedAanduidingNext"/>
								<xsl:text> </xsl:text>
							</xsl:when>
							<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) > 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'true'">
								<xsl:text> de Registergoederen </xsl:text>
								<xsl:for-each select="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht">
									<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
									<xsl:choose>
										<xsl:when test="position() = last() - 1">
											<xsl:text> en </xsl:text>
										</xsl:when>
										<xsl:when test="position() != last()">
											<xsl:text>, </xsl:text>
										</xsl:when>
									</xsl:choose>
								</xsl:for-each>
								<xsl:text> </xsl:text>
							</xsl:when>
						</xsl:choose>
					</xsl:if>
					<xsl:text>die tussen </xsl:text>
					<xsl:value-of select="$partyNameVariantVrijOpNaamNext"/>
					<xsl:text> en </xsl:text>
					<xsl:value-of select="$partyNameVariantKoopAanneemsomNext"/>
					<xsl:text> is overeengekomen, bedraagt: </xsl:text>
					<xsl:choose>
						<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) = 1">
							<xsl:apply-templates select="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht" mode="do-choose-amount-for-variant-x">
								<xsl:with-param name="stukdeelKoop" select="$stukdeelKoopNext"/>
								<xsl:with-param name="bedragKoopprijs" select="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_BedragKoopprijs[2]"/>
							</xsl:apply-templates>
						</xsl:when>
						<xsl:otherwise>
							<xsl:apply-templates select="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht[1]" mode="do-transactiesom-amount">
								<xsl:with-param name="stukdeelKoop" select="$stukdeelKoopNext"/>
							</xsl:apply-templates>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:text>. In </xsl:text>
					<xsl:value-of select="$koopprijsLidwoordNext"/>
					<xsl:text> koopprijs is een bedrag van </xsl:text>
					<xsl:call-template name="amountText">
						<xsl:with-param name="amount" select="$stukdeelKoopNext/tia:koopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'true']/tia:roerendezakenWaarde/tia:som"/>
						<xsl:with-param name="valuta" select="$stukdeelKoopNext/tia:koopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'true']/tia:roerendezakenWaarde/tia:valuta"/>
					</xsl:call-template>
					<xsl:text> </xsl:text>
					<xsl:call-template name="amountNumber">
						<xsl:with-param name="amount" select="$stukdeelKoopNext/tia:koopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'true']/tia:roerendezakenWaarde/tia:som"/>
						<xsl:with-param name="valuta" select="$stukdeelKoopNext/tia:koopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'true']/tia:roerendezakenWaarde/tia:valuta"/>
					</xsl:call-template>
					<xsl:text> voor roerende zaken begrepen. </xsl:text>
					<xsl:if test="$registergoederenOpsommingAangehechtNext = 'true' and count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) = count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederenopsommingaangehecht']/tia:tekst, $upper, $lower) = 'true'])">
						<xsl:text>Van welke roerende zaken een opsomming </xsl:text>
						<xsl:value-of select="$registergoederenOpsommingAangehechtTekstNext"/>
						<xsl:text> gehecht aan deze akte.</xsl:text>
					</xsl:if>
					<br/>
				</p>
			</xsl:when>
			<!-- Variant 2.d Koopprijs 'vrij op naam' -->
			<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'vrij op naam']) = count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht)
					and $stukdeelKoopNext/tia:transactiesom">
				<p>
					<xsl:text>De koopprijs </xsl:text>
					<xsl:if test="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true']">
						<xsl:text>van </xsl:text>
						<xsl:choose>
							<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) = 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'false'">
								<xsl:value-of select="$registergoedAanduidingNext"/>
								<xsl:text> </xsl:text>
							</xsl:when>
							<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) = 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'true'">
								<xsl:text>het Registergoed </xsl:text>
								<xsl:value-of select="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
								<xsl:text> </xsl:text>
							</xsl:when>
							<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) > 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'false'">
								<xsl:value-of select="$registergoedAanduidingNext"/>
								<xsl:text> </xsl:text>
							</xsl:when>
							<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) > 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'true'">
								<xsl:text> de Registergoederen </xsl:text>
								<xsl:for-each select="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht">
									<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
									<xsl:choose>
										<xsl:when test="position() = last() - 1">
											<xsl:text> en </xsl:text>
										</xsl:when>
										<xsl:when test="position() != last()">
											<xsl:text>, </xsl:text>
										</xsl:when>
									</xsl:choose>
								</xsl:for-each>
								<xsl:text> </xsl:text>
							</xsl:when>
						</xsl:choose>
					</xsl:if>
					<xsl:text>die tussen </xsl:text>
					<xsl:value-of select="$partyNameVariantVrijOpNaamNext"/>
					<xsl:text> en </xsl:text>
					<xsl:value-of select="$partyNameVariantKoopAanneemsomNext"/>
					<xsl:text> is overeengekomen, bedraagt: </xsl:text>
					<xsl:choose>
						<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) = 1">
							<xsl:apply-templates select="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht" mode="do-choose-amount-for-variant-x">
								<xsl:with-param name="stukdeelKoop" select="$stukdeelKoopNext"/>
								<xsl:with-param name="bedragKoopprijs" select="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_BedragKoopprijs[2]"/>
							</xsl:apply-templates>
						</xsl:when>
						<xsl:otherwise>
							<xsl:apply-templates select="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht[1]" mode="do-transactiesom-amount">
								<xsl:with-param name="stukdeelKoop" select="$stukdeelKoopNext"/>
							</xsl:apply-templates>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:text>, inclusief een bedrag van </xsl:text>
					<xsl:call-template name="amountText">
						<xsl:with-param name="amount" select="$stukdeelKoopNext/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']/tia:omzetbelasting/tia:som"/>
						<xsl:with-param name="valuta" select="$stukdeelKoopNext/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']/tia:omzetbelasting/tia:valuta"/>
					</xsl:call-template>
					<xsl:text> </xsl:text>
					<xsl:call-template name="amountNumber">
						<xsl:with-param name="amount" select="$stukdeelKoopNext/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']/tia:omzetbelasting/tia:som"/>
						<xsl:with-param name="valuta" select="$stukdeelKoopNext/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']/tia:omzetbelasting/tia:valuta"/>
					</xsl:call-template>
					<xsl:text> aan omzetbelasting. De notari&#x00EB;le kosten, de daarover verschuldigde omzetbelasting en het kadastraal recht wegens de levering van </xsl:text>
					<xsl:if test="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true']">
						<xsl:choose>
							<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) = 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'false'">
								<xsl:value-of select="$registergoedAanduidingNext"/>
								<xsl:text> </xsl:text>
							</xsl:when>
							<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) = 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'true'">
								<xsl:text>het Registergoed </xsl:text>
								<xsl:value-of select="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
								<xsl:text> </xsl:text>
							</xsl:when>
							<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) > 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'false'">
								<xsl:value-of select="$registergoedAanduidingNext"/>
								<xsl:text> </xsl:text>
							</xsl:when>
							<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) > 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'true'">
								<xsl:text> de Registergoederen </xsl:text>
								<xsl:for-each select="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht">
									<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
									<xsl:choose>
										<xsl:when test="position() = last() - 1">
											<xsl:text> en </xsl:text>
										</xsl:when>
										<xsl:when test="position() != last()">
											<xsl:text>, </xsl:text>
										</xsl:when>
									</xsl:choose>
								</xsl:for-each>
								<xsl:text> </xsl:text>
							</xsl:when>
						</xsl:choose>
					</xsl:if>
					<xsl:text>zijn voor rekening van </xsl:text>
					<xsl:value-of select="$partyNameVariantVrijOpNaamNext"/>
					<xsl:text>.</xsl:text>
				</p>
			</xsl:when>
			<!-- Variant 2.e Koopprijs 'exclusief omzetbelasting' -->
			<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'exclusief omzetbelasting']) = count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht)
						and $stukdeelKoopNext/tia:transactiesom">
				<p>
					<xsl:text>De koopprijs </xsl:text>
					<xsl:if test="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true']">
						<xsl:text>van </xsl:text>
						<xsl:choose>
							<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) = 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'false'">
								<xsl:value-of select="$registergoedAanduidingNext"/>
								<xsl:text> </xsl:text>
							</xsl:when>
							<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) = 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'true'">
								<xsl:text>het Registergoed </xsl:text>
								<xsl:value-of select="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
								<xsl:text> </xsl:text>
							</xsl:when>
							<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) > 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'false'">
								<xsl:value-of select="$registergoedAanduidingNext"/>
								<xsl:text> </xsl:text>
							</xsl:when>
							<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) > 1 and $stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'true'">
								<xsl:text> de Registergoederen </xsl:text>
								<xsl:for-each select="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht">
									<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
									<xsl:choose>
										<xsl:when test="position() = last() - 1">
											<xsl:text> en </xsl:text>
										</xsl:when>
										<xsl:when test="position() != last()">
											<xsl:text>, </xsl:text>
										</xsl:when>
									</xsl:choose>
								</xsl:for-each>
								<xsl:text> </xsl:text>
							</xsl:when>
						</xsl:choose>
					</xsl:if>
					<xsl:text>die tussen </xsl:text>
					<xsl:value-of select="$partyNameVariantVrijOpNaamNext"/>
					<xsl:text> en </xsl:text>
					<xsl:value-of select="$partyNameVariantKoopAanneemsomNext"/>
					<xsl:text> is overeengekomen, bedraagt: </xsl:text>
					<xsl:choose>
						<xsl:when test="count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) = 1">
							<xsl:apply-templates select="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht" mode="do-choose-amount-for-variant-x">
								<xsl:with-param name="stukdeelKoop" select="$stukdeelKoopNext"/>
								<xsl:with-param name="bedragKoopprijs" select="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht/tia:tia_BedragKoopprijs[2]"/>
							</xsl:apply-templates>
						</xsl:when>
						<xsl:otherwise>
							<xsl:apply-templates select="$stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht[1]" mode="do-transactiesom-amount">
								<xsl:with-param name="stukdeelKoop" select="$stukdeelKoopNext"/>
							</xsl:apply-templates>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:text>, te vermeerderen met een bedrag van </xsl:text>
					<xsl:call-template name="amountText">
						<xsl:with-param name="amount" select="$stukdeelKoopNext/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']/tia:omzetbelasting/tia:som"/>
						<xsl:with-param name="valuta" select="$stukdeelKoopNext/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']/tia:omzetbelasting/tia:valuta"/>
					</xsl:call-template>
					<xsl:text> </xsl:text>
					<xsl:call-template name="amountNumber">
						<xsl:with-param name="amount" select="$stukdeelKoopNext/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']/tia:omzetbelasting/tia:som"/>
						<xsl:with-param name="valuta" select="$stukdeelKoopNext/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']/tia:omzetbelasting/tia:valuta"/>
					</xsl:call-template>
					<xsl:text> aan omzetbelasting.</xsl:text>
				</p>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="tia:IMKAD_ZakelijkRecht" mode="do-purchase-price-twee-levering-individual-next">
		<xsl:param name="stukdeelLeveringNext" select="self::node()[false()]"/>
		<xsl:param name="stukdeelKoopNext" select="self::node()[false()]"/>
		<xsl:param name="partyNameVariantVrijOpNaamNext" select="''"/>
		<xsl:param name="partyNameVariantKoopAanneemsomNext" select="''"/>
		<xsl:param name="tweeLeveringPartyTextNext" select="''"/>
		<xsl:param name="registergoederenTonenRoerendeZakenNext" select="''"/>
		<xsl:param name="registergoederenOpsommingAangehechtNext" select="''"/>
		<xsl:param name="registergoederenOpsommingAangehechtTekstNext" select="''"/>
		<xsl:param name="koopprijsLidwoordNext" select="''"/>
		<xsl:choose>
			<!-- Variant 2.a Koopprijs 'kaal' -->
			<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'kaal'">
				<p>
					<xsl:text>De koopprijs </xsl:text>
					<xsl:if test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
						<xsl:text>van </xsl:text>
						<xsl:choose>
							<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true'">
								<xsl:text>Registergoed </xsl:text>
								<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
								<xsl:text> </xsl:text>
							</xsl:when>
							<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
								<xsl:value-of select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst"/>
								<xsl:text> </xsl:text>
							</xsl:when>
						</xsl:choose>
					</xsl:if>
					<xsl:text>die tussen </xsl:text>
					<xsl:value-of select="$partyNameVariantVrijOpNaamNext"/>
					<xsl:text> en </xsl:text>
					<xsl:value-of select="$partyNameVariantKoopAanneemsomNext"/>
					<xsl:text> is overeengekomen, bedraagt: </xsl:text>
					<xsl:apply-templates select="." mode="do-choose-amount-for-variant-a">
						<xsl:with-param name="stukdeelKoop" select="$stukdeelKoopNext"/>
						<xsl:with-param name="bedragKoopprijs" select="descendant-or-self::tia:tia_BedragKoopprijs[2]"/>
					</xsl:apply-templates>
					<xsl:text>.</xsl:text>
					<br/>
				</p>
			</xsl:when>
			<!-- Variant 2.b Koopprijs 'met daarnaast een bedrag aan roerende zaken' -->
			<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'roerende zaken exclusief'">
				<p>
					<xsl:text>De koopprijs </xsl:text>
					<xsl:if test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
						<xsl:text>van </xsl:text>
						<xsl:choose>
							<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true'">
								<xsl:text>het Registergoed </xsl:text>
								<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
								<xsl:text> </xsl:text>
							</xsl:when>
							<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
								<xsl:value-of select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst"/>
								<xsl:text> </xsl:text>
							</xsl:when>
						</xsl:choose>
					</xsl:if>
					<xsl:text>die tussen </xsl:text>
					<xsl:value-of select="$partyNameVariantVrijOpNaamNext"/>
					<xsl:text> en </xsl:text>
					<xsl:value-of select="$partyNameVariantKoopAanneemsomNext"/>
					<xsl:text> is overeengekomen, bedraagt: </xsl:text>
					<xsl:apply-templates select="." mode="do-choose-amount-for-variant-x">
						<xsl:with-param name="stukdeelKoop" select="$stukdeelKoopNext"/>
						<xsl:with-param name="bedragKoopprijs" select="descendant-or-self::tia:tia_BedragKoopprijs[2]"/>
					</xsl:apply-templates>
					<xsl:text>. </xsl:text>
					<xsl:value-of select="$tweeLeveringPartyTextNext"/>
					<xsl:choose>
						<xsl:when test="contains(translate($tweeLeveringPartyTextNext, $upper, $lower), 'en')">
							<xsl:text> hebben </xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text> heeft </xsl:text>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:text>aan de </xsl:text>
					<xsl:choose>
						<xsl:when test="translate($registergoederenTonenRoerendeZakenNext, $upper, $lower) = 'true' and count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) = count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederentonenroerendezaken']/tia:tekst, $upper, $lower) = 'true'])">
							<xsl:text>in </xsl:text>
							<xsl:if test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
								<xsl:choose>
									<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true'">
										<xsl:text>het Registergoed </xsl:text>
										<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
										<xsl:text> </xsl:text>
									</xsl:when>
									<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
										<xsl:value-of select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst"/>
										<xsl:text> </xsl:text>
									</xsl:when>
								</xsl:choose>
							</xsl:if>
							<xsl:text>begrepen </xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>meeverkochte </xsl:text>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:text>roerende zaken een waarde toegekend groot </xsl:text>
					<xsl:choose>
						<xsl:when test="tia:tia_KoopprijsSpecificatie[2][translate(tia:roerendezakenInclusief, $upper, $lower) = 'false']/tia:roerendezakenWaarde">
							<xsl:call-template name="amountText">
								<xsl:with-param name="amount" select="tia:tia_KoopprijsSpecificatie[2][translate(tia:roerendezakenInclusief, $upper, $lower) = 'false']/tia:roerendezakenWaarde/tia:som"/>
								<xsl:with-param name="valuta" select="tia:tia_KoopprijsSpecificatie[2][translate(tia:roerendezakenInclusief, $upper, $lower) = 'false']/tia:roerendezakenWaarde/tia:valuta"/>
							</xsl:call-template>
							<xsl:text> </xsl:text>
							<xsl:call-template name="amountNumber">
								<xsl:with-param name="amount" select="tia:tia_KoopprijsSpecificatie[2][translate(tia:roerendezakenInclusief, $upper, $lower) = 'false']/tia:roerendezakenWaarde/tia:som"/>
								<xsl:with-param name="valuta" select="tia:tia_KoopprijsSpecificatie[2][translate(tia:roerendezakenInclusief, $upper, $lower) = 'false']/tia:roerendezakenWaarde/tia:valuta"/>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test="not(tia:tia_KoopprijsSpecificatie[2][translate(tia:roerendezakenInclusief, $upper, $lower) = 'false']/tia:roerendezakenWaarde)">
							<xsl:call-template name="amountText">
								<xsl:with-param name="amount" select="$stukdeelKoopNext/tia:koopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'false']/tia:roerendezakenWaarde/tia:som"/>
								<xsl:with-param name="valuta" select="$stukdeelKoopNext/tia:koopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'false']/tia:roerendezakenWaarde/tia:valuta"/>
							</xsl:call-template>
							<xsl:text> </xsl:text>
							<xsl:call-template name="amountNumber">
								<xsl:with-param name="amount" select="$stukdeelKoopNext/tia:koopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'false']/tia:roerendezakenWaarde/tia:som"/>
								<xsl:with-param name="valuta" select="$stukdeelKoopNext/tia:koopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'false']/tia:roerendezakenWaarde/tia:valuta"/>
							</xsl:call-template>
						</xsl:when>
					</xsl:choose>
					<xsl:text>. De koopprijs </xsl:text>
					<xsl:if test="translate($registergoederenTonenRoerendeZakenNext, $upper, $lower) = 'true' and count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) = count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederentonenroerendezaken']/tia:tekst, $upper, $lower) = 'true'])">
						<xsl:text>van </xsl:text>
						<xsl:choose>
							<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true'">
								<xsl:text>het Registergoed </xsl:text>
								<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
								<xsl:text> </xsl:text>
							</xsl:when>
							<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
								<xsl:value-of select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst"/>
								<xsl:text> </xsl:text>
							</xsl:when>
						</xsl:choose>
					</xsl:if>
					<xsl:text>wordt met dit bedrag verhoogd. </xsl:text>
					<xsl:if test="$registergoederenOpsommingAangehechtNext = 'true' and count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) = count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederenopsommingaangehecht']/tia:tekst, $upper, $lower) = 'true'])">
						<xsl:text>Van welke roerende zaken een opsomming </xsl:text>
						<xsl:value-of select="$registergoederenOpsommingAangehechtTekstNext"/>
						<xsl:text> gehecht aan deze akte.</xsl:text>
					</xsl:if>
				</p>
			</xsl:when>
			<!-- Variant 2.c Koopprijs 'met inbegrip van een bedrag aan roerende zaken' -->
			<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'roerende zaken inclusief'">
				<p>
					<xsl:text>De koopprijs </xsl:text>
					<xsl:if test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
						<xsl:text>van </xsl:text>
						<xsl:choose>
							<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true'">
								<xsl:text>het Registergoed </xsl:text>
								<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
								<xsl:text> </xsl:text>
							</xsl:when>
							<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
								<xsl:value-of select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst"/>
								<xsl:text> </xsl:text>
							</xsl:when>
						</xsl:choose>
					</xsl:if>
					<xsl:text>die tussen </xsl:text>
					<xsl:value-of select="$partyNameVariantVrijOpNaamNext"/>
					<xsl:text> en </xsl:text>
					<xsl:value-of select="$partyNameVariantKoopAanneemsomNext"/>
					<xsl:text> is overeengekomen, bedraagt: </xsl:text>
					<xsl:apply-templates select="." mode="do-choose-amount-for-variant-x">
						<xsl:with-param name="stukdeelKoop" select="$stukdeelKoopNext"/>
						<xsl:with-param name="bedragKoopprijs" select="descendant-or-self::tia:tia_BedragKoopprijs[2]"/>
					</xsl:apply-templates>
					<xsl:text>. In </xsl:text>
					<xsl:value-of select="$koopprijsLidwoordNext"/>
					<xsl:text> koopprijs is een bedrag van </xsl:text>
					<xsl:choose>
						<xsl:when test="tia:tia_KoopprijsSpecificatie[2][translate(tia:roerendezakenInclusief, $upper, $lower) = 'true']/tia:roerendezakenWaarde">
							<xsl:call-template name="amountText">
								<xsl:with-param name="amount" select="tia:tia_KoopprijsSpecificatie[2][translate(tia:roerendezakenInclusief, $upper, $lower) = 'true']/tia:roerendezakenWaarde/tia:som"/>
								<xsl:with-param name="valuta" select="tia:tia_KoopprijsSpecificatie[2][translate(tia:roerendezakenInclusief, $upper, $lower) = 'true']/tia:roerendezakenWaarde/tia:valuta"/>
							</xsl:call-template>
							<xsl:text> </xsl:text>
							<xsl:call-template name="amountNumber">
								<xsl:with-param name="amount" select="tia:tia_KoopprijsSpecificatie[2][translate(tia:roerendezakenInclusief, $upper, $lower) = 'true']/tia:roerendezakenWaarde/tia:som"/>
								<xsl:with-param name="valuta" select="tia:tia_KoopprijsSpecificatie[2][translate(tia:roerendezakenInclusief, $upper, $lower) = 'true']/tia:roerendezakenWaarde/tia:valuta"/>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test="not(tia:tia_KoopprijsSpecificatie[2][translate(tia:roerendezakenInclusief, $upper, $lower) = 'true']/tia:roerendezakenWaarde)">
							<xsl:call-template name="amountText">
								<xsl:with-param name="amount" select="$stukdeelKoopNext/tia:koopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'true']/tia:roerendezakenWaarde/tia:som"/>
								<xsl:with-param name="valuta" select="$stukdeelKoopNext/tia:koopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'true']/tia:roerendezakenWaarde/tia:valuta"/>
							</xsl:call-template>
							<xsl:text> </xsl:text>
							<xsl:call-template name="amountNumber">
								<xsl:with-param name="amount" select="$stukdeelKoopNext/tia:koopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'true']/tia:roerendezakenWaarde/tia:som"/>
								<xsl:with-param name="valuta" select="$stukdeelKoopNext/tia:koopprijsSpecificatie[translate(tia:roerendezakenInclusief, $upper, $lower) = 'true']/tia:roerendezakenWaarde/tia:valuta"/>
							</xsl:call-template>
						</xsl:when>
					</xsl:choose>
					<xsl:text> voor roerende zaken begrepen. </xsl:text>
					<xsl:if test="$registergoederenOpsommingAangehechtNext = 'true' and count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht) = count($stukdeelLeveringNext/tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederenopsommingaangehecht']/tia:tekst, $upper, $lower) = 'true'])">
						<xsl:text>Van welke roerende zaken een opsomming </xsl:text>
						<xsl:value-of select="$registergoederenOpsommingAangehechtTekstNext"/>
						<xsl:text> gehecht aan deze akte.</xsl:text>
					</xsl:if>
				</p>
			</xsl:when>
			<!-- Variant 2.d Koopprijs 'vrij op naam' -->
			<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'vrij op naam'">
				<p>
					<xsl:text>De koopprijs </xsl:text>
					<xsl:if test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
						<xsl:text>van </xsl:text>
						<xsl:choose>
							<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true'">
								<xsl:text>het Registergoed </xsl:text>
								<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
								<xsl:text> </xsl:text>
							</xsl:when>
							<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
								<xsl:value-of select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst"/>
								<xsl:text> </xsl:text>
							</xsl:when>
						</xsl:choose>
					</xsl:if>
					<xsl:text>die tussen </xsl:text>
					<xsl:value-of select="$partyNameVariantVrijOpNaamNext"/>
					<xsl:text> en </xsl:text>
					<xsl:value-of select="$partyNameVariantKoopAanneemsomNext"/>
					<xsl:text> is overeengekomen, bedraagt: </xsl:text>
					<xsl:apply-templates select="." mode="do-choose-amount-for-variant-x">
						<xsl:with-param name="stukdeelKoop" select="$stukdeelKoopNext"/>
						<xsl:with-param name="bedragKoopprijs" select="descendant-or-self::tia:tia_BedragKoopprijs[2]"/>
					</xsl:apply-templates>
					<xsl:text>, inclusief een bedrag van </xsl:text>
					<xsl:choose>
						<xsl:when test="tia:tia_KoopprijsSpecificatie[2][translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']/tia:omzetbelasting">
							<xsl:call-template name="amountText">
								<xsl:with-param name="amount" select="tia:tia_KoopprijsSpecificatie[2][translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']/tia:omzetbelasting/tia:som"/>
								<xsl:with-param name="valuta" select="tia:tia_KoopprijsSpecificatie[2][translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']/tia:omzetbelasting/tia:valuta"/>
							</xsl:call-template>
							<xsl:text> </xsl:text>
							<xsl:call-template name="amountNumber">
								<xsl:with-param name="amount" select="tia:tia_KoopprijsSpecificatie[2][translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']/tia:omzetbelasting/tia:som"/>
								<xsl:with-param name="valuta" select="tia:tia_KoopprijsSpecificatie[2][translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']/tia:omzetbelasting/tia:valuta"/>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test="not(tia:tia_KoopprijsSpecificatie[2][translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']/tia:omzetbelasting)">
							<xsl:call-template name="amountText">
								<xsl:with-param name="amount" select="$stukdeelKoopNext/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']/tia:omzetbelasting/tia:som"/>
								<xsl:with-param name="valuta" select="$stukdeelKoopNext/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']/tia:omzetbelasting/tia:valuta"/>
							</xsl:call-template>
							<xsl:text> </xsl:text>
							<xsl:call-template name="amountNumber">
								<xsl:with-param name="amount" select="$stukdeelKoopNext/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']/tia:omzetbelasting/tia:som"/>
								<xsl:with-param name="valuta" select="$stukdeelKoopNext/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'true']/tia:omzetbelasting/tia:valuta"/>
							</xsl:call-template>
						</xsl:when>
					</xsl:choose>
					<xsl:text> aan omzetbelasting. De notari&#x00EB;le kosten, de daarover verschuldigde omzetbelasting en het kadastraal recht wegens de levering van </xsl:text>
					<xsl:choose>
						<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true'">
							<xsl:text>het Registergoed </xsl:text>
							<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
							<xsl:text> </xsl:text>
						</xsl:when>
						<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
							<xsl:value-of select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst"/>
							<xsl:text> </xsl:text>
						</xsl:when>
					</xsl:choose>
					<xsl:text>zijn voor rekening van </xsl:text>
					<xsl:value-of select="$partyNameVariantVrijOpNaamNext"/>
					<xsl:text>.</xsl:text>
				</p>
			</xsl:when>
			<!-- Variant 2.e Koopprijs 'exclusief omzetbelasting' -->
			<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'exclusief omzetbelasting'">
				<p>
					<xsl:text>De koopprijs </xsl:text>
					<xsl:if test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
						<xsl:text>van </xsl:text>
						<xsl:choose>
							<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst, $upper, $lower) = 'true'">
								<xsl:text>het Registergoed </xsl:text>
								<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
								<xsl:text> </xsl:text>
							</xsl:when>
							<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst, $upper, $lower) = 'true'">
								<xsl:value-of select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst"/>
								<xsl:text> </xsl:text>
							</xsl:when>
						</xsl:choose>
					</xsl:if>
					<xsl:text>die tussen </xsl:text>
					<xsl:value-of select="$partyNameVariantVrijOpNaamNext"/>
					<xsl:text> en </xsl:text>
					<xsl:value-of select="$partyNameVariantKoopAanneemsomNext"/>
					<xsl:text> is overeengekomen, bedraagt: </xsl:text>
					<xsl:apply-templates select="." mode="do-choose-amount-for-variant-x">
						<xsl:with-param name="stukdeelKoop" select="$stukdeelKoopNext"/>
						<xsl:with-param name="bedragKoopprijs" select="descendant-or-self::tia:tia_BedragKoopprijs[2]"/>
					</xsl:apply-templates>
					<xsl:text>, te vermeerderen met een bedrag van </xsl:text>
					<xsl:choose>
						<xsl:when test="tia:tia_KoopprijsSpecificatie[2][translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']/tia:omzetbelasting">
							<xsl:call-template name="amountText">
								<xsl:with-param name="amount" select="tia:tia_KoopprijsSpecificatie[2][translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']/tia:omzetbelasting/tia:som"/>
								<xsl:with-param name="valuta" select="tia:tia_KoopprijsSpecificatie[2][translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']/tia:omzetbelasting/tia:valuta"/>
							</xsl:call-template>
							<xsl:text> </xsl:text>
							<xsl:call-template name="amountNumber">
								<xsl:with-param name="amount" select="tia:tia_KoopprijsSpecificatie[2][translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']/tia:omzetbelasting/tia:som"/>
								<xsl:with-param name="valuta" select="tia:tia_KoopprijsSpecificatie[2][translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']/tia:omzetbelasting/tia:valuta"/>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test="not(tia:tia_KoopprijsSpecificatie[2][translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']/tia:omzetbelasting)">
							<xsl:call-template name="amountText">
								<xsl:with-param name="amount" select="$stukdeelKoopNext/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']/tia:omzetbelasting/tia:som"/>
								<xsl:with-param name="valuta" select="$stukdeelKoopNext/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']/tia:omzetbelasting/tia:valuta"/>
							</xsl:call-template>
							<xsl:text> </xsl:text>
							<xsl:call-template name="amountNumber">
								<xsl:with-param name="amount" select="$stukdeelKoopNext/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']/tia:omzetbelasting/tia:som"/>
								<xsl:with-param name="valuta" select="$stukdeelKoopNext/tia:koopprijsSpecificatie[translate(tia:omzetbelastingInclusief, $upper, $lower) = 'false']/tia:omzetbelasting/tia:valuta"/>
							</xsl:call-template>
						</xsl:when>
					</xsl:choose>
					<xsl:text> aan omzetbelasting.</xsl:text>
				</p>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-purchase-option
	*********************************************************
	Public: no

	Identity transform: no

	Description: Deed of transfer purchase option.

	Input: tia:IMKAD_AangebodenStuk

	Params: none

	Output: XHTML structure

	Calls:
	(name) capitalizePartyAlias
	(name) amountText
	(name) amountNumber

	Called by:
	(mode) do-deed
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_AangebodenStuk" mode="do-purchase-option">
		<a name="hyp4.purchaseOption" class="location">&#160;</a>
		<!-- Empty default template -->
	</xsl:template>
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_AangebodenStuk[tia:StukdeelKoopoptie]" mode="do-purchase-option">
		<a name="hyp4.purchaseOption" class="location">&#160;</a>
		<h2 class="header">
			<xsl:text>KOOPOPTIE</xsl:text>
		</h2>
		<xsl:for-each select="tia:StukdeelKoopoptie[tia:tia_Volgnummer]">
			<xsl:variable name="vervreemderPartyName">
				<xsl:choose>
					<xsl:when test="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
						<xsl:call-template name="capitalizePartyAlias">
							<xsl:with-param name="party" select="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
						<xsl:call-template name="capitalizePartyAlias">
							<xsl:with-param name="party" select="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]"/>
						</xsl:call-template>
					</xsl:when>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="verkrijgerPartyName">
				<xsl:choose>
					<xsl:when test="../tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]">
						<xsl:value-of select="../tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
					</xsl:when>
					<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]">
						<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
					</xsl:when>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="allZakelijkRechts" select="../tia:StukdeelLevering/tia:IMKAD_ZakelijkRecht"/>
			<xsl:variable name="zakelijkRechtNodes" select="$allZakelijkRechts[concat('#', @id) = current()/tia:RegistergoedRef/@xlink:href]"/>
			<xsl:variable name="registergoedAanduiding" select="$zakelijkRechtNodes[1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst"/>
			<xsl:variable name="registergoedAanduidingHetRegistergoed" select="translate($registergoedAanduiding, $upper, $lower) = 'het registergoed'"/>
			<xsl:variable name="registergoedAanduidingHetVerkochte" select="translate($registergoedAanduiding, $upper, $lower) = 'het verkochte'"/>
			<xsl:variable name="registergoedAanduidingDeRegistergoederen" select="translate($registergoedAanduiding, $upper, $lower) = 'de registergoederen'"/>
			<xsl:variable name="upperCaseRegistergoedVerkochteOrRegistergoederen">
				<xsl:choose>
					<xsl:when test="$registergoedAanduidingHetRegistergoed">
						<xsl:text>het Registergoed</xsl:text>
					</xsl:when>
					<xsl:when test="$registergoedAanduidingHetVerkochte">
						<xsl:text>het Verkochte</xsl:text>
					</xsl:when>
					<xsl:when test="$registergoedAanduidingDeRegistergoederen">
						<xsl:text>de Registergoederen</xsl:text>
					</xsl:when>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="koopoptieRegistergoedVermeldenMetVolgnummer" select="tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopoptieregistergoedvermeldenmetvolgnummer']"/>
			<p>
				<xsl:value-of select="$vervreemderPartyName"/>
				<xsl:text> verleent aan </xsl:text>
				<xsl:value-of select="$verkrijgerPartyName"/>
				<xsl:text>, die zulks voor zich aanneemt, </xsl:text>
				<xsl:if test="tia:aantalJaarRechtKoop and normalize-space(tia:aantalJaarRechtKoop) != '' and number(tia:aantalJaarRechtKoop) > 0">
					<xsl:text>voor de tijd van </xsl:text>
					<xsl:value-of select="kef:convertNumberToText(tia:aantalJaarRechtKoop)"/>
					<xsl:text> jaar te rekenen vanaf heden, </xsl:text>
				</xsl:if>
				<xsl:text>het recht om </xsl:text>
				<xsl:choose>
					<xsl:when test="count($zakelijkRechtNodes) = 1 and $koopoptieRegistergoedVermeldenMetVolgnummer/tia:tekst = 'false'">
						<xsl:value-of select="$upperCaseRegistergoedVerkochteOrRegistergoederen"/>
						<xsl:text> </xsl:text>
					</xsl:when>
					<xsl:when test="count($zakelijkRechtNodes) = 1 and $koopoptieRegistergoedVermeldenMetVolgnummer/tia:tekst = 'true'">
						<xsl:text>het Registergoed </xsl:text>
						<xsl:value-of select="count($zakelijkRechtNodes[1]/preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
						<xsl:text> </xsl:text>
					</xsl:when>
					<xsl:when test="count($zakelijkRechtNodes) > 1 and $koopoptieRegistergoedVermeldenMetVolgnummer/tia:tekst = 'false'">
						<xsl:value-of select="$upperCaseRegistergoedVerkochteOrRegistergoederen"/>
						<xsl:text> </xsl:text>
					</xsl:when>
					<xsl:when test="count($zakelijkRechtNodes) > 1 and $koopoptieRegistergoedVermeldenMetVolgnummer/tia:tekst = 'true'">
						<xsl:text> de Registergoederen </xsl:text>
						<xsl:for-each select="$allZakelijkRechts[concat('#', @id) = current()/tia:RegistergoedRef/@xlink:href]">
							<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
							<xsl:choose>
								<xsl:when test="position() = last() - 1">
									<xsl:text> en </xsl:text>
								</xsl:when>
								<xsl:when test="position() != last()">
									<xsl:text>, </xsl:text>
								</xsl:when>
							</xsl:choose>
						</xsl:for-each>
						<xsl:text> </xsl:text>
					</xsl:when>
				</xsl:choose>
				<xsl:text> te kopen onder de hierna vermelde voorwaarden en bedingen, tegen betaling van </xsl:text>
				<xsl:choose>
					<xsl:when test="tia:bedragRechtKoop/tia:som and normalize-space(tia:bedragRechtKoop/tia:som) != '' and number(tia:bedragRechtKoop/tia:som) > 0">
						<xsl:call-template name="amountText">
							<xsl:with-param name="amount" select="tia:bedragRechtKoop/tia:som"/>
							<xsl:with-param name="valuta" select="tia:bedragRechtKoop/tia:valuta"/>
						</xsl:call-template>
						<xsl:text> </xsl:text>
						<xsl:call-template name="amountNumber">
							<xsl:with-param name="amount" select="tia:bedragRechtKoop/tia:som"/>
							<xsl:with-param name="valuta" select="tia:bedragRechtKoop/tia:valuta"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>een koopprijs welke zal worden vastgesteld door drie deskundigen, te benoemen &#x00E9;&#x00E9;n door ieder van de ondergetekenden en de derde door de beide aldus aangewezen deskundigen samen in onderling overleg, of bij gebreke van eenstemmigheid omtrent de benoeming van deze derde deskundige, door de bevoegde rechter in wiens ressort het verkochte is gelegen op verzoek van de meest gerede partij, dan wel op een wijze als hierna nader omschreven</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:text>.</xsl:text>
			</p>
		</xsl:for-each>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-easements
	*********************************************************
	Public: no

	Identity transform: no

	Description: Deed of transfer easements.

	Input: tia:IMKAD_AangebodenStuk

	Params: none

	Output: XHTML structure

	Calls:
	(name) capitalizePartyAlias
	(name) groupParcels
	(name) groupApartments
	(mode) do-levering-cadastral-identification

	Called by:
	(mode) do-deed
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_AangebodenStuk" mode="do-easements">
		<a name="hyp4.easements" class="location">&#160;</a>
		<!-- Empty default template -->
	</xsl:template>
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_AangebodenStuk[tia:StukdeelErfdienstbaarheid]" mode="do-easements">
		<a name="hyp4.easements" class="location">&#160;</a>
		<h2 class="header">
			<xsl:text>VESTIGING ERFDIENSTBAARHEDEN</xsl:text>
		</h2>
		<xsl:for-each select="tia:StukdeelErfdienstbaarheid[tia:tia_Volgnummer]">
			<xsl:variable name="verkrijgerPartyName">
				<xsl:choose>
					<xsl:when test="../tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]">
						<xsl:value-of select="../tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
					</xsl:when>
					<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]">
						<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
					</xsl:when>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="vervreemderPartyName">
				<xsl:choose>
					<xsl:when test="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
						<xsl:call-template name="capitalizePartyAlias">
							<xsl:with-param name="party" select="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
						<xsl:call-template name="capitalizePartyAlias">
							<xsl:with-param name="party" select="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]"/>
						</xsl:call-template>
					</xsl:when>
				</xsl:choose>
			</xsl:variable>
			<p>
				<xsl:value-of select="$vervreemderPartyName"/>
				<xsl:text> en </xsl:text>
				<xsl:value-of select="$verkrijgerPartyName"/>
				<xsl:text> zijn overeengekomen erfdienstbaarheden te vestigen zoals hierna omschreven. Ter uitvoering van de overeenkomst worden hierbij gevestigd ten behoeve van </xsl:text>
				<xsl:if test="tia:IMKAD_AantekeningKadastraalObject/tia:tenBehoeveVan/tia:IMKAD_Perceel">
					<xsl:variable name="_parcelsOnBehalfOf">
						<xsl:call-template name="groupParcels">
							<xsl:with-param name="parcels" select="tia:IMKAD_AantekeningKadastraalObject/tia:tenBehoeveVan/tia:IMKAD_Perceel"/>
						</xsl:call-template>
					</xsl:variable>
					<xsl:variable name="parcelsOnBehalfOf" select="exslt:node-set($_parcelsOnBehalfOf)"/>
					<xsl:choose>
						<xsl:when test="count(tia:IMKAD_AantekeningKadastraalObject/tia:tenBehoeveVan/tia:IMKAD_Perceel) > 1">
							<xsl:text>de percelen, </xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>het perceel, </xsl:text>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:for-each select="$parcelsOnBehalfOf/groups/group">
						<xsl:apply-templates select="tia:IMKAD_Perceel[1]/tia:kadastraleAanduiding" mode="do-levering-cadastral-identification">
							<xsl:with-param name="sameObjects" select="tia:IMKAD_Perceel[position() > 1]"/>
							<xsl:with-param name="boldLabel" select="'false'"/>
							<xsl:with-param name="displayMunicipalityLabel" select="'false'"/>
							<xsl:with-param name="position" select="position()"/>
							<xsl:with-param name="includeComma" select="'false'"/>
						</xsl:apply-templates>
						<xsl:choose>
							<xsl:when test="position() = last()"/>
							<xsl:when test="position() + 1 = last()">
								<xsl:text> en </xsl:text>
							</xsl:when>
							<xsl:when test="position() + 1 &lt; last()">
								<xsl:text>, </xsl:text>
							</xsl:when>
						</xsl:choose>
					</xsl:for-each>
				</xsl:if>
				<xsl:if test="tia:IMKAD_AantekeningKadastraalObject/tia:tenBehoeveVan/tia:IMKAD_Appartementsrecht">
					<xsl:variable name="_apartmentsOnBehalfOf">
						<xsl:call-template name="groupApartments">
							<xsl:with-param name="apartments" select="tia:IMKAD_AantekeningKadastraalObject/tia:tenBehoeveVan/tia:IMKAD_Appartementsrecht"/>
						</xsl:call-template>
					</xsl:variable>
					<xsl:variable name="apartmentsOnBehalfOf" select="exslt:node-set($_apartmentsOnBehalfOf)"/>
					<xsl:choose>
						<xsl:when test="count(tia:IMKAD_AantekeningKadastraalObject/tia:tenBehoeveVan/tia:IMKAD_Appartementsrecht) > 1">
							<xsl:if test="tia:IMKAD_AantekeningKadastraalObject/tia:tenBehoeveVan/tia:IMKAD_Perceel">
								<xsl:text>, </xsl:text>
							</xsl:if>
							<xsl:text>de appartementsrechten, </xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:if test="tia:IMKAD_AantekeningKadastraalObject/tia:tenBehoeveVan/tia:IMKAD_Perceel">
								<xsl:text> en </xsl:text>
							</xsl:if>
							<xsl:text>het appartementsrecht, </xsl:text>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:for-each select="$apartmentsOnBehalfOf/groups/group">
						<xsl:apply-templates select="tia:IMKAD_Appartementsrecht[1]/tia:kadastraleAanduiding" mode="do-levering-cadastral-identification">
							<xsl:with-param name="sameObjects" select="tia:IMKAD_Appartementsrecht[position() > 1]"/>
							<xsl:with-param name="boldLabel" select="'false'"/>
							<xsl:with-param name="displayMunicipalityLabel" select="'false'"/>
							<xsl:with-param name="position" select="position()"/>
							<xsl:with-param name="includeComma" select="'false'"/>
						</xsl:apply-templates>
						<xsl:choose>
							<xsl:when test="position() = last()"/>
							<xsl:when test="position() + 1 = last()">
								<xsl:text> en </xsl:text>
							</xsl:when>
							<xsl:when test="position() + 1 &lt; last()">
								<xsl:text>, </xsl:text>
							</xsl:when>
						</xsl:choose>
					</xsl:for-each>
				</xsl:if>
				<xsl:text> en ten laste van </xsl:text>
				<xsl:if test="tia:IMKAD_AantekeningKadastraalObject/tia:tenLasteVan/tia:IMKAD_Perceel">
					<xsl:variable name="_parcelsSubjectTo">
						<xsl:call-template name="groupParcels">
							<xsl:with-param name="parcels" select="tia:IMKAD_AantekeningKadastraalObject/tia:tenLasteVan/tia:IMKAD_Perceel"/>
						</xsl:call-template>
					</xsl:variable>
					<xsl:variable name="parcelsSubjectTo" select="exslt:node-set($_parcelsSubjectTo)"/>
					<xsl:choose>
						<xsl:when test="count(tia:IMKAD_AantekeningKadastraalObject/tia:tenLasteVan/tia:IMKAD_Perceel) > 1">
							<xsl:text>de percelen, </xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>het perceel, </xsl:text>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:for-each select="$parcelsSubjectTo/groups/group">
						<xsl:apply-templates select="tia:IMKAD_Perceel[1]/tia:kadastraleAanduiding" mode="do-levering-cadastral-identification">
							<xsl:with-param name="sameObjects" select="tia:IMKAD_Perceel[position() > 1]"/>
							<xsl:with-param name="boldLabel" select="'false'"/>
							<xsl:with-param name="displayMunicipalityLabel" select="'false'"/>
							<xsl:with-param name="position" select="position()"/>
							<xsl:with-param name="includeComma" select="'false'"/>
						</xsl:apply-templates>
						<xsl:choose>
							<xsl:when test="position() = last()"/>
							<xsl:when test="position() + 1 = last()">
								<xsl:text> en </xsl:text>
							</xsl:when>
							<xsl:when test="position() + 1 &lt; last()">
								<xsl:text>, </xsl:text>
							</xsl:when>
						</xsl:choose>
					</xsl:for-each>
				</xsl:if>
				<xsl:if test="tia:IMKAD_AantekeningKadastraalObject/tia:tenLasteVan/tia:IMKAD_Appartementsrecht">
					<xsl:variable name="_apartmentsSubjectTo">
						<xsl:call-template name="groupApartments">
							<xsl:with-param name="apartments" select="tia:IMKAD_AantekeningKadastraalObject/tia:tenLasteVan/tia:IMKAD_Appartementsrecht"/>
						</xsl:call-template>
					</xsl:variable>
					<xsl:variable name="apartmentsSubjectTo" select="exslt:node-set($_apartmentsSubjectTo)"/>
					<xsl:choose>
						<xsl:when test="count(tia:IMKAD_AantekeningKadastraalObject/tia:tenLasteVan/tia:IMKAD_Appartementsrecht) > 1">
							<xsl:if test="tia:IMKAD_AantekeningKadastraalObject/tia:tenLasteVan/tia:IMKAD_Perceel">
								<xsl:text>, </xsl:text>
							</xsl:if>
							<xsl:text>de appartementsrechten, </xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:if test="tia:IMKAD_AantekeningKadastraalObject/tia:tenLasteVan/tia:IMKAD_Perceel">
								<xsl:text> en </xsl:text>
							</xsl:if>
							<xsl:text>het appartementsrecht, </xsl:text>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:for-each select="$apartmentsSubjectTo/groups/group">
						<xsl:apply-templates select="tia:IMKAD_Appartementsrecht[1]/tia:kadastraleAanduiding" mode="do-levering-cadastral-identification">
							<xsl:with-param name="sameObjects" select="tia:IMKAD_Appartementsrecht[position() > 1]"/>
							<xsl:with-param name="boldLabel" select="'false'"/>
							<xsl:with-param name="displayMunicipalityLabel" select="'false'"/>
							<xsl:with-param name="position" select="position()"/>
							<xsl:with-param name="includeComma" select="'false'"/>
						</xsl:apply-templates>
						<xsl:choose>
							<xsl:when test="position() = last()"/>
							<xsl:when test="position() + 1 = last()">
								<xsl:text> en </xsl:text>
							</xsl:when>
							<xsl:when test="position() + 1 &lt; last()">
								<xsl:text>, </xsl:text>
							</xsl:when>
						</xsl:choose>
					</xsl:for-each>
				</xsl:if>
				<xsl:text> de navolgende erfdienstbaarheden: </xsl:text>
				<xsl:value-of select="tia:omschrijving"/>
				<xsl:text>.</xsl:text>
			</p>
		</xsl:for-each>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-qualitative-obligations
	*********************************************************
	Public: no

	Identity transform: no

	Description: Deed of transfer qualitative obligations.

	Input: tia:IMKAD_AangebodenStuk

	Params: none

	Output: XHTML structure

	Calls:
	(name) capitalizePartyAlias
	(name) groupParcels
	(name) groupApartments
	(mode) do-levering-cadastral-identification

	Called by:
	(mode) do-deed
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_AangebodenStuk" mode="do-qualitative-obligations">
		<a name="hyp4.qualitativeObligation" class="location">&#160;</a>
		<!-- Empty default template -->
	</xsl:template>
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_AangebodenStuk[tia:StukdeelKwalitatieveVerplichting]" mode="do-qualitative-obligations">
		<a name="hyp4.qualitativeObligation" class="location">&#160;</a>
		<h2 class="header">
			<xsl:text>VESTIGING KWALITATIEVE VERPLICHTINGEN</xsl:text>
		</h2>
		<xsl:for-each select="tia:StukdeelKwalitatieveVerplichting[tia:tia_Volgnummer]">
			<xsl:variable name="verkrijgerPartyName">
				<xsl:choose>
					<xsl:when test="../tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]">
						<xsl:value-of select="../tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
					</xsl:when>
					<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]">
						<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
					</xsl:when>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="vervreemderPartyName">
				<xsl:choose>
					<xsl:when test="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
						<xsl:call-template name="capitalizePartyAlias">
							<xsl:with-param name="party" select="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
						<xsl:call-template name="capitalizePartyAlias">
							<xsl:with-param name="party" select="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]"/>
						</xsl:call-template>
					</xsl:when>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="belanghebbendePartyName">
				<xsl:choose>
					<xsl:when test="../tia:Partij[@id = substring-after(current()/tia:belanghebbendeRef/@xlink:href, '#')]">
						<xsl:value-of select="../tia:Partij[@id = substring-after(current()/tia:belanghebbendeRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
					</xsl:when>
					<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:belanghebbendeRef/@xlink:href, '#')]">
						<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:belanghebbendeRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
					</xsl:when>
				</xsl:choose>
			</xsl:variable>
			<p>
				<xsl:value-of select="$vervreemderPartyName"/>
				<xsl:text> en </xsl:text>
				<xsl:value-of select="$verkrijgerPartyName"/>
				<xsl:text> zijn overeengekomen kwalitatieve verplichtingen te vestigen zoals hierna omschreven. Ter uitvoering van de overeenkomst worden hierbij gevestigd ten behoeve van </xsl:text>
				<xsl:value-of select="$belanghebbendePartyName"/>
				<xsl:text> en ten laste van </xsl:text>
				<xsl:if test="tia:IMKAD_AantekeningKadastraalObject/tia:tenLasteVan/tia:IMKAD_Perceel">
					<xsl:variable name="_parcelsSubjectTo">
						<xsl:call-template name="groupParcels">
							<xsl:with-param name="parcels" select="tia:IMKAD_AantekeningKadastraalObject/tia:tenLasteVan/tia:IMKAD_Perceel"/>
						</xsl:call-template>
					</xsl:variable>
					<xsl:variable name="parcelsSubjectTo" select="exslt:node-set($_parcelsSubjectTo)"/>
					<xsl:choose>
						<xsl:when test="count(tia:IMKAD_AantekeningKadastraalObject/tia:tenLasteVan/tia:IMKAD_Perceel) > 1">
							<xsl:text>de percelen, </xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>het perceel, </xsl:text>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:for-each select="$parcelsSubjectTo/groups/group">
						<xsl:apply-templates select="tia:IMKAD_Perceel[1]/tia:kadastraleAanduiding" mode="do-levering-cadastral-identification">
							<xsl:with-param name="sameObjects" select="tia:IMKAD_Perceel[position() > 1]"/>
							<xsl:with-param name="boldLabel" select="'false'"/>
							<xsl:with-param name="displayMunicipalityLabel" select="'false'"/>
							<xsl:with-param name="position" select="position()"/>
							<xsl:with-param name="includeComma" select="'false'"/>
						</xsl:apply-templates>
						<xsl:choose>
							<xsl:when test="position() = last()"/>
							<xsl:when test="position() + 1 = last()">
								<xsl:text> en </xsl:text>
							</xsl:when>
							<xsl:when test="position() + 1 &lt; last()">
								<xsl:text>, </xsl:text>
							</xsl:when>
						</xsl:choose>
					</xsl:for-each>
				</xsl:if>
				<xsl:if test="tia:IMKAD_AantekeningKadastraalObject/tia:tenLasteVan/tia:IMKAD_Appartementsrecht">
					<xsl:variable name="_apartmentsSubjectTo">
						<xsl:call-template name="groupApartments">
							<xsl:with-param name="apartments" select="tia:IMKAD_AantekeningKadastraalObject/tia:tenLasteVan/tia:IMKAD_Appartementsrecht"/>
						</xsl:call-template>
					</xsl:variable>
					<xsl:variable name="apartmentsSubjectTo" select="exslt:node-set($_apartmentsSubjectTo)"/>
					<xsl:choose>
						<xsl:when test="count(tia:IMKAD_AantekeningKadastraalObject/tia:tenLasteVan/tia:IMKAD_Appartementsrecht) > 1">
							<xsl:if test="tia:IMKAD_AantekeningKadastraalObject/tia:tenLasteVan/tia:IMKAD_Perceel">
								<xsl:text>, </xsl:text>
							</xsl:if>
							<xsl:text>de appartementsrechten, </xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:if test="tia:IMKAD_AantekeningKadastraalObject/tia:tenLasteVan/tia:IMKAD_Perceel">
								<xsl:text> en </xsl:text>
							</xsl:if>
							<xsl:text>het appartementsrecht, </xsl:text>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:for-each select="$apartmentsSubjectTo/groups/group">
						<xsl:apply-templates select="tia:IMKAD_Appartementsrecht[1]/tia:kadastraleAanduiding" mode="do-levering-cadastral-identification">
							<xsl:with-param name="sameObjects" select="tia:IMKAD_Appartementsrecht[position() > 1]"/>
							<xsl:with-param name="boldLabel" select="'false'"/>
							<xsl:with-param name="displayMunicipalityLabel" select="'false'"/>
							<xsl:with-param name="position" select="position()"/>
							<xsl:with-param name="includeComma" select="'false'"/>
						</xsl:apply-templates>
						<xsl:choose>
							<xsl:when test="position() = last()"/>
							<xsl:when test="position() + 1 = last()">
								<xsl:text> en </xsl:text>
							</xsl:when>
							<xsl:when test="position() + 1 &lt; last()">
								<xsl:text>, </xsl:text>
							</xsl:when>
						</xsl:choose>
					</xsl:for-each>
				</xsl:if>
				<xsl:text> de navolgende kwalitatieve verplichtingen: </xsl:text>
				<xsl:value-of select="tia:omschrijving"/>
				<xsl:text>. </xsl:text>
			</p>
		</xsl:for-each>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-common-ownership
	*********************************************************
	Public: no

	Identity transform: no

	Description: Deed of transfer common ownership.

	Input: tia:IMKAD_AangebodenStuk

	Params: none

	Output: XHTML structure

	Calls:
	(name) capitalizePartyAlias
	(name) groupParcels
	(name) groupApartments
	(mode) do-levering-cadastral-identification

	Called by:
	(mode) do-deed
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_AangebodenStuk" mode="do-common-ownership">
		<a name="hyp4.commonOwnership" class="location">&#160;</a>
		<!-- Empty default template -->
	</xsl:template>
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_AangebodenStuk[tia:StukdeelMandeligheid]" mode="do-common-ownership">
		<a name="hyp4.commonOwnership" class="location">&#160;</a>
		<h2 class="header">
			<xsl:text>BESTEMD TOT MANDELIGHEID</xsl:text>
		</h2>
		<xsl:for-each select="tia:StukdeelMandeligheid[tia:tia_Volgnummer]">
			<xsl:variable name="verkrijgerPartyName">
				<xsl:choose>
					<xsl:when test="../tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]">
						<xsl:value-of select="../tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
					</xsl:when>
					<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]">
						<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
					</xsl:when>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="vervreemderPartyName">
				<xsl:choose>
					<xsl:when test="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
						<xsl:call-template name="capitalizePartyAlias">
							<xsl:with-param name="party" select="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
						<xsl:call-template name="capitalizePartyAlias">
							<xsl:with-param name="party" select="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]"/>
						</xsl:call-template>
					</xsl:when>
				</xsl:choose>
			</xsl:variable>
			<p>
				<xsl:value-of select="$vervreemderPartyName"/>
				<xsl:text> en </xsl:text>
				<xsl:value-of select="$verkrijgerPartyName"/>
				<xsl:text> zijn overeengekomen dat </xsl:text>
				<xsl:choose>
					<xsl:when test="count(tia:IMKAD_AantekeningKadastraalObject/tia:tenLasteVan) > 1">
						<xsl:text>de hierna te vermelden objecten worden</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>het hierna te vermelden object wordt</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:text> bestemd tot gemeenschappelijk nut als bedoeld in artikel 5:60 van het Burgerlijk Wetboek ten behoeve van </xsl:text>
				<xsl:if test="tia:IMKAD_AantekeningKadastraalObject/tia:tenBehoeveVan/tia:IMKAD_Perceel">
					<xsl:variable name="_parcelsOnBehalfOf">
						<xsl:call-template name="groupParcels">
							<xsl:with-param name="parcels" select="tia:IMKAD_AantekeningKadastraalObject/tia:tenBehoeveVan/tia:IMKAD_Perceel"/>
						</xsl:call-template>
					</xsl:variable>
					<xsl:variable name="parcelsOnBehalfOf" select="exslt:node-set($_parcelsOnBehalfOf)"/>
					<xsl:choose>
						<xsl:when test="count(tia:IMKAD_AantekeningKadastraalObject/tia:tenBehoeveVan/tia:IMKAD_Perceel) > 1">
							<xsl:text>de percelen, </xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>het perceel, </xsl:text>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:for-each select="$parcelsOnBehalfOf/groups/group">
						<xsl:apply-templates select="tia:IMKAD_Perceel[1]/tia:kadastraleAanduiding" mode="do-levering-cadastral-identification">
							<xsl:with-param name="sameObjects" select="tia:IMKAD_Perceel[position() > 1]"/>
							<xsl:with-param name="boldLabel" select="'false'"/>
							<xsl:with-param name="displayMunicipalityLabel" select="'false'"/>
							<xsl:with-param name="position" select="position()"/>
							<xsl:with-param name="includeComma" select="'false'"/>
						</xsl:apply-templates>
						<xsl:choose>
							<xsl:when test="position() = last()"/>
							<xsl:when test="position() + 1 = last()">
								<xsl:text> en </xsl:text>
							</xsl:when>
							<xsl:when test="position() + 1 &lt; last()">
								<xsl:text>, </xsl:text>
							</xsl:when>
						</xsl:choose>
					</xsl:for-each>
				</xsl:if>
				<xsl:if test="tia:IMKAD_AantekeningKadastraalObject/tia:tenBehoeveVan/tia:IMKAD_Appartementsrecht">
					<xsl:variable name="_apartmentsOnBehalfOf">
						<xsl:call-template name="groupApartments">
							<xsl:with-param name="apartments" select="tia:IMKAD_AantekeningKadastraalObject/tia:tenBehoeveVan/tia:IMKAD_Appartementsrecht"/>
						</xsl:call-template>
					</xsl:variable>
					<xsl:variable name="apartmentsOnBehalfOf" select="exslt:node-set($_apartmentsOnBehalfOf)"/>
					<xsl:choose>
						<xsl:when test="count(tia:IMKAD_AantekeningKadastraalObject/tia:tenBehoeveVan/tia:IMKAD_Appartementsrecht) > 1">
							<xsl:if test="tia:IMKAD_AantekeningKadastraalObject/tia:tenBehoeveVan/tia:IMKAD_Perceel">
								<xsl:text>, </xsl:text>
							</xsl:if>
							<xsl:text>de appartementsrechten, </xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:if test="tia:IMKAD_AantekeningKadastraalObject/tia:tenBehoeveVan/tia:IMKAD_Perceel">
								<xsl:text> en </xsl:text>
							</xsl:if>
							<xsl:text>het appartementsrecht, </xsl:text>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:for-each select="$apartmentsOnBehalfOf/groups/group">
						<xsl:apply-templates select="tia:IMKAD_Appartementsrecht[1]/tia:kadastraleAanduiding" mode="do-levering-cadastral-identification">
							<xsl:with-param name="sameObjects" select="tia:IMKAD_Appartementsrecht[position() > 1]"/>
							<xsl:with-param name="boldLabel" select="'false'"/>
							<xsl:with-param name="displayMunicipalityLabel" select="'false'"/>
							<xsl:with-param name="position" select="position()"/>
							<xsl:with-param name="includeComma" select="'false'"/>
						</xsl:apply-templates>
						<xsl:choose>
							<xsl:when test="position() = last()"/>
							<xsl:when test="position() + 1 = last()">
								<xsl:text> en </xsl:text>
							</xsl:when>
							<xsl:when test="position() + 1 &lt; last()">
								<xsl:text>, </xsl:text>
							</xsl:when>
						</xsl:choose>
					</xsl:for-each>
				</xsl:if>
				<xsl:text> en ten laste van </xsl:text>
				<xsl:if test="tia:IMKAD_AantekeningKadastraalObject/tia:tenLasteVan/tia:IMKAD_Perceel">
					<xsl:variable name="_parcelsSubjectTo">
						<xsl:call-template name="groupParcels">
							<xsl:with-param name="parcels" select="tia:IMKAD_AantekeningKadastraalObject/tia:tenLasteVan/tia:IMKAD_Perceel"/>
						</xsl:call-template>
					</xsl:variable>
					<xsl:variable name="parcelsSubjectTo" select="exslt:node-set($_parcelsSubjectTo)"/>
					<xsl:choose>
						<xsl:when test="count(tia:IMKAD_AantekeningKadastraalObject/tia:tenLasteVan/tia:IMKAD_Perceel) > 1">
							<xsl:text>de percelen, </xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>het perceel, </xsl:text>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:for-each select="$parcelsSubjectTo/groups/group">
						<xsl:apply-templates select="tia:IMKAD_Perceel[1]/tia:kadastraleAanduiding" mode="do-levering-cadastral-identification">
							<xsl:with-param name="sameObjects" select="tia:IMKAD_Perceel[position() > 1]"/>
							<xsl:with-param name="boldLabel" select="'false'"/>
							<xsl:with-param name="displayMunicipalityLabel" select="'false'"/>
							<xsl:with-param name="position" select="position()"/>
							<xsl:with-param name="includeComma" select="'false'"/>
						</xsl:apply-templates>
						<xsl:choose>
							<xsl:when test="position() = last()"/>
							<xsl:when test="position() + 1 = last()">
								<xsl:text> en </xsl:text>
							</xsl:when>
							<xsl:when test="position() + 1 &lt; last()">
								<xsl:text>, </xsl:text>
							</xsl:when>
						</xsl:choose>
					</xsl:for-each>
				</xsl:if>
				<xsl:if test="tia:IMKAD_AantekeningKadastraalObject/tia:tenLasteVan/tia:IMKAD_Appartementsrecht">
					<xsl:variable name="_apartmentsSubjectTo">
						<xsl:call-template name="groupApartments">
							<xsl:with-param name="apartments" select="tia:IMKAD_AantekeningKadastraalObject/tia:tenLasteVan/tia:IMKAD_Appartementsrecht"/>
						</xsl:call-template>
					</xsl:variable>
					<xsl:variable name="apartmentsSubjectTo" select="exslt:node-set($_apartmentsSubjectTo)"/>
					<xsl:choose>
						<xsl:when test="count(tia:IMKAD_AantekeningKadastraalObject/tia:tenLasteVan/tia:IMKAD_Appartementsrecht) > 1">
							<xsl:if test="tia:IMKAD_AantekeningKadastraalObject/tia:tenLasteVan/tia:IMKAD_Perceel">
								<xsl:text>, </xsl:text>
							</xsl:if>
							<xsl:text>de appartementsrechten, </xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:if test="tia:IMKAD_AantekeningKadastraalObject/tia:tenLasteVan/tia:IMKAD_Perceel">
								<xsl:text> en </xsl:text>
							</xsl:if>
							<xsl:text>het appartementsrecht, </xsl:text>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:for-each select="$apartmentsSubjectTo/groups/group">
						<xsl:apply-templates select="tia:IMKAD_Appartementsrecht[1]/tia:kadastraleAanduiding" mode="do-levering-cadastral-identification">
							<xsl:with-param name="sameObjects" select="tia:IMKAD_Appartementsrecht[position() > 1]"/>
							<xsl:with-param name="boldLabel" select="'false'"/>
							<xsl:with-param name="displayMunicipalityLabel" select="'false'"/>
							<xsl:with-param name="position" select="position()"/>
							<xsl:with-param name="includeComma" select="'false'"/>
						</xsl:apply-templates>
						<xsl:choose>
							<xsl:when test="position() = last()"/>
							<xsl:when test="position() + 1 = last()">
								<xsl:text> en </xsl:text>
							</xsl:when>
							<xsl:when test="position() + 1 &lt; last()">
								<xsl:text>, </xsl:text>
							</xsl:when>
						</xsl:choose>
					</xsl:for-each>
				</xsl:if>
				<xsl:text>. Met betrekking tot deze mandeligheid zijn de volgende bepalingen overeengekomen: </xsl:text>
				<xsl:value-of select="tia:omschrijving"/>
				<xsl:text>. </xsl:text>
			</p>
		</xsl:for-each>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-election-of-domicile
	*********************************************************
	Public: no

	Identity transform: no

	Description: Deed of transfer election of domicile.

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
	<xsl:template match="tia:IMKAD_AangebodenStuk" mode="do-election-of-domicile">
		<xsl:variable name="woonplaatskeuze" select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_woonplaatskeuze']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_woonplaatskeuze']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_woonplaatskeuze']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
		<a name="hyp4.electionOfDomicile" class="location">&#160;</a>
		<xsl:if test="$woonplaatskeuze != ''">
			<h2 class="header">
				<u>
					<xsl:text>WOONPLAATSKEUZE</xsl:text>
				</u>
			</h2>
			<p>
				<xsl:value-of select="$woonplaatskeuze"/>
			</p>
		</xsl:if>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-energy-performance-certificate
	*********************************************************
	Public: no

	Identity transform: no

	Description: Deed of transfer energy performance certificate.

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
	<xsl:template match="tia:IMKAD_AangebodenStuk" mode="do-energy-performance-certificate">
		<xsl:variable name="alienatorPartyName" select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
		<xsl:variable name="acquirerPartyName">
			<xsl:choose>
				<xsl:when test="tia:tia_StukVariant = 'Standaardlevering'">
					<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
				</xsl:when>
				<xsl:when test="tia:tia_StukVariant = 'Twee leveringen'">
					<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
				</xsl:when>
				<xsl:when test="tia:tia_StukVariant = 'Verkoop rechten met cessie'">
					<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
				</xsl:when>
				<xsl:when test="tia:tia_StukVariant = 'Verkoop rechten met indeplaatsstelling'">
					<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
				</xsl:when>
				<xsl:when test="tia:StukdeelLevering[tia:IMKAD_ZakelijkRecht]">
					<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
				</xsl:when>
			</xsl:choose>
		</xsl:variable>
	</xsl:template>
	<!--
	*********************************************************
	Name: capitalizePartyAlias
	*********************************************************
	Public: no

	Discription: Capitalizes first letter of party alias.

	Params: party - partyNode (tia:Partij)

	Output: text

	Calls:
	none

	Called by:
	(mode) do-purchase-and-transfer
	(mode) do-purchase-option
	(mode) do-easements
	(mode) do-qualitative-obligations
	(mode) do-common-ownership
	-->
	<!--
	**** named template ********************************************************************************
	-->
	<xsl:template name="capitalizePartyAlias">
		<xsl:param name="party"/>
		<xsl:value-of select="concat(translate(substring($party/tia:aanduidingPartij, 1, 1), $lower, $upper), substring($party/tia:aanduidingPartij, 2))"/>
	</xsl:template>
	<!--
	*********************************************************
	Name: groupParcels
	*********************************************************
	Public: no

	Discription: Creates groups of parcels (nodes tia:IMKAD_Perceel) with the same cadastral district and the same section.

	Params: parcels - node set containing tia:IMKAD_Perceel nodes with the same cadastral district and the same section; default is empty node set

	Output: Tree fragment:
			<groups xmlns="">
				<group xmlns="">
					<tia:IMKAD_Perceel />
					...
				</group>
				...
			</groups>

	Calls:
	none

	Called by:
	(mode) do-easements
	(mode) do-qualitative-obligations
	(mode) do-common-ownership
	-->
	<!--
	**** named template ********************************************************************************
	-->
	<xsl:template name="groupParcels">
		<xsl:param name="parcels" select="self::node()[false()]"/>
		<groups xmlns="">
			<xsl:for-each select="$parcels">
				<xsl:if test="not(parent::*/preceding-sibling::*[name() = name(current()/parent::*)]/tia:IMKAD_Perceel[
						tia:kadastraleAanduiding/tia:gemeente = current()/tia:kadastraleAanduiding/tia:gemeente
						and tia:kadastraleAanduiding/tia:sectie = current()/tia:kadastraleAanduiding/tia:sectie])">
					<group xmlns="">
						<xsl:copy-of select=". | parent::*/following-sibling::*[name() = name(current()/parent::*)]/tia:IMKAD_Perceel[
							tia:kadastraleAanduiding/tia:gemeente = current()/tia:kadastraleAanduiding/tia:gemeente
							and tia:kadastraleAanduiding/tia:sectie = current()/tia:kadastraleAanduiding/tia:sectie]"/>
					</group>
				</xsl:if>
			</xsl:for-each>
		</groups>
	</xsl:template>
	<!--
	*********************************************************
	Name: groupApartments
	*********************************************************
	Public: no

	Discription: Creates groups of apartments (nodes tia:IMKAD_Appartementsrecht) with the same cadastral district, section and complex identification.

	Params: apartments - node set containing tia:IMKAD_Appartementsrecht nodes with the same cadastral district, section and complex identification; default is empty node set

	Output: Tree fragment:
			<groups xmlns="">
				<group xmlns="">
					<tia:IMKAD_Appartementsrecht />
					...
				</group>
				...
			</groups>

	Calls:
	none

	Called by:
	(mode) do-easements
	(mode) do-qualitative-obligations
	(mode) do-common-ownership
	-->
	<!--
	**** named template ********************************************************************************
	-->
	<xsl:template name="groupApartments">
		<xsl:param name="apartments" select="self::node()[false()]"/>
		<groups xmlns="">
			<xsl:for-each select="$apartments">
				<xsl:if test="not(parent::*/preceding-sibling::*[name() = name(current()/parent::*)]/tia:IMKAD_Appartementsrecht[
						tia:kadastraleAanduiding/tia:gemeente = current()/tia:kadastraleAanduiding/tia:gemeente
						and tia:kadastraleAanduiding/tia:sectie = current()/tia:kadastraleAanduiding/tia:sectie
						and tia:kadastraleAanduiding/tia:perceelnummer = current()/tia:kadastraleAanduiding/tia:perceelnummer])">
					<group xmlns="">
						<xsl:copy-of select=". | parent::*/following-sibling::*[name() = name(current()/parent::*)]/tia:IMKAD_Appartementsrecht[
							tia:kadastraleAanduiding/tia:gemeente = current()/tia:kadastraleAanduiding/tia:gemeente
							and tia:kadastraleAanduiding/tia:sectie = current()/tia:kadastraleAanduiding/tia:sectie
							and tia:kadastraleAanduiding/tia:perceelnummer = current()/tia:kadastraleAanduiding/tia:perceelnummer]"/>
					</group>
				</xsl:if>
			</xsl:for-each>
		</groups>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-assignment-directors-associattion-of-owners
	*********************************************************

	Public: no

	Identity transform: no

	Description: Assignment directors association of owners.

	Input: tia:IMKAD_AangebodenStuk

	Params: none

	Output: XHTML structure

	Calls:
	(name) do-opgave_bestuur_vve-one
	(name) do-opgave_bestuur_vve-two-separate
	(name) do-opgave_bestuur_vve-two-group

	Called by:
	(mode) do-deed
	-->
	<!--
	**** named template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_AangebodenStuk" mode="do-assignment-directors-associattion-of-owners">
		<a name="hyp4.purchaseOption" class="location">&#160;</a>
		<xsl:if test="tia:StukdeelLevering/tia:IMKAD_ZakelijkRecht[tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_opgavebestuurvve']/tia:tekst = 'true']">
			<h2 class="header">
				<xsl:text>OPGAVE BESTUUR VERENIGING VAN EIGENAARS</xsl:text>
			</h2>
			<xsl:for-each select="tia:StukdeelLevering[tia:IMKAD_ZakelijkRecht]">
				<xsl:variable name="stukdeelLeveringVolgnummerNumber" select="number(current()/tia:tia_Volgnummer)"/>
				<xsl:variable name="stukdeelKoopVolgnummer">
					<xsl:choose>
						<!-- Variant 3: Verkoop rechten uit koopovereenkomst met cessie, Variant 4: Verkoop rechten uit koopovereenkomst met indeplaatsstelling -->
						<xsl:when test="translate(../tia:tia_StukVariant, $upper, $lower) = 'verkoop rechten met cessie' or translate(../tia:tia_StukVariant, $upper, $lower) = 'verkoop rechten met indeplaatsstelling'">
							<xsl:value-of select="../tia:StukdeelKoop[tia:tia_Volgnummer = format-number(($stukdeelLeveringVolgnummerNumber * number('2') - number('1')), '0')]/tia:tia_Volgnummer"/>
						</xsl:when>
						<!-- Variant 1: Standaardlevering, Variant 2: Twee leveringen -->
						<xsl:otherwise>
							<xsl:value-of select="../tia:StukdeelKoop[tia:tia_Volgnummer = current()/tia:tia_Volgnummer]/tia:tia_Volgnummer"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<xsl:variable name="stukdeelKoop" select="../tia:StukdeelKoop[tia:tia_Volgnummer = $stukdeelKoopVolgnummer]"/>
				<xsl:variable name="registergoedAanduidingHetRegistergoed" select="tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst, $upper, $lower) = 'het registergoed']"/>
				<xsl:variable name="registergoedAanduidingHetVerkochte" select="tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst, $upper, $lower) = 'het verkochte']"/>
				<xsl:variable name="registergoedAanduidingDeRegistergoederen" select="tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst, $upper, $lower) = 'de registergoederen']"/>
				<xsl:variable name="registergoedAanduidingHetRegistergoedText" select="$registergoedAanduidingHetRegistergoed[1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst"/>
				<xsl:variable name="registergoedAanduidingHetVerkochteText" select="$registergoedAanduidingHetVerkochte[1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst"/>
				<xsl:variable name="registergoedAanduidingDeRegistergoederenText" select="$registergoedAanduidingDeRegistergoederen[1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst"/>
				<xsl:variable name="numberOpgavebestuurvvetekstOne" select="count(tia:IMKAD_ZakelijkRecht[tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_opgavebestuurvve']/tia:tekst = 'true'
						and tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_opgavebestuurvvetekst']/tia:tekst = '1'][1]/preceding::tia:IMKAD_ZakelijkRecht)"/>
				<xsl:variable name="numberOpgavebestuurvvetekstTwo" select="count(tia:IMKAD_ZakelijkRecht[tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_opgavebestuurvve']/tia:tekst = 'true'
						and tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_opgavebestuurvvetekst']/tia:tekst = '2'
						and tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_vveregistergoedvermelden']/tia:tekst = 'true'][1]/preceding::tia:IMKAD_ZakelijkRecht)"/>
				<xsl:variable name="numberOfOpgavebestuurvvetekstTwoGroup" select="count(tia:IMKAD_ZakelijkRecht[tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_opgavebestuurvve']/tia:tekst = 'true'
						and tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_opgavebestuurvvetekst']/tia:tekst = '2'
						and not(tia:tia_KoopprijsSpecificatie/tia:vveReservefondssom)
						and tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_vveregistergoedvermelden']/tia:tekst = 'true'])"/>
				<xsl:variable name="numberOpgavebestuurvvetekstTwoGroup" select="count(tia:IMKAD_ZakelijkRecht[tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_opgavebestuurvve']/tia:tekst = 'true'
						and tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_opgavebestuurvvetekst']/tia:tekst = '2'
						and not(tia:tia_KoopprijsSpecificatie/tia:vveReservefondssom)
						and tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_vveregistergoedvermelden']/tia:tekst = 'true'][1]/preceding::tia:IMKAD_ZakelijkRecht)"/>
				<xsl:for-each select="tia:IMKAD_ZakelijkRecht">
					<xsl:choose>
						<!-- Registergoed k_opgavebestuurvvetekst=1-->
						<xsl:when test="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_opgavebestuurvvetekst']/tia:tekst = '1'
								and $numberOpgavebestuurvvetekstOne = count(current()/preceding::tia:IMKAD_ZakelijkRecht)">
							<xsl:apply-templates select=".." mode="do-opgave_bestuur_vve-one"/>
						</xsl:when>
						<!-- Registergoed k_opgavebestuurvvetekst=2 and have tia_KoopprijsSpecificatie -->
						<xsl:when test="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_opgavebestuurvvetekst']/tia:tekst = '2'
								and tia:tia_KoopprijsSpecificatie/tia:vveReservefondssom
								and ($numberOfOpgavebestuurvvetekstTwoGroup = 0
									or ($numberOfOpgavebestuurvvetekstTwoGroup > 0 and not($numberOpgavebestuurvvetekstTwoGroup = count(current()/preceding::tia:IMKAD_ZakelijkRecht))))">
							<xsl:apply-templates select="." mode="do-opgave_bestuur_vve-two-separate">
								<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
							</xsl:apply-templates>
						</xsl:when>
						<!-- Registergoed k_opgavebestuurvvetekst=2 and doesn't have tia_KoopprijsSpecificatie -->
						<xsl:when test="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_opgavebestuurvvetekst']/tia:tekst = '2'
								and not(tia:tia_KoopprijsSpecificatie/tia:vveReservefondssom)
								and $numberOpgavebestuurvvetekstTwoGroup = count(current()/preceding::tia:IMKAD_ZakelijkRecht)">
							<xsl:apply-templates select=".." mode="do-opgave_bestuur_vve-two-group">
								<xsl:with-param name="stukdeelKoop" select="$stukdeelKoop"/>
							</xsl:apply-templates>
						</xsl:when>
					</xsl:choose>
				</xsl:for-each>
			</xsl:for-each>
		</xsl:if>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-opgave_bestuur_vve-one
	*********************************************************
	Public: no

	Identity transform: no

	Description: Case k_OpgaveBestuurVveTekst = 1 - print first text

	Input: tia:StukdeelLevering

	Params: none

	Output: XHTML structure

	Calls:
	none

	Called by:
	(mode) do-assignment-directors-associattion-of-owners
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:StukdeelLevering" mode="do-opgave_bestuur_vve-one">
		<xsl:variable name="registergoedAanduiding" select="normalize-space(tia:IMKAD_ZakelijkRecht[tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_opgavebestuurvve']/tia:tekst = 'true'
				and tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_opgavebestuurvvetekst']/tia:tekst = '1'
				and tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_vveregistergoedvermelden']/tia:tekst = 'true']/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst)"/>
		<xsl:variable name="countTrueVVERegistergoedVermelden" select="count(tia:IMKAD_ZakelijkRecht[tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_opgavebestuurvve']/tia:tekst = 'true'
				and tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_opgavebestuurvvetekst']/tia:tekst = '1'
				and tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_vveregistergoedvermelden']/tia:tekst = 'true'])"/>
		<xsl:variable name="countTrueVVERegistergoedVermeldenMetVolgnummer" select="count(tia:IMKAD_ZakelijkRecht[tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_opgavebestuurvve']/tia:tekst = 'true'
				and tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_opgavebestuurvvetekst']/tia:tekst = '1'
				and tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_vveregistergoedvermelden']/tia:tekst = 'true']/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_vveregistergoedvermeldenmetvolgnummer'
				and tia:tekst = 'true'])"/>
		<xsl:if test="tia:IMKAD_ZakelijkRecht[tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_opgavebestuurvvetekst']/tia:tekst = '1'
				and tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_opgavebestuurvve']/tia:tekst = 'true']">
			<p>
				<xsl:text>Uit een aan deze akte </xsl:text>
				<xsl:value-of select="tia:IMKAD_ZakelijkRecht[tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_opgavebestuurvvetekst']/tia:tekst = '1']/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_opgavebestuurvvegehechte']/tia:tekst"/>
				<xsl:text> opgave van/namens het bestuur van de vereniging van eigenaars, blijkt </xsl:text>
				<xsl:if test="tia:IMKAD_ZakelijkRecht[tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_opgavebestuurvve']/tia:tekst = 'true'
						and tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_opgavebestuurvvetekst']/tia:tekst = '1']/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_vveregistergoedvermelden']/tia:tekst = 'true'">
					<xsl:text>met betrekking tot </xsl:text>
					<xsl:choose>
						<xsl:when test="$countTrueVVERegistergoedVermeldenMetVolgnummer > 1">
							<xsl:text>de Registergoederen </xsl:text>
							<xsl:for-each select="tia:IMKAD_ZakelijkRecht[tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_opgavebestuurvve']/tia:tekst = 'true'
									and tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_opgavebestuurvvetekst']/tia:tekst = '1'
									and tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_vveregistergoedvermelden']/tia:tekst = 'true'
									and tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_vveregistergoedvermeldenmetvolgnummer']/tia:tekst = 'true']">
								<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
								<xsl:choose>
									<xsl:when test="position() = last() - 1">
										<xsl:text> en </xsl:text>
									</xsl:when>
									<xsl:when test="position() != last()">
										<xsl:text>, </xsl:text>
									</xsl:when>
								</xsl:choose>
							</xsl:for-each>
						</xsl:when>
						<xsl:when test="$countTrueVVERegistergoedVermeldenMetVolgnummer = 1">
							<xsl:text>het Registergoed </xsl:text>
							<xsl:if test="$countTrueVVERegistergoedVermeldenMetVolgnummer = 1">
								<xsl:value-of select="count(tia:IMKAD_ZakelijkRecht[tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_opgavebestuurvve']/tia:tekst = 'true'
										and tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_opgavebestuurvvetekst']/tia:tekst = '1'
										and tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_vveregistergoedvermelden']/tia:tekst = 'true'
										and tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_vveregistergoedvermeldenmetvolgnummer']/tia:tekst = 'true']/preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
								<xsl:text> </xsl:text>
							</xsl:if>
						</xsl:when>
						<xsl:when test="$registergoedAanduiding">
							<xsl:value-of select="$registergoedAanduiding"/>
						</xsl:when>
					</xsl:choose>
					<xsl:text> </xsl:text>
				</xsl:if>
				<xsl:text>dat het reservefonds van de vereniging nihil bedraagt.</xsl:text>
			</p>
		</xsl:if>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-opgave_bestuur_vve-two-separate
	*********************************************************
	Public: no

	Identity transform: no

	Description: k_OpgaveBestuurVveTekst = 2, print separate, one Registergoed which have amount per Registergoed

	Input: tia:StukdeelLevering

	Params: stukdeelKoop

	Output: XHTML structure

	Calls:
	(name) amountText
	(name) amountNumber

	Called by:
	(mode) do-assignment-directors-associattion-of-owners
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_ZakelijkRecht" mode="do-opgave_bestuur_vve-two-separate">
		<xsl:param name="stukdeelKoop" select="self::node()[false()]"/>
		<xsl:variable name="registergoedAanduidingText" select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst"/>
		<p>
			<xsl:text>In de koopprijs </xsl:text>
			<xsl:if test="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_vveregistergoedvermelden']/tia:tekst = 'true'">
				<xsl:text>van </xsl:text>
				<xsl:choose>
					<xsl:when test="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_vveregistergoedvermeldenmetvolgnummer']/tia:tekst = 'true'">
						<xsl:text>het Registergoed </xsl:text>
						<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
						<xsl:text> </xsl:text>
					</xsl:when>
					<xsl:when test="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_vveregistergoedvermeldenmetvolgnummer']/tia:tekst = 'false'">
						<xsl:value-of select="$registergoedAanduidingText"/>
						<xsl:text> </xsl:text>
					</xsl:when>
				</xsl:choose>
			</xsl:if>
			<xsl:text>is begrepen het aandeel van </xsl:text>
			<xsl:variable name="volgnummerStukdeelLevering">
				<xsl:value-of select="number(../tia:tia_Volgnummer) - 1"/>
			</xsl:variable>
			<xsl:variable name="partijNaam">
				<xsl:choose>
					<xsl:when test="$SoortLevering = 'Twee leveringen'">
						<xsl:choose>
							<xsl:when test="../../tia:Partij[@id = substring-after(current()/../../tia:StukdeelLevering[tia:tia_Volgnummer=$volgnummerStukdeelLevering]/tia:vervreemderRechtRef/@xlink:href, '#')]">
								<xsl:value-of select="../../tia:Partij[@id = substring-after(current()/../../tia:StukdeelLevering[tia:tia_Volgnummer=$volgnummerStukdeelLevering]/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
							</xsl:when>
							<xsl:when test="../../tia:Partij/tia:Partij[@id = substring-after(current()/../../comment()[tia:tia_Volgnummer=$volgnummerStukdeelLevering]/tia:vervreemderRechtRef/@xlink:href, '#')]">
								<xsl:value-of select="../../tia:Partij/tia:Partij[@id = substring-after(current()/../../tia:StukdeelLevering[tia:tia_Volgnummer=$volgnummerStukdeelLevering]/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
							</xsl:when>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="../../tia:Partij[@id = substring-after(current()/../tia:vervreemderRechtRef/@xlink:href, '#')]">
								<xsl:value-of select="../../tia:Partij[@id = substring-after(current()/../tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
							</xsl:when>
							<xsl:when test="../../tia:Partij/tia:Partij[@id = substring-after(current()/../tia:vervreemderRechtRef/@xlink:href, '#')]">
								<xsl:value-of select="../../tia:Partij/tia:Partij[@id = substring-after(current()/../tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
							</xsl:when>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:value-of select="$partijNaam"/>
			<xsl:text> groot </xsl:text>
			<!-- Print amount -->
			<xsl:choose>
				<xsl:when test="tia:tia_KoopprijsSpecificatie/tia:vveReservefondssom">
					<xsl:call-template name="amountText">
						<xsl:with-param name="amount" select="tia:tia_KoopprijsSpecificatie/tia:vveReservefondssom/tia:som"/>
						<xsl:with-param name="valuta" select="tia:tia_KoopprijsSpecificatie/tia:vveReservefondssom/tia:valuta"/>
					</xsl:call-template>
					<xsl:text> </xsl:text>
					<xsl:call-template name="amountNumber">
						<xsl:with-param name="amount" select="tia:tia_KoopprijsSpecificatie/tia:vveReservefondssom/tia:som"/>
						<xsl:with-param name="valuta" select="tia:tia_KoopprijsSpecificatie/tia:vveReservefondssom/tia:valuta"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="$stukdeelKoop/tia:koopprijsSpecificatie/tia:vveReservefondssom">
					<xsl:call-template name="amountText">
						<xsl:with-param name="amount" select="$stukdeelKoop/tia:koopprijsSpecificatie/tia:vveReservefondssom/tia:som"/>
						<xsl:with-param name="valuta" select="$stukdeelKoop/tia:koopprijsSpecificatie/tia:vveReservefondssom/tia:valuta"/>
					</xsl:call-template>
					<xsl:text> </xsl:text>
					<xsl:call-template name="amountNumber">
						<xsl:with-param name="amount" select="$stukdeelKoop/tia:koopprijsSpecificatie/tia:vveReservefondssom/tia:som"/>
						<xsl:with-param name="valuta" select="$stukdeelKoop/tia:koopprijsSpecificatie/tia:vveReservefondssom/tia:valuta"/>
					</xsl:call-template>
				</xsl:when>
			</xsl:choose>
			<xsl:text> in het reservefonds van de vereniging van eigenaars, waarvan blijkt uit een aan deze akte </xsl:text>
			<xsl:value-of select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_opgavebestuurvvegehechte']/tia:tekst"/>
			<xsl:text> opgave van/namens het bestuur van die vereniging.</xsl:text>
			<br/>
			<xsl:text>Uit de opgave blijkt voorts het bedrag dat </xsl:text>
			<xsl:value-of select="$partijNaam"/>
			<xsl:text> op heden aan de vereniging van eigenaars verschuldigd is.</xsl:text>
		</p>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-opgave_bestuur_vve-two-group
	*********************************************************
	Public: no

	Identity transform: no

	Description: k_OpgaveBestuurVveTekst = 2, print group when there is more than one Registergoed and doesn't have amount per Registergoed

	Input: tia:StukdeelLevering

	Params: stukdeelKoop

	Output: XHTML structure

	Calls:
	(name) amountText
	(name) amountNumber

	Called by:
	(mode) do-assignment-directors-associattion-of-owners
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:StukdeelLevering" mode="do-opgave_bestuur_vve-two-group">
		<xsl:param name="stukdeelKoop" select="self::node()[false()]"/>
		<xsl:variable name="registergoedAanduiding" select="normalize-space(tia:IMKAD_ZakelijkRecht[tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_opgavebestuurvve']/tia:tekst = 'true'
				and tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_opgavebestuurvvetekst']/tia:tekst = '2'
				and not(tia:tia_KoopprijsSpecificatie/tia:vveReservefondssom)
				and tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_vveregistergoedvermelden']/tia:tekst = 'true']/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduiding']/tia:tekst)"/>
		<xsl:variable name="countTrueVVERegistergoedVermeldenMetVolgnummer" select="count(tia:IMKAD_ZakelijkRecht[tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_opgavebestuurvve']/tia:tekst = 'true'
				and tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_opgavebestuurvvetekst']/tia:tekst = '2'
				and not(tia:tia_KoopprijsSpecificatie/tia:vveReservefondssom)
				and tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_vveregistergoedvermelden']/tia:tekst = 'true']/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_vveregistergoedvermeldenmetvolgnummer'
				and tia:tekst = 'true'])"/>
		<p>
			<xsl:text>In de koopprijs </xsl:text>
			<xsl:if test="tia:IMKAD_ZakelijkRecht[tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_opgavebestuurvve']/tia:tekst = 'true'
					and tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_opgavebestuurvvetekst']/tia:tekst = '2']/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_vveregistergoedvermelden']/tia:tekst = 'true'">
				<xsl:text>van </xsl:text>
				<xsl:choose>
					<xsl:when test="$countTrueVVERegistergoedVermeldenMetVolgnummer > 1">
						<xsl:text>de Registergoederen </xsl:text>
						<xsl:for-each select="tia:IMKAD_ZakelijkRecht[tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_opgavebestuurvve']/tia:tekst = 'true'
								and tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_opgavebestuurvvetekst']/tia:tekst = '2'
								and not(tia:tia_KoopprijsSpecificatie/tia:vveReservefondssom)
								and tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_vveregistergoedvermelden']/tia:tekst = 'true']">
							<xsl:value-of select="count(preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
							<xsl:choose>
								<xsl:when test="position() = last() - 1">
									<xsl:text> en </xsl:text>
								</xsl:when>
								<xsl:when test="position() != last()">
									<xsl:text>, </xsl:text>
								</xsl:when>
							</xsl:choose>
						</xsl:for-each>
					</xsl:when>
					<xsl:when test="$countTrueVVERegistergoedVermeldenMetVolgnummer = 1">
						<xsl:text>het Registergoed </xsl:text>
						<xsl:value-of select="count(tia:IMKAD_ZakelijkRecht[tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_opgavebestuurvve']/tia:tekst = 'true'
								and tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_opgavebestuurvvetekst']/tia:tekst = '2'
								and not(tia:tia_KoopprijsSpecificatie/tia:vveReservefondssom)
								and tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_vveregistergoedvermelden']/tia:tekst = 'true'
								and tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_vveregistergoedvermeldenmetvolgnummer']/tia:tekst = 'true']/preceding::tia:IMKAD_ZakelijkRecht) + 1"/>
						<xsl:text> </xsl:text>
					</xsl:when>
					<xsl:when test="$registergoedAanduiding">
						<xsl:value-of select="$registergoedAanduiding"/>
					</xsl:when>
				</xsl:choose>
				<xsl:text> </xsl:text>
			</xsl:if>
			<xsl:text>is begrepen het aandeel van </xsl:text>
			<!-- Print party -->
			<xsl:variable name="volgnummerStukdeelLevering">
				<xsl:value-of select="number(tia:tia_Volgnummer) - 1"/>
			</xsl:variable>
			<xsl:variable name="partijNaam">
				<xsl:choose>
					<xsl:when test="$SoortLevering = 'Twee leveringen'">
						<xsl:choose>
							<xsl:when test="../tia:Partij[@id = substring-after(../tia:StukdeelLevering[tia:tia_Volgnummer=$volgnummerStukdeelLevering]/tia:vervreemderRechtRef/@xlink:href, '#')]">
								<xsl:value-of select="../tia:Partij[@id = substring-after(../tia:StukdeelLevering[tia:tia_Volgnummer=$volgnummerStukdeelLevering]/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
							</xsl:when>
							<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after(../tia:StukdeelLevering[tia:tia_Volgnummer=$volgnummerStukdeelLevering]/tia:vervreemderRechtRef/@xlink:href, '#')]">
								<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after(../tia:StukdeelLevering[tia:tia_Volgnummer=$volgnummerStukdeelLevering]/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
							</xsl:when>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
								<xsl:value-of select="../tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
							</xsl:when>
							<xsl:when test="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]">
								<xsl:value-of select="../tia:Partij/tia:Partij[@id = substring-after(current()/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
							</xsl:when>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:value-of select="$partijNaam"/>
			<xsl:text> groot </xsl:text>
			<!-- Print amount -->
			<xsl:variable name="currentZakelijk" select="tia:IMKAD_ZakelijkRecht[tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_opgavebestuurvve']/tia:tekst = 'true'
					and tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_opgavebestuurvvetekst']/tia:tekst = '2'
					and not(tia:tia_KoopprijsSpecificatie/tia:vveReservefondssom)
					and tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_vveregistergoedvermelden']/tia:tekst = 'true'
					and tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_vveregistergoedvermeldenmetvolgnummer']/tia:tekst = 'true']"/>
			<xsl:choose>
				<xsl:when test="$currentZakelijk[1]/tia:tia_KoopprijsSpecificatie">
					<xsl:call-template name="amountText">
						<xsl:with-param name="amount" select="$currentZakelijk[1]/tia:tia_KoopprijsSpecificatie/tia:vveReservefondssom/tia:som"/>
						<xsl:with-param name="valuta" select="$currentZakelijk[1]/tia:tia_KoopprijsSpecificatie/tia:vveReservefondssom/tia:valuta"/>
					</xsl:call-template>
					<xsl:text> </xsl:text>
					<xsl:call-template name="amountNumber">
						<xsl:with-param name="amount" select="$currentZakelijk[1]/tia:tia_KoopprijsSpecificatie/tia:vveReservefondssom/tia:som"/>
						<xsl:with-param name="valuta" select="$currentZakelijk[1]/tia:tia_KoopprijsSpecificatie/tia:vveReservefondssom/tia:valuta"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="amountText">
						<xsl:with-param name="amount" select="$stukdeelKoop/tia:koopprijsSpecificatie/tia:vveReservefondssom/tia:som"/>
						<xsl:with-param name="valuta" select="$stukdeelKoop/tia:koopprijsSpecificatie/tia:vveReservefondssom/tia:valuta"/>
					</xsl:call-template>
					<xsl:text> </xsl:text>
					<xsl:call-template name="amountNumber">
						<xsl:with-param name="amount" select="$stukdeelKoop/tia:koopprijsSpecificatie/tia:vveReservefondssom/tia:som"/>
						<xsl:with-param name="valuta" select="$stukdeelKoop/tia:koopprijsSpecificatie/tia:vveReservefondssom/tia:valuta"/>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text> in het reservefonds van de vereniging van eigenaars, waarvan blijkt uit een aan deze akte </xsl:text>
			<xsl:value-of select="tia:IMKAD_ZakelijkRecht[tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_opgavebestuurvvetekst']/tia:tekst = '2']/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_opgavebestuurvvegehechte']/tia:tekst"/>
			<xsl:text> opgave van/namens het bestuur van die vereniging.</xsl:text>
			<br/>
			<xsl:text>Uit de opgave blijkt voorts het bedrag dat </xsl:text>
			<!-- Print party -->
			<xsl:value-of select="$partijNaam"/>
			<xsl:text> op heden aan de vereniging van eigenaars verschuldigd is.</xsl:text>
		</p>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-choose-amount-for-variant-a
	*********************************************************
	Public: no

	Identity transform: no

	Description: Amount printed for variants 1a and 2a.

	Input: tia:IMKAD_ZakelijkRecht

	Params: stukdeelKoop
			bedragKoopprijs

	Output: XHTML structure - amount

	Calls:
	(name) amountText
	(name) amountNumber

	Called by:
	(mode) do-purchase-price
	(mode) do-purchase-price-twee-levering-group
	(mode) do-purchase-price-twee-levering-individual
	(mode) do-purchase-price-twee-levering-group-next
	(mode) do-purchase-price-twee-levering-individual-next
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_ZakelijkRecht" mode="do-choose-amount-for-variant-a">
		<xsl:param name="stukdeelKoop" select="self::node()[false()]"/>
		<xsl:param name="bedragKoopprijs" select="self::node()[false()]"/>
		<xsl:choose>
			<xsl:when test="count(preceding-sibling::tia:IMKAD_ZakelijkRecht) = 0 and count(following-sibling::tia:IMKAD_ZakelijkRecht) = 0
				and $bedragKoopprijs">
				<xsl:call-template name="amountText">
					<xsl:with-param name="amount" select="$bedragKoopprijs/tia:som"/>
					<xsl:with-param name="valuta" select="$bedragKoopprijs/tia:valuta"/>
				</xsl:call-template>
				<xsl:text> </xsl:text>
				<xsl:call-template name="amountNumber">
					<xsl:with-param name="amount" select="$bedragKoopprijs/tia:som"/>
					<xsl:with-param name="valuta" select="$bedragKoopprijs/tia:valuta"/>
				</xsl:call-template>
			</xsl:when>
			<!--k_KoopprijsPerRegistergoed exist just for 1.a-->
			<xsl:when test="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst = 'true'
				and tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'true'
				and (not($stukdeelKoop/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsperregistergoed']) or
					$stukdeelKoop/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsperregistergoed']/tia:tekst = 'false')
				and $bedragKoopprijs">
				<xsl:call-template name="amountText">
					<xsl:with-param name="amount" select="$bedragKoopprijs/tia:som"/>
					<xsl:with-param name="valuta" select="$bedragKoopprijs/tia:valuta"/>
				</xsl:call-template>
				<xsl:text> </xsl:text>
				<xsl:call-template name="amountNumber">
					<xsl:with-param name="amount" select="$bedragKoopprijs/tia:som"/>
					<xsl:with-param name="valuta" select="$bedragKoopprijs/tia:valuta"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst = 'true'
				and tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'true'">
				<xsl:call-template name="amountText">
					<xsl:with-param name="amount" select="$stukdeelKoop/tia:transactiesom/tia:som"/>
					<xsl:with-param name="valuta" select="$stukdeelKoop/tia:transactiesom/tia:valuta"/>
				</xsl:call-template>
				<xsl:text> </xsl:text>
				<xsl:call-template name="amountNumber">
					<xsl:with-param name="amount" select="$stukdeelKoop/tia:transactiesom/tia:som"/>
					<xsl:with-param name="valuta" select="$stukdeelKoop/tia:transactiesom/tia:valuta"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="amountText">
					<xsl:with-param name="amount" select="$stukdeelKoop/tia:transactiesom/tia:som"/>
					<xsl:with-param name="valuta" select="$stukdeelKoop/tia:transactiesom/tia:valuta"/>
				</xsl:call-template>
				<xsl:text> </xsl:text>
				<xsl:call-template name="amountNumber">
					<xsl:with-param name="amount" select="$stukdeelKoop/tia:transactiesom/tia:som"/>
					<xsl:with-param name="valuta" select="$stukdeelKoop/tia:transactiesom/tia:valuta"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-choose-amount-for-variant-x
	*********************************************************
	Public: no

	Identity transform: no

	Description: Amount printed for all variant except for variant a.

	Input: tia:IMKAD_ZakelijkRecht

	Params: stukdeelKoop
			bedragKoopprijs

	Output: XHTML structure - amount

	Calls:
	(name) amountText
	(name) amountNumber

	Called by:
	(mode) do-purchase-price
	(mode) do-purchase-price-twee-levering-group
	(mode) do-purchase-price-twee-levering-individual
	(mode) do-purchase-price-twee-levering-group-next
	(mode) do-purchase-price-twee-levering-individual-next
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_ZakelijkRecht" mode="do-choose-amount-for-variant-x">
		<xsl:param name="stukdeelKoop" select="self::node()[false()]"/>
		<xsl:param name="bedragKoopprijs" select="self::node()[false()]"/>
		<xsl:choose>
			<xsl:when test="count(preceding-sibling::tia:IMKAD_ZakelijkRecht) = 0 and count(following-sibling::tia:IMKAD_ZakelijkRecht) = 0
				and $bedragKoopprijs">
				<xsl:call-template name="amountText">
					<xsl:with-param name="amount" select="$bedragKoopprijs/tia:som"/>
					<xsl:with-param name="valuta" select="$bedragKoopprijs/tia:valuta"/>
				</xsl:call-template>
				<xsl:text> </xsl:text>
				<xsl:call-template name="amountNumber">
					<xsl:with-param name="amount" select="$bedragKoopprijs/tia:som"/>
					<xsl:with-param name="valuta" select="$bedragKoopprijs/tia:valuta"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst = 'true'
				and tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'true'
				and $bedragKoopprijs">
				<xsl:call-template name="amountText">
					<xsl:with-param name="amount" select="$bedragKoopprijs/tia:som"/>
					<xsl:with-param name="valuta" select="$bedragKoopprijs/tia:valuta"/>
				</xsl:call-template>
				<xsl:text> </xsl:text>
				<xsl:call-template name="amountNumber">
					<xsl:with-param name="amount" select="$bedragKoopprijs/tia:som"/>
					<xsl:with-param name="valuta" select="$bedragKoopprijs/tia:valuta"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst = 'true'">
				<xsl:call-template name="amountText">
					<xsl:with-param name="amount" select="$stukdeelKoop/tia:transactiesom/tia:som"/>
					<xsl:with-param name="valuta" select="$stukdeelKoop/tia:transactiesom/tia:valuta"/>
				</xsl:call-template>
				<xsl:text> </xsl:text>
				<xsl:call-template name="amountNumber">
					<xsl:with-param name="amount" select="$stukdeelKoop/tia:transactiesom/tia:som"/>
					<xsl:with-param name="valuta" select="$stukdeelKoop/tia:transactiesom/tia:valuta"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst = 'false'">
				<xsl:choose>
					<xsl:when test="$bedragKoopprijs">
						<xsl:call-template name="amountText">
							<xsl:with-param name="amount" select="$bedragKoopprijs/tia:som"/>
							<xsl:with-param name="valuta" select="$bedragKoopprijs/tia:valuta"/>
						</xsl:call-template>
						<xsl:call-template name="amountNumber">
							<xsl:with-param name="amount" select="$bedragKoopprijs/tia:som"/>
							<xsl:with-param name="valuta" select="$bedragKoopprijs/tia:valuta"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="$stukdeelKoop/tia:transactiesom">
						<xsl:call-template name="amountText">
							<xsl:with-param name="amount" select="$stukdeelKoop/tia:transactiesom/tia:som"/>
							<xsl:with-param name="valuta" select="$stukdeelKoop/tia:transactiesom/tia:valuta"/>
						</xsl:call-template>
						<xsl:text> </xsl:text>
						<xsl:call-template name="amountNumber">
							<xsl:with-param name="amount" select="$stukdeelKoop/tia:transactiesom/tia:som"/>
							<xsl:with-param name="valuta" select="$stukdeelKoop/tia:transactiesom/tia:valuta"/>
						</xsl:call-template>
					</xsl:when>
				</xsl:choose>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-bedragKoopprijs-amount
	*********************************************************
	Public: no

	Identity transform: no

	Description: Printed amout of bedragKoopprijs

	Input: tia:IMKAD_ZakelijkRecht

	Params: bedragKoopprijs
			stukdeelKoop
			standaardLevering - true when is called from 1a

	Output: XHTML structure - amount

	Calls:
	(name) amountText
	(name) amountNumber

	Called by:
	(mode) do-purchase-price
	(mode) do-purchase-price-twee-levering-group
	(mode) do-purchase-price-twee-levering-group-next
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_ZakelijkRecht" mode="do-bedragKoopprijs-amount">
		<xsl:param name="bedragKoopprijs" select="self::node()[false()]"/>
		<xsl:param name="stukdeelKoop" select="self::node()[false()]"/>
		<xsl:param name="standaardLevering" select="self::node()[false()]"/>
		<xsl:variable name="conditionVariableA" select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst = 'true'
				and tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'true'
													and $stukdeelKoop/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsperregistergoed']/tia:tekst = 'false'
													and $bedragKoopprijs
													and $standaardLevering='true'"/>
		<xsl:variable name="conditionVariableX" select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst = 'true'
													and tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']/tia:tekst = 'true'
													and $bedragKoopprijs and not($standaardLevering)"/>
		<xsl:choose>
			<xsl:when test="$conditionVariableA or $conditionVariableX">
				<xsl:call-template name="amountText">
					<xsl:with-param name="amount" select="$bedragKoopprijs/tia:som"/>
					<xsl:with-param name="valuta" select="$bedragKoopprijs/tia:valuta"/>
				</xsl:call-template>
				<xsl:text> </xsl:text>
				<xsl:call-template name="amountNumber">
					<xsl:with-param name="amount" select="$bedragKoopprijs/tia:som"/>
					<xsl:with-param name="valuta" select="$bedragKoopprijs/tia:valuta"/>
				</xsl:call-template>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-transactiesom-amount
	*********************************************************
	Public: no

	Identity transform: no

	Description: Printed amout of transactiesom

	Input: tia:IMKAD_ZakelijkRecht

	Params: stukdeelKoop

	Output: XHTML structure - amount

	Calls:
	(name) amountText
	(name) amountNumber

	Called by:
	(mode) do-purchase-price
	(mode) do-purchase-price-twee-levering-group
	(mode) do-purchase-price-twee-levering-group-next
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_ZakelijkRecht" mode="do-transactiesom-amount">
		<xsl:param name="stukdeelKoop" select="self::node()[false()]"/>
		<xsl:choose>
			<xsl:when test="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst = 'true'
				and tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermeldenmetvolgnummer']">
				<xsl:call-template name="amountText">
					<xsl:with-param name="amount" select="$stukdeelKoop/tia:transactiesom/tia:som"/>
					<xsl:with-param name="valuta" select="$stukdeelKoop/tia:transactiesom/tia:valuta"/>
				</xsl:call-template>
				<xsl:text> </xsl:text>
				<xsl:call-template name="amountNumber">
					<xsl:with-param name="amount" select="$stukdeelKoop/tia:transactiesom/tia:som"/>
					<xsl:with-param name="valuta" select="$stukdeelKoop/tia:transactiesom/tia:valuta"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsregistergoedvermelden']/tia:tekst = 'false'">
				<xsl:call-template name="amountText">
					<xsl:with-param name="amount" select="$stukdeelKoop/tia:transactiesom/tia:som"/>
					<xsl:with-param name="valuta" select="$stukdeelKoop/tia:transactiesom/tia:valuta"/>
				</xsl:call-template>
				<xsl:text> </xsl:text>
				<xsl:call-template name="amountNumber">
					<xsl:with-param name="amount" select="$stukdeelKoop/tia:transactiesom/tia:som"/>
					<xsl:with-param name="valuta" select="$stukdeelKoop/tia:transactiesom/tia:valuta"/>
				</xsl:call-template>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-levering-cadastral-identification
	*********************************************************
	Public: yes

	Identity transform: no

	Description: Cadastral identification.

	Input: tia:kadastraleAanduiding

	Params: sameObjects - node set containing tia:IMKAD_Perceel or tia:IMKAD_Appartementsrecht nodes with the same data; default is empty node set
			boldLabel - indicates if "kadastraal bekend" should be bold; default is true
			displayMunicipalityLabel - indicates if label "gemeente" should be displayed; default is true
			numberLabelAsParcel - used for apartments, displays text "nummer" instead of "complexaanduiding" when true
			position - position of currently processed tia:IMKAD_Perceel/tia:IMKAD_Appartementsrecht/tia:IMKAD_Leidingnetwerk
			includeComma - indicates weather starting comma sign should be printed

	Output: text

	Calls:
	none

	Called by:
	(mode) do-parcel-data
	(mode) do-apartment-data
	(mode) do-network-data
	(mode) do-easements
	(mode) do-qualitative-obligations
	(mode) do-common-ownership
	(name) additionCancellationOfRestrictionTextBlock
	-->
	<!--
	**** matching template ********************************************************************************
	**** PARCEL & NETWORK  ********************************************************************************
	-->
	<xsl:template match="tia:kadastraleAanduiding[parent::tia:IMKAD_Perceel
							or parent::tia:IMKAD_Leidingnetwerk]" mode="do-levering-cadastral-identification">
		<xsl:param name="sameObjects" select="self::node()[false()]"/>
		<xsl:param name="boldLabel" select="'true'"/>
		<xsl:param name="displayMunicipalityLabel" select="'true'"/>
		<xsl:param name="numberLabelAsParcel" select="'false'"/>
		<xsl:param name="position" select="'1'"/>
		<xsl:param name="includeComma" select="'true'"/>
		<xsl:if test="$position = '1'">
			<xsl:choose>
				<xsl:when test="translate($boldLabel, $upper, $lower) = 'true'">
					<xsl:if test="parent::tia:IMKAD_Perceel and $includeComma = 'true'">
						<xsl:text>,</xsl:text>
					</xsl:if>
					<strong>
						<xsl:text> kadastraal bekend </xsl:text>
					</strong>
				</xsl:when>
				<xsl:otherwise>
					<xsl:if test="parent::tia:IMKAD_Perceel and $includeComma = 'true'">
						<xsl:text>, </xsl:text>
					</xsl:if>
					<xsl:text> kadastraal bekend </xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
		<xsl:if test="translate($displayMunicipalityLabel, $upper, $lower) = 'true'">
			<xsl:text>gemeente </xsl:text>
		</xsl:if>
		<xsl:value-of select="tia:gemeente"/>
		<xsl:text>, sectie </xsl:text>
		<xsl:value-of select="tia:sectie"/>
		<xsl:text>, nummer</xsl:text>
		<xsl:if test="$sameObjects">
			<xsl:text>s</xsl:text>
		</xsl:if>
		<xsl:text> </xsl:text>
		<xsl:value-of select="tia:perceelnummer"/>
		<xsl:if test="$sameObjects/tia:kadastraleAanduiding/tia:perceelnummer">
			<xsl:for-each select="$sameObjects/tia:kadastraleAanduiding/tia:perceelnummer">
				<xsl:choose>
					<xsl:when test="position() = last()">
						<xsl:text> en </xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>, </xsl:text>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:value-of select="."/>
			</xsl:for-each>
		</xsl:if>
		<xsl:if test="translate(normalize-space(../tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_komma']/tia:tekst), $upper, $lower) = 'true'">
			<xsl:text>,</xsl:text>
		</xsl:if>
	</xsl:template>
	<!--
	**** matching template ********************************************************************************
	****     APARTMENT     ********************************************************************************
	-->
	<xsl:template match="tia:kadastraleAanduiding[parent::tia:IMKAD_Appartementsrecht]" mode="do-levering-cadastral-identification">
		<xsl:param name="sameObjects" select="self::node()[false()]"/>
		<xsl:param name="boldLabel" select="'true'"/>
		<xsl:param name="displayMunicipalityLabel" select="'true'"/>
		<xsl:param name="numberLabelAsParcel" select="'false'"/>
		<xsl:param name="position" select="'1'"/>
		<xsl:if test="$position = '1'">
			<xsl:choose>
				<xsl:when test="translate($boldLabel, $upper, $lower) = 'true'">
					<strong>
						<xsl:text> kadastraal bekend </xsl:text>
					</strong>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text> kadastraal bekend </xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
		<xsl:if test="translate($displayMunicipalityLabel, $upper, $lower) = 'true'">
			<xsl:text>gemeente </xsl:text>
		</xsl:if>
		<xsl:value-of select="tia:gemeente"/>
		<xsl:text>, sectie </xsl:text>
		<xsl:value-of select="tia:sectie"/>
		<xsl:choose>
			<xsl:when test="translate($numberLabelAsParcel, $upper, $lower) = 'true'">
				<xsl:text>, nummer </xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>, complexaanduiding </xsl:text>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:value-of select="tia:perceelnummer"/>
		<xsl:text>, </xsl:text>
		<xsl:choose>
			<xsl:when test="$sameObjects">
				<xsl:text>appartementsindices </xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>appartementsindex </xsl:text>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:value-of select="tia:appartementsindex"/>
		<xsl:if test="$sameObjects/tia:kadastraleAanduiding/tia:appartementsindex">
			<xsl:for-each select="$sameObjects/tia:kadastraleAanduiding/tia:appartementsindex">
				<xsl:choose>
					<xsl:when test="position() = last()">
						<xsl:text> en </xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>, </xsl:text>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:value-of select="."/>
			</xsl:for-each>
		</xsl:if>
	</xsl:template>
	<xsl:template name="toon-het-registergoed">
		<xsl:param name="index"/>
		<xsl:param name="totaal"/>
		<xsl:text>Registergoed </xsl:text>
		<xsl:value-of select="$index"/>
		<xsl:choose>
			<xsl:when test="$index = $totaal - 1">
				<xsl:text> en </xsl:text>
			</xsl:when>
			<xsl:when test="$index != $totaal">
				<xsl:text>, </xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text> </xsl:text>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:if test="number($index) != number($totaal)">
			<xsl:call-template name="toon-het-registergoed">
				<xsl:with-param name="index" select="number($index) + 1"/>
				<xsl:with-param name="totaal" select="$totaal"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
