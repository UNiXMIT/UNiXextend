# AcuThin and AcuToWeb cannot access a shared/mapped drive on Windows 10
## Environment
All versions of AcuCOBOL-GT extend  
Windows  

## Situation

When a shared or mapped drive is set in the Working Directory in the Alias then there will be an error 267 in the AcuConnect logs, and the program will not run.  

This same set up works on Windows 7 but not now with Windows 10.  

## Resolution
Microsoft has increased security on Windows 10. Now, services created as Local System account cannot access mapped/shared drives.   

The Windows error 267 means 'The directory name is invalid'.  

The AcuConnect service is created to log on as 'Local System'. As such, it cannot access the drive and returns the error.  

There are 2 solutions to get around this issue. Depending on your setup and system architecture, one solution may work better than the other.  

#### SOLUTION 1 – Change the AcuConnect service to not run as the SYSTEM account.  

1. Press the Windows R keys, which will open the 'Run' window.  

2. Type 'services.msc' enter, this will open the Services window.  

3. Find the AcuConnect service i.e. AcuConnect 10.2.0 on port 10200  

4. Right-click on that service and navigate to Properties. Then click the Log On tab.  

5. In this section, see that the service is configured to use 'Local System account'. To allow the service to access the shared drive, the AcuConnect service needs to log on as a valid user on that machine with permission to access the drive.  

6. Click the 'This account' radio button and fill in the account details with an appropriate account with sufficient privileges. Click Apply then OK.  

7. The changes will only take effect after the service has been restarted. Restart the service in the Services.msc window.  

8. Now when the program is run again through AcuConnect or AcuToWeb it should not have issues with the working directory being a mapped drive.  

#### SOLUTION 2 - Map the drive as the SYSTEM account.  

1. Download the 3rd party tool [SysinternalsSuite - PsExec](https://learn.microsoft.com/en-us/sysinternals/downloads/psexec)    

2. Open an elevated cmd.exe prompt (Run as administrator).  

3. Elevate again to root using PSExec.exe; Navigate to the folder containing SysinternalsSuite and execute the following command: 
    ```
    psexec -i -s cmd.exe
    ```
    You are now inside a prompt that is "nt authority\system" and can prove this by typing "whoami". The -i is needed because drive mappings need to interact with the user  

4. Create the persistent mapped drive as the SYSTEM account with the following command: 
    ```
    net use z: \\server\share /persistent:yes /user:username password
    ```

    **NOTE:** You can only remove this mapping the same way you created it, from the SYSTEM account. To remove it, follow steps 1 and 2 but change the command on step 3 to: 
    ```
    net use z: /delete 
    ```