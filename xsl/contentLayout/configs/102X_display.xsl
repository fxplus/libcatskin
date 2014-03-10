<?xml version="1.0" encoding="UTF-8"?>
<!--
**========================================================================
**
**          Copyright 2007-2011 Ex Libris (USA) Inc.
**                          All Rights Reserved
**
**========================================================================
-->
<!--
**        Product : Webvoyage :: 102X displays
**        Version : 7.1.0
**        Created : 10-MAR-2009
**  Last Modified : 10-MAR-2009
**    Orig Author : Chi-Hoi Duong
-->
<!--
**        This file is to transform the customized 102X fields
-->

<xsl:stylesheet version="1.0"
   exclude-result-prefixes="xsl page fo ser hol slim mfhd item"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:page="http://www.exlibrisgroup.com/voyager/webvoyage/page"
   xmlns:fo="http://www.w3.org/1999/XSL/Format"
   xmlns:ser="http://www.endinfosys.com/Voyager/serviceParameters"
   xmlns:hol="http://www.endinfosys.com/Voyager/holdings"
   xmlns:slim="http://www.loc.gov/MARC21/slim"
   xmlns:mfhd="http://www.endinfosys.com/Voyager/mfhd"
   xmlns:item="http://www.endinfosys.com/Voyager/item">

    <xsl:variable name="chronValues" select="document('104X_chronValues.xml')"/>


    <!-- NON-CONFIGURABLE GLOBAL VARIABLES -->

    <xsl:variable name="lowercase" select="'abcdefghijklmnopqrstuvwxyz'" />
    <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

    <!-- GET PUNCTUATION CONSTANTS FROM 102Xconfig.xsl -->

    <xsl:variable name="v102Xconfig" select="document('./1042_config.xml')"/>

    <!--
            for Voyager 6.1 and above, we need to provide
            a full path to the file 102X_config.xsl
    -->
    <xsl:variable name="v102Xconfig" select="document('./102X_config.xml')"/>
    <xsl:variable name="displayComponentName"    select="$v102Xconfig//Config/displayComponentName"/>
    <xsl:variable name="displayNextExpectedIssue" select="$v102Xconfig//Config/displayNextExpectedIssue"/>
    <xsl:variable name="numberOfIssuesToDisplayPerComponent" select="number($v102Xconfig//Config/numberOfIssuesToDisplayPerComponent)"/>
    <xsl:variable name="componentSortOrder" select="$v102Xconfig//Config/componentSortOrder"/>
    <xsl:variable name="issueSortOrder"    select="$v102Xconfig//Config/issueSortOrder"/>
    <xsl:variable name="expectedOn" select="$v102Xconfig//Config/expectedOn"/>
    <xsl:variable name="dateDisplaySeparator" select="$v102Xconfig//Config/dateDisplaySeparator"/>
    <xsl:variable name="dateOrder" select="$v102Xconfig//Config/dateOrder"/>
    <xsl:variable name="centuryFormat" select="$v102Xconfig//Config/centuryFormat"/>


<!-- ************************************************ -->

    <xsl:template name="displaySubscription">
        <xsl:param name="subscription"/>
        <xsl:param name="componentTypeFilter" />
            <xsl:for-each select="$subscription/mfhd:components/mfhd:component">
                    <xsl:sort select="translate(mfhd:name, $uppercase, $lowercase)"
                              order="{translate($componentSortOrder, $uppercase, $lowercase)}"
                              data-type="text"/>
                    <xsl:variable name="subscriptionData">
                        <xsl:if test="translate($componentTypeFilter, $uppercase, $lowercase) = translate(mfhd:type, $uppercase, $lowercase)">
                            <xsl:call-template name="displayComponent">
                               <xsl:with-param name="component" select="." />
                            </xsl:call-template>
                        </xsl:if>
                    </xsl:variable>
                    <xsl:if test="string-length($subscriptionData)">
                        <xsl:copy-of select="$subscriptionData" /><br/>
                    </xsl:if>
            </xsl:for-each>
    </xsl:template>

<!-- ************************************************ -->

    <xsl:template name="displayComponent">
        <xsl:param name="component"/>
        <xsl:for-each select="$component/mfhd:name">
             <xsl:choose>
                    <xsl:when test="position()=1"><xsl:value-of select="'&#09;'"/></xsl:when>
                    <xsl:otherwise><xsl:value-of select="'&#09;&#09;&#09;'"/></xsl:otherwise>
             </xsl:choose>
             <xsl:if test="translate($displayComponentName, $lowercase, $uppercase)='Y'">
                 <u><xsl:value-of select="."/></u><br/><xsl:value-of select="'&#xA;'"></xsl:value-of>
             </xsl:if>
        </xsl:for-each>
        <xsl:if test="translate($displayNextExpectedIssue, $lowercase, $uppercase)='Y'">
            <xsl:for-each select="$component/mfhd:unreceivedIssues/mfhd:unreceivedIssue">
               <xsl:sort select="@issueId"
                       order="{translate($issueSortOrder, $uppercase, $lowercase)}"
                       data-type="number"/>
               <xsl:if test="position() &lt;= $numberOfIssuesToDisplayPerComponent">
                  <xsl:call-template name="displayNextUnreceivedIssue">
                     <xsl:with-param name="unreceivedIssue" select="." />
                  </xsl:call-template>
               </xsl:if>
            </xsl:for-each>
        </xsl:if>
        <xsl:for-each select="$component/mfhd:receivedIssues/mfhd:receivedIssue">
            <xsl:sort select="@issueId"
                    order="{translate($issueSortOrder, $uppercase, $lowercase)}"
                    data-type="number"/>
            <xsl:if test="position() &lt;= $numberOfIssuesToDisplayPerComponent">
                <xsl:call-template name="displayReceivedIssue">
                    <xsl:with-param name="receivedIssue" select="." />
                </xsl:call-template>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>

<!-- ************************************************ -->

    <xsl:template name="displayReceivedIssue">
        <xsl:param name="receivedIssue"/>
            <xsl:value-of select="'&#09;&#09;&#09;'"/>
            <xsl:value-of select="$receivedIssue/mfhd:caption"/><br/>
            <!--
            <xsl:value-of select="'&#xA;'"></xsl:value-of>
            -->
    </xsl:template>


<!-- ************************************************ -->

    <xsl:template name="displayNextUnreceivedIssue">
        <xsl:param name="unreceivedIssue" />
        <xsl:if test="translate($unreceivedIssue/mfhd:isNextExpected, $lowercase, $uppercase)='TRUE'">
            <xsl:value-of select="'&#09;&#09;&#09;'"/>
            <xsl:value-of select="$unreceivedIssue/mfhd:caption"/>
            <xsl:text> [</xsl:text>
            <xsl:value-of select="$expectedOn"/>
            <xsl:choose>
                <xsl:when test="$dateOrder='1'">
                    <xsl:call-template name="displayDayMonthYear">
                        <xsl:with-param name="expectedDate" select="mfhd:expectedDate" />
                    </xsl:call-template>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:call-template name="displayMonthDayYear">
                        <xsl:with-param name="expectedDate" select="mfhd:expectedDate" />
                    </xsl:call-template>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:text>]</xsl:text>
            
            <br/>
            <!--<xsl:value-of select="'&#xA;&#xd;'"></xsl:value-of><br/>-->
        </xsl:if>
    </xsl:template>

<!-- ************************************************ -->

    <xsl:template name="displayMonthDayYear">
        <xsl:param name="expectedDate" />
        <xsl:value-of select="substring($expectedDate,6,2)"/>
        <xsl:value-of select="$dateDisplaySeparator"/>
        <xsl:value-of select="substring($expectedDate,9,2)"/>
        <xsl:value-of select="$dateDisplaySeparator"/>
        <xsl:choose>
            <xsl:when test="$centuryFormat='1'">
                <xsl:value-of select="substring($expectedDate,1,4)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="substring($expectedDate,3,2)"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

<!-- ************************************************ -->

    <xsl:template name="displayDayMonthYear">
        <xsl:param name="expectedDate" />
        <xsl:value-of select="substring($expectedDate,9,2)"/>
        <xsl:value-of select="$dateDisplaySeparator"/>
        <xsl:value-of select="substring($expectedDate,6,2)"/>
        <xsl:value-of select="$dateDisplaySeparator"/>
        <xsl:choose>
            <xsl:when test="$centuryFormat='1'">
                <xsl:value-of select="substring($expectedDate,1,4)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="substring($expectedDate,3,2)"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>

