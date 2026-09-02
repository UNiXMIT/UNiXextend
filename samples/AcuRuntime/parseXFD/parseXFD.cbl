       identification division.
       program-id. parseXFD.
       remarks.  
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.   
       input-output section.
       file-control.

           select file-output assign to ws-file-name
                              organization is indexed
                              access is dynamic
                              record key is FilmKey
                              file status is ws-output-status. 
                                    
       data division.
       file section.   
      $XFD FILE=filmografia            
       FD file-output.
       01  file-output-rec.
           05 FilmKey.
              07 Film-Code          PIC  9(9) value zeroes.
           05 Film-Title            PIC  X(50).
      $XFD DATE=YYYYMMDD
           05 Film-Date             PIC  X(8). 
           05 Film-Genre            PIC  X(25).  
           05 Film-Cost             PIC  s9(14)v9(03) 
              sign trailing separate.                                  
       
       working-storage section.
       77 ws-output-status          PIC XX. 
       77 ws-file-name              PIC X(50) value "FILMOGRAFIA".
                      
       77 ws-title                  PIC X(40) value spaces.
       77 ws-counter                PIC 9(9)  value zeroes.
       01 ws-pause                  PIC 9v99  value zeroes.
       01 ws-max                    PIC 9(9)  value zeroes.

       77 Default-Font
                  USAGE IS HANDLE OF FONT DEFAULT-FONT.  
       77 Form1-Handle
                  USAGE IS HANDLE OF WINDOW.     
       77 Screen1-Ef-1-Value           PIC  9(9) value 10.  
       77 Screen1-Ef-2-Value           PIC  9v99 value 0,00.   
       
       77 Key-Status IS SPECIAL-NAMES CRT STATUS PIC 9(4) VALUE 0.
           88 Exit-Pushed VALUE 27.
           88 Message-Received VALUE 95.
           88 Event-Occurred VALUE 96.
           88 Screen-No-Input-Field VALUE 97.
           88 Screen-Time-Out VALUE 99.
       01 end-the-read    pic 9 value 0.
       01 xfd-handle usage handle.
   
       copy "parsexfd.def".
       
       screen section.
       01 Screen-1.
           03 AcucobolGT-Label, Label, 
              COL 14,10, LINE 1,90, LINES 1,60 CELLS, SIZE 20,00 CELLS, 
              FONT IS Default-Font, ID IS 1, CENTER, 
              LABEL-OFFSET 0, 
              TITLE "ACUCOBOL-GT". 
               
           03 Desc-Label-1, Label, 
              COL 10, LINE 6, LINES 1,60 CELLS, SIZE 25,00 CELLS, 
              FONT IS Default-Font, ID IS 2, 
              LABEL-OFFSET 0, 
              TITLE "How many loops maximum to write/read?".                
           03 Screen1-Ef-1, Entry-Field, 
              COL 10, LINE 8, 
              LINES 2 CELLS, SIZE 10 CELLS, 
              3-D, ID IS 3, VALUE Screen1-Ef-1-Value,
              MAX-TEXT 9.
           03 Screen1-Pb-1, Push-Button, 
              COL 25, LINE 8, 
              LINES 2 CELLS, SIZE 15 CELLS, 
              ID IS 4, TITLE "WRITE",
              EXCEPTION-VALUE 111.  

           03 Desc-Label-2, Label, 
              COL 10, LINE 12, LINES 1,60 CELLS, SIZE 25,00 CELLS, 
              FONT IS Default-Font, ID IS 2, 
              LABEL-OFFSET 0, 
              TITLE "How many seconds between each read?".                                
           03 Screen1-Ef-2, Entry-Field, 
              COL 10, LINE 14, 
              LINES 2 CELLS, SIZE 10 CELLS, 
              3-D, ID IS 6, VALUE Screen1-Ef-2-Value,
              MAX-TEXT 5.
           03 Screen1-Pb-2, Push-Button, 
              COL 25, LINE 14, 
              LINES 2 CELLS, SIZE 15 CELLS, 
              ID IS 7, TITLE "READ",
              EXCEPTION-VALUE 222.  
                     
           03 Counter-Label, Label, 
              COL 10, LINE 18, 
              LINES 1,60 CELLS, SIZE 40,00 CELLS, 
              FONT IS Default-Font, ID IS 9, 
              LABEL-OFFSET 0, 
              TITLE "- - - - - - - - - - - - - - -". 
                            
           03 Exit-PB, Push-Button, 
              COL 19,10, LINE 33, LINES 2,10 CELLS, SIZE 9,90 CELLS, 
              PERMANENT, FONT IS Default-Font, ID IS 10, KEY IS "x", 
              CANCEL-BUTTON, 
              TITLE "E&xit".         
       
       procedure division.
       main-logic.

           CALL "C$PARSEXFD" 
               USING PARSEXFD-PARSE, "filmografia", "FILMOGRAFIA", 1,
               PARSEXFD-DESCRIPTION
               GIVING xfd-handle


           CALL "C$PARSEXFD"
               USING PARSEXFD-GET-FIELD-INFO, xfd-handle, 0,
               PARSEXFD-FIELD-DESCRIPTION
           
           DISPLAY MESSAGE BOX "Field Description = "
                                PARSEXFD-FIELD-NAME
              
           goback.