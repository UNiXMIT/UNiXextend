      * Program2.cbl
      * Program2.cbl is generated from D:\examples\APIs&DLLs\ProgressBar\Program2.Psf
     
       IDENTIFICATION              DIVISION.
       PROGRAM-ID. Program2.
       AUTHOR. mprince.
       DATE-WRITTEN. Tuesday, December 02, 2003 11:34:04 AM.
       REMARKS.
      *This sample program demonstrates the use of Microsoft's 
      *ProgressBar Control version 6.0 (sp4).
      *It shows how to change the look of the control, compares it to
      *AcuCOBOL-GT's frame, and shows how to run the control in a 
      *thread so that the user can stop the process.

       ENVIRONMENT                DIVISION.
       CONFIGURATION               SECTION.
       SPECIAL-NAMES.
       COPY "ProgressBar.def".
       COPY "Acuclass.Def".
           .
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
       COPY "activex.def".
       COPY "showmsg.def".
      *{Bench}end

       77 Quit-Mode-Flag PIC S9(5) COMP-1 VALUE 0. 
       77 Key-Status IS SPECIAL-NAMES CRT STATUS PIC 9(4) VALUE 0.
           88 Exit-Pushed VALUE 27.
           88 Message-Received VALUE 95.
           88 Event-Occurred VALUE 96.
           88 Screen-No-Input-Field VALUE 97.
           88 Screen-Time-Out VALUE 99.
      * property-defined variable

      * user-defined variable
       77 Screen1-Handle
                  USAGE IS HANDLE OF WINDOW.
       77 frame-value      PIC  9(3).
       77 int  PIC  9(3).
       77 thread1-handle
                  USAGE IS HANDLE OF THREAD.
       77 ef-val           PIC  999.
       77 ActiveX-Res
                  USAGE IS HANDLE OF RESOURCE.
       77 scroll-state     PIC  9.
       01 exit-status pic 9(5) value zero.
       01 CMD-LINE    pic x(20) value "start.bat".

      *{Bench}copy-working 
       COPY "Program2.wrk".
      *{Bench}end
       LINKAGE                     SECTION.
      *{Bench}linkage
      *{Bench}end
       SCREEN                      SECTION.

      *{Bench}copy-screen
       COPY "Program2.scr".
      *{Bench}end
       PROCEDURE DIVISION.

       Acu-Main-Logic.
      *    Before-Program
           PERFORM Acu-Initial-Routine
      * run main screen
      *{Bench}run-mainscr
           PERFORM Acu-Screen1-Routine
      *{Bench}end
           PERFORM Acu-Exit-Rtn
           .

       COPY "showmsg.cpy".

       Acu-Initial-Routine.
      *    Before-Init
      * get system information
           ACCEPT System-Information FROM System-Info
      * get terminal information
           ACCEPT Terminal-Abilities FROM Terminal-Info
      * load resource
           PERFORM Acu-Init-Res
      *    After-Init
           .

       Acu-Init-Res.
      * resource loading
           COPY RESOURCE "Program2.res".
           CALL "C$RESOURCE" USING CRESOURCE-LOAD "Program2.res", 
              GIVING ActiveX-Res
           .

       Acu-Exit-Rtn.
           CALL "C$RESOURCE" USING CRESOURCE-DESTROY, ActiveX-Res
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
                 LINES 53.30, SIZE 71.90, CELL HEIGHT 10, 
                 CELL WIDTH 10, AUTO-MINIMIZE, COLOR IS 65793, 
                 LABEL-OFFSET 0, LINK TO THREAD, MODELESS, NO SCROLL, 
                 WITH SYSTEM MENU, 
                 TITLE "Screen", TITLE-BAR, NO WRAP, 
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
      * Screen1-Pb-2 Link To
              WHEN Key-Status = 100
                 PERFORM Screen1-Pb-2-Link
      * Screen1-Pb-3 Link To
              WHEN Key-Status = 101
                 PERFORM Screen1-Pb-3-Link
      * Screen1-Pb-5 Link To
              WHEN Key-Status = 102
                 PERFORM Screen1-Pb-5-Link
      * Screen1-Pb-6 Link To
              WHEN Key-Status = 103
                 PERFORM Screen1-Pb-6-Link
      * Screen1-Pb-7 Link To
              WHEN Key-Status = 104
                 PERFORM Screen1-Pb-7-Link
      * Screen1-Pb-8 Link To
              WHEN Key-Status = 105
                 PERFORM Screen1-Pb-8-Link
           END-EVALUATE
      * avoid changing focus
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
      ***   start event editor code   ***
      *
       Screen1-Pb-2-Link.
      *Here is the actual movement of the progress bar
      *which is done by modifying its value.  I am 
      *performing it in a separate thread so that the 
      *"Stop" push-button will work.  You should do 
      *this to allow the user to change their mind and 
      *stop the process mid-stream

      *I have also included, for comparison's sake,
      *AcuCOBOL-GT's standard method for making
      *a progress bar, which is a frame with 2 fill colors and 
      *a changable fill-percent. 

           perform thread handle in thread1-handle
               perform varying int from 1 by 1 until int > 100
               modify Screen1-PB-1, Value int
               modify Screen1-Fr-1, FILL-PERCENT int
               call "c$sleep" using ".1"      
           end-perform.
           CALL "C$SYSTEM" 
               USING CMD-LINE
               193
               GIVING EXIT-STATUS.
      *
       Screen1-Pb-3-Link.
      *Get the value of the progress bar
           inquire Screen1-PB-1, value ef-val
      *Get the value of the frame
           inquire Screen1-Fr-1, FILL-PERCENT in frame-value
      *report the value to the screen
           if ef-val < 100
      *Display the percent completed of the progress bar:
               modify Screen1-La-1, visible = 1
               modify Screen1-La-2, VISIBLE = 1
               modify Screen1-Ef-1, VISIBLE = 1
      *and the frame
               modify Screen1-La-1a, VISIBLE = 1
               modify Screen1-La-2a, VISIBLE = 1
               modify Screen1-Ef-1a, VISIBLE = 1
               display Screen1
           end-if.
      *destroy the thread handle to stop the read
           destroy thread1-handle
           
           .
      *
       Screen1-Pb-5-Link.
      *Set the orientation to vertical
           modify Screen1-PB-1, Orientation = 1
                                LINES 30.3
                                size 3                                        

           
           .
      *
       Screen1-Pb-6-Link.
      *Set the orientation to horizontal
           modify Screen1-PB-1, Orientation = 0
                                LINES 3
                                size 30.3              
           .
      *
       Screen1-Pb-7-Link.
      *I made this push-button dynamic, so we need to
      *find out what the scrolling style is, then
      *toggle it to the other
           inquire Screen1-PB-1, Scrolling in scroll-state
           if scroll-state = 0
               modify Screen1-PB-1, Scrolling = 1
               modify Screen1-Pb-7, TITLE = "Change &Style to bar"
           else 
               modify Screen1-PB-1, Scrolling = 0
               modify Screen1-Pb-7, TITLE = "Change &Style to smooth"
           end-if.
           
           .
      *
       Screen1-Pb-8-Link.
      *You cannot change the fill-color of the frame,
      *just the background color
           modify Screen1-Fr-1, fill-color2 = 3
           display Screen1
           
           .

       

       REPORT-COMPOSER SECTION.

