# AcuXDBCS TLS Setup

## Verify Certificate and Key against CA Chain

This command uses `fullchain_ca.crt` as the trusted CA chain to validate `cert.pem`. It confirms the server certificate was signed by a trusted CA and that the full chain of trust resolves. A response of `cert.pem: OK` means verification succeeded; any other output indicates a broken or incomplete chain.
```
$ openssl verify -CAfile fullchain_ca.crt cert.pem 
cert.pem: OK
```

## Setup
```
-e certificate CA|cert_store [protocol[,protocol[,,,]]]
```
**cert.pem** - Certificate and private key combined in PEM format. The PEM file may contain either a PRIVATE KEY or RSA PRIVATE KEY block.    
**fullchain_ca.crt** - CA certificate used to verify the server certificate. (Not required when using invcertok to skip certificate verification, or cert_store, since the CA certificate is already in your OS certificate store.)
**cert_store** - To validate an incoming client certificate, look for CA certificates in the Trusted Root CA's in the OS Certificate Store. 

> Note: If the PEM file does not contain a PRIVATE KEY or RSA PRIVATE KEY block, the corresponding <filename>key.pem file in the same directory is used as the private key.  

### Protocols
**TLS Levels** - The accepted incoming TLS level or levels in the form of a comma-delimited list. Accepted TLS levels are 1.0 through 1.3. For example, 1.2,1.3 means only TLS levels 1.2 and 1.3 are accepted from clients. 1.3 only, means only TLS level 1.3 is accepted.  
**invcertok** - Allow invalid certificates, which eliminates the need to create a new certificate each time, and also enables users to use self-signed certificates. Insecure in production environments.  
 

### Examples
```
acuxdbcs.sh -start -p20222 -e cert.pem fullchain_ca.crt 1.1,1.2
acuxdbcs.sh -start -p20222 -e cert_store 1.1
acuxdbcs.sh -start -p20222 -e cert.pem invcertok,1.1
```

### Clients
**net.ini** - is where you define client-side settings for your network configuration. On the client machine, you must set the GENESIS_HOME and VORTEX_HOME environment variable to point to the product install directory i.e.  
Windows - `%ProgramFiles(x86)%\Rocket Software\extend 11.0.0\AcuGT`  
Linux - `/home/products/acu1100shx64`  
AcuXDBC looks for net.ini in the lib subdirectory of the specified path. For example, `%VORTEX_HOME%\lib` or `$VORTEX_HOME/lib`.  

Use the net.ini to configure TLS on the client side:
```
ssl                 yes
ssl_CAcertstore     /etc/certs/crt.txt
ssl_certfile        /etc/certs/fullchain_ca.crt
ssl_protocol        1.1,1.2
```

**ssl** - Default: `no`. If `yes`, then the client requires SSL communication with the server. If `no` and the server requires SSL, then the client will also use SSL.  
**ssl_CAcertstore** - Default: System-defined CA certificate store. The specified CA certificate trust store will be used to validate the server certificate. The certificates must be in PEM format.  
**ssl_certfile** - The specified CA certificate will be used to validate the server certificate. The certificates must be in PEM format.  
**ssl_protocol** - Default: all TLS protocol levels are accepted. Comma-separated list of accepted TLS protocol levels. The supported levels are `1.1`, `1.2`, `1.3`. The order is not important.  