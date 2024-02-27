# Program fails to run and the AcuRCL log file shows error 'Failed to create a registry entry for the child runtime: 5'
## Environment
AcuConnect Thin Client  
AcuToWeb  
Windows  
Linux/UNIX  

## Situation
When executing a program through AcuConnect or AcuToWeb, the program fails to launch. The acurcl log file shows:  

```
Failed to create a registry entry for the child runtime: 5
```

## Resolution
The issue is caused by incorrect permissions. Windows error code 5 = Access is denied.  

The user should be a member of whatever group gives it the appropriate permissions to run the application. It may need to be a member of the Administrators group. If so then make sure it is a member of ONLY the Administrators group. When account is a member of multiple groups, Windows sometimes applies the most restrictive permissions.  

AcuRCL creates a registry key, HKLM\Software\Micro Focus\AcuConnect\SocketHandles, which it uses to pass information to the child runtime. If it can't create this registry key, it will halt the child runtime and display the mentioned error in the log.  

For help with generating a log from the acurcl service, see the instructions here - https://portal.microfocus.com/s/article/KM000005044#ThinClient  
The log can help to see which user is being used, on the server, to start the program etc.  