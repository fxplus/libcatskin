<?xml version="1.0" encoding="UTF-8"?>

<!--
#(c)#=====================================================================
#(c)#
#(c)#       Copyright 2007-2011 Ex Libris (USA) Inc.
#(c)#       All Rights Reserved
#(c)#
#(c)#=====================================================================
-->

<!--
**          Product : WebVoyage :: cl_resultsMyList
**          Version : 7.2.0
**          Created : 16-NOV-2007
**      Orig Author : David Sellers
**    Last Modified : 14-SEP-2009
** Last Modified By : Mel Pemble
-->

<xsl:stylesheet version="1.0"
	exclude-result-prefixes="xsl fo page"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:page="http://www.exlibrisgroup.com/voyager/webvoyage/page"
	xmlns:fo="http://www.w3.org/1999/XSL/Format">

<!-- ###################### -->
<!-- ## buildResultsForm ## -->
<!-- ######################################################### -->

<xsl:template name="buildResultsForm">
	<xsl:for-each select="/page:page/page:pageBody">

		<div class="resultsTitleForm">
	
			<!-- ## results header ## -->
			<div class="resultsHeader">
				<xsl:call-template name="buildResultsHeader"/>
			</div>
	
			<!-- ## jump nav top ## -->
			<div id="jumpBarNavTop">
				<xsl:call-template name="buildJumpBar"/>
			</div>
	
			<!-- ## browse header top ## -->
			<div id="browseHeaderTop">
				<xsl:call-template name="buildBrowseHeader">
					<xsl:with-param name="location" select="'top'"/>
				</xsl:call-template>
			</div>

         <div id="theResults">
   			<!-- ## filters ## -->
   			<xsl:call-template name="buildFiltersBlock"/>
   
   			<!-- ## records ## -->
   			<div id="resultList">
   				<xsl:call-template name="buildResultsList"/>
   			</div>
         </div>
         
			<!-- ## browse header bottom ## -->
			<div id="browseHeaderbottom">
				<xsl:call-template name="buildBrowseHeader">
					<xsl:with-param name="location" select="'bottom'"/>
				</xsl:call-template>
			</div>
	
			<!-- ## jump nav bottom ## -->
			<div id="jumpBarNavBottom">
				<xsl:call-template name="buildJumpBar"/>
			</div>
	
		</div>			
	</xsl:for-each>		

</xsl:template>

<!-- ######################################################### -->

</xsl:stylesheet>


