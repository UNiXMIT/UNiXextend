# Performance issues on Windows Server 2012 / 2016

When moving from Windows Server 2008 to Windows Server 2012 or 2016, the performance of AcuCOBOL-GT extend might decrease. Other programs may be affected too. This can be resolved by testing one or more of the following changes to the registry entries.  

Make the following changes using regedit.exe then restart the machine.  
  
  
Disable fair sharing of the DISK  
Change the value EnableFairShare from 1 to 0 (zero). 

```
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TSFairShare\Disk  
```
  
  
Disable fair sharing of the CPU.  
Change the value EnableCPUQuota from 1 to 0 (zero).  

```
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Quota Systemreg1  
```
  
  
Disable fair sharing of the NETWORK  
Change the value EnableFairShare from 1 to 0 (zero).  

```
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TSFairShare\NetFS  
```