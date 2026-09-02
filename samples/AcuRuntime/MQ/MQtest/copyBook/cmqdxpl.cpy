      ******************************************************************
      **                                                              **
      **                      IBM MQ for Windows                      **
      **                                                              **
      **  FILE NAME:      CMQDXPL                                     **
      **                                                              **
      **  DESCRIPTION:    MQDXP Structure -- Data Conversion Exit     **
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
      **  FUNCTION:       This file declares the structure MQDXP,     **
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
      ** Pointer Size:  64 Bit                                        **
      ** Source File:                                                 **
      ** CMQDXPL                                                      **
      ** <END_BUILDINFO>                                              **
      ******************************************************************

      ** MQDXP structure
       10  MQDXP.
      ** Structure identifier
       15  MQDXP-STRUCID PIC X(4).
      ** Structure version number
       15  MQDXP-VERSION PIC S9(9) BINARY.
      ** Reserved
       15  MQDXP-EXITOPTIONS PIC S9(9) BINARY.
      ** Application options
       15  MQDXP-APPOPTIONS PIC S9(9) BINARY.
      ** Numeric encoding required by application
       15  MQDXP-ENCODING PIC S9(9) BINARY.
      ** Character set required by application
       15  MQDXP-CODEDCHARSETID PIC S9(9) BINARY.
      ** Length in bytes of message data
       15  MQDXP-DATALENGTH PIC S9(9) BINARY.
      ** Completion code
       15  MQDXP-COMPCODE PIC S9(9) BINARY.
      ** Reason code qualifying CompCode
       15  MQDXP-REASON PIC S9(9) BINARY.
      ** Response from exit
       15  MQDXP-EXITRESPONSE PIC S9(9) BINARY.
      ** Connection handle
       15  MQDXP-HCONN PIC S9(9) BINARY.
      ** Ver:1 **
      ** Add padding to ensure that pointers start on correct
      ** boundaries
       15  FILLER  PIC S9(9) BINARY VALUE 0.
      ** Interface entry points
       15  MQDXP-PENTRYPOINTS POINTER.
      ** Ver:2 **


      ******************************************************************
      **  End of CMQDXPL                                              **
      ******************************************************************
