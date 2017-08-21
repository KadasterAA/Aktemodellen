<?xml version="1.0" encoding="UTF-8"?>
<!--
*********************************************************
Version: 1.18
*********************************************************
-->
<xsl:stylesheet
	xmlns:xhtml="http://www.w3.org/1999/xhtml"
	xmlns:w="http://schemas.microsoft.com/office/word/2003/wordml"
	xmlns:wx="http://schemas.microsoft.com/office/word/2003/auxHint"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:exsl="http://exslt.org/common"
	exclude-result-prefixes="xhtml"
	version="1.0">

	<!-- Default indentation in 'twips' (=1/20 point = 1/1440 inch). -->
	<xsl:param name="indent-base">360</xsl:param>
	<xsl:param name="style-template">style-template.word.xml</xsl:param>

	<!-- constants -->
	<xsl:variable name="upper">ABCDEFGHIJKLMNOPQRSTUVWXYZ</xsl:variable>
	<xsl:variable name="lower">abcdefghijklmnopqrstuvwxyz</xsl:variable>
	<xsl:variable name="number">0123456789</xsl:variable>
	<xsl:variable name="styles" select="document($style-template)//w:styles" />
	<xsl:variable name="part2_root_div_title" select="'part2'" />
	<xsl:variable name="tableWidth" select="7675" />

	<xsl:attribute-set name="font">
		<xsl:attribute name="fname">Arial</xsl:attribute>
		<xsl:attribute name="size">14px</xsl:attribute>
		<xsl:attribute name="color">red</xsl:attribute>
	</xsl:attribute-set>

	<xsl:include href="xhtml_wordml-lists-1.05.xsl" />

	<xsl:template match="/">
		<xsl:processing-instruction name="mso-application">progid="Word.Document"</xsl:processing-instruction>
		<w:wordDocument>
			<xsl:attribute name="w:macrosPresent">no</xsl:attribute>
			<xsl:attribute name="w:embeddedObjPresent">no</xsl:attribute>
			<xsl:attribute name="w:ocxPresent">no</xsl:attribute>
			<xsl:attribute name="xml:space">preserve</xsl:attribute>
			<!-- Define list styles -->
			<xsl:call-template name="createListDefs" />
			<!-- Define layout styles (should be available in Word). -->
			<xsl:call-template name="createStyleDefs" />
			<!-- Document properties - view layout and zoom level -->
			<w:docPr>
				<w:view w:val="print" />
				<w:zoom w:percent="100" />
			</w:docPr>
			<w:body>
				<!-- Footer with page numbers -->
				<w:sectPr>
					<w:ftr w:type="odd">
						<w:p>
							<w:pPr>
								<w:pStyle w:val="Footer" />
								<w:jc w:val="right" />
							</w:pPr>
							<w:fldSimple w:instr=" PAGE   \* MERGEFORMAT ">
								<w:r>
									<w:rPr>
										<w:noProof />
									</w:rPr>
									<w:t>1</w:t>
								</w:r>
							</w:fldSimple>
						</w:p>
					</w:ftr>
					<w:pgSz w:w="11906" w:h="16838" />
					<w:pgMar w:top="3402" w:right="1418" w:bottom="1418" w:left="2835" w:header="709" w:footer="709" w:gutter="0" />
					<w:cols w:space="708" />
					<w:docGrid w:line-pitch="360" />
				</w:sectPr>
				<!-- process the content -->
				<wx:sect>
					<wx:sub-section>
						<wx:sub-section>
							<xsl:apply-templates select="//xhtml:body" mode="do-content" />
							<w:sectPr>
								<w:pgSz w:w="11906" w:h="16838" />
								<w:pgMar w:top="3402" w:right="1418" w:bottom="1418" w:left="2835" w:header="709" w:footer="709" w:gutter="0" />
								<w:cols w:space="708" />
								<w:docGrid w:line-pitch="360" />
							</w:sectPr>
						</wx:sub-section>
					</wx:sub-section>
				</wx:sect>
			</w:body>
		</w:wordDocument>
	</xsl:template>

	<!-- defines layout styles -->
	<xsl:template name="createStyleDefs">
		<xsl:choose>
			<xsl:when test="$styles">
				<xsl:copy-of select="$styles" />
			</xsl:when>
			<xsl:otherwise>
				<w:styles>
					<xsl:call-template name="createHeadingStyles" />
				</w:styles>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- creates a style per heading type (h1, h2, ...) -->
	<xsl:template name="createHeadingStyles">
		<xsl:param name="index">1</xsl:param>
		<xsl:if test="//xhtml:*[translate(local-name(), $upper, $lower) = concat('h', $index)]">
			<w:style w:type="paragraph" w:styleId="Heading{$index}" w:tentative="on">
				<w:name w:val="heading {$index}" />
			</w:style>
			<!-- use recursion to add succeeding styles -->
			<xsl:call-template name="createHeadingStyles">
				<xsl:with-param name="index" select="$index + 1" />
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<xsl:template match="xhtml:a" />

	<xsl:template match="xhtml:h1 | xhtml:h2 | xhtml:h3 | xhtml:h4 | xhtml:h5 | xhtml:h6 | xhtml:p | xhtml:div | xhtml:span | xhtml:font" mode="do-content">
		<xsl:call-template name="createP" />
	</xsl:template>

	<xsl:template match="xhtml:p[xhtml:table]" mode="do-content">
		<xsl:apply-templates mode="in-table" />
	</xsl:template>

	<!-- empty line -->
	<xsl:template match="xhtml:p[normalize-space() = ''] | xhtml:div[normalize-space() = '']" mode="do-content">
		<w:p />
	</xsl:template>

	<!-- list item with or without nested lists -->
	<xsl:template match="xhtml:li" mode="do-content">
		<xsl:call-template name="processListItemWithNestedList" />
	</xsl:template>

	<xsl:template name="processListItemWithNestedList">
		<xsl:param name="startPosition">1</xsl:param>
		<xsl:variable name="nestedListPosition">
			<xsl:call-template name="getNestedListPosition">
				<xsl:with-param name="nestedListPosition" select="$startPosition" />
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="nonNestedListPosition">
			<xsl:call-template name="getNonNestedListPosition">
				<xsl:with-param name="nonNestedListPosition" select="$startPosition" />
			</xsl:call-template>
		</xsl:variable>
		<xsl:if test="$nonNestedListPosition > 0">
			<xsl:call-template name="createP">
				<xsl:with-param name="beginPosition" select="$nonNestedListPosition" />
				<xsl:with-param name="endPosition" select="$nestedListPosition" />
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="$nestedListPosition > 0">
			<xsl:apply-templates select="(* | text())[position() = $nestedListPosition]" mode="inP" />
			<!-- continue with the remaining list item nodes -->
			<xsl:call-template name="processListItemWithNestedList">
				<xsl:with-param name="startPosition" select="$nestedListPosition + 1" />
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<xsl:template name="getNestedListPosition">
		<xsl:param name="nestedListPosition">1</xsl:param>
		<xsl:variable name="testNodes" select="* | text()" />
		<xsl:choose>
			<xsl:when test="$nestedListPosition > count($testNodes)">0</xsl:when>
			<xsl:when test="$testNodes[position() = $nestedListPosition]/descendant::xhtml:li">
				<xsl:value-of select="$nestedListPosition" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="getNestedListPosition">
					<xsl:with-param name="nestedListPosition" select="$nestedListPosition + 1" />
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="getNonNestedListPosition">
		<xsl:param name="nonNestedListPosition">1</xsl:param>
		<xsl:variable name="testNodes" select="* | text()" />
		<xsl:choose>
			<xsl:when test="$nonNestedListPosition > count($testNodes)">0</xsl:when>
			<xsl:when test="not($testNodes[position() = $nonNestedListPosition]/descendant::xhtml:li)">
				<xsl:value-of select="$nonNestedListPosition" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="getNonNestedListPosition">
					<xsl:with-param name="nonNestedListPosition" select="$nonNestedListPosition + 1" />
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="createP">
		<xsl:param name="beginPosition">0</xsl:param>
		<xsl:param name="endPosition">0</xsl:param>
		<xsl:choose>
			<xsl:when test="($beginPosition > 0) and ($endPosition = 0)">
				<xsl:call-template name="doCreateP">
					<xsl:with-param name="contentNodes" select="(* | text())
							[position() >= $beginPosition and
							(translate(local-name(), $upper, $lower) = 'br' or normalize-space() != '' or . = ' ') and
							translate(local-name(), $upper, $lower) != 'a']" />
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="($beginPosition > 0) and ($endPosition > $beginPosition)">
				<xsl:call-template name="doCreateP">
					<xsl:with-param name="contentNodes" select="(* | text())
							[position() >= $beginPosition and
							position() &lt; $endPosition and
							(translate(local-name(), $upper, $lower) = 'br' or normalize-space() != '' or . = ' ') and
							translate(local-name(), $upper, $lower) != 'a']" />
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="doCreateP">
					<xsl:with-param name="contentNodes" select="(* | text())
							[(translate(local-name(), $upper, $lower) = 'br' or normalize-space() != '' or . = ' ') and
							translate(local-name(), $upper, $lower) != 'a']" />
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="doCreateP">
		<xsl:param name="contentNodes" />
		<xsl:if test="$contentNodes">
			<xsl:variable name="heading-level">
				<xsl:choose>
					<xsl:when test="$contentNodes/ancestor-or-self::xhtml:*[starts-with(local-name(), 'h')
							and contains($number, substring-after(translate(local-name(), $upper, $lower), 'h'))
							and not(contains(@style, 'font-weight') and contains(translate(@style, $upper, $lower), 'normal'))
							and not(contains(@style, 'text-decoration') and contains(translate(@style, $upper, $lower), 'none'))]">
						<xsl:value-of select="substring-after(translate(local-name(), $upper, $lower), 'h')" />
					</xsl:when>
					<xsl:otherwise>0</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="list-level" select="count($contentNodes/ancestor-or-self::xhtml:ol) + count($contentNodes/ancestor-or-self::xhtml:ul)" />
			<!-- TODO - determine indent-level properly -->
			<xsl:variable name="indent-level" select="count($contentNodes/ancestor-or-self::xhtml:*[contains(translate(@style, $upper, $lower), 'margin-left')])" />
			<xsl:variable name="center-level" select="count($contentNodes/ancestor-or-self::xhtml:center)
					+ count($contentNodes/ancestor-or-self::xhtml:*[contains(translate(@style, $upper, $lower), 'text-align') and contains(translate(@style, $upper, $lower), 'center')])" />
			<w:p>
				<xsl:if test="$heading-level + $list-level + $indent-level + $center-level > 0">
					<xsl:variable name="listDefId">
						<xsl:call-template name="getListDefId">
							<xsl:with-param name="listItemNode" select="$contentNodes[1]" />
						</xsl:call-template>
					</xsl:variable>
					<w:pPr>
						<!-- apply style -->
						<xsl:variable name="styleName">
							<xsl:choose>
								<xsl:when test="$heading-level > 0">
									<xsl:value-of select="concat('heading ', $heading-level)" />
								</xsl:when>
								<xsl:otherwise>Normal</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<w:pStyle w:val="{$styles/w:style[translate(w:name/@w:val, $upper, $lower) = translate($styleName, $upper, $lower)]/@w:styleId}" />
						<!-- list style -->
						<xsl:if test="$listDefId != 0">
							<xsl:variable name="ilvl">
								<xsl:choose>
									<xsl:when test="$listDefId >= 0">
										<xsl:value-of select="count($contentNodes/ancestor::xhtml:ol) - 1" />
									</xsl:when>
									<xsl:otherwise>0</xsl:otherwise>
								</xsl:choose>
							</xsl:variable>
							<w:listPr>
								<w:ilvl w:val="{$ilvl}" />
								<w:ilfo w:val="{$listDefId}" />
							</w:listPr>
						</xsl:if>
						<!-- indentation -->
						<xsl:if test="$indent-level + $list-level > 0">
							<xsl:variable name="actual-indent" select="$indent-base * ($indent-level + $list-level)" />
							<w:tabs>
								<w:tab w:val="list" w:pos="{$actual-indent}" />
							</w:tabs>
							<xsl:choose>
								<xsl:when test="$listDefId != 0">
									<w:ind w:left="{$actual-indent}" w:hanging="{$indent-base}" />
								</xsl:when>
								<xsl:otherwise>
									<w:ind w:left="{$actual-indent}" />
								</xsl:otherwise>
							</xsl:choose>
						</xsl:if>
						<xsl:if test="$center-level > 0">
							<w:jc w:val="center" />
						</xsl:if>
					</w:pPr>
				</xsl:if>
				<xsl:apply-templates select="$contentNodes" mode="inP" />
			</w:p>
		</xsl:if>
	</xsl:template>

	<xsl:template match="xhtml:br" mode="inP">
		<xsl:if test="not(local-name(following-sibling::*[1]) = 'ol' or local-name(following-sibling::*[1]) = 'ul')">
			<w:br />
		</xsl:if>
	</xsl:template>

	<xsl:template match="xhtml:ol" mode="inP">
		<xsl:apply-templates select="*" mode="do-content" />
	</xsl:template>

	<xsl:template match="xhtml:ul" mode="inP">
		<xsl:apply-templates select="*" mode="do-content" />
	</xsl:template>

	<xsl:template match="xhtml:p[normalize-space() = '']" mode="inP">
		<w:br />
		<w:br />
	</xsl:template>

	<xsl:template match="xhtml:em | xhtml:strong | xhtml:span" mode="inP">
		<xsl:apply-templates mode="inP" />
		<xsl:choose>
			<xsl:when test="following-sibling::text()" />
			<xsl:when test="((following-sibling::xhtml:br)
					or ((following-sibling::xhtml:p) and (normalize-space(following-sibling::xhtml:p) = ''))
					or ((following-sibling::xhtml:div) and (normalize-space(following-sibling::xhtml:div) = '')))">
				<w:br />
				<w:br />
			</xsl:when>
			<xsl:when test="following-sibling::xhtml:p | following-sibling::xhtml:div">
				<w:br />
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="text()[normalize-space()]" mode="inP">
		<xsl:if test="not(parent::xhtml:a)">
			<xsl:variable name="strong-level" select="count(ancestor::xhtml:strong) +
					count(ancestor::xhtml:b) +
					count(ancestor::xhtml:*[contains(translate(@style, $upper, $lower), 'font-weight:')
						and contains(translate(@style, $upper, $lower), 'bold')
						and not(descendant::xhtml:*[contains(translate(@style, $upper, $lower), 'font-weight:')
						and not(contains(translate(@style, $upper, $lower), 'bold'))])
					])" />
			<xsl:variable name="em-level" select="count(ancestor::xhtml:em) +
					count(ancestor::xhtml:i) +
					count(ancestor::xhtml:*[contains(translate(@style, $upper, $lower), 'font-style:')
						and contains(translate(@style, $upper, $lower), 'italic')
						and not(descendant::xhtml:*[contains(translate(@style, $upper, $lower), 'font-style:')
						and not(contains(translate(@style, $upper, $lower), 'italic'))])
					])" />
			<xsl:variable name="u-level" select="count(ancestor::xhtml:*[contains(translate(@style, $upper, $lower), 'text-decoration:')
						and contains(translate(@style, $upper, $lower), 'underline')
						and not(descendant::xhtml:*[contains(translate(@style, $upper, $lower), 'text-decoration:')
						and not(contains(translate(@style, $upper, $lower), 'underline'))])
					]) +
					count(ancestor::xhtml:*[translate(local-name(), $upper, $lower) = 'u'
						and not(descendant::xhtml:*[contains(translate(@style, $upper, $lower), 'text-decoration:')
						and not(contains(translate(@style, $upper, $lower), 'underline'))])
					])" />
			<xsl:variable name="font-size" select="ancestor::xhtml:font/@size" />
			<xsl:variable name="center-level" select="count(ancestor-or-self::xhtml:center)
					+ count(ancestor-or-self::xhtml:*[contains(translate(@style, $upper, $lower), 'text-align') and contains(translate(@style, $upper, $lower), 'center')])" />

			<w:r>
				<!-- style -->
				<xsl:if test="($strong-level > 0) or ($em-level > 0) or ($u-level > 0) or ($font-size != '') or ($center-level > 0)">
					<w:rPr>
						<!-- strong -->
						<xsl:if test="$strong-level > 0">
							<w:b />
						</xsl:if>
						<!-- emphasized -->
						<xsl:if test="$em-level > 0">
							<w:i />
						</xsl:if>
						<!-- underlined -->
						<xsl:if test="$u-level > 0">
							<w:u w:val="single" />
						</xsl:if>
						<xsl:variable name="sizeOfFont">
							<xsl:choose>
								<xsl:when test="$font-size = '1'">9</xsl:when>
								<xsl:when test="$font-size = '2'">10</xsl:when>
								<xsl:when test="$font-size = '3'">13</xsl:when>
								<xsl:when test="$font-size = '4'">16</xsl:when>
								<xsl:when test="$font-size = '5'">19</xsl:when>
								<xsl:when test="$font-size = '6'">24</xsl:when>
								<xsl:when test="$font-size = '7'">32</xsl:when>
							</xsl:choose>
						</xsl:variable>
						<!-- font-size: the unit of the w:sz / w:sz-cs is half-points -->
						<xsl:if test="$sizeOfFont != ''">
							<w:sz-cs w:val="{$sizeOfFont * 2}" />
							<w:sz w:val="{$sizeOfFont * 2}" />
						</xsl:if>
						<xsl:if test="$center-level > 0">
							<w:jc w:val="center" />
						</xsl:if>

					</w:rPr>
				</xsl:if>
				<w:t>
					<xsl:choose>
						<!-- strip spaces unless there is sibling text with <strong> or other inline styling -->
						<xsl:when test="../xhtml:*[translate(local-name(), $upper, $lower) = 'strong' or translate(local-name(), $upper, $lower) = 'em' or translate(local-name(), $upper, $lower) = 'b' or translate(local-name(), $upper, $lower) = 'i' or translate(local-name(), $upper, $lower) = 'u'
								or (contains(translate(@style, $upper, $lower), 'text-decoration:') and contains(translate(@style, $upper, $lower), 'underline'))
								or (contains(translate(@style, $upper, $lower), 'font-style:') and contains(translate(@style, $upper, $lower), 'italic'))
								or (contains(translate(@style, $upper, $lower), 'font-weight:') and contains(translate(@style, $upper, $lower), 'bold'))]
								or ($strong-level > 0) or ($em-level > 0) or ($u-level > 0)">
							<xsl:value-of select="." />
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="normalize-space(.)" />
						</xsl:otherwise>
					</xsl:choose>
				</w:t>
			</w:r>
		</xsl:if>
	</xsl:template>

	<!-- XHTML table -->
	<xsl:template match="xhtml:table" mode="do-content">
		<w:tbl>
			<w:tblPr>
				<w:tblW w:w="{$tableWidth}" w:type="dxa" />
			</w:tblPr>
			<xsl:apply-templates select="*" mode="do-content" />
		</w:tbl>
	</xsl:template>

	<!-- XHTML table tbody -->
	<xsl:template match="xhtml:tbody" mode="do-content">
		<xsl:apply-templates select="*" mode="do-content" />
	</xsl:template>

	<!-- XHTML table tr -->
	<xsl:template match="xhtml:tr" mode="do-content">
		<w:tr>
			<xsl:apply-templates select="*" mode="do-content" />
		</w:tr>
	</xsl:template>

	<!-- XHTML table td -->
	<xsl:template match="xhtml:td" mode="do-content">
		<w:tc>
			<w:tcPr>
				<!-- number -->
				<xsl:choose>
					<xsl:when test="translate(@class, $upper, $lower) = 'number'">
						<w:tcW w:w="{$indent-base}" w:type="dxa" />
					</xsl:when>
					<xsl:when test="starts-with(translate(@class, $upper, $lower), 'level')">
						<w:tcW w:w="{$tableWidth - (count(preceding-sibling::xhtml:td) + number(substring-after(@class, 'level'))) * $indent-base}" w:type="dxa" />
					</xsl:when>
					<xsl:otherwise>
						<w:tcW w:w="{$tableWidth - (count(preceding-sibling::xhtml:td) * $indent-base)}" w:type="dxa" />
					</xsl:otherwise>
				</xsl:choose>
				<!-- colspan -->
				<xsl:if test="@colspan">
					<w:gridSpan w:val="{@colspan}" />
				</xsl:if>
			</w:tcPr>
			<xsl:choose>
				<!-- empty content -->
				<xsl:when test="normalize-space() = ''">
					<w:p />
				</xsl:when>
				<!-- nested table -->
				<xsl:when test="xhtml:table">
					<xsl:apply-templates mode="in-table" />
					<w:p />
				</xsl:when>
				<!-- nested list -->
				<xsl:when test="xhtml:ol or xhtml:ul">
					<xsl:call-template name="processListItemWithNestedList" />
				</xsl:when>
				<!-- other -->
				<xsl:otherwise>
					<xsl:call-template name="createP" />
				</xsl:otherwise>
			</xsl:choose>
		</w:tc>
	</xsl:template>

	<xsl:template match="xhtml:table" mode="in-table">
		<w:tbl>
			<w:tblPr>
				<w:tblW w:w="5000" w:type="pct" />
			</w:tblPr>
			<xsl:apply-templates select="*" mode="do-content" />
		</w:tbl>
	</xsl:template>

	<xsl:template match="text()[normalize-space()]" mode="in-table">
		<w:p>
			<xsl:apply-templates select="." mode="inP" />
		</w:p>
	</xsl:template>

</xsl:stylesheet>
