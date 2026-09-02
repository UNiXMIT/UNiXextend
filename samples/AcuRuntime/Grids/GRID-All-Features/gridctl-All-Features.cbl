       identification division.
CC1040* program-id.  gridctl.
CC1040 program-id.  gridctl-All-Features.
       
CC1040* Modified by ccontardi, Dec 2020 > Jan 2021
CC1040* Adding 10.4.0 features regarding ECN-4697 - MOVEABLE-COLUMNS (and others)
CC1040* 
CC1040* ccbl32 -ga -sx 1050 gridctl-All-Features.cbl
CC1040* 

CC1030* Modified by ccontardi, Apr 2022
CC1030* Adding 10.3.0 feature for Column Sorting

CC1050* Modified by ccontardi, Apr 2022
CC1050* Adding 10.5.0 features regarding ECN-4756 - ADJUSTABLE-ROWS (and others)

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

       copy "acucobol.def".
       copy "acugui.def".
       copy "crtvars.def".
       copy "controls.def".
       copy "opensave.def".
       copy resource "littlegt.bmp".

      * Constants

CC1040 78  max-rows                          value 21. | 18.
       78  max-cols                          value 7.

      * Crt-Status

       77  key-status is special-names crt status pic 9(4) value 0.
         88  exit-pressed                    value 10.
         88  about-pressed                   value 15.
         88  Event-Occurred                  value 96.
         88  exit-about-screen               value 201.
CC1040   88  adjustable-cols-pressed         value 701.
CC1040   88  moveable-pressed                value 702.
CC1040   88  hide-pressed                    value 703.
CC1040   88  move-back-pressed               value 704.
CC1040   88  move-forward-pressed            value 705.
CC1040   88  reset-pressed                   value 706.
CC1040   88  search-pressed                  value 707.
CC1040   88  storeable-pressed               value 708.
CC1040   88  inquire-pressed                 value 709.
CC1030   88  ascending-sort-pressed          value 710.
CC1030   88  descending-sort-pressed         value 711.
CC1050   88  adjustable-rows-pressed         value 712.
CC1050   88  cent-row-head-pressed           value 713.
CC1050   88  wrap-text-pressed               value 714.
CC1050   88  valignment-changed              value 715.

      * Handles

       77  window-0                          handle of window.
       77  window-1                          handle of window.
       77  about-thread                      handle of thread.
       77  grid-menu                         handle of menu.
       77  gt-bitmap                         pic s9(9) comp-4.
CC1040 77  Screen1-St-1-Handle USAGE IS HANDLE OF STATUS-BAR.

      * Data Items for Screen Handling

       77  ctr                               pic 99    value 0.
       77  grid-y                            pic 99    value 0.
         88 in-column-headings                         value 1.
       77  grid-x                            pic 99    value 0.
         88 in-row-headings                            value 1.
       77  bmp-num                           pic 99    value 0.
       77  scratch                           pic x(80) value spaces.
CC1040 77 ws-is-adjustable-cols              PIC S9(1) VALUE 0.  
CC1050 77 ws-is-adjustable-rows              PIC S9(1) VALUE 0.  
CC1040 77 ws-is-moveable                     PIC S9(1) VALUE 0.  
CC1040 77 ws-is-storeable                    PIC S9(1) VALUE 1. 
CC1040 77 ws-is-enabled                      pic 9     value 0.
CC1050 77 ws-is-1050-enabled                 pic 9     value 0.
CC1050 77 ws-is-WrapText                     PIC S9(1) VALUE 0.
CC1050 77 ws-is-VAlignment                   PIC S9(1) VALUE 0.
CC1050 77 ws-is-CentRowHead                  PIC S9(1) VALUE 0.
CC1040 77 ws-counter                         pic 99    value 0.
CC1040 77 ws-st-content                      PIC x(110) value spaces.
CC1040 77 ws-Search-String                   pic x(20) value spaces.
CC1040 77 ws-Cell-String                     pic x(40) value spaces.
CC1040 77 ws-current-col                     PIC 9(3)  value 0.
CC1040 77 ws-current-row                     PIC 9(3)  value 0.
CC1040 77 ws-current-logical-col             PIC 9(3)  value 0.
CC1040 77 ws-current-phys-col                PIC 9(3)  value 0.
CC1050 77 ws-current-cell-wrap-text          PIC 9(3)  value 0.
CC1050 77 ws-current-cell-valignment         PIC x.
CC1050 77 ws-current-CentRowHead             PIC 9(3)  value 0.
CC1040 77 ws-search-result                   PIC 9     value 0.
CC1040 77 Screen1-Cm-HdShCols-Value          PIC x(10).       
CC1040 77 Screen1-Cm-MvCols-Value            PIC x(10).  
CC1030 77 Screen1-Cm-Sort-Value              PIC x(10).   
CC1050 77 Screen1-Cm-VAlignment-Value        PIC x(10).   
CC1040 77 ws-hiding-logical-col              PIC  9(3) value 0. 
CC1040 77 ws-logical-col-from                PIC  9(3) value 0. 
CC1040 77 ws-logical-col-to                  PIC  9(3) value 0. 
CC1040 77 ws-phys-col-no-sign                PIC  9(3) value 0. 
CC1040 77 ws-phys-col-temp-val               PIC S9(3). 
CC1030 77 ws-logical-col-temp-val            PIC S9(3).
CC1040 77 ws-num-rows                        PIC S9(3) value -1.
CC1040 77 ws-num-row-headings                PIC  9(3) value 1. 
CC1040 77 ws-first-usable-col                PIC  9(3) value 1. 
CC1040 77 ws-registry-key                    PIC  X(100) value 
CC1040                  "Micro Focus\extend 10.5.0\GRID-All-Features".

CC1040 01 Screen1-CmBox-Container-Item.
          05 PIC X(10) VALUE spaces.
          05 PIC X(10) VALUE "CATEGORY".
          05 PIC X(10) VALUE "AUTHOR".
          05 PIC X(10) VALUE "NAME".
          05 PIC X(10) VALUE "TITLE".
          05 PIC X(10) VALUE "PUBLISHER".
          05 PIC X(10) VALUE "DATE".
CC1040 01 Screen1-CmBox-Container REDEFINES 
           Screen1-CmBox-Container-Item PIC X(10) OCCURS max-cols TIMES.

CC1040 01 Screen1-Physical-Table.                                          | This will store the Physical information about the Grid
          03 Screen1-Physical-Table-Item OCCURS max-cols TIMES.            | I use its index when I need to refer to the Logical position of the columns
             05 ws-phys-descr PIC X(10).
             05 ws-phys-col   PIC S9(3).
             
CC1050 01 Screen1-CmBox-VAlignment-Container-Item.
          05 PIC X(10) VALUE spaces.
          05 PIC X(10) VALUE "Top   ".
          05 PIC X(10) VALUE "Center".
          05 PIC X(10) VALUE "Bottom".
CC1050 01 Screen1-CmBox-VAlignment-Container REDEFINES 
           Screen1-CmBox-VAlignment-Container-Item PIC X(10) 
                                             OCCURS 4 TIMES.             

      * Grid Data

       01 grid-data-table.
         05 filler                           pic x(120)
CC1040     value "  CAT.(2)         AUTH.(3) NAME (4)       TITLE (5)
CC1040-    "                         PUBLISHER (6)             DATE (7)"
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
CC1040   05 filler                           pic x(120)
CC1040     value "18Space Opera     Soule    Charles        Light of the
CC1040-    " Jedi                    Century                   05/01/202
CC1040-    "1".
CC1040   05 filler                           pic x(120)
CC1040     value "19Science Fiction SchätzingFrank          Limit
CC1040-    "                         Kiepenheuer & Witsch      05/10/200
CC1040-    "9".
CC1040   05 filler                           pic x(120)
CC1040     value "20Horror          Simmons  Dan            Summer of Ni
CC1040-    "ght                      Putnam Pub Group          01/01/199
CC1040-    "1".

       01 grid-data-tbl redefines grid-data-table.
         05 grid-record occurs max-rows times      pic x(120).
      *
       screen section.
       01 main-screen.
CC1040*                exception procedure exception-handler.              | This wasn't updatating ws-is-adjustable-cols and ws-is-moveable in time

CC1050* ROW-HEIGHTS
CC1050* This property sets the heights of rows in the grid. 
CC1050* It accepts an array of positive, non-zero integers. Heights are specified in units of lines of text. 
CC1050* If the number of rows is greater than the size of the array given to this property, the remaining rows will default to a height of 1 line. 
CC1050* 
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
CC1040       |  adjustable-columns
CC1040       |  moveable-columns
CC1050       |  adjustable-rows
CC1050       |  row-heights        = ( 1, 2, 3, 4, 5 )
               use-tab
               column-headings
               row-headings
               centered-headings
               tiled-headings
               pop-up menu          grid-menu
               event procedure is   grid-1-handler
CC1040         NUM-ROWS             ws-num-rows
CC1040         NUM-ROW-HEADINGS     ws-num-row-headings
CC1040         VSCROLL
CC1040         HSCROLL                                                     | I am trying to add HSCROLL here, as it does not appear automatically.
CC1040         REGISTRY-KEY = ws-registry-key
               .
      *
CC1040* BEGINNING OF NEW CODE   
      *
           03 Screen1-Ef-Search, Entry-Field, 
               line 23, col 5, 
               LINES 1.2 CELLS, SIZE 14 CELLS,  
               BOXED, VALUE ws-Search-String.   
           03 Screen1-Pb-Search, push-button,
               line 23, col 20,
               LINES 1.2 CELLS, size 10 cells
               title "SEARCH",
               self-act,
               exception-value    = 707.  
      *
           03 Screen1-Pb-Inquire, push-button,
               line 23, col 32, 
               LINES 1.2 CELLS, SIZE 25 CELLS, 
               title "INQUIRE CELL",
               self-act,
               exception-value    = 709.   
      *
CC1030     03 Screen1-La-Sort, Label, 
CC1030         line 23, col 80,
CC1030         LINES 1.2 CELLS, SIZE 12 CELLS, 
CC1030         TITLE "Sort column"
CC1030         ENABLED 1.     
CC1030     03 Screen1-Cm-Sort, Combo-Box,
CC1030         line 23.1, col 92,
CC1030         LINES 11.10 CELLS, SIZE 15 CELLS, 
CC1030         3-D, DROP-DOWN, UNSORTED, 
CC1030         VALUE Screen1-Cm-Sort-Value
CC1030         ENABLED 1. 
CC1030     03 Screen1-Pb-SortAsc, push-button,
CC1030         line 23, col 108,
CC1030         LINES 1.2 CELLS, size 6 cells
CC1030         title "A>Z",
CC1030         self-act,
CC1030         exception-value    = 710
CC1030         ENABLED 1. 
CC1030     03 Screen1-Pb-SortDesc, push-button,
CC1030         line 23, col 115,
CC1030         LINES 1.2 CELLS, size 6 cells
CC1030         title "Z>A",
CC1030         self-act,
CC1030         exception-value    = 711
CC1030         ENABLED 1.          
      *
           03 Screen1-Cb-AdjCols, Check-Box,
               line 26, col 5, 
               LINES 1.2 CELLS, SIZE 25 CELLS, 
               EXCEPTION-VALUE 701,
               NOTIFY,
               SELF-ACT, 
               | TEXT-ONLY,
               TITLE "ADJUSTABLE-COLUMNS", 
               VALUE ws-is-adjustable-cols. 
      *        
           03 Screen1-La-HdShCols, Label, 
               line 26, col 32,
               LINES 1.2 CELLS, SIZE 17 CELLS, 
               TITLE "Hide/Show column"
               ENABLED ws-is-enabled.     
           03 Screen1-Cm-HdShCols, Combo-Box,
               line 26.1, col 49,
               LINES 11.10 CELLS, SIZE 15 CELLS, 
               3-D, DROP-DOWN, UNSORTED, 
               VALUE Screen1-Cm-HdShCols-Value
               ENABLED ws-is-enabled. 
           03 Screen1-Pb-HdShCols, push-button,
               line 26, col 66,
               LINES 1.2 CELLS, size 6 cells
               title "GO",
               self-act,
               exception-value    = 703
               ENABLED ws-is-enabled.                 
      *
CC1050     03  Frame, rimmed,
CC1050         line 25, col 80,
CC1050         LINES 8 CELLS, SIZE 41 CELLS, 
CC1050         TITLE "New 10.5.0 features".      
CC1050
CC1050     03 Screen1-Cb-AdjRows, Check-Box,
CC1050         line 26, col 81.5, 
CC1050         LINES 1.2 CELLS, SIZE 25 CELLS, 
CC1050         EXCEPTION-VALUE 712,
CC1050         NOTIFY,
CC1050         SELF-ACT, 
CC1050         | TEXT-ONLY,
CC1050         TITLE "ADJUSTABLE-ROWS", 
CC1050         VALUE ws-is-adjustable-rows
CC1050         ENABLED ws-is-1050-enabled.  
CC1050      
CC1050     03 Screen1-Cb-CentRowHead, Check-Box,
CC1050         line 27, col 81.5, 
CC1050         LINES 1.2 CELLS, SIZE 30 CELLS, 
CC1050         EXCEPTION-VALUE 713,
CC1050         NOTIFY,
CC1050         SELF-ACT, 
CC1050         | TEXT-ONLY,
CC1050         TITLE "CENTERED-ROW-HEADINGS", 
CC1050         VALUE ws-is-CentRowHead
CC1050         ENABLED ws-is-1050-enabled.                 
CC1050 
CC1050     03 Screen1-La-SetRows, Label, 
CC1050         line 29, col 81.5,
CC1050         LINES 1.2 CELLS, SIZE 35 CELLS, 
CC1050         TITLE "Select a CELL to apply the following:"
CC1050         ENABLED ws-is-1050-enabled.         
CC1050      
CC1050     03 Screen1-Cb-WrapText, Check-Box,
CC1050         line 30, col 81.5, 
CC1050         LINES 1.2 CELLS, SIZE 25 CELLS, 
CC1050         EXCEPTION-VALUE 714,
CC1050         NOTIFY,
CC1050         SELF-ACT, 
CC1050         | TEXT-ONLY,
CC1050         TITLE "WRAP-TEXT", 
CC1050         VALUE ws-is-WrapText
CC1050         ENABLED ws-is-1050-enabled.         
CC1050      
CC1050     03 Screen1-La-VAlignment, Label, 
CC1050         line 31.1, col 81.5,
CC1050         LINES 1.2 CELLS, SIZE 12 CELLS, 
CC1050         TITLE "VALIGNMENT"
CC1050         ENABLED ws-is-1050-enabled.         
CC1050              
CC1050     03 Screen1-Cm-VAlignment, Combo-Box,
CC1050         line 31.2, col 94,
CC1050         LINES 11.10 CELLS, SIZE 15 CELLS, 
CC1050         3-D, DROP-DOWN, UNSORTED, 
CC1050         VALUE Screen1-Cm-VAlignment-Value
CC1050         ENABLED ws-is-1050-enabled
CC1050         EXCEPTION-VALUE 715
CC1050         NOTIFY-SELCHANGE.  




BACKUP*     03 Screen1-Cb-VAlignment, Label |Check-Box,
BACKUP*         line 31, col 81.5, 
BACKUP*         LINES 1.2 CELLS, SIZE 25 CELLS, 
BACKUP*        | EXCEPTION-VALUE 715,
BACKUP*        | NOTIFY,
BACKUP*        | SELF-ACT, 
BACKUP*         | TEXT-ONLY,
BACKUP*         TITLE "VALIGNMENT", 
BACKUP*        | VALUE ws-is-VAlignment
BACKUP*         ENABLED ws-is-1050-enabled.           
    
CC1050     
      *
           03 Screen1-Cb-MvCols, Check-Box,
               line 28, col 5, 
               LINES 1.2 CELLS, SIZE 25 CELLS, 
               EXCEPTION-VALUE 702,
               NOTIFY,
               SELF-ACT, 
               | TEXT-ONLY,
               TITLE "MOVEABLE-COLUMNS", 
               VALUE ws-is-moveable.
      *        
           03 Screen1-La-MvCols, Label, 
               line 28, col 32,
               LINES 1.2 CELLS, SIZE 12 CELLS, 
               TITLE "Move column"
               ENABLED ws-is-enabled.    
           03 Screen1-Pb-MvColsBk, push-button,
               line 28, col 44,
               LINES 1.2 CELLS, size 6 cells
               title "<<<",
               self-act,
               exception-value    = 704
               ENABLED ws-is-enabled.     
           03 Screen1-Cm-MvCols, Combo-Box,
               line 28.1, col 51,
               LINES 11.10 CELLS, SIZE 15 CELLS, 
               3-D, DROP-DOWN, UNSORTED, 
               VALUE Screen1-Cm-MvCols-Value
               ENABLED ws-is-enabled.   
           03 Screen1-Pb-MvColsFw, push-button,
               line 28, col 67,
               LINES 1.2 CELLS, size 6 cells
               title ">>>",
               self-act,
               exception-value    = 705
               ENABLED ws-is-enabled.     
      *   
           03 Screen1-Cb-Store, Check-Box,
               line 30, col 5, 
               LINES 1.2 CELLS, SIZE 40 CELLS, 
               EXCEPTION-VALUE 708,
               NOTIFY,
               SELF-ACT, 
               | TEXT-ONLY,
               TITLE "Store your customizations for a future use", 
               VALUE ws-is-storeable
               ENABLED ws-is-enabled.     
      *
           03 Screen1-Pb-Reset, push-button,
               line 33.5, col 5, 
               LINES 1.2 CELLS, SIZE 25 CELLS, 
               title "RESET GRID",
               self-act,
               exception-value    = 706.      
      *
CC1040* END
      *
         05 about-pb, push-button,
               line 33.5, col 98,
CC1040         LINES 1.2 CELLS,
               size 14 cells
               title "&About",
               self-act,
               exception-value    = 15
CC1050         visible = 0.

         05 push-button,
               line 33.5, col 114,
CC1040         LINES 1.2 CELLS,
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
           SET EXCEPTION 1 TO SELECT-ALL-SELECTION.  
           SET EXCEPTION 3 TO COPY-SELECTION.  
           SET EXCEPTION 22 TO PASTE-SELECTION.  
           SET EXCEPTION 24 TO CUT-SELECTION.  
           SET EXCEPTION 26 TO UNDO.  
           display standard graphical window,
                   title "Grid Control Demo - 10.4.0 Grid New Features",
                   size 130, 
CC1040             lines 35, |25, 
CC1040             RESIZABLE
CC1040             AUTO-RESIZE
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

CC1040     DISPLAY STATUS-BAR
CC1040        PANEL-WIDTHS 128, 
CC1040        PANEL-STYLE 1, 
CC1040        PANEL-TEXT ws-st-content, 
CC1040        GRIP, 
CC1040        HANDLE IS Screen1-St-1-Handle

CC1050     move 1 to ws-is-1050-enabled.                                   | 1050 10.5.0

           display main-screen.
           perform load-grid.
CC1040*    perform thread animate-bitmap.                                  | THREAD thread suspended until the following is fixed: OCTCR50A27039 - AcuThin: When a thread updates the UI, mouse clicks can be lost           
                
CC1040     MODIFY Screen1-Cm-HdShCols, ITEM-TO-ADD = TABLE 
                                       Screen1-CmBox-Container
CC1040     MODIFY Screen1-Cm-MvCols, ITEM-TO-ADD = TABLE 
                                     Screen1-CmBox-Container
CC1030     MODIFY Screen1-Cm-Sort, ITEM-TO-ADD = TABLE 
                                   Screen1-CmBox-Container
                                   
CC1050     MODIFY Screen1-Cm-VAlignment, ITEM-TO-ADD = TABLE               | 1050 10.5.0
                                   Screen1-CmBox-VAlignment-Container      | 1050 10.5.0
                                
CC1040     perform load-initial-Screen1-Physical-Table      

CC1040     add 1 to ws-num-row-headings giving ws-first-usable-col         | NUM-ROW-HEADINGS - Row Header cannot be hidden, nor moved                   

           perform, with test after, until exit-pressed
CC1040*       accept main-screen on exception continue end-accept          | This wasn't updatating ws-is-adjustable-cols and ws-is-moveable in time
CC1040       accept main-screen on exception 
                perform exception-handler
             end-accept             
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
           
CC1040 load-initial-Screen1-Physical-Table.     
           perform varying ws-counter from 1 by 1 
                   until ws-counter > max-cols 
              move ws-counter to ws-phys-col(ws-counter)
              move Screen1-CmBox-Container(ws-counter) 
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
               
CC1040       when adjustable-cols-pressed
      * Grids that have ADJUSTABLE-COLUMNS specified will now allow columns to be fully 
      * hidden by dragging the trailing divider to the beginning of the column.  
      * (Previously this would result in a "width 1" column, now it hides the column entirely).  
      * With ADJUSTABLE-COLUMNS set, a small mark will appear at the top of any hidden column.  
      * Clicking this mark will restore the column to its prior size.  
      *
               if ws-is-adjustable-cols = 1
                  modify grid-1, adjustable-columns
                  initialize ws-st-content
                  string "You can adjust size and hide columns, now. "
                       into ws-st-content
                  modify Screen1-St-1-Handle, PANEL-TEXT ws-st-content
                  modify Screen1-La-HdShCols, enabled = 1
                  modify Screen1-Cm-HdShCols, enabled = 1
                  modify Screen1-Pb-HdShCols, enabled = 1
                  modify Screen1-Cb-Store,    enabled = 1
               else   
                  modify grid-1, not adjustable-columns
                  initialize ws-st-content 
                  modify Screen1-St-1-Handle, PANEL-TEXT ws-st-content
                  modify Screen1-La-HdShCols, enabled = 0
                  modify Screen1-Cm-HdShCols, enabled = 0
                  modify Screen1-Pb-HdShCols, enabled = 0
                  if ws-is-moveable = 0 
                     and ws-is-adjustable-rows = 0                              | 1050 10.5.0
                    | move 0 to ws-is-storeable
                    | perform set-registry-key
                     modify Screen1-Cb-Store, enabled = 0
                                              value   = ws-is-storeable
                  end-if
               end-if
               
CC1040       when moveable-pressed
      * MOVEABLE-COLUMNS is a new style introduced in 10.4.0. 
      * Without this, users will not be able to move by dragging the column.
      * When columns can be moved, the user can drag a column header to a new location. 
      * While moving, a dark area the size of the column header will drag with the mouse, 
      * and when getting to a valid drop location, will display two red arrows (one pointing up, 
      * one pointing down) at the column separator where the column will move to.
      *
               if ws-is-moveable = 1
                  modify grid-1, moveable-columns
                  initialize ws-st-content 
                  string "You can move columns, now. "
                       into ws-st-content
                  modify Screen1-St-1-Handle, PANEL-TEXT ws-st-content
                  modify Screen1-La-MvCols,   enabled = 1
                  modify Screen1-Cm-MvCols,   enabled = 1
                  modify Screen1-Pb-MvColsBk, enabled = 1
                  modify Screen1-Pb-MvColsFw, enabled = 1
                  modify Screen1-Cb-Store,    enabled = 1
               else   
                  modify grid-1, not moveable-columns
                  initialize ws-st-content 
                  modify Screen1-St-1-Handle, PANEL-TEXT ws-st-content
                  modify Screen1-La-MvCols,   enabled = 0
                  modify Screen1-Cm-MvCols,   enabled = 0
                  modify Screen1-Pb-MvColsBk, enabled = 0
                  modify Screen1-Pb-MvColsFw, enabled = 0
                  if ws-is-adjustable-cols = 0 
                     and ws-is-adjustable-rows = 0                              | 1050 10.5.0
                    | move 0 to ws-is-storeable
                    | perform set-registry-key
                     modify Screen1-Cb-Store, enabled = 0, 
                                              value   = ws-is-storeable
                  end-if
               end-if
               
CC1040       when hide-pressed
                  perform hide-unhide-column
                  
CC1040       when move-back-pressed
                  perform move-column-back
                  
CC1040       when move-forward-pressed
                  perform move-column-forward
                                                     
CC1040       when reset-pressed
                  perform reset-columns
                                                     
CC1040       when search-pressed
                  perform search-grid
                                                     
CC1040       when inquire-pressed
                  perform inquire-cell
                                                     
CC1040       when storeable-pressed
                  perform set-registry-key
                                                     
CC1030       when ascending-sort-pressed
                  perform sort-column-ascending
                                                     
CC1030       when descending-sort-pressed
                  perform sort-column-descending
                                                     
CC1050       when adjustable-rows-pressed                                       | 1050 10.5.0
      * ADJUSTABLE-ROWS is a new style introduced in 10.5.0. 
      * This style enables the adjustment of row heights by dragging row dividers using the mouse. 
      * If the ROW-HEADINGS style is also enabled, 
      * the row dividers will only be draggable within the row headings column.
      * This style is set when declaring the grid in the screen section.
      * Resized row heights can be stored in the registry, in the same manner as 
      * resized column widths are when the ADJUSTABLE-COLUMNS style is enabled.
      *
               if ws-is-adjustable-rows = 1                                     | 1050 10.5.0
                  modify grid-1, adjustable-rows                                | 1050 10.5.0
                  initialize ws-st-content                                      | 1050 10.5.0
                  string "You can adjust the height of the rows, now. "         | 1050 10.5.0
                       into ws-st-content                                       | 1050 10.5.0
                  modify Screen1-St-1-Handle, PANEL-TEXT ws-st-content          | 1050 10.5.0
                  modify Screen1-Cb-Store,    enabled = 1                       | 1050 10.5.0
               else                                                             | 1050 10.5.0
                  modify grid-1, not adjustable-rows                            | 1050 10.5.0
                  initialize ws-st-content                                      | 1050 10.5.0
                  modify Screen1-St-1-Handle, PANEL-TEXT ws-st-content          | 1050 10.5.0
                  if ws-is-moveable = 0                                         | 1050 10.5.0
                     and ws-is-adjustable-cols = 0                              | 1050 10.5.0
                     modify Screen1-Cb-Store, enabled = 0                       | 1050 10.5.0
                                              value   = ws-is-storeable         | 1050 10.5.0
                  end-if                                                        | 1050 10.5.0
               end-if                                                           | 1050 10.5.0
                  
CC1050       when cent-row-head-pressed                                         | 1050 10.5.0
                  perform apply-CentRowHead                                     | 1050 10.5.0  
                                                     
CC1050       when wrap-text-pressed                                             | 1050 10.5.0
                  perform apply-wrap-text                                       | 1050 10.5.0    
                                                     
CC1050       when Event-Occurred
                  evaluate Event-Type
                     when NTF-SELCHANGE
                          perform apply-new-valignment
                  end-evaluate          
                  
           end-evaluate.

      * We have selected a subset of the GRID control's events, and
      * programmed responses to them.  In each case, the programmed response
      * is that a color change occur, and that the color change affect a
      * prescribed range of cells in the GRID.

       grid-1-handler.
           evaluate event-type
             when MSG-GRID-RBUTTON-DOWN
                display message "MSG-GRID-RBUTTON-DOWN EVENT"
             when msg-goto-cell             
             when msg-goto-cell-mouse
                 modify grid-1, region-color = 0
CC1040           modify grid-1, X = ws-current-col, Y = ws-current-row
CC1040                          CELL-COLOR = 0
CC1050           perform verify-cell-settings                                   | 1050 10.5.0

             when msg-bitmap-clicked
                 call "w$menu" using wmenu-popup, grid-menu

             when msg-goto-cell-drag
                 modify grid-1,
                   drag-color = bright-white + bckgrnd-red
                   
CC1040       when MSG-COLUMN-SHOW   
                 perform update-hidden-columns      
                   
CC1040       when MSG-COLUMN-MOVED   
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
CC1040* BEGINNING OF NEW CODE   
      *
       hide-unhide-column.
           perform varying ws-counter from ws-first-usable-col by 1
                   until ws-counter > max-cols
              if ws-phys-descr(ws-counter) = Screen1-Cm-HdShCols-Value    
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
      *
           move Event-data-2 to ws-hiding-logical-col
           multiply -1 by ws-phys-col(ws-hiding-logical-col)
           .
      *
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
           .
      *
       move-column-back.   
           initialize ws-logical-col-from ws-logical-col-to               
           perform varying ws-counter from max-cols by -1 
                   until ws-counter < ws-first-usable-col 
              if ws-phys-descr(ws-counter) = Screen1-Cm-MvCols-Value 
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
           perform varying ws-counter from ws-first-usable-col by 1 
                   until ws-counter > max-cols
              if ws-phys-descr(ws-counter) = Screen1-Cm-MvCols-Value 
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
           modify grid-1, RESET-GRID 1
                
           perform load-grid
           
           perform load-initial-Screen1-Physical-Table   
           
           MODIFY grid-1, PHYSICAL-COLUMNS (0,
                                            ws-phys-col(1),
                                            ws-phys-col(2),
                                            ws-phys-col(3),
                                            ws-phys-col(4),
                                            ws-phys-col(5),
                                            ws-phys-col(6),
                                            ws-phys-col(7))
             display-columns = ( 1, 4, 20, 32, 46, 85, 111 )
             virtual-width   = 124 
CC1050       row-heights     = ( 0 )                                            | 1050 10.5.0           
                                            
           initialize ws-st-content
           modify Screen1-St-1-Handle, PANEL-TEXT ws-st-content                       
           .
      *
       search-grid.   
      * When a column is hidden, explicitly moving the cursor to that column via CURSOR-X or CURSOR-PHYS-X
      * will reveal the column.  Also, if SEARCH-TEXT finds a value in a hidden column and positions the
      * cursor there, the column will be revealed.  
      * In general, the grid will not allow the cursor to occupy a hidden column.  
      *
           inquire Screen1-Ef-Search, VALUE ws-Search-String
           
           if ws-Search-String not = spaces     

              inquire grid-1, SEARCH-OPTIONS in GRID-SEARCH-OPTIONS

              SET GRID-SEARCH-IGNORE-CASE   TO TRUE
              SET GRID-SEARCH-FORWARDS      TO TRUE
              SET GRID-SEARCH-WRAP          TO TRUE
              SET GRID-SEARCH-MATCH-ANY     TO TRUE
              SET GRID-SEARCH-ALL-DATA      TO TRUE                                                        
              SET GRID-SEARCH-SKIP-CURRENT  TO TRUE
              SET GRID-SEARCH-MOVES-CURSOR  TO TRUE
           
              MODIFY grid-1, SEARCH-OPTIONS = GRID-SEARCH-OPTIONS
           
              inquire grid-1, CURSOR-Y IN ws-current-row,
                              CURSOR-X IN ws-current-col 
           
              modify grid-1, X = ws-current-col, Y = ws-current-row  
                             SEARCH-TEXT = ws-Search-String 
                             GIVING ws-search-result

              if ws-search-result = GRDSRCH-NOT-FOUND
                 display message box ws-Search-String
                                     x"0d0a"
                                     "NOT FOUND",
                                     icon is MB-WARNING-ICON
              else
                 modify grid-1, X = ws-current-col, Y = ws-current-row
                               CELL-COLOR = 0
                            
                 inquire grid-1, CURSOR-Y IN ws-current-row,
                                 CURSOR-X IN ws-current-col 
                 |modify grid-1,  X = ws-current-col, Y = ws-current-row  
                 |                CELL-COLOR = 480     
                                                               
              end-if  
                                                        
           end-if                                          
           .
      *
       inquire-cell.   
      * CURSOR-PHYS-X is a new property that corresponds to the physical column the cursor occupies 
      * (CURSOR-X corresponds to the logical column instead).  
      * When either CURSOR-PHYS-X or CURSOR-X is set, both properties are updated appropriately 
      * after the cursor is moved.
      *
           inquire grid-1, CURSOR-Y      IN ws-current-row
                           CURSOR-X      IN ws-current-logical-col
                           CURSOR-PHYS-X IN ws-current-phys-col   
                           
           modify grid-1, Y = ws-current-row               
                          X = ws-current-logical-col   
                                
           inquire grid-1, CELL-DATA IN ws-Cell-String
           
           display message box ws-Cell-String
                               x"0d0a"
                               "at row " ws-current-row  
                               " (header included)"
                               x"0d0a"
                               "physical column " ws-current-phys-col
                               x"0d0a"        
                               "logical column " ws-current-logical-col    
           .
      *
       set-registry-key.   
      * REGISTRY-KEY is a new property. 
      * By setting this, the runtime will store information about the user's modifications to the grid 
      * (sort-column, physical-columns, column widths) in the registry, 
      * and load those again when a COBOL program with the same key name is run. 
      * (Hopefully, this will be unique for each grid in your application.) 
      * If the number of columns in the grid doesn't match the number of columns stored in the registry, 
      * the values in the registry are ignored. 
      * This should be one of the last properties to be set, 
      * because when the runtime is notified that this property is set is when it actually loads the values.   
      *
      * As of the time of this writing (December 2020), Microsoft’s recommended key name follows this pattern:
      * HKEY_CURRENT_USER\Software\company\product\version\...
      * where "..."" would be some unique name for the particular grid (perhaps program-name\grid-name).  
      * Example:
      * REGISTRY-KEY = "MyCompany\MyProduct\1.0\CUSTMAINT\Shipping Grid"      
      *     
      * In AcuToWeb, the new property is managed by saving the data in the localstorage of the page to which it will only be accessible.
      *  
           if ws-is-storeable = 1
              modify grid-1, REGISTRY-KEY = ws-registry-key 
           else
              modify grid-1, REGISTRY-KEY = spaces
           end-if
           .
      *
CC1040* END   
      * 
CC1030 sort-column-ascending.
           perform varying ws-counter from ws-first-usable-col by 1
                   until ws-counter > max-cols
              if Screen1-CmBox-Container(ws-counter) 
                 = Screen1-Cm-Sort-Value    
                 modify grid-1, sort-column = ws-counter
              end-if
           end-perform
CC1030     .  
      * 
CC1030 sort-column-descending.
           perform varying ws-counter from ws-first-usable-col by 1
                   until ws-counter > max-cols
              if Screen1-CmBox-Container(ws-counter) 
                 = Screen1-Cm-Sort-Value   
                 multiply ws-counter by -1 
                          giving ws-logical-col-temp-val
                 modify grid-1, sort-column = ws-logical-col-temp-val
              end-if
           end-perform
CC1030     .  
      *   
CC1050 apply-CentRowHead.   
      * CENTERED-ROW-HEADINGS
      * This style, when enabled, vertically centers the grid's row headings.
      * This style is set when declaring the grid in the screen section. 
      * This style has no effect if the ROW-HEADINGS style is not also enabled.              
      * 
           if ws-is-CentRowHead = 0                                             | 1050 10.5.0
              modify grid-1, not CENTERED-ROW-HEADINGS                          | 1050 10.5.0
           else                                                                 | 1050 10.5.0 
              modify grid-1, CENTERED-ROW-HEADINGS                              | 1050 10.5.0 
           end-if                                                               | 1050 10.5.0 
CC1050     .     
      *        
CC1050 verify-cell-settings.
      * Inquire the current status of the cell for wrap-text and valignement    | TODO TO DO
      * Then update the check-boxes for each click on a cell                    | TODO TO DO
      * Currently, I am cleaning the screen controls as these properties are CELL-wise.
      *
           modify Screen1-Cb-WrapText,   value = 0                              | 1050 10.5.0   
           modify Screen1-Cm-VAlignment, value = spaces                         | 1050 10.5.0         
CC1050     .      
      * 
CC1050 apply-wrap-text.
      * WRAP-TEXT
      * This property enables or disables text wrapping within a cell. 
      * Accepted values are 1 (enabled) or 0 (disabled). 
      * This property is targeted at a cell after the grid has been loaded, 
      * using a "modify" statement, similarly to the existing "CELL-DATA" and "CELL-COLOR" properties. 
      * WRAP-TEXT is set to 0 (disabled) by default in all cells.
      * The WRAP-TEXT property cannot be enabled if the targeted cell also has a VALIGNMENT property which is set to "B" or "C". 
      * VALIGNMENT takes precedence if this conflict should occur, and WRAP-TEXT will be set to 0 (disabled).
      * Text wrapping is when text, which is wider than the width of the column its cell occupies, 
      * is split across multiple lines to reduce its width.
      * 
           inquire grid-1, CURSOR-Y      IN ws-current-row                      | 1050 10.5.0
                           CURSOR-X      IN ws-current-logical-col              | 1050 10.5.0
                           CURSOR-PHYS-X IN ws-current-phys-col                 | 1050 10.5.0
                           WRAP-TEXT     IN ws-current-cell-wrap-text           | 1050 10.5.0
           
           if ws-current-cell-wrap-text = 0                                     | 1050 10.5.0
              modify grid-1, Y = ws-current-row                                 | 1050 10.5.0   
                             X = ws-current-phys-col                            | 1050 10.5.0
                             WRAP-TEXT = 1                                      | 1050 10.5.0
           else                                                                 | 1050 10.5.0
              modify grid-1, Y = ws-current-row                                 | 1050 10.5.0
                             X = ws-current-phys-col                            | 1050 10.5.0
                             WRAP-TEXT = 0                                      | 1050 10.5.0
           end-if                                                               | 1050 10.5.0
CC1050     .     
      * 
CC1050 apply-new-valignment.
      * VALIGNMENT
      * This property sets the vertical alignment of text within the targeted cell. 
      * Accepted values are "T" (top aligned), "B" (bottom aligned), "C" (vertically center aligned) or "U" (unaligned). 
      * Unaligned is equivalent to top aligned, and is the default setting. 
      * This property is targeted at a cell after the grid has been loaded, using a "modify" statement, 
      * similarly to the existing "CELL-DATA" and "CELL-COLOR" properties.
      * If VALIGNMENT is set to "B" or "C", the WRAP-TEXT property is disabled for that cell. 
      * VALIGNMENT takes precedence when both are present 
      * (i.e. if a cell has the properties VALIGNMENT = "B" and WRAP-TEXT = 1, the WRAP-TEXT property will be treated as if it is set to 0). 
      * 
           inquire grid-1, CURSOR-Y      IN ws-current-row                      | 1050 10.5.0
                           CURSOR-X      IN ws-current-logical-col              | 1050 10.5.0
                           CURSOR-PHYS-X IN ws-current-phys-col                 | 1050 10.5.0
                           VALIGNMENT    IN ws-current-cell-valignment          | 1050 10.5.0
                           
           modify grid-1, Y = ws-current-row                                    | 1050 10.5.0   
                          X = ws-current-phys-col                               | 1050 10.5.0
                          VALIGNMENT = Screen1-Cm-VAlignment-Value(1:1)         | 1050 10.5.0        
                          
           |stop  ws-current-cell-valignment                              
CC1050     .     