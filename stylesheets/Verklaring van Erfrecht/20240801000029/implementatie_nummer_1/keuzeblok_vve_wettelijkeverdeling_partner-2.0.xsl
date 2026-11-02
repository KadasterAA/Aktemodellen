<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exslt="http://exslt.org/common" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:kef="nl.kadaster.xslt.XslExtensionFunctions" exclude-result-prefixes="xsl exslt xlink kef" version="1.0">
	<xsl:template match="partners">

		<h3 class="header">
			<u>BURGERLIJKE STAAT</u>
		</h3>
		<p>
			<xsl:text>De </xsl:text>
			<xsl:value-of select="$overledeneAanduiding"/>
			<xsl:text> was </xsl:text>
			<xsl:value-of select="partnerOverledene/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_tentijde']/tekst"/>
			<xsl:text> van </xsl:text>
			<xsl:value-of select="$zijnHaar"/>
			<xsl:text> overlijden </xsl:text>
			<xsl:choose>
				<xsl:when test="translate(partnerOverledene/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_burgerlijkestaat']/tekst,$upper, $lower) = 'huwelijk'">
					<xsl:text>gehuwd met </xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>geregistreerd partner van </xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:call-template name="tb-NatuurlijkPersoon">
				<xsl:with-param name="persoon" select="$partner"/>
			</xsl:call-template>
			<xsl:text>.</xsl:text>
		</p>
		<p>
			<xsl:text>Gemeld </xsl:text>
			<xsl:value-of select="partnerOverledene/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_burgerlijkestaat']/tekst"/>
			<xsl:text> is ontbonden door </xsl:text>
			<xsl:value-of select="partnerOverledene/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_overlijden']/tekst"/>
			<xsl:text>.</xsl:text>
		</p>


		<xsl:variable name="aantalHuwelijk" select="count(eerderePartner/tekstkeuze/tekst[text()='huwelijk'])"/>
		<xsl:variable name="aantalGeregistreerdPartner" select="count(eerderePartner/tekstkeuze/tekst[text()='geregistreerd partnerschap'])"/>

		<xsl:if test="eerderePartner">
			<p>
				<xsl:text>De </xsl:text>
				<xsl:value-of select="$overledeneAanduiding"/>
				<xsl:text> is eerder </xsl:text>
				<xsl:if test="$aantalHuwelijk > 1 or $aantalGeregistreerdPartner > 1">
					<xsl:text>achtereenvolgens </xsl:text>
				</xsl:if>
				<xsl:choose>
					<xsl:when test="$aantalHuwelijk > 0 and $aantalGeregistreerdPartner > 0">
						<xsl:text>gehuwd geweest met of geregistreerd partner geweest van:</xsl:text>
					</xsl:when>
					<xsl:when test="$aantalHuwelijk > 0">
						<xsl:text>gehuwd geweest met:</xsl:text>
					</xsl:when>
					<xsl:when test="$aantalGeregistreerdPartner > 0">
						<xsl:text>geregistreerd partner geweest van:</xsl:text>
					</xsl:when>
				</xsl:choose>
			</p>
			<table cellspacing="0" cellpadding="0">
				<tbody>
					<xsl:for-each select="eerderePartner">
						<xsl:variable name="eerderePartnerRef" select="partnerRef/@xlink:href"/>
						<xsl:variable name="eerderePartner" select="$opsommingPersonen/IMKAD_Persoon[@id = substring-after($eerderePartnerRef,'#')]"/>
						<xsl:choose>
							<xsl:when test="$aantalHuwelijk + $aantalGeregistreerdPartner = 1">
								<tr>
									<td>
										<xsl:call-template name="tb-NatuurlijkPersoon">
											<xsl:with-param name="persoon" select="$eerderePartner"/>
										</xsl:call-template>
										<xsl:text>.</xsl:text>
									</td>
								</tr>
								<tr>
									<td>
										<xsl:call-template name="keuzeOntbonden"/>
									</td>
								</tr>
							</xsl:when>
							<xsl:otherwise>
								<tr>
									<td class="number">
										<xsl:number value="position()" format="a"/>
										<xsl:text>.</xsl:text>
									</td>
									<td>
										<xsl:call-template name="tb-NatuurlijkPersoon">
											<xsl:with-param name="persoon" select="$eerderePartner"/>
										</xsl:call-template>
										<xsl:text>.</xsl:text>
									</td>
								</tr>
								<tr>
									<td class="number"/>
									<td>
										<xsl:call-template name="keuzeOntbonden"/>
									</td>
								</tr>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
				</tbody>
			</table>
		</xsl:if>
		<p>
			<xsl:choose>
				<xsl:when test="translate(partnerOverledene/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_huwelijksvermogensrecht']/tekst,$upper, $lower) = 'algehele'">
					<xsl:text>Het Nederlandse huwelijksvermogensrecht was van toepassing. Tussen de echtgenoten bestond een algehele gemeenschap van goederen zoals deze tot één januari tweeduizend achttien in artikel 1:94 Burgerlijk Wetboek was opgenomen.</xsl:text>
				</xsl:when>
				<xsl:when test="translate(partnerOverledene/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_huwelijksvermogensrecht']/tekst,$upper, $lower) = 'beperkte'">
					<xsl:text>Het Nederlandse huwelijksvermogensrecht was van toepassing. Tussen de echtgenoten bestond een beperkte gemeenschap van goederen zoals deze vanaf één januari tweeduizend achttien in artikel 1:94 Burgerlijk Wetboek is opgenomen.</xsl:text>
				</xsl:when>
			</xsl:choose>
		</p>
		<h3 class="header">
			<u>ONTBONDEN GEMEENSCHAP VAN GOEDEREN</u>
		</h3>
		<xsl:choose>
			<xsl:when test="partnerOverledene/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_ontbondengemeenschap']/tekst = '1'">
				<p>
					<xsl:text>De nalatenschap omvat, naast eventueel eigen vermogen van de </xsl:text>
					<xsl:value-of select="$overledeneAanduiding"/>
					<xsl:text>, de helft van de door </xsl:text>
					<xsl:value-of select="$zijnHaar"/>
					<xsl:text> overlijden ontbonden gemeenschap van goederen.</xsl:text>
				</p>
			</xsl:when>
			<xsl:when test="partnerOverledene/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_ontbondengemeenschap']/tekst = '2'">
				<p>
					<xsl:text>Het Nederlandse huwelijksvermogensrecht was van toepassing. Zij hebben huwelijkse voorwaarden gemaakt</xsl:text>
					<xsl:if test="translate(partnerOverledene/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_uitsluitinggemeenschapgoederen']/tekst,$upper, $lower) = 'true'">
						<xsl:text> waarbij elke gemeenschap van goederen is uitgesloten</xsl:text>
					</xsl:if>
					<xsl:text>. De nalatenschap van de </xsl:text>
					<xsl:value-of select="$overledeneAanduiding"/>
					<xsl:text> omvat </xsl:text>
					<xsl:value-of select="$zijnHaar"/>
					<xsl:text> eigen vermogen en </xsl:text>
					<xsl:value-of select="$zijnHaar"/>
					<xsl:text> aandeel in de eventuele goederen die gemeenschappelijk in eigendom van </xsl:text>
					<xsl:choose>
						<xsl:when test="$zijnHaar = 'zijn'">
							<xsl:text>hem</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$zijnHaar"/>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:text> en </xsl:text>
					<xsl:value-of select="$zijnHaar"/>
					<xsl:text> genoemde echtgenoot/echtgenote waren.</xsl:text>
				</p>
			</xsl:when>
			<xsl:when test="partnerOverledene/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_ontbondengemeenschap']/tekst = '3'">
				<p>
					<xsl:text>Het Nederlandse huwelijksvermogensrecht was van toepassing. Zij hebben partnerschapsvoorwaarden gemaakt</xsl:text>
					<xsl:choose>
						<xsl:when test="translate(partnerOverledene/tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_uitsluitinggemeenschapgoederen']/tekst,$upper, $lower) = 'true'">
							<xsl:text> waarbij elke gemeenschap van goederen is uitgesloten.</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>.</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:text> De nalatenschap van de </xsl:text>
					<xsl:value-of select="$overledeneAanduiding"/>
					<xsl:text> omvat </xsl:text>
					<xsl:value-of select="$zijnHaar"/>
					<xsl:text> eigen vermogen en </xsl:text>
					<xsl:value-of select="$zijnHaar"/>
					<xsl:text> aandeel in de eventuele goederen die gemeenschappelijk in eigendom van </xsl:text>
					<xsl:choose>
						<xsl:when test="$zijnHaar = 'zijn'">
							<xsl:text>hem</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$zijnHaar"/>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:text> en </xsl:text>
					<xsl:value-of select="$zijnHaar"/>
					<xsl:text> genoemde partner waren.</xsl:text>
				</p>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="keuzeOntbonden">
		<xsl:choose>
			<xsl:when test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_burgerlijkestaat']/tekst,$upper, $lower) = 'huwelijk'">
				<xsl:call-template name="huwelijkOntbonden"/>
			</xsl:when>
			<xsl:when test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_burgerlijkestaat']/tekst,$upper, $lower) = 'geregistreerd partnerschap'">
				<xsl:call-template name="geregistreerdPartnerOntbonden"/>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="huwelijkOntbonden">
		<xsl:text>Gemeld huwelijk is ontbonden door </xsl:text>
		<xsl:value-of select="tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_ontbondenhuwelijk']/tekst"/>
		<xsl:if test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_ontbondenhuwelijk']/tekst,$upper, $lower) = 'overlijden van laatstgenoemde op'">
			<xsl:text> op </xsl:text>
			<xsl:value-of select="kef:convertDateToText(datumOverlijden)"/>
			<xsl:text> te </xsl:text>
			<xsl:value-of select="plaatsOverlijden"/>
		</xsl:if>
		<xsl:text>, aangetekend in de registers van de burgerlijke stand van de gemeente </xsl:text>
		<xsl:value-of select="gemeenteBurgerlijkeStand"/>
		<xsl:text> op </xsl:text>
		<xsl:value-of select="kef:convertDateToText(datumBurgerlijkeStand)"/>
		<xsl:text>.</xsl:text>
	</xsl:template>

	<xsl:template name="geregistreerdPartnerOntbonden">
		<xsl:text>Gemeld geregistreerd partnerschap is ontbonden </xsl:text>
		<xsl:value-of select="tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_ontbondenpartnerschap']/tekst"/>
		<xsl:if test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_ontbondenpartnerschap']/tekst,$upper, $lower) = 'door overlijden van laatstgenoemde op'">
			<xsl:text> </xsl:text>
			<xsl:value-of select="kef:convertDateToText(datumOverlijden)"/>
			<xsl:text> te </xsl:text>
			<xsl:value-of select="plaatsOverlijden"/>
		</xsl:if>
		<xsl:if test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_ontbondenpartnerschap']/tekst,$upper, $lower) = 'tijdens leven van'">
			<xsl:text> </xsl:text>
			<xsl:value-of select="$overledeneAanduiding"/>
		</xsl:if>
		<xsl:text> </xsl:text>
		<xsl:value-of select="$blijkens_low"/>
		<xsl:text> aantekening in de registers van de burgerlijke stand van de gemeente </xsl:text>
		<xsl:value-of select="gemeenteBurgerlijkeStand"/>
		<xsl:text> op </xsl:text>
		<xsl:value-of select="kef:convertDateToText(datumBurgerlijkeStand)"/>
		<xsl:text>.</xsl:text>
	</xsl:template>

</xsl:stylesheet>
