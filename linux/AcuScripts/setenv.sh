#!/bin/bash
# Any scripts run after this to start/stop services will use the ACUCOBOL variable set here.

set_acu()
{
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
}

set_java()
{
    java_bit="${2}" 
    case ${java_bit} in 
       32) set_java32
          ;;
       64) set_java64
          ;;  
       *) set_java64
          ;; 
    esac 
}

set_java32()
{
    export JAVA_HOME=
    export PATH=
    export CLASSPATH=
    export PRELOAD_JAVA_LIBRARY=1
    export JAVA_LIBRARY_NAME=
}

set_java64()
{
    export JAVA_HOME=
    export PATH=
    export CLASSPATH=
    export PRELOAD_JAVA_LIBRARY=1
    export JAVA_LIBRARY_NAME=
}

set_oracle()
{
    # If the Oracle database isn't started then run the following commands:
    # "lsnrctl start"
    # "sqlplus '/ as sysdba'"
    # "SQL> startup"

    export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe
    export ORACLE_SID=XE
    export NLS_LANG=`$ORACLE_HOME/bin/nls_lang.sh`
    export PATH=$ORACLE_HOME/bin:$PATH
    export LD_LIBRARY_PATH=$ORACLE_HOME/lib:$LD_LIBRARY_PATH
}

set_informix()
{
    # Start Informix Database with - oninit
    # Stop Informix Database with - onmode -ky
    # Both require to execute as ROOT
    # Setup Guide - http://bit.ly/2LqdqD7

    export INFORMIXDIR=/home/informix
    export INFORMIXSERVER=informix
    export ONCONFIG=onconfig
    export INFORMIXTERM=terminfo
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/informix/lib:/home/informix/lib/esql
    export PATH=$PATH:/home/informix/bin    
}

option="${1}" 
case ${option} in 
   java) set_java
      ;;
   oracle) set_oracle
      ;; 
   informix) set_informix
      ;;  
   *) set_acu
      ;; 
esac 
