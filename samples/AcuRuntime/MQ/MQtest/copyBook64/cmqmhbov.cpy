      ******************************************************************
      **                                                              **
      **                      IBM MQ for Windows                      **
      **                                                              **
      **  FILE NAME:      CMQMHBOV                                    **
      **                                                              **
      **  DESCRIPTION:    MQMHBO Structure -- Message Handle To       **
      **                  Buffer Options                              **
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
      **  FUNCTION:       This file declares the structure MQMHBO,    **
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
      ** CMQMHBOV                                                     **
      ** <END_BUILDINFO>                                              **
      ******************************************************************

      ** MQMHBO structure
       10  MQMHBO.
      ** Structure identifier
       15  MQMHBO-STRUCID PIC X(4) VALUE 'MHBO'.
      ** Structure version number
       15  MQMHBO-VERSION PIC S9(9) BINARY VALUE 1.
      ** Options that control the action of MQMHBUF
       15  MQMHBO-OPTIONS PIC S9(9) BINARY VALUE 1.


      ******************************************************************
      **  End of CMQMHBOV                                             **
      ******************************************************************
