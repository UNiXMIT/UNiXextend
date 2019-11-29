# ISV License Utility

1. Unzip the utility to a directory of your choosing.

    **NOTE:** The isvlic32 license must have an expiration date. If it does not then it thinks the license is expired.

    The ISV License Utility is ordered and delivered separately from all other products. It will have been delivered as a zip file, isvlic32.zip. You extract those files to a directory where you run it from; there is no installation program.

2. Activate the ISV License utility license first - that creates isvlic32.alc (in the x86 license folder)

3. Then activate the Dedicated Master Runtime license - that adds the runtime license into isvlic32.alc  

    **NOTE:** On Windows if the dedicated runtime licence is for machine key 5 (x64) then this will create another isvlic.alc in the x64 license folder and not one combined license. To get around this use the /destination parameter, when activating the licenses, to tell the utility where to create the license.
    ```
    activator /destination=C:\path\to\isvlicdir
    ```

4. Copy the isvlic32.alc to the directory with isvlic32.exe, if you didn't create it there.

4. Now you can run the ISV License utility:  
    Usage: isvlic32 [options] license-file  
    Where [options] is any collection of the following:
    ```
    -m machine-key
    -u number-of-users [0-32767]
    -r maximum-number-of-records [0-15 (0-3000)]
    -e expiration-date [yyyymmdd]
    ```

    EXAMPLE:
    ```
    isvlic32 -m 60 -u 14 -r 0 -e runcbl.alc (or wrun32.alc if it's for a Windows runtime) 
    -r 0 means not record limited.  
    -e with no date means no expiration  
    ```

    **NOTE:** If using `-e` with no date you will get the warning 'No expiration date set!' but will still be able to create the license. Setting an expiration date here will make it a trial license.

    You can also just execute "isvlic32 runcbl.alc" and then follow the prompts.

    The utility creates the runcbl.alc license file. It has the same serial number as the Dedicated Master Runtime license but its own code and key. If you use the code and key inside this license the activator will create the exact same license. So the actual license file may be distributed to the end user or you can provide the code and key to be activated.