# What limits does the acurcl.ini file have?
## Environment
AcuCOBOL-GT extend  
Windows  
Linux/UNIX  

## Situation
Does the AcuConnect alias file (acurcl.ini) have any limits on how large it can be or how many alias it can contain?  

## Resolution
There are no limits on the acurcl.ini file with regard its size or number of alias it contains. The size is only limited by available disk space and memory when the file is parsed.  

It might take longer parse the file as it grows larger but there are no benchmarks to say how much longer it would take in this regard.  