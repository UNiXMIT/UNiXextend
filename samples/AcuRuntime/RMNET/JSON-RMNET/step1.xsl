<?xml version='1.0'?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text" encoding="utf-8"/>

<xsl:template match="/">
<xsl:value-of disable-output-escaping="yes" select="concat('&lt;','root','&gt;')"/>
<xsl:call-template name="parseNextToken">
	<xsl:with-param name="remaining"><xsl:call-template name="stripLeadingWhitespace"><xsl:with-param name="theString" select="/json-string"/></xsl:call-template></xsl:with-param>
</xsl:call-template>
<xsl:value-of disable-output-escaping="yes" select="concat('&lt;','/root','&gt;')"/>
</xsl:template>

<xsl:template name="parseNextToken">
<xsl:param name="remaining" select="''"/>
<xsl:param name="operandStack" select="','"/>

<xsl:variable name="operandChar" select="substring($remaining,1,1)"/>

<xsl:choose>
<xsl:when test="string-length($remaining) = 0"></xsl:when>

<xsl:when test="$operandChar = '{'">
<xsl:value-of disable-output-escaping="yes" select="concat('&lt;','object','&gt;')"/>
<xsl:call-template name="parseNextToken">
	<xsl:with-param name="remaining"><xsl:call-template name="stripLeadingWhitespace"><xsl:with-param name="theString" select="substring($remaining,2)"/></xsl:call-template></xsl:with-param>
	<xsl:with-param name="operandStack" select="concat($operandChar,$operandStack)"/>
</xsl:call-template>
</xsl:when>

<xsl:when test="$operandChar = '}'">
<xsl:value-of disable-output-escaping="yes" select="concat('&lt;','/object','&gt;')"/>
<xsl:call-template name="parseNextToken">
	<xsl:with-param name="remaining"><xsl:call-template name="stripLeadingWhitespace"><xsl:with-param name="theString" select="substring($remaining,2)"/></xsl:call-template></xsl:with-param>
	<xsl:with-param name="operandStack" select="substring($operandStack,2)"/>
</xsl:call-template>
</xsl:when>

<xsl:when test="$operandChar = '['">
<xsl:value-of disable-output-escaping="yes" select="concat('&lt;','array','&gt;')"/>
<xsl:call-template name="parseNextToken">
	<xsl:with-param name="remaining"><xsl:call-template name="stripLeadingWhitespace"><xsl:with-param name="theString" select="substring($remaining,2)"/></xsl:call-template></xsl:with-param>
	<xsl:with-param name="operandStack" select="concat($operandChar,$operandStack)"/>
</xsl:call-template>
</xsl:when>

<xsl:when test="$operandChar = ']'">
<xsl:value-of disable-output-escaping="yes" select="concat('&lt;','/array','&gt;')"/>
<xsl:call-template name="parseNextToken">
	<xsl:with-param name="remaining"><xsl:call-template name="stripLeadingWhitespace"><xsl:with-param name="theString" select="substring($remaining,2)"/></xsl:call-template></xsl:with-param>
	<xsl:with-param name="operandStack" select="substring($operandStack,2)"/>
</xsl:call-template>
</xsl:when>

<xsl:when test="$operandChar = '&quot;'">
<!-- if the top of the operand stack is a comma, then this must be name
     if the top of the operand stack is a [ or :, then this must be a string value -->
	<xsl:choose>
	<xsl:when test="substring($operandStack,1,1) = ',' or substring($operandStack,1,1) = '{'">  <!-- name -->
		<xsl:variable name="nameString" select="substring-before(substring($remaining,2),'&quot;')"/>
        <xsl:value-of disable-output-escaping="yes" select="concat('&lt;','nameNode name=&quot;',$nameString,'&quot;/&gt;')"/>
		<xsl:call-template name="parseNextToken">
			<xsl:with-param name="operandStack" select="concat(':',$operandStack)"/>
			<xsl:with-param name="remaining"><xsl:call-template name="stripLeadingWhitespace"><xsl:with-param name="theString" select="substring-after(substring-after(substring($remaining,2),'&quot;'),':')"/></xsl:call-template></xsl:with-param>
		</xsl:call-template>
	</xsl:when>
	<xsl:when test="substring($operandStack,1,1) = '['">  <!-- value in an array -->
		<xsl:variable name="theValue" select="substring-before(substring($remaining,2),'&quot;')"/>
		<xsl:variable name="afterTheValue"><xsl:call-template name="stripLeadingWhitespace"><xsl:with-param name="theString" select="substring-after(substring($remaining,2),'&quot;')"/></xsl:call-template></xsl:variable>
		<xsl:variable name="remainingAfterValue"><xsl:choose><xsl:when test="substring($afterTheValue,1,1) = ','"><xsl:call-template name="stripLeadingWhitespace"><xsl:with-param name="theString" select="substring($afterTheValue,2)"/></xsl:call-template></xsl:when>
		                                                     <xsl:otherwise><xsl:value-of select="$afterTheValue"/></xsl:otherwise>
		                                         </xsl:choose>
	    </xsl:variable> <!-- $remainingAfterValue is used to swallow the comma in a series of values within an array -->
		<xsl:value-of disable-output-escaping="yes" select="concat('&lt;arrayItem type=&quot;string&quot;&gt;&lt;![CDATA[',$theValue,']]&gt;&lt;/arrayItem&gt;')"/>
		<xsl:call-template name="parseNextToken">
			<xsl:with-param name="operandStack" select="$operandStack"/> <!-- keep the bracket as the operator -->
			<xsl:with-param name="remaining" select="$afterTheValue"/>
		</xsl:call-template>
	</xsl:when>
	<xsl:when test="substring($operandStack,1,1) = ':'">  <!-- elementary value  -->
		<xsl:variable name="theValue" select="substring-before(substring($remaining,2),'&quot;')"/>
		<xsl:value-of disable-output-escaping="yes" select="concat('&lt;value type=&quot;string&quot;&gt;&lt;![CDATA[',$theValue,']]&gt;&lt;/value&gt;')"/>
		<xsl:call-template name="parseNextToken">
			<xsl:with-param name="operandStack" select="$operandStack"/>
			<xsl:with-param name="remaining"><xsl:call-template name="stripLeadingWhitespace"><xsl:with-param name="theString" select="substring-after(substring($remaining,2),'&quot;')"/></xsl:call-template></xsl:with-param>
		</xsl:call-template>
	</xsl:when>
	</xsl:choose>
</xsl:when>

<xsl:when test="$operandChar = ','">
	<xsl:variable name="nextOperandStack"><xsl:choose><xsl:when test="substring($operandStack,1,1) = '['"><xsl:value-of select="$operandStack"/></xsl:when>
	                                                  <xsl:otherwise><xsl:value-of select="concat(',',$operandStack)"/></xsl:otherwise>
	                                      </xsl:choose></xsl:variable>
	<xsl:call-template name="parseNextToken">
		<xsl:with-param name="operandStack" select="$nextOperandStack"/>
		<xsl:with-param name="remaining"><xsl:call-template name="stripLeadingWhitespace"><xsl:with-param name="theString" select="substring($remaining,2)"/></xsl:call-template></xsl:with-param>
	</xsl:call-template>
</xsl:when>

<xsl:when test="contains('0123456789.-',$operandChar)">
	<xsl:variable name="numberString"><xsl:call-template name="getNumberString"><xsl:with-param name="theString" select="$remaining"/></xsl:call-template></xsl:variable>
	<xsl:variable name="afterNumberString"><xsl:call-template name="getAfterNumberString"><xsl:with-param name="theString" select="$remaining"/></xsl:call-template></xsl:variable>
	<xsl:choose>
	<xsl:when test="substring($operandStack,1,1) = '['">  <!-- value in an array -->
		<xsl:variable name="remainingAfterValue"><xsl:choose><xsl:when test="substring($afterNumberString,1,1) = ','"><xsl:call-template name="stripLeadingWhitespace"><xsl:with-param name="theString" select="substring($afterNumberString,2)"/></xsl:call-template></xsl:when>
		                                                     <xsl:otherwise><xsl:value-of select="$afterNumberString"/></xsl:otherwise>
		                                         </xsl:choose>
	    </xsl:variable> <!-- $remainingAfterValue is used to swallow the comma in a series of values within an array -->
		<xsl:value-of disable-output-escaping="yes" select="concat('&lt;arrayItem type=&quot;number&quot;&gt;',$numberString,'&lt;/arrayItem&gt;')"/>
		<xsl:call-template name="parseNextToken">
			<xsl:with-param name="operandStack" select="$operandStack"/> <!-- keep the bracket as the operator -->
			<xsl:with-param name="remaining" select="$remainingAfterValue"/>
		</xsl:call-template>
	</xsl:when>
	<xsl:when test="substring($operandStack,1,1) = ':'">  <!-- elementary value  -->
		<xsl:value-of disable-output-escaping="yes" select="concat('&lt;value type=&quot;number&quot;&gt;',$numberString,'&lt;/value&gt;')"/>
		<xsl:call-template name="parseNextToken">
			<xsl:with-param name="operandStack" select="$operandStack"/>
			<xsl:with-param name="remaining"><xsl:call-template name="stripLeadingWhitespace"><xsl:with-param name="theString" select="$afterNumberString"/></xsl:call-template></xsl:with-param>
		</xsl:call-template>
	</xsl:when>
	</xsl:choose> 
</xsl:when>

<xsl:when test="substring($remaining,1,4) = 'true' or substring($remaining,1,5) = 'false' or substring($remaining,1,4) = 'null'">
<xsl:variable name="keyword"><xsl:choose><xsl:when test="substring($remaining,1,4) = 'true'">true</xsl:when>
                                         <xsl:when test="substring($remaining,1,5) = 'false'">false</xsl:when>
										 <xsl:when test="substring($remaining,1,4) = 'null'">null</xsl:when></xsl:choose></xsl:variable>
	<xsl:value-of disable-output-escaping="yes" select="concat('&lt;value type=&quot;',$keyword,'&quot;&gt;',$keyword,'&lt;/value&gt;')"/>
	<xsl:call-template name="parseNextToken">
		<xsl:with-param name="operandStack" select="$operandStack"/>
		<xsl:with-param name="remaining"><xsl:call-template name="stripLeadingWhitespace"><xsl:with-param name="theString" select="substring($remaining,string-length($keyword)+1)"/></xsl:call-template></xsl:with-param>
	</xsl:call-template>
</xsl:when>

<xsl:otherwise>
	<xsl:value-of disable-output-escaping="yes" select="concat('&lt;parseError&gt;',substring($remaining,1,1),'&lt;/parseError&gt;')"/>
	<xsl:call-template name="parseNextToken">
		<xsl:with-param name="operandStack" select="$operandStack"/>
		<xsl:with-param name="remaining"><xsl:call-template name="stripLeadingWhitespace"><xsl:with-param name="theString" select="substring($remaining,2)"/></xsl:call-template></xsl:with-param>
	</xsl:call-template>
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template name="stripLeadingWhitespace">
<xsl:param name="theString" select="''"/>
<xsl:choose>
<xsl:when test="string-length($theString) &gt; 0">
	<xsl:variable name="firstChar" select="substring($theString,1,1)"/>
	<xsl:variable name="remaining" select="substring($theString,2)"/>
	<xsl:choose>
	<xsl:when test="string-length(normalize-space($firstChar)) &gt; 0"><xsl:value-of select="$theString"/></xsl:when>
	<xsl:otherwise><xsl:call-template name="stripLeadingWhitespace"><xsl:with-param name="theString" select="$remaining"/></xsl:call-template></xsl:otherwise>
	</xsl:choose>
</xsl:when>
<xsl:otherwise/>
</xsl:choose>
</xsl:template>

<xsl:template name="getNumberString">
<xsl:param name="theString" select="''"/>
<xsl:param name="outString" select="''"/>
<xsl:choose>
<xsl:when test="string-length($theString) &gt; 0">
	<xsl:choose>
	<xsl:when test="contains('0123456789.eE-+',substring($theString,1,1))"><xsl:call-template name="getNumberString">
	                                                                       <xsl:with-param name="theString" select="substring($theString,2)"/>
																		   <xsl:with-param name="outString" select="concat($outString,substring($theString,1,1))"/>
																		   </xsl:call-template></xsl:when>
	<xsl:otherwise><xsl:value-of select="$outString"/></xsl:otherwise>
	</xsl:choose>
</xsl:when>
<xsl:otherwise><xsl:value-of select="$outString"/></xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template name="getAfterNumberString">
<xsl:param name="theString" select="''"/>
<xsl:choose>
<xsl:when test="string-length($theString) &gt; 0">
	<xsl:choose>
	<xsl:when test="contains('0123456789.eE-+',substring($theString,1,1))"><xsl:call-template name="getAfterNumberString">
	                                                                       <xsl:with-param name="theString" select="substring($theString,2)"/>
																		   </xsl:call-template></xsl:when>
	<xsl:otherwise><xsl:value-of select="$theString"/></xsl:otherwise>
	</xsl:choose>
</xsl:when>
<xsl:otherwise></xsl:otherwise>
</xsl:choose>
</xsl:template>

</xsl:stylesheet>