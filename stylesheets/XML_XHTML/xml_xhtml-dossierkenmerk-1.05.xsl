<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:xhtml="http://www.w3.org/1999/xhtml"
	xmlns:tia="http://www.kadaster.nl/schemas/KIK/TIA_Algemeen"
	xmlns:alg="http://www.kadaster.nl/schemas/KIK/Formaattypen"
	xmlns:xlink="http://www.w3.org/1999/xlink"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	exclude-result-prefixes="xhtml tia alg xlink xsl"
	version="1.0">

	<!-- 
		*************************************************************************
		Template for documents characteristic (dossier-kenmerk)
		*************************************************************************
	-->
	<xsl:template name="dossierkenmerk">
		<xsl:param name="kenmerk"/>
		<xsl:param name="type"/>
		<xsl:param name="isNetworkNotary" select="'false'"/>
		<xsl:choose>
			<xsl:when test="translate($type,$upper,$lower) = 'dot'">
				<a name="hyp4.header" class="location">&#160;</a>
			</xsl:when>
			<xsl:when test="translate($type,$upper,$lower) = 'dom'">
				<a name="hyp3.header" class="location">&#160;</a>
			</xsl:when>
			<xsl:when test="translate($type,$upper,$lower) = 'wkpb'">
				<a name="wkpb.header" class="location">&#160;</a>
			</xsl:when>
			<xsl:when test="translate($type,$upper,$lower) = 'doc'">
				<a name="mortgagecancellationdeed.header" class="location">&#160;</a>
			</xsl:when>
		</xsl:choose>
		<xsl:if test="$kenmerk != ''">
			<p>
				<xsl:if test="translate($isNetworkNotary,$upper,$lower) = 'true'">
					<xsl:attribute name="title">without_dashes</xsl:attribute>
				</xsl:if>
				<xsl:choose>
					<xsl:when test="translate($type,$upper,$lower) = 'dos'">
						<xsl:text>Dossiernummer: </xsl:text>
					</xsl:when>
					<xsl:when test="translate($type,$upper,$lower) = 'docs'">
						<xsl:text>Dossiernummer: </xsl:text>
					</xsl:when>
					<xsl:when test="translate($type,$upper,$lower) = 'dom'">
						<xsl:text>Offertenummer: </xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>Kenmerk: </xsl:text>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:value-of select="$kenmerk"/>
			</p>
			<p>
				<xsl:if test="translate($isNetworkNotary,$upper,$lower) = 'true'">
					<xsl:attribute name="title">without_dashes</xsl:attribute>
				</xsl:if>
				<br/>
			</p>
		</xsl:if>
	</xsl:template>
	
</xsl:stylesheet>
