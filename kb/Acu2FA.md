# Can you enable Two-Factor Authentication (2FA) for AcuCOBOL Services?
## Environment
AcuCOBOL-GT extend  
Windows  
Linux/UNIX  

## Situation
Is it possible to enable Two-Factor Authentication (2FA) for AcuCOBOL services like AcuToWeb or AcuConnect?  

## Resolution
RMNET allows you to send and receive web requests/responses. This allows a COBOL program to connect with a 2FA Web API.  

Micro Focus 2FA solution is called [NetIQ](https://www.microfocus.com/en-us/cyberres/identity-access-management). This is a separate product to AcuCOBOL. For more information about NetIQ, please contact a Micro Focus Account Manager.  

More information about RMNET can be found in the documentation at:  
ACUCOBOL-GT Version 10.x.y Documentation Set > Appendices > Appendix I. Library Routines > General Syntax and Library List > RMNet Routines  

A useful RMNET tutorial can be found at:  
extend Programming Guides> A Guide to Interoperating with ACUCOBOL-GT Version 10.x.y > Working with Non-Vision Data > Working with Web Site and Web Service Data > Tutorial: Using RMNet to Exchange Data Between Your Program and a Web Server  