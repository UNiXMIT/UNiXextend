# How to configure NGINX as a reverse proxy for AcuToWeb
## Environment
AcuToWeb    
Linux/UNIX  

## Situation
How can NGINX be configured as a reverse proxy for AcuToWeb?  

## Resolution
Here are some example configurations to configure NGINX as a reverse proxy for AcuToWeb;

NGINX passing requests from port 80:  
```
server {
    listen 80;

    location / {
        proxy_set_header X-Real-IP  $remote_addr;
        proxy_set_header X-Forwarded-For $remote_addr;
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_pass http://127.0.0.1:3000;
    }
    
    location /websocket {
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_pass http://127.0.0.1:8000;
    }
}
```

NGINX secured with SSL, passing requests from port 443: 
```
server {
    listen 443 ssl;
    ssl_certificate /config/keys/cert.crt;
    ssl_certificate_key /config/keys/cert.key;

    location / {
        proxy_set_header X-Real-IP  $remote_addr;
        proxy_set_header X-Forwarded-For $remote_addr;
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_pass http://127.0.0.1:3000;
    }

    location /websocket {
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_pass http://127.0.0.1:8000;
    }
}
```

NGINX as a load balancer for multiple instances of AcuToWeb:
```
upstream backend {
    ip_hash;
    server 127.0.0.1:3000;
    server 127.0.0.1:3001;
}

upstream websocket {
    ip_hash;
    server 127.0.0.1:8000;
    server 127.0.0.1:8001;
}

server {
    listen 443 ssl;
    include /config/nginx/ssl.conf;

    location / {
        proxy_set_header X-Real-IP  $remote_addr;
        proxy_set_header X-Forwarded-For $remote_addr;
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_pass http://backend;
    }

    location /websocket {
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_pass http://websocket;
    }
}
```

NGINX configured to dynamically proxy a short URL i.e.  
```
http://domain.com/?id=tour  
```
proxies to  
```
http://domain.com/?portgw=443&alias=tour&theme=tour  
```
```
server {
    listen 443 ssl;
    include /config/nginx/ssl.conf;

    location / {
        if ($args = "/?id=") {
            rewrite ^ $uri?portgw=443&alias=$arg_id&theme=$arg_id break;
        }
        proxy_set_header X-Real-IP  $remote_addr;
        proxy_set_header X-Forwarded-For $remote_addr;
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_pass http://127.0.0.1:3000;
    }

    location /websocket {
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_pass http://127.0.0.1:8000;
    }
}
```

**IMPORTANT:** With these configurations, the AcuToWeb Gateway is hidden behind NGINX and it is only reachable via the port bound in NGINX; therefore, it is mandatory to use the portgw parameter to override the gateway configuration; for example:  

```
https://domain.com/?portgw=443
```