      ******************************************************************
      **                                                              **
      **                      IBM MQ for Windows                      **
      **                                                              **
      **  FILE NAME:      CMQCFXLL                                    **
      **                                                              **
      **  DESCRIPTION:    MQCFIL64 Structure -- PCF 64-bit            **
      **                  Integer-List Parameter                      **
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
      **  FUNCTION:       This file declares the structure            **
      **                  MQCFIL64, which is used by the main MQI.    **
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
      ** CMQCFXLL                                                     **
      ** <END_BUILDINFO>                                              **
      ******************************************************************

      ** MQCFIL64 structure
       10  MQCFIL64.
      ** Structure type
       15  MQCFIL64-TYPE PIC S9(9) BINARY.
      ** Structure length
       15  MQCFIL64-STRUCLENGTH PIC S9(9) BINARY.
      ** Parameter identifier
       15  MQCFIL64-PARAMETER PIC S9(9) BINARY.
      ** Count of parameter values
       15  MQCFIL64-COUNT PIC S9(9) BINARY.


      ******************************************************************
      **  End of CMQCFXLL                                             **
      ******************************************************************
