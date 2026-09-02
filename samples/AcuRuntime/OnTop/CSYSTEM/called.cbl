       IDENTIFICATION DIVISION.
       PROGRAM-ID.                      called.
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
       01 WS-HANDLE                    HANDLE OF WINDOW.

       LINKAGE SECTION.

       SCREEN SECTION.

       PROCEDURE DIVISION.

           DISPLAY INITIAL GRAPHICAL WINDOW
                   LINES 20 SIZE 40
                   SYSTEM MENU
                   TITLE "CALLED"
                   HANDLE IN WS-HANDLE
           ACCEPT OMITTED
           GOBACK.