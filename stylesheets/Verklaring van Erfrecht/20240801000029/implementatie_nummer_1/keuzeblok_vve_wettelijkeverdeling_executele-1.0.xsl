<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exslt="http://exslt.org/common" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:kef="nl.kadaster.xslt.XslExtensionFunctions" exclude-result-prefixes="xsl exslt xlink kef" version="1.0">
	<xsl:template match="executele">
		<xsl:variable name="variant" select="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_variant']/tekst, $upper, $lower)"/>
		<h3 class="header">
			<u>
				<xsl:text>EXECUTELE</xsl:text>
				<xsl:if test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_afwikkelingsbewind']/tekst, $upper, $lower)='true'">
					<xsl:text> EN AFWIKKELINGSBEWIND</xsl:text>
				</xsl:if>
			</u>
		</h3>
		<xsl:choose>
			<xsl:when test="$variant = 'a'">
				<p>
					<xsl:text>In gemeld testament, van </xsl:text>
					<xsl:value-of select="kef:convertDateToText(datum)"/>
					<xsl:text>, heeft de </xsl:text>
					<xsl:value-of select="$overledeneAanduiding"/>
					<xsl:text> </xsl:text>
					<xsl:value-of select="$zijnHaar"/>
					<xsl:text> genoemde </xsl:text>
					<xsl:value-of select="$benamingPartner"/>
					<xsl:text> benoemd tot executeur. De genoemde </xsl:text>
					<xsl:value-of select="$benamingPartner"/>
					<xsl:text> van de overledene heeft deze benoeming aanvaard. Hiervan blijkt uit een onderhandse verklaring van zuivere aanvaarding en aanvaarding executele.</xsl:text>
				</p>
				<p>
					<b>
						<xsl:text>Taken/bevoegdheden executeur</xsl:text>
					</b>
				</p>
				<p>
					<xsl:text>De executeur heeft de taak en de bevoegdheid om de nalatenschap van de overledene te beheren. De executeur is bevoegd de door hem beheerde goederen te gelde te maken, voor zover dit nodig is om de schulden van de nalatenschap te voldoen. De executeur behoeft voor de tegeldemaking van een goed geen toestemming van de erfgenamen. Gedurende het beheer vertegenwoordigt de executeur de erfgenamen in en buiten rechte waar het de nalatenschap betreft. De executeur kan ook als wederpartij van zichzelf optreden.</xsl:text>
				</p>
			</xsl:when>
			<xsl:when test="$variant = 'b'">
				<p>
					<xsl:text>In gemeld testament, van </xsl:text>
					<xsl:value-of select="kef:convertDateToText(datum)"/>
					<xsl:text>, heeft de </xsl:text>
					<xsl:value-of select="$overledeneAanduiding"/>
					<xsl:text> </xsl:text>
					<xsl:value-of select="$zijnHaar"/>
					<xsl:text> </xsl:text>
					<xsl:value-of select="$benamingPartner"/>
					<xsl:text> tot executeur-afwikkelingsbewindvoerder benoemd.</xsl:text>
					<xsl:choose>
						<xsl:when test="translate($partner/gegevens/GBA_Ingezetene/geslacht/geslachtsaanduiding,$upper,$lower) = 'man'">
							<xsl:text> Hij </xsl:text>
						</xsl:when>
						<xsl:when test="translate($partner/gegevens/GBA_Ingezetene/geslacht/geslachtsaanduiding,$upper,$lower) = 'vrouw'">
							<xsl:text> Zij </xsl:text>
						</xsl:when>
					</xsl:choose>
					<xsl:text> heeft de benoeming aanvaard. </xsl:text>
				</p>
				<p>
					<xsl:text>Hiervan blijkt uit gemelde verklaring van aanvaarding executele en afwikkelingsbewind.</xsl:text>
				</p>
				<p>
					<b>
						<xsl:text>Taken en bevoegdheden executeur-afwikkelingsbewindvoerder</xsl:text>
					</b>
				</p>
				<p>
					<xsl:text>De executeur-afwikkelingsbewindvoerder, hierna ook te noemen ‘afwikkelingsbewindvoerder’, heeft tot taak de goederen van de nalatenschap te beheren, de vorderingen te innen en de schulden van de nalatenschap te voldoen die tijdens zijn/haar beheer uit die goederen behoren te worden voldaan, waaronder begrepen, voor zover van toepassing, het afgeven van legaten.</xsl:text>
				</p>
				<p>
					<xsl:text>Daarnaast is de afwikkelingsbewindvoerder bevoegd om over de goederen van de nalatenschap van de </xsl:text>
					<xsl:value-of select="$overledeneAanduiding"/>
					<xsl:text> te beschikken en om zelfstandig een verdeling van de nalatenschap tot stand te brengen, zonder medewerking, zonder machtiging of goedkeuring van de rechthebbende(n) of de (kanton)rechter.</xsl:text>
				</p>
				<p>
					<xsl:text>De executeur-afwikkelingsbewindvoerder is aldus onder meer bevoegd om de nalatenschap te verdelen bij notariële akte (ook partieel), alsmede goederen van de nalatenschap te vervreemden.</xsl:text>
					<xsl:if test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_wederpartij']/tekst, $upper, $lower)='true'">
						<xsl:text> De afwikkelingsbewindvoerder kan ook als wederpartij van zichzelf optreden.</xsl:text>
					</xsl:if>
				</p>
			</xsl:when>
			<xsl:when test="$variant = 'c'">
				<xsl:variable name="persoonRef" select="persoonRef/@xlink:href"/>
				<xsl:variable name="executeur" select="$opsommingPersonen/IMKAD_Persoon[@id = substring-after($persoonRef,'#')]"/>
				<xsl:variable name="geslacht" select="$executeur/gegevens/GBA_Ingezetene/geslacht/geslachtsaanduiding"/>
				<p>
					<xsl:text>In gemeld testament, van </xsl:text>
					<xsl:value-of select="kef:convertDateToText(datum)"/>
					<xsl:text>, heeft de </xsl:text>
					<xsl:value-of select="$overledeneAanduiding"/>
					<xsl:text> tot executeur benoemd: </xsl:text>
					<xsl:call-template name="tb-NatuurlijkPersoon">
						<xsl:with-param name="persoon" select="$executeur"/>
					</xsl:call-template>
					<xsl:text>. </xsl:text>
					<xsl:choose>
						<xsl:when test="translate($geslacht,$upper,$lower) = 'man'">
							<xsl:text>Hij </xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>Zij </xsl:text>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:text> heeft de benoeming aanvaard. Hiervan blijkt uit een onderhandse verklaring van aanvaarding executele.</xsl:text>
				</p>
				<p>
					<b>
						<xsl:text>Taken en bevoegdheden executeur</xsl:text>
					</b>
				</p>
				<p>
					<xsl:text>De executeur heeft de taak en de bevoegdheid om de nalatenschap van de overledene te beheren. De executeur is bevoegd de door </xsl:text>
					<xsl:choose>
						<xsl:when test="translate($geslacht,$upper,$lower) = 'man'">
							<xsl:text>hem </xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>haar </xsl:text>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:text>beheerde goederen te gelde te maken, voor zover dit nodig is om de schulden van de nalatenschap te voldoen.</xsl:text>
					<xsl:if test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_tegeldemaking']/tekst, $upper, $lower)='true'">
						<xsl:text> De executeur behoeft voor de tegeldemaking van een goed geen toestemming van de erfgenamen.</xsl:text>
					</xsl:if>
					<xsl:text> Gedurende het beheer vertegenwoordigt de executeur de erfgenamen in en buiten rechte waar het de nalatenschap betreft.</xsl:text>
					<xsl:if test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_wederpartij']/tekst, $upper, $lower)='true'">
						<xsl:text> De executeur kan ook als wederpartij van zichzelf optreden.</xsl:text>
					</xsl:if>
				</p>
			</xsl:when>
			<xsl:when test="$variant = 'd'">
				<xsl:variable name="persoonRef" select="persoonRef/@xlink:href"/>
				<xsl:variable name="executeur" select="$opsommingPersonen/IMKAD_Persoon[@id = substring-after($persoonRef,'#')]"/>
				<xsl:variable name="geslacht" select="$executeur/GBA_Ingezetene/geslacht/geslachtsaanduiding"/>
				<p>
					<xsl:text>In gemeld testament, van </xsl:text>
					<xsl:value-of select="kef:convertDateToText(datum)"/>
					<xsl:text>, heeft de </xsl:text>
					<xsl:value-of select="$overledeneAanduiding"/>
					<xsl:text> tot executeur-afwikkelingsbewindvoerder benoemd: </xsl:text>
					<xsl:call-template name="tb-NatuurlijkPersoon">
						<xsl:with-param name="persoon" select="$executeur"/>
					</xsl:call-template>
					<xsl:text>.</xsl:text>
					<xsl:choose>
						<xsl:when test="translate($geslacht,$upper,$lower) = 'man'">
							<xsl:text> Hij </xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text> Zij </xsl:text>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:text> heeft de benoeming aanvaard.</xsl:text>
				</p>
				<p>
					<xsl:text>Hiervan blijkt uit gemelde verklaring van aanvaarding executele en afwikkelingsbewind.</xsl:text>
				</p>
				<p>
					<b>
						<xsl:text>Taken en bevoegdheden executeur-afwikkelingsbewindvoerder</xsl:text>
					</b>
				</p>
				<p>
					<xsl:text>De executeur-afwikkelingsbewindvoerder, hierna ook te noemen 'afwikkelingsbewindvoerder', heeft tot taak de goederen van de nalatenschap te beheren, de vorderingen te innen en de schulden van de nalatenschap te voldoen die tijdens haar beheer uit die goederen behoren te worden voldaan, waaronder begrepen, voor zover van toepassing, het afgeven van legaten.</xsl:text>
				</p>
				<p>
					<xsl:text>Daarnaast is de afwikkelingsbewindvoerder bevoegd om over de goederen van de nalatenschap van de </xsl:text>
					<xsl:value-of select="$overledeneAanduiding"/>
					<xsl:text> te beschikken en om zelfstandig een verdeling van de nalatenschap tot stand te brengen, zonder medewerking, zonder machtiging of goedkeuring van de rechthebbende(n) of de (kanton)rechter. De executeur-afwikkelingsbewindvoerder is aldus onder meer bevoegd om de nalatenschap te verdelen bij notariële akte (ook partieel), alsmede goederen van de nalatenschap te vervreemden.</xsl:text>
					<xsl:if test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_wederpartij']/tekst, $upper, $lower)='true'">
						<xsl:text> De afwikkelingsbewindvoerder kan ook als wederpartij van zichzelf optreden.</xsl:text>
					</xsl:if>
				</p>
			</xsl:when>
			<xsl:when test="$variant = 'e'">
				<xsl:variable name="persoonRef1" select="persoonRef[1]/@xlink:href"/>
				<xsl:variable name="executeur1" select="$opsommingPersonen/IMKAD_Persoon[@id = substring-after($persoonRef1,'#')]"/>
				<xsl:variable name="persoonRef2" select="persoonRef[2]/@xlink:href"/>
				<xsl:variable name="executeur2" select="$opsommingPersonen/IMKAD_Persoon[@id = substring-after($persoonRef2,'#')]"/>
				<p>
					<xsl:text>In gemeld testament, van </xsl:text>
					<xsl:value-of select="kef:convertDateToText(datum)"/>
					<xsl:text>, heeft de </xsl:text>
					<xsl:value-of select="$overledeneAanduiding"/>
					<xsl:text> tot executeurs benoemd: </xsl:text>
					<xsl:call-template name="tb-NatuurlijkPersoon">
						<xsl:with-param name="persoon" select="$executeur1"/>
					</xsl:call-template>
					<xsl:text> en </xsl:text>
					<xsl:call-template name="tb-NatuurlijkPersoon">
						<xsl:with-param name="persoon" select="$executeur2"/>
					</xsl:call-template>
					<xsl:text>.</xsl:text>
				</p>
				<p>
					<xsl:text>Zij hebben de benoeming aanvaard. Hiervan blijkt uit twee onderhandse verklaringen van aanvaarding executele.</xsl:text>
				</p>
				<xsl:if test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_volmacht']/tekst, $upper, $lower)='true'">
					<p>
						<xsl:text>Voor het afwikkelen van de bank- en financiële zaken van de </xsl:text>
						<xsl:value-of select="$overledeneAanduiding"/>
						<xsl:text> hebben de executeurs elkaar over en weer een volmacht gegeven, zodat zij ieder afzonderlijk bevoegd zijn.</xsl:text>
					</p>
				</xsl:if>
				<p>
					<b>
						<xsl:text>Taken en bevoegdheden executeur</xsl:text>
					</b>
				</p>
				<p>
					<xsl:text>De executeurs hebben de taak en de bevoegdheid om de nalatenschap van de </xsl:text>
					<xsl:value-of select="$overledeneAanduiding"/>
					<xsl:text> te beheren. De executeurs zijn bevoegd de door hen beheerde goederen te gelde te maken, voor zover dit nodig is om de schulden van de nalatenschap te voldoen.</xsl:text>
					<xsl:if test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_tegeldemaking']/tekst, $upper, $lower)='true'">
						<xsl:text> De executeurs behoeven voor de tegeldemaking van een goed geen toestemming van de erfgenamen.</xsl:text>
					</xsl:if>
					<xsl:text> Gedurende het beheer vertegenwoordigen de executeurs de erfgenamen in en buiten rechte waar het de nalatenschap betreft.</xsl:text>
					<xsl:if test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_wederpartij']/tekst, $upper, $lower)='true'">
						<xsl:text> De executeurs kunnen ook als wederpartij van zichzelf optreden.</xsl:text>
					</xsl:if>
				</p>
			</xsl:when>
			<xsl:when test="$variant = 'f'">
				<xsl:variable name="persoonRef1" select="persoonRef[1]/@xlink:href"/>
				<xsl:variable name="executeur1" select="$opsommingPersonen/IMKAD_Persoon[@id = substring-after($persoonRef1,'#')]"/>
				<xsl:variable name="persoonRef2" select="persoonRef[2]/@xlink:href"/>
				<xsl:variable name="executeur2" select="$opsommingPersonen/IMKAD_Persoon[@id = substring-after($persoonRef2,'#')]"/>
				<p>
					<xsl:text>In gemeld testament van </xsl:text>
					<xsl:value-of select="kef:convertDateToText(datum)"/>
					<xsl:text> heeft de </xsl:text>
					<xsl:value-of select="$overledeneAanduiding"/>
					<xsl:text> tot executeur-afwikkelingsbewindvoerders benoemd: </xsl:text>
					<xsl:call-template name="tb-NatuurlijkPersoon">
						<xsl:with-param name="persoon" select="$executeur1"/>
					</xsl:call-template>
					<xsl:text> en </xsl:text>
					<xsl:call-template name="tb-NatuurlijkPersoon">
						<xsl:with-param name="persoon" select="$executeur2"/>
					</xsl:call-template>
					<xsl:text>.</xsl:text>
				</p>
				<p>
					<xsl:text>Zij hebben de benoeming aanvaard. Hiervan blijkt uit twee verklaringen van aanvaarding executele en afwikkelingsbewind.</xsl:text>
				</p>
				<xsl:if test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_volmacht']/tekst, $upper, $lower)='true'">
					<p>
						<xsl:text>Voor het afwikkelen van de bank- en financiële zaken van </xsl:text>
						<xsl:value-of select="$overledeneAanduiding"/>
						<xsl:text> hebben de executeurs-afwikkelingsbewindvoerders elkaar over en weer een ondervolmacht gegeven, zodat zij ieder afzonderlijk bevoegd zijn.</xsl:text>
					</p>
				</xsl:if>
				<p>
					<b>
						<xsl:text>Taken en bevoegdheden executeur-afwikkelingsbewindvoerder</xsl:text>
					</b>
				</p>
				<p>
					<xsl:text>De executeur-afwikkelingsbewindvoerders, hierna ook te noemen ‘afwikkelingsbewindvoerders’, hebben tot taak de goederen van de nalatenschap te beheren, de vorderingen te innen en de schulden van de nalatenschap te voldoen die tijdens hun beheer uit die goederen behoren te worden voldaan, waaronder begrepen, voor zover van toepassing, het afgeven van legaten.</xsl:text>
				</p>
				<p>
					<xsl:text>Daarnaast zijn de afwikkelingsbewindvoerders bevoegd om over de goederen van de nalatenschap van de </xsl:text>
					<xsl:value-of select="$overledeneAanduiding"/>
					<xsl:text> te beschikken en om zelfstandig een verdeling van de nalatenschap tot stand te brengen, zonder medewerking, zonder machtiging of goedkeuring van de rechthebbende(n) of de (kanton)rechter. De executeur-afwikkelingsbewindvoerders zijn aldus onder meer bevoegd om de nalatenschap te verdelen bij notariële akte (ook partieel), alsmede goederen van de nalatenschap te vervreemden.</xsl:text>
					<xsl:if test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_wederpartij']/tekst, $upper, $lower)='true'">
						<xsl:text> De afwikkelingsbewindvoerders kunnen ook als wederpartij van zichzelf optreden.</xsl:text>
					</xsl:if>
				</p>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
