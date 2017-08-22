<?xml version="1.0" encoding="UTF-8"?>
<!--
*********************************************************
Stylesheet: hypotheek_abn_amro_generiek.xsl
Version: 1.32
*********************************************************
Description:
Common style sheet used by ABN AMRO mortgage deeds.

Public:
(mode) do-parties
(mode) do-statement-of-equivalence
(mode) do-header
(mode) do-rights
(mode) do-election-of-domicile
(mode) do-free-text

Private:
(mode) do-parties
(mode) do-party-person
-->
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
	xmlns:tia="http://www.kadaster.nl/schemas/KIK/TIA_Algemeen"
	xmlns:xlink="http://www.w3.org/1999/xlink"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	exclude-result-prefixes="tia xsl xlink"
	version="1.0">

	<xsl:include href="generiek-1.08.xsl"/>
	<xsl:include href="tekstblok_titel_hypotheekakten-1.01.xsl"/>
	<xsl:include href="tekstblok_aanhef-1.07.xsl"/>
	<xsl:include href="tekstblok_equivalentieverklaring-1.09.04.xsl"/>
	<xsl:include href="tekstblok_gevolmachtigde-1.10.xsl"/>
	<xsl:include href="tekstblok_legitimatie-1.01.xsl"/>
	<xsl:include href="tekstblok_personalia_van_natuurlijk_persoon-1.05.xsl"/>
	<xsl:include href="tekstblok_natuurlijk_persoon-1.09.xsl"/>
	<xsl:include href="tekstblok_overbruggingshypotheek-1.06.xsl"/>
	<xsl:include href="tekstblok_partij_natuurlijk_persoon-1.15.xsl"/>
	<xsl:include href="tekstblok_partij_niet_natuurlijk_persoon-1.20.xsl"/>
	<xsl:include href="tekstblok_partijnamen_in_hypotheekakten-1.05.xsl"/>
	<xsl:include href="tekstblok_recht-1.07.xsl"/>
	<xsl:include href="tekstblok_rechtspersoon-1.09.xsl"/>
	<xsl:include href="tekstblok_registergoed-1.17.xsl"/>
	<xsl:include href="tekstblok_vof_cv_ms-1.04.xsl"/>
	<xsl:include href="tekstblok_woonadres-1.05.xsl"/>
	<xsl:include href="tweededeel-1.05.xsl"/>

	<!--
	*********************************************************
	Mode: do-parties
	*********************************************************
	Public: yes

	Identity transform: no

	Description: ABN AMRO mortgage deed parties.

	Input: tia:Bericht_TIA_Stuk

	Params: name-addition - addition to the party name in case of MoneYou and Florius deeds.

	Output: XHTML structure

	Calls:
	(mode) do-parties

	Called by:
	(mode) do-deed
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:Bericht_TIA_Stuk" mode="do-parties">
		<xsl:param name="name-addition" select="''"/>
		<!-- Parties -->
		<table cellspacing="0" cellpadding="0">
			<tbody>
				<xsl:apply-templates select="tia:IMKAD_AangebodenStuk/tia:Partij" mode="do-parties">
					<xsl:with-param name="name-addition" select="$name-addition"/>
				</xsl:apply-templates>
			</tbody>
		</table>
	</xsl:template>

	<!--
	*********************************************************
	Mode: do-parties
	*********************************************************
	Public: no

	Identity transform: no

	Description: ABN AMRO mortgage deed parties.

	Input: tia:Partij

	Params: name-addition - addition to the party name in case of MoneYou and Florius deeds.

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
	<xsl:template match="tia:Partij" mode="do-parties">
		<xsl:param name="name-addition"/>
		<xsl:variable name="numberOfPersonsInFirstParty" select="count(../tia:Partij[1]/tia:IMKAD_Persoon)"/>
		<xsl:variable name="numberOfPersonsInSecondParty" select="count(../tia:Partij[2]/tia:IMKAD_Persoon)"/>
		<xsl:variable name="numberOfPersonPairsInFirstParty" select="count(../tia:Partij[1]/tia:IMKAD_Persoon[(tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene) and tia:GerelateerdPersoon[tia:rol]])"/>
		<xsl:variable name="numberOfPersonPairsInSecondParty" select="count(../tia:Partij[2]/tia:IMKAD_Persoon[(tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene) and tia:GerelateerdPersoon[tia:rol]])"/>
		<xsl:variable name="numberOfPersons" select="count(tia:IMKAD_Persoon) + count(tia:IMKAD_Persoon/tia:GerelateerdPersoon[translate(tia:tia_IndPartij, $upper, $lower) = 'true'])"/>
		<xsl:variable name="numberOfLegalPersonPairsInFirstParty" select="count(../tia:Partij[1]/tia:IMKAD_Persoon[tia:tia_Gegevens/tia:NHR_Rechtspersoon and tia:GerelateerdPersoon[tia:rol = 'volmachtgever']])"/>
		<xsl:variable name="numberOfLegalPersonPairsInSecondParty" select="count(../tia:Partij[2]/tia:IMKAD_Persoon[tia:tia_Gegevens/tia:NHR_Rechtspersoon and tia:GerelateerdPersoon[tia:rol = 'volmachtgever']])"/>
		<xsl:variable name="colspan">
			<xsl:choose>
				<xsl:when test="($numberOfPersonsInFirstParty > 1 and $numberOfPersonPairsInFirstParty >= 1) or
					($numberOfPersonsInSecondParty > 1 and $numberOfPersonPairsInSecondParty >= 1) or 
					$numberOfLegalPersonPairsInFirstParty >= 1 or $numberOfLegalPersonPairsInSecondParty >= 1">
					<xsl:text>3</xsl:text>
				</xsl:when>
				<xsl:when test="($numberOfPersonsInFirstParty = 1 and $numberOfPersonPairsInFirstParty = 1 and $numberOfLegalPersonPairsInFirstParty = 0) or
					($numberOfPersonsInSecondParty = 1 and $numberOfPersonPairsInSecondParty = 1 and $numberOfLegalPersonPairsInSecondParty = 0) or
					$numberOfPersonsInFirstParty > 1 or $numberOfPersonsInSecondParty > 1">
					<xsl:text>2</xsl:text>
				</xsl:when>
			</xsl:choose>
		</xsl:variable>
		
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
			<!-- If only one person pair, or legal person with warrantors is present - do not create list -->
			<xsl:when test="(tia:IMKAD_Persoon[(tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene) and tia:GerelateerdPersoon[tia:rol]] 
						or $numberOfLegalPersonPairsInFirstParty > 0 or $numberOfLegalPersonPairsInSecondParty > 0) and not(count(tia:IMKAD_Persoon) > 1)">
				<xsl:apply-templates select="tia:IMKAD_Persoon" mode="do-party-person">
					<xsl:with-param name="maxColspan" select="$colspan"/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:when test="count(tia:IMKAD_Persoon) = 1">
				<xsl:apply-templates select="tia:IMKAD_Persoon" mode="do-party-person">
					<xsl:with-param name="maxColspan" select="$colspan"/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:otherwise>
				<xsl:for-each select="tia:IMKAD_Persoon">
					<xsl:apply-templates select="." mode="do-party-person">
						<xsl:with-param name="maxColspan" select="$colspan"/>
					</xsl:apply-templates>
				</xsl:for-each>
			</xsl:otherwise>
		</xsl:choose>
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
				<xsl:choose>
					<xsl:when test="position() = 1">
						<xsl:if test="translate($name-addition, $upper, $lower) = 'aab' and translate(../tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_rechtsopvolgers']/tia:tekst, $upper, $lower) = 'true'">
							<xsl:value-of select="normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_rechtsopvolgers']/tia:tekst)"/>
							<xsl:text> </xsl:text>
						</xsl:if>
						<xsl:text>hierna </xsl:text>
						<xsl:text>te noemen: '</xsl:text>
						<xsl:if test="translate($name-addition, $upper, $lower) = 'moneyou'">
							<xsl:text>de </xsl:text>
						</xsl:if>
						<u><xsl:text>Bank</xsl:text></u>
						<xsl:text>'</xsl:text>
						<xsl:choose>
							<xsl:when test="translate($name-addition, $upper, $lower) = 'moneyou'">
								<xsl:text>,</xsl:text>
								<br/>
								<xsl:text>de Bank hierna verder te noemen: 'MoneYou'</xsl:text>
							</xsl:when>
							<xsl:when test="translate($name-addition, $upper, $lower) = 'florius'">
								<xsl:text>,</xsl:text>
								<br/>
								<xsl:text>de Bank hierna handelend onder de naam: 'Florius'</xsl:text>
							</xsl:when>
						</xsl:choose>
						<xsl:text>;</xsl:text>
					</xsl:when>
					<xsl:when test="position() = 2">
						<xsl:if test="@id = substring-after(../tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:vervreemderRechtRef/@xlink:href, '#')">
							<xsl:apply-templates select="." mode="do-mortgage-deed-party-name">
								<xsl:with-param name="partyNumber" select="'2'"/>
							</xsl:apply-templates>
							<xsl:text>.</xsl:text>
						</xsl:if>
					</xsl:when>
				</xsl:choose>
			</td>
		</tr>
	</xsl:template>

	<!--
	*********************************************************
	Mode: do-party-person
	*********************************************************
	Public: no

	Identity transform: no

	Description: ABN AMRO mortgage deed party persons.

	Input: tia:IMKAD_Persoon

	Params: maxColspan - maximal colspan in table

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
		
		<xsl:apply-templates select="." mode="do-party-natural-person">
			<xsl:with-param name="maxColspan" select="$maxColspan"/>
		</xsl:apply-templates>
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
	Mode: do-statement-of-equivalence
	*********************************************************
	Public: yes

	Identity transform: no

	Description: ABN AMRO mortgage deed statement of equivalence.

	Input: tia:Bericht_TIA_Stuk

	Params: none

	Output: XHTML structure

	Calls:
	(mode) do-statement-of-equivalence

	Called by:
	(mode) do-deed
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:Bericht_TIA_Stuk" mode="do-statement-of-equivalence">
		<!-- Text block Statement of equivalence -->
		<xsl:if test="translate($type-document, $upper, $lower) = 'afschrift'">
			<a name="hyp3.statementOfEquivalence" class="location">&#160;</a>
			<xsl:apply-templates select="tia:IMKAD_AangebodenStuk" mode="do-statement-of-equivalence"/>
			<!-- Two empty lines after Statement of equivalence -->
			<p><br/></p>
			<p><br/></p>
		</xsl:if>
	</xsl:template>
	
	<!--
	*********************************************************
	Mode: do-header
	*********************************************************
	Public: yes

	Identity transform: no

	Description: ABN AMRO mortgage deed header.

	Input: tia:Bericht_TIA_Stuk

	Params: none

	Output: XHTML structure

	Calls:
	(mode) do-header
	(mode) do-mortgage-deed-title

	Called by:
	(mode) do-deed
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:Bericht_TIA_Stuk" mode="do-header">
		<a name="hyp3.header" class="location">&#160;</a>
		<!-- Text block Mortgage deed title -->
		<xsl:apply-templates select="tia:IMKAD_AangebodenStuk" mode="do-mortgage-deed-title"/>
		<!-- Text block Header -->
		<xsl:apply-templates select="tia:IMKAD_AangebodenStuk" mode="do-header"/>
	</xsl:template>

	<!--
	*********************************************************
	Mode: do-rights
	*********************************************************
	Public: yes

	Identity transform: no

	Description: ABN AMRO mortgage deed rights.

	Input: tia:Bericht_TIA_Stuk

	Params: typeOfAbnAmroHypotheek - type of ABN AMRO mortgage, it could 'MoneYou', 'Florius' or 'AAB'

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
		<xsl:param name="typeOfHypotheek" select="'MoneYou'"/>
		
		<xsl:choose>
			<xsl:when test="count(tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht) = 1">
				<p>
					<xsl:variable name="rightText">
						<xsl:apply-templates select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht" mode="do-right"/>
					</xsl:variable>
					<xsl:if test="normalize-space($rightText) != ''">
						<xsl:value-of select="$rightText"/>
						<xsl:text> </xsl:text>
					</xsl:if>
					<xsl:apply-templates select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht" mode="do-registered-object"/>
					<xsl:text>;</xsl:text>
					<br/>
					<xsl:choose>
						<xsl:when test="$typeOfHypotheek = 'Florius'">
							<xsl:text>hierna te noemen: 'het </xsl:text>
							<u><xsl:text>onderpand</xsl:text></u>
							<xsl:text>'.</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>hierna te noemen het: '</xsl:text>
							<u><xsl:text>onderpand</xsl:text></u>
							<xsl:text>'.</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</p>
			</xsl:when>
			<!-- Multiple registered objects, all parcels with same data -->
			<xsl:when test="count(tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht)
					= count(tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht[
						((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen']/tia:tekst
								= current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen']/tia:tekst)
							or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen'])
								and not(current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen'])))
						and tia:aardVerkregen = current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:aardVerkregen
						and normalize-space(tia:aardVerkregen) != ''
						and ((tia:tia_Aantal_BP_Rechten
								= current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_Aantal_BP_Rechten)
							or (not(tia:tia_Aantal_BP_Rechten)
								and not(current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_Aantal_BP_Rechten)))
						and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven']/tia:tekst
								= current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven']/tia:tekst)
							or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven'])
								and not(current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven'])))
						and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom']/tia:tekst
								= current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom']/tia:tekst)
							or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom'])
								and not(current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom'])))
						and ((tia:aandeelInRecht/tia:teller	= current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:aandeelInRecht/tia:teller 
							and tia:aandeelInRecht/tia:noemer = current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:aandeelInRecht/tia:noemer)
							or (not(tia:aandeelInRecht)
								and not(current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:aandeelInRecht)))
						and tia:IMKAD_Perceel[
							tia:tia_OmschrijvingEigendom
								= current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_OmschrijvingEigendom
							and ((tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid']/tia:tekst
									= current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid']/tia:tekst)
								or (not(tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid'])
									and not(current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid'])))
							and ((tia:tia_SplitsingsverzoekOrdernummer
									= current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_SplitsingsverzoekOrdernummer)
								or (not(tia:tia_SplitsingsverzoekOrdernummer)
									and not(current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_SplitsingsverzoekOrdernummer)))
							and normalize-space(tia:tia_OmschrijvingEigendom) != ''
							and tia:kadastraleAanduiding/tia:gemeente
								= current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:kadastraleAanduiding/tia:gemeente
							and normalize-space(tia:kadastraleAanduiding/tia:gemeente) != ''
							and tia:kadastraleAanduiding/tia:sectie
								= current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:kadastraleAanduiding/tia:sectie
							and normalize-space(tia:kadastraleAanduiding/tia:sectie) != ''
							and tia:IMKAD_OZLocatie/tia:ligging
								= current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:ligging
							and normalize-space(tia:IMKAD_OZLocatie/tia:ligging) != ''
							and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer
								= current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer)
								or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer)
									and not(current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer)))
							and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter
									= current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter)
								or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter)
									and not(current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter)))
							and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging
									= current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging)
								or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging)
									and not(current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging)))
							and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode
									= current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode)
								or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode)
									and not(current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode)))
							and tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam
								= current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam
							and normalize-space(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam) != ''
							and tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam
								= current()/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam
							and normalize-space(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam) != '']])">
				<p>
					<xsl:variable name="rightText">
						<xsl:apply-templates select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht[1]" mode="do-right"/>
					</xsl:variable>
					<xsl:if test="normalize-space($rightText) != ''">
						<xsl:value-of select="$rightText"/>
						<xsl:text> </xsl:text>
					</xsl:if>
					<xsl:apply-templates select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht[1]" mode="do-registered-object"/>
					<xsl:text>;</xsl:text>
					<br/>
					<xsl:choose>
						<xsl:when test="$typeOfHypotheek = 'Florius'">
							<xsl:text>hierna zowel samen als afzonderlijk te noemen: 'het </xsl:text>
							<u><xsl:text>onderpand</xsl:text></u>
							<xsl:text>'.</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>hierna zowel samen als afzonderlijk te noemen het: '</xsl:text>
							<u><xsl:text>onderpand</xsl:text></u>
							<xsl:text>'.</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</p>
			</xsl:when>
			<xsl:otherwise>
				<table cellpadding="0" cellspacing="0">
					<tbody>
						<xsl:call-template name="processRights">
							<xsl:with-param name="positionOfProcessedRight" select="1"/>
							<xsl:with-param name="position" select="1"/>
							<xsl:with-param name="registeredObjects" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']"/>
						</xsl:call-template>
					</tbody>
				</table>
				<p>
					<xsl:choose>
						<xsl:when test="$typeOfHypotheek = 'Florius'">
							<xsl:text>hierna zowel samen als afzonderlijk te noemen: 'het </xsl:text>
							<u><xsl:text>onderpand</xsl:text></u>
							<xsl:text>'.</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>hierna zowel samen als afzonderlijk te noemen het: '</xsl:text>
							<u><xsl:text>onderpand</xsl:text></u>
							<xsl:text>'.</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</p>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--
	*********************************************************
	Mode: do-election-of-domicile
	*********************************************************
	Public: yes

	Identity transform: no

	Description: ABN AMRO mortgage deed election of domicile.

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
			translate(normalize-space(current()/tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_woonplaatskeuze']/tia:tekst), $upper, $lower)]), $upper, $lower)]" />
		<!-- Election of domicile -->
		<a name="hyp3.electionOfDomicile" class="location">&#160;</a>
		<xsl:if test="$woonplaatskeuze != ''">
			<p><u><xsl:text>Woonplaats</xsl:text></u></p>
			<p><xsl:value-of select="$woonplaatskeuze"/></p>
		</xsl:if>
	</xsl:template>
	
	<!--
	*********************************************************
	Mode: do-free-text
	*********************************************************
	Public: yes

	Identity transform: no

	Description: ABN AMRO mortgage deed free text part.

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

</xsl:stylesheet>
