#!/bin/bash
# The startacu.sh script run after this, to start/stop services, will use the ACUCOBOL variable set here.
# ACU_OPT is the location of all your Acu installations
export ACU_OPT=/home/products
# Set the path to other installations here:
export JAVA32=
export JAVA64=
export JDBC_DRIVER=
export ORACLE32=
export ORACLE64=
export INFORMIX_OPT=
export MQ=

export FILE_TRACE_TIMESTAMP=TRUE

usage()
{
  echo "
Options:  
 . setenv.sh                          Set the AcuCOBOL environment
 . setenv.sh [options] <parameters>   Set the AcuCOBOL environment and Additional Binaries/Libraries     

Usage: 
 -i            INFORMIX
 -j 32/64      JAVA 32 or 64 bit
 -m 32/64      MQ 32 or 64 bit
 -o 32/64      ORACLE 32 or 64 bit
 -h            Usage

Example:
 . setenv.sh -j 64      Sets AcuCOBOL and JAVA 64-Bit"
}

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
       *)  set_java64
           ;; 
    esac 
}

set_java32()
{
    export JAVA_HOME=$JAVA32
    export PATH=$JAVA32/bin:$PATH
    export CLASSPATH=.:$ACUCOBOL/bin/CVM.jar:$ACUCOBOL/bin/vortex.jar:$JDBC_DRIVER
    export PRELOAD_JAVA_LIBRARY=1
    export JAVA_LIBRARY_NAME=$JAVA_HOME/bin/server/libjvm.so
}

set_java64()
{
    export JAVA_HOME=$JAVA64
    export PATH=$JAVA64/bin:$PATH
    export CLASSPATH=.:$ACUCOBOL/bin/CVM.jar:$ACUCOBOL/bin/vortex.jar:$JDBC_DRIVER
    export PRELOAD_JAVA_LIBRARY=1
    export JAVA_LIBRARY_NAME=$JAVA_HOME/bin/server/libjvm.so
}

set_oracle()
{
    oracle_bit="${2}" 
    case ${oracle_bit} in 
       32) set_oracle32
           ;;
       64) set_oracle64
           ;;  
       *)  set_oracle64
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
    export MQSERVER=DEV.APP.SVRCONN/TCP/127.0.0.1
    case ${mq_bit} in 
       32) set_mq32
           ;;
       64) set_mq64
           ;;  
       *)  set_mq64
           ;; 
    esac 
}

set_mq32()
{
    export PATH=$MQ/bin:$PATH
    export LD_LIBRARY_PATH=$MQ/lib/:$LD_LIBRARY_PATH
    export SHARED_LIBRARY_LIST=libmqic_r.so:libmqmcs_r.so
}

set_mq64()
{
    export PATH=$MQ/bin:$PATH
    export LD_LIBRARY_PATH=$MQ/lib64/:$LD_LIBRARY_PATH
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

invalidARG=
OPTIND=1
while getopts ":j:m:o:hi" z; do
    case "${z}" in
        i)
            set_informix
            ;;
        j)
            set_java
            ;;
        m)  
            set_mq
            ;;
        o)  
            set_oracle
            ;; 
        h)  
            usage
            ;;       
        :)  
            echo "ERROR: Option -$OPTARG requires an argument"
            usage
            ;;
        \?)
            echo "ERROR: Invalid option -$OPTARG"
            usage
            invalidARG="true" 
            ;;
    esac
done
shift "$((OPTIND-1))"
if [ -z "$invalidARG" ]
then
   set_acu
fi
