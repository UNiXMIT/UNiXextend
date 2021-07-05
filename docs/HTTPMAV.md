# HTTPGET/HTTPPOST results in a MAV or returns garbage in the response

## PROBLEM

A HTTPGET/HTTPPOST call sometimes results in a MAV or garbage characters are returned in the response.  

## SOLUTION

This can happen when you free the response pointer, using NETFREE, before you have acted on the response. For example:  

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

In this case you may get a MAV on the MOVE or you will have garbage in WS-RESPONSE.  

To solve the issue you need to free the pointer after you have finished with it and processed the response data. So in this example you just have to move the call to free the pointer to the end. For example:

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
