       Identification Division.
       Program-Id.  Example-1.
      *
      * Title: EXAMPLE1.CBL: Export / Import.
      *
      * Copyright (C) 2008,2010 Micro Focus. All rights reserved.
      *
      * This sample code is supplied for demonstration purposes only
      * on an "as is" basis and is for use at your own risk.
      *
      * Version Identification:
      *   $Revision: 67186 $
      *   $Date: 2015-03-23 19:14:54 +0000 (Mon, 23 Mar 2015) $
      *   $URL: svn://sd-dev/acu/tags/v10-1-0-patch-1662-rc-11/cobolgt/sample/xmlext/example1.cbl $
      *
       Data Division.
       Working-Storage Section.

       Copy "s-struct.cpy".

       01  Done Pic X.
       01  WS-TimeStamp.
           02 WS-Date       PIC 9999/99/99.
           02 Filler        PIC XX Value Spaces.
           02 WS-Time       PIC 99/99/99/99.

       Copy "lixmlall.cpy".

       Procedure Division.
       A.
           Display "Example-1 - Illustrate EXPORT FILE & IMPORT FILE".

           XML INITIALIZE.
           If Not XML-OK Go to Z End-If.

           Accept WS-Date From Date YYYYMMDD.
           Accept WS-Time From Time.
           Inspect WS-Time Converting "/" To ":".
           Move "." To WS-Time(9: 1).
           Move WS-TimeStamp To Time-Stamp.

           XML EXPORT FILE
               Address-Struct   *> reference to export source data item (input)
               "address1"       *> output document file name (input)
               Struct-Name.     *> model data name string (input)
           If Not XML-OK Go to Z End-If.

           Display Space.
           Display "address1.xml exported by XML EXPORT FILE".
           Perform Display-Address-Struct.
           Initialize Address-Struct.

           XML IMPORT FILE
               Address-Struct   *> reference to import target data item (input)
               "address1"       *> input document file name (input)
               Struct-Name.     *> model data name string (input)
           If Not XML-OK Go to Z End-If.

           Display Space.
           Display "address1.xml imported by XML IMPORT FILE".
           Perform Display-Address-Struct.

           Display Space.
           Display "You may inspect 'address1.xml'".
           Display Space.
           Go to Z.

       Display-Address-Struct.
           Display Space.
           Display "Name:        " Name.
           Display "Address-1:   " Address-1.
           Display "Address-2:   " Address-2.
           Display "Address-3:   " Address-3.
           Display "Country:     " Country.
           Display "Time-Stamp:  " Time-Stamp.

       Z.
           Copy "lixmltrm.cpy".

           Display "Press a key to terminate:".                         TESTS
           Accept Done.                                                 TESTS
           Stop Run.

           Copy "lixmldsp.cpy".

       End Program  Example-1.
