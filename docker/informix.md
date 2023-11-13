# Informix
#### Pull and Run container
```
podman pull ibmcom/informix-developer-database:latest
podman run -d -it --name informix -h informix --privileged -p 9088:9088 -e LICENSE=accept ibmcom/informix-developer-database:latest
```

### Attach to container
```
podman exec -it informix bash
```

### Container Details
```
Username: informix
Password: in4mix
```

### Remove container
```
podman stop informix
podman rm informix
```

### Commandline utility
```
dbaccess
```

### Ports
9088 - TCP
9089 - DRDA
27017 - Mongo
27018 - REST
27883 - MQTT

### Informix CSDK
```
podman pull ibmcom/informix-developer-sandbox
podman run -d -it --name IFX -h IFX --privileged -e LICENSE=accept ibmcom/informix-developer-sandbox
podman cp IFX:/home/informix /home/
export informix_OPT=/home/informix/odbc
. setenvacu.sh informix
sudo mkdir -p /usr/informix/lib/esql
sudo ln -s /home/informix/odbc/lib/esql/checkapi.o /usr/informix/lib/esql
```

### sqlhosts
informix        onsoctcp        localhost         9088  

### Source
https://dockr.ly/2BWRpaH
