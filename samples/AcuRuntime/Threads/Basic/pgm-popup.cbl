       IDENTIFICATION DIVISION.
       PROGRAM-ID.  PGM-POPUP.
       AUTHOR. CLAUDIO.CONTARDI@MICROFOCUS.COM.
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
       77 WS-LABEL-2                PIC  X(50) VALUE spaces.
       77 KEY-1                     PIC  9(5).
       77 WS-VISIBLE                PIC  9     VALUE 1.
       77 WS-ENABLE                 PIC  9     VALUE 1.
       


       SCREEN SECTION.
       01 SCREEN2.
           03 SCREEN2-LA-1, LABEL, 
              COL 3, LINE 2, LINES 15 CELLS, SIZE 20 CELLS, 
              ID IS 2, LABEL-OFFSET 0, 
              TITLE WS-LABEL, VISIBLE WS-VISIBLE.
           03 SCREEN2-PB-1, PUSH-BUTTON, 
              COL 3, LINE 5, LINES 4 CELLS, SIZE 16 CELLS, 
              EXCEPTION-VALUE 1111, ID IS 3, 
              TITLE "STOP PROCESSING",
              VISIBLE WS-VISIBLE.
              
       PROCEDURE DIVISION.
     
       MAIN-LOGIC.

           DISPLAY INDEPENDENT GRAPHICAL WINDOW
                 LINES 15, SIZE 20, CELL HEIGHT 10, 
                 CELL WIDTH 10, AUTO-MINIMIZE, COLOR IS 65793, 
                 LABEL-OFFSET 0, LINK TO THREAD, MODELESS, NO SCROLL, 
                 WITH SYSTEM MENU, 
                 TITLE "SCREEN 2", TITLE-BAR, NO WRAP, 
                 HANDLE IS SCREEN2-HANDLE
                        
           DISPLAY SCREEN2 UPON SCREEN2-HANDLE    
           
           perform until 1 = 2
           
           ACCEPT SCREEN2
              ALLOWING MESSAGES FROM last THREAD   
              ON EXCEPTION continue
           end-accept   
           EVALUATE TRUE
                  WHEN key-status = 1111
                     SEND "STOP" TO ALL threads
                  when message-received
                     receive ws-msg from last thread
                     if ws-msg = "close"
                        move space to ws-msg
                        destroy screen2-handle
                        goback
                     end-if                                
              END-EVALUATE
           end-perform
           .           