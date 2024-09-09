<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exslt="http://exslt.org/common" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:kef="nl.kadaster.xslt.XslExtensionFunctions" exclude-result-prefixes="xsl exslt xlink kef" version="1.0">
	<xsl:template match="conclusie">
		<xsl:variable name="variant" select="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_variant']/tekst, $upper, $lower)"/>
		<h3 class="header">
			<u>
				<xsl:text>CONCLUSIE</xsl:text>
			</u>
		</h3>
		<p>
			<xsl:choose>
				<xsl:when test="$variant = 'a'">
					<xsl:variable name="persoonRef" select="persoonRef/@xlink:href"/>
					<xsl:variable name="gerechtigde" select="$opsommingPersonen/IMKAD_Persoon[@id = substring-after($persoonRef,'#')]"/>
					<xsl:text>Op grond van het vorenstaande is genoemde </xsl:text>
					<xsl:apply-templates select="$gerechtigde/gegevens/GBA_Ingezetene" mode="do-gender-salutation"/>
					<xsl:text> </xsl:text>
					<xsl:apply-templates select="$gerechtigde/gegevens/GBA_Ingezetene" mode="do-natural-person-personal-data"/>
					<xsl:text>, als enige gerechtigd tot alle goederen en gelden behorende tot </xsl:text>
					<xsl:if test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_ontbonden']/tekst, $upper, $lower)='true'">
						<xsl:text>de door overlijden ontbonden gemeenschap van goederen en </xsl:text>
					</xsl:if>
					<xsl:text>de nalatenschap van de </xsl:text>
					<xsl:value-of select="$overledeneAanduiding"/>
					<xsl:text>, en mitsdien </xsl:text>
					<xsl:if test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_zelfstandigbevoegd']/tekst, $upper, $lower)='true'">
						<xsl:text>zelfstandig bevoegd en </xsl:text>
					</xsl:if>
					<xsl:text>gerechtigd om over al deze goederen te beheren en daarover te beschikken.</xsl:text>
				</xsl:when>
				<xsl:when test="$variant = 'b'">
					<xsl:variable name="persoonRef" select="persoonRef/@xlink:href"/>
					<xsl:variable name="gerechtigde" select="$opsommingPersonen/IMKAD_Persoon[@id = substring-after($persoonRef,'#')]"/>
					<xsl:text>Mitsdien is </xsl:text>
					<xsl:apply-templates select="$gerechtigde/gegevens/GBA_Ingezetene" mode="do-gender-salutation"/>
					<xsl:text> </xsl:text>
					<xsl:apply-templates select="$gerechtigde/gegevens/GBA_Ingezetene" mode="do-natural-person-personal-data"/>
					<xsl:if test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_voornoemd']/tekst, $upper, $lower)='true'">
						<xsl:text>, voornoemd</xsl:text>
					</xsl:if>
					<xsl:text>, met uitsluiting van ieder ander zelfstandig bevoegd en gerechtigd tot alle daden van beheer en beschikking betreft de ontbonden huwelijksgoederengemeenschap en de nalatenschap van de </xsl:text>
					<xsl:value-of select="$overledeneAanduiding"/>
					<xsl:text>.</xsl:text>
				</xsl:when>
				<xsl:when test="$variant = 'c'">
					<xsl:variable name="persoonRef1" select="persoonRef[1]/@xlink:href"/>
					<xsl:variable name="gerechtigde1" select="$opsommingPersonen/IMKAD_Persoon[@id = substring-after($persoonRef1,'#')]"/>
					<xsl:variable name="persoonRef2" select="persoonRef[2]/@xlink:href"/>
					<xsl:variable name="gerechtigde2" select="$opsommingPersonen/IMKAD_Persoon[@id = substring-after($persoonRef2,'#')]"/>
					<xsl:text>Mitsdien zijn </xsl:text>
					<xsl:apply-templates select="$gerechtigde1/gegevens/GBA_Ingezetene" mode="do-gender-salutation"/>
					<xsl:text> </xsl:text>
					<xsl:apply-templates select="$gerechtigde1/gegevens/GBA_Ingezetene" mode="do-natural-person-personal-data"/>
					<xsl:text> en </xsl:text>
					<xsl:apply-templates select="$gerechtigde2/gegevens/GBA_Ingezetene" mode="do-gender-salutation"/>
					<xsl:text> </xsl:text>
					<xsl:apply-templates select="$gerechtigde2/gegevens/GBA_Ingezetene" mode="do-natural-person-personal-data"/>
					<xsl:if test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_voornoemd']/tekst, $upper, $lower)='true'">
						<xsl:text>, beiden voornoemd</xsl:text>
					</xsl:if>
					<xsl:text>, met uitsluiting van </xsl:text>
					<xsl:value-of select="tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_gezamenlijk']/tekst"/>
					<xsl:text> bevoegd en gerechtigd tot alle daden van beheer en beschikking betreft de ontbonden huwelijksgoederengemeenschap en de nalatenschap van de </xsl:text>
					<xsl:value-of select="$overledeneAanduiding"/>
					<xsl:text>.</xsl:text>
				</xsl:when>
			</xsl:choose>
		</p>
	</xsl:template>
</xsl:stylesheet>
