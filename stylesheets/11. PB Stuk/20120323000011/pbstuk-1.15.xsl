<?xml version="1.0" encoding="UTF-8"?>
<!--
*********************************************************
Stylesheet: pbstuk.xsl
Version: 1.15
*********************************************************
Description:
PB deed.

Public:
(mode) do-deed

Private:
(mode) do-addition-or-cancellation-of-restriction
(mode) do-replacement-area
(mode) do-continue-document
(name) additionCancellationOfRestrictionTextBlock
-->
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
	xmlns:tia="http://www.kadaster.nl/schemas/KIK/TIA_Algemeen"
	xmlns:kef="nl.kadaster.xslt.XslExtensionFunctions"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	exclude-result-prefixes="tia kef xsl"
	version="1.0">

	<xsl:include href="generiek-1.08.xsl"/>
	<xsl:include href="tekstblok_personalia_van_natuurlijk_persoon-1.05.xsl"/>
	<xsl:include href="tekstblok_natuurlijk_persoon-1.09.xsl"/>
	<xsl:include href="tekstblok_registergoed-1.17.xsl"/>
	<xsl:include href="tekstblok_deel_nummer-1.02.xsl"/>

	<!-- PB deed specific global variables -->
	<xsl:variable name="keuzeteksten" select="document('keuzeteksten-pb_stuk-1.04.xml')"/>
	<xsl:variable name="documentTitle" select="'PB stuk'"/>

	<!--
	*********************************************************
	Mode: do-deed
	*********************************************************
	Public: yes

	Identity transform: no

	Description: PB deed.

	Input: tia:Bericht_TIA_Stuk

	Params: none

	Output: XHTML structure

	Calls:
	(mode) do-part-and-number
	(mode) do-addition-or-cancellation-of-restriction
	(mode) do-replacement-area
	(mode) do-continue-document

	Called by:
	Root template
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:Bericht_TIA_Stuk" mode="do-deed">
        <xsl:variable name="txt1" select="tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_toegevoegdebijlage']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
        	translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_toegevoegdebijlage']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
        	translate(normalize-space(current()/tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_toegevoegdebijlage']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
        <xsl:variable name="txt2" select="tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_typemutatiepb']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
        	translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_typemutatiepb']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
        	translate(normalize-space(current()/tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_typemutatiepb']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
		<xsl:variable name="publicLawNature" select="tia:IMKAD_AangebodenStuk/tia:tia_Verklaarder/tia:verklaringBestuursorgaan/tia:informatiePB/tia:aardPubliekrechtelijkeRechtspersoon"/>
		<a name="wkpb.statement" class="location">&#160;</a>
		<p>	
			<xsl:text>Ondergetekende, </xsl:text>
			<xsl:apply-templates select="tia:IMKAD_AangebodenStuk/tia:tia_Verklaarder" mode="do-natural-person" />
			<xsl:text>, 'pb-gemachtigde', handelende namens </xsl:text>
	        <xsl:value-of select="tia:IMKAD_AangebodenStuk/tia:tia_Verklaarder/tia:verklaringBestuursorgaan/tia:naamBestuursorgaan" />
	        <xsl:text>, gevestigd te </xsl:text>
	        <xsl:value-of select="tia:IMKAD_AangebodenStuk/tia:tia_Verklaarder/tia:standplaats" />
	        <xsl:text>, verklaart hierbij dat:</xsl:text>
		</p>
		<table cellpadding="0" cellspacing="0">
			<tbody>
				<tr>
					<td class="number" valign="top">
						<xsl:text>-</xsl:text>
					</td>
					<td>
						<xsl:text>dit stuk </xsl:text>
						<xsl:value-of select="$txt1"/>
						<xsl:if test="$txt1">
							<xsl:text> </xsl:text>
						</xsl:if>
						<xsl:text>een volledige en juiste weergave is van de inhoud van het stuk waarvan het een afschrift is;</xsl:text>
					</td>
				</tr>
				<xsl:if test="tia:IMKAD_AangebodenStuk/tia:tia_Verklaarder/tia:verklaringBestuursorgaan/tia:informatiePB">
					<tr>
						<td class="number" valign="top">
							<xsl:text>-</xsl:text>
						</td>
						<td>
							<xsl:text>verkrijgers van grondstukken binnen het gebied van </xsl:text>
		                    <xsl:choose>
		                        <xsl:when test="translate($publicLawNature, $upper, $lower) = 'gemeente'">
		                        	<xsl:text>de gemeente </xsl:text>
		                        	<xsl:value-of select="tia:IMKAD_AangebodenStuk/tia:tia_Verklaarder/tia:verklaringBestuursorgaan/tia:informatiePB/tia:naamGemeente"/>
		                        </xsl:when>
		                        <xsl:when test="translate($publicLawNature, $upper, $lower) = 'waterschap'">
		                        	<xsl:text>het waterschap </xsl:text>
		                        	<xsl:value-of select="tia:IMKAD_AangebodenStuk/tia:tia_Verklaarder/tia:verklaringBestuursorgaan/tia:informatiePB/tia:naamWaterschap"/>
		                        </xsl:when>
		                        <xsl:when test="translate($publicLawNature, $upper, $lower) = 'provincie'">
		                        	<xsl:text>de provincie </xsl:text>
		                        	<xsl:value-of select="tia:IMKAD_AangebodenStuk/tia:tia_Verklaarder/tia:verklaringBestuursorgaan/tia:informatiePB/tia:naamProvincie"/>
		                        </xsl:when>
		                        <xsl:when test="translate($publicLawNature, $upper, $lower) = 'ministerie'">
		                        	<xsl:text>het ministerie </xsl:text>
		                        	<xsl:value-of select="tia:IMKAD_AangebodenStuk/tia:tia_Verklaarder/tia:verklaringBestuursorgaan/tia:informatiePB/tia:naamMinisterie"/>
		                        </xsl:when>
		                        <xsl:otherwise><xsl:value-of select="$publicLawNature"/></xsl:otherwise>
		                    </xsl:choose>
		                    <xsl:text>, die belast zijn met door </xsl:text>
		                    <xsl:choose>
		                        <xsl:when test="translate($publicLawNature, $upper, $lower) = 'gemeente'">
		                        	<xsl:text>die gemeente </xsl:text>
		                        </xsl:when>
		                        <xsl:when test="translate($publicLawNature, $upper, $lower) = 'waterschap'">
		                        	<xsl:text>dat waterschap </xsl:text>
		                        </xsl:when>
		                        <xsl:when test="translate($publicLawNature, $upper, $lower) = 'provincie'">
		                        	<xsl:text>die provincie </xsl:text>
		                        </xsl:when>
		                        <xsl:when test="translate($publicLawNature, $upper, $lower) = 'ministerie'">
		                        	<xsl:text>dat ministerie </xsl:text>
		                        </xsl:when>
		                    </xsl:choose>
		                    <xsl:text>opgelegde publiekrechtelijke beperkingen daaromtrent nadere informatie kunnen verkrijgen bij </xsl:text>
		                    <xsl:value-of select="tia:IMKAD_AangebodenStuk/tia:tia_Verklaarder/tia:verklaringBestuursorgaan/tia:informatiePB/tia:naamAfdeling"/>
		                    <xsl:text>, </xsl:text>
		                    <xsl:value-of select="concat(substring(tia:IMKAD_AangebodenStuk/tia:tia_Verklaarder/tia:verklaringBestuursorgaan/tia:informatiePB/tia:adres/tia:BAG_NummerAanduiding/tia:postcode, 0, 5),
		                    		' ',
		                    		substring(tia:IMKAD_AangebodenStuk/tia:tia_Verklaarder/tia:verklaringBestuursorgaan/tia:informatiePB/tia:adres/tia:BAG_NummerAanduiding/tia:postcode, 5))"/>
							<xsl:text>, </xsl:text>
							<xsl:value-of select="tia:IMKAD_AangebodenStuk/tia:tia_Verklaarder/tia:verklaringBestuursorgaan/tia:informatiePB/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam"/>
							<xsl:text>, </xsl:text>
							<xsl:value-of select="tia:IMKAD_AangebodenStuk/tia:tia_Verklaarder/tia:verklaringBestuursorgaan/tia:informatiePB/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam"/>
							<xsl:text>, </xsl:text>
							<xsl:value-of select="tia:IMKAD_AangebodenStuk/tia:tia_Verklaarder/tia:verklaringBestuursorgaan/tia:informatiePB/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer"/>
							<xsl:if test="tia:IMKAD_AangebodenStuk/tia:tia_Verklaarder/tia:verklaringBestuursorgaan/tia:informatiePB/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter">
								<xsl:if test="string-length(tia:IMKAD_AangebodenStuk/tia:tia_Verklaarder/tia:verklaringBestuursorgaan/tia:informatiePB/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter) != 0">
									<xsl:text>, </xsl:text>
									<xsl:value-of select="tia:IMKAD_AangebodenStuk/tia:tia_Verklaarder/tia:verklaringBestuursorgaan/tia:informatiePB/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter"/>
								</xsl:if>
							</xsl:if>
							<xsl:if test="tia:IMKAD_AangebodenStuk/tia:tia_Verklaarder/tia:verklaringBestuursorgaan/tia:informatiePB/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging">
								<xsl:if test="string-length(tia:IMKAD_AangebodenStuk/tia:tia_Verklaarder/tia:verklaringBestuursorgaan/tia:informatiePB/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging) != 0">
									<xsl:text>, </xsl:text>
									<xsl:value-of select="tia:IMKAD_AangebodenStuk/tia:tia_Verklaarder/tia:verklaringBestuursorgaan/tia:informatiePB/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging"/>
								</xsl:if>
							</xsl:if>
		                    <xsl:if test="tia:IMKAD_AangebodenStuk/tia:tia_Verklaarder/tia:verklaringBestuursorgaan/tia:informatiePB/tia:telefoonnummer and tia:IMKAD_AangebodenStuk/tia:tia_Verklaarder/tia:verklaringBestuursorgaan/tia:informatiePB/tia:telefoonnummer != ''">                    		    
		                        <xsl:text>, </xsl:text>
		                        <xsl:value-of select="tia:IMKAD_AangebodenStuk/tia:tia_Verklaarder/tia:verklaringBestuursorgaan/tia:informatiePB/tia:telefoonnummer"/>
		                    </xsl:if>
		                    <xsl:if test="tia:IMKAD_AangebodenStuk/tia:tia_Verklaarder/tia:verklaringBestuursorgaan/tia:informatiePB/tia:e-mailadres and tia:IMKAD_AangebodenStuk/tia:tia_Verklaarder/tia:verklaringBestuursorgaan/tia:informatiePB/tia:e-mailadres != ''">                    		    
		                        <xsl:text>, </xsl:text>
		                        <xsl:value-of select="tia:IMKAD_AangebodenStuk/tia:tia_Verklaarder/tia:verklaringBestuursorgaan/tia:informatiePB/tia:e-mailadres"/>
		                    </xsl:if>
		                    <xsl:text> en gebonden zijn aan de regels, gesteld in de algemene voorwaarden welke zijn ingeschreven in </xsl:text>
		                    <xsl:apply-templates select="tia:IMKAD_AangebodenStuk/tia:tia_Verklaarder/tia:verklaringBestuursorgaan/tia:informatiePB/tia:algemeneVoorwaarden" mode="do-part-and-number"/>
		                    <xsl:text>;</xsl:text>
						</td>
					</tr>
				</xsl:if>
				<tr>
					<td class="number" valign="top">
						<xsl:text>-</xsl:text>
					</td>
					<td>
						<xsl:text>ten aanzien van de navolgende grondstukken publiekrechtelijke beperkingen</xsl:text>
		                <xsl:value-of select="$txt2"/>
                		<xsl:text>, krachtens een stuk, waarvan een afschrift als bijlage aan dit stuk is gehecht.</xsl:text>
					</td>
				</tr>
			</tbody>
		</table>
		<p><br/></p>
		<a name="wkpb.header" class="location">&#160;</a>
		<xsl:if test="normalize-space(tia:IMKAD_AangebodenStuk/tia:tia_OmschrijvingKenmerk) != ''">
			<p>
				<xsl:text>Kenmerk: </xsl:text>
				<xsl:value-of select="tia:IMKAD_AangebodenStuk/tia:tia_OmschrijvingKenmerk"/>
			</p>
			<p><br/></p>
		</xsl:if>
		<!-- Cancellation of Document (Doorhalen stuk) -->
        <a name="wkpb.deletePiece" class="location">&#160;</a>
        <xsl:if test="tia:IMKAD_AangebodenStuk/tia:StukdeelDoorhalingPR_Beperking[translate(tia:aardDoorhalingPB, $upper, $lower) = 'doorhaling']">
	        <p>
	            <xsl:text>Hierbij verzoekt ondergetekende de/het volgende stuk(ken) door te halen:</xsl:text><br/>
	            <xsl:text>De eerdere inschrijving(en) van beperkingen in</xsl:text>
	            <xsl:choose>
	            	<xsl:when test="count(tia:IMKAD_AangebodenStuk/tia:StukdeelDoorhalingPR_Beperking[translate(tia:aardDoorhalingPB, $upper, $lower) = 'doorhaling']) > 1">
		            	<br/>
	            	</xsl:when>
	            	<xsl:otherwise>
	            		<xsl:text> </xsl:text>
	            	</xsl:otherwise>
	            </xsl:choose>
	            <xsl:for-each select="tia:IMKAD_AangebodenStuk/tia:StukdeelDoorhalingPR_Beperking[translate(tia:aardDoorhalingPB, $upper, $lower) = 'doorhaling']">
	            	<xsl:apply-templates select="tia:doorTeHalenStuk" mode="do-part-and-number"/>
	            	<xsl:if test="position() != last()">
	            		<br/>
	            	</xsl:if>
	            </xsl:for-each>
	            <xsl:text>.</xsl:text>
	        </p>
			<p><br/></p>
		</xsl:if>
        <!-- Addition/cancellation of restriction (Opvoer-Onttrekking beperkingen) -->
        <xsl:choose>
			<xsl:when test="tia:IMKAD_AangebodenStuk/tia:StukdeelDoorhalingPR_Beperking[translate(tia:aardDoorhalingPB, $upper, $lower) = 'onttrekking'] or tia:IMKAD_AangebodenStuk/tia:StukdeelPR_Beperking">
		        <xsl:apply-templates select="tia:IMKAD_AangebodenStuk/tia:StukdeelDoorhalingPR_Beperking[translate(tia:aardDoorhalingPB, $upper, $lower) = 'onttrekking'] | tia:IMKAD_AangebodenStuk/tia:StukdeelPR_Beperking" mode="do-addition-or-cancellation-of-restriction" />
			</xsl:when>
			<xsl:otherwise>
				<a name="wkpb.restrictionsToAdd" class="location">&#160;</a>
				<a name="wkpb.restrictionsToWithdraw" class="location">&#160;</a>
			</xsl:otherwise>
		</xsl:choose>
       	<xsl:if test="not(tia:IMKAD_AangebodenStuk/tia:StukdeelDoorhalingPR_Beperking[translate(tia:aardDoorhalingPB, $upper, $lower) = 'onttrekking'])">
       		<a name="wkpb.restrictionsToWithdraw" class="location">&#160;</a>
       	</xsl:if>
        <!-- Replacement Area (Vervanging gebied) -->
		<a name="wkpb.replacementArea" class="location">&#160;</a>
		<xsl:apply-templates select="tia:IMKAD_AangebodenStuk/tia:StukdeelWijzigingPR_Beperking" mode="do-replacement-area" />
        <!-- Continue Document (Handhaven stuk) -->
        <xsl:choose>
			<xsl:when test="tia:IMKAD_AangebodenStuk/tia:StukdeelHandhavingPR_Beperking">
				<xsl:apply-templates select="tia:IMKAD_AangebodenStuk/tia:StukdeelHandhavingPR_Beperking" mode="do-continue-document" />
			</xsl:when>
			<xsl:otherwise>
				<a name="wkpb.maintainPiece" class="location">&#160;</a>
			</xsl:otherwise>
		</xsl:choose>
		<!-- Closing (Afsluiting) -->
		<xsl:if test="tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_anderegrondstukken']">
			<p>
				<xsl:value-of select="tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_anderegrondstukken']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
					translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_anderegrondstukken']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
					translate(normalize-space(current()/tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_anderegrondstukken']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
			</p>
		</xsl:if>
		<xsl:if test="normalize-space(tia:IMKAD_AangebodenStuk/tia:StukdeelDoorhalingPR_Beperking/tia:depotnummer) != ''
				or normalize-space(tia:IMKAD_AangebodenStuk/tia:StukdeelPR_Beperking/tia:depotnummer) != ''
				or normalize-space(tia:IMKAD_AangebodenStuk/tia:StukdeelWijzigingPR_Beperking/tia:depotnummer) != ''">
			<p>
				<xsl:text>Bijwerking van de kadastrale registers moet uitsluitend gebaseerd zijn op de contouren zoals ze in depot zijn opgenomen en behoren bij deze inschrijving en niet zoals ze in het oorspronkelijke besluit staan aangegeven en welke als bijlage zijn mee ingeschreven.</xsl:text>
			</p>
		</xsl:if>	
		<xsl:if test="tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_anderegrondstukken']
				or normalize-space(tia:IMKAD_AangebodenStuk/tia:StukdeelDoorhalingPR_Beperking/tia:depotnummer) != ''
				or normalize-space(tia:IMKAD_AangebodenStuk/tia:StukdeelPR_Beperking/tia:depotnummer) != ''
				or normalize-space(tia:IMKAD_AangebodenStuk/tia:StukdeelWijzigingPR_Beperking/tia:depotnummer) != ''">
			<p><br/></p>
		</xsl:if>
		<!-- Signature With Date (Ondertekening) -->
		<a name="wkpb.signature" class="location">&#160;</a>
		<p>
			<xsl:text>Getekend te </xsl:text>
			<xsl:value-of select="tia:IMKAD_AangebodenStuk/tia:tia_PlaatsOndertekening/tia:woonplaatsNaam"/>
			<xsl:text>, op </xsl:text>
			<xsl:if test="substring(string(tia:IMKAD_AangebodenStuk/tia:tia_DatumOndertekening), 0, 11) != ''">
				<xsl:value-of select="kef:convertMonthToText(substring(string(tia:IMKAD_AangebodenStuk/tia:tia_DatumOndertekening), 0, 11))"/>				
			</xsl:if>
			<xsl:text>.</xsl:text>
		</p>
	</xsl:template>

	<!--
	*********************************************************
	Mode: do-addition-or-cancellation-of-restriction
	*********************************************************
	Public: no

	Identity transform: no

	Description: Addition/cancellation of restriction.

	Input: tia:StukdeelDoorhalingPR_Beperking or tia:StukdeelPR_Beperking

	Params: none

	Output: XHTML structure

	Calls:
	(mode) do-part-and-number

	Called by:
	(mode) do-deed
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:StukdeelDoorhalingPR_Beperking | tia:StukdeelPR_Beperking" mode="do-addition-or-cancellation-of-restriction">
		<a name="wkpb.restrictionsToAdd" class="location">&#160;</a>
		<xsl:variable name="numberParcels" select="count(tia:IMKAD_AantekeningKadastraalObject/tia:tenLasteVan/tia:IMKAD_Perceel)"/>
		<xsl:variable name="numberApartments" select="count(tia:IMKAD_AantekeningKadastraalObject/tia:tenLasteVan/tia:IMKAD_Appartementsrecht)"/>
		<xsl:variable name="textParcels">
			<xsl:choose>
				<xsl:when test="$numberParcels = 1"><xsl:text>bij het perceel, </xsl:text></xsl:when>
				<xsl:when test="$numberParcels > 1"><xsl:text>bij de percelen, </xsl:text></xsl:when>
				<xsl:otherwise><xsl:text> </xsl:text></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="textApartments">
			<xsl:choose>
				<xsl:when test="$numberApartments = 1"><xsl:text>bij het appartementsrecht, </xsl:text></xsl:when>
				<xsl:when test="$numberApartments > 1"><xsl:text>bij de appartementsrechten, </xsl:text></xsl:when>
				<xsl:otherwise><xsl:text> </xsl:text></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:if test="local-name() = 'StukdeelDoorhalingPR_Beperking' and count(preceding-sibling::tia:StukdeelDoorhalingPR_Beperking[translate(tia:aardDoorhalingPB, $upper, $lower) = 'onttrekking']) = 0">
			<a name="wkpb.restrictionsToWithdraw" class="location">&#160;</a>
		</xsl:if>
		<xsl:if test="tia:depotnummer and tia:depotnummer != ''">
			<xsl:call-template name="additionCancellationOfRestrictionTextBlock">
				<xsl:with-param name="deedPart" select="."/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="$numberParcels >= 1">
			<xsl:call-template name="additionCancellationOfRestrictionTextBlock">
				<xsl:with-param name="deedPart" select="."/>
				<xsl:with-param name="text" select="$textParcels"/>
				<xsl:with-param name="cadastralObjects" select="tia:IMKAD_AantekeningKadastraalObject/tia:tenLasteVan/tia:IMKAD_Perceel"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="$numberApartments >= 1">
			<xsl:call-template name="additionCancellationOfRestrictionTextBlock">
				<xsl:with-param name="deedPart" select="."/>
				<xsl:with-param name="text" select="$textApartments"/>
				<xsl:with-param name="cadastralObjects" select="tia:IMKAD_AantekeningKadastraalObject/tia:tenLasteVan/tia:IMKAD_Appartementsrecht"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="not(tia:depotnummer and tia:depotnummer != '') and $numberParcels = 0 and $numberApartments = 0">
			<xsl:call-template name="additionCancellationOfRestrictionTextBlock">
				<xsl:with-param name="deedPart" select="."/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<!--
	*********************************************************
	Name: additionCancellationOfRestrictionTextBlock
	*********************************************************
	Public: no

	Identity transform: no

	Description: Addition/cancellation of restriction text.

	Input: tia:StukdeelDoorhalingPR_Beperking or tia:StukdeelPR_Beperking

	Params: none

	Output: XHTML structure

	Calls:
	(mode) do-part-and-number
	(mode) do-cadastral-identification

	Called by:
	(mode) do-addition-or-cancellation-of-restriction
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template name="additionCancellationOfRestrictionTextBlock">
		<xsl:param name="deedPart"/>
		<xsl:param name="text"/>
		<xsl:param name="cadastralObjects" select="self::node()[false()]"/>

		<xsl:variable name="txt" select="$deedPart/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_soortstuk']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_soortstuk']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space($deedPart/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_soortstuk']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
		<p>
			<xsl:text>Naar aanleiding van de in </xsl:text>
			<xsl:value-of select="$txt"/>
			<xsl:text> vermelde gegevens, verzoekt ondergetekende de basisregistratie kadaster bij te werken door</xsl:text>
			<xsl:if test="$text != ''">
				<xsl:text> </xsl:text>
				<xsl:value-of select="$text"/>
			</xsl:if>
			<xsl:for-each select="$cadastralObjects">
				<xsl:choose>
					<xsl:when test="count($cadastralObjects) > 1">
						<br/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text> </xsl:text>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:apply-templates select="tia:kadastraleAanduiding" mode="do-cadastral-identification">
					<xsl:with-param name="boldLabel" select="'false'"/>
					<xsl:with-param name="numberLabelAsParcel" select="'true'"/>
				</xsl:apply-templates>
				<xsl:text>, </xsl:text>
				<xsl:if test="translate(local-name(), $upper, $lower) = 'imkad_perceel' and tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrens']">
					<xsl:value-of select="normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrens']/tia:tekst[1])"/>
					<xsl:text>, </xsl:text>
				</xsl:if>
			</xsl:for-each>
			<xsl:if test="count($cadastralObjects) > 1">
				<br/>
			</xsl:if>
			<xsl:if test="$deedPart/tia:depotnummer and $deedPart/tia:depotnummer != ''">
				<xsl:text>, onder verwijzing naar de tekening met depotnummer </xsl:text>
				<xsl:value-of select="$deedPart/tia:depotnummer"/>
				<xsl:text>, </xsl:text>
			</xsl:if>
			<xsl:text>een beperking op grond van de </xsl:text>
			<xsl:value-of select="$deedPart/tia:wetBeperking"/>
			<xsl:choose>
				<!-- Addition of restriction -->
				<xsl:when test="translate(local-name($deedPart), $upper, $lower) = 'stukdeelpr_beperking'">
					<xsl:text> op te voeren.</xsl:text>
				</xsl:when>
				<!-- Cancellation of restriction -->
				<xsl:when test="translate(local-name($deedPart), $upper, $lower) = 'stukdeeldoorhalingpr_beperking'">
					<xsl:text> door te halen, voor zover deze betrekking heeft op inschrijving(en) in</xsl:text>
		            <xsl:choose>
		            	<xsl:when test="count($deedPart/tia:doorTeHalenStuk) > 1">
			            	<br/>
		            	</xsl:when>
		            	<xsl:otherwise>
		            		<xsl:text> </xsl:text>
		            	</xsl:otherwise>
		            </xsl:choose>
		            <xsl:for-each select="$deedPart/tia:doorTeHalenStuk">
		            	<xsl:apply-templates select="." mode="do-part-and-number"/>
		            	<xsl:if test="position() != last()">
		            		<br/>
		            	</xsl:if>
		            </xsl:for-each>
					<xsl:text>.</xsl:text>
				</xsl:when>
			</xsl:choose>
		</p>
		<p><br/></p>
	</xsl:template>

	<!--
	*********************************************************
	Mode: do-replacement-area
	*********************************************************
	Public: no

	Identity transform: no

	Description: Replacement area.

	Input: tia:StukdeelWijzigingPR_Beperking

	Params: none

	Output: XHTML structure

	Calls:
	(mode) do-part-and-number

	Called by:
	(mode) do-deed
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:StukdeelWijzigingPR_Beperking" mode="do-replacement-area">
		<p>
			<xsl:text>Omdat de in de opgave vermelde gegevens inmiddels kunnen zijn vervallen, verzoekt ondergetekende de basisregistratie kadaster bij te werken door bij de percelen, onder verwijzing naar de tekening met depotnummer </xsl:text>
			<xsl:value-of select="tia:depotnummer"/>
			<xsl:text>, een beperking op grond van de </xsl:text>
			<xsl:value-of select="tia:wetBeperking"/>
			<xsl:text> op te voeren.</xsl:text>
			<br/>
			<xsl:text>De eerdere inschrijving van beperkingen in </xsl:text>
        	<xsl:apply-templates select="tia:vervallenInschrijving" mode="do-part-and-number"/>
			<xsl:text> vervallen voor zover de in deze inschrijving met een kadastrale aanduiding omschreven grondstukken niet samenvallen met de grondstukken op voormelde met een depotnummer aangeduide tekening.</xsl:text>
		</p>
       	<p><br/></p>
	</xsl:template>

	<!--
	*********************************************************
	Mode: do-continue-document
	*********************************************************
	Public: no

	Identity transform: no

	Description: Continue document.

	Input: tia:StukdeelHandhavingPR_Beperking

	Params: none

	Output: XHTML structure

	Calls:
	(mode) do-part-and-number

	Called by:
	(mode) do-deed
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:StukdeelHandhavingPR_Beperking" mode="do-continue-document">
        <a name="wkpb.maintainPiece" class="location">&#160;</a>
        <p>
        	<xsl:text>Hierbij verzoekt ondergetekende de publiekrechtelijke beperking(en), opgelegd met een stuk/stukken, ingeschreven in</xsl:text>
             <xsl:choose>
            	<xsl:when test="count(tia:stukTeHandhavenBeperking) > 1">
	            	<br/>
            	</xsl:when>
            	<xsl:otherwise>
            		<xsl:text> </xsl:text>
            	</xsl:otherwise>
            </xsl:choose>
            <xsl:for-each select="tia:stukTeHandhavenBeperking">
            	<xsl:apply-templates select="." mode="do-part-and-number"/>
            	<xsl:if test="position() != last()">
            		<br/>
            	</xsl:if>
            </xsl:for-each>
        	<xsl:choose>
	        	<xsl:when test="count(tia:stukTeHandhavenBeperking) > 1">
	        		<br/>
	        	</xsl:when>
	        	<xsl:otherwise>
	        		<xsl:text> </xsl:text>
	        	</xsl:otherwise>
        	</xsl:choose>
        	<xsl:text>te handhaven.</xsl:text>
		</p>
       	<p><br/></p>
	</xsl:template>

</xsl:stylesheet>
