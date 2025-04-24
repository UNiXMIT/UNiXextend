# Configure START statement to be case-insensitive
## Environment
All versions of AcuCOBOL-GT extend     
Windows  
Linux / UNIX  

## Situation
The COBOL START statement is case-sensitive. Can it be configured to be case-insensitive?  

## Resolution
This can be achieved by setting a custom ALPHABET entry in the SPECIAL-NAMES paragraph and COLLATION SEQUENCE on the SELECT.  
In the SPECIAL-NAMES paragraph add the following (where NO-CASE is a user-defined word that defines an alphabet name):

```
SPECIAL-NAMES.
    ALPHABET NO-CASE IS 1 THRU 65   'A' ALSO 'a' 
    'B' ALSO 'b'   'C' ALSO 'c'   'D' ALSO 'd' 
    'E' ALSO 'e'   'F' ALSO 'f'   'G' ALSO 'g' 
    'H' ALSO 'h'   'I' ALSO 'i'   'J' ALSO 'j' 
    'K' ALSO 'k'   'L' ALSO 'l'   'M' ALSO 'm' 
    'N' ALSO 'n'   'O' ALSO 'o'   'P' ALSO 'p' 
    'Q' ALSO 'q'   'R' ALSO 'r'   'S' ALSO 's' 
    'T' ALSO 't'   'U' ALSO 'u'   'V' ALSO 'v' 
    'W' ALSO 'w'   'X' ALSO 'x'   'Y' ALSO 'y' 
    'Z' ALSO 'z'.
```

In the SELECT clause add the NO-CASE alphabet as the COLLATING SEQUENCE:  

```
FILE-CONTROL.
    SELECT FILE-OUTPUT ASSIGN TO "testFile"
    COLLATING SEQUENCE IS NO-CASE
    ORGANIZATION IS INDEXED
    ACCESS IS DYNAMIC
    RECORD KEY IS FILEKEY
    FILE STATUS IS WS-OUTPUT-STATUS. 
```

Any START performed on this file will now be case-insensitive.  
This will only work on new Vision files created after setting the sections previously mentioned. Any existing Vision files that require a case-insensitive START will need to be re-created as a new Vision file which has the new SELECT.  
This custom ALPHABET can also be used for the COLLATING SEQUENCE in other areas like SORT and MERGE.  

## Additional Information
For more information about the ALPHABET entry and COLLATION SEQUENCE can be found in the documentation at:   
ACUCOBOL-GT Version x.y.z Documentation Set > ACUCOBOL-GT Reference Manual > Environment Division > Input-Output Section > File-Control Paragraph   
ACUCOBOL-GT Version x.y.z Documentation Set > ACUCOBOL-GT Reference Manual > Environment Division > Configuration Section > Special-Names Paragraph  

The AcuCOBOL Documentation and Resources are available here:  
https://docs.rocketsoftware.com/bundle?labelkey=prod_acucobol_gt  
 