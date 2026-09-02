      *{Bench}prg-comment
      * web-browser.cbl
      * web-browser.cbl is generated from C:\AcuSamples\web-browser\web-browser\web-browser.Psf
      *{Bench}end
       IDENTIFICATION              DIVISION.
      *{Bench}prgid
       PROGRAM-ID. web-browser.
       AUTHOR. CContardi.
       DATE-WRITTEN. martedì 21 novembre 2017 15:48:04.
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
       77 Screen1-LM
                  USAGE IS HANDLE OF LAYOUT-MANAGER, LM-RESIZE
                  VALUE NULL.
       77 ws-pdf-location           PIC  x(150) value spaces.
       77 ws-acutoweb-location      PIC  x(150) value spaces.
       77 ws-acutoweb-url           PIC  x(150) value spaces.
AToWeb 77 env-acutoweb-path         pic  x(150) value spaces.
AToWeb 77 env-acutoweb-url          pic  x(150) value spaces.

      *{Bench}end
       LINKAGE                     SECTION.
       77 ln-path          PIC  x(100).
       77 ln-name          PIC  x(050).
      *{Bench}linkage
      *{Bench}end
       SCREEN                      SECTION.
      *{Bench}copy-screen
       01 Screen1.
           03 Screen1-Wb-1, Web-Browser, 
              COL 2, LINE 2, LINES 45 CELLS, SIZE 61 CELLS, 
              ID IS 3, LAYOUT-DATA = 17, 
              EVENT PROCEDURE Screen1-Wb-1-Event-Proc.

      *{Bench}end

      *{Bench}linkpara
       PROCEDURE DIVISION using ln-path, ln-name.
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
              DISPLAY Floating GRAPHICAL WINDOW
                 LINES 48,00, SIZE 64,00, LAYOUT-MANAGER IS Screen1-LM 
                 CELL HEIGHT 10, CELL WIDTH 10, COLOR IS 65793, 
                 LABEL-OFFSET 0, LINK TO THREAD, MODELESS, RESIZABLE, 
                 NO SCROLL, WITH SYSTEM MENU, 
                 TITLE "PDF file viewer", TITLE-BAR, NO WRAP, 
                 HANDLE IS Screen1-Handle
      * toolbar
           DISPLAY Screen1 UPON Screen1-Handle
      *    After-Create
           .

       Acu-Screen1-Init-Data.
      *    Before-Initdata
AToWeb        INITIALIZE env-acutoweb-path
                         env-acutoweb-url
                         ws-pdf-location
                         ws-acutoweb-location
                         ws-acutoweb-url
                         
              ACCEPT env-acutoweb-path FROM ENVIRONMENT "ACUTOWEB_PATH"
              ACCEPT env-acutoweb-url  FROM ENVIRONMENT "ACUTOWEB_URL"
              INSPECT env-acutoweb-path 
                      REPLACING TRAILING SPACES BY LOW-VALUES
              INSPECT env-acutoweb-url 
                      REPLACING TRAILING SPACES BY LOW-VALUES         
              
              STRING ln-path delimited by spaces
                     "\"
                     ln-name delimited by spaces
                     INTO ws-pdf-location        
              
              STRING env-acutoweb-path delimited by low-values
                     "Web\"            delimited by size
                     ln-name delimited by spaces
                     INTO ws-acutoweb-location

AToWeb* Il file PDF deve essere sotto alla AcuToWeb\Web per essere visualizzabile nel browser    
AToWeb* PDF file must be copied under server's AcuToWeb\Web folder to be visible in the browser  
AToWeb        CALL "C$COPY" USING ws-pdf-location ws-acutoweb-location  

              STRING env-acutoweb-url delimited by low-values
                     ln-name delimited by spaces
                     INTO ws-acutoweb-url

              MODIFY Screen1-Wb-1, VALUE = ws-acutoweb-url
           .            
                                   
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
AToWeb     CALL "C$DELETE" USING ws-acutoweb-location                        
           .

       Screen1-Wb-1-Event-Proc.
      * 
           .
      ***   start event editor code   ***
      *

       

      *{Bench}end
       REPORT-COMPOSER SECTION.
