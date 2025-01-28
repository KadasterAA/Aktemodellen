<?xml version="1.0" encoding="UTF-8"?>
<!--
*********************************************************
Stylesheet: tekstblok_partij_natuurlijk_persoon.xsl
Version: 2.0
*********************************************************
Description:
Party natural person text block.

Public:
(mode) do-party-natural-person

Private:
(mode) do-party-natural-person-common-part-one
(mode) do-main-person-capacity
(mode) do-party-natural-person-addresses
(mode) do-party-natural-person-single
(mode) do-party-natural-person-person-pair
(mode) do-party-natural-person-person-pair-person-one-common
(mode) do-party-natural-person-person-pair-person-two-common
(mode) do-person-pair-partner-variant-four
(mode) do-person-pair-partner-variant-two
(mode) do-person-pair-representative-variant-five
(mode) do-person-pair-housemate-variant-three
(mode) do-party-person-number-for-natural-person
(mode) do-capacity-variant-for-natural-person
(mode) do-joint-address-marital-status
(mode) do-hoedanigheid-person-data
(mode) do-not-voorzich-data
(mode) do-capacity-variant-for-natural-person-variant

-->
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
	xmlns:kef="nl.kadaster.xslt.XslExtensionFunctions"
	xmlns:tia="http://www.kadaster.nl/schemas/KIK/TIA_Algemeen"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xlink="http://www.w3.org/1999/xlink"
	exclude-result-prefixes="tia xsl xlink kef"
	version="1.0">

	<!--
	*********************************************************
	Mode: do-party-natural-person
	*********************************************************
	Public: yes

	Identity transform: no

	Description: Party natural person text block.

	Input: tia:IMKAD_Persoon

	Params: start - order number of person in nested party
			anchorName - name of the anchor that will be used in first <td> element
			personTerminator - character that is printed at the end of each person's block
			skipPartyNumberColumn - indicator if party number column should not be printed ('false' is default)
			forcePrintingPartyNumber - force printing party number ('false' is default)
			partyNumberingFormat - party numbering format ('1' is default)
			personNumberingFormat - first level person numbering format ('a' is default)

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
		<xsl:param name="start" select="number('0')" />
		<xsl:param name="anchorName" select="''" />
		<xsl:param name="personTerminator" select="';'" />
		<xsl:param name="skipPartyNumberColumn" select="'false'" />
		<xsl:param name="forcePrintingPartyNumber" select="'false'" />
		<xsl:param name="partyNumberingFormat" select="'1'" />
		<xsl:param name="personNumberingFormat" select="'a'" />

		<xsl:choose>
			<xsl:when test="tia:GerelateerdPersoon">
				<xsl:apply-templates select="." mode="do-party-natural-person-person-pair">
					<xsl:with-param name="start" select="$start" />
					<xsl:with-param name="anchorName" select="$anchorName" />
					<xsl:with-param name="personTerminator" select="$personTerminator" />
					<xsl:with-param name="skipPartyNumberColumn" select="$skipPartyNumberColumn" />
					<xsl:with-param name="forcePrintingPartyNumber" select="$forcePrintingPartyNumber" />
					<xsl:with-param name="partyNumberingFormat" select="$partyNumberingFormat" />
					<xsl:with-param name="personNumberingFormat" select="$personNumberingFormat" />
				</xsl:apply-templates>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="." mode="do-party-natural-person-single">
					<xsl:with-param name="start" select="$start" />
					<xsl:with-param name="anchorName" select="$anchorName" />
					<xsl:with-param name="personTerminator" select="$personTerminator" />
					<xsl:with-param name="skipPartyNumberColumn" select="$skipPartyNumberColumn" />
					<xsl:with-param name="forcePrintingPartyNumber" select="$forcePrintingPartyNumber" />
					<xsl:with-param name="partyNumberingFormat" select="$partyNumberingFormat" />
					<xsl:with-param name="personNumberingFormat" select="$personNumberingFormat" />
				</xsl:apply-templates>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--
	*********************************************************
	Mode: do-party-natural-person-common-part-one
	*********************************************************
	Public: no

	Identity transform: no

	Description: First common text block for each type of natural persons.

	Input: tia:IMKAD_Persoon

	Params: none

	Output: text

	Calls:
	(mode) do-natural-person
	(mode) do-identity-document

	Called by:
	(mode) do-party-natural-person-single
	(mode) do-person-pair-partner-variant-two
	(mode) do-person-pair-housemate-variant-three
	(mode) do-person-pair-partner-variant-four
	(mode) do-person-pair-representative-variant-five
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon" mode="do-party-natural-person-common-part-one">
		<xsl:apply-templates select="." mode="do-natural-person" />
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-main-person-capacity
	*********************************************************
	Public: no

	Identity transform: no

	Description: Second common text block for each type of natural persons.

	Input: tia:IMKAD_Persoon

	Params: representerPersons - person which referenced to hoedanigheid, previous person
			relatedPersons - variable where related persons are stored
			hoedanigheid - current hoedanigheid
			personVariant - k_KeuzeblokVariant specified in XML, value can be 1, 2, 3, 4 or 5. When doesn't exist k_KeuzeblokVariant, implies value is 1
			intermedialPerson - true when hoedanigheid is referenced from previous main person and have reference to current main Person
			personNumberingFormat - first level person numbering format ('a' is default)
			onlyPersonWithBullet - true when current person is only person with number (or when other persons are single, or referenced, or voor zich etc.)

	Output: text

	Calls:
	(mode) do-capacity-variant-for-natural-person
	(mode) do-legal-person

	Called by:
	(mode) do-party-natural-person-single
	(mode) do-person-pair-partner-variant-two
	(mode) do-person-pair-housemate-variant-three
	(mode) do-person-pair-partner-variant-four
	(mode) do-person-pair-representative-variant-five
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon" mode="do-main-person-capacity">
		<xsl:param name="representerPersons" select="self::node()[false()]" />
		<xsl:param name="relatedPersons" select="self::node()[false()]" />
		<xsl:param name="hoedanigheid" select="self::node()[false()]" />
		<xsl:param name="personVariant" select="''" />
		<xsl:param name="intermedialPerson" select="false" />
		<xsl:param name="personNumberingFormat" select="'a'" />
		<xsl:param name="onlyPersonWithBullet" select="'false'" />
		<xsl:param name="nestingDepth" select="number('0')" />

		<xsl:variable name="capacityVariant" select="$hoedanigheid/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvariant']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvariant']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space($hoedanigheid/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvariant']/tia:tekst), $upper, $lower)]), $upper, $lower)]" />

		<xsl:if test="$capacityVariant = '5' or $capacityVariant = '6' or $capacityVariant = '7'">
			<xsl:apply-templates select="$hoedanigheid" mode="do-capacity-variant-for-natural-person">
				<xsl:with-param name="representerPersons" select="$representerPersons" />
				<xsl:with-param name="relatedPersons" select="$relatedPersons" />
				<xsl:with-param name="intermedialPerson" select="$intermedialPerson" />
				<xsl:with-param name="numberingFormat" select="translate($personNumberingFormat, '1a', 'a1')" />
				<xsl:with-param name="personVariant" select="$personVariant" />
				<xsl:with-param name="onlyPersonWithBullet" select="$onlyPersonWithBullet" />
				<xsl:with-param name="nestingDepth" select="$nestingDepth" />
			</xsl:apply-templates>
		</xsl:if>
	</xsl:template>

	<!--
	*********************************************************
	Mode: do-party-natural-person-addresses
	*********************************************************
	Public: no

	Identity transform: no

	Description: Common text block for natural persons residential and future addresses (if any).

	Input: tia:IMKAD_Persoon

	Params: commonFutureAddress - determines weather future address part should be printed

	Output: text

	Calls:
	(mode) do-address

	Called by:
	(mode) do-party-natural-person-single
	(mode) do-person-pair-partner-variant-two
	(mode) do-person-pair-housemate-variant-three
	(mode) do-person-pair-partner-variant-four
	(mode) do-person-pair-representative-variant-five
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon" mode="do-party-natural-person-addresses">
		<xsl:param name="commonFutureAddress" select="'true'" />

		<xsl:text>wonende te </xsl:text>
		<xsl:apply-templates select="tia:IMKAD_WoonlocatiePersoon" mode="do-address" />
		<xsl:if test="tia:toekomstigAdres and translate($commonFutureAddress, $upper, $lower) = 'true'">
			<xsl:text> (toekomstig adres: </xsl:text>
			<xsl:apply-templates select="tia:toekomstigAdres" mode="do-address" />
			<xsl:text>)</xsl:text>
		</xsl:if>
	</xsl:template>

	<!--
	*********************************************************
	Mode: do-party-natural-person-single
	*********************************************************
	Public: no

	Identity transform: no

	Description: Party natural single person text block.

	Input: tia:IMKAD_Persoon

	Params: start - order number of person in nested party
			anchorName - name of the anchor that will be positioned in first <td> element
			personTerminator - character that is printed at the end of each person's block
			skipPartyNumberColumn - indicator if party number column should not be printed ('false' is default)
			forcePrintingPartyNumber - force printing party number ('false' is default)
			partyNumberingFormat - party numbering format ('1' is default)
			personNumberingFormat - first level person numbering format ('a' is default)

	Output: XHTML

	Calls:
	(mode) do-party-natural-person-common-part-one
	(mode) do-main-person-capacity
	(mode) do-marital-status
	(mode) do-party-natural-person-addresses

	Called by:
	(mode) do-party-natural-person
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon" mode="do-party-natural-person-single">
		<xsl:param name="start" select="number('0')" />
		<xsl:param name="anchorName" select="''" />
		<xsl:param name="personTerminator" />
		<xsl:param name="skipPartyNumberColumn" select="'false'" />
		<xsl:param name="forcePrintingPartyNumber" select="'false'" />
		<xsl:param name="partyNumberingFormat" select="'1'" />
		<xsl:param name="personNumberingFormat" select="'a'" />

		<xsl:variable name="currentPersonId" select="@id" />
		<xsl:variable name="mainPerson" select="." />
		<xsl:variable name="party" select=".." />
		<xsl:variable name="ordinalNumberOfPersonInParty" select="count(preceding-sibling::tia:IMKAD_Persoon) + 1" />
		<xsl:variable name="numberOfPersons">
			<xsl:value-of select="count(preceding-sibling::tia:IMKAD_Persoon) + count(following-sibling::tia:IMKAD_Persoon)" />
		</xsl:variable>
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
		<xsl:variable name="onlyPersonWithBullet">
			<xsl:choose>
				<!-- When count of PNP persons which are not single and doesn't have Hoedanigheid or just doesn't have Hoedanigheid voor zich or which are single persons and doesn't have Hoedanigheid at all -->
				<xsl:when test="count(preceding-sibling::tia:IMKAD_Persoon[(tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene)
										and ((tia:GerelateerdPersoon and (not(concat('#', @id) = $party/tia:Hoedanigheid/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href']) or concat('#', @id) = $party/tia:Hoedanigheid[not(tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvoorzich'])]/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href']))
										or (not(tia:GerelateerdPersoon) and not(concat('#', @id) = $party/tia:Hoedanigheid/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'])))]) +
								count(following-sibling::tia:IMKAD_Persoon[(tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene)
										and ((tia:GerelateerdPersoon and (not(concat('#', @id) = $party/tia:Hoedanigheid/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href']) or concat('#', @id) = $party/tia:Hoedanigheid[not(tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvoorzich'])]/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href']))
										or (not(tia:GerelateerdPersoon) and not(concat('#', @id) = $party/tia:Hoedanigheid/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'])))]) +
								count($party/tia:IMKAD_Persoon[tia:tia_Gegevens/tia:NHR_Rechtspersoon and not((count(tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder']) = 0) and concat('#', @id) =
								$party/tia:Hoedanigheid/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] and count(preceding-sibling::tia:IMKAD_Persoon) > 0)]) +
								count($party/tia:IMKAD_Persoon[tia:tia_Gegevens/tia:NHR_Rechtspersoon and count(tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder']) > 1]/tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder' and
								preceding-sibling::tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder']]) = 0">
					<xsl:text>true</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>false</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="numberOfPersonPairs">
			<xsl:value-of select="count(preceding-sibling::tia:IMKAD_Persoon[(tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene) and tia:GerelateerdPersoon[tia:rol]])
					+ count(following-sibling::tia:IMKAD_Persoon[(tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene) and tia:GerelateerdPersoon[tia:rol]])" />
		</xsl:variable>
		<xsl:variable name="secondNumberingLevel">
			<xsl:choose>
				<xsl:when test="$numberOfPersonPairs > 0
							and count($party/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[not(concat('#', @id) = $party/tia:Hoedanigheid[not(concat('#', @id) = $party/tia:Gevolmachtigde/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'])]/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'])]) > 0">
					<xsl:text>true</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>false</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="previousPerson" select="preceding-sibling::tia:IMKAD_Persoon[1]" />
		<xsl:variable name="isPreviousPersonNaturalPerson">
			<xsl:choose>
				<xsl:when test="$previousPerson[tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene]">
					<xsl:text>true</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>false</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="previousCapacityExists" select="$party/tia:Hoedanigheid[($previousPerson/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id) or $previousPerson/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id)) and tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#', $currentPersonId)]" />
		<xsl:variable name="followingPerson" select="following-sibling::tia:IMKAD_Persoon[1]" />
		<xsl:variable name="isFollowingPersonNaturalPerson">
			<xsl:choose>
				<xsl:when test="$followingPerson/tia:tia_Gegevens/tia:NHR_Rechtspersoon">
					<xsl:text>false</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>true</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="capacityExists" select="$party/tia:Hoedanigheid[current()/descendant-or-self::tia:IMKAD_Persoon/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id) and not(tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#', $followingPerson/@id))]" />
		<xsl:variable name="positionWithinPerson" select="$start - 1" />
		<xsl:variable name="capacityForNextPerson" select="$party/tia:Hoedanigheid[current()/descendant-or-self::tia:IMKAD_Persoon/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id) and tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#', $followingPerson/@id)]" />
		<xsl:variable name="representerPerson" select="$party/descendant-or-self::tia:IMKAD_Persoon[tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',$capacityForNextPerson/@id)]" />
		<xsl:variable name="referencedPerson" select="$party/descendant-or-self::tia:IMKAD_Persoon[$party/tia:Hoedanigheid[$mainPerson/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id)]/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id)]" />
		<xsl:variable name="isMainPerson" select="$party/@id" /> <!-- If @id is recognized mean that current is main person, not nested -->
		<xsl:variable name="intermedialPerson" select="$party/tia:Hoedanigheid[$representerPerson/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id) and tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href']] and $isMainPerson" />
		<!-- just for nested depth -->
		<xsl:variable name="anyRelatedPersonsWithBullet">
			<xsl:choose>
				<xsl:when test="count(current()/tia:GerelateerdPersoon/tia:IMKAD_Persoon[not($party/tia:Hoedanigheid[concat('#', @id) = $party/descendant::tia:IMKAD_Persoon/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href']]/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#', @id))]) > 0">
					<xsl:text>true</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>false</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="secondLevel">
			<xsl:choose>
				<xsl:when test="($isPreviousPersonNaturalPerson = 'true' and $previousCapacityExists) or
								(not($isPreviousPersonNaturalPerson = 'true' and $previousCapacityExists) and $anyRelatedPersonsWithBullet = 'true') or
								($onlyPersonWithBullet = 'false' and $anyRelatedPersonsWithBullet = 'true')">
					<xsl:text>true</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>false</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="nestingDepth">
			<xsl:choose>
				<xsl:when test="$onlyPersonWithBullet = 'false' and $anyRelatedPersonsWithBullet = 'true' and $secondLevel = 'true'">
					<xsl:text>2</xsl:text>
				</xsl:when>
				<xsl:when test="($onlyPersonWithBullet = 'false' and $anyRelatedPersonsWithBullet = 'false' and $secondLevel = 'false') or ($onlyPersonWithBullet = 'true' and $anyRelatedPersonsWithBullet = 'true' and $secondLevel = 'false')">
					<xsl:text>1</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:if test="not($isPreviousPersonNaturalPerson = 'true' and $previousCapacityExists)">
			<tr>
				<td>
					<table>
						<tbody>
							<tr>
								<xsl:if test="not($skipPartyNumberColumn = 'true')">
									<xsl:choose>
										<xsl:when test="$party/tia:Gevolmachtigde[tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#', $party/tia:Hoedanigheid[count(tia:wordtVertegenwoordigdRef) = 0]/@id)] and not($forcePrintingPartyNumber = 'true')">
											<td class="number" valign="top">
												<xsl:text>&#xFEFF;</xsl:text>
											</td>
										</xsl:when>
										<xsl:otherwise>
											<xsl:choose>
												<xsl:when test="count(preceding-sibling::tia:IMKAD_Persoon) = 0">
													<!-- Party letter printed in case of first person -->
													<td class="number" valign="top">
														<a name="{$anchorName}" class="location" style="_position: relative;">&#xFEFF;</a>
														<xsl:number value="count(../preceding-sibling::tia:Partij) + 1" format="{$partyNumberingFormat}" />
														<xsl:text>.</xsl:text>
													</td>
												</xsl:when>
												<xsl:otherwise>
													<td class="number" valign="top">
														<xsl:text>&#xFEFF;</xsl:text>
													</td>
												</xsl:otherwise>
											</xsl:choose>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:if>
								<td>
									<table>
										<tbody>
										<tr>
											<xsl:if test="$onlyPersonWithBullet = 'false'">
												<td class="number" valign="top">
													<xsl:apply-templates mode="do-party-person-number-for-natural-person" select="$mainPerson">
														<xsl:with-param name="numberingFormat" select="$personNumberingFormat" />
														<xsl:with-param name="currentParty" select="$party" />
														<xsl:with-param name="ordinalNumberOfPersonInParty" select="$ordinalNumberOfPersonInParty" />
													</xsl:apply-templates>
												</td>
											</xsl:if>
											<td class="level0">
												<xsl:apply-templates select="." mode="do-party-natural-person-common-part-one" />
												<xsl:if test="tia:tia_BurgerlijkeStaatTekst">
													<xsl:text>, </xsl:text>
												</xsl:if>
												<xsl:apply-templates select="." mode="do-marital-status" />
												<xsl:text>, </xsl:text>
												<xsl:apply-templates select="." mode="do-party-natural-person-addresses" />
												<xsl:choose>
													<xsl:when test="$capacityForNextPerson and $isFollowingPersonNaturalPerson = 'true'">
														<xsl:text>, </xsl:text>
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
							<!-- when single person reference other single person through NOT voor zich Hoedanigheid -->
							<xsl:if test="$capacityForNextPerson and $isFollowingPersonNaturalPerson = 'true'">
								<tr>
									<td class="number" valign="top">
										<xsl:text>&#xFEFF;</xsl:text>
									</td>
									<td>
										<table>
											<tbody>
												<tr>
													<td class="level0">
														<xsl:apply-templates select="$followingPerson" mode="do-main-person-capacity">
															<xsl:with-param name="representerPersons" select="$representerPerson" />
															<xsl:with-param name="relatedPersons" select="$referencedPerson" />
															<xsl:with-param name="hoedanigheid" select="$capacityForNextPerson" />
															<xsl:with-param name="intermedialPerson" select="$intermedialPerson" />
															<xsl:with-param name="personVariant" select="'1'" />
															<xsl:with-param name="personNumberingFormat" select="$personNumberingFormat" />
															<xsl:with-param name="onlyPersonWithBullet" select="number($onlyPersonWithBullet)" />
														</xsl:apply-templates>
													</td>
												</tr>
											</tbody>
										</table>
									</td>
								</tr>
							</xsl:if>
						</tbody>
					</table>
				</td>
			</tr>
		</xsl:if>
	</xsl:template>

	<!--
	*********************************************************
	Mode: do-party-natural-person-person-pair
	*********************************************************
	Public: no

	Identity transform: no

	Description: Party natural persons pair text block.

	Input: tia:IMKAD_Persoon

	Params: start - order number of person in nested party
			anchorName - name of the anchor that will be positioned in first <td> element
			personTerminator - character that is printed at the end of each person's block
			skipPartyNumberColumn - indicator if party number column should not be printed ('false' is default)
			forcePrintingPartyNumber - force printing party number ('false' is default)
			partyNumberingFormat - party numbering format ('1' is default)
			personNumberingFormat - first level person numbering format ('a' is default)

	Output: XHTML

	Calls:
	(mode) do-person-pair-partner-variant-two
	(mode) do-person-pair-housemate-variant-three
	(mode) do-person-pair-partner-variant-four
	(mode) do-person-pair-representative-variant-five

	Called by:
	(mode) do-party-natural-person
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon" mode="do-party-natural-person-person-pair">
		<xsl:param name="start" select="number('0')" />
		<xsl:param name="anchorName" select="''" />
		<xsl:param name="personTerminator" />
		<xsl:param name="skipPartyNumberColumn" select="'false'" />
		<xsl:param name="forcePrintingPartyNumber" select="'false'" />
		<xsl:param name="partyNumberingFormat" select="'1'" />
		<xsl:param name="personNumberingFormat" select="'a'" />

		<xsl:variable name="personPairVariant" select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_keuzeblokvariant']/tia:tekst" />

		<xsl:choose>
			<xsl:when test="$personPairVariant = '2'">
				<xsl:apply-templates select="." mode="do-person-pair-partner-variant-two">
					<xsl:with-param name="start" select="$start" />
					<xsl:with-param name="anchorName" select="$anchorName" />
					<xsl:with-param name="personTerminator" select="$personTerminator" />
					<xsl:with-param name="skipPartyNumberColumn" select="$skipPartyNumberColumn" />
					<xsl:with-param name="forcePrintingPartyNumber" select="$forcePrintingPartyNumber" />
					<xsl:with-param name="partyNumberingFormat" select="$partyNumberingFormat" />
					<xsl:with-param name="personNumberingFormat" select="$personNumberingFormat" />
				</xsl:apply-templates>
			</xsl:when>
			<xsl:when test="$personPairVariant = '3'">
				<xsl:apply-templates select="." mode="do-person-pair-housemate-variant-three">
					<xsl:with-param name="start" select="$start" />
					<xsl:with-param name="anchorName" select="$anchorName" />
					<xsl:with-param name="personTerminator" select="$personTerminator" />
					<xsl:with-param name="skipPartyNumberColumn" select="$skipPartyNumberColumn" />
					<xsl:with-param name="forcePrintingPartyNumber" select="$forcePrintingPartyNumber" />
					<xsl:with-param name="partyNumberingFormat" select="$partyNumberingFormat" />
					<xsl:with-param name="personNumberingFormat" select="$personNumberingFormat" />
				</xsl:apply-templates>
			</xsl:when>
			<xsl:when test="$personPairVariant = '4'">
				<xsl:apply-templates select="." mode="do-person-pair-partner-variant-four">
					<xsl:with-param name="start" select="$start" />
					<xsl:with-param name="anchorName" select="$anchorName" />
					<xsl:with-param name="personTerminator" select="$personTerminator" />
					<xsl:with-param name="skipPartyNumberColumn" select="$skipPartyNumberColumn" />
					<xsl:with-param name="forcePrintingPartyNumber" select="$forcePrintingPartyNumber" />
					<xsl:with-param name="partyNumberingFormat" select="$partyNumberingFormat" />
					<xsl:with-param name="personNumberingFormat" select="$personNumberingFormat" />
				</xsl:apply-templates>
			</xsl:when>
			<xsl:when test="$personPairVariant = '5'">
				<xsl:apply-templates select="." mode="do-person-pair-representative-variant-five">
					<xsl:with-param name="start" select="$start" />
					<xsl:with-param name="anchorName" select="$anchorName" />
					<xsl:with-param name="personTerminator" select="$personTerminator" />
					<xsl:with-param name="skipPartyNumberColumn" select="$skipPartyNumberColumn" />
					<xsl:with-param name="forcePrintingPartyNumber" select="$forcePrintingPartyNumber" />
					<xsl:with-param name="partyNumberingFormat" select="$partyNumberingFormat" />
					<xsl:with-param name="personNumberingFormat" select="$personNumberingFormat" />
				</xsl:apply-templates>
			</xsl:when>
			<!-- Partner is default for preview -->
			<xsl:otherwise>
				<xsl:apply-templates select="." mode="do-person-pair-partner-variant-four">
					<xsl:with-param name="start" select="$start" />
					<xsl:with-param name="anchorName" select="$anchorName" />
					<xsl:with-param name="personTerminator" select="$personTerminator" />
					<xsl:with-param name="skipPartyNumberColumn" select="$skipPartyNumberColumn" />
					<xsl:with-param name="forcePrintingPartyNumber" select="$forcePrintingPartyNumber" />
					<xsl:with-param name="partyNumberingFormat" select="$partyNumberingFormat" />
					<xsl:with-param name="personNumberingFormat" select="$personNumberingFormat" />
				</xsl:apply-templates>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--
	*********************************************************
	Mode: do-party-natural-person-person-pair-person-one-common
	*********************************************************
	Public: no

	Identity transform: no

	Description: Common text block for first person in person pair.

	Input: tia:IMKAD_Persoon

	Params: start - order number of person in nested party
			anchorName - name of the anchor that will be positioned in first <td> element
			onlyPersonWithBullet - true when current person is only person with number (or when other persons are single, or referenced, or voor zich etc.)
			anyRelatedPersonsWithBullet - ?
			skipPartyNumberColumn - indicator if party number column should not be printed ('false' is default)
			forcePrintingPartyNumber - force printing party number ('false' is default)
			partyNumberingFormat - party numbering format ('1' is default)
			personNumberingFormat - first level person numbering format ('a' is default)

	Output: XHTML

	Calls: none

	Called by:
	(mode) do-person-pair-partner-variant-two
	(mode) do-person-pair-housemate-variant-three
	(mode) do-person-pair-partner-variant-four
	(mode) do-person-pair-representative-variant-five
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon" mode="do-party-natural-person-person-pair-person-one-common">
		<xsl:param name="start" select="number('0')" />
		<xsl:param name="anchorName" select="''" />
		<xsl:param name="onlyPersonWithBullet" select="'false'" />
		<xsl:param name="anyRelatedPersonsWithBullet" select="'false'" />
		<xsl:param name="skipPartyNumberColumn" select="'false'" />
		<xsl:param name="forcePrintingPartyNumber" select="'false'" />
		<xsl:param name="partyNumberingFormat" select="'1'" />
		<xsl:param name="personNumberingFormat" select="'a'" />

		<xsl:variable name="numberOfPersons" select="count(preceding-sibling::tia:IMKAD_Persoon) + count(following-sibling::tia:IMKAD_Persoon)" />
		<xsl:variable name="mainPerson" select="." />
		<xsl:variable name="party" select=".." />
		<xsl:variable name="ordinalNumberOfPersonInParty" select="count(preceding-sibling::tia:IMKAD_Persoon) + 1" />
		<xsl:variable name="positionWithinPerson" select="$start - 1" />

		<xsl:if test="not($skipPartyNumberColumn = 'true')">
			<xsl:choose>
				<xsl:when test="$party/tia:Gevolmachtigde[tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#', $party/tia:Hoedanigheid[count(tia:wordtVertegenwoordigdRef) = 0]/@id)] and not($forcePrintingPartyNumber = 'true')">
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="count(preceding-sibling::tia:IMKAD_Persoon) = 0">
							<!-- Party letter printed in case of first person -->
							<td class="number" valign="top">
								<xsl:choose>
									<xsl:when test="$anchorName != ''">
										<a name="{$anchorName}" class="location" style="_position: relative;">&#xFEFF;</a>
									</xsl:when>
									<xsl:otherwise>
										<a name="{current()/parent::node()/@id}" class="location" style="_position: relative;">&#xFEFF;</a>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:number value="count(../preceding-sibling::tia:Partij) + 1" format="{$partyNumberingFormat}" />
								<xsl:text>.</xsl:text>
							</td>
						</xsl:when>
						<xsl:otherwise>
							<td class="number" valign="top">
								<xsl:text>&#xFEFF;</xsl:text>
							</td>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
		<xsl:if test="$onlyPersonWithBullet = 'false' or ($onlyPersonWithBullet = 'true' and $anyRelatedPersonsWithBullet = 'true')">
			<xsl:choose>
				<xsl:when test="$numberOfPersons = 0">
					<td class="number" valign="top">
						<xsl:number value="1" format="{$personNumberingFormat}" />
						<xsl:text>.</xsl:text>
					</td>
				</xsl:when>
				<xsl:otherwise>
					<xsl:variable name="numberingFormat">
						<xsl:choose>
							<xsl:when test="$onlyPersonWithBullet = 'false' or $anyRelatedPersonsWithBullet = 'true'">
								<xsl:value-of select="$personNumberingFormat" />
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="translate($personNumberingFormat, '1a', 'a1')" />
							</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
					<td class="number" valign="top">
						<xsl:apply-templates mode="do-party-person-number-for-natural-person" select="$mainPerson">
							<xsl:with-param name="numberingFormat" select="$numberingFormat" />
							<xsl:with-param name="currentParty" select="$party" />
							<xsl:with-param name="ordinalNumberOfPersonInParty" select="$ordinalNumberOfPersonInParty" />
						</xsl:apply-templates>
					</td>
					<xsl:if test="$onlyPersonWithBullet = 'false' and $anyRelatedPersonsWithBullet = 'true'">
						<td class="number" valign="top">
							<xsl:number value="1" format="{translate($personNumberingFormat, '1a', 'a1')}" />
							<xsl:text>.</xsl:text>
						</td>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>

	<!--
	*********************************************************
	Mode: do-party-natural-person-person-pair-person-two-common
	*********************************************************
	Public: no

	Identity transform: no

	Description: Common text block for second and further persons in person pair.

	Input: tia:IMKAD_Persoon

	Params: onlyPersonWithBullet - true when current person is only person with number (or when other persons are single, or referenced, or voor zich etc.)
			anyRelatedPersonsWithBullet - ?
			secondLevel - ?
			position - position of currently processed person
			skipPartyNumberColumn - indicator if party number column should not be printed ('false' is default)
			personNumberingFormat - first level person numbering format ('a' is default)

	Output: XHTML

	Calls: none

	Called by:
	(mode) do-person-pair-partner-variant-two
	(mode) do-person-pair-housemate-variant-three
	(mode) do-person-pair-partner-variant-four
	(mode) do-person-pair-representative-variant-five
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon" mode="do-party-natural-person-person-pair-person-two-common">
		<xsl:param name="onlyPersonWithBullet" select="'false'" />
		<xsl:param name="anyRelatedPersonsWithBullet" select="'false'" />
		<xsl:param name="secondLevel" select="'true'" />
		<xsl:param name="position" select="number('0')" />
		<xsl:param name="skipPartyNumberColumn" select="'false'" />
		<xsl:param name="personNumberingFormat" select="'a'" />

		<xsl:variable name="party" select="../../.." />
		<xsl:variable name="ordinalNumberOfPersonInParty" select="count(../../preceding-sibling::tia:IMKAD_Persoon) + 1" />
		<xsl:variable name="numberOfPersons" select="count(../../preceding-sibling::tia:IMKAD_Persoon) + count(../../following-sibling::tia:IMKAD_Persoon)" />

		<xsl:if test="not($skipPartyNumberColumn = 'true')">
			<td class="number" valign="top">
				<xsl:text>&#xFEFF;</xsl:text>
			</td>
		</xsl:if>
		<xsl:choose>
			<xsl:when test="$numberOfPersons = 0">
				<td class="number" valign="top">
					<xsl:choose>
						<xsl:when test="$position != 0">
							<xsl:number value="$position + 1" format="{$personNumberingFormat}" />
						</xsl:when>
						<xsl:otherwise>
							<xsl:number value="2" format="{$personNumberingFormat}" />
						</xsl:otherwise>
					</xsl:choose>
					<xsl:text>.</xsl:text>
				</td>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="$onlyPersonWithBullet = 'false' and $anyRelatedPersonsWithBullet = 'true' and $secondLevel = 'true'">
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
				</xsl:if>
				<xsl:variable name="numberingFormat">
					<xsl:choose>
						<xsl:when test="$onlyPersonWithBullet = 'false' and $anyRelatedPersonsWithBullet = 'true' and $secondLevel = 'true'">
							<xsl:value-of select="translate($personNumberingFormat, '1a', 'a1')" />
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$personNumberingFormat" />
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<td class="number" valign="top">
					<xsl:apply-templates mode="do-party-person-number-for-natural-person" select="../..">
						<xsl:with-param name="numberingFormat" select="$numberingFormat" />
						<xsl:with-param name="currentParty" select="$party" />
						<xsl:with-param name="ordinalNumberOfPersonInParty" select="$ordinalNumberOfPersonInParty" />
						<xsl:with-param name="positionWithinPerson" select="$position" />
						<xsl:with-param name="secondLevel" select="$secondLevel" />
					</xsl:apply-templates>
				</td>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--
	*********************************************************
	Mode: do-person-pair-partner-variant-four
	*********************************************************
	Public: no

	Identity transform: no

	Description: Two natural persons (partners) with joint marital status and joint residential address.

	Input: tia:IMKAD_Persoon

	Params: start - order number of person in nested party
			anchorName - name of the anchor that will be positioned in first <td> element
			personTerminator - character that is printed at the end of each person's block
			skipPartyNumberColumn - indicator if party number column should not be printed ('false' is default)
			forcePrintingPartyNumber - force printing party number ('false' is default)
			partyNumberingFormat - party numbering format ('1' is default)
			personNumberingFormat - first level person numbering format ('a' is default)

	Output: XHTML

	Calls:
	(mode) do-party-natural-person-person-pair-person-one-common
	(mode) do-party-natural-person-person-pair-person-two-common
	(mode) do-natural-person
	(mode) do-identity-document
	(mode) do-party-natural-person-common-part-one
	(mode) do-marital-status-partners
	(mode) do-party-natural-person-addresses

	Called by:
	(mode) do-party-natural-person-person-pair
	-->
	<xsl:template match="tia:IMKAD_Persoon" mode="do-person-pair-partner-variant-four">
		<xsl:param name="start" select="number('0')" />
		<xsl:param name="anchorName" select="''" />
		<xsl:param name="personTerminator" />
		<xsl:param name="skipPartyNumberColumn" select="'false'" />
		<xsl:param name="forcePrintingPartyNumber" select="'false'" />
		<xsl:param name="partyNumberingFormat" select="'1'" />
		<xsl:param name="personNumberingFormat" select="'a'" />

		<xsl:variable name="party" select=".." />
		<xsl:variable name="currentMainPerson" select="." />
		<xsl:variable name="currentPersonId" select="@id" />
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
		<xsl:variable name="onlyPersonWithBullet">
			<xsl:choose>
				<!-- When count of PNP persons which are not single and doesn't have Hoedanigheid or just doesn't have Hoedanigheid voor zich or which are single persons and doesn't have Hoedanigheid at all -->
				<xsl:when test="count(preceding-sibling::tia:IMKAD_Persoon[(tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene)
										and ((tia:GerelateerdPersoon and (not(concat('#', @id) = $party/tia:Hoedanigheid/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href']) or concat('#', @id) = $party/tia:Hoedanigheid[not(tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvoorzich'])]/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href']))
										or (not(tia:GerelateerdPersoon) and not(concat('#', @id) = $party/tia:Hoedanigheid/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'])))]) +
								count(following-sibling::tia:IMKAD_Persoon[(tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene)
										and ((tia:GerelateerdPersoon and (not(concat('#', @id) = $party/tia:Hoedanigheid/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href']) or concat('#', @id) = $party/tia:Hoedanigheid[not(tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvoorzich'])]/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href']))
										or (not(tia:GerelateerdPersoon) and not(concat('#', @id) = $party/tia:Hoedanigheid/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'])))]) +
								count($party/tia:IMKAD_Persoon[tia:tia_Gegevens/tia:NHR_Rechtspersoon and not((count(tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder']) = 0) and concat('#', @id) =
								$party/tia:Hoedanigheid/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] and count(preceding-sibling::tia:IMKAD_Persoon) > 0)]) +
								count($party/tia:IMKAD_Persoon[tia:tia_Gegevens/tia:NHR_Rechtspersoon and count(tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder']) > 1]/tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder' and
								preceding-sibling::tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder']]) = 0">
					<xsl:text>true</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>false</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="anyRelatedPersonsWithBullet">
			<xsl:choose>
				<xsl:when test="count(current()/tia:GerelateerdPersoon/tia:IMKAD_Persoon[not($party/tia:Hoedanigheid[concat('#', @id) = $party/descendant::tia:IMKAD_Persoon/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href']]/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#', @id))]) > 0">
					<xsl:text>true</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>false</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="partner" select="tia:GerelateerdPersoon/tia:IMKAD_Persoon" />
		<xsl:variable name="followingPerson" select="following-sibling::tia:IMKAD_Persoon[1]" />
		<xsl:variable name="isFollowingPersonNaturalPerson">
			<xsl:choose>
				<xsl:when test="$followingPerson/tia:tia_Gegevens/tia:NHR_Rechtspersoon">
					<xsl:text>false</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>true</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="capacityExists" select="$party/tia:Hoedanigheid[current()/descendant-or-self::tia:IMKAD_Persoon/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id) and tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#', $currentMainPerson/tia:GerelateerdPersoon/tia:IMKAD_Persoon/@id)]" />
		<xsl:variable name="partnersAuthorizedRepresentative" select="$party/tia:Gevolmachtigde[tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',$party/tia:Hoedanigheid[tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',$partner/@id)]/@id)]" />
		<xsl:variable name="authorizedRepresentativeHoedanigheid" select="$party/tia:Hoedanigheid[concat('#',@id) = $party/tia:Gevolmachtigde/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] and tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',$partner/@id)]" />
		<xsl:variable name="capacityForNextPerson" select="$party/tia:Hoedanigheid[current()/descendant-or-self::tia:IMKAD_Persoon/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id) and tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#', $followingPerson/@id)]" />
		<xsl:variable name="previousPerson" select="preceding-sibling::tia:IMKAD_Persoon[1]" />
		<xsl:variable name="isPreviousPersonNaturalPerson">
			<xsl:choose>
				<xsl:when test="$previousPerson[tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene]">
					<xsl:text>true</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>false</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="previousCapacityExists" select="$party/tia:Hoedanigheid[($previousPerson/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id) or $previousPerson/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id)) and tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#', $currentPersonId)]" />
		<xsl:variable name="representerPerson" select="$party/descendant-or-self::tia:IMKAD_Persoon[tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',$capacityForNextPerson/@id)]" />
		<xsl:variable name="referencedPerson" select="$party/descendant-or-self::tia:IMKAD_Persoon[$party/tia:Hoedanigheid[$currentMainPerson/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id)]/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id)]" />
		<xsl:variable name="representerKeuzeblokVariant" select="$representerPerson/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_keuzeblokvariant']/tia:tekst" />
		<xsl:variable name="isMainPerson" select="$party/@id" /> <!-- If @id is recognized mean that current is main person, not nested -->
		<xsl:variable name="intermedialPerson" select="$party/tia:Hoedanigheid[$representerPerson/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id) and tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href']] and $isMainPerson" />
		<xsl:variable name="forThem" select="$previousCapacityExists/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvoorzich']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
				translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvoorzich']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
				translate(normalize-space($previousCapacityExists/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvoorzich']/tia:tekst), $upper, $lower)]), $upper, $lower)]" />
		<xsl:variable name="numberOfPrecedingPersonsRepresentingFollowingPerson" select="count(preceding::tia:IMKAD_Persoon[tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',$capacityForNextPerson/@id)])" />
		<xsl:variable name="secondLevel">
			<xsl:choose>
				<xsl:when test="($isPreviousPersonNaturalPerson = 'true' and $previousCapacityExists) or
								(not($isPreviousPersonNaturalPerson = 'true' and $previousCapacityExists) and $anyRelatedPersonsWithBullet = 'true') or
								($onlyPersonWithBullet = 'false' and $anyRelatedPersonsWithBullet = 'true')">
					<xsl:text>true</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>false</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="nestingDepth">
			<xsl:choose>
				<xsl:when test="$onlyPersonWithBullet = 'false' and $anyRelatedPersonsWithBullet = 'true' and $secondLevel = 'true'">
					<xsl:text>2</xsl:text>
				</xsl:when>
				<xsl:when test="($onlyPersonWithBullet = 'false' and $anyRelatedPersonsWithBullet = 'false' and $secondLevel = 'false') or ($onlyPersonWithBullet = 'true' and $anyRelatedPersonsWithBullet = 'true' and $secondLevel = 'false')">
					<xsl:text>1</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<!-- Doesn't contain hoedanigheid which is referenced from previousPerson and which reference to current person or contain such hoedanigheid but is not voor zich -->
		<xsl:if test="not($previousCapacityExists) or (not($forThem) and $previousCapacityExists)">
			<tr>
				<td>
					<table>
						<tbody>
							<tr>
								<xsl:apply-templates select="." mode="do-party-natural-person-person-pair-person-one-common">
									<xsl:with-param name="start" select="$start" />
									<xsl:with-param name="anchorName" select="$anchorName" />
									<xsl:with-param name="onlyPersonWithBullet" select="$onlyPersonWithBullet" />
									<xsl:with-param name="anyRelatedPersonsWithBullet" select="$anyRelatedPersonsWithBullet" />
									<xsl:with-param name="skipPartyNumberColumn" select="$skipPartyNumberColumn" />
									<xsl:with-param name="forcePrintingPartyNumber" select="$forcePrintingPartyNumber" />
									<xsl:with-param name="partyNumberingFormat" select="$partyNumberingFormat" />
									<xsl:with-param name="personNumberingFormat" select="$personNumberingFormat" />
								</xsl:apply-templates>
								<td>
									<xsl:apply-templates select="." mode="do-party-natural-person-common-part-one" />
									<xsl:choose>
										<xsl:when test="$capacityExists and not($partnersAuthorizedRepresentative)">
											<xsl:text>, </xsl:text>
											<xsl:apply-templates select="$capacityExists" mode="do-capacity-variant-for-natural-person">
												<xsl:with-param name="nestingDepth" select="number($nestingDepth)" />
												<xsl:with-param name="representerPersons" select="." />
												<xsl:with-param name="relatedPersons" select="$referencedPerson" />
												<xsl:with-param name="numberingFormat" select="translate($personNumberingFormat, '1a', 'a1')" />
											</xsl:apply-templates>
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
			<!-- No Hoedanigheid which reference any GerelateerdPersoon from current main person and none person reference to it -->
			<xsl:if test="count($party/tia:Hoedanigheid[tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#', $partner/@id) and $party/descendant-or-self::tia:IMKAD_Persoon/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#', @id)]) = 0">
				<xsl:variable name="secondLevel2">
					<xsl:choose>
						<xsl:when test="($isPreviousPersonNaturalPerson = 'true' and $previousCapacityExists) or
										(not($isPreviousPersonNaturalPerson = 'true' and $previousCapacityExists) and $anyRelatedPersonsWithBullet = 'true') or
										($onlyPersonWithBullet = 'false' and $anyRelatedPersonsWithBullet = 'true')">
							<xsl:text>true</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>false</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<xsl:variable name="positionWithinPerson" select="count(preceding-sibling::tia:GerelateerdPersoon/tia:IMKAD_Persoon[not(concat('#', @id) = $party/tia:Hoedanigheid/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'])])
																+ count($party/tia:Hoedanigheid[concat('#', @id) = $party/tia:Gevolmachtigde/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] and substring-after(tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'], '#') = current()/preceding-sibling::tia:GerelateerdPersoon/tia:IMKAD_Persoon/@id])
																+ 1" />

				<tr>
					<td>
						<table>
							<tbody>
								<tr>
									<xsl:apply-templates select="$partner" mode="do-party-natural-person-person-pair-person-two-common">
										<xsl:with-param name="onlyPersonWithBullet" select="$onlyPersonWithBullet" />
										<xsl:with-param name="anyRelatedPersonsWithBullet" select="$anyRelatedPersonsWithBullet" />
										<xsl:with-param name="secondLevel" select="$secondLevel2" />
										<xsl:with-param name="position" select="$positionWithinPerson" />
										<xsl:with-param name="skipPartyNumberColumn" select="$skipPartyNumberColumn" />
										<xsl:with-param name="personNumberingFormat" select="$personNumberingFormat" />
									</xsl:apply-templates>
									<td>
										<xsl:if test="$partnersAuthorizedRepresentative">
											<xsl:choose>
												<xsl:when test="$authorizedRepresentativeHoedanigheid">
													<xsl:apply-templates select="$partnersAuthorizedRepresentative" mode="do-legal-representative">
														<xsl:with-param name="capacityPerson" select="$authorizedRepresentativeHoedanigheid" />
													</xsl:apply-templates>
												</xsl:when>
												<xsl:otherwise>
													<xsl:apply-templates select="$partnersAuthorizedRepresentative" mode="do-legal-representative" />
												</xsl:otherwise>
											</xsl:choose>
											<xsl:text> </xsl:text>
										</xsl:if>
										<xsl:apply-templates select="$partner" mode="do-party-natural-person-common-part-one" />
										<xsl:text>;</xsl:text>
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
								<xsl:if test="not($skipPartyNumberColumn = 'true')">
									<td class="number" valign="top">
										<xsl:text>&#xFEFF;</xsl:text>
									</td>
								</xsl:if>
								<xsl:if test="$onlyPersonInParty = 'false' and $onlyPersonWithBullet = 'false'">
									<td class="number" valign="top">
										<xsl:text>&#xFEFF;</xsl:text>
									</td>
								</xsl:if>
								<!-- When previous main person represent current person throught voor zich Hoedanigheid than need to be moved column to right -->
								<xsl:if test="$forThem and $previousPerson/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',$previousCapacityExists/@id) and $previousCapacityExists/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id)">
									<td class="number" valign="top">
										<xsl:text>&#xFEFF;</xsl:text>
									</td>
								</xsl:if>
								<td>
									<!-- Print Hoedanigheid for Person and GerelateerdPersoon; when GerelateerdPersoon > 1 nestingDepth = 1, otherwise 0 -->
									<xsl:variable name="nestingDepthForExternalPrintOfHoedanigheid">
										<xsl:choose>
											<xsl:when test="$nestingDepth > 1">
												<xsl:value-of select="number('1')" />
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="number('0')" />
											</xsl:otherwise>
										</xsl:choose>
									</xsl:variable>
									<xsl:apply-templates select="." mode="do-joint-address-marital-status" />
									<xsl:choose>
										<xsl:when test="$capacityForNextPerson and $isFollowingPersonNaturalPerson = 'true' and $numberOfPrecedingPersonsRepresentingFollowingPerson = 0">
											<xsl:text>, </xsl:text>
											<xsl:apply-templates select="$followingPerson" mode="do-main-person-capacity">
												<xsl:with-param name="representerPersons" select="$representerPerson" />
												<xsl:with-param name="relatedPersons" select="$party/descendant-or-self::tia:IMKAD_Persoon[$capacityForNextPerson/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id)]" />
												<xsl:with-param name="hoedanigheid" select="$capacityForNextPerson" />
												<xsl:with-param name="intermedialPerson" select="$intermedialPerson" />
												<xsl:with-param name="personVariant" select="'4'" />
												<xsl:with-param name="personNumberingFormat" select="$personNumberingFormat" />
												<xsl:with-param name="onlyPersonWithBullet" select="$onlyPersonWithBullet" />
												<xsl:with-param name="nestingDepth" select="$nestingDepthForExternalPrintOfHoedanigheid" />
											</xsl:apply-templates>
										</xsl:when>
										<xsl:when test="$capacityForNextPerson and $isFollowingPersonNaturalPerson = 'true' and $numberOfPrecedingPersonsRepresentingFollowingPerson > 0">
											<xsl:text>,</xsl:text>
										</xsl:when>
										<xsl:when test="not($capacityForNextPerson)">
											<xsl:text>;</xsl:text>
										</xsl:when>
									</xsl:choose>
								</td>
							</tr>
						</tbody>
					</table>
				</td>
			</tr>
			<!-- Print intermedialPerson Hoedanigheid; nestingDepth = 0 -->
			<xsl:if test="$numberOfPrecedingPersonsRepresentingFollowingPerson > 0">
				<tr>
					<td>
						<table>
							<tbody>
								<tr>
									<td class="number" valign="top">
										<xsl:text>&#xFEFF;</xsl:text>
									</td>
									<td>
										<xsl:apply-templates select="$followingPerson" mode="do-main-person-capacity">
											<xsl:with-param name="representerPersons" select="$representerPerson"/>
											<xsl:with-param name="relatedPersons"
															select="$party/descendant-or-self::tia:IMKAD_Persoon[$capacityForNextPerson/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id)]"/>
											<xsl:with-param name="hoedanigheid" select="$capacityForNextPerson"/>
											<xsl:with-param name="intermedialPerson" select="$intermedialPerson"/>
											<xsl:with-param name="personVariant" select="'4'"/>
											<xsl:with-param name="personNumberingFormat" select="$personNumberingFormat"/>
											<xsl:with-param name="onlyPersonWithBullet" select="$onlyPersonWithBullet"/>
										</xsl:apply-templates>
									</td>
								</tr>
							</tbody>
						</table>
					</td>
				</tr>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<!--
	*********************************************************
	Mode: do-person-pair-partner-variant-two
	*********************************************************
	Public: no

	Identity transform: no

	Description: Two natural persons (partners) with joint marital status.

	Input: tia:IMKAD_Persoon

	Params: start - order number of person in nested party
			anchorName - name of the anchor that will be positioned in first <td> element
			personTerminator - character that is printed at the end of each person's block
			skipPartyNumberColumn - indicator if party number column should not be printed ('false' is default)
			forcePrintingPartyNumber - force printing party number ('false' is default)
			partyNumberingFormat - party numbering format ('1' is default)
			personNumberingFormat - first level person numbering format ('a' is default)

	Output: XHTML

	Calls:
	(mode) do-party-natural-person-person-pair-person-one-common
	(mode) do-party-natural-person-person-pair-person-two-common
	(mode) do-party-natural-person-common-part-one
	(mode) do-main-person-capacity
	(mode) do-party-natural-person-addresses
	(mode) do-address
	(mode) do-marital-status-partners
	(mode) do-capacity-variant-for-natural-person
	(mode) do-legal-representative
	(mode) do-gender-salutation
	(mode) do-legal-person

	Called by:
	(mode) do-party-natural-person-person-pair
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon" mode="do-person-pair-partner-variant-two">
		<xsl:param name="start" select="number('0')" />
		<xsl:param name="anchorName" select="''" />
		<xsl:param name="personTerminator" />
		<xsl:param name="skipPartyNumberColumn" select="'false'" />
		<xsl:param name="forcePrintingPartyNumber" select="'false'" />
		<xsl:param name="partyNumberingFormat" select="'1'" />
		<xsl:param name="personNumberingFormat" select="'a'" />

		<xsl:variable name="party" select=".." />
		<xsl:variable name="currentMainPerson" select="." />
		<xsl:variable name="currentPersonId" select="@id" />
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
		<xsl:variable name="previousPerson" select="preceding-sibling::tia:IMKAD_Persoon[1]" />
		<xsl:variable name="previousCapacityExists" select="$party/tia:Hoedanigheid[($previousPerson/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id) or $previousPerson/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id)) and tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#', $currentPersonId)]" />
		<xsl:variable name="followingPerson" select="following-sibling::tia:IMKAD_Persoon[1]" />
		<xsl:variable name="capacityForNextPerson" select="$party/tia:Hoedanigheid[current()/descendant-or-self::tia:IMKAD_Persoon/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id) and tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#', $followingPerson/@id)]" />
		<xsl:variable name="representerPerson" select="$party/descendant-or-self::tia:IMKAD_Persoon[tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',$capacityForNextPerson/@id)]" />
		<xsl:variable name="referencedPerson" select="$party/descendant-or-self::tia:IMKAD_Persoon[$party/tia:Hoedanigheid[$currentMainPerson/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id)]/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id)]" />
		<xsl:variable name="representerKeuzeblokVariant" select="$representerPerson/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_keuzeblokvariant']/tia:tekst" />
		<xsl:variable name="isMainPerson" select="$party/@id" /> <!-- If @id is recognized mean that current is main person, not nested -->
		<xsl:variable name="intermedialPerson" select="$party/tia:Hoedanigheid[$representerPerson/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id) and tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href']] and $isMainPerson" />
		<xsl:variable name="onlyPersonWithBullet">
			<xsl:choose>
				<!-- When count of PNP persons which are not single and doesn't have Hoedanigheid or just doesn't have Hoedanigheid voor zich or which are single persons and doesn't have Hoedanigheid at all -->
				<xsl:when test="count(preceding-sibling::tia:IMKAD_Persoon[(tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene)
										and ((tia:GerelateerdPersoon and (not(concat('#', @id) = $party/tia:Hoedanigheid/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href']) or concat('#', @id) = $party/tia:Hoedanigheid[not(tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvoorzich'])]/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href']))
										or (not(tia:GerelateerdPersoon) and not(concat('#', @id) = $party/tia:Hoedanigheid/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'])))]) +
								count(following-sibling::tia:IMKAD_Persoon[(tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene)
										and ((tia:GerelateerdPersoon and (not(concat('#', @id) = $party/tia:Hoedanigheid/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href']) or concat('#', @id) = $party/tia:Hoedanigheid[not(tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvoorzich'])]/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href']))
										or (not(tia:GerelateerdPersoon) and not(concat('#', @id) = $party/tia:Hoedanigheid/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'])))]) +
								count($party/tia:IMKAD_Persoon[tia:tia_Gegevens/tia:NHR_Rechtspersoon and not((count(tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder']) = 0) and concat('#', @id) =
								$party/tia:Hoedanigheid/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] and count(preceding-sibling::tia:IMKAD_Persoon) > 0)]) +
								count($party/tia:IMKAD_Persoon[tia:tia_Gegevens/tia:NHR_Rechtspersoon and count(tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder']) > 1]/tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder' and
								preceding-sibling::tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder']]) = 0">
					<xsl:text>true</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>false</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="anyRelatedPersonsWithBullet">
			<xsl:choose>
				<xsl:when test="count(current()/tia:GerelateerdPersoon/tia:IMKAD_Persoon[not($party/tia:Hoedanigheid[concat('#', @id) = $party/descendant::tia:IMKAD_Persoon/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href']]/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#', @id))]) > 0">
					<xsl:text>true</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>false</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="partner" select="tia:GerelateerdPersoon/tia:IMKAD_Persoon" />
		<xsl:variable name="isFollowingPersonNaturalPerson">
			<xsl:choose>
				<xsl:when test="$followingPerson/tia:tia_Gegevens/tia:NHR_Rechtspersoon">
					<xsl:text>false</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>true</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="capacityExists" select="$party/tia:Hoedanigheid[current()/descendant-or-self::tia:IMKAD_Persoon/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id) and tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#', $currentMainPerson/tia:GerelateerdPersoon/tia:IMKAD_Persoon/@id)]" />
		<xsl:variable name="partnersAuthorizedRepresentative" select="$party/tia:Gevolmachtigde[tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',$party/tia:Hoedanigheid[tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',$partner/@id)]/@id)]" />
		<xsl:variable name="authorizedRepresentativeHoedanigheid" select="$party/tia:Hoedanigheid[concat('#',@id) = $party/tia:Gevolmachtigde/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] and tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',$partner/@id)]" />
		<xsl:variable name="isPreviousPersonNaturalPerson">
			<xsl:choose>
				<xsl:when test="$previousPerson[tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene]">
					<xsl:text>true</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>false</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="forThem" select="$previousCapacityExists/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvoorzich']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
				translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvoorzich']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
				translate(normalize-space($previousCapacityExists/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvoorzich']/tia:tekst), $upper, $lower)]), $upper, $lower)]" />
		<!-- Last representer to GerelateerdPersoon in current person; representer from current person-->
		<xsl:variable name="isLastInternalPersonRepresenter">
			<xsl:choose>
				<xsl:when test="count($currentMainPerson/descendant-or-self::tia:IMKAD_Persoon[concat('#', $capacityExists/@id) = tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href']]) = 1">
					<xsl:text>true</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>false</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="numberOfPrecedingPersonsRepresentingFollowingPerson" select="count(preceding::tia:IMKAD_Persoon[tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',$capacityForNextPerson/@id)])" />
		<xsl:variable name="secondLevel">
			<xsl:choose>
				<xsl:when test="($isPreviousPersonNaturalPerson = 'true' and $previousCapacityExists) or
								(not($isPreviousPersonNaturalPerson = 'true' and $previousCapacityExists) and $anyRelatedPersonsWithBullet = 'true') or
								($onlyPersonWithBullet = 'false' and $anyRelatedPersonsWithBullet = 'true')">
					<xsl:text>true</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>false</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="nestingDepth">
			<xsl:choose>
				<xsl:when test="$onlyPersonWithBullet = 'false' and $anyRelatedPersonsWithBullet = 'true' and $secondLevel = 'true'">
					<xsl:text>2</xsl:text>
				</xsl:when>
				<xsl:when test="($onlyPersonWithBullet = 'false' and $anyRelatedPersonsWithBullet = 'false' and $secondLevel = 'false') or ($onlyPersonWithBullet = 'true' and $anyRelatedPersonsWithBullet = 'true' and $secondLevel = 'false')">
					<xsl:text>1</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<!-- Doesn't contain hoedanigheid which is referenced from previousPerson and which reference to current person or contain such hoedanigheid but is not voor zich -->
		<xsl:if test="not($previousCapacityExists) or (not($forThem) and $previousCapacityExists)">
			<tr>
				<td>
					<table>
						<tbody>
							<tr>
								<xsl:apply-templates select="." mode="do-party-natural-person-person-pair-person-one-common">
									<xsl:with-param name="start" select="$start" />
									<xsl:with-param name="anchorName" select="$anchorName" />
									<xsl:with-param name="onlyPersonWithBullet" select="$onlyPersonWithBullet" />
									<xsl:with-param name="anyRelatedPersonsWithBullet" select="$anyRelatedPersonsWithBullet" />
									<xsl:with-param name="skipPartyNumberColumn" select="$skipPartyNumberColumn" />
									<xsl:with-param name="forcePrintingPartyNumber" select="$forcePrintingPartyNumber" />
									<xsl:with-param name="partyNumberingFormat" select="$partyNumberingFormat" />
									<xsl:with-param name="personNumberingFormat" select="$personNumberingFormat" />
								</xsl:apply-templates>
								<td>
									<xsl:apply-templates select="." mode="do-party-natural-person-common-part-one" />
									<xsl:text>, </xsl:text>
									<xsl:apply-templates select="." mode="do-party-natural-person-addresses" />
									<xsl:choose>
										<xsl:when test="$capacityExists and not($partnersAuthorizedRepresentative) and $isLastInternalPersonRepresenter = 'true'">
											<xsl:text>; </xsl:text>
											<xsl:apply-templates select="$capacityExists" mode="do-capacity-variant-for-natural-person">
												<xsl:with-param name="nestingDepth" select="number($nestingDepth)" />
												<xsl:with-param name="representerPersons" select="." />
												<xsl:with-param name="relatedPersons" select="$referencedPerson" />
												<xsl:with-param name="numberingFormat" select="translate($personNumberingFormat, '1a', 'a1')" />
											</xsl:apply-templates>
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
			<!-- No Hoedanigheid which reference any GerelateerdPersoon from current main person and none person reference to it -->
			<xsl:if test="count($party/tia:Hoedanigheid[tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#', $partner/@id) and $party/descendant-or-self::tia:IMKAD_Persoon/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#', @id)]) = 0">
				<xsl:variable name="hoedanigheid" select="$party/tia:Hoedanigheid[tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#', $partner/@id)]" />
				<xsl:variable name="secondLevel3">
					<xsl:choose>
						<xsl:when test="($isPreviousPersonNaturalPerson = 'true' and $previousCapacityExists) or
										(not($isPreviousPersonNaturalPerson = 'true' and $previousCapacityExists) and $anyRelatedPersonsWithBullet = 'true') or
										($onlyPersonWithBullet = 'false' and $anyRelatedPersonsWithBullet = 'true')">
							<xsl:text>true</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>false</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<xsl:variable name="positionWithinPerson" select="count(preceding-sibling::tia:GerelateerdPersoon/tia:IMKAD_Persoon[not(concat('#', @id) = $party/tia:Hoedanigheid/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'])])
																+ count($party/tia:Hoedanigheid[concat('#', @id) = $party/tia:Gevolmachtigde/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] and substring-after(tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'], '#') = current()/preceding-sibling::tia:GerelateerdPersoon/tia:IMKAD_Persoon/@id])
																+ 1" />

				<tr>
					<td>
						<table>
							<tbody>
								<tr>
									<xsl:apply-templates select="$partner" mode="do-party-natural-person-person-pair-person-two-common">
										<xsl:with-param name="onlyPersonWithBullet" select="$onlyPersonWithBullet" />
										<xsl:with-param name="anyRelatedPersonsWithBullet" select="$anyRelatedPersonsWithBullet" />
										<xsl:with-param name="secondLevel" select="$secondLevel3" />
										<xsl:with-param name="position" select="$positionWithinPerson" />
										<xsl:with-param name="skipPartyNumberColumn" select="$skipPartyNumberColumn" />
										<xsl:with-param name="personNumberingFormat" select="$personNumberingFormat" />
									</xsl:apply-templates>
									<td>
										<xsl:if test="$partnersAuthorizedRepresentative">
											<xsl:apply-templates select="$partnersAuthorizedRepresentative" mode="do-legal-representative" />
											<xsl:if test="$hoedanigheid and count($hoedanigheid/tia:wordtVertegenwoordigdRef) != 1">
												<xsl:text>:</xsl:text>
											</xsl:if>
											<xsl:text> </xsl:text>
										</xsl:if>
										<xsl:apply-templates select="$partner" mode="do-party-natural-person-common-part-one" />
										<xsl:text>, wonende te </xsl:text>
										<xsl:choose>
											<xsl:when test="translate(tia:GerelateerdPersoon[1]/tia:IndGezamenlijkeWoonlocatie, $upper, $lower) = 'true'">
												<xsl:apply-templates select="tia:IMKAD_WoonlocatiePersoon" mode="do-address" />
											</xsl:when>
											<xsl:when test="translate(tia:GerelateerdPersoon[1]/tia:IndGezamenlijkeWoonlocatie, $upper, $lower) = 'false'">
												<xsl:apply-templates select="tia:GerelateerdPersoon[1]/tia:IMKAD_Persoon/tia:IMKAD_WoonlocatiePersoon" mode="do-address" />
											</xsl:when>
										</xsl:choose>
										<xsl:if test="(tia:toekomstigAdres and translate(tia:GerelateerdPersoon[1]/tia:IndGezamenlijkeToekomstigeWoonlocatie, $upper, $lower) = 'true')
													or (tia:GerelateerdPersoon[1]/tia:IMKAD_Persoon/tia:toekomstigAdres and (translate(tia:GerelateerdPersoon[1]/tia:IndGezamenlijkeToekomstigeWoonlocatie, $upper, $lower) = 'false' or not(tia:GerelateerdPersoon[1]/tia:IndGezamenlijkeToekomstigeWoonlocatie)))">
											<xsl:text> (toekomstig adres: </xsl:text>
											<xsl:choose>
												<xsl:when test="translate(tia:GerelateerdPersoon[1]/tia:IndGezamenlijkeToekomstigeWoonlocatie, $upper, $lower) = 'true'">
													<xsl:apply-templates select="tia:toekomstigAdres" mode="do-address" />
												</xsl:when>
												<xsl:otherwise>
													<xsl:apply-templates select="tia:GerelateerdPersoon[1]/tia:IMKAD_Persoon/tia:toekomstigAdres" mode="do-address" />
												</xsl:otherwise>
											</xsl:choose>
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
			<tr>
				<td>
					<table>
						<tbody>
							<tr>
								<xsl:if test="not($skipPartyNumberColumn = 'true')">
									<td class="number" valign="top">
										<xsl:text>&#xFEFF;</xsl:text>
									</td>
								</xsl:if>
								<xsl:if test="$onlyPersonInParty = 'false' and $onlyPersonWithBullet = 'false'">
									<td class="number" valign="top">
										<xsl:text>&#xFEFF;</xsl:text>
									</td>
								</xsl:if>
								<td>
									<xsl:apply-templates select="." mode="do-joint-address-marital-status" />
									<xsl:variable name="nestingDepthForExternalPrintOfHoedanigheid">
										<xsl:choose>
											<xsl:when test="$nestingDepth > 1">
												<xsl:value-of select="number('1')" />
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="number('0')" />
											</xsl:otherwise>
										</xsl:choose>
									</xsl:variable>
									<xsl:choose>
										<xsl:when test="$capacityForNextPerson and $isFollowingPersonNaturalPerson = 'true' and $numberOfPrecedingPersonsRepresentingFollowingPerson = 0">
											<xsl:text>, </xsl:text>
											<xsl:apply-templates select="$followingPerson" mode="do-main-person-capacity">
												<xsl:with-param name="representerPersons" select="$representerPerson" />
												<xsl:with-param name="relatedPersons" select="$party/descendant-or-self::tia:IMKAD_Persoon[$capacityForNextPerson/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id)]" />
												<xsl:with-param name="hoedanigheid" select="$capacityForNextPerson" />
												<xsl:with-param name="intermedialPerson" select="$intermedialPerson" />
												<xsl:with-param name="personVariant" select="'2'" />
												<xsl:with-param name="personNumberingFormat" select="$personNumberingFormat" />
												<xsl:with-param name="onlyPersonWithBullet" select="$onlyPersonWithBullet" />
												<xsl:with-param name="nestingDepth" select="$nestingDepthForExternalPrintOfHoedanigheid" />
											</xsl:apply-templates>
										</xsl:when>
										<xsl:when test="$capacityForNextPerson and $isFollowingPersonNaturalPerson = 'true' and $numberOfPrecedingPersonsRepresentingFollowingPerson > 0">
											<xsl:text>,</xsl:text>
										</xsl:when>
										<xsl:when test="not($capacityForNextPerson)">
											<xsl:text>;</xsl:text>
										</xsl:when>
									</xsl:choose>
								</td>
							</tr>
						</tbody>
					</table>
				</td>
			</tr>
			<xsl:if test="$numberOfPrecedingPersonsRepresentingFollowingPerson > 0">
				<tr>
					<td>
						<table>
							<tbody>
								<tr>
									<td class="number" valign="top">
										<xsl:text>&#xFEFF;</xsl:text>
									</td>
									<td>
										<xsl:apply-templates select="$followingPerson" mode="do-main-person-capacity">
											<xsl:with-param name="representerPersons" select="$representerPerson"/>
											<xsl:with-param name="relatedPersons"
															select="$party/descendant-or-self::tia:IMKAD_Persoon[$capacityForNextPerson/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id)]"/>
											<xsl:with-param name="hoedanigheid" select="$capacityForNextPerson"/>
											<xsl:with-param name="intermedialPerson" select="$intermedialPerson"/>
											<xsl:with-param name="personVariant" select="'2'"/>
											<xsl:with-param name="personNumberingFormat" select="$personNumberingFormat"/>
											<xsl:with-param name="onlyPersonWithBullet" select="$onlyPersonWithBullet"/>
										</xsl:apply-templates>
									</td>
								</tr>
							</tbody>
						</table>
					</td>
				</tr>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<!--
	*********************************************************
	Mode: do-person-pair-representative-variant-five
	*********************************************************
	Public: no

	Identity transform: no

	Description: Two natural persons (not partners) where one acts on behalf of oneself and the other.

	Input: tia:IMKAD_Persoon

	Params: start - order number of person in nested party
			anchorName - name of the anchor that will be positioned in first <td> element
			personTerminator - character that is printed at the end of each person's block
			skipPartyNumberColumn - indicator if party number column should not be printed ('false' is default)
			forcePrintingPartyNumber - force printing party number ('false' is default)
			partyNumberingFormat - party numbering format ('1' is default)
			personNumberingFormat - first level person numbering format ('a' is default)

	Output: XHTML

	Calls:
	(mode) do-party-natural-person-person-pair-person-one-common
	(mode) do-party-natural-person-person-pair-person-two-common
	(mode) do-party-natural-person-common-part-one
	(mode) do-marital-status
	(mode) do-party-natural-person-addresses
	(mode) do-address

	Called by:
	(mode) do-party-natural-person-person-pair
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon" mode="do-person-pair-representative-variant-five">
		<xsl:param name="start" select="number('0')" />
		<xsl:param name="anchorName" select="''" />
		<xsl:param name="personTerminator" />
		<xsl:param name="skipPartyNumberColumn" select="'false'" />
		<xsl:param name="forcePrintingPartyNumber" select="'false'" />
		<xsl:param name="partyNumberingFormat" select="'1'" />
		<xsl:param name="personNumberingFormat" select="'a'" />

		<xsl:variable name="party" select=".." />
		<xsl:variable name="currentPersonId" select="@id" />
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
		<xsl:variable name="anyRelatedPersonsWithBullet">
			<xsl:choose>
				<xsl:when test="count(current()/tia:GerelateerdPersoon/tia:IMKAD_Persoon[not($party/tia:Hoedanigheid[concat('#', @id) = $party/descendant::tia:IMKAD_Persoon/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href']]/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#', @id))]) > 0">
					<xsl:text>true</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>false</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="onlyPersonWithBullet">
			<xsl:choose>
				<!-- When count of PNP persons which are not single and doesn't have Hoedanigheid or just doesn't have Hoedanigheid voor zich or which are single persons and doesn't have Hoedanigheid at all -->
				<xsl:when test="count(preceding-sibling::tia:IMKAD_Persoon[(tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene)
										and ((tia:GerelateerdPersoon and (not(concat('#', @id) = $party/tia:Hoedanigheid/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href']) or concat('#', @id) = $party/tia:Hoedanigheid[not(tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvoorzich'])]/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href']))
										or (not(tia:GerelateerdPersoon) and not(concat('#', @id) = $party/tia:Hoedanigheid/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'])))]) +
								count(following-sibling::tia:IMKAD_Persoon[(tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene)
										and ((tia:GerelateerdPersoon and (not(concat('#', @id) = $party/tia:Hoedanigheid/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href']) or concat('#', @id) = $party/tia:Hoedanigheid[not(tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvoorzich'])]/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href']))
										or (not(tia:GerelateerdPersoon) and not(concat('#', @id) = $party/tia:Hoedanigheid/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'])))]) +
								count($party/tia:IMKAD_Persoon[tia:tia_Gegevens/tia:NHR_Rechtspersoon and not((count(tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder']) = 0) and concat('#', @id) =
								$party/tia:Hoedanigheid/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] and count(preceding-sibling::tia:IMKAD_Persoon) > 0)]) +
								count($party/tia:IMKAD_Persoon[tia:tia_Gegevens/tia:NHR_Rechtspersoon and count(tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder']) > 1]/tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder' and
								preceding-sibling::tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder']]) = 0">
					<xsl:text>true</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>false</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="currentMainPerson" select="." />
		<xsl:variable name="firstRelatedPerson" select="tia:GerelateerdPersoon[1]/tia:IMKAD_Persoon" />
		<xsl:variable name="followingPerson" select="following-sibling::tia:IMKAD_Persoon[1]" />
		<xsl:variable name="isFollowingPersonNaturalPerson">
			<xsl:choose>
				<xsl:when test="$followingPerson/tia:tia_Gegevens/tia:NHR_Rechtspersoon">
					<xsl:text>false</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>true</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="capacityExists" select="$party/tia:Hoedanigheid[current()/descendant-or-self::tia:IMKAD_Persoon/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id) and tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#', $currentMainPerson/tia:GerelateerdPersoon/tia:IMKAD_Persoon/@id)]" />
		<xsl:variable name="firstRelatedPersonAuthorizedRepresentative" select="$party/tia:Hoedanigheid[$party/tia:Gevolmachtigde/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id)]/tia:wordtVertegenwoordigdRef = concat('#',$firstRelatedPerson/@id)" />
		<xsl:variable name="previousPerson" select="preceding-sibling::tia:IMKAD_Persoon[1]" />
		<xsl:variable name="isPreviousPersonNaturalPerson">
			<xsl:choose>
				<xsl:when test="$previousPerson[tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene]">
					<xsl:text>true</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>false</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="previousCapacityExists" select="$party/tia:Hoedanigheid[($previousPerson/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id) or $previousPerson/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id)) and tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#', $currentPersonId)]" />
		<!-- Last representer to GerelateerdPersoon in current person; representer from current person-->
		<xsl:variable name="isLastInternalPersonRepresenter">
			<xsl:choose>
				<xsl:when test="count($currentMainPerson/descendant-or-self::tia:IMKAD_Persoon[concat('#', $capacityExists/@id) = tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href']]) = 1">
					<xsl:text>true</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>false</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="capacityForNextPerson" select="$party/tia:Hoedanigheid[current()/descendant-or-self::tia:IMKAD_Persoon/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id) and tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#', $followingPerson/@id)]" />
		<xsl:variable name="numberingFormat">
			<xsl:choose>
				<xsl:when test="$onlyPersonWithBullet != $anyRelatedPersonsWithBullet">
					<xsl:value-of select="$personNumberingFormat" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="translate($personNumberingFormat, '1a', 'a1')" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="secondLevel">
			<xsl:choose>
				<xsl:when test="($isPreviousPersonNaturalPerson = 'true' and $previousCapacityExists) or
								(not($isPreviousPersonNaturalPerson = 'true' and $previousCapacityExists) and $anyRelatedPersonsWithBullet = 'true') or
								($onlyPersonWithBullet = 'false' and $anyRelatedPersonsWithBullet = 'true')">
					<xsl:text>true</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>false</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="representerPerson" select="$party/descendant-or-self::tia:IMKAD_Persoon[tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',$capacityForNextPerson/@id)]" />
		<xsl:variable name="referencedPerson" select="$party/descendant-or-self::tia:IMKAD_Persoon[$party/tia:Hoedanigheid[$currentMainPerson/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id)]/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id)]" />
		<xsl:variable name="representerKeuzeblokVariant" select="$representerPerson/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_keuzeblokvariant']/tia:tekst" />
		<xsl:variable name="isMainPerson" select="$party/@id" /> <!-- If @id is recognized mean that current is main person, not nested -->
		<xsl:variable name="intermedialPerson" select="$party/tia:Hoedanigheid[$representerPerson/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id) and tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href']] and $isMainPerson" />
		<xsl:variable name="forThem" select="$previousCapacityExists/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvoorzich']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
				translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvoorzich']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
				translate(normalize-space($previousCapacityExists/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvoorzich']/tia:tekst), $upper, $lower)]), $upper, $lower)]" />

		<xsl:variable name="nestingDepth">
			<xsl:choose>
				<xsl:when test="$onlyPersonWithBullet = 'false' and $anyRelatedPersonsWithBullet = 'true' and $secondLevel = 'true'">
					<xsl:text>2</xsl:text>
				</xsl:when>
				<xsl:when test="($onlyPersonWithBullet = 'false' and $anyRelatedPersonsWithBullet = 'false' and $secondLevel = 'false') or ($onlyPersonWithBullet = 'true' and $anyRelatedPersonsWithBullet = 'true' and $secondLevel = 'false') or $secondLevel = 'true'">
					<xsl:text>1</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<!-- Doesn't contain hoedanigheid which is referenced from previousPerson and which reference to current person or contain such hoedanigheid but is not voor zich -->
		<xsl:if test="not($previousCapacityExists) or (not($forThem) and $previousCapacityExists)">
			<tr>
				<td>
					<table>
						<tbody>
							<tr>
								<xsl:apply-templates select="." mode="do-party-natural-person-person-pair-person-one-common">
									<xsl:with-param name="start" select="$start" />
									<xsl:with-param name="anchorName" select="$anchorName" />
									<xsl:with-param name="onlyPersonWithBullet" select="$onlyPersonWithBullet" />
									<xsl:with-param name="anyRelatedPersonsWithBullet" select="$anyRelatedPersonsWithBullet" />
									<xsl:with-param name="skipPartyNumberColumn" select="$skipPartyNumberColumn" />
									<xsl:with-param name="forcePrintingPartyNumber" select="$forcePrintingPartyNumber" />
									<xsl:with-param name="partyNumberingFormat" select="$partyNumberingFormat" />
									<xsl:with-param name="personNumberingFormat" select="$personNumberingFormat" />
								</xsl:apply-templates>
								<td>
									<xsl:apply-templates select="." mode="do-party-natural-person-common-part-one" />
									<xsl:if test="tia:tia_BurgerlijkeStaatTekst">
										<xsl:text>, </xsl:text>
									</xsl:if>
									<xsl:apply-templates select="." mode="do-marital-status" />
									<xsl:text>, </xsl:text>
									<xsl:apply-templates select="." mode="do-party-natural-person-addresses" />
									<xsl:choose>
										<xsl:when test="$capacityExists and not($firstRelatedPersonAuthorizedRepresentative) and $isLastInternalPersonRepresenter = 'true'">
											<xsl:text>; </xsl:text>
											<xsl:apply-templates select="$capacityExists" mode="do-capacity-variant-for-natural-person">
												<xsl:with-param name="nestingDepth" select="$nestingDepth" />
												<xsl:with-param name="representerPersons" select="." />
												<xsl:with-param name="relatedPersons" select="$referencedPerson" />
												<xsl:with-param name="numberingFormat" select="$numberingFormat" />
											</xsl:apply-templates>
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
			<xsl:for-each select="tia:GerelateerdPersoon">
				<xsl:variable name="currentRelatedPerson" select="tia:IMKAD_Persoon" />
				<xsl:variable name="relatedPersonAuthorizedRepresentative" select="$party/tia:Gevolmachtigde[concat('#',$party/tia:Hoedanigheid[tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',$currentRelatedPerson/@id)]/@id) = tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href']]" />
				<xsl:variable name="authorizedRepresentativeHoedanigheid" select="$party/tia:Hoedanigheid[concat('#',@id) = $party/tia:Gevolmachtigde/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] and tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',$currentRelatedPerson/@id)]" />
				<xsl:variable name="alreadyProcessed">
					<xsl:choose>
						<xsl:when test="count(preceding-sibling::tia:GerelateerdPersoon/tia:IMKAD_Persoon[concat('#', @id) = $authorizedRepresentativeHoedanigheid/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href']]) > 0
								or not($party/tia:Hoedanigheid[not($authorizedRepresentativeHoedanigheid/@id = @id) and concat('#',@id) = $party/descendant::tia:IMKAD_Persoon/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href']]/tia:wordtVertegenwoordigdRef[@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',current()/tia:IMKAD_Persoon/@id)]) = false">
							<xsl:text>true</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>false</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<xsl:variable name="positionWithinPerson" select="count(preceding-sibling::tia:GerelateerdPersoon/tia:IMKAD_Persoon[not(concat('#', @id) = $party/tia:Hoedanigheid/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'])])
																+ count($party/tia:Hoedanigheid[concat('#', @id) = $party/tia:Gevolmachtigde/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] and substring-after(tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'], '#') = current()/preceding-sibling::tia:GerelateerdPersoon/tia:IMKAD_Persoon/@id])
																+ 1" />

				<xsl:choose>
					<xsl:when test="$relatedPersonAuthorizedRepresentative">
						<xsl:if test="$alreadyProcessed = 'false'">
							<tr>
								<td>
									<table>
										<tbody>
											<tr>
												<xsl:apply-templates select="tia:IMKAD_Persoon" mode="do-party-natural-person-person-pair-person-two-common">
													<xsl:with-param name="onlyPersonWithBullet" select="$onlyPersonWithBullet" />
													<xsl:with-param name="anyRelatedPersonsWithBullet" select="$anyRelatedPersonsWithBullet" />
													<xsl:with-param name="secondLevel" select="$secondLevel" />
													<xsl:with-param name="position" select="$positionWithinPerson" />
													<xsl:with-param name="skipPartyNumberColumn" select="$skipPartyNumberColumn" />
													<xsl:with-param name="personNumberingFormat" select="$personNumberingFormat" />
												</xsl:apply-templates>
												<td>
													<xsl:apply-templates select="$relatedPersonAuthorizedRepresentative" mode="do-legal-representative" />
													<xsl:choose>
														<xsl:when test="count($authorizedRepresentativeHoedanigheid/tia:wordtVertegenwoordigdRef) = 1">
															<xsl:variable name="relatedPersonID" select="substring-after($authorizedRepresentativeHoedanigheid/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'], '#')" />
															<xsl:variable name="currentlyProcessedPerson" select="$currentMainPerson/tia:GerelateerdPersoon[tia:IMKAD_Persoon[@id = $relatedPersonID]]" />
															<xsl:text> </xsl:text>
															<xsl:apply-templates select="$currentMainPerson/tia:GerelateerdPersoon/tia:IMKAD_Persoon[@id = $relatedPersonID]" mode="do-party-natural-person-common-part-one" />
															<xsl:if test="$currentMainPerson/tia:GerelateerdPersoon/tia:IMKAD_Persoon[@id = $relatedPersonID]/tia:tia_BurgerlijkeStaatTekst">
																<xsl:text>, </xsl:text>
															</xsl:if>
															<xsl:apply-templates select="$currentMainPerson/tia:GerelateerdPersoon/tia:IMKAD_Persoon[@id = $relatedPersonID]" mode="do-marital-status" />
															<xsl:text>, wonende te </xsl:text>
															<xsl:choose>
																<xsl:when test="translate($currentlyProcessedPerson/tia:IndGezamenlijkeWoonlocatie, $upper, $lower) = 'true'">
																	<xsl:apply-templates select="$currentMainPerson/tia:IMKAD_WoonlocatiePersoon" mode="do-address" />
																</xsl:when>
																<xsl:when test="translate($currentlyProcessedPerson/tia:IndGezamenlijkeWoonlocatie, $upper, $lower) = 'false'">
																	<xsl:apply-templates select="$currentlyProcessedPerson/tia:IMKAD_Persoon/tia:IMKAD_WoonlocatiePersoon" mode="do-address" />
																</xsl:when>
															</xsl:choose>
															<xsl:if test="($currentMainPerson/tia:toekomstigAdres and translate($currentlyProcessedPerson/tia:IndGezamenlijkeToekomstigeWoonlocatie, $upper, $lower) = 'true')
																		or ($currentlyProcessedPerson/tia:IMKAD_Persoon/tia:toekomstigAdres and (translate($currentlyProcessedPerson/tia:IndGezamenlijkeToekomstigeWoonlocatie, $upper, $lower) = 'false' or not($currentlyProcessedPerson/tia:IndGezamenlijkeToekomstigeWoonlocatie)))">
																<xsl:text> (toekomstig adres: </xsl:text>
																<xsl:choose>
																	<xsl:when test="translate($currentlyProcessedPerson/tia:IndGezamenlijkeToekomstigeWoonlocatie, $upper, $lower) = 'true'">
																		<xsl:apply-templates select="$currentMainPerson/tia:toekomstigAdres" mode="do-address" />
																	</xsl:when>
																	<xsl:otherwise>
																		<xsl:apply-templates select="$currentlyProcessedPerson/tia:IMKAD_Persoon/tia:toekomstigAdres" mode="do-address" />
																	</xsl:otherwise>
																</xsl:choose>
																<xsl:text>)</xsl:text>
															</xsl:if>
															<xsl:text>;</xsl:text>
														</xsl:when>
														<xsl:when test="count($authorizedRepresentativeHoedanigheid/tia:wordtVertegenwoordigdRef) > 1">
															<xsl:text>:</xsl:text>
															<table cellspacing="0" cellpadding="0">
																<tbody>
																	<xsl:variable name="lastRelatedPersons" select="count($authorizedRepresentativeHoedanigheid/tia:wordtVertegenwoordigdRef)" />
																	<xsl:for-each select="$authorizedRepresentativeHoedanigheid/tia:wordtVertegenwoordigdRef">
																		<xsl:variable name="relatedPersonID" select="substring-after(current()/@*[translate(local-name(), $upper, $lower) = 'href'], '#')" />
																		<xsl:variable name="currentlyProcessedPerson" select="$currentMainPerson/tia:GerelateerdPersoon[tia:IMKAD_Persoon[@id = $relatedPersonID]]" />
																		<tr>
																			<td class="number" valign="top">
																				<xsl:number value="position()" format="{$numberingFormat}" />
																				<xsl:text>.</xsl:text>
																			</td>
																			<td>
																				<xsl:attribute name="class">
																					<xsl:if test="$onlyPersonWithBullet = 'false' and $anyRelatedPersonsWithBullet = 'true' and $secondLevel = 'true'">
																						<xsl:text>level2</xsl:text>
																					</xsl:if>
																					<xsl:if test="not($onlyPersonWithBullet = 'false' and $anyRelatedPersonsWithBullet = 'true' and $secondLevel = 'true')">
																						<xsl:text>level1</xsl:text>
																					</xsl:if>
																				</xsl:attribute>
																				<xsl:apply-templates select="$currentMainPerson/tia:GerelateerdPersoon/tia:IMKAD_Persoon[@id = $relatedPersonID]" mode="do-party-natural-person-common-part-one" />
																				<xsl:if test="$currentMainPerson/tia:GerelateerdPersoon/tia:IMKAD_Persoon[@id = $relatedPersonID]/tia:tia_BurgerlijkeStaatTekst">
																					<xsl:text>, </xsl:text>
																				</xsl:if>
																				<xsl:apply-templates select="$currentMainPerson/tia:GerelateerdPersoon/tia:IMKAD_Persoon[@id = $relatedPersonID]" mode="do-marital-status" />
																				<xsl:text>, wonende te </xsl:text>
																				<xsl:choose>
																					<xsl:when test="translate($currentlyProcessedPerson/tia:IndGezamenlijkeWoonlocatie, $upper, $lower) = 'true'">
																						<xsl:apply-templates select="$currentMainPerson/tia:IMKAD_WoonlocatiePersoon" mode="do-address" />
																					</xsl:when>
																					<xsl:when test="translate($currentlyProcessedPerson/tia:IndGezamenlijkeWoonlocatie, $upper, $lower) = 'false'">
																						<xsl:apply-templates select="$currentlyProcessedPerson/tia:IMKAD_Persoon/tia:IMKAD_WoonlocatiePersoon" mode="do-address" />
																					</xsl:when>
																				</xsl:choose>
																				<xsl:if test="($currentMainPerson/tia:toekomstigAdres and translate($currentlyProcessedPerson/tia:IndGezamenlijkeToekomstigeWoonlocatie, $upper, $lower) = 'true')
																							or ($currentlyProcessedPerson/tia:IMKAD_Persoon/tia:toekomstigAdres and (translate($currentlyProcessedPerson/tia:IndGezamenlijkeToekomstigeWoonlocatie, $upper, $lower) = 'false' or not($currentlyProcessedPerson/tia:IndGezamenlijkeToekomstigeWoonlocatie)))">
																					<xsl:text> (toekomstig adres: </xsl:text>
																					<xsl:choose>
																						<xsl:when test="translate($currentlyProcessedPerson/tia:IndGezamenlijkeToekomstigeWoonlocatie, $upper, $lower) = 'true'">
																							<xsl:apply-templates select="$currentMainPerson/tia:toekomstigAdres" mode="do-address" />
																						</xsl:when>
																						<xsl:otherwise>
																							<xsl:apply-templates select="$currentlyProcessedPerson/tia:IMKAD_Persoon/tia:toekomstigAdres" mode="do-address" />
																						</xsl:otherwise>
																					</xsl:choose>
																					<xsl:text>)</xsl:text>
																				</xsl:if>
																				<xsl:text>;</xsl:text>
																				<xsl:if test="position() != $lastRelatedPersons">
																					<xsl:text> en </xsl:text>
																				</xsl:if>
																			</td>
																		</tr>
																	</xsl:for-each>
																</tbody>
															</table>
														</xsl:when>
													</xsl:choose>
												</td>
											</tr>
										</tbody>
									</table>
								</td>
							</tr>
						</xsl:if>
					</xsl:when>
					<xsl:otherwise>
						<xsl:variable name="nextRelatedPersonToProcess" select="following-sibling::tia:GerelateerdPersoon[not(concat('#',tia:IMKAD_Persoon/@id) = $party/tia:Hoedanigheid/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'])][1]/tia:IMKAD_Persoon" />
						<xsl:variable name="capacityExistsForRelatedPerson" select="$party/tia:Hoedanigheid[$currentRelatedPerson/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id) and tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#', $currentMainPerson/tia:GerelateerdPersoon/tia:IMKAD_Persoon/@id)]" />
						<xsl:variable name="nextRelatedPersonAuthorizedRepresentative" select="$party/tia:Hoedanigheid[$party/tia:Gevolmachtigde/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id)]/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',$firstRelatedPerson/@id)" />
						<xsl:variable name="lastRepresenter">
							<xsl:choose>
								<xsl:when test="count($currentMainPerson/following-sibling::tia:IMKAD_Persoon[tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#', $capacityExists/@id)]) +
												count(following-sibling::tia:GerelateerdPersoon/tia:IMKAD_Persoon[tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#', $capacityExistsForRelatedPerson/@id)]) = 0">
									<xsl:text>true</xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>false</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="relatedRepresenters" select="$currentMainPerson/descendant-or-self::tia:IMKAD_Persoon[tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#', $capacityExistsForRelatedPerson/@id)]" />
						<xsl:if test="$alreadyProcessed = 'false'">
							<tr>
								<td>
									<table>
										<tbody>
											<tr>
												<xsl:apply-templates select="tia:IMKAD_Persoon" mode="do-party-natural-person-person-pair-person-two-common">
													<xsl:with-param name="onlyPersonWithBullet" select="$onlyPersonWithBullet" />
													<xsl:with-param name="anyRelatedPersonsWithBullet" select="$anyRelatedPersonsWithBullet" />
													<xsl:with-param name="secondLevel" select="$secondLevel" />
													<xsl:with-param name="position" select="$positionWithinPerson" />
													<xsl:with-param name="skipPartyNumberColumn" select="$skipPartyNumberColumn" />
													<xsl:with-param name="personNumberingFormat" select="$personNumberingFormat" />
												</xsl:apply-templates>
												<td>
													<xsl:variable name="nestingDepth2">
														<xsl:choose>
															<xsl:when test="$onlyPersonWithBullet = 'false' and $anyRelatedPersonsWithBullet = 'true' and $secondLevel = 'true'">
																<xsl:text>2</xsl:text>
															</xsl:when>
															<xsl:when test="($onlyPersonWithBullet = 'false' and $anyRelatedPersonsWithBullet = 'false' and $secondLevel = 'false') or ($onlyPersonWithBullet = 'true' and $anyRelatedPersonsWithBullet = 'true' and $secondLevel = 'false')">
																<xsl:text>1</xsl:text>
															</xsl:when>
															<xsl:otherwise>
																<xsl:text>0</xsl:text>
															</xsl:otherwise>
														</xsl:choose>
													</xsl:variable>

													<xsl:apply-templates select="tia:IMKAD_Persoon" mode="do-party-natural-person-common-part-one" />
													<xsl:if test="tia:IMKAD_Persoon/tia:tia_BurgerlijkeStaatTekst">
														<xsl:text>, </xsl:text>
													</xsl:if>
													<xsl:apply-templates select="tia:IMKAD_Persoon" mode="do-marital-status" />
													<xsl:text>, wonende te </xsl:text>
													<xsl:choose>
														<xsl:when test="translate(tia:IndGezamenlijkeWoonlocatie, $upper, $lower) = 'true'">
															<xsl:apply-templates select="../tia:IMKAD_WoonlocatiePersoon" mode="do-address" />
														</xsl:when>
														<xsl:when test="translate(tia:IndGezamenlijkeWoonlocatie, $upper, $lower) = 'false'">
															<xsl:apply-templates select="tia:IMKAD_Persoon/tia:IMKAD_WoonlocatiePersoon" mode="do-address" />
														</xsl:when>
													</xsl:choose>
													<xsl:if test="(../tia:toekomstigAdres and translate(tia:IndGezamenlijkeToekomstigeWoonlocatie, $upper, $lower) = 'true')
															or (tia:IMKAD_Persoon/tia:toekomstigAdres and (translate(tia:IndGezamenlijkeToekomstigeWoonlocatie, $upper, $lower) = 'false' or not(tia:IndGezamenlijkeToekomstigeWoonlocatie)))">
														<xsl:text> (toekomstig adres: </xsl:text>
														<xsl:choose>
															<xsl:when test="translate(tia:IndGezamenlijkeToekomstigeWoonlocatie, $upper, $lower) = 'true'">
																<xsl:apply-templates select="../tia:toekomstigAdres" mode="do-address" />
															</xsl:when>
															<xsl:otherwise>
																<xsl:apply-templates select="tia:IMKAD_Persoon/tia:toekomstigAdres" mode="do-address" />
															</xsl:otherwise>
														</xsl:choose>
														<xsl:text>)</xsl:text>
													</xsl:if>
													<xsl:choose>
														<xsl:when test="$capacityExistsForRelatedPerson and not($nextRelatedPersonAuthorizedRepresentative) and $lastRepresenter = 'true'">
															<xsl:text>, </xsl:text>
															<xsl:apply-templates select="$capacityExistsForRelatedPerson" mode="do-capacity-variant-for-natural-person">
																<xsl:with-param name="nestingDepth" select="number($nestingDepth2)" />
																<xsl:with-param name="relatedPersons" select="$relatedRepresenters" />
																<xsl:with-param name="representerPersons" select="." />
																<xsl:with-param name="numberingFormat" select="$numberingFormat" />
															</xsl:apply-templates>
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
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
		</xsl:if>
		<xsl:if test="$capacityForNextPerson and $isFollowingPersonNaturalPerson = 'true'">
			<tr>
				<td>
					<table>
						<tbody>
							<tr>
								<xsl:if test="not($skipPartyNumberColumn = 'true')">
									<td class="number" valign="top">
										<xsl:text>&#xFEFF;</xsl:text>
									</td>
								</xsl:if>
								<!-- When previous main person represent current person throught voor zich Hoedanigheid than need to be moved column to right -->
								<xsl:if test="$forThem and $previousPerson/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',$previousCapacityExists/@id) and $previousCapacityExists/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id)">
									<td class="number" valign="top">
										<xsl:text>&#xFEFF;</xsl:text>
									</td>
								</xsl:if>
								<td>
									<xsl:apply-templates select="$followingPerson" mode="do-main-person-capacity">
										<xsl:with-param name="representerPersons" select="$representerPerson" />
										<xsl:with-param name="relatedPersons" select="$party/descendant-or-self::tia:IMKAD_Persoon[$capacityForNextPerson/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id)]" />
										<xsl:with-param name="hoedanigheid" select="$capacityForNextPerson" />
										<xsl:with-param name="intermedialPerson" select="$intermedialPerson" />
										<xsl:with-param name="personVariant" select="'5'" />
										<xsl:with-param name="personNumberingFormat" select="$personNumberingFormat" />
										<xsl:with-param name="onlyPersonWithBullet" select="$onlyPersonWithBullet" />
									</xsl:apply-templates>
								</td>
							</tr>
						</tbody>
					</table>
				</td>
			</tr>
		</xsl:if>
	</xsl:template>

	<!--
	*********************************************************
	Mode: do-person-pair-housemate-variant-three
	*********************************************************
	Public: no

	Identity transform: no

	Description: Two natural persons (not partners) with joint residential address.

	Input: tia:IMKAD_Persoon

	Params: start - order number of person in nested party
			anchorName - name of the anchor that will be positioned in first <td> element
			personTerminator - character that is printed at the end of each person's block
			skipPartyNumberColumn - indicator if party number column should not be printed ('false' is default)
			forcePrintingPartyNumber - force printing party number ('false' is default)
			partyNumberingFormat - party numbering format ('1' is default)
			personNumberingFormat - first level person numbering format ('a' is default)

	Output: XHTML

	Calls:
	(mode) do-party-natural-person-person-pair-person-one-common
	(mode) do-party-natural-person-person-pair-person-two-common
	(mode) do-party-natural-person-common-part-one
	(mode) do-marital-status
	(mode) do-party-natural-person-addresses

	Called by:
	(mode) do-party-natural-person-person-pair
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon" mode="do-person-pair-housemate-variant-three">
		<xsl:param name="start" select="number('0')" />
		<xsl:param name="anchorName" select="''" />
		<xsl:param name="personTerminator" />
		<xsl:param name="skipPartyNumberColumn" select="'false'" />
		<xsl:param name="forcePrintingPartyNumber" select="'false'" />
		<xsl:param name="partyNumberingFormat" select="'1'" />
		<xsl:param name="personNumberingFormat" select="'a'" />

		<xsl:variable name="party" select=".." />
		<xsl:variable name="currentPersonId" select="@id" />
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
		<xsl:variable name="anyRelatedPersonsWithBullet">
			<xsl:choose>
				<xsl:when test="count(current()/tia:GerelateerdPersoon/tia:IMKAD_Persoon[not($party/tia:Hoedanigheid[concat('#', @id) = $party/descendant::tia:IMKAD_Persoon/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href']]/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#', @id))]) > 0">
					<xsl:text>true</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>false</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="onlyPersonWithBullet">
			<xsl:choose>
				<!-- When count of PNP persons which are not single and doesn't have Hoedanigheid or just doesn't have Hoedanigheid voor zich or which are single persons and doesn't have Hoedanigheid at all -->
				<xsl:when test="count(preceding-sibling::tia:IMKAD_Persoon[(tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene)
										and ((tia:GerelateerdPersoon and (not(concat('#', @id) = $party/tia:Hoedanigheid/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href']) or concat('#', @id) = $party/tia:Hoedanigheid[not(tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvoorzich'])]/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href']))
										or (not(tia:GerelateerdPersoon) and not(concat('#', @id) = $party/tia:Hoedanigheid/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'])))]) +
								count(following-sibling::tia:IMKAD_Persoon[(tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene)
										and ((tia:GerelateerdPersoon and (not(concat('#', @id) = $party/tia:Hoedanigheid/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href']) or concat('#', @id) = $party/tia:Hoedanigheid[not(tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvoorzich'])]/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href']))
										or (not(tia:GerelateerdPersoon) and not(concat('#', @id) = $party/tia:Hoedanigheid/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'])))]) +
								count($party/tia:IMKAD_Persoon[tia:tia_Gegevens/tia:NHR_Rechtspersoon and not((count(tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder']) = 0) and concat('#', @id) =
								$party/tia:Hoedanigheid/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] and count(preceding-sibling::tia:IMKAD_Persoon) > 0)]) +
								count($party/tia:IMKAD_Persoon[tia:tia_Gegevens/tia:NHR_Rechtspersoon and count(tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder']) > 1]/tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder' and
								preceding-sibling::tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder']]) = 0">
					<xsl:text>true</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>false</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="currentMainPerson" select="." />
		<xsl:variable name="firstRelatedPerson" select="tia:GerelateerdPersoon[1]/tia:IMKAD_Persoon" />
		<xsl:variable name="followingPerson" select="following-sibling::tia:IMKAD_Persoon[1]" />
		<xsl:variable name="isFollowingPersonNaturalPerson">
			<xsl:choose>
				<xsl:when test="$followingPerson/tia:tia_Gegevens/tia:NHR_Rechtspersoon">
					<xsl:text>false</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>true</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="capacityExists" select="$party/tia:Hoedanigheid[current()/descendant-or-self::tia:IMKAD_Persoon/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id) and tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#', $currentMainPerson/tia:GerelateerdPersoon/tia:IMKAD_Persoon/@id)]" />
		<xsl:variable name="previousPerson" select="preceding-sibling::tia:IMKAD_Persoon[1]" />
		<xsl:variable name="isPreviousPersonNaturalPerson">
			<xsl:choose>
				<xsl:when test="$previousPerson[tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene]">
					<xsl:text>true</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>false</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="previousCapacityExists" select="$party/tia:Hoedanigheid[($previousPerson/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id) or $previousPerson/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id)) and tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#', $currentPersonId)]" />
		<xsl:variable name="firstRelatedPersonAuthorizedRepresentative" select="$party/tia:Hoedanigheid[$party/tia:Gevolmachtigde/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id)]/tia:wordtVertegenwoordigdRef = concat('#',$firstRelatedPerson/@id)" />
		<!-- Last representer to GerelateerdPersoon in current person; representer from current person-->
		<xsl:variable name="isLastInternalPersonRepresenter">
			<xsl:choose>
				<xsl:when test="count($currentMainPerson/descendant-or-self::tia:IMKAD_Persoon[concat('#', $capacityExists/@id) = tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href']]) = 1">
					<xsl:text>true</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>false</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="capacityForNextPerson" select="$party/tia:Hoedanigheid[current()/descendant-or-self::tia:IMKAD_Persoon/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id) and tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#', $followingPerson/@id)]" />
		<xsl:variable name="numberingFormat">
			<xsl:choose>
				<xsl:when test="$onlyPersonWithBullet != $anyRelatedPersonsWithBullet">
					<xsl:value-of select="$personNumberingFormat" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="translate($personNumberingFormat, '1a', 'a1')" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="referencedPersonVariant" select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_keuzeblokvariant']/tia:tekst" />
		<xsl:variable name="secondLevel">
			<xsl:choose>
				<xsl:when test="($isPreviousPersonNaturalPerson = 'true' and $previousCapacityExists) or
								(not($isPreviousPersonNaturalPerson = 'true' and $previousCapacityExists) and $anyRelatedPersonsWithBullet = 'true') or
								($onlyPersonWithBullet = 'false' and $anyRelatedPersonsWithBullet = 'true')">
					<xsl:text>true</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>false</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="nestingDepth">
			<xsl:choose>
				<xsl:when test="$onlyPersonWithBullet = 'false' and $anyRelatedPersonsWithBullet = 'true' and $secondLevel = 'true'">
					<xsl:text>2</xsl:text>
				</xsl:when>
				<xsl:when test="($onlyPersonWithBullet = 'false' and $anyRelatedPersonsWithBullet = 'false' and $secondLevel = 'false') or ($onlyPersonWithBullet = 'true' and $anyRelatedPersonsWithBullet = 'true' and $secondLevel = 'false') or $secondLevel = 'true'">
					<xsl:text>1</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>0</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="representerPerson" select="$party/descendant-or-self::tia:IMKAD_Persoon[tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',$capacityForNextPerson/@id)]" />
		<xsl:variable name="referencedPerson" select="$party/descendant-or-self::tia:IMKAD_Persoon[$party/tia:Hoedanigheid[$currentMainPerson/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id)]/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id)]" />
		<xsl:variable name="representerKeuzeblokVariant" select="$representerPerson/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_keuzeblokvariant']/tia:tekst" />
		<xsl:variable name="isMainPerson" select="$party/@id" /> <!-- If @id is recognized mean that current is main person, not nested -->
		<xsl:variable name="intermedialPerson" select="$party/tia:Hoedanigheid[$representerPerson/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id) and tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href']] and $isMainPerson" />
		<xsl:variable name="forThem" select="$previousCapacityExists/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvoorzich']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
				translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvoorzich']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
				translate(normalize-space($previousCapacityExists/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvoorzich']/tia:tekst), $upper, $lower)]), $upper, $lower)]" />
		<xsl:variable name="numberOfPrecedingPersonsRepresentingFollowingPerson" select="count(preceding::tia:IMKAD_Persoon[tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',$capacityForNextPerson/@id)])" />

		<!-- Doesn't contain hoedanigheid which is referenced from previousPerson and which reference to current person or contain such hoedanigheid but is not voor zich -->
		<xsl:if test="not($previousCapacityExists) or (not($forThem) and $previousCapacityExists)">
			<tr>
				<td>
					<table>
						<tbody>
							<tr>
								<xsl:apply-templates select="." mode="do-party-natural-person-person-pair-person-one-common">
									<xsl:with-param name="start" select="$start" />
									<xsl:with-param name="anchorName" select="$anchorName" />
									<xsl:with-param name="onlyPersonWithBullet" select="$onlyPersonWithBullet" />
									<xsl:with-param name="anyRelatedPersonsWithBullet" select="$anyRelatedPersonsWithBullet" />
									<xsl:with-param name="skipPartyNumberColumn" select="$skipPartyNumberColumn" />
									<xsl:with-param name="forcePrintingPartyNumber" select="$forcePrintingPartyNumber" />
									<xsl:with-param name="partyNumberingFormat" select="$partyNumberingFormat" />
									<xsl:with-param name="personNumberingFormat" select="$personNumberingFormat" />
								</xsl:apply-templates>
								<td>
									<xsl:apply-templates select="." mode="do-party-natural-person-common-part-one" />
									<xsl:if test="tia:tia_BurgerlijkeStaatTekst">
										<xsl:text>, </xsl:text>
									</xsl:if>
									<xsl:apply-templates select="." mode="do-marital-status" />
									<xsl:choose>
										<xsl:when test="$capacityExists and not($firstRelatedPersonAuthorizedRepresentative) and $isLastInternalPersonRepresenter = 'true'">
											<xsl:choose>
												<xsl:when test="$referencedPersonVariant = '3'">
													<xsl:text>; </xsl:text>
												</xsl:when>
												<xsl:otherwise>
													<xsl:text>, </xsl:text>
												</xsl:otherwise>
											</xsl:choose>
											<xsl:apply-templates select="$capacityExists" mode="do-capacity-variant-for-natural-person">
												<xsl:with-param name="nestingDepth" select="number($nestingDepth)" />
												<xsl:with-param name="representerPersons" select="." />
												<xsl:with-param name="relatedPersons" select="$referencedPerson" />
												<xsl:with-param name="numberingFormat" select="$numberingFormat" />
											</xsl:apply-templates>
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
			<xsl:for-each select="tia:GerelateerdPersoon">
				<xsl:variable name="currentRelatedPerson" select="tia:IMKAD_Persoon" />
				<xsl:variable name="relatedPersonAuthorizedRepresentative" select="$party/tia:Gevolmachtigde[tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',$party/tia:Hoedanigheid[tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',$currentRelatedPerson/@id)]/@id)]" />
				<xsl:variable name="authorizedRepresentativeHoedanigheid" select="$party/tia:Hoedanigheid[concat('#',@id) = $party/tia:Gevolmachtigde/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] and tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',$currentRelatedPerson/@id)]" />
				<xsl:variable name="alreadyProcessed">
					<xsl:choose>
						<xsl:when test="count(preceding-sibling::tia:GerelateerdPersoon/tia:IMKAD_Persoon[concat('#', @id) = $authorizedRepresentativeHoedanigheid/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href']]) > 0
								or not($party/tia:Hoedanigheid[not($authorizedRepresentativeHoedanigheid/@id = @id) and concat('#',@id) = $party/descendant::tia:IMKAD_Persoon/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href']]/tia:wordtVertegenwoordigdRef[@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',current()/tia:IMKAD_Persoon/@id)]) = false">
							<xsl:text>true</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>false</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<xsl:variable name="positionWithinPerson" select="count(preceding-sibling::tia:GerelateerdPersoon/tia:IMKAD_Persoon[not(concat('#', @id) = $party/tia:Hoedanigheid/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'])])
																+ count($party/tia:Hoedanigheid[concat('#', @id) = $party/tia:Gevolmachtigde/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] and substring-after(tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'], '#') = current()/preceding-sibling::tia:GerelateerdPersoon/tia:IMKAD_Persoon/@id])
																+ 1" />

				<xsl:choose>
					<xsl:when test="$relatedPersonAuthorizedRepresentative">
						<xsl:if test="$alreadyProcessed = 'false'">
							<tr>
								<td>
									<table>
										<tbody>
											<tr>
												<xsl:apply-templates select="tia:IMKAD_Persoon" mode="do-party-natural-person-person-pair-person-two-common">
													<xsl:with-param name="onlyPersonWithBullet" select="$onlyPersonWithBullet" />
													<xsl:with-param name="anyRelatedPersonsWithBullet" select="$anyRelatedPersonsWithBullet" />
													<xsl:with-param name="secondLevel" select="$secondLevel" />
													<xsl:with-param name="position" select="$positionWithinPerson" />
													<xsl:with-param name="skipPartyNumberColumn" select="$skipPartyNumberColumn" />
													<xsl:with-param name="personNumberingFormat" select="$personNumberingFormat" />
												</xsl:apply-templates>
												<td>
													<xsl:apply-templates select="$relatedPersonAuthorizedRepresentative" mode="do-legal-representative" />
													<xsl:choose>
														<xsl:when test="count($authorizedRepresentativeHoedanigheid/tia:wordtVertegenwoordigdRef) = 1">
															<xsl:variable name="relatedPersonID" select="substring-after($authorizedRepresentativeHoedanigheid/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'], '#')" />
															<xsl:text> </xsl:text>
															<xsl:apply-templates select="$currentMainPerson/tia:GerelateerdPersoon/tia:IMKAD_Persoon[@id = $relatedPersonID]" mode="do-party-natural-person-common-part-one" />
															<xsl:if test="$currentMainPerson/tia:GerelateerdPersoon/tia:IMKAD_Persoon[@id = $relatedPersonID]/tia:tia_BurgerlijkeStaatTekst">
																<xsl:text>, </xsl:text>
															</xsl:if>
															<xsl:apply-templates select="$currentMainPerson/tia:GerelateerdPersoon/tia:IMKAD_Persoon[@id = $relatedPersonID]" mode="do-marital-status" />
															<xsl:text>;</xsl:text>
														</xsl:when>
														<xsl:when test="count($authorizedRepresentativeHoedanigheid/tia:wordtVertegenwoordigdRef) > 1">
															<xsl:text>:</xsl:text>
															<table cellspacing="0" cellpadding="0">
																<tbody>
																	<xsl:variable name="lastRelatedPersons" select="count($authorizedRepresentativeHoedanigheid/tia:wordtVertegenwoordigdRef)" />
																	<xsl:for-each select="$authorizedRepresentativeHoedanigheid/tia:wordtVertegenwoordigdRef">
																		<xsl:variable name="relatedPersonID" select="substring-after(current()/@*[translate(local-name(), $upper, $lower) = 'href'], '#')" />
																		<tr>
																			<td class="number" valign="top">
																				<xsl:number value="position()" format="{$numberingFormat}" />
																				<xsl:text>.</xsl:text>
																			</td>
																			<td>
																				<xsl:attribute name="class">
																					<xsl:if test="$onlyPersonWithBullet = 'false' and $anyRelatedPersonsWithBullet = 'true' and $secondLevel = 'true'">
																						<xsl:text>level2</xsl:text>
																					</xsl:if>
																					<xsl:if test="not($onlyPersonWithBullet = 'false' and $anyRelatedPersonsWithBullet = 'true' and $secondLevel = 'true')">
																						<xsl:text>level1</xsl:text>
																					</xsl:if>
																				</xsl:attribute>
																				<xsl:apply-templates select="$currentMainPerson/tia:GerelateerdPersoon/tia:IMKAD_Persoon[@id = $relatedPersonID]" mode="do-party-natural-person-common-part-one" />
																				<xsl:if test="$currentMainPerson/tia:GerelateerdPersoon/tia:IMKAD_Persoon[@id = $relatedPersonID]/tia:tia_BurgerlijkeStaatTekst">
																					<xsl:text>, </xsl:text>
																				</xsl:if>
																				<xsl:apply-templates select="$currentMainPerson/tia:GerelateerdPersoon/tia:IMKAD_Persoon[@id = $relatedPersonID]" mode="do-marital-status" />
																				<xsl:text>;</xsl:text>
																				<xsl:if test="position() != $lastRelatedPersons">
																					<xsl:text> en </xsl:text>
																				</xsl:if>
																			</td>
																		</tr>
																	</xsl:for-each>
																</tbody>
															</table>
														</xsl:when>
													</xsl:choose>
												</td>
											</tr>
										</tbody>
									</table>
								</td>
							</tr>
						</xsl:if>
					</xsl:when>
					<xsl:otherwise>
						<xsl:variable name="nextRelatedPersonToProcess" select="following-sibling::tia:GerelateerdPersoon[not(concat('#',tia:IMKAD_Persoon/@id) = $party/tia:Hoedanigheid[$party/tia:Gevolmachtigde/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id)]/tia:wordtVertegenwoordigdRef)][1]/tia:IMKAD_Persoon" />
						<xsl:variable name="capacityExistsForRelatedPerson" select="$party/tia:Hoedanigheid[$currentRelatedPerson/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id) and tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#', $currentMainPerson/tia:GerelateerdPersoon/tia:IMKAD_Persoon/@id)]" />
						<xsl:variable name="nextRelatedPersonAuthorizedRepresentative" select="$party/tia:Hoedanigheid[$party/tia:Gevolmachtigde/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id)]/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',$firstRelatedPerson/@id)" />
						<xsl:variable name="lastRepresenter">
							<xsl:choose>
								<xsl:when test="count($currentMainPerson/following-sibling::tia:IMKAD_Persoon[tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#', $capacityExists/@id)]) +
												count(following-sibling::tia:GerelateerdPersoon/tia:IMKAD_Persoon[tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#', $capacityExistsForRelatedPerson/@id)]) = 0">
									<xsl:text>true</xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>false</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="relatedRepresenters" select="$currentMainPerson/descendant-or-self::tia:IMKAD_Persoon[tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#', $capacityExistsForRelatedPerson/@id)]" />
						<xsl:if test="$alreadyProcessed = 'false'">
							<tr>
								<td>
									<table>
										<tbody>
											<tr>
												<xsl:apply-templates select="tia:IMKAD_Persoon" mode="do-party-natural-person-person-pair-person-two-common">
													<xsl:with-param name="onlyPersonWithBullet" select="$onlyPersonWithBullet" />
													<xsl:with-param name="anyRelatedPersonsWithBullet" select="$anyRelatedPersonsWithBullet" />
													<xsl:with-param name="secondLevel" select="$secondLevel" />
													<xsl:with-param name="position" select="$positionWithinPerson" />
													<xsl:with-param name="skipPartyNumberColumn" select="$skipPartyNumberColumn" />
													<xsl:with-param name="personNumberingFormat" select="$personNumberingFormat" />
												</xsl:apply-templates>
												<td>
													<xsl:apply-templates select="tia:IMKAD_Persoon" mode="do-party-natural-person-common-part-one" />
													<xsl:if test="tia:IMKAD_Persoon/tia:tia_BurgerlijkeStaatTekst">
														<xsl:text>, </xsl:text>
													</xsl:if>
													<xsl:apply-templates select="tia:IMKAD_Persoon" mode="do-marital-status" />
													<xsl:choose>
														<xsl:when test="$capacityExistsForRelatedPerson and not($nextRelatedPersonAuthorizedRepresentative) and $lastRepresenter = 'true'">
															<xsl:text>; </xsl:text>
															<xsl:apply-templates select="$capacityExistsForRelatedPerson" mode="do-capacity-variant-for-natural-person">
																<xsl:with-param name="nestingDepth" select="number($nestingDepth)" />
																<xsl:with-param name="relatedPersons" select="$relatedRepresenters" />
																<xsl:with-param name="representerPersons" select="." />
																<xsl:with-param name="numberingFormat" select="$numberingFormat" />
															</xsl:apply-templates>
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
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
			<tr>
				<td>
					<table>
						<tbody>
							<tr>
								<xsl:if test="not($skipPartyNumberColumn = 'true')">
									<td class="number" valign="top">
										<xsl:text>&#xFEFF;</xsl:text>
									</td>
								</xsl:if>
								<xsl:if test="$onlyPersonInParty = 'false' and $onlyPersonWithBullet = 'false'">
									<td class="number" valign="top">
										<xsl:text>&#xFEFF;</xsl:text>
									</td>
								</xsl:if>
								<!-- When previous main person represent current person throught voor zich Hoedanigheid than need to be moved column to right -->
								<xsl:if test="$forThem and $previousPerson/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',$previousCapacityExists/@id) and $previousCapacityExists/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id)">
									<td class="number" valign="top">
										<xsl:text>&#xFEFF;</xsl:text>
									</td>
								</xsl:if>
								<td>
									<!-- Print Hoedanigheid for Person and GerelateerdPersoon; when GerelateerdPersoon > 1 nestingDepth = 1, otherwise 0 -->
									<xsl:variable name="nestingDepthForExternalPrintOfHoedanigheid">
										<xsl:choose>
											<xsl:when test="$nestingDepth > 1">
												<xsl:value-of select="number('1')" />
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="number('0')" />
											</xsl:otherwise>
										</xsl:choose>
									</xsl:variable>
									<xsl:apply-templates select="." mode="do-joint-address-marital-status" />
									<xsl:choose>
										<xsl:when test="$capacityForNextPerson and $isFollowingPersonNaturalPerson = 'true' and $numberOfPrecedingPersonsRepresentingFollowingPerson = 0">
											<xsl:text>, </xsl:text>
											<xsl:apply-templates select="$followingPerson" mode="do-main-person-capacity">
												<xsl:with-param name="representerPersons" select="$representerPerson" />
												<xsl:with-param name="relatedPersons" select="$party/descendant-or-self::tia:IMKAD_Persoon[$capacityForNextPerson/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id)]" />
												<xsl:with-param name="hoedanigheid" select="$capacityForNextPerson" />
												<xsl:with-param name="intermedialPerson" select="$intermedialPerson" />
												<xsl:with-param name="personVariant" select="'3'" />
												<xsl:with-param name="personNumberingFormat" select="$personNumberingFormat" />
												<xsl:with-param name="onlyPersonWithBullet" select="$onlyPersonWithBullet" />
												<xsl:with-param name="nestingDepth" select="$nestingDepthForExternalPrintOfHoedanigheid" />
											</xsl:apply-templates>
										</xsl:when>
										<xsl:when test="$capacityForNextPerson and $isFollowingPersonNaturalPerson = 'true' and $numberOfPrecedingPersonsRepresentingFollowingPerson > 0">
											<xsl:text>,</xsl:text>
										</xsl:when>
										<xsl:when test="not($capacityForNextPerson)">
											<xsl:text>;</xsl:text>
										</xsl:when>
									</xsl:choose>
								</td>
							</tr>
						</tbody>
					</table>
				</td>
			</tr>
			<!-- Print intermedialPerson Hoedanigheid; nestingDepth = 0 -->
			<xsl:if test="$numberOfPrecedingPersonsRepresentingFollowingPerson > 0">
				<tr>
					<td>
						<table>
							<tbody>
								<tr>
									<td class="number" valign="top">
										<xsl:text>&#xFEFF;</xsl:text>
									</td>
									<td>
										<xsl:apply-templates select="$followingPerson" mode="do-main-person-capacity">
											<xsl:with-param name="representerPersons" select="$representerPerson"/>
											<xsl:with-param name="relatedPersons"
															select="$party/descendant-or-self::tia:IMKAD_Persoon[$capacityForNextPerson/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id)]"/>
											<xsl:with-param name="hoedanigheid" select="$capacityForNextPerson"/>
											<xsl:with-param name="intermedialPerson" select="$intermedialPerson"/>
											<xsl:with-param name="personVariant" select="'3'"/>
											<xsl:with-param name="personNumberingFormat"
															select="$personNumberingFormat"/>
											<xsl:with-param name="onlyPersonWithBullet" select="$onlyPersonWithBullet"/>
										</xsl:apply-templates>
									</td>
								</tr>
							</tbody>
						</table>
					</td>
				</tr>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<!--
	*********************************************************
	Mode: do-party-person-number-for-natural-person
	*********************************************************
	Public: no

	Identity transform: no

	Description: Determines number of P(N)NP within party.

	Input: tia:IMKAD_Persoon

	Params: numberingFormat - format of the numbering
			currentParty - party which contains processed person
			ordinalNumberOfPersonInParty - ordinal number of the person within XML
			positionWithinPerson - position in person which should be taken into account also
			secondLevel - ?

	Output: text

	Calls: none

	Called by:
	(mode) do-party-legal-person
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon" mode="do-party-person-number-for-natural-person">
		<xsl:param name="numberingFormat" />
		<xsl:param name="currentParty" select="self::node()[false()]" />
		<xsl:param name="ordinalNumberOfPersonInParty" select="number('0')" />
		<xsl:param name="positionWithinPerson" select="number('0')" />
		<xsl:param name="secondLevel" select="'false'" />

		<!-- Count rules (Count is based into position of person in XML (ordinal number)):
			1. PNNP that are printed without bullet are not taken into acount
			2. PNNP with volmachtgever related persons that are all printed with the bullet are taken into account
			3. Additional bestuurders from PNNP are also taken into acount
			4. For PNP, when there is Gevolmachtigde acting on person level, all PNP's represented by that Gevolmachtigde are listed within one bullet, so should not be taken into acount
			5. For PNP, if a main person is represented by a previous PNP then the related persons of that main person are each counted as one bullet as they are shifted to the left, to first level of numbering
		-->
		<xsl:variable name="positionWithinParty">
			<xsl:choose>
				<xsl:when test="$secondLevel = 'true'">
					<xsl:value-of select="number('1')" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="count($currentParty/tia:IMKAD_Persoon[$ordinalNumberOfPersonInParty]/preceding-sibling::tia:IMKAD_Persoon[tia:tia_Gegevens/tia:NHR_Rechtspersoon and not(count(tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder']) = 0 and count(tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'volmachtgever']) = 0 and (concat('#', @id) = $currentParty/tia:Hoedanigheid/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href']) and count(preceding-sibling::tia:IMKAD_Persoon) > 0)])
								+ count($currentParty/tia:IMKAD_Persoon[$ordinalNumberOfPersonInParty]/preceding-sibling::tia:IMKAD_Persoon[tia:tia_Gegevens/tia:NHR_Rechtspersoon and count(tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder']) = 0 and (concat('#', @id) = $currentParty/tia:Hoedanigheid/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href']) and count(preceding-sibling::tia:IMKAD_Persoon) > 0]/tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'volmachtgever']/tia:IMKAD_Persoon)
								+ count($currentParty/tia:IMKAD_Persoon[$ordinalNumberOfPersonInParty]/preceding-sibling::tia:IMKAD_Persoon[count(tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder']) > 1]/tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder' and preceding-sibling::tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder']])
								+ count($currentParty/tia:IMKAD_Persoon[$ordinalNumberOfPersonInParty]/preceding-sibling::tia:IMKAD_Persoon[(tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene)
										and ((tia:GerelateerdPersoon and (not(concat('#', @id) = $currentParty/tia:Hoedanigheid/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href']) or concat('#', @id) = $currentParty/tia:Hoedanigheid[not(tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvoorzich'])]/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href']))
										or (not(tia:GerelateerdPersoon) and not(concat('#', @id) = $currentParty/tia:Hoedanigheid/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'])))])
								+ 1" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="personNumberValue">
			<xsl:choose>
				<xsl:when test="$positionWithinPerson > 0 and $secondLevel = 'true'">
					<xsl:value-of select="$positionWithinPerson + $positionWithinParty" />
				</xsl:when>
				<xsl:when test="$positionWithinPerson > 0 and $secondLevel = 'false'">
					<xsl:value-of select="$positionWithinPerson + $positionWithinParty - 1" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$positionWithinParty" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:number value="$personNumberValue" format="{$numberingFormat}" />
		<xsl:text>.</xsl:text>
	</xsl:template>

	<!--
	*********************************************************
	Mode: do-capacity-variant-for-natural-person
	*********************************************************
	Public: yes

	Identity transform: no

	Description: Hoedangheid text block.

	Input: tia:IMKAD_Persoon

	Params: nestingDepth - nesting depth for current recursive iteration
			representerPersons - person which referenced to hoedanigheid, previous person
			relatedPersons - variable where related persons are stored
			authorizedRepresentative - variable where related authorized representative is stored
			numberingFormat - format of the numbering
			intermedialPerson - true when hoedanigheid is referenced from previous main person and have reference to current main Person
			personVariant - k_KeuzeblokVariant specified in XML, value can be 1, 2, 3, 4 or 5. When doesn't exist k_KeuzeblokVariant, implies value is 1
			onlyPersonWithBullet - true when current person is only person with number (or when other persons are single, or referenced, or voor zich etc.)

	Output: text

	Calls:
	(mode) do-gender-salutation
	(mode) do-capacity-variant-for-natural-person-variant

	Called by:
	(mode) do-party-legal-person
	(mode) do-person-pair-partner-variant-two
	(mode) do-person-pair-housemate-variant-three
	(mode) do-person-pair-partner-variant-four
	(mode) do-person-pair-representative-variant-five
	(mode) do-legal-representative
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:Hoedanigheid" mode="do-capacity-variant-for-natural-person">
		<xsl:param name="nestingDepth" select="number('0')" />
		<xsl:param name="representerPersons" select="self::node()[false()]" />
		<xsl:param name="relatedPersons" select="self::node()[false()]" />
		<xsl:param name="authorizedRepresentative" select="self::node()[false()]" />
		<xsl:param name="numberingFormat" />
		<xsl:param name="intermedialPerson" select="false" />
		<xsl:param name="personVariant" select="number('0')" />
		<xsl:param name="onlyPersonWithBullet" select="'false'" />

		<xsl:variable name="party" select=".." />
		<xsl:variable name="currentHoedanigheid" select="." />
		<xsl:variable name="forThem" select="tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvoorzich']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
				translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvoorzich']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
				translate(normalize-space(current()/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvoorzich']/tia:tekst), $upper, $lower)]), $upper, $lower)]" />
		<xsl:variable name="capacityNumber" select="tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidbenaming']/tia:tekst" />
		<xsl:variable name="named" select="tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvoornoemd']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
				translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvoornoemd']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
				translate(normalize-space(current()/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvoornoemd']/tia:tekst), $upper, $lower)]), $upper, $lower)]" />

		<xsl:if test="translate($capacityNumber, $upper, $lower) = '1'">
			<xsl:if test="$authorizedRepresentative">
				<xsl:apply-templates select="$authorizedRepresentative/tia:gegevens/tia:persoonGegevens" mode="do-gender-salutation" />
				<xsl:text> </xsl:text>
				<xsl:value-of select="$authorizedRepresentative/tia:gegevens/tia:persoonGegevens/tia:naam/tia:voornamen" />
				<xsl:if test="$authorizedRepresentative/tia:gegevens/tia:persoonGegevens/tia:tia_VoorvoegselsNaam
						and normalize-space($authorizedRepresentative/tia:gegevens/tia:persoonGegevens/tia:tia_VoorvoegselsNaam) != ''">
					<xsl:text> </xsl:text>
					<xsl:value-of select="$authorizedRepresentative/tia:gegevens/tia:persoonGegevens/tia:tia_VoorvoegselsNaam" />
				</xsl:if>
				<xsl:text> </xsl:text>
				<xsl:value-of select="$authorizedRepresentative/tia:gegevens/tia:persoonGegevens/tia:tia_NaamZonderVoorvoegsels" />
				<xsl:choose>
					<xsl:when test="count($representerPersons) = 1">
						<xsl:text> en </xsl:text>
					</xsl:when>
					<xsl:when test="count($representerPersons) > 1">
						<xsl:text>, </xsl:text>
					</xsl:when>
				</xsl:choose>
			</xsl:if>
			<xsl:variable name="lastRepresenter" select="count($representerPersons)" />
			<xsl:for-each select="$representerPersons">
				<xsl:apply-templates select="." mode="do-not-voorzich-data" />
				<xsl:choose>
					<xsl:when test="position() = $lastRepresenter" />
					<xsl:when test="position() + 1 = $lastRepresenter">
						<xsl:text> en </xsl:text>
					</xsl:when>
					<xsl:when test="position() + 1 &lt; $lastRepresenter">
						<xsl:text>, </xsl:text>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
			<xsl:if test="$named">
				<xsl:text> </xsl:text>
				<xsl:value-of select="$named" />
			</xsl:if>
			<xsl:text>,</xsl:text>
		</xsl:if>
		<xsl:text> te dezen </xsl:text>
		<xsl:if test="($authorizedRepresentative and count($representerPersons) > 0) or (not($authorizedRepresentative) and count($representerPersons) > 1)">
			<xsl:text>gezamenlijk </xsl:text>
		</xsl:if>
		<xsl:text>handelend</xsl:text>
		<xsl:variable name="numberOfGerelateerdPersoon" select="count($party/tia:IMKAD_Persoon[$currentHoedanigheid/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id)]/tia:GerelateerdPersoon)" />
		<xsl:choose>
			<!-- voor zich -->
			<xsl:when test="$forThem and translate($party/descendant::tia:IMKAD_Persoon[$currentHoedanigheid/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id)]/tia:tia_IndGerechtigde, $upper, $lower) = 'true'">
				<xsl:text>:</xsl:text>
				<table>
					<tbody>
						<tr>
							<td class="number" valign="top">
								<xsl:number value="1" format="I" />
								<xsl:text>.</xsl:text>
							</td>
							<td>
								<xsl:attribute name="class">
									<xsl:text>level</xsl:text>
									<xsl:value-of select="$nestingDepth" />
								</xsl:attribute>
								<xsl:value-of select="$forThem" />
							</td>
						</tr>
						<tr>
							<td class="number" valign="top">
								<xsl:number value="2" format="I" />
								<xsl:text>.</xsl:text>
							</td>
							<td>
								<xsl:attribute name="class">
									<xsl:text>level</xsl:text>
									<xsl:value-of select="$nestingDepth" />
								</xsl:attribute>

								<xsl:variable name="personPointingToHoedanigheid" select="$party/descendant-or-self::tia:IMKAD_Persoon[tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',$currentHoedanigheid/@id)]" />
								<xsl:apply-templates select="." mode="do-capacity-variant-for-natural-person-variant">
									<xsl:with-param name="relatedPersons" select="$personPointingToHoedanigheid" />
									<xsl:with-param name="authorizedRepresentative" select="$authorizedRepresentative" />
								</xsl:apply-templates>
								<xsl:choose>
									<xsl:when test="count(tia:wordtVertegenwoordigdRef) + $numberOfGerelateerdPersoon > 1">
										<xsl:text>: </xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text> </xsl:text>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:choose>
									<!-- External referencing - main Person reference next main Person through hoedanigheid -->
									<xsl:when test="$intermedialPerson">
										<xsl:variable name="currentMainPerson" select="$party/tia:IMKAD_Persoon[current()/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id)]" />
										<xsl:variable name="firstRelatedPerson" select="$currentMainPerson/tia:GerelateerdPersoon[1]/tia:IMKAD_Persoon" />
										<xsl:variable name="followingPerson" select="$currentMainPerson/following-sibling::tia:IMKAD_Persoon[1]" />

										<xsl:choose>
											<!-- referenced main person - currentMainPerson - doesn't contain GerelateerdPersoon -->
											<xsl:when test="$numberOfGerelateerdPersoon = 0">
												<!-- Gevolmachtigde reference to current Hoedanigheid -->
												<xsl:variable name="relatedPersonAuthorizedRepresentative" select="$party/tia:Gevolmachtigde[concat('#',$currentHoedanigheid/@id) = tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href']]" />
												<xsl:if test="$relatedPersonAuthorizedRepresentative">
													<xsl:apply-templates select="$relatedPersonAuthorizedRepresentative" mode="do-legal-representative" />
												</xsl:if>
												<xsl:apply-templates select="." mode="do-hoedanigheid-person-data">
													<xsl:with-param name="referencedPerson" select="$currentMainPerson" />
												</xsl:apply-templates>
											</xsl:when>
											<!-- referenced main person - currentMainPerson - contain GerelateerdPersoon -->
											<xsl:otherwise>
												<table>
													<tbody>
														<!-- main person text -->
														<tr>
															<td class="number" valign="top">
																<xsl:number value="1" format="{$numberingFormat}" />
																<xsl:text>.</xsl:text>
															</td>
															<td class="number">
																<xsl:number value="1" format="{translate($numberingFormat, '1a', 'a1')}" />
																<xsl:text>.</xsl:text>
															</td>
															<td>
																<xsl:attribute name="class">
																	<xsl:text>level</xsl:text>
																	<xsl:value-of select="$nestingDepth + 1" />
																</xsl:attribute>
																<xsl:apply-templates select="." mode="do-hoedanigheid-person-data">
																	<xsl:with-param name="referencedPerson" select="$currentMainPerson" />
																</xsl:apply-templates>
															</td>
														</tr>
														<!-- Through related persons -->
														<xsl:for-each select="$currentMainPerson/tia:GerelateerdPersoon">
															<xsl:variable name="currentRelatedPerson" select="tia:IMKAD_Persoon" />
															<xsl:variable name="relatedPersonAuthorizedRepresentative" select="$party/tia:Gevolmachtigde[concat('#',$party/tia:Hoedanigheid[tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',$currentRelatedPerson/@id)]/@id) = tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href']]" />
															<xsl:variable name="authorizedRepresentativeHoedanigheid" select="$party/tia:Hoedanigheid[concat('#',@id) = $party/tia:Gevolmachtigde/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] and tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',$currentRelatedPerson/@id)]" />
															<xsl:variable name="alreadyProcessed">
																<xsl:choose>
																	<xsl:when test="count(preceding-sibling::tia:GerelateerdPersoon/tia:IMKAD_Persoon[concat('#', @id) = $authorizedRepresentativeHoedanigheid/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href']]) > 0
																			or not($party/tia:Hoedanigheid[not($authorizedRepresentativeHoedanigheid/@id = @id) and concat('#',@id) = $party/descendant::tia:IMKAD_Persoon/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href' and @id != $currentHoedanigheid/@id]]/tia:wordtVertegenwoordigdRef[@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',current()/tia:IMKAD_Persoon/@id)]) = false">
																		<xsl:text>true</xsl:text>
																	</xsl:when>
																	<xsl:otherwise>
																		<xsl:text>false</xsl:text>
																	</xsl:otherwise>
																</xsl:choose>
															</xsl:variable>
															<xsl:variable name="positionWithinPerson" select="count(preceding-sibling::tia:GerelateerdPersoon/tia:IMKAD_Persoon[not(concat('#', @id) = $party/tia:Hoedanigheid/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'])])
																	+ count($party/tia:Hoedanigheid[concat('#', @id) = $party/tia:Gevolmachtigde/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] and substring-after(tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'], '#') = preceding-sibling::tia:GerelateerdPersoon/tia:IMKAD_Persoon/@id])
																	+ 2" />

															<xsl:choose>
																<!-- Gevolmachtigde reference to current Hoedanigheid -->
																<xsl:when test="$relatedPersonAuthorizedRepresentative">
																	<xsl:if test="$alreadyProcessed = 'false'">
																		<tr>
																			<td class="number" valign="top">
																				<xsl:text>&#xFEFF;</xsl:text>
																			</td>
																			<td class="number">
																				<xsl:number value="$positionWithinPerson" format="{translate($numberingFormat, '1a', 'a1')}" />
																				<xsl:text>.</xsl:text>
																			</td>
																			<td>
																				<table>
																					<tbody>
																						<tr>
																							<td>
																								<xsl:attribute name="class">
																									<xsl:text>level</xsl:text>
																									<xsl:choose>
																										<xsl:when test="$authorizedRepresentativeHoedanigheid/tia:wordtVertegenwoordigdRef > 1">
																											<xsl:value-of select="$nestingDepth + 4" />
																										</xsl:when>
																										<xsl:otherwise>
																											<xsl:value-of select="$nestingDepth + 3" />
																										</xsl:otherwise>
																									</xsl:choose>
																								</xsl:attribute>
																								<xsl:apply-templates select="$relatedPersonAuthorizedRepresentative" mode="do-legal-representative" />
																								<xsl:choose>
																									<xsl:when test="count($authorizedRepresentativeHoedanigheid/tia:wordtVertegenwoordigdRef) = 1">
																										<xsl:text> </xsl:text>
																										<xsl:apply-templates select="$authorizedRepresentativeHoedanigheid" mode="do-hoedanigheid-person-data">
																											<xsl:with-param name="referencedPerson" select="$currentRelatedPerson" />
																										</xsl:apply-templates>
																									</xsl:when>
																									<xsl:when test="count($authorizedRepresentativeHoedanigheid/tia:wordtVertegenwoordigdRef[@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#', $currentMainPerson/tia:GerelateerdPersoon/tia:IMKAD_Persoon/@id)]) > 1">
																										<table cellspacing="0" cellpadding="0">
																											<tbody>
																												<xsl:for-each select="$authorizedRepresentativeHoedanigheid/tia:wordtVertegenwoordigdRef">
																													<xsl:variable name="relatedPersonID" select="substring-after(current()/@*[translate(local-name(), $upper, $lower) = 'href'], '#')" />
																													<xsl:variable name="currentlyProcessedPerson" select="$currentMainPerson/tia:GerelateerdPersoon[tia:IMKAD_Persoon[@id = $relatedPersonID]]" />

																													<tr>
																														<td class="number" valign="top">
																															<xsl:number value="$positionWithinPerson" format="{$numberingFormat}" />
																															<xsl:text>.</xsl:text>
																														</td>
																														<td>
																															<xsl:variable name="referencedPerson" select="$party/descendant-or-self::tia:IMKAD_Persoon[current()/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id)]" />
																															<xsl:apply-templates select="$authorizedRepresentativeHoedanigheid" mode="do-hoedanigheid-person-data">
																																<xsl:with-param name="referencedPerson" select="$referencedPerson" />
																															</xsl:apply-templates>
																															<xsl:choose>
																																<xsl:when test="count(following-sibling::tia:wordtVertegenwoordigdRef) > 0 and not($referencedPerson/tia:vertegenwoordigtRef[@*[translate(local-name(), $upper, $lower) = 'href']])">
																																	<xsl:text> en</xsl:text>
																																</xsl:when>
																																<xsl:otherwise>
																																	<xsl:text></xsl:text>
																																</xsl:otherwise>
																															</xsl:choose>
																														</td>
																													</tr>
																												</xsl:for-each>
																											</tbody>
																										</table>
																									</xsl:when>
																								</xsl:choose>
																							</td>
																						</tr>
																					</tbody>
																				</table>
																			</td>
																		</tr>
																	</xsl:if>
																</xsl:when>
																<xsl:otherwise>
																	<xsl:if test="$alreadyProcessed = 'false'">
																		<tr>
																			<td class="number" valign="top">
																				<xsl:text>&#xFEFF;</xsl:text>
																			</td>
																			<td class="number">
																				<xsl:number value="$positionWithinPerson" format="{translate($numberingFormat, '1a', 'a1')}" />
																				<xsl:text>.</xsl:text>
																			</td>
																			<td>
																				<xsl:variable name="capacityExistsForRelatedPerson" select="$party/tia:Hoedanigheid[$currentRelatedPerson/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id)]" />
																				<xsl:variable name="referencedPersonOfRelatedPerson" select="$party/descendant-or-self::tia:IMKAD_Persoon[$capacityExistsForRelatedPerson/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id)]" />
																				<xsl:variable name="forThemFromHoedanigheidFromPerson" select="$capacityExistsForRelatedPerson/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvoorzich']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
																						translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvoorzich']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
																						translate(normalize-space($capacityExistsForRelatedPerson/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvoorzich']/tia:tekst), $upper, $lower)]), $upper, $lower)]" />
																				<xsl:variable name="newNestingDepth">
																					<xsl:choose>
																						<xsl:when test="count($referencedPersonOfRelatedPerson) > 1 and $forThemFromHoedanigheidFromPerson">
																							<xsl:value-of select="$nestingDepth + 4" />
																						</xsl:when>
																						<xsl:otherwise>
																							<xsl:value-of select="$nestingDepth + 3" />
																						</xsl:otherwise>
																					</xsl:choose>
																				</xsl:variable>

																				<table>
																					<tbody>
																						<tr>
																							<td>
																								<xsl:attribute name="class">
																									<xsl:text>level</xsl:text>
																									<xsl:value-of select="$newNestingDepth" />
																								</xsl:attribute>
																								<xsl:choose>
																									<!-- GerelateerdPersoon is referenced with Hoedanigheid -->
																									<xsl:when test="$capacityExistsForRelatedPerson">
																										<xsl:apply-templates select="$capacityExistsForRelatedPerson" mode="do-hoedanigheid-person-data">
																											<xsl:with-param name="referencedPerson" select="$currentRelatedPerson" />
																										</xsl:apply-templates>
																									</xsl:when>
																									<!-- GerelateerdPersoon doesn't have reference from Hoedanigheid -->
																									<xsl:otherwise>
																										<xsl:variable name="capacityNotExistsForRelatedPerson" select="$party/tia:Hoedanigheid[tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#', $currentMainPerson/@id)]" />
																										<xsl:apply-templates select="$capacityNotExistsForRelatedPerson" mode="do-hoedanigheid-person-data">
																											<xsl:with-param name="referencedPerson" select="$currentRelatedPerson" />
																										</xsl:apply-templates>
																									</xsl:otherwise>
																								</xsl:choose>
																								<xsl:apply-templates select="$capacityExistsForRelatedPerson" mode="do-capacity-variant-for-natural-person">
																									<xsl:with-param name="nestingDepth" select="$newNestingDepth" />
																									<xsl:with-param name="representerPersons" select="$currentRelatedPerson" />
																									<xsl:with-param name="relatedPersons" select="$referencedPersonOfRelatedPerson" />
																									<xsl:with-param name="numberingFormat" select="translate($numberingFormat, '1a', 'a1')" />
																								</xsl:apply-templates>
																							</td>
																						</tr>
																					</tbody>
																				</table>
																			</td>
																		</tr>
																	</xsl:if>
																</xsl:otherwise>
															</xsl:choose>
														</xsl:for-each>
													</tbody>
												</table>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:variable name="representerPerson" select="$party/descendant-or-self::tia:IMKAD_Persoon[current()/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id)]" />
										<xsl:variable name="doJointAddressMaritalStatus">
											<xsl:apply-templates select="$currentMainPerson" mode="do-joint-address-marital-status" />
										</xsl:variable>
										<xsl:variable name="capacityForNextPerson" select="$party/tia:Hoedanigheid[current()/descendant-or-self::tia:IMKAD_Persoon/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id) and tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#', $followingPerson/@id)]" />
										<xsl:variable name="numberOfPrecedingPersonsRepresentingFollowingPerson" select="count(preceding::tia:IMKAD_Persoon[tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',$capacityForNextPerson/@id)])" />

										<xsl:if test="normalize-space($doJointAddressMaritalStatus) != '' or ($capacityForNextPerson and not($followingPerson/tia:tia_Gegevens/tia:NHR_Rechtspersoon) and $numberOfPrecedingPersonsRepresentingFollowingPerson = 0)">
											<table>
												<tbody>
													<tr>
														<td class="number" valign="top">
															<xsl:text>&#xFEFF;</xsl:text>
														</td>
														<td colspan="2">
															<xsl:attribute name="class">
																<xsl:text>level</xsl:text>
																<xsl:value-of select="$nestingDepth + 1" />
															</xsl:attribute>
															<xsl:value-of select="$doJointAddressMaritalStatus" />
															<xsl:choose>
																<xsl:when test="$capacityForNextPerson and not($followingPerson/tia:tia_Gegevens/tia:NHR_Rechtspersoon) and $numberOfPrecedingPersonsRepresentingFollowingPerson = 0">
																	<xsl:text>, </xsl:text>
																	<xsl:apply-templates select="$followingPerson" mode="do-main-person-capacity">
																		<xsl:with-param name="representerPersons" select="$representerPerson" />
																		<xsl:with-param name="relatedPersons" select="$party/descendant-or-self::tia:IMKAD_Persoon[$capacityForNextPerson/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id)]" />
																		<xsl:with-param name="hoedanigheid" select="$capacityForNextPerson" />
																		<xsl:with-param name="intermedialPerson" select="$party/tia:Hoedanigheid[$representerPerson/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id) and tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href']] and $party/@id" />
																		<xsl:with-param name="personVariant" select="$followingPerson/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_keuzeblokvariant']/tia:tekst" />
																		<xsl:with-param name="personNumberingFormat" select="$numberingFormat" />
																		<xsl:with-param name="onlyPersonWithBullet" select="$onlyPersonWithBullet" />
																	</xsl:apply-templates>
																</xsl:when>
																<xsl:when test="$capacityForNextPerson and not($followingPerson/tia:tia_Gegevens/tia:NHR_Rechtspersoon) and $numberOfPrecedingPersonsRepresentingFollowingPerson > 0">
																	<xsl:text>,</xsl:text>
																</xsl:when>
																<xsl:when test="not($capacityForNextPerson)">
																	<xsl:text>;</xsl:text>
																</xsl:when>
															</xsl:choose>
														</td>
													</tr>
												</tbody>
											</table>
										</xsl:if>
										<xsl:if test="$numberOfPrecedingPersonsRepresentingFollowingPerson > 0">
											<xsl:apply-templates select="$followingPerson" mode="do-main-person-capacity">
												<xsl:with-param name="representerPersons" select="$representerPerson" />
												<xsl:with-param name="relatedPersons" select="$party/descendant-or-self::tia:IMKAD_Persoon[$capacityForNextPerson/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id)]" />
												<xsl:with-param name="hoedanigheid" select="$capacityForNextPerson" />
												<xsl:with-param name="intermedialPerson" select="$party/tia:Hoedanigheid[$representerPerson/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id) and tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href']] and $party/@id" />
												<xsl:with-param name="personVariant" select="$followingPerson/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_keuzeblokvariant']/tia:tekst" />
												<xsl:with-param name="personNumberingFormat" select="$numberingFormat" />
												<xsl:with-param name="onlyPersonWithBullet" select="$onlyPersonWithBullet" />
											</xsl:apply-templates>
										</xsl:if>
									</xsl:when>
									<xsl:when test="count(tia:wordtVertegenwoordigdRef) = 1">
										<xsl:variable name="referencedPerson" select="$party/descendant::tia:IMKAD_Persoon[current()/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id)]" />
										<xsl:apply-templates select="." mode="do-hoedanigheid-person-data">
											<xsl:with-param name="referencedPerson" select="$referencedPerson" />
										</xsl:apply-templates>
									</xsl:when>
									<xsl:when test="count(tia:wordtVertegenwoordigdRef) > 1">
										<table>
											<tbody>
												<xsl:for-each select="tia:wordtVertegenwoordigdRef">
													<xsl:variable name="referencedPersonWithCurrentHoedanigheid" select="$party/descendant-or-self::tia:IMKAD_Persoon[current()/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id)]" />
													<xsl:variable name="hoedanigheidFromPerson" select="$party/tia:Hoedanigheid[concat('#', @id) = $referencedPersonWithCurrentHoedanigheid/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href']]" />
													<xsl:variable name="isMainPersonRef" select="count($party/tia:IMKAD_Persoon[concat('#',@id) = $hoedanigheidFromPerson/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href']]) > 0" />
													<xsl:variable name="referencedPersonFromCurrentReferencedPerson" select="$party/descendant-or-self::tia:IMKAD_Persoon[$hoedanigheidFromPerson/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',@id)]" />
													<xsl:variable name="forThemFromHoedanigheidFromPerson" select="$hoedanigheidFromPerson/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvoorzich']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
																		translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvoorzich']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
																		translate(normalize-space($hoedanigheidFromPerson/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvoorzich']/tia:tekst), $upper, $lower)]), $upper, $lower)]" />
													<xsl:variable name="newNestingDepth">
														<xsl:choose>
															<xsl:when test="count($referencedPersonFromCurrentReferencedPerson) > 1 and $forThemFromHoedanigheidFromPerson">
																<xsl:value-of select="$nestingDepth + 2" />
															</xsl:when>
															<xsl:otherwise>
																<xsl:value-of select="$nestingDepth + 1" />
															</xsl:otherwise>
														</xsl:choose>
													</xsl:variable>

													<tr>
														<td class="number" valign="top">
															<xsl:number value="position()" format="{$numberingFormat}" />
															<xsl:text>.</xsl:text>
														</td>
														<td>
															<xsl:attribute name="class">
																<xsl:text>level</xsl:text>
																<xsl:value-of select="$newNestingDepth" />
															</xsl:attribute>
															<xsl:apply-templates select="$currentHoedanigheid" mode="do-hoedanigheid-person-data">
																	<xsl:with-param name="referencedPerson" select="$referencedPersonWithCurrentHoedanigheid" />
															</xsl:apply-templates>
															<xsl:if test="count(following-sibling::tia:wordtVertegenwoordigdRef) > 0 and not($referencedPersonWithCurrentHoedanigheid/tia:vertegenwoordigtRef[@*[translate(local-name(), $upper, $lower) = 'href']])">
																<xsl:text> en</xsl:text>
															</xsl:if>
															<!-- Prevent printing twice in case when GerelateerdPersoon reference next main Persoon -->
															<xsl:if test="$referencedPersonWithCurrentHoedanigheid/tia:vertegenwoordigtRef[@*[translate(local-name(), $upper, $lower) = 'href']] and not($isMainPersonRef)">
																<xsl:apply-templates select="$hoedanigheidFromPerson" mode="do-capacity-variant-for-natural-person">
																	<xsl:with-param name="nestingDepth" select="$newNestingDepth" />
																	<xsl:with-param name="representerPersons" select="$referencedPersonWithCurrentHoedanigheid" />
																	<xsl:with-param name="relatedPersons" select="$referencedPersonFromCurrentReferencedPerson" />
																	<xsl:with-param name="numberingFormat" select="translate($numberingFormat, '1a', 'a1')" />
																</xsl:apply-templates>
															</xsl:if>
														</td>
													</tr>
												</xsl:for-each>
											</tbody>
										</table>
									</xsl:when>
								</xsl:choose>
							</td>
						</tr>
					</tbody>
				</table>
			</xsl:when>
			<!-- NOT voor zich -->
			<xsl:otherwise>
				<xsl:text> </xsl:text>
				<xsl:variable name="personPointingToHoedanigheid" select="$party/descendant-or-self::tia:IMKAD_Persoon[tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#',$currentHoedanigheid/@id)]" />
				<xsl:apply-templates select="." mode="do-capacity-variant-for-natural-person-variant">
					<xsl:with-param name="nestingDepth" select="number('1')" />
					<xsl:with-param name="relatedPersons" select="$personPointingToHoedanigheid" />
					<xsl:with-param name="authorizedRepresentative" select="$authorizedRepresentative" />
				</xsl:apply-templates>
				<xsl:choose>
					<xsl:when test="count(tia:wordtVertegenwoordigdRef) + $numberOfGerelateerdPersoon > 1">
						<xsl:text>: </xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text> </xsl:text>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:if test="not($relatedPersons[tia:GerelateerdPersoon])"> <!-- not($personVariant = '1') -->
				<xsl:variable name="lastRelatedPersons" select="count($relatedPersons)" />
				<xsl:choose>
					<xsl:when test="count($relatedPersons) > 1">
						<xsl:for-each select="$relatedPersons">
							<table>
								<tbody>
									<tr>
										<td class="number" valign="top">
											<xsl:number value="position()" format="{$numberingFormat}" />
											<xsl:text>.</xsl:text>
										</td>
										<td>
											<xsl:attribute name="class">
												<xsl:text>level</xsl:text>
												<xsl:value-of select="$nestingDepth" />
											</xsl:attribute>
											<xsl:apply-templates select="$currentHoedanigheid" mode="do-hoedanigheid-person-data">
												<xsl:with-param name="referencedPerson" select="." />
											</xsl:apply-templates>
											<xsl:choose>
												<xsl:when test="position() = $lastRelatedPersons" />
												<xsl:when test="position() + 1 = $lastRelatedPersons">
													<xsl:text> en </xsl:text>
												</xsl:when>
												<xsl:when test="position() + 1 &lt; $lastRelatedPersons">
													<xsl:text>, </xsl:text>
												</xsl:when>
											</xsl:choose>
										</td>
									</tr>
								</tbody>
							</table>
						</xsl:for-each>
					</xsl:when>
					<xsl:when test="count($relatedPersons) = 1">
						<xsl:apply-templates select="$currentHoedanigheid" mode="do-hoedanigheid-person-data">
							<xsl:with-param name="referencedPerson" select="$relatedPersons" />
						</xsl:apply-templates>
						<xsl:choose>
							<xsl:when test="position() = last()" />
							<xsl:when test="position() + 1 = last()">
								<xsl:text> en </xsl:text>
							</xsl:when>
							<xsl:when test="position() + 1 &lt; last()">
								<xsl:text>, </xsl:text>
							</xsl:when>
						</xsl:choose>
					</xsl:when>
				</xsl:choose>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--
	*********************************************************
	Mode: do-joint-address-marital-status
	*********************************************************
	Public: no

	Identity transform: no

	Description: Common text block for joint address and/or marital status

	Input: tia:IMKAD_Persoon

	Params: none

	Output: text

	Calls:
	(mode) do-not-voorzich-data
	(mode) do-marital-status-partners
	(mode) do-party-natural-person-addresses

	Called by:
	(mode) do-person-pair-partner-variant-four
	(mode) do-person-pair-partner-variant-two
	(mode) do-person-pair-housemate-variant-three
	(mode) do-capacity-variant-for-natural-person
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon" mode="do-joint-address-marital-status">
		<xsl:variable name="party" select=".." />
		<xsl:variable name="personVariant" select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_keuzeblokvariant']/tia:tekst" />

		<xsl:if test="$party/tia:Gevolmachtigde and translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_toonnamenpersonen']/tia:tekst, $upper, $lower) = 'true'">
			<xsl:apply-templates select="." mode="do-not-voorzich-data" />
			<xsl:choose>
				<xsl:when test="count(tia:GerelateerdPersoon) = 1">
					<xsl:text> en </xsl:text>
				</xsl:when>
				<xsl:when test="count(tia:GerelateerdPersoon) > 1">
					<xsl:text>, </xsl:text>
				</xsl:when>
			</xsl:choose>
			<xsl:variable name="lastGerlateerdPersoon" select="count(tia:GerelateerdPersoon)" />
			<xsl:for-each select="tia:GerelateerdPersoon">
				<xsl:apply-templates select="./tia:IMKAD_Persoon" mode="do-not-voorzich-data" />
				<xsl:choose>
					<xsl:when test="position() = $lastGerlateerdPersoon - 1">
						<xsl:text> en </xsl:text>
					</xsl:when>
					<xsl:when test="position() != $lastGerlateerdPersoon">
						<xsl:text>, </xsl:text>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
			<xsl:if test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voornoemd']/tia:tekst, $upper, $lower) = 'voornoemd'">
				<xsl:text> voornoemd,</xsl:text>
			</xsl:if>
			<xsl:if test="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_burgerlijkestaattekstpartners'] or $personVariant = '3'">
				<xsl:text> </xsl:text>
			</xsl:if>
		</xsl:if>
		<xsl:apply-templates select="." mode="do-marital-status-partners" />
		<xsl:if test="$personVariant = '4'">
			<xsl:text>, </xsl:text>
		</xsl:if>
		<xsl:if test="$personVariant = '3' or $personVariant = '4'">
			<xsl:text>tezamen </xsl:text>
			<xsl:apply-templates select="." mode="do-party-natural-person-addresses">
				<xsl:with-param name="commonFutureAddress">
					<xsl:choose>
						<xsl:when test="translate(tia:GerelateerdPersoon/tia:IndGezamenlijkeToekomstigeWoonlocatie, $upper, $lower) = 'true'">
							<xsl:text>true</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>false</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
			</xsl:apply-templates>
		</xsl:if>
	</xsl:template>

	<!--
	*********************************************************
	Mode: do-hoedanigheid-person-data
	*********************************************************
	Public: no

	Identity transform: no

	Description: Person data printed in hoedangheid text block.

	Input: tia:Hoedanigheid

	Params: referencedPerson - Person referenced from Hoedangheid

	Output: text

	Calls:
	(mode) do-party-natural-person-common-part-one
	(mode) do-marital-status
	(mode) do-party-natural-person-addresses

	Called by:
	(mode) do-capacity-variant-for-natural-person
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:Hoedanigheid" mode="do-hoedanigheid-person-data">
		<xsl:param name="referencedPerson" select="self::node()[false()]" />

		<xsl:variable name="referencedPersonVariant">
			<xsl:choose>
				<xsl:when test="$referencedPerson/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_keuzeblokvariant']/tia:tekst">
					<xsl:value-of select="$referencedPerson/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_keuzeblokvariant']/tia:tekst" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$referencedPerson/../../tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_keuzeblokvariant']/tia:tekst" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:apply-templates select="$referencedPerson" mode="do-party-natural-person-common-part-one" />
		<xsl:if test="$referencedPersonVariant != '2' and $referencedPersonVariant != '4'">
			<xsl:if test="$referencedPerson/tia:tia_BurgerlijkeStaatTekst">
				<xsl:text>, </xsl:text>
			</xsl:if>
			<xsl:apply-templates select="$referencedPerson" mode="do-marital-status" />
		</xsl:if>
		<xsl:if test="$referencedPersonVariant != '3' and $referencedPersonVariant != '4'">
			<xsl:text>, </xsl:text>
			<xsl:apply-templates select="$referencedPerson" mode="do-party-natural-person-addresses" />
		</xsl:if>
		<xsl:text>;</xsl:text>
	</xsl:template>

	<!--
	*********************************************************
	Mode: do-not-voorzich-data
	*********************************************************
	Public: no

	Identity transform: no

	Description: Person data printed in hoedangheid text block when hoedangheid is not voor zich.

	Input: tia:IMKAD_Persoon

	Params: none

	Output: text

	Calls:
	(mode) do-gender-salutation

	Called by:
	(mode) do-capacity-variant-for-natural-person
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon" mode="do-not-voorzich-data">
		<xsl:choose>
			<xsl:when test="tia:tia_Gegevens/tia:GBA_Ingezetene">
				<xsl:apply-templates select="tia:tia_Gegevens/tia:GBA_Ingezetene" mode="do-gender-salutation" />
				<xsl:text> </xsl:text>
				<xsl:choose>
					<xsl:when test="tia:tia_Gegevens/tia:IMKAD_KadNatuurlijkPersoon">
						<xsl:value-of select="tia:tia_Gegevens/tia:IMKAD_KadNatuurlijkPersoon/tia:voornamen" />
						<xsl:if test="tia:tia_Gegevens/tia:IMKAD_KadNatuurlijkPersoon/tia:voorvoegselsgeslachtsnaam
								and normalize-space(tia:tia_Gegevens/tia:IMKAD_KadNatuurlijkPersoon/tia:voorvoegselsgeslachtsnaam) != ''">
							<xsl:text> </xsl:text>
							<xsl:value-of select="tia:tia_Gegevens/tia:IMKAD_KadNatuurlijkPersoon/tia:voorvoegselsgeslachtsnaam" />
						</xsl:if>
						<xsl:text> </xsl:text>
						<xsl:value-of select="tia:tia_Gegevens/tia:IMKAD_KadNatuurlijkPersoon/tia:geslachtsnaam" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="tia:tia_Gegevens/tia:GBA_Ingezetene/tia:naam/tia:voornamen" />
						<xsl:if test="tia:tia_Gegevens/tia:GBA_Ingezetene/tia:tia_VoorvoegselsNaam
								and normalize-space(tia:tia_Gegevens/tia:GBA_Ingezetene/tia:tia_VoorvoegselsNaam) != ''">
							<xsl:text> </xsl:text>
							<xsl:value-of select="tia:tia_Gegevens/tia:GBA_Ingezetene/tia:tia_VoorvoegselsNaam" />
						</xsl:if>
						<xsl:text> </xsl:text>
						<xsl:value-of select="tia:tia_Gegevens/tia:GBA_Ingezetene/tia:tia_NaamZonderVoorvoegsels" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="tia:tia_Gegevens/tia:IMKAD_NietIngezetene">
				<xsl:apply-templates select="tia:tia_Gegevens/tia:IMKAD_NietIngezetene" mode="do-gender-salutation" />
				<xsl:text> </xsl:text>
				<xsl:value-of select="tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:voornamen" />
				<xsl:if test="tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:voorvoegsels and normalize-space(tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:voorvoegsels) != ''">
					<xsl:text> </xsl:text>
					<xsl:value-of select="tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:voorvoegsels" />
				</xsl:if>
				<xsl:text> </xsl:text>
				<xsl:value-of select="tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:geslachtsnaam" />
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<!--
	*********************************************************
	Mode: do-capacity-variant-for-natural-person-variant
	*********************************************************
	Public: no

	Identity transform: no

	Description: Hoedangheid variants text block.

	Input: tia:IMKAD_Persoon

	Params: relatedPersons - variable where related persons are stored
			authorizedRepresentative - variable where related authorized representative is stored

	Output: text

	Calls: none

	Called by:
	(mode) do-capacity-variant-for-natural-person
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:Hoedanigheid" mode="do-capacity-variant-for-natural-person-variant">
		<xsl:param name="relatedPersons" select="self::node()[false()]" />
		<xsl:param name="authorizedRepresentative" select="self::node()[false()]" />

		<xsl:variable name="capacityVariant" select="tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvariant']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvariant']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space(current()/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvariant']/tia:tekst), $upper, $lower)]), $upper, $lower)]" />
		<xsl:variable name="numberOfPersons" select="count($relatedPersons)" />
		<xsl:variable name="genderOfFirstLegalPerson" select="$relatedPersons[1]/tia:tia_Gegevens/tia:NHR_Rechtspersoon/tia:rechtsvormSub" />
		<xsl:variable name="genderFromKodesFile" select="$legalPersonNames[translate(Value[@ColumnRef = 'C']/SimpleValue, $upper, $lower) = translate($genderOfFirstLegalPerson, $upper, $lower)]/Value[@ColumnRef = 'E']/SimpleValue" />
		<xsl:variable name="gender">
			<xsl:choose>
				<xsl:when test="$numberOfPersons = 1">
					<xsl:choose>
						<xsl:when test="translate($relatedPersons[1]/tia:tia_Gegevens/tia:GBA_Ingezetene/tia:geslacht/tia:geslachtsaanduiding, $upper, $lower) = 'vrouw'
								or translate($relatedPersons[1]/tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:geslacht, $upper, $lower) = 'vrouw'
								or translate($genderFromKodesFile, $upper, $lower) = 'v'">
							<xsl:text>haar</xsl:text>
						</xsl:when>
						<xsl:when test="translate($relatedPersons[1]/tia:tia_Gegevens/tia:GBA_Ingezetene/tia:geslacht/tia:geslachtsaanduiding, $upper, $lower) = 'man'
								or translate($relatedPersons[1]/tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:geslacht, $upper, $lower) = 'man'
								or translate($genderFromKodesFile, $upper, $lower) = 'm'">
							<xsl:text>zijn</xsl:text>
						</xsl:when>
						<xsl:when test="translate($relatedPersons[1]/tia:tia_Gegevens/tia:GBA_Ingezetene/tia:geslacht/tia:geslachtsaanduiding, $upper, $lower) = 'onbekend'
								or translate($relatedPersons[1]/tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:geslacht, $upper, $lower) = 'onbekend'">
							<xsl:text>diens</xsl:text>
						</xsl:when>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:choose>
			<xsl:when test="$capacityVariant = '1'">
				<xsl:variable name="capacityTextVariant1" select="$keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidtekstvariant1']/tia:tekst[
					position() = translate(normalize-space(current()/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidtekstvariant1']/tia:tekst), $upper, $lower)]" />
				<xsl:choose>
					<xsl:when test="$numberOfPersons = 1">
						<xsl:choose>
							<xsl:when test="contains(translate($capacityTextVariant1, $upper, $lower), 'bevoegde bestuurders')">
								<xsl:value-of select="concat(substring-before($capacityTextVariant1, 'bevoegde bestuurders'), 'bevoegd bestuurder', substring-after($capacityTextVariant1, 'bevoegde bestuurders'))" />
							</xsl:when>
							<xsl:when test="contains(translate($capacityTextVariant1, $upper, $lower), 'bevoegde directeuren')">
								<xsl:value-of select="concat(substring-before($capacityTextVariant1, 'bevoegde directeuren'), 'bevoegd directeur', substring-after($capacityTextVariant1, 'bevoegde directeuren'))" />
							</xsl:when>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$capacityTextVariant1" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$capacityVariant = '2'">
				<xsl:variable name="capacityTextVariant2" select="$keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidtekstvariant2']/tia:tekst[
					position() = translate(normalize-space(current()/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidtekstvariant2']/tia:tekst), $upper, $lower)]" />
				<xsl:choose>
					<xsl:when test="$numberOfPersons = 1">
						<xsl:variable name="capacityTextVariant2Plurality">
							<xsl:choose>
								<xsl:when test="contains(translate($capacityTextVariant2, $upper, $lower), 'bevoegde bestuurders')">
									<xsl:value-of select="concat(substring-before($capacityTextVariant2, 'bevoegde bestuurders'), 'bevoegd bestuurder', substring-after($capacityTextVariant2, 'bevoegde bestuurders'))" />
								</xsl:when>
								<xsl:when test="contains(translate($capacityTextVariant2, $upper, $lower), 'bevoegde directeuren')">
									<xsl:value-of select="concat(substring-before($capacityTextVariant2, 'bevoegde directeuren'), 'bevoegd directeur', substring-after($capacityTextVariant2, 'bevoegde directeuren'))" />
								</xsl:when>
								<xsl:when test="contains(translate($capacityTextVariant2, $upper, $lower), 'bestuurders')">
									<xsl:value-of select="concat(substring-before($capacityTextVariant2, 'bestuurders'), 'bestuurder', substring-after($capacityTextVariant2, 'bestuurders'))" />
								</xsl:when>
								<xsl:when test="contains(translate($capacityTextVariant2, $upper, $lower), 'directeuren')">
									<xsl:value-of select="concat(substring-before($capacityTextVariant2, 'directeuren'), 'directeur', substring-after($capacityTextVariant2, 'directeuren'))" />
								</xsl:when>
							</xsl:choose>
						</xsl:variable>
						<xsl:value-of select="concat(substring-before($capacityTextVariant2Plurality, 'zijn/haar/diens/hun'), $gender, substring-after($capacityTextVariant2Plurality, 'zijn/haar/diens/hun'))" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="concat(substring-before($capacityTextVariant2, 'zijn/haar/diens/hun'), 'hun', substring-after($capacityTextVariant2, 'zijn/haar/diens/hun'))" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$capacityVariant = '3'">
				<xsl:variable name="capacityTextVariant3" select="$keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidtekstvariant3']/tia:tekst[
					position() = translate(normalize-space(current()/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidtekstvariant3']/tia:tekst), $upper, $lower)]" />
				<xsl:value-of select="$capacityTextVariant3" />
			</xsl:when>
			<xsl:when test="$capacityVariant = '4'">
				<xsl:text>in </xsl:text>
				<xsl:choose>
					<xsl:when test="$numberOfPersons = 1">
						<xsl:value-of select="$gender" />
						<xsl:text> hoedanigheid van burgemeester</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>hun hoedanigheid van burgemeesters</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:text> van</xsl:text>
			</xsl:when>
			<xsl:when test="$capacityVariant = '5'">
				<xsl:variable name="capacityTextVariant5" select="$keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidtekstvariant5']/tia:tekst[
					position() = translate(normalize-space(current()/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidtekstvariant5']/tia:tekst), $upper, $lower)]" />
				<xsl:choose>
					<xsl:when test="($authorizedRepresentative and $numberOfPersons = 0) or (not($authorizedRepresentative) and $numberOfPersons = 1)">
						<xsl:variable name="capacityTextVariant5Plurality">
							<xsl:if test="contains(translate($capacityTextVariant5, $upper, $lower), 'mondeling gevolmachtigden') or contains(translate($capacityTextVariant5, $upper, $lower), 'schriftelijk gevolmachtigden')">
								<xsl:value-of select="concat(substring-before($capacityTextVariant5, 'gevolmachtigden'), 'gevolmachtigde', substring-after($capacityTextVariant5, 'gevolmachtigden'))" />
							</xsl:if>
						</xsl:variable>
						<xsl:value-of select="$capacityTextVariant5Plurality" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$capacityTextVariant5" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$capacityVariant = '6'">
				<xsl:variable name="capacityTextVariant6" select="$keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidtekstvariant6']/tia:tekst[
					position() = translate(normalize-space(current()/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidtekstvariant6']/tia:tekst), $upper, $lower)]" />
				<xsl:variable name="genderVariant6">
					<xsl:choose>
						<xsl:when test="$numberOfPersons = 1">
							<xsl:value-of select="$gender" />
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>hun</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
<!--					TODO: $authorizedRepresentative wordt waarschijnlijk niet gebruikt -->
<!--					<xsl:choose>-->
<!--						<xsl:when test="$authorizedRepresentative">-->
<!--							<xsl:choose>-->
<!--								<xsl:when test="$numberOfPersons = 0">-->
<!--									<xsl:choose>-->
<!--										<xsl:when test="translate($authorizedRepresentative/tia:gegevens/tia:persoonGegevens/tia:geslacht/tia:geslachtsaanduiding, $upper, $lower) = 'vrouw'">-->
<!--											<xsl:text>haar</xsl:text>-->
<!--										</xsl:when>-->
<!--										<xsl:when test="translate($authorizedRepresentative/tia:gegevens/tia:persoonGegevens/tia:geslacht/tia:geslachtsaanduiding, $upper, $lower) = 'man'">-->
<!--											<xsl:text>zijn</xsl:text>-->
<!--										</xsl:when>-->
<!--										<xsl:when test="translate($authorizedRepresentative/tia:gegevens/tia:persoonGegevens/tia:geslacht/tia:geslachtsaanduiding, $upper, $lower) = 'onbekend'">-->
<!--											<xsl:text>diens</xsl:text>-->
<!--										</xsl:when>-->
<!--									</xsl:choose>-->
<!--								</xsl:when>-->
<!--								<xsl:otherwise>-->
<!--									<xsl:text>hun</xsl:text>-->
<!--								</xsl:otherwise>-->
<!--							</xsl:choose>-->
<!--						</xsl:when>-->
<!--						<xsl:otherwise>-->
<!--							<xsl:choose>-->
<!--								<xsl:when test="$numberOfPersons = 1">-->
<!--									<xsl:value-of select="$gender" />-->
<!--								</xsl:when>-->
<!--								<xsl:otherwise>-->
<!--									<xsl:text>hun</xsl:text>-->
<!--								</xsl:otherwise>-->
<!--							</xsl:choose>-->
<!--						</xsl:otherwise>-->
<!--					</xsl:choose>-->
				</xsl:variable>
				<xsl:variable name="datumVariant6">
					<xsl:choose>
						<xsl:when test="$authorizedRepresentative">
							<xsl:value-of select="$authorizedRepresentative/tia:gegevensOndertekening[tia:soortOndertekening = 'beschikking kantonrechter']/tia:datum" />
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$relatedPersons[1]/tia:tia_GegevensOndertekening[tia:soortOndertekening = 'beschikking kantonrechter']/tia:datum" />
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<xsl:variable name="placeVariant6">
					<xsl:choose>
						<xsl:when test="$authorizedRepresentative">
							<xsl:value-of select="$authorizedRepresentative/tia:gegevensOndertekening[tia:soortOndertekening = 'beschikking kantonrechter']/tia:naamGemeente" />
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$relatedPersons[1]/tia:tia_GegevensOndertekening[tia:soortOndertekening = 'beschikking kantonrechter']/tia:naamGemeente" />
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<xsl:variable name="capacityTextVariant6WithGender">
					<xsl:value-of select="concat(substring-before($capacityTextVariant6, 'zijn/haar/diens/hun'), $genderVariant6, substring-after($capacityTextVariant6, 'zijn/haar/diens/hun'))" />
				</xsl:variable>
				<xsl:variable name="capacityTextVariant6WithGenderPlurality">
					<xsl:choose>
						<xsl:when test="($authorizedRepresentative and $numberOfPersons = 0) or (not($authorizedRepresentative) and $numberOfPersons = 1)">
							<xsl:value-of select="concat(substring-before($capacityTextVariant6WithGender, 'curatoren'), 'curator', substring-after($capacityTextVariant6WithGender, 'curatoren'))" />
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$capacityTextVariant6WithGender" />
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<xsl:variable name="Datum_DATE_VARIANT_6" select="substring(string($datumVariant6), 0, 11)" />
				<xsl:variable name="Datum_STRING_VARIANT_6">
					<xsl:if test="$Datum_DATE_VARIANT_6 != ''">
						<xsl:value-of select="kef:convertDateToText($Datum_DATE_VARIANT_6)" />
					</xsl:if>
				</xsl:variable>

				<xsl:choose>
					<xsl:when test="contains(translate($capacityTextVariant6WithGenderPlurality, $upper, $lower), 'plaats') and contains(translate($capacityTextVariant6WithGenderPlurality, $upper, $lower), 'datum')">
						<xsl:variable name="middleText">
							<xsl:value-of select="substring-after(substring-before($capacityTextVariant6WithGenderPlurality, 'datum'), 'plaats')" />
						</xsl:variable>
						<xsl:value-of select="concat(substring-before($capacityTextVariant6WithGenderPlurality, 'plaats'), $placeVariant6, $middleText, $Datum_STRING_VARIANT_6, substring-after($capacityTextVariant6WithGenderPlurality, 'datum'))" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$capacityTextVariant6WithGenderPlurality" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$capacityVariant = '7'">
				<xsl:variable name="capacityTextVariant7" select="$keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidtekstvariant7']/tia:tekst[
					position() = translate(normalize-space(current()/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidtekstvariant7']/tia:tekst), $upper, $lower)]" />
				<xsl:variable name="datumVariant7">
					<xsl:choose>
						<xsl:when test="$authorizedRepresentative">
							<xsl:value-of select="$authorizedRepresentative/tia:gegevensOndertekening[tia:soortOndertekening = 'beschikking kantonrechter']/tia:datum" />
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$relatedPersons[1]/tia:tia_GegevensOndertekening[tia:soortOndertekening = 'beschikking kantonrechter']/tia:datum" />
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<xsl:variable name="placeVariant7">
					<xsl:choose>
						<xsl:when test="$authorizedRepresentative">
							<xsl:value-of select="$authorizedRepresentative/tia:gegevensOndertekening[tia:soortOndertekening = 'beschikking kantonrechter']/tia:naamGemeente" />
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$relatedPersons[1]/tia:tia_GegevensOndertekening[tia:soortOndertekening = 'beschikking kantonrechter']/tia:naamGemeente" />
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<xsl:variable name="capacityTextVariant7Plurality">
					<xsl:choose>
						<xsl:when test="($authorizedRepresentative and $numberOfPersons = 0) or (not($authorizedRepresentative) and $numberOfPersons = 1)">
							<xsl:choose>
								<xsl:when test="contains(translate($capacityTextVariant7, $upper, $lower), 'bewindvoerders')">
									<xsl:value-of select="concat(substring-before($capacityTextVariant7, 'bewindvoerders'), 'bewindvoerder', substring-after($capacityTextVariant7, 'bewindvoerders'))" />
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$capacityTextVariant7" />
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$capacityTextVariant7" />
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<xsl:variable name="Datum_DATE_VARIANT_7" select="substring(string($datumVariant7), 0, 11)" />
				<xsl:variable name="Datum_STRING_VARIANT_7">
					<xsl:if test="$Datum_DATE_VARIANT_7 != ''">
						<xsl:value-of select="kef:convertDateToText($Datum_DATE_VARIANT_7)" />
					</xsl:if>
				</xsl:variable>

				<xsl:choose>
					<xsl:when test="contains(translate($capacityTextVariant7Plurality, $upper, $lower), 'plaats') and contains(translate($capacityTextVariant7Plurality, $upper, $lower), 'datum')">
						<xsl:variable name="middleText">
							<xsl:value-of select="substring-after(substring-before($capacityTextVariant7Plurality, 'datum'), 'plaats')" />
						</xsl:variable>
						<xsl:value-of select="concat(substring-before($capacityTextVariant7Plurality, 'plaats'), $placeVariant7, $middleText, $Datum_STRING_VARIANT_7, substring-after($capacityTextVariant7Plurality, 'datum'))" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$capacityTextVariant7Plurality" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$capacityVariant = '8'">
				<xsl:variable name="capacityTextVariant8" select="$keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidtekstvariant8']/tia:tekst[
					position() = translate(normalize-space(current()/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidtekstvariant8']/tia:tekst), $upper, $lower)]" />
				<xsl:value-of select="$capacityTextVariant8" />
			</xsl:when>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>
