<?xml version="1.0" encoding="UTF-8"?>
<!--
*********************************************************
Stylesheet: notariele_verklaring.xsl
Version: 1.18
*********************************************************
Description:
Notary statement deed.

Public:
(mode) do-deed

Private:
(mode) do-parties
(mode) do-party-person
(mode) do-declaration
(mode) do-properties
(mode) do-transfer-of-title-date
(mode) do-provisions
(mode) do-civil-law-declaration
(mode) do-request-for-registration
(mode) do-election-of-domicile
(mode) do-deed-closure
-->
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
	xmlns:tia="http://www.kadaster.nl/schemas/KIK/TIA_Algemeen"
	xmlns:kef="nl.kadaster.xslt.XslExtensionFunctions"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:exslt="http://exslt.org/common"
	exclude-result-prefixes="tia kef xsl exslt"
	version="1.0">

	<xsl:include href="generiek-1.08.xsl"/>
	<xsl:include href="tekstblok_aanhef_notariele_verklaring-1.03.xsl"/>
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

	<!-- Notariele verklaring specific global variables -->
	<xsl:variable name="keuzeteksten" select="document('keuzeteksten-notariele_verklaring-1.06.xml')"/>
	<xsl:variable name="documentTitle" select="'Notariele verklaring stuk'"/>

	<!--
	*********************************************************
	Mode: do-deed
	*********************************************************
	Public: yes

	Identity transform: no

	Description: Notary statement deed.

	Input: tia:Bericht_TIA_Stuk

	Params: none

	Output: XHTML structure

	Calls:
	(mode) do-parties
	(mode) do-party-person
	(mode) do-declaration
	(mode) do-properties
	(mode) do-transfer-of-title-date
	(mode) do-provisions
	(mode) do-civil-law-declaration
	(mode) do-request-for-registration
	(mode) do-election-of-domicile
	(mode) do-deed-closure

	Called by:
	Root template
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:Bericht_TIA_Stuk" mode="do-deed">
		<xsl:variable name="koopOptie" select="tia:IMKAD_AangebodenStuk/tia:StukdeelNotarieleVerklaring/tia:soortOvereenkomst"/>
		<xsl:variable name="koopOptieText">
			<xsl:value-of select="$koopOptie"/>
			<xsl:if test="translate($koopOptie, $upper, $lower) = 'optie'">
				<xsl:text>-</xsl:text>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="party1-number-persons">
   			<xsl:choose>
    			<xsl:when test="tia:IMKAD_AangebodenStuk/tia:Partij[1]/tia:Gevolmachtigde">
     				<xsl:value-of select="number('1')"/>
    			</xsl:when>
    			<xsl:otherwise>
     				<xsl:value-of select="count(tia:IMKAD_AangebodenStuk/tia:Partij[1]/tia:IMKAD_Persoon | 
     					tia:IMKAD_AangebodenStuk/tia:Partij[1]/tia:IMKAD_Persoon/tia:GerelateerdPersoon[translate(tia:tia_IndPartij, $upper, $lower) = 'true']/tia:IMKAD_Persoon)"/>
    			</xsl:otherwise>
   			</xsl:choose>
  		</xsl:variable>
  		<xsl:variable name="party2-number-persons">
			<xsl:choose>
				<xsl:when test="tia:IMKAD_AangebodenStuk/tia:Partij[2]">
					<xsl:choose>
						<xsl:when test="tia:IMKAD_AangebodenStuk/tia:Partij[2]/tia:Gevolmachtigde">
							<xsl:value-of select="number('1')" />
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="count(tia:IMKAD_AangebodenStuk/tia:Partij[2]/tia:IMKAD_Persoon | 
								tia:IMKAD_AangebodenStuk/tia:Partij[2]/tia:IMKAD_Persoon/tia:GerelateerdPersoon[translate(tia:tia_IndPartij, $upper, $lower) = 'true']/tia:IMKAD_Persoon)" />
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="number('0')" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="total-persons" select="$party1-number-persons + $party2-number-persons" />	
		
		<!-- Text block Statement of equivalence -->
		<xsl:if test="$type-document = 'AFSCHRIFT'">
			<a name="notarystatementdeed.statementOfEquivalence" class="location">&#160;</a>
			<xsl:apply-templates select="tia:IMKAD_AangebodenStuk" mode="do-statement-of-equivalence"/>
			<!-- Two empty lines after Statement of equivalence -->
			<p><br/></p>
			<p><br/></p>
		</xsl:if>
		<a name="notarystatementdeed.header" class="location">&#160;</a>
		<!-- Notariele verklaring title -->
		<p style="text-align:center" title="without_dashes">
			<strong>
				<xsl:text>Notari&#x00EB;le verklaring </xsl:text>
				<xsl:value-of select="$koopOptieText"/>
				<xsl:text>overeenkomst</xsl:text>
			</strong>
		</p>
		<!-- Empty line after Notariele verklaring title -->
		<p title="without_dashes"><br/></p>
		<!-- Kenmerk -->
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
		<h2 class="header">
			<u>
				<xsl:text>Verklaring</xsl:text>
				<xsl:if test="$total-persons &gt; 1">
					<xsl:text> personen</xsl:text>
				</xsl:if>
				<xsl:if test="$total-persons &lt; 2">
					<xsl:text> persoon</xsl:text>
				</xsl:if>
			</u>
		</h2>
		<!-- Parties -->
		<table cellspacing="0" cellpadding="0">
			<tbody>
				<xsl:apply-templates select="tia:IMKAD_AangebodenStuk/tia:Partij" mode="do-parties"/>
			</tbody>
		</table>
		<!-- Declaration -->
		<xsl:apply-templates select="tia:IMKAD_AangebodenStuk" mode="do-declaration">
			<xsl:with-param name="koopOptie" select="$koopOptie"/>
			<xsl:with-param name="koopOptieText" select="$koopOptieText"/>
		</xsl:apply-templates>
		<!-- Properties -->
		<xsl:apply-templates select="tia:IMKAD_AangebodenStuk" mode="do-properties">
			<xsl:with-param name="koopOptie" select="$koopOptie"/>
		</xsl:apply-templates>
		<!-- Transfer of title date -->
		<xsl:apply-templates select="tia:IMKAD_AangebodenStuk" mode="do-transfer-of-title-date">
			<xsl:with-param name="koopOptie" select="$koopOptie"/>
		</xsl:apply-templates>
		<!-- Provisions -->
		<xsl:apply-templates select="tia:IMKAD_AangebodenStuk" mode="do-provisions">
			<xsl:with-param name="koopOptie" select="$koopOptie"/>
			<xsl:with-param name="koopOptieText" select="$koopOptieText"/>
		</xsl:apply-templates>
		<!-- Civil law notarial declaration -->
		<xsl:apply-templates select="tia:IMKAD_AangebodenStuk" mode="do-civil-law-declaration">
			<xsl:with-param name="koopOptie" select="$koopOptie"/>
			<xsl:with-param name="koopOptieText" select="$koopOptieText"/>
		</xsl:apply-templates>
		<!-- Registration request -->
		<xsl:apply-templates select="tia:IMKAD_AangebodenStuk" mode="do-request-for-registration">
			<xsl:with-param name="koopOptie" select="$koopOptie"/>
		</xsl:apply-templates>		
		<!--Election of domicile -->
		<xsl:apply-templates select="tia:IMKAD_AangebodenStuk" mode="do-election-of-domicile"/>
		<!-- Closure of deed -->
		<xsl:apply-templates select="tia:IMKAD_AangebodenStuk" mode="do-deed-closure"/>	
	</xsl:template>
	
	<!--
	*********************************************************
	Mode: do-parties
	*********************************************************
	Public: no

	Identity transform: no

	Description: Notary statement deed parties.

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
		<xsl:variable name="numberOfPersonsInFirstParty" select="count(../tia:Partij[1]/tia:IMKAD_Persoon)"/>
		<xsl:variable name="numberOfPersonsInSecondParty" select="count(../tia:Partij[2]/tia:IMKAD_Persoon)"/>
		<xsl:variable name="numberOfPersonPairsInFirstParty" select="count(../tia:Partij[1]/tia:IMKAD_Persoon[tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene]/tia:GerelateerdPersoon[tia:rol])"/>
		<xsl:variable name="numberOfPersonPairsInSecondParty" select="count(../tia:Partij[2]/tia:IMKAD_Persoon[tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene]/tia:GerelateerdPersoon[tia:rol])"/>
		<xsl:variable name="numberOfPersons" select="count(tia:IMKAD_Persoon)
			+ count(tia:IMKAD_Persoon/tia:GerelateerdPersoon[tia:tia_IndPartij = 'true'])"/>
		<xsl:variable name="colspan">
			<xsl:choose>
				<xsl:when test="($numberOfPersonsInFirstParty > 1 and $numberOfPersonPairsInFirstParty >= 1) or
					($numberOfPersonsInSecondParty > 1 and $numberOfPersonPairsInSecondParty >= 1)">
					<xsl:text>3</xsl:text>
				</xsl:when>
				<xsl:when test="($numberOfPersonsInFirstParty = 1 and $numberOfPersonPairsInFirstParty = 1) or
					($numberOfPersonsInSecondParty = 1 and $numberOfPersonPairsInSecondParty = 1) or
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
			<!-- If only one person pair is present do not create list -->
			<xsl:when test="tia:IMKAD_Persoon[(tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene)
						and tia:GerelateerdPersoon[tia:rol]]
					and not(count(tia:IMKAD_Persoon) > 1)">
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
				<xsl:text>hierna </xsl:text>
				<xsl:if test="$numberOfPersons > 1">
					<xsl:text>(zowel tezamen als ieder afzonderlijk) </xsl:text>
				</xsl:if>
				<xsl:text>te noemen: </xsl:text>
				<xsl:value-of select="tia:aanduidingPartij"/>
				<xsl:text>, </xsl:text>
			</td>
		</tr>
	</xsl:template>

	<!--
	*********************************************************
	Mode: do-party-person
	*********************************************************
	Public: no

	Identity transform: no

	Description: Notary statement deed party persons.

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
			<xsl:with-param name="personTerminator" select="','"/>
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
			<xsl:with-param name="personTerminator" select="','"/>
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
			<xsl:with-param name="personTerminator" select="','"/>
		</xsl:apply-templates>
	</xsl:template>
	
	<!--
	*********************************************************
	Mode: do-declaration
	*********************************************************
	Public: no

	Identity transform: no

	Description: Notary statement deed declaration.

	Input: tia:IMKAD_AangebodenStuk

	Params: koopOptie - choice between koop/optie
			koopOptieText - choice between koop/optie-

	Output: XHTML structure

	Calls: none

	Called by:
	(mode) do-deed
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_AangebodenStuk" mode="do-declaration">
		<xsl:param name="koopOptie"/>
		<xsl:param name="koopOptieText"/>
		<xsl:variable name="transcript" select="tia:StukdeelNotarieleVerklaring/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_afschriftuittreksel']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_afschriftuittreksel']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space(current()/tia:StukdeelNotarieleVerklaring/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_afschriftuittreksel']/tia:tekst), $upper, $lower)]), $upper, $lower)]" />
		<xsl:variable name="partyGender" select="tia:StukdeelNotarieleVerklaring/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_geslachtpartij']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_geslachtpartij']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space(current()/tia:StukdeelNotarieleVerklaring/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_geslachtpartij']/tia:tekst), $upper, $lower)]), $upper, $lower)]" />

		<a name="notarystatementdeed.declaration" class="location">&#160;</a>
		<p>
			<xsl:choose>
				<xsl:when test="count(tia:Partij) = 1">
					<xsl:text>verklaarde </xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>verklaarden </xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text>dat tussen </xsl:text>
			<xsl:choose>
				<xsl:when test="count(tia:Partij) = 2">
					<xsl:text>hen </xsl:text>
				</xsl:when>
				<xsl:when test="count(tia:Partij) = 1">
					<xsl:value-of select="$partyGender"/>
					<xsl:text> en </xsl:text>
					<xsl:choose>
						<xsl:when test="translate(tia:Partij/tia:aanduidingPartij, $upper, $lower) = 'koper'">
							<xsl:text>verkoper </xsl:text>
						</xsl:when>
						<xsl:when test="translate(tia:Partij/tia:aanduidingPartij, $upper, $lower) = 'verkoper'"> 
							<xsl:text>koper </xsl:text>
						</xsl:when>
						<xsl:when test="translate(tia:Partij/tia:aanduidingPartij, $upper, $lower) = 'optieverlener'">
							<xsl:text>optiegerechtigde </xsl:text>
						</xsl:when>
						<xsl:when test="translate(tia:Partij/tia:aanduidingPartij, $upper, $lower) = 'optiegerechtigde'">
							<xsl:text>optieverlener </xsl:text> 
						</xsl:when>
					</xsl:choose>
				</xsl:when>
			</xsl:choose>
			<xsl:text>een </xsl:text>
			<xsl:value-of select="$koopOptieText"/>
			<xsl:choose>
				<xsl:when test="translate($koopOptie, $upper, $lower) = 'koop'">
					<xsl:text>overeenkomst is gesloten met betrekking tot het hierna te omschrijven verkochte. Van deze </xsl:text>
					<xsl:value-of select="$koopOptieText"/>
					<xsl:text>overeenkomst blijkt uit een door verkoper en koper ondertekende onderhandse overeenkomst de dato </xsl:text>
				</xsl:when>
				<xsl:when test="translate($koopOptie, $upper, $lower) = 'optie'">
					<xsl:text>overeenkomst is gesloten met betrekking tot het hierna te omschrijven verkochte. Van deze </xsl:text>
					<xsl:value-of select="$koopOptieText"/>
					<xsl:text>overeenkomst blijkt uit een door optieverlener en optiegerechtigde ondertekende onderhandse overeenkomst de dato </xsl:text>				
				</xsl:when>
			</xsl:choose>
			<xsl:value-of select="kef:convertDateToText(tia:StukdeelNotarieleVerklaring/tia:datumOnderhandseOvereenkomst)"/>
			<xsl:text>, hierna aan te duiden met </xsl:text>
			<strong>
				<xsl:value-of select="$koopOptieText"/>
				<xsl:text>overeenkomst, </xsl:text>
			</strong>
			 <xsl:text>waarvan een </xsl:text>
			<xsl:value-of select="$transcript"/>
			<xsl:text> aan deze verklaring is gehecht.</xsl:text>
		</p>
	</xsl:template>
	
	<!--
	*********************************************************
	Mode: do-properties
	*********************************************************
	Public: no

	Identity transform: no

	Description: Notary statement deed properties.

	Input: tia:IMKAD_AangebodenStuk

	Params: koopOptie - choice between koop/optie

	Output: XHTML structure

	Calls: 
	(mode) do-right
	(mode) do-registered-object
	(mode) amountText
	(mode) amountNumber

	Called by:
	(mode) do-deed
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_AangebodenStuk" mode="do-properties">
		<xsl:param name="koopOptie"/>
		<xsl:variable name="numberOfRights" select="count(tia:StukdeelNotarieleVerklaring/tia:IMKAD_ZakelijkRecht)"/>
		<xsl:variable name="commonPrice">
			<xsl:choose>
				<xsl:when test="tia:StukdeelNotarieleVerklaring/tia:bedragKoopprijs"><xsl:text>true</xsl:text></xsl:when>
				<xsl:otherwise><xsl:text>false</xsl:text></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="_registeredObjectGroups">
			<groups xmlns="">
				<xsl:for-each select="tia:StukdeelNotarieleVerklaring/tia:IMKAD_ZakelijkRecht">
					<!-- Skip processed rights -->
					<xsl:if test="not(tia:IMKAD_Perceel and preceding-sibling::tia:IMKAD_ZakelijkRecht[
							((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen']/tia:tekst
									= current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen']/tia:tekst)
								or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen'])
									and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen'])))
							and tia:aardVerkregen = current()/tia:aardVerkregen
							and normalize-space(tia:aardVerkregen) != ''
							and ((tia:tia_Aantal_BP_Rechten
									= current()/tia:tia_Aantal_BP_Rechten)
								or (not(tia:tia_Aantal_BP_Rechten)
									and not(current()/tia:tia_Aantal_BP_Rechten)))
							and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven']/tia:tekst
									= current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven']/tia:tekst)
								or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven'])
									and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven'])))
							and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom']/tia:tekst
									= current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom']/tia:tekst)
								or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom'])
									and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom'])))
							and tia:IMKAD_Perceel[
								tia:tia_OmschrijvingEigendom
									= current()/tia:IMKAD_Perceel/tia:tia_OmschrijvingEigendom
								and normalize-space(tia:tia_OmschrijvingEigendom) != ''
								and ((tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid']/tia:tekst
										= current()/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid']/tia:tekst)
									or (not(tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid'])
										and not(current()/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid'])))
								and ((tia:tia_SplitsingsverzoekOrdernummer
										= current()/tia:IMKAD_Perceel/tia:tia_SplitsingsverzoekOrdernummer)
									or (not(tia:tia_SplitsingsverzoekOrdernummer)
										and not(current()/tia:IMKAD_Perceel/tia:tia_SplitsingsverzoekOrdernummer)))
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
								and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter
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
								and tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam
									= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam
								and normalize-space(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam) != ''
								and tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam
									= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam
								and normalize-space(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam) != '']])">
						<group xmlns="">
							<xsl:copy-of select=". | following-sibling::tia:IMKAD_ZakelijkRecht[
								((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen']/tia:tekst
										= current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen']/tia:tekst)
									or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen'])
										and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen'])))
								and tia:aardVerkregen = current()/tia:aardVerkregen
								and normalize-space(tia:aardVerkregen) != ''
								and ((tia:tia_Aantal_BP_Rechten
										= current()/tia:tia_Aantal_BP_Rechten)
									or (not(tia:tia_Aantal_BP_Rechten)
										and not(current()/tia:tia_Aantal_BP_Rechten)))
								and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven']/tia:tekst
										= current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven']/tia:tekst)
									or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven'])
										and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven'])))
								and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom']/tia:tekst
										= current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom']/tia:tekst)
									or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom'])
										and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom'])))
								and tia:IMKAD_Perceel[
									tia:tia_OmschrijvingEigendom
										= current()/tia:IMKAD_Perceel/tia:tia_OmschrijvingEigendom
									and normalize-space(tia:tia_OmschrijvingEigendom) != ''
									and ((tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid']/tia:tekst
											= current()/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid']/tia:tekst)
										or (not(tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid'])
											and not(current()/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid'])))
									and ((tia:tia_SplitsingsverzoekOrdernummer
											= current()/tia:IMKAD_Perceel/tia:tia_SplitsingsverzoekOrdernummer)
										or (not(tia:tia_SplitsingsverzoekOrdernummer)
											and not(current()/tia:IMKAD_Perceel/tia:tia_SplitsingsverzoekOrdernummer)))
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
									and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter
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
									and tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam
										= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam
									and normalize-space(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam) != ''
									and tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam
										= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam
									and normalize-space(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam) != '']]"/>
						</group>
					</xsl:if>
				</xsl:for-each>
			</groups>
		</xsl:variable>
		<xsl:variable name="registeredObjectGroups" select="exslt:node-set($_registeredObjectGroups)"/>

		<a name="notarystatementdeed.purchasePrice" class="location">&#160;</a>
		<h2 class="header"><u><xsl:text>Registergoederen</xsl:text></u></h2>
		<xsl:choose>
			<xsl:when test="$numberOfRights = 1">
				<p>
					<xsl:text>Het verkochte betreft: </xsl:text>
					<xsl:variable name="right-text">
						<xsl:apply-templates select="tia:StukdeelNotarieleVerklaring/tia:IMKAD_ZakelijkRecht" mode="do-right"/>
					</xsl:variable>
					<xsl:if test="normalize-space($right-text) != ''">
						<xsl:value-of select="$right-text"/>
						<xsl:text> </xsl:text>
					</xsl:if>
					<xsl:apply-templates select="tia:StukdeelNotarieleVerklaring/tia:IMKAD_ZakelijkRecht" mode="do-registered-object"/>
					<xsl:text>,</xsl:text>
					<xsl:if test="translate($commonPrice, $upper, $lower) = 'false'">
						<xsl:text> waarvan de koopprijs </xsl:text>
						<xsl:choose>
							<xsl:when test="translate($koopOptie, $upper, $lower) = 'koop'">
								<xsl:text>bedraagt </xsl:text>
							</xsl:when>
							<xsl:when test="translate($koopOptie, $upper, $lower) = 'optie'">
								<xsl:text>zal bedragen </xsl:text>				
							</xsl:when>
						</xsl:choose>
						<xsl:call-template name="amountText">
	        				<xsl:with-param name="amount" select="tia:StukdeelNotarieleVerklaring/tia:IMKAD_ZakelijkRecht/tia:tia_BedragKoopprijs/tia:som" />
	        				<xsl:with-param name="valuta" select="tia:StukdeelNotarieleVerklaring/tia:IMKAD_ZakelijkRecht/tia:tia_BedragKoopprijs/tia:valuta" />
	        			</xsl:call-template>
	        			<xsl:text> </xsl:text>
	        			<xsl:call-template name="amountNumber">
	        				<xsl:with-param name="amount" select="tia:StukdeelNotarieleVerklaring/tia:IMKAD_ZakelijkRecht/tia:tia_BedragKoopprijs/tia:som" />
	        				<xsl:with-param name="valuta" select="tia:StukdeelNotarieleVerklaring/tia:IMKAD_ZakelijkRecht/tia:tia_BedragKoopprijs/tia:valuta" />
	        			</xsl:call-template>
	        			<xsl:text>,</xsl:text>
	        		</xsl:if>
        			<br/>
					<xsl:text>hierna te noemen: </xsl:text>
					<strong><xsl:text>het verkochte</xsl:text></strong>
					<xsl:text>.</xsl:text>
				</p>
			</xsl:when>
			<xsl:otherwise>
				<p><xsl:text>Het verkochte betreft:</xsl:text></p>
				<table cellpadding="0" cellspacing="0">
					<tbody>
						<xsl:for-each select="$registeredObjectGroups/groups/group">
							<tr>
								<td class="number" valign="top">
									<xsl:text>-</xsl:text>
								</td>
								<td>
									<xsl:variable name="right-text">
										<xsl:apply-templates select="tia:IMKAD_ZakelijkRecht[1]" mode="do-right"/>
									</xsl:variable>
									<xsl:if test="normalize-space($right-text) != ''">
										<xsl:value-of select="$right-text"/>
										<xsl:text> </xsl:text>
									</xsl:if>
									<xsl:apply-templates select="tia:IMKAD_ZakelijkRecht[1]" mode="do-registered-object"/>
									<xsl:if test="translate($commonPrice, $upper, $lower) = 'false'">
										<xsl:text>, waarvan de koopprijs </xsl:text>
										<xsl:choose>
											<xsl:when test="translate($koopOptie, $upper, $lower) = 'koop'">
												<xsl:text>bedraagt </xsl:text>
											</xsl:when>
											<xsl:when test="translate($koopOptie, $upper, $lower) = 'optie'">
												<xsl:text>zal bedragen </xsl:text>				
											</xsl:when>
										</xsl:choose>
										<xsl:call-template name="amountText">
					        				<xsl:with-param name="amount" select="tia:IMKAD_ZakelijkRecht/tia:tia_BedragKoopprijs/tia:som" />
					        				<xsl:with-param name="valuta" select="tia:IMKAD_ZakelijkRecht/tia:tia_BedragKoopprijs/tia:valuta" />
					        			</xsl:call-template>
					        			<xsl:text> </xsl:text>
					        			<xsl:call-template name="amountNumber">
					        				<xsl:with-param name="amount" select="tia:IMKAD_ZakelijkRecht/tia:tia_BedragKoopprijs/tia:som" />
					        				<xsl:with-param name="valuta" select="tia:IMKAD_ZakelijkRecht/tia:tia_BedragKoopprijs/tia:valuta" />
					        			</xsl:call-template>
					        		</xsl:if>
									<xsl:choose>
										<xsl:when test="position() = last()">
											<xsl:text>,</xsl:text>
										</xsl:when>
										<xsl:otherwise>
											<xsl:text>;</xsl:text>
										</xsl:otherwise>
									</xsl:choose>
								</td>
							</tr>
						</xsl:for-each>
					</tbody>
				</table>
				<p>
					<xsl:text>hierna (tezamen) te noemen: </xsl:text>
					<strong><xsl:text>het verkochte</xsl:text></strong>
					<xsl:text>.</xsl:text>
				</p>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:if test="translate($commonPrice, $upper, $lower) = 'true'">
			<h2 class="header"><u><xsl:text>Koopprijs</xsl:text></u></h2>
			<p>
				<xsl:text>De </xsl:text>
				<xsl:if test="$numberOfRights > 1">
					<xsl:text>gezamenlijke </xsl:text>
				</xsl:if>
				<xsl:text>koopprijs </xsl:text>
				<xsl:choose>
					<xsl:when test="translate($koopOptie, $upper, $lower) = 'koop'">
						<xsl:text>bedraagt: </xsl:text>
					</xsl:when>
					<xsl:when test="translate($koopOptie, $upper, $lower) = 'optie'">
						<xsl:text>zal bedragen: </xsl:text>				
					</xsl:when>
				</xsl:choose>
				<xsl:call-template name="amountText">
        			<xsl:with-param name="amount" select="tia:StukdeelNotarieleVerklaring/tia:bedragKoopprijs/tia:som" />
        			<xsl:with-param name="valuta" select="tia:StukdeelNotarieleVerklaring/tia:bedragKoopprijs/tia:valuta" />
        		</xsl:call-template>
        		<xsl:text> </xsl:text>
        		<xsl:call-template name="amountNumber">
        			<xsl:with-param name="amount" select="tia:StukdeelNotarieleVerklaring/tia:bedragKoopprijs/tia:som" />
        			<xsl:with-param name="valuta" select="tia:StukdeelNotarieleVerklaring/tia:bedragKoopprijs/tia:valuta" />
        		</xsl:call-template>
        		<xsl:text>.</xsl:text>
			</p>
		</xsl:if>
	</xsl:template>
	
	<!--
	*********************************************************
	Mode: do-transfer-of-title-date
	*********************************************************
	Public: no

	Identity transform: no

	Description: Notary statement deed transfer of title date.

	Input: tia:IMKAD_AangebodenStuk

	Params: koopOptie - choice between koop/optie

	Output: XHTML structure

	Calls: none

	Called by:
	(mode) do-deed
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_AangebodenStuk" mode="do-transfer-of-title-date">
		<xsl:param name="koopOptie"/>

		<a name="notarystatementdeed.provision" class="location">&#160;</a>
		<xsl:choose>
			<xsl:when test="translate($koopOptie, $upper, $lower) = 'koop'">
				<h2 class="header"><u><xsl:text>Leveringsdatum</xsl:text></u></h2>
				<p>
					<xsl:text>Het verkochte zal door verkoper aan koper bij notari&#x00EB;le akte worden geleverd op </xsl:text>
						<xsl:value-of select="kef:convertDateToText(tia:StukdeelNotarieleVerklaring/tia:datumLevering)"/>
					<xsl:text>, dan wel zoveel eerder of later als partijen nader zullen overeenkomen.</xsl:text>
				</p>
			</xsl:when>
			<xsl:when test="translate($koopOptie, $upper, $lower) = 'optie' and tia:StukdeelNotarieleVerklaring/tia:datumLevering != ''">
				<h2 class="header"><u><xsl:text>Leveringsdatum</xsl:text></u></h2>
				<p>
					<xsl:text>Het verkochte zal door optieverlener aan optiegerechtigde bij notari&#x00EB;le akte worden geleverd op </xsl:text>
					<xsl:value-of select="kef:convertDateToText(tia:StukdeelNotarieleVerklaring/tia:datumLevering)"/>
					<xsl:text>, dan wel zoveel eerder of later als partijen nader zullen overeenkomen.</xsl:text>
				</p>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	
	<!--
	*********************************************************
	Mode: do-provisions
	*********************************************************
	Public: no

	Identity transform: no

	Description: Notary statement deed provisions.

	Input: tia:IMKAD_AangebodenStuk

	Params: koopOptie - choice between koop/optie
			koopOptieText - choice between koop/optie-

	Output: XHTML structure

	Calls: none

	Called by:
	(mode) do-deed
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_AangebodenStuk" mode="do-provisions">
		<xsl:param name="koopOptie"/>
		<xsl:param name="koopOptieText"/>
		<xsl:variable name="reflection" select="tia:StukdeelNotarieleVerklaring/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_bedenktijd']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_bedenktijd']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space(current()/tia:StukdeelNotarieleVerklaring/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_bedenktijd']/tia:tekst), $upper, $lower)]), $upper, $lower)]" />

		<xsl:if test="translate($koopOptie, $upper, $lower) = 'koop'">
			<h2 class="header"><u><xsl:text>Bedenktijd</xsl:text></u></h2>
			<xsl:if test="normalize-space($reflection) != ''">
				<p>
					<xsl:value-of select="$reflection" />
					<xsl:text>.</xsl:text>
				</p>
			</xsl:if>
		</xsl:if>
		<h2 class="header">
			<u>
				<xsl:text>Overige bepalingen </xsl:text>
				<xsl:value-of select="$koopOptieText"/>
				<xsl:text>overeenkomst</xsl:text>
			</u>
		</h2>
		<p>
			<xsl:text>Op deze </xsl:text>
			<xsl:value-of select="$koopOptieText"/>
			<xsl:text>overeenkomst zijn voorts van toepassing de bepalingen als vermeld in de </xsl:text>
			<xsl:value-of select="$koopOptieText"/>
			<xsl:text>overeenkomst.</xsl:text>
		</p>
	</xsl:template>
	
	<!--
	*********************************************************
	Mode: do-civil-law-declaration
	*********************************************************
	Public: no

	Identity transform: no

	Description: Notary statement deed civil law declaration.

	Input: tia:IMKAD_AangebodenStuk

	Params: koopOptie - choice between koop/optie
			koopOptieText - choice between koop/optie-

	Output: XHTML structure

	Calls: none

	Called by:
	(mode) do-deed
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_AangebodenStuk" mode="do-civil-law-declaration">
		<xsl:param name="koopOptie"/>
		<xsl:param name="koopOptieText"/>
		<xsl:variable name="underAgreement" select="tia:StukdeelNotarieleVerklaring/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_grondinstemming']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_grondinstemming']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space(current()/tia:StukdeelNotarieleVerklaring/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_grondinstemming']/tia:tekst), $upper, $lower)]), $upper, $lower)]" />
			
		<h2 class="header"><u><xsl:text>Notari&#x00EB;le verklaringen</xsl:text></u></h2>
		<h2 class="header"><u><xsl:text>Verklaring ex artikel 26 Kadasterwet</xsl:text></u></h2>
		<p>
			<xsl:text>De aangehechte </xsl:text>
			<xsl:value-of select="$koopOptieText"/>
			<xsl:text>overeenkomst toont genoegzaam aan dat het in te schrijven feit zich inderdaad heeft voorgedaan. </xsl:text>
		</p>
		<h2 class="header"><u><xsl:text>Artikel 37 Kadasterwet</xsl:text></u></h2>
		<p>
			<xsl:if test="normalize-space($underAgreement) != ''">
				<xsl:value-of select="$underAgreement"/>
				<xsl:text>. </xsl:text>
			</xsl:if>
			<xsl:if test="translate($koopOptie, $upper, $lower) = 'koop'">
				<br />
				<xsl:text>Ik, notaris, verklaar overeenkomstig het bepaalde in artikel 7:3 lid 6 Burgerlijk Wetboek dat het bepaalde in artikel 7:3 leden 1, 2 en 5 Burgerlijk Wetboek niet aan inschrijving van deze koopovereenkomst in de weg staat. </xsl:text>
			</xsl:if>
		</p>
	</xsl:template>
	
	<!--
	*********************************************************
	Mode: do-request-for-registration
	*********************************************************
	Public: no

	Identity transform: no

	Description: Notary statement deed registration request.

	Input: tia:IMKAD_AangebodenStuk

	Params: koopOptie - choice between koop/optie

	Output: XHTML structure

	Calls: none

	Called by:
	(mode) do-deed
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_AangebodenStuk" mode="do-request-for-registration">
		<xsl:param name="koopOptie"/>
		<xsl:variable name="requestRegistration" select="tia:StukdeelNotarieleVerklaring/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verzoekinschrijvingnamens']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verzoekinschrijvingnamens']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space(current()/tia:StukdeelNotarieleVerklaring/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verzoekinschrijvingnamens']/tia:tekst), $upper, $lower)]), $upper, $lower)]" />
		<xsl:variable name="article10" select="tia:StukdeelNotarieleVerklaring/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_artikel10']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_artikel10']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space(current()/tia:StukdeelNotarieleVerklaring/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_artikel10']/tia:tekst), $upper, $lower)]), $upper, $lower)]" />
		<xsl:variable name="groundArticle" select="tia:StukdeelNotarieleVerklaring/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_grondartikel']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_grondartikel']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space(current()/tia:StukdeelNotarieleVerklaring/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_grondartikel']/tia:tekst), $upper, $lower)]), $upper, $lower)]" />

		<h2 class="header"><u><xsl:text>Verzoek tot inschrijving</xsl:text></u></h2>
		<p>
			<xsl:text>In verband met het vorenstaande verzoek ik, notaris, namens </xsl:text>
			<xsl:value-of select="$requestRegistration" />
			<xsl:choose>
				<xsl:when test="translate($koopOptie, $upper, $lower) = 'koop'">
					<xsl:text> een afschrift van deze verklaring in de openbare registers op grond van artikel 7:3 lid 1 Burgerlijk Wetboek en in verband met artikel 3:17 lid 2 Burgerlijk Wetboek</xsl:text>
					<xsl:if test="$article10 != ''">
						<xsl:text> </xsl:text>
						<xsl:value-of select="$article10" />
					</xsl:if>
					<xsl:text>, in te schrijven.</xsl:text>
				</xsl:when>
				<xsl:when test="translate($koopOptie, $upper, $lower) = 'optie'">
					<xsl:text> een afschrift van deze verklaring in de openbare registers op grond van </xsl:text> 
					<xsl:if test="$groundArticle != ''">
						<xsl:text> </xsl:text>
						<xsl:value-of select="$groundArticle" />
					</xsl:if>
					<xsl:text>, in te schrijven.</xsl:text>
				</xsl:when>
			</xsl:choose>
		</p>
	</xsl:template>
	
	<!--
	*********************************************************
	Mode: do-election-of-domicile
	*********************************************************
	Public: no

	Identity transform: no

	Description: Notary statement deed election of domicile.

	Input: tia:IMKAD_AangebodenStuk

	Params: none

	Output: XHTML structure

	Calls: none

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
			
		<a name="notarystatementdeed.electionOfDomicile" class="location">&#160;</a>
		<xsl:if test="$woonplaatskeuze != ''">
			<h2 class="header"><u><xsl:text>Woonplaatskeuze</xsl:text></u></h2>
			<p><xsl:value-of select="$woonplaatskeuze"/></p>
		</xsl:if>
	</xsl:template>
	
	<!--
	*********************************************************
	Mode: do-deed-closure
	*********************************************************
	Public: no

	Identity transform: no

	Description: Notary statement deed closure.

	Input: tia:IMKAD_AangebodenStuk

	Params: none

	Output: XHTML structure

	Calls: none

	Called by:
	(mode) do-deed
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_AangebodenStuk" mode="do-deed-closure">
		<xsl:variable name="Signiture_Time_TIME" select="substring(string(tia:tia_TijdOndertekening), 1, 5)"/>
		<xsl:variable name="Signiture_Time_STRING">
			<xsl:if test="normalize-space($Signiture_Time_TIME) != ''">
				<xsl:value-of select="kef:convertTimeToText($Signiture_Time_TIME)"/>
			</xsl:if>
		</xsl:variable>
		
		<a name="notarystatementdeed.signature" class="location">&#160;</a>
		<h2 class="header"><u><xsl:text>Slot akte</xsl:text></u></h2>
		<p>
			<xsl:text>Deze akte is verleden te </xsl:text>
			<xsl:value-of select="tia:tia_PlaatsOndertekening/tia:woonplaatsNaam"/>
			<xsl:text> op de datum als in het hoofd van deze akte is vermeld en door mij, notaris, is ondertekend om </xsl:text>
			<xsl:value-of select="$Signiture_Time_STRING"/>
			<xsl:text> (</xsl:text>
			<xsl:value-of select="$Signiture_Time_TIME"/>
			<xsl:text> uur).</xsl:text>
		</p>
	</xsl:template>
	
</xsl:stylesheet>
