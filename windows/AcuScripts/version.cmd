@ECHO OFF

SET EXTEND=%1
IF '%1'=='' GOTO END

:SET-DEFAULT-VERSION
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Micro Focus\ACUCOBOL-GT" /V "DefaultVersion" /t REG_SZ /d "%EXTEND%" /f
GOTO END

:END