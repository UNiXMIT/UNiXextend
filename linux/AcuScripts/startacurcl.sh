#!/bin/bash
# The ACUCOBOL variable used in this script is set in the setenv.sh script.
# Make sure you have run that script first before running this one.

ACURCL_PORT=$1
export SERVER_ALIAS_FILE=/home/support/AcuSupport/etc/acurcl.ini

if [ -z "$ACURCL_PORT" ] ; then
        export ACCESS_FILE=/home/support/AcuSupport/etc/AcuAccess
        $ACUCOBOL/bin/acurcl -start -@
else
        export ACCESS_FILE=/home/support/AcuSupport/etc/AcuAccess$1
        $ACUCOBOL/bin/acurcl -start -n $ACURCL_PORT -@
fi
