      *{Bench}prg-comment
      * Program1.cbl
      * Program1.cbl is generated from C:\Project1\Program1.Psf
      *{Bench}end
       IDENTIFICATION              DIVISION.
      *{Bench}prgid
       PROGRAM-ID. Program1.
       AUTHOR. support.
       DATE-WRITTEN. 11 March 2020 11:29:31.
       REMARKS. 
      *{Bench}end
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       SPECIAL-NAMES.
      *{Bench}activex-def
      *{Bench}end
      *{Bench}decimal-point
           DECIMAL-POINT IS COMMA.
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
       01 Screen1-Gd-1-Record.
           05 Gd-1-Col-1       PIC  X(08).
           05 Gd-1-Col-2       PIC  X(08).
           05 Gd-1-Col-3       PIC  X(08).
           05 Gd-1-Col-4       PIC  X(08).
           05 Gd-1-Col-5       PIC  X(08).
       01 WS-COUNT         PIC  9(3)
                  VALUE IS ZERO.

      *{Bench}end
       LINKAGE                     SECTION.
      *{Bench}linkage
      *{Bench}end
       SCREEN                      SECTION.
      *{Bench}copy-screen
       01 Screen1.
           03 Screen1-Gd-1, Grid, 
              COL 5,00, LINE 5,40, LINES 10,30 CELLS, SIZE 29,90 CELLS, 
              3-D, 
              DATA-COLUMNS (1, 9, 17, 25, 33), 
              DISPLAY-COLUMNS (1, 9, 17, 25, 33), 
              SEPARATION (5, 5, 5, 5, 5), 
              CURSOR-FRAME-WIDTH 3, DIVIDER-COLOR 1, DRAG-COLOR 1, 
              HEADING-COLOR 257, HEADING-DIVIDER-COLOR 1, ID IS 99, 
              RECORD-DATA Screen1-Gd-1-Record, TILED-HEADINGS, 
              VPADDING 50, VSCROLL, 
              EVENT PROCEDURE Screen1-Gd-1-Event-Proc.
           03 Screen1-Pb-1, Push-Button, 
              COL 37,60, LINE 8,00, LINES 5,00 CELLS, SIZE 10,50 CELLS, 
              EXCEPTION-VALUE 555, ID IS 2, 
              TITLE "ADD Row", 
              EVENT PROCEDURE Screen1-Pb-1-Event-Proc.

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
                 LINES 19,10, SIZE 51,10, CELL HEIGHT 10, 
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
           PERFORM Acu-Screen1-Gd-1-Content
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

      * Screen1-Gd-1
       Acu-Screen1-Gd-1-Content.
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
              WHEN Key-Status = 555
                 PERFORM Screen1-Pb-1-Link
           END-EVALUATE
           MOVE 4 TO Accept-Control
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

       Screen1-Gd-1-Event-Proc.
           .

       Screen1-Pb-1-Event-Proc.
           .
      ***   start event editor code   ***
      *
       Screen1-Pb-1-Link.
           ADD 1 TO WS-COUNT

           MODIFY Screen1-Gd-1 INSERTION-INDEX = WS-COUNT
                               INSERT-ROWS 1

           MODIFY Screen1-Gd-1 CURSOR-X = 1
                               CURSOR-Y = WS-COUNT     
           
           MOVE  4 TO ACCEPT-CONTROL 
           MOVE  99 TO CONTROL-ID                                     

           CALL "W$KEYBUF" USING 1 "{^M}"   | sends an ENTER key
           CALL "W$KEYBUF" USING 1 "{ZB}"   | sends a BACKSPACE key
           .

       

      *{Bench}end
       REPORT-COMPOSER SECTION.
