<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exslt="http://exslt.org/common"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:c="http://www.kadaster.nl/schemas/AA/tussen"
                xmlns:kef="nl.kadaster.xslt.XslExtensionFunctions"
                version="1.0">
    <xsl:template match="aanvaardingen">
        <xsl:apply-templates select="zuivereAanvaarding"/>
        <xsl:apply-templates select="zuivereAanvaardingMetOnderhandseVerklaring"/>
        <xsl:apply-templates select="beneficiaireBoedelbeschrijving"/>
        <xsl:apply-templates select="beneficiaireMinderJarigKeuze1"/>
        <xsl:apply-templates select="beneficiaireMinderJarigKeuze2"/>
        <xsl:apply-templates select="beneficiaireCuratele"/>
        <xsl:apply-templates select="beneficiaireOnderBewind"/>
    </xsl:template>

    <xsl:template match="zuivereAanvaarding">
        <xsl:call-template name="do-header">
            <xsl:with-param name="header" select="'ZUIVERE AANVAARDING'"/>
        </xsl:call-template>
        <p>
            <xsl:value-of select="$blijkens_up"/>
            <xsl:text> de </xsl:text>
            <xsl:call-template name="toonTekstWanneerKeuzetekstIsTrue">
                <xsl:with-param name="tekst" select="'aan deze akte gehechte '"/>
                <xsl:with-param name="tagnaam" select="'k_AkteGehecht'"/>
            </xsl:call-template>
            <xsl:text>verklaringen hebben </xsl:text>
            <xsl:call-template name="toonTekstWanneerKeuzetekstIsTrue">
                <xsl:with-param name="tekst" select="'voornoemde '"/>
                <xsl:with-param name="tagnaam" select="'k_Voornoemd'"/>
            </xsl:call-template>
            <xsl:call-template name="toonTekstKeuzetekst">
                <xsl:with-param name="tagnaam" select="'k_Partner'"/>
            </xsl:call-template>
            <xsl:text> en </xsl:text>
            <xsl:value-of select="$zijnHaar"/>
            <xsl:text> hiervoor </xsl:text>
            <xsl:call-template name="toonTekstWanneerKeuzetekstIsTrue">
                <xsl:with-param name="tekst" select="'onder ERFGENAMEN '"/>
                <xsl:with-param name="tagnaam" select="'k_KopjeErfgenamen'"/>
            </xsl:call-template>
            <xsl:apply-templates select="subs" mode="do-erfgenamen"/>
            <xsl:text> genoemde </xsl:text>
            <xsl:call-template name="toonTekstKeuzetekst">
                <xsl:with-param name="tagnaam" select="'k_Erfgenamen'"/>
            </xsl:call-template>
            <xsl:text> de nalatenschap zuiver aanvaard.</xsl:text>
        </p>
    </xsl:template>

    <xsl:template match="zuivereAanvaardingMetOnderhandseVerklaring">
        <xsl:call-template name="do-header">
                <xsl:with-param name="header" select="'ZUIVERE AANVAARDING'"/>
        </xsl:call-template>
        <p>
            <xsl:text>De nalatenschap van de </xsl:text>
            <xsl:value-of select="$overledeneAanduiding"/>
            <xsl:text> is door </xsl:text>
            <xsl:call-template name="toonTekstWanneerKeuzetekstIsTrue">
                <xsl:with-param name="tekst" select="'voornoemde '"/>
                <xsl:with-param name="tagnaam" select="'k_Voornoemd'"/>
            </xsl:call-template>
            <xsl:call-template name="toonTekstKeuzetekst">
                <xsl:with-param name="tagnaam" select="'k_Partner'"/>
            </xsl:call-template>
            <xsl:text> en </xsl:text>
            <xsl:value-of select="$zijnHaar"/>
            <xsl:text> hiervoor </xsl:text>
            <xsl:call-template name="toonTekstWanneerKeuzetekstIsTrue">
                <xsl:with-param name="tekst" select="'onder ERFGENAMEN '"/>
                <xsl:with-param name="tagnaam" select="'k_KopjeErfgenamen'"/>
            </xsl:call-template>
            <xsl:apply-templates select="subs" mode="do-erfgenamen"/>
            <xsl:text> genoemde </xsl:text>
            <xsl:call-template name="toonTekstKeuzetekst">
                <xsl:with-param name="tagnaam" select="'k_Erfgenamen'"/>
            </xsl:call-template>
            <xsl:text> zuiver aanvaard. Van deze zuivere aanvaarding blijkt uit </xsl:text>
            <xsl:value-of select="kef:convertNumberToText(aantalVerklaringen)"/>
            <xsl:text> onderhandse verklaringen van zuivere aanvaarding</xsl:text>
            <xsl:call-template name="toonTekstWanneerKeuzetekstIsTrue">
                <xsl:with-param name="tekst" select="' die aan deze akte zullen worden gehecht'"/>
                <xsl:with-param name="tagnaam" select="'k_Aktegehecht'"/>
            </xsl:call-template>
            <xsl:text>.</xsl:text>
        </p>
    </xsl:template>

    <xsl:template match="beneficiaireBoedelbeschrijving">
        <xsl:call-template name="do-header">
            <xsl:with-param name="header" select="'BENEFICIAIRE AANVAARDING'"/>
        </xsl:call-template>
        <p>
            <xsl:text>De nalatenschap van de </xsl:text>
            <xsl:value-of select="$overledeneAanduiding"/>
            <xsl:text> is door de hiervoor </xsl:text>
            <xsl:call-template name="toonTekstWanneerKeuzetekstIsTrue">
                <xsl:with-param name="tekst" select="'onder ERFGENAMEN '"/>
                <xsl:with-param name="tagnaam" select="'k_KopjeErfgenamen'"/>
            </xsl:call-template>
            <xsl:apply-templates select="subs" mode="do-erfgenamen"/>
            <xsl:text> genoemde </xsl:text>
            <xsl:call-template name="toonTekstKeuzetekst">
                <xsl:with-param name="tagnaam" select="'k_Erfgenamen'"/>
            </xsl:call-template>
            <xsl:text> aanvaard onder het voorrecht van boedelbeschrijving, </xsl:text>
            <xsl:value-of select="$blijkens_low"/>
            <xsl:text> een akte op </xsl:text>
            <xsl:value-of select="kef:convertDateToText(datumAkte)"/>
            <xsl:text> opgemaakt ter griffie van de Rechtbank </xsl:text>
            <xsl:value-of select="naamPlaatsRechtbank"/>
            <xsl:text>, akte registernummer </xsl:text>
            <xsl:value-of select="registernummer"/>
            <xsl:text>. Een afschrift van die verklaring is ingeschreven in het boedelregister van voormelde Rechtbank.</xsl:text>
        </p>
    </xsl:template>

    <xsl:template match="beneficiaireMinderJarigKeuze1">
        <xsl:call-template name="do-header">
            <xsl:with-param name="header" select="'BENEFICIAIRE AANVAARDING'"/>
        </xsl:call-template>
        <p>
            <xsl:text>De nalatenschap van de </xsl:text>
            <xsl:value-of select="$overledeneAanduiding"/>
            <xsl:text> is door de wettelijke vertegenwoordiger namens de hiervoor </xsl:text>
            <xsl:call-template name="toonTekstWanneerKeuzetekstIsTrue">
                <xsl:with-param name="tekst" select="'onder ERFGENAMEN '"/>
                <xsl:with-param name="tagnaam" select="'k_KopjeErfgenamen'"/>
            </xsl:call-template>
            <xsl:text> genoemde </xsl:text>
            <xsl:call-template name="toonTekstKeuzetekst">
                <xsl:with-param name="tagnaam" select="'k_Minderjarigen'"/>
            </xsl:call-template>
            <xsl:text> aanvaard onder het voorrecht van boedelbeschrijving, </xsl:text>
            <xsl:value-of select="$blijkens_low"/>
            <xsl:text> uit een akte op </xsl:text>
            <xsl:value-of select="kef:convertDateToText(datumAkte)"/>
            <xsl:text> opgemaakt ter griffie van de Rechtbank te </xsl:text>
            <xsl:value-of select="naamPlaatsRechtbank"/>
            <xsl:text>, akte registernummer </xsl:text>
            <xsl:value-of select="registernummer"/>
            <xsl:text>. Een afschrift van die verklaring is ingeschreven in het boedelregister van voormelde Rechtbank.</xsl:text>
        </p>
    </xsl:template>

    <xsl:template match="beneficiaireMinderJarigKeuze2">
        <xsl:call-template name="do-header">
            <xsl:with-param name="header" select="'BENEFICIAIRE AANVAARDING'"/>
        </xsl:call-template>
        <p>
            <xsl:text>Namens </xsl:text>
            <xsl:call-template name="kiesTekstbijWaardeKeuzetekst">
                <xsl:with-param name="tekst1" select="'de minderjarige kinderen is op '"/>
                <xsl:with-param name="tekst2" select="'het minderjarig kind is op '"/>
                <xsl:with-param name="tagnaam" select="'k_Minderjarigen'"/>
                <xsl:with-param name="waarde" select="'minderjarigen'"/>
            </xsl:call-template>
            <xsl:value-of select="kef:convertDateToText(datumVerklaring)"/>
            <xsl:text> bij de griffie van de Rechtbank </xsl:text>
            <xsl:value-of select="naamPlaatsRechtbank"/>
            <xsl:text> (zaaknummer </xsl:text>
            <xsl:value-of select="zaaknummer"/>
            <xsl:text>) de verklaring afgelegd dat de nalatenschap ten behoeve van de </xsl:text>
            <xsl:call-template name="toonTekstKeuzetekst">
                <xsl:with-param name="tagnaam" select="'k_Minderjarigen'"/>
            </xsl:call-template>
            <xsl:text> is aanvaard onder het voorrecht van boedelbeschrijving.</xsl:text>
        </p>
    </xsl:template>

    <xsl:template match="beneficiaireCuratele">
        <xsl:call-template name="do-header">
            <xsl:with-param name="header" select="'BENEFICIAIRE AANVAARDING'"/>
        </xsl:call-template>
        <xsl:variable name="partnerRef" select="partnerRef/@xlink:href"/>
        <xsl:variable name="partner" select="$opsommingPersonen/IMKAD_Persoon[@id = substring-after($partnerRef,'#')]"/>
        <xsl:variable name="curatorRef" select="curatorRef/@xlink:href"/>
        <xsl:variable name="curator" select="$opsommingPersonen/IMKAD_Persoon[@id = substring-after($curatorRef,'#')]"/>
        <p>
            <xsl:value-of select="$blijkens_up"/>
            <xsl:text> een beschikking van de rechtbank, is </xsl:text>
            <xsl:apply-templates select="$partner/gegevens/GBA_Ingezetene" mode="do-gender-salutation"/>
            <xsl:text> </xsl:text>
            <xsl:apply-templates select="$partner/gegevens/GBA_Ingezetene" mode="do-natural-person-personal-data"/>
            <xsl:call-template name="toonTekstWanneerKeuzetekstIsTrue">
                <xsl:with-param name="tekst" select="', voornoemd'"/>
                <xsl:with-param name="tagnaam" select="'k_Voornoemd'"/>
            </xsl:call-template>
              <xsl:text>, onder curatele gesteld. Tot curator is benoemd: </xsl:text>
            <xsl:call-template name="tb-NatuurlijkPersoon">
                <xsl:with-param name="persoon" select="$curator"/>
            </xsl:call-template>
            <xsl:text>. De curator heeft namens de onder curatele gestelde de nalatenschap van de overledene aanvaard onder het voorrecht van boedelbeschrijving. Hiervan blijkt uit een verklaring afgelegd op </xsl:text>
            <xsl:value-of select="kef:convertDateToText(datumVerklaring)"/>
            <xsl:text> bij de griffie van de Rechtbank </xsl:text>
            <xsl:value-of select="naamPlaatsRechtbank"/>
            <xsl:text> (zaaknummer </xsl:text>
            <xsl:value-of select="zaaknummer"/>
            <xsl:text>).</xsl:text>
        </p>
    </xsl:template>

    <xsl:template match="beneficiaireOnderBewind">
        <xsl:call-template name="do-header">
            <xsl:with-param name="header" select="'BENEFICIAIRE AANVAARDING'"/>
        </xsl:call-template>
        <xsl:variable name="bewindvoerderRef" select="bewindvoerderRef/@xlink:href"/>
        <xsl:variable name="bewindvoerder" select="$opsommingPersonen/IMKAD_Persoon[@id = substring-after($bewindvoerderRef,'#')]"/>
        <p>
            <xsl:value-of select="$blijkens_up"/>
            <xsl:text> een beschikking van de rechtbank </xsl:text>
            <xsl:value-of select="naamPlaatsRechtbank"/>
            <xsl:text>, is er een bewind ingesteld over de goederen die (zullen gaan) toebehoren aan de hiervoor onder </xsl:text>
            <xsl:call-template name="toonTekstKeuzetekstUpper">
                <xsl:with-param name="tagnaam" select="'k_AfstammelingenErfgenamen'"/>
            </xsl:call-template>

            <xsl:call-template name="kiesErfgenaamOfAfstammeling"/>

            <xsl:text> genoemde </xsl:text>
            <xsl:call-template name="toonTekstKeuzetekst">
                <xsl:with-param name="tagnaam" select="'k_Erfgenamen'"/>
            </xsl:call-template>
            <xsl:text>. Tot bewindvoerder is benoemd </xsl:text>
            <xsl:call-template name="tb-NatuurlijkPersoon">
                <xsl:with-param name="persoon" select="$bewindvoerder"/>
            </xsl:call-template>
            <xsl:text>. De bewindvoerder heeft namens de gemelde </xsl:text>
            <xsl:call-template name="toonTekstKeuzetekst">
                <xsl:with-param name="tagnaam" select="'k_Erfgenamen'"/>
            </xsl:call-template>
            <xsl:text> de nalatenschap van de overledene aanvaard onder het voorrecht van boedelbeschrijving. Hiervan blijkt uit </xsl:text>
            <xsl:value-of select="kef:convertNumberToText(aantalVerklaringen)"/>
            <xsl:text> verklaring</xsl:text>
            <xsl:if test="aantalVerklaringen > 1">
                <xsl:text>en</xsl:text>
            </xsl:if>
            <xsl:text>, afgelegd op </xsl:text>
            <xsl:value-of select="kef:convertDateToText(datumVerklaring)"/>
            <xsl:text> bij de griffie van de Rechtbank </xsl:text>
            <xsl:value-of select="naamPlaatsRechtbankVerklaring"/>
            <xsl:text> (zaaknummer</xsl:text>
            <xsl:value-of select="zaaknummer"/>
            <xsl:text>).</xsl:text>
        </p>
    </xsl:template>

    <xsl:template name="kiesTekstbijWaardeKeuzetekst">
        <xsl:param name="tekst1"/>
        <xsl:param name="tekst2"/>
        <xsl:param name="tagnaam"/>
        <xsl:param name="waarde"/>
        <xsl:choose>
            <xsl:when test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = translate($tagnaam, $upper, $lower)]/tekst,$upper,$lower) = $waarde ">
                <xsl:value-of select="$tekst1"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$tekst2"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="do-header">
        <xsl:param name="header"/>
        <h3 class="header">
            <u>
                <xsl:value-of select="$header"/>
            </u>
        </h3>
    </xsl:template>

    <xsl:template name="toonTekstWanneerKeuzetekstIsTrue">
        <xsl:param name="tekst"/>
        <xsl:param name="tagnaam"/>
        <xsl:if test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = translate($tagnaam, $upper, $lower)]/tekst,$upper,$lower) = 'true'">
            <xsl:value-of select="$tekst"/>
        </xsl:if>
    </xsl:template>

    <xsl:template name="toonTekstKeuzetekst">
        <xsl:param name="tagnaam"/>
        <xsl:value-of
                select="tekstkeuze[translate(tagNaam, $upper, $lower) = translate($tagnaam, $upper, $lower)]/tekst"/>
    </xsl:template>

    <xsl:template name="toonTekstKeuzetekstUpper">
        <xsl:param name="tagnaam"/>
        <xsl:value-of
                select="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = translate($tagnaam, $upper, $lower)]/tekst, $lower, $upper)"/>
    </xsl:template>


    <xsl:template name="kiesErfgenaamOfAfstammeling">
        <xsl:choose>
            <xsl:when
                    test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = translate('k_AfstammelingenErfgenamen', $upper, $lower)]/tekst,$upper,$lower) = 'erfgenamen'">
                <xsl:apply-templates select="subs" mode="do-erfgenamen"/>
            </xsl:when>
            <xsl:when
                    test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = translate('k_AfstammelingenErfgenamen', $upper, $lower)]/tekst,$upper,$lower) = 'afstammelingen'">
                <xsl:apply-templates select="subs" mode="do-afstammelingen"/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>


    <xsl:template match="subs" mode="do-erfgenamen">
        <xsl:text> sub </xsl:text>
        <xsl:variable name="aantal" select="count(./persoonRef)"/>
        <xsl:for-each select="./persoonRef">
            <xsl:variable name="persoonRef" select="@xlink:href"/>
            <xsl:variable name="sub" select="$erfdelen/c:erfdeel[@xlink:href = $persoonRef]"/>
            <xsl:call-template name="do-sub">
                <xsl:with-param name="sub" select="$sub"/>
                <xsl:with-param name="aantal" select="$aantal"/>
            </xsl:call-template>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="subs" mode="do-afstammelingen">
        <xsl:text> sub </xsl:text>
        <xsl:variable name="aantal" select="count(./persoonRef)"/>
        <xsl:for-each select="./persoonRef">
            <xsl:variable name="persoonRef" select="@xlink:href"/>
            <xsl:variable name="sub" select="$afstammelingen/descendant::c:afstammeling[@xlink:href = $persoonRef]"/>
            <xsl:call-template name="do-sub">
                <xsl:with-param name="sub" select="$sub"/>
                <xsl:with-param name="aantal" select="$aantal"/>
            </xsl:call-template>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="do-sub">
        <xsl:param name="sub"/>
        <xsl:param name="aantal"/>
        <xsl:value-of select="$sub/@teken"/>
        <xsl:if test="not(string(number($sub/@index))='NaN')">
            <xsl:number value="$sub/@index" format="a"/>
        </xsl:if>
        <xsl:choose>
            <xsl:when test="position() = $aantal"> </xsl:when>
            <xsl:when test="position() = $aantal - 1"> en </xsl:when>
            <xsl:otherwise>, </xsl:otherwise>
        </xsl:choose>
    </xsl:template>



</xsl:stylesheet>
