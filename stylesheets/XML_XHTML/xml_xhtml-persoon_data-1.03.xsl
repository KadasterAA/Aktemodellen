<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	xmlns:tia="http://www.kadaster.nl/schemas/KIK/TIA_Algemeen"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:kef="nl.kadaster.xslt.XslExtensionFunctions"
	exclude-result-prefixes="tia xsl kef"
    version="1.0">

	<xsl:template name="person_data">
		<xsl:param name="person"/>
		<xsl:param name="include-birth-data" select="'true'"/>

		<xsl:if test="$person/tia:tia_AdellijkeTitel">
			<xsl:if test="string-length($person/tia:tia_AdellijkeTitel)!=0">
				<xsl:value-of select="$person/tia:tia_AdellijkeTitel"/>
				<xsl:text> </xsl:text>
			</xsl:if>
		</xsl:if>
		<xsl:if test="$person/tia:tia_Titel">
			<xsl:if test="string-length($person/tia:tia_Titel)!=0">
				<xsl:value-of select="$person/tia:tia_Titel"/>
				<xsl:text> </xsl:text>
			</xsl:if>
		</xsl:if>
		<xsl:value-of select="$person/tia:naam/tia:voornamen|$person/tia:voornamen"/>
		<xsl:text> </xsl:text>
		<xsl:if test="normalize-space($person/tia:tia_VoorvoegselsNaam|$person/tia:voorvoegsels)">
			<xsl:value-of select="$person/tia:tia_VoorvoegselsNaam|$person/tia:voorvoegsels"/>
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:value-of select="$person/tia:tia_NaamZonderVoorvoegsels|$person/tia:geslachtsnaam"/>
		<xsl:if test="translate($include-birth-data,$upper,$lower) = 'true'">
			<xsl:text>, geboren te </xsl:text>
			<xsl:if test="normalize-space($person/tia:geboorte/tia:geboorteplaatsOmschrijving|$person/tia:geboorteplaats)">
				<xsl:value-of select="$person/tia:geboorte/tia:geboorteplaatsOmschrijving|$person/tia:geboorteplaats"/>
			</xsl:if>
			<xsl:text> op </xsl:text>
			<xsl:if test="normalize-space($person/tia:geboorte/tia:geboortedatum|$person/tia:geboortedatum)">
				<xsl:value-of select="kef:convertDateToText(substring(string($person/tia:geboorte/tia:geboortedatum|$person/tia:geboortedatum),0,11))"/>
			</xsl:if>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
