# Rebuilding a Vision file with Vutil gives an unrelated error message
## Problem

When rebuilding a Vision file using ‘vutil -rebuild’, part way through it will show an error ‘The Printer is out of paper’ or ‘The device does not recognize the command’. The final Vision file isn’t complete and is missing records.  

```
D:\>vutil32 -rebuild filmografia
Input = filmografia, Output = Vy7xi6y, 3000000 records
Rebuilding...
....10%...
Output record 1509431: The device does not recognize the command.
```

## Resolution

Ensure there is enough space for the rebuilt file before the rebuild is performed.  
This type of error can occur when there is not enough storage space available for the rebuilt Vision file. Vutil receives the error message from Windows and then displays it. It is unknown why Windows returns an unrelated error message when the disk is full.  