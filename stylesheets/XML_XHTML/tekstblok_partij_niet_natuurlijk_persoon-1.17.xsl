<?xml version="1.0" encoding="UTF-8"?>
<!--
*********************************************************
Stylesheet: tekstblok_partij_niet_natuurlijk_persoon.xsl
Version: 1.17
*********************************************************
Description:
Party legal person text block.

Public:
(mode) do-party-legal-person

Private:
(mode) do-manager
(mode) do-correspondant-address
-->
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
	xmlns:tia="http://www.kadaster.nl/schemas/KIK/TIA_Algemeen"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	exclude-result-prefixes="tia xsl"
	version="1.0">

	<!--
	*********************************************************
	Mode: do-party-legal-person
	*********************************************************
	Public: yes

	Identity transform: no

	Description: Party legal person text block.

	Input: tia:IMKAD_Persoon

	Params: maxColspan - maximal colspan in table
			start - order number of person in nested party
			nestedParty - indicator if current person's party is nested one
			anchorName - name of the anchor that will be positioned in first <td> element
			personTerminator - character that is printed at the end of each person's block
			includePartyLetter - indicates if party letter is included in the table structure
			partyNumberingStyle - numbering style of parties
			personNumberingStyle - numbering style of persons
			eachPersonInSingleParty - indicates if each person is nested within separate sub party
			haveAdditionalText - indicator if additional text should be printed at the end of this text block

	Output: text

	Calls:
	(mode) do-legal-person
	(mode) do-correspondant-address
	(mode) do-manager
	(mode) do-vof-cv-ms

	Called by:
	(mode) do-party-person
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon" mode="do-party-legal-person">
		<xsl:param name="maxColspan" select="number('0')"/>
		<xsl:param name="start" select="number('0')"/>
		<xsl:param name="nestedParty" select="'false'"/>
		<xsl:param name="anchorName" select="''"/>
		<xsl:param name="personTerminator" select="';'" />
		<xsl:param name="includePartyLetter" select="'false'"/>
		<xsl:param name="partyNumberingStyle" select="'1'"/>
		<xsl:param name="personNumberingStyle" select="'a'"/>
		<xsl:param name="eachPersonInSingleParty" select="'false'"/>
		<xsl:param name="haveAdditionalText" select="'false'"/>
		
		<xsl:variable name="additionalText">
			<xsl:if test="$haveAdditionalText = 'true' and count(tia:VoormaligeRechtspersoon/tia:statutaireNaam) > 0">
				<xsl:for-each select="tia:VoormaligeRechtspersoon[tia:statutaireNaam]">
					<xsl:if test="translate(tia:rechtsvormSub, $upper, $lower) != 'de staat'">
						<xsl:choose>
							<xsl:when test="contains(translate(tia:rechtsvormSub, $upper, $lower), 'kerkgenootschap')">
								<xsl:text>het </xsl:text>
							</xsl:when>
							<xsl:otherwise>
								<xsl:text>de </xsl:text>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:if>
					<xsl:value-of select="tia:statutaireNaam"/>
					<xsl:choose>
						<xsl:when test="position() = last() - 1">
							<xsl:text> en </xsl:text>
						</xsl:when>
						<xsl:when test="position() != last()">
							<xsl:text>, </xsl:text>
						</xsl:when>
					</xsl:choose>
				</xsl:for-each>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="numberOfPersons">
			<xsl:choose>
				<xsl:when test="$eachPersonInSingleParty = 'true'">
					<xsl:value-of select="count(../preceding-sibling::tia:Partij/tia:IMKAD_Persoon) + count(../following-sibling::tia:Partij/tia:IMKAD_Persoon)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="count(preceding-sibling::tia:IMKAD_Persoon) + count(following-sibling::tia:IMKAD_Persoon)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="numberOfPersonPairs">
			<xsl:choose>
				<xsl:when test="$eachPersonInSingleParty = 'true'">
					<xsl:value-of select="count(../preceding-sibling::tia:Partij/tia:IMKAD_Persoon[tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene]/tia:GerelateerdPersoon[tia:rol]) 
						+ count(../following-sibling::tia:Partij/tia:IMKAD_Persoon[tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene]/tia:GerelateerdPersoon[tia:rol])"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="count(preceding-sibling::tia:IMKAD_Persoon[tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene]/tia:GerelateerdPersoon[tia:rol]) 
						+ count(following-sibling::tia:IMKAD_Persoon[tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene]/tia:GerelateerdPersoon[tia:rol])"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="competence" select="tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder']/tia:bevoegdheid"/>
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

		<tr>				
			<xsl:if test="$includePartyLetter = 'true'">
				<td class="number" valign="top">
					<xsl:text>&#xFEFF;</xsl:text>
				</td>
			</xsl:if>
			<xsl:choose>
				<xsl:when test="$eachPersonInSingleParty = 'true'">
					<xsl:if test="$numberOfPersons > 0">
						<td class="number" valign="top">
							<xsl:number value="count(../preceding-sibling::tia:Partij/tia:IMKAD_Persoon) + 1" format="{$personNumberingStyle}"/>
						</td>
					</xsl:if>
				</xsl:when>
				<xsl:when test="../tia:Gevolmachtigde">
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<xsl:if test="translate($nestedParty, $upper, $lower) = 'true' and count(preceding-sibling::tia:IMKAD_Persoon) = 0">
						<td class="number" valign="top">
							<xsl:choose>
								<xsl:when test="$start = '0'">
									<xsl:number value="1" format="{$personNumberingStyle}"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:number value="$start" format="{$personNumberingStyle}"/>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:text>.</xsl:text>
						</td>
					</xsl:if>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="count(preceding-sibling::tia:IMKAD_Persoon) = 0">
							<xsl:if test="translate($nestedParty, $upper, $lower) = 'true'">
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
												<xsl:number value="count(preceding-sibling::tia:IMKAD_Persoon) + 1" format="{$personNumberingStyle}"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:number value="count(preceding-sibling::tia:IMKAD_Persoon) + $start" format="{$personNumberingStyle}"/>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:text>.</xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:number value="count(../preceding-sibling::tia:Partij) + 1" format="{$partyNumberingStyle}"/>
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
			<xsl:if test="$eachPersonInSingleParty = 'false' and $numberOfPersons > 0 and not(translate($nestedParty, $upper, $lower) = 'true' and count(preceding-sibling::tia:IMKAD_Persoon) = 0)">	
				<td class="number" valign="top">
					<xsl:choose>
						<xsl:when test="translate($nestedParty, $upper, $lower) = 'true'">
							<xsl:choose>
								<xsl:when test="$start = '0'">
									<xsl:number value="count(preceding-sibling::tia:IMKAD_Persoon) + 1" format="{$personNumberingStyle}"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:number value="count(preceding-sibling::tia:IMKAD_Persoon) + $start" format="{$personNumberingStyle}"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:otherwise>
							<xsl:number value="count(preceding-sibling::tia:IMKAD_Persoon) + 1" format="{$personNumberingStyle}"/>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:text>.</xsl:text>	
				</td>
			</xsl:if>
			<xsl:if test="$haveWarrantors = 'true'">
				<td class="number" valign="top">
					<xsl:choose>
						<xsl:when test="$numberOfPersons > 0">
							<xsl:text>1.</xsl:text>							
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>a.</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</td>
			</xsl:if>
			<td>
						<xsl:choose>
					<xsl:when test="$maxColspan > 2 and $numberOfPersons = 0">
						<xsl:attribute name="colspan">
							<xsl:choose>
								<xsl:when test="($numberOfPersons = 0 and translate($nestedParty, $upper, $lower) = 'true') or ($haveWarrantors = 'true' and $numberOfPersons = 0)">
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
					<xsl:when test="$maxColspan = 2 and $numberOfPersons = 0 and translate($nestedParty, $upper, $lower) = 'false' and $haveWarrantors = 'false'">
						<xsl:attribute name="colspan">
							<xsl:value-of select="$maxColspan"/>
						</xsl:attribute>
							</xsl:when>
					<xsl:when test="$maxColspan > 2 and $numberOfPersons > 0 and $haveWarrantors = 'false'">
						<xsl:attribute name="colspan">
							<xsl:value-of select="$maxColspan - 1"/>
						</xsl:attribute>
					</xsl:when>
					<xsl:when test="$maxColspan > 2 and $numberOfPersons > 0  
							and (count(preceding-sibling::tia:IMKAD_Persoon[tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) != 'bestuurder' and translate(tia:rol, $upper, $lower) != 'volmachtgever']]) > 0 or count(following-sibling::tia:IMKAD_Persoon[tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) != 'bestuurder' and translate(tia:rol, $upper, $lower) != 'volmachtgever']]) > 0)
							and $haveWarrantors = 'false'">
						<xsl:attribute name="colspan">
							<xsl:value-of select="$maxColspan - 1"/>
						</xsl:attribute>
					</xsl:when>
						</xsl:choose>
				<!-- Manager data -->
				<xsl:if test="tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder']">
					<xsl:apply-templates select="tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder']/tia:IMKAD_Persoon" mode="do-manager"/>
					<xsl:text>, te dezen</xsl:text>
				</xsl:if>
				<xsl:choose>
					<xsl:when test="translate(tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder']/tia:tia_IndPartij, $upper, $lower) = 'true'">
						<xsl:text>:</xsl:text>
						<ul class="arrow">
							<li class="arrow">
								<xsl:text>handelend in priv&#x00E9;; en</xsl:text>
							</li>
							<li class="arrow">
								<xsl:text>rechtsgeldig vertegenwoordigend </xsl:text>
								<xsl:apply-templates select="." mode="do-legal-person"/>
								<xsl:choose>
									<xsl:when test="$competence and $haveWarrantors = 'true'">
										<xsl:text>; en</xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:if test="$haveWarrantors = 'false'">
											<xsl:if test="tia:IMKAD_PostlocatiePersoon">
												<xsl:text>, (correspondentieadres voor alle aangelegenheden betreffende de hierna te vermelden rechtshandelingen: </xsl:text>
												<xsl:apply-templates select="tia:IMKAD_PostlocatiePersoon" mode="do-correspondant-address" />
												<xsl:text>)</xsl:text>
											</xsl:if>
											<xsl:if test="$haveAdditionalText = 'true' and $additionalText != ''">
												<xsl:text> ten tijde van de inschrijving genaamd:</xsl:text>
												<br/>
												<xsl:value-of select="$additionalText"/>
											</xsl:if>
											<xsl:value-of select="$personTerminator"/>					
										</xsl:if>
									</xsl:otherwise>
								</xsl:choose>
							</li>
							<xsl:if test="$competence and $haveWarrantors = 'true'">
								<li class="arrow">
									<xsl:text>als </xsl:text>
									<xsl:value-of select="$competence"/>
									<xsl:text> gevolmachtigde van:</xsl:text>
								</li>
							</xsl:if>
						</ul>
					</xsl:when>
					<xsl:otherwise>
						<xsl:if test="tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder']">
							<xsl:text> rechtsgeldig vertegenwoordigend </xsl:text>
						</xsl:if>
						<xsl:apply-templates select="." mode="do-legal-person"/>
						<xsl:choose>
							<xsl:when test="$competence and $haveWarrantors = 'true'">
								<xsl:text>; en</xsl:text>
								<ul class="arrow">
									<li class="arrow">
										<xsl:text>als </xsl:text>
										<xsl:value-of select="$competence"/>
										<xsl:text> gevolmachtigde van:</xsl:text>
									</li>
								</ul>
							</xsl:when>
							<xsl:otherwise>
								<xsl:if test="$haveWarrantors = 'false'">
									<xsl:if test="tia:IMKAD_PostlocatiePersoon">
										<xsl:text>, (correspondentieadres voor alle aangelegenheden betreffende de hierna te vermelden rechtshandelingen: </xsl:text>
										<xsl:apply-templates select="tia:IMKAD_PostlocatiePersoon" mode="do-correspondant-address" />
										<xsl:text>)</xsl:text>
									</xsl:if>
									<xsl:if test="$haveAdditionalText = 'true' and $additionalText != ''">
										<xsl:text> ten tijde van de inschrijving genaamd:</xsl:text>
										<br/>
										<xsl:value-of select="$additionalText"/>
									</xsl:if>
									<xsl:value-of select="$personTerminator"/>					
								</xsl:if>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</td>
		</tr>
		<xsl:if test="$haveWarrantors = 'true'">
			<xsl:for-each select="tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'volmachtgever' and translate(tia:tia_IndPartij, $upper, $lower) = 'true']">
				<tr>
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<xsl:if test="$numberOfPersons > 0">
						<td class="number" valign="top">
							<xsl:text>&#xFEFF;</xsl:text>
						</td>
					</xsl:if>
					<td class="number" valign="top">
						<xsl:choose>
							<xsl:when test="$numberOfPersons > 0">
								<xsl:choose>
									<xsl:when test="$start != '0'">
										<xsl:number value="position() + $start" format="1"/>
									</xsl:when>
									<xsl:otherwise>
								<xsl:number value="position() + 1" format="1"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:when>
							<xsl:otherwise>
								<xsl:choose>
									<xsl:when test="$start != '0'">
										<xsl:number value="position() + $start" format="a"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:number value="position() + 1" format="a"/>
							</xsl:otherwise>
						</xsl:choose>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:text>.</xsl:text>
					</td>
					<td>
						<xsl:if test="$numberOfPersons = 0 and $maxColspan > 2">
							<xsl:attribute name="colspan">
								<xsl:value-of select="$maxColspan - 1"/>
							</xsl:attribute>
						</xsl:if>
						<xsl:apply-templates select="tia:IMKAD_Persoon" mode="do-legal-person"/>
						<xsl:choose>	
							<xsl:when test="position() != last()">
								<xsl:text>;</xsl:text>
							</xsl:when>
							<xsl:when test="position() = last() and ../../tia:vofCvMs">
								<xsl:text>;</xsl:text>
							</xsl:when>
							<xsl:when test="position() = last() and not(../../tia:vofCvMs)">
								<xsl:if test="../tia:IMKAD_PostlocatiePersoon">
									<xsl:text>, (correspondentieadres voor alle aangelegenheden betreffende de hierna te vermelden rechtshandelingen: </xsl:text>
									<xsl:apply-templates select="../tia:IMKAD_PostlocatiePersoon" mode="do-correspondant-address" />
									<xsl:text>)</xsl:text>
								</xsl:if>
								<xsl:if test="$haveAdditionalText = 'true' and $additionalText != ''">
									<xsl:text> ten tijde van de inschrijving genaamd:</xsl:text>
									<br/>
									<xsl:value-of select="$additionalText"/>
								</xsl:if>
								<xsl:value-of select="$personTerminator"/>
							</xsl:when>
						</xsl:choose>
					</td>
				</tr>
			</xsl:for-each>
		</xsl:if>
			<xsl:if test="../tia:vofCvMs">
				<tr>
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<td>
						<xsl:if test="$maxColspan != '' and $maxColspan != 0">
							<xsl:attribute name="colspan">
								<xsl:value-of select="$maxColspan"/>
							</xsl:attribute>
						</xsl:if>
						<xsl:if test="../tia:vofCvMs">
							<xsl:apply-templates select="." mode="do-vof-cv-ms"/>
						</xsl:if>
						<xsl:if test="tia:IMKAD_PostlocatiePersoon">
							<xsl:text>, (correspondentieadres voor alle aangelegenheden betreffende de hierna te vermelden rechtshandelingen: </xsl:text>
							<xsl:apply-templates select="tia:IMKAD_PostlocatiePersoon" mode="do-correspondant-address" />
							<xsl:text>)</xsl:text>
						</xsl:if>
						<xsl:if test="$haveAdditionalText = 'true' and $additionalText != ''">
							<xsl:text> ten tijde van de inschrijving genaamd:</xsl:text>
							<br/>
							<xsl:value-of select="$additionalText"/>
						</xsl:if>
						<xsl:value-of select="$personTerminator"/>	
					</td>				
				</tr>
			</xsl:if>
	</xsl:template>

	<!--
	*********************************************************
	Mode: do-manager
	*********************************************************
	Public: no

	Identity transform: no

	Description: Legal person manager

	Input: tia:IMKAD_Persoon

	Params: none

	Output: text

	Calls:
	(mode) do-natural-person
	(mode) do-address
	(mode) do-identity-document
	(mode) do-marital-status

	Called by:
	(mode) do-party-legal-person
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:GerelateerdPersoon/tia:IMKAD_Persoon" mode="do-manager">
		<xsl:apply-templates select="." mode="do-natural-person"/>
		<xsl:if test="tia:IMKAD_WoonlocatiePersoon">
			<xsl:text>, wonende te </xsl:text>
			<xsl:apply-templates select="tia:IMKAD_WoonlocatiePersoon" mode="do-address"/>
		</xsl:if>
		<xsl:if test="tia:tia_Legitimatiebewijs">
			<xsl:text>, </xsl:text>
			<xsl:apply-templates select="tia:tia_Legitimatiebewijs" mode="do-identity-document">
				<xsl:with-param name="gender" select="tia:tia_Gegevens/tia:GBA_Ingezetene/tia:geslacht/tia:geslachtsaanduiding
					| tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:geslacht"/>
			</xsl:apply-templates>
		</xsl:if>
		<xsl:if test="normalize-space(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_burgerlijkestaattekst']/tia:tekst) != ''">
			<xsl:text>, </xsl:text>
			<xsl:apply-templates select="." mode="do-marital-status"/>
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
	none

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

</xsl:stylesheet>
