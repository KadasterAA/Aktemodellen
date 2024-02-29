<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exslt="http://exslt.org/common" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:kef="nl.kadaster.xslt.XslExtensionFunctions" exclude-result-prefixes="xsl exslt xlink kef" version="1.0">
	<xsl:template name="afstammelingen">
		<xsl:variable name="aantalOverigeAfstammelingen" select="count(IMKAD_AangebodenStuk/stukdeelVVE/overigAfstammelingRef)"/>
		<h3 class="header">
			<u>AFSTAMMELINGEN</u>
		</h3>
		<xsl:apply-templates select="IMKAD_AangebodenStuk/stukdeelVVE/partner/gegevensPartner/afstammelingen">
			<xsl:with-param name="partnerRef" select="$partnerRef"/>
		</xsl:apply-templates>
		<xsl:for-each select="IMKAD_AangebodenStuk/stukdeelVVE/partner/eerdereBurgerlijkeStaat">
			<xsl:apply-templates select="afstammelingen">
				<xsl:with-param name="partnerRef" select="huwelijkPartnerRef/@xlink:href | geregistreerdPartnerRef/@xlink:href"/>
			</xsl:apply-templates>
		</xsl:for-each>
		<xsl:if test="$aantalOverigeAfstammelingen > 0">
			<xsl:call-template name="overigeAfstammelingen"/>
		</xsl:if>
	</xsl:template>
	<xsl:template match="afstammelingen">
		<xsl:param name="partnerRef"/>
		<xsl:variable name="partner" select="$opsommingPersonen/IMKAD_Persoon[@id = substring-after($partnerRef,'#')]"/>
		<xsl:variable name="burgerlijkeStaat">
			<xsl:choose>
				<xsl:when test="parent::gegevensPartner">
					<xsl:value-of select="../tekstkeuze[translate(tagNaam, $upper, $lower) = 'k_burgerlijkestaat']/tekst"/>
				</xsl:when>
				<xsl:when test="../huwelijkPartnerRef">
					<xsl:text>huwelijk</xsl:text>
				</xsl:when>
				<xsl:when test="../geregistreerdPartnerRef">
					<xsl:text>geregistreerd partnerschap</xsl:text>
				</xsl:when>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="aantalKinderen" select="count(kindInLevenRef) + count(vooroverledenKind)"/>
		<xsl:variable name="aantalKinderInLeven" select="count(kindInLevenRef)"/>
		<xsl:variable name="aantalVooroverledenKind" select="count(vooroverledenKind)"/>
		<xsl:variable name="aantalPreceding" select="count(preceding::afstammelingen/kindInLevenRef) + count(preceding::afstammelingen/vooroverledenKind)"/>
		<xsl:choose>
			<xsl:when test="$aantalKinderInLeven = 0">
				<p>
					<xsl:text>Uit voormeld </xsl:text>
					<xsl:value-of select="$burgerlijkeStaat"/>
					<xsl:text> met </xsl:text>
					<xsl:apply-templates select="$partner/gegevens/GBA_Ingezetene" mode="do-natural-person-personal-data"/>
					<xsl:text> </xsl:text>
					<xsl:choose>
						<xsl:when test="$aantalKinderen = 1">
							<xsl:text> is een kind geboren, welk kind is vooroverleden, te weten:</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text> zijn </xsl:text>
							<xsl:value-of select="kef:convertNumberToText($aantalKinderen)"/>
							<xsl:text> kinderen geboren, welke kinderen allen zijn vooroverleden, te weten:</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</p>
			</xsl:when>
			<xsl:otherwise>
				<p>
					<xsl:text>Uit voormeld </xsl:text>
					<xsl:value-of select="$burgerlijkeStaat"/>
					<xsl:text> met </xsl:text>
					<xsl:apply-templates select="$partner/gegevens/GBA_Ingezetene" mode="do-natural-person-personal-data"/>
					<xsl:text> </xsl:text>
					<xsl:choose>
						<xsl:when test="$aantalKinderen = 1">
							<xsl:text> is een kind geboren, waarvan in leven </xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text> zijn </xsl:text>
							<xsl:value-of select="kef:convertNumberToText($aantalKinderen)"/>
							<xsl:text> kinderen geboren, waarvan in leven </xsl:text>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:choose>
						<xsl:when test="$aantalKinderInLeven = 1">
							<xsl:text> is een kind</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text> zijn </xsl:text>
							<xsl:value-of select="kef:convertNumberToText($aantalKinderInLeven)"/>
							<xsl:text> kinderen</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:text>, te weten:</xsl:text>
				</p>
				<table cellspacing="0" cellpadding="0">
					<tbody>
						<xsl:for-each select="kindInLevenRef">
							<xsl:variable name="kindInLeven" select="$opsommingPersonen/IMKAD_Persoon[@id = substring-after(current()/@xlink:href,'#')]"/>
							<tr>
								<td class="number">
									<xsl:number value="position() + $aantalPreceding" format="1"/>
									<xsl:text>.</xsl:text>
								</td>
								<td colspan="2">
									<xsl:call-template name="tb-NatuurlijkPersoon">
										<xsl:with-param name="partner" select="$kindInLeven"/>
									</xsl:call-template>
									<xsl:choose>
										<xsl:when test="$aantalKinderInLeven = position() and $aantalVooroverledenKind = 0">
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
				<xsl:if test="$aantalVooroverledenKind > 0">
					<p>
						<xsl:text>terwijl </xsl:text>
						<xsl:value-of select="kef:convertNumberToText($aantalVooroverledenKind)"/>
						<xsl:choose>
							<xsl:when test="$aantalVooroverledenKind = 1">
								<xsl:text> kind is vooroverleden, te weten:</xsl:text>
							</xsl:when>
							<xsl:otherwise>
								<xsl:text> kinderen zijn vooroverleden, te weten:</xsl:text>
							</xsl:otherwise>
						</xsl:choose>
					</p>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:for-each select="vooroverledenKind/vooroverledenKindRef">
			<xsl:variable name="nummerKind" select="position()"/>
			<table cellspacing="0" cellpadding="0">
				<tbody>
					<xsl:variable name="vooroverledenKind" select="$opsommingPersonen/IMKAD_Persoon[@id = substring-after(current()/@xlink:href,'#')]"/>
					<xsl:variable name="aantalAfstammelingen" select="count(../afstammelingRef)"/>
					<tr>
						<td class="number">
							<xsl:number value="position() + $aantalPreceding + $aantalKinderInLeven" format="1"/>
							<xsl:text>.</xsl:text>
						</td>
						<td colspan="2">
							<xsl:call-template name="tb-NatuurlijkPersoon">
								<xsl:with-param name="partner" select="$vooroverledenKind"/>
								<xsl:with-param name="toonWoonplaats" select="'false'"/>
							</xsl:call-template>
							<xsl:text>;</xsl:text>
						</td>
					</tr>
					<xsl:choose>
						<xsl:when test="$aantalAfstammelingen > 0">
							<tr>
								<xsl:choose>
									<xsl:when test="$aantalAfstammelingen = 1">
										<td class="number"/>
										<td colspan="2">
											<xsl:text>met achterlating van </xsl:text>
											<xsl:value-of select="kef:convertNumberToText($aantalAfstammelingen)"/>
											<xsl:text> afstammeling, zijnde:</xsl:text>
										</td>
									</xsl:when>
									<xsl:otherwise>
										<td class="number"/>
										<td colspan="2">
											<xsl:text>met achterlating van </xsl:text>
											<xsl:value-of select="kef:convertNumberToText($aantalAfstammelingen)"/>
											<xsl:text> afstammelingen, zijnde:</xsl:text>
										</td>
									</xsl:otherwise>
								</xsl:choose>
							</tr>
							<xsl:for-each select="../afstammelingRef">
								<xsl:variable name="afstammeling" select="$opsommingPersonen/IMKAD_Persoon[@id = substring-after(current()/@xlink:href,'#')]"/>
								<tr>
									<td class="number"/>
									<td class="number">
										<xsl:number value="position()" format="a"/>
										<xsl:text>.</xsl:text>
									</td>
									<td>
										<xsl:call-template name="tb-NatuurlijkPersoon">
											<xsl:with-param name="partner" select="$afstammeling"/>
										</xsl:call-template>
										<xsl:choose>
											<xsl:when test="$aantalAfstammelingen = position() and $nummerKind = $aantalVooroverledenKind">
												<xsl:text>.</xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text>;</xsl:text>
											</xsl:otherwise>
										</xsl:choose>
									</td>
								</tr>
							</xsl:for-each>
						</xsl:when>
						<xsl:otherwise>
							<tr>
								<td class="number"/>
								<td colspan="2">
									<xsl:text>zonder achterlating van afstammelingen.</xsl:text>
								</td>
							</tr>
						</xsl:otherwise>
					</xsl:choose>
				</tbody>
			</table>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="overigeAfstammelingen">
		<xsl:variable name="aantalKinderen" select="count(//kindInLevenRef) + count(//vooroverledenKind)"/>
		<xsl:variable name="aantalOverigeAfstammelingen" select="count(//overigAfstammelingRef)"/>
		<xsl:variable name="aantalHuwelijken" select="count(//huwelijkPartnerRef)"/>
		<xsl:variable name="aantalGP" select="count(//geregistreerdPartnerRef)"/>
		<p>
			<xsl:text>Naast voornoemd</xsl:text>
			<xsl:choose>
				<xsl:when test="$aantalKinderen > 1">
					<xsl:text>e kinderen</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text> kind</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text> uit voormeld</xsl:text>
			<xsl:if test="$aantalGP + $aantalHuwelijken > 1">
				<xsl:text>e</xsl:text>
			</xsl:if>
			<xsl:choose>
				<xsl:when test="$aantalHuwelijken = 1">
					<xsl:text> huwelijk</xsl:text>
				</xsl:when>
				<xsl:when test="$aantalHuwelijken > 1">
					<xsl:text> huwelijken</xsl:text>
				</xsl:when>
			</xsl:choose>
			<xsl:if test="$aantalGP > 0 and $aantalHuwelijken > 0">
				<xsl:text> en</xsl:text>
			</xsl:if>
			<xsl:choose>
				<xsl:when test="$aantalGP = 1">
					<xsl:text> partnerschap</xsl:text>
				</xsl:when>
				<xsl:when test="$aantalGP > 1">
					<xsl:text> partnerschappen</xsl:text>
				</xsl:when>
			</xsl:choose>
			<xsl:text> heeft </xsl:text>
			<xsl:value-of select="$overledeneAanduiding"/>
			<xsl:text> voorts als afstammeling</xsl:text>
			<xsl:if test="$aantalOverigeAfstammelingen > 1">
				<xsl:text>en</xsl:text>
			</xsl:if>
			<xsl:text> nagelaten:</xsl:text>
		</p>
		<table cellspacing="0" cellpadding="0">
			<tbody>
				<xsl:for-each select="IMKAD_AangebodenStuk/stukdeelVVE/overigAfstammelingRef">
					<xsl:variable name="overigAfstammeling" select="$opsommingPersonen/IMKAD_Persoon[@id = substring-after(current()/@xlink:href,'#')]"/>
					<tr>
						<td class="number">
							<xsl:number value="position() + $aantalKinderen" format="1"/>
							<xsl:text>.</xsl:text>
						</td>
						<td>
							<xsl:call-template name="tb-NatuurlijkPersoon">
								<xsl:with-param name="partner" select="$overigAfstammeling"/>
							</xsl:call-template>
							<xsl:choose>
								<xsl:when test="following-sibling::overigAfstammelingRef">
									<xsl:text>;</xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>.</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
						</td>
					</tr>
				</xsl:for-each>
			</tbody>
		</table>
	</xsl:template>
</xsl:stylesheet>