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
**          Product : WebVoyage :: displayRecord
**          Version : 7.2.0
**          Created : 11-OCT-2007
**      Orig Author : David Sellers
**    Last Modified : 18-AUG-2009
** Last Modified By : Mel Pemble
-->

<xsl:stylesheet version="1.0"
   exclude-result-prefixes="xsl fo page"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:page="http://www.exlibrisgroup.com/voyager/webvoyage/page"
   xmlns:fo="http://www.w3.org/1999/XSL/Format">
	
	<!-- External imports -->
	<xsl:include href="./common/stdImports.xsl"/>
	
	<!-- Specific Imports -->
	<xsl:include href="./contentLayout/cl_displayRecord.xsl"/>
	<xsl:include href="./contentLayout/display/display.xsl"/>
	<xsl:include href="./pageFacets/displayFacets.xsl"/>
	<xsl:include href="./pageFacets/resultsFacets.xsl"/>
	<xsl:include href="./pageFacets/relatedItemsShelfFacets.xsl"/>

	<!-- Variable Declarations -->
	<xsl:variable name="currPage">displayRecord</xsl:variable>
	
	<xsl:variable name="displayRecordCSS">
		<link href="{$css-loc}resultsFacets.css"      media="all" type="text/css" rel="stylesheet"/>
		<link href="{$css-loc}displayCommon.css"      media="all" type="text/css" rel="stylesheet"/>
		<link href="{$css-loc}highlight.css"          media="all" type="text/css" rel="stylesheet"/>
		<link href="{$css-loc}displayGoogleBooks.css" media="all" type="text/css" rel="stylesheet"/>
	</xsl:variable>
	
	<xsl:variable name="myJavascripts">
		<script type="text/javascript" src="{$jscript-loc}imageUtils.js"></script>
	</xsl:variable>
	
	<!-- ######################### -->
	<!-- ## begin Main Template ## -->
	<!-- ######################################################### -->

	<xsl:template match="/">
		<xsl:call-template name="buildHtmlPage">
			<xsl:with-param name="myCSS" select="$displayRecordCSS"/>
			<xsl:with-param name="myJavascripts" select="$myJavascripts"/>
		</xsl:call-template>
	</xsl:template>
	
	<!-- ################## -->
	<!-- ## buildContent ## -->
	<!-- ######################################################### -->

	<xsl:template name="buildContent">
		<xsl:call-template name="buildRecordForm"/>
	</xsl:template>
	
   <!-- ######################################################### -->

</xsl:stylesheet>

