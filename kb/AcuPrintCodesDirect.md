# Epson ESC/P functions, being sent to format the print, are not recognised when using '-P SPOOLER-DIRECT'
## Environment
AcuCOBOL-GT extend  
Windows  

## Situation
When sending prints direct to an Epson printer using -P SPOOLER-DIRECT or -Q printername;DIRECT=ON, that include Epson ESC/P control codes, the control codes are printed rather than being interpreted by the printer.  

## Resolution
Check that the driver being used is compatible with Epson ESC/P control codes. An older Centronics-based driver might be needed so that the control codes are recognised and the driver can then send the correct commands to the printer.  
Switching from a USB to USB cable to a USB to Centronics (parallel) cable may force the use of an older Centronics-based driver.  