       IDENTIFICATION DIVISION.
       PROGRAM-ID.                      program-name.
       INSTALLATION.                    comment-entry.
       DATE-WRITTEN.                    2008/XX/XX - 99:99:99.
       DATE-COMPILED.                   2008/XX/XX - 00:00:00.

      ******************************************************************
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER.                 computer-name.
       OBJECT-COMPUTER.                 computer-name.
      *SPECIAL-NAMES.
      *   CURSOR     IS  cursor-name,
      *   CRT STATUS IS  crt-status-name.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
       copy "books.sl".
      *I-O-CONTROL.
      *      i-o-control-entry

      *****************************************************************
       DATA DIVISION.
       FILE SECTION.
       copy "books.fd".

       WORKING-STORAGE SECTION.
      *For C$CALLERR routine to get why the CALL statement Failed.
       77  ERR-CODE                      pic x(2).
       77  ERR-MESSAGE                   pic x(80).
      *For C$RERR routine to get the extendeed file status information.
       01  EXTEND-STAT.
           03 primary-error              pic x(2).
           03 secondary-error            pic x(10).
       01  TEXT-MESSAGE                  pic x(40).
      *For C$RERRNAME routine to get the last file used in an I/O statement.
       77  LAST-FILENAME                 PIC X(40).
       77  books-status pic x(2).


       LINKAGE SECTION.
      * [ Data Desciption Entry ....]

       SCREEN SECTION.
      * [ Screen Description Entry ... ]

      ******************************************************************
       PROCEDURE DIVISION.
      *        [ {USING | CHAINING} {parameter} ... ] .

      * DECLARATIVES.
      * section-name SECTION [ segment-no].
      *    declarative-sentence
      * paragraph-name.
      *     sentence ...   ...
      * END DECLARATIVES.
      
      * Section-name SECTION [ segment-no].
      *    declarative-sentence
      * Paragraph-name.
      *     sentence ...   ...
       Main Section.

           Exit Program.
           Stop Run.

       Library-Routines Section.
      * Library Routines Description

       Display-Call-Err-Message.
           CALL "C$CALLERR" USING ERR-CODE, ERR-MESSAGE
           DISPLAY MESSAGE BOX
                   ERR-MESSAGE,
                   TITLE IS "Call Statement Failed".
                   
       Display-Extended-File-Status.
           CALL "C$RERR" USING EXTEND-STAT, TEXT-MESSAGE.
           CALL "C$RERRNAME" USING LAST-FILENAME.
           MOVE SPACES TO ERR-MESSAGE.
           String "File Name :" delimited by size
                  LAST-FILENAME delimited by spaces
                  " Status ["   delimited by size
                  primary-error delimited by size
                  ","           delimited by size
                  secondary-error delimited by spaces
                  "] "          delimited by size
                  TEXT-MESSAGE  delimited by size
              into ERR-MESSAGE
           End-String.
           DISPLAY MESSAGE BOX
                   ERR-MESSAGE,
                   TITLE IS "File Status".
                   
       Display-File-Status-Codes.
           Evaluate ERR-CODE
               When "00"
                  Display Message "Operation successful."
               When "10"
                  Display Message "End of file."
               When "22"
                  Display Message "Duplicate key found but not allowed."
               When "23"
                  Display Message "Record not found."
               When "34"
                  Display Message "Disk full for sequential file or sort
      -                             " file."
               When "35"
                  Display Message "File not found."
               When "41"
                  Display Message "File is already open."
               When "42"
                  Display Message "File not open."
               When "30"
               When "39"
               When other
                  Perform Display-Extended-File-Status
           End-Evaluate.
