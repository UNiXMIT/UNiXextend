      ******************************************************************
      **                                                              **
      **                  IBM MQSeries for Windows NT                 **
      **                                                              **
      **  COPYBOOK NAME:  CMQODV                                      **
      **                                                              **
      **  DESCRIPTION:    Object Descriptor Structure                 **
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
      **  FUNCTION:       This file declares the structure MQOD,      **
      **                  which is used by the main MQI.              **
      **                                                              **
      **  PROCESSOR:      COBOL                                       **
      **                                                              **
      ******************************************************************
 
      **   MQOD structure
        10 MQOD.
      **    Structure identifier
         15 MQOD-STRUCID             PIC X(4) VALUE 'OD  '.
      **    Structure version number
         15 MQOD-VERSION             PIC S9(9) BINARY VALUE 1.
      **    Object type
         15 MQOD-OBJECTTYPE          PIC S9(9) BINARY VALUE 1.
      **    Object name
         15 MQOD-OBJECTNAME          PIC X(48) VALUE SPACES.
      **    Object queue manager name
         15 MQOD-OBJECTQMGRNAME      PIC X(48) VALUE SPACES.
      **    Dynamic queue name
         15 MQOD-DYNAMICQNAME        PIC X(48) VALUE 'AMQ.*'.
      **    Alternate user identifier
         15 MQOD-ALTERNATEUSERID     PIC X(12) VALUE SPACES.
      **    Number of object records present
         15 MQOD-RECSPRESENT         PIC S9(9) BINARY VALUE 0.
      **    Number of local queues opened successfully
         15 MQOD-KNOWNDESTCOUNT      PIC S9(9) BINARY VALUE 0.
      **    Number of remote queues opened successfully
         15 MQOD-UNKNOWNDESTCOUNT    PIC S9(9) BINARY VALUE 0.
      **    Number of queues that failed to open
         15 MQOD-INVALIDDESTCOUNT    PIC S9(9) BINARY VALUE 0.
      **    Offset of first object record from start of MQOD
         15 MQOD-OBJECTRECOFFSET     PIC S9(9) BINARY VALUE 0.
      **    Offset of first response record from start of MQOD
         15 MQOD-RESPONSERECOFFSET   PIC S9(9) BINARY VALUE 0.
      **    Address of first object record
         15 MQOD-OBJECTRECPTR        POINTER VALUE NULL.
      **    Address of first response record
         15 MQOD-RESPONSERECPTR      POINTER VALUE NULL.
      **    Alternate security identifier
         15 MQOD-ALTERNATESECURITYID PIC X(40) VALUE LOW-VALUES.
      **    Resolved queue name
         15 MQOD-RESOLVEDQNAME       PIC X(48) VALUE SPACES.
      **    Resolved queue manager name
         15 MQOD-RESOLVEDQMGRNAME    PIC X(48) VALUE SPACES.
 
      ******************************************************************
      **  End of CMQODV                                               **
      ******************************************************************
