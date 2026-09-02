      *{Bench}prg-comment
      * GRID-Phys-vs-Logical-Columns.cbl
      * GRID-Phys-vs-Logical-Columns.cbl is generated from C:\AcuSamples\GRID\GRID-MoveAndHide-1040-ECN-4697\GRID-Phys-vs-Logical-Columns\GRID-Phys-vs-Logical-Columns.Psf
      *{Bench}end
       IDENTIFICATION              DIVISION.
      *{Bench}prgid
       PROGRAM-ID. GRID-Phys-vs-Logical-Columns.
       AUTHOR. support.
       DATE-WRITTEN. Thursday, September 23, 2021 5:11:37 PM.
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
      *
      *
       77 ws-counter       PIC  99
                  VALUE IS 0.
       77 ws-logical-col-from          PIC  9(3)
                  VALUE IS 0.
       77 ws-logical-col-to            PIC  9(3)
                  VALUE IS 0.
       77 ws-first-usable-col          PIC  9(3)
                  VALUE IS 1.
       78 max-cols VALUE IS 10. 
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
       01 Screen1-Physical-Table.
           03 Screen1-Physical-Table-Item
                      OCCURS MAX-COLS TO MAX-COLS TIMES DEPENDING ON 
           ws-counter .
               05 ws-phys-col      PIC  S9(3).

      *{Bench}end
       LINKAGE                     SECTION.
      *{Bench}linkage
      *{Bench}end
       SCREEN                      SECTION.
      *{Bench}copy-screen
       01 Screen1.
           03 Screen1-La-1, Label, 
              COL 3.80, LINE 2.30, LINES 1.30 CELLS, SIZE 19.40 CELLS, 
              ID IS 1, LABEL-OFFSET 0, 
              TITLE "Physical vs. Logical Grid Columns".
           03 Screen1-La-2, Label, 
              COL 3.80, LINE 6.10, LINES 1.30 CELLS, SIZE 30.10 CELLS, 
              ID IS 2, LABEL-OFFSET 0, 
              TITLE 
              "Use the mouse to move the columns of the first Grid.".
           03 Screen1-Gd-1, Grid, 
              COL 3.80, LINE 8.80, LINES 10.50 CELLS, SIZE 57.80 CELLS, 
              MOVEABLE-COLUMNS, 3-D, COLUMN-HEADINGS, 
              DATA-COLUMNS (1, 9, 17, 25, 33, 41, 49, 57, 65, 73), 
              DISPLAY-COLUMNS (1, 9, 17, 25, 33, 41, 49, 57, 65, 73), 
              SEPARATION (5, 5, 5, 5, 5, 5, 5, 5, 5, 5), 
              CURSOR-FRAME-WIDTH 3, DIVIDER-COLOR 1, DRAG-COLOR 1, 
              HEADING-COLOR 353, HEADING-DIVIDER-COLOR 1, ID IS 3, 
              NUM-COL-HEADINGS 1, NUM-ROWS 10, 
              RECORD-DATA Screen1-Gd-1-Record, TILED-HEADINGS, 
              VPADDING 50, VSCROLL, 
              EVENT PROCEDURE Screen1-Gd-1-Event-Proc.
           03 Screen1-La-2a, Label, 
              COL 3.80, LINE 22.90, LINES 1.30 CELLS, SIZE 32.40 CELLS, 
              ID IS 4, LABEL-OFFSET 0, 
              TITLE 
              "The columns in the second Grid will automatically follow.
      -       "".
           03 Screen1-Gd-2, Grid, 
              COL 3.80, LINE 25.10, LINES 10.50 CELLS, 
              SIZE 57.80 CELLS, 
              3-D, COLUMN-HEADINGS, 
              DATA-COLUMNS (1, 9, 17, 25, 33, 41, 49, 57, 65, 73), 
              DISPLAY-COLUMNS (1, 9, 17, 25, 33, 41, 49, 57, 65, 73), 
              SEPARATION (5, 5, 5, 5, 5, 5, 5, 5, 5, 5), 
              CURSOR-FRAME-WIDTH 3, DIVIDER-COLOR 1, DRAG-COLOR 1, 
              HEADING-COLOR 481, HEADING-DIVIDER-COLOR 1, ID IS 5, 
              NUM-COL-HEADINGS 1, NUM-ROWS 10, 
              RECORD-DATA Screen1-Gd-1-Record, TILED-HEADINGS, 
              VPADDING 50, VSCROLL, 
              EVENT PROCEDURE Screen1-Gd-1-Event-Proc.

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
                 LINES 43.00, SIZE 64.00, CELL HEIGHT 10, 
                 CELL WIDTH 10, AUTO-MINIMIZE, COLOR IS 65793, 
                 LABEL-OFFSET 0, LINK TO THREAD, MODELESS, NO SCROLL, 
                 WITH SYSTEM MENU, 
                 TITLE "Screen", TITLE-BAR, NO WRAP, 
                 EVENT PROCEDURE Screen1-Event-Proc, 
                 HANDLE IS Screen1-Handle
      * toolbar
           DISPLAY Screen1 UPON Screen1-Handle
           PERFORM Screen1-Aft-Create
           .

       Acu-Screen1-Init-Data.
      *    Before-Initdata
           PERFORM Acu-Screen1-Gd-1-Content
           PERFORM Acu-Screen1-Gd-2-Content
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
           .

      * Screen1-Gd-2
       Acu-Screen1-Gd-2-Content.
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

       Screen1-Gd-1-Event-Proc.
      * 
           EVALUATE Event-Type
           WHEN Msg-Column-Moved
              EVALUATE Event-Control-Id
              WHEN 3
                 PERFORM Screen1-Gd-1-Ev-Msg-Column-Moved
              END-EVALUATE
           END-EVALUATE
           .
      ***   start event editor code   ***
      *
       Screen1-Aft-Create.
           MODIFY Screen1-Gd-1, Y = 1, 
                                RECORD-TO-ADD = "      A       B       C  
      -    "       D       E       F       G       H       I       J"
      
           MODIFY Screen1-Gd-2, Y = 1, 
                                RECORD-TO-ADD = "      A       B       C  
      -    "       D       E       F       G       H       I       J"

      * load-initial-Screen1-Physical-Table
           perform varying ws-counter from 1 by 1                 
                   until ws-counter > max-cols 
              move ws-counter to ws-phys-col(ws-counter)
           end-perform        
           .
      *
       Screen1-Gd-1-Ev-Msg-Column-Moved.
           perform update-moved-columns
           .

       update-moved-columns.
      * When moved, the runtime sends a message to the COBOL program, MSG-COLUMN-MOVED.
      * Event-data-1 is the physical column moving, 
      * and event-data-2 is the physical column number immediately before the newly-moved column 
      * (at the time of movement). 
      *
           initialize ws-logical-col-from ws-logical-col-to  
           perform varying ws-counter from ws-first-usable-col by 1 
                    until ws-counter > max-cols
              if ws-phys-col(ws-counter) = event-data-1                         | I need to know the Logical position of the Physical Column I'm about to move
                 or ws-phys-col(ws-counter) = event-data-1 * -1                 | At the same time, the value my be negative
                    move ws-counter to ws-logical-col-from                      | Current Logical Column I am going to move  
              end-if
           end-perform        
           
           if ws-logical-col-from not = 0              
              
              if event-data-1 < event-data-2                                    | Column is going to be moved rightward 
                 perform varying ws-counter from ws-first-usable-col 
                         by 1 until ws-counter > max-cols  
                    if ws-counter = ws-logical-col-from
                       move event-data-2 to ws-phys-col(ws-counter)             | The column I am moving takes the new physical position
                    else                                                        | and then all the others included in the range will shift down
                       if ( ws-phys-col(ws-counter) >= event-data-1 
                            and 
                            ws-phys-col(ws-counter) <= event-data-2 
                          ) 
                          or
                          ( ws-phys-col(ws-counter) <= event-data-1 * -1        | Physical Columns may be hidden, which means included in range from -7 to -2
                            and 
                            ws-phys-col(ws-counter) >= event-data-2 * -1 
                          )  
                          if ws-phys-col(ws-counter) > 0                        | Column is NOT hidden  
                            subtract 1 from ws-phys-col(ws-counter)
                          else                                                  | Column IS hidden  
                            add 1 to ws-phys-col(ws-counter)
                          end-if   
                       end-if 
                    end-if
                 end-perform  
                              
              else                                                              | Column is going to be moved leftward 
              
                 add 1 to event-data-2
                 perform varying ws-counter from max-cols   
                         by -1 until ws-counter < ws-first-usable-col 
                    if ws-counter = ws-logical-col-from
                       move event-data-2 to ws-phys-col(ws-counter)             | The column I am moving takes the new physical position
                    else                                                        | and then all the others included in the range will shift down
                       if ( ws-phys-col(ws-counter) <= event-data-1 
                            and 
                            ws-phys-col(ws-counter) >= event-data-2 
                          ) 
                          or
                          ( ws-phys-col(ws-counter) >= event-data-1 * -1        | Physical Columns may be hidden, which means included in range from -7 to -2
                            and 
                            ws-phys-col(ws-counter) <= event-data-2 * -1 
                          )  
                          if ws-phys-col(ws-counter) > 0                        | Column is NOT hidden 
                            add 1 to ws-phys-col(ws-counter)  
                          else                                                  | Column IS hidden 
                            subtract 1 from ws-phys-col(ws-counter)
                          end-if   
                       end-if 
                    end-if
                 end-perform                             
              
              end-if 
           
           end-if  

      * Now I apply the same sequence of physical information to Grid n. 2

           MODIFY Screen1-Gd-2, PHYSICAL-COLUMNS = ( 0, 
                                                     ws-phys-col(1),
                                                     ws-phys-col(2),
                                                     ws-phys-col(3),
                                                     ws-phys-col(4),
                                                     ws-phys-col(5),
                                                     ws-phys-col(6),
                                                     ws-phys-col(7),
                                                     ws-phys-col(8),
                                                     ws-phys-col(9),
                                                     ws-phys-col(10),
                                                   )
           .
       

      *{Bench}end
       REPORT-COMPOSER SECTION.
