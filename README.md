# Aktemodellen
Kadaster Automatische Akteverwerking

Op deze locatie staat de informatie ten behoeve van software leveranciers die software ontwikkelen ten behoeve van het notariaat. Specifiek staat hier de informatie welke nodig is om zogeheten KIK-Akten te kunnen vervaardigen. 

KIK staat voor Ketenintegratie Inschrijving Kadaster. KIK-Akten beoogt om sneller, met hogere kwaliteit en tegen lagere kosten akten in te kunnen schrijven bij het Kadaster.

We raden aan om een GitHub Desktop te gebruiken om een lokale kopie te creëren van deze repository. Voordelen hiervan zijn dat de inhoud van de repository lokaal op een eigen bestandssysteem beschikbaar is en tegelijkertijd eenvoudig te synchroniseren is met de hier gepubliceerde kopie. Lees pagina https://desktop.github.com/ voor details over de GitHub Desktop.

# Globale release notes
## 3 juni 2019 
We hebben in deze release een nieuwe stylesheet van de ING opgeleverd. Dit zijn de tekstblok aanpassingen die we eerder al voor de Levering (release 5 april 2019) hebben opgeleverd. De details van deze wijzigingen hebben we opgenomen in de [release notes](/kik-modeldocumenten/modeldocumenten/Hypotheek%20ING/20190601000004/Releasenotes%20ING%2020190601000004%20-%201.md) van de ING.
- AA-4411: We hebben een bug opgelost in de stylesheet van de [ASR](/kik-modeldocumenten/modeldocumenten/Hypotheek%20ASR/20190401000020/Releasenotes%20ASR%2020190401000020%20-%203.md).
- AA-4412: We hebben een nieuwe versie van het Modeldocument van de [ASR](/kik-modeldocumenten/modeldocumenten/Hypotheek%20ASR/20190401000020/Releasenotes%20ASR%2020190401000020%20-%203.md) opgeleverd.

## 17 mei 2019
Met deze release wordt de bèta release van 5 april 2019 definitief gemaakt. Vanaf nu resulteren wijzigingen van de Akte van Levering in een nieuw stylesheetnummer of een nieuw implementatienummer.
- AA-4386: In het tekstblok Aanhef is de komma tussen 'gemeente' en 'kantoorhoudende', op verzoek, optioneel gemaakt. Deze wijziging hebben we nog alleen doorgevoerd voor de [Levering](/kik-modeldocumenten/modeldocumenten/Akte%20van%20levering/20190301000007/Releasenotes%20Akte%20van%20Levering%2020190301000007%20-%201.md) en [ASR](/kik-modeldocumenten/modeldocumenten/Hypotheek%20ASR/20190401000020/Releasenotes%20ASR%2020190401000020%20-%202.md).
- AA-4391: In het tekstblok Equivalentieverklaring is de komma tussen 'gemeente' en 'kantoorhoudende', op verzoek, optioneel gemaakt. Deze wijziging hebben we nog alleen doorgevoerd voor de [Levering](/kik-modeldocumenten/modeldocumenten/Akte%20van%20levering/20190301000007/Releasenotes%20Akte%20van%20Levering%2020190301000007%20-%201.md) en [ASR](/kik-modeldocumenten/modeldocumenten/Hypotheek%20ASR/20190401000020/Releasenotes%20ASR%2020190401000020%20-%202.md).
- AA-4395 en AA-4409: In de ASR zijn kleine tekstuele wijzigingen in de vaste tekst doorgevoerd. In de [release notes](/kik-modeldocumenten/modeldocumenten/Hypotheek%20ASR/20190401000020/Releasenotes%20ASR%2020190401000020%20-%202.md) van de ASR hebben we de details opgenomen.


## 3 mei 2019
- Voor de ASR hebben we een aktemodel ontwikkeld. In de [release notes](/kik-modeldocumenten/modeldocumenten/Hypotheek%20ASR/20190401000020/Releasenotes%20ASR%2020190401000020%20-%201.md) en de [toelichting]( /kik-modeldocumenten/modeldocumenten/Hypotheek%20ASR/20190401000020/Toelichting%20modeldocument%20ASR%201.1%20-v1.0.0.docx) hebben we de details opgenomen.

## 5 April 2019 (Bèta)
- We hebben in deze release drie vaak gehoorde wensen vanuit het notariaat vervuld. Daarnaast hebben we veertien  verbeteringen doorgevoerd in diverse tekstblokken. Tevens hebben we een aantal verbeteringen in de akte van levering zelf doorgevoerd. Met deze release hebben we deze wijzigingen doorgevoerd in de Akte van Levering. In de komende maanden zullen we deze wijzigingen ook doorvoeren in de overige akten. De details van deze wijzigingen hebben we opgenomen in de [release notes](/kik-modeldocumenten/modeldocumenten/Akte%20van%20levering/20190301000007/Releasenotes%20Akte%20van%20Levering%2020190301000007%20-%201.md) van de Akte van Levering.  
Voorbeelden van een aantal doorgevoerde wijzigingen hebben we opgenomen onder de FAQ map in [voorbeelden](/kik-modeldocumenten/FAQ/Voorbeelden).  
Het schema hebben we ook aangepast voor deze release. De details hebben we beschreven in de [Changelog XSD StukAlgemeen](/schema/stuk%20algemeen/Changelog%20XSD%20StukAlgemeen.MD), [xsd van StukAlgemeen](/schema/stuk%20algemeen/8.1.0/StukAlgemeen-8.1.0.xsd) en de [documentatie](/schema/stuk%20algemeen/8.1.0/HTML/index.htm).  

Deze release is een bèta release. De onvolkomendheden die we de komende 4 weken vinden, zullen we nog in deze versie oplossen en uiteindelijk definitief verklaren. Het stylesheetnummer en implementatienummer blijven dan dus gelijk.

## 20 maart 2019
- AA-4345: Bij bij de kadastrale gemeenten met de naam NES en NES (A) klopte de opgegeven kode niet. Dit hebben we gecorrigeerd in de waardelijst kadastralegemeente_backend.

## 18 februari 2019
- AA-4294: We hebben de meldingen van een aantal controles verbeterd waardoor duidelijker is op welk object of persoon de melding betrekking heeft.

## 5 februari 2019
- AA-4324: Wijziging AA-4303 was voor de particuliere hypotheek vermeld in de [release notes met implementatienummer 2](/kik-modeldocumenten/modeldocumenten/Hypotheek%20Particulier/20180501000006/Releasenotes%20Particulier%2020180501000006%20-%202.md), dit had in de [release notes van implementatienummer 3](/kik-modeldocumenten/modeldocumenten/Hypotheek%20Particulier/20180501000006/Releasenotes%20Particulier%2020180501000006%20-%203.md) moeten staan. Dit hebben we opgelost. De opgeloste bug AA-4198 was eerder opgelost onder implementatienummer 2 van de particuliere hypotheek, deze staat nu ook vermeld.
- AA-4324: Ten onrechte wees de ETO Tester Obvion hypotheekaktes met implementatienummer 2 af. Dit hebben we opgelost.

## 31 januari 2019
-  AA-4303: In het tekstblok Registergoed is het groeperen van percelen nu ook afhankelijk van "tia_Aantal_Rechten" en "tia_Aantal_RechtenVariant". De mogelijkheid om percelen te groeperen hield eerder nog geen rekening met deze variabelen. Deze dienen nu ook gelijk te zijn willen percelen gegroepeerd kunnen worden in het tekstblok registergoed. Deze wijziging hebben we doorgevoerd in alle modeldocumenten. Zie eventueel ook de release notes van de modeldocumenten zelf.
- AA-4311: Sinds 1 januari 2019 is voor de Rabobank alleen nog de statutaire naam 'Coöperatieve Rabobank U.A.' toegestaan in aktes. 

## 13 december 2018
- AA-4273: Wanneer 2 locatieadressen werden opgegeven in het Tekstblok Registergoed dan werden deze ten onrechte gescheiden door een komma in plaats van "en". Dit probleem hebben we hiermee opgelost. 

- AA-4298: Wegens compatibiliteitsproblemen met de stylesheets, hebben we de partnerspecifieke XSD voor de Rabobank versie 1.5 van 12 november aangepast. Zie de [Changelog XSD RabobankHypotheekakte](/schema/RabobankHypotheekakte/Changelog%20XSD%20RabobankHypotheekakte.MD), [XSD versie 1.5.1](/schema/RabobankHypotheekakte/1.5.1/RabobankHypotheekakte-1.5.1.xsd) en de [documentatie](https://github.com/KadasterAA/Aktemodellen/blob/master/schema/RabobankHypotheekakte/1.5.1/HTML/index.htm) voor de details.

- AA-4293: De huidige waardelijst voor landen in woon- en postadressen van buitenlandsAdres was al langere tijd niet meer actueel. Dit leverde ongewenste uitval op in de verwerking en sommige landen werden ten onrechte afgekeurd. Om eenvoudiger actueel te blijven zal AA overgaan op de algemene waardelijst BRPLand. We hebben hier nu een aangepaste voor AA-specifieke versie van gepubliceerd welke in de plaats komt van de huidige land-kodes-actueel. De aangepaste versie van BRPLand bevat nu nog schrijfwijzen voor landen die geldig waren volgens land-kodes-actueel, maar niet voorkomen in de algemene BRPLand waardelijst. Deze waarden zijn met einddatum geldigheid (Datum tot) ook opgenomen. De specifieke versie van BRPLand bevat nu alle actueel geldige landen. Nieuw zijn onder andere Bonaire, Curaçao, Saba en Sint Eustatius. Vanaf 1 april 2019 zal de algemene BRPLand waardelijst van toepassing zijn. 
Let op waarden voor Land als "Verenigd Koninkrijk" en "Verenigde Staten" waren en blijven onjuist en zullen uitval blijven geven. 

- AA-4292: De waarden "Laren Noord-Holland" en "Netwerken" ontbraken in de waardelijst kadastralegemeente_backend. Deze waarden hebben we hier aan toegevoegd.

- AA-3973: De volgende stylesheet-nummers kunnen met ingang van 1 april  2019 niet meer aangeboden worden via KIK:

| Nummer | Model |
| --- | --- |
| 20160701000015 | Aegon |
| 20180402000014 | BLG |
| 20151101000014 | BLG |
| 20180402000016 | RegioBank |
| 20180402000013 | SNS |


## 12 november 2018
Als gevolg van strengere eisen voor de Basisregistratie Kadaster (BRK) hebben we wijzigingen doorgevoerd in een aantal gegevensformaten zodat uitval bij verwerking van KIK-akten zal verminderen:
- AA-4241: We hebben het formaat voor omschrijvingKadastraalObject aangepast zodat deze in lijn is met de BRK.
- AA-4242: We hebben het formaat voor FINummer aangepast naar het formaat voor kvknummer. 
- AA-4243: We hebben het formaat voor huisletter strikter gemaakt zodat deze in overeenstemming is met de BAG.

Naast deze verbeteringen hebben we overbodige onderdelen verwijderd uit de schema's StukAlgemeen en Rabobank.

De details voor StukAlgemeen zijn terug te vinden in de 
[Changelog XSD StukAlgemeen](/schema/stuk%20algemeen/Changelog%20XSD%20StukAlgemeen.MD), [xsd van de algemene formaattypen](/schema/alg-formaattypen/2.0.0/alg-formaattypen-2.0.0.xsd), [xsd van StukAlgemeen](/schema/stuk%20algemeen/8.0.0/StukAlgemeen-8.0.0.xsd) en de [documentatie](/schema/stuk%20algemeen/8.0.0/HTML/index.htm). 

De wijzigingen in het schema van de Rabobank zijn op genomen in de [Changelog XSD RabobankHypotheekakte](/schema/RabobankHypotheekakte/Changelog%20XSD%20RabobankHypotheekakte.MD), [xsd van RabobankHypotheekakte](/schema/RabobankHypotheekakte/1.5/RabobankHypotheekakte-1.5.xsd) en de bijbehorende [documentatie](/schema/RabobankHypotheekakte/1.5/HTML/index.htm).

## 15 oktober 2018
- AA-4249: We hebben een bug in het modeldocument voor de [Rabobank](/kik-modeldocumenten/modeldocumenten/Hypotheek%20Rabobank/20181015000005/Releasenotes%20Rabobank%2020181015000005%20-%201.md) opgelost.	
- AA-4250: In het Tekstblok Partijnamen in Hypotheekakten hebben we 'de' in partijaanduiding optioneel gemaakt en toegepast voor de [Rabobank](/kik-modeldocumenten/modeldocumenten/Hypotheek%20Rabobank/20181015000005/Releasenotes%20Rabobank%2020181015000005%20-%201.md).
- AA-4248: We hebben verouderde documentatie van tekstblokken verwijderd.

## 5 oktober 2018
- AA-3586: een kleine aanpassing aan de waardelijst [land-codes-actueel](/waardelijsten/land-kodes-actueel.xml). We hebben daarnaast voor Automatische Akteverwerking overbodige waardelijsten verwijderd uit de publicatie.
- AA-4200: Er is een nieuwe generieke waardelijst met [nnp-kodes](/waardelijsten/nnp-kodes.xml) met een extra kolom, code rechtsvorm. Voor het modeldocument van de Rabobank gebruiken we vanaf nu niet meer de specifieke waardelijst nnp-kodes_hypotheek. Ook voor andere modeldocumenten gaan we op termijn over op deze generieke waardelijst. De reden hiervoor is dat alle waardelijsten met nnp-kodes inhoudelijk identiek zijn. 
- We hebben een aantal bugs in het modeldocument [voor de Rabobank](/kik-modeldocumenten/modeldocumenten/Hypotheek%20Rabobank/20180801000005/Releasenotes%20Rabobank%2020180801000005%20-%203.md) opgelost.

## 10 september 2018
- We hebben enkele bugs in het nieuwe modeldocument voor de Rabobank opgelost. De details staan in de [release notes voor de Rabobank](/kik-modeldocumenten/modeldocumenten/Hypotheek%20Rabobank/20180801000005/Releasenotes%20Rabobank%2020180801000005%20-%202.md). 
- KIK-Akten van de Rabobank met stylesheetnummers 20140830000005 en 20180501000005 worden met ingang van heden niet meer geaccepteerd.

## 3 augustus 2018
-  Nieuwe versie van het modeldocument voor de Rabobank. De details staan in de [release notes voor de Rabobank](/kik-modeldocumenten/modeldocumenten/Hypotheek%20Rabobank/20180801000005/Releasenotes%20Rabobank%2020180801000005%20-%201.md) en in de [toelichting](/kik-modeldocumenten/modeldocumenten/Hypotheek%20Rabobank/20180801000005/Toelichting%20modeldocument%20Rabobank%204.0.1%20-%20v4.0.0.docx).

## 4 juli 2018
-  Bij het modeldocument, de toelichting en de releasenotes van het modeldocument van Aegon is per abuis een verkeerd stylesheetnummer getoond. 
De fout is inmiddels in de documentatie hersteld, het juiste stylesheetnummer moet zijn [20180501000015](/kik-modeldocumenten/modeldocumenten/Hypotheek%20Aegon/20180501000015).

## 18 juni 2018
- Met deze release maken we de wĳziging AA-3777 in de toelichting van het [tekstblok Burgerlijke Staat](/kik-modeldocumenten/tekstblokken/Toelichting%20Tekstblok%20-%20Burgerlijke%20staat%201.1%20-%20v1.5.docx) ongedaan. Zie voor de details release notes van de verschillende modeldocumenten.
- Voor de modeldocumenten van [SNS](/kik-modeldocumenten/modeldocumenten/Hypotheek%20SNS/20180501000013/Releasenotes%20SNS%2020180501000013%20%20-%201b.md) en [RegioBank](/kik-modeldocumenten/modeldocumenten/Hypotheek%20Regiobank/20180501000016/Releasenotes%20Regiobank%2020180501000016%20-%201b.md) hebben we de nu overbodige controle op datum ondertekening hypotheekofferte verwijderd.

## 29 mei 2018
- De [handleiding voor de Externe Test Omgeving (ETO)](/kik-eto) voor KIK-AA hebben we omgezet naar Markdown en uitgebreid met de eisen waaraan voldaan moet worden voor het gebruik van de ETO.

## 18 mei 2018
- In de nieuwe versie van tekstblok [Burgerlijke Staat](/kik-modeldocumenten/tekstblokken/Toelichting%20Tekstblok%20-%20Burgerlijke%20staat%201.1%20-%20v1.4.docx) dient u ‘geregistreerd partnerschap’ i.p.v. ‘geregistreerd partner’ te gebruiken. Tevens hebben we de mogelijkheid om ook ‘in beperkte gemeenschap van goederen’ te gebruiken toegevoegd. Zie voor verdere details de release notes voor de nieuwe stylesheets van de verschillende modeldocumenten.
- In de nieuwe versie van het tekstblok [Recht](/kik-modeldocumenten/tekstblokken/Toelichting%20Tekstblok%20-%20Recht%202.7%20-%20v2.9.docx) dient bij (Eigendom belast met) Opstal, Erfpacht en BP rechten het aantal vermeld te worden. Voor BP rechten was dit al verplicht via een specifieke constructie. Het aantal kan voor zowel Opstal, Erfpacht als BP rechten nu op een gelijke wijze aangegeven worden. Zie voor verdere details de release notes voor de nieuwe stylesheets van de verschillende modeldocumenten.
- Bij een recht van erfpacht of bij een recht van ondererfpacht (variant d) werd voorafgaand aan 'belast met' geen komma getoond. Dit is wel de bedoeling. Het tekstblok [Recht](/kik-modeldocumenten/tekstblokken/Tekstblok%20-%20Recht%20v2.7.docx) en de [Toelichting](/kik-modeldocumenten/tekstblokken/Toelichting%20Tekstblok%20-%20Recht%202.7%20-%20v2.9.docx) hebben we hier op aangepast.
- De [Documentatie XSD StukAlgemeen](/schema/stuk%20algemeen/7.0.0/Documentatie%20XSD%20StukAlgemeen-7.0.0.doc) bevat nu alleen nog de algemene documentatie. De modelbeschrijving zelf is vanaf nu opgenomen in een [HTML versie](/schema/stuk%20algemeen/7.0.0/HTML/index.htm) welke leesbaar is met Internet Explorer.
- Ook de Overzichtsplaat StukAlgemeen is vanaf nu beschikbaar in deze HTML versie van de modelbeschrijving.
- De datum ondertekening hypotheekofferte is verwijderd uit de modeldocumenten voor de [RegioBank](/kik-modeldocumenten/modeldocumenten/Hypotheek%20Regiobank/20180501000016/Releasenotes%20Regiobank%2020180501000016%20-%201.md) en de [SNS](/kik-modeldocumenten/modeldocumenten/Hypotheek%20SNS/20180501000013/Releasenotes%20SNS%2020180402000013%20%20-%201.md).
- We hebben een drietal bugs opgelost in de [Doorhaling Hypotheek](/kik-modeldocumenten/modeldocumenten/Doorhaling%20hypotheek/20180501000010/Releasenotes%20Doorhaling%20hypotheek%2020180501000010%20-%201.md) en een bug in de [Akte van Levering](/kik-modeldocumenten/modeldocumenten/Akte%20van%20levering/20180501000007/Releasenotes%20Akte%20van%20Levering%2020180501000007%20-%201.md).
- Zoals eerder aangekondigd, kunnen de volgende stylesheet-nummers met ingang van heden niet meer aangeboden worden via KIK:

| Nummer | Model |
| --- | --- |
| 20120323000001 | ABN AMRO AAB |
| 20120501000001 | ABN AMRO AAB |
| 20120323000002 | ABN AMRO Florius |
| 20120501000002 | ABN AMRO Florius |
| 20120501000003 | ABN AMRO MoneYou |
| 20120501000009 | Akte van verdeling |
| 20120323000004 | ING bank |
| 20120501000004 | ING bank |
| 20120501000008 | Koop- of Optieovereenkomst |
| 20120323000007 | Leveringsakte KNB |
| 20120501000007 | Leveringsakte KNB |
| 20120701000001 | Leveringsakte KNB |
| 20120323000006 | Particuliere hypotheek |
| 20120501000006 | Particuliere hypotheek |
| 20120323000005 | Rabobank |
| 20120501000005 | Rabobank |

## 4 mei 2018
- De bestandstructuur hebben we aangepast om een hogere kwaliteit te kunnen bieden. De mappen tekstblokken en modeldocumenten hebben we beiden onder de map kik-modeldocumenten geplaatst. We hebben geen inhoudelijke wijzigingen doorgevoerd.

## 10 april 2018
- De modeldocumenten van de Volksbank zijn aangepast met betrekking tot de offerte. Zie voor details de [release notes voor de BLG hypotheek](/kik-modeldocumenten/modeldocumenten/Hypotheek%20BLG/20180402000014/Releasenotes%20BLG%2020180402000014%20-%201.md), de [release notes voor de RegioBank hypotheek](/kik-modeldocumenten/modeldocumenten/Hypotheek%20Regiobank/20180402000016/Releasenotes%20Regiobank%2020180402000016%20-%201.md) en de [release notes voor de SNS hypotheek](/kik-modeldocumenten/modeldocumenten/Hypotheek%20SNS/20180402000013/Releasenotes%20SNS%2020180402000013%20%20-%201.md).
- Zoals we op 10 januari hebben aangekondigd, kunnen de volgende stylesheet-nummers met ingang van heden niet meer aangeboden worden via KIK:

| Nummer | Model |
|---|---|
| 20090513000002 | Doorhaling |
| 20140830000009 | Akte van Verdeling |
| 20150801000014 | BLG |
| 20140822000006 | Particuliere hypotheek |
| 20140830000004 | ING bank |
| 20150101000012 | Obvion |
| 20151001000015 | Aegon |
| 20150201000013 | SNS |
| 20160201000016 | RegioBank |

## 27 maart 2018
Intrekking release 20 maart.

## 20 maart 2018
Aanpassingen t.b.v. Volksbank. Ingetrokken op 27 maart.

## 23 februari 2018 
- De vaste tekst bij hypotheekrecht en overbrugging aangepast conform model MUNT 18.01. Daarnaast hebben we een voorbeeld en de toelichting verbeterd van dit modeldocument. Meer details staan beschreven in de [release notes voor de Munt hypotheek](/kik-modeldocumenten/modeldocumenten/Hypotheek%20Munt/20161001000018/Releasenotes%20Munt%2020161001000018%20-%205.md).

## 29 januari 2018 #
- Voor alle modeldocumenten is het nu mogelijk om de perceelgrootte in vierkante meters te tonen. Zie ook de release notes van de individuele modeldocumenten. Hiertoe hebben we de stylesheet, het [Tekstblok - Registergoed](/kik-modeldocumenten/tekstblokken/Tekstblok%20-%20Registergoed%20v2.7.0.docx) en de bijbehorende [Toelichting](/kik-modeldocumenten/tekstblokken/Toelichting%20Tekstblok%20-%20Registergoed%202.7.0%20-%20v2.11.0.docx) aangepast.
- De op [Github](https://github.com/KadasterAA/Aktemodellen) gepubliceerde informatie vervangt met ingang van deze release de informatie welke eerder gepubliceerd stond op de [kadaster-site](https://kik-aa.kadaster.nl/kik/aktemodellen/) en is op deze laatste locatie dan ook niet meer beschikbaar.

## 15 december 2017 #
- Aanpassing in de tekstblokken Aanhef, Aanhef Notariële Verklaring, Equivalentieverklaring. [Details staan in de release notes voor Akte van Levering](/kik-modeldocumenten/modeldocumenten/Akte%20van%20levering/20140830000007/Releasenotes%20Akte%20van%20Levering%2020140830000007%20-%2011.docx).

## 17 november 2017 #
- Aanpassing van een technische waardelijst. [Details staan in de release notes voor Abn Amro AAB](/kik-modeldocumenten/modeldocumenten/Hypotheek%20ABN%20AMRO%20AAB/20140830000001/Releasenotes%20Modeldocumenten%202014083000000x%20-%208.doc).

