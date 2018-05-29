# Aktemodellen
Kadaster Automatische Akteverwerking

Op deze locatie staat de informatie ten behoeve van software leveranciers die software ontwikkelen ten behoeve van het notariaat. Specifiek staat hier de informatie welke nodig is om zogeheten KIK-Akten te kunnen vervaardigen. 

KIK staat voor Ketenintegratie Inschrijving Kadaster. KIK-Akten beoogt om sneller, met hogere kwaliteit en tegen lagere kosten akten in te kunnen schrijven bij het Kadaster.

We raden aan om een GitHub Desktop te gebruiken om een lokale kopie te creëren van deze repository. Voordelen hiervan zijn dat de inhoud van de repository lokaal op een eigen bestandssysteem beschikbaar is en tegelijkertijd eenvoudig te synchroniseren is met de hier gepubliceerde kopie. Lees pagina https://desktop.github.com/ voor details over de GitHub Desktop.

# Globale release notes
## 29 mei 2018
- De [handleiding voor de Externe Test Omgeving (ETO)](/kik-eto/readme.md) voor KIK-AA hebben we omgezet naar Markdown en uitgebreid met de eisen waaraan voldaan moet worden voor het gebruik van de ETO.

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

