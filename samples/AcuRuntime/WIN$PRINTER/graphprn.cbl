       IDENTIFICATION DIVISION.
       PROGRAM-ID. GRAPHPRN.
       DATE-WRITTEN. 2000/07/27
       REMARKS.
      *This program illustrates use of the new intrinsic functions for
      *graphics printing in Windows with Windows runtime version 5.2.0

      * Copyright (C) 2000-2001,2004,2006,2008,2010 Micro Focus.
      * All rights reserved.
      *
      * This sample code is supplied for demonstration purposes only
      * on an "as is" basis and is for use at your own risk.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT PRINT-FILE
           ASSIGN TO PRINT WS-PRINTER
           ORGANIZATION IS LINE SEQUENTIAL
           FILE STATUS IS PRINTER-STATUS.

       DATA DIVISION.
       FILE SECTION.
       FD  PRINT-FILE.
       01  PRINT-RECORD             PIC X(80).

       WORKING-STORAGE SECTION.
      * ACUCOBOL-GT PREDEFINED LIBRARIES
            COPY "acugui.def".
            COPY "winprint.def".
      * ACUCOBOL-GT PREDEFINED LIBRARIES FOR CUSTOMIZED FONTS DEFINITION
            COPY "fonts.def".
            COPY "crtvars.def".
            COPY "winvers.def".

       78  TERMINATION-KEY          VALUE 27.

       77  KEY-STATUS IS SPECIAL-NAMES CRT STATUS PIC 9(5) VALUE 0.
           88 ESCAPE-KEY            VALUE TERMINATION-KEY.

       77  MSG-TXT                  PIC X(100) VALUE SPACE.
       77  WS-COUNT                 PIC 9(03) VALUE 0.
       77  PRNLIST-IDX              PIC 9(03) VALUE 0.
       77  CALL-RESULT              SIGNED-INT VALUE 0.
       77  CHOSEN-PRINTER           PIC X(80).
       77  CHANGE-FLAG              PIC 9(01) VALUE 0.
       77  UPDATING                 PIC 9(01) VALUE 0.
       77  WS-LOGO                  USAGE IS HANDLE VALUE NULL.
       77  TITLE-FONT               USAGE IS HANDLE OF FONT VALUE NULL.
       77  TEXT-FONT                USAGE IS HANDLE OF FONT VALUE NULL.
       77  DATA-FONT                USAGE IS HANDLE OF FONT VALUE NULL.
       77  PAGE-TOTAL               PIC 9(09)V9(09).
       77  ITEM-HELP                PIC 9(09)V9(09).
       77  WS-START-ITEM-Y          PIC 9(02)V9(02).
       77  WS-PRINTER               PIC X(83) VALUE "-P SPOOLER".
       77  WS-STD-PITCH             PIC 9(02).

       77  COLORREF                 USAGE UNSIGNED-INT.
       77  RGB-RED                  PIC 9(03).
       77  RGB-GREEN                PIC 9(03).
       77  RGB-BLUE                 PIC 9(03).

       77  ABOUT-TEXT               PIC X(512).
       77  ABOUT-01                 PIC X(60) VALUE
           "This program demonstrates the new features in eXtend 5.2".
       77  ABOUT-02                 PIC X(60) VALUE
           "to print using colors and graphics on Windows printers".
       77  ABOUT-03                 PIC X(60) VALUE
           "through use of new functionality in WIN$PRINTER:".
       77  ABOUT-04                 PIC X(30) VALUE
           "   o WINPRINT-GRAPH-BRUSH".
       77  ABOUT-05                 PIC X(30) VALUE
           "   o WINPRINT-GRAPH-PEN".
       77  ABOUT-06                 PIC X(30) VALUE
           "   o WINPRINT-GRAPH-DRAW".
       77  ABOUT-07                 PIC X(40) VALUE
           "   o WINPRINT-GET-PRINTER-INFO-EX".
       77  ABOUT-08                 PIC X(30) VALUE
           "   o WINPRINT-SET-PRINTER-EX".
       77  ABOUT-09                 PIC X(40) VALUE
           "   o WINPRINT-GET-CURRENT-INFO-EX".
       77  ABOUT-10                 PIC X(30) VALUE
           "   o WINPRINT-SET-CURSOR".
       77  ABOUT-11                 PIC X(30) VALUE
           "   o WINPRINT-SET-TEXT-COLOR".

       01  PRINTER-ERR-MSG.
           03 FILLER                PIC X(15) VALUE "Printer error #".
           03 PRINTER-STATUS        PIC X(2).
           03 FILLER                PIC X(13) VALUE " has occured!".
           03 FILLER                PIC X(01) VALUE X"0D".
           03 STATUS-VALUE          PIC X(20) VALUE SPACE.
           03 FILLER                PIC X(01) VALUE X"0D".
           03 STATUS-TXT            PIC X(60) VALUE SPACE.

       01  SPOOLER-ERR-MSG.
           03 FILLER                PIC X(15) VALUE "Spooler error: ".
           03 WIN-SPOOL-ERR         PIC Z(8)9.

       01  ORDER-ITEMS.
           03 DESCRIPTION           PIC X(10) VALUE "eXtend 5.0".
           03 QUANTITY              PIC Z(03)9.99.
           03 ITEM-PRICE            PIC Z(03)9.99.
           03 ITEM-TOTAL            PIC Z(03)9.99.
           03 THE-END               PIC X(1).

       01  PAGE-TOTAL-REC.
           03 PAGE-TOTAL-TITLE      PIC X(07) VALUE "Total: ".
           03 SHOW-PAGE-TOTAL       PIC Z(03),Z(02)9.99.
           03 PAGE-TOTAL-END        PIC X(01).

       01  ORDER-INFO-REC.
           03 ORDER-INFO-TITLE      PIC X(15).
           03 ORDER-INFO-INFO       PIC X(15).
           03 ORDER-INFO-END        PIC X(01).

       SCREEN SECTION.

       01  MWIN-SCREEN.

           03 LABEL,
              COL                   20 PIXELS,
              LINE                  22 PIXELS,
              TITLE                 "Selected printer",
              LEFT.

           03 LABEL,
              COL                   20 PIXELS,
              LINE                  65 PIXELS,
              TITLE "Select a printer, then click on the Print button",
              LEFT.

           03 LABEL,
              COL                   286 PIXELS,
              LINE                  65 PIXELS,
              TITLE                 "to do a demonstration print...",
              LEFT.

           03 PUSH-BUTTON,
              COL                   197 PIXELS,
              LINE                  100 PIXELS,
              LINES                 30 PIXELS,
              SIZE                  84 PIXELS,
              ID                    IS 12,
              EVENT                 PROCEDURE IS PRINT-EVENT,
              TITLE                 "&Print",
              SELF-ACT.

           03 PUSH-BUTTON,
              COL                   307 PIXELS,
              LINE                  100 PIXELS,
              LINES                 30 PIXELS,
              SIZE                  84 PIXELS,
              ID                    IS 14,
              EVENT                 PROCEDURE IS ABOUT-EVENT,
              TITLE                 "&About",
              SELF-ACT.

           03 PUSH-BUTTON,
              COL                   417 PIXELS,
              LINE                  100 PIXELS,
              LINES                 30 PIXELS,
              SIZE                  84 PIXELS,
              TERMINATION-VALUE     TERMINATION-KEY,
              TITLE                 "&Quit",
              SELF-ACT.

           03 DATA-SCREEN.

              05 PRNLIST-SCREEN     COMBO-BOX,
                 COL                200 PIXELS,
                 LINE               20 PIXELS,
                 SIZE               300 PIXELS,
                 NOTIFY-SELCHANGE,
                 ID                 IS 15,
                 UNSORTED,
                 MASS-UPDATE        IS UPDATING,
                 USING              CHOSEN-PRINTER,
                 3-D.

       PROCEDURE DIVISION.

       DECLARATIVES.

       PRINTER-ERROR SECTION.

           USE AFTER STANDARD ERROR PROCEDURE ON PRINT-FILE.

       PRINTER-ERR.

           CALL    "C$RERR"         USING
                   STATUS-VALUE
                   STATUS-TXT.
           DISPLAY MESSAGE          BOX
                   PRINTER-ERR-MSG
                   TITLE            "Printer Error!"
                   TYPE             1
                   ICON             3.
           STOP RUN.

       END DECLARATIVES.

       MAIN-LOGIC.
       MAIN-001.

           CALL    "WIN$VERSION"    USING WINVERSION-DATA
                   ON               EXCEPTION GO TO MAIN-900.

           IF      NOT              WIN-WORDSIZE-16
           AND     NOT              WIN-WORDSIZE-32
           AND     NOT              WIN-WORDSIZE-64
                   GO               TO MAIN-900.

           PERFORM INITIAL-SETUP.
           PERFORM LOAD-DATA.
           PERFORM LOOP.
           PERFORM CLEAN-UP.
           STOP    RUN.

       MAIN-900.

           DISPLAY "This program requires 32 bit Microsoft Windows".
           ACCEPT  OMITTED          WITH BEEP.
           STOP    RUN.

       MAIN-EXIT.
           EXIT.

       LOOP SECTION.
       LOOP-001.

           PERFORM UNTIL            ESCAPE-KEY
                   ACCEPT           MWIN-SCREEN
                   END-PERFORM.

       LOOP-900.
       LOOP-EXIT.
           EXIT.

       CLEAN-UP SECTION.
       CLEAN-UP-001.

           IF      WS-LOGO          NOT = NULL
                   CALL             "W$BITMAP" USING
                                    WBITMAP-DESTROY WS-LOGO.

           IF      TITLE-FONT       NOT = NULL
                   DESTROY          TITLE-FONT.

           IF      TEXT-FONT        NOT = NULL
                   DESTROY          TEXT-FONT.

           IF      DATA-FONT        NOT = NULL
                   DESTROY          DATA-FONT.

           DESTROY MWIN-SCREEN.

       CLEAN-UP-900.
       CLEAN-UP-EXIT.
           EXIT.

      *Load the list of printers.
       LOAD-DATA SECTION.
       LOAD-DATA-001.

           SET     ENVIRONMENT      "WINPRINT-NAMES-ONLY" TO 1.

           CALL    "WIN$PRINTER"    USING
                   WINPRINT-GET-NO-PRINTERS
                   WINPRINT-SELECTION
                   GIVING           CALL-RESULT.

           IF      CALL-RESULT      NOT    >      0
                   PERFORM          ERROR-MESSAGE
                   PERFORM          CLEAN-UP
                   STOP             RUN.

           MOVE    WINPRINT-NO-OF-PRINTERS TO     WS-COUNT.
           MOVE    1                TO     UPDATING.
           PERFORM VARYING          PRNLIST-IDX FROM 1 BY 1
                   UNTIL            PRNLIST-IDX > WS-COUNT
                   PERFORM          INIT-PRINTER-DATA
                   MOVE             PRNLIST-IDX TO
                                    WINPRINT-NO-OF-PRINTERS
                   CALL             "WIN$PRINTER" USING
                                    WINPRINT-GET-PRINTER-INFO-EX
                                    WINPRINT-SELECTION
                                    GIVING CALL-RESULT
                                    END-CALL
                   PERFORM          UPDATES
                   END-PERFORM.
           INITIALIZE               UPDATING.
           DISPLAY DATA-SCREEN.
           MOVE    CHOSEN-PRINTER   TO WINPRINT-NAME.

       LOAD-DATA-900.
       LOAD-DATA-EXIT.
           EXIT.

       UPDATES SECTION.
       UPDATES-001.

           IF      CALL-RESULT      NOT = 1
                   INITIALIZE       WS-COUNT
                   GO               TO UPDATES-900.

           MODIFY  PRNLIST-SCREEN
                   ITEM-TO-ADD      = WINPRINT-NAME.

           IF      WPRT-IS-DEFAULT
                   MOVE             WINPRINT-NAME TO
                                    CHOSEN-PRINTER.

       UPDATES-900.
       UPDATES-EXIT.
           EXIT.

       INITIAL-SETUP SECTION.
       INITIAL-SETUP-001.

           INITIALIZE               WS-COUNT.
           DISPLAY STANDARD         GRAPHICAL WINDOW
                   LINES            11
                   SIZE             75
                   TITLE-BAR        WITH SYSTEM MENU
                   BACKGROUND-LOW
                   AUTO-MINIMIZE
                   AUTO-RESIZE
                   MODELESS
                   ERASE
                   LINK             TO THREAD
                   NO SCROLL        NO WRAP
                   TITLE
                    "eXtend Graphics printing demonstration".

           DISPLAY MWIN-SCREEN.

       INITIAL-SETUP-900.
       INITIAL-SETUP-EXIT.
           EXIT.

       ERROR-MESSAGE SECTION.
       ERROR-MESSAGE-001.

           INITIALIZE               MSG-TXT.
           EVALUATE                 CALL-RESULT
                   WHEN             WPRTERR-UNSUPPORTED
                                    MOVE "Operation not supported!"   TO
                                         MSG-TXT
                   WHEN             WPRTERR-BAD-ARG
                                    MOVE "Illegal parameter used!"    TO
                                         MSG-TXT
                   WHEN             WPRTERR-CANCELLED
                                    MOVE "Operation cancelled!"       TO
                                         MSG-TXT
                                    GO   TO  ERROR-MESSAGE-900
                   WHEN             WPRTERR-BUFFER-TOO-SMALL
                                    MOVE "Transfer buffer too small!" TO
                                         MSG-TXT
                   WHEN             WPRTERR-NO-MEMORY
                                    MOVE "Out of memory!"             TO
                                         MSG-TXT
                   WHEN             WPRTERR-SPOOLER-OPEN
                                    MOVE "Spooler can't be open!"     TO
                                         MSG-TXT
                   WHEN             WPRTERR-SPOOLER-CLOSED
                                    MOVE "Spooler can't be closed!"   TO
                                         MSG-TXT
                   WHEN             WPRTERR-DEVICE-INCAPABLE
                                    MOVE "This device can't do this!" TO
                                         MSG-TXT
                   WHEN             WPRTERR-ENUM-FAIL
                                    MOVE "Found no printers!"         TO
                                         MSG-TXT
                   WHEN             WPRTERR-DRV-LOADFAIL
                                    MOVE "Driver did not load!"       TO
                                         MSG-TXT
                   WHEN             WPRTERR-BAD-DRIVER
                                    MOVE "Bad driver!"                TO
                                         MSG-TXT
                   WHEN             WPRTERR-SPOOL-ERR
                                    CALL "WIN$PRINTER" USING
                                         WINPRINT-GET-SPOOL-ERR
                                         GIVING CALL-RESULT
                                    MOVE CALL-RESULT TO WIN-SPOOL-ERR
                                    MOVE SPOOLER-ERR-MSG              TO
                                         MSG-TXT
                   WHEN             OTHER MOVE "Unknown error!" TO
                                         MSG-TXT
           END-EVALUATE.
           DISPLAY MESSAGE          BOX
                   MSG-TXT
                   TITLE            "An error has occured..."
                   TYPE             1
                   ICON             3.

       ERROR-MESSAGE-900.
       ERROR-MESSAGE-EXIT.
           EXIT.

       PRINT-EVENT SECTION.
       PRINT-EVENT-001.

           IF      EVENT-CONTROL-ID NOT = 12
           OR      EVENT-TYPE       = MSG-VALIDATE
                   GO               TO PRINT-EVENT-900.

           SET     ENVIRONMENT      "WINPRINT-NAMES-ONLY" TO 0.
           INQUIRE PRNLIST-SCREEN
                   VALUE            CHOSEN-PRINTER.

           INITIALIZE               WINPRINT-NAME
                                    WINPRINT-PORT
                                    WINPRINT-DRIVER
                                    WINPRINT-DRV-VERSION
                                    WINPRINT-NO-OF-PRINTERS
                                    WINPRINT-IS-DEFAULT
                                    WINPRINT-COPIES
                                    WINPRINT-ORIENTATION
                                    WINPRINT-QUALITY
                                    WINPRINT-CURR-ORIENTATION
                                    WINPRINT-CURR-COPIES
                                    WINPRINT-DUPLEX
                                    WINPRINT-COLLATE
                                    WINPRINT-COLOR
                                    WINPRINT-CURR-DUPLEX
                                    WINPRINT-CURR-COLLATE
                                    WINPRINT-CURR-PAPERSIZE
                                    WINPRINT-CURR-TRAY
                                    WINPRINT-CURR-COLOR
                                    WINPRINT-JOB-TITLE.
           MOVE    CHOSEN-PRINTER   TO WINPRINT-NAME.
           MOVE    "eXtend graphics printing demo" TO
                   WINPRINT-JOB-TITLE.
           CALL    "WIN$PRINTER"    USING
                   WINPRINT-SET-PRINTER-EX
                   WINPRINT-SELECTION
                   GIVING           CALL-RESULT.
           CALL    "WIN$PRINTER"    USING
                   WINPRINT-GET-CURRENT-INFO-EX
                   WINPRINT-SELECTION
                   GIVING           CALL-RESULT.
           OPEN    OUTPUT           PRINT-FILE.
           PERFORM PREPARE-PRINTER.
           PERFORM DO-GRAPHICS.
           PERFORM DO-TEXTS.
           PERFORM DO-ORDER-INFO.
           PERFORM DO-ITEM-TITLES.
           PERFORM DO-SETUP-COLUMNS.
           MOVE    29.8             TO WS-START-ITEM-Y.
           PERFORM VARYING PRNLIST-IDX FROM 1 BY 1
                   UNTIL   PRNLIST-IDX > 28
                   PERFORM          DO-ITEMS
                   END-PERFORM.
           PERFORM DO-FOOTER.
           PERFORM RELEASE-RESOURCES.
           CLOSE   PRINT-FILE.
           SET     ENVIRONMENT      "WINPRINT-NAMES-ONLY" TO 1.

       PRINT-EVENT-900.
       PRINT-EVENT-EXIT.
           EXIT.

       RELEASE-RESOURCES SECTION.
       RELEASE-RESOURCES-001.

           IF      TEXT-FONT        NOT = 0
                   DESTROY          TEXT-FONT
                   INITIALIZE       TEXT-FONT.

           IF      DATA-FONT        NOT = 0
                   DESTROY          DATA-FONT
                   INITIALIZE       DATA-FONT.

       RELEASE-RESOURCES-900.
       RELEASE-RESOURCES-EXIT.
           EXIT.

      *Set up columns for printing order header
       DO-ORDER-INFO SECTION.
       DO-ORDER-INFO-001.

           INITIALIZE               ORDER-INFO-END.

           CALL    "WIN$PRINTER"    USING
                   WINPRINT-SET-DATA-COLUMNS
                   RECORD-POSITION  OF ORDER-INFO-TITLE
                   RECORD-POSITION  OF ORDER-INFO-INFO
                   RECORD-POSITION  OF ORDER-INFO-END.

           INITIALIZE               WINPRINT-COL-START
                                    WINPRINT-COL-INDENT
                                    WINPRINT-COL-SEPARATION
                                    WINPRINT-COL-FONT
                                    WINPRINT-COL-UNITS
                                    WINPRINT-COL-ALIGNMENT.
           MOVE    WPRTUNITS-CELLS  TO WINPRINT-COL-UNITS.
           MOVE    WPRTALIGN-NONE   TO WINPRINT-COL-ALIGNMENT.
           MOVE    TEXT-FONT        TO WINPRINT-COL-FONT.

           MOVE    57               TO WINPRINT-COL-START.
           MOVE    WPRTALIGN-NONE   TO WINPRINT-COL-ALIGNMENT.
           CALL    "WIN$PRINTER"    USING
                   WINPRINT-SET-PAGE-COLUMN
                   WINPRINT-COLUMN.

           MOVE    73               TO WINPRINT-COL-START.
           MOVE    WPRTALIGN-RIGHT  TO WINPRINT-COL-ALIGNMENT.
           MOVE    DATA-FONT        TO WINPRINT-COL-FONT.
           CALL    "WIN$PRINTER"    USING
                   WINPRINT-SET-PAGE-COLUMN
                   WINPRINT-COLUMN.

           MOVE    93               TO WINPRINT-COL-START.
           MOVE    WPRTALIGN-NONE   TO WINPRINT-COL-ALIGNMENT.
           CALL    "WIN$PRINTER"    USING
                   WINPRINT-SET-PAGE-COLUMN
                   WINPRINT-COLUMN.

           MOVE    57               TO  WPRTDATA-DRAW-START-X.
           MOVE    15               TO  WPRTDATA-DRAW-START-Y.
           MOVE    WPRTUNITS-CELLS  TO  WPRTDATA-DRAW-UNITS.
           CALL    "WIN$PRINTER"    USING
                   WINPRINT-SET-CURSOR
                   WINPRINT-DATA
                   GIVING           CALL-RESULT.

           IF      CALL-RESULT      <  1
                      PERFORM          ERROR-MESSAGE
                      GO               TO DO-ORDER-INFO-900.

           MOVE    "Order #"        TO ORDER-INFO-TITLE.
           MOVE    "24568"          TO ORDER-INFO-INFO.
           WRITE   PRINT-RECORD     FROM ORDER-INFO-REC
                   BEFORE           ADVANCING 1 LINE.

           MOVE    57               TO  WPRTDATA-DRAW-START-X.
           MOVE    16.5             TO  WPRTDATA-DRAW-START-Y.
           MOVE    WPRTUNITS-CELLS  TO  WPRTDATA-DRAW-UNITS.
           CALL    "WIN$PRINTER"    USING
                   WINPRINT-SET-CURSOR
                   WINPRINT-DATA
                   GIVING           CALL-RESULT.

           IF      CALL-RESULT      <  1
                   PERFORM          ERROR-MESSAGE
                   GO               TO DO-ORDER-INFO-900.

           MOVE    "Order date"     TO ORDER-INFO-TITLE.
           MOVE    "24 Dec 2000"    TO ORDER-INFO-INFO.
           WRITE   PRINT-RECORD     FROM ORDER-INFO-REC
                   BEFORE           ADVANCING 1 LINE.

           MOVE    57               TO  WPRTDATA-DRAW-START-X.
           MOVE    18               TO  WPRTDATA-DRAW-START-Y.
           MOVE    WPRTUNITS-CELLS  TO  WPRTDATA-DRAW-UNITS.
           CALL    "WIN$PRINTER"    USING
                   WINPRINT-SET-CURSOR
                   WINPRINT-DATA
                   GIVING           CALL-RESULT.

           IF      CALL-RESULT      <  1
                   PERFORM          ERROR-MESSAGE
                   GO               TO DO-ORDER-INFO-900.

           MOVE    "Representative" TO ORDER-INFO-TITLE.
           MOVE    "S. Upersales"   TO ORDER-INFO-INFO.
           WRITE   PRINT-RECORD     FROM ORDER-INFO-REC
                   BEFORE           ADVANCING 1 LINE.

           MOVE    57               TO  WPRTDATA-DRAW-START-X.
           MOVE    19.5             TO  WPRTDATA-DRAW-START-Y.
           MOVE    WPRTUNITS-CELLS  TO  WPRTDATA-DRAW-UNITS.
           CALL    "WIN$PRINTER"    USING
                   WINPRINT-SET-CURSOR
                   WINPRINT-DATA
                   GIVING           CALL-RESULT.

           IF      CALL-RESULT      <  1
                   PERFORM          ERROR-MESSAGE
                   GO               TO DO-ORDER-INFO-900.

           MOVE    "Conditions"     TO ORDER-INFO-TITLE.
           MOVE    "Pay by 30 days" TO ORDER-INFO-INFO.
           WRITE   PRINT-RECORD     FROM ORDER-INFO-REC
                   BEFORE           ADVANCING 1 LINE.

           CALL    "WIN$PRINTER"    USING WINPRINT-CLEAR-PAGE-COLUMNS.
           CALL    "WIN$PRINTER"    USING WINPRINT-CLEAR-DATA-COLUMNS.

       DO-ORDER-INFO-900.
       DO-ORDER-INFO-EXIT.
           EXIT.

      *Set up columns for order line items
       DO-SETUP-COLUMNS SECTION.
       DO-SETUP-COLUMNS-001.

           INITIALIZE               THE-END.
           CALL    "WIN$PRINTER"    USING
                   WINPRINT-SET-DATA-COLUMNS
                   RECORD-POSITION  OF DESCRIPTION
                   RECORD-POSITION  OF QUANTITY
                   RECORD-POSITION  OF ITEM-PRICE
                   RECORD-POSITION  OF ITEM-TOTAL
                   RECORD-POSITION  OF THE-END.

           INITIALIZE               WINPRINT-COL-START
                                    WINPRINT-COL-INDENT
                                    WINPRINT-COL-SEPARATION
                                    WINPRINT-COL-FONT
                                    WINPRINT-COL-UNITS
                                    WINPRINT-COL-ALIGNMENT.
           MOVE    WPRTUNITS-CELLS  TO WINPRINT-COL-UNITS.
           MOVE    WPRTALIGN-NONE   TO WINPRINT-COL-ALIGNMENT.
           MOVE    0.20             TO WINPRINT-COL-SEPARATION.
           MOVE    DATA-FONT        TO WINPRINT-COL-FONT.

           MOVE    3                TO WINPRINT-COL-START.
           MOVE    WPRTALIGN-NONE   TO WINPRINT-COL-ALIGNMENT.
           CALL    "WIN$PRINTER"    USING
                   WINPRINT-SET-PAGE-COLUMN
                   WINPRINT-COLUMN.

           MOVE    3                TO WINPRINT-COL-SEPARATION.
           MOVE    35               TO WINPRINT-COL-START.
           MOVE    WPRTALIGN-DECIMAL TO WINPRINT-COL-ALIGNMENT.
           CALL    "WIN$PRINTER"    USING
                   WINPRINT-SET-PAGE-COLUMN
                   WINPRINT-COLUMN.

           MOVE    53               TO WINPRINT-COL-START.
           MOVE    WPRTALIGN-DECIMAL TO WINPRINT-COL-ALIGNMENT.
           CALL    "WIN$PRINTER"    USING
                   WINPRINT-SET-PAGE-COLUMN
                   WINPRINT-COLUMN.

           MOVE    69               TO WINPRINT-COL-START.
           MOVE    WPRTALIGN-DECIMAL TO WINPRINT-COL-ALIGNMENT.
           CALL    "WIN$PRINTER"    USING
                   WINPRINT-SET-PAGE-COLUMN
                   WINPRINT-COLUMN.

           MOVE    96               TO WINPRINT-COL-START.
           MOVE    WPRTALIGN-NONE   TO WINPRINT-COL-ALIGNMENT.
           CALL    "WIN$PRINTER"    USING
                   WINPRINT-SET-PAGE-COLUMN
                   WINPRINT-COLUMN.

       DO-SETUP-COLUMNS-900.
       DO-SETUP-COLUMNS-EXIT.
           EXIT.

      *Set up columns for order footer
       DO-FOOTER SECTION.
       DO-FOOTER-001.

           CALL    "WIN$PRINTER"    USING WINPRINT-CLEAR-PAGE-COLUMNS.
           CALL    "WIN$PRINTER"    USING WINPRINT-CLEAR-DATA-COLUMNS.
           INITIALIZE               PAGE-TOTAL-END.

           CALL    "WIN$PRINTER"    USING
                   WINPRINT-SET-DATA-COLUMNS
                   RECORD-POSITION  OF PAGE-TOTAL-TITLE
                   RECORD-POSITION  OF SHOW-PAGE-TOTAL
                   RECORD-POSITION  OF PAGE-TOTAL-END.

           INITIALIZE               WINPRINT-COL-START
                                    WINPRINT-COL-INDENT
                                    WINPRINT-COL-SEPARATION
                                    WINPRINT-COL-FONT
                                    WINPRINT-COL-UNITS
                                    WINPRINT-COL-ALIGNMENT.
           MOVE    WPRTUNITS-CELLS  TO WINPRINT-COL-UNITS.
           MOVE    WPRTALIGN-NONE   TO WINPRINT-COL-ALIGNMENT.
           MOVE    TEXT-FONT        TO WINPRINT-COL-FONT.

           MOVE    72               TO WINPRINT-COL-START.
           MOVE    WPRTALIGN-NONE   TO WINPRINT-COL-ALIGNMENT.
           CALL    "WIN$PRINTER"    USING
                   WINPRINT-SET-PAGE-COLUMN
                   WINPRINT-COLUMN.

           MOVE    79               TO WINPRINT-COL-START.
           MOVE    WPRTALIGN-RIGHT  TO WINPRINT-COL-ALIGNMENT.
           MOVE    DATA-FONT        TO WINPRINT-COL-FONT.
           CALL    "WIN$PRINTER"    USING
                   WINPRINT-SET-PAGE-COLUMN
                   WINPRINT-COLUMN.

           MOVE    95               TO WINPRINT-COL-START.
           MOVE    WPRTALIGN-NONE   TO WINPRINT-COL-ALIGNMENT.
           CALL    "WIN$PRINTER"    USING
                   WINPRINT-SET-PAGE-COLUMN
                   WINPRINT-COLUMN.

           MOVE    72               TO  WPRTDATA-DRAW-START-X.
           MOVE    62.5             TO  WPRTDATA-DRAW-START-Y.
           MOVE    WPRTUNITS-CELLS  TO  WPRTDATA-DRAW-UNITS.
           CALL    "WIN$PRINTER"    USING
                   WINPRINT-SET-CURSOR
                   WINPRINT-DATA
                   GIVING           CALL-RESULT.

           IF      CALL-RESULT      <  1
                   PERFORM          ERROR-MESSAGE
                   GO               TO DO-FOOTER-900.

           MOVE    PAGE-TOTAL       TO SHOW-PAGE-TOTAL.

      *If printer supports colors select solid red text color for total.
           IF      WPRT-COLOR
                   INITIALIZE       RGB-RED
                                    RGB-GREEN
                                    RGB-BLUE
                   MOVE             255 TO RGB-RED
                   PERFORM          CALC-COLORREF
                   MOVE             COLORREF TO WPRTDATA-TEXT-COLOR
                   CALL             "WIN$PRINTER" USING
                                    WINPRINT-SET-TEXT-COLOR
                                    WPRTDATA-TEXT-COLOR
                                    GIVING WPRTDATA-TEXT-COLOR.

           WRITE   PRINT-RECORD     FROM PAGE-TOTAL-REC
                   BEFORE           ADVANCING 1 LINE.

      *If printer supports colors, restore color
           IF      WPRT-COLOR
                   CALL             "WIN$PRINTER" USING
                                    WINPRINT-SET-TEXT-COLOR
                                    WPRTDATA-TEXT-COLOR
                                    GIVING COLORREF.

           CALL    "WIN$PRINTER"    USING WINPRINT-CLEAR-PAGE-COLUMNS.
           CALL    "WIN$PRINTER"    USING WINPRINT-CLEAR-DATA-COLUMNS.

       DO-FOOTER-900.
       DO-FOOTER-EXIT.
           EXIT.

      *Draw order items title
       DO-ITEM-TITLES SECTION.
       DO-ITEM-TITLES-001.

           INITIALIZE               WPRTDATA-DRAW.
           MOVE    2                TO  WPRTDATA-DRAW-START-X.
           MOVE    28.8             TO  WPRTDATA-DRAW-START-Y.
           MOVE    WPRTUNITS-CELLS  TO  WPRTDATA-DRAW-UNITS.
           CALL    "WIN$PRINTER"    USING
                   WINPRINT-SET-CURSOR
                   WINPRINT-DATA
                   GIVING           CALL-RESULT.

           IF      CALL-RESULT      <  1
                   PERFORM          ERROR-MESSAGE
                   GO               TO DO-ITEM-TITLES-900.

           WRITE   PRINT-RECORD     FROM   "Description"
                   BEFORE           ADVANCING 1 LINE.

           MOVE    44.5             TO  WPRTDATA-DRAW-START-X.
           CALL    "WIN$PRINTER"    USING
                   WINPRINT-SET-CURSOR
                   WINPRINT-DATA
                   GIVING           CALL-RESULT.

           IF      CALL-RESULT      <  1
                   PERFORM          ERROR-MESSAGE
                   GO               TO DO-ITEM-TITLES-900.

           WRITE   PRINT-RECORD     FROM   "Quantity"
                   BEFORE           ADVANCING 1 LINE.

           MOVE    56.0             TO  WPRTDATA-DRAW-START-X.
           CALL    "WIN$PRINTER"    USING
                   WINPRINT-SET-CURSOR
                   WINPRINT-DATA
                   GIVING           CALL-RESULT.

           IF      CALL-RESULT      <  1
                   PERFORM          ERROR-MESSAGE
                   GO               TO DO-ITEM-TITLES-900.

           WRITE   PRINT-RECORD     FROM   "Price per item"
                   BEFORE           ADVANCING 1 LINE.

           MOVE    86.5             TO  WPRTDATA-DRAW-START-X.
           CALL    "WIN$PRINTER"    USING
                   WINPRINT-SET-CURSOR
                   WINPRINT-DATA
                   GIVING           CALL-RESULT.

           IF      CALL-RESULT      <  1
                   PERFORM          ERROR-MESSAGE
                   GO               TO DO-ITEM-TITLES-900.

           WRITE   PRINT-RECORD     FROM   "Line total"
                   BEFORE           ADVANCING 1 LINE.

       DO-ITEM-TITLES-900.
       DO-ITEM-TITLES-EXIT.
           EXIT.


      *Print order items
       DO-ITEMS SECTION.
       DO-ITEMS-001.

           INITIALIZE               WPRTDATA-DRAW.
           MOVE    2                TO  WPRTDATA-DRAW-START-X.
           COMPUTE WPRTDATA-DRAW-START-Y =
                   WS-START-ITEM-Y  +
                   PRNLIST-IDX.
           MOVE    WPRTUNITS-CELLS  TO  WPRTDATA-DRAW-UNITS.
           CALL    "WIN$PRINTER"    USING WINPRINT-SET-CURSOR
                                          WINPRINT-DATA
                   GIVING           CALL-RESULT.

           IF      CALL-RESULT      <  1
                   PERFORM          ERROR-MESSAGE
                   GO               TO DO-ITEMS-900.

           MOVE    PRNLIST-IDX      TO QUANTITY.
           MOVE    5.20             TO ITEM-PRICE.
           COMPUTE ITEM-HELP        = PRNLIST-IDX * 5.20.
           ADD     ITEM-HELP        TO PAGE-TOTAL.
           MOVE    ITEM-HELP        TO ITEM-TOTAL.

           WRITE   PRINT-RECORD     FROM   ORDER-ITEMS
                   BEFORE           ADVANCING 1 LINE.

       DO-ITEMS-900.
       DO-ITEMS-EXIT.
           EXIT.

      *Do texts, order header
       DO-TEXTS SECTION.
       DO-TEXTS-001.

      *Position cursor
           INITIALIZE               WPRTDATA-DRAW.
           MOVE    4                TO  WPRTDATA-DRAW-START-X.
           MOVE    2                TO  WPRTDATA-DRAW-START-Y.
           MOVE    WPRTUNITS-CELLS  TO  WPRTDATA-DRAW-UNITS.
           CALL    "WIN$PRINTER"    USING
                   WINPRINT-SET-CURSOR
                   WINPRINT-DATA
                   GIVING           CALL-RESULT.

           IF      CALL-RESULT      <  1
                   PERFORM          ERROR-MESSAGE
                   GO               TO DO-TEXTS-900.

           WRITE   PRINT-RECORD     FROM   "Customer company Inc."
                   BEFORE           ADVANCING 1 LINE.

           ADD     1                TO  WPRTDATA-DRAW-START-Y.
           CALL    "WIN$PRINTER"    USING
                   WINPRINT-SET-CURSOR
                   WINPRINT-DATA
                   GIVING           CALL-RESULT.

           IF      CALL-RESULT      <  1
                   PERFORM          ERROR-MESSAGE
                   GO               TO DO-TEXTS-900.

           WRITE   PRINT-RECORD     FROM
                   "Wonder street 995, suite 204"
                   BEFORE           ADVANCING 1 LINE.

           ADD     1                TO  WPRTDATA-DRAW-START-Y.
           CALL    "WIN$PRINTER"    USING
                   WINPRINT-SET-CURSOR
                   WINPRINT-DATA
                   GIVING           CALL-RESULT.

           IF      CALL-RESULT      <  1
                   PERFORM          ERROR-MESSAGE
                   GO               TO DO-TEXTS-900.

           WRITE   PRINT-RECORD     FROM
                   "Miracle, 51st state 99999-9999"
                   BEFORE           ADVANCING 1 LINE.

           ADD     1                TO  WPRTDATA-DRAW-START-Y.
           CALL    "WIN$PRINTER"    USING
                   WINPRINT-SET-CURSOR
                   WINPRINT-DATA
                   GIVING           CALL-RESULT.

           IF      CALL-RESULT      <  1
                   PERFORM          ERROR-MESSAGE
                   GO               TO DO-TEXTS-900.

           WRITE   PRINT-RECORD     FROM
                   "Wonderland"
                   BEFORE           ADVANCING 1 LINE.

           MOVE    15               TO  WPRTDATA-DRAW-START-Y.
           MOVE    WPRTUNITS-CELLS  TO  WPRTDATA-DRAW-UNITS.
           CALL    "WIN$PRINTER"    USING
                   WINPRINT-SET-CURSOR
                   WINPRINT-DATA
                   GIVING           CALL-RESULT.

           IF      CALL-RESULT      <  1
                   PERFORM          ERROR-MESSAGE
                   GO               TO DO-TEXTS-900.

           WRITE   PRINT-RECORD     FROM   "Micro Focus"
                   BEFORE           ADVANCING 1 LINE.

           ADD     1                TO  WPRTDATA-DRAW-START-Y.
           CALL    "WIN$PRINTER"    USING
                   WINPRINT-SET-CURSOR
                   WINPRINT-DATA
                   GIVING           CALL-RESULT.

           IF      CALL-RESULT      <  1
                   PERFORM          ERROR-MESSAGE
                   GO               TO DO-TEXTS-900.

           WRITE   PRINT-RECORD     FROM
                   "8515 Miralani Drive"
                   BEFORE           ADVANCING 1 LINE.

           ADD     1                TO  WPRTDATA-DRAW-START-Y.
           CALL    "WIN$PRINTER"    USING
                   WINPRINT-SET-CURSOR
                   WINPRINT-DATA
                   GIVING           CALL-RESULT.

           IF      CALL-RESULT      <  1
                   PERFORM          ERROR-MESSAGE
                   GO               TO DO-TEXTS-900.

           WRITE   PRINT-RECORD     FROM
                   "San Diego, CA 92126"
                   BEFORE           ADVANCING 1 LINE.

           ADD     1                TO  WPRTDATA-DRAW-START-Y.
           CALL    "WIN$PRINTER"    USING
                   WINPRINT-SET-CURSOR
                   WINPRINT-DATA
                   GIVING CALL-RESULT.

           IF      CALL-RESULT      <  1
                   PERFORM          ERROR-MESSAGE
                   GO               TO DO-TEXTS-900.

           WRITE   PRINT-RECORD     FROM
                   "USA"
                   BEFORE           ADVANCING 1 LINE.

       DO-TEXTS-900.
       DO-TEXTS-EXIT.
           EXIT.

      *Prepare printer, load fonts and draw form title.
       PREPARE-PRINTER SECTION.
       PREPARE-PRINTER-001.

           IF      WPRT-A4
           OR      WPRT-A4SMALL
                   MOVE             10     TO WS-STD-PITCH
           ELSE
                   MOVE             12     TO WS-STD-PITCH.

           INITIALIZE               PAGE-TOTAL.

           IF      WS-LOGO          =      0
                   CALL             "W$BITMAP" USING
                                    WBITMAP-LOAD
                                    "ACUCORP.BMP"
                                    GIVING WS-LOGO
                                    ON EXCEPTION GO TO
                                    PREPARE-PRINTER-800.

       PREPARE-PRINTER-005.

           IF      TEXT-FONT        NOT = 0
                   GO               TO  PREPARE-PRINTER-010.

           INITIALIZE               WFONT-DATA.
           SET     WFDEVICE-WIN-PRINTER TO TRUE.
           SET     WFCHARSET-DEFAULT    TO TRUE.
           SET     WFFAMILY-MODERN  TO  TRUE.
           MOVE    "Times New Roman"    TO WFONT-NAME.
           MOVE    WS-STD-PITCH     TO  WFONT-SIZE.

           CALL    "W$FONT"         USING
                   WFONT-GET-CLOSEST-FONT
                   TEXT-FONT        WFONT-DATA
                   GIVING           CALL-RESULT.

       PREPARE-PRINTER-010.

           IF      DATA-FONT        NOT = 0
                   GO               TO  PREPARE-PRINTER-020.

           INITIALIZE               WFONT-DATA.
           SET     WFDEVICE-WIN-PRINTER TO TRUE.
           SET     WFCHARSET-DEFAULT    TO TRUE.
           SET     WFFAMILY-MODERN  TO  TRUE.
           MOVE    "Times New Roman"    TO WFONT-NAME.
           SET     WFONT-BOLD       TO TRUE.
           MOVE    WS-STD-PITCH     TO  WFONT-SIZE.
           CALL    "W$FONT"         USING
                   WFONT-GET-CLOSEST-FONT
                   DATA-FONT        WFONT-DATA
                   GIVING           CALL-RESULT.

       PREPARE-PRINTER-020.

           IF      TITLE-FONT       NOT = 0
                   GO               TO  PREPARE-PRINTER-030.

           INITIALIZE               WFONT-DATA.
           SET     WFDEVICE-WIN-PRINTER TO TRUE.
           SET     WFCHARSET-DEFAULT    TO TRUE.
           SET     WFFAMILY-MODERN  TO  TRUE.
           MOVE    "Arial"          TO WFONT-NAME.
           MOVE    20               TO WFONT-SIZE.
           SET     WFONT-ITALIC     TO TRUE.
           SET     WFONT-BOLD       TO TRUE.
           CALL    "W$FONT"         USING
                   WFONT-GET-CLOSEST-FONT
                   TITLE-FONT        WFONT-DATA
                   GIVING           CALL-RESULT.

       PREPARE-PRINTER-030.

           INITIALIZE               WPRTDATA-SET-FONT.
           MOVE    TITLE-FONT       TO WPRTDATA-FONT.
           CALL    "WIN$PRINTER"    USING
                   WINPRINT-SET-FONT
                   WINPRINT-DATA
                   GIVING           CALL-RESULT.

           INITIALIZE               WPRTDATA-DRAW.
           MOVE    32               TO  WPRTDATA-DRAW-START-X.
           MOVE    4                TO  WPRTDATA-DRAW-START-Y.
           MOVE    WPRTUNITS-CELLS  TO  WPRTDATA-DRAW-UNITS.
           CALL    "WIN$PRINTER"    USING
                   WINPRINT-SET-CURSOR
                   WINPRINT-DATA
                   GIVING           CALL-RESULT.

      *If printer supports color, write title in solid blue.
           IF      WPRT-COLOR
                   INITIALIZE       RGB-RED
                                    RGB-GREEN
                                    RGB-BLUE
                   MOVE             255 TO RGB-BLUE
                   PERFORM          CALC-COLORREF
                   MOVE             COLORREF TO WPRTDATA-TEXT-COLOR
                   CALL             "WIN$PRINTER" USING
                                    WINPRINT-SET-TEXT-COLOR
                                    WPRTDATA-TEXT-COLOR
                                    GIVING WPRTDATA-TEXT-COLOR.

           WRITE   PRINT-RECORD     FROM
                   "Order confirmation"
                   BEFORE           ADVANCING 1 LINE.

      *If printer supports color, restore color
           IF      WPRT-COLOR
                   CALL             "WIN$PRINTER" USING
                                    WINPRINT-SET-TEXT-COLOR
                                    WPRTDATA-TEXT-COLOR
                                    GIVING COLORREF.

           INITIALIZE               WPRTDATA-SET-FONT.
           MOVE    TEXT-FONT        TO WPRTDATA-FONT.
           CALL    "WIN$PRINTER"    USING
                   WINPRINT-SET-FONT
                   WINPRINT-DATA
                   GIVING           CALL-RESULT.

           INITIALIZE               WPRTDATA-PAGE-LAYOUT.
           MOVE    70               TO WPRTDATA-LINES-PER-PAGE.
           MOVE    97               TO WPRTDATA-COLUMNS-PER-PAGE.
           CALL    "WIN$PRINTER"    USING
                   WINPRINT-SET-LINES-PER-PAGE
                   WINPRINT-DATA
                   GIVING           CALL-RESULT.
           GO      TO               PREPARE-PRINTER-900.

       PREPARE-PRINTER-800.

           INITIALIZE               WS-LOGO.
           GO      TO               PREPARE-PRINTER-005.

       PREPARE-PRINTER-900.
       PREPARE-PRINTER-EXIT.
           EXIT.

      *Do all the graphics for the form
       DO-GRAPHICS SECTION.
       DO-GRAPHICS-001.

      *Create a solid pen 30 logical points thick
           INITIALIZE               WPRTDATA-PEN.
           MOVE    WPRT-PEN-SOLID   TO  WPRTDATA-PEN-STYLE.
           MOVE    30               TO  WPRTDATA-PEN-WIDTH.

      *If color support
           IF      WPRT-COLOR
                   MOVE             91  TO  RGB-RED
                   MOVE             157 TO  RGB-GREEN
                   MOVE             255 TO  RGB-BLUE
                   PERFORM          CALC-COLORREF
                   MOVE             COLORREF TO WPRTDATA-PEN-COLOR.

           CALL    "WIN$PRINTER"    USING
                   WINPRINT-GRAPH-PEN
                   WINPRINT-DATA
                   GIVING           CALL-RESULT.

           IF      CALL-RESULT      <  1
                   PERFORM          ERROR-MESSAGE
                   GO               TO DO-GRAPHICS-900.

      *Create an invisible brush
           INITIALIZE               WPRTDATA-BRUSH.
           MOVE    WPRT-BRUSH-NULL  TO  WPRTDATA-BRUSH-STYLE.
           CALL    "WIN$PRINTER"    USING
                   WINPRINT-GRAPH-BRUSH
                   WINPRINT-DATA
                   GIVING           CALL-RESULT.

           IF      CALL-RESULT      <  1
                   PERFORM          ERROR-MESSAGE
                   GO               TO DO-GRAPHICS-900.

      * Draw box for customer name.
           INITIALIZE               WPRTDATA-DRAW.
           MOVE    WPRT-DRAW-ROUND-RECTANGLE TO  WPRTDATA-DRAW-SHAPE.
           MOVE    3                TO  WPRTDATA-DRAW-START-X.
           MOVE    1                TO  WPRTDATA-DRAW-START-Y.
           MOVE    40               TO  WPRTDATA-DRAW-STOP-X.
           MOVE    10               TO  WPRTDATA-DRAW-STOP-Y.
           MOVE    WPRTUNITS-CELLS  TO  WPRTDATA-DRAW-UNITS.
           CALL    "WIN$PRINTER"    USING
                   WINPRINT-GRAPH-DRAW
                   WINPRINT-DATA
                   GIVING           CALL-RESULT.

           IF      CALL-RESULT      <  1
                   PERFORM          ERROR-MESSAGE
                   GO               TO DO-GRAPHICS-900.

      *Create a solid pen 10 logical points thick
           INITIALIZE               WPRTDATA-PEN.
           MOVE    WPRT-PEN-SOLID   TO  WPRTDATA-PEN-STYLE.
           MOVE    10               TO  WPRTDATA-PEN-WIDTH.

      *If color support
           IF      WPRT-COLOR
                   MOVE             91  TO  RGB-RED
                   MOVE             157 TO  RGB-GREEN
                   MOVE             255 TO  RGB-BLUE
                   PERFORM          CALC-COLORREF
                   MOVE             COLORREF TO WPRTDATA-PEN-COLOR.

           CALL    "WIN$PRINTER"    USING
                   WINPRINT-GRAPH-PEN
                   WINPRINT-DATA
                   GIVING           CALL-RESULT.

           IF      CALL-RESULT      <  1
                   PERFORM          ERROR-MESSAGE
                   GO               TO DO-GRAPHICS-900.

      * Draw box for order information
           INITIALIZE               WPRTDATA-DRAW.
           MOVE    WPRT-DRAW-ROUND-RECTANGLE TO  WPRTDATA-DRAW-SHAPE.
           MOVE    55.5             TO  WPRTDATA-DRAW-START-X.
           MOVE    14               TO  WPRTDATA-DRAW-START-Y.
           MOVE    93               TO  WPRTDATA-DRAW-STOP-X.
           MOVE    23               TO  WPRTDATA-DRAW-STOP-Y.
           MOVE    WPRTUNITS-CELLS  TO  WPRTDATA-DRAW-UNITS.
           CALL    "WIN$PRINTER"    USING
                   WINPRINT-GRAPH-DRAW
                   WINPRINT-DATA
                   GIVING           CALL-RESULT.

           IF      CALL-RESULT      <  1
                   PERFORM          ERROR-MESSAGE
                   GO               TO DO-GRAPHICS-900.

      * Draw box for order items
           INITIALIZE               WPRTDATA-DRAW.
           MOVE    WPRT-DRAW-RECTANGLE TO  WPRTDATA-DRAW-SHAPE.
           MOVE    1                TO  WPRTDATA-DRAW-START-X.
           MOVE    30.5             TO  WPRTDATA-DRAW-START-Y.
           MOVE    96               TO  WPRTDATA-DRAW-STOP-X.
           MOVE    59.5             TO  WPRTDATA-DRAW-STOP-Y.
           MOVE    WPRTUNITS-CELLS  TO  WPRTDATA-DRAW-UNITS.
           CALL    "WIN$PRINTER"    USING
                   WINPRINT-GRAPH-DRAW
                   WINPRINT-DATA
                   GIVING           CALL-RESULT.

           IF      CALL-RESULT      <  1
                   PERFORM          ERROR-MESSAGE
                   GO               TO DO-GRAPHICS-900.

      *Create a solid pen 3 logical points thick
           INITIALIZE               WPRTDATA-PEN.
           MOVE    WPRT-PEN-SOLID   TO  WPRTDATA-PEN-STYLE.
           MOVE    3                TO  WPRTDATA-PEN-WIDTH.

      *If color support
           IF      WPRT-COLOR
                   MOVE             91  TO RGB-RED
                   MOVE             157 TO RGB-GREEN
                   MOVE             255 TO RGB-BLUE
                   PERFORM          CALC-COLORREF
                   MOVE             COLORREF TO WPRTDATA-PEN-COLOR.

           CALL    "WIN$PRINTER"    USING
                   WINPRINT-GRAPH-PEN
                   WINPRINT-DATA
                   GIVING           CALL-RESULT.

           IF      CALL-RESULT      <  1
                   PERFORM          ERROR-MESSAGE
                   GO               TO DO-GRAPHICS-900.

      *Create a gray brush
           INITIALIZE               WPRTDATA-BRUSH.
           MOVE    WPRT-BRUSH-GRAY  TO  WPRTDATA-BRUSH-STYLE.

           CALL    "WIN$PRINTER"    USING
                   WINPRINT-GRAPH-BRUSH
                   WINPRINT-DATA
                   GIVING           CALL-RESULT.

           IF      CALL-RESULT      <  1
                   PERFORM          ERROR-MESSAGE
                   GO               TO DO-GRAPHICS-900.

      * Draw box for vendor name.
           INITIALIZE               WPRTDATA-DRAW.
           MOVE    WPRT-DRAW-ROUND-RECTANGLE TO  WPRTDATA-DRAW-SHAPE.
           MOVE    3                TO  WPRTDATA-DRAW-START-X.
           MOVE    14               TO  WPRTDATA-DRAW-START-Y.
           MOVE    40               TO  WPRTDATA-DRAW-STOP-X.
           MOVE    23               TO  WPRTDATA-DRAW-STOP-Y.
           MOVE    WPRTUNITS-CELLS  TO  WPRTDATA-DRAW-UNITS.
           CALL    "WIN$PRINTER"    USING
                   WINPRINT-GRAPH-DRAW
                   WINPRINT-DATA
                   GIVING           CALL-RESULT.

           IF      CALL-RESULT      <  1
                   PERFORM          ERROR-MESSAGE
                   GO               TO DO-GRAPHICS-900.

      *Create a solid pen 30 logical points thick
           INITIALIZE               WPRTDATA-PEN.
           MOVE    WPRT-PEN-SOLID   TO  WPRTDATA-PEN-STYLE.
           MOVE    30               TO  WPRTDATA-PEN-WIDTH.

      *If color support
           IF      WPRT-COLOR
                   MOVE             91  TO RGB-RED
                   MOVE             157 TO RGB-GREEN
                   MOVE             255 TO RGB-BLUE
                   PERFORM          CALC-COLORREF
                   MOVE             COLORREF TO WPRTDATA-PEN-COLOR.

           CALL    "WIN$PRINTER"    USING
                   WINPRINT-GRAPH-PEN
                   WINPRINT-DATA
                   GIVING           CALL-RESULT.

           IF      CALL-RESULT      <  1
                   PERFORM          ERROR-MESSAGE
                   GO               TO DO-GRAPHICS-900.

      * Draw a line to separate order head and body
           INITIALIZE               WPRTDATA-DRAW.
           MOVE    WPRT-DRAW-LINE   TO  WPRTDATA-DRAW-SHAPE.
           MOVE    1                TO  WPRTDATA-DRAW-START-X.
           MOVE    27               TO  WPRTDATA-DRAW-START-Y.
           MOVE    96               TO  WPRTDATA-DRAW-STOP-X.
           MOVE    27               TO  WPRTDATA-DRAW-STOP-Y.
           MOVE    WPRTUNITS-CELLS  TO  WPRTDATA-DRAW-UNITS.
           CALL    "WIN$PRINTER"    USING
                   WINPRINT-GRAPH-DRAW
                   WINPRINT-DATA
                   GIVING           CALL-RESULT.

           IF      CALL-RESULT      <  1
                   PERFORM          ERROR-MESSAGE
                   GO               TO DO-GRAPHICS-900.

      *Create an invisible pen
           INITIALIZE               WPRTDATA-PEN.
           MOVE    WPRT-PEN-NULL    TO  WPRTDATA-PEN-STYLE.
           MOVE    1                TO  WPRTDATA-PEN-WIDTH.
           CALL    "WIN$PRINTER"    USING
                   WINPRINT-GRAPH-PEN
                   WINPRINT-DATA
                   GIVING           CALL-RESULT.

           IF      CALL-RESULT      <  1
                   PERFORM          ERROR-MESSAGE
                   GO               TO DO-GRAPHICS-900.

      *Create an diagonal cross brush
           INITIALIZE               WPRTDATA-BRUSH.
           MOVE    WPRT-BRUSH-DIAGCROSS TO  WPRTDATA-BRUSH-STYLE.

      *If color support
           IF      WPRT-COLOR
                   MOVE             105 TO RGB-RED
                   MOVE             211 TO RGB-GREEN
                   MOVE             108 TO RGB-BLUE
                   PERFORM          CALC-COLORREF
                   MOVE             COLORREF TO WPRTDATA-BRUSH-COLOR.

           CALL    "WIN$PRINTER"    USING
                   WINPRINT-GRAPH-BRUSH
                   WINPRINT-DATA
                   GIVING           CALL-RESULT.

           IF      CALL-RESULT      <  1
                   PERFORM          ERROR-MESSAGE
                   GO               TO DO-GRAPHICS-900.

      * Draw box for a nice end of the order.
           INITIALIZE               WPRTDATA-DRAW.
           MOVE    WPRT-DRAW-ROUND-RECTANGLE TO  WPRTDATA-DRAW-SHAPE.
           MOVE    24               TO  WPRTDATA-DRAW-START-X.
           MOVE    66               TO  WPRTDATA-DRAW-START-Y.
           MOVE    72               TO  WPRTDATA-DRAW-STOP-X.
           MOVE    68               TO  WPRTDATA-DRAW-STOP-Y.
           MOVE    WPRTUNITS-CELLS  TO  WPRTDATA-DRAW-UNITS.
           CALL    "WIN$PRINTER"    USING
                   WINPRINT-GRAPH-DRAW
                   WINPRINT-DATA
                   GIVING           CALL-RESULT.

           IF      CALL-RESULT      <  1
                   PERFORM          ERROR-MESSAGE
                   GO               TO DO-GRAPHICS-900.

      *Create a light gray brush
           INITIALIZE               WPRTDATA-BRUSH.
           MOVE    WPRT-BRUSH-LTGRAY TO  WPRTDATA-BRUSH-STYLE.

           CALL    "WIN$PRINTER"    USING
                   WINPRINT-GRAPH-BRUSH
                   WINPRINT-DATA
                   GIVING           CALL-RESULT.

           IF      CALL-RESULT      <  1
                   PERFORM          ERROR-MESSAGE
                   GO               TO DO-GRAPHICS-900.

      * Draw box background for item line titles
           INITIALIZE               WPRTDATA-DRAW.
           MOVE    WPRT-DRAW-ROUND-RECTANGLE TO  WPRTDATA-DRAW-SHAPE.
           MOVE    1                TO  WPRTDATA-DRAW-START-X.
           MOVE    28.8             TO  WPRTDATA-DRAW-START-Y.
           MOVE    96               TO  WPRTDATA-DRAW-STOP-X.
           MOVE    30.2             TO  WPRTDATA-DRAW-STOP-Y.
           MOVE    WPRTUNITS-CELLS  TO  WPRTDATA-DRAW-UNITS.
           CALL    "WIN$PRINTER"    USING
                   WINPRINT-GRAPH-DRAW
                   WINPRINT-DATA
                   GIVING           CALL-RESULT.

           IF      CALL-RESULT      <  1
                   PERFORM          ERROR-MESSAGE
                   GO               TO DO-GRAPHICS-900.

      * Draw box background for item line totals
           INITIALIZE               WPRTDATA-DRAW.
           MOVE    WPRT-DRAW-ROUND-RECTANGLE TO  WPRTDATA-DRAW-SHAPE.
           MOVE    80               TO  WPRTDATA-DRAW-START-X.
           MOVE    31               TO  WPRTDATA-DRAW-START-Y.
           MOVE    95               TO  WPRTDATA-DRAW-STOP-X.
           MOVE    59               TO  WPRTDATA-DRAW-STOP-Y.
           MOVE    WPRTUNITS-CELLS  TO  WPRTDATA-DRAW-UNITS.
           CALL    "WIN$PRINTER"    USING
                   WINPRINT-GRAPH-DRAW
                   WINPRINT-DATA
                   GIVING           CALL-RESULT.

           IF      CALL-RESULT      <  1
                   PERFORM          ERROR-MESSAGE
                   GO               TO DO-GRAPHICS-900.

      *Create a solid pen 10 logical points thick
           INITIALIZE               WPRTDATA-PEN.
           MOVE    WPRT-PEN-SOLID   TO  WPRTDATA-PEN-STYLE.
           MOVE    10               TO  WPRTDATA-PEN-WIDTH.
           CALL    "WIN$PRINTER"    USING
                   WINPRINT-GRAPH-PEN
                   WINPRINT-DATA
                   GIVING           CALL-RESULT.

           IF      CALL-RESULT      <  1
                   PERFORM          ERROR-MESSAGE
                   GO               TO DO-GRAPHICS-900.

      * Draw box background for order totals
           INITIALIZE               WPRTDATA-DRAW.
           MOVE    WPRT-DRAW-RECTANGLE TO  WPRTDATA-DRAW-SHAPE.
           MOVE    70               TO  WPRTDATA-DRAW-START-X.
           MOVE    62               TO  WPRTDATA-DRAW-START-Y.
           MOVE    95               TO  WPRTDATA-DRAW-STOP-X.
           MOVE    64               TO  WPRTDATA-DRAW-STOP-Y.
           MOVE    WPRTUNITS-CELLS  TO  WPRTDATA-DRAW-UNITS.
           CALL    "WIN$PRINTER"    USING
                   WINPRINT-GRAPH-DRAW
                   WINPRINT-DATA
                   GIVING CALL-RESULT.

           IF      CALL-RESULT      <  1
                   PERFORM          ERROR-MESSAGE
                   GO               TO DO-GRAPHICS-900.

           INITIALIZE               WPRTDATA-PRINT-BITMAP.
           MOVE    WS-LOGO          TO WPRTDATA-BITMAP.

           MOVE    2                TO WPRTDATA-BITMAP-ROW.
           MOVE    57               TO WPRTDATA-BITMAP-COL.
           MOVE    37               TO WPRTDATA-BITMAP-WIDTH.
           MOVE    4                TO WPRTDATA-BITMAP-HEIGHT.
           MOVE    WPRTBITMAP-SCALE-CELLS TO
                                       WPRTDATA-BITMAP-FLAGS.
           CALL    "WIN$PRINTER"    USING
                   WINPRINT-PRINT-BITMAP
                   WINPRINT-DATA.

       DO-GRAPHICS-900.
       DO-GRAPHICS-EXIT.
           EXIT.

      *Initialize printer data
       INIT-PRINTER-DATA SECTION.
       INIT-PRINTER-DATA-001.

           INITIALIZE               WINPRINT-NAME
                                    WINPRINT-PORT
                                    WINPRINT-DRIVER
                                    WINPRINT-DRV-VERSION
                                    WINPRINT-IS-DEFAULT
                                    WINPRINT-COPIES
                                    WINPRINT-ORIENTATION
                                    WINPRINT-QUALITY
                                    WINPRINT-CURR-ORIENTATION
                                    WINPRINT-CURR-COPIES.

       INIT-PRINTER-DATA-900.
       INIT-PRINTER-DATA-EXIT.
           EXIT.

       ABOUT-EVENT SECTION.
       ABOUT-EVENT-001.

           IF      EVENT-CONTROL-ID NOT = 14
           OR      EVENT-TYPE       = MSG-VALIDATE
                   GO               TO ABOUT-EVENT-900.

           STRING  ABOUT-01
                   x"0A"
                   ABOUT-02
                   x"0A"
                   ABOUT-03
                   x"0A"
                   x"0A"
                   ABOUT-04
                   x"0A"
                   ABOUT-05
                   x"0A"
                   ABOUT-06
                   x"0A"
                   ABOUT-07
                   x"0A"
                   ABOUT-08
                   x"0A"
                   ABOUT-09
                   x"0A"
                   ABOUT-10
                   x"0A"
                   ABOUT-11
                   x"0A"
                   DELIMITED        BY SIZE INTO ABOUT-TEXT.

           DISPLAY MESSAGE          BOX
                   ABOUT-TEXT
                   TITLE            "About PrnDemoX"
                   TYPE             1
                   ICON             1.

       ABOUT-EVENT-900.
       ABOUT-EVENT-EXIT.
           EXIT.


      *Calculate COLORREF value
       CALC-COLORREF SECTION.
       CALC-COLORREF-001.

           COMPUTE COLORREF            =
                   (RGB-RED)           +
                   (RGB-GREEN * 256)   +
                   (RGB-BLUE * 65536).

       CALC-COLORREF-900.
       CALC-COLORREF-EXIT.
           EXIT.
