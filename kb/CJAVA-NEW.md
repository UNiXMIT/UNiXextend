# C$JAVA using CJAVA-NEW does not allow for a return status value
## Environment
AcuCOBOL-GT extend  
Windows and Linux/UNIX  

## Situation
When using C$JAVA, CJAVA-NEW does not allow for a return status value like CJAVA-CALL does. That means that CJAVA-NEW will not be able to inform the user if there were any unhandled exceptions.   

## Resolution
CJAVA-NEW returns a handle. This handle is playing double duty as the status value and the object handle. When treated as a signed int type the object-handle will be negative upon error. The same errors are used as the other status variables. For example the CJAVA-NEW code in the runtime has explicit checks for CJAVA-INVALIDARG (-1) and CJAVA_NOMEMORY (-9). When positive it is the object handle.  