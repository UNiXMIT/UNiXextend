# The .atc file still launches using the older version of AcuThin instead of the new version after the automatic update
## Environment
All versions of AcuCOBOL-GT extend  
Windows  

## Situation
When running a newer version of AcuConnect on the server, the automatic update is triggered and installed on the client machine as expected.  

After this, when the .atc file is launched, the previous version of AcuThin is still used instead of the new installed version.  

This means that the automatic update is triggered again.  

## Resolution
An additional registry key, created for the .atc extension and set to a previous version of AcuThin, was causing the .atc file to always be launched with that version even after an automatic update.  

This registry key atc_auto_file, in fact any <ext>_auto_file key is created when trying to open a file and are prompted with "Open With" or "How do you want to open this file" dialog. Responding with a specific version of AcuThin means that this will always be used regardless of newer versions of AcuThin that are installed.  

Removing the atc_auto_file registry keys resolves this issue.  

**NOTE:** The following solution requires editing the registry so it would be a good idea to backup the registry first. This can be done by navigating to File -> Export in the registry window.  

First open the regedit window. Press Win R to open the Run window. Type ’regedit’ then press enter.  

Once the registry editor window is open press ‘ctrl f’ which will open the Find window and type ‘atc_auto_file’ then press enter.  

The key related to atc_auto_file should be found. Delete this key and search again as there may be more than one key. Do this until you have deleted all the keys related to atc_auto_file. For instance on one machine, keys were found in the following locations:  

```
HKEY_CLASSES_ROOT\atc_auto_file\shell\open\command
HKEY_CURRENT_USER\Software\Classes\atc_auto_file\shell\open\command
```

Now when you run the .atc file, the most recent version of AcuThin will be used.  