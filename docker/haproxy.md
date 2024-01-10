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

### Example haproxy.cfg
```
global
    log /dev/log    local0
    log /dev/log    local1 notice
    chroot /var/lib/haproxy
    stats socket /run/haproxy/admin.sock mode 660 level admin expose-fd listeners
    stats timeout 30s
    user haproxy
    group haproxy
    daemon

defaults
    log     global
    mode    http
    option  httplog
    option  dontlognull
    timeout connect 5000
    timeout client  50000
    timeout server  50000

frontend http_front
   bind *:80
   stats uri /haproxy?stats
   default_backend http_back

backend http_back
   balance roundrobin
   stick-table type ip size 200k expire 30m
   stick on src
   server server1 10.0.0.1:3000 check
   server server2 10.0.0.2:3000 check
```