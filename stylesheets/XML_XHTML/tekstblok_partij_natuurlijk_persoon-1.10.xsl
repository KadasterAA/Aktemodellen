<?xml version="1.0" encoding="UTF-8"?>
<!--
*********************************************************
Stylesheet: tekstblok_partij_natuurlijk_persoon.xsl
Version: 1.10
*********************************************************
Description:
Party natural person text block.

Public:
(mode) do-party-natural-person

Private:
(mode) do-party-natural-person-common
(mode) do-party-natural-person-addresses
(mode) do-party-natural-person-single
(mode) do-party-natural-person-person-pair
(mode) do-party-natural-person-person-pair-person-one-common
(mode) do-party-natural-person-person-pair-person-two-common
(mode) do-person-pair-partner-variant-two
(mode) do-person-pair-partner-variant-four
(mode) do-person-pair-representative-variant-five
(mode) do-person-pair-representative-variant-seven
(mode) do-person-pair-partner-representative-variant-six
(mode) do-person-pair-partner-representative-variant-eight
(mode) do-person-pair-housemate-variant-three

-->
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
	xmlns:tia="http://www.kadaster.nl/schemas/KIK/TIA_Algemeen"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	exclude-result-prefixes="tia xsl"
	version="1.0">

	<!--
	*********************************************************
	Mode: do-party-natural-person
	*********************************************************
	Public: yes

	Identity transform: no

	Description: Party natural person text block.

	Input: tia:IMKAD_Persoon

	Params: maxColspan - maximal colspan in table
			start - order number of person in nested party
			nestedParty - indicator if current person's party is nested one
			anchorName - name of the anchor that will be used in first <td> element

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
		<xsl:param name="maxColspan" select="number('0')"/>
		<xsl:param name="start" select="number('0')"/>
		<xsl:param name="nestedParty" select="'false'"/>
		<xsl:param name="anchorName" select="''"/>
		<xsl:param name="personTerminator" select="';'"/>

		<xsl:choose>
			<xsl:when test="tia:GerelateerdPersoon">
				<xsl:apply-templates select="." mode="do-party-natural-person-person-pair">
					<xsl:with-param name="maxColspan" select="$maxColspan"/>
					<xsl:with-param name="start" select="$start"/>
					<xsl:with-param name="nestedParty" select="$nestedParty"/>
					<xsl:with-param name="anchorName" select="$anchorName"/>
					<xsl:with-param name="personTerminator" select="$personTerminator"/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="." mode="do-party-natural-person-single">
					<xsl:with-param name="maxColspan" select="$maxColspan"/>
					<xsl:with-param name="start" select="$start"/>
					<xsl:with-param name="nestedParty" select="$nestedParty"/>
					<xsl:with-param name="anchorName" select="$anchorName"/>
					<xsl:with-param name="personTerminator" select="$personTerminator"/>
				</xsl:apply-templates>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<!--
	*********************************************************
	Mode: do-party-natural-person-common
	*********************************************************
	Public: no

	Identity transform: no

	Description: Common text block for each type of natural persons.

	Input: tia:IMKAD_Persoon

	Params: none

	Output: text

	Calls:
	(mode) do-natural-person
	(mode) do-identity-document

	Called by:
	(mode) do-party-natural-person-single
	(mode) do-person-pair-partner-variant-two
	(mode) do-person-pair-partner-variant-four
	(mode) do-person-pair-representative-variant-five
	(mode) do-person-pair-representative-variant-seven
	(mode) do-person-pair-partner-representative-variant-six
	(mode) do-person-pair-partner-representative-variant-eight
	(mode) do-person-pair-housemate-variant-three
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon" mode="do-party-natural-person-common">
		<xsl:apply-templates select="." mode="do-natural-person"/>
		<xsl:text>, </xsl:text>
		<xsl:if test="tia:tia_Legitimatiebewijs">
			<xsl:apply-templates select="tia:tia_Legitimatiebewijs" mode="do-identity-document">
				<xsl:with-param name="gender" select="tia:tia_Gegevens/tia:GBA_Ingezetene/tia:geslacht/tia:geslachtsaanduiding
					| tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:geslacht"/>
			</xsl:apply-templates>
			<xsl:text>, </xsl:text>
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
	(mode) do-person-pair-partner-variant-four
	(mode) do-person-pair-representative-variant-five
	(mode) do-person-pair-representative-variant-seven
	(mode) do-person-pair-partner-representative-variant-six
	(mode) do-person-pair-partner-representative-variant-eight
	(mode) do-person-pair-housemate-variant-three
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon" mode="do-party-natural-person-addresses">
		<xsl:param name="commonFutureAddress" select="'true'"/>
		<xsl:text>wonende te </xsl:text>
		<xsl:apply-templates select="tia:IMKAD_WoonlocatiePersoon" mode="do-address"/>
		<xsl:if test="tia:toekomstigAdres and translate($commonFutureAddress, $upper, $lower) = 'true'">
			<xsl:text> (toekomstig adres: </xsl:text>
			<xsl:apply-templates select="tia:toekomstigAdres" mode="do-address"/>
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

	Params: maxColspan - maximal colspan in table
			start - order number of person in nested party
			nestedParty - indicator if current person's party is nested one
			anchorName - name of the anchor that will be positioned in first <td> element

	Output: XHTML

	Calls:
	(mode) do-party-natural-person-common
	(mode) do-marital-status
	(mode) do-party-natural-person-addresses

	Called by:
	(mode) do-party-natural-person
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon" mode="do-party-natural-person-single">
		<xsl:param name="maxColspan" select="number('0')"/>
		<xsl:param name="start" select="number('0')"/>
		<xsl:param name="nestedParty" select="'false'"/>
		<xsl:param name="anchorName" select="''"/>
		<xsl:param name="personTerminator" />
		
		<xsl:variable name="numberOfPersons" select="count(preceding-sibling::tia:IMKAD_Persoon) + count(following-sibling::tia:IMKAD_Persoon)"/>
		<xsl:variable name="numberOfPersonPairs" select="count(preceding-sibling::tia:IMKAD_Persoon[tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene]/tia:GerelateerdPersoon[tia:rol]) 
			+ count(following-sibling::tia:IMKAD_Persoon[tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene]/tia:GerelateerdPersoon[tia:rol])"/>
		
		<tr>
			<xsl:choose>
				<xsl:when test="../tia:Gevolmachtigde">
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="count(preceding-sibling::tia:IMKAD_Persoon) = 0">
							<xsl:if test="$nestedParty = 'true'">
								<td class="number" valign="top">
									<xsl:text>&#xFEFF;</xsl:text>
								</td>
							</xsl:if>
							<td class="number" valign="top">
								<xsl:if test="translate($nestedParty, $upper, $lower) = 'false' or (translate($nestedParty, $upper, $lower) = 'true' and count(../preceding-sibling::tia:Partij) > 0)">
									<xsl:choose>
										<xsl:when test="$anchorName != ''">
											<a name="{$anchorName}" class="location" style="_position: relative;">&#xFEFF;</a>
										</xsl:when>
										<xsl:otherwise>
											<a name="{current()/parent::node()/@id}" class="location" style="_position: relative;">&#xFEFF;</a>
										</xsl:otherwise>									
									</xsl:choose>
								</xsl:if>
								<xsl:choose>
									<xsl:when test="translate($nestedParty, $upper, $lower) = 'true'">
										<xsl:choose>
											<xsl:when test="$start = '0'">
												<xsl:number value="count(preceding-sibling::tia:IMKAD_Persoon) + 1" format="a"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:number value="count(preceding-sibling::tia:IMKAD_Persoon) + $start" format="a"/>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:text>.</xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="count(../preceding-sibling::tia:Partij) + 1"/>
										<xsl:text>.</xsl:text>
									</xsl:otherwise>
								</xsl:choose>
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
			<xsl:if test="$numberOfPersons > 0 and not(translate($nestedParty, $upper, $lower) = 'true' and count(preceding-sibling::tia:IMKAD_Persoon) = 0)">
				<td class="number" valign="top">
					<xsl:choose>
						<xsl:when test="translate($nestedParty, $upper, $lower) = 'true'">
							<xsl:choose>
								<xsl:when test="$start = '0'">
									<xsl:number value="count(preceding-sibling::tia:IMKAD_Persoon) + 1" format="a"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:number value="count(preceding-sibling::tia:IMKAD_Persoon) + $start" format="a"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:otherwise>
							<xsl:number value="count(preceding-sibling::tia:IMKAD_Persoon) + 1" format="a"/>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:text>.</xsl:text>							
				</td>
			</xsl:if>
			<td>
				<xsl:choose>
					<xsl:when test="$maxColspan > 2">
						<xsl:attribute name="colspan">
							<xsl:choose>
								<xsl:when test="$numberOfPersons = 0 and translate($nestedParty, $upper, $lower) = 'true'">
									<xsl:value-of select="$maxColspan - 1"/>
								</xsl:when>
								<xsl:when test="$numberOfPersons = 0">
									<xsl:value-of select="$maxColspan"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$maxColspan - 1"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:attribute>
					</xsl:when>
					<xsl:when test="$maxColspan = 2 and $numberOfPersons = 0 and translate($nestedParty, $upper, $lower) = 'false'">
						<xsl:attribute name="colspan">
							<xsl:value-of select="$maxColspan"/>
						</xsl:attribute>
					</xsl:when>
				</xsl:choose>
				<xsl:apply-templates select="." mode="do-party-natural-person-common"/>
				<xsl:apply-templates select="." mode="do-marital-status"/>
				<xsl:text>, </xsl:text>
				<xsl:apply-templates select="." mode="do-party-natural-person-addresses"/>
				<xsl:value-of select="$personTerminator"/>
			</td>
		</tr>
		
	</xsl:template>
	
	<!--
	*********************************************************
	Mode: do-party-natural-person-person-pair
	*********************************************************
	Public: no

	Identity transform: no

	Description: Party natural persons pair text block.

	Input: tia:IMKAD_Persoon

	Params: maxColspan - maximal colspan in table
			start - order number of person in nested party
			nestedParty - indicator if current person's party is nested one
			anchorName - name of the anchor that will be positioned in first <td> element

	Output: XHTML

	Calls:
	(mode) do-person-pair-partner-variant-two
	(mode) do-person-pair-partner-variant-four
	(mode) do-person-pair-partner-representative-variant-six
	(mode) do-person-pair-partner-representative-variant-eight
	(mode) do-person-pair-representative-variant-five
	(mode) do-person-pair-representative-variant-seven
	(mode) do-person-pair-housemate-variant-three

	Called by:
	(mode) do-party-natural-person
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon" mode="do-party-natural-person-person-pair">
		<xsl:param name="maxColspan" select="number('0')"/>
		<xsl:param name="start" select="number('0')"/>
		<xsl:param name="nestedParty" select="'false'"/>
		<xsl:param name="anchorName" select="''"/>
		<xsl:param name="personTerminator" />
		
		<xsl:variable name="personPairVariant" select="tia:GerelateerdPersoon/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_keuzeblokvariant']/tia:tekst" />

		<xsl:choose>
			<xsl:when test="$personPairVariant = '2'">
				<xsl:apply-templates select="." mode="do-person-pair-partner-variant-two">
					<xsl:with-param name="maxColspan" select="$maxColspan"/>
					<xsl:with-param name="start" select="$start"/>
					<xsl:with-param name="nestedParty" select="$nestedParty"/>
					<xsl:with-param name="anchorName" select="$anchorName"/>
					<xsl:with-param name="personTerminator" select="$personTerminator"/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:when test="$personPairVariant = '4'">
				<xsl:apply-templates select="." mode="do-person-pair-partner-variant-four">
					<xsl:with-param name="maxColspan" select="$maxColspan"/>
					<xsl:with-param name="start" select="$start"/>
					<xsl:with-param name="nestedParty" select="$nestedParty"/>
					<xsl:with-param name="anchorName" select="$anchorName"/>
					<xsl:with-param name="personTerminator" select="$personTerminator"/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:when test="$personPairVariant = '6'">
				<xsl:apply-templates select="." mode="do-person-pair-partner-representative-variant-six">
					<xsl:with-param name="maxColspan" select="$maxColspan"/>
					<xsl:with-param name="start" select="$start"/>
					<xsl:with-param name="nestedParty" select="$nestedParty"/>
					<xsl:with-param name="anchorName" select="$anchorName"/>
					<xsl:with-param name="personTerminator" select="$personTerminator"/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:when test="$personPairVariant = '8'">
				<xsl:apply-templates select="." mode="do-person-pair-partner-representative-variant-eight">
					<xsl:with-param name="maxColspan" select="$maxColspan"/>
					<xsl:with-param name="start" select="$start"/>
					<xsl:with-param name="nestedParty" select="$nestedParty"/>
					<xsl:with-param name="anchorName" select="$anchorName"/>
					<xsl:with-param name="personTerminator" select="$personTerminator"/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:when test="$personPairVariant = '5'">
				<xsl:apply-templates select="." mode="do-person-pair-representative-variant-five">
					<xsl:with-param name="maxColspan" select="$maxColspan"/>
					<xsl:with-param name="start" select="$start"/>
					<xsl:with-param name="nestedParty" select="$nestedParty"/>
					<xsl:with-param name="anchorName" select="$anchorName"/>
					<xsl:with-param name="personTerminator" select="$personTerminator"/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:when test="$personPairVariant = '7'">
				<xsl:apply-templates select="." mode="do-person-pair-representative-variant-seven">
					<xsl:with-param name="maxColspan" select="$maxColspan"/>
					<xsl:with-param name="start" select="$start"/>
					<xsl:with-param name="nestedParty" select="$nestedParty"/>
					<xsl:with-param name="anchorName" select="$anchorName"/>
					<xsl:with-param name="personTerminator" select="$personTerminator"/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:when test="$personPairVariant = '3'">
				<xsl:apply-templates select="." mode="do-person-pair-housemate-variant-three">
					<xsl:with-param name="maxColspan" select="$maxColspan"/>
					<xsl:with-param name="start" select="$start"/>
					<xsl:with-param name="nestedParty" select="$nestedParty"/>
					<xsl:with-param name="anchorName" select="$anchorName"/>
					<xsl:with-param name="personTerminator" select="$personTerminator"/>
				</xsl:apply-templates>
			</xsl:when>
			<!-- Partner is default for preview -->
			<xsl:otherwise>
				<xsl:apply-templates select="." mode="do-person-pair-partner-variant-four">
					<xsl:with-param name="maxColspan" select="$maxColspan"/>
					<xsl:with-param name="start" select="$start"/>
					<xsl:with-param name="nestedParty" select="$nestedParty"/>
					<xsl:with-param name="anchorName" select="$anchorName"/>
					<xsl:with-param name="personTerminator" select="$personTerminator"/>
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
			nestedParty - indicator if current person's party is nested one
			anchorName - name of the anchor that will be positioned in first <td> element

	Output: XHTML

	Calls: none

	Called by:
	(mode) do-person-pair-partner-variant-two
	(mode) do-person-pair-partner-variant-four
	(mode) do-person-pair-representative-variant-five
	(mode) do-person-pair-representative-variant-seven
	(mode) do-person-pair-partner-representative-variant-six
	(mode) do-person-pair-partner-representative-variant-eight
	(mode) do-person-pair-housemate-variant-three
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon" mode="do-party-natural-person-person-pair-person-one-common">
		<xsl:param name="start" select="number('0')"/>
		<xsl:param name="nestedParty" select="'false'"/>
		<xsl:param name="anchorName" select="''"/>
		<xsl:variable name="numberOfPersons" select="count(preceding-sibling::tia:IMKAD_Persoon) + count(following-sibling::tia:IMKAD_Persoon)"/>
		
		<xsl:choose>
				<xsl:when test="../tia:Gevolmachtigde">
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="count(preceding-sibling::tia:IMKAD_Persoon) = 0">
							<td class="number" valign="top">
								<xsl:if test="translate($nestedParty, $upper, $lower) = 'false' or (translate($nestedParty, $upper, $lower) = 'true' and count(../preceding-sibling::tia:Partij) > 0)">
									<xsl:choose>
										<xsl:when test="$anchorName != ''">
											<a name="{$anchorName}" class="location" style="_position: relative;">&#xFEFF;</a>
										</xsl:when>
										<xsl:otherwise>
											<a name="{current()/parent::node()/@id}" class="location" style="_position: relative;">&#xFEFF;</a>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:if>
								<xsl:choose>
									<xsl:when test="translate($nestedParty, $upper, $lower) = 'true'">
										<xsl:text>&#xFEFF;</xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="count(../preceding-sibling::tia:Partij) + 1"/>
										<xsl:text>.</xsl:text>
									</xsl:otherwise>
								</xsl:choose>
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
			<xsl:choose>
				<xsl:when test="$numberOfPersons = 0">
					<td class="number" valign="top">
						<xsl:choose>
							<xsl:when test="translate($nestedParty, $upper, $lower) = 'true'">
								<xsl:choose>
									<xsl:when test="$start = '0'">
										<xsl:number value="1" format="a"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:number value="$start" format="a"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:when>
							<xsl:otherwise>
								<xsl:number value="1" format="a"/>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:text>.</xsl:text>
					</td>
				</xsl:when>
				<xsl:otherwise>
					<td class="number" valign="top">
						<xsl:choose>
							<xsl:when test="translate($nestedParty, $upper, $lower) = 'true'">
								<xsl:choose>
									<xsl:when test="$start = '0'">
										<xsl:number value="count(preceding-sibling::tia:IMKAD_Persoon) + 1" format="a"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:number value="count(preceding-sibling::tia:IMKAD_Persoon) + $start" format="a"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:when>
							<xsl:otherwise>
								<xsl:number value="count(preceding-sibling::tia:IMKAD_Persoon) + 1" format="a"/>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:text>.</xsl:text>
					</td>
					<td class="number" valign="top">
						<xsl:text>1.</xsl:text>
					</td>
				</xsl:otherwise>
			</xsl:choose>
	</xsl:template>
	
	<!--
	*********************************************************
	Mode: do-party-natural-person-person-pair-person-two-common
	*********************************************************
	Public: no

	Identity transform: no

	Description: Common text block for second person in person pair.

	Input: tia:IMKAD_Persoon

	Params: start - order number of person in nested party
			nestedParty - indicator if current person's party is nested one

	Output: XHTML

	Calls: none

	Called by:
	(mode) do-person-pair-partner-variant-two
	(mode) do-person-pair-partner-variant-four
	(mode) do-person-pair-representative-variant-five
	(mode) do-person-pair-representative-variant-seven
	(mode) do-person-pair-partner-representative-variant-six
	(mode) do-person-pair-partner-representative-variant-eight
	(mode) do-person-pair-housemate-variant-three
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon" mode="do-party-natural-person-person-pair-person-two-common">
		<xsl:param name="start" select="number('0')"/>
		<xsl:param name="nestedParty" select="'false'"/>
		<xsl:variable name="numberOfPersons" select="count(preceding-sibling::tia:IMKAD_Persoon) + count(following-sibling::tia:IMKAD_Persoon)"/>
		
		<td class="number" valign="top">
			<xsl:text>&#xFEFF;</xsl:text>
		</td>
		<xsl:choose>
			<xsl:when test="$numberOfPersons = 0">
				<td class="number" valign="top">
					<xsl:choose>
						<xsl:when test="translate($nestedParty, $upper, $lower) = 'true'">
							<xsl:choose>
								<xsl:when test="$start = '0'">
									<xsl:number value="2" format="a"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:number value="$start + 1" format="a"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:otherwise>
							<xsl:number value="2" format="a"/>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:text>.</xsl:text>
				</td>
			</xsl:when>
			<xsl:otherwise>
				<td class="number" valign="top">
					<xsl:text>&#xFEFF;</xsl:text>
				</td>
				<td class="number" valign="top">
					<xsl:text>2.</xsl:text>
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

	Params: maxColspan - maximal colspan in table	
			start - order number of person in nested party
			nestedParty - indicator if current person's party is nested one
			anchorName - name of the anchor that will be positioned in first <td> element

	Output: XHTML

	Calls:
	(mode) do-party-natural-person-person-pair-person-one-common
	(mode) do-party-natural-person-person-pair-person-two-common
	(mode) do-natural-person
	(mode) do-identity-document
	(mode) do-party-natural-person-common
	(mode) do-marital-status-partners
	(mode) do-party-natural-person-addresses

	Called by:
	(mode) do-party-natural-person-person-pair
	-->
	<xsl:template match="tia:IMKAD_Persoon" mode="do-person-pair-partner-variant-four">
		<xsl:param name="maxColspan" select="number('0')"/>
		<xsl:param name="start" select="number('0')"/>
		<xsl:param name="nestedParty" select="'false'"/>
		<xsl:param name="anchorName" select="''"/>
		<xsl:param name="personTerminator" />
					
		<tr>
			<xsl:apply-templates select="." mode="do-party-natural-person-person-pair-person-one-common">
				<xsl:with-param name="start" select="$start"/>
				<xsl:with-param name="nestedParty" select="$nestedParty"/>
				<xsl:with-param name="anchorName" select="$anchorName"/>
			</xsl:apply-templates>
			<td>
				<xsl:if test="($maxColspan > 2) and ((count(preceding-sibling::tia:IMKAD_Persoon) + count(following-sibling::tia:IMKAD_Persoon)) = 0)">
					<xsl:attribute name="colspan">					
						<xsl:value-of select="$maxColspan - 1"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="." mode="do-natural-person"/>
				<xsl:if test="tia:tia_Legitimatiebewijs">
					<xsl:text>, </xsl:text>
					<xsl:apply-templates select="tia:tia_Legitimatiebewijs" mode="do-identity-document">
						<xsl:with-param name="gender" select="tia:tia_Gegevens/tia:GBA_Ingezetene/tia:geslacht/tia:geslachtsaanduiding
							| tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:geslacht"/>
					</xsl:apply-templates>
				</xsl:if>
				<xsl:text>;</xsl:text>
			</td>
		</tr>
		<tr>
			<xsl:apply-templates select="." mode="do-party-natural-person-person-pair-person-two-common">
				<xsl:with-param name="start" select="$start"/>
				<xsl:with-param name="nestedParty" select="$nestedParty"/>
			</xsl:apply-templates>
			<td>
				<xsl:if test="($maxColspan > 2) and ((count(preceding-sibling::tia:IMKAD_Persoon) + count(following-sibling::tia:IMKAD_Persoon)) = 0)">
					<xsl:attribute name="colspan">					
						<xsl:value-of select="$maxColspan - 1"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="tia:GerelateerdPersoon/tia:IMKAD_Persoon" mode="do-party-natural-person-common"/>
				<xsl:text> </xsl:text>
				<xsl:apply-templates select="." mode="do-marital-status-partners"/>
				<xsl:text>,</xsl:text>
				<br/>
				<xsl:text> tezamen </xsl:text>
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
				<xsl:value-of select="$personTerminator"/>
			</td>
		</tr>
	</xsl:template>
	
	<!--
	*********************************************************
	Mode: do-person-pair-partner-variant-two
	*********************************************************
	Public: no

	Identity transform: no

	Description: Two natural persons (partners) with joint marital status. 

	Input: tia:IMKAD_Persoon

	Params: maxColspan - maximal colspan in table
			start - order number of person in nested party
			nestedParty - indicator if current person's party is nested one
			anchorName - name of the anchor that will be positioned in first <td> element

	Output: XHTML

	Calls:
	(mode) do-party-natural-person-person-pair-person-one-common
	(mode) do-party-natural-person-person-pair-person-two-common
	(mode) do-party-natural-person-common
	(mode) do-party-natural-person-addresses
	(mode) do-address
	(mode) do-marital-status-partners

	Called by:
	(mode) do-party-natural-person-person-pair
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon" mode="do-person-pair-partner-variant-two">
		<xsl:param name="maxColspan" select="number('0')"/>
		<xsl:param name="start" select="number('0')"/>
		<xsl:param name="nestedParty" select="'false'"/>
		<xsl:param name="anchorName" select="''"/>
		<xsl:param name="personTerminator" />
		
		<tr>
			<xsl:apply-templates select="." mode="do-party-natural-person-person-pair-person-one-common">
				<xsl:with-param name="start" select="$start"/>
				<xsl:with-param name="nestedParty" select="$nestedParty"/>
				<xsl:with-param name="anchorName" select="$anchorName"/>
			</xsl:apply-templates>
			<td>
				<xsl:if test="($maxColspan > 2) and ((count(preceding-sibling::tia:IMKAD_Persoon) + count(following-sibling::tia:IMKAD_Persoon)) = 0)">
					<xsl:attribute name="colspan">					
						<xsl:value-of select="$maxColspan - 1"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="." mode="do-party-natural-person-common"/>
				<xsl:apply-templates select="." mode="do-party-natural-person-addresses"/>
				<xsl:text>;</xsl:text>
			</td>
		</tr>
		<tr>
			<xsl:apply-templates select="." mode="do-party-natural-person-person-pair-person-two-common">
				<xsl:with-param name="start" select="$start"/>
				<xsl:with-param name="nestedParty" select="$nestedParty"/>
			</xsl:apply-templates>
			<td>
				<xsl:if test="($maxColspan > 2) and ((count(preceding-sibling::tia:IMKAD_Persoon) + count(following-sibling::tia:IMKAD_Persoon)) = 0)">
					<xsl:attribute name="colspan">					
						<xsl:value-of select="$maxColspan - 1"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="tia:GerelateerdPersoon/tia:IMKAD_Persoon" mode="do-party-natural-person-common"/>
				<xsl:text> wonende te </xsl:text>
				<xsl:choose>
					<xsl:when test="translate(tia:GerelateerdPersoon/tia:IndGezamenlijkeWoonlocatie, $upper, $lower) = 'true'">
						<xsl:apply-templates select="tia:IMKAD_WoonlocatiePersoon" mode="do-address"/>
					</xsl:when>
					<xsl:when test="translate(tia:GerelateerdPersoon/tia:IndGezamenlijkeWoonlocatie, $upper, $lower) = 'false'">
						<xsl:apply-templates select="tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:IMKAD_WoonlocatiePersoon" mode="do-address"/>
					</xsl:when>
				</xsl:choose>
				<xsl:if test="(tia:toekomstigAdres and translate(tia:GerelateerdPersoon/tia:IndGezamenlijkeToekomstigeWoonlocatie, $upper, $lower) = 'true')
						 	or (tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:toekomstigAdres and (translate(tia:GerelateerdPersoon/tia:IndGezamenlijkeToekomstigeWoonlocatie, $upper, $lower) = 'false' or not(tia:GerelateerdPersoon/tia:IndGezamenlijkeToekomstigeWoonlocatie)))">
					<xsl:text> (toekomstig adres: </xsl:text>
					<xsl:choose>
						<xsl:when test="translate(tia:GerelateerdPersoon/tia:IndGezamenlijkeToekomstigeWoonlocatie, $upper, $lower) = 'true'">
							<xsl:apply-templates select="tia:toekomstigAdres" mode="do-address"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:apply-templates select="tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:toekomstigAdres" mode="do-address"/>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:text>)</xsl:text>
				</xsl:if>
				<xsl:text> </xsl:text>
				<xsl:apply-templates select="." mode="do-marital-status-partners"/>
				<xsl:value-of select="$personTerminator"/>
			</td>
		</tr>
	</xsl:template>
	
	<!--
	*********************************************************
	Mode: do-person-pair-representative-variant-seven
	*********************************************************
	Public: no

	Identity transform: no

	Description: Two natural persons (not partners) where one acts on behalf of oneself and the other, with joint residential address. 

	Input: tia:IMKAD_Persoon

	Params: maxColspan - maximal colspan in table
			start - order number of person in nested party
			nestedParty - indicator if current person's party is nested one
			anchorName - name of the anchor that will be positioned in first <td> element

	Output: XHTML

	Calls:
	(mode) do-party-natural-person-person-pair-person-one-common
	(mode) do-party-natural-person-person-pair-person-two-common
	(mode) do-party-natural-person-common
	(mode) do-marital-status
	(mode) do-party-natural-person-addresses

	Called by:
	(mode) do-party-natural-person-person-pair
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon" mode="do-person-pair-representative-variant-seven">
		<xsl:param name="maxColspan" select="number('0')"/>
		<xsl:param name="start" select="number('0')"/>
		<xsl:param name="nestedParty" select="'false'"/>
		<xsl:param name="anchorName" select="''"/>
		<xsl:param name="personTerminator" />
		
		<tr>
			<xsl:apply-templates select="." mode="do-party-natural-person-person-pair-person-one-common">
				<xsl:with-param name="start" select="$start"/>
				<xsl:with-param name="nestedParty" select="$nestedParty"/>
				<xsl:with-param name="anchorName" select="$anchorName"/>
			</xsl:apply-templates>
			<td>
				<xsl:if test="($maxColspan > 2) and ((count(preceding-sibling::tia:IMKAD_Persoon) + count(following-sibling::tia:IMKAD_Persoon)) = 0)">
					<xsl:attribute name="colspan">					
						<xsl:value-of select="$maxColspan - 1"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="." mode="do-party-natural-person-common"/>
				<xsl:apply-templates select="." mode="do-marital-status"/>
				<xsl:text> te dezen handelend:</xsl:text>
				<ul class="arrow">
					<li class="arrow">
						<xsl:text>voor zich: en</xsl:text>
					</li>
					<li class="arrow">
						<xsl:text>als </xsl:text>
						<xsl:value-of select="tia:GerelateerdPersoon/tia:bevoegdheid"/>
						<xsl:text> gevolmachtigde van:</xsl:text>
					</li>					
				</ul>
			</td>
		</tr>
		<tr>
			<xsl:apply-templates select="." mode="do-party-natural-person-person-pair-person-two-common">
				<xsl:with-param name="start" select="$start"/>
				<xsl:with-param name="nestedParty" select="$nestedParty"/>
			</xsl:apply-templates>
			<td>
				<xsl:if test="($maxColspan > 2) and ((count(preceding-sibling::tia:IMKAD_Persoon) + count(following-sibling::tia:IMKAD_Persoon)) = 0)">
					<xsl:attribute name="colspan">					
						<xsl:value-of select="$maxColspan - 1"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="tia:GerelateerdPersoon/tia:IMKAD_Persoon" mode="do-party-natural-person-common"/>
				<xsl:apply-templates select="tia:GerelateerdPersoon/tia:IMKAD_Persoon" mode="do-marital-status"/>
				<xsl:text>,</xsl:text>
				<br/>
				<xsl:text> tezamen </xsl:text>
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
				<xsl:value-of select="$personTerminator"/>
			</td>
		</tr>
	</xsl:template>
	
	<!--
	*********************************************************
	Mode: do-person-pair-representative-variant-five
	*********************************************************
	Public: no

	Identity transform: no

	Description: Two natural persons (not partners) where one acts on behalf of oneself and the other. 

	Input: tia:IMKAD_Persoon

	Params: maxColspan - maximal colspan in table
			start - order number of person in nested party
			nestedParty - indicator if current person's party is nested one
			anchorName - name of the anchor that will be positioned in first <td> element

	Output: XHTML

	Calls:
	(mode) do-party-natural-person-person-pair-person-one-common
	(mode) do-party-natural-person-person-pair-person-two-common
	(mode) do-party-natural-person-common
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
		<xsl:param name="maxColspan" select="number('0')"/>
		<xsl:param name="start" select="number('0')"/>
		<xsl:param name="nestedParty" select="'false'"/>
		<xsl:param name="anchorName" select="''"/>
		<xsl:param name="personTerminator" />
		
		<tr>
			<xsl:apply-templates select="." mode="do-party-natural-person-person-pair-person-one-common">
				<xsl:with-param name="start" select="$start"/>
				<xsl:with-param name="nestedParty" select="$nestedParty"/>
				<xsl:with-param name="anchorName" select="$anchorName"/>
			</xsl:apply-templates>
			<td>
				<xsl:if test="($maxColspan > 2) and ((count(preceding-sibling::tia:IMKAD_Persoon) + count(following-sibling::tia:IMKAD_Persoon)) = 0)">
					<xsl:attribute name="colspan">					
						<xsl:value-of select="$maxColspan - 1"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="." mode="do-party-natural-person-common"/>
				<xsl:apply-templates select="." mode="do-marital-status"/>
				<xsl:text>, </xsl:text>
				<xsl:apply-templates select="." mode="do-party-natural-person-addresses"/>
				<xsl:text> te dezen handelend:</xsl:text>
				<ul class="arrow">
					<li class="arrow">
						<xsl:text>voor zich: en</xsl:text>
					</li>
					<li class="arrow">
						<xsl:text>als </xsl:text>
						<xsl:value-of select="tia:GerelateerdPersoon/tia:bevoegdheid"/>
						<xsl:text> gevolmachtigde van:</xsl:text>
					</li>					
				</ul>
			</td>
		</tr>
		<tr>
			<xsl:apply-templates select="." mode="do-party-natural-person-person-pair-person-two-common">
				<xsl:with-param name="start" select="$start"/>
				<xsl:with-param name="nestedParty" select="$nestedParty"/>
			</xsl:apply-templates>
			<td>
				<xsl:if test="($maxColspan > 2) and ((count(preceding-sibling::tia:IMKAD_Persoon) + count(following-sibling::tia:IMKAD_Persoon)) = 0)">
					<xsl:attribute name="colspan">					
						<xsl:value-of select="$maxColspan - 1"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="tia:GerelateerdPersoon/tia:IMKAD_Persoon" mode="do-party-natural-person-common"/>
				<xsl:apply-templates select="tia:GerelateerdPersoon/tia:IMKAD_Persoon" mode="do-marital-status"/>
				<xsl:text>, wonende te </xsl:text>
				<xsl:choose>
					<xsl:when test="translate(tia:GerelateerdPersoon/tia:IndGezamenlijkeWoonlocatie, $upper, $lower) = 'true'">
						<xsl:apply-templates select="tia:IMKAD_WoonlocatiePersoon" mode="do-address"/>
					</xsl:when>
					<xsl:when test="translate(tia:GerelateerdPersoon/tia:IndGezamenlijkeWoonlocatie, $upper, $lower) = 'false'">
						<xsl:apply-templates select="tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:IMKAD_WoonlocatiePersoon" mode="do-address"/>
					</xsl:when>
				</xsl:choose>
				<xsl:if test="(tia:toekomstigAdres and translate(tia:GerelateerdPersoon/tia:IndGezamenlijkeToekomstigeWoonlocatie, $upper, $lower) = 'true') 
							or (tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:toekomstigAdres and (translate(tia:GerelateerdPersoon/tia:IndGezamenlijkeToekomstigeWoonlocatie, $upper, $lower) = 'false' or not(tia:GerelateerdPersoon/tia:IndGezamenlijkeToekomstigeWoonlocatie)))">
					<xsl:text> (toekomstig adres: </xsl:text>
					<xsl:choose>
						<xsl:when test="translate(tia:GerelateerdPersoon/tia:IndGezamenlijkeToekomstigeWoonlocatie, $upper, $lower) = 'true'">
							<xsl:apply-templates select="tia:toekomstigAdres" mode="do-address"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:apply-templates select="tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:toekomstigAdres" mode="do-address"/>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:text>)</xsl:text>
				</xsl:if>
				<xsl:value-of select="$personTerminator"/>
			</td>
		</tr>
	</xsl:template>
	
	<!--
	**********************************************************
	Mode: do-person-pair-partner-representative-variant-eight
	**********************************************************
	Public: no

	Identity transform: no

	Description: Two natural persons (partners) where one acts on behalf of oneself and the other, with joint marital status and joint residential address. 

	Input: tia:IMKAD_Persoon

	Params: maxColspan - maximal colspan in table
			start - order number of person in nested party
			nestedParty - indicator if current person's party is nested one
			anchorName - name of the anchor that will be positioned in first <td> element

	Output: XHTML

	Calls:
	(mode) do-party-natural-person-person-pair-person-one-common
	(mode) do-party-natural-person-person-pair-person-two-common
	(mode) do-party-natural-person-common
	(mode) do-marital-status-partners
	(mode) do-party-natural-person-addresses

	Called by:
	(mode) do-party-natural-person-person-pair
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon" mode="do-person-pair-partner-representative-variant-eight">
		<xsl:param name="maxColspan" select="number('0')"/>
		<xsl:param name="start" select="number('0')"/>
		<xsl:param name="nestedParty" select="'false'"/>
		<xsl:param name="anchorName" select="''"/>
		<xsl:param name="personTerminator" />
		
		<tr>
			<xsl:apply-templates select="." mode="do-party-natural-person-person-pair-person-one-common">
				<xsl:with-param name="start" select="$start"/>
				<xsl:with-param name="nestedParty" select="$nestedParty"/>
				<xsl:with-param name="anchorName" select="$anchorName"/>
			</xsl:apply-templates>
			<td>
				<xsl:if test="($maxColspan > 2) and ((count(preceding-sibling::tia:IMKAD_Persoon) + count(following-sibling::tia:IMKAD_Persoon)) = 0)">
					<xsl:attribute name="colspan">					
						<xsl:value-of select="$maxColspan - 1"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="." mode="do-party-natural-person-common"/>
				<xsl:text> te dezen handelend:</xsl:text>
				<ul class="arrow">
					<li class="arrow">
						<xsl:text>voor zich: en</xsl:text>
					</li>
					<li class="arrow">
						<xsl:text>als </xsl:text>
						<xsl:value-of select="tia:GerelateerdPersoon/tia:bevoegdheid"/>
						<xsl:text> gevolmachtigde van:</xsl:text>
					</li>					
				</ul>
			</td>
		</tr>
		<tr>
			<xsl:apply-templates select="." mode="do-party-natural-person-person-pair-person-two-common">
				<xsl:with-param name="start" select="$start"/>
				<xsl:with-param name="nestedParty" select="$nestedParty"/>
			</xsl:apply-templates>
			<td>
				<xsl:if test="($maxColspan > 2) and ((count(preceding-sibling::tia:IMKAD_Persoon) + count(following-sibling::tia:IMKAD_Persoon)) = 0)">
					<xsl:attribute name="colspan">					
						<xsl:value-of select="$maxColspan - 1"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="tia:GerelateerdPersoon/tia:IMKAD_Persoon" mode="do-party-natural-person-common"/>
				<xsl:text> </xsl:text>
				<xsl:apply-templates select="." mode="do-marital-status-partners"/>
				<xsl:text>,</xsl:text>
				<br/>
				<xsl:text> tezamen </xsl:text>
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
				<xsl:value-of select="$personTerminator"/>
			</td>
		</tr>
	</xsl:template>
	
	<!--
	*********************************************************
	Mode: do-person-pair-partner-representative-variant-six
	*********************************************************
	Public: no

	Identity transform: no

	Description: Two natural persons (partners) where one acts on behalf of oneself and the other, with joint marital status. 

	Input: tia:IMKAD_Persoon

	Params: maxColspan - maximal colspan in table
			start - order number of person in nested party
			nestedParty - indicator if current person's party is nested one
			anchorName - name of the anchor that will be positioned in first <td> element

	Output: XHTML

	Calls:
	(mode) do-party-natural-person-person-pair-person-one-common
	(mode) do-party-natural-person-person-pair-person-two-common
	(mode) do-party-natural-person-common
	(mode) do-party-natural-person-addresses
	(mode) do-address
	(mode) do-marital-status-partners

	Called by:
	(mode) do-party-natural-person-person-pair
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon" mode="do-person-pair-partner-representative-variant-six">
		<xsl:param name="maxColspan" select="number('0')"/>
		<xsl:param name="start" select="number('0')"/>
		<xsl:param name="nestedParty" select="'false'"/>
		<xsl:param name="anchorName" select="''"/>
		<xsl:param name="personTerminator" />
		
		<tr>
			<xsl:apply-templates select="." mode="do-party-natural-person-person-pair-person-one-common">
				<xsl:with-param name="start" select="$start"/>
				<xsl:with-param name="nestedParty" select="$nestedParty"/>
				<xsl:with-param name="anchorName" select="$anchorName"/>
			</xsl:apply-templates>
			<td>
				<xsl:if test="($maxColspan > 2) and ((count(preceding-sibling::tia:IMKAD_Persoon) + count(following-sibling::tia:IMKAD_Persoon)) = 0)">
					<xsl:attribute name="colspan">					
						<xsl:value-of select="$maxColspan - 1"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="." mode="do-party-natural-person-common"/>
				<xsl:text> </xsl:text>
				<xsl:apply-templates select="." mode="do-party-natural-person-addresses"/>
				<xsl:text> te dezen handelend:</xsl:text>
				<ul class="arrow">
					<li class="arrow">
						<xsl:text>voor zich: en</xsl:text>
					</li>
					<li class="arrow">
						<xsl:text>als </xsl:text>
						<xsl:value-of select="tia:GerelateerdPersoon/tia:bevoegdheid"/>
						<xsl:text> gevolmachtigde van:</xsl:text>
					</li>					
				</ul>
			</td>
		</tr>
		<tr>
			<xsl:apply-templates select="." mode="do-party-natural-person-person-pair-person-two-common">
				<xsl:with-param name="start" select="$start"/>
				<xsl:with-param name="nestedParty" select="$nestedParty"/>
			</xsl:apply-templates>
			<td>
				<xsl:if test="($maxColspan > 2) and ((count(preceding-sibling::tia:IMKAD_Persoon) + count(following-sibling::tia:IMKAD_Persoon)) = 0)">
					<xsl:attribute name="colspan">					
						<xsl:value-of select="$maxColspan - 1"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="tia:GerelateerdPersoon/tia:IMKAD_Persoon" mode="do-party-natural-person-common"/>
				<xsl:text> wonende te </xsl:text>
				<xsl:choose>
					<xsl:when test="translate(tia:GerelateerdPersoon/tia:IndGezamenlijkeWoonlocatie, $upper, $lower) = 'true'">
						<xsl:apply-templates select="tia:IMKAD_WoonlocatiePersoon" mode="do-address"/>
					</xsl:when>
					<xsl:when test="translate(tia:GerelateerdPersoon/tia:IndGezamenlijkeWoonlocatie, $upper, $lower) = 'false'">
						<xsl:apply-templates select="tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:IMKAD_WoonlocatiePersoon" mode="do-address"/>
					</xsl:when>
				</xsl:choose>
				<xsl:if test="(tia:toekomstigAdres and translate(tia:GerelateerdPersoon/tia:IndGezamenlijkeToekomstigeWoonlocatie, $upper, $lower) = 'true') 
							or (tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:toekomstigAdres and (translate(tia:GerelateerdPersoon/tia:IndGezamenlijkeToekomstigeWoonlocatie, $upper, $lower) = 'false' or not(tia:GerelateerdPersoon/tia:IndGezamenlijkeToekomstigeWoonlocatie)))">
					<xsl:text> (toekomstig adres: </xsl:text>
					<xsl:choose>
						<xsl:when test="translate(tia:GerelateerdPersoon/tia:IndGezamenlijkeToekomstigeWoonlocatie, $upper, $lower) = 'true'">
							<xsl:apply-templates select="tia:toekomstigAdres" mode="do-address"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:apply-templates select="tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:toekomstigAdres" mode="do-address"/>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:text>)</xsl:text>
				</xsl:if>
				<xsl:text> </xsl:text>
				<xsl:apply-templates select="." mode="do-marital-status-partners"/>
				<xsl:value-of select="$personTerminator"/>
			</td>
		</tr>
	</xsl:template>
	
	<!--
	*********************************************************
	Mode: do-person-pair-housemate-variant-three
	*********************************************************
	Public: no

	Identity transform: no

	Description: Two natural persons (not partners) with joint residential address. 

	Input: tia:IMKAD_Persoon

	Params: maxColspan - maximal colspan in table
			start - order number of person in nested party
			nestedParty - indicator if current person's party is nested one
			anchorName - name of the anchor that will be positioned in first <td> element

	Output: XHTML

	Calls:
	(mode) do-party-natural-person-person-pair-person-one-common
	(mode) do-party-natural-person-person-pair-person-two-common
	(mode) do-party-natural-person-common
	(mode) do-marital-status
	(mode) do-party-natural-person-addresses

	Called by:
	(mode) do-party-natural-person-person-pair
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon" mode="do-person-pair-housemate-variant-three">
		<xsl:param name="maxColspan" select="number('0')"/>
		<xsl:param name="start" select="number('0')"/>
		<xsl:param name="nestedParty" select="'false'"/>
		<xsl:param name="anchorName" select="''"/>
		<xsl:param name="personTerminator" />
		
		<tr>
			<xsl:apply-templates select="." mode="do-party-natural-person-person-pair-person-one-common">
				<xsl:with-param name="start" select="$start"/>
				<xsl:with-param name="nestedParty" select="$nestedParty"/>
				<xsl:with-param name="anchorName" select="$anchorName"/>
			</xsl:apply-templates>
			<td>
				<xsl:if test="($maxColspan > 2) and ((count(preceding-sibling::tia:IMKAD_Persoon) + count(following-sibling::tia:IMKAD_Persoon)) = 0)">
					<xsl:attribute name="colspan">					
						<xsl:value-of select="$maxColspan - 1"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="." mode="do-party-natural-person-common"/>
				<xsl:apply-templates select="." mode="do-marital-status"/>
				<xsl:text>;</xsl:text>
			</td>
		</tr>
		<tr>
			<xsl:apply-templates select="." mode="do-party-natural-person-person-pair-person-two-common">
				<xsl:with-param name="start" select="$start"/>
				<xsl:with-param name="nestedParty" select="$nestedParty"/>
			</xsl:apply-templates>
			<td>
				<xsl:if test="($maxColspan > 2) and ((count(preceding-sibling::tia:IMKAD_Persoon) + count(following-sibling::tia:IMKAD_Persoon)) = 0)">
					<xsl:attribute name="colspan">					
						<xsl:value-of select="$maxColspan - 1"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="tia:GerelateerdPersoon/tia:IMKAD_Persoon" mode="do-party-natural-person-common"/>
				<xsl:apply-templates select="tia:GerelateerdPersoon/tia:IMKAD_Persoon" mode="do-marital-status"/>
				<xsl:text>,</xsl:text>
				<br/>
				<xsl:text> tezamen </xsl:text>
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
				<xsl:value-of select="$personTerminator"/>
			</td>
		</tr>
	</xsl:template>
	
</xsl:stylesheet>
