<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" xmlns:rep="http://www.kadaster.nl/schemas/KIK/repository/v07" exclude-result-prefixes="rep xsl" version="1.0">
	<xsl:output method="text" encoding="UTF-8"/>
	<xsl:template match="processing-instruction()"/>
	<xsl:template match="/">
		<xsl:apply-templates select="rep:repository"/>
	</xsl:template>
	<xsl:template match="rep:repository">
		<xsl:text>Per implementatienummer vindt u hier de versie van het stylesheet</xsl:text>
		<xsl:text>&#xa;</xsl:text>
		<xsl:text>&#xa;</xsl:text>
		<xsl:text>Modeldocument|Depotnummer|Implementatienr|Versie stylesheet</xsl:text>
		<xsl:text>&#xa;</xsl:text>
		<xsl:text>:---:|:---:|---|---</xsl:text>
		<xsl:text>&#xa;</xsl:text>
		<xsl:apply-templates select="rep:modeldocument">
			<xsl:sort select="rep:soort-stuk"/>
			<xsl:sort select="rep:soort-stuk-variant"/>
			<xsl:sort select="rep:depotnummer" order="descending" data-type="number"/>
		</xsl:apply-templates>
	</xsl:template>
	<xsl:template match="rep:modeldocument">
		<xsl:if test="rep:specificatie/rep:publicatie = 'extern'">
			<xsl:apply-templates select="rep:soort-stuk"/>
		</xsl:if>
	</xsl:template>
	<xsl:template match="rep:soort-stuk">
		<xsl:variable name="soort">
			<xsl:value-of select="."/>
		</xsl:variable>
		<xsl:variable name="variant">
			<xsl:choose>
				<xsl:when test="../rep:soort-stuk-variant">
					<xsl:value-of select="../rep:soort-stuk-variant"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="isErAlEen">
			<xsl:for-each select="preceding::rep:modeldocument/rep:soort-stuk">
				<xsl:if test="../rep:specificatie/rep:publicatie = 'extern'">
					<xsl:if test=". = $soort">
						<xsl:choose>
							<xsl:when test="../rep:soort-stuk-variant">
								<xsl:if test="../rep:soort-stuk-variant = $variant">
									<xsl:text>true</xsl:text>
								</xsl:if>
							</xsl:when>
							<xsl:otherwise>
								<xsl:text>true</xsl:text>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:if>
				</xsl:if>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="soortStuk">
			<xsl:value-of select="."/>
			<xsl:if test="string-length(../rep:soort-stuk-variant) != 0">
				<xsl:text> </xsl:text>
				<xsl:value-of select="../rep:soort-stuk-variant"/>
			</xsl:if>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$isErAlEen = 'true'">
				<xsl:text> “ |</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$soortStuk"/>
				<xsl:text>|</xsl:text>
		</xsl:otherwise>
		</xsl:choose>
		<xsl:apply-templates select="../rep:depotnummer"/>
		<xsl:text>|</xsl:text>
		<!-- implementatie -->
		<xsl:apply-templates select="../rep:implementatie/rep:modeldocument-implementatie">
			<xsl:sort select="../rep:implementatienummer" order="descending" data-type="number"/>
		</xsl:apply-templates>
	</xsl:template>
	<xsl:template match="rep:modeldocument-implementatie">
		<xsl:if test="preceding-sibling::rep:modeldocument-implementatie">
			<xsl:text> “ | “ |</xsl:text>
		</xsl:if>
		<xsl:value-of select="rep:implementatienummer"/>
		<xsl:text>|</xsl:text>
		<xsl:value-of select="substring-before(substring-after(rep:style-sheet,'/'),'.xsl')"/>
		<xsl:text>&#xa;</xsl:text>
	</xsl:template>
</xsl:stylesheet>
