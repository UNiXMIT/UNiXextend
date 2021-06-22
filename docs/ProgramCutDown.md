# Cutting Down An ACUCOBOL-GT Application To Submit For Troubleshooting  

When reporting an error or bad behavior in an ACUCOBOL-GT application, the Customer Care engineer may request a test case in order to troubleshoot the issue.  Should a small stand-alone program not demonstrate the behavior, the whole application itself may need to be submitted. However **DO NOT** send the entire application, instead send only the programs and data files that are actually used in demonstrating the issue.   

## INSTRUCTIONS 

1. Start the application with a Runtime trace as described [here](trace.md#Runtime).  

2. Exercise only the steps necessary to demonstrate the bad behavior, and then exit (if the Runtime hasn't already terminated from the bad behavior).  

3. Parse the runtime log file for the programs loaded and for the files opened e.g.

    3a. List all programs loaded:  

    ```
      grep loaded runtime.log | sort | uniq > programs.lst  
    ```

    The programs.lst file will contain the names of all libraries and COBOL programs loaded by the Runtime.  

    3b. List all data files opened:  

    ```
     grep ': open ' runtime.log | sed 's/open.*//' | sort | uniq > files.lst  
    ```

    The files.lst file will contain the names of the files as known by the program.  

    For each of those examine the runtime.log to see if there is a line following the open noting "translated name".  If the disk file has a different name then this line gives that name.  

4. Zip up all of the following and attach to the support incident:  

    - The COBOL program object files, compiled for debug  

    - The COBOL program source files (To avoid having to provide a myriad of copybooks, compile with "-lpo @.src" to produce a single complete source file with all copybooks expanded.)

    - Any libraries loaded by the application (.so, .sl, .dll) that aren't provided with the OS

    - The data files

    - The Runtime configuration file

 5. Update the support incident with the compile command line and instructions for running the application and reproducing the bad behavior.

