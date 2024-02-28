# AcuToWeb performance issues after 200+ active users are connected
## Environment
AcuToWeb 10.5.1 and lower  
Linux / UNIX  

## Situation
When 200+ users are connected to AcuToWeb, it stops accepting new connections and starts generating the following type of error in the gateway log:  

```
error: can't start new thread
```

Performance of AcuToWeb degrades for those that are still connected.  

## Resolution
The issue is caused by the limitation of Python 32 bit that is included with AcuToWeb. Python 32 bit can use a maximum of 4GB of memory and that limits the number of threads that can be created by a process. In order to bypass that limit there are a few options available.  

1. Start multiple instances of AcuToWeb and use a load balancer to balance the traffic between the instances of ATW. This will lower the number of users connected to any one instance of ATW and avoid the issue.  

2. Start AcuToWeb using Python 64 bit. Python 64 bit does not come bundled with AcuToWeb so it will need to be installed on the machine where ATW is installed. The Python package dependencies will also need to be installed for ATW to start and run correctly. For example, on RHEL 8:  

```
dnf install python38
dnf install python38-pip
pip3.8 install cffi pycryptodomex pillow pyOpenSSL
```

Now the acutoweb-gateway script in the acutoweb directory will need modifying to use this version of Python.   

```
python3.8 ./Gateway/main.pyc ${CONFIG} > gateway.out 2>&1 &
```

When ATW is started, it will now use Python 64 bit. Any limits that are hit when using Python 64 bit may be limitations of the OS/Server. For example, you may see the following error which is caused by a limitation on the server of the number of file descriptors that a process can have:  

```
exceptions.IOError: [Errno 24] Too many open files:
```

This can be temporarily increased, before starting AcuRCL and ATW:  

```
ulimit -n 50000
```

It can be made permanent, for all users, in the file /etc/security/limits.conf:  

```
* hard nofile 50000
* soft nofile 50000
```

The following ATW configuration variable may also need to be increased, to allow more time for connections to complete as the load on the server increases:  

```
probing_connection 30000
```

These instructions are specifically for version 10.5.x  
It is recommended that you upgrade to 10.5.x if Python 64 bit is needed. Installing Python 64 bit for version lower than 10.5.x is more complicated because a lower version of Python is used (2.7) that is no longer supported and cannot be installed on newer OS.  

In version 11.0.0 and higher, this will no longer be an issue and the workaround will not be needed.  

## Additional Information
### Python 2.7 64 bit
```
yum install glibc-devel glibc-devel.i686 zlib-devel zlib-devel.i686 openssl openssl-devel
cd /tmp
mkdir /home/products/python27
wget https://www.python.org/ftp/python/2.7.18/Python-2.7.18.tar.xz
tar -xf Python-2.7.18.tar.xz
cd Python-2.7.18
./configure --prefix=/home/products/python27 --with-ensurepip=install --enable-optimizations && make && make install
/home/products/python27/bin/python -m pip install cffi pillow pyOpenSSL==21.0.0 twisted==20.3.0 autobahn==0.13.0 txsockjs pycrypto Service_Identity==18.1.0 cryptography==2.7
```

### Python 3.8.13 64 bit
```
dnf install glibc-devel glibc-devel.i686 zlib-devel zlib-devel.i686 openssl openssl-devel
cd /tmp/
mkdir /home/products/python38
wget https://www.python.org/ftp/python/3.8.13/Python-3.8.13.tgz
tar -zxf Python-3.8.13.tgz
cd Python-3.8.13
./configure --prefix=/home/products/python38 --with-ensurepip=install --enable-optimizations && make && make install
/home/products/python38/bin/python3 -m pip install cffi pycryptodomex pillow pyOpenSSL
```