# MSSQL
### Pull and Run container
```
podman pull mcr.microsoft.com/mssql/server:2022-latest
podman run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=strongPassword123" -e "MSSQL_COLLATION=SQL_Latin1_General_CP1_CI_AS" -p 1433:1433 --name mssql -d mcr.microsoft.com/mssql/server:2022-latest
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
