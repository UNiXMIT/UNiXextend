# Advanced AcuThin Tracing

Valid values for the '-t n' acuthin command flag are:  

```
1 = Thin client requests only
2 = Event details
4 = Window handles
8 = MODIFY control details
16 = Configuration variables
32 = Signals
# Added in 8.0.0
64 = Control handles
255 = Covers all existing levels and one for the future (0x80).
```
Any trace level greater than 3 will turn on socket level tracing.  
Values can be added together to enable multiple tracing options i.e. '-t 3' to enable Thin Client requests and Event details.  

### Useful Values
 
```
1 = Thin client requests only
3 = Add event details
7 = Add window handles and socket level tracing
63 = Add MODIFY control, configuration and signal details
127 = Thin client requests, event details, window handles, socket, MODIFY control, configuration, signals,
control handles
255 = Everything
```