       identification division.
       program-id.  gridctl.

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
      * The gridctlsample program has the MOVEABLE-COLUMNS style. This style
      * allowsthe user to move columns. Place the cursor on a column header
      * and drag the column to the left or right. Red arrows appear where
      * you can release the column.

       environment division.
       data division.
       working-storage section.
       
CCCCCC 77 ws-registry-key                    PIC  X(100) value 
CCCCCC    "Micro Focus\extend 10.5.0\gridCtlNew-Storing-ROW-HEIGHTS".       

      * Copybooks

       copy "def/acucobol.def".
       copy "def/acugui.def".
       copy "def/crtvars.def".
       copy "def/controls.def".
       copy "def/opensave.def".
       copy resource "littlegt.bmp".

      * Constants

       78  max-rows                          value 18.
       78  max-cols                          value 7.

      * Crt-Status

       77  key-status is special-names crt status pic 9(4) value 0.
         88  exit-pressed                    value 10.
         88  about-pressed                   value 15.
         88  exit-about-screen               value 201.
         88  issue-0-pressed                 value 90.
         88  issue-1-pressed                 value 91.
         88  issue-2-pressed                 value 92.

      * Handles

       77  window-0                          handle of window.
       77  window-1                          handle of window.
       77  about-thread                      handle of thread.
       77  grid-menu                         handle of menu.
       77  gt-bitmap                         pic s9(9) comp-4.

      * Data Items for Screen Handling

       77  ctr                               pic 99    value 0.
       77  grid-y                            pic 99    value 0.
         88 in-column-headings                         value 1.
       77  grid-x                            pic 99    value 0.
         88 in-row-headings                            value 1.
       77  bmp-num                           pic 99    value 0.
       77  scratch                           pic x(80) value spaces.

      * Grid Data

       01 grid-data-table.
         05 filler                           pic x(120)
           value "  CATEGORY        AUTHOR                  TITLE
      -    "                         PUBLISHER                 DATE".
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

       01 grid-data-tbl redefines grid-data-table.
         05 grid-record occurs max-rows times      pic x(120).
      *
       screen section.
       01 main-screen exception procedure exception-handler.
         03 grid-1, grid,
               line 2.5, col 2,
               size 125, lines 18,
               data-columns       = ( 1, 3, 19, 28, 43, 80, 106)
               display-columns    = ( 1, 4, 20, 32, 46, 85, 111)
               row-heights        = ( 1, 1, 1, 2)                               | 10.5.0
               sort-types         = ("-","X","X","X","X","X","D^")
               halignment         = ("C","C","C","C","C","C","R")
               row-dividers       = (1,3)
               column-dividers    = (2,2,2,2,2,2)
               divider-color      = bright-red
               cursor-color       = 80
               heading-color      = 144
               cursor-frame-width = -1
               vpadding           = 50
               virtual-width      = 124
               adjustable-columns                                               | 10.4.0
               adjustable-rows                                                  | 10.5.0
               moveable-columns
               use-tab
               column-headings
               row-headings
               centered-col-headings
               tiled-headings
               centered-row-headings                                            | 10.5.0
               pop-up menu          grid-menu
               event procedure is   grid-1-handler
CCCCCC         REGISTRY-KEY = ws-registry-key
               .

         05 about-pb, push-button,
               line 23, col 25,
               size 14 cells
               title "&About",
               self-act,
               exception-value    = 15.

         05 push-button,
               line 23, col 41,
               size 14 cells
               title "E&xit",
               self-act,
               exception-value    = 10.
      *
CCCCCC*
         05 push-button,
               line 22, col 57,
               size 40 cells
               title "MODIFY ROW-HEIGHTS = ( 0 )",
               self-act,
               exception-value    = 90.
                     
         05 push-button,
               line 23, col 57,
               size 40 cells
               title "MODIFY ROW-HEIGHTS = ( 3, 3, 3, 3 )",
               self-act,
               exception-value    = 91.
               
         05 push-button,
               line 24, col 57,
               size 40 cells
               title "MODIFY ROW-HEIGHTS = ( 0, 5, 5, 5 )",
               self-act,
               exception-value    = 92.               
CCCCCC*
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
                   title "Grid Control Demo",
                   size 130, lines 25, background-low
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
	  
           display main-screen.
           perform load-grid.
           perform edit-cell.                                                   | 10.5.0
           perform thread animate-bitmap.

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

       edit-cell.
           modify grid-1, x = 2, y = 4,
                          wrap-text = 0,                                        | 10.5.0
                          valignment = "Center",                                | 10.5.0
                          cell-data = "Mystery (Center)"

           modify grid-1, x = 3,
                          valignment = "Bottom",                                | 10.5.0
                          cell-data = "Haddon (Bottom)"

           modify grid-1, x = 4,
                          cell-data = "Mark (Default)"

           modify grid-1, x = 5, 
                          cell-data =
                  "The Curious Incident of The Dog in the Night-Time",
                          wrap-text = 1                                         | 10.5.0

           modify grid-1, x = 6

           modify grid-1, x = 7
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
           move "Hold the Mouse down on a Column Headings" to scratch .
           modify comments-listbox, item-to-add = scratch             .
           move " Drag the Column to the left or right" to scratch    .
           modify comments-listbox, item-to-add = scratch             .
           move " the MOVEABLE_COLUMNS style allows you" to scratch    .
           modify comments-listbox, item-to-add = scratch             .
           move " to move a Column" to scratch    .
           modify comments-listbox, item-to-add = scratch             .
           move " Red arrows appear where you can release" to scratch .
           modify comments-listbox, item-to-add = scratch             .
           move " the column" to scratch    .
           modify comments-listbox, item-to-add = scratch             .
           move "Drag the Mouse down Row Headings" to scratch         .
           modify comments-listbox, item-to-add = scratch             .
           move "Left-click on a Grid Cell, and Drag Mouse" to scratch.
           modify comments-listbox, item-to-add = scratch             .
           move "Click on a Column Heading" to scratch
           modify comments-listbox, item-to-add = scratch             .
           move " the sort indicator will appear" to scratch    .                .
           modify comments-listbox, item-to-add = scratch             .
           move "Click on a Row Heading" to scratch                   .
           modify comments-listbox, item-to-add = scratch             .
           move "Click on a Column Heading Divider, and " to scratch  .
           modify comments-listbox, item-to-add = scratch             .
           move " adjust column width by dragging divider" to scratch .
           modify comments-listbox, item-to-add = scratch             .
           move " you can adjust the column to the point " to scratch .
           modify comments-listbox, item-to-add = scratch             .
           move " where it becomes hidden. A red mark " to scratch    .
           modify comments-listbox, item-to-add = scratch             .
           move " appears in the header.              " to scratch    .
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
CCCCC        when issue-0-pressed  
CCCCC          perform reproduce-issue-0
CCCCC        when issue-1-pressed  
CCCCC          perform reproduce-issue-1
CCCCC        when issue-2-pressed  
CCCCC          perform reproduce-issue-2
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

             when msg-bitmap-clicked
                 call "w$menu" using wmenu-popup, grid-menu

             when msg-goto-cell-drag
                 modify grid-1,
                   drag-color = bright-white + bckgrnd-red

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
CCCCCC*         
       reproduce-issue-0.
           MODIFY grid-1, ROW-HEIGHTS = ( 0 )
           .
           
       reproduce-issue-1.
           MODIFY grid-1, ROW-HEIGHTS = ( 3, 3, 3, 3 )
           .

       reproduce-issue-2.
           MODIFY grid-1, ROW-HEIGHTS = ( 0, 5, 5, 5 )
           .
CCCCCC*      
