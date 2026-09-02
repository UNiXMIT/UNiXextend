      ******************************************************************
      **                                                              **
      **                  IBM MQSeries for Windows NT                 **
      **                                                              **
      **  COPYBOOK NAME:  CMQMDV                                      **
      **                                                              **
      **  DESCRIPTION:    Message Descriptor Structure                **
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
      **  FUNCTION:       This file declares the structure MQMD,      **
      **                  which is used by the main MQI.              **
      **                                                              **
      **  PROCESSOR:      COBOL                                       **
      **                                                              **
      ******************************************************************
 
      **   MQMD structure
        10 MQMD.
      **    Structure identifier
         15 MQMD-STRUCID          PIC X(4) VALUE 'MD  '.
      **    Structure version number
         15 MQMD-VERSION          PIC S9(9) BINARY VALUE 1.
      **    Options for report messages
         15 MQMD-REPORT           PIC S9(9) BINARY VALUE 0.
      **    Message type
         15 MQMD-MSGTYPE          PIC S9(9) BINARY VALUE 8.
      **    Message lifetime
         15 MQMD-EXPIRY           PIC S9(9) BINARY VALUE -1.
      **    Feedback or reason code
         15 MQMD-FEEDBACK         PIC S9(9) BINARY VALUE 0.
      **    Data encoding
         15 MQMD-ENCODING         PIC S9(9) BINARY VALUE 17.
      **    Coded character set identifier
         15 MQMD-CODEDCHARSETID   PIC S9(9) BINARY VALUE 0.
      **    Format name
         15 MQMD-FORMAT           PIC X(8) VALUE SPACES.
      **    Message priority
         15 MQMD-PRIORITY         PIC S9(9) BINARY VALUE -1.
      **    Message persistence
         15 MQMD-PERSISTENCE      PIC S9(9) BINARY VALUE 2.
      **    Message identifier
         15 MQMD-MSGID            PIC X(24) VALUE LOW-VALUES.
      **    Correlation identifier
         15 MQMD-CORRELID         PIC X(24) VALUE LOW-VALUES.
      **    Backout counter
         15 MQMD-BACKOUTCOUNT     PIC S9(9) BINARY VALUE 0.
      **    Name of reply queue
         15 MQMD-REPLYTOQ         PIC X(48) VALUE SPACES.
      **    Name of reply queue manager
         15 MQMD-REPLYTOQMGR      PIC X(48) VALUE SPACES.
      **    User identifier
         15 MQMD-USERIDENTIFIER   PIC X(12) VALUE SPACES.
      **    Accounting token
         15 MQMD-ACCOUNTINGTOKEN  PIC X(32) VALUE LOW-VALUES.
      **    Application data relating to identity
         15 MQMD-APPLIDENTITYDATA PIC X(32) VALUE SPACES.
      **    Type of application that put the message
         15 MQMD-PUTAPPLTYPE      PIC S9(9) BINARY VALUE 0.
      **    Name of application that put the message
         15 MQMD-PUTAPPLNAME      PIC X(28) VALUE SPACES.
      **    Date when message was put
         15 MQMD-PUTDATE          PIC X(8) VALUE SPACES.
      **    Time when message was put
         15 MQMD-PUTTIME          PIC X(8) VALUE SPACES.
      **    Application data relating to origin
         15 MQMD-APPLORIGINDATA   PIC X(4) VALUE SPACES.
      **    Group identifier
         15 MQMD-GROUPID          PIC X(24) VALUE LOW-VALUES.
      **    Sequence number of logical message within group
         15 MQMD-MSGSEQNUMBER     PIC S9(9) BINARY VALUE 1.
      **    Offset of data in physical message from start of logical
      **    message
         15 MQMD-OFFSET           PIC S9(9) BINARY VALUE 0.
      **    Message flags
         15 MQMD-MSGFLAGS         PIC S9(9) BINARY VALUE 0.
      **    Length of original message
         15 MQMD-ORIGINALLENGTH   PIC S9(9) BINARY VALUE -1.
 
      ******************************************************************
      **  End of CMQMDV                                               **
      ******************************************************************
