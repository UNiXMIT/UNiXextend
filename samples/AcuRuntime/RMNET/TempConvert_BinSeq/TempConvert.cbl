       identification division.
       program-id.  TempConv.

      * Copyright (C) 2011 Micro Focus or one of its affiliates.
      *
      * The only warranties for products and services of Micro Focus
      * and its affiliates and licensors ("Micro Focus") are set
      * forth in the express warranty statements accompanying such
      * products and services. Nothing herein should be construed as
      * constituting an additional warranty. Micro Focus shall not
      * be liable for technical or editorial errors or omissions
      * contained herein. The information contained herein is
      * subject to change without notice.
      *
      * Contains Confidential Information. Except as specifically
      * indicated otherwise, a valid license is required for possession,
      * use or copying. Consistent with FAR 12.211 and 12.212,
      * Commercial Computer Software, Computer Software Documentation,
      * and Technical Data for Commercial Items are licensed to the U.S.
      * Government under vendor's standard commercial license.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT RESPONSE-FILE
               ASSIGN TO RANDOM,  "response.txt"
               ORGANIZATION IS BINARY SEQUENTIAL,
               ACCESS MODE IS SEQUENTIAL,
               FILE STATUS IS IO-STAT.

       DATA DIVISION.
       FILE SECTION.
       FD  RESPONSE-FILE
            DATA RECORD IS DATA-REC.
       01  DATA-REC.
              05 ONEBYTE            PIC X.

       working-storage section.
       01  IO-STAT                    PIC XX. 
       01  COUNTER                    PIC 9(10).       
       01  Fahrenheit-To-Celsius.
           02  Fahrenheit              pic x(3) value zeros.
               88  is-quit             value spaces.

       01  Fahrenheit-To-Celsius-Response.
           02  Fahrenheit-To-Celsius-Result   pic X(20).

       01  request-payload             usage pointer.
       01  response-payload            usage pointer.
       01  response-status             pic 9(3) value zero.
       01  response-status-2           pic 9(3) value zero.
       01  response-len                pic s9(4).
       01  request-len                 pic s9(4).
       01  a-single-char               pic x.

           copy "lixmlall.cpy".

       01  Desired-SOAP-Action.
          05 filler pic x(10) value 'SOAPAction'.
          05 filler pic x value x"00".
          05 filler pic x(90) value
           '"https://www.w3schools.com/xml/FahrenheitToCelsius"'.
          05 filler pic x value x"00".

       78  Post-Address value
             "https://www.w3schools.com/xml/tempconvert.asmx".

       78  Content-Type value "text/xml; charset=utf-8".

       linkage section.
       01 http-response pic x(100).

       procedure division.
       main.
           XML INITIALIZE.

       a.
           display "Fahrenheit To Celsius Service Sample"
                   line 3 position 10 erase.
           display "Fahrenheit:",    line 5, position 3
                   "Spaces to quit", line 5, position 25
           perform
             with test after
             until (Fahrenheit(1:1) is numeric or
                    Fahrenheit(1:1) = "-") and
                    Fahrenheit(2:) is numeric
               accept Fahrenheit, line 5, position 16,
                                  prompt, update, tab,
                                  control "upper"
               if is-quit
                   go to z
               end-if
           end-perform.

           XML EXPORT FILE
               Fahrenheit-To-Celsius
               "TempFahrenheitRequest.xml"
               "Fahrenheit-To-Celsius"
               "TempConvertRequestF2C.xsl".
           if not XML-OK go to z.

           XML EXPORT TEXT
               Fahrenheit-To-Celsius
               request-payload
               request-len
               "Fahrenheit-To-Celsius"
               "TempConvertRequestF2C.xsl".
           if not XML-OK go to z.
      
      *     XML GET TEXT
      *         request-payload
      *         request-len
      *         "TempFahrenheitRequest.xml".
      *     if not XML-OK go to z.    

           call "NetInit"
             giving
               response-status.

           call "NetSetSSLCA" using "ca-bundle.crt".               

           call "HttpPost"
             using
               Post-Address
               Content-Type
               request-payload
               request-len
               response-payload
               response-len
               Desired-SOAP-Action
             giving
               response-status.

           set address of http-response to response-payload.

           display "Response: ", response-status.

           if not response-status = 0
             call "NetGetError" using response-payload response-len
                                giving response-status-2
             set address of http-response to response-payload
             display "Error! ", response-status
             display "Error message: ", http-response(1:response-len)
             call "NetFree" using response-payload
             go to z
           end-if.

           XML FREE TEXT
               request-payload.

           if response-payload = NULL
               display "Error:  NULL pointer returned", line 10, blink
               accept a-single-char prompt
               go to z
           end-if.

           XML PUT TEXT
               response-payload
               response-len
               "TempFahrenheitResponse.xml".
           if not XML-OK go to z.
           
           open output response-file.
           
           perform varying counter from 1 by 1 
             until counter > response-len
               move http-response(counter:1) to onebyte
               write data-rec
           end-perform.

           XML IMPORT TEXT
               Fahrenheit-To-Celsius-Response
               response-payload
               response-len
               "Fahrenheit-To-Celsius-Response"
               "TempConvertResponseF2C.xsl".
           if not XML-OK go to z.

           call "NetFree"
             using
               response-payload.

           call "NetCleanup".

           display "        Celsius: ", line 10 position 5
                   Fahrenheit-To-Celsius-Result position 0.
           accept a-single-char prompt tab.
           go to a.

       z.
           copy "lixmltrm.cpy".
           display "finished.", line 20 position 5.
           accept a-single-char prompt tab.
           stop run.

           copy "lixmldsp.cpy".
