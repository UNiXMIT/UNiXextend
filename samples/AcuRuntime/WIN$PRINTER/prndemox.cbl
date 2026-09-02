       IDENTIFICATION DIVISION.
       PROGRAM-ID. PRNDEMOX.
       DATE-WRITTEN. 1999/01/15 AM 09:22.
       REMARKS.
      *This program illustrates manipulation of the Windows printspooler using
      *WIN$PRINTER features.
      *
      *This is program PRNDEMOX is inherited from PRNDEMO and shows additional
      *features to manipulate the Windows print spooler introduced with
      *Acucobol v. 5.2
      *
      * Copyright (c) 1996-2010 by Micro Focus. Users of ACUCOBOL-GT
      * may freely modify and redistribute this program.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT PRINT-FILE
           ASSIGN TO PRINTER "-P SPOOLER"
           LINE SEQUENTIAL
           FILE STATUS IS PRINTER-ERRSTAT.

       DATA DIVISION.
       FILE SECTION.
       FD  PRINT-FILE.
       01  PRINT-RECORD                        PIC X(80).

       WORKING-STORAGE SECTION.
      * ACUCOBOL-GT PREDEFINED LIBRARIES
            COPY "ACUGUI.DEF".
            COPY "WINPRINT.DEF".
      * ACUCOBOL-GT PREDEFINED LIBRARIES FOR CUSTOMIZED FONTS DEFINITION
            COPY "FONTS.DEF".
            COPY "CRTVARS.DEF".

       77  KEY-STATUS IS SPECIAL-NAMES CRT STATUS PIC 9(5) VALUE 0.
       77  MSG-TXT                  PIC X(100) VALUE SPACE.
       77  WS-COUNT                 PIC 9(03) VALUE 0.
       77  PRNLIST-IDX              PIC 9(03) VALUE 0.
       77  CALL-RESULT              SIGNED-INT VALUE 0.
       77  WS-STD-FONT              HANDLE OF FONT VALUE NULL.
       77  MWIN-HANDLE              HANDLE OF WINDOW VALUE NULL.
       77  UPDATING                 PIC 9(01) VALUE 0.
       77  PRINTER-ADD              PIC X(80).
       77  WS-HA                    pic 9(03).
       77  WS-HB                    pic 9(03).
       77  WS-HS                    PIC X(34).
       77  LAST-PRN-STATUS          PIC X(35).
       77  LAST-JOB-STATUS          PIC X(35).
       77  JOB-CANCEL-ENABLE        PIC 9 VALUE 0.
       77  JOB-PAUSE-ENABLE         PIC 9 VALUE 0.
       77  JOB-RESUME-ENABLE        PIC 9 VALUE 0.
       77  WS-PAPERSIZE             SIGNED-SHORT VALUE 0.
       77  WS-TRAY                  SIGNED-SHORT VALUE 0.

       78  PRINTER-LIST-ID          VALUE 1.
       78  JOB-CANCEL-ID            VALUE 2.
       78  JOB-PAUSE-ID             VALUE 3.
       78  JOB-RESUME-ID            VALUE 4.
       78  PRINT-EVENT-ID           VALUE 5.
       78  ABOUT-EVENT-ID           VALUE 6.
       78  SETUP-EVENT-ID           VALUE 7.

       78  GRP-PORTRAIT-ID          VALUE 1.
       78  GRP-LANDSCAPE-ID         VALUE 2.

       78  GRP-SIMPLEX-ID           VALUE 1.
       78  GRP-DUPLEX-VERT-ID       VALUE 2.
       78  GRP-DUPLEX-HOR-ID        VALUE 3.

       78  GRP-ORIENTATION          VALUE 1.
       78  GRP-DUPLEX               VALUE 2.

       78  CANCEL-PROGRAM-ID        VALUE 27.

       77  ABOUT-TEXT               PIC X(512).
       77  ABOUT-01                 PIC X(60) VALUE
           "This program demonstrates the new features in eXtend 5.2".
       77  ABOUT-02                 PIC X(60) VALUE
           "to manipulate Windows printer drivers through use of new".
       77  ABOUT-03                 PIC X(60) VALUE
           "functionality in WIN$PRINTER:".
       77  ABOUT-04                 PIC X(60) VALUE
           "   o WINPRINT-GET-PRINTER-INFO-EX".
       77  ABOUT-05                 PIC X(60) VALUE
           "   o WINPRINT-SET-PRINTER-EX".
       77  ABOUT-06                 PIC X(60) VALUE
           "   o WINPRINT-GET-CURRENT-INFO-EX".
       77  ABOUT-07                 PIC X(60) VALUE
           "   o WINPRINT-GET-PRINTER-STATUS".
       77  ABOUT-08                 PIC X(60) VALUE
           "   o WINPRINT-GET-PRINTER-MEDIA".

      *Visual variables.
       01  MISC-TMP-VARS.
           03 DEFPRN-ENABLE         PIC 9.
           03 LNDSCP-ENABLE         PIC 9.
           03 ORIENT-VALUE          PIC 9.
           03 DUPLEX-ENABLE         PIC 9.
           03 DUPLEX-VALUE          PIC 9.
           03 COLLATE-ENABLE        PIC 9.
           03 COLLATE-VALUE         PIC 9.
           03 COLOR-ENABLE          PIC 9.
           03 COLOR-VALUE           PIC 9.
           03 COPIES-ENABLE         PIC 9.
           03 MAX-COPIES            SIGNED-SHORT.
           03 JOB-TITLE-VALUE       PIC X(30).
           03 COPIES-VALUE          PIC 9(03).
           03 DRVVERS-VALUE         PIC 9(04).
           03 DRVNAME-VALUE         PIC X(80).
           03 PORTS-VALUE           PIC X(80).
           03 CHOSEN-PRINTER        PIC X(80).
           03 CHOSEN-QUALITY        PIC X(20).
           03 CHOSEN-PAPER-SIZE     PIC X(34).
           03 CHOSEN-PAPER-TRAY     PIC X(34).
           03 JOB-NO                PIC Z(8)9.
           03 PRN-STATUS            PIC X(35).
           03 JOB-STATUS            PIC X(35).

       01  WINVERSION-DATA.
           03 WIN-MAJOR-VERSION     PIC X COMP-X.
           03 WIN-MINOR-VERSION     PIC X COMP-X.
           03 WIN-PLATFORM          PIC X COMP-X.
              88 PLATFORM-WIN-31    VALUE 1.
              88 PLATFORM-WIN-95    VALUE 2.
              88 PLATFORM-WIN-NT    VALUE 3.
           03 WIN-WORDSIZE          PIC X COMP-X.
              88 WIN-WORDSIZE-16    VALUE 1.
              88 WIN-WORDSIZE-32    VALUE 2.

       01  PRINTER-ERR-MSG.
           03 FILLER                PIC X(15) VALUE "Printer error #".
           03 PRINTER-ERRSTAT       PIC X(2).
           03 FILLER                PIC X(13) VALUE " has occured!".
           03 FILLER                PIC X(01) VALUE X"0D".
           03 STATUS-VALUE          PIC X(20) VALUE SPACE.
           03 FILLER                PIC X(01) VALUE X"0D".
           03 STATUS-TXT            PIC X(60) VALUE SPACE.

       01  PRINTER-STATUS-TITLE.
           03 FILLER                PIC X(01) VALUE X"09".
           03 FILLER                PIC X(08) VALUE "Printer:".

       01  JOB-STATUS-TITLE.
           03 FILLER                PIC X(01) VALUE X"09".
           03 FILLER                PIC X(04) VALUE "Job:".

       01  SPOOLER-ERR-MSG.
           03 FILLER                PIC X(11) VALUE "GDI error: ".
           03 SPOOLER-ERR-NO        PIC 9(09).

       01  JOB-PROGRESS.
           03 FILLER                PIC X(06) VALUE " page: ".
           03 PROGRESS-START        PIC ZZ9.
           03 FILLER                PIC X(04) VALUE " of ".
           03 PROGRESS-TOTAL        PIC ZZ9.

       01  MAX-COPIES-VALUE.
           03 FILLER                PIC X(06) VALUE "(Max: ".
           03 MAX-COPIES-VIS        PIC Z(05).
           03 FILLER                PIC X(01) VALUE ")".

       01  DRIVER-PROGRESS          PIC X(20).

       01  USER-DEFINED.
           03 FILLER                PIC X(13) VALUE "User defined ".
           03 USR-DEF                    PIC 999.

       01  UNDEFINED.
           03 FILLER                PIC X(08) VALUE "Unknown ".
           03 UN-DEF                    PIC 999.

       01  TABLES.
           03  QUALITY-ITEMS.
               05 FILLER            PIC X(20) VALUE "Default".
               05 FILLER            PIC X(20) VALUE "High".
               05 FILLER            PIC X(20) VALUE "Medium".
               05 FILLER            PIC X(20) VALUE "Low".
               05 FILLER            PIC X(20) VALUE "Draft".
           03 QUALITY-TABLE REDEFINES QUALITY-ITEMS OCCURS 5 PIC X(20).
           03 PRINTERS-TABLE        PIC X(80) OCCURS 30.

       SCREEN SECTION.

       01  PRINTER-LABELS.

           03 FRAME,
              COL                   6 PIXELS,
              LINE                  5 PIXELS,
              LINES                 105 PIXELS,
              SIZE                  550 PIXELS,
              FONT                  IS WS-STD-FONT,
              TITLE                 "Printer",
              ENGRAVED,
              TITLE-POSITION        1.

           03 LABEL,
              COL                   20 PIXELS,
              LINE                  25 PIXELS,
              FONT                  IS WS-STD-FONT,
              TITLE                 "Name:",
              LEFT.

           03 LABEL,
              COL                   20 PIXELS,
              LINE                  45 PIXELS,
              FONT                  IS WS-STD-FONT,
              TITLE                 "Port:",
              LEFT.

           03 LABEL,
              COL                   20 PIXELS,
              LINE                  65 PIXELS,
              FONT                  IS WS-STD-FONT,
              TITLE                 "Driver:",
              LEFT.

           03 LABEL,
              COL                   475 PIXELS,
              LINE                  65 PIXELS,
              FONT                  IS WS-STD-FONT,
              TITLE                 "Ver:",
              LEFT.

           03 LABEL,
              COL                   20 PIXELS,
              LINE                  85 PIXELS,
              FONT                  IS WS-STD-FONT,
              TITLE                 "Windows def:",
              LEFT.

           03 FRAME,
              COL                   6 PIXELS,
              LINE                  120 PIXELS,
              LINES                 200 PIXELS
              SIZE                  550 PIXELS
              FONT                  IS WS-STD-FONT,
              TITLE                 "Job attributes",
              ENGRAVED,
              TITLE-POSITION        1.

           03 LABEL,
              COL                   14 PIXELS,
              LINE                  140 PIXELS,
              FONT                  IS WS-STD-FONT,
              TITLE                 "Orientation:",
              LEFT.

           03 LABEL,
              COL                   350 PIXELS,
              LINE                  140 PIXELS,
              FONT                  IS WS-STD-FONT,
              TITLE                 "Duplex:",
              LEFT.

           03 LABEL,
              COL                   350 PIXELS,
              LINE                  215 PIXELS,
              FONT                  IS WS-STD-FONT,
              TITLE                 "Copies:",
              LEFT.

           03 LABEL,
              COL                   14 PIXELS,
              LINE                  190 PIXELS,
              FONT                  IS WS-STD-FONT,
              TITLE                 "Print quality:",
              LEFT.

           03 LABEL,
              COL                   14 PIXELS,
              LINE                  220 PIXELS,
              FONT                  IS WS-STD-FONT,
              TITLE                 "Paper size:",
              LEFT.

           03 LABEL,
              COL                   14 PIXELS,
              LINE                  250 PIXELS,
              FONT                  IS WS-STD-FONT,
              TITLE                 "Paper tray:",
              LEFT.

           03 LABEL,
              COL                   350 PIXELS,
              LINE                  240 PIXELS,
              FONT                  IS WS-STD-FONT,
              TITLE                 "Collate:",
              LEFT.

           03 LABEL,
              COL                   350 PIXELS,
              LINE                  265 PIXELS,
              FONT                  IS WS-STD-FONT,
              TITLE                 "Color:",
              LEFT.

           03 LABEL,
              COL                   14 PIXELS,
              LINE                  290 PIXELS,
              FONT                  IS WS-STD-FONT,
              TITLE                 "Job title:",
              LEFT.

           03 JOB-BUTTONS.

              05 PUSH-BUTTON,
                 COL                10 PIXELS,
                 LINE               331 PIXELS,
                 LINES              30 PIXELS,
                 SIZE               70 PIXELS,
                 FONT               IS WS-STD-FONT,
                 ID                 IS JOB-CANCEL-ID,
                 EVENT              PROCEDURE IS JOB-EVENT,
                 ENABLED            JOB-CANCEL-ENABLE,
                 TITLE              "&Cancel job",
                 SELF-ACT.

              05 PUSH-BUTTON,
                 COL                100 PIXELS,
                 LINE               331 PIXELS,
                 LINES              30 PIXELS,
                 SIZE               70 PIXELS,
                 FONT               IS WS-STD-FONT,
                 ID                 IS JOB-PAUSE-ID,
                 EVENT              PROCEDURE IS JOB-EVENT,
                 ENABLED            JOB-PAUSE-ENABLE,
                 TITLE              "P&ause Job",
                 SELF-ACT.

              05 PUSH-BUTTON,
                 COL                190 PIXELS,
                 LINE               331 PIXELS,
                 LINES              30 PIXELS,
                 SIZE               70 PIXELS,
                 FONT               IS WS-STD-FONT,
                 ID                 IS JOB-RESUME-ID,
                 EVENT              PROCEDURE IS JOB-EVENT,
                 ENABLED            JOB-RESUME-ENABLE,
                 TITLE              "&Restart job",
                 SELF-ACT.

           03 PUSH-BUTTON,
              COL                   300 PIXELS,
              LINE                  331 PIXELS,
              LINES                 30 PIXELS,
              SIZE                  70 PIXELS,
              FONT                  IS WS-STD-FONT,
              ID                    IS ABOUT-EVENT-ID,
              EVENT                 PROCEDURE IS ABOUT-EVENT,
              TITLE                 "&About",
              SELF-ACT.

           03 PRINT-BUTTON          PUSH-BUTTON,
              COL                   390 PIXELS,
              LINE                  331 PIXELS,
              LINES                 30 PIXELS,
              SIZE                  70 PIXELS,
              FONT                  IS WS-STD-FONT,
              ID                    IS PRINT-EVENT-ID,
              EVENT                 PROCEDURE IS PRINT-EVENT,
              TITLE                 "&Print",
              SELF-ACT.

           03 PUSH-BUTTON,
              COL                   480 PIXELS,
              LINE                  331 PIXELS,
              LINES                 30 PIXELS,
              SIZE                  70 PIXELS,
              FONT                  IS WS-STD-FONT,
              ID                    IS CANCEL-PROGRAM-ID,
              TERMINATION-VALUE     CANCEL-PROGRAM-ID,
              TITLE                 "Cancel",
              SELF-ACT.

           03 DEVICE-STATUS         STATUS-BAR
              PANEL-WIDTHS          (7, 30, 5, -1)
              PANEL-STYLE           (1, 1, 1, 1)
              PANEL-TEXT            (PRINTER-STATUS-TITLE,
                                    " ",
                                    JOB-STATUS-TITLE,
                                    " ").

       01 PRINTER-VALUES.

           03 PRNLIST-SCREEN        COMBO-BOX,
              COL                   100 PIXELS,
              LINE                  20 PIXELS,
              SIZE                  385 PIXELS,
              FONT                  IS WS-STD-FONT,
              UNSORTED,
              MASS-UPDATE           IS UPDATING,
              USING                 CHOSEN-PRINTER,
              NOTIFY-SELCHANGE,
              ID                    IS PRINTER-LIST-ID,
              3-D.

           03 PUSH-BUTTON,
              COL                   495 PIXELS,
              LINE                  18 PIXELS,
              LINES                 25 PIXELS,
              SIZE                  50 PIXELS,
              FONT                  IS WS-STD-FONT,
              ID                    IS SETUP-EVENT-ID,
              EVENT                 PROCEDURE IS SETUP-EVENT,
              TITLE                 "&Setup",
              SELF-ACT.

           03 ENTRY-FIELD,
              COL                   100 PIXELS,
              LINE                  45 PIXELS,
              SIZE                  390 PIXELS,
              FONT                  IS WS-STD-FONT,
              READ-ONLY,
              NO-BOX,
              VALUE                 PORTS-VALUE.

           03 ENTRY-FIELD,
              COL                   100 PIXELS,
              LINE                  65 PIXELS,
              SIZE                  370 PIXELS,
              FONT                  IS WS-STD-FONT,
              READ-ONLY,
              NO-BOX,
              VALUE                 DRVNAME-VALUE.

           03 ENTRY-FIELD,
              COL                   500 PIXELS,
              LINE                  65 PIXELS,
              SIZE                  40 PIXELS,
              FONT                  IS WS-STD-FONT,
              READ-ONLY,
              NO-BOX,
              VALUE                 DRVVERS-VALUE,
              RIGHT,
              NUMERIC.

           03 CHECK-BOX,
              COL                   100 PIXELS,
              LINE                  85 PIXELS,
              FONT                  IS WS-STD-FONT,
              ENABLED               0,
              VALUE                 DEFPRN-ENABLE.

           03 RADIO-BUTTON,
              COL                   100 PIXELS,
              LINE                  141 PIXELS,
              VALUE                 ORIENT-VALUE,
              FONT                  IS WS-STD-FONT,
              TITLE                 "Portrait",
              GROUP-VALUE           IS GRP-PORTRAIT-ID,
              GROUP                 GRP-ORIENTATION,
              NO-GROUP-TAB,
              NOTIFY,
              SELF-ACT.

           03 RADIO-BUTTON,
              COL                   100 PIXELS,
              LINE                  160 PIXELS,
              VALUE                 ORIENT-VALUE,
              FONT                  IS WS-STD-FONT,
              TITLE                 "Landscape",
              GROUP-VALUE           IS GRP-LANDSCAPE-ID,
              GROUP                 GRP-ORIENTATION,
              NO-GROUP-TAB,
              NOTIFY,
              SELF-ACT,
              ENABLED               LNDSCP-ENABLE.

           03 RADIO-BUTTON,
              COL                   423 PIXELS,
              LINE                  141 PIXELS,
              VALUE                 DUPLEX-VALUE,
              FONT                  IS WS-STD-FONT,
              TITLE                 "Simplex",
              GROUP-VALUE           IS 1,
              GROUP                 GRP-DUPLEX,
              NO-GROUP-TAB,
              ENABLED               DUPLEX-ENABLE.

           03 RADIO-BUTTON,
              COL                   423 PIXELS,
              LINE                  160 PIXELS,
              VALUE                 DUPLEX-VALUE,
              FONT                  IS WS-STD-FONT,
              TITLE                 "Duplex vertical",
              GROUP-VALUE           IS GRP-DUPLEX-VERT-ID,
              GROUP                 GRP-DUPLEX,
              NO-GROUP-TAB,
              ENABLED               DUPLEX-ENABLE.

           03 RADIO-BUTTON,
              COL                   423 PIXELS,
              LINE                  180 PIXELS,
              VALUE                 DUPLEX-VALUE,
              FONT                  IS WS-STD-FONT,
              TITLE                 "Duplex horizontal",
              GROUP-VALUE           IS GRP-DUPLEX-HOR-ID,
              GROUP                 GRP-DUPLEX,
              NO-GROUP-TAB,
              ENABLED               DUPLEX-ENABLE.

           03 PRINT-QUALITY         COMBO-BOX,
              COL                   100 PIXELS,
              LINE                  187 PIXELS,
              SIZE                  190 PIXELS,
              FONT                  IS WS-STD-FONT,
              UNSORTED
              MASS-UPDATE           IS UPDATING
              NOTIFY-SELCHANGE
              USING                 CHOSEN-QUALITY
              3-D.

           03 PAPER-SIZE            COMBO-BOX,
              COL                   100 PIXELS,
              LINE                  218 PIXELS,
              SIZE                  190 PIXELS,
              FONT                  IS WS-STD-FONT,
              UNSORTED
              MASS-UPDATE           IS UPDATING
              NOTIFY-SELCHANGE
              USING                 CHOSEN-PAPER-SIZE
              3-D.

           03 PAPER-TRAY            COMBO-BOX
              COL                   100 PIXELS,
              LINE                  248 PIXELS,
              SIZE                  190 PIXELS,
              FONT                  IS WS-STD-FONT,
              UNSORTED
              MASS-UPDATE           IS UPDATING
              NOTIFY-SELCHANGE
              USING                 CHOSEN-PAPER-TRAY
              3-D.

           03 COPIES-SPIN           ENTRY-FIELD,
              COL                   425 PIXELS,
              LINE                  210 PIXELS,
              SIZE                  50 PIXELS,
              FONT                  IS WS-STD-FONT,
              VALUE                 COPIES-VALUE,
              MIN-VAL               0,
              MAX-VAL               MAX-COPIES,
              SPINNER
              3-D
              MAX-TEXT              4,
              ENABLED               COPIES-ENABLE,
              AUTO-SPIN.

           03 LABEL,
              COL                   486 PIXELS,
              LINE                  212 PIXELS,
              FONT                  IS WS-STD-FONT,
              TITLE                 MAX-COPIES-VALUE,
              LEFT.

           03 CHECK-BOX,
              COL                   425 PIXELS,
              LINE                  240 PIXELS,
              FONT                  IS WS-STD-FONT,
              VALUE                 COLLATE-VALUE,
              ENABLED               COLLATE-ENABLE.

           03 CHECK-BOX,
              COL                   425 PIXELS,
              LINE                  265 PIXELS,
              FONT                  IS WS-STD-FONT,
              ENABLED               COLOR-ENABLE,
              VALUE                 COLOR-VALUE.

           03 JOB-TITLE             ENTRY-FIELD,
              COL                   100 PIXELS,
              LINE                  290 PIXELS,
              FONT                  IS WS-STD-FONT,
              SIZE                  240 PIXELS,
              VALUE                 JOB-TITLE-VALUE,
              MAX-TEXT              30,
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

      *     CALL    "WIN$VERSION"    USING WINVERSION-DATA
      *             ON               EXCEPTION GO TO MAIN-900.

      *     IF      NOT              WIN-WORDSIZE-32
      *             GO               TO MAIN-900.

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

      *This is the main loop of the application, display the screen
      *and wait for user interaction, periodically interrupted to
      *detect possible status changes of printer/job.
       LOOP SECTION.
       LOOP-001.

           PERFORM UNTIL            KEY-STATUS = CANCEL-PROGRAM-ID
                   ACCEPT           PRINTER-VALUES BEFORE TIME 500

                   IF               KEY-STATUS = W-EVENT
                   AND              EVENT-TYPE = NTF-SELCHANGE
                   AND              EVENT-CONTROL-ID = PRINTER-LIST-ID
                                    PERFORM UPDATE-CHANGE
                                    END-IF

                   IF               KEY-STATUS = W-TIMEOUT
                                    PERFORM PRINTER-STATUS-UPDATE
                                    END-IF

           END-PERFORM.

       LOOP-900.
       LOOP-EXIT.
           EXIT.

      *As in any application, cleaning up what ever we have constructed
      *is important, and should always be done, this is the common clean
      *up procedure for this application, to be called when ever the
      *application is to terminate.
       CLEAN-UP SECTION.
       CLEAN-UP-001.

            DESTROY PRINTER-VALUES.
            DESTROY PRINTER-LABELS.

            IF      MWIN-HANDLE     NOT = NULL
                    DESTROY         MWIN-HANDLE.

            IF      WS-STD-FONT     NOT = NULL
                    DESTROY         WS-STD-FONT.

       CLEAN-UP-900.
       CLEAN-UP-EXIT.
           EXIT.

      *Upon initialization, there is a number of things we have to
      *establish in a one time task, this is performed here.
      *What we do here, is to get the number of printers present
      * (WINPRINT-GET-NO-PRINTERS), thereafter we load each driver
      *to find the default one. This could also be done without
      *iteration by calling the WINPRINT-GET-CURRENT-INFO, which
      *will give us the current printer. There is however one
      *caveat with that approach, if the runtime already has used
      *the windows spooler, and possibly modified the printer
      *setting it isn't necessarily the Windows default printer
      *that is returned, hence this choice, also, we do this
      *iteration in this sample application to show how to iterate
      *through the printers available on the system.

      *Note: When calling WINPRINT-GET-NO-PRINTERS for the first
      *time the task will take some time, reason being that this
      *implies some initialization routines in the runtime which
      *triggers a load of the printer drivers to obtain the various
      *settings for the printers. This is a one time action only,
      *and subesequent calls will not take so much time. The only
      *exception to this is if there has been a modification to
      *the Windows spooler or one or more of the printer drivers or
      *if there has been added a printer. This will cause the
      *printing subsystem of the runtime to reload the data for
      *the drivers.
       LOAD-DATA SECTION.
       LOAD-DATA-001.

           SET     ENVIRONMENT      "WINPRINT-NAMES-ONLY" TO 1.
           CALL    "WIN$PRINTER"    USING  WINPRINT-GET-NO-PRINTERS
                                           WINPRINT-SELECTION
                                    GIVING CALL-RESULT.

           IF      CALL-RESULT      NOT    >      0
           OR      WINPRINT-NO-OF-PRINTERS =      0
                   PERFORM          ERROR-MESSAGE
                   PERFORM          CLEAN-UP
                   STOP             RUN.

           MOVE    WINPRINT-NO-OF-PRINTERS TO     WS-COUNT.
           MOVE    1                TO     UPDATING
                                           WS-HA.
           INITIALIZE               DRIVER-PROGRESS.
           MODIFY  PRINT-QUALITY    ITEM-TO-ADD TABLE QUALITY-TABLE.

           PERFORM VARYING          PRNLIST-IDX FROM 1 BY 1
                   UNTIL            PRNLIST-IDX > WS-COUNT
                   PERFORM          INIT-PRINTER-DATA
                   STRING           "." DELIMITED BY SIZE INTO
                                    DRIVER-PROGRESS WITH POINTER
                                    WS-HA
                   MODIFY           DEVICE-STATUS
                                    PANEL-INDEX 4
                                    PANEL-TEXT DRIVER-PROGRESS
                   MOVE             PRNLIST-IDX TO
                                    WINPRINT-NO-OF-PRINTERS
                   CALL             "WIN$PRINTER" USING
                                    WINPRINT-GET-PRINTER-INFO-EX
                                    WINPRINT-SELECTION
                                    GIVING CALL-RESULT
                                    END-CALL

                   IF               CALL-RESULT = 1
                   AND              WPRT-IS-DEFAULT
                                    SET ENVIRONMENT
                                        "WINPRINT-NAMES-ONLY" TO 0
                                    CALL "WIN$PRINTER" USING
                                         WINPRINT-GET-PRINTER-INFO-EX
                                         WINPRINT-SELECTION
                                         GIVING CALL-RESULT
                                         END-CALL
                                    SET ENVIRONMENT
                                        "WINPRINT-NAMES-ONLY" TO 1
                                    END-IF

                   IF               CALL-RESULT NOT = 1
                                    MOVE 0 TO WS-COUNT
                   ELSE

                                       IF PRNLIST-IDX < 31
                                          MOVE WINPRINT-NAME TO
                                            PRINTERS-TABLE(PRNLIST-IDX)
                                       END-IF

                                    END-IF

                   IF               CALL-RESULT = 1
                   AND              WPRT-IS-DEFAULT
                                    PERFORM GET-ATTRIBUTES
                                    END-IF

           END-PERFORM.

      *Special case, if for some reason there was no default printer
      *set, we use the last one loaded. Rare case.
           IF      CHOSEN-PRINTER   = SPACE
                   PERFORM          GET-ATTRIBUTES
                   MOVE             WINPRINT-CURR-PAPERSIZE TO
                                    WS-PAPERSIZE
                   MOVE             WINPRINT-CURR-TRAY TO
                                    WS-TRAY.

           DISPLAY PRINTER-VALUES.
           MODIFY  PRNLIST-SCREEN   ITEM-TO-ADD TABLE PRINTERS-TABLE.
           MODIFY  PRINT-QUALITY    ITEM-TO-ADD TABLE QUALITY-TABLE.
           PERFORM UPDATE-MEDIA-TABLES.
           INITIALIZE               WINPRINT-SELECTION.
           MOVE    CHOSEN-PRINTER   TO WINPRINT-NAME.
           PERFORM PRINTER-STATUS-UPDATE.
           INITIALIZE               UPDATING.
           DISPLAY PRINTER-VALUES.

       LOAD-DATA-900.
       LOAD-DATA-EXIT.
           EXIT.

      *This is where we update the screen variables with the information
      *we have obtained for the printer to be displayed.
       GET-ATTRIBUTES SECTION.
       GET-ATTRIBUTES-001.

           MOVE    WINPRINT-CURR-ORIENTATION TO ORIENT-VALUE.
           MOVE    WINPRINT-CURR-COPIES      TO COPIES-VALUE.
           MOVE    WINPRINT-IS-DEFAULT       TO DEFPRN-ENABLE.
           MOVE    WINPRINT-CURR-DUPLEX      TO DUPLEX-VALUE.
           MOVE    WINPRINT-CURR-COLLATE     TO COLLATE-VALUE.
           MOVE    WINPRINT-CURR-PAPERSIZE   TO WS-PAPERSIZE.
           MOVE    WINPRINT-CURR-TRAY        TO WS-TRAY.
           MOVE    WINPRINT-CURR-COLOR       TO COLOR-VALUE.

           EVALUATE                 WINPRINT-QUALITY
                   WHEN WPRTSEL-QUALITY-DEFAULT MOVE "Default" TO
                                                     CHOSEN-QUALITY
                   WHEN WPRTSEL-QUALITY-HIGH    MOVE "High"    TO
                                                     CHOSEN-QUALITY
                   WHEN WPRTSEL-QUALITY-MEDIUM  MOVE "Medium"  TO
                                                     CHOSEN-QUALITY
                   WHEN WPRTSEL-QUALITY-LOW     MOVE "Low"     TO
                                                     CHOSEN-QUALITY
                   WHEN WPRTSEL-QUALITY-DRAFT   MOVE "Draft"   TO
                                                     CHOSEN-QUALITY
                   WHEN OTHER                   MOVE SPACES    TO
                                                     CHOSEN-QUALITY
           END-EVALUATE.

           IF      WPRT-HAS-NO-COPY
                   INITIALIZE       COPIES-ENABLE
                   MOVE             1 TO MAX-COPIES-VIS
           ELSE
                   MOVE             WINPRINT-COPIES TO
                                    MAX-COPIES
                                    MAX-COPIES-VIS
                   MOVE             1 TO COPIES-ENABLE.

           IF      NOT              WPRT-HAS-LANDSCAPE
                   INITIALIZE       LNDSCP-ENABLE
           ELSE
                   MOVE             1 TO LNDSCP-ENABLE.

           IF           WPRT-HAS-NO-DUPLEX
                   INITIALIZE       DUPLEX-ENABLE
           ELSE
                   MOVE             1 TO DUPLEX-ENABLE.

           IF           WPRT-HAS-NO-COLLATE
                   INITIALIZE       COLLATE-ENABLE
           ELSE
                   MOVE             1 TO COLLATE-ENABLE.

           IF           WPRT-HAS-NO-COLOR
                   INITIALIZE       COLOR-ENABLE
           ELSE
                   MOVE             1 TO COLOR-ENABLE.

           MOVE    WINPRINT-PORT    TO   PORTS-VALUE.
           MOVE    WINPRINT-DRIVER  TO   DRVNAME-VALUE.
           MOVE    WINPRINT-DRV-VERSION  TO DRVVERS-VALUE.
           MOVE    WINPRINT-NAME    TO   CHOSEN-PRINTER.

       GET-ATTRIBUTES-900.
       GET-ATTRIBUTES-EXIT.
           EXIT.

      *Windows provides a vast set of standard paper sizes and trays
      *these are however not all supported by the particular printer
      *driver. Hence, we inquire the printer for these values rather
      *than showing the Windows standard list, which may cause to
      *incorrect results.

      *Note that the WINPRINT-GET-PRINTER-MEDIA returns a a table of
      *of the printer paper sizes and trays represented by numeric
      *entries, not by text. This is done to preserve memory and
      *time, this media id (for both paper size and trays) can then
      *be matched to the predefined table in winprint.def. Note
      *however that the particular instance of the printer driver
      *may have defined a tray and/or paper sizes that is not present
      *in Windows standard. In that case we present the paper size / tray
      *as either user defined (id above 256) or unknown (paper size
      *between 41 and 256, paper tray between 15 and 256)
       UPDATE-MEDIA-TABLES SECTION.
       UPDATE-MEDIA-TABLES-001.

           MODIFY  PAPER-SIZE
                   RESET-LIST            1.
           MODIFY  PAPER-TRAY
                   RESET-LIST       1.

           INITIALIZE               WINPRINT-MEDIA.
           MOVE    CHOSEN-PRINTER   TO WINPRINT-MEDIA-PRINTER.
           MOVE    PORTS-VALUE      TO WINPRINT-MEDIA-PORT.
           CALL    "WIN$PRINTER"    USING
                   WINPRINT-GET-PRINTER-MEDIA
                   WINPRINT-MEDIA
                   GIVING           CALL-RESULT.

           IF      CALL-RESULT            NOT > 0
                   PERFORM          ERROR-MESSAGE
                   GO               TO  UPDATE-MEDIA-TABLES-900.

           PERFORM VARYING WS-HA FROM 1 BY 1
                   UNTIL (WS-HA > WINPRINT-MEDIA-PAPERCOUNT
                   OR     WS-HA > MAX-PAPER-SIZES)
                      MOVE WINPRINT-MEDIA-PAPER(WS-HA) TO WS-HB
                   IF WS-HB = 0
                      EXIT PERFORM CYCLE
                   END-IF
                   INITIALIZE       WS-HS

                   IF               WS-HB < MAX-PAPER-SIZES
                   OR               WS-HB = MAX-PAPER-SIZES
                                    MOVE    PAPER-SIZE-TABLE(WS-HB) TO
                                            WS-HS
                                       END-IF

                      IF               WS-HB > MAX-PAPER-SIZES
                      AND              WS-HB < 256
                                    MOVE WS-HB TO UN-DEF
                                    MOVE UNDEFINED TO WS-HS
                                       END-IF

                      IF               WS-HB > 255
                                    MOVE WS-HB TO USR-DEF
                                    MOVE USER-DEFINED TO WS-HS
                                       END-IF

                   IF               WS-HS NOT = SPACE
                                       MODIFY  PAPER-SIZE
                                               ITEM-TO-ADD WS-HS
                                    END-IF

                   IF               WS-HB = WS-PAPERSIZE
                                    MOVE WS-HS TO CHOSEN-PAPER-SIZE
                                    END-IF

           END-PERFORM.

           PERFORM VARYING WS-HA FROM 1 BY 1
                   UNTIL (WS-HA > WINPRINT-MEDIA-TRAYCOUNT
                      OR WS-HA > MAX-PAPER-TRAYS)
                      MOVE WINPRINT-MEDIA-TRAYS(WS-HA) TO WS-HB
                   IF WS-HB = 0
                      EXIT PERFORM CYCLE
                   END-IF
                   INITIALIZE       WS-HS
      *For some weird reason, the Windows standard does not have defined
      *entries 12 and 13, but 14 and 15. For convenience we map this back
      *and forth. See also SET-ATTRIBUTES section.
                   IF               WS-HB = 14
                                    MOVE PAPER-TRAY-TABLE(12) TO
                                         WS-HS
                                       END-IF

                      IF               WS-HB = 15
                                    MOVE PAPER-TRAY-TABLE(13) TO
                                         WS-HS
                                       END-IF

                   IF               (WS-HB < MAX-PAPER-TRAYS
                   OR               WS-HB = MAX-PAPER-TRAYS)
                                    MOVE PAPER-TRAY-TABLE(WS-HB) TO
                                         WS-HS
                                       END-IF

                   IF               WS-HB > 15
                   AND              WS-HB < 256
                                    MOVE WS-HB TO UN-DEF
                                       MOVE UNDEFINED TO WS-HS
                                       END-IF

                      IF               WS-HB > 255
                                    MOVE WS-HB TO USR-DEF
                                       MOVE USER-DEFINED TO WS-HS
                                       END-IF

                   IF               WS-HS NOT = SPACE
                                    MODIFY PAPER-TRAY
                                              ITEM-TO-ADD
                                              WS-HS
                                    END-IF

                   IF               WS-HB = WS-TRAY
                                    MOVE WS-HS TO CHOSEN-PAPER-TRAY
                                    END-IF

           END-PERFORM.

       UPDATE-MEDIA-TABLES-900.
       UPDATE-MEDIA-TABLES-EXIT.
           EXIT.

      *Show the window and the screen section labels.
       INITIAL-SETUP SECTION.
       INITIAL-SETUP-001.

           ACCEPT  WS-STD-FONT      FROM STANDARD OBJECT "small-font".
           DISPLAY STANDARD         GRAPHICAL WINDOW
                   LINES            30
                   SIZE             94
                   CONTROL          FONT WS-STD-FONT
                   TITLE-BAR
                   SYSTEM           MENU
                   BACKGROUND-LOW
                   AUTO-MINIMIZE
                   AUTO-RESIZE
                   MODELESS
                   ERASE
                   LINK             TO THREAD
                   NO               SCROLL
                   NO               WRAP
                   TITLE
                    "eXtend Windows print spooler demonstration".

           INITIALIZE               WFONT-DATA
                                    COPIES-VALUE
                                    WS-COUNT
                                    MAX-COPIES
                                    MAX-COPIES-VIS.

           DISPLAY PRINTER-LABELS.

       INITIAL-SETUP-900.
       INITIAL-SETUP-EXIT.
           EXIT.

      *This is where we deal with the error conditions that may occur.
      *Note that these are respondents of the WIN$PRINTER function, any
      *errors through the standard file handling procedure are handled
      *by the code in the DECLARATIVES section.
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
                                    MOVE CALL-RESULT TO SPOOLER-ERR-NO
                                    STRING
                                     "Windows print spooler error!"
                                     X"0A"
                                     SPOOLER-ERR-MSG
                                     DELIMITED BY SIZE INTO MSG-TXT
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

      *When we select another printer, get the attributes for
      *this printer.
       UPDATE-CHANGE SECTION.
       UPDATE-CHANGE-001.

           MODIFY  DEVICE-STATUS    PANEL-INDEX 2
                   PANEL-TEXT       "Loading driver...".
           PERFORM INIT-PRINTER-DATA.
           MOVE    CHOSEN-PRINTER   TO WINPRINT-NAME.
           SET     ENVIRONMENT      "WINPRINT-NAMES-ONLY" TO 0.
           CALL    "WIN$PRINTER"    USING
                                    WINPRINT-GET-PRINTER-INFO-EX
                                    WINPRINT-SELECTION
                   GIVING           CALL-RESULT.
           SET     ENVIRONMENT      "WINPRINT-NAMES-ONLY" TO 1.

           IF      CALL-RESULT      NOT = 1
                   PERFORM          ERROR-MESSAGE
                   GO               TO  UPDATE-CHANGE-900.

           MOVE    1                TO  UPDATING.
           PERFORM GET-ATTRIBUTES.
           PERFORM UPDATE-MEDIA-TABLES.
           INITIALIZE               LAST-PRN-STATUS.
           PERFORM PRINTER-STATUS-UPDATE.
           INITIALIZE               UPDATING.
           DISPLAY PRINTER-VALUES.

       UPDATE-CHANGE-900.
       UPDATE-CHANGE-EXIT.
           EXIT.

      *When we want to set a printer attribute, we will have
      *to send the entire structure, we do however only change
      *those settings we want to change by leaving those we
      *don't want to change as 0. Note that we must pass the
      *printer name as received by WINPRINT-GET-PRINTER-INFO,
      *WINPRINT-GET-PRINTER-INFO-EX, WINPRINT-GET-CURRENT-INFO
      *or WINPRINT-GET-CURRENT-INFO-EX to do this.
       SET-ATTRIBUTES SECTION.
       SET-ATTRIBUTES-001.

           PERFORM INIT-PRINTER-DATA.
           MOVE    CHOSEN-PRINTER   TO WINPRINT-NAME.
           CALL    "WIN$PRINTER"    USING
                                    WINPRINT-GET-PRINTER-INFO-EX
                                    WINPRINT-SELECTION
                   GIVING           CALL-RESULT.

           IF      CALL-RESULT      NOT = 1
                   PERFORM          ERROR-MESSAGE
                   GO               TO  SET-ATTRIBUTES-900.

           IF      COPIES-ENABLE    = 1
                   INQUIRE          COPIES-SPIN
                                    VALUE IN COPIES-VALUE
                   MOVE             COPIES-VALUE TO
                                    WINPRINT-CURR-COPIES.

           MOVE    ORIENT-VALUE     TO WINPRINT-CURR-ORIENTATION.

           INITIALIZE               WINPRINT-QUALITY.

           IF      CHOSEN-QUALITY   = "High"
                   MOVE             WPRTSEL-QUALITY-HIGH TO
                                    WINPRINT-QUALITY.

           IF      CHOSEN-QUALITY   = "Medium"
                   MOVE             WPRTSEL-QUALITY-MEDIUM TO
                                    WINPRINT-QUALITY.

           IF      CHOSEN-QUALITY   = "Low"
                   MOVE             WPRTSEL-QUALITY-LOW TO
                                    WINPRINT-QUALITY.

           IF      CHOSEN-QUALITY   = "Draft"
                   MOVE             WPRTSEL-QUALITY-LOW TO
                                    WINPRINT-QUALITY.

           IF      DUPLEX-ENABLE    = 1
                   MOVE             DUPLEX-VALUE TO
                                    WINPRINT-CURR-DUPLEX.

           IF      COLLATE-ENABLE   = 1
                   MOVE             COLLATE-VALUE TO
                                    WINPRINT-CURR-COLLATE.

           IF      COLOR-ENABLE     = 1
                   MOVE             COLOR-VALUE TO
                                    WINPRINT-CURR-COLOR.

           MOVE    1                TO WS-HA.
           INITIALIZE               WS-HB.

           IF      CHOSEN-PAPER-SIZE(01:07) = "Unknown"
      *Check for undefined
                   MOVE             CHOSEN-PAPER-SIZE TO UNDEFINED
                   MOVE             UN-DEF TO WS-HB
           ELSE IF CHOSEN-PAPER-SIZE(01:12) = "User defined"
      *Check for user defined
                   MOVE             CHOSEN-PAPER-SIZE TO USER-DEFINED
                   MOVE             USR-DEF TO WS-HB
           ELSE
      *Check for standard
                   PERFORM UNTIL (WS-HA > MAX-PAPER-SIZES OR WS-HB > 0)
                                    IF CHOSEN-PAPER-SIZE =
                                       PAPER-SIZE-TABLE(WS-HA)
                                       MOVE WS-HA TO WS-HB
                                       END-IF
                                    ADD 1 TO WS-HA
                   END-PERFORM.

           IF      WS-HB            = WS-PAPERSIZE
      *If no change, don't change.
                   INITIALIZE       WS-HB.

           MOVE    WS-HB            TO WINPRINT-CURR-PAPERSIZE.

           MOVE    1                TO WS-HA.
           INITIALIZE               WS-HB.

           IF      CHOSEN-PAPER-TRAY(01:07) = "Unknown"
                   MOVE             CHOSEN-PAPER-TRAY TO UNDEFINED
                   MOVE             UN-DEF TO WS-HB
           ELSE IF CHOSEN-PAPER-TRAY(01:12) = "User defined"
                   MOVE             CHOSEN-PAPER-TRAY TO USER-DEFINED
                   MOVE             USR-DEF TO WS-HB
           ELSE
                   PERFORM          UNTIL (WS-HA > MAX-PAPER-TRAYS OR
                                    WS-HB > 0)
                                    IF CHOSEN-PAPER-TRAY =
                                       PAPER-TRAY-TABLE(WS-HA)
                                       MOVE WS-HA TO WS-HB
                                       END-IF
                                    ADD 1 TO WS-HA
                   END-PERFORM.

           IF      WS-HB            = WS-TRAY
      *If no change, don't change.
                   INITIALIZE       WS-HB.

      *For some weird reason, the Windows standard does not have defined
      *entries 12 and 13, but 14 and 15. For convenience we map this back
      *and forth. See also UPDATE-MEDIA-TABLES section
           IF      WS-HB            = 12
                   MOVE             14 TO WS-HB
           ELSE IF WS-HB            = 13
                   MOVE             15 TO WS-HB.

           MOVE    WS-HB            TO WINPRINT-CURR-TRAY.

           INQUIRE JOB-TITLE
                   VALUE            JOB-TITLE-VALUE.

           IF      JOB-TITLE-VALUE  NOT = SPACE
                   MOVE             JOB-TITLE-VALUE TO
                                    WINPRINT-JOB-TITLE.

           CALL    "WIN$PRINTER"    USING  WINPRINT-SET-PRINTER-EX
                                           WINPRINT-SELECTION
                                    GIVING CALL-RESULT.

           IF      CALL-RESULT      NOT = 1
                   PERFORM          ERROR-MESSAGE
                   GO               TO  SET-ATTRIBUTES-900.

       SET-ATTRIBUTES-900.
       SET-ATTRIBUTES-EXIT.
           EXIT.

      *This is where we print our small sample. To test some of the
      *attributes, for instance duplex printing, you might want to
      *print more text. But for the purpose of this test application
      *we just print a few lines. For color and graphics demo, see
      *GraphPrn.cbl demo.

      *Note that job control buttons are not activated until the print
      *is finished from our side. Job control are on a job in the spooler
      *queue, not for our printing, if the user cancels a print that is
      *still being feeded to the spooler from our application, you should
      *close the file first, then use the job control functions to cancel
      *it from the spooler. Do not attempt to cancel or pause a print while
      *the Cobol application still have the file open. This is not a
      *limitation of Cobol, but of the Windows spooler system. And, after
      *all, it makes sense.
       PRINT-EVENT SECTION.
       PRINT-EVENT-001.

           IF      EVENT-CONTROL-ID NOT = PRINT-EVENT-ID
           OR      EVENT-TYPE       = MSG-VALIDATE
                   GO               TO PRINT-EVENT-900.

           MODIFY  PRINT-BUTTON     ENABLED 0.
           DISPLAY PRINT-BUTTON.
           PERFORM PRINTER-STATUS-UPDATE.
           PERFORM SET-ATTRIBUTES.

           IF      CALL-RESULT      NOT = 1
                   PERFORM          ERROR-MESSAGE
                   GO               TO PRINT-EVENT-900.

           OPEN    OUTPUT           PRINT-FILE.
           PERFORM VARYING          WS-COUNT FROM 1 BY 1 UNTIL
                                    WS-COUNT > PRNLIST-IDX
                   INITIALIZE       PRINT-RECORD
                   PERFORM          PRINTER-STATUS-UPDATE
                   WRITE            PRINT-RECORD FROM
                                    "eXtend 5.2 shows flexibility!"
                                    BEFORE ADVANCING 1 LINE
                   END-PERFORM.
           CLOSE   PRINT-FILE.
           MOVE    1                TO JOB-CANCEL-ENABLE
                                       JOB-PAUSE-ENABLE
                                       JOB-RESUME-ENABLE.
           DISPLAY JOB-BUTTONS.
           PERFORM PRINTER-STATUS-UPDATE.

       PRINT-EVENT-900.

           MODIFY  PRINT-BUTTON     ENABLED 1.
           DISPLAY PRINT-BUTTON.

       PRINT-EVENT-EXIT.
           EXIT.

       ABOUT-EVENT SECTION.
       ABOUT-EVENT-001.

           IF      EVENT-CONTROL-ID NOT = ABOUT-EVENT-ID
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
                   DELIMITED        BY SIZE INTO ABOUT-TEXT.

           DISPLAY MESSAGE          BOX
                   ABOUT-TEXT
                   TITLE            "About PrnDemoX"
                   TYPE             1
                   ICON             1.

       ABOUT-EVENT-900.
       ABOUT-EVENT-EXIT.
           EXIT.

      *This is the section we use to manipulate the current
      *job we have printed. Note, while this sample is only targeting
      *the last job performed, it is possible to manipulate any job
      *you have printed, but you will then have to preserve the job
      *id for each print yourself. Also note the use of the printer
      *name to identify for which printer the job is.
       JOB-EVENT SECTION.
       JOB-EVENT-001.

           INITIALIZE               WINPRINT-JOB-STATUS.
           MOVE    CHOSEN-PRINTER   TO WINPRINT-JOB-PRINTER.

           EVALUATE                 EVENT-CONTROL-ID
                   WHEN             JOB-CANCEL-ID
                                    INITIALIZE JOB-CANCEL-ENABLE
                                               JOB-PAUSE-ENABLE
                                               JOB-RESUME-ENABLE
                                    SET WPRT-JOB-CANCEL TO TRUE
                   WHEN             JOB-PAUSE-ID
                                    MOVE 1 TO  JOB-RESUME-ENABLE
                                    INITIALIZE JOB-PAUSE-ENABLE
                                    SET WPRT-JOB-PAUSE TO TRUE
                          WHEN             JOB-RESUME-ID
                                    MOVE 1 TO  JOB-PAUSE-ENABLE
                                    INITIALIZE JOB-RESUME-ENABLE
                                    SET WPRT-JOB-RESUME TO TRUE
                   WHEN             OTHER
                                    GO TO JOB-EVENT-900
           END-EVALUATE.

           DISPLAY JOB-BUTTONS.

           CALL    "WIN$PRINTER"    USING
                   WINPRINT-SET-JOB-STATUS
                   WINPRINT-JOB-STATUS
                   GIVING           CALL-RESULT.

           IF      CALL-RESULT      < 1
                   PERFORM          ERROR-MESSAGE
                   GO               TO JOB-EVENT-900.

           PERFORM PRINTER-STATUS-UPDATE.

       JOB-EVENT-900.
       JOB-EVENT-EXIT.
           EXIT.

      *Here we call the standard Windows printer setup, and inherit
      *possible changes into our form afterwards.
       SETUP-EVENT SECTION.
       SETUP-EVENT-001.

           IF      EVENT-CONTROL-ID NOT = SETUP-EVENT-ID
                   GO               TO SETUP-EVENT-900.

           INITIALIZE               WINPRINT-NO-OF-PRINTERS.
           PERFORM SET-ATTRIBUTES.
           CALL    "WIN$PRINTER"    USING WINPRINT-SETUP
                                    GIVING CALL-RESULT.

           IF      CALL-RESULT      NOT = 1
                   PERFORM          ERROR-MESSAGE
                   GO               TO  SETUP-EVENT-900.

           PERFORM INIT-PRINTER-DATA.
           CALL    "WIN$PRINTER"    USING
                                    WINPRINT-GET-CURRENT-INFO-EX
                                    WINPRINT-SELECTION
                                    GIVING CALL-RESULT.

           IF      CALL-RESULT      NOT = 1
                   PERFORM          ERROR-MESSAGE
                   GO               TO  SETUP-EVENT-900.

           MOVE    1                TO UPDATING.
           PERFORM GET-ATTRIBUTES.
           PERFORM UPDATE-MEDIA-TABLES.
           PERFORM PRINTER-STATUS-UPDATE.
           INITIALIZE               UPDATING.
           DISPLAY PRINTER-VALUES.

       SETUP-EVENT-900.
       SETUP-EVENT-EXIT.
           EXIT.

      *Standard routine to initialize related variables.
       INIT-PRINTER-DATA SECTION.
       INIT-PRINTER-DATA-001.

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

       INIT-PRINTER-DATA-900.
       INIT-PRINTER-DATA-EXIT.
           EXIT.

      *This is the section we use to get the current status of
      *the printer and a possible job. Note that
      *WINPRINT-GET-PRINTER-STATUS uses the same structure as
      *WINPRINT-GET-PRINTER-INFO, this application is created
      *such that the content of WINPRINT-SELECTION is correct
      *for this step, if your application modifies the
      *WINPRINT-SELECTION, you will have to make sure that the
      *WINPRINT-NAME and WINPRINT-PORT variables has the correct
      *value as these are used by the function. The WINPRINT-SELECTION
      *structure are not modified by this call.

      *Note: The WINPRINT-GET-PRINTER-STATUS provides you with
      *the status of the printer itself, hence, to get info about
      *a job, you will have to use the WINPRINT-GET-JOB-STATUS.

       PRINTER-STATUS-UPDATE SECTION.
       PRINTER-STATUS-UPDATE-001.

           INITIALIZE               PRN-STATUS.

           CALL    "WIN$PRINTER"    USING
                   WINPRINT-GET-PRINTER-STATUS
                   WINPRINT-SELECTION
                   GIVING           WINPRINT-PRINTER-STATUS.

           EVALUATE                 WINPRINT-PRINTER-STATUS
                   WHEN             WPRTERR-UNSUPPORTED
                                    MOVE "Idle" TO
                                         PRN-STATUS
                                    GO   TO PRINTER-STATUS-UPDATE-020
                   WHEN             WPRTERR-DRV-LOADFAIL
                                    MOVE "Driver failure" TO
                                         PRN-STATUS
                                    GO   TO PRINTER-STATUS-UPDATE-020
                   WHEN             WPRTERR-NO-MEMORY
                                    MOVE "Out of memory" TO
                                         PRN-STATUS
                                    GO   TO PRINTER-STATUS-UPDATE-020
                   WHEN             WPRTERR-ENUM-FAIL
                                    MOVE "Status not available" TO
                                         PRN-STATUS
                                    GO   TO PRINTER-STATUS-UPDATE-020
           END-EVALUATE.

           MOVE    1                TO WS-HA WS-HB.

      *The status as returned from the Windows API, may be a combination
      *of multiple conditions, hence we have to use CBL_AND to evaluate
      *and list conditions, as multiple conditions may be present.
       PRINTER-STATUS-UPDATE-010.

           MOVE    PRINTER-CONDITIONS(WS-HA) TO CALL-RESULT.
           CALL    "CBL_AND"        USING
                   WINPRINT-PRINTER-STATUS
                   CALL-RESULT
                   4.

           IF      CALL-RESULT      NOT = 0

                   EVALUATE         WS-HA
                    WHEN            01 STRING "Idle "
                                              DELIMITED BY SIZE INTO
                                              PRN-STATUS WITH POINTER
                                              WS-HB
                    WHEN            02 STRING "Paused "
                                              DELIMITED BY SIZE INTO
                                              PRN-STATUS WITH POINTER
                                              WS-HB
                    WHEN            03 STRING "Error "
                                              DELIMITED BY SIZE INTO
                                              PRN-STATUS WITH POINTER
                                              WS-HB
                    WHEN            04 STRING "Pending deletion "
                                              DELIMITED BY SIZE INTO
                                              PRN-STATUS WITH POINTER
                                              WS-HB
                    WHEN            05 STRING "Paper jam "
                                              DELIMITED BY SIZE INTO
                                              PRN-STATUS WITH POINTER
                                              WS-HB
                    WHEN            06 STRING "Out of paper "
                                              DELIMITED BY SIZE INTO
                                              PRN-STATUS WITH POINTER
                                              WS-HB
                    WHEN            07 STRING
                                        "Waiting for manual feed "
                                              DELIMITED BY SIZE INTO
                                              PRN-STATUS WITH POINTER
                                              WS-HB
                    WHEN            08 STRING "Paper problem "
                                              DELIMITED BY SIZE INTO
                                              PRN-STATUS WITH POINTER
                                              WS-HB
                    WHEN            09 STRING "Printer is offline "
                                              DELIMITED BY SIZE INTO
                                              PRN-STATUS WITH POINTER
                                              WS-HB
                    WHEN            10 STRING "IO Active "
                                              DELIMITED BY SIZE INTO
                                              PRN-STATUS WITH POINTER
                                              WS-HB
                    WHEN            11 STRING "Busy "
                                              DELIMITED BY SIZE INTO
                                              PRN-STATUS WITH POINTER
                                              WS-HB
                    WHEN            12 STRING "Printing "
                                              DELIMITED BY SIZE INTO
                                              PRN-STATUS WITH POINTER
                                              WS-HB
                    WHEN            13 STRING "Output bin full "
                                              DELIMITED BY SIZE INTO
                                              PRN-STATUS WITH POINTER
                                              WS-HB
                    WHEN            14 STRING "Not available "
                                              DELIMITED BY SIZE INTO
                                              PRN-STATUS WITH POINTER
                                              WS-HB
                    WHEN            15 STRING "Waiting "
                                              DELIMITED BY SIZE INTO
                                              PRN-STATUS WITH POINTER
                                              WS-HB
                    WHEN            16 STRING "Processing "
                                              DELIMITED BY SIZE INTO
                                              PRN-STATUS WITH POINTER
                                              WS-HB
                    WHEN            17 STRING "Initializing "
                                              DELIMITED BY SIZE INTO
                                              PRN-STATUS WITH POINTER
                                              WS-HB
                    WHEN            18 STRING "Warming up "
                                              DELIMITED BY SIZE INTO
                                              PRN-STATUS WITH POINTER
                                              WS-HB
                    WHEN            19 STRING "Low on toner "
                                              DELIMITED BY SIZE INTO
                                              PRN-STATUS WITH POINTER
                                              WS-HB
                    WHEN            20 STRING "Out of toner "
                                              DELIMITED BY SIZE INTO
                                              PRN-STATUS WITH POINTER
                                              WS-HB
                    WHEN            21 STRING "Page unprintable "
                                              DELIMITED BY SIZE INTO
                                              PRN-STATUS WITH POINTER
                                              WS-HB
                    WHEN            22 STRING "User intervention "
                                              DELIMITED BY SIZE INTO
                                              PRN-STATUS WITH POINTER
                                              WS-HB
                    WHEN            23 STRING "Out of memory "
                                              DELIMITED BY SIZE INTO
                                              PRN-STATUS WITH POINTER
                                              WS-HB
                    WHEN            24 STRING "Printer door open "
                                              DELIMITED BY SIZE INTO
                                              PRN-STATUS WITH POINTER
                                              WS-HB
                    WHEN            25 STRING "Server unknown "
                                              DELIMITED BY SIZE INTO
                                              PRN-STATUS WITH POINTER
                                              WS-HB
                    WHEN            26 STRING "Power save "
                                              DELIMITED BY SIZE INTO
                                              PRN-STATUS WITH POINTER
                                              WS-HB
                   END-EVALUATE.

           IF           WS-HA            NOT > MAX-PRINTER-STATUS
                   ADD              1   TO WS-HA
                   GO               TO  PRINTER-STATUS-UPDATE-010.

       PRINTER-STATUS-UPDATE-020.

           IF      PRN-STATUS       = SPACE
                   MOVE             "Unknown" TO PRN-STATUS.

           IF      PRN-STATUS       = LAST-PRN-STATUS
                   GO               TO PRINTER-STATUS-UPDATE-030.

           MOVE    PRN-STATUS       TO LAST-PRN-STATUS.

           MODIFY  DEVICE-STATUS
                   PANEL-INDEX      2
                   PANEL-TEXT       PRN-STATUS.

       PRINTER-STATUS-UPDATE-030.

           INITIALIZE               WINPRINT-JOB-STATUS
                                    JOB-STATUS.
           MOVE    CHOSEN-PRINTER   TO WINPRINT-JOB-PRINTER.

           CALL    "WIN$PRINTER"    USING
                   WINPRINT-GET-JOB-STATUS
                   WINPRINT-JOB-STATUS
                   GIVING           CALL-RESULT.

           EVALUATE                 CALL-RESULT
                   WHEN             WPRTERR-DRV-LOADFAIL
                                    MOVE "Driver failure" TO
                                         JOB-STATUS
                                    INITIALIZE JOB-CANCEL-ENABLE
                                               JOB-PAUSE-ENABLE
                                               JOB-RESUME-ENABLE
                                    DISPLAY JOB-BUTTONS
                                    GO   TO PRINTER-STATUS-UPDATE-050
                   WHEN             WPRTERR-NO-MEMORY
                                    MOVE "Out of memory" TO
                                         JOB-STATUS
                                    INITIALIZE JOB-CANCEL-ENABLE
                                               JOB-PAUSE-ENABLE
                                               JOB-RESUME-ENABLE
                                    DISPLAY JOB-BUTTONS
                                    GO   TO PRINTER-STATUS-UPDATE-050
                   WHEN             WPRTERR-BAD-ARG
                                    MOVE "No current"
                                         TO JOB-STATUS
                                    INITIALIZE JOB-CANCEL-ENABLE
                                               JOB-PAUSE-ENABLE
                                               JOB-RESUME-ENABLE
                                    DISPLAY JOB-BUTTONS
                                    GO   TO PRINTER-STATUS-UPDATE-050
           END-EVALUATE.

           IF      WINPRINT-JOB-STATUS-TEXT NOT = SPACE
                   MOVE             WINPRINT-JOB-STATUS-TEXT TO
                                    JOB-STATUS
                   GO               TO PRINTER-STATUS-UPDATE-050.

           MOVE    1                TO  WS-HA WS-HB.

      *The status as returned from the Windows API, may be a combination
      *of multiple conditions, hence we have to use CBL_AND to evaluate
      *and list conditions, as multiple conditions may be present.
       PRINTER-STATUS-UPDATE-040.

           MOVE    JOB-CONDITIONS(WS-HA) TO CALL-RESULT.
           CALL    "CBL_AND"        USING
                   WINPRINT-JOB-STATUS-NO
                   CALL-RESULT
                   4.

           IF      CALL-RESULT      NOT = 0
                   EVALUATE         WS-HA
                    WHEN            01 STRING "Paused "
                                              DELIMITED BY SIZE INTO
                                              JOB-STATUS WITH POINTER
                                              WS-HB
                    WHEN            02 STRING "Error "
                                              DELIMITED BY SIZE INTO
                                              JOB-STATUS WITH POINTER
                                              WS-HB
                    WHEN            03 STRING "Deleting "
                                              DELIMITED BY SIZE INTO
                                              JOB-STATUS WITH POINTER
                                              WS-HB
                                       INITIALIZE JOB-CANCEL-ENABLE
                                               JOB-PAUSE-ENABLE
                                               JOB-RESUME-ENABLE
                                       DISPLAY JOB-BUTTONS
                    WHEN            04 STRING "Spooling "
                                              DELIMITED BY SIZE INTO
                                              JOB-STATUS WITH POINTER
                                              WS-HB
                    WHEN            05 STRING "Printing "
                                              DELIMITED BY SIZE INTO
                                              JOB-STATUS WITH POINTER
                                              WS-HB
                                       MOVE   WINPRINT-JOB-PAGE-PRINTED
                                              TO PROGRESS-START
                                       MOVE   WINPRINT-JOB-PAGE-TOTAL TO
                                              PROGRESS-TOTAL
                                       STRING JOB-PROGRESS
                                              DELIMITED BY SIZE INTO
                                              JOB-STATUS WITH POINTER
                                              WS-HB
                    WHEN            06 STRING "Offline "
                                              DELIMITED BY SIZE INTO
                                              JOB-STATUS WITH POINTER
                                              WS-HB
                    WHEN            07 STRING "Out of paper "
                                              DELIMITED BY SIZE INTO
                                              JOB-STATUS WITH POINTER
                                              WS-HB
                    WHEN            08 STRING "Printed "
                                              DELIMITED BY SIZE INTO
                                              JOB-STATUS WITH POINTER
                                              WS-HB
                    WHEN            09 STRING "Deleted "
                                              DELIMITED BY SIZE INTO
                                              JOB-STATUS WITH POINTER
                                              WS-HB
                    WHEN            10 STRING "Driver incapable "
                                              DELIMITED BY SIZE INTO
                                              JOB-STATUS WITH POINTER
                                              WS-HB
                    WHEN            11 STRING "User intervention "
                                              DELIMITED BY SIZE INTO
                                              JOB-STATUS WITH POINTER
                                              WS-HB
                    WHEN            12 STRING "Restarting "
                                              DELIMITED BY SIZE INTO
                                              JOB-STATUS WITH POINTER
                                              WS-HB
                   END-EVALUATE.

           IF           WS-HA            NOT > MAX-JOB-STATUS
                   ADD              1   TO WS-HA
                   GO               TO  PRINTER-STATUS-UPDATE-040.

       PRINTER-STATUS-UPDATE-050.

           IF      JOB-STATUS       = SPACE
                   MOVE             "Unknown" TO JOB-STATUS.

       PRINTER-STATUS-UPDATE-055.

           IF      JOB-STATUS       = LAST-JOB-STATUS
                   GO               TO PRINTER-STATUS-UPDATE-900.

           MOVE    JOB-STATUS       TO LAST-JOB-STATUS.

           MODIFY  DEVICE-STATUS
                   PANEL-INDEX      4
                   PANEL-TEXT       JOB-STATUS.

       PRINTER-STATUS-UPDATE-900.
       PRINTER-STATUS-UPDATE-EXIT.
           EXIT.
