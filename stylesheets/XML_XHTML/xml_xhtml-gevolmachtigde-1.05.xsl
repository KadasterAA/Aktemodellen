<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:tia="http://www.kadaster.nl/schemas/KIK/TIA_Algemeen"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    exclude-result-prefixes="tia xsl"
	version="1.0">
	
	<!-- 
		*************************************************************************
		Template for block representative
		*************************************************************************
	-->
	<xsl:template name="Gevolmachtigde">
		<xsl:param name="gevolmachtigde"/>
		<xsl:param name="type"/>

		<xsl:if test="translate($gevolmachtigde/tia:gegevens/tia:persoonGegevens/tia:geslacht/tia:geslachtsaanduiding,$upper,$lower) = 'man'">
			<xsl:text>De heer</xsl:text>
		</xsl:if>
		<xsl:if test="translate($gevolmachtigde/tia:gegevens/tia:persoonGegevens/tia:geslacht/tia:geslachtsaanduiding,$upper,$lower) = 'vrouw'">
			<xsl:text>Mevrouw</xsl:text>
		</xsl:if>
		<xsl:text> </xsl:text>
		<xsl:call-template name="person_data">
			<xsl:with-param name="person" select="$gevolmachtigde/tia:gegevens/tia:persoonGegevens"/>
		</xsl:call-template>
		<xsl:choose>
			<xsl:when test="translate($type,$upper,$lower) = 'doc'">
				<xsl:text>, kantooradres: </xsl:text>
				<xsl:value-of select="$gevolmachtigde/tia:gegevens/tia:naamKantoor"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>, werkzaam ten kantore van mij, notaris</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:text>, gevestigd te </xsl:text>
		<xsl:call-template name="binnenlandsAdres">
			<xsl:with-param name="address" select="$gevolmachtigde/tia:gegevens/tia:adresKantoor"/>
		</xsl:call-template>
		<xsl:text>, te dezen handelend </xsl:text>
		<xsl:choose>
			<xsl:when test="translate($type,$upper,$lower) = 'dot'">
				<xsl:variable name="txt" select="$gevolmachtigde/tia:tekstkeuze[translate(tia:tagNaam,$upper,$lower) = 'k_verantwoordelijkheidnotaris']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
					translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam,$upper,$lower) = 'k_verantwoordelijkheidnotaris']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
					translate(normalize-space($gevolmachtigde/tia:tekstkeuze[translate(tia:tagNaam,$upper,$lower) = 'k_verantwoordelijkheidnotaris']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
				<xsl:value-of select="$txt"/>
				<xsl:if test="$txt">
					<xsl:text> </xsl:text>
				</xsl:if>
			</xsl:when>
			<xsl:when test="translate($type,$upper,$lower) = 'doc'">
				<xsl:text>onder de verantwoordelijkheid van mij, notaris, </xsl:text>
			</xsl:when>
		</xsl:choose>
		<xsl:text>als </xsl:text>
		<xsl:choose>
			<xsl:when test="translate($type,$upper,$lower) = 'doc'">
				<xsl:text>schriftelijk</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="$gevolmachtigde/tia:gegevens/tia:bevoegdheid">
					<xsl:if test="string-length($gevolmachtigde/tia:gegevens/tia:bevoegdheid)!=0">
						<xsl:value-of select="$gevolmachtigde/tia:gegevens/tia:bevoegdheid"/>
					</xsl:if>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:text> gevolmachtigde van:</xsl:text>
	</xsl:template>
    
</xsl:stylesheet>
