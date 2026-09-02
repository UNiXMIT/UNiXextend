       IDENTIFICATION DIVISION.
       PROGRAM-ID.  PGM-POPUP.
       AUTHOR. CC.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.       
       DATA DIVISION.
       FILE SECTION.

       WORKING-STORAGE SECTION.
       
       77 KEY-STATUS IS SPECIAL-NAMES CRT STATUS PIC 9(4) VALUE 0.
           88 EXIT-PUSHED VALUE 27.
           88 MESSAGE-RECEIVED VALUE 95.
           88 EVENT-OCCURRED VALUE 96.
           88 SCREEN-NO-INPUT-FIELD VALUE 97.
           88 SCREEN-TIME-OUT VALUE 99.
       01  EVENT-STATUS
           IS SPECIAL-NAMES EVENT STATUS.
           03  EVENT-TYPE                      PIC X(4) COMP-X.
           03  EVENT-WINDOW-HANDLE             HANDLE OF WINDOW.
           03  EVENT-CONTROL-HANDLE            HANDLE.
           03  EVENT-CONTROL-ID                PIC XX COMP-X.
           03  EVENT-DATA-1                    SIGNED-SHORT.
           03  EVENT-DATA-2                    SIGNED-LONG.
           03  EVENT-ACTION                    PIC X COMP-X.           
                  
       77 SCREEN1-HANDLE            USAGE IS HANDLE OF WINDOW.
       77 SCREEN2-HANDLE            USAGE IS HANDLE OF WINDOW.
       77 WS-VALORE                 PIC  9(5)  VALUE IS 0.
       77 WS-MSG                    PIC  X(30).
       77 WS-ENTRY                  PIC  X(30).
       77 WS-LABEL                  PIC  X(50) VALUE 
                                            "I'm processing".
       77 WS-LABEL-2                PIC  X(50) VALUE SPACES.
       77 KEY-1                     PIC  9(5).
       77 WS-VISIBLE                PIC  9     VALUE 1.
       77 WS-ENABLE                 PIC  9     VALUE 1.
       


       SCREEN SECTION.
       01 SCREEN2.
           03 SCREEN2-LA-1, LABEL, 
              COL 8, LINE 4, LINES 15 CELLS, SIZE 20 CELLS, 
              ID IS 2, LABEL-OFFSET 0, 
              TITLE WS-LABEL, VISIBLE WS-VISIBLE.
           03 SCREEN2-PB-1, PUSH-BUTTON, 
              COL 8, LINE 7, LINES 4 CELLS, SIZE 16 CELLS, 
              EXCEPTION-VALUE 1111, ID IS 3, 
              TITLE "CANCEL ?",
              VISIBLE WS-VISIBLE.
              
       PROCEDURE DIVISION.
     
       MAIN-LOGIC.

           DISPLAY INDEPENDENT GRAPHICAL WINDOW
                 LINES 15, SIZE 30, 
                 CELL HEIGHT 10, CELL WIDTH 10, 
                 AUTO-MINIMIZE, COLOR IS 65793, 
                 LABEL-OFFSET 0, LINK TO THREAD, MODELESS, NO SCROLL, 
                 WITH SYSTEM MENU, 
                 TITLE-BAR, NO WRAP, 
                 HANDLE IS SCREEN2-HANDLE
                 TITLE "VISION"
                        
           DISPLAY SCREEN2 UPON SCREEN2-HANDLE    
           
           PERFORM UNTIL 1 = 2
           
           ACCEPT SCREEN2
              ALLOWING MESSAGES FROM LAST THREAD   
              ON EXCEPTION CONTINUE
           END-ACCEPT   
           EVALUATE TRUE
                  WHEN KEY-STATUS = 1111
                     SEND "STOP" TO ALL THREADS
                  WHEN MESSAGE-RECEIVED
                     RECEIVE WS-MSG FROM LAST THREAD
                     IF WS-MSG = "close"
                        MOVE SPACE TO WS-MSG
                        DESTROY SCREEN2-HANDLE
                        GOBACK
                     END-IF                                
              END-EVALUATE
           END-PERFORM.           