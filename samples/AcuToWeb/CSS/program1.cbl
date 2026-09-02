      *{Bench}prg-comment
      * Program1.cbl
      * Program1.cbl is generated from C:\etc\1011\Date\css\Program1.Psf
      *{Bench}end
       IDENTIFICATION              DIVISION.
      *{Bench}prgid
       PROGRAM-ID. Program1.
       AUTHOR. SHjerpe.
       DATE-WRITTEN. Thursday, August 31, 2017 11:44:27 AM.
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
       77 Screen2-SF-HANDLE
                  USAGE IS HANDLE OF WINDOW VALUE NULL.
       77 Screen2-MN-1-HANDLE
                  USAGE IS HANDLE OF MENU VALUE NULL.
       77 Screen3-SF-HANDLE
                  USAGE IS HANDLE OF WINDOW VALUE NULL.
       77 Screen3-MN-1-HANDLE
                  USAGE IS HANDLE OF MENU VALUE NULL.
       01 .
           03 Screen1-Ef-1-Value-Item      PIC  X(30).
           03 Screen1-Ef-1-Value REDEFINES Screen1-Ef-1-Value-Item  PIC 
            X(30)
                      OCCURS 1 TIMES.

      *{Bench}end
       LINKAGE                     SECTION.
      *{Bench}linkage
      *{Bench}end
       SCREEN                      SECTION.
      *{Bench}copy-screen
       01 Screen1.
           03 Screen1-Pb-1, Push-Button, 
              COL 38.30, LINE 15.00, LINES 3.50 CELLS, 
              SIZE 14.00 CELLS,  ATW-CSS-CLASS "basicpbclass"
              ID IS 1, CANCEL-BUTTON, 
              TITLE "Exit".
           03 Screen1-Pb-2, Push-Button, 
              COL 1.80, LINE 10.10, LINES 3.50 CELLS, SIZE 28.40 CELLS, 
              EXCEPTION-VALUE 81, ID IS 2, ATW-CSS-CLASS "basicpbclass"
              TITLE "Launch new window same color as this one".
           03 Screen1-Pb-2a, Push-Button, 
              COL 2.10, LINE 14.80, LINES 3.50 CELLS, SIZE 28.40 CELLS, 
              EXCEPTION-VALUE 91, ID IS 3,  ATW-CSS-ID "specpbid"
              TITLE "Launch new window different color ".
           03 Screen1-Ef-1, Entry-Field, 
              COL 9.50, LINE 2.80, LINES 6.30 CELLS, SIZE 43.50 CELLS, 
              3-D, ID IS 4, READ-ONLY, 
              VALUE MULTIPLE Screen1-Ef-1-Value.
           03 Screen1-La-1, Label, 
              COL 1.90, LINE 3.50, LINES 1.70 CELLS, SIZE 5.70 CELLS, 
              ID IS 5, LABEL-OFFSET 0, 
              TITLE "CSS".
       01 Screen2, HELP-ID 1.
           03 Screen2-PB-CANCEL, Push-Button, 
              COL 9.40, LINE 5.90, LINES 2.00 CELLS, SIZE 8.00 CELLS, 
              HELP-ID 3, ID IS 2, SELF-ACT, CANCEL-BUTTON, 
              TITLE "Cancel".
       01 Screen3, HELP-ID 1.
           03 Screen3-PB-CANCEL, Push-Button, 
              COL 11.00, LINE 12.00, LINES 2.00 CELLS, SIZE 8.00 CELLS, 
              HELP-ID 3, ID IS 2, SELF-ACT, CANCEL-BUTTON, 
              TITLE "Cancel".
           03 Screen1-Ef-1a, Entry-Field, 
              COL 11.10, LINE 3.10, LINES 6.30 CELLS, SIZE 18.90 CELLS, 
              3-D, ID IS 4, READ-ONLY, 
              VALUE MULTIPLE Screen1-Ef-1-Value.
           03 Screen3-La-1, Label, 
              COL 1.60, LINE 4.80, LINES 2.80 CELLS, SIZE 6.10 CELLS, 
              ID IS 5, LABEL-OFFSET 0, 
              TITLE "CSS".

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
                 LINES 19.30, SIZE 54.70, CELL HEIGHT 10, 
                 CELL WIDTH 10, AUTO-MINIMIZE, COLOR IS 65793, 
                 LABEL-OFFSET 0, LINK TO THREAD, MODELESS, NO SCROLL, 
                 WITH SYSTEM MENU, ATW-CSS-CLASS "basicwinclass"
                 TITLE "Screen", TITLE-BAR, NO WRAP, 
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
                 LINES 12.30, SIZE 26.40, CELL HEIGHT 10, 
                 CELL WIDTH 10, COLOR IS 65793, ERASE, LABEL-OFFSET 0, 
                 LINK TO THREAD, MODELESS, NO-CLOSE, RESIZABLE, 
                 NO SCROLL, WITH SYSTEM MENU, 
                 ATW-CSS-CLASS "basicwinclass"
                 TITLE "Window with same color ", TITLE-BAR, NO WRAP, 
                 HANDLE IS Screen2-SF-HANDLE
      * main menu
           PERFORM Acu-Screen2-MN-1-Menu
           MOVE Menu-Handle TO Screen2-MN-1-HANDLE
           CALL "W$MENU" USING Wmenu-Show, Screen2-MN-1-HANDLE
      * toolbar
           DISPLAY Screen2 UPON Screen2-SF-HANDLE
      *    After-Create
           .

       Acu-Screen3-Create-Win.
      *    Before-Create
      * display screen
              DISPLAY Floating GRAPHICAL WINDOW
                 LINES 15.40, SIZE 30.50, CELL HEIGHT 10, 
                 CELL WIDTH 10, COLOR IS 65793, ERASE, LABEL-OFFSET 0, 
                 LINK TO THREAD, MODELESS, NO-CLOSE, RESIZABLE, 
                 NO SCROLL, WITH SYSTEM MENU, 
                 ATW-CSS-ID "specwinid"
                 TITLE "window with new color", TITLE-BAR, NO WRAP, 
                 HANDLE IS Screen3-SF-HANDLE
      * main menu
           PERFORM Acu-Screen3-MN-1-Menu
           MOVE Menu-Handle TO Screen3-MN-1-HANDLE
           CALL "W$MENU" USING Wmenu-Show, Screen3-MN-1-HANDLE
      * toolbar
           DISPLAY Screen3 UPON Screen3-SF-HANDLE
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
           PERFORM UNTIL Exit-Pushed
              ACCEPT Screen1  
                 ON EXCEPTION PERFORM Acu-Screen1-Evaluate-Func
              END-ACCEPT
           END-PERFORM
           DESTROY Screen1-Handle
           INITIALIZE Key-Status
           .
      * Screen2
       Acu-Screen2-Proc.
           PERFORM UNTIL Exit-Pushed
              ACCEPT Screen2  
                 ON EXCEPTION PERFORM Acu-Screen2-Evaluate-Func
              END-ACCEPT
           END-PERFORM
           DESTROY Screen2-SF-HANDLE
           INITIALIZE Key-Status
           .
      * Screen3
       Acu-Screen3-Proc.
           PERFORM UNTIL Exit-Pushed
              ACCEPT Screen3  
                 ON EXCEPTION PERFORM Acu-Screen3-Evaluate-Func
              END-ACCEPT
           END-PERFORM
           DESTROY Screen3-SF-HANDLE
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
      * Screen1-Pb-2 Link To
              WHEN Key-Status = 81
                 PERFORM Screen1-Pb-2-Link
      * Screen1-Pb-2a Link To
              WHEN Key-Status = 91
                 PERFORM Screen1-Pb-2a-Link
           END-EVALUATE
           MOVE 1 TO Accept-Control
           .

      * Screen2
       Acu-Screen2-Evaluate-Func.
           EVALUATE TRUE
              WHEN Exit-Pushed
                 PERFORM Acu-Screen2-Exit
              WHEN Event-Occurred
                 IF Event-Type = Cmd-Close
                    PERFORM Acu-Screen2-Exit
                 END-IF
           END-EVALUATE
           MOVE 1 TO Accept-Control
           .

      * Screen3
       Acu-Screen3-Evaluate-Func.
           EVALUATE TRUE
              WHEN Exit-Pushed
                 PERFORM Acu-Screen3-Exit
              WHEN Event-Occurred
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

      * Screen2-MN-1
       Acu-Screen2-MN-1-Menu.
           PERFORM Acu-Screen2-MN-1
              THRU Acu-Screen2-MN-1-Exit.

       Acu-Screen2-MN-1.
           CALL "W$MENU" USING Wmenu-New GIVING Menu-Handle
           IF Menu-Handle = ZERO
              GO TO Acu-Screen2-MN-1-Exit
           END-IF
           CALL "W$MENU" USING WMENU-ADD, Menu-Handle, 0, 0, "E&xit", 27
           .

       Acu-Screen2-MN-1-Exit.
           MOVE ZERO TO Return-Code.

      * Screen3-MN-1
       Acu-Screen3-MN-1-Menu.
           PERFORM Acu-Screen3-MN-1
              THRU Acu-Screen3-MN-1-Exit.

       Acu-Screen3-MN-1.
           CALL "W$MENU" USING Wmenu-New GIVING Menu-Handle
           IF Menu-Handle = ZERO
              GO TO Acu-Screen3-MN-1-Exit
           END-IF
           CALL "W$MENU" USING WMENU-ADD, Menu-Handle, 0, 0, "E&xit", 27
           .

       Acu-Screen3-MN-1-Exit.
           MOVE ZERO TO Return-Code.


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
       Screen1-Pb-2-Link.
            perform  Acu-Screen2-Routine
           .
      *
       Screen1-Pb-2a-Link.
            perform  Acu-Screen3-Routine
           .

       

      *{Bench}end
       REPORT-COMPOSER SECTION.

