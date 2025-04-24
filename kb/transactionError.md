# What is the cause for the transaction error 9E-12? What can be done to fix it?
## Environment
AcuCOBOL-GT extend (All Versions)   
Windows and Linux    
 
## Situation
The documentation for AcuCOBOL-GT extend says that a 9E 12 occurs because “the last transaction in the log file is incomplete”. What can cause this and what is the solution to get back up and running?  

## Resolution
It’s hard to pinpoint the exact cause of the error without seeing what was happening at the time or reproducing the error in a test environment. The most possible cause is that the process crashed (or was killed) in the middle of writing the transaction log, and now the log is permanently incomplete.   

To recover from this error, make sure all users are logged out of the system and recover from the transaction log to make sure the files are consistent. Then start logging from that point. - https://docs.rocketsoftware.com/bundle/acucobolgt_dg_1051_html/page/BKPPPPLIBRS077.html  