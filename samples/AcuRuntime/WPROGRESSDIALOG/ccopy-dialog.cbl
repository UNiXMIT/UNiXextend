       identification division.
       program-id. prog.
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

       copy "acugui.def".

       77  FILE-STATUS               PIC 9(3).   
       
       77  ws-errors                 pic 9 value 0.
       
       01  FILE-INFO-SERVER. 
           02  FILE-SIZE-SERVER    PIC X(8) COMP-X. 
           02  FILE-DATE-SERVER    PIC 9(8) COMP-X. 
           02  FILE-TIME-SERVER    PIC 9(8) COMP-X. 

       01  FILE-INFO-CLIENT. 
           02  FILE-SIZE-CLIENT    PIC X(8) COMP-X. 
           02  FILE-DATE-CLIENT    PIC 9(8) COMP-X. 
           02  FILE-TIME-CLIENT    PIC 9(8) COMP-X. 

       77  time-start              pic 9(8).
       77  time-end                pic 9(8).
       77  ws-size                 pic X(18).
       77  ws-server-file          pic X(100) value 
           "pdf.pdf".
       77  ws-client-file          pic X(100) value 
           "@[DISPLAY]:C:\temp\pdf.pdf".
       77  pd-handle usage handle value 0.
       77  rval pic 9(5) value 0.
           
       procedure division.
       main-logic.
       
       
           CALL "C$FILEINFO"  
                USING ws-server-file, 
                      FILE-INFO-SERVER,  
                GIVING FILE-STATUS 
                
           IF FILE-STATUS = 0

              MOVE FILE-SIZE-SERVER TO ws-size
              DISPLAY "File size on the server is " ws-size
                      UPON ERROR-LOG
                             
              accept time-start from time
              DISPLAY "C$COPY starts at " time-start UPON ERROR-LOG
            
              CALL "w$progressdialog" using WPROGRESSDIALOG-CREATE 
                 "Title" "Cancel Message" 
                 WPROGRESSDIALOG-MODAL 
                 WPROGRESSDIALOG-ANIMATION-FILECOPY giving pd-handle

              CALL "w$progressdialog" using WPROGRESSDIALOG-C-COPY
                                            pd-handle

              CALL "C$COPY"  
                   USING ws-server-file  
                         ws-client-file
                   GIVING FILE-STATUS 
                   
              CALL "w$progressdialog" using WPROGRESSDIALOG-QUERY-CANCEL
                                            pd-handle giving rval
              if rval = 1 then
             
              CALL "w$progressdialog" using WPROGRESSDIALOG-DESTROY 
                                            pd-handle
              end-if
             
              DISPLAY "C$COPY FILE-STATUS = " FILE-STATUS 
                      UPON ERROR-LOG

           IF FILE-STATUS = 0

                 accept time-end from time
                 DISPLAY "C$COPY ends at   " time-end 
                         UPON ERROR-LOG

                 CALL "C$FILEINFO"  
                   USING ws-client-file, 
                         FILE-INFO-CLIENT  
                   GIVING FILE-STATUS    

                 MOVE FILE-SIZE-CLIENT TO ws-size                   
                 DISPLAY  "File size on the client is " ws-size 
                          UPON ERROR-LOG                        

                 IF FILE-SIZE-SERVER = FILE-SIZE-CLIENT
                    DISPLAY  "C$COPY SUCCESFUL!" UPON ERROR-LOG
                    DISPLAY MESSAGE BOX "C$COPY SUCCESFUL!"     
                 ELSE
                    DISPLAY "C$FILEINFO - Error on the client"
                            UPON ERROR-LOG
                    DISPLAY MESSAGE BOX 
                            "C$FILEINFO - Error on the client",
                            H"0A",
                            "server file size: " FILE-SIZE-SERVER 
                            H"0A",
                            "client file size: " FILE-SIZE-CLIENT                           
                 END-IF
              
              ELSE
                 DISPLAY "C$COPY - Error in copy" UPON ERROR-LOG
                 DISPLAY MESSAGE BOX "C$COPY - Error in copy"                                     
              END-IF
           
           ELSE
              DISPLAY "C$FILEINFO - Error on the server" UPON ERROR-LOG
              DISPLAY MESSAGE BOX "C$FILEINFO - Error on the server"            
           END-IF           
           .
       	   stop run.