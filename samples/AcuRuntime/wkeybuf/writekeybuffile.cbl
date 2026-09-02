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
      *     SELECT [OPTIONAL] file-name
      *            ASSIGN TO [device] [file-spec]
      *            FILE STATUS IS status-variable.
      *I-O-CONTROL.
      *      i-o-control-entry

      *****************************************************************
       DATA DIVISION.
       FILE SECTION.
      * FD  file-name [IS EXTERNAL] [IS GLOBAL]
      *   [ file-desc { record-description } ...] ... ]
      * SD  file-name
      *   [ sort-desc { record-description } ...]

       WORKING-STORAGE SECTION.
       01 ws-ret pic 9(4).
       01 ws-x   pic x(10).
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
       
           call "W$KEYBUF" using 9, 
           "C:\dev\keystrokes.txt"
           returning ws-ret         
           display ws-ret
          
           accept ws-x
           *>When recording, this is to stop the recording
           *>call "W$KEYBUF" using 5 returning ws-ret
           *>display ws-ret
           accept omitted
           goback.