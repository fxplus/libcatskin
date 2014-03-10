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
**          Product : WebVoyage :: searchBasic
**          Version : 7.2.0
**          Created : 17-JUL-2007
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

<!-- Page specific imports -->
<xsl:include href="./contentLayout/cl_searchBasic.xsl"/>
<xsl:include href="./pageFacets/searchFacets.xsl"/>

<!-- Variable Declarations -->
<xsl:variable name="currPage">searchBasic</xsl:variable>

<xsl:variable name="searchCSS">
   <link href="{$css-loc}searchPages.css" media="all" type="text/css" rel="stylesheet"/>
   <link href="{$css-loc}searchBasic.css" media="all" type="text/css" rel="stylesheet"/>
</xsl:variable>

<!-- ######################### -->
<!-- ## begin Main Template ## -->
<!-- ######################################################### -->

<xsl:template match="/">
	<xsl:call-template name="buildHtmlPage">
		<xsl:with-param name="myCSS"  select="$searchCSS"/>
	</xsl:call-template>		
</xsl:template>

<!-- ################## -->
<!-- ## buildContent ## -->
<!-- ######################################################### -->

<xsl:template name="buildContent">

   <xsl:variable name="formData">
      <xsl:call-template name="buildBasicSearch"/>
   </xsl:variable>
   
	<xsl:call-template name="buildTheSearchForm">
		<xsl:with-param name="formName" select="'searchBasic'"/>
		<xsl:with-param name="formData" select="$formData"/>
		<xsl:with-param name="selectedTab" select="'page.search.buttons.basic.button'"/>
	</xsl:call-template>

</xsl:template>

<!-- ######################################################### -->

</xsl:stylesheet>


