       IDENTIFICATION DIVISION.
       PROGRAM-ID.                      gridBitmap.
       AUTHOR.  MIT. 
       REMARKS.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
      *     DECIMAL-POINT IS COMMA.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
      * SELECT

       DATA DIVISION.
       FILE SECTION.
      * FD

       WORKING-STORAGE SECTION.
       77  CTR                               PIC 99 VALUE 0.
       78  MAX-ROWS                          VALUE 18.
       78  MAX-COLS                          VALUE 7.
       77  WS-BITMAP1                        PIC S9(9) COMP-4.
       77  WS-BITMAP2                        PIC S9(9) COMP-4.
       77  WINDOW-HANDLE                     HANDLE OF WINDOW.
       78  BRIGHT-RED                        VALUE 13.

       77  KEY-STATUS IS SPECIAL-NAMES CRT STATUS PIC 9(4) VALUE 0.
           88  EXIT-PRESSED                  VALUE 10.
       
       01 GRID-DATA-TABLE.
         05 FILLER                           PIC X(120)
           VALUE "  CATEGORY        AUTHOR                  TITLE
      -    "                         PUBLISHER                 DATE".
         05 FILLER                           PIC X(120)
           VALUE "01Adventure       Fleming  Ian            On Her Majes
      -    "ty's Secret Service      New American Library      01/10/196
      -    "3".
         05 FILLER                           PIC X(120)
           VALUE "02Art             CrespelleJean-Paul      Monet
      -    "                         Studio Editions           12/25/199
      -    "3".
         05 FILLER                           PIC X(120)
           VALUE "03Biographical    Adamson  Joy            Born Free
      -    "                         Pantheon                  6/8/1960"
           .
         05 FILLER                           PIC X(120)
           VALUE "04Children        Milne    A.A.           Winnie the P
      -    "ooh                      E.P. Dutton & Co., Inc    03-23-195
      -    "6".
         05 FILLER                           PIC X(120)
           VALUE "05Fiction         Miller   Henry          Tropic of Ca
      -    "pricorn                  Grove Press               4/20/1961
      -    "".
         05 FILLER                           PIC X(120)
           VALUE "06History         Durant   Will and Ariel The Age of N
      -    "apoleon                  Simon and Schuster        04/20/197
      -    "5".
         05 FILLER                           PIC X(120)
           VALUE "07History         Stone    Irving         The Agony an
      -    "d the Ecstasy            Doubleday & Company, Inc  03/20/195
      -    "8".
         05 FILLER                           PIC X(120)
           VALUE "08History         Tuchmann Barbara        The March of
      -    " Folly                   Alfred A. Knopf, Inc      10-12-198
      -    "4".
         05 FILLER                           PIC X(120)
           VALUE "09Murder Mystery  Christie Agatha         Sleeping Mur
      -    "der                      The Haddon Craftsman, Inc 07-08-197
      -	   "6".
         05 FILLER                           PIC X(120)
           VALUE "10Reference       Matthews Peter          The Guinness
      -    " Book of Records 1996    Bantam Books              9-10-1997
      -    "".
         05 FILLER                           PIC X(120)
           VALUE "11Science         Macauly  David          The Way Thin
      -    "gs Work                  Houghton Mifflin, Co      09/08/198
      -    "8".
         05 FILLER                           PIC X(120)
           VALUE "12Science Fiction Crichton Michael        AirFrame
      -    "                         Alfred A. Knopf, Inc      01/05/199
      -    "6".
         05 FILLER                           PIC X(120)
           VALUE "13Science Fiction Crichton Michael        Jurassic Par
      -    "k                        Signet Fiction            001/4/199
      -    "4".
         05 FILLER                           PIC X(120)
           VALUE "14Science Fiction Niven    Larry          Ringworld
      -    "                         Ballantine Books          8/9/1970"
           .
         05 FILLER                           PIC X(120)
           VALUE "15Science Fiction Verne    Jules          A Journey to
      -    " the Center of the Earth Signet Classic            8/11/1986
      -    "".
         05 FILLER                           PIC X(120)
           VALUE "16Science Fiction Verne    Jules          20,000 Leagu
      -    "es Under the Sea         Signet Classic            12/8/1986
      -    "".
         05 FILLER                           PIC X(120)
           VALUE "17Science Fiction Wells    H.G.           The Invisibl
      -    "e Man                    Signet Classic            11/9/1986
      -    "".

       01  GRID-DATA-TBL REDEFINES GRID-DATA-TABLE.
           05  GRID-RECORD OCCURS MAX-ROWS TIMES      PIC X(120).

       COPY "acugui.def".

       LINKAGE SECTION.

       SCREEN SECTION.
       01 MAIN-SCREEN.
           03 GRID-1 GRID
                   LINE 2.5 COL 2
                   SIZE 125 LINES 18
                   DATA-COLUMNS       = ( 1, 3, 19, 28, 43, 80, 106)
                   DISPLAY-COLUMNS    = ( 1, 4, 20, 32, 46, 85, 111)
                   SORT-TYPES         = ("-","X","X","X","X","X","D^")
                   HALIGNMENT          = ("C","C","C","C","C","C","R")
                   ROW-DIVIDERS       = (1,3)
                   COLUMN-DIVIDERS    = (2,2,2,2,2,2)
                   DIVIDER-COLOR      = BRIGHT-RED
                   CURSOR-COLOR       = 80
                   HEADING-COLOR      = 144
                   CURSOR-FRAME-WIDTH = -1
                   VPADDING           = 50
                   VIRTUAL-WIDTH      = 124
                   ADJUSTABLE-COLUMNS
                   USE-TAB
                   COLUMN-HEADINGS
                   ROW-HEADINGS
                   HSCROLL
                   CENTERED-COL-HEADINGS
                   TILED-HEADINGS.
           03 PUSH-BUTTON
                   LINE 33 COL 25
                   SIZE 14 
                   TITLE "E&XIT"
                   SELF-ACT
                   EXCEPTION-VALUE = 10.

       PROCEDURE DIVISION.

           DISPLAY STANDARD GRAPHICAL WINDOW
                   TITLE "GRID BITMAP DEMO"
                   SIZE 130 LINES 35
                   BACKGROUND-LOW
                   MODELESS RESIZABLE
                   HANDLE WINDOW-HANDLE

           CALL "W$BITMAP" USING WBITMAP-LOAD "warning.bmp"
                GIVING WS-BITMAP1

           CALL "W$BITMAP" USING WBITMAP-LOAD "warning.png"
                GIVING WS-BITMAP2

           DISPLAY MAIN-SCREEN
           PERFORM LOAD-GRID

           PERFORM WITH TEST AFTER UNTIL EXIT-PRESSED
               ACCEPT MAIN-SCREEN 
           END-PERFORM

           GOBACK.

       LOAD-GRID.
           PERFORM VARYING CTR FROM 1 BY 1 UNTIL CTR > MAX-ROWS
               MODIFY GRID-1 RECORD-TO-ADD = GRID-RECORD(CTR)
           END-PERFORM.
           
           MODIFY GRID-1 X = 2 Y = 2 BITMAP = WS-BITMAP1

           MODIFY GRID-1 X = 2 Y = 3 BITMAP = WS-BITMAP2
            
           MODIFY GRID-1 CURSOR-X = 2 CURSOR-Y = 2.