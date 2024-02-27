# AcuConnect Distributed Processing error 'Program missing or inaccessible'
## Environment
AcuCOBOL-GT extend  
Linux/UNIX  

## Situation
When AcuConnect Distributed Processing is under a heavy load the error message ‘Program missing or inaccessible’ maybe seen and the runtime will crash or hang.  

This is reproduced when the Server is Linux and the client is Windows.  

## Resolution
On a very fast network and performing thousands of socket operations, the server does not have enough time to close a socket before opening a new one and as a result it is running out of sockets.  The solution is to configure the operating system to reuse and recycle sockets. On Linux systems run the following commands as root:  

```
sysctl -w net.ipv4.tcp_tw_reuse=1
sysctl -w net.ipv4.tcp_tw_recycle=1
```

To make this configuration permanent use:  

```
net.ipv4.tcp_tw_reuse=1
net.ipv4.tcp_tw_recycle=1
```

in the file '/etc/sysctl.d/99-tcp-reuse.conf' then issue the following command:  

```
service procps start
```

It may also help to check and increase the current port range used. To find out what current port range is in use, use following command for example:  

```
sysctl net.ipv4.ip_local_port_range
net.ipv4.ip_local_port_range = 32768     60999
```

The number of ports available, based on this output would be 28231 (60999-32768=28231).  

The command to increase the number of ports:  

```
sysctl -w net.ipv4.ip_local_port_range="15000 64000"
```

The command to check the number of sockets that are currently in use:  
```
netstat -4 -6|grep localhost|wc
```

It should show something like the following.  The first number is the number of sockets in use:  

```
0       0       0
```

Keep running the netstat command to see if the number of sockets keeps increasing.  They should increase for each runtime connected but should not max out.  

**NOTE:** The commands outlined in this article may vary from system to system, especially on new OS, yet the logic stays the same.  

**NOTE2:** net.ipv4.tcp_tw_recycle was removed from Linux 4.12. Instead, the value for net.ipv4.tcp_fin_timeout could be decreased to accelerate re-use of TCP connections that are in the TIME-WAIT state.  
The net.ipv4.tcp_fin_timeout parameter in Linux controls the time a TCP connection remains in the TIME-WAIT state after it has been closed. The TIME-WAIT state is designed to ensure that any delayed or duplicate packets from the previous connection are properly handled before reusing the port. This parameter is specified in seconds and defaults to 60 seconds.  