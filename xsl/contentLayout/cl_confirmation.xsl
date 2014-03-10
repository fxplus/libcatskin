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
**          Product : WebVoyage 
**          Version : 7.2.0
**          Created : 25-Oct-2007
**      Orig Author : Scott Morgan
**    Last Modified : 14-SEP-2009
** Last Modified By : Mel Pemble
-->

<xsl:stylesheet version="1.0"
	exclude-result-prefixes="xsl fo page"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:page="http://www.exlibrisgroup.com/voyager/webvoyage/page"
	xmlns:fo="http://www.w3.org/1999/XSL/Format">
	
	<!-- External imports -->
	
	<xsl:template name="cl_confirmation.confirmationPanel">
		<div class="formBackround">
			<xsl:for-each  select="/page:page/page:pageBody">
				<br/>
			    <div class="message">
					<xsl:for-each  select="page:element[@nameId='page.searchResults.emailComplete.page.success.label']" >
			    		<xsl:value-of select="page:label"/>
					</xsl:for-each>
					<br/>	    		
				</div>
				
				<xsl:for-each  select="page:element/page:element[@nameId='page.searchResults.emailComplete.page.success.list']" >
	    			<div class="messageValues">
	    			<xsl:value-of select="page:label"/>
	    			</div>
				</xsl:for-each>	
				
				
				
				
				<xsl:for-each  select="page:element[@nameId='page.searchResults.emailComplete.page.return.button']" >
					    <br/>
					    <form>
					       <xsl:attribute name="id">
					             <xsl:value-of select="page:postText"/>
					       </xsl:attribute>
					       <xsl:attribute name="action">
					             <xsl:value-of select="'searchBasic'"/>
					       </xsl:attribute>
					       <div class="formButtons">
					       		<br/>
						       <input>
						           <xsl:attribute name="value">
							             <xsl:value-of select="'Return to search page'"/>
							       </xsl:attribute>
							       <xsl:attribute name="alt">
							             <xsl:value-of select="'Return Button'"/>
							       </xsl:attribute>
							       <xsl:attribute name="class">
							             <xsl:value-of select="'btn'"/>
							       </xsl:attribute>
							       <xsl:attribute name="type">
							             <xsl:value-of select="'submit'"/>
							       </xsl:attribute>
						       </input>
					        </div>
					    </form>	
				</xsl:for-each>
				
				
			</xsl:for-each>
	
		<br/>
		</div>
	</xsl:template>
	
</xsl:stylesheet>

