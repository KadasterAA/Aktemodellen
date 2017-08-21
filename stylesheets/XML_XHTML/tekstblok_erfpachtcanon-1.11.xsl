<?xml version="1.0" encoding="UTF-8"?>
<!--
*********************************************************
Stylesheet: tekstblok_erfpachtcanon.xsl
Version: 1.11
*********************************************************
Description:
Erfpachtcanon text block.

Public:
(mode) do-long-lease-ground-rent 

Private:
(mode) do-long-lease-ground-rent-variant
-->
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
	xmlns:tia="http://www.kadaster.nl/schemas/KIK/TIA_Algemeen"
	xmlns:kef="nl.kadaster.xslt.XslExtensionFunctions"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xlink="http://www.w3.org/1999/xlink"
	xmlns:exslt="http://exslt.org/common"
	exclude-result-prefixes="tia kef xsl exslt xlink"
	version="1.0">

	<xsl:variable name="_monthsInText">
		<tia:months>
			<tia:month><xsl:text>januari</xsl:text></tia:month>
			<tia:month><xsl:text>februari</xsl:text></tia:month>
			<tia:month><xsl:text>maart</xsl:text></tia:month>
			<tia:month><xsl:text>april</xsl:text></tia:month>
			<tia:month><xsl:text>mei</xsl:text></tia:month>
			<tia:month><xsl:text>juni</xsl:text></tia:month>
			<tia:month><xsl:text>juli</xsl:text></tia:month>
			<tia:month><xsl:text>augustus</xsl:text></tia:month>
			<tia:month><xsl:text>september</xsl:text></tia:month>
			<tia:month><xsl:text>oktober</xsl:text></tia:month>
			<tia:month><xsl:text>november</xsl:text></tia:month>
			<tia:month><xsl:text>december</xsl:text></tia:month>
		</tia:months>
	</xsl:variable>
	<xsl:variable name="monthsInText" select="exslt:node-set($_monthsInText)"/>

	<!--
	*********************************************************
	Mode: do-long-lease-ground-rent
	*********************************************************
	Public: yes

	Identity transform: no

	Description: Erfpachtcanon text block.

	Input: tia:IMKAD_AangebodenStuk

	Params: rights

	Output: text

	Calls:
	(name) amountText
	(name) amountNumber	

	Called by:
	(mode) do-deed
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:StukdeelErfpachtcanon | tia:StukdeelErfpachtcanonTijdelijkAfgekocht | tia:StukdeelErfpachtcanonEeuwigAfgekocht" mode="do-long-lease-ground-rent">
		<xsl:param name="rights" select="self::node()[false()]"/>
		
		<xsl:variable name="currentStukdeel" select="."/>
		<xsl:variable name="registeredStukdeelErfpachtcanon" select="$currentStukdeel/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederen']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederen']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space($currentStukdeel/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederen']/tia:tekst), $upper, $lower)]), $upper, $lower)]" />
		<xsl:variable name="numberOfStukdeelErfpachtcanon" select="count(tia:RegistergoedRef)"/>
	
		<p>
			<xsl:text>De erfpachtcanon van </xsl:text>
			<xsl:choose>
				<xsl:when test="$registeredStukdeelErfpachtcanon = '1'">
					<xsl:if test="$rights">
						<xsl:text> </xsl:text>
					</xsl:if>
					<xsl:choose>
						<xsl:when test="($numberOfStukdeelErfpachtcanon = 1)">
							<xsl:text>het Registergoed </xsl:text>
						</xsl:when>
						<xsl:when test="($numberOfStukdeelErfpachtcanon > 1)">
							<xsl:text>de Registergoederen </xsl:text>
						</xsl:when>
					</xsl:choose>

					<xsl:for-each select="$rights[concat('#', @id) = $currentStukdeel/tia:RegistergoedRef/@xlink:href]">
					
						<xsl:value-of select="count(preceding-sibling::tia:IMKAD_ZakelijkRecht) + 1"/>
						<xsl:choose>
							<xsl:when test="position() = last() - 1">
								<xsl:text> en </xsl:text>
							</xsl:when>
							<xsl:when test="position() != last()">
								<xsl:text>, </xsl:text>
							</xsl:when>
						</xsl:choose> 	
					</xsl:for-each>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text> </xsl:text>
					<xsl:if test="$currentStukdeel/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederen']/tia:tekst">
						<xsl:if test="normalize-space($registeredStukdeelErfpachtcanon) != ''">
							<xsl:value-of select="$registeredStukdeelErfpachtcanon"/>
						</xsl:if>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:apply-templates select="$currentStukdeel" mode="do-long-lease-ground-rent-variant"/>
			<xsl:text>.</xsl:text>
		</p>	
	</xsl:template>
	
	<!--
	*********************************************************
	Mode: do-long-lease-ground-rent-variant
	*********************************************************
	Public: yes

	Identity transform: no

	Description: Variant within Erfpachtcanon text block.

	Input: tia:StukdeelErfpachtcanon

	Params: none

	Output: text

	Calls:
	(name) amountText
	(name) amountNumber	

	Called by:
	(mode) do-long-lease-ground-rent
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:StukdeelErfpachtcanon" mode="do-long-lease-ground-rent-variant">
		<xsl:variable name="due" select="tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verschuldigd']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verschuldigd']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space(current()/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verschuldigd']/tia:tekst), $upper, $lower)]), $upper, $lower)]" />
		<xsl:variable name="pay" select="$keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voldoen']/tia:tekst[
			position() = translate(normalize-space(current()/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voldoen']/tia:tekst), $upper, $lower)]" />

		<xsl:text> bedraagt jaarlijks </xsl:text>	
		<xsl:call-template name="amountText">
        	<xsl:with-param name="amount" select="tia:bedrag/tia:som" />
        	<xsl:with-param name="valuta" select="tia:bedrag/tia:valuta" />
        </xsl:call-template>
        <xsl:text> </xsl:text>
        <xsl:call-template name="amountNumber">
        	<xsl:with-param name="amount" select="tia:bedrag/tia:som" />
        	<xsl:with-param name="valuta" select="tia:bedrag/tia:valuta" />
        </xsl:call-template>
		<xsl:if test="tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voldoen']/tia:tekst
					and normalize-space(tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voldoen']/tia:tekst) != ''">
			<xsl:variable name="orderNumberOfFirstMonth" select="number(tia:betaling[1]/tia:betaalMaand)"/>
			<xsl:variable name="orderNumberOfSecondMonth" select="number(tia:betaling[2]/tia:betaalMaand)"/>
			<xsl:text>, en moet </xsl:text>
			<xsl:if test="normalize-space($due) != ''">
				<xsl:value-of select="$due"/>
				<xsl:text> </xsl:text>
			</xsl:if>
			<xsl:choose>
				<xsl:when test="tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voldoen']/tia:tekst = '2' 
							or tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voldoen']/tia:tekst = '3'">
					<xsl:variable name="textAfterBetaalDag" select="substring-after($pay, '{betaalDag}')"/>
					<xsl:variable name="textAfterBetaalMaand" select="substring-after($textAfterBetaalDag, '{betaalMaand}')"/>
								
					<xsl:value-of select="concat(substring-before($pay, '{betaalDag}'), kef:convertOrdinalToText(tia:betaling[1]/tia:betaalDag))"/>
					<xsl:value-of select="concat(substring-before($textAfterBetaalDag, '{betaalMaand}'), $monthsInText/tia:months/tia:month[$orderNumberOfFirstMonth])"/>
					<xsl:value-of select="concat(substring-before($textAfterBetaalMaand, '{betaalMaand}'), $monthsInText/tia:months/tia:month[$orderNumberOfSecondMonth], substring-after($textAfterBetaalMaand, '{betaalMaand}'))"/>
				</xsl:when>
				<xsl:when test="tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voldoen']/tia:tekst = '8' 
							or tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voldoen']/tia:tekst = '9'">
					<xsl:variable name="textAfterFirstBetaalMaand" select="substring-after($pay, '{betaalMaand}')"/>
					<xsl:variable name="textAfterSecondBetaalMaand" select="substring-after($textAfterFirstBetaalMaand, '{betaalMaand}')"/>
					<xsl:variable name="Datum_DATE" select="substring(string(tia:startBetaling), 0, 11)"/>
					<xsl:variable name="Datum_STRING">
						<xsl:if test="$Datum_DATE != ''">
							<xsl:value-of select="kef:convertDateToText($Datum_DATE)"/>
						</xsl:if>
					</xsl:variable>
								
					<xsl:value-of select="concat(substring-before($pay, '{betaalDag}'), kef:convertNumberToText(tia:betaling[1]/tia:betaalDag), ' ', $monthsInText/tia:months/tia:month[$orderNumberOfFirstMonth])"/>
					<xsl:value-of select="concat(substring-before($textAfterFirstBetaalMaand, '{betaalDag}'), kef:convertNumberToText(tia:betaling[2]/tia:betaalDag), ' ', $monthsInText/tia:months/tia:month[$orderNumberOfSecondMonth])"/>
					<xsl:value-of select="concat(substring-before($textAfterSecondBetaalMaand, '{startBetaling}'), $Datum_STRING, substring-after($textAfterSecondBetaalMaand, '{startBetaling}'))"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$pay"/>
				</xsl:otherwise>
			</xsl:choose>					
		</xsl:if>
	</xsl:template>
	
	<!--
	*********************************************************
	Mode: do-long-lease-ground-rent-variant
	*********************************************************
	Public: yes

	Identity transform: no

	Description: Variant within Erfpachtcanon text block.

	Input: tia:StukdeelErfpachtcanonTijdelijkAfgekocht

	Params: none

	Output: text

	Calls:
	(name) amountText
	(name) amountNumber	

	Called by:
	(mode) do-long-lease-ground-rent
	-->

	<!--
	**** matching template ********************************************************************************
	-->	
	<xsl:template match="tia:StukdeelErfpachtcanonTijdelijkAfgekocht" mode="do-long-lease-ground-rent-variant">
		<xsl:variable name="Datum_DATE" select="substring(string(tia:afgekochtVanaf), 0, 11)"/>
		<xsl:variable name="Datum_STRING">
		<xsl:if test="$Datum_DATE != ''">
			<xsl:value-of select="kef:convertDateToText($Datum_DATE)"/>
		</xsl:if>
		</xsl:variable>
		<xsl:text> is afgekocht voor een periode van </xsl:text>
		<xsl:value-of select="kef:convertNumberToText(string(tia:aantalJaar))"/>
		<xsl:text> jaar, te rekenen vanaf </xsl:text>
		<xsl:value-of select="$Datum_STRING"/>
		<xsl:if test="normalize-space(tia:bedrag) != ''">
			<xsl:text> en wel voor een bedrag van totaal </xsl:text>
			<xsl:call-template name="amountText">
	        	<xsl:with-param name="amount" select="tia:bedrag/tia:som" />
	        	<xsl:with-param name="valuta" select="tia:bedrag/tia:valuta" />
	        </xsl:call-template>
	        <xsl:text> </xsl:text>
	        <xsl:call-template name="amountNumber">
	        	<xsl:with-param name="amount" select="tia:bedrag/tia:som" />
	        	<xsl:with-param name="valuta" select="tia:bedrag/tia:valuta" />
	        </xsl:call-template>
		</xsl:if>
	</xsl:template>
	
	<!--
	*********************************************************
	Mode: do-long-lease-ground-rent-variant
	*********************************************************
	Public: yes

	Identity transform: no

	Description: Variant within Erfpachtcanon text block.

	Input: tia:StukdeelErfpachtcanonEeuwigAfgekocht

	Params: none

	Output: text

	Calls:
	(name) amountText
	(name) amountNumber	

	Called by:
	(mode) do-long-lease-ground-rent
	-->

	<!--
	**** matching template ********************************************************************************
	-->	
	<xsl:template match="tia:StukdeelErfpachtcanonEeuwigAfgekocht" mode="do-long-lease-ground-rent-variant">
		<xsl:variable name="buyoffDate" select="tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_afkooptermijn']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
						translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_afkooptermijn']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
						translate(normalize-space(current()/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_afkooptermijn']/tia:tekst), $upper, $lower)]), $upper, $lower)]" />
		<xsl:text> is</xsl:text>
		<xsl:if test="normalize-space($buyoffDate) = 'volledig afgekocht over de gehele duur van de erfpachtcanon' or normalize-space($buyoffDate) = 'eeuwigdurend afgekocht'">
			<xsl:text> </xsl:text>
			<xsl:value-of select="$buyoffDate" />					
		</xsl:if>
		<xsl:if test="normalize-space(tia:bedrag) != ''">
			<xsl:text> met een bedrag ineens van </xsl:text>
			<xsl:call-template name="amountText">
	        	<xsl:with-param name="amount" select="tia:bedrag/tia:som" />
	        	<xsl:with-param name="valuta" select="tia:bedrag/tia:valuta" />
	        </xsl:call-template>
	        <xsl:text> </xsl:text>
	        <xsl:call-template name="amountNumber">
	        	<xsl:with-param name="amount" select="tia:bedrag/tia:som" />
	        	<xsl:with-param name="valuta" select="tia:bedrag/tia:valuta" />
	        </xsl:call-template>
		</xsl:if>
	</xsl:template>
	
</xsl:stylesheet>
