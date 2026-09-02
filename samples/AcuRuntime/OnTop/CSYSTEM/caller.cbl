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
           CALL "C$SYSTEM" USING "C:\Program Files (x86)\Micro Focus\ext
      -                         "end 10.5.1\AcuGT\bin\wrun32.exe C:\temp
      -                         "\initial\called.acu" 1
      *    Keep the first window open while the second one is created 
      *    in called.acu         
           CALL "C$SLEEP" USING 0.5
           GOBACK.