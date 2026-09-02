       IDENTIFICATION DIVISION.
       PROGRAM-ID.  HTTPPOST-WEBHOOK.

      * COPYRIGHT (C) 2018 MICRO FOCUS. ALL RIGHTS RESERVED.
      *
      * THIS SAMPLE CODE IS SUPPLIED FOR DEMONSTRATION PURPOSES ONLY
      * ON AN "AS IS" BASIS AND IS FOR USE AT YOUR OWN RISK.

      * COMPILE WITH -SL

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       COPY "acucobol.def".

       01  REQUEST-PAYLOAD             USAGE POINTER.
       01  REQUEST-LEN                 PIC S9(6) VALUE ZERO.
       01  RESPONSE-PAYLOAD            USAGE POINTER.
       01  RESPONSE-LEN                PIC S9(6) VALUE ZERO.
       01  RESPONSE-STATUS             PIC 9(3) VALUE ZERO.
       01  SSL-VERIFYPEER-FLAG         PIC 9 VALUE 0.
       01  STATUS-CODE                 PIC 9(3) VALUE ZERO.
       01  MESSAGE-DATA                PIC X(64) VALUE SPACES.
       01  REQUEST-DATA                PIC X(100) VALUE SPACES.
       01  POST-ADDRESS                PIC X(200) VALUE "https://webhook-test.com/b331965e9a18acaf4f57e7f5c162de5c".
       78  CONTENT-TYPE VALUE 'application/json'.

       PROCEDURE DIVISION.
           PERFORM SETUP
           PERFORM HTTPPOST
           GOBACK.

       SETUP.
           INITIALIZE REQUEST-PAYLOAD REQUEST-LEN
           SET REQUEST-PAYLOAD TO ADDRESS OF REQUEST-DATA
           
           CALL "NETINIT" GIVING RESPONSE-STATUS
           CALL "NETSSLVERIFYPEER" USING SSL-VERIFYPEER-FLAG 
                                   GIVING STATUS-CODE.
           CALL "HTTPSETRESPONSEHEADER" USING 0 
                                        GIVING STATUS-CODE
           
           DISPLAY "Enter Message: " AT 0510
           ACCEPT MESSAGE-DATA AT 0526
           STRING '{"content": "' DELIMITED BY SIZE
                  MESSAGE-DATA DELIMITED BY "  "
                  '"}' DELIMITED BY SIZE
                  INTO REQUEST-DATA

           SET REQUEST-LEN TO SIZE OF REQUEST-DATA.
          

       HTTPPOST.
           CALL "HTTPPOST"
             USING
               POST-ADDRESS
               CONTENT-TYPE
               REQUEST-PAYLOAD
               REQUEST-LEN
               RESPONSE-PAYLOAD
               RESPONSE-LEN
             GIVING
               RESPONSE-STATUS.