       IDENTIFICATION DIVISION.
       PROGRAM-ID.                      bitmap.
       AUTHOR.  MIT. 

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
       COPY "acugui.def".
       01 BMP-HANDLE                PIC S9(9) COMP-4.

       LINKAGE SECTION.

       SCREEN SECTION.

       PROCEDURE DIVISION.
           
           CALL "W$BITMAP" USING WBITMAP-LOAD "mario.bmp"
                           GIVING BMP-HANDLE
           DISPLAY STANDARD WINDOW
                   TITLE "BITMAP SAMPLE"
                   LINES 25, SIZE 65
                   BACKGROUND-COLOR = 7
           DISPLAY BITMAP BITMAP-HANDLE = BMP-HANDLE
      *            TRANSPARENT-COLOR = BM-CORNER-COLOR
                   SIZE = 200 LINES = 200 BITMAP-SCALE = 1 AT 0101

           GOBACK.