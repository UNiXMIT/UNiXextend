      *{Bench}prg-comment
      * Scrollbar.cbl
      * Scrollbar.cbl is generated from C:\AcuSamples\scrollbar\Scrollbar.Psf
      *{Bench}end
       IDENTIFICATION              DIVISION.
      *{Bench}prgid
       PROGRAM-ID. Scrollbar.
       AUTHOR. CContardi.
       DATE-WRITTEN. mercoledì 29 settembre 2010 12.07.09.
       REMARKS. 
           This program demonstrates logic used by the scroll-bar control
           to navigate in a list-box.
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
      * property-defined variable

      * user-defined variable
       01 key-entered IS SPECIAL-NAMES CRT STATUS  PIC  9(3)
                  VALUE IS zeroes.
       01 exception-values.
           05 quit PIC  9(3).
       78 ws-max-lines VALUE IS 13. 
       78 scroll-line VALUE IS 14,25. 
       78 ws-window-lines VALUE IS 16,5. 
       78 ws-button-lines VALUE IS 15,5. 
       78 ws-max-line-length VALUE IS 132. 
       78 ws-col-start VALUE IS 7. 
       77 ws-win-size      PIC  9(5)
                  VALUE IS 00060.
       77 ws-size          PIC  9(3).
       77 ws-scroll-value  PIC  9(5)
                  VALUE IS 0001.
       77 ws-sub           PIC  9(3).
       77 ws-string        PIC  x(ws-max-line-length).
       01 data-table
                  OCCURS WS-MAX-LINES TIMES.
           05 table-item       PIC  x(ws-max-line-length)
                      VALUE IS all "123456789 ".
       01 ws-rd-line
                  OCCURS WS-MAX-LINES TIMES.
           05 FILLER           PIC  x(ws-max-line-length).
       77 Form1-Handle
                  USAGE IS HANDLE OF WINDOW.
       01 .
           03 Form1-Lb-1-Container-Item.
               05      PIC  X(30).
           78 Form1-Lb-1-Container-Num VALUE IS 1. 
           03 Form1-Lb-1-Container REDEFINES Form1-Lb-1-Container-Item  
           PIC  X(30)
                      OCCURS 1 TIMES
                      INDEXED  Form1-Lb-1-Container-Idx.
       77 Form1-Lb-1-Value PIC  X(30).
       77 Medium-Font
                  USAGE IS HANDLE OF FONT MEDIUM-FONT.
       77 EVENT-DATA-2     PIC  X(30).
       77 EVENTO-DATA-2    PIC  X(30).
       77 EVENTO-TYPE      PIC  X(30).
       77 Form1-Sb-2-Value PIC  S9(2)
                  VALUE IS 5.
       77 ws-line          PIC  9(3)v99.
       77 ws-line-comodo   PIC  9(3)v99.

      *{Bench}end
       LINKAGE                     SECTION.
      *{Bench}linkage
      *{Bench}end
       SCREEN                      SECTION.
      *{Bench}copy-screen
       01 Form1, 
           BEFORE PROCEDURE Reload-Listbox.
           03 Form1-Sb-1, Scroll-Bar, 
              COL 4,00, LINE 27,00, LINES 2,00 CELLS, SIZE 20,00 CELLS, 
              ID IS 1, HORIZONTAL, MAX-VAL IS 100, MIN-VAL IS 0, 
              PAGE-SIZE IS 0, TRACK-THUMB, VALUE ws-scroll-value, 
              EVENT PROCEDURE Form1-Sb-1-Event-Proc.
           03 Form1-Ef-1, Entry-Field, 
              COL 26,90, LINE 10,30, LINES 2,00 CELLS, SIZE 6,00 CELLS, 
              3-D, ID IS 2, RIGHT, VALUE EVENTO-DATA-2.
           03 Form1-Lb-1, List-Box, 
              COL 4,50, LINE 4,00, LINES 20,50 CELLS, SIZE 8,00 CELLS, 
              3-D, ID IS 3, MASS-UPDATE 0, UNSORTED, 
              VALUE Form1-Lb-1-Value, 
              NO-SEARCH.
           03 Form1-Pb-1, Push-Button, 
              COL 38,20, LINE 29,80, LINES 2,50 CELLS, SIZE 7,00 CELLS, 
              ID IS 4, SELF-ACT, CANCEL-BUTTON, 
              TITLE "E&xit".
           03 Form1-La-1, Label, 
              COL 26,90, LINE 13,30, LINES 2,00 CELLS, 
              SIZE 10,00 CELLS, 
              FONT IS Medium-Font, ID IS 5, LABEL-OFFSET 0, 
              TITLE "campo data-2".
           03 Form1-Ef-2, Entry-Field, 
              COL 26,90, LINE 16,30, LINES 2,00 CELLS, SIZE 6,50 CELLS, 
              3-D, ID IS 6, RIGHT, VALUE EVENTO-TYPE.
           03 Form1-La-2, Label, 
              COL 26,90, LINE 19,30, LINES 1,50 CELLS, SIZE 8,50 CELLS, 
              ID IS 7, LABEL-OFFSET 0, 
              TITLE "EVENT TYPE".
           03 Form1-Sb-2, Scroll-Bar, 
              COL 39,30, LINE 3,00, LINES 22,70 CELLS, SIZE 2,10 CELLS, 
              ID IS 8, MAX-VAL IS 10, MIN-VAL IS 0, PAGE-SIZE IS 0, 
              TRACK-THUMB, VALUE Form1-Sb-2-Value, 
              EVENT PROCEDURE Form1-Sb-2-Event-Proc.

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
           PERFORM Acu-Form1-Routine
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

       Acu-Form1-Routine.
      *    Before-Routine
           PERFORM Acu-Form1-Scrn
           PERFORM Acu-Form1-Proc
      *    After-Routine
           .

       Acu-Form1-Scrn.
           PERFORM Acu-Form1-Create-Win
           PERFORM Acu-Form1-Init-Data
           .

       Acu-Form1-Create-Win.
      *    Before-Create
      * display screen
              DISPLAY Standard GRAPHICAL WINDOW
                 LINES 33,30, SIZE 46,20, CELL HEIGHT 10, 
                 CELL WIDTH 10, AUTO-MINIMIZE, AUTO-RESIZE, 
                 COLOR IS 65793, CONTROLS-UNCROPPED, ERASE, 
                 LABEL-OFFSET 0, LINK TO THREAD, MODELESS, NO SCROLL, 
                 WITH SYSTEM MENU, 
                 TITLE "Scroll-bar demo", TITLE-BAR, NO WRAP, 
                 EVENT PROCEDURE Form1-Event-Proc, 
                 HANDLE IS Form1-Handle
      * toolbar
           DISPLAY Form1 UPON Form1-Handle
      *    After-Create
           .

       Acu-Form1-Init-Data.
      *    Before-Initdata
           PERFORM Acu-Form1-Lb-1-Content
      *    After-Initdata
           .
      * Form1
       Acu-Form1-Proc.
           PERFORM UNTIL key-entered = 27
              ACCEPT Form1  
                 ON EXCEPTION PERFORM Acu-Form1-Evaluate-Func
              END-ACCEPT
           END-PERFORM
           DESTROY Form1-Handle
           INITIALIZE key-entered
           .

      * Form1-Lb-1
       Acu-Form1-Lb-1-Content.
           MODIFY Form1-Lb-1, MASS-UPDATE = 1, RESET-LIST = 1
           MODIFY Form1-Lb-1, ITEM-TO-ADD = TABLE Form1-Lb-1-Container
           MODIFY Form1-Lb-1, MASS-UPDATE = 0
           MODIFY Form1-Lb-1, VALUE Form1-Lb-1-Value
           .

      * Form1
       Acu-Form1-Evaluate-Func.
           EVALUATE TRUE
              WHEN key-entered = 27
                 PERFORM Acu-Form1-Exit
              WHEN key-entered = 96
                 IF Event-Type = Cmd-Close
                    PERFORM Acu-Form1-Exit
                 END-IF
           END-EVALUATE
           MOVE 1 TO Accept-Control
           . 

       Acu-Form1-Exit.
           MOVE 27 TO key-entered
           .


       Acu-Form1-Event-Extra.
           EVALUATE Event-Type
           WHEN Msg-Close
              PERFORM Acu-Form1-Msg-Close
           END-EVALUATE
           .

       Acu-Form1-Msg-Close.
           ACCEPT Quit-Mode-Flag FROM ENVIRONMENT "QUIT_MODE"
           IF Quit-Mode-Flag = ZERO
              PERFORM Acu-Form1-Exit
              PERFORM Acu-Exit-Rtn
           END-IF
           .

       Form1-Event-Proc.
      * 
           PERFORM Acu-Form1-Event-Extra
           .

       Form1-Sb-1-Event-Proc.
      * 
           EVALUATE Event-Type
           WHEN Msg-Sb-Next
              PERFORM Form1-Sb-1-Ev-Msg-Sb-Next
           WHEN Msg-Sb-Nextpage
              PERFORM Form1-Sb-1-Ev-Msg-Sb-Nextpage
           WHEN Msg-Sb-Prev
              PERFORM Form1-Sb-1-Ev-Msg-Sb-Prev
           WHEN Msg-Sb-Prevpage
              PERFORM Form1-Sb-1-Ev-Msg-Sb-Prevpage
           WHEN Msg-Sb-Thumbtrack
              PERFORM Form1-Sb-1-Ev-Msg-Sb-Thumbtrack
           END-EVALUATE
           .

       Form1-Sb-2-Event-Proc.
      * 
           EVALUATE Event-Type
           WHEN Msg-Sb-Next
              PERFORM Form1-Sb-2-Ev-Msg-Sb-Next
           WHEN Msg-Sb-Prev
              PERFORM Form1-Sb-2-Ev-Msg-Sb-Prev
           END-EVALUATE
           .
      ***   start event editor code   ***
      *
       Form1-Sb-1-Ev-Msg-Sb-Next.
           if ws-scroll-value <= ws-max-line-length - ws-size
                   add 1 to ws-scroll-value
           end-if
               perform redraw-sb-lb
           .
      *
       Form1-Sb-1-Ev-Msg-Sb-Prev.
           if ws-scroll-value > 1
                   subtract 1 from ws-scroll-value
           end-if
               perform redraw-sb-lb
           .
      *
       Form1-Sb-1-Ev-Msg-Sb-Nextpage.
           if ws-scroll-value + (ws-size * 2) 
                             < ws-max-line-length
                   add ws-size to ws-scroll-value
               else
                   compute ws-scroll-value = 
                   ws-max-line-length + 1 - ws-size 
           end-if
               perform redraw-sb-lb
           .
      *
       Form1-Sb-1-Ev-Msg-Sb-Prevpage.
           if ws-scroll-value - ws-size > 1
                  subtract ws-size from ws-scroll-value
           else
                   compute ws-scroll-value = 1
           end-if
               perform redraw-sb-lb
           .
      *
       Form1-Sb-1-Ev-Msg-Sb-Thumbtrack.
           if evento-data-2 > 0
                    move evento-data-2 to ws-scroll-value
           end-if
               perform redraw-sb-lb
           .
       redraw-sb-lb.
           modify Form1-Sb-1,    value = ws-scroll-value.
           perform reload-listbox.

       reload-listbox.
           compute ws-size = ws-window-lines - ws-col-start + 1
           
           if ws-size > ws-max-line-length
               move ws-max-line-length to ws-size
               modify Form1-Sb-1,  visible = false
           else
               modify Form1-Sb-1,  visible = true    
           end-if.     
           
           modify Form1-Lb-1, , reset-list 1 mass-update = 1.
           perform varying ws-sub from 1 by 1 
                   until ws-sub > ws-max-lines
               move table-item(ws-sub) to ws-string
               move ws-string(ws-scroll-value:ws-size) 
                    to ws-rd-line(ws-sub)
               modify Form1-Lb-1,  
                    item-to-add = ws-rd-line(ws-sub)
           end-perform.
           modify Form1-Lb-1,  mass-update = 0.
           display Form1. 
      *

            
           .
      *
       Form1-Sb-2-Ev-Msg-Sb-Next.  
        
           compute Form1-Sb-2-Value = Form1-Sb-2-Value + 1
           modify Form1-Sb-2, VALUE = Form1-Sb-2-Value

           inquire Form1-Ef-1, line in ws-line
           move ws-line to ws-line-comodo

           if ws-line-comodo > 5

              compute ws-line = ws-line - 1
              modify Form1-Ef-1, line ws-line
              inquire Form1-La-1, line in ws-line
              compute ws-line = ws-line - 1
              modify Form1-La-1, line ws-line
              inquire Form1-Ef-2, line in ws-line
              compute ws-line = ws-line - 1
              modify Form1-Ef-2, line ws-line
              inquire Form1-La-2, line in ws-line
              compute ws-line = ws-line - 1
              modify Form1-La-2, line ws-line

           end-if
           .
      *
       Form1-Sb-2-Ev-Msg-Sb-Prev. 

           compute Form1-Sb-2-Value = Form1-Sb-2-Value - 1 
           modify Form1-Sb-2, VALUE = Form1-Sb-2-Value  

           inquire Form1-Ef-1, line in ws-line  
           move ws-line to ws-line-comodo

           if ws-line-comodo < 15 

              compute ws-line = ws-line + 1
              modify Form1-Ef-1, line ws-line
              inquire Form1-La-1, line in ws-line
              compute ws-line = ws-line + 1
              modify Form1-La-1, line ws-line
              inquire Form1-Ef-2, line in ws-line
              compute ws-line = ws-line + 1
              modify Form1-Ef-2, line ws-line
              inquire Form1-La-2, line in ws-line
              compute ws-line = ws-line + 1
              modify Form1-La-2, line ws-line   

           end-if
           .
       

      *{Bench}end
       REPORT-COMPOSER SECTION.
