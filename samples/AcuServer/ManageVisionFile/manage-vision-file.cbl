       identification division.
       program-id. manage-vision-file.
       AUTHOR. CLAUDIO.CONTARDI@MICROFOCUS.COM.
       remarks.  
      * ccbl32 -ga                              manage-vision-file.cbl
      *** INTERVAL-TIMER introduced in 10.2.0 -   http://bit.ly/3819Eu6
      * ccbl32 -ga -si TIMER                    manage-vision-file.cbl
      * ccbl32 -ga -si XML -si TIMER            manage-vision-file.cbl
      * ccbl32 -ga -si XML -si TIMER -si THREAD manage-vision-file.cbl
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
            DECIMAL-POINT IS COMMA.    
       input-output section.
       file-control.
           select file-output assign 
           to ws-file-name
           organization is indexed
           access is dynamic
           record key is FilmKey
           file status is ws-output-status.       
       data division.
       file section.   
      $XFD FILE=filmografia           
       FD file-output.
       01  file-output-rec.
           05 FilmKey.
              07 Film-Code          PIC  9(9) value zeroes.
           05 Film-Title            PIC  X(61).
      $XFD DATE=YYYYMMDD USE GROUP
           05 Film-Date.
              07 Film-YYYY          PIC  X(4).
              07 Film-MM            PIC  X(2).
              07 Film-DD            PIC  X(2).
           05 Film-Genre            PIC  X(25). 
           05 Film-Description      PIC  X(100).   
       
       working-storage section.
       77 ws-output-status          PIC XX. 
       77 ws-file-name              PIC X(40) value "filmografia".
       77 ws-file-type              PIC X. 
          88 is-vision              value 1.
          88 is-xml                 value 0.       
       77 ws-title                  PIC X(70) value spaces.
       77 ws-spaces                 PIC X(70) value spaces.
       77 ws-counter                PIC 9(9)  value zeroes.
       77 ws-max                    PIC 9(9)  value zeroes.
       77 ws-pause                  PIC 9(3)v99 value zeroes.
       01 ws-film-date-print.
           05 Film-DD              PIC  X(2).   
           05 filler               PIC  X VALUE "/".
           05 Film-MM              PIC  X(2).
           05 filler               PIC  X VALUE "/".
           05 Film-YYYY            PIC  X(4).
           
       77 Default-Font
                  USAGE IS HANDLE OF FONT DEFAULT-FONT.  
       77 Form1-Handle
                  USAGE IS HANDLE OF WINDOW.     
       77 Screen1-Ef-1-Value           PIC  9(9)  value ZERO.  
       77 Screen1-Ef-2-Value           PIC  9(5)  value 0.
       77 Screen1-Ef-Edit-1-Value      PIC  X(40) value 
                                                  "Star Wars ep. IX". 
       77 Screen1-Ef-Edit-2-Value      PIC  X(8)  value "20191215". 
       77 Screen1-Ef-Edit-3-Value      PIC  X(25) value "Sci-Fiction". 
       77 Screen1-Ef-Edit-4-Value      PIC  X(100) 
                                value "Record Description". 
       77 V-VERSION                    PIC 9 VALUE 6.
       01 V-COUNT                      PIC 9 VALUE ZERO. 

       01 WS-TASK                      PIC X(10) VALUE SPACES.
       01 WS-COUNT                     PIC X(9) VALUE ZERO.
       
       01 IO-OP                        PIC X(8) VALUE SPACES.
       77 START-TIME                   PIC 9(4)v9(4).
       77 ELAPSED-TIME                 PIC 9(4)v9(4).
       77 DISPLAY-TIME                 PIC ZZZ9,9(4).
       
       77 Key-Status IS SPECIAL-NAMES CRT STATUS PIC 9(4) VALUE 0.
           88 Exit-Pushed VALUE 27.
           88 Message-Received VALUE 95.
           88 Event-Occurred VALUE 96.
           88 Screen-No-Input-Field VALUE 97.
           88 Screen-Time-Out VALUE 99.
       
       77  key-pressed      pic 9.
           88 key-was-pressed   value 1 when false 0.      

      *--------------------------------------------------------------------           
       77 h-cancel-popup               USAGE IS HANDLE OF THREAD. 
       77 ws-msg                       PIC  X(4) value spaces.       
      *--------------------------------------------------------------------       
       COPY "crtvars.def".
       COPY "acugui.def".

       screen section.
       01 Screen-1.
           03 AcucobolGT-Label, Label, 
              COL 17, LINE 1,90, LINES 1,60 CELLS, SIZE 20,00 CELLS, 
              FONT IS Default-Font, ID IS 1, CENTER, 
              LABEL-OFFSET 0, 
              TITLE "ACUCOBOL-GT". 
               
           03 Desc-Label-Edit-0, Label, 
              COL 10, LINE 6, LINES 1,60 CELLS, SIZE 45,00 CELLS, 
              FONT IS Default-Font, ID IS 2, 
              LABEL-OFFSET 0, 
              TITLE "File Name:". 
           03 Screen1-Ef-Edit-0, Entry-Field, 
              COL 21, LINE 6, 
              LINES 2 CELLS, SIZE 25 CELLS, 
              3-D, ID IS 3, VALUE ws-file-name,
              MAX-TEXT 40.    
           03 Desc-Label-Edit-1, Label, 
              COL 10, LINE 8, LINES 1,60 CELLS, SIZE 10 CELLS, 
              FONT IS Default-Font, ID IS 4, 
              LABEL-OFFSET 0, 
              TITLE "Film Title:".              
           03 Screen1-Ef-Edit-1, Entry-Field, 
              COL 21, LINE 8, 
              LINES 2 CELLS, SIZE 25 CELLS, 
              3-D, ID IS 5, VALUE Screen1-Ef-Edit-1-Value,
              MAX-TEXT 40.              
           03 Desc-Label-Edit-2, Label, 
              COL 10, LINE 10, LINES 1,60 CELLS, SIZE 45,00 CELLS, 
              FONT IS Default-Font, ID IS 6, 
              LABEL-OFFSET 0, 
              TITLE "Film Date:".            
           |03 Screen1-Ef-Edit-2, Entry-Field, 
           |   COL 21, LINE 10, 
           |   LINES 2 CELLS, SIZE 10 CELLS, 
           |   3-D, ID IS 7, VALUE Screen1-Ef-Edit-2-Value,
           |   MAX-TEXT 8.  
           03 Screen1-De-1, Date-Entry, 
              COL 21,1, LINE 10,  
              LINES 2 CELLS, SIZE 10 CELLS, 
              ID IS 7, VALUE-FORMAT 0, VALUE Screen1-Ef-Edit-2-Value.                           
           03 Desc-Label-Edit-3, Label, 
              COL 10, LINE 12, LINES 1,60 CELLS, SIZE 45,00 CELLS, 
              FONT IS Default-Font, ID IS 8, 
              LABEL-OFFSET 0, 
              TITLE "Film Genre:".             
           03 Screen1-Ef-Edit-3, Entry-Field, 
              COL 21, LINE 12, 
              LINES 2 CELLS, SIZE 25 CELLS, 
              3-D, ID IS 9, VALUE Screen1-Ef-Edit-3-Value,
              MAX-TEXT 25.                           
           03 Desc-Label-Edit-4, Label, 
              COL 10, LINE 14, LINES 1,60 CELLS, SIZE 45,00 CELLS, 
              FONT IS Default-Font, ID IS 28, 
              LABEL-OFFSET 0, 
              TITLE "Film Description:".             
           03 Screen1-Ef-Edit-4, Entry-Field, 
              COL 21, LINE 14, 
              LINES 2 CELLS, SIZE 25 CELLS, 
              3-D, ID IS 29, VALUE Screen1-Ef-Edit-4-Value,
              MAX-TEXT 100. 
               
           03 Desc-Label-1, Label, 
              COL 10, LINE 18,5, LINES 2 CELLS, SIZE 45,00 CELLS, 
              FONT IS Default-Font, ID IS 10, 
              LABEL-OFFSET 0, 
              TITLE "How many iterations to execute?".                
           03 Screen1-Ef-1, Entry-Field, 
              COL 38, LINE 18, 
              LINES 2 CELLS, SIZE 8 CELLS, 
              3-D, ID IS 11, VALUE Screen1-Ef-1-Value,
              MAX-TEXT 9.
              
           03 Desc-Label-2, Label, 
              COL 10, LINE 20,5, LINES 2 CELLS, SIZE 45,00 CELLS, 
              FONT IS Default-Font, ID IS 12, 
              LABEL-OFFSET 0, 
              TITLE "How many 100th of secs between each iter.?".
           03 Screen1-Ef-2, Entry-Field, 
              COL 38, LINE 20, 
              LINES 2 CELLS, SIZE 8 CELLS, 
              3-D, ID IS 13, VALUE Screen1-Ef-2-Value
              MAX-TEXT 5.                
              
           03 Screen1-Pb-1, Push-Button, 
              COL 55, LINE 6, 
              LINES 2 CELLS, SIZE 15 CELLS, 
              ID IS 14, TITLE "WRITE",
              EXCEPTION-VALUE 111.                
           03 Screen1-Pb-2, Push-Button, 
              COL 55, LINE 9, 
              LINES 2 CELLS, SIZE 15 CELLS,
              ID IS 15, TITLE "REWRITE",
              EXCEPTION-VALUE 333. 
           03 Screen1-Pb-3, Push-Button, 
              COL 55, LINE 12, 
              LINES 2 CELLS, SIZE 15 CELLS, 
              ID IS 16, TITLE "READ",
              EXCEPTION-VALUE 222.  
      *     03 Screen1-Pb-4, Push-Button,                                   | XML
      *        COL 55, LINE 15,                                             | XML
      *        LINES 2 CELLS, SIZE 15 CELLS,                                | XML 
      *        ID IS 20, TITLE "WRITE TO XML",                              | XML
      *        EXCEPTION-VALUE 444.                                         | XML
           03 vision-label, Label, 
              COL 55, LINE 19, LINES 2 CELLS, SIZE 12 CELLS, 
              FONT IS Default-Font, ID IS 17, 
              LABEL-OFFSET 0, 
              TITLE "VISION VERSION".                                      
           03 Screen1-Cm-1, Combo-Box, 
              COL 66, LINE 19, LINES 10 CELLS, SIZE 4 CELLS, 
              3-D, ID IS 18, MASS-UPDATE 0, DROP-DOWN, UNSORTED, 
              NOTIFY-SELCHANGE, VALUE V-VERSION
              EXCEPTION PROCEDURE Screen1-Cm-1-Exception-Proc.          
           03 Counter-Label, Label, 
              COL 10, LINE 29, 
              LINES 1,60 CELLS, SIZE 75,00 CELLS, 
              FONT IS Default-Font, ID IS 19, 
              LABEL-OFFSET 0, 
              TITLE ws-title.
           03 Details-Label, Label, 
              COL 18, LINE 31, 
              LINES 1,60 CELLS, SIZE 65,00 CELLS, 
              FONT IS Default-Font, ID IS 20, 
              LABEL-OFFSET 0. 
           03 Details-2-Label, Label, 
              COL 18, LINE 33, 
              LINES 1,60 CELLS, SIZE 65,00 CELLS, 
              FONT IS Default-Font, ID IS 21, 
              LABEL-OFFSET 0. 
                            
           03 Exit-PB, Push-Button, 
              COL 55, LINE 35,
              LINES 2 CELLS, SIZE 15 CELLS,
              PERMANENT, FONT IS Default-Font, ID IS 100, KEY IS "x", 
              CANCEL-BUTTON, 
              TITLE "E&xit".         
       
       procedure division CHAINING WS-TASK WS-COUNT.
       main-logic.
           
      *     ACCEPT WS-COUNT FROM ENVIRONMENT "RECORD-NUMBER"
           MOVE WS-COUNT TO Screen1-Ef-1-Value CONVERT
      *     ACCEPT WS-TASK FROM ENVIRONMENT "WS-TASK"

           DISPLAY STANDARD GRAPHICAL WINDOW
                 LINES 40,  SIZE 75, 
                 MIN-LINES 35, MIN-SIZE 46, 
                 CELL HEIGHT 10, CELL WIDTH 10, 
                 AUTO-MINIMIZE, 
                 MODELESS, WITH SYSTEM MENU,  
                 RESIZABLE,
                 CONTROL FONT Default-Font, 
                 user-colors,
                 background-low,
                 TITLE "Manage your VISION File", TITLE-BAR, 
                 USER-GRAY, USER-WHITE, 
                 HANDLE IS Form1-Handle,
                 link to thread,
                 controls-uncropped.        
              
           DISPLAY Screen-1 UPON Form1-Handle 

           PERFORM VARYING V-COUNT FROM 3 BY 1 UNTIL V-COUNT > 6
               MODIFY Screen1-Cm-1, ITEM-TO-ADD = V-COUNT
           END-PERFORM 
           
      *     PERFORM UNTIL Exit-Pushed
      *        ACCEPT Screen-1  
      *          ON EXCEPTION PERFORM Acu-Screen-1-Evaluate-Func
      *       END-ACCEPT
      *    END-PERFORM
           
           EVALUATE WS-TASK
               WHEN "WRITE"
                   MODIFY Screen1-Pb-2 ENABLED = FALSE
                   MODIFY Screen1-Pb-3 ENABLED = FALSE
                   set is-vision to true
                   PERFORM setting-the-loop
                   PERFORM loading-the-data
               WHEN "READ"
                   MODIFY Screen1-Pb-1 ENABLED = FALSE
                   MODIFY Screen1-Pb-2 ENABLED = FALSE
                   PERFORM setting-the-loop
                   PERFORM reading-the-data 
               WHEN "REWRITE"
                   MODIFY Screen1-Pb-1 ENABLED = FALSE
                   MODIFY Screen1-Pb-3 ENABLED = FALSE
                   PERFORM setting-the-loop
                   PERFORM rewriting-the-data
               WHEN OTHER
                   DISPLAY MESSAGE "Incorrect value for WS-TASK." H"0A"
                                   "Correct the CBLCONFI and try again."
                   GOBACK
           END-EVALUATE
           
           DESTROY Form1-Handle.  
           
           PERFORM leaving-the-prog.
           
       Acu-Screen-1-Evaluate-Func.
           EVALUATE TRUE
              WHEN Exit-Pushed
                 DESTROY Form1-Handle
                 INITIALIZE Key-Status                
                 PERFORM leaving-the-prog
             WHEN key-status = 111
                 set is-vision to true
                 PERFORM setting-the-loop
                 PERFORM loading-the-data
             WHEN key-status = 222
                 PERFORM setting-the-loop
                 PERFORM reading-the-data     
             WHEN key-status = 333
                 PERFORM setting-the-loop
                 PERFORM rewriting-the-data        
             WHEN key-status = 444  
                 set is-xml to true 
                 PERFORM setting-the-loop
                 PERFORM Load-Data   
           END-EVALUATE
           .                     

       setting-the-loop. 
           initialize ws-msg
           move Screen1-Ef-1-Value to ws-max.

       loading-the-data.
      *    MOVE "   WRITE" TO IO-OP                                         | TIMER
           open output file-output
      *     perform Open-Cancel-Popup                                       | THREAD
           perform Load-Data
      *     perform Close-Cancel-Popup                                      | THREAD
           close file-output.

       reading-the-data.
      *    MOVE "    READ" TO IO-OP                                         | TIMER
           open input file-output
      *     perform Open-Cancel-Popup                                       | THREAD
           perform Read-Primary-Key
      *     perform Close-Cancel-Popup                                      | THREAD
           close file-output.

       rewriting-the-data.
      *    MOVE " REWRITE" TO IO-OP                                         | TIMER
           open I-O file-output
      *     perform Open-Cancel-Popup                                       | THREAD
           perform RW-Primary-Key
      *     perform Close-Cancel-Popup                                      | THREAD
           close file-output.

       leaving-the-prog.                  	   
       	   goback.

       	   
       Load-Data.            
           initialize file-output-rec 
                      ws-title
                      ws-counter
           compute ws-pause = Screen1-Ef-2-Value / 100

      *    PERFORM START-TIMER                                             | TIMER
           perform until ws-counter >= ws-max
                         OR ws-msg = "STOP"                                | THREAD
             add 1                         to ws-counter
             move ws-counter               to Film-Code 
                      
             CALL "C$SLEEP" USING ws-pause
      *       accept key-pressed from input status
      
             move Screen1-Ef-Edit-1-Value  to Film-Title           
             move Screen1-Ef-Edit-2-Value  to Film-Date
             move Screen1-Ef-Edit-3-Value  to Film-Genre
             move Screen1-Ef-Edit-4-Value  to Film-Description
             
             if is-vision
                write file-output-rec             
                initialize ws-title
                string "Writing record -> " Film-Code into ws-title
      *          modify Counter-Label, title = ws-title
                initialize ws-title
      *          modify Details-Label, title = ws-title
      *          modify Details-2-Label, title = ws-title
             else
      *         MOVE "XMLwrite" TO IO-OP                                    | TIMER
                CALL "manage-vision-file-to-XML"
                     USING ws-file-name  
                           file-output-rec           
                initialize ws-title
                string "Writing XML record -> " Film-Code into ws-title
      *          modify Counter-Label, title = ws-title
                initialize ws-title
      *          modify Details-Label, title = ws-title
      *          modify Details-2-Label, title = ws-title
                exit perform
             end-if   
      *      perform Check-Cancel-Popup                                    | THREAD
           end-perform
      *     PERFORM STOP-TIMER                                             | TIMER

           initialize ws-title
           move "Writing complete!" to ws-title  
           modify Details-Label, title = ws-title         
           .
 
 
       Read-Primary-Key.
           initialize file-output-rec 
                      ws-title 
                      ws-counter
           compute ws-pause = Screen1-Ef-2-Value / 100
           move low-values         to FilmKEY
            
           start file-output key not < FilmKEY     

      *    PERFORM START-TIMER                                             | TIMER
           perform until ws-output-status not = "00" 
                         OR ws-counter >= ws-max
                         OR ws-msg = "STOP"                                | THREAD
             read file-output next with lock
               at end 
                 exit perform
               not at end
                 CALL "C$SLEEP" USING ws-pause
      *           accept key-pressed from input status
                 initialize ws-title
                 string FilmKEY " -> " Film-Title into ws-title                   
      *           modify Counter-Label, title = ws-title
                 initialize ws-title
                 move corresponding Film-Date to ws-film-date-print
                 string ws-film-date-print " - " Film-Genre 
                                   into ws-title  
      *           modify Details-Label, title = ws-title
      *           modify Details-2-Label, title = Film-Description
                 add 1             to ws-counter
      *          perform Check-Cancel-Popup                                | THREAD
             end-read
           end-perform
      *    PERFORM STOP-TIMER                                              | TIMER
           .
 
 
       RW-Primary-Key.
           initialize file-output-rec 
                      ws-title 
                      ws-counter
           compute ws-pause = Screen1-Ef-2-Value / 100
           move low-values         to FilmKEY
             
           start file-output key not < FilmKEY     
           
      *    PERFORM START-TIMER                                             | TIMER
           perform until ws-output-status not = "00" 
                         OR ws-counter >= ws-max        
                         OR ws-msg = "STOP"                                | THREAD
             read file-output next with lock
               at end 
                 exit perform
               not at end
                 CALL "C$SLEEP" USING ws-pause
      *           accept key-pressed from input status                 
      
                 move Screen1-Ef-Edit-1-Value  to Film-Title
                 move Screen1-Ef-Edit-2-Value  to Film-Date
                 move Screen1-Ef-Edit-3-Value  to Film-Genre  
                 inspect Screen1-Ef-Edit-4-Value 
                         replacing trailing spaces by low-values
                 string Screen1-Ef-Edit-4-Value delimited by low-values 
                        " (Rec. n. " FilmKEY ")" 
                        ws-spaces 
                        into Film-Description
                 
                 add 1                         to ws-counter
                 REWRITE file-output-rec
                    INVALID KEY 
                       display message box "Error rewriting record"
                                           FilmKEY x"0d0a"
                                           "File status: "   
                                           ws-output-status
                    NOT INVALID KEY  
                       initialize ws-title
                       string "ReWriting record -> " FilmKEY 
                                                     into ws-title
      *                 modify Counter-Label, title = ws-title   
                       initialize ws-title
      *                 modify Details-Label, title = ws-title
      *                 modify Details-2-Label, title = ws-title
                 END-REWRITE
      *          perform Check-Cancel-Popup                                | THREAD
             end-read
           end-perform
      *     PERFORM STOP-TIMER                                             | TIMER

           initialize ws-title
           move "ReWriting complete!" to ws-title  
           modify Details-Label, title = ws-title         
           .
           
       Open-Cancel-Popup.
           modify Screen1-Pb-1 enabled = 0
           modify Screen1-Pb-2 enabled = 0
           modify Screen1-Pb-3 enabled = 0
           initialize ws-msg
           CALL THREAD "manage-vision-file-cancel.acu" 
                HANDLE IN h-cancel-popup.   
           
       Check-Cancel-Popup.    
           RECEIVE ws-msg FROM THREAD h-cancel-popup BEFORE TIME 0
           NOT ON EXCEPTION             
              IF ws-msg = "STOP" 
                 INITIALIZE ws-title
                 MOVE "PROCESSING HAS BEEN STOPPED" TO ws-title
                 MODIFY Details-Label, title = ws-title
              END-IF                
           END-RECEIVE.
           
       Close-Cancel-Popup.   
           modify Screen1-Pb-1 enabled = 1
           modify Screen1-Pb-2 enabled = 1
           modify Screen1-Pb-3 enabled = 1        
           SEND "close" TO THREAD h-cancel-popup
           WAIT FOR LAST THREAD. 

       Screen1-Cm-1-Exception-Proc.
           IF Event-Occurred
              EVALUATE Event-Type
              WHEN Ntf-Selchange
                 PERFORM SET-VISION-VERSION
              END-EVALUATE
           END-IF.

       SET-VISION-VERSION.
           IF V-VERSION < 3 or > 6
               MOVE 6 to V-VERSION
           END-IF
           SET ENVIRONMENT "V_VERSION" TO V-VERSION.  

       START-TIMER.                                                        | TIMER  
      *    INITIALIZE START-TIME ELAPSED-TIME DISPLAY-TIME   
      *    MOVE FUNCTION INTERVAL-TIMER TO START-TIME.                     | TIMER

       STOP-TIMER.                                                         | TIMER
      *    COMPUTE ELAPSED-TIME = FUNCTION INTERVAL-TIMER - START-TIME     | TIMER
      *    MOVE ELAPSED-TIME TO DISPLAY-TIME                               | TIMER
      *    DISPLAY MESSAGE IO-OP " DURATION = " DISPLAY-TIME " SECONDS"    | TIMER
      *                    TITLE "DURATION"                                | TIMER
      *    INITIALIZE IO-OP.                                               | TIMER     