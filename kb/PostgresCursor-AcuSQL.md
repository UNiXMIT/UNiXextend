# Error ‘cobcur1_000000 does not exist’ in AcuSQL with positioned updates using a cursor and PostgreSQL
## Environment
AcuSQL  
Windows  
Linux / UNIX  

## Situation
Attempting to update records through a cursor with PostgreSQL fails with error:  

```
ERROR: cursor "cobcur1_000000" does not exist
```

According to PostgreSQL documentation, this syntax is supported.  

## Resolution
Although positioned updates are documented as valid in PostgreSQL, they are not supported in the generic way (as statements) by its ODBC driver (psqlODBC). This is documented in the PostgreSQL ODBC documentation.  
An alternative solution should be found, using SQL Statements in your source, to workaround this limitation of psqlODBC.  

#### Additional Information
https://odbc.postgresql.org/docs/config.html