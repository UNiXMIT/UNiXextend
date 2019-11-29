#!/bin/bash
# The ACUCOBOL variable used in this script is set in the setenv.sh script.
# Make sure you have run that script first before running this one.

ACUSERVE_PORT=$1

if [ -z "$ACUSERVE_PORT" ] ; then
        $ACUCOBOL/bin/acuserve -start -c /home/support/AcuSupport/etc/a_srvcfg -@
else
        $ACUCOBOL/bin/acuserve -start -c /home/support/AcuSupport/etc/a_srvcfg -n $ACUSERVE_PORT -@
fi
