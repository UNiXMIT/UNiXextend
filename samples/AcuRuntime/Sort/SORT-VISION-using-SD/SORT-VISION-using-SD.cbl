       IDENTIFICATION DIVISION.
       PROGRAM-ID. SORT-VISION-using-SD.
       AUTHOR.  CCCCCC. 
       REMARKS.    
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           decimal-point is comma.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           select file-input assign to ws-file-input-name
           organization is indexed
           access is dynamic
           record key is FilmKey
           alternate key is Film-Genre with duplicates
           alternate key is Film-Title
           file status is ws-input-status. 
      *           
           select SORT-FILE assign to "DISK".
      *              
           select file-output assign to ws-file-output-name
           organization is indexed
           access is dynamic
           record key is OutputKey
           alternate key is Output-Title
           file status is ws-output-status. 
      *             
         
       DATA DIVISION.
       FILE SECTION.        
       FD file-input.
       01  file-input-rec.
           05 FilmKey.
              07 Film-Code          PIC  9(9) value zeroes.
           05 Film-Title            PIC  X(30).
           05 Film-Genre            PIC  X(10). 
           05 Film-Description      PIC  X(100). 
      *          
       FD file-output.
       01  file-output-rec.
           05 OutputKey.
              07 Output-Code        PIC  9(9) value zeroes.
           05 Output-Title          PIC  X(30).
           05 Output-Genre          PIC  X(10). 
           05 Output-Description    PIC  X(100).            
      *             
       SD SORT-FILE.
       01 s-REC.
          03  s-Code                PIC  9(9).
          03  s-Title               PIC  X(30).
          03  s-Genre               PIC  X(10). 
          03  s-Description         PIC  X(100).  
       
       WORKING-STORAGE SECTION.
       77 ws-input-status           PIC XX. 
       77 ws-output-status          PIC XX. 
       77 ws-file-input-name        PIC X(40) value "films".
       77 ws-file-output-name       PIC X(40) value "sorted-films".
              
       LINKAGE SECTION.       
       SCREEN SECTION.
       PROCEDURE DIVISION.
       MAIN-LOGIC.       
           
           DISPLAY STANDARD WINDOW
                 LINES 40,  SIZE 75, 
                 MIN-LINES 35, MIN-SIZE 46, 
                 AUTO-MINIMIZE, 
                 MODELESS, WITH SYSTEM MENU,  
                 RESIZABLE,
                 user-colors,
                 background-low,
                 TITLE "SORT sample", TITLE-BAR, 
                 USER-GRAY, USER-WHITE, 
                 link to thread,
                 controls-uncropped.   
                 
           perform load-file-input
           
           perform read-file-input                     
           
           perform sort-Sci-Fi-records    
   
           perform read-file-output  
           
           goback
           .  
      *           
       load-file-input.
           open output file-input
           move  01                 to Film-Code
           move  "Star Wars"        to Film-Title
           move  "Sci-Fi"           to Film-Genre
           write file-input-rec
           move  02                 to Film-Code
           move  "Forrest Gump"     to Film-Title
           move  "Comedy"           to Film-Genre
           write file-input-rec
           move  03                 to Film-Code
           move  "Top Gun"          to Film-Title
           move  "Action"           to Film-Genre
           write file-input-rec
           move  04                 to Film-Code
           move  "Jurassic Park"    to Film-Title
           move  "Action"           to Film-Genre
           write file-input-rec
           move  05                 to Film-Code
           move  "Interstellar"     to Film-Title
           move  "Sci-Fi"           to Film-Genre
           write file-input-rec
           close file-input   
           display "File input - CREATED"   
           accept omitted        
           . 
      *           
       read-file-input.
           open input file-input
           move low-values to FilmKEY
           start file-input key not < FilmKEY     
           perform until ws-input-status not = "00"  
             read file-input next
               at end 
                 exit perform
               not at end
               display Film-Code " - " Film-Genre " - " Film-Title
             end-read              
           end-perform          
           close file-input      
           accept omitted       
           .                   
      *   
       read-file-output.
           display "Extract Sci-Fi films sorted by Code descending"          
           open input file-output
           move high-values to Output-Code
           start file-output key not > Output-Code     
           perform until ws-output-status not = "00"  
             read file-output previous
               at end 
                 exit perform
               not at end
               display output-Code " - " output-Genre " - " output-Title
             end-read              
           end-perform          
           close file-output  
           display 
           "Note that Jurassic Park has been modified during RELEASE"
           accept omitted       
           .                 
      *           
       sort-Sci-Fi-records section.     
           SORT SORT-FILE
               ON DESCENDING KEY s-Code
               INPUT  PROCEDURE IS SORT-IN
               OUTPUT PROCEDURE IS SORT-OUT
               .    
       sort-Sci-Fi-records-EXIT.
           EXIT.
      *       
       sort-in section.
       a00-sort-in.
           open input file-input
           perform until ws-input-status not = "00"  
             read file-input next
               at end 
                 exit perform
               not at end
               if Film-Title = "Jurassic Park"
                 move "Sci-Fi" to Film-Genre
                 move 9        to Film-Code
               end-if
               move file-input-rec to s-REC
               RELEASE s-REC
             end-read              
           end-perform                     
           close file-input.  
       a00-sort-in-exit.    
           exit.
      *       
       sort-out section.
       a00-sort-out.
           open output file-output                     
           perform until 1 = 2
               RETURN SORT-FILE INTO s-REC  
                   AT END exit perform
                   NOT AT END 
                     if s-Genre = "Sci-Fi"
                       write file-output-rec from s-REC                  
                     end-if  
               END-RETURN    
           end-perform.           
           close file-output.  
       a00-sort-out-exit.    
           exit.
      *  