       program-id. Print-PDF. 

       file-control.
           select file-output 
           ASSIGN TO PRINT ws-printer
           organization is LINE SEQUENTIAL                                      
           FILE STATUS IS FILE-STATUS.
       
       file section.              
       FD file-output.
       01 file-output-rec.
           05 file-record           PIC  X(132).    
       
       working-storage section.
       01 FIle-STATUS          pic 9(2) value zero.
       01 ws-printer.
          05 print-prefix      pic x(8) value "-p PDF ".
          05 print-name        pic x(50) value spaces.

       procedure division.
       main-logic.
       
           display "Enter PDF filename (e.g. TestPrint.pdf): " at 0201
           accept print-name at 0242     

           open output file-output
           
           move "Test Print" to file-record
              
           
           write file-output-rec
           close file-output.
   
           stop run.