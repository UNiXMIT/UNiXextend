      ******************************************************************
      **                                                              **
      **                      IBM MQ for Windows                      **
      **                                                              **
      **  FILE NAME:      CMQCFIFL                                    **
      **                                                              **
      **  DESCRIPTION:    MQCFIF Structure -- PCF Integer Filter      **
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
      **  FUNCTION:       This file declares the structure MQCFIF,    **
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
      ** CMQCFIFL                                                     **
      ** <END_BUILDINFO>                                              **
      ******************************************************************

      ** MQCFIF structure
       10  MQCFIF.
      ** Structure type
       15  MQCFIF-TYPE PIC S9(9) BINARY.
      ** Structure length
       15  MQCFIF-STRUCLENGTH PIC S9(9) BINARY.
      ** Parameter identifier
       15  MQCFIF-PARAMETER PIC S9(9) BINARY.
      ** Operator identifier
       15  MQCFIF-OPERATOR PIC S9(9) BINARY.
      ** Filter value
       15  MQCFIF-FILTERVALUE PIC S9(9) BINARY.


      ******************************************************************
      **  End of CMQCFIFL                                             **
      ******************************************************************
