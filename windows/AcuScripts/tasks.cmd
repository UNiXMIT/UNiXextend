@ECHO OFF
SET CHOICE=%1
SET VERSION=%2
SET ACUBIT=%3
SET FILENAME=%4

CALL C:\AcuScripts\setenv.cmd %VERSION%

IF "%CHOICE%" == "compile" (
    ECHO Compiling %FILENAME% with version %VERSION%
    ccbl32 %COMPILERFLAGS% %FILENAME%
)
IF "%CHOICE%" == "run" (
    ECHO Running %FILENAME% with version %VERSION% %ACUBIT%-Bit
    wrun32 %RUNTIMEFLAGS% %FILENAME%
)