       identification division.
       program-id.  HTTPPOST-FORM.

      * Copyright (C) 2018 Micro Focus. All rights reserved.
      *
      * This sample code is supplied for demonstration purposes only
      * on an "as is" basis and is for use at your own risk.

      * This is not a working example as is. Post-Address needs to
      * point to a real URL that contains a form. Then the payload
      * content needs to be tailored to your needs.
      * More information on the multipart/form-data format can be found
      * here https://www.w3.org/TR/html401/interact/forms.html

      * ccbl32 -ga -sl HTTPPOST-FORM.cbl
      * wrun32 -d -y rmnet.dll -y xmlif.dll HTTPPOST-FORM.acu

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
       01  status-code                 PIC 9(3) value ZERO.
       01  parser-handle               USAGE HANDLE.
       01  file-name                   PIC X(50) VALUE "customer.xml".
       01  file-data                   PIC X(20000) value spaces. 
       01  request-data                PIC X(20000) value spaces.
       
       01  Post-Address                PIC X(200) value "https://mfmit.ddns.net/api".

       78  Content-Type value 'multipart/form-data; boundary="MultipartBoundry"'.
        
       linkage section.
       01  response-data               PIC X(2000).

       procedure division.
           PERFORM setup
           PERFORM httppost
           PERFORM get-response
           GOBACK.

       setup.
           XML INITIALIZE
           INITIALIZE request-payload request-len
           SET request-payload TO ADDRESS OF request-data
           
           CALL "NetInit" GIVING response-status
           CALL "NetSSLVerifyPeer" USING SSL-verifypeer-flag 
                                   GIVING status-code.
           CALL "HttpSetResponseHeader" USING 1 
                                        GIVING status-code

           call "C$XML" using CXML-PARSE-FILE
                              file-name 
           move return-code to parser-handle
      
           call "C$XML" using CXML-WRITE-STRING
                              PARSER-HANDLE
                              file-data

      *    This is the multipart/form-data format payload content                      
           STRING '--MultipartBoundry'
                  H"0D0A"
                  'Content-Disposition: form-data; name="username"'
                  H"0D0A"
                  'username'
                  H"0D0A" 
                  '--MultipartBoundry'
                  H"0D0A"
                  'Content-Disposition: form-data; name="password"'
                  H"0D0A"
                  'password'
                  H"0D0A"
                  '--MultipartBoundry'
                  H"0D0A"
                  'Content-Disposition: form-data; name="uploadfile"; filename="customer.xml"'
                  H"0D0A"
                  'Content-Type: application/xml'
                  H"0D0A"
                  file-data
                  H"0D0A"
                  "--MultipartBoundry--"
               INTO request-data

               SET request-len TO SIZE OF request-data.

       httppost.
           CALL "HttpPost"
             USING
               Post-Address
               Content-Type
               request-payload
               request-len
               response-payload
               response-len
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
               "response.html"
           END-IF

           CALL "NetFree" USING response-payload.

           
