@echo off
REM To run docker in the background you need two things:
REM 1 - Use "docker run -d" to run the container detached.
REM 2 - Start a program in the container in the foreground
REM     otherwise the container exits when there are no
REM     programs running in the foreground.

setlocal

REM Start the AcuToWeb Gateway
cd "C:\Program Files (x86)\Micro Focus\extend 10.5.0\AcuToWeb"
start /b .\Tools\Python\pythonw.exe .\Gateway\main.pyc C:\AppContainerDirectory\gateway_windows.conf

REM Start AcuRCL
cd C:\AppContainerDirectory
acurcl -start -c C:\AppContainerDirectory\acurcl_windows.cfg -l -t7 -e C:\SharedContainerDirectory\acutoweb_windows.out -f
