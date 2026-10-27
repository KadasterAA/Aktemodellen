<?xml version="1.0" encoding="UTF-8"?>
<!--
*********************************************************
Stylesheet: hypotheek_abn_amro_florius.xsl
Version: 6.0.0
- [AA-9733] ABN AMRO- AAB nieuw bankmodel
*********************************************************
Description:
ABN AMRO Florius mortgage deed.

Public:
(mode) do-deed
-->
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
	xmlns:tia="http://www.kadaster.nl/schemas/KIK/TIA_Algemeen"
	xmlns:kef="nl.kadaster.xslt.XslExtensionFunctions"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	exclude-result-prefixes="tia kef xsl"
	version="1.0">

	<xsl:include href="hypotheek_abn_amro_generiek-6.00.xsl" />

	<xsl:variable name="keuzeteksten" select="document('keuzeteksten_hypotheek_abn_amro_florius-6.0.0.xml')"/>
	<!--
	*********************************************************
	Mode: do-deed
	*********************************************************
	Public: yes

	Identity transform: no

	Description: ABN AMRO Florius mortgage deed.

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
			<xsl:with-param name="name-addition" select="'Florius'"/>
		</xsl:apply-templates>
		<p>
			<xsl:text>Van gemelde volmacht(en) is mij, notaris genoegzaam gebleken.</xsl:text>
		</p>
		<!-- Details of Mortgage -->
		<a name="hyp3.detailsOfMortgage" class="location">&#160;</a>
		<p>
			<xsl:text>De comparanten verklaarden dat tussen Florius en de schuldenaar is overeengekomen een geldlening met hypotheekstelling en inpandgeving aan te gaan, van welke overeenkomst blijkt uit een aan deze akte gehechte, door de schuldenaar ondertekende offerte, ter uitvoering waarvan zij het volgende zijn overeengekomen.</xsl:text>
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
    					<xsl:text>De schuldenaar verklaarde wegens van Florius ter leen ontvangen gelden (hoofdelijk) schuldig te zijn aan Florius een bedrag van </xsl:text>
    					<xsl:call-template name="amountText">
        					<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragLening/tia:som" />
							<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragLening/tia:valuta" />
        				</xsl:call-template>
        				<xsl:text> </xsl:text>
        				<xsl:call-template name="amountNumber">
        					<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragLening/tia:som" />
							<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragLening/tia:valuta" />
        				</xsl:call-template>
    					<xsl:text>. Florius verklaarde de hiervoor vermelde schuldbekentenis te aanvaarden.</xsl:text>
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
    					<xsl:text>Voorts kunnen te eniger tijd uit hoofde van de onderhavige overeenkomst onder (in eventueel alsdan uit te brengen offertes) nader te bepalen voorwaarden eventuele overige uitbetalingen ten behoeve van de schuldenaar geschieden, indien en voorzover Florius en de schuldenaar zulks alsdan mochten overeenkomen.</xsl:text>
		    		</td>
		    	</tr>
		    	<tr>
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<td colspan="2">
			    		<xsl:text>Tot zekerheid voor de terugbetaling van de hoofdsom en de betaling van het verder verschuldigde, waaronder mede begrepen al hetgeen de schuldenaar op grond van het hierboven sub b bepaalde verschuldigd mocht zijn, zal ten behoeve van Florius recht van hypotheek casu quo pand worden gevestigd zoals hierna wordt omschreven.</xsl:text>
			    		<br/> 
			    		<xsl:text>Met betrekking tot deze lening hebben de comparanten verklaard dat Florius en de schuldenaar het volgende zijn overeengekomen.</xsl:text>
			    	</td>
			    </tr>
			    <tr>
					<td class="number" valign="top">
						<xsl:text>2.</xsl:text>
					</td>
					<td class="number" valign="top">
						<xsl:text>I.</xsl:text>
					</td>
					<td>
        			    <u><xsl:text>Looptijd en aflossing</xsl:text></u>
        			    <br/>
        			    <xsl:text>De lening heeft een looptijd zoals in de offerte is overeengekomen. De aflossing van de lening vindt plaats op de wijze zoals in de offerte is overeengekomen, respectievelijk zoals eventueel nader tussen partijen zal worden overeengekomen.</xsl:text>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<td class="number" valign="top">
						<xsl:text>II.</xsl:text>
					</td>
					<td>
        			    <u><xsl:text>Rente</xsl:text></u>
        			    <br/>
        			    <xsl:text>De schuldenaar is voor het eerst vanaf de datum omschreven in de toepasselijke leningsvoorwaarden tot het einde van de desbetreffende maand naar het overeengekomen percentage rente verschuldigd, berekend over de schuld. De rente wordt voor iedere volgende maand naar het overeengekomen percentage berekend over de schuld per het einde van de daaraan voorafgaande maand. Bij de saldobepaling van de schuld zullen eventueel verschuldigde maar niet betaalde rente, kosten en andere bedragen bij de schuld worden geteld.</xsl:text>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<td class="number" valign="top">
						<xsl:text>III.</xsl:text>
					</td>
					<td>
	        		    <u><xsl:text>Overige bepalingen</xsl:text></u>
	        		    <br/>
	        		    <xsl:text>Verder zijn op voormelde lening van toepassing, de algemene leningsvoorwaarden met de daarin opgenomen algemene bepalingen zoals deze in de aan deze akte gehechte offerte zijn overeengekomen, voormelde algemene bepalingen hierna te noemen de 'Algemene bepalingen'.</xsl:text>
					</td>
				</tr>
			</tbody>
		</table>
		<!-- Mortgage charges -->
		<a name="hyp3.mortgageAmountAndAdditionalCosts" class="location">&#160;</a>
		<p><u><xsl:text>HYPOTHEEKSTELLING EN VERPANDING</xsl:text></u></p>
		<p><u><xsl:text>Tot meerdere zekerheid voor</xsl:text></u><xsl:text>:</xsl:text></p>
		<table cellspacing="0" cellpadding="0">
			<tbody>
				<tr>
					<td class="number" valign="top">
						<xsl:text>a.</xsl:text>
					</td>
					<td colspan="2">
		    	        <xsl:text>de betaling van de schuld ad </xsl:text>
		    	        <xsl:call-template name="amountText">
    						<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:hoofdsom/tia:som" />
							<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:hoofdsom/tia:valuta" />
    					</xsl:call-template>
    					<xsl:text> </xsl:text>
    					<xsl:call-template name="amountNumber">
    						<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:hoofdsom/tia:som" />
							<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:hoofdsom/tia:valuta" />
    					</xsl:call-template>
		        		<xsl:text>, waaronder begrepen de eventueel krachtens de onderhavige overeenkomst te eniger tijd nader verrichte uitbetalingen en waaronder voorts wordt begrepen al hetgeen aan Florius verschuldigd is en zal zijn uit hoofde van eventueel in deze akte genoemde eerder verleden akte(n) van geldlening met hypotheekstelling aangaande het hierna genoemde onderpand;</xsl:text>
		        	</td>
		        </tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>b.</xsl:text>
					</td>
					<td class="number" valign="top">
						<xsl:text>1.</xsl:text>
					</td>
					<td>
    	                <xsl:text>voldoening van de bedongen rente alsmede de eventueel later overeen te komen verhoging daarvan;</xsl:text>
					</td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<td class="number" valign="top">
						<xsl:text>2.</xsl:text>
					</td>
					<td>
    	            	<xsl:text>voldoening van alle boeten, kosten en rechten, schadevergoedingen en al hetgeen Florius verder uit hoofde van de lening van de schuldenaar te vorderen mocht hebben, welke onder 1 en 2 bedoelde bedragen worden begroot op een totaal bedrag ad </xsl:text>
    	               <xsl:call-template name="amountText">
							<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragRente/tia:som" />
							<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragRente/tia:valuta" />
						</xsl:call-template>
						<xsl:text> </xsl:text>
						<xsl:call-template name="amountNumber">
							<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragRente/tia:som" />
							<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragRente/tia:valuta" />
						</xsl:call-template>
                    	<xsl:text>;</xsl:text>
                    </td>
				</tr>
				<tr>
					<td class="number" valign="top">
						<xsl:text>&#xFEFF;</xsl:text>
					</td>
					<td colspan="2">				
                    	<xsl:text>derhalve tot een totaalbedrag ad </xsl:text>
                    	<xsl:call-template name="amountText">
							<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragTotaal/tia:som" />
							<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragTotaal/tia:valuta" />
						</xsl:call-template>
						<xsl:text> </xsl:text>
						<xsl:call-template name="amountNumber">
							<xsl:with-param name="amount" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragTotaal/tia:som" />
							<xsl:with-param name="valuta" select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragTotaal/tia:valuta" />
						</xsl:call-template>
                    	<xsl:text>;</xsl:text>
					</td>
				</tr>
			</tbody>
		</table>
		<!-- Registered objects -->
		<a name="hyp3.rights" class="location">&#160;</a>
		<p>
			<xsl:text>verleent de schuldenaar bij deze aan Florius, die van de schuldenaar aanvaardt, het recht van</xsl:text>
			<xsl:if test="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:rangordeHypotheek">
				<xsl:text> </xsl:text>
				<xsl:value-of select="kef:convertOrdinalToText(tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:rangordeHypotheek)"></xsl:value-of>
			</xsl:if>
			<xsl:text> hypotheek op het hierna te omschrijven onderpand:</xsl:text>
		</p>
		<xsl:apply-templates select="." mode="do-rights">
			<xsl:with-param name="typeOfHypotheek" select="'Florius'"/>
		</xsl:apply-templates>
		<xsl:apply-templates select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[translate(tia:aanduidingHypotheek, $upper, $lower) = 'overbruggingshypotheek']" mode="do-overbruggingshypotheek"/>
		<p>
			<xsl:text>Florius verklaarde hierbij alle aan haar gegeven rechten en bevoegdheden te aanvaarden.</xsl:text>
		</p>		
		<xsl:apply-templates select="." mode="do-election-of-domicile"/>
		<p><xsl:text>EINDE KADASTERDEEL</xsl:text></p>
		<xsl:apply-templates select="." mode="do-free-text"/>
	</xsl:template>

	<!--
	************************************************************************************************************************
	**** Overbruggingshypotheek ********************************************************************************************
	************************************************************************************************************************
	-->
	<xsl:template match="tia:StukdeelHypotheek" mode="do-overbruggingshypotheek">
		<a name="hyp3.bridgingMortgage" class="location">&#160;</a>
		<p>
			<u>
				<xsl:text>OVERBRUGGINGSHYPOTHEEK</xsl:text>
			</u>
		</p>
		<p>
			<xsl:text>Voorts verleent de schuldenaar tot meerdere zekerheid voor de betaling van de schuld als hierboven vermeld, bij deze aan Florius, die van de schuldenaar aanvaardt, het recht van </xsl:text>
			<xsl:value-of select="kef:convertOrdinalToText(tia:rangordeHypotheek)"/>
			<xsl:text> hypotheek op het hierna te omschrijven onderpand:</xsl:text>
		</p>
		<xsl:choose>
			<xsl:when test="count(tia:IMKAD_ZakelijkRecht) = 1">
				<p>
					<xsl:variable name="rightText">
						<xsl:apply-templates select="tia:IMKAD_ZakelijkRecht" mode="do-right"/>
					</xsl:variable>
					<xsl:if test="normalize-space($rightText) != ''">
						<xsl:value-of select="$rightText"/>
						<xsl:text> </xsl:text>
					</xsl:if>
					<xsl:apply-templates select="tia:IMKAD_ZakelijkRecht" mode="do-registered-object"/>
					<xsl:text>.</xsl:text>
				</p>
			</xsl:when>
			<!-- Multiple registered objects, all parcels with same data -->
			<xsl:when test="count(tia:IMKAD_ZakelijkRecht)
							= count(tia:IMKAD_ZakelijkRecht[
								((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen']/tia:tekst
										= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen']/tia:tekst)
									or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen'])
										and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen'])))
								and tia:aardVerkregen = current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:aardVerkregen
								and normalize-space(tia:aardVerkregen) != ''
								and ((tia:tia_Aantal_BP_Rechten
										= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_Aantal_BP_Rechten)
									or (not(tia:tia_Aantal_BP_Rechten)
										and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_Aantal_BP_Rechten)))
								and ((tia:tia_Aantal_Rechten
										= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_Aantal_Rechten)
									or (not(tia:tia_Aantal_Rechten)
										and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_Aantal_Rechten)))
								and ((tia:tia_Aantal_RechtenVariant
										= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_Aantal_RechtenVariant)
									or (not(tia:tia_Aantal_RechtenVariant)
										and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_Aantal_RechtenVariant)))
								and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven']/tia:tekst
										= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven']/tia:tekst)
									or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven'])
										and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven'])))
								and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom']/tia:tekst
										= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom']/tia:tekst)
									or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom'])
										and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom'])))
								and ((tia:aandeelInRecht/tia:teller	= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:aandeelInRecht/tia:teller
									and tia:aandeelInRecht/tia:noemer = current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:aandeelInRecht/tia:noemer)
									or (not(tia:aandeelInRecht)
										and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:aandeelInRecht)))
								and tia:IMKAD_Perceel[
									tia:tia_OmschrijvingEigendom
										= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_OmschrijvingEigendom
									and normalize-space(tia:tia_OmschrijvingEigendom) != ''
									and ((tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid']/tia:tekst
											= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid']/tia:tekst)
										or (not(tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid'])
											and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid'])))
									and ((tia:tia_SplitsingsverzoekOrdernummer
											= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_SplitsingsverzoekOrdernummer)
										or (not(tia:tia_SplitsingsverzoekOrdernummer)
											and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_SplitsingsverzoekOrdernummer)))
									and tia:kadastraleAanduiding/tia:gemeente
										= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:kadastraleAanduiding/tia:gemeente
									and normalize-space(tia:kadastraleAanduiding/tia:gemeente) != ''
									and tia:kadastraleAanduiding/tia:sectie
										= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:kadastraleAanduiding/tia:sectie
									and normalize-space(tia:kadastraleAanduiding/tia:sectie) != ''
									and tia:IMKAD_OZLocatie/tia:ligging
										= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:ligging
									and normalize-space(tia:IMKAD_OZLocatie/tia:ligging) != ''
									and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer
										= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer)
										or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer)
											and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer)))
									and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter
											= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter)
										or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter)
											and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter)))
									and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging
											= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging)
										or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging)
											and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging)))
									and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode
											= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode)
										or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode)
											and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode)))
									and tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam
										= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam
									and normalize-space(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam) != ''
									and tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam
										= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam
									and normalize-space(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam) != '']]) and $RegistergoedTonenPerPerceel='false'">
				<p>
					<xsl:variable name="rightText">
						<xsl:apply-templates select="tia:IMKAD_ZakelijkRecht[1]" mode="do-right"/>
					</xsl:variable>
					<xsl:if test="normalize-space($rightText) != ''">
						<xsl:value-of select="$rightText"/>
						<xsl:text> </xsl:text>
					</xsl:if>
					<xsl:apply-templates select="tia:IMKAD_ZakelijkRecht[1]" mode="do-registered-object"/>
					<xsl:text>.</xsl:text>
				</p>
			</xsl:when>
			<xsl:otherwise>
				<table cellpadding="0" cellspacing="0">
					<tbody>
						<xsl:call-template name="processRights">
							<xsl:with-param name="positionOfProcessedRight" select="1"/>
							<xsl:with-param name="position" select="1"/>
							<xsl:with-param name="registeredObjects" select="."/>
						</xsl:call-template>
					</tbody>
				</table>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
