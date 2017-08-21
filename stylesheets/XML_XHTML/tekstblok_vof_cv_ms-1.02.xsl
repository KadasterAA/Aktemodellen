<?xml version="1.0" encoding="UTF-8"?>
<!--
*********************************************************
Stylesheet: tekstblok_vof_cv.xsl
Version: 1.02
*********************************************************
Description:
VOF CV MS text block.

Public:
(mode) do-vof-cv-ms

Private:
none
-->
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
	xmlns:tia="http://www.kadaster.nl/schemas/KIK/TIA_Algemeen"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	exclude-result-prefixes="tia xsl"
	version="1.0">

	<!--
	*********************************************************
	Mode: do-vof-cv-ms
	*********************************************************
	Public: yes

	Identity transform: no

	Description: VOF CV MS text block.

	Input: tia:IMKAD_Persoon

	Params: none

	Output: text

	Calls:
	(mode) do-gender-salutation
	(mode) do-legal-person
	

	Called by:
	(mode) do-party-legal-person
	(mode) do-party-natural-person-single
	(mode) do-party-natural-person-person-pair
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon" mode="do-vof-cv-ms">
		<xsl:variable name="forThem" select="../../tia:Partij/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorzich']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorzich']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space(current()/../../tia:Partij/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorzich']/tia:tekst), $upper, $lower)]), $upper, $lower)]" />
		<xsl:variable name="rol" select="../../tia:Partij/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_rolvennootmaat']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_rolvennootmaat']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space(current()/../../tia:Partij/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_rolvennootmaat']/tia:tekst), $upper, $lower)]), $upper, $lower)]" />	
		
		<xsl:if test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_vennootmaat']/tia:tekst, $upper, $lower) = 'true' 
						or translate(tia:GerelateerdPersoon/tia:IMKAD_Persoon/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_vennootmaat']/tia:tekst, $upper, $lower) = 'true'">
			<xsl:if test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_vennootmaat']/tia:tekst, $upper, $lower) = 'true'">
				<xsl:choose>
					<xsl:when test="tia:tia_Gegevens/tia:GBA_Ingezetene">
						<xsl:apply-templates select="tia:tia_Gegevens/tia:GBA_Ingezetene" mode="do-gender-salutation" />
						<xsl:text> </xsl:text>
						<xsl:choose>
							<xsl:when test="tia:tia_Gegevens/tia:IMKAD_KadNatuurlijkPersoon">
								<xsl:value-of select="tia:tia_Gegevens/tia:IMKAD_KadNatuurlijkPersoon/tia:geslachtsnaam"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="tia:tia_Gegevens/tia:GBA_Ingezetene/tia:tia_NaamZonderVoorvoegsels"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="tia:tia_Gegevens/tia:IMKAD_NietIngezetene">
						<xsl:apply-templates select="tia:tia_Gegevens/tia:IMKAD_NietIngezetene" mode="do-gender-salutation" />
						<xsl:text> </xsl:text>	
						<xsl:value-of select="tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:geslachtsnaam"/>
					</xsl:when>
					<xsl:when test="tia:tia_Gegevens/tia:NHR_Rechtspersoon">
						<xsl:value-of select="tia:tia_Gegevens/tia:NHR_Rechtspersoon/tia:rechtsvormSub"/>
						<xsl:text> </xsl:text>	
						<xsl:value-of select="tia:tia_Gegevens/tia:NHR_Rechtspersoon/tia:statutaireNaam"/>
					</xsl:when>
				</xsl:choose>
				<xsl:choose>
					<xsl:when test="count(tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_vennootmaat']/tia:tekst, $upper, $lower) = 'true']) = 1">
						<xsl:text> en </xsl:text>
					</xsl:when>
					<xsl:when test="count(tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_vennootmaat']/tia:tekst, $upper, $lower) = 'true']) > 1">
						<xsl:text>, </xsl:text>
					</xsl:when>
				</xsl:choose>
		</xsl:if>
			<xsl:for-each select="tia:GerelateerdPersoon/tia:IMKAD_Persoon[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_vennootmaat']/tia:tekst, $upper, $lower) = 'true']">
		<xsl:choose>
					<xsl:when test="tia:tia_Gegevens/tia:GBA_Ingezetene">
						<xsl:apply-templates select="tia:tia_Gegevens/tia:GBA_Ingezetene" mode="do-gender-salutation" />
						<xsl:text> </xsl:text>
						<xsl:choose>
							<xsl:when test="tia:tia_Gegevens/tia:IMKAD_KadNatuurlijkPersoon">
								<xsl:value-of select="tia:tia_Gegevens/tia:IMKAD_KadNatuurlijkPersoon/tia:geslachtsnaam"/>
			</xsl:when>
			<xsl:otherwise>
								<xsl:value-of select="tia:tia_Gegevens/tia:GBA_Ingezetene/tia:tia_NaamZonderVoorvoegsels"/>
			</xsl:otherwise>
		</xsl:choose>
					</xsl:when>
					<xsl:when test="tia:tia_Gegevens/tia:IMKAD_NietIngezetene">
						<xsl:apply-templates select="tia:tia_Gegevens/tia:IMKAD_NietIngezetene" mode="do-gender-salutation" />
						<xsl:text> </xsl:text>	
						<xsl:value-of select="tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:geslachtsnaam"/>
					</xsl:when>
					<xsl:when test="tia:tia_Gegevens/tia:NHR_Rechtspersoon">
						<xsl:value-of select="tia:tia_Gegevens/tia:NHR_Rechtspersoon/tia:rechtsvormSub"/>
						<xsl:text> </xsl:text>	
						<xsl:value-of select="tia:tia_Gegevens/tia:NHR_Rechtspersoon/tia:statutaireNaam"/>
					</xsl:when>
				</xsl:choose>
				<xsl:choose>
					<xsl:when test="position() = last() - 1">
						<xsl:text> en </xsl:text>
					</xsl:when>
					<xsl:when test="position() != last()">
						<xsl:text>, </xsl:text>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
			<xsl:text> voornoemd, </xsl:text>
		</xsl:if>
		<xsl:text>te dezen handelend</xsl:text>
		<xsl:choose>
			<xsl:when test="$forThem">
				<xsl:text>:</xsl:text>
				<ul class="arrow">
					<li class="arrow">
						<xsl:value-of select="substring-after($forThem, '- ')"/>
					</li>
					<li class="arrow">
						<xsl:text>als </xsl:text>
						<xsl:value-of select="$rol"/>	
						<xsl:text> van</xsl:text>
					</li>
				</ul>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text> als </xsl:text>
				<xsl:value-of select="$rol"/>	
				<xsl:text> van </xsl:text>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:apply-templates select="../tia:vofCvMs" mode="do-legal-person"/>
	</xsl:template>
</xsl:stylesheet>
