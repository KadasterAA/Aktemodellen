<?xml version="1.0" encoding="UTF-8"?>
<!--
*********************************************************
Version: 1.24
*********************************************************
-->
<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format"
	xmlns:xhtml="http://www.w3.org/1999/xhtml"
	xmlns:tia="http://www.kadaster.nl/schemas/KIK/TIA_Algemeen"
	exclude-result-prefixes="xhtml"
	version="1.0">

	<!-- AFSCHRIFT | CONCEPT | MINUUT -->
	<xsl:param name="type-document">AFSCHRIFT</xsl:param>
	<!-- indent-base in points (= 1/72 inch) -->
	<xsl:param name="indent-base">20</xsl:param>
	<!-- use embedded font by default -->
	<xsl:param name="font-family">LiberationSans</xsl:param>
	<!-- font-size in points (= 1/72 inch) -->
	<xsl:param name="font-size">10</xsl:param>
	<!-- tab-width in millimeters -->
	<xsl:param name="indentWidth">7</xsl:param>
	<!-- AA-2941: set fixed col-width for Roman-number (tab-width in millimeters) -->
	<xsl:param name="indentRomanWidth">15</xsl:param>

	<xsl:decimal-format decimal-separator="," grouping-separator="." />

	<xsl:variable name="aflijn-img">
		<xsl:choose>
			<xsl:when test="$type-document = 'MINUUT'">lijn-<xsl:value-of select="$font-size" />pt.jpg</xsl:when>
			<xsl:otherwise>wit.gif</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="upper">ABCDEFGHIJKLMNOPQRSTUVWXYZ</xsl:variable>
	<xsl:variable name="lower">abcdefghijklmnopqrstuvwxyz</xsl:variable>
	<!-- Correction of layout for header, footer and margins. Distances are in millimeters. -->
	<xsl:variable name="headerExtent">20</xsl:variable>
	<xsl:variable name="footerExtent">15</xsl:variable>
	<!-- Variables for specifying margins in mm. Margins are optional; default values guarantee back-ward compatibility. -->
	<xsl:variable name="marginLeftTemp">
		<xsl:call-template name="getMetaData">
			<xsl:with-param name="tag">margin-left</xsl:with-param>
			<xsl:with-param name="default">25</xsl:with-param>
		</xsl:call-template>
	</xsl:variable>
    <xsl:variable name="marginLeft">
        <xsl:value-of select="($marginLeftTemp - 8)" />
    </xsl:variable>
	<xsl:variable name="marginRight">
		<xsl:call-template name="getMetaData">
			<xsl:with-param name="tag">margin-right</xsl:with-param>
			<xsl:with-param name="default">25</xsl:with-param>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="marginTop">
		<xsl:call-template name="getMetaData">
			<xsl:with-param name="tag">margin-top</xsl:with-param>
			<xsl:with-param name="default">25</xsl:with-param>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="marginBottom">
		<xsl:call-template name="getMetaData">
			<xsl:with-param name="tag">margin-bottom</xsl:with-param>
			<xsl:with-param name="default">25</xsl:with-param>
		</xsl:call-template>
	</xsl:variable>

	<!-- main entry -->
	<xsl:template match="/">
		<fo:root font-size="{$font-size}pt" font-family="{$font-family}">
			<fo:layout-master-set>
				<fo:simple-page-master master-name="portrait" page-height="29.7cm" page-width="21cm">
					<!-- layout for the body part -->
					<fo:region-body margin-top="{$marginTop}mm" margin-bottom="{$marginBottom}mm" margin-left="{$marginLeft}mm" margin-right="{$marginRight}mm" />
					<!-- layout for the header and footer part -->
					<fo:region-before extent="{$headerExtent}mm" />
					<fo:region-after extent="{$footerExtent}mm" />
					<!-- layout for the left and right part -->
					<fo:region-start extent="{$marginLeft}mm" />
					<fo:region-end extent="{$marginRight}mm" />
				</fo:simple-page-master>
			</fo:layout-master-set>
			<fo:page-sequence master-reference="portrait">
				<!-- apply the header -->
				<fo:static-content flow-name="xsl-region-before">
					<xsl:call-template name="document-header" />
				</fo:static-content>
				<!-- apply the footer -->
				<fo:static-content flow-name="xsl-region-after">
					<xsl:call-template name="document-footer" />
				</fo:static-content>
				<fo:static-content flow-name="xsl-region-start">
					<fo:block />
				</fo:static-content>
				<fo:static-content flow-name="xsl-region-end">
					<fo:block />
				</fo:static-content>
				<!-- apply the body -->
				<fo:flow flow-name="xsl-region-body">
					<fo:block>
						<xsl:apply-templates select="//xhtml:body" />
					</fo:block>
				</fo:flow>
			</fo:page-sequence>
		</fo:root>
	</xsl:template>

	<xsl:template match="xhtml:a" />

	<!-- reads the content of a <meta> tag -->
	<xsl:template name="getMetaData">
		<xsl:param name="tag" />
		<xsl:param name="default" />
		<xsl:variable name="metaData" select="/xhtml:html/xhtml:head/xhtml:meta[@scheme = 'nl.kadaster.kik'][@name = $tag]" />
		<xsl:choose>
			<xsl:when test="$metaData">
				<xsl:value-of select="$metaData/@content" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$default" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- header -->
	<xsl:template name="document-header">
		<fo:block />
	</xsl:template>

	<!-- footer -->
	<xsl:template name="document-footer">
		<fo:block text-align="end">
			<fo:page-number />
		</fo:block>
	</xsl:template>

	<!-- h1, h2, ... -->
	<xsl:template match="xhtml:*[(starts-with(name(), 'h')) or (starts-with(name(), 'H'))][contains('123456789', substring(name(), 2, 1))]">
		<!-- TODO - apply proper styles -->
		<fo:block>
			<xsl:attribute name="background-image">
				<xsl:value-of select="$aflijn-img" />
			</xsl:attribute>
			<xsl:choose>
				<!-- Do not need bolding in these two cases -->
				<xsl:when test="translate(@class, $upper, $lower) = 'header'">
					<xsl:attribute name="text-decoration">underline</xsl:attribute>
				</xsl:when>
				<xsl:when test="contains(translate(@style, $upper, $lower), 'font-weight') and contains(translate(@style, $upper, $lower), 'normal')" />
				<xsl:otherwise>
					<xsl:attribute name="font-weight">bold</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:apply-templates />
		</fo:block>
	</xsl:template>

	<!-- p -->
	<xsl:template match="xhtml:p | xhtml:div">
		<fo:block background-color="white">
			<fo:block>
				<xsl:choose>
					<xsl:when test="translate(@title, $upper, $lower) = 'without_dashes'">
						<xsl:attribute name="background-image">
							<xsl:text>wit.gif</xsl:text>
						</xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="background-image">
							<xsl:value-of select="$aflijn-img" />
						</xsl:attribute>
					</xsl:otherwise>
				</xsl:choose>				
				<!-- TODO: calculate indent properly -->
				<xsl:if test="@style and contains(translate(@style, $upper, $lower), 'margin-left')">
					<xsl:attribute name="margin-left">
						<xsl:value-of select="concat($indent-base, 'pt')" />
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="center or (contains(translate(@style, $upper, $lower), 'text-align') and contains(translate(@style, $upper, $lower), 'center'))">
					<xsl:attribute name="text-align">
						<xsl:text>center</xsl:text>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates />
			</fo:block>
		</fo:block>
	</xsl:template>

	<!-- br -->
	<xsl:template match="xhtml:br">
		<xsl:choose>
			<xsl:when test="translate(name((following-sibling::xhtml:* | following-sibling::text())[1]), $upper, $lower) = 'br'">
				<fo:block white-space-collapse="false" white-space-treatment="preserve" linefeed-treatment="preserve">
					<xsl:text> </xsl:text>
				</fo:block>
			</xsl:when>
			<xsl:otherwise>
				<fo:block white-space-collapse="false" white-space-treatment="preserve" linefeed-treatment="preserve" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- empty line -->
	<xsl:template match="xhtml:p[normalize-space() = ''] | xhtml:div[normalize-space() = '']">
		<fo:block white-space-collapse="false" white-space-treatment="preserve" linefeed-treatment="preserve">
			<xsl:text> </xsl:text>
		</fo:block>
	</xsl:template>

	<!-- ul -->
	<xsl:template match="xhtml:ul">
		<fo:list-block>
			<xsl:apply-templates select="xhtml:li | xhtml:ul | xhtml:ol" mode="ul" />
		</fo:list-block>
	</xsl:template>
	<xsl:template match="xhtml:*" mode="ul">
		<fo:list-item background-color="white">
			<fo:list-item-label>
				<fo:block>
					<xsl:choose>
						<!-- Nested lists have their own labels -->
						<xsl:when test="translate(name(), $upper, $lower) = 'ol' or translate(name(), $upper, $lower) = 'ul'" />
						<xsl:when test="parent::xhtml:ul[translate(@class, $upper, $lower) = 'arrow']">
							<xsl:text>-</xsl:text>
						</xsl:when>
						<!-- list level 3 -->
						<xsl:when test="translate(@style, $upper, $lower) = 'list-style-type:square' or count(ancestor::xhtml:ol | ancestor::xhtml:ul) >= 3">
							<xsl:text>*</xsl:text>
						</xsl:when>
						<!-- list level 2 -->
						<xsl:when test="translate(@style, $upper, $lower) = 'list-style-type:circle' or count(ancestor::xhtml:ol | ancestor::xhtml:ul) = 2">
							<xsl:attribute name="font-size"><xsl:value-of select="$font-size - 2" />pt</xsl:attribute>
							<xsl:text>o</xsl:text>
						</xsl:when>
						<!-- list level 1 -->
						<xsl:otherwise>
							<!-- 'opsommingsteken' -->
							<xsl:text>&#x2022;</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</fo:block>
			</fo:list-item-label>
			<fo:list-item-body>
				<xsl:variable name="background-image">
					<xsl:choose>
						<xsl:when test="translate(@title, $upper, $lower) = 'without_dashes'">
							<xsl:text>wit.gif</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$aflijn-img" />
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<fo:block margin-left="{$indent-base}pt" background-image="{$background-image}">
					<xsl:apply-templates select="." />
				</fo:block>
			</fo:list-item-body>
		</fo:list-item>
	</xsl:template>

	<!-- ol -->
	<xsl:template match="xhtml:ol">
		<fo:list-block>
			<xsl:apply-templates select="xhtml:li | xhtml:ul | xhtml:ol" mode="ol" />
		</fo:list-block>
	</xsl:template>
	<xsl:template match="xhtml:*" mode="ol">
		<xsl:variable name="start">
			<xsl:choose>
				<xsl:when test="parent::xhtml:ol/@start">
					<xsl:value-of select="parent::xhtml:ol/@start - 1" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<fo:list-item background-color="white">
			<fo:list-item-label>
				<fo:block>
					<xsl:choose>
						<!-- Nested lists have their own labels -->
						<xsl:when test="translate(name(), $upper, $lower) = 'ol' or translate(name(), $upper, $lower) = 'ul'" />
						<!-- numbered list upper-alpha -->
						<xsl:when test="translate(@style, $upper, $lower) = 'list-style-type:upper-alpha'">
							<xsl:number value="$start + position() - count(preceding-sibling::xhtml:ol) - count(preceding-sibling::xhtml:ul)" format="A" />
						</xsl:when>
						<!-- numbered list lower-alpha -->
						<xsl:when test="translate(@style, $upper, $lower) = 'list-style-type:lower-alpha'">
							<xsl:number value="$start + position() - count(preceding-sibling::xhtml:ol) - count(preceding-sibling::xhtml:ul)" format="a" />
						</xsl:when>
						<!-- numbered list upper-roman -->
						<xsl:when test="translate(@style, $upper, $lower) = 'list-style-type:upper-roman'">
							<xsl:number value="$start + position() - count(preceding-sibling::xhtml:ol) - count(preceding-sibling::xhtml:ul)" format="I" />
						</xsl:when>
						<!-- numbered list lower-roman -->
						<xsl:when test="translate(@style, $upper, $lower) = 'list-style-type:lower-roman'">
							<xsl:number value="$start + position() - count(preceding-sibling::xhtml:ol) - count(preceding-sibling::xhtml:ul)" format="i" />
						</xsl:when>
						<!-- numbered list -->
						<xsl:otherwise>
							<xsl:value-of select="$start + position() - count(preceding-sibling::xhtml:ol) - count(preceding-sibling::xhtml:ul)" />
						</xsl:otherwise>
					</xsl:choose>
					<xsl:if test="not(translate(name(), $upper, $lower) = 'ol' or translate(name(), $upper, $lower) = 'ul')">
						<xsl:text>.</xsl:text>
					</xsl:if>
				</fo:block>
			</fo:list-item-label>
			<fo:list-item-body>
				<xsl:variable name="background-image">
					<xsl:choose>
						<xsl:when test="translate(@title, $upper, $lower) = 'without_dashes'">
							<xsl:text>wit.gif</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$aflijn-img" />
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<fo:block margin-left="{$indent-base}pt" background-image="{$background-image}">
					<xsl:apply-templates select="." />
				</fo:block>
			</fo:list-item-body>
		</fo:list-item>
	</xsl:template>

	<xsl:template match="xhtml:font">
		<xsl:variable name="fontSize">
			<xsl:choose>
				<xsl:when test="@size = '1'">9</xsl:when>
				<xsl:when test="@size = '2'">10</xsl:when>
				<xsl:when test="@size = '3'">13</xsl:when>
				<xsl:when test="@size = '4'">16</xsl:when>
				<xsl:when test="@size = '5'">19</xsl:when>
				<xsl:when test="@size = '6'">24</xsl:when>
				<xsl:when test="@size = '7'">32</xsl:when>
				<xsl:otherwise>10</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="backgroundImage">
			<xsl:text>lijn-</xsl:text>
			<xsl:value-of select="$fontSize" />
			<xsl:text>pt.jpg</xsl:text>
		</xsl:variable>
		<fo:block background-image="{$backgroundImage}">
			<fo:inline>
				<xsl:if test="@size">
					<xsl:attribute name="font-size"><xsl:value-of select="$fontSize" />pt</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="child::node()" />
			</fo:inline>
		</fo:block>
	</xsl:template>

	<!-- any text -->
	<xsl:template match="text()">
		<!--
			WordML style sheet does not handle 3rd level list nesting (necessary for person pair data).
			This check is inserted in order to avoid text which is non-breaking space only.
			Must be corrected with appropriate list handling by WordML style sheet,
			as part of issue ORKADKIK-428.
		-->
		<xsl:if test=". != '&#xFEFF;' and (
				normalize-space(.) != '' or (normalize-space(.) = '' and
					(translate(name(preceding::xhtml:*[1]), $upper, $lower) = 'span' or translate(name(preceding::xhtml:*[1]), $upper, $lower) = 'font' or translate(name(preceding::xhtml:*[1]), $upper, $lower) = 'u' or translate(name(preceding::xhtml:*[1]), $upper, $lower) = 'i'
						or translate(name(preceding::xhtml:*[1]), $upper, $lower) = 'em' or translate(name(preceding::xhtml:*[1]), $upper, $lower) = 'b' or translate(name(preceding::xhtml:*[1]), $upper, $lower) = 'strong') and
					(translate(name(following::xhtml:*[1]), $upper, $lower) = 'span' or translate(name(following::xhtml:*[1]), $upper, $lower) = 'font' or translate(name(following::xhtml:*[1]), $upper, $lower) = 'u' or translate(name(following::xhtml:*[1]), $upper, $lower) = 'i'
						or translate(name(following::xhtml:*[1]), $upper, $lower) = 'em' or translate(name(following::xhtml:*[1]), $upper, $lower) = 'b' or translate(name(following::xhtml:*[1]), $upper, $lower) = 'strong')))">
			<fo:inline background-color="white">
				<!-- strong (bold) -->
				<xsl:if test="ancestor::xhtml:strong or
						ancestor::xhtml:b or
						ancestor::xhtml:*[contains(translate(@style, $upper, $lower), 'font-weight:') and contains(translate(@style, $upper, $lower), 'bold') and not(descendant::xhtml:*[contains(translate(@style, $upper, $lower), 'font-weight:') and not(contains(translate(@style, $upper, $lower), 'bold'))])]">
					<xsl:attribute name="font-weight">bold</xsl:attribute>
				</xsl:if>
				<!-- em (italics) -->
				<xsl:if test="ancestor::xhtml:em or
						ancestor::xhtml:i or
						ancestor::xhtml:*[contains(translate(@style, $upper, $lower), 'font-style:') and contains(translate(@style, $upper, $lower), 'italic') and not(descendant::xhtml:*[contains(translate(@style, $upper, $lower), 'font-style:') and not(contains(translate(@style, $upper, $lower), 'italic'))])]">
					<xsl:attribute name="font-style">italic</xsl:attribute>
				</xsl:if>
				<!-- underline -->
				<xsl:if test="ancestor::xhtml:*[contains(translate(@style, $upper, $lower), 'text-decoration:') and contains(translate(@style, $upper, $lower), 'underline') and not(descendant::xhtml:*[contains(translate(@style, $upper, $lower), 'text-decoration:') and not(contains(translate(@style, $upper, $lower), 'underline'))])]
						or ancestor::xhtml:*[translate(name(), $upper, $lower) = 'u' and not(descendant::xhtml:*[contains(translate(@style, $upper, $lower), 'text-decoration:') and not(contains(translate(@style, $upper, $lower), 'underline'))])]">
					<xsl:attribute name="text-decoration">underline</xsl:attribute>
				</xsl:if>
				<xsl:if test="ancestor::xhtml:center or ancestor::xhtml:*[contains(translate(@style, $upper, $lower), 'text-align') and contains(translate(@style, $upper, $lower), 'center')]">
					<xsl:attribute name="text-align">
						<xsl:text>center</xsl:text>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="." />
			</fo:inline>
		</xsl:if>
	</xsl:template>
	
	<!-- XHTML table -->
	<xsl:template match="xhtml:table">
		<xsl:variable name="numberOfCellsInLongestRow">
			<xsl:call-template name="getNumberOfCellsInLongestRow">
				<xsl:with-param name="row" select="xhtml:tbody/xhtml:tr[1]" />
				<xsl:with-param name="numberOfRows" select="count(xhtml:tbody/xhtml:tr)" />
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="haveAdditionalColumn">
			<xsl:choose>
				<xsl:when test="xhtml:tbody/xhtml:tr[count(xhtml:td) = $numberOfCellsInLongestRow][1]/xhtml:td[@colspan]">
					<xsl:text>true</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>false</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<fo:table table-layout="fixed" width="100%">
			<xsl:for-each select="xhtml:tbody/xhtml:tr[count(xhtml:td) = $numberOfCellsInLongestRow][1]/xhtml:td">
				<fo:table-column>
					<!--
						Page and table dimensions:
							page width = 210mm
							tab width = ${indentWidth}mm
							left margin = ${marginLeft}mm
							right margin = ${marginRight}mm
							
						So the column-width is ${indentWidth}mm if it's a tab, 
						or else 
							(210 - $marginLeft - $marginRight - (position() + number(substring-after(@class, 'level')) - 1) * $indentWidth)mm if there is no additional column and there is nesting level (given in value of attribute @class), 
							(210 - $marginLeft - $marginRight - ${numTabs} * $indentWidth)mm if there is no additional column and no nesting level, 
							or ${indentWidth}mm if there is an additional column.
						Note that ${numTabs} = position() - 1.
					-->
					<xsl:attribute name="column-width">
						<xsl:choose>
							<xsl:when test="translate(@class, $upper, $lower) = 'number'">
								<xsl:value-of select="$indentWidth" />
							</xsl:when>
                            <!-- AA-2941: set fixed col-width for Roman-number (tab-width in millimeters) -->
							<xsl:when test="translate(@class, $upper, $lower) = 'roman'">
								<xsl:value-of select="$indentRomanWidth" />
							</xsl:when>
							<xsl:otherwise>
								<xsl:choose>
									<xsl:when test="$haveAdditionalColumn = 'false'">
										<xsl:choose>
											<xsl:when test="starts-with(translate(@class, $upper, $lower), 'level')">
												<xsl:value-of select="210 - $marginLeftTemp - $marginRight - (position() + number(substring-after(@class, 'level'))) * $indentWidth" />
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="210 - $marginLeftTemp - $marginRight - (position() - 1) * $indentWidth" />
											</xsl:otherwise>
										</xsl:choose>										
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="$indentWidth" />
									</xsl:otherwise>
								</xsl:choose>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:text>mm</xsl:text>
					</xsl:attribute>
				</fo:table-column>
			</xsl:for-each>
			<!-- add additional fo:table-column if there is @colspan attribute at last element in longest row -->
			<xsl:if test="$haveAdditionalColumn = 'true'">
				<fo:table-column>
					<!--
						Page and table dimensions:
							page width = 210mm
							tab width = ${indentWidth}mm
							left margin = ${marginLeft}mm
							right margin = ${marginRight}mm
						So the column-width is (210 - $marginLeft - $marginRight - $numberOfCellsInLongestRow * $indentWidth)mm.
					-->
					<xsl:attribute name="column-width">
						<xsl:value-of select="210 - $marginLeftTemp - $marginRight - $numberOfCellsInLongestRow * $indentWidth" />
						<xsl:text>mm</xsl:text>
					</xsl:attribute>
				</fo:table-column>
			</xsl:if>
			<xsl:apply-templates select="*" />
		</fo:table>
	</xsl:template>

	<xsl:template match="xhtml:tbody">
		<fo:table-body>
			<xsl:apply-templates select="*" />
		</fo:table-body>
	</xsl:template>

	<xsl:template match="xhtml:tr">
		<fo:table-row>
			<xsl:apply-templates select="*" />
		</fo:table-row>
	</xsl:template>

	<xsl:template match="xhtml:td">
		<fo:table-cell>
			<!-- number -->
			<xsl:if test="translate(@class, $upper, $lower) = 'number'">
				<xsl:attribute name="width">
					<xsl:value-of select="$indentWidth" />
					<xsl:text>mm</xsl:text>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="translate(@class, $upper, $lower) = 'roman'">
				<xsl:attribute name="width">
					<xsl:value-of select="$indentRomanWidth" />
					<xsl:text>mm</xsl:text>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="not(@class)">
				<xsl:attribute name="background-image">
					<xsl:value-of select="$aflijn-img" />
				</xsl:attribute>
			</xsl:if>
			<!-- colspan -->
			<xsl:if test="@colspan">
				<xsl:attribute name="number-columns-spanned">
					<xsl:number value="@colspan" />
				</xsl:attribute>
			</xsl:if>
			<fo:block>
				<xsl:apply-templates select="* | text()" />
			</fo:block>
		</fo:table-cell>
	</xsl:template>

	<xsl:template name="getNumberOfCellsInLongestRow">
		<xsl:param name="numberOfCellsInLongestRow" select="'0'" />
		<xsl:param name="rowIndex" select="'1'" />
		<xsl:param name="row" select="self::node()[false()]" />
		<xsl:param name="numberOfRows" select="'0'" />

		<xsl:choose>
			<xsl:when test="$rowIndex &lt;= $numberOfRows">
				<xsl:call-template name="getNumberOfCellsInLongestRow">
					<xsl:with-param name="rowIndex" select="$rowIndex + 1" />
					<xsl:with-param name="row" select="$row/following-sibling::xhtml:tr[1]" />
					<xsl:with-param name="numberOfCellsInLongestRow">
						<xsl:choose>
							<xsl:when test="count($row/xhtml:td) > $numberOfCellsInLongestRow">
								<xsl:value-of select="count($row/xhtml:td)" />
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="$numberOfCellsInLongestRow" />
							</xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
					<xsl:with-param name="numberOfRows" select="$numberOfRows" />
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$numberOfCellsInLongestRow" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>
