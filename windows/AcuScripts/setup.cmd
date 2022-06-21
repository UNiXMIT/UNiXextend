@ECHO OFF

:: Install Software
choco feature enable -n=allowGlobalConfirmation
choco install brave
:: choco install visualstudio2017professional
:: choco install visualstudio2019professional
:: choco install visualstudio2022professional
choco install vscode /NoDesktopIcon
choco install 7zip
choco install adobereader
choco install microsoft-windows-terminal
choco install sysinternals
choco install vcredist140
choco install revo-uninstaller
choco install lockhunter
choco install insomnia-rest-api-client
choco install dotnet3.5
choco install lessmsi
choco install linkshellextension
choco install dotpeek
choco install tinytask
choco install nircmd
choco install speedtest
choco install hashtab

:: Create directories, change permissions and set PATH
md \temp
cacls \temp /e /p Everyone:f
md \etc
cacls \etc /e /p Everyone:f
md \AcuDataFiles
cacls \AcuDataFiles /e /p Everyone:f
md \AcuSamples
cacls \AcuSamples /e /p Everyone:f
md \AcuScripts
cacls \AcuScripts /e /p Everyone:f
setx /m PATH "%PATH%;\AcuScripts"

:: Disable Firewall
netsh advfirewall set allprofiles state off

:: Turn off IE Enhanced Security Configuration 
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}" /v "IsInstalled" /t REG_DWORD /d 0 /f 
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}" /v "IsInstalled" /t REG_DWORD /d 0 /f

Rundll32 iesetup.dll, IEHardenLMSettings 
Rundll32 iesetup.dll, IEHardenUser 
Rundll32 iesetup.dll, IEHardenAdmin

REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}" /f /va REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}" /f /va

:: Enable OpenSSH Server
powershell -command "Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0"

:: Download Scripts
cd AcuScripts
curl -O https://raw.githubusercontent.com/UNiXMIT/UNiXextend/master/windows/AcuScripts/admin.cmd
curl -O https://raw.githubusercontent.com/UNiXMIT/UNiXextend/master/windows/AcuScripts/version.cmd
curl -O https://raw.githubusercontent.com/UNiXMIT/UNiXextend/master/windows/AcuScripts/setenv.cmd