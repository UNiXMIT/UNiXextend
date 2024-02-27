# AcuXDBC error ‘DLLLOAD: xvision, the specified procedure could not be found’ when using Excel
## Environment
All versions of AcuCOBOL-GT extend  
Windows  

## Situation
When using AcuXDBC and accessing the data through a DSN in Excel, it returns the error:  

```
DLLLOAD: xvision, the specified procedure could not be found  
```

PATH and GENESIS_HOME are set correctly and using odbcsql.bat directly on the command line works correctly.  
 
## Resolution
It may be that an incorrect DLL is being found and loaded, causing the error to occur.  

This can be checked using Procmon to generate a log, showing what DLLs are loaded and where from.  

In most cases by checking the log it could be seen that MSQRY32.exe (Microsoft query tool) was checking for zlib.dll in C:\Windows\SysWOW64\ BEFORE the Acu bin directory.  

If an incorrect or very old zlib.dll is located in the SysWOW64 directory then that would be loaded instead of the DLL in the Acu bin directory. Then the error would occur.  

It is unsure where the additional DLL originated from so it’s not recommended to delete it. Instead backup then move or rename the DLL and then AcuXDBC will work correctly again without error.  