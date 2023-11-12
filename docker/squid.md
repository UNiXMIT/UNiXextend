# Squid

### Pull and Run container
```
podman pull ubuntu/squid:5.2-22.04_beta
podman run -d --name squid -e TZ=UTC -p 3128:3128 ubuntu/squid:5.2-22.04_beta
```

### Attach to container
```
podman exec -it squid bash
```

### Allow SSH/SFTP Connections
```
podman exec -it squid bash -c "echo acl SSL_ports port 22 >> /etc/squid/squid.conf"
podman exec -it squid bash -c "echo acl Safe_ports port 22 >> /etc/squid/squid.conf"
podman restart squid
```

### Remove your container
```
podman stop squid
podman rm squid
```

### Source
https://hub.docker.com/r/ubuntu/squid