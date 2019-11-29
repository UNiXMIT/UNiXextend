#!/bin/bash
# The ACUCOBOL variable used in this script is set in the setenv.sh script.
# Make sure you have run that script first before running this one.

ACURCL_PORT=$1

if [ -z "$ACURCL_PORT" ] ; then
        $ACUCOBOL/bin/acurcl -kill -@
else
        $ACUCOBOL/bin/acurcl -kill -n $ACURCL_PORT -@
fi
