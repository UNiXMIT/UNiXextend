@ECHO OFF
# CHROME
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Google\Chrome" /v InsecurePrivateNetworkRequestsAllowed /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Google\Chrome\InsecurePrivateNetworkRequestsAllowedForUrls" /v 1 /t REG_SZ /d  http://www.example.com:8080 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Google\Chrome\InsecurePrivateNetworkRequestsAllowedForUrls" /v 2 /t REG_SZ /d [*.]example.com /f

# EDGE
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v InsecurePrivateNetworkRequestsAllowed /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge\InsecurePrivateNetworkRequestsAllowedForUrls" /v 1 /t REG_SZ /d  http://www.example.com:8080 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge\InsecurePrivateNetworkRequestsAllowedForUrls" /v 2 /t REG_SZ /d [*.]example.com /f

# BRAVE
reg add "HKEY_LOCAL_MACHINE\Software\Policies\BraveSoftware\Brave" /v InsecurePrivateNetworkRequestsAllowed /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\Software\Policies\BraveSoftware\Brave\InsecurePrivateNetworkRequestsAllowedForUrls" /v 1 /t REG_SZ /d  http://www.example.com:8080 /f
reg add "HKEY_LOCAL_MACHINE\Software\Policies\BraveSoftware\Brave\InsecurePrivateNetworkRequestsAllowedForUrls" /v 2 /t REG_SZ /d [*.]example.com /f