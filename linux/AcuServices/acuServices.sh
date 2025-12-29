#!/bin/bash
arg1="$1"
arg2="$2"
shift 2
source /tmp/.acu.env
export SERVER_ALIAS_FILE=$ACUSUP/etc/acurcl.ini
export BOOMERANG_ALIAS_FILE=$ACUSUP/etc/boomerang.ini
export ACCESS_FILE=$ACUSUP/etc/AcuAccess
export DEFAULT_USER=support
export ACURCL_PORT=5632
export ACUSERVER_PORT=6523
export ACUXDBCS_PORT=20222
export BOOMERANG_PORT=7770

acurcl() {
    case "$arg2" in
        start)
            $ACUCOBOL/bin/acurcl -start -c $ACUSUP/etc/acurcl.cfg -n $ACURCL_PORT -@
            # $ACUCOBOL/bin/acurcl -start -c $ACUSUP/etc/acurcl.cfg -n $ACURCL_PORT -le $ACUSUP/AcuLogs/acurcl.log -t7 -@
            ;;
        stop)
            $ACUCOBOL/bin/acurcl -kill -n $ACURCL_PORT
            sleep 5
            ;;
        restart)
            for arg2 in stop start; do
                acurcl
            done
            ;;
        *)
            echo -e "Incorrect parms.  Usage: $0 (acurcl|atw|acuserve|acuxdbcs|boomerang) (start|stop|restart)"
            exit 1;
            ;;
    esac
}

atw() {
    case "$arg2" in
        start)
            # $ACUCOBOL/acutoweb/acutoweb-gateway -start
            $ACUCOBOL/acutoweb/acutoweb-gateway -start -c $ACUSUP/etc/gateway.toml
            ;;
        stop)
            $ACUCOBOL/acutoweb/acutoweb-gateway -kill
            sleep 5
            ;;
        restart)
            for arg2 in stop start; do
                atw
            done
            ;;
        *)
            echo -e "Incorrect parms.  Usage: $0 (acurcl|atw|acuserve|acuxdbcs|boomerang) (start|stop|restart)"
            exit 1;
            ;;
    esac
}

acuserver() {
    case "$arg2" in
        start)
            $ACUCOBOL/bin/acuserve -start -c $ACUSUP/etc/a_srvcfg -n $ACUSERVER_PORT -@
            # $ACUCOBOL/bin/acuserve -start -c $ACUSUP/etc/a_srvcfg -n $ACUSERVER_PORT -le $ACUSUP/AcuLogs/acuserve.log -t7 -@
            ;;
        stop)
            $ACUCOBOL/bin/acuserve -kill -n $ACUSERVE_PORT -@
            sleep 5
            ;;
        restart)
            for arg2 in stop start; do
                acuserver
            done
            ;;
        *)
            echo -e "Incorrect parms.  Usage: $0 (acurcl|atw|acuserve|acuxdbcs|boomerang) (start|stop|restart)"
            exit 1;
            ;;
    esac
}

acuxdbcs() {
    case "$arg2" in
        start)
            $ACUCOBOL/bin/acuxdbcs.sh -start -n $ACUXDBCS_PORT
            # $ACUCOBOL/bin/acuxdbcs.sh -start -n $ACUXDBCS_PORT -l
            ;;
        stop)
            $ACUCOBOL/bin/acuxdbcs.sh -kill -n $ACUXDBCS_PORT
            sleep 5
            ;;
        restart)
            for arg2 in stop start; do
                acuxdbcs
            done
            ;;
        *)
            echo -e "Incorrect parms.  Usage: $0 (acurcl|atw|acuserve|acuxdbcs|boomerang) (start|stop|restart)"
            exit 1;
            ;;
    esac
}

boomerang() {
    case "$arg2" in
        start)
            $ACUCOBOL/bin/boomerang -start -c $ACUSUP/etc/boomerang.cfg -n $BOOMERANG_PORT -@
            # $ACUCOBOL/bin/boomerang -start -c $ACUSUP/etc/boomerang.cfg -n $BOOMERANG_PORT -t 7 -e $ACUSUP/AcuLogs/boomerang.log -@
            ;;
        stop)
            $ACUCOBOL/bin/boomerang -kill -n $BOOMERANG_PORT -@
            sleep 5
            ;;
        restart)
            for arg2 in stop start; do
                boomerang
            done
            ;;
        *)
            echo -e "Incorrect parms.  Usage: $0 (acurcl|atw|acuserve|acuxdbcs|boomerang) (start|stop|restart)"
            exit 1;
            ;;
    esac
}

case "$arg1" in
    acurcl)
        acurcl
        ;;
    atw)
        atw
        ;;
    acuserver)
        acuserver
        ;;
    acuxdbcs)
        acuxdbcs
        ;;
    boomerang)
        boomerang
        ;;
    *)
        echo -e "Incorrect parms. Usage: $0 (acurcl|atw|acuserve|acuxdbcs|boomerang) (start|stop|restart)"
        exit 1;
        ;;
esac