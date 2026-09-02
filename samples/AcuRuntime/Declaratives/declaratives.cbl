       identification division.
       program-id. prog.
       remarks.
       
       environment division.
       input-output section.
       file-control.
           select FILMOGRAFIA assign 
           to "filmografia"
           organization is indexed
           access is dynamic
           record key is Film-Codice
           file status is ws-output-status.
       
       data division.
       file section.        
      *((  XFD FILE=filmografia  ))       
       FD FILMOGRAFIA.
       01  file-output-rec.
           05 Film-Codice           PIC  X(2).
           05 Film-Genere           PIC  X(16).
           05 Film-Cognome          PIC  X(9).
           05 Film-Nome             PIC  X(15).
           05 Film-Titolo           PIC  X(37).
           05 Film-Produttore       PIC  X(26).
           05 Film-Anno             PIC  X(4).
      *((  XFD DATE=YYYYMMDD  ))               
           05 Film-Data             PIC  9(8).
                                     
       
       working-storage section.
       77 ws-output-status     pic XX. 
       
       77 EXTEND-STAT    PIC X(9).
       77 TEXT-MESSAGE   PIC X(100).
       77 STATUS-TYPE    PIC 9 value 1.
       77 ERR-CODE       PIC X(2). 
       
       77 ws-flag        pic 9.
       
       78  MB-OK               VALUE 1. 
       78  MB-YES-NO           VALUE 2. 
       78  MB-OK-CANCEL        VALUE 3. 
       78  MB-YES-NO-CANCEL    VALUE 4. 
       78  MB-YES              VALUE 1. 
       78  MB-NO               VALUE 2. 
       78  MB-CANCEL           VALUE 3. 
       78  MB-DEFAULT-ICON     VALUE 1. 
       78  MB-WARNING-ICON     VALUE 2. 
       78  MB-ERROR-ICON       VALUE 3. 

       
       procedure division.
       DECLARATIVES.
       IO-INPUT-ERROR-HANDLING SECTION. 
           USE AFTER STANDARD ERROR PROCEDURE ON I-O. 
       IO-INPUT-ERROR-HANDLER. 
           CALL "C$RERR" 
               USING EXTEND-STAT, TEXT-MESSAGE, STATUS-TYPE 
      *     display message box "error " EXTEND-STAT " - " TEXT-MESSAGE.
           
           IF EXTEND-STAT(1:2) = 35
              display message box 
              "File not found. Would you like to create it?"
                                  TYPE IS MB-YES-NO
                                  RETURNING ws-flag
              IF ws-flag = MB-YES
                 open Output FILMOGRAFIA
                 perform carica-dati
                 close FILMOGRAFIA
                 open INPUT FILMOGRAFIA                 
              ELSE
                 display message box "Have a good day."
                 perform main-exit
              END-IF      
           END-IF                    
           IF EXTEND-STAT(1:2) = 93
                 display message box EXTEND-STAT " - " TEXT-MESSAGE
                                     x"0A"    
                                     "Retry later."
                 perform main-exit
           END-IF           

       END DECLARATIVES. 
      
       main-logic.

           open EXCLUSIVE I-O FILMOGRAFIA.
           perform leggi-dati.
           close FILMOGRAFIA.

       main-exit.                  	   
       	   stop run.

       	   
       carica-dati. 
           
           move "01"                                  to Film-Codice     
           move "Adventure"                           to Film-Genere
           move "Fleming"                             to Film-Cognome
           move "Ian"                                 to Film-Nome
           move "On Her Majesty's Secret Service"     to Film-Titolo
           move "New American Library"                to Film-Produttore
           move "1963"                                to Film-Anno
           move 20070223                              to Film-Data
           write file-output-rec.

           move "02"                                  to Film-Codice  
           move "Art"                                 to Film-Genere  
           move "Crespelle"                           to Film-Cognome
           move "Jean-Paul"                           to Film-Nome  
           move "Monet"                               to Film-Titolo  
           move "Studio Editions"                     to Film-Produttore  
           move "1993"                                to Film-Anno  
           move 20070223                              to Film-Data
           write file-output-rec
              invalid delete FILMOGRAFIA RECORD
           end-write   
           .     
           
                          

           move "03"                                  to Film-Codice
           move "Biographical"                        to Film-Genere
           move "Adamson"                             to Film-Cognome
           move "Joy"                                 to Film-Nome
           move "Born Free"                           to Film-Titolo
           move "Pantheon"                            to Film-Produttore
           move "1960"                                to Film-Anno
           move 20070223                              to Film-Data
           write file-output-rec.
      
           move "04"                                  to Film-Codice
           move "Children"                            to Film-Genere
           move "Milne"                               to Film-Cognome
           move "A.A."                                to Film-Nome
           move "Winnie the Pooh"                     to Film-Titolo
           move "E.P. Dutton & Co., Inc"              to Film-Produttore
           move "1956"                                to Film-Anno
           move 20070223                              to Film-Data
           write file-output-rec.
      
           move "05"                                  to Film-Codice
           move "Fiction"                             to Film-Genere
           move "Miller"                              to Film-Cognome
           move "Henry"                               to Film-Nome
           move "Tropic of Capricorn"                 to Film-Titolo
           move "Grove Press"                         to Film-Produttore
           move "1961"                                to Film-Anno
           move 20070223                              to Film-Data
           write file-output-rec.
      
           move  "06"                                 to Film-Codice 
           move "History"                             to Film-Genere
           move "Durant"                              to Film-Cognome
           move "Will and Ariel"                      to Film-Nome
           move "The Age of Napoleon"                 to Film-Titolo
           move "Simon and Schuster"                  to Film-Produttore
           move "1975"                                to Film-Anno  
           move 20070223                              to Film-Data   
           write file-output-rec.            
      
           move  "07"                                 to Film-Codice 
           move "History"                             to Film-Genere
           move "Stone"                               to Film-Cognome
           move "Irving"                              to Film-Nome
           move "The Agony and the Ecstasy"           to Film-Titolo
           move "Doubleday & Company, Inc"            to Film-Produttore
           move "1958"                                to Film-Anno
           move 20070223                              to Film-Data
           write file-output-rec.
      
           move  "08"                                 to Film-Codice 
           move "History"                             to Film-Genere
           move "Tuchmann"                            to Film-Cognome
           move "Barbara"                             to Film-Nome
           move "The March of Folly"                  to Film-Titolo
           move "Alfred A. Knopf, Inc"                to Film-Produttore
           move "1984"                                to Film-Anno
           move 20070223                              to Film-Data
           write file-output-rec.
      
           move  "09"                                 to Film-Codice  
           move "Murder Mystery"                      to Film-Genere
           move "Christie"                            to Film-Cognome
           move "Agatha"                              to Film-Nome
           move "Sleeping Murder"                     to Film-Titolo
           move "The Haddon Craftsman, Inc"           to Film-Produttore
           move "1976"                                to Film-Anno
           move 20070223                              to Film-Data
           write file-output-rec.
      
           move  "10"                                 to Film-Codice 
           move "Reference"                           to Film-Genere
           move "Matthews"                            to Film-Cognome
           move "Peter"                               to Film-Nome
           move "The Guinness Book of Records 1996"   to Film-Titolo
           move "Bantam Books"                        to Film-Produttore
           move "1997"                                to Film-Anno
           move 20070223                              to Film-Data
           write file-output-rec.
           .       	 
 
       leggi-dati.
             move low-values to Film-Codice
             
             start FILMOGRAFIA key not < Film-Codice
             
             perform until ws-output-status not = "00"
               read FILMOGRAFIA next with lock
                 at end 
                   accept omitted
                   end-accept
                 not at end
                   display Film-Codice " - " Film-Anno " - " Film-Titolo
               end-read
             end-perform.
           .