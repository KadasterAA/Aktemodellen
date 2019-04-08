# Release notes
Product|Akte van Levering stylesheetnummer 20190301000007 implementatienummer 1|
|---|---|
|**Release**|**April 2019**|
## Wijzigingen

### Tekstblok TB Aanhef
|Wijziging|Omschrijving|Oplossing|
|---|---|---|
AA-4313 | We hebben het mogelijk gemaakt om 'verschijnt' of 'verschijnen' op te nemen in de aanhef. Tot nu toe was alleen de verledentijdsvorm mogelijk terwijl er veel behoefte is om ook de tegenwoordige tijd te kunnen gebruiken. | Tekstblok, Toelichting, Stylesheet| 
AA-3185 | We hebben de aanhalingstekens in de toelichting conform het modeldocument opgenomen. Deze kwamen niet overeen. | Toelichting |
AA-2625 | Voor 'kantoorhoudende te' ontbrak een komma in het model, deze hebben we toegevoegd. | Tekstblok, Toelichting, Stylesheet |

### Tekstblok TB Equivalentieverklaring
|Wijziging|Omschrijving|Oplossing|
|---|---|---|
AA-2625 | Voor 'kantoorhoudende te' ontbrak een komma in het model, deze hebben we toegevoegd. | Tekstblok, Toelichting, Stylesheet |

### Tekstblok TB Legitimatie
|Wijziging|Omschrijving|Oplossing|
|---|---|---|
AA-2850 | We hebben de mogelijkheden uitgebreid met betrekking tot plaats, datum en afgifte door. Deze wijziging maakt het mogelijk om de gegevens van legitimatiebewijzen op te nemen wanneer deze zijn afgegeven door een instantie in plaats van een gemeente. De wens om dit te kunnen is de afgelopen jaren meerdere malen geuit vanuit het notariaat. | Tekstblok, Toelichting, Stylesheet| 

### TB Natuurlijk persoon
|Wijziging|Omschrijving|Oplossing|
|---|---|---|
AA-4239 | We hebben de mogelijkheid om het geboorteland apart op te nemen toegevoegd. De reden hiervoor is dat dit element nu apart wordt geregistreerd in de Basisregistratie Kadaster (BRK) waardoor de gegevenskwaliteit verbetert. Voorheen was het alleen mogelijk om geboorteland en geboorteplaats samen in één veld aan te leveren.| Tekstblok, Toelichting, Stylesheet, Schema| 

### Tekstblok - Partij natuurlijk persoon
|Wijziging|Omschrijving|Oplossing|
|---|---|---|
AA-4305 | De toelichting vermelde ten onrechte op een tweetal plaatsen dat tekstblok gevolmachtigde werd gevolgd door een puntkomma. Dit hebben we gecorrigeerd. Zie voor details de toelichting. | Toelichting | 

### Tekstblok - Partij niet natuurlijk persoon
|Wijziging|Omschrijving|Oplossing|
|---|---|---|
AA-2652 | Wanneer er 2 gerelateerde niet natuurlijke personen in het tekstblok voorkwamen en beiden een correspondentieadres hadden, dan werd alleen van de eerste het correspondentieadres getoond. Dit hebben we opgelost en toont de stylesheet het correspondentieadres bij elke persoon afzonderlijk. | Stylesheet | 

### Tekstblok - Rechtspersoon
|Wijziging|Omschrijving|Oplossing|
|---|---|---|
AA-2736 | De optionele gebruikerskeuze om 'tevens' te tonen in dit tekstblok was niet helemaal correct geïmplementeerd. We hebben dit gecorrigeerd. Nu toont de akte de inhoud van de tekst horende bij de tagnaam 'k_HandelendOnderNaam' getoond. | Stylesheet | 

### Tekstblok TB Registergoed
|Wijziging|Omschrijving|Oplossing|
|---|---|---|
AA-4274 | Het tekstblok toont nu 'even' of 'oneven' bij respectievelijk even of oneven adresreeksen ter verduidelijking van de locatie van een perceel. Op deze manier is het duidelijker welke huisnummers precies bedoeld worden. Dit komt de gegevenskwaliteit ten goede. | Tekstblok, Toelichting, Stylesheet, Java library|

### MD Levering 
|Wijziging|Omschrijving|Oplossing|
|---|---|---|
AA-2088 | We hebben het mogelijk gemaakt om de aktetekst compacter weer te geven wanneer er erfdienstbaarheden over en weer worden gevestigd. De wijzigingen staan opgenomen in toelichting, voorbeeld van zo'n akte hebben we opgenomen in de FAQ map. Daarnaast hebben we het ook mogelijk gemaakt om, optioneel, in de tekst ook aan te geven dat de erfdienstbaarheden ook zijn aanvaard. De wens om dit te kunnen is de afgelopen jaren meerdere malen geuit vanuit het notariaat. Beide aanpassingen zijn optioneel: standaard zal de akte opgemaakt worden als versie 4.6.0 van dit modeldocument. | Modeldocument, Toelichting, Stylesheet|
AA-4357 | De weergave van naam rechtspersoon hebben we verduidelijkt en gecorrigeerd. Eerder werd, met gebruik van de stylesheet, alleen de statutaire naam met de afkorting van de rechtsvorm getoond. Hier dient echter alleen de aanduiding persoon of de statutaire naam van de rechtspersoon te worden getoond, zonder enige aanduiding van de rechtsvorm. | Toelichting, Stylesheet |
AA-4354 | Optionele herhalende keuzetekst ten behoeve van het tonen van verschillende partij-aanduidingen van de personen binnen de hoofdpartij verwijderd uit Partij 2 in Vervreemders, Verkrijgers en Belanghebbenden. Dit was niet mogelijk in Partij 2. | Toelichting |
AA-4319 | In Variant 2: Twee leveringen ontbrak 'Deze/Dit' voor 'koopovereenkomst' (onder het kopje 'KOOP'). Dit hebben we in deze versie opgelost. | Stylesheet |
AA-4220 | Er is een nieuwe generieke waardelijst met nnp-kodes met een extra kolom, code rechtsvorm. Voor dit modeldocument gebruiken we vanaf nu dus niet meer de specifieke waardelijst nnp-kodes_hypotheek. In oktober 2018 hebben we deze wijziging al voor de Rabobank doorgevoerd. | Stylesheet |
AA-2376 | Bij Variant 1.a Koopprijs ‘kaal’ ontbrak de punt achter de koopprijs. Dit hebben we opgelost in deze versie. | Stylesheet |
AA-2729 | In het onderdeel 'Vervreemders, Verkrijgers en Belanghebbenden' stond bij "De verschenen personen, handelend als gemeld..." na personen ten onrechte een spatie voor de komma. Dit hebben we opgelost in deze versie. | Stylesheet | 


### Specificaties
Naam|Versie MD/TB|Versie Toelich.|  |
| --- |--- |--- |---|
Modeldocument Akte van Levering|**[4.7.0]( /kik-modeldocumenten/modeldocumenten/Akte%20van%20levering/20190301000007/Modeldocument%20Akte%20van%20Levering%20v4.7.0.docx)**|**[4.6.0]( /kik-modeldocumenten/modeldocumenten/Akte%20van%20levering/20190301000007/Toelichting%20modeldocument%20Akte%20van%20Levering%204.7.0%20-%20v4.6.0.docx)**| X |
XSD StukAlgemeen|**[8.0.1](/schema/stuk%20algemeen/8.0.1/StukAlgemeen-8.0.1.xsd)**|| X |
Tekstblok - Algemene afspraken modeldocumenten en tekstblokken|[2.6](/kik-modeldocumenten/tekstblokken/Tekstblok%20-%20Algemene%20afspraken%20modeldocumenten%20en%20tekstblokken%20v2.6.docx)||  | 
Toelichting - Comparitie nummering en layout||[1.1.2](/kik-modeldocumenten/tekstblokken/Toelichting%20-%20Comparitie%20nummering%20en%20layout%20v1.1.2.docx)|   |
Tekstblok - Aanhef|**[2.12](/kik-modeldocumenten/tekstblokken/Tekstblok%20-%20Aanhef%20v2.12.docx)**|**[3.6](/kik-modeldocumenten/tekstblokken/Toelichting%20Tekstblok%20-%20Aanhef%202.12%20-%20v3.6.docx)**| X |
Tekstblok - Burgerlijke staat|[1.1](/kik-modeldocumenten/tekstblokken/Tekstblok%20-%20Burgerlijke%20staat%20v1.1.docx)|[1.4](/kik-modeldocumenten/tekstblokken/Toelichting%20Tekstblok%20-%20Burgerlijke%20staat%201.1%20-%20v1.4.docx)|   |
Tekstblok - Equivalentieverklaring|**[3.2](/kik-modeldocumenten/tekstblokken/Tekstblok%20-%20Equivalentieverklaring%20v3.2.docx)**|**[3.8](/kik-modeldocumenten/tekstblokken/Toelichting%20Tekstblok%20-%20Equivalentieverklaring%203.2%20-%20v3.8.docx)**| X |
Tekstblok - Erfpachtcanon|[1.2](/kik-modeldocumenten/tekstblokken/Tekstblok%20-%20Erfpachtcanon%20v1.2.docx)|[1.7.1](/kik-modeldocumenten/tekstblokken/Toelichting%20Tekstblok%20-%20Erfpachtcanon%201.2%20-%20v1.7.1.docx)|   |
Tekstblok - Gevolmachtigde|[2.7](/kik-modeldocumenten/tekstblokken/Tekstblok%20-%20Gevolmachtigde%20v2.7.docx)|[2.8.0](/kik-modeldocumenten/tekstblokken/Toelichting%20Tekstblok%20-%20Gevolmachtigde%202.7%20-%20v2.8.0.docx)|   |
Tekstblok - Legitimatie|**[3.0](/kik-modeldocumenten/tekstblokken/Tekstblok%20-%20Legitimatie%20v3.0.docx)**|**[3.0](/kik-modeldocumenten/tekstblokken/Toelichting%20Tekstblok%20-%20Legitimatie%203.0%20-%20v3.0.docx)**| X |
Tekstblok - Natuurlijk persoon|**[2.5](/kik-modeldocumenten/tekstblokken/Tekstblok%20-%20Natuurlijk%20persoon%20v2.5.docx)**|**[3.1](/kik-modeldocumenten/tekstblokken/Toelichting%20Tekstblok%20-%20Natuurlijk%20persoon%202.5%20-%20v3.1.docx)**| X |
Tekstblok - Partij natuurlijk persoon|[3.2](/kik-modeldocumenten/tekstblokken/Tekstblok%20-%20Partij%20natuurlijk%20persoon%20v3.2.docx)|**[3.10](/kik-modeldocumenten/tekstblokken/Toelichting%20Tekstblok%20-%20Partij%20natuurlijk%20persoon%203.2%20-%20v3.10.docx)**| X |
Tekstblok - Partij niet natuurlijk persoon|[3.3.0](/kik-modeldocumenten/tekstblokken/Tekstblok%20-%20Partij%20niet%20natuurlijk%20persoon%20v3.3.0.docx)|[4.2.0](/kik-modeldocumenten/tekstblokken/Toelichting%20Tekstblok%20-%20Partij%20niet%20natuurlijk%20persoon%203.3.0%20-%20v4.2.0.docx)|   |
Tekstblok - Personalia van Natuurlijk persoon|[1.0](/kik-modeldocumenten/tekstblokken/Tekstblok%20-%20Personalia%20van%20Natuurlijk%20persoon%20v1.0.docx)|[1.4](/kik-modeldocumenten/tekstblokken/Toelichting%20Tekstblok%20-%20Personalia%20van%20Natuurlijk%20persoon%201.0%20-%20v1.4.docx)|   |
Tekstblok - Recht|[2.7](/kik-modeldocumenten/tekstblokken/Tekstblok%20-%20Recht%20v2.7.docx)|[2.9](/kik-modeldocumenten/tekstblokken/Toelichting%20Tekstblok%20-%20Recht%202.7%20-%20v2.9.docx)|  |
Tekstblok - Rechtspersoon|[2.8.0](/kik-modeldocumenten/tekstblokken/Tekstblok%20-%20Rechtspersoon%20v2.8.0.docx)|[2.11.0](/kik-modeldocumenten/tekstblokken/Toelichting%20Tekstblok%20-%20Rechtspersoon%202.8.0%20-%20v2.11.0.docx)|   |
Tekstblok - Registergoed|**[2.8.1](/kik-modeldocumenten/tekstblokken/Tekstblok%20-%20Registergoed%20v2.8.1.docx)**|**[2.13.0](/kik-modeldocumenten/tekstblokken/Toelichting%20Tekstblok%20-%20Registergoed%202.8.1%20-%20v2.13.0.docx)**| X | 
Tekstblok - Woonadres|[2.1](/kik-modeldocumenten/tekstblokken/Tekstblok%20-%20Woonadres%20v2.1.docx)|[2.4](/kik-modeldocumenten/tekstblokken/Toelichting%20Tekstblok%20-%20Woonadres%202.1%20-%20v2.4.docx)|   |
X = nieuw of gewijzigd voor dit stylesheet- en implementatienummer, vetgedrukte versienummers zijn gewijzigd.