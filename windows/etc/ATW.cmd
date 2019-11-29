@ECHO OFF
net stop "AcuToWeb 8030"
start /w "" "C:\Windows\System32\notepad.exe" C:\etc\1030-gateway.conf
net start "AcuToWeb 8030"
