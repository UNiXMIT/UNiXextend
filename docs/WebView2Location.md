# Configure the location of the browser executable folder

This policy configures WebView2 applications to use the WebView2 Runtime in the specified path. The folder should contain the following files: msedgewebview2.exe, msedge.dll, and so on.  

To set the value for the folder path, provide a Value name and Value pair. Set value name to the Application User Model ID or the executable file name. You can use the "*" wildcard as value name to apply to all applications.  

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge\WebView2\BrowserExecutableFolder" /v wrun32.exe /t REG_SZ /d "C:\PathToThe\WebView2Directory" /f

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Edge\WebView2\BrowserExecutableFolder" /v wrun32.exe /t REG_SZ /d "C:\PathToThe\WebView2Directory" /f