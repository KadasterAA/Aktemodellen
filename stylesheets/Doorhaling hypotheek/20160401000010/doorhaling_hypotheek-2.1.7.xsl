<?xml version="1.0" encoding="UTF-8"?>
<!--
*********************************************************
Stylesheet: doorhaling_hypotheek.xsl
Version: 2.1.7 (AA-3613: tekstblok aanhef en equivalentieverklaring)
*********************************************************
Description:
Mortgage cancellation deed.

Public:
(mode) do-deed

Private:
(mode) do-parties
(mode) do-party-person
(mode) do-renouncement-of-mortgage-right
(mode) do-acceptance-proxy
(mode) do-termination-of-mortgage-right
(mode) do-revocation-of-decision
(mode) do-person-numbering
(mode) do-document-cancellation
(mode) do-copy
-->
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:tia="http://www.kadaster.nl/schemas/KIK/TIA_Algemeen" xmlns:kef="nl.kadaster.xslt.XslExtensionFunctions" xmlns:gc="http://docs.oasis-open.org/codelist/ns/genericode/1.0/" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exslt="http://exslt.org/common" xmlns:xlink="http://www.w3.org/1999/xlink" exclude-result-prefixes="tia kef gc xsl exslt xlink" version="1.0">
	<xsl:include href="generiek-1.08.xsl"/>
	<xsl:include href="tekstblok_aanhef-1.18.xsl"/>
	<xsl:include href="tekstblok_burgerlijke_staat-1.02.xsl"/>
	<xsl:include href="tekstblok_equivalentieverklaring-1.26.xsl"/>
	<xsl:include href="tekstblok_legitimatie-1.01.xsl"/>
	<xsl:include href="tekstblok_personalia_van_natuurlijk_persoon-1.06.xsl"/>
	<xsl:include href="tekstblok_natuurlijk_persoon-1.12.xsl"/>
	<xsl:include href="tekstblok_partij_natuurlijk_persoon_doorhaling-2.0.0.xsl"/>
	<xsl:include href="tekstblok_partij_niet_natuurlijk_persoon_doorhaling-2.0.0.xsl"/>
	<xsl:include href="tekstblok_woonadres-1.05.xsl"/>
	<xsl:include href="tekstblok_rechtspersoon-1.14.0.xsl"/>
	<xsl:include href="tekstblok_deel_nummer-1.03.xsl"/>
	<xsl:include href="tekstblok_recht-1.16.xsl"/>
	<xsl:include href="tekstblok_registergoed-1.26.xsl"/>
	<!-- MCD specific global variables -->
	<xsl:variable name="keuzeteksten" select="document('keuzeteksten_doorhaling_hypotheek-2.0.0.xml')"/>
	<xsl:variable name="legalPersonNames" select="document('nnp-kodes_doorhalinghypotheek.xml')/gc:CodeList/SimpleCodeList/Row"/>
	<!-- 'Bij akte andere notaris' is first row -->
	<xsl:variable name="bijAkteAndereNotaris" select="translate(document('aanvaarding.xml')/gc:CodeList/SimpleCodeList/Row[1]/Value[1]/SimpleValue, $upper, $lower)"/>
	<!-- 'Bij akte oud-notaris' is second row -->
	<xsl:variable name="bijAkteOudNotaris" select="translate(document('aanvaarding.xml')/gc:CodeList/SimpleCodeList/Row[2]/Value[1]/SimpleValue, $upper, $lower)"/>
	<!-- 'Bij andere eigen akte' is third row -->
	<xsl:variable name="bijAndereEigenAkte" select="translate(document('aanvaarding.xml')/gc:CodeList/SimpleCodeList/Row[3]/Value[1]/SimpleValue, $upper, $lower)"/>
	<!-- 'Onderhandse volmacht' is fourth row -->
	<xsl:variable name="onderhandseVolmacht" select="translate(document('aanvaarding.xml')/gc:CodeList/SimpleCodeList/Row[4]/Value[1]/SimpleValue, $upper, $lower)"/>
	<!-- 'afstand hypotheekrecht' is first row -->
	<xsl:variable name="afstandHypotheekrecht" select="translate(document('soortdoorhaling.xml')/gc:CodeList/SimpleCodeList/Row[1]/Value[1]/SimpleValue, $upper, $lower)"/>
	<!-- 'opzegging hypotheekrecht' is second row -->
	<xsl:variable name="opzeggingHypotheekrecht" select="translate(document('soortdoorhaling.xml')/gc:CodeList/SimpleCodeList/Row[2]/Value[1]/SimpleValue, $upper, $lower)"/>
	<!-- 'vervallenverklaring' is third row -->
	<xsl:variable name="vervallenverklaring" select="translate(document('soortdoorhaling.xml')/gc:CodeList/SimpleCodeList/Row[3]/Value[1]/SimpleValue, $upper, $lower)"/>
	<!-- Document title -->
	<xsl:variable name="documentTitle" select="tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_titeldoorhaling']/tia:tekst"/>
	<!-- tel het aantal gevolmachtigden -->
	<xsl:variable name="numberOfRepresentatives" select="count(//tia:Gevolmachtigde)"/>
	<xsl:variable name="numberOfParties" select="count(tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:Partij)"/>
	<xsl:variable name="numberOfCancellations" select="count(tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:StukdeelDoorhalingHypotheek)"/>
	<!--xsl:variable name="numberOfRepresentatives" select="count(tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:Gevolmachtigde) + count(tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:Partij[substring((translate(tia:aanduidingPartij, $upper, $lower)),1,13) = 'volmachtgever']/tia:Gevolmachtigde)"/-->
	<!-- tel het aantal volmachtgevers -->
	<xsl:variable name="volmachtgeversTotalCount" select="count(tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:Partij[
			(substring((translate(tia:aanduidingPartij, $upper, $lower)),1,13) = 'volmachtgever') or
			(substring((translate(tia:aanduidingPartij, $upper, $lower)),1,15) = 'hypotheekhouder')
			]/tia:Partij/tia:IMKAD_Persoon
		| tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:Partij[
			(substring((translate(tia:aanduidingPartij, $upper, $lower)),1,13) = 'volmachtgever') or
			(substring((translate(tia:aanduidingPartij, $upper, $lower)),1,15) = 'hypotheekhouder')
			]/tia:Partij/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon)"/>
	<!-- tel het aantal rechthebbenden -->
	<xsl:variable name="rechthebbendenTotalCount" select="count(tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:Partij[substring((translate(tia:aanduidingPartij, $upper, $lower)),1,13) = 'rechthebbende']/tia:Partij/tia:IMKAD_Persoon
			| tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:Partij[substring((translate(tia:aanduidingPartij, $upper, $lower)),1,13) = 'rechthebbende']/tia:Partij/tia:IMKAD_Persoon/tia:GerelateerdPersoon/tia:IMKAD_Persoon)"/>
	<!-- tel het aantal gerelateerde personen -->
	<xsl:variable name="gerelateerdenTotalCount" select="count(tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:Partij/tia:Partij/tia:IMKAD_Persoon/tia:GerelateerdPersoon)"/>
	<xsl:variable name="RegistergoedTonenPerPerceel">
		<!-- t.b.v. TB Registergoed -->
		<xsl:choose>
			<xsl:when test="tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedtonenperperceel']">
				<xsl:value-of select="translate(tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedtonenperperceel']/tia:tekst, $upper, $lower)"/>
			</xsl:when>
			<xsl:otherwise>false</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<!--
	*********************************************************
	Mode: do-deed
	*********************************************************
	Public: yes

	Identity transform: no

	Description: Mortgage cancellation deed.

	Input: tia:Bericht_TIA_Stuk

	Params: none

	Output: XHTML structure

	Calls:
	(mode) do-statement-of-equivalence
	(mode) do-header
	(mode) do-keuzeblok-gevolmachtigde
	(mode) do-parties
	(mode) do-renouncement-of-mortgage-right
	(mode) do-termination-of-mortgage-right
	(mode) do-revocation-of-decision

	Called by:
	Root template
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:Bericht_TIA_Stuk" mode="do-deed">
		<!-- Text block Statement of equivalence -->
		<xsl:if test="translate($type-document, $upper, $lower) = 'afschrift'">
			<a name="mortgagecancellationdeed.statementOfEquivalence" class="location">&#160;</a>
			<xsl:apply-templates select="tia:IMKAD_AangebodenStuk" mode="do-statement-of-equivalence"/>
			<!-- Two empty lines after Statement of equivalence -->
			<p>
				<br/>
			</p>
			<p>
				<br/>
			</p>
		</xsl:if>
		<a name="mortgagecancellationdeed.header" class="location">&#160;</a>
		<!-- Document title -->
		<xsl:if test="normalize-space($documentTitle) != ''">
			<p style="text-align:center" title="without_dashes">
				<xsl:value-of select="$documentTitle"/>
			</p>
			<!-- Empty line after title -->
			<p title="without_dashes">
				<br/>
			</p>
		</xsl:if>
		<!-- Offertenummer -->
		<xsl:if test="tia:IMKAD_AangebodenStuk/tia:tia_OmschrijvingKenmerk and normalize-space(tia:IMKAD_AangebodenStuk/tia:tia_OmschrijvingKenmerk) != ''">
			<p title="without_dashes">
				<xsl:text>Kenmerk: </xsl:text>
				<xsl:value-of select="tia:IMKAD_AangebodenStuk/tia:tia_OmschrijvingKenmerk"/>
			</p>
			<!-- Empty line after Offertenummer -->
			<p title="without_dashes">
				<br/>
			</p>
		</xsl:if>
		<!-- Text block Header -->
		<xsl:apply-templates select="tia:IMKAD_AangebodenStuk" mode="do-header"/>
		<!-- As there are nested parties used as wrappers for persons, restructure the XML in order to conform to person templates and usual party-person XML structure -->
		<xsl:variable name="_aangebodenStukRestructured">
			<xsl:apply-templates select="tia:IMKAD_AangebodenStuk" mode="do-copy"/>
		</xsl:variable>
		<xsl:variable name="aangebodenStukRestructured" select="exslt:node-set($_aangebodenStukRestructured)"/>
		<!-- TEKSTBLOK_Volmachtgevers -->
		<xsl:for-each select="$aangebodenStukRestructured/tia:IMKAD_AangebodenStuk/tia:Partij[
			(substring((translate(tia:aanduidingPartij, $upper, $lower)),1,13) = 'volmachtgever') or
			(substring((translate(tia:aanduidingPartij, $upper, $lower)),1,15) = 'hypotheekhouder')]">
			<xsl:apply-templates select="." mode="do-partij"/>
		</xsl:for-each>
		<!-- TEKSTBLOK_rechthebbenden -->
		<xsl:for-each select="$aangebodenStukRestructured/tia:IMKAD_AangebodenStuk/tia:Partij[substring((translate(tia:aanduidingPartij, $upper, $lower)),1,13) = 'rechthebbende']">
			<xsl:apply-templates select="." mode="do-partij"/>
		</xsl:for-each>
		<!-- Tekstblok Volmachtverlening
			//IMKAD_AangebodenStuk/AantalOnderhandseAktenVolmacht
		 -->
		<xsl:call-template name="do-volmachtverlening"/>
		<!-- Keuzeblok Soort Doorhaling
			//IMKAD_AangebodenStuk/StukdeelDoorhalingHypotheek/soortDoorhaling
		-->
		<xsl:apply-templates select="tia:IMKAD_AangebodenStuk" mode="do-keuzeblok-soort-doorhaling"/>
		<!-- vaste tekst: TEKSTBLOK_Volmachtverlening -->
		<xsl:call-template name="do-overige-verklaringen"/>
		<!-- Tekstblok Woonplaatskeuze -->
		<xsl:variable name="woonplaatskeuze" select="tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_woonplaatskeuze']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_woonplaatskeuze']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
			translate(normalize-space(current()/tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_woonplaatskeuze']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
		<xsl:if test="$woonplaatskeuze != ''">
			<a name="mortgagecancellationdeed.electionOfDomicile" class="location">&#160;</a>
			<h3>
				<u>
					<xsl:text>Woonplaatskeuze</xsl:text>
				</u>
			</h3>
			<p>
				<xsl:value-of select="$woonplaatskeuze"/>
				<xsl:text>.</xsl:text>
			</p>
		</xsl:if>
		<!-- Identiteit personen-->
		<p>
			<xsl:text>De identiteit van de verschenen </xsl:text>
			<xsl:choose>
				<xsl:when test="$numberOfRepresentatives > 1">
					<xsl:text>personen </xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>persoon </xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text>is door mij, notaris, aan de hand van </xsl:text>
			<xsl:if test="$numberOfRepresentatives = 1">
				<xsl:text>een </xsl:text>
			</xsl:if>
			<xsl:text>daartoe </xsl:text>
			<xsl:choose>
				<xsl:when test="$numberOfRepresentatives > 1">
					<xsl:text>bestemde documenten </xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>bestemd document </xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text>vastgesteld.</xsl:text>
		</p>
		<!-- Passeren akte -->
		<a name="mortgagecancellationdeed.signature" class="location">&#160;</a>
		<xsl:apply-templates select="tia:IMKAD_AangebodenStuk" mode="do-signature"/>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-copy
	*********************************************************
	Public: no

	Identity transform: no

	Description: Recursive template used for creation/copy of structure that is exactly the same as matched one, except for the tia:Gevolmachtigde and tia:Hoedanigheid elements on tia:AangebodenStuk level and the nested party structures specific for Mortgage cancellation deed.
				 tia:Gevolmachtigde and tia:Hoedanigheid elements on tia:AangebodenStuk level will be copied into tia:Partij elements in order to create usual party XML structure that can be used in any following logic.
				 Nested parties wrapper element (tia:Partij) is not copied into new structure, in order to create usual party-person XML structure that can be used in any following logic.

	Input: @*|node()

	Params: none

	Output: XHTML structure

	Calls:
	(mode) do-copy

	Called by:
	(mode) do-deed
	-->
	<!--
	**** matching template     ****************************************************************************
	**** ATTRIBUTES/NODES/TEXT ****************************************************************************
	-->
	<xsl:template match="@*|node()" mode="do-copy">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" mode="do-copy"/>
		</xsl:copy>
	</xsl:template>
	<!--
	**** matching template ********************************************************************************
	**** NOT NESTED PARTY  ********************************************************************************
	-->
	<xsl:template match="tia:Partij[not(parent::tia:Partij)]" mode="do-copy">
		<tia:Partij>
			<xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute>
			<xsl:apply-templates select="../tia:Hoedanigheid" mode="do-copy"/>
			<xsl:apply-templates select="../tia:Gevolmachtigde" mode="do-copy"/>
			<xsl:apply-templates select="./node()" mode="do-copy"/>
		</tia:Partij>
	</xsl:template>
	<!--
	**** matching template ********************************************************************************
	**** NESTED PARTY      ********************************************************************************
	-->
	<xsl:template match="tia:Partij[parent::tia:Partij]" mode="do-copy">
		<xsl:apply-templates select="tia:IMKAD_Persoon" mode="do-copy"/>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-keuzeblok-gevolmachtigde
	*********************************************************
	Public: no

	Identity transform: no

	Description: Verplicht keuzeblok.
	De gevolmachtigde treedt op voor de volmachtgevers of voor de volmachtgevers en rechthebbenden.

	Input: tia:Gevolmachtigde

	Params: none

	Output: XHTML structure

	Calls:
	(mode) do-keuzeblok-kantoorgevolmachtigde
	(mode) do-natural-person
	(mode) do-identity-document
	(mode) do-address
	(mode) do-marital-status

	Called by:
	(mode) do-deed
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:Gevolmachtigde" mode="do-keuzeblok-gevolmachtigde">
		<xsl:choose>
			<!-- Variant a. Kantoorgevolmachtigde
				//Gevolmachtigde/gegevens/adresPersoon niet aanwezig
				//Gevolmachtigde/gegevens/adresKantoor optioneel aanwezig
			-->
			<xsl:when test="tia:gegevens[not(tia:adresPersoon)]">
				<xsl:apply-templates select="." mode="do-keuzeblok-kantoorgevolmachtigde"/>
			</xsl:when>
			<!-- Variant b. Natuurlijk Persoon
				//Gevolmachtigde/gegevens/adresPersoon aanwezig
			 -->
			<xsl:when test="tia:gegevens/tia:adresPersoon">
				<!-- TEKSTBLOK_NATUURLIJK_PERSOON -->
				<xsl:apply-templates select="." mode="do-natural-person"/>
				<xsl:text>, </xsl:text>
				<!-- optioneel:TEKSTBLOK_LEGITIMATIE -->
				<xsl:if test="tia:gegevens/tia:legitimatiebewijs">
					<xsl:apply-templates select="tia:gegevens/tia:legitimatiebewijs" mode="do-identity-document">
						<xsl:with-param name="gender" select="tia:gegevens/tia:persoonGegevens/tia:geslacht/tia:geslachtsaanduiding"/>
					</xsl:apply-templates>
					<xsl:text>, </xsl:text>
				</xsl:if>
				<xsl:text>wonende te </xsl:text>
				<!-- TEKSTBLOK_WOONADRES -->
				<xsl:apply-templates select="tia:gegevens" mode="do-address"/>
				<xsl:text>, </xsl:text>
				<!-- optioneel:TEKSTBLOK_BURGERLIJKE_STAAT -->
				<xsl:if test="tia:burgerlijkeStaatTekst">
					<xsl:apply-templates select="." mode="do-marital-status"/>
					<xsl:text>, </xsl:text>
				</xsl:if>
				<xsl:text>te dezen handelend als </xsl:text>
				<!-- TEKSTBLOK_MONDELIJK_SCHRIFTELIJK -->
				<xsl:value-of select="tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_volmachtverlening']/tia:tekst"/>
				<xsl:text> gevolmachtigde van:</xsl:text>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-keuzeblok-kantoorgevolmachtigde
	*********************************************************
	Public: yes

	Identity transform: no

	Description: Legal representative text block.

	Input: tia:Gevolmachtigde

	Params: none

	Output: text

	Calls:
	(mode) do-natural-person
	
	Called by:
	(mode) do-keuzeblok-gevolmachtigde
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:Gevolmachtigde" mode="do-keuzeblok-kantoorgevolmachtigde">
		<xsl:apply-templates select="." mode="do-natural-person"/>
		<xsl:text>, werkzaam ten kantore van mij, notaris, </xsl:text>
		<xsl:if test="tia:gegevens/tia:adresKantoor">
			<xsl:text> kantoorhoudende te </xsl:text>
			<!-- Insert space between numbers and letters of post code -->
			<xsl:value-of select="concat(normalize-space(substring(tia:gegevens/tia:adresKantoor/tia:BAG_NummerAanduiding/tia:postcode, 1, 4)), ' ',
						normalize-space(substring(tia:gegevens/tia:adresKantoor/tia:BAG_NummerAanduiding/tia:postcode, 5)))"/>
			<xsl:text> </xsl:text>
			<xsl:value-of select="normalize-space(tia:gegevens/tia:adresKantoor/tia:BAG_Woonplaats/tia:woonplaatsNaam)"/>
			<xsl:text>, </xsl:text>
			<xsl:value-of select="normalize-space(tia:gegevens/tia:adresKantoor/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam)"/>
			<xsl:text> </xsl:text>
			<xsl:value-of select="normalize-space(tia:gegevens/tia:adresKantoor/tia:BAG_NummerAanduiding/tia:huisnummer)"/>
			<xsl:if test="tia:gegevens/tia:adresKantoor/tia:BAG_NummerAanduiding/tia:huisletter
							and normalize-space(tia:gegevens/tia:adresKantoor/tia:BAG_NummerAanduiding/tia:huisletter) != ''">
				<xsl:text> </xsl:text>
				<xsl:value-of select="normalize-space(tia:gegevens/tia:adresKantoor/tia:BAG_NummerAanduiding/tia:huisletter)"/>
			</xsl:if>
			<xsl:if test="tia:gegevens/tia:adresKantoor/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging
							and normalize-space(tia:gegevens/tia:adresKantoor/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging) != ''">
				<xsl:text> </xsl:text>
				<xsl:value-of select="normalize-space(tia:gegevens/tia:adresKantoor/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging)"/>
			</xsl:if>
			<xsl:text>, </xsl:text>
		</xsl:if>
		<xsl:text>te dezen handelend </xsl:text>
		<xsl:if test="translate(tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verantwoordelijkheidnotaris']/tia:tekst, $upper, $lower) = 'true'">
			<xsl:text>onder de verantwoordelijkheid van mij, notaris, en </xsl:text>
		</xsl:if>
		<xsl:text>als </xsl:text>
		<!-- TEKSTBLOK_MONDELIJK_SCHRIFTELIJK -->
		<xsl:value-of select="normalize-space(tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_volmachtverlening']/tia:tekst)"/>
		<xsl:text> gevolmachtigde van:</xsl:text>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-partij
	*********************************************************
	Public: no

	Identity transform: no

	Description: Tabel van de volmachtgever(s) of van de rechthebbende(n)

	Input: tia:Partij

	Params: none

	Output: XHTML structure

	Calls:
	(mode) do-party-person

	Called by:
	(mode) do-deed
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:Partij" mode="do-partij">
		<!-- bepaal het aantal personen in de partij -->
		<xsl:variable name="personsCount" select="count(tia:IMKAD_Persoon)"/>
		<!-- bepaal het aantal gerelateerde personen in de partij -->
		<xsl:variable name="relatedPersonsCount" select="count(tia:IMKAD_Persoon/tia:GerelateerdPersoon)"/>
		<!-- bepaal de tabel opmaak v/d (N)NP's in de Partij -->
		<!-- skipPartyLetterColumn(1) -->
		<xsl:variable name="skipPartyLetterColumn">
			<xsl:choose>
				<xsl:when test="($volmachtgeversTotalCount > 0) and ($rechthebbendenTotalCount >0)">
					<!-- comparitie nummering variant 4 t/m 6 -->
					<xsl:text>false</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<!--  comparitie nummering variant 1 t/m 3 -->
					<xsl:text>true</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- skipPartyNumberColumn(2) -->
		<xsl:variable name="skipPartyNumberColumn">
			<xsl:choose>
				<xsl:when test="($personsCount = 1) and ($relatedPersonsCount = 0)">
					<!-- comparitie nummering variant 1,4 -->
					<xsl:text>true</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<!-- comparitie nummering variant 2,3,5,6 -->
					<xsl:text>false</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- skipPersonLetterColumn(3) -->
		<xsl:variable name="skipPersonLetterColumn">
			<xsl:choose>
				<xsl:when test="($personsCount > 1) and ($relatedPersonsCount >0)">
					<!-- comparitie nummering variant 3,6 -->
					<xsl:text>false</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<!--  comparitie nummering variant 1,2,4,5 -->
					<xsl:text>true</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- numberOfColums -->
		<xsl:variable name="numberOfColums">
			<xsl:choose>
				<xsl:when test="($skipPartyLetterColumn = 'true') and ($skipPartyNumberColumn = 'true') and ($skipPersonLetterColumn= 'true')">
					<!-- comparitie nummering variant 1 -->
					<xsl:number value="1"/>
				</xsl:when>
				<xsl:when test="(($skipPartyLetterColumn = 'true') and ($skipPartyNumberColumn = 'false') and ($skipPersonLetterColumn= 'true'))
								or (($skipPartyLetterColumn = 'false') and ($skipPartyNumberColumn = 'true') and ($skipPersonLetterColumn= 'true'))">
					<!-- comparitie nummering variant 2,4 -->
					<xsl:number value="2"/>
				</xsl:when>
				<xsl:when test="(($skipPartyLetterColumn = 'true') and ($skipPartyNumberColumn = 'false') and ($skipPersonLetterColumn= 'false'))
								or (($skipPartyLetterColumn = 'false') and ($skipPartyNumberColumn = 'false') and ($skipPersonLetterColumn= 'true'))">
					<!-- comparitie nummering variant 3,5 -->
					<xsl:number value="3"/>
				</xsl:when>
				<xsl:when test="($skipPartyLetterColumn = 'false') and ($skipPartyNumberColumn = 'false') and ($skipPersonLetterColumn= 'false')">
					<!-- comparitie nummering variant 6 -->
					<xsl:number value="4"/>
				</xsl:when>
			</xsl:choose>
		</xsl:variable>
		<!-- bepaal de anker-naam v/d tabel -->
		<xsl:variable name="anchorName">
			<xsl:choose>
				<xsl:when test="(substring((translate(tia:aanduidingPartij, $upper, $lower)),1,13) = 'volmachtgever') or
					(substring((translate(tia:aanduidingPartij, $upper, $lower)),1,15) = 'hypotheekhouder')">
					<xsl:text>party.1</xsl:text>
				</xsl:when>
				<xsl:when test="substring((translate(tia:aanduidingPartij, $upper, $lower)),1,13) = 'rechthebbende'">
					<xsl:text>party.2</xsl:text>
				</xsl:when>
			</xsl:choose>
		</xsl:variable>
		<!-- bepaal de inhoud v/d Partij-letter kolom (1) -->
		<xsl:variable name="partyLetter">
			<xsl:choose>
				<xsl:when test="(substring((translate(tia:aanduidingPartij, $upper, $lower)),1,13) = 'volmachtgever') or
					(substring((translate(tia:aanduidingPartij, $upper, $lower)),1,15) = 'hypotheekhouder')">
					<xsl:text>A</xsl:text>
				</xsl:when>
				<xsl:when test="substring((translate(tia:aanduidingPartij, $upper, $lower)),1,13) = 'rechthebbende'">
					<xsl:text>B</xsl:text>
				</xsl:when>
			</xsl:choose>
		</xsl:variable>
		<!-- bepaal de hoedanigheid in de Partij -->
		<xsl:variable name="hoedanigheidId" select="substring-after(tia:Gevolmachtigde/tia:vertegenwoordigtRef/@xlink:href, '#')"/>
		<!-- bepaal of er een Gevolmachtigde op Partij niveau is -->
		<xsl:variable name="printGevolmachtigdeOnPartyLevel">
			<xsl:choose>
				<xsl:when test="tia:Gevolmachtigde and count(tia:Hoedanigheid[@id = $hoedanigheidId]/tia:wordtVertegenwoordigdRef) = 0 and (count(../tia:Gevolmachtigde) = 0 or count(preceding-sibling::tia:Partij) = 0)">
					<xsl:text>true</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>false</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- Gevolmachtigde on party level data should be printed before party-person table -->
		<xsl:if test="$printGevolmachtigdeOnPartyLevel = 'true'">
			<p>
				<a name="{@id}" class="location" style="_position: relative;">&#xFEFF;</a>
				<xsl:apply-templates select="tia:Gevolmachtigde" mode="do-keuzeblok-gevolmachtigde"/>
			</p>
		</xsl:if>
		<!-- tabel van (N)NP's in de partij -->
		<table cellspacing="0" cellpadding="0">
			<tbody>
				<!-- de hoofd-personen in de partij -->
				<xsl:variable name="numberOfPersons" select="count(tia:IMKAD_Persoon)"/>
				<xsl:for-each select="tia:IMKAD_Persoon">
					<!-- partij nummer (v/d hoofd-persoon) in kolom(2) -->
					<xsl:variable name="partyNumber" select="count(preceding-sibling::tia:IMKAD_Persoon) + 1"/>
					<!-- hoofd (N)NP met zijn gerelateerde-personen in de partij -->
					<!-- template do-party-person wordt altijd aangeroepen met de hoofd (N)NP -->
					<xsl:variable name="afsluiting">
						<!-- Het laatste keuzeblok persoon wordt afgesloten met een ‘,’ en de andere met een ‘;’ -->
						<xsl:choose>
							<xsl:when test="position() &lt; $numberOfPersons">
								<xsl:text>;</xsl:text>
							</xsl:when>
							<xsl:otherwise>
								<xsl:text>,</xsl:text>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
					<xsl:apply-templates select="." mode="do-party-person">
						<xsl:with-param name="anchorName" select="$anchorName"/>
						<xsl:with-param name="numberOfColums" select="$numberOfColums"/>
						<xsl:with-param name="skipPartyLetterColumn" select="$skipPartyLetterColumn"/>
						<xsl:with-param name="partyLetter" select="$partyLetter"/>
						<xsl:with-param name="skipPartyNumberColumn" select="$skipPartyNumberColumn"/>
						<xsl:with-param name="partyNumber" select="$partyNumber"/>
						<xsl:with-param name="skipPersonLetterColumn" select="$skipPersonLetterColumn"/>
						<!-- de hoofd-persoon in de relatie is altijd 'a' -->
						<xsl:with-param name="personLetter" select="1"/>
						<xsl:with-param name="afsluiting" select="$afsluiting"/>
					</xsl:apply-templates>
				</xsl:for-each>
			</tbody>
		</table>
		<xsl:if test="not($skipPartyNumberColumn = 'true') and count(descendant::tia:IMKAD_Persoon) > 1">
			<xsl:attribute name="style"><xsl:text>margin-left: 30px</xsl:text></xsl:attribute>
		</xsl:if>
		<!-- tekstblok k_IederVanHen -->
		<xsl:value-of select="tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_iedervanhen']/tia:tekst"/>
		<!-- tekstblok aanduidingPartij -->
		<xsl:text> hierna te noemen: </xsl:text>
		<xsl:choose>
			<xsl:when test="translate(tia:aanduidingPartij, $upper, $lower) = 'volmachtgever'">
				<xsl:text>volmachtgever</xsl:text>
			</xsl:when>
			<xsl:when test="translate(tia:aanduidingPartij, $upper, $lower) = 'rechthebbende'">
				<xsl:text>rechthebbende</xsl:text>
			</xsl:when>
			<xsl:when test="translate(tia:aanduidingPartij, $upper, $lower) = 'volmachtgevers'">
				<xsl:text>volmachtgevers</xsl:text>
			</xsl:when>
			<xsl:when test="translate(tia:aanduidingPartij, $upper, $lower) = 'rechthebbenden'">
				<xsl:text>rechthebbenden</xsl:text>
			</xsl:when>
			<xsl:when test="translate(tia:aanduidingPartij, $upper, $lower) = 'volmachtgever en/of hypotheekhouder'">
				<xsl:text>volmachtgever en/of hypotheekhouder</xsl:text>
			</xsl:when>
			<xsl:when test="translate(tia:aanduidingPartij, $upper, $lower) = 'volmachtgevers en/of hypotheekhouders'">
				<xsl:text>volmachtgevers en/of hypotheekhouders</xsl:text>
			</xsl:when>
		</xsl:choose>
		<!-- volgt partij rechthebbenden dan wordt partij volmachtgevers afgesloten met een ‘;’ -->
		<!-- anders afgesluiten met een ‘.’ -->
		<xsl:choose>
			<xsl:when test="((substring((translate(tia:aanduidingPartij, $upper, $lower)),1,13) = 'volmachtgever') or
				(substring((translate(tia:aanduidingPartij, $upper, $lower)),1,15) = 'hypotheekhouder'))
				and ($rechthebbendenTotalCount >0)">
				<xsl:text>;</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>.</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-party-person
	*********************************************************
	Public: no

	Identity transform: no

	Description: Mortgage cancellation deed party persons.

	Input: tia:IMKAD_Persoon

	Params: anchorName - name of the anchor that will be used in first <td> element
			numberOfColums - max. number of columns used in table
			skipPartyLetterColumn - indicator if party letter column(1) should not be printed
			partyLetter - party letter (A or B)
			skipPartyNumberColumn - indicator if party number column(2) should not be printed
			partyNumber - ordinal number of the party
			skipPersonLetterColumn - indicator if person letter column(3) should not be printed
			personLetter - ordinal letter of the person in the party

	Output: XHTML structure

	Calls:
	(mode) do-party-natural-person
	(mode) do-party-legal-person

	Called by:
	(mode) do-parties
	-->
	<!--
	**** matching template ********************************************************************************
	****   NATURAL PERSON  ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon[(tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene)]" mode="do-party-person">
		<xsl:param name="anchorName"/>
		<xsl:param name="numberOfColums"/>
		<xsl:param name="skipPartyLetterColumn"/>
		<xsl:param name="partyLetter"/>
		<xsl:param name="skipPartyNumberColumn"/>
		<xsl:param name="partyNumber"/>
		<xsl:param name="skipPersonLetterColumn"/>
		<xsl:param name="personLetter"/>
		<xsl:param name="afsluiting"/>
		<xsl:apply-templates select="." mode="do-party-natural-person">
			<xsl:with-param name="anchorName" select="$anchorName"/>
			<xsl:with-param name="numberOfColums" select="$numberOfColums"/>
			<xsl:with-param name="skipPartyLetterColumn" select="$skipPartyLetterColumn"/>
			<xsl:with-param name="partyLetter" select="$partyLetter"/>
			<xsl:with-param name="skipPartyNumberColumn" select="$skipPartyNumberColumn"/>
			<xsl:with-param name="partyNumber" select="$partyNumber"/>
			<xsl:with-param name="skipPersonLetterColumn" select="$skipPersonLetterColumn"/>
			<xsl:with-param name="personLetter" select="$personLetter"/>
			<xsl:with-param name="afsluiting" select="$afsluiting"/>
		</xsl:apply-templates>
	</xsl:template>
	<!--
	**** matching template ********************************************************************************
	****    LEGAL PERSON   ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_Persoon[tia:tia_Gegevens/tia:NHR_Rechtspersoon]" mode="do-party-person">
		<xsl:param name="anchorName"/>
		<xsl:param name="numberOfColums"/>
		<xsl:param name="skipPartyLetterColumn"/>
		<xsl:param name="partyLetter"/>
		<xsl:param name="skipPartyNumberColumn"/>
		<xsl:param name="partyNumber"/>
		<xsl:param name="skipPersonLetterColumn"/>
		<xsl:param name="personLetter"/>
		<xsl:param name="afsluiting"/>
		<xsl:apply-templates select="." mode="do-party-legal-person">
			<xsl:with-param name="anchorName" select="$anchorName"/>
			<xsl:with-param name="numberOfColums" select="$numberOfColums"/>
			<xsl:with-param name="skipPartyLetterColumn" select="$skipPartyLetterColumn"/>
			<xsl:with-param name="partyLetter" select="$partyLetter"/>
			<xsl:with-param name="skipPartyNumberColumn" select="$skipPartyNumberColumn"/>
			<xsl:with-param name="partyNumber" select="$partyNumber"/>
			<xsl:with-param name="skipPersonLetterColumn" select="$skipPersonLetterColumn"/>
			<xsl:with-param name="personLetter" select="$personLetter"/>
			<xsl:with-param name="afsluiting" select="$afsluiting"/>
		</xsl:apply-templates>
	</xsl:template>

	<!--
	*********************************************************
	template: do-volmachtverlening
	*********************************************************
	Public: yes

	Description: Tekstblok Volmachtverlening
		//IMKAD_AangebodenStuk/AantalOnderhandseAktenVolmacht.

	Input: -

	Called by do-deed
	-->
	<xsl:template name="do-volmachtverlening">
		<h3>
			<u>
				<xsl:text>Volmachtverlening</xsl:text>
			</u>
		</h3>
		<p>
			<xsl:text>Van gemelde volmacht</xsl:text>
			<xsl:if test="tia:IMKAD_AangebodenStuk/tia:tia_AantalOnderhandseAktenVolmacht > 1">
				<xsl:text>en</xsl:text>
			</xsl:if>
			<xsl:text> blijkt uit </xsl:text>
			<xsl:if test="tia:IMKAD_AangebodenStuk/tia:tia_AantalOnderhandseAktenVolmacht != ''">
				<xsl:value-of select="kef:convertNumberToText(tia:IMKAD_AangebodenStuk/tia:tia_AantalOnderhandseAktenVolmacht)"/>
			</xsl:if>
			<xsl:text> onderhandse akte</xsl:text>
			<xsl:if test="tia:IMKAD_AangebodenStuk/tia:tia_AantalOnderhandseAktenVolmacht > 1">
				<xsl:text>n</xsl:text>
			</xsl:if>
			<xsl:text> van volmacht die aan deze akte </xsl:text>
			<xsl:choose>
				<xsl:when test="tia:IMKAD_AangebodenStuk/tia:tia_AantalOnderhandseAktenVolmacht > 1">
					<xsl:text>worden</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>wordt</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text> gehecht.</xsl:text>
			<!-- Optioneel: TEKSTBLOK_Sub_B_vermeldeVolmacht -->
			<xsl:if test="tia:IMKAD_AangebodenStuk//tia:Partij[substring((translate(tia:aanduidingPartij, $upper, $lower)),1,13) = 'rechthebbende']">
				<br/>
				<xsl:text>Van de sub B. vermelde </xsl:text>
				<xsl:value-of select="normalize-space(tia:IMKAD_AangebodenStuk//tia:Partij[substring((translate(tia:aanduidingPartij, $upper, $lower)),1,13) = 'rechthebbende']/tia:tekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_volmacht']/tia:tekst)"/>
				<xsl:text> blijkt zoals hierna vermeld.</xsl:text>
			</xsl:if>
		</p>
	</xsl:template>


	<!--
	*********************************************************
	Mode: do-keuzeblok-soort-doorhaling
	*********************************************************
	Public: no

	Identity transform: no

	Description: KEUZEBLOK Soort Doorhaling.

	Input: tia:IMKAD_AangebodenStuk

	Params: none.

	Output: XHTML structure

	Calls:
	(mode) do-stukdeel-doorhaling

	Called by:
	(mode) do-deed
	-->
	<xsl:template match="tia:IMKAD_AangebodenStuk" mode="do-keuzeblok-soort-doorhaling">
		<xsl:variable name="aantalAfstandHypotheekrecht" select="count(tia:StukdeelDoorhalingHypotheek[translate(tia:soortDoorhaling, $upper, $lower) = $afstandHypotheekrecht])"/>
		<xsl:variable name="aantalOpzeggingHypotheekrecht" select="count(tia:StukdeelDoorhalingHypotheek[translate(tia:soortDoorhaling, $upper, $lower) = $opzeggingHypotheekrecht])"/>
		<xsl:variable name="aantalStukdelen" select="count(tia:StukdeelDoorhalingHypotheek)"/>

		<!-- groepeer de Stukdelen DoorhalingHypotheek per variant -->
		<!-- (Afstand hypotheekrecht) -->
		<xsl:if test="tia:StukdeelDoorhalingHypotheek[translate(tia:soortDoorhaling, $upper, $lower) = $afstandHypotheekrecht]">
			<!-- print de afstandHypotheekrecht header -->
			<h3>
				<u>
					<xsl:text>Afstand hypotheekrecht</xsl:text>
				</u>
			</h3>
			<!-- tabel van de Stukdelen DoorhalingHypotheek in variant 1 (Afstand hypotheekrecht)-->
			<table cellspacing="0" cellpadding="0">
				<tbody>
					<!-- voor ieder Studdeel een regel in de tabel-->
					<xsl:for-each select="tia:StukdeelDoorhalingHypotheek[translate(tia:soortDoorhaling, $upper, $lower) = $afstandHypotheekrecht]">
						<!-- Stukdeel nummer in kolom(1) -->
						<xsl:variable name="stukDeelNumber" select="count(preceding-sibling::tia:StukdeelDoorhalingHypotheek[translate(tia:soortDoorhaling, $upper, $lower) = $afstandHypotheekrecht]) + 1"/>
						<!-- Stukdeel Doorhaling Hypotheek in kolom(2)-->
						<xsl:apply-templates select="." mode="do-stukdeel-doorhaling-variant-1">
							<xsl:with-param name="aantalStukdelen" select="$aantalStukdelen"/>
							<xsl:with-param name="stukDeelNumber" select="$stukDeelNumber"/>
						</xsl:apply-templates>
					</xsl:for-each>
				</tbody>
			</table>
		</xsl:if>
		<!-- (Opzegging hypotheekrecht) -->
		<xsl:if test="tia:StukdeelDoorhalingHypotheek[translate(tia:soortDoorhaling, $upper, $lower) = $opzeggingHypotheekrecht]">
			<!-- print de opzeggingHypotheekrecht header -->
			<h3>
				<u>
					<xsl:text>Opzegging hypotheekrecht</xsl:text>
				</u>
			</h3>
			<!-- tabel van de Stukdelen DoorhalingHypotheek in variant 2 (Opzegging hypotheekrecht) -->
			<table cellspacing="0" cellpadding="0">
				<tbody>
					<!-- voor ieder Studdeel een regel in de tabel-->
					<xsl:for-each select="tia:StukdeelDoorhalingHypotheek[translate(tia:soortDoorhaling, $upper, $lower) = $opzeggingHypotheekrecht]">
						<!-- Stukdeel nummer in kolom(1) -->
						<xsl:variable name="stukDeelNumber" select="$aantalAfstandHypotheekrecht + count(preceding-sibling::tia:StukdeelDoorhalingHypotheek[translate(tia:soortDoorhaling, $upper, $lower) = $opzeggingHypotheekrecht]) + 1"/>
						<!-- Stukdeel Doorhaling Hypotheek in kolom(2)-->
						<xsl:apply-templates select="." mode="do-stukdeel-doorhaling-variant-2">
							<xsl:with-param name="aantalStukdelen" select="$aantalStukdelen"/>
							<xsl:with-param name="stukDeelNumber" select="$stukDeelNumber"/>
						</xsl:apply-templates>
					</xsl:for-each>
				</tbody>
			</table>
		</xsl:if>
		<!-- (Vervallenverklaring) -->
		<xsl:if test="tia:StukdeelDoorhalingHypotheek[translate(tia:soortDoorhaling, $upper, $lower) = $vervallenverklaring]">
			<!-- print de vervallenverklaring header -->
			<h3>
				<u>
					<xsl:text>Vervallenverklaring</xsl:text>
				</u>
			</h3>
			<!-- tabel van de Stukdelen DoorhalingHypotheek in variant 3 (Vervallenverklaring) -->
			<table cellspacing="0" cellpadding="0">
				<tbody>
					<!-- voor ieder Studdeel een regel in de tabel-->
					<xsl:for-each select="tia:StukdeelDoorhalingHypotheek[translate(tia:soortDoorhaling, $upper, $lower) = $vervallenverklaring]">
						<!-- Stukdeel nummer in kolom(1) -->
						<xsl:variable name="stukDeelNumber" select="$aantalAfstandHypotheekrecht + $aantalOpzeggingHypotheekrecht +
																		count(preceding-sibling::tia:StukdeelDoorhalingHypotheek[translate(tia:soortDoorhaling, $upper, $lower) = $vervallenverklaring]) + 1"/>
						<!-- Stukdeel Doorhaling Hypotheek in kolom(2)-->
						<xsl:apply-templates select="." mode="do-stukdeel-doorhaling-variant-3">
							<xsl:with-param name="aantalStukdelen" select="$aantalStukdelen"/>
							<xsl:with-param name="stukDeelNumber" select="$stukDeelNumber"/>
						</xsl:apply-templates>
					</xsl:for-each>
				</tbody>
			</table>
		</xsl:if>
	</xsl:template>

	<!--
	*********************************************************
	template: do-overige-verklaringen
	*********************************************************
	Public: yes

	Description: TEKSTBLOK_Overige_verklaringen

	Input: -

	called by do-deed
	-->
	<xsl:template name="do-overige-verklaringen">
		<!-- Tekstblok Overige verklaringen -->
		<p>
			<xsl:text>De verschenen </xsl:text>
			<xsl:choose>
				<xsl:when test="$numberOfRepresentatives > 1">
					<xsl:text>personen verklaren</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>persoon verklaart</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text> vervolgens namens partij</xsl:text>
			<xsl:if test="$numberOfParties > 1">
				<xsl:text>en</xsl:text>
			</xsl:if>
			<xsl:text>:</xsl:text>
		</p>
		<h3>
			<u>
				<xsl:text>Geen beperkt recht hypothecaire vorderingen</xsl:text>
			</u>
		</h3>
		<p>
			<xsl:text>De </xsl:text>
			<xsl:choose>
				<xsl:when test="$numberOfCancellations > 1">
					<xsl:text>vorderingen </xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>vordering </xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text>waarvoor </xsl:text>
			<xsl:choose>
				<xsl:when test="$numberOfCancellations > 1">
					<xsl:text>de hypotheekrechten </xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>het hypotheekrecht </xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text>tot zekerheid </xsl:text>
			<xsl:choose>
				<xsl:when test="$numberOfCancellations > 1">
					<xsl:text>strekken, zijn </xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>strekt, is </xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text>niet met een beperkt recht bezwaard.</xsl:text>
		</p>
		<h3>
			<u>
				<xsl:text>Vervallen hypotheken</xsl:text>
			</u>
		</h3>
		<p>
			<xsl:text>Ingevolge het vorenstaande zijn gemelde hypotheekrechten vervallen.</xsl:text>
		</p>
	</xsl:template>

	<!--
	*********************************************************
	Mode: do-stukdeel-doorhaling-variant-1
	*********************************************************
	Public: no

	Identity transform: no

	Description: Afstand hypotheekrecht

	Input: tia:StukdeelDoorhalingHypotheek

	Params: aantalStukdelen, stukDeelNumber

	Output: XHTML structure

	Calls:
	(mode) do-vervreemderRechtRef-party
	(mode) do-part-and-number
	(mode) do-verkrijgerRechtRef-party
	(mode) do-recht-en-registergoed
	(mode) aanvaardingVolmacht
	
	Called by:
	(mode) do-keuzeblok-soort-doorhaling
	-->
	<xsl:template match="tia:StukdeelDoorhalingHypotheek" mode="do-stukdeel-doorhaling-variant-1">
		<!-- het stukdeel-volgnummer wordt doorgegeven, voor de nummering in de tabel -->
		<xsl:param name="aantalStukdelen"/>
		<xsl:param name="stukDeelNumber"/>
		<!-- bepaal het aantal SubPartijen, die in dit StukDeel opgenoemd moeten worden-->
		<xsl:variable name="numVervreemderRechtRef" select="count(tia:vervreemderRechtRef)"/>		
		<xsl:variable name="numVerkrijgerRechtRef" select="count(tia:verkrijgerRechtRef)"/>
		<!-- opmaak variabelen -->
		<xsl:variable name="Datum_DATE" select="substring(string(tia:doorTeHalenStuk/tia:datumInschrijving), 0, 11)"/>
		<xsl:variable name="Datum_Doorhaling">
			<xsl:if test="$Datum_DATE != ''">
				<xsl:value-of select="kef:convertDateToText($Datum_DATE)"/>
			</xsl:if>
		</xsl:variable>
		<!-- eerste regel v/h stukdeel: -->
		<tr>
			<xsl:if test="($aantalStukdelen) &gt; 1">
				<td class="roman" valign="top">
					<xsl:number value="$stukDeelNumber" format="I."/>
				</td>
			</xsl:if>
			<td>
				<xsl:text>De </xsl:text>
				<!-- KEUZETEKST k_Hypotheekhouder -->
				<xsl:value-of select="normalize-space(tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hypotheekhouder']/tia:tekst)"/>
				<xsl:text> en de </xsl:text>
				<!-- KEUZETEKST k_Rechthebbende -->
				<xsl:value-of select="normalize-space(tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_rechthebbende']/tia:tekst)"/>
				<xsl:text> zijn overeengekomen dat afstand wordt gedaan van na te melden hypotheekrecht.</xsl:text>
			</td>
		</tr>
		<!-- 2e regel v/h stukdeel: -->
		<tr>
			<xsl:if test="($aantalStukdelen) &gt; 1">
				<!-- een lege kolom i.v.m. uitlijning -->
				<td class="number" valign="top">
					<xsl:text>&#xFEFF;</xsl:text>
				</td>
			</xsl:if>
			<td>
				<xsl:text>De genoemde </xsl:text>
				<!-- OPTIONEEL: voor iedere vervreemderRechtRef -->
				<xsl:for-each select="tia:vervreemderRechtRef">
					<!-- volmachtgeverId = //IMKAD_AangebodenStuk/Partij[aanduidingPartij=volmachtgevers]/Partij[+id] -->
					<xsl:variable name="volmachtgeverId" select="substring-after(@xlink:href, '#')"/>
					<!-- posSub = positie(volgorde) van de vervreemderRechtRef in het huidige StukdeelDoorhalingHypotheek -->
					<xsl:variable name="posSub" select="position()"/>
					<!-- selecteer de gerefereerde volmachtgever(s) en bepaal het volgnummer daarvan in de comparitie -->
					<xsl:apply-templates select="/tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:Partij[
							(substring((translate(tia:aanduidingPartij, $upper, $lower)),1,13) = 'volmachtgever') or
							(substring((translate(tia:aanduidingPartij, $upper, $lower)),1,15) = 'hypotheekhouder')
							]/tia:Partij[@id=$volmachtgeverId]"
							 mode="do-vervreemderRechtRef-party">
						<xsl:with-param name="aantalRefPartijen" select="$numVervreemderRechtRef"/>
						<xsl:with-param name="posSub" select="$posSub"/>
						<xsl:with-param name="stukdeelNumber" select="$stukDeelNumber"/> 
					</xsl:apply-templates>				
				</xsl:for-each>
				<xsl:text> </xsl:text>
				<xsl:value-of select="normalize-space(tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_doetdoen']/tia:tekst)"/>
				<xsl:text> ter uitvoering van deze overeenkomst hierbij afstand van:</xsl:text>
			</td>
		</tr>
		<!-- 3e regel v/h stukdeel: -->
		<tr>
			<xsl:if test="($aantalStukdelen) &gt; 1">
				<!-- een lege kolom i.v.m. uitlijning -->
				<td class="number" valign="top">
					<xsl:text>&#xFEFF;</xsl:text>
				</td>
			</xsl:if>	
			<td>
				<xsl:text>het hypotheekrecht dat op </xsl:text>
				<xsl:value-of select="$Datum_Doorhaling"/>
				<xsl:text> is ingeschreven in de openbare registers van het Kadaster in </xsl:text>
				<!-- TEKSTBLOK DEEL EN NUMMER -->
				<xsl:apply-templates select="tia:doorTeHalenStuk/tia:deelEnNummer" mode="do-part-and-number"/>
				<xsl:text>, ten behoeve van de (thans) genoemde </xsl:text>
				<xsl:value-of select="normalize-space(tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_volmachtgever']/tia:tekst)"/>
				<xsl:text>. Het hypotheekrecht komt ten laste van de hiervoor genoemde </xsl:text>
				<!-- OPTIONEEL: voor iedere verkrijgerRechtRef -->
				<xsl:for-each select="tia:verkrijgerRechtRef">
					<!-- rechthebbendeId = //IMKAD_AangebodenStuk/Partij[aanduidingPartij=rechthebbende(n)]/Partij[+id] -->
					<xsl:variable name="rechthebbendeId" select="substring-after(@xlink:href, '#')"/>
					<!-- posSub = positie(volgorde) van de vervreemderRechtRef in het huidige StukdeelDoorhalingHypotheek -->
					<xsl:variable name="posSub" select="position()"/>
					<!-- selecteer de gerefereerde rechthebbende(n) en bepaal het volgnummer daarvan in de comparitie -->
					<xsl:apply-templates select="/tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:Partij[substring((translate(tia:aanduidingPartij, $upper, $lower)),1,13) = 'rechthebbende']/tia:Partij[@id=$rechthebbendeId]"
						 mode="do-verkrijgerRechtRef-party">
						<xsl:with-param name="aantalRefPartijen" select="$numVerkrijgerRechtRef"/>
						<xsl:with-param name="posSub" select="$posSub"/>
					</xsl:apply-templates>
				</xsl:for-each>
				<xsl:text> op de met bovenbedoeld hypotheekrecht bezwaarde registergoederen</xsl:text>
				<!-- OPTIONEEL: afleidbare tekst en herhalende combinatie van tekstblok RECHT en tekstblok REGISTERGOED -->
				<xsl:choose>
					<xsl:when test="tia:IMKAD_ZakelijkRecht">
						<xsl:call-template name="do-recht-en-registergoed"/>
					</xsl:when>
					<!-- afsluiten met een punt -->
					<xsl:otherwise>
						<xsl:text>.</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</td>
		</tr>
		<!-- 4e regel v/h stukdeel: -->
		<tr>
			<xsl:if test="($aantalStukdelen) &gt; 1">
				<!-- een lege kolom i.v.m. uitlijning -->
				<td class="number" valign="top">
					<xsl:text>&#xFEFF;</xsl:text>
				</td>
			</xsl:if>
			<td>
				<!-- Aanvaarding/Volmacht -->
				<xsl:call-template name="aanvaardingVolmacht"/>
			</td>
		</tr>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-stukdeel-doorhaling-variant-2
	*********************************************************
	Public: no

	Identity transform: no

	Description: Opzegging hypotheekrecht.

	Input: tia:StukdeelDoorhalingHypotheek

	Params: aantalStukdelen, stukDeelNumber

	Output: XHTML structure

	Calls:
	(mode) do-vervreemderRechtRef-party
	(mode) do-part-and-number
	(mode) do-recht-en-registergoed

	Called by:
	(mode) do-keuzeblok-soort-doorhaling
	-->
	<xsl:template match="tia:StukdeelDoorhalingHypotheek" mode="do-stukdeel-doorhaling-variant-2">
		<xsl:param name="aantalStukdelen"/>
		<xsl:param name="stukDeelNumber"/>
		<!-- bepaal het aantal SubPartijen, die in dit StukDeel opgenoemd moeten worden-->
		<xsl:variable name="numVervreemderRechtRef" select="count(tia:vervreemderRechtRef)"/>
		<!-- opmaak variabelen -->
		<xsl:variable name="Datum_DATE" select="substring(string(tia:doorTeHalenStuk/tia:datumInschrijving), 0, 11)"/>
		<xsl:variable name="Datum_Doorhaling">
			<xsl:if test="$Datum_DATE != ''">
				<xsl:value-of select="kef:convertDateToText($Datum_DATE)"/>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="aantalDebiteur">
			<xsl:value-of select="count(tia:debiteurAkteHypotheekrecht)"/>
		</xsl:variable>
		<!-- hier de regels in de tabel v/d stukdelen in de doorhaling opbouwen: -->
		<tr>
			<xsl:if test="($aantalStukdelen) &gt; 1">
				<td class="roman" valign="top">
					<xsl:number value="$stukDeelNumber" format="I."/>
				</td>
			</xsl:if>
			<td>
				<xsl:text>De </xsl:text>
				<xsl:for-each select="tia:vervreemderRechtRef">
					<!-- volmachtgeverId = //IMKAD_AangebodenStuk/Partij[aanduidingPartij=volmachtgevers]/Partij[+id] -->
					<xsl:variable name="volmachtgeverId" select="substring-after(@xlink:href, '#')"/>
					<!-- posSub = positie(volgorde) van de vervreemderRechtRef in het huidige StukdeelDoorhalingHypotheek -->
					<xsl:variable name="posSub" select="position()"/>
					<!-- selecteer de gerefereerde volmachtgever(s) en bepaal het volgnummer daarvan in de comparitie -->
					<xsl:apply-templates select="/tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:Partij[
							(substring((translate(tia:aanduidingPartij, $upper, $lower)),1,13) = 'volmachtgever') or
							(substring((translate(tia:aanduidingPartij, $upper, $lower)),1,15) = 'hypotheekhouder')
							]/tia:Partij[@id=$volmachtgeverId]"
							 mode="do-vervreemderRechtRef-party">
						 <xsl:with-param name="aantalRefPartijen" select="$numVervreemderRechtRef"/>
						 <xsl:with-param name="posSub" select="$posSub"/>
						<xsl:with-param name="stukdeelNumber" select="$stukDeelNumber"/> 
					</xsl:apply-templates>
				</xsl:for-each>
				<xsl:text> </xsl:text>
				<xsl:value-of select="normalize-space(tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_zegtzeggen']/tia:tekst)"/>
				<xsl:text> hierbij op:</xsl:text>
			</td>
		</tr>
		<!-- tweede regel: -->
		<tr>
			<xsl:if test="($aantalStukdelen) &gt; 1">
				<td class="number" valign="top">
					<xsl:text>&#xFEFF;</xsl:text>
				</td>
			</xsl:if>
			<td>
				<xsl:text> het hypotheekrecht dat op </xsl:text>
				<xsl:value-of select="$Datum_Doorhaling"/>
				<xsl:text> is ingeschreven in de openbare registers van het Kadaster in </xsl:text>
				<!-- TEKSTBLOK DEEL EN NUMMER -->
				<xsl:apply-templates select="tia:doorTeHalenStuk/tia:deelEnNummer" mode="do-part-and-number"/>
				<xsl:text>, ten behoeve van de (thans) genoemde </xsl:text>
				<xsl:value-of select="normalize-space(tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_volmachtgever']/tia:tekst)"/>
				<!-- OPTIONEEL: debiteur -->
				<xsl:if test="$aantalDebiteur > 0">
					<xsl:text> en ten laste van de in de akte, waarbij het hypotheekrecht werd gevestigd, genoemde </xsl:text>
					<xsl:value-of select="normalize-space(tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hypotheekgever']/tia:tekst)"/>
					<xsl:text> en/of </xsl:text>
					<xsl:value-of select="normalize-space(tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_debiteur']/tia:tekst)"/>
					<xsl:text> te weten </xsl:text>
					<xsl:for-each select="tia:debiteurAkteHypotheekrecht">
						<xsl:choose>
							<xsl:when test="position() = 1">
								<xsl:value-of select="."/>
							</xsl:when>
							<xsl:when test="position() &lt; $aantalDebiteur">
								<xsl:text>, </xsl:text>
								<xsl:value-of select="."/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:text> en </xsl:text>
								<xsl:value-of select="."/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
				</xsl:if>
				<!-- OPTIONEEL: afleidbare tekst en herhalende combinatie van tekstblok RECHT en tekstblok REGISTERGOED -->
				<xsl:choose>
					<xsl:when test="tia:IMKAD_ZakelijkRecht">
						<xsl:call-template name="do-recht-en-registergoed"/>
					</xsl:when>
					<!-- afsluiten met een punt -->
					<xsl:otherwise>
						<xsl:text>.</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</td>
		</tr>
		<!-- derde regel: -->
		<tr>
			<xsl:if test="($aantalStukdelen) &gt; 1">
				<td class="number" valign="top">
					<xsl:text>&#xFEFF;</xsl:text>
				</td>
			</xsl:if>	
			<td>
				<xsl:text>Deze opzeggingsbevoegdheid is verleend in de akte waarbij laatstgemeld hypotheekrecht werd gevestigd.</xsl:text>
			</td>
		</tr>
	</xsl:template>

	<!--
	*********************************************************
	Mode: do-stukdeel-doorhaling-variant-3
	*********************************************************
	Public: no

	Identity transform: no

	Description: Vervallenverklaring.

	Input: tia:StukdeelDoorhalingHypotheek

	Params: aantalStukdelen, stukDeelNumber

	Output: XHTML structure

	Calls:
	(mode) do-vervreemderRechtRef-party
	(mode) do-part-and-number

	Called by:
	(mode) do-keuzeblok-soort-doorhaling
	-->
	<xsl:template match="tia:StukdeelDoorhalingHypotheek" mode="do-stukdeel-doorhaling-variant-3">
		<xsl:param name="aantalStukdelen"/>
		<xsl:param name="stukDeelNumber"/>
		<!-- bepaal het aantal SubPartijen, die in dit StukDeel opgenoemd moeten worden-->
		<xsl:variable name="numVervreemderRechtRef" select="count(tia:vervreemderRechtRef)"/>		
		<!-- opmaak variabelen -->
		<xsl:variable name="Datum_DATE" select="substring(string(tia:doorTeHalenStuk/tia:datumInschrijving), 0, 11)"/>
		<xsl:variable name="Datum_Doorhaling">
			<xsl:if test="$Datum_DATE != ''">
				<xsl:value-of select="kef:convertDateToText($Datum_DATE)"/>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="aantalDebiteur">
			<xsl:value-of select="count(tia:debiteurAkteHypotheekrecht)"/>
		</xsl:variable>
		<!-- hier de regel in de tabel v/d stukdelen in de doorhaling opbouwen: -->
		<tr>
			<xsl:if test="($aantalStukdelen) &gt; 1">
				<td class="roman" valign="top">
					<xsl:number value="$stukDeelNumber" format="I."/>
				</td>
			</xsl:if>
			<td>
				<xsl:text>De </xsl:text>
				<xsl:for-each select="tia:vervreemderRechtRef">
					<!-- volmachtgeverId = //IMKAD_AangebodenStuk/Partij[aanduidingPartij=volmachtgevers]/Partij[+id] -->
					<xsl:variable name="volmachtgeverId" select="substring-after(@xlink:href, '#')"/>
					<!-- posSub = positie(volgorde) van de vervreemderRechtRef in het huidige StukdeelDoorhalingHypotheek -->
					<xsl:variable name="posSub" select="position()"/>
					<!-- selecteer de gerefereerde volmachtgever(s) en bepaal het volgnummer daarvan in de comparitie -->
					<xsl:apply-templates select="/tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:Partij[
							(substring((translate(tia:aanduidingPartij, $upper, $lower)),1,13) = 'volmachtgever') or
							(substring((translate(tia:aanduidingPartij, $upper, $lower)),1,15) = 'hypotheekhouder')
							]/tia:Partij[@id=$volmachtgeverId]"
							 mode="do-vervreemderRechtRef-party">
						 <xsl:with-param name="aantalRefPartijen" select="$numVervreemderRechtRef"/>
						 <xsl:with-param name="posSub" select="$posSub"/>
						<xsl:with-param name="stukdeelNumber" select="$stukDeelNumber"/> 
					</xsl:apply-templates>
				</xsl:for-each>
				<xsl:text> </xsl:text>
				<xsl:value-of select="normalize-space(tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_verklaartverklaren']/tia:tekst)"/>
				<xsl:text> dat het hypotheekrecht dat op </xsl:text>
				<xsl:value-of select="$Datum_Doorhaling"/>
				<xsl:text> is ingeschreven in de openbare registers van het Kadaster in </xsl:text>
				<!-- TEKSTBLOK DEEL EN NUMMER -->
				<xsl:apply-templates select="tia:doorTeHalenStuk/tia:deelEnNummer" mode="do-part-and-number"/>
				<xsl:text>, ten behoeve van de (thans) genoemde </xsl:text>
				<xsl:value-of select="normalize-space(tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_volmachtgever']/tia:tekst)"/>
				<xsl:if test="$aantalDebiteur > 0">
					<xsl:text> en ten laste van de in de akte, waarbij het hypotheekrecht werd gevestigd, genoemde </xsl:text>
					<xsl:value-of select="normalize-space(tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_hypotheekgever']/tia:tekst)"/>
					<xsl:text> en/of </xsl:text>
					<xsl:value-of select="normalize-space(tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_debiteur']/tia:tekst)"/>
					<xsl:text> te weten </xsl:text>
					<xsl:for-each select="tia:debiteurAkteHypotheekrecht">
						<xsl:choose>
							<xsl:when test="position() = 1">
								<xsl:value-of select="."/>
							</xsl:when>
							<xsl:when test="position() &lt; $aantalDebiteur">
								<xsl:text>, </xsl:text>
								<xsl:value-of select="."/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:text> en </xsl:text>
								<xsl:value-of select="."/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
				</xsl:if>
				<xsl:text> is vervallen omdat de vordering tot zekerheid waarvoor zij werd verstrekt is voldaan en/of door beëindiging van de rechtsverhouding tot zekerheid waarvan het hypotheekrecht werd gevestigd.</xsl:text>
			</td>
		</tr>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-vervreemderRechtRef-party
	*********************************************************
	Public: no

	Identity transform: no

	Description: bepaal het volgnummer v/d gerefereerde volmachtgevers in de comparitie.

	Input: tia:Partij

	Params: nvt

	Output: XHTML structure

	Calls:
	(mode) ...

	Called by:
	(mode) do-stukdeel-doorhaling-variant-1
	(mode) do-stukdeel-doorhaling-variant-2
	(mode) do-stukdeel-doorhaling-variant-3
	-->
	<xsl:template match="tia:Partij" mode="do-vervreemderRechtRef-party">
		<!-- het aantal subPartijen in StukdeelDoorhalingHypotheek wordt meegegeven -->
		<xsl:param name="aantalRefPartijen"/>
		<!-- de positie(volgorde) van de subPartij in StukdeelDoorhalingHypotheek wordt meegegeven -->
		<xsl:param name="posSub"/>
		<!-- Het stukdeelnummer -->
		<xsl:param name="stukdeelNumber"/>
		<!-- het totaal aantal subpartijen -->
		<xsl:variable name="aantalSubpartijen" select="count(parent::tia:Partij/tia:Partij)"/>
		<!-- bepaal het volgnummer van deze Partij in //IMKAD_AangebodenStuk/Partij[aanduidingPartij=volmachtgevers] -->
		<xsl:variable name="partijNummer" select="count(preceding-sibling::tia:Partij) + 1"/>
		<!-- bepaal het aantal gerelateerde personen in deze partij -->
		<xsl:variable name="gerelateerdePersonen" select="count(tia:IMKAD_Persoon/tia:GerelateerdPersoon)"/>
		<!-- bepaal het aantal voorkomens van VoormaligRechtspersoon in deze Partij -->
		<xsl:variable name="aantalVoormalig" select="count(tia:IMKAD_Persoon//tia:VoormaligeRechtspersoon[@id])"/>

		<!-- bepaal de opsomming (nummering) v/d volmachtgevers -->
		<xsl:choose>
			<!-- variant 1: slechts 1 gerefereerde volmachtgever, die NIET genummerd is in de comparitie -->
			<xsl:when test="($aantalSubpartijen = 1) and ($gerelateerdePersonen = 0)">
				<!-- vaste tekst -->
				<xsl:text> volmachtgever</xsl:text>
				<!-- OPTIONEEL: VoormaligeRechtspersoon -->
				<xsl:for-each select="tia:IMKAD_Persoon/tia:VoormaligeRechtspersoon[@id]">
					<!-- voormaligeRechtspersoonId = //tia:IMKAD_AangebodenStuk/tia:StukdeelDoorhalingHypotheek/tia:voormaligeRechtspersoonRef[substring-after(@xlink:href, '#')] -->
					<xsl:variable name="voormaligeRechtspersoonId" select="@id"/>
					<xsl:if test="/tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:StukdeelDoorhalingHypotheek[$stukdeelNumber]/tia:voormaligeRechtspersoonRef[
						(substring-after(@xlink:href, '#')=$voormaligeRechtspersoonId)
						]">
						<xsl:apply-templates select="." mode="do-VoormaligeRechtspersoon"/>
						<xsl:text>, </xsl:text>
					</xsl:if>
				</xsl:for-each>
			</xsl:when>
			
			<!-- variant 2a: twee gerefereerde volmachtgevers, die NIET samen genummerd zijn in de comparitie -->
			<xsl:when test="($aantalSubpartijen = 1) and ($gerelateerdePersonen = 1)">
				<!-- vaste tekst -->
				<xsl:text> volmachtgever sub 1</xsl:text>
				<!-- OPTIONEEL: VoormaligeRechtspersoon -->
				<xsl:for-each select="tia:IMKAD_Persoon/tia:VoormaligeRechtspersoon[@id]">
					<!-- voormaligeRechtspersoonId = //tia:IMKAD_AangebodenStuk/tia:StukdeelDoorhalingHypotheek/tia:voormaligeRechtspersoonRef[substring-after(@xlink:href, '#')] -->
					<xsl:variable name="voormaligeRechtspersoonId" select="@id"/>
					<xsl:if test="/tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:StukdeelDoorhalingHypotheek[$stukdeelNumber]/tia:voormaligeRechtspersoonRef[
						(substring-after(@xlink:href, '#')=$voormaligeRechtspersoonId)
						]">
						<xsl:apply-templates select="." mode="do-VoormaligeRechtspersoon"/>
						<xsl:text>, </xsl:text>
					</xsl:if>
				</xsl:for-each>
				<xsl:text> en volmachtgevers sub 2 </xsl:text>
				<!-- OPTIONEEL: VoormaligeRechtspersoon -->
				<xsl:for-each select="tia:IMKAD_Persoon/tia:VoormaligeRechtspersoon[@id]">
					<!-- voormaligeRechtspersoonId = //tia:IMKAD_AangebodenStuk/tia:StukdeelDoorhalingHypotheek/tia:voormaligeRechtspersoonRef[substring-after(@xlink:href, '#')] -->
					<xsl:variable name="voormaligeRechtspersoonId" select="@id"/>
					<xsl:if test="/tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:StukdeelDoorhalingHypotheek[$stukdeelNumber]/tia:voormaligeRechtspersoonRef[
						(substring-after(@xlink:href, '#')=$voormaligeRechtspersoonId)
						]">
						<xsl:apply-templates select="." mode="do-VoormaligeRechtspersoon"/>
						<xsl:text>, </xsl:text>
					</xsl:if>
				</xsl:for-each>
			</xsl:when>

			<!-- variant 2b: meerdere gerefereerde en gerelateerde volmachtgevers, die NIET samen genummerd zijn in de comparitie -->
			<xsl:when test="(($aantalSubpartijen = 1) and ($gerelateerdePersonen > 1))">
				<!-- vaste tekst -->
				<xsl:text> volmachtgever sub 1</xsl:text>
				<!-- OPTIONEEL: VoormaligeRechtspersoon -->
				<xsl:for-each select="tia:IMKAD_Persoon/tia:VoormaligeRechtspersoon[@id]">
					<!-- voormaligeRechtspersoonId = //tia:IMKAD_AangebodenStuk/tia:StukdeelDoorhalingHypotheek/tia:voormaligeRechtspersoonRef[substring-after(@xlink:href, '#')] -->
					<xsl:variable name="voormaligeRechtspersoonId" select="@id"/>
					<!-- bepaal of tia:voormaligeRechtspersoonRef afgedrukt moet worden;
						voormaligeRechtspersoonId = //tia:IMKAD_AangebodenStuk/tia:StukdeelDoorhalingHypotheek/tia:voormaligeRechtspersoonRef[substring-after(@xlink:href, '#')]
					-->
					<xsl:if test="/tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:StukdeelDoorhalingHypotheek[$stukdeelNumber]/tia:voormaligeRechtspersoonRef[
						(substring-after(@xlink:href, '#')=$voormaligeRechtspersoonId)
						]">
						<xsl:apply-templates select="." mode="do-VoormaligeRechtspersoon"/>
					</xsl:if>
				</xsl:for-each>
				<xsl:text>, </xsl:text>
				<!-- dan opsommen van ALLE gerelateerde volmachtgevers (partijen) -->
				<xsl:for-each select="tia:IMKAD_Persoon/tia:GerelateerdPersoon">
					<!-- vaste tekst -->
					<xsl:text> volmachtgever sub </xsl:text>
					<!-- partijNummer v/d volmachtgever opnoemen -->
					<xsl:number value="($partijNummer)+(position())" format="1"/>
					<!-- OPTIONEEL: VoormaligeRechtspersoon -->
					<xsl:for-each select="tia:IMKAD_Persoon/tia:VoormaligeRechtspersoon[@id]">
						<!-- voormaligeRechtspersoonId = //tia:IMKAD_AangebodenStuk/tia:StukdeelDoorhalingHypotheek/tia:voormaligeRechtspersoonRef[substring-after(@xlink:href, '#')] -->
						<xsl:variable name="voormaligeRechtspersoonId" select="@id"/>
						<xsl:if test="/tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:StukdeelDoorhalingHypotheek[$stukdeelNumber]/tia:voormaligeRechtspersoonRef[
							(substring-after(@xlink:href, '#')=$voormaligeRechtspersoonId)
							]">
							<xsl:apply-templates select="." mode="do-VoormaligeRechtspersoon"/>
							<!-- alleen een afsluitende komma, bij de laatste 2 volmachtgevers -->
							<xsl:if test="position() &gt; ($gerelateerdePersonen - 2)">
								<xsl:text>, </xsl:text>
							</xsl:if>
						</xsl:if>
					</xsl:for-each>
					<!-- bepaal of dit wel of niet de laatste gerelateerde volmachtgever is -->
					<xsl:choose>
						<xsl:when test="position() &lt; ($gerelateerdePersonen - 1)">
							<xsl:text>,</xsl:text>
						</xsl:when>
						<xsl:when test="position() = ($gerelateerdePersonen - 1)">
							<xsl:text> en</xsl:text>
						</xsl:when>
					</xsl:choose>
				</xsl:for-each>
			</xsl:when>

			<!-- variant 2c: meerdere gerefereerde en NIET gerelateerde volmachtgevers, die NIET samen genummerd zijn in de comparitie -->
			<xsl:when test="($aantalSubpartijen > 1) and ($gerelateerdePersonen = 0)">
				<!-- 
					hier vooraf bepalen of dit de laats opgenoemde gerefereerde volmachtgever is,
					om de complexiteit van de scheidings-komma logica te beperken.
				-->
				<xsl:choose>
					<!-- als dit de eerste partij is, dan voorafgaan door niets -->
					<xsl:when test="$posSub = 1">
						<xsl:text></xsl:text>
					</xsl:when>
					<!-- als dit de laatse partij is, dan voorafgaan door 'en' -->
					<xsl:when test="$posSub = ($aantalRefPartijen)">
						<xsl:text> en</xsl:text>
					</xsl:when>
					<!-- in alle andere gevallen, dan voorafgaan door een ',' -->
					<xsl:otherwise>
						<xsl:text>,</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
				<!-- vaste tekst -->
				<xsl:text> volmachtgever sub </xsl:text>
				<!-- partijNummer v/d volmachtgever opnoemen -->
				<xsl:number value="$partijNummer" format="1"/>
				<!-- OPTIONEEL: VoormaligeRechtspersoon -->
				<xsl:for-each select="tia:IMKAD_Persoon/tia:VoormaligeRechtspersoon[@id]">
					<!-- voormaligeRechtspersoonId = //tia:IMKAD_AangebodenStuk/tia:StukdeelDoorhalingHypotheek/tia:voormaligeRechtspersoonRef[substring-after(@xlink:href, '#')] -->
					<xsl:variable name="voormaligeRechtspersoonId" select="@id"/>
					<xsl:if test="/tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:StukdeelDoorhalingHypotheek[$stukdeelNumber]/tia:voormaligeRechtspersoonRef[
						(substring-after(@xlink:href, '#')=$voormaligeRechtspersoonId)
						]">
						<xsl:apply-templates select="." mode="do-VoormaligeRechtspersoon"/>
						<!--xsl:text>, </xsl:text-->
					</xsl:if>
				</xsl:for-each>
				<!-- bepaal of dit wel of niet de laatste opgenoemde volmachtgever is 
				<xsl:choose>
					<xsl:when test="$posSub &lt; ($aantalRefPartijen - 1)">
						<xsl:text>,</xsl:text>
					</xsl:when>
					<xsl:when test="$posSub = ($aantalRefPartijen - 1)">
						<xsl:text> en</xsl:text>
					</xsl:when>
				</xsl:choose> -->
			</xsl:when>

			<!-- variant 3a: meerdere gerefereerde volmachtgevers, die NIET samen genummerd zijn in de comparitie
				en waarvan de partij-letter NIET afgedrukt moet worden  -->
			<xsl:when test="($aantalSubpartijen > 1) and ($gerelateerdePersonen > 0)">
				<!-- 
					hier vooraf bepalen of dit de laats opgenoemde gerefereerde volmachtgever is,
					om de complexiteit van de scheidings-komma logica te beperken.
				-->
				<xsl:choose>
					<!-- als dit de eerste partij is, dan voorafgaan door niets -->
					<xsl:when test="$posSub = 1">
						<xsl:text></xsl:text>
					</xsl:when>
					<!-- als dit de laatse partij is, dan voorafgaan door 'en' -->
					<xsl:when test="$posSub = ($aantalRefPartijen)">
						<xsl:text> en</xsl:text>
					</xsl:when>
					<!-- in alle andere gevallen, dan voorafgaan door een ',' -->
					<xsl:otherwise>
						<xsl:text>,</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
				<!-- vaste tekst -->
				<xsl:text> volmachtgevers sub </xsl:text>
				<!-- partijNummer v/d volmachtgever opnoemen -->
				<xsl:number value="$partijNummer" format="1"/>
			</xsl:when>

			<!-- variant 3b: meerdere gerefereerde volmachtgevers, die WEL samen genummerd zijn in de comparitie
				en waarvan de partij-letter WEL afgedrukt moet worden  -->
			<xsl:when test="($aantalSubpartijen > 1) and ($gerelateerdePersonen > 0) and ($aantalVoormalig > 0)">
				<!-- 
					hier vooraf bepalen of dit de laats opgenoemde gerefereerde volmachtgever is,
					om de complexiteit van de scheidings-komma logica te beperken.
					als dit niet de eerste partij is, dan wordt hier de hoofdpartij altijd voorafgaan door een ','
				-->
				<xsl:if test="$posSub &gt; 1">
					<xsl:text>,</xsl:text>
				</xsl:if>
				<!-- vaste tekst -->
				<xsl:text> volmachtgever sub </xsl:text>
				<!-- partijNummer v/d volmachtgever opnoemen -->
				<xsl:number value="$partijNummer" format="1"/>
				<!-- bepaal de Partijletter binnen de gerelateerde volmachtgevers -->
				<xsl:number value="position()" format="a"/>
				<!-- bepaal of hierna opgenoemde volmachtgever de laatste is -->
				<xsl:choose>
					<xsl:when test="($posSub = $aantalRefPartijen) and ($gerelateerdePersonen = 1)">
						<xsl:text> en</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>,</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
				<!-- opsommen van ALLE PartijLetters -->
				<xsl:for-each select="tia:IMKAD_Persoon/tia:GerelateerdPersoon">
					<!-- vaste tekst -->
					<xsl:text> volmachtgever sub </xsl:text>
					<!-- partijNummer v/d volmachtgever opnoemen -->
					<xsl:number value="$partijNummer" format="1"/>
					<!-- bepaal de Partijletter binnen de gerelateerde volmachtgevers -->
					<xsl:number value="position()+1" format="a"/>
					<!-- bepaal of dit wel of niet de laatste gerelateerde volmachtgever is -->
					<xsl:choose>
						<xsl:when test="position() &lt; $gerelateerdePersonen">
							<xsl:text>,</xsl:text>
						</xsl:when>
					</xsl:choose>
				</xsl:for-each>
				<!-- bepaal of dit wel of niet de laatste opgenoemde volmachtgever is 
				<xsl:choose>
					<xsl:when test="$posSub &lt; ($aantalRefPartijen - 1)">
						<xsl:text>,</xsl:text>
					</xsl:when>
					<xsl:when test="$posSub = ($aantalRefPartijen - 1)">
						<xsl:text> en</xsl:text>
					</xsl:when>
				</xsl:choose> -->
			</xsl:when>
			
		</xsl:choose>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-verkrijgerRechtRef-party
	*********************************************************
	Public: no

	Identity transform: no

	Description: bepaal het volgnummer v/d gerefereerde rechthebbenden in de comparitie.

	Input: tia:Partij

	Params: aantalRefs - het aantal verkrijgerRechtRef's in het StukdeelDoorhalingHypotheek

	Output: XHTML structure

	Calls:
	<none>

	Called by:
	(mode) do-stukdeel-doorhaling-variant-1
	-->
	<xsl:template match="tia:Partij" mode="do-verkrijgerRechtRef-party">
		<!-- het aantal op te noemen SubPartijen in StukdeelDoorhalingHypotheek wordt meegegeven -->
		<xsl:param name="aantalRefPartijen"/>
		<!-- de positie(volgorde) van de subPartij in StukdeelDoorhalingHypotheek wordt meegegeven -->
		<xsl:param name="posSub"/>
		
		<!-- het totaal aantal subpartijen -->
		<xsl:variable name="aantalSubpartijen" select="count(parent::tia:Partij/tia:Partij)"/>
		<!-- bepaal het volgnummer van deze Partij in //IMKAD_AangebodenStuk/Partij[aanduidingPartij=volmachtgevers] -->
		<xsl:variable name="partijNummer" select="count(preceding-sibling::tia:Partij) + 1"/>
		<!-- bepaal het aantal gerelateerde personen in deze partij -->
		<xsl:variable name="gerelateerdePersonen" select="count(tia:IMKAD_Persoon/tia:GerelateerdPersoon)"/>


		<xsl:choose>
			<!-- variant 1: slechts 1 gerefereerde  rechthebbende, die NIET genummerd is in de comparitie -->
			<xsl:when test="($aantalSubpartijen = 1) and ($gerelateerdePersonen = 0)">
				<xsl:text> rechthebbende</xsl:text>
			</xsl:when>

			<!-- variant 2a: twee gerefereerde  rechthebbenden, die NIET samen genummerd zijn in de comparitie -->
			<xsl:when test="($aantalSubpartijen = 1) and ($gerelateerdePersonen = 1)">
				<!-- vaste tekst -->
				<xsl:text> rechthebbende sub 1 en rechthebbenden sub 2 </xsl:text>
			</xsl:when>

			<!-- variant 2b: meerdere gerefereerde en gerelateerde  rechthebbenden, die NIET samen genummerd zijn in de comparitie -->
			<xsl:when test="(($aantalSubpartijen = 1) and ($gerelateerdePersonen > 1))">
				<!-- vaste tekst -->
				<xsl:text> rechthebbende sub 1, </xsl:text>
				<!-- dan opsommen van ALLE gerelateerde rechthebbenden (partijen) -->
				<xsl:for-each select="tia:IMKAD_Persoon/tia:GerelateerdPersoon">
					<!-- vaste tekst -->
					<xsl:text> rechthebbende sub </xsl:text>
					<!-- partijNummer v/d  rechthebbende opnoemen -->
					<xsl:number value="($partijNummer)+(position())" format="1"/>
					<!-- bepaal of dit wel of niet de laatste gerelateerde  rechthebbende is -->
					<xsl:choose>
						<xsl:when test="position() &lt; ($gerelateerdePersonen - 1)">
							<xsl:text>,</xsl:text>
						</xsl:when>
						<xsl:when test="position() = ($gerelateerdePersonen - 1)">
							<xsl:text> en</xsl:text>
						</xsl:when>
					</xsl:choose>
				</xsl:for-each>
			</xsl:when>

			<!-- variant 2c: meerdere gerefereerde en NIET gerelateerde  rechthebbenden, die NIET samen genummerd zijn in de comparitie -->
			<xsl:when test="($aantalSubpartijen > 1) and ($gerelateerdePersonen = 0)">
				<!-- 
					hier vooraf bepalen of dit de laats opgenoemde gerefereerde  rechthebbende is,
					om de complexiteit van de scheidings-komma logica te beperken.
				-->
				<xsl:choose>
					<!-- als dit de eerste partij is, dan voorafgaan door niets -->
					<xsl:when test="$posSub = 1">
						<xsl:text></xsl:text>
					</xsl:when>
					<!-- als dit de laatse partij is, dan voorafgaan door 'en' -->
					<xsl:when test="$posSub = ($aantalRefPartijen)">
						<xsl:text> en</xsl:text>
					</xsl:when>
					<!-- in alle andere gevallen, dan voorafgaan door een ',' -->
					<xsl:otherwise>
						<xsl:text>,</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
				<!-- vaste tekst -->
				<xsl:text> rechthebbende sub </xsl:text>
				<!-- partijNummer v/d  rechthebbende opnoemen -->
				<xsl:number value="$partijNummer" format="1"/>
				<!-- bepaal of dit wel of niet de laatste opgenoemde volmachtgever is 
				<xsl:choose>
					<xsl:when test="$posSub &lt; ($aantalRefPartijen - 1)">
						<xsl:text>,</xsl:text>
					</xsl:when>
					<xsl:when test="$posSub = ($aantalRefPartijen - 1)">
						<xsl:text> en</xsl:text>
					</xsl:when>
				</xsl:choose> -->
			</xsl:when>

			<!-- variant 3a: meerdere gerefereerde  rechthebbenden, die NIET samen genummerd zijn in de comparitie
				en waarvan de partij-letter NIET afgedrukt moet worden  -->
			<xsl:when test="($aantalSubpartijen > 1) and ($gerelateerdePersonen > 0)">
				<!-- 
					hier vooraf bepalen of dit de laats opgenoemde gerefereerde  rechthebbende is,
					om de complexiteit van de scheidings-komma logica te beperken.
				-->
				<xsl:choose>
					<!-- als dit de eerste partij is, dan voorafgaan door niets -->
					<xsl:when test="$posSub = 1">
						<xsl:text></xsl:text>
					</xsl:when>
					<!-- als dit de laatse partij is, dan voorafgaan door 'en' -->
					<xsl:when test="$posSub = ($aantalRefPartijen)">
						<xsl:text> en</xsl:text>
					</xsl:when>
					<!-- in alle andere gevallen, dan voorafgaan door een ',' -->
					<xsl:otherwise>
						<xsl:text>,</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
				<!-- vaste tekst -->
				<xsl:text> rechthebbenden sub </xsl:text>
				<!-- partijNummer v/d volmachtgever opnoemen -->
				<xsl:number value="$partijNummer" format="1"/>
			</xsl:when>

		</xsl:choose>	
	</xsl:template>
	<!--
	*********************************************************
	template: do-recht-en-registergoed
	*********************************************************
	Public: yes

	Description: TEKSTBLOK_Recht_en_Registergoed
		Optionele afleidbare tekst en herhalende combinatie van tekstblok RECHT en tekstblok REGISTERGOED.
		(voor een gedeeltelijke doorhaling hypotheek van één of meer recht/registergoed combinaties).

	Input: -

	called by do-stukdeel-doorhaling-variant-2 & -3
	-->
	<xsl:template name="do-recht-en-registergoed">
		<xsl:text>, doch alleen voor zover gemeld hypotheekrecht is gevestigd op:</xsl:text>
		<br/>
		<!-- bepaal het aantal IMKAD_ZakelijkRecht -->
		<xsl:choose>
			<!-- enkel IMKAD_ZakelijkRecht -->
			<xsl:when test="count(tia:IMKAD_ZakelijkRecht) = 1">
				<p>
					<!-- TEKSTBLOK RECHT -->
					<xsl:variable name="rightText">
						<xsl:apply-templates select="tia:IMKAD_ZakelijkRecht" mode="do-right"/>
					</xsl:variable>
					<xsl:if test="normalize-space($rightText) != ''">
						<xsl:value-of select="$rightText"/>
						<!-- (spatie) -->
						<xsl:text> </xsl:text>
					</xsl:if>
					<!-- TEKSTBLOK REGISTERGOED -->
					<xsl:apply-templates select="tia:IMKAD_ZakelijkRecht" mode="do-registered-object"/>
					<xsl:text>.</xsl:text>
				</p>
			</xsl:when>
			<!-- Multiple registered objects, all parcels with same data -->
			<!-- let go crazy and align this monster to the left, in an effort to pretend is still human readable... :-( -->
			<xsl:when test="count(tia:IMKAD_ZakelijkRecht)= count(tia:IMKAD_ZakelijkRecht[
		tia:aardVerkregen = current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:aardVerkregen
		and normalize-space(tia:aardVerkregen) != ''
		and ((tia:aardVerkregenVariant = current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:aardVerkregenVariant)
			or (not(tia:aardVerkregenVariant)
				and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:aardVerkregenVariant)))					
		and ((tia:tia_Aantal_BP_Rechten = current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_Aantal_BP_Rechten)
			or (not(tia:tia_Aantal_BP_Rechten)
				and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_Aantal_BP_Rechten)))
		and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven']/tia:tekst
				= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven']/tia:tekst)
			or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven'])
				and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven'])))
		and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom']/tia:tekst
				= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom']/tia:tekst)
			or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom'])
			and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom'])))
		and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoud']/tia:tekst
				= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoud']/tia:tekst)
			or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoud'])
			and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoud'])))
		and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurend']/tia:tekst
				= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurend']/tia:tekst)
			or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurend'])
			and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurend'])))
		and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijvenvariant']/tia:tekst
				= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijvenvariant']/tia:tekst)
			or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijvenvariant'])
			and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijvenvariant'])))
		and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoudvariant']/tia:tekst
				= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoudvariant']/tia:tekst)
			or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoudvariant'])
			and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoudvariant'])))
		and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurendvariant']/tia:tekst
				= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurendvariant']/tia:tekst)
			or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurendvariant'])
			and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurendvariant'])))
		and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aantal_bp_rechtenvariant']/tia:tekst
				= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aantal_bp_rechtenvariant']/tia:tekst)
			or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aantal_bp_rechtenvariant'])
			and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aantal_bp_rechtenvariant'])))
		and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen']/tia:tekst
				= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen']/tia:tekst)
			or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen'])
				and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen'])))
		and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_wijzevanlevering']/tia:tekst
				= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_wijzevanlevering']/tia:tekst)
			or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_wijzevanlevering'])
				and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_wijzevanlevering'])))
		and ((tia:aandeelInRecht/tia:teller = current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:aandeelInRecht/tia:teller
			and tia:aandeelInRecht/tia:noemer = current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:aandeelInRecht/tia:noemer)
			or (not(tia:aandeelInRecht)
				and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:aandeelInRecht)))
		and tia:IMKAD_Perceel[tia:tia_OmschrijvingEigendom = current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_OmschrijvingEigendom
			and normalize-space(tia:tia_OmschrijvingEigendom) != ''
			and ((tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid']/tia:tekst
					= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid']/tia:tekst)
				or (not(tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid'])
					and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid'])))
			and ((tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aanduiding']/tia:tekst
					= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aanduiding']/tia:tekst)
				or (not(tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aanduiding'])
				and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aanduiding'])))
			and ((tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_nabij']/tia:tekst
					= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_nabij']/tia:tekst)
				or (not(tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_nabij'])
				and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_nabij'])))
			and ((tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_komma']/tia:tekst
					= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_komma']/tia:tekst)
				or (not(tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_komma'])
				and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_komma'])))
			and ((tia:tia_SplitsingsverzoekOrdernummer = current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_SplitsingsverzoekOrdernummer)
				or (not(tia:tia_SplitsingsverzoekOrdernummer)
					and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_SplitsingsverzoekOrdernummer)))
		and ((tia:stukVerificatiekosten/tia:reeks = current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:reeks)
				or (not(tia:stukVerificatiekosten/tia:reeks)
					and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:reeks)))
			and ((tia:stukVerificatiekosten/tia:deel = current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:deel)
				or (not(tia:stukVerificatiekosten/tia:deel)
					and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:deel)))
			and ((tia:stukVerificatiekosten/tia:nummer = current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:nummer)
				or (not(tia:stukVerificatiekosten/tia:nummer)
					and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:nummer)))
			and tia:kadastraleAanduiding/tia:gemeente = current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:kadastraleAanduiding/tia:gemeente
			and normalize-space(tia:kadastraleAanduiding/tia:gemeente) != ''
			and tia:kadastraleAanduiding/tia:sectie = current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:kadastraleAanduiding/tia:sectie
			and normalize-space(tia:kadastraleAanduiding/tia:sectie) != ''
			and tia:IMKAD_OZLocatie/tia:ligging = current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:ligging
			and normalize-space(tia:IMKAD_OZLocatie/tia:ligging) != ''
			and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer
				= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer)
				or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer)
					and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer)))
			and  ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter
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
			and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam
				= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam)
				or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam)
					and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam)))
		and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam
				= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam)
				or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam)
					and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam)))
			and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:postcode
				= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:postcode)
				or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:postcode)
					and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:kadBinnenlandsAdres/tia:postcode)))
			and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:woonplaatsNaam
				= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:woonplaatsNaam)
				or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:woonplaatsNaam)
					and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:kadBinnenlandsAdres/tia:woonplaatsNaam)))
			and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:openbareRuimteNaam
				= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:openbareRuimteNaam)
				or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:openbareRuimteNaam)
					and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:kadBinnenlandsAdres/tia:openbareRuimteNaam)))				
			and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummer
				= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummer)
				or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummer)
					and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:kadBinnenlandsAdres/tia:huisNummer)))
			and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisLetter
				= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisLetter)
				or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisLetter)
					and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:kadBinnenlandsAdres/tia:huisLetter)))
			and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummerToevoeging
				= current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummerToevoeging)
				or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummerToevoeging)
					and not(current()/tia:IMKAD_ZakelijkRecht[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:kadBinnenlandsAdres/tia:huisNummerToevoeging)))]]) and $RegistergoedTonenPerPerceel='false' ">
				<p>
					<!-- TEKSTBLOK RECHT -->
					<xsl:variable name="rightText">
						<xsl:apply-templates select="tia:IMKAD_ZakelijkRecht[1]" mode="do-right"/>
					</xsl:variable>
					<xsl:if test="normalize-space($rightText) != ''">
						<xsl:value-of select="$rightText"/>
						<!-- (spatie) -->
						<xsl:text> </xsl:text>
					</xsl:if>
					<!-- TEKSTBLOK REGISTERGOED -->
					<xsl:apply-templates select="tia:IMKAD_ZakelijkRecht[1]" mode="do-registered-object"/>
					<xsl:text>,</xsl:text>
					<!-- (regeleinde) -->
					<br/>
				</p>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="existAanduiding">
					<xsl:choose>
						<xsl:when test="tia:IMKAD_ZakelijkRecht[translate(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedaanduidingtekst']/tia:tekst, $upper, $lower) = 'true']">
							<xsl:text>true</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>false</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<table cellpadding="0" cellspacing="0">
					<tbody>
						<xsl:call-template name="processRights">
							<xsl:with-param name="positionOfProcessedRight" select="1"/>
							<xsl:with-param name="position" select="1"/>
							<xsl:with-param name="registeredObjects" select="."/>
							<xsl:with-param name="punctuationMark" select="','"/>
							<xsl:with-param name="haveAdditionalText" select="'false'"/>
							<xsl:with-param name="semicolon" select="$existAanduiding"/>
						</xsl:call-template>
					</tbody>
				</table>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--
	*********************************************************
	template: aanvaardingVolmacht
	*********************************************************
	Public: yes

	Description: TEKSTBLOK_Aanvaarding_Volmacht

	Input: -

	called by do-stukdeel-doorhaling-variant-1
	-->
	<xsl:template name="aanvaardingVolmacht">
		<xsl:variable name="bijwaarnemer" select="tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_bijwaarnemer']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
				translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_bijwaarnemer']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
				translate(normalize-space(current()/tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_bijwaarnemer']/tia:tekst), $upper, $lower)]), $upper, $lower)]" />
		<!-- print de Aanvaarding header -->
		<u>
			<b>
				<xsl:text>Aanvaarding</xsl:text>
			</b>
		</u>
		<!-- (regeleinde) -->
		<br/>
		<!--  verklaring van afstand nemen rechthebbende -->
		<xsl:text> De </xsl:text>
		<!-- KEUZETEKST k_Rechthebbende -->
		<xsl:value-of select="normalize-space(tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_rechthebbende']/tia:tekst)"/>
		<xsl:text> op de met bovenbedoeld hypotheekrecht bezwaarde registergoederen </xsl:text>
		<!-- KEUZETEKST k_NeemtNemen -->
		<xsl:value-of select="normalize-space(tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_neemtnemen']/tia:tekst)"/>
		<xsl:text> hierbij, voor zover dat niet reeds eerder is geschied, de hiervoor vermelde afstand van het hypotheekrecht aan.</xsl:text>
		<!-- forceer regeleinde -->
		<br/>
		<!-- print de Volmacht header -->
		<u>
			<b>
				<xsl:text>Volmacht</xsl:text>
			</b>
		</u>
		<!-- forceer regeleinde -->
		<br/>
		<!-- vaste tekst -->
		<xsl:text>Van de onderhavige volmachtverlening door de </xsl:text>
		<!-- KEUZETEKST k_Rechthebbende -->
		<xsl:value-of select="normalize-space(tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_rechthebbende']/tia:tekst)"/>
    	<!-- Verplichte gebruikerskeuze: aanvaarding variant -->
    	<xsl:choose>
			<!-- aanvaarding bij onderhandse volmacht  -->
			<xsl:when test="normalize-space(tia:volmachtverleningAfstand/tia:aantalOnderhandseAkten) != ''">
				<xsl:text> blijkt uit </xsl:text>

				<xsl:value-of select="normalize-space(kef:convertNumberToText(tia:volmachtverleningAfstand/tia:aantalOnderhandseAkten))"/>
				
				<xsl:text> onderhandse </xsl:text>
				<xsl:choose>
					<xsl:when test="normalize-space(tia:volmachtverleningAfstand/tia:aantalOnderhandseAkten) = 1">
						<xsl:text>akte</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>akten</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:text> van volmacht die aan deze akte </xsl:text>
				<xsl:choose>
					<xsl:when test="normalize-space(tia:volmachtverleningAfstand/tia:aantalOnderhandseAkten) = 1">
						<xsl:text>wordt</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>worden</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:text> gehecht</xsl:text>
			</xsl:when>
			<!-- aanvaarding bij akte andere notaris of oud-notaris  -->
			<xsl:when test="(tia:volmachtverleningAfstand[normalize-space(tia:datumOndertekening) != '']) and (tia:volmachtverleningAfstand[normalize-space(tia:naamNotaris) != ''])
						and (tia:volmachtverleningAfstand[normalize-space(tia:plaatsNotarisKantoor) != ''])">
				<xsl:text> blijkt uit een akte verleden op </xsl:text>
				<xsl:value-of select="kef:convertDateToText(normalize-space(tia:volmachtverleningAfstand/tia:datumOndertekening))"/>
				<xsl:text> voor </xsl:text>
				<xsl:value-of select="normalize-space(tia:volmachtverleningAfstand/tia:naamNotaris)"/>
				<!-- KEUZETEKST: oud notaris -->
				<xsl:text>, </xsl:text>
				<xsl:value-of select="normalize-space(tia:tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_oudnotaris']/tia:tekst)"/>
				<xsl:text> notaris te </xsl:text>
				<xsl:value-of select="normalize-space(tia:volmachtverleningAfstand/tia:plaatsNotarisKantoor)"/>
			</xsl:when>
			<!-- aanvaarding bij waarnemer  -->
			<xsl:when test="(tia:volmachtverleningAfstand[normalize-space(tia:datumOndertekening) != '']) and (tia:volmachtverleningAfstand[normalize-space(tia:naamNotaris) != ''])">
				<xsl:text> blijkt uit een akte verleden op </xsl:text>
				<xsl:value-of select="kef:convertDateToText(normalize-space(tia:volmachtverleningAfstand/tia:datumOndertekening))"/>
				<xsl:text> voor </xsl:text>
				<xsl:value-of select="normalize-space(tia:volmachtverleningAfstand/tia:naamNotaris)"/>
				<xsl:text>,  als waarnemer van mij, notaris</xsl:text>
			</xsl:when>
			<!-- aanvaarding bij (waarnemer van) notaris niet met naam genoemd  -->
			<xsl:when test="(tia:volmachtverleningAfstand[normalize-space(tia:datumOndertekening) != ''])">
				<xsl:text> blijkt uit een akte verleden op </xsl:text>
				<xsl:value-of select="kef:convertDateToText(normalize-space(tia:volmachtverleningAfstand/tia:datumOndertekening))"/>
				<xsl:text> voor </xsl:text>
				<!-- KEUZETEKST: waarnemen -->
				<xsl:if test="$bijwaarnemer != ''">
					<xsl:value-of select="$bijwaarnemer"/>
				</xsl:if>
				<xsl:text> mij, notaris</xsl:text>
			</xsl:when>
		</xsl:choose>
		<xsl:text>.</xsl:text>

	</xsl:template>
	<!--
	*********************************************************
	Mode: do-VoormaligeRechtspersoon
	*********************************************************
	Public: yes

	Description: de Voormalige Rechts Persoon gegevens

	Input: tia:VoormaligeRechtspersoon

	called by do-vervreemderRechtRef-party
	-->
	<xsl:template match="tia:VoormaligeRechtspersoon[@id]" mode="do-VoormaligeRechtspersoon">
		<xsl:variable name="dehet">
			<xsl:choose>
				<xsl:when test="translate(tia:rechtsvormSub, $upper, $lower) = 'kerkgenootschap'">
					<xsl:text>het </xsl:text>
					<xsl:value-of select="tia:rechtsvormSub"/>
				</xsl:when>
				<xsl:when test="translate(tia:rechtsvormSub, $upper, $lower) = 'de staat'">
					<xsl:value-of select="tia:rechtsvormSub"/>
				</xsl:when>
				<xsl:when test="tia:rechtsvormSub">
					<xsl:text>de </xsl:text>
					<xsl:value-of select="tia:rechtsvormSub"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:text>, ten tijde van de inschrijving genaamd </xsl:text>
		<xsl:value-of select="$dehet"/>
		<xsl:text> </xsl:text>
		<xsl:value-of select="tia:statutaireNaam"/>
	</xsl:template>
	<!--
	*********************************************************
	Mode: do-signature
	*********************************************************
	Public: yes

	Identity transform: no

	Description: Passeren akte.

	Input: tia:IMKAD_AangebodenStuk

	Params: none

	Output: text
	
	Called by: main
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:IMKAD_AangebodenStuk" mode="do-signature">
		<p>
			<strong>
				<xsl:text>WAARVAN AKTE</xsl:text>
			</strong>
			<xsl:text> is verleden te </xsl:text>
			<xsl:value-of select="tia:tia_PlaatsOndertekening/tia:woonplaatsNaam"/>
			<xsl:text> op de datum in het hoofd van deze akte vermeld.</xsl:text>
			<xsl:if test="tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_toegelicht']/tia:tekst = 'true'">
				<xsl:text> De zakelijke inhoud van de akte is aan de verschenen </xsl:text>
				<xsl:choose>
					<xsl:when test="$numberOfRepresentatives > 1">
						<xsl:text> personen</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text> persoon</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:text> opgegeven en toegelicht. De verschenen </xsl:text>
				<xsl:choose>
					<xsl:when test="$numberOfRepresentatives > 1">
						<xsl:text> personen hebben</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text> persoon heeft</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:text> verklaard op volledige voorlezing van de akte geen prijs te stellen en tijdig voor het verlijden van de akte een concept-akte te hebben ontvangen, van de inhoud van de akte te hebben kennis genomen en te zijn gewezen op de gevolgen die voor partijen uit de akte voortvloeien.</xsl:text>
			</xsl:if>
			<xsl:text> Deze akte is onmiddellijk na beperkte voorlezing door de verschenen</xsl:text>
			<xsl:choose>
				<xsl:when test="$numberOfRepresentatives > 1">
					<xsl:text> personen</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text> persoon</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text> en vervolgens door mij, notaris, ondertekend</xsl:text>
			<xsl:if test="tia:tia_TijdOndertekening">
				<xsl:text> om </xsl:text>
				<xsl:if test="string-length(substring(string(tia:tia_TijdOndertekening), 0, 11)) != 0">
					<xsl:value-of select="kef:convertTimeToText(substring(tia:tia_TijdOndertekening, 1, 5))"/>
				</xsl:if>
				<xsl:text> (</xsl:text>
				<xsl:value-of select="substring(tia:tia_TijdOndertekening, 0, 6)"/>
				<xsl:text> uur)</xsl:text>
			</xsl:if>
			<xsl:text>.</xsl:text>
		</p>
		<xsl:if test="translate($type-document, $upper, $lower) = 'afschrift'">
			<p>
				<br/>
			</p>
			<p>
				<xsl:text>UITGEGEVEN VOOR AFSCHRIFT</xsl:text>
				<br/>
				<xsl:text>w.g.</xsl:text>
				<br/>
				<xsl:apply-templates select="tia:heeftOndertekenaar/tia:persoonsgegevens" mode="ondertekenaar" />
				<xsl:text>, (kandidaat-)notaris</xsl:text>
			</p>
		</xsl:if>
	</xsl:template>
	<!--
	*********************************************************
	Mode: ondertekenaar
	*********************************************************
	Public: yes

	Identity transform: no

	Description: ondertekenaar.

	Input: tia:persoonsgegevens

	Params: none

	Output: XHTML
	
	Called by: do-signature
	-->
	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:persoonsgegevens" mode="ondertekenaar">
		<xsl:value-of select="normalize-space(concat(../tia:voorletters,' ',tia:tia_VoorvoegselsNaam,' ',tia:tia_NaamZonderVoorvoegsels))"/>
	</xsl:template>
	
<!-- 
	EOF
 -->
</xsl:stylesheet>
