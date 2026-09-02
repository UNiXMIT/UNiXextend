       IDENTIFICATION DIVISION.
       PROGRAM-ID.                      Spaces.
      * Sample program uses STRING/UNSTRING to remove spaces

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

       DATA DIVISION.
       FILE SECTION.

       WORKING-STORAGE SECTION.
       01 WS-SPACES        PIC X(23) VALUE "Hello my name is Martin".
       01 WS-NO-SPACES     PIC X(23) VALUE SPACES.
       01 WS-POINTER       PIC 99 VALUE ZERO.
       01 WS-POINTER2      PIC 99 VALUE ZERO.
       01 LIST-SIZE        PIC 99 VALUE ZERO.
       01 WS-STRING        PIC X(23) VALUE SPACES.

       LINKAGE SECTION.

       SCREEN SECTION.

       PROCEDURE DIVISION.
           DISPLAY "Text to UNSTRING: " at 0101
           ACCEPT WS-SPACES at 0119 DEFAULT WS-SPACES
           MOVE 1 TO WS-POINTER WS-POINTER2
           SET LIST-SIZE TO SIZE OF WS-SPACES

           PERFORM UNTIL WS-POINTER > LIST-SIZE
               UNSTRING WS-SPACES
                        DELIMITED BY ALL SPACE
                        INTO WS-NO-SPACES
                        POINTER WS-POINTER
               END-UNSTRING
               PERFORM STORE-VALUE
           END-PERFORM

           DISPLAY "Result = " at 0301
           DISPLAY WS-STRING at 0310
           ACCEPT OMITTED
           
           goback.

       STORE-VALUE.
           STRING WS-NO-SPACES
                  DELIMITED BY SPACE
                  INTO WS-STRING
                  POINTER WS-POINTER2
           END-STRING.
           