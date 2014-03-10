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
**          Product : WebVoyage :: emailBody
**          Version : 7.2.0
**          Created : 01-NOV-2007
**      Orig Author : Scott Morgan
**    Last Modified : 18-AUG-2009
** Last Modified By : Mel Pemble
-->

<xsl:stylesheet version="1.0"
   exclude-result-prefixes="xsl fo page ser hol slim mfhd item"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:page="http://www.exlibrisgroup.com/voyager/webvoyage/page"
	xmlns:fo="http://www.w3.org/1999/XSL/Format"
	xmlns:ser="http://www.endinfosys.com/Voyager/serviceParameters"
	xmlns:hol="http://www.endinfosys.com/Voyager/holdings" 
   xmlns:slim="http://www.loc.gov/MARC21/slim"
   xmlns:mfhd="http://www.endinfosys.com/Voyager/mfhd"
   xmlns:item="http://www.endinfosys.com/Voyager/item">
       
	<xsl:include href="./contentLayout/display/display_text.xsl"/>
	
	<!--  since we don't have html and text all emails will be 
	      text so that we cover both types of clients 
	      (html clients will read text email) -->
	<xsl:output method="html" version="4.0" encoding="UTF-8"/>
	<xsl:variable name="new_line" select="'&#xA;'" />
	<xsl:variable name="tab" select="'&#09;'" />
	
	<xsl:variable name="Config" select="document('./contentLayout/configs/emailcfg.xml')"/>
	<xsl:variable name="holdingsConfig" select="document('./contentLayout/configs/emailcfgHoldings.xml')"/>	
	
	<xsl:template match="/">
		<xsl:for-each  select="/page:page/page:pageBody" >
			<xsl:for-each  select="page:element[@nameId='eMail.to']" >
				<xsl:value-of select="page:label"/> 
				<xsl:value-of select="' '"/>
				<xsl:value-of select="page:value"/>
				<xsl:value-of select="','"/>
			</xsl:for-each>
			<xsl:value-of select="$new_line"/>
			<xsl:value-of select="$new_line"/>
			
			<xsl:value-of select="page:element[@nameId='text.entered.by.user']"/>
			<xsl:value-of select="$new_line"/>
			
			<!--  the bib_records_replacement_token will be 
				  replaced the bib records rendered by emailRecord.xsl  -->	
			<xsl:value-of select="'bib_records_replacement_token'"/>
			<xsl:value-of select="$new_line"/>
			<xsl:value-of select="$new_line"/>
---------------------------------------------------------------
Institution Name:<xsl:value-of select="$tab"/>Falmouth University and University of Exeter Penryn Campus 
Institution Address:<xsl:value-of select="$tab"/>Learning Resources Centre, Penryn Campus, Treliever Road, Penryn, TR10 9EZ
Institution Web Site:<xsl:value-of select="$tab"/>http://library.fxplus.ac.uk
Institution Email:<xsl:value-of select="$tab"/>library@fxplus.ac.uk
Institution Phone:<xsl:value-of select="$tab"/>01326 370441
			
		</xsl:for-each>

	</xsl:template>
		
</xsl:stylesheet>

