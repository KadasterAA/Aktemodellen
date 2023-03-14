<?xml version="1.0" encoding="UTF-8"?>
<!--
*********************************************************
Stylesheet: tekstblok_registergoed.xsl
Version: 1.17
*********************************************************
Description:
Registered object text block.

Public:
(mode) do-registered-object
(mode) do-cadastral-identification
(name) processRights

Private:
(mode) do-parcel-data
(mode) do-apartment-data
(mode) do-network-data
(mode) do-ship-data
(mode) do-airplane-data
(mode) do-parcel-size
(mode) do-object-location
(mode) do-object-address
(mode) do-propulsion
(name) isLastProcessedRight
-->
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
	xmlns:tia="http://www.kadaster.nl/schemas/KIK/TIA_Algemeen"
	xmlns:kef="nl.kadaster.xslt.XslExtensionFunctions"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	exclude-result-prefixes="tia kef xsl"
	version="1.0">

	<!--
	*********************************************************
	Mode: do-registered-object
	*********************************************************
	Public: yes

	Identity transform: no

	Description: Registered object main template.

	Input: tia:IMKAD_ZakelijkRecht

	Params: none

	Output: text with hard breaks (<br/>)

	Calls:
	(mode) do-parcel-data
	(mode) do-apartment-data
	(mode) do-network-data
	(mode) do-ship-data
	(mode) do-airplane-data
	(mode) do-propulsion

	Called by:
	(mode) do-deed
	(mode) do-registered-objects-deed-of-transfer
	(mode) do-properties
	(mode) do-bridging-mortgage
	(mode) do-renouncement-of-mortgage-right
	(mode) do-termination-of-mortgage-right
	-->

	<!--
	**** matching template ********************************************************************************
	**** PARCEL *******************************************************************************************
	-->
	<xsl:template match="tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel]" mode="do-registered-object">
		<!-- Grab all parcels (tia:IMKAD_Perceel nodes) with same data -->
		<xsl:variable name="sameObjects" select="following-sibling::tia:IMKAD_ZakelijkRecht[
			((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen']/tia:tekst
					= current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen']/tia:tekst)
				or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen'])
					and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen'])))
			and tia:aardVerkregen = current()/tia:aardVerkregen
			and normalize-space(tia:aardVerkregen) != ''
			and ((tia:tia_Aantal_BP_Rechten
					= current()/tia:tia_Aantal_BP_Rechten)
				or (not(tia:tia_Aantal_BP_Rechten)
					and not(current()/tia:tia_Aantal_BP_Rechten)))
			and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven']/tia:tekst
					= current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven']/tia:tekst)
				or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven'])
					and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven'])))
			and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom']/tia:tekst
					= current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom']/tia:tekst)
				or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom'])
					and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom'])))
			and ((tia:aandeelInRecht/tia:teller	= current()/tia:aandeelInRecht/tia:teller 
				and tia:aandeelInRecht/tia:noemer = current()/tia:aandeelInRecht/tia:noemer)
				or (not(tia:aandeelInRecht)
					and not(current()/tia:aandeelInRecht)))		
			and tia:IMKAD_Perceel[
				tia:tia_OmschrijvingEigendom
					= current()/tia:IMKAD_Perceel/tia:tia_OmschrijvingEigendom
				and normalize-space(tia:tia_OmschrijvingEigendom) != ''
				and ((tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid']/tia:tekst
						= current()/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid']/tia:tekst)
					or (not(tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid'])
						and not(current()/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid'])))
				and ((tia:tia_SplitsingsverzoekOrdernummer
						= current()/tia:IMKAD_Perceel/tia:tia_SplitsingsverzoekOrdernummer)
					or (not(tia:tia_SplitsingsverzoekOrdernummer)
						and not(current()/tia:IMKAD_Perceel/tia:tia_SplitsingsverzoekOrdernummer)))
				and tia:kadastraleAanduiding/tia:gemeente
					= current()/tia:IMKAD_Perceel/tia:kadastraleAanduiding/tia:gemeente
				and normalize-space(tia:kadastraleAanduiding/tia:gemeente) != ''
				and tia:kadastraleAanduiding/tia:sectie
					= current()/tia:IMKAD_Perceel/tia:kadastraleAanduiding/tia:sectie
				and normalize-space(tia:kadastraleAanduiding/tia:sectie) != ''
				and tia:IMKAD_OZLocatie/tia:ligging
					= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:ligging
				and normalize-space(tia:IMKAD_OZLocatie/tia:ligging) != ''
				and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer
					= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer)
					or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer)
						and not(current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer)))
				and	((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter
						= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter)
					or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter)
						and not(current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter)))
				and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging
						= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging)
					or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging)
						and not(current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging)))
				and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode
						= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode)
					or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode)
						and not(current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode)))
				and tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam
					= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam
				and normalize-space(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam) != ''
				and tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam
					= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam
				and normalize-space(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam) != '']]/tia:IMKAD_Perceel"/>
		<xsl:variable name="respectively">
			<xsl:choose>
				<xsl:when test="count($sameObjects) > 0">
					<xsl:text>respectievelijk </xsl:text>
				</xsl:when>
				<xsl:otherwise><xsl:text/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="parcel-initial-text" select="tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space(current()/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid']/tia:tekst), $upper, $lower)]), $upper, $lower)]" />
		<xsl:choose>
			<xsl:when test="translate($parcel-initial-text, $upper, $lower) != 'met bestemming mandeligheid'">
				<xsl:apply-templates select="tia:IMKAD_Perceel" mode="do-parcel-data">
					<xsl:with-param name="sameObjects" select="$sameObjects"/>
					<xsl:with-param name="parcel-initial-text" select="$parcel-initial-text"/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="tia:IMKAD_Perceel" mode="do-parcel-data">
					<xsl:with-param name="sameObjects" select="$sameObjects"/>
				</xsl:apply-templates>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:text> </xsl:text>
		<xsl:choose>
			<xsl:when test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen']/tia:tekst, $upper, $lower) = 'true'">
				<xsl:text>waaraan door het kadaster een voorlopige kadastrale grens en -oppervlakte is toegekend, </xsl:text>
				<xsl:value-of select="$respectively"/>
				<xsl:text>ter grootte van ongeveer </xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$respectively"/>
				<xsl:text>ter grootte van </xsl:text>
			</xsl:otherwise>
		</xsl:choose>
		<!-- Current parcel size -->
		<xsl:apply-templates select="tia:IMKAD_Perceel/tia:grootte" mode="do-parcel-size"/>
		<!-- Same parcel sizes, if any -->
		<xsl:if test="$sameObjects">
			<xsl:for-each select="$sameObjects/tia:grootte">
				<xsl:choose>
					<xsl:when test="position() = last()">
						<xsl:text> en </xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>, </xsl:text>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:apply-templates select="." mode="do-parcel-size"/>
			</xsl:for-each>
		</xsl:if>
		<xsl:if test="translate($parcel-initial-text, $upper, $lower) = 'met bestemming mandeligheid'">
			<xsl:text> </xsl:text>
			<xsl:value-of select="$parcel-initial-text"/>
		</xsl:if>
	</xsl:template>

	<!--
	**** matching template ********************************************************************************
	**** APARTMENT ****************************************************************************************
	-->
	<xsl:template match="tia:IMKAD_ZakelijkRecht[tia:IMKAD_Appartementsrecht]" mode="do-registered-object">
		<xsl:apply-templates select="tia:IMKAD_Appartementsrecht" mode="do-apartment-data"/>
	</xsl:template>

	<!--
	**** matching template ********************************************************************************
	**** NETWORK ******************************************************************************************
	-->
	<xsl:template match="tia:IMKAD_ZakelijkRecht[tia:IMKAD_Leidingnetwerk]" mode="do-registered-object">
		<xsl:apply-templates select="tia:IMKAD_Leidingnetwerk" mode="do-network-data"/>
	</xsl:template>

	<!--
	**** matching template ********************************************************************************
	**** SHIP *********************************************************************************************
	-->
	<xsl:template match="tia:IMKAD_ZakelijkRecht[tia:Schip]" mode="do-registered-object">
		<xsl:apply-templates select="tia:Schip" mode="do-ship-data"/>
		<xsl:if test="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voortstuwing']">
			<xsl:text> </xsl:text>
			<xsl:value-of select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voortstuwing']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
				translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voortstuwing']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
				translate(normalize-space(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voortstuwing']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
		</xsl:if>
		<xsl:if test="tia:Schip/tia:beschrijvingVoortstuwingswerktuigen">
			<xsl:text>:</xsl:text>
			<xsl:apply-templates select="tia:Schip/tia:beschrijvingVoortstuwingswerktuigen" mode="do-propulsion"/>
		</xsl:if>
		<xsl:if test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_scheepstoebehoren']/tia:tekst, $upper, $lower) = 'true'">
			<xsl:text>,</xsl:text>
			<xsl:choose>
				<xsl:when test="tia:Schip/tia:beschrijvingVoortstuwingswerktuigen">
					<br/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text> </xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:value-of select="normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_scheepstoebehoren']/tia:tekst)"/>
		</xsl:if>
	</xsl:template>

	<!--
	**** matching template ********************************************************************************
	**** AIRPLANE *****************************************************************************************
	-->
	<xsl:template match="tia:IMKAD_ZakelijkRecht[tia:Luchtvaartuig]" mode="do-registered-object">
		<xsl:apply-templates select="tia:Luchtvaartuig" mode="do-airplane-data"/>
	</xsl:template>

	<!--
	*********************************************************
	Mode: do-cadastral-identification
	*********************************************************
	Public: yes

	Identity transform: no

	Description: Cadastral identification.

	Input: tia:kadastraleAanduiding

	Params: sameObjects - node set containing tia:IMKAD_Perceel or tia:IMKAD_Appartementsrecht nodes with the same data; default is empty node set
			boldLabel - indicates if "kadastraal bekend" should be bold; default is true
			displayMunicipalityLabel - indicates if label "gemeente" should be displayed; default is true
			numberLabelAsParcel - used for apartments, displays text "nummer" instead of "complexaanduiding" when true
			position - position of currently processed tia:IMKAD_Perceel/tia:IMKAD_Appartementsrecht/tia:IMKAD_Leidingnetwerk

	Output: text

	Calls:
	none

	Called by:
	(mode) do-parcel-data
	(mode) do-apartment-data
	(mode) do-network-data
	(mode) do-easements
	(mode) do-qualitative-obligations
	(mode) do-common-ownership
	(name) additionCancellationOfRestrictionTextBlock
	-->

	<!--
	**** matching template ********************************************************************************
	**** PARCEL & NETWORK  ********************************************************************************
	-->
	<xsl:template match="tia:kadastraleAanduiding[parent::tia:IMKAD_Perceel
							or parent::tia:IMKAD_Leidingnetwerk]" mode="do-cadastral-identification">
		<xsl:param name="sameObjects" select="self::node()[false()]"/>
		<xsl:param name="boldLabel" select="'true'"/>
		<xsl:param name="displayMunicipalityLabel" select="'true'"/>
		<xsl:param name="numberLabelAsParcel" select="'false'"/>
		<xsl:param name="position" select="'1'"/>
		
		<xsl:if test="$position = '1'">
		<xsl:choose>
			<xsl:when test="translate($boldLabel, $upper, $lower) = 'true'">
				<strong>
					<xsl:text>kadastraal bekend </xsl:text>
				</strong>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>kadastraal bekend </xsl:text>
			</xsl:otherwise>
		</xsl:choose>
		</xsl:if>
		<xsl:if test="translate($displayMunicipalityLabel, $upper, $lower) = 'true'">
			<xsl:text>gemeente </xsl:text>
		</xsl:if>
		<xsl:value-of select="tia:gemeente"/>
		<xsl:text>, sectie </xsl:text>
		<xsl:value-of select="tia:sectie"/>
		<xsl:text>, nummer</xsl:text>
		<xsl:if test="$sameObjects">
			<xsl:text>s</xsl:text>
		</xsl:if>
		<xsl:text> </xsl:text>
		<xsl:value-of select="tia:perceelnummer"/>
		<xsl:if test="$sameObjects/tia:kadastraleAanduiding/tia:perceelnummer">
			<xsl:for-each select="$sameObjects/tia:kadastraleAanduiding/tia:perceelnummer">
				<xsl:choose>
					<xsl:when test="position() = last()">
						<xsl:text> en </xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>, </xsl:text>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:value-of select="."/>
			</xsl:for-each>
		</xsl:if>
	</xsl:template>

	<!--
	**** matching template ********************************************************************************
	****     APARTMENT     ********************************************************************************
	-->
	<xsl:template match="tia:kadastraleAanduiding[parent::tia:IMKAD_Appartementsrecht]" mode="do-cadastral-identification">
		<xsl:param name="sameObjects" select="self::node()[false()]"/>
		<xsl:param name="boldLabel" select="'true'"/>
		<xsl:param name="displayMunicipalityLabel" select="'true'"/>
		<xsl:param name="numberLabelAsParcel" select="'false'"/>
		<xsl:param name="position" select="'1'"/>
		
		<xsl:if test="$position = '1'">
		<xsl:choose>
			<xsl:when test="translate($boldLabel, $upper, $lower) = 'true'">
				<strong>
					<xsl:text>kadastraal bekend </xsl:text>
				</strong>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>kadastraal bekend </xsl:text>
			</xsl:otherwise>
		</xsl:choose>
		</xsl:if>
		<xsl:if test="translate($displayMunicipalityLabel, $upper, $lower) = 'true'">
			<xsl:text>gemeente </xsl:text>
		</xsl:if>
		<xsl:value-of select="tia:gemeente"/>
		<xsl:text>, sectie </xsl:text>
		<xsl:value-of select="tia:sectie"/>
		<xsl:choose>
			<xsl:when test="translate($numberLabelAsParcel, $upper, $lower) = 'true'">
				<xsl:text>, nummer </xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>, complexaanduiding </xsl:text>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:value-of select="tia:perceelnummer"/>
   		<xsl:text>, </xsl:text>
   		<xsl:choose>
			<xsl:when test="$sameObjects">
				<xsl:text>appartementsindices </xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>appartementsindex </xsl:text>
			</xsl:otherwise>
		</xsl:choose>
   		<xsl:value-of select="tia:appartementsindex"/>
		<xsl:if test="$sameObjects/tia:kadastraleAanduiding/tia:appartementsindex">
			<xsl:for-each select="$sameObjects/tia:kadastraleAanduiding/tia:appartementsindex">
				<xsl:choose>
					<xsl:when test="position() = last()">
						<xsl:text> en </xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>, </xsl:text>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:value-of select="."/>
			</xsl:for-each>
		</xsl:if>
	</xsl:template>

	<!--
	*********************************************************
	Mode: do-parcel-data
	*********************************************************
	Public: no

	Identity transform: no

	Description: Parcel object.

	Input: tia:IMKAD_Perceel

	Params: sameObjects - node set containing tia:IMKAD_Perceel nodes with the same data
			parcel-initial-text - text that should be printed at the beginning of the paragraph

	Output: text

	Calls:
	(mode) do-object-location
	(mode) do-cadastral-identification

	Called by:
	(mode) do-registered-object
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Perceel" mode="do-parcel-data">
		<xsl:param name="sameObjects"/>
		<xsl:param name="parcel-initial-text" select="''"/>
		
		<xsl:if test="$parcel-initial-text != ''">
			<xsl:value-of select="$parcel-initial-text"/>
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:value-of select="tia:tia_OmschrijvingEigendom"/>
		<xsl:text> </xsl:text>
		<xsl:apply-templates select="tia:IMKAD_OZLocatie" mode="do-object-location"/>
		<xsl:text>, </xsl:text>
		<xsl:apply-templates select="tia:kadastraleAanduiding" mode="do-cadastral-identification">
			<xsl:with-param name="sameObjects" select="$sameObjects"/>
		</xsl:apply-templates>
	</xsl:template>

	<!--
	*********************************************************
	Mode: do-apartment-data
	*********************************************************
	Public: no

	Identity transform: no

	Description: Apartment object.

	Input: tia:IMKAD_Appartementsrecht

	Params: none

	Output: text

	Calls:
	(mode) do-object-location
	(mode) do-cadastral-identification

	Called by:
	(mode) do-registered-object
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Appartementsrecht" mode="do-apartment-data">
		<xsl:value-of select="tia:tia_OmschrijvingEigendom"/>
		<xsl:text> </xsl:text>
		<xsl:apply-templates select="tia:IMKAD_OZLocatie" mode="do-object-location"/>
		<xsl:text>, </xsl:text>
		<xsl:apply-templates select="tia:kadastraleAanduiding" mode="do-cadastral-identification"/>
	</xsl:template>

	<!--
	*********************************************************
	Mode: do-network-data
	*********************************************************
	Public: no

	Identity transform: no

	Description: Network object.

	Input: tia:IMKAD_Leidingnetwerk

	Params: none

	Output: text

	Calls:
	(mode) do-cadastral-identification

	Called by:
	(mode) do-registered-object
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Leidingnetwerk" mode="do-network-data">
		<xsl:value-of select="tia:tia_Typering"/>
		<xsl:text> </xsl:text>
		<xsl:apply-templates select="tia:kadastraleAanduiding" mode="do-cadastral-identification">
			<xsl:with-param name="displayMunicipalityLabel" select="'false'"/>
		</xsl:apply-templates>
	</xsl:template>

	<!--
	*********************************************************
	Mode: do-ship-data
	*********************************************************
	Public: no

	Identity transform: no

	Description: Ship object.

	Input: tia:Schip

	Params: none

	Output: text with hard breaks (<br/>)

	Calls:
	none

	Called by:
	(mode) do-registered-object
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:Schip" mode="do-ship-data">
		<xsl:variable name="eenheid-part">
			<xsl:choose>
				<xsl:when test="translate(tia:brutoInhoud/tia:eenheid, $upper, $lower) = 'kubieke meter (m3)'"><xsl:text>liter</xsl:text></xsl:when>
				<xsl:when test="translate(tia:brutoInhoud/tia:eenheid, $upper, $lower) = 'ton'"><xsl:text>kilo</xsl:text></xsl:when>
				<xsl:otherwise><xsl:text/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:value-of select="tia:typering"/>
		<br/>
		<xsl:text>genaamd </xsl:text>
		<xsl:value-of select="tia:naam"/>
		<xsl:if test="tia:oudeNaam and normalize-space(tia:oudeNaam) != ''">
			<xsl:text>, voorheen genaamd </xsl:text>
			<xsl:value-of select="tia:oudeNaam"/>
		</xsl:if>
		<xsl:text>, met het brandmerk </xsl:text>
		<xsl:value-of select="tia:brandmerk/tia:getal"/>
		<xsl:text> </xsl:text>
		<xsl:value-of select="tia:brandmerk/tia:rubriek"/>
		<xsl:text> </xsl:text>
		<xsl:value-of select="tia:brandmerk/tia:aanduidingKadastervestiging"/>
		<xsl:text> </xsl:text>
		<xsl:value-of select="tia:brandmerk/tia:jaar"/>
		<xsl:text>, gebouwd</xsl:text>
		<xsl:if test="tia:naamGebouwdDoor and normalize-space(tia:naamGebouwdDoor) != ''">
			<xsl:text> door </xsl:text>
			<xsl:value-of select="tia:naamGebouwdDoor"/>
		</xsl:if>
		<xsl:text> in </xsl:text>
		<xsl:value-of select="tia:plaatsGebouwdIn"/>
		<xsl:if test="tia:landGebouwdIn and normalize-space(tia:landGebouwdIn) != ''">
			<xsl:text> </xsl:text>
			<xsl:value-of select="tia:landGebouwdIn"/>
		</xsl:if>
		<xsl:text>, bouwjaar </xsl:text>
		<xsl:value-of select="tia:bouwjaar"/>
		<xsl:if test="tia:brutoInhoud">
			<xsl:variable name="sizeBeforeDecimal">
                <xsl:choose>
                    <xsl:when test="contains(tia:brutoInhoud/tia:getal, '.')">
                        <xsl:value-of select="substring-before(tia:brutoInhoud/tia:getal, '.')"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="tia:brutoInhoud/tia:getal"/>
                    </xsl:otherwise>
                </xsl:choose>
			</xsl:variable>
			<xsl:variable name="sizeAfterDecimal">
                <xsl:choose>
                    <xsl:when test="contains(tia:brutoInhoud/tia:getal, '.')">
                        <xsl:value-of select="substring-after(tia:brutoInhoud/tia:getal, '.')"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="''"/>
                    </xsl:otherwise>
                </xsl:choose>
			</xsl:variable>
			<xsl:text> met een </xsl:text>
			<xsl:value-of select="tia:brutoInhoud/tia:soortInhoud"/>
			<xsl:text> van </xsl:text>
			<xsl:if test="string-length($sizeBeforeDecimal) > 0">
				<xsl:value-of select="kef:convertNumberToText(string($sizeBeforeDecimal))"/>
				<xsl:text> </xsl:text>
			</xsl:if>
			<xsl:value-of select="tia:brutoInhoud/tia:eenheid"/>
			<xsl:if test="string-length($sizeAfterDecimal) > 0">
				<xsl:text> en </xsl:text>
				<xsl:value-of select="kef:convertNumberToText(string($sizeAfterDecimal))"/>
				<xsl:text> </xsl:text>
				<xsl:value-of select="$eenheid-part"/>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<!--
	*********************************************************
	Mode: do-airplane-data
	*********************************************************
	Public: no

	Identity transform: no

	Description: Airplane object.

	Input: tia:Luchtvaartuig

	Params: none

	Output: text

	Calls:
	(mode) do-propulsion

	Called by:
	(mode) do-registered-object
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:Luchtvaartuig" mode="do-airplane-data">
		<xsl:text>het luchtvaartuig met het nationaliteits- en inschrijvingskenmerk PH </xsl:text>
		<xsl:value-of select="tia:inschrijvingskenmerk"/>
		<xsl:text> met een maximaal toegelaten startmassa van </xsl:text>
		<xsl:value-of select="tia:startmassa"/>
		<xsl:text> kilogram en </xsl:text>
		<xsl:choose>
			<xsl:when test="count(tia:beschrijvingVoortstuwingswerktuigen) = 1">
				<xsl:text>het volgende voortstuwingswerktuig:</xsl:text>
			</xsl:when>
			<xsl:when test="count(tia:beschrijvingVoortstuwingswerktuigen) > 1">
				<xsl:text>de volgende voortstuwingswerktuigen:</xsl:text>
			</xsl:when>
		</xsl:choose>
		<xsl:apply-templates select="tia:beschrijvingVoortstuwingswerktuigen" mode="do-propulsion"/>
	</xsl:template>

	<!--
	*********************************************************
	Mode: do-parcel-size
	*********************************************************
	Public: no

	Identity transform: no

	Description: Parcel size.

	Input: tia:grootte

	Params: none

	Output: text

	Calls:
	none

	Called by:
	(mode) do-registered-object
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:grootte" mode="do-parcel-size">
		<!-- example: 11234 ca = 1 hectare, 12 are en 34 ca -->
		<xsl:variable name="hectare" select="floor(. div 10000)"/>
		<xsl:variable name="are" select="floor(. div 100 mod 100)"/>
		<xsl:variable name="centiare" select="floor(. mod 100)"/>
		<!-- more than 0 hectare -->
		<xsl:if test="$hectare > 0">
			<xsl:value-of select="kef:convertNumberToText(string($hectare))"/>
			<xsl:text> hectare</xsl:text>
		</xsl:if>
		<!-- more than 0 are -->
		<xsl:if test="$are > 0">
			<xsl:if test="$hectare > 0">
				<xsl:choose>
					<xsl:when test="$centiare > 0">
						<xsl:text>, </xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text> en </xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
			<xsl:value-of select="kef:convertNumberToText(string($are))"/>
			<xsl:text> are</xsl:text>
		</xsl:if>
		<!-- more than 0 centiare -->
		<xsl:if test="$centiare > 0">
			<xsl:if test="$hectare > 0 or $are > 0">
				<xsl:text> en </xsl:text>
			</xsl:if>
			<xsl:value-of select="kef:convertNumberToText(string($centiare))"/>
			<xsl:text> centiare</xsl:text>
		</xsl:if>
		<xsl:text> (</xsl:text>
		<!-- more than 0 hectare -->
		<xsl:if test="$hectare > 0">
			<xsl:value-of select="$hectare"/>
			<xsl:text> ha</xsl:text>
			<xsl:if test="$are > 0 or $centiare > 0">
				<xsl:text> </xsl:text>
			</xsl:if>
		</xsl:if>
		<!-- more than 0 are -->
		<xsl:if test="$are > 0">
			<xsl:value-of select="$are"/>
			<xsl:text> a</xsl:text>
			<xsl:if test="$centiare > 0">
				<xsl:text> </xsl:text>
			</xsl:if>
		</xsl:if>
		<!-- more than 0 centiare -->
		<xsl:if test="$centiare > 0">
			<xsl:value-of select="$centiare"/>
			<xsl:text> ca</xsl:text>
		</xsl:if>
		<xsl:text>)</xsl:text>
	</xsl:template>

	<!--
	*********************************************************
	Mode: do-object-location
	*********************************************************
	Public: no

	Identity transform: no

	Description: Object location.

	Input: tia:IMKAD_OZLocatie

	Params: none

	Output: text

	Calls:
	(mode) do-object-address

	Called by:
	(mode) do-parcel-data
	(mode) do-apartment-data
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_OZLocatie" mode="do-object-location">
		<xsl:text>gelegen </xsl:text>
		<xsl:value-of select="tia:ligging"/>
		<xsl:text> </xsl:text>
		<xsl:apply-templates select="tia:adres" mode="do-object-address"/>
	</xsl:template>

	<!--
	*********************************************************
	Mode: do-object-address
	*********************************************************
	Public: no

	Identity transform: no

	Description: Object address.

	Input: tia:adres

	Params: none

	Output: text

	Calls:
	none

	Called by:
	(mode) do-object-location
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:adres" mode="do-object-address">
		<xsl:if test="tia:BAG_NummerAanduiding/tia:postcode
				and normalize-space(tia:BAG_NummerAanduiding/tia:postcode) != ''">
			<!-- Insert space between numbers and letters of post code -->
			<xsl:value-of select="concat(normalize-space(substring(tia:BAG_NummerAanduiding/tia:postcode, 1, 4)), ' ',
				normalize-space(substring(tia:BAG_NummerAanduiding/tia:postcode, 5)))"/>
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:value-of select="tia:BAG_Woonplaats/tia:woonplaatsNaam"/>
		<xsl:text>, </xsl:text>
		<xsl:value-of select="tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam"/>
		<xsl:if test="tia:BAG_NummerAanduiding/tia:huisnummer
				and normalize-space(tia:BAG_NummerAanduiding/tia:huisnummer) != ''">
			<xsl:text> </xsl:text>
			<xsl:value-of select="tia:BAG_NummerAanduiding/tia:huisnummer"/>
		</xsl:if>
		<xsl:if test="tia:BAG_NummerAanduiding/tia:huisletter
				and normalize-space(tia:BAG_NummerAanduiding/tia:huisletter) != ''">
			<xsl:text> </xsl:text>
			<xsl:value-of select="tia:BAG_NummerAanduiding/tia:huisletter"/>
		</xsl:if>
		<xsl:if test="tia:BAG_NummerAanduiding/tia:huisnummertoevoeging
				and normalize-space(tia:BAG_NummerAanduiding/tia:huisnummertoevoeging) != ''">
			<xsl:text> </xsl:text>
			<xsl:value-of select="tia:BAG_NummerAanduiding/tia:huisnummertoevoeging"/>
		</xsl:if>
	</xsl:template>

	<!--
	*********************************************************
	Mode: do-propulsion
	*********************************************************
	Public: no

	Identity transform: no

	Description: Propulsion.

	Input: tia:beschrijvingVoortstuwingswerktuigen

	Params: none

	Output: text with hard breaks (<br/>)

	Calls:
	none

	Called by:
	(mode) do-ship-data
	(mode) do-airplane-data
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:beschrijvingVoortstuwingswerktuigen" mode="do-propulsion">
		<br/>
		<xsl:text>Merk: </xsl:text>
		<xsl:value-of select="tia:merk"/>
		<br/>
		<xsl:text>Motornummer: </xsl:text>
		<xsl:value-of select="tia:motornummer"/>
		<br/>
		<xsl:if test="tia:plaatsMotor and normalize-space(tia:plaatsMotor) != ''">
			<xsl:text>Plaats motor: </xsl:text>
			<xsl:value-of select="tia:plaatsMotor"/>
			<br/>
		</xsl:if>
		<xsl:text>Sterkte: </xsl:text>
		<xsl:value-of select="tia:sterkte"/>
		<xsl:text> PK</xsl:text>
	</xsl:template>
	
	<!--
	*********************************************************
	Name: processRights
	*********************************************************
	Public: yes

	Discription: Prints data concerning rights. If some parcels are similar, they are printed together in the same row.

	Params: positionOfProcessedRight - Position of processed right in list of rights.
			position - Counter used to determine order number (position) of printed right's data.
			registeredObjects - Root element that contains rights.
			punctuationMark - Punctuation mark used between two printed rights.
			lastElementsPunctuationMark - Punctuation mark used after last printed right.

	Output: XHTML structure

	Calls:
	(mode) do-right
	(mode) do-registered-object
	(name) processRights (reccuring)
	(name) indent
	(name) isLastProcessedRight

	Called by:
	(mode) do-rights
	(mode) do-rights-bridging
	(mode) do-deed
	(mode) do-registered-objects-deed-of-transfer
	(mode) do-bridging-mortgage
	-->

	<!--
	**** named template ********************************************************************************
	-->
	<xsl:template name="processRights">
		<xsl:param name="positionOfProcessedRight"/>
		<xsl:param name="position"/>
		<xsl:param name="registeredObjects"/>
		<xsl:param name="punctuationMark" select="';'"/>
		<xsl:param name="lastElementsPunctuationMark" select="''"/>
		<xsl:param name="indentLevel" select="number('0')"/>
		<xsl:variable name="processedRight" select="$registeredObjects/tia:IMKAD_ZakelijkRecht[$positionOfProcessedRight]"/>
		<xsl:variable name="isLastProcessedRight">
			<xsl:if test="normalize-space($lastElementsPunctuationMark) != ''">
				<xsl:call-template name="isLastProcessedRight">
					<xsl:with-param name="positionOfProcessedRight" select="$positionOfProcessedRight + 1"/>
					<xsl:with-param name="registeredObjects" select="$registeredObjects"/>
				</xsl:call-template>
			</xsl:if>
		</xsl:variable>
		
		<xsl:choose>
			<!-- Skip parcel if already processed by previous with the same data -->
			<xsl:when test="not($processedRight/tia:IMKAD_Perceel and $processedRight/preceding-sibling::tia:IMKAD_ZakelijkRecht[
				((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen']/tia:tekst
					= $processedRight/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen']/tia:tekst)
					or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen'])
						and not($processedRight/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen'])))
				and tia:aardVerkregen = $processedRight/tia:aardVerkregen
				and normalize-space(tia:aardVerkregen) != ''
				and ((tia:tia_Aantal_BP_Rechten
						= $processedRight/tia:tia_Aantal_BP_Rechten)
					or (not(tia:tia_Aantal_BP_Rechten)
						and not($processedRight/tia:tia_Aantal_BP_Rechten)))
				and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven']/tia:tekst
						= $processedRight/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven']/tia:tekst)
					or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven'])
						and not($processedRight/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven'])))
				and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom']/tia:tekst
						= $processedRight/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom']/tia:tekst)
					or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom'])
						and not($processedRight/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom'])))
				and ((tia:aandeelInRecht/tia:teller	= $processedRight/tia:aandeelInRecht/tia:teller 
					and tia:aandeelInRecht/tia:noemer = $processedRight/tia:aandeelInRecht/tia:noemer)
					or (not(tia:aandeelInRecht)
						and not($processedRight/tia:aandeelInRecht)))
				and tia:IMKAD_Perceel[
					tia:tia_OmschrijvingEigendom
						= $processedRight/tia:IMKAD_Perceel/tia:tia_OmschrijvingEigendom
					and normalize-space(tia:tia_OmschrijvingEigendom) != ''
					and ((tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid']/tia:tekst
							= $processedRight/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid']/tia:tekst)
						or (not(tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid'])
							and not($processedRight/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid'])))
					and ((tia:tia_SplitsingsverzoekOrdernummer
							= $processedRight/tia:IMKAD_Perceel/tia:tia_SplitsingsverzoekOrdernummer)
						or (not(tia:tia_SplitsingsverzoekOrdernummer)
							and not($processedRight/tia:IMKAD_Perceel/tia:tia_SplitsingsverzoekOrdernummer)))
					and tia:kadastraleAanduiding/tia:gemeente
						= $processedRight/tia:IMKAD_Perceel/tia:kadastraleAanduiding/tia:gemeente
					and normalize-space(tia:kadastraleAanduiding/tia:gemeente) != ''
					and tia:kadastraleAanduiding/tia:sectie
						= $processedRight/tia:IMKAD_Perceel/tia:kadastraleAanduiding/tia:sectie
					and normalize-space(tia:kadastraleAanduiding/tia:sectie) != ''
					and tia:IMKAD_OZLocatie/tia:ligging
						= $processedRight/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:ligging
					and normalize-space(tia:IMKAD_OZLocatie/tia:ligging) != ''
					and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer
						= $processedRight/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer)
						or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer)
							and not($processedRight/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer)))
					and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter
						= $processedRight/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter)
						or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter)
							and not($processedRight/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter)))
					and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging
						= $processedRight/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging)
						or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging)
							and not($processedRight/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging)))
					and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode
						= $processedRight/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode)
						or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode)
							and not($processedRight/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode)))
					and tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam
						= $processedRight/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam
					and normalize-space(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam) != ''
					and tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam
						= $processedRight/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam
					and normalize-space(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam) != '']])">
				<tr>
					<xsl:if test="$indentLevel > 0">
						<xsl:call-template name="indent">
							<xsl:with-param name="current" select="number('1')"/>
							<xsl:with-param name="indentLevel" select="$indentLevel"/>
						</xsl:call-template>
					</xsl:if>
					<td class="number" valign="top">
						<xsl:number value="$position" format="a"/>
						<xsl:text>.</xsl:text>
					</td>
					<td>
						<xsl:variable name="rightText">
							<xsl:apply-templates select="$processedRight" mode="do-right"/>
						</xsl:variable>
						<xsl:if test="normalize-space($rightText) != ''">
							<xsl:value-of select="$rightText"/>
							<xsl:text> </xsl:text>
						</xsl:if>
						<xsl:apply-templates select="$processedRight" mode="do-registered-object"/>
						<xsl:choose>
							<xsl:when test="normalize-space($lastElementsPunctuationMark) != '' and $isLastProcessedRight = 'true'">
								<xsl:value-of select="$lastElementsPunctuationMark"/>								
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="$punctuationMark"/>
							</xsl:otherwise>
						</xsl:choose>
					</td>
				</tr>
				<xsl:if test="$positionOfProcessedRight &lt; count($registeredObjects/tia:IMKAD_ZakelijkRecht)">
					<xsl:call-template name="processRights">
						<xsl:with-param name="positionOfProcessedRight" select="$positionOfProcessedRight + 1"/>
						<xsl:with-param name="position" select="$position + 1"/>
						<xsl:with-param name="registeredObjects" select="$registeredObjects"/>
						<xsl:with-param name="lastElementsPunctuationMark" select="$lastElementsPunctuationMark"/>
						<xsl:with-param name="punctuationMark" select="$punctuationMark"/>
						<xsl:with-param name="indentLevel" select="$indentLevel"/>
					</xsl:call-template>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="$positionOfProcessedRight &lt; count($registeredObjects/tia:IMKAD_ZakelijkRecht)">
					<xsl:call-template name="processRights">
						<xsl:with-param name="positionOfProcessedRight" select="$positionOfProcessedRight + 1"/>
						<xsl:with-param name="position" select="$position"/>
						<xsl:with-param name="registeredObjects" select="$registeredObjects"/>
						<xsl:with-param name="punctuationMark" select="$punctuationMark"/>
						<xsl:with-param name="lastElementsPunctuationMark" select="$lastElementsPunctuationMark"/>
						<xsl:with-param name="indentLevel" select="$indentLevel"/>
					</xsl:call-template>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<!--
	*********************************************************
	Name: isLastProcessedRight
	*********************************************************
	Public: no

	Discription: Checks if right is the last one processed. It is the last processed if there is at least one unprocessed right after one that is checked. 

	Params: positionOfProcessedRight - Position of currently checked right in list of rights.
			registeredObjects - Root element that contains rights.

	Output: XHTML structure

	Calls:
	(name) isLastProcessedRight (reccuring)

	Called by:
	(name) processRights
	-->

	<!--
	**** named template ********************************************************************************
	-->
	<xsl:template name="isLastProcessedRight">
		<xsl:param name="positionOfProcessedRight"/>
		<xsl:param name="registeredObjects"/>
		<xsl:variable name="processedRight" select="$registeredObjects/tia:IMKAD_ZakelijkRecht[$positionOfProcessedRight]"/>
		
		<xsl:choose>
			<xsl:when test="$positionOfProcessedRight &lt;= count($registeredObjects/tia:IMKAD_ZakelijkRecht)">
				<xsl:choose>
					<xsl:when test="count($processedRight/preceding-sibling::tia:IMKAD_ZakelijkRecht[
						((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen']/tia:tekst
							= $processedRight/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen']/tia:tekst)
							or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen'])
								and not($processedRight/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen'])))
						and tia:aardVerkregen = $processedRight/tia:aardVerkregen
						and normalize-space(tia:aardVerkregen) != ''
						and ((tia:tia_Aantal_BP_Rechten
								= $processedRight/tia:tia_Aantal_BP_Rechten)
							or (not(tia:tia_Aantal_BP_Rechten)
								and not($processedRight/tia:tia_Aantal_BP_Rechten)))
						and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven']/tia:tekst
								= $processedRight/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven']/tia:tekst)
							or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven'])
								and not($processedRight/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven'])))
						and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom']/tia:tekst
								= $processedRight/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom']/tia:tekst)
							or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom'])
								and not($processedRight/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom'])))
						and ((tia:aandeelInRecht/tia:teller	= $processedRight/tia:aandeelInRecht/tia:teller 
							and tia:aandeelInRecht/tia:noemer = $processedRight/tia:aandeelInRecht/tia:noemer)
							or (not(tia:aandeelInRecht)
								and not($processedRight/tia:aandeelInRecht)))
						and tia:IMKAD_Perceel[
							tia:tia_OmschrijvingEigendom
								= $processedRight/tia:IMKAD_Perceel/tia:tia_OmschrijvingEigendom
							and normalize-space(tia:tia_OmschrijvingEigendom) != ''
							and ((tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid']/tia:tekst
									= $processedRight/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid']/tia:tekst)
								or (not(tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid'])
									and not($processedRight/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid'])))
							and ((tia:tia_SplitsingsverzoekOrdernummer
									= $processedRight/tia:IMKAD_Perceel/tia:tia_SplitsingsverzoekOrdernummer)
								or (not(tia:tia_SplitsingsverzoekOrdernummer)
									and not($processedRight/tia:IMKAD_Perceel/tia:tia_SplitsingsverzoekOrdernummer)))
							and tia:kadastraleAanduiding/tia:gemeente
								= $processedRight/tia:IMKAD_Perceel/tia:kadastraleAanduiding/tia:gemeente
							and normalize-space(tia:kadastraleAanduiding/tia:gemeente) != ''
							and tia:kadastraleAanduiding/tia:sectie
								= $processedRight/tia:IMKAD_Perceel/tia:kadastraleAanduiding/tia:sectie
							and normalize-space(tia:kadastraleAanduiding/tia:sectie) != ''
							and tia:IMKAD_OZLocatie/tia:ligging
								= $processedRight/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:ligging
							and normalize-space(tia:IMKAD_OZLocatie/tia:ligging) != ''
							and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer
								= $processedRight/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer)
								or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer)
									and not($processedRight/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer)))
							and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter
								= $processedRight/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter)
								or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter)
									and not($processedRight/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter)))
							and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging
								= $processedRight/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging)
								or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging)
									and not($processedRight/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging)))
							and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode
								= $processedRight/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode)
								or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode)
									and not($processedRight/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode)))
							and tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam
								= $processedRight/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam
							and normalize-space(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam) != ''
							and tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam
								= $processedRight/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam
							and normalize-space(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam) != '']]) = 0">
						<xsl:text>false</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="isLastProcessedRight">
							<xsl:with-param name="positionOfProcessedRight" select="$positionOfProcessedRight + 1"/>
							<xsl:with-param name="registeredObjects" select="$registeredObjects"/>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>true</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>
