- Install MS Build Tools for the C compiler (cl.exe)
- Modify 'MYCBLPGM' in 'acu.c' to the name of the COBOL program you want to run.
- Open a Developer Command Prompt
- Build the C program:  
    ```
    cl /I "C:\Program Files (x86)\Micro Focus\extend 10.5.1\AcuGT\lib" wrun32.lib acu.c  
    ```