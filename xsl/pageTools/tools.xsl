<!--
#(c)#=====================================================================
#(c)#
#(c)#       Copyright 2007-2011 Ex Libris (USA) Inc.
#(c)#                       All Rights Reserved
#(c)#
#(c)#=====================================================================
-->
<!--
**          Product : WebVoyage :: tools
**          Version : 7.2.0
**          Created : 16-JUL-2007
**      Orig Author : Mel Pemble
**    Last Modified : 15-SEP-2009
** Last Modified By : Mel Pemble
-->

<xsl:stylesheet
   version="1.0"
   exclude-result-prefixes="xsl fo page xalan"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:fo="http://www.w3.org/1999/XSL/Format"
   xmlns:xalan="http://xml.apache.org/xalan"
   xmlns:page="http://www.exlibrisgroup.com/voyager/webvoyage/page">

   <!--
   ## A Place to put Global Templates used in the interface ##
   -->

<xsl:variable name="lowercase" select="'abcdefghijklmnopqrstuvwxyz'" />
<xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

<!-- ######################################################### -->

<xsl:template name="buildImageUrl">
<xsl:param name="eleName"/>
<xsl:param name="longdesc"/>

   <xsl:for-each select="/page:page//page:element[@nameId=$eleName]">
      <a>
         <xsl:if test="string-length(page:URL)">
            <xsl:attribute name="href"><xsl:value-of select="page:URL"/></xsl:attribute>
         </xsl:if>
         <!--
         <xsl:if test="string-length(page:linkText)">
            <xsl:attribute name="alt"><xsl:value-of select="page:linkText"/></xsl:attribute>
         </xsl:if>
         -->
         <xsl:choose>
            <xsl:when test="string-length(page:imageURL)">
               <img src="{page:imageURL}" alt="{page:linkText}"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="page:linkText"/>
            </xsl:otherwise>
         </xsl:choose>
      </a>
   </xsl:for-each>

</xsl:template>

<!-- ######################################################### -->

<xsl:template name="createHiddenField">
<xsl:param name="eleName"/>

    <xsl:for-each select="/page:page//page:element[@nameId=$eleName]">
       <xsl:if test="string-length(page:value)">
           <label for="{@nameId}">
              <input type="hidden">
                 <xsl:attribute name="id"><xsl:value-of select="@nameId"/></xsl:attribute>
                   <xsl:attribute name="name"><xsl:value-of select="@nameId"/></xsl:attribute>
                   <xsl:attribute name="value"><xsl:value-of select="page:value"/></xsl:attribute>
              </input>
           </label>
        </xsl:if>
    </xsl:for-each>

</xsl:template>

<!-- ######################################################### -->

<xsl:template name="doHiddenFields">

    <xsl:for-each select="/page:page/page:element[@hidden='true']">
        <input type="hidden">
              <xsl:attribute name="id"><xsl:value-of select="@nameId"/></xsl:attribute>
                <xsl:attribute name="name"><xsl:value-of select="@nameId"/></xsl:attribute>
                <xsl:attribute name="value">
                    <xsl:choose>
                        <xsl:when test="string-length(page:valueId)"><xsl:value-of select="page:valueId"/></xsl:when>
                        <xsl:otherwise><xsl:value-of select="page:value"/></xsl:otherwise>
                    </xsl:choose>
                </xsl:attribute>
        </input>
    </xsl:for-each>

</xsl:template>

<!-- ######################################################### -->

<xsl:template name="displayPageMessages">

    <xsl:variable name="needsBR" select="'xxEnterPageNamesxx xxEnterPageNamesxx xxEnterPageNamesxx'"/>

    <xsl:for-each select="//page:message">

        <xsl:variable name="blockCode"><xsl:value-of select="@blockCode"/></xsl:variable>
        <xsl:variable name="errorCode"><xsl:value-of select="@errorCode"/></xsl:variable>
        <xsl:variable name="requestCode"><xsl:value-of select="@requestCode"/></xsl:variable>

        <!-- ## here you can set specific css classes based on block/error/request codes ## -->
        <xsl:variable name="messageClass">
            <xsl:choose>
                <xsl:when test="@errorCode='searchResults.noHits'">noHitsError</xsl:when>
                <xsl:when test="@type='blocked'">blockMessage</xsl:when>
                <xsl:otherwise>pageErrorText</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <p class="{$messageClass}" id="{$messageClass}">
            <xsl:choose>
                <xsl:when test="$Configs/pageConfigs/pageMessages/pageMsg[@blockCode=$blockCode]">
                    <xsl:copy-of select="$Configs/pageConfigs/pageMessages/pageMsg[@blockCode=$blockCode]/node()"/>
                </xsl:when>
                <xsl:when test="$Configs/pageConfigs/pageMessages/pageMsg[@errorCode=$errorCode]">
                    <xsl:copy-of select="$Configs/pageConfigs/pageMessages/pageMsg[@errorCode=$errorCode]/node()"/>
                </xsl:when>
                <xsl:when test="$Configs/pageConfigs/pageMessages/pageMsg[@requestCode=$requestCode]">
                    <xsl:copy-of select="$Configs/pageConfigs/pageMessages/pageMsg[@requestCode=$requestCode]/node()"/>
                </xsl:when>
                <xsl:when test="string-length(.)">
                    <xsl:value-of select="."/>
                </xsl:when>
                <xsl:otherwise>
                    <!-- This is a catch-all message for blocks/errors/reqeusts -->
                    The system could not process your request.
                </xsl:otherwise>
            </xsl:choose>
        </p>
    </xsl:for-each>


</xsl:template>

<!-- ######################################################### -->

<xsl:template name="displayPageHtmlSnippet">
<xsl:param name="position"/>

   <xsl:variable name="pageNameId">
      <xsl:value-of select="/page:page/@nameId"/>
   </xsl:variable>

   <xsl:if test="$Configs/pageConfigs/pageHTML/page[@name=$pageNameId][@position=$position]">
      <div class="pageHTMLSnippet">
         <xsl:copy-of select="$Configs/pageConfigs/pageHTML/page[@name=$pageNameId][@position=$position]/node()"/>
      </div>
   </xsl:if>

</xsl:template>

<!-- ######################################################### -->

<xsl:template name="buildStdButton">
<xsl:param name="eleName"/>

<xsl:for-each select="/page:page//page:element[@nameId=$eleName]">

    <xsl:if test="string-length(page:buttonAction)">

        <input type="button" class="formButton" name="{$eleName}" id="{$eleName}">
            <xsl:attribute name="value"><xsl:value-of select="page:buttonText"/></xsl:attribute>
            <xsl:choose>
                <xsl:when test="page:buttonMessage">
                    <xsl:attribute name="onclick">if(confirm('<xsl:value-of select="page:buttonMessage"/>')){ window.location.href='<xsl:value-of select="page:buttonAction"/>'}</xsl:attribute>
                </xsl:when>
                <xsl:when test="page:buttonAction">
                    <xsl:choose>
                        <xsl:when test="contains(page:buttonAction,'AddChangePopup')">
                            <xsl:attribute name="onclick">javascript:popUp('<xsl:value-of select="page:buttonAction"/>');</xsl:attribute>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:attribute name="onclick">window.location.href='<xsl:value-of select="page:buttonAction"/>'</xsl:attribute>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>

            </xsl:choose>
        </input>&#160;

    </xsl:if>
   </xsl:for-each>


</xsl:template>

<!-- ######################################################### -->

<xsl:template name="buildLinkType">
<xsl:param name="eleName"/>
<xsl:param name="spanId"/>
<xsl:param name="imageLink"/>

   <xsl:variable name="spanEle">
      <xsl:choose>
         <xsl:when test="string-length($spanId)">
            <xsl:value-of select="$spanId"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="$eleName"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>

   <xsl:for-each select="/page:page//page:element[@nameId=$eleName]">
      <span id="span{$spanEle}">
          <xsl:if test="string-length(page:linkText)">
             <xsl:if test="string-length(page:preText)">
                <span id="preText{$spanEle}"><xsl:value-of select="page:preText"/></span>
             </xsl:if>
            <a title="{page:linkText}">
               <xsl:if test="string-length(page:URL)">
                  <xsl:attribute name="href"><xsl:value-of select="page:URL"/></xsl:attribute>
               </xsl:if>
               <xsl:if test="string-length($imageLink)">
                  <img src="{$image-loc}{$imageLink}" id="{$eleName}" alt="{page:linkText}"/>
               </xsl:if>
               <xsl:value-of select="page:linkText"/>
            </a>
            <xsl:if test="string-length(page:postText)">
               <span id="postText{$spanEle}"><xsl:value-of select="page:postText"/></span>
             </xsl:if>
          </xsl:if>
       </span>
   </xsl:for-each>

</xsl:template>

<!-- ######################################################### -->

<xsl:template name="displayLabelText">

<xsl:param name="eleName"/>
    <xsl:value-of select="/page:page/page:element[@nameId=$eleName]/page:label" />
</xsl:template>

<!-- ######################################################### -->

<xsl:template name="displayValueText">
<xsl:param name="eleName"/>
    <xsl:value-of select="/page:page/page:element[@nameId=$eleName]/page:value" />
</xsl:template>

<!-- ######################################################### -->

<xsl:template name="displayValue">
<xsl:param name="val"/>
<xsl:param name="popUPLink"/>
<xsl:param name="popUPText"/>

<!--
    Send the data to a function that will replace pipes with breaks
-->
    <xsl:choose>
        <xsl:when test="contains($val,'|')">
            <xsl:call-template name="replace-pipes">
                <xsl:with-param name="text" select="$val" />
                <xsl:with-param name="replace" select="'|'" />
                <xsl:with-param name="popUPLink" select="$popUPLink"/>
                <xsl:with-param name="popUPText" select="$popUPText"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
            <xsl:call-template name="br-replace">
                <xsl:with-param name="word" select="$val"/>
            </xsl:call-template>
        </xsl:otherwise>
    </xsl:choose>

</xsl:template>

<!-- ######################################################### -->

<xsl:template name="displaySortedValue">
<xsl:param name="val"/>

<!--
    Send the data to a function that will replace pipes with breaks
-->
<xsl:choose>
    <xsl:when test="contains($val,'|')">
        <xsl:variable name="roleNodes">
            <xsl:call-template name="buildRTF">
                <xsl:with-param name="text" select="$val" />
                <xsl:with-param name="replace" select="'|'" />
            </xsl:call-template>
        </xsl:variable>
        <xsl:for-each select="xalan:nodeset($roleNodes)/data">
            <xsl:sort select="@role"/>
            <xsl:value-of select="@role"/><br/>
        </xsl:for-each>
    </xsl:when>
    <xsl:otherwise>
        <xsl:call-template name="br-replace">
            <xsl:with-param name="word" select="$val"/>
        </xsl:call-template>
    </xsl:otherwise>
</xsl:choose>

</xsl:template>

<!-- ######################################################### -->

<xsl:template name="buildRTF">
<xsl:param name="text" />
<xsl:param name="replace" />

    <xsl:choose>
        <xsl:when test="contains($text,$replace)">
            <xsl:element name="data">
                <xsl:attribute name="role"><xsl:value-of select="substring-before($text,$replace)"/></xsl:attribute>
            </xsl:element>
            <xsl:call-template name="buildRTF">
                <xsl:with-param name="text" select="substring-after($text,$replace)" />
                <xsl:with-param name="replace" select="$replace" />
            </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
            <xsl:element name="data">
                <xsl:attribute name="role"><xsl:value-of select="$text"/></xsl:attribute>
            </xsl:element>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<!-- ######################################################### -->

<xsl:template name="replace-pipes">
<xsl:param name="text" />
<xsl:param name="replace" />
<xsl:param name="popUPLink"/>
<xsl:param name="popUPText"/>

    <xsl:choose>
        <xsl:when test="contains($text,$replace)">
            <xsl:value-of select="substring-before($text,$replace)"/>
            <xsl:if test="string-length($popUPLink)">
&#160;&#160;&#160;<a
                    href="javascript:void(0)"
                    target="_popupIP"
                    onclick="return openGlobalhelp('{$popUPLink}','IpPopUp',580,380,0)"><xsl:value-of select="$popUPText"/>
                </a>
            </xsl:if>
            <br/>
            <xsl:call-template name="replace-pipes">
                <xsl:with-param name="text" select="substring-after($text,$replace)" />
                <xsl:with-param name="replace" select="$replace" />
            </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
            <xsl:value-of select="$text"/>
            <xsl:if test="string-length($popUPLink)">
&#160;&#160;&#160;<a
                    href="javascript:void(0)"
                    target="_popupIP"
                    onclick="return openGlobalhelp('{$popUPLink}','IpPopUp',580,380,0)"><xsl:value-of select="$popUPText"/>
                </a>
            </xsl:if>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<!-- ######################################################### -->

<xsl:template name="replace-chars-with-space">
<xsl:param name="text" />
<xsl:param name="replace" />
    <xsl:choose>
        <xsl:when test="contains($text,$replace)">
            <xsl:value-of select="substring-before($text,$replace)"/>&#160;&#160;&#160;
            <xsl:call-template name="replace-chars-with-space">
                <xsl:with-param name="text" select="substring-after($text,$replace)" />
                <xsl:with-param name="replace" select="$replace" />
            </xsl:call-template>
        </xsl:when>
        <xsl:otherwise><xsl:value-of select="$text"/></xsl:otherwise>
    </xsl:choose>
</xsl:template>

<!-- ######################################################### -->

<xsl:template name="removepipes">
<xsl:param name="text" />
<xsl:param name="replace" />
    <xsl:choose>
        <xsl:when test="contains($text,$replace)">
            <xsl:value-of select="substring-before($text,$replace)"/>
            <xsl:call-template name="removepipes">
                <xsl:with-param name="text" select="substring-after($text,$replace)" />
                <xsl:with-param name="replace" select="$replace" />
            </xsl:call-template>
        </xsl:when>
        <xsl:otherwise><xsl:value-of select="$text"/></xsl:otherwise>
    </xsl:choose>
</xsl:template>

<!-- ######################################################### -->

<xsl:template name="br-replace">
<xsl:param name="word"/>
<xsl:variable name="cr"><xsl:text>
 </xsl:text></xsl:variable>

    <xsl:choose>
        <xsl:when test="contains($word,$cr)">
            <xsl:value-of select="substring-before($word,$cr)"/><br/>
            <xsl:call-template name="br-replace">
                <xsl:with-param name="word" select="substring-after($word,$cr)"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
            <xsl:value-of select="$word"/>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<!-- ######################################################### -->

<xsl:template name="replace-chars-with-comma-space">
 <xsl:param name="text" />
<xsl:param name="replace" />
    <xsl:choose>
        <xsl:when test="contains($text,$replace)">
            <xsl:value-of select="substring-before($text,$replace)"/>,&#160;
            <xsl:call-template name="replace-chars-with-comma-space">
                <xsl:with-param name="text" select="substring-after($text,$replace)" />
                <xsl:with-param name="replace" select="$replace" />
            </xsl:call-template>
        </xsl:when>
        <xsl:otherwise><xsl:value-of select="$text"/></xsl:otherwise>
    </xsl:choose>
</xsl:template>

<!-- ###################################################################### -->

<xsl:template name="trimData">
<xsl:param name="sData"/>

   <xsl:choose>
      <xsl:when test="string-length($sData) &gt; 8">
         <xsl:choose>
            <xsl:when test="contains($sData,' ')">
               <xsl:choose>
                  <xsl:when test="string-length(substring-before($sData,' ')) &lt; 8">
                     <xsl:call-template name="trimData">
                        <xsl:with-param name="sData" select="substring-after($sData,' ')"/>
                     </xsl:call-template>
                  </xsl:when>
                  <xsl:otherwise><xsl:value-of select="substring-before($sData,' ')"/></xsl:otherwise>
               </xsl:choose>
            </xsl:when>
            <xsl:otherwise><xsl:value-of select="normalize-space($sData)"/></xsl:otherwise>
         </xsl:choose>
      </xsl:when>
   </xsl:choose>

</xsl:template>

<!-- ######################################################### -->

</xsl:stylesheet>



