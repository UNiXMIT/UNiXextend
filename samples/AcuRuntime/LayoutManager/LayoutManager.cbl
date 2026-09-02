      *{Bench}prg-comment
      * LayoutManager.cbl
      * LayoutManager.cbl is generated from C:\AcuSamples\layoutmgr\layoutmgr\LayoutManager.Psf
      *{Bench}end
       IDENTIFICATION              DIVISION.
      *{Bench}prgid
       PROGRAM-ID. LayoutManager.
       AUTHOR. Administrator.
       DATE-WRITTEN. 6 September, 2024 11:44:16 AM.
       REMARKS. 
           This program demonstrates various Layout Manager flags.  
           The layout manager facility and the resize layout manager are 
           described in detail in section 4.8, "Layout Managers," 
           of Book 2, ACUCOBOL-GT User Interface Programming. 
      *{Bench}end
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       SPECIAL-NAMES.
      *{Bench}activex-def
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
      
       COPY "lmresize.def".

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
       77 Screen1-Ef-1-Value           PIC  X(30).
       77 ws-ef-1          PIC  x.
       77 Screen1-Wb-1-Value           PIC  X(80)
                  VALUE IS "www.acucorp.com".
       77 Screen1-Ef-2-Value           PIC  X(30).
       01 ef-1-line        PIC  999
                  VALUE IS 3.
       01 ef-1-col         PIC  999
                  VALUE IS 4.
       01 ef-1-lines       PIC  999
                  VALUE IS 2.
       01 ef-1-size        PIC  999
                  VALUE IS 10.
       01 scr-lines        PIC  999
                  VALUE IS 40.
       01 scr-size         PIC  999
                  VALUE IS 53.
       01 Screen1-Gd-1-Record.
           05 Gd-1-Col-1       PIC  X(08).
           05 Gd-1-Col-2       PIC  X(08).
           05 Gd-1-Col-3       PIC  X(08).
           05 Gd-1-Col-4       PIC  X(08).
           05 Gd-1-Col-5       PIC  X(08).
           05 Gd-1-Col-6       PIC  X(08).
           05 Gd-1-Col-7       PIC  X(08).
           05 Gd-1-Col-8       PIC  X(08).
           05 Gd-1-Col-9       PIC  X(08).
           05 Gd-1-Col-10      PIC  X(08).
           05 Gd-1-Col-11      PIC  X(08).
           05 Gd-1-Col-12      PIC  X(08).
           05 Gd-1-Col-13      PIC  X(08).
           05 Gd-1-Col-14      PIC  X(08).
           05 Gd-1-Col-15      PIC  X(08).
           05 gd-1-line        PIC  9(3)
                      VALUE IS 26.
           05 gd-1-col         PIC  9(3)
                      VALUE IS 4.
           05 gd-1-lines       PIC  9(3)
                      VALUE IS 10.
           05 gd-1-size        PIC  9(3)
                      VALUE IS 10.
       77 Screen2-Handle
                  USAGE IS HANDLE OF WINDOW VALUE NULL.
       77 Screen2-Ef-1-Value           PIC  X(30).
       77 Small-Font
                  USAGE IS HANDLE OF FONT SMALL-FONT.
       78 newline VALUE IS h"0A". 
       01 ctr-x            PIC  99
                  VALUE IS 1.

      *{Bench}end
       LINKAGE                     SECTION.
      *{Bench}linkage
      *{Bench}end
       SCREEN                      SECTION.
      *{Bench}copy-screen
       01 Screen1.
           03 Screen1-Pb-2, Push-Button, 
              COL 25.00, LINE 4.50, LINES 2.50 CELLS, SIZE 8.00 CELLS, 
              EXCEPTION-VALUE 101, FONT IS Small-Font, ID IS 4, 
              TITLE "resize-x", 
              layout-data = rlm-move-both-any.
           03 Screen1-Pb-2a, Push-Button, 
              COL 34.00, LINE 4.50, LINES 2.50 CELLS, SIZE 8.00 CELLS, 
              EXCEPTION-VALUE 102, FONT IS Small-Font, ID IS 3, 
              TITLE "resize-y", 
              layout-data = rlm-move-both-any.
           03 Screen1-Pb-10, Push-Button, 
              COL 43.00, LINE 4.50, LINES 2.50 CELLS, SIZE 8.00 CELLS, 
              EXCEPTION-VALUE 111, FONT IS Small-Font, ID IS 14, 
              TITLE "resize-both", 
              layout-data = rlm-move-both-any.
           03 Screen1-Pb-2aa, Push-Button, 
              COL 25.00, LINE 8.50, LINES 2.50 CELLS, SIZE 8.00 CELLS, 
              EXCEPTION-VALUE 103, FONT IS Small-Font, ID IS 5, 
              TITLE "move-x", 
              layout-data = rlm-move-both-any.
           03 Screen1-Pb-2aaa, Push-Button, 
              COL 34.00, LINE 8.50, LINES 2.50 CELLS, SIZE 8.00 CELLS, 
              EXCEPTION-VALUE 104, FONT IS Small-Font, ID IS 6, 
              TITLE "move-y", 
              layout-data = rlm-move-both-any.
           03 Screen1-Pb-12, Push-Button, 
              COL 43.00, LINE 8.50, LINES 2.50 CELLS, SIZE 8.00 CELLS, 
              EXCEPTION-VALUE 113, FONT IS Small-Font, ID IS 16, 
              TITLE "move-both", 
              layout-data = rlm-move-both-any.
           03 Screen1-Pb-6, Push-Button, 
              COL 25.00, LINE 13.50, LINES 2.50 CELLS, SIZE 8.00 CELLS, 
              EXCEPTION-VALUE 107, FONT IS Small-Font, ID IS 10, 
              TITLE "resize-x-any", 
              layout-data = rlm-move-both-any.
           03 Screen1-Pb-7, Push-Button, 
              COL 34.00, LINE 13.40, LINES 2.50 CELLS, SIZE 8.00 CELLS, 
              EXCEPTION-VALUE 108, FONT IS Small-Font, ID IS 11, 
              TITLE "resize-y-any", 
              layout-data = rlm-move-both-any.
           03 Screen1-Pb-11, Push-Button, 
              COL 43.00, LINE 13.50, LINES 2.50 CELLS, SIZE 8.00 CELLS, 
              EXCEPTION-VALUE 112, FONT IS Small-Font, ID IS 15, 
              TITLE "resize-both-any", 
              layout-data = rlm-move-both-any.
           03 Screen1-Pb-8, Push-Button, 
              COL 25.00, LINE 17.50, LINES 2.50 CELLS, SIZE 8.00 CELLS, 
              EXCEPTION-VALUE 109, FONT IS Small-Font, ID IS 12, 
              TITLE "move-x-any", 
              layout-data = rlm-move-both-any.
           03 Screen1-Pb-9, Push-Button, 
              COL 34.00, LINE 17.40, LINES 2.50 CELLS, SIZE 8.00 CELLS, 
              EXCEPTION-VALUE 110, FONT IS Small-Font, ID IS 13, 
              TITLE "move-y-any", 
              layout-data = rlm-move-both-any.
           03 Screen1-Pb-13, Push-Button, 
              COL 43.00, LINE 17.40, LINES 2.50 CELLS, SIZE 8.00 CELLS, 
              EXCEPTION-VALUE 114, FONT IS Small-Font, ID IS 17, 
              TITLE "move-both-any", 
              layout-data = rlm-move-both-any.
           03 Screen1-Pb-17, Push-Button, 
              COL 25.00, LINE 25.00, LINES 2.00 CELLS, SIZE 9.00 CELLS, 
              EXCEPTION-VALUE 121, FONT IS Small-Font, ID IS 24, 
              TITLE "Clear max-width", VISIBLE 0, 
              layout-data = rlm-move-both-any.
           03 Screen1-Pb-16, Push-Button, 
              COL 25.00, LINE 25.00, LINES 2.00 CELLS, SIZE 9.00 CELLS, 
              EXCEPTION-VALUE 120, FONT IS Small-Font, ID IS 23, 
              TITLE "Set max-width", 
              layout-data = rlm-move-both-any.
           03 Screen1-Pb-14, Push-Button, 
              COL 25.00, LINE 28.00, LINES 2.00 CELLS, SIZE 9.00 CELLS, 
              EXCEPTION-VALUE 117, FONT IS Small-Font, ID IS 21, 
              TITLE "Set max-height", 
              layout-data = rlm-move-both-any.
           03 Screen1-Pb-15, Push-Button, 
              COL 25.00, LINE 27.90, LINES 2.00 CELLS, SIZE 9.00 CELLS, 
              EXCEPTION-VALUE 118, FONT IS Small-Font, ID IS 22, 
              TITLE "Clear max-height", VISIBLE 0, 
              layout-data = rlm-move-both-any.
           03 Screen1-Pb-3, Push-Button, 
              COL 25.00, LINE 31.90, LINES 3.00 CELLS, SIZE 9.00 CELLS, 
              EXCEPTION-VALUE 100, FONT IS Small-Font, ID IS 7, 
              TITLE "&Reset window", 
              layout-data = rlm-move-both-any.
           03 Screen1-Pb-1, Push-Button, 
              COL 42.00, LINE 35.00, LINES 3.00 CELLS, SIZE 9.00 CELLS, 
              FONT IS Small-Font, ID IS 2, CANCEL-BUTTON, 
              TITLE "E&xit ", 
              layout-data = rlm-move-both-any.
           03 Screen1-Gd-1, Grid, 
              COL gd-1-col, LINE gd-1-line, LINES gd-1-lines CELLS, 
              SIZE gd-1-size CELLS, 
              3-D, 
              DATA-COLUMNS (1, 9, 17, 25, 33, 41, 49, 57, 65, 73, 81,
              89, 97, 105, 113), 
              DISPLAY-COLUMNS (1, 5, 13, 21, 29, 37, 45, 53, 61, 69, 77,
              85, 93, 101, 109), 
              SEPARATION (5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5), 
              CURSOR-FRAME-WIDTH 3, DIVIDER-COLOR 1, DRAG-COLOR 1, 
              HEADING-COLOR 257, HEADING-DIVIDER-COLOR 1, ID IS 18, 
              NUM-ROWS 20, RECORD-DATA Screen1-Gd-1-Record, 
              TILED-HEADINGS, VPADDING 50, 
              EVENT PROCEDURE Screen1-Gd-1-Event-Proc.
           03 Screen1-Br-1b, Bar, 
              COL 25.00, LINE 12.00, SIZE 26.00 CELLS, 
              ID IS 26, WIDTH 1, 
              layout-data = rlm-move-both-any.
           03 Screen1-Fr-1, Frame, 
              COL 24.00, LINE 3.00, LINES 18.00 CELLS, 
              SIZE 28.00 CELLS, 
              ENGRAVED, ID IS 8, 
              TITLE "Layout-data values", BACKGROUND-LOW, 
              layout-data = rlm-move-both-any.
           03 Screen1-Fr-2, Frame, 
              COL 24.00, LINE 23.00, LINES 13.00 CELLS, 
              SIZE 11.00 CELLS, 
              ENGRAVED, ID IS 9, 
              TITLE "Window settings", BACKGROUND-LOW, 
              layout-data = rlm-move-both-any.
           03 Screen1-Br-1, Bar, 
              COL 25.00, LINE 30.90, SIZE 9.00 CELLS, 
              ID IS 19, WIDTH 1, 
              layout-data = rlm-move-both-any.
           03 Screen1-Pb-4, Push-Button, 
              COL 25.00, LINE 37.00, LINES 1.50 CELLS, SIZE 9.00 CELLS, 
              EXCEPTION-VALUE 200, FONT IS Small-Font, ID IS 20, 
              TITLE "Do not push", VISIBLE 0, 
              layout-data = rlm-move-both-any.
           03 Screen1-Ef-1, Entry-Field, 
              COL 4.00, LINE ef-1-line, LINES ef-1-lines CELLS, 
              SIZE ef-1-size CELLS, 
              3-D, ID IS 1, VALUE Screen1-Ef-1-Value.

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
                 LINES scr-lines, SIZE scr-size, CELL HEIGHT 10, 
                 CELL WIDTH 10, AUTO-MINIMIZE, COLOR IS 65793, 
                 CONTROLS-UNCROPPED, LABEL-OFFSET 0, LINK TO THREAD, 
                 MODELESS, RESIZABLE, NO SCROLL, WITH SYSTEM MENU, 
                 TITLE "Layout Manager Demo", TITLE-BAR, NO WRAP, 
                 layout-manager = lm-resize, 
                 EVENT PROCEDURE Screen1-Event-Proc, 
                 HANDLE IS Screen1-Handle
      * toolbar
           DISPLAY Screen1 UPON Screen1-Handle
      *    After-Create
           .

       Acu-Screen1-Init-Data.
      *    Before-Initdata
           PERFORM Acu-Screen1-Gd-1-Content
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

      * Screen1-Gd-1
       Acu-Screen1-Gd-1-Content.
      * Columns' Setting
           MODIFY Screen1-Gd-1, X = 1, X = 1, COLUMN-FONT = Small-Font, 
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
              WHEN Key-Status = 101
                 PERFORM Screen1-Pb-2-Link
      * Screen1-Pb-2a Link To
              WHEN Key-Status = 102
                 PERFORM Screen1-Pb-2a-Link
      * Screen1-Pb-10 Link To
              WHEN Key-Status = 111
                 PERFORM Screen1-Pb-10-Link
      * Screen1-Pb-2aa Link To
              WHEN Key-Status = 103
                 PERFORM Screen1-Pb-2aa-Link
      * Screen1-Pb-2aaa Link To
              WHEN Key-Status = 104
                 PERFORM Screen1-Pb-2aaa-Link
      * Screen1-Pb-12 Link To
              WHEN Key-Status = 113
                 PERFORM Screen1-Pb-12-Link
      * Screen1-Pb-6 Link To
              WHEN Key-Status = 107
                 PERFORM Screen1-Pb-6-Link
      * Screen1-Pb-7 Link To
              WHEN Key-Status = 108
                 PERFORM Screen1-Pb-7-Link
      * Screen1-Pb-11 Link To
              WHEN Key-Status = 112
                 PERFORM Screen1-Pb-11-Link
      * Screen1-Pb-8 Link To
              WHEN Key-Status = 109
                 PERFORM Screen1-Pb-8-Link
      * Screen1-Pb-9 Link To
              WHEN Key-Status = 110
                 PERFORM Screen1-Pb-9-Link
      * Screen1-Pb-13 Link To
              WHEN Key-Status = 114
                 PERFORM Screen1-Pb-13-Link
      * Screen1-Pb-17 Link To
              WHEN Key-Status = 121
                 PERFORM Screen1-Pb-17-Link
      * Screen1-Pb-16 Link To
              WHEN Key-Status = 120
                 PERFORM Screen1-Pb-16-Link
      * Screen1-Pb-14 Link To
              WHEN Key-Status = 117
                 PERFORM Screen1-Pb-14-Link
      * Screen1-Pb-15 Link To
              WHEN Key-Status = 118
                 PERFORM Screen1-Pb-15-Link
      * Screen1-Pb-3 Link To
              WHEN Key-Status = 100
                 PERFORM Screen1-Pb-3-Link
      * Screen1-Pb-4 Link To
              WHEN Key-Status = 200
                 PERFORM Screen1-Pb-4-Link
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

       Screen1-Gd-1-Event-Proc.
           .
      ***   start event editor code   ***
       reset-ef-1.
           modify Screen1-Ef-1, layout-data = 0 value = " "
           line  ef-1-line  col  ef-1-col
           lines ef-1-lines size ef-1-size
           modify Screen1-Gd-1,  layout-data = 0 value = " "
           line  gd-1-line  col  gd-1-col
           lines gd-1-lines size gd-1-size
           perform Screen1-Pb-15-Link
           perform Screen1-Pb-17-Link
          
           .
      *
       Screen1-Pb-3-Link.
           perform reset-ef-1
           modify Screen1-Handle, LINES scr-lines
           modify Screen1-Handle, SIZE  scr-size
           add 1 to ctr-x
           if ctr-x = 10
             modify Screen1-Pb-4, visible = true
             move 0 to ctr-x
           else
             modify Screen1-Pb-4, VISIBLE = false
                                  title = "Do Not Push"
           end-if
           .
      *
       Screen1-Pb-2-Link.
           perform reset-ef-1
           modify Screen1-Ef-1, layout-data = rlm-resize-x
           value "rlm-resize-x"
           modify Screen1-Gd-1, layout-data = rlm-resize-x
           .
      *
       Screen1-Pb-2a-Link.
           perform reset-ef-1
           modify Screen1-Ef-1, layout-data = rlm-resize-y
           value "rlm-resize-y"
           modify Screen1-Gd-1, layout-data = rlm-resize-y
           .
      *
       Screen1-Pb-2aa-Link.
           perform reset-ef-1
           modify Screen1-Ef-1, layout-data = rlm-move-x
           value "move-x"  
           modify Screen1-Gd-1, layout-data = rlm-move-x
           .
      *
       Screen1-Pb-2aaa-Link.
           perform reset-ef-1
           modify Screen1-Ef-1, layout-data = rlm-move-y
           value "move-y"
           modify Screen1-Gd-1, layout-data = rlm-move-y
     
           .

      *
       Screen1-Pb-6-Link.
           perform reset-ef-1
           modify Screen1-Ef-1, layout-data = rlm-resize-x-any
           value "resize-x-any"
           modify Screen1-Gd-1, layout-data = rlm-resize-x-any
           .
      *
       Screen1-Pb-7-Link.
           perform reset-ef-1
           modify Screen1-Ef-1, layout-data = rlm-resize-y-any
           value "resize-y-any"
           modify Screen1-Gd-1, layout-data = rlm-resize-y-any
           
           .
      *
       Screen1-Pb-8-Link.
           perform reset-ef-1
           modify Screen1-Ef-1, layout-data = rlm-move-x-any
           value "move-x-any" 
           modify Screen1-Gd-1, layout-data = rlm-move-x-any
           
           .
      *
       Screen1-Pb-9-Link.
           perform reset-ef-1
           modify Screen1-Ef-1, layout-data = rlm-move-y-any
           value "move-y-any" 
           modify Screen1-Gd-1, layout-data = rlm-move-y-any
           .
      *
       Screen1-Pb-10-Link.
           perform reset-ef-1
           modify Screen1-Ef-1, layout-data = rlm-resize-both
           value "resize-both" 
           modify Screen1-Gd-1, layout-data = rlm-resize-both
           
           .
      *
       Screen1-Pb-11-Link.
           perform reset-ef-1
           modify Screen1-Ef-1, layout-data = rlm-resize-both-any
           value "resize-both-any" 
           modify Screen1-Gd-1, layout-data = rlm-resize-both-any
           .
      *
       Screen1-Pb-12-Link.
           perform reset-ef-1
           modify Screen1-Ef-1, layout-data = rlm-move-both
           value "move-both"
           modify Screen1-Gd-1, layout-data = rlm-move-both
           
           .
      *
       Screen1-Pb-13-Link.
           perform reset-ef-1
           modify Screen1-Ef-1, layout-data = rlm-move-both-any
           value "move-both-any"
           modify Screen1-Gd-1, layout-data = rlm-move-both-any
           
           .
      *
      *
       Screen1-Pb-14-Link.
           
           modify Screen1-Ef-1, max-height = 10
           modify Screen1-Gd-1, max-height = 15
           modify Screen1-Pb-14, visible = false
           modify Screen1-Pb-15, VISIBLE = true
           perform check-layout-data-value.
           .
      *
       Screen1-Pb-15-Link.
           
           modify Screen1-Ef-1, max-height = " "
           modify Screen1-Gd-1, max-height = " "
           modify Screen1-Pb-14, visible = true
           modify Screen1-Pb-15, VISIBLE = false
           .
      *
       Screen1-Pb-16-Link.
           
           modify Screen1-Ef-1, max-width = 20
           modify Screen1-Gd-1, max-width = 25
           modify Screen1-Pb-16, visible = false
           modify Screen1-Pb-17, VISIBLE = true
           perform check-layout-data-value.

           
           .
      *
       Screen1-Pb-17-Link.
           
           modify Screen1-Ef-1, max-width = " "
           modify Screen1-Gd-1, max-width = " "
           modify Screen1-Pb-16, visible = true
           modify Screen1-Pb-17, VISIBLE = false

           .

       check-layout-data-value.
           inquire Screen1-Ef-1, VALUE in screen1-ef-1-value
           move screen1-ef-1-value(1:1) TO ws-ef-1
           evaluate ws-ef-1
             when spaces
               display message box 
                "Please select a"   newline
                "Layout-data value"
                icon mb-warning-icon
               perform Screen1-Pb-15-Link
               perform Screen1-Pb-17-Link
             when "m"
               display message box
                "Resize operations only." newline
                "Not valid for moves"
                icon mb-warning-icon
               perform Screen1-Pb-15-Link
               perform Screen1-Pb-17-Link
             when "x"
               modify Screen1-Pb-4, VISIBLE = true
           end-evaluate                                                             

      *     end-if                                                
           .
      *
       Screen1-Pb-4-Link.
      *     move "resize-both-any on ALL controls" to screen1-ef-1-value
           modify Screen1-Ef-1,   layout-data = rlm-resize-both-any
           modify Screen1-Pb-1, layout-data = rlm-resize-both-any
           modify Screen1-Pb-2, layout-data = rlm-resize-both-any
                  Screen1-Pb-2a, layout-data = rlm-resize-both-any
                  Screen1-Pb-2aa, layout-data = rlm-resize-both-any
           modify Screen1-Pb-2aaa, layout-data = rlm-resize-both-any
           modify Screen1-Pb-3, layout-data = rlm-resize-both-any
           modify Screen1-Pb-6, layout-data = rlm-resize-both-any
           modify Screen1-Pb-7, layout-data = rlm-resize-both-any
           modify Screen1-Pb-8, layout-data = rlm-resize-both-any
           modify Screen1-Pb-9, layout-data = rlm-resize-both-any
           modify Screen1-Pb-10, layout-data = rlm-resize-both-any
           modify Screen1-Pb-11, layout-data = rlm-resize-both-any
           modify Screen1-Pb-12, layout-data = rlm-resize-both-any
           modify Screen1-Pb-13, layout-data = rlm-resize-both-any
           modify Screen1-Gd-1,  layout-data = rlm-resize-both-any
           modify Screen1-Pb-14, layout-data = rlm-resize-both-any
           modify Screen1-Pb-15, layout-data = rlm-resize-both-any
           modify Screen1-Pb-16, layout-data = rlm-resize-both-any
           modify Screen1-Pb-17, layout-data = rlm-resize-both-any
           modify Screen1-Br-1b, layout-data = rlm-resize-both-any
           modify Screen1-Fr-1, layout-data = rlm-resize-both-any
           modify Screen1-Fr-2, layout-data = rlm-resize-both-any
           modify Screen1-Br-1, layout-data = rlm-resize-both-any
           modify Screen1-Pb-4, layout-data = rlm-resize-both-any
           modify Screen1-Handle, action action-maximize
           modify Screen1-Pb-4, TITLE "I Told you not to push"
           modify Screen1-Pb-4, cancel-button
           .

       

      *{Bench}end
       REPORT-COMPOSER SECTION.
