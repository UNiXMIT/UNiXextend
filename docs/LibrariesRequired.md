# Libraries Required

- **ACUSERVER_LIBS** is the client library needed to use networking functionality (AcuServer, AcuConnect Distributed Processing, AcuConnect Thin Client, C$SOCKET, licensing, possibly other things). *Required*

- **ACVT_LIB** is our conversion library, necessary for the MOVE verb, and for doing other numeric conversions. *Required*

- **AXML_LIB** is our XML support library, and is needed for parsing XFD files, C$XML, AcuXML. *Possibly optional* 

- **TERMMGR_LIB** is our screen manager. *Required* 

- **AFSI_LIB and AFSI2_LIB** are various file system functions. AFSI_LIB has our file dispatch functionality, and without this no file systems are supported (including vision). *Required*
 
- **AFSI2_LIB** is some high-level XFD parsing functionality. *Possibly optional*

- **REGEX_LIB** is used for regular expression processing. *Possibly optional*

- **FSI_LIBS** are extra libraries needed for various file systems (Informix, etc). This will be blank by default, unless modifed by the user for using a particular file system 

- **VISION_LIB** is vision. *Required* 

- **ACUSQL_LIBS** is a list of libraries needed for Embedded SQL processing. Blank by default, unless modified by the user. 

- **CICS_LIB and MQSERIES_LIB** are needed if the customer is using CICS or MQSERIES. These are normally blank, unless modified by the user. 

- **EXTSM_LIB** is for an external sort module. Normally blank, unless modified by the user. 

- **ACME_LIB** is basic functionality for abstracting machine differences. *Required* 

- **PDF_LIB** is for PDF printing or C$PDF. *Possibly optional*

- **HPDF_LIB** is a support library for PDF_LIB. Can be removed if PDF_LIB is removed
 
- **PNG_LIB** is another support library for PDF_LIB. Can be removed if PDF_LIB is removed 

- **COMPRESSION_LIB** is used for compression. *Possibly optional *
