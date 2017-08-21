<?xml version="1.0" encoding="UTF-8"?>
<!--
*********************************************************
Stylesheet: hypotheek_abn_amro_aab.xsl
Version: 1.80 (JIRA: AA-2230: TB Recht)
*********************************************************
Description:
ABN AMRO mortgage deed.

Public:
(mode) do-deed
-->
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
	xmlns:tia="http://www.kadaster.nl/schemas/KIK/TIA_Algemeen"
	xmlns:kef="nl.kadaster.xslt.XslExtensionFunctions"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	exclude-result-prefixes="tia kef xsl"
	version="1.0">

	<xsl:include href="hypotheek_abn_amro_generiek-1.80.xsl" />

	<!-- ABN AMRO AAB specific global variables -->
	<xsl:variable name="keuzeteksten" select="document('keuzeteksten_hypotheek_abn_amro_aab-1.26.xml')" />
	<!--
	*********************************************************
	Mode: do-deed
	*********************************************************
	Public: yes

	Identity transform: no

	Description: ABN AMRO AAB mortgage deed.

	Input: tia:Bericht_TIA_Stuk

	Params: none

	Output: XHTML structure

	Calls:
	(mode) do-statement-of-equivalence
	(mode) do-header
	(mode) do-parties
	(mode) do-rights
	(mode) do-bridging-mortgage
	(mode) do-election-of-domicile
	(mode) do-free-text
	(name) amountText
	(name) amountNumber

	Called by:
	Root template
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:Bericht_TIA_Stuk" mode="do-deed">
		<xsl:apply-templates select="." mode="do-statement-of-equivalence"/>
		<xsl:apply-templates select="." mode="do-header"/>		
		<xsl:apply-templates select="." mode="do-parties">
			<xsl:with-param name="name-addition" select="'AAB'"/>
		</xsl:apply-templates>		
		<!-- Details of Mortgage -->
		<a name="hyp3.detailsOfMortgage" class="location">&#160;</a>
		<p>
			<xsl:text>Van gemelde volmacht(en) is mij, notaris genoegzaam gebleken.</xsl:text>
		</p>
		<p>
			<xsl:text>De comparanten</xsl:text>
			<xsl:value-of select="tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_handelendals']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
				translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_handelendals']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
				translate(normalize-space(current()/tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_handelendals']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
			<xsl:text> verklaarden dat tussen de Bank en de Schuldenaar is overeengekomen een geldlening met hypotheekstelling en inpandgeving aan te gaan, van welke overeenkomst blijkt uit een aan deze Akte gehechte, door de Schuldenaar ondertekende offerte, ter uitvoering waarvan zij het volgende zijn overeengekomen.</xsl:text>
		</p>		
		<table cellspacing="0" cellpadding="0">
			<tbody>
				<tr>
					<td class="number" valign="top">
						<xsl:text>1.</xsl:text>
					</td>
					<td colspan="2">
						<u><xsl:text>LENING</xsl:text></u>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<td class="number" valign="top">
						<xsl:text>a.</xsl:text>
					</td>
					<td>
						<xsl:text>De Schuldenaar verklaarde wegens van de Bank ter leen ontvangen gelden (hoofdelijk) schuldig te zijn aan de Bank een bedrag van </xsl:text>
						<xsl:call-template name="amountText">
							<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragLening/tia:som" />
							<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragLening/tia:valuta" />
						</xsl:call-template>
						<xsl:text> </xsl:text>
						<xsl:call-template name="amountNumber">
							<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragLening/tia:som" />
							<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragLening/tia:valuta" />
						</xsl:call-template>
						<xsl:text>. De Bank verklaarde de hiervoor vermelde schuldbekentenis te aanvaarden.</xsl:text>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<td class="number" valign="top">
						<xsl:text>b.</xsl:text>
					</td>
					<td>
						<xsl:text>Door de Schuldenaar zullen ten behoeve van de Bank een recht van hypotheek en  pandrechten worden verleend op de in deze Akte omschreven goederen, tot zekerheid zoals in deze Akte wordt omschreven.</xsl:text>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<td class="number" valign="top">
						<xsl:text>c.</xsl:text>
					</td>
					<td>
						<xsl:text>Met betrekking tot deze lening hebben de comparanten verklaard dat de Bank en de Schuldenaar het volgende zijn overeengekomen.</xsl:text>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>2.</xsl:text>
					</td>
					<td colspan="2">
						<u><xsl:text>Looptijd en aflossing</xsl:text></u>
						<br/>
						<xsl:text>De lening heeft een looptijd zoals in de offerte is overeengekomen. De aflossing van de lening vindt plaats op de wijze zoals in de offerte is overeengekomen, respectievelijk zoals eventueel nader tussen partijen zal worden overeengekomen.</xsl:text>
						<br/>
						<u><xsl:text>Rente en administratiekosten</xsl:text></u>
						<br/>
						<xsl:text>De Schuldenaar is voor het eerst vanaf de datum omschreven in de toepasselijke Voorwaarden ABN AMRO Hypotheekvormen tot het einde van de desbetreffende maand naar het in de offerte overeengekomen percentage rente verschuldigd, berekend over de lening. Eventueel verschuldigde administratiekosten worden separaat maandelijks in rekening gebracht. De rente wordt voor iedere volgende maand naar het overeengekomen percentage berekend over de lening per het einde van de daaraan voorafgaande maand. Bij de saldobepaling van de geldlening zullen eventueel verschuldigde maar niet betaalde rente, kosten en andere bedragen bij de lening worden geteld.</xsl:text>
						<br/>
						<u><xsl:text>Overige bepalingen</xsl:text></u>
						<br/>
						<xsl:text>Verder zijn op voormelde lening de volgende voorwaarden van toepassing:</xsl:text>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<td class="number" valign="top">
						<xsl:text>-</xsl:text>
					</td>
					<td>
						<xsl:text>de Voorwaarden ABN AMRO Hypotheekvormen</xsl:text>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<td class="number" valign="top">
						<xsl:text>-</xsl:text>
					</td>
					<td>
						<xsl:text>Algemene Bepalingen voor Hypotheken</xsl:text>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<td class="number" valign="top">
						<xsl:text>-</xsl:text>
					</td>
					<td>
						<xsl:text>Algemene Voorwaarden ABN AMRO Bank N.V.</xsl:text>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<td colspan="2">
						<xsl:text>In de offerte die aan deze akte is gehecht staat precies aangegeven welke versies van genoemde voorwaarden op de lening van toepassing zijn. De drie genoemde voorwaarden worden hierna tezamen de "Algemene Bepalingen" genoemd.</xsl:text>
					</td>
				</tr>
			</tbody>
		</table>
		<xsl:if test="translate(tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_svnstarterslening']/tia:tekst, $upper, $lower) = 'true'">
			<p><u><xsl:text>SVn Starterslening</xsl:text></u></p>
			<p>
				<xsl:text>In verband met de door de Stichting Stimuleringsfonds Volkshuisvesting Nederlandse Gemeenten (SVn) te verstrekken Starterslening, heeft de Bank zich jegens SVn en Stichting Waarborgfonds Eigen Woningen (WEW) verplicht, na het ingaan van de lening geen gelden meer onder verband van de eerste hypotheekstelling ter leen te verstrekken aan de Schuldenaar. Tevens heeft de Bank zich jegens SVn en WEW verplicht reeds afgeloste bedragen op de lening, onder verband van de eerste hypotheekstelling, niet opnieuw te laten opnemen door de Schuldenaar. Voormelde verplichtingen rusten op de Bank uitsluitend zolang de bij SVn aangegane Starterslening niet volledig is afgelost.</xsl:text>
			</p>	
		</xsl:if>
		<!-- Mortgage charges -->
		<a name="hyp3.mortgageAmountAndAdditionalCosts" class="location">&#160;</a>
		<p><u><xsl:text>HYPOTHEEKSTELLING EN VERPANDING</xsl:text></u></p>
		<p>
			<xsl:text>De Schuldenaar verklaarde bij deze ten behoeve van de Bank het recht van hypotheek, welk recht de Bank hierbij van de Schuldenaar aanvaardt, te verlenen tot een bedrag van </xsl:text>
			<xsl:call-template name="amountText">
				<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:hoofdsom/tia:som" />
				<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:hoofdsom/tia:valuta" />
			</xsl:call-template>
			<xsl:text> </xsl:text>
			<xsl:call-template name="amountNumber">
				<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:hoofdsom/tia:som" />
				<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:hoofdsom/tia:valuta" />
			</xsl:call-template>
			<xsl:text> met rente en kosten begroot op </xsl:text>
			<xsl:call-template name="amountText">
				<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragRente/tia:som" />
				<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragRente/tia:valuta" />
			</xsl:call-template>
			<xsl:text> </xsl:text>
			<xsl:call-template name="amountNumber">
				<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragRente/tia:som" />
				<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragRente/tia:valuta" />
			</xsl:call-template>
			<xsl:text>; dus tezamen ten belope van </xsl:text>
			<xsl:call-template name="amountText">
				<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragTotaal/tia:som" />
				<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragTotaal/tia:valuta" />
			</xsl:call-template>
			<xsl:text> </xsl:text>
			<xsl:call-template name="amountNumber">
				<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragTotaal/tia:som" />
				<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragTotaal/tia:valuta" />
			</xsl:call-template>
			<xsl:text> op elk van de hierna in deze akte genoemde goederen afzonderlijk, voor de gehele som met rente en kosten.</xsl:text>
		</p>			
		<!-- Registered objects -->
		<a name="hyp3.rights" class="location">&#160;</a>
		<p>
			<xsl:text>Schuldenaar verleent bij deze aan de Bank, die dit van Schuldenaar aanvaardt, het recht van</xsl:text>
			<xsl:if test="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:rangordeHypotheek">
					<xsl:text> </xsl:text>
				<xsl:value-of select="kef:convertOrdinalToText(tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:rangordeHypotheek)"></xsl:value-of>
			</xsl:if>
			<xsl:text> hypotheek op het hierna te beschrijven onderpand:</xsl:text>
		</p>
		<xsl:apply-templates select="." mode="do-rights"/>		
		<!-- Bridging mortgage -->
		<xsl:apply-templates select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[translate(tia:aanduidingHypotheek, $upper, $lower) = 'overbruggingshypotheek']" mode="do-bridging-mortgage"/>
		<xsl:if test="not(tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[translate(tia:aanduidingHypotheek, $upper, $lower) = 'overbruggingshypotheek'])">
			<a name="hyp3.bridgingMortgage" class="location">&#160;</a>
		</xsl:if>
		<p>De Bank verklaarde hierbij alle aan haar gegeven rechten en bevoegdheden te aanvaarden.</p>
		<xsl:apply-templates select="." mode="do-election-of-domicile"/>
		<p><xsl:text>EINDE KADASTERDEEL</xsl:text></p>
		<xsl:apply-templates select="." mode="do-free-text"/>
	</xsl:template>

</xsl:stylesheet>
