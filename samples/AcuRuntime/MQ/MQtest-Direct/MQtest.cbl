       IDENTIFICATION DIVISION.
       PROGRAM-ID.                      MQtest.
       REMARKS. 
      *   COMPILE_OPTIONS_REQUIRED:
      *        32-Bit: -si MQ32 -sx MQ64 -d5
      *        64-Bit: -si MQ64 -sx MQ32 -d5

      *   RUNTIME_OPTIONS_REQUIRED: -c mq.cfg

      *   This program tests the basic MQSERIES CALLS:
      *        MQCONNX - Connect to Queue Manager (extended)
      *        MQDISC  - Disconnect from Queue Manager
      *        MQOPEN  - Open Queue 
      *                    - input mode (get messages off of the queue)
      *                    - browse mode (read only gets)
      *                    - output mode (enable puts)
      *        MQCLOSE - Close Queue
      *        MQPUT   - Put messages on Queue
      *        MQGET   - Get messages off of Queue

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

       DATA DIVISION.
       FILE SECTION.

       WORKING-STORAGE SECTION.
       COPY "acucobol.def".
       COPY "acugui.def".
       COPY "crtvars.def".

      ******************************************************************
      *    CALL Parameters for common calls (MQCONNXMQDISC,MQOPEN,     *
      *    MQCLOSE,MQGET,MQPUT)                                        *
      ******************************************************************
       01 QMGRNAME                  PIC X(48) VALUE SPACES.
       01 HCONN                     PIC S9(9) BINARY.
       01 COMPCODE                  PIC S9(9) BINARY.
       01 REASON                    PIC S9(9) BINARY.
       01 OPTIONS                   PIC S9(9) BINARY.
       01 HOBJ                      PIC S9(9) BINARY.
       01 BUFFER-LENGTH             PIC S9(9) BINARY.
       01 MAX-BUFF-LENGTH           PIC S9(9) BINARY.
       01 BUFFER                    PIC X(1024).
       01 UID                       PIC X(20) VALUE SPACES.
       01 PWD                       PIC X(20) VALUE SPACES.
            
       01 DATA-LENGTH               PIC S9(9) BINARY.
       01 MSG-COUNT                 PIC 9999.
       01 WS-COUNT                  PIC 9(2) VALUE ZERO.
       01 UID-SIZE                  PIC 9(3) VALUE ZERO.
       01 PWD-SIZE                  PIC 9(3) VALUE ZERO.

      * OTHER VARIABLES
       01 TARGET-QUEUE              PIC X(20).
       01 CALL-NAME                 PIC x(20).
       01 IRF-USER-ID               PIC X(48) VALUE SPACES.
       01 IRF-NETNAME               PIC X(48) VALUE SPACES.
       01 IRF-WKSTATID              PIC X(48) VALUE SPACES.
       01 PIC-X26                   PIC X(26) 
                                    VALUE "15/09/2021 16:36:40:50".

       01 W301-WI-ID                PIC X(40) 
                                    VALUE "199926400016". |WorkItemID.
       01 W301-WB-ID                PIC X(25) 
                                    VALUE "970-00000".    |WorkBasketID.

       01 W301CMPI                  PIC X(02) VALUE "01". |Comp Code
       01 W301ACTI                  PIC X(03) VALUE "ADD".|Action Taken
       01 W301CAUI                  PIC X(03) VALUE "001".|Cause Code.  

      ******************************************************************
      *    Declare MQI structures needed                               *
      ******************************************************************
      *    MQI named constants
       01  MY-MQ-CONSTANTS.
      *    COPY "cobcpy32/CMQV".                                        MQ32
           COPY "cobcpy64/CMQV".                                        MQ64
      * Connect Options
       01  CONNECTOPTS.
      *     COPY "cobcpy32/CMQCNOV".                                    MQ32
           COPY "cobcpy64/CMQCNOV".                                     MQ64            
      * Security Parameters     
       01  SECPARAM. 
      *    COPY "cobcpy32/CMQCSPV".                                     MQ32
           COPY "cobcpy64/CMQCSPV".                                     MQ64
      *    Object Descriptor
       01  OBJDESC.
      *    COPY "cobcpy32/CMQODV".                                      MQ32
           COPY "cobcpy64/CMQODV".                                      MQ64
      *    Message Descriptor
       01  MSGDESC.
      *    COPY "cobcpy32/CMQMDV".                                      MQ32
           COPY "cobcpy64/CMQMDV".                                      MQ64
      *    Put message options
       01  PUTMSGOPTS.
      *    COPY "cobcpy32/CMQPMOV".                                     MQ32
           COPY "cobcpy64/CMQPMOV".                                     MQ64
      *    Get message options
       01  GETMSGOPTS.
      *    COPY "cobcpy32/CMQGMOV".                                     MQ32
           COPY "cobcpy64/CMQGMOV".                                     MQ64

       LINKAGE SECTION.

       SCREEN SECTION.

       PROCEDURE DIVISION.
           ACCEPT SYSTEM-INFORMATION FROM SYSTEM-INFO
           ACCEPT TERMINAL-ABILITIES FROM TERMINAL-INFO

           DISPLAY "Queue Manager Name = " AT 0101
           ACCEPT QMGRNAME AT 0122 DEFAULT "QM1"
           DISPLAY "Target Queue = " AT 0201
           ACCEPT TARGET-QUEUE AT 0216 DEFAULT "DEV.QUEUE.1"
           DISPLAY "Username = " AT 0301
           ACCEPT UID AT 0312 DEFAULT "app"
           DISPLAY "Password = " AT 0401
           ACCEPT PWD AT 0412 DEFAULT "passw"

           INITIALIZE WS-COUNT
           SET UID-SIZE TO SIZE OF UID
           INSPECT UID TALLYING WS-COUNT FOR TRAILING SPACES
           COMPUTE MQCSP-CSPUSERIDLENGTH = UID-SIZE - WS-COUNT
           INITIALIZE WS-COUNT
           SET PWD-SIZE TO SIZE OF PWD
           INSPECT PWD TALLYING WS-COUNT FOR TRAILING SPACES
           COMPUTE MQCSP-CSPPASSWORDLENGTH = PWD-SIZE - WS-COUNT

           MOVE MQCNO-VERSION-5 TO MQCNO-VERSION
           MOVE MQMD-VERSION-2  TO MQMD-CURRENT-VERSION
           MOVE MQPMO-VERSION-2 TO MQPMO-CURRENT-VERSION
           MOVE MQGMO-VERSION-2 TO MQGMO-CURRENT-VERSION
           MOVE MQOD-VERSION-2  TO MQOD-CURRENT-VERSION

           SET MQCNO-SECURITYPARMSPTR TO ADDRESS OF SECPARAM
           MOVE MQCSP_AUTH_USER_ID_AND_PWD TO MQCSP-AUTHENTICATIONTYPE
           SET MQCSP-CSPUSERIDPTR TO ADDRESS OF UID
           SET MQCSP-CSPPASSWORDPTR TO ADDRESS OF PWD

           MOVE USER-ID    TO IRF-USER-ID
           MOVE USER-ID    TO IRF-NETNAME
           MOVE STATION-ID TO IRF-WKSTATID

      *    Indicate that sample program has started
           DISPLAY 'MQtest: Simple put and get test.' AT 0501
           MOVE 1024 TO MAX-BUFF-LENGTH
           DISPLAY "Buffer Length from 126 to 1024   " AT 0701
           ACCEPT MAX-BUFF-LENGTH UPDATE
           PERFORM CONNECT-TO-QUEUE-MANAGER
           IF COMPCODE = 0    

      *    set options to open queue for output 
               ADD MQOO-OUTPUT MQOO-FAIL-IF-QUIESCING
                     GIVING OPTIONS
               PERFORM OPEN-QUEUE
               PERFORM PUT-MESSAGES-ON-QUEUE
               PERFORM CLOSE-QUEUE
               
      *    set options to open queue for browsing
               ADD MQOO-BROWSE MQOO-FAIL-IF-QUIESCING
                     GIVING OPTIONS
               PERFORM OPEN-QUEUE

      *    set options for get to browse mode         
               MOVE MQGMO-BROWSE-NEXT TO MQGMO-OPTIONS
               PERFORM GET-MESSAGES-OFF-QUEUE
               PERFORM CLOSE-QUEUE               
               
      *    set options to open queue for input
               ADD MQOO-INPUT-AS-Q-DEF MQOO-FAIL-IF-QUIESCING
                     GIVING OPTIONS
               PERFORM OPEN-QUEUE

      *    turn browse mode on get off
               MOVE MQGMO-NONE TO MQGMO-OPTIONS
               PERFORM GET-MESSAGES-OFF-QUEUE
               PERFORM CLOSE-QUEUE
           END-IF.

           DISPLAY "TESTS COMPLETE!".
           PERFORM DISCONNECT-FROM-QUEUE-MANAGER. 
           ACCEPT OMITTED.
           GOBACK.
           
      ******************************************************************
      *    Connect to the queue manager                                *
      ******************************************************************
       connect-to-queue-manager.
           
           CALL 'MQCONNX' USING QMGRNAME
                                by reference CONNECTOPTS
                                by reference HCONN
                                by reference COMPCODE
                                by reference REASON
           IF COMPCODE NOT EQUAL 0
               MOVE "MQCONNX" TO CALL-NAME
               PERFORM ERROR-HANDLING
           ELSE
               DISPLAY "Connection to queue manager successful"
           END-IF.
      ******************************************************************
      *    Open the message queue                                      *
      ******************************************************************
       OPEN-QUEUE.
           MOVE TARGET-QUEUE TO MQOD-OBJECTNAME
           CALL 'MQOPEN' USING by value HCONN 
                               by reference OBJDESC
                               by value OPTIONS
                               by reference HOBJ
                               by reference COMPCODE
                               by reference REASON.
         
      *    report reason, if any; stop if failed
           IF REASON IS NOT EQUAL TO MQRC-NONE
               DISPLAY 'MQOPEN ended with reason code ' REASON
           END-IF.

           IF COMPCODE IS EQUAL TO MQCC-FAILED
               DISPLAY 'unable to open server queue for output'
               MOVE REASON TO RETURN-CODE
               PERFORM DISCONNECT-FROM-QUEUE-MANAGER
           END-IF.
           
      *    declare open a success if we get this far
           display "Queue " TARGET-QUEUE " open.". 
             
      ******************************************************************
      *    Put messages on the message queue                           *
      ******************************************************************
       PUT-MESSAGES-ON-QUEUE.

           PERFORM BUILD-MESSAGE-HEADER THRU BUILD-MESSAGE-TRAILER.
           MOVE MAX-BUFF-LENGTH TO BUFFER-LENGTH.

           CALL "MQPUT" USING by value HCONN
                              by value HOBJ
                              by reference MSGDESC
                              by reference PUTMSGOPTS
                              by value BUFFER-LENGTH
                              by reference BUFFER
                              by reference COMPCODE
                              by reference REASON.
           IF REASON NOT EQUAL ZERO
               PERFORM ERROR-HANDLING.                               
            
           DISPLAY "1 message put on the queue". 
           ACCEPT OMITTED.
         
      ******************************************************************
      *    Build the long message.                                     *
      ******************************************************************
       BUILD-MESSAGE-HEADER.
           MOVE LOW-VALUES TO BUFFER.
           MOVE 1          TO BUFFER-LENGTH.
           STRING 'BC_MSH|`~\&|1|' 
                  IRF-USER-ID '|' 
                  IRF-NETNAME  '|' 
                  IRF-WKSTATID '||'
                  DELIMITED BY SPACES
                  INTO BUFFER WITH POINTER BUFFER-LENGTH. 

           STRING PIC-X26
                  DELIMITED BY SIZE
                  INTO BUFFER WITH POINTER BUFFER-LENGTH.     
      
       BUILD-THE-MESSAGE.
           STRING 'BC_MSH|`~\&|2|', 
                  'WF_CPT|1|' 
                  W301-WB-ID '|'
                  W301-WI-ID
                  DELIMITED BY SPACES
                  INTO BUFFER WITH POINTER BUFFER-LENGTH.

           STRING '|INQ_CMPLT_CD~' W301CMPI
                  '`INQ_ACTN_CD~'  W301ACTI
                  '`INQ_CS_CD~'    W301CAUI
                  DELIMITED BY SIZE
                  INTO BUFFER WITH POINTER BUFFER-LENGTH.

       BUILD-MESSAGE-TRAILER.
           STRING 'BC_MSH|`~\&|3|'
                  DELIMITED BY SIZE
                  INTO BUFFER WITH POINTER BUFFER-LENGTH.
       
      ******************************************************************
      *    Close the source queue                                      *
      ******************************************************************
       CLOSE-QUEUE.             
           MOVE MQCO-NONE TO OPTIONS.
           CALL 'MQCLOSE' USING by value HCONN
                                by reference HOBJ
                                by value OPTIONS
                                by reference COMPCODE
                                by reference REASON.

      *    report reason, if any
           IF REASON IS NOT EQUAL TO MQRC-NONE
               DISPLAY 'MQCLOSE ended with reason code ' REASON
           END-IF.

      *    declare close a success if we get this far
           DISPLAY "Queue " TARGET-QUEUE " closed.". 

      ******************************************************************
      *    Get messages from the message queue                         *
      ******************************************************************
       GET-MESSAGES-OFF-QUEUE.
           MOVE 0 TO MSG-COUNT.
           PERFORM GET-NEXT-MESSAGE WITH TEST BEFORE
               UNTIL COMPCODE IS EQUAL TO MQCC-FAILED.

      ******************************************************************
      *    Get one message                                             *
      *        In order to read the messages in sequence, MSGID and    *
      *    CORRELID must have the default value.  MQGET sets them      *
      *    to the values for the message it returns, so re-initialise  *
      *    them each time                                              *
      ******************************************************************
       GET-NEXT-MESSAGE.
           MOVE MQMI-NONE TO MQMD-MSGID.
           MOVE MQCI-NONE TO MQMD-CORRELID.
           MOVE SPACES TO BUFFER.
           MOVE Max-Buff-Length TO BUFFER-LENGTH.
           MOVE 15000 TO MQGMO-WAITINTERVAL.

           CALL 'MQGET' USING by value HCONN
                              by value HOBJ
                              by reference MSGDESC
                              by reference GETMSGOPTS
                              by value BUFFER-LENGTH
                              by reference BUFFER
                              by reference DATA-LENGTH
                              by reference COMPCODE
                              by reference REASON.

      *    Display message received 
           IF COMPCODE IS NOT EQUAL TO MQCC-FAILED
             IF MSG-COUNT IS EQUAL TO 0
               DISPLAY 'Messages in ' MQGMO-RESOLVEDQNAME
             END-IF
             ADD 1 TO MSG-COUNT
             DISPLAY MSG-COUNT ': ' BUFFER
             ACCEPT OMITTED
           END-IF.

      *    Report reason, if any 
           IF REASON IS NOT EQUAL TO MQRC-NONE
             IF REASON IS EQUAL TO MQRC-NO-MSG-AVAILABLE
               DISPLAY 'no more messages'
             ELSE
               IF DATA-LENGTH IS GREATER THAN BUFFER-LENGTH
                 DISPLAY '   --- truncated'
               ELSE
                 DISPLAY 'MQGET ended with reason code ' REASON
               END-IF
             END-IF
           END-IF.
           
      ******************************************************************
      *    Disconnect from queue manager (if not previously connected) *
      ******************************************************************
       DISCONNECT-FROM-QUEUE-MANAGER.
           IF REASON IS NOT EQUAL TO MQRC-ALREADY-CONNECTED
             CALL 'MQDISC' USING by reference HCONN
                                 by reference COMPCODE
                                 by reference REASON

      *      report reason, if any
             IF REASON IS NOT EQUAL TO MQRC-NONE
               DISPLAY 'MQDISC ended with reason code ' REASON
             END-IF
           END-IF.
           
           ACCEPT OMITTED.
           GOBACK.

      ******************************************************************
      *    Error Hanlding Section                                      *
      ******************************************************************
       ERROR-HANDLING. 
               DISPLAY CALL-NAME " failed!".   
               DISPLAY "QMGRNAME: " QMGRNAME. 
               DISPLAY "HCONN: " HCONN.
               DISPLAY "COMPCODE: " COMPCODE. 
               DISPLAY "REASON: " REASON.
               ACCEPT OMITTED.
               GOBACK.
