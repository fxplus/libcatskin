<?xml version="1.0" encoding="UTF-8"?>

<!--
#(c)#=====================================================================
#(c)#
#(c)#       Copyright 2007 ExLibris Group
#(c)#            All Rights Reserved
#(c)#
#(c)#=====================================================================
-->
<!--
**          Product : WebVoyage :: receiptRecord
**          Version : 7.0
**          Created : 31-OCT-2007
**      Orig Author : Scott Morgan
**    Last Modified : 31-JAN-2008
** Last Modified By : David Sellers
**
-->
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:page="http://www.exlibrisgroup.com/voyager/webvoyage/page"
	xmlns:fo="http://www.w3.org/1999/XSL/Format">

	<!-- ## Our Document Holders ## -->
	<xsl:variable name="Config"         select="document('../contentLayout/configs/print/receiptRecordConfig.xml')"/>
       <xsl:variable name="holdingsConfig" select="document('../contentLayout/configs/print/printReceiptConfigHoldings.xml')"/>	


	<!-- External imports -->
	<xsl:include href="../common/stdImports.xsl"/>
	<xsl:include href="../contentLayout/display/display.xsl"/>
	
	<xsl:variable name="currPage">Receipt Print Format</xsl:variable>

	<!-- ##################### -->
	<!-- ## begin Main Template ## -->
	<!-- ####################################################################################################################### -->
	<xsl:template match="/">
	  <div class="bibRecord">
   		<xsl:for-each select="$Config">
   			<div class="bibliographicData">
   				<xsl:call-template name="buildMarcDisplay">
   					<xsl:with-param name="recordType" select="'bib'"/>
   				</xsl:call-template>
   			</div>
   		</xsl:for-each>
		<xsl:for-each select="$Config">
			<div class="holdingsData">
				<xsl:call-template name="buildMarcDisplay">
					<xsl:with-param name="recordType" select="'mfhd'"/>
				</xsl:call-template>
			</div>			   			
   		</xsl:for-each>
		</div>
	</xsl:template>
	
	<xsl:template name="buildContent">
		<!--  do nothing makes framework.xsl happy -->
	</xsl:template>
	
</xsl:stylesheet>