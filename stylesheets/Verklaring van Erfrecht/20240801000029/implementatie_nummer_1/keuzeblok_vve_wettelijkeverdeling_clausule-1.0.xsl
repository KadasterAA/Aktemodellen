<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exslt="http://exslt.org/common" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:kef="nl.kadaster.xslt.XslExtensionFunctions" exclude-result-prefixes="xsl exslt xlink kef" version="1.0">
	<xsl:template match="uitInSluitingsClausule">
		<xsl:variable name="inUitsluiting">
			<xsl:choose>
				<xsl:when test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_inuitsluitingsclausule']/tekst, $upper, $lower)='insluiting'">
					<xsl:text>insluitingsclausule</xsl:text>
				</xsl:when>
				<xsl:when test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_inuitsluitingsclausule']/tekst, $upper, $lower)='uitsluiting'">
					<xsl:text>uitsluitingsclausule</xsl:text>
				</xsl:when>
				<xsl:when test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_inuitsluitingsclausule']/tekst, $upper, $lower)='beide'">
					<xsl:text>uitsluitingsclausule als een insluitingsclausule</xsl:text>
				</xsl:when>
			</xsl:choose>
		</xsl:variable>
		<h3 class="header">
			<u>
				<xsl:value-of select="translate($inUitsluiting,$lower,$upper)"/>
			</u>
		</h3>
		<p>
			<xsl:text>In gemeld testament van </xsl:text>
			<xsl:value-of select="kef:convertDateToText(datum)"/>
			<xsl:text> is ten aanzien van de verkrijgers een </xsl:text>
			<xsl:value-of select="$inUitsluiting"/>
			<xsl:text> opgenomen als bedoeld in artikel 1:94 lid 1 van het Burgerlijk Wetboek. In voormeld testament staat vermeld: </xsl:text>
			<xsl:value-of select="citaat"/>
			<xsl:text>.</xsl:text>
		</p>
	</xsl:template>
</xsl:stylesheet>
