<?xml version="1.0" encoding="UTF-8"?>
<!--
*********************************************************
Stylesheet: tekstblok_erfpachtcanon.xsl
Version: 1.04
*********************************************************
Description:
Erfpachtcanon text block.

Public:
(mode) do-long-lease-ground-rent 

Private:
(name) none
-->
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
	xmlns:tia="http://www.kadaster.nl/schemas/KIK/TIA_Algemeen"
	xmlns:kef="nl.kadaster.xslt.XslExtensionFunctions"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:exslt="http://exslt.org/common"
	exclude-result-prefixes="tia kef xsl exslt"
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

	Params: title - header title of text block

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
	<xsl:template match="tia:IMKAD_AangebodenStuk" mode="do-long-lease-ground-rent">
		<xsl:param name="title" select="''"/>
		<xsl:param name="rights" select="self::node()[false()]"/>
		<xsl:variable name="registered" select="tia:StukdeelErfpachtcanon/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederen']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederen']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space(current()/tia:StukdeelErfpachtcanon/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoederen']/tia:tekst), $upper, $lower)]), $upper, $lower)]" />
		<xsl:variable name="due" select="tia:StukdeelErfpachtcanon/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verschuldigd']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verschuldigd']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space(current()/tia:StukdeelErfpachtcanon/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verschuldigd']/tia:tekst), $upper, $lower)]), $upper, $lower)]" />
		<xsl:variable name="pay" select="$keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voldoen']/tia:tekst[
			position() = translate(normalize-space(current()/tia:StukdeelErfpachtcanon/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voldoen']/tia:tekst), $upper, $lower)]" />

		<h2 class="header"><xsl:value-of select="$title"/></h2>
		<p>
			<xsl:text>De erfpachtcanon </xsl:text>
			<xsl:choose>
				<xsl:when test="tia:StukdeelErfpachtcanon">
					<xsl:text>van</xsl:text>
					<xsl:choose>
						<xsl:when test="$registered = '1'">
							<xsl:if test="$rights">
								<xsl:text> </xsl:text>
							</xsl:if>
							<xsl:choose>
								<xsl:when test="count($rights[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_erfpachtcanon']/tia:tekst, $upper, $lower) = 'true']) = 1">
									<xsl:text>de Registergoed </xsl:text>
								</xsl:when>
								<xsl:when test="count($rights[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_erfpachtcanon']/tia:tekst, $upper, $lower) = 'true']) > 1">
									<xsl:text>het Registergoederen </xsl:text>
								</xsl:when>
							</xsl:choose>
							<xsl:for-each select="$rights[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_erfpachtcanon']/tia:tekst, $upper, $lower) = 'true']">
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
							<xsl:value-of select="$registered"/>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:text> bedraagt jaarlijks </xsl:text>
					<xsl:call-template name="amountText">
        				<xsl:with-param name="amount" select="tia:StukdeelErfpachtcanon/tia:bedrag/tia:som" />
        				<xsl:with-param name="valuta" select="tia:StukdeelErfpachtcanon/tia:bedrag/tia:valuta" />
        			</xsl:call-template>
        			<xsl:text> </xsl:text>
        			<xsl:call-template name="amountNumber">
        				<xsl:with-param name="amount" select="tia:StukdeelErfpachtcanon/tia:bedrag/tia:som" />
        				<xsl:with-param name="valuta" select="tia:StukdeelErfpachtcanon/tia:bedrag/tia:valuta" />
        			</xsl:call-template>
					<xsl:if test="tia:StukdeelErfpachtcanon/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voldoen']/tia:tekst
							and normalize-space(tia:StukdeelErfpachtcanon/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voldoen']/tia:tekst) != ''">
						<xsl:variable name="orderNumberOfFirstMonth" select="number(tia:StukdeelErfpachtcanon/tia:betaling[1]/tia:betaalMaand)"/>
					    <xsl:variable name="orderNumberOfSecondMonth" select="number(tia:StukdeelErfpachtcanon/tia:betaling[2]/tia:betaalMaand)"/>
					    
						<xsl:text>, en moet </xsl:text>
						<xsl:if test="normalize-space($due) != ''">
							<xsl:value-of select="$due"/>
							<xsl:text> </xsl:text>
						</xsl:if>
						<xsl:choose>
							<xsl:when test="tia:StukdeelErfpachtcanon/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voldoen']/tia:tekst = '2' 
												or tia:StukdeelErfpachtcanon/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voldoen']/tia:tekst = '3'">
								<xsl:variable name="textAfterBetaalDag" select="substring-after($pay, '{betaalDag}')"/>
								<xsl:variable name="textAfterBetaalMaand" select="substring-after($textAfterBetaalDag, '{betaalMaand}')"/>
								
								<xsl:value-of select="concat(substring-before($pay, '{betaalDag}'), kef:convertOrdinalToText(tia:StukdeelErfpachtcanon/tia:betaling[1]/tia:betaalDag))"/>
								<xsl:value-of select="concat(substring-before($textAfterBetaalDag, '{betaalMaand}'), $monthsInText/tia:months/tia:month[$orderNumberOfFirstMonth])"/>
								<xsl:value-of select="concat(substring-before($textAfterBetaalMaand, '{betaalMaand}'), $monthsInText/tia:months/tia:month[$orderNumberOfSecondMonth], substring-after($textAfterBetaalMaand, '{betaalMaand}'))"/>
							</xsl:when>
							<xsl:when test="tia:StukdeelErfpachtcanon/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voldoen']/tia:tekst = '8' 
												or tia:StukdeelErfpachtcanon/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voldoen']/tia:tekst = '9'">
								<xsl:variable name="textAfterFirstBetaalMaand" select="substring-after($pay, '{betaalMaand}')"/>
								<xsl:variable name="textAfterSecondBetaalMaand" select="substring-after($textAfterFirstBetaalMaand, '{betaalMaand}')"/>
								<xsl:variable name="Datum_DATE" select="substring(string(tia:StukdeelErfpachtcanon/tia:startBetaling), 0, 11)"/>
								<xsl:variable name="Datum_STRING">
						 			<xsl:if test="$Datum_DATE != ''">
										<xsl:value-of select="kef:convertDateToText($Datum_DATE)"/>
									</xsl:if>
								</xsl:variable>
								
								<xsl:value-of select="concat(substring-before($pay, '{betaalDag}'), kef:convertNumberToText(tia:StukdeelErfpachtcanon/tia:betaling[1]/tia:betaalDag), ' ', $monthsInText/tia:months/tia:month[$orderNumberOfFirstMonth])"/>
								<xsl:value-of select="concat(substring-before($textAfterFirstBetaalMaand, '{betaalDag}'), kef:convertNumberToText(tia:StukdeelErfpachtcanon/tia:betaling[2]/tia:betaalDag), ' ', $monthsInText/tia:months/tia:month[$orderNumberOfSecondMonth])"/>
								<xsl:value-of select="concat(substring-before($textAfterSecondBetaalMaand, '{startBetaling}'), $Datum_STRING, substring-after($textAfterSecondBetaalMaand, '{startBetaling}'))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="$pay"/>
							</xsl:otherwise>
						</xsl:choose>					
					</xsl:if>
				</xsl:when>
				<xsl:when test="tia:StukdeelErfpachtcanonTijdelijkAfgekocht">
					<xsl:variable name="Datum_DATE" select="substring(string(tia:StukdeelErfpachtcanonTijdelijkAfgekocht/tia:afgekochtVanaf), 0, 11)"/>
					<xsl:variable name="Datum_STRING">
			 			<xsl:if test="$Datum_DATE != ''">
							<xsl:value-of select="kef:convertDateToText($Datum_DATE)"/>
						</xsl:if>
					</xsl:variable>

					<xsl:text>is afgekocht voor een periode van </xsl:text>
					<xsl:value-of select="tia:StukdeelErfpachtcanonTijdelijkAfgekocht/tia:aantalJaar"/>
					<xsl:text> jaar, te rekenen vanaf </xsl:text>
					<xsl:value-of select="$Datum_STRING"/>
					<xsl:text> en wel voor een bedrag van totaal </xsl:text>
					<xsl:call-template name="amountText">
        				<xsl:with-param name="amount" select="tia:StukdeelErfpachtcanonTijdelijkAfgekocht/tia:bedrag/tia:som" />
        				<xsl:with-param name="valuta" select="tia:StukdeelErfpachtcanonTijdelijkAfgekocht/tia:bedrag/tia:valuta" />
        			</xsl:call-template>
        			<xsl:text> </xsl:text>
        			<xsl:call-template name="amountNumber">
        				<xsl:with-param name="amount" select="tia:StukdeelErfpachtcanonTijdelijkAfgekocht/tia:bedrag/tia:som" />
        				<xsl:with-param name="valuta" select="tia:StukdeelErfpachtcanonTijdelijkAfgekocht/tia:bedrag/tia:valuta" />
        			</xsl:call-template>
				</xsl:when>
				<xsl:when test="tia:StukdeelErfpachtcanonEeuwigAfgekocht">
					<xsl:text>is volledig afgekocht over de gehele duur van de erfpachtcanon met een bedrag ineens van </xsl:text>
					<xsl:call-template name="amountText">
        				<xsl:with-param name="amount" select="tia:StukdeelErfpachtcanonEeuwigAfgekocht/tia:bedrag/tia:som" />
        				<xsl:with-param name="valuta" select="tia:StukdeelErfpachtcanonEeuwigAfgekocht/tia:bedrag/tia:valuta" />
        			</xsl:call-template>
        			<xsl:text> </xsl:text>
        			<xsl:call-template name="amountNumber">
        				<xsl:with-param name="amount" select="tia:StukdeelErfpachtcanonEeuwigAfgekocht/tia:bedrag/tia:som" />
        				<xsl:with-param name="valuta" select="tia:StukdeelErfpachtcanonEeuwigAfgekocht/tia:bedrag/tia:valuta" />
        			</xsl:call-template>
				</xsl:when>
			</xsl:choose>
			<xsl:text>.</xsl:text>
		</p>	
	</xsl:template>
</xsl:stylesheet>
