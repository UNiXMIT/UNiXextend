# AcuXDBC Server TLS Setup

AcuXDBC supports TLS on UNIX using OpenSSL whereas AcuXDBC on Windows uses Secure Channel (SChannel) which is part of the Windows operating system.  

AcuXDBC can be configured to use standard TLS or mutual TLS (mTLS). Standard TLS requires a server certificate. mTLS additionally requires a client certificate, so that the server and client each authenticate the other.  

## Certificates
| File | Description |
|------|-------------|
| `root_ca.crt` | Root CA certificate. The trust anchor that signs the intermediate CA. Installed on the client so it can validate the server certificate. Also installed on the server, which verifies its own server certificate against it at startup and, if mTLS is configured, uses it to validate the client certificate. |
| `intermediate_ca.crt` | Intermediate CA certificate. Signs the server and client certificates and links them back to the root CA. |
| `server.crt` / `server.key` | Server certificate and private key. Presented by AcuXDBC Server to prove its identity to the client. |
| `client.crt` / `client.key` | Client certificate and private key. Required only if mTLS is configured. Presented by the client to prove its identity to the server. | 

## Install CA Certificates  
These steps install the CA certificates into the operating system trust store.   
- **Client:** Required, so the client can validate the server certificate against the root CA certificate.  
- **Server:** Required. AcuXDBC Server verifies its own server certificate against the root CA certificate at startup. If mTLS is configured, the root CA certificate is also used to validate client certificates.  

### Windows 
Add a root CA certificate to the Trusted Root Certification Authorities (Root) store.  
```
>certutil -addstore Root C:\certs\root_ca.crt
```

Add an intermediate CA certificate to the Intermediate Certification Authorities (CA) store.  
```
>certutil -addstore CA C:\certs\intermediate_ca.crt
```

On Windows, the server certificate and private key must be combined into a .pfx file. Generate it with OpenSSL (you will be prompted to set an export password):    
```
openssl pkcs12 -export -out server.pfx -inkey server.key -in server.crt -certfile intermediate_ca.crt
```

Import the .pfx into the Personal (MY) store. You will be prompted for the password set above.  
```
>certutil -f -importPFX MY C:\server\server.pfx
```

If mTLS is enabled, the client certificate and key can be combined into a `client.pfx` and imported into the Personal (MY) store on the client machine the same way.  


#### Other Useful Commands
Display a certificate in the Trusted Root Certification Authorities (Root) store.  
```
>certutil -store Root "XDBCServer"
```

Verify the server or client certificate against the CA certificates in the system certificate store.  
```
>certutil -verify [server.crt|client.crt]
...
CertUtil: -verify command completed successfully.
```

### Linux
Install the root CA certificate into the operating system trust store using the distribution's own method. OpenSSL's default CA locations point to this store, and the CA is also trusted by other applications on the system.  

RHEL, Rocky, Fedora:  
```
$ sudo cp root_ca.crt /etc/pki/ca-trust/source/anchors/
$ sudo update-ca-trust
```

Debian, Ubuntu (the file must have a `.crt` extension):  
```
$ sudo cp root_ca.crt /usr/local/share/ca-certificates/
$ sudo update-ca-certificates
```

#### Other Useful Commands
Verify the server or client certificate against CA certificates in the system certificate store.  
```
$ openssl verify -untrusted intermediate_ca.crt [server.crt|client.crt] 
server.crt: OK    # Example output; the result depends on the certificate
```

> **NOTE**: SSL_CERT_DIR and SSL_CERT_FILE can be used to modify the system defined CA certificate location and filename. Applies only to OpenSSL. 

## Setup
```
-e ServerCertificate [CA_PEM_filename|cert_store] [invcertok] [TLS-level]
```

The options fall into three groups:  
- **ServerCertificate**: required. Enables standard TLS.  
- **[CA_PEM_filename|cert_store]**: optional. Specify one or the other, not both. Enables mTLS.  
- **[invcertok] [TLS-level]**: optional. Relaxes certificate checking and sets the minimum TLS level.  

### ServerCertificate (required)
- **PEM filename**  
    Server certificate and private key combined in PEM format. The PEM file may contain either a PRIVATE KEY or RSA PRIVATE KEY block.  

    > **NOTE**: If the PEM file does not contain a PRIVATE KEY or RSA PRIVATE KEY block, the corresponding <filename>key.pem file in the same directory is used as the private key.  
    > The key file name is derived from the certificate name by replacing its suffix with “key.pem”. For example, if "myserver.crt" has no embedded key, AcuXDBC looks for "mycertkey.pem" in the same directory. An error is returned if that key file is missing or contains no valid key.  
    > AcuXDBC does not support pass phrase encoded key files.  

#### Windows (SChannel) Only ServerCertificate Methods
- **StoreName\Path\[CommonName|Thumbprint]**  
    Any valid Windows certificate store name (for example, `LocalMachine`, `CurrentUser`, or `Users`) followed by a valid store path (for example `MY`).  
    Examples: 
    ```
    LocalMachine\MY\XDBCServer  
    LocalMachine\MY\d7890d96a266ad39d347aa991e17a2875ecf8175  
    ```

### Client Certificate Validation - mTLS [optional]
Specify one of the following to enable mTLS. The server then requires a client certificate and validates it against the specified CA certificates.  

- **CA_PEM_filename**  
    CA certificate used to verify the client certificate.  

- **cert_store**  
    The `cert_store` keyword tells AcuXDBC Server to validate the client certificate using the CA certificates in the system certificate store — the OpenSSL store on Linux or the SChannel store on Windows.  

### Other Options [optional]
- **invcertok**  
    Allow invalid certificates (for example, expired certificates), which eliminates the need to create a new certificate each time, and also enables users to use self-signed certificates. Insecure in production environments.  

- **TLS-Level**  
    The minimum TLS level AcuXDBC Server will accept. Values are 1.2 & 1.3  
    The default minimum is 1.2  

### Examples
#### Standard TLS
Server certificate only. Clients are not required to present a certificate.  
```
xdbcsrvr -p20222 -e server.crt
```

Same as above, but only TLS 1.3 connections are accepted.  
```
xdbcsrvr -p20222 -e server.crt 1.3
```

Allow an invalid server certificate, such as a self-signed or expired certificate. For testing only.  
```
xdbcsrvr -p20222 -e server.crt invcertok
```

#### mTLS
Require a client certificate and validate it against `root_ca.crt`. Only TLS 1.3 is accepted.  
```
xdbcsrvr -p20222 -e server.crt root_ca.crt 1.3
```

Require a client certificate and validate it against the CA certificates in the OS certificate store (OpenSSL on Linux, SChannel on Windows).  
```
xdbcsrvr -p20222 -e server.crt cert_store
```

#### Windows (SChannel) certificate store
Use the server certificate named `XDBCServer` from the `LocalMachine\MY` store instead of a PEM file.  
```
xdbcsrvr -p20222 -e LocalMachine\MY\XDBCServer
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

- **ssl_CAcertstore** 
    Default: `cert_store`. System-defined CA certificate store. The specified CA certificate trust store will be used to validate the server certificate. The certificates must be in PEM format.  
    On Windows, only `cert_store` or `CA_PEM_filename` may be specified.  

- **ssl_certfile** 
    Used to specify the client certificate when mTLS is enabled in AcuXDBC Server. The certificates must be in PEM format.  
    On Windows, only `Storename\Path\[CommonName|Thumbprint]` may be specified.  

- **ssl_protocol**  
    Default: all TLS protocol levels are accepted. Comma-separated list of accepted TLS protocol levels. The supported levels are `1.2` and `1.3`. The order is not important.  

#### Example net.ini for a TLS-configured AcuXDBC Server
```
ssl                 yes
ssl_protocol        1.2,1.3
ssl_CAcertstore     cert_store
```