@echo off

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
@echo off
set JAVA_HOME=C:\Java\x64\jdk-11.0.5+10
set PATH=%ACUCOBOL%bin;%JAVA_HOME%\bin\client;%JAVA_HOME%\bin;C:\WINDOWS\system32;C:\etc\acu
set CLASSPATH=.;%ACUCOBOL%bin\CVM.jar;%ACUCOBOL%bin\vortex.jar
set PRELOAD_JAVA_LIBRARY=1
set JAVA_LIBRARY_NAME=%JAVA_HOME%\bin\client\JVM.dll
GOTO END

:END
