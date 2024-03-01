# How to configure Apache as a reverse proxy for AcuToWeb
## Environment
AcuToWeb    
Linux/UNIX  

## Situation
How can Apache be configured as a reverse proxy for AcuToWeb?  

## Resolution
Here are some example configurations to configure Apache as a reverse proxy for AcuToWeb;

Apache passing requests from port 80:  
```
Listen 80

<VirtualHost *:80>
    ProxyPreserveHost On
    ProxyPass / http://127.0.0.1:3000/
    ProxyPassReverse / http://127.0.0.1:3000/

    <Location /websocket>
        ProxyPass ws://127.0.0.1:8000/
        ProxyPassReverse ws://127.0.0.1:8000/
    </Location>
</VirtualHost>
```

Apache secured with SSL, passing requests from port 443: 
```
Listen 443 https

<VirtualHost *:443>
    ProxyPreserveHost On
    ProxyPass / http://127.0.0.1:3000/
    ProxyPassReverse / http://127.0.0.1:3000/

    <Location /websocket>
        ProxyPass ws://127.0.0.1:8000/
        ProxyPassReverse ws://127.0.0.1:8000/
    </Location>

    SSLProxyEngine On
    SSLCertificateChainFile "/usr/local/apache2/conf/ssl.crt/ca.crt"
    SSLCertificateKeyFile "/usr/local/apache2/conf/ssl.key/server.key"
</VirtualHost>
```

Apache configured to dynamically proxy a short URL i.e.  
```
https://domain.com/?id=tour  
```
proxies to  
```
https://domain.com/?portgw=443&alias=tour&theme=tour  
```
```
Listen 443 https

<VirtualHost *:443>
    ProxyPreserveHost On
    RewriteEngine On
    RewriteCond %{QUERY_STRING} ^id=([A-Za-z0-9-]+)$
    RewriteRule / http://127.0.0.1:3000/?portgw=443&alias=%1&theme=%1 [P]
    ProxyPass / http://127.0.0.1:3000/
    ProxyPassReverse / http://127.0.0.1:3000/

    <Location /websocket>
        ProxyPass ws://127.0.0.1:8000/
        ProxyPassReverse ws://127.0.0.1:8000/
    </Location>

    SSLProxyEngine On
    SSLCertificateChainFile "/usr/local/apache2/conf/ssl.crt/ca.crt"
    SSLCertificateKeyFile "/usr/local/apache2/conf/ssl.key/server.key"
</VirtualHost>
```

**IMPORTANT:** With these configurations, the AcuToWeb Gateway is hidden behind Apache and it is only reachable via the port bound in Apache; therefore, it is mandatory to use the portgw parameter to override the gateway configuration; for example:  

```
https://domain.com/?portgw=443
```