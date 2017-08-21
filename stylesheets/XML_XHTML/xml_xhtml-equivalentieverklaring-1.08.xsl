<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:xhtml="http://www.w3.org/1999/xhtml"
	xmlns:tia="http://www.kadaster.nl/schemas/KIK/TIA_Algemeen"
	xmlns:alg="http://www.kadaster.nl/schemas/KIK/Formaattypen"
	xmlns:xlink="http://www.w3.org/1999/xlink"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:kef="nl.kadaster.xslt.XslExtensionFunctions"
	exclude-result-prefixes="xhtml tia alg xlink xsl kef"
	version="1.0">

	<!-- 
		*************************************************************************
		Template for Statement of equivalence (Verklaarder)
		*************************************************************************
	-->
	<xsl:template name="equivalentieverklaring">
		<xsl:param name="aangebodenstuk"/>
		<xsl:param name="aardondertekenaar"/>
		<xsl:param name="type"/>

		<xsl:if test="translate($type-document,$upper,$lower) = 'afschrift'">
			<xsl:choose>
				<xsl:when test="translate($type,$upper,$lower) = 'dot'">
					<a name="hyp4.statementOfEquivalence" class="location">&#160;</a>
				</xsl:when>
				<xsl:when test="translate($type,$upper,$lower)= 'dom'">
					<a name="hyp3.statementOfEquivalence" class="location">&#160;</a>
				</xsl:when>
				<xsl:when test="translate($type,$upper,$lower) = 'wkpb'">
				    <a name="wkpb.statement" class="location">&#160;</a>
				</xsl:when>
				<xsl:when test="translate($type,$upper,$lower) = 'doc'">
				    <a name="mortgagecancellationdeed.statementOfEquivalence" class="location">&#160;</a>
				</xsl:when>
			</xsl:choose>
			<xsl:if test="translate($type,$upper,$lower) = 'doc'">
				<p>
					<xsl:text>w.g.</xsl:text>
					<br/>
					<xsl:if test="$aangebodenstuk/tia:ondertekenaar/tia:tia_Initialen != ''">
						<xsl:value-of select="$aangebodenstuk/tia:ondertekenaar/tia:tia_Initialen"/>
						<xsl:text> </xsl:text>
					</xsl:if>
					<xsl:if test="$aangebodenstuk/tia:ondertekenaar/tia:tia_Ondertekenaar/tia:tia_VoorvoegselsNaam != ''">
						<xsl:value-of select="$aangebodenstuk/tia:ondertekenaar/tia:tia_Ondertekenaar/tia:tia_VoorvoegselsNaam"/>
						<xsl:text> </xsl:text>
					</xsl:if>
					<xsl:if test="$aangebodenstuk/tia:ondertekenaar/tia:tia_Ondertekenaar/tia:tia_NaamZonderVoorvoegsels != ''">
						<xsl:value-of select="$aangebodenstuk/tia:ondertekenaar/tia:tia_Ondertekenaar/tia:tia_NaamZonderVoorvoegsels"/>
					</xsl:if>
				</p>
				<p><br/></p>
			</xsl:if>
			<p>
				<xsl:text>Ondergetekende, </xsl:text>
				<xsl:if test="translate($aangebodenstuk/tia:tia_Verklaarder/tia:verklaarder/tia:geslacht/tia:geslachtsaanduiding,$upper,$lower) = 'man'">
					<xsl:text>de heer </xsl:text>
				</xsl:if>
				<xsl:if test="translate($aangebodenstuk/tia:tia_Verklaarder/tia:verklaarder/tia:geslacht/tia:geslachtsaanduiding,$upper,$lower) = 'vrouw'">
					<xsl:text>mevrouw </xsl:text>
				</xsl:if>
				<xsl:call-template name="person_data">
					<xsl:with-param name="person" select="$aangebodenstuk/tia:tia_Verklaarder/tia:verklaarder"/>
					<xsl:with-param name="include-birth-data" select="'false'"/>
				</xsl:call-template>
				<xsl:text>,</xsl:text>
				<xsl:choose>
				    <xsl:when test="translate($type,$upper,$lower) = 'wkpb'">
				        <xsl:text> '</xsl:text>
				        <xsl:value-of select="$aangebodenstuk/tia:tia_Verklaarder/tia:aard"/>
				        <xsl:text>', handelende namens </xsl:text>
				        <xsl:value-of select="$aangebodenstuk/tia:tia_Verklaarder/tia:verklaringBestuursorgaan/tia:naamBestuursorgaan" />
				        <xsl:text>, gevestigd te </xsl:text>
				        <xsl:value-of select="$aangebodenstuk/tia:tia_Verklaarder/tia:standplaats" />
				        <xsl:text>, verklaart hierbij dat:</xsl:text>
				    </xsl:when>
                    <xsl:otherwise>
        				<xsl:if test="$aangebodenstuk/tia:tia_Verklaarder/tia:aard = $aardondertekenaar">
        					<!-- notaries + waarnamer -->
							<xsl:choose>
							    <xsl:when test="translate($type,$upper,$lower) = 'doc'">
							    	<xsl:text> als waarnemer van </xsl:text>
							    </xsl:when>
							    <xsl:otherwise>
        							<xsl:text> hierna te noemen: notaris, als waarnemer van </xsl:text>
        						</xsl:otherwise>
        					</xsl:choose>
        					<xsl:call-template name="person_data">
        						<xsl:with-param name="person" select="$aangebodenstuk/tia:tia_Verklaarder/tia:waarnemerVoor"/>
        						<xsl:with-param name="include-birth-data" select="'false'"/>
        					</xsl:call-template>
        					<xsl:text>,</xsl:text>
        				</xsl:if>
        				<xsl:text> notaris te </xsl:text>
        				<xsl:value-of select="$aangebodenstuk/tia:tia_Verklaarder/tia:standplaats"/>
        				<xsl:choose>
        					<xsl:when test="translate($type,$upper,$lower) = 'doc'">
        						<xsl:text>, verklaart dat dit afschrift een volledige en juiste weergave is van de inhoud van het stuk waarvan het een afschrift is.</xsl:text>
        					</xsl:when>
        					<xsl:otherwise>, verklaart:</xsl:otherwise>
        				</xsl:choose>
    				</xsl:otherwise>
				</xsl:choose>
			</p>
			<xsl:choose>
    			<xsl:when test="translate($type,$upper,$lower) = 'dot' or translate($type,$upper,$lower) = 'dom'">
    				<ul class="arrow">
    					<li class="arrow">dat dit afschrift een volledige en juiste weergave is van de inhoud van het stuk waarvan het een afschrift is;</li>
    					<li class="arrow">
    						<xsl:text>dat het stuk waarvan dit stuk een afschrift is om </xsl:text>
    						<xsl:if test="$aangebodenstuk/tia:tia_TijdOndertekening">
    							<xsl:if test="string-length(substring(string($aangebodenstuk/tia:tia_TijdOndertekening),0,11))!=0">
    								<xsl:value-of select="kef:convertTimeToText(substring($aangebodenstuk/tia:tia_TijdOndertekening,1,5))"/>
    							</xsl:if>
    							<xsl:text> (</xsl:text>
    							<xsl:value-of select="substring($aangebodenstuk/tia:tia_TijdOndertekening,0,6)"/>
    							<xsl:text> uur) is ondertekend</xsl:text>
    						</xsl:if>
    						<xsl:choose>
    							<xsl:when test="translate($type,$upper,$lower) = 'dom'"><xsl:text>.</xsl:text></xsl:when>
    							<xsl:when test="translate($type,$upper,$lower) = 'dot'"><xsl:text>;</xsl:text></xsl:when>
    						</xsl:choose>
    					</li>
    					<xsl:if test="translate($type,$upper,$lower) = 'dot'">
    						<xsl:variable name="txt" select="$aangebodenstuk/tia:tia_TekstKeuze[translate(tia:tagNaam,$upper,$lower) = 'k_verklaringwvg']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
    								translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam,$upper,$lower) = 'k_verklaringwvg']/tia:tekst[translate(normalize-space(.), $upper, $lower) = translate(normalize-space($aangebodenstuk/tia:tia_TekstKeuze[translate(tia:tagNaam,$upper,$lower) = 'k_verklaringwvg']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
    						<xsl:if test="$txt != ''">
    							<li class="arrow">
    								<xsl:value-of select="$txt"/>
    								<xsl:text>.</xsl:text>
    							</li>
    						</xsl:if>
    					</xsl:if>
    				</ul>
    			</xsl:when>
    			<xsl:when test="translate($type,$upper,$lower) = 'wkpb'">
    			    <xsl:variable name="txt1" select="$aangebodenstuk/tia:tia_TekstKeuze[translate(tia:tagNaam,$upper,$lower) = 'k_toegevoegdebijlage']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
    			    	translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam,$upper,$lower) = 'k_toegevoegdebijlage']/tia:tekst[translate(normalize-space(.), $upper, $lower) = translate(normalize-space($aangebodenstuk/tia:tia_TekstKeuze[translate(tia:tagNaam,$upper,$lower) = 'k_toegevoegdebijlage']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
    			    <xsl:variable name="txt2" select="$aangebodenstuk/tia:tia_TekstKeuze[translate(tia:tagNaam,$upper,$lower) = 'k_typemutatiepb']/tia:tekst[translate(normalize-space(.), $upper, $lower) = 
    			    	translate(normalize-space($keuzeteksten/*/tia:TekstKeuze[translate(tia:tagNaam,$upper,$lower) = 'k_typemutatiepb']/tia:tekst[translate(normalize-space(.), $upper, $lower) = translate(normalize-space($aangebodenstuk/tia:tia_TekstKeuze[translate(tia:tagNaam,$upper,$lower) = 'k_typemutatiepb']/tia:tekst), $upper, $lower)]), $upper, $lower)]"/>
                	<ul class="arrow">
                		<li class="arrow">
                			<xsl:text>dit stuk </xsl:text>
                			<xsl:value-of select="$txt1"/>
                			<xsl:if test="$txt1">
                				<xsl:text> </xsl:text>
                			</xsl:if>
                			<xsl:text>een volledige en juiste weergave is van de inhoud van het stuk waarvan het een afschrift is;</xsl:text>
                		</li>
                		<xsl:if test="$aangebodenstuk/tia:tia_Verklaarder/tia:verklaringBestuursorgaan/tia:informatiePB">
                    		<li class="arrow">
                    		    <xsl:text>verkrijgers van grondstukken binnen het gebied van de gemeente </xsl:text>
                    		    <xsl:value-of select="$aangebodenstuk/tia:tia_Verklaarder/tia:verklaringBestuursorgaan/tia:informatiePB/tia:naamBestuursorgaanInfo"/>
                    		    <xsl:text>, die belast zijn met door die gemeente opgelegde publiekrechtelijke beperkingen daaromtrent nadere informatie kunnen verkrijgen bij </xsl:text>
                    		    <xsl:value-of select="$aangebodenstuk/tia:tia_Verklaarder/tia:verklaringBestuursorgaan/tia:informatiePB/tia:naamAfdeling"/>
                    		    <xsl:text>, </xsl:text>
                    			<xsl:call-template name="binnenlandsAdres">
                    				<xsl:with-param name="address" select="$aangebodenstuk/tia:tia_Verklaarder/tia:verklaringBestuursorgaan/tia:informatiePB/tia:adres"/>
                    			</xsl:call-template>
                    			<xsl:if test="$aangebodenstuk/tia:tia_Verklaarder/tia:verklaringBestuursorgaan/tia:informatiePB/tia:telefoonnummer and $aangebodenstuk/tia:tia_Verklaarder/tia:verklaringBestuursorgaan/tia:informatiePB/tia:telefoonnummer != ''">                    		    
                        		    <xsl:text>, </xsl:text>
                        		    <xsl:value-of select="$aangebodenstuk/tia:tia_Verklaarder/tia:verklaringBestuursorgaan/tia:informatiePB/tia:telefoonnummer"/>
                        	    </xsl:if>
                    			<xsl:if test="$aangebodenstuk/tia:tia_Verklaarder/tia:verklaringBestuursorgaan/tia:informatiePB/tia:e-mailadres and $aangebodenstuk/tia:tia_Verklaarder/tia:verklaringBestuursorgaan/tia:informatiePB/tia:e-mailadres != ''">                    		    
                        		    <xsl:text>, </xsl:text>
                        		    <xsl:value-of select="$aangebodenstuk/tia:tia_Verklaarder/tia:verklaringBestuursorgaan/tia:informatiePB/tia:e-mailadres"/>
                        	    </xsl:if>
                        	    <xsl:text> en gebonden zijn aan de regels, gesteld in de algemene voorwaarden welke zijn ingeschreven in register Hypotheken 4, </xsl:text>
                        	    <xsl:call-template name="IngeschrevenStuk">
                        	    	<xsl:with-param name="ingeschrevenStuk" select="$aangebodenstuk/tia:tia_Verklaarder/tia:verklaringBestuursorgaan/tia:informatiePB/tia:algemeneVoorwaarden"/>
                        	    	<xsl:with-param name="reeks" select="'false'"/>
                        	    	<xsl:with-param name="insertAnd" select="'false'"/>
                        	    </xsl:call-template>
                        	    <xsl:text>;</xsl:text>
                            </li>
                        </xsl:if>
                        <li>
                            <xsl:text>ten aanzien van de navolgende grondstukken publiekrechtelijke beperkingen</xsl:text>
							<xsl:if test="$txt2">
                            	<xsl:text> </xsl:text>
                            </xsl:if>
                            <xsl:value-of select="$txt2"/>
                            <xsl:text>, krachtens een stuk, waarvan een afschrift als bijlage aan dit stuk is gehecht.</xsl:text>
                        </li>
                	</ul>		    
    			</xsl:when>
    		</xsl:choose>
    		<xsl:if test="translate($type,$upper,$lower) != 'doc'">
				<p><br/></p>
			</xsl:if>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
