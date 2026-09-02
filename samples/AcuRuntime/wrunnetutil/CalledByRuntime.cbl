       identification division.  
       program-id. CalledByRuntime.  
       environment division.  
       configuration section.  
       data division.  
       working-storage section.  
       77  variabile-confi   pic x(30).
       77  working-string    pic x(50).
       77  working-int       pic 9(5).
       01  working-struct.
           05 ws-string    pic x(50).
           05 ws-int       pic 9(5).
           
 
       linkage section.  
      *    linkage contains handles only
       77  string-in-out  usage handle.
       77  int-in-out     usage handle.  
       01  struct-in-out  usage handle.
 
       procedure division using string-in-out, 
                                int-in-out, 
                                struct-in-out.  
                                
       main-logic.  
      * GET VALUES passed from .Net to COBOL
           CALL "C$GETVARIANT" USING string-in-out,  working-string. 
           CALL "C$GETVARIANT" USING int-in-out,     working-int. 
           CALL "C$GETVARIANT" USING struct-in-out,  working-struct. 


           accept variabile-confi from environment "MY_VARIABLE"
      *     if variabile-confi = space
      *        move "I have found no config file"   to variabile-confi
      *     end-if
      *     display message box variabile-confi


           display message box "parameter 1: " working-string
                               x"0D0A"
                               "parameter 2: " working-int
      
           move "I'm back from Acu COBOL" to working-string.  
           move 9999                      to working-int.  
      
           move "new structure"  to ws-string
           move 2                to ws-int.
      *

      * SET VALUES to provide back from COBOL to .Net
           CALL "C$SETVARIANT" USING working-string, string-in-out. 
           CALL "C$SETVARIANT" USING working-int,    int-in-out.   
           CALL "C$SETVARIANT" USING working-struct, struct-in-out. 


***********exit program.  
           stop run.

