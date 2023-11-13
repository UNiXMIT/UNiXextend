# DB2 LUW
### Pull and Run container
```
podman pull icr.io/db2_community/db2
podman run -itd --name db2 --privileged=true -p 50000:50000 -e LICENSE=accept -e DB2INSTANCE=support -e DB2INST1_PASSWORD=strongPassword123 -e DBNAME=support icr.io/db2_community/db2
```

### Attach to container
```
podman exec -it db2 bash -c "su - support"
```

### Connect to database and execute SQL
```
db2 CONNECT TO SUPPORT
db2 SET CURRENT SCHEMA SchemaName
db2 SELECT * FROM SUPPORT.SchemaName
```

### Connect to database and execute SQL from file
```
db2 -t -vmf db2.sql |tee db2.sql.out
```

t – terminated – the statements are terminated with a delimiter. The default delimiter is the semi-colon.  
v – verbose – the statement will be echoed in output prior to the result of the statement. This is extremely useful when reviewing output or troubleshooting failed statements.  
m – prints the number of lines affected by DML.  
f – file – indicates that db2 should execute statements from a file, with the filename specified one space after the f.  

### Remove your container
```
podman stop db2
podman rm db2
```

### Clients and Driver Downloads
https://ibm.co/3JKDGaL

### Catalog remote database on client
```
db2 catalog tcpip node <NODENAME> remote hostname|ip_address server service_name|port_number
db2 catalog database <DBNAME> at node <NODENAME>
db2 terminate
db2 connect to <DBNAME> user <USERNAME>
```
NODENAME - A local nickname you can set for the computer that has the database you want to catalog.  
DBNAME - Name of remote database to catalog.  

### Install ODBC Driver (cmd as Admin)
```
db2cli install -setup
```

### Source
https://ibm.co/3JuuQga  