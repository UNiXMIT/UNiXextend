# Opportunistic Locking System

Windows has its own locking mechanism, called Opportunistic Locking, for files shared in a network environment. This mechanism is enabled by default and can contribute to file errors and performance issues in such an environment.  

## Disabling Opportunistic Locking on Windows Client PCs

To disable opportunistic locking on a Windows client PC, change or add the following Registry value:  

```
HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\MRXSmb\Parameters OplocksDisabled = 1  
```

## Disabling Opportunistic Locking on Windows Servers

To disable opportunistic locking on a Windows server, change or add the following Registry value:  
```
LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters EnableOplocks = 0
```

## Disabling Opportunistic Locking on SMB2

Opportunistic Locking cannot be turned off for SMB2, but you can disable SMB2 itself.  

To disable SMB2 on a Windows Server 2008 or Windows Vista PC, change or add the following Registry value:  

```
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters SMB2 = 0
```

Once SMB2 is disabled, SMB1 will be used and the methods described above will be applicable in order to disable opportunistic locking for SMB1.