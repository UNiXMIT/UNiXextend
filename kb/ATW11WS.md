# Websockets in AcuToWeb 11.0.0 unreachable behind a proxy web server
## Environment
AcuToWeb 11.0.0  
Windows  
Linux/UNIX  
NGINX / IIS / Apache Web Servers

## Situation
The 'portgw' and 'hostgw' URL parameters are no longer supported or used in version 11.0.0.  
When attempting to connect to the gateway web server via a proxy using a different port, the client still tries to establish WebSocket connections to the gateway using the original 'webserver_port' defined in the TOML configuration file.  

## Resolution
This is a known issue. A fix will be provided in version 11.0.0 PU 1. Once available, it can be downloaded from the [RCC portal](https://my.rocketsoftware.com/RocketCommunity/s/).