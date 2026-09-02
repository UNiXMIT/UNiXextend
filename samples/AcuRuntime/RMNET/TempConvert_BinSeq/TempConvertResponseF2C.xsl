<?xml version='1.0' encoding='utf-8' ?>
<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:a="https://www.w3schools.com/xml/">
	<xsl:output method="html" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/">
		<Fahrenheit-To-Celsius-Response>
			<Fahrenheit-To-Celsius-Result>
				<xsl:value-of select="//a:FahrenheitToCelsiusResult"/>
			</Fahrenheit-To-Celsius-Result>
		</Fahrenheit-To-Celsius-Response>
	</xsl:template>
</xsl:stylesheet>
