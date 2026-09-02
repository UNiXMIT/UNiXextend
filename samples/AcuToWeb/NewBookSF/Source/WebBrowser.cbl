      *{Bench}prg-comment
      * WebBrowser.cbl
      * WebBrowser.cbl is generated from C:\AcuSamples\BookSF\NewBookSFwithATWID\WebBrowser.Psf
      *{Bench}end
       IDENTIFICATION              DIVISION.
      *{Bench}prgid
       PROGRAM-ID. WebBrowser.
       AUTHOR. support.
       DATE-WRITTEN. Tuesday, January 12, 2021 11:32:56 AM.
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
       77 Key-Status IS SPECIAL-NAMES CRT STATUS PIC 9(4) VALUE 0.
           88 Exit-Pushed VALUE 27.
           88 Message-Received VALUE 95.
           88 Event-Occurred VALUE 96.
           88 Screen-No-Input-Field VALUE 97.
           88 Screen-Time-Out VALUE 99.
      * property-defined variable

      * user-defined variable
       77 WebBrowser-Handle
                  USAGE IS HANDLE OF WINDOW VALUE NULL.
       77 WebBrowser-Mn-1-Handle
                  USAGE IS HANDLE OF MENU VALUE NULL.
       77 WebBrowser-Wb-1-Value        PIC  X(100)
                  VALUE IS "https://en.wikipedia.org/wiki/Main_Page".

      *{Bench}end
       LINKAGE                     SECTION.
      *{Bench}linkage
      *{Bench}end
       SCREEN                      SECTION.
      *{Bench}copy-screen
       01 WebBrowser.
           03 WebBrowser-Wb-1, Web-Browser, 
              COL 1.00, LINE 1.00, LINES 47.00 CELLS, SIZE 70.00 CELLS, 
              ID IS 1, VALUE WebBrowser-Wb-1-Value, 
              ATW-CSS-ID "ATW-WBrowser-WB".
           03 WebBrowser-Pb-1, Push-Button, 
              COL 27.00, LINE 50.00, LINES 3.00 CELLS, 
              SIZE 14.00 CELLS, 
              ID IS 2, SELF-ACT, CANCEL-BUTTON, 
              TITLE "Exit", ATW-CSS-ID "ATW-WBrowser-ExitButton".

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
           PERFORM Acu-WebBrowser-Routine
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

       Acu-WebBrowser-Routine.
      *    Before-Routine
           PERFORM Acu-WebBrowser-Scrn
           PERFORM Acu-WebBrowser-Proc
      *    After-Routine
           .

       Acu-WebBrowser-Scrn.
           PERFORM Acu-WebBrowser-Create-Win
           PERFORM Acu-WebBrowser-Init-Data
           .

       Acu-WebBrowser-Create-Win.
      *    Before-Create
      * display screen
              DISPLAY Floating GRAPHICAL WINDOW
                 LINES 53.00, SIZE 70.00, CELL HEIGHT 10, 
                 CELL WIDTH 10, COLOR IS 65793, LABEL-OFFSET 0, 
                 LINK TO THREAD, MODELESS, NO SCROLL, WITH SYSTEM MENU, 
                 TITLE "Screen", TITLE-BAR, NO WRAP, 
                 ATW-CSS-CLASS "ATW-SCREEN", 
                 EVENT PROCEDURE WebBrowser-Event-Proc, 
                 HANDLE IS WebBrowser-Handle
      * main menu
           PERFORM Acu-WebBrowser-Mn-1-Menu
           MOVE Menu-Handle TO WebBrowser-Mn-1-Handle
           CALL "W$MENU" USING Wmenu-Show, WebBrowser-Mn-1-Handle
      * toolbar
           DISPLAY WebBrowser UPON WebBrowser-Handle
      *    After-Create
           .

       Acu-WebBrowser-Init-Data.
      *    Before-Initdata
      *    After-Initdata
           .
      * WebBrowser
       Acu-WebBrowser-Proc.
           PERFORM UNTIL Exit-Pushed
              ACCEPT WebBrowser  
                 ON EXCEPTION PERFORM Acu-WebBrowser-Evaluate-Func
              END-ACCEPT
           END-PERFORM
           DESTROY WebBrowser-Handle
           INITIALIZE Key-Status
           .

      * WebBrowser
       Acu-WebBrowser-Evaluate-Func.
           EVALUATE TRUE
              WHEN Exit-Pushed
                 PERFORM Acu-WebBrowser-Exit
              WHEN Event-Occurred
                 IF Event-Type = Cmd-Close
                    PERFORM Acu-WebBrowser-Exit
                 END-IF
      * MI-Exit Link To
              WHEN Key-Status = 1001
                 PERFORM WebBrowser-Mn-1-MI-Exit-Link
           END-EVALUATE
           MOVE 1 TO Accept-Control
           .

       Acu-WebBrowser-Exit.
           SET Exit-Pushed TO TRUE
           .

      * WebBrowser-Mn-1
       Acu-WebBrowser-Mn-1-Menu.
           PERFORM Acu-WebBrowser-Mn-1
              THRU Acu-WebBrowser-Mn-1-Exit.

       Acu-WebBrowser-Mn-1.
           CALL "W$MENU" USING Wmenu-New GIVING Menu-Handle
           IF Menu-Handle = ZERO
              GO TO Acu-WebBrowser-Mn-1-Exit
           END-IF
           CALL "W$MENU" USING Wmenu-New GIVING Sub-Handle-1
           IF Sub-Handle-1 = ZERO
              MOVE ZERO TO Menu-Handle
              GO TO Acu-WebBrowser-Mn-1-EXIT
           END-IF
           CALL "W$MENU" USING WMENU-ADD, Menu-Handle, 0, 0, "File", 
              1000, Sub-Handle-1
           CALL "W$MENU" USING WMENU-ADD, Sub-Handle-1, 0, 0, "Exit", 
              1001
           CALL "W$MENU" USING Wmenu-New GIVING Sub-Handle-1
           IF Sub-Handle-1 = ZERO
              MOVE ZERO TO Menu-Handle
              GO TO Acu-WebBrowser-Mn-1-EXIT
           END-IF
           CALL "W$MENU" USING WMENU-ADD, Menu-Handle, 0, 0, "Help", 
              1002, Sub-Handle-1
           CALL "W$MENU" USING WMENU-ADD, Sub-Handle-1, 0, 0, "About", 
              1003
           .

       Acu-WebBrowser-Mn-1-Exit.
           MOVE ZERO TO Return-Code.


       WebBrowser-Event-Proc.
           .
      ***   start event editor code   ***
      *
       WebBrowser-Mn-1-MI-Exit-Link.
           Perform Acu-Exit-Rtn
           .

       

      *{Bench}end
       REPORT-COMPOSER SECTION.
