       IDENTIFICATION DIVISION.
       PROGRAM-ID.  TESTREGEXP.
       REMARKS.
***********  
*******        
******* ccbl32 -ga -di TESTREGEXP.cbl
******* 
***********  
******* 
******* Regular Expression Basic Syntax Reference
******* http://www.regular-expressions.info/reference.html
******* 
******* CAtlRegExp Class  
******* http://msdn.microsoft.com/en-us/library/k3zs4axe%28VS.80%29.aspx
******* 
***********  
******* The error value is returned in return-value. 
******* The possible error values (described in "acucobol.def") have the following meanings:
*******
*******  0 AREGEXP-ERROR-NO-ERROR         -- No error
*******  1 AREGEXP-ERROR-NO-MEMORY        -- Insufficient memory to handle the request
*******  2 AREGEXP-ERROR-BRACE-EXPECTED   -- A closing brace is missing
*******  3 AREGEXP-ERROR-PAREN-EXPECTED   -- A closing parenthesis is missing
*******  4 AREGEXP-ERROR-BRACKET-EXPECTED -- A closing bracket is missing
*******  5 AREGEXP-ERROR-UNEXPECTED       -- An unknown error occurred
*******  6 AREGEXP-ERROR-EMPTY-RANGE      -- An empty range was given
*******  7 AREGEXP-ERROR-INVALID-GROUP    -- The group provided was invalid
*******  8 AREGEXP-ERROR-INVALID-RANGE    -- An invalid range was given
*******  9 AREGEXP-ERROR-EMPTY-REPEATOP   -- A repeat operator was given on an empty subexpression
******* 10 AREGEXP-ERROR-INVALID-INPUT    -- The input was invalid
******* 11 AREGEXP-ERROR-INVALID-HANDLE   -- The handle is not a regular expression handle or a match handle
******* 12 AREGEXP-ERROR-INVALID-ARGUMENT -- One of the arguments given is invalid
******* 13 AREGEXP-ERROR-INVALID-CALL-SEQ -- The order of C$REGEXP operations is an invalid sequence.
******* 14 AREGEXP-ERROR-NO-MATCH         -- The regular expression did not find a match in the given string. 
*******
***********       
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
       DATA DIVISION.
       
       FILE SECTION.
       WORKING-STORAGE SECTION.
       77 W-STRINGA                 PIC X(500).
       77 W-CERCA                   PIC X(40).
       77 RISPX                     PIC X.
       77 W-START                   PIC 9(4)  COMP-5.
       77 W-END                     PIC X.
       77 RET-HANDLE-COMP           HANDLE.
       77 RET-HANDLE-MATCH          HANDLE.
       77 return-value              PIC 99.

       PROCEDURE DIVISION.
       Main Section.
           DISPLAY " " ERASE screen.
           DISPLAY "C$REGEXP sample code"
           
           CALL "C$REGEXP" USING 1 |AREGEXP-GET-LEVEL 
                           GIVING return-value 
                           
           EVALUATE return-value
              WHEN 0
                DISPLAY "regular expression processing is not available"
              WHEN 1
                DISPLAY "Windows regular expressions supported"
              WHEN 2
                DISPLAY "POSIX regular expressions supported"           
           END-EVALUATE  
           
           ACCEPT omitted   
           
           PERFORM Test-String-Not-Found.
           PERFORM Test-String-Found.
           PERFORM Test-Find-http.
           PERFORM Test-Validating-Email.
           
           PERFORM End-Section.
           
*********** 
        Test-String-Not-Found.
           INITIALIZE W-START        
                 
           MOVE "(ACUCOBOL-GT)|(10.3.1)" TO W-STRINGA
           DISPLAY "Compiling Regular Expression: "  LINE 6 POSITION 1
                   W-STRINGA  LINE 6 POSITION 32
           INSPECT W-STRINGA REPLACING TRAILING SPACES BY X"00"
           
           ACCEPT omitted   
           
           CALL "C$REGEXP" USING 2 | AREGEXP-COMPILE       
                                 W-STRINGA       
                                 1 
                          GIVING RET-HANDLE-comp
                          
           IF RET-HANDLE-comp = null
              display "Error compiling the given Regular Expression"
           END-IF                  

           MOVE "I love to develop in any language" TO W-CERCA
           DISPLAY "String to work on: " LINE 7 POSITION 1
                   W-CERCA    LINE 7 POSITION 32
           INSPECT W-CERCA REPLACING TRAILING SPACES BY X"00"
           
           ACCEPT omitted   
           
           CALL "C$REGEXP" USING 3 | AREGEXP-MATCH
                                 RET-HANDLE-COMP 
                                 W-CERCA
                                 0 W-START W-END
                          GIVING RET-HANDLE-MATCH

           IF RET-HANDLE-MATCH = 0
              
              CALL "C$REGEXP" USING 20 | AREGEXP-LAST-ERROR 
                              GIVING return-value   
                              
              DISPLAY "Error: " LINE 8 POSITION 1
              
              EVALUATE return-value
                WHEN 14
                  DISPLAY "The regular expression did not find a match i"
      -           "n the given string."
              END-EVALUATE
              
           ELSE
              DISPLAY "String found at position " LINE 8 POSITION 1
                      W-START
                       
           END-IF

           ACCEPT omitted.
           
*********** 
        Test-String-Found.
           INITIALIZE W-START

           MOVE "(ACUCOBOL-GT)|(10.3.1)" TO W-STRINGA
           DISPLAY "Compiling Regular Expression: "  LINE 12 POSITION 1
                   W-STRINGA  LINE 12 POSITION 32
           INSPECT W-STRINGA REPLACING TRAILING SPACES BY X"00"
           
           ACCEPT omitted   
           
           CALL "C$REGEXP" USING 2 | AREGEXP-COMPILE       
                                 W-STRINGA       
                                 1 
                          GIVING RET-HANDLE-comp
                          
           IF RET-HANDLE-comp = null
              display "Error compiling the given Regular Expression"
           END-IF                  

           MOVE "I am using ACUCOBOL-GT" TO W-CERCA
           DISPLAY "String to work on: " LINE 13 POSITION 1
                   W-CERCA    LINE 13 POSITION 32
           INSPECT W-CERCA REPLACING TRAILING SPACES BY X"00"
           
           ACCEPT omitted   
           
           CALL "C$REGEXP" USING 3 | AREGEXP-MATCH
                                 RET-HANDLE-COMP 
                                 W-CERCA
                                 0 W-START W-END
                          GIVING RET-HANDLE-MATCH

           IF RET-HANDLE-MATCH = 0
              
              CALL "C$REGEXP" USING 20 | AREGEXP-LAST-ERROR 
                              GIVING return-value   
                              
              DISPLAY "Error: " LINE 14 POSITION 1
              
              EVALUATE return-value
                WHEN 14
                  DISPLAY "The regular expression did not find a match i"
      -           "n the given string."
              END-EVALUATE       
              
           ELSE
              DISPLAY "String found at position " LINE 14 POSITION 1
                      W-START
                       
           END-IF

           ACCEPT omitted .        
           
*********** 
        Test-Find-http.
           INITIALIZE W-START        

           MOVE "(http\:\/\/[a-zA-Z0-9_\-]+[a-zA-Z0-9_\-])"
           TO W-STRINGA

           DISPLAY "Compiling Regular Expression: "  LINE 18 POSITION 1
                   W-STRINGA  LINE 18 POSITION 32           
           INSPECT W-STRINGA REPLACING TRAILING SPACES BY X"00"
           
           ACCEPT omitted   
           
           CALL "C$REGEXP" USING 2 | AREGEXP-COMPILE          
                                 W-STRINGA       
                                 9 
                          GIVING RET-HANDLE-comp
                          
           IF RET-HANDLE-comp = null
              display "Error compiling the given Regular Expression"
           END-IF                  

           MOVE "http://www.mywebsite.com" TO W-CERCA
           DISPLAY "String to work on: " LINE 19 POSITION 1
                   W-CERCA    LINE 19 POSITION 32
           INSPECT W-CERCA REPLACING TRAILING SPACES BY X"00"
           
           ACCEPT omitted   
           
           CALL "C$REGEXP" USING 3 
                                 RET-HANDLE-COMP 
                                 W-CERCA
                                 0 W-START W-END
                          GIVING RET-HANDLE-MATCH

           IF RET-HANDLE-MATCH = 0
              
              CALL "C$REGEXP" USING 20 | AREGEXP-LAST-ERROR 
                              GIVING return-value   
                              
              DISPLAY "Error: " LINE 20 POSITION 1
              
              EVALUATE return-value
                WHEN 14
                  DISPLAY "The regular expression did not find a match i"
      -           "n the given string."
              END-EVALUATE
                                   
              
           ELSE
              DISPLAY "String found at position " LINE 20 POSITION 1
                      W-START
                       
           END-IF
           
           ACCEPT omitted.   
           
*********** 
        Test-Validating-Email.
           INITIALIZE W-START        
        
           DISPLAY " " ERASE screen.
        
           MOVE "[a-z0-9_]+@[a-z0-9\-]+\.[a-z0-9\-\.]"           
           TO W-STRINGA

           DISPLAY "Compiling Regular Expression: "  LINE 6 POSITION 1
                   W-STRINGA  LINE 6 POSITION 32           
           INSPECT W-STRINGA REPLACING TRAILING SPACES BY X"00"
           
           ACCEPT omitted   
           
           CALL "C$REGEXP" USING 2 | AREGEXP-COMPILE          
                                 W-STRINGA       
                                 9 
                          GIVING RET-HANDLE-comp
                          
           IF RET-HANDLE-comp = null
              display "Error compiling the given Regular Expression"
           END-IF                  

           MOVE "mia.email@dominio.com" TO W-CERCA
           DISPLAY "String to work on: " LINE 7 POSITION 1
                   W-CERCA    LINE 7 POSITION 32
           INSPECT W-CERCA REPLACING TRAILING SPACES BY X"00"
           
           ACCEPT omitted   
           
           CALL "C$REGEXP" USING 3 
                                 RET-HANDLE-COMP 
                                 W-CERCA
                                 0 W-START W-END
                          GIVING RET-HANDLE-MATCH

           IF RET-HANDLE-MATCH = 0
              
              CALL "C$REGEXP" USING 20 | AREGEXP-LAST-ERROR 
                              GIVING return-value   
                              
              DISPLAY "Error: " LINE 8 POSITION 1
              
              EVALUATE return-value
                WHEN 14
                  DISPLAY "The regular expression did not find a match i"
      -           "n the given string."
              END-EVALUATE
                                   
              
           ELSE
              DISPLAY "String found at position " LINE 8 POSITION 1
                      W-START
                       
           END-IF
           
           ACCEPT omitted   .
           
*********** 
        End-Section.

           DISPLAY "Bye bye!" LINE 22 POSITION 50

           ACCEPT omitted   

           GOBACK.     
           
            
