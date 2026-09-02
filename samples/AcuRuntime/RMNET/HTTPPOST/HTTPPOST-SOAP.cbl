       identification division.
       program-id.  HTTPPOST-SOAP.

      * Copyright (C) 2018 Micro Focus. All rights reserved.
      *
      * This sample code is supplied for demonstration purposes only
      * on an "as is" basis and is for use at your own risk.

      * This is not a working example as is. Post-Address needs to
      * point to a real URI. Then the SOAPAction and Autorization
      * header content needs to be tailored to your needs.
      * Remeber that the password needs to be base64 encoded.

       data division.
       working-storage section.
       COPY "acucobol.def".
       COPY "lixmlall.cpy".

       01  request-payload             USAGE POINTER.
       01  request-len                 PIC s9(6) value ZERO.
       01  response-payload            USAGE POINTER.
       01  response-len                PIC s9(6) value ZERO.
       01  response-status             PIC 9(3) value ZERO.

       01  SSL-verifypeer-flag         PIC 9 value 0.
       01  status-code                 PIC 9(3) value zero.
       01  parser-handle               USAGE HANDLE.
       01  file-name                   PIC X(50) VALUE "Request.xml".
       01  request-data                PIC X(1500).
       
       01  Desired-SOAP-Action.
          05 filler PIC X(10) value 'SOAPAction'.
          05 filler PIC X value x"00".
          05 filler PIC X(54) value '"https://SOAPURI"'.
          05 filler PIC X value x"00".
          05 filler PIC X(13) value 'Authorization'.
          05 filler PIC X value x"00".
          05 filler PIC X(30) value 'Basic base64-encoded-password'.
          05 filler PIC X value x"00".

       78  Post-Address value "https://yourURI.com".

       78  Content-Type value "text/xml; charset=utf-8".
        
       linkage section.
       01  response-data                PIC X(1500).

       procedure division.
           PERFORM setup
           PERFORM httppost
           PERFORM get-response
           GOBACK.

       setup.
           CALL "C$XML" USING CXML-PARSE-FILE
                              file-name 
           MOVE RETURN-CODE TO parser-handle
      
           CALL "C$XML" USING CXML-WRITE-STRING
                              PARSER-HANDLE
                              request-data

           SET request-payload TO ADDRESS OF request-data
      *     SET request-len TO SIZE OF request-data

           CALL "NetInit" GIVING response-status
           CALL "NetSSLVerifyPeer" USING SSL-verifypeer-flag 
                                   GIVING status-code.

       httppost.
           CALL "HttpPost"
             USING
               Post-Address
               Content-Type
               request-payload
               request-len
               response-payload
               response-len
               Desired-SOAP-Action
             GIVING
               response-status.

       get-response.                
           SET ADDRESS OF response-data TO response-payload           

           IF NOT response-status = 0
               DISPLAY MESSAGE BOX "Response Status = " response-status
           ELSE
               XML PUT TEXT
               response-payload
               response-len
               "response.ext"
           END-IF

           CALL "NetFree" USING response-payload.             
