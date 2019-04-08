# Frequently Asked Questions

Op deze plaats zullen antwoorden opgenomen worden die vaker worden gesteld rondom de mogelijkheden met Kadaster Automatische Akteverwerking.

1. Sommige personen hebben een reeks van huisnummers als woonadres. 
Hoe kan dit in een KIK akte opgenomen?

Antwoord: Dit kan door het eerste huisnummer in huisnummer op te nemen en het laatste huisnummer in huisnummer toevoeging. Om het mooi weer te geven in de akte, is het mogelijk om in huisnummertoevoeing het huisnummer vooraf te laten gaan door een koppelteken en een spatie.
Voorbeeld xml:
```
   <BAG_NummerAanduiding>
        <huisnummer>50</huisnummer>
        <huisnummertoevoeging>- 56</huisnummertoevoeging>
        <postcode>1000AA</postcode>
   </BAG_NummerAanduiding>
```

