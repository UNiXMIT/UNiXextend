       IDENTIFICATION DIVISION.
       PROGRAM-ID.                      caller.
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
                   TITLE "CALLER"
                   HANDLE IN WS-HANDLE
           
           DISPLAY "PRESS ENTER TO CONTINUE..."
           ACCEPT OMITTED
           CALL "C$CHAIN" USING  "C:\Program Files (x86)\Micro Focus\ext
      -                         "end 10.5.1\AcuGT\bin\wrun32.exe called.
      -                         "acu"
           GOBACK.