      *
      * Title: LIXMLDSP.CPY: Display Status definitions.
      *
      ******************************************************************
      *
      * (C) Copyright 2018-2019 Micro Focus or one of its affiliates.
      *
      * The only warranties for products and services of Micro Focus and
      * its affiliates and licensors ("Micro Focus") are set forth in
      * the express warranty statements accompanying such products and
      * services. Nothing herein should be construed as constituting an
      * additional warranty. Micro Focus shall not be liable for
      * technical or editorial errors or omissions contained herein. The
      * information contained herein is subject to change without
      * notice.
      *
      ******************************************************************
      *
      * Version Identification:
      *   $Revision: 25098 $
      *   $Date: 2019-05-13 20:55:43 +0100 (Mon, 13 May 2019) $
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
