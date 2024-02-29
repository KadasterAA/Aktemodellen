<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exslt="http://exslt.org/common" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:kef="nl.kadaster.xslt.XslExtensionFunctions" exclude-result-prefixes="xsl exslt xlink kef" version="1.0">
	<xsl:template match="overlijden">
		<h3 class="header">
			<u>OVERLIJDEN</u>
		</h3>
		<p>
			<xsl:choose>
				<xsl:when test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_variant']/tekst, $upper, $lower) = 'a'">
					<xsl:value-of select="$blijkens_up"/>
					<xsl:text> een aan deze akte gehecht uittreksel uit een overlijdensakte van de gemeente </xsl:text>
					<xsl:value-of select="gemeenteOverlijden"/>
					<xsl:text> is op </xsl:text>
					<xsl:value-of select="kef:convertDateToText(datumOverlijden)"/>
					<xsl:text> te </xsl:text>
					<xsl:value-of select="woonplaatsOverlijden"/>
					<xsl:text> overleden </xsl:text>
					
					<xsl:call-template name="tb-NatuurlijkPersoon">
					
						<xsl:with-param name="partner" select="$overledenPersoon"/>
						<xsl:with-param name="toonWoonplaats" select="'false'"/>
					</xsl:call-template>
					<xsl:text>, </xsl:text>
					<xsl:value-of select="tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_laatstwonende']/tekst"/>
					<xsl:text> te </xsl:text>
					<xsl:value-of select="woonplaatsLaatselijk"/>
					<xsl:text>, hierna te noemen de </xsl:text>
					<xsl:value-of select="$overledeneAanduiding"/>
				</xsl:when>
				<xsl:when test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_variant']/tekst, $upper, $lower) = 'b'">
					<xsl:text>Op </xsl:text>
					<xsl:value-of select="kef:convertDateToText(datumOverlijden)"/>
					<xsl:text> is in de gemeente </xsl:text>
					<xsl:value-of select="gemeenteOverlijden"/>
					<xsl:text> overleden: </xsl:text>
					<xsl:call-template name="tb-NatuurlijkPersoon">
						<xsl:with-param name="partner" select="$overledenPersoon"/>
						<xsl:with-param name="toonWoonplaats" select="'false'"/>
					</xsl:call-template>
					<xsl:text>, </xsl:text>
					<xsl:value-of select="tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_laatstwonende']/tekst"/>
					<xsl:text> te </xsl:text>
					<xsl:value-of select="woonplaatsLaatselijk"/>
					<xsl:text>, hierna te noemen de </xsl:text>
					<xsl:value-of select="$overledeneAanduiding"/>
				</xsl:when>
			</xsl:choose>
			<xsl:text>.</xsl:text>
			<xsl:if test="nationaliteit">
				<xsl:text> De </xsl:text>
				<xsl:value-of select="$overledeneAanduiding"/>
				<xsl:text> had bij </xsl:text>
				<xsl:value-of select="$zijnHaar"/>
				<xsl:text> overlijden de </xsl:text>
				<xsl:value-of select="nationaliteit"/>
				<xsl:text> nationaliteit.</xsl:text>
			</xsl:if>
		</p>
	</xsl:template>
</xsl:stylesheet>
