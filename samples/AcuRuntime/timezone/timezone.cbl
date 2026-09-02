       IDENTIFICATION               DIVISION.
       PROGRAM-ID.                  Timezone.
       WORKING-STORAGE SECTION.
       77  CNTL-FONT                USAGE HANDLE OF FONT SMALL-FONT.
       77  KEY-STATUS               IS SPECIAL-NAMES
           CRT STATUS               PIC 9(4) VALUE 0.
           88  EXIT-PRESSED         VALUE 27.
       77  WS-RESULT                PIC S9(9) COMP-5.
       77  WS-I                     PIC 9(2).
       77  WS-J                     PIC 9(2).
       77  WS-CHAR                  PIC X.
       77  GMT-TIME-VIS             PIC Z9.

       01  TIMEZONE.
           03 BIAS                  PIC S9(9) COMP-5.
           03 STANDARD-NAME         PIC X(64).

       01 FORMATTED-OUTPUT.
          03 TIME-ZONE-BIAS         PIC ----9.
          03 TIME-ZONE-TXT          PIC X(32).
          03 TIME-ZONE-DAYOFWEEK    PIC 9.
          03 TIME-ZONE-DATE.
             05 TIME-ZONE-MONTH     PIC 99.
             05 FILLER              PIC X(1) VALUE ".".
             05 TIME-ZONE-DAY       PIC 99.
             05 FILLER              PIC X(1) VALUE ".".
             05 TIME-ZONE-YEAR      PIC 99.

       77 EDITOR-STRING             PIC X(60) OCCURS 3.

       SCREEN      SECTION.
       01  TEMPLATE-SCREEN.

           03      PUSH-BUTTON
                   LINE             7
                   COL              25
                   SIZE             14
                   TITLE            "E&xit"
                   SELF-ACT
                   EXCEPTION-VALUE  = 27.

           03      LINE             01
                   COL              02.

           03      ENTRY-FIELD      OCCURS 3
                   LINE             + 1
                   COL              02
                   SIZE             60
                   LINES            01
                   VALUE            EDITOR-STRING
                   READ-ONLY
                   3-D.

       PROCEDURE DIVISION.
       MAIN-LOGIC.

           DISPLAY STANDARD         GRAPHICAL WINDOW
                   TITLE            "Template"
                   CONTROL          FONT CNTL-FONT
                   SIZE             63
                   LINES            9
                   BACKGROUND-LOW.

	   PERFORM INITIALIZE-DATA.
           PERFORM WITH TEST AFTER  UNTIL EXIT-PRESSED
                   ACCEPT           TEMPLATE-SCREEN
           END-PERFORM.
           DESTROY TEMPLATE-SCREEN.
           STOP    RUN.

       INITIALIZE-DATA.

           INITIALIZE               KEY-STATUS
                                    EDITOR-STRING(1)
                                    EDITOR-STRING(2)
                                    EDITOR-STRING(3).
      *                              EDITOR-STRING(4)
      *                              EDITOR-STRING(5)
      *                              EDITOR-STRING(6)
      *                              EDITOR-STRING(7)
      *                              EDITOR-STRING(8)
      *                              EDITOR-STRING(9).
           DISPLAY TEMPLATE-SCREEN.
           CALL    "KERNEL32.DLL".
           PERFORM FETCH-TIMEZONE-INFO.
           CANCEL  "KERNEL32.DLL".
           EXIT    PARAGRAPH.

       FETCH-TIMEZONE-INFO.

           INITIALIZE               BIAS
                                    STANDARD-NAME
           CALL    "GetTimeZoneInformation" USING
                   BY REFERENCE     TIMEZONE
                   GIVING           WS-RESULT
                   END-CALL

           EVALUATE                 WS-RESULT
                   WHEN             0
                                    DISPLAY MESSAGE BOX
                                            "Unknown time zone error"
                                            TITLE "Error"
                   WHEN             1
                                   DISPLAY "This PC is on standard time"
                                            UPON GLOBAL TITLE
                   WHEN             2
                                    DISPLAY "This PC is on daylight savi
      -                                     "ngs time"
                                            UPON GLOBAL TITLE
                   WHEN             OTHER
                                    DISPLAY MESSAGE BOX
                                            "Unknown error occured"
                                            TITLE "Error"
           END-EVALUATE
           MOVE    BIAS             TO TIME-ZONE-BIAS
           STRING  "Bias: "
                   TIME-ZONE-BIAS   DELIMITED BY SIZE
                   " minutes"
                   INTO             EDITOR-STRING(1)
           INITIALIZE               WS-J
           PERFORM VARYING          WS-I FROM 1 BY 2 UNTIL WS-I > 31
                   ADD              1 TO WS-J
                   MOVE             STANDARD-NAME(WS-I:1) TO
                                    WS-CHAR
                   MOVE             WS-CHAR TO
                                    TIME-ZONE-TXT(WS-J:1)
                   END-PERFORM
           STRING  "Time Zone: "
                   TIME-ZONE-TXT    DELIMITED BY SIZE
                   INTO             EDITOR-STRING(2)

           DIVIDE  BIAS             BY 60 GIVING GMT-TIME-VIS

           IF      BIAS             < 0
                   STRING  "This PC is " 
                           GMT-TIME-VIS
                           " hours ahead of Greenwich Mean Time"
                           INTO EDITOR-STRING(3)
           ELSE
                   STRING "This PC is " 
                          GMT-TIME-VIS
                          " hours after of Greenwich Mean Time"
                          INTO EDITOR-STRING(3)
                   END-IF
           DISPLAY TEMPLATE-SCREEN
           EXIT    PARAGRAPH.