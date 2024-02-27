# High CPU usage of wrun32, writing to a file named $Logfile
## Environment
AcuCOBOL-GT extend  
Windows  

## Situation
In Windows Resource Monitor it shows that the runtime (wrun32) is constantly writing to a file called $Logfile and the CPU usage on the machine is constantly high. The COBOL program source contains no references to a file called $Logfile.  

## Resolution
The $Logfile is a special NTFS system file. It is a circular log of all disk operations and is used to roll back disk operations. The file stays the same size, in the same place and is allocated when the disk is originally formatted. Everything that goes through that file system, uses it. This is normal behaviour on Windows.  
The high CPU usage could be unrelated and more diagnostics should be taken to find the cause. Usually it is caused by Windows updates and not the runtime.  