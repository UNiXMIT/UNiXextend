@if not "%VS_CONFIG%"=="" ECHO OFF
rem if invoked by Visual Studio or NMAKE, set quiet mode above
setlocal

REM Before running this batch file:
REM Please set environment variable ACUCOBOL to the ACU extend base directory.

REM Try to find the ACU extend "bin" directory, if not already set
for /F "delims=;" %%F in ("%ACUCOBOL%") do set ACUSHORT=%%~fsF
if "%ACU_PROGRAM_DIR%"=="" (
  if not "%ACUCOBOL%"=="" (
    if exist %ACUSHORT%\bin\nul (
      set ACU_PROGRAM_DIR=%ACUSHORT%\bin
    )
  )
  if exist ..\..\..\bin\ccbl32.exe		 set ACU_PROGRAM_DIR=..\..\..\bin
  if exist ..\..\..\..\bin\ccbl32.exe		 set ACU_PROGRAM_DIR=..\..\..\..\bin
  if exist ..\..\..\..\..\bin\ccbl32.exe	 set ACU_PROGRAM_DIR=..\..\..\..\..\bin
  if exist ..\..\..\..\..\..\bin\ccbl32.exe	 set ACU_PROGRAM_DIR=..\..\..\..\..\..\bin
)
set PATH=%ACU_PROGRAM_DIR%;%PATH%

REM Try to find the XML Extensions copybook directory, if not already set
if "%XML_EXT_DIR%"=="" (
  if not "%ACU_PROGRAM_DIR%"=="" (
    if exist %ACU_PROGRAM_DIR%\..\sample\xmlext\nul (
      set XML_EXT_DIR=%ACU_PROGRAM_DIR%\..\sample\xmlext
    )
  )
  if exist ..\..\..\sample\xmlext\nul		 set XML_EXT_DIR=..\..\..\sample\xmlext
  if exist ..\..\..\..\sample\xmlext\nul	 set XML_EXT_DIR=..\..\..\..\sample\xmlext
  if exist ..\..\..\..\..\sample\xmlext\nul	 set XML_EXT_DIR=..\..\..\..\..\sample\xmlext
  if exist ..\..\..\..\..\..\sample\xmlext\nul	 set XML_EXT_DIR=..\..\..\..\..\..\sample\xmlext
)


REM Compile the sample

set COPYPATH=.;%XML_EXT_DIR%

for %%F in (*.cbl) do ccbl32 -Cr -Sr -Ze -Gz -Ga -Ze %%F
for %%F in (*.acu) do start /w wrun32 -y xmlif.dll -y rmnet.dll %%F

endlocal



