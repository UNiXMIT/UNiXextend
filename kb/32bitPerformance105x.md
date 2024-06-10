# Performance Decrease in Windows 10.5.x Runtime
## Environment
AcuCOBOL-GT extend Runtime 32 bit   
AcuConnect Thin Client 32 bit 
Windows   

## Situation
On Windows, the 10.5.x runtime or AcuThin client is slower than in 10.4.1 or lower.  
The exact same program in 10.5.x runs slower in certain areas than it used to in previous versions.  

## Resolution
This is a known issue caused by a bug in Visual Studio 2022, which is now used to build the Windows binaries.  
The issue has been reported to Microsoft and a Patch Update will be delivered with the fix as soon as Microsoft confirm that the issue is resolved.  
The issue only occurs with the 32 bit version. The 64 bit version is not affected.  