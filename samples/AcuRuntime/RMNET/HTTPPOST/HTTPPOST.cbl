       IDENTIFICATION DIVISION.
       PROGRAM-ID.  HTTPPOST.

      *** RUNTIME OPTIONS
      ** WINDOWS
      * -y rmnet.dll HTTPPOST.acu
      ** LINUX
      * -y librmnet64.so HTTPPOST.acu

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       COPY "acucobol.def".

       01  REQUEST-PAYLOAD             USAGE POINTER.
       01  REQUEST-LEN                 PIC S9(6) VALUE ZERO.
       01  RESPONSE-PAYLOAD            USAGE POINTER.
       01  RESPONSE-LEN                PIC S9(6) VALUE ZERO.
       01  RESPONSE-STATUS             PIC 9(3) VALUE ZERO.
       01  SSL-VERIFYPEER-FLAG         PIC 9 VALUE 1.
       01  RES-HEADER                  PIC 9 VALUE 0. 
       01  SSL-VERSION                 PIC X(20) VALUE "TLSv1_2".        
       01  STATUS-CODE                 PIC 9(3) VALUE ZERO.
       01  WS-DATA                     PIC X(200).
       01  POST-ADDRESS  PIC X(200) VALUE "https://reqres.in/api/users".
       78  CONTENT-TYPE                VALUE 'application/json'.
       78  NEWLINE                     VALUE H"0A".
       
       01 EXTRA-HEADERS.
           05 filler PIC X(9) value 'x-api-key'.
           05 filler PIC X value x"00".
           05 filler PIC X(150) value 'reqres-free-v1'.
           05 filler PIC X value x"00".
           05 filler PIC X value x"00".
       
       LINKAGE SECTION.
       01  RESPONSE-DATA               PIC X(2000).

       PROCEDURE DIVISION.
           PERFORM SETUP
           PERFORM HTTPPOST
           PERFORM GET-RESPONSE
           GOBACK.

       SETUP.
           INITIALIZE REQUEST-PAYLOAD REQUEST-LEN
           SET REQUEST-PAYLOAD TO ADDRESS OF WS-DATA
           CALL "NETINIT" GIVING RESPONSE-STATUS
           CALL "NETSSLVERIFYPEER" USING SSL-VERIFYPEER-FLAG 
                                   GIVING STATUS-CODE
           CALL "HTTPSETRESPONSEHEADER" USING RES-HEADER 
                                        GIVING STATUS-CODE
           CALL "NetSetSSLCA" USING "cacert.pem"
                              GIVING STATUS-CODE
           CALL "HTTPSETSSLVERSION" USING SSL-VERSION
                                    GIVING STATUS-CODE
           STRING '{"name":"morpheus","job":"leader"}' INTO WS-DATA
           SET REQUEST-LEN TO SIZE OF WS-DATA.
          
       HTTPPOST.
           CALL "HTTPPOST"
             USING
               POST-ADDRESS
               CONTENT-TYPE
               REQUEST-PAYLOAD
               REQUEST-LEN
               RESPONSE-PAYLOAD
               RESPONSE-LEN
               EXTRA-HEADERS
             GIVING
               RESPONSE-STATUS.

       GET-RESPONSE.          
           SET ADDRESS OF RESPONSE-DATA TO RESPONSE-PAYLOAD           
           IF NOT RESPONSE-STATUS = 0
               CALL "NETGETERROR" USING RESPONSE-PAYLOAD RESPONSE-LEN
               SET ADDRESS OF RESPONSE-DATA TO RESPONSE-PAYLOAD
               DISPLAY MESSAGE BOX "RESPONSE STATUS: " RESPONSE-STATUS
                         NEWLINE  
                         "ERROR MESSAGE: " RESPONSE-DATA(1:RESPONSE-LEN)
                         TITLE "RMNET: ERROR"
           ELSE
               IF RESPONSE-LEN = 0
                   DISPLAY MESSAGE "No Response Payload."
                                   TITLE "RMNET: EMPTY RESPONSE"
               ELSE
                   DISPLAY MESSAGE RESPONSE-DATA
                                   TITLE "RMNET: SUCCESS"
               END-IF
           END-IF
           CALL "NETFREE" USING RESPONSE-PAYLOAD.