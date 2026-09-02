       IDENTIFICATION DIVISION.
       PROGRAM-ID.                      ATWDesktopCheck.
      * Check to see if ATW Desktop is started on the client machine.
      * If AtwDesktop is not active the CLIENT-USER-ID field of 
      * TERMINAL-ABILITIES is always equal to WebUser, otherwise the 
      * value will be the computer user.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

       DATA DIVISION.
       FILE SECTION.

       WORKING-STORAGE SECTION.
       COPY "acucobol.def".

       77 RESULT               PIC 9(3).
       78 NEWLINE              VALUE H"0A".

       LINKAGE SECTION.

       SCREEN SECTION.

       PROCEDURE DIVISION.

           ACCEPT TERMINAL-ABILITIES FROM TERMINAL-INFO
           IF TERMINAL-NAME = "AcuToWeb"
               IF CLIENT-USER-ID = "WebUser"
                   DISPLAY MESSAGE "ATW Desktop is not running," NEWLINE
                                   "Please start it and try again."
                                   TITLE "AcuToWeb Desktop Check"
               ELSE
                   DISPLAY MESSAGE "ATW Desktop is running!"
                                   TITLE "AcuToWeb Desktop Check"
               END-IF
           ELSE
               DISPLAY MESSAGE "Program is not running in AcuToWeb!"
           END-IF
           GOBACK.