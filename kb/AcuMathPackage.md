# Difference in performance and undefined behaviour of math package in AcuCOBOL-GT extend 8.1.0 vs 10.5.0
## Environment
AcuCOBOL-GT extend 8.1.2 or later  
Windows  
Linux/UNIX  

## Situation
The performance of the math package (i.e. COMPUTE etc.) has dropped since 8.1.2 and is now slower. Also the undefined behaviour (i.e. using spaces in numeric data) is different.  

## Resolution
The default math package changed from binary to decimal in 8.1.2. To change the math package back to binary, in version 8.1.2 and later, use the compiler option '--bin'.  
In all defined cases, the two packages work identically. Differences may be seen, between the 2 maths packages, with undefined cases (i.e. using spaces in numeric data). The binary package and the decimal package may not always return the same result in undefined cases.  

More details can be found in the documentation at:  
ACUCOBOL-GT Version 10.5.0 Documentation Set > ACUCOBOL-GT User's Guide > Compiler and Runtime > Using the Compiler > Miscellaneous Options  
and  
ACUCOBOL-GT Version 10.5.0 Documentation Set > Appendices > Appendix C. Changes Affecting Previous Versions > Changes Affecting Version 8.1.2  

 
## Additional Information
The AcuCOBOL Documentation and Resources are available here:  
https://docs.rocketsoftware.com/bundle?labelkey=prod_acucobol_gt  