@ECHO OFF

SET EXTEND=%1
IF '%1'=='' GOTO END

reg add "HKCU\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "C:\Program Files (x86)\Micro Focus\extend %EXTEND%\AcuGT\bin\acurcl.exe" /t REG_SZ /d "~ RUNASADMIN" /f
reg add "HKCU\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "C:\Program Files (x86)\Micro Focus\extend %EXTEND%\AcuGT\bin\AcuToWeb.exe" /t REG_SZ /d "~ RUNASADMIN" /f
GOTO END

:END