@echo off
REM bld.bat - Build a Windows image for running extend products in a container.
setlocal
setlocal EnableDelayedExpansion
REM ----------------------------------------------------------------------------
REM Set default values
set DRYRUN=
set EULAARG=no
set APP=no
REM ----------------------------------------------------------------------------
if .%1 == . goto no_arguments

:argloop
if .%1 == . goto endofargs

if /I .%1 == .dryrun (
	shift
	set DRYRUN=echo DRYRUN:
	goto argloop
)
if /I .%1 == .IacceptEULA (
	set EULAARG=yes
	shift
	goto argloop
)
if /I .%1 == .win_x64 (
	set ENV=%1
	for /F "tokens=1,2 delims==" %%a in (bld_!ENV!.env) do (
		set %%a=%%b
	)
	shift
	goto argloop
)
if /I .%1 == .app (
	set APP=yes
	shift
	goto argloop
)
if /I .%1 == .rmi (
	set ENV=win_x64
	for /F "tokens=1,2 delims==" %%a in (bld_!ENV!.env) do (
		set %%a=%%b
	)
	echo Removing image !BASEIMAGE!
	docker rmi --force !BASEIMAGE! 2>nul
	echo Removing image !APPIMAGE!
	docker rmi --force !APPIMAGE! 2>nul
	goto theend
)
if /I NOT .%1 == .xxx (
	echo Invalid argument: "%1"
	shift
	goto argloop
)

:endofargs
REM ----------------------------------------------------------------------------
REM Use default platform if one was not specified on the command line
if /I .%ENV% == . (
	echo Using default platform: win_x64
	set ENV=win_x64
	for /F "tokens=1,2 delims==" %%a in (bld_!ENV!.env) do (
		set %%a=%%b
	)
)
REM ----------------------------------------------------------------------------
if /I .%APP% == .yes (
	set ENV=win_x64_app
)
REM ----------------------------------------------------------------------------
if .%EULAARG% == .yes goto bldcont
echo Invalid argument, EULA not accepted.
echo.
goto no_arguments
REM ----------------------------------------------------------------------------
:bldcont
REM Build the image

if /I .%ENV% == .win_x64 (
	%DRYRUN% docker build ^
	--tag %BASEIMAGE% ^
	--build-arg BASEOSIMAGE=%BASEOSIMAGE% ^
	--build-arg ACCEPT_CONTAINER_EULA=%EULAARG% ^
	--build-arg ADDLOCAL="%ADDLOCAL%" ^
	--build-arg MSI="%MSI%" ^
	--build-arg EXTEND_VERSION="%EXTEND_VERSION%" ^
	--file %DOCKERFILE% ^
	.
)

if /I .%ENV% == .win_x64_app (
	%DRYRUN% docker build ^
	--tag %APPIMAGE% ^
	--build-arg BASEIMAGE=%BASEIMAGE% ^
	--build-arg EXTEND_VERSION="%EXTEND_VERSION%" ^
	--build-arg APPCONTAINERDIRECTORY="%CD%\AppContainerDirectory" ^
	--file %DOCKERFILE%_app ^
	.
)

REM ----------------------------------------------------------------------------
goto theend
REM ----------------------------------------------------------------------------
:no_arguments
echo Usage: bld.bat IacceptEULA [options]
echo.
echo Options:
echo   IacceptEULA - indicates the acceptance of the EULA (required)
echo   win_x64     - build a Windows image with 64-bit products
echo   app         - build an image based on the extend image and
echo                 include the AppContainerDirectory
echo   rmi         - indicates that you want to remove the microfocus/extend
echo                 images via 'docker rmi --force'
echo   dryrun      - don't create an image, just echo the command that would
echo                 be used to do it.
echo.
echo Examples:
echo       bld.bat IacceptEULA win_x64
echo       bld.bat IacceptEULA win_x64 app
echo       bld.bat rmi
goto theend
REM ----------------------------------------------------------------------------
:theend
