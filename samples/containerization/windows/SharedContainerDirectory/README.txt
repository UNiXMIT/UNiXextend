SharedContainerDirectory

This directory allows for persistent data after a container has been stopped.
It is a single shared directory between the host and the container where your
container applications can create or make changes to files and data that you
want to remain after a container has been stopped. The sample COBOL programs
will use this directory for files that get created when they are run by using
the runtime -e error output file option and the runtime configuration variable
FILE-PREFIX for data files.

If you run the run_container_AcuRCL.bat example, you should find an
acurcl_windows.out file in the SharedContainerDirectory directory.

If you run the run_container_AcuToWeb.bat example, you will find an additional
file called gateway.log in the SharedContainerDirectory directory.
