@ECHO OFF
SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
set prompt=CMD$G$S

REM ######################### Install-IIS.bat ##################################
ECHO.
ECHO Running "%~0"
ECHO.
ECHO This script configures IIS with the features required to run
ECHO Micro Focus Xcentrisity Business Information Server.
ECHO.
ECHO To list available IIS features and their state in Windows 8 and 10+,
ECHO use this command:
ECHO.
ECHO    dism /online /get-features
ECHO.
ECHO The %~nx0 file may be edited to add additional IIS features,
ECHO or remove unwanted IIS features.
ECHO.
REM  (c) Copyright 2018 - 2020 Micro Focus or one of its affiliates.
REM
REM  $Date: 2020-10-15 02:50:41 +0100 (Thu, 15 Oct 2020) $
REM
REM ############################################################################

REM Check for elevation
net file >NUL 2>&1
if %errorlevel% equ 0 goto :prompt
    echo %~nx0 must be run as administrator or with elevated privileges.
    echo Restart with elevation?
    CHOICE /C YNC /M "    Press Y for Yes, N for No, or C for Cancel."
    if %errorlevel% neq 1 ( echo IIS Configuration cancelled & pause & exit /b 1 )
    echo powershell start-process cmd.exe -ArgumentList '/c "%~dpnx0"' -verb runas
    powershell start-process cmd.exe -ArgumentList '/c "%~dpnx0"' -verb runas
    if %errorlevel% neq 0 ( echo Could not launch %~nx0 elevated & pause & exit /b 1 )
    exit /b %ERRORLEVEL%

:prompt
    if not exist "%WinDir%\system32\choice.exe" goto :nochoice
    echo Install or Configure IIS for BIS?
    CHOICE /C YNC /M "    Press Y for Yes, N for No, or C for Cancel."
    if %errorlevel% NEQ 1 ( echo IIS Configuration cancelled & pause & exit /b 1 )

:nochoice

REM Windows provides two ways to configure built-in programs:
REM PKGMGR - Windows 7 through 10 (deprecated starting in 10)
REM DISM   - Windows 8 and later  (preferred)
REM The syntax is different but role names are the same

set HAVE_DISM=
if exist "%WinDir%\system32\Dism.exe" set HAVE_DISM=1

REM These default delimiters are for PKGMGR, override for DISM below
SET "D1= "
SET "D2=;"

if defined HAVE_DISM (
    SET "D1= /featurename:""
    SET "D2=""
)

REM Accumulate the required "roles" in the ROLES environment variable

set ROLES=%ROLES%%D1%IIS-WebServerRole%D2%
set ROLES=%ROLES%%D1%IIS-WebServer%D2%
set ROLES=%ROLES%%D1%IIS-CommonHttpFeatures%D2%
set ROLES=%ROLES%%D1%IIS-StaticContent%D2%
set ROLES=%ROLES%%D1%IIS-DefaultDocument%D2%
set ROLES=%ROLES%%D1%IIS-DirectoryBrowsing%D2%
set ROLES=%ROLES%%D1%IIS-HttpErrors%D2%
set ROLES=%ROLES%%D1%IIS-HealthAndDiagnostics%D2%
set ROLES=%ROLES%%D1%IIS-HttpLogging%D2%
set ROLES=%ROLES%%D1%IIS-LoggingLibraries%D2%
set ROLES=%ROLES%%D1%IIS-RequestMonitor%D2%
set ROLES=%ROLES%%D1%IIS-Security%D2%
set ROLES=%ROLES%%D1%IIS-RequestFiltering%D2%
set ROLES=%ROLES%%D1%IIS-BasicAuthentication%D2%
set ROLES=%ROLES%%D1%IIS-WindowsAuthentication%D2%
set ROLES=%ROLES%%D1%IIS-HttpCompressionStatic%D2%
set ROLES=%ROLES%%D1%IIS-WebServerManagementTools%D2%
set ROLES=%ROLES%%D1%IIS-ManagementConsole%D2%
set ROLES=%ROLES%%D1%WAS-WindowsActivationService%D2%
set ROLES=%ROLES%%D1%WAS-ProcessModel%D2%
set ROLES=%ROLES%%D1%WAS-NetFxEnvironment%D2%
set ROLES=%ROLES%%D1%WAS-ConfigurationAPI%D2%
set ROLES=%ROLES%%D1%IIS-ISAPIExtensions%D2%
set ROLES=%ROLES%%D1%IIS-ISAPIFilter%D2%
set ROLES=%ROLES%%D1%IIS-HttpRedirect%D2%

rem Enable this for IIS 6 Management Compatiblity (required by BISMKDIR but not BISMKAPP)

REM set ROLES=%ROLES%%D1%IIS-IIS6ManagementCompatibility%D2%

rem We will install ASP.NET by default; required for the samples, but not by BIS itself
rem These roles can be disabled with REM if they are not wanted.

set ROLES=%ROLES%%D1%IIS-NetFxExtensibility%D2%
set ROLES=%ROLES%%D1%IIS-ASPNET%D2%
set ROLES=%ROLES%%D1%IIS-NetFxExtensibility45%D2%
set ROLES=%ROLES%%D1%IIS-ASPNET45%D2%
set ROLES=%ROLES%%D1%NetFx4Extended-ASPNET45%D2%

REM These are never required by BIS, but are left as an example of additional IIS features

rem set ROLES=%ROLES%%D1%WCF-HTTP-Activation%D2%
rem set ROLES=%ROLES%%D1%WCF-HTTP-Activation%D2%

REM Configure IIS features and roles
if defined HAVE_DISM (
    echo.
    echo dism.exe /online /norestart /logpath:"%temp%\%~n0.log" /enable-feature /all %ROLES%
         dism.exe /online /norestart /logpath:"%temp%\%~n0.log" /enable-feature /all %ROLES%
    if errorlevel 1 goto :done
) else (
    echo.
    echo start /w pkgmgr /iu:%ROLES% /norestart /l:"%temp%\%~n0.log"
         start /w pkgmgr /iu:%ROLES% /norestart /l:"%temp%\%~n0.log"
)

REM Unlock configuration sections so BISMKDIR/BISMKAPP can add handlers to the metabase
set "APPCMD=%windir%\system32\inetsrv\appcmd.exe"
if not exist "%APPCMD%" (
    echo.
    echo Program "%APPCMD%" not found, cannot unlock the IIS metabase!
) else (
    echo.
    echo appcmd.exe unlock config -section:system.webServer/handlers
         "%appcmd%" unlock config -section:system.webServer/handlers
    REM  Not required, but left as an example
    REM  "%appcmd%" unlock config -section:anonymousAuthentication
    REM  "%appcmd%" unlock config -section:windowsAuthentication
    echo.
    echo IIS configuration complete!
    echo You may now install or repair BIS.
)

pause

:done
