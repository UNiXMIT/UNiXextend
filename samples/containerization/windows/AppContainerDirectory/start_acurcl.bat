@echo off
REM To run docker in the background you need two things:
REM 1 - Use "docker run -d" to run the container detached.
REM 2 - Start a program in the container in the foreground
REM     otherwise the container exits when there are no
REM     programs running in the foreground.

setlocal

REM Start AcuRCL
cd C:\AppContainerDirectory
acurcl -start -c C:\AppContainerDirectory\acurcl_windows.cfg -l -t7 -e C:\SharedContainerDirectory\acurcl_windows.out -f
