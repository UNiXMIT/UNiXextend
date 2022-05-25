#!/bin/bash
# EXAMPLE USAGE: ./version.sh /home/products/acu1041stx64/
export ACUCHECK=$1
if [ -z "$ACUCHECK" ]
then
    echo "Enter root directory of the AcuCOBOL installation: "
    read ACUCHECK
fi
export SHARED=$ACUCHECK/lib/libruncbl64.so
if [ -f "$SHARED" ];
then
    echo "You have installed the SHARED version of AcuCOBOL"
else
    echo "You have installed the STATIC version of AcuCOBOL"
fi