<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exslt="http://exslt.org/common" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:kef="nl.kadaster.xslt.XslExtensionFunctions" exclude-result-prefixes="xsl exslt xlink kef" version="1.0">
	<xsl:template match="inschrijvingBoedelregister">
		<xsl:variable name="variant" select="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_variant']/tekst, $upper, $lower)"/>
		<h3 class="header">
			<u>
				<xsl:text>INSCHRIJVING BOEDELREGISTER</xsl:text>
			</u>
		</h3>
		<p>
			<xsl:choose>
				<xsl:when test="$variant = 'a'">
					<xsl:text>Als notaris, bedoeld in artikel 4:186 lid 2 van het Burgerlijk Wetboek, is ondergetekende in het boedelregister ingeschreven.</xsl:text>
				</xsl:when>
				<xsl:when test="$variant = 'b'">
					<xsl:variable name="notarisRef" select="notarisRef/@xlink:href"/>
					<xsl:variable name="notaris" select="$opsommingPersonen/IMKAD_Persoon[@id = substring-after($notarisRef,'#')]"/>
					<xsl:text>Als notaris, bedoeld in artikel 4:186 lid 2 van het Burgerlijk Wetboek, is ondergetekende in het boedelregister ingeschreven </xsl:text>
					<xsl:apply-templates select="$notaris/gegevens/GBA_Ingezetene" mode="do-gender-salutation"/>
					<xsl:text> </xsl:text>
					<xsl:apply-templates select="$notaris/gegevens/GBA_Ingezetene" mode="do-natural-person-personal-data"/>
					<xsl:text>.</xsl:text>
				</xsl:when>
				<xsl:when test="$variant = 'c'">
					<xsl:text>Ondergetekende is als betrokken notaris ingeschreven in het boedelregister.</xsl:text>
				</xsl:when>
			</xsl:choose>
		</p>
	</xsl:template>
</xsl:stylesheet>
