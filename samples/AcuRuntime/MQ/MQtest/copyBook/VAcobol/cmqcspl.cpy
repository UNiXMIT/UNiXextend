      ******************************************************************
      **                                                              **
      **                      IBM MQ for Windows                      **
      **                                                              **
      **  FILE NAME:      CMQCSPL                                     **
      **                                                              **
      **  DESCRIPTION:    MQCSP Structure -- Security Parameters      **
      **                                                              **
      ******************************************************************
      **  <copyright                                                  **
      **  notice="lm-source-program"                                  **
      **  pids="5724-H72,5655-R36,5724-L26"                           **
      **  years="1993,2025"                                           **
      **  crc="1616507131" >                                          **
      **  Licensed Materials - Property of IBM                        **
      **                                                              **
      **  5724-H72                                                    **
      **                                                              **
      **  (C) Copyright IBM Corp. 1993, 2025 All Rights Reserved.     **
      **                                                              **
      **  US Government Users Restricted Rights - Use, duplication or **
      **  disclosure restricted by GSA ADP Schedule Contract with     **
      **  IBM Corp.                                                   **
      **  </copyright>                                                **
      ******************************************************************
      **                                                              **
      **  FUNCTION:       This file declares the structure MQCSP,     **
      **                  which is used by the main MQI.              **
      **                                                              **
      **  PROCESSOR:      COBOL                                       **
      **                                                              **
      ******************************************************************

      ******************************************************************
      ** <BEGIN_BUILDINFO>                                            **
      ** Generated on:  14/02/25 09:48                                **
      ** Build Level:   p942-L250214                                  **
      ** Build Type:    Production                                    **
      ** Pointer Size:  32 Bit                                        **
      ** Source File:                                                 **
      ** CMQCSPL                                                      **
      ** <END_BUILDINFO>                                              **
      ******************************************************************

      ** MQCSP structure
       10  MQCSP.
      ** Structure identifier
       15  MQCSP-STRUCID PIC X(4).
      ** Structure version number
       15  MQCSP-VERSION PIC S9(9) BINARY.
      ** Type of authentication
       15  MQCSP-AUTHENTICATIONTYPE PIC S9(9) BINARY.
      ** Reserved
       15  MQCSP-RESERVED1 PIC X(4).
      ** Address of user ID
       15  MQCSP-CSPUSERIDPTR POINTER.
      ** Offset of user ID
       15  MQCSP-CSPUSERIDOFFSET PIC S9(9) BINARY.
      ** Length of user ID
       15  MQCSP-CSPUSERIDLENGTH PIC S9(9) BINARY.
      ** Reserved
       15  MQCSP-RESERVED2 PIC X(8).
      ** Address of password
       15  MQCSP-CSPPASSWORDPTR POINTER.
      ** Offset of password
       15  MQCSP-CSPPASSWORDOFFSET PIC S9(9) BINARY.
      ** Length of password
       15  MQCSP-CSPPASSWORDLENGTH PIC S9(9) BINARY.
      ** Ver:1 **
      ** Reserved
       15  MQCSP-RESERVED3 PIC X(8).
      ** Address of initial key
       15  MQCSP-INITIALKEYPTR POINTER.
      ** Offset of initial key
       15  MQCSP-INITIALKEYOFFSET PIC S9(9) BINARY.
      ** Length of initial key
       15  MQCSP-INITIALKEYLENGTH PIC S9(9) BINARY.
      ** Ver:2 **
      ** Reserved
       15  MQCSP-RESERVED4 PIC X(8).
      ** Address of Token
       15  MQCSP-TOKENPTR POINTER.
      ** Offset of Token
       15  MQCSP-TOKENOFFSET PIC S9(9) BINARY.
      ** Length of Token
       15  MQCSP-TOKENLENGTH PIC S9(9) BINARY.
      ** Ver:3 **


      ******************************************************************
      **  End of CMQCSPL                                              **
      ******************************************************************
