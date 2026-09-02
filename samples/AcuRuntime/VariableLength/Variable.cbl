       IDENTIFICATION              DIVISION.
       PROGRAM-ID. Variable.
       AUTHOR. mturner.
       DATE-WRITTEN. 26 May 2017 14:54:18.
       REMARKS.

       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       SPECIAL-NAMES.

       INPUT-OUTPUT                SECTION.

       select fd-name assign to "user.dat"
                      organization is indexed
                      access mode is dynamic
                      record key is fd-name-key.

       DATA                        DIVISION.
       FILE                        SECTION.
       fd fd-name record is varying in size from 4 to 40200 characters.
       01 fd-name-record.
           05 fd-name-key    pic x(4).
           05 fd-name-data   pic x(400).

       WORKING-STORAGE             SECTION.
       01 ws-count    pic 99 value 1.

       LINKAGE                     SECTION.

       SCREEN                      SECTION.

       PROCEDURE DIVISION.
           open output FD-NAME
               move "Test" to fd-name-key
               write FD-NAME-RECORD
           close FD-NAME
           goback.
