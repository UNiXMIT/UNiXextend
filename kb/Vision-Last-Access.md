# Vision files last accessed date/time is not changed during OPEN INPUT when performing a READ
## Environment
AcuCOBOL-GT extend  
Windows  

## Situation

When reading a file during an OPEN INPUT, the date/time accessed of the Vision file is not changed. When checking if a file has been accessed recently, it's not clear because the date/time it was last accessed is not accurate.

## Resolution
This is something that is controlled by the Windows OS using 'fsutil'  

Run the following command to check what is currently set:  

```
fsutil behavior query DisableLastAccess
```

The following are the values it could have:  

```
0 - User Managed, Last Access Updates Enabled
1 - User Managed, Last Access Updates Disabled
2 - System Managed, Last Access Updates Enabled
3 - System Managed, Last Access Updates Disabled
```

If you want the date accessed of a Vision file to be updated when it is read, set DisableLastAccess to 0 or 2:  

```
fsutil behavior set DisableLastAccess 0
```