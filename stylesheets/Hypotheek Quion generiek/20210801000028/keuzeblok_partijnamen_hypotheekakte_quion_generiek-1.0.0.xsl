<?xml version="1.0" encoding="UTF-8"?>
<!--
*********************************************************
Stylesheet: keuzeblok_partijnamen_hypotheekakte_quion_generiek-1.0.0.xsl
Version: 1.0.0
*********************************************************
Description:
KEUZEBLOK PARTIJNAMEN HYPOTHEEKAKTE - Quion generiek

Public:
(mode) do-mortgage-deed-party-name
(mode) do-person-numbering
(mode) do-person-name

Private:
none
-->
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:tia="http://www.kadaster.nl/schemas/KIK/TIA_Algemeen" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exslt="http://exslt.org/common" xmlns:xlink="http://www.w3.org/1999/xlink" exclude-result-prefixes="tia xsl exslt xlink" version="1.0">
	<!--
	*********************************************************
	Mode: do-keuzeblok-partijnamen-hypotheekakte
	*********************************************************
	Public: yes

	Identity transform: no
	Input: tia:Partij

	Calls:
	(mode) do-person-numbering

	Called by:
	(mode) do-comparitie
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:Partij" mode="do-keuzeblok-partijnamen-hypotheekakte">
		<xsl:param name="partyNumber" select="number('1')"/>
		<xsl:variable name="currentPartij" select="."/>
		<xsl:variable name="debtor" select="'geldnemer'"/>
		<xsl:variable name="mortgager" select="'hypotheekgever'"/>
		<xsl:variable name="both" select="'beiden'"/>
		<xsl:variable name="_debtorPersons">
			<tia:groups>
				<xsl:apply-templates select="." mode="do-person-numbering">
					<xsl:with-param name="partyNumber" select="$partyNumber"/>
					<xsl:with-param name="debtorPersonsProcessed" select="'true'"/>
					<xsl:with-param name="mortgagerPersonsProcessed" select="'false'"/>
					<xsl:with-param name="debtor" select="$debtor"/>
					<xsl:with-param name="mortgager" select="$mortgager"/>
				</xsl:apply-templates>
			</tia:groups>
		</xsl:variable>
		<xsl:variable name="debtorPersons" select="exslt:node-set($_debtorPersons)"/>
		<xsl:variable name="_mortgagerPersons">
			<tia:groups>
				<xsl:apply-templates select="." mode="do-person-numbering">
					<xsl:with-param name="partyNumber" select="$partyNumber"/>
					<xsl:with-param name="debtorPersonsProcessed" select="'false'"/>
					<xsl:with-param name="mortgagerPersonsProcessed" select="'true'"/>
					<xsl:with-param name="debtor" select="$debtor"/>
					<xsl:with-param name="mortgager" select="$mortgager"/>
				</xsl:apply-templates>
			</tia:groups>
		</xsl:variable>
		<xsl:variable name="mortgagerPersons" select="exslt:node-set($_mortgagerPersons)"/>
		<!-- Verplichte keuze uit de volgende 2 opties -->
		<xsl:choose>
			<!-- Optie 1: Geldnemer of Hypotheekgever' -->
			<xsl:when test="translate(tia:aanduidingPartij, $upper, $lower) = 'geldnemer en/of hypotheekgever'">
				<xsl:text>hierna ook te noemen:</xsl:text>
				<xsl:if test="(count(tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true'])
						+ count(tia:IMKAD_Persoon/tia:GerelateerdPersoon[translate(tia:IMKAD_Persoon/tia:tia_IndGerechtigde, $upper, $lower) = 'true'])
						+ count(tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon[translate(tia:IMKAD_Persoon/tia:tia_IndGerechtigde, $upper, $lower) = 'true'])) > 1">
					<xsl:text> (tezamen en waar van toepassing ook ieder afzonderlijk)</xsl:text>
				</xsl:if>
				<xsl:text> "geldnemer" dan wel "schuldenaar" en/of "hypotheekgever"</xsl:text>
			</xsl:when>
			<!-- Optie 2: Aanduiding per persoon -->
			<xsl:when test="translate(tia:aanduidingPartij, $upper, $lower) = 'aanduiding per persoon'">
				<!-- gebruikte variabelen -->
				<xsl:variable name="numberOfPersonPairs" select="count(tia:IMKAD_Persoon/tia:GerelateerdPersoon[tia:rol and tia:rol != 'bestuurder'])"/>
				<xsl:variable name="numberOfDebtorPersons" select="count(tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true' and translate(tia:tia_PartijOnderdeel, $upper, $lower) = translate($debtor, $upper, $lower) or translate(tia:tia_PartijOnderdeel, $upper, $lower) = translate($both, $upper, $lower)])
						+ count(tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true' and translate(tia:tia_PartijOnderdeel, $upper, $lower) = translate($debtor, $upper, $lower) or translate(tia:tia_PartijOnderdeel, $upper, $lower) = translate($both, $upper, $lower)])
						+ count(tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true' and translate(tia:tia_PartijOnderdeel, $upper, $lower) = translate($debtor, $upper, $lower) or translate(tia:tia_PartijOnderdeel, $upper, $lower) = translate($both, $upper, $lower)])"/>
				<xsl:variable name="numberOfMortgagerPersons" select="count(tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true' and translate(tia:tia_PartijOnderdeel, $upper, $lower) = translate($mortgager, $upper, $lower) or translate(tia:tia_PartijOnderdeel, $upper, $lower) = translate($both, $upper, $lower)])
						+ count(tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true' and translate(tia:tia_PartijOnderdeel, $upper, $lower) = translate($mortgager, $upper, $lower) or translate(tia:tia_PartijOnderdeel, $upper, $lower) = translate($both, $upper, $lower)])
						+ count(tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true' and translate(tia:tia_PartijOnderdeel, $upper, $lower) = translate($mortgager, $upper, $lower) or translate(tia:tia_PartijOnderdeel, $upper, $lower) = translate($both, $upper, $lower)])"/>
				<xsl:variable name="voornoemdGeldnemer" select="tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_geldnemervoornoemd']"/>
				<xsl:variable name="voornoemdHypotheekgever" select="tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hypotheekgevervoornoemd']"/>
				<xsl:variable name="verwijzingPersoon" select="tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verwijzingpersoon']"/>
				<xsl:variable name="number" select="translate(normalize-space($verwijzingPersoon/tia:tekst), $upper, $lower) = 'nummer'"/>
				<xsl:variable name="name" select="translate(normalize-space($verwijzingPersoon/tia:tekst), $upper, $lower) = 'naam'"/>
				<xsl:variable name="existGevolmachtigde" select="(count(tia:Hoedanigheid[concat('#',@id) = $currentPartij/tia:Gevolmachtigde/tia:vertegenwoordigtRef/@xlink:href]) + count($currentPartij/descendant::tia:IMKAD_Persoon/tia:vertegenwoordigtRef) + count(tia:vertegenwoordigtRef)) > 0"/>
				<xsl:if test="(not($existGevolmachtigde) and $number) or $name">
					<!-- 2.5.2.1.1	Aanduiding persoon met nummer -->
					<xsl:if test="$number">
						<xsl:text>de verschenen </xsl:text>
						<xsl:choose>
							<xsl:when test="$numberOfDebtorPersons > 1">
								<xsl:text>personen </xsl:text>
							</xsl:when>
							<xsl:otherwise>
								<xsl:text>persoon </xsl:text>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:text>sub </xsl:text>
					</xsl:if>
					<xsl:for-each select="$debtorPersons/tia:groups/tia:group">
						<xsl:value-of select="."/>
						<xsl:choose>
							<xsl:when test="position() = last() - 1">
								<xsl:text> en </xsl:text>
							</xsl:when>
							<xsl:when test="position() != last()">
								<xsl:text>, </xsl:text>
							</xsl:when>
						</xsl:choose>
					</xsl:for-each>
					<xsl:if test="$name and translate(normalize-space($voornoemdGeldnemer/tia:tekst), $upper, $lower) = 'voornoemd'">
						<xsl:text> voornoemd,</xsl:text>
					</xsl:if>
					<xsl:text> hierna ook te noemen: </xsl:text>
					<xsl:if test="$numberOfDebtorPersons > 1">
						<xsl:text>(tezamen en waar van toepassing ook ieder afzonderlijk)</xsl:text>
					</xsl:if>
					<xsl:text> "geldnemer" dan wel "schuldenaar" en </xsl:text>
					<xsl:if test="$number">
						<xsl:text>de verschenen </xsl:text>
						<xsl:choose>
							<xsl:when test="$numberOfMortgagerPersons > 1">
								<xsl:text>personen </xsl:text>
							</xsl:when>
							<xsl:otherwise>
								<xsl:text>persoon </xsl:text>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:text>sub </xsl:text>
					</xsl:if>
					<xsl:for-each select="$mortgagerPersons/tia:groups/tia:group">
						<xsl:value-of select="."/>
						<xsl:choose>
							<xsl:when test="position() = last() - 1">
								<xsl:text> en </xsl:text>
							</xsl:when>
							<xsl:when test="position() != last()">
								<xsl:text>, </xsl:text>
							</xsl:when>
						</xsl:choose>
					</xsl:for-each>
					<xsl:if test="$name and translate(normalize-space($voornoemdHypotheekgever/tia:tekst), $upper, $lower) = 'voornoemd'">
						<xsl:text> voornoemd,</xsl:text>
					</xsl:if>
					<xsl:text> hierna ook te noemen: </xsl:text>
					<xsl:if test="$numberOfMortgagerPersons > 1">
						<xsl:text>(tezamen en waar van toepassing ook ieder afzonderlijk)</xsl:text>
					</xsl:if>
					<xsl:text> "hypotheekgever"</xsl:text>
				</xsl:if>
			</xsl:when>
			<!-- Alle andere gevallen -->
			<xsl:otherwise>
				<p>
					<xsl:text>KEUZEBLOK PARTIJNAMEN HYPOTHEEKAKTE</xsl:text>
				</p>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-person-numbering
	*********************************************************
	Public: yes

	Identity transform: no

	Description: Numbering of person within party.

	Input: tia:IMKAD_Persoon

	Params: partyNumber - number of the party
	        debtorPersonsProcessed - indicator if debtor persons are processed
	        mortgagerPersonsProcessed - indicator if mortager persons are processed
	        allPersonsProcessed - indicator if all persons are processed, regardless of the presence of tia:tia_PartijOnderdeel and it's value 

	Output: Tree fragment:
			<tia:groups>
				<tia:group>
					person name
				</tia:group>
				...
			</tia:groups>

	Calls:
	(mode) do-person-name

	Called by:
	(mode) do-keuzeblok-partijnamen-hypotheekakte
	(mode) do-deed
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:Partij" mode="do-person-numbering">
		<xsl:param name="partyNumber"/>
		<xsl:param name="debtorPersonsProcessed" select="'false'"/>
		<xsl:param name="mortgagerPersonsProcessed" select="'false'"/>
		<xsl:param name="allPersonsProcessed" select="'false'"/>
		<xsl:param name="debtor"/>
		<xsl:param name="mortgager"/>
		
		<xsl:variable name="currentParty" select="."/>
		<xsl:variable name="both" select="'beiden'"/>
		<xsl:variable name="verwijzingPersoon" select="tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verwijzingpersoon']"/>
		<xsl:variable name="number" select="translate(normalize-space($verwijzingPersoon/tia:tekst), $upper, $lower) = 'nummer'"/>
		<xsl:variable name="name" select="translate(normalize-space($verwijzingPersoon/tia:tekst), $upper, $lower) = 'naam'"/>
		<xsl:variable name="onlyPersonInParty">
			<xsl:choose>
				<xsl:when test="count($currentParty/tia:IMKAD_Persoon) = 1">
					<xsl:text>true</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>false</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:for-each select="tia:IMKAD_Persoon">
			<xsl:variable name="personIsMortgager">
				<xsl:choose>
					<xsl:when test="translate(tia:tia_PartijOnderdeel, $upper, $lower) = translate($mortgager, $upper, $lower) or translate(tia:tia_PartijOnderdeel, $upper, $lower) = translate($both, $upper, $lower)">
						<xsl:text>true</xsl:text>
					</xsl:when>
					<xsl:when test="$allPersonsProcessed = 'true'">
						<xsl:text>true</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>false</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="personIsDebtor">
				<xsl:choose>
					<xsl:when test="translate(tia:tia_PartijOnderdeel, $upper, $lower) = translate($debtor, $upper, $lower) or translate(tia:tia_PartijOnderdeel, $upper, $lower) = translate($both, $upper, $lower)">
						<xsl:text>true</xsl:text>
					</xsl:when>
					<xsl:when test="$allPersonsProcessed = 'true'">
						<xsl:text>true</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>false</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:text>personIsDebtor: </xsl:text>
			<xsl:value-of select="personIsDebtor"/>
			<xsl:variable name="personIsBothDebtorAndMortgager">
				<xsl:choose>
					<xsl:when test="translate(tia:tia_PartijOnderdeel, $upper, $lower) = translate($both, $upper, $lower)">
						<xsl:text>true</xsl:text>
					</xsl:when>
					<xsl:when test="$allPersonsProcessed = 'true'">
						<xsl:text>true</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>false</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="ordinalNumberOfPersonInParty" select="count(preceding-sibling::tia:IMKAD_Persoon) + 1"/>
			<xsl:variable name="positionWithinParty" select="count($currentParty/tia:IMKAD_Persoon[$ordinalNumberOfPersonInParty]/preceding-sibling::tia:IMKAD_Persoon[not(tia:tia_Gegevens/tia:NHR_Rechtspersoon and (count(tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder']) = 0) and (tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidaanduiding']/tia:tekst) and count(preceding-sibling::tia:IMKAD_Persoon) > 0)])
			+ count($currentParty/tia:IMKAD_Persoon[$ordinalNumberOfPersonInParty]/preceding-sibling::tia:IMKAD_Persoon[count(tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder']) > 1]/tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder' and preceding-sibling::tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder']])												
			+ 1"/>
			<xsl:variable name="existGevolmachtigde" select="count(tia:Hoedanigheid[$currentParty/tia:Gevolmachtigde/tia:vertegenwoordigtRef/@xlink:href = concat('#',@id)]) + 
														count($currentParty/tia:IMKAD_Persoon[not(tia:tia_Gegevens/tia:NHR_Rechtspersoon)]/tia:vertegenwoordigtRef) + 
														count($currentParty/tia:IMKAD_Persoon[not(tia:tia_Gegevens/tia:NHR_Rechtspersoon)]/tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:vertegenwoordigtRef)"/>
			<xsl:choose>
				<!-- printing NAME of persons-->
				<xsl:when test="$name">
					<xsl:choose>
						<!-- PNP -->
						<xsl:when test="tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene">
							<!-- main person -->
							<xsl:if test="translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true' and 
											(($debtorPersonsProcessed = 'true' and $personIsDebtor = 'true') or ($mortgagerPersonsProcessed = 'true' and $personIsMortgager = 'true'))">
								<tia:group>
									<xsl:apply-templates select="tia:tia_Gegevens" mode="do-person-name"/>
								</tia:group>
							</xsl:if>
							<!-- related person(s) -->
							<xsl:for-each select="tia:GerelateerdPersoon">
								<xsl:variable name="currentPerson" select="tia:IMKAD_Persoon"/>
								<xsl:variable name="currentPersonIsDebtor">
									<xsl:choose>
										<xsl:when test="translate(tia:IMKAD_Persoon/tia:tia_PartijOnderdeel, $upper, $lower) = translate($debtor, $upper, $lower) or translate(tia:IMKAD_Persoon/tia:tia_PartijOnderdeel, $upper, $lower) = translate($both, $upper, $lower)">
											<xsl:text>true</xsl:text>
										</xsl:when>
										<xsl:when test="$allPersonsProcessed = 'true'">
											<xsl:text>true</xsl:text>
										</xsl:when>
										<xsl:otherwise>
											<xsl:text>false</xsl:text>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:variable>
								<xsl:variable name="currentPersonIsMortgager">
									<xsl:choose>
										<xsl:when test="translate(tia:IMKAD_Persoon/tia:tia_PartijOnderdeel, $upper, $lower) = translate($mortgager, $upper, $lower) or translate(tia:IMKAD_Persoon/tia:tia_PartijOnderdeel, $upper, $lower) = translate($both, $upper, $lower)">
											<xsl:text>true</xsl:text>
										</xsl:when>
										<xsl:when test="$allPersonsProcessed = 'true'">
											<xsl:text>true</xsl:text>
										</xsl:when>
										<xsl:otherwise>
											<xsl:text>false</xsl:text>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:variable>
								<xsl:if test="translate(tia:IMKAD_Persoon/tia:tia_IndGerechtigde, $upper, $lower) = 'true' and 
												(($debtorPersonsProcessed = 'true' and $currentPersonIsDebtor = 'true') or ($mortgagerPersonsProcessed = 'true' and $currentPersonIsMortgager = 'true'))">
									<xsl:variable name="relatedPersonAuthorizedRepresentative" select="$currentParty/tia:Gevolmachtigde[tia:vertegenwoordigtRef/@xlink:href = concat('#', $currentParty/tia:Hoedanigheid[tia:wordtVertegenwoordigdRef/@xlink:href=concat('#',$currentPerson/@id)]/@id)]"/>
									<xsl:variable name="allreadyProcessed">
										<xsl:choose>
											<xsl:when test="$relatedPersonAuthorizedRepresentative/tia:volmachtgeverRef[@xlink:href = concat('#',current()/preceding-sibling::tia:GerelateerdPersoon/tia:IMKAD_Persoon/@id)]">
												<xsl:text>true</xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text>false</xsl:text>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:variable>
									<xsl:if test="$allreadyProcessed = 'false'">
										<tia:group>
											<xsl:apply-templates select="tia:IMKAD_Persoon/tia:tia_Gegevens" mode="do-person-name"/>
										</tia:group>
									</xsl:if>
								</xsl:if>
							</xsl:for-each>
						</xsl:when>
						<!-- PNNP -->
						<xsl:when test="tia:tia_Gegevens/tia:NHR_Rechtspersoon">
							<!-- bestuurder -->
							<xsl:for-each select="tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder']">
								<xsl:variable name="positionInSecondNestedLevel" select="count(preceding-sibling::tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'bestuurder']) + 1"/>
								<xsl:variable name="positionWithinPerson" select="position() - 1"/>
								<xsl:variable name="mainPersonInManagerIsMortgager">
									<xsl:choose>
										<xsl:when test="translate(tia:IMKAD_Persoon/tia:tia_PartijOnderdeel, $upper, $lower) = translate($mortgager, $upper, $lower) or translate(tia:IMKAD_Persoon/tia:tia_PartijOnderdeel, $upper, $lower) = translate($both, $upper, $lower)">
											<xsl:text>true</xsl:text>
										</xsl:when>
										<xsl:when test="$allPersonsProcessed = 'true'">
											<xsl:text>true</xsl:text>
										</xsl:when>
										<xsl:otherwise>
											<xsl:text>false</xsl:text>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:variable>
								<xsl:variable name="mainPersonInManagerIsDebtor">
									<xsl:choose>
										<xsl:when test="translate(tia:IMKAD_Persoon/tia:tia_PartijOnderdeel, $upper, $lower) = translate($debtor, $upper, $lower) or translate(tia:IMKAD_Persoon/tia:tia_PartijOnderdeel, $upper, $lower) = translate($both, $upper, $lower)">
											<xsl:text>true</xsl:text>
										</xsl:when>
										<xsl:when test="$allPersonsProcessed = 'true'">
											<xsl:text>true</xsl:text>
										</xsl:when>
										<xsl:otherwise>
											<xsl:text>false</xsl:text>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:variable>
								<!-- main person of bestuurder -->
								<xsl:if test="translate(tia:IMKAD_Persoon/tia:tia_IndGerechtigde, $upper, $lower) = 'true' and 
												(($debtorPersonsProcessed = 'true' and $mainPersonInManagerIsDebtor = 'true') or
													($mortgagerPersonsProcessed = 'true' and $mainPersonInManagerIsMortgager = 'true'))">
									<tia:group>
										<xsl:apply-templates select="tia:IMKAD_Persoon/tia:tia_Gegevens" mode="do-person-name"/>
									</tia:group>
								</xsl:if>
								<!-- related bestuurder person(s) -->
								<xsl:for-each select="tia:IMKAD_Persoon/tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'partner' or translate(tia:rol, $upper, $lower) = 'huisgenoot']">
									<xsl:variable name="positionInThirdNestedLevel" select="count(preceding-sibling::tia:GerelateerdPersoon[translate(tia:rol, $upper, $lower) = 'partner' or translate(tia:rol, $upper, $lower) = 'huisgenoot']) + 1"/>
									<xsl:variable name="currentPersonInManagerIsDebtor">
										<xsl:choose>
											<xsl:when test="translate(tia:IMKAD_Persoon/tia:tia_PartijOnderdeel, $upper, $lower) = translate($debtor, $upper, $lower) or translate(tia:IMKAD_Persoon/tia:tia_PartijOnderdeel, $upper, $lower) = translate($both, $upper, $lower)">
												<xsl:text>true</xsl:text>
											</xsl:when>
											<xsl:when test="$allPersonsProcessed = 'true'">
												<xsl:text>true</xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text>false</xsl:text>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:variable>
									<xsl:variable name="currentPersonInManagerIsMortgager">
										<xsl:choose>
											<xsl:when test="translate(tia:IMKAD_Persoon/tia:tia_PartijOnderdeel, $upper, $lower) = translate($mortgager, $upper, $lower) or translate(tia:IMKAD_Persoon/tia:tia_PartijOnderdeel, $upper, $lower) = translate($both, $upper, $lower)">
												<xsl:text>true</xsl:text>
											</xsl:when>
											<xsl:when test="$allPersonsProcessed = 'true'">
												<xsl:text>true</xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text>false</xsl:text>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:variable>
									<xsl:if test="translate(tia:IMKAD_Persoon/tia:tia_IndGerechtigde, $upper, $lower) = 'true' and 
													(($debtorPersonsProcessed = 'true' and $currentPersonInManagerIsDebtor = 'true') or 
														($mortgagerPersonsProcessed = 'true' and $currentPersonInManagerIsMortgager = 'true'))">
										<tia:group>
											<xsl:apply-templates select="tia:IMKAD_Persoon/tia:tia_Gegevens" mode="do-person-name"/>
										</tia:group>
									</xsl:if>
								</xsl:for-each>
							</xsl:for-each>
							<!-- main person -->
							<xsl:if test="translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true' and 
											(($debtorPersonsProcessed = 'true' and $personIsDebtor = 'true') or ($mortgagerPersonsProcessed = 'true' and $personIsMortgager = 'true'))">
								<tia:group>
									<xsl:apply-templates select="tia:tia_Gegevens" mode="do-person-name"/>
								</tia:group>
							</xsl:if>
							<!-- related person(s) -->
							<xsl:for-each select="tia:GerelateerdPersoon[not(translate(tia:rol, $upper, $lower) = 'bestuurder')]">
								<xsl:variable name="currentPerson" select="tia:IMKAD_Persoon"/>
								<xsl:variable name="currentPersonIsDebtor">
									<xsl:choose>
										<xsl:when test="translate(tia:IMKAD_Persoon/tia:tia_PartijOnderdeel, $upper, $lower) = translate($debtor, $upper, $lower) or translate(tia:IMKAD_Persoon/tia:tia_PartijOnderdeel, $upper, $lower) = translate($both, $upper, $lower)">
											<xsl:text>true</xsl:text>
										</xsl:when>
										<xsl:when test="$allPersonsProcessed = 'true'">
											<xsl:text>true</xsl:text>
										</xsl:when>
										<xsl:otherwise>
											<xsl:text>false</xsl:text>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:variable>
								<xsl:variable name="currentPersonIsMortgager">
									<xsl:choose>
										<xsl:when test="translate(tia:IMKAD_Persoon/tia:tia_PartijOnderdeel, $upper, $lower) = translate($mortgager, $upper, $lower) or translate(tia:IMKAD_Persoon/tia:tia_PartijOnderdeel, $upper, $lower) = translate($both, $upper, $lower)">
											<xsl:text>true</xsl:text>
										</xsl:when>
										<xsl:when test="$allPersonsProcessed = 'true'">
											<xsl:text>true</xsl:text>
										</xsl:when>
										<xsl:otherwise>
											<xsl:text>false</xsl:text>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:variable>
								<xsl:if test="translate(tia:IMKAD_Persoon/tia:tia_IndGerechtigde, $upper, $lower) = 'true' and 
												(($debtorPersonsProcessed = 'true' and $currentPersonIsDebtor = 'true') or ($mortgagerPersonsProcessed = 'true' and $currentPersonIsMortgager = 'true'))">
									<xsl:variable name="relatedPersonAuthorizedRepresentative" select="$currentParty/tia:Gevolmachtigde[tia:vertegenwoordigtRef/@xlink:href = concat('#', $currentParty/tia:Hoedanigheid[tia:wordtVertegenwoordigdRef/@xlink:href=concat('#',$currentPerson/@id)]/@id)]"/>
									<xsl:variable name="allreadyProcessed">
										<xsl:choose>
											<xsl:when test="$relatedPersonAuthorizedRepresentative/tia:volmachtgeverRef[@xlink:href = concat('#',current()/preceding-sibling::tia:GerelateerdPersoon/tia:IMKAD_Persoon/@id)]">
												<xsl:text>true</xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text>false</xsl:text>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:variable>
									<!-- print only if Gevolmachtigde (per person) number is not printed already -->
									<xsl:if test="$allreadyProcessed = 'false'">
										<tia:group>
											<xsl:apply-templates select="tia:IMKAD_Persoon/tia:tia_Gegevens" mode="do-person-name"/>
										</tia:group>
									</xsl:if>
								</xsl:if>
							</xsl:for-each>
						</xsl:when>
					</xsl:choose>
				</xsl:when>
				<!-- printing NUMBER for persons-->
				<xsl:when test="$number and $existGevolmachtigde = 0">
					<!-- PNP -->
					<xsl:if test="tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene">
						<!-- main person -->
						<xsl:if test="translate(tia:tia_IndGerechtigde, $upper, $lower) = 'true' and 
										(($debtorPersonsProcessed = 'true' and $personIsDebtor = 'true') or ($mortgagerPersonsProcessed = 'true' and $personIsMortgager = 'true'))">
							<tia:group>
								<xsl:value-of select="$partyNumber"/>
								<xsl:choose>
									<xsl:when test="$onlyPersonInParty = 'true'">
										<xsl:if test="tia:GerelateerdPersoon">
											<xsl:number value="1" format="a"/>
										</xsl:if>
									</xsl:when>
									<xsl:otherwise>
										<xsl:number value="$positionWithinParty" format="a"/>
										<xsl:if test="tia:GerelateerdPersoon">
											<xsl:number value="1" format="1"/>
										</xsl:if>
									</xsl:otherwise>
								</xsl:choose>
							</tia:group>
						</xsl:if>
						<!-- related person(s) -->
						<xsl:for-each select="tia:GerelateerdPersoon">
							<xsl:variable name="currentPerson" select="tia:IMKAD_Persoon"/>
							<xsl:variable name="currentPersonIsDebtor">
								<xsl:choose>
									<xsl:when test="translate(tia:IMKAD_Persoon/tia:tia_PartijOnderdeel, $upper, $lower) = translate($debtor, $upper, $lower) or translate(tia:IMKAD_Persoon/tia:tia_PartijOnderdeel, $upper, $lower) = translate($both, $upper, $lower)">
										<xsl:text>true</xsl:text>
									</xsl:when>
									<xsl:when test="$allPersonsProcessed = 'true'">
										<xsl:text>true</xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text>false</xsl:text>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:variable>
							<xsl:variable name="currentPersonIsMortgager">
								<xsl:choose>
									<xsl:when test="translate(tia:IMKAD_Persoon/tia:tia_PartijOnderdeel, $upper, $lower) = translate($mortgager, $upper, $lower) or translate(tia:IMKAD_Persoon/tia:tia_PartijOnderdeel, $upper, $lower) = translate($both, $upper, $lower)">
										<xsl:text>true</xsl:text>
									</xsl:when>
									<xsl:when test="$allPersonsProcessed = 'true'">
										<xsl:text>true</xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text>false</xsl:text>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:variable>
							<xsl:if test="translate(tia:IMKAD_Persoon/tia:tia_IndGerechtigde, $upper, $lower) = 'true' and 
											(($debtorPersonsProcessed = 'true' and $currentPersonIsDebtor = 'true') or ($mortgagerPersonsProcessed = 'true' and $currentPersonIsMortgager = 'true'))">
								<tia:group>
									<xsl:value-of select="$partyNumber"/>
									<xsl:choose>
										<xsl:when test="$onlyPersonInParty = 'true'">
											<xsl:number value="position() + 1" format="a"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:number value="$positionWithinParty" format="a"/>
											<xsl:number value="position() + 1" format="1"/>
										</xsl:otherwise>
									</xsl:choose>
								</tia:group>
							</xsl:if>
						</xsl:for-each>
					</xsl:if>
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-person-name
	*********************************************************
	Public: yes

	Identity transform: no

	Description: Print name from tia:GBA_Ingezetene, tia:IMKAD_KadNatuurlijkPersoon, tia:IMKAD_NietIngezetene, tia:NHR_Rechtspersoon

	Input: tia:tia_Gegevens

	Params: none

	Output: text

	Calls:
	(mode) do-gender-salutation

	Called by:
	(mode) do-person-numbering
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:tia_Gegevens" mode="do-person-name">
		<xsl:choose>
			<xsl:when test="tia:GBA_Ingezetene">
				<xsl:apply-templates select="tia:GBA_Ingezetene" mode="do-gender-salutation"/>
				<xsl:text> </xsl:text>
				<xsl:variable name="kadNatuurlijkPersoon" select="../tia:tia_Gegevens[tia:IMKAD_KadNatuurlijkPersoon]/tia:IMKAD_KadNatuurlijkPersoon"/>
				<xsl:choose>
					<xsl:when test="$kadNatuurlijkPersoon">
						<xsl:value-of select="$kadNatuurlijkPersoon/tia:voornamen"/>
						<xsl:if test="$kadNatuurlijkPersoon/tia:voorvoegselsgeslachtsnaam
								and normalize-space($kadNatuurlijkPersoon/tia:voorvoegselsgeslachtsnaam) != ''">
							<xsl:text> </xsl:text>
							<xsl:value-of select="$kadNatuurlijkPersoon/tia:voorvoegselsgeslachtsnaam"/>
						</xsl:if>
						<xsl:text> </xsl:text>
						<xsl:value-of select="$kadNatuurlijkPersoon/tia:geslachtsnaam"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="tia:GBA_Ingezetene/tia:naam/tia:voornamen"/>
						<xsl:if test="tia:GBA_Ingezetene/tia:tia_VoorvoegselsNaam
								and normalize-space(tia:GBA_Ingezetene/tia:tia_VoorvoegselsNaam) != ''">
							<xsl:text> </xsl:text>
							<xsl:value-of select="tia:GBA_Ingezetene/tia:tia_VoorvoegselsNaam"/>
						</xsl:if>
						<xsl:text> </xsl:text>
						<xsl:value-of select="tia:GBA_Ingezetene/tia:tia_NaamZonderVoorvoegsels"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="tia:IMKAD_NietIngezetene">
				<xsl:apply-templates select="tia:IMKAD_NietIngezetene" mode="do-gender-salutation"/>
				<xsl:text> </xsl:text>
				<xsl:value-of select="tia:IMKAD_NietIngezetene/tia:voornamen"/>
				<xsl:if test="tia:IMKAD_NietIngezetene/tia:voorvoegsels
						and normalize-space(tia:IMKAD_NietIngezetene/tia:voorvoegsels) != ''">
					<xsl:text> </xsl:text>
					<xsl:value-of select="tia:IMKAD_NietIngezetene/tia:voorvoegsels"/>
				</xsl:if>
				<xsl:text> </xsl:text>
				<xsl:value-of select="tia:IMKAD_NietIngezetene/tia:geslachtsnaam"/>
			</xsl:when>
			<xsl:when test="tia:NHR_Rechtspersoon">
				<xsl:choose>
					<xsl:when test="../tia:tia_AanduidingPersoon">
						<xsl:value-of select="../tia:tia_AanduidingPersoon"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="tia:NHR_Rechtspersoon/tia:statutaireNaam"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
