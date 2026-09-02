       IDENTIFICATION DIVISION.
       PROGRAM-ID.                      commandLine.
       AUTHOR.  MIT. 
       REMARKS.
           GetCommandLineA retrieves the command-line string for 
           the current process.
           You must be using the full path to the wrun32.exe when 
           starting the runtime if you want the full path to be returned
           by the WinAPI.

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
       01 WS-MEMPTR                    USAGE POINTER.
       01 WS-CMDLINE                   PIC X(100).

       LINKAGE SECTION.

       SCREEN SECTION.

       PROCEDURE DIVISION.

           CALL "KERNEL32.DLL@WINAPI"
           CALL "MSVCRT.DLL"
           CALL "GetCommandLineA"      GIVING WS-MEMPTR
           CALL "strcpy"               USING
                                       BY REFERENCE WS-CMDLINE 
                                       BY VALUE WS-MEMPTR
           DISPLAY MESSAGE BOX WS-CMDLINE
                           TITLE = "Command Line"
           CANCEL "MSVCRT.DLL"
           CANCEL "KERNEL32.DLL@WINAPI"
           GOBACK.