      ******************************************************************
      **                                                              **
      **                      IBM MQ for Windows                      **
      **                                                              **
      **  FILE NAME:      CMQCFSTV                                    **
      **                                                              **
      **  DESCRIPTION:    MQCFST Structure -- PCF String Parameter    **
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
      **  FUNCTION:       This file declares the structure MQCFST,    **
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
      ** CMQCFSTV                                                     **
      ** <END_BUILDINFO>                                              **
      ******************************************************************

      ** MQCFST structure
       10  MQCFST.
      ** Structure type
       15  MQCFST-TYPE PIC S9(9) BINARY VALUE 4.
      ** Structure length
       15  MQCFST-STRUCLENGTH PIC S9(9) BINARY VALUE 20.
      ** Parameter identifier
       15  MQCFST-PARAMETER PIC S9(9) BINARY VALUE 0.
      ** Coded character set identifier
       15  MQCFST-CODEDCHARSETID PIC S9(9) BINARY VALUE 0.
      ** Length of string
       15  MQCFST-STRINGLENGTH PIC S9(9) BINARY VALUE 0.


      ******************************************************************
      **  End of CMQCFSTV                                             **
      ******************************************************************
