# Set ssl_CAcertstore to stop silent AcuXDBC TLS failures
## Environment
AcuXDBC  
Windows  
Linux/UNIX  

## Symptoms
An AcuXDBC client connects to an AcuXDBC Server configured for TLS, but the client's net.ini does not set `ssl_CAcertstore` to `cert_store` or a `CA_PEM_filename`. If any part of the AcuXDBC Server TLS configuration is incorrect (for example, a missing or wrong CA certificate), the connection can fail silently instead of reporting an error.  

## Solution
When AcuXDBC Server is configured for TLS, always set `ssl_CAcertstore` in the net.ini file on every AcuXDBC client. At the very minimum, set it to `cert_store`:  

```
ssl                 yes
ssl_protocol        1.3
ssl_CAcertstore     cert_store
```

Without `ssl_CAcertstore cert_store`, a TLS misconfiguration may not produce an error and the client may not verify the server certificate. A client that does not verify the server certificate is open to a man-in-the-middle (MITM) attack, because it cannot confirm that it is talking to the genuine AcuXDBC Server.  

With `ssl_CAcertstore cert_store` set, the client always validates the server certificate against the CA certificates in the system certificate store (OpenSSL on Linux, SChannel on Windows). If something is misconfigured, the connection fails with an error and the problem must be fixed before the connection will work. An insecure connection is never established silently.  

Alternatively, set `ssl_CAcertstore` to a `CA_PEM_filename` to validate the server certificate against a specific CA certificate file instead of the system certificate store. This restricts trust to that CA only:  

```
ssl                 yes
ssl_protocol        1.3
ssl_CAcertstore     /path/to/root_ca.crt
```  