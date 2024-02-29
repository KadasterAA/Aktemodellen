<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exslt="http://exslt.org/common" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:kef="nl.kadaster.xslt.XslExtensionFunctions" exclude-result-prefixes="xsl exslt xlink kef" version="1.0">
	<xsl:template match="aanvaarding">
		<xsl:variable name="variant" select="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_variant']/tekst, $upper, $lower)"/>
		<h3 class="header">
			<u>
				<xsl:choose>
					<xsl:when test="$variant = 'a' or $variant = 'b'">
						<xsl:text>ZUIVERE AANVAARDING</xsl:text>
					</xsl:when>
					<xsl:when test="$variant = 'c' or $variant = 'd' or $variant = 'e' or $variant = 'f'">
						<xsl:text>BENEFICIAIRE AANVAARDING</xsl:text>
					</xsl:when>
				</xsl:choose>
			</u>
		</h3>
		<xsl:choose>
			<xsl:when test="$variant = 'a'">
				<p>
					<xsl:value-of select="$blijkens_up"/>
					<xsl:text> de </xsl:text>
					<xsl:if test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_aktegehecht']/tekst,$upper,$lower) = 'true'">
						<xsl:text>aan deze akte gehechte  </xsl:text>
					</xsl:if>
					<xsl:text> verklaringen hebben </xsl:text>
					<xsl:if test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_voornoemd']/tekst,$upper,$lower) = 'true'">
						<xsl:text>voornoemde </xsl:text>
					</xsl:if>
					<xsl:value-of select="tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_partner']/tekst"/>
					<xsl:text> en </xsl:text>
					<xsl:value-of select="$zijnHaar"/>
					<xsl:text> hiervoor </xsl:text>
					<xsl:if test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_kopjeerfgenamen']/tekst,$upper,$lower) = 'true'">
						<xsl:text> onder ERFGENAMEN </xsl:text>
					</xsl:if>
					<xsl:text> genoemde </xsl:text>
					<xsl:value-of select="tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_erfgenamen']/tekst"/>
					<xsl:text> de nalatenschap zuiver aanvaard.</xsl:text>
				</p>
			</xsl:when>
			<xsl:when test="$variant = 'b'">
				<p>
					<xsl:text>De nalatenschap van de </xsl:text>
					<xsl:value-of select="$overledeneAanduiding"/>
					<xsl:text> is door </xsl:text>
					<xsl:if test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_voornoemd']/tekst,$upper,$lower) = 'true'">
						<xsl:text>voornoemde </xsl:text>
					</xsl:if>
					<xsl:value-of select="tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_partner']/tekst"/>
					<xsl:text> en </xsl:text>
					<xsl:value-of select="$zijnHaar"/>
					<xsl:text> hiervoor </xsl:text>
					<xsl:if test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_kopjeerfgenamen']/tekst,$upper,$lower) = 'true'">
						<xsl:text> onder ERFGENAMEN </xsl:text>
					</xsl:if>
					<xsl:text> genoemde </xsl:text>
					<xsl:value-of select="tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_erfgenamen']/tekst"/>
					<xsl:text> zuiver aanvaard. Van deze zuivere aanvaarding blijkt uit </xsl:text>
					<xsl:value-of select="kef:convertNumberToText(aantal)"/>
					<xsl:text> onderhandse verklaringen van zuivere aanvaarding</xsl:text>
					<xsl:if test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_aktegehecht']/tekst,$upper,$lower) = 'true'">
						<xsl:text> die aan deze akte zullen worden gehecht</xsl:text>
					</xsl:if>
					<xsl:text>.</xsl:text>
				</p>
			</xsl:when>
			<xsl:when test="$variant = 'c'">
				<p>
					<xsl:text>De nalatenschap van de </xsl:text>
					<xsl:value-of select="$overledeneAanduiding"/>
					<xsl:text> is door de hiervoor </xsl:text>
					<xsl:if test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_kopjeerfgenamen']/tekst,$upper,$lower) = 'true'">
						<xsl:text>onder ERFGENAMEN </xsl:text>
					</xsl:if>
					<xsl:text> genoemde </xsl:text>
					<xsl:value-of select="tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_erfgenamen']/tekst"/>
					<xsl:text> aanvaard onder het voorrecht van boedelbeschrijving, </xsl:text>
					<xsl:value-of select="$blijkens_low"/>
					<xsl:text> een akte op </xsl:text>
					<xsl:value-of select="kef:convertDateToText(datum)"/>
					<xsl:text> opgemaakt ter griffie van de Rechtbank </xsl:text>
					<xsl:value-of select="naamRechtbank"/>
					<xsl:text>, akte registernummer </xsl:text>
					<xsl:value-of select="registerNummer"/>
					<xsl:text>. Een afschrift van die verklaring is ingeschreven in het boedelregister van voormelde Rechtbank.</xsl:text>
				</p>
			</xsl:when>
			<xsl:when test="$variant = 'd'">
				<p>
					<xsl:text>De nalatenschap van de </xsl:text>
					<xsl:value-of select="$overledeneAanduiding"/>
					<xsl:text> is door de wettelijke vertegenwoordiger namens de hiervoor </xsl:text>
					<xsl:if test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_kopjeerfgenamen']/tekst,$upper,$lower) = 'true'">
						<xsl:text>onder ERFGENAMEN </xsl:text>
					</xsl:if>
					<xsl:text>genoemde </xsl:text>
					<xsl:value-of select="tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_minderjarigen']/tekst"/>
					<xsl:text> aanvaard onder het voorrecht van boedelbeschrijving, </xsl:text>
					<xsl:value-of select="$blijkens_low"/>
					<xsl:text> uit een akte op </xsl:text>
					<xsl:value-of select="kef:convertDateToText(datum)"/>
					<xsl:text> opgemaakt ter griffie van de Rechtbank te </xsl:text>
					<xsl:value-of select="plaatsRechtbank"/>
					<xsl:text>, akte registernummer </xsl:text>
					<xsl:value-of select="registerNummer"/>
					<xsl:text>. Een afschrift van die verklaring is ingeschreven in het boedelregister van voormelde Rechtbank.</xsl:text>
				</p>
				<xsl:if test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_verklaring']/tekst,$upper,$lower) = 'true'">
					<p>
						<xsl:text>Namens </xsl:text>
						<xsl:choose>
							<xsl:when test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_minderjarigen']/tekst,$upper,$lower) = 'minderjarigen'">
								<xsl:text>de minderjarige kinderen is op </xsl:text>
							</xsl:when>
							<xsl:otherwise>
								<xsl:text>het minderjarig kind is op </xsl:text>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:value-of select="kef:convertDateToText(datumVerklaring)"/>
						<xsl:text> bij de griffie van de Rechtbank </xsl:text>
						<xsl:value-of select="rechtbankVerklaring"/>
						<xsl:text> (zaaknummer </xsl:text>
						<xsl:value-of select="zaakNummer"/>
						<xsl:text>) de verklaring afgelegd dat de nalatenschap ten behoeve van de </xsl:text>
						<xsl:value-of select="tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_minderjarigen']/tekst"/>
						<xsl:text> is aanvaard onder het voorrecht van boedelbeschrijving.</xsl:text>
					</p>
				</xsl:if>
			</xsl:when>
			<xsl:when test="$variant = 'e'">
				<xsl:variable name="persoonRef" select="persoonRef/@xlink:href"/>
				<xsl:variable name="persoon" select="$opsommingPersonen/IMKAD_Persoon[@id = substring-after($persoonRef,'#')]"/>
				<xsl:variable name="curatorRef" select="curatorRef/@xlink:href"/>
				<xsl:variable name="curator" select="$opsommingPersonen/IMKAD_Persoon[@id = substring-after($curatorRef,'#')]"/>
				<p>
					<xsl:value-of select="$blijkens_up"/>
					<xsl:text> een beschikking van de rechtbank, is </xsl:text>
					<xsl:apply-templates select="$persoon/gegevens/GBA_Ingezetene" mode="do-gender-salutation"/>
					<xsl:text> </xsl:text>
					<xsl:apply-templates select="$persoon/gegevens/GBA_Ingezetene" mode="do-natural-person-personal-data"/>
					<xsl:if test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_voornoemd']/tekst,$upper,$lower) = 'true'">
						<xsl:text>, voornoemd</xsl:text>
					</xsl:if>
					<xsl:text>, onder curatele gesteld. Tot curator is benoemd: </xsl:text>
					<xsl:call-template name="tb-NatuurlijkPersoon">
						<xsl:with-param name="partner" select="$curator"/>
					</xsl:call-template>
					<xsl:text>. De curator heeft namens de onder curatele gestelde de nalatenschap van de overledene aanvaard onder het voorrecht van boedelbeschrijving. Hiervan blijkt uit een verklaring afgelegd op </xsl:text>
					<xsl:value-of select="kef:convertDateToText(datumVerklaring)"/>
					<xsl:text> bij de griffie van de Rechtbank </xsl:text>
					<xsl:value-of select="rechtbankVerklaring"/>
					<xsl:text> (zaaknummer </xsl:text>
					<xsl:value-of select="zaakNummer"/>
					<xsl:text>).</xsl:text>
				</p>
			</xsl:when>
			<xsl:when test="$variant = 'f'">
				<xsl:variable name="curatorRef" select="curatorRef/@xlink:href"/>
				<xsl:variable name="curator" select="$opsommingPersonen/IMKAD_Persoon[@id = substring-after($curatorRef,'#')]"/>
			<p>
					<xsl:value-of select="$blijkens_up"/>
					<xsl:text> een beschikking van de rechtbank </xsl:text>
					<xsl:value-of select="naamRechtbank"/>
					<xsl:text>, is er een bewind ingesteld over de goederen die (zullen gaan) toebehoren aan de hiervoor onder </xsl:text>
					<xsl:value-of select="tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_afstammelingenerfgenamen']/tekst"/>
					<xsl:text> sub </xsl:text>
					<xsl:value-of select="tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_volgnummer']/tekst"/>
					<xsl:text> genoemde </xsl:text>
					<xsl:value-of select="tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_erfgenamen']/tekst"/>
					<xsl:text>. Tot bewindvoerder is benoemd </xsl:text>
					<xsl:call-template name="tb-NatuurlijkPersoon">
						<xsl:with-param name="partner" select="$curator"/>
					</xsl:call-template>
					<xsl:text>. De bewindvoerder heeft namens de gemelde </xsl:text>
					<xsl:value-of select="tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_erfgenamen']/tekst"/>
					<xsl:text> de nalatenschap van de overledene aanvaard onder het voorrecht van boedelbeschrijving. Hiervan blijkt uit </xsl:text>
					<xsl:value-of select="kef:convertNumberToText(aantal)"/>
					<xsl:text> verklaring</xsl:text>
					<xsl:if test="aantal > 1">
						<xsl:text>en</xsl:text>
					</xsl:if>
					<xsl:text>, afgelegd op </xsl:text>
					<xsl:value-of select="kef:convertDateToText(datumVerklaring)"/>
					<xsl:text> bij de griffie van de Rechtbank </xsl:text>
					<xsl:value-of select="rechtbankVerklaring"/>
					<xsl:text> (zaaknummer </xsl:text>
					<xsl:value-of select="zaakNummer"/>
					<xsl:text>).</xsl:text>
				</p>	
			</xsl:when>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
