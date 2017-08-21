<?xml version="1.0" encoding="UTF-8"?>
<!--
*********************************************************
Stylesheet: levering.xsl
Version: 1.29.02
*********************************************************
Description:
Deed of transfer.

Public:
(mode) do-deed

Private:
(mode) do-parties
(mode) do-party-person
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
(mode) do-purchase-distribution-table-part
(mode) do-distribution-person-name
(mode) do-distribution-part
(name) capitalizePartyAlias
(name) groupParcels
(name) groupApartments
-->
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
	xmlns:tia="http://www.kadaster.nl/schemas/KIK/TIA_Algemeen"
	xmlns:kef="nl.kadaster.xslt.XslExtensionFunctions"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:exslt="http://exslt.org/common"
	xmlns:xlink="http://www.w3.org/1999/xlink"
	xmlns:gc="http://docs.oasis-open.org/codelist/ns/genericode/1.0/"
	exclude-result-prefixes="tia kef xsl exslt xlink gc"
	version="1.0">

	<xsl:include href="generiek-1.08.xsl"/>
	<xsl:include href="tekstblok_aanhef-1.05.xsl"/>
	<xsl:include href="tekstblok_equivalentieverklaring-1.09.02.xsl"/>
	<xsl:include href="tekstblok_gevolmachtigde-1.09.xsl"/>
	<xsl:include href="tekstblok_legitimatie-1.01.xsl"/>
	<xsl:include href="tekstblok_personalia_van_natuurlijk_persoon-1.05.xsl"/>
	<xsl:include href="tekstblok_natuurlijk_persoon-1.09.xsl"/>
	<xsl:include href="tekstblok_partij_natuurlijk_persoon-1.10.xsl"/>
	<xsl:include href="tekstblok_partij_niet_natuurlijk_persoon-1.10.xsl"/>
	<xsl:include href="tekstblok_recht-1.05.xsl"/>
	<xsl:include href="tekstblok_rechtspersoon-1.07.xsl"/>
	<xsl:include href="tekstblok_registergoed-1.14.xsl"/>
	<xsl:include href="tekstblok_woonadres-1.04.xsl"/>
	<xsl:include href="tekstblok_deel_nummer-1.02.xsl"/>
	<xsl:include href="tweededeel-1.05.xsl"/>

	<!-- Levering specific global variables -->
	<xsl:variable name="keuzeteksten" select="document('keuzeteksten-levering-1.16.xml')"/>	
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
			<xsl:otherwise><xsl:text/></xsl:otherwise>
		</xsl:choose>
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

	Called by:
	Root template
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:Bericht_TIA_Stuk" mode="do-deed">
		<!-- Text block Statement of equivalence -->
		<xsl:if test="$type-document = 'AFSCHRIFT'">
			<a name="hyp4.statementOfEquivalence" class="location">&#160;</a>
			<xsl:apply-templates select="tia:IMKAD_AangebodenStuk" mode="do-statement-of-equivalence"/>
			<!-- Two empty lines after Statement of equivalence -->
			<p><br/></p>
			<p><br/></p>
		</xsl:if>
		<a name="hyp4.header" class="location">&#160;</a>
		<!-- Document title -->
		<xsl:if test="normalize-space($documentTitle) != ''">
			<p style="text-align:center" title="without_dashes"><xsl:value-of select="$documentTitle"/></p>
			<!-- Empty line after title -->
			<p title="without_dashes"><br/></p>
		</xsl:if>
		<xsl:if test="tia:IMKAD_AangebodenStuk/tia:tia_OmschrijvingKenmerk
				and normalize-space(tia:IMKAD_AangebodenStuk/tia:tia_OmschrijvingKenmerk) != ''">
			<p title="without_dashes">
				<xsl:text>Kenmerk: </xsl:text>
				<xsl:value-of select="tia:IMKAD_AangebodenStuk/tia:tia_OmschrijvingKenmerk"/>
			</p>
			<!-- Empty line after Kenmerk -->
			<p title="without_dashes"><br/></p>
		</xsl:if>
		<!-- Text block Header -->
		<xsl:apply-templates select="tia:IMKAD_AangebodenStuk" mode="do-header"/>
		<!-- Parties -->
		<xsl:apply-templates select="tia:IMKAD_AangebodenStuk/tia:Partij" mode="do-parties"/>
		<p>
			<xsl:text>De verschenen personen verklaarden:</xsl:text>
		</p>
		<!-- Purchase and transfer -->
		<xsl:apply-templates select="tia:IMKAD_AangebodenStuk" mode="do-purchase-and-transfer"/>
		<!-- Purchase registration -->
		<xsl:apply-templates select="tia:IMKAD_AangebodenStuk" mode="do-purchase-registration"/>
		<!-- Purchase price -->
		<xsl:apply-templates select="tia:IMKAD_AangebodenStuk" mode="do-purchase-price"/>
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
		<h3><xsl:text>EINDE KADASTERDEEL</xsl:text></h3>
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

	Called by:
	(mode) do-deed
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:Partij" mode="do-parties">
		<xsl:variable name="numberOfPersons" select="count(tia:IMKAD_Persoon)
			+ count(tia:IMKAD_Persoon/tia:GerelateerdPersoon[translate(tia:tia_IndPartij, $upper, $lower) = 'true'])"/>
		<xsl:variable name="numberOfPersonsWithoutManagers" select="count(tia:IMKAD_Persoon)
			+ count(tia:IMKAD_Persoon[tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene]/tia:GerelateerdPersoon[translate(tia:tia_IndPartij, $upper, $lower) = 'true'])"/>
		<xsl:variable name="numberOfPersonPairs" select="count(tia:IMKAD_Persoon[tia:tia_Gegevens/tia:GBA_Ingezetene 
			or tia:tia_Gegevens/tia:IMKAD_NietIngezetene]/tia:GerelateerdPersoon[tia:rol])"/>
		<xsl:variable name="colspan">
			<xsl:choose>
				<xsl:when test="($numberOfPersonPairs = 1 and $numberOfPersonsWithoutManagers = 2) or ($numberOfPersonsWithoutManagers > 1 and $numberOfPersonPairs = 0)">
					<xsl:text>2</xsl:text>
				</xsl:when>
				<xsl:when test="$numberOfPersonsWithoutManagers > 1 and $numberOfPersonPairs >= 1">
					<xsl:text>3</xsl:text>
				</xsl:when>
			</xsl:choose>
		</xsl:variable>
		
		<table cellspacing="0" cellpadding="0">
			<tbody>
				<xsl:if test="tia:Gevolmachtigde">
					<tr>
						<td class="number" valign="top">
							<a name="{@id}" class="location" style="_position: relative;">&#xFEFF;</a>
							<xsl:value-of select="count(preceding-sibling::tia:Partij) + 1"/>
							<xsl:text>.</xsl:text>
						</td>
						<td>
							<xsl:if test="$colspan != ''">
								<xsl:attribute name="colspan">
									<xsl:value-of select="$colspan"/>
								</xsl:attribute>
							</xsl:if>
							<xsl:apply-templates select="tia:Gevolmachtigde" mode="do-legal-representative"/>
						</td>
					</tr>
				</xsl:if>
				<xsl:choose>
					<!-- If only one person pair is present do not create list -->
					<xsl:when test="tia:IMKAD_Persoon[(tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene)
								and tia:GerelateerdPersoon[tia:rol]]
							and not(count(tia:IMKAD_Persoon) > 1)">
							<xsl:apply-templates select="tia:IMKAD_Persoon" mode="do-party-person"/>
					</xsl:when>
					<xsl:when test="count(tia:IMKAD_Persoon) = 1">
						<xsl:apply-templates select="tia:IMKAD_Persoon" mode="do-party-person"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:for-each select="tia:IMKAD_Persoon">
							<xsl:apply-templates select="." mode="do-party-person">
								<xsl:with-param name="maxColspan" select="$colspan"/>
							</xsl:apply-templates>
						</xsl:for-each>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:if test="tia:IndRegistergoedBewonen = 'true'">
					<tr>	
						<td class="number" valign="top">
							<xsl:text>&#xFEFF;</xsl:text>
						</td>
						<td>
							<xsl:if test="$colspan != ''">
								<xsl:attribute name="colspan">
									<xsl:value-of select="$colspan"/>
								</xsl:attribute>
							</xsl:if>
							<xsl:text>en voornemens het hierna te vermelden registergoed te gaan bewonen,</xsl:text>
						</td>
					</tr>
				</xsl:if>
				<tr>
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<td>
						<xsl:if test="$colspan != ''">
							<xsl:attribute name="colspan">
								<xsl:value-of select="$colspan"/>
							</xsl:attribute>
						</xsl:if>
						<xsl:text>hierna </xsl:text>
						<xsl:if test="$numberOfPersons > 1">
							<xsl:text>zowel tezamen als ieder afzonderlijk </xsl:text>
						</xsl:if>
						<xsl:text>te noemen: "</xsl:text>
						<u><xsl:value-of select="tia:aanduidingPartij"/></u>
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

	Params:  maxColspan - maximal colspan in table

	Output: XHTML structure

	Calls:
	(mode) do-party-natural-person
	(mode) do-party-legal-person

	Called by:
	(mode) do-parties
	-->

	<!--
	**** matching template ********************************************************************************
	****   NATURAL PERSON  ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon[(tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene) and not(tia:GerelateerdPersoon)]" mode="do-party-person">
		<xsl:param name="maxColspan" select="number('0')"/>
		
		<xsl:apply-templates select="." mode="do-party-natural-person">
			<xsl:with-param name="maxColspan" select="$maxColspan"/>
		</xsl:apply-templates>
	</xsl:template>

	<!--
	****   matching template ******************************************************************************
	**** NATURAL PERSON PAIR ******************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon[(tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene) and tia:GerelateerdPersoon]" mode="do-party-person">
		<xsl:param name="maxColspan" select="number('0')"/>
		
		<xsl:apply-templates select="." mode="do-party-natural-person"/>
	</xsl:template>

	<!--
	**** matching template ********************************************************************************
	****    LEGAL PERSON   ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon[tia:tia_Gegevens/tia:NHR_Rechtspersoon]" mode="do-party-person">
		<xsl:param name="maxColspan" select="number('0')"/>
		
		<xsl:apply-templates select="." mode="do-party-legal-person">
			<xsl:with-param name="maxColspan" select="$maxColspan"/>
		</xsl:apply-templates>
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
		<xsl:param name="acquirerParty" select="''"/>
		
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

		<xsl:choose>
			<!-- Variant 1: Equal shares -->
			<xsl:when test="(count($acquirerParty/tia:IMKAD_Persoon/tia:tia_AandeelInRechten)
							+ count($acquirerParty/tia:IMKAD_Persoon/tia:GerelateerdPersoon[translate(tia:tia_IndPartij, $upper, $lower) = 'true']/tia:IMKAD_Persoon/tia:tia_AandeelInRechten)) = 0">
				<xsl:value-of select="$acquirerParty/tia:aanduidingPartij"/>
				<xsl:text>, die bij deze verklaart te aanvaarden</xsl:text>
				<xsl:choose>
					<xsl:when test="$numberOfBuyers = 2">
						<xsl:text>, ieder voor de </xsl:text>
						<xsl:value-of select="$undivided"/>
						<xsl:text>helft</xsl:text>
					</xsl:when>
					<xsl:when test="$numberOfBuyers > 2">
						<xsl:text>, ieder voor het &#x00E9;&#x00E9;n/</xsl:text>
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
			<!-- Variant 2: Unequal shares -->
			<xsl:otherwise>
				<!-- if acquirer party contains authorized representative -->
				<xsl:if test="translate($acquirerPartyHasAuthorizedRepresentative, $upper, $lower) = 'true'">
					<xsl:apply-templates select="$acquirerParty/tia:Gevolmachtigde/tia:gegevens/tia:persoonGegevens" mode="do-gender-salutation"/>
					<xsl:text> </xsl:text>
					<xsl:value-of select="$acquirerParty/tia:Gevolmachtigde/tia:gegevens/tia:persoonGegevens/tia:naam/tia:voornamen"/>
					<xsl:text> </xsl:text>
					<xsl:if test="normalize-space($acquirerParty/tia:Gevolmachtigde/tia:gegevens/tia:persoonGegevens/tia:tia_VoorvoegselsNaam) != ''">
						<xsl:value-of select="$acquirerParty/tia:Gevolmachtigde/tia:gegevens/tia:persoonGegevens/tia:tia_VoorvoegselsNaam"/>
						<xsl:text> </xsl:text>
					</xsl:if>
					<xsl:value-of select="$acquirerParty/tia:Gevolmachtigde/tia:gegevens/tia:persoonGegevens/tia:tia_NaamZonderVoorvoegsels"/>
					<xsl:text> voornoemd, die bij deze verklaart te aanvaarden namens,</xsl:text>
				</xsl:if>
				<xsl:if test="count($acquirerParty/tia:IMKAD_Persoon[tia:tia_AandeelInRechten])
						+ count($acquirerParty/tia:IMKAD_Persoon/tia:GerelateerdPersoon[tia:tia_IndPartij = 'true']/tia:IMKAD_Persoon[tia:tia_AandeelInRechten]) = 1">
					<xsl:if test="translate($acquirerPartyHasAuthorizedRepresentative, $upper, $lower) = 'true'">
						<xsl:text> </xsl:text>
					</xsl:if>
					<xsl:apply-templates select="$acquirerParty/tia:IMKAD_Persoon[tia:tia_AandeelInRechten]
							| $acquirerParty/tia:IMKAD_Persoon/tia:GerelateerdPersoon[translate(tia:tia_IndPartij, $upper, $lower) = 'true']/tia:IMKAD_Persoon[tia:tia_AandeelInRechten]" mode="do-distribution-person-name"/>
					<xsl:apply-templates select="$acquirerParty/tia:IMKAD_Persoon[tia:tia_AandeelInRechten]
							| $acquirerParty/tia:IMKAD_Persoon/tia:GerelateerdPersoon[translate(tia:tia_IndPartij, $upper, $lower) = 'true']/tia:IMKAD_Persoon[tia:tia_AandeelInRechten]" mode="do-distribution-part">
						<xsl:with-param name="acquirerPartyHasAuthorizedRepresentative" select="$acquirerPartyHasAuthorizedRepresentative"/>
					</xsl:apply-templates>
					<xsl:text> in:</xsl:text>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--
	*********************************************************
	Mode: do-purchase-distribution-table-part
	*********************************************************
	Public: no

	Identity transform: no

	Description: Deed of transfer purchase distribution blocks - table part.

	Input: tia:IMKAD_AangebodenStuk

	Params: numberOfBuyers - total number of persons that act as buyer
			acquirerParty - party that acts as acquirer

	Output: XHTML table

	Calls:
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
	<xsl:template match="tia:IMKAD_AangebodenStuk" mode="do-purchase-distribution-table-part">
		<xsl:param name="numberOfBuyers" select="''"/>
		<xsl:param name="acquirerParty" select="''"/>

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

		<xsl:if test="count($acquirerParty/tia:IMKAD_Persoon[tia:tia_AandeelInRechten])
				+ count($acquirerParty/tia:IMKAD_Persoon/tia:GerelateerdPersoon[translate(tia:tia_IndPartij, $upper, $lower) = 'true']/tia:IMKAD_Persoon[tia:tia_AandeelInRechten]) > 1">
			<!-- at least two acquirer persons with unequal shares -->
			<table cellspacing="0" cellpadding="0">
				<tbody>
					<xsl:for-each select="$acquirerParty/tia:IMKAD_Persoon[tia:tia_AandeelInRechten or tia:GerelateerdPersoon[translate(tia:tia_IndPartij, $upper, $lower) = 'true']/tia:IMKAD_Persoon[tia:tia_AandeelInRechten]]">
						<xsl:if test="tia:tia_AandeelInRechten">
							<tr>
								<td class="number" valign="top">
									<xsl:text>-</xsl:text>
								</td>
								<td>
									<xsl:apply-templates select="." mode="do-distribution-person-name"/>
									<xsl:apply-templates select="." mode="do-distribution-part">
										<xsl:with-param name="acquirerPartyHasAuthorizedRepresentative" select="$acquirerPartyHasAuthorizedRepresentative"/>
									</xsl:apply-templates>
									<xsl:choose>
										<xsl:when test="position() = last() and count(tia:GerelateerdPersoon[translate(tia:tia_IndPartij, $upper, $lower) = 'true']) = 0">
											<xsl:text> in:</xsl:text>
										</xsl:when>
										<xsl:otherwise>
											<xsl:text>; en aan</xsl:text>
										</xsl:otherwise>
									</xsl:choose>
								</td>
							</tr>
						</xsl:if>
						<!-- manager on legal person / second person in person pair -->
						<xsl:if test="tia:GerelateerdPersoon[translate(tia:tia_IndPartij, $upper, $lower) = 'true' and tia:IMKAD_Persoon/tia:tia_AandeelInRechten]">
							<tr>
								<td class="number" valign="top">
									<xsl:text>-</xsl:text>
								</td>
								<td>
									<xsl:apply-templates select="tia:GerelateerdPersoon[translate(tia:tia_IndPartij, $upper, $lower) = 'true']/tia:IMKAD_Persoon" mode="do-distribution-person-name"/>
									<xsl:apply-templates select="tia:GerelateerdPersoon[translate(tia:tia_IndPartij, $upper, $lower) = 'true']/tia:IMKAD_Persoon" mode="do-distribution-part">
										<xsl:with-param name="acquirerPartyHasAuthorizedRepresentative" select="$acquirerPartyHasAuthorizedRepresentative"/>
									</xsl:apply-templates>
									<xsl:choose>
										<xsl:when test="position() = last()">
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
	(mode) do-purchase-distribution-table-part
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon[tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene]" mode="do-distribution-person-name">
		<xsl:apply-templates select="tia:tia_Gegevens/tia:GBA_Ingezetene | tia:tia_Gegevens/tia:IMKAD_NietIngezetene" mode="do-gender-salutation"/>
		<xsl:text> </xsl:text>
		<xsl:value-of select="tia:tia_Gegevens/tia:GBA_Ingezetene/tia:naam/tia:voornamen | tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:voornamen"/>
		<xsl:text> </xsl:text>
		<xsl:if test="normalize-space(tia:tia_Gegevens/tia:GBA_Ingezetene/tia:tia_VoorvoegselsNaam | tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:voorvoegsels) != ''">
			<xsl:value-of select="tia:tia_Gegevens/tia:GBA_Ingezetene/tia:tia_VoorvoegselsNaam | tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:voorvoegsels"/>
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:value-of select="tia:tia_Gegevens/tia:GBA_Ingezetene/tia:tia_NaamZonderVoorvoegsels | tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:geslachtsnaam"/>
	</xsl:template>

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon[tia:tia_Gegevens/tia:NHR_Rechtspersoon]" mode="do-distribution-person-name">
		<xsl:value-of select="tia:tia_Gegevens/tia:NHR_Rechtspersoon/tia:rechtsvormSub"/>
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

	Params: acquirerPartyHasAuthorizedRepresentative - indicates whether acquiring party has representative

	Output: text

	Calls:
	none

	Called by:
	(mode) do-purchase-distribution-paragraph-part
	(mode) do-purchase-distribution-table-part
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon" mode="do-distribution-part">
		<xsl:param name="acquirerPartyHasAuthorizedRepresentative"/>

		<xsl:text> voornoemd</xsl:text>
		<xsl:if test="$acquirerPartyHasAuthorizedRepresentative = 'false'">
			<xsl:text>, die bij deze verklaart te aanvaarden</xsl:text>
		</xsl:if>
		<xsl:text> het </xsl:text>
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
	(mode) do-purchase-distribution-table-part
	(mode) do-registered-objects-deed-of-transfer

	Called by:
	(mode) do-purchase-and-transfer
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_AangebodenStuk" mode="do-purchase-and-transfer-standaardlevering">
		<xsl:variable name="Datum_DATE" select="substring(string(tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:koopovereenkomst/tia:datumOndertekening), 0, 11)"/>
		<xsl:variable name="Datum_STRING">
 			<xsl:if test="$Datum_DATE != ''">
				<xsl:value-of select="kef:convertDateToText($Datum_DATE)"/>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="numberOfRegisteredObjects" select="count(tia:StukdeelLevering/tia:IMKAD_ZakelijkRecht)"/>
		<xsl:variable name="numberOfBuyers" select="count(tia:Partij[@id = substring-after(current()/tia:StukdeelLevering/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:IMKAD_Persoon)
			+ count(tia:Partij[@id = substring-after(current()/tia:StukdeelLevering/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:IMKAD_Persoon/tia:GerelateerdPersoon[translate(tia:tia_IndPartij, $upper, $lower) = 'true'])"/>
		<xsl:variable name="undivided">
			<xsl:choose>
				<xsl:when test="translate(tia:StukdeelLevering/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst, $upper, $lower) = 'true'">
					<xsl:choose>
						<xsl:when test="$numberOfBuyers = 2">
							<xsl:text>onverdeelde </xsl:text>
						</xsl:when>
						<xsl:when test="$numberOfBuyers > 2">
							<xsl:text>onverdeeld </xsl:text>
						</xsl:when>
						<xsl:otherwise><xsl:text/></xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise><xsl:text/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="acquirerParty" select="tia:Partij[@id = substring-after(current()/tia:StukdeelLevering/tia:verkrijgerRechtRef/@xlink:href, '#')]"/>	
		<xsl:variable name="koopakte" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst), $upper, $lower)]), $upper, $lower)]" />
		<xsl:variable name="deHetKoopakte">
			<xsl:choose>
				<xsl:when test="normalize-space(tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst) = normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst[1])">
					<xsl:text>het </xsl:text>
				</xsl:when>
				<xsl:when test="normalize-space($koopakte) != ''">
					<xsl:text>de </xsl:text>
				</xsl:when>
			</xsl:choose>
			<xsl:value-of select="$koopakte"/>
		</xsl:variable>
		
		<h2 class="header"><xsl:text>KOOP</xsl:text></h2>
		<p>
			<xsl:call-template name="capitalizePartyAlias">
				<xsl:with-param name="party" select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:vervreemderRechtRef/@xlink:href, '#')]"/>
			</xsl:call-template>
			<xsl:text> en </xsl:text>
			<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
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
			<xsl:if test="translate(tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_akteaangehecht']/tia:tekst, $upper, $lower) = 'true'">
				<xsl:text>aan deze akte wordt gehecht en </xsl:text>
			</xsl:if>
			<xsl:text>hierna wordt aangeduid met "</xsl:text>
			<u>
				<xsl:value-of select="$deHetKoopakte"/>
			</u>
			<xsl:text>".</xsl:text>
		</p>
		<h2 class="header">LEVERING</h2>
		<p>
			<xsl:text>Ter uitvoering van </xsl:text>
			<xsl:value-of select="$deHetKoopakte"/>
			<xsl:text> verklaart </xsl:text>			
			<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelLevering[tia:tia_Volgnummer = '1']/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
			<xsl:text> hierbij te leveren aan </xsl:text>
			<xsl:apply-templates select="." mode="do-purchase-distribution-paragraph-part">
				<xsl:with-param name="numberOfBuyers" select="$numberOfBuyers"/>
				<xsl:with-param name="undivided" select="$undivided"/>
				<xsl:with-param name="acquirerParty" select="$acquirerParty"/>
			</xsl:apply-templates>
		</p>
		<xsl:apply-templates select="." mode="do-purchase-distribution-table-part">
			<xsl:with-param name="numberOfBuyers" select="$numberOfBuyers"/>
			<xsl:with-param name="acquirerParty" select="$acquirerParty"/>
		</xsl:apply-templates>
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
	(mode) do-purchase-distribution-table-part

	Called by:
	(mode) do-purchase-and-transfer
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_AangebodenStuk" mode="do-purchase-and-transfer-tweeleveringen">
		<xsl:variable name="Datum_DATE1" select="substring(string(tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:koopovereenkomst/tia:datumOndertekening), 0, 11)"/>
		<xsl:variable name="Datum_STRING1">
 			<xsl:if test="$Datum_DATE1 != ''">
				<xsl:value-of select="kef:convertDateToText($Datum_DATE1)"/>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="Datum_DATE2" select="substring(string(tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:koopovereenkomst/tia:datumOndertekening), 0, 11)"/>
		<xsl:variable name="Datum_STRING2">
 			<xsl:if test="$Datum_DATE2 != ''">
				<xsl:value-of select="kef:convertDateToText($Datum_DATE2)"/>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="numberOfRegisteredObjects" select="count(tia:StukdeelLevering[tia:tia_Volgnummer = '2']/tia:IMKAD_ZakelijkRecht)"/>
		<xsl:variable name="numberOfBuyers1" select="count(tia:Partij[@id = substring-after(current()/tia:StukdeelLevering[tia:tia_Volgnummer = '1']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:IMKAD_Persoon)
			+ count(tia:Partij[@id = substring-after(current()/tia:StukdeelLevering[tia:tia_Volgnummer = '1']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:IMKAD_Persoon/tia:GerelateerdPersoon[translate(tia:tia_IndPartij, $upper, $lower) = 'true'])"/>
		<xsl:variable name="numberOfBuyers2" select="count(tia:Partij[@id = substring-after(current()/tia:StukdeelLevering[tia:tia_Volgnummer = '2']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:IMKAD_Persoon)
			+ count(tia:Partij[@id = substring-after(current()/tia:StukdeelLevering[tia:tia_Volgnummer = '2']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:IMKAD_Persoon/tia:GerelateerdPersoon[translate(tia:tia_IndPartij, $upper, $lower) = 'true'])"/>
		<xsl:variable name="undivided1">
			<xsl:choose>
				<xsl:when test="translate(tia:StukdeelLevering[tia:tia_Volgnummer = '1']/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst, $upper, $lower) = 'true'">
					<xsl:choose>
						<xsl:when test="$numberOfBuyers1 = 2">
							<xsl:text>onverdeelde </xsl:text>
						</xsl:when>
						<xsl:when test="$numberOfBuyers1 > 2">
							<xsl:text>onverdeeld </xsl:text>
						</xsl:when>
						<xsl:otherwise><xsl:text/></xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise><xsl:text/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="undivided2">
			<xsl:choose>
				<xsl:when test="translate(tia:StukdeelLevering[tia:tia_Volgnummer = '2']/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst, $upper, $lower) = 'true'">
					<xsl:choose>
						<xsl:when test="$numberOfBuyers2 = 2">
							<xsl:text>onverdeelde </xsl:text>
						</xsl:when>
						<xsl:when test="$numberOfBuyers2 > 2">
							<xsl:text>onverdeeld </xsl:text>
						</xsl:when>
						<xsl:otherwise><xsl:text/></xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise><xsl:text/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="acquirerParty1" select="tia:Partij[@id = substring-after(current()/tia:StukdeelLevering[tia:tia_Volgnummer = '1']/tia:verkrijgerRechtRef/@xlink:href, '#')]"/>
		<xsl:variable name="acquirerParty2" select="tia:Partij[@id = substring-after(current()/tia:StukdeelLevering[tia:tia_Volgnummer = '2']/tia:verkrijgerRechtRef/@xlink:href, '#')]"/>
		<xsl:variable name="koopakte" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst), $upper, $lower)]), $upper, $lower)]" />
		<xsl:variable name="ditDezeKoopakte">
			<xsl:choose>
				<xsl:when test="normalize-space(tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:tekstkeuze[tia:tagNaam = 'k_Koopakte']/tia:tekst) = normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst[1])">
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
				<xsl:when test="normalize-space(tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst) = normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst[1])">
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
		<xsl:variable name="transfer-one">
			<xsl:text>Vervolgens verklaart </xsl:text>
			<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelLevering[tia:tia_Volgnummer = '1']/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
			<xsl:text>, ter uitvoering van </xsl:text>
			<xsl:value-of select="$deHet"/>  
			<xsl:text> eerste </xsl:text>
			<xsl:value-of select="$koopakte"/> 
			<xsl:text>, hierbij te leveren aan </xsl:text>
			<xsl:apply-templates select="." mode="do-purchase-distribution-paragraph-part">
				<xsl:with-param name="numberOfBuyers" select="$numberOfBuyers1"/>
				<xsl:with-param name="undivided" select="$undivided1"/>
				<xsl:with-param name="acquirerParty" select="$acquirerParty1"/>
			</xsl:apply-templates>
		</xsl:variable>
		<xsl:variable name="transfer-two">
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
			<xsl:text>, en verklaart </xsl:text>
			<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelLevering[tia:tia_Volgnummer = '2']/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
			<xsl:text>, ter uitvoering van </xsl:text>
			<xsl:value-of select="$deHet"/>
			<xsl:text> tweede </xsl:text>
			<xsl:value-of select="$koopakte"/> 
			<xsl:text>, hierbij te leveren aan </xsl:text>
			<xsl:apply-templates select="." mode="do-purchase-distribution-paragraph-part">
				<xsl:with-param name="numberOfBuyers" select="$numberOfBuyers2"/>
				<xsl:with-param name="undivided" select="$undivided2"/>
				<xsl:with-param name="acquirerParty" select="$acquirerParty2"/>
			</xsl:apply-templates>
		</xsl:variable>
		
		<h2 class="header"><xsl:text>KOOP</xsl:text></h2>
		<table cellpadding="0" cellspacing="0">
			<tbody>
				<tr>
					<td class="number" valign="top">
						<xsl:text>1.</xsl:text>
					</td>
					<td>
				<xsl:text>Door </xsl:text> 
				<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
				<xsl:text> is met </xsl:text>
				<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
				<xsl:text> op </xsl:text>
				<xsl:value-of select="$Datum_STRING1"/>
				<xsl:text> een </xsl:text>
				<xsl:value-of select="$koopakte"/>
				<xsl:text> gesloten betreffende </xsl:text>
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
				<xsl:text>.</xsl:text>
				<xsl:if test="translate(tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_akteaangehecht']/tia:tekst, $upper, $lower) = 'true'">
					<xsl:text> </xsl:text>
					<xsl:value-of select="$ditDezeKoopakte"/>
					<xsl:text> is als bijlage aan deze akte gehecht.</xsl:text>
				</xsl:if>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>2.</xsl:text>
					</td>
					<td>
				<xsl:text>Vervolgens is door </xsl:text> 
				<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
				<xsl:text> met </xsl:text>
				<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
				<xsl:text> op </xsl:text>
				<xsl:value-of select="$Datum_STRING2"/>
				<xsl:text> een </xsl:text>
				<xsl:value-of select="$koopakte"/> 
				<xsl:text> gesloten betreffende </xsl:text>
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
				<xsl:text>.</xsl:text>
				<xsl:if test="translate(tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_akteaangehecht']/tia:tekst, $upper, $lower) = 'true'">
					<xsl:text> </xsl:text>
					<xsl:value-of select="$ditDezeKoopakte"/>
					<xsl:text> is eveneens als bijlage aan deze akte gehecht.</xsl:text>
				</xsl:if>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>3.</xsl:text>
					</td>
					<td>
				<xsl:text>Bij deze akte levert </xsl:text>
				<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
				<xsl:text> aan </xsl:text>
				<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
				<xsl:text> ter uitvoering van </xsl:text>
				<xsl:value-of select="$deHetKoopakte"/> 
				<xsl:text> van </xsl:text>
				<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
				<xsl:text> met </xsl:text>
				<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
				<xsl:text> en </xsl:text>
				<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
				<xsl:text> levert aan </xsl:text>
				<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
				<xsl:text> ter uitvoering van </xsl:text>
				<xsl:value-of select="$deHetKoopakte"/> 
				<xsl:text> van </xsl:text>
				<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
				<xsl:text> met </xsl:text>
				<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
				<xsl:text>.</xsl:text>
					</td>
				</tr>
			</tbody>
		</table>
		<h2 class="header">LEVERING</h2>
		<xsl:choose>
			<!-- if there are acquiring persons with unequal shares in first transfer, paragraph is split to insert table in between -->
			<xsl:when test="(count($acquirerParty1/tia:IMKAD_Persoon/tia:tia_AandeelInRechten)
				+ count($acquirerParty1/tia:IMKAD_Persoon/tia:GerelateerdPersoon[translate(tia:tia_IndPartij, $upper, $lower) = 'true']/tia:IMKAD_Persoon/tia:tia_AandeelInRechten)) > 0">
				<p><xsl:value-of select="$transfer-one"/></p>
				<xsl:apply-templates select="." mode="do-purchase-distribution-table-part">
					<xsl:with-param name="numberOfBuyers" select="$numberOfBuyers1"/>
					<xsl:with-param name="acquirerParty" select="$acquirerParty1"/>
				</xsl:apply-templates>
				<p><xsl:value-of select="$transfer-two"/></p>
			</xsl:when>
			<xsl:otherwise>
				<p>
					<xsl:value-of select="$transfer-one"/>
					<xsl:text> </xsl:text>
					<xsl:value-of select="$transfer-two"/>
				</p>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:apply-templates select="." mode="do-purchase-distribution-table-part">
			<xsl:with-param name="numberOfBuyers" select="$numberOfBuyers2"/>
			<xsl:with-param name="acquirerParty" select="$acquirerParty2"/>
		</xsl:apply-templates>
		<p>
			<xsl:text>OMSCHRIJVING REGISTERGOED</xsl:text>
			<xsl:if test="$numberOfRegisteredObjects > 1">
				<xsl:text>EREN</xsl:text>
			</xsl:if>
		</p>
		<xsl:apply-templates select="tia:StukdeelLevering[tia:tia_Volgnummer = '2']" mode="do-registered-objects-deed-of-transfer"/>
		<p>
			<xsl:text>De bepalingen in deze akte zijn zowel op de eerste levering als op de tweede levering van toepassing, tenzij hierna anders is bepaald.</xsl:text>
		</p>
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
	(mode) do-purchase-distribution-table-part
	(mode) do-registered-objects-deed-of-transfer

	Called by:
	(mode) do-purchase-and-transfer
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_AangebodenStuk" mode="do-purchase-and-transfer-verkooprechtenmetcessie">
		<xsl:variable name="Datum_DATE1" select="substring(string(tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:koopovereenkomst/tia:datumOndertekening), 0, 11)"/>
		<xsl:variable name="Datum_STRING1">
 			<xsl:if test="$Datum_DATE1 != ''">
				<xsl:value-of select="kef:convertDateToText($Datum_DATE1)"/>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="Datum_DATE2" select="substring(string(tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:koopovereenkomst/tia:datumOndertekening), 0, 11)"/>
		<xsl:variable name="Datum_STRING2">
 			<xsl:if test="$Datum_DATE2 != ''">
				<xsl:value-of select="kef:convertDateToText($Datum_DATE2)"/>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="numberOfRegisteredObjects" select="count(tia:StukdeelLevering[tia:tia_Volgnummer = '1']/tia:IMKAD_ZakelijkRecht)"/>
		<xsl:variable name="numberOfBuyers" select="count(tia:Partij[@id = substring-after(current()/tia:StukdeelLevering[tia:tia_Volgnummer = '1']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:IMKAD_Persoon)
			+ count(tia:Partij[@id = substring-after(current()/tia:StukdeelLevering[tia:tia_Volgnummer = '1']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:IMKAD_Persoon/tia:GerelateerdPersoon[translate(tia:tia_IndPartij, $upper, $lower) = 'true'])"/>
		<xsl:variable name="undivided">
			<xsl:choose>
				<xsl:when test="translate(tia:StukdeelLevering[tia:tia_Volgnummer = '1']/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst, $upper, $lower) = 'true'">
					<xsl:choose>
						<xsl:when test="$numberOfBuyers = 2">
							<xsl:text>onverdeelde </xsl:text>
						</xsl:when>
						<xsl:when test="$numberOfBuyers > 2">
							<xsl:text>onverdeeld </xsl:text>
						</xsl:when>
						<xsl:otherwise><xsl:text/></xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise><xsl:text/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="acquirerParty" select="tia:Partij[@id = substring-after(current()/tia:StukdeelLevering[tia:tia_Volgnummer = '1']/tia:verkrijgerRechtRef/@xlink:href, '#')]"/>
		<xsl:variable name="koopakte" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst), $upper, $lower)]), $upper, $lower)]" />
		<xsl:variable name="ditDezeKoopakte">
			<xsl:choose>
				<xsl:when test="normalize-space(tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst) = normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst[1])">
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
				<xsl:when test="normalize-space(tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst) = normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst[1])">
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
		<xsl:variable name="colspan">
			<xsl:choose>
				<xsl:when test="translate(tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_cessie']/tia:tekst, $upper, $lower) = 'true'">
					<xsl:text>2</xsl:text>
				</xsl:when>
			</xsl:choose>
		</xsl:variable>
		
		<h2 class="header"><xsl:text>KOOP</xsl:text></h2>
		<table cellpadding="0" cellspacing="0">
			<tbody>
				<tr>
					<td class="number" valign="top">
						<xsl:text>1.</xsl:text>
					</td>
					<td>
						<xsl:if test="$colspan != ''">
							<xsl:attribute name="colspan">
								<xsl:value-of select="$colspan"/>
							</xsl:attribute>
						</xsl:if>
				<xsl:text>Door </xsl:text> 
				<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
				<xsl:text> is met </xsl:text>
				<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
				<xsl:text> op </xsl:text>
				<xsl:value-of select="$Datum_STRING1"/>
				<xsl:text> een </xsl:text>
				<xsl:value-of select="$koopakte"/>
				<xsl:text> gesloten betreffende de hierna aangeduide zaken.</xsl:text>
				<xsl:if test="translate(tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_akteaangehecht']/tia:tekst, $upper, $lower) = 'true'">
					<xsl:text> </xsl:text>
					<xsl:value-of select="$ditDezeKoopakte"/>
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
							<xsl:attribute name="colspan">
								<xsl:value-of select="$colspan"/>
							</xsl:attribute>
						</xsl:if>
				<xsl:text>Vervolgens is door </xsl:text> 
				<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
				<xsl:text> met </xsl:text>
				<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
				<xsl:text> op </xsl:text>
				<xsl:value-of select="$Datum_STRING2"/>
				<xsl:text> een </xsl:text>
				<xsl:value-of select="$koopakte"/>
				<xsl:text> gesloten betreffende zijn rechten uit </xsl:text>
				<xsl:value-of select="$deHetKoopakte"/>
				<xsl:text> met </xsl:text>
				<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
				<xsl:text> met betrekking tot de hierna aangeduide zaken.</xsl:text>
				<xsl:if test="translate(tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_akteaangehecht']/tia:tekst, $upper, $lower) = 'true'">
					<xsl:text> </xsl:text>
					<xsl:value-of select="$ditDezeKoopakte"/>
					<xsl:text> is eveneens als bijlage aan deze akte gehecht.</xsl:text>
				</xsl:if>
					</td>
				</tr>
				<xsl:choose>
					<xsl:when test="translate(tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_cessie']/tia:tekst, $upper, $lower) = 'false'">
						<tr>
							<td class="number" valign="top">
								<xsl:text>3.</xsl:text>
							</td>
							<td>
						<xsl:call-template name="capitalizePartyAlias">
							<xsl:with-param name="party" select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:verkrijgerRechtRef/@xlink:href, '#')]"/>
						</xsl:call-template>
						<xsl:text> heeft vervolgens de rechten uit </xsl:text>
						<xsl:value-of select="$deHetKoopakte"/>
						<xsl:text> met </xsl:text>
						<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
						<xsl:text> ter voldoening aan zijn koopovereenkomst aan </xsl:text>
						<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
						<xsl:text> geleverd, waarvan mededeling is gedaan aan </xsl:text>
						<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
						<xsl:text>. Bij deze akte wordt de onroerende zaak door </xsl:text>
						<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
						<xsl:text> rechtstreeks aan </xsl:text>
						<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
						<xsl:text> geleverd.</xsl:text>
							</td>
						</tr>	
					</xsl:when>
					<xsl:when test="translate(tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_cessie']/tia:tekst, $upper, $lower) = 'true'">
						<tr>
							<td class="number" valign="top">
								<xsl:text>3.</xsl:text>
							</td>
							<td>
								<xsl:if test="$colspan != ''">
									<xsl:attribute name="colspan">
										<xsl:value-of select="$colspan"/>
									</xsl:attribute>
								</xsl:if>
						<xsl:call-template name="capitalizePartyAlias">
							<xsl:with-param name="party" select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:verkrijgerRechtRef/@xlink:href, '#')]"/>
						</xsl:call-template>
						<xsl:text> draagt hierbij alle rechten uit voormelde </xsl:text>
						<xsl:value-of select="$koopakte"/>
						<xsl:text> met </xsl:text>
						<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
						<xsl:text>, in het bijzonder het recht om van </xsl:text>
						<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
						<xsl:text> de levering in onvoorwaardelijke, volle en vrije eigendom van de hierna vermelde zaken te vorderen, over aan </xsl:text>
						<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
						<xsl:text>, welke overdracht </xsl:text>
						<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
						<xsl:text> hierbij aanvaardt, een en ander op grond van de eveneens in </xsl:text> 
						<xsl:value-of select="$deHet"/>
						<xsl:text> hiervoor onder 1 omschreven </xsl:text>
						<xsl:value-of select="$koopakte"/> 
						<xsl:text> en met dien verstande dat een mededeling, als bedoeld hierna, nog gedaan dient te worden.</xsl:text>
						<br/>
						<xsl:text>Alle rechten en nevenrechten die uit </xsl:text>
						<xsl:value-of select="$deHetKoopakte"/> 
						<xsl:text> tussen </xsl:text>
						<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
						<xsl:text> en </xsl:text>
						<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
						<xsl:text> voortvloeien, waaronder begrepen de rechten uit hoofde van eventuele arbitrage- en bindend-adviesclausules, een en ander met inbegrip van de daaraan verbonden verplichtingen, gaan bij deze van rechtswege over op </xsl:text>
						<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
						<xsl:text>.</xsl:text>
						<br/>
						<xsl:call-template name="capitalizePartyAlias">
							<xsl:with-param name="party" select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:vervreemderRechtRef/@xlink:href, '#')]"/>
						</xsl:call-template>
						<xsl:text> verklaart dat deze cessie aan hem is medegedeeld en deze door </xsl:text>
						<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
						<xsl:text> gedane cessie te erkennen.</xsl:text>
						<br/>
						<xsl:call-template name="capitalizePartyAlias">
							<xsl:with-param name="party" select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:verkrijgerRechtRef/@xlink:href, '#')]"/>
						</xsl:call-template>
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
								<xsl:value-of select="$deHet"/> 
								<xsl:text> genoemde </xsl:text>
								<xsl:value-of select="$koopakte"/>
								<xsl:text> bestaat en dat de rechten daaruit overdraagbaar zijn en dat zij niet aantastbaar is op grond van juridische verweren van </xsl:text>
								<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
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
								<xsl:value-of select="$koopakte"/> 
								<xsl:text> over te dragen en dat die rechten onbeslagen zijn en ook niet bezwaard zijn met enig zekerheidsrecht.</xsl:text>
							</td>
						</tr>
					</xsl:when>
				</xsl:choose>
			</tbody>
		</table>
		<h2 class="header">LEVERING</h2>
		<p>
			<xsl:text>Vervolgens verklaart </xsl:text>			
			<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelLevering[tia:tia_Volgnummer = '1']/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
			<xsl:text>, door middel van deze akte, ter uitvoering van </xsl:text>
			<xsl:value-of select="$deHet"/>
			<xsl:text> eerste </xsl:text>
			<xsl:value-of select="$koopakte"/>
			<xsl:text>, te leveren aan </xsl:text>
			<xsl:apply-templates select="." mode="do-purchase-distribution-paragraph-part">
				<xsl:with-param name="numberOfBuyers" select="$numberOfBuyers"/>
				<xsl:with-param name="undivided" select="$undivided"/>
				<xsl:with-param name="acquirerParty" select="$acquirerParty"/>
			</xsl:apply-templates>
		</p>
		<xsl:apply-templates select="." mode="do-purchase-distribution-table-part">
			<xsl:with-param name="numberOfBuyers" select="$numberOfBuyers"/>
			<xsl:with-param name="acquirerParty" select="$acquirerParty"/>
		</xsl:apply-templates>
		<p>
			<xsl:text>OMSCHRIJVING REGISTERGOED</xsl:text>
			<xsl:if test="$numberOfRegisteredObjects > 1">
				<xsl:text>EREN</xsl:text>
			</xsl:if>
		</p>
		<xsl:apply-templates select="tia:StukdeelLevering[tia:tia_Volgnummer = '1']" mode="do-registered-objects-deed-of-transfer"/>
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
	(mode) do-purchase-distribution-table-part
	(mode) do-registered-objects-deed-of-transfer

	Called by:
	(mode) do-purchase-and-transfer
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_AangebodenStuk" mode="do-purchase-and-transfer-verkooprechtenmetindeplaatsstelling">
		<xsl:variable name="Datum_DATE1" select="substring(string(tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:koopovereenkomst/tia:datumOndertekening), 0, 11)"/>
		<xsl:variable name="Datum_STRING1">
 			<xsl:if test="$Datum_DATE1 != ''">
				<xsl:value-of select="kef:convertDateToText($Datum_DATE1)"/>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="Datum_DATE2" select="substring(string(tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:koopovereenkomst/tia:datumOndertekening), 0, 11)"/>
		<xsl:variable name="Datum_STRING2">
 			<xsl:if test="$Datum_DATE2 != ''">
				<xsl:value-of select="kef:convertDateToText($Datum_DATE2)"/>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="numberOfRegisteredObjects" select="count(tia:StukdeelLevering/tia:IMKAD_ZakelijkRecht)"/>
		<xsl:variable name="numberOfBuyers" select="count(tia:Partij[@id = substring-after(current()/tia:StukdeelLevering/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:IMKAD_Persoon)
			+ count(tia:Partij[@id = substring-after(current()/tia:StukdeelLevering/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:IMKAD_Persoon/tia:GerelateerdPersoon[translate(tia:tia_IndPartij, $upper, $lower) = 'true'])"/>
		<xsl:variable name="undivided">
			<xsl:choose>
				<xsl:when test="translate(tia:StukdeelLevering/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_onverdeeld']/tia:tekst, $upper, $lower) = 'true'">
					<xsl:choose>
						<xsl:when test="$numberOfBuyers = 2">
							<xsl:text>onverdeelde </xsl:text>
						</xsl:when>
						<xsl:when test="$numberOfBuyers > 2">
							<xsl:text>onverdeeld </xsl:text>
						</xsl:when>
						<xsl:otherwise><xsl:text/></xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise><xsl:text/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="acquirerParty" select="tia:Partij[@id = substring-after(current()/tia:StukdeelLevering/tia:verkrijgerRechtRef/@xlink:href, '#')]"/>
		<xsl:variable name="koopakte" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst), $upper, $lower)]), $upper, $lower)]" />
		<xsl:variable name="ditDezeKoopakte">
			<xsl:choose>
				<xsl:when test="normalize-space(tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst) = normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst[1])">
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
				<xsl:when test="normalize-space(tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst) = normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopakte']/tia:tekst[1])">
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
		
		<h2 class="header"><xsl:text>KOOP</xsl:text></h2>
		<table cellpadding="0" cellspacing="0">
			<tbody>
				<tr>
					<td class="number" valign="top">
						<xsl:text>1.</xsl:text>
					</td>
					<td>
				<xsl:text>Door </xsl:text> 
				<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
				<xsl:text> is met </xsl:text>
				<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
				<xsl:text> op </xsl:text>
				<xsl:value-of select="$Datum_STRING1"/>
				<xsl:text> een </xsl:text>
				<xsl:value-of select="$koopakte"/> 
				<xsl:text> gesloten betreffende de hierna aangeduide zaken.</xsl:text>
				<xsl:text> </xsl:text>
				<xsl:value-of select="$ditDezeKoopakte"/>
				<xsl:text> is als bijlage aan deze akte gehecht.</xsl:text>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>2.</xsl:text>
					</td>
					<td>
				<xsl:text>Vervolgens is door </xsl:text> 
				<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
				<xsl:text> met </xsl:text>
				<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
				<xsl:text> op </xsl:text>
				<xsl:value-of select="$Datum_STRING2"/>
				<xsl:text> een </xsl:text>
				<xsl:value-of select="$koopakte"/>
				<xsl:text> gesloten betreffende </xsl:text>
				<xsl:value-of select="$deHetKoopakte"/> 
				<xsl:text> met </xsl:text>
				<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
				<xsl:text> met betrekking tot de hierna aangeduide zaken.</xsl:text>
				<xsl:text> </xsl:text>
				<xsl:value-of select="$ditDezeKoopakte"/>
				<xsl:text> is eveneens als bijlage aan deze akte gehecht.</xsl:text>
					</td>
				</tr>
				<xsl:choose>
					<xsl:when test="translate(tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_contractsoverneming']/tia:tekst, $upper, $lower) = 'false'">
						<tr>
							<td class="number" valign="top">
								<xsl:text>3.</xsl:text>
							</td>
							<td>
						<xsl:text>Bij overeenkomst tussen </xsl:text>
						<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
						<xsl:text>, </xsl:text>
						<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
						<xsl:text> en </xsl:text>
						<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
						<xsl:text> heeft </xsl:text>
						<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
						<xsl:text> de volledige contractspositie van </xsl:text>
						<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
						<xsl:text> in de overeenkomst met </xsl:text>
						<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
						<xsl:text> overgenomen. Bij deze akte wordt ter uitvoering van </xsl:text> 
						<xsl:value-of select="$deHetKoopakte"/> 
						<xsl:text> tussen </xsl:text>
						<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
						<xsl:text> en </xsl:text>
						<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
						<xsl:text> de onroerende zaak aan </xsl:text>
						<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
						<xsl:text> geleverd.</xsl:text>
							</td>
						</tr>
					</xsl:when>
					<xsl:when test="translate(tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_contractsoverneming']/tia:tekst, $upper, $lower) = 'true'">
						<tr>
							<td class="number" valign="top">
								<xsl:text>3.</xsl:text>
							</td>
							<td>
						<xsl:text>Partijen komen overeen dat </xsl:text>
						<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
						<xsl:text> de rechtsverhouding van </xsl:text>
						<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
						<xsl:text> in de overeenkomst met </xsl:text>
						<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
						<xsl:text> overneemt. Alle rechten met inbegrip van wilsrechten en verplichtingen uit hoofde van het contract van </xsl:text>
						<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
						<xsl:text> op </xsl:text>						
						<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
						<xsl:text>, in het bijzonder het recht om van </xsl:text>
						<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
						<xsl:text> de levering in onvoorwaardelijke, volle en vrije eigendom van de hierna vermelde zaken te vorderen, gaan derhalve bij deze over op </xsl:text>
						<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
						<xsl:text>. De verweermiddelen die </xsl:text>
						<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
						<xsl:text> jegens </xsl:text>
						<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
						<xsl:text> met betrekking tot zijn vorderingen kon doen gelden, kan hij voortaan jegens </xsl:text>
						<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
						<xsl:text> doen gelden, zoals ook </xsl:text>
						<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
						<xsl:text> de verweermiddelen die </xsl:text>
						<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
						<xsl:text> tot nu toe jegens </xsl:text>
						<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
						<xsl:text> kon inroepen, voortaan zelf tegen </xsl:text>
						<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
						<xsl:text> kan inroepen.</xsl:text>
						<br/>
						<xsl:call-template name="capitalizePartyAlias">
							<xsl:with-param name="party" select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:verkrijgerRechtRef/@xlink:href, '#')]"/>
						</xsl:call-template>
						<xsl:text> verschaft aan </xsl:text>
						<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
						<xsl:text> hierbij zo veel mogelijk alle bewijsstukken en eventuele executoriale titels met betrekking tot de op </xsl:text>
						<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
						<xsl:text> overgaande hoofd-, wils- en nevenrechten, waaronder begrepen de akte van het hierbij overgenomen contract, in origineel. Voor het geval enig bewijsstuk of enige executoriale titel onder een derde berust, althans van een derde te verkrijgen is, machtigt </xsl:text>
						<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
						<xsl:text> hierbij </xsl:text>
						<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
						<xsl:text> onherroepelijk om zelf dit stuk bij die derde op te vragen en eventueel in rechte op te vorderen.</xsl:text>
							</td>
						</tr>
					</xsl:when>
				</xsl:choose>
			</tbody>
		</table>
		<h2 class="header">LEVERING</h2>
		<p>
			<xsl:text>Vervolgens verklaart </xsl:text>			
			<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelLevering[tia:tia_Volgnummer = '1']/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
			<xsl:text> hierbij, ter uitvoering van </xsl:text> 
			<xsl:value-of select="$deHet"/>
			<xsl:text> eerste </xsl:text>
			<xsl:value-of select="$koopakte"/> 
			<xsl:text>, te leveren aan </xsl:text>
			<xsl:apply-templates select="." mode="do-purchase-distribution-paragraph-part">
				<xsl:with-param name="numberOfBuyers" select="$numberOfBuyers"/>
				<xsl:with-param name="undivided" select="$undivided"/>
				<xsl:with-param name="acquirerParty" select="$acquirerParty"/>
			</xsl:apply-templates>
		</p>
		<xsl:apply-templates select="." mode="do-purchase-distribution-table-part">
			<xsl:with-param name="numberOfBuyers" select="$numberOfBuyers"/>
			<xsl:with-param name="acquirerParty" select="$acquirerParty"/>
		</xsl:apply-templates>
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
					<br/>
					<xsl:text>hierna aangeduid met: "</xsl:text>
					<u><xsl:text>het verkochte</xsl:text></u>
					<xsl:text>".</xsl:text>
				</p>
			</xsl:when>
			<!-- Multiple registered objects, all parcels with same data -->
			<xsl:when test="count(tia:IMKAD_ZakelijkRecht)
					= count(tia:IMKAD_ZakelijkRecht[
						((tia:tia_TekstKeuze[tia:tagNaam = 'k_VoorlopigeGrenzen']/tia:tekst
								= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen']/tia:tekst)
							or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen'])
								and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen'])))
						and tia:aardVerkregen = current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:aardVerkregen
						and normalize-space(tia:aardVerkregen) != ''
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
							and normalize-space(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam) != '']])">
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
					<br/>
					<xsl:text>hierna aangeduid met: "</xsl:text>
					<u><xsl:text>het verkochte</xsl:text></u>
					<xsl:text>".</xsl:text>
				</p>
			</xsl:when>
			<xsl:otherwise>
				<table cellpadding="0" cellspacing="0">
					<tbody>
						<xsl:call-template name="processRights">
							<xsl:with-param name="positionOfProcessedRight" select="1"/>
							<xsl:with-param name="position" select="1"/>
							<xsl:with-param name="registeredObjects" select="."/>
							<xsl:with-param name="punctuationMark" select="','"/>
						</xsl:call-template>
					</tbody>
				</table>
				<p>
					<xsl:text>hierna aangeduid met: "</xsl:text>
					<u><xsl:text>het verkochte</xsl:text></u>
					<xsl:text>".</xsl:text>
				</p>
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
	none

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
	<xsl:template match="tia:IMKAD_AangebodenStuk[tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:koopovereenkomst/tia:datumInschrijving
				and tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:koopovereenkomst/tia:gegevensInschrijving]"
			mode="do-purchase-registration">
		<xsl:variable name="Datum_DATE" select="substring(string(tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:koopovereenkomst/tia:datumInschrijving), 0, 11)"/>
		<xsl:variable name="Datum_STRING">
 			<xsl:if test="$Datum_DATE != ''">
				<xsl:value-of select="kef:convertDateToText($Datum_DATE)"/>
			</xsl:if>
		</xsl:variable>
		<a name="hyp4.purchaseRegistration" class="location">&#160;</a>
		<h2 class="header"><xsl:text>INSCHRIJVING KOOP</xsl:text></h2>
		<p>
			<xsl:text>De koop is ingeschreven ten kantore van de Dienst voor het kadaster en de openbare registers op </xsl:text>
			<xsl:value-of select="$Datum_STRING"/>
			<xsl:text> in </xsl:text>
			<xsl:apply-templates select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:koopovereenkomst/tia:gegevensInschrijving" mode="do-part-and-number" />
			<xsl:if test="translate(tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:vervallen, $upper, $lower) = 'true'">
				<xsl:text> welke inschrijving door de inschrijving van een afschrift van deze akte waardeloos zal worden</xsl:text>
			</xsl:if>
			<xsl:text>.</xsl:text>
		</p>
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
		<h2 class="header"><xsl:text>KOOPPRIJS</xsl:text></h2>
		<xsl:choose>
		    <xsl:when test="tia:tia_StukVariant = 'Twee leveringen'">
		    	<xsl:choose>
		    		<xsl:when test="translate(tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'kaal'">
		    			<p>
		        			<xsl:text>De koopprijs die tussen </xsl:text>
		        			<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
		        			<xsl:text> en </xsl:text>
		        			<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
		        			<xsl:text> is overeengekomen, bedraagt: </xsl:text>
		        			<xsl:call-template name="amountText">
		        				<xsl:with-param name="amount" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:transactiesom/tia:som" />
		        				<xsl:with-param name="valuta" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:transactiesom/tia:valuta" />
		        			</xsl:call-template>
		        			<xsl:text> </xsl:text>
		        			<xsl:call-template name="amountNumber">
		        				<xsl:with-param name="amount" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:transactiesom/tia:som" />
		        				<xsl:with-param name="valuta" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:transactiesom/tia:valuta" />
		        			</xsl:call-template>
		        			<xsl:text>.</xsl:text>
		        			<br/>
		        			<xsl:text>De koopprijs die tussen </xsl:text>
		        			<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
		        			<xsl:text> en </xsl:text>
		        			<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
		        			<xsl:text> is overeengekomen, bedraagt: </xsl:text>
		        			<xsl:call-template name="amountText">
		        				<xsl:with-param name="amount" select="tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:transactiesom/tia:som" />
		        				<xsl:with-param name="valuta" select="tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:transactiesom/tia:valuta" />
		        			</xsl:call-template>
		        			<xsl:text> </xsl:text>
		        			<xsl:call-template name="amountNumber">
		        				<xsl:with-param name="amount" select="tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:transactiesom/tia:som" />
		        				<xsl:with-param name="valuta" select="tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:transactiesom/tia:valuta" />
		        			</xsl:call-template>
		        			<xsl:text>.</xsl:text>
		        		</p>
		    		</xsl:when>
		    		<xsl:when test="translate(tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'roerende zaken exclusief'">
		    			<xsl:variable name="apos" select='"&#39;"'/>
		    			<xsl:variable name="partyTextOne">
		    				<xsl:choose>
		    					<xsl:when test="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:koopprijsSpecificatie/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_partijkeuzekoopprijs']/tia:tekst = concat('{Stukdeelkoop/tia_Volgnummer(', $apos, '1', $apos, ') ../vervreemderRechtRef/Partij/aanduidingPartij}')">
		    						<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
		    					</xsl:when>
		    					<xsl:when test="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:koopprijsSpecificatie/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_partijkeuzekoopprijs']/tia:tekst = concat('{Stukdeelkoop/tia_Volgnummer(', $apos, '1', $apos, ') ../verkrijgerRechtRef/Partij/aanduidingPartij}')">
		    						<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
		    					</xsl:when>
		    					<xsl:when test="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:koopprijsSpecificatie/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_partijkeuzekoopprijs']/tia:tekst = concat('{Stukdeelkoop/tia_Volgnummer(', $apos, '1', $apos, ') ../vervreemderRechtRef/Partij/aanduidingPartij} en {Stukdeelkoop/tia_Volgnummer(', $apos, '1', $apos, ') ../verkrijgerRechtRef/Partij/aanduidingPartij}')">
		    						<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
		    						<xsl:text> en </xsl:text>
		    						<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
		    					</xsl:when>
		    				</xsl:choose>
		    			</xsl:variable>
		    			<xsl:variable name="partyTextTwo">
		    				<xsl:choose>
		    					<xsl:when test="tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:koopprijsSpecificatie/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_partijkeuzekoopprijs']/tia:tekst = concat('{Stukdeelkoop/tia_Volgnummer(', $apos, '2', $apos, ') ../vervreemderRechtRef/Partij/aanduidingPartij}')">
		    						<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
		    					</xsl:when>
		    					<xsl:when test="tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:koopprijsSpecificatie/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_partijkeuzekoopprijs']/tia:tekst = concat('{Stukdeelkoop/tia_Volgnummer(', $apos, '2', $apos, ') ../verkrijgerRechtRef/Partij/aanduidingPartij}')">
		    						<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
		    					</xsl:when>
		    					<xsl:when test="tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:koopprijsSpecificatie/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_partijkeuzekoopprijs']/tia:tekst = concat('{Stukdeelkoop/tia_Volgnummer(', $apos, '2', $apos, ') ../vervreemderRechtRef/Partij/aanduidingPartij} en {Stukdeelkoop/tia_Volgnummer(', $apos, '2', $apos, ') ../verkrijgerRechtRef/Partij/aanduidingPartij}')">
		    						<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
		    						<xsl:text> en </xsl:text>
		    						<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
		    					</xsl:when>
		    				</xsl:choose>
		    			</xsl:variable>
		    			<p>
		        			<xsl:text>De koopprijs die tussen </xsl:text>
		        			<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
		        			<xsl:text> en </xsl:text>
		        			<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
		        			<xsl:text> is overeengekomen, bedraagt: </xsl:text>
		        			<xsl:call-template name="amountText">
		        				<xsl:with-param name="amount" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:transactiesom/tia:som" />
		        				<xsl:with-param name="valuta" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:transactiesom/tia:valuta" />
		        			</xsl:call-template>
		        			<xsl:text> </xsl:text>
		        			<xsl:call-template name="amountNumber">
		        				<xsl:with-param name="amount" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:transactiesom/tia:som" />
		        				<xsl:with-param name="valuta" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:transactiesom/tia:valuta" />
		        			</xsl:call-template>
		        			<xsl:text>. </xsl:text>
		        			<xsl:value-of select="$partyTextOne"/>
		        			<xsl:if test="translate(tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:koopprijsSpecificatie/tia:roerendezakenInclusief, $upper, $lower) = 'false'">
			        			<xsl:choose>
			        				<xsl:when test="contains(translate($partyTextOne, $upper, $lower), 'en')">
			        					<xsl:text> hebben</xsl:text>
			        				</xsl:when>
			        				<xsl:otherwise>
			        					<xsl:text> heeft</xsl:text>
			        				</xsl:otherwise>
			        			</xsl:choose>
			        		    <xsl:text> aan de in het verkochte begrepen roerende zaken een waarde toegekend groot </xsl:text>
			        		    <xsl:call-template name="amountText">
			        				<xsl:with-param name="amount" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:koopprijsSpecificatie/tia:roerendezakenWaarde/tia:som" />
			        				<xsl:with-param name="valuta" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:koopprijsSpecificatie/tia:roerendezakenWaarde/tia:valuta" />
			        			</xsl:call-template>
			        			<xsl:text> </xsl:text>
			        			<xsl:call-template name="amountNumber">
			        				<xsl:with-param name="amount" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:koopprijsSpecificatie/tia:roerendezakenWaarde/tia:som" />
			        				<xsl:with-param name="valuta" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:koopprijsSpecificatie/tia:roerendezakenWaarde/tia:valuta" />
			        			</xsl:call-template>
			        			<xsl:text>. De koopprijs wordt met dit bedrag verhoogd.</xsl:text>
		        			</xsl:if>
		        			<br/>
		        			<xsl:text>De koopprijs die tussen </xsl:text>
		        			<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
		        			<xsl:text> en </xsl:text>
		        			<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
		        			<xsl:text> is overeengekomen, bedraagt: </xsl:text>
		        			<xsl:call-template name="amountText">
		        				<xsl:with-param name="amount" select="tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:transactiesom/tia:som" />
		        				<xsl:with-param name="valuta" select="tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:transactiesom/tia:valuta" />
		        			</xsl:call-template>
		        			<xsl:text> </xsl:text>
		        			<xsl:call-template name="amountNumber">
		        				<xsl:with-param name="amount" select="tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:transactiesom/tia:som" />
		        				<xsl:with-param name="valuta" select="tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:transactiesom/tia:valuta" />
		        			</xsl:call-template>
		        			<xsl:text>. </xsl:text>
		        			<xsl:value-of select="$partyTextTwo"/>
		        			<xsl:if test="translate(tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:koopprijsSpecificatie/tia:roerendezakenInclusief, $upper, $lower) = 'false'">
			        			<xsl:choose>
			        				<xsl:when test="contains(translate($partyTextTwo, $upper, $lower), 'en')">
			        					<xsl:text> hebben</xsl:text>
			        				</xsl:when>
			        				<xsl:otherwise>
			        					<xsl:text> heeft</xsl:text>
			        				</xsl:otherwise>
			        			</xsl:choose>
			        		    <xsl:text> aan de in het verkochte begrepen roerende zaken een waarde toegekend groot </xsl:text>
			        		    <xsl:call-template name="amountText">
			        				<xsl:with-param name="amount" select="tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:koopprijsSpecificatie/tia:roerendezakenWaarde/tia:som" />
			        				<xsl:with-param name="valuta" select="tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:koopprijsSpecificatie/tia:roerendezakenWaarde/tia:valuta" />
			        			</xsl:call-template>
			        			<xsl:text> </xsl:text>
			        			<xsl:call-template name="amountNumber">
			        				<xsl:with-param name="amount" select="tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:koopprijsSpecificatie/tia:roerendezakenWaarde/tia:som" />
			        				<xsl:with-param name="valuta" select="tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:koopprijsSpecificatie/tia:roerendezakenWaarde/tia:valuta" />
			        			</xsl:call-template>
			        			<xsl:text>. De koopprijs wordt met dit bedrag verhoogd.</xsl:text>
		        			</xsl:if>
		        		</p>		    		
		    		</xsl:when>
		    		<xsl:when test="translate(tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'roerende zaken inclusief'">
		    			<p>
		        			<xsl:text>De koopprijs die tussen </xsl:text>
		        			<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
		        			<xsl:text> en </xsl:text>
		        			<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
		        			<xsl:text> is overeengekomen, bedraagt: </xsl:text>
		        			<xsl:call-template name="amountText">
		        				<xsl:with-param name="amount" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:transactiesom/tia:som" />
		        				<xsl:with-param name="valuta" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:transactiesom/tia:valuta" />
		        			</xsl:call-template>
		        			<xsl:text> </xsl:text>
		        			<xsl:call-template name="amountNumber">
		        				<xsl:with-param name="amount" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:transactiesom/tia:som" />
		        				<xsl:with-param name="valuta" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:transactiesom/tia:valuta" />
		        			</xsl:call-template>
		        			<xsl:text>. </xsl:text>
		        			<xsl:if test="translate(tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:koopprijsSpecificatie/tia:roerendezakenInclusief, $upper, $lower) = 'true'"> 
			        		    <xsl:text> In de koopprijs is een bedrag van </xsl:text>
			        		    <xsl:call-template name="amountText">
			        				<xsl:with-param name="amount" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:koopprijsSpecificatie/tia:roerendezakenWaarde/tia:som" />
			        				<xsl:with-param name="valuta" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:koopprijsSpecificatie/tia:roerendezakenWaarde/tia:valuta" />
			        			</xsl:call-template>
			        			<xsl:text> </xsl:text>
			        			<xsl:call-template name="amountNumber">
			        				<xsl:with-param name="amount" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:koopprijsSpecificatie/tia:roerendezakenWaarde/tia:som" />
			        				<xsl:with-param name="valuta" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:koopprijsSpecificatie/tia:roerendezakenWaarde/tia:valuta" />
			        			</xsl:call-template>
			        			<xsl:text> voor roerende zaken begrepen.</xsl:text>
		        			</xsl:if>
		        			<br/>
		        			<xsl:text>De koopprijs die tussen </xsl:text>
		        			<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
		        			<xsl:text> en </xsl:text>
		        			<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
		        			<xsl:text> is overeengekomen, bedraagt: </xsl:text>
		        			<xsl:call-template name="amountText">
		        				<xsl:with-param name="amount" select="tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:transactiesom/tia:som" />
		        				<xsl:with-param name="valuta" select="tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:transactiesom/tia:valuta" />
		        			</xsl:call-template>
		        			<xsl:text> </xsl:text>
		        			<xsl:call-template name="amountNumber">
		        				<xsl:with-param name="amount" select="tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:transactiesom/tia:som" />
		        				<xsl:with-param name="valuta" select="tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:transactiesom/tia:valuta" />
		        			</xsl:call-template>
		        			<xsl:text>. </xsl:text>
		        			<xsl:if test="translate(tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:koopprijsSpecificatie/tia:roerendezakenInclusief, $upper, $lower) = 'true'"> 
			        		    <xsl:text> In de koopprijs is een bedrag van </xsl:text>
			        		    <xsl:call-template name="amountText">
			        				<xsl:with-param name="amount" select="tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:koopprijsSpecificatie/tia:roerendezakenWaarde/tia:som" />
			        				<xsl:with-param name="valuta" select="tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:koopprijsSpecificatie/tia:roerendezakenWaarde/tia:valuta" />
			        			</xsl:call-template>
			        			<xsl:text> </xsl:text>
			        			<xsl:call-template name="amountNumber">
			        				<xsl:with-param name="amount" select="tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:koopprijsSpecificatie/tia:roerendezakenWaarde/tia:som" />
			        				<xsl:with-param name="valuta" select="tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:koopprijsSpecificatie/tia:roerendezakenWaarde/tia:valuta" />
			        			</xsl:call-template>
			        			<xsl:text> voor roerende zaken begrepen.</xsl:text>
		        			</xsl:if>
		        		</p>		    
		    		</xsl:when>
		    		<xsl:when test="translate(tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'vrij op naam'">
		    			<p>
		        			<xsl:text>De koopprijs die tussen </xsl:text>
		        			<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
		        			<xsl:text> en </xsl:text>
		        			<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
		        			<xsl:text> is overeengekomen, bedraagt: </xsl:text>
		        			<xsl:call-template name="amountText">
		        				<xsl:with-param name="amount" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:transactiesom/tia:som" />
		        				<xsl:with-param name="valuta" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:transactiesom/tia:valuta" />
		        			</xsl:call-template>
		        			<xsl:text> </xsl:text>
		        			<xsl:call-template name="amountNumber">
		        				<xsl:with-param name="amount" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:transactiesom/tia:som" />
		        				<xsl:with-param name="valuta" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:transactiesom/tia:valuta" />
		        			</xsl:call-template>
		        			<xsl:text>, </xsl:text>
		        			<xsl:if test="translate(tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:koopprijsSpecificatie/tia:omzetbelastingInclusief, $upper, $lower) = 'true'"> 
			        		    <xsl:text> inclusief een bedrag van </xsl:text>
			        		    <xsl:call-template name="amountText">
			        				<xsl:with-param name="amount" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:koopprijsSpecificatie/tia:omzetbelasting/tia:som" />
			        				<xsl:with-param name="valuta" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:koopprijsSpecificatie/tia:omzetbelasting/tia:valuta" />
			        			</xsl:call-template>
			        			<xsl:text> </xsl:text>
			        			<xsl:call-template name="amountNumber">
			        				<xsl:with-param name="amount" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:koopprijsSpecificatie/tia:omzetbelasting/tia:som" />
			        				<xsl:with-param name="valuta" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:koopprijsSpecificatie/tia:omzetbelasting/tia:valuta" />
			        			</xsl:call-template>
			        			<xsl:text> aan omzetbelasting. De notari&#x00EB;le kosten en het kadastraal recht wegens de levering van het verkochte zijn voor rekening van </xsl:text>
			        			<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
			        			<xsl:text>.</xsl:text>
		        			</xsl:if>
		        			<br/>
		        			<xsl:text>De koopprijs die tussen </xsl:text>
		        			<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
		        			<xsl:text> en </xsl:text>
		        			<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
		        			<xsl:text> is overeengekomen, bedraagt: </xsl:text>
		        			<xsl:call-template name="amountText">
		        				<xsl:with-param name="amount" select="tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:transactiesom/tia:som" />
		        				<xsl:with-param name="valuta" select="tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:transactiesom/tia:valuta" />
		        			</xsl:call-template>
		        			<xsl:text> </xsl:text>
		        			<xsl:call-template name="amountNumber">
		        				<xsl:with-param name="amount" select="tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:transactiesom/tia:som" />
		        				<xsl:with-param name="valuta" select="tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:transactiesom/tia:valuta" />
		        			</xsl:call-template>
		        			<xsl:text>, </xsl:text>
			        		<xsl:if test="translate(tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:koopprijsSpecificatie/tia:omzetbelastingInclusief, $upper, $lower) = 'true'"> 
			        		    <xsl:text> inclusief een bedrag van </xsl:text>
			        		    <xsl:call-template name="amountText">
			        				<xsl:with-param name="amount" select="tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:koopprijsSpecificatie/tia:omzetbelasting/tia:som" />
			        				<xsl:with-param name="valuta" select="tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:koopprijsSpecificatie/tia:omzetbelasting/tia:valuta" />
			        			</xsl:call-template>
			        			<xsl:text> </xsl:text>
			        			<xsl:call-template name="amountNumber">
			        				<xsl:with-param name="amount" select="tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:koopprijsSpecificatie/tia:omzetbelasting/tia:som" />
			        				<xsl:with-param name="valuta" select="tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:koopprijsSpecificatie/tia:omzetbelasting/tia:valuta" />
			        			</xsl:call-template>
			        			<xsl:text> aan omzetbelasting. De notari&#x00EB;le kosten en het kadastraal recht wegens de levering van het verkochte zijn voor rekening van </xsl:text>
			        			<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
			        			<xsl:text>.</xsl:text>
		        			</xsl:if>
		        		</p>	
		    		</xsl:when>
		    		<xsl:when test="translate(tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'exclusief omzetbelasting'">
		    			<p>
		        			<xsl:text>De koopprijs die tussen </xsl:text>
		        			<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
		        			<xsl:text> en </xsl:text>
		        			<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
		        			<xsl:text> is overeengekomen, bedraagt: </xsl:text>
		        			<xsl:call-template name="amountText">
		        				<xsl:with-param name="amount" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:transactiesom/tia:som" />
		        				<xsl:with-param name="valuta" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:transactiesom/tia:valuta" />
		        			</xsl:call-template>
		        			<xsl:text> </xsl:text>
		        			<xsl:call-template name="amountNumber">
		        				<xsl:with-param name="amount" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:transactiesom/tia:som" />
		        				<xsl:with-param name="valuta" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:transactiesom/tia:valuta" />
		        			</xsl:call-template>
		        			<xsl:text>, </xsl:text>
		        			<xsl:if test="translate(tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:koopprijsSpecificatie/tia:omzetbelastingInclusief, $upper, $lower) = 'false'"> 
			        		    <xsl:text> te vermeerderen met een bedrag van </xsl:text>
			        		    <xsl:call-template name="amountText">
			        				<xsl:with-param name="amount" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:koopprijsSpecificatie/tia:omzetbelasting/tia:som" />
			        				<xsl:with-param name="valuta" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:koopprijsSpecificatie/tia:omzetbelasting/tia:valuta" />
			        			</xsl:call-template>
			        			<xsl:text> </xsl:text>
			        			<xsl:call-template name="amountNumber">
			        				<xsl:with-param name="amount" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:koopprijsSpecificatie/tia:omzetbelasting/tia:som" />
			        				<xsl:with-param name="valuta" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:koopprijsSpecificatie/tia:omzetbelasting/tia:valuta" />
			        			</xsl:call-template>
			        			<xsl:text> aan omzetbelasting.</xsl:text>
		        			</xsl:if>
		        			<br/>
		        			<xsl:text>De koopprijs die tussen </xsl:text>
		        			<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
		        			<xsl:text> en </xsl:text>
		        			<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
		        			<xsl:text> is overeengekomen, bedraagt: </xsl:text>
		        			<xsl:call-template name="amountText">
		        				<xsl:with-param name="amount" select="tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:transactiesom/tia:som" />
		        				<xsl:with-param name="valuta" select="tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:transactiesom/tia:valuta" />
		        			</xsl:call-template>
		        			<xsl:text> </xsl:text>
		        			<xsl:call-template name="amountNumber">
		        				<xsl:with-param name="amount" select="tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:transactiesom/tia:som" />
		        				<xsl:with-param name="valuta" select="tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:transactiesom/tia:valuta" />
		        			</xsl:call-template>
		        			<xsl:text>, </xsl:text>
			        		<xsl:if test="translate(tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:koopprijsSpecificatie/tia:omzetbelastingInclusief, $upper, $lower) = 'false'"> 
			        		    <xsl:text> te vermeerderen met een bedrag van </xsl:text>
			        		    <xsl:call-template name="amountText">
			        				<xsl:with-param name="amount" select="tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:koopprijsSpecificatie/tia:omzetbelasting/tia:som" />
			        				<xsl:with-param name="valuta" select="tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:koopprijsSpecificatie/tia:omzetbelasting/tia:valuta" />
			        			</xsl:call-template>
			        			<xsl:text> </xsl:text>
			        			<xsl:call-template name="amountNumber">
			        				<xsl:with-param name="amount" select="tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:koopprijsSpecificatie/tia:omzetbelasting/tia:som" />
			        				<xsl:with-param name="valuta" select="tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:koopprijsSpecificatie/tia:omzetbelasting/tia:valuta" />
			        			</xsl:call-template>
			        			<xsl:text> aan omzetbelasting.</xsl:text>
		        			</xsl:if>
		        		</p>
		    		</xsl:when>
		    	</xsl:choose>
		    </xsl:when>
		    <xsl:otherwise>
		    	<xsl:choose>
		    		<xsl:when test="translate(tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'kaal'">
		    			<p>
		        			<xsl:text>De koopprijs van het verkochte is: </xsl:text>
		        			<xsl:call-template name="amountText">
		        				<xsl:with-param name="amount" select="tia:StukdeelKoop/tia:transactiesom/tia:som" />
		        				<xsl:with-param name="valuta" select="tia:StukdeelKoop/tia:transactiesom/tia:valuta" />
		        			</xsl:call-template>
		        			<xsl:text> </xsl:text>
		        			<xsl:call-template name="amountNumber">
		        				<xsl:with-param name="amount" select="tia:StukdeelKoop/tia:transactiesom/tia:som" />
		        				<xsl:with-param name="valuta" select="tia:StukdeelKoop/tia:transactiesom/tia:valuta" />
		        			</xsl:call-template>
		        			<xsl:text>.</xsl:text>
		        		</p>
		    		</xsl:when>
		    		<xsl:when test="translate(tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'roerende zaken exclusief'">
		    			<xsl:variable name="apos" select='"&#39;"'/>
		    			<xsl:variable name="partyText">
		    				<xsl:choose>
		    					<xsl:when test="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:koopprijsSpecificatie/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_partijkeuzekoopprijs']/tia:tekst = concat('{Stukdeelkoop/tia_Volgnummer(', $apos, '1', $apos, ') ../vervreemderRechtRef/Partij/aanduidingPartij}')">
		    						<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
		    					</xsl:when>
		    					<xsl:when test="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:koopprijsSpecificatie/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_partijkeuzekoopprijs']/tia:tekst = concat('{Stukdeelkoop/tia_Volgnummer(', $apos, '1', $apos, ') ../verkrijgerRechtRef/Partij/aanduidingPartij}')">
		    						<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
		    					</xsl:when>
		    					<xsl:when test="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:koopprijsSpecificatie/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_partijkeuzekoopprijs']/tia:tekst = concat('{Stukdeelkoop/tia_Volgnummer(', $apos, '1', $apos, ') ../verkrijgerRechtRef/Partij/aanduidingPartij} en {Stukdeelkoop/tia_Volgnummer(', $apos, '1', $apos, ') ../vervreemderRechtRef/Partij/aanduidingPartij}')">
		    						<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
		    						<xsl:text> en </xsl:text>
		    						<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
		    					</xsl:when>
		    					<xsl:when test="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:koopprijsSpecificatie/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_partijkeuzekoopprijs']/tia:tekst = concat('{Stukdeelkoop/tia_Volgnummer(', $apos, '2', $apos, ') ../verkrijgerRechtRef/Partij/aanduidingPartij}')">
		    						<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
		    					</xsl:when>
		    					<xsl:when test="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:koopprijsSpecificatie/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_partijkeuzekoopprijs']/tia:tekst = concat('{Stukdeelkoop/tia_Volgnummer(', $apos, '2', $apos, ') ../verkrijgerRechtRef/Partij/aanduidingPartij} en {Stukdeelkoop/tia_Volgnummer(', $apos, '1', $apos, ') ../vervreemderRechtRef/Partij/aanduidingPartij}')">
		    						<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '2']/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
		    						<xsl:text> en </xsl:text>
		    						<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
		    					</xsl:when>
		    				</xsl:choose>
		    			</xsl:variable>
						
		    			<p>
		    				<xsl:text>De koopprijs van het verkochte is: </xsl:text>
		        			<xsl:call-template name="amountText">
		        				<xsl:with-param name="amount" select="tia:StukdeelKoop/tia:transactiesom/tia:som" />
		        				<xsl:with-param name="valuta" select="tia:StukdeelKoop/tia:transactiesom/tia:valuta" />
		        			</xsl:call-template>
		        			<xsl:text> </xsl:text>
		        			<xsl:call-template name="amountNumber">
		        				<xsl:with-param name="amount" select="tia:StukdeelKoop/tia:transactiesom/tia:som" />
		        				<xsl:with-param name="valuta" select="tia:StukdeelKoop/tia:transactiesom/tia:valuta" />
		        			</xsl:call-template>
		        			<xsl:text>. </xsl:text>
		        			<xsl:value-of select="$partyText"/>
		        			<xsl:if test="translate(tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:koopprijsSpecificatie/tia:roerendezakenInclusief, $upper, $lower) = 'false'">
			        			<xsl:choose>
			        				<xsl:when test="contains(translate($partyText, $upper, $lower), 'en')">
			        					<xsl:text> hebben</xsl:text>
			        				</xsl:when>
			        				<xsl:otherwise>
			        					<xsl:text> heeft</xsl:text>
			        				</xsl:otherwise>
			        			</xsl:choose>
			        		    <xsl:text> aan de in het verkochte begrepen roerende zaken een waarde toegekend groot </xsl:text>
			        		    <xsl:call-template name="amountText">
			        				<xsl:with-param name="amount" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:koopprijsSpecificatie/tia:roerendezakenWaarde/tia:som" />
			        				<xsl:with-param name="valuta" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:koopprijsSpecificatie/tia:roerendezakenWaarde/tia:valuta" />
			        			</xsl:call-template>
			        			<xsl:text> </xsl:text>
			        			<xsl:call-template name="amountNumber">
			        				<xsl:with-param name="amount" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:koopprijsSpecificatie/tia:roerendezakenWaarde/tia:som" />
			        				<xsl:with-param name="valuta" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:koopprijsSpecificatie/tia:roerendezakenWaarde/tia:valuta" />
			        			</xsl:call-template>
			        			<xsl:text>. De koopprijs wordt met dit bedrag verhoogd.</xsl:text>
		        			</xsl:if>
		        		</p>
		    		</xsl:when>
		    		<xsl:when test="translate(tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'roerende zaken inclusief'">
		    			<p>
		    				<xsl:text>De koopprijs van het verkochte is: </xsl:text>
		        			<xsl:call-template name="amountText">
		        				<xsl:with-param name="amount" select="tia:StukdeelKoop/tia:transactiesom/tia:som" />
		        				<xsl:with-param name="valuta" select="tia:StukdeelKoop/tia:transactiesom/tia:valuta" />
		        			</xsl:call-template>
		        			<xsl:text> </xsl:text>
		        			<xsl:call-template name="amountNumber">
		        				<xsl:with-param name="amount" select="tia:StukdeelKoop/tia:transactiesom/tia:som" />
		        				<xsl:with-param name="valuta" select="tia:StukdeelKoop/tia:transactiesom/tia:valuta" />
		        			</xsl:call-template>
		        			<xsl:text>. </xsl:text>
		        			<xsl:if test="translate(tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:koopprijsSpecificatie/tia:roerendezakenInclusief, $upper, $lower) = 'true'">
			        		    <xsl:text>In de koopprijs is een bedrag van </xsl:text>
			        		    <xsl:call-template name="amountText">
			        				<xsl:with-param name="amount" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:koopprijsSpecificatie/tia:roerendezakenWaarde/tia:som" />
			        				<xsl:with-param name="valuta" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:koopprijsSpecificatie/tia:roerendezakenWaarde/tia:valuta" />
			        			</xsl:call-template>
			        			<xsl:text> </xsl:text>
			        			<xsl:call-template name="amountNumber">
			        				<xsl:with-param name="amount" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:koopprijsSpecificatie/tia:roerendezakenWaarde/tia:som" />
			        				<xsl:with-param name="valuta" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:koopprijsSpecificatie/tia:roerendezakenWaarde/tia:valuta" />
			        			</xsl:call-template>
			        			<xsl:text> voor roerende zaken begrepen.</xsl:text>
		        			</xsl:if>
		        		</p>
		    		</xsl:when>
		    		<xsl:when test="translate(tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'vrij op naam'">
		    			<p>
		        			<xsl:text>De koopprijs van het verkochte is: </xsl:text>
		        			<xsl:call-template name="amountText">
		        				<xsl:with-param name="amount" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:transactiesom/tia:som" />
		        				<xsl:with-param name="valuta" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:transactiesom/tia:valuta" />
		        			</xsl:call-template>
		        			<xsl:text> </xsl:text>
		        			<xsl:call-template name="amountNumber">
		        				<xsl:with-param name="amount" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:transactiesom/tia:som" />
		        				<xsl:with-param name="valuta" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:transactiesom/tia:valuta" />
		        			</xsl:call-template>
		        			<xsl:text>, </xsl:text>
		        			<xsl:if test="translate(tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:koopprijsSpecificatie/tia:omzetbelastingInclusief, $upper, $lower) = 'true'"> 
			        		    <xsl:text> inclusief een bedrag van </xsl:text>
			        		    <xsl:call-template name="amountText">
			        				<xsl:with-param name="amount" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:koopprijsSpecificatie/tia:omzetbelasting/tia:som" />
			        				<xsl:with-param name="valuta" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:koopprijsSpecificatie/tia:omzetbelasting/tia:valuta" />
			        			</xsl:call-template>
			        			<xsl:text> </xsl:text>
			        			<xsl:call-template name="amountNumber">
			        				<xsl:with-param name="amount" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:koopprijsSpecificatie/tia:omzetbelasting/tia:som" />
			        				<xsl:with-param name="valuta" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:koopprijsSpecificatie/tia:omzetbelasting/tia:valuta" />
			        			</xsl:call-template>
			        			<xsl:text> aan omzetbelasting. De notari&#x00EB;le kosten en het kadastraal recht wegens de levering van het verkochte zijn voor rekening van </xsl:text>
			        			<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:vervreemderRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
			        			<xsl:text>.</xsl:text>
		        			</xsl:if>
		        		</p>	
		    		</xsl:when>
		    		<xsl:when test="translate(tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_koopprijsvariant']/tia:tekst, $upper, $lower) = 'exclusief omzetbelasting'">
		    			<p>
		        			<xsl:text>De koopprijs van het verkochte is: </xsl:text>
		        			<xsl:call-template name="amountText">
		        				<xsl:with-param name="amount" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:transactiesom/tia:som" />
		        				<xsl:with-param name="valuta" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:transactiesom/tia:valuta" />
		        			</xsl:call-template>
		        			<xsl:text> </xsl:text>
		        			<xsl:call-template name="amountNumber">
		        				<xsl:with-param name="amount" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:transactiesom/tia:som" />
		        				<xsl:with-param name="valuta" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:transactiesom/tia:valuta" />
		        			</xsl:call-template>
		        			<xsl:text>, </xsl:text>
		        			<xsl:if test="translate(tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:koopprijsSpecificatie/tia:omzetbelastingInclusief, $upper, $lower) = 'false'"> 
			        		   <xsl:text> te vermeerderen met een bedrag van </xsl:text>
			        		    <xsl:call-template name="amountText">
			        				<xsl:with-param name="amount" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:koopprijsSpecificatie/tia:omzetbelasting/tia:som" />
			        				<xsl:with-param name="valuta" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:koopprijsSpecificatie/tia:omzetbelasting/tia:valuta" />
			        			</xsl:call-template>
			        			<xsl:text> </xsl:text>
			        			<xsl:call-template name="amountNumber">
			        				<xsl:with-param name="amount" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:koopprijsSpecificatie/tia:omzetbelasting/tia:som" />
			        				<xsl:with-param name="valuta" select="tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:koopprijsSpecificatie/tia:omzetbelasting/tia:valuta" />
			        			</xsl:call-template>
			        			<xsl:text> aan omzetbelasting.</xsl:text>
		        			</xsl:if>
		        		</p>
		    		</xsl:when>
		    	</xsl:choose>
		    </xsl:otherwise>
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
		<h2 class="header"><xsl:text>KOOPOPTIE</xsl:text></h2>
		<p>
			<xsl:call-template name="capitalizePartyAlias">
				<xsl:with-param name="party" select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoopoptie/tia:vervreemderRechtRef/@xlink:href, '#')]"/>
			</xsl:call-template>
			<xsl:text> verleent aan </xsl:text>
			<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKoopoptie/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
			<xsl:text>, die zulks voor zich aanneemt, </xsl:text>
			<xsl:if test="tia:StukdeelKoopoptie/tia:aantalJaarRechtKoop
					and normalize-space(tia:StukdeelKoopoptie/tia:aantalJaarRechtKoop) != ''
					and number(tia:StukdeelKoopoptie/tia:aantalJaarRechtKoop) > 0">
				<xsl:text>voor de tijd van </xsl:text>
				<xsl:value-of select="kef:convertNumberToText(tia:StukdeelKoopoptie/tia:aantalJaarRechtKoop)"/>
				<xsl:text> jaar te rekenen vanaf heden, </xsl:text>
			</xsl:if>
			<xsl:text>het recht om het verkochte te kopen onder de hierna vermelde voorwaarden en bedingen, tegen betaling van </xsl:text>
			<xsl:choose>
				<xsl:when test="tia:StukdeelKoopoptie/tia:bedragRechtKoop/tia:som
						and normalize-space(tia:StukdeelKoopoptie/tia:bedragRechtKoop/tia:som) != ''
						and number(tia:StukdeelKoopoptie/tia:bedragRechtKoop/tia:som) > 0">
					<xsl:call-template name="amountText">
						<xsl:with-param name="amount" select="tia:StukdeelKoopoptie/tia:bedragRechtKoop/tia:som" />
						<xsl:with-param name="valuta" select="tia:StukdeelKoopoptie/tia:bedragRechtKoop/tia:valuta" />
					</xsl:call-template>
					<xsl:text> </xsl:text>
					<xsl:call-template name="amountNumber">
						<xsl:with-param name="amount" select="tia:StukdeelKoopoptie/tia:bedragRechtKoop/tia:som" />
						<xsl:with-param name="valuta" select="tia:StukdeelKoopoptie/tia:bedragRechtKoop/tia:valuta" />
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>een koopprijs welke zal worden vastgesteld door drie deskundigen, te benoemen &#x00E9;&#x00E9;n door ieder van de ondergetekenden en de derde door de beide aldus aangewezen deskundigen samen in onderling overleg, of bij gebreke van eenstemmigheid omtrent de benoeming van deze derde deskundige, door de bevoegde rechter in wiens ressort het verkochte is gelegen op verzoek van de meest gerede partij, dan wel op een wijze als hierna nader omschreven</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text>.</xsl:text>
		</p>
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
		<h2 class="header"><xsl:text>VESTIGING ERFDIENSTBAARHEDEN</xsl:text></h2>
		<p>
			<xsl:call-template name="capitalizePartyAlias">
				<xsl:with-param name="party" select="tia:Partij[@id = substring-after(current()/tia:StukdeelErfdienstbaarheid/tia:vervreemderRechtRef/@xlink:href, '#')]"/>
			</xsl:call-template>
			<xsl:text> en </xsl:text>
			<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelErfdienstbaarheid/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
			<xsl:text> zijn overeengekomen erfdienstbaarheden te vestigen zoals hierna omschreven. Ter uitvoering van de overeenkomst worden hierbij gevestigd ten behoeve van </xsl:text>
			<xsl:if test="tia:StukdeelErfdienstbaarheid/tia:IMKAD_AantekeningKadastraalObject/tia:tenBehoeveVan/tia:IMKAD_Perceel">
				<xsl:variable name="_parcelsOnBehalfOf">
					<xsl:call-template name="groupParcels">
						<xsl:with-param name="parcels" select="tia:StukdeelErfdienstbaarheid/tia:IMKAD_AantekeningKadastraalObject/tia:tenBehoeveVan/tia:IMKAD_Perceel"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:variable name="parcelsOnBehalfOf" select="exslt:node-set($_parcelsOnBehalfOf)"/>
				<xsl:choose>
					<xsl:when test="count(tia:StukdeelErfdienstbaarheid/tia:IMKAD_AantekeningKadastraalObject/tia:tenBehoeveVan/tia:IMKAD_Perceel) > 1">
						<xsl:text>de percelen, </xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>het perceel, </xsl:text>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:for-each select="$parcelsOnBehalfOf/groups/group">
					<xsl:apply-templates select="tia:IMKAD_Perceel[1]/tia:kadastraleAanduiding" mode="do-cadastral-identification">
						<xsl:with-param name="sameObjects" select="tia:IMKAD_Perceel[position() > 1]"/>
						<xsl:with-param name="boldLabel" select="'false'"/>
						<xsl:with-param name="displayMunicipalityLabel" select="'false'"/>
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
			<xsl:if test="tia:StukdeelErfdienstbaarheid/tia:IMKAD_AantekeningKadastraalObject/tia:tenBehoeveVan/tia:IMKAD_Appartementsrecht">
				<xsl:variable name="_apartmentsOnBehalfOf">
					<xsl:call-template name="groupApartments">
						<xsl:with-param name="apartments" select="tia:StukdeelErfdienstbaarheid/tia:IMKAD_AantekeningKadastraalObject/tia:tenBehoeveVan/tia:IMKAD_Appartementsrecht"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:variable name="apartmentsOnBehalfOf" select="exslt:node-set($_apartmentsOnBehalfOf)"/>
				<xsl:choose>
					<xsl:when test="count(tia:StukdeelErfdienstbaarheid/tia:IMKAD_AantekeningKadastraalObject/tia:tenBehoeveVan/tia:IMKAD_Appartementsrecht) > 1">
						<xsl:if test="tia:StukdeelErfdienstbaarheid/tia:IMKAD_AantekeningKadastraalObject/tia:tenBehoeveVan/tia:IMKAD_Perceel">
							<xsl:text>, </xsl:text>
						</xsl:if>
						<xsl:text>de appartementsrechten, </xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:if test="tia:StukdeelErfdienstbaarheid/tia:IMKAD_AantekeningKadastraalObject/tia:tenBehoeveVan/tia:IMKAD_Perceel">
							<xsl:text> en </xsl:text>
						</xsl:if>
						<xsl:text>het appartementsrecht, </xsl:text>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:for-each select="$apartmentsOnBehalfOf/groups/group">
					<xsl:apply-templates select="tia:IMKAD_Appartementsrecht[1]/tia:kadastraleAanduiding" mode="do-cadastral-identification">
						<xsl:with-param name="sameObjects" select="tia:IMKAD_Appartementsrecht[position() > 1]"/>
						<xsl:with-param name="boldLabel" select="'false'"/>
						<xsl:with-param name="displayMunicipalityLabel" select="'false'"/>
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
			<xsl:if test="tia:StukdeelErfdienstbaarheid/tia:IMKAD_AantekeningKadastraalObject/tia:tenLasteVan/tia:IMKAD_Perceel">
				<xsl:variable name="_parcelsSubjectTo">
					<xsl:call-template name="groupParcels">
						<xsl:with-param name="parcels" select="tia:StukdeelErfdienstbaarheid/tia:IMKAD_AantekeningKadastraalObject/tia:tenLasteVan/tia:IMKAD_Perceel"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:variable name="parcelsSubjectTo" select="exslt:node-set($_parcelsSubjectTo)"/>
				<xsl:choose>
					<xsl:when test="count(tia:StukdeelErfdienstbaarheid/tia:IMKAD_AantekeningKadastraalObject/tia:tenLasteVan/tia:IMKAD_Perceel) > 1">
						<xsl:text>de percelen, </xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>het perceel, </xsl:text>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:for-each select="$parcelsSubjectTo/groups/group">
					<xsl:apply-templates select="tia:IMKAD_Perceel[1]/tia:kadastraleAanduiding" mode="do-cadastral-identification">
						<xsl:with-param name="sameObjects" select="tia:IMKAD_Perceel[position() > 1]"/>
						<xsl:with-param name="boldLabel" select="'false'"/>
						<xsl:with-param name="displayMunicipalityLabel" select="'false'"/>
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
			<xsl:if test="tia:StukdeelErfdienstbaarheid/tia:IMKAD_AantekeningKadastraalObject/tia:tenLasteVan/tia:IMKAD_Appartementsrecht">
				<xsl:variable name="_apartmentsSubjectTo">
					<xsl:call-template name="groupApartments">
						<xsl:with-param name="apartments" select="tia:StukdeelErfdienstbaarheid/tia:IMKAD_AantekeningKadastraalObject/tia:tenLasteVan/tia:IMKAD_Appartementsrecht"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:variable name="apartmentsSubjectTo" select="exslt:node-set($_apartmentsSubjectTo)"/>
				<xsl:choose>
					<xsl:when test="count(tia:StukdeelErfdienstbaarheid/tia:IMKAD_AantekeningKadastraalObject/tia:tenLasteVan/tia:IMKAD_Appartementsrecht) > 1">
						<xsl:if test="tia:StukdeelErfdienstbaarheid/tia:IMKAD_AantekeningKadastraalObject/tia:tenLasteVan/tia:IMKAD_Perceel">
							<xsl:text>, </xsl:text>
						</xsl:if>
						<xsl:text>de appartementsrechten, </xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:if test="tia:StukdeelErfdienstbaarheid/tia:IMKAD_AantekeningKadastraalObject/tia:tenLasteVan/tia:IMKAD_Perceel">
							<xsl:text> en </xsl:text>
						</xsl:if>
						<xsl:text>het appartementsrecht, </xsl:text>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:for-each select="$apartmentsSubjectTo/groups/group">
					<xsl:apply-templates select="tia:IMKAD_Appartementsrecht[1]/tia:kadastraleAanduiding" mode="do-cadastral-identification">
						<xsl:with-param name="sameObjects" select="tia:IMKAD_Appartementsrecht[position() > 1]"/>
						<xsl:with-param name="boldLabel" select="'false'"/>
						<xsl:with-param name="displayMunicipalityLabel" select="'false'"/>
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
			<xsl:value-of select="tia:StukdeelErfdienstbaarheid/tia:omschrijving"/>
			<xsl:text>.</xsl:text>
		</p>
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
		<h2 class="header"><xsl:text>VESTIGING KWALITATIEVE VERPLICHTINGEN</xsl:text></h2>
		<p>
			<xsl:call-template name="capitalizePartyAlias">
				<xsl:with-param name="party" select="tia:Partij[@id = substring-after(current()/tia:StukdeelKwalitatieveVerplichting/tia:vervreemderRechtRef/@xlink:href, '#')]"/>
			</xsl:call-template>
			<xsl:text> en </xsl:text>
			<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKwalitatieveVerplichting/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
			<xsl:text> zijn overeengekomen kwalitatieve verplichtingen te vestigen zoals hierna omschreven. Ter uitvoering van de overeenkomst worden hierbij gevestigd ten behoeve van </xsl:text>
			<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelKwalitatieveVerplichting/tia:belanghebbendeRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
			<xsl:text> en ten laste van </xsl:text>
			<xsl:if test="tia:StukdeelKwalitatieveVerplichting/tia:IMKAD_AantekeningKadastraalObject/tia:tenLasteVan/tia:IMKAD_Perceel">
				<xsl:variable name="_parcelsSubjectTo">
					<xsl:call-template name="groupParcels">
						<xsl:with-param name="parcels" select="tia:StukdeelKwalitatieveVerplichting/tia:IMKAD_AantekeningKadastraalObject/tia:tenLasteVan/tia:IMKAD_Perceel"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:variable name="parcelsSubjectTo" select="exslt:node-set($_parcelsSubjectTo)"/>
				<xsl:choose>
					<xsl:when test="count(tia:StukdeelKwalitatieveVerplichting/tia:IMKAD_AantekeningKadastraalObject/tia:tenLasteVan/tia:IMKAD_Perceel) > 1">
						<xsl:text>de percelen, </xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>het perceel, </xsl:text>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:for-each select="$parcelsSubjectTo/groups/group">
					<xsl:apply-templates select="tia:IMKAD_Perceel[1]/tia:kadastraleAanduiding" mode="do-cadastral-identification">
						<xsl:with-param name="sameObjects" select="tia:IMKAD_Perceel[position() > 1]"/>
						<xsl:with-param name="boldLabel" select="'false'"/>
						<xsl:with-param name="displayMunicipalityLabel" select="'false'"/>
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
			<xsl:if test="tia:StukdeelKwalitatieveVerplichting/tia:IMKAD_AantekeningKadastraalObject/tia:tenLasteVan/tia:IMKAD_Appartementsrecht">
				<xsl:variable name="_apartmentsSubjectTo">
					<xsl:call-template name="groupApartments">
						<xsl:with-param name="apartments" select="tia:StukdeelKwalitatieveVerplichting/tia:IMKAD_AantekeningKadastraalObject/tia:tenLasteVan/tia:IMKAD_Appartementsrecht"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:variable name="apartmentsSubjectTo" select="exslt:node-set($_apartmentsSubjectTo)"/>
				<xsl:choose>
					<xsl:when test="count(tia:StukdeelKwalitatieveVerplichting/tia:IMKAD_AantekeningKadastraalObject/tia:tenLasteVan/tia:IMKAD_Appartementsrecht) > 1">
						<xsl:if test="tia:StukdeelKwalitatieveVerplichting/tia:IMKAD_AantekeningKadastraalObject/tia:tenLasteVan/tia:IMKAD_Perceel">
							<xsl:text>, </xsl:text>
						</xsl:if>
						<xsl:text>de appartementsrechten, </xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:if test="tia:StukdeelKwalitatieveVerplichting/tia:IMKAD_AantekeningKadastraalObject/tia:tenLasteVan/tia:IMKAD_Perceel">
							<xsl:text> en </xsl:text>
						</xsl:if>
						<xsl:text>het appartementsrecht, </xsl:text>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:for-each select="$apartmentsSubjectTo/groups/group">
					<xsl:apply-templates select="tia:IMKAD_Appartementsrecht[1]/tia:kadastraleAanduiding" mode="do-cadastral-identification">
						<xsl:with-param name="sameObjects" select="tia:IMKAD_Appartementsrecht[position() > 1]"/>
						<xsl:with-param name="boldLabel" select="'false'"/>
						<xsl:with-param name="displayMunicipalityLabel" select="'false'"/>
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
			<xsl:value-of select="tia:StukdeelKwalitatieveVerplichting/tia:omschrijving"/>
			<xsl:text>.</xsl:text>
		</p>
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
	(name) 

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
		<h2 class="header"><xsl:text>BESTEMD TOT MANDELIGHEID</xsl:text></h2>
		<p>
			<xsl:call-template name="capitalizePartyAlias">
				<xsl:with-param name="party" select="tia:Partij[@id = substring-after(current()/tia:StukdeelMandeligheid/tia:vervreemderRechtRef/@xlink:href, '#')]"/>
			</xsl:call-template>
			<xsl:text> en </xsl:text>
			<xsl:value-of select="tia:Partij[@id = substring-after(current()/tia:StukdeelMandeligheid/tia:verkrijgerRechtRef/@xlink:href, '#')]/tia:aanduidingPartij"/>
			<xsl:text> zijn overeengekomen dat </xsl:text>
			<xsl:choose>
				<xsl:when test="count(tia:StukdeelMandeligheid/tia:IMKAD_AantekeningKadastraalObject/tia:tenLasteVan) &gt; 1">
					<xsl:text>de hierna te vermelden objecten worden</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>het hierna te vermelden object wordt</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text> bestemd tot gemeenschappelijk nut als bedoeld in artikel 5:60 van het Burgerlijk Wetboek ten behoeve van </xsl:text>
						
			<xsl:if test="tia:StukdeelMandeligheid/tia:IMKAD_AantekeningKadastraalObject/tia:tenBehoeveVan/tia:IMKAD_Perceel">
				<xsl:variable name="_parcelsOnBehalfOf">
					<xsl:call-template name="groupParcels">
						<xsl:with-param name="parcels" select="tia:StukdeelMandeligheid/tia:IMKAD_AantekeningKadastraalObject/tia:tenBehoeveVan/tia:IMKAD_Perceel"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:variable name="parcelsOnBehalfOf" select="exslt:node-set($_parcelsOnBehalfOf)"/>
				<xsl:choose>
					<xsl:when test="count(tia:StukdeelMandeligheid/tia:IMKAD_AantekeningKadastraalObject/tia:tenBehoeveVan/tia:IMKAD_Perceel) > 1">
						<xsl:text>de percelen, </xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>het perceel, </xsl:text>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:for-each select="$parcelsOnBehalfOf/groups/group">
					<xsl:apply-templates select="tia:IMKAD_Perceel[1]/tia:kadastraleAanduiding" mode="do-cadastral-identification">
						<xsl:with-param name="sameObjects" select="tia:IMKAD_Perceel[position() > 1]"/>
						<xsl:with-param name="boldLabel" select="'false'"/>
						<xsl:with-param name="displayMunicipalityLabel" select="'false'"/>
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
			
			<xsl:if test="tia:StukdeelMandeligheid/tia:IMKAD_AantekeningKadastraalObject/tia:tenBehoeveVan/tia:IMKAD_Appartementsrecht">
				<xsl:variable name="_apartmentsOnBehalfOf">
					<xsl:call-template name="groupApartments">
						<xsl:with-param name="apartments" select="tia:StukdeelMandeligheid/tia:IMKAD_AantekeningKadastraalObject/tia:tenBehoeveVan/tia:IMKAD_Appartementsrecht"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:variable name="apartmentsOnBehalfOf" select="exslt:node-set($_apartmentsOnBehalfOf)"/>
				<xsl:choose>
					<xsl:when test="count(tia:StukdeelMandeligheid/tia:IMKAD_AantekeningKadastraalObject/tia:tenBehoeveVan/tia:IMKAD_Appartementsrecht) > 1">
						<xsl:if test="tia:StukdeelMandeligheid/tia:IMKAD_AantekeningKadastraalObject/tia:tenBehoeveVan/tia:IMKAD_Perceel">
							<xsl:text>, </xsl:text>
						</xsl:if>
						<xsl:text>de appartementsrechten, </xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:if test="tia:StukdeelMandeligheid/tia:IMKAD_AantekeningKadastraalObject/tia:tenBehoeveVan/tia:IMKAD_Perceel">
							<xsl:text> en </xsl:text>
						</xsl:if>
						<xsl:text>het appartementsrecht, </xsl:text>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:for-each select="$apartmentsOnBehalfOf/groups/group">
					<xsl:apply-templates select="tia:IMKAD_Appartementsrecht[1]/tia:kadastraleAanduiding" mode="do-cadastral-identification">
						<xsl:with-param name="sameObjects" select="tia:IMKAD_Appartementsrecht[position() > 1]"/>
						<xsl:with-param name="boldLabel" select="'false'"/>
						<xsl:with-param name="displayMunicipalityLabel" select="'false'"/>
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
			<xsl:if test="tia:StukdeelMandeligheid/tia:IMKAD_AantekeningKadastraalObject/tia:tenLasteVan/tia:IMKAD_Perceel">
				<xsl:variable name="_parcelsSubjectTo">
					<xsl:call-template name="groupParcels">
						<xsl:with-param name="parcels" select="tia:StukdeelMandeligheid/tia:IMKAD_AantekeningKadastraalObject/tia:tenLasteVan/tia:IMKAD_Perceel"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:variable name="parcelsSubjectTo" select="exslt:node-set($_parcelsSubjectTo)"/>
				<xsl:choose>
					<xsl:when test="count(tia:StukdeelMandeligheid/tia:IMKAD_AantekeningKadastraalObject/tia:tenLasteVan/tia:IMKAD_Perceel) > 1">
						<xsl:text>de percelen, </xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>het perceel, </xsl:text>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:for-each select="$parcelsSubjectTo/groups/group">
					<xsl:apply-templates select="tia:IMKAD_Perceel[1]/tia:kadastraleAanduiding" mode="do-cadastral-identification">
						<xsl:with-param name="sameObjects" select="tia:IMKAD_Perceel[position() > 1]"/>
						<xsl:with-param name="boldLabel" select="'false'"/>
						<xsl:with-param name="displayMunicipalityLabel" select="'false'"/>
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
			
			<xsl:if test="tia:StukdeelMandeligheid/tia:IMKAD_AantekeningKadastraalObject/tia:tenLasteVan/tia:IMKAD_Appartementsrecht">
				<xsl:variable name="_apartmentsSubjectTo">
					<xsl:call-template name="groupApartments">
						<xsl:with-param name="apartments" select="tia:StukdeelMandeligheid/tia:IMKAD_AantekeningKadastraalObject/tia:tenLasteVan/tia:IMKAD_Appartementsrecht"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:variable name="apartmentsSubjectTo" select="exslt:node-set($_apartmentsSubjectTo)"/>
				<xsl:choose>
					<xsl:when test="count(tia:StukdeelMandeligheid/tia:IMKAD_AantekeningKadastraalObject/tia:tenLasteVan/tia:IMKAD_Appartementsrecht) > 1">
						<xsl:if test="tia:StukdeelMandeligheid/tia:IMKAD_AantekeningKadastraalObject/tia:tenLasteVan/tia:IMKAD_Perceel">
							<xsl:text>, </xsl:text>
						</xsl:if>
						<xsl:text>de appartementsrechten, </xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:if test="tia:StukdeelMandeligheid/tia:IMKAD_AantekeningKadastraalObject/tia:tenLasteVan/tia:IMKAD_Perceel">
							<xsl:text> en </xsl:text>
						</xsl:if>
						<xsl:text>het appartementsrecht, </xsl:text>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:for-each select="$apartmentsSubjectTo/groups/group">
					<xsl:apply-templates select="tia:IMKAD_Appartementsrecht[1]/tia:kadastraleAanduiding" mode="do-cadastral-identification">
						<xsl:with-param name="sameObjects" select="tia:IMKAD_Appartementsrecht[position() > 1]"/>
						<xsl:with-param name="boldLabel" select="'false'"/>
						<xsl:with-param name="displayMunicipalityLabel" select="'false'"/>
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
			<xsl:value-of select="tia:StukdeelMandeligheid/tia:omschrijving" />
		</p>
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
			translate(normalize-space(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_woonplaatskeuze']/tia:tekst), $upper, $lower)]), $upper, $lower)]" />
		<a name="hyp4.electionOfDomicile" class="location">&#160;</a>
		<xsl:if test="$woonplaatskeuze != ''">
			<h2 class="header"><u><xsl:text>WOONPLAATSKEUZE</xsl:text></u></h2>
			<p><xsl:value-of select="$woonplaatskeuze"/></p>
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
		
		<xsl:if test="translate(tia:StukdeelKoop[tia:tia_Volgnummer = '1']/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_energieprestatiecertificaat']/tia:tekst, $upper, $lower) = 'true'">
			<h2 class="header"><u><xsl:text>ARTIKEL 11c WONINGWET</xsl:text></u></h2>
			<p>
				<xsl:text>Ingevolge artikel 11c van de Woningwet verklaart </xsl:text>
				<xsl:value-of select="$alienatorPartyName"/>
		        <xsl:text> dat hij een geldig energieprestatiecertificaat als bedoeld in artikel 1, eerste lid, van die wet aan </xsl:text>
				<xsl:value-of select="$acquirerPartyName"/>	        	
	        	<xsl:text> heeft verstrekt.</xsl:text>
			</p>	
		</xsl:if>
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

</xsl:stylesheet>
