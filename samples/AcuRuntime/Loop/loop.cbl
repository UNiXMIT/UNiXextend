       IDENTIFICATION DIVISION.
       PROGRAM-ID.                      loop.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

       DATA DIVISION.
       FILE SECTION.

       WORKING-STORAGE SECTION.
       01 STATUS-VALUE    PIC 9(3) VALUE ZEROS.
       01 WS-COUNT        PIC 9(5) VALUE ZEROS.
       01 WS-CONTINUE     PIC 9 VALUE ZERO.

       01 PERFORM-COUNT   PIC 9(5) VALUE 99999.

       COPY "ACUGUI.DEF".

       LINKAGE SECTION.

       SCREEN SECTION.

       PROCEDURE DIVISION.
            PERFORM UNTIL 1 = 2
                PERFORM LOOP-ACTION
                IF STATUS-VALUE = 0
                    EXIT PARAGRAPH
                END-IF
                IF WS-COUNT = PERFORM-COUNT
                    DISPLAY MESSAGE BOX
                        "Do you want to continue?"
                        TITLE IS "CONTINUE LOOP?"
                        TYPE IS 2
                        GIVING WS-CONTINUE
                    IF WS-CONTINUE = 2
                        EXIT PERFORM
                    ELSE
                        INITIALIZE WS-CONTINUE
                    END-IF
                END-IF   
            END-PERFORM
            goback.

       LOOP-ACTION.

            .