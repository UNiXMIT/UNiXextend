      ******************************************************************
      **                                                              **
      **                  IBM MQSeries for Windows NT                 **
      **                                                              **
      **  COPYBOOK NAME:  CMQV                                        **
      **                                                              **
      **  DESCRIPTION:    Constants for Main MQI                      **
      **                                                              **
      ******************************************************************
      **  @START_COPYRIGHT@                                           **
      **  Licensed Materials - Property of IBM                        **
      **                                                              **
      **  04L1830, 5639-B43                                           **
      **                                                              **
      **  (C) Copyright IBM Corporation 1993, 1999.                   **
      **                                                              **
      **  Status: Version 5 Release 1                                 **
      **  @END_COPYRIGHT@                                             **
      ******************************************************************
      **                                                              **
      **  FUNCTION:       This file declares the named constants for  **
      **                  the main MQI.                               **
      **                                                              **
      **  PROCESSOR:      COBOL                                       **
      **                                                              **
      ******************************************************************
 
      ******************************************************************
      **  Values Related to MQBO Structure                            **
      ******************************************************************
 
      **   Structure Identifier
        10 MQBO-STRUC-ID PIC X(4) VALUE 'BO  '.
 
      **   Structure Version Number
        10 MQBO-VERSION-1       PIC S9(9) BINARY VALUE 1.
        10 MQBO-CURRENT-VERSION PIC S9(9) BINARY VALUE 1.
 
      **   Begin Options
        10 MQBO-NONE PIC S9(9) BINARY VALUE 0.
 
 
      ******************************************************************
      **  Values Related to MQCIH Structure                           **
      ******************************************************************
 
      **   Structure Identifier
        10 MQCIH-STRUC-ID PIC X(4) VALUE 'CIH '.
 
      **   Structure Version Number
        10 MQCIH-VERSION-1       PIC S9(9) BINARY VALUE 1.
        10 MQCIH-VERSION-2       PIC S9(9) BINARY VALUE 2.
        10 MQCIH-CURRENT-VERSION PIC S9(9) BINARY VALUE 2.
 
      **   Structure Length
        10 MQCIH-LENGTH-1       PIC S9(9) BINARY VALUE 164.
        10 MQCIH-LENGTH-2       PIC S9(9) BINARY VALUE 180.
        10 MQCIH-CURRENT-LENGTH PIC S9(9) BINARY VALUE 180.
 
      **   Flags
        10 MQCIH-NONE PIC S9(9) BINARY VALUE 0.
 
      **   Return Code
        10 MQCRC-OK                    PIC S9(9) BINARY VALUE 0.
        10 MQCRC-CICS-EXEC-ERROR       PIC S9(9) BINARY VALUE 1.
        10 MQCRC-MQ-API-ERROR          PIC S9(9) BINARY VALUE 2.
        10 MQCRC-BRIDGE-ERROR          PIC S9(9) BINARY VALUE 3.
        10 MQCRC-BRIDGE-ABEND          PIC S9(9) BINARY VALUE 4.
        10 MQCRC-APPLICATION-ABEND     PIC S9(9) BINARY VALUE 5.
        10 MQCRC-SECURITY-ERROR        PIC S9(9) BINARY VALUE 6.
        10 MQCRC-PROGRAM-NOT-AVAILABLE PIC S9(9) BINARY VALUE 7.
        10 MQCRC-BRIDGE-TIMEOUT        PIC S9(9) BINARY VALUE 8.
        10 MQCRC-TRANSID-NOT-AVAILABLE PIC S9(9) BINARY VALUE 9.
 
      **   Unit of Work Control
        10 MQCUOWC-ONLY     PIC S9(9) BINARY VALUE 273.
        10 MQCUOWC-CONTINUE PIC S9(9) BINARY VALUE 65536.
        10 MQCUOWC-FIRST    PIC S9(9) BINARY VALUE 17.
        10 MQCUOWC-MIDDLE   PIC S9(9) BINARY VALUE 16.
        10 MQCUOWC-LAST     PIC S9(9) BINARY VALUE 272.
        10 MQCUOWC-COMMIT   PIC S9(9) BINARY VALUE 256.
        10 MQCUOWC-BACKOUT  PIC S9(9) BINARY VALUE 4352.
 
      **   Get Wait Interval
        10 MQCGWI-DEFAULT PIC S9(9) BINARY VALUE -2.
 
      **   Link Type
        10 MQCLT-PROGRAM     PIC S9(9) BINARY VALUE 1.
        10 MQCLT-TRANSACTION PIC S9(9) BINARY VALUE 2.
 
      **   Output Data Length
        10 MQCODL-AS-INPUT PIC S9(9) BINARY VALUE -1.
 
      **   ADS Descriptor
        10 MQCADSD-NONE      PIC S9(9) BINARY VALUE 0.
        10 MQCADSD-SEND      PIC S9(9) BINARY VALUE 1.
        10 MQCADSD-RECV      PIC S9(9) BINARY VALUE 16.
        10 MQCADSD-MSGFORMAT PIC S9(9) BINARY VALUE 256.
 
      **   Conversational Task
        10 MQCCT-YES PIC S9(9) BINARY VALUE 1.
        10 MQCCT-NO  PIC S9(9) BINARY VALUE 0.
 
      **   Task End Status
        10 MQCTES-NOSYNC  PIC S9(9) BINARY VALUE 0.
        10 MQCTES-COMMIT  PIC S9(9) BINARY VALUE 256.
        10 MQCTES-BACKOUT PIC S9(9) BINARY VALUE 4352.
        10 MQCTES-ENDTASK PIC S9(9) BINARY VALUE 65536.
 
      **   Facility
        10 MQCFAC-NONE PIC X(8) VALUE LOW-VALUES.
 
      **   Function
        10 MQCFUNC-MQCONN PIC X(4) VALUE 'CONN'.
        10 MQCFUNC-MQGET  PIC X(4) VALUE 'GET '.
        10 MQCFUNC-MQINQ  PIC X(4) VALUE 'INQ '.
        10 MQCFUNC-MQOPEN PIC X(4) VALUE 'OPEN'.
        10 MQCFUNC-MQPUT  PIC X(4) VALUE 'PUT '.
        10 MQCFUNC-MQPUT1 PIC X(4) VALUE 'PUT1'.
        10 MQCFUNC-NONE   PIC X(4) VALUE SPACES.
 
      **   Start Code
        10 MQCSC-START     PIC X(4) VALUE 'S   '.
        10 MQCSC-STARTDATA PIC X(4) VALUE 'SD  '.
        10 MQCSC-TERMINPUT PIC X(4) VALUE 'TD  '.
        10 MQCSC-NONE      PIC X(4) VALUE SPACES.
 
 
      ******************************************************************
      **  Values Related to MQCNO Structure                           **
      ******************************************************************
 
      **   Structure Identifier
        10 MQCNO-STRUC-ID PIC X(4) VALUE 'CNO '.
 
      **   Structure Version Number
        10 MQCNO-VERSION-1       PIC S9(9) BINARY VALUE 1.
        10 MQCNO-VERSION-2       PIC S9(9) BINARY VALUE 2.
        10 MQCNO-CURRENT-VERSION PIC S9(9) BINARY VALUE 2.
 
      **   Connect Options
        10 MQCNO-STANDARD-BINDING PIC S9(9) BINARY VALUE 0.
        10 MQCNO-FASTPATH-BINDING PIC S9(9) BINARY VALUE 1.
        10 MQCNO-NONE             PIC S9(9) BINARY VALUE 0.
 
 
      ******************************************************************
      **  Values Related to MQDH Structure                            **
      ******************************************************************
 
      **   Structure Identifier
        10 MQDH-STRUC-ID PIC X(4) VALUE 'DH  '.
 
      **   Structure Version Number
        10 MQDH-VERSION-1       PIC S9(9) BINARY VALUE 1.
        10 MQDH-CURRENT-VERSION PIC S9(9) BINARY VALUE 1.
 
      **   General Flags
        10 MQDHF-NEW-MSG-IDS PIC S9(9) BINARY VALUE 1.
        10 MQDHF-NONE        PIC S9(9) BINARY VALUE 0.
 
      **   Put Message Record Flags
      **   See values for "Put Message Record Fields" under MQPMO
 
 
      ******************************************************************
      **  Values Related to MQDLH Structure                           **
      ******************************************************************
 
      **   Structure Identifier
        10 MQDLH-STRUC-ID PIC X(4) VALUE 'DLH '.
 
      **   Structure Version Number
        10 MQDLH-VERSION-1       PIC S9(9) BINARY VALUE 1.
        10 MQDLH-CURRENT-VERSION PIC S9(9) BINARY VALUE 1.
 
 
      ******************************************************************
      **  Values Related to MQGMO Structure                           **
      ******************************************************************
 
      **   Structure Identifier
        10 MQGMO-STRUC-ID PIC X(4) VALUE 'GMO '.
 
      **   Structure Version Number
        10 MQGMO-VERSION-1       PIC S9(9) BINARY VALUE 1.
        10 MQGMO-VERSION-2       PIC S9(9) BINARY VALUE 2.
        10 MQGMO-VERSION-3       PIC S9(9) BINARY VALUE 3.
        10 MQGMO-CURRENT-VERSION PIC S9(9) BINARY VALUE 3.
 
      **   Get-Message Options
        10 MQGMO-WAIT                    PIC S9(9) BINARY VALUE 1.
        10 MQGMO-NO-WAIT                 PIC S9(9) BINARY VALUE 0.
        10 MQGMO-SYNCPOINT               PIC S9(9) BINARY VALUE 2.
        10 MQGMO-SYNCPOINT-IF-PERSISTENT PIC S9(9) BINARY VALUE 4096.
        10 MQGMO-NO-SYNCPOINT            PIC S9(9) BINARY VALUE 4.
        10 MQGMO-MARK-SKIP-BACKOUT       PIC S9(9) BINARY VALUE 128.
        10 MQGMO-BROWSE-FIRST            PIC S9(9) BINARY VALUE 16.
        10 MQGMO-BROWSE-NEXT             PIC S9(9) BINARY VALUE 32.
        10 MQGMO-BROWSE-MSG-UNDER-CURSOR PIC S9(9) BINARY VALUE 2048.
        10 MQGMO-MSG-UNDER-CURSOR        PIC S9(9) BINARY VALUE 256.
        10 MQGMO-LOCK                    PIC S9(9) BINARY VALUE 512.
        10 MQGMO-UNLOCK                  PIC S9(9) BINARY VALUE 1024.
        10 MQGMO-ACCEPT-TRUNCATED-MSG    PIC S9(9) BINARY VALUE 64.
        10 MQGMO-SET-SIGNAL              PIC S9(9) BINARY VALUE 8.
        10 MQGMO-FAIL-IF-QUIESCING       PIC S9(9) BINARY VALUE 8192.
        10 MQGMO-CONVERT                 PIC S9(9) BINARY VALUE 16384.
        10 MQGMO-LOGICAL-ORDER           PIC S9(9) BINARY VALUE 32768.
        10 MQGMO-COMPLETE-MSG            PIC S9(9) BINARY VALUE 65536.
        10 MQGMO-ALL-MSGS-AVAILABLE      PIC S9(9) BINARY VALUE 131072.
        10 MQGMO-ALL-SEGMENTS-AVAILABLE  PIC S9(9) BINARY VALUE 262144.
        10 MQGMO-NONE                    PIC S9(9) BINARY VALUE 0.
 
      **   Wait Interval
        10 MQWI-UNLIMITED PIC S9(9) BINARY VALUE -1.
 
      **   Signal Values
        10 MQEC-MSG-ARRIVED           PIC S9(9) BINARY VALUE 2.
        10 MQEC-WAIT-INTERVAL-EXPIRED PIC S9(9) BINARY VALUE 3.
        10 MQEC-WAIT-CANCELED         PIC S9(9) BINARY VALUE 4.
        10 MQEC-Q-MGR-QUIESCING       PIC S9(9) BINARY VALUE 5.
        10 MQEC-CONNECTION-QUIESCING  PIC S9(9) BINARY VALUE 6.
 
      **   Match Options
        10 MQMO-MATCH-MSG-ID         PIC S9(9) BINARY VALUE 1.
        10 MQMO-MATCH-CORREL-ID      PIC S9(9) BINARY VALUE 2.
        10 MQMO-MATCH-GROUP-ID       PIC S9(9) BINARY VALUE 4.
        10 MQMO-MATCH-MSG-SEQ-NUMBER PIC S9(9) BINARY VALUE 8.
        10 MQMO-MATCH-OFFSET         PIC S9(9) BINARY VALUE 16.
        10 MQMO-NONE                 PIC S9(9) BINARY VALUE 0.
 
      **   Group Status
        10 MQGS-NOT-IN-GROUP      PIC X VALUE ' '.
        10 MQGS-MSG-IN-GROUP      PIC X VALUE 'G'.
        10 MQGS-LAST-MSG-IN-GROUP PIC X VALUE 'L'.
 
      **   Segment Status
        10 MQSS-NOT-A-SEGMENT PIC X VALUE ' '.
        10 MQSS-SEGMENT       PIC X VALUE 'S'.
        10 MQSS-LAST-SEGMENT  PIC X VALUE 'L'.
 
      **   Segmentation
        10 MQSEG-INHIBITED PIC X VALUE ' '.
        10 MQSEG-ALLOWED   PIC X VALUE 'A'.
 
      **   Message Token
        10 MQMTOK-NONE PIC X(16) VALUE LOW-VALUES.
 
      **   Returned Length
        10 MQRL-UNDEFINED PIC S9(9) BINARY VALUE -1.
 
 
      ******************************************************************
      **  Values Related to MQIIH Structure                           **
      ******************************************************************
 
      **   Structure Identifier
        10 MQIIH-STRUC-ID PIC X(4) VALUE 'IIH '.
 
      **   Structure Version Number
        10 MQIIH-VERSION-1       PIC S9(9) BINARY VALUE 1.
        10 MQIIH-CURRENT-VERSION PIC S9(9) BINARY VALUE 1.
 
      **   Structure Length
        10 MQIIH-LENGTH-1 PIC S9(9) BINARY VALUE 84.
 
      **   Flags
        10 MQIIH-NONE PIC S9(9) BINARY VALUE 0.
 
      **   Authenticator
        10 MQIAUT-NONE PIC X(8) VALUE SPACES.
 
      **   Transaction Instance Identifier
        10 MQITII-NONE PIC X(16) VALUE LOW-VALUES.
 
      **   Transaction State
        10 MQITS-IN-CONVERSATION     PIC X VALUE 'C'.
        10 MQITS-NOT-IN-CONVERSATION PIC X VALUE ' '.
 
      **   Commit Mode
        10 MQICM-COMMIT-THEN-SEND PIC X VALUE '0'.
        10 MQICM-SEND-THEN-COMMIT PIC X VALUE '1'.
 
      **   Security Scope
        10 MQISS-CHECK PIC X VALUE 'C'.
        10 MQISS-FULL  PIC X VALUE 'F'.
 
 
      ******************************************************************
      **  Values Related to MQMD Structure                            **
      ******************************************************************
 
      **   Structure Identifier
        10 MQMD-STRUC-ID PIC X(4) VALUE 'MD  '.
 
      **   Structure Version Number
        10 MQMD-VERSION-1       PIC S9(9) BINARY VALUE 1.
        10 MQMD-VERSION-2       PIC S9(9) BINARY VALUE 2.
        10 MQMD-CURRENT-VERSION PIC S9(9) BINARY VALUE 2.
 
      **   Report Options
        10 MQRO-EXCEPTION                 PIC S9(9) BINARY VALUE
             16777216.
        10 MQRO-EXCEPTION-WITH-DATA       PIC S9(9) BINARY VALUE
             50331648.
        10 MQRO-EXCEPTION-WITH-FULL-DATA  PIC S9(9) BINARY VALUE
             117440512.
        10 MQRO-EXPIRATION                PIC S9(9) BINARY VALUE
             2097152.
        10 MQRO-EXPIRATION-WITH-DATA      PIC S9(9) BINARY VALUE
             6291456.
        10 MQRO-EXPIRATION-WITH-FULL-DATA PIC S9(9) BINARY VALUE
             14680064.
        10 MQRO-COA                       PIC S9(9) BINARY VALUE 256.
        10 MQRO-COA-WITH-DATA             PIC S9(9) BINARY VALUE 768.
        10 MQRO-COA-WITH-FULL-DATA        PIC S9(9) BINARY VALUE 1792.
        10 MQRO-COD                       PIC S9(9) BINARY VALUE 2048.
        10 MQRO-COD-WITH-DATA             PIC S9(9) BINARY VALUE 6144.
        10 MQRO-COD-WITH-FULL-DATA        PIC S9(9) BINARY VALUE 14336.
        10 MQRO-PAN                       PIC S9(9) BINARY VALUE 1.
        10 MQRO-NAN                       PIC S9(9) BINARY VALUE 2.
        10 MQRO-NEW-MSG-ID                PIC S9(9) BINARY VALUE 0.
        10 MQRO-PASS-MSG-ID               PIC S9(9) BINARY VALUE 128.
        10 MQRO-COPY-MSG-ID-TO-CORREL-ID  PIC S9(9) BINARY VALUE 0.
        10 MQRO-PASS-CORREL-ID            PIC S9(9) BINARY VALUE 64.
        10 MQRO-DEAD-LETTER-Q             PIC S9(9) BINARY VALUE 0.
        10 MQRO-DISCARD-MSG               PIC S9(9) BINARY VALUE
             134217728.
        10 MQRO-NONE                      PIC S9(9) BINARY VALUE 0.
 
      **   Report Options Masks
        10 MQRO-REJECT-UNSUP-MASK         PIC S9(9) BINARY VALUE
             270270464.
        10 MQRO-ACCEPT-UNSUP-MASK         PIC S9(9) BINARY VALUE
             -270532353.
        10 MQRO-ACCEPT-UNSUP-IF-XMIT-MASK PIC S9(9) BINARY VALUE 261888.
 
      **   Message Types
        10 MQMT-SYSTEM-FIRST PIC S9(9) BINARY VALUE 1.
        10 MQMT-REQUEST      PIC S9(9) BINARY VALUE 1.
        10 MQMT-REPLY        PIC S9(9) BINARY VALUE 2.
        10 MQMT-DATAGRAM     PIC S9(9) BINARY VALUE 8.
        10 MQMT-REPORT       PIC S9(9) BINARY VALUE 4.
        10 MQMT-SYSTEM-LAST  PIC S9(9) BINARY VALUE 65535.
        10 MQMT-APPL-FIRST   PIC S9(9) BINARY VALUE 65536.
        10 MQMT-APPL-LAST    PIC S9(9) BINARY VALUE 999999999.
 
      **   Expiry
        10 MQEI-UNLIMITED PIC S9(9) BINARY VALUE -1.
 
      **   Feedback Values
        10 MQFB-NONE                   PIC S9(9) BINARY VALUE 0.
        10 MQFB-SYSTEM-FIRST           PIC S9(9) BINARY VALUE 1.
        10 MQFB-QUIT                   PIC S9(9) BINARY VALUE 256.
        10 MQFB-EXPIRATION             PIC S9(9) BINARY VALUE 258.
        10 MQFB-COA                    PIC S9(9) BINARY VALUE 259.
        10 MQFB-COD                    PIC S9(9) BINARY VALUE 260.
        10 MQFB-CHANNEL-COMPLETED      PIC S9(9) BINARY VALUE 262.
        10 MQFB-CHANNEL-FAIL-RETRY     PIC S9(9) BINARY VALUE 263.
        10 MQFB-CHANNEL-FAIL           PIC S9(9) BINARY VALUE 264.
        10 MQFB-APPL-CANNOT-BE-STARTED PIC S9(9) BINARY VALUE 265.
        10 MQFB-TM-ERROR               PIC S9(9) BINARY VALUE 266.
        10 MQFB-APPL-TYPE-ERROR        PIC S9(9) BINARY VALUE 267.
        10 MQFB-STOPPED-BY-MSG-EXIT    PIC S9(9) BINARY VALUE 268.
        10 MQFB-XMIT-Q-MSG-ERROR       PIC S9(9) BINARY VALUE 271.
        10 MQFB-PAN                    PIC S9(9) BINARY VALUE 275.
        10 MQFB-NAN                    PIC S9(9) BINARY VALUE 276.
        10 MQFB-STOPPED-BY-CHAD-EXIT   PIC S9(9) BINARY VALUE 277.
        10 MQFB-STOPPED-BY-PUBSUB-EXIT PIC S9(9) BINARY VALUE 279.
        10 MQFB-NOT-A-REPOSITORY-MSG   PIC S9(9) BINARY VALUE 280.
        10 MQFB-DATA-LENGTH-ZERO       PIC S9(9) BINARY VALUE 291.
        10 MQFB-DATA-LENGTH-NEGATIVE   PIC S9(9) BINARY VALUE 292.
        10 MQFB-DATA-LENGTH-TOO-BIG    PIC S9(9) BINARY VALUE 293.
        10 MQFB-BUFFER-OVERFLOW        PIC S9(9) BINARY VALUE 294.
        10 MQFB-LENGTH-OFF-BY-ONE      PIC S9(9) BINARY VALUE 295.
        10 MQFB-IIH-ERROR              PIC S9(9) BINARY VALUE 296.
        10 MQFB-NOT-AUTHORIZED-FOR-IMS PIC S9(9) BINARY VALUE 298.
        10 MQFB-IMS-ERROR              PIC S9(9) BINARY VALUE 300.
        10 MQFB-IMS-FIRST              PIC S9(9) BINARY VALUE 301.
        10 MQFB-IMS-LAST               PIC S9(9) BINARY VALUE 399.
        10 MQFB-CICS-INTERNAL-ERROR    PIC S9(9) BINARY VALUE 401.
        10 MQFB-CICS-NOT-AUTHORIZED    PIC S9(9) BINARY VALUE 402.
        10 MQFB-CICS-BRIDGE-FAILURE    PIC S9(9) BINARY VALUE 403.
        10 MQFB-CICS-CORREL-ID-ERROR   PIC S9(9) BINARY VALUE 404.
        10 MQFB-CICS-CCSID-ERROR       PIC S9(9) BINARY VALUE 405.
        10 MQFB-CICS-ENCODING-ERROR    PIC S9(9) BINARY VALUE 406.
        10 MQFB-CICS-CIH-ERROR         PIC S9(9) BINARY VALUE 407.
        10 MQFB-CICS-UOW-ERROR         PIC S9(9) BINARY VALUE 408.
        10 MQFB-CICS-COMMAREA-ERROR    PIC S9(9) BINARY VALUE 409.
        10 MQFB-CICS-APPL-NOT-STARTED  PIC S9(9) BINARY VALUE 410.
        10 MQFB-CICS-APPL-ABENDED      PIC S9(9) BINARY VALUE 411.
        10 MQFB-CICS-DLQ-ERROR         PIC S9(9) BINARY VALUE 412.
        10 MQFB-CICS-UOW-BACKED-OUT    PIC S9(9) BINARY VALUE 413.
        10 MQFB-SYSTEM-LAST            PIC S9(9) BINARY VALUE 65535.
        10 MQFB-APPL-FIRST             PIC S9(9) BINARY VALUE 65536.
        10 MQFB-APPL-LAST              PIC S9(9) BINARY VALUE 999999999.
 
      **   Encoding
        10 MQENC-NATIVE PIC S9(9) BINARY VALUE 17.
 
      **   Encoding Masks
        10 MQENC-INTEGER-MASK  PIC S9(9) BINARY VALUE 15.
        10 MQENC-DECIMAL-MASK  PIC S9(9) BINARY VALUE 240.
        10 MQENC-FLOAT-MASK    PIC S9(9) BINARY VALUE 3840.
        10 MQENC-RESERVED-MASK PIC S9(9) BINARY VALUE -4096.
 
      **   Encodings for Binary Integers
        10 MQENC-INTEGER-UNDEFINED PIC S9(9) BINARY VALUE 0.
        10 MQENC-INTEGER-NORMAL    PIC S9(9) BINARY VALUE 1.
        10 MQENC-INTEGER-REVERSED  PIC S9(9) BINARY VALUE 2.
 
      **   Encodings for Packed-Decimal Integers
        10 MQENC-DECIMAL-UNDEFINED PIC S9(9) BINARY VALUE 0.
        10 MQENC-DECIMAL-NORMAL    PIC S9(9) BINARY VALUE 16.
        10 MQENC-DECIMAL-REVERSED  PIC S9(9) BINARY VALUE 32.
 
      **   Encodings for Floating-Point Numbers
        10 MQENC-FLOAT-UNDEFINED     PIC S9(9) BINARY VALUE 0.
        10 MQENC-FLOAT-IEEE-NORMAL   PIC S9(9) BINARY VALUE 256.
        10 MQENC-FLOAT-IEEE-REVERSED PIC S9(9) BINARY VALUE 512.
        10 MQENC-FLOAT-S390          PIC S9(9) BINARY VALUE 768.
 
      **   Coded Character-Set Identifiers
        10 MQCCSI-DEFAULT  PIC S9(9) BINARY VALUE 0.
        10 MQCCSI-Q-MGR    PIC S9(9) BINARY VALUE 0.
        10 MQCCSI-EMBEDDED PIC S9(9) BINARY VALUE -1.
 
      **   Formats
        10 MQFMT-NONE               PIC X(8) VALUE SPACES.
        10 MQFMT-ADMIN              PIC X(8) VALUE 'MQADMIN '.
        10 MQFMT-CHANNEL-COMPLETED  PIC X(8) VALUE 'MQCHCOM '.
        10 MQFMT-CICS               PIC X(8) VALUE 'MQCICS  '.
        10 MQFMT-COMMAND-1          PIC X(8) VALUE 'MQCMD1  '.
        10 MQFMT-COMMAND-2          PIC X(8) VALUE 'MQCMD2  '.
        10 MQFMT-DEAD-LETTER-HEADER PIC X(8) VALUE 'MQDEAD  '.
        10 MQFMT-DIST-HEADER        PIC X(8) VALUE 'MQHDIST '.
        10 MQFMT-EVENT              PIC X(8) VALUE 'MQEVENT '.
        10 MQFMT-IMS                PIC X(8) VALUE 'MQIMS   '.
        10 MQFMT-IMS-VAR-STRING     PIC X(8) VALUE 'MQIMSVS '.
        10 MQFMT-MD-EXTENSION       PIC X(8) VALUE 'MQHMDE  '.
        10 MQFMT-PCF                PIC X(8) VALUE 'MQPCF   '.
        10 MQFMT-REF-MSG-HEADER     PIC X(8) VALUE 'MQHREF  '.
        10 MQFMT-RF-HEADER          PIC X(8) VALUE 'MQHRF   '.
        10 MQFMT-STRING             PIC X(8) VALUE 'MQSTR   '.
        10 MQFMT-TRIGGER            PIC X(8) VALUE 'MQTRIG  '.
        10 MQFMT-WORK-INFO-HEADER   PIC X(8) VALUE 'MQHWIH  '.
        10 MQFMT-XMIT-Q-HEADER      PIC X(8) VALUE 'MQXMIT  '.
 
      **   Priority
        10 MQPRI-PRIORITY-AS-Q-DEF PIC S9(9) BINARY VALUE -1.
 
      **   Persistence Values
        10 MQPER-NOT-PERSISTENT       PIC S9(9) BINARY VALUE 0.
        10 MQPER-PERSISTENT           PIC S9(9) BINARY VALUE 1.
        10 MQPER-PERSISTENCE-AS-Q-DEF PIC S9(9) BINARY VALUE 2.
 
      **   Message Identifier
        10 MQMI-NONE PIC X(24) VALUE LOW-VALUES.
 
      **   Correlation Identifier
        10 MQCI-NONE        PIC X(24) VALUE LOW-VALUES.
        10 MQCI-NEW-SESSION PIC X(24) VALUE
             X'414D51214E45575F53455353494F4E5F434F5252454C4944'.
 
      **   Accounting Token
        10 MQACT-NONE PIC X(32) VALUE LOW-VALUES.
 
      **   Accounting Token Type
        10 MQACTT-UNKNOWN             PIC X VALUE X'00'.
        10 MQACTT-CICS-LUOW-ID        PIC X VALUE X'01'.
        10 MQACTT-OS2-DEFAULT         PIC X VALUE X'04'.
        10 MQACTT-DOS-DEFAULT         PIC X VALUE X'05'.
        10 MQACTT-UNIX-NUMERIC-ID     PIC X VALUE X'06'.
        10 MQACTT-OS400-ACCOUNT-TOKEN PIC X VALUE X'08'.
        10 MQACTT-WINDOWS-DEFAULT     PIC X VALUE X'09'.
        10 MQACTT-NT-SECURITY-ID      PIC X VALUE X'0b'.
        10 MQACTT-USER                PIC X VALUE X'19'.
 
      **   Put Application Types
        10 MQAT-UNKNOWN     PIC S9(9) BINARY VALUE -1.
        10 MQAT-NO-CONTEXT  PIC S9(9) BINARY VALUE 0.
        10 MQAT-CICS        PIC S9(9) BINARY VALUE 1.
        10 MQAT-MVS         PIC S9(9) BINARY VALUE 2.
        10 MQAT-OS390       PIC S9(9) BINARY VALUE 2.
        10 MQAT-IMS         PIC S9(9) BINARY VALUE 3.
        10 MQAT-OS2         PIC S9(9) BINARY VALUE 4.
        10 MQAT-DOS         PIC S9(9) BINARY VALUE 5.
        10 MQAT-AIX         PIC S9(9) BINARY VALUE 6.
        10 MQAT-UNIX        PIC S9(9) BINARY VALUE 6.
        10 MQAT-QMGR        PIC S9(9) BINARY VALUE 7.
        10 MQAT-OS400       PIC S9(9) BINARY VALUE 8.
        10 MQAT-WINDOWS     PIC S9(9) BINARY VALUE 9.
        10 MQAT-CICS-VSE    PIC S9(9) BINARY VALUE 10.
        10 MQAT-WINDOWS-NT  PIC S9(9) BINARY VALUE 11.
        10 MQAT-VMS         PIC S9(9) BINARY VALUE 12.
        10 MQAT-GUARDIAN    PIC S9(9) BINARY VALUE 13.
        10 MQAT-NSK         PIC S9(9) BINARY VALUE 13.
        10 MQAT-VOS         PIC S9(9) BINARY VALUE 14.
        10 MQAT-IMS-BRIDGE  PIC S9(9) BINARY VALUE 19.
        10 MQAT-XCF         PIC S9(9) BINARY VALUE 20.
        10 MQAT-CICS-BRIDGE PIC S9(9) BINARY VALUE 21.
        10 MQAT-NOTES-AGENT PIC S9(9) BINARY VALUE 22.
        10 MQAT-BROKER      PIC S9(9) BINARY VALUE 26.
        10 MQAT-DEFAULT     PIC S9(9) BINARY VALUE 11.
        10 MQAT-USER-FIRST  PIC S9(9) BINARY VALUE 65536.
        10 MQAT-USER-LAST   PIC S9(9) BINARY VALUE 999999999.
 
      **   Group Identifier
        10 MQGI-NONE PIC X(24) VALUE LOW-VALUES.
 
      **   Message Flags
        10 MQMF-SEGMENTATION-INHIBITED PIC S9(9) BINARY VALUE 0.
        10 MQMF-SEGMENTATION-ALLOWED   PIC S9(9) BINARY VALUE 1.
        10 MQMF-MSG-IN-GROUP           PIC S9(9) BINARY VALUE 8.
        10 MQMF-LAST-MSG-IN-GROUP      PIC S9(9) BINARY VALUE 16.
        10 MQMF-SEGMENT                PIC S9(9) BINARY VALUE 2.
        10 MQMF-LAST-SEGMENT           PIC S9(9) BINARY VALUE 4.
        10 MQMF-NONE                   PIC S9(9) BINARY VALUE 0.
 
      **   Message Flags Masks
        10 MQMF-REJECT-UNSUP-MASK         PIC S9(9) BINARY VALUE 4095.
        10 MQMF-ACCEPT-UNSUP-MASK         PIC S9(9) BINARY VALUE
             -1048576.
        10 MQMF-ACCEPT-UNSUP-IF-XMIT-MASK PIC S9(9) BINARY VALUE
             1044480.
 
      **   Original Length
        10 MQOL-UNDEFINED PIC S9(9) BINARY VALUE -1.
 
 
      ******************************************************************
      **  Values Related to MQMDE Structure                           **
      ******************************************************************
 
      **   Structure Identifier
        10 MQMDE-STRUC-ID PIC X(4) VALUE 'MDE '.
 
      **   Structure Version Number
        10 MQMDE-VERSION-2       PIC S9(9) BINARY VALUE 2.
        10 MQMDE-CURRENT-VERSION PIC S9(9) BINARY VALUE 2.
 
      **   Structure Length
        10 MQMDE-LENGTH-2 PIC S9(9) BINARY VALUE 72.
 
      **   General Flags
        10 MQMDEF-NONE PIC S9(9) BINARY VALUE 0.
 
 
      ******************************************************************
      **  Values Related to MQOD Structure                            **
      ******************************************************************
 
      **   Structure Identifier
        10 MQOD-STRUC-ID PIC X(4) VALUE 'OD  '.
 
      **   Structure Version Number
        10 MQOD-VERSION-1       PIC S9(9) BINARY VALUE 1.
        10 MQOD-VERSION-2       PIC S9(9) BINARY VALUE 2.
        10 MQOD-VERSION-3       PIC S9(9) BINARY VALUE 3.
        10 MQOD-CURRENT-VERSION PIC S9(9) BINARY VALUE 3.
 
      **   Structure Length
        10 MQOD-CURRENT-LENGTH PIC S9(9) BINARY VALUE 336.
 
      **   Object Types
        10 MQOT-Q          PIC S9(9) BINARY VALUE 1.
        10 MQOT-NAMELIST   PIC S9(9) BINARY VALUE 2.
        10 MQOT-PROCESS    PIC S9(9) BINARY VALUE 3.
        10 MQOT-Q-MGR      PIC S9(9) BINARY VALUE 5.
        10 MQOT-CHANNEL    PIC S9(9) BINARY VALUE 6.
        10 MQOT-RESERVED-1 PIC S9(9) BINARY VALUE 7.
 
      **   Extended Object Types
        10 MQOT-ALL               PIC S9(9) BINARY VALUE 1001.
        10 MQOT-ALIAS-Q           PIC S9(9) BINARY VALUE 1002.
        10 MQOT-MODEL-Q           PIC S9(9) BINARY VALUE 1003.
        10 MQOT-LOCAL-Q           PIC S9(9) BINARY VALUE 1004.
        10 MQOT-REMOTE-Q          PIC S9(9) BINARY VALUE 1005.
        10 MQOT-SENDER-CHANNEL    PIC S9(9) BINARY VALUE 1007.
        10 MQOT-SERVER-CHANNEL    PIC S9(9) BINARY VALUE 1008.
        10 MQOT-REQUESTER-CHANNEL PIC S9(9) BINARY VALUE 1009.
        10 MQOT-RECEIVER-CHANNEL  PIC S9(9) BINARY VALUE 1010.
        10 MQOT-CURRENT-CHANNEL   PIC S9(9) BINARY VALUE 1011.
        10 MQOT-SAVED-CHANNEL     PIC S9(9) BINARY VALUE 1012.
        10 MQOT-SVRCONN-CHANNEL   PIC S9(9) BINARY VALUE 1013.
        10 MQOT-CLNTCONN-CHANNEL  PIC S9(9) BINARY VALUE 1014.
 
      **   Security Identifier
        10 MQSID-NONE PIC X(40) VALUE LOW-VALUES.
 
      **   Security Identifier Type
        10 MQSIDT-NONE           PIC X VALUE X'00'.
        10 MQSIDT-NT-SECURITY-ID PIC X VALUE X'01'.
 
 
      ******************************************************************
      **  Values Related to MQPMO Structure                           **
      ******************************************************************
 
      **   Structure Identifier
        10 MQPMO-STRUC-ID PIC X(4) VALUE 'PMO '.
 
      **   Structure Version Number
        10 MQPMO-VERSION-1       PIC S9(9) BINARY VALUE 1.
        10 MQPMO-VERSION-2       PIC S9(9) BINARY VALUE 2.
        10 MQPMO-CURRENT-VERSION PIC S9(9) BINARY VALUE 2.
 
      **   Structure Length
        10 MQPMO-CURRENT-LENGTH PIC S9(9) BINARY VALUE 152.
 
      **   Put-Message Options
        10 MQPMO-SYNCPOINT                PIC S9(9) BINARY VALUE 2.
        10 MQPMO-NO-SYNCPOINT             PIC S9(9) BINARY VALUE 4.
        10 MQPMO-NEW-MSG-ID               PIC S9(9) BINARY VALUE 64.
        10 MQPMO-NEW-CORREL-ID            PIC S9(9) BINARY VALUE 128.
        10 MQPMO-LOGICAL-ORDER            PIC S9(9) BINARY VALUE 32768.
        10 MQPMO-NO-CONTEXT               PIC S9(9) BINARY VALUE 16384.
        10 MQPMO-DEFAULT-CONTEXT          PIC S9(9) BINARY VALUE 32.
        10 MQPMO-PASS-IDENTITY-CONTEXT    PIC S9(9) BINARY VALUE 256.
        10 MQPMO-PASS-ALL-CONTEXT         PIC S9(9) BINARY VALUE 512.
        10 MQPMO-SET-IDENTITY-CONTEXT     PIC S9(9) BINARY VALUE 1024.
        10 MQPMO-SET-ALL-CONTEXT          PIC S9(9) BINARY VALUE 2048.
        10 MQPMO-ALTERNATE-USER-AUTHORITY PIC S9(9) BINARY VALUE 4096.
        10 MQPMO-FAIL-IF-QUIESCING        PIC S9(9) BINARY VALUE 8192.
        10 MQPMO-NONE                     PIC S9(9) BINARY VALUE 0.
 
      **   Put Message Record Fields
        10 MQPMRF-MSG-ID           PIC S9(9) BINARY VALUE 1.
        10 MQPMRF-CORREL-ID        PIC S9(9) BINARY VALUE 2.
        10 MQPMRF-GROUP-ID         PIC S9(9) BINARY VALUE 4.
        10 MQPMRF-FEEDBACK         PIC S9(9) BINARY VALUE 8.
        10 MQPMRF-ACCOUNTING-TOKEN PIC S9(9) BINARY VALUE 16.
        10 MQPMRF-NONE             PIC S9(9) BINARY VALUE 0.
 
 
      ******************************************************************
      **  Values Related to MQRFH Structure                           **
      ******************************************************************
 
      **   Structure Identifier
        10 MQRFH-STRUC-ID PIC X(4) VALUE 'RFH '.
 
      **   Structure Version Number
        10 MQRFH-VERSION-1 PIC S9(9) BINARY VALUE 1.
 
      **   Structure Length
        10 MQRFH-STRUC-LENGTH-FIXED PIC S9(9) BINARY VALUE 32.
 
      **   Flags
        10 MQRFH-NONE PIC S9(9) BINARY VALUE 0.
 
      **   Names for Name/Value String
        10 MQNVS-APPL-TYPE PIC X(12) VALUE 'OPT_APP_GRP '.
        10 MQNVS-MSG-TYPE  PIC X(13) VALUE 'OPT_MSG_TYPE '.
 
 
      ******************************************************************
      **  Values Related to MQRMH Structure                           **
      ******************************************************************
 
      **   Structure Identifier
        10 MQRMH-STRUC-ID PIC X(4) VALUE 'RMH '.
 
      **   Structure Version Number
        10 MQRMH-VERSION-1       PIC S9(9) BINARY VALUE 1.
        10 MQRMH-CURRENT-VERSION PIC S9(9) BINARY VALUE 1.
 
      **   Flags
        10 MQRMHF-LAST     PIC S9(9) BINARY VALUE 1.
        10 MQRMHF-NOT-LAST PIC S9(9) BINARY VALUE 0.
 
      **   Object Instance Identifier
        10 MQOII-NONE PIC X(24) VALUE LOW-VALUES.
 
 
      ******************************************************************
      **  Values Related to MQTM Structure                            **
      ******************************************************************
 
      **   Structure Identifier
        10 MQTM-STRUC-ID PIC X(4) VALUE 'TM  '.
 
      **   Structure Version Number
        10 MQTM-VERSION-1       PIC S9(9) BINARY VALUE 1.
        10 MQTM-CURRENT-VERSION PIC S9(9) BINARY VALUE 1.
 
 
      ******************************************************************
      **  Values Related to MQTMC2 Structure                          **
      ******************************************************************
 
      **   Structure Identifier
        10 MQTMC-STRUC-ID PIC X(4) VALUE 'TMC '.
 
      **   Structure Version Number
        10 MQTMC-VERSION-1       PIC X(4) VALUE '   1'.
        10 MQTMC-VERSION-2       PIC X(4) VALUE '   2'.
        10 MQTMC-CURRENT-VERSION PIC X(4) VALUE '   2'.
 
 
      ******************************************************************
      **  Values Related to MQWIH Structure                           **
      ******************************************************************
 
      **   Structure Identifier
        10 MQWIH-STRUC-ID PIC X(4) VALUE 'WIH '.
 
      **   Structure Version Number
        10 MQWIH-VERSION-1       PIC S9(9) BINARY VALUE 1.
        10 MQWIH-CURRENT-VERSION PIC S9(9) BINARY VALUE 1.
 
      **   Structure Length
        10 MQWIH-LENGTH-1       PIC S9(9) BINARY VALUE 120.
        10 MQWIH-CURRENT-LENGTH PIC S9(9) BINARY VALUE 120.
 
      **   Flags
        10 MQWIH-NONE PIC S9(9) BINARY VALUE 0.
 
 
      ******************************************************************
      **  Values Related to MQXQH Structure                           **
      ******************************************************************
 
      **   Structure Identifier
        10 MQXQH-STRUC-ID PIC X(4) VALUE 'XQH '.
 
      **   Structure Version Number
        10 MQXQH-VERSION-1       PIC S9(9) BINARY VALUE 1.
        10 MQXQH-CURRENT-VERSION PIC S9(9) BINARY VALUE 1.
 
 
      ******************************************************************
      **  Values Related to MQCLOSE Call                              **
      ******************************************************************
 
      **   Object Handle
        10 MQHO-UNUSABLE-HOBJ PIC S9(9) BINARY VALUE -1.
        10 MQHO-NONE          PIC S9(9) BINARY VALUE 0.
 
      **   Close Options
        10 MQCO-NONE         PIC S9(9) BINARY VALUE 0.
        10 MQCO-DELETE       PIC S9(9) BINARY VALUE 1.
        10 MQCO-DELETE-PURGE PIC S9(9) BINARY VALUE 2.
 
 
      ******************************************************************
      **  Values Related to MQINQ Call                                **
      ******************************************************************
 
      **   Character-Attribute Selectors
        10 MQCA-ALTERATION-DATE       PIC S9(9) BINARY VALUE 2027.
        10 MQCA-ALTERATION-TIME       PIC S9(9) BINARY VALUE 2028.
        10 MQCA-APPL-ID               PIC S9(9) BINARY VALUE 2001.
        10 MQCA-BACKOUT-REQ-Q-NAME    PIC S9(9) BINARY VALUE 2019.
        10 MQCA-BASE-Q-NAME           PIC S9(9) BINARY VALUE 2002.
        10 MQCA-CHANNEL-AUTO-DEF-EXIT PIC S9(9) BINARY VALUE 2026.
        10 MQCA-CLUSTER-DATE          PIC S9(9) BINARY VALUE 2037.
        10 MQCA-CLUSTER-NAME          PIC S9(9) BINARY VALUE 2029.
        10 MQCA-CLUSTER-NAMELIST      PIC S9(9) BINARY VALUE 2030.
        10 MQCA-CLUSTER-Q-MGR-NAME    PIC S9(9) BINARY VALUE 2031.
        10 MQCA-CLUSTER-TIME          PIC S9(9) BINARY VALUE 2038.
        10 MQCA-CLUSTER-WORKLOAD-DATA PIC S9(9) BINARY VALUE 2034.
        10 MQCA-CLUSTER-WORKLOAD-EXIT PIC S9(9) BINARY VALUE 2033.
        10 MQCA-COMMAND-INPUT-Q-NAME  PIC S9(9) BINARY VALUE 2003.
        10 MQCA-CREATION-DATE         PIC S9(9) BINARY VALUE 2004.
        10 MQCA-CREATION-TIME         PIC S9(9) BINARY VALUE 2005.
        10 MQCA-DEAD-LETTER-Q-NAME    PIC S9(9) BINARY VALUE 2006.
        10 MQCA-DEF-XMIT-Q-NAME       PIC S9(9) BINARY VALUE 2025.
        10 MQCA-ENV-DATA              PIC S9(9) BINARY VALUE 2007.
        10 MQCA-FIRST                 PIC S9(9) BINARY VALUE 2001.
        10 MQCA-INITIATION-Q-NAME     PIC S9(9) BINARY VALUE 2008.
        10 MQCA-LAST                  PIC S9(9) BINARY VALUE 4000.
        10 MQCA-LAST-USED             PIC S9(9) BINARY VALUE 2038.
        10 MQCA-NAMELIST-DESC         PIC S9(9) BINARY VALUE 2009.
        10 MQCA-NAMELIST-NAME         PIC S9(9) BINARY VALUE 2010.
        10 MQCA-NAMES                 PIC S9(9) BINARY VALUE 2020.
        10 MQCA-PROCESS-DESC          PIC S9(9) BINARY VALUE 2011.
        10 MQCA-PROCESS-NAME          PIC S9(9) BINARY VALUE 2012.
        10 MQCA-Q-DESC                PIC S9(9) BINARY VALUE 2013.
        10 MQCA-Q-MGR-DESC            PIC S9(9) BINARY VALUE 2014.
        10 MQCA-Q-MGR-IDENTIFIER      PIC S9(9) BINARY VALUE 2032.
        10 MQCA-Q-MGR-NAME            PIC S9(9) BINARY VALUE 2015.
        10 MQCA-Q-NAME                PIC S9(9) BINARY VALUE 2016.
        10 MQCA-REMOTE-Q-MGR-NAME     PIC S9(9) BINARY VALUE 2017.
        10 MQCA-REMOTE-Q-NAME         PIC S9(9) BINARY VALUE 2018.
        10 MQCA-REPOSITORY-NAME       PIC S9(9) BINARY VALUE 2035.
        10 MQCA-REPOSITORY-NAMELIST   PIC S9(9) BINARY VALUE 2036.
        10 MQCA-STORAGE-CLASS         PIC S9(9) BINARY VALUE 2022.
        10 MQCA-TRIGGER-DATA          PIC S9(9) BINARY VALUE 2023.
        10 MQCA-USER-DATA             PIC S9(9) BINARY VALUE 2021.
        10 MQCA-USER-LIST             PIC S9(9) BINARY VALUE 4000.
        10 MQCA-XMIT-Q-NAME           PIC S9(9) BINARY VALUE 2024.
 
      **   Integer-Attribute Selectors
        10 MQIA-APPL-TYPE                PIC S9(9) BINARY VALUE 1.
        10 MQIA-ARCHIVE                  PIC S9(9) BINARY VALUE 60.
        10 MQIA-AUTHORITY-EVENT          PIC S9(9) BINARY VALUE 47.
        10 MQIA-BACKOUT-THRESHOLD        PIC S9(9) BINARY VALUE 22.
        10 MQIA-CHANNEL-AUTO-DEF         PIC S9(9) BINARY VALUE 55.
        10 MQIA-CHANNEL-AUTO-DEF-EVENT   PIC S9(9) BINARY VALUE 56.
        10 MQIA-CLUSTER-Q-TYPE           PIC S9(9) BINARY VALUE 59.
        10 MQIA-CLUSTER-WORKLOAD-LENGTH  PIC S9(9) BINARY VALUE 58.
        10 MQIA-CODED-CHAR-SET-ID        PIC S9(9) BINARY VALUE 2.
        10 MQIA-COMMAND-LEVEL            PIC S9(9) BINARY VALUE 31.
        10 MQIA-CURRENT-Q-DEPTH          PIC S9(9) BINARY VALUE 3.
        10 MQIA-DEF-BIND                 PIC S9(9) BINARY VALUE 61.
        10 MQIA-DEF-INPUT-OPEN-OPTION    PIC S9(9) BINARY VALUE 4.
        10 MQIA-DEF-PERSISTENCE          PIC S9(9) BINARY VALUE 5.
        10 MQIA-DEF-PRIORITY             PIC S9(9) BINARY VALUE 6.
        10 MQIA-DEFINITION-TYPE          PIC S9(9) BINARY VALUE 7.
        10 MQIA-DIST-LISTS               PIC S9(9) BINARY VALUE 34.
        10 MQIA-FIRST                    PIC S9(9) BINARY VALUE 1.
        10 MQIA-HARDEN-GET-BACKOUT       PIC S9(9) BINARY VALUE 8.
        10 MQIA-HIGH-Q-DEPTH             PIC S9(9) BINARY VALUE 36.
        10 MQIA-INDEX-TYPE               PIC S9(9) BINARY VALUE 57.
        10 MQIA-INHIBIT-EVENT            PIC S9(9) BINARY VALUE 48.
        10 MQIA-INHIBIT-GET              PIC S9(9) BINARY VALUE 9.
        10 MQIA-INHIBIT-PUT              PIC S9(9) BINARY VALUE 10.
        10 MQIA-LAST                     PIC S9(9) BINARY VALUE 2000.
        10 MQIA-LAST-USED                PIC S9(9) BINARY VALUE 61.
        10 MQIA-LOCAL-EVENT              PIC S9(9) BINARY VALUE 49.
        10 MQIA-MAX-HANDLES              PIC S9(9) BINARY VALUE 11.
        10 MQIA-MAX-MSG-LENGTH           PIC S9(9) BINARY VALUE 13.
        10 MQIA-MAX-PRIORITY             PIC S9(9) BINARY VALUE 14.
        10 MQIA-MAX-Q-DEPTH              PIC S9(9) BINARY VALUE 15.
        10 MQIA-MAX-UNCOMMITTED-MSGS     PIC S9(9) BINARY VALUE 33.
        10 MQIA-MSG-DELIVERY-SEQUENCE    PIC S9(9) BINARY VALUE 16.
        10 MQIA-MSG-DEQ-COUNT            PIC S9(9) BINARY VALUE 38.
        10 MQIA-MSG-ENQ-COUNT            PIC S9(9) BINARY VALUE 37.
        10 MQIA-NAME-COUNT               PIC S9(9) BINARY VALUE 19.
        10 MQIA-OPEN-INPUT-COUNT         PIC S9(9) BINARY VALUE 17.
        10 MQIA-OPEN-OUTPUT-COUNT        PIC S9(9) BINARY VALUE 18.
        10 MQIA-PERFORMANCE-EVENT        PIC S9(9) BINARY VALUE 53.
        10 MQIA-PLATFORM                 PIC S9(9) BINARY VALUE 32.
        10 MQIA-Q-DEPTH-HIGH-EVENT       PIC S9(9) BINARY VALUE 43.
        10 MQIA-Q-DEPTH-HIGH-LIMIT       PIC S9(9) BINARY VALUE 40.
        10 MQIA-Q-DEPTH-LOW-EVENT        PIC S9(9) BINARY VALUE 44.
        10 MQIA-Q-DEPTH-LOW-LIMIT        PIC S9(9) BINARY VALUE 41.
        10 MQIA-Q-DEPTH-MAX-EVENT        PIC S9(9) BINARY VALUE 42.
        10 MQIA-Q-SERVICE-INTERVAL       PIC S9(9) BINARY VALUE 54.
        10 MQIA-Q-SERVICE-INTERVAL-EVENT PIC S9(9) BINARY VALUE 46.
        10 MQIA-Q-TYPE                   PIC S9(9) BINARY VALUE 20.
        10 MQIA-REMOTE-EVENT             PIC S9(9) BINARY VALUE 50.
        10 MQIA-RETENTION-INTERVAL       PIC S9(9) BINARY VALUE 21.
        10 MQIA-SCOPE                    PIC S9(9) BINARY VALUE 45.
        10 MQIA-SHAREABILITY             PIC S9(9) BINARY VALUE 23.
        10 MQIA-START-STOP-EVENT         PIC S9(9) BINARY VALUE 52.
        10 MQIA-SYNCPOINT                PIC S9(9) BINARY VALUE 30.
        10 MQIA-TIME-SINCE-RESET         PIC S9(9) BINARY VALUE 35.
        10 MQIA-TRIGGER-CONTROL          PIC S9(9) BINARY VALUE 24.
        10 MQIA-TRIGGER-DEPTH            PIC S9(9) BINARY VALUE 29.
        10 MQIA-TRIGGER-INTERVAL         PIC S9(9) BINARY VALUE 25.
        10 MQIA-TRIGGER-MSG-PRIORITY     PIC S9(9) BINARY VALUE 26.
        10 MQIA-TRIGGER-TYPE             PIC S9(9) BINARY VALUE 28.
        10 MQIA-USAGE                    PIC S9(9) BINARY VALUE 12.
        10 MQIA-USER-LIST                PIC S9(9) BINARY VALUE 2000.
 
      **   Integer Attribute Value Denoting "Not Applicable"
        10 MQIAV-NOT-APPLICABLE PIC S9(9) BINARY VALUE -1.
        10 MQIAV-UNDEFINED      PIC S9(9) BINARY VALUE -2.
 
 
      ******************************************************************
      **  Values Related to MQOPEN Call                               **
      ******************************************************************
 
      **   Open Options
        10 MQOO-INPUT-AS-Q-DEF           PIC S9(9) BINARY VALUE 1.
        10 MQOO-INPUT-SHARED             PIC S9(9) BINARY VALUE 2.
        10 MQOO-INPUT-EXCLUSIVE          PIC S9(9) BINARY VALUE 4.
        10 MQOO-BROWSE                   PIC S9(9) BINARY VALUE 8.
        10 MQOO-OUTPUT                   PIC S9(9) BINARY VALUE 16.
        10 MQOO-INQUIRE                  PIC S9(9) BINARY VALUE 32.
        10 MQOO-SET                      PIC S9(9) BINARY VALUE 64.
        10 MQOO-BIND-ON-OPEN             PIC S9(9) BINARY VALUE 16384.
        10 MQOO-BIND-NOT-FIXED           PIC S9(9) BINARY VALUE 32768.
        10 MQOO-BIND-AS-Q-DEF            PIC S9(9) BINARY VALUE 0.
        10 MQOO-SAVE-ALL-CONTEXT         PIC S9(9) BINARY VALUE 128.
        10 MQOO-PASS-IDENTITY-CONTEXT    PIC S9(9) BINARY VALUE 256.
        10 MQOO-PASS-ALL-CONTEXT         PIC S9(9) BINARY VALUE 512.
        10 MQOO-SET-IDENTITY-CONTEXT     PIC S9(9) BINARY VALUE 1024.
        10 MQOO-SET-ALL-CONTEXT          PIC S9(9) BINARY VALUE 2048.
        10 MQOO-ALTERNATE-USER-AUTHORITY PIC S9(9) BINARY VALUE 4096.
        10 MQOO-FAIL-IF-QUIESCING        PIC S9(9) BINARY VALUE 8192.
 
 
      ******************************************************************
      **  Values Related to All Calls                                 **
      ******************************************************************
 
      **   Connection Handle
        10 MQHC-DEF-HCONN      PIC S9(9) BINARY VALUE 0.
        10 MQHC-UNUSABLE-HCONN PIC S9(9) BINARY VALUE -1.
 
      **   String Lengths
        10 MQ-ABEND-CODE-LENGTH         PIC S9(9) BINARY VALUE 4.
        10 MQ-ACCOUNTING-TOKEN-LENGTH   PIC S9(9) BINARY VALUE 32.
        10 MQ-APPL-IDENTITY-DATA-LENGTH PIC S9(9) BINARY VALUE 32.
        10 MQ-APPL-NAME-LENGTH          PIC S9(9) BINARY VALUE 28.
        10 MQ-APPL-ORIGIN-DATA-LENGTH   PIC S9(9) BINARY VALUE 4.
        10 MQ-ATTENTION-ID-LENGTH       PIC S9(9) BINARY VALUE 4.
        10 MQ-AUTHENTICATOR-LENGTH      PIC S9(9) BINARY VALUE 8.
        10 MQ-BRIDGE-NAME-LENGTH        PIC S9(9) BINARY VALUE 24.
        10 MQ-CANCEL-CODE-LENGTH        PIC S9(9) BINARY VALUE 4.
        10 MQ-CHANNEL-DATE-LENGTH       PIC S9(9) BINARY VALUE 12.
        10 MQ-CHANNEL-DESC-LENGTH       PIC S9(9) BINARY VALUE 64.
        10 MQ-CHANNEL-NAME-LENGTH       PIC S9(9) BINARY VALUE 20.
        10 MQ-CHANNEL-TIME-LENGTH       PIC S9(9) BINARY VALUE 8.
        10 MQ-CLUSTER-NAME-LENGTH       PIC S9(9) BINARY VALUE 48.
        10 MQ-CONN-NAME-LENGTH          PIC S9(9) BINARY VALUE 264.
        10 MQ-CORREL-ID-LENGTH          PIC S9(9) BINARY VALUE 24.
        10 MQ-CREATION-DATE-LENGTH      PIC S9(9) BINARY VALUE 12.
        10 MQ-CREATION-TIME-LENGTH      PIC S9(9) BINARY VALUE 8.
        10 MQ-DATE-LENGTH               PIC S9(9) BINARY VALUE 12.
        10 MQ-EXIT-DATA-LENGTH          PIC S9(9) BINARY VALUE 32.
        10 MQ-EXIT-NAME-LENGTH          PIC S9(9) BINARY VALUE 128.
        10 MQ-EXIT-USER-AREA-LENGTH     PIC S9(9) BINARY VALUE 16.
        10 MQ-FACILITY-LENGTH           PIC S9(9) BINARY VALUE 8.
        10 MQ-FACILITY-LIKE-LENGTH      PIC S9(9) BINARY VALUE 4.
        10 MQ-FORMAT-LENGTH             PIC S9(9) BINARY VALUE 8.
        10 MQ-FUNCTION-LENGTH           PIC S9(9) BINARY VALUE 4.
        10 MQ-GROUP-ID-LENGTH           PIC S9(9) BINARY VALUE 24.
        10 MQ-LTERM-OVERRIDE-LENGTH     PIC S9(9) BINARY VALUE 8.
        10 MQ-LUWID-LENGTH              PIC S9(9) BINARY VALUE 16.
        10 MQ-MAX-EXIT-NAME-LENGTH      PIC S9(9) BINARY VALUE 128.
        10 MQ-MAX-MCA-USER-ID-LENGTH    PIC S9(9) BINARY VALUE 64.
        10 MQ-MCA-JOB-NAME-LENGTH       PIC S9(9) BINARY VALUE 28.
        10 MQ-MCA-NAME-LENGTH           PIC S9(9) BINARY VALUE 20.
        10 MQ-MCA-USER-ID-LENGTH        PIC S9(9) BINARY VALUE 64.
        10 MQ-MFS-MAP-NAME-LENGTH       PIC S9(9) BINARY VALUE 8.
        10 MQ-MODE-NAME-LENGTH          PIC S9(9) BINARY VALUE 8.
        10 MQ-MSG-HEADER-LENGTH         PIC S9(9) BINARY VALUE 4000.
        10 MQ-MSG-ID-LENGTH             PIC S9(9) BINARY VALUE 24.
        10 MQ-MSG-TOKEN-LENGTH          PIC S9(9) BINARY VALUE 16.
        10 MQ-NAMELIST-DESC-LENGTH      PIC S9(9) BINARY VALUE 64.
        10 MQ-NAMELIST-NAME-LENGTH      PIC S9(9) BINARY VALUE 48.
        10 MQ-OBJECT-INSTANCE-ID-LENGTH PIC S9(9) BINARY VALUE 24.
        10 MQ-OBJECT-NAME-LENGTH        PIC S9(9) BINARY VALUE 48.
        10 MQ-PASSWORD-LENGTH           PIC S9(9) BINARY VALUE 12.
        10 MQ-PROCESS-APPL-ID-LENGTH    PIC S9(9) BINARY VALUE 256.
        10 MQ-PROCESS-DESC-LENGTH       PIC S9(9) BINARY VALUE 64.
        10 MQ-PROCESS-ENV-DATA-LENGTH   PIC S9(9) BINARY VALUE 128.
        10 MQ-PROCESS-NAME-LENGTH       PIC S9(9) BINARY VALUE 48.
        10 MQ-PROCESS-USER-DATA-LENGTH  PIC S9(9) BINARY VALUE 128.
        10 MQ-PUT-APPL-NAME-LENGTH      PIC S9(9) BINARY VALUE 28.
        10 MQ-PUT-DATE-LENGTH           PIC S9(9) BINARY VALUE 8.
        10 MQ-PUT-TIME-LENGTH           PIC S9(9) BINARY VALUE 8.
        10 MQ-Q-DESC-LENGTH             PIC S9(9) BINARY VALUE 64.
        10 MQ-Q-MGR-DESC-LENGTH         PIC S9(9) BINARY VALUE 64.
        10 MQ-Q-MGR-IDENTIFIER-LENGTH   PIC S9(9) BINARY VALUE 48.
        10 MQ-Q-MGR-NAME-LENGTH         PIC S9(9) BINARY VALUE 48.
        10 MQ-Q-NAME-LENGTH             PIC S9(9) BINARY VALUE 48.
        10 MQ-REMOTE-SYS-ID-LENGTH      PIC S9(9) BINARY VALUE 4.
        10 MQ-SECURITY-ID-LENGTH        PIC S9(9) BINARY VALUE 40.
        10 MQ-SERVICE-NAME-LENGTH       PIC S9(9) BINARY VALUE 32.
        10 MQ-SERVICE-STEP-LENGTH       PIC S9(9) BINARY VALUE 8.
        10 MQ-SHORT-CONN-NAME-LENGTH    PIC S9(9) BINARY VALUE 20.
        10 MQ-START-CODE-LENGTH         PIC S9(9) BINARY VALUE 4.
        10 MQ-STORAGE-CLASS-LENGTH      PIC S9(9) BINARY VALUE 8.
        10 MQ-TIME-LENGTH               PIC S9(9) BINARY VALUE 8.
        10 MQ-TOTAL-EXIT-DATA-LENGTH    PIC S9(9) BINARY VALUE 999.
        10 MQ-TOTAL-EXIT-NAME-LENGTH    PIC S9(9) BINARY VALUE 999.
        10 MQ-TP-NAME-LENGTH            PIC S9(9) BINARY VALUE 64.
        10 MQ-TRAN-INSTANCE-ID-LENGTH   PIC S9(9) BINARY VALUE 16.
        10 MQ-TRANSACTION-ID-LENGTH     PIC S9(9) BINARY VALUE 4.
        10 MQ-TRIGGER-DATA-LENGTH       PIC S9(9) BINARY VALUE 64.
        10 MQ-USER-ID-LENGTH            PIC S9(9) BINARY VALUE 12.
 
      **   Completion Codes
        10 MQCC-OK      PIC S9(9) BINARY VALUE 0.
        10 MQCC-WARNING PIC S9(9) BINARY VALUE 1.
        10 MQCC-FAILED  PIC S9(9) BINARY VALUE 2.
        10 MQCC-UNKNOWN PIC S9(9) BINARY VALUE -1.
 
      **   Reason Codes
        10 MQRC-NONE                      PIC S9(9) BINARY VALUE 0.
        10 MQRC-APPL-FIRST                PIC S9(9) BINARY VALUE 900.
        10 MQRC-APPL-LAST                 PIC S9(9) BINARY VALUE 999.
        10 MQRC-ALIAS-BASE-Q-TYPE-ERROR   PIC S9(9) BINARY VALUE 2001.
        10 MQRC-ALREADY-CONNECTED         PIC S9(9) BINARY VALUE 2002.
        10 MQRC-BACKED-OUT                PIC S9(9) BINARY VALUE 2003.
        10 MQRC-BUFFER-ERROR              PIC S9(9) BINARY VALUE 2004.
        10 MQRC-BUFFER-LENGTH-ERROR       PIC S9(9) BINARY VALUE 2005.
        10 MQRC-CHAR-ATTR-LENGTH-ERROR    PIC S9(9) BINARY VALUE 2006.
        10 MQRC-CHAR-ATTRS-ERROR          PIC S9(9) BINARY VALUE 2007.
        10 MQRC-CHAR-ATTRS-TOO-SHORT      PIC S9(9) BINARY VALUE 2008.
        10 MQRC-CONNECTION-BROKEN         PIC S9(9) BINARY VALUE 2009.
        10 MQRC-DATA-LENGTH-ERROR         PIC S9(9) BINARY VALUE 2010.
        10 MQRC-DYNAMIC-Q-NAME-ERROR      PIC S9(9) BINARY VALUE 2011.
        10 MQRC-ENVIRONMENT-ERROR         PIC S9(9) BINARY VALUE 2012.
        10 MQRC-EXPIRY-ERROR              PIC S9(9) BINARY VALUE 2013.
        10 MQRC-FEEDBACK-ERROR            PIC S9(9) BINARY VALUE 2014.
        10 MQRC-GET-INHIBITED             PIC S9(9) BINARY VALUE 2016.
        10 MQRC-HANDLE-NOT-AVAILABLE      PIC S9(9) BINARY VALUE 2017.
        10 MQRC-HCONN-ERROR               PIC S9(9) BINARY VALUE 2018.
        10 MQRC-HOBJ-ERROR                PIC S9(9) BINARY VALUE 2019.
        10 MQRC-INHIBIT-VALUE-ERROR       PIC S9(9) BINARY VALUE 2020.
        10 MQRC-INT-ATTR-COUNT-ERROR      PIC S9(9) BINARY VALUE 2021.
        10 MQRC-INT-ATTR-COUNT-TOO-SMALL  PIC S9(9) BINARY VALUE 2022.
        10 MQRC-INT-ATTRS-ARRAY-ERROR     PIC S9(9) BINARY VALUE 2023.
        10 MQRC-SYNCPOINT-LIMIT-REACHED   PIC S9(9) BINARY VALUE 2024.
        10 MQRC-MAX-CONNS-LIMIT-REACHED   PIC S9(9) BINARY VALUE 2025.
        10 MQRC-MD-ERROR                  PIC S9(9) BINARY VALUE 2026.
        10 MQRC-MISSING-REPLY-TO-Q        PIC S9(9) BINARY VALUE 2027.
        10 MQRC-MSG-TYPE-ERROR            PIC S9(9) BINARY VALUE 2029.
        10 MQRC-MSG-TOO-BIG-FOR-Q         PIC S9(9) BINARY VALUE 2030.
        10 MQRC-MSG-TOO-BIG-FOR-Q-MGR     PIC S9(9) BINARY VALUE 2031.
        10 MQRC-NO-MSG-AVAILABLE          PIC S9(9) BINARY VALUE 2033.
        10 MQRC-NO-MSG-UNDER-CURSOR       PIC S9(9) BINARY VALUE 2034.
        10 MQRC-NOT-AUTHORIZED            PIC S9(9) BINARY VALUE 2035.
        10 MQRC-NOT-OPEN-FOR-BROWSE       PIC S9(9) BINARY VALUE 2036.
        10 MQRC-NOT-OPEN-FOR-INPUT        PIC S9(9) BINARY VALUE 2037.
        10 MQRC-NOT-OPEN-FOR-INQUIRE      PIC S9(9) BINARY VALUE 2038.
        10 MQRC-NOT-OPEN-FOR-OUTPUT       PIC S9(9) BINARY VALUE 2039.
        10 MQRC-NOT-OPEN-FOR-SET          PIC S9(9) BINARY VALUE 2040.
        10 MQRC-OBJECT-CHANGED            PIC S9(9) BINARY VALUE 2041.
        10 MQRC-OBJECT-IN-USE             PIC S9(9) BINARY VALUE 2042.
        10 MQRC-OBJECT-TYPE-ERROR         PIC S9(9) BINARY VALUE 2043.
        10 MQRC-OD-ERROR                  PIC S9(9) BINARY VALUE 2044.
        10 MQRC-OPTION-NOT-VALID-FOR-TYPE PIC S9(9) BINARY VALUE 2045.
        10 MQRC-OPTIONS-ERROR             PIC S9(9) BINARY VALUE 2046.
        10 MQRC-PERSISTENCE-ERROR         PIC S9(9) BINARY VALUE 2047.
        10 MQRC-PERSISTENT-NOT-ALLOWED    PIC S9(9) BINARY VALUE 2048.
        10 MQRC-PRIORITY-EXCEEDS-MAXIMUM  PIC S9(9) BINARY VALUE 2049.
        10 MQRC-PRIORITY-ERROR            PIC S9(9) BINARY VALUE 2050.
        10 MQRC-PUT-INHIBITED             PIC S9(9) BINARY VALUE 2051.
        10 MQRC-Q-DELETED                 PIC S9(9) BINARY VALUE 2052.
        10 MQRC-Q-FULL                    PIC S9(9) BINARY VALUE 2053.
        10 MQRC-Q-NOT-EMPTY               PIC S9(9) BINARY VALUE 2055.
        10 MQRC-Q-SPACE-NOT-AVAILABLE     PIC S9(9) BINARY VALUE 2056.
        10 MQRC-Q-TYPE-ERROR              PIC S9(9) BINARY VALUE 2057.
        10 MQRC-Q-MGR-NAME-ERROR          PIC S9(9) BINARY VALUE 2058.
        10 MQRC-Q-MGR-NOT-AVAILABLE       PIC S9(9) BINARY VALUE 2059.
        10 MQRC-REPORT-OPTIONS-ERROR      PIC S9(9) BINARY VALUE 2061.
        10 MQRC-SECOND-MARK-NOT-ALLOWED   PIC S9(9) BINARY VALUE 2062.
        10 MQRC-SECURITY-ERROR            PIC S9(9) BINARY VALUE 2063.
        10 MQRC-SELECTOR-COUNT-ERROR      PIC S9(9) BINARY VALUE 2065.
        10 MQRC-SELECTOR-LIMIT-EXCEEDED   PIC S9(9) BINARY VALUE 2066.
        10 MQRC-SELECTOR-ERROR            PIC S9(9) BINARY VALUE 2067.
        10 MQRC-SELECTOR-NOT-FOR-TYPE     PIC S9(9) BINARY VALUE 2068.
        10 MQRC-SIGNAL-OUTSTANDING        PIC S9(9) BINARY VALUE 2069.
        10 MQRC-SIGNAL-REQUEST-ACCEPTED   PIC S9(9) BINARY VALUE 2070.
        10 MQRC-STORAGE-NOT-AVAILABLE     PIC S9(9) BINARY VALUE 2071.
        10 MQRC-SYNCPOINT-NOT-AVAILABLE   PIC S9(9) BINARY VALUE 2072.
        10 MQRC-TRIGGER-CONTROL-ERROR     PIC S9(9) BINARY VALUE 2075.
        10 MQRC-TRIGGER-DEPTH-ERROR       PIC S9(9) BINARY VALUE 2076.
        10 MQRC-TRIGGER-MSG-PRIORITY-ERR  PIC S9(9) BINARY VALUE 2077.
        10 MQRC-TRIGGER-TYPE-ERROR        PIC S9(9) BINARY VALUE 2078.
        10 MQRC-TRUNCATED-MSG-ACCEPTED    PIC S9(9) BINARY VALUE 2079.
        10 MQRC-TRUNCATED-MSG-FAILED      PIC S9(9) BINARY VALUE 2080.
        10 MQRC-UNKNOWN-ALIAS-BASE-Q      PIC S9(9) BINARY VALUE 2082.
        10 MQRC-UNKNOWN-OBJECT-NAME       PIC S9(9) BINARY VALUE 2085.
        10 MQRC-UNKNOWN-OBJECT-Q-MGR      PIC S9(9) BINARY VALUE 2086.
        10 MQRC-UNKNOWN-REMOTE-Q-MGR      PIC S9(9) BINARY VALUE 2087.
        10 MQRC-WAIT-INTERVAL-ERROR       PIC S9(9) BINARY VALUE 2090.
        10 MQRC-XMIT-Q-TYPE-ERROR         PIC S9(9) BINARY VALUE 2091.
        10 MQRC-XMIT-Q-USAGE-ERROR        PIC S9(9) BINARY VALUE 2092.
        10 MQRC-NOT-OPEN-FOR-PASS-ALL     PIC S9(9) BINARY VALUE 2093.
        10 MQRC-NOT-OPEN-FOR-PASS-IDENT   PIC S9(9) BINARY VALUE 2094.
        10 MQRC-NOT-OPEN-FOR-SET-ALL      PIC S9(9) BINARY VALUE 2095.
        10 MQRC-NOT-OPEN-FOR-SET-IDENT    PIC S9(9) BINARY VALUE 2096.
        10 MQRC-CONTEXT-HANDLE-ERROR      PIC S9(9) BINARY VALUE 2097.
        10 MQRC-CONTEXT-NOT-AVAILABLE     PIC S9(9) BINARY VALUE 2098.
        10 MQRC-SIGNAL1-ERROR             PIC S9(9) BINARY VALUE 2099.
        10 MQRC-OBJECT-ALREADY-EXISTS     PIC S9(9) BINARY VALUE 2100.
        10 MQRC-OBJECT-DAMAGED            PIC S9(9) BINARY VALUE 2101.
        10 MQRC-RESOURCE-PROBLEM          PIC S9(9) BINARY VALUE 2102.
        10 MQRC-ANOTHER-Q-MGR-CONNECTED   PIC S9(9) BINARY VALUE 2103.
        10 MQRC-UNKNOWN-REPORT-OPTION     PIC S9(9) BINARY VALUE 2104.
        10 MQRC-STORAGE-CLASS-ERROR       PIC S9(9) BINARY VALUE 2105.
        10 MQRC-COD-NOT-VALID-FOR-XCF-Q   PIC S9(9) BINARY VALUE 2106.
        10 MQRC-SUPPRESSED-BY-EXIT        PIC S9(9) BINARY VALUE 2109.
        10 MQRC-FORMAT-ERROR              PIC S9(9) BINARY VALUE 2110.
        10 MQRC-SOURCE-CCSID-ERROR        PIC S9(9) BINARY VALUE 2111.
        10 MQRC-SOURCE-INTEGER-ENC-ERROR  PIC S9(9) BINARY VALUE 2112.
        10 MQRC-SOURCE-DECIMAL-ENC-ERROR  PIC S9(9) BINARY VALUE 2113.
        10 MQRC-SOURCE-FLOAT-ENC-ERROR    PIC S9(9) BINARY VALUE 2114.
        10 MQRC-TARGET-CCSID-ERROR        PIC S9(9) BINARY VALUE 2115.
        10 MQRC-TARGET-INTEGER-ENC-ERROR  PIC S9(9) BINARY VALUE 2116.
        10 MQRC-TARGET-DECIMAL-ENC-ERROR  PIC S9(9) BINARY VALUE 2117.
        10 MQRC-TARGET-FLOAT-ENC-ERROR    PIC S9(9) BINARY VALUE 2118.
        10 MQRC-NOT-CONVERTED             PIC S9(9) BINARY VALUE 2119.
        10 MQRC-CONVERTED-MSG-TOO-BIG     PIC S9(9) BINARY VALUE 2120.
        10 MQRC-TRUNCATED                 PIC S9(9) BINARY VALUE 2120.
        10 MQRC-NO-EXTERNAL-PARTICIPANTS  PIC S9(9) BINARY VALUE 2121.
        10 MQRC-PARTICIPANT-NOT-AVAILABLE PIC S9(9) BINARY VALUE 2122.
        10 MQRC-OUTCOME-MIXED             PIC S9(9) BINARY VALUE 2123.
        10 MQRC-OUTCOME-PENDING           PIC S9(9) BINARY VALUE 2124.
        10 MQRC-BRIDGE-STARTED            PIC S9(9) BINARY VALUE 2125.
        10 MQRC-BRIDGE-STOPPED            PIC S9(9) BINARY VALUE 2126.
        10 MQRC-ADAPTER-STORAGE-SHORTAGE  PIC S9(9) BINARY VALUE 2127.
        10 MQRC-UOW-IN-PROGRESS           PIC S9(9) BINARY VALUE 2128.
        10 MQRC-ADAPTER-CONN-LOAD-ERROR   PIC S9(9) BINARY VALUE 2129.
        10 MQRC-ADAPTER-SERV-LOAD-ERROR   PIC S9(9) BINARY VALUE 2130.
        10 MQRC-ADAPTER-DEFS-ERROR        PIC S9(9) BINARY VALUE 2131.
        10 MQRC-ADAPTER-DEFS-LOAD-ERROR   PIC S9(9) BINARY VALUE 2132.
        10 MQRC-ADAPTER-CONV-LOAD-ERROR   PIC S9(9) BINARY VALUE 2133.
        10 MQRC-BO-ERROR                  PIC S9(9) BINARY VALUE 2134.
        10 MQRC-DH-ERROR                  PIC S9(9) BINARY VALUE 2135.
        10 MQRC-MULTIPLE-REASONS          PIC S9(9) BINARY VALUE 2136.
        10 MQRC-OPEN-FAILED               PIC S9(9) BINARY VALUE 2137.
        10 MQRC-ADAPTER-DISC-LOAD-ERROR   PIC S9(9) BINARY VALUE 2138.
        10 MQRC-CNO-ERROR                 PIC S9(9) BINARY VALUE 2139.
        10 MQRC-CICS-WAIT-FAILED          PIC S9(9) BINARY VALUE 2140.
        10 MQRC-DLH-ERROR                 PIC S9(9) BINARY VALUE 2141.
        10 MQRC-HEADER-ERROR              PIC S9(9) BINARY VALUE 2142.
        10 MQRC-SOURCE-LENGTH-ERROR       PIC S9(9) BINARY VALUE 2143.
        10 MQRC-TARGET-LENGTH-ERROR       PIC S9(9) BINARY VALUE 2144.
        10 MQRC-SOURCE-BUFFER-ERROR       PIC S9(9) BINARY VALUE 2145.
        10 MQRC-TARGET-BUFFER-ERROR       PIC S9(9) BINARY VALUE 2146.
        10 MQRC-IIH-ERROR                 PIC S9(9) BINARY VALUE 2148.
        10 MQRC-PCF-ERROR                 PIC S9(9) BINARY VALUE 2149.
        10 MQRC-DBCS-ERROR                PIC S9(9) BINARY VALUE 2150.
        10 MQRC-OBJECT-NAME-ERROR         PIC S9(9) BINARY VALUE 2152.
        10 MQRC-OBJECT-Q-MGR-NAME-ERROR   PIC S9(9) BINARY VALUE 2153.
        10 MQRC-RECS-PRESENT-ERROR        PIC S9(9) BINARY VALUE 2154.
        10 MQRC-OBJECT-RECORDS-ERROR      PIC S9(9) BINARY VALUE 2155.
        10 MQRC-RESPONSE-RECORDS-ERROR    PIC S9(9) BINARY VALUE 2156.
        10 MQRC-ASID-MISMATCH             PIC S9(9) BINARY VALUE 2157.
        10 MQRC-PMO-RECORD-FLAGS-ERROR    PIC S9(9) BINARY VALUE 2158.
        10 MQRC-PUT-MSG-RECORDS-ERROR     PIC S9(9) BINARY VALUE 2159.
        10 MQRC-CONN-ID-IN-USE            PIC S9(9) BINARY VALUE 2160.
        10 MQRC-Q-MGR-QUIESCING           PIC S9(9) BINARY VALUE 2161.
        10 MQRC-Q-MGR-STOPPING            PIC S9(9) BINARY VALUE 2162.
        10 MQRC-DUPLICATE-RECOV-COORD     PIC S9(9) BINARY VALUE 2163.
        10 MQRC-PMO-ERROR                 PIC S9(9) BINARY VALUE 2173.
        10 MQRC-API-EXIT-NOT-FOUND        PIC S9(9) BINARY VALUE 2182.
        10 MQRC-API-EXIT-LOAD-ERROR       PIC S9(9) BINARY VALUE 2183.
        10 MQRC-REMOTE-Q-NAME-ERROR       PIC S9(9) BINARY VALUE 2184.
        10 MQRC-INCONSISTENT-PERSISTENCE  PIC S9(9) BINARY VALUE 2185.
        10 MQRC-GMO-ERROR                 PIC S9(9) BINARY VALUE 2186.
        10 MQRC-CICS-BRIDGE-RESTRICTION   PIC S9(9) BINARY VALUE 2187.
        10 MQRC-STOPPED-BY-CLUSTER-EXIT   PIC S9(9) BINARY VALUE 2188.
        10 MQRC-CLUSTER-RESOLUTION-ERROR  PIC S9(9) BINARY VALUE 2189.
        10 MQRC-CONVERTED-STRING-TOO-BIG  PIC S9(9) BINARY VALUE 2190.
        10 MQRC-TMC-ERROR                 PIC S9(9) BINARY VALUE 2191.
        10 MQRC-PAGESET-FULL              PIC S9(9) BINARY VALUE 2192.
        10 MQRC-PAGESET-ERROR             PIC S9(9) BINARY VALUE 2193.
        10 MQRC-NAME-NOT-VALID-FOR-TYPE   PIC S9(9) BINARY VALUE 2194.
        10 MQRC-UNEXPECTED-ERROR          PIC S9(9) BINARY VALUE 2195.
        10 MQRC-UNKNOWN-XMIT-Q            PIC S9(9) BINARY VALUE 2196.
        10 MQRC-UNKNOWN-DEF-XMIT-Q        PIC S9(9) BINARY VALUE 2197.
        10 MQRC-DEF-XMIT-Q-TYPE-ERROR     PIC S9(9) BINARY VALUE 2198.
        10 MQRC-DEF-XMIT-Q-USAGE-ERROR    PIC S9(9) BINARY VALUE 2199.
        10 MQRC-NAME-IN-USE               PIC S9(9) BINARY VALUE 2201.
        10 MQRC-CONNECTION-QUIESCING      PIC S9(9) BINARY VALUE 2202.
        10 MQRC-CONNECTION-STOPPING       PIC S9(9) BINARY VALUE 2203.
        10 MQRC-ADAPTER-NOT-AVAILABLE     PIC S9(9) BINARY VALUE 2204.
        10 MQRC-MSG-ID-ERROR              PIC S9(9) BINARY VALUE 2206.
        10 MQRC-CORREL-ID-ERROR           PIC S9(9) BINARY VALUE 2207.
        10 MQRC-FILE-SYSTEM-ERROR         PIC S9(9) BINARY VALUE 2208.
        10 MQRC-NO-MSG-LOCKED             PIC S9(9) BINARY VALUE 2209.
        10 MQRC-FILE-NOT-AUDITED          PIC S9(9) BINARY VALUE 2216.
        10 MQRC-CONNECTION-NOT-AUTHORIZED PIC S9(9) BINARY VALUE 2217.
        10 MQRC-MSG-TOO-BIG-FOR-CHANNEL   PIC S9(9) BINARY VALUE 2218.
        10 MQRC-CALL-IN-PROGRESS          PIC S9(9) BINARY VALUE 2219.
        10 MQRC-RMH-ERROR                 PIC S9(9) BINARY VALUE 2220.
        10 MQRC-Q-MGR-ACTIVE              PIC S9(9) BINARY VALUE 2222.
        10 MQRC-Q-MGR-NOT-ACTIVE          PIC S9(9) BINARY VALUE 2223.
        10 MQRC-Q-DEPTH-HIGH              PIC S9(9) BINARY VALUE 2224.
        10 MQRC-Q-DEPTH-LOW               PIC S9(9) BINARY VALUE 2225.
        10 MQRC-Q-SERVICE-INTERVAL-HIGH   PIC S9(9) BINARY VALUE 2226.
        10 MQRC-Q-SERVICE-INTERVAL-OK     PIC S9(9) BINARY VALUE 2227.
        10 MQRC-UNIT-OF-WORK-NOT-STARTED  PIC S9(9) BINARY VALUE 2232.
        10 MQRC-CHANNEL-AUTO-DEF-OK       PIC S9(9) BINARY VALUE 2233.
        10 MQRC-CHANNEL-AUTO-DEF-ERROR    PIC S9(9) BINARY VALUE 2234.
        10 MQRC-CFH-ERROR                 PIC S9(9) BINARY VALUE 2235.
        10 MQRC-CFIL-ERROR                PIC S9(9) BINARY VALUE 2236.
        10 MQRC-CFIN-ERROR                PIC S9(9) BINARY VALUE 2237.
        10 MQRC-CFSL-ERROR                PIC S9(9) BINARY VALUE 2238.
        10 MQRC-CFST-ERROR                PIC S9(9) BINARY VALUE 2239.
        10 MQRC-INCOMPLETE-GROUP          PIC S9(9) BINARY VALUE 2241.
        10 MQRC-INCOMPLETE-MSG            PIC S9(9) BINARY VALUE 2242.
        10 MQRC-INCONSISTENT-CCSIDS       PIC S9(9) BINARY VALUE 2243.
        10 MQRC-INCONSISTENT-ENCODINGS    PIC S9(9) BINARY VALUE 2244.
        10 MQRC-INCONSISTENT-UOW          PIC S9(9) BINARY VALUE 2245.
        10 MQRC-INVALID-MSG-UNDER-CURSOR  PIC S9(9) BINARY VALUE 2246.
        10 MQRC-MATCH-OPTIONS-ERROR       PIC S9(9) BINARY VALUE 2247.
        10 MQRC-MDE-ERROR                 PIC S9(9) BINARY VALUE 2248.
        10 MQRC-MSG-FLAGS-ERROR           PIC S9(9) BINARY VALUE 2249.
        10 MQRC-MSG-SEQ-NUMBER-ERROR      PIC S9(9) BINARY VALUE 2250.
        10 MQRC-OFFSET-ERROR              PIC S9(9) BINARY VALUE 2251.
        10 MQRC-ORIGINAL-LENGTH-ERROR     PIC S9(9) BINARY VALUE 2252.
        10 MQRC-SEGMENT-LENGTH-ZERO       PIC S9(9) BINARY VALUE 2253.
        10 MQRC-UOW-NOT-AVAILABLE         PIC S9(9) BINARY VALUE 2255.
        10 MQRC-WRONG-GMO-VERSION         PIC S9(9) BINARY VALUE 2256.
        10 MQRC-WRONG-MD-VERSION          PIC S9(9) BINARY VALUE 2257.
        10 MQRC-GROUP-ID-ERROR            PIC S9(9) BINARY VALUE 2258.
        10 MQRC-INCONSISTENT-BROWSE       PIC S9(9) BINARY VALUE 2259.
        10 MQRC-XQH-ERROR                 PIC S9(9) BINARY VALUE 2260.
        10 MQRC-SRC-ENV-ERROR             PIC S9(9) BINARY VALUE 2261.
        10 MQRC-SRC-NAME-ERROR            PIC S9(9) BINARY VALUE 2262.
        10 MQRC-DEST-ENV-ERROR            PIC S9(9) BINARY VALUE 2263.
        10 MQRC-DEST-NAME-ERROR           PIC S9(9) BINARY VALUE 2264.
        10 MQRC-TM-ERROR                  PIC S9(9) BINARY VALUE 2265.
        10 MQRC-CLUSTER-EXIT-ERROR        PIC S9(9) BINARY VALUE 2266.
        10 MQRC-CLUSTER-EXIT-LOAD-ERROR   PIC S9(9) BINARY VALUE 2267.
        10 MQRC-CLUSTER-PUT-INHIBITED     PIC S9(9) BINARY VALUE 2268.
        10 MQRC-CLUSTER-ERROR             PIC S9(9) BINARY VALUE 2269.
        10 MQRC-CLUSTER-RESOURCE-ERROR    PIC S9(9) BINARY VALUE 2269.
        10 MQRC-NO-DESTINATIONS-AVAILABLE PIC S9(9) BINARY VALUE 2270.
        10 MQRC-CONNECTION-ERROR          PIC S9(9) BINARY VALUE 2273.
        10 MQRC-OPTION-ENVIRONMENT-ERROR  PIC S9(9) BINARY VALUE 2274.
        10 MQRC-CD-ERROR                  PIC S9(9) BINARY VALUE 2277.
        10 MQRC-CLIENT-CONN-ERROR         PIC S9(9) BINARY VALUE 2278.
        10 MQRC-CHANNEL-STOPPED-BY-USER   PIC S9(9) BINARY VALUE 2279.
        10 MQRC-HCONFIG-ERROR             PIC S9(9) BINARY VALUE 2280.
        10 MQRC-FUNCTION-ERROR            PIC S9(9) BINARY VALUE 2281.
        10 MQRC-CHANNEL-STARTED           PIC S9(9) BINARY VALUE 2282.
        10 MQRC-CHANNEL-STOPPED           PIC S9(9) BINARY VALUE 2283.
        10 MQRC-CHANNEL-CONV-ERROR        PIC S9(9) BINARY VALUE 2284.
        10 MQRC-SERVICE-NOT-AVAILABLE     PIC S9(9) BINARY VALUE 2285.
        10 MQRC-INITIALIZATION-FAILED     PIC S9(9) BINARY VALUE 2286.
        10 MQRC-TERMINATION-FAILED        PIC S9(9) BINARY VALUE 2287.
        10 MQRC-UNKNOWN-Q-NAME            PIC S9(9) BINARY VALUE 2288.
        10 MQRC-SERVICE-ERROR             PIC S9(9) BINARY VALUE 2289.
        10 MQRC-Q-ALREADY-EXISTS          PIC S9(9) BINARY VALUE 2290.
        10 MQRC-USER-ID-NOT-AVAILABLE     PIC S9(9) BINARY VALUE 2291.
        10 MQRC-UNKNOWN-ENTITY            PIC S9(9) BINARY VALUE 2292.
        10 MQRC-UNKNOWN-AUTH-ENTITY       PIC S9(9) BINARY VALUE 2293.
        10 MQRC-UNKNOWN-REF-OBJECT        PIC S9(9) BINARY VALUE 2294.
        10 MQRC-CHANNEL-ACTIVATED         PIC S9(9) BINARY VALUE 2295.
        10 MQRC-CHANNEL-NOT-ACTIVATED     PIC S9(9) BINARY VALUE 2296.
        10 MQRC-UOW-CANCELED              PIC S9(9) BINARY VALUE 2297.
        10 MQRC-SELECTOR-TYPE-ERROR       PIC S9(9) BINARY VALUE 2299.
        10 MQRC-COMMAND-TYPE-ERROR        PIC S9(9) BINARY VALUE 2300.
        10 MQRC-MULTIPLE-INSTANCE-ERROR   PIC S9(9) BINARY VALUE 2301.
        10 MQRC-SYSTEM-ITEM-NOT-ALTERABLE PIC S9(9) BINARY VALUE 2302.
        10 MQRC-BAG-CONVERSION-ERROR      PIC S9(9) BINARY VALUE 2303.
        10 MQRC-SELECTOR-OUT-OF-RANGE     PIC S9(9) BINARY VALUE 2304.
        10 MQRC-SELECTOR-NOT-UNIQUE       PIC S9(9) BINARY VALUE 2305.
        10 MQRC-INDEX-NOT-PRESENT         PIC S9(9) BINARY VALUE 2306.
        10 MQRC-STRING-ERROR              PIC S9(9) BINARY VALUE 2307.
        10 MQRC-ENCODING-NOT-SUPPORTED    PIC S9(9) BINARY VALUE 2308.
        10 MQRC-SELECTOR-NOT-PRESENT      PIC S9(9) BINARY VALUE 2309.
        10 MQRC-OUT-SELECTOR-ERROR        PIC S9(9) BINARY VALUE 2310.
        10 MQRC-STRING-TRUNCATED          PIC S9(9) BINARY VALUE 2311.
        10 MQRC-SELECTOR-WRONG-TYPE       PIC S9(9) BINARY VALUE 2312.
        10 MQRC-INCONSISTENT-ITEM-TYPE    PIC S9(9) BINARY VALUE 2313.
        10 MQRC-INDEX-ERROR               PIC S9(9) BINARY VALUE 2314.
        10 MQRC-SYSTEM-BAG-NOT-ALTERABLE  PIC S9(9) BINARY VALUE 2315.
        10 MQRC-ITEM-COUNT-ERROR          PIC S9(9) BINARY VALUE 2316.
        10 MQRC-FORMAT-NOT-SUPPORTED      PIC S9(9) BINARY VALUE 2317.
        10 MQRC-SELECTOR-NOT-SUPPORTED    PIC S9(9) BINARY VALUE 2318.
        10 MQRC-ITEM-VALUE-ERROR          PIC S9(9) BINARY VALUE 2319.
        10 MQRC-HBAG-ERROR                PIC S9(9) BINARY VALUE 2320.
        10 MQRC-PARAMETER-MISSING         PIC S9(9) BINARY VALUE 2321.
        10 MQRC-CMD-SERVER-NOT-AVAILABLE  PIC S9(9) BINARY VALUE 2322.
        10 MQRC-STRING-LENGTH-ERROR       PIC S9(9) BINARY VALUE 2323.
        10 MQRC-INQUIRY-COMMAND-ERROR     PIC S9(9) BINARY VALUE 2324.
        10 MQRC-NESTED-BAG-NOT-SUPPORTED  PIC S9(9) BINARY VALUE 2325.
        10 MQRC-BAG-WRONG-TYPE            PIC S9(9) BINARY VALUE 2326.
        10 MQRC-ITEM-TYPE-ERROR           PIC S9(9) BINARY VALUE 2327.
        10 MQRC-SYSTEM-BAG-NOT-DELETABLE  PIC S9(9) BINARY VALUE 2328.
        10 MQRC-SYSTEM-ITEM-NOT-DELETABLE PIC S9(9) BINARY VALUE 2329.
        10 MQRC-CODED-CHAR-SET-ID-ERROR   PIC S9(9) BINARY VALUE 2330.
        10 MQRC-MSG-TOKEN-ERROR           PIC S9(9) BINARY VALUE 2331.
        10 MQRC-MISSING-WIH               PIC S9(9) BINARY VALUE 2332.
        10 MQRC-WIH-ERROR                 PIC S9(9) BINARY VALUE 2333.
        10 MQRC-RFH-ERROR                 PIC S9(9) BINARY VALUE 2334.
        10 MQRC-RFH-STRING-ERROR          PIC S9(9) BINARY VALUE 2335.
        10 MQRC-RFH-COMMAND-ERROR         PIC S9(9) BINARY VALUE 2336.
        10 MQRC-RFH-PARM-ERROR            PIC S9(9) BINARY VALUE 2337.
        10 MQRC-RFH-DUPLICATE-PARM        PIC S9(9) BINARY VALUE 2338.
        10 MQRC-RFH-PARM-MISSING          PIC S9(9) BINARY VALUE 2339.
 
 
      ******************************************************************
      **  Values Related to Queue Attributes                          **
      ******************************************************************
 
      **   Queue Types
        10 MQQT-LOCAL   PIC S9(9) BINARY VALUE 1.
        10 MQQT-MODEL   PIC S9(9) BINARY VALUE 2.
        10 MQQT-ALIAS   PIC S9(9) BINARY VALUE 3.
        10 MQQT-REMOTE  PIC S9(9) BINARY VALUE 6.
        10 MQQT-CLUSTER PIC S9(9) BINARY VALUE 7.
 
      **   Cluster Queue Types
        10 MQCQT-LOCAL-Q     PIC S9(9) BINARY VALUE 1.
        10 MQCQT-ALIAS-Q     PIC S9(9) BINARY VALUE 2.
        10 MQCQT-REMOTE-Q    PIC S9(9) BINARY VALUE 3.
        10 MQCQT-Q-MGR-ALIAS PIC S9(9) BINARY VALUE 4.
 
      **   Extended Queue Types
        10 MQQT-ALL PIC S9(9) BINARY VALUE 1001.
 
      **   Queue Definition Types
        10 MQQDT-PREDEFINED        PIC S9(9) BINARY VALUE 1.
        10 MQQDT-PERMANENT-DYNAMIC PIC S9(9) BINARY VALUE 2.
        10 MQQDT-TEMPORARY-DYNAMIC PIC S9(9) BINARY VALUE 3.
 
      **   Inhibit Get
        10 MQQA-GET-INHIBITED PIC S9(9) BINARY VALUE 1.
        10 MQQA-GET-ALLOWED   PIC S9(9) BINARY VALUE 0.
 
      **   Inhibit Put
        10 MQQA-PUT-INHIBITED PIC S9(9) BINARY VALUE 1.
        10 MQQA-PUT-ALLOWED   PIC S9(9) BINARY VALUE 0.
 
      **   Queue Shareability
        10 MQQA-SHAREABLE     PIC S9(9) BINARY VALUE 1.
        10 MQQA-NOT-SHAREABLE PIC S9(9) BINARY VALUE 0.
 
      **   Back-Out Hardening
        10 MQQA-BACKOUT-HARDENED     PIC S9(9) BINARY VALUE 1.
        10 MQQA-BACKOUT-NOT-HARDENED PIC S9(9) BINARY VALUE 0.
 
      **   Message Delivery Sequence
        10 MQMDS-PRIORITY PIC S9(9) BINARY VALUE 0.
        10 MQMDS-FIFO     PIC S9(9) BINARY VALUE 1.
 
      **   Trigger Control
        10 MQTC-OFF PIC S9(9) BINARY VALUE 0.
        10 MQTC-ON  PIC S9(9) BINARY VALUE 1.
 
      **   Trigger Types
        10 MQTT-NONE  PIC S9(9) BINARY VALUE 0.
        10 MQTT-FIRST PIC S9(9) BINARY VALUE 1.
        10 MQTT-EVERY PIC S9(9) BINARY VALUE 2.
        10 MQTT-DEPTH PIC S9(9) BINARY VALUE 3.
 
      **   Queue Usage
        10 MQUS-NORMAL       PIC S9(9) BINARY VALUE 0.
        10 MQUS-TRANSMISSION PIC S9(9) BINARY VALUE 1.
 
      **   Distribution Lists
        10 MQDL-SUPPORTED     PIC S9(9) BINARY VALUE 1.
        10 MQDL-NOT-SUPPORTED PIC S9(9) BINARY VALUE 0.
 
      **   Index Type
        10 MQIT-NONE      PIC S9(9) BINARY VALUE 0.
        10 MQIT-MSG-ID    PIC S9(9) BINARY VALUE 1.
        10 MQIT-CORREL-ID PIC S9(9) BINARY VALUE 2.
        10 MQIT-MSG-TOKEN PIC S9(9) BINARY VALUE 4.
 
      **   Archiving Mode
        10 MQAR-NONE PIC S9(9) BINARY VALUE 0.
        10 MQAR-ALL  PIC S9(9) BINARY VALUE 1.
 
      **   Default Bind
        10 MQBND-BIND-ON-OPEN   PIC S9(9) BINARY VALUE 0.
        10 MQBND-BIND-NOT-FIXED PIC S9(9) BINARY VALUE 1.
 
 
      ******************************************************************
      **  Values Related to Namelist Attributes                       **
      ******************************************************************
 
      **   Name Count
        10 MQNC-MAX-NAMELIST-NAME-COUNT PIC S9(9) BINARY VALUE 256.
 
 
      ******************************************************************
      **  Values Related to Process-Definition Attributes             **
      ******************************************************************
 
      **   Application Types
      **   See values for "Put Application Types" under MQMD
 
 
      ******************************************************************
      **  Values Related to Queue-Manager Attributes                  **
      ******************************************************************
 
      **   Command Level
        10 MQCMDL-LEVEL-1   PIC S9(9) BINARY VALUE 100.
        10 MQCMDL-LEVEL-101 PIC S9(9) BINARY VALUE 101.
        10 MQCMDL-LEVEL-110 PIC S9(9) BINARY VALUE 110.
        10 MQCMDL-LEVEL-114 PIC S9(9) BINARY VALUE 114.
        10 MQCMDL-LEVEL-120 PIC S9(9) BINARY VALUE 120.
        10 MQCMDL-LEVEL-200 PIC S9(9) BINARY VALUE 200.
        10 MQCMDL-LEVEL-201 PIC S9(9) BINARY VALUE 201.
        10 MQCMDL-LEVEL-210 PIC S9(9) BINARY VALUE 210.
        10 MQCMDL-LEVEL-220 PIC S9(9) BINARY VALUE 220.
        10 MQCMDL-LEVEL-221 PIC S9(9) BINARY VALUE 221.
        10 MQCMDL-LEVEL-320 PIC S9(9) BINARY VALUE 320.
        10 MQCMDL-LEVEL-420 PIC S9(9) BINARY VALUE 420.
        10 MQCMDL-LEVEL-500 PIC S9(9) BINARY VALUE 500.
        10 MQCMDL-LEVEL-510 PIC S9(9) BINARY VALUE 510.
 
      **   Platform
        10 MQPL-MVS        PIC S9(9) BINARY VALUE 1.
        10 MQPL-OS390      PIC S9(9) BINARY VALUE 1.
        10 MQPL-OS2        PIC S9(9) BINARY VALUE 2.
        10 MQPL-AIX        PIC S9(9) BINARY VALUE 3.
        10 MQPL-UNIX       PIC S9(9) BINARY VALUE 3.
        10 MQPL-OS400      PIC S9(9) BINARY VALUE 4.
        10 MQPL-WINDOWS    PIC S9(9) BINARY VALUE 5.
        10 MQPL-WINDOWS-NT PIC S9(9) BINARY VALUE 11.
        10 MQPL-VMS        PIC S9(9) BINARY VALUE 12.
        10 MQPL-NSK        PIC S9(9) BINARY VALUE 13.
 
      **   Syncpoint Availability
        10 MQSP-AVAILABLE     PIC S9(9) BINARY VALUE 1.
        10 MQSP-NOT-AVAILABLE PIC S9(9) BINARY VALUE 0.
 
      **   Channel Auto Definition
        10 MQCHAD-DISABLED PIC S9(9) BINARY VALUE 0.
        10 MQCHAD-ENABLED  PIC S9(9) BINARY VALUE 1.
 
      **   Distribution Lists
      **   See values for "Distribution Lists" under Queue Attributes
 
 
      ******************************************************************
      **  End of CMQV                                                 **
      ******************************************************************
