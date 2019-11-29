# Shared or Static

The difference is the type of link used when creating the product.

STATIC is a version where the runtime libraries are linked together into a big executable. It is very easy to work with (no need to setup any variables saying where the linked libraries are). The issue is that is make it more difficult to interface with other products.  

SHARED is a version of the runtime where everything (all the logic) is on the shared libraries (.so on Linux). You need to point at them with an environment variable to be able to use it (LD_LIBRARY_PATH on Centos for example). If you want to link the product with other products it is generally easier.  