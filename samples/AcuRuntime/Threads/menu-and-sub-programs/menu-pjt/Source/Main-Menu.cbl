      *{Bench}prg-comment
      * Main-Menu.cbl
      * Main-Menu.cbl is generated from C:\AcuSamples\threads\menu-and-sub-programs\menu-pjt\Main-Menu.Psf
      *{Bench}end
       IDENTIFICATION              DIVISION.
      *{Bench}prgid
       PROGRAM-ID. Main-Menu.
       AUTHOR. support.
       DATE-WRITTEN. Thursday, July 22, 2021 12:16:47 PM.
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
                  USAGE IS HANDLE OF WINDOW
                  VALUE IS 0.
       01 CALCULATOR-WINDOW EXTERNAL 
                  USAGE IS HANDLE OF WINDOW.
      *
      *
       01 COMBOBOX-WINDOW EXTERNAL 
                  USAGE IS HANDLE OF WINDOW.
       01 CALC-THREAD-HANDLE
                  USAGE IS HANDLE OF THREAD
                  VALUE IS 0.
       01 COMBOBOX-THREAD-HANDLE
                  USAGE IS HANDLE OF THREAD
                  VALUE IS 0.

      *{Bench}end
       LINKAGE                     SECTION.
      *{Bench}linkage
      *{Bench}end
       SCREEN                      SECTION.
      *{Bench}copy-screen
       01 Screen1.
           03 Screen1-Pb-1, Push-Button, 
              COL 3.20, LINE 2.90, LINES 4.10 CELLS, SIZE 14.00 CELLS, 
              EXCEPTION-VALUE 111, ID IS 1, 
              TITLE "Calculator".
           03 Screen1-Pb-2, Push-Button, 
              COL 3.10, LINE 8.00, LINES 4.10 CELLS, SIZE 14.00 CELLS, 
              EXCEPTION-VALUE 222, ID IS 2, 
              TITLE "ComboBox Sample".
           03 Screen1-Pb-3, Push-Button, 
              COL 3.10, LINE 13.40, LINES 4.10 CELLS, SIZE 14.00 CELLS, 
              EXCEPTION-VALUE 27, ID IS 3, CANCEL-BUTTON, 
              TITLE "Exit".

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
              DISPLAY Initial GRAPHICAL WINDOW
                 LINES 21.00, SIZE 20.10, CELL HEIGHT 10, 
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
           PERFORM Screen1-Bef-Initdata
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
              WHEN Key-Status = 111
                 PERFORM Screen1-Pb-1-Link
      * Screen1-Pb-2 Link To
              WHEN Key-Status = 222
                 PERFORM Screen1-Pb-2-Link
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
           IF CALCULATOR-WINDOW > 0
              SET I-O WINDOW TO CALCULATOR-WINDOW
           ELSE  
              CALL IN THREAD "calc3ForThread" 
                   HANDLE IN CALC-THREAD-HANDLE
           END-IF   
           .
      *
       Screen1-Pb-2-Link.
           IF COMBOBOX-WINDOW > 0  
              SET I-O WINDOW TO COMBOBOX-WINDOW 
           ELSE  
              CALL IN THREAD "comboboxForThread" 
                   HANDLE IN COMBOBOX-THREAD-HANDLE
           END-IF   
           .
      *
       Screen1-Bef-Initdata.
           INITIALIZE CALCULATOR-WINDOW COMBOBOX-WINDOW
           .

       

      *{Bench}end
       REPORT-COMPOSER SECTION.
