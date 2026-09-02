      *{Bench}prg-comment
      * css-example.cbl
      * css-example.cbl is generated from C:\Users\shjerpe\trunk\cobolgt\sample\acutoweb\css-example.Psf
      *{Bench}end
       IDENTIFICATION              DIVISION.
      *{Bench}prgid
       PROGRAM-ID. css-example.
       AUTHOR. SHjerpe.
       DATE-WRITTEN. Monday, October 23, 2017 10:43:19 AM.
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
      * property-defined variable
       77 Key-Status IS SPECIAL-NAMES CRT STATUS PIC 9(4) VALUE 0.
           88 Exit-Pushed VALUE 27.
           88 Message-Received VALUE 95.
           88 Event-Occurred VALUE 96.
           88 Screen-No-Input-Field VALUE 97.
           88 Screen-Time-Out VALUE 99.

      * user-defined variable
       77 Screen1-Handle
                  USAGE IS HANDLE OF WINDOW VALUE NULL.
       77 Screen1-Ef-1-Value           PIC  X(550)
                  VALUE IS "When run with a runtime or Thin client this 
      -    "example User Interfaceis  grey. When run with AcuToWeb  
      -    "and using theHarvest CSS theme, the window is yellowish. 
      -    "When run with AcuToWeb and using the 10-2-examle CSS theme,
      -    "the Window and control are a light green-blue and the 
      -    "push buttons are rounded and one is a different color".
       77 Screen1-Ef-1a-Value           PIC  X(300)
                  VALUE IS "Harvest theme has the Window background 
      -    "going from green to  yellow.".
       77 Screen1-Ef-1b-Value PIC  X(500)  VALUE IS 
           ".css-ex-win-class  td{background-color: lightcyan 
      -    " !important;}        .keep-color-same{background-color: 
      -    "lightcyan !important;}                 #css-ex-win-color 
      -    "td{ background-color: lime !important;}
      -    ".css-ex-pb-corners{border-width: 5px; border-radius: 15px;}
      -    "#css-ex-pb-color{ background-color: lime !important;} ".


       77 Screen2-Handle
                  USAGE IS HANDLE OF WINDOW VALUE NULL.
       77 Screen3-Handle
                  USAGE IS HANDLE OF WINDOW VALUE NULL.

      *{Bench}end
       LINKAGE                     SECTION.
      *{Bench}linkage
      *{Bench}end
       SCREEN                      SECTION.
      *{Bench}copy-screen
       01 Screen1.
           03 Screen1-Pb-1, Push-Button, 
              COL 43.60, LINE 9.80, LINES 3.30 CELLS, SIZE 18.90 CELLS, 
              EXCEPTION-VALUE 44, ID IS 1, 
              TITLE "Launch same color window", 
                ATW-CSS-CLASS "css-ex-pb-corners".
           03 Screen1-Ef-1, Entry-Field, 
              COL 4.30, LINE 6.10, LINES 9.10 CELLS, SIZE 35.70 CELLS, 
              3-D, ID IS 3, READ-ONLY, MULTILINE, 
              ATW-CSS-CLASS "keep-color-same"
              VALUE Screen1-Ef-1-Value.
           03 Screen1-La-1, Label, 
              COL 3.80, LINE 3.00, LINES 1.90 CELLS, SIZE 24.80 CELLS, 
              ID IS 2, LABEL-OFFSET 0, 
               ATW-CSS-CLASS "keep-color-same"
              TITLE "About this example".
           03 Screen1-Ef-1a, Entry-Field, 
              COL 4.20, LINE 18.80, LINES 3.50 CELLS, SIZE 35.70 CELLS, 
              3-D, ID IS 7, READ-ONLY, MULTILINE, 
                ATW-CSS-CLASS "keep-color-same"
              VALUE Screen1-Ef-1a-Value.
           03 Screen1-Ef-1aa, Entry-Field, 
              COL 3.80, LINE 30.80, LINES 12.90 CELLS, 
              SIZE 42 CELLS, 
              3-D, ID IS 4, READ-ONLY, MULTILINE, 
                  ATW-CSS-CLASS "keep-color-same"
              VALUE Screen1-Ef-1b-Value.
           03 Screen1-La-2, Label, 
              COL 3.40, LINE 15.90, LINES 2.10 CELLS, SIZE 26.00 CELLS, 
              ID IS 5, LABEL-OFFSET 0, 
               ATW-CSS-CLASS "keep-color-same"
              TITLE "Using the Harvest CSS theme".
           03 Screen1-La-3, Label, 
              COL 3.30, LINE 26.00, LINES 2.00 CELLS, SIZE 31.80 CELLS, 
              ID IS 6, LABEL-OFFSET 0, 
              ATW-CSS-CLASS "keep-color-same"
              TITLE "Using the 10-2-example CSS Theme".  
           03 Screen1-Pb-2, Push-Button, 
              COL 43.70, LINE 16.80, LINES 3.30 CELLS, 
              SIZE 18.90 CELLS, 
              EXCEPTION-VALUE 55, ID IS 8, 
              TITLE "Launch different color window", 
              ATW-CSS-CLASS "css-ex-pb-corners", 
              ATW-CSS-ID "css-ex-pb-color".
           03 Screen1-Pb-3, Push-Button, 
              COL 43.60, LINE 24.00, LINES 3.30 CELLS, 
              SIZE 18.90 CELLS, 
              ID IS 9, CANCEL-BUTTON, 
              TITLE "Exit", ATW-CSS-CLASS "css-ex-pb-corners".
       01 Screen2.
           03 Screen2-Pb-1, Push-Button, 
              COL 11.30, LINE 6.30, LINES 2.90 CELLS, SIZE 15.60 CELLS, 
              ID IS 1, CANCEL-BUTTON, 
              TITLE "Exit", ATW-CSS-CLASS "css-ex-pb-corners".
       01 Screen3.
           03 Screen3-Pb-1, Push-Button, 
              COL 10.40, LINE 4.50, LINES 3.20 CELLS, SIZE 16.70 CELLS, 
              ID IS 1,  CANCEL-BUTTON, 
              TITLE "Exit", ATW-CSS-CLASS "css-ex-pb-corners", 
              ATW-CSS-ID "css-ex-win-color".

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
      *    After-Program
           EXIT PROGRAM
           STOP RUN
           .

       Acu-Screen1-Routine.
      *    Before-Routine
           PERFORM Acu-Screen1-Scrn
           PERFORM Acu-Screen1-Proc
      *    After-Routine
           .

       Acu-Screen2-Routine.
      *    Before-Routine
           PERFORM Acu-Screen2-Scrn
           PERFORM Acu-Screen2-Proc
      *    After-Routine
           .

       Acu-Screen3-Routine.
      *    Before-Routine
           PERFORM Acu-Screen3-Scrn
           PERFORM Acu-Screen3-Proc
      *    After-Routine
           .

       Acu-Screen1-Scrn.
           PERFORM Acu-Screen1-Create-Win
           PERFORM Acu-Screen1-Init-Data
           .

       Acu-Screen2-Scrn.
           PERFORM Acu-Screen2-Create-Win
           PERFORM Acu-Screen2-Init-Data
           .

       Acu-Screen3-Scrn.
           PERFORM Acu-Screen3-Create-Win
           PERFORM Acu-Screen3-Init-Data
           .

       Acu-Screen1-Create-Win.
      *    Before-Create
      * display screen
              DISPLAY Standard GRAPHICAL WINDOW
                 LINES 46.70, SIZE 64.00, CELL HEIGHT 10, 
                 CELL WIDTH 10, AUTO-MINIMIZE, COLOR IS 65793, 
                 LABEL-OFFSET 0, LINK TO THREAD, MODELESS, NO SCROLL, 
                 WITH SYSTEM MENU, 
                 TITLE "Screen", TITLE-BAR, NO WRAP, 
                 ATW-CSS-CLASS "css-ex-win-class", 
                 EVENT PROCEDURE Screen1-Event-Proc, 
                 HANDLE IS Screen1-Handle
      * toolbar
           DISPLAY Screen1 UPON Screen1-Handle
      *    After-Create
           .

       Acu-Screen2-Create-Win.
      *    Before-Create
      * display screen
              DISPLAY Floating GRAPHICAL WINDOW
                 LINES 17.20, SIZE 45.30, CELL HEIGHT 10, 
                 CELL WIDTH 10, COLOR IS 65793, LABEL-OFFSET 0, 
                 LINK TO THREAD, MODELESS, NO SCROLL, WITH SYSTEM MENU, 
                 TITLE "Same color as Window 1", TITLE-BAR, NO WRAP, 
                 ATW-CSS-CLASS "css-ex-win-class",
                 EVENT PROCEDURE Screen2-Event-Proc, 
                 HANDLE IS Screen2-Handle
      * toolbar
           DISPLAY Screen2 UPON Screen2-Handle
      *    After-Create
           .

       Acu-Screen3-Create-Win.
      *    Before-Create
      * display screen
              DISPLAY Floating GRAPHICAL WINDOW
                 LINES 12.40, SIZE 39.30, CELL HEIGHT 10, 
                 CELL WIDTH 10, COLOR IS 65793, LABEL-OFFSET 0, 
                 LINK TO THREAD, MODELESS, NO SCROLL, WITH SYSTEM MENU, 
                 TITLE "Same color as different color push button", 
                 TITLE-BAR, NO WRAP, ATW-CSS-ID "css-ex-win-color", 
                 EVENT PROCEDURE Screen3-Event-Proc, 
                 HANDLE IS Screen3-Handle
      * toolbar
           DISPLAY Screen3 UPON Screen3-Handle
      *    After-Create
           .

       Acu-Screen1-Init-Data.
      *    Before-Initdata
      *    After-Initdata
           .

       Acu-Screen2-Init-Data.
      *    Before-Initdata
      *    After-Initdata
           .

       Acu-Screen3-Init-Data.
      *    Before-Initdata
      *    After-Initdata
           .
      * Screen1
       Acu-Screen1-Proc.
           PERFORM UNTIL  Exit-Pushed

              ACCEPT Screen1  
                 ON EXCEPTION PERFORM Acu-Screen1-Evaluate-Func
              END-ACCEPT
           END-PERFORM
           DESTROY Screen1-Handle
           INITIALIZE Key-Status

           .
      * Screen2
       Acu-Screen2-Proc.
           PERFORM UNTIL  Exit-Pushed

              ACCEPT Screen2  
                 ON EXCEPTION PERFORM Acu-Screen2-Evaluate-Func
              END-ACCEPT
           END-PERFORM
           DESTROY Screen2-Handle
           INITIALIZE Key-Status

           .
      * Screen3
       Acu-Screen3-Proc.
           PERFORM UNTIL  Exit-Pushed

              ACCEPT Screen3  
                 ON EXCEPTION PERFORM Acu-Screen3-Evaluate-Func
              END-ACCEPT
           END-PERFORM
           DESTROY Screen3-Handle
           INITIALIZE Key-Status

           .

      * Screen1
       Acu-Screen1-Evaluate-Func.
           EVALUATE TRUE
              WHEN  Exit-Pushed
                 PERFORM Acu-Screen1-Exit
              WHEN  Event-Occurred
                 IF Event-Type = Cmd-Close
                    PERFORM Acu-Screen1-Exit
                 END-IF
      * Screen1-Pb-1 Link To
              WHEN  Key-Status = 44
                 PERFORM Screen1-Pb-1-Link
      * Screen1-Pb-2 Link To
              WHEN  Key-Status = 55
                 PERFORM Screen1-Pb-2-Link
           END-EVALUATE
           MOVE 1 TO Accept-Control
           .

      * Screen2
       Acu-Screen2-Evaluate-Func.
           EVALUATE TRUE
              WHEN  Exit-Pushed
                 PERFORM Acu-Screen2-Exit
              WHEN  Event-Occurred
                 IF Event-Type = Cmd-Close
                    PERFORM Acu-Screen2-Exit
                 END-IF
           END-EVALUATE
           MOVE 1 TO Accept-Control
           .

      * Screen3
       Acu-Screen3-Evaluate-Func.
           EVALUATE TRUE
              WHEN  Exit-Pushed
                 PERFORM Acu-Screen3-Exit
              WHEN  Event-Occurred
                 IF Event-Type = Cmd-Close
                    PERFORM Acu-Screen3-Exit
                 END-IF
           END-EVALUATE
           MOVE 1 TO Accept-Control
           .

       Acu-Screen1-Exit.
           SET Exit-Pushed TO TRUE
           .

       Acu-Screen2-Exit.
           SET Exit-Pushed TO TRUE
           .

       Acu-Screen3-Exit.
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

       Screen2-Event-Proc.
           .

       Screen3-Event-Proc.
           .
      ***   start event editor code   ***
      *
       Screen1-Pb-1-Link.
           perform Acu-Screen2-Routine
           .
      *
       Screen1-Pb-2-Link.
           perform Acu-Screen3-Routine
           .

       

      *{Bench}end
       REPORT-COMPOSER SECTION.
