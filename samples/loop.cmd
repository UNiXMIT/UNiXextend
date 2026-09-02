@ECHO OFF
for /l %%x in (1, 1, 600) do (
start msedge "http://awslinux:3000/?hostgw=awslinux&portgw=8000&alias=tour"
    timeout /T 1 /NOBREAK > NUL
    cls
    echo %%x ATW Connections Started...
)