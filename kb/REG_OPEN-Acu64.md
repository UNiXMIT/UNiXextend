# When using the 64 bit runtime, REG_OPEN_KEY_EX or DISPLAY_REG_OPEN_KEY_EX returns an error ‘invalid or missing parameter’
## Environment
AcuCOBOL-GT extend from 10.5.0 onward  
Windows  
Linux/UNIX (when using Thin Client)  

## Situation
Calling REG_OPEN_KEY_EX or DISPLAY_REG_OPEN_KEY_EX with the 64 bit runtime returns an error ‘invalid or missing parameter’. In 10.4.1 and lower, it never returned an error.  

## Resolution
In previous versions, when using the 64 bit runtime, a HANDLE was used to receive the HKEY. HANDLE is always 32 bit but when using the 64 bit runtime the Win32 API returns a POINTER which is 64 bit. This could cause problems.  
In 10.5.0 we test that the variable is big enough to hold the HKEY value.   
Windows may have returned small values that fit into HANDLE before, but it is not guaranteed. Programs that still use HANDLE with the 64 bit runtime should be updated to use POINTER instead.  