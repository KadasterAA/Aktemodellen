<?xml version="1.0" encoding="UTF-8"?>
<!--
*********************************************************
Stylesheet: tekstblok_gevolmachtigde.xsl
Version: 2.00 (AA-)
*********************************************************
Description:
Legal representative text block. 

Public:
(mode) do-legal-representative
(mode) do-capacity-variant-for-legal-representative

Private:
none
-->
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
	xmlns:kef="nl.kadaster.xslt.XslExtensionFunctions"
	xmlns:tia="http://www.kadaster.nl/schemas/KIK/TIA_Algemeen"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xlink="http://www.w3.org/1999/xlink"
	exclude-result-prefixes="tia xsl kef xlink"
	version="1.0">

	<!--
	*********************************************************
	Mode: do-legal-representative
	*********************************************************
	Public: yes

	Identity transform: no

	Description: Legal representative text block.

	Input: tia:Gevolmachtigde

	Params: none

	Output: text

	Calls:
	(mode) do-natural-person
	(mode) do-address
	(mode) do-identity-document
	(mode) do-marital-status
	(mode) do-marital-status-partners
	(mode) do-capacity-variant-for-legal-representative

	Called by:
	(mode) do-parties
	(mode) do-person-pair-partner-variant-two
	(mode) do-person-pair-housemate-variant-three
	(mode) do-person-pair-partner-variant-four
	(mode) do-person-pair-representative-variant-five
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:Gevolmachtigde" mode="do-legal-representative">
		<xsl:variable name="hoedanigheid" select="../tia:Hoedanigheid[concat('#',@id) = current()/tia:vertegenwoordigtRef/@*[translate(local-name(), $upper, $lower) = 'href']]"/>
		<xsl:variable name="capacityVariant" select="$hoedanigheid/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvariant']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvariant']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space($hoedanigheid/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvariant']/tia:tekst), $upper, $lower)]), $upper, $lower)]" />
		<xsl:variable name="maritalStatusVariant" select="tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_burgerlijkestaattekst']/tia:tekst"/>
		
		<xsl:apply-templates select="." mode="do-natural-person"/>
		<xsl:choose>
			<xsl:when test="tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_optie']/tia:tekst = '1'">
				<xsl:text>, werkzaam ten kantore van mij, notaris,</xsl:text>
				<xsl:if test="tia:gegevens/tia:adresKantoor">
					<xsl:text> kantoorhoudende te </xsl:text>
					<!-- Insert space between numbers and letters of post code -->
					<xsl:value-of select="concat(normalize-space(substring(tia:gegevens/tia:adresKantoor/tia:BAG_NummerAanduiding/tia:postcode, 1, 4)), ' ',
						normalize-space(substring(tia:gegevens/tia:adresKantoor/tia:BAG_NummerAanduiding/tia:postcode, 5)))"/>
					<xsl:text> </xsl:text>
					<xsl:value-of select="tia:gegevens/tia:adresKantoor/tia:BAG_Woonplaats/tia:woonplaatsNaam"/>
					<xsl:text>, </xsl:text>
					<xsl:value-of select="tia:gegevens/tia:adresKantoor/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam"/>
					<xsl:text> </xsl:text>
					<xsl:value-of select="tia:gegevens/tia:adresKantoor/tia:BAG_NummerAanduiding/tia:huisnummer"/>
					<xsl:if test="tia:gegevens/tia:adresKantoor/tia:BAG_NummerAanduiding/tia:huisletter
							and normalize-space(tia:gegevens/tia:adresKantoor/tia:BAG_NummerAanduiding/tia:huisletter) != ''">
						<xsl:text> </xsl:text>
						<xsl:value-of select="tia:gegevens/tia:adresKantoor/tia:BAG_NummerAanduiding/tia:huisletter"/>
					</xsl:if>
					<xsl:if test="tia:gegevens/tia:adresKantoor/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging
							and normalize-space(tia:gegevens/tia:adresKantoor/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging) != ''">
						<xsl:text> </xsl:text>
						<xsl:value-of select="tia:gegevens/tia:adresKantoor/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging"/>
					</xsl:if>
					<xsl:text>,</xsl:text>
				</xsl:if>
				<xsl:text> te dezen handelend</xsl:text>
				<xsl:if test="translate(tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verantwoordelijkheidnotaris']/tia:tekst, $upper, $lower) = 'true'">
					<xsl:text> onder de verantwoordelijkheid van mij, notaris, en</xsl:text>
				</xsl:if>
			</xsl:when>
			<xsl:when test="tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_optie']/tia:tekst = '2'">
				<xsl:choose>
					<xsl:when test="count(tia:GerelateerdPersoon) = 0">
<!--						<xsl:if test="tia:gegevens/tia:legitimatiebewijs">-->
<!--							<xsl:text>, </xsl:text>-->
<!--							<xsl:apply-templates select="tia:gegevens/tia:legitimatiebewijs" mode="do-identity-document">-->
<!--								<xsl:with-param name="gender" select="tia:gegevens/tia:persoonGegevens/tia:geslacht/tia:geslachtsaanduiding"/>-->
<!--							</xsl:apply-templates>	-->
<!--						</xsl:if>-->
						<xsl:text>, wonende te</xsl:text>
						<xsl:if test="tia:gegevens/tia:adresPersoon/tia:kadBinnenlandsAdres or tia:gegevens/tia:adresPersoon/tia:binnenlandsAdres or tia:gegevens/tia:adresPersoon/tia:buitenlandsAdres">
								<xsl:text> </xsl:text>
								<xsl:apply-templates select="tia:gegevens" mode="do-address"/>
							<xsl:text>,</xsl:text>
						</xsl:if>
						<xsl:if test="$maritalStatusVariant != ''">
							<xsl:text> </xsl:text>
							<xsl:apply-templates select="." mode="do-marital-status" />
							<xsl:text>,</xsl:text>
						</xsl:if>
						<xsl:text> te dezen handelend</xsl:text>
					</xsl:when>
					<xsl:when test="count(tia:GerelateerdPersoon) > 0">
						<xsl:choose>
							<xsl:when test="translate(tia:GerelateerdPersoon/tia:IndGezamenlijkeWoonlocatie, $upper, $lower) = 'true' and tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_burgerlijkestaattekstpartners']/tia:tekst">
<!--								<xsl:if test="tia:gegevens/tia:legitimatiebewijs">-->
<!--									<xsl:text>, </xsl:text>-->
<!--									<xsl:apply-templates select="tia:gegevens/tia:legitimatiebewijs" mode="do-identity-document">-->
<!--										<xsl:with-param name="gender" select="tia:gegevens/tia:persoonGegevens/tia:geslacht/tia:geslachtsaanduiding"/>-->
<!--									</xsl:apply-templates>	-->
<!--								</xsl:if>-->
								<xsl:text>; en </xsl:text>
								<br/>
								<xsl:for-each select="tia:GerelateerdPersoon">
									<xsl:apply-templates select="tia:IMKAD_Persoon" mode="do-natural-person"/>
<!--									<xsl:if test="tia:IMKAD_Persoon/tia:tia_Legitimatiebewijs">-->
<!--										<xsl:text>, </xsl:text>-->
<!--										<xsl:apply-templates select="tia:IMKAD_Persoon/tia:tia_Legitimatiebewijs" mode="do-identity-document">-->
<!--											<xsl:with-param name="gender" select="tia:IMKAD_Persoon/tia:tia_Gegevens/tia:GBA_Ingezetene/tia:geslacht/tia:geslachtsaanduiding-->
<!--																					| tia:IMKAD_Persoon/tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:geslacht"/>-->
<!--										</xsl:apply-templates>	-->
<!--									</xsl:if>-->
									<xsl:if test="position() != last()">
										<xsl:text>; en</xsl:text>
										<br/>							
									</xsl:if>
								</xsl:for-each>
								<xsl:text>, tezamen </xsl:text>
								<xsl:if test="tia:gegevens/tia:adresPersoon/tia:kadBinnenlandsAdres or tia:gegevens/tia:adresPersoon/tia:binnenlandsAdres or tia:gegevens/tia:adresPersoon/tia:buitenlandsAdres">
									<xsl:text>wonende te </xsl:text>
									<xsl:apply-templates select="tia:gegevens" mode="do-address" />
									<xsl:text>, </xsl:text>
								</xsl:if>
								<xsl:apply-templates select="." mode="do-marital-status-partners" />
								<xsl:text>, te dezen gezamenlijk handelend</xsl:text>								
							</xsl:when>
							<xsl:when test="translate(tia:GerelateerdPersoon/tia:IndGezamenlijkeWoonlocatie, $upper, $lower) = 'false' and tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_burgerlijkestaattekstpartners']/tia:tekst">
<!--								<xsl:if test="tia:gegevens/tia:legitimatiebewijs">-->
<!--									<xsl:text>, </xsl:text>-->
<!--									<xsl:apply-templates select="tia:gegevens/tia:legitimatiebewijs" mode="do-identity-document">-->
<!--										<xsl:with-param name="gender" select="tia:gegevens/tia:persoonGegevens/tia:geslacht/tia:geslachtsaanduiding"/>-->
<!--									</xsl:apply-templates>	-->
<!--								</xsl:if>-->
								<xsl:text>, wonende te </xsl:text>
								<xsl:apply-templates select="tia:gegevens" mode="do-address" />
								<xsl:text>; en </xsl:text>
								<br/>
								<xsl:for-each select="tia:GerelateerdPersoon">
									<xsl:apply-templates select="tia:IMKAD_Persoon" mode="do-natural-person"/>
<!--									<xsl:if test="tia:IMKAD_Persoon/tia:tia_Legitimatiebewijs">-->
<!--										<xsl:text>, </xsl:text>-->
<!--										<xsl:apply-templates select="tia:IMKAD_Persoon/tia:tia_Legitimatiebewijs" mode="do-identity-document">-->
<!--											<xsl:with-param name="gender" select="tia:IMKAD_Persoon/tia:tia_Gegevens/tia:GBA_Ingezetene/tia:geslacht/tia:geslachtsaanduiding-->
<!--													| tia:IMKAD_Persoon/tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:geslacht"/>-->
<!--										</xsl:apply-templates>	-->
<!--									</xsl:if>-->
									<xsl:text>, wonende te </xsl:text>
									<xsl:apply-templates select="tia:IMKAD_Persoon/tia:IMKAD_WoonlocatiePersoon" mode="do-address" />
									<xsl:if test="position() = last()">
										<xsl:text>, </xsl:text>
									</xsl:if>
									<xsl:if test="position() != last()">
										<xsl:text>; en</xsl:text>
										<br/>							
									</xsl:if>
								</xsl:for-each>
								<xsl:apply-templates select="." mode="do-marital-status-partners" />
								<xsl:text>, te dezen gezamenlijk handelend</xsl:text>
							</xsl:when>
							<xsl:when test="translate(tia:GerelateerdPersoon/tia:IndGezamenlijkeWoonlocatie, $upper, $lower) = 'true' and not(tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_burgerlijkestaattekst']) and not(tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_burgerlijkestaattekstpartners'])">
<!--								<xsl:if test="tia:gegevens/tia:legitimatiebewijs">-->
<!--									<xsl:text>, </xsl:text>-->
<!--									<xsl:apply-templates select="tia:gegevens/tia:legitimatiebewijs" mode="do-identity-document">-->
<!--										<xsl:with-param name="gender" select="tia:gegevens/tia:persoonGegevens/tia:geslacht/tia:geslachtsaanduiding"/>-->
<!--									</xsl:apply-templates>	-->
<!--								</xsl:if>-->
								<xsl:text>; en </xsl:text>
								<br/>
								<xsl:for-each select="tia:GerelateerdPersoon">
									<xsl:apply-templates select="tia:IMKAD_Persoon" mode="do-natural-person"/>
<!--									<xsl:if test="tia:IMKAD_Persoon/tia:tia_Legitimatiebewijs">-->
<!--										<xsl:text>, </xsl:text>-->
<!--										<xsl:apply-templates select="tia:IMKAD_Persoon/tia:tia_Legitimatiebewijs" mode="do-identity-document">-->
<!--											<xsl:with-param name="gender" select="tia:IMKAD_Persoon/tia:tia_Gegevens/tia:GBA_Ingezetene/tia:geslacht/tia:geslachtsaanduiding-->
<!--																					| tia:IMKAD_Persoon/tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:geslacht"/>-->
<!--										</xsl:apply-templates>	-->
<!--									</xsl:if>-->
									<xsl:if test="position() != last()">
										<xsl:text>; en</xsl:text>
										<br/>							
									</xsl:if>
								</xsl:for-each>
								<xsl:text>, tezamen </xsl:text>
								<xsl:if test="tia:gegevens/tia:adresPersoon/tia:kadBinnenlandsAdres or tia:gegevens/tia:adresPersoon/tia:binnenlandsAdres or tia:gegevens/tia:adresPersoon/tia:buitenlandsAdres">
									<xsl:text>wonende te </xsl:text>
									<xsl:apply-templates select="tia:gegevens" mode="do-address" />
									<xsl:text>, </xsl:text>
								</xsl:if>
								<xsl:text>te dezen gezamenlijk handelend</xsl:text>
							</xsl:when>
							<xsl:when test="translate(tia:GerelateerdPersoon/tia:IndGezamenlijkeWoonlocatie, $upper, $lower) = 'false' and tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_burgerlijkestaattekst']/tia:tekst">
<!--								<xsl:if test="tia:gegevens/tia:legitimatiebewijs">-->
<!--									<xsl:text>, </xsl:text>-->
<!--									<xsl:apply-templates select="tia:gegevens/tia:legitimatiebewijs" mode="do-identity-document">-->
<!--										<xsl:with-param name="gender" select="tia:gegevens/tia:persoonGegevens/tia:geslacht/tia:geslachtsaanduiding"/>-->
<!--									</xsl:apply-templates>	-->
<!--								</xsl:if>-->
								<xsl:text>, wonende te </xsl:text>
								<xsl:apply-templates select="tia:gegevens" mode="do-address" />
								<xsl:if test="$maritalStatusVariant != ''">
									<xsl:text>, </xsl:text>
									<xsl:apply-templates select="." mode="do-marital-status" />
								</xsl:if>	
								<xsl:text>; en </xsl:text>
								<br/>
								<xsl:for-each select="tia:GerelateerdPersoon">
									<xsl:variable name="maritalStatusForPerson" >
										<xsl:value-of select="tia:IMKAD_Persoon/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_burgerlijkestaattekst']/tia:tekst" />
									</xsl:variable>
									<xsl:apply-templates select="tia:IMKAD_Persoon" mode="do-natural-person"/>
<!--									<xsl:if test="tia:IMKAD_Persoon/tia:tia_Legitimatiebewijs">-->
<!--										<xsl:text>, </xsl:text>-->
<!--										<xsl:apply-templates select="tia:IMKAD_Persoon/tia:tia_Legitimatiebewijs" mode="do-identity-document">-->
<!--											<xsl:with-param name="gender" select="tia:IMKAD_Persoon/tia:tia_Gegevens/tia:GBA_Ingezetene/tia:geslacht/tia:geslachtsaanduiding-->
<!--													| tia:IMKAD_Persoon/tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:geslacht"/>-->
<!--										</xsl:apply-templates>	-->
<!--									</xsl:if>									-->
									<xsl:text>, wonende te </xsl:text>
									<xsl:apply-templates select="tia:IMKAD_Persoon/tia:IMKAD_WoonlocatiePersoon" mode="do-address" />
									<xsl:if test="$maritalStatusForPerson != ''">
										<xsl:text>, </xsl:text>
										<xsl:apply-templates select="tia:IMKAD_Persoon" mode="do-marital-status" />
									</xsl:if>	
									<xsl:choose>
										<xsl:when test="position() != last()">
											<xsl:text>; en</xsl:text>					
											<br/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:text>, </xsl:text>
										</xsl:otherwise>
									</xsl:choose>		
								</xsl:for-each>
								<br/>
								<xsl:text>te dezen gezamenlijk handelend</xsl:text>
							</xsl:when>
						</xsl:choose>
					</xsl:when>
				</xsl:choose>
			</xsl:when>
		</xsl:choose>
		<xsl:if test="$hoedanigheid and ($capacityVariant = '5' or $capacityVariant = '6' or $capacityVariant = '7')">				
				<xsl:text> </xsl:text>
				<xsl:apply-templates select="$hoedanigheid" mode="do-capacity-variant-for-legal-representative">
					<xsl:with-param name="relatedPersons" select="descendant::tia:IMKAD_Persoon"/>
					<xsl:with-param name="authorizedRepresentative" select="."/>
				</xsl:apply-templates>
		</xsl:if>	
	</xsl:template>

	<!--
	*********************************************************
	Mode: do-capacity-variant-for-legal-representative
	*********************************************************
	Public: no

	Identity transform: no

	Description: Hoedangheid variants text block.

	Input: tia:Hoedanigheid

	Params: relatedPersons - variable where related persons are stored 
			authorizedRepresentative - variable where related authorized representative is stored

	Output: text

	Calls: none 

	Called by:
	(mode) do-legal-representative
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:Hoedanigheid" mode="do-capacity-variant-for-legal-representative">
		<xsl:param name="relatedPersons" select="self::node()[false()]"/>
		<xsl:param name="authorizedRepresentative" select="self::node()[false()]"/>
		
		<xsl:variable name="capacityVariant" select="tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvariant']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvariant']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
			translate(normalize-space(current()/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidvariant']/tia:tekst), $upper, $lower)]), $upper, $lower)]" />
		<xsl:variable name="numberOfPersons" select="count($relatedPersons)"/>
		<xsl:variable name="genderOfFirstLegalPerson" select="$relatedPersons[1]/tia:tia_Gegevens/tia:NHR_Rechtspersoon/tia:rechtsvormSub"/>		
		<xsl:variable name="genderFromKodesFile" select="$legalPersonNames[translate(Value[@ColumnRef = 'C']/SimpleValue, $upper, $lower) = translate($genderOfFirstLegalPerson, $upper, $lower)]/Value[@ColumnRef = 'E']/SimpleValue"/>
		<xsl:variable name="gender">
			<xsl:choose>
				<xsl:when test="$numberOfPersons = 1">
					<xsl:choose>
						<xsl:when test="translate($relatedPersons[1]/tia:tia_Gegevens/tia:GBA_Ingezetene/tia:geslacht/tia:geslachtsaanduiding, $upper, $lower) = 'vrouw' 
								or translate($relatedPersons[1]/tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:geslacht, $upper, $lower) = 'vrouw'
								or translate($genderFromKodesFile, $upper, $lower) = 'v'">
							<xsl:text>haar</xsl:text>
						</xsl:when>
						<xsl:when test="translate($relatedPersons[1]/tia:tia_Gegevens/tia:GBA_Ingezetene/tia:geslacht/tia:geslachtsaanduiding, $upper, $lower) = 'man' 
								or translate($relatedPersons[1]/tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:geslacht, $upper, $lower) = 'man'
								or translate($genderFromKodesFile, $upper, $lower) = 'm'">
							<xsl:text>zijn</xsl:text>
						</xsl:when>
						<xsl:when test="translate($relatedPersons[1]/tia:tia_Gegevens/tia:GBA_Ingezetene/tia:geslacht/tia:geslachtsaanduiding, $upper, $lower) = 'onbekend'
								or translate($relatedPersons[1]/tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:geslacht, $upper, $lower) = 'onbekend'
								or translate($genderFromKodesFile, $upper, $lower) = 'o'">
							<xsl:text>diens</xsl:text>
						</xsl:when>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text></xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:choose>
			<xsl:when test="$capacityVariant = '5'">
				<xsl:variable name="capacityTextVariant5" select="$keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidtekstvariant5']/tia:tekst[
					position() = translate(normalize-space(current()/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidtekstvariant5']/tia:tekst), $upper, $lower)]" />
				<xsl:choose>
					<xsl:when test="$numberOfPersons = 0">
						<xsl:variable name="capacityTextVariant5Plurality">
							<xsl:if test="contains(translate($capacityTextVariant5, $upper, $lower), 'mondeling gevolmachtigden') or contains(translate($capacityTextVariant5, $upper, $lower), 'schriftelijk gevolmachtigden')">
								<xsl:value-of select="concat(substring-before($capacityTextVariant5, 'gevolmachtigden'), 'gevolmachtigde', substring-after($capacityTextVariant5, 'gevolmachtigden'))"/>
							</xsl:if>
						</xsl:variable>
						<xsl:value-of select="$capacityTextVariant5Plurality"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$capacityTextVariant5"/>
					</xsl:otherwise>
				</xsl:choose>					
			</xsl:when>
			<xsl:when test="$capacityVariant = '6'">
				<xsl:variable name="capacityTextVariant6" select="$keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidtekstvariant6']/tia:tekst[
					position() = translate(normalize-space(current()/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidtekstvariant6']/tia:tekst), $upper, $lower)]" />
				<xsl:variable name="genderVariant6">
					<xsl:choose>
						<xsl:when test="$numberOfPersons = 0">
							<xsl:choose>
								<xsl:when test="translate($authorizedRepresentative/tia:gegevens/tia:persoonGegevens/tia:geslacht/tia:geslachtsaanduiding, $upper, $lower) = 'vrouw'">
									<xsl:text>haar</xsl:text>
								</xsl:when>
								<xsl:when test="translate($authorizedRepresentative/tia:gegevens/tia:persoonGegevens/tia:geslacht/tia:geslachtsaanduiding, $upper, $lower) = 'man'">
									<xsl:text>zijn</xsl:text>
								</xsl:when>
								<xsl:when test="translate($authorizedRepresentative/tia:gegevens/tia:persoonGegevens/tia:geslacht/tia:geslachtsaanduiding, $upper, $lower) = 'onbekend'">
									<xsl:text>diens</xsl:text>
								</xsl:when>
							</xsl:choose>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>hun</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>				
				<xsl:variable name="datumVariant6">
					<xsl:value-of select="$authorizedRepresentative/tia:gegevensOndertekening[tia:soortOndertekening = 'beschikking kantonrechter']/tia:datum"/>							
				</xsl:variable>
				<xsl:variable name="placeVariant6">
					<xsl:value-of select="$authorizedRepresentative/tia:gegevensOndertekening[tia:soortOndertekening = 'beschikking kantonrechter']/tia:naamGemeente"/>							
				</xsl:variable>				
				<xsl:variable name="capacityTextVariant6WithGender">
					<xsl:value-of select="concat(substring-before($capacityTextVariant6, 'zijn/haar/diens/hun'), $genderVariant6, substring-after($capacityTextVariant6, 'zijn/haar/diens/hun'))"/>
				</xsl:variable>
				<xsl:variable name="capacityTextVariant6WithGenderPlurality">
					<xsl:choose>
						<xsl:when test="$numberOfPersons = 0">
							<xsl:value-of select="concat(substring-before($capacityTextVariant6WithGender, 'curatoren'), 'curator', substring-after($capacityTextVariant6WithGender, 'curatoren'))"/>							
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$capacityTextVariant6WithGender"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<xsl:variable name="Datum_DATE_VARIANT_6" select="substring(string($datumVariant6), 0, 11)"/>
				<xsl:variable name="Datum_STRING_VARIANT_6">
		 			<xsl:if test="$Datum_DATE_VARIANT_6 != ''">
						<xsl:value-of select="kef:convertDateToText($Datum_DATE_VARIANT_6)"/>
					</xsl:if>
				</xsl:variable>
				
				<xsl:choose>
					<xsl:when test="contains(translate($capacityTextVariant6WithGenderPlurality, $upper, $lower), 'plaats') and contains(translate($capacityTextVariant6WithGenderPlurality, $upper, $lower), 'datum')">
						<xsl:variable name="middleText">
							<xsl:value-of select="substring-after(substring-before($capacityTextVariant6WithGenderPlurality, 'datum'), 'plaats')"></xsl:value-of>
						</xsl:variable>
						<xsl:value-of select="concat(substring-before($capacityTextVariant6WithGenderPlurality, 'plaats'), $placeVariant6, $middleText, $Datum_STRING_VARIANT_6, substring-after($capacityTextVariant6WithGenderPlurality, 'datum'))"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$capacityTextVariant6WithGenderPlurality"/>
					</xsl:otherwise>
				</xsl:choose>	
			</xsl:when>
			<xsl:when test="$capacityVariant = '7'">	
				<xsl:variable name="capacityTextVariant7" select="$keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidtekstvariant7']/tia:tekst[
					position() = translate(normalize-space(current()/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hoedanigheidtekstvariant7']/tia:tekst), $upper, $lower)]" />
				<xsl:variable name="datumVariant7">
					<xsl:value-of select="$authorizedRepresentative/tia:gegevensOndertekening[tia:soortOndertekening = 'beschikking kantonrechter']/tia:datum"/>							
				</xsl:variable>
				<xsl:variable name="placeVariant7">
					<xsl:value-of select="$authorizedRepresentative/tia:gegevensOndertekening[tia:soortOndertekening = 'beschikking kantonrechter']/tia:naamGemeente"/>							
				</xsl:variable>					
				<xsl:variable name="capacityTextVariant7Plurality">
					<xsl:choose>
						<xsl:when test="$numberOfPersons = 0">
							<xsl:choose>
								<xsl:when test="contains(translate($capacityTextVariant7, $upper, $lower), 'bewindvoerders')">
									<xsl:value-of select="concat(substring-before($capacityTextVariant7, 'bewindvoerders'), 'bewindvoerder', substring-after($capacityTextVariant7, 'bewindvoerders'))"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$capacityTextVariant7"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$capacityTextVariant7"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<xsl:variable name="Datum_DATE_VARIANT_7" select="substring(string($datumVariant7), 0, 11)"/>
				<xsl:variable name="Datum_STRING_VARIANT_7">
		 			<xsl:if test="$Datum_DATE_VARIANT_7 != ''">
						<xsl:value-of select="kef:convertDateToText($Datum_DATE_VARIANT_7)"/>
					</xsl:if>
				</xsl:variable>
				
				<xsl:choose>
					<xsl:when test="contains(translate($capacityTextVariant7Plurality, $upper, $lower), 'plaats') and contains(translate($capacityTextVariant7Plurality, $upper, $lower), 'datum')">
						<xsl:variable name="middleText">
							<xsl:value-of select="substring-after(substring-before($capacityTextVariant7Plurality, 'datum'), 'plaats')"></xsl:value-of>
						</xsl:variable>
						<xsl:value-of select="concat(substring-before($capacityTextVariant7Plurality, 'plaats'), $placeVariant7, $middleText, $Datum_STRING_VARIANT_7, substring-after($capacityTextVariant7Plurality, 'datum'))"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$capacityTextVariant7Plurality"/>
					</xsl:otherwise>
				</xsl:choose>				
			</xsl:when>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
