@ECHO OFF

>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%ERRORLEVEL%' NEQ '0' (
    ECHO "Admin privileges are required!"
    timeout /t 5
    GOTO :END
)

:: Create Admin user
net accounts /maxpwage:unlimited
net user administrator Unidos30
net user /add support Unidos30
net localgroup administrators support /add

:: Install Chocolatey
powershell -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "[System.Net.ServicePointManager]::SecurityProtocol = 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

:: Install/Configure Software
choco feature enable -n=allowGlobalConfirmation
choco install googlechrome
choco install vscode /NoDesktopIcon 
choco install autoruns
choco install procmon
choco install procexp
choco install vcredist140 
choco install 7zip 
choco install winscp
:: choco install visualstudio2017professional
:: choco install visualstudio2019professional
:: choco install visualstudio2022professional
:: choco install dotnet
:: choco install windows-sdk-10.1
:: choco install microsoft-build-tools
:: choco install office365business
:: choco install microsoft-windows-terminal
:: choco install revo-uninstaller
:: choco install lockhunter
:: choco install adobereader
:: choco install insomnia-rest-api-client
:: choco install linkshellextension
:: choco install dotpeek
:: choco install tinytask
:: choco install speedtest
:: choco install clumsy

:: Desktop CleanUp at 'support' first Logon
ECHO @ECHO OFF > \users\Public\Documents\CleanupDesktop.cmd
ECHO del /q \Users\support\Desktop\* >> \users\Public\Documents\CleanupDesktop.cmd
ECHO del /q \Users\Public\Desktop\* >> \users\Public\Documents\CleanupDesktop.cmd
ECHO del /q \Users\Administrator\Desktop\* >> \users\Public\Documents\CleanupDesktop.cmd
ECHO schtasks /change /tn "CleanupDesktop" /DISABLE >> \users\Public\Documents\CleanupDesktop.cmd
schtasks /create /sc ONLOGON /tn "CleanupDesktop" /tr "\users\Public\Documents\CleanupDesktop.cmd" /ru support /rp Unidos30 /rl highest /f

:: Import VSCode settings and install VSCode Extensions at 'support' first Logon
ECHO @ECHO OFF > \users\Public\Documents\VSCode.cmd
ECHO call "C:\Program Files\Microsoft VS Code\bin\code" --install-extension zhuangtongfa.material-theme >> \users\Public\Documents\VSCode.cmd
ECHO call "C:\Program Files\Microsoft VS Code\bin\code" --install-extension bitlang.cobol >> \users\Public\Documents\VSCode.cmd
ECHO call "C:\Program Files\Microsoft VS Code\bin\code" --install-extension micro-focus-amc.mfenterprise >> \users\Public\Documents\VSCode.cmd
ECHO curl -s -o C:\Users\support\AppData\Roaming\Code\User\settings.json https://raw.githubusercontent.com/UNiXMIT/UNiXextend/master/windows/etc/settings.json >> \users\Public\Documents\VSCode.cmd
ECHO curl -s -o C:\Users\support\AppData\Roaming\Code\User\keybindings.json https://raw.githubusercontent.com/UNiXMIT/UNiXextend/master/windows/etc/keybindings.json >> \users\Public\Documents\VSCode.cmd
ECHO schtasks /change /tn "VSCode" /DISABLE >> \users\Public\Documents\VSCode.cmd
schtasks /create /sc ONLOGON /tn "VSCode" /tr "\users\Public\Documents\VSCode.cmd" /ru support /rp Unidos30 /rl highest /f

:: extractMSI
reg add "HKEY_CLASSES_ROOT\Msi.Package\shell\extractMSI\command" /ve /t REG_SZ /d "msiexec /a \"%1\" /qb TARGETDIR=\"%1 Contents\"" /f

:: AcuSilent MSI Install Option
reg add "HKEY_CLASSES_ROOT\Msi.Package\shell\runas" /ve /t REG_SZ /d "AcuSilent" /f
reg add "HKEY_CLASSES_ROOT\Msi.Package\shell\runas\command" /ve /t REG_SZ /d "msiexec /i \"%1\" ADDLOCAL=ALL WINDOWSVERSION=PostWindows7 /qb" /f

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
md \AcuLogs
cacls \AcuLogs /e /p Everyone:f
setx /m PATH "C:\AcuScripts;%PATH%"

:: Add directories to QuickAccess at 'support' first Login
ECHO @ECHO OFF > \users\Public\Documents\QuickAccess.cmd
ECHO powershell -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "$o = new-object -com shell.application;$o.Namespace('c:\temp').Self.InvokeVerb('pintohome');" >> \users\Public\Documents\QuickAccess.cmd
ECHO powershell -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "$o = new-object -com shell.application;$o.Namespace('c:\etc').Self.InvokeVerb('pintohome');" >> \users\Public\Documents\QuickAccess.cmd
ECHO powershell -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "$o = new-object -com shell.application;$o.Namespace('c:\AcuSupport').Self.InvokeVerb('pintohome');" >> \users\Public\Documents\QuickAccess.cmd
ECHO powershell -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "$o = new-object -com shell.application;$o.Namespace('c:\AcuResources').Self.InvokeVerb('pintohome');" >> \users\Public\Documents\QuickAccess.cmd
ECHO powershell -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "$o = new-object -com shell.application;$o.Namespace('c:\AcuDataFiles').Self.InvokeVerb('pintohome');" >> \users\Public\Documents\QuickAccess.cmd
ECHO powershell -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "$o = new-object -com shell.application;$o.Namespace('c:\AcuSamples').Self.InvokeVerb('pintohome');" >> \users\Public\Documents\QuickAccess.cmd
ECHO powershell -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "$o = new-object -com shell.application;$o.Namespace('c:\AcuScripts').Self.InvokeVerb('pintohome');" >> \users\Public\Documents\QuickAccess.cmd
ECHO schtasks /change /tn "ModifyQuickAccess" /DISABLE >> \users\Public\Documents\QuickAccess.cmd
schtasks /create /sc ONLOGON /tn "ModifyQuickAccess" /tr "\users\Public\Documents\QuickAccess.cmd" /ru support /rp Unidos30 /rl highest /f

:: Download AcuScripts
cd \AcuScripts
curl -s -O https://raw.githubusercontent.com/UNiXMIT/UNiXextend/master/windows/AcuScripts/setenv.cmd
md .vscode
cacls .vscode /e /p Everyone:f
cd \AcuScripts\.vscode
curl -s -O https://raw.githubusercontent.com/UNiXMIT/UNiXextend/master/windows/AcuScripts/vscode/settings.json
curl -s -O https://raw.githubusercontent.com/UNiXMIT/UNiXextend/master/windows/AcuScripts/vscode/tasks.json

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

:: Enable OpenSSH Server
powershell -command "Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0"
sc config sshd start=auto

:: Create Auto Shutdown Schedule
schtasks /create /sc daily /tn "AutoShutdown" /tr "shutdown -s -f -t 0" /st 18:00 /ru support /rp Unidos30 /rl highest /f
schtasks /change /tn "AutoShutdown" /disable

:: Defer Updates
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v DeferFeatureUpdates /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v DeferFeatureUpdatesPeriodInDays /t REG_DWORD /d 90 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v DeferQualityUpdates /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v DeferQualityUpdatesPeriodInDays /t REG_DWORD /d 30 /f

:: Disable UAC
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 0 /f

:: Show file extensions
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFilesExt /t REG_DWORD /d 0 /f

cd \temp

:END