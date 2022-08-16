# Windows

## CHROME
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Google\Chrome" /v InsecurePrivateNetworkRequestsAllowed /t REG_DWORD /d 1 /f  
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Google\Chrome\InsecurePrivateNetworkRequestsAllowedForUrls" /v 1 /t REG_SZ /d  http://www.example.com:8080 /f  
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Google\Chrome\InsecurePrivateNetworkRequestsAllowedForUrls" /v 2 /t REG_SZ /d [*.]example.com /f  

## EDGE
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v InsecurePrivateNetworkRequestsAllowed /t REG_DWORD /d 1 /f  
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge\InsecurePrivateNetworkRequestsAllowedForUrls" /v 1 /t REG_SZ /d  http://www.example.com:8080 /f  
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge\InsecurePrivateNetworkRequestsAllowedForUrls" /v 2 /t REG_SZ /d [*.]example.com /f

## BRAVE
reg add "HKEY_LOCAL_MACHINE\Software\Policies\BraveSoftware\Brave" /v InsecurePrivateNetworkRequestsAllowed /t REG_DWORD /d 1 /f  
reg add "HKEY_LOCAL_MACHINE\Software\Policies\BraveSoftware\Brave\InsecurePrivateNetworkRequestsAllowedForUrls" /v 1 /t REG_SZ /d  http://www.example.com:8080 /f  
reg add "HKEY_LOCAL_MACHINE\Software\Policies\BraveSoftware\Brave\InsecurePrivateNetworkRequestsAllowedForUrls" /v 2 /t REG_SZ /d [*.]example.com /f

# MacOS

## CHROME
defaults write com.google.Chrome InsecurePrivateNetworkRequestsAllowed -bool true  
defaults write com.google.Chrome InsecurePrivateNetworkRequestsAllowedForUrls -string "http://www.example.com:8080"  
defaults write com.google.Chrome InsecurePrivateNetworkRequestsAllowedForUrls -string "[*.]example.com"  

## EDGE
defaults write com.microsoft.Edge InsecurePrivateNetworkRequestsAllowed -bool true  
defaults write com.microsoft.Edge InsecurePrivateNetworkRequestsAllowedForUrls -string "http://www.example.com:8080"  
defaults write com.microsoft.Edge InsecurePrivateNetworkRequestsAllowedForUrls -string "[*.]example.com"  

## BRAVE
defaults write com.brave.Browser InsecurePrivateNetworkRequestsAllowed -bool true  
defaults write com.brave.Browser InsecurePrivateNetworkRequestsAllowedForUrls -string "http://www.example.com:8080"  
defaults write com.brave.Browser InsecurePrivateNetworkRequestsAllowedForUrls -string "[*.]example.com"