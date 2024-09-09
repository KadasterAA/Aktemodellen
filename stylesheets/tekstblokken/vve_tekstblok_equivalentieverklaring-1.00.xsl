<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:kef="nl.kadaster.xslt.XslExtensionFunctions" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="kef xsl" version="1.0">
	<!--
	*********************************************************
	Mode: do-statement-of-equivalence
	*********************************************************
	Public: yes

	Identity transform: no

	Description: Statement of equivalence text block.

	Input: IMKAD_AangebodenStuk

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
	<xsl:template match="*[local-name()='IMKAD_AangebodenStuk']" mode="do-statement-of-equivalence">
		<xsl:param name="punctuationMark" select="'.'"/>
		<xsl:variable name="signiture_Time_TIME" select="substring(string(tijdOndertekening), 1, 5)"/>
		<xsl:variable name="signiture_Time_STRING">
			<xsl:if test="normalize-space($signiture_Time_TIME) != ''">
				<xsl:value-of select="kef:convertTimeToText($signiture_Time_TIME)"/>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="declarerPlace" select="translate(heeftVerklaarder/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_verklaarderplaatsaanduiding']/tekst, $upper, $lower)"/>
		<xsl:variable name="verklaringomgevingswet" select="tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_verklaringomgevingswet']/tekst[translate(normalize-space(.), $upper, $lower)]"/>
		<xsl:variable name="copyOrExtract" select="tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_soortdocument']/tekst[translate(normalize-space(.), $upper, $lower)]"/>
		<xsl:variable name="pluralPiece" select="tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_meervoudstuk']/tekst[translate(normalize-space(.), $upper, $lower)]"/>
		<xsl:variable name="gemeente" select="heeftVerklaarder/gemeente"/>
		<xsl:variable name="woonplaats" select="heeftVerklaarder/standplaats"/>
		<p>
			<xsl:text>Ondergetekende, </xsl:text>
			<xsl:apply-templates select="heeftVerklaarder/persoonsgegevens" mode="do-natural-person-personal-data"/>
			<xsl:text>, </xsl:text>
			<xsl:choose>
				<xsl:when test="not(heeftVerklaarder/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_verklaarderwaarneming'])">
					<xsl:text>notaris</xsl:text>
					<xsl:if test="$gemeente">
						<xsl:text> in de gemeente </xsl:text>
						<xsl:value-of select="$gemeente"/>
					</xsl:if>
					<xsl:if test="$woonplaats">
						<xsl:if test="heeftVerklaarder/gemeente and not(heeftVerklaarder/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_komma']/tekst = 'false')">
							<xsl:text>,</xsl:text>
						</xsl:if>
						<xsl:text> </xsl:text>
						<xsl:choose>
							<xsl:when test="heeftVerklaarder/gemeente">
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
						<xsl:when test="translate(heeftVerklaarder/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_verklaarderwaarneming']/tekst, $upper, $lower) = 'waarneming'">
							<xsl:value-of select="translate(heeftVerklaarder/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_verklaarderkandidaat']/tekst, $upper, $lower)"/>
							<xsl:text> hierna te noemen: </xsl:text>
							<xsl:text>‘</xsl:text>
							<u>
								<xsl:text>notaris</xsl:text>
							</u>
							<xsl:text>’</xsl:text>
							<xsl:text>, als waarnemer van </xsl:text>
							<xsl:apply-templates select="heeftVerklaarder/isWaarnemerVoor/persoonsgegevens" mode="do-natural-person-personal-data"/>
						</xsl:when>
						<!-- vacant kantoor -->
						<xsl:when test="translate(heeftVerklaarder/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_verklaarderwaarneming']/tekst, $upper, $lower) = 'vacant kantoor'">
							<xsl:value-of select="translate(heeftVerklaarder/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_verklaarderkandidaat']/tekst, $upper, $lower)"/>
							<xsl:text> hierna te noemen: </xsl:text>
							<xsl:text>‘</xsl:text>
							<u>
								<xsl:text>notaris</xsl:text>
							</u>
							<xsl:text>’</xsl:text>
							<xsl:text>, als waarnemer </xsl:text>
							<xsl:if test="heeftVerklaarder/isWaarnemerVoor/persoonsgegevens">
								<xsl:text>van </xsl:text>
								<xsl:apply-templates select="heeftVerklaarder/isWaarnemerVoor/persoonsgegevens" mode="do-natural-person-personal-data"/>
							</xsl:if>
							<xsl:if test="heeftVerklaarder/isWaarnemerVoor">
								<xsl:if test="heeftVerklaarder/isWaarnemerVoor/gemeente or heeftVerklaarder/isWaarnemerVoor/standplaats">
									<xsl:text>, notaris</xsl:text>
								</xsl:if>
								<xsl:if test="heeftVerklaarder/isWaarnemerVoor/gemeente">
									<xsl:text> </xsl:text>
									<xsl:text>in de gemeente </xsl:text>
									<xsl:value-of select="heeftVerklaarder/isWaarnemerVoor/gemeente"/>
								</xsl:if>
								<xsl:if test="heeftVerklaarder/isWaarnemerVoor/standplaats">
									<xsl:if test="heeftVerklaarder/isWaarnemerVoor/gemeente and not(heeftVerklaarder/isWaarnemerVoor/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_komma']/tekst = 'false')">
										<xsl:text>,</xsl:text>
									</xsl:if>
									<xsl:text> </xsl:text>
									<xsl:choose>
										<xsl:when test="heeftVerklaarder/isWaarnemerVoor/gemeente">
											<xsl:text>kantoorhoudende te</xsl:text>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="translate(heeftVerklaarder/isWaarnemerVoor/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_verklaarderplaatsaanduiding']/tekst, $upper, $lower)"/>
										</xsl:otherwise>
									</xsl:choose>
									<xsl:text> </xsl:text>
									<xsl:value-of select="heeftVerklaarder/isWaarnemerVoor/standplaats"/>
								</xsl:if>
								<xsl:text>, als waarnemer</xsl:text>
							</xsl:if>
							<xsl:text> van het vacante </xsl:text>
							<xsl:value-of select="translate(heeftVerklaarder/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_verklaardervacantkantoor']/tekst, $upper, $lower)"/>
							<xsl:text> van </xsl:text>
							<xsl:choose>
								<xsl:when test="heeftVerklaarder/isVacatureWaarnemerVoor/persoonsgegevens">
									<xsl:apply-templates select="heeftVerklaarder/isVacatureWaarnemerVoor/persoonsgegevens" mode="do-natural-person-personal-data"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:apply-templates select="heeftVerklaarder/isWaarnemerVoor/isVacatureWaarnemerVoor/persoonsgegevens" mode="do-natural-person-personal-data"/>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:text>, destijds notaris</xsl:text>
							<xsl:choose>
								<xsl:when test="heeftVerklaarder/isVacatureWaarnemerVoor">
									<xsl:if test="heeftVerklaarder/isVacatureWaarnemerVoor/gemeente">
										<xsl:text> in de gemeente </xsl:text>
										<xsl:value-of select="heeftVerklaarder/isVacatureWaarnemerVoor/gemeente"/>
									</xsl:if>
									<xsl:if test="heeftVerklaarder/isVacatureWaarnemerVoor/standplaats">
										<xsl:if test="heeftVerklaarder/isVacatureWaarnemerVoor/gemeente and not(heeftVerklaarder/isVacatureWaarnemerVoor/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_komma']/tekst = 'false')">
											<xsl:text>,</xsl:text>
										</xsl:if>
										<xsl:text> </xsl:text>
										<xsl:choose>
											<xsl:when test="heeftVerklaarder/isVacatureWaarnemerVoor/gemeente">
												<xsl:text>kantoorhoudende te</xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="translate(heeftVerklaarder/isVacatureWaarnemerVoor/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_verklaarderplaatsaanduiding']/tekst, $upper, $lower)"/>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:text> </xsl:text>
										<xsl:value-of select="heeftVerklaarder/isVacatureWaarnemerVoor/standplaats"/>
									</xsl:if>
								</xsl:when>
								<xsl:otherwise>
									<xsl:if test="heeftVerklaarder/isWaarnemerVoor/isVacatureWaarnemerVoor/gemeente">
										<xsl:text> in de gemeente </xsl:text>
										<xsl:value-of select="heeftVerklaarder/isWaarnemerVoor/isVacatureWaarnemerVoor/gemeente"/>
									</xsl:if>
									<xsl:if test="heeftVerklaarder/isWaarnemerVoor/isVacatureWaarnemerVoor/standplaats">
										<xsl:if test="heeftVerklaarder/isWaarnemerVoor/isVacatureWaarnemerVoor/gemeente and not(heeftVerklaarder/isWaarnemerVoor/isVacatureWaarnemerVoor/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_komma']/tekst = 'false')">
											<xsl:text>,</xsl:text>
										</xsl:if>
										<xsl:text> </xsl:text>
										<xsl:choose>
											<xsl:when test="heeftVerklaarder/isWaarnemerVoor/isVacatureWaarnemerVoor/gemeente">
												<xsl:text>kantoorhoudende te</xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="translate(heeftVerklaarder/isWaarnemerVoor/isVacatureWaarnemerVoor/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_verklaarderplaatsaanduiding']/tekst, $upper, $lower)"/>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:text> </xsl:text>
										<xsl:value-of select="heeftVerklaarder/isWaarnemerVoor/isVacatureWaarnemerVoor/standplaats"/>
									</xsl:if>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<!-- verlof -->
						<xsl:when test="translate(heeftVerklaarder/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_verklaarderwaarneming']/tekst, $upper, $lower) = 'verlof'">
							<xsl:value-of select="translate(heeftVerklaarder/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_verklaarderkandidaat']/tekst, $upper, $lower)"/>
							<xsl:text> hierna te noemen: </xsl:text>
							<xsl:text>‘</xsl:text>
							<u>
								<xsl:text>notaris</xsl:text>
							</u>
							<xsl:text>’</xsl:text>
							<xsl:text>, als waarnemer van de met verlof afwezige </xsl:text>
							<xsl:apply-templates select="heeftVerklaarder/isWaarnemerVoor/persoonsgegevens" mode="do-natural-person-personal-data"/>
						</xsl:when>
						<!-- toegevoegd notaris -->
						<xsl:when test="translate(heeftVerklaarder/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_verklaarderwaarneming']/tekst, $upper, $lower) = 'toegevoegd notaris'">
							<xsl:text> toegevoegd notaris, bevoegd om akten te passeren in het protocol van </xsl:text>
							<xsl:apply-templates select="heeftVerklaarder/isWaarnemerVoor/persoonsgegevens" mode="do-natural-person-personal-data"/>
						</xsl:when>
						<!-- niet vacant kantoor -->
						<xsl:when test="translate(heeftVerklaarder/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_verklaarderwaarneming']/tekst, $upper, $lower) = 'niet vacant kantoor'">
							<xsl:value-of select="translate(heeftVerklaarder/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_verklaarderkandidaat']/tekst, $upper, $lower)"/>
							<xsl:text> hierna te noemen: </xsl:text>
							<xsl:text>‘</xsl:text>
							<u>
								<xsl:text>notaris</xsl:text>
							</u>
							<xsl:text>’</xsl:text>
							<xsl:text>, als waarnemer </xsl:text>
							<xsl:if test="heeftVerklaarder/isWaarnemerVoor/persoonsgegevens">
								<xsl:text>van </xsl:text>
								<xsl:apply-templates select="heeftVerklaarder/isWaarnemerVoor/persoonsgegevens" mode="do-natural-person-personal-data"/>
							</xsl:if>
							<xsl:if test="heeftVerklaarder/isWaarnemerVoor">
								<xsl:if test="heeftVerklaarder/isWaarnemerVoor/gemeente or heeftVerklaarder/isWaarnemerVoor/standplaats">
									<xsl:text>, notaris</xsl:text>
								</xsl:if>
								<xsl:if test="heeftVerklaarder/isWaarnemerVoor/gemeente">
									<xsl:text> </xsl:text>
									<xsl:text>in de gemeente </xsl:text>
									<xsl:value-of select="heeftVerklaarder/isWaarnemerVoor/gemeente"/>
								</xsl:if>
								<xsl:if test="heeftVerklaarder/isWaarnemerVoor/gemeente and heeftVerklaarder/isWaarnemerVoor/standplaats and not(heeftVerklaarder/isWaarnemerVoor/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_komma']/tekst = 'false')">
									<xsl:text>,</xsl:text>
								</xsl:if>
								<xsl:if test="heeftVerklaarder/isWaarnemerVoor/standplaats">
									<xsl:if test="heeftVerklaarder/isWaarnemerVoor/gemeente and not(heeftVerklaarder/isWaarnemerVoor/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_komma']/tekst = 'false')">
										<xsl:text>,</xsl:text>
									</xsl:if>
									<xsl:text> </xsl:text>
									<xsl:choose>
										<xsl:when test="heeftVerklaarder/isWaarnemerVoor/gemeente">
											<xsl:text>kantoorhoudende te</xsl:text>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="translate(heeftVerklaarder/isWaarnemerVoor/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_verklaarderplaatsaanduiding']/tekst, $upper, $lower)"/>
										</xsl:otherwise>
									</xsl:choose>
									<xsl:text> </xsl:text>
									<xsl:value-of select="heeftVerklaarder/isWaarnemerVoor/standplaats"/>
								</xsl:if>
								<xsl:text>, als waarnemer</xsl:text>
							</xsl:if>
							<xsl:text> van het </xsl:text>
							<xsl:value-of select="translate(heeftVerklaarder/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_verklaardervacantkantoor']/tekst, $upper, $lower)"/>
							<xsl:text> van </xsl:text>
							<xsl:choose>
								<xsl:when test="heeftVerklaarder/isVacatureWaarnemerVoor/persoonsgegevens">
									<xsl:apply-templates select="heeftVerklaarder/isVacatureWaarnemerVoor/persoonsgegevens" mode="do-natural-person-personal-data"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:apply-templates select="heeftVerklaarder/isWaarnemerVoor/isVacatureWaarnemerVoor/persoonsgegevens" mode="do-natural-person-personal-data"/>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:text>, notaris</xsl:text>
							<xsl:choose>
								<xsl:when test="heeftVerklaarder/isVacatureWaarnemerVoor">
									<xsl:if test="heeftVerklaarder/isVacatureWaarnemerVoor/gemeente">
										<xsl:text> in de gemeente </xsl:text>
										<xsl:value-of select="heeftVerklaarder/isVacatureWaarnemerVoor/gemeente"/>
									</xsl:if>
									<xsl:if test="heeftVerklaarder/isVacatureWaarnemerVoor/standplaats">
										<xsl:if test="heeftVerklaarder/isVacatureWaarnemerVoor/gemeente and not(heeftVerklaarder/isVacatureWaarnemerVoor/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_komma']/tekst = 'false')">
											<xsl:text>,</xsl:text>
										</xsl:if>
										<xsl:text> </xsl:text>
										<xsl:choose>
											<xsl:when test="heeftVerklaarder/isVacatureWaarnemerVoor/gemeente">
												<xsl:text>kantoorhoudende te</xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="translate(heeftVerklaarder/isVacatureWaarnemerVoor/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_verklaarderplaatsaanduiding']/tekst, $upper, $lower)"/>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:text> </xsl:text>
										<xsl:value-of select="heeftVerklaarder/isVacatureWaarnemerVoor/standplaats"/>
									</xsl:if>
								</xsl:when>
								<xsl:otherwise>
									<xsl:if test="heeftVerklaarder/isWaarnemerVoor/isVacatureWaarnemerVoor/gemeente">
										<xsl:text> in de gemeente </xsl:text>
										<xsl:value-of select="heeftVerklaarder/isWaarnemerVoor/isVacatureWaarnemerVoor/gemeente"/>
									</xsl:if>
									<xsl:if test="heeftVerklaarder/isWaarnemerVoor/isVacatureWaarnemerVoor/standplaats">
										<xsl:if test="heeftVerklaarder/isWaarnemerVoor/isVacatureWaarnemerVoor/gemeente and not(heeftVerklaarder/isWaarnemerVoor/isVacatureWaarnemerVoor/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_komma']/tekst = 'false')">
											<xsl:text>,</xsl:text>
										</xsl:if>
										<xsl:text> </xsl:text>
										<xsl:choose>
											<xsl:when test="heeftVerklaarder/isWaarnemerVoor/isVacatureWaarnemerVoor/gemeente">
												<xsl:text>kantoorhoudende te</xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="translate(heeftVerklaarder/isWaarnemerVoor/isVacatureWaarnemerVoor/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_verklaarderplaatsaanduiding']/tekst, $upper, $lower)"/>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:text> </xsl:text>
										<xsl:value-of select="heeftVerklaarder/isWaarnemerVoor/isVacatureWaarnemerVoor/standplaats"/>
									</xsl:if>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:if test="heeftVerklaarder/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_verklaarderwaarneming'] and
						translate(heeftVerklaarder/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_verklaarderwaarneming']/tekst, $upper, $lower) != 'vacant kantoor' and
						translate(heeftVerklaarder/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_verklaarderwaarneming']/tekst, $upper, $lower) != 'niet vacant kantoor' and
						translate(heeftVerklaarder/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_verklaarderwaarneming']/tekst, $upper, $lower) != 'geen waarneming'">
				<xsl:text>, notaris</xsl:text>
				<xsl:if test="heeftVerklaarder/isWaarnemerVoor/gemeente">
					<xsl:text> in de gemeente </xsl:text>
					<xsl:value-of select="heeftVerklaarder/isWaarnemerVoor/gemeente"/>
				</xsl:if>
				<xsl:if test="heeftVerklaarder/isWaarnemerVoor/standplaats">
					<xsl:if test="heeftVerklaarder/isWaarnemerVoor/gemeente and not(heeftVerklaarder/isWaarnemerVoor/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_komma']/tekst = 'false')">
						<xsl:text>,</xsl:text>
					</xsl:if>
					<xsl:text> </xsl:text>
					<xsl:choose>
						<xsl:when test="heeftVerklaarder/isWaarnemerVoor/gemeente">
							<xsl:text>kantoorhoudende te </xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="translate(heeftVerklaarder/isWaarnemerVoor/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_verklaarderplaatsaanduiding']/tekst, $upper, $lower)"/>
							<xsl:text> </xsl:text>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:value-of select="heeftVerklaarder/isWaarnemerVoor/standplaats"/>
				</xsl:if>
			</xsl:if>
			<xsl:text>, verklaart</xsl:text>
			<xsl:choose>
				<xsl:when test="(not(tijdOndertekening) or normalize-space(tijdOndertekening) = '') and normalize-space($verklaringomgevingswet) = ''">
					<xsl:text> dat dit afschrift </xsl:text>
					<xsl:if test="depotnummerTekening and normalize-space(depotnummerTekening) != ''">
						<xsl:text> samen met de tekening die in bewaring is genomen met depotnummer </xsl:text>
						<xsl:value-of select="depotnummerTekening"/>
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
		<xsl:if test="(tijdOndertekening and normalize-space(tijdOndertekening) != '')">
			<table cellpadding="0" cellspacing="0">
				<tbody>
					<tr>
						<td class="number" valign="top">
							<xsl:text>-</xsl:text>
						</td>
						<td>
							<xsl:text> dat dit afschrift </xsl:text>
							<xsl:if test="depotnummerTekening and normalize-space(depotnummerTekening) != ''">
								<xsl:text> samen met de tekening die in bewaring is genomen met depotnummer </xsl:text>
								<xsl:value-of select="depotnummerTekening"/>
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
								<xsl:when test="$verklaringomgevingswet != ''">
									<xsl:text>;</xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>.</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
						</td>
					</tr>
					<xsl:if test="$verklaringomgevingswet != ''">
						<tr>
							<td class="number" valign="top">
								<xsl:text>-</xsl:text>
							</td>
							<td>
								<xsl:value-of select="$verklaringomgevingswet"/>
							</td>
						</tr>
					</xsl:if>
				</tbody>
			</table>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>