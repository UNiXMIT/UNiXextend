       identification division.
       program-id. test-CCOPY-with-ENV.
       author. supportline@microfocus.com. 
       remarks.       
       environment division.
       SPECIAL-NAMES. 
           SYSERR IS ERROR-LOG.               
       input-output section.
       file-control.
       data division.
       file section.
              
       working-storage section.
       77  FILE-STATUS             PIC 9(3).   
       
       77  ws-errors               pic 9 value 0.
       
       01  FILE-INFO-INPUT. 
           02  FILE-SIZE-INPUT     PIC X(8) COMP-X. 
           02  FILE-DATE-INPUT     PIC 9(8) COMP-X. 
           02  FILE-TIME-INPUT     PIC 9(8) COMP-X. 

       01  FILE-INFO-OUTPUT. 
           02  FILE-SIZE-OUTPUT    PIC X(8) COMP-X. 
           02  FILE-DATE-OUTPUT    PIC 9(8) COMP-X. 
           02  FILE-TIME-OUTPUT    PIC 9(8) COMP-X. 

       77  time-start              pic 9(8).
       77  time-end                pic 9(8).
       77  ws-size                 pic X(18).
       77  ws-input-file           pic X(100) value spaces.
       77  ws-output-file          pic X(100) value spaces.
       77  ws-check-input-file     pic x(5)   value spaces.
       77  ws-check-output-file    pic x(5)   value spaces.
           
       procedure division.
       main-logic.
       
           accept ws-input-file  from environment "ENV-INPUT-FILE"
           accept ws-output-file from environment "ENV-OUTPUT-FILE" 
           accept ws-check-input-file from environment 
                                      "ENV-FILEINFO-INPUT"
           accept ws-check-output-file from environment 
                                       "ENV-FILEINFO-OUTPUT"
           
           PERFORM CHECK-INPUT-FILE.           
           PERFORM COPY-FILE.
           PERFORM CHECK-OUTPUT-FILE.
           
           goback.
           
           
           
       CHECK-INPUT-FILE.           
           IF ws-check-input-file = "1" or "TRUE" or "ON"
           
             CALL "C$FILEINFO"  
                  USING ws-input-file, 
                        FILE-INFO-INPUT,  
                  GIVING FILE-STATUS 

             IF FILE-STATUS = 0

                MOVE FILE-SIZE-INPUT TO ws-size
                DISPLAY "File size to copy is " ws-size 
                        UPON ERROR-LOG
                                    
             ELSE      
                      
                DISPLAY MESSAGE BOX "C$FILEINFO failed for input file"    

             END-IF           

           END-IF
           .
           
           
        COPY-FILE.                                 
              DISPLAY MESSAGE BOX "Copying file " x"0d0a"
                                  ws-input-file   x"0d0a"
                                  " into "        x"0d0a"
                                  ws-output-file   
                                                  
              accept time-start from time
              DISPLAY "C$COPY starts at " time-start UPON ERROR-LOG

              CALL "C$COPY"  
                   USING ws-input-file,  
                         ws-output-file
      *                "T"
                   GIVING FILE-STATUS 

              DISPLAY "C$COPY FILE-STATUS = " FILE-STATUS 
                      UPON ERROR-LOG
                      
              accept time-end from time
              DISPLAY "C$COPY ends at   " time-end UPON ERROR-LOG

              IF FILE-STATUS = 0                 
                 DISPLAY MESSAGE BOX "C$COPY process completed. "
              ELSE
                 DISPLAY MESSAGE BOX "C$COPY failed with status = " 
                                     FILE-STATUS
              END-IF   
              .
              
              
       CHECK-OUTPUT-FILE.  
           IF ws-check-output-file = "1" or "TRUE" or "YES" or "Y"
           
              CALL "C$FILEINFO"  
                   USING ws-output-file, 
                         FILE-INFO-OUTPUT,  
                   GIVING FILE-STATUS    

              MOVE FILE-SIZE-OUTPUT TO ws-size                   
              DISPLAY  "File of the copied size is " ws-size 
                       UPON ERROR-LOG                        

              IF FILE-SIZE-INPUT = FILE-SIZE-OUTPUT
                 DISPLAY  "C$COPY OK!" UPON ERROR-LOG
                 DISPLAY MESSAGE BOX 
                                 "C$COPY OK!"  x"0d0a"
                                 "Input file size:  " FILE-SIZE-INPUT  
                                 x"0d0a"
                                 "Copied file size: " FILE-SIZE-OUTPUT
              ELSE
                 DISPLAY "C$FILEINFO failed for output file"
                         UPON ERROR-LOG
                 DISPLAY MESSAGE BOX 
                         "C$FILEINFO - Error on the copy",
                         H"0A",
                         "input file size:  " FILE-SIZE-INPUT 
                         H"0A",
                         "output file size: " FILE-SIZE-OUTPUT                           
              END-IF
                                       
           END-IF
           .   
              