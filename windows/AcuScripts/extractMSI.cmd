@ECHO OFF
msiexec /a "%~1" /qb TARGETDIR="%CD%\%~1 Contents"