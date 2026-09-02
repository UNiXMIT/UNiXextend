<?xml version='1.0' encoding='utf-8'?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/">
		<zipcode-to-citydata-response xmlns:xtk="http://microfocus.com/xml-extensions/symbol-table/">
			<zip-returned>
				<xsl:value-of select="//zip"/>
			</zip-returned>
			<cities>
				<xsl:for-each select="//cities/object">
					<city-name>
						<xsl:value-of select="city"/>
					</city-name>
					<preferred-status>
						<xsl:value-of select="preferred"/>
					</preferred-status>
				</xsl:for-each>
			</cities>
			<county-name>
				<xsl:value-of select="//county"/>
			</county-name>
			<state-name>
				<xsl:value-of select="//state"/>
			</state-name>
			<country-name>
				<xsl:value-of select="//country"/>
			</country-name>
			<area-code>
				<xsl:value-of select="//area-code"/>
			</area-code>
			<fips-code>
				<xsl:value-of select="//fips"/>
			</fips-code>
			<time-zone>
				<xsl:value-of select="//time-zone"/>
			</time-zone>
			<daylight-savings>
				<xsl:value-of select="//daylight-savings"/>
			</daylight-savings>
			<latitude>
				<xsl:value-of select="//latitude"/>
			</latitude>
			<longitude>
				<xsl:value-of select="//longitude"/>
			</longitude>
			<type-code>
				<xsl:value-of select="//type"/>
			</type-code>
			<population>
				<xsl:value-of select="//population"/>
			</population>
		</zipcode-to-citydata-response>
	</xsl:template>
</xsl:stylesheet>
