<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exslt="http://exslt.org/common" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:kef="nl.kadaster.xslt.XslExtensionFunctions" exclude-result-prefixes="xsl exslt xlink kef" version="1.0">
	<xsl:template match="testamentUitersteWilsbeschikking">
		<xsl:variable name="variant" select="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_variant']/tekst, $upper, $lower)"/>
		<xsl:variable name="Datum" select="substring(string(datum), 0, 11)"/>
		<xsl:variable name="DatumString">
			<xsl:if test="$Datum != ''">
				<xsl:value-of select="kef:convertDateToText($Datum)"/>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="DatumAanvullend" select="substring(string(aanvullend/datum), 0, 11)"/>
		<xsl:variable name="DatumAanvullendString">
			<xsl:if test="$DatumAanvullend != ''">
				<xsl:value-of select="kef:convertDateToText($DatumAanvullend)"/>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="notarisRef" select="notarisRef/@xlink:href"/>
		<xsl:variable name="notaris" select="$opsommingPersonen/IMKAD_Persoon[@id = substring-after($notarisRef,'#')]"/>
		<xsl:variable name="aanvullendNotarisRef" select="aanvullend/notarisRef/@xlink:href"/>
		<xsl:variable name="aanvullendNotaris" select="$opsommingPersonen/IMKAD_Persoon[@id = substring-after($aanvullendNotarisRef,'#')]"/>
		<h3 class="header">
			<u>
				<xsl:value-of select="translate($benamingTestament,$lower, $upper)"/>
			</u>
		</h3>
		<xsl:choose>
			<xsl:when test="$variant = 'a'">
				<p>
					<xsl:text>De </xsl:text>
					<xsl:value-of select="$overledeneAanduiding"/>
					<xsl:text> heeft, </xsl:text>
					<xsl:value-of select="$blijkens_low"/>
					<xsl:text> een </xsl:text>
					<xsl:if test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_aangehecht']/tekst, $upper, $lower) = 'true'">
						<xsl:text>aan deze akte gehechte </xsl:text>
					</xsl:if>
					<xsl:text>opgave van het Centraal Testamentenregister</xsl:text>
					<xsl:if test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_plaatstestamentregister']/tekst, $upper, $lower) = 'true'">
						<xsl:text> te ’s-Gravenhage</xsl:text>
					</xsl:if>
					<xsl:text>, niet bij </xsl:text>
					<xsl:value-of select="$benamingTestament"/>
					<xsl:text> over </xsl:text>
					<xsl:value-of select="$zijnHaar"/>
					<xsl:text> nalatenschap beschikt.</xsl:text>
					<xsl:if test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_codicil']/tekst, $upper, $lower) = 'true'">
						<xsl:text> Van het bestaan van een codicil is mij, notaris, evenmin gebleken.</xsl:text>
					</xsl:if>
				</p>
			</xsl:when>
			<xsl:when test="$variant = 'b'">
				<p>
					<xsl:text>De </xsl:text>
					<xsl:value-of select="$overledeneAanduiding"/>
					<xsl:text> heeft, </xsl:text>
					<xsl:value-of select="$blijkens_low"/>
					<xsl:text> een </xsl:text>
					<xsl:if test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_aangehecht']/tekst, $upper, $lower) = 'true'">
						<xsl:text>aan deze akte gehechte </xsl:text>
					</xsl:if>
					<xsl:text>opgave van het Centraal Testamentenregister</xsl:text>
					<xsl:if test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_plaatstestamentregister']/tekst, $upper, $lower) = 'true'">
						<xsl:text> te ’s-Gravenhage</xsl:text>
					</xsl:if>
					<xsl:text>, </xsl:text>
					<xsl:value-of select="$zijnHaar"/>
					<xsl:text> laatste </xsl:text>
					<xsl:value-of select="$benamingTestament"/>
					<xsl:text> gemaakt bij akte op </xsl:text>
					<xsl:value-of select="$DatumString"/>
					<xsl:text> verleden voor </xsl:text>
					<xsl:call-template name="tb-NatuurlijkPersoon">
						<xsl:with-param name="partner" select="$notaris"/>
						<xsl:with-param name="toonWoonplaats" select="false"/>
					</xsl:call-template>
					<xsl:if test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_destijds']/tekst, $upper, $lower) = 'true'">
						<xsl:text>, destijds</xsl:text>
					</xsl:if>
					<xsl:choose>
						<xsl:when test="standplaats != ''">
							<xsl:text> notaris te </xsl:text>
							<xsl:value-of select="standplaats"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text> mij, notaris</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:if test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_herroepen']/tekst, $upper, $lower) = 'true'">
						<xsl:text>, en daarbij alle eerdere uiterste wilsbeschikkingen herroepen, behalve die eventueel bij codicil zijn gemaakt</xsl:text>
					</xsl:if>
					<xsl:text>.</xsl:text>
					<xsl:if test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_codicil']/tekst, $upper, $lower) = 'true'">
						<xsl:text> Van het bestaan van een codicil is mij, notaris, niet gebleken.</xsl:text>
					</xsl:if>
				</p>
				<p>
					<xsl:text>Gemeld</xsl:text>
					<xsl:if test="$benamingTestament = 'uiterste wilsbeschikking'">
						<xsl:text>e</xsl:text>
					</xsl:if>
					<xsl:text> </xsl:text>
					<xsl:value-of select="$benamingTestament"/>
					<xsl:if test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_aangehecht']/tekst, $upper, $lower) = 'true'">
						<xsl:text>, waarvan een kopie aan deze akte is gehecht</xsl:text>
					</xsl:if>
					<xsl:text>, is door het overlijden van de </xsl:text>
					<xsl:value-of select="$overledeneAanduiding"/>
					<xsl:text> van kracht geworden.</xsl:text>
				</p>
				<p>
					<xsl:value-of select="$blijkens_up"/>
					<xsl:text> gemeld testament is de </xsl:text>
					<xsl:value-of select="$overledeneAanduiding"/>
					<xsl:text> niet afgeweken van na te melden wettelijke verdeling en heeft voorts </xsl:text>
					<xsl:choose>
						<xsl:when test="tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_erfstelling']/tekst = '1'">
							<xsl:text>geen van de wet afwijkende erfstelling gemaakt, met dien verstande dat de </xsl:text>
							<xsl:value-of select="$overledeneAanduiding"/>
							<xsl:text> de wilsrechten als bedoeld in de artikelen 4:19, 4:20 en 4:21 van het Burgerlijk Wetboek heeft uitgesloten</xsl:text>
							<xsl:text>.</xsl:text>
						</xsl:when>
						<xsl:when test="tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_erfstelling']/tekst = '2'">
							<xsl:text>geen van de wet afwijkende erfstelling gemaakt.</xsl:text>
						</xsl:when>
						<xsl:when test="tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_erfstelling']/tekst = '3'">
							<xsl:text>een van de wet afwijkende erfstelling gemaakt, zoals hierna onder Erfgenamen nader is uitgewerkt.</xsl:text>
						</xsl:when>
					</xsl:choose>
				</p>
			</xsl:when>
			<xsl:when test="$variant = 'c'">
				<p>
					<xsl:text>Volgens opgave van het Nederlandse Centraal Testamentenregister </xsl:text>
					<xsl:if test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_plaatstestamentregister']/tekst, $upper, $lower) = 'true'">
						<xsl:text> te ’s-Gravenhage </xsl:text>
					</xsl:if>
					<xsl:text>heeft de </xsl:text>
					<xsl:value-of select="$overledeneAanduiding"/>
					<xsl:text> voor het laatst over </xsl:text>
					<xsl:value-of select="$zijnHaar"/>
					<xsl:text> nalatenschap beschikt bij </xsl:text>
					<xsl:value-of select="$benamingTestament"/>
					<xsl:text> op </xsl:text>
					<xsl:value-of select="$DatumString"/>
					<xsl:text> verleden voor </xsl:text>
					<xsl:choose>
						<xsl:when test="$notaris != ''">
							<xsl:call-template name="tb-NatuurlijkPersoon">
								<xsl:with-param name="partner" select="$notaris"/>
								<xsl:with-param name="toonWoonplaats" select="false"/>
							</xsl:call-template>
							<xsl:if test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_destijds']/tekst, $upper, $lower) = 'true'">
								<xsl:text>, destijds</xsl:text>
							</xsl:if>
							<xsl:text> notaris te </xsl:text>
							<xsl:value-of select="standplaats"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>mij, notaris</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:text>, onder gedeeltelijke gestanddoening van </xsl:text>
					<xsl:value-of select="$zijnHaar"/>
					<xsl:text> testament op </xsl:text>
					<xsl:value-of select="$DatumAanvullendString"/>
					<xsl:text> verleden voor </xsl:text>
					<xsl:choose>
						<xsl:when test="$aanvullendNotaris != ''">
							<xsl:call-template name="tb-NatuurlijkPersoon">
								<xsl:with-param name="partner" select="$aanvullendNotaris"/>
								<xsl:with-param name="toonWoonplaats" select="false"/>
							</xsl:call-template>
							<xsl:if test="translate(aanvullend/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_destijds']/tekst, $upper, $lower) = 'true'">
								<xsl:text>, destijds</xsl:text>
							</xsl:if>
							<xsl:text> notaris te </xsl:text>
							<xsl:value-of select="aanvullend/standplaats"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="aanvullend/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_notaris']/tekst"/>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:text>.</xsl:text>
				</p>
				<p>
					<xsl:text>In laatstgemeld testament heeft de overledene alle voorgaande uiterste wilsbeschikkingen herroepen.</xsl:text>
				</p>
				<xsl:if test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_codicil']/tekst, $upper, $lower) = 'true'">
					<p>
						<xsl:text> Van het bestaan van een codicil is mij, notaris, niet gebleken.</xsl:text>
					</p>
				</xsl:if>
			</xsl:when>
			<xsl:when test="$variant = 'd'">
				<p>
					<xsl:text>De </xsl:text>
					<xsl:value-of select="$overledeneAanduiding"/>
					<xsl:text> heeft, volgens opgave van het Centraal Testamenten Register</xsl:text>
					<xsl:if test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_plaatstestamentregister']/tekst, $upper, $lower) = 'true'">
						<xsl:text> te ’s-Gravenhage</xsl:text>
					</xsl:if>
					<xsl:text>, over </xsl:text>
					<xsl:value-of select="$zijnHaar"/>
					<xsl:text> nalatenschap beschikt bij </xsl:text>
					<xsl:value-of select="$benamingTestament"/>
					<xsl:text>, op </xsl:text>
					<xsl:value-of select="$DatumString"/>
					<xsl:text> verleden voor </xsl:text>
					<xsl:choose>
						<xsl:when test="standplaats != ''">
								<xsl:call-template name="tb-NatuurlijkPersoon">
								<xsl:with-param name="partner" select="$notaris"/>
								<xsl:with-param name="toonWoonplaats" select="false"/>
							</xsl:call-template>
							<xsl:if test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_destijds']/tekst, $upper, $lower) = 'true'">
								<xsl:text>, destijds</xsl:text>
							</xsl:if>
							<xsl:text> notaris te </xsl:text>
							<xsl:value-of select="standplaats"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text> mij, notaris</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:text>.</xsl:text>
				</p>
				<p>
					<xsl:text>Vervolgens heeft de </xsl:text>
					<xsl:value-of select="$overledeneAanduiding"/>
					<xsl:text>, volgens opgave van het Centraal Testamenten Register</xsl:text>
					<xsl:if test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_plaatstestamentregister']/tekst, $upper, $lower) = 'true'">
						<xsl:text> te ’s-Gravenhage</xsl:text>
					</xsl:if>
					<xsl:text>, bij aanvullend </xsl:text>
					<xsl:value-of select="$benamingTestament"/>
					<xsl:text> over </xsl:text>
					<xsl:value-of select="$zijnHaar"/>
					<xsl:text> nalatenschap beschikt, te weten op </xsl:text>
					<xsl:value-of select="$DatumAanvullendString"/>
					<xsl:text> voor </xsl:text>
					<xsl:choose>
						<xsl:when test="aanvullend/standplaats != ''">
							<xsl:call-template name="tb-NatuurlijkPersoon">
								<xsl:with-param name="partner" select="$aanvullendNotaris"/>
								<xsl:with-param name="toonWoonplaats" select="false"/>
							</xsl:call-template>
							<xsl:if test="translate(aanvullend/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_destijds']/tekst, $upper, $lower) = 'true'">
								<xsl:text>, destijds</xsl:text>
							</xsl:if>
							<xsl:text> notaris te </xsl:text>
							<xsl:value-of select="aanvullend/standplaats"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="aanvullend/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_notaris']/tekst"/>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:text>.</xsl:text>
					<xsl:if test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_codicil']/tekst, $upper, $lower) = 'true'">
						<xsl:text> Van het bestaan van een codicil is mij, notaris, niet gebleken.</xsl:text>
					</xsl:if>
				</p>
			</xsl:when>
			<xsl:when test="$variant = 'e'">
				<p>
					<xsl:text>De </xsl:text>
					<xsl:value-of select="$overledeneAanduiding"/>
					<xsl:text> heeft, volgens opgave van het Centraal Testamenten Register</xsl:text>
					<xsl:if test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_plaatstestamentregister']/tekst, $upper, $lower) = 'true'">
						<xsl:text> te ’s-Gravenhage</xsl:text>
					</xsl:if>
					<xsl:text>, over </xsl:text>
					<xsl:value-of select="$zijnHaar"/>
					<xsl:text> nalatenschap beschikt bij </xsl:text>
					<xsl:value-of select="$benamingTestament"/>
					<xsl:text>, op </xsl:text>
					<xsl:value-of select="$DatumString"/>
					<xsl:text> verleden voor </xsl:text>
					<xsl:call-template name="tb-NatuurlijkPersoon">
						<xsl:with-param name="partner" select="$notaris"/>
						<xsl:with-param name="toonWoonplaats" select="false"/>
					</xsl:call-template>
					<xsl:if test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_destijds']/tekst, $upper, $lower) = 'true'">
						<xsl:text>, destijds</xsl:text>
					</xsl:if>
					<xsl:choose>
						<xsl:when test="standplaats != ''">
							<xsl:text> notaris te </xsl:text>
							<xsl:value-of select="standplaats"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text> mij, notaris</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:text>, welk </xsl:text>
					<xsl:value-of select="$benamingTestament"/>
					<xsl:text> onder meer een wettelijke verdeling bevat.</xsl:text>
				</p>
				<p>
					<xsl:text>Vervolgens heeft de </xsl:text>
					<xsl:value-of select="$overledeneAanduiding"/>
					<xsl:text>, volgens opgave van het Centraal Testamenten Register</xsl:text>
					<xsl:if test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_plaatstestamentregister']/tekst, $upper, $lower) = 'true'">
						<xsl:text> te ’s-Gravenhage</xsl:text>
					</xsl:if>
					<xsl:text>, nog </xsl:text>
					<xsl:value-of select="kef:convertNumberToText(aanvullend/aantal)"/>
					<xsl:text> maal bij aanvullend </xsl:text>
					<xsl:value-of select="$benamingTestament"/>
					<xsl:text> over </xsl:text>
					<xsl:value-of select="$zijnHaar"/>
					<xsl:text> nalatenschap beschikt, te weten op </xsl:text>
					<xsl:value-of select="$DatumAanvullendString"/>
					<xsl:text> voor </xsl:text>
					<xsl:call-template name="tb-NatuurlijkPersoon">
						<xsl:with-param name="partner" select="$aanvullendNotaris"/>
						<xsl:with-param name="toonWoonplaats" select="false"/>
					</xsl:call-template>
					<xsl:if test="translate(aanvullend/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_destijds']/tekst, $upper, $lower) = 'true'">
						<xsl:text>, destijds</xsl:text>
					</xsl:if>
					<xsl:choose>
						<xsl:when test="aanvullend/standplaats != ''">
							<xsl:text> notaris te </xsl:text>
							<xsl:value-of select="aanvullend/standplaats"/>
						</xsl:when>
						<xsl:when test="translate(aanvullend/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_notaris']/tekst, $upper, $lower) != ''">
							<xsl:value-of select="translate(aanvullend/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_notaris']/tekst, $upper, $lower) != ''"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text> mij, notaris</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:text>.</xsl:text>
					<xsl:if test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_codicil']/tekst, $upper, $lower) = 'true'">
						<xsl:text> Van het bestaan van een codicil is mij, notaris, niet gebleken.</xsl:text>
					</xsl:if>
				</p>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>