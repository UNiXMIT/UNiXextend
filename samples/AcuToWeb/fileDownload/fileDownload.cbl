       IDENTIFICATION              DIVISION.
       PROGRAM-ID. fileDownload.
       AUTHOR. support.
       DATE-WRITTEN. 20 August 2021 14:35:56.
       REMARKS. 
      * PREREQUISITES
      * 1. Change the URL for the file on line 61 
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       SPECIAL-NAMES.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
       DATA                        DIVISION.
       FILE                        SECTION.
       WORKING-STORAGE             SECTION.
       COPY "acugui.def".
       COPY "crtvars.def".
       77 Key-Status IS SPECIAL-NAMES CRT STATUS PIC 9(4) VALUE 0.
           88 Exit-Pushed VALUE 27.
           88 Message-Received VALUE 95.
           88 Event-Occurred VALUE 96.
           88 Screen-No-Input-Field VALUE 97.
           88 Screen-Time-Out VALUE 99.

       77 Screen1-Handle USAGE IS HANDLE OF WINDOW VALUE NULL.
       01 JSstr1            PIC  X(500).
       01 JSstr2            PIC  X(500).

       LINKAGE                     SECTION.
       SCREEN                      SECTION.
       01 Screen1.
           03 Screen1-Pb-1, Push-Button, 
              COL 5.10, LINE 3.30, LINES 3.40 CELLS, SIZE 8.00 CELLS, 
              ID IS 1 TITLE "DOWNLOAD", ATW-CSS-ID "button".
           03 Screen1-As-1, ATW-Script.

       PROCEDURE DIVISION.

       Main-Logic.
              DISPLAY Standard GRAPHICAL WINDOW
                 LINES 8.10, SIZE 16.20, CELL HEIGHT 10, CELL WIDTH 10, 
                 AUTO-MINIMIZE, COLOR IS 65793, LABEL-OFFSET 0, 
                 LINK TO THREAD, MODELESS, NO SCROLL, WITH SYSTEM MENU, 
                 TITLE "File Download", TITLE-BAR, NO WRAP,  
                 HANDLE IS Screen1-Handle
           
           DISPLAY Screen1 UPON Screen1-Handle
           
           STRING 'saveAs:function (URL) {' DELIMITED BY SIZE
                  'var link = document.createElement("a");'
                  'link.href = URL;'
                  'link.download = "";'
                  'link.dispatchEvent(new MouseEvent("click"));'
                  '}'
                  INTO JSstr1

                  STRING 'var downloadButton=document.querySelector'
                  DELIMITED BY SIZE
                  '("#button");'
                  'downloadButton.addEventListener("click", function()'
                  '{FileDownload.saveAs("https://domain.com/file");});'
                  INTO JSstr2

           MODIFY Screen1-As-1 add('FileDownload' JSstr1)    
           MODIFY Screen1-As-1 evaluate(JSstr2)

           PERFORM UNTIL Exit-Pushed
              ACCEPT Screen1  
                 ON EXCEPTION PERFORM Acu-Screen1-Evaluate-Func
              END-ACCEPT
           END-PERFORM
           DESTROY Screen1-Handle
           INITIALIZE Key-Status
           GOBACK.

       Acu-Screen1-Evaluate-Func.
           EVALUATE TRUE
              WHEN Exit-Pushed
                 SET Exit-Pushed TO TRUE
              WHEN Event-Occurred
                 IF Event-Type = Cmd-Close
                    SET Exit-Pushed TO TRUE
                 END-IF
           END-EVALUATE
           MOVE 1 TO Accept-Control.
