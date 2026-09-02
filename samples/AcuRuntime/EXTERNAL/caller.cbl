       IDENTIFICATION DIVISION.
       PROGRAM-ID.                      caller.
       AUTHOR.  MIT. 
       REMARKS.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
      *SELECT

       DATA DIVISION.
       FILE SECTION.
      *FD

       WORKING-STORAGE SECTION.
       01 WS-TEST-DATA             PIC X(10) IS EXTERNAL.

       LINKAGE SECTION.

       SCREEN SECTION.

       PROCEDURE DIVISION.
           MOVE "Hello A" TO WS-TEST-DATA
           CALL "called"
           CANCEL "called"
           DISPLAY MESSAGE WS-TEST-DATA TITLE "CALLER"

           GOBACK.