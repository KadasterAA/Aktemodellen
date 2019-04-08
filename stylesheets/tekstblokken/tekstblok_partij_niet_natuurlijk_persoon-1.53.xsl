<?xml version="1.0" encoding="UTF-8"?>
<!--
*********************************************************
Stylesheet: tekstblok_partij_niet_natuurlijk_persoon.xsl
Version: 1.52 : AA-2208
*********************************************************
Description:
Party legal person text block.

Public:
(mode) do-party-legal-person

Private:
(mode) do-party-legal-person-text-main-and-related-persons
(mode) do-party-legal-person-text-main-and-related-persons-warrantors-act-as-hoedanighied-for-each-other
(mode) do-party-legal-person-text-main-and-related-persons-warrantors-act-as-hoedanighied-for-each-other-next-representation
(mode) do-party-legal-person-text-main-and-related-persons-all-warrantors-represented-by-main-person
(mode) do-party-legal-person-text-main-and-related-persons-all-warrantors-and-main-person-represented-by-manager
(mode) do-party-legal-person-text-main-and-related-persons-without-warrantors
(mode) do-party-legal-person-text-main-and-related-persons-warrantors-and-main-person-represented-in-groups-by-managers
(mode) do-capacity-for-more-persons-in-hoedanigheid
(mode) do-capacity-for-other-persons-in-groups-represented-by-managers
(mode) do-party-person-number-for-legal-person
(mode) do-manager
(mode) do-correspondant-address
(mode) do-capacity-for-legal-person
(mode) do-person-details
(mode) do-capacity-variant-for-legal-person

-->
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:kef="nl.kadaster.xslt.XslExtensionFunctions" xmlns:tia="http://www.kadaster.nl/schemas/KIK/TIA_Algemeen" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xlink="http://www.w3.org/1999/xlink" exclude-result-prefixes="tia xsl kef xlink" version="1.0">
	<!--
	*********************************************************
	Mode: do-party-legal-person
	*********************************************************
	Public: yes

	Identity transform: no

	Description: Party legal person text block.

	Input: tia:IMKAD_Persoon

	Params: start - order number of person in nested party
			anchorName - name of the anchor that will be positioned in first <td> element
			personTerminator - character that is printed at the end of each person's block
			skipPartyNumberColumn - indicator if party number column should not be printed ('false' is default)
			forcePrintingPartyNumber - force printing party number ('false' is default)
			partyNumberingFormat - party numbering format ('1' is default)
			personNumberingFormat - first level person numbering format ('a' is default)

	Output: text

	Calls:
	(mode) do-address
	(mode) do-capacity-for-legal-person
	(mode) do-capacity-variant-for-legal-person
	(mode) do-correspondant-address
	(mode) do-legal-person
	(mode) do-manager
	(mode) do-marital-status-partners
	(mode) do-party-person-number-for-legal-person
	(mode) do-party-legal-person-text-main-and-related-persons

	Called by:
	(mode) do-party-legal-person
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon" mode="do-party-legal-person">
		<xsl:param name="start" select="number('0')"/>
		<xsl:param name="anchorName" select="''"/>
		<xsl:param name="personTerminator" select="';'"/>
		<xsl:param name="skipPartyNumberColumn" select="'false'"/>
		<xsl:param name="forcePrintingPartyNumber" select="'false'"/>
		<xsl:param name="partyNumberingFormat" select="'1'"/>
		<xsl:param name="personNumberingFormat" select="'a'"/>
		<xsl:variable name="currentParty" select=".."/>
		<xsl:variable name="mainPerson" select="."/>
		<xsl:variable name="firstWarrantor" select="tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'volmachtgever'][1]/tia:IMKAD_Persoon"/>
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
		<xsl:variable name="ordinalNumberOfPersonInParty" select="count(preceding-sibling::tia:IMKAD_Persoon) + 1"/>
		<xsl:variable name="onlyPersonWithBulletInParty">
			<xsl:choose>
				<xsl:when test="count(preceding-sibling::tia:IMKAD_Persoon[(tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene) and not(concat('#', @id) = $currentParty/tia:Hoedanigheid[not(concat('#', @id) = $currentParty/tia:Gevolmachtigde/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'])]/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'])])
							+ count(following-sibling::tia:IMKAD_Persoon[(tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene) and not(concat('#', @id) = $currentParty/tia:Hoedanigheid/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'])])
							+ count(preceding-sibling::tia:IMKAD_Persoon[tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene]/tia:GerelateerdPersoon/tia:IMKAD_Persoon[not(concat('#', @id) = $currentParty/tia:Hoedanigheid[not(concat('#', @id) = $currentParty/tia:Gevolmachtigde/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'])]/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'])])
							+ count(following-sibling::tia:IMKAD_Persoon[tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene]/tia:GerelateerdPersoon/tia:IMKAD_Persoon[not(concat('#', @id) = $currentParty/tia:Hoedanigheid/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'])])
							+ count($currentParty/tia:IMKAD_Persoon[tia:tia_Gegevens/tia:NHR_Rechtspersoon and not(count(tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder']) = 0 and concat('#', @id) = $currentParty/tia:Hoedanigheid/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] and count(preceding-sibling::tia:IMKAD_Persoon) > 0)])
							+ count($currentParty/tia:IMKAD_Persoon[count(tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder']) > 1]/tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder' and preceding-sibling::tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder']]) > 1">
					<xsl:text>false</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>true</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="mainPersonRepresentedInHoedanigheid" select="$currentParty/tia:Hoedanigheid[tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#', $mainPerson/@id)]"/>
		<xsl:variable name="firstWarrantorRepresentedInHoedanigheid" select="$currentParty/tia:Hoedanigheid[tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#', $firstWarrantor/@id)]"/>
		<xsl:variable name="gevolmachtigdeOnPartyLevelRepresentsPersonsInHoedanigheid">
			<xsl:choose>
				<xsl:when test="../tia:Gevolmachtigde and count(../tia:Gevolmachtigde[$currentParty/tia:Hoedanigheid[tia:wordtVertegenwoordigdRef]/@id = substring-after(tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'], '#')]) = 0">
					<xsl:text>true</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>false</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="haveWarrantors">
			<xsl:choose>
				<xsl:when test="tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'volmachtgever']">
					<xsl:text>true</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>false</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="haveManagers">
			<xsl:choose>
				<xsl:when test="tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder']">
					<xsl:text>true</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>false</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="numberOfManagers" select="count(tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder'])"/>
		<xsl:variable name="numberOfRelatedPersonsInAllManager" select="count(tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder']/tia:IMKAD_Persoon/descendant-or-self::tia:IMKAD_Persoon)"/>
		<xsl:variable name="isTherePrecedingPerson">
			<xsl:choose>
				<xsl:when test="count(preceding-sibling::tia:IMKAD_Persoon) > 0">
					<xsl:text>true</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>false</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="capacityVariantCurrentPerson" select="$mainPersonRepresentedInHoedanigheid/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvariant']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvariant']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space($mainPersonRepresentedInHoedanigheid/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvariant']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
		<xsl:variable name="capacityFirstWarrantor" select="$firstWarrantorRepresentedInHoedanigheid/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidaanduiding']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidaanduiding']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space($firstWarrantorRepresentedInHoedanigheid/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidaanduiding']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
		<xsl:variable name="capacityVariantFirstWarrantor" select="$firstWarrantorRepresentedInHoedanigheid/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvariant']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvariant']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space($firstWarrantorRepresentedInHoedanigheid/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvariant']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
		<!--
			General Hoedanigheid rules:
			1. Person is represented in Hoedanigheid by some of the preceding persons
			or
			2. Person is represented in Hoedanigheid by Gevolmachtigde(s) which acts on party level
			or
			3. Person is represented in Hoedanigheid by it's own bestuurder(s)
		-->
		<xsl:choose>
			<!-- NNP doesnt't contain bestuurder(s) and previous person(s) act(s) as Hoedanigheid for current - it should be printed without bullet -->
			<xsl:when test="$haveManagers = 'false' and $mainPersonRepresentedInHoedanigheid and $isTherePrecedingPerson = 'true'">
				<xsl:choose>
					<xsl:when test="$haveWarrantors = 'true'">
						<tr>
							<td>
								<xsl:apply-templates select="$mainPerson" mode="do-party-legal-person-text-main-and-related-persons">
									<xsl:with-param name="mainPersonRepresentedInHoedanigheid" select="$mainPersonRepresentedInHoedanigheid"/>
									<xsl:with-param name="firstWarrantorRepresentedInHoedanigheid" select="$firstWarrantorRepresentedInHoedanigheid"/>
									<xsl:with-param name="capacityVariantCurrentPerson" select="$capacityVariantCurrentPerson"/>
									<xsl:with-param name="capacityFirstWarrantor" select="$capacityFirstWarrantor"/>
									<xsl:with-param name="capacityVariantFirstWarrantor" select="$capacityVariantFirstWarrantor"/>
									<xsl:with-param name="firstWarrantor" select="$firstWarrantor"/>
									<xsl:with-param name="haveWarrantors" select="$haveWarrantors"/>
									<xsl:with-param name="relatedPersons" select="preceding-sibling::tia:IMKAD_Persoon/descendant-or-self::tia:IMKAD_Persoon[concat('#', $mainPersonRepresentedInHoedanigheid/@id) = tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href']]"/>
									<xsl:with-param name="personTerminator" select="$personTerminator"/>
									<xsl:with-param name="onlyPersonWithBulletInParty" select="$onlyPersonWithBulletInParty"/>
									<xsl:with-param name="representedByPreviousPerson" select="'true'"/>
									<xsl:with-param name="skipPartyNumberColumn" select="$skipPartyNumberColumn"/>
									<xsl:with-param name="personNumberingFormat" select="$personNumberingFormat"/>
								</xsl:apply-templates>
							</td>
						</tr>
					</xsl:when>
					<xsl:otherwise>
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
											<td>
												<xsl:apply-templates select="$mainPerson" mode="do-party-legal-person-text-main-and-related-persons">
													<xsl:with-param name="mainPersonRepresentedInHoedanigheid" select="$mainPersonRepresentedInHoedanigheid"/>
													<xsl:with-param name="firstWarrantorRepresentedInHoedanigheid" select="$firstWarrantorRepresentedInHoedanigheid"/>
													<xsl:with-param name="capacityVariantCurrentPerson" select="$capacityVariantCurrentPerson"/>
													<xsl:with-param name="capacityFirstWarrantor" select="$capacityFirstWarrantor"/>
													<xsl:with-param name="capacityVariantFirstWarrantor" select="$capacityVariantFirstWarrantor"/>
													<xsl:with-param name="firstWarrantor" select="$firstWarrantor"/>
													<xsl:with-param name="haveWarrantors" select="$haveWarrantors"/>
													<xsl:with-param name="relatedPersons" select="preceding-sibling::tia:IMKAD_Persoon/descendant-or-self::tia:IMKAD_Persoon[concat('#', $mainPersonRepresentedInHoedanigheid/@id) = tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href']]"/>
													<xsl:with-param name="personTerminator" select="$personTerminator"/>
													<xsl:with-param name="onlyPersonWithBulletInParty" select="$onlyPersonWithBulletInParty"/>
													<xsl:with-param name="representedByPreviousPerson" select="'true'"/>
													<xsl:with-param name="skipPartyNumberColumn" select="$skipPartyNumberColumn"/>
													<xsl:with-param name="personNumberingFormat" select="$personNumberingFormat"/>
												</xsl:apply-templates>
											</td>
										</tr>
									</tbody>
								</table>
							</td>
						</tr>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<!-- NNP doesnt't contain bestuurder(s) and Gevolmachtigde acts as Hoedanigheid for current person - it should be printed with bullet -->
			<xsl:when test="$haveManagers = 'false' and not($mainPersonRepresentedInHoedanigheid) and $gevolmachtigdeOnPartyLevelRepresentsPersonsInHoedanigheid = 'true'">
				<!-- Main NNP person -->
				<tr>
					<td>
						<table>
							<tbody>
								<tr>
									<!-- First TD element (optional) -->
									<xsl:if test="not($skipPartyNumberColumn = 'true')">
										<xsl:choose>
											<xsl:when test="$gevolmachtigdeOnPartyLevelRepresentsPersonsInHoedanigheid = 'true' and not($forcePrintingPartyNumber = 'true')">
												<!-- Has Gevoltmachtigde on party level -->
												<td class="number" valign="top">
													<xsl:text>&#xFEFF;</xsl:text>
												</td>
											</xsl:when>
											<xsl:otherwise>
												<!-- Doesn't have Gevoltmachtigde on party level -->
												<xsl:choose>
													<xsl:when test="$isTherePrecedingPerson = 'false'">
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
															<xsl:number value="count(../preceding-sibling::tia:Partij) + 1" format="{$partyNumberingFormat}"/>
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
									<!-- Second TD element (optional) -->
									<xsl:if test="$onlyPersonInParty = 'false'">
										<td class="number" valign="top">
											<xsl:apply-templates mode="do-party-person-number-for-legal-person" select="$mainPerson">
												<xsl:with-param name="numberingFormat" select="$personNumberingFormat"/>
												<xsl:with-param name="currentParty" select="$currentParty"/>
												<xsl:with-param name="ordinalNumberOfPersonInParty" select="$ordinalNumberOfPersonInParty"/>
											</xsl:apply-templates>
										</td>
									</xsl:if>
									<!-- Third TD element (optional) -->
									<xsl:if test="$haveWarrantors = 'true'">
										<td class="number" valign="top">
											<xsl:choose>
												<xsl:when test="$onlyPersonInParty = 'true'">
													<xsl:number value="1" format="{$personNumberingFormat}"/>
												</xsl:when>
												<xsl:otherwise>
													<xsl:number value="1" format="{translate($personNumberingFormat, '1a', 'a1')}"/>
												</xsl:otherwise>
											</xsl:choose>
											<xsl:text>.</xsl:text>
										</td>
									</xsl:if>
									<!-- Fourth TD element (text) -->
									<td>
										<xsl:apply-templates select="." mode="do-legal-person"/>
										<xsl:if test="normalize-space(tia:tia_AanduidingPersoon) != ''">
											<xsl:text>, hierna te noemen: </xsl:text>
											<xsl:value-of select="tia:tia_AanduidingPersoon"/>
										</xsl:if>
										<xsl:choose>
											<xsl:when test="$haveWarrantors = 'true'">
												<xsl:text>; en</xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:if test="tia:IMKAD_PostlocatiePersoon">
													<xsl:text> (correspondentieadres voor alle aangelegenheden betreffende de hierna te vermelden rechtshandelingen: </xsl:text>
													<xsl:apply-templates select="tia:IMKAD_PostlocatiePersoon" mode="do-correspondant-address"/>
													<xsl:text>)</xsl:text>
												</xsl:if>
												<xsl:value-of select="$personTerminator"/>
											</xsl:otherwise>
										</xsl:choose>
										<!-- TODO: Check if Hoedanigheid relation is possible within PNNP represented by Gevolmachtigde -->
										<xsl:if test="$firstWarrantorRepresentedInHoedanigheid">
											<xsl:apply-templates select="$firstWarrantorRepresentedInHoedanigheid" mode="do-capacity-for-legal-person">
												<xsl:with-param name="relatedPersons" select="."/>
												<xsl:with-param name="shouldPrintColon" select="'false'"/>
											</xsl:apply-templates>
											<xsl:if test="$capacityVariantFirstWarrantor = '1' or $capacityVariantFirstWarrantor = '2' or $capacityVariantFirstWarrantor = '3' or $capacityVariantFirstWarrantor = '4' or $capacityVariantFirstWarrantor = '5' or $capacityVariantFirstWarrantor = '6' or $capacityVariantFirstWarrantor = '7' or $capacityVariantFirstWarrantor = '8' or $capacityVariantFirstWarrantor = '10' ">
												<xsl:text> </xsl:text>
												<xsl:apply-templates select="$firstWarrantorRepresentedInHoedanigheid" mode="do-capacity-variant-for-legal-person">
													<xsl:with-param name="relatedPersons" select="."/>
												</xsl:apply-templates>
											</xsl:if>
										</xsl:if>
									</td>
								</tr>
							</tbody>
						</table>
					</td>
				</tr>
				<!-- Warrantors -->
				<xsl:for-each select="tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'volmachtgever']">
					<xsl:variable name="currentWarrantor" select="tia:IMKAD_Persoon"/>
					<xsl:variable name="nextWarrantor" select="following-sibling::tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'volmachtgever'][1]/tia:IMKAD_Persoon"/>
					<xsl:variable name="currentWarrantorRepresentedInHoedanigheid" select="$currentParty/tia:Hoedanigheid[tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#', $currentWarrantor/@id)]"/>
					<xsl:variable name="nextWarrantorRepresentedInHoedanigheid" select="$currentParty/tia:Hoedanigheid[tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'] = concat('#', $nextWarrantor/@id)]"/>
					<xsl:variable name="capacityNextWarrantor" select="$nextWarrantorRepresentedInHoedanigheid/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidaanduiding']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
						translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidaanduiding']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
						translate(normalize-space($nextWarrantorRepresentedInHoedanigheid/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidaanduiding']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
					<xsl:variable name="capacityVariantNextWarrantor" select="$nextWarrantorRepresentedInHoedanigheid/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvariant']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
										translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvariant']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
										translate(normalize-space($nextWarrantorRepresentedInHoedanigheid/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvariant']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
					<xsl:variable name="bulletShouldBePrinted">
						<xsl:choose>
							<xsl:when test="$currentWarrantorRepresentedInHoedanigheid">
								<xsl:text>false</xsl:text>
							</xsl:when>
							<xsl:otherwise>
								<xsl:text>true</xsl:text>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
					<xsl:variable name="numberOfPrecedingWarrantorsWithoutBullet" select="count(preceding-sibling::tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'volmachtgever' and tia:IMKAD_Persoon[@id = substring-after($currentParty/tia:Hoedanigheid/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'], '#')]])"/>
					<tr>
						<td>
							<table>
								<tbody>
									<tr>
										<!-- First TD element (optional) -->
										<xsl:if test="not($skipPartyNumberColumn = 'true')">
											<td class="number" valign="top">
												<xsl:text>&#xFEFF;</xsl:text>
											</td>
										</xsl:if>
										<!-- Second TD element (optional) -->
										<xsl:if test="$onlyPersonInParty = 'false'">
											<td class="number" valign="top">
												<xsl:text>&#xFEFF;</xsl:text>
											</td>
										</xsl:if>
										<!-- Third TD element (optional) -->
										<xsl:if test="$bulletShouldBePrinted = 'true'">
											<td class="number" valign="top">
												<xsl:choose>
													<xsl:when test="$onlyPersonInParty = 'false'">
														<xsl:number value="position() + 1 - $numberOfPrecedingWarrantorsWithoutBullet" format="{translate($personNumberingFormat, '1a', 'a1')}"/>
													</xsl:when>
													<xsl:otherwise>
														<xsl:number value="position() + 1 - $numberOfPrecedingWarrantorsWithoutBullet" format="{$personNumberingFormat}"/>
													</xsl:otherwise>
												</xsl:choose>
												<xsl:text>.</xsl:text>
											</td>
										</xsl:if>
										<!-- Fourth TD element (text) -->
										<td>
											<xsl:apply-templates select="tia:IMKAD_Persoon" mode="do-legal-person"/>
											<xsl:if test="normalize-space(tia:IMKAD_Persoon/tia:tia_AanduidingPersoon) != ''">
												<xsl:text>, hierna te noemen: </xsl:text>
												<xsl:value-of select="tia:IMKAD_Persoon/tia:tia_AanduidingPersoon"/>
											</xsl:if>
											<xsl:if test="tia:IMKAD_Persoon/tia:IMKAD_PostlocatiePersoon">
												<xsl:text> (correspondentieadres voor alle aangelegenheden betreffende de hierna te vermelden rechtshandelingen: </xsl:text>
												<xsl:apply-templates select="tia:IMKAD_Persoon/tia:IMKAD_PostlocatiePersoon" mode="do-correspondant-address"/>
												<xsl:text>)</xsl:text>
											</xsl:if>
											<xsl:choose>
												<xsl:when test="position() != last()">
													<xsl:text>; en</xsl:text>
												</xsl:when>
												<xsl:when test="position() = last()">
													<xsl:value-of select="$personTerminator"/>
												</xsl:when>
											</xsl:choose>
											<!-- TODO: Check if Hoedanigheid relation is possible within PNNP represented by Gevolmachtigde -->
											<xsl:if test="$nextWarrantorRepresentedInHoedanigheid">
												<xsl:apply-templates select="$nextWarrantorRepresentedInHoedanigheid" mode="do-capacity-for-legal-person">
													<xsl:with-param name="relatedPersons" select="tia:IMKAD_Persoon"/>
													<xsl:with-param name="shouldPrintColon" select="'false'"/>
												</xsl:apply-templates>
												<xsl:if test="$capacityVariantNextWarrantor = '1' or $capacityVariantNextWarrantor = '2' or $capacityVariantNextWarrantor = '3' or $capacityVariantNextWarrantor = '4' or $capacityVariantNextWarrantor = '5' or $capacityVariantNextWarrantor = '6' or $capacityVariantNextWarrantor = '7' or $capacityVariantNextWarrantor = '8' or $capacityVariantNextWarrantor = '10'">
													<xsl:text> </xsl:text>
													<xsl:apply-templates select="$nextWarrantorRepresentedInHoedanigheid" mode="do-capacity-variant-for-legal-person">
														<xsl:with-param name="relatedPersons" select="tia:IMKAD_Persoon"/>
													</xsl:apply-templates>
												</xsl:if>
											</xsl:if>
										</td>
									</tr>
								</tbody>
							</table>
						</td>
					</tr>
				</xsl:for-each>
			</xsl:when>
			<!-- NNP contains bestuurder(s), main NNP is represented in Hoedanigheid by them -->
			<xsl:when test="$haveManagers = 'true'">
				<xsl:for-each select="tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder']">
					<xsl:variable name="manager" select="."/>
					<xsl:variable name="mainPersonInManager" select="tia:IMKAD_Persoon"/>
					<xsl:variable name="mainPersonInManagerContainsRelatedPersons">
						<xsl:choose>
							<xsl:when test="$mainPersonInManager/tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'partner' or translate(tia:rol, $upper, $lower) = 'huisgenoot']">
								<xsl:text>true</xsl:text>
							</xsl:when>
							<xsl:otherwise>
								<xsl:text>false</xsl:text>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
					<xsl:variable name="hasCommonMaritalStatus">
						<xsl:choose>
							<xsl:when test="$mainPersonInManagerContainsRelatedPersons = 'true' and $mainPersonInManager/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_burgerlijkestaattekstpartners']/tia:tekst">
								<xsl:text>true</xsl:text>
							</xsl:when>
							<xsl:otherwise>
								<xsl:text>false</xsl:text>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
					<xsl:variable name="hasCommonAddress">
						<xsl:choose>
							<xsl:when test="$mainPersonInManagerContainsRelatedPersons = 'true' and $mainPersonInManager/tia:GerelateerdPersoon[1]/tia:IndGezamenlijkeWoonlocatie = 'true'">
								<xsl:text>true</xsl:text>
							</xsl:when>
							<xsl:otherwise>
								<xsl:text>false</xsl:text>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
					<xsl:variable name="isLast">
						<xsl:choose>
							<xsl:when test="position() = last()">
								<xsl:text>true</xsl:text>
							</xsl:when>
							<xsl:otherwise>
								<xsl:text>false</xsl:text>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
					<xsl:variable name="actingInPrivate" select="$mainPersonRepresentedInHoedanigheid/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvoorzich']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
						translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvoorzich']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
						translate(normalize-space($mainPersonRepresentedInHoedanigheid/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvoorzich']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
					<!-- Bestuurder main person -->
					<tr>
						<td>
							<table>
								<tbody>
									<tr>
										<!-- First TD element (optional) -->
										<xsl:if test="not($skipPartyNumberColumn = 'true')">
											<xsl:choose>
												<xsl:when test="$gevolmachtigdeOnPartyLevelRepresentsPersonsInHoedanigheid = 'true' and not($forcePrintingPartyNumber = 'true')">
													<!-- Has Gevoltmachtigde on party level -->
													<td class="number" valign="top">
														<xsl:text>&#xFEFF;</xsl:text>
													</td>
												</xsl:when>
												<xsl:otherwise>
													<!-- Doesn't have Gevoltmachtigde on party level -->
													<xsl:choose>
														<xsl:when test="$isTherePrecedingPerson = 'false' and position() = 1">
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
																<xsl:number value="count(../../preceding-sibling::tia:Partij) + 1" format="{$partyNumberingFormat}"/>
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
										<!-- Second TD element (optional) -->
										<xsl:if test="not($onlyPersonWithBulletInParty = 'true' and $mainPersonInManagerContainsRelatedPersons = 'false')">
											<td class="number" valign="top">
												<xsl:apply-templates mode="do-party-person-number-for-legal-person" select="$mainPerson">
													<xsl:with-param name="numberingFormat" select="$personNumberingFormat"/>
													<xsl:with-param name="currentParty" select="$currentParty"/>
													<xsl:with-param name="ordinalNumberOfPersonInParty" select="$ordinalNumberOfPersonInParty"/>
													<xsl:with-param name="positionWithinPerson" select="position()-1"/>
												</xsl:apply-templates>
											</td>
										</xsl:if>
										<!-- Third TD element (optional) -->
										<xsl:if test="$mainPersonInManagerContainsRelatedPersons = 'true' and $onlyPersonWithBulletInParty = 'false'">
											<td class="number" valign="top">
												<xsl:number value="1" format="{translate($personNumberingFormat, '1a', 'a1')}"/>
												<xsl:text>.</xsl:text>
											</td>
										</xsl:if>
										<!-- Fourth TD element (text) -->
										<td>
											<xsl:apply-templates select="tia:IMKAD_Persoon" mode="do-manager">
												<xsl:with-param name="hasCommonAddress" select="$hasCommonAddress"/>
												<xsl:with-param name="hasCommonMaritalStatus" select="$hasCommonMaritalStatus"/>
											</xsl:apply-templates>
											<xsl:choose>
												<xsl:when test="$numberOfManagers = 1 and $mainPersonInManagerContainsRelatedPersons = 'false'">
													<xsl:text>, </xsl:text>
												</xsl:when>
												<xsl:otherwise>
													<xsl:text>; </xsl:text>
												</xsl:otherwise>
											</xsl:choose>
											<xsl:if test="$isLast = 'true' and $mainPersonInManagerContainsRelatedPersons = 'false' and $numberOfManagers = 1">
												<xsl:choose>
													<xsl:when test="not($actingInPrivate)">
														<xsl:apply-templates select="$mainPersonRepresentedInHoedanigheid" mode="do-capacity-for-legal-person">
															<xsl:with-param name="relatedPersons" select="$mainPerson/descendant::tia:IMKAD_Persoon[not(parent::tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'volmachtgever'])]"/>
															<xsl:with-param name="shouldPrintColon" select="'false'"/>
														</xsl:apply-templates>
														<xsl:apply-templates select="$mainPerson" mode="do-party-legal-person-text-main-and-related-persons">
															<xsl:with-param name="mainPersonRepresentedInHoedanigheid" select="$mainPersonRepresentedInHoedanigheid"/>
															<xsl:with-param name="firstWarrantorRepresentedInHoedanigheid" select="$firstWarrantorRepresentedInHoedanigheid"/>
															<xsl:with-param name="capacityVariantCurrentPerson" select="$capacityVariantCurrentPerson"/>
															<xsl:with-param name="capacityFirstWarrantor" select="$capacityFirstWarrantor"/>
															<xsl:with-param name="capacityVariantFirstWarrantor" select="$capacityVariantFirstWarrantor"/>
															<xsl:with-param name="firstWarrantor" select="$firstWarrantor"/>
															<xsl:with-param name="haveWarrantors" select="$haveWarrantors"/>
															<xsl:with-param name="relatedPersons" select="$mainPerson/descendant::tia:IMKAD_Persoon[not(parent::tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'volmachtgever'])]"/>
															<xsl:with-param name="personTerminator" select="$personTerminator"/>
															<xsl:with-param name="capacityAlredyPrinted" select="'true'"/>
															<xsl:with-param name="wrappedInTableData" select="'true'"/>
															<xsl:with-param name="onlyPersonWithBulletInParty" select="$onlyPersonWithBulletInParty"/>
															<xsl:with-param name="skipPartyNumberColumn" select="$skipPartyNumberColumn"/>
															<xsl:with-param name="personNumberingFormat" select="$personNumberingFormat"/>
														</xsl:apply-templates>
													</xsl:when>
													<xsl:otherwise>
														<xsl:apply-templates select="$mainPersonRepresentedInHoedanigheid" mode="do-capacity-for-legal-person">
															<xsl:with-param name="relatedPersons" select="$mainPerson/descendant::tia:IMKAD_Persoon[not(parent::tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'volmachtgever'])]"/>
															<xsl:with-param name="shouldPrintColon" select="'true'"/>
														</xsl:apply-templates>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:if>
										</td>
									</tr>
								</tbody>
							</table>
						</td>
					</tr>
					<xsl:if test="$isLast = 'true' and $mainPersonInManagerContainsRelatedPersons = 'false' and ($numberOfManagers > 1 or ($numberOfManagers = 1 and $actingInPrivate))">
						<xsl:choose>
							<xsl:when test="$actingInPrivate">
								<xsl:if test="$numberOfManagers > 1">
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
														<td>
															<xsl:apply-templates select="$mainPersonRepresentedInHoedanigheid" mode="do-capacity-for-legal-person">
																<xsl:with-param name="relatedPersons" select="$mainPerson/descendant::tia:IMKAD_Persoon[not(parent::tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'volmachtgever'])]"/>
																<xsl:with-param name="shouldPrintColon" select="'true'"/>
															</xsl:apply-templates>
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
													<td>
														<table cellspacing="0" cellpadding="0">
															<tbody>
																<tr>
																	<xsl:if test="$numberOfManagers = 1 and $numberOfRelatedPersonsInAllManager = 1 and $onlyPersonWithBulletInParty = 'false'">
																		<td class="number" valign="top">
																			<xsl:text>&#xFEFF;</xsl:text>
																		</td>
																	</xsl:if>
																	<td class="number" valign="top">
																		<xsl:number value="1" format="I"/>
																		<xsl:text>.</xsl:text>
																	</td>
																	<td class="level0">
																		<xsl:value-of select="$actingInPrivate"/>
																	</td>
																</tr>
																<xsl:apply-templates select="$mainPerson" mode="do-party-legal-person-text-main-and-related-persons">
																	<xsl:with-param name="mainPersonRepresentedInHoedanigheid" select="$mainPersonRepresentedInHoedanigheid"/>
																	<xsl:with-param name="firstWarrantorRepresentedInHoedanigheid" select="$firstWarrantorRepresentedInHoedanigheid"/>
																	<xsl:with-param name="capacityVariantCurrentPerson" select="$capacityVariantCurrentPerson"/>
																	<xsl:with-param name="capacityFirstWarrantor" select="$capacityFirstWarrantor"/>
																	<xsl:with-param name="capacityVariantFirstWarrantor" select="$capacityVariantFirstWarrantor"/>
																	<xsl:with-param name="firstWarrantor" select="$firstWarrantor"/>
																	<xsl:with-param name="haveWarrantors" select="$haveWarrantors"/>
																	<xsl:with-param name="relatedPersons" select="$mainPerson/descendant::tia:IMKAD_Persoon[not(parent::tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'volmachtgever'])]"/>
																	<xsl:with-param name="personTerminator" select="$personTerminator"/>
																	<xsl:with-param name="capacityAlredyPrinted" select="'true'"/>
																	<xsl:with-param name="actingInPrivate" select="'true'"/>
																	<xsl:with-param name="onlyPersonWithBulletInParty" select="$onlyPersonWithBulletInParty"/>
																	<xsl:with-param name="wrappedInTable" select="'true'"/>
																	<xsl:with-param name="skipPartyNumberColumn" select="$skipPartyNumberColumn"/>
																	<xsl:with-param name="personNumberingFormat" select="$personNumberingFormat"/>
																</xsl:apply-templates>
															</tbody>
														</table>
													</td>
												</tr>
											</tbody>
										</table>
									</td>
								</tr>
							</xsl:when>
							<xsl:otherwise>
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
													<xsl:if test="$numberOfManagers = 1 and $numberOfRelatedPersonsInAllManager = 1 and $onlyPersonWithBulletInParty = 'false'">
														<td class="number" valign="top">
															<xsl:text>&#xFEFF;</xsl:text>
														</td>
													</xsl:if>
													<td>
														<xsl:apply-templates select="$mainPerson" mode="do-party-legal-person-text-main-and-related-persons">
															<xsl:with-param name="mainPersonRepresentedInHoedanigheid" select="$mainPersonRepresentedInHoedanigheid"/>
															<xsl:with-param name="firstWarrantorRepresentedInHoedanigheid" select="$firstWarrantorRepresentedInHoedanigheid"/>
															<xsl:with-param name="capacityVariantCurrentPerson" select="$capacityVariantCurrentPerson"/>
															<xsl:with-param name="capacityFirstWarrantor" select="$capacityFirstWarrantor"/>
															<xsl:with-param name="capacityVariantFirstWarrantor" select="$capacityVariantFirstWarrantor"/>
															<xsl:with-param name="firstWarrantor" select="$firstWarrantor"/>
															<xsl:with-param name="haveWarrantors" select="$haveWarrantors"/>
															<xsl:with-param name="relatedPersons" select="$mainPerson/descendant::tia:IMKAD_Persoon[not(parent::tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'volmachtgever'])]"/>
															<xsl:with-param name="personTerminator" select="$personTerminator"/>
															<xsl:with-param name="wrappedInTableData" select="'true'"/>
															<xsl:with-param name="onlyPersonWithBulletInParty" select="$onlyPersonWithBulletInParty"/>
															<xsl:with-param name="skipPartyNumberColumn" select="$skipPartyNumberColumn"/>
															<xsl:with-param name="personNumberingFormat" select="$personNumberingFormat"/>
														</xsl:apply-templates>
													</td>
												</tr>
											</tbody>
										</table>
									</td>
								</tr>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:if>
					<!-- Bestuurder related persons -->
					<xsl:for-each select="$mainPersonInManager/tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'partner' or translate(tia:rol, $upper, $lower) = 'huisgenoot']">
						<tr>
							<td>
								<table>
									<tbody>
										<tr>
											<!-- First TD element (optional) -->
											<xsl:if test="not($skipPartyNumberColumn = 'true')">
												<td class="number" valign="top">
													<xsl:text>&#xFEFF;</xsl:text>
												</td>
											</xsl:if>
											<!-- Second TD element (optional) -->
											<xsl:if test="$onlyPersonWithBulletInParty = 'false'">
												<td class="number" valign="top">
													<xsl:text>&#xFEFF;</xsl:text>
												</td>
											</xsl:if>
											<!-- Third TD element (mandatory) -->
											<xsl:variable name="numberingFormat">
												<xsl:choose>
													<xsl:when test="$onlyPersonWithBulletInParty = 'false'">
														<xsl:value-of select="translate($personNumberingFormat, '1a', 'a1')"/>
													</xsl:when>
													<xsl:otherwise>
														<xsl:value-of select="$personNumberingFormat"/>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:variable>
											<td class="number" valign="top">
												<xsl:apply-templates mode="do-party-person-number-for-legal-person" select="$mainPerson">
													<xsl:with-param name="numberingFormat" select="$numberingFormat"/>
													<xsl:with-param name="currentParty" select="$currentParty"/>
													<xsl:with-param name="ordinalNumberOfPersonInParty" select="$ordinalNumberOfPersonInParty"/>
													<xsl:with-param name="positionWithinPerson" select="position()"/>
													<xsl:with-param name="relatedBesturderPerson" select="'true'"/>
												</xsl:apply-templates>
											</td>
											<!-- Fourth TD element (text) -->
											<td>
												<xsl:apply-templates select="tia:IMKAD_Persoon" mode="do-manager">
													<xsl:with-param name="hasCommonAddress" select="$hasCommonAddress"/>
													<xsl:with-param name="hasCommonMaritalStatus" select="$hasCommonMaritalStatus"/>
												</xsl:apply-templates>
												<xsl:text>; </xsl:text>
											</td>
										</tr>
									</tbody>
								</table>
							</td>
						</tr>
						<xsl:if test="position() = last() and $isLast = 'true' and $hasCommonAddress = 'false' and $hasCommonMaritalStatus = 'false'">
							<xsl:choose>
								<xsl:when test="$actingInPrivate">
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
														<xsl:if test="$numberOfManagers = 1 and $numberOfRelatedPersonsInAllManager > 1 and $onlyPersonWithBulletInParty = 'false'">
															<td class="number" valign="top">
																<xsl:text>&#xFEFF;</xsl:text>
															</td>
														</xsl:if>
														<td>
															<xsl:apply-templates select="$mainPersonRepresentedInHoedanigheid" mode="do-capacity-for-legal-person">
																<xsl:with-param name="relatedPersons" select="$mainPerson/descendant::tia:IMKAD_Persoon[not(parent::tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'volmachtgever'])]"/>
																<xsl:with-param name="shouldPrintColon" select="'true'"/>
															</xsl:apply-templates>
														</td>
													</tr>
												</tbody>
											</table>
										</td>
									</tr>
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
														<xsl:if test="$numberOfManagers = 1 and $numberOfRelatedPersonsInAllManager > 1 and $onlyPersonWithBulletInParty = 'false'">
															<td class="number" valign="top">
																<xsl:text>&#xFEFF;</xsl:text>
															</td>
														</xsl:if>
														<td>
															<table cellspacing="0" cellpadding="0">
																<tbody>
																	<tr>
																		<xsl:if test="$numberOfManagers = 1 and $numberOfRelatedPersonsInAllManager = 1 and $onlyPersonWithBulletInParty = 'false'">
																			<td class="number" valign="top">
																				<xsl:text>&#xFEFF;</xsl:text>
																			</td>
																		</xsl:if>
																		<td class="number" valign="top">
																			<xsl:number value="1" format="I"/>
																			<xsl:text>.</xsl:text>
																		</td>
																		<td class="level1">
																			<xsl:value-of select="$actingInPrivate"/>
																		</td>
																	</tr>
																	<xsl:apply-templates select="$mainPerson" mode="do-party-legal-person-text-main-and-related-persons">
																		<xsl:with-param name="mainPersonRepresentedInHoedanigheid" select="$mainPersonRepresentedInHoedanigheid"/>
																		<xsl:with-param name="firstWarrantorRepresentedInHoedanigheid" select="$firstWarrantorRepresentedInHoedanigheid"/>
																		<xsl:with-param name="capacityVariantCurrentPerson" select="$capacityVariantCurrentPerson"/>
																		<xsl:with-param name="capacityFirstWarrantor" select="$capacityFirstWarrantor"/>
																		<xsl:with-param name="capacityVariantFirstWarrantor" select="$capacityVariantFirstWarrantor"/>
																		<xsl:with-param name="firstWarrantor" select="$firstWarrantor"/>
																		<xsl:with-param name="haveWarrantors" select="$haveWarrantors"/>
																		<xsl:with-param name="relatedPersons" select="$mainPerson/descendant::tia:IMKAD_Persoon[not(parent::tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'volmachtgever'])]"/>
																		<xsl:with-param name="personTerminator" select="$personTerminator"/>
																		<xsl:with-param name="capacityAlredyPrinted" select="'true'"/>
																		<xsl:with-param name="actingInPrivate" select="'true'"/>
																		<xsl:with-param name="wrappedInTable" select="'true'"/>
																		<xsl:with-param name="onlyPersonWithBulletInParty" select="$onlyPersonWithBulletInParty"/>
																		<xsl:with-param name="skipPartyNumberColumn" select="$skipPartyNumberColumn"/>
																		<xsl:with-param name="personNumberingFormat" select="$personNumberingFormat"/>
																	</xsl:apply-templates>
																</tbody>
															</table>
														</td>
													</tr>
												</tbody>
											</table>
										</td>
									</tr>
								</xsl:when>
								<xsl:otherwise>
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
														<xsl:if test="$numberOfManagers = 1 and $numberOfRelatedPersonsInAllManager > 1 and $onlyPersonWithBulletInParty = 'false'">
															<td class="number" valign="top">
																<xsl:text>&#xFEFF;</xsl:text>
															</td>
														</xsl:if>
														<td>
															<xsl:apply-templates select="$mainPerson" mode="do-party-legal-person-text-main-and-related-persons">
																<xsl:with-param name="mainPersonRepresentedInHoedanigheid" select="$mainPersonRepresentedInHoedanigheid"/>
																<xsl:with-param name="firstWarrantorRepresentedInHoedanigheid" select="$firstWarrantorRepresentedInHoedanigheid"/>
																<xsl:with-param name="capacityVariantCurrentPerson" select="$capacityVariantCurrentPerson"/>
																<xsl:with-param name="capacityFirstWarrantor" select="$capacityFirstWarrantor"/>
																<xsl:with-param name="capacityVariantFirstWarrantor" select="$capacityVariantFirstWarrantor"/>
																<xsl:with-param name="firstWarrantor" select="$firstWarrantor"/>
																<xsl:with-param name="haveWarrantors" select="$haveWarrantors"/>
																<xsl:with-param name="relatedPersons" select="$mainPerson/descendant::tia:IMKAD_Persoon[not(parent::tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'volmachtgever'])]"/>
																<xsl:with-param name="personTerminator" select="$personTerminator"/>
																<xsl:with-param name="wrappedInTableData" select="'true'"/>
																<xsl:with-param name="onlyPersonWithBulletInParty" select="$onlyPersonWithBulletInParty"/>
																<xsl:with-param name="skipPartyNumberColumn" select="$skipPartyNumberColumn"/>
																<xsl:with-param name="personNumberingFormat" select="$personNumberingFormat"/>
															</xsl:apply-templates>
														</td>
													</tr>
												</tbody>
											</table>
										</td>
									</tr>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:if>
					</xsl:for-each>
					<!-- Text which follows after related bestuurders -->
					<xsl:if test="$mainPersonInManagerContainsRelatedPersons = 'true' and ($hasCommonAddress = 'true' or $hasCommonMaritalStatus = 'true')">
						<xsl:choose>
							<xsl:when test="position() = last()">
								<xsl:choose>
									<xsl:when test="$actingInPrivate">
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
															<xsl:if test="$numberOfRelatedPersonsInAllManager > 1 and $onlyPersonWithBulletInParty = 'false'">
																<td class="number" valign="top">
																	<xsl:text>&#xFEFF;</xsl:text>
																</td>
															</xsl:if>
															<td>
																<xsl:if test="$hasCommonMaritalStatus = 'true'">
																	<xsl:apply-templates select="$mainPersonInManager" mode="do-marital-status-partners"/>
																</xsl:if>
																<xsl:if test="$hasCommonAddress = 'true'">
																	<xsl:if test="$mainPersonInManager/tia:IMKAD_WoonlocatiePersoon">
																		<xsl:if test="$hasCommonMaritalStatus = 'true'">
																			<xsl:text>, </xsl:text>
																		</xsl:if>
																		<xsl:if test="translate($mainPersonInManager/tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'partner' or translate(tia:rol, $upper, $lower) = 'huisgenoot'][1]/tia:IndGezamenlijkeWoonlocatie, $upper, $lower) = 'true'">
																			<xsl:text>tezamen </xsl:text>
																		</xsl:if>
																		<xsl:text>wonende te </xsl:text>
																		<xsl:apply-templates select="$mainPersonInManager/tia:IMKAD_WoonlocatiePersoon" mode="do-address"/>
																	</xsl:if>
																</xsl:if>
																<xsl:text>, </xsl:text>
																<xsl:if test="$numberOfManagers = 1">
																	<xsl:apply-templates select="$mainPersonRepresentedInHoedanigheid" mode="do-capacity-for-legal-person">
																		<xsl:with-param name="relatedPersons" select="$mainPerson/descendant::tia:IMKAD_Persoon[not(parent::tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'volmachtgever'])]"/>
																		<xsl:with-param name="shouldPrintColon" select="'true'"/>
																	</xsl:apply-templates>
																</xsl:if>
															</td>
														</tr>
													</tbody>
												</table>
											</td>
										</tr>
										<xsl:if test="$numberOfManagers != 1">
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
																<td>
																	<xsl:apply-templates select="$mainPersonRepresentedInHoedanigheid" mode="do-capacity-for-legal-person">
																		<xsl:with-param name="relatedPersons" select="$mainPerson/descendant::tia:IMKAD_Persoon[not(parent::tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'volmachtgever'])]"/>
																		<xsl:with-param name="shouldPrintColon" select="'true'"/>
																	</xsl:apply-templates>
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
															<xsl:if test="$numberOfManagers = 1 and $numberOfRelatedPersonsInAllManager > 1 and $onlyPersonWithBulletInParty = 'false'">
																<td class="number" valign="top">
																	<xsl:text>&#xFEFF;</xsl:text>
																</td>
															</xsl:if>
															<td>
																<table cellspacing="0" cellpadding="0">
																	<tbody>
																		<tr>
																			<xsl:if test="$numberOfManagers = 1 and $numberOfRelatedPersonsInAllManager = 1 and $onlyPersonWithBulletInParty = 'false'">
																				<td class="number" valign="top">
																					<xsl:text>&#xFEFF;</xsl:text>
																				</td>
																			</xsl:if>
																			<td class="number" valign="top">
																				<xsl:number value="1" format="I"/>
																				<xsl:text>.</xsl:text>
																			</td>
																			<td>
																				<xsl:attribute name="class"><xsl:choose><xsl:when test="$numberOfManagers = 1 and $numberOfRelatedPersonsInAllManager >= 1 and $onlyPersonWithBulletInParty = 'false'"><xsl:text>level1</xsl:text></xsl:when><xsl:otherwise><xsl:text>level0</xsl:text></xsl:otherwise></xsl:choose></xsl:attribute>
																				<xsl:value-of select="$actingInPrivate"/>
																			</td>
																		</tr>
																		<xsl:apply-templates select="$mainPerson" mode="do-party-legal-person-text-main-and-related-persons">
																			<xsl:with-param name="mainPersonRepresentedInHoedanigheid" select="$mainPersonRepresentedInHoedanigheid"/>
																			<xsl:with-param name="firstWarrantorRepresentedInHoedanigheid" select="$firstWarrantorRepresentedInHoedanigheid"/>
																			<xsl:with-param name="capacityVariantCurrentPerson" select="$capacityVariantCurrentPerson"/>
																			<xsl:with-param name="capacityFirstWarrantor" select="$capacityFirstWarrantor"/>
																			<xsl:with-param name="capacityVariantFirstWarrantor" select="$capacityVariantFirstWarrantor"/>
																			<xsl:with-param name="firstWarrantor" select="$firstWarrantor"/>
																			<xsl:with-param name="haveWarrantors" select="$haveWarrantors"/>
																			<xsl:with-param name="relatedPersons" select="$mainPerson/descendant::tia:IMKAD_Persoon[not(parent::tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'volmachtgever'])]"/>
																			<xsl:with-param name="personTerminator" select="$personTerminator"/>
																			<xsl:with-param name="actingInPrivate" select="'true'"/>
																			<xsl:with-param name="capacityAlredyPrinted" select="'true'"/>
																			<xsl:with-param name="wrappedInTable" select="'true'"/>
																			<xsl:with-param name="onlyPersonWithBulletInParty" select="$onlyPersonWithBulletInParty"/>
																			<xsl:with-param name="skipPartyNumberColumn" select="$skipPartyNumberColumn"/>
																			<xsl:with-param name="personNumberingFormat" select="$personNumberingFormat"/>
																		</xsl:apply-templates>
																	</tbody>
																</table>
															</td>
														</tr>
													</tbody>
												</table>
											</td>
										</tr>
									</xsl:when>
									<xsl:otherwise>
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
															<xsl:if test="$numberOfRelatedPersonsInAllManager > 1 and $onlyPersonWithBulletInParty = 'false'">
																<td class="number" valign="top">
																	<xsl:text>&#xFEFF;</xsl:text>
																</td>
															</xsl:if>
															<td>
																<xsl:if test="$hasCommonMaritalStatus = 'true'">
																	<xsl:apply-templates select="$mainPersonInManager" mode="do-marital-status-partners"/>
																</xsl:if>
																<xsl:if test="$hasCommonAddress = 'true'">
																	<xsl:if test="$mainPersonInManager/tia:IMKAD_WoonlocatiePersoon">
																		<xsl:if test="$hasCommonMaritalStatus = 'true'">
																			<xsl:text>, </xsl:text>
																		</xsl:if>
																		<xsl:if test="translate($mainPersonInManager/tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'partner' or translate(tia:rol, $upper, $lower) = 'huisgenoot'][1]/tia:IndGezamenlijkeWoonlocatie, $upper, $lower) = 'true'">
																			<xsl:text>tezamen </xsl:text>
																		</xsl:if>
																		<xsl:text>wonende te </xsl:text>
																		<xsl:apply-templates select="$mainPersonInManager/tia:IMKAD_WoonlocatiePersoon" mode="do-address"/>
																	</xsl:if>
																</xsl:if>
																<xsl:text>, </xsl:text>
																<xsl:if test="$numberOfManagers = 1">
																	<xsl:apply-templates select="$mainPerson" mode="do-party-legal-person-text-main-and-related-persons">
																		<xsl:with-param name="mainPersonRepresentedInHoedanigheid" select="$mainPersonRepresentedInHoedanigheid"/>
																		<xsl:with-param name="firstWarrantorRepresentedInHoedanigheid" select="$firstWarrantorRepresentedInHoedanigheid"/>
																		<xsl:with-param name="capacityVariantCurrentPerson" select="$capacityVariantCurrentPerson"/>
																		<xsl:with-param name="capacityFirstWarrantor" select="$capacityFirstWarrantor"/>
																		<xsl:with-param name="capacityVariantFirstWarrantor" select="$capacityVariantFirstWarrantor"/>
																		<xsl:with-param name="firstWarrantor" select="$firstWarrantor"/>
																		<xsl:with-param name="haveWarrantors" select="$haveWarrantors"/>
																		<xsl:with-param name="relatedPersons" select="$mainPerson/descendant::tia:IMKAD_Persoon[not(parent::tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'volmachtgever'])]"/>
																		<xsl:with-param name="personTerminator" select="$personTerminator"/>
																		<xsl:with-param name="wrappedInTableData" select="'true'"/>
																		<xsl:with-param name="onlyPersonWithBulletInParty" select="$onlyPersonWithBulletInParty"/>
																		<xsl:with-param name="skipPartyNumberColumn" select="$skipPartyNumberColumn"/>
																		<xsl:with-param name="personNumberingFormat" select="$personNumberingFormat"/>
																	</xsl:apply-templates>
																</xsl:if>
															</td>
														</tr>
													</tbody>
												</table>
											</td>
										</tr>
										<xsl:if test="$numberOfManagers != 1">
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
																<td>
																	<xsl:apply-templates select="$mainPerson" mode="do-party-legal-person-text-main-and-related-persons">
																		<xsl:with-param name="mainPersonRepresentedInHoedanigheid" select="$mainPersonRepresentedInHoedanigheid"/>
																		<xsl:with-param name="firstWarrantorRepresentedInHoedanigheid" select="$firstWarrantorRepresentedInHoedanigheid"/>
																		<xsl:with-param name="capacityVariantCurrentPerson" select="$capacityVariantCurrentPerson"/>
																		<xsl:with-param name="capacityFirstWarrantor" select="$capacityFirstWarrantor"/>
																		<xsl:with-param name="capacityVariantFirstWarrantor" select="$capacityVariantFirstWarrantor"/>
																		<xsl:with-param name="firstWarrantor" select="$firstWarrantor"/>
																		<xsl:with-param name="haveWarrantors" select="$haveWarrantors"/>
																		<xsl:with-param name="relatedPersons" select="$mainPerson/descendant::tia:IMKAD_Persoon[not(parent::tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'volmachtgever'])]"/>
																		<xsl:with-param name="personTerminator" select="$personTerminator"/>
																		<xsl:with-param name="wrappedInTableData" select="'true'"/>
																		<xsl:with-param name="onlyPersonWithBulletInParty" select="$onlyPersonWithBulletInParty"/>
																		<xsl:with-param name="skipPartyNumberColumn" select="$skipPartyNumberColumn"/>
																		<xsl:with-param name="personNumberingFormat" select="$personNumberingFormat"/>
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
							</xsl:when>
							<xsl:otherwise>
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
													<xsl:if test="$onlyPersonWithBulletInParty = 'false'">
														<td class="number" valign="top">
															<xsl:text>&#xFEFF;</xsl:text>
														</td>
													</xsl:if>
													<td>
														<xsl:if test="$hasCommonMaritalStatus = 'true'">
															<xsl:apply-templates select="$mainPersonInManager" mode="do-marital-status-partners"/>
														</xsl:if>
														<xsl:if test="$hasCommonAddress = 'true'">
															<xsl:if test="$mainPersonInManager/tia:IMKAD_WoonlocatiePersoon">
																<xsl:if test="$hasCommonMaritalStatus = 'true'">
																	<xsl:text>, </xsl:text>
																</xsl:if>
																<xsl:if test="translate($mainPersonInManager/tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'partner' or translate(tia:rol, $upper, $lower) = 'huisgenoot'][1]/tia:IndGezamenlijkeWoonlocatie, $upper, $lower) = 'true'">
																	<xsl:text>tezamen </xsl:text>
																</xsl:if>
																<xsl:text>wonende te </xsl:text>
																<xsl:apply-templates select="$mainPersonInManager/tia:IMKAD_WoonlocatiePersoon" mode="do-address"/>
															</xsl:if>
														</xsl:if>
														<xsl:text>; </xsl:text>
													</td>
												</tr>
											</tbody>
										</table>
									</td>
								</tr>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:if>
				</xsl:for-each>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-party-legal-person-text-main-and-related-persons
	*********************************************************
	Public: no

	Identity transform: no

	Description: Block which contains party legal person text for main NNP and related NNP's (volmachtgevers/warrantors).

	Input: tia:IMKAD_Persoon

	Params: mainPersonRepresentedInHoedanigheid - Hoedanigheid which contains reference to main person
			firstWarrantorRepresentedInHoedanigheid - Hoedanigheid which contains reference to first warrantor
			capacityVariantCurrentPerson - variant of Hoedanigheid in main NNP
			capacityFirstWarrantor - indicator if first related NNP (warrantor) contains Hoedanigheid data
			capacityVariantFirstWarrantor - variant of Hoedanigheid in first related NNP (warrantor)
			firstWarrantor - variable which represents first related NNP (warrantor)
			haveWarrantors - indicator if main NNP contains related one(s)
			relatedPersons - persons acting in hoedanigheid for currently processed one
			personTerminator - character that is printed at the end of each person's block
			capacityAlredyPrinted - indicator if capacity text is already printed
			onlyPersonWithBulletInParty - indicator if this is only bulleted person in party
			actingInPrivate - indicator if main person is represented in private (in prive) by bestuurder(s)
			wrappedInTable - indicator if content is wrapped in table, and root (current) element is <tbody>
			wrappedInTableData - indicator if content is wrapped in table data cell, and root (current) element is <td>
			representedByPreviousPerson - indicator if PNNP is represented by preceding PNNP persons
			skipPartyNumberColumn - indicator if party number column should not be printed ('false' is default)
			personNumberingFormat - first level person numbering format ('a' is default)

	Output: text

	Calls:
	(mode) do-capacity-for-legal-person
	(mode) do-capacity-variant-for-legal-person
	(mode) do-correspondant-address
	(mode) do-legal-person
	(mode) do-party-legal-person-text-main-and-related-persons-all-warrantors-and-main-person-represented-by-manager
	(mode) do-party-legal-person-text-main-and-related-persons-all-warrantors-represented-by-main-person
	(mode) do-party-legal-person-text-main-and-related-persons-warrantors-act-as-hoedanighied-for-each-other
	(mode) do-party-legal-person-text-main-and-related-persons-warrantors-and-main-person-represented-in-groups-by-managers
	(mode) do-party-legal-person-text-main-and-related-persons-without-warrantors
	(mode) do-party-person-number-for-legal-person

	Called by:
	(mode) do-party-legal-person
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon" mode="do-party-legal-person-text-main-and-related-persons">
		<xsl:param name="mainPersonRepresentedInHoedanigheid" select="self::node()[false()]"/>
		<xsl:param name="firstWarrantorRepresentedInHoedanigheid" select="self::node()[false()]"/>
		<xsl:param name="capacityVariantCurrentPerson" select="number('0')"/>
		<xsl:param name="capacityFirstWarrantor" select="self::node()[false()]"/>
		<xsl:param name="capacityVariantFirstWarrantor" select="number('0')"/>
		<xsl:param name="firstWarrantor" select="self::node()[false()]"/>
		<xsl:param name="haveWarrantors" select="'false'"/>
		<xsl:param name="relatedPersons" select="self::node()[false()]"/>
		<xsl:param name="personTerminator" select="';'"/>
		<xsl:param name="capacityAlredyPrinted" select="'false'"/>
		<xsl:param name="onlyPersonWithBulletInParty" select="'false'"/>
		<xsl:param name="actingInPrivate" select="'false'"/>
		<xsl:param name="wrappedInTable" select="'false'"/>
		<xsl:param name="wrappedInTableData" select="'false'"/>
		<xsl:param name="representedByPreviousPerson" select="'false'"/>
		<xsl:param name="skipPartyNumberColumn" select="'false'"/>
		<xsl:param name="personNumberingFormat" select="'a'"/>
		<xsl:variable name="mainPerson" select="."/>
		<xsl:variable name="firstManager" select="tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder'][1]"/>
		<xsl:variable name="currentParty" select=".."/>
		<xsl:variable name="numberOfWarrantors" select="count(tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'volmachtgever'])"/>
		<xsl:variable name="numberOfManagers" select="count(tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder'])"/>
		<xsl:variable name="allWarrantorsAndMainPersonRepresentedByManager">
			<xsl:choose>
				<xsl:when test="count($currentParty/tia:Hoedanigheid[concat('#', @id) = $firstManager/tia:IMKAD_Persoon/tia:vertegenwoordigtRef[1]/@*[translate(local-name(), $upper, $lower) = 'href']]/tia:wordtVertegenwoordigdRef) = ($numberOfWarrantors + 1)">
					<xsl:text>true</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>false</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="allWarrantorsRepresentedByMainPerson">
			<xsl:choose>
				<xsl:when test="$mainPersonRepresentedInHoedanigheid and count($mainPersonRepresentedInHoedanigheid/tia:wordtVertegenwoordigdRef) = 1
						and concat('#', $firstWarrantorRepresentedInHoedanigheid/@id) = $mainPerson/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] and $firstWarrantorRepresentedInHoedanigheid and count($firstWarrantorRepresentedInHoedanigheid/tia:wordtVertegenwoordigdRef) = $numberOfWarrantors">
					<xsl:text>true</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>false</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="warrantorsActAsHoedanighiedForEachOther">
			<xsl:choose>
				<xsl:when test="count(tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'volmachtgever' and concat('#', tia:IMKAD_Persoon/@id) = $currentParty/tia:Hoedanigheid[concat('#', @id) = $mainPerson/tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'volmachtgever']/tia:IMKAD_Persoon/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href']]/tia:wordtVertegenwoordigdRef[count(preceding-sibling::tia:wordtVertegenwoordigdRef) = 0]/@*[translate(local-name(), $upper, $lower) = 'href']]) > 0">
					<xsl:text>true</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>false</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="warrantorsAndMainPersonRepresentedInGroupsByManagers">
			<xsl:choose>
				<xsl:when test="count($firstManager/tia:IMKAD_Persoon/tia:vertegenwoordigtRef[substring-after(@*[translate(local-name(), $upper, $lower) = 'href'], '#') = $currentParty/tia:Hoedanigheid[substring-after(tia:wordtVertegenwoordigdRef[1]/@*[translate(local-name(), $upper, $lower) = 'href'], '#') = $mainPerson/descendant-or-self::tia:IMKAD_Persoon[not(parent::tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder'])]/@id]/@id]) > 1 or
								(count($currentParty/tia:Hoedanigheid[concat('#', @id) = $firstManager/tia:IMKAD_Persoon[count(tia:vertegenwoordigtRef) = 1]/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href']]/tia:wordtVertegenwoordigdRef) > 1 and
								count($currentParty/tia:Hoedanigheid[concat('#', @id) = $firstManager/tia:IMKAD_Persoon[count(tia:vertegenwoordigtRef) = 1]/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href']]/tia:wordtVertegenwoordigdRef) &lt; ($numberOfWarrantors + 1) and
								count($mainPerson/descendant-or-self::tia:IMKAD_Persoon[tia:vertegenwoordigtRef[substring-after(@*[translate(local-name(), $upper, $lower) = 'href'], '#') = $currentParty/tia:Hoedanigheid[substring-after(tia:wordtVertegenwoordigdRef[1]/@*[translate(local-name(), $upper, $lower) = 'href'], '#') = $mainPerson/descendant-or-self::tia:IMKAD_Persoon/@id]/@id] and concat('#', @id) = $currentParty/tia:Hoedanigheid[concat('#', @id) = $firstManager/tia:IMKAD_Persoon[count(tia:vertegenwoordigtRef) = 1]/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href']]/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href']]) > 1)">
					<xsl:text>true</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>false</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="numberOfRelatedPersonsInAllManager" select="count(tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder']/tia:IMKAD_Persoon/descendant-or-self::tia:IMKAD_Persoon)"/>
		<xsl:variable name="formatOfFirstLevel">
			<xsl:choose>
				<xsl:when test="$numberOfManagers = 1 and $numberOfRelatedPersonsInAllManager = 1 and $onlyPersonWithBulletInParty = 'true'">
					<xsl:value-of select="$personNumberingFormat"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="translate($personNumberingFormat, '1a', 'a1')"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="warrantorsAndMainPersonRepresentedByPreviousPersons">
			<xsl:choose>
				<xsl:when test="count(tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder']) = 0 and $mainPersonRepresentedInHoedanigheid and count(preceding-sibling::tia:IMKAD_Persoon) > 0">
					<xsl:text>true</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>false</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="ordinalNumberOfPersonInParty" select="count(preceding-sibling::tia:IMKAD_Persoon) + 1"/>
		<xsl:choose>
			<xsl:when test="$haveWarrantors = 'true'">
				<xsl:choose>
					<!--
						Bestuurder(s) acts as Hoednagiheid for main NNP and some of the related NNPs (volmachtgevers). There are two situations:
						1. more than 1 reference to Hoedanigheid from first bestuurder
						2. 1 reference to Hoedanigheid from first bestuurder, Hoedanigheid contain references to more than 1 (but not all) NNP (main person and warrantor)
					-->
					<xsl:when test="$warrantorsAndMainPersonRepresentedInGroupsByManagers = 'true'">
						<!-- Iterate through each group, described within first bestuurder -->
						<xsl:for-each select="$firstManager/tia:IMKAD_Persoon/tia:vertegenwoordigtRef[substring-after(@*[translate(local-name(), $upper, $lower) = 'href'], '#') = $currentParty/tia:Hoedanigheid[substring-after(tia:wordtVertegenwoordigdRef[1]/@*[translate(local-name(), $upper, $lower) = 'href'], '#') = $mainPerson/descendant-or-self::tia:IMKAD_Persoon[not(parent::tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder'])]/@id]/@id]">
							<xsl:variable name="currentlyProcessedHoedanigheidId" select="@*[translate(local-name(), $upper, $lower) = 'href']"/>
							<xsl:variable name="currentlyProcessedHoedanigheid" select="$currentParty/tia:Hoedanigheid[concat('#', @id) = $currentlyProcessedHoedanigheidId]"/>
							<xsl:variable name="capacityVariantCurrentHoedanigheid" select="$currentlyProcessedHoedanigheid/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvariant']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
								translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvariant']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
								translate(normalize-space($currentlyProcessedHoedanigheid/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvariant']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
							<xsl:variable name="managerPersonsRepresentingInHoedanigheid" select="$mainPerson/tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder']/tia:IMKAD_Persoon/descendant-or-self::tia:IMKAD_Persoon"/>
							<xsl:variable name="capacityAlredyPrintedInAdvance">
								<xsl:choose>
									<xsl:when test="count($firstManager/tia:IMKAD_Persoon/tia:vertegenwoordigtRef) = 1 and $actingInPrivate = 'false'">
										<xsl:text>true</xsl:text>
									</xsl:when>
									<xsl:when test="count($firstManager/tia:IMKAD_Persoon/tia:vertegenwoordigtRef) > 1 and $actingInPrivate = 'false'">
										<xsl:text>true</xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="$capacityAlredyPrinted"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:variable>
							<xsl:choose>
								<xsl:when test="$wrappedInTableData = 'true'">
									<xsl:choose>
										<!-- If there is only one reference to Hoedanigheid from bestuurder(s), Hoedanigheid and Hoedanigheid variant text should be printed prior to table -->
										<xsl:when test="count($firstManager/tia:IMKAD_Persoon/tia:vertegenwoordigtRef) = 1 and $actingInPrivate = 'false'">
											<xsl:if test="$capacityAlredyPrinted = 'false'">
												<xsl:apply-templates select="$currentlyProcessedHoedanigheid" mode="do-capacity-for-legal-person">
													<xsl:with-param name="relatedPersons" select="$managerPersonsRepresentingInHoedanigheid"/>
													<xsl:with-param name="shouldPrintColon" select="'false'"/>
												</xsl:apply-templates>
											</xsl:if>
											<xsl:if test="$capacityVariantCurrentHoedanigheid = '1' or $capacityVariantCurrentHoedanigheid = '2' or $capacityVariantCurrentHoedanigheid = '3' or $capacityVariantCurrentHoedanigheid = '4' or $capacityVariantCurrentHoedanigheid = '5' or $capacityVariantCurrentHoedanigheid = '6' or $capacityVariantCurrentHoedanigheid = '7' or $capacityVariantCurrentHoedanigheid = '8' or $capacityVariantCurrentHoedanigheid = '10'">
												<xsl:text> </xsl:text>
												<xsl:apply-templates select="$currentlyProcessedHoedanigheid" mode="do-capacity-variant-for-legal-person">
													<xsl:with-param name="relatedPersons" select="$managerPersonsRepresentingInHoedanigheid"/>
												</xsl:apply-templates>
											</xsl:if>
											<xsl:text>:</xsl:text>
										</xsl:when>
										<!-- If there is more than one reference to Hoedanigheid from bestuurder(s), Hoedanigheid text should be printed prior to table -->
										<xsl:when test="position() = 1 and count($firstManager/tia:IMKAD_Persoon/tia:vertegenwoordigtRef) > 1 and $actingInPrivate = 'false'">
											<xsl:if test="$capacityAlredyPrinted = 'false'">
												<xsl:apply-templates select="$currentlyProcessedHoedanigheid" mode="do-capacity-for-legal-person">
													<xsl:with-param name="relatedPersons" select="$managerPersonsRepresentingInHoedanigheid"/>
													<xsl:with-param name="shouldPrintColon" select="'false'"/>
												</xsl:apply-templates>
											</xsl:if>
											<xsl:text>:</xsl:text>
										</xsl:when>
									</xsl:choose>
									<table>
										<tbody>
											<xsl:apply-templates select="$mainPerson" mode="do-party-legal-person-text-main-and-related-persons-warrantors-and-main-person-represented-in-groups-by-managers">
												<xsl:with-param name="mainPersonRepresentedInHoedanigheid" select="$mainPersonRepresentedInHoedanigheid"/>
												<xsl:with-param name="firstWarrantorRepresentedInHoedanigheid" select="$firstWarrantorRepresentedInHoedanigheid"/>
												<xsl:with-param name="capacityVariantCurrentPerson" select="$capacityVariantCurrentPerson"/>
												<xsl:with-param name="capacityFirstWarrantor" select="$capacityFirstWarrantor"/>
												<xsl:with-param name="capacityVariantFirstWarrantor" select="$capacityVariantFirstWarrantor"/>
												<xsl:with-param name="firstWarrantor" select="$firstWarrantor"/>
												<xsl:with-param name="haveWarrantors" select="$haveWarrantors"/>
												<xsl:with-param name="relatedPersons" select="$relatedPersons"/>
												<xsl:with-param name="personTerminator" select="$personTerminator"/>
												<xsl:with-param name="capacityAlredyPrinted" select="$capacityAlredyPrintedInAdvance"/>
												<xsl:with-param name="onlyPersonWithBulletInParty" select="$onlyPersonWithBulletInParty"/>
												<xsl:with-param name="actingInPrivate" select="$actingInPrivate"/>
												<xsl:with-param name="wrappedInTable" select="$wrappedInTable"/>
												<xsl:with-param name="wrappedInTableData" select="$wrappedInTableData"/>
												<xsl:with-param name="currentParty" select="$currentParty"/>
												<xsl:with-param name="numberOfManagers" select="$numberOfManagers"/>
												<xsl:with-param name="firstManager" select="$firstManager"/>
												<xsl:with-param name="currentlyProcessedHoedanigheid" select="$currentlyProcessedHoedanigheid"/>
												<xsl:with-param name="capacityVariantCurrentHoedanigheid" select="$capacityVariantCurrentHoedanigheid"/>
												<xsl:with-param name="managerPersonsRepresentingInHoedanigheid" select="$managerPersonsRepresentingInHoedanigheid"/>
												<xsl:with-param name="position" select="position()"/>
												<xsl:with-param name="last" select="last()"/>
												<xsl:with-param name="numberOfRelatedPersonsInAllManager" select="$numberOfRelatedPersonsInAllManager"/>
												<xsl:with-param name="formatOfFirstLevel" select="$formatOfFirstLevel"/>
												<xsl:with-param name="personNumberingFormat" select="$personNumberingFormat"/>
											</xsl:apply-templates>
										</tbody>
									</table>
								</xsl:when>
								<xsl:otherwise>
									<xsl:apply-templates select="$mainPerson" mode="do-party-legal-person-text-main-and-related-persons-warrantors-and-main-person-represented-in-groups-by-managers">
										<xsl:with-param name="mainPersonRepresentedInHoedanigheid" select="$mainPersonRepresentedInHoedanigheid"/>
										<xsl:with-param name="firstWarrantorRepresentedInHoedanigheid" select="$firstWarrantorRepresentedInHoedanigheid"/>
										<xsl:with-param name="capacityVariantCurrentPerson" select="$capacityVariantCurrentPerson"/>
										<xsl:with-param name="capacityFirstWarrantor" select="$capacityFirstWarrantor"/>
										<xsl:with-param name="capacityVariantFirstWarrantor" select="$capacityVariantFirstWarrantor"/>
										<xsl:with-param name="firstWarrantor" select="$firstWarrantor"/>
										<xsl:with-param name="haveWarrantors" select="$haveWarrantors"/>
										<xsl:with-param name="relatedPersons" select="$relatedPersons"/>
										<xsl:with-param name="personTerminator" select="$personTerminator"/>
										<xsl:with-param name="capacityAlredyPrinted" select="$capacityAlredyPrintedInAdvance"/>
										<xsl:with-param name="onlyPersonWithBulletInParty" select="$onlyPersonWithBulletInParty"/>
										<xsl:with-param name="actingInPrivate" select="$actingInPrivate"/>
										<xsl:with-param name="wrappedInTable" select="$wrappedInTable"/>
										<xsl:with-param name="wrappedInTableData" select="$wrappedInTableData"/>
										<xsl:with-param name="currentParty" select="$currentParty"/>
										<xsl:with-param name="numberOfManagers" select="$numberOfManagers"/>
										<xsl:with-param name="firstManager" select="$firstManager"/>
										<xsl:with-param name="currentlyProcessedHoedanigheid" select="$currentlyProcessedHoedanigheid"/>
										<xsl:with-param name="capacityVariantCurrentHoedanigheid" select="$capacityVariantCurrentHoedanigheid"/>
										<xsl:with-param name="managerPersonsRepresentingInHoedanigheid" select="$managerPersonsRepresentingInHoedanigheid"/>
										<xsl:with-param name="position" select="position()"/>
										<xsl:with-param name="last" select="last()"/>
										<xsl:with-param name="numberOfRelatedPersonsInAllManager" select="$numberOfRelatedPersonsInAllManager"/>
										<xsl:with-param name="formatOfFirstLevel" select="$formatOfFirstLevel"/>
										<xsl:with-param name="personNumberingFormat" select="$personNumberingFormat"/>
									</xsl:apply-templates>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:for-each>
					</xsl:when>
					<!-- Bestuurder(s)/Gevolmachtide acts as Hoednagiheid for both main and related NNPs (volmachtgevers) -->
					<xsl:when test="$allWarrantorsAndMainPersonRepresentedByManager = 'true'">
						<xsl:choose>
							<xsl:when test="$wrappedInTable = 'true'">
								<tr>
									<xsl:if test="$numberOfManagers = 1 and $numberOfRelatedPersonsInAllManager = 1 and $onlyPersonWithBulletInParty = 'false'">
										<td class="number" valign="top">
											<xsl:text>&#xFEFF;</xsl:text>
										</td>
									</xsl:if>
									<td class="number" valign="top">
										<xsl:choose>
											<xsl:when test="$actingInPrivate = 'true'">
												<xsl:number value="2" format="I"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:number value="1" format="{$formatOfFirstLevel}"/>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:text>.</xsl:text>
									</td>
									<td>
										<xsl:if test="$actingInPrivate = 'true'">
											<xsl:attribute name="class"><xsl:text>level1</xsl:text></xsl:attribute>
										</xsl:if>
										<xsl:apply-templates select="$mainPerson" mode="do-party-legal-person-text-main-and-related-persons-all-warrantors-and-main-person-represented-by-manager">
											<xsl:with-param name="mainPersonRepresentedInHoedanigheid" select="$mainPersonRepresentedInHoedanigheid"/>
											<xsl:with-param name="capacityVariantCurrentPerson" select="$capacityVariantCurrentPerson"/>
											<xsl:with-param name="relatedPersons" select="$relatedPersons"/>
											<xsl:with-param name="personTerminator" select="$personTerminator"/>
											<xsl:with-param name="capacityAlredyPrinted" select="$capacityAlredyPrinted"/>
											<xsl:with-param name="onlyPersonWithBulletInParty" select="$onlyPersonWithBulletInParty"/>
											<xsl:with-param name="numberOfManagers" select="$numberOfManagers"/>
											<xsl:with-param name="numberOfRelatedPersonsInAllManager" select="$numberOfRelatedPersonsInAllManager"/>
											<xsl:with-param name="actingInPrivate" select="$actingInPrivate"/>
											<xsl:with-param name="formatOfFirstLevel" select="$formatOfFirstLevel"/>
											<xsl:with-param name="personNumberingFormat" select="$personNumberingFormat"/>
										</xsl:apply-templates>
									</td>
								</tr>
							</xsl:when>
							<xsl:otherwise>
								<xsl:apply-templates select="$mainPerson" mode="do-party-legal-person-text-main-and-related-persons-all-warrantors-and-main-person-represented-by-manager">
									<xsl:with-param name="mainPersonRepresentedInHoedanigheid" select="$mainPersonRepresentedInHoedanigheid"/>
									<xsl:with-param name="capacityVariantCurrentPerson" select="$capacityVariantCurrentPerson"/>
									<xsl:with-param name="relatedPersons" select="$relatedPersons"/>
									<xsl:with-param name="personTerminator" select="$personTerminator"/>
									<xsl:with-param name="capacityAlredyPrinted" select="$capacityAlredyPrinted"/>
									<xsl:with-param name="onlyPersonWithBulletInParty" select="$onlyPersonWithBulletInParty"/>
									<xsl:with-param name="numberOfManagers" select="$numberOfManagers"/>
									<xsl:with-param name="numberOfRelatedPersonsInAllManager" select="$numberOfRelatedPersonsInAllManager"/>
									<xsl:with-param name="actingInPrivate" select="$actingInPrivate"/>
									<xsl:with-param name="formatOfFirstLevel" select="$formatOfFirstLevel"/>
									<xsl:with-param name="personNumberingFormat" select="$personNumberingFormat"/>
								</xsl:apply-templates>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<!-- Bestuurder(s)/Gevolmachtide acts as Hoednagiheid for main NNP and main NNP acts as Hoedanigheid for all related NNPs (volmachtgevers) -->
					<xsl:when test="$allWarrantorsRepresentedByMainPerson = 'true'">
						<xsl:choose>
							<xsl:when test="$wrappedInTable = 'true'">
								<tr>
									<xsl:if test="$numberOfManagers = 1 and $numberOfRelatedPersonsInAllManager = 1 and $onlyPersonWithBulletInParty = 'false'">
										<td class="number" valign="top">
											<xsl:text>&#xFEFF;</xsl:text>
										</td>
									</xsl:if>
									<td class="number" valign="top">
										<xsl:choose>
											<xsl:when test="$actingInPrivate = 'true'">
												<xsl:number value="2" format="I"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:number value="1" format="{$formatOfFirstLevel}"/>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:text>.</xsl:text>
									</td>
									<td>
										<xsl:if test="$actingInPrivate = 'true'">
											<xsl:attribute name="class"><xsl:text>level1</xsl:text></xsl:attribute>
										</xsl:if>
										<xsl:apply-templates select="$mainPerson" mode="do-party-legal-person-text-main-and-related-persons-all-warrantors-represented-by-main-person">
											<xsl:with-param name="mainPersonRepresentedInHoedanigheid" select="$mainPersonRepresentedInHoedanigheid"/>
											<xsl:with-param name="capacityVariantCurrentPerson" select="$capacityVariantCurrentPerson"/>
											<xsl:with-param name="relatedPersons" select="$relatedPersons"/>
											<xsl:with-param name="personTerminator" select="$personTerminator"/>
											<xsl:with-param name="capacityAlredyPrinted" select="$capacityAlredyPrinted"/>
											<xsl:with-param name="numberOfWarrantors" select="$numberOfWarrantors"/>
											<xsl:with-param name="capacityVariantFirstWarrantor" select="$capacityVariantFirstWarrantor"/>
											<xsl:with-param name="firstWarrantorRepresentedInHoedanigheid" select="$firstWarrantorRepresentedInHoedanigheid"/>
											<xsl:with-param name="firstWarrantor" select="$firstWarrantor"/>
											<xsl:with-param name="actingInPrivate" select="$actingInPrivate"/>
											<xsl:with-param name="numberOfManagers" select="$numberOfManagers"/>
											<xsl:with-param name="numberOfRelatedPersonsInAllManager" select="$numberOfRelatedPersonsInAllManager"/>
											<xsl:with-param name="onlyPersonWithBulletInParty" select="$onlyPersonWithBulletInParty"/>
											<xsl:with-param name="formatOfFirstLevel" select="$formatOfFirstLevel"/>
											<xsl:with-param name="skipPartyNumberColumn" select="$skipPartyNumberColumn"/>
											<xsl:with-param name="personNumberingFormat" select="$personNumberingFormat"/>
										</xsl:apply-templates>
									</td>
								</tr>
							</xsl:when>
							<xsl:otherwise>
								<xsl:apply-templates select="$mainPerson" mode="do-party-legal-person-text-main-and-related-persons-all-warrantors-represented-by-main-person">
									<xsl:with-param name="mainPersonRepresentedInHoedanigheid" select="$mainPersonRepresentedInHoedanigheid"/>
									<xsl:with-param name="capacityVariantCurrentPerson" select="$capacityVariantCurrentPerson"/>
									<xsl:with-param name="relatedPersons" select="$relatedPersons"/>
									<xsl:with-param name="personTerminator" select="$personTerminator"/>
									<xsl:with-param name="capacityAlredyPrinted" select="$capacityAlredyPrinted"/>
									<xsl:with-param name="numberOfWarrantors" select="$numberOfWarrantors"/>
									<xsl:with-param name="capacityVariantFirstWarrantor" select="$capacityVariantFirstWarrantor"/>
									<xsl:with-param name="firstWarrantorRepresentedInHoedanigheid" select="$firstWarrantorRepresentedInHoedanigheid"/>
									<xsl:with-param name="firstWarrantor" select="$firstWarrantor"/>
									<xsl:with-param name="actingInPrivate" select="$actingInPrivate"/>
									<xsl:with-param name="numberOfManagers" select="$numberOfManagers"/>
									<xsl:with-param name="numberOfRelatedPersonsInAllManager" select="$numberOfRelatedPersonsInAllManager"/>
									<xsl:with-param name="onlyPersonWithBulletInParty" select="$onlyPersonWithBulletInParty"/>
									<xsl:with-param name="formatOfFirstLevel" select="$formatOfFirstLevel"/>
									<xsl:with-param name="skipPartyNumberColumn" select="$skipPartyNumberColumn"/>
									<xsl:with-param name="personNumberingFormat" select="$personNumberingFormat"/>
								</xsl:apply-templates>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<!-- Bestuurder(s)/Gevolmachtide acts as Hoednagiheid for main NNP, main NNP acts as Hoedanigheid for first related NNP (volmachtgever) and volmachtgevers act as Hoedanigheid for each other -->
					<xsl:when test="$warrantorsActAsHoedanighiedForEachOther = 'true'">
						<xsl:choose>
							<xsl:when test="$wrappedInTable = 'true'">
								<tr>
									<xsl:if test="$numberOfManagers = 1 and $numberOfRelatedPersonsInAllManager = 1 and $onlyPersonWithBulletInParty = 'false'">
										<td class="number" valign="top">
											<xsl:text>&#xFEFF;</xsl:text>
										</td>
									</xsl:if>
									<td class="number" valign="top">
										<xsl:choose>
											<xsl:when test="$actingInPrivate = 'true'">
												<xsl:number value="2" format="I"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:number value="1" format="{$formatOfFirstLevel}"/>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:text>.</xsl:text>
									</td>
									<td>
										<xsl:if test="$actingInPrivate = 'true'">
											<xsl:attribute name="class"><xsl:text>level1</xsl:text></xsl:attribute>
										</xsl:if>
										<xsl:apply-templates select="$mainPerson" mode="do-party-legal-person-text-main-and-related-persons-warrantors-act-as-hoedanighied-for-each-other">
											<xsl:with-param name="mainPersonRepresentedInHoedanigheid" select="$mainPersonRepresentedInHoedanigheid"/>
											<xsl:with-param name="capacityVariantCurrentPerson" select="$capacityVariantCurrentPerson"/>
											<xsl:with-param name="personTerminator" select="$personTerminator"/>
											<xsl:with-param name="actingInPrivate" select="$actingInPrivate"/>
											<xsl:with-param name="currentParty" select="$currentParty"/>
											<xsl:with-param name="capacityAlredyPrinted" select="$capacityAlredyPrinted"/>
											<xsl:with-param name="formatOfFirstLevel" select="$formatOfFirstLevel"/>
											<xsl:with-param name="numberOfRelatedPersonsInAllManager" select="$numberOfRelatedPersonsInAllManager"/>
											<xsl:with-param name="personNumberingFormat" select="$personNumberingFormat"/>
										</xsl:apply-templates>
									</td>
								</tr>
							</xsl:when>
							<xsl:otherwise>
								<xsl:apply-templates select="$mainPerson" mode="do-party-legal-person-text-main-and-related-persons-warrantors-act-as-hoedanighied-for-each-other">
									<xsl:with-param name="mainPersonRepresentedInHoedanigheid" select="$mainPersonRepresentedInHoedanigheid"/>
									<xsl:with-param name="capacityVariantCurrentPerson" select="$capacityVariantCurrentPerson"/>
									<xsl:with-param name="personTerminator" select="$personTerminator"/>
									<xsl:with-param name="actingInPrivate" select="$actingInPrivate"/>
									<xsl:with-param name="currentParty" select="$currentParty"/>
									<xsl:with-param name="capacityAlredyPrinted" select="$capacityAlredyPrinted"/>
									<xsl:with-param name="formatOfFirstLevel" select="$formatOfFirstLevel"/>
									<xsl:with-param name="numberOfRelatedPersonsInAllManager" select="$numberOfRelatedPersonsInAllManager"/>
									<xsl:with-param name="personNumberingFormat" select="$personNumberingFormat"/>
								</xsl:apply-templates>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<!-- Previous persons act as Hoednagiheid for both main NNP and volmachtgevers -->
					<xsl:when test="$warrantorsAndMainPersonRepresentedByPreviousPersons = 'true'">
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
											<td>
												<xsl:apply-templates select="$mainPersonRepresentedInHoedanigheid" mode="do-capacity-for-legal-person">
													<xsl:with-param name="relatedPersons" select="$relatedPersons"/>
													<xsl:with-param name="shouldPrintColon" select="'false'"/>
													<xsl:with-param name="representedByPreviousPerson" select="$representedByPreviousPerson"/>
												</xsl:apply-templates>
												<xsl:if test="$capacityVariantCurrentPerson = '1' or $capacityVariantCurrentPerson = '2' or $capacityVariantCurrentPerson = '3' or $capacityVariantCurrentPerson = '4' or $capacityVariantCurrentPerson = '5' or $capacityVariantCurrentPerson = '6' or $capacityVariantCurrentPerson = '7' or $capacityVariantCurrentPerson = '8' or $capacityVariantCurrentPerson = '10'">
													<xsl:text> </xsl:text>
													<xsl:apply-templates select="$mainPersonRepresentedInHoedanigheid" mode="do-capacity-variant-for-legal-person">
														<xsl:with-param name="relatedPersons" select="$relatedPersons"/>
													</xsl:apply-templates>
												</xsl:if>
												<xsl:text>:</xsl:text>
											</td>
										</tr>
									</tbody>
								</table>
							</td>
						</tr>
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
											<td class="number" valign="top">
												<xsl:apply-templates mode="do-party-person-number-for-legal-person" select="$mainPerson">
													<xsl:with-param name="numberingFormat" select="$personNumberingFormat"/>
													<xsl:with-param name="currentParty" select="$currentParty"/>
													<xsl:with-param name="ordinalNumberOfPersonInParty" select="$ordinalNumberOfPersonInParty"/>
												</xsl:apply-templates>
											</td>
											<td>
												<xsl:apply-templates select="." mode="do-legal-person"/>
												<xsl:if test="normalize-space(tia:tia_AanduidingPersoon) != ''">
													<xsl:text>, hierna te noemen: </xsl:text>
													<xsl:value-of select="tia:tia_AanduidingPersoon"/>
												</xsl:if>
												<xsl:text>; en</xsl:text>
											</td>
										</tr>
									</tbody>
								</table>
							</td>
						</tr>
						<xsl:for-each select="tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'volmachtgever']">
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
												<td class="number" valign="top">
													<xsl:apply-templates mode="do-party-person-number-for-legal-person" select="$mainPerson">
														<xsl:with-param name="numberingFormat" select="$personNumberingFormat"/>
														<xsl:with-param name="currentParty" select="$currentParty"/>
														<xsl:with-param name="ordinalNumberOfPersonInParty" select="$ordinalNumberOfPersonInParty"/>
														<xsl:with-param name="positionWithinPerson" select="position()"/>
													</xsl:apply-templates>
												</td>
												<td>
													<xsl:apply-templates select="tia:IMKAD_Persoon" mode="do-legal-person"/>
													<xsl:if test="normalize-space(tia:IMKAD_Persoon/tia:tia_AanduidingPersoon) != ''">
														<xsl:text>, hierna te noemen: </xsl:text>
														<xsl:value-of select="tia:IMKAD_Persoon/tia:tia_AanduidingPersoon"/>
													</xsl:if>
													<xsl:if test="tia:IMKAD_Persoon/tia:IMKAD_PostlocatiePersoon">
														<xsl:text> (correspondentieadres voor alle aangelegenheden betreffende de hierna te vermelden rechtshandelingen: </xsl:text>
														<xsl:apply-templates select="tia:IMKAD_Persoon/tia:IMKAD_PostlocatiePersoon" mode="do-correspondant-address"/>
														<xsl:text>)</xsl:text>
													</xsl:if>
													<xsl:choose>
														<xsl:when test="position() != last()">
															<xsl:text>; en</xsl:text>
														</xsl:when>
														<xsl:when test="position() = last()">
															<xsl:value-of select="$personTerminator"/>
														</xsl:when>
													</xsl:choose>
												</td>
											</tr>
										</tbody>
									</table>
								</td>
							</tr>
						</xsl:for-each>
					</xsl:when>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="$wrappedInTable = 'true'">
						<tr>
							<xsl:if test="$numberOfManagers = 1 and $numberOfRelatedPersonsInAllManager = 1 and $onlyPersonWithBulletInParty = 'false'">
								<td class="number" valign="top">
									<xsl:text>&#xFEFF;</xsl:text>
								</td>
							</xsl:if>
							<td class="number" valign="top">
								<xsl:choose>
									<xsl:when test="$actingInPrivate = 'true'">
										<xsl:number value="2" format="I"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:number value="1" format="{$formatOfFirstLevel}"/>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:text>.</xsl:text>
							</td>
							<td>
								<xsl:if test="$actingInPrivate = 'true'">
									<xsl:attribute name="class"><xsl:text>level1</xsl:text></xsl:attribute>
								</xsl:if>
								<xsl:apply-templates select="$mainPerson" mode="do-party-legal-person-text-main-and-related-persons-without-warrantors">
									<xsl:with-param name="mainPersonRepresentedInHoedanigheid" select="$mainPersonRepresentedInHoedanigheid"/>
									<xsl:with-param name="capacityVariantCurrentPerson" select="$capacityVariantCurrentPerson"/>
									<xsl:with-param name="relatedPersons" select="$relatedPersons"/>
									<xsl:with-param name="personTerminator" select="$personTerminator"/>
									<xsl:with-param name="capacityAlredyPrinted" select="$capacityAlredyPrinted"/>
									<xsl:with-param name="actingInPrivate" select="$actingInPrivate"/>
									<xsl:with-param name="representedByPreviousPerson" select="$representedByPreviousPerson"/>
								</xsl:apply-templates>
							</td>
						</tr>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="$mainPerson" mode="do-party-legal-person-text-main-and-related-persons-without-warrantors">
							<xsl:with-param name="mainPersonRepresentedInHoedanigheid" select="$mainPersonRepresentedInHoedanigheid"/>
							<xsl:with-param name="capacityVariantCurrentPerson" select="$capacityVariantCurrentPerson"/>
							<xsl:with-param name="relatedPersons" select="$relatedPersons"/>
							<xsl:with-param name="personTerminator" select="$personTerminator"/>
							<xsl:with-param name="capacityAlredyPrinted" select="$capacityAlredyPrinted"/>
							<xsl:with-param name="representedByPreviousPerson" select="$representedByPreviousPerson"/>
						</xsl:apply-templates>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--
	*******************************************************************************************************
	Mode: do-party-legal-person-text-main-and-related-persons-warrantors-act-as-hoedanighied-for-each-other
	*******************************************************************************************************
	Public: no

	Identity transform: no

	Description: Block used for initial logic execution when main NNP represents volmachtgevers in Hoedanigheid, and volmachtgevers also represent each other in Hoedanigheid.
				 As there is maximum nesting level allowed, recursive template do-party-legal-person-text-main-and-related-persons-warrantors-act-as-hoedanighied-for-each-other-next-representation
				 will be called several times, in order to print lists with maximum allowed nesting levels or less.
				 Each recursive call assumes list level restart - it will start as new list, and the numbering format will be retained as if it was sequence of previos list.


	Input: tia:IMKAD_Persoon

	Params: mainPersonRepresentedInHoedanigheid - Hoedanigheid which contains reference to main person
			capacityVariantCurrentPerson - variant of Hoedanigheid in main NNP
			personTerminator - character that is printed at the end of each person's block
			actingInPrivate - determines whether main NNP is represented in 'in prive' type of Hoedanigheid representation
			currentParty - currently processed party
			capacityAlredyPrinted - determines if capacity text is allready printed prior to this template calling
			formatOfFirstLevel - format of first nesting level, could be either 'a' or '1'
			numberOfRelatedPersonsInAllManager - total number of related persons in all managers
			personNumberingFormat - first level person numbering format ('a' is default)

	Output: text

	Calls:
	(mode) do-party-legal-person-text-main-and-related-persons-warrantors-act-as-hoedanighied-for-each-other-next-representation

	Called by:
	(mode) do-party-legal-person-text-main-and-related-persons
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon" mode="do-party-legal-person-text-main-and-related-persons-warrantors-act-as-hoedanighied-for-each-other">
		<xsl:param name="mainPersonRepresentedInHoedanigheid" select="self::node()[false()]"/>
		<xsl:param name="capacityVariantCurrentPerson" select="number('0')"/>
		<xsl:param name="personTerminator" select="';'"/>
		<xsl:param name="actingInPrivate" select="'false'"/>
		<xsl:param name="currentParty" select="self::node()[false()]"/>
		<xsl:param name="capacityAlredyPrinted" select="'false'"/>
		<xsl:param name="formatOfFirstLevel"/>
		<xsl:param name="numberOfRelatedPersonsInAllManager" select="number('0')"/>
		<xsl:param name="personNumberingFormat" select="'a'"/>
		<xsl:variable name="mainPerson" select="."/>
		<xsl:variable name="maximumNestingDepth" select="number('10')"/>
		<xsl:variable name="allHoedanigheids" select="$currentParty/tia:Hoedanigheid[concat('#', @id) = $mainPerson/descendant-or-self::tia:IMKAD_Persoon/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] and substring-after(tia:wordtVertegenwoordigdRef[1]/@*[translate(local-name(), $upper, $lower) = 'href'], '#') = $mainPerson/descendant-or-self::tia:IMKAD_Persoon/@id]"/>
		<xsl:for-each select="$allHoedanigheids">
			<xsl:variable name="position" select="position()"/>
			<xsl:variable name="isFirstRecursiveCallFromOutside">
				<xsl:choose>
					<xsl:when test="position() = 1">
						<xsl:text>true</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>false</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="currentlyProcessedHoedanigheid" select="."/>
			<xsl:variable name="previouslyProcessedHoedanigheid" select="$allHoedanigheids[$position - 1]"/>
			<xsl:variable name="actingInPrivateCurrentlyProcessedHoedanigheid" select="$currentlyProcessedHoedanigheid/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvoorzich']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
					translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvoorzich']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
					translate(normalize-space($currentlyProcessedHoedanigheid/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvoorzich']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
			<xsl:variable name="currentHoedanigheidNestingDepthActingInPrivate">
				<xsl:choose>
					<xsl:when test="$actingInPrivateCurrentlyProcessedHoedanigheid">
						<xsl:number value="1"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:number value="0"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="currentHoedanigheidNestingDepth">
				<xsl:choose>
					<xsl:when test="count($currentlyProcessedHoedanigheid/tia:wordtVertegenwoordigdRef) > 1">
						<xsl:value-of select="$currentHoedanigheidNestingDepthActingInPrivate + 1"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$currentHoedanigheidNestingDepthActingInPrivate + 0"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="currentHoedanigheidStartingNestingDepth" select="count(preceding-sibling::tia:Hoedanigheid[@id = $allHoedanigheids/@id and count(tia:wordtVertegenwoordigdRef) > 1])
								+ count(preceding-sibling::tia:Hoedanigheid[@id = $allHoedanigheids/@id and tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvoorzich']/tia:tekst])"/>
			<xsl:variable name="previousHoedanigheidStartingNestingDepth" select="count($previouslyProcessedHoedanigheid/preceding-sibling::tia:Hoedanigheid[@id = $allHoedanigheids/@id and count(tia:wordtVertegenwoordigdRef) > 1])
								+ count($previouslyProcessedHoedanigheid/preceding-sibling::tia:Hoedanigheid[@id = $allHoedanigheids/@id and tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvoorzich']/tia:tekst])"/>
			<xsl:variable name="shouldPrintRomanNumbers">
				<xsl:choose>
					<xsl:when test="$numberOfRelatedPersonsInAllManager > 1 and $actingInPrivate = 'false'">
						<xsl:text>true</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>false</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<!-- Call recursive template in case of first iteration and in any further where maximum allowed nesting level is reached (as this can be achieved in more hoedanigheids given in sequence, call should occur only for the first one, and should be skiped for the rest) -->
			<xsl:if test="position() = 1 or ($currentHoedanigheidStartingNestingDepth mod $maximumNestingDepth = 0 and not($previousHoedanigheidStartingNestingDepth mod $maximumNestingDepth = 0))">
				<xsl:apply-templates select="$mainPerson" mode="do-party-legal-person-text-main-and-related-persons-warrantors-act-as-hoedanighied-for-each-other-next-representation">
					<xsl:with-param name="allHoedanigheids" select="$allHoedanigheids"/>
					<xsl:with-param name="processedHoedanigheidOrderNumber" select="count(preceding-sibling::tia:Hoedanigheid[@id = $allHoedanigheids/@id]) + 1"/>
					<xsl:with-param name="personTerminator" select="$personTerminator"/>
					<xsl:with-param name="currentParty" select="$currentParty"/>
					<xsl:with-param name="formatOfFirstLevel" select="$formatOfFirstLevel"/>
					<xsl:with-param name="maximumNestingDepth" select="$maximumNestingDepth"/>
					<xsl:with-param name="nestingDepth" select="number('0')"/>
					<xsl:with-param name="actingInPrivate" select="$actingInPrivate"/>
					<xsl:with-param name="isFirstRecursiveCallFromOutside" select="$isFirstRecursiveCallFromOutside"/>
					<xsl:with-param name="capacityAlredyPrinted" select="$capacityAlredyPrinted"/>
					<xsl:with-param name="shouldPrintRomanNumbers" select="$shouldPrintRomanNumbers"/>
					<xsl:with-param name="numberOfRelatedPersonsInAllManager" select="$numberOfRelatedPersonsInAllManager"/>
					<xsl:with-param name="personNumberingFormat" select="$personNumberingFormat"/>
				</xsl:apply-templates>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<!--
	***************************************************************************************************************************
	Mode: do-party-legal-person-text-main-and-related-persons-warrantors-act-as-hoedanighied-for-each-other-next-representation
	***************************************************************************************************************************
	Public: no

	Identity transform: no

	Description: Recursive block used when main NNP represents volmachtgevers in Hoedanigheid, and volmachtgevers also represent each other in Hoedanigheid.
				 End of recursion - either all volmachtgevers are processed, either maximum nesting depth is reached.

	Input: tia:IMKAD_Persoon

	Params: allHoedanigheids - all Hoedanigheid classes that contain representations between main NNP and volmachtgevers
			processedHoedanigheidOrderNumber - ordinal number of processed Hoedanigheid, in list given under allHoedanigheids parameter
			personTerminator - character that is printed at the end of each person's block
			currentParty - currently processed party
			formatOfFirstLevel - format of first nesting level, could be either 'a' or '1'
			maximumNestingDepth - maximum allowed nesting depth, used as one of conditions for recursion completion
			nestingDepth - nesting depth for current recursive iteration
			actingInPrivate - determines whether main NNP is represented in 'in prive' type of Hoedanigheid representation
			isFirstRecursiveCallFromOutside - indicator if it is first recursive call from outside caller, this has impact on numbering logic
			capacityAlredyPrinted - determines if capacity text is allready printed prior to this template calling
			shouldPrintRomanNumbers - indicator if Roman numbers should be printed
			numberOfRelatedPersonsInAllManager - total number of related persons in all managers
			recursiveCallOrdinalNumber - ordinal number of recursive call, starts from 1
			personNumberingFormat - first level person numbering format ('a' is default)

	Output: text

	Calls:
	(mode) do-capacity-for-legal-person
	(mode) do-capacity-variant-for-legal-person
	(mode) do-correspondant-address
	(mode) do-legal-person
	(mode) do-party-legal-person-text-main-and-related-persons-warrantors-act-as-hoedanighied-for-each-other-next-representation


	Called by:
	(mode) do-party-legal-person-text-main-and-related-persons-warrantors-act-as-hoedanighied-for-each-other
	(mode) do-party-legal-person-text-main-and-related-persons-warrantors-act-as-hoedanighied-for-each-other-next-representation
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon" mode="do-party-legal-person-text-main-and-related-persons-warrantors-act-as-hoedanighied-for-each-other-next-representation">
		<xsl:param name="allHoedanigheids" select="self::node()[false()]"/>
		<xsl:param name="processedHoedanigheidOrderNumber" select="number('0')"/>
		<xsl:param name="personTerminator" select="';'"/>
		<xsl:param name="currentParty" select="self::node()[false()]"/>
		<xsl:param name="formatOfFirstLevel"/>
		<xsl:param name="maximumNestingDepth" select="number('0')"/>
		<xsl:param name="nestingDepth" select="number('0')"/>
		<xsl:param name="actingInPrivate" select="'false'"/>
		<xsl:param name="isFirstRecursiveCallFromOutside" select="'false'"/>
		<xsl:param name="capacityAlredyPrinted" select="'false'"/>
		<xsl:param name="shouldPrintRomanNumbers" select="'false'"/>
		<xsl:param name="numberOfRelatedPersonsInAllManager" select="number('0')"/>
		<xsl:param name="recursiveCallOrdinalNumber" select="number('1')"/>
		<xsl:param name="personNumberingFormat" select="'a'"/>
		<xsl:variable name="mainPerson" select="."/>
		<xsl:variable name="numberOfHoedanigheids" select="count($allHoedanigheids)"/>
		<xsl:variable name="currentlyProcessedHoedanigheid" select="$allHoedanigheids[$processedHoedanigheidOrderNumber]"/>
		<xsl:variable name="isThereMoreHoedanigheidsToProcess">
			<xsl:choose>
				<xsl:when test="$processedHoedanigheidOrderNumber = count($allHoedanigheids)">
					<xsl:text>false</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>true</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="capacityVariantCurrentHoedaigheid" select="$currentlyProcessedHoedanigheid/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvariant']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvariant']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space($currentlyProcessedHoedanigheid/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvariant']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
		<xsl:variable name="numberOfPersonsRepresentedByThisHoedanigheid" select="count($currentlyProcessedHoedanigheid/tia:wordtVertegenwoordigdRef)"/>
		<xsl:variable name="firstRepresentedPerson" select="$mainPerson/descendant-or-self::tia:IMKAD_Persoon[concat('#', @id) = $currentlyProcessedHoedanigheid/tia:wordtVertegenwoordigdRef[1]/@*[translate(local-name(), $upper, $lower) = 'href']]"/>
		<xsl:variable name="previousPersonsActingAsHoedanigheid" select="$mainPerson/descendant-or-self::tia:IMKAD_Persoon[concat('#', $currentlyProcessedHoedanigheid/@id) = tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href']]"/>
		<xsl:variable name="actingInPrivateCurrentlyProcessedHoedanigheid" select="$currentlyProcessedHoedanigheid/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvoorzich']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
					translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvoorzich']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
					translate(normalize-space($currentlyProcessedHoedanigheid/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvoorzich']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
		<xsl:choose>
			<!-- When there is only one warrantor represented by current one (in Hoedanigheid), plain text will follows -->
			<xsl:when test="$numberOfPersonsRepresentedByThisHoedanigheid = 1">
				<xsl:choose>
					<!-- In prive (voor zich) Hoedanigheid relation logic is possible only between bestuurder(s) and main NNP person -->
					<xsl:when test="$actingInPrivateCurrentlyProcessedHoedanigheid">
						<xsl:if test="$capacityVariantCurrentHoedaigheid = '1' or $capacityVariantCurrentHoedaigheid = '2' or $capacityVariantCurrentHoedaigheid = '3' or $capacityVariantCurrentHoedaigheid = '4' or $capacityVariantCurrentHoedaigheid = '5' or $capacityVariantCurrentHoedaigheid = '6' or $capacityVariantCurrentHoedaigheid = '7' or $capacityVariantCurrentHoedaigheid = '8' or $capacityVariantCurrentHoedaigheid = '10'">
							<xsl:text> </xsl:text>
							<xsl:apply-templates select="$currentlyProcessedHoedanigheid" mode="do-capacity-variant-for-legal-person">
								<xsl:with-param name="relatedPersons" select="$previousPersonsActingAsHoedanigheid"/>
							</xsl:apply-templates>
						</xsl:if>
						<xsl:text> </xsl:text>
						<xsl:apply-templates select="$firstRepresentedPerson" mode="do-legal-person"/>
						<xsl:if test="normalize-space($firstRepresentedPerson/tia:tia_AanduidingPersoon) != ''">
							<xsl:text>, hierna te noemen: </xsl:text>
							<xsl:value-of select="$firstRepresentedPerson/tia:tia_AanduidingPersoon"/>
						</xsl:if>
						<xsl:if test="$isThereMoreHoedanigheidsToProcess = 'false' and $firstRepresentedPerson/tia:IMKAD_PostlocatiePersoon">
							<xsl:text> (correspondentieadres voor alle aangelegenheden betreffende de hierna te vermelden rechtshandelingen: </xsl:text>
							<xsl:apply-templates select="$firstRepresentedPerson/tia:IMKAD_PostlocatiePersoon" mode="do-correspondant-address"/>
							<xsl:text>)</xsl:text>
						</xsl:if>
						<xsl:choose>
							<xsl:when test="$isThereMoreHoedanigheidsToProcess = 'true'">
								<xsl:text>, </xsl:text>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="$personTerminator"/>
							</xsl:otherwise>
						</xsl:choose>
						<!-- Recursion continues -->
						<xsl:if test="$numberOfHoedanigheids > $processedHoedanigheidOrderNumber and $maximumNestingDepth > ($nestingDepth + 1)">
							<xsl:apply-templates select="$mainPerson" mode="do-party-legal-person-text-main-and-related-persons-warrantors-act-as-hoedanighied-for-each-other-next-representation">
								<xsl:with-param name="allHoedanigheids" select="$allHoedanigheids"/>
								<xsl:with-param name="processedHoedanigheidOrderNumber" select="$processedHoedanigheidOrderNumber + 1"/>
								<xsl:with-param name="personTerminator" select="$personTerminator"/>
								<xsl:with-param name="currentParty" select="$currentParty"/>
								<xsl:with-param name="formatOfFirstLevel" select="$formatOfFirstLevel"/>
								<xsl:with-param name="maximumNestingDepth" select="$maximumNestingDepth"/>
								<xsl:with-param name="nestingDepth" select="$nestingDepth"/>
								<xsl:with-param name="actingInPrivate" select="$actingInPrivate"/>
								<xsl:with-param name="isFirstRecursiveCallFromOutside" select="$isFirstRecursiveCallFromOutside"/>
								<xsl:with-param name="capacityAlredyPrinted" select="$capacityAlredyPrinted"/>
								<xsl:with-param name="shouldPrintRomanNumbers" select="$shouldPrintRomanNumbers"/>
								<xsl:with-param name="numberOfRelatedPersonsInAllManager" select="$numberOfRelatedPersonsInAllManager"/>
								<xsl:with-param name="recursiveCallOrdinalNumber" select="$recursiveCallOrdinalNumber + 1"/>
								<xsl:with-param name="personNumberingFormat" select="$personNumberingFormat"/>
							</xsl:apply-templates>
						</xsl:if>
					</xsl:when>
					<xsl:otherwise>
						<xsl:if test="not($capacityAlredyPrinted = 'true' and $isFirstRecursiveCallFromOutside = 'true' and $nestingDepth = 0 and $recursiveCallOrdinalNumber = 1)">
							<xsl:choose>
								<!-- Specific case when there is bestuurders with related partners/huisgenots which do not have reference toward hoedanigheid, but they need to be taken into account for representing -->
								<xsl:when test="$mainPerson/tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder'] and $isFirstRecursiveCallFromOutside = 'true' and $nestingDepth = 0 and $recursiveCallOrdinalNumber = 1">
									<xsl:apply-templates select="$currentlyProcessedHoedanigheid" mode="do-capacity-for-legal-person">
										<xsl:with-param name="relatedPersons" select="$mainPerson/descendant-or-self::tia:IMKAD_Persoon[parent::tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder' or translate(tia:rol, $upper, $lower) = 'partner'] or translate(tia:rol, $upper, $lower) = 'huisgenot']"/>
										<xsl:with-param name="shouldPrintColon" select="'false'"/>
									</xsl:apply-templates>
								</xsl:when>
								<xsl:otherwise>
									<xsl:apply-templates select="$currentlyProcessedHoedanigheid" mode="do-capacity-for-legal-person">
										<xsl:with-param name="relatedPersons" select="$previousPersonsActingAsHoedanigheid"/>
										<xsl:with-param name="shouldPrintColon" select="'false'"/>
									</xsl:apply-templates>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:if>
						<xsl:if test="$capacityVariantCurrentHoedaigheid = '1' or $capacityVariantCurrentHoedaigheid = '2' or $capacityVariantCurrentHoedaigheid = '3' or $capacityVariantCurrentHoedaigheid = '4' or $capacityVariantCurrentHoedaigheid = '5' or $capacityVariantCurrentHoedaigheid = '6' or $capacityVariantCurrentHoedaigheid = '7' or $capacityVariantCurrentHoedaigheid = '8' or $capacityVariantCurrentHoedaigheid = '10'">
							<xsl:text> </xsl:text>
							<xsl:apply-templates select="$currentlyProcessedHoedanigheid" mode="do-capacity-variant-for-legal-person">
								<xsl:with-param name="relatedPersons" select="$previousPersonsActingAsHoedanigheid"/>
							</xsl:apply-templates>
						</xsl:if>
						<xsl:text> </xsl:text>
						<xsl:apply-templates select="$firstRepresentedPerson" mode="do-legal-person"/>
						<xsl:if test="normalize-space($firstRepresentedPerson/tia:tia_AanduidingPersoon) != ''">
							<xsl:text>, hierna te noemen: </xsl:text>
							<xsl:value-of select="$firstRepresentedPerson/tia:tia_AanduidingPersoon"/>
						</xsl:if>
						<xsl:if test="$isThereMoreHoedanigheidsToProcess = 'false' and $firstRepresentedPerson/tia:IMKAD_PostlocatiePersoon">
							<xsl:text> (correspondentieadres voor alle aangelegenheden betreffende de hierna te vermelden rechtshandelingen: </xsl:text>
							<xsl:apply-templates select="$firstRepresentedPerson/tia:IMKAD_PostlocatiePersoon" mode="do-correspondant-address"/>
							<xsl:text>)</xsl:text>
						</xsl:if>
						<xsl:choose>
							<xsl:when test="$isThereMoreHoedanigheidsToProcess = 'true'">
								<xsl:text>, </xsl:text>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="$personTerminator"/>
							</xsl:otherwise>
						</xsl:choose>
						<!-- Recursion continues -->
						<xsl:if test="$numberOfHoedanigheids > $processedHoedanigheidOrderNumber and $maximumNestingDepth > $nestingDepth">
							<xsl:apply-templates select="$mainPerson" mode="do-party-legal-person-text-main-and-related-persons-warrantors-act-as-hoedanighied-for-each-other-next-representation">
								<xsl:with-param name="allHoedanigheids" select="$allHoedanigheids"/>
								<xsl:with-param name="processedHoedanigheidOrderNumber" select="$processedHoedanigheidOrderNumber + 1"/>
								<xsl:with-param name="personTerminator" select="$personTerminator"/>
								<xsl:with-param name="currentParty" select="$currentParty"/>
								<xsl:with-param name="formatOfFirstLevel" select="$formatOfFirstLevel"/>
								<xsl:with-param name="maximumNestingDepth" select="$maximumNestingDepth"/>
								<xsl:with-param name="nestingDepth" select="$nestingDepth"/>
								<xsl:with-param name="actingInPrivate" select="$actingInPrivate"/>
								<xsl:with-param name="isFirstRecursiveCallFromOutside" select="$isFirstRecursiveCallFromOutside"/>
								<xsl:with-param name="capacityAlredyPrinted" select="$capacityAlredyPrinted"/>
								<xsl:with-param name="shouldPrintRomanNumbers" select="$shouldPrintRomanNumbers"/>
								<xsl:with-param name="numberOfRelatedPersonsInAllManager" select="$numberOfRelatedPersonsInAllManager"/>
								<xsl:with-param name="recursiveCallOrdinalNumber" select="$recursiveCallOrdinalNumber + 1"/>
								<xsl:with-param name="personNumberingFormat" select="$personNumberingFormat"/>
							</xsl:apply-templates>
						</xsl:if>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<!-- When there is more than one warrantor represented by current one (in Hoedanigheid), list of them will follows -->
			<xsl:otherwise>
				<xsl:choose>
					<!-- In prive (voor zich) Hoedanigheid relation logic is possible only between bestuurder(s) and main NNP person -->
					<xsl:when test="$actingInPrivateCurrentlyProcessedHoedanigheid">
						<xsl:if test="$capacityVariantCurrentHoedaigheid = '1' or $capacityVariantCurrentHoedaigheid = '2' or $capacityVariantCurrentHoedaigheid = '3' or $capacityVariantCurrentHoedaigheid = '4' or $capacityVariantCurrentHoedaigheid = '5' or $capacityVariantCurrentHoedaigheid = '6' or $capacityVariantCurrentHoedaigheid = '7' or $capacityVariantCurrentHoedaigheid = '8' or $capacityVariantCurrentHoedaigheid = '10'">
							<xsl:text> </xsl:text>
							<xsl:apply-templates select="$currentlyProcessedHoedanigheid" mode="do-capacity-variant-for-legal-person">
								<xsl:with-param name="relatedPersons" select="$previousPersonsActingAsHoedanigheid"/>
							</xsl:apply-templates>
						</xsl:if>
						<xsl:text>:</xsl:text>
						<table cellspacing="0" cellpadding="0">
							<tbody>
								<xsl:for-each select="$currentlyProcessedHoedanigheid/tia:wordtVertegenwoordigdRef">
									<xsl:variable name="currentPersonId" select="."/>
									<xsl:variable name="currentlyProcessedPerson" select="$mainPerson/descendant-or-self::tia:IMKAD_Persoon[concat('#', @id) = $currentPersonId/@*[translate(local-name(), $upper, $lower) = 'href']]"/>
									<xsl:variable name="chosenNestingDepth">
										<xsl:choose>
											<xsl:when test="count($currentlyProcessedHoedanigheid/tia:wordtVertegenwoordigdRef) > 1">
												<xsl:value-of select="$nestingDepth + 1"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="$nestingDepth"/>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:variable>
									<tr>
										<td class="number" valign="top">
											<xsl:number value="position()" format="{$personNumberingFormat}"/>
											<xsl:text>.</xsl:text>
										</td>
										<td>
											<xsl:attribute name="class"><xsl:text>level</xsl:text><xsl:value-of select="$chosenNestingDepth"/></xsl:attribute>
											<xsl:apply-templates select="$currentlyProcessedPerson" mode="do-legal-person"/>
											<xsl:if test="normalize-space($currentlyProcessedPerson/tia:tia_AanduidingPersoon) != ''">
												<xsl:text>, hierna te noemen: </xsl:text>
												<xsl:value-of select="$currentlyProcessedPerson/tia:tia_AanduidingPersoon"/>
											</xsl:if>
											<xsl:if test="$isThereMoreHoedanigheidsToProcess = 'false' and $currentlyProcessedPerson/tia:IMKAD_PostlocatiePersoon">
												<xsl:text> (correspondentieadres voor alle aangelegenheden betreffende de hierna te vermelden rechtshandelingen: </xsl:text>
												<xsl:apply-templates select="$currentlyProcessedPerson/tia:IMKAD_PostlocatiePersoon" mode="do-correspondant-address"/>
												<xsl:text>)</xsl:text>
											</xsl:if>
											<xsl:choose>
												<xsl:when test="position() != last()">
													<xsl:text>; en</xsl:text>
												</xsl:when>
												<xsl:when test="position() = last()">
													<xsl:choose>
														<xsl:when test="$numberOfHoedanigheids > $processedHoedanigheidOrderNumber and $maximumNestingDepth > ($nestingDepth + 2)">
															<xsl:text>,</xsl:text>
														</xsl:when>
														<xsl:otherwise>
															<xsl:value-of select="$personTerminator"/>
														</xsl:otherwise>
													</xsl:choose>
												</xsl:when>
											</xsl:choose>
											<xsl:if test="position() = last()">
												<xsl:text> </xsl:text>
												<!-- Recursion continues -->
												<xsl:if test="$numberOfHoedanigheids > $processedHoedanigheidOrderNumber and $maximumNestingDepth > ($nestingDepth + 2)">
													<xsl:apply-templates select="$mainPerson" mode="do-party-legal-person-text-main-and-related-persons-warrantors-act-as-hoedanighied-for-each-other-next-representation">
														<xsl:with-param name="allHoedanigheids" select="$allHoedanigheids"/>
														<xsl:with-param name="processedHoedanigheidOrderNumber" select="$processedHoedanigheidOrderNumber + 1"/>
														<xsl:with-param name="personTerminator" select="$personTerminator"/>
														<xsl:with-param name="currentParty" select="$currentParty"/>
														<xsl:with-param name="formatOfFirstLevel" select="$formatOfFirstLevel"/>
														<xsl:with-param name="maximumNestingDepth" select="$maximumNestingDepth"/>
														<xsl:with-param name="nestingDepth" select="$chosenNestingDepth"/>
														<xsl:with-param name="actingInPrivate" select="$actingInPrivate"/>
														<xsl:with-param name="isFirstRecursiveCallFromOutside" select="$isFirstRecursiveCallFromOutside"/>
														<xsl:with-param name="capacityAlredyPrinted" select="$capacityAlredyPrinted"/>
														<xsl:with-param name="shouldPrintRomanNumbers" select="$shouldPrintRomanNumbers"/>
														<xsl:with-param name="numberOfRelatedPersonsInAllManager" select="$numberOfRelatedPersonsInAllManager"/>
														<xsl:with-param name="recursiveCallOrdinalNumber" select="$recursiveCallOrdinalNumber + 1"/>
														<xsl:with-param name="personNumberingFormat" select="$personNumberingFormat"/>
													</xsl:apply-templates>
												</xsl:if>
											</xsl:if>
										</td>
									</tr>
								</xsl:for-each>
							</tbody>
						</table>
					</xsl:when>
					<xsl:otherwise>
						<xsl:if test="not($capacityAlredyPrinted = 'true' and $isFirstRecursiveCallFromOutside = 'true' and $nestingDepth = 0 and $recursiveCallOrdinalNumber = 1)">
							<xsl:choose>
								<!-- Specific case when there is bestuurders with related partners/huisgenots which do not have reference toward hoedanigheid, but they need to be taken into account for representing -->
								<xsl:when test="$mainPerson/tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder'] and $isFirstRecursiveCallFromOutside = 'true' and $nestingDepth = 0 and $recursiveCallOrdinalNumber = 1">
									<xsl:apply-templates select="$currentlyProcessedHoedanigheid" mode="do-capacity-for-legal-person">
										<xsl:with-param name="relatedPersons" select="$mainPerson/descendant-or-self::tia:IMKAD_Persoon[parent::tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder' or translate(tia:rol, $upper, $lower) = 'partner'] or translate(tia:rol, $upper, $lower) = 'huisgenot']"/>
										<xsl:with-param name="shouldPrintColon" select="'false'"/>
									</xsl:apply-templates>
								</xsl:when>
								<xsl:otherwise>
									<xsl:apply-templates select="$currentlyProcessedHoedanigheid" mode="do-capacity-for-legal-person">
										<xsl:with-param name="relatedPersons" select="$previousPersonsActingAsHoedanigheid"/>
										<xsl:with-param name="shouldPrintColon" select="'false'"/>
									</xsl:apply-templates>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:if>
						<xsl:if test="$capacityVariantCurrentHoedaigheid = '1' or $capacityVariantCurrentHoedaigheid = '2' or $capacityVariantCurrentHoedaigheid = '3' or $capacityVariantCurrentHoedaigheid = '4' or $capacityVariantCurrentHoedaigheid = '5' or $capacityVariantCurrentHoedaigheid = '6' or $capacityVariantCurrentHoedaigheid = '7' or $capacityVariantCurrentHoedaigheid = '8' or $capacityVariantCurrentHoedaigheid = '10'">
							<xsl:text> </xsl:text>
							<xsl:apply-templates select="$currentlyProcessedHoedanigheid" mode="do-capacity-variant-for-legal-person">
								<xsl:with-param name="relatedPersons" select="$previousPersonsActingAsHoedanigheid"/>
							</xsl:apply-templates>
						</xsl:if>
						<xsl:text>:</xsl:text>
						<table cellspacing="0" cellpadding="0">
							<tbody>
								<xsl:for-each select="$currentlyProcessedHoedanigheid/tia:wordtVertegenwoordigdRef">
									<xsl:variable name="currentPersonId" select="."/>
									<xsl:variable name="currentlyProcessedPerson" select="$mainPerson/descendant-or-self::tia:IMKAD_Persoon[concat('#', @id) = $currentPersonId/@*[translate(local-name(), $upper, $lower) = 'href']]"/>
									<xsl:variable name="chosenNestingDepth">
										<xsl:choose>
											<xsl:when test="(count($currentlyProcessedHoedanigheid/tia:wordtVertegenwoordigdRef) > 1 and $actingInPrivate = 'true')
															or $numberOfRelatedPersonsInAllManager > 1 and $nestingDepth > 0 and $isFirstRecursiveCallFromOutside = 'true' and $actingInPrivate = 'false'">
												<xsl:value-of select="$nestingDepth + 1"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="$nestingDepth"/>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:variable>
									<tr>
										<xsl:if test="$numberOfRelatedPersonsInAllManager > 1 and $nestingDepth = 0 and $isFirstRecursiveCallFromOutside = 'true' and $actingInPrivate = 'false'">
											<td class="number" valign="top">
												<xsl:text>&#xFEFF;</xsl:text>
											</td>
										</xsl:if>
										<td class="number" valign="top">
											<xsl:choose>
												<xsl:when test="$nestingDepth = 0 and $isFirstRecursiveCallFromOutside = 'true' and $shouldPrintRomanNumbers = 'true'">
													<xsl:number value="position()" format="I"/>
												</xsl:when>
												<xsl:otherwise>
													<xsl:choose>
														<xsl:when test="$actingInPrivate = 'true' or $shouldPrintRomanNumbers = 'true'">
															<xsl:choose>
																<xsl:when test="($nestingDepth + 1) mod 2 = 0">
																	<xsl:number value="position()" format="{$personNumberingFormat}"/>
																</xsl:when>
																<xsl:otherwise>
																	<xsl:number value="position()" format="{translate($personNumberingFormat, '1a', 'a1')}"/>
																</xsl:otherwise>
															</xsl:choose>
														</xsl:when>
														<xsl:otherwise>
															<xsl:choose>
																<xsl:when test="($nestingDepth + 1) mod 2 = 0">
																	<xsl:number value="position()" format="{translate($formatOfFirstLevel, '1a', 'a1')}"/>
																</xsl:when>
																<xsl:otherwise>
																	<xsl:number value="position()" format="{$formatOfFirstLevel}"/>
																</xsl:otherwise>
															</xsl:choose>
														</xsl:otherwise>
													</xsl:choose>
												</xsl:otherwise>
											</xsl:choose>
											<xsl:text>.</xsl:text>
										</td>
										<td>
											<xsl:attribute name="class"><xsl:text>level</xsl:text><xsl:value-of select="$chosenNestingDepth"/></xsl:attribute>
											<xsl:apply-templates select="$currentlyProcessedPerson" mode="do-legal-person"/>
											<xsl:if test="normalize-space($currentlyProcessedPerson/tia:tia_AanduidingPersoon) != ''">
												<xsl:text>, hierna te noemen: </xsl:text>
												<xsl:value-of select="$currentlyProcessedPerson/tia:tia_AanduidingPersoon"/>
											</xsl:if>
											<xsl:if test="$isThereMoreHoedanigheidsToProcess = 'false' and $currentlyProcessedPerson/tia:IMKAD_PostlocatiePersoon">
												<xsl:text> (correspondentieadres voor alle aangelegenheden betreffende de hierna te vermelden rechtshandelingen: </xsl:text>
												<xsl:apply-templates select="$currentlyProcessedPerson/tia:IMKAD_PostlocatiePersoon" mode="do-correspondant-address"/>
												<xsl:text>)</xsl:text>
											</xsl:if>
											<xsl:choose>
												<xsl:when test="position() != last()">
													<xsl:text>; en</xsl:text>
												</xsl:when>
												<xsl:when test="position() = last()">
													<xsl:choose>
														<xsl:when test="$numberOfHoedanigheids > $processedHoedanigheidOrderNumber and $maximumNestingDepth > ($nestingDepth + 1)">
															<xsl:text>,</xsl:text>
														</xsl:when>
														<xsl:otherwise>
															<xsl:value-of select="$personTerminator"/>
														</xsl:otherwise>
													</xsl:choose>
												</xsl:when>
											</xsl:choose>
											<xsl:if test="position() = last()">
												<xsl:text> </xsl:text>
												<!-- Recursion continues -->
												<xsl:if test="$numberOfHoedanigheids > $processedHoedanigheidOrderNumber and $maximumNestingDepth > ($nestingDepth + 1)">
													<xsl:apply-templates select="$mainPerson" mode="do-party-legal-person-text-main-and-related-persons-warrantors-act-as-hoedanighied-for-each-other-next-representation">
														<xsl:with-param name="allHoedanigheids" select="$allHoedanigheids"/>
														<xsl:with-param name="processedHoedanigheidOrderNumber" select="$processedHoedanigheidOrderNumber + 1"/>
														<xsl:with-param name="personTerminator" select="$personTerminator"/>
														<xsl:with-param name="currentParty" select="$currentParty"/>
														<xsl:with-param name="formatOfFirstLevel" select="$formatOfFirstLevel"/>
														<xsl:with-param name="maximumNestingDepth" select="$maximumNestingDepth"/>
														<xsl:with-param name="nestingDepth" select="$nestingDepth + 1"/>
														<xsl:with-param name="actingInPrivate" select="$actingInPrivate"/>
														<xsl:with-param name="isFirstRecursiveCallFromOutside" select="$isFirstRecursiveCallFromOutside"/>
														<xsl:with-param name="capacityAlredyPrinted" select="$capacityAlredyPrinted"/>
														<xsl:with-param name="shouldPrintRomanNumbers" select="$shouldPrintRomanNumbers"/>
														<xsl:with-param name="numberOfRelatedPersonsInAllManager" select="$numberOfRelatedPersonsInAllManager"/>
														<xsl:with-param name="recursiveCallOrdinalNumber" select="$recursiveCallOrdinalNumber + 1"/>
														<xsl:with-param name="personNumberingFormat" select="$personNumberingFormat"/>
													</xsl:apply-templates>
												</xsl:if>
											</xsl:if>
										</td>
									</tr>
								</xsl:for-each>
							</tbody>
						</table>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--
	***************************************************************************************************************************
	Mode: do-party-legal-person-text-main-and-related-persons-all-warrantors-represented-by-main-person
	***************************************************************************************************************************
	Public: no

	Identity transform: no

	Description: Handles the situation when main person in PNNP represents all related wolmachtgever persons in Hooedanigheid.

	Input: tia:IMKAD_Persoon

	Params: mainPersonRepresentedInHoedanigheid - Hoedanigheid which contains reference to main person
			capacityVariantCurrentPerson - variant of Hoedanigheid in main NNP
			relatedPersons - persons acting in hoedanigheid for currently processed one
			personTerminator - character that is printed at the end of each person's block
			capacityAlredyPrinted - determines if capacity text is allready printed prior to this template calling
			numberOfWarrantors - number of warrantor persons in currently processed PNNP
			capacityVariantFirstWarrantor - variant of Hoedanigheid in first related NNP (warrantor)
			firstWarrantorRepresentedInHoedanigheid - Hoedanigheid which contains reference to first warrantor
			firstWarrantor - variable which represents first related NNP (warrantor)
			actingInPrivate - determines whether main NNP is represented in 'in prive' type of Hoedanigheid representation
			numberOfManagers - number of managers (bestuurders)
			numberOfRelatedPersonsInAllManager - total number of related persons in all managers
			onlyPersonWithBulletInParty - indicator if this is only bulleted person in party
			formatOfFirstLevel - format of first nesting level, could be either 'a' or '1'
			skipPartyNumberColumn - indicator if party number column should not be printed ('false' is default)
			personNumberingFormat - first level person numbering format ('a' is default)

	Output: text

	Calls:
	(mode) do-capacity-for-legal-person
	(mode) do-capacity-variant-for-legal-person
	(mode) do-correspondant-address
	(mode) do-legal-person

	Called by:
	(mode) do-party-legal-person-text-main-and-related-persons
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon" mode="do-party-legal-person-text-main-and-related-persons-all-warrantors-represented-by-main-person">
		<xsl:param name="mainPersonRepresentedInHoedanigheid" select="self::node()[false()]"/>
		<xsl:param name="capacityVariantCurrentPerson" select="number('0')"/>
		<xsl:param name="relatedPersons" select="self::node()[false()]"/>
		<xsl:param name="personTerminator" select="';'"/>
		<xsl:param name="capacityAlredyPrinted" select="'false'"/>
		<xsl:param name="numberOfWarrantors" select="number('0')"/>
		<xsl:param name="capacityVariantFirstWarrantor" select="number('0')"/>
		<xsl:param name="firstWarrantorRepresentedInHoedanigheid" select="self::node()[false()]"/>
		<xsl:param name="firstWarrantor" select="self::node()[false()]"/>
		<xsl:param name="actingInPrivate" select="'false'"/>
		<xsl:param name="numberOfManagers" select="number('0')"/>
		<xsl:param name="numberOfRelatedPersonsInAllManager" select="number('0')"/>
		<xsl:param name="onlyPersonWithBulletInParty" select="'false'"/>
		<xsl:param name="formatOfFirstLevel"/>
		<xsl:param name="skipPartyNumberColumn" select="'false'"/>
		<xsl:param name="personNumberingFormat" select="'a'"/>
		<xsl:variable name="mainPerson" select="."/>
		<xsl:variable name="actingInPrivateFirstVolmachtgever" select="$firstWarrantorRepresentedInHoedanigheid/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvoorzich']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
						translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvoorzich']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
						translate(normalize-space($firstWarrantorRepresentedInHoedanigheid/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvoorzich']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
		<xsl:variable name="actingInPrivateMainPerson" select="$mainPersonRepresentedInHoedanigheid/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvoorzich']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
						translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvoorzich']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
						translate(normalize-space($mainPersonRepresentedInHoedanigheid/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvoorzich']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
		<xsl:variable name="shouldPrintColonBeforeFirstWarrantor">
			<xsl:choose>
				<xsl:when test="$numberOfWarrantors = 1">
					<xsl:text>false</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>true</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:if test="$capacityAlredyPrinted = 'false'">
			<xsl:apply-templates select="$mainPersonRepresentedInHoedanigheid" mode="do-capacity-for-legal-person">
				<xsl:with-param name="relatedPersons" select="$relatedPersons"/>
				<xsl:with-param name="shouldPrintColon" select="'false'"/>
			</xsl:apply-templates>
		</xsl:if>
		<xsl:if test="$capacityVariantCurrentPerson = '1' or $capacityVariantCurrentPerson = '2' or $capacityVariantCurrentPerson = '3' or $capacityVariantCurrentPerson = '4' or $capacityVariantCurrentPerson = '5' or $capacityVariantCurrentPerson = '6' or $capacityVariantCurrentPerson = '7' or $capacityVariantCurrentPerson = '8' or $capacityVariantCurrentPerson = '10'">
			<xsl:text> </xsl:text>
			<xsl:apply-templates select="$mainPersonRepresentedInHoedanigheid" mode="do-capacity-variant-for-legal-person">
				<xsl:with-param name="relatedPersons" select="$relatedPersons"/>
			</xsl:apply-templates>
		</xsl:if>
		<xsl:text> </xsl:text>
		<xsl:apply-templates select="." mode="do-legal-person"/>
		<xsl:if test="normalize-space(tia:tia_AanduidingPersoon) != ''">
			<xsl:text>, hierna te noemen: </xsl:text>
			<xsl:value-of select="tia:tia_AanduidingPersoon"/>
		</xsl:if>
		<xsl:if test="tia:IMKAD_PostlocatiePersoon">
			<xsl:text> (correspondentieadres voor alle aangelegenheden betreffende de hierna te vermelden rechtshandelingen: </xsl:text>
			<xsl:apply-templates select="tia:IMKAD_PostlocatiePersoon" mode="do-correspondant-address"/>
			<xsl:text>)</xsl:text>
		</xsl:if>
		<xsl:text>, </xsl:text>
		<xsl:apply-templates select="$firstWarrantorRepresentedInHoedanigheid" mode="do-capacity-for-legal-person">
			<xsl:with-param name="relatedPersons" select="."/>
			<xsl:with-param name="shouldPrintColon" select="'false'"/>
		</xsl:apply-templates>
		<xsl:if test="not($actingInPrivateFirstVolmachtgever) and $capacityVariantFirstWarrantor = '1' or $capacityVariantFirstWarrantor = '2' or $capacityVariantFirstWarrantor = '3' or $capacityVariantFirstWarrantor = '4' or $capacityVariantFirstWarrantor = '5' or $capacityVariantFirstWarrantor = '6' or $capacityVariantFirstWarrantor = '7' or $capacityVariantFirstWarrantor = '8' or $capacityVariantFirstWarrantor = '10'">
			<xsl:text> </xsl:text>
			<xsl:apply-templates select="$firstWarrantorRepresentedInHoedanigheid" mode="do-capacity-variant-for-legal-person">
				<xsl:with-param name="relatedPersons" select="."/>
			</xsl:apply-templates>
		</xsl:if>
		<xsl:choose>
			<xsl:when test="$numberOfWarrantors = 1">
				<xsl:choose>
					<xsl:when test="$actingInPrivateFirstVolmachtgever">
						<xsl:text>:</xsl:text>
						<table cellspacing="0" cellpadding="0">
							<tbody>
								<tr>
									<td class="number" valign="top">
										<xsl:number value="1" format="I"/>
										<xsl:text>.</xsl:text>
									</td>
									<td>
										<xsl:attribute name="class"><xsl:text>level2</xsl:text></xsl:attribute>
										<xsl:value-of select="$actingInPrivateFirstVolmachtgever"/>
									</td>
								</tr>
								<tr>
									<td class="number" valign="top">
										<xsl:number value="2" format="I"/>
										<xsl:text>.</xsl:text>
									</td>
									<td>
										<xsl:attribute name="class"><xsl:text>level2</xsl:text></xsl:attribute>
										<xsl:if test="$capacityVariantFirstWarrantor = '1' or $capacityVariantFirstWarrantor = '2' or $capacityVariantFirstWarrantor = '3' or $capacityVariantFirstWarrantor = '4' or $capacityVariantFirstWarrantor = '5' or $capacityVariantFirstWarrantor = '6' or $capacityVariantFirstWarrantor = '7' or $capacityVariantFirstWarrantor = '8' or $capacityVariantFirstWarrantor = '10'">
											<xsl:apply-templates select="$firstWarrantorRepresentedInHoedanigheid" mode="do-capacity-variant-for-legal-person">
												<xsl:with-param name="relatedPersons" select="."/>
											</xsl:apply-templates>
										</xsl:if>
										<xsl:text> </xsl:text>
										<xsl:apply-templates select="$firstWarrantor" mode="do-legal-person"/>
										<xsl:if test="normalize-space($firstWarrantor/tia:tia_AanduidingPersoon) != ''">
											<xsl:text>, hierna te noemen: </xsl:text>
											<xsl:value-of select="$firstWarrantor/tia:tia_AanduidingPersoon"/>
										</xsl:if>
										<xsl:if test="$firstWarrantor/tia:IMKAD_PostlocatiePersoon">
											<xsl:text> (correspondentieadres voor alle aangelegenheden betreffende de hierna te vermelden rechtshandelingen: </xsl:text>
											<xsl:apply-templates select="$firstWarrantor/tia:IMKAD_PostlocatiePersoon" mode="do-correspondant-address"/>
											<xsl:text>)</xsl:text>
										</xsl:if>
										<xsl:value-of select="$personTerminator"/>
									</td>
								</tr>
							</tbody>
						</table>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text> </xsl:text>
						<xsl:apply-templates select="$firstWarrantor" mode="do-legal-person"/>
						<xsl:if test="normalize-space($firstWarrantor/tia:tia_AanduidingPersoon) != ''">
							<xsl:text>, hierna te noemen: </xsl:text>
							<xsl:value-of select="$firstWarrantor/tia:tia_AanduidingPersoon"/>
						</xsl:if>
						<xsl:if test="$firstWarrantor/tia:IMKAD_PostlocatiePersoon">
							<xsl:text> (correspondentieadres voor alle aangelegenheden betreffende de hierna te vermelden rechtshandelingen: </xsl:text>
							<xsl:apply-templates select="$firstWarrantor/tia:IMKAD_PostlocatiePersoon" mode="do-correspondant-address"/>
							<xsl:text>)</xsl:text>
						</xsl:if>
						<xsl:value-of select="$personTerminator"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>:</xsl:text>
				<table cellspacing="0" cellpadding="0">
					<tbody>
						<xsl:if test="$actingInPrivateFirstVolmachtgever">
							<tr>
								<td class="number" valign="top">
									<xsl:number value="1" format="I"/>
									<xsl:text>.</xsl:text>
								</td>
								<td>
									<xsl:choose>
										<xsl:when test="$actingInPrivateMainPerson and $numberOfManagers = 1 and $numberOfRelatedPersonsInAllManager >= 1 and $onlyPersonWithBulletInParty = 'false'">
											<xsl:attribute name="class"><xsl:text>level2</xsl:text></xsl:attribute>
										</xsl:when>
										<xsl:when test="$actingInPrivateMainPerson or ($numberOfManagers = 1 and $numberOfRelatedPersonsInAllManager = 1 and $onlyPersonWithBulletInParty = 'false')">
											<xsl:attribute name="class"><xsl:text>level1</xsl:text></xsl:attribute>
										</xsl:when>
										<xsl:otherwise>
											<xsl:attribute name="class"><xsl:text>level0</xsl:text></xsl:attribute>
										</xsl:otherwise>
									</xsl:choose>
									<xsl:value-of select="$actingInPrivateFirstVolmachtgever"/>
								</td>
							</tr>
						</xsl:if>
						<tr>
							<xsl:if test="not($actingInPrivateFirstVolmachtgever) and not($numberOfManagers = 1 and $numberOfRelatedPersonsInAllManager = 1)">
								<td class="number" valign="top">
									<xsl:text>&#xFEFF;</xsl:text>
								</td>
							</xsl:if>
							<td class="number" valign="top">
								<xsl:choose>
									<xsl:when test="$actingInPrivateFirstVolmachtgever">
										<xsl:number value="2" format="I"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:number value="1" format="{$formatOfFirstLevel}"/>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:text>.</xsl:text>
							</td>
							<td>
								<xsl:choose>
									<xsl:when test="$actingInPrivateMainPerson and $numberOfManagers = 1 and $numberOfRelatedPersonsInAllManager >= 1 and $onlyPersonWithBulletInParty = 'false'">
										<xsl:attribute name="class"><xsl:text>level2</xsl:text></xsl:attribute>
									</xsl:when>
									<xsl:when test="$actingInPrivateMainPerson or ($numberOfManagers = 1 and $numberOfRelatedPersonsInAllManager = 1 and $onlyPersonWithBulletInParty = 'false')">
										<xsl:attribute name="class"><xsl:text>level1</xsl:text></xsl:attribute>
									</xsl:when>
									<xsl:otherwise>
										<xsl:attribute name="class"><xsl:text>level0</xsl:text></xsl:attribute>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:choose>
									<xsl:when test="$actingInPrivateFirstVolmachtgever">
										<xsl:if test="$capacityVariantFirstWarrantor = '1' or $capacityVariantFirstWarrantor = '2' or $capacityVariantFirstWarrantor = '3' or $capacityVariantFirstWarrantor = '4' or $capacityVariantFirstWarrantor = '5' or $capacityVariantFirstWarrantor = '6' or $capacityVariantFirstWarrantor = '7' or $capacityVariantFirstWarrantor = '8' or $capacityVariantFirstWarrantor = '10'">
											<xsl:apply-templates select="$firstWarrantorRepresentedInHoedanigheid" mode="do-capacity-variant-for-legal-person">
												<xsl:with-param name="relatedPersons" select="."/>
											</xsl:apply-templates>
										</xsl:if>
										<xsl:text>:</xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:apply-templates select="$firstWarrantor" mode="do-legal-person"/>
										<xsl:if test="normalize-space($firstWarrantor/tia:tia_AanduidingPersoon) != ''">
											<xsl:text>, hierna te noemen: </xsl:text>
											<xsl:value-of select="$firstWarrantor/tia:tia_AanduidingPersoon"/>
										</xsl:if>
										<xsl:text>; en</xsl:text>
									</xsl:otherwise>
								</xsl:choose>
							</td>
						</tr>
						<xsl:choose>
							<xsl:when test="$actingInPrivateFirstVolmachtgever">
								<tr>
									<xsl:if test="not($skipPartyNumberColumn = 'true')">
										<td class="number" valign="top">
											<xsl:text>&#xFEFF;</xsl:text>
										</td>
									</xsl:if>
									<td>
										<table cellspacing="0" cellpadding="0">
											<tbody>
												<xsl:for-each select="tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'volmachtgever']">
													<tr>
														<td class="number" valign="top">
															<xsl:number value="position()" format="{$personNumberingFormat}"/>
															<xsl:text>.</xsl:text>
														</td>
														<td>
															<xsl:choose>
																<xsl:when test="$onlyPersonWithBulletInParty = 'false'">
																	<xsl:attribute name="class"><xsl:text>level2</xsl:text></xsl:attribute>
																</xsl:when>
																<xsl:otherwise>
																	<xsl:attribute name="class"><xsl:text>level1</xsl:text></xsl:attribute>
																</xsl:otherwise>
															</xsl:choose>
															<xsl:apply-templates select="tia:IMKAD_Persoon" mode="do-legal-person"/>
															<xsl:if test="normalize-space(tia:IMKAD_Persoon/tia:tia_AanduidingPersoon) != ''">
																<xsl:text>, hierna te noemen: </xsl:text>
																<xsl:value-of select="tia:IMKAD_Persoon/tia:tia_AanduidingPersoon"/>
															</xsl:if>
															<xsl:if test="tia:IMKAD_Persoon/tia:IMKAD_PostlocatiePersoon">
																<xsl:text> (correspondentieadres voor alle aangelegenheden betreffende de hierna te vermelden rechtshandelingen: </xsl:text>
																<xsl:apply-templates select="tia:IMKAD_Persoon/tia:IMKAD_PostlocatiePersoon" mode="do-correspondant-address"/>
																<xsl:text>)</xsl:text>
															</xsl:if>
															<xsl:choose>
																<xsl:when test="position() != last()">
																	<xsl:text>; en</xsl:text>
																</xsl:when>
																<xsl:when test="position() = last()">
																	<xsl:value-of select="$personTerminator"/>
																</xsl:when>
															</xsl:choose>
														</td>
													</tr>
												</xsl:for-each>
											</tbody>
										</table>
									</td>
								</tr>
							</xsl:when>
							<xsl:otherwise>
								<xsl:for-each select="tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'volmachtgever']">
									<xsl:if test="position() != 1">
										<tr>
											<xsl:if test="not($actingInPrivateFirstVolmachtgever) and not($numberOfManagers = 1 and $numberOfRelatedPersonsInAllManager = 1)">
												<td class="number" valign="top">
													<xsl:text>&#xFEFF;</xsl:text>
												</td>
											</xsl:if>
											<td class="number" valign="top">
												<xsl:number value="position()" format="{$formatOfFirstLevel}"/>
												<xsl:text>.</xsl:text>
											</td>
											<td class="level1">
												<xsl:apply-templates select="tia:IMKAD_Persoon" mode="do-legal-person"/>
												<xsl:if test="normalize-space(tia:IMKAD_Persoon/tia:tia_AanduidingPersoon) != ''">
													<xsl:text>, hierna te noemen: </xsl:text>
													<xsl:value-of select="tia:IMKAD_Persoon/tia:tia_AanduidingPersoon"/>
												</xsl:if>
												<xsl:if test="tia:IMKAD_Persoon/tia:IMKAD_PostlocatiePersoon">
													<xsl:text> (correspondentieadres voor alle aangelegenheden betreffende de hierna te vermelden rechtshandelingen: </xsl:text>
													<xsl:apply-templates select="tia:IMKAD_Persoon/tia:IMKAD_PostlocatiePersoon" mode="do-correspondant-address"/>
													<xsl:text>)</xsl:text>
												</xsl:if>
												<xsl:choose>
													<xsl:when test="position() != last()">
														<xsl:text>; en</xsl:text>
													</xsl:when>
													<xsl:when test="position() = last()">
														<xsl:value-of select="$personTerminator"/>
													</xsl:when>
												</xsl:choose>
											</td>
										</tr>
									</xsl:if>
								</xsl:for-each>
							</xsl:otherwise>
						</xsl:choose>
					</tbody>
				</table>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--
	***************************************************************************************************************************
	Mode: do-party-legal-person-text-main-and-related-persons-all-warrantors-and-main-person-represented-by-manager
	***************************************************************************************************************************
	Public: no

	Identity transform: no

	Description: Handles the situation when main person in PNNP and all related wolmachtgever persons are represented in Hoedanigheid by bestuurder(s).

	Input: tia:IMKAD_Persoon

	Params: mainPersonRepresentedInHoedanigheid - Hoedanigheid which contains reference to main person
			capacityVariantCurrentPerson - variant of Hoedanigheid in main NNP
			relatedPersons - persons acting in hoedanigheid for currently processed one
			personTerminator - character that is printed at the end of each person's block
			capacityAlredyPrinted - determines if capacity text is allready printed prior to this template calling
			numberOfManagers - number of managers (bestuurders)
			numberOfRelatedPersonsInAllManager - total number of related persons in all managers
			onlyPersonWithBulletInParty - indicator if this is only bulleted person in party
			actingInPrivate - determines whether main NNP is represented in 'in prive' type of Hoedanigheid representation
			formatOfFirstLevel - format of first nesting level, could be either 'a' or '1'
			personNumberingFormat - first level person numbering format ('a' is default)

	Output: text

	Calls:
	(mode) do-capacity-for-legal-person
	(mode) do-capacity-variant-for-legal-person
	(mode) do-correspondant-address
	(mode) do-legal-person

	Called by:
	(mode) do-party-legal-person-text-main-and-related-persons
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon" mode="do-party-legal-person-text-main-and-related-persons-all-warrantors-and-main-person-represented-by-manager">
		<xsl:param name="mainPersonRepresentedInHoedanigheid" select="self::node()[false()]"/>
		<xsl:param name="capacityVariantCurrentPerson" select="number('0')"/>
		<xsl:param name="relatedPersons" select="self::node()[false()]"/>
		<xsl:param name="personTerminator" select="';'"/>
		<xsl:param name="capacityAlredyPrinted" select="'false'"/>
		<xsl:param name="numberOfManagers" select="number('0')"/>
		<xsl:param name="numberOfRelatedPersonsInAllManager" select="number('0')"/>
		<xsl:param name="onlyPersonWithBulletInParty" select="'false'"/>
		<xsl:param name="actingInPrivate" select="'false'"/>
		<xsl:param name="formatOfFirstLevel"/>
		<xsl:param name="personNumberingFormat" select="'a'"/>
		<xsl:variable name="mainPerson" select="."/>
		<xsl:variable name="shouldPrintRomanNumbers">
			<xsl:choose>
				<xsl:when test="$numberOfRelatedPersonsInAllManager > 1 and $actingInPrivate = 'false'">
					<xsl:text>true</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>false</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:if test="$capacityAlredyPrinted = 'false'">
			<xsl:apply-templates select="$mainPersonRepresentedInHoedanigheid" mode="do-capacity-for-legal-person">
				<xsl:with-param name="relatedPersons" select="$relatedPersons"/>
				<xsl:with-param name="shouldPrintColon" select="'false'"/>
			</xsl:apply-templates>
		</xsl:if>
		<xsl:if test="$capacityVariantCurrentPerson = '1' or $capacityVariantCurrentPerson = '2' or $capacityVariantCurrentPerson = '3' or $capacityVariantCurrentPerson = '4' or $capacityVariantCurrentPerson = '5' or $capacityVariantCurrentPerson = '6' or $capacityVariantCurrentPerson = '7' or $capacityVariantCurrentPerson = '8' or $capacityVariantCurrentPerson = '10'">
			<xsl:text> </xsl:text>
			<xsl:apply-templates select="$mainPersonRepresentedInHoedanigheid" mode="do-capacity-variant-for-legal-person">
				<xsl:with-param name="relatedPersons" select="$relatedPersons"/>
			</xsl:apply-templates>
		</xsl:if>
		<xsl:text>:</xsl:text>
		<table cellspacing="0" cellpadding="0">
			<tbody>
				<tr>
					<xsl:if test="$actingInPrivate = 'false' and not($numberOfManagers = 1 and $numberOfRelatedPersonsInAllManager = 1)">
						<td class="number" valign="top">
							<xsl:text>&#xFEFF;</xsl:text>
						</td>
					</xsl:if>
					<td class="number" valign="top">
						<xsl:choose>
							<xsl:when test="$shouldPrintRomanNumbers = 'true'">
								<xsl:number value="1" format="I"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:choose>
									<xsl:when test="$actingInPrivate = 'true'">
										<xsl:number value="1" format="{$personNumberingFormat}"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:number value="1" format="{$formatOfFirstLevel}"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:text>.</xsl:text>
					</td>
					<td>
						<xsl:choose>
							<xsl:when test="$actingInPrivate = 'true' and $numberOfManagers = 1 and $numberOfRelatedPersonsInAllManager != 1 and $onlyPersonWithBulletInParty = 'false'">
								<xsl:attribute name="class"><xsl:text>level2</xsl:text></xsl:attribute>
							</xsl:when>
							<xsl:when test="$actingInPrivate = 'true' or ($numberOfManagers = 1 and $numberOfRelatedPersonsInAllManager != 1 and $onlyPersonWithBulletInParty = 'false')">
								<xsl:attribute name="class"><xsl:text>level1</xsl:text></xsl:attribute>
							</xsl:when>
							<xsl:otherwise>
								<xsl:attribute name="class"><xsl:text>level0</xsl:text></xsl:attribute>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:apply-templates select="." mode="do-legal-person"/>
						<xsl:if test="normalize-space(tia:tia_AanduidingPersoon) != ''">
							<xsl:text>, hierna te noemen: </xsl:text>
							<xsl:value-of select="tia:tia_AanduidingPersoon"/>
						</xsl:if>
						<xsl:text>; en</xsl:text>
					</td>
				</tr>
				<xsl:for-each select="tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'volmachtgever']">
					<tr>
						<xsl:if test="$actingInPrivate = 'false' and not($numberOfManagers = 1 and $numberOfRelatedPersonsInAllManager = 1)">
							<td class="number" valign="top">
								<xsl:text>&#xFEFF;</xsl:text>
							</td>
						</xsl:if>
						<td class="number" valign="top">
							<xsl:choose>
								<xsl:when test="$shouldPrintRomanNumbers = 'true'">
									<xsl:number value="position() + 1" format="I"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:choose>
										<xsl:when test="$actingInPrivate = 'true'">
											<xsl:number value="position() + 1" format="{$personNumberingFormat}"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:number value="position() + 1" format="{$formatOfFirstLevel}"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:text>.</xsl:text>
						</td>
						<td>
							<xsl:choose>
								<xsl:when test="$actingInPrivate = 'true'">
									<xsl:attribute name="class"><xsl:text>level2</xsl:text></xsl:attribute>
								</xsl:when>
								<xsl:otherwise>
									<xsl:attribute name="class"><xsl:text>level1</xsl:text></xsl:attribute>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:apply-templates select="tia:IMKAD_Persoon" mode="do-legal-person"/>
							<xsl:if test="normalize-space(tia:IMKAD_Persoon/tia:tia_AanduidingPersoon) != ''">
								<xsl:text>, hierna te noemen: </xsl:text>
								<xsl:value-of select="tia:IMKAD_Persoon/tia:tia_AanduidingPersoon"/>
							</xsl:if>
							<xsl:if test="tia:IMKAD_Persoon/tia:IMKAD_PostlocatiePersoon">
								<xsl:text> (correspondentieadres voor alle aangelegenheden betreffende de hierna te vermelden rechtshandelingen: </xsl:text>
								<xsl:apply-templates select="tia:IMKAD_Persoon/tia:IMKAD_PostlocatiePersoon" mode="do-correspondant-address"/>
								<xsl:text>)</xsl:text>
							</xsl:if>
							<xsl:choose>
								<xsl:when test="position() != last()">
									<xsl:text>; en</xsl:text>
								</xsl:when>
								<xsl:when test="position() = last()">
									<xsl:value-of select="$personTerminator"/>
								</xsl:when>
							</xsl:choose>
						</td>
					</tr>
				</xsl:for-each>
			</tbody>
		</table>
	</xsl:template>
	<!--
	***************************************************************************************************************************
	Mode: do-party-legal-person-text-main-and-related-persons-without-warrantors
	***************************************************************************************************************************
	Public: no

	Identity transform: no

	Description: Handles the situation when main person in PNNP is represented in Hoedanigheid by either preceding PNNP persons, Gevolmachtigde or bestuurder(s), and doesn't contain volmachtgevers (warrantors) at all.

	Input: tia:IMKAD_Persoon

	Params: mainPersonRepresentedInHoedanigheid - Hoedanigheid which contains reference to main person
			capacityVariantCurrentPerson - variant of Hoedanigheid in main NNP
			relatedPersons - persons acting in hoedanigheid for currently processed one
			personTerminator - character that is printed at the end of each person's block
			capacityAlredyPrinted - determines if capacity text is allready printed prior to this template calling
			actingInPrivate - determines whether main NNP is represented in 'in prive' type of Hoedanigheid representation
			representedByPreviousPerson - indicator if PNNP is represented by preceding PNNP persons

	Output: text

	Calls:
	(mode) do-capacity-for-legal-person
	(mode) do-capacity-variant-for-legal-person
	(mode) do-correspondant-address
	(mode) do-legal-person

	Called by:
	(mode) do-party-legal-person-text-main-and-related-persons
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon" mode="do-party-legal-person-text-main-and-related-persons-without-warrantors">
		<xsl:param name="mainPersonRepresentedInHoedanigheid" select="self::node()[false()]"/>
		<xsl:param name="capacityVariantCurrentPerson" select="number('0')"/>
		<xsl:param name="relatedPersons" select="self::node()[false()]"/>
		<xsl:param name="personTerminator" select="';'"/>
		<xsl:param name="capacityAlredyPrinted" select="'false'"/>
		<xsl:param name="actingInPrivate" select="'false'"/>
		<xsl:param name="representedByPreviousPerson" select="'false'"/>
		<xsl:if test="$capacityAlredyPrinted = 'false'">
			<xsl:apply-templates select="$mainPersonRepresentedInHoedanigheid" mode="do-capacity-for-legal-person">
				<xsl:with-param name="relatedPersons" select="$relatedPersons"/>
				<xsl:with-param name="shouldPrintColon" select="'false'"/>
				<xsl:with-param name="representedByPreviousPerson" select="$representedByPreviousPerson"/>
			</xsl:apply-templates>
		</xsl:if>
		<xsl:if test="$capacityVariantCurrentPerson = '1' or $capacityVariantCurrentPerson = '2' or $capacityVariantCurrentPerson = '3' or $capacityVariantCurrentPerson = '4' or $capacityVariantCurrentPerson = '5' or $capacityVariantCurrentPerson = '6' or $capacityVariantCurrentPerson = '7' or $capacityVariantCurrentPerson = '8' or $capacityVariantCurrentPerson = '10'">
			<xsl:text> </xsl:text>
			<xsl:apply-templates select="$mainPersonRepresentedInHoedanigheid" mode="do-capacity-variant-for-legal-person">
				<xsl:with-param name="relatedPersons" select="$relatedPersons"/>
			</xsl:apply-templates>
		</xsl:if>
		<xsl:text> </xsl:text>
		<xsl:apply-templates select="." mode="do-legal-person"/>
		<xsl:if test="normalize-space(tia:tia_AanduidingPersoon) != ''">
			<xsl:text>, hierna te noemen: </xsl:text>
			<xsl:value-of select="tia:tia_AanduidingPersoon"/>
		</xsl:if>
		<xsl:if test="tia:IMKAD_PostlocatiePersoon">
			<xsl:text> (correspondentieadres voor alle aangelegenheden betreffende de hierna te vermelden rechtshandelingen: </xsl:text>
			<xsl:apply-templates select="tia:IMKAD_PostlocatiePersoon" mode="do-correspondant-address"/>
			<xsl:text>)</xsl:text>
		</xsl:if>
		<xsl:value-of select="$personTerminator"/>
	</xsl:template>
	<!--
	***************************************************************************************************************************
	Mode: do-party-legal-person-text-main-and-related-persons-warrantors-and-main-person-represented-in-groups-by-managers
	***************************************************************************************************************************
	Public: no

	Identity transform: no

	Description: Handles the situation when main person in PNNP and all related wolmachtgever persons are represented in Hoedanigheid by bestuurder(s), in several groups.
				 Each group of persons is represented in it's own Hoedanigheid, meaning that bestuurder(s) represents persons in several different Hoedanigheids.

	Input: tia:IMKAD_Persoon

	Params: mainPersonRepresentedInHoedanigheid - Hoedanigheid which contains reference to main person
			firstWarrantorRepresentedInHoedanigheid - Hoedanigheid which contains reference to first warrantor
			capacityVariantCurrentPerson - variant of Hoedanigheid in main NNP
			capacityFirstWarrantor - indicator if first related NNP (warrantor) contains Hoedanigheid data
			capacityVariantFirstWarrantor - variant of Hoedanigheid in first related NNP (warrantor)
			firstWarrantor - variable which represents first related NNP (warrantor)
			haveWarrantors - indicator if main NNP contains related one(s)
			relatedPersons - persons acting in hoedanigheid for currently processed one
			personTerminator - character that is printed at the end of each person's block
			capacityAlredyPrinted - indicator if capacity text is already printed
			onlyPersonWithBulletInParty - indicator if this is only bulleted person in party
			actingInPrivate - indicator if main person is represented in private (in prive) by bestuurder(s)
			wrappedInTable - indicator if content is wrapped in table, and root (current) element is <tbody>
			wrappedInTableData - indicator if content is wrapped in table data cell, and root (current) element is <td>
			currentParty - currently processed party
			numberOfManagers - number of managers (bestuurders)
			firstManager - first bestuurder
			currentlyProcessedHoedanigheid - Hoedanigheid for currently processed group
			capacityVariantCurrentHoedanigheid - capacity variant for currently processed group's Hoedanigheid
			managerPersonsRepresentingInHoedanigheid - bestuurder persons representing current group
			position - position of currently processed group
			last - position of last processed group
			numberOfRelatedPersonsInAllManager - total number of related persons in all managers
			formatOfFirstLevel - format of first nesting level, could be either 'a' or '1'
			personNumberingFormat - first level person numbering format ('a' is default)

	Output: text

	Calls:
	(mode) do-capacity-for-legal-person
	(mode) do-capacity-for-more-persons-in-hoedanigheid
	(mode) do-capacity-variant-for-legal-person
	(mode) do-legal-person

	Called by:
	(mode) do-party-legal-person-text-main-and-related-persons
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon" mode="do-party-legal-person-text-main-and-related-persons-warrantors-and-main-person-represented-in-groups-by-managers">
		<xsl:param name="mainPersonRepresentedInHoedanigheid" select="self::node()[false()]"/>
		<xsl:param name="firstWarrantorRepresentedInHoedanigheid" select="self::node()[false()]"/>
		<xsl:param name="capacityVariantCurrentPerson" select="number('0')"/>
		<xsl:param name="capacityFirstWarrantor" select="self::node()[false()]"/>
		<xsl:param name="capacityVariantFirstWarrantor" select="number('0')"/>
		<xsl:param name="firstWarrantor" select="self::node()[false()]"/>
		<xsl:param name="haveWarrantors" select="'false'"/>
		<xsl:param name="relatedPersons" select="self::node()[false()]"/>
		<xsl:param name="personTerminator" select="';'"/>
		<xsl:param name="capacityAlredyPrinted" select="'false'"/>
		<xsl:param name="onlyPersonWithBulletInParty" select="'false'"/>
		<xsl:param name="actingInPrivate" select="'false'"/>
		<xsl:param name="wrappedInTable" select="'false'"/>
		<xsl:param name="wrappedInTableData" select="'false'"/>
		<xsl:param name="currentParty" select="self::node()[false()]"/>
		<xsl:param name="numberOfManagers" select="number('0')"/>
		<xsl:param name="firstManager" select="self::node()[false()]"/>
		<xsl:param name="currentlyProcessedHoedanigheid" select="self::node()[false()]"/>
		<xsl:param name="capacityVariantCurrentHoedanigheid"/>
		<xsl:param name="managerPersonsRepresentingInHoedanigheid" select="self::node()[false()]"/>
		<xsl:param name="position" select="number('0')"/>
		<xsl:param name="last" select="number('0')"/>
		<xsl:param name="numberOfRelatedPersonsInAllManager" select="number('0')"/>
		<xsl:param name="formatOfFirstLevel"/>
		<xsl:param name="personNumberingFormat" select="'a'"/>
		<xsl:variable name="mainPerson" select="."/>
		<xsl:choose>
			<!-- Only one person is represented in currently processed Hoedanigheid -->
			<xsl:when test="count($currentlyProcessedHoedanigheid/tia:wordtVertegenwoordigdRef) = 1">
				<xsl:variable name="onlyPersonRepresentedInHoedanigheid" select="$mainPerson/descendant-or-self::tia:IMKAD_Persoon[not(parent::tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder']) and concat('#', @id) = $currentlyProcessedHoedanigheid/tia:wordtVertegenwoordigdRef[1]/@*[translate(local-name(), $upper, $lower) = 'href']]"/>
				<xsl:variable name="hoeadnigheidContainingReferencesToFollowingWarrantors" select="$currentParty/tia:Hoedanigheid[concat('#', @id) = $onlyPersonRepresentedInHoedanigheid/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] and substring-after(tia:wordtVertegenwoordigdRef[1]/@*[translate(local-name(), $upper, $lower) = 'href'], '#') = $mainPerson/descendant::tia:IMKAD_Persoon[parent::tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'volmachtgever']]/@id]"/>
				<xsl:variable name="capacityVariantNextHoedanigheid" select="$hoeadnigheidContainingReferencesToFollowingWarrantors/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvariant']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
					translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvariant']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
					translate(normalize-space($hoeadnigheidContainingReferencesToFollowingWarrantors/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvariant']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
				<xsl:variable name="personsRepresentedInHoeadnigheidByCurrentPerson" select="$mainPerson/descendant-or-self::tia:IMKAD_Persoon[concat('#', @id) = $hoeadnigheidContainingReferencesToFollowingWarrantors/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href']]"/>
				<xsl:variable name="lastPersonsRepresentedInHoeadnigheidByCurrentPersonPosition" select="count($personsRepresentedInHoeadnigheidByCurrentPerson)"/>
				<tr>
					<xsl:choose>
						<xsl:when test="$actingInPrivate = 'true' and ($numberOfManagers = 1 and $numberOfRelatedPersonsInAllManager = 1 and $onlyPersonWithBulletInParty = 'false')">
							<td class="number" valign="top">
								<xsl:text>&#xFEFF;</xsl:text>
							</td>
						</xsl:when>
						<xsl:when test="$actingInPrivate = 'false' and $numberOfRelatedPersonsInAllManager > 1">
							<td class="number" valign="top">
								<xsl:text>&#xFEFF;</xsl:text>
							</td>
						</xsl:when>
					</xsl:choose>
					<td class="number" valign="top">
						<xsl:choose>
							<xsl:when test="$actingInPrivate = 'true'">
								<xsl:number value="$position + 1" format="I"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:number value="$position" format="I"/>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:text>.</xsl:text>
					</td>
					<td>
						<xsl:attribute name="class"><xsl:text>level</xsl:text><xsl:choose><xsl:when test="($actingInPrivate = 'true' and $numberOfManagers = 1 and $numberOfRelatedPersonsInAllManager = 1 and $onlyPersonWithBulletInParty = 'false')
												or ($actingInPrivate = 'false' and $onlyPersonWithBulletInParty = 'false')"><xsl:value-of select="number('1')"/></xsl:when><xsl:otherwise><xsl:value-of select="number('0')"/></xsl:otherwise></xsl:choose></xsl:attribute>
						<xsl:if test="$capacityAlredyPrinted = 'false'">
							<xsl:apply-templates select="$currentlyProcessedHoedanigheid" mode="do-capacity-for-legal-person">
								<xsl:with-param name="relatedPersons" select="$managerPersonsRepresentingInHoedanigheid"/>
								<xsl:with-param name="shouldPrintColon" select="'false'"/>
							</xsl:apply-templates>
						</xsl:if>
						<xsl:if test="$capacityVariantCurrentHoedanigheid = '1' or $capacityVariantCurrentHoedanigheid = '2' or $capacityVariantCurrentHoedanigheid = '3' or $capacityVariantCurrentHoedanigheid = '4' or $capacityVariantCurrentHoedanigheid = '5' or $capacityVariantCurrentHoedanigheid = '6' or $capacityVariantCurrentHoedanigheid = '7' or $capacityVariantCurrentHoedanigheid = '8' or $capacityVariantCurrentHoedanigheid = '10'">
							<xsl:text> </xsl:text>
							<xsl:apply-templates select="$currentlyProcessedHoedanigheid" mode="do-capacity-variant-for-legal-person">
								<xsl:with-param name="relatedPersons" select="$managerPersonsRepresentingInHoedanigheid"/>
							</xsl:apply-templates>
						</xsl:if>
						<xsl:text> </xsl:text>
						<xsl:choose>
							<!-- It represents only one person in Hoedanigheid -->
							<xsl:when test="count($personsRepresentedInHoeadnigheidByCurrentPerson) = 1">
								<xsl:apply-templates select="$onlyPersonRepresentedInHoedanigheid" mode="do-legal-person"/>
								<xsl:if test="normalize-space($onlyPersonRepresentedInHoedanigheid/tia:tia_AanduidingPersoon) != ''">
									<xsl:text>, hierna te noemen: </xsl:text>
									<xsl:value-of select="$onlyPersonRepresentedInHoedanigheid/tia:tia_AanduidingPersoon"/>
								</xsl:if>
								<xsl:text>, </xsl:text>
								<xsl:apply-templates select="$hoeadnigheidContainingReferencesToFollowingWarrantors" mode="do-capacity-for-legal-person">
									<xsl:with-param name="relatedPersons" select="$onlyPersonRepresentedInHoedanigheid"/>
									<xsl:with-param name="shouldPrintColon" select="'false'"/>
								</xsl:apply-templates>
								<xsl:if test="$capacityVariantNextHoedanigheid = '1' or $capacityVariantNextHoedanigheid = '2' or $capacityVariantNextHoedanigheid = '3' or $capacityVariantNextHoedanigheid = '4' or $capacityVariantNextHoedanigheid = '5' or $capacityVariantNextHoedanigheid = '6' or $capacityVariantNextHoedanigheid = '7' or $capacityVariantNextHoedanigheid = '8' or $capacityVariantNextHoedanigheid = '10'">
									<xsl:text> </xsl:text>
									<xsl:apply-templates select="$hoeadnigheidContainingReferencesToFollowingWarrantors" mode="do-capacity-variant-for-legal-person">
										<xsl:with-param name="relatedPersons" select="$onlyPersonRepresentedInHoedanigheid"/>
									</xsl:apply-templates>
								</xsl:if>
								<xsl:text> </xsl:text>
								<xsl:apply-templates select="$personsRepresentedInHoeadnigheidByCurrentPerson[1]" mode="do-legal-person"/>
								<xsl:if test="normalize-space($personsRepresentedInHoeadnigheidByCurrentPerson[1]/tia:tia_AanduidingPersoon) != ''">
									<xsl:text>, hierna te noemen: </xsl:text>
									<xsl:value-of select="$personsRepresentedInHoeadnigheidByCurrentPerson[1]/tia:tia_AanduidingPersoon"/>
								</xsl:if>
								<xsl:choose>
									<xsl:when test="$position != $last">
										<xsl:text>; en</xsl:text>
									</xsl:when>
									<xsl:when test="$position = $last">
										<xsl:value-of select="$personTerminator"/>
									</xsl:when>
								</xsl:choose>
							</xsl:when>
							<!-- It represents more persons in Hoedanigheid -->
							<xsl:when test="count($personsRepresentedInHoeadnigheidByCurrentPerson) > 1">
								<xsl:apply-templates select="$onlyPersonRepresentedInHoedanigheid" mode="do-legal-person"/>
								<xsl:if test="normalize-space($onlyPersonRepresentedInHoedanigheid/tia:tia_AanduidingPersoon) != ''">
									<xsl:text>, hierna te noemen: </xsl:text>
									<xsl:value-of select="$onlyPersonRepresentedInHoedanigheid/tia:tia_AanduidingPersoon"/>
								</xsl:if>
								<xsl:text>; </xsl:text>
								<xsl:apply-templates select="$hoeadnigheidContainingReferencesToFollowingWarrantors" mode="do-capacity-for-legal-person">
									<xsl:with-param name="relatedPersons" select="$onlyPersonRepresentedInHoedanigheid"/>
									<xsl:with-param name="shouldPrintColon" select="'false'"/>
								</xsl:apply-templates>
								<xsl:if test="$capacityVariantNextHoedanigheid = '1' or $capacityVariantNextHoedanigheid = '2' or $capacityVariantNextHoedanigheid = '3' or $capacityVariantNextHoedanigheid = '4' or $capacityVariantNextHoedanigheid = '5' or $capacityVariantNextHoedanigheid = '6' or $capacityVariantNextHoedanigheid = '7' or $capacityVariantNextHoedanigheid = '8' or $capacityVariantNextHoedanigheid = '10'">
									<xsl:text> </xsl:text>
									<xsl:apply-templates select="$hoeadnigheidContainingReferencesToFollowingWarrantors" mode="do-capacity-variant-for-legal-person">
										<xsl:with-param name="relatedPersons" select="$onlyPersonRepresentedInHoedanigheid"/>
									</xsl:apply-templates>
								</xsl:if>
								<xsl:text>:</xsl:text>
								<table cellspacing="0" cellpadding="0">
									<tbody>
										<xsl:for-each select="$personsRepresentedInHoeadnigheidByCurrentPerson">
											<tr>
												<td class="number" valign="top">
													<xsl:number value="position()" format="{$personNumberingFormat}"/>
													<xsl:text>.</xsl:text>
												</td>
												<td class="level2">
													<xsl:apply-templates select="." mode="do-legal-person"/>
													<xsl:if test="normalize-space(tia:tia_AanduidingPersoon) != ''">
														<xsl:text>, hierna te noemen: </xsl:text>
														<xsl:value-of select="tia:tia_AanduidingPersoon"/>
													</xsl:if>
													<xsl:choose>
														<xsl:when test="position() != $lastPersonsRepresentedInHoeadnigheidByCurrentPersonPosition">
															<xsl:text>; en</xsl:text>
														</xsl:when>
														<xsl:when test="position() = $lastPersonsRepresentedInHoeadnigheidByCurrentPersonPosition">
															<xsl:value-of select="$personTerminator"/>
														</xsl:when>
													</xsl:choose>
												</td>
											</tr>
										</xsl:for-each>
									</tbody>
								</table>
							</xsl:when>
							<!-- It represents none persons in Hoedanigheid -->
							<xsl:otherwise>
								<xsl:text>nnnn</xsl:text>
								<xsl:apply-templates select="$onlyPersonRepresentedInHoedanigheid" mode="do-legal-person"/>
								<xsl:if test="normalize-space($onlyPersonRepresentedInHoedanigheid/tia:tia_AanduidingPersoon) != ''">
									<xsl:text>, hierna te noemen: </xsl:text>
									<xsl:value-of select="$onlyPersonRepresentedInHoedanigheid/tia:tia_AanduidingPersoon"/>
								</xsl:if>
								<xsl:choose>
									<xsl:when test="$position != $last">
										<xsl:text>; en</xsl:text>
									</xsl:when>
									<xsl:when test="$position = $last">
										<xsl:value-of select="$personTerminator"/>
									</xsl:when>
								</xsl:choose>
							</xsl:otherwise>
						</xsl:choose>
					</td>
				</tr>
			</xsl:when>
			<!-- More persons are represented in currently processed Hoedanigheid -->
			<xsl:otherwise>
				<xsl:choose>
					<!-- If there is only one reference to Hoedanigheid from bestuurder(s) -->
					<xsl:when test="count($firstManager/tia:IMKAD_Persoon/tia:vertegenwoordigtRef) = 1 and $actingInPrivate = 'false' and $wrappedInTableData = 'true'">
						<xsl:variable name="nestingLevelOneReferenceToHoedanigheidFromBestuurders">
							<xsl:choose>
								<xsl:when test="$onlyPersonWithBulletInParty = 'true'">
									<xsl:text>0</xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>1</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:apply-templates select="$currentlyProcessedHoedanigheid" mode="do-capacity-for-more-persons-in-hoedanigheid">
							<xsl:with-param name="mainPerson" select="$mainPerson"/>
							<xsl:with-param name="currentParty" select="$currentParty"/>
							<xsl:with-param name="personTerminator" select="$personTerminator"/>
							<xsl:with-param name="position" select="$position"/>
							<xsl:with-param name="last" select="$last"/>
							<xsl:with-param name="actingInPrivate" select="$actingInPrivate"/>
							<xsl:with-param name="numberOfManagers" select="$numberOfManagers"/>
							<xsl:with-param name="numberOfRelatedPersonsInAllManager" select="$numberOfRelatedPersonsInAllManager"/>
							<xsl:with-param name="onlyPersonWithBulletInParty" select="$onlyPersonWithBulletInParty"/>
							<xsl:with-param name="formatOfFirstLevel" select="$formatOfFirstLevel"/>
							<xsl:with-param name="nestingLevel" select="$nestingLevelOneReferenceToHoedanigheidFromBestuurders"/>
							<xsl:with-param name="shouldPrintRoman" select="'true'"/>
							<xsl:with-param name="personNumberingFormat" select="$personNumberingFormat"/>
						</xsl:apply-templates>
					</xsl:when>
					<!-- If there is more than 1 reference to Hoedanigheid from bestuurder(s) -->
					<xsl:otherwise>
						<tr>
							<xsl:choose>
								<xsl:when test="$actingInPrivate = 'true' and ($numberOfManagers = 1 and $numberOfRelatedPersonsInAllManager = 1 and $onlyPersonWithBulletInParty = 'false')">
									<td class="number" valign="top">
										<xsl:text>&#xFEFF;</xsl:text>
									</td>
								</xsl:when>
								<xsl:when test="$actingInPrivate = 'false' and $numberOfRelatedPersonsInAllManager > 1">
									<td class="number" valign="top">
										<xsl:text>&#xFEFF;</xsl:text>
									</td>
								</xsl:when>
							</xsl:choose>
							<td class="number" valign="top">
								<xsl:choose>
									<xsl:when test="$actingInPrivate = 'true'">
										<xsl:number value="$position + 1" format="I"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:number value="$position" format="I"/>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:text>.</xsl:text>
							</td>
							<td>
								<xsl:attribute name="class"><xsl:text>level</xsl:text><xsl:choose><xsl:when test="($actingInPrivate = 'true' and $numberOfManagers = 1 and $numberOfRelatedPersonsInAllManager = 1 and $onlyPersonWithBulletInParty = 'false')
														or ($actingInPrivate = 'false' and $onlyPersonWithBulletInParty = 'false')"><xsl:value-of select="number('1')"/></xsl:when><xsl:otherwise><xsl:value-of select="number('0')"/></xsl:otherwise></xsl:choose></xsl:attribute>
								<xsl:if test="$capacityAlredyPrinted = 'false'">
									<xsl:apply-templates select="$currentlyProcessedHoedanigheid" mode="do-capacity-for-legal-person">
										<xsl:with-param name="relatedPersons" select="$managerPersonsRepresentingInHoedanigheid"/>
										<xsl:with-param name="shouldPrintColon" select="'false'"/>
									</xsl:apply-templates>
								</xsl:if>
								<xsl:if test="$capacityVariantCurrentHoedanigheid = '1' or $capacityVariantCurrentHoedanigheid = '2' or $capacityVariantCurrentHoedanigheid = '3' or $capacityVariantCurrentHoedanigheid = '4' or $capacityVariantCurrentHoedanigheid = '5' or $capacityVariantCurrentHoedanigheid = '6' or $capacityVariantCurrentHoedanigheid = '7' or $capacityVariantCurrentHoedanigheid = '8' or $capacityVariantCurrentHoedanigheid = '10'">
									<xsl:text> </xsl:text>
									<xsl:apply-templates select="$currentlyProcessedHoedanigheid" mode="do-capacity-variant-for-legal-person">
										<xsl:with-param name="relatedPersons" select="$managerPersonsRepresentingInHoedanigheid"/>
									</xsl:apply-templates>
								</xsl:if>
								<xsl:text>:</xsl:text>
								<xsl:variable name="nestingDepth">
									<xsl:choose>
										<xsl:when test="($numberOfManagers = 1 and $numberOfRelatedPersonsInAllManager = 1 and $onlyPersonWithBulletInParty = 'false')
														or ($actingInPrivate = 'false' and $numberOfRelatedPersonsInAllManager > 1)">
											<xsl:value-of select="number('2')"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="number('1')"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:variable>
								<table cellspacing="0" cellpadding="0">
									<tbody>
										<xsl:apply-templates select="$currentlyProcessedHoedanigheid" mode="do-capacity-for-more-persons-in-hoedanigheid">
											<xsl:with-param name="mainPerson" select="$mainPerson"/>
											<xsl:with-param name="currentParty" select="$currentParty"/>
											<xsl:with-param name="personTerminator" select="$personTerminator"/>
											<xsl:with-param name="position" select="$position"/>
											<xsl:with-param name="last" select="$last"/>
											<xsl:with-param name="actingInPrivate" select="$actingInPrivate"/>
											<xsl:with-param name="numberOfManagers" select="$numberOfManagers"/>
											<xsl:with-param name="numberOfRelatedPersonsInAllManager" select="$numberOfRelatedPersonsInAllManager"/>
											<xsl:with-param name="onlyPersonWithBulletInParty" select="$onlyPersonWithBulletInParty"/>
											<xsl:with-param name="formatOfFirstLevel" select="$formatOfFirstLevel"/>
											<xsl:with-param name="nestingLevel" select="$nestingDepth"/>
											<xsl:with-param name="personNumberingFormat" select="$personNumberingFormat"/>
										</xsl:apply-templates>
									</tbody>
								</table>
							</td>
						</tr>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-capacity-for-more-persons-in-hoedanigheid
	*********************************************************
	Public: no

	Identity transform: no

	Description: Prints persons group represented by besuurder(s), where Hoedanigheid contains references to more than one person.

	Input: tia:Hoedanigheid

	Params: currentParty - party which contains processed person
			mainPerson - main person which contains processed person
			shouldPrintComma - indicator if leading comma should be printed
			personTerminator - character that is printed at the end of each person's block
			position - position of currently processed group
			last - position of last processed group
			actingInPrivate - indicator if main person is represented in private (in prive) by bestuurder(s)
			numberOfManagers - number of managers (bestuurders)
			numberOfRelatedPersonsInAllManager - total number of related persons in all managers
			onlyPersonWithBulletInParty - indicator if this is only bulleted person in party
			formatOfFirstLevel - format of first nesting level, could be either 'a' or '1'
			nestingLevel - nesting level of the printed list
			shouldPrintRoman - indicator if Roman number format should be considered for printout
			personNumberingFormat - first level person numbering format ('a' is default)

	Output: text

	Calls:
	(mode) do-capacity-for-legal-person
	(mode) do-capacity-for-other-persons-in-groups-represented-by-managers
	(mode) do-capacity-variant-for-legal-person
	(mode) do-legal-person

	Called by:
	(mode) do-party-legal-person-text-main-and-related-persons-warrantors-and-main-person-represented-in-groups-by-managers
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:Hoedanigheid" mode="do-capacity-for-more-persons-in-hoedanigheid">
		<xsl:param name="currentParty" select="self::node()[false()]"/>
		<xsl:param name="mainPerson" select="self::node()[false()]"/>
		<xsl:param name="personTerminator" select="';'"/>
		<xsl:param name="position" select="number('0')"/>
		<xsl:param name="last" select="number('0')"/>
		<xsl:param name="actingInPrivate" select="'false'"/>
		<xsl:param name="numberOfManagers" select="number('0')"/>
		<xsl:param name="numberOfRelatedPersonsInAllManager" select="number('0')"/>
		<xsl:param name="onlyPersonWithBulletInParty" select="'false'"/>
		<xsl:param name="formatOfFirstLevel"/>
		<xsl:param name="nestingLevel" select="number('0')"/>
		<xsl:param name="shouldPrintRoman" select="'false'"/>
		<xsl:param name="personNumberingFormat" select="'a'"/>
		<xsl:variable name="shouldPrintRomanNumbers">
			<xsl:choose>
				<xsl:when test="$shouldPrintRoman = 'true' and $numberOfRelatedPersonsInAllManager > 1 and $actingInPrivate = 'false'">
					<xsl:text>true</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>false</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="currentlyProcessedHoedanigheid" select="."/>
		<xsl:for-each select="$currentlyProcessedHoedanigheid/tia:wordtVertegenwoordigdRef">
			<xsl:variable name="currentlyProcessedPersonReferencedInHoedanigheid" select="@*[translate(local-name(), $upper, $lower) = 'href']"/>
			<xsl:variable name="currentlyProcessedPersonRepresentedInHoedanigheid" select="$mainPerson/descendant-or-self::tia:IMKAD_Persoon[not(parent::tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder']) and concat('#', @id) = $currentlyProcessedPersonReferencedInHoedanigheid]"/>
			<xsl:variable name="hoeadnigheidContainingReferencesToFollowingWarrantors" select="$currentParty/tia:Hoedanigheid[concat('#', @id) = $currentlyProcessedPersonRepresentedInHoedanigheid/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'] and substring-after(tia:wordtVertegenwoordigdRef[1]/@*[translate(local-name(), $upper, $lower) = 'href'], '#') = $mainPerson/descendant::tia:IMKAD_Persoon[parent::tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'volmachtgever']]/@id]"/>
			<xsl:variable name="capacityVariantNextHoedanigheid" select="$hoeadnigheidContainingReferencesToFollowingWarrantors/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvariant']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
				translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvariant']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
				translate(normalize-space($hoeadnigheidContainingReferencesToFollowingWarrantors/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvariant']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
			<xsl:variable name="personsRepresentedInHoeadnigheidByCurrentPerson" select="$mainPerson/descendant-or-self::tia:IMKAD_Persoon[concat('#', @id) = $hoeadnigheidContainingReferencesToFollowingWarrantors/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href']]"/>
			<xsl:variable name="positionOfFirstWarrantorFromNextGroup" select="position() + 1"/>
			<xsl:variable name="firstWarrantorFromNextGroup" select="$mainPerson/tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'volmachtgever']/tia:IMKAD_Persoon[concat('#', @id) = $currentlyProcessedHoedanigheid/tia:wordtVertegenwoordigdRef[$positionOfFirstWarrantorFromNextGroup]/@*[translate(local-name(), $upper, $lower) = 'href']]"/>
			<xsl:variable name="firstWarrantorFromNextGroupPosition">
				<xsl:choose>
					<xsl:when test="$firstWarrantorFromNextGroup">
						<xsl:value-of select="count($firstWarrantorFromNextGroup/../preceding-sibling::tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'volmachtgever']) + 1"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<!-- If it is last processed, consider all following warrantors as there are no more groups afterwards -->
							<xsl:when test="$position = $last">
								<xsl:value-of select="count($mainPerson/tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'volmachtgever']) + 1"/>
							</xsl:when>
							<!-- Otherwise, none should be consider further -->
							<xsl:otherwise>
								<xsl:value-of select="number('0')"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="isLast">
				<xsl:choose>
					<xsl:when test="position() = last()">
						<xsl:text>true</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>false</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<tr>
				<td class="number" valign="top">
					<xsl:choose>
						<xsl:when test="$shouldPrintRomanNumbers = 'true'">
							<xsl:number value="position()" format="I"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:number value="position()" format="{$formatOfFirstLevel}"/>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:text>.</xsl:text>
				</td>
				<td>
					<xsl:attribute name="class"><xsl:text>level</xsl:text><xsl:value-of select="$nestingLevel"/></xsl:attribute>
					<xsl:choose>
						<!-- It represents only one person in Hoedanigheid -->
						<xsl:when test="count($personsRepresentedInHoeadnigheidByCurrentPerson) = 1">
							<xsl:variable name="firstWarrantorFromCurrentGroupPosition" select="count($personsRepresentedInHoeadnigheidByCurrentPerson[1]/../preceding-sibling::tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'volmachtgever']) + 1"/>
							<xsl:variable name="warrantorsWhichAreRepresenters" select="$mainPerson/tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'volmachtgever'
													and (count(preceding-sibling::tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'volmachtgever']) + 1) &lt; $firstWarrantorFromNextGroupPosition
													and (count(preceding-sibling::tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'volmachtgever']) + 1) >= $firstWarrantorFromCurrentGroupPosition]
													/tia:IMKAD_Persoon[substring-after(tia:vertegenwoordigtRef[1]/@*[translate(local-name(), $upper, $lower) = 'href'], '#') = $currentParty/tia:Hoedanigheid[substring-after(tia:wordtVertegenwoordigdRef[1]/@*[translate(local-name(), $upper, $lower) = 'href'], '#') = $mainPerson/tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'volmachtgever']/tia:IMKAD_Persoon/@id]/@id]"/>
							<xsl:apply-templates select="$currentlyProcessedPersonRepresentedInHoedanigheid" mode="do-legal-person"/>
							<xsl:if test="normalize-space($currentlyProcessedPersonRepresentedInHoedanigheid/tia:tia_AanduidingPersoon) != ''">
								<xsl:text>, hierna te noemen: </xsl:text>
								<xsl:value-of select="$currentlyProcessedPersonRepresentedInHoedanigheid/tia:tia_AanduidingPersoon"/>
							</xsl:if>
							<xsl:text>, </xsl:text>
							<xsl:apply-templates select="$hoeadnigheidContainingReferencesToFollowingWarrantors" mode="do-capacity-for-legal-person">
								<xsl:with-param name="relatedPersons" select="$currentlyProcessedPersonRepresentedInHoedanigheid"/>
								<xsl:with-param name="shouldPrintColon" select="'false'"/>
							</xsl:apply-templates>
							<xsl:if test="$capacityVariantNextHoedanigheid = '1' or $capacityVariantNextHoedanigheid = '2' or $capacityVariantNextHoedanigheid = '3' or $capacityVariantNextHoedanigheid = '4' or $capacityVariantNextHoedanigheid = '5' or $capacityVariantNextHoedanigheid = '6' or $capacityVariantNextHoedanigheid = '7' or $capacityVariantNextHoedanigheid = '8' or $capacityVariantNextHoedanigheid = '10'">
								<xsl:text> </xsl:text>
								<xsl:apply-templates select="$hoeadnigheidContainingReferencesToFollowingWarrantors" mode="do-capacity-variant-for-legal-person">
									<xsl:with-param name="relatedPersons" select="$currentlyProcessedPersonRepresentedInHoedanigheid"/>
								</xsl:apply-templates>
							</xsl:if>
							<xsl:text> </xsl:text>
							<xsl:apply-templates select="$personsRepresentedInHoeadnigheidByCurrentPerson[1]" mode="do-legal-person"/>
							<xsl:if test="normalize-space($personsRepresentedInHoeadnigheidByCurrentPerson[1]/tia:tia_AanduidingPersoon) != ''">
								<xsl:text>, hierna te noemen: </xsl:text>
								<xsl:value-of select="$personsRepresentedInHoeadnigheidByCurrentPerson[1]/tia:tia_AanduidingPersoon"/>
							</xsl:if>
							<xsl:choose>
								<xsl:when test="$warrantorsWhichAreRepresenters">
									<xsl:apply-templates select="$personsRepresentedInHoeadnigheidByCurrentPerson[1]" mode="do-capacity-for-other-persons-in-groups-represented-by-managers">
										<xsl:with-param name="firstWarrantorFromCurrentGroupPosition" select="$firstWarrantorFromCurrentGroupPosition"/>
										<xsl:with-param name="mainPerson" select="$mainPerson"/>
										<xsl:with-param name="currentParty" select="$currentParty"/>
										<xsl:with-param name="firstWarrantorFromNextGroup" select="$firstWarrantorFromNextGroup"/>
										<xsl:with-param name="firstWarrantorFromNextGroupPosition" select="$firstWarrantorFromNextGroupPosition"/>
										<xsl:with-param name="warrantorsWhichAreRepresenters" select="$warrantorsWhichAreRepresenters"/>
										<xsl:with-param name="personTerminator" select="$personTerminator"/>
										<xsl:with-param name="isLast" select="$isLast"/>
										<xsl:with-param name="nestingLevel" select="$nestingLevel + 1"/>
										<xsl:with-param name="formatOfFirstLevel" select="$formatOfFirstLevel"/>
									</xsl:apply-templates>
								</xsl:when>
								<xsl:otherwise>
									<xsl:choose>
										<xsl:when test="position() != last()">
											<xsl:text>; en</xsl:text>
										</xsl:when>
										<xsl:when test="position() = last()">
											<xsl:choose>
												<xsl:when test="$position != $last">
													<xsl:text>; en</xsl:text>
												</xsl:when>
												<xsl:otherwise>
													<xsl:value-of select="$personTerminator"/>
												</xsl:otherwise>
											</xsl:choose>
										</xsl:when>
									</xsl:choose>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<!-- It represents more persons in Hoedanigheid -->
						<xsl:when test="count($personsRepresentedInHoeadnigheidByCurrentPerson) > 1">
							<xsl:variable name="lastPersonRepresentedInHoeadnigheidByCurrentPerson" select="count($personsRepresentedInHoeadnigheidByCurrentPerson)"/>
							<xsl:variable name="firstWarrantorFromCurrentGroupPosition" select="count($personsRepresentedInHoeadnigheidByCurrentPerson[1]/../preceding-sibling::tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'volmachtgever']) + 1"/>
							<xsl:variable name="warrantorsWhichAreRepresenters" select="$mainPerson/tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'volmachtgever'
													and (count(preceding-sibling::tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'volmachtgever']) + 1) &lt; $firstWarrantorFromNextGroupPosition
													and (count(preceding-sibling::tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'volmachtgever']) + 1) >= $firstWarrantorFromCurrentGroupPosition]
													/tia:IMKAD_Persoon[substring-after(tia:vertegenwoordigtRef[1]/@*[translate(local-name(), $upper, $lower) = 'href'], '#') = $currentParty/tia:Hoedanigheid[substring-after(tia:wordtVertegenwoordigdRef[1]/@*[translate(local-name(), $upper, $lower) = 'href'], '#') = $mainPerson/tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'volmachtgever']/tia:IMKAD_Persoon/@id]/@id]"/>
							<xsl:apply-templates select="$currentlyProcessedPersonRepresentedInHoedanigheid" mode="do-legal-person"/>
							<xsl:if test="normalize-space($currentlyProcessedPersonRepresentedInHoedanigheid/tia:tia_AanduidingPersoon) != ''">
								<xsl:text>, hierna te noemen: </xsl:text>
								<xsl:value-of select="$currentlyProcessedPersonRepresentedInHoedanigheid/tia:tia_AanduidingPersoon"/>
							</xsl:if>
							<xsl:text>, </xsl:text>
							<xsl:apply-templates select="$hoeadnigheidContainingReferencesToFollowingWarrantors" mode="do-capacity-for-legal-person">
								<xsl:with-param name="relatedPersons" select="$currentlyProcessedPersonRepresentedInHoedanigheid"/>
								<xsl:with-param name="shouldPrintColon" select="'false'"/>
							</xsl:apply-templates>
							<xsl:if test="$capacityVariantNextHoedanigheid = '1' or $capacityVariantNextHoedanigheid = '2' or $capacityVariantNextHoedanigheid = '3' or $capacityVariantNextHoedanigheid = '4' or $capacityVariantNextHoedanigheid = '5' or $capacityVariantNextHoedanigheid = '6' or $capacityVariantNextHoedanigheid = '7' or $capacityVariantNextHoedanigheid = '8' or $capacityVariantNextHoedanigheid = '10'">
								<xsl:text> </xsl:text>
								<xsl:apply-templates select="$hoeadnigheidContainingReferencesToFollowingWarrantors" mode="do-capacity-variant-for-legal-person">
									<xsl:with-param name="relatedPersons" select="$currentlyProcessedPersonRepresentedInHoedanigheid"/>
								</xsl:apply-templates>
							</xsl:if>
							<xsl:text>:</xsl:text>
							<table cellspacing="0" cellpadding="0">
								<tbody>
									<xsl:for-each select="$personsRepresentedInHoeadnigheidByCurrentPerson">
										<tr>
											<td class="number" valign="top">
												<xsl:choose>
													<xsl:when test="$shouldPrintRomanNumbers = 'true'">
														<xsl:number value="position()" format="{$personNumberingFormat}"/>
													</xsl:when>
													<xsl:otherwise>
														<xsl:number value="position()" format="{translate($formatOfFirstLevel, '1a', 'a1')}"/>
													</xsl:otherwise>
												</xsl:choose>
												<xsl:text>.</xsl:text>
											</td>
											<td>
												<xsl:attribute name="class"><xsl:text>level</xsl:text><xsl:value-of select="$nestingLevel + 1"/></xsl:attribute>
												<xsl:apply-templates select="." mode="do-legal-person"/>
												<xsl:if test="normalize-space(tia:tia_AanduidingPersoon) != ''">
													<xsl:text>, hierna te noemen: </xsl:text>
													<xsl:value-of select="tia:tia_AanduidingPersoon"/>
												</xsl:if>
												<xsl:choose>
													<xsl:when test="position() != $lastPersonRepresentedInHoeadnigheidByCurrentPerson">
														<xsl:text>; en</xsl:text>
													</xsl:when>
													<xsl:when test="position() = $lastPersonRepresentedInHoeadnigheidByCurrentPerson">
														<xsl:choose>
															<xsl:when test="$warrantorsWhichAreRepresenters or $position != $last">
																<xsl:text>; en</xsl:text>
															</xsl:when>
															<xsl:otherwise>
																<xsl:value-of select="$personTerminator"/>
															</xsl:otherwise>
														</xsl:choose>
													</xsl:when>
												</xsl:choose>
											</td>
										</tr>
									</xsl:for-each>
								</tbody>
							</table>
							<xsl:if test="$warrantorsWhichAreRepresenters">
								<xsl:apply-templates select="$personsRepresentedInHoeadnigheidByCurrentPerson[count($personsRepresentedInHoeadnigheidByCurrentPerson)]" mode="do-capacity-for-other-persons-in-groups-represented-by-managers">
									<xsl:with-param name="firstWarrantorFromCurrentGroupPosition" select="$firstWarrantorFromCurrentGroupPosition"/>
									<xsl:with-param name="mainPerson" select="$mainPerson"/>
									<xsl:with-param name="currentParty" select="$currentParty"/>
									<xsl:with-param name="firstWarrantorFromNextGroup" select="$firstWarrantorFromNextGroup"/>
									<xsl:with-param name="firstWarrantorFromNextGroupPosition" select="$firstWarrantorFromNextGroupPosition"/>
									<xsl:with-param name="warrantorsWhichAreRepresenters" select="$warrantorsWhichAreRepresenters"/>
									<xsl:with-param name="personTerminator" select="$personTerminator"/>
									<xsl:with-param name="isLast" select="$isLast"/>
									<xsl:with-param name="shouldPrintComma" select="'false'"/>
									<xsl:with-param name="nestingLevel" select="$nestingLevel + 1"/>
									<xsl:with-param name="formatOfFirstLevel" select="$formatOfFirstLevel"/>
								</xsl:apply-templates>
							</xsl:if>
						</xsl:when>
						<!-- It represents none persons in Hoedanigheid -->
						<xsl:otherwise>
							<xsl:apply-templates select="$currentlyProcessedPersonRepresentedInHoedanigheid" mode="do-legal-person"/>
							<xsl:if test="normalize-space($currentlyProcessedPersonRepresentedInHoedanigheid/tia:tia_AanduidingPersoon) != ''">
								<xsl:text>, hierna te noemen: </xsl:text>
								<xsl:value-of select="$currentlyProcessedPersonRepresentedInHoedanigheid/tia:tia_AanduidingPersoon"/>
							</xsl:if>
							<xsl:choose>
								<xsl:when test="position() != last()">
									<xsl:text>; en</xsl:text>
								</xsl:when>
								<xsl:when test="position() = last()">
									<xsl:choose>
										<xsl:when test="$position != $last">
											<xsl:text>; en</xsl:text>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="$personTerminator"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
							</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>
		</xsl:for-each>
	</xsl:template>
	<!--
	*********************************************************************
	Mode: do-capacity-for-other-persons-in-groups-represented-by-managers
	*********************************************************************
	Public: no

	Identity transform: no

	Description: Output for the rest of the person group represented by the besuurder(s), located under main bullet.
				 First person from the group and it's Hoedanigheid relation to following warrantor(s) is handled prior to this template's call.

	Input: tia:IMKAD_Persoon

	Params: firstWarrantorFromCurrentGroupPosition - ordinal number of the warrantor (in XML) on which the tamplate is called
			currentParty - party which contains processed person
			mainPerson - main person which contains processed person
			firstWarrantorFromNextGroup - first person from next group, printed under next bullet in the main list
			firstWarrantorFromNextGroupPosition - ordinal number of the warrantor (in XML)
			warrantorsWhichAreRepresenters - all warrantors which represent others, in current group
			personTerminator - character that is printed at the end of each person's block
			isLast - indicator if there are persons which will be printed in the same list, after this block's call
			shouldPrintComma - indicator if leading comma should be printed
			nestingLevel - nesting level of the printed list
			formatOfFirstLevel - format of first nesting level, could be either 'a' or '1'

	Output: text

	Calls:
	(mode) do-capacity-for-legal-person
	(mode) do-capacity-variant-for-legal-person
	(mode) do-legal-person

	Called by:
	(mode) do-capacity-for-more-persons-in-hoedanigheid
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon" mode="do-capacity-for-other-persons-in-groups-represented-by-managers">
		<xsl:param name="firstWarrantorFromCurrentGroupPosition" select="number('0')"/>
		<xsl:param name="currentParty" select="self::node()[false()]"/>
		<xsl:param name="mainPerson" select="self::node()[false()]"/>
		<xsl:param name="firstWarrantorFromNextGroup" select="self::node()[false()]"/>
		<xsl:param name="firstWarrantorFromNextGroupPosition" select="number('0')"/>
		<xsl:param name="warrantorsWhichAreRepresenters" select="self::node()[false()]"/>
		<xsl:param name="personTerminator" select="';'"/>
		<xsl:param name="isLast" select="'false'"/>
		<xsl:param name="shouldPrintComma" select="'true'"/>
		<xsl:param name="nestingLevel" select="number('0')"/>
		<xsl:param name="formatOfFirstLevel"/>
		<xsl:if test="$warrantorsWhichAreRepresenters and $shouldPrintComma = 'true'">
			<xsl:text>, </xsl:text>
		</xsl:if>
		<xsl:for-each select="$warrantorsWhichAreRepresenters">
			<xsl:variable name="currentRepresenter" select="."/>
			<xsl:variable name="currentHoedanigheid" select="$currentParty/tia:Hoedanigheid[@id = substring-after($currentRepresenter/tia:vertegenwoordigtRef[1]/@*[translate(local-name(), $upper, $lower) = 'href'], '#')]"/>
			<xsl:variable name="personsRepresentedInHoeadnigheidByCurrentPerson" select="$mainPerson/descendant-or-self::tia:IMKAD_Persoon[concat('#', @id) = $currentHoedanigheid/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href']]"/>
			<xsl:variable name="capacityVariantCurrentHoedanigheid" select="$currentHoedanigheid/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvariant']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
				translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvariant']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
				translate(normalize-space($currentHoedanigheid/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvariant']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
			<xsl:variable name="lastWarrantorsWhichIsRepresenter" select="count($warrantorsWhichAreRepresenters)"/>
			<xsl:choose>
				<xsl:when test="count($personsRepresentedInHoeadnigheidByCurrentPerson) = 1">
					<xsl:apply-templates select="$currentHoedanigheid" mode="do-capacity-for-legal-person">
						<xsl:with-param name="relatedPersons" select="$currentRepresenter"/>
						<xsl:with-param name="shouldPrintColon" select="'false'"/>
					</xsl:apply-templates>
					<xsl:if test="$capacityVariantCurrentHoedanigheid = '1' or $capacityVariantCurrentHoedanigheid = '2' or $capacityVariantCurrentHoedanigheid = '3' or $capacityVariantCurrentHoedanigheid = '4' or $capacityVariantCurrentHoedanigheid = '5' or $capacityVariantCurrentHoedanigheid = '6' or $capacityVariantCurrentHoedanigheid = '7' or $capacityVariantCurrentHoedanigheid = '8' or $capacityVariantCurrentHoedanigheid = '10'">
						<xsl:text> </xsl:text>
						<xsl:apply-templates select="$currentHoedanigheid" mode="do-capacity-variant-for-legal-person">
							<xsl:with-param name="relatedPersons" select="$currentRepresenter"/>
						</xsl:apply-templates>
					</xsl:if>
					<xsl:text> </xsl:text>
					<xsl:apply-templates select="$personsRepresentedInHoeadnigheidByCurrentPerson[1]" mode="do-legal-person"/>
					<xsl:if test="normalize-space($personsRepresentedInHoeadnigheidByCurrentPerson[1]/tia:tia_AanduidingPersoon) != ''">
						<xsl:text>, hierna te noemen: </xsl:text>
						<xsl:value-of select="$personsRepresentedInHoeadnigheidByCurrentPerson[1]/tia:tia_AanduidingPersoon"/>
					</xsl:if>
					<xsl:choose>
						<xsl:when test="position() != $lastWarrantorsWhichIsRepresenter">
							<xsl:text>, </xsl:text>
						</xsl:when>
						<xsl:when test="position() = $lastWarrantorsWhichIsRepresenter">
							<xsl:choose>
								<xsl:when test="$isLast = 'true'">
									<xsl:value-of select="$personTerminator"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>; en</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="count($personsRepresentedInHoeadnigheidByCurrentPerson) > 1">
					<xsl:variable name="lastPersonRepresentedInHoeadnigheidByCurrentPerson" select="count($personsRepresentedInHoeadnigheidByCurrentPerson)"/>
					<xsl:apply-templates select="$currentHoedanigheid" mode="do-capacity-for-legal-person">
						<xsl:with-param name="relatedPersons" select="$currentRepresenter"/>
						<xsl:with-param name="shouldPrintColon" select="'false'"/>
					</xsl:apply-templates>
					<xsl:if test="$capacityVariantCurrentHoedanigheid = '1' or $capacityVariantCurrentHoedanigheid = '2' or $capacityVariantCurrentHoedanigheid = '3' or $capacityVariantCurrentHoedanigheid = '4' or $capacityVariantCurrentHoedanigheid = '5' or $capacityVariantCurrentHoedanigheid = '6' or $capacityVariantCurrentHoedanigheid = '7' or $capacityVariantCurrentHoedanigheid = '8' or $capacityVariantCurrentHoedanigheid = '10'">
						<xsl:text> </xsl:text>
						<xsl:apply-templates select="$currentHoedanigheid" mode="do-capacity-variant-for-legal-person">
							<xsl:with-param name="relatedPersons" select="$currentRepresenter"/>
						</xsl:apply-templates>
					</xsl:if>
					<xsl:text>:</xsl:text>
					<table cellspacing="0" cellpadding="0">
						<tbody>
							<xsl:for-each select="$personsRepresentedInHoeadnigheidByCurrentPerson">
								<tr>
									<td class="number" valign="top">
										<xsl:number value="position()" format="{translate($formatOfFirstLevel, '1a', 'a1')}"/>
										<xsl:text>.</xsl:text>
									</td>
									<td>
										<xsl:attribute name="class"><xsl:text>level</xsl:text><xsl:value-of select="$nestingLevel"/></xsl:attribute>
										<xsl:apply-templates select="." mode="do-legal-person"/>
										<xsl:if test="normalize-space(tia:tia_AanduidingPersoon) != ''">
											<xsl:text>, hierna te noemen: </xsl:text>
											<xsl:value-of select="tia:tia_AanduidingPersoon"/>
										</xsl:if>
										<xsl:choose>
											<xsl:when test="position() != $lastPersonRepresentedInHoeadnigheidByCurrentPerson">
												<xsl:text>; en</xsl:text>
											</xsl:when>
											<xsl:when test="position() = $lastPersonRepresentedInHoeadnigheidByCurrentPerson">
												<xsl:choose>
													<xsl:when test="$isLast = 'true'">
														<xsl:value-of select="$personTerminator"/>
													</xsl:when>
													<xsl:otherwise>
														<xsl:text>; en</xsl:text>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:when>
										</xsl:choose>
									</td>
								</tr>
							</xsl:for-each>
						</tbody>
					</table>
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-party-person-number-for-legal-person
	*********************************************************
	Public: no

	Identity transform: no

	Description: Determines number of P(N)NP within party.

	Input: tia:IMKAD_Persoon

	Params: numberingFormat - format of the numbering
			currentParty - party which contains processed person
			ordinalNumberOfPersonInParty - ordinal number of the person within XML
			positionWithinPerson - position in person which should be taken into account also
			relatedBesturderPerson - indicator if related Bestuurder's person is processed

	Output: text

	Calls: none

	Called by:
	(mode) do-party-legal-person
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon" mode="do-party-person-number-for-legal-person">
		<xsl:param name="numberingFormat"/>
		<xsl:param name="currentParty" select="self::node()[false()]"/>
		<xsl:param name="ordinalNumberOfPersonInParty" select="number('0')"/>
		<xsl:param name="positionWithinPerson" select="number('0')"/>
		<xsl:param name="relatedBesturderPerson" select="'false'"/>
		<!--
			Count rules. Count is based into position of person in XML (ordinal number):
			1. PNNP that are printed without bullet are not taken into acount
			2. PNNP with volmachtgever related persons that are all printed with the bullet are taken into account
			3. Additional bestuurders from PNNP are also taken into acount
			4. For PNP, when there is Gevolmachtigde acting on person level, all PNP's represented by that Gevolmachtigde are listed within one bullet, so should not be taken into acount
			5. For PNP, if a main person is represented by a previous PNP then the related persons of that main person are each counted as one bullet as they are shifted to the left, to first level of numbering
		-->
		<xsl:variable name="positionWithinParty">
			<xsl:choose>
				<xsl:when test="$relatedBesturderPerson = 'true'">
					<xsl:value-of select="number('1')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="count($currentParty/tia:IMKAD_Persoon[$ordinalNumberOfPersonInParty]/preceding-sibling::tia:IMKAD_Persoon[tia:tia_Gegevens/tia:NHR_Rechtspersoon and not(count(tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder']) = 0 and count(tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'volmachtgever']) = 0 and (concat('#', @id) = $currentParty/tia:Hoedanigheid/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href']) and count(preceding-sibling::tia:IMKAD_Persoon) > 0)])
								+ count($currentParty/tia:IMKAD_Persoon[$ordinalNumberOfPersonInParty]/preceding-sibling::tia:IMKAD_Persoon[tia:tia_Gegevens/tia:NHR_Rechtspersoon and count(tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder']) = 0 and (concat('#', @id) = $currentParty/tia:Hoedanigheid/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href']) and count(preceding-sibling::tia:IMKAD_Persoon) > 0]/tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'volmachtgever']/tia:IMKAD_Persoon)
								+ count($currentParty/tia:IMKAD_Persoon[$ordinalNumberOfPersonInParty]/preceding-sibling::tia:IMKAD_Persoon[count(tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder']) > 1]/tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder' and preceding-sibling::tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder']])
								+ count($currentParty/tia:IMKAD_Persoon[$ordinalNumberOfPersonInParty]/preceding-sibling::tia:IMKAD_Persoon[(tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene) and not(concat('#', @id) = $currentParty/tia:Hoedanigheid[not(concat('#', @id) = $currentParty/tia:Gevolmachtigde/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'])]/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'])])
								+ count($currentParty/tia:IMKAD_Persoon[$ordinalNumberOfPersonInParty]/preceding-sibling::tia:IMKAD_Persoon[(tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene) and concat('#', @id) = $currentParty/tia:Hoedanigheid[not(concat('#', @id) = $currentParty/tia:Gevolmachtigde/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'])]/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href']]/tia:GerelateerdPersoon/tia:IMKAD_Persoon[not(concat('#', @id) = $currentParty/tia:Hoedanigheid[not(concat('#', @id) = $currentParty/tia:Gevolmachtigde/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href'])]/tia:wordtVertegenwoordigdRef/@*[translate(local-name(), $upper, $lower) = 'href'])])
								+ 1"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="personNumberValue">
			<xsl:choose>
				<xsl:when test="$positionWithinPerson > 0">
					<xsl:value-of select="$positionWithinPerson + $positionWithinParty"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$positionWithinParty"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:number value="$personNumberValue" format="{$numberingFormat}"/>
		<xsl:text>.</xsl:text>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-manager
	*********************************************************
	Public: no

	Identity transform: no

	Description: Legal person manager

	Input: tia:IMKAD_Persoon

	Params: hasCommonMaritalStatus - indicator if manager and it's partners have common marital status
			hasCommonAddress - indicator if manager and it's partners have common address

	Output: text

	Calls:
	(mode) do-address
	(mode) do-identity-document
	(mode) do-marital-status
	(mode) do-natural-person

	Called by:
	(mode) do-party-legal-person
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:GerelateerdPersoon/tia:IMKAD_Persoon" mode="do-manager">
		<xsl:param name="hasCommonMaritalStatus" select="'false'"/>
		<xsl:param name="hasCommonAddress" select="'false'"/>
		<xsl:apply-templates select="." mode="do-natural-person"/>
		<xsl:if test="tia:tia_Legitimatiebewijs">
			<xsl:text>, </xsl:text>
			<xsl:apply-templates select="tia:tia_Legitimatiebewijs" mode="do-identity-document">
				<xsl:with-param name="gender" select="tia:tia_Gegevens/tia:GBA_Ingezetene/tia:geslacht/tia:geslachtsaanduiding
					| tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:geslacht"/>
			</xsl:apply-templates>
		</xsl:if>
		<xsl:if test="$hasCommonMaritalStatus = 'false'">
			<xsl:if test="normalize-space(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_burgerlijkestaattekst']/tia:tekst) != ''">
				<xsl:text>, </xsl:text>
				<xsl:apply-templates select="." mode="do-marital-status"/>
			</xsl:if>
		</xsl:if>
		<xsl:if test="$hasCommonAddress = 'false'">
			<xsl:if test="tia:IMKAD_WoonlocatiePersoon">
				<xsl:text>, wonende te </xsl:text>
				<xsl:apply-templates select="tia:IMKAD_WoonlocatiePersoon" mode="do-address"/>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-correspondant-address
	*********************************************************
	Public: no

	Identity transform: no

	Description: Correspondant address

	Input: tia:IMKAD_PostlocatiePersoon, tia:binnenlandsAdres, tia:buitenlandsAdres, tia:postbusAdres

	Params: none

	Output: text

	Calls:
	(mode) do-correspondant-address

	Called by:
	(mode) do-party-legal-person
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_PostlocatiePersoon" mode="do-correspondant-address">
		<xsl:if test="tia:tia_label and normalize-space(tia:tia_label) != ''">
			<xsl:value-of select="tia:tia_label"/>
			<xsl:text>, </xsl:text>
		</xsl:if>
		<xsl:if test="tia:tia_afdeling and normalize-space(tia:tia_afdeling) != ''">
			<xsl:value-of select="tia:tia_afdeling"/>
			<xsl:text>, </xsl:text>
		</xsl:if>
		<xsl:apply-templates select="tia:adres/tia:binnenlandsAdres
			| tia:adres/tia:buitenlandsAdres
			| tia:adres/tia:postbusAdres" mode="do-correspondant-address"/>
	</xsl:template>
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:binnenlandsAdres" mode="do-correspondant-address">
		<!-- Insert space between numbers and letters of post code -->
		<xsl:value-of select="concat(normalize-space(substring(tia:BAG_NummerAanduiding/tia:postcode, 1, 4)), ' ',
			normalize-space(substring(tia:BAG_NummerAanduiding/tia:postcode, 5)))"/>
		<xsl:text> </xsl:text>
		<xsl:value-of select="tia:BAG_Woonplaats/tia:woonplaatsNaam"/>
		<xsl:text>, </xsl:text>
		<xsl:value-of select="tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam"/>
		<xsl:text> </xsl:text>
		<xsl:value-of select="tia:BAG_NummerAanduiding/tia:huisnummer"/>
		<xsl:if test="tia:BAG_NummerAanduiding/tia:huisletter and normalize-space(tia:BAG_NummerAanduiding/tia:huisletter) != ''">
			<xsl:text> </xsl:text>
			<xsl:value-of select="tia:BAG_NummerAanduiding/tia:huisletter"/>
		</xsl:if>
		<xsl:if test="tia:BAG_NummerAanduiding/tia:huisnummertoevoeging and normalize-space(tia:BAG_NummerAanduiding/tia:huisnummertoevoeging) != ''">
			<xsl:text> </xsl:text>
			<xsl:value-of select="tia:BAG_NummerAanduiding/tia:huisnummertoevoeging"/>
		</xsl:if>
	</xsl:template>
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:buitenlandsAdres" mode="do-correspondant-address">
		<xsl:if test="tia:regio and normalize-space(tia:regio) != ''">
			<xsl:value-of select="tia:regio"/>
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:value-of select="tia:woonplaats"/>
		<xsl:text>, </xsl:text>
		<xsl:value-of select="tia:adres"/>
		<xsl:text> </xsl:text>
		<xsl:value-of select="tia:land"/>
	</xsl:template>
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:postbusAdres" mode="do-correspondant-address">
		<xsl:text>postbus </xsl:text>
		<xsl:value-of select="tia:postbusnummer"/>
		<xsl:text> </xsl:text>
		<!-- Insert space between numbers and letters of post code -->
		<xsl:value-of select="concat(normalize-space(substring(tia:postcode, 1, 4)), ' ',
			normalize-space(substring(tia:postcode, 5)))"/>
		<xsl:text> </xsl:text>
		<xsl:value-of select="tia:woonplaatsnaam"/>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-capacity-for-legal-person
	*********************************************************
	Public: yes

	Identity transform: no

	Description: Hoedangheid text block.

	Input: tia:Hoedanigheid

	Params: relatedPersons - persons acting in Hoedanigheid for currently processed one
			shouldPrintColon - indicator if colon should be print at the end of the block
			representedByPreviousPerson - indicator if PNNP is represented by preceding PNNP persons

	Output: text

	Calls:
	(mode) do-person-details

	Called by:
	(mode) do-capacity-for-other-persons-in-groups-represented-by-managers
	(mode) do-capacity-for-more-persons-in-hoedanigheid
	(mode) do-party-legal-person
	(mode) do-party-legal-person-text-main-and-related-persons
	(mode) do-party-legal-person-text-main-and-related-persons-all-warrantors-and-main-person-represented-by-manager
	(mode) do-party-legal-person-text-main-and-related-persons-all-warrantors-represented-by-main-person
	(mode) do-party-legal-person-text-main-and-related-persons-warrantors-act-as-hoedanighied-for-each-other-next-representation
	(mode) do-party-legal-person-text-main-and-related-persons-warrantors-and-main-person-represented-in-groups-by-managers
	(mode) do-party-legal-person-text-main-and-related-persons-without-warrantors
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:Hoedanigheid" mode="do-capacity-for-legal-person">
		<xsl:param name="relatedPersons" select="self::node()[false()]"/>
		<xsl:param name="shouldPrintColon" select="'true'"/>
		<xsl:param name="representedByPreviousPerson" select="'false'"/>
		<xsl:variable name="forThem" select="tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvoorzich']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvoorzich']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space(current()/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvoorzich']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
		<xsl:variable name="capacity" select="tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidaanduiding']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidaanduiding']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space(current()/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidaanduiding']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
		<xsl:variable name="capacityNumber" select="tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidbenaming']/tia:tekst"/>
		<xsl:variable name="lastRelatedPerson" select="count($relatedPersons)"/>
		<xsl:variable name="named" select="tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvoornoemd']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvoornoemd']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space(current()/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvoornoemd']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
		<xsl:choose>
			<xsl:when test="translate($capacityNumber, $upper, $lower) = '1'">
				<xsl:if test="$relatedPersons[1]/tia:tia_Gegevens/tia:NHR_Rechtspersoon">
					<xsl:choose>
						<xsl:when test="$relatedPersons[1]/tia:tia_AanduidingPersoon">
							<xsl:value-of select="$relatedPersons[1]/tia:tia_AanduidingPersoon"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$relatedPersons[1]/tia:tia_Gegevens/tia:NHR_Rechtspersoon/tia:statutaireNaam"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
				<xsl:if test="$named">
					<xsl:if test="count($relatedPersons) > 0">
						<xsl:text> </xsl:text>
					</xsl:if>
					<xsl:value-of select="$named"/>
				</xsl:if>
				<xsl:text>, </xsl:text>
			</xsl:when>
			<xsl:when test="translate($capacityNumber, $upper, $lower) = '2'">
				<xsl:text>laatstgenoemde </xsl:text>
				<xsl:value-of select="$relatedPersons[1]/tia:tia_AanduidingRechtsvorm"/>
				<xsl:text>, </xsl:text>
			</xsl:when>
			<xsl:when test="translate($capacityNumber, $upper, $lower) = '3'">
				<xsl:text>welke </xsl:text>
				<xsl:value-of select="$relatedPersons[1]/tia:tia_AanduidingRechtsvorm"/>
				<xsl:text>, </xsl:text>
			</xsl:when>
			<xsl:when test="translate($capacityNumber, $upper, $lower) = '4'">
				<xsl:choose>
					<xsl:when test="$representedByPreviousPerson = 'true'">
						<xsl:variable name="hoedanigheidId" select="@id"/>
						<xsl:variable name="representedMainPerson" select="../tia:IMKAD_Persoon[descendant-or-self::tia:IMKAD_Persoon[concat('#', $hoedanigheidId) = tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href']]]"/>
						<xsl:variable name="isGerelateerdPersoonContainedLastPerson" select="$representedMainPerson[count($representedMainPerson)]/descendant::tia:GerelateerdPersoon[tia:rol='bestuurder' or tia:rol='partner' or tia:rol='huisgenoot' or tia:rol='volmachtgever']/tia:IMKAD_Persoon[concat('#', $hoedanigheidId) = tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href']]"/>
						<xsl:for-each select="$representedMainPerson">
							<xsl:variable name="currentPersonPosition" select="position()"/>
							<xsl:variable name="penultimateMainPerson" select="$currentPersonPosition + 1 = count($representedMainPerson)"/>
							<xsl:variable name="lastMainPerson" select="$currentPersonPosition = count($representedMainPerson)"/>
							<xsl:variable name="countAllPersonsRepresentedInCurrentPerson" select="count(descendant-or-self::tia:IMKAD_Persoon[concat('#', $hoedanigheidId) = tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href']])"/>
							<xsl:variable name="bestuurderPartnerHuisgenootPersons" select="descendant::tia:GerelateerdPersoon[tia:rol='bestuurder' or tia:rol='partner' or tia:rol='huisgenoot']/tia:IMKAD_Persoon[concat('#', $hoedanigheidId) = tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href']]"/>
							<xsl:variable name="volmachtgeverPersons" select="descendant::tia:GerelateerdPersoon[tia:rol='volmachtgever']/tia:IMKAD_Persoon[concat('#', $hoedanigheidId) = tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href']]"/>
							<xsl:variable name="countVolmachtgeverPersons" select="count($volmachtgeverPersons)"/>
							<!-- Bestuurder, partner and huisgenoot persons -->
							<xsl:for-each select="$bestuurderPartnerHuisgenootPersons">
								<xsl:apply-templates select="." mode="do-person-details"/>
								<xsl:choose>
									<xsl:when test="($lastMainPerson and position() + 1 = $countAllPersonsRepresentedInCurrentPerson)
													or ($penultimateMainPerson and not(isGerelateerdPersoonContainedLastPerson) and position() = $countAllPersonsRepresentedInCurrentPerson)">
										<xsl:text> en </xsl:text>
									</xsl:when>
									<xsl:when test="not($lastMainPerson) or ($lastMainPerson and (position() + 1 &lt; $countAllPersonsRepresentedInCurrentPerson))">
										<xsl:text>, </xsl:text>
									</xsl:when>
								</xsl:choose>
							</xsl:for-each>
							<!-- Main person -->
							<xsl:if test="concat('#', $hoedanigheidId) = tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href']">
								<xsl:apply-templates select="." mode="do-person-details"/>
								<xsl:choose>
									<xsl:when test="($lastMainPerson and $countVolmachtgeverPersons = 1)
													or ($penultimateMainPerson and not($isGerelateerdPersoonContainedLastPerson) and $countVolmachtgeverPersons = 0)">
										<xsl:text> en </xsl:text>
									</xsl:when>
									<xsl:when test="not($lastMainPerson) or ($lastMainPerson and $countVolmachtgeverPersons > 1)">
										<xsl:text>, </xsl:text>
									</xsl:when>
								</xsl:choose>
							</xsl:if>
							<!-- Volmachtgever person -->
							<xsl:for-each select="$volmachtgeverPersons">
								<xsl:apply-templates select="." mode="do-person-details"/>
								<xsl:choose>
									<xsl:when test="($lastMainPerson and (position() + 1) = $countVolmachtgeverPersons)
													or ($penultimateMainPerson and not($isGerelateerdPersoonContainedLastPerson) and position() = $countVolmachtgeverPersons)">
										<xsl:text> en </xsl:text>
									</xsl:when>
									<xsl:when test="not($lastMainPerson) or ($lastMainPerson and (position() + 1) &lt; $countVolmachtgeverPersons)">
										<xsl:text>, </xsl:text>
									</xsl:when>
								</xsl:choose>
							</xsl:for-each>
						</xsl:for-each>
					</xsl:when>
					<xsl:otherwise>
						<xsl:for-each select="$relatedPersons">
							<xsl:apply-templates select="." mode="do-person-details"/>
							<xsl:choose>
								<xsl:when test="position() + 1 = $lastRelatedPerson">
									<xsl:text> en </xsl:text>
								</xsl:when>
								<xsl:when test="position() + 1 &lt; $lastRelatedPerson">
									<xsl:text>, </xsl:text>
								</xsl:when>
							</xsl:choose>
						</xsl:for-each>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:if test="$named">
					<xsl:if test="count($relatedPersons) > 0">
						<xsl:text> </xsl:text>
					</xsl:if>
					<xsl:value-of select="$named"/>
				</xsl:if>
				<xsl:text>, </xsl:text>
			</xsl:when>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="translate($capacity, $upper, $lower) = 'te dezen handelend'">
				<xsl:value-of select="substring-before($capacity, 'handelend')"/>
				<xsl:if test="count($relatedPersons) > 1 and (not($capacityNumber) or ($capacityNumber and translate($capacityNumber, $upper, $lower) = '4'))">
					<xsl:text>gezamenlijk </xsl:text>
				</xsl:if>
				<xsl:value-of select="substring-after($capacity, 'dezen ')"/>
				<xsl:if test="$shouldPrintColon = 'true'">
					<xsl:text>:</xsl:text>
				</xsl:if>
			</xsl:when>
			<xsl:when test="translate($capacity, $upper, $lower) = 'te dezen rechtsgeldig vertegenwoordigend'">
				<xsl:value-of select="substring-before($capacity, 'rechtsgeldig')"/>
				<xsl:if test="count($relatedPersons) > 1 and (not($capacityNumber) or ($capacityNumber and translate($capacityNumber, $upper, $lower) = '4'))">
					<xsl:text>tezamen </xsl:text>
				</xsl:if>
				<xsl:value-of select="substring-after($capacity, 'dezen ')"/>
				<xsl:if test="$shouldPrintColon = 'true'">
					<xsl:text>:</xsl:text>
				</xsl:if>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-person-details
	*********************************************************
	Public: yes

	Identity transform: no

	Description: Person data.

	Input: tia:IMKAD_Persoon

	Params: none

	Output: text

	Calls:
	(mode) do-gender-salutation

	Called by:
	(mode) do-capacity-for-legal-person
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon" mode="do-person-details">
		<xsl:choose>
			<xsl:when test="tia:tia_Gegevens/tia:GBA_Ingezetene">
				<xsl:apply-templates select="tia:tia_Gegevens/tia:GBA_Ingezetene" mode="do-gender-salutation"/>
				<xsl:text> </xsl:text>
				<xsl:choose>
					<xsl:when test="tia:tia_Gegevens/tia:IMKAD_KadNatuurlijkPersoon">
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
						<xsl:value-of select="tia:tia_Gegevens/tia:GBA_Ingezetene/tia:naam/tia:voornamen"/>
						<xsl:if test="tia:tia_Gegevens/tia:GBA_Ingezetene/tia:tia_VoorvoegselsNaam
								and normalize-space(tia:tia_Gegevens/tia:GBA_Ingezetene/tia:tia_VoorvoegselsNaam) != ''">
							<xsl:text> </xsl:text>
							<xsl:value-of select="tia:tia_Gegevens/tia:GBA_Ingezetene/tia:tia_VoorvoegselsNaam"/>
						</xsl:if>
						<xsl:text> </xsl:text>
						<xsl:value-of select="tia:tia_Gegevens/tia:GBA_Ingezetene/tia:tia_NaamZonderVoorvoegsels"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="tia:tia_Gegevens/tia:IMKAD_NietIngezetene">
				<xsl:apply-templates select="tia:tia_Gegevens/tia:IMKAD_NietIngezetene" mode="do-gender-salutation"/>
				<xsl:text> </xsl:text>
				<xsl:value-of select="tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:voornamen"/>
				<xsl:if test="tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:voorvoegsels
						and normalize-space(tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:voorvoegsels) != ''">
					<xsl:text> </xsl:text>
					<xsl:value-of select="tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:voorvoegsels"/>
				</xsl:if>
				<xsl:text> </xsl:text>
				<xsl:value-of select="tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:geslachtsnaam"/>
			</xsl:when>
			<xsl:when test="tia:tia_Gegevens/tia:NHR_Rechtspersoon">
				<xsl:choose>
					<xsl:when test="tia:tia_AanduidingPersoon">
						<xsl:value-of select="tia:tia_AanduidingPersoon"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="tia:tia_Gegevens/tia:NHR_Rechtspersoon/tia:statutaireNaam"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-capacity-variant-for-legal-person
	*********************************************************
	Public: no

	Identity transform: no

	Description: Hoedangheid variants text block.

	Input: tia:Hoedanigheid

	Params: relatedPersons - persons acting in hoedanigheid for currently processed one

	Output: text

	Calls: none

	Called by:
	(mode) do-capacity-for-more-persons-in-hoedanigheid
	(mode) do-capacity-for-other-persons-in-groups-represented-by-managers
	(mode) do-party-legal-person
	(mode) do-party-legal-person-text-main-and-related-persons-all-warrantors-represented-by-main-person
	(mode) do-party-legal-person-text-main-and-related-persons-all-warrantors-and-main-person-represented-by-manager
	(mode) do-party-legal-person-text-main-and-related-persons
	(mode) do-party-legal-person-text-main-and-related-persons-warrantors-act-as-hoedanighied-for-each-other-next-representation
	(mode) do-party-legal-person-text-main-and-related-persons-warrantors-and-main-person-represented-in-groups-by-managers
	(mode) do-party-legal-person-text-main-and-related-persons-without-warrantors
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:Hoedanigheid" mode="do-capacity-variant-for-legal-person">
		<xsl:param name="relatedPersons" select="self::node()[false()]"/>
		<xsl:variable name="capacityVariant" select="tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvariant']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
				translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvariant']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
				translate(normalize-space(current()/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvariant']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
		<xsl:variable name="numberOfPersons" select="count($relatedPersons)"/>
		<xsl:variable name="genderOfFirstLegalPerson" select="$relatedPersons[1]/tia:tia_Gegevens/tia:NHR_Rechtspersoon/tia:rechtsvormSub"/>
		<xsl:variable name="genderFromKodesFile" select="$legalPersonNames[translate(Value[@ColumnRef = 'C']/SimpleValue, $upper, $lower) = translate($genderOfFirstLegalPerson, $upper, $lower)]/Value[@ColumnRef = 'E']/SimpleValue"/>
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
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>hun</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$capacityVariant = '1'">
				<xsl:variable name="capacityTextVariant1" select="$keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidtekstvariant1']/tia:tekst[
						position() = translate(normalize-space(current()/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidtekstvariant1']/tia:tekst), $upper, $lower)]"/>
				<xsl:choose>
					<xsl:when test="$numberOfPersons = 1">
						<xsl:choose>
							<xsl:when test="contains($capacityTextVariant1, 'bevoegde bestuurders')">
								<xsl:value-of select="concat(substring-before($capacityTextVariant1, 'bevoegde bestuurders'), 'bevoegd bestuurder', substring-after($capacityTextVariant1, 'bevoegde bestuurders'))"/>
							</xsl:when>
							<xsl:when test="contains($capacityTextVariant1, 'bevoegde directeuren')">
								<xsl:value-of select="concat(substring-before($capacityTextVariant1, 'bevoegde directeuren'), 'bevoegd directeur', substring-after($capacityTextVariant1, 'bevoegde directeuren'))"/>
							</xsl:when>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$capacityTextVariant1"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$capacityVariant = '2'">
				<xsl:variable name="capacityTextVariant2" select="$keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidtekstvariant2']/tia:tekst[
						position() = translate(normalize-space(current()/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidtekstvariant2']/tia:tekst), $upper, $lower)]"/>
				<xsl:variable name="capacityTextVariant2WithGender">
					<xsl:choose>
						<xsl:when test="contains($capacityTextVariant2, 'zijn/haar/hun')">
							<xsl:value-of select="concat(substring-before($capacityTextVariant2, 'zijn/haar/hun'), $gender, substring-after($capacityTextVariant2, 'zijn/haar/hun'))"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$capacityTextVariant2"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<xsl:choose>
					<xsl:when test="$numberOfPersons = 1">
						<xsl:choose>
							<xsl:when test="contains($capacityTextVariant2WithGender, 'bevoegde bestuurders')">
								<xsl:value-of select="concat(substring-before($capacityTextVariant2WithGender, 'bevoegde bestuurders'), 'bevoegd bestuurder', substring-after($capacityTextVariant2WithGender, 'bevoegde bestuurders'))"/>
							</xsl:when>
							<xsl:when test="contains($capacityTextVariant2WithGender, 'bevoegde directeuren')">
								<xsl:value-of select="concat(substring-before($capacityTextVariant2WithGender, 'bevoegde directeuren'), 'bevoegd directeur', substring-after($capacityTextVariant2WithGender, 'bevoegde directeuren'))"/>
							</xsl:when>
							<xsl:when test="contains($capacityTextVariant2WithGender, 'bestuurders')">
								<xsl:value-of select="concat(substring-before($capacityTextVariant2WithGender, 'bestuurders'), 'bestuurder', substring-after($capacityTextVariant2WithGender, 'bestuurders'))"/>
							</xsl:when>
							<xsl:when test="contains($capacityTextVariant2WithGender, 'directeuren')">
								<xsl:value-of select="concat(substring-before($capacityTextVariant2WithGender, 'directeuren'), 'directeur', substring-after($capacityTextVariant2WithGender, 'directeuren'))"/>
							</xsl:when>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$capacityTextVariant2WithGender"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$capacityVariant = '3'">
				<xsl:variable name="capacityTextVariant3" select="$keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidtekstvariant3']/tia:tekst[
						position() = translate(normalize-space(current()/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidtekstvariant3']/tia:tekst), $upper, $lower)]"/>
				<xsl:choose>
					<xsl:when test="$numberOfPersons = 1">
						<xsl:choose>
							<xsl:when test="contains($capacityTextVariant3, 'vertegenwoordigers')">
								<xsl:value-of select="concat(substring-before($capacityTextVariant3, 'vertegenwoordigers'), 'vertegenwoordiger', substring-after($capacityTextVariant3, 'vertegenwoordigers'))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="$capacityTextVariant3"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$capacityTextVariant3"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$capacityVariant = '4'">
				<xsl:text>in </xsl:text>
				<xsl:value-of select="$gender"/>
				<xsl:text> hoedanigheid van burgemeester</xsl:text>
				<xsl:if test="$numberOfPersons > 1">
					<xsl:text>s</xsl:text>
				</xsl:if>
				<xsl:text> van</xsl:text>
			</xsl:when>
			<xsl:when test="$capacityVariant = '5'">
				<xsl:variable name="capacityTextVariant5" select="$keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidtekstvariant5']/tia:tekst[
						position() = translate(normalize-space(current()/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidtekstvariant5']/tia:tekst), $upper, $lower)]"/>
				<xsl:choose>
					<xsl:when test="$numberOfPersons = 1">
						<xsl:choose>
							<xsl:when test="contains($capacityTextVariant5, 'mondeling gevolmachtigden') or contains($capacityTextVariant5, 'schriftelijk gevolmachtigden')">
								<xsl:value-of select="concat(substring-before($capacityTextVariant5, 'gevolmachtigden'), 'gevolmachtigde', substring-after($capacityTextVariant5, 'gevolmachtigden'))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="$capacityTextVariant5"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$capacityTextVariant5"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$capacityVariant = '6'">
				<xsl:variable name="capacityTextVariant6" select="$keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidtekstvariant6']/tia:tekst[
						position() = translate(normalize-space(current()/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidtekstvariant6']/tia:tekst), $upper, $lower)]"/>
				<xsl:variable name="placeVariant6">
					<xsl:value-of select="tia:gegevensOndertekening[tia:soortOndertekening = 'beschikking kantonrechter']/tia:naamGemeente"/>
				</xsl:variable>
				<xsl:variable name="dateVariant6">
					<xsl:value-of select="tia:gegevensOndertekening[tia:soortOndertekening = 'beschikking kantonrechter']/tia:datum"/>
				</xsl:variable>
				<xsl:variable name="dateVariant6Text">
					<xsl:if test="$dateVariant6 != ''">
						<xsl:value-of select="kef:convertDateToText(substring(string($dateVariant6), 0, 11))"/>
					</xsl:if>
				</xsl:variable>
				<xsl:variable name="capacityTextVariant6WithGender">
					<xsl:choose>
						<xsl:when test="contains($capacityTextVariant6, 'zijn/haar/hun')">
							<xsl:value-of select="concat(substring-before($capacityTextVariant6, 'zijn/haar/hun'), $gender, substring-after($capacityTextVariant6, 'zijn/haar/hun'))"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$capacityTextVariant6"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<xsl:variable name="capacityTextVariant6WithGenderPlace">
					<xsl:choose>
						<xsl:when test="contains($capacityTextVariant6WithGender, 'plaats')">
							<xsl:value-of select="concat(substring-before($capacityTextVariant6WithGender, 'plaats'), $placeVariant6, substring-after($capacityTextVariant6WithGender, 'plaats'))"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$capacityTextVariant6WithGender"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<xsl:variable name="capacityTextVariant6WithGenderPlaceDate">
					<xsl:choose>
						<xsl:when test="contains($capacityTextVariant6WithGenderPlace, 'datum')">
							<xsl:value-of select="concat(substring-before($capacityTextVariant6WithGenderPlace, 'datum'), $dateVariant6Text, substring-after($capacityTextVariant6WithGenderPlace, 'datum'))"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$capacityTextVariant6WithGenderPlace"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<xsl:choose>
					<xsl:when test="$numberOfPersons = 1">
						<xsl:choose>
							<xsl:when test="contains($capacityTextVariant6WithGenderPlaceDate, 'curatoren')">
								<xsl:value-of select="concat(substring-before($capacityTextVariant6WithGenderPlaceDate, 'curatoren'), 'curator', substring-after($capacityTextVariant6WithGenderPlaceDate, 'curatoren'))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="$capacityTextVariant6WithGenderPlaceDate"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$capacityTextVariant6WithGenderPlaceDate"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$capacityVariant = '7'">
				<xsl:variable name="capacityTextVariant7" select="$keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidtekstvariant7']/tia:tekst[
						position() = translate(normalize-space(current()/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidtekstvariant7']/tia:tekst), $upper, $lower)]"/>
				<xsl:variable name="placeVariant7">
					<xsl:value-of select="tia:gegevensOndertekening[tia:soortOndertekening = 'beschikking kantonrechter']/tia:naamGemeente"/>
				</xsl:variable>
				<xsl:variable name="dateVariant7">
					<xsl:value-of select="tia:gegevensOndertekening[tia:soortOndertekening = 'beschikking kantonrechter']/tia:datum"/>
				</xsl:variable>
				<xsl:variable name="dateVariant7Text">
					<xsl:if test="$dateVariant7 != ''">
						<xsl:value-of select="kef:convertDateToText(substring(string($dateVariant7), 0, 11))"/>
					</xsl:if>
				</xsl:variable>
				<xsl:variable name="capacityTextVariant7WithPlace">
					<xsl:choose>
						<xsl:when test="contains($capacityTextVariant7, 'plaats')">
							<xsl:value-of select="concat(substring-before($capacityTextVariant7, 'plaats'), $placeVariant7, substring-after($capacityTextVariant7, 'plaats'))"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$capacityTextVariant7"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<xsl:variable name="capacityTextVariant7WithPlaceDate">
					<xsl:choose>
						<xsl:when test="contains($capacityTextVariant7WithPlace, 'datum')">
							<xsl:value-of select="concat(substring-before($capacityTextVariant7WithPlace, 'datum'), $dateVariant7Text, substring-after($capacityTextVariant7WithPlace, 'datum'))"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$capacityTextVariant7WithPlace"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<xsl:choose>
					<xsl:when test="$numberOfPersons = 1">
						<xsl:choose>
							<xsl:when test="contains($capacityTextVariant7WithPlaceDate, 'bewindvoerders')">
								<xsl:value-of select="concat(substring-before($capacityTextVariant7WithPlaceDate, 'bewindvoerders'), 'bewindvoerder', substring-after($capacityTextVariant7WithPlaceDate, 'bewindvoerders'))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="$capacityTextVariant7WithPlaceDate"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$capacityTextVariant7WithPlaceDate"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$capacityVariant = '8'">
				<xsl:variable name="capacityTextVariant8" select="$keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidtekstvariant8']/tia:tekst[
						position() = translate(normalize-space(current()/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidtekstvariant8']/tia:tekst), $upper, $lower)]"/>
				<xsl:choose>
					<xsl:when test="$numberOfPersons = 1">
						<xsl:choose>
							<xsl:when test="contains($capacityTextVariant8, 'gezamenlijk')">
								<xsl:value-of select="concat(substring-before($capacityTextVariant8, 'gezamenlijk'), substring-after($capacityTextVariant8, 'gezamenlijk'))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="$capacityTextVariant8"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$capacityTextVariant8"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$capacityVariant = '10'">
				<xsl:variable name="capacityTextVariant10" select="$keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidtekstvariant10']/tia:tekst[
						position() = translate(normalize-space(current()/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidtekstvariant10']/tia:tekst), $upper, $lower)]"/>
				<xsl:choose>
					<xsl:when test="$numberOfPersons = 1">
						<xsl:choose>
							<xsl:when test="contains($capacityTextVariant10, 'zaakwaarnemers')">
								<xsl:value-of select="concat(substring-before($capacityTextVariant10, 'zaakwaarnemers'), 'zaakwaarnemer', substring-after($capacityTextVariant10, 'zaakwaarnemers'))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="$capacityTextVariant10"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$capacityTextVariant10"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
