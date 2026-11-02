<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exslt="http://exslt.org/common" xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:kef="nl.kadaster.xslt.XslExtensionFunctions" exclude-result-prefixes="xsl exslt xlink kef"
                xmlns:c="http://www.kadaster.nl/schemas/AA/tussen"
                version="1.0">
    <xsl:include href="vve-tekstblok_personalia_van_natuurlijk_persoon-1.00.xsl"/>
    <xsl:template name="afstammelingen">
        <h3 class="header">
            <u>AFSTAMMELINGEN</u>
        </h3>

        <xsl:apply-templates select="$afstammelingen/c:partner" mode="do-partner"/>
        <xsl:apply-templates select="$afstammelingen/c:overigeAfstammelingen" mode="do-overigeAfstammelingen">
            <xsl:with-param name="partners" select="$afstammelingen"/>
        </xsl:apply-templates>

    </xsl:template>

    <xsl:template match="c:partner" mode="do-partner">
        <xsl:variable name="partner" select="$opsommingPersonen/IMKAD_Persoon[@id = substring-after(current()/@xlink:href,'#')]"/>
        <xsl:variable name="burgerlijkeStaat" select="@burgerlijkeStaat"/>
        <xsl:variable name="aantalKinderen" select="count(c:afstammeling[@soort='kind' or @soort='vooroverledenKind'])"/>
        <xsl:variable name="aantalKinderInLeven" select="count(c:afstammeling[@soort='kind'])"/>
        <xsl:variable name="aantalVooroverledenKind" select="count(c:afstammeling[@soort='vooroverledenKind'])"/>
        <xsl:choose>
            <xsl:when test="$aantalKinderInLeven = 0">
                <p>
                    <xsl:text>Uit voormeld </xsl:text>
                    <xsl:value-of select="$burgerlijkeStaat"/>
                    <xsl:text> met </xsl:text>
                    <xsl:apply-templates select="$partner/gegevens/GBA_Ingezetene"
                                         mode="do-natural-person-personal-data"/>
                    <xsl:text> </xsl:text>
                    <xsl:choose>
                        <xsl:when test="$aantalKinderen = 1">
                            <xsl:text> is een kind geboren, welk kind is vooroverleden, te weten:</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text> zijn </xsl:text>
                            <xsl:value-of select="kef:convertNumberToText($aantalKinderen)"/>
                            <xsl:text> kinderen geboren, welke kinderen allen zijn vooroverleden, te weten:</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                </p>
            </xsl:when>
            <xsl:otherwise>
                <p>
                    <xsl:text>Uit voormeld </xsl:text>
                    <xsl:value-of select="$burgerlijkeStaat"/>
                    <xsl:text> met </xsl:text>
                    <xsl:apply-templates select="$partner/gegevens/GBA_Ingezetene"
                                         mode="do-natural-person-personal-data"/>
                    <xsl:text> </xsl:text>
                    <xsl:choose>
                        <xsl:when test="$aantalKinderen = 1">
                            <xsl:text> is een kind geboren, waarvan in leven </xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text> zijn </xsl:text>
                            <xsl:value-of select="kef:convertNumberToText($aantalKinderen)"/>
                            <xsl:text> kinderen geboren, waarvan in leven </xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:choose>
                        <xsl:when test="$aantalKinderInLeven = 1">
                            <xsl:text> is een kind</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text> zijn </xsl:text>
                            <xsl:value-of select="kef:convertNumberToText($aantalKinderInLeven)"/>
                            <xsl:text> kinderen</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:text>, te weten:</xsl:text>
                </p>
                <table cellspacing="0" cellpadding="0">
                    <tbody>
                        <xsl:for-each select="c:afstammeling[@soort='kind']">
                            <xsl:variable name="kindInLeven"
                                          select="$opsommingPersonen/IMKAD_Persoon[@id = substring-after(current()/@xlink:href,'#')]"/>
                            <tr>
                                <td class="number">
                                    <xsl:number value="@teken"/>
                                    <xsl:text>.</xsl:text>
                                </td>
                                <td colspan="2">
                                    <xsl:call-template name="tb-NatuurlijkPersoon">
                                        <xsl:with-param name="persoon" select="$kindInLeven"/>
                                    </xsl:call-template>
                                    <xsl:value-of select="@afsluitTeken"/>
                                </td>
                            </tr>
                        </xsl:for-each>
                    </tbody>
                </table>
                <xsl:if test="$aantalVooroverledenKind > 0">
                    <p>
                        <xsl:text>terwijl </xsl:text>
                        <xsl:value-of select="kef:convertNumberToText($aantalVooroverledenKind)"/>
                        <xsl:choose>
                            <xsl:when test="$aantalVooroverledenKind = 1">
                                <xsl:text> kind is vooroverleden, te weten:</xsl:text>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text> kinderen zijn vooroverleden, te weten:</xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                    </p>
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:for-each select="c:afstammeling[@soort='vooroverledenKind']">
            <table cellspacing="0" cellpadding="0">
                <tbody>
                    <xsl:variable name="vooroverledenKind"
                                  select="$opsommingPersonen/IMKAD_Persoon[@id = substring-after(current()/@xlink:href,'#')]"/>
                    <xsl:variable name="aantalAfstammelingen" select="count(c:afstammeling)"/>
                    <tr>
                        <td class="number">
                            <xsl:number value="@teken"/>
                            <xsl:text>.</xsl:text>
                        </td>
                        <td colspan="2">
                            <xsl:call-template name="tb-NatuurlijkPersoon">
                                <xsl:with-param name="persoon" select="$vooroverledenKind"/>
                                <xsl:with-param name="toonWoonplaats" select="'false'"/>
                            </xsl:call-template>
                            <xsl:text>;</xsl:text>
                        </td>
                    </tr>
                    <xsl:choose>
                        <xsl:when test="$aantalAfstammelingen > 0">
                            <tr>
                                <xsl:choose>
                                    <xsl:when test="$aantalAfstammelingen = 1">
                                        <td class="number"/>
                                        <td colspan="2">
                                            <xsl:text>met achterlating van </xsl:text>
                                            <xsl:value-of select="kef:convertNumberToText($aantalAfstammelingen)"/>
                                            <xsl:text> afstammeling, zijnde:</xsl:text>
                                        </td>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <td class="number"/>
                                        <td colspan="2">
                                            <xsl:text>met achterlating van </xsl:text>
                                            <xsl:value-of select="kef:convertNumberToText($aantalAfstammelingen)"/>
                                            <xsl:text> afstammelingen, zijnde:</xsl:text>
                                        </td>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </tr>
                            <xsl:for-each select="c:afstammeling">
                                <xsl:variable name="afstammeling"
                                              select="$opsommingPersonen/IMKAD_Persoon[@id = substring-after(current()/@xlink:href,'#')]"/>
                                <tr>
                                    <td class="number"/>
                                    <td class="number">
                                        <xsl:number value="@index" format="a"/>
                                        <xsl:text>.</xsl:text>
                                    </td>
                                    <td>
                                        <xsl:call-template name="tb-NatuurlijkPersoon">
                                            <xsl:with-param name="persoon" select="$afstammeling"/>
                                        </xsl:call-template>
                                        <xsl:value-of select="@afsluitTeken"/>
                                    </td>
                                </tr>
                            </xsl:for-each>
                        </xsl:when>
                        <xsl:otherwise>
                            <tr>
                                <td class="number"/>
                                <td colspan="2">
                                    <xsl:text>zonder achterlating van afstammelingen.</xsl:text>
                                </td>
                            </tr>
                        </xsl:otherwise>
                    </xsl:choose>
                </tbody>
            </table>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="c:overigeAfstammelingen" mode="do-overigeAfstammelingen">
        <xsl:param name="partners"/>
        <xsl:variable name="aantalKinderen" select="count($partners/c:partner/c:afstammeling[@soort='kind' or @soort='vooroverledenKind'])"/>
        <xsl:variable name="aantalHuwelijken" select="count($partners/c:partner[@burgerlijkeStaat = 'huwelijk'])"/>
        <xsl:variable name="aantalGP" select="count($partners/c:partner[@burgerlijkeStaat = 'geregistreerd partnerschap'])"/>
        <xsl:variable name="aantalOverigeAfstammelingen" select="count(c:afstammeling)"/>

        <p>
            <xsl:text>Naast voornoemd</xsl:text>
            <xsl:choose>
                <xsl:when test="$aantalKinderen > 1">
                    <xsl:text>e kinderen</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text> kind</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:text> uit voormeld</xsl:text>
            <xsl:if test="$aantalGP + $aantalHuwelijken > 1">
                <xsl:text>e</xsl:text>
            </xsl:if>
            <xsl:choose>
                <xsl:when test="$aantalHuwelijken = 1">
                    <xsl:text> huwelijk</xsl:text>
                </xsl:when>
                <xsl:when test="$aantalHuwelijken > 1">
                    <xsl:text> huwelijken</xsl:text>
                </xsl:when>
            </xsl:choose>
            <xsl:if test="$aantalGP > 0 and $aantalHuwelijken > 0">
                <xsl:text> en</xsl:text>
            </xsl:if>
            <xsl:choose>
                <xsl:when test="$aantalGP = 1">
                    <xsl:text> partnerschap</xsl:text>
                </xsl:when>
                <xsl:when test="$aantalGP > 1">
                    <xsl:text> partnerschappen</xsl:text>
                </xsl:when>
            </xsl:choose>
            <xsl:text> heeft </xsl:text>
            <xsl:value-of select="$overledeneAanduiding"/>
            <xsl:text> voorts als afstammeling</xsl:text>
            <xsl:if test="$aantalOverigeAfstammelingen > 1">
                <xsl:text>en</xsl:text>
            </xsl:if>
            <xsl:text> nagelaten:</xsl:text>
        </p>
        <table cellspacing="0" cellpadding="0">
            <tbody>
                <xsl:apply-templates select="c:afstammeling" mode="afstammeling"/>
            </tbody>
        </table>
    </xsl:template>

    <xsl:template match="c:afstammeling" mode="afstammeling">
        <xsl:variable name="overigAfstammeling" select="$opsommingPersonen/IMKAD_Persoon[@id = substring-after(current()/@xlink:href,'#')]"/>
        <tr>
            <td class="number">
                <xsl:number value="@teken"/>
                <xsl:text>.</xsl:text>
            </td>
            <td>
                <xsl:call-template name="tb-NatuurlijkPersoon">
                    <xsl:with-param name="persoon" select="$overigAfstammeling"/>
                </xsl:call-template>
                <xsl:value-of select="@afsluitTeken"/>
            </td>
        </tr>
    </xsl:template>

<!--    volgende gedeelte wordt een tussen xml gemaakt deze is nodig om dat je in de aanvaarding hier heen wil verwijzen-->

    <xsl:template match="partnerOverledene"  mode="do-tussen-xml">
        <xsl:variable name="burgerlijkeStaat" select="tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_burgerlijkestaat']/tekst"/>
        <c:partner xlink:href="{partnerRef/@xlink:href}" soort="{'partnerOverledene'}" burgerlijkeStaat="{$burgerlijkeStaat}">
            <xsl:apply-templates select="afstammelingen/kindInLevenRef" mode="do-kindInLevenRef"/>
            <xsl:apply-templates select="afstammelingen/vooroverledenKind" mode="do-afstammelingen"/>
        </c:partner>
    </xsl:template>

    <xsl:template match="eerderePartner"  mode="do-tussen-xml">
        <xsl:variable name="burgerlijkeStaat" select="tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_burgerlijkestaat']/tekst"/>
        <c:partner xlink:href="{partnerRef/@xlink:href}" soort="{'eerderePartner'}" burgerlijkeStaat="{$burgerlijkeStaat}">
            <xsl:apply-templates select="afstammelingen/kindInLevenRef" mode="do-kindInLevenRef"/>
            <xsl:apply-templates select="afstammelingen/vooroverledenKind" mode="do-afstammelingen"/>
        </c:partner>
    </xsl:template>

    <xsl:template match="kindInLevenRef" mode="do-kindInLevenRef">
        <xsl:variable name="aantalPreceding" select="count(preceding::kindInLevenRef) + count(preceding::vooroverledenKind) + 1"/>
        <xsl:variable name="laatste" select="count(../kindInLevenRef) = position() and count(../vooroverledenKind) = 0"/>
        <xsl:variable name="afsluitteken">
            <xsl:call-template name="do-afsluitTeken-afstammeling">
                <xsl:with-param name="laatste" select="$laatste"/>
            </xsl:call-template>
        </xsl:variable>

        <xsl:call-template name="do-afstammeling">
            <xsl:with-param name="soort" select="'kind'"/>
            <xsl:with-param name="href" select="@xlink:href"/>
            <xsl:with-param name="teken" select="$aantalPreceding"/>
            <xsl:with-param name="index" select="''"/>
            <xsl:with-param name="afsluitTeken" select="$afsluitteken"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template name="do-afsluitTeken-afstammeling">
        <xsl:param name="laatste"/>
        <xsl:choose>
            <xsl:when test="$laatste">.</xsl:when>
            <xsl:otherwise>;</xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="vooroverledenKind" mode="do-afstammelingen">
        <xsl:variable name="aantalPreceding" select="count(preceding::kindInLevenRef) + count(preceding::vooroverledenKind) + 1"/>
        <xsl:call-template name="do-afstammeling">
            <xsl:with-param name="soort" select="'vooroverledenKind'"/>
            <xsl:with-param name="href" select="vooroverledenKindRef/@xlink:href"/>
            <xsl:with-param name="teken" select="$aantalPreceding"/>
            <xsl:with-param name="index" select="''"/>
            <xsl:with-param name="afsluitTeken" select="';'"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="overigeAfstammelingen" mode="do-tussen-xml">
        <c:overigeAfstammelingen>
            <xsl:apply-templates select="overigeAfstammelingRef" mode="do-tussen-xml"/>
        </c:overigeAfstammelingen>
    </xsl:template>

    <xsl:template match="overigeAfstammelingRef" mode="do-tussen-xml">
        <xsl:variable name="aantalPreceding" select="count(preceding::kindInLevenRef) + count(preceding::vooroverledenKind)"/>
        <xsl:variable name="laatste" select="count(//overigeAfstammelingRef) = position()"/>
        <xsl:variable name="afsluitteken">
            <xsl:call-template name="do-afsluitTeken-afstammeling">
                <xsl:with-param name="laatste" select="$laatste"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:call-template name="do-afstammeling">
            <xsl:with-param name="soort" select="'overigeAfstammeling'"/>
            <xsl:with-param name="href" select="@xlink:href"/>
            <xsl:with-param name="teken" select="position() + $aantalPreceding"/>
            <xsl:with-param name="index" select="''"/>
            <xsl:with-param name="afsluitTeken" select="$afsluitteken"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template name="do-afstammeling">
        <xsl:param name="soort"/>
        <xsl:param name="href"/>
        <xsl:param name="teken"/>
        <xsl:param name="index"/>
        <xsl:param name="afsluitTeken"/>
        <c:afstammeling soort="{$soort}" teken="{$teken}" index="{$index}" xlink:href="{$href}" afsluitTeken="{$afsluitTeken}">
            <xsl:apply-templates select="afstammelingRef" mode="do-afstammelingen">
                <xsl:with-param name="teken" select="$teken"/>
            </xsl:apply-templates>
        </c:afstammeling>
    </xsl:template>

    <xsl:template match="afstammelingRef" mode="do-afstammelingen">
        <xsl:param name="teken"/>
        <xsl:variable name="laatste" select="count(../afstammelingRef) = position()"/>
        <xsl:variable name="afsluitteken">
            <xsl:call-template name="do-afsluitTeken-afstammeling">
                <xsl:with-param name="laatste" select="$laatste"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:call-template name="do-afstammeling">
            <xsl:with-param name="soort" select="'kleinkind'"/>
            <xsl:with-param name="href" select="@xlink:href"/>
            <xsl:with-param name="teken" select="$teken"/>
            <xsl:with-param name="index" select="position()"/>
            <xsl:with-param name="afsluitTeken" select="$afsluitteken"/>
        </xsl:call-template>
    </xsl:template>

</xsl:stylesheet>