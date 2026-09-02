       IDENTIFICATION DIVISION.
       PROGRAM-ID.                      MultiMonitor.
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
       COPY "acugui.def".
       COPY "acucobol.def".
       COPY "crtvars.def".
       COPY "showmsg.def".

       01 SCREEN1-HANDLE USAGE HANDLE.
       01 SCREEN2-HANDLE USAGE HANDLE.

       77 Key-Status IS SPECIAL-NAMES CRT STATUS PIC 9(4) VALUE 0.
           88 Exit-Pushed VALUE 27.
           88 Message-Received VALUE 95.
           88 Event-Occurred VALUE 96.
           88 Screen-No-Input-Field VALUE 97.
           88 Screen-Time-Out VALUE 99.

       LINKAGE SECTION.

       SCREEN SECTION.
       01 SCREEN1.
           05 LABEL "MONITOR-COUNT:", LINE 2 COL 5.
           05 ENTRY-FIELD LINE 2 COL 24 LINES 1,3 CELLS SIZE 3 CELLS 
              CENTER VALUE MONITOR-COUNT.
           05 PUSH-BUTTON LINE 24 COL 64 LINES 2 SIZE 5 TITLE "?"
              EXCEPTION PROCEDURE ABOUT-HELP.
           05 LABEL "MONITOR 1", LINE 4 COL 10.
      *MONITOR 1
      *OMI-PHYSICAL 
           05 LABEL "OMIP-LEFT:", LINE 6 COL 10.
           05 ENTRY-FIELD LINE 6 COL 24 LINES 1,3 CELLS SIZE 9 CELLS 
              RIGHT VALUE OMIP-LEFT(1).
           05 LABEL "OMIP-TOP:", LINE 8 COL 10.
           05 ENTRY-FIELD LINE 8 COL 24 LINES 1,3 CELLS SIZE 9 CELLS 
              RIGHT VALUE OMIP-TOP(1).
           05 LABEL "OMIP-RIGHT:", LINE 10 COL 10.
           05 ENTRY-FIELD LINE 10 COL 24 LINES 1,3 CELLS SIZE 9 CELLS 
              RIGHT VALUE OMIP-RIGHT(1).
           05 LABEL "OMIP-BOTTOM:", LINE 12 COL 10.
           05 ENTRY-FIELD LINE 12 COL 24 LINES 1,3 CELLS SIZE 9 CELLS 
              RIGHT VALUE OMIP-BOTTOM(1).
      * OMI-WORK
           05 LABEL "OMIW-LEFT:", LINE 14 COL 10.
           05 ENTRY-FIELD LINE 14 COL 24 LINES 1,3 CELLS SIZE 9 CELLS 
              RIGHT VALUE OMIW-LEFT(1).
           05 LABEL "OMIW-TOP:", LINE 16 COL 10.
           05 ENTRY-FIELD LINE 16 COL 24 LINES 1,3 CELLS SIZE 9 CELLS 
              RIGHT VALUE OMIW-TOP(1).
           05 LABEL "OMIW-RIGHT:", LINE 18 COL 10.
           05 ENTRY-FIELD LINE 18 COL 24 LINES 1,3 CELLS SIZE 9 CELLS 
              RIGHT VALUE OMIW-RIGHT(1).
           05 LABEL "OMIW-BOTTOM:", LINE 20 COL 10.
           05 ENTRY-FIELD LINE 20 COL 24 LINES 1,3 CELLS SIZE 9 CELLS 
              RIGHT VALUE OMIW-BOTTOM(1).
      *MONITOR 2
       01 SCREEN2.
           05 LABEL "MONITOR 2", LINE 4 COL 40.
      *OMI-PHYSICAL
           05 LABEL "OMIP-LEFT:", LINE 6 COL 40.
           05 ENTRY-FIELD LINE 6 COL 54 LINES 1,3 CELLS SIZE 9 CELLS 
              RIGHT VALUE OMIP-LEFT(2).
           05 LABEL "OMIP-TOP:", LINE 8 COL 40.
           05 ENTRY-FIELD LINE 8 COL 54 LINES 1,3 CELLS SIZE 9 CELLS 
              RIGHT VALUE OMIP-TOP(2).
           05 LABEL "OMIP-RIGHT:", LINE 10 COL 40.
           05 ENTRY-FIELD LINE 10 COL 54 LINES 1,3 CELLS SIZE 9 CELLS 
              RIGHT VALUE OMIP-RIGHT(2).
           05 LABEL "OMIP-BOTTOM:", LINE 12 COL 40.
           05 ENTRY-FIELD LINE 12 COL 54 LINES 1,3 CELLS SIZE 9 CELLS 
              RIGHT VALUE OMIP-BOTTOM(2).
      * OMI-WORK  
           05 LABEL "OMIW-LEFT:", LINE 14 COL 40.
           05 ENTRY-FIELD LINE 14 COL 54 LINES 1,3 CELLS SIZE 9 CELLS 
              RIGHT VALUE OMIW-LEFT(2).
           05 LABEL "OMIW-TOP:", LINE 16 COL 40.
           05 ENTRY-FIELD LINE 16 COL 54 LINES 1,3 CELLS SIZE 9 CELLS 
              RIGHT VALUE OMIW-TOP(2).
           05 LABEL "OMIW-RIGHT:", LINE 18 COL 40.
           05 ENTRY-FIELD LINE 18 COL 54 LINES 1,3 CELLS SIZE 9 CELLS 
              RIGHT VALUE OMIW-RIGHT(2).
           05 LABEL "OMIW-BOTTOM:", LINE 20 COL 40.
           05 ENTRY-FIELD LINE 20 COL 54 LINES 1,3 CELLS SIZE 9 CELLS 
              RIGHT VALUE OMIW-BOTTOM(2).  

       PROCEDURE DIVISION.
           ACCEPT TERMINAL-ABILITIES FROM TERMINAL-INFO
           DISPLAY STANDARD GRAPHICAL WINDOW
               LINES 26 SIZE 70
               MODELESS WITH SYSTEM MENU
               TITLE "MultiMonitor" TITLE-BAR
               HANDLE IS SCREEN1-HANDLE 
           DISPLAY SCREEN1 UPON SCREEN1-HANDLE
           IF MONITOR-COUNT > 1
               DISPLAY SCREEN2 UPON SCREEN1-HANDLE
           END-IF
           IF IS-PRIMARY-MONITOR(1)
               DISPLAY LABEL "PRIMARY MONITOR IS MONITOR 1" AT 2410
                       SIZE 30
           ELSE
               IF IS-PRIMARY-MONITOR(2)
                   DISPLAY LABEL "PRIMARY MONITOR IS MONITOR 2" AT 2410
                           SIZE 30
               END-IF
           END-IF
           ACCEPT SCREEN1
           GOBACK.
       
       ABOUT-HELP.
           IF EVENT-OCCURRED
              EVALUATE EVENT-TYPE
              WHEN CMD-CLICKED
                 DISPLAY MESSAGE BOX "OMI-PHYSICAL (i.e. OMIP-*) is the 
      -                              "physical size of the monitor."
                                     H"0A" H"0A"
                                     "OMI-WORK (i.e. OMIW-*) is the usab
      -                              "le size of the monitor."
                                     H"0A" H"0A"
                                     "This information mimics that retur
      -                              "ned by the Win32 API GetMonitorInf
      -                              "o, providing information for the p
      -                              "hysical and work area of up to 10 
      -                              "attached monitors."
                                     TITLE = "About / Help"
              END-EVALUATE
           END-IF