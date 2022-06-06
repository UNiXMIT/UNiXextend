# Shared or Static

The difference is the type of link used when creating the product.  

STATIC is a version where the runtime libraries are linked together into a big executable. It is very easy to work with (no need to setup any variables saying where the linked libraries are). The issue is that it makes it more difficult to interface with other products.  

SHARED is a version of the runtime where everything (all the logic) is on the shared libraries (.so on Linux). You need to point at them with an environment variable to be able to use it (LD_LIBRARY_PATH on CentOS for example). If you want to link the product with other products it is generally easier.  

A Shared installer will look like this: 
``` 
setup_acucob1041pmk59shACU  
```

A Static installer will look like this:  
```
setup_acucob1041pmk59stACU  
```

To identify which version has been installed, look in the lib directory of the installation. If the file ‘libruncbl64.so’ exists and a number of other .so files then the Shared version has been installed. If that file does not exist and the lib directory contains .a files then the Static version has been installed.  

The Shared version is required if AcuXDBC or RMNET is needed.  

For Acu4GL it is easier and simpler to use the Shared version and set the external libraries on LD_LIBRARY_PATH (LIBPATH or SHLIB_PATH on some OS), rather than relinking the required libraries using the Static version.  