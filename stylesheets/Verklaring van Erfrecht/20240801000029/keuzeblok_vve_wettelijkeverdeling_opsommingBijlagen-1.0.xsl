<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exslt="http://exslt.org/common" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:kef="nl.kadaster.xslt.XslExtensionFunctions" exclude-result-prefixes="xsl exslt xlink kef" version="1.0">
	<xsl:template match="opsommingBijlagen">
		<h3 class="header">
			<u>
				<xsl:text>AANHECHTEN BESCHEIDEN</xsl:text>
			</u>
		</h3>
		<p>
			<xsl:text>Aan deze akte worden de volgende bescheiden gehecht: </xsl:text>
		</p>
		<xsl:choose>
			<xsl:when test="count(bijlage) = 1">
				<p>
					<xsl:value-of select="bijlage"/>
				</p>
			</xsl:when>
			<xsl:otherwise>
				<table cellspacing="0" cellpadding="0">
					<tbody>
						<xsl:for-each select="bijlage">
							<tr>
								<td class="number">
									<xsl:text>-</xsl:text>
								</td>
								<td>
									<xsl:value-of select="."/>
								</td>
							</tr>
						</xsl:for-each>
					</tbody>
				</table>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
