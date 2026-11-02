# Set ssl_CAcertstore to stop silent AcuXDBC TLS failures
## Environment
AcuXDBC  
Windows  
Linux/UNIX  

## Symptoms
An AcuXDBC client connects to an AcuXDBC Server configured for TLS, but the client's net.ini does not set `ssl_CAcertstore`. If any part of the AcuXDBC Server TLS configuration is incorrect (for example, a missing or wrong CA certificate), the connection can fail silently instead of reporting an error.  

## Solution
Always set `ssl_CAcertstore` to `cert_store` in the net.ini file on every AcuXDBC client, when AcuXDBC Server is configured for TLS:  

```
ssl                 yes
ssl_protocol        1.3
ssl_CAcertstore     cert_store
```

Without `ssl_CAcertstore cert_store`, a TLS misconfiguration may not produce an error and the client may not verify the server certificate. A client that does not verify the server certificate is open to a man-in-the-middle (MITM) attack, because it cannot confirm that it is talking to the genuine AcuXDBC Server.  

With `ssl_CAcertstore cert_store` set, the client always validates the server certificate against the CA certificates in the system certificate store (OpenSSL on Linux, SChannel on Windows). If something is misconfigured, the connection fails with an error and the problem must be fixed before the connection will work. An insecure connection is never established silently.  