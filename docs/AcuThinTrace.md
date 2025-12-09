# Advanced AcuThin Tracing

AcuThin provides an advanced tracing option, -t n, which enables detailed logging of Thin client activity. This includes request flows, event information, window handles, socket operations, MODIFY control actions, configuration activity, signals, and control handles. These trace details are typically only useful to AcuCOBOL developers, though the technical support team may occasionally request them for diagnostic purposes.  

- AcuThin produces a disp.\<pid\>.trc file and, optionally, a socks.\<pid\>.trc file. These files are written to the current directory when AcuThin is launched.  
- The runtime produces an app.\<pid\>.trc file and, optionally, a socks.\<pid\>.trc. These files are written to the runtime’s working directory, as specified in the alias.  

The socks.\<pid\>.trc file captures low-level socket activity. The app.\<pid\>.trc file serves as the runtime's equivalent of AcuThin's disp.\<pid\>.trc, providing a record of all messages the runtime sends and receives.

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
127 = Thin client requests, event details, window handles, sockets, MODIFY control, configuration, signals,
control handles
255 = Everything
```