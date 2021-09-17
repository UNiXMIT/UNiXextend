#!/bin/bash
# Any scripts run after this to start/stop services will use the ACUCOBOL variable set here.
ACU_OPT=/home/products
ACUSUP=/home/support/AcuSupport
export SERVER_ALIAS_FILE=$ACUSUP/etc/acurcl.ini
export FILE_TRACE_TIMESTAMP=TRUE

usage()
{
  echo "
Options:  
 startacu.sh [options] <parameters>   Start/Stop an AcuCOBOL service    

Usage: 
 -c stop or status      Stop or Status of the service (1st Option)
 -l                     Set logging on the service (2nd Option)
 -r port                AcuRCL with specified port
 -w                     AcuToWeb (Port is set in gateway.conf)
 -s port                AcuServer with specified port
 -x port                AcuXDBC Server with specified port
 -h                     Usage

Example:
 startacu.sh -l -r 10400          Start AcuRCL on port 10400 with logging enabled
 startacu.sh -c stop -r 10400     Stop AcuRCL started on port 10400
 startacu.sh -c status -r 10400   Status of AcuRCL started on port 10400"
}

start_acurcl()
{
    if [[ "$ACUCONFIG" == "stop" ]] ; then
        $ACUCOBOL/bin/acurcl -kill -n $ACURCL_PORT -@
    else
        if [[ "$ACUCONFIG" = "status" ]] ; then
            $ACUCOBOL/bin/acurcl -info -n $ACURCL_PORT
        else
            if [[ "$ACULOG" = "log" ]] ; then
                export ACCESS_FILE=$ACUSUP/etc/AcuAccess$ACURCL_PORT
                $ACUCOBOL/bin/acurcl -start -c $ACUSUP/etc/acurcl.cfg -n $ACURCL_PORT -le $ACUSUP/AcuLogs/$ACURCL_PORT-acurcl.log -t7 -@
            else
                export ACCESS_FILE=$ACUSUP/etc/AcuAccess$ACURCL_PORT
                $ACUCOBOL/bin/acurcl -start -c $ACUSUP/etc/acurcl.cfg -n $ACURCL_PORT -@
            fi
        fi
    fi
}

start_atw()
{
    if [[ "$ACUCONFIG" == "stop" ]] ; then
        $ACUCOBOL/acutoweb/acutoweb-gateway -kill
    else
        if [[ "$ACUCONFIG" = "status" ]] ; then
            $ACUCOBOL/acutoweb/acutoweb-gateway -info
        else
            $ACUCOBOL/acutoweb/acutoweb-gateway -start
        fi
    fi
}

start_acuserve()
{
    if [[ "$ACUCONFIG" == "stop" ]] ; then
        $ACUCOBOL/bin/acuserve -kill -n $ACUSERVE_PORT -@
    else
        if [[ "$ACULOG" = "log" ]] ; then
            export ACCESS_FILE=$ACUSUP/etc/AcuAccess$ACUSERVER_PORT
            $ACUCOBOL/bin/acuserve -start -c $ACUSUP/etc/a_srvcfg -n $ACUSERVER_PORT -le $ACUSUP/AcuLogs/$ACUSERVER_PORT-acuserve.log -t7 -@
        else
            export ACCESS_FILE=$ACUSUP/etc/AcuAccess$ACUSERVER_PORT
            $ACUCOBOL/bin/acuserve -start -c $ACUSUP/etc/a_srvcfg -n $ACUSERVER_PORT -@
        fi
    fi
}

start_acuxdbcs()
{
    if [[ "$ACUCONFIG" == "stop" ]] ; then
        $ACUCOBOL/bin/acuxdbcs.sh -kill -n $ACUXDBCS_PORT
    else
        if [[ "$ACUCONFIG" = "status" ]] ; then
            $ACUCOBOL/bin/acuxdbcs.sh -info -n $ACUXDBCS_PORT
        else
            if [[ "$ACULOG" = "log" ]] ; then
                $ACUCOBOL/bin/acuxdbcs.sh -start -n $ACUXDBCS_PORT -l
            else
                $ACUCOBOL/bin/acuxdbcs.sh -start -n $ACUXDBCS_PORT
            fi
        fi
    fi
}

invalidARG=
ACULOG=
ACUCONFIG=
OPTIND=1
while getopts ":r:s:c:x:whl" z; do
    case "${z}" in
        r)
            export ACURCL_PORT=$OPTARG
            start_acurcl
            ;;
        w)
            start_atw
            ;;
        s)  
            export ACUSERVER_PORT=$OPTARG
            start_acuserve
            ;;
        x)  
            export ACUXDBCS_PORT=$OPTARG
            start_acuxdbcs
            ;;
        c)  
            ACUCONFIG=$OPTARG
            ;;
        l)  
            ACULOG=log
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