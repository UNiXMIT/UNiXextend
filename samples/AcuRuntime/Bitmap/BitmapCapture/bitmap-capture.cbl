      *{Bench}prg-comment
      * bitmap-capture.cbl
      * bitmap-capture.cbl is generated from C:\AcuSamples\bitmap-capture\bitmap-capture.Psf
      *{Bench}end
       IDENTIFICATION              DIVISION.
      *{Bench}prgid
       PROGRAM-ID. bitmap-capture.
       AUTHOR. CContardi.
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
       77 extend-JPG       PIC  S9(6)
                  USAGE IS COMP-4
                  VALUE IS 0.
       77 default-font
                  USAGE IS HANDLE OF FONT DEFAULT-FONT.
       77 Acucorp-bmp      PIC  S9(6)
                  USAGE IS COMP-4
                  VALUE IS 0.
       77 w-BITMAP-HANDLE
                  USAGE IS HANDLE OF BITMAP VALUE NULL.
       77 extend10-bmp     PIC  S9(6)
                  USAGE IS COMP-4
                  VALUE IS 0.
       77 Screen1-Wb-1-Value           PIC  X(100)
                  VALUE IS "file:///C:\MTurner\AcuSamples\AcuRuntime\Bit
      -           "map\BitmapCapture/extend10.bmp".
       77 ws-captured-bmp  PIC  x(100).

      *{Bench}end
       LINKAGE                     SECTION.
      *{Bench}linkage
      *{Bench}end
       SCREEN                      SECTION.
      *{Bench}copy-screen
       01 Screen1.
           03 Screen1-Pb-1, Push-Button, 
              COL 2,80, LINE 2,60, LINES 5,20 CELLS, SIZE 29,00 CELLS, 
              EXCEPTION-VALUE 1000, ID IS 2, 
              TITLE "click to capture the screen image".
           03 Screen1-Pb-2, Push-Button, 
              COL 2,80, LINE 8,10, LINES 5,20 CELLS, SIZE 29,00 CELLS, 
              EXCEPTION-VALUE 1003, ID IS 4, 
              TITLE "click to capture the desktop image".
           03 Screen1-Wb-1, Web-Browser, 
              COL 3,40, LINE 14,90, LINES 31,80 CELLS, 
              SIZE 58,00 CELLS, 
              ID IS 1, VALUE Screen1-Wb-1-Value.

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

       Acu-Screen1-Scrn.
           PERFORM Acu-Screen1-Create-Win
           PERFORM Acu-Screen1-Init-Data
           .

       Acu-Screen1-Create-Win.
      *    Before-Create
      * display screen
              DISPLAY Standard GRAPHICAL WINDOW
                 LINES 48,00, SIZE 64,00, CELL HEIGHT 10, 
                 CELL WIDTH 10, AUTO-MINIMIZE, COLOR IS 65793, 
                 CONTROL FONT default-font, LABEL-OFFSET 0, 
                 LINK TO THREAD, MODELESS, NO SCROLL, WITH SYSTEM MENU, 
                 TITLE "Screen", TITLE-BAR, NO WRAP, 
                 EVENT PROCEDURE Screen1-Event-Proc, 
                 HANDLE IS Screen1-Handle
      * toolbar
           DISPLAY Screen1 UPON Screen1-Handle
      *    After-Create
           .

       Acu-Screen1-Init-Data.
      *    Before-Initdata
           PERFORM Screen1-Aft-Initdata
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
              WHEN Key-Status = 1000
                 PERFORM Screen1-Pb-1-Link
      * Screen1-Pb-2 Link To
              WHEN Key-Status = 1003
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
       Screen1-Aft-Initdata.
      *    IF IS-REMOTE 
      *      MODIFY Screen1-Wb-1, 
      *             VALUE is "file:///C:/temp/extend10.bmp"
      *      MOVE "@[display]:C:\temp\captured.bmp" TO ws-captured-bmp
      *    ELSE
      *      MOVE "C:\temp\captured.bmp" TO ws-captured-bmp
      *    END-IF
           *> CAPTURE TO WINDOWS CLIPBOARD 
           MOVE SPACES TO ws-captured-bmp
           .
      *
       Screen1-Pb-1-Link.

           CALL "W$BITMAP" 
                USING WBITMAP-CAPTURE-IMAGE, 
                      ws-captured-bmp,
                      0, | 0 = active window is captured
                      0, | 0 = The entire window is captured, including the title bar, window frame, menu, etc.
                     32, | 1 = monochrome, 32 = 32-bits per pixel  
                GIVING w-BITMAP-HANDLE 

      *    MODIFY Screen1-Wb-1, VALUE is "file:///C:/temp/captured.bmp"
           .
      *
       Screen1-Pb-2-Link.
           CALL "W$BITMAP" 
                USING WBITMAP-CAPTURE-DESKTOP  
                      ws-captured-bmp,
                      32, | 1 = monochrome, 32 = 32-bits per pixel  
                GIVING w-BITMAP-HANDLE  

      *    MODIFY Screen1-Wb-1, VALUE is "file:///C:/temp/captured.bmp"
           .

       

      *{Bench}end
       REPORT-COMPOSER SECTION.
