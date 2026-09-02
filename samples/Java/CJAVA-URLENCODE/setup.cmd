@echo off
SET "ACUCOBOL=C:\Program Files (x86)\Micro Focus\extend 10.5.1\AcuGT"
SET "JAVA_HOME=C:\MTurner\AcuSamples\Java\CJAVA-URLENCODE\jdk-17.0.17+10"

SET PATH=%ACUCOBOL%\bin;%JAVA_HOME%\bin\client;%JAVA_HOME%\bin;%PATH%
SET CLASSPATH=.
SET PRELOAD_JAVA_LIBRARY=1
SET JAVA_LIBRARY_NAME=%JAVA_HOME%\bin\client\JVM.dll
ECHO.
ECHO PATH and CLASSPATH have been set!
ECHO.
ECHO Running Program to URL Encode
ECHO.
wrun32 -d url.acu