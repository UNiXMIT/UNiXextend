# AcuXDBC Server TLS Setup

AcuXDBC supports TLS on Unix using OpenSSL whereas AcuXDBC on Windows uses Secure Channel (SChannel) which is part of the Windows operating system.  

AcuXDBC uses mutual TLS (mTLS), so both a server certificate and a client certificate are required.  


## Verify Certificate against CA Chain
These commands verify that a server certificate (server.crt) chains up to a trusted CA, using either the Windows certificate store (certutil) or a CA trust directory (openssl). It confirms the server certificate was signed by a trusted CA and that the full chain of trust resolves. 

## Certificates Required
The certificates in this document are issued by a private CA (for example, smallstep) with a root and intermediate CA.  

| File | Description |
|------|-------------|
| `root_ca.crt` | Root CA certificate. The trust anchor that signs the intermediate CA. Installed on both the server and the client so each can validate the other's certificate. |
| `intermediate_ca.crt` | Intermediate CA certificate. Signs the server and client certificates and links them back to the root CA. |
| `server.crt` / `server.key` | Server certificate and private key. Presented by `xdbcsrvr` to prove its identity to the client. |
| `client.crt` / `client.key` | Client certificate and private key. Presented by the client to prove its identity to the server (mTLS). |

### Windows 
> **NOTE**: These steps are only applicable if you are using the OS certificate store (for example, `LocalMachine\Root\XDBCServer`) rather than PEM files directly.  

Add a root CA certificate to the Trusted Root Certification Authorities (Root) store.  
```
>certutil -addstore Root C:\certs\root_ca.crt
```

Add an intermediate CA certificate to the Intermediate Certification Authorities (CA) store.  
```
>certutil -addstore CA C:\certs\intermediate_ca.crt
```

Display a certificate in the Trusted Root Certification Authorities (Root) store.  
```
>certutil -store Root "XDBCServer"
```

Once the root CA Certificate is in Root and the intermediate certificate in CA, just point at the server certificate.  
```
>certutil -verify server.crt
...
CertUtil: -verify command completed successfully.
```

### Linux
Determine the OpenSSL trust directory. Common locations include `/etc/pki/tls/certs` and `/etc/ssl/certs`.  
```
$ OPENSSLDIR=$(openssl version -d | cut -d'"' -f2)/certs
```

Copy the trusted CA certificate into the default trust directory.  
```
$ sudo cp /home/support/root_ca.crt $OPENSSLDIR
```

Run openssl rehash to create the required symbolic links.  
```
$ sudo openssl rehash -v $OPENSSLDIR
link root_ca.crt -> f54a4c0c.0   # Example output; the hash will vary
```

Verify the certificate with -CApath.  
```
$ openssl verify -CApath $OPENSSLDIR -untrusted intermediate_ca.crt server.crt
server.crt: OK    # Example output; the result depends on the certificate
```

> **NOTE**: SSL_CERT_DIR and SSL_CERT_FILE can be used to modify the system defined CAcertificate location and filename. Applies only to OpenSSL.  

## Setup
```
-e ServerCertificate [ CA PEM filename | certstore ] [invcertok] [TLS-level]
```

### ServerCertificate Methods
- **PEM filename**  
    Certificate and private key combined in PEM format. The PEM file may contain either a PRIVATE KEY or RSA PRIVATE KEY block.  

    > **NOTE**: If the PEM file does not contain a PRIVATE KEY or RSA PRIVATE KEY block, the corresponding <filename>key.pem file in the same directory is used as the private key.  
    > The key file name is derived from the certificate name by replacing its suffix with “key.pem”. For example, if "myserver.crt" has no embedded key, AcuXDBC looks for "mycertkey.pem" in the same directory. An error is returned if that key file is missing or contains no valid key.  
    > AcuXDBC does not support pass phrase encoded key files.  

### Windows (SChannel) Only ServerCertificate Methods
- **StoreName\Path\[CommonName|Thumbprint]**  
    Any valid Windows certificate store name (for example, `LocalMachine`, `CurrentUser`, or `Users`) followed by a valid store path (for example `MY`).  
    Examples: 
    ```
    LocalMachine\Root\XDBCServer  
    LocalMachine\Root\d7890d96a266ad39d347aa991e17a2875ecf8175  
    ```

- **LocalHost**  
    The `LocalHost` keyword tells AcuXDBC server to search `LocalMachine\MY` for any valid certificate that has Server Authentication usage and an IP address or DNS name matching the server.  

### Other Options [optional]
- **CA PEM filename**  
    CA certificate used to verify the server certificate. (Not required when using invcertok to skip certificate verification, or cert_store, since the CA certificate is already in your OS certificate store.)  

- **cert_store**  
    The `cert_store` keyword tells AcuXDBC Server to validate the client using the CA certificates in the system certificate store — the OpenSSL store on Linux or the SChannel store on Windows.  

- **invcertok**  
    Allow invalid certificates (for example, expired certificates), which eliminates the need to create a new certificate each time, and also enables users to use self-signed certificates. Insecure in production environments.  

- **TLS-Level**  
    The minimum TLS level AcuXDBC Server will accept. Values are 1.2 & 1.3  
    The default minimum is 1.2  

### Examples
```
xdbcsrvr -p20222 -e server.crt root_ca.crt 1.3
xdbcsrvr -p20222 -e server.crt cert_store
xdbcsrvr -p20222 -e server.crt invcertok
```

### Clients
#### net.ini
This file is where client-side settings are defined for the network configuration. On the client machine, GENESIS_HOME and VORTEX_HOME environment variable must be set to point to the product install directory i.e.  
Windows - `%ProgramFiles(x86)%\Rocket Software\extend 11.0.0\AcuGT`  
Linux - `/home/products/acu1100shx64`  
AcuXDBC looks for net.ini in the lib subdirectory of the specified path. For example, `%VORTEX_HOME%\lib` or `$VORTEX_HOME/lib`.  

#### net.ini options
- **ssl**  
    Default: `no`. If `yes`, then the client requires TLS communication with the server. If `no` and the server requires TLS, then the client will also use TLS.  

- **ssl_CAcertstore** (Windows SChannel)
    Default: System-defined CA certificate store. The specified CA certificate trust store will be used to validate the server certificate. The certificates must be in PEM format.  
    Only `Storename\Path\[CommonName | Thumbprint]` may be specified.  

- **ssl_certfile**
    The specified CA certificate will be used to validate the server certificate. The certificates must be in PEM format.  

- **ssl_protocol**  
    Default: all TLS protocol levels are accepted. Comma-separated list of accepted TLS protocol levels. The supported levels are `1.2` and `1.3`. The order is not important.  

#### Example net.ini for a TLS-configured AcuXDBC Server
```
ssl                 yes
ssl_protocol        1.2,1.3
ssl_certfile        /etc/certs/root_ca.crt
```