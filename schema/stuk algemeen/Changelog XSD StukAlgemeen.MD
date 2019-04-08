# Changelog XSD StukAlgemeen

## CHANGES XSD StukAlgemeen-8.1.0 DATUM 1 december 2018
o.b.v. AA-4239 
- IMKAD_NietIngezetene geboorteland toegevoegd
- GBA_Geboorte geboorteland toegevoegd

## CHANGES XSD StukAlgemeen-8.0.1 DATUM 1 november 2018
o.b.v. AA-2850
- Legitimatiebewijs plaatsUitgegeven optioneel gemaakt
- Legitimatiebewijs datumUitgegeven optioneel gemaakt
- Legitimatiebewijs datumGeldigTot [0..1] toegevoegd
- Legitimatiebewijs instantieUitgegeven [0..1] toegevoegd

## CHANGES XSD StukAlgemeen-8.0.0 DATUM 7 november 2018
o.b.v. AA-4242, AA-4243 en AA-4241
- definitie kvkNummer toegevoegd: [0-9]{8} (alg-formaattypen-2.0.0.xsd)
- definitie Huisletter toegevoegd: [a-zA-Z] (alg-formaattypen-2.0.0.xsd)
- type NHR_Rechtspersoon/FINummer gewijzigd in KvkNummer
- type IMKAD_OnroerendeZaak/tia_OmschrijvingEigendom gewijzigd naar alg-AN250V
- type BAG_NummerAanduiding/huisletter gewijzigd in Huisletter
- type IMKAD_KadBinnenlandsAdres/huisletter gewijzigd in Huisletter

- IMKAD_AangebodenStuk tia_WoonplaatsKeuze verwijderd
- IMKAD_Persoon tia_ExecuteurVan verwijderd
- GerelateerdPersoon tia_IndPartij verwijderd
- GerelateerdPersoon bevoegdheid verwijderd
- GegevensGevolmachtigde bevoegdheid verwijderd
- GegevensGevolmachtigde naamKantoor verwijderd
- IMKAD_Ondertekenaar tia_Aard verwijderd
- IMKAD_Ondertekenaar tia_KadGegevensOndertekenaar verwijderd
- IMKAD_Ondertekenaar tia_KadGegevensWaarnemerVoor verwijderd
- Verklaarder aard verwijderd
- Verklaarder kadGegevensWaarnemerVoor verwijderd
- AkteOpzeggingsbevoegdheid verwijderd
- KeuzeAkteOpzeggingsbevoegdheid verwijderd
- AkteOpzeggingsbevoegdheidGroup verwijderd
- StukdeelBeslag verwijderd
- StukdeelDoorhalingBeslag verwijderd
- KostenStuk verwijderd

## CHANGES XSD StukAlgemeen-7.0.0 DATUM 18 mei 2018
o.b.v. AA-3724 IMKAD_ZakelijkRecht uitgebreid met:
- tia_Aantal_Rechten
- tia_Aantal_RechtenVariant

Dit om het aantal zakelijke rechten betreffende eigendom welke belast zijn met Opstal, Erfpacht of BP recht respectievelijk zakelijke rechten variant betreffende Opstal, Erfpacht of BP recht aan te geven.


## CHANGES XSD StukAlgemeen-6.3.1 DATUM 12 april 2017

o.b.v. AA-3358 Numerieke definities &#39;StukAlgemeen&#39; aangepast (alg-formaattypen-1.8.1.xsd):

- definitie alg-0N9 toegevoegd t.b.v. BSN
- type IMKAD\_ZakelijkRecht/Aantal\_BP\_Rechten gewijzigd in alg-0N2
- type GBA\_Ingezetene/BSN gewijzigd in alg-0N9

## CHANGES XSD StukAlgemeen-6.3.0 DATUM 17 maart 2017

o.b.v. AA-3179 Numerieke definities &#39;StukAlgemeen&#39; aangepast (alg-formaattypen-1.8.0.xsd):

- definities alg-Nx gewijzigd in: string [1-9][0-9]\*
- definities alg-0N2 en alg-0N12 toegevoegd: string [0-9][0-9]\*
- type NHR\_Rechtspersoon/FINummer gewijzigd in alg-0N12
- type Betaling/betaalDag gewijzigd in alg-0N2
- type Betaling/betaalMaand gewijzigd in alg-0N2

o.b.v. AA-3296 Statutaire zetel maximum lengte 24 verwijderen:

- NHR\_Rechtspersoon/statutaireZetel gewijzigd in alg-AN40V

## CHANGES XSD StukAlgemeen-6.2.0 DATUM 15 april 2016

o.b.v. AA-910 Partnergegevens bij Gevolmachtigde

- StukdeelDoorhalingHypotheek voormaligeRechtspersoonRef [0..\*] toegevoegd
- VoormaligeRechtspersoon
  - id [0..1] toegevoegd

## CHANGES XSD StukAlgemeen-6.1.0 DATUM 16 maart 2016

o.b.v. AA-910 Partnergegevens bij Gevolmachtigde

- Gevolmachtigde
  - partnerGegevens [0..1] toegevoegd t.b.v. Tekstblok Burgerlijke staat
  - id [0..1] toegevoegd (t.b.v. intern gebruik)
- Softwareleverancier
  - bedrijfsnaam [0..1] toegevoegd

## CHANGES XSD StukAlgemeen-6.0.0 DATUM 22 december 2015

o.b.v. AA-2073 Modeldocument Doorhaling Hypotheek

- Notaris
  - voorletters [0..1] toegevoegd t.b.v. voorletters van de ondertekenaar,
- StukdeelDoorhalingHypotheek/volmachtverleningAfstand [0..1]
  - aantalOnderhandseAkten [0..1]
  - datumOndertekening [0..1]
  - naamNotaris [0..1]
  - plaatsNotarisKantoor [0..1]

## CHANGES XSD StukAlgemeen-5.0.0 DATUM 12 november 2015

o.b.v. AA-2284 Tekstblok Rechtspersoon

- NHR\_Rechtspersoon
  - tia\_HandelendOnderNaam [0..1] toegevoegd t.b.v. hypotheeknemer die hypotheek verstrekt onder een andere naam dan de statutaire naam.

## CHANGES XSD StukAlgemeen-4.1.1 DATUM 6 september 2015

o.b.v. AA-2175 BLG Hypotheek

- StukdeelHypotheek
  - bedragOverbruggingslening van type IMKAD\_Bedrag (0..1) gecorrigeerd

## CHANGES XSD StukAlgemeen-4.1.0 DATUM 16 september 2015

o.b.v. AA-2128 Nodes Leverancier toevoegen

- Bericht\_TIA\_Stuk
  - softwareleverancier van type Softwareleverancier (0..1) toegevoegd

CHANGES XSD StukAlgemeen-4.0.0 DATUM 15 juli 2015

o.b.v. AA-1645 BLG Hypotheek

- StukdeelHypotheek
  - bedragOverbruggingslening van type IMKAD\_Bedrag (0..1) toegevoegd

## CHANGES XSD StukAlgemeen-3.0.0 DATUM 10 juli 2015

o.b.v. AA-1529 Juridisch juiste Akte van Verdeling

- StukdeelVerdelingUittredingVennoten toegevoegd
- StukdeelVerdelingHuwelijk
  - plaatsOntbinding optioneel gemaakt
  - gemeenteOntbinding alg-AN80 [0..1] toegevoegd
  - plaatsRechtbank optioneel gemaakt
  - gemeenteRechtbank alg-AN80 [0..1] toegevoegd
  - naamRechtbank alg-AN35 [0..1] toegevoegd
- StukdeelVerdelingPartnerschap
  - plaatsOntbinding optioneel gemaakt
  - gemeenteOntbinding alg-AN80 [0..1] toegevoegd

o.b.v. AA-1620

- NHR\_Rechtspersoon
  - FINummer van type alg-N12 i.p.v. alg-AN12

## CHANGES XSD StukAlgemeen-2.8 DATUM 10 februari 2015

obv CH62044 SNS Hypotheek

- StukdeelHypotheek
  - datumOfferte van type date (0..1) toegevoegd

## CHANGES XSD StukAlgemeen-2.7a DATUM 10 februari 2015

Terugdraaien wijziging uit XSD v2.6 ivm (nog) niet gerealiseerde CH56650

- Hoedanigheid
  - gegevensOndertekening van type GegevensOndertekening (0..1) verwijderd

## CHANGES XSD StukAlgemeen-2.7 DATUM 29 augustus 2014

obv CH54186 PB-model uitgebreid met uitvoerende organisatie

- VerklaringBestuursorgaan
  - naamUitvoerendeOrganisatie van type alg-AN200 (0..1) toegevoegd
  - plaatsUitvoerendeOrganisatie van type alg-AN80 (0..1) toegevoegd

## CHANGES XSD StukAlgemeen-2.6 DATUM 1 augustus 2014

obv CH56650 nr1, nr7 en nr12 ondertekening beschikking toegevoegd aan Hoedanigheid

- Hoedanigheid
  - gegevensOndertekening van type GegevensOndertekening (0..1) toegevoegd

## CHANGES XSD StukAlgemeen-2.5a DATUM 1 augustus 2014

Aanpassingen obv CH57662 CHANGES XSD StukAlgemeen-2.4 DATUM 16 mei 2014 verwijderd omdat CH57662 is teruggetrokken.

- StukdeelVerdelingHuwelijk
  - datumInschrijving (date) optioneel verwijderd

## CHANGES XSD StukAlgemeen-2.5 DATUM 8 juli 2014

obv CH58772 Tekstblok Aanhef, Aanhef NV en Equivalentieverklaring, extra waarneming toegevoegd

- IMKAD\_AangebodenStuk tia\_Verklaarder gewijzigd van verplicht naar optioneel
- Notaris, met attributen persoonsgegevens (1..1), standplaats (0..1), gemeente (0..1) en tekstkeuze (0..\*) toegevoegd
  - IMKAD\_AangebodenStuk heeftOndertekenaar (0..1) Notaris toegevoegd
  - IMKAD\_AangebodenStuk heeftVerklaarder (0..1) Notaris toegevoegd
  - Notaris isWaarnemerVoor (0..1) Notaris toegevoegd
  - Notaris isVacatureWaarnemerVoor (0..1) Notaris toegevoegd

## CHANGES XSD StukAlgemeen-2.4 DATUM 16 mei 2014

obv CH57662 Modeldocument Verdeling tekstkeuzes toegevoegd

- StukdeelVerdelingHuwelijk
  - datumInschrijving (date) optioneel toegevoegd

CHANGES stuk-algemeen XSD 2.3 – 2.3a

- In IMKAD\_Persoon
  - tia\_AanduidingRechtsvorm (alg-AN80) toegevoegd

CHANGES stuk-algemeen XSD 2.2f – 2.3

- Hoedanigheid toegevoegd
- IMKAD\_AangebodenStuk Hoedanigheid (0..\*) toegevoegd
- Partij Hoedanigheid (0..\*) toegevoegd
- Gevolmachtigde vertegenwoordigerRef (0..\*) toegevoegd
- Gevolmachtigde volmachtgeverRef (0..\*) verwijderd
- IMKAD\_Persoon vertegenwoordigerRef (0..\*) toegevoegd

CHANGES stuk-algemeen XSD 2.2e – 2.2f

- In IMKAD\_ZakelijkRecht
  - aardVerkregenVariant (waardenlijst) toegevoegd
- In NHR\_Rechtspersoon
  - statutaireNaam van type alg-AN200

CHANGES stuk-algemeen XSD 2.2d – 2.2e

- In StukdeelErfpachtcanonEeuwigAfgekocht
  - IMKAD\_Bedrag optioneel

CHANGES stuk-algemeen XSD 2.2c – 2.2d

- IMKAD\_ZakelijkRecht attributeGroup correct gemaakt
- In IMKAD\_ZakelijkRecht
  - tia\_BedragKoopprijs mag [0..2] voorkomen

CHANGES stuk-algemeen XSD 2.2b – 2.2c

- In IMKAD\_Persoon
  - tia\_IndGerechtigde(boolean) toegevoegd
  - tia\_AanduidingPersoon (alg-AN80) toegevoegd
- In GerelateerdPersoon
  - tia\_IndPartij optioneel
- In IMKAD\_ZakelijkRecht
  - tia\_BedragKoopprijs mag [0..2] voorkomen
  - tia\_KoopprijsSpecificatie mag [0..2] voorkomen

CHANGES stuk-algemeen XSD 2.2a – 2.2b

- IMKAD\_Stukdeel RegistergoedRef (0..\*) toegevoegd
- Partij partijPersoonRef (0..\*) toegevoegd
- In Partij
  - aandeelInRechten (Aandeel) toegevoegd
- IMKAD\_Gevolmachtigde volmachtgeverRef (0..\*) toegevoegd
- In IMKAD\_Persoon
  - tia\_PartijOnderdeel mag [0..\*] voorkomen
- In IMKAD\_ZakelijkRecht
  - tia\_KoopprijsSpecificatie (KoopprijsSpecificatie) [0..1] toegevoegd
  - id (ID) [0..1] toegevoegd
- In StukdeelErfpachtcanonTijdelijkAfgekocht
  - Bedrag optioneel
- In BAG\_NummerAanduiding
  - huisNummerToevoeging van type alg-AN10
- In IMKAD\_KadBinnenlandsAdres
  - huisNummerToevoeging van type alg-AN10
- In KoopprijsSpecificatie
  - Aanneemsom (IMKAD\_Bedrag) toegevoegd
  - koopprijsTotaal (IMKAD\_Bedrag) toegevoegd
  - vveReservefondssom (IMKAD\_Bedrag) toegevoegd

CHANGES stuk-algemeen XSD 2.2 – 2.2a

- In IMKAD\_Appartementsrecht
  - Aandeel (Aandeel) toegevoegd

CHANGES stuk-algemeen XSD 2.1a – 2.2

- IMKAD\_AangebodenStuk Gevolmachtigde mag 0..\* voorkomen
- Partij Gevolmachtigde mag 0..\* voorkomen
- In Gevolmachtigde:
  - burgerlijkeStaatTekst (Waardelijst) toegevoegd
  - burgerlijkeStaatLand (alg-AN80) toegevoegd
  - gegevensOndertekening (GegevensOndertekening) toegevoegd
  - relatie GerelateerdPersoon toegevoegd
- In IMKAD\_Persoon:
  - tia\_BurgerlijkeStaatLand (alg-AN80) toegevoegd
  - gegevensOndertekening (GegevensOndertekening) toegevoegd
- In VoormaligRechtspersoon
  - rechtsvormSub gewijzigd in Waardelijst
- In StukdeelHypotheek:
  - bedragLening mag 0..\* voorkomen
- In IMKAD\_Perceel
  - stukVerificatiekosten (IMKAD\_DeelEnNummer) toegevoegd
- In IMKAD\_OZLOcatie
  - BAG\_BinnenlandsAdres documentation aangepast in adres conform BAG
  - kadBinnenlandsAdres (IMKAD\_KadBinnenlandsAdres) toegevoegd
- In Legitimatiebewijs:
  - soort gewijzigd in alg-AN100
  - kenmerk gewijzigd in alg-AN100
- GegevensOndertekening (ComplexType) toegevoegd

## CHANGES stuk-algemeen XSD 2.1 – 2.1a

- Partij, vofCvMs -&gt; type gewijzigd in IMKAD\_Persoon

CHANGES stuk-algemeen XSD 2.0b – 2.1

- datumOndertekening in KoopOvereenkomst is optioneel geworden. ##        

CHANGES stuk-algemeen XSD 2.0a – 2.0b

- VoormaligeRechtspersoon toegevoegd
- Tia\_Tekstkeuze in IMKAD\_OnroerendeZaak is 0..\* geworden

## CHANGES stuk-algemeen XSD 2.0 – 2.0a

- StukdeelErfpachtcanon toegevoegd
- StukdeelErpachtcanonTijdelijkAfgekocht toegevoegd
- StukdeelErfpachtcanonEeuwigAfgekocht toegevoegd
- Betaling toegevoegd

CHANGES stuk-algemeen XSD 1.9a – 2.0

- IMKAD\_Persoon, tia\_ExecuteurVan (alg\_AN70) toegevoegd
- IMKAD\_Persoon, relatie met GerelateerdPersoon wordt &#39;0..\*&#39;
- Partij, vofCvMs (NHR\_Rechtspersoon) toegevoegd

## CHANGES stuk-algemeen XSD 1.9 – 1.9a

- Richting relatie van IMKAD\_Persoon naar SimpleLink gewijzigd

## CHANGES stuk-algemeen XSD 1.8c – 1.9

- Het type van de volgende attributen is gewijzigd (was: waardelijst):
  1. Schip, landGebouwdIn (alg-AN50)
  2. StukdeelHypotheek, soortHypotheek (alg-AN20)
  3. IMKAD\_AantekeningKadastraalObject, aard (alg-AN20)
  4. GBA\_Ingezetene, tia\_AdellijkeTitel (alg-AN40)
  5. GBA\_Ingezetene, IMKAD\_KadNatuurlijkPersoon, tia\_AdellijkeTitel2 (alg-AN40)
  6. GBA\_Ingezetene, IMKAD\_KadNatuurlijkPersoon, tia\_Titel (alg-AN40)
  7. IMKAD\_KadNatuurlijkPersoon, adellijkeTitelOfPredikaat (alg-AN40)
  8. BAG\_Woonplaats, woonplaatsNaam (alg-AN80V)
  9. IMKAD\_KadBinnenlandsAdres, woonplaatsNaam (alg-AN80V)
  10. IMKAD\_Ondertekenaar, standplaats (alg-AN80)
  11. Verklaarder, standplaats (alg-AN80)
  12. InformatiePB, naamGemeente (alg-AN80)
  13. InformatiePB, naamBestuursorgaanInfo (alg-AN80)
  14. Legitimatiebewijs, landUitgegeven (alg-AN50)
  15. IMKAD\_DomicilieKeuze, aard (alg-AN50V)

## CHANGES stuk-algemeen XSD 1.8b – 1.8c

- In IMKAD\_Persoon/Id optioneel gemaakt

## CHANGES stuk-algemeen XSD 1.8a – 1.8b

- IMKAD\_AangebodenStuk/tia\_Depotnummer gewijzigd in tia\_DepotnummerTekening
- StukdeelVerdelingHuwelijk/plaatsBurgerlijkeStand gewijzigd in StukdeelVerdelingHuwelijk/plaatsOntbinding
- StukdeelVerdelingHuwelijk/datumAantekeningBurgerlijkeStand gewijzigd in StukdeelVerdelingHuwelijk/datumOntbinding

## CHANGES stuk-algemeen XSD 1.8 – 1.8a

- verkrijgerRechtRef van IMKAD\_ZakelijkRecht naar Partij is 0..\* geworden
- Toedeling toegevoegd
- In IMKAD\_Persoon een XSD-attribuut Id en relatie naar xlinks toegevoegd

## CHANGES stuk-algemeen XSD 1.7c – 1.8

- StukdeelVerdeling:
  - attributen verwijderd
  - opgesplitst in StukdeelVerdelingVennootschap, StukdeelVerdelingHuwelijk, StukdeelVerdelingPartnerschap en StukdeelVerdelingGemeenschap met specifieke attributen.
- In IMKAD\_AangebodenStuk:
  - tia\_Depotnummer toegevoegd
- In IMKAD\_ZakelijkRecht
  - Relatie verkrijgerRechtRef naar Partij toegevoegd

## CHANGES stuk-algemeen XSD 1.7b – 1.7c

- In Bericht\_TIA\_stuk:
  - nummerStylesheet verplicht gemaakt
  - soortStuk en soortStukVariant verwijderd
  - implementatienummer toegevoegd
- In GegevensGevolmachtigde
  - kadGegevensPersoon toegevoegd
  - adresPersoon, cardinaliteit gewijzigd [0..2]
- in IMKAD\_Ondertekenaar
  - tia\_KadGegevensOndertekenaar en tia\_KadGegevensWaarnemerVoor toegevoegd
- in Verklaarder
  - kadGegevensVerklaarder en kadGegevensWaarnemerVoor toegevoegd

## CHANGES stuk-algemeen XSD 1.7a – 1.7b

- In Bericht\_TIA\_stuk:
  - nummerStylesheet optioneel gemaakt
  - soortStuk en soortStukVariant toegevoegd
- Nieuwe klasse StukdeelVerdeling toegevoegd en hierbij behorende klasse Echtscheiding.
- KoopprijsSpecificatie/inclusief opgesplitst in onroerendezakenInclusief en omzetbelastingInclusief

##  CHANGES stuk-algemeen XSD 1.7 – 1.7a

- KadBinnenlandsAdres -&gt; IMKAD\_KadBinnenlandsAdres
- KadNatuurlijkPersoon -&gt; IMKAD\_KadNatuurlijkPersoon
- leningnummer en rangordehypotheek -&gt; type: Alg-N9
- Aan IMKAD\_Persoon is het volgende optionele attribuut toegevoegd:
  - tia\_PartnerGegevens (alg-AN70)
- Nieuwe klasse KoopPrijsSpecificatie toegevoegd met de volgende optionele attributen:
  - omzetbelasting (bedrag)
  - roerendezakenWaarde (bedrag)
  - inclusief (boolean)
  - tekstkeuze (TekstKeuze)
- Aan StukdeelKoop het voglende optionele attribuut toegevoegd
  - koopprijsSpecificatie (KoopprijsSpecificatie)

## CHANGES stuk-algemeen XSD 1.6a – 1.7

- Aan &#39;StukdeelHypotheek&#39;zijn de volgende optionele attributen toegevoegd:
  - rangordeHypotheek (int)
  - leningnummer (int)
  - bedragTotaal (bedrag)
- &#39;KadBinnenlandsAdres&#39; toegevoegd met de volgende attributen:
  - huisLetter
  - huisNummer
  - huisNummerToevoeging
  - openbareRuimteNaam
  - postcode
  - woonplaatsNaam
- &#39;KadNatuurlijkPersoon&#39; toegevoegd met de volgende attributen:
  - adellijkeTitelOfPredikaat
  - geslachtsnaam
  - voornamen
  - voorvoegselsgeslachtsnaam
  - tia\_TekstKeuze
  - tia\_Titel
  - tia\_Titel2
  - tia\_AdellijkeTitel2
- Aan &#39;IMKAD\_Perceel&#39; is het volgende optionele attribuut toegevoegd:
  - tia\_SplitsingsverzoekOrdernummer
- Aan Alg-formaattypen-1.5 is het volgende type toegevoegd:
  - &lt;&lt;XSDsimpleType&gt;&gt; Alg-AN50N (normalizedString toegevoegd)
- Aan &#39;IMKAD\_AdreskeuzeWL&#39; is het volgende attribuut toegevoegd:
  - kadBinnenlandsAdres
- In IMKAD\_WoonlocatiePersoon is de multipliciteit van  IMKAD\_AdreskeuzeWl gewijzigd naar &#39;1 -2&#39;
- In IMKAD\_Persoon is de multipliciteit van tia\_Gegevens gewijzigd naar &#39;1-2&#39;.

CHANGES stuk-algemeen XSD 1.6 – 1.6a

- In &#39;IMKAD\_Persoon&#39; het attribuut &#39;tia\_PartijOnderdeel&#39; (optioneel) toegevoegd

## CHANGES stuk-algemeen XSD 1.5b – 1.6

- In &#39;IMKAD\_AangebodenStuk&#39; het attribuut &#39;tia\_OmschrijvingZaak&#39; (optioneel) toegevoegd
- &#39;StukdeelMandeligheid&#39; toegevoegd met de volgende attributen:
  - Omschrijving (string)
  - Bestaand (boolean)
  - Vervallen (boolean)
- Optioneel attribuut &#39;aandeelInRechten&#39; (Aandeel) toegevoegd aan &#39;IMKAD\_Persoon&#39;

## CHANGES stuk-algemeen XSD 1.5a – 1.5b

-        type van 'soortOvereenkomst'; in 'StukdeelNotarieleVerklaring' gewijzigd in waardenlijst

## CHANGES stuk-algemeen XSD 1.5 – 1.5a

- &#39;StukdeelNotariëleVerklaring&#39; gewijzigd in &#39;StukdeelNotarieleVerklaring&#39;

## CHANGES stuk-algemeen XSD 1.4 – 1.5

-  &#39;StukdeelNotariëleVerklaring&#39; toegevoegd met de volgende attributen:
  - soortOvereenkomst
  - datumOnderhandseOvereenkomst
  - bedragKoopprijs
  - datumLevering
- Attribuut &#39;tia\_BedragKoopprijs&#39; toegevoegd in IMKAD\_ZakelijkRecht
- Attribuut &#39;tia\_TekstKeuze&#39; toegevoegd in GBA\_Ingezetene én in IMKAD\_NietIngezetene
- Attribuut &#39;adresKantoor&#39; optioneel gemaakt in GegevensGevolmachtigde
- Attributen toegevoegd in GegevensGevolmachtigde:
  - adresPersoon
  - legitimatiebewijs
- Attribuut &#39;bevoegdheid&#39; toegevoegd aan GerelateerdPersoon
- Attribuut &#39;tia\_Gemeente&#39; toegevoegd aan Ondertekenaar
- Attribuut &#39;gemeente&#39; toegevoegd aan Verklaarder



## CHANGES stuk-algemeen XSD 1.3 – 1.4

- In &#39;InformatiePB&#39; de volgende attributen toegevoegd:
  - aardPubliekrechtelijkeBeperking
  - naamGemeente
  - naamProvincie
  - naamWaterschap
  - naamMinisterie
- In &#39;InformatiePB&#39; het attribuut &#39;naamBestuursorgaanInfo&#39; optioneel gemaakt. _(Dit attribuut kan tzt vervallen als de oude stylesheet voor WKPB v0.9 niet meer gebruikt wordt.)_
- In &#39;IMKAD\_OnroerendeZaak&#39; het attribuut &#39;tia\_Tekstkeuze&#39; toegevoegd

## CHANGES stuk-algemeen XSD 1.2 – 1.3

Attribuut &#39;aanduidingHypotheek&#39; (optioneel) met waardelijst toegevoegd aan &#39;StukdeelHypotheek&#39;

CHANGES stuk-algemeen XSD 1.1 – 1.2

Corrections to new versions tekstblokken:

- IndGezamenlijkeWoonlocatie (optional) added to &#39;GerelateerdPersoon&#39;
- IndGezamenlijkeToekomstigeWoonlocatie (optional) added to &#39;GerelateerdPersoon&#39;
- IndRegistergoedBewonen (optional) added to &#39;Partij&#39;

## CHANGES stuk-algemeen XSD 1.0 – 1.1 (1.0.1)

Changes related to new versions tekstblokken:

- tia\_titel2 and tia\_AdellijkeTitel2  (optional) added to &#39;GBA\_Ingezetene&#39; and &#39;IMKAD\_NietIngezetene&#39;,
- tia\_TekstKeuze  (optional) added to &#39;IMKAD\_Persoon&#39;,
- tekstKeuze  (optional) added to &#39;GerelateerdPersoon&#39;,
- landGebouwdIn  (optional) added to &#39;Schip&#39;.

Changes related to new version &#39;Levering&#39;:

- tia\_StukVariant (optional) added to &#39;IMKAD\_AangebodenStuk&#39;,
- tia\_Volgnummer  (optional) added to &#39;IMKAD\_Stukdeel&#39;,
- transactiesom made optional in &#39;StukdeelKoop&#39;,
- &#39;StukdeelKoopoptie&#39; added

Changes related to JIRA bug 499

- sterkte changed from integer to D9 (maximum fraction digits is 3) in &#39;Voortstuwing&#39;,
- getal in Inhoud: added maximum fraction digits is 3.

## CHANGES stuk-algemeen XSD 0.81 – 1.0

- Optional element &quot;partnerSpecifiek&quot; added to class Bericht\_TIA\_Stuk, used by the bank information.
- Element &#39;soortHypotheek&#39; from StukdeelHypotheek made optional, this element is not used in the partner specific modeldocument.
- Optional elements &quot;tia\_label&quot; and &quot;tia\_afdeling&quot; added to class IMKAD\_PostlocatiePersoon.
- Element &quot;huisnummer&quot; from &quot;BAG\_NummerAanduiding&quot; changed from mandatory to optional (CQ AAV0600000227).

Changes from v0.72 reversed so XSD remain backward compatible from v0.5:

- &quot;tia\_IndPartij&quot; replaced from IMKAD\_Persoon to GerelateerdPersoon.
- &quot;getal&quot; in Inhoud changes from D7 to D9.

Changes from v0.6 reversed so XSD remain backward compatible from v0.5:

- &quot;tia\_aantalTekeningen&quot; (optional) added to IMKAD\_Perceel.



## CHANGES stuk-algemeen XSD 0.8 – 0.81

Relation from IMKAD\_AangebodenStuk to Partij changed from 1..n to 0..n, because Partij isn&#39;t used for WKPB

## CHANGES stuk-algemeen XSD 0.72 – 0.8

Changes following realisation of KetenPortaalKadaster:

- aanduidingKadastervestiging in Brandmerk changed from AN3 to AN8. (JIRA 122)

alg-Formaattypen-1.3 updated to alg-Formaatttypen-1.4 because of new attribute types.

Changes related to the implementation of WKPB:

- class StukdeelDoorhalingPR\_Beperking,: attribute aardDoorhalingPB has been added
- class Verklaarder: attribute verklaringBestuursorgaan added.
- class VerklaringBestuursorgaan has been added
- class InformatiePB has been added
- IMKAD\_AangebodenStuk: element informatiePR\_Beperking removed.
- class IMKAD\_DeelEnNummer, attribute &quot;reeks&quot;: Annotation updated.
- class StukdeelDoorhalingBeslag: Annotation updated.
- class StukdeelDoorhalingHypotheek: Annotation updated.
- class  IMKAD\_AangebodenStuk: attribute &quot;ondertekenaar&quot; has been made optional because this class isn&#39;t used for WKPB
- class  IMKAD\_AantekeningKadastraalObject: attribute &quot;aard&quot; has been made optional because this attribute isn&#39;t used for WKPB.

CHANGES stuk-algemeen XSD 0.7 – 0.72

Changes from v0.6 reversed so XSD remain backward compatible from v0.5:

- tijdstipOndertekening in IMKAD\_AangebodenStuk removed and replaced by tia\_DatumOndertekening (xs:date) and tia\_TijdOndertekening (xs:time)
- Koopgegevens removed from StukdeelLevering
- StukdeelKoop added with elements which are removed from StukdeelLevering/koopgegevens.
- tia\_BreukdeelOnverdeeldAandeel added in IMKAD\_ZakelijkRecht
- tia\_WetVoorkeursrechtGemeente removed from IMKAD\_AangebodenStuk (tia-Tekstkeuze must be used)
- tia\_IndPartij replaced from GerelateerdPersoon to IMKAD\_Persoon (conform v0.5)

The references to lists of values are removed from the notes of the elements. Depending on the type of document which the XSD is used for, various value lists apply. The relation between the elements and the value lists must be derived from the CVA file for that application.

Added Enums are converted into value lists (for future flexibility with backward compatibility):

-
  - bevoegdheid in GegevensGevolmachtigde
  - rol in GerelateerdPersoon
  - rubriek in Brandmerk
  - soortinhoud in Inhoud
  - eenheid in Inhoud

Changes following realisation of KetenPortaalKadaster ## (not backwards compatible)## :

- tia\_TekstKeuze in IMKAD ZakelijkRecht changed from [0..1] to [0..\*]. (JIRA 121)
- getal in Inhoud changes from N7 to D7. (JIRA 296)
- perceelnummer in IMKAD\_KadastraleAanduiding changed from AN5 to N5. (JIRA 323)
- appartementsindex in IMKAD\_KadastraleAanduiding changed from AN4 to N4.  (JIRA 323)
- huisnummer in BAG\_NummerAanduiding changed from AN5 to N5. (JIRA 329)

Changes relating to the implementation of WKPB:

- classes StukdeelPR\_Beperking, StukdeelWijzigingPR\_Beperking, StukdeelDoorhalingPR\_Beperking and StukdeelHandhavingPR\_Beperking have been added
- class Verklaarder: elements naamBestuursorgaan and  informatiePR\_Beperking added.
- IMKAD\_AangebodenStuk: element informatiePR\_Beperking added.

CHANGES stuk-algemeen XSD 0.61 – 0.7

XSD: Only changes to annotations

- IMKAD\_Perceel/grootte
- GBA\_Geslacht/geslachtsaanduiding
- IMKAD\_NietIngezetene/geslacht

Waardelijsten/codelists:

- renamed:
  - adellijketitelkik.xml &gt; adellijketitel.xml
  - titelingezetenekik.xml &gt; titelingezetene.xml
  - aarddomiciliekeuzekik.xml &gt; aarddomiciliekeuze.xml
  - burgerlijkestaatkik.xml &gt; burgerlijkestaat.xml
  - aardondertekenaarkik.xml &gt; aardondertekenaar.xml
  - kadgem-kodes.xml &gt; kgm.xml
  - woonplaatsenkik.xml &gt; woonplaats.xml
- other list:
  - edi.xml &gt; zak-recht-kodes.xml
  - rechtsvormkik.xml &gt; nnp-kodes.xml
- added:
  - zetel.xml
  - soortdoorhalingkik.xml
  - aanvaardingkik.xml
  - aardbeslagkik.xml
  - soorthypotheekkik.xml
  - wetvoorkeursrechtgemeentekik.xml
- became enum in xsd:
  - bevoegdheidgevolmachtigdekik.xml
  - rolgerelateerdpersoonkik.xml
  - rubriekkik.xml
  - soortinhoudkik.xml
  - eenheidkik.xml

CHANGES stuk-algemeen XSD 0.6 – 0.61

Changes after review

- IMKAD\_Persoon under Partij now has cardinality of 0-n
- StukdeelBeslag/doorTeHalenStuk renamed to doorTeHalenBeslag
- tia\_DatumOndertekening (xs:date) and tia\_TijdOndertekening (xs:time) have been replaced by one element tijdstipOndertekening of type xs:dateTime.

CHANGES stuk-algemeen XSD 0.5 – 0.6

Changes made for the purpose of supporting more types of deeds (deeds of cancellation of mortgage, seizure, and cancellation of seizure).

- StukdeelDoorhalingHypotheek added with elements specific to cancellation of mortgage.
- StukdeelBeslag added with elements specific to seizure.
- StukdeelDoorhalingBeslag added with elements specific to cancellation of seizure.
- StukdeelKoop has been removed, its child elements moved to StukdeelLevering/koop.
- koperRef and verkoperRef added to StukdeelLevering. These are references to those parties that will sell resp. buy, mentioned under KOOP in the deed.
- tia\_BreukdeelOnverdeeldAandeel under IMKAD\_ZakelijkRecht has been removed and replaced by aandeelInRecht. This is used in cancellations of mortgage.
- tia\_Advocaat added to IMKAD\_Domiciliekeuze. This is used in seizures and cancellations of seizure.
- added to IMKAD\_AangebodenStuk, both for cancellation of mortgage:
  - tia\_AantalOnderhandseAktenVolmacht
  - tia\_PlaatsOndertekening
- added to IMKAD\_AangebodenStuk for deed of transfer:
  - tia\_WetVoorkeursrechtGemeente
- IMKAD\_Ondertekenaar/standplaats made optional
- IMKAD\_Ondertekenaar/aard made optional
- tia\_Initialen added to IMKAD\_Ondertekenaar for cancellation of mortgage.
- Verklaarder/standplaats made optional
- Verklaarder/aard made optional
- IMKAD\_Perceel/tia\_aantalTekeningen removed

CHANGES stuk-algemeen XSD 0.4 - 0.5

- tia\_TekstTweedeDeel was changed to type xs:anyType.
- Classes VervreemdersRecht and VerkrijgersRecht removed.
- Instead, a class Partij is introduced which has 1 or more Persons. Partij class is related to AangebodenStuk.
- Gevolmachtigde is child of Partij and child of AangebodenStuk. For deeds of transfer it is always used as child of Partij.
- GerelateerdPersoon class: the relation name &#39;bestuurder&#39; was removed and replaced by an element &#39;rol&#39; which has the role of the related person.
- IMKAD\_Persoon element tia\_IndBestuurderInPrive was renamed to tia\_IndPartij and moved to GerelateerdPersoon.
- Partij has an attribuutgroup XLink and an id attribute which are used for linking to parties from elsewhere in the deed.
- Class Stukdeel has three relations to Partij: vervreemderRechtRef, verkrijgerRechtRef and belanghebbendeRef. These are used to refer to parties using Xlink
- The class \_Recht has an additional relation rechthebbende to IMKAD\_Persoon. This is not relevant for deeds of transfer: needed for seizure deeds which will be supported in future.
- Addition of Stukdeel specializations StukdeelKwalitatieveVerplichting and StukdeelKoop.

- New version of formaattypen XSD is used.
- tia\_Woonplaatskeuze was moved to AangebodenStuk. Cardinality was changed to [0-2] but this is not relevant for deeds of transfer (2 are used in deeds of seizure)
- additional elements &#39;omschrijving&#39;, &#39;vervallen&#39; and &#39;bestaand&#39; for StukdeelErfdienstbaarheid
- cardinality of \_Aantekening tenBehoeveVan assocation changed to [0-n]. It is optional because not used in case of StukdeelKwalitatieveVerplichting.
- cardinality of \_Aantekening tenLasteVan assocation changed to [1-n].
- element beschrijvingVoortstuwingswerktuigen of Schip and Luchtvaartuig has changed cardinality of [0-\*]
- IMKAD\_Leidingnetwerk has an additional element tia\_Typering for the description of the network.
- tia\_BreukdeelOnverdeeldAandeel moved from Koopovereenkomst to IMKAD\_ZakelijkRecht
- VerledenAkte in StukdeelRangwisseling has additional element plaatsNotaris (not relevant for deed of transfer)
- Additional recursive relation from Partij to [0-n] Partij. Not relevant for deed of transfer
- element aardVerkregen of IMKAD\_ZakelijkRecht was made optional. In deed of transfer it is however always filled. It is optional because of another type of deed.
- IMKAD\_Perceel element grootte was made optional because it is not filled when the context is StukdeelErfdienstbaarheid or StukdeelKwalitatieveVerplichting.

CHANGES 0.3 - 0.4:

XSD was changed directly:

- tia\_TekstTweedeDeel was changed to typeless element.

Changes 0.2 - 0.3:

Type of following elements is changed to Waardenlijst because they are restricted to values of the new codelist Woonplaatsen.xml:

statutaireZetel

standplaats Ondertekenaar and Verklaarder

woonplaats BAG\_BinnenlandsAdres

bouwplaats Schip
