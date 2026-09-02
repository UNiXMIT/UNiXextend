       IDENTIFICATION               DIVISION.
       PROGRAM-ID. INTERNATIONAL.
       ENVIRONMENT DIVISION.
       SELECT      OPTIONAL         TEXT-FILE
                   ASSIGN TO DISK   "CYRILLIC.DAT".
       DATA DIVISION.

       FILE SECTION.
       FD  TEXT-FILE.
       01  TEXT-RECORD.
           03  TEXT-LENGTH          PIC 9(9).
           03  TEXT-STORAGE         PIC X(128).

       WORKING-STORAGE SECTION.
       COPY "FONTS.DEF".
       01  EVENT-STATUS IS SPECIAL-NAMES EVENT STATUS.
           03  EVENT-TYPE           PIC X(4) COMP-X.
           03  EVENT-WINDOW-HANDLE  HANDLE OF WINDOW.
           03  EVENT-CONTROL-HANDLE HANDLE.
           03  EVENT-CONTROL-ID     PIC XX COMP-X.
           03  EVENT-DATA-1         SIGNED-SHORT.
           03  EVENT-DATA-2         SIGNED-LONG.
           03  EVENT-ACTION         PIC X COMP-X.

       77  RESULT                   PIC S9(9) COMP-5.
       77  FELD1                    PIC X(20).
       77  FELD1-READ               PIC X(20).
       77  S-FONT                   HANDLE OF FONT.
       77  KEY-STATUS IS SPECIAL-NAMES CRT STATUS PIC 9(5) VALUE ZERO.
           88  EXIT-PRESSED         VALUE 27.
           88  STORE-PRESSED        VALUE 100.
       77  KLF-ACTIVATE             PIC X(4) COMP-N.
       77  WS-KBD-NAME              PIC X(09).
       77  AnsiCP                   PIC X(4) COMP-N.
       77  MainWin                  HANDLE OF WINDOW.
       77  ProgramWin               HANDLE OF WINDOW.

       SCREEN SECTION.
       01  INFO-SCREEN.
           03  LABEL                "Text"
               COL                  02
               LINE                 02.
           03  ENTRY-FIELD          USING FELD1
               3-D
               COL                  07
               LINE                 02
               SIZE                 20
               FONT                 S-FONT.
           03  LABEL
               COL                  31
               LINE                 02
               SIZE                 20
               TITLE                FELD1-READ
               TRANSPARENT
               FONT                 S-FONT.
           03  PUSH-BUTTON
               COL                  05
               LINE                 07
               SIZE                 10
               TITLE                "&Store",
               EXCEPTION-VALUE      100.
           03  PUSH-BUTTON
               COL                  35
               LINE                 10
               TITLE                "E&xit"
               SIZE                 10
               CANCEL-BUTTON.

       01 ListLanguages.
           03  LangListBox, list-box,
               line 2 column 2
               size 20, lines 9
               3-d,
               visible 0
               unsorted.

       PROCEDURE DIVISION.

       MAIN-APP SECTION.
       MAIN-001.
           INITIALIZE               KEY-STATUS
                                    FELD1
                                    FELD1-READ.
           PERFORM SELECT-LANG.
           PERFORM UNTIL EXIT-PRESSED
                   DISPLAY          INFO-SCREEN
                   ACCEPT           INFO-SCREEN

                   IF               STORE-PRESSED
                                    DESTROY INFO-SCREEN
                   		    PERFORM STORE-AND-LOAD
                   		    END-IF

           END-PERFORM.
           DESTROY INFO-SCREEN.
           STOP RUN.

       SELECT-LANG.
           DISPLAY STANDARD         WINDOW
                   BACKGROUND-LOW
                   SIZE             30
                   LINES            13
                   TITLE            "Select language"
                   HANDLE           IN MainWin.
	   DISPLAY ListLanguages.
	   MODIFY  LangListBox
	           item-to-add      "Default"
	           item-to-add      "Hebrew"
	           item-to-add      "Arabic"
	           item-to-add      "Greek"
	           item-to-add      "Turkish"
	           item-to-add      "Russian".
	   MODIFY  LangListBox
                   SELECTION-INDEX  1
	           Visible          1.
	   ACCEPT  ListLanguages.

           IF      KEY-STATUS       = 13
                   INQUIRE          LangListBox
                                    SELECTION-INDEX IN RESULT
           ELSE
                   INITIALIZE       RESULT
                   END-IF

	   MODIFY  MainWin          VISIBLE = 0.
	   DESTROY ListLanguages.
           INITIALIZE               WFONT-DATA
                                    WS-KBD-NAME.
           EVALUATE                 RESULT
                   WHEN		    1 | Default ANSI char set
                                    MOVE    x"400" TO AnsiCP

                   WHEN		    2 | Hebrew keyboard
                                    SET     WFCHARSET-WIN-HEBREW TO
                                            TRUE
                                    STRING  "0000040D" LOW-VALUES
                                            DELIMITED BY SIZE
                                            INTO WS-KBD-NAME
                                    MOVE    x"40D" TO AnsiCP

                   WHEN		    3 | Arabic keyboard
                                    SET     WFCHARSET-WIN-ARABIC TO
                                            TRUE
                                    STRING  "00000401" LOW-VALUES
                                            DELIMITED BY SIZE
                                            INTO WS-KBD-NAME
                                    MOVE    x"401" TO AnsiCP

                   WHEN		    4 | Greek keyboard
                                    SET     WFCHARSET-WIN-GREEK TO
                                            TRUE
                                    STRING  "00000408" LOW-VALUES
                                            DELIMITED BY SIZE
                                            INTO WS-KBD-NAME
                                    MOVE    x"408" TO AnsiCP

                   WHEN		    5 | Turkish keyboard
                                    SET     WFCHARSET-WIN-TURKISH TO
                                            TRUE
                                    STRING  "0000041F" LOW-VALUES
                                            DELIMITED BY SIZE
                                            INTO WS-KBD-NAME
                                    MOVE    x"41F" TO AnsiCP

                   WHEN		    6 | Russian keyboard
                                    SET     WFCHARSET-WIN-RUSSIAN TO
                                            TRUE
                                    STRING  "00000419" LOW-VALUES
                                            DELIMITED BY SIZE
                                            INTO WS-KBD-NAME
                                    MOVE    x"419" TO AnsiCP
                   WHEN             OTHER
                                    DISPLAY MESSAGE BOX
                                            "Unknown choice"
                                            TITLE "Fatal Error"
                                    GOBACK
           END-EVALUATE.
           PERFORM SET-CODEPAGE.
           MOVE    "Arial"          TO WFONT-NAME.
           MOVE    10               TO WFONT-SIZE.
           MOVE    16               TO WFONT-CHAR-SET.
           CALL    "W$FONT"         USING
                   WFONT-GET-FONT
                   S-FONT
                   WFONT-DATA
                   GIVING           RESULT.
           DISPLAY FLOATING         WINDOW
                   BACKGROUND-LOW
                   SIZE             50
                   LINES            13
                   CONTROL FONT     S-FONT
                   TITLE            "Select language"                   
           EXIT    PARAGRAPH.

       STORE-AND-LOAD.

	   OPEN    OUTPUT           TEXT-FILE.
	   INITIALIZE               TEXT-LENGTH.
	   INSPECT FELD1            TALLYING
	           TEXT-LENGTH      FOR TRAILING SPACES.
	   SUBTRACT                 20 FROM TEXT-LENGTH.
	   INITIALIZE               TEXT-STORAGE.
	   MOVE    FELD1            TO TEXT-STORAGE.
	   WRITE   TEXT-RECORD.
	   CLOSE   TEXT-FILE.
	   OPEN    INPUT            TEXT-FILE.
	   INITIALIZE               TEXT-RECORD
	                            FELD1
	                            FELD1-READ
	                            KEY-STATUS.
	   READ    TEXT-FILE.
	   MOVE    TEXT-STORAGE     TO FELD1-READ.
	   CLOSE   TEXT-FILE.

       SET-CODEPAGE.

           IF      WS-KBD-NAME      = SPACE
                   EXIT             PARAGRAPH
                   END-IF.

           CALL    "USER32.DLL".
       	   CALL    "Kernel32.DLL".

      *You may also set the locale
       	   CALL    "SetThreadLocale@WINAPI" USING
       	           BY VALUE	    AnsiCP.

           MOVE    1                TO KLF-ACTIVATE.

           IF      WFCHARSET-WIN-ARABIC
           OR      WFCHARSET-WIN-HEBREW
                   CALL             "SetProcessDefaultLayout@WINAPI"
                                    USING BY VALUE KLF-ACTIVATE
                   END-IF

           CALL    "LoadKeyboardLayoutA@WINAPI" USING
                   BY REFERENCE     WS-KBD-NAME,
                   BY VALUE         KLF-ACTIVATE.

           CANCEL  "USER32.DLL".
       	   CANCEL  "Kernel32.DLL".
           EXIT    PARAGRAPH.
