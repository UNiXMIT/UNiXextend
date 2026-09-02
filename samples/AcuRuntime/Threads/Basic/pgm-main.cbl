       IDENTIFICATION DIVISION.
       PROGRAM-ID.  PGM-MAIN.
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
       77 WS-LABEL-2                PIC  X(50) VALUE spaces.
       77 KEY-1                     PIC  9(5).
       77 WS-VISIBLE                PIC  9     VALUE 1.
       77 WS-ENABLE                 PIC  9     VALUE 1.
       
       77 h-popup                   USAGE IS HANDLE OF THREAD.
       
       77 MAIN-THREAD-HANDLE        HANDLE. 

       SCREEN SECTION.
       01 SCREEN1.
           03 SCREEN1-LA-3, LABEL, 
              COL 7, LINE 4,5, LINES 7 CELLS, SIZE 27 CELLS, 
              ID IS 1, LABEL-OFFSET 0, 
              TITLE "I can count from 1 to 20: ".  
           03 SCREEN1-LA-1, LABEL, 
              COL 25, LINE 4,5, LINES 7 CELLS, SIZE 27 CELLS, 
              ID IS 2, LABEL-OFFSET 0, 
              TITLE WS-VALORE.  
           03 SCREEN1-PB-1, PUSH-BUTTON, 
              COL 10, LINE 15, LINES 4 CELLS, SIZE 16 CELLS, 
              EXCEPTION-VALUE 2222, ID IS 5, 
              TITLE "START PROCESSING".    
           03 SCREEN1-LA-2, LABEL, 
              COL 5, LINE 28, LINES 10 CELLS, SIZE 50 CELLS, 
              ID IS 6, LABEL-OFFSET 0, 
              TITLE WS-LABEL-2.   
              
       PROCEDURE DIVISION.
     
       MAIN-LOGIC.

           DISPLAY STANDARD GRAPHICAL WINDOW
                 LINES 31, SIZE 35, CELL HEIGHT 10, 
                 CELL WIDTH 10, AUTO-MINIMIZE, COLOR IS 65793, 
                 LABEL-OFFSET 0, LINK TO THREAD, MODELESS, NO SCROLL, 
                 WITH SYSTEM MENU, 
                 TITLE "THREADS EXPERIMENT", TITLE-BAR, NO WRAP, 
                 HANDLE IS SCREEN1-HANDLE

           DISPLAY SCREEN1 UPON SCREEN1-HANDLE
           
           PERFORM WITH TEST AFTER UNTIL EXIT-PUSHED
              ACCEPT SCREEN1
              ON EXCEPTION
              EVALUATE KEY-STATUS
                     WHEN 2222
                          PERFORM ELABORAZIONE                   
              END-EVALUATE   
              END-ACCEPT          
           END-PERFORM   
          
           .
       FINE.
           EXIT PROGRAM.
           STOP RUN.
      *
      *
      *     
       ELABORAZIONE.  
         
      * Inquiring the thread of main program.
      * This is useful if you want to send messages to it directly from called threads.
       
           ACCEPT MAIN-THREAD-HANDLE FROM THREAD HANDLE.
       
      * PRIMA DI INIZIARE L'ELABORAZIONE PRINCIPALE, LANCIO IL THREAD                   
      * E DISABILITO LA SCREEN
      *
      * before starting the processing, call the thread and disable the screen
      
           CALL THREAD "pgm-popup" 
                HANDLE IN h-popup
      
           move spaces to WS-LABEL-2
           display SCREEN1-LA-2
           MODIFY SCREEN1-HANDLE, ENABLED = 0     
           
           MOVE 0 TO WS-VALORE         

           PERFORM UNTIL WS-VALORE = 20

              ADD 1 TO WS-VALORE
              DISPLAY SCREEN1-LA-1
              CALL "C$SLEEP" USING 0,5

              RECEIVE WS-MSG FROM THREAD h-popup before time 0
              not on exception             
                 IF WS-MSG = "STOP"
                    move space to ws-msg
                    MOVE "PROCESSING HAS BEEN STOPPED"  TO WS-LABEL-2
                    DISPLAY SCREEN1-LA-2
                    EXIT PERFORM
                 END-IF                
              end-receive
           END-PERFORM     
           
           SEND "close" TO THREAD h-popup
           WAIT FOR LAST THREAD      
           MODIFY SCREEN1-HANDLE, ENABLED = 1           
           .
