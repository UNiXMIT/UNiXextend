       IDENTIFICATION DIVISION.
       PROGRAM-ID.                      Multiline.
      * Multiline accept of large variable with terminal width 80

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

       DATA DIVISION.
       FILE SECTION.

       WORKING-STORAGE SECTION.
       01  TEST-MF-TEMP.
           05 LINE-1       PIC X(80) VALUE SPACES.
           05 LINE-2       PIC X(80) VALUE SPACES.
           05 LINE-3       PIC X(80) VALUE SPACES.
           05 LINE-4       PIC X(80) VALUE SPACES.

       01 TEST-MF          PIC X(1000) VALUE SPACES.

       LINKAGE SECTION.

       SCREEN SECTION.

       PROCEDURE DIVISION.
           DISPLAY "TEST-MF  PIC X(1000)= " AT 0101
           ACCEPT LINE-1 AT 0201 AUTO
           ACCEPT LINE-2 AT 0301 AUTO
           ACCEPT LINE-3 AT 0401 AUTO
           ACCEPT LINE-4 AT 0501 AUTO

           STRING LINE-1
                  LINE-2
                  LINE-3
                  LINE-4 
                INTO TEST-MF

           DISPLAY MESSAGE TEST-MF
                   TITLE "RESULT"
           
           goback.