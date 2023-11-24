# MYSQL

### Pull and Run container
```
podman pull container-registry.oracle.com/mysql/community-server:latest
podman run --name=mysql -p 3306:3306 -d container-registry.oracle.com/mysql/community-server:latest
```

### Root password
```
podman logs mysql 2>&1 | grep GENERATED
```

### Attach to container
```
podman exec -it mysql mysql -uroot -p
```

### Create user and allow remote access
```
ALTER USER 'root'@'localhost' IDENTIFIED BY 'YourStrongRootPassword';
FLUSH PRIVILEGES;
CREATE USER 'support'@'localhost' IDENTIFIED BY 'YourStrongPassword';
GRANT ALL PRIVILEGES ON *.* TO 'support'@'localhost' WITH GRANT OPTION;
CREATE USER 'support'@'%' IDENTIFIED BY 'YourStrongPassword';
GRANT ALL PRIVILEGES ON *.* TO 'support'@'%' WITH GRANT OPTION;
```

### Remove container
```
podman stop mysql
podman rm mysql
```

### Source
https://bit.ly/44fijqt