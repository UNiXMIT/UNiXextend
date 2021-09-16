@ECHO OFF

:: Ensure JAVA, ORACLE AND MQ PATHS are correct
SET JAVA32=C:\OpenJDK\x86\jdk-11.0.10+9
SET JAVA64=
SET ORACLE32=
SET ORACLE64=
SET MQ=
SET MQSERVER=DEV.APP.SVRCONN/TCP/127.0.0.1
SET FILE_TRACE_TIMESTAMP=TRUE

IF '%1'=='java' GOTO JAVA
IF '%1'=='JAVA' GOTO JAVA
IF '%1'=='oracle' GOTO ORACLE
IF '%1'=='ORACLE' GOTO ORACLE
IF '%1'=='mq' GOTO MQ
IF '%1'=='MQ' GOTO MQ

:: AcuVersion set here
SET EXTEND=%1

:: Modify AcuPath here if not in default install location
SET ACUPATH32=C:\Program Files (x86)\Micro Focus\extend %EXTEND%\
SET ACUPATH64=C:\Program Files\Micro Focus\extend %EXTEND%\

SET DEF=".;%ACUPATH32%AcuGT\sample\def"
SET XML=".;%ACUPATH32%AcuGT\sample\xmlext"
SET BMP=".;%ACUPATH32%AcuGT\sample\acubench\resource"
SET ALL=".;%ACUPATH32%AcuGT\sample\def;%ACUPATH32%AcuGT\sample\xmlext;%ACUPATH32%AcuGT\sample\acubench\resource"
SET COPYPATH=%ALL%

IF '%2'=='32' GOTO 32BIT
IF '%2'=='64' GOTO 64BIT
IF '%2'=='b' GOTO ACUBENCH
IF '%2'=='B' GOTO ACUBENCH
IF '%2'=='atw' GOTO ACUTOWEB
IF '%2'=='ATW' GOTO ACUTOWEB

:32BIT
SET ACUPATH=%ACUPATH32%AcuGT\
SET CHOICE=%EXTEND% 32bit
IF '%3'=='p' GOTO PATCH
IF '%3'=='P' GOTO PATCH
IF '%3'=='d' GOTO DIRECTORY
IF '%3'=='D' GOTO DIRECTORY
GOTO SETPATH

:64BIT
SET ACUPATH=%ACUPATH64%AcuGT\
SET CHOICE=%EXTEND% 64bit
IF '%3'=='p' GOTO PATCH
IF '%3'=='P' GOTO PATCH
IF '%3'=='d' GOTO DIRECTORY
IF '%3'=='D' GOTO DIRECTORY
GOTO SETPATH

:SETPATH
SET ACUBENCH=%ACUPATH32%acubench\
SET PATH=C:\etc\acu;%ACUPATH%bin%3;%ACUBENCH%;C:\WINDOWS\system32
SET GENESIS_HOME=%ACUPATH%
ECHO.
ECHO %CHOICE% %3
IF '%3'=='java' GOTO JAVA
IF '%3'=='JAVA' GOTO JAVA
IF '%3'=='oracle' GOTO ORACLE
IF '%3'=='ORACLE' GOTO ORACLE
IF '%3'=='mq' GOTO MQ
IF '%3'=='MQ' GOTO MQ
GOTO END

:PATCH
ECHO.
DIR "%ACUPATH%bin1*" /b
GOTO END

:DIRECTORY
CD "%ACUPATH%"
START .
GOTO END

:ACUBENCH
START "" "%ACUPATH32%acubench\AcuBench.exe"
GOTO END

:ACUTOWEB
START "" "%ACUPATH32%AcuGT\bin\AcuToWeb.exe"
GOTO END

:JAVA
IF '%2'=='32' GOTO JAVA32BIT
IF '%2'=='64' GOTO JAVA64BIT

:JAVA32BIT
set JAVA_HOME=%JAVA32%
set PATH=C:\etc\acu;%ACUPATH%bin;%JAVA_HOME%\bin\client;%JAVA_HOME%\bin;C:\WINDOWS\system32
set CLASSPATH=.;%ACUPATH%bin\CVM.jar;%ACUPATH%bin\vortex.jar
set PRELOAD_JAVA_LIBRARY=1
set JAVA_LIBRARY_NAME=%JAVA_HOME%\bin\client\JVM.dll
GOTO END

:JAVA64BIT
set JAVA_HOME=%JAVA64%
set PATH=C:\etc\acu;%ACUPATH%bin;%JAVA_HOME%\bin\client;%JAVA_HOME%\bin;C:\WINDOWS\system32
set CLASSPATH=.;%ACUPATH%bin\CVM.jar;%ACUPATH%bin\vortex.jar
set PRELOAD_JAVA_LIBRARY=1
set JAVA_LIBRARY_NAME=%JAVA_HOME%\bin\client\JVM.dll
GOTO END

:ORACLE
IF '%2'=='32' GOTO ORA32BIT
IF '%2'=='64' GOTO ORA64BIT

:ORA32BIT
SET ORACLE_HOME=%ORACLE32%
SET PATH=C:\etc\acu;%ORACLE_HOME%;%ACUPATH%bin;C:\WINDOWS\system32
GOTO END

:ORA64BIT
SET ORACLE_HOME=%ORACLE64%
SET PATH=C:\etc\acu;%ORACLE_HOME%;%ACUPATH%bin;C:\WINDOWS\system32
GOTO END

:MQ
IF '%2'=='32' GOTO MQ32BIT
IF '%2'=='64' GOTO MQ64BIT

:MQ32BIT
SET PATH=C:\etc\acu;%MQ%bin;%ACUPATH%bin;C:\WINDOWS\system32
SET SHARED_LIBRARY_LIST=mqic32.dll
GOTO END

:MQ64BIT
SET PATH=C:\etc\acu;%MQ%bin64;%ACUPATH%bin;C:\WINDOWS\system32
SET SHARED_LIBRARY_LIST=mqic64.dll
GOTO END

:END
