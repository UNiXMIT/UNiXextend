      >>IMP(ACU-CBLFLAGS=-sl) 
       IDENTIFICATION DIVISION.
       PROGRAM-ID.                      AI.
       AUTHOR.  MIT. 
       
      *** Runtime Options
      ** WINDOWS
      * -y rmnet.dll
      ** LINUX
      * -y librmnet64.so

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.

       WORKING-STORAGE SECTION.
       COPY "acucobol.def".

       01  REQUEST-PAYLOAD             USAGE POINTER.
       01  REQUEST-LEN                 PIC S9(6) VALUE ZERO.
       01  RESPONSE-PAYLOAD            USAGE POINTER.
       01  RESPONSE-LEN                PIC S9(6) VALUE ZERO.
       01  RESPONSE-STATUS             PIC 9(3) VALUE ZERO.
       01  SSL-VERIFYPEER-FLAG         PIC 9 VALUE 0.
       01  RES-HEADER                  PIC 9 VALUE 0. 
       01  SSL-VERSION                 PIC X(20) VALUE "TLSv1_3".        
       01  STATUS-CODE                 PIC 9(3) VALUE ZERO.
       01  POST-ADDRESS                PIC X(200) VALUE "https://generativelanguage.googleapis.com/v1beta/interactions".
       78  CONTENT-TYPE                VALUE 'application/json'.
       78  NEWLINE                     VALUE H"0A".

       01  EXTRA-HEADERS.
           05 filler PIC X(14) value 'x-goog-api-key'.
           05 filler PIC X value x"00".
           05 filler PIC X(60) value 'XXX.XXX.XXX.XXX'.    | ENTER YOUR API KEY HERE
           05 filler PIC X value x"00".
           05 filler PIC X value x"00".
       
       01  JSON-STRING.
           05 FILLER PIC X     VALUE '{'.
           05 FILLER PIC X(30) VALUE '"model": "gemma-4-26b-a4b-it",'.
           05 FILLER PIC X(65) VALUE '"system_instruction": "Keep the response under 500 characters",'.
           05 FILLER PIC X(35) VALUE '"input": "What is Rocket AcuCOBOL?"'.
           05 FILLER PIC X     VALUE '}'.
       
       01  JSON-DATA.
           05 ws-id                                 PIC X(100).
           05 ws-status                             PIC X(20).
           05 ws-usage.
               10 total_tokens                      PIC 9(9).
               10 total_input_tokens                PIC 9(9).
               10 input_tokens_by_modality OCCURS 10 TIMES.
                   15 modality                      PIC X(20).
                   15 tokens                        PIC 9(9).
               10 total_cached_tokens               PIC 9(9).
               10 total_output_tokens               PIC 9(9).
               10 total_tool_use_tokens             PIC 9(9).
               10 total_thought_tokens              PIC 9(9).
               10 initial_input_tokens              PIC 9(9).
           05 created                               PIC X(20).
           05 updated                               PIC X(20).
           05 service_tier                          PIC X(20).
           05 steps OCCURS 10 TIMES.
               10 signature                         PIC X(100).
               10 summary OCCURS 10 TIMES.
                   15 ws-summary-text               PIC X(1000).
                   15 ws-summary-type               PIC X(20).
               10 ws-content OCCURS 10 TIMES.
                   15 ws-content-text               PIC X(500).
                   15 ws-content-type               PIC X(20).
               10 ws-step-type                      PIC X(20).
           05 ws-object                             PIC X(20).
           05 model                                 PIC X(100).
       
       01  JSON-DATA2.
           05 ws-error.
               10 ws-message                        PIC X(200).
               10 ws-code                           PIC X(20).
       
       LINKAGE SECTION.
       01  RESPONSE-DATA                            PIC X(10000).

       PROCEDURE DIVISION.
           PERFORM SETUP
           PERFORM HTTPPOST
           PERFORM GET-RESPONSE
           GOBACK.

       SETUP.
           INITIALIZE REQUEST-PAYLOAD REQUEST-LEN
           SET REQUEST-PAYLOAD TO ADDRESS OF JSON-STRING
           CALL "NETINIT" GIVING RESPONSE-STATUS
           CALL "NETSSLVERIFYPEER" USING SSL-VERIFYPEER-FLAG 
                                   GIVING STATUS-CODE
           CALL "HTTPSETRESPONSEHEADER" USING RES-HEADER 
                                        GIVING STATUS-CODE
           CALL "NetSetSSLCA" USING "cacert.pem"
                              GIVING STATUS-CODE
           CALL "HTTPSETSSLVERSION" USING SSL-VERSION
                                    GIVING STATUS-CODE
           SET REQUEST-LEN TO SIZE OF JSON-STRING.
          
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
                   PERFORM PARSE-RESPONSE
                   DISPLAY MESSAGE ws-content-text(2 1)
                           TITLE "AI: SUCCESS"
               END-IF
           END-IF
           CALL "NETFREE" USING RESPONSE-PAYLOAD.
       
       PARSE-RESPONSE.
           JSON PARSE RESPONSE-DATA(1:RESPONSE-LEN) INTO JSON-DATA
                NAME JSON-DATA OMITTED
                     ws-id IS 'id'
                     ws-status IS 'status'
                     ws-usage IS 'usage'
                     ws-content IS 'content'
                     ws-object IS 'object'
                     ws-step-type IS 'type'
                     ws-summary-text IS 'text'
                     ws-summary-type IS 'type'
                     ws-content-text IS 'text'
                     ws-content-type IS 'type'
                ON EXCEPTION
                   PERFORM PARSE-ERROR
           END-JSON.

       PARSE-ERROR.
           JSON PARSE RESPONSE-DATA(1:RESPONSE-LEN) INTO JSON-DATA2
                NAME JSON-DATA2 OMITTED
                     ws-error IS 'error'
                     ws-message IS 'message'
                     ws-code IS 'code'
           IF ws-code OF JSON-DATA2 NOT = SPACES
               DISPLAY MESSAGE "Error Code: " ws-code OF JSON-DATA2
                               NEWLINE
                               "Error Message: " ws-message OF JSON-DATA2
                       TITLE "AI: ERROR"
               STOP RUN
           END-IF.