       IDENTIFICATION              DIVISION.
       PROGRAM-ID. fileUpload.
       AUTHOR. support.
       DATE-WRITTEN. 20 August 2021 14:35:56.
       REMARKS. 
      * PREREQUISITES
      * 1. Server side script to handle the file upload
      * i.e. .PHP script or Node.js
      * 2. Edit the URL in fileDialogChanged:function
      * to point to your server file handling script.
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
       01 JSstr3            PIC  X(500).
       01 JS-CSV            PIC  X(100).

       LINKAGE                     SECTION.
       SCREEN                      SECTION.
       01 Screen1.
           03 Screen1-Pb-1, Push-Button, 
              COL 5.10, LINE 3.30, LINES 3.40 CELLS, SIZE 8.00 CELLS, 
              ID IS 1 TITLE "UPLOAD", ATW-CSS-ID "button".
           03 Screen1-Pb-2, Push-Button,
              COL 5.10, LINE 9.30, LINES 3.40 CELLS, SIZE 8.00 CELLS,
              ID IS 2 TITLE "FileNames", ATW-CSS-ID "button2"
              EXCEPTION PROCEDURE JS-ARRAY.
           03 Screen1-As-1, ATW-Script.

       PROCEDURE DIVISION.

       Main-Logic.
              DISPLAY Standard GRAPHICAL WINDOW
                 LINES 14, SIZE 16.20, CELL HEIGHT 10, CELL WIDTH 10, 
                 AUTO-MINIMIZE, COLOR IS 65793, LABEL-OFFSET 0, 
                 LINK TO THREAD, MODELESS, NO SCROLL, WITH SYSTEM MENU, 
                 TITLE "File Upload", TITLE-BAR, NO WRAP,  
                 HANDLE IS Screen1-Handle
           
           DISPLAY Screen1 UPON Screen1-Handle
           
           STRING 'openFileDialog:function' DELIMITED BY SIZE
                  '(accept, callback, multi=false) {'
                  'var inputElement = document.createElement("input");'
                  'inputElement.type = "file";'
                  'inputElement.accept = accept;'
                  'if(multi){inputElement.multiple=multi;}'
                  'inputElement.addEventListener("change", callback);'
                  'inputElement.dispatchEvent(new MouseEvent("click"));'
                  '}'
                  INTO JSstr1

           STRING 'fileDialogChanged:function(event) {'
                  DELIMITED BY SIZE
                  '[...this.files].forEach(file => {'
                  'var xhr = new XMLHttpRequest();'
                  'var formData = new FormData();'
                  'myList = [ ];'
                  'formData.append("myFile", file);'
                  'xhr.open("POST","https://domain.com/api",true);'
                  'xhr.onreadystatechange = function() {'
                  'if (xhr.readyState == 4 && xhr.status == 200) {'
                  'var header = xhr.getResponseHeader("uploadedFile");'
                  'myList.push(header);'
                  '}};'
                  'xhr.send(formData);});}'
                  INTO JSstr2

           STRING 'var uploadButton=document.querySelector("#button");'
                  DELIMITED BY SIZE
                  'uploadButton.addEventListener("click",function() {'
                  'FileDialog.openFileDialog(true,FileUpload.fileDialog'
                  'Changed,true);});'
                  INTO JSstr3

           MODIFY Screen1-As-1 add('FileDialog' JSstr1)    
           MODIFY Screen1-As-1 add('FileUpload' JSstr2)
           MODIFY Screen1-As-1 evaluate(JSstr3)

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

       JS-ARRAY.
           MODIFY Screen1-As-1 evaluate('finalJS=myList.join(",");')
           MODIFY Screen1-As-1 evaluate('console.log(finalJS);')
           INQUIRE Screen1-As-1 variable("finalJS") IN JS-CSV
           DISPLAY MESSAGE JS-CSV TITLE "FILES UPLOADED".
