#!/bin/bash
# Generate a private key and self-signed certificate for localhost
openssl req -x509 -out server.crt -keyout server.key \
  -newkey rsa:2048 -nodes -sha256 \
  -subj '/CN=localhost' -extensions EXT -config <( \
   printf "[dn]\nCN=localhost\n[req]\ndistinguished_name = dn\n[EXT]\nsubjectAltName=DNS:localhost\nkeyUsage=digitalSignature\nextendedKeyUsage=serverAuth")
 
# Import the Certificate on Windows
## 2 Options:

### PowerShell
### Import-Certificate -FilePath "C:\server.crt" -CertStoreLocation Cert:\CurrentUser\Root

### certutil - https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/certutil
### certutil.exe -addstore root c:\server.crt