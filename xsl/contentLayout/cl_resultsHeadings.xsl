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
**          Product : WebVoyage :: cl_resultsHeadings
**          Version : 7.2.0
**          Created : 15-OCT-2007
**      Orig Author : David Sellers
**    Last Modified : 14-SEP-2009
** Last Modified By : Mel Pemble
-->

<xsl:stylesheet version="1.0"
   exclude-result-prefixes="xsl fo page"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:page="http://www.exlibrisgroup.com/voyager/webvoyage/page"
   xmlns:fo="http://www.w3.org/1999/XSL/Format">

<!-- ################## -->
<!-- ## buildResultsForm ## -->
<!-- ######################################################### -->

<xsl:template name="buildResultsForm">
    <xsl:for-each select="/page:page/page:pageBody">

        <div class="resultsHeadingsForm">

            <!-- ## results header ## -->
            <div class="resultsHeader">
                <xsl:call-template name="buildResultsHeader"/>
            </div>

            <!-- ## jump nav top ## -->
            <div id="jumpBarNavTop">
                <xsl:call-template name="buildJumpBar"/>
            </div>

            <!-- ## browse header top ## -->
            <div id="browseHeaderTop">
                <xsl:call-template name="buildBrowseHeader">
                    <xsl:with-param name="location" select="'top'"/>
                </xsl:call-template>
            </div>

            <!-- ## records ## -->
            <div id="resultList">
                <xsl:call-template name="buildResultsHeadingsList"/>
            </div>

            <!-- ## browse header bottom ## -->
            <div id="browseHeaderbottom">
                <xsl:call-template name="buildBrowseHeader">
                    <xsl:with-param name="location" select="'bottom'"/>
                </xsl:call-template>
            </div>

            <!-- ## jump nav bottom ## -->
            <div id="jumpBarNavBottom">
                <xsl:call-template name="buildJumpBar"/>
            </div>

        </div>
    </xsl:for-each>

</xsl:template>

<xsl:template name="buildResultsHeadingsList">
    <xsl:for-each select="page:element[@nameId='headings']">
        <xsl:for-each select="page:option">

            <!-- ## variable used for alternating color ## -->
            <xsl:variable name="classPosition">
                <xsl:choose>
                    <xsl:when test="(position() mod 2) = 0">evenRow</xsl:when>
                    <xsl:otherwise>oddRow</xsl:otherwise>
                </xsl:choose>
            </xsl:variable>

            <!-- ## headings result record ## -->
            <div class="{$classPosition}">


                <!-- ## link & text ## -->
                <div class="resultListTextCell">

                    <!-- ## headings results heading ## -->
                    <div class="resultHeading">
                        <xsl:for-each select="page:option/page:element[@nameId='page.searchResults.contents.heading.link']">
                            <a href="{page:URL}">
                                <xsl:value-of select="page:linkText"/>
                            </a>
                        </xsl:for-each>
                        <xsl:for-each select="page:option/page:element[@nameId='page.searchResults.contents.heading.label']">
                            <label><xsl:value-of select="page:label"/><xsl:value-of select="page:value"/></label>
                        </xsl:for-each>

                        <!-- ## headings results title data ## -->
                        <xsl:for-each select="page:option/page:element[@nameId='page.searchResults.contents.title']">
                            <div class="resultTitle">
                                <div class="resultTitleLabel"><label><xsl:value-of select="page:label"/></label></div>
                                <div class="resultTitleValue"><span><xsl:value-of select="page:value"/></span></div>
                            </div>
                        </xsl:for-each>

                        <!-- ## headings results title data ## -->
                        <xsl:for-each select="page:option/page:element[@nameId='page.searchResults.contents.type']">
                            <div class="resultType">
                                <div class="resultTypeLabel"><label><xsl:value-of select="page:label"/></label></div>
                                <div class="resultTypeValue"><span><xsl:value-of select="page:value"/></span></div>
                            </div>
                        </xsl:for-each>
                    </div>

                    <!-- ## headings results referance info ## -->
                    <xsl:for-each select="page:option/page:element[@nameId='page.searchResults.contents.authority']">
                        <div class="resultAuthority">
                            <xsl:for-each select="page:element[@nameId='page.searchResults.authority.label']">
                                <div class="resultAuthorityLabel"><label><xsl:value-of select="page:label"/></label></div>
                            </xsl:for-each>
                            <xsl:for-each select="page:element[@nameId='page.searchResults.authority.link']">
                                <div class="resultAuthorityLink">
                                    <a href="{page:URL}"><xsl:value-of select="page:linkText"/></a>
                                </div>
                            </xsl:for-each>
                        </div>
                    </xsl:for-each>
                    <xsl:for-each select="page:option/page:element[@nameId='page.searchResults.contents.note']">
                        <div class="resultReferance">
                            <div class="resultReferanceLabel"><label><xsl:value-of select="page:label"/></label></div>
                            <div class="resultReferanceValue"><span><xsl:value-of select="page:value"/></span></div>
                        </div>
                    </xsl:for-each>
                    <xsl:for-each select="page:option/page:element[@nameId='page.searchResults.contents.reference']">
                        <div class="resultReferance">
                            <xsl:for-each select="page:element[@nameId='page.searchResults.reference.label']">
                                <div class="resultReferanceLabel"><label><xsl:value-of select="page:label"/></label></div>
                            </xsl:for-each>
                            <xsl:for-each select="page:element[@nameId='page.searchResults.reference.link']">
                                <div class="resultReferanceLink">
                                    <a href="{page:URL}"><xsl:value-of select="page:linkText"/></a>
                                </div>
                            </xsl:for-each>
                        </div>
                    </xsl:for-each>
                    <!-- ## headings results referance info ## -->

                </div>
                <!-- ## link & text ## -->

            </div>
            <!-- ## headings result record ## -->

        </xsl:for-each>
    </xsl:for-each>
</xsl:template>


</xsl:stylesheet>


