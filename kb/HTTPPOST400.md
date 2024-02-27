# HTTPPOST with extra headers returns error ‘HTTP 400 - Bad Request’
## Environment
All versions of AcuCOBOL-GT extend with RMNET  
All platforms  

## Situation
When using the HTTPPOST function with extra headers the response received is ‘HTTP 400 - Bad Request’.  
 
## Resolution
When using either HTTPPOST or HTTPGET there is the option to set extra headers. These extra headers could be either SOAPAction or Authorization headers etc. If this is not formatted correctly the server will respond with an error ‘HTTP 400 – Bad Request’  

According to the documentation:  

**extra-headers** - An optional alphanumeric item specifying extra headers to be added to the HTTP header. This argument consists of name/value pairs separated by hex x"00", and ended with two x"00"'s.  

This could be set in the following format in WORKING-STORAGE:  

```
01 EXTRA-HEADERS.
    05 filler PIC X(10) value 'SOAPAction'.
    05 filler PIC X value x"00".
    05 filler PIC X(90) value '"https://SOAPURI"';.
    05 filler PIC X value x"00".
    05 filler PIC X(13) value 'Authorization'.
    05 filler PIC X value x"00".
    05 filler PIC X(30) value 'Basic base64-encoded-password'.
    05 filler PIC X value x"00".
    05 filler PIC X value x"00".
```

For a working example please refer to a COBOL program called TempConvert.cbl, located in:  
%PUBLIC%\documents\Micro Focus\extend x.x.x\sample\rmnet  