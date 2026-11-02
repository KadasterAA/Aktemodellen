<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exslt="http://exslt.org/common" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:kef="nl.kadaster.xslt.XslExtensionFunctions" exclude-result-prefixes="xsl exslt xlink kef" version="1.0">
	<xsl:template match="woonplaatsKeuze">
		<xsl:variable name="variant" select="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_variant']/tekst, $upper, $lower)"/>
		<h3 class="header">
			<u>
				<xsl:text>WOONPLAATS</xsl:text>
			</u>
		</h3>
		<p>
			<xsl:choose>
				<xsl:when test="$variant = 'a'">
					<xsl:text>Voornoemde erfgenamen hebben voor de uitvoering van deze akte, waaronder begrepen de inschrijving daarvan in de openbare registers, woonplaats gekozen </xsl:text>
					<xsl:value-of select="tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_tenkantore']/tekst"/>
					<xsl:text> de bewaarder van deze akte.</xsl:text>
				</xsl:when>
				<xsl:when test="$variant = 'b'">
					
					<xsl:text>De erfgenamen kiezen op voet van art. 1:15 Burgerlijk Wetboek ter zake van de kennisgevingen van het Kadaster domicilie op het kantoor </xsl:text>
					<xsl:value-of select="tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_bewaarder']/tekst"/>
					<xsl:text>.</xsl:text>
				</xsl:when>
				<xsl:when test="$variant = 'c'">
					<xsl:variable name="persoonRef" select="persoonRef/@xlink:href"/>
					<xsl:variable name="persoon" select="$opsommingPersonen/IMKAD_Persoon[@id = substring-after($persoonRef,'#')]"/>
					<xsl:text>De erfgenamen kiezen op voet van art. 1:15 Burgerlijk Wetboek ter zake van de kennisgevingen van het Kadaster domicilie te </xsl:text>
					<xsl:apply-templates select="$persoon/gegevens/GBA_Ingezetene" mode="do-gender-salutation"/>
					<xsl:text> </xsl:text>
					<xsl:apply-templates select="$persoon/gegevens/GBA_Ingezetene" mode="do-natural-person-personal-data"/>
					<xsl:text>.</xsl:text>
				</xsl:when>
			</xsl:choose>
		</p>
	</xsl:template>
</xsl:stylesheet>
