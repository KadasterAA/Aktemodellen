<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
	xmlns:xhtml="http://www.w3.org/1999/xhtml"
	xmlns:tia="http://www.kadaster.nl/schemas/KIK/TIA_Algemeen"
	xmlns:alg="http://www.kadaster.nl/schemas/KIK/Formaattypen"
	xmlns:xlink="http://www.w3.org/1999/xlink"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:kef="nl.kadaster.xslt.XslExtensionFunctions"
	xmlns:gc="http://docs.oasis-open.org/codelist/ns/genericode/1.0/"
	exclude-result-prefixes="xhtml tia alg xlink xsl kef gc"
	version="1.0">

	<xsl:include href="xml_xhtml-generiek-1.08.xsl"/>
	<xsl:include href="xml_xhtml-equivalentieverklaring-1.08.xsl"/>
	<xsl:include href="xml_xhtml-dossierkenmerk-1.05.xsl"/>
	<xsl:include href="xml_xhtml-ondertekenaar-1.10.xsl"/>
	<xsl:include href="xml_xhtml-gevolmachtigde-1.05.xsl"/>
	<xsl:include href="xml_xhtml-persoon_data-1.03.xsl"/>
	<xsl:include href="xml_xhtml-persoon-1.13.xsl"/>
	<xsl:include href="xml_xhtml-partij-1.15.xsl"/>
	<xsl:include href="xml_xhtml-kadastraalobject-1.11.xsl"/>

	<xsl:variable name="keuzeteksten" select="document('keuzeteksten-doorhaling_hypotheken-1.00.xml')"/>
	<!-- XML Value lists -->
	<xsl:variable name="mc-aarddomiciliekeuze" select="document('aarddomiciliekeuze_doorhalinghypotheek.xml')/gc:CodeList/SimpleCodeList/Row[1]/Value[1]/SimpleValue"/>
	<xsl:variable name="mc-aardondertekenaar" select="document('aardondertekenaar_doorhalinghypotheek.xml')/gc:CodeList/SimpleCodeList/Row[2]/Value[1]/SimpleValue"/>
	<!-- 'Bij akte andere notaris' is first row -->
	<xsl:variable name="mc-aanvaarding-BijAkteAndereNotaris" select="document('aanvaarding.xml')/gc:CodeList/SimpleCodeList/Row[1]/Value[1]/SimpleValue"/>
	<!-- 'Bij akte oud-notaris' is second row -->
	<xsl:variable name="mc-aanvaarding-BijAkteOudNotaris" select="document('aanvaarding.xml')/gc:CodeList/SimpleCodeList/Row[2]/Value[1]/SimpleValue"/>
	<!-- 'Bij andere eigen akte' is third row -->
	<xsl:variable name="mc-aanvaarding-BijAndereEigenAkte" select="document('aanvaarding.xml')/gc:CodeList/SimpleCodeList/Row[3]/Value[1]/SimpleValue"/>
	<!-- 'Onderhandse volmacht' is fourth row -->
	<xsl:variable name="mc-aanvaarding-OnderhandseVolmacht" select="document('aanvaarding.xml')/gc:CodeList/SimpleCodeList/Row[4]/Value[1]/SimpleValue"/>
	<!-- 'afstand hypotheekrecht' is first row -->
	<xsl:variable name="mc-soortdoorhaling-AfstandHypotheekrecht" select="document('soortdoorhaling.xml')/gc:CodeList/SimpleCodeList/Row[1]/Value[1]/SimpleValue"/>
	<!-- 'opzegging hypotheekrecht' is second row -->
	<xsl:variable name="mc-soortdoorhaling-OpzeggingHypotheekrecht" select="document('soortdoorhaling.xml')/gc:CodeList/SimpleCodeList/Row[2]/Value[1]/SimpleValue"/>
	<!-- 'vervallenverklaring' is third row -->
	<xsl:variable name="mc-soortdoorhaling-Vervallenverklaring" select="document('soortdoorhaling.xml')/gc:CodeList/SimpleCodeList/Row[3]/Value[1]/SimpleValue"/>

	<xsl:variable name="document-titel">DoorhalingHypotheek</xsl:variable>
	<xsl:variable name="AangebodenStuk" select="/tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk"/>
	<xsl:variable name="Partijs" select="$AangebodenStuk/tia:Partij"/>
	<xsl:variable name="ObjectNumber" select="0"/>
	<xsl:variable name="Woonplaatskeuze" select="$AangebodenStuk/tia:tia_WoonplaatsKeuze/tia:aard"/>
	<xsl:variable name="TekstKeuzeTags" select="$keuzeteksten/tia:Keuzeteksten/tia:TekstKeuze/tia:tagNaam"/>

	<!-- 
        *************************************************************************
        Dit template toont de akte-inhoud
        *************************************************************************
    -->
	<xsl:template match="tia:IMKAD_AangebodenStuk">
		<!-- dossierkenmerk (characteristic) subparagraph -->
		<xsl:if test="$AangebodenStuk/tia:tia_OmschrijvingKenmerk != ''">
			<xsl:call-template name="dossierkenmerk">
				<xsl:with-param name="kenmerk" select="$AangebodenStuk/tia:tia_OmschrijvingKenmerk"/>
				<xsl:with-param name="type" select="'doc'"/>
			</xsl:call-template>
		</xsl:if>
		<!-- ondertekenaar (signer) subparagraph -->
		<xsl:call-template name="ondertekenaar">
			<xsl:with-param name="aangebodenstuk" select="$AangebodenStuk"/>
			<xsl:with-param name="aardondertekenaar" select="$mc-aardondertekenaar"/>
			<xsl:with-param name="type" select="'doc'"/>
		</xsl:call-template>
		<!-- Authorised Representative text block (GEVOLMACHTIGDE) -->
		<a name="mortgagecancellationdeed.authorizedRepresentative" class="location">&#160;</a>
		<p>
			<xsl:call-template name="Gevolmachtigde">
				<xsl:with-param name="gevolmachtigde" select="$AangebodenStuk/tia:Gevolmachtigde"/>
				<xsl:with-param name="type" select="'doc'"/>
			</xsl:call-template>
		</p>
		<!-- Warrantors and persons entitled subparagraphs -->
		<xsl:call-template name="vervreemders">
			<xsl:with-param name="type" select="'doc'"/>
		</xsl:call-template>
		<xsl:if test="count(tia:Partij) = 1">
			<a name="mortgagecancellationdeed.personsEntitled" class="location">&#160;</a>
		</xsl:if>
		<!-- Granting Power of Attorney  -->
		<xsl:call-template name="Volmachtverlening" />
		<!-- Renouncement of Mortgage Right (Afstand hypotheekrecht) -->
		<xsl:call-template name="AfstandHypotheekrecht">
	        <xsl:with-param name="deedPart" select="$AangebodenStuk/tia:StukdeelDoorhalingHypotheek[tia:soortDoorhaling = $mc-soortdoorhaling-AfstandHypotheekrecht]"/>
		</xsl:call-template>
		<!-- Termination of a Mortgage Right (Opzegging hypotheekrecht) -->
		<xsl:call-template name="OpzeggingHypotheekrecht">
	        <xsl:with-param name="deedPart" select="$AangebodenStuk/tia:StukdeelDoorhalingHypotheek[tia:soortDoorhaling = $mc-soortdoorhaling-OpzeggingHypotheekrecht]"/>
		</xsl:call-template>
		<!-- Revocation of Decision (Vervallenverklaring) -->
		<xsl:call-template name="Vervallenverklaring">
	        <xsl:with-param name="deedPart" select="$AangebodenStuk/tia:StukdeelDoorhalingHypotheek[tia:soortDoorhaling = $mc-soortdoorhaling-Vervallenverklaring]"/>
		</xsl:call-template>
		<p>
			<xsl:text>De verschenen persoon</xsl:text>
			<xsl:if test="count($AangebodenStuk/tia:Gevolmachtigde) > 1">
				<xsl:text>en</xsl:text>
			</xsl:if>
			<xsl:text> verklaarde</xsl:text>
			<xsl:if test="count($AangebodenStuk/tia:Gevolmachtigde) > 1">
				<xsl:text>n</xsl:text>
			</xsl:if>
			<xsl:text> vervolgens namens partij</xsl:text>
			<xsl:if test="count($Partijs/tia:Partij) > 1">
				<xsl:text>en</xsl:text>
			</xsl:if>
			<xsl:text>:</xsl:text>
			<br/>
			<b><u><xsl:text>Geen beperkt recht hypothecaire vorderingen</xsl:text></u></b>
		</p>
		<p>
			<xsl:text>De vorderingen waarvoor de hypotheekrechten tot zekerheid strekten, zijn niet met een beperkt recht bezwaard.</xsl:text>
		</p>
		<h2 class="header"><xsl:text>Vervallen hypotheken</xsl:text></h2>
		<p>
			<xsl:text>Ingevolge het vorenstaande zijn gemelde hypotheekrechten vervallen.</xsl:text>
		</p>
		<a name="mortgagecancellationdeed.electionOfDomicile" class="location">&#160;</a>
		<xsl:if test="$Woonplaatskeuze = $mc-aarddomiciliekeuze">
			<xsl:call-template name="WoonplatskeuzeTextBlock"/>
		</xsl:if>
		<p>
			<xsl:text>De identiteit van de verschenen persoon</xsl:text>
			<xsl:if test="count($AangebodenStuk/tia:Gevolmachtigde) > 1">
				<xsl:text>en</xsl:text>
			</xsl:if>
			<xsl:text> is door mij, notaris, aan de hand van </xsl:text>
			<xsl:choose>
				<xsl:when test="count($AangebodenStuk/tia:Gevolmachtigde) > 1">
					<xsl:text>daartoe bestemde documenten</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>een daartoe bestemd document</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text> vastgesteld.</xsl:text>
		</p>
		<xsl:call-template name="Signature"/>
		<!-- verklaarder alinea - statement of equivalence subparagraph -->
		<xsl:call-template name="equivalentieverklaring">
			<xsl:with-param name="aangebodenstuk" select="$AangebodenStuk"/>
			<xsl:with-param name="aardondertekenaar" select="$mc-aardondertekenaar"/>
			<xsl:with-param name="type" select="'doc'"/>
		</xsl:call-template>		
	</xsl:template>

	<xsl:template name="AfstandHypotheekrecht">
		<xsl:param name="deedPart"/>

		<a name="mortgagecancellationdeed.renouncements" class="location">&#160;</a>
		<xsl:if test="$deedPart">
			<h2 class="header">Afstand hypotheekrecht</h2>
			<table cellpadding="0" cellspacing="0">
				<tbody>
					<xsl:for-each select="$deedPart">
						<xsl:variable name="volmachtgeverCount" select="count(tia:vervreemderRechtRef[@xlink:href != '' and @xlink:href != '#'])"/>
						<xsl:variable name="rechthebbendeCount" select="count(tia:verkrijgerRechtRef[@xlink:href != '' and @xlink:href != '#'])"/>
						<xsl:variable name="rightsCount" select="count(tia:IMKAD_ZakelijkRecht)"/>
						<tr>
							<td class="number" valign="top">
								<xsl:number value="position()" format="a"/>
								<xsl:text>.</xsl:text>
							</td>
							<td>
								<xsl:text>De hypotheekhouder</xsl:text>
								<xsl:if test="$volmachtgeverCount > 1">
									<xsl:text>s</xsl:text>
								</xsl:if>
								<xsl:text> en de rechthebbende</xsl:text>
								<xsl:if test="$rechthebbendeCount > 1">
									<xsl:text>n</xsl:text>
								</xsl:if> 
								<xsl:text> zijn overeengekomen dat afstand wordt gedaan van na te melden hypotheekrecht.</xsl:text>
								<br/>
								<xsl:text>De genoemde volmachtgever</xsl:text>
								<xsl:if test="$volmachtgeverCount > 1">
									<xsl:text>s</xsl:text>
								</xsl:if>
								<xsl:call-template name="extractPartyNames">
									<xsl:with-param name="partyReference" select="tia:vervreemderRechtRef[@xlink:href != '' and @xlink:href != '#']"/>
									<xsl:with-param name="parties" select="$Partijs"/>
									<xsl:with-param name="count" select="$volmachtgeverCount"/>
								</xsl:call-template>
								<xsl:choose>
									<xsl:when test="$volmachtgeverCount > 1">
										<xsl:text>doen </xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text>doet </xsl:text>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:text>ter uitvoering van deze overeenkomst hierbij afstand van:</xsl:text>
								<br/>
								<xsl:call-template name="DoorTeHalenStuk">
									<xsl:with-param name="doorTeHalenStuk" select="tia:doorTeHalenStuk"/>
								</xsl:call-template>
						        <xsl:text>, ten behoeve van (thans) de genoemde volmachtgever</xsl:text>
								<xsl:if test="$volmachtgeverCount > 1">
									<xsl:text>s</xsl:text>
								</xsl:if>
						        <xsl:text> welk hypotheekrecht thans komt ten laste van de hiervoor genoemde rechthebbende</xsl:text>
								<xsl:if test="$rechthebbendeCount > 1">
									<xsl:text>n</xsl:text>
								</xsl:if>
								<xsl:call-template name="extractPartyNames">
									<xsl:with-param name="partyReference" select="tia:verkrijgerRechtRef[@xlink:href != '' and @xlink:href != '#']"/>
									<xsl:with-param name="parties" select="$Partijs"/>
									<xsl:with-param name="count" select="$rechthebbendeCount"/>
								</xsl:call-template>
								<xsl:text>op de met bovenbedoeld hypotheekrecht bezwaarde registergoederen</xsl:text>
								<xsl:choose>
									<xsl:when test="$rightsCount &lt; 1">
										<xsl:text>.</xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text>, doch alleen voor zover gemeld hypotheekrecht is gevestigd op</xsl:text>
										<xsl:call-template name="mortgageCancellationParcels">
											<xsl:with-param name="rights" select="tia:IMKAD_ZakelijkRecht"/>
											<xsl:with-param name="count" select="$rightsCount"/>
										</xsl:call-template>
									</xsl:otherwise>
								</xsl:choose>
								<br/>
								<u><xsl:text>Aanvaarding/Volmacht</xsl:text></u>
								<br/>
								<xsl:choose>
									<xsl:when test="tia:akteOpzeggingsBevoegdheid/tia:aanvaarding = $mc-aanvaarding-OnderhandseVolmacht">
										<xsl:text>Van de onderhavige volmachtverlening door de rechthebbende</xsl:text>
										<xsl:if test="$rechthebbendeCount > 1">
											<xsl:text>n</xsl:text>
										</xsl:if> 
										<xsl:text> blijkt uit </xsl:text>
										<xsl:if test="tia:akteOpzeggingsBevoegdheid/tia:AantalOnderhandseAkten/tia:aantalOnderhandseAkten != ''">
											<xsl:value-of select="kef:convertNumberToText(tia:akteOpzeggingsBevoegdheid/tia:AantalOnderhandseAkten/tia:aantalOnderhandseAkten)"/>
										</xsl:if>
										<xsl:text> onderhandse akte</xsl:text>
										<xsl:if test="tia:akteOpzeggingsBevoegdheid/tia:AantalOnderhandseAkten/tia:aantalOnderhandseAkten > 1">
											<xsl:text>n</xsl:text>
										</xsl:if>
										<xsl:text> van volmacht die aan deze akte </xsl:text>
										<xsl:choose>
											<xsl:when test="tia:akteOpzeggingsBevoegdheid/tia:AantalOnderhandseAkten/tia:aantalOnderhandseAkten > 1">
												<xsl:text>worden </xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text>wordt </xsl:text>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:text>gehecht.</xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text>Van de onderhavige volmachtverlening door de rechthebbende</xsl:text>
										<xsl:if test="$rechthebbendeCount > 1">
											<xsl:text>n</xsl:text>
										</xsl:if> 
										<xsl:text> blijkt uit een akte verleden op </xsl:text>
										<xsl:if test="substring(string(tia:akteOpzeggingsBevoegdheid/tia:AkteOpzeggingsbevoegdheidGroup/tia:datumOndertekening),0,11) != ''">
											<xsl:value-of select="kef:convertDateToText(substring(string(tia:akteOpzeggingsBevoegdheid/tia:AkteOpzeggingsbevoegdheidGroup/tia:datumOndertekening),0,11))"/>
										</xsl:if>
										<xsl:text> </xsl:text>
										<xsl:choose>
											<xsl:when test="tia:akteOpzeggingsBevoegdheid/tia:aanvaarding = $mc-aanvaarding-BijAndereEigenAkte">
												<xsl:text>voor mij, notaris</xsl:text>
											</xsl:when>
											<xsl:when test="tia:akteOpzeggingsBevoegdheid/tia:aanvaarding = $mc-aanvaarding-BijAkteAndereNotaris or tia:akteOpzeggingsBevoegdheid/tia:aanvaarding = $mc-aanvaarding-BijAkteOudNotaris">
												<xsl:text>voor </xsl:text>
												<xsl:value-of select="tia:akteOpzeggingsBevoegdheid/tia:AkteOpzeggingsbevoegdheidGroup/tia:naamNotaris"/>
												<xsl:text>, </xsl:text>
												<xsl:if test="tia:akteOpzeggingsBevoegdheid/tia:aanvaarding = $mc-aanvaarding-BijAkteOudNotaris">
													<xsl:text>destijds </xsl:text>
												</xsl:if>
												<xsl:text>notaris te </xsl:text>
												<xsl:value-of select="tia:akteOpzeggingsBevoegdheid/tia:AkteOpzeggingsbevoegdheidGroup/tia:plaatsNotaris"/>
											</xsl:when>
										</xsl:choose>
										<xsl:text>.</xsl:text>
									</xsl:otherwise>
								</xsl:choose>
							</td>
						</tr>						
					</xsl:for-each>
				</tbody>
			</table>
		</xsl:if>
	</xsl:template>

	<xsl:template name="OpzeggingHypotheekrecht">
		<xsl:param name="deedPart"/>

		<a name="mortgagecancellationdeed.terminations" class="location">&#160;</a>
		<xsl:if test="$deedPart">
			<h2 class="header">Opzegging hypotheekrecht</h2>
			<table cellpadding="0" cellspacing="0">
				<tbody>
					<xsl:for-each select="$deedPart">
						<xsl:variable name="volmachtgeverCount" select="count(tia:vervreemderRechtRef[@xlink:href != '' and @xlink:href != '#'])"/>
						<xsl:variable name="debiteurCount" select="count(tia:debiteurAkteHypotheekrecht[text() != ''])"/>
						<xsl:variable name="rightsCount" select="count(tia:IMKAD_ZakelijkRecht)"/>
		
						<tr>
							<td class="number" valign="top">
								<xsl:number value="position()" format="a"/>
								<xsl:text>.</xsl:text>
							</td>
							<td>
								<xsl:text>De volmachtgever</xsl:text>
								<xsl:if test="$volmachtgeverCount > 1">
									<xsl:text>s</xsl:text>
								</xsl:if>
								<xsl:call-template name="extractPartyNames">
									<xsl:with-param name="partyReference" select="tia:vervreemderRechtRef[@xlink:href != '' and @xlink:href != '#']"/>
									<xsl:with-param name="parties" select="$Partijs"/>
									<xsl:with-param name="count" select="$volmachtgeverCount"/>
								</xsl:call-template>
								<xsl:choose>
									<xsl:when test="$volmachtgeverCount > 1">
										<xsl:text>zeggen </xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text>zegt </xsl:text>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:text>hierbij op:</xsl:text>
								<br/>
								<xsl:call-template name="DoorTeHalenStuk">
									<xsl:with-param name="doorTeHalenStuk" select="tia:doorTeHalenStuk"/>
								</xsl:call-template>
						        <xsl:text>, ten behoeve van (thans) de genoemde volmachtgever</xsl:text>
								<xsl:if test="$volmachtgeverCount > 1">
									<xsl:text>s</xsl:text>
								</xsl:if>
								<xsl:choose>
									<xsl:when test="$debiteurCount &lt;= 0 and $rightsCount &lt;= 0">
										<xsl:text>.</xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:if test="$debiteurCount > 0">
											<xsl:text> en ten laste van de in de akte waarbij het hypotheekrecht werd gevestigd genoemde hypotheekgever</xsl:text>
											<xsl:if test="$debiteurCount > 1">
												<xsl:text>s</xsl:text>
											</xsl:if>
											<xsl:text> en/of debiteur</xsl:text>
											<xsl:if test="$debiteurCount > 1">
												<xsl:text>en</xsl:text>
											</xsl:if>
											<xsl:text> te weten:</xsl:text>
											<xsl:for-each select="tia:debiteurAkteHypotheekrecht[text() != '']">
												<xsl:text> </xsl:text>
												<xsl:value-of select="."/>
												<xsl:choose>
													<xsl:when test="$debiteurCount > 1 and position() + 1 = last()">
														<xsl:text> en</xsl:text>
													</xsl:when>
													<xsl:when test="$debiteurCount > 1 and position() + 1 &lt; last()">
														<xsl:text>,</xsl:text>
													</xsl:when>
												</xsl:choose>
											</xsl:for-each>
											<xsl:if test="$rightsCount &lt;= 0">
												<xsl:text>.</xsl:text>
											</xsl:if>
										</xsl:if>
										<xsl:if test="$rightsCount > 0">
											<xsl:text>, doch alleen voor zover gemeld hypotheekrecht is gevestigd op</xsl:text>
											<xsl:call-template name="mortgageCancellationParcels">
												<xsl:with-param name="rights" select="tia:IMKAD_ZakelijkRecht"/>
												<xsl:with-param name="count" select="$rightsCount"/>
											</xsl:call-template>
										</xsl:if>
									</xsl:otherwise>
								</xsl:choose>
								<br/>
								<xsl:text>Deze opzeggingsbevoegdheid is verleend in de akte waarbij laatstgemeld hypotheekrecht werd gevestigd.</xsl:text>
							</td>
						</tr>
					</xsl:for-each>
				</tbody>
			</table>
		</xsl:if>
	</xsl:template>

	<xsl:template name="Vervallenverklaring">
		<xsl:param name="deedPart"/>

		<a name="mortgagecancellationdeed.revocations" class="location">&#160;</a>
		<xsl:if test="$deedPart">
			<h2 class="header">Vervallenverklaring</h2>
			<table cellpadding="0" cellspacing="0">
				<tbody>
					<xsl:for-each select="$deedPart">
						<xsl:variable name="volmachtgeverCount" select="count(tia:vervreemderRechtRef[@xlink:href != '' and @xlink:href != '#'])"/>
						<xsl:variable name="debiteurCount" select="count(tia:debiteurAkteHypotheekrecht[text() != ''])"/>
		
						<tr>
							<td class="number" valign="top">
								<xsl:number value="position()" format="a"/>
								<xsl:text>.</xsl:text>
							</td>
							<td>
								<xsl:text>De volmachtgever</xsl:text>
								<xsl:if test="$volmachtgeverCount > 1">
									<xsl:text>s</xsl:text>
								</xsl:if>
								<xsl:call-template name="extractPartyNames">
									<xsl:with-param name="partyReference" select="tia:vervreemderRechtRef[@xlink:href != '' and @xlink:href != '#']"/>
									<xsl:with-param name="parties" select="$Partijs"/>
									<xsl:with-param name="count" select="$volmachtgeverCount"/>
								</xsl:call-template>
								<xsl:choose>
									<xsl:when test="$volmachtgeverCount > 1">
										<xsl:text>verklaren </xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text>verklaart </xsl:text>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:text>dat </xsl:text>
								<xsl:call-template name="DoorTeHalenStuk">
									<xsl:with-param name="doorTeHalenStuk" select="tia:doorTeHalenStuk"/>
								</xsl:call-template>
								<xsl:text>, ten behoeve van de genoemde volmachtgever</xsl:text>
								<xsl:if test="$volmachtgeverCount > 1">
									<xsl:text>s</xsl:text>
								</xsl:if>
								<xsl:if test="$debiteurCount &gt; 0">
									<xsl:text> en ten laste van de in de akte waarbij het hypotheekrecht werd gevestigd genoemde hypotheekgever</xsl:text>
									<xsl:if test="$debiteurCount > 1">
										<xsl:text>s</xsl:text>
									</xsl:if>
									<xsl:text> en/of debiteur</xsl:text>
									<xsl:if test="$debiteurCount > 1">
										<xsl:text>en</xsl:text>
									</xsl:if>
									<xsl:text> te weten:</xsl:text>
									<xsl:for-each select="tia:debiteurAkteHypotheekrecht[text() != '']">
										<xsl:text> </xsl:text>
										<xsl:value-of select="."/>
										<xsl:choose>
											<xsl:when test="$debiteurCount > 1 and position() + 1 = last()">
												<xsl:text> en</xsl:text>
											</xsl:when>
											<xsl:when test="$debiteurCount > 1 and position() + 1 &lt; last()">
												<xsl:text>,</xsl:text>
											</xsl:when>
										</xsl:choose>
									</xsl:for-each>
								</xsl:if>
								<xsl:text> is vervallen omdat de vordering tot zekerheid waarvoor zij werd verstrekt is voldaan en/of door be&#x00EB;indiging van de rechtsverhouding tot zekerheid waarvan het hypotheekrecht werd gevestigd.</xsl:text>
							</td>
						</tr>
					</xsl:for-each>
				</tbody>
			</table>
		</xsl:if>
	</xsl:template>

	<xsl:template name="Volmachtverlening">
		<a name="mortgagecancellationdeed.powerOfAttorney" class="location">&#160;</a>
		<h2 class="header">Volmachtverlening</h2>
		<p>
			<xsl:text>Van de sub A. vermelde volmacht</xsl:text>
			<xsl:if test="$AangebodenStuk/tia:tia_AantalOnderhandseAktenVolmacht > 1">
				<xsl:text>en</xsl:text>
			</xsl:if>
			<xsl:text> blijkt uit </xsl:text>
			<xsl:if test="$AangebodenStuk/tia:tia_AantalOnderhandseAktenVolmacht != ''">
				<xsl:value-of select="kef:convertNumberToText($AangebodenStuk/tia:tia_AantalOnderhandseAktenVolmacht)"/>
			</xsl:if>
			<xsl:text> onderhandse akte</xsl:text>
			<xsl:if test="$AangebodenStuk/tia:tia_AantalOnderhandseAktenVolmacht > 1">
				<xsl:text>n</xsl:text>
			</xsl:if>
			<xsl:text> van volmacht die aan deze akte </xsl:text>
			<xsl:choose>
				<xsl:when test="$AangebodenStuk/tia:tia_AantalOnderhandseAktenVolmacht > 1">
					<xsl:text>worden</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>wordt</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text> gehecht.</xsl:text>
			<xsl:if test="$Partijs[translate(@id,$upper,$lower) = 'mortgagecancellationdeed.personsentitled']/tia:Partij[tia:IMKAD_Persoon]">
				<br/>
				<xsl:text>Van de sub B. vermelde volmachtgeving</xsl:text>
				<xsl:if test="count($Partijs[translate(@id,$upper,$lower) = 'mortgagecancellationdeed.personsentitled']/tia:Partij[tia:IMKAD_Persoon]) > 1">
					<xsl:text>en</xsl:text>
				</xsl:if>
				<xsl:text> blijkt zoals hierna vermeld.</xsl:text>
			</xsl:if>
		</p>
	</xsl:template>

	<xsl:template name="WoonplatskeuzeTextBlock">
		<h2 class="header">Woonplaatskeuze</h2>
		<p>
			<xsl:text>De verschenen persoon</xsl:text>
			<xsl:if test="count($AangebodenStuk/tia:Gevolmachtigde) > 1">
				<xsl:text>en</xsl:text>
			</xsl:if>
			<xsl:text>, handelend als gemeld, </xsl:text>
			<xsl:choose>
				<xsl:when test="count($AangebodenStuk/tia:Gevolmachtigde) > 1">
					<xsl:text>verklaren</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>verklaart</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text> terzake van deze akte woonplaats te kiezen ten kantore van mij, notaris.</xsl:text>
		</p>
	</xsl:template>

	<xsl:template name="Signature">
		<a name="mortgagecancellationdeed.signature" class="location">&#160;</a>
		<p>
			<b><xsl:text>WAARVAN AKTE</xsl:text></b>
			<span>
				<xsl:text>&#160;is verleden te </xsl:text>
				<xsl:value-of select="$AangebodenStuk/tia:tia_PlaatsOndertekening/tia:woonplaatsNaam"/>
				<xsl:text> op de datum in het hoofd van deze akte vermeld. Deze akte is onmiddellijk na beperkte voorlezing door de verschenen persoon</xsl:text>
				<xsl:if test="count($AangebodenStuk/tia:Gevolmachtigde) > 1">
					<xsl:text>en</xsl:text>
				</xsl:if>
				<xsl:text> en vervolgens door mij, notaris, ondertekend om </xsl:text>
				<xsl:if test="$AangebodenStuk/tia:tia_TijdOndertekening">
					<xsl:if test="string-length(substring(string($AangebodenStuk/tia:tia_TijdOndertekening), 0, 11)) != 0">
						<xsl:value-of select="kef:convertTimeToText(substring($AangebodenStuk/tia:tia_TijdOndertekening, 1, 5))"/>
					</xsl:if>
					<xsl:text> (</xsl:text>
					<xsl:value-of select="substring($AangebodenStuk/tia:tia_TijdOndertekening, 0, 6)"/>
					<xsl:text> uur).</xsl:text>
				</xsl:if>
			</span>
		</p>
	</xsl:template>
</xsl:stylesheet>
