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
       01 WIN-NAME             PIC X(64).
       01 WS-lpWindowName      POINTER.
       01 WS-HANDLE            HANDLE OF WINDOW.        
       01 RETCODE              PIC 9(9) VALUE 0.

       LINKAGE SECTION.

       SCREEN SECTION.

       PROCEDURE DIVISION.

           DISPLAY INITIAL GRAPHICAL WINDOW
                   LINES 20 SIZE 50
                   SYSTEM MENU
                   TITLE "CALLED"
                   HANDLE IN WS-HANDLE
       
           CALL "User32.DLL"   

           MOVE "CALLED" TO WIN-NAME
           INSPECT WIN-NAME REPLACING TRAILING SPACE BY X"00"
           SET WS-lpWindowName TO ADDRESS OF WIN-NAME

           CALL "FindWindowA@WINAPI"   USING 
                                       BY VALUE 0
                                       BY VALUE WS-lpWindowName
                                       GIVING WS-HANDLE
           
           IF WS-HANDLE = 0
               DISPLAY "WINDOW NOT FOUND"
               ACCEPT OMITTED
               GOBACK
           ELSE
               DISPLAY WS-HANDLE
           END-IF

           CALL "ShowWindow"           USING
                                       BY VALUE WS-HANDLE 
                                       BY VALUE 2
                                       GIVING RETCODE

           CALL "ShowWindow"           USING
                                       BY VALUE WS-HANDLE 
                                       BY VALUE 1
                                       GIVING RETCODE

           ACCEPT OMITTED

           CANCEL "User32.DLL"
           GOBACK.