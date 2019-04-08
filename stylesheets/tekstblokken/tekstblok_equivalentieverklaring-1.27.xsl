<?xml version="1.0" encoding="UTF-8"?>
<!--
*********************************************************
Stylesheet: tekstblok_equivalentieverklaring.xsl
Version: 1.26 (AA-3613)
*********************************************************
Description:
Statement of equivalence text block.

Public:
(mode) do-statement-of-equivalence

Private:
none
-->
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:tia="http://www.kadaster.nl/schemas/KIK/TIA_Algemeen" xmlns:kef="nl.kadaster.xslt.XslExtensionFunctions" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="tia kef xsl" version="1.0">
	<!--
	*********************************************************
	Mode: do-statement-of-equivalence
	*********************************************************
	Public: yes

	Identity transform: no

	Description: Statement of equivalence text block.

	Input: tia:IMKAD_AangebodenStuk

	Params: none

	Output: XHTML structure

	Calls:
	(mode) do-natural-person-personal-data

	Called by:
	(mode) do-deed
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_AangebodenStuk" mode="do-statement-of-equivalence">
		<xsl:param name="punctuationMark" select="'.'"/>
		<xsl:variable name="signiture_Time_TIME" select="substring(string(tia:tia_TijdOndertekening), 1, 5)"/>
		<xsl:variable name="signiture_Time_STRING">
			<xsl:if test="normalize-space($signiture_Time_TIME) != ''">
				<xsl:value-of select="kef:convertTimeToText($signiture_Time_TIME)"/>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="declarerPlace" select="translate(tia:heeftVerklaarder/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verklaarderplaatsaanduiding']/tia:tekst, $upper, $lower)"/>
		<xsl:variable name="verklaringWvg">
			<xsl:choose>
				<xsl:when test="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verklaringwvg']">
					<xsl:choose>
						<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verklaringwvg']/tia:tekst, $upper, $lower) = 'false'">
							<xsl:value-of select="normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verklaringwvg']/tia:tekst[1])"/>
						</xsl:when>
						<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verklaringwvg']/tia:tekst, $upper, $lower) = 'true'">
							<xsl:value-of select="normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verklaringwvg']/tia:tekst[2])"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verklaringwvg']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
								translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verklaringwvg']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
								translate(normalize-space(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verklaringwvg']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
							<xsl:text>.</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="copyOrExtract" select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_soortdocument']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_soortdocument']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_soortdocument']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
		<xsl:variable name="pluralPiece" select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoudstuk']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoudstuk']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoudstuk']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
		<xsl:variable name="gemeente" select="tia:heeftVerklaarder/tia:gemeente"/>
		<xsl:variable name="woonplaats" select="tia:heeftVerklaarder/tia:standplaats"/>
		<p>
			<xsl:text>Ondergetekende, </xsl:text>
			<xsl:apply-templates select="tia:heeftVerklaarder/tia:persoonsgegevens" mode="do-natural-person-personal-data"/>
			<xsl:text>, </xsl:text>
			<xsl:choose>
				<xsl:when test="not(tia:heeftVerklaarder/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verklaarderwaarneming'])">
					<xsl:text>notaris</xsl:text>
					<xsl:if test="$gemeente">
						<xsl:text> in de gemeente </xsl:text>
						<xsl:value-of select="$gemeente"/>
					</xsl:if>
					<xsl:if test="$woonplaats">
						<xsl:if test="tia:heeftVerklaarder/tia:gemeente">
							<xsl:text>,</xsl:text>
						</xsl:if>
						<xsl:text> </xsl:text>
						<xsl:choose>
							<xsl:when test="tia:heeftVerklaarder/tia:gemeente">
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
					<!-- Skip KEUZEBLOKVARIANT WAARNEMING when k_verklaarderwaarneming = 'geen waarneming' -->
					<xsl:choose>
						<!-- waarneming -->
						<xsl:when test="translate(tia:heeftVerklaarder/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verklaarderwaarneming']/tia:tekst, $upper, $lower) = 'waarneming'">
							<xsl:value-of select="translate(tia:heeftVerklaarder/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verklaarderkandidaat']/tia:tekst, $upper, $lower)"/>
							<xsl:text> hierna te noemen: </xsl:text>
							<xsl:text>‘</xsl:text>
							<u>
								<xsl:text>notaris</xsl:text>
							</u>
							<xsl:text>’</xsl:text>
							<xsl:text>, als waarnemer van </xsl:text>
							<xsl:apply-templates select="tia:heeftVerklaarder/tia:isWaarnemerVoor/tia:persoonsgegevens" mode="do-natural-person-personal-data"/>
						</xsl:when>
						<!-- vacant kantoor -->
						<xsl:when test="translate(tia:heeftVerklaarder/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verklaarderwaarneming']/tia:tekst, $upper, $lower) = 'vacant kantoor'">
							<xsl:value-of select="translate(tia:heeftVerklaarder/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verklaarderkandidaat']/tia:tekst, $upper, $lower)"/>
							<xsl:text> hierna te noemen: </xsl:text>
							<xsl:text>‘</xsl:text>
							<u>
								<xsl:text>notaris</xsl:text>
							</u>
							<xsl:text>’</xsl:text>
							<xsl:text>, als waarnemer </xsl:text>
							<xsl:if test="tia:heeftVerklaarder/tia:isWaarnemerVoor/tia:persoonsgegevens">
								<xsl:text>van </xsl:text>
								<xsl:apply-templates select="tia:heeftVerklaarder/tia:isWaarnemerVoor/tia:persoonsgegevens" mode="do-natural-person-personal-data"/>
							</xsl:if>
							<xsl:if test="tia:heeftVerklaarder/tia:isWaarnemerVoor">
								<xsl:if test="tia:heeftVerklaarder/tia:isWaarnemerVoor/tia:gemeente or tia:heeftVerklaarder/tia:isWaarnemerVoor/tia:standplaats">
									<xsl:text>, notaris</xsl:text>
								</xsl:if>
								<xsl:if test="tia:heeftVerklaarder/tia:isWaarnemerVoor/tia:gemeente">
									<xsl:text> </xsl:text>
									<xsl:text>in de gemeente </xsl:text>
									<xsl:value-of select="tia:heeftVerklaarder/tia:isWaarnemerVoor/tia:gemeente"/>
								</xsl:if>
								<xsl:if test="tia:heeftVerklaarder/tia:isWaarnemerVoor/tia:standplaats">
									<xsl:if test="tia:heeftVerklaarder/tia:isWaarnemerVoor/tia:gemeente">
										<xsl:text>,</xsl:text>
									</xsl:if>
									<xsl:text> </xsl:text>
									<xsl:choose>
										<xsl:when test="tia:heeftVerklaarder/tia:isWaarnemerVoor/tia:gemeente">
											<xsl:text>kantoorhoudende te</xsl:text>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="translate(tia:heeftVerklaarder/tia:isWaarnemerVoor/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verklaarderplaatsaanduiding']/tia:tekst, $upper, $lower)"/>
										</xsl:otherwise>
									</xsl:choose>
									<xsl:text> </xsl:text>
									<xsl:value-of select="tia:heeftVerklaarder/tia:isWaarnemerVoor/tia:standplaats"/>
								</xsl:if>
								<xsl:text>, als waarnemer</xsl:text>
							</xsl:if>
							<xsl:text> van het vacante </xsl:text>
							<xsl:value-of select="translate(tia:heeftVerklaarder/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verklaardervacantkantoor']/tia:tekst, $upper, $lower)"/>
							<xsl:text> van </xsl:text>
							<xsl:choose>
								<xsl:when test="tia:heeftVerklaarder/tia:isVacatureWaarnemerVoor/tia:persoonsgegevens">
									<xsl:apply-templates select="tia:heeftVerklaarder/tia:isVacatureWaarnemerVoor/tia:persoonsgegevens" mode="do-natural-person-personal-data"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:apply-templates select="tia:heeftVerklaarder/tia:isWaarnemerVoor/tia:isVacatureWaarnemerVoor/tia:persoonsgegevens" mode="do-natural-person-personal-data"/>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:text>, destijds notaris</xsl:text>
							<xsl:choose>
								<xsl:when test="tia:heeftVerklaarder/tia:isVacatureWaarnemerVoor">
									<xsl:if test="tia:heeftVerklaarder/tia:isVacatureWaarnemerVoor/tia:gemeente">
										<xsl:text> in de gemeente </xsl:text>
										<xsl:value-of select="tia:heeftVerklaarder/tia:isVacatureWaarnemerVoor/tia:gemeente"/>
									</xsl:if>
									<xsl:if test="tia:heeftVerklaarder/tia:isVacatureWaarnemerVoor/tia:standplaats">
										<xsl:if test="tia:heeftVerklaarder/tia:isVacatureWaarnemerVoor/tia:gemeente">
											<xsl:text>,</xsl:text>
										</xsl:if>
										<xsl:text> </xsl:text>
										<xsl:choose>
											<xsl:when test="tia:heeftVerklaarder/tia:isVacatureWaarnemerVoor/tia:gemeente">
												<xsl:text>kantoorhoudende te</xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="translate(tia:heeftVerklaarder/tia:isVacatureWaarnemerVoor/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verklaarderplaatsaanduiding']/tia:tekst, $upper, $lower)"/>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:text> </xsl:text>
										<xsl:value-of select="tia:heeftVerklaarder/tia:isVacatureWaarnemerVoor/tia:standplaats"/>
									</xsl:if>
								</xsl:when>
								<xsl:otherwise>
									<xsl:if test="tia:heeftVerklaarder/tia:isWaarnemerVoor/tia:isVacatureWaarnemerVoor/tia:gemeente">
										<xsl:text> in de gemeente </xsl:text>
										<xsl:value-of select="tia:heeftVerklaarder/tia:isWaarnemerVoor/tia:isVacatureWaarnemerVoor/tia:gemeente"/>
									</xsl:if>
									<xsl:if test="tia:heeftVerklaarder/tia:isWaarnemerVoor/tia:isVacatureWaarnemerVoor/tia:standplaats">
										<xsl:if test="tia:heeftVerklaarder/tia:isWaarnemerVoor/tia:isVacatureWaarnemerVoor/tia:gemeente">
											<xsl:text>,</xsl:text>
										</xsl:if>
										<xsl:text> </xsl:text>
										<xsl:choose>
											<xsl:when test="tia:heeftVerklaarder/tia:isWaarnemerVoor/tia:isVacatureWaarnemerVoor/tia:gemeente">
												<xsl:text>kantoorhoudende te</xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="translate(tia:heeftVerklaarder/tia:isWaarnemerVoor/tia:isVacatureWaarnemerVoor/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verklaarderplaatsaanduiding']/tia:tekst, $upper, $lower)"/>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:text> </xsl:text>
										<xsl:value-of select="tia:heeftVerklaarder/tia:isWaarnemerVoor/tia:isVacatureWaarnemerVoor/tia:standplaats"/>
									</xsl:if>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<!-- verlof -->
						<xsl:when test="translate(tia:heeftVerklaarder/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verklaarderwaarneming']/tia:tekst, $upper, $lower) = 'verlof'">
							<xsl:value-of select="translate(tia:heeftVerklaarder/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verklaarderkandidaat']/tia:tekst, $upper, $lower)"/>
							<xsl:text> hierna te noemen: </xsl:text>
							<xsl:text>‘</xsl:text>
							<u>
								<xsl:text>notaris</xsl:text>
							</u>
							<xsl:text>’</xsl:text>
							<xsl:text>, als waarnemer van de met verlof afwezige </xsl:text>
							<xsl:apply-templates select="tia:heeftVerklaarder/tia:isWaarnemerVoor/tia:persoonsgegevens" mode="do-natural-person-personal-data"/>
						</xsl:when>
						<!-- toegevoegd notaris -->
						<xsl:when test="translate(tia:heeftVerklaarder/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verklaarderwaarneming']/tia:tekst, $upper, $lower) = 'toegevoegd notaris'">
							<xsl:text> toegevoegd notaris, bevoegd om akten te passeren in het protocol van </xsl:text>
							<xsl:apply-templates select="tia:heeftVerklaarder/tia:isWaarnemerVoor/tia:persoonsgegevens" mode="do-natural-person-personal-data"/>
						</xsl:when>
						<!-- niet vacant kantoor -->
						<xsl:when test="translate(tia:heeftVerklaarder/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verklaarderwaarneming']/tia:tekst, $upper, $lower) = 'niet vacant kantoor'">
							<xsl:value-of select="translate(tia:heeftVerklaarder/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verklaarderkandidaat']/tia:tekst, $upper, $lower)"/>
							<xsl:text> hierna te noemen: </xsl:text>
							<xsl:text>‘</xsl:text>
							<u>
								<xsl:text>notaris</xsl:text>
							</u>
							<xsl:text>’</xsl:text>
							<xsl:text>, als waarnemer </xsl:text>
							<xsl:if test="tia:heeftVerklaarder/tia:isWaarnemerVoor/tia:persoonsgegevens">
								<xsl:text>van </xsl:text>
								<xsl:apply-templates select="tia:heeftVerklaarder/tia:isWaarnemerVoor/tia:persoonsgegevens" mode="do-natural-person-personal-data"/>
							</xsl:if>
							<xsl:if test="tia:heeftVerklaarder/tia:isWaarnemerVoor">
								<xsl:if test="tia:heeftVerklaarder/tia:isWaarnemerVoor/tia:gemeente or tia:heeftVerklaarder/tia:isWaarnemerVoor/tia:standplaats">
									<xsl:text>, notaris</xsl:text>
								</xsl:if>
								<xsl:if test="tia:heeftVerklaarder/tia:isWaarnemerVoor/tia:gemeente">
									<xsl:text> </xsl:text>
									<xsl:text>in de gemeente </xsl:text>
									<xsl:value-of select="tia:heeftVerklaarder/tia:isWaarnemerVoor/tia:gemeente"/>
								</xsl:if>
								<xsl:if test="tia:heeftVerklaarder/tia:isWaarnemerVoor/tia:gemeente and tia:heeftVerklaarder/tia:isWaarnemerVoor/tia:standplaats">
									<xsl:text>,</xsl:text>
								</xsl:if>
								<xsl:if test="tia:heeftVerklaarder/tia:isWaarnemerVoor/tia:standplaats">
									<xsl:if test="tia:heeftVerklaarder/tia:isWaarnemerVoor/tia:gemeente">
										<xsl:text>,</xsl:text>
									</xsl:if>
									<xsl:text> </xsl:text>
									<xsl:choose>
										<xsl:when test="tia:heeftVerklaarder/tia:isWaarnemerVoor/tia:gemeente">
											<xsl:text>kantoorhoudende te</xsl:text>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="translate(tia:heeftVerklaarder/tia:isWaarnemerVoor/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verklaarderplaatsaanduiding']/tia:tekst, $upper, $lower)"/>
										</xsl:otherwise>
									</xsl:choose>
									<xsl:text> </xsl:text>
									<xsl:value-of select="tia:heeftVerklaarder/tia:isWaarnemerVoor/tia:standplaats"/>
								</xsl:if>
								<xsl:text>, als waarnemer</xsl:text>
							</xsl:if>
							<xsl:text> van het </xsl:text>
							<xsl:value-of select="translate(tia:heeftVerklaarder/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verklaardervacantkantoor']/tia:tekst, $upper, $lower)"/>
							<xsl:text> van </xsl:text>
							<xsl:choose>
								<xsl:when test="tia:heeftVerklaarder/tia:isVacatureWaarnemerVoor/tia:persoonsgegevens">
									<xsl:apply-templates select="tia:heeftVerklaarder/tia:isVacatureWaarnemerVoor/tia:persoonsgegevens" mode="do-natural-person-personal-data"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:apply-templates select="tia:heeftVerklaarder/tia:isWaarnemerVoor/tia:isVacatureWaarnemerVoor/tia:persoonsgegevens" mode="do-natural-person-personal-data"/>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:text>, notaris</xsl:text>
							<xsl:choose>
								<xsl:when test="tia:heeftVerklaarder/tia:isVacatureWaarnemerVoor">
									<xsl:if test="tia:heeftVerklaarder/tia:isVacatureWaarnemerVoor/tia:gemeente">
										<xsl:text> in de gemeente </xsl:text>
										<xsl:value-of select="tia:heeftVerklaarder/tia:isVacatureWaarnemerVoor/tia:gemeente"/>
									</xsl:if>
									<xsl:if test="tia:heeftVerklaarder/tia:isVacatureWaarnemerVoor/tia:standplaats">
										<xsl:if test="tia:heeftVerklaarder/tia:isVacatureWaarnemerVoor/tia:gemeente">
											<xsl:text>,</xsl:text>
										</xsl:if>
										<xsl:text> </xsl:text>
										<xsl:choose>
											<xsl:when test="tia:heeftVerklaarder/tia:isVacatureWaarnemerVoor/tia:gemeente">
												<xsl:text>kantoorhoudende te</xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="translate(tia:heeftVerklaarder/tia:isVacatureWaarnemerVoor/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verklaarderplaatsaanduiding']/tia:tekst, $upper, $lower)"/>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:text> </xsl:text>
										<xsl:value-of select="tia:heeftVerklaarder/tia:isVacatureWaarnemerVoor/tia:standplaats"/>
									</xsl:if>
								</xsl:when>
								<xsl:otherwise>
									<xsl:if test="tia:heeftVerklaarder/tia:isWaarnemerVoor/tia:isVacatureWaarnemerVoor/tia:gemeente">
										<xsl:text> in de gemeente </xsl:text>
										<xsl:value-of select="tia:heeftVerklaarder/tia:isWaarnemerVoor/tia:isVacatureWaarnemerVoor/tia:gemeente"/>
									</xsl:if>
									<xsl:if test="tia:heeftVerklaarder/tia:isWaarnemerVoor/tia:isVacatureWaarnemerVoor/tia:standplaats">
										<xsl:if test="tia:heeftVerklaarder/tia:isWaarnemerVoor/tia:isVacatureWaarnemerVoor/tia:gemeente">
											<xsl:text>,</xsl:text>
										</xsl:if>
										<xsl:text> </xsl:text>
										<xsl:choose>
											<xsl:when test="tia:heeftVerklaarder/tia:isWaarnemerVoor/tia:isVacatureWaarnemerVoor/tia:gemeente">
												<xsl:text>kantoorhoudende te</xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="translate(tia:heeftVerklaarder/tia:isWaarnemerVoor/tia:isVacatureWaarnemerVoor/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verklaarderplaatsaanduiding']/tia:tekst, $upper, $lower)"/>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:text> </xsl:text>
										<xsl:value-of select="tia:heeftVerklaarder/tia:isWaarnemerVoor/tia:isVacatureWaarnemerVoor/tia:standplaats"/>
									</xsl:if>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:if test="tia:heeftVerklaarder/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verklaarderwaarneming'] and
						translate(tia:heeftVerklaarder/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verklaarderwaarneming']/tia:tekst, $upper, $lower) != 'vacant kantoor' and
						translate(tia:heeftVerklaarder/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verklaarderwaarneming']/tia:tekst, $upper, $lower) != 'niet vacant kantoor' and
						translate(tia:heeftVerklaarder/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verklaarderwaarneming']/tia:tekst, $upper, $lower) != 'geen waarneming'">
				<xsl:text>, notaris</xsl:text>
				<xsl:if test="tia:heeftVerklaarder/tia:isWaarnemerVoor/tia:gemeente">
					<xsl:text> in de gemeente </xsl:text>
					<xsl:value-of select="tia:heeftVerklaarder/tia:isWaarnemerVoor/tia:gemeente"/>
				</xsl:if>
				<xsl:if test="tia:heeftVerklaarder/tia:isWaarnemerVoor/tia:standplaats">
					<xsl:if test="tia:heeftVerklaarder/tia:isWaarnemerVoor/tia:gemeente">
						<xsl:text>,</xsl:text>
					</xsl:if>
					<xsl:text> </xsl:text>
					<xsl:choose>
						<xsl:when test="tia:heeftVerklaarder/tia:isWaarnemerVoor/tia:gemeente">
							<xsl:text>kantoorhoudende te </xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="translate(tia:heeftVerklaarder/tia:isWaarnemerVoor/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verklaarderplaatsaanduiding']/tia:tekst, $upper, $lower)"/>
							<xsl:text> </xsl:text>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:value-of select="tia:heeftVerklaarder/tia:isWaarnemerVoor/tia:standplaats"/>
				</xsl:if>
			</xsl:if>
			<xsl:text>, verklaart</xsl:text>
			<xsl:choose>
				<xsl:when test="(not(tia:tia_TijdOndertekening) or normalize-space(tia:tia_TijdOndertekening) = '') and normalize-space($verklaringWvg) = ''">
					<xsl:text> dat dit afschrift</xsl:text>
					<xsl:if test="tia:tia_DepotnummerTekening and normalize-space(tia:tia_DepotnummerTekening) != ''">
						<xsl:text> samen met de tekening die in bewaring is genomen met depotnummer </xsl:text>
						<xsl:value-of select="tia:tia_DepotnummerTekening"/>
					</xsl:if>
					<xsl:text> inhoudelijk een volledig en juiste weergave is van de inhoud van </xsl:text>
					<xsl:value-of select="$pluralPiece"/>
					<xsl:text> het stuk waarvan het een </xsl:text>
					<xsl:value-of select="$copyOrExtract"/>
					<xsl:text> is</xsl:text>
					<xsl:value-of select="$punctuationMark"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>:</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</p>
		<xsl:if test="(tia:tia_TijdOndertekening and normalize-space(tia:tia_TijdOndertekening) != '')">
			<table cellpadding="0" cellspacing="0">
				<tbody>
					<tr>
						<td class="number" valign="top">
							<xsl:text>-</xsl:text>
						</td>
						<td>
							<xsl:text>dat dit afschrift</xsl:text>
							<xsl:if test="tia:tia_DepotnummerTekening and normalize-space(tia:tia_DepotnummerTekening) != ''">
								<xsl:text> samen met de tekening die in bewaring is genomen met depotnummer </xsl:text>
								<xsl:value-of select="tia:tia_DepotnummerTekening"/>
							</xsl:if>
							<xsl:text> inhoudelijk een volledig en juiste weergave is van de inhoud van </xsl:text>
							<xsl:value-of select="$pluralPiece"/>
							<xsl:text> het stuk waarvan het een </xsl:text>
							<xsl:value-of select="$copyOrExtract"/>
							<xsl:text> is;</xsl:text>
						</td>
					</tr>
					<tr>
						<td class="number" valign="top">
							<xsl:text>-</xsl:text>
						</td>
						<td>
							<xsl:text>dat het stuk waarvan dit stuk een </xsl:text>
							<xsl:value-of select="$copyOrExtract"/>
							<xsl:text> is om </xsl:text>
							<xsl:value-of select="concat($signiture_Time_STRING, ' (' , $signiture_Time_TIME, ' uur) ')"/>
							<xsl:text> is ondertekend</xsl:text>
							<xsl:choose>
								<xsl:when test="$verklaringWvg != ''">
									<xsl:text>;</xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>.</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
						</td>
					</tr>
					<xsl:if test="$verklaringWvg != ''">
						<tr>
							<td class="number" valign="top">
								<xsl:text>-</xsl:text>
							</td>
							<td>
								<xsl:value-of select="$verklaringWvg"/>
							</td>
						</tr>
					</xsl:if>
				</tbody>
			</table>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
