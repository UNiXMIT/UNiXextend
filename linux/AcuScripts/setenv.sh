#!/bin/bash
# Any scripts run after this to start/stop services will use the ACUCOBOL variable set here.
export ACU_OPT=/home/products
export JAVA32=
export JAVA64=
export ORACLE32=
export ORACLE64=
export INFORMIX_OPT=
export MQ=
export MQSERVER=DEV.APP.SVRCONN/TCP/127.0.0.1
export FILE_TRACE_TIMESTAMP=TRUE

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
    export DEF=".:$ACUCOBOL/sample/def"
    export XML=".:$ACUCOBOL/sample/xmlext"
    export BMP=".:$ACUCOBOL/sample"
    export ALL=".:$ACUCOBOL/sample/def:$ACUCOBOL/sample/xmlext:$ACUCOBOL/sample"
    export COPYPATH=$ALL

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

set_mq()
{
    mq_bit="${2}" 
    case ${mq_bit} in 
       32) set_mq32
          ;;
       64) set_mq64
          ;;  
       *) set_mq64
          ;; 
    esac 
}

set_mq32()
{
    export PATH=$MQ/bin:$PATH
    export LD_LIBRARY_PATH=$MQ/lib64/:$LD_LIBRARY_PATH
    export SHARED_LIBRARY_LIST=libmqic_r.so:libmqmcs_r.so
}

set_mq64()
{
    export PATH=$MQ/bin:$PATH
    export LD_LIBRARY_PATH=$MQ/lib/:$LD_LIBRARY_PATH
    export SHARED_LIBRARY_LIST=libmqic_r.so:libmqmcs_r.so
}

set_informix()
{
    export INFORMIX_HOME=$INFORMIX_OPT
    export INFORMIXDIR=$INFORMIX_OPT/odbc
    export INFORMIXSERVER=informix
    export ONCONFIG=onconfig
    export INFORMIXTERM=terminfo
    export INFORMIXSQLHOSTS=$INFORMIX_HOME/sqlhosts
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$INFORMIX_HOME/lib:$INFORMIX_HOME/lib/esql:$INFORMIXDIR/lib:$INFORMIXDIR/lib/esql:$INFORMIXDIR/lib/cli
    export PATH=$PATH:$INFORMIX_HOME/bin:$INFORMIXDIR/bin    
}

option="${1}" 
case ${option} in 
   java) set_java
      ;;
   oracle) set_oracle
      ;; 
   informix) set_informix
      ;;
   mq) set_mq
      ;;  
   *) set_acu
      ;; 
esac 
