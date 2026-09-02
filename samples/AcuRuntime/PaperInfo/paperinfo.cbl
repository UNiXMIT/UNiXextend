       IDENTIFICATION               DIVISION.
       PROGRAM-ID.                  PaperInfo.
       ENVIRONMENT                  DIVISION.
       CONFIGURATION                SECTION.
       SPECIAL-NAMES.

       FILE-CONTROL.
       SELECT EnumPrinter           ASSIGN TO "Printerlist.txt"
           ORGANIZATION             IS LINE SEQUENTIAL.

       FILE SECTION.
       FD  EnumPrinter.
       01  EprintRec                PIC X(100).

       WORKING-STORAGE SECTION.
       77  CALL-RESULT              SIGNED-INT VALUE 0.
       77  TmpStr                   PIC X(15).
       77  WS-HA                    pic 9(03).
       77  WS-HB                    pic 9(03).
       77  WS-LAST                  pic 9(03).
       77  WS-HS                    PIC X(34).

       COPY "WINPRINT.DEF".

       PROCEDURE   DIVISION.
       MAIN SECTION.
       MAIN-001.

           OPEN    OUTPUT           EnumPrinter.
           INITIALIZE                    WINPRINT-SELECTION.
           MOVE    1                TO WINPRINT-NO-OF-PRINTERS.
           CALL    "WIN$PRINTER"    USING
                   WINPRINT-GET-PRINTER-INFO-EX
                   WINPRINT-SELECTION
                   GIVING           CALL-RESULT.

           PERFORM UNTIL            CALL-RESULT NOT > 0
                   IF               CALL-RESULT < 1
                                    EXIT PERFORM CYCLE
                                    END-IF
                   INITIALIZE       EPrintRec
                   WRITE            EPrintRec FROM WINPRINT-NAME
                   PERFORM          GET-MEDIA
                   WRITE            EPrintRec FROM SPACES
                   ADD              1 TO WINPRINT-NO-OF-PRINTERS
                   CALL             "WIN$PRINTER" USING
                                    WINPRINT-GET-PRINTER-INFO-EX
                                    WINPRINT-SELECTION
                                    GIVING CALL-RESULT
                                    END-CALL
                   END-PERFORM.
           CLOSE   EnumPrinter.
           STOP    RUN.

       MAIN-900.
       MAIN-EXIT.
           EXIT.

      *Windows provides a vast set of standard paper sizes and trays
      *these are however not all supported by the particular printer
      *driver. Hence, we inquire the printer for these values rather
      *than showing the Windows standard list, which may cause to
      *incorrect results.

      *Note that the WINPRINT-GET-PRINTER-MEDIA returns a table of
      *of the printer paper sizes and trays represented by numeric
      *entries, not by text. This is done to preserve memory and
      *time, this media id (for both paper size and trays) can then
      *be matched to the predefined table in winprint.def. Note
      *however that the particular instance of the printer driver
      *may have defined a tray and/or paper sizes that is not present
      *in Windows standard. In that case we present the paper size / tray
      *as either user defined (id above 256) or unknown (paper size
      *between 41 and 256, paper tray between 15 and 256)
       GET-MEDIA SECTION.
       GET-MEDIA-001.
           INITIALIZE               WINPRINT-MEDIA
                                    EPrintRec
                                    WS-LAST.
           WRITE   EPrintRec        FROM "Paper formats".
           MOVE    WINPRINT-NAME    TO WINPRINT-MEDIA-PRINTER.
           MOVE    WINPRINT-PORT    TO WINPRINT-MEDIA-PORT.
           CALL    "WIN$PRINTER"    USING
                   WINPRINT-GET-PRINTER-MEDIA
                   WINPRINT-MEDIA
                   GIVING           CALL-RESULT.

           IF      CALL-RESULT      NOT > 0
                   EXIT             SECTION
                   END-IF.

           PERFORM VARYING          WS-HA FROM 1 BY 1
                   UNTIL            WS-HA > WINPRINT-MEDIA-PAPERCOUNT
                   PERFORM          BUILD-PAPER
           END-PERFORM.

           INITIALIZE               WS-LAST
                                    EPrintRec.
           WRITE   EPrintRec        FROM SPACES. 
           WRITE   EPrintRec        FROM "Paper Trays" .

           PERFORM VARYING WS-HA FROM 1 BY 1
                   UNTIL WS-HA > WINPRINT-MEDIA-TRAYCOUNT
                   PERFORM          BUILD-TRAY
           END-PERFORM.

       GET-MEDIA-900.
       GET-MEDIA-EXIT.
           EXIT.

       BUILD-PAPER SECTION.
       BUILD-PAPER-001.

           MOVE    WINPRINT-MEDIA-PAPER(WS-HA) TO WS-HB.
           INITIALIZE               EPrintRec.

           IF      WS-HB            = 0
           OR      WS-HB            = WS-LAST
                   EXIT             SECTION
                   END-IF.

           MOVE    WS-HB            TO WS-LAST.

           IF      WS-HB            < MAX-PAPER-SIZES
           OR      WS-HB            = MAX-PAPER-SIZES
                   STRING           "  (" WS-HB ") - "
                                    PAPER-SIZE-TABLE(WS-HB)
                                    INTO  EPrintRec
                                    END-STRING
                   END-IF.

           IF      WS-HB            > MAX-PAPER-SIZES
           AND     WS-HB            < 256
                   STRING           "  (" WS-HB ") - Undefined" 
                                    INTO  EPrintRec
                                    END-STRING
                   END-IF.

           IF      WS-HB            > 256
                   STRING           "  (" WS-HB ") - User defined" 
                                    INTO  EPrintRec
                                    END-STRING
                   END-IF.

           WRITE   EPrintRec.

       BUILD-PAPER-900.
       BUILD-PAPER-EXIT.
           EXIT.

       BUILD-TRAY SECTION.
       BUILD-TRAY-001.

           MOVE    WINPRINT-MEDIA-TRAYS(WS-HA) TO WS-HB.
           INITIALIZE               EprintRec.

           IF      WS-HB            = 0
           OR      WS-HB            = WS-LAST
                   EXIT             PARAGRAPH
                   END-IF.

           MOVE    WS-HB            TO WS-LAST.

      *For some weird reason, the Windows standard does not have defined
      *entries 12 and 13, but 14 and 15. For convenience we map this back
      *and forth. See also SET-ATTRIBUTES section.
           IF      WS-HB            = 14
                   STRING           "  (14) - "
                                    PAPER-TRAY-TABLE(12)
                                    INTO  EPrintRec
                                    END-STRING
                   END-IF.

           IF      WS-HB            = 15
                   STRING           "  (15) - "
                                    PAPER-TRAY-TABLE(13)
                                    INTO  EPrintRec
                                    END-STRING
                   END-IF.

           IF      WS-HB            < MAX-PAPER-TRAYS
           OR      WS-HB            = MAX-PAPER-TRAYS
                   STRING           "  (" WS-HB ") - "
                                    PAPER-TRAY-TABLE(WS-HB)
                                    INTO  EPrintRec
                                    END-STRING
                   END-IF.

           IF      WS-HB            > 15
           AND     WS-HB            < 256
                   STRING           "  (" WS-HB ") - Undefined"
                                    INTO  EPrintRec
                                    END-STRING
                   END-IF.

           IF      WS-HB            > 256
                   STRING           "  (" WS-HB ") - User defined"
                                    INTO  EPrintRec
                                    END-STRING
                   END-IF.

           WRITE   EPrintRec.

       BUILD-TRAY-900.
       BUILD-TRAY-EXIT.
           EXIT.