      ******************************************************************
      **                                                              **
      **                  IBM MQSeries for Windows NT                 **
      **                                                              **
      **  COPYBOOK NAME:  CMQGMOV                                     **
      **                                                              **
      **  DESCRIPTION:    Get Message Options Structure               **
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
      **  FUNCTION:       This file declares the structure MQGMO,     **
      **                  which is used by the main MQI.              **
      **                                                              **
      **  PROCESSOR:      COBOL                                       **
      **                                                              **
      ******************************************************************
 
      **   MQGMO structure
        10 MQGMO.
      **    Structure identifier
         15 MQGMO-STRUCID        PIC X(4) VALUE 'GMO '.
      **    Structure version number
         15 MQGMO-VERSION        PIC S9(9) BINARY VALUE 1.
      **    Options that control the action of MQGET
         15 MQGMO-OPTIONS        PIC S9(9) BINARY VALUE 0.
      **    Wait interval
         15 MQGMO-WAITINTERVAL   PIC S9(9) BINARY VALUE 0.
      **    Signal
         15 MQGMO-SIGNAL1        PIC S9(9) BINARY VALUE 0.
      **    Signal identifier
         15 MQGMO-SIGNAL2        PIC S9(9) BINARY VALUE 0.
      **    Resolved name of destination queue
         15 MQGMO-RESOLVEDQNAME  PIC X(48) VALUE SPACES.
      **    Options controlling selection criteria used for MQGET
         15 MQGMO-MATCHOPTIONS   PIC S9(9) BINARY VALUE 3.
      **    Flag indicating whether message retrieved is in a group
         15 MQGMO-GROUPSTATUS    PIC X VALUE ' '.
      **    Flag indicating whether message retrieved is a segment of a
      **    logical message
         15 MQGMO-SEGMENTSTATUS  PIC X VALUE ' '.
      **    Flag indicating whether further segmentation is allowed for
      **    the message retrieved
         15 MQGMO-SEGMENTATION   PIC X VALUE ' '.
      **    Reserved
         15 MQGMO-RESERVED1      PIC X VALUE SPACES.
      **    Message token
         15 MQGMO-MSGTOKEN       PIC X(16) VALUE LOW-VALUES.
      **    Length of message data returned (bytes)
         15 MQGMO-RETURNEDLENGTH PIC S9(9) BINARY VALUE -1.
 
      ******************************************************************
      **  End of CMQGMOV                                              **
      ******************************************************************
