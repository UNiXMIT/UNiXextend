# Configuration variable WIN32_BROWSER2_FOLDER does not work
## Environment
AcuCOBOL-GT extend from 10.5.0 onward  
Windows    

## Situation
The configuration variable WIN32_BROWSER2_FOLDER was introduced in 10.5.0 but it does not work. Even when it is set correctly, to point to a directory holding the Web browser control DLLs, it does not use that version of WebView2.  

## Resolution
This is a known issue and will be fixed in a future release.    
A workaround is to set the 'WebView2\BrowserExecutableFolder' registry key to the location of the standalone WebView2 binaries directory and removing WIN32_BROWSER2_FOLDER from the runtime configuration file:  

```
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge\WebView2\BrowserExecutableFolder" /v * /t REG_SZ /d "C:\temp\Microsoft.WebView2.FixedVersionRuntime.122.0.2365.80.x86" /f
```

## Additional Information
More information can be found in the documentation:   
ACUCOBOL-GT Version x.y.z Documentation Set > Appendices > Appendix H. Configuration Variables > Configuration Variables > WIN32_BROWSER2_FOLDER

The AcuCOBOL Documentation and Resources are available here:  
https://www.microfocus.com/en-us/support/ACUCOBOL-GT%20(Extend)  