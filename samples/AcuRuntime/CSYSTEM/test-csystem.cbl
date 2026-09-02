       identification division.
       program-id. test-csystem.
       author. CCCCCC.
       remarks.

       environment division.
       input-output section.

       data division.
       file section.

       working-storage section.
       77  WS-CMD-LINE         PIC X(200) value spaces.
       77  EXIT-STATUS         pic 9(3). 
       77  WS-FLAG             PIC 9(3) value zeroes.   
       
       77  WS-CSYS-ASYNC       PIC 9    value zeroes.       
       77  WS-CSYS-MINIMIZED   PIC 9    value zeroes.        
       77  WS-CSYS-HIDDEN      PIC 9(2) value zeroes.        
       77  WS-CSYS-SHELL       PIC 9(2) value zeroes. 
       77  WS-CSYS-DESKTOP     PIC 9(3) value zeroes.         
       
       77  CFG-CSYS-ASYNC      PIC X value space.       
       77  CFG-CSYS-MINIMIZED  PIC X value space.       
       77  CFG-CSYS-HIDDEN     PIC X value space.       
       77  CFG-CSYS-SHELL      PIC X value space.
       77  CFG-CSYS-DESKTOP    PIC X value space.       
       
       
       
       COPY "acucobol.def".

       procedure division.
       main-logic.
       
           ACCEPT WS-CMD-LINE FROM ENVIRONMENT "CFG-CMD-LINE"

           ACCEPT CFG-CSYS-ASYNC FROM ENVIRONMENT "CFG-CSYS-ASYNC"
           IF CFG-CSYS-ASYNC = "Y"
              MOVE 1 TO WS-CSYS-ASYNC   
           END-IF  
           
           ACCEPT CFG-CSYS-MINIMIZED FROM ENVIRONMENT 
                                         "CFG-CSYS-MINIMIZED"
           IF CFG-CSYS-MINIMIZED = "Y"
              MOVE 8 TO WS-CSYS-MINIMIZED  
           END-IF   
           
           ACCEPT CFG-CSYS-HIDDEN FROM ENVIRONMENT "CFG-CSYS-HIDDEN"
           IF CFG-CSYS-HIDDEN = "Y"
              MOVE 32 TO WS-CSYS-HIDDEN   
           END-IF   
           
           ACCEPT CFG-CSYS-SHELL FROM ENVIRONMENT "CFG-CSYS-SHELL"                      
           IF CFG-CSYS-SHELL = "Y"
              MOVE 64 TO WS-CSYS-SHELL  
           END-IF           
           
           ACCEPT CFG-CSYS-DESKTOP FROM ENVIRONMENT "CFG-CSYS-DESKTOP"           
           IF CFG-CSYS-DESKTOP = "Y"
              MOVE 128 TO WS-CSYS-DESKTOP
           END-IF   
           
           
           COMPUTE WS-FLAG = WS-FLAG + WS-CSYS-ASYNC
                                     + WS-CSYS-MINIMIZED
                                     + WS-CSYS-HIDDEN
                                     + WS-CSYS-SHELL
                                     + WS-CSYS-DESKTOP
                            
       
           CALL "C$SYSTEM" USING WS-CMD-LINE,
                                 WS-FLAG
                           GIVING EXIT-STATUS

           display message box "EXIT-STATUS: " EXIT-STATUS
                               x"0A"
                               x"0A"
                               "(NOTE: -1 means C$SYSTEM failed.)"
                               TITLE "Testing C$SYSTEM"
                                        
           .
           stop run.
