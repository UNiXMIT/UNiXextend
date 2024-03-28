# 'undefined symbol' error when using the AcuRuntime or starting AcuConnect
## Environment
AcuCOBOL-GT extend   
Linux/UNIX  

## Situation
At runtime or when starting acurcl, the following error is returned:  
```
symbol lookup error: acurcl: undefined symbol: Alibid_aregex_10_5_0_27415_60_RELEASE
```
The PATH and LD_LIBRARY_PATH environment variables are set correctly.  
Using the 'nm -D' command on the libraries in the Acu installations lib directory shows that the Alibid_aregex_* symbol is correctly found in the Acu libraries.  

## Resolution
Inspecting the output from a strace, truss or tusc is very useful in this situation. It will show what libraries are being found and loaded.  
The basic strace, truss or tusc command is adequate for what is needed in most cases.  

### Linux  
```
strace -f -o <full path name to output file> <program name and any arguments>
```
 
### AIX
```
truss -f -o <full path name to output file> <program name and any arguments>
```

### Solaris
```
truss -f -o <full path name to output file> <program name and any arguments>
```

### HP-UX
```
tusc -f -o <full path name to output file> <program name and any arguments>
```

on Linux, the strace showed that a different library, with the same name as a library in the Acu lib directory, was being found and loaded before it found the Acu library:  
```
29191 open("/usr/lib/libaregex.so", O_RDONLY|O_CLOEXEC) = 3
```
This was causing the 'undefined symbol' error.  

To solve this issue, LD_PRELOAD can be used to influence the linkage of shared libraries and the resolution of symbols (functions) at runtime.  
Setting LD_PRELOAD allows a program to preload a shared object file (a library) before any other shared objects:  
```
export LD_PRELOAD=/home/products/acu1051shx64/lib/libaregex64.so
```
Now the library libaregex64.so will be loaded from that location before a library with the same name in other locations like /usr/lib64  
The LD_PRELOAD mechanism is available on Linux and AIX.  
On Solaris and HP-UX, LD_PRELOAD is not supported.  
Solaris uses a similar mechanism called LD_PRELOAD_32 and LD_PRELOAD_64 for 32-bit and 64-bit applications respectively.  
HP-UX provides a similar functionality through SHLIB_PATH, which allows you to specify directories to search for shared libraries before the standard directories.  