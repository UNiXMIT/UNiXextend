       IDENTIFICATION DIVISION.
       PROGRAM-ID. MY-OPENSAVEBOX.
       AUTHOR. CLAUDIO.CONTARDI @ MICROFOCUS. 
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.       
       DATA DIVISION.
       FILE SECTION.       
       
       WORKING-STORAGE SECTION.
       
       78  NEWLINE      VALUE H"0A". 

******* This item returns the status of the operation. 
******* A value of "1" indicates that the operation completed successfully. 
******* A zero or negative value indicates that the operation failed.            
       01  OPENSAVE-STATUS                   PIC S99. 
         
       01  OP-CODE                           PIC 99.           
       01  WK-OP-CODE                        PIC XX.  

       01  WK-OPENSAVE-DATA.
           03  WK-OPNSAV-FILENAME            PIC X(256).
           03  WK-OPNSAV-FLAGS               PIC X(4) COMP-X.
           03  WK-OPNSAV-DEFAULT-EXT         PIC X(12).
           03  WK-OPNSAV-TITLE               PIC X(80).
           03  WK-OPNSAV-FILTERS             PIC X(512).
           03  WK-OPNSAV-DEFAULT-FILTER      PIC X(4) COMP-X.
           03  WK-OPNSAV-DEFAULT-DIR         PIC X(128).
           03  WK-OPNSAV-BASENAME            PIC X(128).
       
       COPY "OPENSAVE.DEF".  
       
       PROCEDURE DIVISION.
       MAIN-LOGIC.

           INITIALIZE OPENSAVE-DATA WK-OPENSAVE-DATA

           ACCEPT WK-OPNSAV-FILENAME FROM ENVIRONMENT 
                                      "CFG-OPNSAV-FILENAME"    
           MOVE WK-OPNSAV-FILENAME TO OPNSAV-FILENAME                                               

           ACCEPT WK-OPNSAV-FLAGS FROM ENVIRONMENT 
                                      "CFG-OPNSAV-FLAGS"
           MOVE WK-OPNSAV-FLAGS TO OPNSAV-FLAGS                                      

           ACCEPT WK-OPNSAV-DEFAULT-EXT FROM ENVIRONMENT 
                                      "CFG-OPNSAV-DEFAULT-EXT"
           MOVE WK-OPNSAV-DEFAULT-EXT TO OPNSAV-DEFAULT-EXT
 
           ACCEPT WK-OPNSAV-TITLE FROM ENVIRONMENT  
                                      "CFG-OPNSAV-TITLE"  
           MOVE WK-OPNSAV-TITLE TO OPNSAV-TITLE
                                      
           ACCEPT WK-OPNSAV-FILTERS FROM ENVIRONMENT 
                                      "CFG-OPNSAV-FILTERS"
           MOVE WK-OPNSAV-FILTERS TO OPNSAV-FILTERS
                                      
           ACCEPT WK-OPNSAV-DEFAULT-FILTER FROM ENVIRONMENT 
                                      "CFG-OPNSAV-DEFAULT-FILTER"
           MOVE WK-OPNSAV-DEFAULT-FILTER TO OPNSAV-DEFAULT-FILTER

           ACCEPT WK-OPNSAV-DEFAULT-DIR FROM ENVIRONMENT  
                                      "CFG-OPNSAV-DEFAULT-DIR" 
           MOVE WK-OPNSAV-DEFAULT-DIR TO OPNSAV-DEFAULT-DIR

           ACCEPT WK-OP-CODE FROM ENVIRONMENT  
                                      "CFG-OP-CODE"
           MOVE WK-OP-CODE TO OP-CODE

           CALL "C$OPENSAVEBOX"  
                USING OP-CODE, 
                      OPENSAVE-DATA 
                GIVING OPENSAVE-STATUS 

           DISPLAY MESSAGE BOX 
                     "C$OPENSAVEBOX:", NEWLINE,
                     "BASENAME -> " OPNSAV-BASENAME
                     TITLE IS "C$OPENSAVEBOX Result"
                     
           
           GOBACK.