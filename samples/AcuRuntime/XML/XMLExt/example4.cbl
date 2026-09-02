       Identification Division.
       Program-Id.  Example-4.
      *
      * Title: EXAMPLE4.CBL: Export / Import with Sparse Arrays.
      *
      * Copyright (C) 2008,2010 Micro Focus. All rights reserved.
      *
      * This sample code is supplied for demonstration purposes only
      * on an "as is" basis and is for use at your own risk.
      *
      * Version Identification:
      *   $Revision: 67186 $
      *   $Date: 2015-03-23 19:14:54 +0000 (Mon, 23 Mar 2015) $
      *   $URL: svn://sd-dev/acu/tags/v10-1-0-patch-1669-rc-0/cobolgt/sample/xmlext/example4.cbl $
      *
      * This example exports files table1.xml to table4.xml
      * and imports files table1.xml to table6.xml.
      *
      * Files table5.xml and table6.xml must already exist for
      *   the imports of those files in this example.
      *
       Data Division.
       Working-Storage Section.
       01  Data-Table.
           02              Pic X Value "[".
           02  Table-1     Occurs 6.
               03  X       Pic X.
               03  N       Pic 9.
           02              Pic X Value "]".

       01  I               Pic 9.
       01  Done            Pic X.

       Copy "lixmlall.cpy".

       Procedure Division.
       A.
           Display "Example-4 - Illustrate EXPORT FILE & IMPORT FILE"
                   " with sparse arrays".

           XML INITIALIZE.
           If Not XML-OK Go to Z End-If.

           XML DISABLE ATTRIBUTES.
           If Not XML-OK Go to Z End-If.

           XML DISABLE ALL-OCCURRENCES.
           If Not XML-OK Go to Z End-If.

           Initialize Data-Table.
           Move "B" to X (2).  Move  2  to N (2).
           Move "D" to X (4).  Move  4  to N (4).

           XML EXPORT FILE
               Data-Table         *> reference to export source data item (input)
               "table1"           *> output document file name (input)
               "Data-Table".      *> model data name string (input)
           If Not XML-OK Go to Z End-If.

           Display Space.
           Display "table1.xml exported by XML EXPORT FILE: ".
           Display Data-Table Position 0.

           XML ENABLE ATTRIBUTES.
           If Not XML-OK Go to Z End-If.

           XML DISABLE ALL-OCCURRENCES.
           If Not XML-OK Go to Z End-If.

           Initialize Data-Table.
           Move "B" to X (2).  Move  2  to N (2).
           Move "D" to X (4).  Move  4  to N (4).

           XML EXPORT FILE
               Data-Table         *> reference to export source data item (input)
               "table2"           *> output document file name (input)
               "Data-Table".      *> model data name string (input)
           If Not XML-OK Go to Z End-If.

           Display "table2.xml exported by XML EXPORT FILE: ".
           Display Data-Table Position 0.

           XML DISABLE ATTRIBUTES.
           If Not XML-OK Go to Z End-If.

           XML ENABLE ALL-OCCURRENCES.
           If Not XML-OK Go to Z End-If.

           Initialize Data-Table.
           Move "B" to X (2).  Move  2  to N (2).
           Move "D" to X (4).  Move  4  to N (4).

           XML EXPORT FILE
               Data-Table         *> reference to export source data item (input)
               "table3"           *> output document file name (input)
               "Data-Table".      *> model data name string (input)
           If Not XML-OK Go to Z End-If.

           Display "table3.xml exported by XML EXPORT FILE: ".
           Display Data-Table Position 0.
           Initialize Data-Table.

           XML ENABLE ATTRIBUTES.
           If Not XML-OK Go to Z End-If.

           XML ENABLE ALL-OCCURRENCES.
           If Not XML-OK Go to Z End-If.

           Move "B" to X (2).  Move  2  to N (2).
           Move "D" to X (4).  Move  4  to N (4).

           XML EXPORT FILE
               Data-Table         *> reference to export source data item (input)
               "table4"           *> output document file name (input)
               "Data-Table".      *> model data name string (input)
           If Not XML-OK Go to Z End-If.

           Display "table4.xml exported by XML EXPORT FILE: ".
           Display Data-Table Position 0.
           Initialize Data-Table.

           XML IMPORT FILE
               Data-Table         *> reference to import target data item (input)
               "table1"           *> input document file name (input)
               "Data-Table".      *> model data name string (input)
           If Not XML-OK Go to Z End-If.

           Display Space.
           Display "table1.xml imported by XML IMPORT FILE: ".
           Display Data-Table Position 0.
           Initialize Data-Table.

           XML IMPORT FILE
               Data-Table         *> reference to import target data item (input)
               "table2"           *> input document file name (input)
               "Data-Table".      *> model data name string (input)
           If Not XML-OK Go to Z End-If.

           Display "table2.xml imported by XML IMPORT FILE: ".
           Display Data-Table Position 0.
           Initialize Data-Table.

           XML IMPORT FILE
               Data-Table         *> reference to import target data item (input)
               "table3"           *> input document file name (input)
               "Data-Table".      *> model data name string (input)
           If Not XML-OK Go to Z End-If.

           Display "table3.xml imported by XML IMPORT FILE: ".
           Display Data-Table Position 0.
           Initialize Data-Table.

           XML IMPORT FILE
               Data-Table         *> reference to import target data item (input)
               "table4"           *> input document file name (input)
               "Data-Table".      *> model data name string (input)
           If Not XML-OK Go to Z End-If.

           Display "table4.xml imported by XML IMPORT FILE: ".
           Display Data-Table Position 0.
           Initialize Data-Table.

           XML IMPORT FILE
               Data-Table         *> reference to import target data item (input)
               "table5"           *> input document file name (input)
               "Data-Table".      *> model data name string (input)
           If Not XML-OK Go to Z End-If.

           Display "table5.xml imported by XML IMPORT FILE: ".
           Display Data-Table Position 0.
           Initialize Data-Table.

           XML IMPORT FILE
               Data-Table         *> reference to import target data item (input)
               "table6"           *> input document file name (input)
               "Data-Table".      *> model data name string (input)
           If Not XML-OK Go to Z End-If.

           Display "table6.xml imported by XML IMPORT FILE: ".
           Display Data-Table Position 0.

           Display Space.
           Display "You may inspect 'table1.xml' - 'table6.xml'".
           Display Space.

       Z.
           Copy "lixmltrm.cpy".

           Display "Press a key to terminate:".                         TESTS
           Accept Done.                                                 TESTS
           Stop Run.

           Copy "lixmldsp.cpy".

       End Program  Example-4.
