       IDENTIFICATION DIVISION.
       PROGRAM-ID. prog.
       AUTHOR.  supportline@microfocus.com. 
       REMARKS.    
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.         
       DATA DIVISION.
       FILE SECTION.       
       WORKING-STORAGE SECTION.       
       copy "acucobol.def".       
       LINKAGE SECTION.       
       SCREEN SECTION.
       PROCEDURE DIVISION.
       MAIN-LOGIC.       
           
           ACCEPT TERMINAL-ABILITIES FROM TERMINAL-INFO.  
 
           IF IS-REMOTE
              IF TERMINAL-NAME = "AcuToWeb"
                 | AcuToWeb
              ELSE
                 | AcuThin
              END-IF
           ELSE
             | wrun32.exe           
           END-IF 
           
           goback.
           .       	   