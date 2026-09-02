       IDENTIFICATION DIVISION.
       PROGRAM-ID.                      cmkdir.
       AUTHOR.  MIT. 
       REMARKS.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
      * SELECT

       DATA DIVISION.
       FILE SECTION.
      * FD

       WORKING-STORAGE SECTION.
       01 DIR-NAME1                     PIC X(100) VALUE SPACES.
       01 DIR-NAME2                     PIC X(100) VALUE SPACES.
       01 ERR-NUM                       PIC 9(9) COMP-4.
       01 FILENAME                      PIC X(60).
       01 MYDIR                         USAGE HANDLE.

       COPY "acucobol.def".

       LINKAGE SECTION.

       SCREEN SECTION.

       PROCEDURE DIVISION.

           MOVE "@[DISPLAY]:C:\temp" TO DIR-NAME1
           CALL "C$CHDIR" USING DIR-NAME1 GIVING ERR-NUM

           CALL "C$LIST-DIRECTORY" USING LISTDIR-OPEN
                                  DIR-NAME1
                                  "*"
           MOVE RETURN-CODE TO MYDIR
           IF MYDIR = 0
               STOP RUN
           END-IF
           
           DISPLAY "Contents of Directory: "
           PERFORM WITH TEST AFTER UNTIL FILENAME = SPACES
               CALL "C$LIST-DIRECTORY" USING LISTDIR-NEXT
                                             MYDIR
                                             FILENAME
               DISPLAY FILENAME
           END-PERFORM.
           ACCEPT OMITTED

           CALL "C$LIST-DIRECTORY" USING LISTDIR-CLOSE
                                         MYDIR.
           
           MOVE "@{DISPLAY]:TESTDIR" TO DIR-NAME2
           CALL "C$MAKEDIR" USING DIR-NAME2

           GOBACK.