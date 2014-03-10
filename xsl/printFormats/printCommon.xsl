<?xml version="1.0" encoding="UTF-8"?>

<!--
#(c)#=====================================================================
#(c)#
#(c)#       Copyright 2007-2009 Ex Libris (USA) Inc.
#(c)#       All Rights Reserved
#(c)#
#(c)#=====================================================================
-->
<!--
**          Product : WebVoyage :: printCommon
**          Version : 7.1.0
**          Created : 31-OCT-2007
**      Orig Author : Scott Morgan
**    Last Modified : 09-MAR-2009
** Last Modified By : Mel Pemble
-->
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:page="http://www.exlibrisgroup.com/voyager/webvoyage/page"
	xmlns:fo="http://www.w3.org/1999/XSL/Format">

	<!-- External imports -->
	<xsl:include href="../common/stdImports.xsl"/>
	<xsl:include href="../contentLayout/display/display.xsl"/>

	<xsl:variable name="currPage">Brief Print Format</xsl:variable>
    	<xsl:variable name="holdingsConfig" select="document('../contentLayout/configs/print/printConfigHoldings.xml')"/>

	<xsl:template match="/">
		<html>
			<head>
				<script>
					<xsl:attribute name="type">
			             		<xsl:value-of select="'text/javascript'"/>
			        	</xsl:attribute>
			        	<xsl:attribute name="src">
			        		<xsl:value-of select="$jscript-loc" />
			             		<xsl:value-of select="'autoPrint.js'"/>
			        	</xsl:attribute>
				</script>

<!-- ###################################################################################################### -->
<!-- ## getURL() and getcss() are declared in autoPrint.js ## -->
<!-- RECEIPT is styled for the EPSON TM-T88IV RECEIPT printer (~8cm wide paper) -->
	<script type="text/javascript">
		if(getURL() == 'receipt') {
			getcss('<xsl:value-of select='$css-loc'/>print/printReceiptFullRecord.css')
			getcss('<xsl:value-of select='$css-loc'/>print/printReceiptRecord.css') 
		}
		else {
			getcss('<xsl:value-of select='$css-loc'/>print/printFullRecord.css')
			getcss('<xsl:value-of select='$css-loc'/>print/printBriefRecord.css')
		}
	</script>
<!-- ######################################################################################################
THESE ARE THE ORIGINAL CSS DECLARATIONS 
<style type='text/css' media='screen,print'>@import '<xsl:value-of select='$css-loc'/>print/printFullRecord.css';</style>
<style type='text/css' media='screen,print'>@import '<xsl:value-of select='$css-loc'/>print/printBriefRecord.css';</style>	
-->
		<style type='text/css' media='print'>@import '<xsl:value-of select='$css-loc'/>print/printOnly.css';</style>
		
				
			</head>

		       <body onload="printPage()">
				<!--  the actual html for the record will get placed here buffered by the servlet -->
				<xsl:value-of select="'html_for_records_replacement_token'" />
<div class="bkbtn"><A HREF="javascript:history.go(-1)"> [Go Back]</A></div>
			</body>
			<footer>
			</footer>
		</html>
	</xsl:template>
	
	<xsl:template name="buildContent">
		<!--  do nothing -->
	</xsl:template>
	
</xsl:stylesheet>