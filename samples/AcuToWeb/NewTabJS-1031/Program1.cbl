      *{Bench}prg-comment
      * Program1.cbl
      * Program1.cbl is generated from C:\AcuSamples\AcuToWeb\ATW-PDFinNewTabJS\Program1.Psf
      *{Bench}end
       IDENTIFICATION              DIVISION.
      *{Bench}prgid
       PROGRAM-ID. Program1.
       AUTHOR. support.
       DATE-WRITTEN. Wednesday, January 27, 2021 4:36:36 PM.
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
       01 RELEASE-VERSION  PIC  X(50)
                  VALUE IS SPACES.
       77 Screen1-Rb-1-Value           PIC  S9(1)
                  VALUE IS 0.

      *{Bench}end
       LINKAGE                     SECTION.
      *{Bench}linkage
      *{Bench}end
       SCREEN                      SECTION.
      *{Bench}copy-screen
       01 Screen1.
           03 Screen1-Pb-1, Push-Button, 
              COL 11.90, LINE 27.00, LINES 5.40 CELLS, 
              SIZE 11.30 CELLS, 
              ID IS 1, 
              TITLE "OPEN", ATW-CSS-ID "OPEN-JS", 
              EVENT PROCEDURE Screen1-Pb-1-Event-Proc.
           03 Screen1-Rb-1, Radio-Button, 
              COL 8.10, LINE 5.90, LINES 3.20 CELLS, SIZE 19.00 CELLS, 
              GROUP 1, GROUP-VALUE 1, ID IS 2, 
              TITLE "extend 10.2.0 Release Notes", 
              VALUE Screen1-Rb-1-Value, 
              EVENT PROCEDURE Screen1-Rb-1-Event-Proc.
           03 Screen1-Rb-1a, Radio-Button, 
              COL 8.10, LINE 11.10, LINES 3.20 CELLS, SIZE 19.00 CELLS, 
              GROUP 1, GROUP-VALUE 2, ID IS 3, 
              TITLE "extend 10.2.1 Release Notes", 
              VALUE Screen1-Rb-1-Value, 
              EVENT PROCEDURE Screen1-Rb-1a-Event-Proc.
           03 Screen1-Rb-1b, Radio-Button, 
              COL 8.10, LINE 16.10, LINES 3.20 CELLS, SIZE 19.00 CELLS, 
              GROUP 1, GROUP-VALUE 3, ID IS 4, 
              TITLE "extend 10.3.0 Release Notes", 
              VALUE Screen1-Rb-1-Value, 
              EVENT PROCEDURE Screen1-Rb-1b-Event-Proc.
           03 Screen1-La-1, Label, 
              COL 6.00, LINE 22.10, LINES 1.80 CELLS, SIZE 23.20 CELLS, 
              ID IS 5, CENTER, LABEL-OFFSET 0, TITLE RELEASE-VERSION, 
              ATW-CSS-ID "WS-URL".

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
                 LINES 35.20, SIZE 33.20, CELL HEIGHT 10, 
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

       Screen1-Pb-1-Event-Proc.
           .

       Screen1-Rb-1-Event-Proc.
      * 
           EVALUATE Event-Type
           WHEN Cmd-Clicked
              PERFORM Screen1-Rb-1-Ev-Cmd-Clicked
           END-EVALUATE
           .

       Screen1-Rb-1a-Event-Proc.
      * 
           EVALUATE Event-Type
           WHEN Cmd-Clicked
              PERFORM Screen1-Rb-1a-Ev-Cmd-Clicked
           END-EVALUATE
           .

       Screen1-Rb-1b-Event-Proc.
      * 
           EVALUATE Event-Type
           WHEN Cmd-Clicked
              PERFORM Screen1-Rb-1b-Ev-Cmd-Clicked
           END-EVALUATE
           .
      ***   start event editor code   ***
      *
       Screen1-Rb-1-Ev-Cmd-Clicked.
           INITIALIZE RELEASE-VERSION
           MOVE "http://bit.ly/extend1020" TO RELEASE-VERSION
           PERFORM UPDATE-LABEL
           .
      *
       Screen1-Rb-1a-Ev-Cmd-Clicked.
           INITIALIZE RELEASE-VERSION
           MOVE "http://bit.ly/extend1021" TO RELEASE-VERSION
           PERFORM UPDATE-LABEL
           .
      *
       Screen1-Rb-1b-Ev-Cmd-Clicked.
           INITIALIZE RELEASE-VERSION
           MOVE "http://bit.ly/2R34DeE" TO RELEASE-VERSION
           PERFORM UPDATE-LABEL
           .
      *
       UPDATE-LABEL.
           MODIFY Screen1-La-1 TITLE = RELEASE-VERSION
           .

       

      *{Bench}end
       REPORT-COMPOSER SECTION.
