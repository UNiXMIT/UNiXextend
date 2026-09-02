      *
      * Title: LIXMLDSP.CPY: Display Status definitions.
      *
      * Copyright (C) 2008,2010 Micro Focus. All rights reserved.
      *
      * You have a royalty-free right to use, modify, reproduce, and
      * distribute this COBOL source file (and/or any modified version)
      * in any way you find useful, provided that you retain this notice
      * and agree that Micro Focus has no warranty, obligations, or
      * liability for any such use of the source file.
      *
      * Version Identification:
      *   $Revision: 67187 $
      *   $Date: 2015-03-23 19:18:56 +0000 (Mon, 23 Mar 2015) $
      *
       Display-Status.
           If Not XML-IsSuccess
               Perform With Test After Until XML-NoMore
                   XML GET STATUS-TEXT
                   Display XML-StatusText
               End-Perform
           End-If.
      *
      * End of LIXMLDSP.CPY.
      *
