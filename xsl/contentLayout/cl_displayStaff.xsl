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
**          Product : WebVoyage :: cl_displayStaff
**          Version : 7.2.0
**          Created : 11-OCT-2007
**      Orig Author : David Sellers
**    Last Modified : 14-SEP-2009
** Last Modified By : Mel Pemble
-->

<xsl:stylesheet version="1.0"
	exclude-result-prefixes="xsl fo page"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:page="http://www.exlibrisgroup.com/voyager/webvoyage/page"
	xmlns:fo="http://www.w3.org/1999/XSL/Format">
       
      
<!-- ## Our Document Holders ## -->
<xsl:variable name="Config" select="document('./configs/displaycfg.xml')"/>
<xsl:variable name="holdingsConfig" select="document('./configs/displayHoldings.xml')"/>


<!-- ################## -->
<!-- ## buildRecordForm ## -->
<!-- ######################################################### -->

<xsl:template name="buildStaffForm">
	<xsl:for-each select="/page:page/page:pageBody">

		<div class="recordForm">
	
			<!-- ## jump nav top ## -->
			<div id="jumpBarNavTop">
				<xsl:call-template name="buildJumpBar"/>
			</div>
	

			<div class="recordContent">

				<!-- ## Action Box ## -->
				<xsl:call-template name="buildActionBox">
					<xsl:with-param name="pageRecordType" select="'actionBox.staffView.link'"/>
				</xsl:call-template>


						<!-- ## MARC Data ## -->
						<xsl:for-each select="$Config">

							<xsl:call-template name="buildTitle">
								<xsl:with-param name="recordType" select="'bib'"/>
							</xsl:call-template>
						
							<div class="marcData">
								<xsl:call-template name="BMD4000"/>
							</div>
						</xsl:for-each>
				
			</div>
	
		</div>			
		
	</xsl:for-each>		

</xsl:template>


</xsl:stylesheet>


