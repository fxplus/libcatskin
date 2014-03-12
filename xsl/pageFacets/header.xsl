<!--
#(c)#=====================================================================
#(c)#
#(c)#       Copyright 2007-2011 Ex Libris (USA) Inc.
#(c)#                       All Rights Reserved
#(c)#
#(c)#=====================================================================
-->
<!--
**          Product : WebVoyage :: header
**          Version : 7.2.0
**          Created : 06-JUL-2007
**      Orig Author : Mel Pemble
**    Last Modified : 29-SEP-2009
** Last Modified By : Mel Pemble
-->

<xsl:stylesheet
    version="1.0"
    exclude-result-prefixes="xsl fo page"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:page="http://www.exlibrisgroup.com/voyager/webvoyage/page">

<xsl:variable name="headerText" select="$Configs/pageConfigs/elementTitles/header"/>

<!-- ################# -->
<!-- ## buildHeader ## -->
<!-- ##################################################################################################################### -->

<xsl:template name="buildHeader">
   <xsl:for-each select="/page:page/page:pageHeader">
      <div id="headerRow">
         <div id="logo" title="{$headerText/logo}">
            <xsl:call-template name="buildImageUrl">
               <xsl:with-param name="eleName" select="'page.header.logo.image'"/>
            </xsl:call-template>
            
         </div>
         <div id="patronCol">

            <xsl:call-template name="loginLogout"/>
            <div id="headerHelp" title="{$headerText/help}">
               <span>
             <a href="{page:element[@nameId='page.header.help.link']/page:linkurl}" target="help">
                     <xsl:value-of select="page:element[@nameId='page.header.help.link']/page:linkText"/>
                  </a>&#160;<xsl:value-of select="page:element[@nameId='page.header.help.link']/page:postText"/>
               </span>
            </div>
         </div>
         <xsl:for-each select="page:tabs[@nameId='page.header.buttons']">
            <div id="headerTabs" title="{$headerText/headerTabs}">
               <a name="mainNav"></a>
               <h2 class="nav"><xsl:value-of select="$headerText/headerTabs"/></h2>
               <ul class="navbar">
                  <xsl:for-each select="$Configs/pageConfigs/headerTabDisplayOrder/tab">
                     <xsl:variable name="tempName" select="@name"/>
                     <xsl:call-template name="buildHeaderTab">
                        <xsl:with-param name="displayTab" select="$tempName"/>
                        <xsl:with-param name="highlight" select="highlight/@pages"/>
                     </xsl:call-template>
                  </xsl:for-each>
               </ul>
            </div>
         </xsl:for-each>
      </div>
   </xsl:for-each>
</xsl:template>

<!-- #################### -->
<!-- ## buildHeaderTab ## -->
<!-- ######################################################### -->

<xsl:template name="loginLogout">

   <xsl:variable name="headerPatronTitleText">
      <xsl:choose>
         <xsl:when test="string(page:element[@nameId='page.header.login.link'])">
            <xsl:if test="string-length(page:element[@nameId='page.header.login.link']/page:preText)">
              <xsl:value-of select="page:element[@nameId='page.header.login.link']/page:preText"/>&#160;
            </xsl:if>
            <xsl:value-of select="page:element[@nameId='page.header.login.link']/page:linkText"/>&#160;<xsl:value-of select="page:element[@nameId='page.header.login.link']/page:postText"/>
         </xsl:when>
         <xsl:when test="string(page:element[@nameId='page.header.logout.link'])">
            <xsl:value-of select="page:element[@nameId='page.header.logout.link']/page:preText"/>&#160;<xsl:value-of select="page:element[@nameId='page.header.logout.link']/page:preText[2]"/>&#160;<xsl:value-of select="page:element[@nameId='page.header.logout.link']/page:linkText"/>&#160;<xsl:value-of select="page:element[@nameId='page.header.logout.link']/page:postText"/>
         </xsl:when>
      </xsl:choose>
   </xsl:variable>
   
   <div id="headerPatron" title="{$headerPatronTitleText}">
      <span>
         <xsl:choose>
            <xsl:when test="string(page:element[@nameId='page.header.login.link'])">
               <xsl:if test="string-length(page:element[@nameId='page.header.login.link']/page:preText)">
                 <xsl:value-of select="page:element[@nameId='page.header.login.link']/page:preText"/>&#160;
               </xsl:if>
               <a href="{page:element[@nameId='page.header.login.link']/page:URL}"><xsl:value-of select="page:element[@nameId='page.header.login.link']/page:linkText"/></a>&#160;<xsl:value-of select="page:element[@nameId='page.header.login.link']/page:postText"/>
            </xsl:when>
            <xsl:when test="string(page:element[@nameId='page.header.logout.link'])">
            <span class="logoutPreText"><xsl:value-of select="page:element[@nameId='page.header.logout.link']/page:preText"/></span>&#160;<xsl:value-of select="page:element[@nameId='page.header.logout.link']/page:preText[2]"/>&#160;<a href="{page:element[@nameId='page.header.logout.link']/page:URL}"><xsl:value-of select="page:element[@nameId='page.header.logout.link']/page:linkText"/></a>&#160;<xsl:value-of select="page:element[@nameId='page.header.logout.link']/page:postText"/>
            </xsl:when>
         </xsl:choose>
      </span>
   </div>

</xsl:template>

<!-- #################### -->
<!-- ## buildHeaderTab ## -->
<!-- ######################################################### -->

<xsl:template name="buildHeaderTab">
<xsl:param name="displayTab"/>
<xsl:param name="highlight"/>

   <xsl:for-each select="$pageHeaderXML//page:button[@nameId=$displayTab]">
      <xsl:variable name="tabClass">
   		<xsl:choose>
   			<xsl:when test="contains($highlight,/page:page/@nameId)">on</xsl:when>
   			<xsl:otherwise>off</xsl:otherwise>		
   		</xsl:choose>
   	</xsl:variable>
      <li class="{$tabClass}" title="{page:buttonMessage}">
         <a href="{page:buttonAction}" name="{@nameId}">
            <span><xsl:value-of select="page:buttonText"/></span>
         </a>
      </li>
   </xsl:for-each>

</xsl:template>

<!-- ###################### -->
<!-- ## buildQuickSearch ## -->
<!-- ##################################################################################################################### -->

<xsl:template name="quickSearchBar">

   <xsl:for-each select="/page:page/page:searchQuick">
      <div id="quickSearchBar" title="{$headerText/quickSearchBar}">
         <form action="{page:element[@nameId='page.searchQuick.go.button']/page:buttonAction}" method="get">
         
            <span id="quickSearchArg" title="{/page:page//page:element[@nameId='searchArg']/page:label}">
               <xsl:call-template name="buildFormInput">
                  <xsl:with-param name="eleName"  select="'searchArg'"/>
                  <xsl:with-param name="size"  select="'36'"/>
               </xsl:call-template>
            </span>
            
            <span id="searchButton" title="{//page:element[@nameId='page.searchQuick.go.button']/page:buttonMessage}">
               <input type="submit"
                      alt="{//page:element[@nameId='page.searchQuick.go.button']/page:buttonMessage}"
                      value="{//page:element[@nameId='page.searchQuick.go.button']/page:buttonText}"
                      id="quickSearchButton"/>
            </span>

            <span id="searchHistory" title="{//page:element[@nameId='page.searchQuick.searchHistory.link']/page:linkText}">
               <span id="searchHistoryIcon">&#160;</span>
               <xsl:call-template name="buildLinkType">
                  <xsl:with-param name="eleName"  select="'page.searchQuick.searchHistory.link'"/>
               </xsl:call-template>
            </span>
            
            <input type="hidden" name="searchCode" value="{page:element[@nameId='searchCode']/page:label}"/>
            <input type="hidden" name="searchType" value="{page:element[@nameId='searchType']/page:label}"/>
            <input type="hidden" name="recCount" value="{page:element[@nameId='recCount']/page:label}"/>
            
         </form>
      </div>
   </xsl:for-each>
</xsl:template>

<!-- ##################################################################################################################### -->

</xsl:stylesheet>


