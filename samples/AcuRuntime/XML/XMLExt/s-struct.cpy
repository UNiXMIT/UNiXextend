      *
      * Title: s-struct.cpy: XML Extensions sample data structure.
      *
      * Copyright (C) 2010 Micro Focus. All rights reserved.
      *
      * This sample code is supplied for demonstration purposes only
      * on an "as is" basis and is for use at your own risk.
      *
      * Version Identification:
      *   $Revision: 67186 $
      *   $Date: 2015-03-23 19:14:54 +0000 (Mon, 23 Mar 2015) $
      *   $URL: svn://sd-dev/acu/tags/v10-1-0-patch-1662-rc-11/cobolgt/sample/xmlext/s-struct.cpy $
      *
       01  Address-Struct.
           02  Name          Pic X(64)
                   Value "Specialty Cowboy Boots Company".
           02  Address-1     Pic X(64)
                   Value "1050 North San Antonio Street".
           02  Address-2     Pic X(64) Value "Suite 200".
           02  Address-3.
               03  City      Pic X(32) Value "Austin".
               03  State     Pic X(2) Value "TX".
               03  Zip       Pic 9(5) Value 78701.
           02  Country       Pic X(64)
                   Value "United States of America".
           02  Time-Stamp    Pic X(23).

       01 Struct-Name       Pic X(14) Value "Address-Struct".
