# Prevent users closing/reloading the browser window and disconnecting AcuToWeb
## Environment
AcuToWeb 10.2.0 onwards  
Windows and Linux   

## Situation
If a user closes/reloads the browser by accident, AcuToWeb gives no warning that the connection to the server will be closed. Is it possible to display a warning before a browser is closed or reloaded?  

## Resolution
To enable warnings when the browser is closed/reloaded, set the following in the runtime configuration file (cblconfig/cblconfi):  

```
QUIT_MODE -2
```

Now a warning will be displayed before the browser is closed or reloaded.  

**NOTE:** While this works correctly in desktop browsers and Android browsers, it currently does not work in any browsers running on iOS. This is due to a bug on iOS that has yet to be fixed by Apple.  