      *{Bench}prg-comment
      * Program1.cbl
      * Program1.cbl is generated from C:\etc\acu-to-web-e2e-resources\more-apps\tab-control\Program1.Psf
      *{Bench}end
       IDENTIFICATION              DIVISION.
      *{Bench}prgid
       PROGRAM-ID. Program1.
       AUTHOR. ranitg.
       DATE-WRITTEN. Monday, 25 April 2022 15:53:00.
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
       77 Screen1-Ta-1-Value           PIC  S9(1)
                  VALUE IS 1.
       77 Screen1-Pg-1-Visible         PIC  9
                  VALUE IS 0.
       77 Screen1-Pg-2-Visible         PIC  9
                  VALUE IS 0.
       77 Screen1-Pg-3-Visible         PIC  9
                  VALUE IS 0.
       77 Screen1-Pg-4-Visible         PIC  9
                  VALUE IS 0.

       01 addJSVal       SIGNED-LONG.
	   
	   
      *{Bench}end
       LINKAGE                     SECTION.
      *{Bench}linkage
      *{Bench}end
       SCREEN                      SECTION.
      *{Bench}copy-screen
       01 Screen1.
	       03 atwScript, ATW-Script.
           03 Screen1-Ta-1, Tab-Control, 
              COL 18.20, LINE 2.30, LINES 58.20 CELLS, 
              SIZE 66.10 CELLS, 
              ID IS 1, BOTTOM, VALUE Screen1-Ta-1-Value, ATW-CSS-ID 
              "tab1".
           03 Screen1-Pg-1, VISIBLE Screen1-Pg-1-Visible.
              05 Screen1-Pb-1, Push-Button, 
                 COL 31.00, LINE 5.00, LINES 9.00 CELLS, 
                 SIZE 15.70 CELLS, 
                 ID IS 2, 
                 TITLE "Push Button 1", ATW-CSS-ID "button1", 
                 EVENT PROCEDURE button1-Event-Proc.
           03 Screen1-Pg-2, VISIBLE Screen1-Pg-2-Visible.
              05 Screen1-Pb-2, Push-Button, 
                 COL 40.70, LINE 15.90, LINES 9.70 CELLS, 
                 SIZE 19.20 CELLS, 
                 ID IS 3, 
                 TITLE "Push Button 2", ATW-CSS-ID "button2",
				 EVENT PROCEDURE button2-Event-Proc.
           03 Screen1-Pg-3, VISIBLE Screen1-Pg-3-Visible.
              05 Screen1-Pb-3, Push-Button, 
                 COL 41.00, LINE 20.00, LINES 14.40 CELLS, 
                 SIZE 22.20 CELLS, 
                 ID IS 4, 
                 TITLE "Push Button 3", ATW-CSS-ID "button3",
				 EVENT PROCEDURE button3-Event-Proc.
           03 Screen1-Pg-4, VISIBLE Screen1-Pg-4-Visible.
              05 Screen1-Pb-4, Push-Button, 
                 COL 41.30, LINE 21.50, LINES 13.50 CELLS, 
                 SIZE 19.90 CELLS, 
                 ID IS 5, 
                 TITLE "Push Button 4", ATW-CSS-ID "button4",
				 EVENT PROCEDURE button4-Event-Proc.

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
           MOVE 1 TO Screen1-Pg-1-Visible
      * display screen
              DISPLAY Standard GRAPHICAL WINDOW
                 LINES 60.70, SIZE 85.50, CELL HEIGHT 10, 
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
           MODIFY Screen1-Ta-1, TAB-TO-ADD = ("Agreement Details", 
              "Applicant Details", "Applicant Map", 
              "Applicant Work Details")
           MODIFY Screen1-Ta-1, VALUE = 1
		   modify atwScript add("myscript-tab", 
		      "[SRC]:resources/tab.js")
		      giving addJSVal
		   
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
           IF Event-Control-Id = 1 AND Event-Type = Cmd-Tabchanged
              PERFORM Acu-Screen1-Ta-1-Cmd-Tabchanged
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

       Acu-Screen1-Ta-1-Cmd-Tabchanged.
           EVALUATE Event-Type
           WHEN Cmd-Tabchanged
              MOVE Event-Data-1 TO Screen1-Ta-1-Value
              MOVE 0 TO Screen1-Pg-1-Visible, Screen1-Pg-2-Visible,
                  Screen1-Pg-3-Visible, Screen1-Pg-4-Visible
              EVALUATE Event-Data-1
              WHEN 1
                 MOVE 1 TO Screen1-Pg-1-Visible
              WHEN 2
                 MOVE 1 TO Screen1-Pg-2-Visible
              WHEN 3
                 MOVE 1 TO Screen1-Pg-3-Visible
              WHEN 4
                 MOVE 1 TO Screen1-Pg-4-Visible
              END-EVALUATE
      *       Before-Tabchg-Display
              DISPLAY Screen1
      *       After-Tabchg-Display
           END-EVALUATE
           .

       Screen1-Event-Proc.
      * 
           PERFORM Acu-Screen1-Event-Extra
           .

       button1-Event-Proc.
      * 
           EVALUATE Event-Type
           WHEN Cmd-Clicked
              PERFORM button1-Routine
           END-EVALUATE
           .
	
       button2-Event-Proc.
      * 
           EVALUATE Event-Type
           WHEN Cmd-Clicked
              PERFORM button2-Routine
           END-EVALUATE
           .
		   
       button3-Event-Proc.
      * 
           EVALUATE Event-Type
           WHEN Cmd-Clicked
              PERFORM button3-Routine
           END-EVALUATE
           .
	
       button4-Event-Proc.
      * 
           EVALUATE Event-Type
           WHEN Cmd-Clicked
              PERFORM button4-Routine
           END-EVALUATE
           .
      ***   start event editor code   ***

       button1-Routine.
	       modify atwscript call("completeTab", 1)
		   modify atwscript call("startTab", 2)
	       .
		   
       button2-Routine.
	       modify atwscript call("completeTab", 2)
		   modify atwscript call("startTab", 3)
	       .
		   
       button3-Routine.
	       modify atwscript call("completeTab", 3)
		   modify atwscript call("startTab", 4)
	       .
		   
       button4-Routine.
	       modify atwscript call("completeTab", 4)
		   display message box "Form complete!"
	       .


      *{Bench}end
       REPORT-COMPOSER SECTION.
