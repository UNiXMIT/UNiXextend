       IDENTIFICATION DIVISION.
       PROGRAM-ID. CLIENT-CLOSES-PROGRAM.
       REMARKS.    This program demonstrates QUIT_MODE implemention.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT ERR-FILE
           ASSIGN TO "QUITMODEDATA.TXT"
           ORGANIZATION LINE SEQUENTIAL
           FILE STATUS ERR-STAT.
      
       DATA DIVISION.
       FILE SECTION.
       FD ERR-FILE.
       01 ERR-REC  PIC X(20).
       
       WORKING-STORAGE SECTION.
       COPY "crtvars.def".
       01  WIN-HANDLE USAGE HANDLE OF WINDOW.
       01  ERR-STAT  PIC XX.
       77 KEY-STATUS IS SPECIAL-NAMES CRT STATUS PIC 9(4) VALUE 0.
           88 EXIT-PUSHED VALUE 27.

       SCREEN SECTION.
       01  SCREEN-1.
           03 PB-1 PUSH-BUTTON, "E&xit"
              CANCEL-BUTTON LINE 8 COL 12.

       PROCEDURE DIVISION.
       INITIAL-LOGIC.
      *  These variables tell the server runtime how often to check for
      *  client machine activity, and what value is to be sent to the
      *  server runtime should the client be disconnected.  They can
      *  also be set in the server runtime configuration file.
           SET ENVIRONMENT "TC_CHECK_ALIVE_INTERVAL" to "30".

      *  This value is sent to the KEY-STATUS data structure
           SET ENVIRONMENT "TC_QUIT_MODE" TO "888".
           SET ENVIRONMENT "QUIT_MODE" TO "999".
           INITIALIZE KEY-STATUS.     
           OPEN EXTEND ERR-FILE.

       MAIN-LOGIC.

       MAIN.
           DISPLAY STANDARD GRAPHICAL WINDOW,
              BACKGROUND-LOW LINES 10 SIZE 25
              HANDLE WIN-HANDLE
              EVENT PROCEDURE SHUT-DOWN-TC-QUIT-MODE.
           DISPLAY SCREEN-1 UPON WIN-HANDLE.
           ACCEPT SCREEN-1
               ON EXCEPTION PERFORM SHUT-DOWN-QUIT-MODE.

       SHUT-DOWN-QUIT-MODE.
           MOVE KEY-STATUS TO ERR-REC.
           WRITE ERR-REC.
           CLOSE ERR-FILE.
           PERFORM 9999-EXIT-PROGRAM.

       SHUT-DOWN-TC-QUIT-MODE.
           MOVE EVENT-DATA-2 TO ERR-REC.
           WRITE ERR-REC.
           CLOSE ERR-FILE.
           PERFORM 9999-EXIT-PROGRAM.

       9999-EXIT-PROGRAM.
           EXIT PROGRAM.
           STOP RUN.