<?xml version="1.0" encoding="UTF-8"?>
<!--
#(c)#=====================================================================
#(c)#
#(c)# Copyright 2007-2009 Ex Libris (USA) Inc.
#(c)# All Rights Reserved
#(c)#
#(c)#=====================================================================
-->
<!--
** Note: create persistent link based on bib ID
** Product : WebVoyage :: local_PersistentLink
** Version : 7.1.0
** Created : 16-Nov-2007
** Orig Author : Eric
** Last Modified : 04-MAY-2009
** Last Modified By : Mel Pemble
-->
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:page="http://www.exlibrisgroup.com/voyager/webvoyage/page"
xmlns:fo="http://www.w3.org/1999/XSL/Format">
<!-- ###################################################################### -->
<xsl:template name="persistentLink">
	<div class="persistentlink">
    <xsl:text disable-output-escaping="yes">&lt;a href="</xsl:text>
          <xsl:value-of select="concat('http://voyager.falmouth.ac.uk/vwebv/holdingsInfo?bibId=',$bibID)"></xsl:value-of>
    <xsl:text disable-output-escaping="yes">"&gt; Persistent link &lt;/a&gt;</xsl:text>

	</div>
</xsl:template>
<!-- ###################################################################### -->
</xsl:stylesheet>