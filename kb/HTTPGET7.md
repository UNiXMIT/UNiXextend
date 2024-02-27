# HTTPGET status code 7 (unable to connect) occurs for one user only
## Environment
All versions of AcuCOBOL-GT extend  
All Platforms  

## Situation
On only one users machine, HTTPGET fails with response status 7 (unable to connect).  
The same issue occurs when using CURL directly, but more information is returned about the issue - 'curl: (60) SSL certificate problem: unable to get local issuer certificate'  
Testing the same URL in a browser works OK.  
Why does this issue occur in RMNET and CURL but not in a browser, and why does it only happen on one users machine?  

## Resolution
The issue is with the client verifying the authenticity of the server. This is usually caused by an old or missing CA (certificate authority) certificate on the client machine.  

Browsers and most OS ship with a list of trusted CAs. These pre-installed certificates serve as trust anchors to derive all further trust from. When visiting a HTTPS website, your browser verifies that the trust chain presented by the server during the TLS handshake ends at one of the locally trusted root certificates.  

It might be that the CAs on the users OS are not up to date but the browsers CA cert is up to date.  

Rather than rely on the clients CAs, it is possible to download and use an up to date CA and specify that CA be used instead, using NetSetSSLCA.  
This function is used to specify a file containing one, or more, certificates of public Certificate Authorities. The certificates must be in PEM format.   

Usage:  

```
CALL "NetSetSSLCA" USING public-ca-file
                   GIVING status-code.
```

Where public-ca-file is an alphanumeric item specifying the location of a file containing accepted public certificate authorities.  
Using this function allows greater control over what CA Certificates are used with RMNET, rather than relying on what the client already has installed.  