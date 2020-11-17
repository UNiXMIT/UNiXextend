#!/bin/bash
# Any scripts run after this to start/stop services will use the ACUCOBOL variable set here.
export ACU_OPT=/home/products
export JAVA32=
export JAVA64=
export ORACLE32=
export ORACLE64=
export INFORMIX_OPT=

set_acu()
{
    # Save current directory.
    CURRENT_DIR=$(pwd)

    # Set the path of your Acu installations here.
    cd $ACU_OPT
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
    export JAVA_HOME=$JAVA32
    export PATH=
    export CLASSPATH=
    export PRELOAD_JAVA_LIBRARY=1
    export JAVA_LIBRARY_NAME=
}

set_java64()
{
    export JAVA_HOME=$JAVA64
    export PATH=
    export CLASSPATH=
    export PRELOAD_JAVA_LIBRARY=1
    export JAVA_LIBRARY_NAME=
}

set_oracle()
{
    oracle_bit="${2}" 
    case ${oracle_bit} in 
       32) set_oracle32
          ;;
       64) set_oracle64
          ;;  
       *) set_oracle64
          ;; 
    esac 
}

set_oracle32()
{
    export ORACLE_HOME=$ORACLE32
    export PATH=$ORACLE_HOME/bin:$PATH
    export LD_LIBRARY_PATH=$ORACLE_HOME/lib:$LD_LIBRARY_PATH
}

set_oracle64()
{
    export ORACLE_HOME=$ORACLE64
    export PATH=$ORACLE_HOME/bin:$PATH
    export LD_LIBRARY_PATH=$ORACLE_HOME/lib:$LD_LIBRARY_PATH
}

set_informix()
{
    export INFORMIXDIR=$INFORMIX_OPT
    export INFORMIXSERVER=informix
    export ONCONFIG=onconfig
    export INFORMIXTERM=terminfo
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$INFORMIXDIR/lib:$INFORMIXDIR/lib/esql
    export PATH=$PATH:$INFORMIXDIR/bin    
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
