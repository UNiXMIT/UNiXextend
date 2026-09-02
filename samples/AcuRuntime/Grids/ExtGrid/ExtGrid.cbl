      *{Bench}prg-comment
      * ExtGrid.cbl
      * ExtGrid.cbl is generated from C:\AcuSamples\extgrid2\ExtGrid.Psf
      *{Bench}end
       IDENTIFICATION              DIVISION.
      *{Bench}prgid
       PROGRAM-ID. ExtGrid.
       AUTHOR. CContardi.
       DATE-WRITTEN. marted� 30 marzo 2010 16.07.41.
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
       77 ExtGrid-Handle
                  USAGE IS HANDLE OF WINDOW.
       01 ExtGrid-Gd-1-Record.
           05 ws-id-x          PIC  x(15).
           05 ws-id REDEFINES ws-id-x  PIC  9(15).
           05 ws-check         PIC  X(15).
           05 ws-radio         PIC  X(15).
           05 ws-combo         PIC  X(15).
       01 hbmp PIC  s9(9)
                  USAGE IS COMP-4.
       01 ws-id-z          PIC  z(15).
       01 ws-cont          PIC  9(5).
       01 stato            PIC  9.
       77 Fixed-Font
                  USAGE IS HANDLE OF FONT FIXED-FONT.
       77 Default-Font
                  USAGE IS HANDLE OF FONT DEFAULT-FONT.
       01 wnd-font.
           03 wnd-cell-size    PIC  9(5).
           03 wnd-cell-height  PIC  9(5).
       01 std-font.
           03 std-cell-size    PIC  9(5).
           03 std-cell-height  PIC  9(5).
       01 hstd-font
                  USAGE IS HANDLE OF FONT.
       01 columns-size.
           05 col1 PIC  9(3)
                      VALUE IS 10.
           05 col2 PIC  9(3)
                      VALUE IS 20.
           05 col3 PIC  9(3)
                      VALUE IS 20.
           05 col4 PIC  9(3)
                      VALUE IS 20.
       01 gc   PIC  9(5).
       01 gl   PIC  9(5).
       01 ox1  PIC  9(5).
       01 ox2  PIC  9(5).
       01 ox3  PIC  9(5).
       01 ox4  PIC  9(5).
       01 ox   PIC  9(5).
       01 oy   PIC  9(5)v9(2).
       01 x-px PIC  9(5).
       01 h-combo
                  USAGE IS HANDLE OF COMBO-BOX.
       01 mr   PIC  9(5).
       01 mc   PIC  9(5).
       01 h-label
                  USAGE IS HANDLE OF LABEL.
       01 l-lines          PIC  9(5)v9(3).
       01 l-size           PIC  9(5)v9(3).
       01 visualizza-combo PIC  9.
       01 ws-combo-value   PIC  x(20).
       77 grid-size        PIC  S9(4)V9(2)
                  VALUE IS 54,40.
       77 combo-size       PIC  9(5)v9(4).
       77 combo-line       PIC  9(5)v9(4).
       77 combo-col        PIC  9(5)v9(4).
       77 Arial14B
                  USAGE IS HANDLE OF FONT.
       77 MS-Sans-Serif14
                  USAGE IS HANDLE OF FONT.
       77 MS-Sans-Serif10
                  USAGE IS HANDLE OF FONT.
       77 method           PIC  s9(8)
                  USAGE IS COMP-5
                  VALUE IS 104.
       77 top-grid         PIC  9(5).
       01 font-size.
           05 fz-height        PIC  9(4)
                      USAGE IS COMP-5.
           05 fz-width         PIC  9(4)
                      USAGE IS COMP-5.
           05 fz-boxed-height  PIC  9(4)
                      USAGE IS COMP-5.
           05 fz-field-separation          PIC  9(4)
                      USAGE IS COMP-5.
       77 Small-Font
                  USAGE IS HANDLE OF FONT SMALL-FONT.
       77 ws-ecnld1051     PIC  x.
       77 ws-event-data-2  PIC  9(3).
       77 Large-Font
                  USAGE IS HANDLE OF FONT LARGE-FONT.
       77 Medium-Font
                  USAGE IS HANDLE OF FONT MEDIUM-FONT.
       77 grid-font
                  USAGE IS HANDLE OF FONT MEDIUM-FONT.
       77 Script11
                  USAGE IS HANDLE OF FONT.
       77 Traditional-Font
                  USAGE IS HANDLE OF FONT TRADITIONAL-FONT.

      *{Bench}end
       LINKAGE                     SECTION.
      *{Bench}linkage
      *{Bench}end
       SCREEN                      SECTION.
      *{Bench}copy-screen
       01 ExtGrid, 
           EXCEPTION PROCEDURE ExtGrid-Exception-Proc.
           03 ExtGrid-Gd-1, Grid, 
              COL 3,00, LINE 3,00, LINES 22,30 CELLS, 
              SIZE grid-size CELLS, 
              ADJUSTABLE-COLUMNS, 3-D, COLUMN-HEADINGS, 
              DATA-COLUMNS (1, 16, 31, 46), 
              DISPLAY-COLUMNS (1, 11, 31, 51), 
              CURSOR-FRAME-WIDTH 3, DIVIDER-COLOR 1, DRAG-COLOR 1, 
              FONT IS grid-font, HEADING-COLOR 257, 
              HEADING-DIVIDER-COLOR 1, ID IS 1, NUM-COL-HEADINGS 1, 
              NUM-ROWS 40, RECORD-DATA ExtGrid-Gd-1-Record, 
              TILED-HEADINGS, VPADDING 50, 
              EVENT PROCEDURE ExtGrid-Gd-1-Event-Proc.
           03 la-col1, Label, 
              COL 4,40, LINE 38,90, LINES 1,50 CELLS, SIZE 10,70 CELLS, 
              ID IS 2, LABEL-OFFSET 0, 
              TITLE "mouse-row", VISIBLE 0.
           03 la-col2, Label, 
              COL 15,10, LINE 38,90, LINES 1,50 CELLS, 
              SIZE 10,70 CELLS, 
              ID IS 3, LABEL-OFFSET 0, 
              TITLE "Label", VISIBLE 0.
           03 la-col3, Label, 
              COL 25,90, LINE 38,90, LINES 1,50 CELLS, 
              SIZE 10,70 CELLS, 
              ID IS 4, LABEL-OFFSET 0, 
              TITLE "mouse-col", VISIBLE 0.
           03 la-col4, Label, 
              COL 36,60, LINE 38,90, LINES 1,50 CELLS, 
              SIZE 10,70 CELLS, 
              ID IS 5, LABEL-OFFSET 0, 
              TITLE "Label", VISIBLE 0.

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
           PERFORM Acu-ExtGrid-Routine
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
           PERFORM ExtGrid-Aft-Program
           EXIT PROGRAM
           STOP RUN
           .

       Acu-ExtGrid-Routine.
      *    Before-Routine
           PERFORM Acu-ExtGrid-Scrn
           PERFORM Acu-ExtGrid-Proc
      *    After-Routine
           .

       Acu-ExtGrid-Scrn.
           PERFORM Acu-ExtGrid-Create-Win
           PERFORM Acu-ExtGrid-Init-Data
           .

       Acu-ExtGrid-Create-Win.
      *    Before-Create
      * display screen
              DISPLAY Standard GRAPHICAL WINDOW
                 LINES 35,90, SIZE 59,00, CELL HEIGHT 10, 
                 CELL WIDTH 10, AUTO-MINIMIZE, COLOR IS 65793, 
                 LABEL-OFFSET 0, LINK TO THREAD, MODELESS, NO SCROLL, 
                 WITH SYSTEM MENU, 
                 TITLE "Screen", TITLE-BAR, NO WRAP, 
                 EVENT PROCEDURE ExtGrid-Event-Proc, 
                 HANDLE IS ExtGrid-Handle
      * toolbar
           DISPLAY ExtGrid UPON ExtGrid-Handle
           PERFORM ExtGrid-Aft-Create
           .

       Acu-ExtGrid-Init-Data.
      *    Before-Initdata
           PERFORM Acu-ExtGrid-Gd-1-Content
      *    After-Initdata
           .
      * ExtGrid
       Acu-ExtGrid-Proc.
           PERFORM UNTIL Exit-Pushed
              ACCEPT ExtGrid  
                 ON EXCEPTION PERFORM Acu-ExtGrid-Evaluate-Func
              END-ACCEPT
           END-PERFORM
           DESTROY ExtGrid-Handle
           INITIALIZE Key-Status
           .

      * ExtGrid-Gd-1
       Acu-ExtGrid-Gd-1-Content.
           .

      * ExtGrid
       Acu-ExtGrid-Evaluate-Func.
           EVALUATE TRUE
              WHEN Exit-Pushed
                 PERFORM Acu-ExtGrid-Exit
              WHEN Event-Occurred
                 IF Event-Type = Cmd-Close
                    PERFORM Acu-ExtGrid-Exit
                 END-IF
           END-EVALUATE
           MOVE 1 TO Accept-Control
           . 

       Acu-ExtGrid-Exit.
           SET Exit-Pushed TO TRUE
           .


       Acu-ExtGrid-Event-Extra.
           EVALUATE Event-Type
           WHEN Msg-Close
              PERFORM Acu-ExtGrid-Msg-Close
           END-EVALUATE
           .

       Acu-ExtGrid-Msg-Close.
           ACCEPT Quit-Mode-Flag FROM ENVIRONMENT "QUIT_MODE"
           IF Quit-Mode-Flag = ZERO
              PERFORM Acu-ExtGrid-Exit
              PERFORM Acu-Exit-Rtn
           END-IF
           .

       ExtGrid-Event-Proc.
      * 
           PERFORM Acu-ExtGrid-Event-Extra
           .

       ExtGrid-Exception-Proc.
           PERFORM ExtGrid-Ex-Other
           .

       ExtGrid-Gd-1-Event-Proc.
      * 
           EVALUATE Event-Type
           WHEN Msg-Begin-Entry
              PERFORM ExtGrid-Gd-1-Ev-Msg-Begin-Entry
           WHEN Msg-Bitmap-Clicked
              PERFORM ExtGrid-Gd-1-Ev-Msg-Bitmap-Clicked
           WHEN Msg-Col-Width-Changed
              PERFORM ExtGrid-Gd-1-Ev-Msg-Col-Width-Changed
           END-EVALUATE
           .
      ***   start event editor code   ***
      *
       ExtGrid-Aft-Create.
           perform  leggi-dimensioni
           perform thread segui-mouse
      * metto l'intestazione 
           move spaces to ExtGrid-Gd-1-Record
           move "id" to ws-id-x
           move "check" to ws-check
           move "radio" to ws-radio
           move "combo" to ws-combo
           modify ExtGrid-Gd-1, RECORD-TO-ADD ExtGrid-Gd-1-Record
      * carico la bmp
      *     call "w$bitmap" using wbitmap-load "bmp1.bmp" 
      *                     giving hbmp
      * riempio le righe
           perform varying ws-cont from 1 by 1 until ws-cont = 40
                move "unchecked check" to ws-check
                move "unselected radio" to ws-radio
                move "combo-data" to ws-combo
                move ws-cont to ws-id-z
                move ws-id-z to ws-id-x
      ** metto i dati
                modify ExtGrid-Gd-1, record-to-add ExtGrid-Gd-1-Record
      ** metto la prima bmp
                modify ExtGrid-Gd-1, y ws-cont + 1
                                     x 2
                                     bitmap hbmp
                                     bitmap-width 12
                                     bitmap-number 1 |check-unchecked
                                     hidden-data 0
      ** metto la seconda bmp
                modify ExtGrid-Gd-1, y ws-cont + 1
                                     x 3
                                     bitmap hbmp
                                     bitmap-width 12
                                     bitmap-number 3 |radio-unselected 
                                     hidden-data 0
           end-perform
           
           .
      *
       ExtGrid-Aft-Program.
      * questa la metto qui perch� basta che ci sia  
      *      copy resource "bmp1.bmp".
           .
      *
       ExtGrid-Gd-1-Ev-Msg-Bitmap-Clicked.
           inquire ExtGrid-Gd-1, hidden-data in stato
           evaluate event-data-1
              when 2
                 if stato = 0
                    modify extgrid-gd-1 bitmap-number 2
                                        hidden-data = 1
                                        cell-data "checked check"
                 else
                    modify extgrid-gd-1 bitmap-number 1
                                        hidden-data = 0
                                        cell-data "unchecked check"
                 end-if
              when 3
                 if stato = 0
                    modify extgrid-gd-1 bitmap-number 4
                                        hidden-data = 1
                                        cell-data "selected radio"
                 else
                    modify extgrid-gd-1 bitmap-number 3
                                        hidden-data = 0 
                                        cell-data "unselected radio"
                 end-if                                
           end-evaluate
           set event-action to event-action-fail            
           .
      *
       ExtGrid-Gd-1-Ev-Msg-Begin-Entry.
           evaluate event-data-1
              when 1
              when 2
              when 3
                 set event-action to event-action-fail
              when 4
                 move 1 to visualizza-combo
                 set event-action to event-action-fail-terminate
           end-evaluate
           
           .
      *

       leggi-dimensioni.
      * leggo le dimensioni della cella della finestra
           accept WS-ECNLD1051 from environment "ECNLD1051"
           if WS-ECNLD1051 not = "1"
              move "0" to WS-ECNLD1051          
           end-if                     
      * method 1 
          initialize textsize-data 
          move Extgrid-Handle to textsize-window
          accept hstd-font from standard object "standard-font" 
          move hstd-font to textsize-font
          call "w$textsize" using "0" textsize-data
          compute wnd-cell-size = TEXTSIZE-BASE-X  / TEXTSIZE-CELLS-X
          compute wnd-cell-height = TEXTSIZE-BASE-Y  / TEXTSIZE-CELLS-Y
      * leggo le dimensioni dello standard font
          initialize font-size
      * Default-Font = font variable per la griglia
          move grid-font to   hstd-font
      *    move small-font to   hstd-font
      *    accept hstd-font from standard object "standard-font" 
      **--
          set environment "code_prefix" to "."
          call "atermmgr.dll"          
          call "w_font" using by value method
                              by value hstd-font
                              by reference font-size
                        giving stato
          if stato not = 1
             display message box "Errore w_font()"
             stop run
          end-if
          compute  std-cell-size  = fz-width

      *    compute  std-cell-height  =  fz-height
          compute  std-cell-height  =  FZ-BOXED-HEIGHT
      **--

      *    move hstd-font to textsize-font
      *    call "w$textsize" using "0" textsize-data
      *    compute  std-cell-size =  textsize-base-x |- 1
      *    compute  std-cell-height =  textsize-base-y |- 1

      * calcolo le dimensioni della griglia
           compute grid-size = grid-size * wnd-cell-size
          .
      *
       ExtGrid-Gd-1-Ev-Msg-Col-Width-Changed.
          evaluate event-data-1
             when 1
                move event-data-2 to col1
             when 2
                move event-data-2 to col2
             when 3
                move event-data-2 to col3
             when 4
                move event-data-2 to col4
          end-evaluate                              
          .
       calcola-coordinate.
      * la combo sar� nella colonna 4
      * considero le coordinate X
           inquire ExtGrid-Gd-1, COLUMN in gc
           compute gc = gc - 1 | l'origine � a colonna 1
           compute ox = gc * wnd-cell-size + 1
           compute ox1 = col1 * std-cell-size
           compute ox2 = col2 * std-cell-size
           compute ox3 = col3 * std-cell-size
      * la dimensione visibile dell'ultima colonna dipende 
      * da quanto � larga la griglia
           compute ox4 = grid-size - ox1 - ox2 - ox3
           compute x-px = ox + ox1 + ox2 + ox3        
      * considero le coordinate Y
      ** origine Y della griglia
           inquire ExtGrid-Gd-1, line in gl
           compute gl = gl - 1 | l'origine � a colonna 1
           compute oy = (gl * wnd-cell-height) + 1 |c'� un pixel vuoto all'inizio della finestra
          .

       segui-mouse.
          initialize MOUSE-INFO
          modify la-col1, VISIBLE 1
          modify la-col2, VISIBLE 1
          modify la-col3, VISIBLE 1
          modify la-col4, VISIBLE 1
          perform until Exit-Pushed
            call "w$mouse" using GET-MOUSE-STATUS mouse-info
            move mouse-row-pixel to mr
            move mouse-col-pixel to mc
            modify la-col2, TITLE mr
            modify la-col4, TITLE mc
            call "c$sleep" using 0,1
          end-perform
          .
      *
       ExtGrid-Ex-Other.
          if visualizza-combo = 1
                 modify ExtGrid-Gd-1, ENABLED = 0
      * calcolo le coordinate dove creare la combo
                 perform calcola-coordinate
      * creo la combo
      *-- le righe della griglia sembra siano alte il 
      *-- doppio delle celle della finestra
      *           compute combo-size = (ox4 - 1)/ wnd-cell-size
                 compute combo-size = ox4 
                 inquire ExtGrid-Gd-1, VSCROLL-POS in top-grid     
                 compute top-grid = top-grid - 1
                 if top-grid < 0 
                    move 0 to top-grid
                 end-if
                 compute ws-event-data-2 = event-data-2 - 1
            if WS-ECNLD1051 = "1"
               COMPUTE COMBO-LINE = ((ws-EVENT-DATA-2 - TOP-GRID ) *
                                     STD-CELL-HEIGHT)
                                    + OY + ws-EVENT-DATA-2 - top-grid 
            else
               COMPUTE COMBO-LINE = ((ws-EVENT-DATA-2 - TOP-GRID ) *
                                     STD-CELL-HEIGHT)
                                     + OY 
            end-if

      *           compute combo-line = ((event-data-2 - top-grid - 1) * 
      **                                (std-cell-height * 1,5)
      *                                (std-cell-height )
      **                                + oy + event-data-2 - top-grid)
      *                                + oy - top-grid)
      *

                 display combo-box
                         lines 5
      *                   lines (std-cell-height * 1,5)pixel
                         font hstd-font
                         size combo-size pixel
                         line combo-line pixel
                         col x-px + 1 pixel  |1 -> col-dividers
                         handle in h-combo
                 modify h-combo item-to-add "valore1"
                                item-to-add "valore2"
                                item-to-add "valore3"
                                
      * accetto la combo
                 accept h-combo on exception continue end-accept
                 inquire h-combo value in ws-combo-value
                 modify ExtGrid-Gd-1,
                 (event-data-2, event-data-1) CELL-DATA = ws-combo-value
      * distruggo la combo
                 destroy h-combo
                 move 0 to visualizza-combo
                 modify ExtGrid-Gd-1, ENABLED = 1
           end-if
                                       
           .

       

      *{Bench}end
       REPORT-COMPOSER SECTION.
