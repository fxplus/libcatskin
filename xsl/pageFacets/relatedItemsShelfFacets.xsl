<xsl:stylesheet version="1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:page="http://www.exlibrisgroup.com/voyager/webvoyage/page"
   xmlns:fo="http://www.w3.org/1999/XSL/Format">

<!-- ############################ -->
<!-- ## buildRelatedItemsShelf ## -->
<!-- ####################################################################################################################### -->
<xsl:template name="buildRelatedItemsShelf">
  <div class="relatedItemsBookshelfContainer">
    <a name="relatedItemsBookshelfContainer"></a>
    <xsl:variable name="callNumber" select="$HoldXML//*[@name='callNumber']"/>
<!--
    <xsl:variable name="locationCode" select="$HoldXML//*[@name='locationCode']"/>
-->
    <xsl:choose>
      <xsl:when test="(string-length($callNumber) > 3) and not(contains($callNumber, '/')) and not(contains($callNumber, ':'))">
        <span id="relatedItemsShelf_callNumber" style="display: none;">
          <xsl:value-of select="$callNumber"/>
        </span>
        <span id="relatedItemsShelf_bibId" style="display: none;">
          <xsl:value-of select="$bibID"/>
        </span>
        <!-- UNCOMMENT THIS LINE AND CHANGE THE CLIENTCODE TO ENABLE SYNDETICS IMAGES -->
          <span id="relatedItemsShelf_syndeticsClientCode" style="display: none;">unifalel</span> 
         
        <!-- UNCOMMENT THIS LINE TO ENABLE GOOGLE BOOK SEARCH LINKS AND IMAGES
          <span id="relatedItemsShelf_useGoogleBooks" style="display: none;">true</span>
        -->
        <!-- UNCOMMENT THIS LINE AND CHANGE THE UA NUMBER TO ENABLE GOOGLE ANALYTICS TRACKING
          <span id="relatedItemsShelf_GA_trackerId" style="display: none;">UA-0000000-1</span>
        -->  
        <iframe class="relatedItemsBookshelf" src="/relatedItemsShelf/relatedItemsShelf.html" scrolling="no" frameborder="0" style="width:700px; height:400px; border:0; padding-left:15px;">
        </iframe>
      </xsl:when>
      <xsl:otherwise>
        <xsl:comment>Irregular call number, not displaying related items bookshelf.</xsl:comment>
      </xsl:otherwise>
    </xsl:choose>
  </div>
</xsl:template>

<!-- ####################################################################################################################### -->

<!-- ################################ -->
<!-- ## buildRelatedItemsShelfHint ## -->
<!-- ####################################################################################################################### -->
<xsl:template name="buildRelatedItemsShelfHint">
  <div class="relatedItemsBookshelfHint" style="display: none; clear: both; border-top: 1px solid #52B3FF; padding: 5px 0 15px; ">
    <label style="margin-left: 5px;">More Books on This Subject</label>
    <div style="margin-left: 15px;">
      <a href="#relatedItemsBookshelfContainer" style="text-decoration: none;">
        Browse This Shelf
        <img src="/relatedItemsShelf/img/external/bookshelf_icon.png" style="border: 0"/>
       </a>
    </div>
  </div>
</xsl:template>

<!-- ####################################################################################################################### -->

</xsl:stylesheet>
