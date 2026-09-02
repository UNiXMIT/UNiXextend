README

Tab Control Side Menu POC

Instructions:
* Extract the file "add-to-etc.zip" into etc.
* Run the Gateway with "1040-32_gateway-cert.conf" configuration file (or copy the properties from there).
* Run tab-control.acu with the theme "tabs":
	Add the alias "tab-control".
	URL: <host>:<port>?alias=tab-control&theme=tabs
* Wait until the resource "myscript-tab.js" loads - 
	you will see that the first and second tab items are colored and the 2nd tab is picked.
	
	
Workflow:
1. Click "Push Button 2" - tab 2 is done and changed to tab 3.
2. Click "Push Button 3" - tab 3 is done and changed to tab 4.
3. Click "Push Button 4" - tab 4 is done and msg box appears.
