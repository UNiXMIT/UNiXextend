# ACUCOBOL-GT Trace Files For Troubleshooting
SupportLine engineers frequently require a log file in order to troubleshoot an issue; therefore it is expedient to include these files when reporting a problem.  Following are instructions for obtaining commonly required logs to attach to your support incident.  There are alternatives for some of these instructions, such as setting configuration variables.  Use those ways if they are more familiar to you. 

[General Information](#General-Information)

[Runtime](#Runtime)

[Compiler](#Compiler)

[Thin Client](#Thin-Client)

[AcuToWeb](#AcuToWeb)

[AcuServer](#AcuServer)

[AcuXDBC](#AcuXDBC)


#### Note:
The log files described here are a helpful starting place; additional tracing may be requested by Customer Care to further troubleshoot.


## General Information:

#### Log Name:
All of the log and list files described below may be assigned any name which can include the path.  The Runtime log in recent versions may use wildcards to include unique information in the name:

```
%p - process id
%d - date (YYYYMMDD)
%t - time
%u - username
%h - hostname
```

#### Compressed logs:
The Runtime, AcuServer, and AcuConnect can automatically produce compressed log files by adding the -g option. It is advisable to give the log file an extension of .gz or .zip to indicate it is a compressed archive.

#### Timestamps:
To include timestamps on each line of the log files (does not apply to AcuXDBC logs), before proceeding with the following instructions set this in the environment, or add it to the related configuration file:  FILE_TRACE_TIMESTAMP 1


## Runtime:

1. Add "-dlxe runtime.log" to the Runtime command line.  So it will be something like this on Unix-like OS:

     ```
     runcbl -dlxe runtime.log <other options> programName
     ```

    Or like this on Windows:

     ```
     wrun32 -dlxe runtime.log <other options> programName
     ```

2. At the debugger prompt enter 'tf 9', then 't flush', then 'g'.  Exercise your program to produce the bad behavior, and then exit if the Runtime hasn't already terminated.

3. Zip up runtime.log and attach to the support incident.

 
## Compiler:

1. Add "-lcfoswx @.lst" to your compile options.  So you'll have something like this on Unix-like OS:

     ```
     ccbl -lcfoswx @.lst <other options> programName.cbl
     ```

    Or like this on Windows:

     ```
     ccbl32 -lcfoswx @.lst <other options> programName.cbl
     ```

2. Zip up the list file and attach to the support incident.

 
## Thin Client: 

1. Stop AcuConnect then restart with logging.  Add "-le acurcl.log -t7" to the AcuConnect start command.  Something like:

     ```
     acurcl -start -c acurcl.cfg -le acurcl.log -t7
     ```

    On Windows use the AcuConnect Control Panel, Services tab. Stop the service, edit the properties of the service to specify the error file, set trace level 7, and select the "List configuration …" option, then start the service.

2. Modify the target command line in the shortcut on the client to add "-dlxe runtime.log".  It will be something like:

     ```
     acuthin.exe server:port -dlxe runtime.log aliasName
     ```

3. At the debugger prompt enter 'tf 9', then 't flush', then 'g'.  Exercise your program to produce the bad behavior, and then exit if the Runtime hasn't already terminated.  If you did not include the path for the log file name it will be located in the working directory specified in the alias.

4. Zip up acurcl.log and runtime.log, and attach to the support incident.


## AcuToWeb:
1. Stop the AcuToWeb service. Open the gateway.conf file in Notepad or other text editor.

2. Adjust the following options to assign the following values (change gateway.log path to suit your setup):

     ```
     LOG_LEVEL      15
     LOGFILE        /path/to/gateway.log
     ```
3. Start AcuToWeb then exercise your program to produce the bad behavior, and then exit if the Runtime hasn't already terminated.

4. Zip up the gateway.log and attach to the support incident.


## AcuServer: (in addition to the runtime.log above)

1. Stop AcuServer and restart with logging.  Add "-le acuserve.log -t7" to the AcuServer start command.  Something like:

     ```
     acuserve -start -c a_srvcfg -le acuserve.log -t7
     ```

    On Windows use the AcuServer Control Panel, Services tab. Stop the service, edit the properties of the service to specify the error file, set trace level 7, and select the "List configuration …" option, then start the service

2. Execute your application until the error happens.

3. Zip up acuserve.log and runtime.log, and attach to the support incident.


## AcuXDBC:

1. Open the configuration file in Notepad or other text editor.  By default that is acuxdbc.cfg located in the directory specified in the GENESIS_HOME environment variable.

2. At the bottom there are four logging entries. Uncomment them and assign values as follows:

     ```
     vision_logging_file      /path/to/vision.log 
     vision_logging_level     9   
     debug_logfile            /path/to/debug.log          
     debug_loglevel           3
     ```

3. Execute the ODBC application that is accessing AcuXDBC data and exercise as needed to produce the error.

4. Zip up vision.log and debug.log and attach to the support incident.

    When the error is from AcuXDBC connected to AcuXDBC Server follow the steps above but modify the configuration file on the server.
