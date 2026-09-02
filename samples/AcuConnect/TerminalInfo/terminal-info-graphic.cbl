      *{Bench}prg-comment
      * terminal-info-graphic.cbl
      * terminal-info-graphic.cbl is generated from C:\AcuSamples\terminal-info\terminal-info-pjt\terminal-info-graphic.Psf
      *{Bench}end
       IDENTIFICATION              DIVISION.
      *{Bench}prgid
       PROGRAM-ID. terminal-info-graphic.
       AUTHOR. CContardi.
       DATE-WRITTEN. luned� 25 settembre 2017 15:56:07.
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
       77 ws-client        PIC  X(64).
       77 ws-TERMINAL-NAME PIC  X(64).
       77 ws-USER-ID       PIC  x(12).
       77 WS-IS-REMOTE     PIC  X(12).
       77 ws-PHYSICAL-SCREEN-HEIGHT    PIC  X(64).
       77 ws-PHYSICAL-SCREEN-WIDTH     PIC  X(64).
       77 WS-USABLE-SCREEN-HEIGHT      PIC  X(12).
       77 WS-USABLE-SCREEN-WIDTH       PIC  X(12).
       77 ws-client-machine-name       PIC  X(64).
       77 ws-client-user-id            PIC  X(64).
       77 ws-os            PIC  X(10).
       77 ws-BROWSER-NAME  PIC  X(30).
       77 ws-BROWSER-VERSION           PIC  X(10).
       77 ws-ENGINE-NAME   PIC  X(30).
       77 ws-ENGINE-VERSION            PIC  X(10).
       77 ws-CLIENT-OS-NAME            PIC  X(30).
       77 ws-CLIENT-OS-VERSION         PIC  X(10).
       77 ws-CLIENT-DEVICE-TYPE        PIC  X(30).
       77 ws-CLIENT-DEVICE-VENDOR      PIC  X(30).
       77 ws-CLIENT-DEVICE-MODEL       PIC  X(30).

      *{Bench}end
       LINKAGE                     SECTION.
      *{Bench}linkage
      *{Bench}end
       SCREEN                      SECTION.
      *{Bench}copy-screen
       01 Screen1, 
           BEFORE PROCEDURE Screen1-Bef-Procedure.
           03 Screen1-Pb-1, Push-Button, 
              COL 42,60, LINE 40,50, LINES 2,80 CELLS, 
              SIZE 10,10 CELLS, 
              EXCEPTION-VALUE 123, ID IS 1, 
              TITLE "Refresh".
           03 Screen1-La-1, Label, 
              COL 3,50, LINE 30,70, LINES 1,60 CELLS, SIZE 17,70 CELLS, 
              ID IS 2, LABEL-OFFSET 0, 
              TITLE "CLIENT-MACHINE-NAME".
           03 Screen1-La-2, Label, 
              COL 25,00, LINE 30,70, LINES 1,90 CELLS, 
              SIZE 17,10 CELLS, 
              ID IS 3, LABEL-OFFSET 0, TITLE ws-client-machine-name.
           03 Screen1-La-1a, Label, 
              COL 3,50, LINE 7,50, LINES 2,30 CELLS, SIZE 15,50 CELLS, 
              ID IS 4, LABEL-OFFSET 0, 
              TITLE "TERMINAL-NAME".
           03 Screen1-La-2a, Label, 
              COL 25,00, LINE 7,50, LINES 1,90 CELLS, SIZE 17,10 CELLS, 
              ID IS 5, LABEL-OFFSET 0, TITLE ws-TERMINAL-NAME.
           03 Screen1-La-1aa, Label, 
              COL 3,50, LINE 19,80, LINES 4,10 CELLS, SIZE 17,70 CELLS, 
              ID IS 6, LABEL-OFFSET 0, 
              TITLE "OPERATING-SYSTEM (on the Server)".
           03 Screen1-La-2aa, Label, 
              COL 25,00, LINE 19,80, LINES 1,90 CELLS, 
              SIZE 17,10 CELLS, 
              ID IS 7, LABEL-OFFSET 0, TITLE ws-os.
           03 Screen1-La-1aaa, Label, 
              COL 3,50, LINE 27,70, LINES 1,60 CELLS, SIZE 8,60 CELLS, 
              ID IS 8, LABEL-OFFSET 0, 
              TITLE "IS-REMOTE".
           03 Screen1-La-2aaa, Label, 
              COL 25,00, LINE 27,70, LINES 1,90 CELLS, 
              SIZE 17,10 CELLS, 
              ID IS 9, LABEL-OFFSET 0, TITLE WS-IS-REMOTE.
           03 Screen1-La-1b, Label, 
              COL 3,50, LINE 13,20, LINES 1,60 CELLS, SIZE 20,50 CELLS, 
              ID IS 10, LABEL-OFFSET 0, 
              TITLE "PHYSICAL-SCREEN-HEIGHT".
           03 Screen1-La-2b, Label, 
              COL 25,00, LINE 13,20, LINES 1,90 CELLS, SIZE 5,40 CELLS, 
              ID IS 11, LABEL-OFFSET 0, 
              TITLE ws-PHYSICAL-SCREEN-HEIGHT.
           03 Screen1-La-1ab, Label, 
              COL 3,50, LINE 16,10, LINES 1,60 CELLS, SIZE 19,80 CELLS, 
              ID IS 12, LABEL-OFFSET 0, 
              TITLE "PHYSICAL-SCREEN-WIDTH".
           03 Screen1-La-2ab, Label, 
              COL 25,00, LINE 16,10, LINES 1,90 CELLS, SIZE 5,20 CELLS, 
              ID IS 13, LABEL-OFFSET 0, TITLE ws-PHYSICAL-SCREEN-WIDTH.
           03 Screen1-La-1aab, Label, 
              COL 31,00, LINE 13,20, LINES 1,60 CELLS, SIZE 5,50 CELLS, 
              ID IS 14, LABEL-OFFSET 0, 
              TITLE "(usable".
           03 Screen1-La-2aab, Label, 
              COL 38,30, LINE 13,20, LINES 1,90 CELLS, SIZE 5,20 CELLS, 
              ID IS 15, LABEL-OFFSET 0, TITLE WS-USABLE-SCREEN-HEIGHT.
           03 Screen1-La-2aaaa, Label, 
              COL 38,30, LINE 16,10, LINES 1,90 CELLS, SIZE 5,20 CELLS, 
              ID IS 17, LABEL-OFFSET 0, TITLE WS-USABLE-SCREEN-WIDTH.
           03 Screen1-La-1aaba, Label, 
              COL 31,00, LINE 16,10, LINES 1,60 CELLS, SIZE 5,50 CELLS, 
              ID IS 18, LABEL-OFFSET 0, 
              TITLE "(usable".
           03 Screen1-La-1aabb, Label, 
              COL 44,00, LINE 13,20, LINES 1,60 CELLS, SIZE 0,80 CELLS, 
              ID IS 16, LABEL-OFFSET 0, 
              TITLE ")".
           03 Screen1-La-1aabba, Label, 
              COL 44,00, LINE 16,10, LINES 1,60 CELLS, SIZE 0,80 CELLS, 
              ID IS 19, LABEL-OFFSET 0, 
              TITLE ")".
           03 Screen1-La-1c, Label, 
              COL 3,50, LINE 33,40, LINES 1,60 CELLS, SIZE 12,30 CELLS, 
              ID IS 20, LABEL-OFFSET 0, 
              TITLE "CLIENT-USER-ID".
           03 Screen1-La-2c, Label, 
              COL 25,00, LINE 33,40, LINES 1,90 CELLS, 
              SIZE 17,10 CELLS, 
              ID IS 21, LABEL-OFFSET 0, TITLE ws-client-user-id.
           03 Screen1-La-2ac, Label, 
              COL 25,00, LINE 10,20, LINES 1,90 CELLS, 
              SIZE 17,10 CELLS, 
              ID IS 22, LABEL-OFFSET 0, TITLE WS-USER-ID.
           03 Screen1-La-1ac, Label, 
              COL 3,50, LINE 10,20, LINES 2,30 CELLS, SIZE 15,50 CELLS, 
              ID IS 23, LABEL-OFFSET 0, 
              TITLE "USER-ID".
           03 Screen1-Br-1, Bar, 
              COL 47,10, LINE 2,20, LINES 36,80 CELLS, 
              ID IS 24, WIDTH 1.
           03 Screen1-La-3, Label, 
              COL 50,60, LINE 3,60, LINES 1,60 CELLS, SIZE 30,00 CELLS, 
              ID IS 25, LABEL-OFFSET 0, 
              TITLE "NEW IN 10.2 - ECN-4501:".
           03 Screen1-La-4, Label, 
              COL 50,60, LINE 7,30, LINES 1,60 CELLS, SIZE 12,80 CELLS, 
              ID IS 26, LABEL-OFFSET 0, 
              TITLE "BROWSER-NAME".
           03 Screen1-La-4a, Label, 
              COL 50,60, LINE 10,60, LINES 1,60 CELLS, 
              SIZE 15,20 CELLS, 
              ID IS 27, LABEL-OFFSET 0, 
              TITLE "BROWSER-VERSION".
           03 Screen1-La-4b, Label, 
              COL 50,60, LINE 13,90, LINES 1,60 CELLS, 
              SIZE 10,80 CELLS, 
              ID IS 28, LABEL-OFFSET 0, 
              TITLE "ENGINE-NAME".
           03 Screen1-La-4ba, Label, 
              COL 50,60, LINE 17,20, LINES 1,60 CELLS, 
              SIZE 13,20 CELLS, 
              ID IS 29, LABEL-OFFSET 0, 
              TITLE "ENGINE-VERSION".
           03 Screen1-La-4baa, Label, 
              COL 50,60, LINE 20,50, LINES 1,60 CELLS, 
              SIZE 13,00 CELLS, 
              ID IS 30, LABEL-OFFSET 0, 
              TITLE "CLIENT-OS-NAME".
           03 Screen1-La-4baaa, Label, 
              COL 50,60, LINE 23,80, LINES 1,60 CELLS, 
              SIZE 15,40 CELLS, 
              ID IS 31, LABEL-OFFSET 0, 
              TITLE "CLIENT-OS-VERSION".
           03 Screen1-La-4baaaa, Label, 
              COL 50,60, LINE 27,10, LINES 1,60 CELLS, 
              SIZE 16,10 CELLS, 
              ID IS 32, LABEL-OFFSET 0, 
              TITLE "CLIENT-DEVICE-TYPE".
           03 Screen1-La-4baaaaa, Label, 
              COL 50,60, LINE 30,40, LINES 1,60 CELLS, 
              SIZE 18,50 CELLS, 
              ID IS 33, LABEL-OFFSET 0, 
              TITLE "CLIENT-DEVICE-VENDOR".
           03 Screen1-La-4baaaaaa, Label, 
              COL 50,60, LINE 33,70, LINES 1,60 CELLS, 
              SIZE 17,30 CELLS, 
              ID IS 34, LABEL-OFFSET 0, 
              TITLE "CLIENT-DEVICE-MODEL".
           03 Screen1-La-4c, Label, 
              COL 72,40, LINE 7,50, LINES 1,60 CELLS, SIZE 12,80 CELLS, 
              ID IS 35, LABEL-OFFSET 0, TITLE ws-BROWSER-NAME.
           03 Screen1-La-4aa, Label, 
              COL 72,40, LINE 10,80, LINES 1,60 CELLS, 
              SIZE 15,20 CELLS, 
              ID IS 36, LABEL-OFFSET 0, TITLE ws-BROWSER-VERSION.
           03 Screen1-La-4bb, Label, 
              COL 72,40, LINE 14,10, LINES 1,60 CELLS, 
              SIZE 10,80 CELLS, 
              ID IS 37, LABEL-OFFSET 0, TITLE ws-ENGINE-NAME.
           03 Screen1-La-4bab, Label, 
              COL 72,40, LINE 17,40, LINES 1,60 CELLS, 
              SIZE 13,20 CELLS, 
              ID IS 38, LABEL-OFFSET 0, TITLE ws-ENGINE-VERSION.
           03 Screen1-La-4baab, Label, 
              COL 72,40, LINE 20,70, LINES 1,60 CELLS, 
              SIZE 13,00 CELLS, 
              ID IS 39, LABEL-OFFSET 0, TITLE ws-CLIENT-OS-NAME.
           03 Screen1-La-4baaab, Label, 
              COL 72,40, LINE 24,00, LINES 1,60 CELLS, 
              SIZE 15,40 CELLS, 
              ID IS 40, LABEL-OFFSET 0, TITLE ws-CLIENT-OS-VERSION.
           03 Screen1-La-4baaaab, Label, 
              COL 72,40, LINE 27,30, LINES 1,60 CELLS, 
              SIZE 16,10 CELLS, 
              ID IS 41, LABEL-OFFSET 0, TITLE ws-CLIENT-DEVICE-TYPE.
           03 Screen1-La-4baaaaab, Label, 
              COL 72,40, LINE 30,60, LINES 1,60 CELLS, 
              SIZE 18,50 CELLS, 
              ID IS 42, LABEL-OFFSET 0, TITLE ws-CLIENT-DEVICE-VENDOR.
           03 Screen1-La-4baaaaaaa, Label, 
              COL 72,40, LINE 33,90, LINES 1,60 CELLS, 
              SIZE 17,30 CELLS, 
              ID IS 43, LABEL-OFFSET 0, TITLE ws-CLIENT-DEVICE-MODEL.

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
                 LINES 44,80, SIZE 97,50, CELL HEIGHT 10, 
                 CELL WIDTH 10, AUTO-MINIMIZE, COLOR IS 65793, 
                 LABEL-OFFSET 0, LINK TO THREAD, MODELESS, RESIZABLE, 
                 NO SCROLL, WITH SYSTEM MENU, 
                 TITLE "Information about the Client", TITLE-BAR, 
                 NO WRAP, 
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
      * Screen1-Pb-1 Link To
              WHEN Key-Status = 123
                 PERFORM Screen1-Pb-1-Link
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

           ACCEPT TERMINAL-ABILITIES FROM TERMINAL-INFO. 

           MOVE CLIENT-MACHINE-NAME    TO ws-client-machine-name
           MOVE CLIENT-USER-ID         TO ws-client-user-id
           MOVE TERMINAL-NAME          TO ws-TERMINAL-NAME 
           IF IS-REMOTE
             MOVE "Yes"                TO ws-IS-REMOTE
           ELSE        
             MOVE "No"                 TO ws-IS-REMOTE
           END-IF
           MOVE USABLE-SCREEN-HEIGHT   TO ws-USABLE-SCREEN-HEIGHT
           MOVE USABLE-SCREEN-WIDTH    TO ws-USABLE-SCREEN-WIDTH   
           MOVE PHYSICAL-SCREEN-HEIGHT TO ws-PHYSICAL-SCREEN-HEIGHT
           MOVE PHYSICAL-SCREEN-WIDTH  TO ws-PHYSICAL-SCREEN-WIDTH

           MOVE ATW-BROWSER-NAME         TO ws-BROWSER-NAME             
           MOVE ATW-BROWSER-VERSION      TO ws-BROWSER-VERSION          
           MOVE ATW-ENGINE-NAME          TO ws-ENGINE-NAME              
           MOVE ATW-ENGINE-VERSION       TO ws-ENGINE-VERSION           
           MOVE ATW-CLIENT-OS-NAME       TO ws-CLIENT-OS-NAME           
           MOVE ATW-CLIENT-OS-VERSION    TO ws-CLIENT-OS-VERSION        
           MOVE ATW-CLIENT-DEVICE-TYPE   TO ws-CLIENT-DEVICE-TYPE       
           MOVE ATW-CLIENT-DEVICE-VENDOR TO ws-CLIENT-DEVICE-VENDOR     
           MOVE ATW-CLIENT-DEVICE-MODEL  TO ws-CLIENT-DEVICE-MODEL      

           ACCEPT SYSTEM-INFORMATION FROM SYSTEM-INFO.

           MOVE USER-ID                 TO WS-USER-ID       
           MOVE OPERATING-SYSTEM        TO ws-os
 
           display Screen1                                   
           .
      *
       Screen1-Bef-Procedure.
           perform Screen1-Pb-1-Link
           .

       

      *{Bench}end
       REPORT-COMPOSER SECTION.
