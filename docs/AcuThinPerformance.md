# AcuConnect Thin Client performance

## How to improve the performance of an AcuConnect Thin Client application

In general two are the most important factors in performance terms when executing Thin Client applications, the application and the network latency, rather than bandwidth.  
Latency is almost always the cause for poor thin client display performance, increasing the bandwidth does not necessarily reduce latency. When a client sends a request to acurcl, it just makes the connection via a socket, once a client is connected to the child runtime, acurcl is never again utilized for that client except during the runtime shutdown.  
During the execution of the application, all the performance depends on the speed of the network.  

The above points to the fact that the memory requirements are those for the runtime, which are minimum. A thin client program is less affected by the network latency if it has fewer calls that require a response. Reducing “chattiness” is the key to improving display performance.  

For example if the application has a capture screen with 50 fields and the program makes a field-to-field validation, the program will be “traveling” back-and-forth from the client to the server 50 times impacting the performance of the application, when this same program is running stand-alone, there is no network traffic at all, so, there is no impact in the performance. There are some runtime configuration variables that can help, take a look at their descriptions and play with them to find which and what values are the best for the application:  

```
TC_CONTROL_SYNC_LEVEL
TC_TV_SELCHANGING
TC_EXCLUDE_EVENT_LIST
TC_EVENT_LIST
AGS_RECEIVE_BUFFER_SIZE
AGS_SEND_BUFFER_SIZE
AGS_MAX_SEND_SIZE
AGS_SOCKET_COMPRESS
```

If you use a lot of BEFORE/AFTER procedures on fields, this requires a lot of traffic between the client and the server as the cursor cannot simply advance to the next field. The client has to check with the server each time whether it can advance or not.

Ideally in the Thin Client environment you may want to DISPLAY a whole screen and then ACCEPT the whole screen and at that point do the validation instead of validating at a field-by-field level., as I mentioned before. Using MODIFY/INQUIRE within control events could hit the performance dramatically.  

Also, there is a very important tip: **NEVER** use relative line or column positions for any screen control, if your application is going to be executed by Extend's Thin Client's, doing so, will make the traffic between the server and the client to explode dramatically. Always use fixed line and column positions and do not omit any line or position value, even if it is the same as the control above.

There is a special chapter in AcuConnect’s documentation with several tips to increase the performance of a Thin Client application - [Tuning System Performance](https://bit.ly/3wNYvsZ)