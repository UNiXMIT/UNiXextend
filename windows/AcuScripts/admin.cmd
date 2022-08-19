@ECHO OFF

SET EXTEND=%1
IF '%1'=='' GOTO END

:ACURCL
reg query "HKCU\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "C:\Program Files (x86)\Micro Focus\extend %EXTEND%\AcuGT\bin\acurcl.exe" >nul 2>&1
IF %ERRORLEVEL% == 0 GOTO ATW
reg add "HKCU\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "C:\Program Files (x86)\Micro Focus\extend %EXTEND%\AcuGT\bin\acurcl.exe" /t REG_SZ /d "~ RUNASADMIN" /f
GOTO ATW

:ATW
reg query "HKCU\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "C:\Program Files (x86)\Micro Focus\extend %EXTEND%\AcuGT\bin\AcuToWeb.exe" >nul 2>&1
IF %ERRORLEVEL% == 0 GOTO END
reg add "HKCU\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "C:\Program Files (x86)\Micro Focus\extend %EXTEND%\AcuGT\bin\AcuToWeb.exe" /t REG_SZ /d "~ RUNASADMIN" /f
GOTO ACUSERVE

:ACUSERVE
reg query "HKCU\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "C:\Program Files (x86)\Micro Focus\extend %EXTEND%\AcuGT\bin\acuserve.exe" >nul 2>&1
IF %ERRORLEVEL% == 0 GOTO ATW
reg add "HKCU\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "C:\Program Files (x86)\Micro Focus\extend %EXTEND%\AcuGT\bin\acuserve.exe" /t REG_SZ /d "~ RUNASADMIN" /f
GOTO END

:END