#!/bin/bash
export ACUCOBOL=$1
export SHARED=$ACUCOBOL/lib/libruncbl64.so
if [ -z "$ACUCOBOL" ]
then
    echo "Enter root directory of the AcuCOBOL installation: "
    read x
fi
if [ -f "$SHARED" ];
then
    echo "You have installed the SHARED version of AcuCOBOL"
else
    echo "You have installed the STATIC version of AcuCOBOL"
fi