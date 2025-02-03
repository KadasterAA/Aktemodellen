# tekstvergelijking

```
 
 De volgende beide stappen uitvoeren om de ALL testen af te starten:

Stap 1:

# starten van de alltesten:
Zonder testen:
mvn clean install -DskipTests -Dcucumber.reporting.skip=true

Dan stap 2:

Met alle testen:
mvn verify --projects nl.kadaster.aa.controle.tekstvergelijking:tekstvergelijking-testen -Dtest=*ALL

Of per soort akte bij stap 2:
- in plaats van de ster:
Hypotheek
DoorhalingHypotheek
NotarieleVerklaring
Verdeling
Levering
VerklaringvanErfrecht
Tekstblokken

=====================================================================================================================


 curl -X POST "http://localhost:13020/api/1.0/stel-pdf-samen"  \
 -H "Content-Type: multipart/form-data"  \
 -F "essentialia=@essentialia.xml;type= application/xml" \
 --output akte.pdf

 curl -X POST "http://aa-controleren.fto.kadaster.nl/tekstvergelijking/api/1.0/stel-pdf-samen"   \
 -H "Content-Type: multipart/form-data"   \
 -F "essentialia=@essentialia.xml;type= application/xml"  \
 --output akte.pdf


curl -X POST "http://localhost:13020/api/1.0/uitvoeren-tekstvergelijking/"  \
 -H "Content-Type: multipart/form-data"  \
 -F "essentialia=@aabl_scenario_1.xml;type= application/xml" \
 -F "pdf=@aabl_scenario_1.pdf;type= application/xml" --output resultaat.json

curl -X POST "http://aa-controleren.fto.kadaster.nl/tekstvergelijking/api/1.0/uitvoeren-tekstvergelijking/"  \
 -H "Content-Type: multipart/form-data"  \
 -F "essentialia=@scenario01.xml;type= application/xml" \
 -F "pdf=@scenario01.pdf;type= application/xml"
 
curl -X POST "http://localhost:13020/api/1.0/geef-extractedtext"  \
 -H "Content-Type: multipart/form-data"  \
 -F "pdf=@20190730002251.pdf;type= application/xml" --output resultaat.json
 
curl -X POST "http://aa-controleren.fto.kadaster.nl/tekstvergelijking/api/1.0/geef-extractedtext"  \
 -H "Content-Type: multipart/form-data"  \
 -F "pdf=@20190730002251.pdf;type= application/xml" --output resultaat.json

 ---------------
 
 ```
