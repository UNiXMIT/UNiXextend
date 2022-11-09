# Using the Fixed Version WebView2 runtime

1. Download the Fixed Version of the WebView2 Runtime from Download the WebView2 Runtime, as a package.  

2. Decompress the WebView2 Runtime package using the command-line command expand {path to the package} -F:* {path to the destination folder} or by using a decompression tool such as WinRAR. Avoid decompressing through File Explorer, because that approach might not generate the correct folder structure.  

3. Configure the location of the browser executable folder.  
   This policy configures WebView2 applications to use the WebView2 Runtime in the specified path. The folder should contain the following files: msedgewebview2.exe, msedge.dll, and so on.

   To set the value for the folder path, provide a Value name and Value pair. Set value name to the Application User Model ID or the executable file name. You can use the "*" wildcard as value name to apply to all applications.

   ```
   reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge\WebView2\BrowserExecutableFolder" /v * /t REG_SZ /d "C:\Microsoft.WebView2.FixedVersionRuntime.107.0.1418.35.x86" /f
   ```

Sources:  
https://learn.microsoft.com/en-us/microsoft-edge/webview2/concepts/distribution    
https://learn.microsoft.com/en-us/deployedge/microsoft-edge-webview-policies  