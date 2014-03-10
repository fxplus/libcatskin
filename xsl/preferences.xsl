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
**          Product : WebVoyage :: Preferences
**          Version : 7.2.0
**          Created : 23-AUG-2007
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
	<xsl:include href="./contentLayout/cl_preferences.xsl"/>
	<xsl:include href="./pageFacets/myAccountLinks.xsl"/>
	
	<!-- Variable Declarations -->
	<xsl:variable name="currPage">Preferences</xsl:variable>
	<xsl:variable name="preferencesCSS">
	   <link href="{$css-loc}preferences.css" media="all" type="text/css" rel="stylesheet"/>
	</xsl:variable>
	
	<!-- ######################### -->
	<!-- ## begin Main Template ## -->
	<!-- ######################################################### -->
	
	<xsl:template match="/">
		<xsl:call-template name="buildHtmlPage">
			<xsl:with-param name="myCSS" select="$preferencesCSS"/>
		</xsl:call-template>
	</xsl:template>
	
	<!-- ################## -->
	<!-- ## buildContent ## -->
	<!-- ######################################################### -->

	<xsl:template name="buildContent">
		<form action="{/page:page//page:element[@nameId='page.myAccount.editPreferences.save.button']/page:buttonAction}" method="GET" accept-charset="UTF-8"  name="editPreferences">
			<xsl:call-template name="buildPreferences"/>
		</form>
	</xsl:template>

	<!-- ######################################################### -->
</xsl:stylesheet>

