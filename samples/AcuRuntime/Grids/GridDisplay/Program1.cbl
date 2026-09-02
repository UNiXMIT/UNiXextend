      *{Bench}prg-comment
      * Program1.cbl
      * Program1.cbl is generated from C:\Project1\Program1.Psf
      *{Bench}end
       IDENTIFICATION              DIVISION.
      *{Bench}prgid
       PROGRAM-ID. Program1.
       AUTHOR. support.
       DATE-WRITTEN. 15 September 2020 16:02:45.
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
       COPY "lmresize.def".
       COPY "showmsg.def".
      *{Bench}end

      *{Bench}copy-working
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
       77 Screen1-Ef-1-Value           PIC  X(30).
       01 WS-COUNT         PIC  99.
       77 Screen1-LM
                  USAGE IS HANDLE OF LAYOUT-MANAGER, LM-RESIZE
                  VALUE NULL.
       01 PAGE-SIZE        PIC  99
                  VALUE IS 20.
       01 GRID1-HANDLE
                  USAGE IS HANDLE OF GRID VALUE NULL.

      *{Bench}end
       LINKAGE                     SECTION.
      *{Bench}linkage
      *{Bench}end
       SCREEN                      SECTION.
      *{Bench}copy-screen
       01 Screen1.
           03 Screen1-Ef-1, Entry-Field, 
              COL 3.40, LINE 44.90, LINES 2.90 CELLS, SIZE 11.90 CELLS, 
              3-D, ID IS 2, VALUE Screen1-Ef-1-Value.
           03 Screen1-Pb-1, Push-Button, 
              COL 27.80, LINE 44.00, LINES 3.60 CELLS, 
              SIZE 10.20 CELLS, 
              ID IS 3, 
              TITLE "Push Button".

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
              DISPLAY Floating GRAPHICAL WINDOW
                 LINES 48.00, SIZE 64.00, LAYOUT-MANAGER IS Screen1-LM 
                 CELL HEIGHT 10, CELL WIDTH 10, COLOR IS 65793, 
                 CONTROLS-UNCROPPED, LABEL-OFFSET 0, LINK TO THREAD, 
                 MODELESS, RESIZABLE, NO SCROLL, WITH SYSTEM MENU, 
                 TITLE "Screen", TITLE-BAR, NO WRAP, 
                 EVENT PROCEDURE Screen1-Event-Proc, 
                 HANDLE IS Screen1-Handle
      * toolbar
           DISPLAY Screen1 UPON Screen1-Handle
           DISPLAY GRID HANDLE IN GRID1-HANDLE
              COL 1.80, LINE 1.50, LINES PAGE-SIZE, 
              SIZE 61.00 CELLS, 
              ADJUSTABLE-COLUMNS, 3-D, COLUMN-HEADINGS, 
              DATA-COLUMNS (1, 9, 17, 25, 33, 41, 49, 57, 65, 73, 81), 
              DISPLAY-COLUMNS (1, 9, 17, 25, 33, 41, 49, 57, 65, 73,
              81), 
              SEPARATION (5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5), 
              CURSOR-FRAME-WIDTH 3, DIVIDER-COLOR 1, DRAG-COLOR 1, 
              HEADING-COLOR 257, HEADING-DIVIDER-COLOR 1, ID IS 1, 
              NUM-COL-HEADINGS 1, NUM-ROWS 30, TILED-HEADINGS, 
              VPADDING 50, VSCROLL,.
           PERFORM Screen1-Aft-Create
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
           END-EVALUATE
           MOVE 1 TO Accept-Control
           .

       Acu-Screen1-Exit.
           SET Exit-Pushed TO TRUE
           .


       Screen1-Event-Proc.
           .
      ***   start event editor code   ***
      *
       Screen1-Aft-Create.
           MOVE 1 to WS-COUNT
           PERFORM 30 TIMES 
               MODIFY GRID1-handle X = 1 Y = WS-COUNT 
                                   CELL-DATA = WS-COUNT
               ADD 1 TO WS-COUNT
           END-PERFORM
           .

       

      *{Bench}end
       REPORT-COMPOSER SECTION.
