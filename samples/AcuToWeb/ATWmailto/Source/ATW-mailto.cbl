      *{Bench}prg-comment
      * ATW-mailto.cbl
      * ATW-mailto.cbl is generated from C:\AcuSamples\AcuToWeb\ATW-mailto\ATW-mailto.Psf
      *{Bench}end
       IDENTIFICATION              DIVISION.
      *{Bench}prgid
       PROGRAM-ID. ATW-mailto.
       AUTHOR. support.
       DATE-WRITTEN. Wednesday, March 25, 2020 11:00:33 AM.
       REMARKS. 
      *{Bench}end
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       SPECIAL-NAMES.
      *{Bench}activex-def
      *{Bench}end
      *{Bench}decimal-point
      *{Bench}end
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *{Bench}file-control
      *{Bench}end
       DATA                        DIVISION.
       FILE                        SECTION.
      *{Bench}file
      *{Bench}end
       WORKING-STORAGE             SECTION.
      *{Bench}acu-def
       COPY "acugui.def".
       COPY "acucobol.def".
       COPY "crtvars.def".
       COPY "showmsg.def".
      *{Bench}end

      *{Bench}copy-working
       77 Quit-Mode-Flag PIC S9(5) COMP-4 VALUE 0.
       77 Key-Status IS SPECIAL-NAMES CRT STATUS PIC 9(4) VALUE 0.
           88 Exit-Pushed VALUE 27.
           88 Message-Received VALUE 95.
           88 Event-Occurred VALUE 96.
           88 Screen-No-Input-Field VALUE 97.
           88 Screen-Time-Out VALUE 99.
      * property-defined variable

      * user-defined variable
       77 Screen1-Handle
                  USAGE IS HANDLE OF WINDOW VALUE NULL.
       77 ws-from          PIC  X(50).
       77 ws-to            PIC  X(50).
       77 ws-subject       PIC  X(50).
       77 ws-message       PIC  X(1000).
       77 ws-mailto        PIC  X(1150).

      *{Bench}end
       LINKAGE                     SECTION.
      *{Bench}linkage
      *{Bench}end
       SCREEN                      SECTION.
      *{Bench}copy-screen
       01 Screen1.
           03 Screen1-La-1, Label, 
              COL 4.30, LINE 2.70, LINES 1.30 CELLS, SIZE 3.40 CELLS, 
              ID IS 1, LABEL-OFFSET 0, 
              TITLE "From:".
           03 Screen1-Ef-1, Entry-Field, 
              COL 9.60, LINE 2.30, LINES 2.20 CELLS, SIZE 26.50 CELLS, 
              3-D, ID IS 2, VALUE ws-from.
           03 Screen1-La-2, Label, 
              COL 4.50, LINE 6.10, LINES 1.30 CELLS, SIZE 2.20 CELLS, 
              ID IS 3, LABEL-OFFSET 0, 
              TITLE "To:".
           03 Screen1-Ef-2, Entry-Field, 
              COL 9.90, LINE 5.90, LINES 2.60 CELLS, SIZE 26.40 CELLS, 
              3-D, ID IS 4, VALUE ws-to.
           03 Screen1-La-3, Label, 
              COL 2.60, LINE 11.00, LINES 1.30 CELLS, SIZE 5.70 CELLS, 
              ID IS 5, LABEL-OFFSET 0, 
              TITLE "Subject:".
           03 Screen1-Ef-3, Entry-Field, 
              COL 9.90, LINE 10.90, LINES 2.40 CELLS, SIZE 26.10 CELLS, 
              3-D, ID IS 6, VALUE ws-subject.
           03 Screen1-La-4, Label, 
              COL 2.10, LINE 16.00, LINES 1.30 CELLS, SIZE 5.70 CELLS, 
              ID IS 8, LABEL-OFFSET 0, 
              TITLE "Message:".
           03 Screen1-Ef-4, Entry-Field, 
              COL 10.00, LINE 15.60, LINES 8.60 CELLS, 
              SIZE 25.90 CELLS, 
              3-D, ID IS 9, MAX-TEXT 1000, MULTILINE, USE-RETURN, 
              USE-TAB, VALUE ws-message.
           03 Screen1-Pb-1, Push-Button, 
              COL 10.20, LINE 26.00, LINES 2.60 CELLS, SIZE 7.80 CELLS, 
              EXCEPTION-VALUE 123, ID IS 7, 
              TITLE "SEND".

      *{Bench}end

      *{Bench}linkpara
       PROCEDURE DIVISION.
      *{Bench}end
      *{Bench}declarative
      *{Bench}end

       Acu-Main-Logic.
      *{Bench}entry-befprg
      *    Before-Program
      *{Bench}end
           PERFORM Acu-Initial-Routine
      * run main screen
      *{Bench}run-mainscr
           PERFORM Acu-Screen1-Routine
      *{Bench}end
           PERFORM Acu-Exit-Rtn
           .

      *{Bench}copy-procedure
       COPY "showmsg.cpy".

       Acu-Initial-Routine.
      *    Before-Init
      * get system information
           ACCEPT System-Information FROM System-Info
      * get terminal information
           ACCEPT Terminal-Abilities FROM Terminal-Info
      *    After-Init
           .

       Acu-Exit-Rtn.
      * destroy font
           PERFORM Acu-Exit-Font
      * destroy bitmap
           PERFORM Acu-Exit-Bmp
      *    After-Program
           EXIT PROGRAM
           STOP RUN
           .
       Acu-Exit-Font.
      * font destroy
           .

       Acu-Exit-Bmp.
      * bitmap destroy
           .

       Acu-Screen1-Routine.
      *    Before-Routine
           PERFORM Acu-Screen1-Scrn
           PERFORM Acu-Screen1-Proc
      *    After-Routine
           .

       Acu-Screen1-Scrn.
           PERFORM Acu-Screen1-Create-Win
           PERFORM Acu-Screen1-Init-Data
           .

       Acu-Screen1-Create-Win.
      *    Before-Create
      * display screen
              DISPLAY Standard GRAPHICAL WINDOW
                 LINES 30.60, SIZE 40.60, CELL HEIGHT 10, 
                 CELL WIDTH 10, AUTO-MINIMIZE, COLOR IS 65793, 
                 LABEL-OFFSET 0, LINK TO THREAD, MODELESS, NO SCROLL, 
                 WITH SYSTEM MENU, 
                 TITLE "Screen", TITLE-BAR, NO WRAP, 
                 EVENT PROCEDURE Screen1-Event-Proc, 
                 HANDLE IS Screen1-Handle
      * toolbar
           DISPLAY Screen1 UPON Screen1-Handle
      *    After-Create
           .

       Acu-Screen1-Init-Data.
      *    Before-Initdata
      *    After-Initdata
           .
      * Screen1
       Acu-Screen1-Proc.
           PERFORM UNTIL Exit-Pushed
              ACCEPT Screen1  
                 ON EXCEPTION PERFORM Acu-Screen1-Evaluate-Func
              END-ACCEPT
           END-PERFORM
           DESTROY Screen1-Handle
           INITIALIZE Key-Status
           .

      * Screen1
       Acu-Screen1-Evaluate-Func.
           EVALUATE TRUE
              WHEN Exit-Pushed
                 PERFORM Acu-Screen1-Exit
              WHEN Event-Occurred
                 IF Event-Type = Cmd-Close
                    PERFORM Acu-Screen1-Exit
                 END-IF
      * Screen1-Pb-1 Link To
              WHEN Key-Status = 123
                 PERFORM Screen1-Pb-1-Link
           END-EVALUATE
           MOVE 1 TO Accept-Control
           .

       Acu-Screen1-Exit.
           SET Exit-Pushed TO TRUE
           .


       Acu-Screen1-Event-Extra.
           EVALUATE Event-Type
           WHEN Msg-Close
              PERFORM Acu-Screen1-Msg-Close
           END-EVALUATE
           .

       Acu-Screen1-Msg-Close.
           ACCEPT Quit-Mode-Flag FROM ENVIRONMENT "QUIT_MODE"
           IF Quit-Mode-Flag = ZERO
              PERFORM Acu-Screen1-Exit
              PERFORM Acu-Exit-Rtn
           END-IF
           .

       Screen1-Event-Proc.
      * 
           PERFORM Acu-Screen1-Event-Extra
           .
      ***   start event editor code   ***
      *
       Screen1-Pb-1-Link.
           inspect ws-subject replacing trailing spaces by low-values
           inspect ws-message replacing trailing spaces by low-values
           string "mailto:"
                  ws-to delimited by spaces
                  "?subject="    
                  ws-subject delimited by low-values
                  "&body="    
                  ws-message delimited by low-values
                  into ws-mailto
           display web-browser, value ws-mailto, visible 0.
           .

       

      *{Bench}end
       REPORT-COMPOSER SECTION.
