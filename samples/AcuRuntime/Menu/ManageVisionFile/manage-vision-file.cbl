       IDENTIFICATION DIVISION.
       PROGRAM-ID. MANAGE-VISION-FILE.
       AUTHOR. CC.
       REMARKS.  
      * ccbl32 -ga                              manage-vision-file.cbl
      *** INTERVAL-TIMER introduced in 10.2.0 - http://bit.ly/3819Eu6
      * ccbl32 -ga -si TIMER                    manage-vision-file.cbl
      * ccbl32 -ga -si XML -si TIMER            manage-vision-file.cbl
      * ccbl32 -ga -si XML -si TIMER -si THREAD manage-vision-file.cbl
      * ccbl32 -ga -si DISP                     manage-vision-file.cbl
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
            DECIMAL-POINT IS COMMA.    
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT FILE-OUTPUT ASSIGN TO WS-FILE-NAME
           ORGANIZATION IS INDEXED
           ACCESS IS DYNAMIC
           RECORD KEY IS FILMKEY
           ALTERNATE KEY IS FILM-GENRE WITH DUPLICATES
           FILE STATUS IS WS-OUTPUT-STATUS.       
       DATA DIVISION.
       FILE SECTION.   
      $XFD FILE=filmografia           
       FD FILE-OUTPUT.
       01  FILE-OUTPUT-REC.
           05 FILMKEY.
              07 FILM-CODE          PIC  9(9) VALUE ZEROES.
      $xfd  when FILM-CODE = "1" tablename=ship1
      $xfd  when FILM-CODE = "2" tablename=ship2
           05 FILM-TITLE            PIC  X(61).
      $XFD DATE=YYYYMMDD USE GROUP
           05 FILM-DATE.
              07 FILM-YYYY          PIC  X(4).
              07 FILM-MM            PIC  X(2).
              07 FILM-DD            PIC  X(2).
           05 FILM-GENRE            PIC  X(25). 
           05 FILM-DESCRIPTION      PIC  X(100).   
       
       WORKING-STORAGE SECTION.
       77 WS-OUTPUT-STATUS          PIC XX. 
       77 WS-FILE-NAME              PIC X(40) VALUE "filmografia".
       77 WS-FILE-TYPE              PIC X. 
          88 IS-VISION              VALUE 1.
          88 IS-XML                 VALUE 0.       
       77 WS-TITLE                  PIC X(70) VALUE SPACES.
       77 WS-SPACES                 PIC X(70) VALUE SPACES.
       77 WS-COUNTER                PIC 9(9)  VALUE ZEROES.
       77 WS-MAX                    PIC 9(9)  VALUE ZEROES.
       77 WS-PAUSE                  PIC 9(3)V99 VALUE ZEROES.
       01 WS-FILM-DATE-PRINT.
           05 FILM-DD              PIC  X(2).   
           05 FILLER               PIC  X VALUE "/".
           05 FILM-MM              PIC  X(2).
           05 FILLER               PIC  X VALUE "/".
           05 FILM-YYYY            PIC  X(4).
           
       77 DEFAULT-FONT
                  USAGE IS HANDLE OF FONT DEFAULT-FONT.  
       77 FORM1-HANDLE
                  USAGE IS HANDLE OF WINDOW.     
       77 SCREEN1-EF-1-VALUE           PIC  9(9)  VALUE 10.  
       77 SCREEN1-EF-2-VALUE           PIC  9(5)  VALUE 0.
       77 SCREEN1-EF-5-VALUE           PIC  X(25) VALUE "Sci-Fiction".
       77 SCREEN1-EF-EDIT-1-VALUE      PIC  X(40) VALUE 
                                                  "Star Wars ep. IX". 
       77 SCREEN1-EF-EDIT-2-VALUE      PIC  X(8)  VALUE "20191215". 
       77 SCREEN1-EF-EDIT-3-VALUE      PIC  X(25) VALUE "Sci-Fiction". 
       77 SCREEN1-EF-EDIT-4-VALUE      PIC  X(100) 
                                VALUE "Record Description". 
       77 V-VERSION                    PIC 9 VALUE 6.
       01 V-COUNT                      PIC 9 VALUE ZERO. 
       
       01 IO-OP                        PIC X(8) VALUE SPACES.
       77 START-TIME                   PIC 9(4)v9(4).
       77 ELAPSED-TIME                 PIC 9(4)v9(4).
       77 DISPLAY-TIME                 PIC ZZZ9,9(4).
       
       77 KEY-STATUS IS SPECIAL-NAMES CRT STATUS PIC 9(4) VALUE 0.
           88 EXIT-PUSHED VALUE 27.
           88 MESSAGE-RECEIVED VALUE 95.
           88 EVENT-OCCURRED VALUE 96.
           88 SCREEN-NO-INPUT-FIELD VALUE 97.
           88 SCREEN-TIME-OUT VALUE 99.
       
       77 KEY-PRESSED      PIC 9.
           88 KEY-WAS-PRESSED   VALUE 1 WHEN FALSE 0.      
       
       77 A4GL-WHERE-CONSTRAINT  PIC X(32750) EXTERNAL.

       77 H-CANCEL-POPUP               USAGE IS HANDLE OF THREAD. 
       77 WS-MSG                       PIC  X(4) VALUE SPACES.       

       COPY "crtvars.def".
       COPY "acugui.def".

       SCREEN SECTION.
       01 SCREEN-1.
           03 ACUCOBOLGT-LABEL, LABEL, 
              COL 17, LINE 1,90, LINES 1,60 CELLS, SIZE 20,00 CELLS, 
              FONT IS DEFAULT-FONT, ID IS 1, CENTER, 
              LABEL-OFFSET 0, 
              TITLE "ACUCOBOL-GT". 
               
           03 DESC-LABEL-EDIT-0, LABEL, 
              COL 10, LINE 6, LINES 1,60 CELLS, SIZE 9 CELLS, 
              FONT IS DEFAULT-FONT, ID IS 2, 
              LABEL-OFFSET 0, 
              TITLE "File Name:". 
           03 SCREEN1-EF-EDIT-0, ENTRY-FIELD, 
              COL 21, LINE 6, 
              LINES 2 CELLS, SIZE 25 CELLS, 
              3-D, ID IS 3, VALUE WS-FILE-NAME,
              MAX-TEXT 40.    
           03 DESC-LABEL-EDIT-1, LABEL, 
              COL 10, LINE 8, LINES 1,60 CELLS, SIZE 9 CELLS, 
              FONT IS DEFAULT-FONT, ID IS 4, 
              LABEL-OFFSET 0, 
              TITLE "Film Title:".              
           03 SCREEN1-EF-EDIT-1, ENTRY-FIELD, 
              COL 21, LINE 8, 
              LINES 2 CELLS, SIZE 25 CELLS, 
              3-D, ID IS 5, VALUE SCREEN1-EF-EDIT-1-VALUE,
              MAX-TEXT 40.              
           03 DESC-LABEL-EDIT-2, LABEL, 
              COL 10, LINE 10, LINES 1,60 CELLS, SIZE 7 CELLS, 
              FONT IS DEFAULT-FONT, ID IS 6, 
              LABEL-OFFSET 0, 
              TITLE "Film Date:".            
           03 SCREEN1-DE-1, DATE-ENTRY, 
              COL 21,1, LINE 10,  
              LINES 2 CELLS, SIZE 10 CELLS, 
              ID IS 7, VALUE-FORMAT 0, VALUE SCREEN1-EF-EDIT-2-VALUE. 
           03 DESC-LABEL-EDIT-3, LABEL, 
              COL 10, LINE 12, LINES 1,60 CELLS, SIZE 9 CELLS, 
              FONT IS DEFAULT-FONT, ID IS 8, 
              LABEL-OFFSET 0, 
              TITLE "Film Genre:".             
           03 SCREEN1-EF-EDIT-3, ENTRY-FIELD, 
              COL 21, LINE 12, 
              LINES 2 CELLS, SIZE 25 CELLS, 
              3-D, ID IS 9, VALUE SCREEN1-EF-EDIT-3-VALUE,
              MAX-TEXT 25.                           
           03 DESC-LABEL-EDIT-4, LABEL, 
              COL 10, LINE 14, LINES 1,60 CELLS, SIZE 10 CELLS, 
              FONT IS DEFAULT-FONT, ID IS 28, 
              LABEL-OFFSET 0, 
              TITLE "Film Description:".             
           03 SCREEN1-EF-EDIT-4, ENTRY-FIELD, 
              COL 21, LINE 14, 
              LINES 2 CELLS, SIZE 25 CELLS, 
              3-D, ID IS 29, VALUE SCREEN1-EF-EDIT-4-VALUE,
              MAX-TEXT 100. 
               
           03 DESC-LABEL-1, LABEL, 
              COL 10, LINE 18,5, LINES 2 CELLS, SIZE 20 CELLS, 
              FONT IS DEFAULT-FONT, ID IS 10, 
              LABEL-OFFSET 0, 
              TITLE "How many iterations to execute?".                
           03 SCREEN1-EF-1, ENTRY-FIELD, 
              COL 38, LINE 18, 
              LINES 2 CELLS, SIZE 8 CELLS, 
              3-D, ID IS 11, VALUE SCREEN1-EF-1-VALUE,
              MAX-TEXT 9.
              
           03 DESC-LABEL-2, LABEL, 
              COL 10, LINE 20,5, LINES 2 CELLS, SIZE 27 CELLS, 
              FONT IS DEFAULT-FONT, ID IS 12, 
              LABEL-OFFSET 0, 
              TITLE "How many 100th of secs between each iter.?".
           03 SCREEN1-EF-2, ENTRY-FIELD, 
              COL 38, LINE 20, 
              LINES 2 CELLS, SIZE 8 CELLS, 
              3-D, ID IS 13, VALUE SCREEN1-EF-2-VALUE
              MAX-TEXT 5.                
              
           03 SCREEN1-PB-1, PUSH-BUTTON, 
              COL 55, LINE 6, 
              LINES 2 CELLS, SIZE 15 CELLS, 
              ID IS 14, TITLE "WRITE",
              EXCEPTION-VALUE 111.                
           03 SCREEN1-PB-2, PUSH-BUTTON, 
              COL 55, LINE 9, 
              LINES 2 CELLS, SIZE 15 CELLS,
              ID IS 15, TITLE "REWRITE",
              EXCEPTION-VALUE 333. 
           03 SCREEN1-PB-3, PUSH-BUTTON, 
              COL 55, LINE 12, 
              LINES 2 CELLS, SIZE 15 CELLS, 
              ID IS 16, TITLE "READ",
              EXCEPTION-VALUE 222.  
      *     03 SCREEN1-PB-4, PUSH-BUTTON,                                  |XML
      *        COL 55, LINE 15,                                            |XML
      *        LINES 2 CELLS, SIZE 15 CELLS,                               |XML
      *        ID IS 20, TITLE "WRITE TO XML",                             |XML
      *        EXCEPTION-VALUE 444.                                        |XML
           03 VISION-LABEL, LABEL,                                         
              COL 55, LINE 24, LINES 2 CELLS, SIZE 12 CELLS,     
              FONT IS DEFAULT-FONT, ID IS 17,                    
              LABEL-OFFSET 0,                                    
              TITLE "VISION VERSION".                            
           03 SCREEN1-CM-1, COMBO-BOX,                           
              COL 66, LINE 24, LINES 10 CELLS, SIZE 4 CELLS,     
              3-D, ID IS 18, MASS-UPDATE 0, DROP-DOWN, UNSORTED, 
              NOTIFY-SELCHANGE, VALUE V-VERSION                  
              EXCEPTION PROCEDURE SCREEN1-CM-1-EXCEPTION-PROC.   
           03 SCREEN1-PB-5, PUSH-BUTTON,                         
              COL 55, LINE 18,                                   
              LINES 2 CELLS, SIZE 15 CELLS,                      
              ID IS 30, TITLE "READ by Genre",                   
              EXCEPTION-VALUE 555.                               
           03 SCREEN1-EF-5, ENTRY-FIELD,                         
              COL 62, LINE 21,                                   
              LINES 2 CELLS, SIZE 8 CELLS,                       
              3-D, ID IS 31, VALUE SCREEN1-EF-5-VALUE            
              MAX-TEXT 25.                                       
           03 COUNTER-LABEL, LABEL, 
              COL 10, LINE 29, 
              LINES 1,60 CELLS, SIZE 75,00 CELLS, 
              FONT IS DEFAULT-FONT, ID IS 19, 
              LABEL-OFFSET 0, 
              TITLE WS-TITLE.
           03 DETAILS-LABEL, LABEL, 
              COL 18, LINE 31, 
              LINES 1,60 CELLS, SIZE 65,00 CELLS, 
              FONT IS DEFAULT-FONT, ID IS 20, 
              LABEL-OFFSET 0. 
           03 DETAILS-2-LABEL, LABEL, 
              COL 18, LINE 33, 
              LINES 1,60 CELLS, SIZE 65,00 CELLS, 
              FONT IS DEFAULT-FONT, ID IS 21, 
              LABEL-OFFSET 0. 
                            
           03 EXIT-PB, PUSH-BUTTON, 
              COL 55, LINE 35,
              LINES 2 CELLS, SIZE 15 CELLS,
              PERMANENT, FONT IS DEFAULT-FONT, ID IS 100, KEY IS "X", 
              CANCEL-BUTTON, 
              TITLE "E&xit".         
       
       PROCEDURE DIVISION.
       
           DISPLAY STANDARD GRAPHICAL WINDOW
                 LINES 40,  SIZE 75, 
                 MIN-LINES 35, MIN-SIZE 46, 
                 CELL HEIGHT 10, CELL WIDTH 10, 
                 AUTO-MINIMIZE, 
                 MODELESS, WITH SYSTEM MENU,  
                 RESIZABLE,
                 CONTROL FONT DEFAULT-FONT, 
                 USER-COLORS,
                 BACKGROUND-LOW,
                 TITLE "Manage your VISION File", TITLE-BAR, 
                 USER-GRAY, USER-WHITE, 
                 HANDLE IS FORM1-HANDLE,
                 LINK TO THREAD,
                 CONTROLS-UNCROPPED.        
              
           DISPLAY SCREEN-1 UPON FORM1-HANDLE 

           PERFORM VARYING V-COUNT FROM 3 BY 1 UNTIL V-COUNT > 6
               MODIFY SCREEN1-CM-1, ITEM-TO-ADD = V-COUNT       
           END-PERFORM                                          
           
           PERFORM UNTIL EXIT-PUSHED
              ACCEPT SCREEN-1  
                 ON EXCEPTION PERFORM ACU-SCREEN-1-EVALUATE-FUNC
              END-ACCEPT
           END-PERFORM
           
           DESTROY FORM1-HANDLE.  
           
           PERFORM LEAVING-THE-PROG.
           
       ACU-SCREEN-1-EVALUATE-FUNC.
                 INITIALIZE WS-TITLE
                 MODIFY COUNTER-LABEL, TITLE = WS-TITLE
                 MODIFY DETAILS-LABEL, TITLE = WS-TITLE
                 MODIFY DETAILS-2-LABEL, TITLE = WS-TITLE
           EVALUATE TRUE
              WHEN EXIT-PUSHED
                 DESTROY FORM1-HANDLE
                 INITIALIZE KEY-STATUS                
                 PERFORM LEAVING-THE-PROG
             WHEN KEY-STATUS = 111
                 SET IS-VISION TO TRUE
                 PERFORM SETTING-THE-LOOP
                 PERFORM LOADING-THE-DATA
             WHEN KEY-STATUS = 222
                 PERFORM SETTING-THE-LOOP
                 PERFORM READING-THE-DATA     
             WHEN KEY-STATUS = 333
                 PERFORM SETTING-THE-LOOP
                 PERFORM REWRITING-THE-DATA        
             WHEN KEY-STATUS = 444  
                 SET IS-XML TO TRUE 
                 PERFORM SETTING-THE-LOOP
                 PERFORM LOAD-DATA 
             WHEN KEY-STATUS = 555  
                 PERFORM READING-THE-DATA-BY-THE-KEY  
           END-EVALUATE
           .                     

       SETTING-THE-LOOP. 
           INITIALIZE WS-MSG
           MOVE SCREEN1-EF-1-VALUE TO WS-MAX.

       LOADING-THE-DATA.
      *    MOVE "   WRITE" TO IO-OP                                        |TIMER
           OPEN OUTPUT FILE-OUTPUT
      *     PERFORM OPEN-CANCEL-POPUP                                      |THREAD
           PERFORM LOAD-DATA
      *     PERFORM CLOSE-CANCEL-POPUP                                     |THREAD
           CLOSE FILE-OUTPUT.

       READING-THE-DATA.
      *    MOVE "    READ" TO IO-OP                                        |TIMER
           OPEN INPUT FILE-OUTPUT
      *     PERFORM OPEN-CANCEL-POPUP                                      |THREAD
           PERFORM READ-PRIMARY-KEY
      *     PERFORM CLOSE-CANCEL-POPUP                                     |THREAD
           CLOSE FILE-OUTPUT.

       REWRITING-THE-DATA.
      *    MOVE " REWRITE" TO IO-OP                                        |TIMER
           OPEN I-O FILE-OUTPUT
      *     PERFORM OPEN-CANCEL-POPUP                                      |THREAD
           PERFORM RW-PRIMARY-KEY
      *     PERFORM CLOSE-CANCEL-POPUP                                     |THREAD
           CLOSE FILE-OUTPUT.

       LEAVING-THE-PROG.                  	   
       	   GOBACK.

       	   
       LOAD-DATA.            
           INITIALIZE FILE-OUTPUT-REC 
                      WS-TITLE
                      WS-COUNTER
           COMPUTE WS-PAUSE = SCREEN1-EF-2-VALUE / 100
           MODIFY DETAILS-LABEL, TITLE = WS-TITLE

      *    PERFORM START-TIMER                                             |TIMER
           PERFORM UNTIL WS-COUNTER >= WS-MAX
                         OR WS-MSG = "STOP"                                |THREAD
             ADD 1                         TO WS-COUNTER
             MOVE WS-COUNTER               TO FILM-CODE 
                      
             CALL "C$SLEEP" USING WS-PAUSE
      *       ACCEPT KEY-PRESSED FROM INPUT STATUS
      
             MOVE SCREEN1-EF-EDIT-1-VALUE  TO FILM-TITLE           
             MOVE SCREEN1-EF-EDIT-2-VALUE  TO FILM-DATE
             MOVE SCREEN1-EF-EDIT-3-VALUE  TO FILM-GENRE
             MOVE SCREEN1-EF-EDIT-4-VALUE  TO FILM-DESCRIPTION
             
             IF IS-VISION
                WRITE FILE-OUTPUT-REC             
                INITIALIZE WS-TITLE
                STRING "Writing record -> " FILM-CODE INTO WS-TITLE
      *          MODIFY COUNTER-LABEL, TITLE = WS-TITLE                    |DISP
                INITIALIZE WS-TITLE
      *          MODIFY DETAILS-LABEL, TITLE = WS-TITLE                    |DISP
      *          MODIFY DETAILS-2-LABEL, TITLE = WS-TITLE                  |DISP
             ELSE
      *         MOVE "XMLWRITE" TO IO-OP                                   |TIMER
                CALL "manage-vision-file-to-XML"
                     USING WS-FILE-NAME  
                           FILE-OUTPUT-REC           
                INITIALIZE WS-TITLE
                STRING "Writing XML record -> " FILM-CODE INTO WS-TITLE
      *          MODIFY COUNTER-LABEL, TITLE = WS-TITLE                    |DISP
                INITIALIZE WS-TITLE
      *          MODIFY DETAILS-LABEL, TITLE = WS-TITLE                    |DISP
      *          MODIFY DETAILS-2-LABEL, TITLE = WS-TITLE                  |DISP
                EXIT PERFORM
             END-IF   
      *      PERFORM CHECK-CANCEL-POPUP                                    |THREAD
           END-PERFORM
      *     PERFORM STOP-TIMER                                             |TIMER

           INITIALIZE WS-TITLE
           MOVE "Write Complete!" TO WS-TITLE  
           MODIFY DETAILS-LABEL, TITLE = WS-TITLE                  
           .
 
 
       READ-PRIMARY-KEY.
           INITIALIZE FILE-OUTPUT-REC 
                      WS-TITLE 
                      WS-COUNTER
           COMPUTE WS-PAUSE = SCREEN1-EF-2-VALUE / 100
           MODIFY DETAILS-LABEL, TITLE = WS-TITLE
           MOVE LOW-VALUES         TO FILMKEY
            
           START FILE-OUTPUT KEY NOT < FILMKEY

      *    PERFORM START-TIMER                                             |TIMER
           PERFORM UNTIL WS-OUTPUT-STATUS NOT = "00" 
                         OR WS-COUNTER >= WS-MAX
                         OR WS-MSG = "STOP"                                |THREAD
             READ FILE-OUTPUT NEXT WITH LOCK
               AT END 
                 EXIT PERFORM
               NOT AT END
                 CALL "C$SLEEP" USING WS-PAUSE
      *           ACCEPT KEY-PRESSED FROM INPUT STATUS
                 INITIALIZE WS-TITLE
                 STRING FILMKEY " -> " FILM-TITLE INTO WS-TITLE                   
      *           MODIFY COUNTER-LABEL, TITLE = WS-TITLE                   |DISP
                 INITIALIZE WS-TITLE
                 MOVE CORRESPONDING FILM-DATE TO WS-FILM-DATE-PRINT
                 STRING WS-FILM-DATE-PRINT " - " FILM-GENRE 
                                   INTO WS-TITLE  
      *           MODIFY DETAILS-LABEL, TITLE = WS-TITLE                   |DISP
      *           MODIFY DETAILS-2-LABEL, TITLE = FILM-DESCRIPTION         |DISP
                 ADD 1             TO WS-COUNTER
      *          PERFORM CHECK-CANCEL-POPUP                                |THREAD
             END-READ
           END-PERFORM
      *    PERFORM STOP-TIMER                                              |TIMER

           INITIALIZE WS-TITLE
           MOVE "Read Complete!" TO WS-TITLE  
           MODIFY DETAILS-LABEL, TITLE = WS-TITLE
           .
 
 
       RW-PRIMARY-KEY.
           INITIALIZE FILE-OUTPUT-REC 
                      WS-TITLE 
                      WS-COUNTER
           COMPUTE WS-PAUSE = SCREEN1-EF-2-VALUE / 100
           MODIFY DETAILS-LABEL, TITLE = WS-TITLE
           MOVE LOW-VALUES         TO FILMKEY
             
           START FILE-OUTPUT KEY NOT < FILMKEY
           
      *    PERFORM START-TIMER                                             |TIMER
           PERFORM UNTIL WS-OUTPUT-STATUS NOT = "00" 
                         OR WS-COUNTER >= WS-MAX        
                         OR WS-MSG = "STOP"                                |THREAD
             READ FILE-OUTPUT NEXT WITH LOCK
               AT END 
                 EXIT PERFORM
               NOT AT END
                 CALL "C$SLEEP" USING WS-PAUSE
      *           ACCEPT KEY-PRESSED FROM INPUT STATUS                 
      
                 MOVE SCREEN1-EF-EDIT-1-VALUE  TO FILM-TITLE
                 MOVE SCREEN1-EF-EDIT-2-VALUE  TO FILM-DATE
                 MOVE SCREEN1-EF-EDIT-3-VALUE  TO FILM-GENRE  
                 INSPECT SCREEN1-EF-EDIT-4-VALUE 
                         REPLACING TRAILING SPACES BY LOW-VALUES
                 STRING SCREEN1-EF-EDIT-4-VALUE DELIMITED BY LOW-VALUES 
                        " (Rec. n. " FILMKEY ")" 
                        WS-SPACES 
                        INTO FILM-DESCRIPTION
                 
                 ADD 1                         TO WS-COUNTER
                 REWRITE FILE-OUTPUT-REC
                    INVALID KEY 
                       DISPLAY MESSAGE BOX "Error rewriting record"
                                           FILMKEY X"0D0A"
                                           "File status: "   
                                           WS-OUTPUT-STATUS
                    NOT INVALID KEY  
                       INITIALIZE WS-TITLE
                       STRING "ReWriting record -> " FILMKEY 
                                                     INTO WS-TITLE
      *                 MODIFY COUNTER-LABEL, TITLE = WS-TITLE             |DISP
                       INITIALIZE WS-TITLE
      *                 MODIFY DETAILS-LABEL, TITLE = WS-TITLE             |DISP
      *                 MODIFY DETAILS-2-LABEL, TITLE = WS-TITLE           |DISP
                 END-REWRITE
      *          PERFORM CHECK-CANCEL-POPUP                                |THREAD
             END-READ
           END-PERFORM
      *     PERFORM STOP-TIMER                                             |TIMER

           INITIALIZE WS-TITLE
           MOVE "ReWrite Complete!" TO WS-TITLE  
           MODIFY DETAILS-LABEL, TITLE = WS-TITLE         
           .
           
       OPEN-CANCEL-POPUP.
           MODIFY SCREEN1-PB-1 ENABLED = 0
           MODIFY SCREEN1-PB-2 ENABLED = 0
           MODIFY SCREEN1-PB-3 ENABLED = 0
           INITIALIZE WS-MSG
           CALL THREAD "manage-vision-file-cancel.acu" 
                HANDLE IN H-CANCEL-POPUP.   
           
       CHECK-CANCEL-POPUP.    
           RECEIVE WS-MSG FROM THREAD H-CANCEL-POPUP BEFORE TIME 0
           NOT ON EXCEPTION             
              IF WS-MSG = "STOP" 
                 INITIALIZE WS-TITLE
                 MOVE "PROCESSING HAS BEEN STOPPED" TO WS-TITLE
                 MODIFY DETAILS-LABEL, TITLE = WS-TITLE
              END-IF                
           END-RECEIVE.
           
       CLOSE-CANCEL-POPUP.   
           MODIFY SCREEN1-PB-1 ENABLED = 1
           MODIFY SCREEN1-PB-2 ENABLED = 1
           MODIFY SCREEN1-PB-3 ENABLED = 1        
           SEND "close" TO THREAD H-CANCEL-POPUP
           WAIT FOR LAST THREAD. 

       SCREEN1-CM-1-EXCEPTION-PROC.
           IF EVENT-OCCURRED
              EVALUATE EVENT-TYPE
              WHEN NTF-SELCHANGE
                 PERFORM SET-VISION-VERSION
              END-EVALUATE
           END-IF.

       SET-VISION-VERSION.
           IF V-VERSION < 3 OR > 6
               MOVE 6 TO V-VERSION
           END-IF
           SET ENVIRONMENT "V_VERSION" TO V-VERSION.  

       START-TIMER.                                                        |TIMER
      *    INITIALIZE START-TIME ELAPSED-TIME DISPLAY-TIME   
      *    MOVE FUNCTION INTERVAL-TIMER TO START-TIME.                     |TIMER

       STOP-TIMER.                                                         |TIMER
      *    COMPUTE ELAPSED-TIME = FUNCTION INTERVAL-TIMER - START-TIME     |TIMER
      *    MOVE ELAPSED-TIME TO DISPLAY-TIME                               |TIMER
      *    DISPLAY MESSAGE IO-OP " DURATION = " DISPLAY-TIME " SECONDS"    |TIMER
      *                    TITLE "DURATION"                                |TIMER
      *    INITIALIZE IO-OP.                                               |TIMER
      
       Reading-the-Data-by-the-Key.                  
           MOVE "Film_Title like '%Mandalorian%'"    
                            TO A4GL-WHERE-CONSTRAINT 
           SET ENVIRONMENT "4GL_WHERE_CONSTRAINT"    
                            TO A4GL-WHERE-CONSTRAINT 
      *    MOVE "    READ" TO IO-OP                                        |TIMER
           MOVE SCREEN1-EF-5-VALUE TO FILM-GENRE 
           OPEN INPUT FILE-OUTPUT                
      *    PERFORM START-TIMER                                             |TIMER
           READ FILE-OUTPUT KEY IS FILM-GENRE                     
              INVALID KEY                                           
                 INITIALIZE WS-TITLE                                
                 MOVE "Key not found." TO WS-TITLE                  
                 MODIFY COUNTER-LABEL, TITLE = WS-TITLE             
                 INITIALIZE WS-TITLE                                
                 MODIFY DETAILS-LABEL, TITLE = WS-TITLE             
                 MODIFY DETAILS-2-LABEL, TITLE = WS-TITLE           
              NOT INVALID KEY                                       
                 CALL "C$SLEEP" USING WS-PAUSE                      
                 INITIALIZE WS-TITLE                                
                 STRING FILMKEY " -> " FILM-TITLE INTO WS-TITLE     
                 MODIFY COUNTER-LABEL, TITLE = WS-TITLE             
                 INITIALIZE WS-TITLE                                
                 MOVE CORRESPONDING FILM-DATE TO WS-FILM-DATE-PRINT 
                 STRING WS-FILM-DATE-PRINT " - " FILM-GENRE         
                                   INTO WS-TITLE                    
                 MODIFY DETAILS-LABEL, TITLE = WS-TITLE             
                 MODIFY DETAILS-2-LABEL, TITLE = FILM-DESCRIPTION   
           END-READ                                                 
      *    PERFORM STOP-TIMER                                              |TIMER
           CLOSE FILE-OUTPUT                                 
           .
