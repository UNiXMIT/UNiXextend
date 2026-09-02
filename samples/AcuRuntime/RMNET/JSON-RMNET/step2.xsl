<?xml version='1.0'?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output indent="yes" method="xml" encoding="utf-8"/>

<xsl:template match="/">
<root><xsl:apply-templates select="*[local-name() != 'nameNode']"/></root>
</xsl:template>

<xsl:template match="value">
<xsl:variable name="nodeName"><xsl:call-template name="createNodeName"/></xsl:variable>
<xsl:element name="{$nodeName}"><xsl:value-of select="."/></xsl:element>
</xsl:template>

<xsl:template match="arrayItem">
<xsl:variable name="candidateNodeName"><xsl:choose>
                                <xsl:when test="local-name(parent::array[1]/preceding-sibling::*[1]) = 'nameNode'"><xsl:value-of select="parent::array[1]/preceding-sibling::*[1]/@name"/></xsl:when>
                                <xsl:otherwise><xsl:value-of select="local-name(.)"/></xsl:otherwise>
                              </xsl:choose></xsl:variable>
<xsl:variable name="nodeName"><xsl:value-of select="concat(translate(substring($candidateNodeName,1,1),'0123456789','xxxxxxxxxx'),translate(substring($candidateNodeName,2),'_ ','-'),'Item')"/></xsl:variable>
<xsl:element name="{$nodeName}"><xsl:value-of select="."/></xsl:element>
</xsl:template>

<xsl:template match="object|array">
<xsl:variable name="nodeName"><xsl:call-template name="createNodeName"/></xsl:variable>
<xsl:element name="{$nodeName}"><xsl:apply-templates select="*[local-name() != 'nameNode']"/></xsl:element>
</xsl:template>

<xsl:template name="createNodeName">
<xsl:variable name="candidateNodeName"><xsl:choose>
                                          <xsl:when test="local-name(preceding-sibling::*[1]) = 'nameNode'"><xsl:value-of select="preceding-sibling::*[1]/@name"/></xsl:when>
                                          <xsl:otherwise><xsl:value-of select="local-name(.)"/></xsl:otherwise>
                                       </xsl:choose></xsl:variable>
<!-- apply any adjustments necessary to get the JSON name to a valid name for an XML node.  
     As an example the following will ensure that the name will not begin with a digit or a space,
	 and that underscore and colon are converted to hyphen. -->
<xsl:variable name="actualNodeName"><xsl:value-of select="concat(translate(substring($candidateNodeName,1,1),'0123456789 ','xxxxxxxxxx'),translate(substring($candidateNodeName,2),':_ ','--'))"/></xsl:variable>
<xsl:value-of select="$actualNodeName"/>
</xsl:template>

</xsl:stylesheet>