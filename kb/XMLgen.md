# XML GENERATE cannot handle large data
## Environment
AcuCOBOL-GT extend  
Windows  
Linux/UNIX  

## Situation
When compiling a COBOL program that defines a large number of data items and uses the XML GENERATE statement to create an XML document, the compilation fails with multiple instances of the following error message:  

`xmlgen.cbl, line XXXX: Statement too large at code address XX` 

This may occur when the XML GENERATE statement processes a very large number of data items, potentially approaching internal limits on statement or paragraph size.    

## Resolution
When using XML GENERATE, the compiler internally produces multiple CALL statements. In some cases, this can exceed the paragraph size limit of 32k.  
This behaviour is due to a limitation in the current design of XML GENERATE within ACUCOBOL-GT.  
This limitation cannot be resolved without a fundamental redesign of the XML GENERATE functionality. To address this, an enhancement request would need to be submitted for future consideration.  
If you would like to submit an enhancement request for this, please create a new case in the [RCC Portal](https://my.rocketsoftware.com/RocketCommunity/s/).  