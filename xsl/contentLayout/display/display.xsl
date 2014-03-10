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
**          Product : WebVoyage :: display
**          Version : 7.1.0
**          Created : 26-OCT-2007
**      Orig Author : David Sellers
**    Last Modified : 07-MAY-2009
** Last Modified By : Mel Pemble
-->

<xsl:stylesheet version="1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:page="http://www.exlibrisgroup.com/voyager/webvoyage/page"
   xmlns:fo="http://www.w3.org/1999/XSL/Format"
   xmlns:ser="http://www.endinfosys.com/Voyager/serviceParameters"
   xmlns:hol="http://www.endinfosys.com/Voyager/holdings"
   xmlns:slim="http://www.loc.gov/MARC21/slim" exclude-result-prefixes="slim"
   xmlns:mfhd="http://www.endinfosys.com/Voyager/mfhd"
   xmlns:item="http://www.endinfosys.com/Voyager/item">

<xsl:import href="../display/marc21slim.xsl"/>
<xsl:import href="../configs/104X_display.xsl"/>
<xsl:import href="../configs/102X_display.xsl"/>

<xsl:import href="../display/urlfunctions.xsl"/>

<xsl:variable name="constStr_Field000Leader">000</xsl:variable>
<xsl:variable name="constStr_SpacingUnderline">_</xsl:variable>
<xsl:variable name="constStr_SubfieldPipe">|</xsl:variable>

<!-- ## Our Document Holders ## -->
<xsl:variable name="HoldXML" select="//hol:mfhdCollection"/>

<xsl:variable name="bibRecord" select="//hol:bibRecord "/>
<xsl:variable name="bibID" select="//hol:bibRecord/@bibId"/>
<xsl:variable name="mfhdRecord" select="//hol:mfhdCollection/mfhd:mfhdRecord"/>

<xsl:variable name="pdsHandle" select="/page:page/page:pageBody/page:holdingsCollection/@pdsHandle"/>

<xsl:variable name="searchParameter" select="/page:page/page:pageBody/page:element[@nameId='search.parameter']/page:label"/>
<xsl:variable name="searchArgParameter" select="/page:page/page:pageBody/page:element[@nameId='searchArg.parameter']/page:label"/>
<xsl:variable name="searchCodeParameter" select="/page:page/page:pageBody/page:element[@nameId='searchCode.parameter']/page:label"/>
<xsl:variable name="searchTypeParameter" select="/page:page/page:pageBody/page:element[@nameId='searchType.parameter']/page:label"/>

<xsl:variable name="searchTypeAuthor" select="/page:page/page:pageBody/page:element[@nameId='searchType.author']"/>
<xsl:variable name="searchTypeCallNumber" select="/page:page/page:pageBody/page:element[@nameId='searchType.callNumber']"/>
<xsl:variable name="searchTypeSubject" select="/page:page/page:pageBody/page:element[@nameId='searchType.subject']"/>
<xsl:variable name="searchTypeTitle" select="/page:page/page:pageBody/page:element[@nameId='searchType.title']"/>

<xsl:variable name="itemLocation" select="/page:page/page:pageBody/page:element[@nameId='search.item.location']/page:label"/>
<xsl:variable name="itemCallNumber" select="/page:page/page:pageBody/page:element[@nameId='search.item.callNumber']/page:label"/>
<xsl:variable name="itemStatus" select="/page:page/page:pageBody/page:element[@nameId='search.item.status']/page:label"/>

<xsl:variable name="itemStatusCodes" select="/page:page/page:pageBody/page:element[@nameId='search.item.status.code']"/>
<xsl:variable name="itemStatuses" select="/page:page/page:pageBody/page:element[@nameId='holdingsInfo.itemStatus']"/>

<xsl:variable name="lineItemStatus" select="/page:page/page:pageBody/page:element[@nameId='holdingsInfo.lineItemStatus']"/>

<xsl:variable name="holdingsJumpBar" select="/page:page/page:pageBody/page:element[@nameId='db.holdings.jumpBar']"/>

<xsl:variable name="searchTerms" select="/page:page/page:pageBody/page:element[@nameId='page.searchResults.terms']/page:element"/>

<xsl:variable name="relatedBibs" select="/page:page/page:pageBody/page:element[@nameId='holdingsInfo.relatedRecords']"/>
<xsl:variable name="dbCodes" select="/page:page/page:pageBody/page:element[@nameId='search.dbCode']"/>
<xsl:variable name="dpsLink" select="/page:page/page:pageBody/page:element[@nameId='holdingsInfo.dpsLink']"/>

<xsl:variable name="bibFormats" select="$Configs/pageConfigs/bibFormats"/>

<xsl:variable name="browse" select="'%2B'"/>

<!-- ## Definition of URN and DOI link from webvoyage.properties file the default is a blank string ## -->
<xsl:variable name="doiLink">
    <xsl:copy-of select="/page:page/page:pageBody/page:element[@nameId='property.DOI']/page:label"/>
</xsl:variable>
<xsl:variable name="urnLink">
    <xsl:copy-of select="/page:page/page:pageBody/page:element[@nameId='property.URN']/page:label"/>
</xsl:variable>

<!-- ## The following variables are used to convert case ## -->
<xsl:variable name="lowercase" select="'abcdefghijklmnopqrstuvwxyz'" />
<xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

    <xsl:variable name="VFORMAT">
	<xsl:for-each select="$bibRecord">
	<xsl:variable name="bibID" select="/page:page/page:pageBody/page:holdingsCollection/hol:marcRecord/hol:bibRecord/@bibId"/>
        <xsl:call-template name="BMDProcessMarcTags">
            <xsl:with-param name="field" select="'084'"/>
            <xsl:with-param name="indicator1" select="'X'"/>
            <xsl:with-param name="indicator2" select="'X'"/>
            <xsl:with-param name="subfield" select="'b'"/>
            <xsl:with-param name="mfhdID" select="$bibID"/>
            <xsl:with-param name="recordType" select="'bib'"/>
        </xsl:call-template>
	</xsl:for-each>
    </xsl:variable>

   <xsl:variable name="ISBN">
	<xsl:for-each select="$bibRecord">
	<xsl:variable name="bibID" select="/page:page/page:pageBody/page:holdingsCollection/hol:marcRecord/hol:bibRecord/@bibId"/>
        <xsl:call-template name="BMDProcessMarcTags">
            <xsl:with-param name="field" select="'020'"/>
            <xsl:with-param name="indicator1" select="'X'"/>
            <xsl:with-param name="indicator2" select="'X'"/>
            <xsl:with-param name="subfield" select="'a'"/>
            <xsl:with-param name="mfhdID" select="$bibID"/>
            <xsl:with-param name="recordType" select="'bib'"/>
        </xsl:call-template>
	</xsl:for-each>
    </xsl:variable>

    <xsl:variable name="QRClassNumberA">
	<xsl:for-each select="$bibRecord">
	<xsl:variable name="bibID" select="/page:page/page:pageBody/page:holdingsCollection/hol:marcRecord/hol:bibRecord/@bibId"/>
        <xsl:call-template name="BMDProcessMarcTags">
            <xsl:with-param name="field" select="'082'"/>
            <xsl:with-param name="indicator1" select="'X'"/>
            <xsl:with-param name="indicator2" select="'X'"/>
            <xsl:with-param name="subfield" select="'a'"/>
            <xsl:with-param name="mfhdID" select="$bibID"/>
            <xsl:with-param name="recordType" select="'bib'"/>
        </xsl:call-template>
	</xsl:for-each>
    </xsl:variable>

    <xsl:variable name="QRClassNumberB">
	<xsl:for-each select="$bibRecord">
	<xsl:variable name="bibID" select="/page:page/page:pageBody/page:holdingsCollection/hol:marcRecord/hol:bibRecord/@bibId"/>
        <xsl:call-template name="BMDProcessMarcTags">
            <xsl:with-param name="field" select="'082'"/>
            <xsl:with-param name="indicator1" select="'X'"/>
            <xsl:with-param name="indicator2" select="'X'"/>
            <xsl:with-param name="subfield" select="'b'"/>
            <xsl:with-param name="mfhdID" select="$bibID"/>
            <xsl:with-param name="recordType" select="'bib'"/>
        </xsl:call-template>
	</xsl:for-each>
    </xsl:variable>

    <xsl:variable name="QRClassNumberDVD">
	<xsl:for-each select="$bibRecord">
	<xsl:variable name="bibID" select="/page:page/page:pageBody/page:holdingsCollection/hol:marcRecord/hol:bibRecord/@bibId"/>
        <xsl:call-template name="BMDProcessMarcTags">
            <xsl:with-param name="field" select="'084'"/>
            <xsl:with-param name="indicator1" select="'X'"/>
            <xsl:with-param name="indicator2" select="'X'"/>
            <xsl:with-param name="subfield" select="'b'"/>
            <xsl:with-param name="mfhdID" select="$bibID"/>
            <xsl:with-param name="recordType" select="'bib'"/>
        </xsl:call-template>
	</xsl:for-each>
    </xsl:variable>

    <xsl:variable name="QRTitle">
	<xsl:for-each select="$bibRecord">
	<xsl:variable name="bibID" select="/page:page/page:pageBody/page:holdingsCollection/hol:marcRecord/hol:bibRecord/@bibId"/>
        <xsl:call-template name="BMDProcessMarcTags">
            <xsl:with-param name="field" select="'245'"/>
            <xsl:with-param name="indicator1" select="'X'"/>
            <xsl:with-param name="indicator2" select="'X'"/>
            <xsl:with-param name="subfield" select="'a'"/>
            <xsl:with-param name="mfhdID" select="$bibID"/>
            <xsl:with-param name="recordType" select="'bib'"/>
        </xsl:call-template>
	</xsl:for-each>
    </xsl:variable>

    <xsl:variable name="QRAuthor">
	<xsl:for-each select="$bibRecord">
	<xsl:variable name="bibID" select="/page:page/page:pageBody/page:holdingsCollection/hol:marcRecord/hol:bibRecord/@bibId"/>
        <xsl:call-template name="BMDProcessMarcTags">
            <xsl:with-param name="field" select="'100'"/>
            <xsl:with-param name="indicator1" select="'X'"/>
            <xsl:with-param name="indicator2" select="'X'"/>
            <xsl:with-param name="subfield" select="'a'"/>
            <xsl:with-param name="mfhdID" select="$bibID"/>
            <xsl:with-param name="recordType" select="'bib'"/>
        </xsl:call-template>
	</xsl:for-each>
    </xsl:variable>


<!-- ###################################################################### -->

<xsl:template name="buildMarcDisplay">
<xsl:param name="mfhdID"/>
<xsl:param name="recordType"/>

    <xsl:choose>
        <xsl:when test="$recordType='bib'">
            <!-- ## Bibliographic Title ## -->
            <xsl:call-template name="buildTitle">
                <xsl:with-param name="mfhdID" select="$mfhdID"/>
                <xsl:with-param name="recordType" select="$recordType"/>
            </xsl:call-template>

            <!-- ## Bibliographic Cover Image ## -->
            <xsl:for-each select="/display/coverTags">
                <xsl:call-template name="buildCoverImage">
                    <xsl:with-param name="mfhdID" select="$mfhdID"/>
                    <xsl:with-param name="recordType" select="$recordType"/>
                </xsl:call-template>
            </xsl:for-each>

	     <!-- ## Bibliographic Tags ## -->
            <div class="bibTags">
                <h2 class="nav">Bibliographic Record Display</h2>
                <ul title="Bibliographic Record Display">
                    <!-- ## Process Each Section of Display Tags at a time -->
                    <xsl:for-each select="/display/displayTags">
                        <xsl:variable name="displayData">
                            <xsl:call-template name="processDisplayTags">
                                <xsl:with-param name="mfhdID" select="$mfhdID"/>
                                <xsl:with-param name="recordType" select="$recordType"/>
                            </xsl:call-template>
                        </xsl:variable>

                        <xsl:variable name="bibTag">
                            <xsl:call-template name="outputDisplayData">
                                <xsl:with-param name="displayData" select="$displayData"/>
                            </xsl:call-template>
                        </xsl:variable>

                        <xsl:if test="string-length($bibTag)">
                            <xsl:if test="$holdingsJumpBar">
                                <xsl:if test="displayTag/@field='9000'">
                                    <li class="bibTag">
                                        <span class="fieldLabelSpan">
                                            <a name="holdingsJumpBar"/><xsl:value-of select="$holdingsJumpBar/page:element[@nameId='db.holdings.jumpBar.text']/page:label"/>
                                        </span>

                                        <span class="subfieldData">
                                            <xsl:for-each select="$HoldXML/mfhd:mfhdRecord">
                                                <xsl:variable name="mfhdId" select="@mfhdId"/>
                                                <xsl:variable name="dbCode">
                                                    <xsl:for-each select="mfhd:mfhdData[@name='databaseCode']">
                                                        <xsl:variable name="code" select="."/>
                                                        <xsl:value-of select="$dbCodes/page:element[@nameId=$code]/page:value"/>
                                                    </xsl:for-each>
                                                </xsl:variable>
                                                
							<a href="#holdingsJumpBar{$mfhdId}">
                                                    <xsl:choose>
                                                        <xsl:when test="string-length($dbCode)">
                                                            <xsl:value-of select="$dbCode"/>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <xsl:for-each select="mfhd:mfhdData[@name='databaseName']">
                                                                <xsl:if test="string-length(.)">
                                                                    <xsl:value-of select="."/>
                                                                </xsl:if>
                                                            </xsl:for-each>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </a><br/>
                                            </xsl:for-each>
                                        &#160;</span>
                                    </li>
                                </xsl:if>
                            </xsl:if>
                            <li class="bibTag">
                                <xsl:copy-of select="$bibTag"/>
                            </li>
                        </xsl:if>
                    </xsl:for-each>
                </ul>
            </div>
<!--  Syndetics Plus Content and Book Jacket: start --> 
<!--  I've put them at what should be the end of the bibdata display	-->
  <div id="syn_avprofile_link" />
  <div id="syn_summary" /> 
  <div id="syn_avsummary" /> 
  <div id="syn_toc" />  
<!--  Syndetics Plus Content and Book Jacket: end --> 
</xsl:when>

        <xsl:when test="$recordType='mfhd'">
        <!-- ## Holdings Tags ## -->
            <!-- ## Process Each Section of Holdings Tags at a time -->
            <xsl:for-each select="/display/holdingsTags">
                <xsl:variable name="displayData">
                    <xsl:call-template name="processDisplayTags">
                        <xsl:with-param name="mfhdID" select="$mfhdID"/>
                        <xsl:with-param name="recordType" select="$recordType"/>
                    </xsl:call-template>
                </xsl:variable>

                <xsl:variable name="bibTag">
                    <xsl:call-template name="outputDisplayData">
                        <xsl:with-param name="displayData" select="$displayData"/>
                    </xsl:call-template>
                </xsl:variable>

                <xsl:if test="string-length($bibTag)">
                    <li class="bibTag">
                        <xsl:copy-of select="$bibTag"/>
                    </li>
                </xsl:if>
            </xsl:for-each>
        </xsl:when>
    </xsl:choose>
    <br/>
</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="buildCoverImage">
<xsl:param name="mfhdID"/>
<xsl:param name="recordType"/>

   <xsl:for-each select="/display/coverTags">
	<xsl:choose>
		<xsl:when test="contains($VFORMAT,'VIDEO') or contains($VFORMAT,'DVD') or contains($VFORMAT, 'BLU-RAY')">
		<!--<xsl:when test="(string-length($displayData) = 12) and (displayTag/@field='020')">-->
			<xsl:choose>
				<xsl:when test="string-length($ISBN) = 12 or string-length($ISBN) = 13">
					<div class="bibCover">
						<!--<a href="http&#58;&#47;&#47;syndetics.com&#47;index.aspx&#63;isbn={$ISBN}&#47;index.html&amp;client=unifalel&amp;type=rn12">-->
						<img src="http&#58;&#47;&#47;syndetics.com&#47;index.aspx&#63;isbn={$ISBN}&#47;MC.GIF&amp;client=unifalel&amp;upc={$ISBN}"/><!--</a>-->
					</div>
				</xsl:when>
			</xsl:choose>
		</xsl:when>
	<xsl:otherwise>
		<xsl:variable name="displayData">
         		<xsl:call-template name="processDisplayTags">
            			<xsl:with-param name="mfhdID" select="$mfhdID"/>
            			<xsl:with-param name="recordType" select="$recordType"/>
         		</xsl:call-template>
      		</xsl:variable>


         	<xsl:variable name="linkPRE-TEXT">
         	   <xsl:choose>
         	      <xsl:when test="string-length(@linkPRE_TEXT)">
         	         <xsl:value-of select="normalize-space(@linkPRE_TEXT)"/>
         	      </xsl:when>
         	      <xsl:otherwise>    </xsl:otherwise>
         	   </xsl:choose>
         	</xsl:variable>

         	<xsl:variable name="linkPOST-TEXT">
            	 <xsl:choose>
            	   <xsl:when test="string-length(@linkPOST_TEXT)">
            	      <xsl:value-of select="normalize-space(@linkPOST_TEXT)"/>
            	   </xsl:when>
            	   <xsl:otherwise>    </xsl:otherwise>
            	 </xsl:choose>
        	</xsl:variable>

         	<xsl:variable name="altText">
            	 <xsl:choose>
               	<xsl:when test="string-length(@altText)">
               	   <xsl:value-of select="@altText"/>
              	</xsl:when>
               <xsl:otherwise>&#160;</xsl:otherwise>
            	 </xsl:choose>
         	</xsl:variable>

         <xsl:variable name="singleInstance">
            <xsl:choose>
               <xsl:when test="string-length(@singleInstance)">
                  <xsl:value-of select="@singleInstance"/>
               </xsl:when>
               <xsl:otherwise></xsl:otherwise>
            </xsl:choose>
         </xsl:variable>

         <xsl:variable name="infoPRE-TEXT">
            <xsl:choose>
               <xsl:when test="string-length(@infoPRE_TEXT)">
                  <xsl:value-of select="@infoPRE_TEXT"/>
               </xsl:when>
               <xsl:otherwise></xsl:otherwise>
            </xsl:choose>
         </xsl:variable>

         <xsl:variable name="infoPOST-TEXT">
            <xsl:choose>
               <xsl:when test="string-length(@infoPOST_TEXT)">
                  <xsl:value-of select="@infoPOST_TEXT"/>
               </xsl:when>
               <xsl:otherwise></xsl:otherwise>
            </xsl:choose>
         </xsl:variable>

      <xsl:variable name="coverImageLinks">
         <xsl:call-template name="buildCoverImageLinks">
             <xsl:with-param name="preText" select="$linkPRE-TEXT"/>
             <xsl:with-param name="postText" select="$linkPOST-TEXT"/>
             <xsl:with-param name="altText" select="$altText"/>
             <xsl:with-param name="instance" select="$singleInstance"/>
             <xsl:with-param name="preTextInfo" select="$infoPRE-TEXT"/>
             <xsl:with-param name="postTextInfo" select="$infoPOST-TEXT"/>
         </xsl:call-template>
      </xsl:variable>

    <xsl:copy-of select="$coverImageLinks"/>

	</xsl:otherwise>
	</xsl:choose>
   </xsl:for-each>

</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="buildCoverImageLinks">
<xsl:param name="preText"/>
<xsl:param name="postText"/>
<xsl:param name="altText"/>
<xsl:param name="instance" select="'false'"/>
<xsl:param name="preTextInfo"/>
<xsl:param name="postTextInfo"/>

    <xsl:for-each select="displayTag">

        <xsl:variable name="displayTag" select="."/>
        <xsl:variable  name="field" select="@field"/>
        <xsl:variable  name="subfield" select="@subfield"/>

        <div class="bibCover">

            <xsl:choose>
                <xsl:when test="$instance='true'">
                    <xsl:for-each select="$bibRecord/hol:marcRecord/slim:datafield[@tag=$field]">
                        <xsl:if test="position()=1">
                            <xsl:variable name="subfieldData">
                                <xsl:call-template name="BMDDisplaySubfield">
                                    <xsl:with-param name="subfield" select="$subfield"/>
                                    <xsl:with-param name="displayTag" select="$displayTag"/>
                                </xsl:call-template>
                            </xsl:variable>

                            <xsl:if test="string-length($subfieldData)">
                                <xsl:variable name="displayDataNormalize">
                                    <xsl:call-template name="trimData">
                                        <xsl:with-param name="sData">
                                             <xsl:value-of select="normalize-space($subfieldData)"/>
                                        </xsl:with-param>
                                      </xsl:call-template>
                                </xsl:variable>

                                <xsl:choose>
                                    <xsl:when test="string-length($preTextInfo)">
                                        <xsl:choose>
                                            <xsl:when test="string-length($postTextInfo)">
                                                <a href="{$preTextInfo}{$displayDataNormalize}{$postTextInfo}" id="extLink"><img src="{$preText}{$displayDataNormalize}{$postText}" class="recordCoverImage" alt="{$altText}" onload="checkImage(this)"/></a>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <img src="{$preText}{$displayDataNormalize}{$postText}" class="recordCoverImage" alt="{$altText}" onload="checkImage(this)"/>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <img src="{$preText}{$displayDataNormalize}{$postText}" class="recordCoverImage" alt="{$altText}" onload="checkImage(this)"/>
                                    </xsl:otherwise>
                               </xsl:choose>
	
                            </xsl:if>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:for-each select="$bibRecord/hol:marcRecord/slim:datafield[@tag=$field]">
                        <xsl:variable name="subfieldData">
                            <xsl:call-template name="BMDDisplaySubfield">
                                <xsl:with-param name="subfield" select="$subfield"/>
                                <xsl:with-param name="displayTag" select="$displayTag"/>
                            </xsl:call-template>
                        </xsl:variable>

                        <xsl:if test="string-length($subfieldData)">
                            <xsl:variable name="displayDataNormalize">
                                <xsl:call-template name="trimData">
                                    <xsl:with-param name="sData">
                                        <xsl:value-of select="normalize-space($subfieldData)"/>
                                    </xsl:with-param>
                                 </xsl:call-template>
                            </xsl:variable>

                                <xsl:choose>
                                    <xsl:when test="string-length($preTextInfo)">
                                        <xsl:choose>
                                            <xsl:when test="string-length($postTextInfo)">
                                                <a href="{$preTextInfo}{$displayDataNormalize}{$postTextInfo}" id="extLink">
                                                <img src="{$preText}{$displayDataNormalize}{$postText}" class="recordCoverImage" alt="{$altText}" onload="checkImage(this)"/>
                                                </a>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <img src="{$preText}{$displayDataNormalize}{$postText}" class="recordCoverImage" alt="{$altText}" onload="checkImage(this)"/>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <img src="{$preText}{$displayDataNormalize}{$postText}" class="recordCoverImage" alt="{$altText}" onload="checkImage(this)"/>
                                    </xsl:otherwise>
                               </xsl:choose>
                        </xsl:if>

                    </xsl:for-each>
                </xsl:otherwise>
            </xsl:choose>
        </div>

    </xsl:for-each>

</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="buildTitle">
<xsl:param name="mfhdID"/>
<xsl:param name="recordType"/>

    <xsl:for-each select="/display/titleTags">
        <div class="bibTitle">
            <xsl:variable name="displayData">
                <xsl:call-template name="processDisplayTags">
                       <xsl:with-param name="mfhdID" select="$mfhdID"/>
                       <xsl:with-param name="recordType" select="$recordType"/>
                   </xsl:call-template>
            </xsl:variable>

            <p>
                <xsl:copy-of select="$displayData"/>
            </p>

        </div>
    </xsl:for-each>

</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="outputDisplayData">
<xsl:param name="displayData"/>

        <xsl:choose>

          <xsl:when test="(string-length($displayData) = 12) and (displayTag/@field='020')">
                 

                 	 <span class="fieldLabelSpan">UPC:</span>
                   
			<span class="subfieldData">
                    		<xsl:copy-of select="$displayData"/>
			</span>
            </xsl:when>

            <xsl:when test="string-length($displayData) and displayTag/@field='9000'">
                    <div class="holdingsLabel">
                        <xsl:choose>
                            <xsl:when test="string-length(@label)">
                              <!--
                                <xsl:value-of select="@label"/>
                                -->
                                <h3 class="orange_tb"><xsl:value-of select="@label"/></h3>
                            </xsl:when>
                            <xsl:otherwise>
                                &#160;
                            </xsl:otherwise>
                        </xsl:choose>
                    </div>
                    <xsl:copy-of select="$displayData"/>
            </xsl:when>

            <xsl:when test="string-length($displayData) and displayTag/@field='9500'">
                <div class="holdingsSummaryLabel">
                    <xsl:choose>
                        <xsl:when test="string-length(@label)">
                            <h3 class="holdingsSummaryHeading">
                                <xsl:value-of select="@label"/>
                            </h3>
                        </xsl:when>
                        <xsl:otherwise>
                                &#160;
                            </xsl:otherwise>
                    </xsl:choose>
                </div>
                <xsl:copy-of select="$displayData"/>
            </xsl:when>

          <xsl:when test="$displayData='0' and displayTag/@field='1010'">
          </xsl:when>

            <xsl:when test="string-length($displayData)">
                <!--div class="fieldLabel"-->
                    <span class="fieldLabelSpan">
                        <xsl:choose>
                            <xsl:when test="string-length(@label)">
                                <xsl:value-of select="@label"/>
                            </xsl:when>
                            <xsl:otherwise>
                                &#160;
                            </xsl:otherwise>
                        </xsl:choose>
                    </span>
                <!--/div-->
                <!--div class="fieldData"-->
                    <span class="subfieldData"><xsl:copy-of select="$displayData"/></span>
                <!--/div-->
            </xsl:when>

            <xsl:when test="not(string-length($displayData))">
                <xsl:if test="string-length(@notFound)">


                    <!--div class="fieldLabel"-->
                        <span class="fieldLabelSpan">
                            <xsl:choose>
                                <xsl:when test="string-length(@label)">
                                    <xsl:value-of select="@label"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    &#160;
                                </xsl:otherwise>
                            </xsl:choose>
                        </span>
                    <!--/div-->
                    <!--div class="fieldData"-->
                        <span class="subfieldData"><xsl:value-of select="@notFound"/>&#160;</span>
                    <!--/div-->
                </xsl:if>
            </xsl:when>
        </xsl:choose>
</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="processDisplayTags">
<xsl:param name="mfhdID"/>
<xsl:param name="recordType"/>
    <xsl:for-each select="displayTag">

        <xsl:choose>
            <xsl:when test="@field &lt; '1000'">
                <xsl:call-template name="BMDProcessMarcTags">
                    <xsl:with-param name="field" select="@field"/>
                    <xsl:with-param name="indicator1" select="@indicator1"/>
                    <xsl:with-param name="indicator2" select="@indicator2"/>
                    <xsl:with-param name="subfield" select="@subfield"/>
                    <xsl:with-param name="mfhdID" select="$mfhdID"/>
                    <xsl:with-param name="recordType" select="$recordType"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="@field = '1000'">                                    <!-- ## Opac display name for location ## -->
               <xsl:call-template name="BMD1000">
                   <xsl:with-param name="mfhdID" select="$mfhdID"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:when test="@field = '1002'">                                    <!-- ## database name ## -->
               <xsl:call-template name="BMD1002">
                   <xsl:with-param name="mfhdID" select="$mfhdID"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:when test="@field = '1005'">                                    <!-- ## 1005  Location ?? ## -->
                <xsl:call-template name="BMD1005">
                   <xsl:with-param name="mfhdID" select="$mfhdID"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:when test="@field = '1010'">                                    <!-- ## number of items linked to mfhd ## -->
                <xsl:call-template name="BMD1010">
                   <xsl:with-param name="mfhdID" select="$mfhdID"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:when test="@field = '1012'">                                    <!-- ## item status for item record ## -->
                <xsl:call-template name="BMD1012">
                   <xsl:with-param name="mfhdID" select="$mfhdID"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:when test="@field = '1020'">                                    <!-- ## Recent issues from serials ## -->
                <xsl:call-template name="BMD1020">
                   <xsl:with-param name="mfhdID" select="$mfhdID"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:when test="@field = '1021'">                                    <!-- ## Recent issues/xsl ## -->
              <!--  <xsl:call-template name="BMD102X">
                   <xsl:with-param name="mfhdID" select="$mfhdID"/>
                   <xsl:with-param name="iField" select="'1021'"/>
               </xsl:call-template> -->
            </xsl:when>
            <xsl:when test="@field = '1022'">                                    <!-- ## supplements ## -->
                <xsl:call-template name="BMD1022">
                   <xsl:with-param name="mfhdID" select="$mfhdID"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:when test="@field = '1023'">                                    <!-- ## supplements/xsl ## -->
                <!--<xsl:call-template name="BMD102X">
                   <xsl:with-param name="mfhdID" select="$mfhdID"/>
                   <xsl:with-param name="iField" select="'1023'"/>
               </xsl:call-template>-->
            </xsl:when>
            <xsl:when test="@field = '1024'">                                    <!-- ## indexes ## -->
                <xsl:call-template name="BMD1024">
                   <xsl:with-param name="mfhdID" select="$mfhdID"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:when test="@field = '1025'">                                    <!-- ## indexes/xsl ## -->
                <!--<xsl:call-template name="BMD102X">
                   <xsl:with-param name="mfhdID" select="$mfhdID"/>
                   <xsl:with-param name="iField" select="'1025'"/>
               </xsl:call-template>-->
            </xsl:when>
            <xsl:when test="@field = '1030'">                                    <!-- ## Order status  ## -->
                <xsl:call-template name="BMD1030">
                   <xsl:with-param name="mfhdID" select="$mfhdID"/>
               </xsl:call-template>
            </xsl:when>

            <xsl:when test="@field = '1040'">                                    <!-- ## Compressed serials information ## -->
                <xsl:call-template name="BMD104X">
                   <xsl:with-param name="mfhdID" select="$mfhdID"/>
                   <xsl:with-param name="iField" select="'1040'"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:when test="@field = '1042'">                                    <!-- ## Compressed serials information ## -->
                <xsl:call-template name="BMD104X">
                   <xsl:with-param name="mfhdID" select="$mfhdID"/>
                   <xsl:with-param name="iField" select="'1042'"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:when test="@field = '1044'">                                    <!-- ## Compressed serials information ## -->
               <xsl:call-template name="BMD104X">
                   <xsl:with-param name="mfhdID" select="$mfhdID"/>
                   <xsl:with-param name="iField" select="'1044'"/>
               </xsl:call-template>
            </xsl:when>

            <xsl:when test="@field = '1041'">                                    <!-- ## Compressed serials/xsl ## -->
               <xsl:call-template name="BMD104X">
                   <xsl:with-param name="mfhdID" select="$mfhdID"/>
                   <xsl:with-param name="iField" select="'1041'"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:when test="@field = '1043'">                                    <!-- ## Compressed serials/xsl ## -->
               <xsl:call-template name="BMD104X">
                   <xsl:with-param name="mfhdID" select="$mfhdID"/>
                   <xsl:with-param name="iField" select="'1043'"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:when test="@field = '1045'">                                    <!-- ## Compressed serials/xsl ## -->
               <xsl:call-template name="BMD104X">
                   <xsl:with-param name="mfhdID" select="$mfhdID"/>
                   <xsl:with-param name="iField" select="'1045'"/>
               </xsl:call-template>
            </xsl:when>

            <xsl:when test="@field = '1050'">                                    <!-- ## E-item ## -->
                <xsl:call-template name="BMD1050">
                   <xsl:with-param name="mfhdID" select="$mfhdID"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:when test="@field = '2000'">                                    <!-- ## TOC ## -->
                <xsl:call-template name="BMD2000">
                    <xsl:with-param name="mfhdID" select="$mfhdID"/>
                    <xsl:with-param name="recordType" select="$recordType"/>
                </xsl:call-template>
            </xsl:when>

            <xsl:when test="@field = '3000'">                                    <!-- ## 856 links ## -->
                <xsl:choose>
                    <xsl:when test="$recordType='bib'">
                        <xsl:call-template name="BMD3000">
                            <xsl:with-param name="marc" select="$bibRecord/hol:marcRecord"/>
                            <xsl:with-param name="recordType" select="$recordType"/>
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:call-template name="BMD3000">
                            <xsl:with-param name="marc" select="$mfhdRecord[@mfhdId=$mfhdID]/mfhd:marcRecord"/>
                            <xsl:with-param name="recordType" select="''"/>
                        </xsl:call-template>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>

            <xsl:when test="@field = '3500'">                                    <!-- ## 3500 Related Bibs / Linked Records ## -->
                <xsl:call-template name="BMD3500"/>
            </xsl:when>

            <xsl:when test="@field = '3600'">                                    <!-- ## 3600 DPS Related  Linked Records ## -->
                <xsl:call-template name="BMD3600"/>
            </xsl:when>

            <xsl:when test="@field = '4000'">                                    <!-- ## MARC record ## -->
                <xsl:call-template name="BMD4000"/>
            </xsl:when>

            <xsl:when test="@field = '4100'">                                    <!-- ## undocumented/Dublin Core view ## -->

            </xsl:when>

            <xsl:when test="@field = '5000'">                                    <!-- ## Database name ## -->
                <xsl:call-template name="BMD5000"/>
            </xsl:when>
            <!-- ## 6000 6010   Meridian ## -->


            <!-- ## Leader and Control field handling ## -->
            <xsl:when test="@field = '7000'">                                    <!-- ## Primary Material ## -->
                <xsl:call-template name="BMD7000"/>
            </xsl:when>
            <xsl:when test="@field = '7106'">                                    <!-- ## Includes ## -->
                <xsl:call-template name="BMD7106"/>
            </xsl:when>
            <xsl:when test="@field = '7107'">                                    <!-- ## Physical Description ## -->
                <xsl:call-template name="BMD7107"/>
            </xsl:when>


            <xsl:when test="@field = '9000'">                                    <!-- ## Holdings ## -->
                  <xsl:call-template name="BMD9000"/>
            </xsl:when>
            <xsl:when test="@field = '9500'">                                    <!-- ## Holdings summary ## -->
                  <xsl:call-template name="BMD9500"/>
            </xsl:when>

        </xsl:choose>
    </xsl:for-each>

</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="BMDProcessMarcTags">
<xsl:param name="field"/>
<xsl:param name="indicator1"/>
<xsl:param name="indicator2"/>
<xsl:param name="subfield"/>
<xsl:param name="mfhdID"/>
<xsl:param name="recordType"/>

   <xsl:variable name="displayTag" select="."/>

   <xsl:variable name="displayData">

      <xsl:choose>
         <xsl:when test="$recordType='bib'">
            <xsl:for-each select="$bibRecord/hol:marcRecord/slim:datafield[@tag=$field]">
               <xsl:choose>
                  <xsl:when test="($indicator1 = @ind1 or $indicator1 = 'X' or (@ind1 = ' ' and $indicator1 = '|')) and ($indicator2 = @ind2 or $indicator2 = 'X' or (@ind2 = ' ' and $indicator2 = '|'))">

                     <xsl:variable name="subfieldData">
                        <xsl:call-template name="BMDDisplaySubfield">
                           <xsl:with-param name="subfield" select="$subfield"/>
                           <xsl:with-param name="displayTag" select="$displayTag"/>
                        </xsl:call-template>
                     </xsl:variable>

                     <xsl:if test="string-length($subfieldData)"><!--<span class="subfield">-->
                        <xsl:if test="position()>1"><xsl:text> </xsl:text></xsl:if>
                        <xsl:choose>
                           <xsl:when test="string-length($displayTag/@redirect) and string-length($displayTag/@redirectOn)">
                              <xsl:variable name="link">
                                    <xsl:variable name="bibSearchRedirect">
                                        <xsl:value-of select="translate($displayTag/@redirect, $uppercase, $lowercase)">
                                        </xsl:value-of>
                                    </xsl:variable>
                                 <xsl:variable name="redirectSearchCode">
                                    <xsl:choose>
                                       <xsl:when test="$bibSearchRedirect='author'"><xsl:value-of select="$searchTypeAuthor/page:element[@nameId='searchCode']/page:label"/>  </xsl:when>
                                       <xsl:when test="$bibSearchRedirect='callnumber'"> <xsl:value-of select="$searchTypeCallNumber/page:element[@nameId='searchCode']/page:label"/> </xsl:when>
                                       <xsl:when test="$bibSearchRedirect='subject'"><xsl:value-of select="$searchTypeSubject/page:element[@nameId='searchCode']/page:label"/> </xsl:when>
                                       <xsl:when test="$bibSearchRedirect='title'"><xsl:value-of select="$searchTypeTitle/page:element[@nameId='searchCode']/page:label"/> </xsl:when>
                                    </xsl:choose>
                                 </xsl:variable>

                                 <xsl:variable name="redirectSearchType">
                                    <xsl:choose>
                                       <xsl:when test="$bibSearchRedirect='author'"><xsl:value-of select="$searchTypeAuthor/page:element[@nameId='searchType']/page:label"/></xsl:when>
                                       <xsl:when test="$bibSearchRedirect='callnumber'"> <xsl:value-of select="$searchTypeCallNumber/page:element[@nameId='searchType']/page:label"/></xsl:when>
                                       <xsl:when test="$bibSearchRedirect='subject'"><xsl:value-of select="$searchTypeSubject/page:element[@nameId='searchType']/page:label"/></xsl:when>
                                       <xsl:when test="$bibSearchRedirect='title'"><xsl:value-of select="$searchTypeTitle/page:element[@nameId='searchType']/page:label"/></xsl:when>
                                    </xsl:choose>
                                 </xsl:variable>

                                 <xsl:variable name="redirectNonFillingIndicator">
                                    <xsl:choose>
                                       <xsl:when test="$displayTag/@nonFillingIndicator = 'true'">
                                          <xsl:value-of select="$indicator2"/>
                                       </xsl:when>
                                       <xsl:otherwise>1</xsl:otherwise>
                                    </xsl:choose>
                                 </xsl:variable>

                                 <xsl:variable name="redirectSearchData">
                                    <xsl:call-template name="BMDDisplaySubfield">
                                       <xsl:with-param name="subfield" select="$displayTag/@redirectOn"/>
                                    </xsl:call-template>
                                 </xsl:variable>

                                 <!--
                                 xsl:variable name="cleanedRedirectSearchData">
                                    <xsl:value-of select="escape-uri($redirectSearchData, true())"/>
                                    <xsl:value-of select="replace($redirectSearchData, 'a',' WTF')"/>
                                 </xsl:variable
                                 -->

                                 <xsl:variable name="linkData">
                                    <xsl:value-of select="$searchParameter"/><xsl:value-of select="$searchArgParameter"/>=<xsl:value-of select="substring($redirectSearchData,$redirectNonFillingIndicator)"/>&amp;<xsl:value-of select="$searchCodeParameter"/>=<xsl:value-of select="$redirectSearchCode"/>&amp;<xsl:value-of select="$searchTypeParameter"/>=<xsl:value-of select="$redirectSearchType"/>
                                 </xsl:variable>

                                 <xsl:value-of select="normalize-space($linkData)"/>

                              </xsl:variable>

                               <a href="{$link}">
                                   <xsl:if test="string-length($displayTag/@preText)"><xsl:value-of select="$displayTag/@preText"/></xsl:if>
                                   <xsl:copy-of select="$subfieldData"/>
                                   <xsl:if test="string-length($displayTag/@postText)"><xsl:value-of select="$displayTag/@postText"/></xsl:if>
                               </a><br/>

                           </xsl:when>
                           <xsl:otherwise>
                               <xsl:if test="string-length($displayTag/@preText)"><xsl:value-of select="$displayTag/@preText"/></xsl:if>
                               <xsl:copy-of select="$subfieldData"/>
                               <xsl:if test="string-length($displayTag/@postText)"><xsl:value-of select="$displayTag/@postText"/></xsl:if>
                               <br/>
                           </xsl:otherwise>
                        </xsl:choose>
                     <!--/span--></xsl:if>
                  </xsl:when>
               </xsl:choose>
            </xsl:for-each>
         </xsl:when>

         <xsl:when test="$recordType='mfhd'">
            <xsl:for-each select="$HoldXML/mfhd:mfhdRecord[@mfhdId = $mfhdID]/mfhd:marcRecord/slim:datafield[@tag=$field]">
               <xsl:choose>
                  <xsl:when test="($indicator1 = @ind1 or $indicator1 = 'X' or (@ind1 = ' ' and $indicator1 = '|')) and ($indicator2 = @ind2 or $indicator2 = 'X' or (@ind2 = ' ' and $indicator2 = '|'))">

                     <xsl:variable name="subfieldData">
                        <xsl:call-template name="BMDDisplaySubfield">
                           <xsl:with-param name="subfield" select="$subfield"/>
                           <xsl:with-param name="displayTag" select="$displayTag"/>
                        </xsl:call-template>
                     </xsl:variable>

                     <xsl:if test="string-length($subfieldData)"><!--span class="subfieldData"-->
                        <xsl:if test="position()>1"><xsl:text> </xsl:text></xsl:if>
                        <xsl:choose>
                           <xsl:when test="string-length($displayTag/@redirect) and string-length($displayTag/@redirectOn)">
                              <xsl:variable name="link">
                                  <xsl:variable name="mfhdSearchRedirect">
                                        <xsl:value-of select="translate($displayTag/@redirect, $uppercase, $lowercase)">
                                        </xsl:value-of>
                                 </xsl:variable>
                              <xsl:variable name="redirectSearchCode">
                                 <xsl:choose>
                                    <xsl:when test="$mfhdSearchRedirect='callnumber'"> <xsl:value-of select="$searchTypeCallNumber/page:element[@nameId='searchCode']/page:label"/><xsl:value-of select="$browse"/></xsl:when>
                                 </xsl:choose>
                              </xsl:variable>

                              <xsl:variable name="redirectSearchType">
                                 <xsl:choose>
                                    <xsl:when test="$mfhdSearchRedirect='callnumber'"> <xsl:value-of select="$searchTypeCallNumber/page:element[@nameId='searchType']/page:label"/></xsl:when>
                                 </xsl:choose>
                              </xsl:variable>

                                 <xsl:variable name="redirectSearchData">
                                    <xsl:call-template name="BMDDisplaySubfield">
                                       <xsl:with-param name="subfield" select="$displayTag/@redirectOn"/>
                                    </xsl:call-template>
                                 </xsl:variable>

                                 <xsl:variable name="redirectNonFillingIndicator">
                                    <xsl:choose>
                                       <xsl:when test="$displayTag/@nonFillingIndicator = 'true'">
                                          <xsl:value-of select="$indicator2"/>
                                       </xsl:when>
                                       <xsl:otherwise>1</xsl:otherwise>
                                    </xsl:choose>
                                 </xsl:variable>

                                 <xsl:variable name="linkData">
                                    <xsl:value-of select="$searchParameter"/><xsl:value-of select="$searchArgParameter"/>=<xsl:value-of select="substring($redirectSearchData,$redirectNonFillingIndicator)"/>&amp;<xsl:value-of select="$searchCodeParameter"/>=<xsl:value-of select="$redirectSearchCode"/>&amp;<xsl:value-of select="$searchTypeParameter"/>=<xsl:value-of select="$redirectSearchType"/>
                                 </xsl:variable>

                                 <xsl:value-of select="normalize-space($linkData)"/>

                              </xsl:variable>

                              <a href="{$link}">
                                 <xsl:if test="string-length($displayTag/@preText)"><xsl:value-of select="$displayTag/@preText"/></xsl:if>
                                 <xsl:copy-of select="$subfieldData"/>
                                 <xsl:if test="string-length($displayTag/@postText)"><xsl:value-of select="$displayTag/@postText"/></xsl:if>
                              </a><br/>

                           </xsl:when>
                           <xsl:otherwise>
                              <xsl:if test="string-length($displayTag/@preText)"><xsl:value-of select="$displayTag/@preText"/></xsl:if>
                              <xsl:copy-of select="$subfieldData"/>
                              <xsl:if test="string-length($displayTag/@postText)"><xsl:value-of select="$displayTag/@postText"/></xsl:if>
                              <br/>
                           </xsl:otherwise>
                        </xsl:choose>
                     <!--/span--></xsl:if>
                  </xsl:when>
               </xsl:choose>
            </xsl:for-each>
         </xsl:when>
      </xsl:choose>
   </xsl:variable>

   <xsl:if test="string-length($displayData)">
      <xsl:copy-of select="$displayData"/>
   </xsl:if>

</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="BMDDisplaySubfield">
<xsl:param name="subfield"/>
<xsl:param name="displayTag"/>

<xsl:for-each select="slim:subfield">
   <xsl:choose>
      <xsl:when test="contains($subfield,@code)">
         <xsl:variable name="subfieldCode">
            <xsl:value-of select="@code"/>
         </xsl:variable>
         <xsl:variable name="subfieldPreText">
            <xsl:if test="$displayTag"><xsl:value-of select="$displayTag/subfield[@value=$subfieldCode]/@preText"/></xsl:if>
         </xsl:variable>
         <xsl:variable name="subfieldPostText">
            <xsl:if test="$displayTag"><xsl:value-of select="$displayTag/subfield[@value=$subfieldCode]/@postText"/></xsl:if>
         </xsl:variable>

         <!--xsl:value-of select="$subfieldPreText"/-->
         <xsl:choose>
            <xsl:when test="string-length($subfieldPreText)">
               <xsl:value-of select="$subfieldPreText"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:if test="position()>1"><xsl:text> </xsl:text></xsl:if>
            </xsl:otherwise>
         </xsl:choose>

         <xsl:value-of select="."/>

         <xsl:value-of select="$subfieldPostText"/>

      </xsl:when>
   </xsl:choose>
</xsl:for-each>

</xsl:template>
<!-- ###################################################################### -->

<!-- <xsl:template name="BMD1000">
<xsl:param name="mfhdID"/>

    <xsl:for-each select="$HoldXML/mfhd:mfhdRecord[@mfhdId = $mfhdID]/mfhd:mfhdData[@name='locationDisplayName']">
        <xsl:if test="string-length(.)">
            <xsl:value-of select="."/><br/>
        </xsl:if>
    </xsl:for-each>
</xsl:template> -->

<xsl:template name="BMD1000">
<xsl:param name="mfhdID"/>

    <xsl:for-each select="$HoldXML/mfhd:mfhdRecord[@mfhdId = $mfhdID]/mfhd:mfhdData[@name='locationDisplayName']">
    
	<xsl:variable name="locCode">
	 <xsl:value-of select="$HoldXML/mfhd:mfhdRecord[@mfhdId = $mfhdID]/mfhd:mfhdData[@name='locationCode']"/>
	</xsl:variable>
	
	<xsl:if test="$locCode = 'L-WJOURN'">
            <a href="http://voyager.falmouth.ac.uk/vwebv/patronRequest?requestCode=WAREJOURN&amp;requestSiteId=1@FOACDB20030724153201&amp;bibId={$bibID}&amp;bibDbCode=LOCAL&amp;bibDbName=Falmouth%20&amp;recCount=10&amp;recPointer=0&amp;searchType=1">Request Warehouse Journal</a><br/>
        </xsl:if>

        <xsl:if test="string-length(.)">
            <xsl:value-of select="."/><br/>
        </xsl:if>
    </xsl:for-each>
</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="BMD1002">
<xsl:param name="mfhdID"/>

    <xsl:for-each select="$HoldXML/mfhd:mfhdRecord[@mfhdId = $mfhdID]">
        <xsl:variable name="dbCode">
            <xsl:for-each select="mfhd:mfhdData[@name='databaseCode']">
            <xsl:variable name="code" select="."/>
            <xsl:value-of select="$dbCodes/page:element[@nameId=$code]/page:value"/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="string-length($dbCode)">
                <xsl:value-of select="$dbCode"/><br/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:for-each select="mfhd:mfhdData[@name='databaseName']">
                    <xsl:if test="string-length(.)">
                        <xsl:value-of select="."/><br/>
                    </xsl:if>
                </xsl:for-each>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:for-each>
</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="BMD1005">
<xsl:param name="mfhdID"/>

    <xsl:for-each select="$HoldXML/mfhd:mfhdRecord[@mfhdId = $mfhdID]/mfhd:itemCollection/item:itemLocation">
        <xsl:if test="string-length(item:itemLocationData[@name='tempLocation'])">
            <!-- ## 1st one is always the mfhd ## -->
            <xsl:if test="not(position() = 1)">

                <xsl:if test="string-length(item:itemLocationData[@name='itemEnum'])">
                    <xsl:value-of select="item:itemLocationData[@name='itemEnum']"/>&#160;
                </xsl:if>
                <xsl:if test="string-length(item:itemLocationData[@name='itemChron'])">
                    <xsl:value-of select="item:itemLocationData[@name='itemChron']"/>&#160;
                </xsl:if>
                <xsl:if test="string-length(item:itemLocationData[@name='itemYear'])">
                    <xsl:value-of select="item:itemLocationData[@name='itemYear']"/>&#160;
                </xsl:if>
                <xsl:if test="string-length(item:itemLocationData[@name='itemCaption'])">
                    <xsl:value-of select="item:itemLocationData[@name='itemCaption']"/>&#160;
                </xsl:if>
                <xsl:if test="string-length(item:itemLocationData[@name='itemFreeText'])">
                    <xsl:value-of select="item:itemLocationData[@name='itemFreeText']"/>&#160;
                </xsl:if>
                <xsl:if test="string-length(item:itemLocationData[@name='itemCopyNumber'])">
                    c.<xsl:value-of select="item:itemLocationData[@name='itemCopyNumber']"/>&#160;
                </xsl:if>

                <xsl:value-of select="item:itemLocationData[@name='tempLocation']"/><br/>
            </xsl:if>
        </xsl:if>
    </xsl:for-each>
</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="BMD1010">
<xsl:param name="mfhdID"/>
    <xsl:for-each select="$HoldXML/mfhd:mfhdRecord[@mfhdId = $mfhdID]/mfhd:itemCollection">
        <xsl:if test="string-length(item:itemCount)">
            <xsl:value-of select="item:itemCount"/><br/>
        </xsl:if>
    </xsl:for-each>
</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="BMD1012">
<xsl:param name="mfhdID"/>
    <xsl:for-each select="$HoldXML/mfhd:mfhdRecord[@mfhdId = $mfhdID]/mfhd:itemCollection/item:itemRecord">
        <xsl:if test="string-length(item:itemData[@name='displayStatus'])">
            <xsl:value-of select="item:itemData[@name='displayStatus']"/><br/>
        </xsl:if>
    </xsl:for-each>
</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="BMD102X">
<xsl:param name="mfhdID"/>
<xsl:param name="iField"/>

   <xsl:variable name="compressedData">
       <xsl:for-each select="$HoldXML/mfhd:mfhdRecord[@mfhdId = $mfhdID]/mfhd:serialsSubscriptions">
         <xsl:choose>
            <xsl:when test="$iField='1020'"><xsl:call-template name="BMD1020"/></xsl:when>
            <xsl:when test="$iField='1021'">
                <xsl:call-template name="displaySubscription">
                    <xsl:with-param name="subscription" select="mfhd:subscription"/>
                    <xsl:with-param name="componentTypeFilter" select="'Basic'"></xsl:with-param>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="$iField='1022'"><xsl:call-template name="BMD1022"/></xsl:when>
            <xsl:when test="$iField='1023'">
                <xsl:call-template name="displaySubscription">
                    <xsl:with-param name="subscription" select="mfhd:subscription"/>
                    <xsl:with-param name="componentTypeFilter" select="'Supplement'"></xsl:with-param>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="$iField='1024'"><xsl:call-template name="BMD1024"/></xsl:when>
            <xsl:when test="$iField='1025'">
                <xsl:call-template name="displaySubscription">
                    <xsl:with-param name="subscription" select="mfhd:subscription"/>
                    <xsl:with-param name="componentTypeFilter" select="'Index'"></xsl:with-param>
                </xsl:call-template>
            </xsl:when>
         </xsl:choose>
       </xsl:for-each>
   </xsl:variable>

    <xsl:if test="string-length($compressedData)">
           <xsl:copy-of select="$compressedData"/><br/>
   </xsl:if>

</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="BMD1020">
<xsl:param name="mfhdID"/>
    <xsl:for-each select="$HoldXML/mfhd:mfhdRecord[@mfhdId = $mfhdID]/mfhd:serialsCheckIn/mfhd:recent">
        <xsl:for-each select="mfhd:enumChron">
            <xsl:value-of select="."/><br/>
        </xsl:for-each>
    </xsl:for-each>
</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="BMD1022">
<xsl:param name="mfhdID"/>
    <xsl:for-each select="$HoldXML/mfhd:mfhdRecord[@mfhdId = $mfhdID]/mfhd:serialsCheckIn/mfhd:supplements">
        <xsl:for-each select="mfhd:enumChron">
            <xsl:value-of select="."/><br/>
        </xsl:for-each>
    </xsl:for-each>
</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="BMD1024">
<xsl:param name="mfhdID"/>
    <xsl:for-each select="$HoldXML/mfhd:mfhdRecord[@mfhdId = $mfhdID]/mfhd:serialsCheckIn/mfhd:indexes">
        <xsl:for-each select="mfhd:enumChron">
            <xsl:value-of select="."/><br/>
        </xsl:for-each>
    </xsl:for-each>
</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="BMD1030">
<xsl:param name="mfhdID"/>
    <xsl:for-each select="$HoldXML/mfhd:mfhdRecord[@mfhdId = $mfhdID]/mfhd:poLineItems">
        <xsl:for-each select="$lineItemStatus/page:element[page:label = $mfhdID]">
            <xsl:for-each select="../page:element[@nameId='holdingsInfo.lineItemStatus.status']">
            <xsl:value-of  select="page:label"/><br/>
            </xsl:for-each>
        </xsl:for-each>
    </xsl:for-each>
</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="BMD104X">
<xsl:param name="mfhdID"/>
<xsl:param name="iField"/>

   <xsl:variable name="compressedData">
       <xsl:for-each select="$HoldXML/mfhd:mfhdRecord[@mfhdId = $mfhdID]/mfhd:marcRecord">
         <xsl:choose>
            <xsl:when test="$iField='1040'"><xsl:call-template name="display1041"/></xsl:when>
            <xsl:when test="$iField='1041'"><xsl:call-template name="display1041"/></xsl:when>
            <xsl:when test="$iField='1042'"><xsl:call-template name="display1043"/></xsl:when>
            <xsl:when test="$iField='1043'"><xsl:call-template name="display1043"/></xsl:when>
            <xsl:when test="$iField='1044'"><xsl:call-template name="display1045"/></xsl:when>
            <xsl:when test="$iField='1045'"><xsl:call-template name="display1045"/></xsl:when>
         </xsl:choose>
       </xsl:for-each>
   </xsl:variable>

    <xsl:if test="string-length($compressedData)">
           <xsl:copy-of select="$compressedData"/><br/>
   </xsl:if>

</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="BMD1050">
<xsl:param name="mfhdID"/>
    <xsl:for-each select="$HoldXML/mfhd:mfhdRecord[@mfhdId = $mfhdID]/mfhd:eItems">
        <xsl:if test="string-length(mfhd:eItem)">
                <xsl:for-each select="mfhd:eItem">
                    <xsl:if test="string-length(mfhd:link)">
                        <xsl:if test="not(position() = 1)">
                            <br/>
                        </xsl:if>
                        <a href="{mfhd:link}"><xsl:value-of select="mfhd:caption"/></a><xsl:value-of select="mfhd:enum"/> <xsl:value-of select="mfhd:chron"/> <xsl:value-of select="mfhd:year"/>
                    </xsl:if>
                </xsl:for-each>
        </xsl:if>
    </xsl:for-each>
</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="BMD2000">
<xsl:param name="mfhdID"/>
<xsl:param name="recordType"/>

    <xsl:variable name="tocData">
        <xsl:call-template name="BMDProcessMarcTags">
            <xsl:with-param name="field" select="'505'"/>
            <xsl:with-param name="indicator1" select="'X'"/>
            <xsl:with-param name="indicator2" select="'X'"/>
            <xsl:with-param name="subfield" select="'atrg'"/>
            <xsl:with-param name="mfhdID" select="$mfhdID"/>
            <xsl:with-param name="recordType" select="$recordType"/>
        </xsl:call-template>
    </xsl:variable>


    <xsl:variable name="tocDataWithBreaks">
        <xsl:call-template name="replaceStringWithBreak">
            <xsl:with-param name="string" select="$tocData"/>
            <xsl:with-param name="target" select="'--'"/>
        </xsl:call-template>
    </xsl:variable>

   <xsl:if test="$tocDataWithBreaks">
      <xsl:copy-of select="$tocDataWithBreaks"/>
   </xsl:if>

</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="replaceStringWithBreak">
<xsl:param name="string"/>
<xsl:param name="target"/>

    <xsl:choose>
        <xsl:when test="contains($string, $target)">
            <xsl:variable name="output">
                <xsl:copy-of select="substring-before($string, $target)"/>
            </xsl:variable>
            <xsl:variable name="outputAfter">
                <xsl:copy-of select="substring-after($string, $target)"/>
            </xsl:variable>

            <xsl:copy-of select="$output"/><br/>

            <xsl:choose>
                <xsl:when test="contains($outputAfter, $target)">
                    <xsl:variable name="outputAfterWithBreaks">
                        <xsl:call-template name="replaceStringWithBreak">
                            <xsl:with-param name="string" select="$outputAfter"/>
                            <xsl:with-param name="target" select="$target"/>
                        </xsl:call-template>
                    </xsl:variable>
                    <xsl:copy-of select="$outputAfterWithBreaks"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:copy-of select="$outputAfter"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:when>

        <xsl:otherwise>
            <xsl:copy-of select="$string"/>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="replaceString">

<xsl:param name="string"/>
<xsl:param name="target"/>
<xsl:param name="replacement"/>

    <xsl:choose>
        <xsl:when test="contains($string, $target)">
            <xsl:variable name="output">
                <xsl:copy-of select="substring-before($string, $target)"/>
                <xsl:copy-of select="$replacement"/>
                <xsl:copy-of select="substring-after($string, $target)"/>
            </xsl:variable>

            <xsl:if test="contains($output, $target)">

            </xsl:if>

            <xsl:copy-of select="$output"/>
        </xsl:when>
        <xsl:otherwise>
            <xsl:copy-of select="$string"/>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<!-- ###################################################################### -->

<xsl:template match="*" mode="nsStrip">
  <xsl:element name="{name()}" namespace="{namespace-uri()}">
    <xsl:copy-of select="@*"/>
    <xsl:apply-templates/>
  </xsl:element>
</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="BMD3000">
<xsl:param name="marc"/>
<xsl:param name="recordType"/>

  <xsl:variable name="exeurl">
            <xsl:for-each select="$bibRecord/hol:marcRecord/slim:datafield[@tag='856']/slim:subfield[@code='u']">
                <xsl:if test="contains(., 'exeter.ac.uk')">
                <xsl:value-of select="'TRUE'"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>

  <xsl:variable name="sfxurl">
            <xsl:for-each select="$bibRecord/hol:marcRecord/slim:datafield[@tag='856']/slim:subfield[@code='u']">
                <xsl:if test="contains(., 'sfxhosted.exlibrisgroup.com')">
                <xsl:value-of select="'TRUE'"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>

  <xsl:variable name="ISSN">
      <xsl:call-template name="trimData">
         <xsl:with-param name="sData">
            <xsl:call-template name="BMDProcessMarcTags">
               <xsl:with-param name="field" select="'022'"/>
               <xsl:with-param name="indicator1" select="'X'"/>
               <xsl:with-param name="indicator2" select="'X'"/>
               <xsl:with-param name="subfield" select="'a'"/>
               <xsl:with-param name="mfhdID" select="$bibID"/>
               <xsl:with-param name="recordType" select="'bib'"/>
            </xsl:call-template>
          </xsl:with-param>
       </xsl:call-template>
	</xsl:variable>

   <xsl:variable name="OWNER">
	<xsl:for-each select="$HoldXML/mfhd:mfhdRecord">
	<xsl:variable name="mfhdID" select="@mfhdId"/>
        <xsl:call-template name="BMDProcessMarcTags">
            <xsl:with-param name="field" select="'561'"/>
            <xsl:with-param name="indicator1" select="'X'"/>
            <xsl:with-param name="indicator2" select="'X'"/>
            <xsl:with-param name="subfield" select="'a'"/>
            <xsl:with-param name="mfhdID" select="$mfhdID"/>
            <xsl:with-param name="recordType" select="'mfhd'"/>
        </xsl:call-template>
	</xsl:for-each>
    </xsl:variable>
    
	<xsl:for-each select="$marc/slim:datafield[@tag='856']">
        <xsl:choose>
            <!--
               ## This will handle the case of multiple subfield u's.
               ## We wont however try and match up and notes to them,
               ## or do any other logic for that matter
            -->
            <xsl:when test="count(slim:subfield[@code='u']) &gt; 1">
                <xsl:for-each select="slim:subfield[@code='u']">
                    <xsl:if test="contains(translate(., $lowercase, $uppercase), 'HTTP:') or
                                 contains(translate(., $lowercase, $uppercase), 'HTTPS:') or
                                 contains(translate(., $lowercase, $uppercase), 'MAILTO') or
                                 contains(translate(., $lowercase, $uppercase), 'FTP')">
                        <a href="{.}">
                            <xsl:value-of select="."/>
                        </a>&#160;<br/>
                    </xsl:if>
                </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="note">
                    <xsl:choose>
                        <xsl:when test="slim:subfield[@code='3']">
                            <xsl:value-of select="slim:subfield[@code='3']"/>
                            <xsl:if test="slim:subfield[@code='z']">
                                &#160;<xsl:copy-of select="slim:subfield[@code='z']"/>
                            </xsl:if>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:choose>
                                <xsl:when test="slim:subfield[@code='y']">
                                    <xsl:value-of select="slim:subfield[@code='y']"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:if test="slim:subfield[@code='z']">
                                    <xsl:copy-of select="slim:subfield[@code='z']"/>
                                    <!--
                                    <xsl:apply-templates select="slim:subfield[@code='z']/text()" mode="nsStrip"/>

                                        <xsl:value-of select="subfield[@code='z']"/>

                                        <xsl:copy-of select="slim:subfield[@code='z']"/>
                                        -->
                                    </xsl:if>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>

                <!-- Image Server link is only valid for bib data not MFHD data -->
                <xsl:variable name="sdc">
                   <xsl:if test="$recordType='bib'">
                     <xsl:for-each select="slim:subfield[@code='2']">
                          <xsl:value-of select="."/>
                     </xsl:for-each>
                   </xsl:if>
                </xsl:variable>
                <xsl:variable name="imageServerLink">
                   <xsl:if test="$recordType='bib'">
                    <xsl:if test="string-length($sdc)>0 and translate($sdc,$lowercase,$uppercase)='SDC'">
                        <xsl:for-each select="slim:subfield[@code='f']">
                                <xsl:value-of select="."/>
                        </xsl:for-each>
                    </xsl:if>
                   </xsl:if>
                </xsl:variable>

                <xsl:variable name="url">
                    <xsl:for-each select="slim:subfield[@code='u']">
                        <xsl:if test="contains(translate(., $lowercase, $uppercase), 'HTTP:') or
                                     contains(translate(., $lowercase, $uppercase), 'HTTPS:') or
                                     contains(translate(., $lowercase, $uppercase), 'MAILTO') or
                                     contains(translate(., $lowercase, $uppercase), 'FTP')">
                            <xsl:value-of select="."/>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:variable>

                <xsl:variable name="doi">
                    <xsl:for-each select="slim:subfield[@code='u']">
                        <xsl:if test="contains(translate(., $lowercase, $uppercase), 'DOI:') or
                                                      contains(translate(., $lowercase, $uppercase), 'URN:')">
                            <xsl:value-of select="."/>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:variable>

                <xsl:variable name="doi2">
                    <xsl:if test="string-length($doi)=0">
                        <xsl:if test="./slim:subfield[@code='g']">
                            <xsl:value-of select="./slim:subfield[@code='g']"/>
                        </xsl:if>
                    </xsl:if>
                </xsl:variable>

                <xsl:variable name="doi2note">
                    <xsl:if test="string-length($doi2)>0">
                        <xsl:if test="./slim:subfield[@code='z']">
                            <xsl:value-of select="./slim:subfield[@code='z']"/>
                        </xsl:if>
                    </xsl:if>
                </xsl:variable>

                <xsl:variable name="link">
                    <xsl:choose>
                        <xsl:when test="string-length($url)>0">
                            <xsl:value-of select="$url"/>
                        </xsl:when>
                        <xsl:when test="string-length($doi)>0">
                            <xsl:value-of select="$doi"/>
                        </xsl:when>
                        <xsl:when test="string-length($doi2)>0">
                            <xsl:value-of select="$doi2"/>
                        </xsl:when>
                        <xsl:when test="string-length($imageServerLink)>0">
                            <xsl:value-of select="$imageServerLink"/>
                        </xsl:when>
                    </xsl:choose>
                </xsl:variable>

                <!-- ## Replace the URN and DOI link with the string user defined in webvoyage.properties file ## -->
                <!-- ## Some BIB record may have both URN: and DOI: string and would render invalid link       ## -->
                <xsl:variable name="newLink1">
                    <xsl:if test="string-length($link)>0">
                        <xsl:choose>
                            <xsl:when test="(contains($link, 'URN:'))">
                                <xsl:variable name="replacedLink1">
                                    <xsl:call-template name="replaceString">
                                        <xsl:with-param name="string" select="$link"/>
                                        <xsl:with-param name="target" select="'URN:'"/>
                                        <xsl:with-param name="replacement" select="$urnLink"/>
                                       </xsl:call-template>
                                    </xsl:variable>
                                <xsl:copy-of select="$replacedLink1" />
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:copy-of select="$link"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:if>
                </xsl:variable>

                <xsl:variable name="newLink2">
                    <xsl:if test="string-length($newLink1)>0">
                        <xsl:choose>
                            <xsl:when test="(contains($newLink1, 'DOI:'))">
                                <xsl:variable name="replacedLink2">
                                    <xsl:call-template name="replaceString">
                                        <xsl:with-param name="string" select="$newLink1"/>
                                        <xsl:with-param name="target" select="'DOI:'"/>
                                        <xsl:with-param name="replacement" select="$doiLink"/>
                                       </xsl:call-template>
                                    </xsl:variable>
                                <xsl:copy-of select="$replacedLink2" />
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:copy-of select="$newLink1"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:if>
                </xsl:variable>

                <xsl:if test="string-length($newLink2)>0">
                    <a href="{$newLink2}">
                        <xsl:choose>
                            <xsl:when test="string-length($note)>0">
				<!-- JAMIE - 13/05/2013 - added code below to display play icon for streaming video 856 links rather than text link -->
				<!-- NOTE: the dot after the image is only way I got to get it working for all entries - else single 856 wont show -->
					<!--<xsl:value-of select="$note" disable-output-escaping="yes"/>-->
					<xsl:choose>
						<xsl:when test="(contains($note, 'Click here to watch'))">
							<img src="{$image-loc}playButton5.png" title="Click to watch"/>.
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$note" disable-output-escaping="yes"/>
						</xsl:otherwise>
					</xsl:choose>
                            </xsl:when>
                            <xsl:when test="string-length($doi2note)>0">
                                <xsl:copy-of select="$doi2note"/>
                            </xsl:when>
                            <xsl:otherwise>
					<xsl:copy-of select="$link"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </a>
                    <br/>
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
	</xsl:for-each>
	<xsl:if test="string-length($ISSN) and not(($exeurl = 'TRUE') or ($sfxurl = 'TRUE') or (contains($OWNER, 'Exeter journal')))">
		<a href="http://sfxhosted.exlibrisgroup.com/falmouth?sfx.ignore_date_threshold=1&amp;ctx_ver=Z39.88-2004&amp;rfr_id=info:sid/sfxit.com:kbmanager&amp;rft.issn={$ISSN}">Check availability of full text (Falmouth)</a>
	</xsl:if>

</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="BMD3500">

   <xsl:for-each select="$relatedBibs">

      <xsl:for-each select="page:element">

         <xsl:choose>
            <xsl:when test="page:element/page:URL">
               <xsl:if test="position() &gt; 1">
                  <br/>
               </xsl:if>
               <xsl:if test="string-length(page:element/page:preText)">
                  <span class="relatedBibsPreText">
                     <xsl:value-of select="page:element/page:preText"/>
                  </span>
               </xsl:if>
               <a href="{page:element/page:URL}">
                  <xsl:choose>
                     <xsl:when test="string-length(page:element/page:linkText)">
                        <xsl:value-of select="page:element/page:linkText"/>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:value-of select="$relatedBibs/page:label"/>
                     </xsl:otherwise>
                  </xsl:choose>
               </a>
               <xsl:if test="string-length(page:element/page:postText)">
                  <span class="relatedBibsPostText">
                     <xsl:value-of select="page:element/page:postText"/>
                  </span>
               </xsl:if>
            </xsl:when>
            <xsl:otherwise>
		<!-- WSP UCF added fix to omit links to the same record in related bibs list -->
		<xsl:variable name="relbibID" select="$relatedBibs/page:label/page:element/page:element[@nameId]"/>
		<xsl:choose>
		<xsl:when test="$relbibID=$bibID">
		</xsl:when>
		<xsl:otherwise>
               <table id="relatedRecordsTable" cellspacing="0" >
                  <caption><xsl:value-of select="$relatedBibs/page:label"/></caption>
                  <thead>
                     <xsl:for-each select="page:element[@nameId='holdingsInfo.relatedRecords.heading']">
                        <tr>
                           <xsl:for-each select="page:element">
                              <th id="col_{position()}"><xsl:value-of select="page:label"/></th>
                           </xsl:for-each>
                        </tr>
                     </xsl:for-each>
                  </thead>
                  <tbody>
                     <xsl:for-each select="page:element[@nameId='holdingsInfo.relatedRecords.contents']">
                        <xsl:for-each select="page:element">
				<xsl:variable name="rbibID" select="@nameId"/>
				<xsl:if test="$rbibID!=$bibID">
                           <tr>
                              <xsl:for-each select="page:element">
                                 <td headers="col_{position()}">
                                    <xsl:choose>
                                       <xsl:when test="page:URL">
                                          <a href="{page:URL}">
                                             <xsl:choose>
                                                <xsl:when test="string-length(page:linkText)">
                                                   <xsl:value-of select="page:linkText"/>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                   <xsl:value-of select="page:label"/>
                                                </xsl:otherwise>
                                             </xsl:choose>
                                          </a>
                                       </xsl:when>
                                       <xsl:otherwise>
                                          <xsl:value-of select="page:label"/>
                                       </xsl:otherwise>
                                    </xsl:choose>
                                 </td>
                              </xsl:for-each>
                           </tr>
				</xsl:if>
                        </xsl:for-each>
                     </xsl:for-each>
                  </tbody>
               </table>
		</xsl:otherwise>
		</xsl:choose>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:for-each>
   </xsl:for-each>




</xsl:template>
<!-- ###################################################################### -->

<xsl:template name="BMD3600">
  <xsl:for-each select="$dpsLink">
        <div class="dpsLink">
              <xsl:for-each select="page:element[@nameId='holdingsInfo.DPSLinkText']">
                   <div class="dpsLinkText">
                         <a href="{page:URL}"><xsl:value-of select="page:linkText"/></a>
                   </div>
              </xsl:for-each>
        </div>
   </xsl:for-each>
</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="BMD4000">
    <xsl:for-each select="$bibRecord">
  <xsl:call-template name="buildMarcRecord"/><br/>
    </xsl:for-each>
</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="BMD5000">
    <xsl:for-each select="$bibRecord/hol:bibData[@name='databaseName']">
        <xsl:if test="string-length(.)">
            <xsl:value-of select="."/><br/>
        </xsl:if>
    </xsl:for-each>
</xsl:template>

<!-- ###################### -->
<!-- ## Primary Material ## -->
<!-- ###################################################################### -->

<xsl:template name="BMD7000">

   <xsl:variable name="primaryMaterial" select="substring($bibRecord/hol:marcRecord/slim:leader,7,2)"/>

   <xsl:choose>
      <xsl:when test="string-length($bibFormats/bibFormat[@type=$primaryMaterial])">
         <xsl:value-of select="$bibFormats/bibFormat[@type=$primaryMaterial]"/>
      </xsl:when>
      <xsl:otherwise>
         <xsl:value-of select="$primaryMaterial"/>
      </xsl:otherwise>
   </xsl:choose>

</xsl:template>

<!-- ############## -->
<!-- ## Includes ## -->
<!-- ###################################################################### -->

<xsl:template name="BMD7106">

   <xsl:variable name="cfdata" select="substring($bibRecord/hol:marcRecord/slim:controlfield[@tag='006'],1,1)"/>

   <xsl:choose>
      <xsl:when test="string-length($Configs/pageConfigs/formMaterial/format[@type=$cfdata])">
         <xsl:value-of select="$Configs/pageConfigs/formMaterial/format[@type=$cfdata]"/>
      </xsl:when>
      <xsl:otherwise>
         <xsl:value-of select="$cfdata"/>
      </xsl:otherwise>
   </xsl:choose>
</xsl:template>

<!-- ########################## -->
<!-- ## Physical Description ## -->
<!-- ###################################################################### -->

<xsl:template name="BMD7107">

   <!-- ## use one byte compare ##
   <xsl:variable name="cfdata" select="substring($bibRecord/hol:marcRecord/slim:controlfield[@tag='007'],1,1)"/>
   -->
   <!-- ## use two byte compare ## -->
   <xsl:variable name="cfdata" select="substring($bibRecord/hol:marcRecord/slim:controlfield[@tag='007'],1,2)"/>

   <xsl:choose>
      <xsl:when test="string-length($Configs/pageConfigs/physicalDescription/format[@type=$cfdata])">
         <xsl:value-of select="$Configs/pageConfigs/physicalDescription/format[@type=$cfdata]"/>
      </xsl:when>
      <xsl:otherwise>
         <xsl:value-of select="$cfdata"/>
      </xsl:otherwise>
   </xsl:choose>

</xsl:template>

<!-- ############## -->
<!-- ## Holdings ## -->
<!-- ###################################################################### -->

<xsl:template name="BMD9000">

    <xsl:variable name="holdingsData">
        <xsl:for-each select="$HoldXML/mfhd:mfhdRecord">

            <xsl:variable name="mfhdId" select="@mfhdId"/>

            <!-- ## variable used for alternating color ## -->
            <xsl:variable name="classPosition">
                <xsl:choose>
                    <xsl:when test="(position() mod 2) = 0">evenHoldingsRow</xsl:when>
                    <xsl:otherwise>oddHoldingsRow</xsl:otherwise>
                </xsl:choose>
            </xsl:variable>

            <xsl:for-each select="$holdingsConfig">
                <div class="displayHoldings" >
                    <div class="{$classPosition}">
                        <a name="holdingsJumpBar{$mfhdId}"/>
                        <xsl:call-template name="buildMarcDisplay">
                            <xsl:with-param name="mfhdID" select="$mfhdId"/>
                            <xsl:with-param name="recordType" select="'mfhd'"/>
                        </xsl:call-template>
                        <xsl:if test="$holdingsJumpBar">
                            <a href="#holdingsJumpBar"><xsl:value-of select="$holdingsJumpBar/page:element[@nameId='db.holdings.jumpBar.back']/page:label"/></a><br/>
                        </xsl:if>
                    </div>
                </div>
            </xsl:for-each>
        </xsl:for-each>
    </xsl:variable>

    <xsl:if test="string-length($holdingsData)">
        <h2 class="nav">Holdings Record Display</h2>
        <ul title="Holdings Record Display">
            <div class="holdingsArea">
                <xsl:copy-of select="$holdingsData"/>
                <div class="holdingsBottom">&#160;</div>
            </div>
        </ul>
    </xsl:if>

</xsl:template>

<!-- ###################### -->
<!-- ## Holdings summary ## -->
<!-- ###################################################################### -->

<xsl:template name="BMD9500">

    <xsl:variable name="holdingsData">

    <xsl:if test="$HoldXML/mfhd:mfhdRecord/mfhd:itemCollection/item:itemRecord">

            <table class="searchHistoryTable" cellspacing="0" summary="This table displays the search history.">
                <!--caption><xsl:value-of select="$searchStatusCaption"/></caption-->
                <!--table caption needed ##-->
                <tbody>
                    <tr>
                        <th id="headerStatus" class="tableCellHeading"><xsl:value-of select="$itemStatus"/>&#160;&#160;</th>
                        <th id="headerCallNumber" class="tableCellHeading"><xsl:value-of select="$itemCallNumber"/>&#160;&#160;</th>
                        <th id="headerLocation" class="tableCellHeading"><xsl:value-of select="$itemLocation"/>&#160;&#160;</th>
                    </tr>

                <xsl:for-each select="$HoldXML/mfhd:mfhdRecord/mfhd:itemCollection/item:itemRecord">



                        <xsl:variable name="callNumber" select="../../mfhd:mfhdData[@name='callNumber']"/>

                        <xsl:variable name="classPosition">
                            <xsl:choose>
                                <xsl:when test="(position() mod 2) = 0">evenHoldingsRow</xsl:when>
                                <xsl:otherwise>oddHoldingsRow</xsl:otherwise>
                            </xsl:choose>
                        </xsl:variable>

                        <tr class="{$classPosition}">

                <xsl:variable name="statusCode"><xsl:value-of select="item:itemData[@name='statusCode']"/></xsl:variable>

                <td headers="headerStatus" >
                    <xsl:value-of  select="$itemStatusCodes/page:element[page:value = $statusCode]/page:label"/>
                </td>

                            <td headers="headerCallNumber" >
                                <xsl:value-of select="$callNumber"/>&#160;&#160;
                            </td>
                            <td headers="headerLocation" >
                                <xsl:for-each select="../../mfhd:mfhdData[@name='locationDisplayName']">
                                    <xsl:if test="string-length(.)">
                                        <xsl:value-of select="."/>
                                        <br/>
                                    </xsl:if>
                                </xsl:for-each>
                            </td>
                        </tr>
            </xsl:for-each>

                </tbody>
            </table>
    </xsl:if>

    </xsl:variable>

    <xsl:if test="string-length($holdingsData)">
        <div class="holdingsSummary">
            <xsl:copy-of select="$holdingsData"/>
        </div>
    </xsl:if>
</xsl:template>

<!-- ########################## -->
<!-- ## QR Code ## -->
<!-- ###################################################################### -->

<xsl:template name="QRCode">
   <xsl:variable name="EncodedQRTitle">
   	<xsl:call-template name="encode">
		<xsl:with-param name="str" select="$QRTitle"/>
   	</xsl:call-template>
   </xsl:variable>

   <xsl:choose>
      <xsl:when test="contains($VFORMAT,'VIDEO') or contains($VFORMAT,'DVD')">
	  <img src="http&#58;&#47;&#47;chart.apis.google.com&#47;chart&#63;cht=qr&amp;chs=150x150&amp;chl={$EncodedQRTitle} {$QRClassNumberDVD}"/>
      </xsl:when>
      <xsl:when test="string-length($QRClassNumberB)">
         <img src="http&#58;&#47;&#47;chart.apis.google.com&#47;chart&#63;cht=qr&amp;chs=150x150&amp;chl={$EncodedQRTitle} {$QRAuthor} {$QRClassNumberA}{$QRClassNumberB}"/>
      </xsl:when>
      <xsl:otherwise>
         <img src="http&#58;&#47;&#47;chart.apis.google.com&#47;chart&#63;cht=qr&amp;chs=150x150&amp;chl={$EncodedQRTitle} {$QRAuthor} {$QRClassNumberA}"/>
      </xsl:otherwise>
   </xsl:choose>

</xsl:template>

<!-- ###################################################################### -->
<!-- ########################## -->
<!-- ## TALIS Lists ## -->
<!-- ###################################################################### -->

<xsl:template name="TalisList">
   
   <xsl:choose>
      <xsl:when test="string-length($ISBN)">
	  <!--<a href="Javascript:getTalis('{$ISBN}')">HERE</a>-->

	  <script type="text/javascript">getTalis('<xsl:value-of select="$ISBN"/>');</script>
      </xsl:when>
      <xsl:otherwise>
      </xsl:otherwise>
   </xsl:choose>

</xsl:template>


<!-- ###################################################################### -->

</xsl:stylesheet>
