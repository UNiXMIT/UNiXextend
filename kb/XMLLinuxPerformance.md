# Very slow performance of XML EXPORT FILE on Linux
## Problem
When using XML EXTENSIONS, the statement XML EXPORT FILE using an XSLT stylesheet takes a few seconds on Windows but on Linux it takes between 2 and 4 minutes.  

## Resolution
The issue is with the 3rd party stylesheet processor library. On Windows, Microsoft’s stylesheet processor performs a lot better. There isn't anything that can be done to improve performance on Linux until the 3rd party library is fixed by its authors.  
If the desired final output needs to be in JSON format, there has been a new feature added in 10.4.0 to generate and parse JSON (added in 10.4.0 by ECN-4700).  