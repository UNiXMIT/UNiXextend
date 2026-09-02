      *{Bench}prg-comment
      * Program1.cbl
      * Program1.cbl is generated from C:\AcuSamples\Browser\Program1.Psf
      *{Bench}end
       IDENTIFICATION              DIVISION.
      *{Bench}prgid
       PROGRAM-ID. Program1.
       AUTHOR. UNiX.
       DATE-WRITTEN. 17 April 2019 09:50:22.
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
       77 Screen2-Handle
                  USAGE IS HANDLE OF WINDOW VALUE NULL.
       77 Screen2-Wb-1-Value           PIC  X(50)
                  VALUE IS "https://google.com".
       77 Screen2-LM
                  USAGE IS HANDLE OF LAYOUT-MANAGER, LM-RESIZE
                  VALUE NULL.

      *{Bench}end
       LINKAGE                     SECTION.
      *{Bench}linkage
      *{Bench}end
       SCREEN                      SECTION.
      *{Bench}copy-screen
       01 Screen1.
           03 Screen1-Pb-1, Push-Button, 
              COL 6.00, LINE 7.00, LINES 4.00 CELLS, SIZE 12.00 CELLS, 
              ID IS 1, 
              TITLE "Browser Control", 
              EVENT PROCEDURE Screen1-Pb-1-Event-Proc.
           03 Screen1-Pb-1a, Push-Button, 
              COL 20.00, LINE 7.00, LINES 4.00 CELLS, SIZE 12.00 CELLS, 
              EXCEPTION-VALUE 1000, ID IS 2, 
              TITLE "EXIT", 
              EVENT PROCEDURE Screen1-Pb-1-Event-Proc.
       01 Screen2.
           03 Screen2-Wb-1, Web-Browser2, 
              COL 1.00, LINE 1.00, LINES 46.00 CELLS, SIZE 64.00 CELLS, 
              ID IS 99, VALUE Screen2-Wb-1-Value, LAYOUT-DATA = 17, 
              VISIBLE 0.
           03 Screen2-Pb-1, Push-Button, 
              COL 27.00, LINE 51.00, LINES 4.00 CELLS, 
              SIZE 12.00 CELLS, 
              EXCEPTION-VALUE 1000, ID IS 2, 
              TITLE "Close Browser", LAYOUT-DATA = 34.

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

       Acu-Screen2-Routine.
      *    Before-Routine
           PERFORM Acu-Screen2-Scrn
           PERFORM Acu-Screen2-Proc
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

       Acu-Screen1-Create-Win.
      *    Before-Create
      * display screen
              DISPLAY Standard GRAPHICAL WINDOW
                 LINES 16.00, SIZE 36.00, CELL HEIGHT 10, 
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

       Acu-Screen2-Create-Win.
      *    Before-Create
      * display screen
              DISPLAY Floating GRAPHICAL WINDOW
                 LINES 56.00, SIZE 64.00, LAYOUT-MANAGER IS Screen2-LM 
                 CELL HEIGHT 10, CELL WIDTH 10, ACTION Action-Maximize, 
                 COLOR IS 65793, LABEL-OFFSET 0, LINK TO THREAD, 
                 MODELESS, RESIZABLE, NO SCROLL, WITH SYSTEM MENU, 
                 TITLE "Screen", TITLE-BAR, NO WRAP, 
                 EVENT PROCEDURE Screen2-Event-Proc, 
                 HANDLE IS Screen2-Handle
      * toolbar
           DISPLAY Screen2 UPON Screen2-Handle
           PERFORM Screen2-Aft-Create
           .

       Acu-Screen1-Init-Data.
      *    Before-Initdata
      *    After-Initdata
           .

       Acu-Screen2-Init-Data.
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
           DESTROY Screen2-Handle
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
      * Screen1-Pb-1a Link To
              WHEN Key-Status = 1000
                 PERFORM Acu-Screen1-Exit
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
      * Screen2-Pb-1 Link To
              WHEN Key-Status = 1000
                 PERFORM Acu-Screen2-Exit
           END-EVALUATE
           MOVE 1 TO Accept-Control
           .

       Acu-Screen1-Exit.
           SET Exit-Pushed TO TRUE
           .

       Acu-Screen2-Exit.
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

       Screen1-Pb-1-Event-Proc.
      * 
           EVALUATE Event-Type
           WHEN Cmd-Clicked
              EVALUATE Event-Control-Id
              WHEN 1
                 PERFORM Screen1-Pb-1-Ev-Cmd-Clicked
              END-EVALUATE
           END-EVALUATE
           .

       Screen2-Event-Proc.
           .
      ***   start event editor code   ***
      *
       Screen1-Pb-1-Ev-Cmd-Clicked.
           perform Acu-Screen2-Routine
           .
      *
       Screen2-Aft-Create.
           MOVE 4 to ACCEPT-CONTROL.
           MOVE 99 to CONTROL-ID.
           MODIFY Screen2-Wb-1, VISIBLE TRUE
           .
       

      *{Bench}end
       REPORT-COMPOSER SECTION.
