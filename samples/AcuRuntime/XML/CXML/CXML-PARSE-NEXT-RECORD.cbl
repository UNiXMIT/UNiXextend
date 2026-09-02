       IDENTIFICATION DIVISION.
       PROGRAM-ID. CXML-READ-NEXT.
       AUTHOR.  CCCCCC. 
       REMARKS.    
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           SYSERR IS ERROR-LOG  
           DECIMAL-POINT IS COMMA.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
       DATA DIVISION.
       FILE SECTION.
       
       WORKING-STORAGE SECTION.
       COPY "acucobol.def".

       01 hParser            usage handle.
       01 hRoot              usage handle.       
       01 hElement           usage handle.
       01 hSubElement        usage handle. 
       01 hSubElementSibling usage handle.  
       01 hFirstRecord       usage handle.
       01 hNextRecord        usage handle.
       01 hTemp              usage handle.
       01 hTemp2             usage handle.
       
       01 text-error         pic x(50).   
       01 text-error-1       pic x(200).
       01 num-error          pic 9(3).	
       01 ws-elementName     pic x(100).   
       01 ws-elementValue    pic x(100).  
       01 ws-elementLenght   pic 9(3)  value 0. 
       01 ws-counter         pic 9(10) value 0. 
       01 ws-display-counter pic 9(10) value 0. 
       01 ws-display-text    pic x(70).
       01 ws-continue        pic x    value spaces.
       01 string-ptr         pic 99.
       
       01 ws-output-xml-file-name        pic x(20) value "testfile.xml".
       01 ws-num-of-records-to-create    pic 9(10) value 1000.
       
       01 ws-input-xml-file-name         pic x(50) value "testfile.xml".                                             
       
       LINKAGE SECTION.       
       SCREEN SECTION.
       PROCEDURE DIVISION.
       MAIN-LOGIC.
                    
           PERFORM CREATE-XML-FILE                                        | CREATE
           PERFORM READ-XML-FILE-NEXT                                     | READ                                                  
                         
       	  goback.
       
       CREATE-XML-FILE.
            call "c$xml" using cxml-new-parser
            move return-code to hParser.           
            PERFORM ADD-ROOT.
            INITIALIZE ws-counter
            PERFORM ADD-RECORDS ws-num-of-records-to-create TIMES.     
            PERFORM SAVE-FILE.              

        ADD-ROOT.
            call "c$xml" using cxml-add-child
                 hParser
                 "ROOT"
                 giving hRoot
            if hRoot not > 0
              move "Error creating ROOT" to text-error
              perform print-errors
            end-if
            .
            
        ADD-RECORDS.
            INITIALIZE ws-elementValue  
            add 1 to ws-counter
            
            STRING "Element-" ws-counter
                   INTO ws-elementValue
                   
            call "c$xml" using cxml-add-child
                 hRoot
                 ws-elementValue
                 giving hElement
            
            INITIALIZE ws-elementValue  
            MOVE ws-counter TO ws-elementValue
            MOVE LENGTH OF ws-elementValue TO ws-elementLenght
            
            call "c$xml" using cxml-add-child
                           hElement
                           "SubElement"
                           ws-elementValue
                           ws-elementLenght
                     giving hSubElement
                     
            CALL "C$XML" USING CXML-ADD-SIBLING, 
                           hSubElement, 
                           "SubElementSibling", 
                     giving hSubElementSibling

            INITIALIZE ws-elementValue              
            STRING "1st VALUE of Sibling" 
                   INTO ws-elementValue
            MOVE LENGTH OF ws-elementValue TO ws-elementLenght
            
            call "c$xml" using cxml-add-child
                           hSubElementSibling
                           "SubSubElementSibling"
                           ws-elementValue
                           ws-elementLenght 
                            
            INITIALIZE ws-elementValue                  
            STRING "2nd VALUE of Sibling" 
                   INTO ws-elementValue
            MOVE LENGTH OF ws-elementValue TO ws-elementLenght
            
            call "c$xml" using cxml-add-child
                           hSubElementSibling
                           "SubSubElementSibling"
                           ws-elementValue
                           ws-elementLenght
                           .

        SAVE-FILE.
            inspect ws-output-xml-file-name replacing trailing spaces 
                                            by low-values          
            call "c$xml" using CXML-WRITE-FILE
                            hParser
                           ws-output-xml-file-name
            call "c$xml" using cxml-release-parser
                           hParser
                              
           display message box "I've created a "
                               ws-num-of-records-to-create
                               " records XML file."    
                               TITLE "XML file"  
            .              

        print-errors.
            call "c$xml" using cxml-get-last-error 
                           text-error-1
                     giving num-error
            display message box
                text-error-1 x"0d0a" num-error
                title text-error
            goback
            . 
            
       
       READ-XML-FILE-NEXT.
           INITIALIZE ws-counter
           inspect ws-input-xml-file-name replacing trailing spaces 
                                          by low-values 
           
           call "c$xml" using CXML-OPEN-FILE 
                              ws-input-xml-file-name
           move return-code to hParser 
           
           call "c$xml" using CXML-PARSE-NEXT-RECORD
                              hParser 
                              
           add 1 to ws-counter 
           
           call "C$XML" using CXML-GET-FIRST-CHILD, hParser
           move return-code to hNextRecord    
           if return-code = 0  
              perform print-errors                        
           end-if        
                          
           move hNextRecord to hTemp     
           perform GET-DATA                                        
           
           perform until ws-continue = "Q" or "q"
              call "c$xml" using CXML-PARSE-NEXT-RECORD
                                 hParser
              if return-code = 0
                 exit perform
              else              
                 call "C$XML" using CXML-GET-NEXT-SIBLING, hNextRecord
                 move return-code to hNextRecord    
                 
                 if return-code = 0  
                    perform print-errors                        
                 end-if         
                 
                 add 1 to ws-counter              
                 move hNextRecord to hTemp     
                 perform GET-DATA                                        
              end-if   
           end-perform
                                          
           call "c$xml" using cxml-release-parser
                              hParser.
                              
           display message box "I've read "
                               ws-counter
                               " records."    
                               TITLE "CXML-PARSE-NEXT-RECORD"               
           .
           
       GET-DATA.
           set string-ptr to 1.
           
           call "C$XML" using CXML-GET-DATA
                        hTemp
                        ws-elementName
                        ws-elementValue
                        ws-elementLenght    
                        
           if return-code = 0  
              perform print-errors                        
           end-if   
           
           string ws-elementName(1:20) into ws-display-text
                                       pointer string-ptr
           
           call "C$XML" using CXML-GET-FIRST-CHILD, hTemp
           move return-code to hTemp2
           
           call "C$XML" using CXML-GET-DATA
                        hTemp2
                        ws-elementName
                        ws-elementValue
                        ws-elementLenght    
                        
           if return-code = 0  
              perform print-errors                        
           end-if   
           
           string " > "
                  ws-elementName(1:20)
                  " > "
                  ws-elementValue(1:40) into ws-display-text
                                        pointer string-ptr
           
           display ws-display-text
           add 1 to ws-display-counter
           if ws-display-counter(10:1) = 0 
              and ws-continue not = "C"
              and ws-continue not = "c"
                 display "Type Q to quit; C to continue until the end: "
                 accept ws-continue
           end-if              
           .