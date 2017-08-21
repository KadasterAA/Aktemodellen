<?xml version="1.0" encoding="UTF-8"?>
<!--
*******************************************************************
Stylesheet: tekstblok_partij_niet_natuurlijk_persoon_doorhaling.xsl
Version: 2.0.0
*******************************************************************
Description:
Party legal person text block.

Public:
(mode) do-party-legal-person

Private:
(mode) do-party-legal-person-single
(mode) do-party-legal-person-pair
-->
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
	xmlns:tia="http://www.kadaster.nl/schemas/KIK/TIA_Algemeen"
	xmlns:kef="nl.kadaster.xslt.XslExtensionFunctions"
	xmlns:gc="http://docs.oasis-open.org/codelist/ns/genericode/1.0/"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:exslt="http://exslt.org/common"
	xmlns:xlink="http://www.w3.org/1999/xlink"
	exclude-result-prefixes="tia kef gc xsl exslt xlink"
	version="1.0">

	<!--
	*********************************************************
	Mode: do-party-legal-person
	*********************************************************
	Public: yes

	Identity transform: no

	Description: Party legal person text block, used for non-standard XML person representation. Used in case when person in XML is located under nested party, which is non-standard location.

	Input: tia:IMKAD_Persoon

	Params: Params: anchorName - name of the anchor that will be used in first <td> element
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
	(mode) do-party-legal-person-related
	(mode) do-party-legal-person-single

	Called by:
	(mode) do-party-person
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon" mode="do-party-legal-person">
		<xsl:param name="anchorName" />
		<xsl:param name="numberOfColums" />
		<xsl:param name="skipPartyLetterColumn" />
		<xsl:param name="partyLetter" />
		<xsl:param name="skipPartyNumberColumn" />
		<xsl:param name="partyNumber"/>
		<xsl:param name="skipPersonLetterColumn" />
		<xsl:param name="personLetter" />
		<xsl:param name="afsluiting"/>

		<xsl:choose>
			<xsl:when test="tia:GerelateerdPersoon[(translate(tia:rol, $upper, $lower) = 'rechtspersoon')]">
				<xsl:apply-templates select="." mode="do-party-legal-person-related">
					<xsl:with-param name="anchorName" select="$anchorName" />
					<xsl:with-param name="numberOfColums" select="$numberOfColums" />
					<xsl:with-param name="skipPartyLetterColumn" select="$skipPartyLetterColumn" />
					<xsl:with-param name="partyLetter" select="$partyLetter" />
					<xsl:with-param name="skipPartyNumberColumn" select="$skipPartyNumberColumn" />
					<xsl:with-param name="partyNumber" select="$partyNumber" />
					<xsl:with-param name="skipPersonLetterColumn" select="$skipPersonLetterColumn" />
					<xsl:with-param name="personLetter" select="$personLetter" />					
					<xsl:with-param name="afsluiting" select="$afsluiting"/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="." mode="do-party-legal-person-single">
					<xsl:with-param name="anchorName" select="$anchorName" />
					<xsl:with-param name="numberOfColums" select="$numberOfColums" />
					<xsl:with-param name="skipPartyLetterColumn" select="$skipPartyLetterColumn" />
					<xsl:with-param name="partyLetter" select="$partyLetter" />
					<xsl:with-param name="skipPartyNumberColumn" select="$skipPartyNumberColumn" />
					<xsl:with-param name="partyNumber" select="$partyNumber" />
					<xsl:with-param name="skipPersonLetterColumn" select="$skipPersonLetterColumn" />
					<xsl:with-param name="personLetter" select="$personLetter" />
					<xsl:with-param name="afsluiting" select="$afsluiting"/>
				</xsl:apply-templates>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--
	*********************************************************
	Mode: do-party-legal-person-single
	*********************************************************
	Public: no

	Identity transform: no

	Description: Party legal single person text block.

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
	(mode) do-legal-person
	(mode) do-identity-document
	(mode) do-marital-status
	(mode) do-address

	Called by:
	(mode) do-party-legal-person
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon" mode="do-party-legal-person-single">
		<xsl:param name="anchorName" />
		<xsl:param name="numberOfColums" />
		<xsl:param name="skipPartyLetterColumn" />
		<xsl:param name="partyLetter" />
		<xsl:param name="skipPartyNumberColumn" />
		<xsl:param name="partyNumber"/>
		<xsl:param name="skipPersonLetterColumn" />
		<xsl:param name="personLetter" />
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
						<!-- TEKSTBLOK RECHTSPERSOON -->
						<xsl:apply-templates select="." mode="do-legal-person"></xsl:apply-templates>
						<!-- optioneel: TEKSTBLOK_PostlocatiePersoon -->
						<xsl:if test="tia:IMKAD_PostlocatiePersoon">
							<xsl:apply-templates select="tia:IMKAD_PostlocatiePersoon" mode="do-PostlocatiePersoon"></xsl:apply-templates>
						</xsl:if>
						<!-- optioneel: TEKSTBLOK_Faillissement -->
						<xsl:if test="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_faillissement']">
							<xsl:text>, </xsl:text>
							<xsl:value-of select="normalize-space(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_faillissement']/tia:tekst)"/>
						</xsl:if>
						<xsl:value-of select="$afsluiting"/>
					</td>
				</xsl:when>
				<!-- alleen colspan toepassen indien >1 (XLS-FO bug ?) -->
				<xsl:otherwise>
					<td class="level0">
						<!-- TEKSTBLOK RECHTSPERSOON -->
						<xsl:apply-templates select="." mode="do-legal-person"></xsl:apply-templates>
						<!-- optioneel: TEKSTBLOK_PostlocatiePersoon -->
						<xsl:if test="tia:IMKAD_PostlocatiePersoon">
							<xsl:apply-templates select="tia:IMKAD_PostlocatiePersoon" mode="do-PostlocatiePersoon"></xsl:apply-templates>
						</xsl:if>
						<!-- optioneel: TEKSTBLOK_Faillissement -->
						<xsl:if test="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_faillissement']">
							<xsl:text>, </xsl:text>
							<xsl:value-of select="normalize-space(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_faillissement']/tia:tekst)"/>
						</xsl:if>
						<xsl:value-of select="$afsluiting"/>
					</td>
				</xsl:otherwise>
			</xsl:choose>
		</tr>
	</xsl:template>

	<!--
	*********************************************************
	Mode: do-party-legal-person-related
	*********************************************************
	Public: no

	Identity transform: no

	Description: Party legal persons related text block.

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
	(mode) ...

	Called by:
	(mode) do-party-legal-person
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon" mode="do-party-legal-person-related">
		<xsl:param name="anchorName" />
		<xsl:param name="numberOfColums" />
		<xsl:param name="skipPartyLetterColumn" />
		<xsl:param name="partyLetter" />
		<xsl:param name="skipPartyNumberColumn" />
		<xsl:param name="partyNumber"/>
		<xsl:param name="skipPersonLetterColumn" />
		<xsl:param name="personLetter" />
		<xsl:param name="afsluiting"/>
		<!-- hier de eerste regel (de hoofdpersoon) in de tabel van NNP's in de partij opbouwen: -->
		<tr>
			<xsl:apply-templates select="." mode="do-party-legal-person-related-first">
				<xsl:with-param name="anchorName" select="$anchorName" />
				<xsl:with-param name="numberOfColums" select="$numberOfColums" />
				<xsl:with-param name="skipPartyLetterColumn" select="$skipPartyLetterColumn" />
				<xsl:with-param name="partyLetter" select="$partyLetter" />
				<!-- eerste regel (de hoofdpersoon) heeft altijd partij-numer --> 
				<xsl:with-param name="skipPartyNumberColumn" select="'false'" />
				<xsl:with-param name="partyNumber" select="$partyNumber" />
				<xsl:with-param name="skipPersonLetterColumn" select="$skipPersonLetterColumn" />
				<!-- persoons-letter bij de hoofd persoon begint altijd bij A (dus=1) -->
				<xsl:with-param name="personLetter" select="1" />				
			</xsl:apply-templates>
		</tr>

		<!-- bepaal of partij-nummer kolom(2) afgedrukt moet worden -->
		<xsl:variable name="skipPartyNumberColumn_2">
			<xsl:choose>
				<!-- indien hoofd-persoon enige in partij -->
				<xsl:when test="(count(preceding-sibling::tia:IMKAD_Persoon) + count(following-sibling::tia:IMKAD_Persoon)) = 0">
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

		<!-- voor iedere gerelateerd Persoon (NNP) een regel -->
		<xsl:for-each select="tia:GerelateerdPersoon">
			<!-- bepaal het volgnummer v/d gerelaarde persoon -->
			<xsl:variable name="_relPersonLetter" select="count(preceding-sibling::tia:GerelateerdPersoon) + 1"/>
			<tr>
				<!-- de tweede persoon -->
				<xsl:apply-templates select="tia:IMKAD_Persoon" mode="do-party-legal-person-related-next">
					<xsl:with-param name="anchorName" select="$anchorName" />
					<xsl:with-param name="numberOfColums" select="$numberOfColums" />
					<xsl:with-param name="skipPartyLetterColumn" select="$skipPartyLetterColumn" />
					<xsl:with-param name="partyLetter" select="$partyLetter" />
					<!-- partij-nummer kolom(2) alleen indien hoofd-persoon enige in partij -->
					<xsl:with-param name="skipPartyNumberColumn" select="$skipPartyNumberColumn_2" />
					<xsl:with-param name="partyNumber" select="number($partyNumber + $_relPersonLetter)" />
					<!-- persoons-letter kolom(3) alleen bij meerdere hoofd-personen in partij -->
					<xsl:with-param name="skipPersonLetterColumn" select="$skipPersonLetterColumn" />
					<xsl:with-param name="personLetter" select="number($_relPersonLetter) + 1" />					
					<xsl:with-param name="afsluiting" select="$afsluiting"/>
				</xsl:apply-templates>
			</tr>
		</xsl:for-each>
	</xsl:template>

	<!--
	*****************************************
	Mode: do-party-legal-person-related-first
	*****************************************
	Public: no

	Identity transform: no

	Description: first person in Party legal persons related

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
	(mode) do-legal-person
	(mode) do-identity-document
	(mode) do-address

	Called by:
	(mode)  do-party-legal-person-related
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon" mode="do-party-legal-person-related-first">
		<xsl:param name="anchorName" />
		<xsl:param name="numberOfColums" />
		<xsl:param name="skipPartyLetterColumn" />
		<xsl:param name="partyLetter" />
		<xsl:param name="skipPartyNumberColumn" />
		<xsl:param name="partyNumber"/>
		<xsl:param name="skipPersonLetterColumn" />
		<xsl:param name="personLetter" />
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
		
		<!-- persoon nummer kolom; deze is nooit leeg, bij hoofdpersoon gerelateerde NNP's -->
		<td class="number" valign="top">
			<xsl:number value="$partyNumber" format="1."/>
		</td>

		<!-- gerelateerde persoons-letter kolom(3) -->
		<xsl:if test="($skipPersonLetterColumn = 'false')">
			<td class="number" valign="top">
				<xsl:number value="$personLetter" format="a."/>
			</td>
		</xsl:if>	

		<!-- Hoofd NNP kolom(4) -->
		<xsl:choose>
			<!-- bereken, welke colspan er toegepast moet worden in de laatste kolom, i.v.m. uitlijning -->	
			<xsl:when test="($skipPartyLetterColumn = 'true') and ($numberOfColums > 2) and ($skipPersonLetterColumn = 'true')">
				<!-- afhankelijk van het aantal kolommen -->
				<td class="level0" colspan="2">
					<!-- TEKSTBLOK RECHTSPERSOON -->
					<xsl:apply-templates select="." mode="do-legal-person"></xsl:apply-templates>
					<!-- optioneel: TEKSTBLOK_PostlocatiePersoon -->
					<xsl:if test="tia:IMKAD_PostlocatiePersoon">
						<xsl:apply-templates select="tia:IMKAD_PostlocatiePersoon" mode="do-PostlocatiePersoon"></xsl:apply-templates>
					</xsl:if>
					<!-- optioneel: TEKSTBLOK_Faillissement -->
					<xsl:if test="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_faillissement']">
						<xsl:text>, </xsl:text>
						<xsl:value-of select="normalize-space(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_faillissement']/tia:tekst)"/>
					</xsl:if>
					<xsl:text>; en</xsl:text>
				</td>
			</xsl:when>
			<!-- indien meerdere hoofd-persoon in partij -->
			<xsl:otherwise>
				<!-- alleen colspan toepassen indien >1 (XLS-FO bug ?) -->
				<td class="level0">
					<!-- TEKSTBLOK RECHTSPERSOON -->
					<xsl:apply-templates select="." mode="do-legal-person"></xsl:apply-templates>
					<!-- optioneel: TEKSTBLOK_PostlocatiePersoon -->
					<xsl:if test="tia:IMKAD_PostlocatiePersoon">
						<xsl:apply-templates select="tia:IMKAD_PostlocatiePersoon" mode="do-PostlocatiePersoon"></xsl:apply-templates>
					</xsl:if>
					<!-- optioneel: TEKSTBLOK_Faillissement -->
					<xsl:if test="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_faillissement']">
						<xsl:text>, </xsl:text>
						<xsl:value-of select="normalize-space(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_faillissement']/tia:tekst)"/>
					</xsl:if>
					<xsl:text>; en</xsl:text>
				</td>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--
	*****************************************
	Mode: do-party-legal-person-related-next
	*****************************************
	Public: no

	Identity transform: no

	Description: second..last related person(s) in Party legal persons related

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
	(mode) do-legal-person
	(mode) do-identity-document
	(mode) do-address

	Called by:
	(mode)  do-party-legal-person-related
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon" mode="do-party-legal-person-related-next">
		<xsl:param name="anchorName" />
		<xsl:param name="numberOfColums" />
		<xsl:param name="skipPartyLetterColumn" />
		<xsl:param name="partyLetter" />
		<xsl:param name="skipPartyNumberColumn" />
		<xsl:param name="partyNumber"/>
		<xsl:param name="skipPersonLetterColumn" />
		<xsl:param name="personLetter" />
		<xsl:param name="afsluiting"/>
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
		<td class="number" valign="top">
			<xsl:choose>
				<xsl:when test="$skipPartyNumberColumn = 'false'">
					<xsl:number value="$partyNumber" format="1."/>
				</xsl:when>	
				<!-- lege kolom i.v.m. uitlijning -->
				<xsl:otherwise>
					<xsl:text>&#xFEFF;</xsl:text>
				</xsl:otherwise>
			</xsl:choose>	
		</td>

		<!-- gerelateerde NNP-letter kolom(3) -->
		<xsl:if test="($skipPersonLetterColumn = 'false')">
			<td class="number" valign="top">
				<xsl:number value="$personLetter" format="a."/>
			</td>
		</xsl:if>

		<!-- Gerelateerde NNP kolom(4) -->
		<xsl:choose>
			<!-- bereken, welke colspan er toegepast moet worden in de laatste kolom, i.v.m. uitlijning -->
			<xsl:when test="($skipPartyLetterColumn = 'true') and ($numberOfColums > 2) and ($skipPersonLetterColumn = 'true')">
				<!-- afhankelijk van het aantal kolommen -->
				<td class="level0" colspan="2">
					<!-- TEKSTBLOK RECHTSPERSOON -->
					<xsl:apply-templates select="." mode="do-legal-person"></xsl:apply-templates>
					<!-- optioneel: TEKSTBLOK_PostlocatiePersoon -->
					<xsl:if test="tia:IMKAD_PostlocatiePersoon">
						<xsl:apply-templates select="tia:IMKAD_PostlocatiePersoon" mode="do-PostlocatiePersoon"></xsl:apply-templates>
					</xsl:if>
					<!-- optioneel: TEKSTBLOK_Faillissement -->
					<xsl:if test="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_faillissement']">
						<xsl:text>, </xsl:text>
						<xsl:value-of select="normalize-space(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_faillissement']/tia:tekst)"/>
					</xsl:if>
					<xsl:value-of select="$afsluiting"/>
				</td>
			</xsl:when>
			<!-- indien meerdere hoofd-persoon in partij -->
			<xsl:otherwise>
				<!-- alleen colspan toepassen indien >1 (XLS-FO bug ?) -->
				<td class="level0">
					<!-- TEKSTBLOK RECHTSPERSOON -->
					<xsl:apply-templates select="." mode="do-legal-person"></xsl:apply-templates>
					<!-- optioneel: TEKSTBLOK_PostlocatiePersoon -->
					<xsl:if test="tia:IMKAD_PostlocatiePersoon">
						<xsl:apply-templates select="tia:IMKAD_PostlocatiePersoon" mode="do-PostlocatiePersoon"></xsl:apply-templates>
					</xsl:if>
					<!-- optioneel: TEKSTBLOK_Faillissement -->
					<xsl:if test="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_faillissement']">
						<xsl:text>, </xsl:text>
						<xsl:value-of select="normalize-space(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_faillissement']/tia:tekst)"/>
					</xsl:if>
					<xsl:value-of select="$afsluiting"/>
				</td>
			</xsl:otherwise>
		</xsl:choose>	
	</xsl:template>

	<!--
	*********************************************************
	Mode: do-PostlocatiePersoon
	*********************************************************
	Input: tia:IMKAD_PostlocatiePersoon
	Params: none
	Output: XHTML

	Calls:
	(mode) none
	
	Called by:
	(mode) do-keuzeblok-niet-natuurlijk-persoon
	-->
	<xsl:template match="tia:IMKAD_PostlocatiePersoon" mode="do-PostlocatiePersoon">
		<xsl:text> (correspondentieadres voor alle aangelegenheden betreffende de hierna te vermelden rechtshandelingen: </xsl:text>
		<!-- Label is een optionele variabele, die bij elke type adres ingevuld mag worden. -->
		<xsl:if test="tia:tia_label">
			<xsl:value-of select="tia:tia_label"/>
			<xsl:text>, </xsl:text>
		</xsl:if>
		<!-- Label is een optionele variabele, die bij elke type adres ingevuld mag worden. -->
		<xsl:if test="tia:tia_afdeling">
			<xsl:value-of select="tia:tia_afdeling"/>
			<xsl:text>, </xsl:text>
		</xsl:if>
		<!-- TEKSTBLOK_Imkad_AdreskeuzePI -->
		<!-- xsl:apply-templates select="adres" mode="do-adres-niet-natuurlijk-persoon"></xsl:apply-templates -->
		<xsl:choose>
				<!-- TEKSTBLOK_binnenlandsAdres -->
				<xsl:when test="tia:adres/tia:binnenlandsAdres">
					<xsl:apply-templates select="tia:adres/tia:binnenlandsAdres" mode="do-binnenlandsAdres"></xsl:apply-templates>
				</xsl:when>
				<!-- TEKSTBLOK_buitenlandsAdres -->
				<xsl:when test="tia:adres/tia:buitenlandsAdres">
					<xsl:apply-templates select="tia:adres/tia:buitenlandsAdres" mode="do-buitenlandsAdres"></xsl:apply-templates>
				</xsl:when>
				<!-- TEKSTBLOK_postbusAdres -->
				<xsl:when test="tia:adres/tia:postbusAdres">
					<xsl:apply-templates select="tia:adres/tia:postbusAdres" mode="do-postbusAdres"></xsl:apply-templates>
				</xsl:when>
			</xsl:choose>
			<xsl:text>)</xsl:text>
	</xsl:template>	
		
	<!--
	*********************************************************
	Mode: do-binnenlandsAdres
	*********************************************************
	Input: tia:binnenlandsAdres
	Params: none
	Output: XHTML

	Calls:
	(mode) none
	
	Called by:
	(mode) do-PostlocatiePersoon
	-->
	<xsl:template match="tia:binnenlandsAdres" mode="do-binnenlandsAdres">
		<!-- Insert space between numbers and letters of post code -->
		<xsl:value-of select="concat(normalize-space(substring(tia:BAG_NummerAanduiding/tia:postcode, 1, 4)), ' ',
			normalize-space(substring(tia:BAG_NummerAanduiding/tia:postcode, 5)))"/>
		<xsl:text> </xsl:text>
		<xsl:value-of select="tia:BAG_Woonplaats/tia:woonplaatsNaam"/>
		<xsl:text>, </xsl:text>
		<xsl:value-of select="tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam"/>
		<xsl:text> </xsl:text>

		<xsl:value-of select="tia:BAG_NummerAanduiding/tia:huisnummer"/>
		<xsl:if test="tia:BAG_NummerAanduiding/tia:huisletter
						and normalize-space(tia:BAG_NummerAanduiding/tia:huisletter) != ''">
			<xsl:text> </xsl:text>
			<xsl:value-of select="tia:BAG_NummerAanduiding/tia:huisletter"/>
		</xsl:if>
		<xsl:if test="tia:BAG_NummerAanduiding/tia:huisnummertoevoeging
						and normalize-space(tia:BAG_NummerAanduiding/tia:huisnummertoevoeging) != ''">
			<xsl:text> </xsl:text>
			<xsl:value-of select="tia:BAG_NummerAanduiding/tia:huisnummertoevoeging"/>
		</xsl:if>
	</xsl:template>

	<!--
	*********************************************************
	Mode: do-buitenlandsAdres
	*********************************************************
	Input: tia:buitenlandsAdres
	Params: none
	Output: XHTML

	Calls:
	(mode) none
	
	Called by:
	(mode) do-PostlocatiePersoon
	-->
	<xsl:template match="tia:buitenlandsAdres" mode="do-buitenlandsAdres">
		<xsl:if test="tia:regio and normalize-space(tia:regio) != ''">
			<xsl:value-of select="tia:regio"/>
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:value-of select="tia:woonplaats"/>
		<xsl:text>, </xsl:text>	
		<xsl:value-of select="tia:adres"/>
		<xsl:text>, </xsl:text>
		<xsl:value-of select="tia:land"/>
	</xsl:template>
	
	<!--
	*********************************************************
	Mode: do-postbusAdres
	*********************************************************
	Input: tia:postbusAdres
	Params: none
	Output: XHTML

	Calls:
	(mode) none
	
	Called by:
	(mode) do-PostlocatiePersoon
	-->
	<xsl:template match="tia:postbusAdres" mode="do-postbusAdres">
		<xsl:text> postbus </xsl:text>
		<xsl:value-of select="tia:postbusnummer"/>
		<xsl:text>, </xsl:text>
		<xsl:if test="tia:postcode">
			<!-- Insert space between numbers and letters of post code -->
			<xsl:value-of select="concat(normalize-space(substring(tia:postcode, 1, 4)), ' ',normalize-space(substring(tia:postcode, 5)))"/>
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:value-of select="tia:woonplaatsnaam"/>
	</xsl:template>
</xsl:stylesheet>
