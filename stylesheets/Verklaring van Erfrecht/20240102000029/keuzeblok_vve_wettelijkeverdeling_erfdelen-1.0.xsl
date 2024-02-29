<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exslt="http://exslt.org/common" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:kef="nl.kadaster.xslt.XslExtensionFunctions" exclude-result-prefixes="xsl exslt xlink kef" version="1.0">
	<xsl:template match="erfdelen">
		<xsl:variable name="variant" select="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_variant']/tekst, $upper, $lower)"/>
		<xsl:variable name="aantalKinderen" select="count(kinderen/kindRef)"/>
		<xsl:variable name="aantalKleinKinderen" select="count(kleinkinderen/kindRef)"/>
		<xsl:variable name="aantalStiefKinderen" select="count(stiefkinderen/kindRef)"/>
		<h3 class="header">
			<u>
				<u>ERFGENAMEN</u>
			</u>
		</h3>
		<xsl:choose>
			<xsl:when test="$variant = 'a'">
				<p>
					<xsl:text>Ingevolge de bepalingen van </xsl:text>
					<xsl:value-of select="tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_bepalingen']/tekst"/>
					<xsl:text> heeft de </xsl:text>
					<xsl:value-of select="$overledeneAanduiding"/>
					<xsl:text> als </xsl:text>
					<xsl:value-of select="$zijnHaar"/>
					<xsl:text> enige erfgenamen achtergelaten:</xsl:text>
				</p>
				<table cellspacing="0" cellpadding="0">
					<tbody>
						<tr>
							<td class="number">
								<xsl:text>-</xsl:text>
							</td>
							<td colspan="2">
								<xsl:value-of select="$zijnHaar"/>
								<xsl:if test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_voornoemde']/tekst,$upper, $lower) = 'true'">
									<xsl:text> voornoemde</xsl:text>
								</xsl:if>
								<xsl:text> </xsl:text>
								<xsl:value-of select="$benamingPartner"/>
								<xsl:text> en </xsl:text>
								<xsl:value-of select="$zijnHaar"/>
								<xsl:text> hiervoor genoemde kind</xsl:text>
								<xsl:if test="$aantalKinderen > 1">
									<xsl:text>eren</xsl:text>
								</xsl:if>
								<xsl:text>, voor </xsl:text>
								<xsl:value-of select="aandeel/teller"/>
								<xsl:text>/</xsl:text>
								<xsl:value-of select="aandeel/noemer"/>
								<xsl:choose>
									<xsl:when test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_iedervoor']/tekst,$upper, $lower) = 'nalatenschap'">
										<xsl:text> gedeelte van </xsl:text>
										<xsl:value-of select="$zijnHaar"/>
										<xsl:text> nalatenschap</xsl:text>
									</xsl:when>
									<xsl:when test="translate(tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_iedervoor']/tekst,$upper, $lower) = 'aandeel'">
										<xsl:text> aandeel</xsl:text>
									</xsl:when>
								</xsl:choose>
								<xsl:choose>
									<xsl:when test="$aantalKleinKinderen = 0 and $aantalStiefKinderen = 0">
										<xsl:text>.</xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text>;</xsl:text>
									</xsl:otherwise>
								</xsl:choose>
							</td>
						</tr>
						<xsl:if test="$aantalKleinKinderen > 0">
							<tr>
								<td class="number">
									<xsl:text>-</xsl:text>
								</td>
								<td colspan="2">
									<xsl:value-of select="$zijnHaar"/>
									<xsl:text> hiervoor genoemde kleinkind</xsl:text>
									<xsl:if test="$aantalKleinKinderen > 1">
										<xsl:text>eren</xsl:text>
									</xsl:if>
									<xsl:text>,</xsl:text>
									<xsl:if test="$aantalKleinKinderen > 1">
										<xsl:text> gezamenlijk</xsl:text>
									</xsl:if>
									<xsl:text> voor </xsl:text>
									<xsl:value-of select="kleinkinderen/aandeel/teller"/>
									<xsl:text>/</xsl:text>
									<xsl:value-of select="kleinkinderen/aandeel/noemer"/>
									<xsl:text> gedeelte, </xsl:text>
									<xsl:if test="$aantalKleinKinderen > 1">
										<xsl:text> derhalve ieder voor </xsl:text>
										<xsl:value-of select="kleinkinderen/aandeelIederVoorZich/teller"/>
										<xsl:text>/</xsl:text>
										<xsl:value-of select="kleinkinderen/aandeelIederVoorZich/noemer"/>
										<xsl:text> gedeelte </xsl:text>
									</xsl:if>
									<xsl:text>van </xsl:text>
									<xsl:value-of select="$zijnHaar"/>
									<xsl:text> nalatenschap</xsl:text>
									<xsl:choose>
										<xsl:when test="$aantalStiefKinderen = 0">
											<xsl:text>.</xsl:text>
										</xsl:when>
										<xsl:otherwise>
											<xsl:text>;</xsl:text>
										</xsl:otherwise>
									</xsl:choose>
								</td>
							</tr>
						</xsl:if>
					</tbody>
				</table>
				<xsl:if test="$aantalStiefKinderen > 0">
					<table cellspacing="0" cellpadding="0">
						<tbody>
							<tr>
								<td class="number">
									<xsl:text>-</xsl:text>
								</td>
								<td colspan="2">
									<xsl:value-of select="$zijnHaar"/>
									<xsl:text> stiefkinderen:</xsl:text>
								</td>
							</tr>
							<xsl:for-each select="stiefkinderen/kindRef">
								<xsl:variable name="stiefkindRef" select="current()/@xlink:href"/>
								<xsl:variable name="stiefkind" select="$opsommingPersonen/IMKAD_Persoon[@id = substring-after($stiefkindRef,'#')]"/>
								<tr>
									<td class="number"/>
									<td class="number">
										<xsl:number value="position()" format="a"/>
										<xsl:text>.</xsl:text>
									</td>
									<td>
										<xsl:call-template name="tb-NatuurlijkPersoon">
											<xsl:with-param name="partner" select="$stiefkind"/>
										</xsl:call-template>
										<xsl:text>, voor </xsl:text>
										<xsl:value-of select="../aandeel/teller"/>
										<xsl:text>/</xsl:text>
										<xsl:value-of select="../aandeel/noemer"/>
										<xsl:text> gedeelte</xsl:text>
										<xsl:choose>
											<xsl:when test="$aantalStiefKinderen = position()">
												<xsl:text>.</xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text>;</xsl:text>
											</xsl:otherwise>
										</xsl:choose>
									</td>
								</tr>
							</xsl:for-each>
						</tbody>
					</table>
				</xsl:if>
			</xsl:when>
			<xsl:when test="$variant = 'b'">
				<p>
					<xsl:text>Op grond van de bepalingen van </xsl:text>
					<xsl:value-of select="tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_bepalingen']/tekst"/>
					<xsl:text> zijn aldus de erfgenamen van de overledene: </xsl:text>
				</p>
				<table cellspacing="0" cellpadding="0">
					<tbody>
						<tr>
							<td class="number">
								<xsl:text>-</xsl:text>
							</td>
							<td colspan="2">
								<xsl:value-of select="../tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_erflatersechtgenoot']/tekst"/>
								<xsl:text> voor </xsl:text>
								<xsl:value-of select="aandeel/teller"/>
								<xsl:text>/</xsl:text>
								<xsl:value-of select="aandeel/noemer"/>
								<xsl:text> aandeel;</xsl:text>
							</td>
						</tr>
						<tr>
							<td class="number">
								<xsl:text>-</xsl:text>
							</td>
							<td colspan="2">
								<xsl:text>kind</xsl:text>
								<xsl:if test="$aantalKinderen > 1">
									<xsl:text>eren</xsl:text>
								</xsl:if>
								<xsl:text>:</xsl:text>
							</td>
						</tr>
						<xsl:for-each select="kinderen/kindRef">
							<xsl:variable name="kindRef" select="current()/@xlink:href"/>
							<xsl:variable name="kind" select="$opsommingPersonen/IMKAD_Persoon[@id = substring-after($kindRef,'#')]"/>
							<tr>
								<td class="number"/>
								<td class="number">
									<xsl:number value="position()" format="a"/>
									<xsl:text>.</xsl:text>
								</td>
								<td>
									<xsl:call-template name="tb-NatuurlijkPersoon">
										<xsl:with-param name="partner" select="$kind"/>
										<xsl:with-param name="toonWoonplaats" select="false"/>
									</xsl:call-template>
									<xsl:text>, voor het </xsl:text>
									<xsl:value-of select="../aandeel/teller"/>
									<xsl:text>/</xsl:text>
									<xsl:value-of select="../aandeel/noemer"/>
									<xsl:text> aandeel</xsl:text>
									<xsl:choose>
										<xsl:when test="$aantalKinderen + $aantalKleinKinderen + $aantalStiefKinderen = position()">
											<xsl:text>.</xsl:text>
										</xsl:when>
										<xsl:otherwise>
											<xsl:text>;</xsl:text>
										</xsl:otherwise>
									</xsl:choose>
								</td>
							</tr>
						</xsl:for-each>
						<xsl:if test="$aantalKleinKinderen > 0">
							<tr>
								<td class="number">
									<xsl:text>-</xsl:text>
								</td>
								<td colspan="2">
									<xsl:text>kleinkind</xsl:text>
									<xsl:if test="$aantalKleinKinderen > 1">
										<xsl:text>eren</xsl:text>
									</xsl:if>
									<xsl:text>:</xsl:text>
								</td>
							</tr>
							<tr>
								<td class="number"/>
								<td class="number">
									<xsl:number value="$aantalKinderen + 1" format="a"/>
									<xsl:text>.</xsl:text>
								</td>
								<td>
									<xsl:for-each select="kleinkinderen/kindRef">
										<xsl:variable name="kleinkindRef" select="current()/@xlink:href"/>
										<xsl:variable name="kleinkind" select="$opsommingPersonen/IMKAD_Persoon[@id = substring-after($kleinkindRef,'#')]"/>
										<xsl:call-template name="tb-NatuurlijkPersoon">
											<xsl:with-param name="partner" select="$kleinkind"/>
											<xsl:with-param name="toonWoonplaats" select="false"/>
										</xsl:call-template>
										<xsl:choose>
											<xsl:when test="position() &lt; ($aantalKleinKinderen - 1)">
												<xsl:text>, </xsl:text>
											</xsl:when>
											<xsl:when test="position() &lt; ($aantalKleinKinderen )">
												<xsl:text> en </xsl:text>
											</xsl:when>
										</xsl:choose>
									</xsl:for-each>
									<xsl:text>,</xsl:text>
									<xsl:if test="$aantalKleinKinderen > 1">
										<xsl:text> gezamenlijk</xsl:text>
									</xsl:if>
									<xsl:text> voor </xsl:text>
									<xsl:value-of select="kleinkinderen/aandeel/teller"/>
									<xsl:text>/</xsl:text>
									<xsl:value-of select="kleinkinderen/aandeel/noemer"/>
									<xsl:text> aandeel</xsl:text>
									<xsl:if test="$aantalKleinKinderen > 1">
										<xsl:text>, derhalve ieder voor </xsl:text>
										<xsl:value-of select="kleinkinderen/aandeelIederVoorZich/teller"/>
										<xsl:text>/</xsl:text>
										<xsl:value-of select="kleinkinderen/aandeelIederVoorZich/noemer"/>
										<xsl:text> aandeel</xsl:text>
									</xsl:if>
									<xsl:text>;</xsl:text>
								</td>
							</tr>
						</xsl:if>
						<xsl:if test="$aantalStiefKinderen > 0">
							<tr>
								<td class="number">
									<xsl:text>-</xsl:text>
								</td>
								<td colspan="2">
									<xsl:text>stiefkind</xsl:text>
									<xsl:if test="$aantalStiefKinderen > 1">
										<xsl:text>eren</xsl:text>
									</xsl:if>
									<xsl:text>:</xsl:text>
								</td>
							</tr>
							<tr>
								<td class="number"/>
								<td class="number">
									<xsl:choose>
										<xsl:when test="$aantalKleinKinderen > 0">
											<xsl:number value="$aantalKinderen + 2" format="a"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:number value="$aantalKinderen + 1" format="a"/>
										</xsl:otherwise>
									</xsl:choose>
									<xsl:text>.</xsl:text>
								</td>
								<td>
									<xsl:for-each select="stiefkinderen/kindRef">
										<xsl:variable name="stiefkindRef" select="current()/@xlink:href"/>
										<xsl:variable name="stiefkind" select="$opsommingPersonen/IMKAD_Persoon[@id = substring-after($stiefkindRef,'#')]"/>
										<xsl:call-template name="tb-NatuurlijkPersoon">
											<xsl:with-param name="partner" select="$stiefkind"/>
											<xsl:with-param name="toonWoonplaats" select="false"/>
										</xsl:call-template>
										<xsl:choose>
											<xsl:when test="position() &lt; ($aantalStiefKinderen - 1)">
												<xsl:text>, </xsl:text>
											</xsl:when>
											<xsl:when test="position() &lt; ($aantalStiefKinderen )">
												<xsl:text> en </xsl:text>
											</xsl:when>
										</xsl:choose>
									</xsl:for-each>
									<xsl:text>,</xsl:text>
									<xsl:if test="$aantalStiefKinderen > 1">
										<xsl:text> gezamenlijk</xsl:text>
									</xsl:if>
									<xsl:text> voor </xsl:text>
									<xsl:value-of select="stiefkinderen/aandeel/teller"/>
									<xsl:text>/</xsl:text>
									<xsl:value-of select="stiefkinderen/aandeel/noemer"/>
									<xsl:text> aandeel</xsl:text>
									<xsl:if test="$aantalStiefKinderen > 1">
										<xsl:text>, derhalve ieder voor </xsl:text>
										<xsl:value-of select="stiefkinderen/aandeelIederVoorZich/teller"/>
										<xsl:text>/</xsl:text>
										<xsl:value-of select="stiefkinderen/aandeelIederVoorZich/noemer"/>
										<xsl:text> aandeel</xsl:text>
									</xsl:if>
									<xsl:text>.</xsl:text>
								</td>
							</tr>
						</xsl:if>
					</tbody>
				</table>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>