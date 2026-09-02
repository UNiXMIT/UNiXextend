       identification division.
       program-id. Print. 
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
       input-output section.
       file-control.
           select file-output 
           ASSIGN TO PRINT ws-printer
           organization is LINE SEQUENTIAL                                      
           FILE STATUS IS FILE-STATUS.
       
       data division.
       file section.              
       FD file-output.
       01 file-output-rec.
           05 file-record           PIC  X(132).
                                     
       
       working-storage section.
       77 FILE-STATUS          pic XX. 
       77 ws-x                 pic 999 value 0.
       
       01 WS-PRINTER           PIC X(51) VALUE spaces.
       01 result               PIC S9(9) COMP-5.
	   COPY "ACUGUI.DEF".
       COPY "WINPRINT.DEF".
       COPY "FONTS.DEF".
       COPY "CRTVARS.DEF".
       
       procedure division.
       main-logic.
   
           move "-p spooler-direct" to ws-printer
           open output file-output.

		   CALL "WIN$PRINTER" 
             USING WINPRINT-GET-PRINTER-INFO 
                          WINPRINT-SELECTION
                              giving result

		   CALL "WIN$PRINTER"
                  using WINPRINT-SET-PRINTER-EX WINPRINT-SELECTION
                  giving result
  
           
           move "Test Print"
           to file-record
              
           
           write file-output-rec
           close file-output.
     
           stop run.