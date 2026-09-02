       identification division.
       program-id. prog-called.
       remarks.
       
       environment division.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
       input-output section.
       file-control.
       
      *{Bench}file-control
      *{Bench}end
       data division.
       file section.

       working-storage section.
       77  wk-string    pic x(50).
       77  wk-int       pic 9(5).
       
       LINKAGE SECTION.       
       77 ln-n  usage handle.
       77 ln-x  usage handle.        

       SCREEN SECTION.
       procedure division using ln-n, ln-x.
       main-logic.
       
      * GET VALUES passed from .Net to COBOL
           CALL "C$GETVARIANT" USING ln-n,  wk-int. 
           CALL "C$GETVARIANT" USING ln-x,  wk-string. 

           compute wk-int = wk-int + 7
           move "New Value" to wk-string
           
           display message box wk-string ":" wk-int
           
      * SET VALUES to provide back from COBOL to .Net
           CALL "C$SETVARIANT" USING wk-int, ln-n
           CALL "C$SETVARIANT" USING wk-string, ln-x            
           .
       	   goback.