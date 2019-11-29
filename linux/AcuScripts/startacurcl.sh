#!/bin/bash
# The ACUCOBOL variable used in this script is set in the setenv.sh script.
# Make sure you have run that script first before running this one.

ACURCL_PORT=$1

if [ -z "$ACURCL_PORT" ] ; then
        $ACUCOBOL/bin/acurcl -start -c /home/support/AcuSupport/etc/acurcl.cfg -@
else
        $ACUCOBOL/bin/acurcl -start -c /home/support/AcuSupport/etc/acurcl.cfg -n $ACURCL_PORT -@
fi
