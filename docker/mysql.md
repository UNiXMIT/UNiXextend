# MYSQL

### Pull and Run container
```
podman pull container-registry.oracle.com/mysql/community-server:latest
podman run --name=mysql -p 3306:3306 -e "MYSQL_ROOT_PASSWORD=strongPassword123" -e "MYSQL_DATABASE=support" -e "MYSQL_USER=support" -e "MYSQL_PASSWORD=stropngPassword123" -d container-registry.oracle.com/mysql/community-server:latest
```

### Attach to container
```
podman exec -it mysql mysql -uroot -p
```

### Remove container
```
podman stop mysql
podman rm mysql
```

### Source
https://bit.ly/44fijqt
