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

:: Install/Configure Software
:: Requires 'App Installer' - https://apps.microsoft.com/store/detail/app-installer/9NBLGGH4NNS1
winget install 7zip.7zip --accept-source-agreements --accept-package-agreements
winget install Microsoft.Sysinternals.Autoruns --accept-source-agreements --accept-package-agreements
winget install Brave.Brave --accept-source-agreements --accept-package-agreements
winget install Microsoft.Sysinternals.ProcessMonitor --accept-source-agreements --accept-package-agreements
winget install Microsoft.Sysinternals.ProcessExplorer --accept-source-agreements --accept-package-agreements
winget install Microsoft.VisualStudioCode --accept-source-agreements --accept-package-agreements
winget install Microsoft.VCRedist.2015+.x86 --accept-source-agreements --accept-package-agreements
winget install Microsoft.VCRedist.2015+.x64 --accept-source-agreements --accept-package-agreements
winget install WinSCP.WinSCP --accept-source-agreements --accept-package-agreements

:: Desktop CleanUp
del /q \Users\support\Desktop\*
del /q \Users\Public\Desktop\* 
del /q \Users\Administrator\Desktop\*

:: Import VSCode settings and install VSCode Extensions
call "C:\Program Files\Microsoft VS Code\bin\code" --install-extension zhuangtongfa.material-theme
call "C:\Program Files\Microsoft VS Code\bin\code" --install-extension bitlang.cobol
call "C:\Program Files\Microsoft VS Code\bin\code" --install-extension micro-focus-amc.mfenterprise
curl -s -o C:\Users\support\AppData\Roaming\Code\User\settings.json https://raw.githubusercontent.com/UNiXMIT/UNiXextend/master/windows/etc/settings.json
curl -s -o C:\Users\support\AppData\Roaming\Code\User\keybindings.json https://raw.githubusercontent.com/UNiXMIT/UNiXextend/master/windows/etc/keybindings.json

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

:: Add directories to QuickAccess
powershell -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "$o = new-object -com shell.application;$o.Namespace('c:\temp').Self.InvokeVerb('pintohome');"
powershell -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "$o = new-object -com shell.application;$o.Namespace('c:\etc').Self.InvokeVerb('pintohome');"
powershell -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "$o = new-object -com shell.application;$o.Namespace('c:\AcuSupport').Self.InvokeVerb('pintohome');"
powershell -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "$o = new-object -com shell.application;$o.Namespace('c:\AcuResources').Self.InvokeVerb('pintohome');"
powershell -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "$o = new-object -com shell.application;$o.Namespace('c:\AcuDataFiles').Self.InvokeVerb('pintohome');"
powershell -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "$o = new-object -com shell.application;$o.Namespace('c:\AcuSamples').Self.InvokeVerb('pintohome');"
powershell -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "$o = new-object -com shell.application;$o.Namespace('c:\AcuScripts').Self.InvokeVerb('pintohome');"

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
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFilesExt /t REG_DWORD /d 0 /f

cd \temp

:END