      *
      * Title: LIXMLDEF.CPY: Data structures and predefined values.
      *
      * Copyright (C) 2008,2015 Micro Focus. All rights reserved.
      *
      * You have a royalty-free right to use, modify, reproduce, and
      * distribute this COBOL source file (and/or any modified version)
      * in any way you find useful, provided that you retain this notice
      * and agree that Micro Focus has no warranty, obligations, or
      * liability for any such use of the source file.
      *
      * Version Identification:
      *   $Revision: 68840 $
      *   $Date: 2015-11-13 20:08:49 +0000 (Fri, 13 Nov 2015) $
      *
      *
      *** Document Processing Statements:
      *
      * XML EXPORT FILE
      *     DataStructure       *> reference to export source data item (input)
      *     DocumentName        *> output document file name (input)
      *     ModelDataName       *> model data name string (input)
      *    [StyleSheetName]     *> XSLT stylesheet file name (input)
      *
      * XML EXPORT TEXT
      *     DataStructure       *> reference to export source data item (input)
      *     DocumentPointer     *> document pointer data item (output)
      *     DocumentLength      *> length of document output (output)
      *     ModelDataName       *> model data name string (input)
      *    [StyleSheetName]     *> XSLT stylesheet file name (input)
      *
      * XML IMPORT FILE
      *     DataStructure       *> reference to import target data item (input)
      *     DocumentName        *> input document file name (input)
      *     ModelDataName       *> model data name string (input)
      *    [StyleSheetName]     *> XSLT stylesheet file name (input)
      *
      * XML IMPORT TEXT
      *     DataStructure       *> reference target data item (input)
      *     DocumentPointer     *> document pointer data item (input)
      *     DocumentLength      *> input document length (input)
      *     ModelDataName       *> model data name string (input)
      *    [StyleSheetName]     *> XSLT stylesheet file name (input)
      *
      * XML TEST WELLFORMED-FILE
      *     DocumentName        *> document to test file name (input)
      *
      * XML TEST WELLFORMED-TEXT
      *     DocumentPointer     *> document pointer data item (input)
      *     DocumentLength      *> length of document text to test (input)
      *
      * XML TRANSFORM FILE
      *     InputDocumentName   *> document to transform file name (input)
      *     StyleSheetName      *> XSLT stylesheet file name (input)
      *     OutputDocumentName  *> transformed document file name (input)
      *
      * XML TRANSFORM TEXT
      *     InDocumentPointer   *> document pointer for input document (input)
      *     InDocumentLength    *> length of input document (input)
      *     StyleSheetName      *> transform XSLT stylesheet file name (input)
      *     OutDocumentPointer  *> document pointer for transformed document (output)
      *     OutDocumentLength   *> length of transformed document (output)
      *
      * XML VALIDATE FILE
      *     DocumentName        *> document to validate file name (input)
      *     SchemaName          *> XML Schema document for validation (input)
      *
      * XML VALIDATE TEXT
      *     DocumentPointer     *> document pointer data item (input)
      *     DocumentLength      *> length of document text to validate (input)
      *     SchemaName          *> file name of schema for document (input)
      *
      *
      *** Document Management Statements:
      *
      * XML FREE TEXT
      *     DocumentPointer     *> document pointer data item (input)
      *
      * XML GET TEXT
      *     DocumentPointer     *> document pointer data item (output)
      *     DocumentLength      *> length of document text (output)
      *     DocumentName        *> source document file name (input)
      *
      * XML PUT TEXT
      *     DocumentPointer     *> document pointer data item (input)
      *     DocumentLength      *> length of document text (input)
      *     DocumentName        *> target document file name (input)
      *
      * XML REMOVE FILE
      *     FileName            *> file name of file to remove (input)
      *
      *
      *** Directory Management Statements:
      *
      * XML FIND FILE
      *     DirectoryName       *> path name of directory to check (input)
      *     FileName            *> full name of found file (output)
      *
      * XML GET UNIQUEID
      *     UniqueID            *> unique id value; see XML-UniqueID (output)
      *
      *
      *** State Management Statements:
      *
      * XML DISABLE ALL-OCCURRENCES
      *
      * XML DISABLE ATTRIBUTES
      *
      * XML DISABLE CACHE
      *
      * XML ENABLE ALL-OCCURRENCES
      *
      * XML ENABLE ATTRIBUTES
      *
      * XML ENABLE CACHE
      *
      * XML FLUSH CACHE
      *
      * XML GET STATUS-TEXT
      *
      * XML INITIALIZE
      *
      * XML GET FLAGS
      *     Flags               *> Flags obtained; see PF-Flags (output)
      *
      * XML SET FLAGS
      *     Flags               *> Flags to set; see PF-Flags (input)
      *
      * XML GET WHITESPACE-FLAGS
      *     WhitespaceFlags     *> WhitespaceFlags obtained (see whitespace-flags)
      *
      * XML SET WHITESPACE-FLAGS
      *     WhitespaceFlags     *> WhitespaceFlags to set (see whitespace-flags)
      *
      * XML SET ENCODING
      *     Encoding            *> Encoding value; see XML-Encoding (input)
      *
      * XML SET XSL-PARAMETERS
      *     {Name, Value}       *> repeating name / value pairs (input)
      *
      * XML CLEAR XSL-PARAMETERS
      *
      * XML TERMINATE
      *
      * XML TRACE
      *     Flags               *> Flags for On=1/Off=0 and Keep=0/Del=2 (input)
      *    [TraceFileName]      *> Trace file; default: "XMLTrace.log" default (input)
      *

      *** XML values for all-occurrences statements:

       78  XML-AllOccurDisableV    VALUE  0.
       78  XML-AllOccurEnableV     VALUE  1.

      *** XML values for attributes statements:

       78  XML-AttrDisableV    VALUE  0.
       78  XML-AttrEnableV     VALUE  1.

      *** XML values for caching statements:

       78  XML-CacheDisableV   VALUE  0.
       78  XML-CacheEnableV    VALUE  1.
       78  XML-CacheFlushV     VALUE -1.

      *** PF-Flags
      *   XML Extensions flag values for XML SET FLAGS and
      *      XML GET FLAGS statements
      *
      *  The following values may be passed as flags in the
      *  XML SET FLAGS statement.  The flags set will be applied
      *  to all data items in an export or import, except
      *  as noted for PF-Leading-Spaces and PF-Trailing-Spaces,
      *  until the flags are changed by another XML SET FLAGS
      *  statement.  The current setting of the flags can be
      *  obtained with an XML GET FLAGS statement.

       78  PF-Leading-Spaces       Value 128.
      *  PF-Leading-Spaces is used on output to cause leading
      *  spaces to be removed from a non-numeric COBOL data item
      *  before being placed in XML.  It is used on input to cause
      *  leading spaces to be added to right justified data items
      *  before being placed in the COBOL data area.  This flag
      *  is not used for edited or FILLER data items on import or
      *  export of a data item.  This flag is also not used for
      *  export of a right justified data item.  The default flag
      *  settings include this flag value (see XML SET FLAGS
      *  statement for changing the default flag settings).

       78  PF-Trailing-Spaces      Value 4194304.
      *  PF-Trailing-Spaces is used on output to cause trailing
      *  spaces to be removed from a non-numeric COBOL data item
      *  before being placed in XML.  It is used on input to cause
      *  trailing spaces to be added to left justified data items
      *  before being placed in the COBOL data area.  This flag
      *  is not used for edited or FILLER data items on import
      *  or export of a data item.  The default flag settings
      *  include this flag value (see XML SET FLAGS statement
      *  for changing the default flag settings).

       78  PF-No-Size-Error       Value 1024.
      *  PF-No-Size-Error is used to disable COBOL size
      *  error checking.  If this flags is not set, size error
      *  checking is performed.

       78  PF-Rounded              Value 262144.
      *  PF-Rounded is used to cause COBOL rounding rules to apply
      *  to any numeric data conversion.  The default flag settings
      *  include this flag value (see XML SET FLAGS statement for
      *  changing the default flag settings).

      *  The following flags affect numeric COBOL Data items on
      *  output only.  Only one of the following flags should be
      *  selected.

       78  PF-Leading-Sign         Value 0.
      *  PF-Leading-Sign causes a sign character (either + or -)
      *  to be placed in the XML before the numeric value.

       78  PF-Leading-Minus        Value 1.
      *  PF-Leading-Minus causes a minus sign to be placed in
      *  the XML before the numeric value if (and only if) the
      *  value is negative.  The default flag settings
      *  include this flag value (see XML SET FLAGS statement for
      *  changing the default flag settings).

       78  PF-Trailing-Sign        Value 4.
      *  PF-Trailing-Sign causes a sign character (either + or -)
      *  to be placed in the XML after the numeric value.

       78  PF-Trailing-Minus       Value 5.
      *  PF-Trailing-Minus causes a minus sign to be placed in
      *  the XML after the numeric value if (and only if) the
      *  value is negative.

       78  PF-Trailing-Credit      Value 6.
      *  PF-Trailing-Credit causes the characters "CR" to be placed
      *  in the XML after the numeric value if (and only if) the
      *  value is negative.

       78  PF-Trailing-Debit       Value 7.
      *  PF-Trailing-Debig causes the characters "DB" to be placed
      *  in the XML after the numeric value if (and only if) the
      *  value is negative.

      * The following data conversion flags are placed here for
      * completeness.  These flags are probably not generally useful
      * in XML Extensions.

       78  PF-Assert-Signed            Value 8.
       78  PF-Assert-Unsigned          Value 16.
       78  PF-In                       Value 32.
       78  PF-Integer-Only             Value 64.
       78  PF-Leading-Value            Value 256.
       78  PF-No-Null-Pointer          Value 512.
       78  PF-Occurs                   Value 2048.
       78  PF-Optional                 Value 4096.
       78  PF-Out                      Value 8192.
       78  PF-Pointer-Max-Size         Value 16384.
       78  PF-Pointer-Reset-Offset     Value 32768.
       78  PF-Repeat                   Value 65536.
       78  PF-Return-Value             Value 131072.
       78  PF-Scaled                   Value 524288.
       78  PF-Silent                   Value 1048576.
       78  PF-Size                     Value 2097152.
       78  PF-Trailing-Value           Value 8388608.
       78  PF-Unsigned                 Value 16777216.
       78  PF-Value-If-Omitted         Value 33554432.
       78  PF-C-Data-Is-Ansi           Value 67108864.
       78  PF-C-Data-Is-Oem            Value 134217728.
       78  PF-Leave-Trailing-Zeroes    Value 268435456.

      *** Whitespace-Flags
      *   XML Extensions flag values for XML GET WHITESPACE-FLAGS and
      *       XML SET WHITESPACE-FLAGS statements
      *
       78  WHITESPACE-DEFAULT-FLAGS     Value 0.
       78  WHITESPACE-STRIP-CONTROL     Value 1.  
       78  WHITESPACE-PRESERVE-TAB      Value 16.
       78  WHITESPACE-PRESERVE-LF       Value 32.
       78  WHITESPACE-PRESERVE-CR       Value 64.
       78  WHITESPACE-NORMALIZE         Value 65536. *>collapse whitespace (space, lf, tab, cr) 

      *** XML-Encoding

       78  ENC-Local                    Value 0.
       78  ENC-UTF8                     Value 1.

      *** XML status values

       78  XML-WarningLimit                                 Value -100. *> allow for future 
       78  XML-WarningAmbiguousImportName                   Value -6.
       78  XML-WarningAmbiguousImportTarget                 Value -5.
       78  XML-WarningSubscriptRange                        Value -4.
       78  XML-WarningDataTruncation                        Value -3.
       78  XML-WarningExtraneousElement                     Value -2.
       78  XML-Success                                      Value  0.
       78  XML-InformDirectoryEmpty                         Value  1.
       78  XML-InformDocumentNoData                         Value  2.
       78  XML-WarningInternalLogic0                        Value  3.
       78  XML-WarningInvalidOption                         Value  4.
       78  XML-StatusNonFatal                               Value  4.
       78  XML-ErrorCreateDocument                          Value  9.
       78  XML-ErrorCreateUrl                               Value 10.
       78  XML-ErrorDataItemDup                             Value 11.
       78  XML-ErrorDataItemMissing                         Value 12.
       78  XML-ErrorDocumentFileCreate                      Value 13.
       78  XML-ErrorDocumentFileMissing                     Value 14.
       78  XML-ErrorExtraneousElement                       Value 15.
       78  XML-ErrorGetFirstChild                           Value 17.
       78  XML-ErrorGetNextSibling                          Value 18.
       78  XML-ErrorGetNodeData                             Value 19.
       78  XML-ErrorGetRootNode                             Value 20.
       78  XML-ErrorInternalLogic0                          Value 21.
       78  XML-ErrorInternalLogic1                          Value 22.
       78  XML-ErrorInternalLogic2                          Value 23.
       78  XML-ErrorInitialization                          Value 24.
       78  XML-ErrorInvalidDataAddress                      Value 25.
       78  XML-ErrorLoadDocument                            Value 28.
       78  XML-ErrorLoadSchema                              Value 29.
       78  XML-ErrorLoadStyleSheet                          Value 30.
       78  XML-ErrorLoadStyleSheetText                      Value 31.
       78  XML-ErrorLoadTemplate                            Value 32.
       78  XML-ErrorSubscriptRange                          Value 35.
       78  XML-ErrorTempFileAccess                          Value 36.
       78  XML-ErrorTransformDom                            Value 37.
       78  XML-ErrorTransformText                           Value 38.
       78  XML-ErrorSymbolTableMissing                      Value 39.
       78  XML-ErrorValidateSchema                          Value 40.
       78  XML-ErrorVersionNumber                           Value 41.
       78  XML-ErrorWriteDocument                           Value 42.
       78  XML-ErrorInvalidCharEncoding                     Value 45.
       78  XML-ErrorInvalidUTF8Data                         Value 46.
       78  XML-ErrorInvalidXmlExtEncodingValue              Value 47.
       78  XML-ErrorInvalidEncodingValue                    Value 47.
       78  XML-ErrorUnableToLocateIconv                     Value 48.
       78  XML-ErrorDirectoryOpenFailure                    Value 49.
       78  XML-ErrorMissingXMLParser                        Value 50.
       78  XML-ErrorDataItemFormat                          Value 51.
       78  XML-ErrorDataConversionFailure                   Value 52.
       78  XML-ErrorCodebridgeConversionFailure             Value 52.
       78  XML-ErrorNotDataItem                             Value 53.
       78  XML-ErrorRequestetTemplateFileMissing            Value 62.
       78  XML-ErrorResolvedNameTooLong                     Value 63.
       78  XML-ErrorResolvedNameDoesNotExist                Value 64.
       78  XML-ErrorNameValuePairRequired                   Value 65.
       78  XML-ErrorExcessiveXslParams                      Value 66.
       78  XML-ErrorUniqueIdBufferTooSmall                  Value 67.
       78  XML-ErrorUniqueIdentifierTooLong                 Value 67.
       78  XML-ErrorAddAttributeNode                        Value 68.
       78  XML-ErrorAddElementNode                          Value 69.
       78  XML-ErrorAddTextNode                             Value 70.
       78  XML-ErrorValidateDomDocument                     Value 71.
       78  XML-ErrorBadImportOffset                         Value 72.
       78  XML-ErrorTraceFileOpenFailed                     Value 73.

      *** XML Interface Data Items

      *   The following data items are implicitly referenced
      *   by XML statements or are useful data items
      *   for explicit references in XML statements.

       01  XML-data-group.

           03  XML-Status             PIC S9(4) Sign Leading Separate.
               88  XML-IsSuccess      VALUE XML-Success.
               88  XML-OK             VALUE XML-WarningLimit
                                      THROUGH XML-StatusNonFatal.
               88  XML-IsDirectoryEmpty
                                      VALUE  XML-InformDirectoryEmpty.
           03  XML-StatusText         PIC X(80).
           03  XML-MoreFlag           PIC 9 BINARY(1) VALUE 0.
               88 XML-NoMore          VALUE 0.
           03  XML-UniqueID           PIC X(40).
           03  XML-Flags              PIC 9(10) BINARY(4).
           03  XML-COBOL-Version      PIC 9(4) VALUE 9.  *>Used by XMLSetVersion
           03  XML-XMLIF-Version      PIC 9(4) VALUE 0.  *>Set by XMLSetVersion

      * End of LIXMLDEF.CPY.
