<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:kef="nl.kadaster.xslt.XslExtensionFunctions" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="kef xsl" version="1.0">
	<xsl:template match="IMKAD_AangebodenStuk" mode="do-header">
		<xsl:variable name="Datum_DATE" select="substring(string(datumOndertekening), 0, 11)"/>
		<xsl:variable name="Datum_STRING">
			<xsl:if test="$Datum_DATE != ''">
				<xsl:value-of select="kef:convertDateToText($Datum_DATE)"/>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="indicationToday" select="tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_dagaanduiding']/tekst"/>
		<xsl:variable name="verklaring" select="heeftOndertekenaar/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_verklaring']/tekst[translate(normalize-space(.), $upper, $lower)]"/>
		<xsl:variable name="declarerPlace" select="translate(heeftOndertekenaar/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_ondertekenaarplaatsaanduiding']/tekst, $upper, $lower)"/>
		<xsl:variable name="gemeente" select="heeftOndertekenaar/gemeente"/>
		<xsl:variable name="woonplaats" select="heeftOndertekenaar/standplaats"/>
		<p>
			<xsl:value-of select="$indicationToday"/>
			<xsl:if test="translate($indicationToday, $upper, $lower) != 'op'">
				<xsl:text>,</xsl:text>
			</xsl:if>
			<xsl:text> </xsl:text>
			<xsl:value-of select="$Datum_STRING"/>
			<xsl:if test="$verklaring = 'verklaart' or $verklaring = 'verklaar ik,'">
				<xsl:text>, </xsl:text>
				<xsl:value-of select="$verklaring"/>
				<xsl:text> </xsl:text>
			</xsl:if>
			<xsl:apply-templates select="heeftOndertekenaar/persoonsgegevens" mode="do-natural-person-personal-data"/>
			<xsl:text>, </xsl:text>
			<xsl:choose>
				<xsl:when test="not(heeftOndertekenaar/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_ondertekenaarwaarneming'])">
					<xsl:text>notaris</xsl:text>
					<xsl:if test="$gemeente">
						<xsl:text> in de gemeente </xsl:text>
						<xsl:value-of select="$gemeente"/>
					</xsl:if>
					<xsl:if test="$woonplaats">
						<xsl:if test="heeftOndertekenaar/gemeente and not(heeftOndertekenaar/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_komma']/tekst = 'false')">
							<xsl:text>,</xsl:text>
						</xsl:if>
						<xsl:text> </xsl:text>
						<xsl:choose>
							<xsl:when test="heeftOndertekenaar/gemeente">
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
						<xsl:when test="translate(heeftOndertekenaar/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_ondertekenaarwaarneming']/tekst, $upper, $lower) = 'waarneming'">
							<xsl:value-of select="translate(heeftOndertekenaar/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_ondertekenaarkandidaat']/tekst, $upper, $lower)"/>
							<xsl:text> hierna te noemen: </xsl:text>
							<xsl:text>‘</xsl:text>
							<u>
								<xsl:text>notaris</xsl:text>
							</u>
							<xsl:text>’</xsl:text>
							<xsl:text>, als waarnemer van </xsl:text>
							<xsl:apply-templates select="heeftOndertekenaar/isWaarnemerVoor/persoonsgegevens" mode="do-natural-person-personal-data"/>
						</xsl:when>
						<!-- vacant kantoor -->
						<xsl:when test="translate(heeftOndertekenaar/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_ondertekenaarwaarneming']/tekst, $upper, $lower) = 'vacant kantoor'">
							<xsl:value-of select="translate(heeftOndertekenaar/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_ondertekenaarkandidaat']/tekst, $upper, $lower)"/>
							<xsl:text> hierna te noemen: </xsl:text>
							<xsl:text>‘</xsl:text>
							<u>
								<xsl:text>notaris</xsl:text>
							</u>
							<xsl:text>’</xsl:text>
							<xsl:text>, als waarnemer </xsl:text>
							<xsl:if test="heeftOndertekenaar/isWaarnemerVoor/persoonsgegevens">
								<xsl:text>van </xsl:text>
								<xsl:apply-templates select="heeftOndertekenaar/isWaarnemerVoor/persoonsgegevens" mode="do-natural-person-personal-data"/>
							</xsl:if>
							<xsl:if test="heeftOndertekenaar/isWaarnemerVoor">
								<xsl:if test="heeftOndertekenaar/isWaarnemerVoor/gemeente or heeftOndertekenaar/isWaarnemerVoor/standplaats">
									<xsl:text>, notaris</xsl:text>
								</xsl:if>
								<xsl:if test="heeftOndertekenaar/isWaarnemerVoor/gemeente">
									<xsl:text> in de gemeente </xsl:text>
									<xsl:value-of select="heeftOndertekenaar/isWaarnemerVoor/gemeente"/>
								</xsl:if>
								<xsl:if test="heeftOndertekenaar/isWaarnemerVoor/standplaats">
									<xsl:if test="heeftOndertekenaar/isWaarnemerVoor/gemeente and not(heeftOndertekenaar/isWaarnemerVoor/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_komma']/tekst = 'false')">
										<xsl:text>,</xsl:text>
									</xsl:if>
									<xsl:text> </xsl:text>
									<xsl:choose>
										<xsl:when test="heeftOndertekenaar/isWaarnemerVoor/gemeente">
											<xsl:text>kantoorhoudende te</xsl:text>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="translate(heeftOndertekenaar/isWaarnemerVoor/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_ondertekenaarplaatsaanduiding']/tekst, $upper, $lower)"/>
										</xsl:otherwise>
									</xsl:choose>
									<xsl:text> </xsl:text>
									<xsl:value-of select="heeftOndertekenaar/isWaarnemerVoor/standplaats"/>
								</xsl:if>
								<xsl:text>, als waarnemer</xsl:text>
							</xsl:if>
							<xsl:text> van het vacante </xsl:text>
							<xsl:value-of select="translate(heeftOndertekenaar/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_ondertekenaarvacantkantoor']/tekst, $upper, $lower)"/>
							<xsl:text> van </xsl:text>
							<xsl:choose>
								<xsl:when test="heeftOndertekenaar/isVacatureWaarnemerVoor/persoonsgegevens">
									<xsl:apply-templates select="heeftOndertekenaar/isVacatureWaarnemerVoor/persoonsgegevens" mode="do-natural-person-personal-data"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:apply-templates select="heeftOndertekenaar/isWaarnemerVoor/isVacatureWaarnemerVoor/persoonsgegevens" mode="do-natural-person-personal-data"/>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:text>, destijds notaris</xsl:text>
							<xsl:choose>
								<xsl:when test="heeftOndertekenaar/isVacatureWaarnemerVoor">
									<xsl:if test="heeftOndertekenaar/isVacatureWaarnemerVoor/gemeente">
										<xsl:text> in de gemeente </xsl:text>
										<xsl:value-of select="heeftOndertekenaar/isVacatureWaarnemerVoor/gemeente"/>
									</xsl:if>
									<xsl:if test="heeftOndertekenaar/isVacatureWaarnemerVoor/standplaats">
										<xsl:if test="heeftOndertekenaar/isVacatureWaarnemerVoor/gemeente and not(heeftOndertekenaar/isVacatureWaarnemerVoor/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_komma']/tekst = 'false')">
											<xsl:text>,</xsl:text>
										</xsl:if>
										<xsl:text> </xsl:text>
										<xsl:choose>
											<xsl:when test="heeftOndertekenaar/isVacatureWaarnemerVoor/gemeente">
												<xsl:text>kantoorhoudende te</xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="translate(heeftOndertekenaar/isVacatureWaarnemerVoor/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_ondertekenaarplaatsaanduiding']/tekst, $upper, $lower)"/>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:text> </xsl:text>
										<xsl:value-of select="heeftOndertekenaar/isVacatureWaarnemerVoor/standplaats"/>
									</xsl:if>
								</xsl:when>
								<xsl:otherwise>
									<xsl:if test="heeftOndertekenaar/isWaarnemerVoor/isVacatureWaarnemerVoor/gemeente">
										<xsl:text> in de gemeente </xsl:text>
										<xsl:value-of select="heeftOndertekenaar/isWaarnemerVoor/isVacatureWaarnemerVoor/gemeente"/>
									</xsl:if>
									<xsl:if test="heeftOndertekenaar/isWaarnemerVoor/isVacatureWaarnemerVoor/standplaats">
										<xsl:if test="heeftOndertekenaar/isWaarnemerVoor/isVacatureWaarnemerVoor/gemeente and not(heeftOndertekenaar/isWaarnemerVoor/isVacatureWaarnemerVoor/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_komma']/tekst = 'false')">
											<xsl:text>,</xsl:text>
										</xsl:if>
										<xsl:text> </xsl:text>
										<xsl:choose>
											<xsl:when test="heeftOndertekenaar/isWaarnemerVoor/isVacatureWaarnemerVoor/gemeente">
												<xsl:text>kantoorhoudende te</xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="translate(heeftOndertekenaar/isWaarnemerVoor/isVacatureWaarnemerVoor/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_ondertekenaarplaatsaanduiding']/tekst, $upper, $lower)"/>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:text> </xsl:text>
										<xsl:value-of select="heeftOndertekenaar/isWaarnemerVoor/isVacatureWaarnemerVoor/standplaats"/>
									</xsl:if>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<!-- verlof -->
						<xsl:when test="translate(heeftOndertekenaar/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_ondertekenaarwaarneming']/tekst, $upper, $lower) = 'verlof'">
							<xsl:value-of select="translate(heeftOndertekenaar/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_ondertekenaarkandidaat']/tekst, $upper, $lower)"/>
							<xsl:text> hierna te noemen: </xsl:text>
							<xsl:text>‘</xsl:text>
							<u>
								<xsl:text>notaris</xsl:text>
							</u>
							<xsl:text>’</xsl:text>
							<xsl:text>, als waarnemer van de met verlof afwezige </xsl:text>
							<xsl:apply-templates select="heeftOndertekenaar/isWaarnemerVoor/persoonsgegevens" mode="do-natural-person-personal-data"/>
						</xsl:when>
						<!-- toegevoegd notaris -->
						<xsl:when test="translate(heeftOndertekenaar/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_ondertekenaarwaarneming']/tekst, $upper, $lower) = 'toegevoegd notaris'">
							<xsl:text>toegevoegd notaris, bevoegd om akten te passeren in het protocol van  </xsl:text>
							<xsl:apply-templates select="heeftOndertekenaar/isWaarnemerVoor/persoonsgegevens" mode="do-natural-person-personal-data"/>
						</xsl:when>
						<!-- waarneming kantoor/protocol -->
						<xsl:when test="translate(heeftOndertekenaar/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_ondertekenaarwaarneming']/tekst, $upper, $lower) = 'niet vacant kantoor'">
							<xsl:value-of select="translate(heeftOndertekenaar/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_ondertekenaarkandidaat']/tekst, $upper, $lower)"/>
							<xsl:text> hierna te noemen: </xsl:text>
							<xsl:text>‘</xsl:text>
							<u>
								<xsl:text>notaris</xsl:text>
							</u>
							<xsl:text>’</xsl:text>
							<xsl:text>, als waarnemer </xsl:text>
							<xsl:if test="heeftOndertekenaar/isWaarnemerVoor/persoonsgegevens">
								<xsl:text>van </xsl:text>
								<xsl:apply-templates select="heeftOndertekenaar/isWaarnemerVoor/persoonsgegevens" mode="do-natural-person-personal-data"/>
							</xsl:if>
							<xsl:if test="heeftOndertekenaar/isWaarnemerVoor">
								<xsl:if test="heeftOndertekenaar/isWaarnemerVoor/gemeente or heeftOndertekenaar/isWaarnemerVoor/standplaats">
									<xsl:text>, notaris</xsl:text>
								</xsl:if>
								<xsl:if test="heeftOndertekenaar/isWaarnemerVoor/gemeente">
									<xsl:text> in de gemeente </xsl:text>
									<xsl:value-of select="heeftOndertekenaar/isWaarnemerVoor/gemeente"/>
								</xsl:if>
								<xsl:if test="heeftOndertekenaar/isWaarnemerVoor/standplaats">
									<xsl:if test="heeftOndertekenaar/isWaarnemerVoor/gemeente and not(heeftOndertekenaar/isWaarnemerVoor/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_komma']/tekst = 'false')">
										<xsl:text>,</xsl:text>
									</xsl:if>
									<xsl:text> </xsl:text>
									<xsl:choose>
										<xsl:when test="heeftOndertekenaar/isWaarnemerVoor/gemeente">
											<xsl:text>kantoorhoudende te</xsl:text>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="translate(heeftOndertekenaar/isWaarnemerVoor/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_ondertekenaarplaatsaanduiding']/tekst, $upper, $lower)"/>
										</xsl:otherwise>
									</xsl:choose>
									<xsl:text> </xsl:text>
									<xsl:value-of select="heeftOndertekenaar/isWaarnemerVoor/standplaats"/>
								</xsl:if>
								<xsl:text>, als waarnemer</xsl:text>
							</xsl:if>
							<xsl:text> van het </xsl:text>
							<xsl:value-of select="translate(heeftOndertekenaar/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_ondertekenaarvacantkantoor']/tekst, $upper, $lower)"/>
							<xsl:text> van </xsl:text>
							<xsl:choose>
								<xsl:when test="heeftOndertekenaar/isVacatureWaarnemerVoor/persoonsgegevens">
									<xsl:apply-templates select="heeftOndertekenaar/isVacatureWaarnemerVoor/persoonsgegevens" mode="do-natural-person-personal-data"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:apply-templates select="heeftOndertekenaar/isWaarnemerVoor/isVacatureWaarnemerVoor/persoonsgegevens" mode="do-natural-person-personal-data"/>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:text>, notaris</xsl:text>
							<xsl:choose>
								<xsl:when test="heeftOndertekenaar/isVacatureWaarnemerVoor">
									<xsl:if test="heeftOndertekenaar/isVacatureWaarnemerVoor/gemeente">
										<xsl:text> in de gemeente </xsl:text>
										<xsl:value-of select="heeftOndertekenaar/isVacatureWaarnemerVoor/gemeente"/>
									</xsl:if>
									<xsl:if test="heeftOndertekenaar/isVacatureWaarnemerVoor/standplaats">
										<xsl:if test="heeftOndertekenaar/isVacatureWaarnemerVoor/gemeente and not(heeftOndertekenaar/isVacatureWaarnemerVoor/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_komma']/tekst = 'false')">
											<xsl:text>,</xsl:text>
										</xsl:if>
										<xsl:text> </xsl:text>
										<xsl:choose>
											<xsl:when test="heeftOndertekenaar/isVacatureWaarnemerVoor/gemeente">
												<xsl:text>kantoorhoudende te</xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="translate(heeftOndertekenaar/isVacatureWaarnemerVoor/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_ondertekenaarplaatsaanduiding']/tekst, $upper, $lower)"/>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:text> </xsl:text>
										<xsl:value-of select="heeftOndertekenaar/isVacatureWaarnemerVoor/standplaats"/>
									</xsl:if>
								</xsl:when>
								<xsl:otherwise>
									<xsl:if test="heeftOndertekenaar/isWaarnemerVoor/isVacatureWaarnemerVoor/gemeente">
										<xsl:text> in de gemeente </xsl:text>
										<xsl:value-of select="heeftOndertekenaar/isWaarnemerVoor/isVacatureWaarnemerVoor/gemeente"/>
									</xsl:if>
									<xsl:if test="heeftOndertekenaar/isWaarnemerVoor/isVacatureWaarnemerVoor/standplaats">
										<xsl:if test="heeftOndertekenaar/isWaarnemerVoor/isVacatureWaarnemerVoor/gemeente and not(heeftOndertekenaar/isWaarnemerVoor/isVacatureWaarnemerVoor/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_komma']/tekst = 'false')">
											<xsl:text>,</xsl:text>
										</xsl:if>
										<xsl:text> </xsl:text>
										<xsl:choose>
											<xsl:when test="heeftOndertekenaar/isWaarnemerVoor/isVacatureWaarnemerVoor/gemeente">
												<xsl:text>kantoorhoudende te</xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="translate(heeftOndertekenaar/isWaarnemerVoor/isVacatureWaarnemerVoor/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_ondertekenaarplaatsaanduiding']/tekst, $upper, $lower)"/>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:text> </xsl:text>
										<xsl:value-of select="heeftOndertekenaar/isWaarnemerVoor/isVacatureWaarnemerVoor/standplaats"/>
									</xsl:if>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:if test="heeftOndertekenaar/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_ondertekenaarwaarneming'] and
						translate(heeftOndertekenaar/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_ondertekenaarwaarneming']/tekst, $upper, $lower) != 'vacant kantoor' and
						translate(heeftOndertekenaar/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_ondertekenaarwaarneming']/tekst, $upper, $lower) != 'niet vacant kantoor'">
				<xsl:text>, notaris</xsl:text>
				<xsl:if test="heeftOndertekenaar/isWaarnemerVoor/gemeente">
					<xsl:text> in de gemeente </xsl:text>
					<xsl:value-of select="heeftOndertekenaar/isWaarnemerVoor/gemeente"/>
				</xsl:if>
				<xsl:if test="heeftOndertekenaar/isWaarnemerVoor/gemeente and heeftOndertekenaar/isWaarnemerVoor/standplaats  and not(heeftOndertekenaar/isWaarnemerVoor/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_komma']/tekst = 'false')">
					<xsl:text>,</xsl:text>
				</xsl:if>
				<xsl:if test="heeftOndertekenaar/isWaarnemerVoor/standplaats">
					<xsl:text> </xsl:text>
					<xsl:choose>
						<xsl:when test="heeftOndertekenaar/isWaarnemerVoor/gemeente">
							<xsl:text>kantoorhoudende te</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="translate(heeftOndertekenaar/isWaarnemerVoor/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_ondertekenaarplaatsaanduiding']/tekst, $upper, $lower)"/>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:text> </xsl:text>
					<xsl:value-of select="heeftOndertekenaar/isWaarnemerVoor/standplaats"/>
				</xsl:if>
			</xsl:if>
			<xsl:if test="translate(heeftOndertekenaar/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_overtuigd']/tekst, $upper, $lower) = 'true'">
				<xsl:text>, dat ik mij zoveel mogelijk heb overtuigd van het volgende</xsl:text>
			</xsl:if>
			<xsl:text>:</xsl:text>
		</p>
	</xsl:template>
</xsl:stylesheet>