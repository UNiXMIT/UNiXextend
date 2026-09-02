      *{Bench}prg-comment
      * GRID-MODIFY.cbl
      * GRID-MODIFY.cbl is generated from C:\AcuSamples\GRID\GRID-MODIFY\GRID-MODIFY.Psf
      *{Bench}end
       IDENTIFICATION              DIVISION.
      *{Bench}prgid
       PROGRAM-ID. GRID-MODIFY.
       AUTHOR. support.
       DATE-WRITTEN. Wednesday, February 5, 2020 5:18:54 PM.
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
       77 ws-temp          PIC  9(4)v99
                  VALUE IS 0.
       77 ws-max           PIC  9(4)v99
                  VALUE IS 0.
       77 ws-string        PIC  x(82).
       01 Screen1-Gd-1-Record.
           05 Gd-1-Col-1       PIC  X(10).
           05 Gd-1-Col-2       PIC  X(08).
           05 Gd-1-Col-3       PIC  X(08).
           05 Gd-1-Col-4       PIC  X(08).
           05 Gd-1-Col-5       PIC  X(08).
           05 Gd-1-Col-6       PIC  X(08).
           05 Gd-1-Col-7       PIC  X(08).
           05 Gd-1-Col-8       PIC  X(08).
           05 Gd-1-Col-9       PIC  X(08).
           05 Gd-1-Col-10      PIC  X(08).

      *{Bench}end
       LINKAGE                     SECTION.
      *{Bench}linkage
      *{Bench}end
       SCREEN                      SECTION.
      *{Bench}copy-screen
       01 Screen1.
           03 Screen1-Gd-1, Grid, 
              COL 16.70, LINE 14.00, LINES 22.60 CELLS, 
              SIZE 32.60 CELLS, 
              3-D, COLUMN-HEADINGS, 
              DATA-COLUMNS (1, 11, 19, 27, 35, 43, 51, 59, 67, 75), 
              DISPLAY-COLUMNS (1, 11, 19, 27, 35, 43, 51, 59, 67, 75), 
              SEPARATION (5, 5, 5, 5, 5, 5, 5, 5, 5, 5), 
              CURSOR-FRAME-WIDTH 3, DIVIDER-COLOR 1, DRAG-COLOR 1, 
              HEADING-COLOR 257, HEADING-DIVIDER-COLOR 1, ID IS 1, 
              NUM-COL-HEADINGS 1, NUM-ROWS 5, 
              RECORD-DATA Screen1-Gd-1-Record, TILED-HEADINGS, 
              VPADDING 50, 
              EVENT PROCEDURE Screen1-Gd-1-Event-Proc.
           03 Screen1-Pb-1, Push-Button, 
              COL 32.50, LINE 4.80, LINES 4.30 CELLS, SIZE 5.90 CELLS, 
              EXCEPTION-VALUE 123, ID IS 2, 
              TITLE "UP".
           03 Screen1-Pb-3, Push-Button, 
              COL 5.60, LINE 22.60, LINES 5.00 CELLS, SIZE 5.90 CELLS, 
              EXCEPTION-VALUE 321, ID IS 4, 
              TITLE "LEFT".
           03 Screen1-Pb-4, Push-Button, 
              COL 63.20, LINE 24.60, LINES 5.10 CELLS, SIZE 8.80 CELLS, 
              EXCEPTION-VALUE 654, ID IS 5, 
              TITLE "RIGHT".
           03 Screen1-Pb-2, Push-Button, 
              COL 32.00, LINE 47.00, LINES 4.40 CELLS, SIZE 7.10 CELLS, 
              EXCEPTION-VALUE 456, ID IS 3, 
              TITLE "Down".
           03 Screen1-Pb-10, Push-Button, 
              COL 71.00, LINE 32.80, LINES 3.80 CELLS, SIZE 9.90 CELLS, 
              EXCEPTION-VALUE 259, ID IS 12, 
              TITLE "ADD RECORDS".
           03 Screen1-Pb-9, Push-Button, 
              COL 71.00, LINE 37.90, LINES 3.80 CELLS, SIZE 9.90 CELLS, 
              EXCEPTION-VALUE 852, ID IS 11, 
              TITLE "VSCROLL".
           03 Screen1-Pb-5, Push-Button, 
              COL 71.00, LINE 44.40, LINES 3.40 CELLS, SIZE 9.90 CELLS, 
              EXCEPTION-VALUE 789, ID IS 6, 
              TITLE "TALLER".
           03 Screen1-Pb-6, Push-Button, 
              COL 71.00, LINE 49.40, LINES 3.10 CELLS, SIZE 9.90 CELLS, 
              EXCEPTION-VALUE 987, ID IS 7, 
              TITLE "SHORTER".
           03 Screen1-Pb-9a, Push-Button, 
              COL 84.60, LINE 38.50, LINES 3.80 CELLS, SIZE 9.90 CELLS, 
              EXCEPTION-VALUE 654, ID IS 13, 
              TITLE "HSCROLL", VISIBLE 0.
           03 Screen1-Pb-7, Push-Button, 
              COL 84.00, LINE 44.70, LINES 3.20 CELLS, SIZE 9.90 CELLS, 
              EXCEPTION-VALUE 741, ID IS 9, 
              TITLE "LARGER".
           03 Screen1-Pb-8, Push-Button, 
              COL 84.40, LINE 49.60, LINES 2.80 CELLS, SIZE 9.90 CELLS, 
              EXCEPTION-VALUE 147, ID IS 10, 
              TITLE "NARROWER".
           03 Screen1-Br-1a, Bar, 
              COL 69.30, LINE 31.90, LINES 22.00 CELLS, 
              ID IS 14, WIDTH 1.
           03 Screen1-Br-1, Bar, 
              COL 82.90, LINE 31.90, LINES 22.00 CELLS, 
              ID IS 8, WIDTH 1.
           03 Screen1-Pb-10a, Push-Button, 
              COL 84.50, LINE 33.10, LINES 3.80 CELLS, SIZE 9.90 CELLS, 
              EXCEPTION-VALUE 9999, ID IS 15, 
              TITLE "RESET".

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
                 LINES 54.00, SIZE 94.10, CELL HEIGHT 10, 
                 CELL WIDTH 10, AUTO-MINIMIZE, COLOR IS 65793, 
                 LABEL-OFFSET 0, LINK TO THREAD, MODELESS, NO SCROLL, 
                 WITH SYSTEM MENU, 
                 TITLE "Screen", TITLE-BAR, NO WRAP, 
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
              WHEN Key-Status = 123
                 PERFORM Screen1-Pb-1-Link
      * Screen1-Pb-3 Link To
              WHEN Key-Status = 321
                 PERFORM Screen1-Pb-3-Link
      * Screen1-Pb-4 Link To
              WHEN Key-Status = 654
                 PERFORM Screen1-Pb-4-Link
      * Screen1-Pb-2 Link To
              WHEN Key-Status = 456
                 PERFORM Screen1-Pb-2-Link
      * Screen1-Pb-10 Link To
              WHEN Key-Status = 259
                 PERFORM Screen1-Pb-10-Link
      * Screen1-Pb-9 Link To
              WHEN Key-Status = 852
                 PERFORM Screen1-Pb-9-Link
      * Screen1-Pb-5 Link To
              WHEN Key-Status = 789
                 PERFORM Screen1-Pb-5-Link
      * Screen1-Pb-6 Link To
              WHEN Key-Status = 987
                 PERFORM Screen1-Pb-6-Link
      * Screen1-Pb-7 Link To
              WHEN Key-Status = 741
                 PERFORM Screen1-Pb-7-Link
      * Screen1-Pb-8 Link To
              WHEN Key-Status = 147
                 PERFORM Screen1-Pb-8-Link
      * Screen1-Pb-10a Link To
              WHEN Key-Status = 9999
                 PERFORM Screen1-Pb-10a-Link
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

       Screen1-Gd-1-Event-Proc.
           .
      ***   start event editor code   ***
      *
       Screen1-Pb-1-Link.
           INQUIRE Screen1-Gd-1, LINE in ws-temp
           SUBTRACT 2,5 from ws-temp
           MODIFY Screen1-Gd-1, LINE ws-temp
           .
      *
       Screen1-Pb-2-Link.
           INQUIRE Screen1-Gd-1, LINE in ws-temp
           ADD 2,5 TO ws-temp
           MODIFY Screen1-Gd-1, LINE ws-temp
           .
      *
       Screen1-Pb-3-Link.
           INQUIRE Screen1-Gd-1, COL in ws-temp
           SUBTRACT 2,5 FROM ws-temp
           MODIFY Screen1-Gd-1, COL ws-temp
           .
      *
       Screen1-Pb-4-Link.
           INQUIRE Screen1-Gd-1, COL in ws-temp
           ADD 2,5 TO ws-temp
           MODIFY Screen1-Gd-1, COL ws-temp
           .
      *
       Screen1-Pb-5-Link.
           INQUIRE Screen1-Gd-1, LINES in ws-temp
           ADD 2,5 TO ws-temp
           MODIFY Screen1-Gd-1, LINES ws-temp
           .
      *
       Screen1-Pb-6-Link.
           INQUIRE Screen1-Gd-1, LINES in ws-temp
           SUBTRACT 2,5 FROM ws-temp
           MODIFY Screen1-Gd-1, LINES ws-temp
           .
      *
       Screen1-Pb-7-Link.
           INQUIRE Screen1-Gd-1, SIZE in ws-temp
           ADD 2,5 TO ws-temp
           MODIFY Screen1-Gd-1, SIZE ws-temp
           .
      *
       Screen1-Pb-8-Link.
           INQUIRE Screen1-Gd-1, SIZE in ws-temp
           SUBTRACT 2,5 FROM ws-temp
           MODIFY Screen1-Gd-1, SIZE ws-temp
           .
      *
       Screen1-Pb-9-Link.
      *     INQUIRE Screen1-Pb-9, TITLE IN ws-string 
      *     IF ws-string = "VSCROLL"
              MODIFY Screen1-Gd-1, VSCROLL
      *        MODIFY Screen1-Pb-9, TITLE = "No SCROLL"
      *     ELSE     
      *        MODIFY Screen1-Gd-1, VSCROLL FALSE
      *        MODIFY Screen1-Pb-9, TITLE = "VSCROLL"
      *     END-IF
           . 
      *
      *Screen1-Pb-9a-Link.
      *    MODIFY Screen1-Gd-1, HSCROLL
           .
      *
       Load-Data.
           add 1 to ws-temp
           STRING "Test" ws-temp "A       "
                  "B       " "C       " "D       "
                  "E       " "F       " "G       "
                  "H       " INTO ws-string
           MODIFY Screen1-Gd-1, RECORD-TO-ADD ws-string
           .
      *
       Screen1-Pb-10-Link.
           add 50 to ws-max
           MODIFY Screen1-Gd-1, NUM-ROWS ws-max
      *    initialize ws-temp
           PERFORM Load-Data 50 times
           .
      *
       Screen1-Pb-10a-Link.
           MODIFY Screen1-Gd-1, RESET-GRID = 1
           initialize ws-temp ws-max
           .

       

      *{Bench}end
       REPORT-COMPOSER SECTION.
