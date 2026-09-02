       IDENTIFICATION DIVISION.
       PROGRAM-ID.                START-DP.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

       DATA DIVISION.
       FILE SECTION.
       
       WORKING-STORAGE SECTION.
       01 WS-COUNT      PIC 9(5).

       LINKAGE SECTION.

       SCREEN SECTION.

       PROCEDURE DIVISION.

           PERFORM 33000 TIMES
             CALL "DP-Program"
             CANCEL "DP-Program"
             ADD 1 TO WS-COUNT
           END-PERFORM
           goback.

