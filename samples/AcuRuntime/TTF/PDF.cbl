       identification division.
       program-id. Print-PDF. 
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
       input-output section.
       file-control.
           select file-output 
           ASSIGN TO PRINT ws-printer
           organization is LINE SEQUENTIAL                                      
           FILE STATUS IS FILE-STATUS.
       
       data division.
       file section.              
       FD file-output.
       01 file-output-rec.
           05 file-record           PIC  X(132).
                                     
       
       working-storage section.
       77 FILE-STATUS          pic XX. 
       77 ws-x                 pic 999 value 0.
       
       01 WS-PRINTER           PIC X(51) VALUE SPACES.
       01 FONT-NAME            PIC X(100) VALUE SPACES.
       
       procedure division.
       main-logic.
	   
           ACCEPT FONT-NAME FROM ENVIRONMENT "PDF_FONT_TRUETYPE_TTF"

           STRING "-p pdf " DELIMITED BY SIZE
                  FONT-NAME DELIMITED BY "."
                  ".PDF" DELIMITED BY SIZE
               INTO WS-PRINTER

           open output file-output.
		   
           
           move "Testing PDF Printing custom fonts"
		   to file-record
              
           
           write file-output-rec
           close file-output.
                  	   
       	   stop run.