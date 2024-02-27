# HTTPGET/HTTPPOST results in a MAV or returns garbage in the response
## Environment
All versions of ACUCOBOL-GT extend using RMNET  
All Operating Systems  

## Problem
A HTTPGET/HTTPPOST call sometimes results in a MAV or garbage characters are returned in the response.  

## Resolution
This can happen when the response pointer is freed, using NETFREE, before the response has been managed. For example:  

```
CALL “HTTPGET” USING WS-URL 
                     RESPONSE-POINTER 
                     RESPONSE-LENGTH
               GIVING STATUS-CODE

SET ADDRESS OF RESPONSE-DATA TO RESPONSE-POINTER

CALL “NETFREE” USING RESPONSE-POINTER

...

MOVE RESPONSE-DATA TO WS-RESPONSE(1:RESPONSE-LENGTH)
```

In this case a MAV is raised on the MOVE or there will be garbage in WS-RESPONSE.  

To solve the issue the pointer needs to be freed after when it is finished with and the response data has been processed. So in this example the call to free the pointer can be moved to the end. For example:  

```
CALL “HTTPGET” USING WS-URL 
                     RESPONSE-POINTER 
                     RESPONSE-LENGTH
               GIVING STATUS-CODE

SET ADDRESS OF RESPONSE-DATA TO RESPONSE-POINTER

MOVE RESPONSE-DATA TO WS-RESPONSE(1:RESPONSE-LENGTH)

...

CALL “NETFREE” USING RESPONSE-POINTER
```