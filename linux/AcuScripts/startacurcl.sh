#!/bin/bash
# The ACUCOBOL variable used in this script is set in the setenv.sh script.
# Make sure you have run that script first before running this one.

ACURCL_PORT=$1
ACULOG=$2
export ACUSUP=/home/support/AcuSupport
export SERVER_ALIAS_FILE=$ACUSUP/etc/acurcl.ini
export FILE_TRACE_TIMESTAMP=TRUE

if [ -z "$ACURCL_PORT" ] ; then
        if [ -z $ACULOG ] ; then
                export ACCESS_FILE=$ACUSUP/etc/AcuAccess
                $ACUCOBOL/bin/acurcl -start -@
        else
                export ACCESS_FILE=$ACUSUP/etc/AcuAccess
                $ACUCOBOL/bin/acurcl -start -le $ACUSUP/AcuLogs/acurcl.log -t7 -@
        fi
else
        if [ -z $ACULOG ] ; then
                export ACCESS_FILE=$ACUSUP/etc/AcuAccess$ACURCL_PORT
                $ACUCOBOL/bin/acurcl -start -n $ACURCL_PORT -@
        else
                export ACCESS_FILE=$ACUSUP/etc/AcuAccess$ACURCL_PORT
                $ACUCOBOL/bin/acurcl -start -n $ACURCL_PORT -le $ACUSUP/AcuLogs/$ACURCL_PORT-acurcl.log -t7 -@
        fi
fi


