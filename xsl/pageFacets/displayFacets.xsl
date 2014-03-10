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
**          Product : : WebVoyage :: displayFacets
**          Version : 7.1.0
**          Created : 26-OCT-2007
**      Orig Author : David Sellers
**    Last Modified : 09-MAR-2009 
** Last Modified By : Mel Pemble
-->

<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:page="http://www.exlibrisgroup.com/voyager/webvoyage/page"
	xmlns:fo="http://www.w3.org/1999/XSL/Format"
	xmlns:mfhd="http://www.endinfosys.com/Voyager/mfhd"
	xmlns:hol="http://www.endinfosys.com/Voyager/holdings"
	xmlns:slim="http://www.loc.gov/MARC21/slim" exclude-result-prefixes="slim">

<xsl:include href="../local_googleBooksAvail.xsl"/>
<xsl:include href="./exeterRequest.xsl"/>
<xsl:include href="./local_PersistentLink.xsl"/>


<xsl:variable name="dbcode">
	<xsl:for-each select="//hol:bibData[@name = 'databaseCode']">
		<xsl:value-of select = "."/>
		</xsl:for-each>
	</xsl:variable>

<xsl:variable name="loccode">
	<xsl:for-each select="//mfhd:mfhdRecord/mfhd:marcRecord/slim:datafield/slim:subfield[@code = 'b']">
		<xsl:value-of select = "."/>
		</xsl:for-each>
	</xsl:variable>

<!-- ###################################################################### -->

<xsl:template name="buildActionBox">
<xsl:param name="pageRecordType"/>

	<xsl:for-each select="page:element[@nameId='actionBox.group']">
		<div class="actionBox">
			<a id="actionBoxQuickLink" name="actionBoxQuickLink"></a>
			<div class="thisItem">
			<xsl:for-each select="page:element[@nameId='actionBox.thisItem.group']">
				<div class="thisItemHeader">
					<label><xsl:value-of select="page:label"/></label>
						<xsl:for-each select="page:element">
							<xsl:choose>
								<xsl:when test="@nameId=$pageRecordType">
								<label><xsl:value-of select="page:linkText"/></label>
								</xsl:when>
							</xsl:choose>
						</xsl:for-each>
				</div>
				<div class="thisItemFooter">
						<xsl:for-each select="page:element">
							<xsl:choose>
								<xsl:when test="@nameId!=$pageRecordType">
								<label>Change to: <a href="{page:URL}"><xsl:value-of select="page:linkText"/></a></label>
								</xsl:when>
							</xsl:choose>
						</xsl:for-each>
				</div>			
	</xsl:for-each>
</div>
			<div class="actions">
			  <div class="persistentLink">
				<!--<xsl:value-of select="$bibID"/>-->
				<!-- ## Use persistentLink template to display the persistent link ##-->
				<xsl:call-template name="persistentLink">
					<xsl:with-param name="bibID" select="bibID"/>
				</xsl:call-template>	
			  </div>
			</div>

			<xsl:for-each select="page:element[@nameId='actionBox.actions.group']">
				<div class="actions">
					<label><xsl:value-of select="page:label"/></label>
					<h2 class="nav">Action Navigation</h2>
					<ul title="Action Navigation" class="actions">
						<xsl:for-each select="page:element">
							<xsl:choose>
							<xsl:when test = "$loccode != 'X-BK'">
								<li><span class="recordLinkBullet">·</span><a href="{page:URL}"><span><xsl:value-of select="page:linkText"/></span></a><br/><span class="fieldSubText"><xsl:value-of select="page:postText"/></span></li>
							</xsl:when>
							<xsl:otherwise>
								<xsl:if test = "page:linkText != 'Make a Request'">
								<li><span class="recordLinkBullet">·</span><a href="{page:URL}"><span><xsl:value-of select="page:linkText"/></span></a><br/><span class="fieldSubText"><xsl:value-of select="page:postText"/></span></li>
								</xsl:if>
							</xsl:otherwise>
							</xsl:choose>
						</xsl:for-each>
		<span class="recordLinkBullet">·</span>
		<a href="javascript:webvoyager.refworks.importBib('?id={$bibID}&amp;id_count=1');"
		title="Export to RefWorks" class="refworks">
		<img style="vertical-align:middle;border:none" src="{$image-loc}refworks.gif"/>
		</a>
	   		<div id="googleBooksRow">
	           <xsl:call-template name="googleBooksAvail"/>
			</div>
		</ul>

				</div>							
			</xsl:for-each>
		
		<ul title="QR Code">
			<li><span class="recordLinkBullet"> </span>
				<xsl:call-template name="QRCode">
				</xsl:call-template>
			</li>
		</ul>

		<!--	<xsl:for-each select="page:element[@nameId='actionBox.moreAboutThisItem.group']">

				<div class="moreInfo">

					<label><xsl:value-of select="page:label"/></label>
					<h2 class="nav">Action Box More Info Navigation</h2>
					<ul title="Action Box More Info Navigation" class="moreInfo"> -->
					            <!-- ## mdp add the google book template ## -->
      
		<!--				<xsl:for-each select="page:element">
							<li>
								<xsl:call-template name="buildImageUrl">
									<xsl:with-param name="eleName" select="@nameId"/>
								</xsl:call-template>
							</li>
						</xsl:for-each>
	   		<div id="googleBooksRow">
	           <xsl:call-template name="googleBooksAvail"/>
			</div>
					</ul>
				</div>
			</xsl:for-each>	-->
		<!-- Start of Related Items Shelf code -->
		<div id="relatedItemsShelfHintRow">
			<xsl:call-template name="buildRelatedItemsShelfHint"/>
		</div>
		<!-- End of Related Items Shelf code -->
</div>
	</xsl:for-each>


</xsl:template>

<!-- ###################################################################### -->

</xsl:stylesheet>
