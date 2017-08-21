<?xml version="1.0" encoding="UTF-8"?>
<!--
*********************************************************
Stylesheet: tekstblok_registergoed.xsl
Version: 1.26
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
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:tia="http://www.kadaster.nl/schemas/KIK/TIA_Algemeen" xmlns:kef="nl.kadaster.xslt.XslExtensionFunctions" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:java="http://xml.apache.org/xalan/java" exclude-result-prefixes="tia kef xsl java" version="1.0">
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
	(mode) do-cadastral-identification

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
			tia:aardVerkregen = current()/tia:aardVerkregen
			and normalize-space(tia:aardVerkregen) != ''
			and ((tia:aardVerkregenVariant
				 = current()/tia:aardVerkregenVariant)
				or (not(tia:aardVerkregenVariant)
					and not(current()/tia:aardVerkregenVariant)))					
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
			and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoud']/tia:tekst
					= current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoud']/tia:tekst)
				or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoud'])
					and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoud'])))
			and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurend']/tia:tekst
					= current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurend']/tia:tekst)
				or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurend'])
					and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurend'])))
			and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijvenvariant']/tia:tekst
					= current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijvenvariant']/tia:tekst)
				or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijvenvariant'])
					and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijvenvariant'])))
			and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoudvariant']/tia:tekst
					= current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoudvariant']/tia:tekst)
				or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoudvariant'])
					and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoudvariant'])))
			and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurendvariant']/tia:tekst
					= current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurendvariant']/tia:tekst)
				or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurendvariant'])
					and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurendvariant'])))
			and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aantal_bp_rechtenvariant']/tia:tekst
					= current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aantal_bp_rechtenvariant']/tia:tekst)
				or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aantal_bp_rechtenvariant'])
					and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aantal_bp_rechtenvariant'])))
	        and	((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen']/tia:tekst
					= current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen']/tia:tekst)
				or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen'])
					and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen'])))
			and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_wijzevanlevering']/tia:tekst
					= current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_wijzevanlevering']/tia:tekst)
				or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_wijzevanlevering'])
					and not(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_wijzevanlevering'])))
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
				and ((tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aanduiding']/tia:tekst
						= current()/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aanduiding']/tia:tekst)
					or (not(tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aanduiding'])
						and not(current()/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aanduiding'])))
				and ((tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_nabij']/tia:tekst
						= current()/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_nabij']/tia:tekst)
					or (not(tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_nabij'])
						and not(current()/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_nabij'])))
				and ((tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_komma']/tia:tekst
						= current()/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_komma']/tia:tekst)
					or (not(tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_komma'])
						and not(current()/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_komma'])))
				and ((tia:tia_SplitsingsverzoekOrdernummer
						= current()/tia:IMKAD_Perceel/tia:tia_SplitsingsverzoekOrdernummer)
					or (not(tia:tia_SplitsingsverzoekOrdernummer)
						and not(current()/tia:IMKAD_Perceel/tia:tia_SplitsingsverzoekOrdernummer)))
				and ((tia:stukVerificatiekosten/tia:reeks
						= current()/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:reeks)
					or (not(tia:stukVerificatiekosten/tia:reeks)
						and not(current()/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:reeks)))
				and ((tia:stukVerificatiekosten/tia:deel
						= current()/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:deel)
					or (not(tia:stukVerificatiekosten/tia:deel)
						and not(current()/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:deel)))
				and ((tia:stukVerificatiekosten/tia:nummer
						= current()/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:nummer)
					or (not(tia:stukVerificatiekosten/tia:nummer)
						and not(current()/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:nummer)))
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
				and  ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter
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
				and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam
					= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam)
					or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam)
						and not(current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam)))
			    and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam
					= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam)
					or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam)
						and not(current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam)))
				and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:postcode
					= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:postcode)
					or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:postcode)
						and not(current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:postcode)))
				and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:woonplaatsNaam
					= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:woonplaatsNaam)
					or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:woonplaatsNaam)
						and not(current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:woonplaatsNaam)))
				and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:openbareRuimteNaam
					= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:openbareRuimteNaam)
					or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:openbareRuimteNaam)
						and not(current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:openbareRuimteNaam)))				
				and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummer
					= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummer)
					or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummer)
						and not(current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummer)))
				and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisLetter
					= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisLetter)
					or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisLetter)
						and not(current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisLetter)))
				and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummerToevoeging
					= current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummerToevoeging)
					or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummerToevoeging)
						and not(current()/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummerToevoeging)))]]/tia:IMKAD_Perceel"/>
		<xsl:variable name="respectively">
			<xsl:choose>
				<xsl:when test="count($sameObjects) > 0 and $RegistergoedTonenPerPerceel='false'">
					<xsl:text>respectievelijk </xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="parcel-initial-text" select="tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space(current()/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
		<xsl:variable name="deliveryMethod" select="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_wijzevanlevering']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_wijzevanlevering']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space(current()/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_wijzevanlevering']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
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
				<xsl:choose>
					<xsl:when test="$deliveryMethod = 'aaneengesloten'">
						<xsl:text>welk perceel als aaneengesloten geheel wordt overgedragen, </xsl:text>
					</xsl:when>
					<xsl:when test="$deliveryMethod = 'doorgeleverd'">
						<xsl:text>welk perceel thans wordt doorgeleverd, </xsl:text>
					</xsl:when>
				</xsl:choose>
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
		<xsl:if test="$sameObjects and $RegistergoedTonenPerPerceel='false'">
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
		<xsl:if test="translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen']/tia:tekst, $upper, $lower) = 'true' 
						and $deliveryMethod = 'verificatiekosten'">
			<xsl:text>. De verificatiekosten zijn reeds in rekening gebracht bij akte ingeschreven in register Hypotheken 4 </xsl:text>
			<xsl:if test="normalize-space(tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:reeks) != ''">
				<xsl:text>te </xsl:text>
				<xsl:value-of select="tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:reeks"/>
			</xsl:if>
			<xsl:text> in deel </xsl:text>
			<xsl:value-of select="tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:deel"/>
			<xsl:text> en nummer </xsl:text>
			<xsl:value-of select="tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:nummer"/>
			<xsl:text> waarbij een aandeel in het perceel</xsl:text>
			<xsl:apply-templates select="tia:IMKAD_Perceel/tia:kadastraleAanduiding" mode="do-cadastral-identification">
				<xsl:with-param name="boldLabel" select="'false'"/>
				<xsl:with-param name="sameObjects" select="$sameObjects"/>
				<xsl:with-param name="includeComma" select="'false'"/>
			</xsl:apply-templates>
			<xsl:text> reeds in eigendom is geleverd</xsl:text>
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
			includeComma - indicates weather starting comma sign should be printed

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
		<xsl:param name="includeComma" select="'true'"/>
		<xsl:if test="$position = '1'">
			<xsl:choose>
				<xsl:when test="translate($boldLabel, $upper, $lower) = 'true'">
					<xsl:if test="parent::tia:IMKAD_Perceel and $includeComma = 'true'">
						<xsl:text>,</xsl:text>
					</xsl:if>
					<strong>
						<xsl:text> kadastraal bekend </xsl:text>
					</strong>
				</xsl:when>
				<xsl:otherwise>
					<xsl:if test="parent::tia:IMKAD_Perceel and $includeComma = 'true'">
						<xsl:text>, </xsl:text>
					</xsl:if>
					<xsl:text> kadastraal bekend </xsl:text>
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
		<xsl:if test="$sameObjects and $RegistergoedTonenPerPerceel = 'false'">
			<xsl:text>s</xsl:text>
		</xsl:if>
		<xsl:text> </xsl:text>
		<xsl:value-of select="tia:perceelnummer"/>
		<xsl:if test="$sameObjects/tia:kadastraleAanduiding/tia:perceelnummer and $RegistergoedTonenPerPerceel='false'">
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
		<xsl:if test="translate(normalize-space(../tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_komma']/tia:tekst), $upper, $lower) = 'true'">
			<xsl:text>,</xsl:text>
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
						<xsl:text> kadastraal bekend </xsl:text>
					</strong>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text> kadastraal bekend </xsl:text>
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
			<xsl:when test="$sameObjects and $RegistergoedTonenPerPerceel = 'false'">
				<xsl:text>appartementsindices </xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>appartementsindex </xsl:text>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:value-of select="tia:appartementsindex"/>
		<xsl:if test="$sameObjects/tia:kadastraleAanduiding/tia:appartementsindex and $RegistergoedTonenPerPerceel = 'false'">
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
	(mode) do-parcel-location
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
		<xsl:apply-templates select="." mode="do-parcel-location"/>
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
	(mode) do-apartment-location
	(mode) do-cadastral-identification

	Called by:
	(mode) do-registered-object
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Appartementsrecht" mode="do-apartment-data">
		<xsl:variable name="apartment-initial-text" select="tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
				translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
				translate(normalize-space(current()/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
		<xsl:variable name="partGroup" select="tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aandeelgemeenschap']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
				translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aandeelgemeenschap']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
				translate(normalize-space(current()/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aandeelgemeenschap']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
		<xsl:if test="translate($apartment-initial-text, $upper, $lower) != 'met bestemming mandeligheid'">
			<xsl:value-of select="$apartment-initial-text"/>
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:value-of select="tia:tia_OmschrijvingEigendom"/>
		<xsl:text> </xsl:text>
		<xsl:apply-templates select="." mode="do-apartment-location"/>
		<xsl:text>,</xsl:text>
		<xsl:apply-templates select="tia:kadastraleAanduiding" mode="do-cadastral-identification"/>
		<xsl:choose>
			<xsl:when test="$partGroup = '1'">
				<xsl:text>, uitmakende het </xsl:text>
				<xsl:value-of select="kef:convertNumberToText(string(tia:Aandeel/tia:teller))"/>
				<xsl:text>/</xsl:text>
				<xsl:value-of select="kef:convertOrdinalToText(string(tia:Aandeel/tia:noemer))"/>
				<xsl:text> (</xsl:text>
				<xsl:value-of select="tia:Aandeel/tia:teller"/>
				<xsl:text>/</xsl:text>
				<xsl:value-of select="tia:Aandeel/tia:noemer"/>
				<xsl:text>) aandeel in de hierna omschreven gemeenschap</xsl:text>
			</xsl:when>
			<xsl:when test="$partGroup = '2'">
				<xsl:text>, uitmakende het </xsl:text>
				<xsl:value-of select="kef:convertNumberToText(string(tia:Aandeel/tia:teller))"/>
				<xsl:text>/</xsl:text>
				<xsl:value-of select="kef:convertOrdinalToText(string(tia:Aandeel/tia:noemer))"/>
				<xsl:text> (</xsl:text>
				<xsl:value-of select="tia:Aandeel/tia:teller"/>
				<xsl:text>/</xsl:text>
				<xsl:value-of select="tia:Aandeel/tia:noemer"/>
				<xsl:text>) aandeel in de hierna te omschrijven gemeenschap</xsl:text>
			</xsl:when>
		</xsl:choose>
		<xsl:if test="translate($apartment-initial-text, $upper, $lower) = 'met bestemming mandeligheid'">
			<xsl:text>, </xsl:text>
			<xsl:value-of select="$apartment-initial-text"/>
		</xsl:if>
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
				<xsl:when test="translate(tia:brutoInhoud/tia:eenheid, $upper, $lower) = 'kubieke meter (m3)'">
					<xsl:text>liter</xsl:text>
				</xsl:when>
				<xsl:when test="translate(tia:brutoInhoud/tia:eenheid, $upper, $lower) = 'ton'">
					<xsl:text>kilo</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text/>
				</xsl:otherwise>
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
	Mode: do-parcel-location
	*********************************************************
	Public: no

	Identity transform: no

	Description: Parcel location.

	Input: tia:IMKAD_Perceel

	Params: none

	Output: text

	Calls:
	(mode) do-parcel-address

	Called by:
	(mode) do-parcel-data
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Perceel" mode="do-parcel-location">
		<xsl:text>gelegen </xsl:text>
		<xsl:value-of select="tia:IMKAD_OZLocatie/tia:ligging"/>
		<xsl:text> </xsl:text>
		<xsl:apply-templates select="." mode="do-parcel-address"/>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-apartment-location
	*********************************************************
	Public: no

	Identity transform: no

	Description: Apartment location.

	Input: tia:IMKAD_Appartementsrecht

	Params: none

	Output: text

	Calls:
	(mode) do-apartment-address

	Called by:
	(mode) do-apartment-data
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Appartementsrecht" mode="do-apartment-location">
		<xsl:text>gelegen </xsl:text>
		<xsl:value-of select="tia:IMKAD_OZLocatie/tia:ligging"/>
		<xsl:text> </xsl:text>
		<xsl:apply-templates select="." mode="do-apartment-address"/>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-parcel-address
	*********************************************************
	Public: no

	Identity transform: no

	Description: Parcel address.

	Input: tia:IMKAD_Perceel

	Params: none

	Output: text

	Calls:
	none

	Called by:
	(mode) do-parcel-location
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Perceel" mode="do-parcel-address">
		<xsl:variable name="indication" select="tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aanduiding']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aanduiding']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space(current()/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aanduiding']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
		<xsl:choose>
			<xsl:when test="tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres">
				<xsl:if test="tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:postcode
				and normalize-space(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:postcode) != ''">
					<!-- Insert space between numbers and letters of post code -->
					<xsl:value-of select="concat(normalize-space(substring(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:postcode, 1, 4)), ' ',
						normalize-space(substring(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:postcode, 5)))"/>
					<xsl:text> </xsl:text>
				</xsl:if>
				<xsl:value-of select="tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:woonplaatsNaam"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode
				and normalize-space(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode) != ''">
					<!-- Insert space between numbers and letters of post code -->
					<xsl:value-of select="concat(normalize-space(substring(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode, 1, 4)), ' ',
					normalize-space(substring(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode, 5)))"/>
					<xsl:text> </xsl:text>
				</xsl:if>
				<xsl:value-of select="tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam"/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:text>,</xsl:text>
		<xsl:choose>
			<xsl:when test="normalize-space($indication) = '1'">
				<xsl:text> plaatselijk niet nader aangeduid</xsl:text>
			</xsl:when>
			<xsl:when test="normalize-space($indication) = '2'">
				<xsl:text> zonder plaatselijke aanduiding</xsl:text>
			</xsl:when>
			<xsl:when test="normalize-space($indication) = '3'">
				<xsl:if test="translate(normalize-space(tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_nabij']/tia:tekst),$upper, $lower) = 'true'">
					<xsl:text> nabij </xsl:text>
				</xsl:if>
				<xsl:choose>
					<xsl:when test="count(tia:IMKAD_OZLocatie) = 1">
						<xsl:text> </xsl:text>
						<xsl:choose>
							<xsl:when test="tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres">
								<xsl:value-of select="tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:openbareRuimteNaam"/>
								<xsl:choose>
									<xsl:when test="normalize-space(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummer) != ''">
										<xsl:text> </xsl:text>
										<xsl:value-of select="tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummer"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text> ongenummerd</xsl:text>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:if test="normalize-space(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisLetter) != ''">
									<xsl:text> </xsl:text>
									<xsl:value-of select="tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisLetter"/>
								</xsl:if>
								<xsl:if test="normalize-space(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummerToevoeging) != ''">
									<xsl:text> </xsl:text>
									<xsl:value-of select="tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummerToevoeging"/>
								</xsl:if>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam"/>
								<xsl:choose>
									<xsl:when test="normalize-space(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer) != ''">
										<xsl:text> </xsl:text>
										<xsl:value-of select="tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text> ongenummerd</xsl:text>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:if test="normalize-space(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter) != ''">
									<xsl:text> </xsl:text>
									<xsl:value-of select="tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter"/>
								</xsl:if>
								<xsl:if test="normalize-space(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging) != ''">
									<xsl:text> </xsl:text>
									<xsl:value-of select="tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging"/>
								</xsl:if>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="count(tia:IMKAD_OZLocatie) > 1">
						<xsl:variable name="ozAddresses">
							<xsl:for-each select="tia:IMKAD_OZLocatie">
								<xsl:copy-of select="."/>
							</xsl:for-each>
						</xsl:variable>
						<xsl:text> </xsl:text>
						<xsl:value-of select="java:nl.kadaster.kpk.server.service.impl.transformer.AddressSortUtil.doParcelAddresses($ozAddresses)"/>
					</xsl:when>
				</xsl:choose>
			</xsl:when>
		</xsl:choose>
		<xsl:if test="tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres">
			<xsl:text>, volgens gegevens van de basisregistratie adressen bekend als: </xsl:text>
			<xsl:value-of select="concat(normalize-space(substring(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode, 1, 4)), ' ',
				normalize-space(substring(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode, 5)))"/>
			<xsl:text> </xsl:text>
			<xsl:value-of select="tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam"/>
			<xsl:text>, </xsl:text>
			<xsl:value-of select="tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam"/>
			<xsl:if test="tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer
							and normalize-space(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer) != ''">
				<xsl:text> </xsl:text>
				<xsl:value-of select="tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer"/>
			</xsl:if>
			<xsl:if test="tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter
							and normalize-space(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter) != ''">
				<xsl:text> </xsl:text>
				<xsl:value-of select="tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter"/>
			</xsl:if>
			<xsl:if test="tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging
							and normalize-space(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging) != ''">
				<xsl:text> </xsl:text>
				<xsl:value-of select="tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging"/>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-apartment-address
	*********************************************************
	Public: no

	Identity transform: no

	Description: Apartment address.

	Input: tia:IMKAD_Appartementsrecht

	Params: none

	Output: text

	Calls:
	none

	Called by:
	(mode) do-apartment-location
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Appartementsrecht" mode="do-apartment-address">
		<xsl:if test="tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode
				and normalize-space(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode) != ''">
			<!-- Insert space between numbers and letters of post code -->
			<xsl:value-of select="concat(normalize-space(substring(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode, 1, 4)), ' ',
				normalize-space(substring(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode, 5)))"/>
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:value-of select="tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam"/>
		<xsl:text>, </xsl:text>
		<xsl:value-of select="tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam"/>
		<xsl:if test="tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer
				and normalize-space(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer) != ''">
			<xsl:text> </xsl:text>
			<xsl:value-of select="tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer"/>
		</xsl:if>
		<xsl:if test="tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter
				and normalize-space(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter) != ''">
			<xsl:text> </xsl:text>
			<xsl:value-of select="tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter"/>
		</xsl:if>
		<xsl:if test="tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging
				and normalize-space(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging) != ''">
			<xsl:text> </xsl:text>
			<xsl:value-of select="tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging"/>
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
		<xsl:param name="indentLevel" select="number('0')"/>
		<xsl:param name="haveAdditionalText" select="'false'"/>
		<xsl:param name="semicolon" select="'false'"/>
		<xsl:param name="aantalGetoondeRegistergoederen"/>
		<xsl:param name="endMark" select="'.'"/>
		
		<xsl:variable name="allProcessedRights" select="$registeredObjects/tia:IMKAD_ZakelijkRecht"/>
		<xsl:variable name="processedRight" select="$allProcessedRights[$positionOfProcessedRight]"/>
		<xsl:variable name="aantalZelfde">
			<xsl:choose>
				<xsl:when test="$RegistergoedTonenPerPerceel='true'"><xsl:value-of select="number('0')"/></xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="bepaalAantalZelfde">
						<xsl:with-param name="positionOfProcessedRight" select="$positionOfProcessedRight"/>
						<xsl:with-param name="registeredObjects" select="$registeredObjects"/>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="isLastProcessedRight">
			<xsl:call-template name="isLastProcessedRight">
				<xsl:with-param name="positionOfProcessedRight" select="$positionOfProcessedRight + $aantalZelfde"/>
				<xsl:with-param name="registeredObjects" select="$registeredObjects"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:choose>
			<!-- Skip parcel if already processed by previous with the same data -->
			<xsl:when test="not($processedRight/tia:IMKAD_Perceel and $processedRight/preceding-sibling::tia:IMKAD_ZakelijkRecht[
				tia:aardVerkregen = $processedRight/tia:aardVerkregen
				and normalize-space(tia:aardVerkregen) != ''
			and ((tia:aardVerkregenVariant 
				= $processedRight/tia:aardVerkregenVariant)
				or (not(tia:aardVerkregenVariant)
					and not($processedRight/tia:aardVerkregenVariant)))					
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
			    and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoud']/tia:tekst
					   = $processedRight/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoud']/tia:tekst)
				    or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoud'])
					and not($processedRight/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoud'])))
				and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurend']/tia:tekst
					= $processedRight/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurend']/tia:tekst)
				or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurend'])
					and not($processedRight/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurend'])))
			and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijvenvariant']/tia:tekst
					= $processedRight/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijvenvariant']/tia:tekst)
				or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijvenvariant'])
					and not($processedRight/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijvenvariant'])))
			and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoudvariant']/tia:tekst
					= $processedRight/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoudvariant']/tia:tekst)
				or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoudvariant'])
					and not($processedRight/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoudvariant'])))
			and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurendvariant']/tia:tekst
					= $processedRight/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurendvariant']/tia:tekst)
				or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurendvariant'])
					and not($processedRight/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurendvariant'])))
			and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aantal_bp_rechtenvariant']/tia:tekst
					= $processedRight/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aantal_bp_rechtenvariant']/tia:tekst)
				or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aantal_bp_rechtenvariant'])
					and not($processedRight/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aantal_bp_rechtenvariant'])))
            and	((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen']/tia:tekst
					= $processedRight/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen']/tia:tekst)
					or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen'])
						and not($processedRight/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen'])))
			and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_wijzevanlevering']/tia:tekst
					= $processedRight/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_wijzevanlevering']/tia:tekst)
				or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_wijzevanlevering'])
					and not($processedRight/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_wijzevanlevering'])))
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
					and ((tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aanduiding']/tia:tekst
							= $processedRight/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aanduiding']/tia:tekst)
						or (not(tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aanduiding'])
							and not($processedRight/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aanduiding'])))
					and ((tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_nabij']/tia:tekst
							= $processedRight/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_nabij']/tia:tekst)
						or (not(tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_nabij'])
							and not($processedRight/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_nabij'])))
					and ((tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_komma']/tia:tekst
							= $processedRight/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_komma']/tia:tekst)
						or (not(tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_komma'])
							and not($processedRight/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_komma'])))
					and ((tia:tia_SplitsingsverzoekOrdernummer
							= $processedRight/tia:IMKAD_Perceel/tia:tia_SplitsingsverzoekOrdernummer)
						or (not(tia:tia_SplitsingsverzoekOrdernummer)
							and not($processedRight/tia:IMKAD_Perceel/tia:tia_SplitsingsverzoekOrdernummer)))
					and ((tia:stukVerificatiekosten/tia:reeks
						= $processedRight/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:reeks)
					or (not(tia:stukVerificatiekosten/tia:reeks)
						and not($processedRight/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:reeks)))
				and ((tia:stukVerificatiekosten/tia:deel
						= $processedRight/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:deel)
					or (not(tia:stukVerificatiekosten/tia:deel)
						and not($processedRight/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:deel)))
				and ((tia:stukVerificatiekosten/tia:nummer
						= $processedRight/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:nummer)
					or (not(tia:stukVerificatiekosten/tia:nummer)
						and not($processedRight/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:nummer)))
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
				and  ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter
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
				and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam
					= $processedRight/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam)
					or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam)
						and not($processedRight/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam)))
				and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam
					= $processedRight/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam)
					or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam)
						and not($processedRight/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam)))
				and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:postcode
					= $processedRight/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:postcode)
					or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:postcode)
						and not($processedRight/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:postcode)))
				and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:woonplaatsNaam
					= $processedRight/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:woonplaatsNaam)
					or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:woonplaatsNaam)
						and not($processedRight/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:woonplaatsNaam)))
				and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:openbareRuimteNaam
					= $processedRight/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:openbareRuimteNaam)
					or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:openbareRuimteNaam)
						and not($processedRight/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:openbareRuimteNaam)))				
				and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummer
					= $processedRight/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummer)
					or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummer)
						and not($processedRight/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummer)))
				and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisLetter
					= $processedRight/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisLetter)
					or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisLetter)
						and not($processedRight/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisLetter)))
				and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummerToevoeging
					= $processedRight/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummerToevoeging)
					or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummerToevoeging)
						and not($processedRight/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummerToevoeging)))]]) or $RegistergoedTonenPerPerceel='true'">
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
							<xsl:when test="$isLastProcessedRight = 'true' and normalize-space($haveAdditionalText) != 'true'">
								<xsl:value-of select="$endMark"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="$punctuationMark"/>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:if test="normalize-space($haveAdditionalText) = 'true' and translate($processedRight/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedvolgnummer']/tia:tekst, $upper, $lower) = 'true'">
							<br/>
							<xsl:text>hierna</xsl:text>
							<xsl:if test="translate($processedRight/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedvolgnummer']/tia:tekst, $upper, $lower) = 'true'">
								<xsl:text> </xsl:text>
								<xsl:value-of select="$processedRight/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedvolgnummertekst']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
									translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedvolgnummertekst']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
									translate(normalize-space($processedRight/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedvolgnummertekst']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
							</xsl:if>
							<xsl:text>: "</xsl:text>
							<u>
								<xsl:if test="translate($processedRight/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedvolgnummerlidwoord']/tia:tekst, $upper, $lower) = 'true'">
									<xsl:text>het </xsl:text>
								</xsl:if>
								<xsl:text>Registergoed </xsl:text>
								<xsl:value-of select="$position + $aantalGetoondeRegistergoederen"/>
							</u>
							<xsl:text>"</xsl:text>
							<xsl:choose>
								<xsl:when test="$isLastProcessedRight = 'true' and $semicolon = 'false'">
									<xsl:text>.</xsl:text>								
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>;</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:if>
					</td>
				</tr>
				<xsl:if test="$positionOfProcessedRight &lt; count($registeredObjects/tia:IMKAD_ZakelijkRecht)">
					<xsl:call-template name="processRights">
						<xsl:with-param name="positionOfProcessedRight" select="$positionOfProcessedRight + 1"/>
						<xsl:with-param name="position" select="$position + 1"/>
						<xsl:with-param name="registeredObjects" select="$registeredObjects"/>
						<xsl:with-param name="punctuationMark" select="$punctuationMark"/>
						<xsl:with-param name="indentLevel" select="$indentLevel"/>
						<xsl:with-param name="haveAdditionalText" select="$haveAdditionalText"/>
						<xsl:with-param name="semicolon" select="$semicolon"/>
						<xsl:with-param name="aantalGetoondeRegistergoederen" select="$aantalGetoondeRegistergoederen"/>
						<xsl:with-param name="endMark" select="$endMark"/>
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
						<xsl:with-param name="indentLevel" select="$indentLevel"/>
						<xsl:with-param name="haveAdditionalText" select="$haveAdditionalText"/>
						<xsl:with-param name="semicolon" select="$semicolon"/>
						<xsl:with-param name="aantalGetoondeRegistergoederen" select="$aantalGetoondeRegistergoederen"/>
						<xsl:with-param name="endMark" select="$endMark"/>
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
				<xsl:when test="count($processedRight/following-sibling::tia:IMKAD_ZakelijkRecht) = 0">			
						<xsl:text>true</xsl:text>
					</xsl:when>
			<xsl:otherwise>
				<xsl:text>false</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="bepaalAantalZelfde">
		<xsl:param name="positionOfProcessedRight"/>
		<xsl:param name="registeredObjects"/>
		<xsl:variable name="processedRight" select="$registeredObjects/tia:IMKAD_ZakelijkRecht[$positionOfProcessedRight]"/>
		<xsl:value-of select="count($processedRight/following-sibling::tia:IMKAD_ZakelijkRecht[
					tia:aardVerkregen = $processedRight/tia:aardVerkregen
						and normalize-space(tia:aardVerkregen) != ''
				and ((tia:aardVerkregenVariant 
				= $processedRight/tia:aardVerkregenVariant)
					or (not(tia:aardVerkregenVariant)
					and not($processedRight/tia:aardVerkregenVariant)))					
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
						and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoud']/tia:tekst
								= $processedRight/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoud']/tia:tekst)
							or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoud'])
								and not($processedRight/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoud'])))
						and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurend']/tia:tekst
								= $processedRight/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurend']/tia:tekst)
							or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurend'])
							and not($processedRight/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurend'])))
						and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijvenvariant']/tia:tekst
								= $processedRight/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijvenvariant']/tia:tekst)
							or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijvenvariant'])
							and not($processedRight/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijvenvariant'])))
						and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoudvariant']/tia:tekst
								= $processedRight/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoudvariant']/tia:tekst)
								or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoudvariant'])
								and not($processedRight/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoudvariant'])))
						and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurendvariant']/tia:tekst
								= $processedRight/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurendvariant']/tia:tekst)
								or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurendvariant'])
								and not($processedRight/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurendvariant'])))
						and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aantal_bp_rechtenvariant']/tia:tekst
								= $processedRight/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aantal_bp_rechtenvariant']/tia:tekst)
							or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aantal_bp_rechtenvariant'])
							and not($processedRight/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aantal_bp_rechtenvariant'])))
						and	((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen']/tia:tekst
								= $processedRight/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen']/tia:tekst)
							or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen'])
								and not($processedRight/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen'])))
						and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_wijzevanlevering']/tia:tekst
								= $processedRight/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_wijzevanlevering']/tia:tekst)
							or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_wijzevanlevering'])
							and not($processedRight/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_wijzevanlevering'])))
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
							and ((tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aanduiding']/tia:tekst
									= $processedRight/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aanduiding']/tia:tekst)
								or (not(tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aanduiding'])
									and not($processedRight/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aanduiding'])))
							and ((tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_nabij']/tia:tekst
									= $processedRight/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_nabij']/tia:tekst)
								or (not(tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_nabij'])
									and not($processedRight/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_nabij'])))
							and ((tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_komma']/tia:tekst
									= $processedRight/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_komma']/tia:tekst)
								or (not(tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_komma'])
									and not($processedRight/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_komma'])))
							and ((tia:tia_SplitsingsverzoekOrdernummer
									= $processedRight/tia:IMKAD_Perceel/tia:tia_SplitsingsverzoekOrdernummer)
								or (not(tia:tia_SplitsingsverzoekOrdernummer)
									and not($processedRight/tia:IMKAD_Perceel/tia:tia_SplitsingsverzoekOrdernummer)))
				and ((tia:stukVerificatiekosten/tia:reeks
						= $processedRight/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:reeks)
					or (not(tia:stukVerificatiekosten/tia:reeks)
						and not($processedRight/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:reeks)))
				and ((tia:stukVerificatiekosten/tia:deel
						= $processedRight/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:deel)
					or (not(tia:stukVerificatiekosten/tia:deel)
						and not($processedRight/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:deel)))
				and ((tia:stukVerificatiekosten/tia:nummer
						= $processedRight/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:nummer)
					or (not(tia:stukVerificatiekosten/tia:nummer)
						and not($processedRight/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:nummer)))
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
				and  ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter
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
				and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam
					= $processedRight/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam)
					or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam)
						and not($processedRight/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam)))
				and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam
					= $processedRight/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam)
					or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam)
						and not($processedRight/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam)))
				and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:postcode
					= $processedRight/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:postcode)
					or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:postcode)
						and not($processedRight/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:postcode)))
				and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:woonplaatsNaam
					= $processedRight/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:woonplaatsNaam)
					or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:woonplaatsNaam)
						and not($processedRight/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:woonplaatsNaam)))
				and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:openbareRuimteNaam
					= $processedRight/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:openbareRuimteNaam)
					or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:openbareRuimteNaam)
						and not($processedRight/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:openbareRuimteNaam)))				
				and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummer
					= $processedRight/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummer)
					or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummer)
						and not($processedRight/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummer)))
				and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisLetter
					= $processedRight/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisLetter)
					or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisLetter)
						and not($processedRight/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisLetter)))
				and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummerToevoeging
					= $processedRight/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummerToevoeging)
					or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummerToevoeging)
						and not($processedRight/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummerToevoeging)))]])"/>
	</xsl:template>
	
</xsl:stylesheet>
