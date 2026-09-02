       identification division.
       program-id. CEXITINFO.
       remarks.
       environment division.
       input-output section.
       data division.
       file section.        
       working-storage section.
       
       77  EXIT-MESSAGE        pic x(500).
       77  EXIT-CODE           pic 9.
         88  COBOL_EXIT_PROGRAM   value 1.
         88  COBOL_REMOTE_CALL    value 2.
         88  COBOL_STOP_RUN       value 3.
         88  COBOL_CALL_ERROR     value 4.
         88  COBOL_SIGNAL         value 5.
         88  COBOL_FATAL_ERROR    value 6.
         88  COBOL_NONFATAL_ERROR value 7.
         88  COBOL_DEBUGGER       value 8.
       77  OS-EXIT-CODE        pic 9(5).
       77  SIGNAL-NUMBER       pic 9(5).

       procedure division.

       DECLARATIVES.
       PROGRAM-ERROR-HANDLING SECTION. 
           USE AT PROGRAM END.
           CALL "C$EXITINFO" 
               USING EXIT-MESSAGE, EXIT-CODE, 
                     OS-EXIT-CODE, SIGNAL-NUMBER
           
           display message box "EXIT-MESSAGE: " EXIT-MESSAGE x"0d0a"
                               "EXIT-CODE:    " EXIT-CODE 
           .    

       END DECLARATIVES. 
      
       main-logic.

           CALL "myProg.acu".

       main-exit.                  	   
       	   stop run.

       	   
