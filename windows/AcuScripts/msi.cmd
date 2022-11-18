@ECHO OFF

:: USAGE
:: msi "extend(R) Version 10.4.1 x86.msi"
msiexec /a %1 /qb TARGETDIR="%~d1%~p1%~n1"