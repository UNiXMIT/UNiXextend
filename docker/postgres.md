# PostgreSQL

### Pull and Run container
```
podman pull postgres:latest
podman run -d -p 5432:5432 --name postgres -e POSTGRES_USER=support -e POSTGRES_PASSWORD=strongPassword123 -e POSTGRES_DB=support postgres:latest
```

### Attach to container
```
podman exec -it postgres bash
```

### Container Details
```
Username: support
Password: strongPassword123
DB: support
```

### Remove your container
```
podman stop postgres
podman rm postgres
```

### Source
https://dockr.ly/3borF7q  

### ODBC Driver Setup
```
sudo yum install postgresql-odbc
```

### odbc.ini
```
[postgres]
Description         = PostgreSQL ODBC connection
Driver              = /usr/lib64/psqlodbcw.so
Database            = support
Servername          = 127.0.0.1
UserName            = support
Password            = mysecretpassword
Port                = 5432
```

### odbcinst.ini
```
[PostgreSQL]
Description     = ODBC for PostgreSQL
Driver          = /usr/lib64/psqlodbcw.so
Setup           = /usr/lib64/libodbcpsqlS.so
FileUsage       = 1
```