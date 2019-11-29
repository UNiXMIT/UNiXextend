@ECHO OFF

:: Modify AcuVersion here
SET EXTEND=10.3.0

:: Modify AcuPath here if not in default install location
SET ACUPATH32=C:\Program Files (x86)\Micro Focus\extend %EXTEND%\
SET ACUPATH64=C:\Program Files\Micro Focus\extend %EXTEND%\

SET DEF=".;%ACUPATH32%AcuGT\sample\def"
SET XML=".;%ACUPATH32%AcuGT\sample\xmlext"
SET BMP=".;%ACUPATH32%AcuGT\sample\acubench\resource"
SET ALL=".;%ACUPATH32%AcuGT\sample\def;%ACUPATH32%AcuGT\sample\xmlext;%ACUPATH32%AcuGT\sample\acubench\resource"
SET COPYPATH=%ALL%

IF '%1'=='32' GOTO 32BIT
IF '%1'=='64' GOTO 64BIT
IF '%1'=='b' GOTO ACUBENCH
IF '%1'=='B' GOTO ACUBENCH

:32BIT
SET ACUCOBOL=%ACUPATH32%AcuGT\
SET CHOICE=%EXTEND% 32bit
IF '%2'=='p' GOTO PATCH
IF '%2'=='d' GOTO DIRECTORY
GOTO SETPATH

:64BIT
SET ACUCOBOL=%ACUPATH64%AcuGT\
SET CHOICE=%EXTEND% 64bit
IF '%2'=='p' GOTO PATCH
IF '%2'=='d' GOTO DIRECTORY
GOTO SETPATH

:SETPATH
SET ACUBENCH=%ACUPATH32%acubench\
SET PATH=%ACUCOBOL%bin%2;%ACUBENCH%;C:\WINDOWS\system32;C:\etc\acu;C:\etc\Shortcuts
SET GENESIS_HOME=%ACUCOBOL%
ECHO.
ECHO %CHOICE% %2
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

:END
