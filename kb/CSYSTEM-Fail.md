# C$SYSTEM fails to locate msg.exe in C:\Windows\System32 using the 32 bit runtime
## Environment
AcuCOBOL-GT extend  
Windows  

## Situation
When using C$SYSTEM with the command line 'dir C:\Windows\System32\m*.exe', the 32 bit runtime fails to find msg.exe  
The same command in Windows, using cmd.exe, is able to find msg.exe  

## Resolution
'C:\Windows\System32' on a 64 bit OS is the wrong place to look for when using the 32 bit runtime. The location of msg.exe when using the 32 bit runtime is 'C:\Windows\Sysnative'.  