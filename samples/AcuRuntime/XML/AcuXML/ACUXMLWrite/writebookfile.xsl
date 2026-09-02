<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" indent="yes"/>
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="REPLACEMENTVALUE">
        <REPVAL>
            <xsl:apply-templates select="@* | node()"/>
        </REPVAL>
    </xsl:template>
    <xsl:template match="@REPLACEMENTVALUE">
        <xsl:attribute name="REPVAL">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>
</xsl:stylesheet>
