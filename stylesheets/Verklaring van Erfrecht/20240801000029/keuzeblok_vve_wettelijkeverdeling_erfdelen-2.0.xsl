<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exslt="http://exslt.org/common" xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:kef="nl.kadaster.xslt.XslExtensionFunctions" exclude-result-prefixes="xsl exslt xlink kef"
                xmlns:c="http://www.kadaster.nl/schemas/AA/tussen"
                version="1.0">

    <xsl:template match="erfdelenGezamenlijk" mode="do-erfgenamen">

        <xsl:variable name="kleinkinderenAanwezig" select="count(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_kleinkind'])>0"/>
        <xsl:variable name="meerDan1Kleinkind" select="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_kleinkind']/tekst,$upper,$lower)= 'kleinkinderen'"/>
        <xsl:variable name="aantalStiefkinderen" select="count(stiefkinderen/stiefkindMetAandeel)"/>
        <xsl:variable name="stiefkinderenAanwezig" select="$aantalStiefkinderen>0"/>

        <h3 class="header">
            <u>
                <u>ERFGENAMEN</u>
            </u>
        </h3>

        <p>
            <xsl:text>Ingevolge de bepalingen van </xsl:text>
            <xsl:value-of select="tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_bepalingen']/tekst"/>
            <xsl:text> heeft de </xsl:text>
            <xsl:value-of select="$overledeneAanduiding"/>
            <xsl:text> als </xsl:text>
            <xsl:value-of select="$zijnHaar"/>
            <xsl:text> enige erfgenamen achtergelaten:</xsl:text>
        </p>
        <table cellspacing="0" cellpadding="0">
            <tbody>
                <tr>
                    <td class="number">
                        <xsl:text>-</xsl:text>
                    </td>
                    <td colspan="2">
                        <xsl:value-of select="$zijnHaar"/>
                        <xsl:if test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_voornoemde']/tekst,$upper, $lower) = 'true'">
                            <xsl:text> voornoemde</xsl:text>
                        </xsl:if>
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="$benamingPartner"/>
                        <xsl:text> en </xsl:text>
                        <xsl:value-of select="$zijnHaar"/>
                        <xsl:text> hiervoor genoemde </xsl:text>
                        <xsl:call-template name="toonTekstKeuzetekst">
                            <xsl:with-param name="tagnaam" select="'k_Kind'"/>
                        </xsl:call-template>
                        <xsl:text>, voor </xsl:text>
                        <xsl:value-of select="gezamenlijkAandeel/teller"/>
                        <xsl:text>/</xsl:text>
                        <xsl:value-of select="gezamenlijkAandeel/noemer"/>
                        <xsl:choose>
                            <xsl:when
                                    test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_iedervoor']/tekst,$upper, $lower) = 'nalatenschap'">
                                <xsl:text> gedeelte van </xsl:text>
                                <xsl:value-of select="$zijnHaar"/>
                                <xsl:text> nalatenschap</xsl:text>
                            </xsl:when>
                            <xsl:when
                                    test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_iedervoor']/tekst,$upper, $lower) = 'aandeel'">
                                <xsl:text> aandeel</xsl:text>
                            </xsl:when>
                        </xsl:choose>
                        <xsl:choose>
                            <xsl:when test="$kleinkinderenAanwezig">
                                <xsl:text>;</xsl:text>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text>.</xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                    </td>
                </tr>
                <xsl:if test="$kleinkinderenAanwezig">
                    <tr>
                        <td class="number">
                            <xsl:text>-</xsl:text>
                        </td>
                        <td colspan="2">
                            <xsl:value-of select="$zijnHaar"/>
                            <xsl:text> hiervoor genoemde </xsl:text>
                            <xsl:call-template name="toonTekstKeuzetekst">
                                <xsl:with-param name="tagnaam" select="'k_kleinKind'"/>
                            </xsl:call-template>
                            <xsl:text>,</xsl:text>
                            <xsl:if test="$meerDan1Kleinkind">
                                <xsl:text> gezamenlijk</xsl:text>
                            </xsl:if>
                            <xsl:text> voor </xsl:text>
                            <xsl:value-of select="gezamenlijkAandeelKleinkinderen/teller"/>
                            <xsl:text>/</xsl:text>
                            <xsl:value-of select="gezamenlijkAandeelKleinkinderen/noemer"/>
                            <xsl:text> gedeelte, </xsl:text>
                            <xsl:if test="$kleinkinderenAanwezig">
                                <xsl:text> derhalve ieder voor </xsl:text>
                                <xsl:value-of select="aandeelPerKleinkind/teller"/>
                                <xsl:text>/</xsl:text>
                                <xsl:value-of select="aandeelPerKleinkind/noemer"/>
                                <xsl:text> gedeelte </xsl:text>
                            </xsl:if>
                            <xsl:text>van </xsl:text>
                            <xsl:value-of select="$zijnHaar"/>
                            <xsl:text> nalatenschap</xsl:text>
                            <xsl:choose>
                                <xsl:when test="$stiefkinderenAanwezig">
                                    <xsl:text>;</xsl:text>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:text>.</xsl:text>
                                </xsl:otherwise>
                            </xsl:choose>
                        </td>
                    </tr>
                </xsl:if>
            </tbody>
        </table>
        <xsl:if test="$stiefkinderenAanwezig">
            <table cellspacing="0" cellpadding="0">
                <tbody>
                    <tr>
                        <td class="number">
                            <xsl:text>-</xsl:text>
                        </td>
                        <td colspan="2">
                            <xsl:value-of select="$zijnHaar"/>
                            <xsl:text> stiefkinderen:</xsl:text>
                        </td>
                    </tr>
                    <xsl:for-each select="stiefkinderen/stiefkindMetAandeel">
                        <xsl:variable name="stiefkindRef" select="persoonRef/@xlink:href"/>
                        <xsl:variable name="stiefkind" select="$opsommingPersonen/IMKAD_Persoon[@id = substring-after($stiefkindRef,'#')]"/>
                        <tr>
                            <td class="number"/>
                            <td class="number">
                                <xsl:number value="position()" format="a"/>
                                <xsl:text>.</xsl:text>
                            </td>
                            <td>
                                <xsl:call-template name="tb-NatuurlijkPersoon">
                                    <xsl:with-param name="persoon" select="$stiefkind"/>
                                </xsl:call-template>
                                <xsl:text>, voor </xsl:text>
                                <xsl:value-of select="aandeel/teller"/>
                                <xsl:text>/</xsl:text>
                                <xsl:value-of select="aandeel/noemer"/>
                                <xsl:text> gedeelte</xsl:text>
                                <xsl:choose>
                                    <xsl:when test="$aantalStiefkinderen = position()">
                                        <xsl:text>.</xsl:text>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:text>;</xsl:text>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </td>
                        </tr>
                    </xsl:for-each>
                </tbody>
            </table>
        </xsl:if>
    </xsl:template>


    <xsl:template match="erfdelenPerPersoon" mode="do-erfgenamen">
        <xsl:variable name="aantalKinderen" select="count($erfdelen/c:erfdeel[@soort = 'kind'])"/>
        <xsl:variable name="aantalKleinkinderen" select="count($erfdelen/c:erfdeel[@soort = 'kleinkind'])"/>
        <xsl:variable name="aantalStiefkinderen" select="count($erfdelen/c:erfdeel[@soort = 'stiefkind'])"/>
        <xsl:variable name="kinderenAanwezig" select="$aantalKinderen>0"/>
        <xsl:variable name="kleinkinderenAanwezig" select="$aantalKleinkinderen>0"/>
        <xsl:variable name="stiefkinderenAanwezig" select="$aantalStiefkinderen>0"/>

        <h3 class="header">
            <u>
                <u>ERFGENAMEN</u>
            </u>
        </h3>
        <p>
            <xsl:text>Op grond van de bepalingen van </xsl:text>
            <xsl:value-of select="tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_bepalingen']/tekst"/>
            <xsl:text> zijn aldus de erfgenamen van de overledene: </xsl:text>
        </p>
        <table cellspacing="0" cellpadding="0">
            <tbody>
                <tr>
                    <xsl:variable name="partner" select="$erfdelen/c:erfdeel[@soort = 'partner'][1]"/>
                    <td class="number">
                        <xsl:text>1</xsl:text>
                        <xsl:text>.</xsl:text>
                    </td>
                    <td colspan="2">
                        <xsl:value-of
                                select="../tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_erflatersechtgenoot']/tekst"/>
                        <xsl:text> voor </xsl:text>
                        <xsl:value-of select="$partner/@teller"/>
                        <xsl:text>/</xsl:text>
                        <xsl:value-of select="$partner/@noemer"/>
                        <xsl:text> aandeel</xsl:text>
                        <xsl:value-of select="$partner/@afsluitTeken"/>
                    </td>
                </tr>
                <xsl:if test="$kinderenAanwezig">
                    <xsl:call-template name="do-kinderen">
                        <xsl:with-param name="personen" select="$erfdelen/c:erfdeel[@soort = 'kind']"/>
                    </xsl:call-template>
                </xsl:if>
                <xsl:if test="$kleinkinderenAanwezig">
                    <xsl:call-template name="do-kinderen">
                        <xsl:with-param name="personen" select="$erfdelen/c:erfdeel[@soort = 'kleinkind']"/>
                    </xsl:call-template>
                </xsl:if>
                <xsl:if test="$stiefkinderenAanwezig">
                    <xsl:call-template name="do-kinderen">
                        <xsl:with-param name="personen" select="$erfdelen/c:erfdeel[@soort = 'stiefkind']"/>
                    </xsl:call-template>
                </xsl:if>
            </tbody>
        </table>
    </xsl:template>

    <xsl:template name="do-kinderen">
        <xsl:param name="personen"/>
        <tr>
            <td class="number">
                <xsl:value-of select="$personen[1]/@teken"/>
                <xsl:text>.</xsl:text>
            </td>
            <td colspan="2">
                <xsl:value-of select="$personen[1]/@soort"/>
                <xsl:if test="count($personen) > 1">
                    <xsl:text>eren</xsl:text>
                </xsl:if>
                <xsl:text>:</xsl:text>
            </td>
        </tr>
        <xsl:for-each select="$personen">
            <xsl:variable name="persoonRef" select="@xlink:href"/>
            <xsl:variable name="kind"
                          select="$opsommingPersonen/IMKAD_Persoon[@id = substring-after($persoonRef,'#')]"/>
            <tr>
                <td class="number"/>
                <td class="number">
                    <xsl:number value="@index" format="a"/>
                    <xsl:text>.</xsl:text>
                </td>
                <td>
                    <xsl:call-template name="tb-NatuurlijkPersoon">
                        <xsl:with-param name="persoon" select="$kind"/>
                        <xsl:with-param name="toonWoonplaats" select="false"/>
                    </xsl:call-template>
                    <xsl:text>, voor het </xsl:text>
                    <xsl:value-of select="@teller"/>
                    <xsl:text>/</xsl:text>
                    <xsl:value-of select="@noemer"/>
                    <xsl:text> aandeel</xsl:text>
                    <xsl:value-of select="@afsluitTeken"/>
                </td>
            </tr>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="erfdelenKindOpsomming">
        <xsl:param name="opsommingIndex"/>
        <xsl:param name="kind"/>
        <xsl:param name="aandeel"/>
        <xsl:param name="afsluitTeken"/>
        <tr>
            <td class="number"/>
            <td class="number">
                <xsl:number value="$opsommingIndex" format="a"/>
                <xsl:text>.</xsl:text>
            </td>
            <td>
                <xsl:call-template name="tb-NatuurlijkPersoon">
                    <xsl:with-param name="persoon" select="$kind"/>
                    <xsl:with-param name="toonWoonplaats" select="false"/>
                </xsl:call-template>
                <xsl:text>, voor het </xsl:text>
                <xsl:value-of select="$aandeel/teller"/>
                <xsl:text>/</xsl:text>
                <xsl:value-of select="$aandeel/noemer"/>
                <xsl:text> aandeel</xsl:text>
                <xsl:value-of select="$afsluitTeken"/>
            </td>
        </tr>
    </xsl:template>




    <xsl:template match="erfdelenPerPersoon" mode="do-tussen-xml">
        <xsl:apply-templates select="partnerMetAandeel"/>
        <xsl:apply-templates select="kinderen/kindMetAandeel"/>
        <xsl:apply-templates select="kleinkinderen/kleinkindMetAandeel"/>
        <xsl:apply-templates select="stiefkinderen/stiefkindMetAandeel"/>
    </xsl:template>

    <xsl:template match="partnerMetAandeel">
        <xsl:variable name="kinderenAanwezig" select="count(//kinderen/kindMetAandeel)>0"/>
        <xsl:variable name="kleinkinderenAanwezig" select="count(//kleinkinderen/kleinkindMetAandeel)>0"/>
        <xsl:variable name="stiefkinderenAanwezig" select="count(//stiefkinderen/kleinkindMetAandeel)>0"/>
        <xsl:variable name="afsluitTeken">
            <xsl:call-template name="do-afsluitTeken-erfdeel">
                <xsl:with-param name="vervolgKinderen" select="$kinderenAanwezig or $kleinkinderenAanwezig or $stiefkinderenAanwezig"/>
                <xsl:with-param name="aantal" select="1"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:call-template name="do-erfdeel">
            <xsl:with-param name="soort" select="'partner'"/>
            <xsl:with-param name="href" select="persoonRef/@xlink:href"/>
            <xsl:with-param name="teller" select="aandeel/teller"/>
            <xsl:with-param name="noemer" select="aandeel/noemer"/>
            <xsl:with-param name="teken" select="1"/>
            <xsl:with-param name="index" select="''"/>
            <xsl:with-param name="afsluitTeken" select="$afsluitTeken"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="kinderen/kindMetAandeel">
        <xsl:variable name="aantalKinderen" select="count(//kinderen/kindMetAandeel)"/>
        <xsl:variable name="kleinkinderenAanwezig" select="count(//kleinkinderen/kleinkindMetAandeel)>0"/>
        <xsl:variable name="stiefkinderenAanwezig" select="count(//stiefkinderen/kleinkindMetAandeel)>0"/>
        <xsl:variable name="afsluitTeken">
            <xsl:call-template name="do-afsluitTeken-erfdeel">
                <xsl:with-param name="vervolgKinderen" select="$kleinkinderenAanwezig or $stiefkinderenAanwezig"/>
                <xsl:with-param name="aantal" select="$aantalKinderen"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:call-template name="do-erfdeel">
            <xsl:with-param name="soort" select="'kind'"/>
            <xsl:with-param name="href" select="persoonRef/@xlink:href"/>
            <xsl:with-param name="teller" select="aandeel/teller"/>
            <xsl:with-param name="noemer" select="aandeel/noemer"/>
            <xsl:with-param name="teken" select="2"/>
            <xsl:with-param name="index" select="position()"/>
            <xsl:with-param name="afsluitTeken" select="$afsluitTeken"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="kleinkinderen/kleinkindMetAandeel">
        <xsl:variable name="aantalkleinKinderen" select="count(//kleinkinderen/kleinkindMetAandeel)"/>
        <xsl:variable name="kinderenAanwezig" select="count(//kinderen/kindMetAandeel)>0"/>
        <xsl:variable name="stiefkinderenAanwezig" select="count(//stiefkinderen/stiefkindMetAandeel)>0"/>
        <xsl:variable name="afsluitTeken">
            <xsl:call-template name="do-afsluitTeken-erfdeel">
                <xsl:with-param name="vervolgKinderen" select="$stiefkinderenAanwezig"/>
                <xsl:with-param name="aantal" select="$aantalkleinKinderen"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:call-template name="do-erfdeel">
            <xsl:with-param name="soort" select="'kleinkind'"/>
            <xsl:with-param name="href" select="persoonRef/@xlink:href"/>
            <xsl:with-param name="teller" select="aandeel/teller"/>
            <xsl:with-param name="noemer" select="aandeel/noemer"/>
            <xsl:with-param name="teken" select="$kinderenAanwezig + 2"/>
            <xsl:with-param name="index" select="position()"/>
            <xsl:with-param name="afsluitTeken" select="$afsluitTeken"/>

        </xsl:call-template>
    </xsl:template>

    <xsl:template match="stiefkinderen/stiefkindMetAandeel">
        <xsl:variable name="aantalStiefKinderen" select="count(//stiefkinderen/stiefkindMetAandeel)"/>
        <xsl:variable name="kinderenAanwezig" select="count(//kinderen/kindMetAandeel)>0"/>
        <xsl:variable name="kleinkinderenAanwezig" select="count(//kleinkinderen/kleinkindMetAandeel)>0"/>
        <xsl:variable name="afsluitTeken">
            <xsl:call-template name="do-afsluitTeken-erfdeel">
                <xsl:with-param name="vervolgKinderen" select="0"/>
                <xsl:with-param name="aantal" select="$aantalStiefKinderen"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:call-template name="do-erfdeel">
            <xsl:with-param name="soort" select="'stiefkind'"/>
            <xsl:with-param name="href" select="persoonRef/@xlink:href"/>
            <xsl:with-param name="teller" select="aandeel/teller"/>
            <xsl:with-param name="noemer" select="aandeel/noemer"/>
            <xsl:with-param name="teken" select="$kinderenAanwezig + $kleinkinderenAanwezig + 2"/>
            <xsl:with-param name="index" select="position()"/>
            <xsl:with-param name="afsluitTeken" select="$afsluitTeken"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template name="do-afsluitTeken-erfdeel">
        <xsl:param name="aantal"/>
        <xsl:param name="vervolgKinderen"/>
        <xsl:choose>
            <xsl:when test="$vervolgKinderen">;</xsl:when>
            <xsl:when test="position() = $aantal">.</xsl:when>
            <xsl:otherwise>;</xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="do-erfdeel">
        <xsl:param name="teken"/>
        <xsl:param name="index"/>
        <xsl:param name="soort"/>
        <xsl:param name="teller"/>
        <xsl:param name="noemer"/>
        <xsl:param name="href"/>
        <xsl:param name="afsluitTeken"/>
        <c:erfdeel soort="{$soort}" teken="{$teken}" index="{$index}" teller="{$teller}"
                   noemer="{$noemer}" xlink:href="{$href}" afsluitTeken="{$afsluitTeken}"/>
    </xsl:template>

</xsl:stylesheet>
