       IDENTIFICATION DIVISION.
       PROGRAM-ID.                      START.
       AUTHOR.  MIT. 
       REMARKS.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
      *     DECIMAL-POINT IS COMMA
           ALPHABET NO-CASE IS 1 THRU 65   'A' ALSO 'a' 
           'B' ALSO 'b'   'C' ALSO 'c'   'D' ALSO 'd' 
           'E' ALSO 'e'   'F' ALSO 'f'   'G' ALSO 'g' 
           'H' ALSO 'h'   'I' ALSO 'i'   'J' ALSO 'j' 
           'K' ALSO 'k'   'L' ALSO 'l'   'M' ALSO 'm' 
           'N' ALSO 'n'   'O' ALSO 'o'   'P' ALSO 'p' 
           'Q' ALSO 'q'   'R' ALSO 'r'   'S' ALSO 's' 
           'T' ALSO 't'   'U' ALSO 'u'   'V' ALSO 'v' 
           'W' ALSO 'w'   'X' ALSO 'x'   'Y' ALSO 'y' 
           'Z' ALSO 'z'.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT FILE-OUTPUT ASSIGN TO "testFile"
           COLLATING SEQUENCE IS NO-CASE
           ORGANIZATION IS INDEXED
           ACCESS IS DYNAMIC
           RECORD KEY IS FILEKEY
           FILE STATUS IS WS-OUTPUT-STATUS. 

       DATA DIVISION.
       FILE SECTION.
       FD FILE-OUTPUT.
       01  FILE-OUTPUT-REC.
           05 FILEKEY                      PIC X.
           05 FILEINFO                     PIC X(20).

       WORKING-STORAGE SECTION.
       77 WS-OUTPUT-STATUS                 PIC XX.
       01  ERROR-TEXT                      PIC X(80).
       01  ERROR-STATUS.
           03 PRIMARY-ERROR                PIC X(2).
           03 SECONDARY-ERROR              PIC X(10).
       78  NEWLINE                         VALUE H"0A".

       COPY "acugui.def".

       LINKAGE SECTION.

       SCREEN SECTION.

       PROCEDURE DIVISION.
       DECLARATIVES.
       FILE-ERR-HANDLING SECTION.
           USE AFTER STANDARD ERROR PROCEDURE ON FILE-OUTPUT.
       FILE-ERR.
           CALL "C$RERR" USING ERROR-STATUS ERROR-TEXT
           DISPLAY MESSAGE "FILE STATUS: " WS-OUTPUT-STATUS NEWLINE
                        "SECONDARY ERROR: " SECONDARY-ERROR NEWLINE
                        "ERROR MESSAGE: " ERROR-TEXT
                        TITLE "ERROR"
                        ICON MB-ERROR-ICON
           STOP RUN. 
       END DECLARATIVES.
       
       MAIN.
           PERFORM LOAD-DATA
           PERFORM READ-DATA
           GOBACK.

       LOAD-DATA.
           OPEN OUTPUT FILE-OUTPUT
           MOVE "A" TO FILEKEY
           MOVE "REC-A" TO FILEINFO
           WRITE FILE-OUTPUT-REC
           MOVE "B" TO FILEKEY
           MOVE "REC-B" TO FILEINFO
           WRITE FILE-OUTPUT-REC
           MOVE "c" TO FILEKEY
           MOVE "REC-c" TO FILEINFO
           WRITE FILE-OUTPUT-REC
           MOVE "d" TO FILEKEY
           MOVE "REC-d" TO FILEINFO
           WRITE FILE-OUTPUT-REC
           MOVE "E" TO FILEKEY
           MOVE "REC-E" TO FILEINFO
           WRITE FILE-OUTPUT-REC
           CLOSE FILE-OUTPUT.
       
       READ-DATA.
           OPEN INPUT FILE-OUTPUT
               INITIALIZE FILE-OUTPUT-REC
               MOVE "a" TO FILEKEY
               START FILE-OUTPUT KEY NOT LESS FILEKEY
               READ FILE-OUTPUT RECORD
               DISPLAY MESSAGE "FILEKEY: " FILEKEY NEWLINE
                        "FILEINFO: " FILEINFO
                        TITLE "DATA".
           CLOSE FILE-OUTPUT.