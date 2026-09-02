       identification division.
       program-id. manage-vision-file.
       remarks.  
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.   
       input-output section.
       file-control.
           select file-output assign 
           to ws-file-name
           organization is indexed
           access is dynamic
           record key is FilmKey
           file status is ws-output-status.  
           
           select file-input assign to "File-Input.txt"
           organization is sequential.
                
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
       
       FD file-input.
       01  file-input-rec.
           05 Input-Address         PIC  X(50).       
       
       working-storage section.
       COPY "FONTS.DEF".
       
       77 ws-output-status          PIC XX. 
       77 ws-file-name              PIC X(15) value "filmografia".
       77 ws-title                  PIC X(40) value spaces.
       77 ws-counter                PIC 9(9)  value zeroes.
       01 ws-pause                  PIC 9v99  value zeroes.
       01 ws-max                    PIC 9(9)  value 1.

       77 Default-Font
                  USAGE IS HANDLE OF FONT DEFAULT-FONT.  
       77 Czech-Font               
                  USAGE IS HANDLE OF FONT.    
       77 Form1-Handle
                  USAGE IS HANDLE OF WINDOW.     
       77 Screen1-Ef-1-Value           PIC  9(9) value 1.  
       77 Screen1-Ef-2-Value           PIC  9v99 value 0,00.   
       
       77 Key-Status IS SPECIAL-NAMES CRT STATUS PIC 9(4) VALUE 0.
           88 Exit-Pushed VALUE 27.
           88 Message-Received VALUE 95.
           88 Event-Occurred VALUE 96.
           88 Screen-No-Input-Field VALUE 97.
           88 Screen-Time-Out VALUE 99.    
           
       77 WK-Title pic x(50).                     
       
       screen section.
       01 Screen-1.
           03 AcucobolGT-Label, Label, 
              COL 14,10, LINE 1,90, LINES 1,60 CELLS, SIZE 20,00 CELLS, 
              FONT IS Default-Font, ID IS 1, CENTER, 
              LABEL-OFFSET 0, 
              TITLE "ACUCOBOL-GT". 
              
           03 Screen1-Pb-1, Push-Button, 
              COL 15, LINE 7, 
              LINES 2 CELLS, SIZE 15 CELLS, 
              ID IS 4, TITLE "WRITE",
              EXCEPTION-VALUE 111.  
           03 Screen1-Pb-2, Push-Button, 
              COL 15, LINE 10, 
              LINES 2 CELLS, SIZE 15 CELLS, 
              ID IS 7, TITLE "READ",
              EXCEPTION-VALUE 222. 
                     
           03 Counter-Label, Label, 
              COL 10, LINE 20, 
              LINES 1,60 CELLS, SIZE 40,00 CELLS, 
              FONT IS Czech-Font, ID IS 9, 
              LABEL-OFFSET 0, 
              TITLE "- - - - - - - - - - - - - - -". 
                            
           03 Exit-PB, Push-Button, 
              COL 19,10, LINE 33, LINES 2,10 CELLS, SIZE 9,90 CELLS, 
              PERMANENT, FONT IS Default-Font, ID IS 10, KEY IS "x", 
              CANCEL-BUTTON, 
              TITLE "E&xit".         
       
       procedure division.
       main-logic.
       
           perform LOAD-FONT.

           DISPLAY STANDARD GRAPHICAL WINDOW
                 LINES 35,10,  SIZE 46,20, 
                 MIN-LINES 35, MIN-SIZE 46, 
                 CELL HEIGHT 10, CELL WIDTH 10, 
                 AUTO-MINIMIZE, 
                 MODELESS, WITH SYSTEM MENU,  
                 RESIZABLE,
                 CONTROL FONT Default-Font, 
                 user-colors,
                 background-low,
                 TITLE "Create VISION", TITLE-BAR, 
                 USER-GRAY, USER-WHITE, 
                 HANDLE IS Form1-Handle,
                 link to thread,
                 controls-uncropped.        
              
           DISPLAY Screen-1 UPON Form1-Handle.   
           
           PERFORM UNTIL Exit-Pushed
              ACCEPT Screen-1  
                 ON EXCEPTION PERFORM Acu-Screen-1-Evaluate-Func
              END-ACCEPT
           END-PERFORM
           
           DESTROY Form1-Handle.  
           
           PERFORM leaving-the-prog.
           
       Acu-Screen-1-Evaluate-Func.
           EVALUATE TRUE
              WHEN Exit-Pushed
                 DESTROY Form1-Handle
                 INITIALIZE Key-Status                
                 PERFORM leaving-the-prog
             WHEN key-status = 111
                 PERFORM loading-the-data
             WHEN key-status = 222
                 PERFORM reading-the-data              
           END-EVALUATE
           .                     

       loading-the-data.
           initialize ws-counter
           open output file-output
           open input  file-input
           perform Load-Data ws-max times.
           close file-output file-input.

       reading-the-data.
           open input file-output.
           perform Read-Primary-Key.
           close file-output.

       leaving-the-prog.                  	   
       	   goback.

       	   
       Load-Data.            
           initialize file-output-rec 
                      ws-title
           add 1                         to ws-counter
           move ws-counter               to Film-Code  
           move "TEST"                   to Film-Genre
           move "20170317"               to Film-Date
           
           read file-input
           move input-address to Film-title

           write file-output-rec.
           string "Writing record -> " ws-counter into ws-title
           modify Counter-Label, title = ws-title.
 
 
       Read-Primary-Key.
             initialize file-output-rec 
                        ws-title 
                        ws-counter
             move Screen1-Ef-2-Value to ws-pause
             move low-values         to FilmKEY
             
             start file-output key not < FilmKEY     
             
             perform until ws-output-status not = "00" OR
                           ws-counter >= ws-max
               read file-output next with lock
                 at end 
                   exit perform
                 not at end
                   CALL "C$SLEEP" USING ws-pause
                   string FilmKEY " -> " Film-Title into ws-title
                   modify Counter-Label, title = ws-title
                   add 1             to ws-counter
               end-read
             end-perform
           .       
      
        
       LOAD-FONT.     
           INITIALIZE WFONT-DATA    
           SET WFCHARSET-WIN-EASTEUROPE TO TRUE
           MOVE "Arial" TO WFONT-NAME
           CALL "W$FONT" USING WFONT-GET-CLOSEST-FONT
                               Czech-FONT
                               WFONT-DATA.