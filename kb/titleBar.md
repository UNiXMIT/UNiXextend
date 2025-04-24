# Title bar of COBOL program changes style and minimize button stops working
## Environment
All versions of AcuCOBOL-GT  
Windows  

## Situation
When running a COBOL program on the server, while connected via RDP, the style of the title bar of the COBOL program can change and then the minimize button will stop working.  
 
## Resolution
This is caused because of the combination of using the RDP connection and having WIN32-NATIVECTLS disabled (set to FALSE).  

There are 2 solutions:  

1. In the runtime configuration file set the following variable:  

    ```
    WIN32-NATIVECTLS TRUE
    ```

2. Instead of connecting to the server via RDP and then running the COBOL program, run the program remotely using AcuConnect Thin Client. More information about AcuConnect Thin Client can be found here - https://www.rocketsoftware.com/sites/default/files/resource_files/acuconnect.pdf  