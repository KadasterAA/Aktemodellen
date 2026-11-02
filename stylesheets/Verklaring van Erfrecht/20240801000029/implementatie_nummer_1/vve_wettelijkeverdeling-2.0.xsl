<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
                xmlns:vve="http://www.kadaster.nl/schemas/AA/VVE-WettelijkeVerdeling/v20240801"
                xmlns:c="http://www.kadaster.nl/schemas/AA/tussen"
                xmlns:exslt="http://exslt.org/common"
                xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:kef="nl.kadaster.xslt.XslExtensionFunctions" exclude-result-prefixes="vve kef xsl xlink"
                version="1.0">
    <xsl:param name="type-document" select="'CONCEPT'"/>
    <xsl:param name="css-url" select="'kadaster.css'"/>

    <xsl:include href="keuzeblok_vve_wettelijkeverdeling-1.0.xsl"/>
    <xsl:include href="keuzeblok_vve_wettelijkeverdeling_aanvaarding-2.0.xsl"/>
    <xsl:include href="keuzeblok_vve_wettelijkeverdeling_executele-1.0.xsl"/>
    <xsl:include href="keuzeblok_vve_wettelijkeverdeling_overlijden-1.0.xsl"/>
    <xsl:include href="keuzeblok_vve_wettelijkeverdeling_partner-2.0.xsl"/>
    <xsl:include href="keuzeblok_vve_wettelijkeverdeling_afstammelingen-2.0.xsl"/>
    <xsl:include href="keuzeblok_vve_wettelijkeverdeling_testament_uiterste_wilsbeschikking-1.0.xsl"/>
    <xsl:include href="keuzeblok_vve_wettelijkeverdeling_erfdelen-2.0.xsl"/>
    <xsl:include href="keuzeblok_vve_wettelijkeverdeling_clausule-1.0.xsl"/>
    <xsl:include href="keuzeblok_vve_wettelijkeverdeling_conclusie-1.0.xsl"/>
    <xsl:include href="keuzeblok_vve_wettelijkeverdeling_inschrijving_boedelregister-1.0.xsl"/>
    <xsl:include href="keuzeblok_vve_wettelijkeverdeling_woonplaatskeuze-1.0.xsl"/>
    <xsl:include href="keuzeblok_vve_wettelijkeverdeling_opsommingBijlagen-1.0.xsl"/>
    <xsl:include href="vve_tekstblok_aanhef-1.00.xsl"/>
    <xsl:include href="vve_tekstblok_equivalentieverklaring-1.00.xsl"/>
    <xsl:include href="vve_tekstblok_natuurlijk_persoon-1.00.xsl"/>
    <xsl:include href="vve-tekstblok_personalia_van_natuurlijk_persoon-1.00.xsl"/>
    <xsl:include href="vve_tekstblok_woonadres-1.00.xsl"/>

    <!-- Common global variables -->
    <xsl:variable name="upper" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
    <xsl:variable name="lower" select="'abcdefghijklmnopqrstuvwxyz'"/>
    <xsl:variable name="documentTitle" select="vve:Bericht_TIA_Stuk/IMKAD_AangebodenStuk/titelAkte"/>
    <xsl:variable name="overledeneAanduiding"
                  select="vve:Bericht_TIA_Stuk/IMKAD_AangebodenStuk/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_overledeneaanduiding']/tekst"/>
    <xsl:variable name="benamingPartner"
                  select="vve:Bericht_TIA_Stuk/IMKAD_AangebodenStuk/stukdeelVVE/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_benamingpartner']/tekst"/>
    <xsl:variable name="blijkens"
                  select="vve:Bericht_TIA_Stuk/IMKAD_AangebodenStuk/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_blijkens']/tekst"/>
    <xsl:variable name="blijkens_up"
                  select="concat(translate(substring($blijkens,1,1),$lower,$upper),substring($blijkens,2))"/>
    <xsl:variable name="blijkens_low"
                  select="concat(translate(substring($blijkens,1,1),$upper,$lower),substring($blijkens,2))"/>
    <xsl:variable name="opsommingPersonen" select="vve:Bericht_TIA_Stuk/IMKAD_AangebodenStuk/opsommingPersonen"/>
    <xsl:variable name="overledeneRef"
                  select="vve:Bericht_TIA_Stuk/IMKAD_AangebodenStuk/stukdeelVVE/overlijden/overledeneRef/@xlink:href"/>
    <xsl:variable name="overledenPersoon"
                  select="$opsommingPersonen/IMKAD_Persoon[@id = substring-after($overledeneRef,'#')]"/>
    <xsl:variable name="benamingTestament"
                  select="vve:Bericht_TIA_Stuk/IMKAD_AangebodenStuk/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_benamingtestament']/tekst"/>
    <xsl:variable name="zijnHaar">
        <xsl:choose>
            <xsl:when test="$overledenPersoon/gegevens/GBA_Ingezetene/geslacht/geslachtsaanduiding = 'Man'">
                <xsl:text>zijn</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>haar</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <xsl:variable name="partnerRef"
                  select="vve:Bericht_TIA_Stuk/IMKAD_AangebodenStuk/stukdeelVVE/partners/partnerOverledene/partnerRef/@xlink:href"/>
    <xsl:variable name="partner" select="$opsommingPersonen/IMKAD_Persoon[@id = substring-after($partnerRef,'#')]"/>

     <xsl:variable name="afstammelingenExslt">
        <xsl:apply-templates select="vve:Bericht_TIA_Stuk/IMKAD_AangebodenStuk/stukdeelVVE/partners/partnerOverledene" mode="do-tussen-xml"/>
        <xsl:apply-templates select="vve:Bericht_TIA_Stuk/IMKAD_AangebodenStuk/stukdeelVVE/partners/eerderePartner" mode="do-tussen-xml"/>
        <xsl:apply-templates select="vve:Bericht_TIA_Stuk/IMKAD_AangebodenStuk/stukdeelVVE/overigeAfstammelingen" mode="do-tussen-xml"/>
    </xsl:variable>
    <xsl:variable name="afstammelingen" select="exslt:node-set($afstammelingenExslt)"/>

    <xsl:variable name="erfdelenExslt">
        <xsl:apply-templates select="vve:Bericht_TIA_Stuk/IMKAD_AangebodenStuk/stukdeelVVE/erfdelenPerPersoon" mode="do-tussen-xml"/>
    </xsl:variable>
    <xsl:variable name="erfdelen" select="exslt:node-set($erfdelenExslt)"/>

    <xsl:template match="/">
        <html>
            <head>
                <xsl:choose>
                    <xsl:when test="normalize-space($documentTitle) != ''">
                        <title>
                            <xsl:value-of select="$documentTitle"/>
                        </title>
                    </xsl:when>
                    <xsl:otherwise>
                        <title>&#160;</title>
                    </xsl:otherwise>
                </xsl:choose>
                <meta http-equiv="Content-Type" content="text/html;charset=UTF-8"/>
                <meta http-equiv="PRAGMA" content="NO-CACHE"/>
                <meta http-equiv="CACHE-CONTROL" content="NO-CACHE"/>
                <meta scheme="nl.kadaster.kik" name="type-document" content="{$type-document}"/>
                <meta content="50" name="margin-left" scheme="nl.kadaster.kik"/>
                <meta content="60" name="margin-top" scheme="nl.kadaster.kik"/>
                <xsl:if test="$css-url != ''">
                    <link rel="stylesheet" type="text/css" href="{$css-url}"/>
                </xsl:if>
            </head>
            <body>
                <xsl:apply-templates select="vve:Bericht_TIA_Stuk" mode="do-vve"/>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="vve:Bericht_TIA_Stuk" mode="do-vve">
        <xsl:apply-templates select="IMKAD_AangebodenStuk" mode="do-statement-of-equivalence"/>
        <p title="without_dashes">
            <br/>
        </p>
        <xsl:if test="normalize-space($documentTitle) != ''">
            <p style="text-align:center" title="without_dashes">
                <xsl:value-of select="$documentTitle"/>
            </p>
            <!-- Empty line after title -->
            <p title="without_dashes">
                <br/>
            </p>
        </xsl:if>
        <xsl:apply-templates select="IMKAD_AangebodenStuk" mode="do-header"/>
        <xsl:apply-templates select="IMKAD_AangebodenStuk/stukdeelVVE/overlijden"/>
        <xsl:apply-templates select="IMKAD_AangebodenStuk/stukdeelVVE/partners"/>
        <xsl:call-template name="afstammelingen"/>
        <xsl:apply-templates select="IMKAD_AangebodenStuk/stukdeelVVE/testamentUitersteWilsbeschikking"/>
        <h3 class="header">
            <u>TOEPASSELIJK RECHT</u>
        </h3>
        <p>
            <xsl:text>Op de nalatenschap is op grond van </xsl:text>
            <xsl:value-of
                    select="IMKAD_AangebodenStuk/stukdeelVVE/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_toepasselijkrecht']/tekst"/>
            <xsl:text>, Nederlands recht van toepassing.</xsl:text>
        </p>
        <xsl:apply-templates select="IMKAD_AangebodenStuk/stukdeelVVE/erfdelenGezamenlijk" mode="do-erfgenamen"/>
        <xsl:apply-templates select="IMKAD_AangebodenStuk/stukdeelVVE/erfdelenPerPersoon" mode="do-erfgenamen"/>
        <xsl:apply-templates select="IMKAD_AangebodenStuk/stukdeelVVE/wettelijkeVerdeling"/>
        <xsl:apply-templates select="IMKAD_AangebodenStuk/stukdeelVVE/aanvaardingen"/>
        <xsl:if test="translate(IMKAD_AangebodenStuk/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_geenwettelijkevereffening']/tekst,$upper, $lower) = 'true'">
            <h3 class="header">
                <u>GEEN WETTELIJKE VEREFFENING</u>
            </h3>
            <p>
                <xsl:text>Op grond van artikel 4:202 lid 3 van het Burgerlijk Wetboek hoeft in verband met voormelde beneficiaire aanvaarding de nalatenschap niet overeenkomstig afdeling 3, titel 6, boek 4 van het Burgerlijk Wetboek te worden afgewikkeld, daar de </xsl:text>
                <xsl:value-of select="$benamingPartner"/>
                <xsl:text> van de </xsl:text>
                <xsl:value-of select="$overledeneAanduiding"/>
                <xsl:text> de nalatenschap zuiver heeft aanvaard.</xsl:text>
            </p>
        </xsl:if>
        <xsl:apply-templates select="IMKAD_AangebodenStuk/stukdeelVVE/executele"/>
        <xsl:apply-templates select="IMKAD_AangebodenStuk/stukdeelVVE/uitInSluitingsClausule"/>
        <xsl:apply-templates select="IMKAD_AangebodenStuk/stukdeelVVE/conclusie"/>
        <xsl:apply-templates select="IMKAD_AangebodenStuk/stukdeelVVE/inschrijvingBoedelregister"/>
        <xsl:apply-templates select="IMKAD_AangebodenStuk/stukdeelVVE/woonplaatsKeuze"/>
        <xsl:apply-templates select="IMKAD_AangebodenStuk/stukdeelVVE/opsommingBijlagen"/>
        <h3 class="header">
            <u>SLOTVERKLARING</u>
        </h3>
        <p>
            <xsl:text>Deze akte is opgemaakt en ondertekend te </xsl:text>
            <xsl:value-of select="IMKAD_AangebodenStuk/heeftOndertekenaar/standplaats"/>
            <xsl:text> op de datum als in het hoofd van deze akte is vermeld.</xsl:text>
        </p>
    </xsl:template>
    <xsl:template name="tb-NatuurlijkPersoon">
        <xsl:param name="persoon"/>
        <xsl:param name="toonWoonplaats" select="'true'"/>

        <xsl:apply-templates select="$persoon" mode="do-natural-person"/>
        <xsl:if test="$toonWoonplaats = 'true'">
            <xsl:text>, wonende te </xsl:text>
            <xsl:apply-templates select="$persoon/IMKAD_WoonlocatiePersoon" mode="do-address"/>
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>
