       IDENTIFICATION DIVISION.
       PROGRAM-ID.                      visionDocStorage.
       AUTHOR.  MIT. 

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT FILETEMP
               ASSIGN TO FILE-NAME
               ORGANIZATION IS BINARY SEQUENTIAL
               ACCESS MODE IS SEQUENTIAL
               LOCK MODE IS AUTOMATIC
               FILE STATUS IS FILE-STATUS-1.
               
           SELECT VISIONSTORAGE
               ASSIGN TO "STORAGE.DAT"
               ORGANIZATION IS INDEXED
               ACCESS MODE IS DYNAMIC
               LOCK MODE IS AUTOMATIC
               FILE STATUS IS FILE-STATUS-2
               RECORD KEY IS KEY01 = VISION-FILE-NAME VISION-POS
               WITH DUPLICATES.

       DATA DIVISION.
       FILE SECTION.
       FD FILETEMP.
      * Fixed one-byte records keep binary data exact (no length framing)
       01 FILETEMP-REC.
           05 FILETEMP-BYTE PIC X.
       FD VISIONSTORAGE.
       01 VISION-REC.
           05 VISION-FILE-NAME PIC X(242).
           05 VISION-POS PIC 9(8).
      * Bytes actually stored in this chunk, used to rebuild exactly
           05 VISION-LEN PIC 9(9).
           05 VISION-STRING PIC X(65535).

       WORKING-STORAGE SECTION.
       77 FILE-STATUS-1 PIC X(2).
       77 FILE-STATUS-2 PIC X(2).
      * Logical document name, used as the Vision record key
       77 DOC-NAME PIC X(242) VALUE "1100.pdf".
      * Physical file opened this phase (source in LOAD, output in UNLOAD)
       77 FILE-NAME PIC X(242).
       77 WK-I PIC 9(9).
       77 MENU-CHOICE PIC X VALUE SPACE.
       77 ERR-LABEL PIC X(30).
       77 ERR-NAME PIC X(48).
       77 ERR-STAT PIC X(2).

       LINKAGE SECTION.

       SCREEN SECTION.

       PROCEDURE DIVISION.

           PERFORM UNTIL MENU-CHOICE = "3"
               PERFORM SHOW-MENU
               EVALUATE MENU-CHOICE
                   WHEN "1"
                       PERFORM GET-DOC-NAME
                       PERFORM LOAD
                   WHEN "2"
                       PERFORM GET-DOC-NAME
                       PERFORM UNLOAD
                   WHEN "3"
                       CONTINUE
                   WHEN OTHER
                       DISPLAY "Invalid choice, try again" AT 0801
                               "Press ENTER to Continue..." AT 0901
                       ACCEPT OMITTED
               END-EVALUATE
           END-PERFORM
           GOBACK.

       SHOW-MENU.
           DISPLAY "1. Load File to Vision" AT 0201 ERASE SCREEN
           DISPLAY "2. Unload File from Vision" AT 0301
           DISPLAY "3. Exit" AT 0401
           DISPLAY "Select an option: " AT 0601 WITH NO ADVANCING
           ACCEPT MENU-CHOICE.

       GET-DOC-NAME.
           DISPLAY "Enter file name: " WITH NO ADVANCING
           ACCEPT DOC-NAME
           IF DOC-NAME = SPACES
               MOVE "1100.pdf" TO DOC-NAME
           END-IF.

      * Show any error at fixed screen positions and wait for the user
       DISPLAY-ERROR.
           DISPLAY ERR-LABEL AT 0201 ERASE SCREEN
                   ERR-NAME  AT 0231
                   "File Status: " AT 0301
                   ERR-STAT  AT 0314
                   "Press ENTER to Continue..." AT 0501
           ACCEPT OMITTED.

       LOAD.
      * Read the source file in chunks and store each as a Vision record
           DISPLAY "LOADING FILE..." AT 0201 ERASE SCREEN
           MOVE DOC-NAME TO FILE-NAME
           OPEN INPUT FILETEMP
           IF FILE-STATUS-1 NOT = "00"
               MOVE "LOAD: cannot open file:" TO ERR-LABEL
               MOVE FILE-NAME TO ERR-NAME
               MOVE FILE-STATUS-1 TO ERR-STAT
               PERFORM DISPLAY-ERROR
               STOP RUN
           END-IF
           OPEN OUTPUT VISIONSTORAGE
           IF FILE-STATUS-2 NOT = "00"
               MOVE "LOAD: cannot open storage:" TO ERR-LABEL
               MOVE "STORAGE.DAT" TO ERR-NAME
               MOVE FILE-STATUS-2 TO ERR-STAT
               PERFORM DISPLAY-ERROR
               STOP RUN
           END-IF
           INITIALIZE VISION-POS
           MOVE DOC-NAME TO VISION-FILE-NAME
           MOVE 0 TO VISION-LEN
           READ FILETEMP
               AT END CONTINUE
           END-READ
      * Accumulate bytes into a 65535-byte chunk, writing when full
           PERFORM UNTIL FILE-STATUS-1 NOT EQUAL "00"
               ADD 1 TO VISION-LEN
               MOVE FILETEMP-BYTE TO VISION-STRING(VISION-LEN:1)
               IF VISION-LEN = 65535
                   ADD 1 TO VISION-POS
                   WRITE VISION-REC
                   MOVE 0 TO VISION-LEN
               END-IF
               READ FILETEMP
                   AT END CONTINUE
               END-READ
           END-PERFORM
      * Write the final partial chunk, if any bytes remain
           IF VISION-LEN > 0
               ADD 1 TO VISION-POS
               WRITE VISION-REC
           END-IF
           CLOSE FILETEMP
           CLOSE VISIONSTORAGE.

       UNLOAD.
      * Open storage first and confirm the document exists before
      * creating the output file, so no empty file is left behind
           DISPLAY "UNLOADING FILE..." AT 0201 ERASE SCREEN
           OPEN INPUT VISIONSTORAGE
           IF FILE-STATUS-2 NOT = "00"
               MOVE "UNLOAD: cannot open storage:" TO ERR-LABEL
               MOVE "STORAGE.DAT" TO ERR-NAME
               MOVE FILE-STATUS-2 TO ERR-STAT
               PERFORM DISPLAY-ERROR
               EXIT PARAGRAPH
           END-IF
           MOVE DOC-NAME TO VISION-FILE-NAME
           MOVE 1 TO VISION-POS
      * INVALID KEY manages the not-found case (status 23) ourselves
           START VISIONSTORAGE KEY IS EQUAL TO KEY01
               INVALID KEY CONTINUE
           END-START
           IF FILE-STATUS-2 NOT = "00"
               MOVE "UNLOAD: no records found for file:" TO ERR-LABEL
               MOVE DOC-NAME TO ERR-NAME
               MOVE FILE-STATUS-2 TO ERR-STAT
               PERFORM DISPLAY-ERROR
               CLOSE VISIONSTORAGE
               EXIT PARAGRAPH
           END-IF
      * Records exist, so now create the output file
           MOVE SPACES TO FILE-NAME
           STRING "UNLOADED-" DELIMITED BY SIZE
                  DOC-NAME DELIMITED BY SPACE
                  INTO FILE-NAME
           END-STRING
           OPEN OUTPUT FILETEMP
           IF FILE-STATUS-1 NOT = "00"
               MOVE "UNLOAD: cannot open output:" TO ERR-LABEL
               MOVE FILE-NAME TO ERR-NAME
               MOVE FILE-STATUS-1 TO ERR-STAT
               PERFORM DISPLAY-ERROR
               CLOSE VISIONSTORAGE
               EXIT PARAGRAPH
           END-IF
           READ VISIONSTORAGE NEXT
               AT END CONTINUE
           END-READ
      * Emit each chunk's exact bytes until this file's chunks end
           PERFORM UNTIL VISION-FILE-NAME NOT EQUAL DOC-NAME
           OR FILE-STATUS-2 NOT EQUAL "00"
               PERFORM VARYING WK-I FROM 1 BY 1
                       UNTIL WK-I > VISION-LEN
                   MOVE VISION-STRING(WK-I:1) TO FILETEMP-BYTE
                   WRITE FILETEMP-REC
               END-PERFORM
               READ VISIONSTORAGE NEXT
                   AT END CONTINUE
               END-READ
           END-PERFORM
           CLOSE FILETEMP
           CLOSE VISIONSTORAGE.