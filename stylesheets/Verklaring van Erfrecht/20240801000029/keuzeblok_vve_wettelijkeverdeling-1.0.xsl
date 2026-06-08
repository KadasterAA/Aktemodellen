<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exslt="http://exslt.org/common" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:kef="nl.kadaster.xslt.XslExtensionFunctions" exclude-result-prefixes="exslt xlink kef" version="1.0">
	<xsl:template match="wettelijkeVerdeling">
		<xsl:variable name="partnerRef" select="partnerRef/@xlink:href"/>
		<xsl:variable name="partner" select="$opsommingPersonen/IMKAD_Persoon[@id = substring-after($partnerRef,'#')]"/>

		<xsl:variable name="geslacht" select="$partner/gegevens/GBA_Ingezetene/geslacht/geslachtsaanduiding"/>
		<h3 class="header">
			<u>WETTELIJKE VERDELING</u>
		</h3>
		<p>
			<xsl:choose>
				<xsl:when test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_wettelijkeverdeling']/tekst, $upper, $lower) = 'a'">
					<xsl:text>Op de nalatenschap is afdeling 1, titel 3, boek 4 van het Burgerlijk Wetboek ("Wettelijke verdeling") van toepassing.</xsl:text>
				</xsl:when>
				<xsl:when test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_wettelijkeverdeling']/tekst, $upper, $lower) = 'b'">
					<xsl:text>De </xsl:text>
					<xsl:value-of select="$overledeneAanduiding"/>
					<xsl:text> heeft de wettelijke verdeling, als bedoeld in afdeling 1, titel 3, boek 4 van het Burgerlijk Wetboek van toepassing verklaard op </xsl:text>
					<xsl:value-of select="$zijnHaar"/>
					<xsl:text> nalatenschap.</xsl:text>
				</xsl:when>
			</xsl:choose>
		</p>
		<p>
			<xsl:choose>
				<xsl:when test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_ongedaanmaken']/tekst, $upper, $lower) = 'artikel 4:18'">
					<xsl:text>Voorts heeft </xsl:text>
					<xsl:apply-templates select="$partner/gegevens/GBA_Ingezetene" mode="do-gender-salutation"/>
					<xsl:text> </xsl:text>
					<xsl:apply-templates select="$partner/gegevens/GBA_Ingezetene" mode="do-natural-person-personal-data"/>
					<xsl:if test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_voornoemd']/tekst, $upper, $lower) = 'true'">
						<xsl:text>, voornoemd,</xsl:text>
					</xsl:if>
					<xsl:text> verklaard van de </xsl:text>
					<xsl:choose>
						<xsl:when test="translate($geslacht,$upper,$lower) = 'man'">
							<xsl:text> hem </xsl:text>
						</xsl:when>
						<xsl:when test="translate($geslacht,$upper,$lower) = 'vrouw'">
							<xsl:text> haar </xsl:text>
						</xsl:when>
					</xsl:choose>
					<xsl:text>op grond van artikel 4:18 van het Burgerlijk Wetboek toekomende bevoegdheid de wettelijke verdeling ongedaan te maken, geen gebruik te hebben gemaakt en daarvan geen gebruik te zullen maken, welke verklaring aan deze akte is gehecht.</xsl:text>
				</xsl:when>
				<xsl:when test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_ongedaanmaken']/tekst, $upper, $lower) = 'wettelijke bevoegdheid'">
					<xsl:text>De </xsl:text>
					<xsl:value-of select="$benamingPartner"/>
					<xsl:text> van de </xsl:text>
					<xsl:value-of select="$overledeneAanduiding"/>
					<xsl:text> heeft volgens het boedelregister van de rechtbank geen gebruik gemaakt van de wettelijke bevoegdheid om de wettelijke verdeling binnen drie (3) maanden na het openvallen van de nalatenschap ongedaan te maken en </xsl:text>
					<xsl:choose>
						<xsl:when test="translate($overledenPersoon/gegevens/GBA_Ingezetene/geslacht/geslachtsaanduiding,$upper,$lower) = 'man'">
							<xsl:text> hij </xsl:text>
						</xsl:when>
						<xsl:when test="translate($overledenPersoon/gegevens/GBA_Ingezetene/geslacht/geslachtsaanduiding,$upper,$lower) = 'vrouw'">
							<xsl:text> zij </xsl:text>
						</xsl:when>
					</xsl:choose>
					<xsl:text>kan nu, in verband met het verstrijken van deze termijn, zich niet meer op deze mogelijkheid beroepen.</xsl:text>
				</xsl:when>
			</xsl:choose>
		</p>
		<p>
			<xsl:text>Als gevolg hiervan heeft de </xsl:text>
			<xsl:value-of select="$benamingPartner"/>
			<xsl:text> van </xsl:text>
			<xsl:choose>
				<xsl:when test="$partner != ''">
					<xsl:apply-templates select="$partner/gegevens/GBA_Ingezetene" mode="do-gender-salutation"/>
					<xsl:text> </xsl:text>
					<xsl:apply-templates select="$partner/gegevens/GBA_Ingezetene" mode="do-natural-person-personal-data"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>de </xsl:text>
					<xsl:value-of select="$overledeneAanduiding"/>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:if test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_voornoemd']/tekst, $upper, $lower) = 'true'">
				<xsl:text>, voornoemd</xsl:text>
			</xsl:if>
			<xsl:text>, op het moment van het overlijden alle goederen van de nalatenschap verkregen en komen de schulden van de nalatenschap voor </xsl:text>
			<xsl:choose>
				<xsl:when test="$partner != ''">
					<xsl:choose>
						<xsl:when test="translate($geslacht,$upper,$lower) = 'man'">
							<xsl:text> zijn rekening en is hij </xsl:text>
						</xsl:when>
						<xsl:when test="translate($geslacht,$upper,$lower) = 'vrouw'">
							<xsl:text> haar rekening en is zij </xsl:text>
						</xsl:when>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="translate($overledenPersoon/gegevens/GBA_Ingezetene/geslacht/geslachtsaanduiding,$upper,$lower) = 'man'">
							<xsl:text> zijn rekening en is hij </xsl:text>
						</xsl:when>
						<xsl:when test="translate($overledenPersoon/gegevens/GBA_Ingezetene/geslacht/geslachtsaanduiding,$upper,$lower) = 'vrouw'">
							<xsl:text> haar rekening en is zij </xsl:text>
						</xsl:when>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text>verplicht die te voldoen.</xsl:text>
		</p>
	</xsl:template>
</xsl:stylesheet>