<?xml version="1.0" encoding="UTF-8"?>
<!--
*********************************************************
Stylesheet: generiek.xsl
Version: 1.08
*********************************************************
Description:
Common style sheet.

Params: type-document - The type of generated document, can be AFSCHRIFT, CONCEPT or MINUUT. Default is CONCEPT.
		css-url - The URL to CSS for XHTML presentation. Default value is kadaster.css.

Public:
(name) amountText
(name) amountNumber
(name) percentText
(name) percentNumber
(name) indent

Private:
(name) round
(name) addMetaData
(name) addMetaDataFromOptionalTextChoice
-->
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
	xmlns:tia="http://www.kadaster.nl/schemas/KIK/TIA_Algemeen"
	xmlns:gc="http://docs.oasis-open.org/codelist/ns/genericode/1.0/"
	xmlns:java="http://xml.apache.org/xalan/java"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	exclude-result-prefixes="tia gc java xsl" 
	version="1.0">

	<!-- Style sheet parameters -->
	<xsl:param name="type-document" select="'CONCEPT'"/>
	<xsl:param name="css-url" select="'kadaster.css'"/>

	<!-- Output settings -->
	<xsl:output method="xml" encoding="UTF-8" />
	<xsl:decimal-format decimal-separator="," grouping-separator="."/>

	<!-- Common global variables -->
	<xsl:variable name="upper" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
	<xsl:variable name="lower" select="'abcdefghijklmnopqrstuvwxyz'"/>
	<xsl:variable name="currencies" select="document('vreemde-valuta-hypotheken-actueel.xml')/gc:CodeList/SimpleCodeList/Row" />

	<!--
	*********************************************************
	Root template
	*********************************************************
	Public: yes

	Identity transform: no

	Description: Root template.

	Input: root node

	Output: XHTML structure

	Calls:
	(name) addMetaData
	(mode) do-deed

	Called by:
	XSLT Processor
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="/">
		<html>
			<head>
				<xsl:choose>
					<xsl:when test="normalize-space($documentTitle) != ''">
						<title><xsl:value-of select="$documentTitle"/></title>
					</xsl:when>
					<xsl:otherwise>
						<title>&#160;</title>
					</xsl:otherwise>
				</xsl:choose>
				<meta http-equiv="Content-Type" content="text/html;charset=UTF-8"/>
				<meta http-equiv="PRAGMA" content="NO-CACHE"/>
				<meta http-equiv="CACHE-CONTROL" content="NO-CACHE"/>
				<xsl:call-template name="addMetaData"/>
				<xsl:if test="$css-url != ''">
					<link rel="stylesheet" type="text/css" href="{$css-url}"/>
				</xsl:if>
			</head>
			<body>
				<xsl:apply-templates select="tia:Bericht_TIA_Stuk" mode="do-deed"/>
			</body>
		</html>
	</xsl:template>

	<!--
	*********************************************************
	Name: amountText
	*********************************************************
	Public: yes

	Discription: Prints amount in text, taking currency into account.

	Params: amount - The amount to print.
			valuta - The currency.

	Output: text

	Calls:
	(name) round

	Called by:
	(mode) do-deed
	-->

	<!--
	**** named template ********************************************************************************
	-->
	<xsl:template name="amountText">
		<xsl:param name="amount" />
		<xsl:param name="valuta" />
		<xsl:variable name="roundedAmount">
			<xsl:call-template name="round">
				<xsl:with-param name="amount" select="$amount"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="amountBeforePoint">
			<xsl:choose>
				<xsl:when test="contains($roundedAmount, '.')">
					<xsl:value-of select="substring-before($roundedAmount, '.')" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$roundedAmount" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="amountAfterPoint">
			<xsl:choose>
				<xsl:when test="$roundedAmount = ''">
					<xsl:value-of select="''" />
				</xsl:when>
				<xsl:when test="not(contains($roundedAmount, '.'))">
					<xsl:value-of select="'0'" />
				</xsl:when>
				<xsl:when test="string-length(substring-after($roundedAmount, '.')) &gt; 2">
					<xsl:value-of select="substring(substring-after($roundedAmount, '.'), 1, 2)" />
				</xsl:when>
				<xsl:when test="string-length(substring-after($roundedAmount, '.')) &lt; 2">
					<xsl:value-of select="concat(substring-after($roundedAmount, '.'), '0')" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="substring-after($roundedAmount, '.')" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:if test="$amountBeforePoint != ''">
			<xsl:value-of select="java:nl.kadaster.kpk.server.service.impl.transformer.XSLTUtil.numberToDutch($amountBeforePoint)" />
		</xsl:if>
		<xsl:text> </xsl:text>
		<xsl:value-of select="translate($valuta, $upper, $lower)"/>
		<xsl:if test="$amountAfterPoint != '' and $amountAfterPoint != '0' and $amountAfterPoint != '00'">
			<xsl:text> en </xsl:text>
			<xsl:value-of select="java:nl.kadaster.kpk.server.service.impl.transformer.XSLTUtil.numberToDutch($amountAfterPoint)" />
			<!-- XXX all currencies have cents as one-hundredth part ??? -->
			<xsl:text> cent</xsl:text>
		</xsl:if>
	</xsl:template>

	<!--
	*********************************************************
	Name: amountNumber
	*********************************************************
	Public: yes

	Discription: Prints amount in numbers (Dutch formatting), taking currency into account.

	Params: amount - The amount to print.
			valuta - The currency.

	Output: text

	Calls:
	(name) round

	Called by:
	(mode) do-deed
	-->

	<!--
	**** named template ********************************************************************************
	-->
	<xsl:template name="amountNumber">
		<xsl:param name="amount" />
		<xsl:param name="valuta" />
		<xsl:param name="useParentheses" select="'true'"/>

		<xsl:variable name="roundedAmount">
			<xsl:call-template name="round">
				<xsl:with-param name="amount" select="$amount"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="formattedAmount">
			<xsl:choose>
				<xsl:when test="$roundedAmount = ''"><xsl:text/></xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="java:nl.kadaster.kpk.server.service.impl.transformer.XSLTUtil.formatAmount($roundedAmount)" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="currency" select="$currencies[translate(Value[@ColumnRef = 'column2']/SimpleValue, $upper, $lower)
			= translate($valuta, $upper, $lower)]/Value[@ColumnRef = 'column1']/SimpleValue"/>

		<xsl:if test="$useParentheses = 'true'">
			<xsl:text>(</xsl:text>
		</xsl:if>
		<xsl:choose>
			<xsl:when test="$currency = 'EUR'">
				<xsl:text>&#x20AC;</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$currency"/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:text> </xsl:text>
		<xsl:value-of select="$formattedAmount" />
		<xsl:if test="$useParentheses = 'true'">
			<xsl:text>)</xsl:text>
		</xsl:if>
	</xsl:template>
	
	<!--
	*********************************************************
	Name: percentText
	*********************************************************
	Public: yes

	Discription: Prints percent in text.

	Params: percent - The percent to print.

	Output: text

	Calls:
	none

	Called by:
	(mode) do-deed
	-->

	<!--
	**** named template ********************************************************************************
	-->
	<xsl:template name="percentText">
		<xsl:param name="percent" />
		<xsl:variable name="percentBeforePoint">
			<xsl:choose>
				<xsl:when test="contains($percent, '.')">
					<xsl:value-of select="substring-before($percent, '.')" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$percent" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="percentAfterPoint">
			<xsl:choose>
				<xsl:when test="$percent = ''">
					<xsl:value-of select="''" />
				</xsl:when>
				<xsl:when test="not(contains($percent, '.'))">
					<xsl:value-of select="''" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="substring-after($percent, '.')" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:if test="$percentBeforePoint != ''">
			<xsl:value-of select="java:nl.kadaster.kpk.server.service.impl.transformer.XSLTUtil.numberToDutch($percentBeforePoint)" />
		</xsl:if>
		<xsl:text> </xsl:text>
		<xsl:if test="$percentAfterPoint != ''">
			<xsl:value-of select="java:nl.kadaster.kpk.server.service.impl.transformer.XSLTUtil.numberToDutch($percentAfterPoint)" />
			<xsl:text>/</xsl:text>
			<xsl:choose>
				<xsl:when test="string-length($percentAfterPoint) = 2">
					<xsl:text>honderdste </xsl:text>
				</xsl:when>
				<xsl:when test="string-length($percentAfterPoint) = 1">
					<xsl:text>tiende </xsl:text>
				</xsl:when>
			</xsl:choose>
		</xsl:if>
		<xsl:text>procent</xsl:text>
	</xsl:template>

	<!--
	*********************************************************
	Name: percentNumber
	*********************************************************
	Public: yes

	Discription: Prints percent in number.

	Params: percent - The percent to print.

	Output: text

	Calls:
	none

	Called by:
	(mode) do-deed
	-->

	<!--
	**** named template ********************************************************************************
	-->
	<xsl:template name="percentNumber">
		<xsl:param name="percent" />
		<xsl:text>(</xsl:text>
		<xsl:value-of select="translate($percent, '.', ',')"/>
		<xsl:text>%)</xsl:text>
	</xsl:template>

	<!--
	*********************************************************
	Name: round
	*********************************************************
	Public: no

	Discription: Rounds amount to two decimals.

	Params: none

	Output: text

	Calls:
	none

	Called by:
	(name) amountText
	(name) amountNumber
	-->

	<!--
	**** named template ********************************************************************************
	-->
	<xsl:template name="round">
		<xsl:param name="amount"/>
		<xsl:choose>
			<xsl:when test="string-length(substring-after($amount, '.')) &gt; 2">
				<xsl:choose>
					<xsl:when test="number(concat('0.', substring(substring-after($amount, '.'), 3))) >= 0.5">
						<xsl:value-of select="concat(substring-before($amount, '.'),
							'.',
							substring(substring-after($amount, '.'), 1, 1),
							string(number(substring(substring-after($amount, '.'), 2, 1)) + 1))"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="substring($amount, 1, string-length($amount) - 1)"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$amount"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--
	*********************************************************
	Name: addMetaData
	*********************************************************
	Public: no

	Discription: Adds document meta data.

	Params: none

	Output: XHTML (<meta />)

	Calls:
	(name) addMetaDataFromTekstKeuze

	Called by:
	Root template
	-->

	<!--
	**** named template ********************************************************************************
	-->
	<xsl:template name="addMetaData">
		<meta scheme="nl.kadaster.kik" name="type-document" content="{$type-document}"/>
		<xsl:call-template name="addMetaDataFromOptionalTextChoice">
			<xsl:with-param name="tagName">margin-left</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="addMetaDataFromOptionalTextChoice">
			<xsl:with-param name="tagName">margin-right</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="addMetaDataFromOptionalTextChoice">
			<xsl:with-param name="tagName">margin-top</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="addMetaDataFromOptionalTextChoice">
			<xsl:with-param name="tagName">margin-bottom</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!--
	*********************************************************
	Name: addMetaDataFromOptionalTextChoice
	*********************************************************
	Public: no

	Discription: Adds document meta data from optional text choice XML storage.

	Params: tagName - Name of the optional text choice tag.

	Output: XHTML (<meta />)

	Calls:
	none

	Called by:
	(name) addMetaData
	-->

	<!--
	**** named template ********************************************************************************
	-->
	<xsl:template name="addMetaDataFromOptionalTextChoice">
		<xsl:param name="tagName"/>
		<xsl:if test="$keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam, $upper, $lower) = translate($tagName, $upper, $lower)]">
			<meta scheme="nl.kadaster.kik" name="{$tagName}"
				content="{$keuzeteksten/*/tia:TekstKeuze[tia:tagNaam = $tagName]/tia:tekst}"/>
		</xsl:if>
	</xsl:template>

	<!--
	*********************************************************
	Name: indent
	*********************************************************
	Public: yes

	Discription: Indents by inserting empty table cells.

	Params: current - Current indentation.
			indentLevel - Desired level of indentation.

	Output: XHTML structure

	Calls:
	(name) indent reccuring

	Called by:
	(mode) do-bridging-mortgage
	(name) processRights
	-->

	<!--
	**** named template ********************************************************************************
	-->
	<xsl:template name="indent">
		<xsl:param name="current"/>
		<xsl:param name="indentLevel"/>

		<td class="number" valign="top">
			<xsl:text>&#160;</xsl:text>
		</td>
		<xsl:if test="$current &lt; $indentLevel">
			<xsl:call-template name="indent">
				<xsl:with-param name="current" select="$current + 1"/>
				<xsl:with-param name="indentLevel" select="$indentLevel"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

</xsl:stylesheet>
