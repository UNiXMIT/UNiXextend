#!/bin/bash
# The ACUCOBOL variable used in this script is set in the setenv.sh script.
# Make sure you have run that script first before running this one.

ACURCL_PORT=$1
ACUOPT=$2
ACUSUP=/home/support/AcuSupport
export SERVER_ALIAS_FILE=$ACUSUP/etc/acurcl.ini
export FILE_TRACE_TIMESTAMP=TRUE

if [[ -z "$ACURCL_PORT" ]] ; then
        if [[ "$ACUOPT" = "log" ]] ; then
                export ACCESS_FILE=$ACUSUP/etc/AcuAccess
                $ACUCOBOL/bin/acurcl -start -c $ACUSUP/etc/acurcl.cfg -le $ACUSUP/AcuLogs/acurcl.log -t7 -@
        else
                export ACCESS_FILE=$ACUSUP/etc/AcuAccess
                $ACUCOBOL/bin/acurcl -start -c $ACUSUP/etc/acurcl.cfg -@
        fi
else
        if [[ "$ACUOPT" = "log" ]] ; then
                export ACCESS_FILE=$ACUSUP/etc/AcuAccess$ACURCL_PORT
                $ACUCOBOL/bin/acurcl -start -c $ACUSUP/etc/acurcl.cfg -n $ACURCL_PORT -le $ACUSUP/AcuLogs/$ACURCL_PORT-acurcl.log -t7 -@
        else
                export ACCESS_FILE=$ACUSUP/etc/AcuAccess$ACURCL_PORT
                $ACUCOBOL/bin/acurcl -start -c $ACUSUP/etc/acurcl.cfg -n $ACURCL_PORT -@
        fi
fi


