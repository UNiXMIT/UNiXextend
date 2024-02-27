# AcuSQL is missing configuration variables for ODBC Driver for SQL Server version 18
## Environment
AcuSQL  
Windows  
Linux/UNIX  

## Situation
AcuSQL 10.5.0 now supports ODBC Driver for SQL Server version 18. According to the documentation, there are no configuration variables to turn off default connection encryption or to trust the server certificate.  

## Resolution
There are 3 new configuration variables in AcuSQL 10.5.0:  

**ASQL-ENCRYPT-CONNECTION** - When set to TRUE, ON, or any non-zero value, the interface adds Encrypt=Yes to the connection string. Otherwise the interface adds nothing extra.  

**ASQL-TRUST-SERVER-CERTIFICATE** - When set to TRUE, ON, or any non-zero value, the interface adds TrustServerCertificate=Yes to the connection string. Otherwise the interface adds nothing extra.  

**ASQL-EXTRA-CONNECTION-INFO** - Enables you to add connection information not otherwise represented by AcuSQL connection options. Set to a literal string. This string is literally added to the connection string, prepended by a semicolon (;) to separate it from other connection attributes.  