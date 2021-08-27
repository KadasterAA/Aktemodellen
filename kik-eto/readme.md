# ETO - Externe Test Omgeving
## Handleiding voor eindgebruikers


## Inleiding
Dit document beschrijft hoe de Externe Test Omgeving (ETO) kan worden gebruikt. De ETO is een testfaciliteit die in het project Automatische Akteverwerking van het Kadaster is ontwikkeld en die externe software leveranciers de mogelijkheid biedt om specifieke resultaten van hun software te verifiëren.

Met de ETO kan men de inhoud van een XML-document vergelijken met die van een PDF akte. Tijdens het verwerken van een akte doet het Kadaster dezelfde vergelijking om te bepalen of de akte automatisch kan worden verwerkt of handmatig moet worden ingevoerd.

### Doelgroep
Deze handleiding is bedoeld voor softwareleveranciers die applicaties ontwikkelen waarmee aktes worden opgesteld die door het Kadaster moeten worden verwerkt. Daarbij gaat het bijvoorbeeld om notarissoftware voor het opstellen van aktes voor hypotheken, beslagleggingen, doorhalingen, etc.
Er wordt verondersteld dat de lezer enige kennis heeft  van webservice technologie.

##	Achtergrond
Het Kadaster kan een aangeleverde (PDF) akte alleen automatisch verwerken als aan deze akte een correct XML-document is gekoppeld. Het Kadaster vergelijkt de inhoud van dat XML-document met die van de akte en bepaalt op basis van het vergelijkingsresultaat of de akte automatisch verwerkt kan worden.
Leveranciers van notaris- en deurwaardersoftware kunnen hun applicatie uitbreiden, zodat naast de PDF-akte ook een XML-document wordt aangemaakt. Met behulp van de in dit document beschreven ETO kunnen zij een PDF-akte en een XML-document vergelijken om te verifiëren of de combinatie door het Kadaster automatisch zou worden verwerkt.

### Vergelijkingsproces
In grote lijnen verloopt het vergelijkingsproces binnen het Kadaster als volgt:
1.	De tekst van de aangeleverde PDF-akte wordt geëxtraheerd.
2.	Op basis van het aangeleverde XML-document wordt een PDF-akte gegenereerd
3.	Van deze gegenereerde PDF-akte wordt eveneens de tekst geëxtraheerd
4.	De beide geëxtraheerde teksten worden onderling vergeleken
Voor een ETO-aanroep moet de inhoud van de essentialia-XML samen met die van de akte-PDF in een verzoekbericht worden opgenomen. De ETO verwerkt dit verzoekbericht en retourneert een antwoordbericht. Dat antwoordbericht bevat naast het vergelijkingsresultaat ook de gegenereerde PDF (stap 2) en geëxtraheerde teksten (stap 1 en 3). Deze extra informatie kan worden gebruikt om de eventueel geconstateerde verschillen nader te analyseren.


### Uitvoeren controles
Het is mogelijk om naast de PDF-vergelijking ook alle validatiecontroles te laten uitvoeren door de ETO web service. Zet daartoe het optionele veld <UitvoerenControles> in het verzoekbericht op true. Het veld <SchematronValidationResult> in het antwoordbericht zal dan een lijst met alle gedetecteerde validatiefouten bevatten.

## Webservice
De ETO is geïmplementeerd als een webservice, die communiceert met SOAP berichten via HTTPS. Er is één type verzoekbericht en één type antwoordbericht. De schema’s (XSD) daarvan zijn opgenomen in de bijlagen. Functionele fouten worden in het responsebericht gemeld, technische fouten worden als SOAP fault geretourneerd.

### Toegang en security
De toegang tot de ETO loopt via een beveiligde TLS verbinding (HTTPS). De webservice vereist HTTP Basic Authentication (naam+wachtwoord, zie RFC2617) en verifieert of het account van de opgegeven naam bekend is en of het is geautoriseerd voor het gebruik van de ETO. Als dat niet het geval is zal een HTTP-error 401 worden geretourneerd.
### Account
Voor het gebruik van de dienst dient een account te worden aangevraagd bij het Kadaster. Dat kan door per email een verzoek daartoe te sturen aan kik@kadaster.nl

### URL’s
Web service: https://service10.kadaster.nl/kik/testenessentialia/

WSDL: https://service10.kadaster.nl/kik/testenessentialia/ws.wsdl

## Eisen voor het gebruik van de ETO
- Gebruik een 32 bits (X86) versie van JAVA 8. De subversie mag niet hoger zijn dan Update 291.
- Zorg dat de JAVA_HOME variabele naar de locale geïnstalleerde versie van de Java JDK verwijst.
- Neem de username en password, horende  bij uw account, op in het bestand pref.propties.

## Bijlage 1: Voorbeeld verzoekbericht
```xml
<?xml version="1.0" encoding="UTF-8"?>
<TestBericht xmlns="http://webservices.kadaster.nl/eto/schemas">
	<AktemodelNummer>20101119000003</AktemodelNummer>
	<EssentialiaBestand>
		<XmlBestand>
PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHRpYTpCZXJpY2h0X1RJQV9T

...

IHZlcnNpZSAyLjguMC4wLS0+Cg==
		</XmlBestand>
		<XmlBestandID>D:\TEST\kik-akte.xml</XmlBestandID>
	</EssentialiaBestand>
	<PdfBestand>
		<PdfAkteBestand>
JVBERi0xLjQKJaqrrK0KNCAwIG9iago8PAovQ3JlYXRvciAoQXBhY2hlIEZPUCBWZXJzaW9uIDEu

...

MwolJUVPRgo=
		</PdfAkteBestand>
		<PdfAkteBestandID>D:\TEST\kik-akte.pdf</PdfAkteBestandID>
	</PdfBestand>
	<DatumAanbiedingStuk>2011-07-07</DatumAanbiedingStuk>
	<UitvoerenControles>true</UitvoerenControles>
</TestBericht>
```

## Bijlage 2: Voorbeeld antwoordbericht
```xml
<ns2:ResultaatBericht xmlns:ns2="http://webservices.kadaster.nl/eto/schemas">
	<ns2:Testresultaat>Ja, XML en PDF komen overeen; er zijn 2 validatiefouten geconstateerd</ns2:Testresultaat>
	<ns2:Testverslag>De essentialia komen overeen met de inhoud van de PDF.</ns2:Testverslag>
	<ns2:SamengesteldeAkte>
		<ns2:PdfSamengesteldeAkteBestand>
JVBERi0xLjQKJaqrrK0KNCAwIG9iago8PAovQ3JlYXRvciAoQXBhY2hlIEZPUCBWZXJ

...

eHJlZgo1MDg2MwolJUVPRgo=
		</ns2:PdfSamengesteldeAkteBestand>
		<ns2:SamengesteledeAkteTekst>Ondergetekende, Drs. Annemarie Doddel, hierna te noemen:
...

Partijen kiezen woonplaats ten kantore van de bewaarder van deze Akte.
</ns2:SamengesteledeAkteTekst>
		<ns2:XmlBestandID>D:\TEST\kik-akte.xml</ns2:XmlBestandID>
	</ns2:SamengesteldeAkte>
	<ns2:OntvangenAkte>
		<ns2:OntvangenAkteTekst>Ondergetekende, Drs. Annemarie Doddel, hierna te noemen:
...

Partijen kiezen woonplaats ten kantore van de bewaarder van deze Akte.
</ns2:OntvangenAkteTekst>
		<ns2:PdfAktebestandID>D:\TEST\kik-akte.pdf</ns2:PdfAktebestandID>
	</ns2:OntvangenAkte>
	<ns2:SchematronValidationResult>{Partij}{1}{tekst}{2950} Waarde 'illegaal' is niet toegestaan voor keuzetekst {k_BurgerlijkeStaatTekst}.
{StukdeelKoop}{1}{datumOndertekening}{2700} Datum koopovereenkomst moet in het verleden liggen.</ns2:SchematronValidationResult>
</ns2:ResultaatBericht>
```