       IDENTIFICATION DIVISION.
       PROGRAM-ID.                      program-name.

      ******************************************************************
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER.                 computer-name.
       OBJECT-COMPUTER.                 computer-name.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

      *****************************************************************
       DATA DIVISION.
       FILE SECTION.

       WORKING-STORAGE SECTION.


       LINKAGE SECTION.

       SCREEN SECTION.

      ******************************************************************
       PROCEDURE DIVISION.

           
       Main Section.
           CALL "W$KEYBUF" USING 1, "{@}kB{a}kB".
           call "C$SLEEP" using 5
           accept omitted
           goback.