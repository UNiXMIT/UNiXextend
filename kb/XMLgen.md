# XML GENERATE cannot handle large data
## Environment
AcuCOBOL-GT extend  
Windows  
Linux/UNIX  

## Situation
A COBOL program has a large amount of data items and uses XML GENERATE to create an XML file based on those data items. When compiling it fails with multiple instances of the error:  

`xmlgen.cbl, line XXXX: Statement too large at code address XX` 

Is this a hitting a limitation in XML GENERATE? The error seems to indicate that it is hitting the maximum Paragraph size of 32k.  

## Resolution
When using XML GENERATE, the compiler internally produces multiple CALL statements. In some cases, this can exceed the paragraph size limit.  
This behaviour is due to a limitation in the current design of XML GENERATE within ACUCOBOL-GT.  
This limitation cannot be resolved without a fundamental redesign of the XML GENERATE functionality. To address this, an enhancement request would need to be submitted for future consideration.  
If you would like to submit an enhancement request for this, please create a new case in the [RCC Portal](https://my.rocketsoftware.com/RocketCommunity/s/).  