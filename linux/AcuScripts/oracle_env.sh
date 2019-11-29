#!/bin/bash
# If the Oracle database isn't started then run the following commands:
# "lsnrctl start"
# "sqlplus '/ as sysdba'"
# "SQL> startup"

export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe
export ORACLE_SID=XE
export NLS_LANG=`$ORACLE_HOME/bin/nls_lang.sh`
export PATH=$ORACLE_HOME/bin:$PATH
export LD_LIBRARY_PATH=$ORACLE_HOME/lib:$LD_LIBRARY_PATH