# Compiler and Runtime Version Compatibility
## Environment
Enterprise Developer  
Enterprise Server  
Visual COBOL  
COBOL Server  
AcuCOBOL-GT extend  
Windows  
Linux/UNIX  

## Symptoms
Do the compiler and runtime need to be the same version?  
Can applications compiled with one product version be run using a different runtime version?  
Is it supported to use different compiler and runtime versions?  

## Solution
Using different versions for compilation and execution is not recommended. While applications compiled with one version may function correctly when executed with a different version, this configuration is not tested and is therefore not considered a supported deployment scenario.  
If issues are encountered in an environment where the compiler and runtime versions differ, it is recommended to first reproduce the issue using matching versions. This helps determine whether the problem is related to the version mismatch before it is reported for further investigation.  