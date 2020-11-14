@ECHO OFF

:: Ensure JAVA and ORACLE PATHS are correct
IF '%1'=='java' GOTO JAVA
IF '%1'=='JAVA' GOTO JAVA
IF '%1'=='oracle' GOTO ORACLE
IF '%1'=='ORACLE' GOTO ORACLE

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

:32BIT
SET ACUCOBOL=%ACUPATH32%AcuGT\
SET CHOICE=%EXTEND% 32bit
IF '%3'=='p' GOTO PATCH
IF '%3'=='d' GOTO DIRECTORY
GOTO SETPATH

:64BIT
SET ACUCOBOL=%ACUPATH64%AcuGT\
SET CHOICE=%EXTEND% 64bit
IF '%3'=='p' GOTO PATCH
IF '%3'=='d' GOTO DIRECTORY
GOTO SETPATH

:SETPATH
SET ACUBENCH=%ACUPATH32%acubench\
SET PATH=%ACUCOBOL%bin%3;%ACUBENCH%;C:\WINDOWS\system32;C:\etc\acu;C:\etc\Shortcuts
SET GENESIS_HOME=%ACUCOBOL%
ECHO.
ECHO %CHOICE% %3
GOTO END

:PATCH
ECHO.
DIR "%ACUCOBOL%bin1*" /b
GOTO END

:DIRECTORY
CD "%ACUCOBOL%"
START .
GOTO END

:ACUBENCH
START "" "%ACUPATH32%acubench\AcuBench.exe"

:JAVA
IF '%1'=='32' GOTO 32BIT
IF '%1'=='64' GOTO 64BIT

:32bit
set JAVA_HOME=C:\Java\x86\jdk-11.0.5+10
set PATH=%ACUCOBOL%bin;%JAVA_HOME%\bin\client;%JAVA_HOME%\bin;C:\WINDOWS\system32;C:\etc\acu
set CLASSPATH=.;%ACUCOBOL%bin\CVM.jar;%ACUCOBOL%bin\vortex.jar
set PRELOAD_JAVA_LIBRARY=1
set JAVA_LIBRARY_NAME=%JAVA_HOME%\bin\client\JVM.dll
GOTO END

:64bit
set JAVA_HOME=C:\Java\x64\jdk-11.0.5+10
set PATH=%ACUCOBOL%bin;%JAVA_HOME%\bin\client;%JAVA_HOME%\bin;C:\WINDOWS\system32;C:\etc\acu
set CLASSPATH=.;%ACUCOBOL%bin\CVM.jar;%ACUCOBOL%bin\vortex.jar
set PRELOAD_JAVA_LIBRARY=1
set JAVA_LIBRARY_NAME=%JAVA_HOME%\bin\client\JVM.dll
GOTO END

:ORACLE
SET PATH=C:\Oracle\instantclient_18_3;%PATH%

:END
