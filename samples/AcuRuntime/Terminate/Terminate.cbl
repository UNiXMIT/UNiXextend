       IDENTIFICATION DIVISION.
       PROGRAM-ID.                      program-name.

      ******************************************************************
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.

      *****************************************************************
       DATA DIVISION.
       FILE SECTION.

       WORKING-STORAGE SECTION.
       01 user-input pic x(20) value spaces.

      ******************************************************************
       PROCEDURE DIVISION.
           
       Main Section.
           display standard graphical window
           display "Input Data: " at 0101
           accept user-input at 0112 
           goback.
                 
