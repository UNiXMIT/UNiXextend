      *
      * Title: LIXMLRPL.CPY:  Replacement keys and text.
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
           ==XML DISABLE ALL-OCCURRENCES==  BY
           ==CALL "XMLAllOccurrences" GIVING XML-Status USING
                 XML-AllOccurDisableV==

           ==XML DISABLE ATTRIBUTES==       BY
           ==CALL "XMLAttributes" GIVING XML-Status USING
                 XML-AttrDisableV==

           ==XML DISABLE CACHE==            BY
           ==CALL "XMLCaching" GIVING XML-Status USING
                 XML-CacheDisableV==

           ==XML ENABLE ALL-OCCURRENCES==   BY
           ==CALL "XMLAllOccurrences" GIVING XML-Status USING
                 XML-AllOccurEnableV==

           ==XML ENABLE ATTRIBUTES==        BY
           ==CALL "XMLAttributes" GIVING XML-Status USING
                 XML-AttrEnableV==

           ==XML ENABLE CACHE==             BY
           ==CALL "XMLCaching" GIVING XML-Status USING
                 XML-CacheEnableV==

           ==XML EXPORT FILE==              BY
           ==CALL "XMLExportFile" GIVING XML-Status USING==

           ==XML EXPORT TEXT==              BY
           ==CALL "XMLExportText" GIVING XML-Status USING==

           ==XML FIND FILE==                BY
           ==CALL "XMLFindInDirectory" GIVING XML-Status USING==

           ==XML FLUSH CACHE==              BY
           ==CALL "XMLCaching" GIVING XML-Status USING
                 XML-CacheFlushV==

           ==XML FREE TEXT==                BY
           ==CALL "XMLFreeText" GIVING XML-Status USING==

           ==XML GET STATUS-TEXT==          BY
           ==CALL "XMLStatus" USING XML-StatusText XML-MoreFlag==

           ==XML GET TEXT==                 BY
           ==CALL "XMLTextInput" GIVING XML-Status USING==

           ==XML GET UNIQUEID==             BY
           ==CALL "XMLUniqueIdentifier" GIVING XML-Status USING==

           ==XML IMPORT FILE==              BY
           ==CALL "XMLImportFile" GIVING XML-Status USING==

           ==XML IMPORT TEXT==              BY
           ==CALL "XMLImportText" GIVING XML-Status USING==

           ==XML INITIALIZE==               BY
           ==CALL "XMLSetVersion" USING XML-COBOL-Version
                  GIVING XML-XMLIF-Version END-CALL
             CALL "XMLInitialize" GIVING XML-Status==

           ==XML PUT TEXT==                 BY
           ==CALL "XMLTextOutput" GIVING XML-Status USING==

           ==XML REMOVE FILE==              BY
           ==CALL "XMLRemove" GIVING XML-Status USING==

           ==XML SET ENCODING==             BY
           ==CALL "XMLSetEncoding" GIVING XML-Status USING==

           ==XML GET FLAGS==                BY
           ==CALL "XMLGetFlags" GIVING XML-Status USING==

           ==XML SET FLAGS==                BY
           ==CALL "XMLFlags" GIVING XML-Status USING==

           ==XML GET WHITESPACE-FLAGS==     BY
           ==CALL "XMLGetWhitespaceFlags" GIVING XML-Status USING==

           ==XML SET WHITESPACE-FLAGS==     BY
           ==CALL "XMLSetWhitespaceFlags" GIVING XML-Status USING==

           ==XML SET XSL-PARAMETERS==       BY
           ==CALL "XMLSetXSLParameter" GIVING XML-Status USING==

           ==XML CLEAR XSL-PARAMETERS==     BY
           ==CALL "XMLSetXSLParameter" GIVING XML-Status==

           ==XML TERMINATE==                BY
           ==CALL "XMLTerminate" GIVING XML-Status==

           ==XML TEST WELLFORMED-FILE==     BY
           ==CALL "XMLWellFormedFile" GIVING XML-Status USING==

           ==XML TEST WELLFORMED-TEXT==     BY
           ==CALL "XMLWellFormedText" GIVING XML-Status USING==

           ==XML TRACE==                    BY
           ==CALL "XMLTrace" GIVING XML-Status USING==

           ==XML TRANSFORM FILE==           BY
           ==CALL "XMLTransform" GIVING XML-Status USING==

           ==XML TRANSFORM TEXT==           BY
           ==CALL "XMLTransformText" GIVING XML-Status USING==

           ==XML VALIDATE FILE==            BY
           ==CALL "XMLValidFile" GIVING XML-Status USING==

           ==XML VALIDATE TEXT==            BY
           ==CALL "XMLValidText" GIVING XML-Status USING==

      *
      * End of LIXMLRPL.CPY.
      *
