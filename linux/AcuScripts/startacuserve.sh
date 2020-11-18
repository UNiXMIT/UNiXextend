#!/bin/bash
# The ACUCOBOL variable used in this script is set in the setenv.sh script.
# Make sure you have run that script first before running this one.

ACUOPT=$2
ACUSUP=/home/support/AcuSupport
export ACUSERVER_PORT=$1
export FILE_TRACE_TIMESTAMP=TRUE

if [[ -z "$ACUSERVER_PORT" ]] ; then
        if [[ "$ACUOPT" = "log" ]] ; then
                export ACCESS_FILE=$ACUSUP/etc/AcuAccess
                $ACUCOBOL/bin/acuserve -start -c $ACUSUP/etc/a_srvcfg -le $ACUSUP/AcuLogs/acuserve.log -t7 -@
        else
                export ACCESS_FILE=$ACUSUP/etc/AcuAccess
                $ACUCOBOL/bin/acuserve -start -c $ACUSUP/etc/a_srvcfg -@
        fi
else
        if [[ "$ACUOPT" = "log" ]] ; then
                export ACCESS_FILE=$ACUSUP/etc/AcuAccess$ACUSERVER_PORT
                $ACUCOBOL/bin/acuserve -start -c $ACUSUP/etc/a_srvcfg -n $ACUSERVER_PORT -le $ACUSUP/AcuLogs/$ACUSERVER_PORT-acuserve.log -t7 -@
        else
                export ACCESS_FILE=$ACUSUP/etc/AcuAccess$ACUSERVER_PORT
                $ACUCOBOL/bin/acuserve -start -c $ACUSUP/etc/a_srvcfg -n $ACUSERVER_PORT -@
        fi
fi
