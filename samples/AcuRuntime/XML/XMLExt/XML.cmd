@echo off
set ACUPATH=C:\Program Files (x86)\Micro Focus\extend 10.1.0\AcuGT
set PATH=%ACUPATH%\bin;C:\bin;C:\bin\UnxUtils\usr\local\wbin;C:\WINDOWS\system32;C:\Program Files (x86)\Java\jre1.8.0_121\bin\client
wrun32 -y xmlif.dll example1.acu