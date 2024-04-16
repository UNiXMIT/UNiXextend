@ECHO OFF

:: Set the path to other installations here:
SET JAVA32=
SET JAVA64=
SET ORACLE32=
SET ORACLE64=
SET MQ=
SET MQSERVER=DEV.APP.SVRCONN/TCP/127.0.0.1

:: Default AcuVersion
SET EXTEND=
:: SET EXTEND=10.5.1
IF "%EXTEND%"=="" FOR /F "tokens=2*" %%A IN ('REG.EXE QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Micro Focus\ACUCOBOL-GT" /S /V "DefaultVersion" 2^>NUL ^| FIND "REG_SZ"') DO SET "EXTEND=%%B"

SET INSTALLDIR32=
SET INSTALLDIR64=
SET PUBLICDIR=
:: SET "INSTALLDIR32=C:\Program Files (x86)\Micro Focus"
:: SET "INSTALLDIR64=C:\Program Files\Micro Focus"
:: SET "PUBLICDIR=C:\Users\Public\Documents\Micro Focus"
SET ACUBIT=
SET CFLAGS=FALSE
SET ACUPATCH=
SET ACUJAVA=
SET ACUORA=
SET ACUMQ=
SET ACUDEF=
SET ACUADMIN=
SET ADMINPATH=

:INITIAL
 SET RESULT=FALSE
 IF "%1" == "-h" SET RESULT=TRUE
 IF "%RESULT%" == "TRUE" (
 GOTO :USAGE
 )
 IF "%1" == "-v" SET RESULT=TRUE
 IF "%RESULT%" == "TRUE" (
    SET EXTEND=%2
    IF "%2"=="" (
        ECHO OPTION REQUIRES AN ARGUMENT -- "v"
        GOTO :USAGE  
    )     
    SHIFT & SHIFT & GOTO :INITIAL
 )
 IF "%1" == "-b" SET RESULT=TRUE
 IF "%RESULT%" == "TRUE" (
    SET ACUBIT=%2
    IF "%2"=="" (
        ECHO OPTION REQUIRES AN ARGUMENT -- "b"
        GOTO :USAGE  
    )     
    SHIFT & SHIFT & GOTO :INITIAL
 )
 IF "%1" == "-c" SET RESULT=TRUE
 IF "%RESULT%" == "TRUE" (
    SET CFLAGS=%2
    IF "%2"=="" (
        ECHO OPTION REQUIRES AN ARGUMENT -- "c"
        GOTO :USAGE  
    )     
    SHIFT & SHIFT & GOTO :INITIAL
 )
 IF "%1" == "-p" SET RESULT=TRUE
 IF "%RESULT%" == "TRUE" (
    SET ACUPATCH=%2
    IF "%2"=="" (
        ECHO OPTION REQUIRES AN ARGUMENT -- "p"
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
 IF "%1" == "-d" SET RESULT=TRUE
 IF "%RESULT%" == "TRUE" (
    SET ACUDEF=TRUE
    SHIFT & GOTO :INITIAL
 )
 IF "%1" == "-a" SET RESULT=TRUE
 IF "%RESULT%" == "TRUE" (
    SET ACUADMIN=TRUE
    SHIFT & GOTO :INITIAL
 )
GOTO :SETACUENV

:USAGE
ECHO Options:
ECHO  setenv                         Set the AcuCOBOL environment
ECHO  setenv options parameters      Set the AcuCOBOL environment and Additional Binaries/DLLs
ECHO.    
ECHO Usage: 
ECHO  -v 10.5.1       AcuCOBOL Version
ECHO  -b 32           32 or 64 bit
ECHO  -p 1785         Patch number
ECHO  -j              JAVA
ECHO  -m              MQ
ECHO  -o              ORACLE
ECHO  -c atw          Open ATW Control Panel   
ECHO  -c dir          Open Install Directory
ECHO  -c bench        Open AcuBench 
ECHO  -d              Set Default AcuCOBOL Version in Registry (Example: setenv -d -v 10.5.0)
ECHO  -a              Set RUNASADMIN for acurcl.exe AcuToWeb.exe and acuserve.exe (Example: setenv -a -v 10.5.0)
ECHO  -h              Usage
ECHO.
ECHO Example:
ECHO  setenv -v 10.3.1 -b 64         Sets AcuCOBOL 10.5.0 64-Bit
ECHO  setenv -v 10.4.0 -b 64 -j      Sets AcuCOBOL 10.5.0 64-Bit and JAVA 64-Bit
ECHO.  
ECHO Patches can be loaded using -p if you have copied the patched bin into the AcuGT directory and name it binXXXX where XXXX is the patch number like "bin1785"
ECHO Example:
ECHO  setenv -v 10.4.0 -b 32 -p 1785        Sets AcuCOBOL 10.4.0 32-Bit Patch Number 1785
GOTO :END

:SETACUENV
IF "%INSTALLDIR32%"=="" (FOR /F "tokens=2*" %%A IN ('REG.EXE QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Micro Focus\ACUCOBOL-GT\%EXTEND%" /S /V "INSTALLDIR" 2^>NUL ^| FIND "REG_SZ"') DO SET "INSTALLDIR32=%%B") ELSE (SET "INSTALLDIR32=%INSTALLDIR32%\extend %EXTEND%\")
IF "%INSTALLDIR64%"=="" (FOR /F "tokens=2*" %%A IN ('REG.EXE QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Micro Focus\ACUCOBOL-GT\%EXTEND%" /S /V "INSTALLDIR" 2^>NUL ^| FIND "REG_SZ"') DO SET "INSTALLDIR64=%%B") ELSE (SET "INSTALLDIR64=%INSTALLDIR64%\extend %EXTEND%\")
IF "%PUBLICDIR%"=="" (FOR /F "tokens=2*" %%A IN ('REG.EXE QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Micro Focus\ACUCOBOL-GT\%EXTEND%" /S /V "PUBLICDIR" 2^>NUL ^| FIND "REG_SZ"') DO SET "PUBLICDIR=%%B") ELSE (SET "PUBLICDIR=%PUBLICDIR%\extend %EXTEND%\")
SET DEF=".;%PUBLICDIR%sample\def;%PUBLICDIR%sample"
SET XML=".;%PUBLICDIR%sample\xmlext;%PUBLICDIR%sample"
SET BMP=".;%PUBLICDIR%sample\acubench\resource;%PUBLICDIR%sample"
SET ALL=".;%PUBLICDIR%sample\def;%PUBLICDIR%sample\xmlext;%PUBLICDIR%sample\acubench\resource;%PUBLICDIR%sample"
SET "COPYPATH=.;%PUBLICDIR%sample\def;%PUBLICDIR%sample\xmlext;%PUBLICDIR%sample\acubench\resource;%PUBLICDIR%sample"
IF "%ACUBIT%"=="" SET ACUBIT=32
IF "%ACUDEF%"=="TRUE" GOTO :SET-DEFAULT-VERSION
IF "%ACUADMIN%"=="TRUE" GOTO :ACUADMIN
IF "%CFLAGS%"=="atw" GOTO :ATW
IF "%CFLAGS%"=="bench" GOTO :ACUBENCH
IF "%CFLAGS%"=="dir" (GOTO :DIRECTORY) ELSE IF NOT "%CFLAGS%"=="FALSE" (ECHO INCORRECT ARGUEMENT FOR OPTION -- "c" & GOTO :USAGE)
IF "%ACUBIT%"=="32" GOTO :32BIT
IF "%ACUBIT%"=="64" GOTO :64BIT
GOTO :END

:SETTIMESTAMP
SET FILE_TRACE_TIMESTAMP=TRUE

:ATW
IF "%ACUBIT%"=="32" (
    START "" "%INSTALLDIR32%AcuGT\bin%ACUPATCH%\AcuToWeb.exe"
)
IF "%ACUBIT%"=="64" (
    START "" "%INSTALLDIR64%AcuGT\bin%ACUPATCH%\AcuToWeb.exe"
)
GOTO :END

:ACUBENCH
IF "%ACUBIT%"=="32" (
    START "" "%INSTALLDIR32%acubench\AcuBench.exe"
)
IF "%ACUBIT%"=="64" (
    START "" "%INSTALLDIR64%acubench\AcuBench.exe"
)
GOTO :END

:DIRECTORY
IF "%ACUBIT%"=="32" (
    START "" "%INSTALLDIR32%"
)
IF "%ACUBIT%"=="64" (
    START "" "%INSTALLDIR64%"
)
GOTO :END

:32BIT
SET ACUBENCH=%INSTALLDIR32%acubench\
SET PATH=C:\AcuScripts;%INSTALLDIR32%AcuGT\bin%ACUPATCH%;%ACUBENCH%;C:\WINDOWS\system32;%PATH%
SET GENESIS_HOME=%INSTALLDIR32%AcuGT
GOTO :SETEXTRAS

:64BIT
SET ACUBENCH=%INSTALLDIR64%acubench\
SET PATH=C:\AcuScripts;%INSTALLDIR64%AcuGT\bin%ACUPATCH%;%ACUBENCH%;%INSTALLDIR32%AcuGT\bin%ACUPATCH%;C:\WINDOWS\system32;%PATH%
SET GENESIS_HOME=%INSTALLDIR64%AcuGT
GOTO :SETEXTRAS

:SETEXTRAS
IF "%ACUBIT%"=="32" (
    IF "%ACUJAVA%"=="TRUE" GOTO :SETJAVA32
    IF "%ACUMQ%"=="TRUE" GOTO :SETMQ32
    IF "%ACUORA%"=="TRUE" GOTO :SETORA32
)
IF "%ACUBIT%"=="64" (
    IF "%ACUJAVA%"=="TRUE" GOTO :SETJAVA64
    IF "%ACUMQ%"=="TRUE" GOTO :SETMQ64
    IF "%ACUORA%"=="TRUE" GOTO :SETORA64
)
GOTO :END

:SETJAVA32
SET ACUJAVA=FALSE
SET JAVA_HOME=%JAVA32%
SET PATH=%JAVA_HOME%\bin\client;%JAVA_HOME%\bin;%PATH%
SET CLASSPATH=.;%INSTALLDIR32%AcuGT\bin%ACUPATCH%\CVM.jar;%INSTALLDIR32%AcuGT\bin%ACUPATCH%\vortex.jar
SET PRELOAD_JAVA_LIBRARY=1
SET JAVA_LIBRARY_NAME=%JAVA_HOME%\bin\client\JVM.dll
GOTO :SETEXTRAS

:SETJAVA64
SET ACUJAVA=FALSE
SET JAVA_HOME=%JAVA64%
SET PATH=%JAVA_HOME%\bin\client;%JAVA_HOME%\bin;%PATH%
SET CLASSPATH=.;%INSTALLDIR64%\AcuGT\bin%ACUPATCH%\CVM.jar;%INSTALLDIR64%AcuGT\bin%ACUPATCH%\vortex.jar
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

:SET-DEFAULT-VERSION
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%ERRORLEVEL%' NEQ '0' (
    ECHO Admin privileges are required!
    timeout /t 5
    GOTO :END
)
IF "%ACUBIT%"=="32" REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Micro Focus\ACUCOBOL-GT" /V "DefaultVersion" /t REG_SZ /d "%EXTEND%" /f
IF "%ACUBIT%"=="64" REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Micro Focus\ACUCOBOL-GT" /V "DefaultVersion" /t REG_SZ /d "%EXTEND%" /f
GOTO :END

:ACUADMIN
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%ERRORLEVEL%' NEQ '0' (
    ECHO Admin privileges are required!
    timeout /t 5
    GOTO :END
)
IF "%ACUBIT%"=="32" (
    IF "%ACUADMIN%"=="TRUE" GOTO :ACUADMIN32
)
IF "%ACUBIT%"=="64" (
    IF "%ACUADMIN%"=="TRUE" GOTO :ACUADMIN64
)

:ACUADMIN32
SET "ADMINPATH=%INSTALLDIR32%AcuGT\bin%ACUPATCH%"
GOTO :ADMINACURCL

:ACUADMIN64
SET "ADMINPATH=%INSTALLDIR64%AcuGT\bin%ACUPATCH%"
GOTO :ADMINACURCL

:ADMINACURCL
REG QUERY "HKCU\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "%ADMINPATH%\acurcl.exe" >nul 2>&1
IF %ERRORLEVEL% == 0 GOTO :ADMINATW
REG ADD "HKCU\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "%ADMINPATH%\acurcl.exe" /t REG_SZ /d "~ RUNASADMIN" /f
GOTO :ADMINATW

:ADMINATW
REG QUERY "HKCU\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "%ADMINPATH%\AcuToWeb.exe" >nul 2>&1
IF %ERRORLEVEL% == 0 GOTO :ADMINACUSERVE
REG ADD "HKCU\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "%ADMINPATH%\AcuToWeb.exe" /t REG_SZ /d "~ RUNASADMIN" /f
GOTO :ADMINACUSERVE

:ADMINACUSERVE
REG QUERY "HKCU\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "%ADMINPATH%\acuserve.exe" >nul 2>&1
IF %ERRORLEVEL% == 0 GOTO :END
REG ADD "HKCU\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "%ADMINPATH%\acuserve.exe" /t REG_SZ /d "~ RUNASADMIN" /f
GOTO :END

:END
