       IDENTIFICATION DIVISION.
       PROGRAM-ID. test-transaction.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT animals
              ASSIGN TO "animals"
              ORGANIZATION IS INDEXED
              ACCESS IS DYNAMIC
              RECORD KEY IS patient-id
              FILE STATUS IS file-status
              LOCK MODE AUTOMATIC WITH ROLLBACK.
      *
           SELECT clients
             ASSIGN TO "clients"
             ORGANIZATION IS INDEXED
             ACCESS IS DYNAMIC
             RECORD KEY IS client_id
             FILE STATUS IS file-status
              LOCK MODE AUTOMATIC WITH ROLLBACK. 
      *    
           SELECT accounts
              ASSIGN TO "accounts"
              ORGANIZATION IS INDEXED
              ACCESS IS DYNAMIC
              RECORD KEY IS accounts-id
              FILE STATUS IS file-status
              LOCK MODE AUTOMATIC WITH ROLLBACK.         

       DATA DIVISION.
       FILE SECTION.
       FD  animals.
       01  animals-record.
           03  animal-info.
               05  patient-id                  pic 9(5).
               05  atype                       pic x.
               05  ctype redefines atype       pic x.
               05  dtype redefines atype       pic x.
               05  otype redefines atype       pic x.
           03  owner-info.
               05  phone                       pic x(8).
               05  owner                       pic x(30).
           03  financial.
               05  acct_no.
                   10  year                    pic 9(2).
                   10  seq_no                  pic 9(4).
               05  last_visit.
                   10  yyyy                    pic 9(4).
                   10  mm                      pic 9(2).
                   10  dd                      pic 9(2).
               05  fee                         pic s9(5)v99.
               05  date_paid                   pic 9(8). 
      *
       FD  clients.
       01  clients-record.
           05  client_id                pic 9(5).
           05  owner-b                 	pic x(30).	
           05  street                  	pic x(30).
           05  city                    	pic x(30).
           05  state_province           pic x(30).
           05  post_code                pic x(6).
           05  country                 	pic x(30).      
      *
       FD  accounts.
       01  accounts-record.
           05 accounts-id               pic 9(5).
           05 months.
       	       10  January              pic 9(6)v9(2).	
               10  February             pic 9(6)v9(2).
               10  March                pic 9(6)v9(2).
               10  April	              pic 9(6)v9(2).
               10  May                  pic 9(6)v9(2).
      	       10  June			            pic 9(6)v9(2).                    


       WORKING-STORAGE SECTION.
           
       01  file-status                      pic xx.
       01  transaction-error                pic 9 value 0.
       
       77 EXTEND-STAT    PIC X(5).
       77 TEXT-MESSAGE   PIC X(100).
       77 STATUS-TYPE    PIC 9 value 1.
       77 ERR-CODE       PIC X(2).        

       PROCEDURE DIVISION.
       DECLARATIVES.
       END DECLARATIVES.              

       MAIN-LOGIC.
       
           open output animals, clients, accounts.


******* First transaction which will go OK

           display "Starting the 1st Transaction"
           accept omitted

           move 0 to transaction-error

           START TRANSACTION
           
           move "00001"          to patient-id.
           move "C"              to atype.
           move "555-0123"       to phone.
           move "Robert Jones"   to owner.
           move 85               to year.
           move 5678             to seq_no.
           move 20020521         to last_visit.
           move 60               to fee.
           move 20020602         to date_paid.
           write animals-record 
                 INVALID KEY  
                 MOVE 1 TO transaction-error.
                 
           move "00001" to client_id.
           move "Holly Roberts" to owner-b.	
           move "1234 10th Street" to street.
           move "San Diego" to city.
           move "California" to state_province.
           move "92121" to post_code.
           move "US" to country.
	         write clients-record
                 INVALID KEY  
                 MOVE 1 TO transaction-error.      
                 
           move "00001" to accounts-id.
           move 25 to January.	
           move 0 to February.
           move 35.75 to March.
           move 0 to April.
           move 60 to May.
           move 0 to June.
           write accounts-record
                 INVALID KEY  
                 MOVE 1 TO transaction-error.                                    
           
           IF transaction-error = 0
              COMMIT TRANSACTION
           else
              ROLLBACK TRANSACTION 
           END-IF      
           
           close animals, clients, accounts.             
           
******* Checking the content of the files
           PERFORM LETTURA-CONTENUTO.         
           
******* SECOND Transaction which will fail and then ROLLBACK

           display "Starting the 2nd Transaction"
           display "Activating the rollback, files should contain only 1
      -            " record"           
           accept omitted

           open I-O animals, clients, accounts.
           
           move 0 to transaction-error

           START TRANSACTION
           
           move "00002"          to patient-id.
           move "D"              to atype.
           move "436-0124"       to phone.
           move "Marco Aurelio"  to owner.
           move 85               to year.
           move 5678             to seq_no.
           move 20020521         to last_visit.
           move 60               to fee.
           move 20020602         to date_paid.
           write animals-record 
                 INVALID KEY  
                 MOVE 1 TO transaction-error.
                 
           move "00002" to client_id.
           move "Alfonso Quaron" to owner-b.	
           move "1234 11th Street" to street.
           move "San Francisco" to city.
           move "California" to state_province.
           move "92121" to post_code.
           move "US" to country.
	         write clients-record
                 INVALID KEY  
                 MOVE 1 TO transaction-error.      
                 
           move "00001" to accounts-id.           | <---------- This key will cause the INVALID KEY error and activate the ROLLBACK
           move 31 to January.	
           move 0 to February.
           move 35.75 to March.
           move 0 to April.
           move 60 to May.
           move 0 to June.
           write accounts-record
                 INVALID KEY  
                 MOVE 1 TO transaction-error.                                    
           
           IF transaction-error = 0
              COMMIT TRANSACTION
           else
              ROLLBACK TRANSACTION 
           END-IF      
           
           close animals, clients, accounts.    
               
******* Checking the content of the files
******* Having activated the ROLLBACK, no new records should be added to the files
           PERFORM LETTURA-CONTENUTO.                

           Exit Program.
           Stop Run.       
           
           
        LETTURA-CONTENUTO.  
            display "Checking the content of the files:"
            accept omitted
               
            open input animals, clients, accounts.        
              
             move low-values to patient-id
             start animals key not < patient-id
             perform until file-status not = "00"
               read animals next with lock
                 at end 
                   accept omitted
                   end-accept
                 not at end
                   display "Animals - " patient-id " - " owner
               end-read
             end-perform.    
             
             move low-values to client_id
             start clients key not < client_id
             perform until file-status not = "00"
               read clients next with lock
                 at end 
                   accept omitted
                   end-accept
                 not at end
                   display "Clients - " client_id " - " owner-b
               end-read
             end-perform.    
             
             move low-values to accounts-id
             start accounts key not < accounts-id
             perform until file-status not = "00"
               read accounts next with lock
                 at end 
                   accept omitted
                   end-accept
                 not at end
                   display "Accounts - " accounts-id " - " January
               end-read
             end-perform.        
             
             close animals, clients, accounts.                       
           