       identification division.
       program-id.  ZipCodeCheck.
                                                                
      * Copyright (C) 2011 Micro Focus. All rights reserved.
      *
      * This sample code is supplied for demonstration purposes only
      * on an "as is" basis and is for use at your own risk.
      *
      * This program demonstrates the use of RMNet to consume a REST web 
      * service that returns XML/JSON formatted information based on a 
      * user provided U.S. 5-digit zip code. Additionally, the program 
      * uses XML Extensions to create and process XML documents used to 
      * communicate with the web service. 
      *
      * This sample uses a free web service provided by a third party, 
      * https://www.zipwise.com/webservices/. While a free, limited 
      * license was available in June 2020, future availability and 
      * configuration of the web service is not guaranteed.  

       data division.
       working-storage section.
       
      * field to receive user input of 5-digit zip code
       01  zipcode-to-citydata.
           02  zipcode              pic x(5) value zeros. 
               88  is-quit          value spaces.

      * fields used to receive data returned by web service         
       01  Zipcode-To-Citydata-Response.
           02 zip-returned          pic x(5).  
           02 cities                occurs 3 times.
	           03 city-name         pic x(30).
               03 preferred-status  pic x.                 
           02 county-name           pic x(30).
           02 state-name            pic x(30).
           02 country-name          pic x(30).
           02 area-code             pic x(3).
           02 fips-code             pic x(5). 
           02 time-zone             pic x(6).
           02 daylight-savings      pic x.
           02 latitude              pic x(10).
           02 longitude             pic x(10).
           02 type-code             pic x.
           02 population            pic x(10). 
            
      * parameters for C$SYSTEM call to add xml header and trailer to 
      * json format file required for XML Extensions to process file   
       01  Call-system-parameters.            
           02 cmd-call    pic x(15)  
                value "cmd /c copy /b ". 
           02 parm1       pic x(13) 
                value "header.txt + ". 
           02 parm2       pic x(22) 
                value "ZipcodeResponse.xml + ". 
           02 parm3       pic x(12) 
                value "trailer.txt ".
           02 parm4       pic x(20) 
                value "combinedheader.xml".       
       01  exit-status pic 99    value zeros.
               88 exit-status-ok value 0.              
        
      * fields used with calls to RMNet and XML Extensions                                       
       01  request-payload          usage pointer.
       01  response-payload         usage pointer.
       01  response-status          pic 9(3) value zeros.
       01  response-status-2        pic 9(3) value zeros.
       01  response-len             pic s9(4).
       01  request-len              pic s9(4).

       01  a-single-char            pic x    value spaces.      
           
      * copy file required to define the XML statements and to define
      * some data-items that are referenced
           copy "lixmlall.cpy".   
            
      * parameters used in building string to call HttpPost
       01  Post-Address-build.           
           02 post-head    pic x(48)   value
              "https://www.zipwise.com/webservices/zipinfo.php?".
           02 post-mid     pic x(25)   value
              "key=mujnx5sd4njrmhvt&zip=".                         
           02 post-tail    pic x(12)   value "&format=json".
       01  Post-Address pic x(90)      values spaces.           
       78  Content-Type value "text/json; charset=utf-8".

      * field to receive data returned by web service
       linkage section.
       01  http-response pic x(300).

       procedure division.
       main.
           XML INITIALIZE.

       a.
           display "Enter US 5-digit zip code: "
                   line 3 position 10.
           display "Spaces to quit", line 5, position 25.

           perform
             with test after
             until zipcode(1:) is numeric 
               accept zipcode, line 5, position 16,
                                  prompt, update, tab,
                                  control "upper"
               if is-quit
                   go to z
               end-if
           end-perform.

      * build parameter string to pass to HttpPost, including user input
           string        
                   post-head    delimited by size
                   post-mid     delimited by size
                   zipcode      delimited by size
                   post-tail    delimited by size      
           into post-address.

      * set initial values for fields used for RMNet and XML Extensions
           set request-payload to address of a-single-char.
           set request-len to size of a-single-char.   
     	  
      * initialize the RMNet session
           call "NetInit"
             giving
               response-status.

      * specifies a file containing certificates 
      * of public Certificate Authorities
           call "NetSetSSLCA" using "ca-bundle.crt".
     
      * call to RMNet to initiate an HTTP POST request 
      * and wait for a response
           call "HttpPost"
             using
               Post-Address 
               Content-Type
               request-payload
               request-len
               response-payload
               response-len              
             giving
               response-status.
          
           set address of http-response to response-payload.

           if not response-status = 0
             call "NetGetError" using response-payload response-len
                                giving response-status-2
             set address of http-response to response-payload
             display "Error! ", response-status
             display "Error message: ", http-response(1:response-len)
             call "NetFree" using response-payload
             go to z
           end-if.

           if response-payload = NULL
               display "Error:  NULL pointer returned", line 10, blink
               accept a-single-char prompt
               go to z
           end-if.

      * copies the content of the memory area specified by  
      * response-payload and response-len to the external file 
      * ZipcodeResponse.xml, which is in json format.
           XML PUT TEXT
               response-payload
               response-len
               "ZipcodeResponse.xml".  *> json format file
           if not XML-OK go to z.
       
      * add required xml header and trailer to json format file          
           call "c$system" using call-system-parameters, 96
               giving exit-status.     
           if not exit-status-ok
               display "Header/Trailer merge failed"
               go to z.
      
      * convert json format file to rudimentary xml format file
           XML TRANSFORM FILE
               "combinedheader.xml"  *> output file of C$SYSTEM call
               "step1.xsl"           *> 1st conversion style sheet 
               "step1.xml".          *> output file of 1st conversion
           if not XML-OK go to z.

      * convert rudimentary xml format file to expected xml format file
           XML TRANSFORM FILE
               "step1.xml"           *> output file of 1st conversion
               "step2.xsl"           *> 2nd conversion style sheet 
               "ZipcodeToCitydataResponse.xml". *> final output xml file   
           if not XML-OK go to z.
                                    
      * import xml format file into program memory using xsl style sheet
      * note: handling of occurs clause in xsl style sheet
           XML IMPORT FILE
               Zipcode-To-Citydata-Response     *> working-storage area
               "ZipcodeToCitydataResponse.xml"  *> final output xml file
               "Zipcode-To-Citydata-Response"   *> working-storage area            
               "ZipcodeToCitydataResponse.xsl". *> final xsl style sheet
           if not XML-OK go to z.

      * frees the memory of a pointer given by RMNet
           call "NetFree"
             using
               response-payload.

      * frees up all of the resources owned by an RMNet session
           call "NetCleanup".

           display "City name: ", line 10 position 5
                              city-name(1)  position 0
           display "State name: ", line 11 position 5
                              state-name  position 0.
           display "Area code: ", line 12 position 5
                              area-code   position 0.
           display "Time zone: ", line 13 position 5
                              time-zone   position 0.
           accept a-single-char prompt tab.    

       z.
      * copy file used to display the status of an XML Extensions 
      * operation and then terminates XML Extensions
           copy "lixmltrm.cpy".          
           display "finished.", line 20 position 5.
           accept a-single-char prompt tab.
           stop run.

      * copy file used with lixmltrm.cpy to display the result status 
      * of an XML Extensions operation
           copy "lixmldsp.cpy".
