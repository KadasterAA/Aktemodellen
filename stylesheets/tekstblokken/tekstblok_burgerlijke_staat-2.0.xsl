<?xml version="1.0" encoding="UTF-8"?>
<!--
*********************************************************
Stylesheet: tekstblok_burgerlijke_staat.xsl
Version: 1.04 (AA-6978)
			
*********************************************************
Description:
Marital status text block.

Public:
(mode) do-marital-status
(mode) do-marital-status-partners

Private:
none
-->
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
	xmlns:tia="http://www.kadaster.nl/schemas/KIK/TIA_Algemeen"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	exclude-result-prefixes="tia xsl"
	version="1.00">
	
	<!--
	*********************************************************
	Mode: do-marital-status
	*********************************************************
	Public: yes

	Identity transform: no

	Description: Marital status.

	Input: tia:Gevolmachtigde

	Params: none

	Output: text

	Calls:
	none

	Called by:
	(mode) do-legal-representative
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:Gevolmachtigde | tia:IMKAD_Persoon" mode="do-marital-status">
		<xsl:variable name="marital-status-text" >
			<xsl:choose>
				<xsl:when test="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_burgerlijkestaattekst']">
					<xsl:value-of select="$keuzetekstenTbBurgelijkeStaat/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_burgerlijkestaattekst']/tia:tekst[
					position() = translate(normalize-space(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_burgerlijkestaattekst']/tia:tekst), $upper, $lower)]" />
				</xsl:when>
				<xsl:when test="tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_burgerlijkestaattekst']">
					<xsl:value-of select="$keuzetekstenTbBurgelijkeStaat/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_burgerlijkestaattekst']/tia:tekst[
					position() = translate(normalize-space(current()/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_burgerlijkestaattekst']/tia:tekst), $upper, $lower)]" />
				</xsl:when>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="marital-status-text-copy">
			<xsl:choose>
				<xsl:when test="contains(translate($marital-status-text, $upper, $lower), 'weduwe/weduwnaar')">
					<xsl:choose>
						<xsl:when test="translate(tia:tia_Gegevens/tia:GBA_Ingezetene/tia:geslacht/tia:geslachtsaanduiding, $upper, $lower) = 'vrouw' or translate(tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:geslacht, $upper, $lower) = 'vrouw' or translate(tia:gegevens/tia:persoonGegevens/tia:geslacht/tia:geslachtsaanduiding, $upper, $lower) = 'vrouw'">
							<xsl:value-of select="concat(substring-before($marital-status-text, 'weduwe/weduwnaar'), 'weduwe', substring-after($marital-status-text, 'weduwe/weduwnaar'))"/>
						</xsl:when>
						<xsl:when test="translate(tia:tia_Gegevens/tia:GBA_Ingezetene/tia:geslacht/tia:geslachtsaanduiding, $upper, $lower) = 'man' or translate(tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:geslacht, $upper, $lower) = 'man' or translate(tia:gegevens/tia:persoonGegevens/tia:geslacht/tia:geslachtsaanduiding, $upper, $lower) = 'man'">
							<xsl:value-of select="concat(substring-before($marital-status-text, 'weduwe/weduwnaar'), 'weduwnaar', substring-after($marital-status-text, 'weduwe/weduwnaar'))"/>
						</xsl:when>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="contains(translate($marital-status-text, $upper, $lower), 'zijn/haar/diens')">
					<xsl:choose>
						<xsl:when test="translate(tia:tia_Gegevens/tia:GBA_Ingezetene/tia:geslacht/tia:geslachtsaanduiding, $upper, $lower) = 'vrouw' or translate(tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:geslacht, $upper, $lower) = 'vrouw' or translate(tia:gegevens/tia:persoonGegevens/tia:geslacht/tia:geslachtsaanduiding, $upper, $lower) = 'vrouw'">
							<xsl:value-of select="concat(substring-before($marital-status-text, 'zijn/haar/diens'), 'haar', substring-after($marital-status-text, 'zijn/haar/diens'))"/>
						</xsl:when>
						<xsl:when test="translate(tia:tia_Gegevens/tia:GBA_Ingezetene/tia:geslacht/tia:geslachtsaanduiding, $upper, $lower) = 'man' or translate(tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:geslacht, $upper, $lower) = 'man' or translate(tia:gegevens/tia:persoonGegevens/tia:geslacht/tia:geslachtsaanduiding, $upper, $lower) = 'man'">
							<xsl:value-of select="concat(substring-before($marital-status-text, 'zijn/haar/diens'), 'zijn', substring-after($marital-status-text, 'zijn/haar/diens'))"/>
						</xsl:when>
						<xsl:when test="translate(tia:tia_Gegevens/tia:GBA_Ingezetene/tia:geslacht/tia:geslachtsaanduiding, $upper, $lower) = 'onbekend' or translate(tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:geslacht, $upper, $lower) = 'onbekend' or translate(tia:gegevens/tia:persoonGegevens/tia:geslacht/tia:geslachtsaanduiding, $upper, $lower) = 'onbekend'">
							<xsl:value-of select="concat(substring-before($marital-status-text, 'zijn/haar/diens'), 'diens', substring-after($marital-status-text, 'zijn/haar/diens'))"/>
						</xsl:when>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$marital-status-text"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>		
		<xsl:variable name="burgerlijkestaatland">
			<xsl:choose>
				<xsl:when test="tia:tia_BurgerlijkeStaatLand">
					<xsl:value-of select="tia:tia_BurgerlijkeStaatLand" />
				</xsl:when>
				<xsl:when test="tia:burgerlijkeStaatLand">
					<xsl:value-of select="tia:burgerlijkeStaatLand" />
				</xsl:when>
				<xsl:otherwise><xsl:text /></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="burgerlijkeStaatTekst">
			<xsl:choose>
				<xsl:when test="tia:tia_BurgerlijkeStaatTekst">
					<xsl:value-of select="tia:tia_BurgerlijkeStaatTekst" />
				</xsl:when>
				<xsl:when test="tia:burgerlijkeStaatTekst">
					<xsl:value-of select="tia:burgerlijkeStaatTekst" />
				</xsl:when>
				<xsl:otherwise><xsl:text /></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="partnerGegevens">
			<xsl:choose>
				<xsl:when test="tia:tia_PartnerGegevens">
					<xsl:value-of select="tia:tia_PartnerGegevens"/>
				</xsl:when>
				<xsl:when test="tia:partnerGegevens">
					<xsl:value-of select="tia:partnerGegevens"/>
				</xsl:when>
			</xsl:choose>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="contains(translate($marital-status-text-copy, $upper, $lower), '{tia_partnergegevens}') and not(contains(translate($marital-status-text-copy, $upper, $lower), '{tia_burgerlijkestaattekst}'))">
				<xsl:value-of select="concat(substring-before($marital-status-text-copy, '{tia_PartnerGegevens}'), $partnerGegevens, substring-after($marital-status-text-copy, '{tia_PartnerGegevens}'))"/>
			</xsl:when>		
			<xsl:when test="contains(translate($marital-status-text-copy, $upper, $lower), '{tia_burgerlijkestaattekst}') and not(contains(translate($marital-status-text-copy, $upper, $lower), '{tia_partnergegevens}')) and not(contains(translate($marital-status-text-copy, $upper, $lower), '{tia_burgerlijkestaatland}'))"> 
				<xsl:value-of select="concat(substring-before($marital-status-text-copy, '{tia_BurgerlijkeStaatTekst}'), $burgerlijkeStaatTekst, substring-after($marital-status-text-copy, '{tia_BurgerlijkeStaatTekst}'))"/>
			</xsl:when>
			<xsl:when test="contains(translate($marital-status-text-copy, $upper, $lower), '{tia_partnergegevens}') and contains(translate($marital-status-text-copy, $upper, $lower), '{tia_burgerlijkestaattekst}')">
				<xsl:variable name="middleText">
					<xsl:value-of select="substring-after(substring-before($marital-status-text-copy, '{tia_PartnerGegevens}'), '{tia_BurgerlijkeStaatTekst}')"></xsl:value-of>
				</xsl:variable>
				<xsl:value-of select="concat(substring-before($marital-status-text-copy, '{tia_BurgerlijkeStaatTekst}'), $burgerlijkeStaatTekst, $middleText,$partnerGegevens, substring-after($marital-status-text-copy, '{tia_PartnerGegevens}'))"/>
			</xsl:when>
			<xsl:when test="contains(translate($marital-status-text-copy, $upper, $lower), '{tia_burgerlijkestaattekst}') and contains(translate($marital-status-text-copy, $upper, $lower), '{tia_burgerlijkestaatland}')">
				<xsl:variable name="middleText">
					<xsl:value-of select="substring-after(substring-before($marital-status-text-copy, '{tia_BurgerlijkeStaatLand}'), '{tia_BurgerlijkeStaatTekst}')"></xsl:value-of>
				</xsl:variable>
				<xsl:value-of select="concat(substring-before($marital-status-text-copy, '{tia_BurgerlijkeStaatTekst}'), $burgerlijkeStaatTekst, $middleText, $burgerlijkestaatland, substring-after($marital-status-text-copy, '{tia_BurgerlijkeStaatLand}'))"/>
			</xsl:when>
			<xsl:when test="not(contains(translate($marital-status-text-copy, $upper, $lower), '{tia_partnergegevens}')) and not(contains(translate($marital-status-text-copy, $upper, $lower), '{tia_burgerlijkestaattekst}')) and not(contains(translate($marital-status-text-copy, $upper, $lower), '{tia_burgerlijkestaatland}'))">
				<xsl:value-of select="$marital-status-text-copy"/>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	
	<!--
	*********************************************************
	Mode: do-marital-status-partners
	*********************************************************
	Public: yes

	Identity transform: no

	Description: Marital status of partners.

	Input: tia:Gevolmachtigde or tia:IMKAD_Persoon

	Params: none

	Output: text

	Calls:
	none

	Called by:
	(mode) do-person-pair-partner
	(mode) do-person-pair-partner-representative
	(mode) do-legal-representative
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:Gevolmachtigde | tia:IMKAD_Persoon" mode="do-marital-status-partners">
		<xsl:variable name="marital-status-text" >
			<xsl:choose>
				<xsl:when test="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_burgerlijkestaattekstpartners']">
					<xsl:value-of select="$keuzetekstenTbBurgelijkeStaat/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_burgerlijkestaattekstpartners']/tia:tekst[
					position() = translate(normalize-space(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_burgerlijkestaattekstpartners']/tia:tekst), $upper, $lower)]" />
				</xsl:when>
				<xsl:when test="tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_burgerlijkestaattekstpartners']">
					<xsl:value-of select="$keuzetekstenTbBurgelijkeStaat/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_burgerlijkestaattekstpartners']/tia:tekst[
					position() = translate(normalize-space(current()/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_burgerlijkestaattekstpartners']/tia:tekst), $upper, $lower)]" />
				</xsl:when>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="burgerlijkestaatland">
			<xsl:choose>
				<xsl:when test="tia:tia_BurgerlijkeStaatLand">
					<xsl:value-of select="tia:tia_BurgerlijkeStaatLand" />
				</xsl:when>
				<xsl:when test="tia:burgerlijkeStaatLand">
					<xsl:value-of select="tia:burgerlijkeStaatLand" />
				</xsl:when>
				<xsl:otherwise><xsl:text /></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="burgerlijkeStaatTekst">
			<xsl:choose>
				<xsl:when test="tia:tia_BurgerlijkeStaatTekst">
					<xsl:value-of select="tia:tia_BurgerlijkeStaatTekst" />
				</xsl:when>
				<xsl:when test="tia:burgerlijkeStaatTekst">
					<xsl:value-of select="tia:burgerlijkeStaatTekst" />
				</xsl:when>
				<xsl:otherwise><xsl:text /></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
			
		<xsl:choose>
			<xsl:when test="contains(translate($marital-status-text, $upper, $lower), '{tia_burgerlijkestaattekst}') and not(contains(translate($marital-status-text, $upper, $lower), '{tia_burgerlijkestaatland}'))">
				<xsl:value-of select="concat(substring-before($marital-status-text, '{tia_BurgerlijkeStaatTekst}'), $burgerlijkeStaatTekst, substring-after($marital-status-text, '{tia_BurgerlijkeStaatTekst}'))"/>
			</xsl:when>
			<xsl:when test="contains(translate($marital-status-text, $upper, $lower), '{tia_burgerlijkestaattekst}') and contains(translate($marital-status-text, $upper, $lower), '{tia_burgerlijkestaatland}')">
				<xsl:variable name="middleText">
					<xsl:value-of select="substring-after(substring-before($marital-status-text, '{tia_BurgerlijkeStaatLand}'), '{tia_BurgerlijkeStaatTekst}')"></xsl:value-of>
				</xsl:variable>
				<xsl:value-of select="concat(substring-before($marital-status-text, '{tia_BurgerlijkeStaatTekst}'), $burgerlijkeStaatTekst, $middleText, $burgerlijkestaatland, substring-after($marital-status-text, '{tia_BurgerlijkeStaatLand}'))"/>
			</xsl:when>
			<xsl:otherwise><xsl:value-of select="$marital-status-text"/></xsl:otherwise>

		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>
