       IDENTIFICATION DIVISION.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER. ACUCOBOL-GT.
       OBJECT-COMPUTER. ACUCOBOL-GT
                    PROGRAM COLLATING SEQUENCE IS ORDER-ALFABETO. 
       SPECIAL-NAMES. DECIMAL-POINT IS COMMA,
                      ALPHABET ORDER-ALFABETO IS
                      '2', '1'.                 

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
       DATA DIVISION.
       FILE SECTION.
       WORKING-STORAGE SECTION.
       77 ws-1 PIC X.
       77 ws-2 PIC X.

       PROCEDURE DIVISION.
       
             MOVE "1" TO ws-1
             MOVE "2" TO ws-2
             IF ws-1 > ws-2
               display message box ws-1 " > " ws-2
             ELSE
               display message box ws-1 " < " ws-2
             END-IF  

             goback.
