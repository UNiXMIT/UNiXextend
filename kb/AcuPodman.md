# AcuCOBOL 10.5.0 Linux container script only uses Podman. Can it be made to check for Docker or Podman?
## Environment
AcuCOBOL-GT extend  
Linux/UNIX  

## Situation
In 10.5.0, support for containers has been added. The example build scripts have been included but on Linux they assume the use of Podman. Can they be modified to use Docker or even detect if Docker or Podman is installed on the host system and then continue to use the correct one?  

## Resolution
The scripts that are included in 10.5.0 are just an example of what is possible with containers. They are also helpful as a starting point for those who haven't used containers before.  
The scripts can be modified to use Docker instead. Or they can be made to check what is installed on the system first.  

For example, in the bld.sh script, you can add the following before the build commands:  

```
CONTAINER_RUNTIME=$(which docker 2>/dev/null) ||
  CONTAINER_RUNTIME=$(which podman 2>/dev/null) ||
  {
    echo "No docker or podman executable found in your PATH"
    exit 1
  }
if "${CONTAINER_RUNTIME}" info | grep -i -q buildahversion; then
  BUILDAH_FORMAT=docker
fi
```

And remove '--format docker' from the build commands.  
Now the script will check if Docker or Podman is installed and use the correct commands to build the container.  
The 'run_*' scripts will also need modifying in a similar manner.  

More information on working with containers can be found in the documentation at:  
extend Programming Guides > A Guide to Interoperating with ACUCOBOL-GT Version 10.x.y > Working with Containerization Technologies  

 
#### Additional Information
The AcuCOBOL Documentation and Resources are available here:  
https://www.microfocus.com/en-us/support/ACUCOBOL-GT%20(Extend)  