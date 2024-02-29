<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="xsl" version="1.0">
	<xsl:template  match="persoonsgegevens | GBA_Ingezetene" mode="do-natural-person-personal-data">
		<xsl:if test="tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_professor']">
			<xsl:value-of select="tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_professor']/tekst[translate(normalize-space(.), $upper, $lower)]"/>
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:if test="(adellijkeTitel) 
				and (normalize-space(adellijkeTitel) != '')">
			<xsl:value-of select="adellijkeTitel"/>
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:if test="titel and normalize-space(titel) != ''">
			<xsl:value-of select="titel"/>
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:value-of select="naam/voornamen"/>
		<xsl:text> </xsl:text>
		<xsl:if test="adellijkeTitel2 and normalize-space(adellijkeTitel2) != ''">
			<xsl:value-of select="adellijkeTitel2"/>
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:if test="(voorvoegselsNaam)
				and normalize-space(voorvoegselsNaam) != ''">
			<xsl:value-of select="voorvoegselsNaam"/>
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:value-of select="naamZonderVoorvoegsels"/>
		<xsl:if test="titel2 and normalize-space(titel2) != ''">
			<xsl:text> </xsl:text>
			<xsl:value-of select="titel2"/>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
