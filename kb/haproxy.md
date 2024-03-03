# How to configure HAProxy as a reverse proxy for AcuToWeb
## Environment
AcuToWeb    
Linux/UNIX  

## Situation
How can HAProxy be configured as a reverse proxy for AcuToWeb?  

## Resolution
Here are some example configurations to configure HAProxy as a reverse proxy for AcuToWeb;

HAProxy passing requests from port 80:  
```
global
    daemon
    maxconn 256

defaults
    mode http
    timeout connect 5000ms
    timeout client 50000ms
    timeout server 50000ms

frontend all_traffic
    bind *:80
    http-request set-header X-Forwarded-Proto http
    
    acl is_websocket path_beg -i /websocket
    
    use_backend websocket_backend if is_websocket
    use_backend app_backend

backend app_backend
    http-request set-header Host %[hdr(host)]
    server app_server 127.0.0.1:3000

backend websocket_backend
    http-request set-header Host %[hdr(host)]
    server websocket_server 127.0.0.1:8000
```

HAProxy secured with SSL, passing requests from port 443: 
```
global
    daemon
    maxconn 256

defaults
    mode http
    timeout connect 5000ms
    timeout client 50000ms
    timeout server 50000ms

frontend all_traffic
    bind *:443 ssl crt /path/to/ssl/certificate.pem key /path/to/ssl/private.key
    http-request set-header X-Forwarded-Proto https
    
    acl is_websocket path_beg -i /websocket
    
    use_backend websocket_backend if is_websocket
    use_backend app_backend

backend app_backend
    http-request set-header Host %[hdr(host)]
    server app_server 127.0.0.1:3000

backend websocket_backend
    http-request set-header Host %[hdr(host)]
    server websocket_server 127.0.0.1:8000
```

HAProxy as a load balancer for multiple instances of AcuToWeb:
```
global
    daemon
    maxconn 256

defaults
    mode http
    timeout connect 5000ms
    timeout client 50000ms
    timeout server 50000ms

frontend all_traffic
    bind *:443 ssl crt /path/to/ssl/certificate.pem key /path/to/ssl/private.key
    http-request set-header X-Forwarded-Proto https
    
    acl is_websocket path_beg -i /websocket
    
    use_backend websocket_backend if is_websocket
    use_backend app_backend

backend app_backend
    balance source hash-type consistent
    http-request set-header Host %[hdr(host)]
    server app_server1 server1:3000 check
    server app_server2 server2:3001 check

backend websocket_backend
    balance source hash-type consistent
    http-request set-header Host %[hdr(host)]
    server websocket_server1 server1:8000 check
    server websocket_server2 server2:8001 check
```

HAProxy configured to dynamically proxy a short URL i.e.  
```
https://domain.com/?id=tour  
```
proxies to  
```
https://domain.com/?portgw=443&alias=tour&theme=tour  
```
```
global
    daemon
    maxconn 256

defaults
    mode http
    timeout connect 5000ms
    timeout client 50000ms
    timeout server 50000ms

frontend all_traffic
    bind *:443 ssl crt /path/to/ssl/certificate.pem key /path/to/ssl/private.key
    http-request set-header X-Forwarded-Proto https
    
    acl is_websocket path_beg -i /websocket
    
    acl is_short_url path_beg -i /?id=
    http-request set-path %[path]?portgw=443&alias=%[query]&theme=%[query] if is_short_url
    
    use_backend websocket_backend if is_websocket
    use_backend app_backend

backend app_backend
    http-request set-header Host %[hdr(host)]
    server app_server 127.0.0.1:3000

backend websocket_backend
    http-request set-header Host %[hdr(host)]
    server websocket_server 127.0.0.1:8000
```

**IMPORTANT:** With these configurations, the AcuToWeb Gateway is hidden behind HAProxy and it is only reachable via the port bound in HAProxy; therefore, it is mandatory to use the portgw parameter to override the gateway configuration; for example:  

```
https://domain.com/?portgw=443
```