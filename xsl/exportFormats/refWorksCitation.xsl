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
**          Product : WebVoyage :: endNote Citation
**          Version : 7.2.0
**          Created : 2-NOV-2007
**      Orig Author : Scott Morgan
**    Last Modified : 16-SEP-2009
** Last Modified By : Mel Pemble
-->

<xsl:stylesheet version="1.0"
    exclude-result-prefixes="xsl fo page hol"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:hol="http://www.endinfosys.com/Voyager/holdings"
    xmlns:page="http://www.exlibrisgroup.com/voyager/webvoyage/page"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">

    <xsl:include href="../contentLayout/display/display_text.xsl"/>

    <xsl:output method="text" version="4.0" encoding="UTF-8"/>
    <xsl:variable name="Config" select="document('../contentLayout/configs/export/refWorksCitationConfig.xml')"/>
   <!-- <xsl:variable name="holdingsConfig" select="document('../contentLayout/configs/export/refWorksCitationConfigHoldings.xml')"/>-->

    <!-- ######################### -->
    <!-- ## begin Main Template ## -->
    <!-- ######################################################### -->

TY  - BOOK

    <xsl:template match="/">
        <xsl:choose>
            <xsl:when test="not(page:page/page:pageFooter)">
                <xsl:for-each select="$Config">
                    <xsl:call-template name="buildMarcDisplay">
                        <xsl:with-param name="recordType" select="'bib'"/>
                    </xsl:call-template>
                </xsl:for-each>

                <xsl:for-each select="$Config">
                    <xsl:call-template name="buildMarcDisplay">
                        <xsl:with-param name="recordType" select="'mfhd'"/>
                    </xsl:call-template>
                </xsl:for-each>
================================================================================<xsl:value-of select="$new_line"/>
            </xsl:when>


            <xsl:otherwise>
<!--
++++++++++++++++++++++++++++++++++++++++++<xsl:value-of select="$new_line"/>
Institution Name:<xsl:value-of select="$tab"/>University College Falmouth and University of Exeter Cornwall Campus 
Institution Address:<xsl:value-of select="$tab"/>Learning Resources Centre, Tremough Campus, Treliever Road, Penryn, TR10 9EZ
Institution Web Site:<xsl:value-of select="$tab"/>http://library.falmouth.ac.uk
Institution Email:<xsl:value-of select="$tab"/>library@falmouth.ac.uk
Institution Phone:<xsl:value-of select="$tab"/>01326 370441 -->
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>

