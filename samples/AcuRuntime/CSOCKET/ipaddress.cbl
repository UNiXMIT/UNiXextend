       IDENTIFICATION DIVISION.
       PROGRAM-ID.    IPADDRESS.

      * Copyright (C) 2001 Micro Focus. All rights reserved.
      *
      * This sample code is supplied for demonstration purposes only
      * on an "as is" basis and is for use at your own risk.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       COPY "socket.def".

       01 HOST-NAME              PIC X(50) VALUE SPACES.
       01 IP-ADDRESS             PIC X(20) VALUE SPACES.

       PROCEDURE DIVISION.
       MAIN-PGH.
           CALL "C$SOCKET" USING AGS-GETHOSTNAME HOST-NAME
           CALL "C$SOCKET" USING AGS-GETHOSTADDR IP-ADDRESS

           DISPLAY MESSAGE
                   "HostName - " HOST-NAME H"0A"
                   "IP Address - " IP-ADDRESS
                   TITLE "IP Address"
                       
           goback.
