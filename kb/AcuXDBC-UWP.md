# Windows Store (UWP) applications do not connect to AcuXDBC
## Environment
All versions of AcuXDBC  
Windows  

## Situation
Excel and Power BI, downloaded from the Windows Store, do not connect to AcuXDBC. They give an error, even when the PATH and GENESIS_HOME variables are set correctly:  

```
DLLLOAD: acuxdbc04, The specified module could not be found.
```
 
## Resolution

Windows Store apps (UWP: Universal Windows Platform) run in an AppContainer security context. "Win32 desktop apps" on Windows Vista or later run as "Standard User" or as "Administrator". UWP apps have less access rights than "Standard User" and can never run as "Administrator".  

UWP apps can request additional capabilities to get a few more rights with permission from the user but have limited access to the system and user data. For example, they cannot read most of the file system, only the installed location, an isolated application data folder, and an isolated temporary file folder. See [File access and permissions (Windows Runtime apps)](https://learn.microsoft.com/en-us/previous-versions/windows/apps/hh967755(v=win.10)?redirectedfrom=MSDN)   

This means that even if the bin directory is set on the PATH, so that the AcuXDBC DLLs can be found, UWP apps do not check locations set on the PATH and cannot load the DLLs.  

#### SOLUTION 1 – Use a non-UWP version of the application.  

This is the recommended solution. Download the non-UWP version of the application. Power BI and Excel both has such versions that work with AcuXDBC. This way future upgrades of AcuXDBC will not require management of DLLs in multiple locations for multiple versions.  

#### SOLUTION 2 – Move the AcuXDBC DLLs to a location accessible to UWP apps.  

The AcuXDBC DLLs can be moved into a location that UWP apps have access to.  

For example, for the 64-bit version of AcuXDBC, the DLLs can be copied into C:\Windows\System32  

Alternatively, for the 32-bit version of AcuXDBC, the DLLs can be copied into C:\Windows\SysWOW64  

**NOTE:** Solution 2 could cause issues if running multiple versions of AcuXDBC on the server and also require management of the DLLs in other locations when you upgrade AcuXDBC.  