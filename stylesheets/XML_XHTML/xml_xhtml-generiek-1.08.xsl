<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:java="http://xml.apache.org/xalan/java"
	xmlns:gc="http://docs.oasis-open.org/codelist/ns/genericode/1.0/"
	exclude-result-prefixes="xsl java gc" 
	version="1.0">

	<!-- AFSCHRIFT | CONCEPT | MINUUT -->
	<xsl:param name="type-document">CONCEPT</xsl:param>
	<xsl:param name="css-url">kadaster.css</xsl:param>

	<xsl:variable name="upper">ABCDEFGHIJKLMNOPQRSTUVWXYZ</xsl:variable>
	<xsl:variable name="lower">abcdefghijklmnopqrstuvwxyz</xsl:variable>
    <xsl:variable name="currencies" select="document('vreemde-valuta-hypotheken-actueel.xml')/gc:CodeList/SimpleCodeList/Row" />

	<xsl:decimal-format decimal-separator="," grouping-separator="."/>
	<xsl:output method="xml" encoding="UTF-8" />

	<!-- root template -->
	<xsl:template match="/">
		<html>
			<head>
				<title><xsl:value-of select="$document-titel"/></title>
				<meta http-equiv="Content-Type" content="text/html;charset=UTF-8"/>
				<meta http-equiv="PRAGMA" content="NO-CACHE"/>
				<meta http-equiv="CACHE-CONTROL" content="NO-CACHE"/>
				<xsl:call-template name="addMetaData"/>
				<xsl:if test="$css-url != ''">
					<link rel="stylesheet" type="text/css" href="{$css-url}"/>
				</xsl:if>
			</head>
			<body>
				<xsl:apply-templates select="$AangebodenStuk"/>
			</body>
		</html>
	</xsl:template>

	<xsl:template name="addMetaData">
		<meta scheme="nl.kadaster.kik" name="type-document" content="{$type-document}"/>
		<xsl:call-template name="addMetaDataFromTekstKeuze">
			<xsl:with-param name="tagNaam">margin-left</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="addMetaDataFromTekstKeuze">
			<xsl:with-param name="tagNaam">margin-right</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="addMetaDataFromTekstKeuze">
			<xsl:with-param name="tagNaam">margin-top</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="addMetaDataFromTekstKeuze">
			<xsl:with-param name="tagNaam">margin-bottom</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="addMetaDataFromTekstKeuze">
		<xsl:param name="tagNaam"/>
		<xsl:variable name="tekstkeuze" select="$TekstKeuzeTags[text() = $tagNaam]/.."/>
		<xsl:if test="$tekstkeuze">
			<meta scheme="nl.kadaster.kik" name="{$tagNaam}"
				content="{$tekstkeuze/*[(translate(name(),$upper,$lower) = 'tekst') or (translate(substring-after(name(), ':'),$upper,$lower) = 'tekst')]}"/>
		</xsl:if>
	</xsl:template>

	<xsl:template name="amount-text">
		<xsl:param name="amount" />
		<xsl:param name="valuta" />
		<xsl:variable name="amountBeforePoint">
			<xsl:choose>
				<xsl:when test="contains($amount, '.')"><xsl:value-of select="substring-before($amount, '.')" /></xsl:when>
				<xsl:otherwise><xsl:value-of select="$amount" /></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="amountAfterPoint">
			<xsl:choose>
				<xsl:when test="$amount = ''"><xsl:value-of select="''" /></xsl:when>
				<xsl:when test="not(contains($amount, '.'))"><xsl:value-of select="'0'" /></xsl:when>
				<xsl:when test="string-length(substring-after($amount, '.')) &gt; 2">
					<xsl:value-of select="substring(substring-after($amount, '.'), 1, 2)" />
				</xsl:when>
				<xsl:when test="string-length(substring-after($amount, '.')) &lt; 2">
					<xsl:value-of select="concat(substring-after($amount, '.'), '0')" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="substring-after($amount, '.')" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:if test="$amountBeforePoint != ''">
			<xsl:value-of select="java:nl.kadaster.kpk.server.service.impl.transformer.XSLTUtil.numberToDutch($amountBeforePoint)" />
		</xsl:if>
		<xsl:text> </xsl:text>
		<xsl:value-of select="translate($valuta,$upper,$lower)"/>
		<xsl:if test="$amountAfterPoint != ''">
			<xsl:text> en </xsl:text>
			<xsl:value-of select="java:nl.kadaster.kpk.server.service.impl.transformer.XSLTUtil.numberToDutch($amountAfterPoint)" />
			<!-- XXX all currencies have cents as one-hundredth part ??? -->
			<xsl:text> cent</xsl:text>
		</xsl:if>
	</xsl:template>

	<xsl:template name="amount-number">
		<xsl:param name="amount" />
		<xsl:param name="valuta" />
		<xsl:variable name="formatted-amount">
			<xsl:choose>
				<xsl:when test="$amount = ''"><xsl:text/></xsl:when>
				<xsl:otherwise><xsl:value-of select="java:nl.kadaster.kpk.server.service.impl.transformer.XSLTUtil.formatAmount($amount)" /></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:text>(</xsl:text>
		<xsl:value-of select="$currencies[translate(Value[translate(@ColumnRef,$upper,$lower) = 'column2']/SimpleValue,$upper,$lower) = translate($valuta,$upper,$lower)]/Value[translate(@ColumnRef,$upper,$lower) = 'column1']/SimpleValue" />
		<xsl:text> </xsl:text>
		<xsl:value-of select="$formatted-amount" />
		<xsl:text>)</xsl:text>
	</xsl:template>

</xsl:stylesheet>
