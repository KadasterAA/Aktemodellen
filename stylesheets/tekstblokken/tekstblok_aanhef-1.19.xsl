<?xml version="1.0" encoding="UTF-8"?>
<!--
*********************************************************
Stylesheet: tekstblok_aanhef.xsl
Version: 1.19 (AA-4313)
*********************************************************
Description:
Header text block.

Public:
(mode) do-header

Private:
none
-->
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
	xmlns:tia="http://www.kadaster.nl/schemas/KIK/TIA_Algemeen"
	xmlns:kef="nl.kadaster.xslt.XslExtensionFunctions"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	exclude-result-prefixes="tia kef xsl"
	version="1.0">

	<!--
	*********************************************************
	Mode: do-header
	*********************************************************
	Public: yes

	Identity transform: no

	Description: Header text block.

	Input: tia:IMKAD_AangebodenStuk

	Params: none

	Output: XHTML structure (<p/>)

	Calls:
	(mode) do-natural-person-personal-data

	Called by:
	(mode) do-deed
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_AangebodenStuk" mode="do-header">
		<xsl:variable name="Datum_DATE" select="substring(string(tia:tia_DatumOndertekening), 0, 11)"/>
		<xsl:variable name="Datum_STRING">
			<xsl:if test="$Datum_DATE != ''">
				<xsl:value-of select="kef:convertDateToText($Datum_DATE)"/>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="indicationToday" select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_dagaanduiding']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_dagaanduiding']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_dagaanduiding']/tia:tekst), $upper, $lower)]), $upper, $lower)]" />
		<xsl:variable name="declarerPlace" select="translate(tia:heeftOndertekenaar/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_ondertekenaarplaatsaanduiding']/tia:tekst, $upper, $lower)" />
		<xsl:variable name="gemeente" select="tia:heeftOndertekenaar/tia:gemeente"/>
		<xsl:variable name="woonplaats" select="tia:heeftOndertekenaar/tia:standplaats"/>
		<xsl:variable name="aantalVerschenenGevolmachtigdenAllePartijen">
			<xsl:value-of select="(count(tia:Gevolmachtigde) + count(tia:Gevolmachtigde/tia:GerelateerdPersoon))"/>
		</xsl:variable>
		<xsl:variable name="aantalPartijen">
			<xsl:value-of select="count(tia:Partij)"/>
		</xsl:variable>
		<xsl:variable name="aantalVerschenenGevolmachtigden">
			<xsl:value-of select="(count(tia:Partij/tia:Gevolmachtigde) + count(tia:Partij/tia:Gevolmachtigde/tia:GerelateerdPersoon))"/>
		</xsl:variable>
		<xsl:variable name="aantalVerschenenNP">
			<xsl:value-of select="(count(tia:Partij[not(tia:Gevolmachtigde)]//tia:IMKAD_Persoon/tia:tia_Gegevens/tia:GBA_Ingezetene) + count(tia:Partij[not(tia:Gevolmachtigde)]//tia:IMKAD_Persoon/tia:tia_Gegevens/tia:IMKAD_NietIngezetene))"/>
		</xsl:variable>	
		<p>
			<xsl:value-of select="$indicationToday"/>
			<xsl:if test="translate($indicationToday, $upper, $lower) != 'op'">
				<xsl:text>,</xsl:text>
			</xsl:if>
			<xsl:text> </xsl:text>
			<xsl:value-of select="$Datum_STRING"/>
			<xsl:text>, </xsl:text>
			<xsl:choose>
				<xsl:when test="$aantalVerschenenGevolmachtigdenAllePartijen = 1 or ($aantalPartijen = 1 and ($aantalVerschenenGevolmachtigden = 1 or $aantalVerschenenNP = 1))">
					<xsl:choose>
						<xsl:when test="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verschijnenverledentijd']/tia:tekst = 'false'">
							<xsl:text>verschijnt </xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>verscheen </xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verschijnenverledentijd']/tia:tekst = 'false'">
							<xsl:text>verschijnen </xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>verschenen </xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text> voor mij, </xsl:text>
			<xsl:apply-templates select="tia:heeftOndertekenaar/tia:persoonsgegevens" mode="do-natural-person-personal-data" />
			<xsl:text>, </xsl:text>
			<xsl:choose>
				<xsl:when test="not(tia:heeftOndertekenaar/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_ondertekenaarwaarneming'])">
					<xsl:text>notaris</xsl:text>
					<xsl:if test="$gemeente">
						<xsl:text> in de gemeente </xsl:text>
						<xsl:value-of select="$gemeente"/>
					</xsl:if>
					<xsl:if test="$woonplaats">
						<xsl:if test="tia:heeftOndertekenaar/tia:gemeente">
							<xsl:text>,</xsl:text>
						</xsl:if>
						<xsl:text> </xsl:text>
						<xsl:choose>
							<xsl:when test="tia:heeftOndertekenaar/tia:gemeente">
								<xsl:text>kantoorhoudende te </xsl:text>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="$declarerPlace"/>
								<xsl:text> </xsl:text>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:value-of select="$woonplaats"/>
					</xsl:if>
				</xsl:when>
				<xsl:otherwise>
					<!-- Skip KEUZEBLOKVARIANT WAARNEMING when k_ondertekenaarwaarneming = 'geen waarneming' -->
					<xsl:choose>
						<!-- waarneming -->
						<xsl:when test="translate(tia:heeftOndertekenaar/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_ondertekenaarwaarneming']/tia:tekst, $upper, $lower) = 'waarneming'">
							<xsl:value-of select="translate(tia:heeftOndertekenaar/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_ondertekenaarkandidaat']/tia:tekst, $upper, $lower)"/>
							<xsl:text> hierna te noemen: </xsl:text>
							<xsl:text>‘</xsl:text>
							<u><xsl:text>notaris</xsl:text></u>
							<xsl:text>’</xsl:text>
							<xsl:text>, als waarnemer van </xsl:text>
							<xsl:apply-templates select="tia:heeftOndertekenaar/tia:isWaarnemerVoor/tia:persoonsgegevens" mode="do-natural-person-personal-data" />
						</xsl:when>
						<!-- vacant kantoor -->
						<xsl:when test="translate(tia:heeftOndertekenaar/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_ondertekenaarwaarneming']/tia:tekst, $upper, $lower) = 'vacant kantoor'">
							<xsl:value-of select="translate(tia:heeftOndertekenaar/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_ondertekenaarkandidaat']/tia:tekst, $upper, $lower)"/>
							<xsl:text> hierna te noemen: </xsl:text>
							<xsl:text>‘</xsl:text>
							<u><xsl:text>notaris</xsl:text></u>
							<xsl:text>’</xsl:text>
							<xsl:text>, als waarnemer </xsl:text>
							<xsl:if test="tia:heeftOndertekenaar/tia:isWaarnemerVoor/tia:persoonsgegevens">
								<xsl:text>van </xsl:text>
								<xsl:apply-templates select="tia:heeftOndertekenaar/tia:isWaarnemerVoor/tia:persoonsgegevens" mode="do-natural-person-personal-data" />
							</xsl:if>
							<xsl:if test="tia:heeftOndertekenaar/tia:isWaarnemerVoor">
								<xsl:if test="tia:heeftOndertekenaar/tia:isWaarnemerVoor/tia:gemeente or tia:heeftOndertekenaar/tia:isWaarnemerVoor/tia:standplaats">
									<xsl:text>, notaris</xsl:text>
								</xsl:if>
								<xsl:if test="tia:heeftOndertekenaar/tia:isWaarnemerVoor/tia:gemeente">
									<xsl:text> in de gemeente </xsl:text>
									<xsl:value-of select="tia:heeftOndertekenaar/tia:isWaarnemerVoor/tia:gemeente"/>
								</xsl:if>
								<xsl:if test="tia:heeftOndertekenaar/tia:isWaarnemerVoor/tia:standplaats">
									<xsl:if test="tia:heeftOndertekenaar/tia:isWaarnemerVoor/tia:gemeente">
										<xsl:text>,</xsl:text>
									</xsl:if>
									<xsl:text> </xsl:text>
									<xsl:choose>
										<xsl:when test="tia:heeftOndertekenaar/tia:isWaarnemerVoor/tia:gemeente">
											<xsl:text>kantoorhoudende te</xsl:text>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="translate(tia:heeftOndertekenaar/tia:isWaarnemerVoor/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_ondertekenaarplaatsaanduiding']/tia:tekst, $upper, $lower)"/>
										</xsl:otherwise>
									</xsl:choose>
									<xsl:text> </xsl:text>
									<xsl:value-of select="tia:heeftOndertekenaar/tia:isWaarnemerVoor/tia:standplaats"/>
								</xsl:if>
								<xsl:text>, als waarnemer</xsl:text>
							</xsl:if>
							<xsl:text> van het vacante </xsl:text>
							<xsl:value-of select="translate(tia:heeftOndertekenaar/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_ondertekenaarvacantkantoor']/tia:tekst, $upper, $lower)"/>
							<xsl:text> van </xsl:text>
							<xsl:choose>
								<xsl:when test="tia:heeftOndertekenaar/tia:isVacatureWaarnemerVoor/tia:persoonsgegevens">
									<xsl:apply-templates select="tia:heeftOndertekenaar/tia:isVacatureWaarnemerVoor/tia:persoonsgegevens" mode="do-natural-person-personal-data"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:apply-templates select="tia:heeftOndertekenaar/tia:isWaarnemerVoor/tia:isVacatureWaarnemerVoor/tia:persoonsgegevens" mode="do-natural-person-personal-data" />
								</xsl:otherwise>
							</xsl:choose>
							<xsl:text>, destijds notaris</xsl:text>
							<xsl:choose>
								<xsl:when test="tia:heeftOndertekenaar/tia:isVacatureWaarnemerVoor">
									<xsl:if test="tia:heeftOndertekenaar/tia:isVacatureWaarnemerVoor/tia:gemeente">
										<xsl:text> in de gemeente </xsl:text>
										<xsl:value-of select="tia:heeftOndertekenaar/tia:isVacatureWaarnemerVoor/tia:gemeente"/>
									</xsl:if>
									<xsl:if test="tia:heeftOndertekenaar/tia:isVacatureWaarnemerVoor/tia:standplaats">
										<xsl:if test="tia:heeftOndertekenaar/tia:isVacatureWaarnemerVoor/tia:gemeente">
											<xsl:text>,</xsl:text>
										</xsl:if>
										<xsl:text> </xsl:text>
										<xsl:choose>
											<xsl:when test="tia:heeftOndertekenaar/tia:isVacatureWaarnemerVoor/tia:gemeente">
												<xsl:text>kantoorhoudende te</xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="translate(tia:heeftOndertekenaar/tia:isVacatureWaarnemerVoor/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_ondertekenaarplaatsaanduiding']/tia:tekst, $upper, $lower)"/>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:text> </xsl:text>
										<xsl:value-of select="tia:heeftOndertekenaar/tia:isVacatureWaarnemerVoor/tia:standplaats"/>
									</xsl:if>
								</xsl:when>
								<xsl:otherwise>
									<xsl:if test="tia:heeftOndertekenaar/tia:isWaarnemerVoor/tia:isVacatureWaarnemerVoor/tia:gemeente">
										<xsl:text> in de gemeente </xsl:text>
										<xsl:value-of select="tia:heeftOndertekenaar/tia:isWaarnemerVoor/tia:isVacatureWaarnemerVoor/tia:gemeente"/>
									</xsl:if>
									<xsl:if test="tia:heeftOndertekenaar/tia:isWaarnemerVoor/tia:isVacatureWaarnemerVoor/tia:standplaats">
										<xsl:if test="tia:heeftOndertekenaar/tia:isWaarnemerVoor/tia:isVacatureWaarnemerVoor/tia:gemeente">
											<xsl:text>,</xsl:text>
										</xsl:if>
										<xsl:text> </xsl:text>
										<xsl:choose>
											<xsl:when test="tia:heeftOndertekenaar/tia:isWaarnemerVoor/tia:isVacatureWaarnemerVoor/tia:gemeente">
												<xsl:text>kantoorhoudende te</xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="translate(tia:heeftOndertekenaar/tia:isWaarnemerVoor/tia:isVacatureWaarnemerVoor/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_ondertekenaarplaatsaanduiding']/tia:tekst, $upper, $lower)"/>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:text> </xsl:text>
										<xsl:value-of select="tia:heeftOndertekenaar/tia:isWaarnemerVoor/tia:isVacatureWaarnemerVoor/tia:standplaats"/>
									</xsl:if>							
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<!-- verlof -->
						<xsl:when test="translate(tia:heeftOndertekenaar/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_ondertekenaarwaarneming']/tia:tekst, $upper, $lower) = 'verlof'">
							<xsl:value-of select="translate(tia:heeftOndertekenaar/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_ondertekenaarkandidaat']/tia:tekst, $upper, $lower)"/>
							<xsl:text> hierna te noemen: </xsl:text>
							<xsl:text>‘</xsl:text>
							<u><xsl:text>notaris</xsl:text></u>
							<xsl:text>’</xsl:text>
							<xsl:text>, als waarnemer van de met verlof afwezige </xsl:text>
							<xsl:apply-templates select="tia:heeftOndertekenaar/tia:isWaarnemerVoor/tia:persoonsgegevens" mode="do-natural-person-personal-data" />
						</xsl:when>
						<!-- toegevoegd notaris -->
						<xsl:when test="translate(tia:heeftOndertekenaar/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_ondertekenaarwaarneming']/tia:tekst, $upper, $lower) = 'toegevoegd notaris'">
							<xsl:text> toegevoegd notaris, bevoegd om akten te passeren in het protocol van  </xsl:text>
							<xsl:apply-templates select="tia:heeftOndertekenaar/tia:isWaarnemerVoor/tia:persoonsgegevens" mode="do-natural-person-personal-data" />
						</xsl:when>
						<!-- waarneming kantoor/protocol -->
						<xsl:when test="translate(tia:heeftOndertekenaar/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_ondertekenaarwaarneming']/tia:tekst, $upper, $lower) = 'niet vacant kantoor'">
							<xsl:value-of select="translate(tia:heeftOndertekenaar/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_ondertekenaarkandidaat']/tia:tekst, $upper, $lower)"/>
							<xsl:text> hierna te noemen: </xsl:text>
							<xsl:text>‘</xsl:text>
							<u><xsl:text>notaris</xsl:text></u>
							<xsl:text>’</xsl:text>
							<xsl:text>, als waarnemer </xsl:text>
							<xsl:if test="tia:heeftOndertekenaar/tia:isWaarnemerVoor/tia:persoonsgegevens">
								<xsl:text>van </xsl:text>
								<xsl:apply-templates select="tia:heeftOndertekenaar/tia:isWaarnemerVoor/tia:persoonsgegevens" mode="do-natural-person-personal-data" />
							</xsl:if>
							<xsl:if test="tia:heeftOndertekenaar/tia:isWaarnemerVoor">
								<xsl:if test="tia:heeftOndertekenaar/tia:isWaarnemerVoor/tia:gemeente or tia:heeftOndertekenaar/tia:isWaarnemerVoor/tia:standplaats">
									<xsl:text>, notaris</xsl:text>
								</xsl:if>
								<xsl:if test="tia:heeftOndertekenaar/tia:isWaarnemerVoor/tia:gemeente">
									<xsl:text> in de gemeente </xsl:text>
									<xsl:value-of select="tia:heeftOndertekenaar/tia:isWaarnemerVoor/tia:gemeente"/>
								</xsl:if>
								<xsl:if test="tia:heeftOndertekenaar/tia:isWaarnemerVoor/tia:standplaats">
									<xsl:if test="tia:heeftOndertekenaar/tia:isWaarnemerVoor/tia:gemeente">
										<xsl:text>,</xsl:text>
									</xsl:if>
									<xsl:text> </xsl:text>
									<xsl:choose>
										<xsl:when test="tia:heeftOndertekenaar/tia:isWaarnemerVoor/tia:gemeente">
											<xsl:text>kantoorhoudende te</xsl:text>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="translate(tia:heeftOndertekenaar/tia:isWaarnemerVoor/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_ondertekenaarplaatsaanduiding']/tia:tekst, $upper, $lower)"/>
										</xsl:otherwise>
									</xsl:choose>
									<xsl:text> </xsl:text>
									<xsl:value-of select="tia:heeftOndertekenaar/tia:isWaarnemerVoor/tia:standplaats"/>
								</xsl:if>
								<xsl:text>, als waarnemer</xsl:text>
							</xsl:if>
							<xsl:text> van het </xsl:text>
							<xsl:value-of select="translate(tia:heeftOndertekenaar/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_ondertekenaarvacantkantoor']/tia:tekst, $upper, $lower)"/>
							<xsl:text> van </xsl:text>
							<xsl:choose>
								<xsl:when test="tia:heeftOndertekenaar/tia:isVacatureWaarnemerVoor/tia:persoonsgegevens">
									<xsl:apply-templates select="tia:heeftOndertekenaar/tia:isVacatureWaarnemerVoor/tia:persoonsgegevens" mode="do-natural-person-personal-data"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:apply-templates select="tia:heeftOndertekenaar/tia:isWaarnemerVoor/tia:isVacatureWaarnemerVoor/tia:persoonsgegevens" mode="do-natural-person-personal-data" />
								</xsl:otherwise>
							</xsl:choose>
							<xsl:text>, notaris</xsl:text>
							<xsl:choose>
								<xsl:when test="tia:heeftOndertekenaar/tia:isVacatureWaarnemerVoor">
									<xsl:if test="tia:heeftOndertekenaar/tia:isVacatureWaarnemerVoor/tia:gemeente">
										<xsl:text> in de gemeente </xsl:text>
										<xsl:value-of select="tia:heeftOndertekenaar/tia:isVacatureWaarnemerVoor/tia:gemeente"/>
									</xsl:if>
									<xsl:if test="tia:heeftOndertekenaar/tia:isVacatureWaarnemerVoor/tia:standplaats">
										<xsl:if test="tia:heeftOndertekenaar/tia:isVacatureWaarnemerVoor/tia:gemeente">
											<xsl:text>,</xsl:text>
										</xsl:if>
										<xsl:text> </xsl:text>
										<xsl:choose>
											<xsl:when test="tia:heeftOndertekenaar/tia:isVacatureWaarnemerVoor/tia:gemeente">
												<xsl:text>kantoorhoudende te</xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="translate(tia:heeftOndertekenaar/tia:isVacatureWaarnemerVoor/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_ondertekenaarplaatsaanduiding']/tia:tekst, $upper, $lower)"/>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:text> </xsl:text>
										<xsl:value-of select="tia:heeftOndertekenaar/tia:isVacatureWaarnemerVoor/tia:standplaats"/>
									</xsl:if>
								</xsl:when>
								<xsl:otherwise>
									<xsl:if test="tia:heeftOndertekenaar/tia:isWaarnemerVoor/tia:isVacatureWaarnemerVoor/tia:gemeente">
										<xsl:text> in de gemeente </xsl:text>
										<xsl:value-of select="tia:heeftOndertekenaar/tia:isWaarnemerVoor/tia:isVacatureWaarnemerVoor/tia:gemeente"/>
									</xsl:if>
									<xsl:if test="tia:heeftOndertekenaar/tia:isWaarnemerVoor/tia:isVacatureWaarnemerVoor/tia:standplaats">
										<xsl:if test="tia:heeftOndertekenaar/tia:isWaarnemerVoor/tia:isVacatureWaarnemerVoor/tia:gemeente">
											<xsl:text>,</xsl:text>
										</xsl:if>
										<xsl:text> </xsl:text>
										<xsl:choose>
											<xsl:when test="tia:heeftOndertekenaar/tia:isWaarnemerVoor/tia:isVacatureWaarnemerVoor/tia:gemeente">
												<xsl:text>kantoorhoudende te</xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="translate(tia:heeftOndertekenaar/tia:isWaarnemerVoor/tia:isVacatureWaarnemerVoor/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_ondertekenaarplaatsaanduiding']/tia:tekst, $upper, $lower)"/>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:text> </xsl:text>
										<xsl:value-of select="tia:heeftOndertekenaar/tia:isWaarnemerVoor/tia:isVacatureWaarnemerVoor/tia:standplaats"/>
									</xsl:if>							
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:if test="tia:heeftOndertekenaar/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_ondertekenaarwaarneming'] and
						translate(tia:heeftOndertekenaar/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_ondertekenaarwaarneming']/tia:tekst, $upper, $lower) != 'vacant kantoor' and 
						translate(tia:heeftOndertekenaar/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_ondertekenaarwaarneming']/tia:tekst, $upper, $lower) != 'niet vacant kantoor' and 
						translate(tia:heeftOndertekenaar/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_ondertekenaarwaarneming']/tia:tekst, $upper, $lower) != 'geen waarneming'">
				<xsl:text>, notaris</xsl:text>
				<xsl:if test="tia:heeftOndertekenaar/tia:isWaarnemerVoor/tia:gemeente">
					<xsl:text> in de gemeente </xsl:text>
					<xsl:value-of select="tia:heeftOndertekenaar/tia:isWaarnemerVoor/tia:gemeente"/>
				</xsl:if>
				<xsl:if test="tia:heeftOndertekenaar/tia:isWaarnemerVoor/tia:gemeente and tia:heeftOndertekenaar/tia:isWaarnemerVoor/tia:standplaats">
					<xsl:text>,</xsl:text>
				</xsl:if>
				<xsl:if test="tia:heeftOndertekenaar/tia:isWaarnemerVoor/tia:standplaats">
					<xsl:text> </xsl:text>
					<xsl:choose>
						<xsl:when test="tia:heeftOndertekenaar/tia:isWaarnemerVoor/tia:gemeente">
							<xsl:text>kantoorhoudende te</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="translate(tia:heeftOndertekenaar/tia:isWaarnemerVoor/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_ondertekenaarplaatsaanduiding']/tia:tekst, $upper, $lower)"/>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:text> </xsl:text>
					<xsl:value-of select="tia:heeftOndertekenaar/tia:isWaarnemerVoor/tia:standplaats"/>
				</xsl:if>
			</xsl:if>
			<xsl:text>: </xsl:text>
		</p>
	</xsl:template>
</xsl:stylesheet>
