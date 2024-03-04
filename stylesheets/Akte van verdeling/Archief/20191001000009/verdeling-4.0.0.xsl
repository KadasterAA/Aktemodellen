<?xml version="1.0" encoding="UTF-8"?>
<!--
*********************************************************
Stylesheet: verdeling.xsl
Version: 4.0.0
AA-4512 - Verdeling - bijwerken naar nieuwste versies tekstblokken
AA-4221 - Akte van Verdeling -  Stylesheet aanpassen naar algemene waardelijst met nnp-kodes
AA-4468 - Tekstuele wijzigingen modeldocument Akte van Verdeling
AA-2505 - levering aan één of meer personen binnen één partij met toedeling werd niet goed getoond
AA-4573 Verdeling: parnterschap i.p.v. partnerschap bij Beëindiging geregistreerd partnerschap
AA-4600 - Tekst werd niet goed getoond onder paragraaf A.
*********************************************************
Description:
Deed of distribution.

Public:
(mode) do-deed

Private:
(mode) do-parties
(mode) do-party-person
(mode) do-registered-objects
(mode) do-type-of-division
(mode) do-type-of-division-corporation
(mode) do-type-of-division-marriage
(mode) do-type-of-division-termination-of-registered-partnership
(mode) do-type-of-division-common-cohabiters
(mode) do-properties
(mode) do-naming-property
(mode) do-division
(mode) do-distribution
(mode) do-allocation-to-one-or-more-parties-with-equal-shares-for-each-of-the-persons
(mode) do-allocation-to-different-persons-within-one-party
(mode) do-allocation-header
(mode) do-allocation-to-different-persons-within-one-party-common
(mode) do-election-of-domicile
(name) numberOfRemainingRightsToProcess
(name) isRightAlreadyProcessed
(name) isAlocationToSpecificPartiesTheSame
(name) groupPartiesAndRights
(name) groupPersonsAndRights
(name) groupParties
(match) groups
(match) group
-->
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:tia="http://www.kadaster.nl/schemas/KIK/TIA_Algemeen" xmlns:kef="nl.kadaster.xslt.XslExtensionFunctions" xmlns:gc="http://docs.oasis-open.org/codelist/ns/genericode/1.0/" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exslt="http://exslt.org/common" xmlns:xlink="http://www.w3.org/1999/xlink" exclude-result-prefixes="tia kef gc xsl exslt xlink" version="1.0">
	<xsl:include href="generiek-1.08.xsl"/>
	<xsl:include href="tekstblok_aanhef-1.20.xsl"/>
	<xsl:include href="tekstblok_burgerlijke_staat-1.03.xsl"/>
	<xsl:include href="tekstblok_equivalentieverklaring-1.28.xsl"/>
	<xsl:include href="tekstblok_erfpachtcanon-1.12.xsl"/>
	<xsl:include href="tekstblok_gevolmachtigde-1.26.xsl"/>
	<xsl:include href="tekstblok_legitimatie-2.00.xsl"/>
	<xsl:include href="tekstblok_personalia_van_natuurlijk_persoon-1.06.xsl"/>
	<xsl:include href="tekstblok_natuurlijk_persoon-1.13.xsl"/>
	<xsl:include href="tekstblok_partij_natuurlijk_persoon-1.39.xsl"/>
	<xsl:include href="tekstblok_partij_niet_natuurlijk_persoon-1.53.xsl"/>
	<xsl:include href="tekstblok_recht-1.17.xsl"/>
	<xsl:include href="tekstblok_rechtspersoon-1.15.0.xsl"/>
	<xsl:include href="tekstblok_registergoed-1.29.xsl"/>
	<xsl:include href="tekstblok_woonadres-1.05.xsl"/>
	<xsl:include href="tweededeel-1.05.xsl"/>
	<!-- Verdeling specific global variables -->
	<xsl:variable name="keuzeteksten" select="document('keuzeteksten_verdeling-4.0.0.xml')"/>
	<xsl:variable name="keuzetekstenTbBurgelijkeStaat" select="document('keuzeteksten-tb-burgerlijkestaat-1.1.0.xml')"/>
	<xsl:variable name="legalPersonNames" select="document('nnp-kodes.xml')/gc:CodeList/SimpleCodeList/Row"/>
	<xsl:variable name="stukdeel" select="tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:StukdeelVerdelingVennootschap | tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:StukdeelVerdelingHuwelijk
										| tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:StukdeelVerdelingPartnerschap | tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:StukdeelVerdelingGemeenschap | 
										tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:StukdeelVerdelingUittredingVennoten"/>
	<xsl:variable name="documentTitle">
		<xsl:choose>
			<xsl:when test="tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_titelakte']/tia:tekst and
							normalize-space(tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_titelakte']/tia:tekst) != ''">
				<xsl:choose>
					<xsl:when test="translate(tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_titelakte']/tia:tekst, $upper, $lower) = 'verdeling adres'">
						<xsl:choose>
							<xsl:when test="$stukdeel/tia:IMKAD_ZakelijkRecht[1][tia:IMKAD_Perceel or tia:IMKAD_Appartementsrecht]/*/tia:IMKAD_OZLocatie">
								<xsl:text>VERDELING </xsl:text>
								<xsl:value-of select="$stukdeel/tia:IMKAD_ZakelijkRecht[1][tia:IMKAD_Perceel or tia:IMKAD_Appartementsrecht]/*/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam"/>
								<xsl:if test="$stukdeel/tia:IMKAD_ZakelijkRecht[1][tia:IMKAD_Perceel or tia:IMKAD_Appartementsrecht]/*/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer
										and normalize-space($stukdeel/tia:IMKAD_ZakelijkRecht[1][tia:IMKAD_Perceel or tia:IMKAD_Appartementsrecht]/*/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer) != ''">
									<xsl:text> </xsl:text>
									<xsl:value-of select="$stukdeel/tia:IMKAD_ZakelijkRecht[1][tia:IMKAD_Perceel or tia:IMKAD_Appartementsrecht]/*/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer"/>
								</xsl:if>
								<xsl:if test="$stukdeel/tia:IMKAD_ZakelijkRecht[1][tia:IMKAD_Perceel or tia:IMKAD_Appartementsrecht]/*/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter
										and normalize-space($stukdeel/tia:IMKAD_ZakelijkRecht[1][tia:IMKAD_Perceel or tia:IMKAD_Appartementsrecht]/*/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter) != ''">
									<xsl:text> </xsl:text>
									<xsl:value-of select="$stukdeel/tia:IMKAD_ZakelijkRecht[1][tia:IMKAD_Perceel or tia:IMKAD_Appartementsrecht]/*/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter"/>
								</xsl:if>
								<xsl:if test="$stukdeel/tia:IMKAD_ZakelijkRecht[1][tia:IMKAD_Perceel or tia:IMKAD_Appartementsrecht]/*/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging
										and normalize-space($stukdeel/tia:IMKAD_ZakelijkRecht[1][tia:IMKAD_Perceel or tia:IMKAD_Appartementsrecht]/*/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging) != ''">
									<xsl:text> </xsl:text>
									<xsl:value-of select="$stukdeel/tia:IMKAD_ZakelijkRecht[1][tia:IMKAD_Perceel or tia:IMKAD_Appartementsrecht]/*/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging"/>
								</xsl:if>
								<xsl:text> te </xsl:text>
								<xsl:value-of select="$stukdeel/tia:IMKAD_ZakelijkRecht[1][tia:IMKAD_Perceel or tia:IMKAD_Appartementsrecht]/*/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam"/>
							</xsl:when>
							<xsl:when test="$stukdeel/tia:IMKAD_ZakelijkRecht">
								<xsl:text>VERDELING</xsl:text>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_titelakte']/tia:tekst"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_titelakte']/tia:tekst"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="RegistergoedTonenPerPerceel">
		<!-- t.b.v. TB Registergoed -->
		<xsl:choose>
			<xsl:when test="$stukdeel/tia:IMKAD_ZakelijkRecht/tia:verkrijgerRechtRef">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:when test="tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedtonenperperceel']">
				<xsl:value-of select="translate(tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedtonenperperceel']/tia:tekst, $upper, $lower)"/>
			</xsl:when>
			<xsl:otherwise>false</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="benamingRegistergoed" select="translate(tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_benamingregistergoed']/tia:tekst, $upper, $lower)"/>
	<!--
	*********************************************************
	Mode: do-deed
	*********************************************************
	Public: yes

	Identity transform: no

	Description: Distribution deed.

	Input: tia:Bericht_TIA_Stuk

	Params: none

	Output: XHTML structure

	Calls:
	(mode) do-statement-of-equivalence
	(mode) do-header
	(mode) do-parties
	(mode) do-type-of-division
	(mode) do-properties
	(mode) do-division
	(mode) do-distribution
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
		<xsl:variable name="verschenen" select="tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verschenen']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verschenen']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space(current()/tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verschenen']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
		<xsl:variable name="handelend" select="tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_handelend']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_handelend']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space(current()/tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_handelend']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
		<xsl:variable name="verklaring" select="tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verklaring']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verklaring']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space(current()/tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verklaring']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
		<!-- Text block Statement of equivalence -->
		<xsl:if test="translate($type-document, $upper, $lower) = 'afschrift'">
			<a name="distributiondeed.statementOfEquivalence" class="location">&#160;</a>
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
		<a name="distributiondeed.header" class="location">&#160;</a>
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
		<p>
			<xsl:for-each select="tia:IMKAD_AangebodenStuk/tia:Partij">
				<xsl:choose>
					<xsl:when test="position() = 1">
						<xsl:value-of select="concat(translate(substring(tia:aanduidingPartij, 1, 1), $lower, $upper), substring(tia:aanduidingPartij, 2))"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="tia:aanduidingPartij"/>
					</xsl:otherwise>
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
			<xsl:text>, tezamen ook te noemen: "de deelgenoten".</xsl:text>
			<br/>
			<xsl:text>De </xsl:text>
			<xsl:value-of select="$verschenen"/>
			<xsl:if test="normalize-space($handelend) != ''">
				<xsl:text>, </xsl:text>
				<xsl:value-of select="$handelend"/>
			</xsl:if>
			<xsl:text> </xsl:text>
			<xsl:value-of select="$verklaring"/>
			<xsl:text> als volgt:</xsl:text>
		</p>
		<!-- Type of division -->
		<xsl:apply-templates select="tia:IMKAD_AangebodenStuk" mode="do-type-of-division"/>
		<!-- Properties and Division -->
		<a name="distributiondeed.allocationType" class="location">&#160;</a>
		<xsl:choose>
			<xsl:when test="tia:IMKAD_AangebodenStuk/tia:StukdeelVerdelingVennootschap">
				<xsl:apply-templates select="tia:IMKAD_AangebodenStuk/tia:StukdeelVerdelingVennootschap" mode="do-properties"/>
				<xsl:if test="tia:IMKAD_AangebodenStuk/tia:StukdeelErfpachtcanon or tia:IMKAD_AangebodenStuk/tia:StukdeelErfpachtcanonTijdelijkAfgekocht or tia:IMKAD_AangebodenStuk/tia:StukdeelErfpachtcanonEeuwigAfgekocht">
					<h2 class="header">
						<xsl:text>Erfpachtcanon</xsl:text>
					</h2>
					<a name="distributiondeed.rentCharge" class="location">&#160;</a>
					<xsl:apply-templates select="tia:IMKAD_AangebodenStuk/tia:StukdeelErfpachtcanon | tia:IMKAD_AangebodenStuk/tia:StukdeelErfpachtcanonTijdelijkAfgekocht | tia:IMKAD_AangebodenStuk/tia:StukdeelErfpachtcanonEeuwigAfgekocht" mode="do-long-lease-ground-rent">
						<xsl:with-param name="rights" select="tia:IMKAD_AangebodenStuk/tia:StukdeelVerdelingVennootschap/tia:IMKAD_ZakelijkRecht"/>
					</xsl:apply-templates>
				</xsl:if>
				<xsl:apply-templates select="tia:IMKAD_AangebodenStuk/tia:StukdeelVerdelingVennootschap" mode="do-division"/>
				<xsl:apply-templates select="tia:IMKAD_AangebodenStuk/tia:StukdeelVerdelingVennootschap" mode="do-distribution"/>
			</xsl:when>
			<xsl:when test="tia:IMKAD_AangebodenStuk/tia:StukdeelVerdelingHuwelijk">
				<xsl:apply-templates select="tia:IMKAD_AangebodenStuk/tia:StukdeelVerdelingHuwelijk" mode="do-properties"/>
				<xsl:if test="tia:IMKAD_AangebodenStuk/tia:StukdeelErfpachtcanon or tia:IMKAD_AangebodenStuk/tia:StukdeelErfpachtcanonTijdelijkAfgekocht or tia:IMKAD_AangebodenStuk/tia:StukdeelErfpachtcanonEeuwigAfgekocht">
					<h2 class="header">
						<xsl:text>Erfpachtcanon</xsl:text>
					</h2>
					<a name="distributiondeed.rentCharge" class="location">&#160;</a>
					<xsl:apply-templates select="tia:IMKAD_AangebodenStuk/tia:StukdeelErfpachtcanon | tia:IMKAD_AangebodenStuk/tia:StukdeelErfpachtcanonTijdelijkAfgekocht | tia:IMKAD_AangebodenStuk/tia:StukdeelErfpachtcanonEeuwigAfgekocht" mode="do-long-lease-ground-rent">
						<xsl:with-param name="rights" select="tia:IMKAD_AangebodenStuk/tia:StukdeelVerdelingHuwelijk/tia:IMKAD_ZakelijkRecht"/>
					</xsl:apply-templates>
				</xsl:if>
				<xsl:apply-templates select="tia:IMKAD_AangebodenStuk/tia:StukdeelVerdelingHuwelijk" mode="do-division"/>
				<xsl:apply-templates select="tia:IMKAD_AangebodenStuk/tia:StukdeelVerdelingHuwelijk" mode="do-distribution"/>
			</xsl:when>
			<xsl:when test="tia:IMKAD_AangebodenStuk/tia:StukdeelVerdelingPartnerschap">
				<xsl:apply-templates select="tia:IMKAD_AangebodenStuk/tia:StukdeelVerdelingPartnerschap" mode="do-properties"/>
				<xsl:if test="tia:IMKAD_AangebodenStuk/tia:StukdeelErfpachtcanon or tia:IMKAD_AangebodenStuk/tia:StukdeelErfpachtcanonTijdelijkAfgekocht or tia:IMKAD_AangebodenStuk/tia:StukdeelErfpachtcanonEeuwigAfgekocht">
					<a name="distributiondeed.rentCharge" class="location">&#160;</a>
					<h2 class="header">
						<xsl:text>Erfpachtcanon</xsl:text>
					</h2>
					<xsl:apply-templates select="tia:IMKAD_AangebodenStuk/tia:StukdeelErfpachtcanon | tia:IMKAD_AangebodenStuk/tia:StukdeelErfpachtcanonTijdelijkAfgekocht | tia:IMKAD_AangebodenStuk/tia:StukdeelErfpachtcanonEeuwigAfgekocht" mode="do-long-lease-ground-rent">
						<xsl:with-param name="rights" select="tia:IMKAD_AangebodenStuk/tia:StukdeelVerdelingPartnerschap/tia:IMKAD_ZakelijkRecht"/>
					</xsl:apply-templates>
				</xsl:if>
				<xsl:apply-templates select="tia:IMKAD_AangebodenStuk/tia:StukdeelVerdelingPartnerschap" mode="do-division"/>
				<xsl:apply-templates select="tia:IMKAD_AangebodenStuk/tia:StukdeelVerdelingPartnerschap" mode="do-distribution"/>
			</xsl:when>
			<xsl:when test="tia:IMKAD_AangebodenStuk/tia:StukdeelVerdelingGemeenschap">
				<xsl:apply-templates select="tia:IMKAD_AangebodenStuk/tia:StukdeelVerdelingGemeenschap" mode="do-properties"/>
				<xsl:if test="tia:IMKAD_AangebodenStuk/tia:StukdeelErfpachtcanon or tia:IMKAD_AangebodenStuk/tia:StukdeelErfpachtcanonTijdelijkAfgekocht or tia:IMKAD_AangebodenStuk/tia:StukdeelErfpachtcanonEeuwigAfgekocht">
					<a name="distributiondeed.rentCharge" class="location">&#160;</a>
					<h2 class="header">
						<xsl:text>Erfpachtcanon</xsl:text>
					</h2>
					<xsl:apply-templates select="tia:IMKAD_AangebodenStuk/tia:StukdeelErfpachtcanon | tia:IMKAD_AangebodenStuk/tia:StukdeelErfpachtcanonTijdelijkAfgekocht | tia:IMKAD_AangebodenStuk/tia:StukdeelErfpachtcanonEeuwigAfgekocht" mode="do-long-lease-ground-rent">
						<xsl:with-param name="rights" select="tia:IMKAD_AangebodenStuk/tia:StukdeelVerdelingGemeenschap/tia:IMKAD_ZakelijkRecht"/>
					</xsl:apply-templates>
				</xsl:if>
				<xsl:apply-templates select="tia:IMKAD_AangebodenStuk/tia:StukdeelVerdelingGemeenschap" mode="do-division"/>
				<xsl:apply-templates select="tia:IMKAD_AangebodenStuk/tia:StukdeelVerdelingGemeenschap" mode="do-distribution"/>
			</xsl:when>
			<xsl:when test="tia:IMKAD_AangebodenStuk/tia:StukdeelVerdelingUittredingVennoten">
				<xsl:apply-templates select="tia:IMKAD_AangebodenStuk/tia:StukdeelVerdelingUittredingVennoten" mode="do-properties"/>
				<xsl:if test="tia:IMKAD_AangebodenStuk/tia:StukdeelErfpachtcanon or tia:IMKAD_AangebodenStuk/tia:StukdeelErfpachtcanonTijdelijkAfgekocht or tia:IMKAD_AangebodenStuk/tia:StukdeelErfpachtcanonEeuwigAfgekocht">
					<a name="distributiondeed.rentCharge" class="location">&#160;</a>
					<h2 class="header">
						<xsl:text>Erfpachtcanon</xsl:text>
					</h2>
					<xsl:apply-templates select="tia:IMKAD_AangebodenStuk/tia:StukdeelErfpachtcanon | tia:IMKAD_AangebodenStuk/tia:StukdeelErfpachtcanonTijdelijkAfgekocht | tia:IMKAD_AangebodenStuk/tia:StukdeelErfpachtcanonEeuwigAfgekocht" mode="do-long-lease-ground-rent">
						<xsl:with-param name="rights" select="tia:IMKAD_AangebodenStuk/tia:StukdeelVerdelingUittredingVennoten/tia:IMKAD_ZakelijkRecht"/>
					</xsl:apply-templates>
				</xsl:if>
				<xsl:apply-templates select="tia:IMKAD_AangebodenStuk/tia:StukdeelVerdelingUittredingVennoten" mode="do-division"/>
				<xsl:apply-templates select="tia:IMKAD_AangebodenStuk/tia:StukdeelVerdelingUittredingVennoten" mode="do-distribution"/>
			</xsl:when>
		</xsl:choose>
		<!-- Election of domicile -->
		<xsl:apply-templates select="tia:IMKAD_AangebodenStuk" mode="do-election-of-domicile"/>
		<h3>
			<xsl:text>EINDE KADASTERDEEL</xsl:text>
		</h3>
		<!-- Free text part -->
		<a name="distributiondeed.part2" class="location">&#160;</a>
		<xsl:apply-templates select="tia:IMKAD_AangebodenStuk/tia:tia_TekstTweedeDeel" mode="do-free-text"/>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-parties
	*********************************************************
	Public: no

	Identity transform: no

	Description: Distribution deed parties.

	Input: tia:Partij

	Params: none

	Output: XHTML structure

	Calls:
	(mode) do-legal-representative
	(mode) do-party-person

	Called by:
	(mode) do-deed
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:Partij" mode="do-parties">
		<xsl:variable name="numberOfPersons" select="count(tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']) + count(tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true'])"/>
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
					TODO: Code improvement
					Restructure following CHOOSE structure, as it is no longer valid. It made sense when list structure was used.
					As table is used now, exactly the same code is called from 3 different branches (2 WHEN's and 1 OTHERWISE), needlessly.
					Therefore, FOR-EACH logic in OTHERWISE branch should be used instead of complete CHOOSE structure.
				-->
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

	Description: Distribution deed party persons.

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
	Mode: do-type-of-division
	*********************************************************
	Public: no

	Identity transform: no

	Description: Distribution deed type of division block.

	Input: tia:IMKAD_AangebodenStuk

	Params: none

	Output: XHTML structure

	Calls:
	(mode) do-type-of-division-corporation
	(mode) do-type-of-division-marriage
	(mode) do-type-of-division-termination-of-registered-partnership
	(mode) do-type-of-division-common-cohabiters

	Called by:
	(mode) do-deed
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_AangebodenStuk" mode="do-type-of-division">
		<a name="distributiondeed.divisionType" class="location">&#160;</a>
		<table cellpadding="0" cellspacing="0">
			<tbody>
				<xsl:choose>
					<xsl:when test="tia:StukdeelVerdelingVennootschap">
						<xsl:apply-templates select="." mode="do-type-of-division-corporation"/>
					</xsl:when>
					<xsl:when test="tia:StukdeelVerdelingUittredingVennoten">
						<xsl:apply-templates select="." mode="do-type-of-division-uittreding-vennoten"/>
					</xsl:when>
					<xsl:when test="tia:StukdeelVerdelingHuwelijk">
						<xsl:apply-templates select="." mode="do-type-of-division-marriage"/>
					</xsl:when>
					<xsl:when test="tia:StukdeelVerdelingPartnerschap">
						<xsl:apply-templates select="." mode="do-type-of-division-termination-of-registered-partnership"/>
					</xsl:when>
					<xsl:when test="tia:StukdeelVerdelingGemeenschap">
						<xsl:apply-templates select="." mode="do-type-of-division-common-cohabiters"/>
					</xsl:when>
				</xsl:choose>
			</tbody>
		</table>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-type-of-division-corporation
	*********************************************************
	Public: no

	Identity transform: no

	Description: Distribution deed corporation type of division block.

	Input: tia:IMKAD_AangebodenStuk

	Params: none

	Output: XHTML structure

	Calls:
	none

	Called by:
	(mode) do-type-of-division
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_AangebodenStuk" mode="do-type-of-division-corporation">
		<xsl:variable name="numberOfRights" select="count(tia:StukdeelVerdelingVennootschap/tia:IMKAD_ZakelijkRecht)"/>
		<xsl:variable name="ondermeer" select="tia:StukdeelVerdelingVennootschap/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_ondermeer']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_ondermeer']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space(current()/tia:StukdeelVerdelingVennootschap/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_ondermeer']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
		<xsl:variable name="vennootschapRechtsvorm" select="tia:StukdeelVerdelingVennootschap/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_vennootschaprechtsvorm']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_vennootschaprechtsvorm']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space(current()/tia:StukdeelVerdelingVennootschap/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_vennootschaprechtsvorm']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
		<xsl:variable name="vennootschapKvK" select="tia:StukdeelVerdelingVennootschap/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_vennootschapkvk']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_vennootschapkvk']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space(current()/tia:StukdeelVerdelingVennootschap/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_vennootschapkvk']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
		<xsl:variable name="vereffend" select="tia:StukdeelVerdelingVennootschap/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_vereffend']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_vereffend']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space(current()/tia:StukdeelVerdelingVennootschap/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_vereffend']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
		<xsl:variable name="eenOfMeer">
			<xsl:call-template name="benamingRegistergoed">
				<xsl:with-param name="aantalRegistergoederen" select="$numberOfRights"/>
			</xsl:call-template>
		</xsl:variable>
		<tr>
			<td class="number" valign="top">
				<xsl:text>A.</xsl:text>
			</td>
			<td>
				<xsl:text>INLEIDING</xsl:text>
			</td>
		</tr>
		<tr>
			<td class="number" valign="top">
				<xsl:text>1.</xsl:text>
			</td>
			<td>
				<xsl:text>De deelgenoten waren de enige vennoten van de destijds tussen hen bestaan hebbende </xsl:text>
				<xsl:if test="normalize-space($vennootschapRechtsvorm) != ''">
					<xsl:value-of select="$vennootschapRechtsvorm"/>
					<xsl:text> </xsl:text>
				</xsl:if>
				<xsl:value-of select="tia:StukdeelVerdelingVennootschap/tia:naam"/>
				<xsl:text>, gemeente </xsl:text>
				<xsl:value-of select="tia:StukdeelVerdelingVennootschap/tia:gemeente"/>
				<xsl:if test="normalize-space(tia:StukdeelVerdelingVennootschap/tia:plaats) != ''">
					<xsl:text>, gevestigd te </xsl:text>
					<xsl:value-of select="tia:StukdeelVerdelingVennootschap/tia:plaats"/>
				</xsl:if>
				<xsl:if test="normalize-space(tia:StukdeelVerdelingVennootschap/tia:FINummer) != ''">
					<xsl:text>, ingeschreven in het handelsregister </xsl:text>
					<xsl:if test="normalize-space($vennootschapKvK) != ''">
						<xsl:value-of select="$vennootschapKvK"/>
						<xsl:text> </xsl:text>
					</xsl:if>
					<xsl:text>onder nummer: </xsl:text>
					<xsl:value-of select="tia:StukdeelVerdelingVennootschap/tia:FINummer"/>
				</xsl:if>
				<xsl:text>.</xsl:text>
			</td>
		</tr>
		<tr>
			<td class="number" valign="top">
				<xsl:text>2.</xsl:text>
			</td>
			<td>
				<xsl:text>De deelgenoten hebben in hun hoedanigheid van vennoten van voormelde </xsl:text>
				<xsl:if test="normalize-space($vennootschapRechtsvorm) != ''">
					<xsl:value-of select="$vennootschapRechtsvorm"/>
					<xsl:text> </xsl:text>
				</xsl:if>
				<xsl:text>destijds </xsl:text>
				<xsl:if test="normalize-space($ondermeer) != ''">
					<xsl:value-of select="$ondermeer"/>
					<xsl:text> </xsl:text>
				</xsl:if>
				<xsl:text>in eigendom verkregen </xsl:text>
				<xsl:choose>
					<xsl:when test="$eenOfMeer = 'registergoed'">
						<xsl:text>het hierna te omschrijven registergoed</xsl:text>
					</xsl:when>
					<xsl:when test="$eenOfMeer = 'registergoederen'">
						<xsl:text>de hierna te omschrijven registergoederen</xsl:text>
					</xsl:when>
				</xsl:choose>
				<xsl:text>.</xsl:text>
			</td>
		</tr>
		<tr>
			<td class="number" valign="top">
				<xsl:text>3.</xsl:text>
			</td>
			<td>
				<xsl:text>Voormelde </xsl:text>
				<xsl:if test="normalize-space($vennootschapRechtsvorm) != ''">
					<xsl:value-of select="$vennootschapRechtsvorm"/>
					<xsl:text> </xsl:text>
				</xsl:if>
				<xsl:text>is vervolgens</xsl:text>
				<xsl:if test="normalize-space($vereffend) != ''">
					<xsl:text> </xsl:text>
					<xsl:value-of select="$vereffend"/>
				</xsl:if>
				<xsl:text>.</xsl:text>
			</td>
		</tr>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-type-of-division-uittreding-vennoten
	*********************************************************
	Public: no

	Identity transform: no

	Description: Distribution deed corporation type of division block.

	Input: tia:IMKAD_AangebodenStuk

	Params: none

	Output: XHTML structure

	Calls:
	none

	Called by:
	(mode) do-type-of-division
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_AangebodenStuk" mode="do-type-of-division-uittreding-vennoten">
		<xsl:variable name="eenOfMeer">
			<xsl:call-template name="benamingRegistergoed">
				<xsl:with-param name="aantalRegistergoederen" select="count(tia:StukdeelVerdelingUittredingVennoten/tia:IMKAD_ZakelijkRecht)"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="ondermeerGemeenschap" select="tia:StukdeelVerdelingUittredingVennoten/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_ondermeergemeenschap']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_ondermeergemeenschap']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space(current()/tia:StukdeelVerdelingUittredingVennoten/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_ondermeergemeenschap']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
		<xsl:variable name="ondermeerOvereenkomst" select="tia:StukdeelVerdelingUittredingVennoten/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_ondermeerovereenkomst']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_ondermeerovereenkomst']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space(current()/tia:StukdeelVerdelingUittredingVennoten/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_ondermeerovereenkomst']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
		<xsl:variable name="vennootschapRechtsvorm" select="tia:StukdeelVerdelingUittredingVennoten/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_vennootschaprechtsvorm']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_vennootschaprechtsvorm']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space(current()/tia:StukdeelVerdelingUittredingVennoten/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_vennootschaprechtsvorm']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
		<xsl:variable name="vennootschapKvK" select="tia:StukdeelVerdelingUittredingVennoten/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_vennootschapkvk']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_vennootschapkvk']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space(current()/tia:StukdeelVerdelingUittredingVennoten/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_vennootschapkvk']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
		<xsl:variable name="kopieOvereenkomst" select="tia:StukdeelVerdelingUittredingVennoten/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_kopieovereenkomst']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_kopieovereenkomst']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space(current()/tia:StukdeelVerdelingUittredingVennoten/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_kopieovereenkomst']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
		<xsl:variable name="Datum_DATE1" select="substring(string(tia:StukdeelVerdelingUittredingVennoten/tia:datumUittreding), 0, 11)"/>
		<xsl:variable name="Datum_STRING1">
			<xsl:if test="$Datum_DATE1 != ''">
				<xsl:value-of select="kef:convertDateToText($Datum_DATE1)"/>
			</xsl:if>
		</xsl:variable>
		<tr>
			<td class="number" valign="top">
				<xsl:text>A.</xsl:text>
			</td>
			<td>
				<xsl:text>INLEIDING</xsl:text>
			</td>
		</tr>
		<tr>
			<td class="number" valign="top">
				<xsl:text>1.</xsl:text>
			</td>
			<td>
				<xsl:text>De deelgenoten waren de enige vennoten van de </xsl:text>
				<xsl:if test="normalize-space($vennootschapRechtsvorm) != ''">
					<xsl:value-of select="$vennootschapRechtsvorm"/>
					<xsl:text> </xsl:text>
				</xsl:if>
				<xsl:value-of select="tia:StukdeelVerdelingUittredingVennoten/tia:naam"/>
				<xsl:text>, gemeente </xsl:text>
				<xsl:value-of select="tia:StukdeelVerdelingUittredingVennoten/tia:gemeente"/>
				<xsl:if test="normalize-space(tia:StukdeelVerdelingUittredingVennoten/tia:plaats) != ''">
					<xsl:text>, gevestigd te </xsl:text>
					<xsl:value-of select="tia:StukdeelVerdelingUittredingVennoten/tia:plaats"/>
				</xsl:if>
				<xsl:if test="normalize-space(tia:StukdeelVerdelingUittredingVennoten/tia:FINummer) != ''">
					<xsl:text>, ingeschreven in het handelsregister </xsl:text>
					<xsl:if test="normalize-space($vennootschapKvK) != ''">
						<xsl:value-of select="$vennootschapKvK"/>
						<xsl:text> </xsl:text>
					</xsl:if>
					<xsl:text>onder nummer: </xsl:text>
					<xsl:value-of select="tia:StukdeelVerdelingUittredingVennoten/tia:FINummer"/>
				</xsl:if>
				<xsl:text>.</xsl:text>
			</td>
		</tr>
		<tr>
			<td class="number" valign="top">
				<xsl:text>2.</xsl:text>
			</td>
			<td>
				<xsl:text>De deelgenoten hebben in hun hoedanigheid van vennoten van voormelde </xsl:text>
				<xsl:if test="normalize-space($vennootschapRechtsvorm) != ''">
					<xsl:value-of select="$vennootschapRechtsvorm"/>
					<xsl:text> </xsl:text>
				</xsl:if>
				<xsl:text>destijds </xsl:text>
				<xsl:if test="normalize-space($ondermeerGemeenschap) != ''">
					<xsl:value-of select="$ondermeerGemeenschap"/>
					<xsl:text> </xsl:text>
				</xsl:if>
				<xsl:text>in eigendom verkregen </xsl:text>
				<xsl:choose>
					<xsl:when test="$eenOfMeer = 'registergoed'">
						<xsl:text>het hierna te omschrijven registergoed</xsl:text>
					</xsl:when>
					<xsl:when test="$eenOfMeer = 'registergoederen'">
						<xsl:text>de hierna te omschrijven registergoederen</xsl:text>
					</xsl:when>
				</xsl:choose>
				<xsl:text>.</xsl:text>
			</td>
		</tr>
		<tr>
			<td class="number" valign="top">
				<xsl:text>3.</xsl:text>
			</td>
			<td>
				<xsl:for-each select="tia:StukdeelVerdelingUittredingVennoten/tia:vervreemderRechtRef">
					<xsl:variable name="vervreemderPartij" select="../../tia:Partij[@id = substring-after(current()/@xlink:href, '#')]"/>
					<xsl:variable name="firstChar" select="substring($vervreemderPartij/tia:aanduidingPartij,1,1)"/>
					<xsl:value-of select="translate($firstChar,$lower,$upper)"/>
					<xsl:value-of select="substring($vervreemderPartij/tia:aanduidingPartij,2)"/>
					<xsl:choose>
						<xsl:when test="position() = last() - 1">
							<xsl:text> en </xsl:text>
						</xsl:when>
						<xsl:when test="position() != last()">
							<xsl:text>, </xsl:text>
						</xsl:when>
					</xsl:choose>
				</xsl:for-each>
				<xsl:choose>
					<xsl:when test="count(tia:StukdeelVerdelingUittredingVennoten/tia:vervreemderRechtRef) > 1">
						<xsl:text> zijn per </xsl:text>
						<xsl:value-of select="$Datum_STRING1"/>
						<xsl:text> als vennoten uitgetreden</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text> is per </xsl:text>
						<xsl:value-of select="$Datum_STRING1"/>
						<xsl:text> als vennoot uitgetreden</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:text>. </xsl:text>
				<xsl:if test="tia:StukdeelVerdelingUittredingVennoten/tia:tekstkeuze[tia:tagNaam='k_OndertekendeOvereenkomst']/tia:tekst='true'">
					<xsl:text>Zoals blijkt uit een door de deelgenoten ondertekende overeenkomst, </xsl:text>
					<xsl:if test="normalize-space($kopieOvereenkomst) != ''">
						<xsl:value-of select="$kopieOvereenkomst"/>
						<xsl:text>, </xsl:text>
					</xsl:if>
					<xsl:text>hebben de deelgenoten een overeenkomst gesloten inzake </xsl:text>
					<xsl:if test="normalize-space($ondermeerOvereenkomst) != ''">
						<xsl:value-of select="$ondermeerOvereenkomst"/>
					</xsl:if>
					<xsl:text> de verdeling van </xsl:text>
					<xsl:choose>
						<xsl:when test="$eenOfMeer = 'registergoed'">
							<xsl:text>het hierna te omschrijven registergoed</xsl:text>
						</xsl:when>
						<xsl:when test="$eenOfMeer = 'registergoederen'">
							<xsl:text>de hierna te omschrijven registergoederen</xsl:text>
						</xsl:when>
					</xsl:choose>
					<xsl:text>.</xsl:text>
				</xsl:if>
			</td>
		</tr>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-type-of-division-marriage
	*********************************************************
	Public: no

	Identity transform: no

	Description: Distribution deed marriage type of division block.

	Input: tia:IMKAD_AangebodenStuk

	Params: none

	Output: XHTML structure

	Calls:
	none

	Called by:
	(mode) do-type-of-division
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_AangebodenStuk" mode="do-type-of-division-marriage">
		<xsl:variable name="numberOfRights" select="count(tia:StukdeelVerdelingHuwelijk/tia:IMKAD_ZakelijkRecht)"/>
		<xsl:variable name="eenOfMeer">
			<xsl:call-template name="benamingRegistergoed">
				<xsl:with-param name="aantalRegistergoederen" select="count(tia:StukdeelVerdelingHuwelijk/tia:IMKAD_ZakelijkRecht)"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="datumUitspraak" select="tia:StukdeelVerdelingHuwelijk/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_datumuitspraak']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_datumuitspraak']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space(current()/tia:StukdeelVerdelingHuwelijk/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_datumuitspraak']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
		<xsl:variable name="zonder" select="tia:StukdeelVerdelingHuwelijk/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_zonder']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_zonder']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space(current()/tia:StukdeelVerdelingHuwelijk/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_zonder']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
		<xsl:variable name="gemeenschapGoederen" select="tia:StukdeelVerdelingHuwelijk/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_gemeenschapgoederen']/tia:tekst[translate(normalize-space(.), $upper, $lower)]"/>
		<xsl:variable name="ondermeerOvereenkomst" select="tia:StukdeelVerdelingHuwelijk/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_ondermeerovereenkomst']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_ondermeerovereenkomst']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space(current()/tia:StukdeelVerdelingHuwelijk/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_ondermeerovereenkomst']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
		<xsl:variable name="ondermeerGemeenschap" select="tia:StukdeelVerdelingHuwelijk/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_ondermeergemeenschap']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_ondermeergemeenschap']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space(current()/tia:StukdeelVerdelingHuwelijk/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_ondermeergemeenschap']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
		<xsl:variable name="gemeenteHuwelijk" select="tia:StukdeelVerdelingHuwelijk/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_gemeentehuwelijk']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_gemeentehuwelijk']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space(current()/tia:StukdeelVerdelingHuwelijk/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_gemeentehuwelijk']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
		<xsl:variable name="gemeenteOntbinding" select="tia:StukdeelVerdelingHuwelijk/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_gemeenteontbinding']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_gemeenteontbinding']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space(current()/tia:StukdeelVerdelingHuwelijk/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_gemeenteontbinding']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
		<xsl:variable name="aantekeningInschrijving" select="tia:StukdeelVerdelingHuwelijk/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aantekeninginschrijving']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aantekeninginschrijving']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space(current()/tia:StukdeelVerdelingHuwelijk/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aantekeninginschrijving']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
		<xsl:variable name="ondertekendDocument" select="tia:StukdeelVerdelingHuwelijk/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_ondertekenddocument']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_ondertekenddocument']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space(current()/tia:StukdeelVerdelingHuwelijk/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_ondertekenddocument']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
		<xsl:variable name="kopieOvereenkomst" select="tia:StukdeelVerdelingHuwelijk/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_kopieovereenkomst']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_kopieovereenkomst']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space(current()/tia:StukdeelVerdelingHuwelijk/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_kopieovereenkomst']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
		<xsl:variable name="Datum_DATE1" select="substring(string(tia:StukdeelVerdelingHuwelijk/tia:datumHuwelijk), 0, 11)"/>
		<xsl:variable name="Datum_STRING1">
			<xsl:if test="$Datum_DATE1 != ''">
				<xsl:value-of select="kef:convertDateToText($Datum_DATE1)"/>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="Datum_DATE2" select="substring(string(tia:StukdeelVerdelingHuwelijk/tia:datumOntbinding), 0, 11)"/>
		<xsl:variable name="Datum_STRING2">
			<xsl:if test="$Datum_DATE2 != ''">
				<xsl:value-of select="kef:convertDateToText($Datum_DATE2)"/>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="Datum_DATE3" select="substring(string(tia:StukdeelVerdelingHuwelijk/tia:datumUitspraakRechtbank), 0, 11)"/>
		<xsl:variable name="Datum_STRING3">
			<xsl:if test="$Datum_DATE3 != ''">
				<xsl:value-of select="kef:convertDateToText($Datum_DATE3)"/>
			</xsl:if>
		</xsl:variable>
		<tr>
			<td class="number" valign="top">
				<xsl:text>A.</xsl:text>
			</td>
			<td>
				<xsl:text>INLEIDING</xsl:text>
			</td>
		</tr>
		<tr>
			<td class="number" valign="top">
				<xsl:text>1.</xsl:text>
			</td>
			<td>
				<xsl:text>De deelgenoten zijn op </xsl:text>
				<xsl:value-of select="$Datum_STRING1"/>
				<xsl:text> </xsl:text>
				<xsl:value-of select="$gemeenteHuwelijk"/>
				<xsl:text> </xsl:text>
				<xsl:value-of select="tia:StukdeelVerdelingHuwelijk/tia:gemeenteHuwelijk"/>
				<xsl:text> gehuwd. Hun huwelijk is door echtscheiding ontbonden door de </xsl:text>
				<xsl:value-of select="$aantekeningInschrijving"/>
				<xsl:text> in de registers van de Burgerlijke Stand </xsl:text>
				<xsl:text> </xsl:text>
				<xsl:value-of select="$gemeenteOntbinding"/>
				<xsl:text> </xsl:text>
				<xsl:value-of select="tia:StukdeelVerdelingHuwelijk/tia:gemeenteOntbinding"/>
				<xsl:text> op </xsl:text>
				<xsl:value-of select="$Datum_STRING2"/>
				<xsl:text> van de beschikking tot echtscheiding van de Rechtbank </xsl:text>
				<xsl:choose>
					<xsl:when test="tia:StukdeelVerdelingHuwelijk/tia:plaatsRechtbank != ''">
						<xsl:text>te </xsl:text>
						<xsl:value-of select="tia:StukdeelVerdelingHuwelijk/tia:plaatsRechtbank"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="tia:StukdeelVerdelingHuwelijk/tia:naamRechtbank"/>
						<xsl:text> locatie </xsl:text>
						<xsl:value-of select="tia:StukdeelVerdelingHuwelijk/tia:gemeenteRechtbank"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:text>, </xsl:text>
				<xsl:value-of select="$datumUitspraak"/>
				<xsl:text> </xsl:text>
				<xsl:value-of select="$Datum_STRING3"/>
				<xsl:text>.</xsl:text>
			</td>
		</tr>
		<tr>
			<td class="number" valign="top">
				<xsl:text>2.</xsl:text>
			</td>
			<td>
				<xsl:text>De deelgenoten waren </xsl:text>
				<xsl:value-of select="$zonder"/>
				<xsl:text>onder het maken van huwelijkse voorwaarden gehuwd. Tot de </xsl:text>
				<xsl:if test="$gemeenschapGoederen != ''">
					<xsl:value-of select="$gemeenschapGoederen"/>
				</xsl:if>
				<xsl:text> goederen </xsl:text>
				<xsl:choose>
					<xsl:when test="$numberOfRights = 1">
						<xsl:text>behoort </xsl:text>
					</xsl:when>
					<xsl:when test="$numberOfRights > 1">
						<xsl:text>behoren </xsl:text>
					</xsl:when>
				</xsl:choose>
				<xsl:if test="normalize-space($ondermeerGemeenschap) != ''">
					<xsl:value-of select="$ondermeerGemeenschap"/>
					<xsl:text> </xsl:text>
				</xsl:if>
				<xsl:choose>
					<xsl:when test="$eenOfMeer = 'registergoed'">
						<xsl:text>het hierna te omschrijven registergoed</xsl:text>
					</xsl:when>
					<xsl:when test="$eenOfMeer = 'registergoederen'">
						<xsl:text>de hierna te omschrijven registergoederen</xsl:text>
					</xsl:when>
				</xsl:choose>
				<xsl:text>.</xsl:text>
			</td>
		</tr>
		<xsl:if test="normalize-space($ondertekendDocument) != ''">
			<tr>
				<td class="number" valign="top">
					<xsl:text>3.</xsl:text>
				</td>
				<td>
					<xsl:text> Zoals blijkt uit een door de deelgenoten </xsl:text>
					<xsl:value-of select="$ondertekendDocument"/>
					<xsl:text>, </xsl:text>
					<xsl:if test="normalize-space($kopieOvereenkomst) != ''">
						<xsl:value-of select="$kopieOvereenkomst"/>
						<xsl:text>, </xsl:text>
					</xsl:if>
					<xsl:text> hebben de deelgenoten een overeenkomst gesloten inzake  </xsl:text>
					<xsl:if test="normalize-space($ondermeerOvereenkomst) != ''">
						<xsl:value-of select="$ondermeerOvereenkomst"/>
						<xsl:text> </xsl:text>
					</xsl:if>
					<xsl:text>de verdeling van </xsl:text>
					<xsl:choose>
						<xsl:when test="$eenOfMeer = 'registergoed'">
							<xsl:text>het hierna te omschrijven registergoed</xsl:text>
						</xsl:when>
						<xsl:when test="$eenOfMeer = 'registergoederen'">
							<xsl:text>de hierna te omschrijven registergoederen</xsl:text>
						</xsl:when>
					</xsl:choose>
					<xsl:text>.</xsl:text>
				</td>
			</tr>
		</xsl:if>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-type-of-division-termination-of-registered-partnership
	*********************************************************
	Public: no

	Identity transform: no

	Description: Distribution deed termination of registered partnership block.

	Input: tia:IMKAD_AangebodenStuk

	Params: none

	Output: XHTML structure

	Calls:
	none

	Called by:
	(mode) do-type-of-division
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_AangebodenStuk" mode="do-type-of-division-termination-of-registered-partnership">
		<xsl:variable name="numberOfRights" select="count(tia:StukdeelVerdelingPartnerschap/tia:IMKAD_ZakelijkRecht)"/>
		<xsl:variable name="eenOfMeer">
			<xsl:call-template name="benamingRegistergoed">
				<xsl:with-param name="aantalRegistergoederen" select="count(tia:StukdeelVerdelingPartnerschap/tia:IMKAD_ZakelijkRecht)"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="Datum_DATE1" select="substring(string(tia:StukdeelVerdelingPartnerschap/tia:datumRegistratie), 0, 11)"/>
		<xsl:variable name="Datum_STRING1">
			<xsl:if test="$Datum_DATE1 != ''">
				<xsl:value-of select="kef:convertDateToText($Datum_DATE1)"/>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="Datum_DATE2" select="substring(string(tia:StukdeelVerdelingPartnerschap/tia:datumOntbinding), 0, 11)"/>
		<xsl:variable name="Datum_STRING2">
			<xsl:if test="$Datum_DATE2 != ''">
				<xsl:value-of select="kef:convertDateToText($Datum_DATE2)"/>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="Datum_DATE3" select="substring(string(tia:StukdeelVerdelingPartnerschap/tia:datumUitspraakRechtbank), 0, 11)"/>
		<xsl:variable name="Datum_STRING3">
			<xsl:if test="$Datum_DATE3 != ''">
				<xsl:value-of select="kef:convertDateToText($Datum_DATE3)"/>
			</xsl:if>
		</xsl:variable>
		<tr>
			<td class="number" valign="top">
				<xsl:text>A.</xsl:text>
			</td>
			<td>
				<xsl:text>INLEIDING</xsl:text>
			</td>
		</tr>
		<tr>
			<td class="number" valign="top">
				<xsl:text>1.</xsl:text>
			</td>
			<td>
				<xsl:text>De deelgenoten zijn op </xsl:text>
				<xsl:value-of select="$Datum_STRING1"/>
				<xsl:text> </xsl:text>
				<xsl:value-of select="tia:StukdeelVerdelingPartnerschap/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_gemeenteregistratie']/tia:tekst"/>
				<xsl:text> </xsl:text>
				<xsl:value-of select="tia:StukdeelVerdelingPartnerschap/tia:gemeenteRegistratie"/>
				<xsl:text> een geregistreerd partnerschap aangegaan. Hun geregistreerd partnerschap is ontbonden door het inschrijven van de </xsl:text>
				<xsl:choose>
					<xsl:when test="tia:StukdeelVerdelingPartnerschap/tia:plaatsRechtbank or tia:StukdeelVerdelingPartnerschap/tia:gemeenteRechtbank">
						<xsl:text>beschikking tot ontbinding van het geregistreerd partnerschap, uitgesproken door de Rechtbank </xsl:text>
						<xsl:choose>
							<xsl:when test="tia:StukdeelVerdelingPartnerschap/tia:plaatsRechtbank">
								<xsl:text> te </xsl:text>
								<xsl:value-of select="tia:StukdeelVerdelingPartnerschap/tia:plaatsRechtbank"/>
								<xsl:text> op </xsl:text>
								<xsl:value-of select="$Datum_STRING3"/>
								<xsl:text>,</xsl:text>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="tia:StukdeelVerdelingPartnerschap/tia:naamRechtbank"/>
								<xsl:text> locatie </xsl:text>
								<xsl:value-of select="tia:StukdeelVerdelingPartnerschap/tia:gemeenteRechtbank"/>
								<xsl:text> op </xsl:text>
								<xsl:value-of select="$Datum_STRING3"/>
								<xsl:text>,</xsl:text>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>be&#x00EB;indigingsverklaring</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:text> in de registers van de Burgerlijke Stand </xsl:text>
				<xsl:value-of select="tia:StukdeelVerdelingPartnerschap/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_gemeenteontbinding']/tia:tekst"/>
				<xsl:text> </xsl:text>
				<xsl:value-of select="tia:StukdeelVerdelingPartnerschap/tia:gemeenteOntbinding"/>
				<xsl:text> op </xsl:text>
				<xsl:value-of select="$Datum_STRING2"/>
				<xsl:text>.</xsl:text>
			</td>
		</tr>
		<tr>
			<td class="number" valign="top">
				<xsl:text>2.</xsl:text>
			</td>
			<td>
				<xsl:text>De deelgenoten waren </xsl:text>
				<xsl:value-of select="tia:StukdeelVerdelingPartnerschap/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_zonder']/tia:tekst"/>
				<xsl:text>onder het maken van partnerschapsvoorwaarden geregistreerd als partner. Tot de </xsl:text>
				<xsl:if test="tia:StukdeelVerdelingPartnerschap/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_gemeenschapgoederen']/tia:tekst != ''">
					<xsl:value-of select="tia:StukdeelVerdelingPartnerschap/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_gemeenschapgoederen']/tia:tekst"/>
				</xsl:if>
				<xsl:text> goederen </xsl:text>
				<xsl:choose>
					<xsl:when test="$numberOfRights = 1">
						<xsl:text>behoort </xsl:text>
					</xsl:when>
					<xsl:when test="$numberOfRights > 1">
						<xsl:text>behoren </xsl:text>
					</xsl:when>
				</xsl:choose>
				<xsl:if test="normalize-space(tia:StukdeelVerdelingPartnerschap/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_ondermeergemeenschap']/tia:tekst) != ''">
					<xsl:value-of select="tia:StukdeelVerdelingPartnerschap/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_ondermeergemeenschap']/tia:tekst"/>
					<xsl:text> </xsl:text>
				</xsl:if>
				<xsl:choose>
					<xsl:when test="$eenOfMeer = 'registergoed'">
						<xsl:text>het hierna te omschrijven registergoed</xsl:text>
					</xsl:when>
					<xsl:when test="$eenOfMeer = 'registergoederen'">
						<xsl:text>de hierna te omschrijven registergoederen</xsl:text>
					</xsl:when>
				</xsl:choose>
				<xsl:text>.</xsl:text>
			</td>
		</tr>
		<xsl:if test="tia:StukdeelVerdelingPartnerschap/tia:tekstkeuze[tia:tagNaam='k_OndertekendeOvereenkomst']/tia:tekst='true'">
			<tr>
				<td class="number" valign="top">
					<xsl:text>3.</xsl:text>
				</td>
				<td>
					<xsl:text>Zoals blijkt uit een door de deelgenoten ondertekende overeenkomst omtrent be&#x00EB;indiging van het geregistreerd partnerschap, </xsl:text>
					<xsl:if test="normalize-space(tia:StukdeelVerdelingPartnerschap/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_kopieovereenkomst']/tia:tekst) != ''">
						<xsl:value-of select="tia:StukdeelVerdelingPartnerschap/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_kopieovereenkomst']/tia:tekst"/>
						<xsl:text>, </xsl:text>
					</xsl:if>
					<xsl:text>hebben de deelgenoten een overeenkomst gesloten inzake </xsl:text>
					<xsl:if test="normalize-space(tia:StukdeelVerdelingPartnerschap/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_ondermeerovereenkomst']/tia:tekst) != ''">
						<xsl:value-of select="tia:StukdeelVerdelingPartnerschap/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_ondermeerovereenkomst']/tia:tekst"/>
						<xsl:text> </xsl:text>
					</xsl:if>
					<xsl:text>de verdeling van </xsl:text>
					<xsl:choose>
						<xsl:when test="$eenOfMeer = 'registergoed'">
							<xsl:text>het hierna te omschrijven registergoed</xsl:text>
						</xsl:when>
						<xsl:when test="$eenOfMeer = 'registergoederen'">
							<xsl:text>de hierna te omschrijven registergoederen</xsl:text>
						</xsl:when>
					</xsl:choose>
					<xsl:text>.</xsl:text>
				</td>
			</tr>
		</xsl:if>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-type-of-division-common-cohabiters
	*********************************************************
	Public: no

	Identity transform: no

	Description: Distribution deed common cohabiters type of division block.

	Input: tia:IMKAD_AangebodenStuk

	Params: none

	Output: XHTML structure

	Calls:
	none

	Called by:
	(mode) do-type-of-division
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_AangebodenStuk" mode="do-type-of-division-common-cohabiters">
		<xsl:variable name="eenOfMeer">
			<xsl:call-template name="benamingRegistergoed">
				<xsl:with-param name="aantalRegistergoederen" select="count(tia:StukdeelVerdelingGemeenschap/tia:IMKAD_ZakelijkRecht)"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="kopieOvereenkomst" select="tia:StukdeelVerdelingGemeenschap/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_kopieovereenkomst']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_kopieovereenkomst']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space(current()/tia:StukdeelVerdelingGemeenschap/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_kopieovereenkomst']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
		<xsl:variable name="ondermeerOvereenkomst" select="tia:StukdeelVerdelingGemeenschap/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_ondermeerovereenkomst']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_ondermeerovereenkomst']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space(current()/tia:StukdeelVerdelingGemeenschap/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_ondermeerovereenkomst']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
		<xsl:choose>
			<xsl:when test="tia:StukdeelVerdelingGemeenschap/tia:tekstkeuze[tia:tagNaam='k_OndertekendeOvereenkomst']/tia:tekst='true'">
				<tr>
					<td class="number" valign="top">
						<xsl:text>A.</xsl:text>
					</td>
					<td align="left">
						<xsl:text>INLEIDING</xsl:text>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>1.</xsl:text>
					</td>
					<td>
						<xsl:text>Zoals blijkt uit na te melden eigendomsverkrijging, bestaat er tussen de deelgenoten een gemeenschap ten aanzien van </xsl:text>
						<xsl:choose>
							<xsl:when test="$eenOfMeer = 'registergoed'">
								<xsl:text>het hierna te omschrijven registergoed</xsl:text>
							</xsl:when>
							<xsl:when test="$eenOfMeer = 'registergoederen'">
								<xsl:text>de hierna te omschrijven registergoederen</xsl:text>
							</xsl:when>
						</xsl:choose>
						<xsl:text>.</xsl:text>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>2.</xsl:text>
					</td>
					<td>
						<xsl:text>Zoals blijkt uit een door de deelgenoten ondertekende overeenkomst, </xsl:text>
						<xsl:if test="normalize-space($kopieOvereenkomst) != ''">
							<xsl:value-of select="$kopieOvereenkomst"/>
							<xsl:text>, </xsl:text>
						</xsl:if>
						<xsl:text>hebben de deelgenoten een overeenkomst gesloten inzake </xsl:text>
						<xsl:if test="normalize-space($ondermeerOvereenkomst) != ''">
							<xsl:value-of select="$ondermeerOvereenkomst"/>
							<xsl:text> </xsl:text>
						</xsl:if>
						<xsl:text>de verdeling van </xsl:text>
						<xsl:choose>
							<xsl:when test="$eenOfMeer = 'registergoed'">
								<xsl:text>het hierna te omschrijven registergoed</xsl:text>
							</xsl:when>
							<xsl:when test="$eenOfMeer = 'registergoederen'">
								<xsl:text>de hierna te omschrijven registergoederen</xsl:text>
							</xsl:when>
						</xsl:choose>
						<xsl:text>.</xsl:text>
					</td>
				</tr>
			</xsl:when>
			<xsl:otherwise>
				<tr>
					<td>
						<xsl:text>A. INLEIDING</xsl:text>
					</td>
				</tr>
				<tr>
					<td>
						<xsl:text>Zoals blijkt uit na te melden eigendomsverkrijging, bestaat er tussen de deelgenoten een gemeenschap ten aanzien van </xsl:text>
						<xsl:choose>
							<xsl:when test="$eenOfMeer = 'registergoed'">
								<xsl:text>het hierna te omschrijven registergoed</xsl:text>
							</xsl:when>
							<xsl:when test="$eenOfMeer = 'registergoederen'">
								<xsl:text>de hierna te omschrijven registergoederen</xsl:text>
							</xsl:when>
						</xsl:choose>
						<xsl:text>.</xsl:text>
					</td>
				</tr>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-properties
	*********************************************************
	Public: no

	Identity transform: no

	Description: Distribution deed properties block.

	Input: tia:StukdeelVerdelingVennootschap, tia:StukdeelVerdelingHuwelijk, tia:StukdeelVerdelingPartnerschap, tia:StukdeelVerdelingGemeenschap of tia:StukdeelVerdelingUittredingVennoten

	Params: none

	Output: XHTML structure

	Calls:
	(mode) do-registered-objects
	(mode) do-naming-property

	Called by:
	(mode) do-deed
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:StukdeelVerdelingVennootschap | tia:StukdeelVerdelingHuwelijk | tia:StukdeelVerdelingPartnerschap | tia:StukdeelVerdelingGemeenschap | tia:StukdeelVerdelingUittredingVennoten" mode="do-properties">
		<xsl:variable name="eenOfMeer">
			<xsl:call-template name="benamingRegistergoed">
				<xsl:with-param name="aantalRegistergoederen" select="count(tia:IMKAD_ZakelijkRecht)"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="kopieOvereenkomst" select="tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_kopieovereenkomst']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_kopieovereenkomst']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space(current()/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_kopieovereenkomst']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
		<!-- 2.5	Verdeling en levering registergoederen -->
		<p>
			<xsl:text>De deelgenoten wensen </xsl:text>
			<xsl:choose>
				<xsl:when test="normalize-space($kopieOvereenkomst) != ''">
					<xsl:text>uitvoering te geven aan de overeenkomst van verdeling door de verdeling en levering van </xsl:text>
					<xsl:choose>
						<xsl:when test="$eenOfMeer = 'registergoed'">
							<xsl:text>het hierna te noemen registergoed bij deze akte te doen plaatsvinden.</xsl:text>
						</xsl:when>
						<xsl:when test="$eenOfMeer = 'registergoederen'">
							<xsl:text>de hierna te noemen registergoederen bij deze akte te doen plaatsvinden.</xsl:text>
						</xsl:when>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>de overeenkomst van verdeling bij deze akte vast te leggen en de verdeling en levering van </xsl:text>
					<xsl:choose>
						<xsl:when test="$eenOfMeer = 'registergoed'">
							<xsl:text>het hierna te noemen registergoed te doen plaatsvinden.</xsl:text>
						</xsl:when>
						<xsl:when test="$eenOfMeer = 'registergoederen'">
							<xsl:text>de hierna te noemen registergoederen te doen plaatsvinden.</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</p>
		<p>
			<xsl:text>B. OMSCHRIJVING </xsl:text>
			<xsl:choose>
				<xsl:when test="$eenOfMeer = 'registergoed'">
					<xsl:text>REGISTERGOED</xsl:text>
				</xsl:when>
				<xsl:when test="$eenOfMeer = 'registergoederen'">
					<xsl:text>REGISTERGOEDEREN</xsl:text>
				</xsl:when>
			</xsl:choose>
			<br/>
			<xsl:choose>
				<xsl:when test="$eenOfMeer = 'registergoed'">
					<xsl:text>Het toe te delen registergoed betreft:</xsl:text>
				</xsl:when>
				<xsl:when test="$eenOfMeer = 'registergoederen'">
					<xsl:text>De toe te delen registergoederen betreffen:</xsl:text>
				</xsl:when>
			</xsl:choose>
		</p>
		<xsl:apply-templates select="." mode="do-registered-objects"/>
		<xsl:apply-templates select="." mode="do-naming-property"/>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-naming-property
	*********************************************************
	Public: no

	Identity transform: no

	Description: Distribution deed naming property block.

	Input: tia:StukdeelVerdelingVennootschap, tia:StukdeelVerdelingHuwelijk, tia:StukdeelVerdelingPartnerschap or tia:StukdeelVerdelingGemeenschap

	Params: none

	Output: XHTML structure

	Calls:
	none

	Called by:
	(mode) do-properties
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:StukdeelVerdelingVennootschap | tia:StukdeelVerdelingHuwelijk | tia:StukdeelVerdelingPartnerschap | tia:StukdeelVerdelingGemeenschap | tia:StukdeelVerdelingUittredingVennoten" mode="do-naming-property">
		<xsl:variable name="eenOfMeer">
			<xsl:call-template name="benamingRegistergoed">
				<xsl:with-param name="aantalRegistergoederen" select="count(tia:IMKAD_ZakelijkRecht)"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="_registeredObjectGroups">
			<groups xmlns="">
				<xsl:for-each select="tia:IMKAD_ZakelijkRecht">
					<xsl:choose>
						<xsl:when test="$RegistergoedTonenPerPerceel='true'">
							<group xmlns="">
								<xsl:copy-of select="."/>
							</group>
						</xsl:when>
						<xsl:when test="not(tia:IMKAD_Perceel and preceding-sibling::tia:IMKAD_ZakelijkRecht[
				tia:aardVerkregen = current()/tia:aardVerkregen
			and normalize-space(tia:aardVerkregen) != ''
			and ((tia:aardVerkregenVariant
				 = current()/tia:aardVerkregenVariant)
				or (not(tia:aardVerkregenVariant)
					and not(current()/tia:aardVerkregenVariant)))					
				and ((tia:tia_Aantal_BP_Rechten
					= current()/tia:tia_Aantal_BP_Rechten)
				or (not(tia:tia_Aantal_BP_Rechten)
					and not(current()/tia:tia_Aantal_BP_Rechten)))
				and ((tia:tia_Aantal_Rechten
					= current()/tia:tia_Aantal_Rechten)
				or (not(tia:tia_Aantal_Rechten)
					and not(current()/tia:tia_Aantal_Rechten)))
				and ((tia:tia_Aantal_RechtenVariant
					= current()/tia:tia_Aantal_RechtenVariant)
				or (not(tia:tia_Aantal_RechtenVariant)
					and not(current()/tia:tia_Aantal_RechtenVariant)))
			and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven']/tia:tekst
					= current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven']/tia:tekst)
				or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven'])
					and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven'])))
			and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom']/tia:tekst
					= current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom']/tia:tekst)
				or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom'])
					and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom'])))
			and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoud']/tia:tekst
					= current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoud']/tia:tekst)
				or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoud'])
					and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoud'])))
			and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurend']/tia:tekst
					= current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurend']/tia:tekst)
				or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurend'])
					and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurend'])))
			and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijvenvariant']/tia:tekst
					= current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijvenvariant']/tia:tekst)
				or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijvenvariant'])
					and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijvenvariant'])))
			and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoudvariant']/tia:tekst
					= current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoudvariant']/tia:tekst)
				or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoudvariant'])
					and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoudvariant'])))
			and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurendvariant']/tia:tekst
					= current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurendvariant']/tia:tekst)
				or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurendvariant'])
					and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurendvariant'])))
			and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aantal_bp_rechtenvariant']/tia:tekst
					= current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aantal_bp_rechtenvariant']/tia:tekst)
				or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aantal_bp_rechtenvariant'])
					and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aantal_bp_rechtenvariant'])))
	        and	((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen']/tia:tekst
					= current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen']/tia:tekst)
				or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen'])
					and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen'])))
			and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_wijzevanlevering']/tia:tekst
					= current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_wijzevanlevering']/tia:tekst)
				or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_wijzevanlevering'])
					and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_wijzevanlevering'])))
			and ((tia:aandeelInRecht/tia:teller	= current()/tia:aandeelInRecht/tia:teller 
				and tia:aandeelInRecht/tia:noemer = current()/tia:aandeelInRecht/tia:noemer)
				or (not(tia:aandeelInRecht)
					and not(current()/tia:aandeelInRecht)))		
			and tia:IMKAD_Perceel[
				tia:tia_OmschrijvingEigendom
					= current()/tia:IMKAD_Perceel/tia:tia_OmschrijvingEigendom
				and normalize-space(tia:tia_OmschrijvingEigendom) != ''
				and ((tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid']/tia:tekst
						= current()/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid']/tia:tekst)
					or (not(tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid'])
						and not(current()/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid'])))
				and ((tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aanduiding']/tia:tekst
						= current()/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aanduiding']/tia:tekst)
					or (not(tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aanduiding'])
						and not(current()/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aanduiding'])))
				and ((tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_nabij']/tia:tekst
						= current()/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_nabij']/tia:tekst)
					or (not(tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_nabij'])
						and not(current()/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_nabij'])))
				and ((tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_komma']/tia:tekst
						= current()/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_komma']/tia:tekst)
					or (not(tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_komma'])
						and not(current()/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_komma'])))
				and ((tia:tia_SplitsingsverzoekOrdernummer
						= current()/tia:IMKAD_Perceel/tia:tia_SplitsingsverzoekOrdernummer)
					or (not(tia:tia_SplitsingsverzoekOrdernummer)
						and not(current()/tia:IMKAD_Perceel/tia:tia_SplitsingsverzoekOrdernummer)))
				and ((tia:stukVerificatiekosten/tia:reeks
						= current()/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:reeks)
					or (not(tia:stukVerificatiekosten/tia:reeks)
						and not(current()/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:reeks)))
				and ((tia:stukVerificatiekosten/tia:deel
						= current()/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:deel)
					or (not(tia:stukVerificatiekosten/tia:deel)
						and not(current()/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:deel)))
				and ((tia:stukVerificatiekosten/tia:nummer
						= current()/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:nummer)
					or (not(tia:stukVerificatiekosten/tia:nummer)
						and not(current()/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:nummer)))
				and tia:kadastraleAanduiding/tia:gemeente
					= current()/tia:IMKAD_Perceel/tia:kadastraleAanduiding/tia:gemeente
				and normalize-space(tia:kadastraleAanduiding/tia:gemeente) != ''
				and tia:kadastraleAanduiding/tia:sectie
					= current()/tia:IMKAD_Perceel/tia:kadastraleAanduiding/tia:sectie
				and normalize-space(tia:kadastraleAanduiding/tia:sectie) != ''
				and tia:IMKAD_OZLocatie/tia:ligging
					= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:ligging
				and normalize-space(tia:IMKAD_OZLocatie/tia:ligging) != ''
				and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer
					= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer)
					or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer)
						and not(current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer)))
				and  ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter
						= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter)
					or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter)
						and not(current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter)))
				and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging
						= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging)
					or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging)
						and not(current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging)))
				and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode
						= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode)
					or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode)
						and not(current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode)))
				and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam
					= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam)
					or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam)
						and not(current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam)))
			    and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam
					= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam)
					or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam)
						and not(current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam)))
				and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:postcode
					= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:postcode)
					or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:postcode)
						and not(current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:postcode)))
				and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:woonplaatsNaam
					= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:woonplaatsNaam)
					or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:woonplaatsNaam)
						and not(current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:woonplaatsNaam)))
				and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:openbareRuimteNaam
					= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:openbareRuimteNaam)
					or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:openbareRuimteNaam)
						and not(current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:openbareRuimteNaam)))				
				and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummer
					= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummer)
					or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummer)
						and not(current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummer)))
				and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisLetter
					= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisLetter)
					or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisLetter)
						and not(current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisLetter)))
				and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummerToevoeging
					= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummerToevoeging)
					or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummerToevoeging)
						and not(current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummerToevoeging)))]])">
							<group xmlns="">
								<xsl:copy-of select=". | following-sibling::tia:IMKAD_ZakelijkRecht[
				tia:aardVerkregen = current()/tia:aardVerkregen
			and normalize-space(tia:aardVerkregen) != ''
			and ((tia:aardVerkregenVariant
				 = current()/tia:aardVerkregenVariant)
				or (not(tia:aardVerkregenVariant)
					and not(current()/tia:aardVerkregenVariant)))					
				and ((tia:tia_Aantal_BP_Rechten
					= current()/tia:tia_Aantal_BP_Rechten)
				or (not(tia:tia_Aantal_BP_Rechten)
					and not(current()/tia:tia_Aantal_BP_Rechten)))
				and ((tia:tia_Aantal_Rechten
					= current()/tia:tia_Aantal_Rechten)
				or (not(tia:tia_Aantal_Rechten)
					and not(current()/tia:tia_Aantal_Rechten)))
				and ((tia:tia_Aantal_RechtenVariant
					= current()/tia:tia_Aantal_RechtenVariant)
				or (not(tia:tia_Aantal_RechtenVariant)
					and not(current()/tia:tia_Aantal_RechtenVariant)))
			and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven']/tia:tekst
					= current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven']/tia:tekst)
				or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven'])
					and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven'])))
			and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom']/tia:tekst
					= current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom']/tia:tekst)
				or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom'])
					and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom'])))
			and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoud']/tia:tekst
					= current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoud']/tia:tekst)
				or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoud'])
					and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoud'])))
			and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurend']/tia:tekst
					= current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurend']/tia:tekst)
				or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurend'])
					and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurend'])))
			and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijvenvariant']/tia:tekst
					= current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijvenvariant']/tia:tekst)
				or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijvenvariant'])
					and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijvenvariant'])))
			and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoudvariant']/tia:tekst
					= current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoudvariant']/tia:tekst)
				or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoudvariant'])
					and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoudvariant'])))
			and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurendvariant']/tia:tekst
					= current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurendvariant']/tia:tekst)
				or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurendvariant'])
					and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurendvariant'])))
			and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aantal_bp_rechtenvariant']/tia:tekst
					= current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aantal_bp_rechtenvariant']/tia:tekst)
				or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aantal_bp_rechtenvariant'])
					and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aantal_bp_rechtenvariant'])))
	        and	((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen']/tia:tekst
					= current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen']/tia:tekst)
				or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen'])
					and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen'])))
			and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_wijzevanlevering']/tia:tekst
					= current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_wijzevanlevering']/tia:tekst)
				or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_wijzevanlevering'])
					and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_wijzevanlevering'])))
			and ((tia:aandeelInRecht/tia:teller	= current()/tia:aandeelInRecht/tia:teller 
				and tia:aandeelInRecht/tia:noemer = current()/tia:aandeelInRecht/tia:noemer)
				or (not(tia:aandeelInRecht)
					and not(current()/tia:aandeelInRecht)))		
			and tia:IMKAD_Perceel[
				tia:tia_OmschrijvingEigendom
					= current()/tia:IMKAD_Perceel/tia:tia_OmschrijvingEigendom
				and normalize-space(tia:tia_OmschrijvingEigendom) != ''
				and ((tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid']/tia:tekst
						= current()/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid']/tia:tekst)
					or (not(tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid'])
						and not(current()/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid'])))
				and ((tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aanduiding']/tia:tekst
						= current()/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aanduiding']/tia:tekst)
					or (not(tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aanduiding'])
						and not(current()/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aanduiding'])))
				and ((tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_nabij']/tia:tekst
						= current()/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_nabij']/tia:tekst)
					or (not(tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_nabij'])
						and not(current()/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_nabij'])))
				and ((tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_komma']/tia:tekst
						= current()/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_komma']/tia:tekst)
					or (not(tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_komma'])
						and not(current()/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_komma'])))
				and ((tia:tia_SplitsingsverzoekOrdernummer
						= current()/tia:IMKAD_Perceel/tia:tia_SplitsingsverzoekOrdernummer)
					or (not(tia:tia_SplitsingsverzoekOrdernummer)
						and not(current()/tia:IMKAD_Perceel/tia:tia_SplitsingsverzoekOrdernummer)))
				and ((tia:stukVerificatiekosten/tia:reeks
						= current()/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:reeks)
					or (not(tia:stukVerificatiekosten/tia:reeks)
						and not(current()/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:reeks)))
				and ((tia:stukVerificatiekosten/tia:deel
						= current()/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:deel)
					or (not(tia:stukVerificatiekosten/tia:deel)
						and not(current()/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:deel)))
				and ((tia:stukVerificatiekosten/tia:nummer
						= current()/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:nummer)
					or (not(tia:stukVerificatiekosten/tia:nummer)
						and not(current()/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:nummer)))
				and tia:kadastraleAanduiding/tia:gemeente
					= current()/tia:IMKAD_Perceel/tia:kadastraleAanduiding/tia:gemeente
				and normalize-space(tia:kadastraleAanduiding/tia:gemeente) != ''
				and tia:kadastraleAanduiding/tia:sectie
					= current()/tia:IMKAD_Perceel/tia:kadastraleAanduiding/tia:sectie
				and normalize-space(tia:kadastraleAanduiding/tia:sectie) != ''
				and tia:IMKAD_OZLocatie/tia:ligging
					= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:ligging
				and normalize-space(tia:IMKAD_OZLocatie/tia:ligging) != ''
				and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer
					= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer)
					or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer)
						and not(current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer)))
				and  ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter
						= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter)
					or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter)
						and not(current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter)))
				and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging
						= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging)
					or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging)
						and not(current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging)))
				and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode
						= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode)
					or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode)
						and not(current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode)))
				and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam
					= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam)
					or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam)
						and not(current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam)))
			    and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam
					= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam)
					or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam)
						and not(current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam)))
				and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:postcode
					= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:postcode)
					or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:postcode)
						and not(current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:postcode)))
				and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:woonplaatsNaam
					= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:woonplaatsNaam)
					or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:woonplaatsNaam)
						and not(current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:woonplaatsNaam)))
				and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:openbareRuimteNaam
					= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:openbareRuimteNaam)
					or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:openbareRuimteNaam)
						and not(current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:openbareRuimteNaam)))				
				and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummer
					= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummer)
					or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummer)
						and not(current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummer)))
				and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisLetter
					= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisLetter)
					or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisLetter)
						and not(current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisLetter)))
				and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummerToevoeging
					= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummerToevoeging)
					or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummerToevoeging)
						and not(current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummerToevoeging)))]]"/>
							</group>
						</xsl:when>
					</xsl:choose>
				</xsl:for-each>
			</groups>
		</xsl:variable>
		<xsl:variable name="registeredObjectGroups" select="exslt:node-set($_registeredObjectGroups)"/>
		<p>
			<xsl:choose>
				<xsl:when test="tia:verkrijgerRechtRef and not(tia:IMKAD_ZakelijkRecht[tia:verkrijgerRechtRef or tia:Toedeling/tia:verkrijgerRechtRef])">
					<xsl:text>hierna ook te noemen: "</xsl:text>
					<xsl:choose>
						<xsl:when test="$eenOfMeer = 'registergoed'">
							<u>
								<xsl:text>het registergoed</xsl:text>
							</u>
						</xsl:when>
						<xsl:when test="$eenOfMeer = 'registergoederen'">
							<u>
								<xsl:text>de registergoederen</xsl:text>
							</u>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text/>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:text>".</xsl:text>
				</xsl:when>
				<xsl:when test="tia:IMKAD_ZakelijkRecht[tia:verkrijgerRechtRef or tia:Toedeling/tia:verkrijgerRechtRef]">
					<xsl:for-each select="$registeredObjectGroups/groups/group">
						<xsl:text>Het hiervoor onder </xsl:text>
						<xsl:number value="position()" format="a"/>
						<xsl:text>. omschreven registergoed wordt hierna aangeduid met: "</xsl:text>
						<u>
							<xsl:text>het registergoed </xsl:text>
							<xsl:number value="position()"/>
						</u>
						<xsl:text>".</xsl:text>
						<xsl:if test="position() != last()">
							<br/>
						</xsl:if>
					</xsl:for-each>
				</xsl:when>
			</xsl:choose>
		</p>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-division
	*********************************************************
	Public: no

	Identity transform: no

	Description: Distribution deed division block.

	Input: tia:StukdeelVerdelingVennootschap, tia:StukdeelVerdelingHuwelijk, tia:StukdeelVerdelingPartnerschap, tia:StukdeelVerdelingGemeenschap of tia:StukdeelVerdelingUittredingVennoten

	Params: none

	Output: XHTML structure

	Calls:
	(none)

	Called by:
	(mode) do-deed
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:StukdeelVerdelingVennootschap | tia:StukdeelVerdelingHuwelijk | tia:StukdeelVerdelingPartnerschap | tia:StukdeelVerdelingGemeenschap | tia:StukdeelVerdelingUittredingVennoten" mode="do-division">
		<xsl:variable name="eenOfMeer">
			<xsl:call-template name="benamingRegistergoed">
				<xsl:with-param name="aantalRegistergoederen" select="count(tia:IMKAD_ZakelijkRecht)"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="root" select="."/>
		<xsl:variable name="_registeredObjectGroups">
			<groups xmlns="">
				<xsl:for-each select="tia:IMKAD_ZakelijkRecht">
					<xsl:choose>
						<xsl:when test="$RegistergoedTonenPerPerceel='true'">
							<group xmlns="">
								<xsl:copy-of select="."/>
							</group>
						</xsl:when>
						<xsl:when test="not(tia:IMKAD_Perceel and preceding-sibling::tia:IMKAD_ZakelijkRecht[
				tia:aardVerkregen = current()/tia:aardVerkregen
			and normalize-space(tia:aardVerkregen) != ''
			and ((tia:aardVerkregenVariant
				 = current()/tia:aardVerkregenVariant)
				or (not(tia:aardVerkregenVariant)
					and not(current()/tia:aardVerkregenVariant)))					
				and ((tia:tia_Aantal_BP_Rechten
					= current()/tia:tia_Aantal_BP_Rechten)
				or (not(tia:tia_Aantal_BP_Rechten)
					and not(current()/tia:tia_Aantal_BP_Rechten)))
				and ((tia:tia_Aantal_Rechten
					= current()/tia:tia_Aantal_Rechten)
				or (not(tia:tia_Aantal_Rechten)
					and not(current()/tia:tia_Aantal_Rechten)))
				and ((tia:tia_Aantal_RechtenVariant
					= current()/tia:tia_Aantal_RechtenVariant)
				or (not(tia:tia_Aantal_RechtenVariant)
					and not(current()/tia:tia_Aantal_RechtenVariant)))
			and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven']/tia:tekst
					= current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven']/tia:tekst)
				or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven'])
					and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven'])))
			and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom']/tia:tekst
					= current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom']/tia:tekst)
				or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom'])
					and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom'])))
			and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoud']/tia:tekst
					= current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoud']/tia:tekst)
				or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoud'])
					and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoud'])))
			and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurend']/tia:tekst
					= current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurend']/tia:tekst)
				or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurend'])
					and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurend'])))
			and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijvenvariant']/tia:tekst
					= current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijvenvariant']/tia:tekst)
				or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijvenvariant'])
					and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijvenvariant'])))
			and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoudvariant']/tia:tekst
					= current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoudvariant']/tia:tekst)
				or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoudvariant'])
					and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoudvariant'])))
			and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurendvariant']/tia:tekst
					= current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurendvariant']/tia:tekst)
				or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurendvariant'])
					and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurendvariant'])))
			and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aantal_bp_rechtenvariant']/tia:tekst
					= current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aantal_bp_rechtenvariant']/tia:tekst)
				or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aantal_bp_rechtenvariant'])
					and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aantal_bp_rechtenvariant'])))
	        and	((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen']/tia:tekst
					= current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen']/tia:tekst)
				or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen'])
					and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen'])))
			and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_wijzevanlevering']/tia:tekst
					= current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_wijzevanlevering']/tia:tekst)
				or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_wijzevanlevering'])
					and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_wijzevanlevering'])))
			and ((tia:aandeelInRecht/tia:teller	= current()/tia:aandeelInRecht/tia:teller 
				and tia:aandeelInRecht/tia:noemer = current()/tia:aandeelInRecht/tia:noemer)
				or (not(tia:aandeelInRecht)
					and not(current()/tia:aandeelInRecht)))		
			and tia:IMKAD_Perceel[
				tia:tia_OmschrijvingEigendom
					= current()/tia:IMKAD_Perceel/tia:tia_OmschrijvingEigendom
				and normalize-space(tia:tia_OmschrijvingEigendom) != ''
				and ((tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid']/tia:tekst
						= current()/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid']/tia:tekst)
					or (not(tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid'])
						and not(current()/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid'])))
				and ((tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aanduiding']/tia:tekst
						= current()/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aanduiding']/tia:tekst)
					or (not(tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aanduiding'])
						and not(current()/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aanduiding'])))
				and ((tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_nabij']/tia:tekst
						= current()/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_nabij']/tia:tekst)
					or (not(tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_nabij'])
						and not(current()/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_nabij'])))
				and ((tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_komma']/tia:tekst
						= current()/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_komma']/tia:tekst)
					or (not(tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_komma'])
						and not(current()/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_komma'])))
				and ((tia:tia_SplitsingsverzoekOrdernummer
						= current()/tia:IMKAD_Perceel/tia:tia_SplitsingsverzoekOrdernummer)
					or (not(tia:tia_SplitsingsverzoekOrdernummer)
						and not(current()/tia:IMKAD_Perceel/tia:tia_SplitsingsverzoekOrdernummer)))
				and ((tia:stukVerificatiekosten/tia:reeks
						= current()/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:reeks)
					or (not(tia:stukVerificatiekosten/tia:reeks)
						and not(current()/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:reeks)))
				and ((tia:stukVerificatiekosten/tia:deel
						= current()/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:deel)
					or (not(tia:stukVerificatiekosten/tia:deel)
						and not(current()/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:deel)))
				and ((tia:stukVerificatiekosten/tia:nummer
						= current()/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:nummer)
					or (not(tia:stukVerificatiekosten/tia:nummer)
						and not(current()/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:nummer)))
				and tia:kadastraleAanduiding/tia:gemeente
					= current()/tia:IMKAD_Perceel/tia:kadastraleAanduiding/tia:gemeente
				and normalize-space(tia:kadastraleAanduiding/tia:gemeente) != ''
				and tia:kadastraleAanduiding/tia:sectie
					= current()/tia:IMKAD_Perceel/tia:kadastraleAanduiding/tia:sectie
				and normalize-space(tia:kadastraleAanduiding/tia:sectie) != ''
				and tia:IMKAD_OZLocatie/tia:ligging
					= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:ligging
				and normalize-space(tia:IMKAD_OZLocatie/tia:ligging) != ''
				and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer
					= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer)
					or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer)
						and not(current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer)))
				and  ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter
						= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter)
					or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter)
						and not(current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter)))
				and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging
						= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging)
					or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging)
						and not(current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging)))
				and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode
						= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode)
					or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode)
						and not(current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode)))
				and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam
					= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam)
					or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam)
						and not(current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam)))
			    and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam
					= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam)
					or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam)
						and not(current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam)))
				and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:postcode
					= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:postcode)
					or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:postcode)
						and not(current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:postcode)))
				and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:woonplaatsNaam
					= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:woonplaatsNaam)
					or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:woonplaatsNaam)
						and not(current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:woonplaatsNaam)))
				and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:openbareRuimteNaam
					= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:openbareRuimteNaam)
					or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:openbareRuimteNaam)
						and not(current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:openbareRuimteNaam)))				
				and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummer
					= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummer)
					or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummer)
						and not(current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummer)))
				and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisLetter
					= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisLetter)
					or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisLetter)
						and not(current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisLetter)))
				and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummerToevoeging
					= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummerToevoeging)
					or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummerToevoeging)
						and not(current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummerToevoeging)))]])">
							<group xmlns="">
								<xsl:copy-of select=". | following-sibling::tia:IMKAD_ZakelijkRecht[
				tia:aardVerkregen = current()/tia:aardVerkregen
			and normalize-space(tia:aardVerkregen) != ''
			and ((tia:aardVerkregenVariant
				 = current()/tia:aardVerkregenVariant)
				or (not(tia:aardVerkregenVariant)
					and not(current()/tia:aardVerkregenVariant)))					
				and ((tia:tia_Aantal_BP_Rechten
					= current()/tia:tia_Aantal_BP_Rechten)
				or (not(tia:tia_Aantal_BP_Rechten)
					and not(current()/tia:tia_Aantal_BP_Rechten)))
				and ((tia:tia_Aantal_Rechten
					= current()/tia:tia_Aantal_Rechten)
				or (not(tia:tia_Aantal_Rechten)
					and not(current()/tia:tia_Aantal_Rechten)))
				and ((tia:tia_Aantal_RechtenVariant
					= current()/tia:tia_Aantal_RechtenVariant)
				or (not(tia:tia_Aantal_RechtenVariant)
					and not(current()/tia:tia_Aantal_RechtenVariant)))
			and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven']/tia:tekst
					= current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven']/tia:tekst)
				or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven'])
					and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven'])))
			and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom']/tia:tekst
					= current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom']/tia:tekst)
				or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom'])
					and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom'])))
			and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoud']/tia:tekst
					= current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoud']/tia:tekst)
				or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoud'])
					and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoud'])))
			and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurend']/tia:tekst
					= current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurend']/tia:tekst)
				or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurend'])
					and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurend'])))
			and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijvenvariant']/tia:tekst
					= current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijvenvariant']/tia:tekst)
				or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijvenvariant'])
					and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijvenvariant'])))
			and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoudvariant']/tia:tekst
					= current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoudvariant']/tia:tekst)
				or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoudvariant'])
					and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoudvariant'])))
			and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurendvariant']/tia:tekst
					= current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurendvariant']/tia:tekst)
				or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurendvariant'])
					and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurendvariant'])))
			and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aantal_bp_rechtenvariant']/tia:tekst
					= current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aantal_bp_rechtenvariant']/tia:tekst)
				or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aantal_bp_rechtenvariant'])
					and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aantal_bp_rechtenvariant'])))
	        and	((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen']/tia:tekst
					= current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen']/tia:tekst)
				or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen'])
					and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen'])))
			and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_wijzevanlevering']/tia:tekst
					= current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_wijzevanlevering']/tia:tekst)
				or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_wijzevanlevering'])
					and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_wijzevanlevering'])))
			and ((tia:aandeelInRecht/tia:teller	= current()/tia:aandeelInRecht/tia:teller 
				and tia:aandeelInRecht/tia:noemer = current()/tia:aandeelInRecht/tia:noemer)
				or (not(tia:aandeelInRecht)
					and not(current()/tia:aandeelInRecht)))		
			and tia:IMKAD_Perceel[
				tia:tia_OmschrijvingEigendom
					= current()/tia:IMKAD_Perceel/tia:tia_OmschrijvingEigendom
				and normalize-space(tia:tia_OmschrijvingEigendom) != ''
				and ((tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid']/tia:tekst
						= current()/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid']/tia:tekst)
					or (not(tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid'])
						and not(current()/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid'])))
				and ((tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aanduiding']/tia:tekst
						= current()/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aanduiding']/tia:tekst)
					or (not(tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aanduiding'])
						and not(current()/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aanduiding'])))
				and ((tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_nabij']/tia:tekst
						= current()/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_nabij']/tia:tekst)
					or (not(tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_nabij'])
						and not(current()/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_nabij'])))
				and ((tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_komma']/tia:tekst
						= current()/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_komma']/tia:tekst)
					or (not(tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_komma'])
						and not(current()/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_komma'])))
				and ((tia:tia_SplitsingsverzoekOrdernummer
						= current()/tia:IMKAD_Perceel/tia:tia_SplitsingsverzoekOrdernummer)
					or (not(tia:tia_SplitsingsverzoekOrdernummer)
						and not(current()/tia:IMKAD_Perceel/tia:tia_SplitsingsverzoekOrdernummer)))
				and ((tia:stukVerificatiekosten/tia:reeks
						= current()/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:reeks)
					or (not(tia:stukVerificatiekosten/tia:reeks)
						and not(current()/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:reeks)))
				and ((tia:stukVerificatiekosten/tia:deel
						= current()/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:deel)
					or (not(tia:stukVerificatiekosten/tia:deel)
						and not(current()/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:deel)))
				and ((tia:stukVerificatiekosten/tia:nummer
						= current()/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:nummer)
					or (not(tia:stukVerificatiekosten/tia:nummer)
						and not(current()/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:nummer)))
				and tia:kadastraleAanduiding/tia:gemeente
					= current()/tia:IMKAD_Perceel/tia:kadastraleAanduiding/tia:gemeente
				and normalize-space(tia:kadastraleAanduiding/tia:gemeente) != ''
				and tia:kadastraleAanduiding/tia:sectie
					= current()/tia:IMKAD_Perceel/tia:kadastraleAanduiding/tia:sectie
				and normalize-space(tia:kadastraleAanduiding/tia:sectie) != ''
				and tia:IMKAD_OZLocatie/tia:ligging
					= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:ligging
				and normalize-space(tia:IMKAD_OZLocatie/tia:ligging) != ''
				and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer
					= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer)
					or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer)
						and not(current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer)))
				and  ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter
						= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter)
					or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter)
						and not(current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter)))
				and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging
						= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging)
					or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging)
						and not(current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging)))
				and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode
						= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode)
					or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode)
						and not(current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode)))
				and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam
					= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam)
					or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam)
						and not(current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam)))
			    and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam
					= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam)
					or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam)
						and not(current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam)))
				and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:postcode
					= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:postcode)
					or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:postcode)
						and not(current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:postcode)))
				and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:woonplaatsNaam
					= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:woonplaatsNaam)
					or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:woonplaatsNaam)
						and not(current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:woonplaatsNaam)))
				and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:openbareRuimteNaam
					= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:openbareRuimteNaam)
					or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:openbareRuimteNaam)
						and not(current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:openbareRuimteNaam)))				
				and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummer
					= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummer)
					or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummer)
						and not(current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummer)))
				and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisLetter
					= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisLetter)
					or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisLetter)
						and not(current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisLetter)))
				and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummerToevoeging
					= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummerToevoeging)
					or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummerToevoeging)
						and not(current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummerToevoeging)))]]"/>
							</group>
						</xsl:when>
					</xsl:choose>
				</xsl:for-each>
			</groups>
		</xsl:variable>
		<xsl:variable name="registeredObjectGroups" select="exslt:node-set($_registeredObjectGroups)"/>
		<xsl:variable name="verdelingVanaf" select="tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verdelingvanaf']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verdelingvanaf']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space(current()/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verdelingvanaf']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
		<xsl:choose>
			<xsl:when test="tia:verkrijgerRechtRef and not(tia:IMKAD_ZakelijkRecht[tia:verkrijgerRechtRef or tia:Toedeling/tia:verkrijgerRechtRef])">
				<p>
					<xsl:text>C. VERDELING</xsl:text>
					<br/>
					<xsl:text>De deelgenoten gaan hierbij over tot verdeling van </xsl:text>
					<xsl:choose>
						<xsl:when test="$eenOfMeer = 'registergoed'">
							<xsl:text>het registergoed</xsl:text>
						</xsl:when>
						<xsl:when test="$eenOfMeer = 'registergoederen'">
							<xsl:text>de registergoederen</xsl:text>
						</xsl:when>
					</xsl:choose>
					<xsl:text> en delen </xsl:text>
					<xsl:choose>
						<xsl:when test="$eenOfMeer = 'registergoed'">
							<xsl:text>het registergoed</xsl:text>
						</xsl:when>
						<xsl:when test="$eenOfMeer = 'registergoederen'">
							<xsl:text>de registergoederen</xsl:text>
						</xsl:when>
					</xsl:choose>
					<xsl:text> </xsl:text>
					<xsl:value-of select="$verdelingVanaf"/>
					<xsl:text> toe aan </xsl:text>
					<xsl:for-each select="tia:verkrijgerRechtRef">
						<xsl:value-of select="../../tia:Partij[@id = substring-after(current()/@xlink:href, '#')]/tia:aanduidingPartij"/>
						<xsl:choose>
							<xsl:when test="position() = last() - 1">
								<xsl:text> en </xsl:text>
							</xsl:when>
							<xsl:when test="position() != last()">
								<xsl:text>, </xsl:text>
							</xsl:when>
						</xsl:choose>
					</xsl:for-each>
					<xsl:text>.</xsl:text>
				</p>
			</xsl:when>
			<xsl:when test="tia:IMKAD_ZakelijkRecht[tia:verkrijgerRechtRef or tia:Toedeling/tia:verkrijgerRechtRef]">
				<p>
					<xsl:text>C. VERDELING</xsl:text>
					<br/>
					<xsl:text>De deelgenoten gaan hierbij over tot verdeling van de registergoederen en delen </xsl:text>
					<xsl:value-of select="$verdelingVanaf"/>
					<xsl:text> toe als volgt:</xsl:text>
				</p>
				<table cellspacing="0" cellpadding="0">
					<tbody>
						<xsl:for-each select="$registeredObjectGroups/groups/group">
							<xsl:if test="tia:IMKAD_ZakelijkRecht/tia:verkrijgerRechtRef or tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef">
								<tr>
									<td class="number" valign="top">
										<xsl:text>-</xsl:text>
									</td>
									<td>
										<xsl:text>het registergoed </xsl:text>
										<xsl:value-of select="position()"/>
										<xsl:text> aan </xsl:text>
										<xsl:for-each select="tia:IMKAD_ZakelijkRecht/tia:verkrijgerRechtRef | tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef">
											<xsl:variable name="processsedPartyId">
												<xsl:value-of select="$root/../tia:Partij[concat('#',@id) = current()/@xlink:href or tia:IMKAD_Persoon[concat('#',@id) = current()/@xlink:href]]/@id"/>
											</xsl:variable>
											<!-- check if person's party is already processed and printed -->
											<xsl:variable name="toedelingVerkrijgerAlreadyProcessed">
												<xsl:choose>
													<xsl:when test="(count(../preceding-sibling::tia:Toedeling/tia:verkrijgerRechtRef[$root/../tia:Partij[tia:IMKAD_Persoon[concat('#',@id) = current()/@xlink:href]]/@id])
																	+ count(../preceding-sibling::tia:verkrijgerRechtRef[concat('#',$processsedPartyId) = @xlink:href])
																	+ count(preceding-sibling::tia:Toedeling/tia:verkrijgerRechtRef[$root/../tia:Partij[tia:IMKAD_Persoon[concat('#',@id) = current()/@xlink:href]]/@id])
																	+ count(preceding-sibling::tia:verkrijgerRechtRef[concat('#',$processsedPartyId) = @xlink:href]))
																	+ count(../preceding-sibling::tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef[$root/../tia:Partij[tia:IMKAD_Persoon[concat('#',@id) = current()/@xlink:href]]/@id])
																	+ count(../preceding-sibling::tia:IMKAD_ZakelijkRecht/tia:verkrijgerRechtRef[concat('#',$processsedPartyId) = @xlink:href])
																	+ count(preceding-sibling::tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef[$root/../tia:Partij[tia:IMKAD_Persoon[concat('#',@id) = current()/@xlink:href]]/@id])
																	+ count(preceding-sibling::tia:IMKAD_ZakelijkRecht/tia:verkrijgerRechtRef[concat('#',$processsedPartyId) = @xlink:href]) > 0">
														<xsl:text>true</xsl:text>
													</xsl:when>
													<xsl:otherwise>
														<xsl:text>false</xsl:text>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:variable>
											<!-- check if currently processed acquirer is actually the last one -->
											<xsl:variable name="numberOfFollowingVerkrijgers" select="count(../following-sibling::tia:Toedeling/tia:verkrijgerRechtRef[$root/../tia:Partij[tia:IMKAD_Persoon[concat('#',@id) = @xlink:href]]/@id != $processsedPartyId])
																		+ count(../following-sibling::tia:verkrijgerRechtRef[concat('#',$processsedPartyId) != @xlink:href])
																		+ count(following-sibling::tia:Toedeling/tia:verkrijgerRechtRef[$root/../tia:Partij[tia:IMKAD_Persoon[concat('#',@id) = @xlink:href]]/@id != $processsedPartyId])
																		+ count(following-sibling::tia:verkrijgerRechtRef[concat('#',$processsedPartyId) != @xlink:href])
																		+ count(../following-sibling::tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef[$root/../tia:Partij[tia:IMKAD_Persoon[concat('#',@id) = @xlink:href]]/@id != $processsedPartyId])
																		+ count(../following-sibling::tia:IMKAD_ZakelijkRecht/tia:verkrijgerRechtRef[concat('#',$processsedPartyId) != @xlink:href])
																		+ count(following-sibling::tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef[$root/../tia:Partij[tia:IMKAD_Persoon[concat('#',@id) = @xlink:href]]/@id != $processsedPartyId])
																		+ count(following-sibling::tia:IMKAD_ZakelijkRecht/tia:verkrijgerRechtRef[concat('#',$processsedPartyId) != @xlink:href])"/>
											<xsl:variable name="isLastVerkrijger">
												<xsl:choose>
													<xsl:when test="$numberOfFollowingVerkrijgers = 0">
														<xsl:text>true</xsl:text>
													</xsl:when>
													<xsl:otherwise>
														<xsl:text>false</xsl:text>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:variable>
											<xsl:if test="translate($toedelingVerkrijgerAlreadyProcessed, $upper, $lower) != 'true'">
												<xsl:value-of select="$root/../tia:Partij[@id = substring-after(current()/@xlink:href, '#')
													or tia:IMKAD_Persoon[@id = substring-after(current()/@xlink:href, '#')]]/tia:aanduidingPartij"/>
											</xsl:if>
											<xsl:if test="translate($isLastVerkrijger, $upper, $lower) != 'true'">
												<xsl:choose>
													<xsl:when test="$numberOfFollowingVerkrijgers = 1">
														<xsl:text> en </xsl:text>
													</xsl:when>
													<xsl:otherwise>
														<xsl:text>, </xsl:text>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:if>
										</xsl:for-each>
										<xsl:choose>
											<xsl:when test="following-sibling::group[tia:IMKAD_ZakelijkRecht/tia:verkrijgerRechtRef or tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef]
													and position() != last()">
												<xsl:text>;</xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text>.</xsl:text>
											</xsl:otherwise>
										</xsl:choose>
									</td>
								</tr>
							</xsl:if>
						</xsl:for-each>
					</tbody>
				</table>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-distribution
	*********************************************************
	Public: no

	Identity transform: no

	Description: Distribution deed transfer of title block.

	Input: tia:StukdeelVerdelingVennootschap, tia:StukdeelVerdelingHuwelijk, tia:StukdeelVerdelingPartnerschap, tia:StukdeelVerdelingGemeenschap of tia:StukdeelVerdelingUittredingVennoten

	Params: none

	Output: XHTML structure

	Calls:
	(mode) do-allocation-to-different-persons-within-one-party
	(mode) do-allocation-to-one-or-more-parties-with-equal-shares-for-each-of-the-persons
	(mode) do-allocation-header
	(name) isAlocationToSpecificPartiesTheSame
	(name) groupPartiesAndRights
	(name) groupParties
	(name) groupPersonsAndRights
	(match) groups

	Called by:
	(mode) do-deed
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:StukdeelVerdelingVennootschap | tia:StukdeelVerdelingHuwelijk | tia:StukdeelVerdelingPartnerschap | tia:StukdeelVerdelingGemeenschap | tia:StukdeelVerdelingUittredingVennoten" mode="do-distribution">
		<xsl:variable name="root" select="."/>
		<xsl:variable name="isAlocationToSpecificPartiesTheSame">
			<xsl:choose>
				<xsl:when test="count(tia:IMKAD_ZakelijkRecht) = count(tia:IMKAD_ZakelijkRecht[
									count(tia:verkrijgerRechtRef) = count(current()/tia:IMKAD_ZakelijkRecht[1]/tia:verkrijgerRechtRef) and normalize-space(tia:verkrijgerRechtRef/@xlink:href) != ''])">
					<xsl:call-template name="isAlocationToSpecificPartiesTheSame">
						<xsl:with-param name="stukdeelNode" select="."/>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'false'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:choose>
			<!-- Variant 1 -->
			<xsl:when test="tia:verkrijgerRechtRef and not(tia:IMKAD_ZakelijkRecht/tia:verkrijgerRechtRef) and (count(../tia:Partij[concat('#', @id) = current()/tia:verkrijgerRechtRef/@xlink:href]/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']/tia:tia_AandeelInRechten)
								+ count(../tia:Partij[concat('#', @id) = current()/tia:verkrijgerRechtRef/@xlink:href]/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']/tia:tia_AandeelInRechten)
								+ count(../tia:Partij[concat('#', @id) = current()/tia:verkrijgerRechtRef/@xlink:href]/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']/tia:tia_AandeelInRechten)) = 0
								and count(tia:IMKAD_ZakelijkRecht/tia:Toedeling) = 0">
				<xsl:variable name="_parties">
					<tia:root>
						<xsl:copy-of select="current()/../tia:Partij[concat('#', @id) = current()/tia:verkrijgerRechtRef/@xlink:href]"/>
					</tia:root>
				</xsl:variable>
				<xsl:variable name="parties" select="exslt:node-set($_parties)"/>
				<xsl:variable name="onverdeeld">
					<xsl:value-of select="tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
						translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
						translate(normalize-space(current()/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
				</xsl:variable>
				<p>
					<xsl:apply-templates select="." mode="do-allocation-header">
						<xsl:with-param name="dubbelePunt" select="''"/>
					</xsl:apply-templates>
					<xsl:apply-templates select="." mode="do-allocation-to-one-or-more-parties-with-equal-shares-for-each-of-the-persons-variantA1">
						<xsl:with-param name="parties" select="$parties"/>
						<xsl:with-param name="onverdeeld" select="$onverdeeld"/>
						<xsl:with-param name="jointAllocation" select="'true'"/>
					</xsl:apply-templates>
					<xsl:text>.</xsl:text>
				</p>
			</xsl:when>
			<!-- Variant 2 -->
			<xsl:when test="count(tia:verkrijgerRechtRef) = 1 and not(tia:IMKAD_ZakelijkRecht/tia:verkrijgerRechtRef) and (count(../tia:Partij[concat('#', @id) = current()/tia:verkrijgerRechtRef/@xlink:href]/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']/tia:tia_AandeelInRechten)
								+ count(../tia:Partij[concat('#', @id) = current()/tia:verkrijgerRechtRef/@xlink:href]/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']/tia:tia_AandeelInRechten)
								+ count(../tia:Partij[concat('#', @id) = current()/tia:verkrijgerRechtRef/@xlink:href]/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']/tia:tia_AandeelInRechten)) > 0
								and count(tia:IMKAD_ZakelijkRecht/tia:Toedeling) = 0">
				<p>
					<xsl:apply-templates select="." mode="do-allocation-header">
						<xsl:with-param name="dubbelePunt" select="':'"/>
					</xsl:apply-templates>
				</p>
				<xsl:apply-templates select="." mode="do-allocation-to-different-persons-within-one-party">
					<xsl:with-param name="authorizedRepresentative" select="../tia:Partij[concat('#', @id) = current()/tia:verkrijgerRechtRef/@xlink:href]/tia:Gevolmachtigde"/>
					<xsl:with-param name="acquiringPersons" select="../tia:Partij[concat('#', @id) = current()/tia:verkrijgerRechtRef/@xlink:href]/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true' and tia:tia_AandeelInRechten]
																	| ../tia:Partij[concat('#', @id) = current()/tia:verkrijgerRechtRef/@xlink:href]/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true' and tia:tia_AandeelInRechten]
																	| ../tia:Partij[concat('#', @id) = current()/tia:verkrijgerRechtRef/@xlink:href]/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true' and tia:tia_AandeelInRechten]"/>
					<xsl:with-param name="acquirerParty" select="../tia:Partij[concat('#', @id) = current()/tia:verkrijgerRechtRef/@xlink:href]"/>
					<xsl:with-param name="allocatedToAll" select="'true'"/>
					<xsl:with-param name="isLastGroup" select="'true'"/>
					<xsl:with-param name="variant" select="'2'"/>
				</xsl:apply-templates>
			</xsl:when>
			<!-- Variant 3 -->
			<xsl:when test="count(tia:verkrijgerRechtRef) = 1 and not(tia:IMKAD_ZakelijkRecht/tia:verkrijgerRechtRef) and count(tia:IMKAD_ZakelijkRecht/tia:Toedeling) > 0">
				<p>
					<xsl:apply-templates select="." mode="do-allocation-header">
						<xsl:with-param name="dubbelePunt" select="':'"/>
					</xsl:apply-templates>
				</p>
				<xsl:apply-templates select="." mode="do-allocation-to-different-persons-within-one-party">
					<xsl:with-param name="authorizedRepresentative" select="../tia:Partij[concat('#', @id) = current()/tia:verkrijgerRechtRef/@xlink:href]/tia:Gevolmachtigde"/>
					<xsl:with-param name="acquiringPersons" select="../tia:Partij[concat('#', @id) = current()/tia:verkrijgerRechtRef/@xlink:href]/tia:IMKAD_Persoon[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef/@xlink:href and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']
																	| ../tia:Partij[concat('#', @id) = current()/tia:verkrijgerRechtRef/@xlink:href]/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef/@xlink:href and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']
																	| ../tia:Partij[concat('#', @id) = current()/tia:verkrijgerRechtRef/@xlink:href]/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef/@xlink:href and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']"/>
					<xsl:with-param name="acquirerParty" select="../tia:Partij[concat('#', @id) = current()/tia:verkrijgerRechtRef/@xlink:href]"/>
					<xsl:with-param name="isLastGroup" select="'true'"/>
					<xsl:with-param name="variant" select="'3'"/>
				</xsl:apply-templates>
			</xsl:when>
			<!-- Variant 4 -->
			<xsl:when test="tia:IMKAD_ZakelijkRecht/tia:verkrijgerRechtRef and translate($isAlocationToSpecificPartiesTheSame, $upper, $lower) = 'true' and
							(count(../tia:Partij[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:verkrijgerRechtRef/@xlink:href]/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']/tia:tia_AandeelInRechten)
							+ count(../tia:Partij[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:verkrijgerRechtRef/@xlink:href]/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']/tia:tia_AandeelInRechten)
							+ count(../tia:Partij[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:verkrijgerRechtRef/@xlink:href]/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']/tia:tia_AandeelInRechten)) = 0
							and count(tia:IMKAD_ZakelijkRecht/tia:Toedeling) = 0">
				<xsl:variable name="_parties">
					<tia:root>
						<xsl:copy-of select="current()/../tia:Partij[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht[1]/tia:verkrijgerRechtRef/@xlink:href]"/>
					</tia:root>
				</xsl:variable>
				<xsl:variable name="parties" select="exslt:node-set($_parties)"/>
				<xsl:variable name="allRights" select="tia:IMKAD_ZakelijkRecht"/>
				<xsl:variable name="_numberedRights">
					<xsl:for-each select="$allRights">
						<tia:IMKAD_ZakelijkRecht>
							<tia:orderNumber>
								<xsl:value-of select="count(preceding-sibling::tia:IMKAD_ZakelijkRecht) + 1"/>
							</tia:orderNumber>
							<xsl:copy-of select="*"/>
						</tia:IMKAD_ZakelijkRecht>
					</xsl:for-each>
				</xsl:variable>
				<xsl:variable name="numberedRights" select="exslt:node-set($_numberedRights)"/>
				<xsl:variable name="_rights">
					<tia:root>
						<xsl:copy-of select="$numberedRights"/>
					</tia:root>
				</xsl:variable>
				<xsl:variable name="rights" select="exslt:node-set($_rights)"/>
				<xsl:variable name="onverdeeld">
					<xsl:value-of select="tia:IMKAD_ZakelijkRecht[1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
						translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
						translate(normalize-space(current()/tia:IMKAD_ZakelijkRecht[1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
				</xsl:variable>
				<xsl:variable name="aantalParties" select="count($parties)"/>
				<p>
					<xsl:apply-templates select="." mode="do-allocation-header">
						<xsl:with-param name="dubbelePunt" select="':'"/>
					</xsl:apply-templates>
				</p>
				<table cellspacing="0" cellpadding="0">
					<tbody>
						<xsl:apply-templates select="." mode="do-allocation-to-one-or-more-parties-with-equal-shares-for-each-of-the-persons">
							<xsl:with-param name="parties" select="$parties"/>
							<xsl:with-param name="rights" select="$rights"/>
							<xsl:with-param name="onverdeeld" select="$onverdeeld"/>
							<xsl:with-param name="aantalParties" select="$aantalParties"/>
						</xsl:apply-templates>
					</tbody>
				</table>
			</xsl:when>
			<!-- Variant 5 -->
			<xsl:when test="tia:IMKAD_ZakelijkRecht/tia:verkrijgerRechtRef and translate($isAlocationToSpecificPartiesTheSame, $upper, $lower) = 'true'
								and (count(../tia:Partij[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:verkrijgerRechtRef/@xlink:href]/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']/tia:tia_AandeelInRechten)
									+ count(../tia:Partij[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:verkrijgerRechtRef/@xlink:href]/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']/tia:tia_AandeelInRechten)
									+ count(../tia:Partij[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:verkrijgerRechtRef/@xlink:href]/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']/tia:tia_AandeelInRechten)) > 0
								and count(tia:IMKAD_ZakelijkRecht/tia:Toedeling) = 0">
				<p>
					<xsl:apply-templates select="." mode="do-allocation-header">
						<xsl:with-param name="dubbelePunt" select="':'"/>
					</xsl:apply-templates>
				</p>
				<xsl:apply-templates select="." mode="do-allocation-to-different-persons-within-one-party">
					<xsl:with-param name="authorizedRepresentative" select="../tia:Partij[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht[1]/tia:verkrijgerRechtRef/@xlink:href]/tia:Gevolmachtigde"/>
					<xsl:with-param name="acquiringPersons" select="../tia:Partij[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht[1]/tia:verkrijgerRechtRef/@xlink:href]/tia:IMKAD_Persoon[tia:tia_AandeelInRechten and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']
																| ../tia:Partij[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht[1]/tia:verkrijgerRechtRef/@xlink:href]/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[tia:tia_AandeelInRechten and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']
																| ../tia:Partij[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht[1]/tia:verkrijgerRechtRef/@xlink:href]/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[tia:tia_AandeelInRechten and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']"/>
					<xsl:with-param name="acquirerParty" select="../tia:Partij[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht[1]/tia:verkrijgerRechtRef/@xlink:href]"/>
					<xsl:with-param name="isLastGroup" select="'true'"/>
					<xsl:with-param name="variant" select="'5'"/>
				</xsl:apply-templates>
			</xsl:when>
			<!-- Variant 6 -->
			<xsl:when test="tia:IMKAD_ZakelijkRecht/tia:verkrijgerRechtRef and translate($isAlocationToSpecificPartiesTheSame, $upper, $lower) = 'true' and count(tia:IMKAD_ZakelijkRecht/tia:Toedeling) > 0">
				<xsl:variable name="indentGevolmachtigden" select="count(../tia:Partij/tia:Gevolmachtigde)"/>
				<xsl:choose>
					<xsl:when test="$indentGevolmachtigden = 1">
						<xsl:apply-templates select="." mode="do-allocation-header">
							<xsl:with-param name="dubbelePunt" select="''"/>
						</xsl:apply-templates>
					</xsl:when>
					<xsl:otherwise>
						<p>
							<xsl:apply-templates select="." mode="do-allocation-header">
								<xsl:with-param name="dubbelePunt" select="':'"/>
							</xsl:apply-templates>
						</p>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:apply-templates select="." mode="do-allocation-to-different-persons-within-one-party">
					<xsl:with-param name="authorizedRepresentative" select="../tia:Partij[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht[1]/tia:verkrijgerRechtRef/@xlink:href]/tia:Gevolmachtigde"/>
					<xsl:with-param name="acquiringPersons" select="../tia:Partij[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht[1]/tia:verkrijgerRechtRef/@xlink:href]/tia:IMKAD_Persoon[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef/@xlink:href and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']
																| ../tia:Partij[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht[1]/tia:verkrijgerRechtRef/@xlink:href]/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef/@xlink:href and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']
																| ../tia:Partij[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht[1]/tia:verkrijgerRechtRef/@xlink:href]/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef/@xlink:href and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']"/>
					<xsl:with-param name="acquirerParty" select="../tia:Partij[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht[1]/tia:verkrijgerRechtRef/@xlink:href]"/>
					<xsl:with-param name="isLastGroup" select="'true'"/>
					<xsl:with-param name="indentGevolmachtigden" select="$indentGevolmachtigden"/>
					<xsl:with-param name="variant" select="'6'"/>
				</xsl:apply-templates>
			</xsl:when>
			<!-- Variant 7 -->
			<xsl:when test="tia:IMKAD_ZakelijkRecht/tia:verkrijgerRechtRef and translate($isAlocationToSpecificPartiesTheSame, $upper, $lower) = 'false' and
							(count(../tia:Partij[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:verkrijgerRechtRef/@xlink:href]/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']/tia:tia_AandeelInRechten)
							+ count(../tia:Partij[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:verkrijgerRechtRef/@xlink:href]/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']/tia:tia_AandeelInRechten)
							+ count(../tia:Partij[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:verkrijgerRechtRef/@xlink:href]/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']/tia:tia_AandeelInRechten)) = 0
							and count(tia:IMKAD_ZakelijkRecht/tia:Toedeling) = 0">
				<xsl:variable name="_parties">
					<tia:root>
						<xsl:copy-of select="current()/../tia:Partij[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:verkrijgerRechtRef/@xlink:href]"/>
					</tia:root>
				</xsl:variable>
				<xsl:variable name="parties" select="exslt:node-set($_parties)"/>
				<xsl:variable name="rights" select="tia:IMKAD_ZakelijkRecht"/>
				<xsl:variable name="_numberedRights">
					<xsl:for-each select="$rights">
						<tia:IMKAD_ZakelijkRecht>
							<tia:orderNumber>
								<xsl:value-of select="count(preceding-sibling::tia:IMKAD_ZakelijkRecht) + 1"/>
							</tia:orderNumber>
							<xsl:copy-of select="*"/>
						</tia:IMKAD_ZakelijkRecht>
					</xsl:for-each>
				</xsl:variable>
				<xsl:variable name="numberedRights" select="exslt:node-set($_numberedRights)"/>
				<xsl:variable name="_groupPartiesAndRightsTemp">
					<tia:groups>
						<xsl:for-each select="$numberedRights/tia:IMKAD_ZakelijkRecht">
							<tia:group>
								<xsl:copy-of select="."/>
								<xsl:copy-of select="$parties/tia:root/tia:Partij[concat('#', @id) = current()/tia:verkrijgerRechtRef/@xlink:href]"/>
							</tia:group>
						</xsl:for-each>
					</tia:groups>
				</xsl:variable>
				<xsl:variable name="groupPartiesAndRightsTemp" select="exslt:node-set($_groupPartiesAndRightsTemp)"/>
				<xsl:variable name="_groupPartiesAndRights">
					<tia:groups>
						<xsl:for-each select="$groupPartiesAndRightsTemp/tia:groups/tia:group">
							<xsl:variable name="currentGroup" select="."/>
							<xsl:if test="not($currentGroup/preceding-sibling::tia:group[count(tia:Partij[@id = $currentGroup/tia:Partij/@id]) = count(tia:Partij) and count(tia:Partij) = count($currentGroup/tia:Partij)])">
								<tia:group>
									<xsl:copy-of select="tia:IMKAD_ZakelijkRecht"/>
									<xsl:copy-of select="$currentGroup/following-sibling::tia:group[count(tia:Partij[@id = $currentGroup/tia:Partij/@id]) = count(tia:Partij) and count(tia:Partij) = count($currentGroup/tia:Partij)]/tia:IMKAD_ZakelijkRecht"/>
									<xsl:copy-of select="tia:Partij"/>
								</tia:group>
							</xsl:if>
						</xsl:for-each>
					</tia:groups>
				</xsl:variable>
				<xsl:variable name="groupPartiesAndRights" select="exslt:node-set($_groupPartiesAndRights)"/>
				<xsl:variable name="_sortedGroupPartiesAndRights">
					<xsl:apply-templates select="$groupPartiesAndRights/tia:groups"/>
				</xsl:variable>
				<xsl:variable name="sortedGroupPartiesAndRights" select="exslt:node-set($_sortedGroupPartiesAndRights)"/>
				<xsl:variable name="aantalParties" select="count($sortedGroupPartiesAndRights/tia:groups/tia:group)"/>
				<p>
					<xsl:apply-templates select="." mode="do-allocation-header">
						<xsl:with-param name="dubbelePunt" select="':'"/>
					</xsl:apply-templates>
				</p>
				<xsl:for-each select="$sortedGroupPartiesAndRights/tia:groups/tia:group">
					<!-- skip groups which contains same (already processed) parties in reverse order -->
					<xsl:if test="not(current()/preceding-sibling::tia:group[tia:Partij[@id = current()/tia:Partij/@id]
										and tia:IMKAD_ZakelijkRecht[tia:orderNumber = current()/tia:IMKAD_ZakelijkRecht/tia:orderNumber]
										and count(tia:IMKAD_ZakelijkRecht) = count(current()/tia:IMKAD_ZakelijkRecht)])">
						<xsl:variable name="_groupedRights">
							<tia:root>
								<xsl:copy-of select="current()/tia:IMKAD_ZakelijkRecht"/>
							</tia:root>
						</xsl:variable>
						<xsl:variable name="groupedRights" select="exslt:node-set($_groupedRights)"/>
						<xsl:variable name="_groupedParties">
							<tia:root>
								<xsl:copy-of select="current()/tia:Partij"/>
							</tia:root>
						</xsl:variable>
						<xsl:variable name="groupedParties" select="exslt:node-set($_groupedParties)"/>
						<xsl:variable name="onverdeeld">
							<xsl:value-of select="tia:IMKAD_ZakelijkRecht[1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
									translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
									translate(normalize-space(current()/tia:IMKAD_ZakelijkRecht[1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
						</xsl:variable>
						<xsl:variable name="isLast">
							<xsl:choose>
								<xsl:when test="count(current()/following-sibling::tia:group[tia:Partij[@id = current()/tia:Partij/@id]
										and tia:IMKAD_ZakelijkRecht[tia:orderNumber = current()/tia:IMKAD_ZakelijkRecht/tia:orderNumber]
										and count(tia:IMKAD_ZakelijkRecht) = count(current()/tia:IMKAD_ZakelijkRecht)]) = count(current()/following-sibling::tia:group)">
									<xsl:text>true</xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>false</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<table cellspacing="0" cellpadding="0">
							<tbody>
								<xsl:apply-templates select="$root" mode="do-allocation-to-one-or-more-parties-with-equal-shares-for-each-of-the-persons">
									<xsl:with-param name="parties" select="$groupedParties"/>
									<xsl:with-param name="rights" select="$groupedRights"/>
									<xsl:with-param name="onverdeeld" select="$onverdeeld"/>
									<xsl:with-param name="isLast" select="$isLast"/>
									<xsl:with-param name="aantalParties" select="$aantalParties"/>
									<xsl:with-param name="variant" select="'7'"/>
								</xsl:apply-templates>
							</tbody>
						</table>
					</xsl:if>
				</xsl:for-each>
			</xsl:when>
			<!-- Variant 8 -->
			<xsl:when test="tia:IMKAD_ZakelijkRecht/tia:verkrijgerRechtRef and translate($isAlocationToSpecificPartiesTheSame, $upper, $lower) = 'false' and (count(../tia:Partij[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:verkrijgerRechtRef/@xlink:href]/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']/tia:tia_AandeelInRechten)
									+ count(../tia:Partij[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:verkrijgerRechtRef/@xlink:href]/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']/tia:tia_AandeelInRechten)
									+ count(../tia:Partij[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:verkrijgerRechtRef/@xlink:href]/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']/tia:tia_AandeelInRechten)) > 0
									and count(../tia:Partij[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:verkrijgerRechtRef/@xlink:href]) = count(../tia:Partij[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:verkrijgerRechtRef/@xlink:href and (tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']/tia:tia_AandeelInRechten or tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']/tia:tia_AandeelInRechten or tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']/tia:tia_AandeelInRechten)])
									and count(tia:IMKAD_ZakelijkRecht/tia:Toedeling) = 0">
				<xsl:variable name="_parties">
					<tia:root>
						<xsl:copy-of select="current()/../tia:Partij[tia:IMKAD_Persoon[tia:tia_AandeelInRechten and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true'] or tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[tia:tia_AandeelInRechten and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true'] or tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[tia:tia_AandeelInRechten and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']]"/>
					</tia:root>
				</xsl:variable>
				<xsl:variable name="parties" select="exslt:node-set($_parties)"/>
				<xsl:variable name="_groupParties">
					<xsl:call-template name="groupParties">
						<xsl:with-param name="parties" select="$parties"/>
						<xsl:with-param name="rights" select="$root/tia:IMKAD_ZakelijkRecht"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:variable name="groupParties" select="exslt:node-set($_groupParties)"/>
				<p>
					<xsl:apply-templates select="." mode="do-allocation-header">
						<xsl:with-param name="dubbelePunt" select="':'"/>
					</xsl:apply-templates>
				</p>
				<xsl:for-each select="$groupParties/tia:groups/tia:group">
					<xsl:variable name="isLastGroup">
						<xsl:choose>
							<xsl:when test="position() = last()">
								<xsl:text>true</xsl:text>
							</xsl:when>
							<xsl:otherwise>
								<xsl:text>false</xsl:text>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
					<xsl:variable name="currentPartijId" select="tia:Partij/@id"/>
					<xsl:variable name="currentPartij" select="$root/../tia:Partij[@id=$currentPartijId]"/>
					<xsl:apply-templates select="$root" mode="do-allocation-to-different-persons-within-one-party">
						<xsl:with-param name="authorizedRepresentative" select="$currentPartij/tia:Gevolmachtigde"/>
						<xsl:with-param name="acquiringPersons" select="$currentPartij/tia:IMKAD_Persoon[tia:tia_AandeelInRechten and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true'] | tia:Partij/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[tia:tia_AandeelInRechten and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true'] | tia:Partij/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[tia:tia_AandeelInRechten and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']"/>
						<xsl:with-param name="acquirerParty" select="$currentPartij"/>
						<xsl:with-param name="isLastGroup" select="$isLastGroup"/>
						<xsl:with-param name="variant" select="'8'"/>
					</xsl:apply-templates>
				</xsl:for-each>
			</xsl:when>
			<!-- Variant 9 -->
			<xsl:when test="tia:IMKAD_ZakelijkRecht/tia:verkrijgerRechtRef and translate($isAlocationToSpecificPartiesTheSame, $upper, $lower) = 'false'
								and count(../tia:Partij[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:verkrijgerRechtRef/@xlink:href]) = count(../tia:Partij[tia:IMKAD_Persoon[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef/@xlink:href and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true'] or tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef/@xlink:href and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true'] or tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef/@xlink:href and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']])
								and count(tia:IMKAD_ZakelijkRecht/tia:Toedeling) > 0">
				<xsl:variable name="_parties">
					<tia:root>
						<xsl:copy-of select="current()/../tia:Partij[tia:IMKAD_Persoon[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef/@xlink:href and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true'] or tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef/@xlink:href and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true'] or tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef/@xlink:href and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']]"/>
					</tia:root>
				</xsl:variable>
				<xsl:variable name="parties" select="exslt:node-set($_parties)"/>
				<xsl:variable name="_groupParties">
					<xsl:call-template name="groupParties">
						<xsl:with-param name="parties" select="$parties"/>
						<xsl:with-param name="rights" select="$root/tia:IMKAD_ZakelijkRecht"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:variable name="groupParties" select="exslt:node-set($_groupParties)"/>
				<p>
					<xsl:apply-templates select="." mode="do-allocation-header">
						<xsl:with-param name="dubbelePunt" select="':'"/>
					</xsl:apply-templates>
				</p>
				<xsl:for-each select="$groupParties/tia:groups/tia:group">
					<xsl:variable name="currentGroup" select="."/>
					<xsl:variable name="isLastGroup">
						<xsl:choose>
							<xsl:when test="position() = last()">
								<xsl:text>true</xsl:text>
							</xsl:when>
							<xsl:otherwise>
								<xsl:text>false</xsl:text>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
					<xsl:variable name="currentPartijId" select="tia:Partij/@id"/>
					<xsl:variable name="currentPartij" select="$root/../tia:Partij[@id = $currentPartijId]"/>
					<xsl:variable name="indentGevolmachtigden" select="count($root/../tia:Partij/tia:Gevolmachtigde) + count($root/../tia:Partij[not(tia:Gevolmachtigde)]/tia:IMKAD_Persoon[concat('#', @id) = $root/tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef/@xlink:href and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true'] | tia:Partij/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[concat('#', @id) = $root/tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef/@xlink:href and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true'] | tia:Partij/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[concat('#', @id) = $root/tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef/@xlink:href and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true'])"/>
					<xsl:apply-templates select="$root" mode="do-allocation-to-different-persons-within-one-party">
						<xsl:with-param name="authorizedRepresentative" select="$currentPartij/tia:Gevolmachtigde"/>
						<xsl:with-param name="acquiringPersons" select="$currentPartij/tia:IMKAD_Persoon[concat('#', @id) = $root/tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef/@xlink:href and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true'] | tia:Partij/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[concat('#', @id) = $root/tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef/@xlink:href and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true'] | tia:Partij/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[concat('#', @id) = $root/tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef/@xlink:href and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']"/>
						<xsl:with-param name="acquirerParty" select="$currentPartij"/>
						<xsl:with-param name="isLastGroup" select="$isLastGroup"/>
						<xsl:with-param name="indentGevolmachtigden" select="$indentGevolmachtigden"/>
						<xsl:with-param name="variant" select="'9'"/>
					</xsl:apply-templates>
				</xsl:for-each>
			</xsl:when>
			<!-- Variant 10 -->
			<xsl:when test="tia:IMKAD_ZakelijkRecht/tia:verkrijgerRechtRef and translate($isAlocationToSpecificPartiesTheSame, $upper, $lower) = 'false'
								and (count(../tia:Partij/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']/tia:tia_AandeelInRechten)
								+ count(../tia:Partij/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']/tia:tia_AandeelInRechten)
								+ count(../tia:Partij/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']/tia:tia_AandeelInRechten)) > 0
								and count(../tia:Partij[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:verkrijgerRechtRef/@xlink:href]) >= count(../tia:Partij[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:verkrijgerRechtRef/@xlink:href and (tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']/tia:tia_AandeelInRechten or tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']/tia:tia_AandeelInRechten or tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']/tia:tia_AandeelInRechten)])
								and count(tia:IMKAD_ZakelijkRecht/tia:Toedeling) > 0
								and count(../tia:Partij[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:verkrijgerRechtRef/@xlink:href]) >= count(../tia:Partij[tia:IMKAD_Persoon[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef/@xlink:href and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true'] or tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef/@xlink:href and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true'] or tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef/@xlink:href and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']])
								and count(../tia:Partij[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:verkrijgerRechtRef/@xlink:href]) = (count(../tia:Partij[tia:IMKAD_Persoon[tia:tia_AandeelInRechten and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true'] or tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']/tia:tia_AandeelInRechten or tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']/tia:tia_AandeelInRechten or
									tia:IMKAD_Persoon[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef/@xlink:href and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true'] or tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef/@xlink:href and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true'] or tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef/@xlink:href and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']]))">
				<xsl:variable name="_parties">
					<tia:root>
						<xsl:copy-of select="current()/../tia:Partij"/>
					</tia:root>
				</xsl:variable>
				<xsl:variable name="parties" select="exslt:node-set($_parties)"/>
				<xsl:variable name="_groupParties">
					<xsl:call-template name="groupParties">
						<xsl:with-param name="parties" select="$parties"/>
						<xsl:with-param name="rights" select="$root/tia:IMKAD_ZakelijkRecht"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:variable name="groupParties" select="exslt:node-set($_groupParties)"/>
				<p>
					<xsl:apply-templates select="." mode="do-allocation-header">
						<xsl:with-param name="dubbelePunt" select="':'"/>
					</xsl:apply-templates>
				</p>
				<xsl:for-each select="$groupParties/tia:groups/tia:group">
					<xsl:variable name="isLastGroup">
						<xsl:choose>
							<xsl:when test="position() = last()">
								<xsl:text>true</xsl:text>
							</xsl:when>
							<xsl:otherwise>
								<xsl:text>false</xsl:text>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
					<xsl:variable name="currentPartijId" select="tia:Partij/@id"/>
					<xsl:variable name="currentPartij" select="$root/../tia:Partij[@id=$currentPartijId]"/>
					<xsl:apply-templates select="$root" mode="do-allocation-to-different-persons-within-one-party">
						<xsl:with-param name="authorizedRepresentative" select="$currentPartij/tia:Gevolmachtigde"/>
						<xsl:with-param name="acquiringPersons" select="$currentPartij/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true'] | tia:Partij/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true'] | tia:Partij/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']"/>
						<xsl:with-param name="acquirerParty" select="$currentPartij"/>
						<xsl:with-param name="isLastGroup" select="$isLastGroup"/>
						<xsl:with-param name="variant" select="'10'"/>
					</xsl:apply-templates>
				</xsl:for-each>
			</xsl:when>
			<!-- Variant 11 -->
			<xsl:when test="tia:IMKAD_ZakelijkRecht/tia:verkrijgerRechtRef and translate($isAlocationToSpecificPartiesTheSame, $upper, $lower) = 'false'
								and (count(../tia:Partij[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:verkrijgerRechtRef/@xlink:href]/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']/tia:tia_AandeelInRechten)
									+ count(../tia:Partij[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:verkrijgerRechtRef/@xlink:href]/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']/tia:tia_AandeelInRechten)
									+ count(../tia:Partij[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:verkrijgerRechtRef/@xlink:href]/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']/tia:tia_AandeelInRechten)) > 0
								and count(../tia:Partij[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:verkrijgerRechtRef/@xlink:href]) > count(../tia:Partij[tia:IMKAD_Persoon[tia:tia_AandeelInRechten and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true'] or tia:IMKAD_Persoon[tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']/tia:tia_AandeelInRechten] or tia:IMKAD_Persoon[tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']/tia:tia_AandeelInRechten]])
								and count(tia:IMKAD_ZakelijkRecht/tia:Toedeling) = 0">
				<xsl:variable name="_parties">
					<tia:root>
						<xsl:copy-of select="current()/../tia:Partij[not(tia:IMKAD_Persoon[tia:tia_AandeelInRechten and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']) and not(tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[tia:tia_AandeelInRechten and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']) and not(tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[tia:tia_AandeelInRechten and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true'])]"/>
					</tia:root>
				</xsl:variable>
				<xsl:variable name="parties" select="exslt:node-set($_parties)"/>
				<xsl:variable name="rights" select="tia:IMKAD_ZakelijkRecht"/>
				<xsl:variable name="_numberedRights">
					<xsl:for-each select="$rights">
						<tia:IMKAD_ZakelijkRecht>
							<tia:orderNumber>
								<xsl:value-of select="count(preceding-sibling::tia:IMKAD_ZakelijkRecht) + 1"/>
							</tia:orderNumber>
							<xsl:copy-of select="*"/>
						</tia:IMKAD_ZakelijkRecht>
					</xsl:for-each>
				</xsl:variable>
				<xsl:variable name="numberedRights" select="exslt:node-set($_numberedRights)"/>
				<xsl:variable name="_groupPartiesAndRights">
					<xsl:call-template name="groupPartiesAndRights">
						<xsl:with-param name="parties" select="$parties"/>
						<xsl:with-param name="rights" select="$numberedRights/tia:IMKAD_ZakelijkRecht"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:variable name="groupPartiesAndRights" select="exslt:node-set($_groupPartiesAndRights)"/>
				<xsl:variable name="_sortedGroupPartiesAndRights">
					<xsl:apply-templates select="$groupPartiesAndRights/tia:groups"/>
				</xsl:variable>
				<xsl:variable name="sortedGroupPartiesAndRights" select="exslt:node-set($_sortedGroupPartiesAndRights)"/>
				<xsl:variable name="_allParties">
					<tia:root>
						<xsl:copy-of select="current()/../tia:Partij[tia:IMKAD_Persoon[tia:tia_AandeelInRechten and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true'] or tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[tia:tia_AandeelInRechten and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true'] or tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[tia:tia_AandeelInRechten and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']]"/>
					</tia:root>
				</xsl:variable>
				<xsl:variable name="allParties" select="exslt:node-set($_allParties)"/>
				<xsl:variable name="_groupParties">
					<xsl:call-template name="groupParties">
						<xsl:with-param name="parties" select="$allParties"/>
						<xsl:with-param name="rights" select="$root/tia:IMKAD_ZakelijkRecht"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:variable name="groupParties" select="exslt:node-set($_groupParties)"/>
				<xsl:variable name="_groupedPersonsAndRights">
					<xsl:for-each select="$groupParties/tia:groups/tia:group">
						<xsl:variable name="_groupPersonsAndRights">
							<xsl:call-template name="groupPersonsAndRights">
								<xsl:with-param name="persons" select="tia:Partij/tia:IMKAD_Persoon[tia:tia_AandeelInRechten and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true'] | tia:Partij/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[tia:tia_AandeelInRechten and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true'] | tia:Partij/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[tia:tia_AandeelInRechten and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']"/>
								<xsl:with-param name="rights" select="$root/tia:IMKAD_ZakelijkRecht"/>
								<xsl:with-param name="acquirerParty" select="tia:Partij"/>
								<xsl:with-param name="variant" select="'11'"/>
							</xsl:call-template>
						</xsl:variable>
						<xsl:variable name="groupPersonsAndRights" select="exslt:node-set($_groupPersonsAndRights)"/>
						<xsl:variable name="_sortedGroupPersonsAndRights">
							<xsl:apply-templates select="$groupPersonsAndRights/tia:groups"/>
						</xsl:variable>
						<xsl:variable name="sortedGroupPersonsAndRights" select="exslt:node-set($_sortedGroupPersonsAndRights)"/>
						<tia:groups>
							<tia:group>
								<xsl:copy-of select="tia:Partij"/>
							</tia:group>
							<xsl:copy-of select="$sortedGroupPersonsAndRights"/>
						</tia:groups>
					</xsl:for-each>
				</xsl:variable>
				<xsl:variable name="groupedPersonsAndRights" select="exslt:node-set($_groupedPersonsAndRights)"/>
				<xsl:variable name="_sortedGroupPersonsAndRights">
					<xsl:for-each select="$groupedPersonsAndRights/tia:groups">
						<tia:groups>
							<xsl:copy-of select="tia:group"/>
							<xsl:apply-templates select="tia:groups"/>
						</tia:groups>
					</xsl:for-each>
				</xsl:variable>
				<xsl:variable name="sortedGroupPersonsAndRights" select="exslt:node-set($_sortedGroupPersonsAndRights)"/>
				<p>
					<xsl:apply-templates select="." mode="do-allocation-header">
						<xsl:with-param name="dubbelePunt" select="':'"/>
					</xsl:apply-templates>
				</p>
				<xsl:for-each select="$numberedRights/tia:IMKAD_ZakelijkRecht">
					<xsl:variable name="processedPartiesRightsGroup" select="$sortedGroupPartiesAndRights/tia:groups/tia:group[tia:IMKAD_ZakelijkRecht[tia:orderNumber = current()/tia:orderNumber]]"/>
					<xsl:variable name="processedPersonsRightsGroup" select="$sortedGroupPersonsAndRights/tia:groups[tia:groups/tia:group[tia:IMKAD_ZakelijkRecht[tia:orderNumber = current()/tia:orderNumber]]]"/>
					<!-- process this group if it should be processed, and if is not already processed -->
					<xsl:if test="$processedPartiesRightsGroup and count($processedPartiesRightsGroup/tia:IMKAD_ZakelijkRecht[tia:orderNumber = current()/tia:orderNumber]/preceding-sibling::tia:IMKAD_ZakelijkRecht) = 0">
						<xsl:variable name="processedGroupPersonsAndRightsCount" select="count($sortedGroupPersonsAndRights/tia:groups[tia:groups/tia:group[tia:IMKAD_ZakelijkRecht[tia:orderNumber &lt; current()/tia:orderNumber]]])"/>
						<xsl:variable name="isLastPartyRightsGroup">
							<xsl:choose>
								<xsl:when test="count($sortedGroupPartiesAndRights/tia:groups/tia:group[tia:IMKAD_ZakelijkRecht[tia:orderNumber = current()/tia:orderNumber]]/following-sibling::tia:group) = 0
									and $processedGroupPersonsAndRightsCount = count($sortedGroupPersonsAndRights/tia:groups[tia:groups/tia:group[tia:IMKAD_ZakelijkRecht]])">
									<xsl:text>true</xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>false</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="_groupedRights">
							<tia:root>
								<xsl:copy-of select="$processedPartiesRightsGroup/tia:IMKAD_ZakelijkRecht"/>
							</tia:root>
						</xsl:variable>
						<xsl:variable name="groupedRights" select="exslt:node-set($_groupedRights)"/>
						<xsl:variable name="_groupedParties">
							<tia:root>
								<xsl:copy-of select="$processedPartiesRightsGroup/tia:Partij"/>
							</tia:root>
						</xsl:variable>
						<xsl:variable name="groupedParties" select="exslt:node-set($_groupedParties)"/>
						<xsl:variable name="onverdeeld">
							<xsl:value-of select="$processedPartiesRightsGroup/tia:IMKAD_ZakelijkRecht[1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
									translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
									translate(normalize-space($processedPartiesRightsGroup/tia:IMKAD_ZakelijkRecht[1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
						</xsl:variable>
						<table cellspacing="0" cellpadding="0">
							<tbody>
								<xsl:apply-templates select="$root" mode="do-allocation-to-one-or-more-parties-with-equal-shares-for-each-of-the-persons">
									<xsl:with-param name="parties" select="$groupedParties"/>
									<xsl:with-param name="rights" select="$groupedRights"/>
									<xsl:with-param name="onverdeeld" select="$onverdeeld"/>
									<xsl:with-param name="isLast" select="$isLastPartyRightsGroup"/>
									<xsl:with-param name="variant" select="'11'"/>
								</xsl:apply-templates>
							</tbody>
						</table>
					</xsl:if>
					<!-- process this group if it should be processed, and if is not already processed -->
					<xsl:if test="$processedPersonsRightsGroup and count($processedPersonsRightsGroup/tia:groups/tia:group[1]/tia:IMKAD_ZakelijkRecht[tia:orderNumber = current()/tia:orderNumber]/preceding-sibling::tia:IMKAD_ZakelijkRecht) = 0
									and count($processedPersonsRightsGroup/tia:groups/tia:group[tia:IMKAD_ZakelijkRecht[tia:orderNumber = current()/tia:orderNumber] and count(preceding-sibling::tia:group[tia:IMKAD_ZakelijkRecht[tia:orderNumber = current()/tia:orderNumber]]) = 0]/preceding-sibling::tia:group) = 0">
						<xsl:variable name="processedPartiesRightsGroupCount" select="count($sortedGroupPartiesAndRights/tia:groups/tia:group[tia:IMKAD_ZakelijkRecht[tia:orderNumber &lt;= current()/tia:orderNumber]])"/>
						<xsl:variable name="isLastPersonRightsGroup">
							<xsl:choose>
								<xsl:when test="count($sortedGroupPersonsAndRights/tia:groups[tia:group[tia:IMKAD_ZakelijkRecht[tia:orderNumber = current()/tia:orderNumber]]]/following-sibling::tia:groups) = 0
										and $processedPartiesRightsGroupCount = count($sortedGroupPartiesAndRights/tia:groups/tia:group[tia:IMKAD_ZakelijkRecht])">
									<xsl:text>true</xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>false</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="currentPartijId" select="$processedPersonsRightsGroup/tia:group/tia:Partij/@id"/>
						<xsl:variable name="currentPartij" select="$root/../tia:Partij[@id=$currentPartijId]"/>
						<xsl:apply-templates select="$root" mode="do-allocation-to-different-persons-within-one-party">
							<xsl:with-param name="authorizedRepresentative" select="$currentPartij/tia:Gevolmachtigde"/>
							<xsl:with-param name="acquiringPersons" select="$currentPartij/tia:IMKAD_Persoon[tia:tia_AandeelInRechten and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true'] | $currentPartij/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[tia:tia_AandeelInRechten and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true'] | $currentPartij/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[tia:tia_AandeelInRechten and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']"/>
							<xsl:with-param name="acquirerParty" select="$currentPartij"/>
							<xsl:with-param name="isLastGroup" select="$isLastPersonRightsGroup"/>
							<xsl:with-param name="variant" select="'11'"/>
						</xsl:apply-templates>
					</xsl:if>
				</xsl:for-each>
			</xsl:when>
			<!-- Variant 13 -->
			<xsl:when test="tia:IMKAD_ZakelijkRecht/tia:verkrijgerRechtRef and translate($isAlocationToSpecificPartiesTheSame, $upper, $lower) = 'false'
								and count(../tia:Partij[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:verkrijgerRechtRef/@xlink:href]) >= count(../tia:Partij[tia:IMKAD_Persoon[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef/@xlink:href and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true'] or tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef/@xlink:href and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true'] or tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef/@xlink:href and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']])
								and (count(../tia:Partij[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:verkrijgerRechtRef/@xlink:href]/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']/tia:tia_AandeelInRechten)
									+ count(../tia:Partij[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:verkrijgerRechtRef/@xlink:href]/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']/tia:tia_AandeelInRechten)
									+ count(../tia:Partij[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:verkrijgerRechtRef/@xlink:href]/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']/tia:tia_AandeelInRechten)) > 0
								and count(../tia:Partij[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:verkrijgerRechtRef/@xlink:href]) >= count(../tia:Partij[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:verkrijgerRechtRef/@xlink:href and (tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']/tia:tia_AandeelInRechten or tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']/tia:tia_AandeelInRechten or tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']/tia:tia_AandeelInRechten)])
								and count(../tia:Partij[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:verkrijgerRechtRef/@xlink:href]) > (count(../tia:Partij[tia:IMKAD_Persoon[tia:tia_AandeelInRechten and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true'] or tia:IMKAD_Persoon[tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']/tia:tia_AandeelInRechten] or tia:IMKAD_Persoon[tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']/tia:tia_AandeelInRechten]
									or tia:IMKAD_Persoon[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef/@xlink:href and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true'] or tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef/@xlink:href and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true'] or tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef/@xlink:href and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']]))
								and count(tia:IMKAD_ZakelijkRecht/tia:Toedeling) > 0">
				<xsl:variable name="_parties">
					<tia:root>
						<xsl:copy-of select="current()/../tia:Partij[not(tia:IMKAD_Persoon[(tia:tia_AandeelInRechten and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true') or (tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:tia_AandeelInRechten and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true')]) and not(tia:IMKAD_Persoon[(concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef/@xlink:href and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true') or tia:GerelateerdPersoon/tia:IMKAD_Persoon[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef/@xlink:href and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true'] or tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef/@xlink:href and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']])]"/>
					</tia:root>
				</xsl:variable>
				<xsl:variable name="parties" select="exslt:node-set($_parties)"/>
				<xsl:variable name="rights" select="tia:IMKAD_ZakelijkRecht"/>
				<xsl:variable name="_numberedRights">
					<xsl:for-each select="$rights">
						<tia:IMKAD_ZakelijkRecht>
							<tia:orderNumber>
								<xsl:value-of select="count(preceding-sibling::tia:IMKAD_ZakelijkRecht) + 1"/>
							</tia:orderNumber>
							<xsl:copy-of select="*"/>
						</tia:IMKAD_ZakelijkRecht>
					</xsl:for-each>
				</xsl:variable>
				<xsl:variable name="numberedRights" select="exslt:node-set($_numberedRights)"/>
				<xsl:variable name="_groupPartiesAndRights">
					<xsl:call-template name="groupPartiesAndRights">
						<xsl:with-param name="parties" select="$parties"/>
						<xsl:with-param name="rights" select="$numberedRights/tia:IMKAD_ZakelijkRecht"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:variable name="groupPartiesAndRights" select="exslt:node-set($_groupPartiesAndRights)"/>
				<xsl:variable name="_sortedGroupPartiesAndRights">
					<xsl:apply-templates select="$groupPartiesAndRights/tia:groups"/>
				</xsl:variable>
				<xsl:variable name="sortedGroupPartiesAndRights" select="exslt:node-set($_sortedGroupPartiesAndRights)"/>
				<xsl:variable name="_allParties">
					<tia:root>
						<xsl:copy-of select="current()/../tia:Partij[tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true' and (tia:tia_AandeelInRechten or tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']/tia:tia_AandeelInRechten or tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']/tia:tia_AandeelInRechten)] or tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true' and (concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef/@xlink:href or tia:GerelateerdPersoon/tia:IMKAD_Persoon[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef/@xlink:href and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true'] or tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']/tia:GerelateerdPersoon/tia:IMKAD_Persoon[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef/@xlink:href and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true'])]]"/>
					</tia:root>
				</xsl:variable>
				<xsl:variable name="allParties" select="exslt:node-set($_allParties)"/>
				<xsl:variable name="_groupParties">
					<xsl:call-template name="groupParties">
						<xsl:with-param name="parties" select="$allParties"/>
						<xsl:with-param name="rights" select="$root/tia:IMKAD_ZakelijkRecht"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:variable name="groupParties" select="exslt:node-set($_groupParties)"/>
				<xsl:variable name="_groupedPersonsAndRights">
					<xsl:for-each select="$groupParties/tia:groups/tia:group">
						<xsl:variable name="_groupPersonsAndRights">
							<xsl:call-template name="groupPersonsAndRights">
								<xsl:with-param name="persons" select="tia:Partij/tia:IMKAD_Persoon[tia:tia_AandeelInRechten and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true'] | tia:Partij/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[tia:tia_AandeelInRechten and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true'] | tia:Partij/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[tia:tia_AandeelInRechten and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']
																		| tia:Partij/tia:IMKAD_Persoon[concat('#', @id) = $root/tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef/@xlink:href and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true'] | tia:Partij/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[concat('#', @id) = $root/tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef/@xlink:href and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true'] | tia:Partij/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[concat('#', @id) = $root/tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef/@xlink:href and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']"/>
								<xsl:with-param name="rights" select="$root/tia:IMKAD_ZakelijkRecht"/>
								<xsl:with-param name="acquirerParty" select="tia:Partij"/>
								<xsl:with-param name="variant" select="'13'"/>
							</xsl:call-template>
						</xsl:variable>
						<xsl:variable name="groupPersonsAndRights" select="exslt:node-set($_groupPersonsAndRights)"/>
						<xsl:variable name="_sortedGroupPersonsAndRights">
							<xsl:apply-templates select="$groupPersonsAndRights/tia:groups"/>
						</xsl:variable>
						<xsl:variable name="sortedGroupPersonsAndRights" select="exslt:node-set($_sortedGroupPersonsAndRights)"/>
						<tia:groups>
							<tia:group>
								<xsl:copy-of select="tia:Partij"/>
							</tia:group>
							<xsl:copy-of select="$sortedGroupPersonsAndRights"/>
						</tia:groups>
					</xsl:for-each>
				</xsl:variable>
				<xsl:variable name="groupedPersonsAndRights" select="exslt:node-set($_groupedPersonsAndRights)"/>
				<xsl:variable name="_sortedGroupPersonsAndRights">
					<xsl:for-each select="$groupedPersonsAndRights/tia:groups">
						<tia:groups>
							<xsl:copy-of select="tia:group"/>
							<xsl:apply-templates select="tia:groups"/>
						</tia:groups>
					</xsl:for-each>
				</xsl:variable>
				<xsl:variable name="sortedGroupPersonsAndRights" select="exslt:node-set($_sortedGroupPersonsAndRights)"/>
				<p>
					<xsl:apply-templates select="." mode="do-allocation-header">
						<xsl:with-param name="dubbelePunt" select="':'"/>
					</xsl:apply-templates>
				</p>
				<xsl:for-each select="$numberedRights/tia:IMKAD_ZakelijkRecht">
					<xsl:variable name="processedPartiesRightsGroup" select="$sortedGroupPartiesAndRights/tia:groups/tia:group[tia:IMKAD_ZakelijkRecht[tia:orderNumber = current()/tia:orderNumber]]"/>
					<xsl:variable name="processedPersonsRightsGroup" select="$sortedGroupPersonsAndRights/tia:groups[tia:groups/tia:group[tia:IMKAD_ZakelijkRecht[tia:orderNumber = current()/tia:orderNumber]]]"/>
					<!-- process this group if it should be processed, and if is not already processed -->
					<xsl:if test="$processedPartiesRightsGroup and count($processedPartiesRightsGroup/tia:IMKAD_ZakelijkRecht[tia:orderNumber = current()/tia:orderNumber]/preceding-sibling::tia:IMKAD_ZakelijkRecht) = 0">
						<xsl:variable name="processedGroupPersonsAndRightsCount" select="count($sortedGroupPersonsAndRights/tia:groups[tia:groups/tia:group[tia:IMKAD_ZakelijkRecht[tia:orderNumber &lt; current()/tia:orderNumber]]])"/>
						<xsl:variable name="isLastPartyRightsGroup">
							<xsl:choose>
								<xsl:when test="count($sortedGroupPartiesAndRights/tia:groups/tia:group[tia:IMKAD_ZakelijkRecht[tia:orderNumber = current()/tia:orderNumber]]/following-sibling::tia:group) = 0
									and $processedGroupPersonsAndRightsCount = count($sortedGroupPersonsAndRights/tia:groups[tia:groups/tia:group[tia:IMKAD_ZakelijkRecht]])">
									<xsl:text>true</xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>false</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="_groupedRights">
							<tia:root>
								<xsl:copy-of select="$processedPartiesRightsGroup/tia:IMKAD_ZakelijkRecht"/>
							</tia:root>
						</xsl:variable>
						<xsl:variable name="groupedRights" select="exslt:node-set($_groupedRights)"/>
						<xsl:variable name="_groupedParties">
							<tia:root>
								<xsl:copy-of select="$processedPartiesRightsGroup/tia:Partij"/>
							</tia:root>
						</xsl:variable>
						<xsl:variable name="groupedParties" select="exslt:node-set($_groupedParties)"/>
						<xsl:variable name="onverdeeld">
							<xsl:value-of select="$processedPartiesRightsGroup/tia:IMKAD_ZakelijkRecht[1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
									translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
									translate(normalize-space($processedPartiesRightsGroup/tia:IMKAD_ZakelijkRecht[1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
						</xsl:variable>
						<table cellspacing="0" cellpadding="0">
							<tbody>
								<xsl:apply-templates select="$root" mode="do-allocation-to-one-or-more-parties-with-equal-shares-for-each-of-the-persons">
									<xsl:with-param name="parties" select="$groupedParties"/>
									<xsl:with-param name="rights" select="$groupedRights"/>
									<xsl:with-param name="onverdeeld" select="$onverdeeld"/>
									<xsl:with-param name="isLast" select="$isLastPartyRightsGroup"/>
									<xsl:with-param name="variant" select="'13'"/>
								</xsl:apply-templates>
							</tbody>
						</table>
					</xsl:if>
					<!-- process this group if it should be processed, and if is not already processed -->
					<xsl:if test="$processedPersonsRightsGroup and count($processedPersonsRightsGroup/tia:groups/tia:group[1]/tia:IMKAD_ZakelijkRecht[tia:orderNumber = current()/tia:orderNumber]/preceding-sibling::tia:IMKAD_ZakelijkRecht) = 0
									and count($processedPersonsRightsGroup/tia:groups/tia:group[tia:IMKAD_ZakelijkRecht[tia:orderNumber = current()/tia:orderNumber] and count(preceding-sibling::tia:group[tia:IMKAD_ZakelijkRecht[tia:orderNumber = current()/tia:orderNumber]]) = 0]/preceding-sibling::tia:group) = 0">
						<xsl:variable name="processedPartiesRightsGroupCount" select="count($sortedGroupPartiesAndRights/tia:groups/tia:group[tia:IMKAD_ZakelijkRecht[tia:orderNumber &lt;= current()/tia:orderNumber]])"/>
						<xsl:variable name="isLastPersonRightsGroup">
							<xsl:choose>
								<xsl:when test="count($sortedGroupPersonsAndRights/tia:groups[tia:group[tia:IMKAD_ZakelijkRecht[tia:orderNumber = current()/tia:orderNumber]]]/following-sibling::tia:groups) = 0
										and $processedPartiesRightsGroupCount = count($sortedGroupPartiesAndRights/tia:groups/tia:group[tia:IMKAD_ZakelijkRecht])">
									<xsl:text>true</xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>false</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="currentPartijId" select="$processedPersonsRightsGroup/tia:group/tia:Partij/@id"/>
						<xsl:variable name="currentPartij" select="$root/../tia:Partij[@id=$currentPartijId]"/>
						<xsl:apply-templates select="$root" mode="do-allocation-to-different-persons-within-one-party">
							<xsl:with-param name="authorizedRepresentative" select="$currentPartij/tia:Gevolmachtigde"/>
							<xsl:with-param name="acquiringPersons" select="$currentPartij/tia:IMKAD_Persoon[tia:tia_AandeelInRechten and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true'] | $currentPartij/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[tia:tia_AandeelInRechten and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']
																		| $currentPartij/tia:IMKAD_Persoon[concat('#', @id) = $root/tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef/@xlink:href and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true'] | $currentPartij/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[concat('#', @id) = $root/tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef/@xlink:href and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']
																		| $currentPartij/tia:IMKAD_Persoon[concat('#', @id) = $root/tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef/@xlink:href and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true'] | $currentPartij/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[concat('#', @id) = $root/tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef/@xlink:href and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']"/>
							<xsl:with-param name="acquirerParty" select="$currentPartij"/>
							<xsl:with-param name="isLastGroup" select="$isLastPersonRightsGroup"/>
							<xsl:with-param name="variant" select="'13'"/>
						</xsl:apply-templates>
					</xsl:if>
				</xsl:for-each>
			</xsl:when>
			<!-- Variant 12 -->
			<xsl:when test="tia:IMKAD_ZakelijkRecht/tia:verkrijgerRechtRef and translate($isAlocationToSpecificPartiesTheSame, $upper, $lower) = 'false'
								and count(../tia:Partij[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:verkrijgerRechtRef/@xlink:href]) > count(../tia:Partij[tia:IMKAD_Persoon[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef/@xlink:href and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true'] or tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef/@xlink:href and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true'] or tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef/@xlink:href and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']])
								and count(tia:IMKAD_ZakelijkRecht/tia:Toedeling) > 0">
				<xsl:variable name="_parties">
					<tia:root>
						<xsl:copy-of select="current()/../tia:Partij[not(tia:IMKAD_Persoon[(concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef/@xlink:href and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true') or tia:GerelateerdPersoon/tia:IMKAD_Persoon[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef/@xlink:href and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true'] or tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef/@xlink:href and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']])]"/>
					</tia:root>
				</xsl:variable>
				<xsl:variable name="parties" select="exslt:node-set($_parties)"/>
				<xsl:variable name="rights" select="tia:IMKAD_ZakelijkRecht"/>
				<xsl:variable name="_numberedRights">
					<xsl:for-each select="$rights">
						<tia:IMKAD_ZakelijkRecht>
							<tia:orderNumber>
								<xsl:value-of select="count(preceding-sibling::tia:IMKAD_ZakelijkRecht) + 1"/>
							</tia:orderNumber>
							<xsl:copy-of select="*"/>
						</tia:IMKAD_ZakelijkRecht>
					</xsl:for-each>
				</xsl:variable>
				<xsl:variable name="numberedRights" select="exslt:node-set($_numberedRights)"/>
				<xsl:variable name="_groupPartiesAndRights">
					<xsl:call-template name="groupPartiesAndRights">
						<xsl:with-param name="parties" select="$parties"/>
						<xsl:with-param name="rights" select="$numberedRights/tia:IMKAD_ZakelijkRecht"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:variable name="groupPartiesAndRights" select="exslt:node-set($_groupPartiesAndRights)"/>
				<xsl:variable name="_sortedGroupPartiesAndRights">
					<xsl:apply-templates select="$groupPartiesAndRights/tia:groups"/>
				</xsl:variable>
				<xsl:variable name="sortedGroupPartiesAndRights" select="exslt:node-set($_sortedGroupPartiesAndRights)"/>
				<xsl:variable name="_allParties">
					<tia:root>
						<xsl:copy-of select="current()/../tia:Partij[tia:IMKAD_Persoon[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef/@xlink:href or tia:GerelateerdPersoon/tia:IMKAD_Persoon[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef/@xlink:href] or tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[concat('#', @id) = current()/tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef/@xlink:href]]]"/>
					</tia:root>
				</xsl:variable>
				<xsl:variable name="allParties" select="exslt:node-set($_allParties)"/>
				<xsl:variable name="_groupParties">
					<xsl:call-template name="groupParties">
						<xsl:with-param name="parties" select="$allParties"/>
						<xsl:with-param name="rights" select="$root/tia:IMKAD_ZakelijkRecht"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:variable name="groupParties" select="exslt:node-set($_groupParties)"/>
				<xsl:variable name="_groupedPersonsAndRights">
					<xsl:for-each select="$groupParties/tia:groups/tia:group">
						<xsl:variable name="_groupPersonsAndRights">
							<xsl:call-template name="groupPersonsAndRights">
								<xsl:with-param name="persons" select="tia:Partij/tia:IMKAD_Persoon[concat('#', @id) = $root/tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef/@xlink:href and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true'] | tia:Partij/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']/tia:GerelateerdPersoon/tia:IMKAD_Persoon[concat('#', @id) = $root/tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef/@xlink:href and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true'] | tia:Partij/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']/tia:GerelateerdPersoon/tia:IMKAD_Persoon[concat('#', @id) = $root/tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef/@xlink:href and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']"/>
								<xsl:with-param name="rights" select="$root/tia:IMKAD_ZakelijkRecht"/>
								<xsl:with-param name="acquirerParty" select="tia:Partij"/>
								<xsl:with-param name="variant" select="'12'"/>
							</xsl:call-template>
						</xsl:variable>
						<xsl:variable name="groupPersonsAndRights" select="exslt:node-set($_groupPersonsAndRights)"/>
						<xsl:variable name="_sortedGroupPersonsAndRights">
							<xsl:apply-templates select="$groupPersonsAndRights/tia:groups"/>
						</xsl:variable>
						<xsl:variable name="sortedGroupPersonsAndRights" select="exslt:node-set($_sortedGroupPersonsAndRights)"/>
						<tia:groups>
							<tia:group>
								<xsl:copy-of select="tia:Partij"/>
							</tia:group>
							<xsl:copy-of select="$sortedGroupPersonsAndRights"/>
						</tia:groups>
					</xsl:for-each>
				</xsl:variable>
				<xsl:variable name="groupedPersonsAndRights" select="exslt:node-set($_groupedPersonsAndRights)"/>
				<xsl:variable name="_sortedGroupPersonsAndRights">
					<xsl:for-each select="$groupedPersonsAndRights/tia:groups">
						<tia:groups>
							<xsl:copy-of select="tia:group"/>
							<xsl:apply-templates select="tia:groups"/>
						</tia:groups>
					</xsl:for-each>
				</xsl:variable>
				<xsl:variable name="sortedGroupPersonsAndRights" select="exslt:node-set($_sortedGroupPersonsAndRights)"/>
				<p>
					<xsl:apply-templates select="." mode="do-allocation-header">
						<xsl:with-param name="dubbelePunt" select="':'"/>
					</xsl:apply-templates>
				</p>
				<xsl:for-each select="$numberedRights/tia:IMKAD_ZakelijkRecht">
					<xsl:variable name="processedPartiesRightsGroup" select="$sortedGroupPartiesAndRights/tia:groups/tia:group[tia:IMKAD_ZakelijkRecht[tia:orderNumber = current()/tia:orderNumber]]"/>
					<xsl:variable name="processedPersonsRightsGroup" select="$sortedGroupPersonsAndRights/tia:groups[tia:groups/tia:group[tia:IMKAD_ZakelijkRecht[tia:orderNumber = current()/tia:orderNumber]]]"/>
					<!-- process this group if it should be processed, and if is not already processed -->
					<xsl:if test="$processedPartiesRightsGroup and count($processedPartiesRightsGroup/tia:IMKAD_ZakelijkRecht[tia:orderNumber = current()/tia:orderNumber]/preceding-sibling::tia:IMKAD_ZakelijkRecht) = 0">
						<xsl:variable name="processedGroupPersonsAndRightsCount" select="count($sortedGroupPersonsAndRights/tia:groups[tia:groups/tia:group[tia:IMKAD_ZakelijkRecht[tia:orderNumber &lt; current()/tia:orderNumber]]])"/>
						<xsl:variable name="isLastPartyRightsGroup">
							<xsl:choose>
								<xsl:when test="count($sortedGroupPartiesAndRights/tia:groups/tia:group[tia:IMKAD_ZakelijkRecht[tia:orderNumber = current()/tia:orderNumber]]/following-sibling::tia:group) = 0
									and $processedGroupPersonsAndRightsCount = count($sortedGroupPersonsAndRights/tia:groups[tia:groups/tia:group[tia:IMKAD_ZakelijkRecht]])">
									<xsl:text>true</xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>false</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="_groupedRights">
							<tia:root>
								<xsl:copy-of select="$processedPartiesRightsGroup/tia:IMKAD_ZakelijkRecht"/>
							</tia:root>
						</xsl:variable>
						<xsl:variable name="groupedRights" select="exslt:node-set($_groupedRights)"/>
						<xsl:variable name="_groupedParties">
							<tia:root>
								<xsl:copy-of select="$processedPartiesRightsGroup/tia:Partij"/>
							</tia:root>
						</xsl:variable>
						<xsl:variable name="groupedParties" select="exslt:node-set($_groupedParties)"/>
						<xsl:variable name="onverdeeld">
							<xsl:value-of select="$processedPartiesRightsGroup/tia:IMKAD_ZakelijkRecht[1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
									translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
									translate(normalize-space($processedPartiesRightsGroup/tia:IMKAD_ZakelijkRecht[1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
						</xsl:variable>
						<table cellspacing="0" cellpadding="0">
							<tbody>
								<xsl:apply-templates select="$root" mode="do-allocation-to-one-or-more-parties-with-equal-shares-for-each-of-the-persons">
									<xsl:with-param name="parties" select="$groupedParties"/>
									<xsl:with-param name="rights" select="$groupedRights"/>
									<xsl:with-param name="onverdeeld" select="$onverdeeld"/>
									<xsl:with-param name="isLast" select="$isLastPartyRightsGroup"/>
									<xsl:with-param name="variant" select="12"/>
								</xsl:apply-templates>
							</tbody>
						</table>
					</xsl:if>
					<!-- process this group if it should be processed, and if is not already processed -->
					<xsl:if test="$processedPersonsRightsGroup and count($processedPersonsRightsGroup/tia:groups/tia:group[1]/tia:IMKAD_ZakelijkRecht[tia:orderNumber = current()/tia:orderNumber]/preceding-sibling::tia:IMKAD_ZakelijkRecht) = 0
									and count($processedPersonsRightsGroup/tia:groups/tia:group[tia:IMKAD_ZakelijkRecht[tia:orderNumber = current()/tia:orderNumber] and count(preceding-sibling::tia:group[tia:IMKAD_ZakelijkRecht[tia:orderNumber = current()/tia:orderNumber]]) = 0]/preceding-sibling::tia:group) = 0">
						<xsl:variable name="processedPartiesRightsGroupCount" select="count($sortedGroupPartiesAndRights/tia:groups/tia:group[tia:IMKAD_ZakelijkRecht[tia:orderNumber &lt;= current()/tia:orderNumber]])"/>
						<xsl:variable name="isLastPersonRightsGroup">
							<xsl:choose>
								<xsl:when test="count($sortedGroupPersonsAndRights/tia:groups[tia:group[tia:IMKAD_ZakelijkRecht[tia:orderNumber = current()/tia:orderNumber]]]/following-sibling::tia:groups) = 0
										and $processedPartiesRightsGroupCount = count($sortedGroupPartiesAndRights/tia:groups/tia:group[tia:IMKAD_ZakelijkRecht])">
									<xsl:text>true</xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>false</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="currentPartijId" select="$processedPersonsRightsGroup/tia:group/tia:Partij/@id"/>
						<xsl:variable name="currentPartij" select="$root/../tia:Partij[@id=$currentPartijId]"/>
						<xsl:apply-templates select="$root" mode="do-allocation-to-different-persons-within-one-party">
							<xsl:with-param name="authorizedRepresentative" select="$currentPartij/tia:Gevolmachtigde"/>
							<xsl:with-param name="acquiringPersons" select="$currentPartij/tia:IMKAD_Persoon[concat('#', @id) = $root/tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef/@xlink:href and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true'] | $currentPartij/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']/tia:GerelateerdPersoon/tia:IMKAD_Persoon[concat('#', @id) = $root/tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef/@xlink:href and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true'] | $currentPartij/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']/tia:GerelateerdPersoon/tia:IMKAD_Persoon[concat('#', @id) = $root/tia:IMKAD_ZakelijkRecht/tia:Toedeling/tia:verkrijgerRechtRef/@xlink:href and translate(tia:tia_IndGerechtigde,$upper,$lower) = 'true']"/>
							<xsl:with-param name="acquirerParty" select="$currentPartij"/>
							<xsl:with-param name="isLastGroup" select="$isLastPersonRightsGroup"/>
							<xsl:with-param name="variant" select="'12'"/>
						</xsl:apply-templates>
					</xsl:if>
				</xsl:for-each>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-allocation-to-one-or-more-parties-with-equal-shares-for-each-of-the-persons-variantA1
	*********************************************************
	Public: no

	Identity transform: no

	Description: variant A1 van do-allocation-to-one-or-more-parties-with-equal-shares-for-each-of-the-persons
					Aangezien deze op veel punten niet overeenkomt met do-allocation-to-one-or-more-parties-with-equal-shares-for-each-of-the-persons hier een apart template

	Input: tia:StukdeelVerdelingVennootschap, tia:StukdeelVerdelingHuwelijk, tia:StukdeelVerdelingPartnerschap or tia:StukdeelVerdelingGemeenschap

	Params: parties - list of parties to which rights are allocated
			rights - list of all rights allocated to party/parties
			onverdeeld - method of allocation
			jointAllocation - are rights jointly allocated to party/parties

	Output: XHTML structure

	Calls:
	(none)

	Called by:
	(mode) do-distribution
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:StukdeelVerdelingVennootschap | tia:StukdeelVerdelingHuwelijk | tia:StukdeelVerdelingPartnerschap | tia:StukdeelVerdelingGemeenschap | tia:StukdeelVerdelingUittredingVennoten" mode="do-allocation-to-one-or-more-parties-with-equal-shares-for-each-of-the-persons-variantA1">
		<xsl:param name="parties" select="self::node()[false()]"/>
		<xsl:param name="rights" select="self::node()[false()]"/>
		<xsl:param name="onverdeeld" select="''"/>
		<xsl:param name="jointAllocation" select="'false'"/>
		<xsl:variable name="eenOfMeer">
			<xsl:call-template name="benamingRegistergoed">
				<xsl:with-param name="aantalRegistergoederen" select="count(tia:IMKAD_ZakelijkRecht)"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="numberOfAcquiringParties" select="count($parties/tia:root/tia:Partij)"/>
		<xsl:variable name="numberOfAcquiringPersons" select="count($parties/tia:root/tia:Partij/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true'])
				+ count($parties/tia:root/tia:Partij/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true'])
				+ count($parties/tia:root/tia:Partij/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true'])"/>
		<xsl:variable name="numberOfRegisteredObjects">
			<xsl:choose>
				<xsl:when test="translate($jointAllocation, $upper, $lower) = 'true'">
					<xsl:value-of select="count(tia:IMKAD_ZakelijkRecht)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="count($rights/tia:root/tia:IMKAD_ZakelijkRecht)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:for-each select="$parties/tia:root/tia:Partij">
			<xsl:value-of select="tia:aanduidingPartij"/>
			<xsl:choose>
				<xsl:when test="position() = last() - 1">
					<xsl:text> en </xsl:text>
				</xsl:when>
				<xsl:when test="position() != last()">
					<xsl:text>, </xsl:text>
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>
		<xsl:text>, die bij deze </xsl:text>
		<xsl:choose>
			<xsl:when test="count($parties/tia:root/tia:Partij) > 1">
				<xsl:text>verklaren</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>verklaart</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:text> te aanvaarden</xsl:text>
		<xsl:if test="($numberOfAcquiringParties = 1 and $numberOfAcquiringPersons > 1) or $numberOfAcquiringParties > 1">
			<xsl:text> ieder voor</xsl:text>
			<xsl:choose>
				<xsl:when test="$numberOfAcquiringParties = 1 and $numberOfAcquiringPersons > 1">
					<xsl:choose>
						<xsl:when test="$numberOfAcquiringPersons = 2">
							<xsl:text> de </xsl:text>
							<xsl:if test="normalize-space($onverdeeld) != ''">
								<xsl:value-of select="$onverdeeld"/>
								<xsl:text>e </xsl:text>
							</xsl:if>
							<xsl:text>helft</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text> het een/</xsl:text>
							<xsl:value-of select="kef:convertOrdinalToText(string($numberOfAcquiringPersons))"/>
							<xsl:text> (1/</xsl:text>
							<xsl:value-of select="$numberOfAcquiringPersons"/>
							<xsl:text>) </xsl:text>
							<xsl:if test="normalize-space($onverdeeld) != ''">
								<xsl:value-of select="$onverdeeld"/>
								<xsl:text> </xsl:text>
							</xsl:if>
							<xsl:text>aandeel</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="$numberOfAcquiringParties > 1">
					<xsl:choose>
						<xsl:when test="$numberOfAcquiringParties = 2">
							<xsl:text> de </xsl:text>
							<xsl:if test="normalize-space($onverdeeld) != ''">
								<xsl:value-of select="$onverdeeld"/>
								<xsl:text>e </xsl:text>
							</xsl:if>
							<xsl:text>helft</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text> het een/</xsl:text>
							<xsl:value-of select="kef:convertOrdinalToText(string($numberOfAcquiringParties))"/>
							<xsl:text> (1/</xsl:text>
							<xsl:value-of select="$numberOfAcquiringParties"/>
							<xsl:text>) </xsl:text>
							<xsl:if test="normalize-space($onverdeeld) != ''">
								<xsl:value-of select="$onverdeeld"/>
								<xsl:text> </xsl:text>
							</xsl:if>
							<xsl:text>aandeel</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
			</xsl:choose>
		</xsl:if>
		<xsl:text>: </xsl:text>
		<xsl:choose>
			<xsl:when test="$eenOfMeer = 'registergoed'">
				<xsl:text>het registergoed</xsl:text>
			</xsl:when>
			<xsl:when test="$eenOfMeer = 'registergoederen'">
				<xsl:text>de registergoederen</xsl:text>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-allocation-to-one-or-more-parties-with-equal-shares-for-each-of-the-persons
	*********************************************************
	Public: no

	Identity transform: no

	Description: Block for distribution deed's transfer of title allocated to one or more parties, with equal shares for each of the persons.

	Input: tia:StukdeelVerdelingVennootschap, tia:StukdeelVerdelingHuwelijk, tia:StukdeelVerdelingPartnerschap or tia:StukdeelVerdelingGemeenschap

	Params: parties - list of parties to which rights are allocated
			rights - list of all rights allocated to party/parties
			onverdeeld - method of allocation
			jointAllocation - are rights jointly allocated to party/parties

	Output: XHTML structure

	Calls:
	(none)

	Called by:
	(mode) do-distribution
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:StukdeelVerdelingVennootschap | tia:StukdeelVerdelingHuwelijk | tia:StukdeelVerdelingPartnerschap | tia:StukdeelVerdelingGemeenschap | tia:StukdeelVerdelingUittredingVennoten" mode="do-allocation-to-one-or-more-parties-with-equal-shares-for-each-of-the-persons">
		<xsl:param name="parties" select="self::node()[false()]"/>
		<xsl:param name="rights" select="self::node()[false()]"/>
		<xsl:param name="onverdeeld" select="''"/>
		<xsl:param name="jointAllocation" select="'false'"/>
		<xsl:param name="isLast" select="'false'"/>
		<xsl:param name="aantalParties" select="0"/>
		<xsl:param name="variant" select="'0'"/>
		<xsl:variable name="eenOfMeer">
			<xsl:call-template name="benamingRegistergoed">
				<xsl:with-param name="aantalRegistergoederen" select="count(tia:IMKAD_ZakelijkRecht)"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="numberOfAcquiringParties" select="count($parties/tia:root/tia:Partij)"/>
		<xsl:variable name="numberOfAcquiringPersons" select="count($parties/tia:root/tia:Partij/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true'])
				+ count($parties/tia:root/tia:Partij/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true'])
				+ count($parties/tia:root/tia:Partij/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true'])"/>
		<xsl:variable name="numberOfRegisteredObjects">
			<xsl:choose>
				<xsl:when test="translate($jointAllocation, $upper, $lower) = 'true'">
					<xsl:value-of select="count(tia:IMKAD_ZakelijkRecht)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="count($rights/tia:root/tia:IMKAD_ZakelijkRecht)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<tr>
			<xsl:if test="$aantalParties > 1 or number($variant) > 6">
				<td class="number" valign="top">
					<xsl:text>-</xsl:text>
				</td>
			</xsl:if>
			<td>
				<xsl:for-each select="$parties/tia:root/tia:Partij">
					<xsl:value-of select="tia:aanduidingPartij"/>
					<xsl:choose>
						<xsl:when test="position() = last() - 1">
							<xsl:text> en </xsl:text>
						</xsl:when>
						<xsl:when test="position() != last()">
							<xsl:text>, </xsl:text>
						</xsl:when>
					</xsl:choose>
				</xsl:for-each>
				<xsl:text>, die bij deze </xsl:text>
				<xsl:choose>
					<xsl:when test="count($parties/tia:root/tia:Partij) > 1">
						<xsl:text>verklaren</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>verklaart</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:text> te aanvaarden</xsl:text>
				<xsl:if test="($numberOfAcquiringParties = 1 and $numberOfAcquiringPersons > 1) or $numberOfAcquiringParties > 1">
					<xsl:text> ieder voor</xsl:text>
					<xsl:choose>
						<xsl:when test="$numberOfAcquiringParties = 1 and $numberOfAcquiringPersons > 1">
							<xsl:choose>
								<xsl:when test="$numberOfAcquiringPersons = 2">
									<xsl:text> de </xsl:text>
									<xsl:if test="normalize-space($onverdeeld) != ''">
										<xsl:value-of select="$onverdeeld"/>
										<xsl:text>e </xsl:text>
									</xsl:if>
									<xsl:text>helft</xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text> het een/</xsl:text>
									<xsl:value-of select="kef:convertOrdinalToText(string($numberOfAcquiringPersons))"/>
									<xsl:text> (1/</xsl:text>
									<xsl:value-of select="$numberOfAcquiringPersons"/>
									<xsl:text>) </xsl:text>
									<xsl:if test="normalize-space($onverdeeld) != ''">
										<xsl:value-of select="$onverdeeld"/>
										<xsl:text> </xsl:text>
									</xsl:if>
									<xsl:text>aandeel</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:when test="$numberOfAcquiringParties > 1">
							<xsl:choose>
								<xsl:when test="$numberOfAcquiringParties = 2">
									<xsl:text> de </xsl:text>
									<xsl:if test="normalize-space($onverdeeld) != ''">
										<xsl:value-of select="$onverdeeld"/>
										<xsl:text>e </xsl:text>
									</xsl:if>
									<xsl:text>helft</xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text> het een/</xsl:text>
									<xsl:value-of select="kef:convertOrdinalToText(string($numberOfAcquiringParties))"/>
									<xsl:text> (1/</xsl:text>
									<xsl:value-of select="$numberOfAcquiringParties"/>
									<xsl:text>) </xsl:text>
									<xsl:if test="normalize-space($onverdeeld) != ''">
										<xsl:value-of select="$onverdeeld"/>
										<xsl:text> </xsl:text>
									</xsl:if>
									<xsl:text>aandeel</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
					</xsl:choose>
				</xsl:if>
				<xsl:text>: </xsl:text>
				<xsl:choose>
					<xsl:when test="$numberOfRegisteredObjects > 0 and translate($jointAllocation, $upper, $lower) = 'false'">
						<xsl:choose>
							<xsl:when test="$numberOfRegisteredObjects = 1">
								<xsl:text>het registergoed </xsl:text>
							</xsl:when>
							<xsl:when test="$numberOfRegisteredObjects > 1">
								<xsl:text>de registergoederen </xsl:text>
							</xsl:when>
						</xsl:choose>
						<xsl:for-each select="$rights/tia:root/tia:IMKAD_ZakelijkRecht">
							<xsl:value-of select="tia:orderNumber"/>
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
					<xsl:when test="$eenOfMeer = 'registergoed'">
						<xsl:text>het registergoed</xsl:text>
					</xsl:when>
					<xsl:when test="$eenOfMeer = 'registergoederen'">
						<xsl:text>de registergoederen</xsl:text>
					</xsl:when>
				</xsl:choose>
				<xsl:choose>
					<xsl:when test="translate($isLast, $upper, $lower) = 'true'">
						<xsl:text>.</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>; en aan</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</td>
		</tr>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-allocation-to-different-persons-within-one-party
	*********************************************************
	Public: no

	Identity transform: no

	Description: Block for distribution deed's transfer of title allocated within one party, to different persons.

	Input: tia:StukdeelVerdelingVennootschap, tia:StukdeelVerdelingHuwelijk, tia:StukdeelVerdelingPartnerschap or tia:StukdeelVerdelingGemeenschap

	Params: authorizedRepresentative - authorized representative of acquirer party
			acquiringPersons - acquiring persons that have share in some rights and/or are allocated to some rights
			acquirerParty - acquirer party
			allocatedToAll - indicator if allocation is made to all rights
			isLastGroup - processed party group is the last one
			variant - number of variant

	Output: XHTML structure

	Calls:
	(mode) do-gender-salutation
	(mode) do-allocation-to-different-persons-within-one-party-common
	(name) groupPersonsAndRights

	Called by:
	(mode) do-distribution
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:StukdeelVerdelingVennootschap | tia:StukdeelVerdelingHuwelijk | tia:StukdeelVerdelingPartnerschap | tia:StukdeelVerdelingGemeenschap | tia:StukdeelVerdelingUittredingVennoten" mode="do-allocation-to-different-persons-within-one-party">
		<xsl:param name="authorizedRepresentative" select="self::node()[false()]"/>
		<xsl:param name="acquiringPersons" select="self::node()[false()]"/>
		<xsl:param name="acquirerParty" select="self::node()[false()]"/>
		<xsl:param name="allocatedToAll" select="'false'"/>
		<xsl:param name="isLastGroup" select="'false'"/>
		<xsl:param name="indentGevolmachtigden" select="0"/>
		<xsl:param name="variant" select="'0'"/>
		<xsl:variable name="root" select="."/>
		<xsl:variable name="authorizedRepresentativeGenderSalutation">
			<xsl:apply-templates select="$authorizedRepresentative/tia:gegevens/tia:persoonGegevens" mode="do-gender-salutation"/>
		</xsl:variable>
		<xsl:variable name="_groupPersonsAndRightsTemp">
			<xsl:call-template name="groupPersonsAndRights">
				<xsl:with-param name="persons" select="$acquiringPersons"/>
				<xsl:with-param name="rights" select="tia:IMKAD_ZakelijkRecht"/>
				<xsl:with-param name="acquirerParty" select="$acquirerParty"/>
				<xsl:with-param name="variant" select="$variant"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="groupPersonsAndRightsTemp" select="exslt:node-set($_groupPersonsAndRightsTemp)"/>
		<xsl:variable name="_groupPersonsAndRights">
			<tia:groups>
				<xsl:for-each select="$groupPersonsAndRightsTemp/tia:groups/tia:group">
					<xsl:variable name="currentGroup" select="."/>
					<xsl:if test="not($currentGroup/preceding-sibling::tia:group[count(tia:IMKAD_Persoon[@id = $currentGroup/tia:IMKAD_Persoon/@id]) = count(tia:IMKAD_Persoon) and count(tia:IMKAD_Persoon) = count($currentGroup/tia:IMKAD_Persoon)
										and count(tia:IMKAD_ZakelijkRecht[tia:orderNumber = $currentGroup/tia:IMKAD_ZakelijkRecht/tia:orderNumber]) = count(tia:IMKAD_ZakelijkRecht) and count(tia:IMKAD_ZakelijkRecht) = count($currentGroup/tia:IMKAD_ZakelijkRecht)])">
						<tia:group>
							<xsl:copy-of select="$currentGroup/*"/>
						</tia:group>
					</xsl:if>
				</xsl:for-each>
			</tia:groups>
		</xsl:variable>
		<xsl:variable name="groupPersonsAndRights" select="exslt:node-set($_groupPersonsAndRights)"/>
		<xsl:variable name="_sortedGroupPersonsAndRights">
			<xsl:apply-templates select="$groupPersonsAndRights/tia:groups"/>
		</xsl:variable>
		<xsl:variable name="sortedGroupPersonsAndRights" select="exslt:node-set($_sortedGroupPersonsAndRights)"/>
		<xsl:variable name="aantalRegels" select="count($sortedGroupPersonsAndRights/tia:groups/tia:group)"/>
		<xsl:choose>
			<xsl:when test="count($acquiringPersons) = 1">
				<xsl:variable name="onverdeeld">
					<xsl:choose>
						<xsl:when test="tia:verkrijgerRechtRef">
							<xsl:value-of select="$root/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
								translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
								translate(normalize-space($root/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$sortedGroupPersonsAndRights/tia:groups/tia:group[1]/tia:IMKAD_ZakelijkRecht[1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
								translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
								translate(normalize-space($sortedGroupPersonsAndRights/tia:groups/tia:group[1]/tia:IMKAD_ZakelijkRecht[1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<!-- have authorized representative -->
				<xsl:if test="$authorizedRepresentative[tia:vertegenwoordigtRef/@xlink:href = concat('#', $acquirerParty/tia:Hoedanigheid[count(tia:wordtVertegenwoordigdRef) = 0]/@id)
								or tia:vertegenwoordigtRef/@xlink:href = concat('#', $acquirerParty/tia:Hoedanigheid[tia:wordtVertegenwoordigdRef/@xlink:href = concat('#', $acquiringPersons/@id)]/@id)]">
					<table cellspacing="0" cellpadding="0">
						<tbody>
							<tr>
								<xsl:if test="$indentGevolmachtigden > 1">
									<td class="number" valign="top">
										<xsl:text>-</xsl:text>
									</td>
								</xsl:if>
								<td>
									<xsl:call-template name="do-gevolmachtigde">
										<xsl:with-param name="authorizedRepresentative" select="$authorizedRepresentative"/>
										<xsl:with-param name="endMark" select="':'"/>
									</xsl:call-template>
								</td>
							</tr>
						</tbody>
					</table>
				</xsl:if>
				<xsl:for-each select="$sortedGroupPersonsAndRights/tia:groups/tia:group">
					<xsl:variable name="personId" select="concat('#', tia:IMKAD_Persoon/@id)"/>
					<xsl:variable name="isLast" select="normalize-space(translate($isLastGroup, $upper, $lower)) = 'true' and position() = last()"/>
					<xsl:if test="tia:IMKAD_ZakelijkRecht/tia:Toedeling[tia:verkrijgerRechtRef[@*[translate(local-name(), $upper, $lower) = 'href'] = $personId] and tia:aandeel]">
						<table cellspacing="0" cellpadding="0">
							<tbody>
								<tr>
									<xsl:if test="(number($variant) > 6) or 
											(count($sortedGroupPersonsAndRights/tia:groups/tia:group[concat('#', tia:IMKAD_Persoon/@id) = $personId]) > 1
														and ($acquirerParty/tia:Hoedanigheid[@id = substring-after($authorizedRepresentative/tia:vertegenwoordigtRef/@xlink:href, '#') and tia:wordtVertegenwoordigdRef/@xlink:href = $personId]
																or $acquirerParty/tia:Hoedanigheid[@id = substring-after($authorizedRepresentative/tia:vertegenwoordigtRef/@xlink:href, '#') and count(tia:wordtVertegenwoordigdRef) = 0]))">
										<td class="number" valign="top">
											<xsl:text>-</xsl:text>
										</td>
									</xsl:if>
									<td>
										<xsl:apply-templates select="tia:IMKAD_Persoon" mode="do-allocation-to-different-persons-within-one-party-common">
											<xsl:with-param name="authorizedRepresentative" select="$authorizedRepresentative"/>
											<xsl:with-param name="rights" select="tia:IMKAD_ZakelijkRecht[tia:Toedeling[tia:verkrijgerRechtRef[@*[translate(local-name(), $upper, $lower) = 'href'] = $personId] and tia:aandeel]]"/>
											<xsl:with-param name="acquirerParty" select="$acquirerParty"/>
											<xsl:with-param name="onverdeeld" select="$onverdeeld"/>
											<xsl:with-param name="allocatedToAll" select="$allocatedToAll"/>
											<xsl:with-param name="isLast" select="$isLast"/>
											<xsl:with-param name="numberOfRights" select="count($root/tia:IMKAD_ZakelijkRecht)"/>
										</xsl:apply-templates>
									</td>
								</tr>
							</tbody>
						</table>
					</xsl:if>
					<xsl:if test="tia:IMKAD_ZakelijkRecht[tia:Toedeling[tia:verkrijgerRechtRef[@*[translate(local-name(), $upper, $lower) = 'href'] = $personId] and not(tia:aandeel)]]">
						<table cellspacing="0" cellpadding="0">
							<tbody>
								<tr>
									<xsl:if test="number($variant > 6) or
											(count($sortedGroupPersonsAndRights/tia:groups/tia:group[concat('#', tia:IMKAD_Persoon/@id) = $personId]) > 1
														and ($acquirerParty/tia:Hoedanigheid[@id = substring-after($authorizedRepresentative/tia:vertegenwoordigtRef/@xlink:href, '#') and tia:wordtVertegenwoordigdRef/@xlink:href = $personId]
																or $acquirerParty/tia:Hoedanigheid[@id = substring-after($authorizedRepresentative/tia:vertegenwoordigtRef/@xlink:href, '#') and count(tia:wordtVertegenwoordigdRef) = 0]))">
										<td class="number" valign="top">
											<xsl:text>-</xsl:text>
										</td>
									</xsl:if>
									<td>
										<xsl:apply-templates select="tia:IMKAD_Persoon" mode="do-allocation-to-different-persons-within-one-party-common">
											<xsl:with-param name="authorizedRepresentative" select="$authorizedRepresentative"/>
											<xsl:with-param name="rights" select="tia:IMKAD_ZakelijkRecht[tia:Toedeling[tia:verkrijgerRechtRef[@*[translate(local-name(), $upper, $lower) = 'href'] = $personId] and not(tia:aandeel)]]"/>
											<xsl:with-param name="acquirerParty" select="$acquirerParty"/>
											<xsl:with-param name="onverdeeld" select="$onverdeeld"/>
											<xsl:with-param name="allocatedToAll" select="$allocatedToAll"/>
											<xsl:with-param name="isLast" select="$isLast"/>
											<xsl:with-param name="numberOfRights" select="count($root/tia:IMKAD_ZakelijkRecht)"/>
										</xsl:apply-templates>
									</td>
								</tr>
							</tbody>
						</table>
					</xsl:if>
				</xsl:for-each>
			</xsl:when>
			<xsl:when test="count($acquiringPersons) > 1">
				<xsl:choose>
					<!-- Gevolmachtigde refer to Hoedanigheid with wordtVertegenwoordigdRef -->
					<xsl:when test="$authorizedRepresentative and $acquirerParty/descendant::tia:Hoedanigheid[concat('#', @id) = $authorizedRepresentative/tia:vertegenwoordigtRef/@xlink:href]/descendant::tia:wordtVertegenwoordigdRef">
						<xsl:variable name="currentGevolmachtigde" select="$acquirerParty/tia:Gevolmachtigde"/>
						<xsl:variable name="hoedanigheidOfAcquirerParty" select="$acquirerParty/tia:Hoedanigheid[concat('#', @id) = $currentGevolmachtigde/tia:vertegenwoordigtRef/@xlink:href]"/>
						<!-- Print persons NOT represented by Gevolmachtigde -->
						<xsl:for-each select="$sortedGroupPersonsAndRights/tia:groups/tia:group">
							<xsl:variable name="_currentPersonId" select="concat('#', current()/tia:IMKAD_Persoon/@id)"/>
							<!-- skip groups which contains the same (already processed) person-right(s) combination
								and check if current IMKAD_Persoon is referenced in Gevolmachtigde-->
							<xsl:if test="not(current()/preceding-sibling::tia:group[tia:IMKAD_Persoon[@id = current()/tia:IMKAD_Persoon/@id]
										and tia:IMKAD_ZakelijkRecht[tia:orderNumber = current()/tia:IMKAD_ZakelijkRecht/tia:orderNumber]
										and count(tia:IMKAD_ZakelijkRecht) = count(current()/tia:IMKAD_ZakelijkRecht)])
										and not($hoedanigheidOfAcquirerParty/tia:wordtVertegenwoordigdRef[@xlink:href = $_currentPersonId])">
								<xsl:variable name="onverdeeld">
									<xsl:choose>
										<xsl:when test="$root/tia:verkrijgerRechtRef">
											<xsl:value-of select="$root/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
												translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
												translate(normalize-space($root/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="tia:IMKAD_ZakelijkRecht[1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
												translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
												translate(normalize-space(current()/tia:IMKAD_ZakelijkRecht[1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:variable>
								<xsl:variable name="isLast">
									<xsl:choose>
										<xsl:when test="translate($isLastGroup, $upper, $lower) = 'true'
															and count(tia:IMKAD_Persoon[@id = $_currentPersonId]/following-sibling::tia:IMKAD_Persoon[not(concat('#', @id) = $hoedanigheidOfAcquirerParty/tia:wordtVertegenwoordigdRef)])
															and count($hoedanigheidOfAcquirerParty/tia:wordtVertegenwoordigdRef[@xlink:href = $_currentPersonId]/following-sibling::tia:wordtVertegenwoordigdRef) = 0">
											<xsl:text>true</xsl:text>
										</xsl:when>
										<xsl:otherwise>
											<xsl:text>false</xsl:text>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:variable>
								<table cellspacing="0" cellpadding="0">
									<tbody>
										<tr>
											<xsl:if test="$aantalRegels > 1">
												<td class="number" valign="top">
													<xsl:text>-</xsl:text>
												</td>
											</xsl:if>
											<td>
												<xsl:apply-templates select="tia:IMKAD_Persoon" mode="do-allocation-to-different-persons-within-one-party-common">
													<xsl:with-param name="authorizedRepresentative" select="$authorizedRepresentative"/>
													<xsl:with-param name="rights" select="tia:IMKAD_ZakelijkRecht"/>
													<xsl:with-param name="onverdeeld" select="$onverdeeld"/>
													<xsl:with-param name="allocatedToAll" select="$allocatedToAll"/>
													<xsl:with-param name="isLast" select="translate($isLast, $upper, $lower) = 'true' and translate($isLastGroup, $upper, $lower) = 'true'"/>
													<xsl:with-param name="numberOfRights" select="count($root/tia:IMKAD_ZakelijkRecht)"/>
												</xsl:apply-templates>
											</td>
										</tr>
									</tbody>
								</table>
							</xsl:if>
						</xsl:for-each>
						<!-- Gevolmachtigde data - have authorized representative -->
						<table cellspacing="0" cellpadding="0">
							<tbody>
								<tr>
									<td class="number" valign="top">
										<xsl:text>-</xsl:text>
									</td>
									<td>
										<xsl:call-template name="do-gevolmachtigde">
											<xsl:with-param name="authorizedRepresentative" select="$authorizedRepresentative"/>
											<xsl:with-param name="endMark" select="''"/>
										</xsl:call-template>
										<!-- Persons represented by the Gevolmachtigde -->
										<xsl:for-each select="$sortedGroupPersonsAndRights/tia:groups/tia:group">
											<xsl:variable name="currentPersonId" select="concat('#', current()/tia:IMKAD_Persoon/@id)"/>
											<!-- skip groups which contains the same (already processed) person-right(s) combination
							and check if current IMKAD_Persoon is referenced in Gevolmachtigde-->
											<xsl:if test="not(preceding-sibling::tia:group[tia:IMKAD_Persoon[@id = current()/tia:IMKAD_Persoon/@id]
										and tia:IMKAD_ZakelijkRecht[tia:orderNumber = current()/tia:IMKAD_ZakelijkRecht/tia:orderNumber]
										and count(tia:IMKAD_ZakelijkRecht) = count(current()/tia:IMKAD_ZakelijkRecht)])
										and $hoedanigheidOfAcquirerParty/tia:wordtVertegenwoordigdRef[@xlink:href = $currentPersonId]">
												<xsl:variable name="onverdeeld">
													<xsl:choose>
														<xsl:when test="$root/tia:verkrijgerRechtRef">
															<xsl:value-of select="$root/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
														translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
														translate(normalize-space($root/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
														</xsl:when>
														<xsl:otherwise>
															<xsl:value-of select="tia:IMKAD_ZakelijkRecht[1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
														translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
														translate(normalize-space(current()/tia:IMKAD_ZakelijkRecht[1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
														</xsl:otherwise>
													</xsl:choose>
												</xsl:variable>
												<xsl:variable name="isLast">
													<xsl:choose>
														<xsl:when test="translate($isLastGroup, $upper, $lower) = 'true'
															and count($hoedanigheidOfAcquirerParty/tia:wordtVertegenwoordigdRef[@xlink:href = $currentPersonId]/following-sibling::tia:wordtVertegenwoordigdRef) = 0">
															<xsl:text>true</xsl:text>
														</xsl:when>
														<xsl:otherwise>
															<xsl:text>false</xsl:text>
														</xsl:otherwise>
													</xsl:choose>
												</xsl:variable>
												<xsl:choose>
													<xsl:when test="count($sortedGroupPersonsAndRights/tia:groups/tia:group[concat('#', tia:IMKAD_Persoon/@id) = $currentPersonId]) = 1">
														<xsl:text> </xsl:text>
														<xsl:apply-templates select="tia:IMKAD_Persoon" mode="do-allocation-to-different-persons-within-one-party-common">
															<xsl:with-param name="authorizedRepresentative" select="$authorizedRepresentative"/>
															<xsl:with-param name="rights" select="tia:IMKAD_ZakelijkRecht"/>
															<xsl:with-param name="onverdeeld" select="$onverdeeld"/>
															<xsl:with-param name="allocatedToAll" select="$allocatedToAll"/>
															<xsl:with-param name="isLast" select="translate($isLast, $upper, $lower) = 'true' and translate($isLastGroup, $upper, $lower) = 'true'"/>
															<xsl:with-param name="numberOfRights" select="count($root/tia:IMKAD_ZakelijkRecht)"/>
														</xsl:apply-templates>
													</xsl:when>
													<xsl:otherwise>
														<xsl:if test="count(preceding-sibling::tia:group[concat('#', tia:IMKAD_Persoon/@id) = $currentPersonId]) = 0">
															<xsl:text>:</xsl:text>
														</xsl:if>
														<table cellspacing="0" cellpadding="0">
															<tbody>
																<tr>
																	<xsl:if test="$authorizedRepresentative">
																		<td class="number" valign="top">
																			<xsl:text/>
																		</td>
																	</xsl:if>
																	<xsl:if test="number($variant > 6) or
														($acquirerParty/tia:Hoedanigheid[@id = substring-after($authorizedRepresentative/tia:vertegenwoordigtRef/@xlink:href, '#') and tia:wordtVertegenwoordigdRef/@xlink:href = $currentPersonId]
																or $acquirerParty/tia:Hoedanigheid[@id = substring-after($authorizedRepresentative/tia:vertegenwoordigtRef/@xlink:href, '#') and count(tia:wordtVertegenwoordigdRef) = 0])">
																		<td class="number" valign="top">
																			<xsl:text>-</xsl:text>
																		</td>
																	</xsl:if>
																	<td>
																		<xsl:apply-templates select="tia:IMKAD_Persoon" mode="do-allocation-to-different-persons-within-one-party-common">
																			<xsl:with-param name="authorizedRepresentative" select="$authorizedRepresentative"/>
																			<xsl:with-param name="rights" select="tia:IMKAD_ZakelijkRecht"/>
																			<xsl:with-param name="onverdeeld" select="$onverdeeld"/>
																			<xsl:with-param name="allocatedToAll" select="$allocatedToAll"/>
																			<xsl:with-param name="isLast" select="translate($isLast, $upper, $lower) = 'true' and translate($isLastGroup, $upper, $lower) = 'true'"/>
																			<xsl:with-param name="numberOfRights" select="count($root/tia:IMKAD_ZakelijkRecht)"/>
																		</xsl:apply-templates>
																	</td>
																</tr>
															</tbody>
														</table>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:if>
										</xsl:for-each>
									</td>
								</tr>
							</tbody>
						</table>
					</xsl:when>
					<!-- Party without persons represented by the Gevolmachtigde -->
					<xsl:otherwise>
						<!-- Gevolmachtigde data - have authorized representative-->
						<xsl:if test="$authorizedRepresentative">
							<xsl:choose>
								<xsl:when test="$indentGevolmachtigden = 1">
									<xsl:call-template name="do-gevolmachtigde">
										<xsl:with-param name="authorizedRepresentative" select="$authorizedRepresentative"/>
										<xsl:with-param name="endMark" select="':'"/>
									</xsl:call-template>
								</xsl:when>
								<xsl:otherwise>
									<table cellspacing="0" cellpadding="0">
										<tbody>
											<tr>
												<xsl:if test="$indentGevolmachtigden > 1 or $variant > 6">
													<td class="number" valign="top">
														<xsl:text>-</xsl:text>
													</td>
												</xsl:if>
												<td>
													<xsl:call-template name="do-gevolmachtigde">
														<xsl:with-param name="authorizedRepresentative" select="$authorizedRepresentative"/>
														<xsl:with-param name="endMark" select="':'"/>
													</xsl:call-template>
												</td>
											</tr>
										</tbody>
									</table>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:if>
						<!-- All persons from acquirerParty -->
						<xsl:for-each select="$sortedGroupPersonsAndRights/tia:groups/tia:group">
							<!-- skip groups which contains the same (already processed) person-right(s) combination -->
							<xsl:if test="not(current()/preceding-sibling::tia:group[tia:IMKAD_Persoon[@id = current()/tia:IMKAD_Persoon/@id]
										and tia:IMKAD_ZakelijkRecht[tia:orderNumber = current()/tia:IMKAD_ZakelijkRecht/tia:orderNumber]
										and count(tia:IMKAD_ZakelijkRecht) = count(current()/tia:IMKAD_ZakelijkRecht)])">
								<xsl:variable name="onverdeeld">
									<xsl:choose>
										<xsl:when test="$root/tia:verkrijgerRechtRef">
											<xsl:value-of select="$root/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
												translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
												translate(normalize-space($root/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="tia:IMKAD_ZakelijkRecht[1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
												translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
												translate(normalize-space(current()/tia:IMKAD_ZakelijkRecht[1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:variable>
								<xsl:variable name="isLast">
									<xsl:choose>
										<xsl:when test="translate($isLastGroup, $upper, $lower) = 'true' and count(current()/following-sibling::tia:group[tia:IMKAD_Persoon[@id = current()/tia:IMKAD_Persoon/@id]
												and tia:IMKAD_ZakelijkRecht[tia:orderNumber = current()/tia:IMKAD_ZakelijkRecht/tia:orderNumber]
												and count(tia:IMKAD_ZakelijkRecht) = count(current()/tia:IMKAD_ZakelijkRecht)]) = count(current()/following-sibling::tia:group)">
											<xsl:text>true</xsl:text>
										</xsl:when>
										<xsl:otherwise>
											<xsl:text>false</xsl:text>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:variable>
								<xsl:choose>
									<xsl:when test="$indentGevolmachtigden > 1 or $authorizedRepresentative">
										<table cellspacing="0" cellpadding="0">
											<tbody>
												<tr>
													<xsl:if test="$authorizedRepresentative and $variant > 6">
														<td class="number" valign="top">
															<xsl:text/>
														</td>
													</xsl:if>
													<td>
														<table cellspacing="0" cellpadding="0">
															<tbody>
																<tr>
																	<xsl:if test="$aantalRegels > 1 or number($variant) > 6">
																		<td class="number" valign="top">
																			<xsl:text>-</xsl:text>
																		</td>
																	</xsl:if>
																	<td>
																		<xsl:apply-templates select="tia:IMKAD_Persoon" mode="do-allocation-to-different-persons-within-one-party-common">
																			<xsl:with-param name="authorizedRepresentative" select="$authorizedRepresentative"/>
																			<xsl:with-param name="rights" select="tia:IMKAD_ZakelijkRecht"/>
																			<xsl:with-param name="onverdeeld" select="$onverdeeld"/>
																			<xsl:with-param name="allocatedToAll" select="$allocatedToAll"/>
																			<xsl:with-param name="isLast" select="translate($isLast, $upper, $lower) = 'true' and translate($isLastGroup, $upper, $lower) = 'true'"/>
																			<xsl:with-param name="numberOfRights" select="count($root/tia:IMKAD_ZakelijkRecht)"/>
																		</xsl:apply-templates>
																	</td>
																</tr>
															</tbody>
														</table>
													</td>
												</tr>
											</tbody>
										</table>
									</xsl:when>
									<xsl:otherwise>
										<table cellspacing="0" cellpadding="0">
											<tbody>
												<tr>
													<xsl:if test="$aantalRegels > 1 or number($variant) > 6">
														<td class="number" valign="top">
															<xsl:text>-</xsl:text>
														</td>
													</xsl:if>
													<td>
														<xsl:apply-templates select="tia:IMKAD_Persoon" mode="do-allocation-to-different-persons-within-one-party-common">
															<xsl:with-param name="authorizedRepresentative" select="$authorizedRepresentative"/>
															<xsl:with-param name="rights" select="tia:IMKAD_ZakelijkRecht"/>
															<xsl:with-param name="onverdeeld" select="$onverdeeld"/>
															<xsl:with-param name="allocatedToAll" select="$allocatedToAll"/>
															<xsl:with-param name="isLast" select="translate($isLast, $upper, $lower) = 'true' and translate($isLastGroup, $upper, $lower) = 'true'"/>
															<xsl:with-param name="numberOfRights" select="count($root/tia:IMKAD_ZakelijkRecht)"/>
														</xsl:apply-templates>
													</td>
												</tr>
											</tbody>
										</table>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:if>
						</xsl:for-each>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="do-gevolmachtigde">
		<xsl:param name="authorizedRepresentative"/>
		<xsl:param name="endMark"/>
		<xsl:variable name="authorizedRepresentativeGenderSalutation">
			<xsl:apply-templates select="$authorizedRepresentative/tia:gegevens/tia:persoonGegevens" mode="do-gender-salutation"/>
		</xsl:variable>
		<xsl:value-of select="$authorizedRepresentativeGenderSalutation"/>
		<xsl:text> </xsl:text>
		<xsl:choose>
			<xsl:when test="$authorizedRepresentative/tia:gegevens/tia:kadGegevensPersoon">
				<xsl:value-of select="$authorizedRepresentative/tia:gegevens/tia:kadGegevensPersoon/tia:voornamen"/>
				<xsl:text> </xsl:text>
				<xsl:if test="normalize-space($authorizedRepresentative/tia:gegevens/tia:kadGegevensPersoon/tia:voorvoegselsgeslachtsnaam) != ''">
					<xsl:value-of select="$authorizedRepresentative/tia:gegevens/tia:kadGegevensPersoon/tia:voorvoegselsgeslachtsnaam"/>
					<xsl:text> </xsl:text>
				</xsl:if>
				<xsl:value-of select="$authorizedRepresentative/tia:gegevens/tia:kadGegevensPersoon/tia:geslachtsnaam"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$authorizedRepresentative/tia:gegevens/tia:persoonGegevens/tia:naam/tia:voornamen"/>
				<xsl:text> </xsl:text>
				<xsl:if test="normalize-space($authorizedRepresentative/tia:gegevens/tia:persoonGegevens/tia:tia_VoorvoegselsNaam) != ''">
					<xsl:value-of select="$authorizedRepresentative/tia:gegevens/tia:persoonGegevens/tia:tia_VoorvoegselsNaam"/>
					<xsl:text> </xsl:text>
				</xsl:if>
				<xsl:value-of select="$authorizedRepresentative/tia:gegevens/tia:persoonGegevens/tia:tia_NaamZonderVoorvoegsels"/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="not($authorizedRepresentative/tia:GerelateerdPersoon)">
				<xsl:text> voornoemd, die bij deze verklaart te aanvaarden namens</xsl:text>
				<xsl:value-of select="$endMark"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="count($authorizedRepresentative/tia:GerelateerdPersoon) > 1">
						<xsl:text>, </xsl:text>
					</xsl:when>
					<xsl:when test="count($authorizedRepresentative/tia:GerelateerdPersoon) = 1">
						<xsl:text> en </xsl:text>
					</xsl:when>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:for-each select="$authorizedRepresentative/tia:GerelateerdPersoon">
			<xsl:choose>
				<xsl:when test="tia:IMKAD_Persoon/tia:tia_Gegevens/tia:GBA_Ingezetene">
					<xsl:variable name="authorizedRepresentativeRelatedPersonGenderSalutation">
						<xsl:apply-templates select="tia:IMKAD_Persoon/tia:tia_Gegevens/tia:GBA_Ingezetene" mode="do-gender-salutation"/>
					</xsl:variable>
					<xsl:if test="$authorizedRepresentativeRelatedPersonGenderSalutation">
						<xsl:value-of select="$authorizedRepresentativeRelatedPersonGenderSalutation"/>
						<xsl:text> </xsl:text>
					</xsl:if>
					<xsl:if test="normalize-space(tia:IMKAD_Persoon/tia:tia_Gegevens/tia:GBA_Ingezetene/tia:naam) != ''">
						<xsl:value-of select="tia:IMKAD_Persoon/tia:tia_Gegevens/tia:GBA_Ingezetene/tia:naam/tia:voornamen"/>
					</xsl:if>
					<xsl:if test="normalize-space(tia:IMKAD_Persoon/tia:tia_Gegevens/tia:GBA_Ingezetene/tia:tia_VoorvoegselsNaam) != ''">
						<xsl:text> </xsl:text>
						<xsl:value-of select="tia:IMKAD_Persoon/tia:tia_Gegevens/tia:GBA_Ingezetene/tia:tia_VoorvoegselsNaam"/>
					</xsl:if>
					<xsl:if test="normalize-space(tia:IMKAD_Persoon/tia:tia_Gegevens/tia:GBA_Ingezetene/tia:tia_NaamZonderVoorvoegsels) != ''">
						<xsl:text> </xsl:text>
						<xsl:value-of select="tia:IMKAD_Persoon/tia:tia_Gegevens/tia:GBA_Ingezetene/tia:tia_NaamZonderVoorvoegsels"/>
					</xsl:if>
				</xsl:when>
				<xsl:when test="tia:IMKAD_Persoon/tia:tia_Gegevens/tia:IMKAD_KadNatuurlijkPersoon">
					<xsl:if test="normalize-space(tia:IMKAD_Persoon/tia:tia_Gegevens/tia:IMKAD_KadNatuurlijkPersoon/tia:voornamen) != ''">
						<xsl:value-of select="tia:IMKAD_Persoon/tia:tia_Gegevens/tia:IMKAD_KadNatuurlijkPersoon/tia:voornamen"/>
					</xsl:if>
					<xsl:if test="normalize-space(tia:IMKAD_Persoon/tia:tia_Gegevens/tia:IMKAD_KadNatuurlijkPersoon/tia:voorvoegselsgeslachtsnaam) != ''">
						<xsl:text> </xsl:text>
						<xsl:value-of select="tia:IMKAD_Persoon/tia:tia_Gegevens/tia:IMKAD_KadNatuurlijkPersoon/tia:voorvoegselsgeslachtsnaam"/>
					</xsl:if>
					<xsl:if test="normalize-space(tia:IMKAD_Persoon/tia:tia_Gegevens/tia:IMKAD_KadNatuurlijkPersoon/tia:geslachtsnaam) != ''">
						<xsl:text> </xsl:text>
						<xsl:value-of select="tia:IMKAD_Persoon/tia:tia_Gegevens/tia:IMKAD_KadNatuurlijkPersoon/tia:geslachtsnaam"/>
					</xsl:if>
				</xsl:when>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="position() + 1 = last()">
					<xsl:text> en </xsl:text>
				</xsl:when>
				<xsl:when test="position() + 1 &lt; last()">
					<xsl:text>, </xsl:text>
				</xsl:when>
				<xsl:when test="position() = last()">
					<xsl:text> voornoemd, die bij deze verklaren te aanvaarden namens</xsl:text>
					<xsl:value-of select="$endMark"/>
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-allocation-header
	*********************************************************
	Public: no

	Identity transform: no

	Description: Common header for distribution deed's transfer of title.

	Input: tia:StukdeelVerdelingVennootschap, tia:StukdeelVerdelingHuwelijk, tia:StukdeelVerdelingPartnerschap or tia:StukdeelVerdelingGemeenschap

	Params: none

	Output: XHTML structure

	Calls:
	none

	Called by:
	(mode) do-distribution
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:StukdeelVerdelingVennootschap | tia:StukdeelVerdelingHuwelijk | tia:StukdeelVerdelingPartnerschap | tia:StukdeelVerdelingGemeenschap | tia:StukdeelVerdelingUittredingVennoten" mode="do-allocation-header">
		<xsl:param name="dubbelePunt"/>
		<xsl:text>D. LEVERING</xsl:text>
		<br/>
		<xsl:text>Ter uitvoering van de hiervoor vermelde overeenkomst van verdeling wordt bij deze geleverd aan</xsl:text>
		<xsl:value-of select="$dubbelePunt"/>
		<xsl:text> </xsl:text>
	</xsl:template>
	<!--
	****************************************************************
	Mode: do-allocation-to-different-persons-within-one-party-common
	****************************************************************
	Public: no

	Identity transform: no

	Description: Common text block for distribution deed's transfer of title allocated within one party, to different persons.

	Input: tia:IMKAD_Persoon

	Params: authorizedRepresentative - authorized representative of acquirer party
			rights - list of all rights allocated to party/parties
			onverdeeld - method of allocation
			allocatedToAll - indicator if allocation is made to all rights
			isLast - processed person-rights group is the last one
			numberOfRights - number of rights in processed person-rights group

	Output: XHTML structure

	Calls:
	(mode) do-gender-salutation
	(name) numberOfRemainingRightsToProcess

	Called by:
	(mode) do-allocation-to-different-persons-within-one-party
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon" mode="do-allocation-to-different-persons-within-one-party-common">
		<xsl:param name="authorizedRepresentative"/>
		<xsl:param name="rights" select="self::node()[false()]"/>
		<xsl:param name="onverdeeld" select="''"/>
		<xsl:param name="allocatedToAll" select="'false'"/>
		<xsl:param name="isLast" select="'false'"/>
		<xsl:param name="numberOfRights" select="0"/>
		<xsl:variable name="personId" select="concat('#', @id)"/>
		<xsl:variable name="party" select="$authorizedRepresentative/.."/>
		<xsl:variable name="authorizedRepresentativeHoedanigheid" select="$party/tia:Hoedanigheid[concat('#', @id) = $authorizedRepresentative/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href']]"/>
		<xsl:variable name="eenOfMeer">
			<xsl:call-template name="benamingRegistergoed">
				<xsl:with-param name="aantalRegistergoederen" select="$numberOfRights"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="(tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_KadNatuurlijkPersoon or tia:tia_Gegevens/tia:IMKAD_NietIngezetene)">
				<xsl:variable name="genderSalutation">
					<xsl:apply-templates select="tia:tia_Gegevens/tia:GBA_Ingezetene | tia:tia_Gegevens/tia:IMKAD_NietIngezetene" mode="do-gender-salutation"/>
				</xsl:variable>
				<xsl:value-of select="$genderSalutation"/>
				<xsl:text> </xsl:text>
				<xsl:choose>
					<xsl:when test="tia:tia_Gegevens/tia:IMKAD_KadNatuurlijkPersoon and tia:tia_Gegevens/tia:GBA_Ingezetene">
						<xsl:value-of select="tia:tia_Gegevens/tia:IMKAD_KadNatuurlijkPersoon/tia:voornamen"/>
						<xsl:if test="tia:tia_Gegevens/tia:IMKAD_KadNatuurlijkPersoon/tia:voorvoegselsgeslachtsnaam
									and normalize-space(tia:tia_Gegevens/tia:IMKAD_KadNatuurlijkPersoon/tia:voorvoegselsgeslachtsnaam) != ''">
							<xsl:text> </xsl:text>
							<xsl:value-of select="tia:tia_Gegevens/tia:IMKAD_KadNatuurlijkPersoon/tia:voorvoegselsgeslachtsnaam"/>
						</xsl:if>
						<xsl:text> </xsl:text>
						<xsl:value-of select="tia:tia_Gegevens/tia:IMKAD_KadNatuurlijkPersoon/tia:geslachtsnaam"/>
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
				<xsl:text> voornoemd</xsl:text>
				<xsl:if test="not($authorizedRepresentative) or
						($authorizedRepresentative and $authorizedRepresentativeHoedanigheid/tia:wordtVertegenwoordigdRef and not($authorizedRepresentativeHoedanigheid[tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = $personId]))">
					<xsl:text>, die bij deze verklaart te aanvaarden</xsl:text>
				</xsl:if>
				<xsl:choose>
					<xsl:when test="$rights[tia:Toedeling[tia:verkrijgerRechtRef[@*[translate(local-name(), $upper, $lower) = 'href'] = $personId] and tia:aandeel]]">
						<xsl:variable name="share" select="$rights/tia:Toedeling[tia:verkrijgerRechtRef[@*[translate(local-name(), $upper, $lower) = 'href'] = $personId]]/tia:aandeel"/>
						<xsl:text> het </xsl:text>
						<xsl:value-of select="kef:convertNumberToText(string($share/tia:teller))"/>
						<xsl:text>/</xsl:text>
						<xsl:value-of select="kef:convertOrdinalToText(string($share/tia:noemer))"/>
						<xsl:text> (</xsl:text>
						<xsl:value-of select="$share/tia:teller"/>
						<xsl:text>/</xsl:text>
						<xsl:value-of select="$share/tia:noemer"/>
						<xsl:text>) </xsl:text>
						<xsl:if test="normalize-space($onverdeeld) != ''">
							<xsl:value-of select="$onverdeeld"/>
							<xsl:text> </xsl:text>
						</xsl:if>
						<xsl:text> aandeel in</xsl:text>
					</xsl:when>
					<xsl:when test="not($rights/tia:Toedeling)">
						<xsl:text> het </xsl:text>
						<xsl:value-of select="kef:convertNumberToText(string(tia:tia_AandeelInRechten/tia:teller))"/>
						<xsl:text>/</xsl:text>
						<xsl:value-of select="kef:convertOrdinalToText(string(tia:tia_AandeelInRechten/tia:noemer))"/>
						<xsl:text> (</xsl:text>
						<xsl:value-of select="tia:tia_AandeelInRechten/tia:teller"/>
						<xsl:text>/</xsl:text>
						<xsl:value-of select="tia:tia_AandeelInRechten/tia:noemer"/>
						<xsl:text>) </xsl:text>
						<xsl:if test="normalize-space($onverdeeld) != ''">
							<xsl:value-of select="$onverdeeld"/>
							<xsl:text> </xsl:text>
						</xsl:if>
						<xsl:text> aandeel in</xsl:text>
					</xsl:when>
				</xsl:choose>
				<xsl:text>: </xsl:text>
				<xsl:choose>
					<xsl:when test="translate($allocatedToAll, $upper, $lower) = 'true'">
						<xsl:choose>
							<xsl:when test="$eenOfMeer = 'registergoed'">
								<xsl:text>het registergoed</xsl:text>
							</xsl:when>
							<xsl:when test="$eenOfMeer = 'registergoederen'">
								<xsl:text>de registergoederen</xsl:text>
							</xsl:when>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="count($rights) = 1">
								<xsl:text>het registergoed </xsl:text>
							</xsl:when>
							<xsl:when test="count($rights) > 1">
								<xsl:text>de registergoederen </xsl:text>
							</xsl:when>
						</xsl:choose>
						<xsl:for-each select="$rights">
							<xsl:variable name="position" select="position()"/>
							<xsl:variable name="isRightAlreadyProcessed">
								<xsl:call-template name="isRightAlreadyProcessed">
									<xsl:with-param name="right" select="$rights[$position]"/>
									<xsl:with-param name="rights" select="$rights"/>
									<xsl:with-param name="indexOfProcessedRight" select="$position"/>
								</xsl:call-template>
							</xsl:variable>
							<!-- check if right has already been processed -->
							<xsl:if test="$isRightAlreadyProcessed = 'false'">
								<xsl:variable name="numberOfRemainingRightsToProcess">
									<xsl:call-template name="numberOfRemainingRightsToProcess">
										<xsl:with-param name="rights" select="$rights"/>
										<xsl:with-param name="index" select="position() + 1"/>
									</xsl:call-template>
								</xsl:variable>
								<xsl:value-of select="tia:orderNumber"/>
								<xsl:choose>
									<xsl:when test="$numberOfRemainingRightsToProcess = 1">
										<xsl:text> en </xsl:text>
									</xsl:when>
									<xsl:when test="$numberOfRemainingRightsToProcess != 0">
										<xsl:text>, </xsl:text>
									</xsl:when>
								</xsl:choose>
							</xsl:if>
						</xsl:for-each>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:choose>
					<xsl:when test="translate($isLast, $upper, $lower) = 'true'">
						<xsl:text>.</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>; en aan </xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="tia:tia_Gegevens/tia:NHR_Rechtspersoon">
				<xsl:value-of select="tia:tia_Gegevens/tia:NHR_Rechtspersoon/tia:statutaireNaam"/>
				<xsl:text> voornoemd</xsl:text>
				<xsl:if test="not($authorizedRepresentative) or
						($authorizedRepresentative and $authorizedRepresentativeHoedanigheid/tia:wordtVertegenwoordigdRef and not($authorizedRepresentativeHoedanigheid[tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = $personId]))">
					<xsl:text>, die bij deze verklaart te aanvaarden</xsl:text>
				</xsl:if>
				<xsl:choose>
					<xsl:when test="$rights[tia:Toedeling[tia:verkrijgerRechtRef[@*[translate(local-name(), $upper, $lower) = 'href'] = $personId] and tia:aandeel]]">
						<xsl:variable name="share" select="$rights/tia:Toedeling[tia:verkrijgerRechtRef[@*[translate(local-name(), $upper, $lower) = 'href'] = $personId]]/tia:aandeel"/>
						<xsl:text> het </xsl:text>
						<xsl:value-of select="kef:convertNumberToText(string($share/tia:teller))"/>
						<xsl:text>/</xsl:text>
						<xsl:value-of select="kef:convertOrdinalToText(string($share/tia:noemer))"/>
						<xsl:text> (</xsl:text>
						<xsl:value-of select="$share/tia:teller"/>
						<xsl:text>/</xsl:text>
						<xsl:value-of select="$share/tia:noemer"/>
						<xsl:text>) </xsl:text>
						<xsl:if test="normalize-space($onverdeeld) != ''">
							<xsl:value-of select="$onverdeeld"/>
							<xsl:text> </xsl:text>
						</xsl:if>
						<xsl:text> aandeel in</xsl:text>
					</xsl:when>
					<xsl:when test="not($rights/tia:Toedeling)">
						<xsl:text> het </xsl:text>
						<xsl:value-of select="kef:convertNumberToText(string(tia:tia_AandeelInRechten/tia:teller))"/>
						<xsl:text>/</xsl:text>
						<xsl:value-of select="kef:convertOrdinalToText(string(tia:tia_AandeelInRechten/tia:noemer))"/>
						<xsl:text> (</xsl:text>
						<xsl:value-of select="tia:tia_AandeelInRechten/tia:teller"/>
						<xsl:text>/</xsl:text>
						<xsl:value-of select="tia:tia_AandeelInRechten/tia:noemer"/>
						<xsl:text>) </xsl:text>
						<xsl:if test="normalize-space($onverdeeld) != ''">
							<xsl:value-of select="$onverdeeld"/>
							<xsl:text> </xsl:text>
						</xsl:if>
						<xsl:text> aandeel in</xsl:text>
					</xsl:when>
				</xsl:choose>
				<xsl:text>: </xsl:text>
				<xsl:choose>
					<xsl:when test="translate($allocatedToAll, $upper, $lower) = 'true'">
						<xsl:choose>
							<xsl:when test="$eenOfMeer = 'registergoed'">
								<xsl:text>het registergoed </xsl:text>
							</xsl:when>
							<xsl:when test="$eenOfMeer = 'registergoederen'">
								<xsl:text>de registergoederen </xsl:text>
							</xsl:when>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="count($rights) = 1">
								<xsl:text>het registergoed </xsl:text>
							</xsl:when>
							<xsl:when test="count($rights) > 1">
								<xsl:text>de registergoederen </xsl:text>
							</xsl:when>
						</xsl:choose>
						<xsl:for-each select="$rights">
							<xsl:variable name="position" select="position()"/>
							<xsl:variable name="isRightAlreadyProcessed">
								<xsl:call-template name="isRightAlreadyProcessed">
									<xsl:with-param name="right" select="$rights[$position]"/>
									<xsl:with-param name="rights" select="$rights"/>
									<xsl:with-param name="indexOfProcessedRight" select="$position"/>
								</xsl:call-template>
							</xsl:variable>
							<!-- check if right has already been processed -->
							<xsl:if test="$isRightAlreadyProcessed = 'false'">
								<xsl:variable name="numberOfRemainingRightsToProcess">
									<xsl:call-template name="numberOfRemainingRightsToProcess">
										<xsl:with-param name="rights" select="$rights"/>
										<xsl:with-param name="index" select="position() + 1"/>
									</xsl:call-template>
								</xsl:variable>
								<xsl:value-of select="tia:orderNumber"/>
								<xsl:choose>
									<xsl:when test="$numberOfRemainingRightsToProcess = 1">
										<xsl:text> en </xsl:text>
									</xsl:when>
									<xsl:when test="$numberOfRemainingRightsToProcess != 0">
										<xsl:text>, </xsl:text>
									</xsl:when>
								</xsl:choose>
							</xsl:if>
						</xsl:for-each>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:choose>
					<xsl:when test="translate($isLast, $upper, $lower) = 'true'">
						<xsl:text>.</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>; en aan</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!--
	*********************************************************
	Name: numberOfRemainingRightsToProcess
	*********************************************************
	Public: no

	Discription: Gets number of rights that remain to be processed.

	Params: rights - list of all rights
			index - index of right which is currently processed, in order to check if it has been already processed. Initially index should be by 1 bigger than right that is currently processed by caller
			counter - number of remaining rights to be processed (rights positioned after right currently processed by caller, which haven't been already processed)

	Calls:
	(name) isRightAlreadyProcessed

	Called by:
	(mode) do-allocation-to-different-persons-within-one-party-common
	-->
	<!--
	**** named template ********************************************************************************
	-->
	<xsl:template name="numberOfRemainingRightsToProcess">
		<xsl:param name="rights" select="self::node()[false()]"/>
		<xsl:param name="index" select="1"/>
		<xsl:param name="counter" select="0"/>
		<xsl:choose>
			<xsl:when test="not($rights[$index])">
				<xsl:value-of select="$counter"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="isRightAlreadyProcessed">
					<xsl:call-template name="isRightAlreadyProcessed">
						<xsl:with-param name="right" select="$rights[$index]"/>
						<xsl:with-param name="rights" select="$rights"/>
						<xsl:with-param name="indexOfProcessedRight" select="$index"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:choose>
					<xsl:when test="$isRightAlreadyProcessed = 'false'">
						<xsl:call-template name="numberOfRemainingRightsToProcess">
							<xsl:with-param name="rights" select="$rights"/>
							<xsl:with-param name="index" select="$index + 1"/>
							<xsl:with-param name="counter" select="$counter + 1"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="numberOfRemainingRightsToProcess">
							<xsl:with-param name="rights" select="$rights"/>
							<xsl:with-param name="index" select="$index + 1"/>
							<xsl:with-param name="counter" select="$counter"/>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--
	*********************************************************
	Name: isRightAlreadyProcessed
	*********************************************************
	Public: no

	Discription: Checks weather currently processed right already has been processed.

	Params: right - currently processed right
			rights - list of all rights
			index - index of right which is compared to currently processed
			indexOfRight - index of currently processed right

	Calls:
	none

	Called by:
	(name) numberOfRemainingRightsToProcess
	-->
	<!--
	**** named template ********************************************************************************
	-->
	<xsl:template name="isRightAlreadyProcessed">
		<xsl:param name="right" select="''"/>
		<xsl:param name="rights" select="self::node()[false()]"/>
		<xsl:param name="index" select="1"/>
		<xsl:param name="indexOfProcessedRight" select="1"/>
		<xsl:choose>
			<xsl:when test="$index = $indexOfProcessedRight">
				<xsl:text>false</xsl:text>
			</xsl:when>
			<xsl:when test="$rights[$index]/tia:orderNumber = $right/tia:orderNumber">
				<xsl:text>true</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="isRightAlreadyProcessed">
					<xsl:with-param name="right" select="$right"/>
					<xsl:with-param name="rights" select="$rights"/>
					<xsl:with-param name="index" select="$index + 1"/>
					<xsl:with-param name="indexOfProcessedRight" select="$indexOfProcessedRight"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--
	*********************************************************
	Name: isAlocationToSpecificPartiesTheSame
	*********************************************************
	Public: no

	Discription: Checks weather allocation made to specific parties is the same in all rights.

	Params: stukdeelNode - root stukdeel node
			index - index of processed verkrijger
			indexOfRight - index of processed property/right

	Calls:
	none

	Called by:
	(mode) do-distribution
	-->
	<!--
	**** named template ********************************************************************************
	-->
	<xsl:template name="isAlocationToSpecificPartiesTheSame">
		<xsl:param name="stukdeelNode"/>
		<xsl:param name="index" select="1"/>
		<xsl:param name="indexOfRight" select="1"/>
		<xsl:choose>
			<xsl:when test="$stukdeelNode/tia:IMKAD_ZakelijkRecht[$indexOfRight]">
				<xsl:choose>
					<xsl:when test="$stukdeelNode/tia:IMKAD_ZakelijkRecht[$indexOfRight]/tia:verkrijgerRechtRef[$index]">
						<xsl:choose>
							<xsl:when test="not($stukdeelNode/tia:IMKAD_ZakelijkRecht[$indexOfRight]/tia:verkrijgerRechtRef[$index][@xlink:href = $stukdeelNode/tia:IMKAD_ZakelijkRecht[1]/tia:verkrijgerRechtRef/@xlink:href])">
								<xsl:value-of select="'false'"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:call-template name="isAlocationToSpecificPartiesTheSame">
									<xsl:with-param name="stukdeelNode" select="$stukdeelNode"/>
									<xsl:with-param name="index" select="$index + 1"/>
									<xsl:with-param name="indexOfRight" select="$indexOfRight"/>
								</xsl:call-template>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="isAlocationToSpecificPartiesTheSame">
							<xsl:with-param name="stukdeelNode" select="$stukdeelNode"/>
							<xsl:with-param name="index" select="1"/>
							<xsl:with-param name="indexOfRight" select="$indexOfRight + 1"/>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="count($stukdeelNode/tia:IMKAD_ZakelijkRecht) > 0">
						<xsl:value-of select="'true'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'false'"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--
	*********************************************************
	Name: groupPartiesAndRights
	*********************************************************
	Public: no

	Discription: Creates groups that contains parties (nodes tia:Partij) and rights (nodes tia:IMKAD_ZakelijkRecht).
				Applicable when allocation of rights is made to one or more parties, with equal shares for each of the persons.

	Params: parties - node set containing tia:Partij nodes
			rights - node set containing tia:IMKAD_ZakelijkRecht nodes

	Output: Tree fragment:
			<tia:groups>
				<tia:group>
					<tia:Partij />
					...
					<tia:IMKAD_ZakelijkRecht />
					...
				</tia:group>
				...
			</tia:groups>

	Calls:
	none

	Called by:
	(mode) do-distribution
	-->
	<!--
	**** named template ********************************************************************************
	-->
	<xsl:template name="groupPartiesAndRights">
		<xsl:param name="parties" select="self::node()[false()]"/>
		<xsl:param name="rights" select="self::node()[false()]"/>
		<xsl:variable name="_numberedRights">
			<xsl:for-each select="$rights">
				<tia:IMKAD_ZakelijkRecht>
					<tia:orderNumber>
						<xsl:value-of select="count(preceding-sibling::tia:IMKAD_ZakelijkRecht) + 1"/>
					</tia:orderNumber>
					<xsl:copy-of select="*"/>
				</tia:IMKAD_ZakelijkRecht>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="numberedRights" select="exslt:node-set($_numberedRights)"/>
		<xsl:variable name="_groupedRights">
			<tia:groups>
				<xsl:for-each select="$parties/tia:root/tia:Partij">
					<xsl:variable name="groupedRights" select="$numberedRights/tia:IMKAD_ZakelijkRecht[tia:verkrijgerRechtRef[@xlink:href = concat('#', current()/@id)]]"/>
					<tia:group>
						<xsl:for-each select="$groupedRights">
							<xsl:copy-of select="."/>
						</xsl:for-each>
					</tia:group>
				</xsl:for-each>
			</tia:groups>
		</xsl:variable>
		<xsl:variable name="groupedRights" select="exslt:node-set($_groupedRights)"/>
		<xsl:variable name="_preProcessedPartiesRightsGroups">
			<tia:groups>
				<xsl:for-each select="$groupedRights/tia:groups/tia:group">
					<xsl:variable name="root" select="."/>
					<tia:group>
						<xsl:for-each select="$parties/tia:root/tia:Partij">
							<xsl:if test="count($root/tia:IMKAD_ZakelijkRecht[tia:verkrijgerRechtRef[@xlink:href = concat('#', current()/@id)]]) = count($root/tia:IMKAD_ZakelijkRecht)">
								<xsl:copy-of select="."/>
							</xsl:if>
						</xsl:for-each>
						<xsl:for-each select="tia:IMKAD_ZakelijkRecht">
							<xsl:copy-of select="."/>
						</xsl:for-each>
					</tia:group>
				</xsl:for-each>
			</tia:groups>
		</xsl:variable>
		<xsl:variable name="preProcessedPartiesRightsGroups" select="exslt:node-set($_preProcessedPartiesRightsGroups)"/>
		<tia:groups>
			<xsl:for-each select="$preProcessedPartiesRightsGroups/tia:groups/tia:group">
				<xsl:variable name="currentGroup" select="."/>
				<xsl:if test="not(preceding-sibling::tia:group[count(current()/tia:Partij) = count(tia:Partij) and count(current()/tia:IMKAD_ZakelijkRecht) = count(tia:IMKAD_ZakelijkRecht)
						and current()/tia:Partij/@id = tia:Partij/@id and current()/tia:IMKAD_ZakelijkRecht/tia:orderNumber = tia:IMKAD_ZakelijkRecht/tia:orderNumber])">
					<tia:group>
						<xsl:copy-of select="tia:Partij"/>
						<xsl:for-each select="tia:IMKAD_ZakelijkRecht">
							<xsl:if test="not($currentGroup/preceding-sibling::tia:group[current()/tia:orderNumber = tia:IMKAD_ZakelijkRecht/tia:orderNumber and count(tia:Partij) > count($currentGroup/tia:Partij)]
									or $currentGroup/following-sibling::tia:group[current()/tia:orderNumber = tia:IMKAD_ZakelijkRecht/tia:orderNumber and count(tia:Partij) > count($currentGroup/tia:Partij)])">
								<xsl:copy-of select="."/>
							</xsl:if>
						</xsl:for-each>
					</tia:group>
				</xsl:if>
			</xsl:for-each>
		</tia:groups>
	</xsl:template>
	<!--
	*********************************************************
	Name: groupPersonsAndRights
	*********************************************************
	Public: no

	Discription: Creates groups that contains persons (nodes tia:IMKAD_Persoon) and rights (nodes tia:IMKAD_ZakelijkRecht).
				 Applicable when allocation of rights is made within one party, to different persons.

	Params: persons - node set containing tia:IMKAD_Persoon nodes
			rights - node set containing tia:IMKAD_ZakelijkRecht nodes
			acquirerParty - acquirer party
			variant - number of variant

	Output: Tree fragment:
			<tia:groups>
				<tia:group>
					<tia:IMKAD_Persoon />
					<tia:IMKAD_ZakelijkRecht />
					...
				</tia:group>
				<tia:group>
					<tia:IMKAD_Persoon />
					<tia:IMKAD_ZakelijkRecht />
					...
				</tia:group>
				...
			</tia:groups>

	Calls:
	none

	Called by:
	(mode) do-distribution
	-->
	<!--
	**** named template ********************************************************************************
	-->
	<xsl:template name="groupPersonsAndRights">
		<xsl:param name="persons" select="self::node()[false()]"/>
		<xsl:param name="rights" select="self::node()[false()]"/>
		<xsl:param name="acquirerParty" select="self::node()[false()]"/>
		<xsl:param name="variant" select="'0'"/>
		<!-- add order number to each right -->
		<xsl:variable name="_numberedRights">
			<xsl:for-each select="$rights">
				<tia:IMKAD_ZakelijkRecht>
					<tia:orderNumber>
						<xsl:value-of select="count(preceding-sibling::tia:IMKAD_ZakelijkRecht) + 1"/>
					</tia:orderNumber>
					<xsl:copy-of select="*"/>
				</tia:IMKAD_ZakelijkRecht>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="numberedRights" select="exslt:node-set($_numberedRights)"/>
		<xsl:variable name="_rights">
			<tia:root>
				<xsl:copy-of select="$numberedRights/tia:IMKAD_ZakelijkRecht"/>
			</tia:root>
		</xsl:variable>
		<xsl:variable name="processedRights" select="exslt:node-set($_rights)"/>
		<!-- create person - right(s) groups -->
		<tia:groups>
			<xsl:for-each select="$persons">
				<xsl:variable name="currentPerson" select="."/>
				<xsl:choose>
					<xsl:when test="$variant = '2'">
						<tia:group>
							<xsl:copy-of select="$currentPerson"/>
						</tia:group>
					</xsl:when>
					<xsl:when test="$variant = '3'">
						<xsl:variable name="id" select="concat('#', current()/@id)"/>
						<xsl:for-each select="$processedRights/tia:root/tia:IMKAD_ZakelijkRecht[tia:Toedeling[tia:verkrijgerRechtRef[@xlink:href = $id]]]">
							<tia:group>
								<xsl:copy-of select="$currentPerson"/>
								<xsl:copy-of select="$processedRights/tia:root/tia:IMKAD_ZakelijkRecht[tia:Toedeling[tia:verkrijgerRechtRef[@xlink:href = $id]
										and ((tia:aandeel and tia:aandeel/tia:teller = current()/tia:Toedeling[tia:verkrijgerRechtRef[@xlink:href = $id]]/tia:aandeel/tia:teller
										and tia:aandeel/tia:noemer = current()/tia:Toedeling[tia:verkrijgerRechtRef[@xlink:href = $id]]/tia:aandeel/tia:noemer)
											or (not(tia:aandeel) and not(current()/tia:Toedeling[tia:verkrijgerRechtRef[@xlink:href = $id]]/tia:aandeel)))]
										and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld'] and current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst
										and tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst = current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst)
											or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']) and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst)))]"/>
							</tia:group>
						</xsl:for-each>
					</xsl:when>
					<xsl:when test="$variant = '5'">
						<xsl:for-each select="$processedRights/tia:root/tia:IMKAD_ZakelijkRecht">
							<tia:group>
								<xsl:copy-of select="$currentPerson"/>
								<xsl:copy-of select="$processedRights/tia:root/tia:IMKAD_ZakelijkRecht"/>
							</tia:group>
						</xsl:for-each>
					</xsl:when>
					<xsl:when test="$variant = '6'">
						<xsl:variable name="id" select="concat('#', current()/@id)"/>
						<xsl:for-each select="$processedRights/tia:root/tia:IMKAD_ZakelijkRecht[tia:Toedeling[tia:verkrijgerRechtRef[@xlink:href = $id]]]">
							<tia:group>
								<xsl:copy-of select="$currentPerson"/>
								<xsl:copy-of select="$processedRights/tia:root/tia:IMKAD_ZakelijkRecht[tia:Toedeling[tia:verkrijgerRechtRef[@xlink:href = $id]
										and ((tia:aandeel and tia:aandeel/tia:teller = current()/tia:Toedeling[tia:verkrijgerRechtRef[@xlink:href = $id]]/tia:aandeel/tia:teller
										and tia:aandeel/tia:noemer = current()/tia:Toedeling[tia:verkrijgerRechtRef[@xlink:href = $id]]/tia:aandeel/tia:noemer)
											or (not(tia:aandeel) and not(current()/tia:Toedeling[tia:verkrijgerRechtRef[@xlink:href = $id]]/tia:aandeel)))]
										and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld'] and current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst
										and tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst = current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst)
											or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']) and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst)))]"/>
							</tia:group>
						</xsl:for-each>
					</xsl:when>
					<xsl:when test="$variant = '8'">
						<xsl:variable name="id" select="concat('#', $acquirerParty/@id)"/>
						<tia:group>
							<xsl:copy-of select="$currentPerson"/>
							<xsl:copy-of select="$processedRights/tia:root/tia:IMKAD_ZakelijkRecht[tia:verkrijgerRechtRef/@xlink:href = $id]"/>
						</tia:group>
					</xsl:when>
					<xsl:when test="$variant = '9'">
						<xsl:variable name="id" select="concat('#', current()/@id)"/>
						<xsl:for-each select="$processedRights/tia:root/tia:IMKAD_ZakelijkRecht[tia:Toedeling[tia:verkrijgerRechtRef[@xlink:href = $id]]]">
							<tia:group>
								<xsl:copy-of select="$currentPerson"/>
								<xsl:copy-of select="$processedRights/tia:root/tia:IMKAD_ZakelijkRecht[tia:Toedeling[tia:verkrijgerRechtRef[@xlink:href = $id]
											and ((tia:aandeel and tia:aandeel/tia:teller = current()/tia:Toedeling[tia:verkrijgerRechtRef[@xlink:href = $id]]/tia:aandeel/tia:teller
											and tia:aandeel/tia:noemer = current()/tia:Toedeling[tia:verkrijgerRechtRef[@xlink:href = $id]]/tia:aandeel/tia:noemer)
												or (not(tia:aandeel) and not(current()/tia:Toedeling[tia:verkrijgerRechtRef[@xlink:href = $id]]/tia:aandeel)))]
											and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld'] and current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst
											and tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst = current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst)
												or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']) and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst)))]"/>
							</tia:group>
						</xsl:for-each>
					</xsl:when>
					<xsl:when test="$variant = '10'">
						<xsl:variable name="personId" select="concat('#', current()/@id)"/>
						<xsl:variable name="acquirerId" select="concat('#', $acquirerParty/@id)"/>
						<xsl:for-each select="$processedRights/tia:root/tia:IMKAD_ZakelijkRecht[tia:Toedeling[tia:verkrijgerRechtRef[@xlink:href = $personId]]]">
							<tia:group>
								<xsl:copy-of select="$currentPerson"/>
								<xsl:copy-of select="$processedRights/tia:root/tia:IMKAD_ZakelijkRecht[
											tia:Toedeling[tia:verkrijgerRechtRef[@xlink:href = $personId]
												and ((tia:aandeel and tia:aandeel/tia:teller = current()/tia:Toedeling[tia:verkrijgerRechtRef[@xlink:href = $personId]]/tia:aandeel/tia:teller
												and tia:aandeel/tia:noemer = current()/tia:Toedeling[tia:verkrijgerRechtRef[@xlink:href = $personId]]/tia:aandeel/tia:noemer)
													or (not(tia:aandeel) and not(current()/tia:Toedeling[tia:verkrijgerRechtRef[@xlink:href = $personId]]/tia:aandeel)))]
												and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld'] and current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst
												and tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst = current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst)
													or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']) and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst)))]"/>
							</tia:group>
						</xsl:for-each>
						<xsl:if test="$currentPerson/tia:tia_AandeelInRechten">
							<tia:group>
								<xsl:copy-of select="$currentPerson"/>
								<xsl:copy-of select="$processedRights/tia:root/tia:IMKAD_ZakelijkRecht[tia:verkrijgerRechtRef[@xlink:href = $acquirerId] and not(tia:Toedeling)]"/>
							</tia:group>
						</xsl:if>
					</xsl:when>
					<xsl:when test="$variant = '11'">
						<xsl:variable name="id" select="concat('#', $acquirerParty/@id)"/>
						<xsl:for-each select="$processedRights/tia:root/tia:IMKAD_ZakelijkRecht[tia:verkrijgerRechtRef[@xlink:href = $id]]">
							<tia:group>
								<xsl:copy-of select="$currentPerson"/>
								<xsl:copy-of select="$processedRights/tia:root/tia:IMKAD_ZakelijkRecht[tia:verkrijgerRechtRef[@xlink:href = $id] and
											((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld'] and current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst
											and tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst = current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst)
												or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']) and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst)))]"/>
							</tia:group>
						</xsl:for-each>
					</xsl:when>
					<xsl:when test="$variant = '12'">
						<xsl:variable name="id" select="concat('#', current()/@id)"/>
						<xsl:if test="$processedRights/tia:root/tia:IMKAD_ZakelijkRecht/tia:Toedeling[tia:verkrijgerRechtRef[@xlink:href = $id]]">
							<xsl:for-each select="$processedRights/tia:root/tia:IMKAD_ZakelijkRecht[tia:Toedeling[tia:verkrijgerRechtRef[@xlink:href = $id]]]">
								<tia:group>
									<xsl:copy-of select="$currentPerson"/>
									<xsl:copy-of select="$processedRights/tia:root/tia:IMKAD_ZakelijkRecht[tia:Toedeling[tia:verkrijgerRechtRef[@xlink:href = $id]
												and ((tia:aandeel and tia:aandeel/tia:teller = current()/tia:Toedeling[tia:verkrijgerRechtRef[@xlink:href = $id]]/tia:aandeel/tia:teller
												and tia:aandeel/tia:noemer = current()/tia:Toedeling[tia:verkrijgerRechtRef[@xlink:href = $id]]/tia:aandeel/tia:noemer)
													or (not(tia:aandeel) and not(current()/tia:Toedeling[tia:verkrijgerRechtRef[@xlink:href = $id]]/tia:aandeel)))]
												and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld'] and current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst
												and tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst = current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst)
													or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']) and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst)))]"/>
								</tia:group>
							</xsl:for-each>
						</xsl:if>
					</xsl:when>
					<xsl:when test="$variant = '13'">
						<xsl:variable name="personId" select="concat('#', current()/@id)"/>
						<xsl:variable name="acquirerId" select="concat('#', $acquirerParty/@id)"/>
						<xsl:for-each select="$processedRights/tia:root/tia:IMKAD_ZakelijkRecht[tia:Toedeling[tia:verkrijgerRechtRef[@xlink:href = $personId]] or tia:verkrijgerRechtRef[@xlink:href = $acquirerId]]">
							<tia:group>
								<xsl:copy-of select="$currentPerson"/>
								<xsl:copy-of select="$processedRights/tia:root/tia:IMKAD_ZakelijkRecht[
											(tia:Toedeling[tia:verkrijgerRechtRef[@xlink:href = $personId]
												and ((tia:aandeel and tia:aandeel/tia:teller = current()/tia:Toedeling[tia:verkrijgerRechtRef[@xlink:href = $personId]]/tia:aandeel/tia:teller
												and tia:aandeel/tia:noemer = current()/tia:Toedeling[tia:verkrijgerRechtRef[@xlink:href = $personId]]/tia:aandeel/tia:noemer)
													or (not(tia:aandeel) and not(current()/tia:Toedeling[tia:verkrijgerRechtRef[@xlink:href = $personId]]/tia:aandeel)))]
												and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld'] and current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst
												and tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst = current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst)
													or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']) and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst))))
											or tia:verkrijgerRechtRef[@xlink:href = $acquirerId]]"/>
							</tia:group>
						</xsl:for-each>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</tia:groups>
	</xsl:template>
	<!--
	*********************************************************
	Name: groupParties
	*********************************************************
	Public: no

	Discription: Creates groups that contains parties (nodes tia:Partij).
				 Applicable when allocation of rights is made within one party, to different persons.

	Params: parties - node set containing tia:Partij nodes
			rights - node set containing tia:IMKAD_ZakelijkRecht nodes

	Output: Tree fragment:
			<tia:groups>
				<tia:group>
					<tia:Partij />
				</tia:group>
				<tia:group>
					<tia:Partij />
				</tia:group>
				...
			</tia:groups>

	Calls:
	none

	Called by:
	(mode) do-distribution
	-->
	<!--
	**** named template ********************************************************************************
	-->
	<xsl:template name="groupParties">
		<xsl:param name="parties" select="self::node()[false()]"/>
		<xsl:param name="rights" select="self::node()[false()]"/>
		<tia:groups>
			<xsl:for-each select="$parties/tia:root/tia:Partij">
				<xsl:variable name="groupedRights" select="$rights[tia:verkrijgerRechtRef/@xlink:href = concat('#', current()/@id)]"/>
				<xsl:if test="count($groupedRights) > 0">
					<tia:group>
						<xsl:copy-of select="."/>
					</tia:group>
				</xsl:if>
			</xsl:for-each>
		</tia:groups>
	</xsl:template>
	<!--
	Public: no

	Identity transform: no

	Description: Text block for sorting of party-rights groups. Sorting is made by orderNumber of tia:IMKAD_ZakelijkRecht element, in ascending order.

	Input: tia:IMKAD_Persoon

	Params: none

	Output: Tree fragment:
			<tia:groups>
				<tia:group>
					<tia:Partij />
					...
					<tia:IMKAD_ZakelijkRecht />
					...
				</tia:group>
				...
			</tia:groups>

	Calls:
	(match) group

	Called by:
	(mode) do-distribution
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:groups">
		<tia:groups>
			<xsl:apply-templates select="tia:group">
				<xsl:sort select="tia:IMKAD_ZakelijkRecht/tia:orderNumber[1]"/>
			</xsl:apply-templates>
		</tia:groups>
	</xsl:template>
	<!--
	Public: no

	Identity transform: no

	Description: Text block used in process of sorting of party-rights groups. Sorting is made by orderNumber of tia:IMKAD_ZakelijkRecht element, in ascending order.

	Input: tia:IMKAD_Persoon

	Params: none

	Output: Tree fragment:
			<tia:group>
				<tia:Partij />
				...
				<tia:IMKAD_ZakelijkRecht />
				...
			</tia:group>

	Calls:
	none

	Called by:
	(match) groups
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:group">
		<xsl:copy-of select="."/>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-registered-objects
	*********************************************************
	Public: no

	Identity transform: no

	Description: Distribution deed registered objects.

	Input: tia:StukdeelVerdelingVennootschap, tia:StukdeelVerdelingHuwelijk, tia:StukdeelVerdelingPartnerschap,tia:StukdeelVerdelingGemeenschap of    tia:StukdeelUittredingVennoten

	Params: none

	Output: XHTML structure

	Calls:
	(mode) do-right
	(mode) do-registered-object
	(name) processRights

	Called by:
	(mode) do-properties
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:StukdeelVerdelingVennootschap | tia:StukdeelVerdelingHuwelijk | tia:StukdeelVerdelingPartnerschap | tia:StukdeelVerdelingGemeenschap | tia:StukdeelVerdelingUittredingVennoten" mode="do-registered-objects">
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
				</p>
			</xsl:when>
			<xsl:otherwise>
				<table cellpadding="0" cellspacing="0">
					<tbody>
						<xsl:call-template name="processRights">
							<xsl:with-param name="positionOfProcessedRight" select="1"/>
							<xsl:with-param name="position" select="1"/>
							<xsl:with-param name="registeredObjects" select="."/>
							<xsl:with-param name="punctuationMark" select="';'"/>
							<xsl:with-param name="endMark" select="','"/>
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
	Public: no

	Identity transform: no

	Description: Distribution deed election of domicile.

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
		<a name="distributiondeed.electionOfDomicile" class="location">&#160;</a>
		<xsl:if test="$woonplaatskeuze != ''">
			<p>
				<xsl:text>E. WOONPLAATSKEUZE</xsl:text>
				<br/>
				<xsl:value-of select="$woonplaatskeuze"/>
			</p>
		</xsl:if>
	</xsl:template>
	<xsl:template name="benamingRegistergoed">
		<xsl:param name="aantalRegistergoederen"/>
		<xsl:choose>
			<xsl:when test="$stukdeel/tia:IMKAD_ZakelijkRecht/tia:verkrijgerRechtRef">
				<xsl:choose>
					<xsl:when test="$aantalRegistergoederen > 1">
						<xsl:text>registergoederen</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>registergoed</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$benamingRegistergoed"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
