#!/bin/bash
# Any scripts run after this to start/stop services will use the ACUCOBOL variable set here.

# Save current directory.
CURRENT_DIR=$(pwd)

# Set the path of your Acu installations here.
cd /home/products
array=(*/)

# Display a list of all Acu installations.
echo
PS3="Which version of AcuCOBOL-GT? "
select ACU in "${array[@]}"
do export ACUCOBOL=$(echo /home/products/$ACU | sed -e "s/\/*$//"); break;  done

# Change directory back to original.
cd $CURRENT_DIR

# Set environment variables.
export PATH=$ACUCOBOL/bin:$PATH
export LD_LIBRARY_PATH=$ACUCOBOL/bin:$ACUCOBOL/lib:$LD_LIBRARY_PATH
export A_TERMCAP=$ACUCOBOL/etc/a_termcap
export GENESIS_HOME=$ACUCOBOL
export VORTEX_HOME=$ACUCOBOL

# Display output from runcbl -vv for set version to check. Only displays first line.
echo
runcbl -vv 2>&1 | head -n 1
echo
