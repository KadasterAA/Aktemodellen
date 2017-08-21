<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:tia="http://www.kadaster.nl/schemas/KIK/TIA_Algemeen"
	xmlns:alg="http://www.kadaster.nl/schemas/KIK/Formaattypen"
	xmlns:xlink="http://www.w3.org/1999/xlink"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:exslt="http://exslt.org/common"
	exclude-result-prefixes="tia alg xlink xsl exslt"
	version="1.0">

	<!-- 
		*************************************************************************
		Template for text block SELLER (Vervreemders), BUYER (Vervreemders)... partij
		*************************************************************************
	-->
	<xsl:template name="Partij">
		<xsl:param name="partij"/>
		<xsl:param name="type"/>
		<xsl:param name="colspan"/>
		<xsl:param name="isNetworkNotary" select="'false'"/>
		<xsl:param name="futureAddressText" select="''"/>
		<xsl:variable name="position" select="count(preceding-sibling::tia:Partij) + 1"/>
		
		<!-- Seller representative -->
		<xsl:choose>
			<xsl:when test="$partij/tia:Gevolmachtigde">
				<tr>
					<td class="number" valign="top">
						<a name="{@id}" class="location" style="_position: relative;">&#xFEFF;</a>
						<xsl:choose>
							<xsl:when test="translate($type,$upper,$lower) = 'doc'">
								<xsl:number value="$position" format="A"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:number value="$position" format="1"/>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:text>.</xsl:text>
					</td>
					<td>
						<xsl:if test="$colspan != ''">
							<xsl:attribute name="colspan">
								<xsl:value-of select="$colspan"/>
							</xsl:attribute>
						</xsl:if>
						<xsl:call-template name="Gevolmachtigde">
							<xsl:with-param name="gevolmachtigde" select="$partij/tia:Gevolmachtigde"/>
							<xsl:with-param name="type" select="$type"/>
						</xsl:call-template>
					</td>
				</tr>
			</xsl:when>
			<xsl:otherwise>
				<!--
					Hack for WordML style sheet to avoid incorrect numbering.
					Must be corrected with appropriate list handling by WordML style sheet,
					as part of issue ORKADKIK-428.
				-->
				<xsl:if test="translate($isNetworkNotary,$upper,$lower) != 'true'">
					<xsl:text>&#xFEFF;</xsl:text>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:variable name="_persons">
			<xsl:choose>
				<xsl:when test="translate($type,$upper,$lower) = 'doc'"><xsl:copy-of select="$partij/tia:Partij/tia:IMKAD_Persoon"/></xsl:when>
				<xsl:otherwise><xsl:copy-of select="$partij/tia:IMKAD_Persoon"/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="_nestedParties">
			<xsl:choose>
				<xsl:when test="translate($type,$upper,$lower) = 'doc'"><xsl:copy-of select="$partij/tia:Partij"/></xsl:when>
				<xsl:otherwise/>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="persons" select="exslt:node-set($_persons)"/>
		<xsl:variable name="nestedParties" select="exslt:node-set($_nestedParties)"/>
		<xsl:variable name="hasAuthorizedRepresentative">
			<xsl:choose>
				<xsl:when test="$partij/tia:Gevolmachtigde">
					<xsl:text>true</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>false</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:call-template name="IMKAD_Persoon">
			<xsl:with-param name="persoon" select="$persons/tia:IMKAD_Persoon"/>
			<xsl:with-param name="nestedParties" select="$nestedParties/tia:Partij"/>
			<xsl:with-param name="type" select="$type"/>
			<xsl:with-param name="colspan" select="$colspan"/>
			<xsl:with-param name="hasAuthorizedRepresentative" select="$hasAuthorizedRepresentative"/>
			<xsl:with-param name="isNetworkNotary" select="$isNetworkNotary"/>
			<xsl:with-param name="futureAddressText" select="$futureAddressText"/>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="vervreemders">
		<xsl:param name="type"/> 
		<xsl:param name="isNetworkNotary" select="'false'"/>
		
		
		<xsl:for-each select="$AangebodenStuk/tia:Partij">
			<table cellspacing="0" cellpadding="0">
				<tbody>
					<xsl:variable name="person-count" select="count(tia:Partij/tia:IMKAD_Persoon)"/>
					<xsl:variable name="numberOfPersons">
						<xsl:choose>
							<xsl:when test="translate($type,$upper,$lower) = 'doc'">
								<xsl:value-of select="count(tia:Partij)"/>								
							</xsl:when>
							<xsl:otherwise>
								<xsl:choose>
									<xsl:when test="translate($isNetworkNotary,$upper,$lower) = 'true'">
										<xsl:value-of select="count(tia:IMKAD_Persoon)"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="count(tia:IMKAD_Persoon) + count(tia:IMKAD_Persoon/tia:GerelateerdPersoon[translate(tia:tia_IndPartij,$upper,$lower) = 'true'])"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:otherwise>
						</xsl:choose>					
					</xsl:variable>
					<xsl:variable name="numberOfPersonsPairs">
						<xsl:if test="translate($isNetworkNotary,$upper,$lower) = 'true'">
							<xsl:value-of select="count(tia:IMKAD_Persoon[translate(tia:tia_BurgerlijkeStaatTekst,$upper,$lower) = 'gehuwd met' or translate(tia:tia_BurgerlijkeStaatTekst,$upper,$lower) = 'geregistreerd partner van'])"/>
						</xsl:if>
					</xsl:variable>
					<xsl:variable name="colspan">
						<xsl:choose>
							<xsl:when test="translate($isNetworkNotary,$upper,$lower) = 'true'">
								<xsl:choose>
									<xsl:when test="$numberOfPersons > 1 and $numberOfPersonsPairs > 0">
										<xsl:text>3</xsl:text>
									</xsl:when>
									<xsl:when test="$numberOfPersons = 1 and $numberOfPersonsPairs = 1">
										<xsl:text>2</xsl:text>
									</xsl:when>
									<xsl:when test="$numberOfPersons > 1">
										<xsl:text>2</xsl:text>
									</xsl:when>
								</xsl:choose>
							</xsl:when>
							<xsl:otherwise>
								<xsl:choose>
									<xsl:when test="$numberOfPersons > 1">
										<xsl:text>2</xsl:text>
									</xsl:when>
								</xsl:choose>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
					<xsl:variable name="xmlKeuzeTekst"
						select="normalize-space(current()/tia:tekstKeuze[translate(tia:tagNaam,$upper,$lower) = 'k_toekomstigadres']/tia:tekst)"/>
					<xsl:variable name="akteTekst">
						<xsl:choose>
							<xsl:when test="($ObjectNumber > 1) and (contains(translate($xmlKeuzeTekst,$upper,$lower), ' het hierna te vermelden registergoed '))">
								<xsl:value-of select="concat(substring-before(translate($xmlKeuzeTekst,$upper,$lower), ' het hierna te vermelden registergoed '),
									' de hierna te vermelden registergoederen ',
									substring-after(translate($xmlKeuzeTekst,$upper,$lower), ' het hierna te vermelden registergoed '))"/>
							</xsl:when>
							<xsl:when test="($ObjectNumber = 1) and (contains(translate($xmlKeuzeTekst,$upper,$lower), ' de hierna te vermelden registergoederen '))">
								<xsl:value-of select="concat(substring-before(translate($xmlKeuzeTekst,$upper,$lower), ' de hierna te vermelden registergoederen '),
									' het hierna te vermelden registergoed ',
									substring-after(translate($xmlKeuzeTekst,$upper,$lower), ' de hierna te vermelden registergoederen '))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="$xmlKeuzeTekst"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
					<xsl:variable name="futureAddressText">
						 <xsl:if test="$numberOfPersons = 1">
							<xsl:value-of select="$keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam,$upper,$lower) = 'k_toekomstigadres']/tia:tekst[translate(normalize-space(.), $upper, $lower) = translate($akteTekst, $upper, $lower)]"/>
						 </xsl:if>
					</xsl:variable>
					<xsl:call-template name="Partij">
						<xsl:with-param name="partij" select="."/>
						<xsl:with-param name="type" select="$type"/>
						<xsl:with-param name="colspan" select="$colspan"/>
						<xsl:with-param name="isNetworkNotary" select="$isNetworkNotary"/>
						<xsl:with-param name="futureAddressText" select="$futureAddressText"/>
					</xsl:call-template>
					<xsl:if test="tia:tekstKeuze[translate(tia:tagNaam,$upper,$lower) = 'k_toekomstigadres']">
						<xsl:choose>
							<xsl:when test="translate($isNetworkNotary,$upper,$lower) = 'true'">
								<xsl:if test="$futureAddressText = ''">
									<!-- Pas de keuzetekst aan, afhankelijk van het aantal objecten (enkelvoud/meervoud). -->
									<tr>
										<td class="number" valign="top">
											<xsl:text>&#xFEFF;</xsl:text>
										</td>
										<td>
											<xsl:if test="$colspan != ''">
												<xsl:attribute name="colspan">
													<xsl:value-of select="$colspan"/>
												</xsl:attribute>
											</xsl:if>
											<xsl:value-of select="$keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam,$upper,$lower) = 'k_toekomstigadres']/tia:tekst[translate(normalize-space(.), $upper, $lower) = translate($akteTekst, $upper, $lower)]"/>
										</td>
									</tr>
								</xsl:if>
							</xsl:when>
							<xsl:otherwise>
								<!-- Pas de keuzetekst aan, afhankelijk van het aantal objecten (enkelvoud/meervoud). -->
								<tr>
									<td class="number" valign="top">
										<xsl:text>&#xFEFF;</xsl:text>
									</td>
									<td>
										<xsl:if test="$colspan != ''">
											<xsl:attribute name="colspan">
												<xsl:value-of select="$colspan"/>
											</xsl:attribute>
										</xsl:if>
										<xsl:value-of select="$keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam,$upper,$lower) = 'k_toekomstigadres']/tia:tekst[translate(normalize-space(.), $upper, $lower) = translate($akteTekst, $upper, $lower)]"/>
									</td>
								</tr>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:if>
					<tr>
						<td class="number" valign="top">
							<xsl:text>&#xFEFF;</xsl:text>
						</td>
						<td>
							<xsl:if test="$colspan != ''">
								<xsl:attribute name="colspan">
									<xsl:value-of select="$colspan"/>
								</xsl:attribute>
							</xsl:if>
							<xsl:choose>
								<xsl:when test="translate($type,$upper,$lower) = 'doc'">
									<xsl:if test="$person-count > 1">
										<xsl:text>ieder van hen </xsl:text>
									</xsl:if>
									<xsl:text>hierna te noemen: </xsl:text>
									<xsl:choose>
										<xsl:when test="$person-count > 1"><xsl:value-of select="tia:aanduidingPartij"/></xsl:when>
										<xsl:otherwise><xsl:value-of select="substring(tia:aanduidingPartij, 1, string-length(tia:aanduidingPartij)-1)"/></xsl:otherwise>
									</xsl:choose>
									<xsl:choose>
										<xsl:when test="position() != last()">
											<xsl:text>;</xsl:text>
										</xsl:when>
										<xsl:otherwise><xsl:text>.</xsl:text></xsl:otherwise>
									</xsl:choose>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>hierna </xsl:text>
									<xsl:if test="count(tia:IMKAD_Persoon|*/tia:GerelateerdPersoon[translate(tia:rol,$upper,$lower) = 'partner'])>1">
										<xsl:choose>
											<xsl:when test="translate($isNetworkNotary,$upper,$lower) = 'true'">
												<xsl:text>samen </xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text>zowel tezamen als ieder afzonderlijk </xsl:text>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:if>
									<xsl:text>te noemen: </xsl:text>
									<xsl:if test="tia:aanduidingPartij and string-length(tia:aanduidingPartij) > 0">
										<xsl:if test="translate($isNetworkNotary,$upper,$lower) = 'true'">
											<xsl:text>'</xsl:text>
										</xsl:if>
										<xsl:choose>
											<!-- Onderstrepen alleen bij hypotheek. -->
											<xsl:when test="//tia:StukdeelHypotheek">
												<span style="text-decoration:underline"><xsl:value-of select="tia:aanduidingPartij"/></span>
											</xsl:when>
											<xsl:otherwise><xsl:value-of select="tia:aanduidingPartij"/></xsl:otherwise>
										</xsl:choose>
										<xsl:if test="translate($isNetworkNotary,$upper,$lower) = 'true'">
											<xsl:text>'</xsl:text>
										</xsl:if>
									</xsl:if>
									<xsl:choose>
										<xsl:when test="count($Partijs) > position()">
											<xsl:text>;</xsl:text>
										</xsl:when>
										<xsl:otherwise><xsl:text>.</xsl:text></xsl:otherwise>
									</xsl:choose>
								</xsl:otherwise>
							</xsl:choose>
						</td>
					</tr>
				</tbody>
			</table>
			<xsl:if test="count($Partijs) > position() and translate($type,$upper,$lower) != 'doc'">
				<p style="margin-left:30px">
					<xsl:text>en</xsl:text>
				</p>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="extractPartyNames">
		<xsl:param name="partyReference"/>
		<xsl:param name="parties" />
		<xsl:param name="count"/>

		<xsl:for-each select="$partyReference">
			<xsl:variable name="id" select="substring-after(@xlink:href, '#')"/>
			<xsl:text> </xsl:text>
			<xsl:value-of select="$parties/tia:Partij[@id = $id]/tia:aanduidingPartij"/>
			<xsl:choose>
				<xsl:when test="$count > 1 and position() + 1 = last()">
					<xsl:text> en</xsl:text>
				</xsl:when>
				<xsl:when test="$count > 1 and position() + 1 &lt; last()">
					<xsl:text>,</xsl:text>
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>
		<xsl:text> </xsl:text>
	</xsl:template>
</xsl:stylesheet>
