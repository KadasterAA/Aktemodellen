<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:tia="http://www.kadaster.nl/schemas/KIK/TIA_Algemeen"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:kef="nl.kadaster.xslt.XslExtensionFunctions"
    xmlns:gc="http://docs.oasis-open.org/codelist/ns/genericode/1.0/"
    exclude-result-prefixes="tia xsl kef gc"
    version="1.0">

	<!-- XML value lists -->
	<!-- Cubic meter is first row --> 
	<xsl:variable name="eenheid-cubic-meter" select="document('eenheid.xml')/gc:CodeList/SimpleCodeList/Row[1]/Value[1]/SimpleValue"/>
	<!-- Ton is second row -->
	<xsl:variable name="eenheid-ton" select="document('eenheid.xml')/gc:CodeList/SimpleCodeList/Row[2]/Value[1]/SimpleValue"/>
	<!-- 
		*************************************************************************
		Parcel and Apartment block (Perceel, Appartementsrecht)
		*************************************************************************
	-->
	<xsl:template name="KadastraalObject">
		<xsl:param name="kadastraalobject"/>
		<xsl:param name="isNetworkNotary" select="'false'"/>
		
		<xsl:apply-templates select="$kadastraalobject/tia:IMKAD_Perceel" mode="do-object">
			<xsl:with-param name="isNetworkNotary" select="$isNetworkNotary"/>
		</xsl:apply-templates>
		<xsl:apply-templates select="$kadastraalobject/tia:IMKAD_Appartementsrecht" mode="do-object">
			<xsl:with-param name="isNetworkNotary" select="$isNetworkNotary"/>
		</xsl:apply-templates>
		<xsl:apply-templates select="$kadastraalobject/tia:Schip" mode="do-object"/>
		<xsl:apply-templates select="$kadastraalobject/tia:IMKAD_Leidingnetwerk" mode="do-object"/>
		<xsl:apply-templates select="$kadastraalobject/tia:Luchtvaartuig" mode="do-object"/>
	</xsl:template>

	<xsl:template match="tia:IMKAD_Perceel" mode="do-object">
		<xsl:param name="isNetworkNotary" select="'false'"/>
		
		<xsl:value-of select="tia:tia_OmschrijvingEigendom"/>
		<xsl:text> gelegen </xsl:text>
		<xsl:value-of select="tia:IMKAD_OZLocatie/tia:ligging"/>
		<xsl:text> </xsl:text>
		<xsl:apply-templates select="tia:IMKAD_OZLocatie/tia:adres">
			<xsl:with-param name="isNetworkNotary" select="$isNetworkNotary"/>
		</xsl:apply-templates>
		<xsl:text>, </xsl:text>
		<strong>
			<xsl:text>kadastraal bekend </xsl:text>
		</strong>
		<xsl:text>gemeente </xsl:text>
		<xsl:call-template name="KadastraleAanduiding">
			<xsl:with-param name="kadastraleAanduiding" select="tia:kadastraleAanduiding"/>
			<xsl:with-param name="isNetworkNotary" select="$isNetworkNotary"/>
		</xsl:call-template>
		<xsl:if test="tia:grootte and string-length(tia:grootte) > 0">
			<xsl:text>, ter grootte van </xsl:text>
			<xsl:choose>
				<xsl:when test="translate($isNetworkNotary,$upper,$lower) = 'true'">
					<xsl:if test="translate(../tia:tia_TekstKeuze[translate(tia:tagNaam,$upper,$lower) = 'k_voorlopig']/tia:tekst,$upper,$lower) = 'met voorlopige kadastrale grenzen'">
						<xsl:text>ongeveer</xsl:text>
						<xsl:text> </xsl:text>
					</xsl:if>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="parent::tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam,$upper,$lower) = 'k_voorlopig']/tia:tekst[translate(normalize-space(.), $upper, $lower) = translate(normalize-space(
						$keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam,$upper,$lower) = 'k_voorlopig']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 	translate(normalize-space(current()/parent::tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam,$upper,$lower) = 'k_voorlopig']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
					<xsl:text> </xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:apply-templates select="tia:grootte">
				<xsl:with-param name="isNetworkNotary" select="$isNetworkNotary"/>
			</xsl:apply-templates>
			<xsl:if test="translate($isNetworkNotary,$upper,$lower) != 'true'">
				<xsl:text> centiare</xsl:text>	
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<xsl:template match="tia:IMKAD_Appartementsrecht" mode="do-object">
		<xsl:param name="isNetworkNotary" select="'false'"/>
		
		<xsl:value-of select="tia:tia_OmschrijvingEigendom"/>
		<xsl:text> gelegen </xsl:text>
		<xsl:value-of select="tia:IMKAD_OZLocatie/tia:ligging"/>
		<xsl:text> </xsl:text>
		<xsl:apply-templates select="tia:IMKAD_OZLocatie/tia:adres">
			<xsl:with-param name="isNetworkNotary" select="$isNetworkNotary"/>
		</xsl:apply-templates>
		<xsl:text>, </xsl:text>
		<strong>
			<xsl:text>kadastraal bekend </xsl:text>
		</strong>
		<xsl:text>gemeente </xsl:text>
		<xsl:call-template name="KadastraleAanduiding">
			<xsl:with-param name="kadastraleAanduiding" select="tia:kadastraleAanduiding"/>
		</xsl:call-template>
	</xsl:template>
	
	<!-- 
		*************************************************************************
		[added LvdB] perceel grootte (parcel size)
		*************************************************************************
	-->
	<xsl:template match="tia:grootte">
		<xsl:param name="isNetworkNotary" select="'false'"/>
		
		<!-- example: 11234 ca = 1 hectare, 12 are en 34 ca -->
		<xsl:variable name="hectare" select="floor(. div 10000)"/>
		<xsl:variable name="are" select="floor(. div 100 mod 100)"/>
		<xsl:variable name="centiare" select="floor(. mod 100)"/>
		
		<xsl:choose>
			<xsl:when test="translate($isNetworkNotary,$upper,$lower) = 'true'">
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
			</xsl:when>
			<xsl:otherwise>
				<!-- more than 0 hectare -->
				<xsl:if test="$hectare > 0">
					<xsl:value-of select="kef:convertNumberToText(string($hectare))"/>
					<xsl:text> hectare, </xsl:text>
				</xsl:if>
				<!-- more than 0 are -->
				<xsl:if test="$hectare > 0 or $are > 0">
					<xsl:value-of select="kef:convertNumberToText(string($are))"/>
					<xsl:text> are </xsl:text>
				</xsl:if>
				<xsl:if test="$hectare > 0 or $are > 0">
					<xsl:text>en </xsl:text>
				</xsl:if>
				<xsl:value-of select="kef:convertNumberToText(string($centiare))"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="tia:Schip" mode="do-object">
		<xsl:param name="parent"/>
		<xsl:variable name="eenheid-part">
			<xsl:choose>
				<xsl:when test="tia:brutoInhoud/tia:eenheid = $eenheid-cubic-meter"><xsl:text>liter</xsl:text></xsl:when>
				<xsl:when test="tia:brutoInhoud/tia:eenheid = $eenheid-ton"><xsl:text>kilo</xsl:text></xsl:when>
				<xsl:otherwise><xsl:text/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:value-of select="tia:typering"/>
		<xsl:text> genaamd </xsl:text>
		<xsl:value-of select="tia:naam"/>
		<xsl:if test="tia:oudeNaam">
			<xsl:text> voorheen genaamd </xsl:text>
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
		<xsl:text>, gebouwd door </xsl:text>
		<xsl:value-of select="tia:naamGebouwdDoor"/>
		<xsl:text> in </xsl:text>
		<xsl:value-of select="tia:plaatsGebouwdIn"/>
		<xsl:text>, bouwjaar </xsl:text>
		<xsl:value-of select="tia:bouwjaar"/>
		<xsl:text> </xsl:text>
		<xsl:if test="tia:brutoInhoud">
			<xsl:text>met een </xsl:text>
			<xsl:value-of select="tia:brutoInhoud/tia:soortInhoud"/>
			<xsl:text> van </xsl:text>
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
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:if test="../tia:tia_TekstKeuze[translate(tia:tagNaam,$upper,$lower) = 'k_voortstuwing']">
			<xsl:value-of select="parent::*/tia:tia_TekstKeuze[translate(tia:tagNaam,$upper,$lower) = 'k_voortstuwing']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
				translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam,$upper,$lower) = 'k_voortstuwing']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
				translate(normalize-space(current()/parent::*/tia:tia_TekstKeuze[translate(tia:tagNaam,$upper,$lower) = 'k_voortstuwing']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
		</xsl:if>
		<xsl:choose>
			<xsl:when test="tia:beschrijvingVoortstuwingswerktuigen">
				<xsl:text>:</xsl:text>
				<xsl:apply-templates select="." mode="do-propulsion"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="../tia:tia_TekstKeuze[translate(tia:tagNaam,$upper,$lower) = 'k_scheepstoebehoren']">
					<xsl:text>,</xsl:text>
					<br/>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:if test="../tia:tia_TekstKeuze[translate(tia:tagNaam,$upper,$lower) = 'k_scheepstoebehoren']">
			<xsl:value-of select="parent::*/tia:tia_TekstKeuze[translate(tia:tagNaam,$upper,$lower) = 'k_scheepstoebehoren']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
				translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam,$upper,$lower) = 'k_scheepstoebehoren']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
				translate(normalize-space(current()/parent::*/tia:tia_TekstKeuze[translate(tia:tagNaam,$upper,$lower) = 'k_scheepstoebehoren']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
		</xsl:if>
	</xsl:template>

	<xsl:template match="tia:Luchtvaartuig" mode="do-object">
		<xsl:text>Het luchtvaartuig met het nationaliteits- en inschrijvingskenmerk PH </xsl:text>
		<xsl:value-of select="tia:inschrijvingskenmerk"/>
		<xsl:text> met een maximaal toegelaten startmassa van </xsl:text>
		<xsl:value-of select="tia:startmassa"/>
		<xsl:text> kilogram en </xsl:text>
		<xsl:if test="count(tia:beschrijvingVoortstuwingswerktuigen)=1">
			<xsl:text> het volgende voorstuwingswerktuig:</xsl:text>
		</xsl:if>
		<xsl:if test="count(tia:beschrijvingVoortstuwingswerktuigen)>1">
			<xsl:text> de volgende voorstuwingswerktuigen:</xsl:text>
		</xsl:if>
		<xsl:apply-templates select="." mode="do-propulsion"/>
	</xsl:template>

	<xsl:template match="tia:IMKAD_Leidingnetwerk" mode="do-object">	
		<xsl:value-of select="tia:tia_Typering"/>
		<xsl:text> kadastraal bekend </xsl:text>
		<xsl:call-template name="KadastraleAanduiding">
			<xsl:with-param name="kadastraleAanduiding" select="tia:kadastraleAanduiding"/>
		</xsl:call-template>
	</xsl:template>

	<xsl:template match="tia:Schip | tia:Luchtvaartuig" mode="do-propulsion">
		<br/>
		<xsl:for-each select="tia:beschrijvingVoortstuwingswerktuigen">
			<xsl:text>Merk: </xsl:text>
			<xsl:value-of select="tia:merk"/>
			<br/>
			<xsl:text>Motornummer: </xsl:text>
			<xsl:value-of select="tia:motornummer"/>
			<br/>
			<xsl:if test="tia:plaatsMotor">
				<xsl:text>Plaats motor: </xsl:text>
				<xsl:value-of select="tia:plaatsMotor"/>
				<br/>
			</xsl:if>
			<xsl:text>Sterkte: </xsl:text>
			<xsl:value-of select="tia:sterkte"/>
			<xsl:text> PK</xsl:text>
			<xsl:choose>
				<xsl:when test="position() = last()">
					<xsl:if test="../../tia:tia_TekstKeuze[translate(tia:tagNaam,$upper,$lower) = 'k_scheepstoebehoren']"><xsl:text>,</xsl:text><br/></xsl:if>
				</xsl:when>
				<xsl:when test="position() != last()">
					<br/>
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template match="tia:IMKAD_OZLocatie/tia:adres">
		<xsl:param name="isNetworkNotary" select="'false'"/>
		<xsl:choose>
			<xsl:when test="translate($isNetworkNotary,$upper,$lower) = 'true'">
				<xsl:if test="tia:BAG_NummerAanduiding/tia:postcode and string-length(tia:BAG_NummerAanduiding/tia:postcode)!=0">
					<xsl:value-of select="tia:BAG_NummerAanduiding/tia:postcode"/>
					<xsl:text> </xsl:text>
				</xsl:if>				
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="tia:BAG_NummerAanduiding/tia:postcode"/>
				<xsl:text> </xsl:text>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:value-of select="tia:BAG_Woonplaats/tia:woonplaatsNaam"/>
		<xsl:text>, </xsl:text>
		<xsl:value-of select="tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam"/>
		<xsl:choose>
			<xsl:when test="translate($isNetworkNotary,$upper,$lower) = 'true'">
				<xsl:if test="tia:BAG_NummerAanduiding/tia:huisnummer and string-length(tia:BAG_NummerAanduiding/tia:huisnummer)!=0">
					<xsl:text> </xsl:text>
					<xsl:value-of select="tia:BAG_NummerAanduiding/tia:huisnummer"/>				
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text> </xsl:text>
				<xsl:value-of select="tia:BAG_NummerAanduiding/tia:huisnummer"/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:if test="tia:BAG_NummerAanduiding/tia:huisletter">
			<xsl:if test="string-length(tia:BAG_NummerAanduiding/tia:huisletter)!=0">
				<xsl:text> </xsl:text>
				<xsl:value-of select="tia:BAG_NummerAanduiding/tia:huisletter"/>
			</xsl:if>
		</xsl:if>
		<xsl:if test="tia:BAG_NummerAanduiding/tia:huisnummertoevoeging">
			<xsl:if test="string-length(tia:BAG_NummerAanduiding/tia:huisnummertoevoeging)!=0">
				<xsl:text> </xsl:text>
				<xsl:value-of select="tia:BAG_NummerAanduiding/tia:huisnummertoevoeging"/>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<!-- Business object Registered deed (Ingeschreven stuk) -->
	<xsl:template name="IngeschrevenStuk">
		<xsl:param name="ingeschrevenStuk"/>
		<xsl:param name="reeks" select="'true'"/>
		<xsl:param name="insertAnd" select="'true'"/>

		<xsl:if test="translate($reeks,$upper,$lower) = 'true'">
	        <xsl:if test="$ingeschrevenStuk/tia:deel != '' and number($ingeschrevenStuk/tia:deel) &lt;= 50000">
	            <xsl:text>te </xsl:text><xsl:value-of select="$ingeschrevenStuk/tia:reeks"/>
	        </xsl:if>
	        <xsl:text> in </xsl:text>
        </xsl:if>
        <xsl:text>deel </xsl:text>
       	<xsl:value-of select="$ingeschrevenStuk/tia:deel"/>
       	<xsl:if test="translate($insertAnd,$upper,$lower) = 'true'">
       		<xsl:text> en</xsl:text>
       	</xsl:if>
        <xsl:text> nummer </xsl:text>
        <xsl:value-of select="$ingeschrevenStuk/tia:nummer"/>
	</xsl:template>

	<!-- Business object Cadastral identification (Kadastrale aanduiding) -->
	<xsl:template name="KadastraleAanduiding">
		<xsl:param name="kadastraleAanduiding"/>
		<xsl:param name="appartmentsIndexAddition" select="''"/>
		<xsl:param name="isNetworkNotary" select="'false'"/>

		<xsl:value-of select="$kadastraleAanduiding/tia:gemeente"/>
		<!-- LvdB keuzetekst voorlopige grenzen -->
		<xsl:choose>
			<xsl:when test="translate($isNetworkNotary,$upper,$lower) = 'true'">
				<xsl:text> </xsl:text>
				<xsl:value-of select="parent::tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam,$upper,$lower) = 'k_voorlopig']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
						translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam,$upper,$lower) = 'k_voorlopig']/tia:tekst[2][translate(normalize-space(.), $upper, $lower) = 
						translate(normalize-space(current()/parent::tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam,$upper,$lower) = 'k_voorlopig']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="translate($kadastraleAanduiding/ancestor::tia:IMKAD_ZakelijkRecht/tia:tia_TekstKeuze[translate(tia:tagNaam,$upper,$lower) = 'k_voorlopig']/tia:tekst,$upper,$lower) = 'ongeveer'"> met voorlopige kadastrale grenzen</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:text>, sectie </xsl:text>
		<xsl:value-of select="$kadastraleAanduiding/tia:sectie"/>
		<xsl:text>, nummer </xsl:text>
		<xsl:value-of select="$kadastraleAanduiding/tia:perceelnummer"/>
   		<xsl:if test="$kadastraleAanduiding/tia:appartementsindex and $kadastraleAanduiding/tia:appartementsindex != ''">
   			<xsl:text>, appartementsindex </xsl:text>
   			<xsl:value-of select="$appartmentsIndexAddition"/>
   			<xsl:value-of select="$kadastraleAanduiding/tia:appartementsindex"/>
   		</xsl:if>
	</xsl:template>

	<xsl:template name="DoorTeHalenStuk">
		<xsl:param name="doorTeHalenStuk"/>

		<xsl:text>het hypotheekrecht dat op </xsl:text>
		<xsl:if test="substring(string($doorTeHalenStuk/tia:datumInschrijving),0,11) != ''">
			<xsl:value-of select="kef:convertDateToText(substring(string($doorTeHalenStuk/tia:datumInschrijving),0,11))"/>
		</xsl:if>	
		<xsl:text> is ingeschreven in de openbare registers van het Kadaster</xsl:text>
        <xsl:if test="$doorTeHalenStuk/tia:deelEnNummer/tia:deel != '' and number($doorTeHalenStuk/tia:deelEnNummer/tia:deel) &lt;= 50000">
            <xsl:text> te </xsl:text>
            <xsl:value-of select="$doorTeHalenStuk/tia:deelEnNummer/tia:reeks"/>
        </xsl:if>
        <xsl:text> in register Hypotheken 3 in </xsl:text>
        <xsl:call-template name="IngeschrevenStuk">
        	<xsl:with-param name="ingeschrevenStuk" select="$doorTeHalenStuk/tia:deelEnNummer"/>
        	<xsl:with-param name="reeks" select="'false'"/>
        	<xsl:with-param name="insertAnd" select="'false'"/>
        </xsl:call-template>
	</xsl:template>

	<xsl:template name="mortgageCancellationParcels">
		<xsl:param name="rights"/>
		<xsl:param name="count"/>
		
		<xsl:for-each select="$rights">
			<xsl:text> </xsl:text>
			<xsl:if test="tia:aandeelInRecht and tia:aandeelInRecht/tia:teller != '' and tia:aandeelInRecht/tia:noemer != ''">
				<xsl:text>het </xsl:text>
				<xsl:value-of select="kef:convertNumberToText(tia:aandeelInRecht/tia:teller)"/>
				<xsl:text>/</xsl:text>
				<xsl:value-of select="kef:convertOrdinalToText(tia:aandeelInRecht/tia:noemer)"/>
				<xsl:text> (</xsl:text>
				<xsl:value-of select="tia:aandeelInRecht/tia:teller"/>
				<xsl:text>/</xsl:text>
				<xsl:value-of select="tia:aandeelInRecht/tia:noemer"/>
				<xsl:text>) onverdeeld aandeel in </xsl:text>
			</xsl:if>
			<xsl:text>het kadastrale perceel gemeente </xsl:text>
			<xsl:call-template name="KadastraleAanduiding">
				<xsl:with-param name="kadastraleAanduiding" select="tia:IMKAD_Perceel/tia:kadastraleAanduiding | tia:IMKAD_Appartementsrecht/tia:kadastraleAanduiding"/>
				<xsl:with-param name="appartmentsIndexAddition" select="'A '"/>
			</xsl:call-template>
			<xsl:choose>
				<xsl:when test="$count &lt;= 1 or position() = last()">
					<xsl:text>.</xsl:text>
				</xsl:when>
				<xsl:when test="$count > 1 and position() + 1 = last()">
					<xsl:text> en</xsl:text>
				</xsl:when>
				<xsl:when test="$count > 1 and position() + 1 &lt; last()">
					<xsl:text>,</xsl:text>
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>

</xsl:stylesheet>
