@echo off
SET ACUCOBOL=C:\Program Files (x86)\Micro Focus\extend 10.2.1\AcuGT\
set JAVA_HOME=C:\Program Files (x86)\Java\jre1.8.0_202
SET JDBC_DRIVER=C:\AcuSamples\CJAVA-DBCONNECT\mssql-jdbc-6.4.0.jre8.jar

set PATH=%ACUCOBOL%bin;%JAVA_HOME%\bin\client;%JAVA_HOME%\bin;C:\WINDOWS\system32;C:\etc\acu
set CLASSPATH=.;%ACUCOBOL%bin\CVM.jar;%ACUCOBOL%bin\vortex.jar;%JDBC_DRIVER%
set PRELOAD_JAVA_LIBRARY=1
set JAVA_LIBRARY_NAME=%JAVA_HOME%\bin\client\JVM.dll
echo.
echo PATH and CLASSPATH have been set!
ECHO.
ECHO Running Program to connect to SQL SERVER
ECHO.
wrun32 jdbc.acu