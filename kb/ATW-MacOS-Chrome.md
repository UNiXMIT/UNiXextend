# Cannot start any program using AcuToWeb on MacOS after update of Chrome to version 104.0.5112.79
## Environment
AcuToWeb  
MacOS  
Chrome 104.0.5112.79  
Edge 104.0.1293.54  

## Situation
After a recent update of Chrome to version 104.0.5112.79 on MacOS, no program can be started with AcuToWeb. Safari and Firefox continue to work correctly.  

The following error is shown when using Chrome/Edge:  

```
main.js?10.4.0.921:6 Uncaught ReferenceError: UI is not defined
at ws_connect (main.js?10.4.0.921:6:17634)
at _connect2gateway (main.js?10.4.0.921:6:2209)
at connect2gateway (main.js?10.4.0.921:6:1592)
at ctor._applicationCallback (main.js?10.4.0.921:22:8071)
at ctor._invokeApplicationCallback (main.js?10.4.0.921:11:24417)
at ctor.<anonymous> (main.js?10.4.0.921:11:24629)
at main.js?10.4.0.921:11:27781
at n (main.js?10.4.0.921:23:14010)
at r (main.js?10.4.0.921:23:14167)
at main.js?10.4.0.921:23:14256
ws_connect @ main.js?10.4.0.921:6
_connect2gateway @ main.js?10.4.0.921:6
connect2gateway @ main.js?10.4.0.921:6
(anonymous) @ main.js?10.4.0.921:22
```

## Resolution
Chrome continues to increase security on its browser with each release, especially when visiting unsecure (http) websites. If ATW is secured with SSL certificates (https) then this issue should not occur.  
To get around this error when ATW is not secured with SSL, either of the following 2 Chrome policies have to be enabled:  
InsecurePrivateNetworkRequestsAllowedForUrls - https://bit.ly/3SMLzPz  
InsecurePrivateNetworkRequestsAllowed - https://bit.ly/3Aq64dK  

For example, either of the following 3 commands can be entered into the clients MacOS terminal, making sure to replace the URL with the correct one for your setup, then restart the client machine:  

```
defaults write com.google.Chrome InsecurePrivateNetworkRequestsAllowed -bool true
defaults write com.google.Chrome InsecurePrivateNetworkRequestsAllowedForUrls -string "http://www.example.com:3000""
defaults write com.google.Chrome InsecurePrivateNetworkRequestsAllowedForUrls -string "[*.]example.com" 
```

For Edge just use the same commands but replace com.google.Chrome with com.microsoft.Edge  