# How to enable AcuToWeb Desktop auto-start at Windows login, from a script?
## Environment
AcuToWeb  
Windows  

## Situation
When silently installing AcuToWeb using the .msi installer, there is no option to tell the installer to start AcuToWeb Desktop and set auto-start of ATW Desktop at Windows login. How can the auto-start of ATW Desktop be enabled when installing ATW?  

## Resolution
The silent installation of ATW can be executed from a script. Later in the same script, ATW Desktop auto-start can be enabled by modifying the registry:  

```
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "AcuToWeb Desktop" /t REG_SZ /d "C:\Program Files (x86)\Micro Focus\extend 10.5.0\ACUTOWEBDESKTOP\ATWDesktop.exe" /f
```

Ensure the path to ATWDesktop.exe in the command is correct for the version and location on the target machine.  

**NOTE:** Before modifying the registry, it is recommended to take a backup of it first.   