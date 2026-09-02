      ******************************************************************
      **                                                              **
      **                      IBM MQ for Windows                      **
      **                                                              **
      **  FILE NAME:      CMQCFBSV                                    **
      **                                                              **
      **  DESCRIPTION:    MQCFBS Structure -- PCF Byte String         **
      **                  Parameter                                   **
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
      **  FUNCTION:       This file declares the structure MQCFBS,    **
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
      ** CMQCFBSV                                                     **
      ** <END_BUILDINFO>                                              **
      ******************************************************************

      ** MQCFBS structure
       10  MQCFBS.
      ** Structure type
       15  MQCFBS-TYPE PIC S9(9) BINARY VALUE 9.
      ** Structure length
       15  MQCFBS-STRUCLENGTH PIC S9(9) BINARY VALUE 16.
      ** Parameter identifier
       15  MQCFBS-PARAMETER PIC S9(9) BINARY VALUE 0.
      ** Length of string
       15  MQCFBS-STRINGLENGTH PIC S9(9) BINARY VALUE 0.


      ******************************************************************
      **  End of CMQCFBSV                                             **
      ******************************************************************
