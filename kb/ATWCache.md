# Changes to the AcuToWeb fillCombo.js no longer have any affect when the ATW service is running
## Environment
AcuToWeb from 10.5.0 onward  
Windows  
Linux/UNIX  

## Situation
In versions prior to 10.5.0, if the AcuToWeb service was already running, changes to the fillCombo.js were immediately seen in the AcuToWeb Connection Setup page. In 10.5.0, when the fillCombo.js is modified, the change is not visible in the AcuToWeb Connection Setup page.  

## Resolution
Changes have been made in 10.5.0 regarding caching. To solve browser caching issues, 10.5.0 now uses a unique file version identifier to tell the browser that a new version of the file is available. Therefore, the browser doesn’t retrieve the old file from cache but rather makes a request to the origin server for the new file. For changes to be seen, the AcuToWeb service must be restarted.  
To make changes immediately visible in AcuToWeb without restarting the AcuToWeb service; in addition to modifying the original file, the file with the unique file version identifier in the filename also needs to be modified. These files are located in the directory set in the gateway.toml for the 'public_root_dir' config variable.    