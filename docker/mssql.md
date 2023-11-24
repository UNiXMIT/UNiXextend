# MSSQL
### Pull and Run container
```
podman pull mcr.microsoft.com/mssql/server:2022-latest
podman run -d --name mssql \
-e "SA_PASSWORD=strongPassword123" \
-e "ACCEPT_EULA=Y" \
-e "MSSQL_COLLATION=SQL_Latin1_General_CP1_CI_AS" \
-p 1433:1433 \
--health-cmd '/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "strongPassword123" -Q "SELECT 1" -b -o /dev/null' \
--health-interval 10s \
--health-timeout 3s \
--health-retries 10 \
--health-start-period 10s \
mcr.microsoft.com/mssql/server:2022-latest
```

### Rotate/Limit Logs
Add the following to the 'podman run' command.  
```
--log-opt max-size=50m --log-opt max-file=5
```

### Attach to container
```
podman exec -it mssql bash
```

### Container Details
username: sa   
password: strongPassword123  

### Create User and Database
```
podman exec -it mssql /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P strongPassword123 -Q "CREATE DATABASE support; \
CREATE LOGIN support WITH PASSWORD='strongPassword123', DEFAULT_DATABASE=support; \
ALTER SERVER ROLE sysadmin ADD MEMBER support; \
CREATE USER support FOR LOGIN support; \
ALTER USER support WITH DEFAULT_SCHEMA=dbo; \
ALTER ROLE db_owner ADD MEMBER support"
```

### Remove container
```
podman stop mssql
podman rm mssql
```

### Source
[https://bit.ly/3Jn5D7i](https://bit.ly/3Jn5D7i)  

### odbc.ini
```
[MSSQL]  
Driver = /opt/microsoft/msodbcsql17/lib64/libmsodbcsql-17.10.so.5.1  
Server = tcp:localhost,1433
Encrypt = yes
TrustServerCertificate = yes
```