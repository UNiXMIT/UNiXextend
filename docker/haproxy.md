# HAProxy
### Pull and Run container
```
podman pull haproxy:latest
podman run -d --name haproxy -v /home/support/haproxy:/usr/local/etc/haproxy:ro --sysctl net.ipv4.ip_unprivileged_port_start=0 -p 8080:80 haproxy:latest
```
**NOTE:** Your host's /home/support/haproxy directory should be populated with a file named haproxy.cfg  

### Attach to container
```
podman exec -it haproxy bash
```

### Reload Config
```
podman kill -s HUP haproxy
```

### Remove container
```
podman stop haproxy
podman rm haproxy
```

### HAProxy Config
Please refer to upstream's excellent (and comprehensive) documentation on the subject of configuring HAProxy for your needs - [https://docs.haproxy.org/](https://docs.haproxy.org/)  

### Source
[https://bit.ly/48OLcLm](https://bit.ly/48OLcLm)  