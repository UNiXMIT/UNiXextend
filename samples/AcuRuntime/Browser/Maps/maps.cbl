       IDENTIFICATION DIVISION.
       PROGRAM-ID.                      MAPS.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

       DATA DIVISION.
       FILE SECTION.

       WORKING-STORAGE SECTION.
       COPY "ACUCOBOL.DEF".
       01 WINDOW-HANDLE USAGE HANDLE.
       01 URL           PIC X(200) VALUE SPACES.
       01 MAPURL        PIC X(200) VALUE "https://www.google.com/maps/embed/v1/place?q=micro+focus,newbury&key=AIzaSyBFw0Qbyq9zTFTd-tUY6dZWTgaQzuU17R8".
       01 LOCALURL      PIC X(200) VALUE "http://google.co.uk/maps/place/micro+focus+newbury".

       77 KEY-STATUS IS SPECIAL-NAMES CRT STATUS PIC 9(4) VALUE 0.
           88 EXIT-PUSHED VALUE 27.       

       LINKAGE SECTION.

       SCREEN SECTION.
       01 SCREEN1.
           05 BROWSER1 WEB-BROWSER2 VALUE URL 
              SIZE 90 CELLS LINES 70 CELLS SCRIPT.

       PROCEDURE DIVISION. 
           ACCEPT TERMINAL-ABILITIES FROM TERMINAL-INFO

           IF IS-REMOTE AND TERMINAL-NAME = "AcuToWeb"
               MOVE MAPURL TO URL
           ELSE
               MOVE LOCALURL TO URL
           END-IF

           DISPLAY STANDARD GRAPHICAL WINDOW
                 LINES 70 SIZE 90
                 CELL HEIGHT 10 CELL WIDTH 10
                 MODELESS WITH SYSTEM MENU
                 TITLE "BROWSER" TITLE-BAR 
                 USER-GRAY USER-WHITE 
                 HANDLE IS WINDOW-HANDLE
           
           DISPLAY SCREEN1 UPON WINDOW-HANDLE
           PERFORM UNTIL EXIT-PUSHED
              ACCEPT SCREEN1
           END-PERFORM

           GOBACK.