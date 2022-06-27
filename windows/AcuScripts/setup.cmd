@ECHO OFF
:: Create Admin user
net user /add support Unidos30
net localgroup administrators support /add

:: Install Chocolatey
powershell -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "[System.Net.ServicePointManager]::SecurityProtocol = 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

:: Install Software
choco feature enable -n=allowGlobalConfirmation
choco install googlechrome 
choco install vscode /NoDesktopIcon 
choco install sysinternals 
choco install vcredist140 
choco install dotnet3.5 
choco install windows-sdk-10.1
choco install microsoft-build-tools
choco install 7zip 
choco install winscp
:: choco install visualstudio2017professional
:: choco install visualstudio2019professional
:: choco install visualstudio2022professional
:: choco install microsoft-windows-terminal
:: choco install revo-uninstaller
:: choco install lockhunter
:: choco install adobereader
:: choco install insomnia-rest-api-client
:: choco install lessmsi
:: choco install linkshellextension
:: choco install dotpeek
:: choco install tinytask
:: choco install nircmd
:: choco install speedtest
:: choco install hashtab
:: choco install clumsy

del /q \Users\support\Desktop\*
del /q \Users\Public\Desktop\*
del /q \Users\Administrator\Desktop\*

:: Create directories, change permissions and set PATH
md \temp
cacls \temp /e /p Everyone:f
md \etc
cacls \etc /e /p Everyone:f
md \AcuSupport
cacls \AcuSupport /e /p Everyone:f
md \AcuResources
cacls \AcuResources /e /p Everyone:f
md \AcuDataFiles
cacls \AcuDataFiles /e /p Everyone:f
md \AcuSamples
cacls \AcuSamples /e /p Everyone:f
md \AcuScripts
cacls \AcuScripts /e /p Everyone:f
setx /m PATH "C:\AcuScripts;%PATH%"

:: Download AcuScripts
cd \AcuScripts
curl -s -O https://raw.githubusercontent.com/UNiXMIT/UNiXextend/master/windows/AcuScripts/admin.cmd
curl -s -O https://raw.githubusercontent.com/UNiXMIT/UNiXextend/master/windows/AcuScripts/version.cmd
curl -s -O https://raw.githubusercontent.com/UNiXMIT/UNiXextend/master/windows/AcuScripts/setenv.cmd

:: Download etc
cd \etc
curl -s -O https://raw.githubusercontent.com/UNiXMIT/UNiXextend/master/windows/etc/AcuThin-AutoUpdate.cfg
curl -s -O https://raw.githubusercontent.com/UNiXMIT/UNiXextend/master/windows/etc/a_srvcfg
curl -s -O https://raw.githubusercontent.com/UNiXMIT/UNiXextend/master/windows/etc/acurcl.cfg
curl -s -O https://raw.githubusercontent.com/UNiXMIT/UNiXextend/master/windows/etc/acurcl.ini
curl -s -O https://raw.githubusercontent.com/UNiXMIT/UNiXextend/master/windows/etc/boomerang.cfg
curl -s -O https://raw.githubusercontent.com/UNiXMIT/UNiXextend/master/windows/etc/cblconfi
curl -s -O https://raw.githubusercontent.com/UNiXMIT/UNiXextend/master/windows/etc/fillCombo.js
curl -s -O https://raw.githubusercontent.com/UNiXMIT/UNiXextend/master/windows/etc/gateway.conf
curl -s -O https://raw.githubusercontent.com/UNiXMIT/UNiXextend/master/windows/etc/gateway.toml

:: Disable Firewall
netsh advfirewall set allprofiles state off

:: Turn off IE Enhanced Security Configuration 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}" /v "IsInstalled" /t REG_DWORD /d 0 /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}" /v "IsInstalled" /t REG_DWORD /d 0 /f

Rundll32 iesetup.dll, IEHardenLMSettings 
Rundll32 iesetup.dll, IEHardenUser 
Rundll32 iesetup.dll, IEHardenAdmin

reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}" /f /va
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}" /f /va

:: Enable OpenSSH Server
powershell -command "Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0"
sc config sshd start=auto

:: Create Auto Shutdown Schedule
schtasks /create /sc daily /tn "AutoShutdown" /tr "shutdown -s -f -t 0" /st 18:00 /ru support /rp Unidos30 /rl highest

:: Defer Updates
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v DeferFeatureUpdates /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v DeferFeatureUpdatesPeriodInDays /t REG_DWORD /d 90 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v DeferQualityUpdates /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v DeferQualityUpdatesPeriodInDays /t REG_DWORD /d 30 /f

:: Disable UAC
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 0 /f

:: Show file extensions
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFilesExt /t REG_DWORD /d 0 /f

cd \temp
