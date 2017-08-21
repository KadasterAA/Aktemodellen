<?xml version="1.0" encoding="UTF-8"?>
<!--
*********************************************************
Stylesheet: tekstblok_partijnamen_in_hypotheekakten.xsl
Version: 1.03
*********************************************************
Description:
Mortgage deed party name text block.

Public:
(mode) do-mortgage-deed-party-name
(mode) do-person-numbering

Private:
none
-->
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
	xmlns:tia="http://www.kadaster.nl/schemas/KIK/TIA_Algemeen"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	exclude-result-prefixes="tia xsl"
	version="1.0">

	<!--
	*********************************************************
	Mode: do-mortgage-deed-party-name
	*********************************************************
	Public: yes

	Identity transform: no

	Description: Mortgage deed party name text block.

	Input: tia:Partij

	Params: start - start of person numbering, default is 0
			partyNumber - number of the party, default is 1

	Output: text

	Calls:
	(mode) do-person-numbering

	Called by:
	(mode) do-parties
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:Partij" mode="do-mortgage-deed-party-name">
		<xsl:param name="start" select="number('0')"/>
		<xsl:param name="partyNumber" select="number('1')"/>

		<xsl:variable name="debtor" select="'de Schuldenaar'"/>
		<xsl:variable name="mortgager" select="'de Hypotheekgever'"/>
		<xsl:variable name="both" select="'de Schuldenaar en/of de Hypotheekgever'"/>

		<xsl:choose>
			<xsl:when test="translate(tia:aanduidingPartij, $upper, $lower) = 'aanduiding per persoon'">
				<xsl:variable name="numberOfPersonPairs" select="count(tia:IMKAD_Persoon[tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene]/tia:GerelateerdPersoon[tia:rol])"/>
				<xsl:variable name="level">
					<xsl:choose>
						<xsl:when test="count(tia:IMKAD_Persoon) = 1 and $numberOfPersonPairs = 0">
							<xsl:value-of select="'1'"/>
						</xsl:when>
						<xsl:when test="(count(tia:IMKAD_Persoon) = 1 and $numberOfPersonPairs = 1)
								or (count(tia:IMKAD_Persoon) > 1 and $numberOfPersonPairs = 0)">
							<xsl:value-of select="'2'"/>
						</xsl:when>
						<xsl:when test="count(tia:IMKAD_Persoon) > 1 and $numberOfPersonPairs >= 1">
							<xsl:value-of select="'3'"/>
						</xsl:when>
					</xsl:choose>
				</xsl:variable>
				<xsl:variable name="numberOfDebtorPersons" select="count(tia:IMKAD_Persoon[translate(tia:tia_PartijOnderdeel, $upper, $lower) = translate($debtor, $upper, $lower) or translate(tia:tia_PartijOnderdeel, $upper, $lower) = translate($both, $upper, $lower)])
						+ count(tia:IMKAD_Persoon[tia:tia_Gegevens/tia:NHR_Rechtspersoon and (translate(tia:tia_PartijOnderdeel, $upper, $lower) = translate($debtor, $upper, $lower) or translate(tia:tia_PartijOnderdeel, $upper, $lower) = translate($both, $upper, $lower))]/tia:GerelateerdPersoon[translate(tia:tia_IndPartij, $upper, $lower) = 'true'])
						+ count(tia:IMKAD_Persoon[tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene]/tia:GerelateerdPersoon[translate(tia:tia_IndPartij, $upper, $lower) = 'true']/tia:IMKAD_Persoon[translate(tia:tia_PartijOnderdeel, $upper, $lower) = translate($debtor, $upper, $lower) or translate(tia:tia_PartijOnderdeel, $upper, $lower) = translate($both, $upper, $lower)])"/>
				<xsl:variable name="numberOfMortgagerPersons" select="count(tia:IMKAD_Persoon[translate(tia:tia_PartijOnderdeel, $upper, $lower) = translate($mortgager, $upper, $lower) or translate(tia:tia_PartijOnderdeel, $upper, $lower) = translate($both, $upper, $lower)])
						+ count(tia:IMKAD_Persoon[tia:tia_Gegevens/tia:NHR_Rechtspersoon and (translate(tia:tia_PartijOnderdeel, $upper, $lower) = translate($mortgager, $upper, $lower) or translate(tia:tia_PartijOnderdeel, $upper, $lower) = translate($both, $upper, $lower))]/tia:GerelateerdPersoon[translate(tia:tia_IndPartij, $upper, $lower) = 'true'])
						+ count(tia:IMKAD_Persoon[tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene]/tia:GerelateerdPersoon[translate(tia:tia_IndPartij, $upper, $lower) = 'true']/tia:IMKAD_Persoon[translate(tia:tia_PartijOnderdeel, $upper, $lower) = translate($mortgager, $upper, $lower) or translate(tia:tia_PartijOnderdeel, $upper, $lower) = translate($both, $upper, $lower)])"/>

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
				<xsl:apply-templates select="tia:IMKAD_Persoon[translate(tia:tia_PartijOnderdeel, $upper, $lower) = translate($debtor, $upper, $lower)
								or translate(tia:tia_PartijOnderdeel, $upper, $lower) = translate($both, $upper, $lower)]
							| tia:IMKAD_Persoon[tia:tia_Gegevens/tia:GBA_Ingezetene
								or tia:tia_Gegevens/tia:IMKAD_NietIngezetene]/tia:GerelateerdPersoon[
									translate(tia:tia_IndPartij, $upper, $lower) = 'true']/tia:IMKAD_Persoon[translate(tia:tia_PartijOnderdeel, $upper, $lower) = translate($debtor, $upper, $lower)
								or translate(tia:tia_PartijOnderdeel, $upper, $lower) = translate($both, $upper, $lower)]"
						mode="do-person-numbering">
					<xsl:with-param name="start" select="$start"/>
					<xsl:with-param name="partyNumber" select="$partyNumber" />
					<xsl:with-param name="level" select="$level" />
				</xsl:apply-templates>
				<xsl:text> hierna </xsl:text>
				<xsl:if test="$numberOfDebtorPersons > 1">
					<xsl:text>zowel tezamen als ieder afzonderlijk </xsl:text>
				</xsl:if>
				<xsl:text>ook te noemen: '</xsl:text>
				<u><xsl:text>de Schuldenaar</xsl:text></u>
				<xsl:text>' en de verschenen </xsl:text>
				<xsl:choose>
					<xsl:when test="$numberOfMortgagerPersons > 1">
						<xsl:text>personen </xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>persoon </xsl:text>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:text>sub </xsl:text>
				<xsl:apply-templates select="tia:IMKAD_Persoon[translate(tia:tia_PartijOnderdeel, $upper, $lower) = translate($mortgager, $upper, $lower)
								or translate(tia:tia_PartijOnderdeel, $upper, $lower) = translate($both, $upper, $lower)]
							| tia:IMKAD_Persoon[tia:tia_Gegevens/tia:GBA_Ingezetene
								or tia:tia_Gegevens/tia:IMKAD_NietIngezetene]/tia:GerelateerdPersoon[
									translate(tia:tia_IndPartij, $upper, $lower) = 'true']/tia:IMKAD_Persoon[translate(tia:tia_PartijOnderdeel, $upper, $lower) = translate($mortgager, $upper, $lower)
								or translate(tia:tia_PartijOnderdeel, $upper, $lower) = translate($both, $upper, $lower)]"
						mode="do-person-numbering">
					<xsl:with-param name="start" select="$start"/>
					<xsl:with-param name="partyNumber" select="$partyNumber" />
					<xsl:with-param name="level" select="$level" />
				</xsl:apply-templates>
				<xsl:text> hierna </xsl:text>
				<xsl:if test="$numberOfMortgagerPersons > 1">
					<xsl:text>zowel tezamen als ieder afzonderlijk </xsl:text>
				</xsl:if>
				<xsl:text>ook te noemen: '</xsl:text>
				<u><xsl:text>de Hypotheekgever</xsl:text></u>
				<xsl:text>'</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>hierna </xsl:text>
				<xsl:if test="count(tia:IMKAD_Persoon) + count(tia:IMKAD_Persoon/tia:GerelateerdPersoon[translate(tia:tia_IndPartij, $upper, $lower) = 'true']) > 1">
					<xsl:text>zowel tezamen als ieder afzonderlijk </xsl:text>
				</xsl:if>
				<xsl:text>ook te noemen: </xsl:text>
				<xsl:choose>
					<xsl:when test="contains(translate(tia:aanduidingPartij, $upper, $lower), 'en/of')">
						<xsl:text>'</xsl:text><u><xsl:value-of select="substring-before(translate(tia:aanduidingPartij, $upper, $lower), ' en/of')"/></u><xsl:text>'</xsl:text>
						<xsl:text> en/of '</xsl:text><u><xsl:value-of select="substring-after(translate(tia:aanduidingPartij, $upper, $lower), 'en/of ')"/></u><xsl:text>'</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>'</xsl:text><u><xsl:value-of select="tia:aanduidingPartij"/></u><xsl:text>'</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
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

	Params: start - start of person numbering
			partyNumber - number of the party
			level - numbering level

	Output: text

	Calls:
	none

	Called by:
	(mode) do-mortgage-deed-party-name
	(mode) do-deed (hypotheek_westland_utrecht.xsl)
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon" mode="do-person-numbering">
		<xsl:param name="start" />
		<xsl:param name="partyNumber" />
		<xsl:param name="level" />

		<xsl:variable name="personPosition">
			<xsl:choose>
				<xsl:when test="$start = 0">
					<xsl:value-of select="count(preceding-sibling::tia:IMKAD_Persoon) + count(parent::tia:GerelateerdPersoon/parent::tia:IMKAD_Persoon/preceding-sibling::tia:IMKAD_Persoon) + 1"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="count(preceding-sibling::tia:IMKAD_Persoon) + count(parent::tia:GerelateerdPersoon/parent::tia:IMKAD_Persoon/preceding-sibling::tia:IMKAD_Persoon) + $start"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:choose>
			<xsl:when test="parent::tia:GerelateerdPersoon">
				<xsl:choose>
					<xsl:when test="$level = '3'">
						<xsl:value-of select="$partyNumber"/>
						<xsl:number value="$personPosition" format="a"/>
						<xsl:text>2</xsl:text>
					</xsl:when>
					<xsl:when test="$level = '2'">
						<xsl:value-of select="$partyNumber"/>
						<xsl:number value="$personPosition + 1" format="a"/>
					</xsl:when>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="$level = '3' or $level = '2'">
						<xsl:value-of select="$partyNumber"/>
						<xsl:number value="$personPosition" format="a"/>
						<xsl:if test="$level = '3' and (tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene) and tia:GerelateerdPersoon">
							<xsl:text>1</xsl:text>
						</xsl:if>
					</xsl:when>
					<xsl:when test="$level = '1'">
						<xsl:value-of select="$partyNumber"/>
					</xsl:when>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="position() + 1 = last()">
				<xsl:text> en </xsl:text>
			</xsl:when>
			<xsl:when test="position() != last()">
				<xsl:text>, </xsl:text>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>
