       IDENTIFICATION DIVISION.
       PROGRAM-ID.    SOCKSRV1.

      * Copyright (C) 2001,2003 Micro Focus. All rights reserved.
      *
      * This sample code is supplied for demonstration purposes only
      * on an "as is" basis and is for use at your own risk.

      * This program demonstrates a single-client server.
      * A single client can connect to this server, and
      * when the client disconnects, the server shuts down.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       COPY "socket.def".

       78  DATA-LENGTH                        VALUE 50.
       77  SOCKET-HANDLE-1                    USAGE HANDLE.
       77  SOCKET-HANDLE-2                    USAGE HANDLE.
       77  SERVER-PORT                        PIC 9(4) value zeros.
       77  DATA-FROM-CLIENT                   PIC X(DATA-LENGTH).
       77  CONNECTION-MADE                    PIC X VALUE "N".
       
       77  KEY-PRESSED                        PIC 9.
           88 KEY-WAS-PRESSED                 value 1 when false 0.
       77  COUNTDOWN                          PIC 9.

       PROCEDURE DIVISION.
       MAIN-PGH.
           DISPLAY WINDOW ERASE
           DISPLAY "Enter Port:" at 0205
           ACCEPT SERVER-PORT at 0217
           DISPLAY "Creating server socket..." at 0405
           CALL "C$SOCKET" USING AGS-CREATE-SERVER
                                 SERVER-PORT
                           GIVING SOCKET-HANDLE-1

           IF SOCKET-HANDLE-1 = NULL
               STOP RUN
           END-IF

           DISPLAY "Accepting connection from client..." at 0605
           
           CALL "C$SOCKET" USING AGS-ACCEPT, SOCKET-HANDLE-1
                               GIVING SOCKET-HANDLE-2
 
           ACCEPT KEY-PRESSED FROM INPUT STATUS
                       
           CALL "C$SOCKET" USING AGS-CLOSE, SOCKET-HANDLE-1

           IF SOCKET-HANDLE-2 = NULL
               STOP RUN
           END-IF

           DISPLAY "Waiting for client data..." at 0805
           
           CALL "C$SOCKET" USING AGS-READ
                                 SOCKET-HANDLE-2
                                 DATA-FROM-CLIENT
                                 DATA-LENGTH

           DISPLAY "Data received from the client: " at 1005
           DISPLAY DATA-FROM-CLIENT at 1037

           INSPECT DATA-FROM-CLIENT CONVERTING
                   "ABCDEFGHIJKLMNOPQRSTUVWXYZ" TO
                   "abcdefghijklmnopqrstuvwxyz"

           DISPLAY "Writing lower case text to client..." at 1205
           
           CALL "C$SOCKET" USING AGS-WRITE
                                 SOCKET-HANDLE-2
                                 DATA-FROM-CLIENT
                                 DATA-LENGTH
           
           CALL "C$SOCKET" USING AGS-CLOSE
                                 SOCKET-HANDLE-2
                                 
           DISPLAY "Closing server program down in... " at 1605
           
           PERFORM VARYING COUNTDOWN FROM 5 BY -1
                                     UNTIL COUNTDOWN = 0
               DISPLAY COUNTDOWN at 1640                      
               CALL "C$SLEEP" USING 1
           END-PERFORM                     
           
           STOP RUN.
