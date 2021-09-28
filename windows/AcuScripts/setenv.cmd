@ECHO OFF

:: Modify the Acu installations paths here, if not in default install location
SET DEFPATH32=C:\Program Files (x86)\Micro Focus
SET DEFPATH64=C:\Program Files\Micro Focus

:: Set the path to other installations here:
SET JAVA32=
SET JAVA64=
SET ORACLE32=
SET ORACLE64=
SET MQ=
SET MQSERVER=DEV.APP.SVRCONN/TCP/127.0.0.1
SET FILE_TRACE_TIMESTAMP=TRUE

:: Default AcuVersion
FOR /F "tokens=2*" %%A IN ('REG.EXE QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Micro Focus\ACUCOBOL-GT" /S /V "DefaultVersion" 2^>NUL ^| FIND "REG_SZ"') DO SET "EXTEND=%%B"

SET ACUBIT=
SET CFLAGS=
SET ACUPATCH=
SET ACUJAVA=
SET ACUORA=
SET ACUMQ=

:INITIAL
 SET RESULT=FALSE
 SET CFLAGS=FALSE
 IF "%1" == "-h" SET RESULT=TRUE
 IF "%RESULT%" == "TRUE" (
 GOTO :USAGE
 )
 IF "%1" == "-v" SET RESULT=TRUE
 IF "%RESULT%" == "TRUE" (
    SET EXTEND=%2
    IF "%2"=="" (
        ECHO OPTION REQUIRES AN ARGUMENT -- 'v'
        GOTO :USAGE  
    )     
    SHIFT & SHIFT & GOTO :INITIAL
 )
 IF "%1" == "-a" SET RESULT=TRUE
 IF "%RESULT%" == "TRUE" (
    SET ACUBIT=%2
    IF "%2"=="" (
        ECHO OPTION REQUIRES AN ARGUMENT -- 'a'
        GOTO :USAGE  
    )     
    SHIFT & SHIFT & GOTO :INITIAL
 )
 IF "%1" == "-c" SET RESULT=TRUE
 IF "%RESULT%" == "TRUE" (
    SET CFLAGS=%2
    IF "%2"=="" (
        ECHO OPTION REQUIRES AN ARGUMENT -- 'c'
        GOTO :USAGE  
    )     
    SHIFT & SHIFT & GOTO :INITIAL
 )
 IF "%1" == "-p" SET RESULT=TRUE
 IF "%RESULT%" == "TRUE" (
    SET ACUPATCH=%2
    IF "%2"=="" (
        ECHO OPTION REQUIRES AN ARGUMENT -- 'p'
        GOTO :USAGE  
    )     
    SHIFT & SHIFT & GOTO :INITIAL
 )
 IF "%1" == "-j" SET RESULT=TRUE
 IF "%RESULT%" == "TRUE" (
    SET ACUJAVA=TRUE
    SHIFT & GOTO :INITIAL
 )
 IF "%1" == "-m" SET RESULT=TRUE
 IF "%RESULT%" == "TRUE" (
    SET ACUMQ=TRUE
    SHIFT & GOTO :INITIAL
 )
 IF "%1" == "-o" SET RESULT=TRUE
 IF "%RESULT%" == "TRUE" (
    SET ACUORA=TRUE
    SHIFT & GOTO :INITIAL
 )
GOTO :SETACUENV

:USAGE
ECHO Options:
ECHO  setenv                         Set the AcuCOBOL environment
ECHO  setenv options parameters      Set the AcuCOBOL environment and Additional Binaries/DLLs
ECHO.    
ECHO Usage: 
ECHO  -v 10.4.0       AcuCOBOL Version
ECHO  -b 32           32 or 64 bit
ECHO  -p 1785         Patch number
ECHO  -j              JAVA
ECHO  -m              MQ
ECHO  -o              ORACLE
ECHO  -c atw          Open ATW Control Panel   
ECHO  -c dir          Open AcuDirectory
ECHO  -c bench        Open AcuBench 
ECHO  -h              Usage
ECHO.
ECHO Example:
ECHO  setenv -v 10.3.1 -a 64         Sets AcuCOBOL 10.3.1 64-Bit
ECHO  setenv -v 10.4.0 -a 64 -j      Sets AcuCOBOL 10.4.0 64-Bit and JAVA 64-Bit
GOTO :END

:SETACUENV
SET ACUPATH32=%DEFPATH32%\extend %EXTEND%
SET ACUPATH64=%DEFPATH64%\extend %EXTEND%
SET DEF=".;%ACUPATH32%\AcuGT\sample\def"
SET XML=".;%ACUPATH32%\AcuGT\sample\xmlext"
SET BMP=".;%ACUPATH32%\AcuGT\sample\acubench\resource"
SET ALL=".;%ACUPATH32%\AcuGT\sample\def;%ACUPATH32%\AcuGT\sample\xmlext;%ACUPATH32%\AcuGT\sample\acubench\resource"
SET COPYPATH=%ALL%
IF '%ACUBIT%'=='' SET ACUBIT=32
IF '%CFLAGS%'=='atw' GOTO :ATW
IF '%CFLAGS%'=='bench' GOTO :ACUBENCH
IF '%CFLAGS%'=='dir' (GOTO :DIRECTORY) ELSE IF NOT '%CFLAGS%'=='FALSE' (ECHO INCORRECT ARGUEMENT FOR OPTION -- 'c' & GOTO :USAGE)
IF '%ACUBIT%'=='32' GOTO :32BIT
IF '%ACUBIT%'=='64' GOTO :64BIT
GOTO :END

:ATW
START "" "%ACUPATH32%\AcuGT\bin%ACUPATCH%\AcuToWeb.exe"
GOTO :END

:ACUBENCH
START "" "%ACUPATH32%\acubench\AcuBench.exe"
GOTO :END

:DIRECTORY
IF '%ACUBIT%'=='32' (
    START "" "%ACUPATH32%"
)
IF '%ACUBIT%'=='64' (
    START "" "%ACUPATH64%"
)
GOTO :END

:32BIT
SET ACUBENCH=%ACUPATH32%\acubench\
SET PATH=C:\etc\acu;%ACUPATH32%\AcuGT\bin%ACUPATCH%;%ACUBENCH%;C:\WINDOWS\system32
SET GENESIS_HOME=%ACUPATH32%
GOTO :SETEXTRAS

:64BIT
SET ACUBENCH=%ACUPATH64%\acubench\
SET PATH=C:\etc\acu;%ACUPATH64%\AcuGT\bin%ACUPATCH%;%ACUBENCH%;C:\WINDOWS\system32
SET GENESIS_HOME=%ACUPATH64%
GOTO :SETEXTRAS

:SETEXTRAS
IF '%ACUBIT%'=='32' (
    IF '%ACUJAVA%'=='TRUE' GOTO :SETJAVA32
    IF '%ACUMQ%'=='TRUE' GOTO :SETMQ32
    IF '%ACUORA%'=='TRUE' GOTO :SETORA32
)
IF '%ACUBIT%'=='64' (
    IF '%ACUJAVA%'=='TRUE' GOTO :SETJAVA64
    IF '%ACUMQ%'=='TRUE' GOTO :SETMQ64
    IF '%ACUORA%'=='TRUE' GOTO :SETORA64
)
GOTO :END

:SETJAVA32
SET ACUJAVA=FALSE
SET JAVA_HOME=%JAVA32%
SET PATH=%JAVA_HOME%\bin\client;%JAVA_HOME%\bin;%PATH%
SET CLASSPATH=.;%ACUPATH32%\AcuGT\bin%ACUPATCH%\CVM.jar;%ACUPATH32%\AcuGT\bin%ACUPATCH%\vortex.jar
SET PRELOAD_JAVA_LIBRARY=1
SET JAVA_LIBRARY_NAME=%JAVA_HOME%\bin\client\JVM.dll
GOTO :SETEXTRAS

:SETJAVA64
SET ACUJAVA=FALSE
SET JAVA_HOME=%JAVA64%
SET PATH=%JAVA_HOME%\bin\client;%JAVA_HOME%\bin;%PATH%
SET CLASSPATH=.;%ACUPATH64%\AcuGT\bin%ACUPATCH%\CVM.jar;%ACUPATH64%\AcuGT\bin%ACUPATCH%\vortex.jar
SET PRELOAD_JAVA_LIBRARY=1
SET JAVA_LIBRARY_NAME=%JAVA_HOME%\bin\client\JVM.dll
GOTO :SETEXTRAS

:SETORA32
SET ACUORA=FALSE
SET ORACLE_HOME=%ORACLE32%
SET PATH=%ORACLE_HOME%;%PATH%
GOTO :SETEXTRAS

:SETORA64
SET ACUORA=FALSE
SET ORACLE_HOME=%ORACLE64%
SET PATH=%ORACLE_HOME%;%PATH%
GOTO :SETEXTRAS

:SETMQ32
SET ACUMQ=FALSE
SET PATH=%MQ%bin;%PATH%
SET SHARED_LIBRARY_LIST=mqic32.dll
GOTO :SETEXTRAS

:SETMQ64
SET ACUMQ=FALSE
SET PATH=%MQ%bin64;%PATH%
SET SHARED_LIBRARY_LIST=mqic.dll
GOTO :SETEXTRAS

:END
