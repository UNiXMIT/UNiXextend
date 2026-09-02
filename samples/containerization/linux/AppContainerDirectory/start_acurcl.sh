#!/bin/bash
# To run a container in the background you need two things:
# 1 - Use "podman run -d" to run the container detached.
# 2 - Start a program in the container in the foreground
#     otherwise the container exits when there are no
#     programs running in the foreground.

cd /AppContainerDirectory

# Start AcuRCL
acurcl -start -c /AppContainerDirectory/acurcl_linux.cfg -l -t7 -e /SharedContainerDirectory/acurcl_linux.out -f
