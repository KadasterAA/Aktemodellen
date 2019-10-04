<?xml version="1.0" encoding="UTF-8"?>
<!--
**************************************************************
Stylesheet: tekstblok_partij_natuurlijk_persoon_doorhaling.xsl
Version: 2.0.0
**************************************************************
Description:
Party natural person text block.

Public:
(mode) do-party-natural-person

Private:
(mode) do-party-natural-person-single
(mode) do-party-natural-person-pair
(mode) do-party-natural-person-pair-variant-two
(mode) do-party-natural-person-pair-variant-three
(mode) do-party-natural-person-pair-variant-four

-->
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:tia="http://www.kadaster.nl/schemas/KIK/TIA_Algemeen" xmlns:kef="nl.kadaster.xslt.XslExtensionFunctions" xmlns:gc="http://docs.oasis-open.org/codelist/ns/genericode/1.0/" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exslt="http://exslt.org/common" xmlns:xlink="http://www.w3.org/1999/xlink" exclude-result-prefixes="tia kef gc xsl exslt xlink" version="1.0">
	<!--
	*********************************************************
	Mode: do-party-natural-person
	*********************************************************
	Public: yes

	Identity transform: no

	Description: Party natural person text block.

	Input: tia:IMKAD_Persoon

	Params: anchorName - name of the anchor that will be used in first <td> element
			numberOfColums - max. number of columns used in table
			skipPartyLetterColumn - indicator if party letter column(1) should not be printed
			partyLetter - party letter (A or B)
			skipPartyNumberColumn - indicator if party number column(2) should not be printed
			partyNumber - ordinal number of the party
			skipPersonLetterColumn - indicator if person letter column(3) should not be printed
			personLetter - ordinal letter of the person in the party
			afsluiting - Het laatste keuzeblok persoon wordt afgesloten met een ‘,’ en de andere met een ‘;’
	Output: XHTML

	Calls:
	(mode) do-party-natural-person-single
	(mode) do-party-natural-person-person-pair

	Called by:
	(mode) do-party-person
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon" mode="do-party-natural-person">
		<xsl:param name="anchorName"/>
		<xsl:param name="numberOfColums"/>
		<xsl:param name="skipPartyLetterColumn"/>
		<xsl:param name="partyLetter"/>
		<xsl:param name="skipPartyNumberColumn"/>
		<xsl:param name="partyNumber"/>
		<xsl:param name="skipPersonLetterColumn"/>
		<xsl:param name="personLetter"/>
		<xsl:param name="afsluiting"/>
		<xsl:choose>
			<xsl:when test="tia:GerelateerdPersoon">
				<xsl:apply-templates select="." mode="do-party-natural-person-pair">
					<xsl:with-param name="anchorName" select="$anchorName"/>
					<xsl:with-param name="numberOfColums" select="$numberOfColums"/>
					<xsl:with-param name="skipPartyLetterColumn" select="$skipPartyLetterColumn"/>
					<xsl:with-param name="partyLetter" select="$partyLetter"/>
					<xsl:with-param name="skipPartyNumberColumn" select="$skipPartyNumberColumn"/>
					<xsl:with-param name="partyNumber" select="$partyNumber"/>
					<xsl:with-param name="skipPersonLetterColumn" select="$skipPersonLetterColumn"/>
					<xsl:with-param name="personLetter" select="$personLetter"/>
					<xsl:with-param name="afsluiting" select="$afsluiting"/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="." mode="do-party-natural-person-single">
					<xsl:with-param name="anchorName" select="$anchorName"/>
					<xsl:with-param name="numberOfColums" select="$numberOfColums"/>
					<xsl:with-param name="skipPartyLetterColumn" select="$skipPartyLetterColumn"/>
					<xsl:with-param name="partyLetter" select="$partyLetter"/>
					<xsl:with-param name="skipPartyNumberColumn" select="$skipPartyNumberColumn"/>
					<xsl:with-param name="partyNumber" select="$partyNumber"/>
					<!-- persoonletter kolom(3) is altijd leeg bij 1-persoons partij -->
					<xsl:with-param name="skipPersonLetterColumn" select="'false'"/>
					<!-- persoonletter kolom(3) is altijd leeg bij 1-persoons partij -->
					<xsl:with-param name="personLetter" select="''"/>
					<xsl:with-param name="afsluiting" select="$afsluiting"/>
				</xsl:apply-templates>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-party-natural-person-single
	*********************************************************
	Public: no

	Identity transform: no

	Description: Party natural single person text block.

	Input: tia:IMKAD_Persoon

	Params: anchorName - name of the anchor that will be used in first <td> element
			numberOfColums - max. number of columns used in table
			skipPartyLetterColumn - indicator if party letter column(1) should not be printed
			partyLetter - party letter (A or B)
			skipPartyNumberColumn - indicator if party number column(2) should not be printed
			partyNumber - ordinal number of the party
			skipPersonLetterColumn - indicator if person letter column(3) should not be printed
			personLetter - ordinal letter of the person in the party
			afsluiting - Het laatste keuzeblok persoon wordt afgesloten met een ‘,’ en de andere met een ‘;’

	Output: XHTML

	Calls:
	(mode) do-natural-person
	(mode) do-identity-document
	(mode) do-marital-status
	(mode) do-address

	Called by:
	(mode) do-party-natural-person
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon" mode="do-party-natural-person-single">
		<xsl:param name="anchorName"/>
		<xsl:param name="numberOfColums"/>
		<xsl:param name="skipPartyLetterColumn"/>
		<xsl:param name="partyLetter"/>
		<xsl:param name="skipPartyNumberColumn"/>
		<xsl:param name="partyNumber"/>
		<xsl:param name="skipPersonLetterColumn"/>
		<xsl:param name="personLetter"/>
		<xsl:param name="afsluiting"/>
		<!-- hier de regel in de tabel van (N)NP's in de partij opbouwen: -->
		<tr>
			<!-- Partïj Letter kolom(1) -->
			<xsl:if test="$skipPartyLetterColumn = 'false'">
				<xsl:choose>
					<!-- alleen een 'A' of 'B' in deze kolom, indien het de eertse persoon in de partij is -->
					<xsl:when test="($partyNumber = 1)">
						<td class="number" valign="top">
							<a name="{$anchorName}" class="location" style="_position: relative;">&#xFEFF;</a>
							<xsl:value-of select="$partyLetter"/>
							<xsl:text>. </xsl:text>
						</td>
					</xsl:when>
					<!-- voor alle opvolgende volmachtgevers, een lege kolom i.v.m. uitlijning -->
					<xsl:otherwise>
						<td class="number" valign="top">
							<xsl:text>&#xFEFF;</xsl:text>
						</td>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
			<!-- persoon nummer kolom(2) -->
			<xsl:if test="($skipPartyNumberColumn = 'false')">
				<td class="number" valign="top">
					<xsl:number value="$partyNumber" format="1."/>
				</td>
			</xsl:if>
			<!-- Persoons Letter kolom(3) is altijd leeg bij alleen hoofdpersoon in Partij -->
			<!-- Hoofd Persoon kolom(4) -->
			<!-- bereken, welke colspan er toegepast moet worden in de laatste kolom, i.v.m. uitlijning -->
			<xsl:choose>
				<!-- afhankelijk van het aantal kolommen -->
				<xsl:when test="($numberOfColums > 2)">
					<td class="level0" colspan="2">
						<!-- TEKSTBLOK_NATUURLIJK_PERSOON -->
						<xsl:apply-templates select="." mode="do-natural-person"/>
						<xsl:text>, </xsl:text>
						<!-- optioneel: TEKSTBLOK_LEGITIMATIE -->
						<xsl:if test="tia:tia_Legitimatiebewijs">
							<xsl:apply-templates select="tia:tia_Legitimatiebewijs" mode="do-identity-document">
								<xsl:with-param name="gender" select="tia:tia_Gegevens/tia:GBA_Ingezetene/tia:geslacht/tia:geslachtsaanduiding | tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:geslacht"/>
							</xsl:apply-templates>
							<xsl:text>, </xsl:text>
						</xsl:if>
						<!-- TEKSTBLOK_BURGERLIJKE_STAAT -->
						<xsl:apply-templates select="." mode="do-marital-status"/>
						<xsl:text>, wonende te </xsl:text>
						<!-- TEKSTBLOK_WOONADRES -->
						<xsl:apply-templates select="tia:IMKAD_WoonlocatiePersoon" mode="do-address"/>
						<xsl:value-of select="$afsluiting"/>
					</td>
				</xsl:when>
				<!-- alleen colspan toepassen indien >1 (XLS-FO bug ?) -->
				<xsl:otherwise>
					<td class="level0">
						<!-- TEKSTBLOK_NATUURLIJK_PERSOON -->
						<xsl:apply-templates select="." mode="do-natural-person"/>
						<xsl:text>, </xsl:text>
						<!-- optioneel: TEKSTBLOK_LEGITIMATIE -->
						<xsl:if test="tia:tia_Legitimatiebewijs">
							<xsl:apply-templates select="tia:tia_Legitimatiebewijs" mode="do-identity-document">
								<xsl:with-param name="gender" select="tia:tia_Gegevens/tia:GBA_Ingezetene/tia:geslacht/tia:geslachtsaanduiding | tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:geslacht"/>
							</xsl:apply-templates>
							<xsl:text>, </xsl:text>
						</xsl:if>
						<!-- TEKSTBLOK_BURGERLIJKE_STAAT -->
						<xsl:apply-templates select="." mode="do-marital-status"/>
						<xsl:text>, wonende te </xsl:text>
						<!-- TEKSTBLOK_WOONADRES -->
						<xsl:apply-templates select="tia:IMKAD_WoonlocatiePersoon" mode="do-address"/>
						<xsl:value-of select="$afsluiting"/>
					</td>
				</xsl:otherwise>
			</xsl:choose>
		</tr>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-party-natural-person-pair
	*********************************************************
	Public: no

	Identity transform: no

	Description: Party natural persons pair text block.

	Input: tia:IMKAD_Persoon

	Params: anchorName - name of the anchor that will be used in first <td> element
			numberOfColums - max. number of columns used in table
			skipPartyLetterColumn - indicator if party letter column(1) should not be printed
			partyLetter - party letter (A or B)
			skipPartyNumberColumn - indicator if party number column(2) should not be printed
			partyNumber - ordinal number of the party
			skipPersonLetterColumn - indicator if person letter column(3) should not be printed
			personLetter - ordinal letter of the person in the party
			afsluiting - Het laatste keuzeblok persoon wordt afgesloten met een ‘,’ en de andere met een ‘;’

	Output: XHTML

	Calls:
	(mode) do-party-natural-person-pair-variant-two
	(mode) do-party-natural-person-pair-variant-three
	(mode) do-party-natural-person-pair-variant-four

	Called by:
	(mode) do-party-natural-person
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon" mode="do-party-natural-person-pair">
		<xsl:param name="anchorName"/>
		<xsl:param name="numberOfColums"/>
		<xsl:param name="skipPartyLetterColumn"/>
		<xsl:param name="partyLetter"/>
		<xsl:param name="skipPartyNumberColumn"/>
		<xsl:param name="partyNumber"/>
		<xsl:param name="skipPersonLetterColumn"/>
		<xsl:param name="personLetter"/>
		<xsl:param name="afsluiting"/>
		<!-- bepaal welke variant van het KEUZEBLOK_NATUURLIJK_PERSOON hier geldt -->
		<xsl:choose>
			<!-- variant 2.4.3.2 Partners met gezamenlijke burgerlijke staat en woonadres -->
			<!-- //GerelateerdPersoon[rol=partners][IndGezamenlijkeWoonlocatie=true]/IMKAD_Persoon -->
			<xsl:when test="tia:GerelateerdPersoon[(translate(substring(tia:rol, 1, 7), $upper, $lower) = 'partner') and (translate(tia:IndGezamenlijkeWoonlocatie, $upper, $lower) = 'true')]/tia:IMKAD_Persoon">
				<xsl:apply-templates select="." mode="do-party-natural-person-pair-variant-two">
					<xsl:with-param name="anchorName" select="$anchorName"/>
					<xsl:with-param name="numberOfColums" select="$numberOfColums"/>
					<xsl:with-param name="skipPartyLetterColumn" select="$skipPartyLetterColumn"/>
					<xsl:with-param name="partyLetter" select="$partyLetter"/>
					<xsl:with-param name="skipPartyNumberColumn" select="$skipPartyNumberColumn"/>
					<xsl:with-param name="partyNumber" select="$partyNumber"/>
					<xsl:with-param name="skipPersonLetterColumn" select="$skipPersonLetterColumn"/>
					<xsl:with-param name="personLetter" select="$personLetter"/>
					<xsl:with-param name="afsluiting" select="$afsluiting"/>
				</xsl:apply-templates>
			</xsl:when>
			<!-- variant 2.4.3.3 Partners met gezamenlijke burgerlijke staat en eigen woonadres -->
			<!-- //GerelateerdPersoon[rol=partners][IndGezamenlijkeWoonlocatie=false]/IMKAD_Persoon -->
			<xsl:when test="tia:GerelateerdPersoon[(translate(substring(tia:rol, 1, 7), $upper, $lower) = 'partner') and (translate(tia:IndGezamenlijkeWoonlocatie, $upper, $lower) = 'false')]/tia:IMKAD_Persoon">
				<xsl:apply-templates select="." mode="do-party-natural-person-pair-variant-three">
					<xsl:with-param name="anchorName" select="$anchorName"/>
					<xsl:with-param name="numberOfColums" select="$numberOfColums"/>
					<xsl:with-param name="skipPartyLetterColumn" select="$skipPartyLetterColumn"/>
					<xsl:with-param name="partyLetter" select="$partyLetter"/>
					<xsl:with-param name="skipPartyNumberColumn" select="$skipPartyNumberColumn"/>
					<xsl:with-param name="partyNumber" select="$partyNumber"/>
					<xsl:with-param name="skipPersonLetterColumn" select="$skipPersonLetterColumn"/>
					<xsl:with-param name="personLetter" select="$personLetter"/>
					<xsl:with-param name="afsluiting" select="$afsluiting"/>
				</xsl:apply-templates>
			</xsl:when>
			<!-- variant 2.4.3.4 Twee of meer huisgenoten met gezamenlijk adres -->
			<!-- //GerelateerdPersoon[rol=huisgenoot][IndGezamenlijkeWoonlocatie=true/IMKAD_Persoon -->
			<xsl:when test="tia:GerelateerdPersoon[(translate(tia:rol, $upper, $lower) = 'huisgenoot')]/tia:IMKAD_Persoon">
				<xsl:apply-templates select="." mode="do-party-natural-person-pair-variant-four">
					<xsl:with-param name="anchorName" select="$anchorName"/>
					<xsl:with-param name="numberOfColums" select="$numberOfColums"/>
					<xsl:with-param name="skipPartyLetterColumn" select="$skipPartyLetterColumn"/>
					<xsl:with-param name="partyLetter" select="$partyLetter"/>
					<xsl:with-param name="skipPartyNumberColumn" select="$skipPartyNumberColumn"/>
					<xsl:with-param name="partyNumber" select="$partyNumber"/>
					<xsl:with-param name="skipPersonLetterColumn" select="$skipPersonLetterColumn"/>
					<xsl:with-param name="personLetter" select="$personLetter"/>
					<xsl:with-param name="afsluiting" select="$afsluiting"/>
				</xsl:apply-templates>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-party-natural-person-pair-variant-two
	*********************************************************
	Public: no

	Identity transform: no

	Description: Party natural persons pair text block - variant 2.

	Input: tia:IMKAD_Persoon

	Params: anchorName - name of the anchor that will be used in first <td> element
			numberOfColums - max. number of columns used in table
			skipPartyLetterColumn - indicator if party letter column(1) should not be printed
			partyLetter - party letter (A or B)
			skipPartyNumberColumn - indicator if party number column(2) should not be printed
			partyNumber - ordinal number of the party
			skipPersonLetterColumn - indicator if person letter column(3) should not be printed
			personLetter - ordinal letter of the person in the party
			afsluiting - Het laatste keuzeblok persoon wordt afgesloten met een ‘,’ en de andere met een ‘;’

	Output: XHTML

	Calls:
	(mode) do-party-natural-person-pair-person-one
	(mode) do-party-natural-person-pair-person-two

	Called by:
	(mode) do-party-natural-person-pair
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon" mode="do-party-natural-person-pair-variant-two">
		<xsl:param name="anchorName"/>
		<xsl:param name="numberOfColums"/>
		<xsl:param name="skipPartyLetterColumn"/>
		<xsl:param name="partyLetter"/>
		<xsl:param name="skipPartyNumberColumn"/>
		<xsl:param name="partyNumber"/>
		<xsl:param name="skipPersonLetterColumn"/>
		<xsl:param name="personLetter"/>
		<xsl:param name="afsluiting"/>
		<!-- bepaal aantal hoofdpersonen in partij  -->
		<xsl:variable name="onlyPersonInParty">
			<xsl:choose>
				<!-- indien hoofd-persoon enige in partij -->
				<xsl:when test="(count(preceding-sibling::tia:IMKAD_Persoon) + count(following-sibling::tia:IMKAD_Persoon)) = 0">
					<xsl:text>true</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>false</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- bepaal of het gerelateerde persoons-nummer, of -letter opgehoogd moet worden -->
		<xsl:choose>
			<!-- indien hoofd-persoon enige in partij -->
			<xsl:when test="$onlyPersonInParty = 'true'">
				<!-- hier de twee regels in de tabel van NP's in de partij opbouwen: -->
				<tr>
					<!-- de eerste persoon -->
					<xsl:apply-templates select="." mode="do-party-natural-person-pair-person-one">
						<xsl:with-param name="anchorName" select="$anchorName"/>
						<xsl:with-param name="numberOfColums" select="$numberOfColums"/>
						<xsl:with-param name="skipPartyLetterColumn" select="$skipPartyLetterColumn"/>
						<xsl:with-param name="partyLetter" select="$partyLetter"/>
						<!-- partij-nummer kolom(2) wordt hier geforceerd -->
						<xsl:with-param name="skipPartyNumberColumn" select="'false'"/>
						<xsl:with-param name="partyNumber" select="$partyNumber"/>
						<!-- persoons-letter kolom(3) wordt hier onderdrukt -->
						<xsl:with-param name="skipPersonLetterColumn" select="'true'"/>
						<!--xsl:with-param name="personLetter" select="1" /-->
					</xsl:apply-templates>
				</tr>
				<tr>
					<!-- de tweede persoon -->
					<xsl:apply-templates select="." mode="do-party-natural-person-pair-person-two">
						<xsl:with-param name="anchorName" select="$anchorName"/>
						<xsl:with-param name="numberOfColums" select="$numberOfColums"/>
						<xsl:with-param name="skipPartyLetterColumn" select="$skipPartyLetterColumn"/>
						<xsl:with-param name="partyLetter" select="$partyLetter"/>
						<!-- partij-nummer kolom(2) wordt hier geforceerd -->
						<xsl:with-param name="skipPartyNumberColumn" select="'false'"/>
						<xsl:with-param name="partyNumber" select="number($partyNumber)+1"/>
						<!-- persoons-letter kolom(3) wordt hier onderdrukt -->
						<xsl:with-param name="skipPersonLetterColumn" select="'true'"/>
						<!--xsl:with-param name="personLetter" select="2" /-->
					</xsl:apply-templates>
				</tr>
				<tr>
					<!-- gez.adres-regel -->
					<xsl:if test="$skipPartyLetterColumn = 'false'">
						<!-- Partïj Letter kolom(1) -->
						<td class="number" valign="top">
							<!-- lege regel i.v.m. uitlijning -->
							<xsl:text>&#xFEFF;</xsl:text>
						</td>
					</xsl:if>
					<!-- colspan is PartyNumberColumn(2) + PersonColumn(3) -->
					<td class="level0" colspan="2">
						<!-- TEKSTBLOK_BURGERLIJKE_STAAT -->
						<xsl:apply-templates select="." mode="do-marital-status-partners"/>
						<xsl:text>, tezamen wonende te </xsl:text>
						<!-- TEKSTBLOK_WOONADRES -->
						<xsl:apply-templates select="tia:IMKAD_WoonlocatiePersoon" mode="do-address"/>
						<xsl:value-of select="$afsluiting"/>
					</td>
				</tr>
			</xsl:when>
			<!-- indien meerdere hoofd-personen in partij -->
			<xsl:otherwise>
				<!-- hier de twee regels in de tabel van NP's in de partij opbouwen: -->
				<tr>
					<!-- de eerste persoon -->
					<xsl:apply-templates select="." mode="do-party-natural-person-pair-person-one">
						<xsl:with-param name="anchorName" select="$anchorName"/>
						<xsl:with-param name="numberOfColums" select="$numberOfColums"/>
						<xsl:with-param name="skipPartyLetterColumn" select="$skipPartyLetterColumn"/>
						<xsl:with-param name="partyLetter" select="$partyLetter"/>
						<!-- partij-nummer kolom(2) wordt hier geforceerd -->
						<xsl:with-param name="skipPartyNumberColumn" select="'false'"/>
						<xsl:with-param name="partyNumber" select="$partyNumber"/>
						<!-- persoons-letter kolom(3) wordt hier geforceerd -->
						<xsl:with-param name="skipPersonLetterColumn" select="'false'"/>
						<xsl:with-param name="personLetter" select="1"/>
					</xsl:apply-templates>
				</tr>
				<tr>
					<!-- de tweede persoon -->
					<xsl:apply-templates select="." mode="do-party-natural-person-pair-person-two">
						<xsl:with-param name="anchorName" select="$anchorName"/>
						<xsl:with-param name="numberOfColums" select="$numberOfColums"/>
						<xsl:with-param name="skipPartyLetterColumn" select="$skipPartyLetterColumn"/>
						<xsl:with-param name="partyLetter" select="$partyLetter"/>
						<!-- partij-nummer kolom(2) wordt hier onderdrukt -->
						<xsl:with-param name="skipPartyNumberColumn" select="'true'"/>
						<xsl:with-param name="partyNumber" select="number($partyNumber)+1"/>
						<!-- persoons-letter kolom(3) wordt hier geforceerd -->
						<xsl:with-param name="skipPersonLetterColumn" select="'false'"/>
						<xsl:with-param name="personLetter" select="2"/>
					</xsl:apply-templates>
				</tr>
				<tr>
					<!-- gez.adres-regel -->
					<xsl:if test="$skipPartyLetterColumn = 'false'">
						<!-- Partïj Letter kolom(1) -->
						<td class="number" valign="top">
							<!-- lege regel i.v.m. uitlijning -->
							<xsl:text>&#xFEFF;</xsl:text>
						</td>
					</xsl:if>
					<!-- PartyNumberColumn(2) i.v.m. uitlijning -->
					<td class="number" valign="top">
						<!-- lege regel i.v.m. uitlijning -->
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<!-- colspan is PersonLetterColumn(3) + PersonColumn(4) -->
					<td class="level0" colspan="2">
						<!-- TEKSTBLOK_BURGERLIJKE_STAAT -->
						<xsl:apply-templates select="." mode="do-marital-status-partners"/>
						<xsl:text>, tezamen wonende te </xsl:text>
						<!-- TEKSTBLOK_WOONADRES -->
						<xsl:apply-templates select="tia:IMKAD_WoonlocatiePersoon" mode="do-address"/>
						<xsl:value-of select="$afsluiting"/>
					</td>
				</tr>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-party-natural-person-pair-variant-three
	*********************************************************
	Public: no

	Identity transform: no

	Description: Party natural persons pair text block - variant 3.

	Input: tia:IMKAD_Persoon

	Params: anchorName - name of the anchor that will be used in first <td> element
			numberOfColums - max. number of columns used in table
			skipPartyLetterColumn - indicator if party letter column(1) should not be printed
			partyLetter - party letter (A or B)
			skipPartyNumberColumn - indicator if party number column(2) should not be printed
			partyNumber - ordinal number of the party
			skipPersonLetterColumn - indicator if person letter column(3) should not be printed
			personLetter - ordinal letter of the person in the party
			afsluiting - Het laatste keuzeblok persoon wordt afgesloten met een ‘,’ en de andere met een ‘;’
	Output: XHTML

	Calls:
	(mode) do-party-natural-person-pair-v3-one
	(mode) do-party-natural-person-pair-v3-two

	Called by:
	(mode) do-party-natural-person-pair
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon" mode="do-party-natural-person-pair-variant-three">
		<xsl:param name="anchorName"/>
		<xsl:param name="numberOfColums"/>
		<xsl:param name="skipPartyLetterColumn"/>
		<xsl:param name="partyLetter"/>
		<xsl:param name="skipPartyNumberColumn"/>
		<xsl:param name="partyNumber"/>
		<xsl:param name="skipPersonLetterColumn"/>
		<xsl:param name="personLetter"/>
		<xsl:param name="afsluiting"/>
		<!-- bepaal aantal hoofdpersonen in partij  -->
		<xsl:variable name="onlyPersonInParty">
			<xsl:choose>
				<!-- indien hoofd-persoon enige in partij -->
				<xsl:when test="(count(preceding-sibling::tia:IMKAD_Persoon) + count(following-sibling::tia:IMKAD_Persoon)) = 0">
					<xsl:text>true</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>false</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- bepaal of het gerelateerde persoons-nummer, of -letter opgehoogd moet worden -->
		<xsl:choose>
			<!-- indien hoofd-persoon enige in partij -->
			<xsl:when test="$onlyPersonInParty = 'true'">
				<!-- hier de twee regels in de tabel van NP's in de partij opbouwen: -->
				<tr>
					<!-- de eerste persoon -->
					<xsl:apply-templates select="." mode="do-party-natural-person-pair-v3-one">
						<xsl:with-param name="anchorName" select="$anchorName"/>
						<xsl:with-param name="numberOfColums" select="$numberOfColums"/>
						<xsl:with-param name="skipPartyLetterColumn" select="$skipPartyLetterColumn"/>
						<xsl:with-param name="partyLetter" select="$partyLetter"/>
						<!-- partij-nummer kolom(2) wordt hier geforceerd -->
						<xsl:with-param name="skipPartyNumberColumn" select="'false'"/>
						<xsl:with-param name="partyNumber" select="$partyNumber"/>
						<!-- persoons-letter kolom(3) wordt hier onderdrukt -->
						<xsl:with-param name="skipPersonLetterColumn" select="'true'"/>
						<!--xsl:with-param name="personLetter" select="1" /-->
					</xsl:apply-templates>
				</tr>
				<tr>
					<!-- de tweede persoon -->
					<xsl:apply-templates select="." mode="do-party-natural-person-pair-v3-two">
						<xsl:with-param name="anchorName" select="$anchorName"/>
						<xsl:with-param name="numberOfColums" select="$numberOfColums"/>
						<xsl:with-param name="skipPartyLetterColumn" select="$skipPartyLetterColumn"/>
						<xsl:with-param name="partyLetter" select="$partyLetter"/>
						<!-- partij-nummer kolom(2) wordt hier geforceerd -->
						<xsl:with-param name="skipPartyNumberColumn" select="'false'"/>
						<xsl:with-param name="partyNumber" select="number($partyNumber)+1"/>
						<!-- persoons-letter kolom(3) wordt hier onderdrukt -->
						<xsl:with-param name="skipPersonLetterColumn" select="'true'"/>
						<!--xsl:with-param name="personLetter" select="2" /-->
					</xsl:apply-templates>
				</tr>
				<tr>
					<!-- gez.Burgelijke Staat regel -->
					<xsl:if test="$skipPartyLetterColumn = 'false'">
						<!-- Partïj Letter kolom(1) -->
						<td class="number" valign="top">
							<!-- lege kolom i.v.m. uitlijning -->
							<xsl:text>&#xFEFF;</xsl:text>
						</td>
					</xsl:if>
					<!-- colspan is PartyNumberColumn(2) + PersonColumn(3) -->
					<td class="level0" colspan="2">
						<!-- TEKSTBLOK_BURGERLIJKE_STAAT -->
						<xsl:apply-templates select="." mode="do-marital-status-partners"/>
						<xsl:value-of select="$afsluiting"/>
					</td>
				</tr>
			</xsl:when>
			<!-- indien meerdere hoofd-personen in partij -->
			<xsl:otherwise>
				<!-- hier de twee regels in de tabel van NP's in de partij opbouwen: -->
				<tr>
					<!-- de eerste persoon -->
					<xsl:apply-templates select="." mode="do-party-natural-person-pair-v3-one">
						<xsl:with-param name="anchorName" select="$anchorName"/>
						<xsl:with-param name="numberOfColums" select="$numberOfColums"/>
						<xsl:with-param name="skipPartyLetterColumn" select="$skipPartyLetterColumn"/>
						<xsl:with-param name="partyLetter" select="$partyLetter"/>
						<!-- partij-nummer kolom(2) wordt hier geforceerd -->
						<xsl:with-param name="skipPartyNumberColumn" select="'false'"/>
						<xsl:with-param name="partyNumber" select="$partyNumber"/>
						<!-- persoons-letter kolom(3) wordt hier geforceerd -->
						<xsl:with-param name="skipPersonLetterColumn" select="'false'"/>
						<xsl:with-param name="personLetter" select="1"/>
					</xsl:apply-templates>
				</tr>
				<tr>
					<!-- de tweede persoon -->
					<xsl:apply-templates select="." mode="do-party-natural-person-pair-v3-two">
						<xsl:with-param name="anchorName" select="$anchorName"/>
						<xsl:with-param name="numberOfColums" select="$numberOfColums"/>
						<xsl:with-param name="skipPartyLetterColumn" select="$skipPartyLetterColumn"/>
						<xsl:with-param name="partyLetter" select="$partyLetter"/>
						<!-- partij-nummer kolom(2) wordt hier onderdrukt -->
						<xsl:with-param name="skipPartyNumberColumn" select="'true'"/>
						<xsl:with-param name="partyNumber" select="number($partyNumber)+1"/>
						<!-- persoons-letter kolom(3) wordt hier geforceerd -->
						<xsl:with-param name="skipPersonLetterColumn" select="'false'"/>
						<xsl:with-param name="personLetter" select="2"/>
					</xsl:apply-templates>
				</tr>
				<tr>
					<!-- gez.adres-regel -->
					<xsl:if test="$skipPartyLetterColumn = 'false'">
						<!-- Partïj Letter kolom(1) -->
						<td class="number" valign="top">
							<!-- lege regel i.v.m. uitlijning -->
							<xsl:text>&#xFEFF;</xsl:text>
						</td>
					</xsl:if>
					<!-- PartyNumberColumn(2) i.v.m. uitlijning -->
					<td class="number" valign="top">
						<!-- lege regel i.v.m. uitlijning -->
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<!-- colspan is PersonLetterColumn(3) + PersonColumn(4) -->
					<td class="level0" colspan="2">
						<!-- TEKSTBLOK_BURGERLIJKE_STAAT -->
						<xsl:apply-templates select="." mode="do-marital-status-partners"/>
						<xsl:value-of select="$afsluiting"/>
					</td>
				</tr>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--
	***********************************************
	Mode: do-party-natural-person-pair-variant-four
	***********************************************
	Public: no

	Identity transform: no

	Description: Party natural persons pair text block - variant 4.

	Input: tia:IMKAD_Persoon

	Params: anchorName - name of the anchor that will be used in first <td> element
			numberOfColums - max. number of columns used in table
			skipPartyLetterColumn - indicator if party letter column(1) should not be printed
			partyLetter - party letter (A or B)
			skipPartyNumberColumn - indicator if party number column(2) should not be printed
			partyNumber - ordinal number of the party
			skipPersonLetterColumn - indicator if person letter column(3) should not be printed
			personLetter - ordinal letter of the person in the party
			afsluiting - Het laatste keuzeblok persoon wordt afgesloten met een ‘,’ en de andere met een ‘;’
	Output: XHTML

	Calls:
	(mode) do-party-natural-person-pair-v4-one
	(mode) do-party-natural-person-pair-v4-next

	Called by:
	(mode) do-party-natural-person-pair
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon" mode="do-party-natural-person-pair-variant-four">
		<xsl:param name="anchorName"/>
		<xsl:param name="numberOfColums"/>
		<xsl:param name="skipPartyLetterColumn"/>
		<xsl:param name="partyLetter"/>
		<xsl:param name="skipPartyNumberColumn"/>
		<xsl:param name="partyNumber"/>
		<xsl:param name="skipPersonLetterColumn"/>
		<xsl:param name="personLetter"/>
		<xsl:param name="afsluiting"/>
		<!-- bepaal aantal hoofdpersonen in partij  -->
		<xsl:variable name="onlyPersonInParty">
			<xsl:choose>
				<!-- indien hoofd-persoon enige in partij -->
				<xsl:when test="(count(preceding-sibling::tia:IMKAD_Persoon) + count(following-sibling::tia:IMKAD_Persoon)) = 0">
					<xsl:text>true</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>false</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- bepaal of het partij-nummer opgehoogd moet worden -->
		<xsl:variable name="_skipPartyNumberColumn">
			<xsl:choose>
				<!-- indien hoofd-persoon enige in partij -->
				<xsl:when test="$onlyPersonInParty = 'true'">
					<!-- partij-nummer kolom(2) wordt geforceerd -->
					<xsl:text>false</xsl:text>
				</xsl:when>
				<!-- indien meerdere hoofd-personen in partij -->
				<xsl:otherwise>
					<!-- partij-nummer kolom(2) wordt onderdrukt -->
					<xsl:text>true</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- bepaal of het gerelateerde persoons-nummer opgehoogd moet worden -->
		<xsl:variable name="_skipPersonLetterColumn">
			<xsl:choose>
				<!-- indien hoofd-persoon enige in partij -->
				<xsl:when test="$onlyPersonInParty = 'true'">
					<!-- persoons-letter kolom(3) wordt onderdrukt -->
					<xsl:text>true</xsl:text>
				</xsl:when>
				<!-- indien meerdere hoofd-personen in partij -->
				<xsl:otherwise>
					<!-- persoons-letter kolom(3) wordt geforceerd -->
					<xsl:text>false</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- hier de eerste regel (de hoofdpersoon) in de tabel van NP's in de partij opbouwen: -->
		<tr>
			<xsl:apply-templates select="." mode="do-party-natural-person-pair-v4-one">
				<xsl:with-param name="anchorName" select="$anchorName"/>
				<xsl:with-param name="numberOfColums" select="$numberOfColums"/>
				<xsl:with-param name="skipPartyLetterColumn" select="$skipPartyLetterColumn"/>
				<xsl:with-param name="partyLetter" select="$partyLetter"/>
				<!-- eerste regel (de hoofdpersoon) heeft in variant 4 altijd partij-numer -->
				<xsl:with-param name="skipPartyNumberColumn" select="'false'"/>
				<xsl:with-param name="partyNumber" select="$partyNumber"/>
				<xsl:with-param name="skipPersonLetterColumn" select="$_skipPersonLetterColumn"/>
				<!-- persoons-letter bij de hoofd persoon begint altijd bij A (dus=1) -->
				<xsl:with-param name="personLetter" select="1"/>
			</xsl:apply-templates>
		</tr>
		<!-- voor iedere gerelateerd Persoon (huisgenoot) een regel -->
		<xsl:for-each select="tia:GerelateerdPersoon">
			<!-- bepaal het volgnummer v/d gerelaarde persoon -->
			<xsl:variable name="_relPersonNumber" select="count(preceding-sibling::tia:GerelateerdPersoon) + 1"/>
			<tr>
				<!-- de tweede persoon -->
				<xsl:apply-templates select="tia:IMKAD_Persoon" mode="do-party-natural-person-pair-v4-next">
					<xsl:with-param name="anchorName" select="$anchorName"/>
					<xsl:with-param name="numberOfColums" select="$numberOfColums"/>
					<xsl:with-param name="skipPartyLetterColumn" select="$skipPartyLetterColumn"/>
					<xsl:with-param name="partyLetter" select="$partyLetter"/>
					<xsl:with-param name="skipPartyNumberColumn" select="$_skipPartyNumberColumn"/>
					<xsl:with-param name="partyNumber" select="number($_relPersonNumber)+1"/>
					<xsl:with-param name="skipPersonLetterColumn" select="$_skipPersonLetterColumn"/>
					<xsl:with-param name="personLetter" select="number($_relPersonNumber)+1"/>
				</xsl:apply-templates>
			</tr>
		</xsl:for-each>
		<!-- gezamelijk woonadres regel -->
		<tr>
			<xsl:if test="$skipPartyLetterColumn = 'false'">
				<!-- Partïj Letter kolom(1) -->
				<td class="number" valign="top">
					<!-- lege regel i.v.m. uitlijning -->
					<xsl:text>&#xFEFF;</xsl:text>
				</td>
			</xsl:if>
			<xsl:if test="$_skipPersonLetterColumn = 'false'">
				<!-- PartyNumberColumn(2) -->
				<td class="number" valign="top">
					<!-- lege regel i.v.m. uitlijning -->
					<xsl:text>&#xFEFF;</xsl:text>
				</td>
			</xsl:if>
			<!-- Woonadres kolom -->
			<!-- colspan is altijd over de laatste twee kolommen: (PartyNumberColumn(2) of PersonLetterColumn(3)) + PersonColumn(4) -->
			<td class="level0" colspan="2">
				<xsl:text>tezamen wonende te </xsl:text>
				<!-- TEKSTBLOK_WOONADRES -->
				<xsl:apply-templates select="tia:IMKAD_WoonlocatiePersoon" mode="do-address"/>
				<xsl:value-of select="$afsluiting"/>
			</td>
		</tr>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-party-natural-person-pair-person-one
	*********************************************************
	Public: no

	Identity transform: no

	Description: first person in Party natural persons pair - variant 2.

	Input: tia:IMKAD_Persoon

	Params: anchorName - name of the anchor that will be used in first <td> element
			numberOfColums - max. number of columns used in table
			skipPartyLetterColumn - indicator if party letter column(1) should not be printed
			partyLetter - party letter (A or B)
			skipPartyNumberColumn - indicator if party number column(2) should not be printed
			partyNumber - ordinal number of the party
			skipPersonLetterColumn - indicator if person letter column(3) should not be printed
			personLetter - ordinal letter of the person in the party

	Output: XHTML

	Calls:
	(mode) do-natural-person
	(mode) do-identity-document

	Called by:
	(mode) do-party-natural-person-pair-variant-two
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon" mode="do-party-natural-person-pair-person-one">
		<xsl:param name="anchorName"/>
		<xsl:param name="numberOfColums"/>
		<xsl:param name="skipPartyLetterColumn"/>
		<xsl:param name="partyLetter"/>
		<xsl:param name="skipPartyNumberColumn"/>
		<xsl:param name="partyNumber"/>
		<xsl:param name="skipPersonLetterColumn"/>
		<xsl:param name="personLetter"/>
		<!-- Partïj Letter kolom(1) -->
		<xsl:if test="$skipPartyLetterColumn = 'false'">
			<td class="number" valign="top">
				<xsl:choose>
					<!-- alleen een 'A' of 'B' in deze kolom, indien het de eertse persoon in de partij is -->
					<xsl:when test="($partyNumber = 1)">
						<a name="{$anchorName}" class="location" style="_position: relative;">&#xFEFF;</a>
						<xsl:value-of select="$partyLetter"/>
						<xsl:text>. </xsl:text>
					</xsl:when>
					<!-- voor alle opvolgende volmachtgevers, een lege kolom i.v.m. uitlijning -->
					<xsl:otherwise>
						<xsl:text>&#xFEFF;</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</td>
		</xsl:if>
		<!-- persoon nummer kolom(2); deze is nooit leeg, bij hoofdpersoon gerelateerd stel -->
		<td class="number" valign="top">
			<xsl:choose>
				<xsl:when test="$numberOfRechthebbendeParties = '1' and $numberOfColums = '3'">
					<xsl:number value="$partyNumber" format="a."/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:number value="$partyNumber" format="1."/>
				</xsl:otherwise>
			</xsl:choose>
		</td>
		<!-- gerelateerde persoons-letter kolom(3) -->
		<!-- scenario 4b.
			als de partij meer dan 2 personen bevat, waaronder aan elkaar gerelateerde personen, dan worden deze gerelateerde personen samen genummerd;
			de eerste persoon met een opvolgend cijfer gevolgd door een letter (1.a) en
			de tweede (en volgende) perso(o)n(en) alleen met een opvolgende letter (b., c., d. enz).
		-->
		<xsl:if test="($skipPersonLetterColumn = 'false')">
			<td class="number" valign="top">
				<xsl:number value="$personLetter" format="a."/>
			</td>
		</xsl:if>
		<!-- (hoofd)persoon kolom(4) -->
		<xsl:choose>
			<!-- bereken, welke colspan er toegepast moet worden in de laatste kolom, i.v.m. uitlijning -->
			<xsl:when test="($skipPartyLetterColumn = 'true') and ($numberOfColums > 2) and ($skipPersonLetterColumn = 'true')">
				<!-- afhankelijk van het aantal kolommen -->
				<td class="level0" colspan="2">
					<!-- TEKSTBLOK_NATUURLIJK_PERSOON -->
					<xsl:apply-templates select="." mode="do-natural-person"/>
					<xsl:text>, </xsl:text>
					<!-- TEKSTBLOK_LEGITIMATIE -->
					<xsl:if test="tia:tia_Legitimatiebewijs">
						<xsl:apply-templates select="tia:tia_Legitimatiebewijs" mode="do-identity-document">
							<xsl:with-param name="gender" select="tia:tia_Gegevens/tia:GBA_Ingezetene/tia:geslacht/tia:geslachtsaanduiding | tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:geslacht"/>
						</xsl:apply-templates>
						<xsl:text>, </xsl:text>
					</xsl:if>
					<xsl:text>en</xsl:text>
				</td>
			</xsl:when>
			<!-- indien anders -->
			<xsl:otherwise>
				<!-- alleen colspan toepassen indien >1 (XLS-FO bug ?) -->
				<td class="level0">
					<!-- TEKSTBLOK_NATUURLIJK_PERSOON -->
					<xsl:apply-templates select="." mode="do-natural-person"/>
					<xsl:text>, </xsl:text>
					<!-- TEKSTBLOK_LEGITIMATIE -->
					<xsl:if test="tia:tia_Legitimatiebewijs">
						<xsl:apply-templates select="tia:tia_Legitimatiebewijs" mode="do-identity-document">
							<xsl:with-param name="gender" select="tia:tia_Gegevens/tia:GBA_Ingezetene/tia:geslacht/tia:geslachtsaanduiding | tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:geslacht"/>
						</xsl:apply-templates>
						<xsl:text>, </xsl:text>
					</xsl:if>
					<xsl:text>en</xsl:text>
				</td>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-party-natural-person-pair-person-two
	*********************************************************
	Public: no

	Identity transform: no

	Description: second person in Party natural persons pair - variant 2.

	Input: tia:IMKAD_Persoon

	Params: anchorName - name of the anchor that will be used in first <td> element
			numberOfColums - max. number of columns used in table
			skipPartyLetterColumn - indicator if party letter column(1) should not be printed
			partyLetter - party letter (A or B)
			skipPartyNumberColumn - indicator if party number column(2) should not be printed
			partyNumber - ordinal number of the party
			skipPersonLetterColumn - indicator if person letter column(3) should not be printed
			personLetter - ordinal letter of the person in the party

	Output: XHTML

	Calls:
	(mode) do-natural-person
	(mode) do-identity-document
	(mode) do-marital-status
	(mode) do-address

	Called by:
	(mode) do-party-natural-person-pair-variant-two
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon" mode="do-party-natural-person-pair-person-two">
		<xsl:param name="anchorName"/>
		<xsl:param name="numberOfColums"/>
		<xsl:param name="skipPartyLetterColumn"/>
		<xsl:param name="partyLetter"/>
		<xsl:param name="skipPartyNumberColumn"/>
		<xsl:param name="partyNumber"/>
		<xsl:param name="skipPersonLetterColumn"/>
		<xsl:param name="personLetter"/>
		<!-- Partïj Letter kolom(1) -->
		<xsl:if test="$skipPartyLetterColumn = 'false'">
			<td class="number" valign="top">
				<xsl:choose>
					<!-- alleen een 'A' of 'B' in deze kolom, indien het de eertse persoon in de partij is -->
					<xsl:when test="($partyNumber = 1)">
						<a name="{$anchorName}" class="location" style="_position: relative;">&#xFEFF;</a>
						<xsl:value-of select="$partyLetter"/>
						<xsl:text>. </xsl:text>
					</xsl:when>
					<!-- voor alle opvolgende volmachtgevers, een lege kolom i.v.m. uitlijning -->
					<xsl:otherwise>
						<xsl:text>&#xFEFF;</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</td>
		</xsl:if>
		<!-- persoon nummer kolom(2) -->
		<xsl:choose>
			<xsl:when test="($skipPartyNumberColumn = 'false')">
				<xsl:choose>
					<xsl:when test="$numberOfRechthebbendeParties = '1' and $numberOfColums = '3'">
						<td class="number" valign="top">
							<xsl:number value="$partyNumber" format="a."/>
						</td>
					</xsl:when>
					<xsl:otherwise>
						<td class="number" valign="top">
							<xsl:number value="$partyNumber" format="1."/>
						</td>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<!-- lege kolom i.v.m. uitlijning -->
				<td class="number" valign="top">
					<xsl:text>&#xFEFF;</xsl:text>
				</td>
			</xsl:otherwise>
		</xsl:choose>
		<!-- gerelateerde persoons-letter kolom(3) -->
		<!-- scenario 4b.
			als de partij meer dan 2 personen bevat, waaronder aan elkaar gerelateerde personen, dan worden deze gerelateerde personen samen genummerd;
			de eerste persoon met een opvolgend cijfer gevolgd door een letter (1.a) en
			de tweede (en volgende) perso(o)n(en) alleen met een opvolgende letter (b., c., d. enz).
		-->
		<xsl:if test="($skipPersonLetterColumn = 'false')">
			<td class="number" valign="top">
				<xsl:number value="$personLetter" format="a."/>
			</td>
		</xsl:if>
		<!-- Gerelateerde NP kolom(4) -->
		<xsl:choose>
			<!-- bereken, welke colspan er toegepast moet worden in de laatste kolom, i.v.m. uitlijning -->
			<xsl:when test="($skipPartyLetterColumn = 'true') and ($numberOfColums > 2) and ($skipPersonLetterColumn = 'true')">
				<!-- afhankelijk van het aantal kolommen -->
				<td class="level0" colspan="2">
					<!-- TEKSTBLOK_NATUURLIJK_PERSOON -->
					<xsl:apply-templates select="tia:GerelateerdPersoon/tia:IMKAD_Persoon" mode="do-natural-person"/>
					<xsl:text>, </xsl:text>
					<!-- TEKSTBLOK_LEGITIMATIE -->
					<xsl:if test="tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:tia_Legitimatiebewijs">
						<xsl:apply-templates select="tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:tia_Legitimatiebewijs" mode="do-identity-document">
							<xsl:with-param name="gender" select="tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:tia_Gegevens/tia:GBA_Ingezetene/tia:geslacht/tia:geslachtsaanduiding | tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:geslacht"/>
						</xsl:apply-templates>
						<xsl:text>, </xsl:text>
					</xsl:if>
				</td>
			</xsl:when>
			<!-- indien anders -->
			<xsl:otherwise>
				<!-- alleen colspan toepassen indien >1 (XLS-FO bug ?) -->
				<td class="level0">
					<!-- TEKSTBLOK_NATUURLIJK_PERSOON -->
					<xsl:apply-templates select="tia:GerelateerdPersoon/tia:IMKAD_Persoon" mode="do-natural-person"/>
					<xsl:text>, </xsl:text>
					<!-- TEKSTBLOK_LEGITIMATIE -->
					<xsl:if test="tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:tia_Legitimatiebewijs">
						<xsl:apply-templates select="tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:tia_Legitimatiebewijs" mode="do-identity-document">
							<xsl:with-param name="gender" select="tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:tia_Gegevens/tia:GBA_Ingezetene/tia:geslacht/tia:geslachtsaanduiding | tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:geslacht"/>
						</xsl:apply-templates>
						<xsl:text>, </xsl:text>
					</xsl:if>
				</td>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--
	*****************************************
	Mode: do-party-natural-person-pair-v3-one
	*****************************************
	Public: no

	Identity transform: no

	Description: first person in Party legal persons pair - variant 3.

	Input: tia:IMKAD_Persoon

	Params: anchorName - name of the anchor that will be used in first <td> element
			numberOfColums - max. number of columns used in table
			skipPartyLetterColumn - indicator if party letter column(1) should not be printed
			partyLetter - party letter (A or B)
			skipPartyNumberColumn - indicator if party number column(2) should not be printed
			partyNumber - ordinal number of the party
			skipPersonLetterColumn - indicator if person letter column(3) should not be printed
			personLetter - ordinal letter of the person in the party

	Output: XHTML

	Calls:
	(mode) do-natural-person
	(mode) do-identity-document
	(mode) do-address

	Called by:
	(mode) do-party-natural-person-pair-variant-three
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon" mode="do-party-natural-person-pair-v3-one">
		<xsl:param name="anchorName"/>
		<xsl:param name="numberOfColums"/>
		<xsl:param name="skipPartyLetterColumn"/>
		<xsl:param name="partyLetter"/>
		<xsl:param name="skipPartyNumberColumn"/>
		<xsl:param name="partyNumber"/>
		<xsl:param name="skipPersonLetterColumn"/>
		<xsl:param name="personLetter"/>
		<!-- Partïj Letter kolom -->
		<xsl:if test="$skipPartyLetterColumn = 'false'">
			<td class="number" valign="top">
				<xsl:choose>
					<!-- alleen een 'A' of 'B' in deze kolom, indien het de eertse persoon in de partij is -->
					<xsl:when test="($partyNumber = 1)">
						<a name="{$anchorName}" class="location" style="_position: relative;">&#xFEFF;</a>
						<xsl:value-of select="$partyLetter"/>
						<xsl:text>. </xsl:text>
					</xsl:when>
					<!-- voor alle opvolgende volmachtgevers, een lege kolom i.v.m. uitlijning -->
					<xsl:otherwise>
						<xsl:text>&#xFEFF;</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</td>
		</xsl:if>
		<!-- persoon nummer kolom; deze is nooit leeg, bij hoofdpersoon gerelateerd stel -->
		<td class="number" valign="top">
			<xsl:choose>
				<xsl:when test="$numberOfRechthebbendeParties = '1' and $numberOfColums = '3'">
					<xsl:number value="$partyNumber" format="a."/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:number value="$partyNumber" format="1."/>
				</xsl:otherwise>
			</xsl:choose>
		</td>
		<!-- gerelateerde persoons-letter kolom(3) -->
		<!-- scenario 4b.
			als de partij meer dan 2 personen bevat, waaronder aan elkaar gerelateerde personen, dan worden deze gerelateerde personen samen genummerd;
			de eerste persoon met een opvolgend cijfer gevolgd door een letter (1.a) en
			de tweede (en volgende) perso(o)n(en) alleen met een opvolgende letter (b., c., d. enz).
		-->
		<xsl:if test="($skipPersonLetterColumn = 'false')">
			<td class="number" valign="top">
				<xsl:number value="$personLetter" format="a."/>
			</td>
		</xsl:if>
		<!-- Hoofd Persoon kolom(4) -->
		<xsl:choose>
			<!-- bereken, welke colspan er toegepast moet worden in de laatste kolom, i.v.m. uitlijning -->
			<xsl:when test="($skipPartyLetterColumn = 'true') and ($numberOfColums > 2) and ($skipPersonLetterColumn = 'true')">
				<!-- afhankelijk van het aantal kolommen -->
				<td class="level0" colspan="2">
					<!-- TEKSTBLOK_NATUURLIJK_PERSOON -->
					<xsl:apply-templates select="." mode="do-natural-person"/>
					<xsl:text>, </xsl:text>
					<!-- TEKSTBLOK_LEGITIMATIE -->
					<xsl:if test="tia:tia_Legitimatiebewijs">
						<xsl:apply-templates select="tia:tia_Legitimatiebewijs" mode="do-identity-document">
							<xsl:with-param name="gender" select="tia:tia_Gegevens/tia:GBA_Ingezetene/tia:geslacht/tia:geslachtsaanduiding | tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:geslacht"/>
						</xsl:apply-templates>
						<xsl:text>, </xsl:text>
					</xsl:if>
					<xsl:text>wonende te </xsl:text>
					<!-- TEKSTBLOK_WOONADRES -->
					<xsl:apply-templates select="tia:IMKAD_WoonlocatiePersoon" mode="do-address"/>
					<xsl:text>, en</xsl:text>
				</td>
			</xsl:when>
			<!-- indien anders -->
			<xsl:otherwise>
				<!-- alleen colspan toepassen indien >1 (XLS-FO bug ?) -->
				<td class="level0">
					<!-- TEKSTBLOK_NATUURLIJK_PERSOON -->
					<xsl:apply-templates select="." mode="do-natural-person"/>
					<xsl:text>, </xsl:text>
					<!-- TEKSTBLOK_LEGITIMATIE -->
					<xsl:if test="tia:tia_Legitimatiebewijs">
						<xsl:apply-templates select="tia:tia_Legitimatiebewijs" mode="do-identity-document">
							<xsl:with-param name="gender" select="tia:tia_Gegevens/tia:GBA_Ingezetene/tia:geslacht/tia:geslachtsaanduiding | tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:geslacht"/>
						</xsl:apply-templates>
						<xsl:text>, </xsl:text>
					</xsl:if>
					<xsl:text>wonende te </xsl:text>
					<!-- TEKSTBLOK_WOONADRES -->
					<xsl:apply-templates select="tia:IMKAD_WoonlocatiePersoon" mode="do-address"/>
					<xsl:text>, en</xsl:text>
				</td>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--
	*****************************************
	Mode: do-party-natural-person-pair-v3-two
	*****************************************
	Public: no

	Identity transform: no

	Description: second person in Party legal persons pair - variant 3.

	Input: tia:IMKAD_Persoon

	Params: anchorName - name of the anchor that will be used in first <td> element
			numberOfColums - max. number of columns used in table
			skipPartyLetterColumn - indicator if party letter column(1) should not be printed
			partyLetter - party letter (A or B)
			skipPartyNumberColumn - indicator if party number column(2) should not be printed
			partyNumber - ordinal number of the party
			skipPersonLetterColumn - indicator if person letter column(3) should not be printed
			personLetter - ordinal letter of the person in the party

	Output: XHTML

	Calls:
	(mode) do-natural-person
	(mode) do-identity-document
	(mode) do-address

	Called by:
	(mode) do-party-natural-person-pair-variant-three
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon" mode="do-party-natural-person-pair-v3-two">
		<xsl:param name="anchorName"/>
		<xsl:param name="numberOfColums"/>
		<xsl:param name="skipPartyLetterColumn"/>
		<xsl:param name="partyLetter"/>
		<xsl:param name="skipPartyNumberColumn"/>
		<xsl:param name="partyNumber"/>
		<xsl:param name="skipPersonLetterColumn"/>
		<xsl:param name="personLetter"/>
		<!-- Partïj Letter kolom(1) -->
		<xsl:if test="$skipPartyLetterColumn = 'false'">
			<td class="number" valign="top">
				<xsl:choose>
					<!-- alleen een 'A' of 'B' in deze kolom, indien het de eertse persoon in de partij is -->
					<xsl:when test="($partyNumber = 1)">
						<a name="{$anchorName}" class="location" style="_position: relative;">&#xFEFF;</a>
						<xsl:value-of select="$partyLetter"/>
						<xsl:text>. </xsl:text>
					</xsl:when>
					<!-- voor alle opvolgende volmachtgevers, een lege kolom i.v.m. uitlijning -->
					<xsl:otherwise>
						<xsl:text>&#xFEFF;</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</td>
		</xsl:if>
		<!-- persoon nummer kolom(2) -->
		<xsl:choose>
			<xsl:when test="($skipPartyNumberColumn = 'false')">
				<xsl:choose>
					<xsl:when test="$numberOfRechthebbendeParties = '1' and $numberOfColums = '3'">
						<td class="number" valign="top">
							<xsl:number value="$partyNumber" format="a."/>
						</td>
					</xsl:when>
					<xsl:otherwise>
						<td class="number" valign="top">
							<xsl:number value="$partyNumber" format="1."/>
						</td>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<!-- lege kolom i.v.m. uitlijning -->
				<td class="number" valign="top">
					<xsl:text>&#xFEFF;</xsl:text>
				</td>
			</xsl:otherwise>
		</xsl:choose>
		<!-- gerelateerde persoons-letter kolom(3) -->
		<xsl:if test="($skipPersonLetterColumn = 'false')">
			<td class="number" valign="top">
				<xsl:number value="$personLetter" format="a."/>
			</td>
		</xsl:if>
		<!-- Gerelateerd Persoon kolom(4) -->
		<xsl:choose>
			<!-- bereken, welke colspan er toegepast moet worden in de laatste kolom, i.v.m. uitlijning -->
			<xsl:when test="($skipPartyLetterColumn = 'true') and ($numberOfColums > 2) and ($skipPersonLetterColumn = 'true')">
				<!-- afhankelijk van het aantal kolommen -->
				<td class="level0" colspan="2">
					<!-- TEKSTBLOK_NATUURLIJK_PERSOON -->
					<xsl:apply-templates select="tia:GerelateerdPersoon/tia:IMKAD_Persoon" mode="do-natural-person"/>
					<xsl:text>, </xsl:text>
					<!-- TEKSTBLOK_LEGITIMATIE -->
					<xsl:if test="tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:tia_Legitimatiebewijs">
						<xsl:apply-templates select="tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:tia_Legitimatiebewijs" mode="do-identity-document">
							<xsl:with-param name="gender" select="tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:tia_Gegevens/tia:GBA_Ingezetene/tia:geslacht/tia:geslachtsaanduiding | tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:geslacht"/>
						</xsl:apply-templates>
						<xsl:text>, </xsl:text>
					</xsl:if>
					<xsl:text>wonende te </xsl:text>
					<!-- TEKSTBLOK_WOONADRES -->
					<xsl:choose>
						<xsl:when test="tia:GerelateerdPersoon[translate(tia:IndGezamenlijkeWoonlocatie,$upper, $lower) = 'true']">
							<xsl:apply-templates select="tia:IMKAD_WoonlocatiePersoon" mode="do-address"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:apply-templates select="tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:IMKAD_WoonlocatiePersoon" mode="do-address"/>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:text>,</xsl:text>
				</td>
			</xsl:when>
			<xsl:otherwise>
				<!-- alleen colspan toepassen indien >1 (XLS-FO bug ?) -->
				<td class="level0">
					<!-- TEKSTBLOK_NATUURLIJK_PERSOON -->
					<xsl:apply-templates select="tia:GerelateerdPersoon/tia:IMKAD_Persoon" mode="do-natural-person"/>
					<xsl:text>, </xsl:text>
					<!-- TEKSTBLOK_LEGITIMATIE -->
					<xsl:if test="tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:tia_Legitimatiebewijs">
						<xsl:apply-templates select="tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:tia_Legitimatiebewijs" mode="do-identity-document">
							<xsl:with-param name="gender" select="tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:tia_Gegevens/tia:GBA_Ingezetene/tia:geslacht/tia:geslachtsaanduiding | tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:geslacht"/>
						</xsl:apply-templates>
						<xsl:text>, </xsl:text>
					</xsl:if>
					<xsl:text>wonende te </xsl:text>
					<!-- TEKSTBLOK_WOONADRES -->
					<xsl:choose>
						<xsl:when test="tia:GerelateerdPersoon[translate(tia:IndGezamenlijkeWoonlocatie,$upper, $lower) = 'true']">
							<xsl:apply-templates select="tia:IMKAD_WoonlocatiePersoon" mode="do-address"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:apply-templates select="tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:IMKAD_WoonlocatiePersoon" mode="do-address"/>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:text>,</xsl:text>
				</td>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--
	*****************************************
	Mode: do-party-natural-person-pair-v4-one
	*****************************************
	Public: no

	Identity transform: no

	Description: first person in Party natural persons pair - variant 4.

	Input: tia:IMKAD_Persoon

	Params: anchorName - name of the anchor that will be used in first <td> element
			numberOfColums - max. number of columns used in table
			skipPartyLetterColumn - indicator if party letter column(1) should not be printed
			partyLetter - party letter (A or B)
			skipPartyNumberColumn - indicator if party number column(2) should not be printed
			partyNumber - ordinal number of the party
			skipPersonLetterColumn - indicator if person letter column(3) should not be printed
			personLetter - ordinal letter of the person in the party

	Output: XHTML

	Calls:
	(mode) do-natural-person
	(mode) do-identity-document
	(mode) do-address

	Called by:
	(mode) do-party-natural-person-pair-variant-four
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon" mode="do-party-natural-person-pair-v4-one">
		<xsl:param name="anchorName"/>
		<xsl:param name="numberOfColums"/>
		<xsl:param name="skipPartyLetterColumn"/>
		<xsl:param name="partyLetter"/>
		<xsl:param name="skipPartyNumberColumn"/>
		<xsl:param name="partyNumber"/>
		<xsl:param name="skipPersonLetterColumn"/>
		<xsl:param name="personLetter"/>
		<!-- Partïj Letter kolom -->
		<xsl:if test="$skipPartyLetterColumn = 'false'">
			<td class="number" valign="top">
				<xsl:choose>
					<!-- alleen een 'A' of 'B' in deze kolom, indien het de eertse persoon in de partij is -->
					<xsl:when test="($partyNumber = 1)">
						<a name="{$anchorName}" class="location" style="_position: relative;">&#xFEFF;</a>
						<xsl:value-of select="$partyLetter"/>
						<xsl:text>. </xsl:text>
					</xsl:when>
					<!-- voor alle opvolgende volmachtgevers, een lege kolom i.v.m. uitlijning -->
					<xsl:otherwise>
						<xsl:text>&#xFEFF;</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</td>
		</xsl:if>
		<xsl:choose>
			<xsl:when test="($skipPartyNumberColumn = 'false')">
				<xsl:choose>
					<xsl:when test="$numberOfRechthebbendeParties = '1' and $numberOfColums = '3'">
						<td class="number" valign="top">
							<xsl:number value="$partyNumber" format="a."/>
						</td>
					</xsl:when>
					<xsl:otherwise>
						<td class="number" valign="top">
							<xsl:number value="$partyNumber" format="1."/>
						</td>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<!-- lege kolom i.v.m. uitlijning -->
				<td class="number" valign="top">
					<xsl:text>&#xFEFF;</xsl:text>
				</td>
			</xsl:otherwise>
		</xsl:choose>
		<!-- persoon nummer kolom; deze is nooit leeg, bij hoofdpersoon gerelateerd stel -->
		<!--		<td class="number" valign="top">
			<xsl:number value="$partyNumber" format="1."/>
		</td>
-->
		<!-- gerelateerde persoons-letter kolom(3) -->
		<!-- scenario 4b.
			als de partij meer dan 2 personen bevat, waaronder aan elkaar gerelateerde personen, dan worden deze gerelateerde personen samen genummerd;
			de eerste persoon met een opvolgend cijfer gevolgd door een letter (1.a) en
			de tweede (en volgende) perso(o)n(en) alleen met een opvolgende letter (b., c., d. enz).
		-->
		<xsl:if test="($skipPersonLetterColumn = 'false')">
			<td class="number" valign="top">
				<xsl:number value="$personLetter" format="a."/>
			</td>
		</xsl:if>
		<!-- Hoofd Persoon kolom(4) -->
		<xsl:choose>
			<!-- bereken, welke colspan er toegepast moet worden in de laatste kolom, i.v.m. uitlijning -->
			<xsl:when test="($skipPartyLetterColumn = 'true') and ($numberOfColums > 2) and ($skipPersonLetterColumn = 'true')">
				<!-- afhankelijk van het aantal kolommen -->
				<td class="level0" colspan="2">
					<!-- TEKSTBLOK_NATUURLIJK_PERSOON -->
					<xsl:apply-templates select="." mode="do-natural-person"/>
					<xsl:text>, </xsl:text>
					<!-- TEKSTBLOK_LEGITIMATIE -->
					<xsl:if test="tia:tia_Legitimatiebewijs">
						<xsl:apply-templates select="tia:tia_Legitimatiebewijs" mode="do-identity-document">
							<xsl:with-param name="gender" select="tia:tia_Gegevens/tia:GBA_Ingezetene/tia:geslacht/tia:geslachtsaanduiding | tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:geslacht"/>
						</xsl:apply-templates>
						<xsl:text>, </xsl:text>
					</xsl:if>
					<!-- TEKSTBLOK_BURGERLIJKE_STAAT -->
					<xsl:apply-templates select="." mode="do-marital-status"/>
					<xsl:text>, en</xsl:text>
				</td>
			</xsl:when>
			<xsl:otherwise>
				<!-- alleen colspan toepassen indien >1 (XLS-FO bug ?) -->
				<td class="level0">
					<!-- TEKSTBLOK_NATUURLIJK_PERSOON -->
					<xsl:apply-templates select="." mode="do-natural-person"/>
					<xsl:text>, </xsl:text>
					<!-- TEKSTBLOK_LEGITIMATIE -->
					<xsl:if test="tia:tia_Legitimatiebewijs">
						<xsl:apply-templates select="tia:tia_Legitimatiebewijs" mode="do-identity-document">
							<xsl:with-param name="gender" select="tia:tia_Gegevens/tia:GBA_Ingezetene/tia:geslacht/tia:geslachtsaanduiding | tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:geslacht"/>
						</xsl:apply-templates>
						<xsl:text>, </xsl:text>
					</xsl:if>
					<!-- TEKSTBLOK_BURGERLIJKE_STAAT -->
					<xsl:apply-templates select="." mode="do-marital-status"/>
					<xsl:text>, en</xsl:text>
				</td>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--
	******************************************
	Mode: do-party-natural-person-pair-v4-next
	******************************************
	Public: no

	Identity transform: no

	Description: second..last person in Party legal persons pair - variant 4.

	Input: tia:IMKAD_Persoon

	Params: anchorName - name of the anchor that will be used in first <td> element
			numberOfColums - max. number of columns used in table
			skipPartyLetterColumn - indicator if party letter column(1) should not be printed
			partyLetter - party letter (A or B)
			skipPartyNumberColumn - indicator if party number column(2) should not be printed
			partyNumber - ordinal number of the party
			skipPersonLetterColumn - indicator if person letter column(3) should not be printed
			personLetter - ordinal letter of the person in the party

	Output: XHTML

	Calls:
	(mode) do-natural-person
	(mode) do-identity-document
	(mode) do-address

	Called by:
	(mode) do-party-natural-person-pair-variant-four
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon" mode="do-party-natural-person-pair-v4-next">
		<xsl:param name="anchorName"/>
		<xsl:param name="numberOfColums"/>
		<xsl:param name="skipPartyLetterColumn"/>
		<xsl:param name="partyLetter"/>
		<xsl:param name="skipPartyNumberColumn"/>
		<xsl:param name="partyNumber"/>
		<xsl:param name="skipPersonLetterColumn"/>
		<xsl:param name="personLetter"/>
		<!-- Partïj Letter kolom(1) -->
		<xsl:if test="$skipPartyLetterColumn = 'false'">
			<td class="number" valign="top">
				<xsl:choose>
					<!-- alleen een 'A' of 'B' in deze kolom, indien het de eertse persoon in de partij is -->
					<xsl:when test="($partyNumber = 1)">
						<a name="{$anchorName}" class="location" style="_position: relative;">&#xFEFF;</a>
						<xsl:value-of select="$partyLetter"/>
						<xsl:text>. </xsl:text>
					</xsl:when>
					<!-- voor alle opvolgende volmachtgevers, een lege kolom i.v.m. uitlijning -->
					<xsl:otherwise>
						<xsl:text>&#xFEFF;</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</td>
		</xsl:if>
		<!-- Partïj Nummer kolom(2) -->
		<xsl:choose>
			<xsl:when test="($skipPartyNumberColumn = 'false')">
				<xsl:choose>
					<xsl:when test="$numberOfRechthebbendeParties = '1' and $numberOfColums = '3'">
						<td class="number" valign="top">
							<xsl:number value="$partyNumber" format="a."/>
						</td>
					</xsl:when>
					<xsl:otherwise>
						<td class="number" valign="top">
							<xsl:number value="$partyNumber" format="1."/>
						</td>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<!-- lege kolom i.v.m. uitlijning -->
				<td class="number" valign="top">
					<xsl:text>&#xFEFF;</xsl:text>
				</td>
			</xsl:otherwise>
		</xsl:choose>
		<!-- gerelateerde persoons-letter kolom(3) -->
		<xsl:if test="($skipPersonLetterColumn = 'false')">
			<td class="number" valign="top">
				<xsl:number value="$personLetter" format="a."/>
			</td>
		</xsl:if>
		<!-- Gerelateerd Persoon kolom(4) -->
		<xsl:choose>
			<!-- bereken, welke colspan er toegepast moet worden in de laatste kolom, i.v.m. uitlijning -->
			<xsl:when test="($skipPartyLetterColumn = 'true') and ($numberOfColums > 2) and ($skipPersonLetterColumn = 'true')">
				<!-- afhankelijk van het aantal kolommen -->
				<td class="level0" colspan="2">
					<!-- TEKSTBLOK_NATUURLIJK_PERSOON -->
					<xsl:apply-templates select="." mode="do-natural-person"/>
					<xsl:text>, </xsl:text>
					<!-- TEKSTBLOK_LEGITIMATIE -->
					<xsl:if test="tia:tia_Legitimatiebewijs">
						<xsl:apply-templates select="tia:tia_Legitimatiebewijs" mode="do-identity-document">
							<xsl:with-param name="gender" select="tia:tia_Gegevens/tia:GBA_Ingezetene/tia:geslacht/tia:geslachtsaanduiding | tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:geslacht"/>
						</xsl:apply-templates>
						<xsl:text>, </xsl:text>
					</xsl:if>
					<!-- TEKSTBLOK_BURGERLIJKE_STAAT -->
					<xsl:apply-templates select="." mode="do-marital-status"/>
					<xsl:choose>
						<xsl:when test="../following-sibling::tia:GerelateerdPersoon">
							<xsl:text>, en</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>,</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</td>
			</xsl:when>
			<xsl:otherwise>
				<!-- alleen colspan toepassen indien >1 (XLS-FO bug ?) -->
				<td class="level0">
					<!-- TEKSTBLOK_NATUURLIJK_PERSOON -->
					<xsl:apply-templates select="." mode="do-natural-person"/>
					<xsl:text>, </xsl:text>
					<!-- TEKSTBLOK_LEGITIMATIE -->
					<xsl:if test="tia:tia_Legitimatiebewijs">
						<xsl:apply-templates select="tia:tia_Legitimatiebewijs" mode="do-identity-document">
							<xsl:with-param name="gender" select="tia:tia_Gegevens/tia:GBA_Ingezetene/tia:geslacht/tia:geslachtsaanduiding | tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:geslacht"/>
						</xsl:apply-templates>
						<xsl:text>, </xsl:text>
					</xsl:if>
					<!-- TEKSTBLOK_BURGERLIJKE_STAAT -->
					<xsl:apply-templates select="." mode="do-marital-status"/>
					<xsl:choose>
						<xsl:when test="../following-sibling::tia:GerelateerdPersoon">
							<xsl:text>, en</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>,</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</td>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
