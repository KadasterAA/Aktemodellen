<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:tia="http://www.kadaster.nl/schemas/KIK/TIA_Algemeen"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:kef="nl.kadaster.xslt.XslExtensionFunctions"
	exclude-result-prefixes="tia xsl kef"
	version="1.0">

	<!-- 
		*************************************************************************
		Template for block sellers
		*************************************************************************
	-->
	<xsl:template name="IMKAD_Persoon">
		<xsl:param name="persoon"/>
		<xsl:param name="type"/>
		<xsl:param name="nestedParties"/>
		<xsl:param name="colspan"/>
		<xsl:param name="hasAuthorizedRepresentative" select="'false'"/>
		<xsl:param name="isNetworkNotary" select="'false'"/>
		<xsl:param name="futureAddressText" select="''"/>
		
		<xsl:variable name="position" select="count(preceding-sibling::tia:Partij) + 1"/>
		<xsl:variable name="id" select="@id"/>
		<xsl:variable name="numberOfPersons" select="count($persoon)"/>
		<xsl:variable name="numberOfPersonsPairs">
			<xsl:value-of select="count($persoon[translate(tia:tia_BurgerlijkeStaatTekst,$upper,$lower) = 'gehuwd met' or translate(tia:tia_BurgerlijkeStaatTekst,$upper,$lower) = 'geregistreerd partner van'])"/>
		</xsl:variable>
		<xsl:variable name="multiple-persons">
			<xsl:choose>
				<xsl:when test="count($persoon) > 1">
					<xsl:value-of select="true"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="false"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
				
		<xsl:for-each select="$persoon">
			<xsl:variable name="index" select="position()"/>
			<xsl:apply-templates select="." mode="imkadPersoon">
				<xsl:with-param name="type" select="$type"/>
				<xsl:with-param name="nestedParty" select="$nestedParties[$index]"/>
				<xsl:with-param name="multiple-persons" select="$multiple-persons"/>
				<xsl:with-param name="index" select="$index"/>
				<xsl:with-param name="id" select="$id"/>
				<xsl:with-param name="colspan" select="$colspan"/>
				<xsl:with-param name="numberOfPersons" select="$numberOfPersons"/>
				<xsl:with-param name="numberOfPersonsPairs" select="$numberOfPersonsPairs"/>
				<xsl:with-param name="position" select="$position"/>
				<xsl:with-param name="hasAuthorizedRepresentative" select="$hasAuthorizedRepresentative"/>
				<xsl:with-param name="isNetworkNotary" select="$isNetworkNotary"/>
				<xsl:with-param name="futureAddressText" select="$futureAddressText"/>
			</xsl:apply-templates>
		</xsl:for-each>
	</xsl:template>

	<!-- persoon -->
	<xsl:template match="tia:*" mode="imkadPersoon">
		<xsl:param name="type"/>
		<xsl:param name="nestedParty"/>
		<xsl:param name="multiple-persons" select="'false'" />
		<xsl:param name="index"/>
		<xsl:param name="id"/>
		<xsl:param name="colspan"/>
		<xsl:param name="numberOfPersons"/>
		<xsl:param name="numberOfPersonsPairs"/>
		<xsl:param name="position"/>
		<xsl:param name="hasAuthorizedRepresentative" select="'false'"/>
		<xsl:param name="isNetworkNotary" select="'false'"/>
		<xsl:param name="futureAddressText" select="''"/>
		
		<xsl:choose>
			<xsl:when test="$numberOfPersons > 1">
				<xsl:choose>
					<xsl:when test="translate($isNetworkNotary,$upper,$lower) = 'true'">
						<!-- Legal person -->
						<xsl:if test="tia:tia_Gegevens/tia:NHR_Rechtspersoon">
							<tr>
								<xsl:choose>
									<xsl:when test="$index = 1">
										<xsl:choose>	
											<xsl:when test="translate($hasAuthorizedRepresentative,$upper,$lower) = 'false'">
												<td class="number" valign="top">
													<a name="{$id}" class="location" style="_position: relative;">&#xFEFF;</a>
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
											</xsl:when>
											<xsl:otherwise>
												<td class="number" valign="top">
													<xsl:text>&#xFEFF;</xsl:text>
												</td>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:when>
									<xsl:otherwise>
										<td class="number" valign="top">
											<xsl:text>&#xFEFF;</xsl:text>
										</td>
									</xsl:otherwise>
								</xsl:choose>
								<td class="number" valign="top">
									<xsl:choose>
										<xsl:when test="translate($type,$upper,$lower) = 'doc'">
											<xsl:number value="$index" format="1"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:number value="$index" format="a"/>
										</xsl:otherwise>
									</xsl:choose>
									<xsl:text>.</xsl:text>
								</td>
								<td>
									<xsl:if test="$numberOfPersonsPairs > 0">
										<xsl:if test="$colspan != ''">
											<xsl:attribute name="colspan">
												<xsl:text>2</xsl:text>
											</xsl:attribute>
										</xsl:if>
									</xsl:if>
									<!-- Legal person manager -->
									<xsl:if test="tia:GerelateerdPersoon">
										<xsl:variable name="bestuurder" select="tia:GerelateerdPersoon/tia:IMKAD_Persoon"/>
										<xsl:call-template name="Bestuurder">
											<xsl:with-param name="bestuurder" select="$bestuurder"/>
											<xsl:with-param name="type" select="$type"/>
											<xsl:with-param name="isNetworkNotary" select="$isNetworkNotary"/>
											<xsl:with-param name="isIndParty" select="tia:GerelateerdPersoon/tia:tia_IndPartij"/>
										</xsl:call-template>
									</xsl:if>
									<xsl:variable name="bestuurderParent" select="tia:GerelateerdPersoon"/>
									<xsl:call-template name="NHR_Rechtspersoon">
										<xsl:with-param name="rechtspersoon" select="tia:tia_Gegevens/tia:NHR_Rechtspersoon"/>
										<xsl:with-param name="bestuurderParent" select="$bestuurderParent"/>
										<xsl:with-param name="type" select="$type"/>
										<xsl:with-param name="multiple-persons" select="$multiple-persons"/>
										<xsl:with-param name="isNetworkNotary" select="$isNetworkNotary"/>
									</xsl:call-template>
								</td>
							</tr>
						</xsl:if>
						<!-- Natural person -->
						<xsl:if test="tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene">
							<tr>
								<xsl:choose>
									<xsl:when test="$index = 1">
										<xsl:choose>	
											<xsl:when test="translate($hasAuthorizedRepresentative,$upper,$lower) = 'false'">
												<td class="number" valign="top">
													<a name="{$id}" class="location" style="_position: relative;">&#xFEFF;</a>
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
											</xsl:when>
											<xsl:otherwise>
												<td class="number" valign="top">
													<xsl:text>&#xFEFF;</xsl:text>
												</td>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:when>
									<xsl:otherwise>
										<td class="number" valign="top">
											<xsl:text>&#xFEFF;</xsl:text>
										</td>
									</xsl:otherwise>
								</xsl:choose>
								<td class="number" valign="top">
									<xsl:choose>
										<xsl:when test="translate($type,$upper,$lower) = 'doc'">
											<xsl:number value="$index" format="1"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:number value="$index" format="a"/>
										</xsl:otherwise>
									</xsl:choose>
									<xsl:text>.</xsl:text>
								</td>
								<xsl:if test="translate(tia:tia_BurgerlijkeStaatTekst,$upper,$lower) = 'gehuwd met' or  translate(tia:tia_BurgerlijkeStaatTekst,$upper,$lower) = 'geregistreerd partner van'">
									<td class="number" valign="top">
										<xsl:text>1.</xsl:text>
									</td>
								</xsl:if>
								<td>
									<xsl:if test="$numberOfPersonsPairs > 0 and (not(tia:tia_BurgerlijkeStaatTekst) or (translate(tia:tia_BurgerlijkeStaatTekst,$upper,$lower) != 'gehuwd met' and translate(tia:tia_BurgerlijkeStaatTekst,$upper,$lower) != 'geregistreerd partner van'))">
										<xsl:if test="$colspan != ''">
											<xsl:attribute name="colspan">
												<xsl:text>2</xsl:text>
											</xsl:attribute>
										</xsl:if>
									</xsl:if>
									<!-- RESIDENT -->
									<xsl:if test="tia:tia_Gegevens/tia:GBA_Ingezetene">
										<xsl:variable name="ingezetene" select="tia:tia_Gegevens/tia:GBA_Ingezetene"/>
										<xsl:call-template name="GBA_Ingezetene">
											<xsl:with-param name="ingezetene" select="$ingezetene"/>
										</xsl:call-template>
									</xsl:if>
									<!-- NON RESIDENT -->
									<xsl:if test="tia:tia_Gegevens/tia:IMKAD_NietIngezetene">
										<xsl:variable name="nietIngezetene" select="tia:tia_Gegevens/tia:IMKAD_NietIngezetene"/>
										<xsl:call-template name="IMKAD_NietIngezetene">
											<xsl:with-param name="nietIngezetene" select="$nietIngezetene"/>
										</xsl:call-template>
									</xsl:if>
									<!--domestic address-->
									<xsl:if test="tia:IMKAD_WoonlocatiePersoon/tia:adres/tia:binnenlandsAdres">
										<xsl:text>, wonende te </xsl:text>
										<xsl:variable name="address" select="tia:IMKAD_WoonlocatiePersoon/tia:adres/tia:binnenlandsAdres"/>
										<xsl:call-template name="binnenlandsAdres">
											<xsl:with-param name="address" select="$address"/>
										</xsl:call-template>
									</xsl:if>
									<!--foreign address-->
									<xsl:if test="tia:IMKAD_WoonlocatiePersoon/tia:adres/tia:buitenlandsAdres">
										<xsl:text>, wonende te </xsl:text>
										<xsl:variable name="address" select="tia:IMKAD_WoonlocatiePersoon/tia:adres/tia:buitenlandsAdres"/>
										<xsl:call-template name="buitenlandsAdres">
											<xsl:with-param name="address" select="$address"/>
										</xsl:call-template>
									</xsl:if>
									<xsl:variable name="sex">
										<xsl:choose>
											<xsl:when test="tia:tia_Gegevens/tia:GBA_Ingezetene">
												<xsl:value-of select="tia:tia_Gegevens/tia:GBA_Ingezetene/tia:geslacht/tia:geslachtsaanduiding"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:geslacht"/>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:variable>
									<!-- Identity document -->
									<xsl:if test="tia:tia_Legitimatiebewijs">
										<xsl:variable name="legitimatie" select="tia:tia_Legitimatiebewijs"/>
										<xsl:call-template name="Legitimatiebewijs">
											<xsl:with-param name="legitimatie" select="$legitimatie"/>
											<xsl:with-param name="sex" select="$sex"/>
											<xsl:with-param name="typeD" select="$type"/>
										</xsl:call-template>
									</xsl:if>
									<xsl:text>, </xsl:text>
									<xsl:value-of select="tia:tia_BurgerlijkeStaatTekst"/>
									<xsl:choose>
										<xsl:when test="translate($type,$upper,$lower) = 'doc'">
											<xsl:text>,</xsl:text>
										</xsl:when>
										<xsl:otherwise>
											<xsl:text>;</xsl:text>
										</xsl:otherwise>
									</xsl:choose>
								</td>
							</tr>
							<xsl:if test="translate(tia:tia_BurgerlijkeStaatTekst,$upper,$lower) = 'gehuwd met' or  translate(tia:tia_BurgerlijkeStaatTekst,$upper,$lower) = 'geregistreerd partner van'">
								<xsl:if test="tia:GerelateerdPersoon">
									<xsl:variable name="partner" select="tia:GerelateerdPersoon/tia:IMKAD_Persoon"/>
									<tr>
										<td class="number" valign="top">
											<xsl:text>&#xFEFF;</xsl:text>
										</td>
										<td class="number" valign="top">
											<xsl:text>&#xFEFF;</xsl:text>
										</td>
										<td class="number" valign="top">
											<xsl:text>2.</xsl:text>
										</td>
										<td>
											<xsl:call-template name="Partner">
												<xsl:with-param name="partner" select="$partner"/>
												<xsl:with-param name="type" select="$type"/>
												<xsl:with-param name="isNetworkNotary" select="$isNetworkNotary"/>
											</xsl:call-template>
											<xsl:choose>
												<xsl:when test="translate($type,$upper,$lower) = 'doc'">
													<xsl:text>,</xsl:text>
												</xsl:when>
												<xsl:otherwise>
													<xsl:text>;</xsl:text>
												</xsl:otherwise>
											</xsl:choose>
										</td>
									</tr>
								</xsl:if>
							</xsl:if>
						</xsl:if>
					</xsl:when>
					<xsl:otherwise>
						<tr>
							<xsl:choose>
								<xsl:when test="$index = 1">
									<xsl:choose>	
										<xsl:when test="translate($hasAuthorizedRepresentative,$upper,$lower) = 'false'">
											<td class="number" valign="top">
												<a name="{$id}" class="location" style="_position: relative;">&#xFEFF;</a>
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
										</xsl:when>
										<xsl:otherwise>
											<td class="number" valign="top">
												<xsl:text>&#xFEFF;</xsl:text>
											</td>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
								<xsl:otherwise>
									<td class="number" valign="top">
										<xsl:text>&#xFEFF;</xsl:text>
									</td>
								</xsl:otherwise>
							</xsl:choose>
							<td class="number" valign="top">
								<xsl:choose>
									<xsl:when test="translate($type,$upper,$lower) = 'doc'">
										<xsl:number value="$index" format="1"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:number value="$index" format="a"/>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:text>.</xsl:text>
							</td>
							<td>
								<!-- Legal person -->
								<xsl:if test="tia:tia_Gegevens/tia:NHR_Rechtspersoon">
									<!-- Legal person manager -->
									<xsl:if test="tia:GerelateerdPersoon">
										<xsl:variable name="bestuurder" select="tia:GerelateerdPersoon/tia:IMKAD_Persoon"/>
										<xsl:call-template name="Bestuurder">
											<xsl:with-param name="bestuurder" select="$bestuurder"/>
											<xsl:with-param name="type" select="$type"/>
										</xsl:call-template>
									</xsl:if>
									<xsl:variable name="bestuurderParent" select="tia:GerelateerdPersoon"/>
									<xsl:call-template name="NHR_Rechtspersoon">
										<xsl:with-param name="rechtspersoon" select="tia:tia_Gegevens/tia:NHR_Rechtspersoon"/>
										<xsl:with-param name="bestuurderParent" select="$bestuurderParent"/>
										<xsl:with-param name="type" select="$type"/>
										<xsl:with-param name="multiple-persons" select="$multiple-persons"/>
									</xsl:call-template>
								</xsl:if>
								<!-- Natural person -->
								<xsl:if test="tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene">
									<!-- RESIDENT -->
									<xsl:if test="tia:tia_Gegevens/tia:GBA_Ingezetene">
										<xsl:variable name="ingezetene" select="tia:tia_Gegevens/tia:GBA_Ingezetene"/>
										<xsl:call-template name="GBA_Ingezetene">
											<xsl:with-param name="ingezetene" select="$ingezetene"/>
										</xsl:call-template>
									</xsl:if>
									<!-- NON RESIDENT -->
									<xsl:if test="tia:tia_Gegevens/tia:IMKAD_NietIngezetene">
										<xsl:variable name="nietIngezetene" select="tia:tia_Gegevens/tia:IMKAD_NietIngezetene"/>
										<xsl:call-template name="IMKAD_NietIngezetene">
											<xsl:with-param name="nietIngezetene" select="$nietIngezetene"/>
										</xsl:call-template>
									</xsl:if>
									<!--domestic address-->
									<xsl:if test="tia:IMKAD_WoonlocatiePersoon/tia:adres/tia:binnenlandsAdres">
										<xsl:text>, wonende te </xsl:text>
										<xsl:variable name="address" select="tia:IMKAD_WoonlocatiePersoon/tia:adres/tia:binnenlandsAdres"/>
										<xsl:call-template name="binnenlandsAdres">
											<xsl:with-param name="address" select="$address"/>
										</xsl:call-template>
									</xsl:if>
									<!--foreign address-->
									<xsl:if test="tia:IMKAD_WoonlocatiePersoon/tia:adres/tia:buitenlandsAdres">
										<xsl:text>, wonende te </xsl:text>
										<xsl:variable name="address" select="tia:IMKAD_WoonlocatiePersoon/tia:adres/tia:buitenlandsAdres"/>
										<xsl:call-template name="buitenlandsAdres">
											<xsl:with-param name="address" select="$address"/>
										</xsl:call-template>
									</xsl:if>
									<xsl:variable name="sex">
										<xsl:choose>
											<xsl:when test="tia:tia_Gegevens/tia:GBA_Ingezetene">
												<xsl:value-of select="tia:tia_Gegevens/tia:GBA_Ingezetene/tia:geslacht/tia:geslachtsaanduiding"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:geslacht"/>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:variable>
									<!-- Identity document -->
									<xsl:if test="tia:tia_Legitimatiebewijs">
										<xsl:variable name="legitimatie" select="tia:tia_Legitimatiebewijs"/>
										<xsl:call-template name="Legitimatiebewijs">
											<xsl:with-param name="legitimatie" select="$legitimatie"/>
											<xsl:with-param name="sex" select="$sex"/>
											<xsl:with-param name="typeD" select="$type"/>
										</xsl:call-template>
									</xsl:if>
									<xsl:text>, </xsl:text>
									<xsl:value-of select="tia:tia_BurgerlijkeStaatTekst"/>
									<!-- Not using partners
									<xsl:if test="tia:tia_BurgerlijkeStaatTekst = 'gehuwd met' or  tia:tia_BurgerlijkeStaatTekst = 'geregistreerd partner van'">
										<xsl:if test="tia:GerelateerdPersoon">
											<xsl:variable name="partner" select="tia:GerelateerdPersoon/tia:IMKAD_Persoon"/>
											<xsl:text> </xsl:text>
											<xsl:call-template name="Partner">
												<xsl:with-param name="partner" select="$partner"/>
												<xsl:with-param name="type" select="$type"/>
											</xsl:call-template>
										</xsl:if>
									</xsl:if>
									-->
									<xsl:choose>
										<xsl:when test="translate($type,$upper,$lower) = 'doc'">
											<xsl:text>,</xsl:text>
										</xsl:when>
										<xsl:otherwise>
											<xsl:text>;</xsl:text>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:if>
							</td>
						</tr>
					</xsl:otherwise>
				</xsl:choose>
				<!--toekomstig adres:-->
				<xsl:if test="tia:toekomstigAdres">
					<tr>
						<td class="number" valign="top">
							<xsl:text>&#xFEFF;</xsl:text>
						</td>
						<td class="number" valign="top">
							<xsl:text>&#xFEFF;</xsl:text>
						</td>
						<td>
							<xsl:if test="translate($isNetworkNotary,$upper,$lower) = 'true' and $numberOfPersonsPairs > 0">
								<xsl:if test="$colspan != ''">
									<xsl:attribute name="colspan">
										<xsl:text>2</xsl:text>
									</xsl:attribute>
								</xsl:if>
							</xsl:if>
							<xsl:text>toekomstig adres: </xsl:text>
							<!--domestic address-->
							<xsl:if test="tia:toekomstigAdres/tia:adres/tia:binnenlandsAdres">
								<xsl:variable name="address" select="tia:toekomstigAdres/tia:adres/tia:binnenlandsAdres"/>
								<xsl:call-template name="binnenlandsAdres">
									<xsl:with-param name="address" select="$address"/>
								</xsl:call-template>
							</xsl:if>
							<!--foreign address-->
							<xsl:if test="tia:toekomstigAdres/tia:adres/tia:buitenlandsAdres">
								<xsl:variable name="address" select="tia:toekomstigAdres/tia:adres/tia:buitenlandsAdres"/>
								<xsl:call-template name="buitenlandsAdres">
									<xsl:with-param name="address" select="$address"/>
								</xsl:call-template>
							</xsl:if>
						</td>
					</tr>
				</xsl:if>
				<xsl:if test="translate($type,$upper,$lower) = 'doc'">
					<tr>
						<td class="number" valign="top">
							<xsl:text>&#xFEFF;</xsl:text>
						</td>
						<td class="number" valign="top">
							<xsl:text>&#xFEFF;</xsl:text>
						</td>
						<td>
							<xsl:text>hierna te noemen: </xsl:text>
							<xsl:value-of select="$nestedParty/tia:aanduidingPartij"/>
							<xsl:text>;</xsl:text>
						</td>
					</tr>			
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="translate($isNetworkNotary,$upper,$lower) = 'true'">
						<!-- Legal person -->
						<xsl:if test="tia:tia_Gegevens/tia:NHR_Rechtspersoon">
							<tr>
								<xsl:choose>
									<xsl:when test="translate($hasAuthorizedRepresentative,$upper,$lower) = 'true'">
										<td class="number" valign="top">
											<xsl:text>&#xFEFF;</xsl:text>
										</td>
									</xsl:when>
									<xsl:otherwise>
										<td class="number" valign="top">
											<a name="{$id}" class="location" style="_position: relative;">&#xFEFF;</a>
											<xsl:number value="$position" format="1"/>
											<xsl:text>.</xsl:text>
										</td>
									</xsl:otherwise>
								</xsl:choose>
								<td>
									<!-- Legal person manager -->
									<xsl:if test="tia:GerelateerdPersoon">
										<xsl:variable name="bestuurder" select="tia:GerelateerdPersoon/tia:IMKAD_Persoon"/>
										<xsl:call-template name="Bestuurder">
											<xsl:with-param name="bestuurder" select="$bestuurder"/>
											<xsl:with-param name="type" select="$type"/>
											<xsl:with-param name="isNetworkNotary" select="$isNetworkNotary"/>
										</xsl:call-template>
									</xsl:if>
									<xsl:variable name="bestuurderParent" select="tia:GerelateerdPersoon"/>
									<xsl:call-template name="NHR_Rechtspersoon">
										<xsl:with-param name="rechtspersoon" select="tia:tia_Gegevens/tia:NHR_Rechtspersoon"/>
										<xsl:with-param name="bestuurderParent" select="$bestuurderParent"/>
										<xsl:with-param name="type" select="$type"/>
										<xsl:with-param name="multiple-persons" select="$multiple-persons"/>
										<xsl:with-param name="isNetworkNotary" select="$isNetworkNotary"/>
									</xsl:call-template>
								</td>
							</tr>
						</xsl:if>
						<!-- Natural person -->
						<xsl:if test="tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene">
							<tr>
								<xsl:choose>
									<xsl:when test="translate($hasAuthorizedRepresentative,$upper,$lower) = 'true'">
										<td class="number" valign="top">
											<xsl:text>&#xFEFF;</xsl:text>
										</td>
									</xsl:when>
									<xsl:otherwise>
										<td class="number" valign="top">
											<a name="{$id}" class="location" style="_position: relative;">&#xFEFF;</a>
											<xsl:number value="$position" format="1"/>
											<xsl:text>.</xsl:text>
										</td>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:if test="translate(tia:tia_BurgerlijkeStaatTekst,$upper,$lower) = 'gehuwd met' or  translate(tia:tia_BurgerlijkeStaatTekst,$upper,$lower) = 'geregistreerd partner van'">
									<td class="number" valign="top">
										<xsl:text>a.</xsl:text>
									</td>
								</xsl:if>
								<td>
									<!-- RESIDENT -->
									<xsl:if test="tia:tia_Gegevens/tia:GBA_Ingezetene">
										<xsl:variable name="ingezetene" select="tia:tia_Gegevens/tia:GBA_Ingezetene"/>
										<xsl:call-template name="GBA_Ingezetene">
											<xsl:with-param name="ingezetene" select="$ingezetene"/>
										</xsl:call-template>
									</xsl:if>
									<!-- NON RESIDENT -->
									<xsl:if test="tia:tia_Gegevens/tia:IMKAD_NietIngezetene">
										<xsl:variable name="nietIngezetene" select="tia:tia_Gegevens/tia:IMKAD_NietIngezetene"/>
										<xsl:call-template name="IMKAD_NietIngezetene">
											<xsl:with-param name="nietIngezetene" select="$nietIngezetene"/>
										</xsl:call-template>
									</xsl:if>
									<!--domestic address-->
									<xsl:if test="tia:IMKAD_WoonlocatiePersoon/tia:adres/tia:binnenlandsAdres">
										<xsl:text>, wonende te </xsl:text>
										<xsl:variable name="address" select="tia:IMKAD_WoonlocatiePersoon/tia:adres/tia:binnenlandsAdres"/>
										<xsl:call-template name="binnenlandsAdres">
											<xsl:with-param name="address" select="$address"/>
										</xsl:call-template>
									</xsl:if>
									<!--foreign address-->
									<xsl:if test="tia:IMKAD_WoonlocatiePersoon/tia:adres/tia:buitenlandsAdres">
										<xsl:text>, wonende te </xsl:text>
										<xsl:variable name="address" select="tia:IMKAD_WoonlocatiePersoon/tia:adres/tia:buitenlandsAdres"/>
										<xsl:call-template name="buitenlandsAdres">
											<xsl:with-param name="address" select="$address"/>
										</xsl:call-template>
									</xsl:if>
									<xsl:variable name="sex">
										<xsl:choose>
											<xsl:when test="tia:tia_Gegevens/tia:GBA_Ingezetene">
												<xsl:value-of select="tia:tia_Gegevens/tia:GBA_Ingezetene/tia:geslacht/tia:geslachtsaanduiding"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:geslacht"/>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:variable>
									<!-- Identity document -->
									<xsl:if test="tia:tia_Legitimatiebewijs">
										<xsl:variable name="legitimatie" select="tia:tia_Legitimatiebewijs"/>
										<xsl:call-template name="Legitimatiebewijs">
											<xsl:with-param name="legitimatie" select="$legitimatie"/>
											<xsl:with-param name="sex" select="$sex"/>
											<xsl:with-param name="typeD" select="$type"/>
										</xsl:call-template>
									</xsl:if>
									<xsl:text>, </xsl:text>
									<xsl:value-of select="tia:tia_BurgerlijkeStaatTekst"/>
									<xsl:text>;</xsl:text>
								</td>
							</tr>
							<xsl:if test="translate(tia:tia_BurgerlijkeStaatTekst,$upper,$lower) = 'gehuwd met' or translate(tia:tia_BurgerlijkeStaatTekst,$upper,$lower) = 'geregistreerd partner van'">
								<xsl:if test="tia:GerelateerdPersoon">
									<tr>
										<td class="number" valign="top">
											<xsl:text>&#xFEFF;</xsl:text>
										</td>
										<td class="number" valign="top">
											<xsl:text>b.</xsl:text>
										</td>
										<td>
											<xsl:variable name="partner" select="tia:GerelateerdPersoon/tia:IMKAD_Persoon"/>
											<xsl:call-template name="Partner">
												<xsl:with-param name="partner" select="$partner"/>
												<xsl:with-param name="type" select="$type"/>
												<xsl:with-param name="isNetworkNotary" select="$isNetworkNotary"/>
											</xsl:call-template>
											<xsl:text>;</xsl:text>
										</td>
									</tr>
								</xsl:if>
							</xsl:if>
						</xsl:if>
					</xsl:when>
					<xsl:otherwise>
						<tr>
							<xsl:choose>	
								<xsl:when test="translate($hasAuthorizedRepresentative,$upper,$lower) = 'false'">
									<td class="number" valign="top">
										<a name="{$id}" class="location" style="_position: relative;">&#xFEFF;</a>
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
								</xsl:when>
								<xsl:otherwise>
									<td class="number" valign="top">
										<xsl:text>&#xFEFF;</xsl:text>
									</td>
								</xsl:otherwise>
							</xsl:choose>
							<td>
								<xsl:if test="$colspan != ''">
									<xsl:attribute name="colspan">
										<xsl:value-of select="$colspan"/>
									</xsl:attribute>
								</xsl:if>
								<!-- Legal person -->
								<xsl:if test="tia:tia_Gegevens/tia:NHR_Rechtspersoon">
									<!-- Legal person manager -->
									<xsl:if test="tia:GerelateerdPersoon">
										<xsl:variable name="bestuurder" select="tia:GerelateerdPersoon/tia:IMKAD_Persoon"/>
										<xsl:call-template name="Bestuurder">
											<xsl:with-param name="bestuurder" select="$bestuurder"/>
											<xsl:with-param name="type" select="$type"/>
										</xsl:call-template>
									</xsl:if>
									<xsl:variable name="bestuurderParent" select="tia:GerelateerdPersoon"/>
									<xsl:call-template name="NHR_Rechtspersoon">
										<xsl:with-param name="rechtspersoon" select="tia:tia_Gegevens/tia:NHR_Rechtspersoon"/>
										<xsl:with-param name="bestuurderParent" select="$bestuurderParent"/>
										<xsl:with-param name="type" select="$type"/>
										<xsl:with-param name="multiple-persons" select="$multiple-persons"/>
									</xsl:call-template>
								</xsl:if>
								<!-- Natural person -->
								<xsl:if test="tia:tia_Gegevens/tia:GBA_Ingezetene or tia:tia_Gegevens/tia:IMKAD_NietIngezetene">
									<!-- RESIDENT -->
									<xsl:if test="tia:tia_Gegevens/tia:GBA_Ingezetene">
										<xsl:variable name="ingezetene" select="tia:tia_Gegevens/tia:GBA_Ingezetene"/>
										<xsl:call-template name="GBA_Ingezetene">
											<xsl:with-param name="ingezetene" select="$ingezetene"/>
										</xsl:call-template>
									</xsl:if>
									<!-- NON RESIDENT -->
									<xsl:if test="tia:tia_Gegevens/tia:IMKAD_NietIngezetene">
										<xsl:variable name="nietIngezetene" select="tia:tia_Gegevens/tia:IMKAD_NietIngezetene"/>
										<xsl:call-template name="IMKAD_NietIngezetene">
											<xsl:with-param name="nietIngezetene" select="$nietIngezetene"/>
										</xsl:call-template>
									</xsl:if>
									<!--domestic address-->
									<xsl:if test="tia:IMKAD_WoonlocatiePersoon/tia:adres/tia:binnenlandsAdres">
										<xsl:text>, wonende te </xsl:text>
										<xsl:variable name="address" select="tia:IMKAD_WoonlocatiePersoon/tia:adres/tia:binnenlandsAdres"/>
										<xsl:call-template name="binnenlandsAdres">
											<xsl:with-param name="address" select="$address"/>
										</xsl:call-template>
									</xsl:if>
									<!--foreign address-->
									<xsl:if test="tia:IMKAD_WoonlocatiePersoon/tia:adres/tia:buitenlandsAdres">
										<xsl:text>, wonende te </xsl:text>
										<xsl:variable name="address" select="tia:IMKAD_WoonlocatiePersoon/tia:adres/tia:buitenlandsAdres"/>
										<xsl:call-template name="buitenlandsAdres">
											<xsl:with-param name="address" select="$address"/>
										</xsl:call-template>
									</xsl:if>
									<xsl:variable name="sex">
										<xsl:choose>
											<xsl:when test="tia:tia_Gegevens/tia:GBA_Ingezetene">
												<xsl:value-of select="tia:tia_Gegevens/tia:GBA_Ingezetene/tia:geslacht/tia:geslachtsaanduiding"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:geslacht"/>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:variable>
									<!-- Identity document -->
									<xsl:if test="tia:tia_Legitimatiebewijs">
										<xsl:variable name="legitimatie" select="tia:tia_Legitimatiebewijs"/>
										<xsl:call-template name="Legitimatiebewijs">
											<xsl:with-param name="legitimatie" select="$legitimatie"/>
											<xsl:with-param name="sex" select="$sex"/>
											<xsl:with-param name="typeD" select="$type"/>
										</xsl:call-template>
									</xsl:if>
									<xsl:text>, </xsl:text>
									<xsl:value-of select="tia:tia_BurgerlijkeStaatTekst"/>
									<!-- Not using partners
									<xsl:if test="tia:tia_BurgerlijkeStaatTekst = 'gehuwd met' or  tia:tia_BurgerlijkeStaatTekst = 'geregistreerd partner van'">
										<xsl:if test="tia:GerelateerdPersoon">
											<xsl:variable name="partner" select="tia:GerelateerdPersoon/tia:IMKAD_Persoon"/>
											<xsl:text> </xsl:text>
											<xsl:call-template name="Partner">
												<xsl:with-param name="partner" select="$partner"/>
												<xsl:with-param name="type" select="$type"/>
											</xsl:call-template>
										</xsl:if>
									</xsl:if>
									-->
									<xsl:choose>
										<xsl:when test="translate($type,$upper,$lower) = 'doc'">
											<xsl:text>,</xsl:text>
										</xsl:when>
										<xsl:otherwise>
											<xsl:text>;</xsl:text>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:if>
							</td>
						</tr>
					</xsl:otherwise>
				</xsl:choose>
				<!--toekomstig adres:-->
				<xsl:if test="tia:toekomstigAdres">
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
							<xsl:text>toekomstig adres: </xsl:text>
							<!--domestic address-->
							<xsl:if test="tia:toekomstigAdres/tia:adres/tia:binnenlandsAdres">
								<xsl:variable name="address" select="tia:toekomstigAdres/tia:adres/tia:binnenlandsAdres"/>
								<xsl:call-template name="binnenlandsAdres">
									<xsl:with-param name="address" select="$address"/>
								</xsl:call-template>
							</xsl:if>
							<!--foreign address-->
							<xsl:if test="tia:toekomstigAdres/tia:adres/tia:buitenlandsAdres">
								<xsl:variable name="address" select="tia:toekomstigAdres/tia:adres/tia:buitenlandsAdres"/>
								<xsl:call-template name="buitenlandsAdres">
									<xsl:with-param name="address" select="$address"/>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="translate($isNetworkNotary,$upper,$lower) = 'true' and $futureAddressText != ''">
								<xsl:text> </xsl:text>
								<xsl:value-of select="$futureAddressText"/>
								<xsl:text> </xsl:text>
							</xsl:if>
						</td>
					</tr>
				</xsl:if>
				<xsl:if test="translate($type,$upper,$lower) = 'doc'">
					<tr>
						<td class="number" valign="top">
							<xsl:text>&#xFEFF;</xsl:text>
						</td>
						<td>
							<xsl:text>hierna te noemen: </xsl:text>
							<xsl:value-of select="$nestedParty/tia:aanduidingPartij"/>
							<xsl:text>;</xsl:text>
						</td>
					</tr>			
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- Legal person manager -->
	<xsl:template name="Bestuurder">
		<xsl:param name="bestuurder"/>
		<xsl:param name="type"/>
		<xsl:param name="isNetworkNotary" select="'false'"/>
		<xsl:param name="isIndParty" select="'false'"/>

		<!-- RESIDENT -->
		<xsl:if test="$bestuurder/tia:tia_Gegevens/tia:GBA_Ingezetene">
			<xsl:variable name="ingez" select="$bestuurder/tia:tia_Gegevens/tia:GBA_Ingezetene"/>
			<xsl:call-template name="GBA_Ingezetene">
				<xsl:with-param name="ingezetene" select="$ingez"/>
			</xsl:call-template>
		</xsl:if>
		<!-- NON RESIDENT -->
		<xsl:if test="$bestuurder/tia:tia_Gegevens/tia:IMKAD_NietIngezetene">
			<xsl:variable name="nietIngez" select="$bestuurder/tia:tia_Gegevens/tia:IMKAD_NietIngezetene"/>
			<xsl:call-template name="IMKAD_NietIngezetene">
				<xsl:with-param name="nietIngezetene" select="$nietIngez"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="$bestuurder/tia:IMKAD_WoonlocatiePersoon">
			<xsl:text>, wonende te </xsl:text>
			<!--domestic address-->
			<xsl:if test="$bestuurder/tia:IMKAD_WoonlocatiePersoon/tia:adres/tia:binnenlandsAdres">
				<xsl:variable name="addr" select="$bestuurder/tia:IMKAD_WoonlocatiePersoon/tia:adres/tia:binnenlandsAdres"/>
				<xsl:call-template name="binnenlandsAdres">
					<xsl:with-param name="address" select="$addr"/>
				</xsl:call-template>
			</xsl:if>
			<!--foreign address-->
			<xsl:if test="$bestuurder/tia:IMKAD_WoonlocatiePersoon/tia:adres/tia:buitenlandsAdres">
				<xsl:variable name="addr" select="$bestuurder/tia:IMKAD_WoonlocatiePersoon/tia:adres/tia:buitenlandsAdres"/>
				<xsl:call-template name="buitenlandsAdres">
					<xsl:with-param name="address" select="$addr"/>
				</xsl:call-template>
			</xsl:if>
		</xsl:if>
		<xsl:variable name="sex2">
			<xsl:choose>
				<xsl:when test="$bestuurder/tia:tia_Gegevens/tia:GBA_Ingezetene">
					<xsl:value-of select="$bestuurder/tia:tia_Gegevens/tia:GBA_Ingezetene/tia:geslacht/tia:geslachtsaanduiding"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$bestuurder/tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:geslacht"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- Identity document -->
		<xsl:if test="$bestuurder/tia:tia_Legitimatiebewijs">
			<!--<xsl:if test="$bestuurder/tia:tia_Legitimatiebewijs" >-->
			<xsl:variable name="legitim" select="$bestuurder/tia:tia_Legitimatiebewijs"/>
			<xsl:call-template name="Legitimatiebewijs">
				<xsl:with-param name="legitimatie" select="$legitim"/>
				<xsl:with-param name="sex" select="$sex2"/>
				<xsl:with-param name="typeD" select="$type"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="$bestuurder/tia:tia_BurgerlijkeStaatTekst">
			<xsl:text>, </xsl:text>
			<xsl:value-of select="$bestuurder/tia:tia_BurgerlijkeStaatTekst"/>
			<xsl:text>;</xsl:text>
		</xsl:if>
		<xsl:choose>
			<xsl:when test="translate($isNetworkNotary,$upper,$lower) = 'true'">
				<xsl:text> te dezen</xsl:text>
				<xsl:choose>
					<xsl:when test="translate($isIndParty,$upper,$lower) = 'true'">
						<xsl:text>:</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text> </xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text> te dezen:</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<!-- RESIDENT -->
	<xsl:template name="GBA_Ingezetene">
		<xsl:param name="ingezetene"/>
		<xsl:if test="translate($ingezetene/tia:geslacht/tia:geslachtsaanduiding,$upper,$lower) = 'man'">
			<xsl:text>de heer</xsl:text>
		</xsl:if>
		<xsl:if test="translate($ingezetene/tia:geslacht/tia:geslachtsaanduiding,$upper,$lower) = 'vrouw'">
			<xsl:text>mevrouw</xsl:text>
		</xsl:if>
		<xsl:text> </xsl:text>
		<xsl:call-template name="person_data">
			<xsl:with-param name="person" select="$ingezetene"/>
		</xsl:call-template>
	</xsl:template>    
    
	<!-- NON RESIDENT -->
	<xsl:template name="IMKAD_NietIngezetene">
		<xsl:param name="nietIngezetene"/>
		<xsl:if test="translate($nietIngezetene/tia:geslacht,$upper,$lower) = 'man'">
			<xsl:text>de heer</xsl:text>
		</xsl:if>
		<xsl:if test="translate($nietIngezetene/tia:geslacht,$upper,$lower) = 'vrouw'">
			<xsl:text>mevrouw</xsl:text>
		</xsl:if>
		<xsl:text> </xsl:text>
		<xsl:call-template name="person_data">
			<xsl:with-param name="person" select="$nietIngezetene"/>
		</xsl:call-template>
	</xsl:template>
    
	<!-- LEGAL PESON -->
	<xsl:template name="NHR_Rechtspersoon">
		<xsl:param name="rechtspersoon"/>
		<xsl:param name="bestuurderParent"/>
		<xsl:param name="multiple-persons" select="'false'"/>
		<xsl:param name="type"/>
		<xsl:param name="isNetworkNotary" select="'false'"/>

		<xsl:choose>
			<xsl:when test="translate($bestuurderParent/tia:tia_IndPartij,$upper,$lower) = 'true'">
				<ul class="arrow">
					<li class="arrow">handelend in privé; en</li>
					<li class="arrow">
						<xsl:call-template name="legal-person-content">
							<xsl:with-param name="rechtspersoon" select="$rechtspersoon"/>
							<xsl:with-param name="type" select="$type"/>
							<xsl:with-param name="isNetworkNotary" select="$isNetworkNotary"/>
						</xsl:call-template>
					</li>
				</ul>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="legal-person-content">
					<xsl:with-param name="rechtspersoon" select="$rechtspersoon"/>
					<xsl:with-param name="type" select="$type"/>
					<xsl:with-param name="isNetworkNotary" select="$isNetworkNotary"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="legal-person-content">
		<xsl:param name="rechtspersoon"/>
		<xsl:param name="type"/>
		<xsl:param name="isNetworkNotary" select="'false'"/>
		<xsl:if test="translate($type,$upper,$lower) != 'doc'">
			<xsl:text>rechtsgeldig vertegenwoordigend </xsl:text>
		</xsl:if>
		<xsl:choose>
			<xsl:when test="translate($rechtspersoon/tia:rechtsvormSub,$upper,$lower) = 'de staat' or $rechtspersoon/tia:rechtsvormSub = ''">
				<xsl:text/>
			</xsl:when>
			<xsl:when test="translate($rechtspersoon/tia:rechtsvormSub,$upper,$lower) = 'kerkgenootschap alsmede haar zelfstandige onderdelen'">
				<xsl:text>het </xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>de </xsl:text>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:value-of select="$rechtspersoon/tia:rechtsvormSub"/>
		<xsl:text>: </xsl:text>
		<xsl:value-of select="$rechtspersoon/tia:statutaireNaam"/>
		<xsl:text>, statutair gevestigd te </xsl:text>
		<xsl:value-of select="$rechtspersoon/tia:statutaireZetel"/>
		<xsl:if test="$rechtspersoon/tia:tia_LandStatutaireZetel">
			<xsl:if test="string-length($rechtspersoon/tia:tia_LandStatutaireZetel)!=0">
				<xsl:text>, </xsl:text>
				<xsl:value-of select="$rechtspersoon/tia:tia_LandStatutaireZetel"/>
			</xsl:if>
		</xsl:if>
		<xsl:text>, kantoor houdende te </xsl:text>
		<!--domestic address-->
		<xsl:if test="tia:IMKAD_WoonlocatiePersoon/tia:adres/tia:binnenlandsAdres">
			<xsl:variable name="address" select="tia:IMKAD_WoonlocatiePersoon/tia:adres/tia:binnenlandsAdres"/>
			<xsl:call-template name="binnenlandsAdres">
				<xsl:with-param name="address" select="$address"/>
			</xsl:call-template>
		</xsl:if>
		<!--foreign address-->
		<xsl:if test="tia:IMKAD_WoonlocatiePersoon/tia:adres/tia:buitenlandsAdres">
			<xsl:variable name="address" select="tia:IMKAD_WoonlocatiePersoon/tia:adres/tia:buitenlandsAdres"/>
			<xsl:call-template name="buitenlandsAdres">
				<xsl:with-param name="address" select="$address"/>
			</xsl:call-template>
		</xsl:if>
		<!-- Chamber of commerce -->
		<xsl:if test="$rechtspersoon/tia:tia_PlaatsKvK and $rechtspersoon/tia:FINummer">
			<xsl:if test="string-length($rechtspersoon/tia:tia_PlaatsKvK)!=0 and string-length($rechtspersoon/tia:FINummer)!=0">
				<xsl:if test="translate($isNetworkNotary,$upper,$lower) = 'true'">
					<xsl:text>,</xsl:text>
				</xsl:if>
				<xsl:text> ingeschreven in het register van de Kamer van Koophandel en </xsl:text>
				<xsl:choose>
					<xsl:when test="translate($isNetworkNotary,$upper,$lower) = 'true'">
						<xsl:text>fabrieken</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>Fabrieken</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:text> te </xsl:text>
				<xsl:value-of select="$rechtspersoon/tia:tia_PlaatsKvK"/>
				<xsl:text>, onder dossiernummer </xsl:text>
				<xsl:value-of select="$rechtspersoon/tia:FINummer"/>
			</xsl:if>
		</xsl:if>
	    <xsl:if test="tia:IMKAD_PostlocatiePersoon">
	    	<xsl:text>, (correspondentieadres voor alle aangelegenheden betreffende de hierna te vermelden rechtshandelingen: </xsl:text>
	    	<xsl:choose>
	    		<!--
	    			Different layout is used for dutch or foreign addres when generating correspondant address
	    			TODO: refactor to use common templates when agreed to change the layout in functional design
	    		 -->
	    		<xsl:when test="tia:IMKAD_PostlocatiePersoon/tia:adres/tia:binnenlandsAdres">
	    			<xsl:value-of select="tia:IMKAD_PostlocatiePersoon/tia:adres/tia:binnenlandsAdres/tia:BAG_NummerAanduiding/tia:postcode" />
			        <xsl:text>, </xsl:text>
			        <xsl:value-of select="tia:IMKAD_PostlocatiePersoon/tia:adres/tia:binnenlandsAdres/tia:BAG_Woonplaats/tia:woonplaatsNaam" />
			        <xsl:text>, </xsl:text>
			        <xsl:value-of select="tia:IMKAD_PostlocatiePersoon/tia:adres/tia:binnenlandsAdres/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam" />
			        <xsl:if test="tia:IMKAD_PostlocatiePersoon/tia:adres/tia:binnenlandsAdres/tia:BAG_NummerAanduiding/tia:huisnummer">
			            <xsl:if test="string-length(tia:IMKAD_PostlocatiePersoon/tia:adres/tia:binnenlandsAdres/tia:BAG_NummerAanduiding/tia:huisnummer) != 0">
			                <xsl:text>, </xsl:text>
			                <xsl:value-of select="tia:IMKAD_PostlocatiePersoon/tia:adres/tia:binnenlandsAdres/tia:BAG_NummerAanduiding/tia:huisnummer" />
			            </xsl:if>
			        </xsl:if>
			        <xsl:if test="tia:IMKAD_PostlocatiePersoon/tia:adres/tia:binnenlandsAdres/tia:BAG_NummerAanduiding/tia:huisletter">
			            <xsl:if test="string-length(tia:IMKAD_PostlocatiePersoon/tia:adres/tia:binnenlandsAdres/tia:BAG_NummerAanduiding/tia:huisletter) != 0">
			                <xsl:text>, </xsl:text>
			                <xsl:value-of select="tia:IMKAD_PostlocatiePersoon/tia:adres/tia:binnenlandsAdres/tia:BAG_NummerAanduiding/tia:huisletter" />
			            </xsl:if>
			        </xsl:if>
			        <xsl:if test="tia:IMKAD_PostlocatiePersoon/tia:adres/tia:binnenlandsAdres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging">
			            <xsl:if test="string-length(tia:IMKAD_PostlocatiePersoon/tia:adres/tia:binnenlandsAdres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging) != 0">
			                <xsl:text>, </xsl:text>
			                <xsl:value-of select="tia:IMKAD_PostlocatiePersoon/tia:adres/tia:binnenlandsAdres/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging" />
			            </xsl:if>
			        </xsl:if>
	    		</xsl:when>
	    		<xsl:when test="tia:IMKAD_PostlocatiePersoon/tia:adres/tia:buitenlandsAdres">
			        <xsl:if test="tia:IMKAD_PostlocatiePersoon/tia:adres/tia:buitenlandsAdres/tia:regio">
			            <xsl:if test="string-length(tia:IMKAD_PostlocatiePersoon/tia:adres/tia:buitenlandsAdres/tia:regio) != 0">
			                <xsl:value-of select="tia:IMKAD_PostlocatiePersoon/tia:adres/tia:buitenlandsAdres/tia:regio" />
			                <xsl:text>, </xsl:text>
			            </xsl:if>
			        </xsl:if>
	    			<xsl:if test="tia:IMKAD_PostlocatiePersoon/tia:adres/tia:buitenlandsAdres/tia:woonplaats">
			            <xsl:if test="string-length(tia:IMKAD_PostlocatiePersoon/tia:adres/tia:buitenlandsAdres/tia:woonplaats) != 0">
			                <xsl:value-of select="tia:IMKAD_PostlocatiePersoon/tia:adres/tia:buitenlandsAdres/tia:woonplaats" />
			                <xsl:text>, </xsl:text>
			            </xsl:if>
			        </xsl:if>
			        <xsl:if test="tia:IMKAD_PostlocatiePersoon/tia:adres/tia:buitenlandsAdres/tia:adres">
			            <xsl:if test="string-length(tia:IMKAD_PostlocatiePersoon/tia:adres/tia:buitenlandsAdres/tia:adres) != 0">
			                <xsl:value-of select="tia:IMKAD_PostlocatiePersoon/tia:adres/tia:buitenlandsAdres/tia:adres" />
			                <xsl:text>, </xsl:text>
			            </xsl:if>
			        </xsl:if>
			        <xsl:value-of select="tia:IMKAD_PostlocatiePersoon/tia:adres/tia:buitenlandsAdres/tia:land" />
	    		</xsl:when>
	    		<xsl:when test="tia:IMKAD_PostlocatiePersoon/tia:adres/tia:postbusAdres">
					<xsl:call-template name="postbusAdres">
						<xsl:with-param name="address" select="tia:IMKAD_PostlocatiePersoon/tia:adres/tia:postbusAdres"/>
					</xsl:call-template>
	    		</xsl:when>
	    	</xsl:choose>
	    	<xsl:text>)</xsl:text>
	    </xsl:if>
		<xsl:text>;</xsl:text>
	</xsl:template>

	<xsl:template name="Partner">
		<xsl:param name="partner"/>
		<xsl:param name="type"/>
		<xsl:param name="isNetworkNotary" select="'false'"/>
		<!-- RESIDENT -->
		<xsl:if test="$partner/tia:tia_Gegevens/tia:GBA_Ingezetene">
			<xsl:variable name="ingez" select="$partner/tia:tia_Gegevens/tia:GBA_Ingezetene"/>
			<xsl:call-template name="GBA_Ingezetene">
				<xsl:with-param name="ingezetene" select="$ingez"/>
			</xsl:call-template>
		</xsl:if>
		<!-- NON RESIDENT -->
		<xsl:if test="$partner/tia:tia_Gegevens/tia:IMKAD_NietIngezetene">
			<xsl:variable name="nietIngez" select="$partner/tia:tia_Gegevens/tia:IMKAD_NietIngezetene"/>
			<xsl:call-template name="IMKAD_NietIngezetene">
				<xsl:with-param name="nietIngezetene" select="$nietIngez"/>
			</xsl:call-template>
		</xsl:if>
		<!--domestic address-->
		<xsl:if test="$partner/tia:IMKAD_WoonlocatiePersoon/tia:adres/tia:binnenlandsAdres">
			<xsl:text>, wonende te </xsl:text>
			<xsl:variable name="addr" select="$partner/tia:IMKAD_WoonlocatiePersoon/tia:adres/tia:binnenlandsAdres"/>
			<xsl:call-template name="binnenlandsAdres">
				<xsl:with-param name="address" select="$addr"/>
			</xsl:call-template>
		</xsl:if>
		<!--foreign address-->
		<xsl:if test="$partner/tia:IMKAD_WoonlocatiePersoon/tia:adres/tia:buitenlandsAdres">
			<xsl:text>, wonende te </xsl:text>
			<xsl:variable name="addr" select="$partner/tia:IMKAD_WoonlocatiePersoon/tia:adres/tia:buitenlandsAdres"/>
			<xsl:call-template name="buitenlandsAdres">
				<xsl:with-param name="address" select="$addr"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:variable name="sex2">
			<xsl:choose>
				<xsl:when test="$partner/tia:tia_Gegevens/tia:GBA_Ingezetene">
					<xsl:value-of select="$partner/tia:tia_Gegevens/tia:GBA_Ingezetene/tia:geslacht/tia:geslachtsaanduiding"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$partner/tia:tia_Gegevens/tia:IMKAD_NietIngezetene/tia:geslacht"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- Identity document -->
		<xsl:if test="$partner/tia:tia_Legitimatiebewijs">
			<!--<xsl:if test="$bestuurder/tia:tia_Legitimatiebewijs" >-->
			<xsl:variable name="legitim" select="$partner/tia:tia_Legitimatiebewijs"/>
			<xsl:call-template name="Legitimatiebewijs">
				<xsl:with-param name="legitimatie" select="$legitim"/>
				<xsl:with-param name="sex" select="$sex2"/>
				<xsl:with-param name="typeD" select="$type"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="translate($isNetworkNotary,$upper,$lower) != 'true'">
			<xsl:text>, </xsl:text>
			<xsl:value-of select="$partner/tia:tia_BurgerlijkeStaatTekst"/>
		</xsl:if>
	</xsl:template>
	
	<!-- 
		*************************************************************************
		Domestic Address (binnenlandsAdres)
		*************************************************************************
	-->
	<xsl:template name="binnenlandsAdres">
		<xsl:param name="address"/>
		<xsl:value-of select="concat(substring($address/tia:BAG_NummerAanduiding/tia:postcode,0,5),' ',substring($address/tia:BAG_NummerAanduiding/tia:postcode,5))"/>
		<xsl:text> </xsl:text>
		<xsl:value-of select="$address/tia:BAG_Woonplaats/tia:woonplaatsNaam"/>
		<xsl:text>, </xsl:text>
		<xsl:value-of select="$address/tia:BAG_OpenbareRuimte/tia:openbareRuimteNaam"/>
		<xsl:text> </xsl:text>
		<xsl:value-of select="$address/tia:BAG_NummerAanduiding/tia:huisnummer"/>
		<xsl:if test="$address/tia:BAG_NummerAanduiding/tia:huisletter">
			<xsl:if test="string-length($address/tia:BAG_NummerAanduiding/tia:huisletter)!=0">
				<xsl:text> </xsl:text>
				<xsl:value-of select="$address/tia:BAG_NummerAanduiding/tia:huisletter"/>
			</xsl:if>
		</xsl:if>
		<xsl:if test="$address/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging">
			<xsl:if test="string-length($address/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging)!=0">
				<xsl:text> </xsl:text>
				<xsl:value-of select="$address/tia:BAG_NummerAanduiding/tia:huisnummertoevoeging"/>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<!-- 
		*************************************************************************
		Foreign Address (buitenlandsAdres)
		*************************************************************************
	-->
	<xsl:template name="buitenlandsAdres">
		<xsl:param name="address"/>
		<xsl:value-of select="$address/tia:woonplaats"/>
		<xsl:text>, </xsl:text>
		<xsl:value-of select="$address/tia:adres"/>
		<xsl:text>, </xsl:text>
		<xsl:if test="$address/tia:regio">
			<xsl:if test="string-length($address/tia:regio)!=0">
				<xsl:value-of select="$address/tia:regio"/>
				<xsl:text>, </xsl:text>
			</xsl:if>
		</xsl:if>
		<xsl:if test="$address/tia:land">
			<xsl:if test="string-length($address/tia:land)!=0">
				<xsl:value-of select="$address/tia:land"/>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<!-- 
		*************************************************************************
		Postbox Address (postbusAdres)
		*************************************************************************
	-->
    <xsl:template name="postbusAdres">
		<xsl:param name="address"/>
		<xsl:if test="$address/tia:postbusnummer">
			<xsl:if test="string-length($address/tia:postbusnummer) != 0">
                <xsl:value-of select="$address/tia:postbusnummer" />
                <xsl:text>, </xsl:text>
            </xsl:if>
		</xsl:if>
    	<xsl:if test="$address/tia:postcode">
			<xsl:if test="string-length($address/tia:postcode) != 0">
                <xsl:value-of select="$address/tia:postcode" />
                <xsl:text>, </xsl:text>
            </xsl:if>
		</xsl:if>
		<xsl:if test="$address/tia:woonplaatsnaam">
			<xsl:if test="string-length($address/tia:woonplaatsnaam) != 0">
                <xsl:value-of select="$address/tia:woonplaatsnaam" />
            </xsl:if>
		</xsl:if>
    </xsl:template>

	<!-- 
		*************************************************************************
		Identity document (Legitimatiebewijs)
		*************************************************************************
	-->
	<xsl:template name="Legitimatiebewijs">
		<xsl:param name="legitimatie"/>
		<xsl:param name="sex"/>
		<xsl:param name="typeD"/>
		<xsl:choose>
			<xsl:when test="translate($typeD,$upper,$lower) = 'dot'">
				<xsl:text>, zich identificerende met </xsl:text>
			</xsl:when>
			<xsl:when test="translate($typeD,$upper,$lower) = 'dom'">
				<xsl:text>, zich legitimerende met </xsl:text>
			</xsl:when>
		</xsl:choose>
		<xsl:if test="translate($sex,$upper,$lower) = 'man'">
			<xsl:text>zijn </xsl:text>
		</xsl:if>
		<xsl:if test="translate($sex,$upper,$lower) = 'vrouw'">
			<xsl:text>haar </xsl:text>
		</xsl:if>
		<xsl:value-of select="$legitimatie/tia:soort"/>
		<xsl:text>, met kenmerk </xsl:text>
		<xsl:value-of select="$legitimatie/tia:kenmerk"/>
		<xsl:text>, uitgegeven te </xsl:text>
		<xsl:value-of select="$legitimatie/tia:plaatsUitgegeven"/>
		<xsl:if test="$legitimatie/tia:landUitgegeven">
			<xsl:if test="string-length($legitimatie/tia:landUitgegeven)!=0">
				<xsl:text>, </xsl:text>
				<xsl:value-of select="$legitimatie/tia:landUitgegeven"/>
			</xsl:if>
		</xsl:if>
		<xsl:text>, op </xsl:text>
		<xsl:if test="$legitimatie/tia:datumUitgegeven">
			<xsl:if test="string-length(substring(string($legitimatie/tia:datumUitgegeven),0,11))!=0">
				<xsl:value-of select="kef:convertDateToText(substring(string($legitimatie/tia:datumUitgegeven),0,11))"/>
			</xsl:if>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
