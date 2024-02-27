# Very slow performance of XML EXPORT FILE on Linux
## Problem
When using XML EXTENSIONS, the statement XML EXPORT FILE using an XSLT stylesheet takes a few seconds on Windows but on Linux it takes between 2 and 4 minutes.  

## Resolution
The issue is with the 3rd party stylesheet processor library. On Windows, Microsoft’s stylesheet processor performs a lot better. There isn't anything that can be done to improve performance on Linux until the 3rd party library is fixed by its authors.  
If the desired final output needs to be in JSON format, there has been a new feature added in 10.4.0 to generate and parse JSON - https://www.microfocus.com/documentation/extend-acucobol/1040/extend_release_notes/GUID-7196E860-AED6-4DEA-9D83-7FEE1730ADCD.html  