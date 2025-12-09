# Changelog XSD RabobankHypotheekakte

## CHANGES XSD RabobankHypotheekakte-2.0 DATUM 9 december 2025

AA-8931 - Optie 'onbekend' toegevoegd voor 'rabo:geslachtsaanduiding'.

## CHANGES XSD RabobankHypotheekakte-1.5.1 DATUM 7 december 2018

o.b.v. AA-4298 Compatibiliteitsprobleem stylesheet met nieuwe XSD versie 1.5:
- Het bleek dat niet alle XML's compatible waren met de bestaande stylesheet om de Rabobank hypotheekakte te maken. Door de namespace gelijk te houden met versie 1.4 van het XSD van de Rabobank voorkomen we dit probleem. Om wendbaarder te zijn zullen we net als voor StukAlgemeen in de toekomst de versieaanduiding in de namespaces van de partnerspecifieke XSD's gaan verwijderen.

## CHANGES XSD RabobankHypotheekakte-1.5 DATUM 7 november 2018

o.b.v. AA-1550 Opschoning overbodige elementen:
- BankHypotheek verwijderd
- AlgemeneVoorwaarden verwijderd
- AlgemeneVoorwaardenBank verwijderd
- IMKAD_AdreskeuzeWI  verwijderd
- BAG_BinnenlandsAdres  verwijderd
- IMKAD_KadBinnenlandsAdres verwijderd

