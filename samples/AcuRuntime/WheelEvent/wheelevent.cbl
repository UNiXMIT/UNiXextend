       IDENTIFICATION DIVISION.
       PROGRAM-ID.  WheelEvent.

      * Copyright (C) 2007 Micro Focus. All rights reserved.
      *
      * This sample code is supplied for demonstration purposes only
      * on an "as is" basis and is for use at your own risk.

       WORKING-STORAGE SECTION.
       COPY        "ACUGUI.DEF".
       COPY        "CRTVARS.DEF".

       78  PAGE-SIZE                VALUE 17.
       77  CNTL-FONT                USAGE HANDLE OF FONT SMALL-FONT.
       77  TEST-TYPE                PIC 9.
       	   88 TEST-PAGED-LISTBOX    VALUE 1.
       	   88 TEST-PAGED-GRID       VALUE 2.
       	   88 TEST-CANCELLED        VALUE 3.
       77  STATE-FLAG               PIC X.
           88  READING-FORWARDS     VALUE "F".
           88  READING-BACKWARDS    VALUE "B".
           88  AT-START             VALUE "S".
           88  AT-END               VALUE "E".

       01  WS-DIR-TXT               PIC X(04).

       01  WS-SCROLL-TXT.
           03 FILLER                PIC X(01) VALUE x"09".
           03 WS-SCROLL             PIC ZZZ9.

       01  WS-FLAGS-TXT.
           03 FILLER                PIC X(01) VALUE x"09".
           03 WS-FLAGS              PIC 999.

       77  KEY-STATUS IS SPECIAL-NAMES CRT STATUS
                                    PIC 9(4).
           88  OK-BUTTON-PRESSED    VALUE 10.

       01  DATA-TABLE.
           03  FILLER.
               05 FILLER PIC X(10) VALUE "Gisle     ".
               05 FILLER PIC X(12) VALUE "San Diego   ".
               05 FILLER PIC X(3) VALUE  "CA".
               05 FILLER PIC X(6) VALUE  "000001".
           03  FILLER.
               05 FILLER PIC X(10) VALUE "Alfredo   ".
               05 FILLER PIC X(12) VALUE "San Diego   ".
               05 FILLER PIC X(3) VALUE  "CA".
               05 FILLER PIC X(6) VALUE  "000002".
           03  FILLER.
               05 FILLER PIC X(10) VALUE "Drake     ".
               05 FILLER PIC X(12) VALUE "San Diego   ".
               05 FILLER PIC X(3) VALUE  "CA".
               05 FILLER PIC X(6) VALUE  "000003".
           03  FILLER.
               05 FILLER PIC X(10) VALUE "Douglas   ".
               05 FILLER PIC X(12) VALUE "San Diego   ".
               05 FILLER PIC X(3) VALUE  "CA".
               05 FILLER PIC X(6) VALUE  "000004".
           03  FILLER.
               05 FILLER PIC X(10) VALUE "Becky     ".
               05 FILLER PIC X(12) VALUE "San Diego   ".
               05 FILLER PIC X(3) VALUE  "CA".
               05 FILLER PIC X(6) VALUE  "000005".
           03  FILLER.
               05 FILLER PIC X(10) VALUE "Jon       ".
               05 FILLER PIC X(12) VALUE "San Diego   ".
               05 FILLER PIC X(3) VALUE  "CA".
               05 FILLER PIC X(6) VALUE  "000006".
           03  FILLER.
               05 FILLER PIC X(10) VALUE "Bob       ".
               05 FILLER PIC X(12) VALUE "San Diego   ".
               05 FILLER PIC X(3) VALUE  "CA".
               05 FILLER PIC X(6) VALUE  "000007".
           03  FILLER.
               05 FILLER PIC X(10) VALUE "Robert    ".
               05 FILLER PIC X(12) VALUE "San Diego   ".
               05 FILLER PIC X(3) VALUE  "CA".
               05 FILLER PIC X(6) VALUE  "000008".
           03  FILLER.
               05 FILLER PIC X(10) VALUE "Anna      ".
               05 FILLER PIC X(12) VALUE "San Diego   ".
               05 FILLER PIC X(3) VALUE  "CA".
               05 FILLER PIC X(6) VALUE  "000009".
           03  FILLER.
               05 FILLER PIC X(10) VALUE "Marilyn   ".
               05 FILLER PIC X(12) VALUE "San Diego   ".
               05 FILLER PIC X(3) VALUE  "CA".
               05 FILLER PIC X(6) VALUE  "000010".
           03  FILLER.
               05 FILLER PIC X(10) VALUE "Sharman   ".
               05 FILLER PIC X(12) VALUE "San Diego   ".
               05 FILLER PIC X(3) VALUE  "CA".
               05 FILLER PIC X(6) VALUE  "000011".
           03  FILLER.
               05 FILLER PIC X(10) VALUE "Mark      ".
               05 FILLER PIC X(12) VALUE "San Diego   ".
               05 FILLER PIC X(3) VALUE  "CA".
               05 FILLER PIC X(6) VALUE  "000012".
           03  FILLER.
               05 FILLER PIC X(10) VALUE "Gordon    ".
               05 FILLER PIC X(12) VALUE "San Diego   ".
               05 FILLER PIC X(3) VALUE  "CA".
               05 FILLER PIC X(6) VALUE  "000013".
           03  FILLER.
               05 FILLER PIC X(10) VALUE "John      ".
               05 FILLER PIC X(12) VALUE "San Diego   ".
               05 FILLER PIC X(3) VALUE  "CA".
               05 FILLER PIC X(6) VALUE  "000014".
           03  FILLER.
               05 FILLER PIC X(10) VALUE "Barbara   ".
               05 FILLER PIC X(12) VALUE "San Diego   ".
               05 FILLER PIC X(3) VALUE  "CA".
               05 FILLER PIC X(6) VALUE  "000015".
           03  FILLER.
               05 FILLER PIC X(10) VALUE "Julie     ".
               05 FILLER PIC X(12) VALUE "San Diego   ".
               05 FILLER PIC X(3) VALUE  "CA".
               05 FILLER PIC X(6) VALUE  "000016".
           03  FILLER.
               05 FILLER PIC X(10) VALUE "Annie     ".
               05 FILLER PIC X(12) VALUE "San Diego   ".
               05 FILLER PIC X(3) VALUE  "CA".
               05 FILLER PIC X(6) VALUE  "000017".
           03  FILLER.
               05 FILLER PIC X(10) VALUE "Mary      ".
               05 FILLER PIC X(12) VALUE "San Diego   ".
               05 FILLER PIC X(3) VALUE  "CA".
               05 FILLER PIC X(6) VALUE  "000018".
           03  FILLER.
               05 FILLER PIC X(10) VALUE "Steve     ".
               05 FILLER PIC X(12) VALUE "San Diego   ".
               05 FILLER PIC X(3) VALUE  "CA".
               05 FILLER PIC X(6) VALUE  "000019".
           03  FILLER.
               05 FILLER PIC X(10) VALUE "Jan       ".
               05 FILLER PIC X(12) VALUE "San Diego   ".
               05 FILLER PIC X(3) VALUE  "CA".
               05 FILLER PIC X(6) VALUE  "000020".
           03  FILLER.
               05 FILLER PIC X(10) VALUE "Lisa      ".
               05 FILLER PIC X(12) VALUE "San Diego   ".
               05 FILLER PIC X(3) VALUE  "CA".
               05 FILLER PIC X(6) VALUE  "000021".
           03  FILLER.
               05 FILLER PIC X(10) VALUE "Jennifer  ".
               05 FILLER PIC X(12) VALUE "San Diego   ".
               05 FILLER PIC X(3) VALUE  "CA".
               05 FILLER PIC X(6) VALUE  "000022".
           03  FILLER.
               05 FILLER PIC X(10) VALUE "Daniel    ".
               05 FILLER PIC X(12) VALUE "San Diego   ".
               05 FILLER PIC X(3) VALUE  "CA".
               05 FILLER PIC X(6) VALUE  "000023".
           03  FILLER.
               05 FILLER PIC X(10) VALUE "Sue       ".
               05 FILLER PIC X(12) VALUE "San Diego   ".
               05 FILLER PIC X(3) VALUE  "CA".
               05 FILLER PIC X(6) VALUE  "000024".
           03  FILLER.
               05 FILLER PIC X(10) VALUE "Dawn      ".
               05 FILLER PIC X(12) VALUE "San Diego   ".
               05 FILLER PIC X(3) VALUE  "CA".
               05 FILLER PIC X(6) VALUE  "000025".
           03  FILLER.
               05 FILLER PIC X(10) VALUE "Lori      ".
               05 FILLER PIC X(12) VALUE "San Diego   ".
               05 FILLER PIC X(3) VALUE  "CA".
               05 FILLER PIC X(6) VALUE  "000026".
           03  FILLER.
               05 FILLER PIC X(10) VALUE "Tina      ".
               05 FILLER PIC X(12) VALUE "San Diego   ".
               05 FILLER PIC X(3) VALUE  "CA".
               05 FILLER PIC X(6) VALUE  "000027".
           03  FILLER.
               05 FILLER PIC X(10) VALUE "Cameron   ".
               05 FILLER PIC X(12) VALUE "San Diego   ".
               05 FILLER PIC X(3) VALUE  "CA".
               05 FILLER PIC X(6) VALUE  "000028".
           03  FILLER.
               05 FILLER PIC X(10) VALUE "Kellie    ".
               05 FILLER PIC X(12) VALUE "San Diego   ".
               05 FILLER PIC X(3) VALUE  "CA".
               05 FILLER PIC X(6) VALUE  "000029".
           03  FILLER.
               05 FILLER PIC X(10) VALUE "Bronwyn   ".
               05 FILLER PIC X(12) VALUE "San Diego   ".
               05 FILLER PIC X(3) VALUE  "CA".
               05 FILLER PIC X(6) VALUE  "000030".
           03  FILLER.
               05 FILLER PIC X(10) VALUE "David     ".
               05 FILLER PIC X(12) VALUE "San Diego   ".
               05 FILLER PIC X(3) VALUE  "CA".
               05 FILLER PIC X(6) VALUE  "000031".
           03  FILLER.
               05 FILLER PIC X(10) VALUE "Chuck     ".
               05 FILLER PIC X(12) VALUE "San Diego   ".
               05 FILLER PIC X(3) VALUE  "CA".
               05 FILLER PIC X(6) VALUE  "000032".
           03  FILLER.
               05 FILLER PIC X(10) VALUE "Denise    ".
               05 FILLER PIC X(12) VALUE "San Diego   ".
               05 FILLER PIC X(3) VALUE  "CA".
               05 FILLER PIC X(6) VALUE  "000033".
           03  FILLER.
               05 FILLER PIC X(10) VALUE "Martin    ".
               05 FILLER PIC X(12) VALUE "London      ".
               05 FILLER PIC X(3) VALUE  "UK".
               05 FILLER PIC X(6) VALUE  "000034".
           03  FILLER.
               05 FILLER PIC X(10) VALUE "Mark      ".
               05 FILLER PIC X(12) VALUE "London      ".
               05 FILLER PIC X(3) VALUE  "UK".
               05 FILLER PIC X(6) VALUE  "000035".
           03  FILLER.
               05 FILLER PIC X(10) VALUE "Jawad     ".
               05 FILLER PIC X(12) VALUE "London      ".
               05 FILLER PIC X(3) VALUE  "UK".
               05 FILLER PIC X(6) VALUE  "000036".
           03  FILLER.
               05 FILLER PIC X(10) VALUE "Piet      ".
               05 FILLER PIC X(12) VALUE "Utrecth     ".
               05 FILLER PIC X(3) VALUE  "NL".
               05 FILLER PIC X(6) VALUE  "000037".
           03  FILLER.
               05 FILLER PIC X(10) VALUE "Pieter    ".
               05 FILLER PIC X(12) VALUE "Utrecth     ".
               05 FILLER PIC X(3) VALUE  "NL".
               05 FILLER PIC X(6) VALUE  "000038".
           03  FILLER.
               05 FILLER PIC X(10) VALUE "Paola     ".
               05 FILLER PIC X(12) VALUE "Utrecth     ".
               05 FILLER PIC X(3) VALUE  "NL".
               05 FILLER PIC X(6) VALUE  "000039".
           03  FILLER.
               05 FILLER PIC X(10) VALUE "Jens      ".
               05 FILLER PIC X(12) VALUE "München     ".
               05 FILLER PIC X(3) VALUE  "DE".
               05 FILLER PIC X(6) VALUE  "000040".
       01  CUSTOMERS REDEFINES DATA-TABLE
           OCCURS 40 TIMES INDEXED BY NAME-IDX.
           03  CUST-NAME            PIC X(10).
           03  CUST-CITY            PIC X(12).
           03  CUST-STATE           PIC X(03).
           03  CUST-AMOUNT          PIC X(06).

       77  LIST-DATA                PIC X(30).
       77  SB-HANDLE                HANDLE OF STATUS-BAR.

       SCREEN SECTION.
       01  PAGED-LIST-SCREEN.
           03  LABEL                "Paged list box example:"
               LINE                 1
               COL                  4.
           03  LABEL                "Corporation"
               LINE                 3
               SIZE                 12
               COL                  5.
           03  LABEL                "City"
               LINE                 3
               SIZE                 6
               COL                  16.
           03  LABEL                "State"
               LINE                 3
               SIZE                 5
               COL                  30.
           03  LABEL                "Number"
               LINE                 3
               SIZE                 8
               COL                  38.

           03  PgListBx             LIST-BOX USING LIST-DATA
               PAGED
               3-D
               LINE                 4.5
               COL                  5
               SIZE                 40
               LINES                PAGE-SIZE
               UPPER
               DATA-COLUMNS         (
                                    RECORD-POSITION OF CUST-NAME,
                                    RECORD-POSITION OF CUST-CITY,
                                    RECORD-POSITION OF CUST-STATE,
                                    RECORD-POSITION OF CUST-AMOUNT
                                    )
               DISPLAY-COLUMNS      (1, 13, 25, 33)
               ALIGNMENT            ("L", "L", "L", "R")
               SEPARATION           (0, 0, 0, 4)
               DIVIDERS             (2, 1, 1, 1)
               ID                   100
               EVENT PROCEDURE IS PAGED-LIST-EVENTS.

           03  PUSH-BUTTON          "&About"
               LINE                 32
               COL                  25
               ID                   900
               EVENT                PROCEDURE IS ABOUT-EVENT.

           03  PUSH-BUTTON          "E&xit"
               TERMINATION-VALUE    10
               LINE                 32
               COL                  39.


       01  PAGED-GRID-SCREEN.
           03  LABEL                "Paged grid example:"
               LINE                 1
               COL                  4.

           03  PgGrid               Grid,
               COL                  5
               LINE                 4.5
               LINES                PAGE-SIZE
               SIZE                 40
               3-D
               DATA-COLUMNS         (
                                    RECORD-POSITION OF CUST-NAME,
                                    RECORD-POSITION OF CUST-CITY,
                                    RECORD-POSITION OF CUST-STATE,
                                    RECORD-POSITION OF CUST-AMOUNT
                                    )
               DISPLAY-COLUMNS      (1, 13, 25, 33)
               SEPARATION           (0, 0, 0, 4)
               HEADING-COLOR        257
               NUM-ROWS             PAGE-SIZE
               PAGED
               TILED-HEADINGS
               VPADDING             50
               ID                   100
               EVENT PROCEDURE IS PAGED-GRID-EVENTS.

           03  PUSH-BUTTON          "&About"
               LINE                 32
               COL                  25
               ID                   900
               EVENT                PROCEDURE IS ABOUT-EVENT.

           03  PUSH-BUTTON
               "E&xit"
               TERMINATION-VALUE    10
               LINE                 32
               COL                  39.

       PROCEDURE DIVISION.
       MAIN-LOGIC.
           DISPLAY STANDARD         GRAPHICAL WINDOW
                   CONTROL          FONT CNTL-FONT
                   SIZE             50
                   LINES            35
                   TITLE            "Wheelmouse events"
                   BACKGROUND-LOW.

           DISPLAY MESSAGE          BOX
                   "Press YES for Paged LISTBOX"
                   x"0a"
                   "Press NO for Paged GRID"
                   x"0a"
                   "Press CANCEL to abort"
                   TYPE             4
                   DEFAULT          1
                   ICON             1
                   GIVING           TEST-TYPE.

           IF      TEST-PAGED-LISTBOX
                   DISPLAY          PAGED-LIST-SCREEN
           ELSE    IF               TEST-PAGED-GRID
                   DISPLAY          PAGED-GRID-SCREEN
           ELSE
                   GO               TO MAIN-LOGIC-EXIT
                   END-IF.

	   DISPLAY STATUS-BAR
                   PANEL-WIDTHS     (11, 5, 11, 5, 11, 5)
                   PANEL-STYLE      (0, 1, 0, 1, 0, 1)
                   PANEL-TEXT       ("Direction", " N/A",
                                     "Scrollines", " N/A",
                                     "Flags", " N/A")
                   HANDLE            IN SB-HANDLE.
           INITIALIZE               NAME-IDX.
           PERFORM GET-NEXT-ITEM    PAGE-SIZE TIMES.
           PERFORM WITH             TEST AFTER
                   UNTIL            OK-BUTTON-PRESSED
                   IF               TEST-PAGED-LISTBOX
                                    ACCEPT PAGED-LIST-SCREEN
                                           END-ACCEPT
                                    END-IF
                   IF               TEST-PAGED-GRID
                                    ACCEPT PAGED-GRID-SCREEN
                                           END-ACCEPT
                                    END-IF
           END-PERFORM
           .

       MAIN-LOGIC-EXIT.
           STOP    RUN.

       ABOUT-EVENT.

           IF      EVENT-CONTROL-ID NOT = 900
           OR      EVENT-TYPE       NOT = CMD-CLICKED
                   EXIT             PARAGRAPH
                   END-IF

           DISPLAY MESSAGE          BOX
                   "This program illustrates how paged listboxes"
                   " and paged grids can be controlled by mousewheel"
                   " events."
                   x"0a"
                   "The new events are respectively:"
                   x"0a" x"0a" x"09"
                   "Paged GRID:"
                   x"0a" x"09" x"09"
                   "MSG-PAGED-NEXT-WHEEL, MSG-PAGED-PREV-WHEEL"
                   x"0a" x"09"
                   "Paged LISTBOX:"
                   x"0a" x"09" x"09"
                   "NTF-PL-NEXT-WHEEL, NTF-PL-PREV-WHEEL"
                   x"0a" x"0a"
                   "Along with these events you will also receive"
                   " the number of lines to scroll as set in the"
                   " registry."
                   x"0a"
                   "Note that there is a dedicated value for page"
                   " scroll that may have been set."
                   x"0a" x"0a"
                   "Finally, you also get to know if the user has"
                   " hold in CONTROL, SHIFT, Left/Right Mouse button"
                   " or one of the X buttons while scrolling."
                   x"0a"
                   "These values are reported in respectively"
                   " EVENT-DATA-1 (scrollines), EVENT-DATA-2 (keys)."
                   x"0a" x"0a"
                   "This program does in addition to actually respond"
                   " to the events also display the event data in the"
                   " statusbar."
                   TITLE            "About Wheelmouse events"
                   TYPE             1
           MOVE    4                TO ACCEPT-CONTROL
           MOVE    100              TO CONTROL-ID
           EXIT    PARAGRAPH.

       PAGED-GRID-EVENTS.

           EVALUATE                 EVENT-TYPE
                   WHEN             MSG-PAGED-NEXT
                                    PERFORM GET-NEXT-ITEM
                   WHEN             MSG-PAGED-PREV
                                    PERFORM GET-PREV-ITEM
                   WHEN             MSG-PAGED-PREV-WHEEL
                                    PERFORM UPDATE-STATUS-BAR
				    PERFORM EVENT-DATA-2 TIMES
                                    	PERFORM GET-PREV-ITEM
                                    	END-PERFORM
                   WHEN             MSG-PAGED-NEXT-WHEEL
                                    PERFORM UPDATE-STATUS-BAR
				    PERFORM EVENT-DATA-2 TIMES
                                    	PERFORM GET-NEXT-ITEM
                                    	END-PERFORM
                   WHEN             MSG-PAGED-NEXTPAGE
                                    MODIFY PgGrid
                                           MASS-UPDATE = 1
                                    PERFORM GET-NEXT-ITEM
                                           PAGE-SIZE TIMES
                                    MODIFY PgGrid
                                           MASS-UPDATE = 0

                   WHEN             MSG-PAGED-PREVPAGE
                                    MODIFY PgGrid
                                           MASS-UPDATE = 1
                                    PERFORM GET-PREV-ITEM
                                           PAGE-SIZE TIMES
                                    MODIFY PgGrid
                                           MASS-UPDATE = 0
                   WHEN             MSG-PAGED-FIRST
                                    INITIALIZE NAME-IDX
                                    MODIFY PgGrid
                                           MASS-UPDATE = 1
                                           RESET-GRID = 1
                                    PERFORM GET-NEXT-ITEM
                                           PAGE-SIZE TIMES
                                    MODIFY PgGrid
                                           MASS-UPDATE = 0

                   WHEN             MSG-PAGED-LAST
                                    MOVE   HIGH-VALUES TO NAME-IDX
                                    MODIFY PgGrid
                                           MASS-UPDATE = 1
                                           RESET-GRID = 1
                                    PERFORM GET-PREV-ITEM
                                           PAGE-SIZE TIMES
                                    MODIFY PgGrid
                                           MASS-UPDATE = 0

           END-EVALUATE
           .

       PAGED-LIST-EVENTS.

           IF      KEY-STATUS       NOT = W-EVENT
                   EXIT             PARAGRAPH
                   END-IF

           EVALUATE                 EVENT-TYPE
                   WHEN             NTF-PL-NEXT
                                    PERFORM GET-NEXT-ITEM
                   WHEN             NTF-PL-PREV
                                    PERFORM GET-PREV-ITEM
                   WHEN             NTF-PL-PREV-WHEEL
                                    PERFORM UPDATE-STATUS-BAR
				    PERFORM EVENT-DATA-2 TIMES
                                    	PERFORM GET-PREV-ITEM
                                    	END-PERFORM
                   WHEN             NTF-PL-NEXT-WHEEL
                                    PERFORM UPDATE-STATUS-BAR
				    PERFORM EVENT-DATA-2 TIMES
                                    	PERFORM GET-NEXT-ITEM
                                    	END-PERFORM
                   WHEN             NTF-PL-NEXTPAGE
                                    MODIFY PgListBx
                                           MASS-UPDATE = 1
                                    PERFORM GET-NEXT-ITEM
                                           PAGE-SIZE TIMES
                                    MODIFY PgListBx
                                           MASS-UPDATE = 0

                   WHEN             NTF-PL-PREVPAGE
                                    MODIFY PgListBx
                                           MASS-UPDATE = 1
                                    PERFORM GET-PREV-ITEM
                                           PAGE-SIZE TIMES
                                    MODIFY PgListBx
                                           MASS-UPDATE = 0
                   WHEN             NTF-PL-FIRST
                                    INITIALIZE NAME-IDX
                                    MODIFY PgListBx
                                           MASS-UPDATE = 1
                                           RESET-LIST = 1
                                    PERFORM GET-NEXT-ITEM
                                           PAGE-SIZE TIMES
                                    MODIFY PgListBx
                                           MASS-UPDATE = 0

                   WHEN             NTF-PL-LAST
                                    MOVE   HIGH-VALUES TO NAME-IDX
                                    MODIFY PgListBx
                                           MASS-UPDATE = 1
                                           RESET-LIST = 1
                                    PERFORM GET-PREV-ITEM
                                           PAGE-SIZE TIMES
                                    MODIFY PgListBx
                                           MASS-UPDATE = 0

                   WHEN NTF-PL-SEARCH
                                    INQUIRE PgListBx
                                            SEARCH-TEXT IN LIST-DATA
                                    SEARCH  CUSTOMERS
                                            AT END EXIT PARAGRAPH
                                            WHEN CUST-NAME(NAME-IDX) =
                                                 LIST-DATA
                                               PERFORM INCREMENT-SEARCH
                                            END-SEARCH
           END-EVALUATE
           .

       INCREMENT-SEARCH.
           MOVE    CUST-NAME(NAME-IDX) TO LIST-DATA
           SET     AT-START TO TRUE
           SUBTRACT 1               FROM NAME-IDX
           MODIFY  PgListBx           MASS-UPDATE = 1
           PERFORM GET-NEXT-ITEM    PAGE-SIZE TIMES
           MODIFY  PgListBx           MASS-UPDATE = 0
           .


       GET-NEXT-ITEM.

           IF      READING-BACKWARDS
                   ADD              PAGE-SIZE TO NAME-IDX
           ELSE
                   ADD              1 TO NAME-IDX
                   END-IF

           IF      NAME-IDX         > 40
                   MOVE             40 TO NAME-IDX
                   EXIT             PARAGRAPH
                   END-IF

           IF      TEST-PAGED-LISTBOX
                   MODIFY           PgListBx
                                    ITEM-TO-ADD = CUSTOMERS(NAME-IDX)
           ELSE
                   MODIFY           PgGrid
                                    RECORD-TO-ADD = CUSTOMERS(NAME-IDX)
                   END-IF
           SET     READING-FORWARDS TO TRUE
           .

       GET-PREV-ITEM.

           IF      READING-FORWARDS
                   SUBTRACT         PAGE-SIZE FROM NAME-IDX
           ELSE
                   SUBTRACT         1 FROM NAME-IDX
                   END-IF

           IF      NAME-IDX         < 1
                   MOVE             1 TO NAME-IDX
                   EXIT             PARAGRAPH
                   END-IF

           IF      TEST-PAGED-LISTBOX
                   MODIFY           PgListBx
                                    INSERTION-INDEX  = 1
                                    ITEM-TO-ADD = CUSTOMERS(NAME-IDX)
           ELSE
                   MODIFY           PgGrid
                                    INSERTION-INDEX  = 1
                                    RECORD-TO-ADD = CUSTOMERS(NAME-IDX)
                   END-IF

           SET     READING-BACKWARDS TO TRUE
           .

       UPDATE-STATUS-BAR.

           IF      EVENT-TYPE       = MSG-PAGED-PREV-WHEEL
           OR      EVENT-TYPE       = NTF-PL-PREV-WHEEL
                   STRING           x"09" "Fwd" DELIMITED BY SIZE INTO
                                    WS-DIR-TXT
           ELSE
                   STRING           x"09" "Bwd" DELIMITED BY SIZE INTO
                                    WS-DIR-TXT
                   END-IF

           IF      EVENT-DATA-2     = WHEEL-PAGESCROLL
                   MOVE             "PAGE" TO WS-SCROLL-TXT
           ELSE
                   MOVE             EVENT-DATA-2 TO WS-SCROLL
                   END-IF

           MOVE    EVENT-DATA-1     TO WS-FLAGS.
           MODIFY  SB-HANDLE
                   PANEL-INDEX      2
                   PANEL-TEXT       = WS-DIR-TXT
                   PANEL-INDEX      4
                   PANEL-TEXT       = WS-SCROLL-TXT
                   PANEL-INDEX      6
                   PANEL-TEXT       = WS-FLAGS-TXT
           EXIT    PARAGRAPH.
