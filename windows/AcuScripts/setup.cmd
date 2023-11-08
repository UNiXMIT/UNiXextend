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
net localgroup administrators support /add

:: Install Chocolatey
powershell -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "[System.Net.ServicePointManager]::SecurityProtocol = 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
setx /m PATH "%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

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
:: Package Parameters for VS
:: --package-parameters "--wait --quiet --norestart --add Microsoft.Net.Component.4.5.TargetingPack --add Microsoft.Net.Component.4.5.2.TargetingPack --add Microsoft.VisualStudio.Component.Debugger.JustInTime --add Microsoft.VisualStudio.Component.GraphDocument --add Microsoft.VisualStudio.Component.NuGet --add Microsoft.VisualStudio.Component.DockerTools --add Microsoft.VisualStudio.Component.VisualStudioData --add Microsoft.VisualStudio.Component.Web --add Microsoft.VisualStudio.Workload.ManagedDesktop --add Microsoft.VisualStudio.Workload.Azure --add Microsoft.VisualStudio.Component.Wcf.Tooling --add Microsoft.VisualStudio.Component.SQL.SSDT --add Microsoft.VisualStudio.Workload.NetCoreTools --downloadThenInstall"
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

:: Import VSCode settings and install VSCode Extensions
call "C:\Program Files\Microsoft VS Code\bin\code" --install-extension zhuangtongfa.material-theme
call "C:\Program Files\Microsoft VS Code\bin\code" --install-extension bitlang.cobol
call "C:\Program Files\Microsoft VS Code\bin\code" --install-extension micro-focus-amc.mfenterprise
curl -s -o %APPDATA%\Code\User\settings.json https://raw.githubusercontent.com/UNiXMIT/UNiXextend/master/windows/etc/settings.json
curl -s -o %APPDATA%\Code\User\keybindings.json https://raw.githubusercontent.com/UNiXMIT/UNiXextend/master/windows/etc/keybindings.json

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
md \MFSamples
cacls \MFSamples /e /p Everyone:f
md \MFSamples\JCL
cacls \MFSamples\JCL /e /p Everyone:f
md \MFDataFiles
cacls \MFDataFiles /e /p Everyone:f
md \MFScripts
cacls \MFScripts /e /p Everyone:f
setx /m PATH "C:\AcuScripts;C:\MFScripts;%PATH%"

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

:: Download MFScripts
cd \MFScripts
curl -s -O https://raw.githubusercontent.com/UNiXMIT/UNiXMF/main/windows/MFScripts/FormatDumps.cmd
curl -s -O https://raw.githubusercontent.com/UNiXMIT/UNiXMF/main/windows/MFScripts/AutoPAC.cmd

:: Download JCL
cd \MFSamples\JCL
curl -s -O https://raw.githubusercontent.com/UNiXMIT/UNiXMF/main/windows/MFScripts/JCL.xml
curl -s -O https://raw.githubusercontent.com/UNiXMIT/UNiXMF/main/windows/MFScripts/JCL.zip

:: Disable Firewall
netsh advfirewall set allprofiles state off

:: Enable OpenSSH Server
powershell -command "Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0"
sc config sshd start=auto

:: Defer Updates
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v DeferFeatureUpdates /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v DeferFeatureUpdatesPeriodInDays /t REG_DWORD /d 90 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v DeferQualityUpdates /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v DeferQualityUpdatesPeriodInDays /t REG_DWORD /d 30 /f

:: Disable UAC
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 0 /f

:: Show file extensions
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFilesExt /t REG_DWORD /d 0 /f

:: Disable Monitor Timeout
powercfg -change -monitor-timeout-ac 0
powercfg -change -monitor-timeout-dc 0

:: Turn off IE Enhanced Security Configuration 
:: reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}" /v "IsInstalled" /t REG_DWORD /d 0 /f 
:: reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}" /v "IsInstalled" /t REG_DWORD /d 0 /f

cd \temp

:END