       IDENTIFICATION DIVISION.
       PROGRAM-ID.    SOCKCLI.

      * Copyright (C) 2001 Micro Focus. All rights reserved.
      *
      * This sample code is supplied for demonstration purposes only
      * on an "as is" basis and is for use at your own risk.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       COPY "socket.def".

       78  DATA-LENGTH                        VALUE 50.
       77  SOCKET-HANDLE                      USAGE HANDLE.
       77  SERVER-NAME                        PIC X(20) value spaces.
       77  SERVER-PORT                        PIC 9(4) value zeros.
       77  DATA-FROM-CLIENT                   PIC X(DATA-LENGTH).
       77  READ-AMOUNT                        PIC 99.
       77  DATA-READ                          PIC X value space.

       PROCEDURE DIVISION.
       MAIN-PGH.
           DISPLAY WINDOW ERASE
           DISPLAY "Enter Server Name:" at 0205
           ACCEPT SERVER-NAME at 0224 
           DISPLAY "Enter Port:" at 0305
           ACCEPT SERVER-PORT at 0317
           
           DISPLAY "Connecting to server... " at 0505
           
           INSPECT SERVER-NAME REPLACING TRAILING SPACES BY LOW-VALUES
           
           CALL "C$SOCKET" USING AGS-CREATE-CLIENT
                                 SERVER-PORT
                                 SERVER-NAME
                           GIVING SOCKET-HANDLE
           
           IF SOCKET-HANDLE = NULL
               STOP RUN
           END-IF

           DISPLAY "Enter data to send to server:" at 0705
           MOVE SPACES TO DATA-FROM-CLIENT
           ACCEPT DATA-FROM-CLIENT at 0735
           
           PERFORM UNTIL DATA-READ = "Y"
               IF DATA-FROM-CLIENT = SPACES
                   EXIT PERFORM
               END-IF
               
               CALL "C$SOCKET" USING AGS-WRITE
                                     SOCKET-HANDLE
                                     DATA-FROM-CLIENT
                                     DATA-LENGTH
                                     
               CALL "C$SOCKET" USING AGS-READ
                                     SOCKET-HANDLE
                                     DATA-FROM-CLIENT
                                     DATA-LENGTH
                               GIVING READ-AMOUNT
               
               DISPLAY "Data returned from server:" at 0905
               DISPLAY DATA-FROM-CLIENT at 0935
               MOVE "Y" TO DATA-READ
               ACCEPT OMITTED
           END-PERFORM    
           
           CALL "C$SOCKET" USING AGS-CLOSE
                                 SOCKET-HANDLE
           STOP RUN.
