       IDENTIFICATION DIVISION.
       PROGRAM-ID.     mqtest1.
       REMARKS.        
           This program tests the basic MQSERIES CALLS:
               MQCONN  - Connect to Queue Manager
               MQDISC  - Disconnect from Queue Manager
               MQOPEN  - Open Queue 
                           - input mode (get messages off of the queue)
                           - browse mode (read only gets)
                           - output mode (enable puts)
               MQCLOSE - Close Queue
               MQPUT   - Put messages on Queue
               MQGET   - Get messages off of Queue
      ****************************************************************
       DATA DIVISION.
       WORKING-STORAGE SECTION.
      *
           COPY Acucobol.def.
           COPY Acugui.def.
           COPY Crtvars.def.
      ******************************************************************
      *    Declare MQI structures needed                               *
      ******************************************************************
      *    MQI named constants
       01  MY-MQ-CONSTANTS.
           COPY "CMQV.CPY".
      *    Object Descriptor
       01  OBJDESC.
           COPY "CMQODV.CPY".
      *    Message Descriptor
       01  MSGDESC.
           COPY "CMQMDV.CPY".
      *    Put message options
       01  PUTMSGOPTS.
           COPY "CMQPMOV.CPY".
      *    Get message options
       01  GETMSGOPTS.
           COPY "CMQGMOV.CPY".
      ******************************************************************
      *    CALL Parameters for common calls (MQCONN,MQDISC,MQOPEN,     *
      *    MQCLOSE,MQGET,MQPUT)                                        *
      ******************************************************************
       01  QM-NAME                    PIC X(48) VALUE SPACES.
       01  HCONN                      PIC S9(9) BINARY.
       01  COMPCODE                   PIC S9(9) BINARY.
       01  REASON                     PIC S9(9) BINARY.
       01  OPTIONS                    PIC S9(9) BINARY.
       01  HOBJ                       PIC S9(9) BINARY.
       01  BUFFER-LENGTH              PIC S9(9) BINARY.
       01  Max-Buff-Length            PIC S9(9) BINARY.
       01  BUFFER                     PIC X(1024).

       01  DATA-LENGTH                PIC S9(9) BINARY.
       01  MSG-COUNT                  PIC 9999.
      
      * OTHER VARIABLES
       01  TARGET-QUEUE               PIC X(20).
       01  call-name                  pic x(20).
       01  IRF-USER-ID                PIC X(48) VALUE SPACES.
       01  IRF-NETNAME                PIC X(48) VALUE SPACES.
       01  IRF-WKSTATID               PIC X(48) VALUE SPACES.
       01  PIC-X26                    PIC X(26) 
                                      VALUE "12/01/2000 11:31:40:50".

       01  W301-WI-ID                 PIC X(40) 
                                      VALUE "199926400016".   |WorkItem ID.
       01  W301-WB-ID                 PIC X(25) 
                                      VALUE "970-00000".      |WorkBasket ID.

       01  W301CMPI                   PIC X(02) VALUE "01". |Comp Code
       01  W301ACTI                   PIC X(03) VALUE "ADD". |Action Taken
       01  W301CAUI                   PIC X(03) VALUE "001". |Cause Code.

      ****************************************************************
       PROCEDURE DIVISION.
       main-logic.
      *
           SET CONFIGURATION "DLL-CONVENTION" TO 0.
           SET CONFIGURATION "CODE-PREFIX"    TO 
                             ".\object;C:\MQClient\BIN".
      *
      **************************Load the MQClient DLL*******************
      *
      *    CALL "./mqic32.dll".
      *
      * get system information
           ACCEPT System-Information FROM System-Info
      * get terminal information
           ACCEPT Terminal-Abilities FROM Terminal-Info
           MOVE MQMD-VERSION-2          TO MQMD-CURRENT-VERSION.
           MOVE MQPMO-VERSION-2         TO MQPMO-CURRENT-VERSION.
           MOVE MQGMO-VERSION-2         TO MQGMO-CURRENT-VERSION.
           MOVE MQOD-VERSION-2          TO MQOD-CURRENT-VERSION.
      *
           MOVE "ACUCORP.QUEUE.MGR"     TO QM-Name.
           MOVE "ORANGE.QUEUE" to target-queue.
           MOVE User-ID                 TO IRF-USER-ID.
           MOVE User-ID                 TO IRF-NETNAME.
           MOVE Station-ID              TO IRF-WKSTATID.
      *
      *    Indicate that sample program has started
           DISPLAY 'mqtest1: Simple put and get test.' Line 2, Col 5.
           MOVE 126 TO Max-Buff-Length.
           DISPLAY "Buffer Length from 126 to 1024   " Line 4, Col 5. 
           ACCEPT Max-Buff-Length  UPDATE.
           perform connect-to-queue-manager.
           if COMPCODE = 0           
      *    set options to open queue for output 
               ADD MQOO-OUTPUT MQOO-FAIL-IF-QUIESCING
                     GIVING OPTIONS
               perform open-queue
               perform put-messages-on-queue
               perform close-queue
               
      *    set options to open queue for browsing
               ADD MQOO-BROWSE MQOO-FAIL-IF-QUIESCING
                     GIVING OPTIONS
               perform open-queue
      *    set options for get to browse mode         
               MOVE MQGMO-BROWSE-NEXT TO MQGMO-OPTIONS
               perform get-messages-off-queue
               perform close-queue               
               
      *    set options to open queue for input
               ADD MQOO-INPUT-AS-Q-DEF MQOO-FAIL-IF-QUIESCING
                     GIVING OPTIONS
               perform open-queue
      *    turn browse mode on get off
               MOVE MQGMO-NONE TO MQGMO-OPTIONS
               perform get-messages-off-queue
               perform close-queue
           end-if.
           display "Tests Complete!".
           perform disconnect-from-queue-manager. 
           accept omitted.
           exit program.
           stop run.
           
      ******************************************************************
      *    Connect to the queue manager                                *
      ******************************************************************
       connect-to-queue-manager.
           CALL 'MQCONN'
               USING QM-NAME, HCONN,
               COMPCODE, REASON.
           if COMPCODE not equal 0
               move "MQCONN" to call-name
               perform Error-handling
           else
               display "Connection to queue manager successful"
           end-if.    
      
      ******************************************************************
      *    Open the message queue                                      *
      ******************************************************************
       open-queue.

           MOVE TARGET-QUEUE TO MQOD-OBJECTNAME.
           CALL 'MQOPEN'
               USING HCONN, OBJDESC,
               OPTIONS, HOBJ,
               COMPCODE, REASON.
         
      *    report reason, if any; stop if failed
           IF REASON IS NOT EQUAL TO MQRC-NONE
               DISPLAY 'MQOPEN ended with reason code ' REASON
           END-IF.

           IF COMPCODE IS EQUAL TO MQCC-FAILED
               DISPLAY 'unable to open server queue for output'
               MOVE REASON TO RETURN-CODE
               perform disconnect-from-queue-manager
           END-IF.
           
      *    declare open a success if we get this far
           display "Queue " TARGET-QUEUE " open.". 
             
      ******************************************************************
      *    Put messages on the message queue                           *
      ******************************************************************
       put-messages-on-queue.

           PERFORM Build-Message-Header thru Build-Message-Trailer.
           MOVE Max-Buff-Length TO BUFFER-LENGTH.

           CALL "MQPUT" USING HCONN, HOBJ, MSGDESC,
                PUTMSGOPTS, BUFFER-LENGTH, BUFFER,
                COMPCODE, REASON.
           IF REASON NOT EQUAL ZERO
               perform error-handling.                               
            
           Display "1 message put on the queue". 
           ACCEPT Omitted.
      *
      *    Build the long message.
      *
       Build-Message-Header.
      *
           MOVE low-values TO buffer.
           MOVE 1          TO Buffer-Length.
           STRING 'BC_MSH|`~\&|1|' 
                  IRF-USER-ID '|' 
                  IRF-NETNAME  '|' 
                  IRF-WKSTATID '||'
                  DELIMITED by SPACES
                  into Buffer with pointer Buffer-Length. 

           STRING Pic-X26
                  DELIMITED BY SIZE
                  INTO Buffer with pointer Buffer-Length.     
      *
       Build-The-Message.
      *
           STRING 'BC_MSH|`~\&|2|', 
                  'WF_CPT|1|' 
                  W301-WB-ID '|'
                  W301-WI-ID
                  delimited by SPACES
                  into Buffer with pointer Buffer-Length.

           STRING '|INQ_CMPLT_CD~' W301CMPI
                  '`INQ_ACTN_CD~'  W301ACTI
                  '`INQ_CS_CD~'    W301CAUI
                  delimited by SIZE
                  into Buffer with pointer Buffer-Length.
      *
       Build-Message-Trailer.
      *
           STRING 'BC_MSH|`~\&|3|'
                  delimited by size
                  into Buffer with pointer Buffer-Length.
      *  
      ******************************************************************
      *    Close the source queue                                      *
      ******************************************************************
       close-queue.             
           MOVE MQCO-NONE TO OPTIONS.
           CALL 'MQCLOSE'
               USING HCONN, HOBJ, OPTIONS,
               COMPCODE, REASON.

      *      report reason, if any
           IF REASON IS NOT EQUAL TO MQRC-NONE
               DISPLAY 'MQCLOSE ended with reason code ' REASON
           END-IF.
      *    declare close a success if we get this far
           display "Queue " TARGET-QUEUE " closed.". 

      ******************************************************************
      *    Get messages from the message queue                         *
      ******************************************************************
       get-messages-off-queue.
           MOVE 0 TO MSG-COUNT.
           PERFORM get-next-message WITH TEST BEFORE
               UNTIL COMPCODE IS EQUAL TO MQCC-FAILED.
      ******************************************************************
      *    Get one message                                             *
      *        In order to read the messages in sequence, MSGID and    *
      *    CORRELID must have the default value.  MQGET sets them      *
      *    to the values for the message it returns, so re-initialise  *
      *    them each time                                              *
      ******************************************************************
       get-next-message.
           MOVE MQMI-NONE TO MQMD-MSGID.
           MOVE MQCI-NONE TO MQMD-CORRELID.
           MOVE SPACES TO BUFFER.
           MOVE Max-Buff-Length TO BUFFER-LENGTH.
           MOVE 15000 TO MQGMO-WAITINTERVAL.

           CALL 'MQGET'
            USING HCONN, HOBJ,
            MSGDESC, GETMSGOPTS,
            BUFFER-LENGTH, BUFFER, DATA-LENGTH,
            COMPCODE, REASON.

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
       disconnect-from-queue-manager.
           IF REASON IS NOT EQUAL TO MQRC-ALREADY-CONNECTED
             CALL 'MQDISC'
              USING HCONN, COMPCODE, REASON

      *      report reason, if any
             IF REASON IS NOT EQUAL TO MQRC-NONE
               DISPLAY 'MQDISC ended with reason code ' REASON
             END-IF
           END-IF.
           
           accept omitted.
           goback.

      ******************************************************************
      *    Error Hanlding Section                                      *
      ******************************************************************
       Error-handling. 
               display call-name " failed!".   
               display "QM-NAME: " QM-NAME. 
               display "HCONN: " HCONN.
               display "COMPCODE: " COMPCODE. 
               display "REASON: " REASON.
               accept omitted.
               goback.

