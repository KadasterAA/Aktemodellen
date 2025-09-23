<?xml version="1.0" encoding="UTF-8"?>
<!--
*************************************************************
Stylesheet: hypotheek_aegon.xsl
Version: 9.0
- [AA-8572] Aegon model - tekstuele aanpassing
*************************************************************

Description:
Aegon hypotheek.

Public:
(mode) do-deed
-->
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:tia="http://www.kadaster.nl/schemas/KIK/TIA_Algemeen" xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:kef="nl.kadaster.xslt.XslExtensionFunctions" xmlns:exslt="http://exslt.org/common" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:gc="http://docs.oasis-open.org/codelist/ns/genericode/1.0/" exclude-result-prefixes="tia xsl xlink kef gc" version="1.0">
    <xsl:include href="generiek-1.08.xsl"/>
    <xsl:include href="tekstblok_aanhef-1.20.xsl"/>
    <xsl:include href="tekstblok_burgerlijke_staat-2.0.xsl"/>
    <xsl:include href="tekstblok_equivalentieverklaring-1.30.xsl"/>
    <xsl:include href="tekstblok_gevolmachtigde-2.00.xsl"/>
    <xsl:include href="tekstblok_natuurlijk_persoon-2.0.xsl"/>
    <xsl:include href="tekstblok_partij_natuurlijk_persoon-2.0.xsl"/>
    <xsl:include href="tekstblok_partij_niet_natuurlijk_persoon-2.0.xsl"/>
    <xsl:include href="keuzeblok_partijnamen_in_hypotheekakten_aegon-1.0.xsl"/>
    <xsl:include href="tekstblok_personalia_van_natuurlijk_persoon-1.06.xsl"/>
    <xsl:include href="tekstblok_recht-1.17.xsl"/>
    <xsl:include href="tekstblok_rechtspersoon-1.16.0.xsl"/>
    <xsl:include href="tekstblok_registergoed-1.29.xsl"/>
    <xsl:include href="tekstblok_titel_hypotheekakten-1.02.xsl"/>
    <xsl:include href="tekstblok_woonadres-1.05.xsl"/>
    <xsl:include href="tweededeel-1.05.xsl"/>
    <xsl:variable name="keuzeteksten" select="document('keuzeteksten_hypotheek_aegon-7.0.0.xml')"/>
    <xsl:variable name="keuzetekstenTbBurgelijkeStaat" select="document('keuzeteksten-tb-burgerlijkestaat-2.0.xml')"/>
    <xsl:variable name="legalPersonNames" select="document('nnp-kodes.xml')/gc:CodeList/SimpleCodeList/Row"/>
    <xsl:variable name="RegistergoedTonenPerPerceel">
        <!-- t.b.v. TB Registergoed -->
        <xsl:choose>
            <xsl:when test="tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedtonenperperceel']">
                <xsl:value-of
                        select="translate(tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_registergoedtonenperperceel']/tia:tekst, $upper, $lower)"/>
            </xsl:when>
            <xsl:otherwise>false</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <xsl:variable name="verkrijgerPartij"
                  select="//tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:Partij[@id = substring-after(//tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:verkrijgerRechtRef/@xlink:href, '#')]"/>
    <xsl:variable name="naamGeldverstrekker" select="$verkrijgerPartij/tia:IMKAD_Persoon/tia:tia_Gegevens/tia:NHR_Rechtspersoon/tia:statutaireNaam"/>


    <!--
    *********************************************************
    Mode: do-deed
    *********************************************************
    Public: yes

    Identity transform: no

    Description: munt mortgage deed.

    Input: tia:Bericht_TIA_Stuk

    Params: none

    Output: XHTML structure

    Calls:
    (mode) do-statement-of-equivalence
    (mode) do-header
    (mode) do-comparitie
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
        <!-- Text block Statement of equivalence -->
        <xsl:if test="translate($type-document, $upper, $lower) = 'afschrift'">
            <a name="hyp3.statementOfEquivalence" class="location">&#160;</a>
            <xsl:apply-templates select="tia:IMKAD_AangebodenStuk" mode="do-statement-of-equivalence"/>
            <!-- Two empty lines after Statement of equivalence -->
            <p>
                <br/>
            </p>
            <p>
                <br/>
            </p>
        </xsl:if>
        <a name="hyp3.header" class="location">&#160;</a>
        <!-- (Titel) Text block Mortgage deed title -->
        <xsl:apply-templates select="tia:IMKAD_AangebodenStuk" mode="do-mortgage-deed-title"/>
        <!-- (Aanhef) Text block Header -->
        <xsl:apply-templates select="tia:IMKAD_AangebodenStuk" mode="do-header"/>
        <xsl:apply-templates select="tia:IMKAD_AangebodenStuk/tia:Partij" mode="do-partij"/>
        <p>
            <xsl:text>De comparanten verklaarden als volgt:</xsl:text>
        </p>
        <table cellspacing="0" cellpadding="0">
            <tbody>
                <tr>
                    <td class="number" valign="top">
                        <xsl:text></xsl:text>
                    </td>
                    <td class="number" valign="top">
                        <table cellspacing="0" cellpadding="0">
                            <tbody>
                                <tr>
                                    <td class="number" valign="top">
                                        <xsl:text>-</xsl:text>
                                    </td>
                                    <td>
                                        <xsl:text>Aegon en de Schuldenaar zijn een overeenkomst van geldlening aangegaan, hierna te noemen: de “Overeenkomst van geldlening”, van welke overeenkomst blijkt uit een door Aegon uitgebracht en door de Schuldenaar geaccepteerd Bindend aanbod. Een afschrift van het door Aegon en Schuldenaar ondertekende Bindend aanbod wordt aan deze akte gehecht.</xsl:text>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td class="number" valign="top">
                        <xsl:text></xsl:text>
                    </td>
                    <td class="number" valign="top">
                        <table cellspacing="0" cellpadding="0">
                            <tbody>
                                <tr>
                                    <td class="number" valign="top">
                                        <xsl:text>-</xsl:text>
                                    </td>
                                    <td>
                                        <xsl:text>Blijkens de Overeenkomst van geldlening verstrekt Aegon aan de Schuldenaar een geldlening voor het hierna te noemen bedrag en is de Schuldenaar verplicht aan Aegon de in deze akte omschreven rechten van hypotheek en pand te (doen) verlenen op de wijze en onder de bepalingen en voorwaarden als uiteengezet in deze akte.</xsl:text>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td class="number" valign="top">
                        <xsl:text></xsl:text>
                    </td>
                    <td class="number" valign="top">
                        <table cellspacing="0" cellpadding="0">
                            <tbody>
                                <tr>
                                    <td class="number" valign="top">
                                        <xsl:text>-</xsl:text>
                                    </td>
                                    <td>
                                        <xsl:text>Partijen zijn derhalve het navolgende overeengekomen.</xsl:text>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                </tr>
            </tbody>
        </table>
        <table cellspacing="0" cellpadding="0">
            <tbody>
                <tr>
                    <td class="number" valign="top">
                        <b>
                            <xsl:text>A.</xsl:text>
                        </b>
                    </td>
                    <td>
                        <b>
                            <xsl:text>GELDLENING</xsl:text>
                        </b>
                    </td>
                </tr>
                <tr>
                    <td class="number" valign="top">
                        <xsl:text></xsl:text>
                    </td>
                    <td>
                        <table cellspacing="0" cellpadding="0">
                            <tbody>
                                <tr>
                                    <td class="number" valign="top">
                                        <b>
                                            <xsl:text>2.</xsl:text>
                                        </b>
                                    </td>
                                    <td>
                                        <p>
                                            <b>
                                                <xsl:text>Lening</xsl:text>
                                            </b>
                                            <br/>
                                            <xsl:text>De Schuldenaar verklaarde wegens van Aegon ter leen ontvangen gelden hoofdelijk schuldig te zijn aan Aegon een bedrag van: </xsl:text>
                                            <xsl:call-template name="amountText">
                                                <xsl:with-param name="amount"
                                                                select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragLening/tia:som"/>
                                                <xsl:with-param name="valuta"
                                                                select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragLening/tia:valuta"/>
                                            </xsl:call-template>
                                            <xsl:text> </xsl:text>
                                            <xsl:call-template name="amountNumber">
                                                <xsl:with-param name="amount"
                                                                select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragLening/tia:som"/>
                                                <xsl:with-param name="valuta"
                                                                select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragLening/tia:valuta"/>
                                            </xsl:call-template>
                                            <xsl:text>, (hierna te noemen: de "Lening"). </xsl:text>
                                            <br/>
                                            <xsl:text>Aegon verklaarde de hiervoor vermelde schuldbekentenis te aanvaarden.</xsl:text>
                                            <xsl:if test="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[translate(tia:aanduidingHypotheek, $upper, $lower) = 'overbruggingshypotheek']">
                                                <br/>
                                                <b>
                                                    <xsl:text>Overbruggingskrediet</xsl:text>
                                                </b>
                                                <br/>
                                                <xsl:text>De Schuldenaar verklaarde tevens wegens van Aegon ter leen ontvangen gelden hoofdelijk schuldig te zijn aan Aegon een bedrag van: </xsl:text>
                                                <xsl:call-template name="amountText">
                                                    <xsl:with-param name="amount"
                                                                    select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[translate(tia:aanduidingHypotheek, $upper, $lower) = 'overbruggingshypotheek']/tia:bedragLening/tia:som"/>
                                                    <xsl:with-param name="valuta"
                                                                    select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[translate(tia:aanduidingHypotheek, $upper, $lower) = 'overbruggingshypotheek']/tia:bedragLening/tia:valuta"/>
                                                </xsl:call-template>
                                                <xsl:text> </xsl:text>
                                                <xsl:call-template name="amountNumber">
                                                    <xsl:with-param name="amount"
                                                                    select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[translate(tia:aanduidingHypotheek, $upper, $lower) = 'overbruggingshypotheek']/tia:bedragLening/tia:som"/>
                                                    <xsl:with-param name="valuta"
                                                                    select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[translate(tia:aanduidingHypotheek, $upper, $lower) = 'overbruggingshypotheek']/tia:bedragLening/tia:valuta"/>
                                                </xsl:call-template>
                                                <xsl:text>, (hierna te noemen: "Overbruggingskrediet").</xsl:text>
                                                <br/>
                                                <xsl:text>Aegon verklaarde de hiervoor vermelde schuldbekentenis te aanvaarden.</xsl:text>
                                            </xsl:if>
                                            <br/>
                                            <xsl:text>De Schuldenaar is met Aegon overeengekomen en heeft zich jegens Aegon verbonden - en, voor zover nodig verklaart hierbij met Aegon overeen te komen en zich te verbinden - tot het vestigen van het recht van hypotheek op het (de) hierna te omschrijven registergoed(eren) en tot het vestigen of, al naar gelang de omstandigheden, tot het bij voorbaat vestigen van pandrecht op hierna te omschrijven roerende zaken, rechten, vorderingen, effecten en vruchten, tot zekerheid voor de betaling van de Lening</xsl:text>
                                            <xsl:if test="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[translate(tia:aanduidingHypotheek, $upper, $lower) = 'overbruggingshypotheek']">
                                                <xsl:text> en Overbruggingskrediet</xsl:text>
                                            </xsl:if>
                                            <xsl:text>.</xsl:text>
                                            <br/>
                                            <b>
                                                <xsl:text>Aanvullende geldlening</xsl:text>
                                            </b>
                                            <br/>
                                            <xsl:text>De Schuldenaar en Aegon kunnen overeenkomen dat door Aegon aan de Schuldenaar een aanvullende geldlening wordt verstrekt, hierna te noemen: “de aanvullende geldlening”. Een aanvullende geldlening wordt alleen verstrekt voor zover het op grond van de voormelde overeenkomst van geldlening en eventuele aanvullende geldlening(en) uitstaande bedrag lager is dan het hierna onder Hypotheekstelling Lening (4), sub (A) genoemde bedrag en indien aan de op dat moment geldende acceptatiecriteria wordt voldaan.</xsl:text>
                                        </p>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="number" valign="top">
                                        <b>
                                            <xsl:text>3.</xsl:text>
                                        </b>
                                    </td>
                                    <td>

                                        <b>
                                            <xsl:text>Gegevens van de Geldlening</xsl:text>
                                        </b>
                                        <br/>
                                        <u>
                                            <xsl:text>Looptijd en aflossing </xsl:text>
                                        </u>
                                        <br/>
                                        <xsl:text>De Lening heeft een looptijd zoals in de Overeenkomst van geldlening is overeengekomen, dan wel eventueel nader tussen partijen (zal worden) overeengekomen. De terugbetaling van de Lening vindt plaats op de wijze als bepaald in de aan deze akte gehechte Bindend aanbod, en de Algemene Voorwaarden welke zijn gehecht aan het Bindend aanbod, en / of op een nader door partijen overeen te komen wijze.</xsl:text>
                                        <br/>
                                        <u>
                                            <xsl:text>Rente</xsl:text>
                                        </u>
                                        <br/>
                                        <xsl:text>De Schuldenaar is rente over de Lening tegen het in de Overeenkomst van geldlening overeengekomen rentepercentage verschuldigd. De voor het eerst te betalen rente wordt berekend vanaf de datum waarop Aegon het bedrag van de Lening ter beschikking heeft gesteld aan de Schuldenaar tot de laatste dag van de desbetreffende maand. Voor iedere volgende maand wordt de door de Schuldenaar te betalen rente berekend over het Uitstaande Bedrag per het einde van de daaraan voorafgaande maand.</xsl:text>
                                        <br/>
                                        <u>
                                            <xsl:text>Algemene Voorwaarden</xsl:text>
                                        </u>
                                        <br/>
                                        <xsl:text>Op de Overeenkomst van geldlening en op deze akte en de daarbij te verstrekken rechten van hypotheek en pand zijn van toepassing de Algemene Voorwaarden. De Algemene Voorwaarden worden geacht een onderdeel te zijn van de Overeenkomst van geldlening en deze akte als waren zij in de Overeenkomst van geldlening en deze akte woordelijk opgenomen. Als de bepalingen in deze akte afwijken van de Algemene Voorwaarden dan hebben de bepalingen in deze akte voorrang. De (Derde) Hypotheekgever verklaart een exemplaar van de Algemene Voorwaarden te hebben ontvangen, daarvan kennis te hebben genomen en daarmee in te stemmen.</xsl:text>
                                        <br/>
                                        <u>
                                            <xsl:text>Begrippen</xsl:text>
                                        </u>
                                        <br/>
                                        <xsl:text>Begrippen die in deze akte worden gebruikt, hebben de betekenis die daaraan is toegekend in de Algemene Voorwaarden, tenzij in deze akte anders is bepaald of uit de strekking van deze akte het tegendeel voortvloeit.</xsl:text>
                                        <xsl:if test="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[translate(tia:aanduidingHypotheek, $upper, $lower) = 'overbruggingshypotheek']">
                                            <br/>
                                            <u>
                                                <xsl:text>Overbruggingskrediet</xsl:text>
                                            </u>
                                            <br/>
                                            <xsl:text>In de Overeenkomst van geldlening is overeengekomen dat Aegon, ter overbrugging van de periode tussen de koop van de nieuwe Woning en de verkoop van de bestaande Woning aan de Schuldenaar een tijdelijke Lening verstrekt, het Overbruggingskrediet. Zie hiervoor en onder 5. Het Overbruggingskrediet heeft een looptijd zoals in de Overeenkomst van geldlening is overeengekomen, dan wel eventueel nader tussen partijen (zal worden) overeengekomen. De Schuldenaar is rente over het Overbruggingskrediet tegen het in de Overeenkomst van geldlening overeengekomen rentepercentage verschuldigd.</xsl:text>
                                        </xsl:if>
                                        <xsl:if test="translate(tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_svnstarterslening']/tia:tekst, $upper, $lower) = 'true'">
                                            <br/>
                                            <u>
                                                <xsl:text>SVn Starterslening</xsl:text>
                                            </u>
                                            <br/>
                                            <xsl:text>In verband met de door de Stichting Stimuleringsfonds Volkshuisvesting Nederlandse Gemeenten (SVn) te verstrekken Starterslening, heeft Aegon zich jegens SVn en Stichting Waarborgfonds Eigen Woningen (WEW) verplicht, na het ingaan van de lening geen gelden meer onder verband van de eerste hypotheekstelling ter leen te verstrekken aan de Schuldenaar. Tevens heeft Aegon zich jegens SVn en WEW verplicht reeds afgeloste bedragen op de lening, onder verband van de eerste hypotheekstelling, niet opnieuw te laten opnemen door de Schuldenaar. Voormelde verplichtingen rusten op Aegon uitsluitend zolang de bij SVn aangegane Starterslening niet volledig is afgelost.</xsl:text>
                                        </xsl:if>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td class="number" valign="top">
                        <b>
                            <xsl:text>B.</xsl:text>
                        </b>
                    </td>
                    <td>
                        <b>
                            <xsl:text>HYPOTHEEKRECHT</xsl:text>
                        </b>
                    </td>
                </tr>
                <tr>
                    <td class="number" valign="top">
                        <xsl:text></xsl:text>
                    </td>
                    <td>
                        <table cellspacing="0" cellpadding="0">
                            <tbody>
                                <tr>
                                    <td class="number" valign="top">
                                        <b>
                                            <xsl:text>4.</xsl:text>
                                        </b>
                                    </td>
                                    <td>
                                        <b>
                                            <xsl:text>Hypotheekstelling Lening</xsl:text>
                                        </b>
                                        <br/>
                                        <xsl:text>De (Derde) Hypotheekgever verleent tot zekerheid voor de betaling van de Lening en al hetgeen Aegon in verband daarmee te vorderen mocht hebben of krijgen op grond van de Overeenkomst van geldlening, eventueel nog te verstrekken aanvullende geldlening(en), de betaling van de verschuldigde rente (ook indien deze betrekking heeft op een periode van langer dan drie jaar), in de Algemene Voorwaarden bedoelde kosten, vergoedingen en premies voor verzekeringen of inleg voor bankrekeningen een recht van hypotheek </xsl:text>
                                        <xsl:value-of
                                                select="kef:convertOrdinalToText(tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:rangordeHypotheek)"/>
                                        <xsl:text> in rang, en wel op het registergoed zoals hierna vermeld tot een bedrag van:</xsl:text>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="number" valign="top">
                                        <xsl:text></xsl:text>
                                    </td>
                                    <td>
                                        <table cellspacing="0" cellpadding="0">
                                        <tbody>
                                            <tr>
                                                <td class="number" valign="top">
                                                    <xsl:text>(A)</xsl:text>
                                                </td>
                                                <td>
                                                    <p>
                                                        <xsl:call-template name="amountText">
                                                            <xsl:with-param name="amount"
                                                                            select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:hoofdsom/tia:som"/>
                                                            <xsl:with-param name="valuta"
                                                                            select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:hoofdsom/tia:valuta"/>
                                                        </xsl:call-template>
                                                        <xsl:text> </xsl:text>
                                                        <xsl:call-template name="amountNumber">
                                                            <xsl:with-param name="amount"
                                                                            select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:hoofdsom/tia:som"/>
                                                            <xsl:with-param name="valuta"
                                                                            select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:hoofdsom/tia:valuta"/>
                                                        </xsl:call-template>
                                                        <xsl:text>, te vermeerderen met</xsl:text>
                                                    </p>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="number" valign="top">
                                                    <xsl:text>(B)</xsl:text>
                                                </td>
                                                <td>
                                                    <p>
                                                        <xsl:text>de hiervoor bedoelde rente, kosten, vergoedingen en premies en/of inleg, die tezamen worden begroot op veertig procent (40%) van het onder (A) omschreven bedrag, zijnde </xsl:text>
                                                        <xsl:call-template name="amountText">
                                                            <xsl:with-param name="amount"
                                                                            select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragRente/tia:som"/>
                                                            <xsl:with-param name="valuta"
                                                                            select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragRente/tia:valuta"/>
                                                        </xsl:call-template>
                                                        <xsl:text> </xsl:text>
                                                        <xsl:call-template name="amountNumber">
                                                            <xsl:with-param name="amount"
                                                                            select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragRente/tia:som"/>
                                                            <xsl:with-param name="valuta"
                                                                            select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragRente/tia:valuta"/>
                                                        </xsl:call-template>
                                                        <xsl:text>,</xsl:text>
                                                    </p>
                                                </td>
                                            </tr>
                                        </tbody>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="number" valign="top">
                                    </td>
                                    <td>
                                        <xsl:text>dus tot een maximaal eindbedrag van </xsl:text>
                                        <xsl:call-template name="amountText">
                                            <xsl:with-param name="amount"
                                                            select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragTotaal/tia:som"/>
                                            <xsl:with-param name="valuta"
                                                            select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragTotaal/tia:valuta"/>
                                        </xsl:call-template>
                                        <xsl:text> </xsl:text>
                                        <xsl:call-template name="amountNumber">
                                            <xsl:with-param name="amount"
                                                            select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragTotaal/tia:som"/>
                                            <xsl:with-param name="valuta"
                                                            select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:bedragTotaal/tia:valuta"/>
                                        </xsl:call-template>
                                        <xsl:text>.</xsl:text>
                                        <br/>
                                        <xsl:text>De hypotheek zoals hiervoor omschreven wordt verleend op het hierna te omschrijven Onderpand:</xsl:text>
                                        <br/>
                                        <xsl:apply-templates select="." mode="do-rights"/>
                                    </td>
                                </tr>
                                <xsl:if test="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[translate(tia:aanduidingHypotheek, $upper, $lower) = 'overbruggingshypotheek']">
                                    <tr>
                                        <td class="number" valign="top">
                                            <b>
                                                <xsl:text>5.</xsl:text>
                                            </b>
                                        </td>
                                        <td>
                                            <b>
                                                <xsl:text>Hypotheekstelling Overbruggingskrediet</xsl:text>
                                            </b>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="number" valign="top">
                                            <xsl:text></xsl:text>
                                        </td>
                                        <td>
                                            <xsl:text>Daarnaast verleent de (Derde) Hypotheekgever tot zekerheid aan Aegon, die bij deze van de (Derde) Hypotheekgever aanvaardt, voor de betaling van al hetgeen Aegon te vorderen mocht hebben of krijgen op grond van het Overbruggingskrediet, de betaling van de verschuldigde rente (ook indien deze betrekking heeft op een periode van langer dan drie jaar), in de Algemene Voorwaarden bedoelde kosten en vergoedingen, een recht van hypotheek </xsl:text>
                                            <xsl:value-of
                                                    select="kef:convertOrdinalToText(tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[translate(tia:aanduidingHypotheek, $upper, $lower) = 'overbruggingshypotheek']/tia:rangordeHypotheek)"/>
                                            <xsl:text> in rang, en wel op het overbruggingspand zoals hierna vermeld tot een bedrag van:</xsl:text>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="number" valign="top">
                                            <xsl:text></xsl:text>
                                        </td>
                                        <td>
                                            <table cellspacing="0" cellpadding="0">
                                            <tbody>
                                                <tr>
                                                    <td class="number" valign="top">
                                                        <xsl:text>(I)</xsl:text>
                                                    </td>
                                                    <td>
                                                        <p>
                                                            <xsl:call-template name="amountText">
                                                                <xsl:with-param name="amount"
                                                                                select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[translate(tia:aanduidingHypotheek, $upper, $lower) = 'overbruggingshypotheek']/tia:hoofdsom/tia:som"/>
                                                                <xsl:with-param name="valuta"
                                                                                select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[translate(tia:aanduidingHypotheek, $upper, $lower) = 'overbruggingshypotheek']/tia:hoofdsom/tia:valuta"/>
                                                            </xsl:call-template>
                                                            <xsl:text> </xsl:text>
                                                            <xsl:call-template name="amountNumber">
                                                                <xsl:with-param name="amount"
                                                                                select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[translate(tia:aanduidingHypotheek, $upper, $lower) = 'overbruggingshypotheek']/tia:hoofdsom/tia:som"/>
                                                                <xsl:with-param name="valuta"
                                                                                select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[translate(tia:aanduidingHypotheek, $upper, $lower) = 'overbruggingshypotheek']/tia:hoofdsom/tia:valuta"/>
                                                            </xsl:call-template>
                                                            <xsl:text>, te vermeerderen met</xsl:text>
                                                        </p>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="number" valign="top">
                                                        <xsl:text>(II)</xsl:text>
                                                    </td>
                                                    <td>
                                                        <p>
                                                            <xsl:text>de hiervoor bedoelde rente, kosten en vergoedingen, die tezamen worden begroot op veertig procent (40%) van het onder (I) omschreven bedrag, zijnde </xsl:text>
                                                            <xsl:call-template name="amountText">
                                                                <xsl:with-param name="amount"
                                                                                select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[translate(tia:aanduidingHypotheek, $upper, $lower) = 'overbruggingshypotheek']/tia:bedragRente/tia:som"/>
                                                                <xsl:with-param name="valuta"
                                                                                select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[translate(tia:aanduidingHypotheek, $upper, $lower) = 'overbruggingshypotheek']/tia:bedragRente/tia:valuta"/>
                                                            </xsl:call-template>
                                                            <xsl:text> </xsl:text>
                                                            <xsl:call-template name="amountNumber">
                                                                <xsl:with-param name="amount"
                                                                                select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[translate(tia:aanduidingHypotheek, $upper, $lower) = 'overbruggingshypotheek']/tia:bedragRente/tia:som"/>
                                                                <xsl:with-param name="valuta"
                                                                                select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[translate(tia:aanduidingHypotheek, $upper, $lower) = 'overbruggingshypotheek']/tia:bedragRente/tia:valuta"/>
                                                            </xsl:call-template>
                                                            <xsl:text>,</xsl:text>
                                                        </p>
                                                    </td>
                                                </tr>
                                            </tbody>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="number" valign="top">
                                            <xsl:text></xsl:text>
                                        </td>
                                        <td>
                                            <xsl:text>dus tot een maximaal eindbedrag van </xsl:text>
                                            <xsl:call-template name="amountText">
                                                <xsl:with-param name="amount"
                                                                select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[translate(tia:aanduidingHypotheek, $upper, $lower) = 'overbruggingshypotheek']/tia:bedragTotaal/tia:som"/>
                                                <xsl:with-param name="valuta"
                                                                select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[translate(tia:aanduidingHypotheek, $upper, $lower) = 'overbruggingshypotheek']/tia:bedragTotaal/tia:valuta"/>
                                            </xsl:call-template>
                                            <xsl:text> </xsl:text>
                                            <xsl:call-template name="amountNumber">
                                                <xsl:with-param name="amount"
                                                                select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[translate(tia:aanduidingHypotheek, $upper, $lower) = 'overbruggingshypotheek']/tia:bedragTotaal/tia:som"/>
                                                <xsl:with-param name="valuta"
                                                                select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[translate(tia:aanduidingHypotheek, $upper, $lower) = 'overbruggingshypotheek']/tia:bedragTotaal/tia:valuta"/>
                                            </xsl:call-template>
                                            <xsl:text>.</xsl:text>
                                            <br/>
                                            <xsl:text>De hypotheek zoals hiervoor omschreven wordt verleend op het hierna te omschrijven Overbruggingspand:</xsl:text>
                                            <br/>
                                            <xsl:apply-templates
                                                    select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[translate(tia:aanduidingHypotheek, $upper, $lower) = 'overbruggingshypotheek']"
                                                    mode="do-overbruggingshypotheek"/>
                                        </td>
                                    </tr>
                                </xsl:if>
                            </tbody>
                        </table>
                    </td>
                </tr>
            </tbody>
        </table>
        <xsl:apply-templates select="." mode="do-election-of-domicile"/>
        <p>
            <xsl:text>EINDE KADASTERDEEL</xsl:text>
        </p>
        <xsl:apply-templates select="." mode="do-free-text"/>
    </xsl:template>
    <!--
    *********************************************************
    Mode: do-rights
    *********************************************************
    Public: yes

    Identity transform: no

    Description: blg mortgage deed rights.

    Input: tia:Bericht_TIA_Stuk

    Params: none

    Output: XHTML structure

    Calls:
    (mode) do-right
    (mode) do-registered-object
    (name) processRights

    Called by:
    (mode) do-deed
    -->
    <!--
    **** matching template ********************************************************************************
    -->
    <xsl:template match="tia:Bericht_TIA_Stuk" mode="do-rights">
        <xsl:variable name="allProcessedRights"
                      select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:IMKAD_ZakelijkRecht"/>
        <xsl:choose>
            <xsl:when test="count($allProcessedRights) = 1">
                <p>
                    <xsl:variable name="rightText">
                        <xsl:apply-templates select="$allProcessedRights" mode="do-right"/>
                    </xsl:variable>
                    <xsl:if test="normalize-space($rightText) != ''">
                        <xsl:value-of select="$rightText"/>
                        <xsl:text> </xsl:text>
                    </xsl:if>
                    <xsl:apply-templates select="$allProcessedRights" mode="do-registered-object"/>
                    <xsl:text>.</xsl:text>
                </p>
            </xsl:when>
            <!-- Multiple registered objects, all parcels with same data -->
            <xsl:when test="count($allProcessedRights)
					= count($allProcessedRights[
						tia:aardVerkregen = $allProcessedRights[tia:IMKAD_Perceel][1]/tia:aardVerkregen
						and normalize-space(tia:aardVerkregen) != ''
						and ((tia:aardVerkregenVariant
							= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:aardVerkregenVariant)
							or (not(tia:aardVerkregenVariant)
							and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:aardVerkregenVariant)))
						and ((tia:tia_Aantal_BP_Rechten
								= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:tia_Aantal_BP_Rechten)
							or (not(tia:tia_Aantal_BP_Rechten)
								and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:tia_Aantal_BP_Rechten)))
						and ((tia:tia_Aantal_Rechten
								= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:tia_Aantal_Rechten)
							or (not(tia:tia_Aantal_Rechten)
								and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:tia_Aantal_Rechten)))
						and ((tia:tia_Aantal_RechtenVariant
								= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:tia_Aantal_RechtenVariant)
							or (not(tia:tia_Aantal_RechtenVariant)
								and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:tia_Aantal_RechtenVariant)))
						and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven']/tia:tekst
								= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven']/tia:tekst)
							or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven'])
								and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijven'])))
						and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom']/tia:tekst
								= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom']/tia:tekst)
							or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom'])
							and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eigendom'])))
						and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoud']/tia:tekst
								= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoud']/tia:tekst)
							or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoud'])
							and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoud'])))
						and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurend']/tia:tekst
								= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurend']/tia:tekst)
							or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurend'])
							and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurend'])))
						and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijvenvariant']/tia:tekst
								= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijvenvariant']/tia:tekst)
							or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijvenvariant'])
							and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_naderteomschrijvenvariant'])))
						and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoudvariant']/tia:tekst
								= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoudvariant']/tia:tekst)
							or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoudvariant'])
							and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_meervoudvariant'])))
						and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurendvariant']/tia:tekst
								= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurendvariant']/tia:tekst)
							or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurendvariant'])
							and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_eeuwigdurendvariant'])))
						and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aantal_bp_rechtenvariant']/tia:tekst
								= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aantal_bp_rechtenvariant']/tia:tekst)
							or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aantal_bp_rechtenvariant'])
							and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aantal_bp_rechtenvariant'])))
						and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen']/tia:tekst
								= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen']/tia:tekst)
							or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen'])
								and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_voorlopigegrenzen'])))
						and ((tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_wijzevanlevering']/tia:tekst
								= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_wijzevanlevering']/tia:tekst)
							or (not(tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_wijzevanlevering'])
								and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_wijzevanlevering'])))
						and ((tia:aandeelInRecht/tia:teller = $allProcessedRights[tia:IMKAD_Perceel][1]/tia:aandeelInRecht/tia:teller
							and tia:aandeelInRecht/tia:noemer = $allProcessedRights[tia:IMKAD_Perceel][1]/tia:aandeelInRecht/tia:noemer)
							or (not(tia:aandeelInRecht)
								and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:aandeelInRecht)))
						and tia:IMKAD_Perceel[
							tia:tia_OmschrijvingEigendom
								= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_OmschrijvingEigendom
							and normalize-space(tia:tia_OmschrijvingEigendom) != ''
							and ((tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid']/tia:tekst
									= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid']/tia:tekst)
								or (not(tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid'])
									and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_mandeligheid'])))
							and ((tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aanduiding']/tia:tekst
									= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aanduiding']/tia:tekst)
								or (not(tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aanduiding'])
								and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_aanduiding'])))
							and ((tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_nabij']/tia:tekst
									= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_nabij']/tia:tekst)
								or (not(tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_nabij'])
								and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_nabij'])))
							and ((tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_komma']/tia:tekst
									= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_komma']/tia:tekst)
								or (not(tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_komma'])
								and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_Tekstkeuze[translate(tia:tagNaam, $upper, $lower) = 'k_komma'])))
							and ((tia:tia_SplitsingsverzoekOrdernummer
									= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_SplitsingsverzoekOrdernummer)
								or (not(tia:tia_SplitsingsverzoekOrdernummer)
									and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:tia_SplitsingsverzoekOrdernummer)))
			and ((tia:stukVerificatiekosten/tia:reeks
						= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:reeks)
					or (not(tia:stukVerificatiekosten/tia:reeks)
						and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:reeks)))
				and ((tia:stukVerificatiekosten/tia:deel
						= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:deel)
					or (not(tia:stukVerificatiekosten/tia:deel)
						and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:deel)))
				and ((tia:stukVerificatiekosten/tia:nummer
						= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:nummer)
					or (not(tia:stukVerificatiekosten/tia:nummer)
						and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:stukVerificatiekosten/tia:nummer)))
				and tia:kadastraleAanduiding/tia:gemeente
					= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:kadastraleAanduiding/tia:gemeente
				and normalize-space(tia:kadastraleAanduiding/tia:gemeente) != ''
				and tia:kadastraleAanduiding/tia:sectie
					= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:kadastraleAanduiding/tia:sectie
				and normalize-space(tia:kadastraleAanduiding/tia:sectie) != ''
				and tia:IMKAD_OZLocatie/tia:ligging
					= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:ligging
				and normalize-space(tia:IMKAD_OZLocatie/tia:ligging) != ''
				and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer
					= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer)
					or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer)
						and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummer)))
				and  ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter
						= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter)
					or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter)
						and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisletter)))
				and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging
						= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging)
					or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging)
						and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging)))
				and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode
						= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode)
					or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode)
						and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_NummerAanduiding/tia:postcode)))
				and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam
					= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam)
					or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam)
						and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam)))
			and ((tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam
					= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam)
					or (not(tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam)
						and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:adres/tia:BAG_Woonplaats/tia:woonplaatsNaam)))
				and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:postcode
					= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:postcode)
					or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:postcode)
						and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:kadBinnenlandsAdres/tia:postcode)))
				and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:woonplaatsNaam
					= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:woonplaatsNaam)
					or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:woonplaatsNaam)
						and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:kadBinnenlandsAdres/tia:woonplaatsNaam)))
				and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:openbareRuimteNaam
					= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:openbareRuimteNaam)
					or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:openbareRuimteNaam)
						and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:kadBinnenlandsAdres/tia:openbareRuimteNaam)))
				and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummer
					= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummer)
					or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummer)
						and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:kadBinnenlandsAdres/tia:huisNummer)))
				and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisLetter
					= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisLetter)
					or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisLetter)
						and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:kadBinnenlandsAdres/tia:huisLetter)))
				and ((tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummerToevoeging
					= $allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummerToevoeging)
					or (not(tia:IMKAD_OZLocatie/tia:kadBinnenlandsAdres/tia:huisNummerToevoeging)
						and not($allProcessedRights[tia:IMKAD_Perceel][1]/tia:IMKAD_Perceel/tia:kadBinnenlandsAdres/tia:huisNummerToevoeging)))]]) and $RegistergoedTonenPerPerceel='false'">
                <p>
                    <xsl:variable name="rightText">
                        <xsl:apply-templates select="$allProcessedRights[1]" mode="do-right"/>
                    </xsl:variable>
                    <xsl:if test="normalize-space($rightText) != ''">
                        <xsl:value-of select="$rightText"/>
                        <xsl:text> </xsl:text>
                    </xsl:if>
                    <xsl:apply-templates select="$allProcessedRights[1]" mode="do-registered-object"/>
                    <xsl:text>.</xsl:text>
                </p>
            </xsl:when>
            <xsl:otherwise>
                <table cellpadding="0" cellspacing="0">
                    <tbody>
                        <xsl:call-template name="processRights">
                            <xsl:with-param name="positionOfProcessedRight" select="1"/>
                            <xsl:with-param name="position" select="1"/>
                            <xsl:with-param name="haveAdditionalText" select="'false'"/>
                            <!-- forceer de ; na elke aanroep recht/registergoed -->
                            <xsl:with-param name="registeredObjects"
                                            select="tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']"/>
                        </xsl:call-template>
                    </tbody>
                </table>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!--
    *********************************************************
    Mode: do-election-of-domicile
    *********************************************************
    Public: yes

    Identity transform: no

    Description: blg mortgage deed election of domicile.

    Input: tia:Bericht_TIA_Stuk

    Params: none

    Output: XHTML structure

    Calls: none

    Called by:
    (mode) do-deed
    -->
    <!--
    **** matching template ********************************************************************************
    -->
    <xsl:template match="tia:Bericht_TIA_Stuk" mode="do-election-of-domicile">
        <xsl:variable name="woonplaatskeuze" select="tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_woonplaatskeuze']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
				translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_woonplaatskeuze']/tia:tekst[translate(normalize-space(.), $upper, $lower) =
				translate(normalize-space(current()/tia:IMKAD_AangebodenStuk/tia:tia_TekstKeuze[translate(tia:tagNaam, $upper, $lower) = 'k_woonplaatskeuze']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
        <!-- Election of domicile -->
        <a name="hyp3.electionOfDomicile" class="location">&#160;</a>
        <xsl:if test="$woonplaatskeuze != ''">
            <p>
                <u>
                    <xsl:text>Woonplaats</xsl:text>
                </u>
            </p>
            <p>
                <xsl:value-of select="$woonplaatskeuze"/>
                <xsl:text>.</xsl:text>
            </p>
        </xsl:if>
    </xsl:template>
    <!--
    *********************************************************
    Mode: do-free-text
    *********************************************************
    Public: yes

    Identity transform: no

    Description: blg mortgage deed free text part.

    Input: tia:Bericht_TIA_Stuk

    Params: none

    Output: XHTML structure

    Calls:
    (mode) do-free-text

    Called by:
    (mode) do-deed
    -->
    <!--
    **** matching template ********************************************************************************
    -->
    <xsl:template match="tia:Bericht_TIA_Stuk" mode="do-free-text">
        <!-- Free text part -->
        <a name="hyp3.part2" class="location">&#160;</a>
        <xsl:apply-templates select="tia:IMKAD_AangebodenStuk/tia:tia_TekstTweedeDeel" mode="do-free-text"/>
    </xsl:template>

    <xsl:template
            match="tia:Partij[@id = substring-after(//tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:verkrijgerRechtRef/@xlink:href, '#')]"
            mode="do-partij">

        <table cellspacing="0" cellpadding="0">
            <tbody>
                <xsl:call-template name="gevolmachtigde"/>
                <xsl:apply-templates select="./tia:IMKAD_Persoon" mode="do-rechtspersoon"/>
            </tbody>
        </table>
    </xsl:template>

    <xsl:template
            match="tia:Partij[@id = substring-after(//tia:Bericht_TIA_Stuk/tia:IMKAD_AangebodenStuk/tia:StukdeelHypotheek[not(tia:aanduidingHypotheek) or normalize-space(tia:aanduidingHypotheek) = '']/tia:vervreemderRechtRef/@xlink:href, '#')]"
            mode="do-partij">
        <xsl:variable name="numberOfPersons"
                      select="count(descendant::tia:IMKAD_Persoon[normalize-space(tia:tia_IndGerechtigde) = 'true'])"/>
        <table>
            <tbody>
                <xsl:call-template name="gevolmachtigde"/>
                <xsl:apply-templates select="./tia:IMKAD_Persoon" mode="do-party-person"/>
            </tbody>
        </table>

        <p style="margin-left:30px">
            <xsl:apply-templates select="." mode="do-keuzeblok-partijnamen-hypotheekakte">
                <xsl:with-param name="partyNumber" select="number('2')"/>
            </xsl:apply-templates>
            <xsl:text>.</xsl:text>
        </p>

    </xsl:template>

    <xsl:template name="gevolmachtigde">
        <xsl:variable name="hoedanigheidId" select="substring-after(./tia:Gevolmachtigde/tia:vertegenwoordigtRef/@xlink:href, '#')"/>
        <xsl:if test="./tia:Gevolmachtigde and count(./tia:Hoedanigheid[@id = $hoedanigheidId]/tia:wordtVertegenwoordigdRef) = 0">
            <tr>
                <td>
                    <table>
                        <tbody>
                            <tr>
                                <td class="number" valign="top">
                                    <a name="{@id}" class="location" style="_position: relative;"></a>
                                    <xsl:value-of select="count(preceding-sibling::tia:Partij) + 1"/>
                                    <xsl:text>.</xsl:text>
                                </td>
                                <td>
                                    <xsl:apply-templates select="./tia:Gevolmachtigde" mode="do-legal-representative"/>
                                    <xsl:text>:</xsl:text>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </td>
            </tr>
        </xsl:if>
    </xsl:template>
    <!--
    *********************************************************
    Mode: do-party-person
    *********************************************************
    Public: no

    Identity transform: no

    Description: blg mortgage deed party persons.

    Input: tia:IMKAD_Persoon

    Params: none

    Output: XHTML structure

    Calls:
    (mode) do-party-natural-person
    (mode) do-party-legal-person

    Called by:
    (mode) do-comparitie
    -->
    <!--
    **** matching template ********************************************************************************
    **** NATURAL PERSON    ********************************************************************************
    -->
    <xsl:template match="tia:IMKAD_Persoon[(tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene) and not(tia:GerelateerdPersoon)]" mode="do-party-person">
        <xsl:apply-templates select="." mode="do-party-natural-person"/>
    </xsl:template>
    <!--
    **** matching template   ******************************************************************************
    **** NATURAL PERSON PAIR ******************************************************************************
    -->
    <xsl:template match="tia:IMKAD_Persoon[(tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene) and tia:GerelateerdPersoon]" mode="do-party-person">
        <xsl:apply-templates select="." mode="do-party-natural-person"/>
    </xsl:template>
    <!--
    **** matching template ********************************************************************************
    **** LEGAL PERSON      ********************************************************************************
    -->
    <xsl:template match="tia:IMKAD_Persoon[tia:tia_Gegevens/tia:NHR_Rechtspersoon]" mode="do-party-person">
        <xsl:apply-templates select="." mode="do-party-legal-person"/>
    </xsl:template>

    <xsl:template match="tia:IMKAD_Persoon[tia:tia_Gegevens/tia:NHR_Rechtspersoon]" mode="do-rechtspersoon">
        <tr>
            <td>
                <table>
                    <tbody>
                        <tr>
                            <td class="number"/>
                            <td>
                                <xsl:apply-templates select="." mode="do-legal-person"/>
                                <xsl:if test="./tia:IMKAD_PostlocatiePersoon">
                                    <xsl:text> (correspondentieadres voor alle aangelegenheden betreffende de hierna te vermelden rechtshandelingen: </xsl:text>

                                    <xsl:apply-templates select="./tia:IMKAD_PostlocatiePersoon" mode="do-correspondant-address"/>
                                    <xsl:text>)</xsl:text>
                                </xsl:if>
                                <xsl:text>;</xsl:text>
                                <br/>
                                <xsl:text>hierna te noemen: "Aegon";</xsl:text>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </td>
        </tr>
    </xsl:template>


    <!--
    **** matching template ********************************************************************************
    **** Overbruggingshypotheek      ********************************************************************************
    -->
    <xsl:template match="tia:StukdeelHypotheek" mode="do-overbruggingshypotheek">
        <xsl:choose>
            <xsl:when test="count(tia:IMKAD_ZakelijkRecht) = 1">
                <xsl:variable name="rightText">
                    <xsl:apply-templates select="tia:IMKAD_ZakelijkRecht" mode="do-right"/>
                </xsl:variable>
                <xsl:if test="normalize-space($rightText) != ''">
                    <xsl:value-of select="$rightText"/>
                    <xsl:text> </xsl:text>
                </xsl:if>
                <xsl:apply-templates select="tia:IMKAD_ZakelijkRecht" mode="do-registered-object"/>
                <xsl:text>.</xsl:text>
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
                <br/>
                <xsl:variable name="rightText">
                    <xsl:apply-templates select="tia:IMKAD_ZakelijkRecht[1]" mode="do-right"/>
                </xsl:variable>
                <xsl:if test="normalize-space($rightText) != ''">
                    <xsl:value-of select="$rightText"/>
                    <xsl:text> </xsl:text>
                </xsl:if>
                <xsl:apply-templates select="tia:IMKAD_ZakelijkRecht[1]" mode="do-registered-object"/>
                <xsl:text>.</xsl:text>
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

    <xsl:template match="tia:tia_Gegevens" mode="do-person-name">
        <xsl:choose>
            <xsl:when test="tia:GBA_Ingezetene">
                <xsl:apply-templates select="tia:GBA_Ingezetene" mode="do-gender-salutation"/>
                <xsl:text> </xsl:text>
                <xsl:variable name="kadNatuurlijkPersoon" select="../tia:tia_Gegevens[tia:IMKAD_KadNatuurlijkPersoon]/tia:IMKAD_KadNatuurlijkPersoon"/>
                <xsl:choose>
                    <xsl:when test="$kadNatuurlijkPersoon">
                        <xsl:value-of select="$kadNatuurlijkPersoon/tia:voornamen"/>
                        <xsl:if test="$kadNatuurlijkPersoon/tia:voorvoegselsgeslachtsnaam
								and normalize-space($kadNatuurlijkPersoon/tia:voorvoegselsgeslachtsnaam) != ''">
                            <xsl:text> </xsl:text>
                            <xsl:value-of select="$kadNatuurlijkPersoon/tia:voorvoegselsgeslachtsnaam"/>
                        </xsl:if>
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="$kadNatuurlijkPersoon/tia:geslachtsnaam"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="tia:GBA_Ingezetene/tia:naam/tia:voornamen"/>
                        <xsl:if test="tia:GBA_Ingezetene/tia:tia_VoorvoegselsNaam
								and normalize-space(tia:GBA_Ingezetene/tia:tia_VoorvoegselsNaam) != ''">
                            <xsl:text> </xsl:text>
                            <xsl:value-of select="tia:GBA_Ingezetene/tia:tia_VoorvoegselsNaam"/>
                        </xsl:if>
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="tia:GBA_Ingezetene/tia:tia_NaamZonderVoorvoegsels"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="tia:IMKAD_NietIngezetene">
                <xsl:apply-templates select="tia:IMKAD_NietIngezetene" mode="do-gender-salutation"/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="tia:IMKAD_NietIngezetene/tia:voornamen"/>
                <xsl:if test="tia:IMKAD_NietIngezetene/tia:voorvoegsels
						and normalize-space(tia:IMKAD_NietIngezetene/tia:voorvoegsels) != ''">
                    <xsl:text> </xsl:text>
                    <xsl:value-of select="tia:IMKAD_NietIngezetene/tia:voorvoegsels"/>
                </xsl:if>
                <xsl:text> </xsl:text>
                <xsl:value-of select="tia:IMKAD_NietIngezetene/tia:geslachtsnaam"/>
            </xsl:when>
            <xsl:when test="tia:NHR_Rechtspersoon">
                <xsl:choose>
                    <xsl:when test="../tia:tia_AanduidingPersoon">
                        <xsl:value-of select="../tia:tia_AanduidingPersoon"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="tia:NHR_Rechtspersoon/tia:statutaireNaam"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
