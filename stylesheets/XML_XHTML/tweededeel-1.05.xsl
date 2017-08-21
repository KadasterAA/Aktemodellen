<?xml version="1.0" encoding="UTF-8"?>
<!--
*********************************************************
Stylesheet: tweededeel.xsl
Version: 1.05
*********************************************************
Description:
Free text style sheet.

Public:
(mode) do-free-text

Private:
none
-->
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
	xmlns:tia="http://www.kadaster.nl/schemas/KIK/TIA_Algemeen"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	exclude-result-prefixes="tia xsl"
	version="1.0">

	<xsl:preserve-space elements="tia:tia_TekstTweedeDeel"/>

	<!--
	*********************************************************
	Mode: do-free-text
	*********************************************************
	Public: yes

	Identity transform: no

	Description: Free text part.

	Input: tia:tia_TekstTweedeDeel

	Params: none

	Output: XHTML structure

	Calls:
	none

	Called by:
	(mode) do-deed
	-->

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="tia:tia_TekstTweedeDeel" mode="do-free-text">
		<xsl:choose>
			<xsl:when test="div and count(*) = 1 and count(div/* | div/text()) > 1">
				<xsl:apply-templates select="div/* | div/text()" mode="do-free-text" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="* | text()" mode="do-free-text" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="*[(starts-with(translate(local-name(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'h')) and (contains('123456789', substring(local-name(), 2, 1)))]" mode="do-free-text">
		<xsl:element name="{name()}">
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates mode="do-free-text"/>
		</xsl:element>
	</xsl:template>

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="*[((translate(local-name(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz') = 'p') or (translate(local-name(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz') = 'div')) and (normalize-space() != '')]" mode="do-free-text">
		<xsl:choose>
			<!-- remove div used as wrapper (with title attribute)  -->
			<xsl:when test="translate(@title, $upper, $lower) = 'part2'">
				<xsl:apply-templates mode="do-free-text"/>
			</xsl:when>
			<xsl:otherwise>
				<div>
					<xsl:copy-of select="@*"/>
					<xsl:apply-templates select="* | text()" mode="do-free-text"/>
				</div>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="*[(translate(local-name(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz') = 'blockquote') and (normalize-space() != '')]" mode="do-free-text">
		<div style="margin-left: 30px;">
			<xsl:apply-templates select="* | text()" mode="do-free-text"/>
		</div>
	</xsl:template>

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="*[translate(local-name(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz') = 'br']" mode="do-free-text">
		<xsl:choose>
			<xsl:when test="ancestor-or-self::*[translate(local-name(), $upper, $lower) = 'p' or translate(local-name(), $upper, $lower) = 'div']"><br/></xsl:when>
			<xsl:otherwise>
				<p>
					<br/>
				</p>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="*[translate(local-name(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz') = 'span']" mode="do-free-text">
		<xsl:choose>
			<xsl:when test="starts-with(translate(local-name(parent::*), $upper, $lower), 'h') and contains('123456789', substring(local-name(parent::*), 2, 1)) and count(child::*) = 0">
				<xsl:apply-templates mode="do-free-text"/>
			</xsl:when>
			<xsl:otherwise>
				<span>
					<xsl:copy-of select="@*"/>
					<xsl:apply-templates mode="do-free-text"/>
				</span>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="*[(translate(local-name(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz') = 'strong') or (translate(local-name(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz') = 'b')]" mode="do-free-text">
		<strong>
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates mode="do-free-text"/>
		</strong>
	</xsl:template>

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="*[translate(local-name(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz') = 'u']" mode="do-free-text">
		<span style="text-decoration:underline">
			<xsl:apply-templates mode="do-free-text"/>
		</span>
	</xsl:template>

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="*[(translate(local-name(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz') = 'em') or (translate(local-name(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz') = 'i')]" mode="do-free-text">
		<em>
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates mode="do-free-text"/>
		</em>
	</xsl:template>

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="*[translate(local-name(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz') = 'ul']" mode="do-free-text">
		<ul>
			<xsl:apply-templates mode="do-free-text"/>
		</ul>
	</xsl:template>

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="*[translate(local-name(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz') = 'ol']" mode="do-free-text">
		<ol>
			<xsl:apply-templates mode="do-free-text"/>
		</ol>
	</xsl:template>

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="*[((translate(local-name(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz') = 'li')) and not(contains(translate(@style, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'list-style: none'))]" mode="do-free-text">
		<li>
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates mode="do-free-text"/>
		</li>
	</xsl:template>

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="*[((translate(local-name(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz') = 'li')) and contains(translate(@style, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'list-style: none')]" mode="do-free-text">
		<xsl:apply-templates mode="do-free-text"/>
	</xsl:template>

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="font[@size]" mode="do-free-text">
		<xsl:copy>
			<xsl:copy-of select="@*" />
			<xsl:apply-templates mode="do-free-text" />
		</xsl:copy>
	</xsl:template>

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="*" priority="-2" mode="do-free-text">
		<span>
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates select="* | text()" mode="do-free-text"/>
		</span>
	</xsl:template>

	<!--
	**** matching template ********************************************************************************
	-->
	<xsl:template match="text()" mode="do-free-text">
		<xsl:choose>
			<xsl:when test="translate(local-name(parent::*), $upper, $lower) = 'div' and translate(parent::*/@title, $upper, $lower) = 'part2' and normalize-space() != ''">
				<span>
					<xsl:copy-of select="." />
				</span>
			</xsl:when>
			<xsl:otherwise>				
				<xsl:copy-of select="." />
			</xsl:otherwise>
		</xsl:choose>	
	</xsl:template>

</xsl:stylesheet>
