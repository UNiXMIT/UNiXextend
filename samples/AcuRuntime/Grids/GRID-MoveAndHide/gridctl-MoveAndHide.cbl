       identification division.
CCCCCC* program-id.  gridctl.
CCCCCC program-id.  gridctl-MoveAndHide.
       
CCCCCC* Modified by ccontardi - 30,31/12/2020 - 02,03/01/2021
CCCCCC* Adding features regarding ECN-4697


      * Copyright (C) 1996,1998-2001,2013 Micro Focus or one
      * of its affiliates.
      *
      * The only warranties for products and services of Micro Focus
      * and its affiliates and licensors ("Micro Focus") are set
      * forth in the express warranty statements accompanying such
      * products and services. Nothing herein should be construed as
      * constituting an additional warranty. Micro Focus shall not
      * be liable for technical or editorial errors or omissions
      * contained herein. The information contained herein is
      * subject to change without notice.
      *
      * Contains Confidential Information. Except as specifically
      * indicated otherwise, a valid license is required for possession,
      * use or copying. Consistent with FAR 12.211 and 12.212,
      * Commercial Computer Software, Computer Software Documentation,
      * and Technical Data for Commercial Items are licensed to the U.S.
      * Government under vendor's standard commercial license.

      * This program demonstrates how to create a grid control with the
      * ability to sort by columns.
      *
      * Grids with headers may also allow for the rows of the grid 
      * to be sorted by the column headers using the property 
      * SORT-TYPES. Grids with the SORT-TYPES property specified have 
      * some unique characteristics that may affect the display of the 
      * grid's rows.
      *
      * Grid sorting uses the quicksort algorithm to sort the columns. 
      * While this is very fast, quicksort is an "unstable sorting" algorithm. 
      * Unstable sorting algorithms do not maintain the relative order of
      * records with equal keys. Since quicksort is an unstable sorting 
      * algorithm, sorting on one column and then on the original column will 
      * not necessarily keep the rows in the same order for those that have 
      * duplicates in the sorted column.  (For more information, please 
      * search for "stable sort" in your favorite search engine.)
      *
      * While this sample is not of a paged grid, you should be aware that
      * because rows are not necessarily in the order you placed them into
      * the grid, the NEXT, PREVIOUS, NEXT PAGE, and PREVIOUS PAGE events
      * should be handled with care. The TOP and END events may show unexpected rows. 
      * This is because all of these events assume that the grid rows are in the 
      * original order (the order you placed them into the grid originally). 
      * Care must be taken when using the SORT property on paged grids to 
      * avoid confusing your users.
      *
      * When you run the gridctl sample program, a grid will be displayed 
      * and populated with data. The data displayed initially has the rows
      * in the order in which the grid was populated.  
      * In this sample, the data was loaded alphabetically by the 
      * category field. Note that when you click on the CATEGORY header, 
      * the ordering of the rows display may change.  This is due to the 
      * rows being changed from the order in which they were loaded 
      * into the grid to an ordering determined by the output of quicksort.  
      * Clicking on the AUTHOR header and then on the originally selected 
      * CATEGORY header may again change the ordering of the rows being 
      * displayed.  The only constant condition is that the rows will be 
      * sorted by the header being clicked on, but will have an undetermined 
      * ordering for those columns with duplicate key values.
      *
       environment division.
       data division.
       working-storage section.

      * Copybooks

       copy "def/acucobol.def".
       copy "def/acugui.def".
       copy "def/crtvars.def".
       copy "def/controls.def".
       copy "def/opensave.def".
       copy resource "littlegt.bmp".

      * Constants

CCCCCC 78  max-rows                          value 21. | 18.
       78  max-cols                          value 7.

      * Crt-Status

       77  key-status is special-names crt status pic 9(4) value 0.
         88  exit-pressed                    value 10.
         88  about-pressed                   value 15.
         88  exit-about-screen               value 201.
CCCCCC   88  adjustable-pressed              value 701.
CCCCCC   88  moveable-pressed                value 702.
CCCCCC   88  hide-pressed                    value 703.
CCCCCC   88  move-back-pressed               value 704.
CCCCCC   88  move-forward-pressed            value 705.
CCCCCC   88  reset-pressed                   value 706.
CCCCCC   88  search-pressed                  value 707.

      * Handles

       77  window-0                          handle of window.
       77  window-1                          handle of window.
       77  about-thread                      handle of thread.
       77  grid-menu                         handle of menu.
       77  gt-bitmap                         pic s9(9) comp-4.
CCCCCC 77  Screen1-St-1-Handle USAGE IS HANDLE OF STATUS-BAR.

      * Data Items for Screen Handling

       77  ctr                               pic 99    value 0.
       77  grid-y                            pic 99    value 0.
         88 in-column-headings                         value 1.
       77  grid-x                            pic 99    value 0.
         88 in-row-headings                            value 1.
       77  bmp-num                           pic 99    value 0.
       77  scratch                           pic x(80) value spaces.
CCCCCC 77 ws-is-adjustable                   PIC S9(1) VALUE 0.  
CCCCCC 77 ws-is-moveable                     PIC S9(1) VALUE 0. 
CCCCCC 77 ws-counter                         pic 99    value 0.
CCCCCC 77 ws-st-content                      PIC x(110) value spaces.
CCCCCC 77 ws-Search-String                   pic x(20) value spaces.
CCCCCC 77 ws-current-col                     PIC 9(3)  value 0.
CCCCCC 77 ws-current-row                     PIC 9(3)  value 0.
CCCCCC 77 ws-search-result                   PIC 9     value 0.
CCCCCC 77 Screen1-Cm-1-Value                 PIC x(10).       
CCCCCC 77 Screen1-Cm-2-Value                 PIC x(10).  
CCCCCC 77 ws-hiding-logical-col              PIC  9(3) value 0. 
CCCCCC 77 ws-logical-col-from                PIC  9(3) value 0. 
CCCCCC 77 ws-logical-col-to                  PIC  9(3) value 0. 
CCCCCC 77 ws-phys-col-no-sign                PIC  9(3) value 0. 
CCCCCC 77 ws-phys-col-temp-val               PIC S9(3).
CCCCCC 77 ws-num-rows                        PIC S9(3) value -1.
CCCCCC 77 ws-num-row-headings                PIC  9(3) value 1. 
CCCCCC 77 ws-first-usable-col                PIC  9(3) value 0. 

CCCCCC 01 Screen1-Cm-1-Container-Item.
          05 PIC X(10) VALUE spaces.
          05 PIC X(10) VALUE "CATEGORY".
          05 PIC X(10) VALUE "AUTHOR".
          05 PIC X(10) VALUE "NAME".
          05 PIC X(10) VALUE "TITLE".
          05 PIC X(10) VALUE "PUBLISHER".
          05 PIC X(10) VALUE "DATE".
CCCCCC 01 Screen1-Cm-1-Container REDEFINES 
           Screen1-Cm-1-Container-Item PIC X(10) OCCURS max-cols TIMES.

CCCCCC 01 Screen1-Physical-Table.                                          | This will store the Physical information about the Grid
          03 Screen1-Physical-Table-Item OCCURS max-cols TIMES.            | I use its index when I need to refer to the Logical position of the columns
             05 ws-phys-descr PIC X(10).
             05 ws-phys-col   PIC S9(3).

      * Grid Data

       01 grid-data-table.
         05 filler                           pic x(120)
CCCCCC     value "  CAT.(2)         AUTH.(3) NAME (4)       TITLE (5)
CCCCCC-    "                         PUBLISHER (6)             DATE (7)"
           .
         05 filler                           pic x(120)
           value "01Adventure       Fleming  Ian            On Her Majes
      -    "ty's Secret Service      New American Library      01/10/196
      -    "3".
         05 filler                           pic x(120)
           value "02Art             CrespelleJean-Paul      Monet
      -    "                         Studio Editions           12/25/199
      -    "3".
         05 filler                           pic x(120)
           value "03Biographical    Adamson  Joy            Born Free
      -    "                         Pantheon                  6/8/1960"
           .
         05 filler                           pic x(120)
           value "04Children        Milne    A.A.           Winnie the P
      -    "ooh                      E.P. Dutton & Co., Inc    03-23-195
      -    "6".
         05 filler                           pic x(120)
           value "05Fiction         Miller   Henry          Tropic of Ca
      -    "pricorn                  Grove Press               4/20/1961
      -    "".
         05 filler                           pic x(120)
           value "06History         Durant   Will and Ariel The Age of N
      -    "apoleon                  Simon and Schuster        04/20/197
      -    "5".
         05 filler                           pic x(120)
           value "07History         Stone    Irving         The Agony an
      -    "d the Ecstasy            Doubleday & Company, Inc  03/20/195
      -    "8".
         05 filler                           pic x(120)
           value "08History         Tuchmann Barbara        The March of
      -    " Folly                   Alfred A. Knopf, Inc      10-12-198
      -    "4".
         05 filler                           pic x(120)
           value "09Murder Mystery  Christie Agatha         Sleeping Mur
      -    "der                      The Haddon Craftsman, Inc 07-08-197
      -    "6".
         05 filler                           pic x(120)
           value "10Reference       Matthews Peter          The Guinness
      -    " Book of Records 1996    Bantam Books              9-10-1997
      -    "".
         05 filler                           pic x(120)
           value "11Science         Macauly  David          The Way Thin
      -    "gs Work                  Houghton Mifflin, Co      09/08/198
      -    "8".
         05 filler                           pic x(120)
           value "12Science Fiction Crichton Michael        AirFrame
      -    "                         Alfred A. Knopf, Inc      01/05/199
      -    "6".
         05 filler                           pic x(120)
           value "13Science Fiction Crichton Michael        Jurassic Par
      -    "k                        Signet Fiction            001/4/199
      -    "4".
         05 filler                           pic x(120)
           value "14Science Fiction Niven    Larry          Ringworld
      -    "                         Ballantine Books          8/9/1970"
           .
         05 filler                           pic x(120)
           value "15Science Fiction Verne    Jules          A Journey to
      -    " the Center of the Earth Signet Classic            8/11/1986
      -    "".
         05 filler                           pic x(120)
           value "16Science Fiction Verne    Jules          20,000 Leagu
      -    "es Under the Sea         Signet Classic            12/8/1986
      -    "".
         05 filler                           pic x(120)
           value "17Science Fiction Wells    H.G.           The Invisibl
      -    "e Man                    Signet Classic            11/9/1986
      -    "".
CCCCCC   05 filler                           pic x(120)
CCCCCC     value "18Space Opera     Soule    Charles        Light of the
CCCCCC-    " Jedi                    Century                   05/01/202
CCCCCC-    "1".
CCCCCC   05 filler                           pic x(120)
CCCCCC     value "19Science Fiction SchätzingFrank          Limit
CCCCCC-    "                         Kiepenheuer & Witsch      05/10/200
CCCCCC-    "9".
CCCCCC   05 filler                           pic x(120)
CCCCCC     value "20Horror          Simmons  Dan            Summer of Ni
CCCCCC-    "ght                      Putnam Pub Group          01/01/199
CCCCCC-    "1".

       01 grid-data-tbl redefines grid-data-table.
         05 grid-record occurs max-rows times      pic x(120).
      *
       screen section.
       01 main-screen exception procedure exception-handler.
         03 grid-1, grid,
               line 2.5, col 2,
               size 125, lines 18.1,
               data-columns       = ( 1, 3, 19, 28, 43, 80, 106)
               display-columns    = ( 1, 4, 20, 32, 46, 85, 111)
               sort-types         = ("-","X","X","X","X","X","D^")
               alignment          = ("C","C","C","C","C","C","R")
               row-dividers       = (1,3)
               column-dividers    = (2,2,2,2,2,2)
               divider-color      = bright-red
               cursor-color       = 80
               heading-color      = 144
               cursor-frame-width = -1
               vpadding           = 50
               virtual-width      = 124
CCCCCC*        adjustable-columns                                          | I am managing this from the source code.
               use-tab
               column-headings
               row-headings
               centered-headings
               tiled-headings
               pop-up menu          grid-menu
               event procedure is   grid-1-handler
CCCCCC         NUM-ROWS             ws-num-rows
CCCCCC         NUM-ROW-HEADINGS     ws-num-row-headings
CCCCCC         VSCROLL
CCCCCC         HSCROLL                                                     | I need to add HSCROLL here, as it does not appear automatically.
               .
      *
CCCCCC* BEGINNING OF NEW CODE   
      *
           03 Screen1-Ef-1, Entry-Field, 
               line 23, col 5, 
               LINES 1.2 CELLS, SIZE 14 CELLS,  
               BOXED, VALUE ws-Search-String.   
           03 Screen1-Pb-1, push-button,
               line 23, col 20,
               LINES 1.2 CELLS, size 10 cells
               title "SEARCH",
               self-act,
               exception-value    = 707.    
      *
           03 Screen1-Cb-1, Check-Box,
               line 25, col 5, 
               LINES 1.2 CELLS, SIZE 25 CELLS, 
               EXCEPTION-VALUE 701,
               SELF-ACT, TEXT-ONLY,
               TITLE "ADJUSTABLE-COLUMNS", 
               VALUE ws-is-adjustable. 
      *        
           03 Screen1-La-2, Label, 
               line 25, col 32,
               LINES 1.2 CELLS, SIZE 17 CELLS, 
               TITLE "Hide/Show column"
               ENABLED 0.     
           03 Screen1-Cm-1, Combo-Box,
               line 25.1, col 49,
               LINES 11.10 CELLS, SIZE 15 CELLS, 
               3-D, DROP-DOWN, UNSORTED, 
               VALUE Screen1-Cm-1-Value
               ENABLED 0. 
           03 Screen1-Pb-2, push-button,
               line 25, col 66,
               LINES 1.2 CELLS, size 6 cells
               title "GO",
               self-act,
               exception-value    = 703
               ENABLED 0.                 
      *
           03 Screen1-Cb-2, Check-Box,
               line 27, col 5, 
               LINES 1.2 CELLS, SIZE 25 CELLS, 
               EXCEPTION-VALUE 702,
               SELF-ACT, TEXT-ONLY,
               TITLE "MOVEABLE-COLUMNS", 
               VALUE ws-is-moveable.
      *        
           03 Screen1-La-4, Label, 
               line 27, col 32,
               LINES 1.2 CELLS, SIZE 12 CELLS, 
               TITLE "Move column"
               ENABLED 0.    
           03 Screen1-Pb-3, push-button,
               line 27, col 44,
               LINES 1.2 CELLS, size 6 cells
               title "<<<",
               self-act,
               exception-value    = 704
               ENABLED 0.     
           03 Screen1-Cm-2, Combo-Box,
               line 27.1, col 51,
               LINES 11.10 CELLS, SIZE 15 CELLS, 
               3-D, DROP-DOWN, UNSORTED, 
               VALUE Screen1-Cm-2-Value
               ENABLED 0.   
           03 Screen1-Pb-4, push-button,
               line 27, col 67,
               LINES 1.2 CELLS, size 6 cells
               title ">>>",
               self-act,
               exception-value    = 705
               ENABLED 0.     
      *
           03 Screen1-Pb-99, push-button,
               line 29, col 5, 
               LINES 1.2 CELLS, SIZE 25 CELLS, 
               title "RESET GRID",
               self-act,
               exception-value    = 706.      
      *
CCCCCC* END
      *
         05 about-pb, push-button,
               line 33, col 98,
CCCCCC         LINES 1.2 CELLS,
               size 14 cells
               title "&About",
               self-act,
               exception-value    = 15.

         05 push-button,
               line 33, col 114,
CCCCCC         LINES 1.2 CELLS,
               size 14 cells
               title "E&xit",
               self-act,
               exception-value    = 10.
      *
       01 about-screen exception exception-handler.
         05 comments-listbox, list-box,
               line + 1.5, column 2
               size 62, lines 14
               3-d,
               unsorted.

         05 push-button,
               line 16, col 26.5,
               title "E&xit",
               self-act,
               exception-value = 201.
      *
       procedure division.
       main-logic.
      *
           perform initialization.
           display standard graphical window,
                   title "Grid Control Demo - 10.4.0 Grid New Features",
                   size 130, 
CCCCCC             lines 35, |25, 
CCCCCC             RESIZABLE
CCCCCC             AUTO-RESIZE
                   background-low
                   modeless, link to thread,
                   cell height = entry-field font
                   handle window-0.
      *
           call "w$bitmap" using wbitmap-load, "littlegt.bmp",
                giving gt-bitmap.

      *   The menu is a popup menu, activated by right-clicking the mouse.
      *   In this program, you can also activate this menu by clicking on
      *   the spinning bitmap.  You will notice that the menu handle is
      *   referred to in the screen section description of the Grid control,
      *   and described in Working-Storage as USAGE HANDLE OF MENU.

           perform build-main-popup.
           move menu-handle to grid-menu.

CCCCCC     DISPLAY STATUS-BAR
CCCCCC        PANEL-WIDTHS 128, 
CCCCCC        PANEL-STYLE 1, 
CCCCCC        PANEL-TEXT ws-st-content, 
CCCCCC        GRIP, 
CCCCCC        HANDLE IS Screen1-St-1-Handle

           display main-screen.
           perform load-grid.
           perform thread animate-bitmap.           
                
CCCCCC     MODIFY Screen1-Cm-1, ITEM-TO-ADD = TABLE 
                                Screen1-Cm-1-Container
CCCCCC     MODIFY Screen1-Cm-2, ITEM-TO-ADD = TABLE 
                                Screen1-Cm-1-Container
                                
CCCCCC     perform load-initial-Screen1-Physical-Table                               

           perform, with test after, until exit-pressed
             accept main-screen on exception continue end-accept
           end-perform.

           stop run.

      *  Grids are loaded with the MODIFY.....RECORD-TO-ADD syntax.
      *  After loading the grid, the cursor is placed in cell 2,2
      *  because this grid has COLUMN-HEADINGS occupying row 1, and
      *  ROW-HEADINGS occupying column 1.

       load-grid.
           perform varying ctr from 1 by 1 until ctr > max-rows
             modify grid-1, record-to-add = grid-record(ctr)
           end-perform.

           modify grid-1, cursor-x = 2, cursor-y = 2.
           
CCCCCC load-initial-Screen1-Physical-Table.     
           perform varying ws-counter from 1 by 1 
                   until ws-counter > max-cols 
              move ws-counter to ws-phys-col(ws-counter)
              move Screen1-Cm-1-Container(ws-counter) 
                              to ws-phys-descr(ws-counter)
           end-perform        
           .     

      * Bitmaps can be place into grid cells, but bitmap controls cannot.
      * To animate a bitmap in a grid cell, set up an infinite loop, and
      * perform it in a thread of its own.  To achieve the spinning effect,
      * MODIFY the bitmap number on a time interval.  In this example,
      * the interval is 2/10 of a second, and is regulated by a call to
      * C$SLEEP.

       animate-bitmap.

           perform until 2 = 1
             perform varying bmp-num from 1 by 1 until bmp-num > 15
               modify grid-1,
                 x = 1, y = 1,
                 bitmap = gt-bitmap
                 bitmap-number = bmp-num
                 bitmap-width = 16,
                 bitmap-trailing = 1

                 call "c$sleep" using 0.2
             end-perform
           end-perform.

      * The ABOUT window is an INDEPENDENT WINDOW, and can be minimized
      * independently of the Main Window.  It is also a MODELESS WINDOW,
      * and is executed in its own THREAD.

       explain-the-program.
           display independent window line 10 col 10
                   title-bar, system menu,
                   title "About GridCtl",
                   lines 17 size 60
                   auto-minimize
                   modeless bind to thread
                   handle window-1.

           display about-screen.
           perform load-comments.

           perform until exit-about-screen
             accept about-screen on exception continue end-accept
           end-perform.

           modify about-pb, enabled = 1.
           call "w$menu" using wmenu-enable, grid-menu, 15.

      * An unsorted Listbox is an excellent tool for presenting comments

       load-comments.
           modify comments-listbox, reset-list = 1                    .
           move "Using the Grid Control Demo Program" to scratch      .
           modify comments-listbox, item-to-add = scratch             .
           move "-" to scratch                                        .
           modify comments-listbox, item-to-add = scratch             .
           move "Drag the Mouse across Column Headings" to scratch    .
           modify comments-listbox, item-to-add = scratch             .
           move "Drag the Mouse down Row Headings" to scratch         .
           modify comments-listbox, item-to-add = scratch             .
           move "Left-click on a Grid Cell, and Drag Mouse" to scratch.
           modify comments-listbox, item-to-add = scratch             .
           move "Click on a Column Heading" to scratch                .
           modify comments-listbox, item-to-add = scratch             .
           move "Click on a Row Heading" to scratch                   .
           modify comments-listbox, item-to-add = scratch             .
           move "Click on a Column Heading Divider, and " to scratch  .
           modify comments-listbox, item-to-add = scratch             .
           move "  adjust column width by dragging divider" to scratch.
           modify comments-listbox, item-to-add = scratch             .
           move "Launch Vertical Popup Menu by: " to scratch          .
           modify comments-listbox, item-to-add = scratch             .
           move "  Clicking on Bitmap in Cell (1,1) " to scratch      .
           modify comments-listbox, item-to-add = scratch             .
           move "  Right-clicking on the Grid Control" to scratch     .
           modify comments-listbox, item-to-add = scratch             .
           move "Click on cell, and enter data" to scratch            .
           modify comments-listbox, item-to-add = scratch             .
           move "To cancel entry, press the ESC key" to scratch       .
           modify comments-listbox, item-to-add = scratch             .

      * Since the ABOUT screen is a MODELESS WINDOW, it must be launched
      * in its own THREAD.

       exception-handler.
           evaluate true
           
             when about-pressed
               modify about-pb, enabled = 0
               call "w$menu" using wmenu-disable, grid-menu, 15
               perform thread explain-the-program handle about-thread
               
CCCCCC       when adjustable-pressed
      * Grids that have ADJUSTABLE-COLUMNS specified will now allow columns to be fully 
      * hidden by dragging the trailing divider to the beginning of the column.  
      * (Previously this would result in a "width 1" column, now it hides the column entirely).  
      * With ADJUSTABLE-COLUMNS set, a small mark will appear at the top of any hidden column.  
      * Clicking this mark will restore the column to its prior size.  
               if ws-is-adjustable = 1
                  modify grid-1, adjustable-columns
                  initialize ws-st-content
                  string "You can adjust size and hide columns, now. "
                       into ws-st-content
                  modify Screen1-St-1-Handle, PANEL-TEXT ws-st-content
                  modify Screen1-La-2, enabled = 1
                  modify Screen1-Cm-1, enabled = 1
                  modify Screen1-Pb-2, enabled = 1
               else   
                  modify grid-1, not adjustable-columns
                  initialize ws-st-content 
                  modify Screen1-St-1-Handle, PANEL-TEXT ws-st-content
                  modify Screen1-La-2, enabled = 0
                  modify Screen1-Cm-1, enabled = 0
                  modify Screen1-Pb-2, enabled = 0
               end-if
               
CCCCCC       when moveable-pressed
      * MOVEABLE-COLUMNS is a new style. 
      * Without this, users will not be able to move by dragging the column.
      * When columns can be moved, the user can drag a column header to a new location. 
      * While moving, a dark area the size of the column header will drag with the mouse, 
      * and when getting to a valid drop location, will display two red arrows (one pointing up, 
      * one pointing down) at the column separator where the column will move to.
               if ws-is-moveable = 1
                  modify grid-1, moveable-columns
                  initialize ws-st-content 
                  string "You can move columns, now. "
                       into ws-st-content
                  modify Screen1-St-1-Handle, PANEL-TEXT ws-st-content
                  modify Screen1-La-4, enabled = 1
                  modify Screen1-Cm-2, enabled = 1
                  modify Screen1-Pb-3, enabled = 1
                  modify Screen1-Pb-4, enabled = 1
               else   
                  modify grid-1, not moveable-columns
                  initialize ws-st-content 
                  modify Screen1-St-1-Handle, PANEL-TEXT ws-st-content
                  modify Screen1-La-4, enabled = 0
                  modify Screen1-Cm-2, enabled = 0
                  modify Screen1-Pb-3, enabled = 0
                  modify Screen1-Pb-4, enabled = 0
               end-if
               
CCCCCC       when hide-pressed
                  perform hide-unhide-column
                  
CCCCCC       when move-back-pressed
                  perform move-column-back
                  
CCCCCC       when move-forward-pressed
                  perform move-column-forward
                                                     
CCCCCC       when reset-pressed
                  perform reset-columns
                                                     
CCCCCC       when search-pressed
                  perform search-grid
                  
           end-evaluate.

      * We have selected a subset of the GRID control's events, and
      * programmed responses to them.  In each case, the programmed response
      * is that a color change occur, and that the color change affect a
      * prescribed range of cells in the GRID.

       grid-1-handler.
           evaluate event-type

             when msg-goto-cell             
             when msg-goto-cell-mouse
                 modify grid-1, region-color = 0
CCCCCC           modify grid-1, X = ws-current-col, Y = ws-current-row
CCCCCC                          CELL-COLOR = 0

             when msg-bitmap-clicked
                 call "w$menu" using wmenu-popup, grid-menu

             when msg-goto-cell-drag
                 modify grid-1,
                   drag-color = bright-white + bckgrnd-red
                   
CCCCCC       when MSG-COLUMN-SHOW   
                 perform update-hidden-columns      
                   
CCCCCC       when MSG-COLUMN-MOVED   
                 perform update-moved-columns              
                 
           end-evaluate.
      *
       copy "gridctl.cpy".

       initialization.
           accept terminal-abilities from terminal-info.
           if not has-graphical-interface
             display message box
               "This program requires a GUI runtime"
             stop run
           end-if.
      *
CCCCCC* BEGINNING OF NEW CODE   
      *
       hide-unhide-column.
           add 1 to ws-num-row-headings giving ws-first-usable-col                | Row Header cannot be hidden, nor moved
           perform varying ws-counter from ws-first-usable-col by 1
                   until ws-counter > max-cols
              if ws-phys-descr(ws-counter) = Screen1-Cm-1-Value    
                 multiply -1 by ws-phys-col(ws-counter)
              end-if
           end-perform
           MODIFY grid-1, PHYSICAL-COLUMNS (0,
                                            ws-phys-col(1),
                                            ws-phys-col(2),
                                            ws-phys-col(3),
                                            ws-phys-col(4),
                                            ws-phys-col(5),
                                            ws-phys-col(6),
                                            ws-phys-col(7))
           .
      *
       update-hidden-columns. 
      * When hidden, the runtime sends a message to the COBOL program, MSG-COLUMN-SHOW. 
      * Event-data-1 is either 0 (hiding) or 1 (showing) the column.
      * Event-data-2 is a combination of the physical and logical columns, 
      * using the formula (physical-column-number * 1000) + logical-column-number.
      * In the case of showing a column, the "physical-column-number" is where 
      * the revealed column will appear.  
      
           move Event-data-2 to ws-hiding-logical-col
           multiply -1 by ws-phys-col(ws-hiding-logical-col)
           .
      *
       update-moved-columns.
      * When moved, the runtime sends a message to the COBOL program, MSG-COLUMN-MOVED.
      * Event-data-1 is the physical column moving, 
      * and event-data-2 is the physical column number immediately before the newly-moved column 
      * (at the time of movement). 
  
           initialize ws-logical-col-from ws-logical-col-to  
           add 1 to ws-num-row-headings giving ws-first-usable-col              | Row Header cannot be hidden, nor moved
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
           .
      *
       move-column-back.   
           initialize ws-logical-col-from ws-logical-col-to               
           add 1 to ws-num-row-headings giving ws-first-usable-col            | Row Header cannot be hidden, nor moved
           perform varying ws-counter from max-cols by -1 
                   until ws-counter < ws-first-usable-col 
              if ws-phys-descr(ws-counter) = Screen1-Cm-2-Value 
                 and ( 
                       ws-phys-col(ws-counter) > ws-first-usable-col
                     or
                     ( ws-phys-col(ws-counter) >= max-cols * -1 and 
                       ws-phys-col(ws-counter) < 
                                             ws-first-usable-col * -1 )
                     )                        
                    move ws-counter              to ws-logical-col-from       | Logical Column I am going to move
                    move ws-phys-col(ws-counter) to ws-phys-col-temp-val      | Its current physical position
                    move ws-phys-col-temp-val    to ws-phys-col-no-sign       | As it may be hidden, I remove the sign
                    subtract 1                 from ws-phys-col-no-sign       | This will be the new physical position
              end-if 
           end-perform    
           perform varying ws-counter from ws-first-usable-col by 1 
                   until ws-counter > max-cols
              if ws-phys-col(ws-counter) = ws-phys-col-no-sign                | I need to know who's currently occupying the physical position I'm moving my column to
                 or ws-phys-col(ws-counter) = ws-phys-col-no-sign * -1        | At the same time, the value my be negative
                    move ws-counter              to ws-logical-col-to         | Current Logical Column I am going to replace with my move    
              end-if
           end-perform  
            
           if ws-logical-col-from not = 0 
              if ws-phys-col(ws-logical-col-from) > 0                            | Column is NOT hidden       
                 subtract 1 from ws-phys-col(ws-logical-col-from)      
              else                                                               | Column IS hidden          
                 add      1 to ws-phys-col(ws-logical-col-from)        
              end-if
            
              if ws-phys-col(ws-logical-col-to) > 0                              | Column is NOT hidden  
                 add      1 to ws-phys-col(ws-logical-col-to)       
              else                                                               | Column IS hidden  
                 subtract 1 from ws-phys-col(ws-logical-col-to)        
              end-if
           
              MODIFY grid-1, PHYSICAL-COLUMNS (0,
                                               ws-phys-col(1),
                                               ws-phys-col(2),
                                               ws-phys-col(3),
                                               ws-phys-col(4),
                                               ws-phys-col(5),
                                               ws-phys-col(6),
                                               ws-phys-col(7))      
           end-if
           .
      *             

       move-column-forward.      
           initialize ws-logical-col-from ws-logical-col-to       
           add 1 to ws-num-row-headings giving ws-first-usable-col            | Row Header cannot be hidden, nor moved
           perform varying ws-counter from ws-first-usable-col by 1 
                   until ws-counter > max-cols
              if ws-phys-descr(ws-counter) = Screen1-Cm-2-Value 
                 and ws-phys-col(ws-counter) < max-cols
                 and ws-phys-col(ws-counter) > max-cols * -1                  | Column might be hidden, and this value negative
                    move ws-counter              to ws-logical-col-from       | Logical Column I am going to move
                    move ws-phys-col(ws-counter) to ws-phys-col-temp-val      | Its current physical position
                    move ws-phys-col-temp-val    to ws-phys-col-no-sign       | As it may be hidden, I remove the sign
                    add 1                        to ws-phys-col-no-sign       | This will be the new physical position
              end-if 
           end-perform    
           perform varying ws-counter from ws-first-usable-col by 1 
                   until ws-counter > max-cols
              if ws-phys-col(ws-counter) = ws-phys-col-no-sign                | I need to know who's currently occupying the physical position I'm moving my column to
                 or ws-phys-col(ws-counter) = ws-phys-col-no-sign * -1        | At the same time, the value my be negative
                    move ws-counter              to ws-logical-col-to         | Current Logical Column I am going to replace with my move    
              end-if
           end-perform  
           
           if ws-logical-col-from not = 0 
              if ws-phys-col(ws-logical-col-from) > 0                            | Column is NOT hidden          
                 add      1 to ws-phys-col(ws-logical-col-from)  
              else                                                               | Column IS hidden           
                 subtract 1 from ws-phys-col(ws-logical-col-from)     
              end-if 
             
              if ws-phys-col(ws-logical-col-to) > 0                              | Column is NOT hidden   
                 subtract 1 from ws-phys-col(ws-logical-col-to)  
              else                                                               | Column IS hidden 
                 add      1 to ws-phys-col(ws-logical-col-to)         
              end-if 
           
              MODIFY grid-1, PHYSICAL-COLUMNS (0,
                                               ws-phys-col(1),
                                               ws-phys-col(2),
                                               ws-phys-col(3),
                                               ws-phys-col(4),
                                               ws-phys-col(5),
                                               ws-phys-col(6),
                                               ws-phys-col(7))     
           end-if
           .
      *
       reset-columns. 
           perform load-initial-Screen1-Physical-Table   
           
           MODIFY grid-1, PHYSICAL-COLUMNS (0,
                                            ws-phys-col(1),
                                            ws-phys-col(2),
                                            ws-phys-col(3),
                                            ws-phys-col(4),
                                            ws-phys-col(5),
                                            ws-phys-col(6),
                                            ws-phys-col(7))
                                            
           initialize ws-st-content
           modify Screen1-St-1-Handle, PANEL-TEXT ws-st-content                       
           .
      *
       search-grid.   
      * When a column is hidden, explicitly moving the cursor to that column via CURSOR-X or CURSOR-PHYS-X
      * will reveal the column.  Also, if SEARCH-TEXT finds a value in a hidden column and positions the
      * cursor there, the column will be revealed.  
      * In general, the grid will not allow the cursor to occupy a hidden column.       

           inquire grid-1, SEARCH-OPTIONS in GRID-SEARCH-OPTIONS

           SET GRID-SEARCH-IGNORE-CASE   TO TRUE
           SET GRID-SEARCH-FORWARDS      TO TRUE
           SET GRID-SEARCH-WRAP          TO TRUE
           SET GRID-SEARCH-MATCH-ANY     TO TRUE
           SET GRID-SEARCH-ALL-DATA      TO TRUE                                                        
           SET GRID-SEARCH-SKIP-CURRENT  TO TRUE
           SET GRID-SEARCH-MOVES-CURSOR  TO TRUE
           
           MODIFY grid-1, SEARCH-OPTIONS = GRID-SEARCH-OPTIONS

           inquire Screen1-Ef-1, VALUE ws-Search-String
           
           inquire grid-1, CURSOR-Y IN ws-current-row,
                           CURSOR-X IN ws-current-col 
           
           modify grid-1, X = ws-current-col, Y = ws-current-row  
                          SEARCH-TEXT = ws-Search-String 
                          GIVING ws-search-result

           if ws-search-result = GRDSRCH-NOT-FOUND
              display message box "NOT FOUND",
                                  ICON IS MB-WARNING-ICON
           else
              modify grid-1, X = ws-current-col, Y = ws-current-row
                            CELL-COLOR = 0
                            
              inquire grid-1, CURSOR-Y IN ws-current-row,
                             CURSOR-X IN ws-current-col 
              |modify grid-1,  X = ws-current-col, Y = ws-current-row  
              |                CELL-COLOR = 480     
                                                               
           end-if                                           
           .
      *
CCCCCC* END   
      * 