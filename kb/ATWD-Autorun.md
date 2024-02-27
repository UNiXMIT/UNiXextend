# Autorun of AcuToWeb Desktop is broken and fails to start at system startup
## Environment
AcuToWeb Desktop  
Windows  

## Situation
When enabling Autorun via the AcuToWeb Desktop menu and restarting the machine, AcuToWeb Desktop does not start at system boot.  

## Resolution
This is a known issue that will be fixed in 10.5.0. Until then it is possible to fix the issue with a small change to the registry entry that controls Autorun of AcuToWeb Desktop.  

```
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "AcuToWeb Desktop" /t REG_SZ /d "C:\Program Files (x86)\Micro Focus\extend 10.4.1\AcuToWeb\AcuToWeb Desktop\ATWDesktop.exe" /f
```

Make sure the path to ATWDesktop.exe is correct for the location on the client machine.  