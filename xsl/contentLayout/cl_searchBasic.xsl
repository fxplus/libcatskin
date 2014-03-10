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
**          Product : WebVoyage :: cl_searchBasic
**          Version : 7.2.0
**          Created : 17-JUL-2007
**      Orig Author : David Sellers
**    Last Modified : 14-SEP-2009
** Last Modified By : Mel Pemble
-->

<xsl:stylesheet version="1.0"
   exclude-result-prefixes="xsl fo page"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:page="http://www.exlibrisgroup.com/voyager/webvoyage/page"
   xmlns:fo="http://www.w3.org/1999/XSL/Format">

<!-- ##################### -->
<!-- ## buildSearchForm ## -->
<!-- ######################################################### -->

<xsl:template name="buildBasicSearch">

   <div id="searchParams">
      <div id="searchInputs">
         <xsl:call-template name="buildFormInput">
            <xsl:with-param name="eleName"  select="'searchArg'"/>
            <xsl:with-param name="size"  select="'51'"/>
            <xsl:with-param name="accesskey"  select="'s'"/>
         </xsl:call-template>
         <xsl:call-template name="buildFormDropDown">
            <xsl:with-param name="eleName"  select="'searchCode'"/>
         </xsl:call-template>
      </div>
      <div id="quickLimits">
         <xsl:call-template name="buildFormDropDown">
            <xsl:with-param name="eleName"  select="'limitTo'"/>
         </xsl:call-template>
      </div>
   </div>
   
   <xsl:call-template name="buildSearchButtons"/>

</xsl:template>

<!-- ######################################################### -->

</xsl:stylesheet>


