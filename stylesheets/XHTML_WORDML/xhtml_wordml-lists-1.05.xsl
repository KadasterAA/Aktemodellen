<?xml version="1.0" encoding="UTF-8"?>
<!--
*********************************************************
Version: 1.05
*********************************************************
-->
<xsl:stylesheet
	xmlns:xhtml="http://www.w3.org/1999/xhtml"
	xmlns:w="http://schemas.microsoft.com/office/word/2003/wordml"
	xmlns:wx="http://schemas.microsoft.com/office/word/2003/auxHint"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	exclude-result-prefixes="xhtml"
	version="1.0">

	<!-- constants -->
	<xsl:variable name="supportedListBullets">&#x2022; o &#x00B7; -</xsl:variable>
	<xsl:variable name="maxAllowedListDepth" select="8"/>

	<xsl:variable name="allOrderedListNodes" select="//xhtml:ol"/>
	<xsl:variable name="allUnorderedListNodes" select="//xhtml:ul"/>
	<xsl:variable name="allListDefIds">
		<xsl:call-template name="getAllListDefIds"/>
	</xsl:variable>
	
	<!-- creates string that contains all list definition id's, in format id1:id2:...idn -->
	<xsl:template name="getAllListDefIds">
		<xsl:text>:</xsl:text>
		<xsl:for-each select="$allOrderedListNodes">
			<xsl:variable name="listDefIds">
				<xsl:for-each select="xhtml:li">
					<xsl:call-template name="getListDefId">
						<xsl:with-param name="listItemNode" select="."/>
					</xsl:call-template>
					<xsl:text> </xsl:text>
				</xsl:for-each>
			</xsl:variable>
			<xsl:call-template name="getListDefIds">
				<xsl:with-param name="listDefIds" select="$listDefIds"/>
			</xsl:call-template>
			<xsl:text>:</xsl:text>
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template name="getListDefIds">
		<xsl:param name="listDefIds"/>	
		<xsl:if test="normalize-space($listDefIds) != ''">
			<xsl:variable name="listDefId" select="substring-before(concat(normalize-space($listDefIds), ' '), ' ')"/>
			<xsl:variable name="remaining-listDefIds" select="normalize-space(substring($listDefIds, string-length($listDefId) + 1))"/>
			<!-- only continue if the value is unique -->
			<xsl:if test="not(contains(translate($remaining-listDefIds, $upper, $lower), translate($listDefId, $upper, $lower)))">
				<xsl:value-of select="$listDefId"/>
			</xsl:if>
			<!-- continue with the remaining values -->
			<xsl:call-template name="getListDefIds">
				<xsl:with-param name="listDefIds" select="$remaining-listDefIds"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	
	<!-- gets index of list definition id occurrence in variable $allListDefIds -->
	<xsl:template name="getIndexOfOrderedListNode">
		<xsl:param name="listDefId"/>
		<xsl:variable name="defId" select="concat(':', $listDefId , ':')"/>
		<xsl:if test="normalize-space($listDefId) != ''">
			<xsl:value-of select="string-length(substring-before($allListDefIds, $defId)) - string-length(translate(substring-before($allListDefIds, $defId),':','')) + 1"/>
		</xsl:if>
	</xsl:template>

	<xsl:template name="createListDefs">
		<w:lists>
			<xsl:if test="$allUnorderedListNodes">
				<xsl:call-template name="createUnorderedListDefs"/>
			</xsl:if>
			<xsl:if test="$allOrderedListNodes">
				<xsl:call-template name="createOrderedListDefs"/>
			</xsl:if>
			<xsl:call-template name="createListDefIdMappings"/>
		</w:lists>
	</xsl:template>

	<!-- creates a w:listDef per unordered list-style, each with a negative w:listDefId -->
	<xsl:template name="createUnorderedListDefs">
		<xsl:param name="bullets" select="$supportedListBullets"/>
		<xsl:param name="styleIndex">-1</xsl:param>
		<xsl:if test="$bullets != ''">
			<!-- pick the first bullet from the space-separated list of bullets -->
			<xsl:variable name="bullet" select="substring-before(concat(normalize-space($bullets), ' '), ' ')"/>
			<w:listDef w:listDefId="{$styleIndex}" w:tentative="on">
				<w:lvl w:ilvl="0">
					<w:lvlText w:val="{$bullet}"/>
				</w:lvl>
			</w:listDef>
			<!-- add list styles for the remaining bullets -->
			<xsl:call-template name="createUnorderedListDefs">
				<xsl:with-param name="bullets" select="normalize-space(substring($bullets, string-length($bullet) + 1))"/>
				<xsl:with-param name="styleIndex" select="$styleIndex - 1"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<!-- creates a w:listDef per <ol> node -->
	<xsl:template name="createOrderedListDefs">
		<!--
			Because Word list numbering (restart counting) is done per w:listDef, so each <ol> node gets its own w:listDef.
			Each w:listDef contains a list of w:lvls, thus forming a matrix of rows and columns. Each row (w:listDef)
			represents the list style and each column (w:lvl) represents a nesting depth.
			
			Each <ol> node forms a numbering group: all its <li> child nodes belong to that numbering group. For each
			combination of <li> item style, nesting depth and numbering group a unique w:listDef/w:lvl node must be created.
			
			We create a w:listDef per combination of item style and numbering group. Within every w:listDef we create a w:lvl
			for each nesting depth that occurs in the document.
			
			The style of an ordered <li> node in the document is represented by an nfc-value (see template getListStyleNfc).
			Combining this nfc-value with the number group of the list item gives the w:listDefId (see template getOrderedListDefId).
		-->
		<xsl:for-each select="$allOrderedListNodes">
			<xsl:variable name="orderedListIndex" select="position()"/>
			<!-- compose a list of all listDefId's we will need (double values are allowed here) -->
			<xsl:variable name="listDefIds">
				<xsl:for-each select="xhtml:li">
					<xsl:call-template name="getListDefId">
						<xsl:with-param name="listItemNode" select="."/>
					</xsl:call-template>
					<xsl:text> </xsl:text>
				</xsl:for-each>
			</xsl:variable>
			<!-- create a w:listDef for each unique listDefId -->
			<xsl:call-template name="createOrderedListDef">
				<xsl:with-param name="listDefIds" select="$listDefIds"/>
				<xsl:with-param name="listMaxDepth" select="$maxAllowedListDepth"/>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>

	<!-- creates a w:listDef for each unique listDefId -->
	<xsl:template name="createOrderedListDef">
		<xsl:param name="listDefIds"/>
		<xsl:param name="listMaxDepth"/>
		<xsl:if test="normalize-space($listDefIds) != '' and normalize-space($listMaxDepth) != ''">
			<xsl:variable name="listDefId" select="substring-before(concat(normalize-space($listDefIds), ' '), ' ')"/>
			<xsl:variable name="remaining-listDefIds" select="normalize-space(substring($listDefIds, string-length($listDefId) + 1))"/>
			<!-- only continue if the value is unique -->
			<xsl:if test="not(contains(translate($remaining-listDefIds, $upper, $lower), translate($listDefId, $upper, $lower)))">
				<w:listDef w:listDefId="{$listDefId}" w:tentative="on">
					<w:plt w:val="HybridMultilevel"/>
					<!-- create a w:lvl for each unique nesting depth -->
					<xsl:call-template name="createOrderedListLvls">
						<xsl:with-param name="listDefId" select="$listDefId"/>
						<xsl:with-param name="listMaxDepth" select="$listMaxDepth"/>
					</xsl:call-template>
				</w:listDef>
			</xsl:if>
			<!-- continue with the remaining values -->
			<xsl:call-template name="createOrderedListDef">
				<xsl:with-param name="listDefIds" select="$remaining-listDefIds"/>
				<xsl:with-param name="listMaxDepth" select="$maxAllowedListDepth"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<!-- creates a w:ilvl for each unique nesting depth -->
	<xsl:template name="createOrderedListLvls">
		<xsl:param name="listDefId"/>
		<xsl:param name="listMaxDepth"/>
		<xsl:variable name="indexOfOrderedListNode">	
			<xsl:call-template name="getIndexOfOrderedListNode">
				<xsl:with-param name="listDefId" select="$listDefId"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="orderedListNode" select="$allOrderedListNodes[number($indexOfOrderedListNode)]"/>
			
		<xsl:variable name="start">
			<xsl:choose>
				<xsl:when test="$orderedListNode/@start">
					<xsl:value-of select="$orderedListNode/@start"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'1'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<xsl:variable name="nfc">
			<xsl:choose>
				<xsl:when test="string-length($listDefId) > 4">
					<xsl:value-of select="substring($listDefId, string-length($listDefId) - 4) mod 1000"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$listDefId mod 1000"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<!-- creates a w:ilvl for each unique nesting depth -->
		<xsl:call-template name="createOrderedListLvl">
			<xsl:with-param name="nestingDepths" select="$listMaxDepth"/>
			<xsl:with-param name="nfc" select="$nfc"/>
			<xsl:with-param name="start" select="$start"/>
		</xsl:call-template>
	</xsl:template>

	<!-- creates a w:ilvl -->
	<xsl:template name="createOrderedListLvl">
		<xsl:param name="nestingDepths"/>
		<xsl:param name="nfc"/>
		<xsl:param name="start" select="'1'"/>
		<xsl:if test="normalize-space($nestingDepths) != ''">
			<xsl:variable name="ilvl" select="substring-before(concat(normalize-space($nestingDepths), ' '), ' ')"/>
			<w:lvl w:ilvl="{$ilvl}">
				<w:start w:val="{$start}"/>
				<w:nfc w:val="{$nfc}"/>
				<w:lvlText w:val="%{$ilvl+1}."/>
			</w:lvl>
			<!-- continue with the remaining values -->
			<xsl:if test="$nestingDepths > 0">
				<xsl:call-template name="createOrderedListLvl">
					<xsl:with-param name="nestingDepths" select="number($nestingDepths)-1"/>
					<xsl:with-param name="nfc" select="$nfc"/>
					<xsl:with-param name="start" select="$start"/>
				</xsl:call-template>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="getOrderedListDefId">
		<xsl:param name="orderedListIndex"/>
		<xsl:param name="listItemNode"/>
		<xsl:variable name="nfc">
			<xsl:call-template name="getOrderedListDefNfc">
				<xsl:with-param name="listItemNode" select="$listItemNode"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:value-of select="1000 * $orderedListIndex + $nfc"/>
	</xsl:template>

	<xsl:template name="getOrderedListDefNfc">
		<xsl:param name="listItemNode"/>
		<xsl:choose>
			<xsl:when test="contains(translate($listItemNode/@style, $upper, $lower), 'list-style-type:') and contains(translate($listItemNode/@style, $upper, $lower), 'upper-roman')">1</xsl:when>
			<xsl:when test="contains(translate($listItemNode/@style, $upper, $lower), 'list-style-type:') and contains(translate($listItemNode/@style, $upper, $lower), 'lower-roman')">2</xsl:when>
			<xsl:when test="contains(translate($listItemNode/@style, $upper, $lower), 'list-style-type:') and contains(translate($listItemNode/@style, $upper, $lower), 'upper-alpha')">3</xsl:when>
			<xsl:when test="contains(translate($listItemNode/@style, $upper, $lower), 'list-style-type:') and contains(translate($listItemNode/@style, $upper, $lower), 'lower-alpha')">4</xsl:when>
			<xsl:otherwise>0</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="createListDefIdMappings">
		<xsl:call-template name="createUnorderedListDefIdMappings"/>
		<xsl:call-template name="createOrderedListDefIdMappings"/>
	</xsl:template>

	<xsl:template name="createUnorderedListDefIdMappings">
		<xsl:param name="bullets" select="$supportedListBullets"/>
		<xsl:param name="listDefId">-1</xsl:param>
		<xsl:if test="$bullets != ''">
			<w:list w:ilfo="{$listDefId}">
				<w:ilst w:val="{$listDefId}"/>
			</w:list>
			<!-- add list mappings for the remaining listDefIds -->
			<xsl:call-template name="createUnorderedListDefIdMappings">
				<xsl:with-param name="bullets" select="normalize-space(substring-after(concat(normalize-space($bullets), ' '), ' '))"/>
				<xsl:with-param name="listDefId" select="$listDefId - 1"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<xsl:template name="createOrderedListDefIdMappings">
		<xsl:for-each select="$allOrderedListNodes">
			<xsl:variable name="orderedListIndex" select="position()"/>
			<!-- compose a list of all listDefId's we will need (double values are allowed here) -->
			<xsl:variable name="listDefIds">
				<xsl:for-each select="xhtml:li">
					<xsl:call-template name="getListDefId">
						<xsl:with-param name="listItemNode" select="."/>
					</xsl:call-template>
					<xsl:text> </xsl:text>
				</xsl:for-each>
			</xsl:variable>
			<!-- create a mapping for each unique listDefId -->
			<xsl:call-template name="createOrderedListDefIdMapping">
				<xsl:with-param name="listDefIds" select="$listDefIds"/>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template name="createOrderedListDefIdMapping">
		<xsl:param name="listDefIds"/>
		<xsl:if test="$listDefIds != ''">
			<xsl:variable name="listDefId" select="normalize-space(substring-before(concat(normalize-space($listDefIds), ' '), ' '))"/>
			<xsl:variable name="remaining-listDefIds" select="normalize-space(substring(normalize-space($listDefIds), string-length($listDefId) + 1))"/>
			<!-- only continue if the value is unique -->
			<xsl:if test="not(contains(translate($remaining-listDefIds, $upper, $lower), translate($listDefId, $upper, $lower)))">
				<w:list w:ilfo="{$listDefId}">
					<w:ilst w:val="{$listDefId}"/>
				</w:list>
			</xsl:if>
			<!-- add list mappings for the remaining listDefIds -->
			<xsl:call-template name="createOrderedListDefIdMapping">
				<xsl:with-param name="listDefIds" select="$remaining-listDefIds"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<xsl:template name="getListDefId">
		<xsl:param name="listItemNode" select="."/>
		<xsl:choose>
			<!-- stop searching for list items if the node has no <ul> or <ol> parent -->
			<xsl:when test="not($listItemNode/ancestor::xhtml:ul or $listItemNode/ancestor::xhtml:ol)">0</xsl:when>
			<!-- skip list item when the parent <li> node has non-empty preceding siblings -->
			<xsl:when test="($listItemNode/parent::xhtml:li)
					and (normalize-space($listItemNode/preceding-sibling::text()) != '')">0</xsl:when>
			<!-- listDefIds for unordered lists -->
			<xsl:when test="$listItemNode/parent::xhtml:ul">
				<xsl:choose>
					<xsl:when test="translate($listItemNode/parent::xhtml:ul/@class, $upper, $lower) = 'arrow'">-4</xsl:when>
					<xsl:when test="translate($listItemNode/@style, $upper, $lower) = 'list-style-type:square'">-1</xsl:when>
					<xsl:when test="translate($listItemNode/@style, $upper, $lower) = 'list-style-type:circle' or count($listItemNode/ancestor::xhtml:ol | $listItemNode/ancestor::xhtml:ul) = 2">-2</xsl:when>
					<xsl:when test="translate($listItemNode/@style, $upper, $lower) = 'list-style-type:square' or count($listItemNode/ancestor::xhtml:ol | $listItemNode/ancestor::xhtml:ul) >= 3">-3</xsl:when>
					<xsl:otherwise>-1</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<!-- listDefIds for ordered lists -->
			<xsl:when test="$listItemNode/parent::xhtml:ol">
				<xsl:for-each select="$allOrderedListNodes">
					<xsl:if test="translate(., $upper, $lower) = translate($listItemNode/.., $upper, $lower)">
						<xsl:variable name="position" select="count($listItemNode/ancestor::xhtml:ol[1]/preceding::xhtml:ol)+position()"/>						
						<!-- during counting, free text definitions should take previous (non-free text) lists in consideration -->
						<xsl:variable name="orderedListIndex">
							<xsl:value-of select="$position"/>
						</xsl:variable>
						<xsl:call-template name="getOrderedListDefId">
							<xsl:with-param name="orderedListIndex" select="$orderedListIndex"/>
							<xsl:with-param name="listItemNode" select="$listItemNode"/>
						</xsl:call-template>
					</xsl:if>
				</xsl:for-each>
			</xsl:when>
			<!-- continue searching up the ancestor tree -->
			<xsl:otherwise>
				<xsl:call-template name="getListDefId">
					<xsl:with-param name="listItemNode" select="$listItemNode/.."/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>
