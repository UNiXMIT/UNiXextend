# Oracle
#### Pull and Run container
```
podman pull container-registry.oracle.com/database/free:latest
podman run -d -p 1521:1521 --name oracle -e ORACLE_PWD=strongPassword123 -e ORACLE_CHARACTERSET=AL32UTF8 container-registry.oracle.com/database/free:latest
```

#### Attach to container
```
podman exec -it oracle bash
```

### Container Details
sid: FREE  
username: sys  
password: strongPassword123  

### Connect to Database
```
podman exec -it oracle sqlplus sys/strongPassword123@//localhost:1521/FREE as sysdba
podman exec -it oracle sqlplus system/strongPassword123@//localhost:1521/FREE
podman exec -it oracle sqlplus pdbadmin/strongPassword123@//localhost:1521/FREEPDB1
```

### Create User and Schema
```
podman exec -it oracle sqlplus sys/strongPassword123@//localhost:1521/FREE as sysdba <<EOF
ALTER SESSION SET "_ORACLE_SCRIPT"=true;
CREATE USER support IDENTIFIED BY strongPassword123;
GRANT ALL PRIVILEGES TO support;
EXIT;
EOF
```

### Remove your container
```
podman stop oracle
podman rm oracle
```

### Source
[https://bit.ly/44fijqt](https://bit.ly/44fijqt)  

### ODBC Driver Setup
```
sudo dnf install [Oracle Instant Client + ODBC .rpm]
```

### ODBC Driver Location example
```
rpm -ql oracle-instantclient-odbc-*
```

### odbc.ini
```
[oracle]
Description     = Oracle ODBC Connection
Driver          = /usr/lib/oracle/19.9/client64/lib/libsqora.so.19.1
Database        = support
Servername      = 127.0.0.1:1521/FREE
UserID          = support
```

### tnsnames.ora
Default Location - $ORACLE_HOME\network\admin    
TNS_ADMIN - Changes the directory path of Oracle Net Services configuration files from the default location of $ORACLE_HOME\network\admin   
```
oracle =
  (DESCRIPTION=
    (ADDRESS = (PROTOCOL = TCP)(HOST = xxx.xxx.xxx.xxx)(PORT = 1521)
  )
  (CONNECT_DATA =
    (SERVICE_NAME=FREE)
  )
)
```

### ORA-12526, TNS:listener: all appropriate instances are in restricted mode.
```
sqlplus /nolog
conn sys as sysdba
password: strongPassword123
alter system disable restricted session;
```