       IDENTIFICATION DIVISION.
       PROGRAM-ID.                      called.
       AUTHOR.  MIT. 
       REMARKS.
           Windows Bug
           https://github.com/microsoft/microsoft-ui-xaml/issues/7595

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
       01 WS-HANDLE            HANDLE OF WINDOW.        

       COPY "acugui.def".

       LINKAGE SECTION.

       SCREEN SECTION.

       PROCEDURE DIVISION.

           DISPLAY INITIAL GRAPHICAL WINDOW
                   LINES 20 SIZE 50
                   SYSTEM MENU
                   TITLE "CALLED"
                   AUTO-MINIMIZE
                   HANDLE IN WS-HANDLE

           MODIFY WS-HANDLE ACTION IS ACTION-MINIMIZE

           MODIFY WS-HANDLE ACTION IS ACTION-RESTORE

           ACCEPT OMITTED
           
           GOBACK.