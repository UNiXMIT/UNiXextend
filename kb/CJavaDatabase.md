# Connecting to a database using C$JAVA
## Environment
All versions of AcuCOBOL-GT extend  
All Platforms  

## Situation
C$JAVA, using the op-codes CJAVA-DBCONNECT and CJAVA-DBQUERY, can be used to connect to and query a database. What driver string and connection string should be used?  

## Resolution
The hardest part is finding the correct connection and driver string to use. This information can commonly be found from the database vendors website. For this sample the connection will be made to SQL Server - https://learn.microsoft.com/en-us/sql/connect/jdbc/building-the-connection-url?view=sql-server-2017  

```
MOVE "com.microsoft.sqlserver.jdbc.SQLServerDriver" to DB-DRIVERSTR
MOVE "jdbc:sqlserver://server-hostname:1433;DatabaseName=support;user=******;password=******;" to DB-CONNECTSTR
MOVE "SELECT * FROM CUSTOMER" to DB-QUERY.
```

The connection should now be successful and a query on the database can be made.  

If the connection is not successful and errors are still received there are some logging options to turn on to investigate the issue further.  

```
A_JAVA_TRACE_VALUE -1
A_JAVA_TRACE_FILENAME javatrace.txt
```

Additional values for A_JAVA_TRACE_VALUE can be found in the documentation - https://docs.rocketsoftware.com/bundle/acucobolgt_dg_1051_html/page/BKUSUSCONFS019.html  