<?xml version='1.0' ?>
<xsl:stylesheet	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tem="https://www.w3schools.com/xml/">
	<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/">
		<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
			<soap:Body>
				<tem:FahrenheitToCelsius>
					<tem:Fahrenheit>
						<xsl:value-of select="fahrenheit-to-celsius/fahrenheit"/>
					</tem:Fahrenheit>
				</tem:FahrenheitToCelsius>
			</soap:Body>
		</soap:Envelope>
	</xsl:template>
</xsl:stylesheet>
