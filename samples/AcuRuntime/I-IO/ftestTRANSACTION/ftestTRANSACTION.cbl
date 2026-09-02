IDENTIFIcation division.                                                        
program-id.  ftest.                                                             
                                                                                
* this program performs various file i/o tests for benchmarking                 
* purposes.  it should be compiled under acucobol with the                      
* following command:                                                            
*    runcbl ftestio or wrun32 ftestio
*
* NOTE - this program has not been fully tested and there is a possibility
*        that it may contain errors.  Use this code as a guideline only and
*        be sure to test all implementations using this logic.  However it
*        is useful for providing the general concepts for using I$IO.
*
                                                                                
environment division.                                                           
configuration section.                                                          
                                                                                
                                                                                
data division.                                                                  
                                                                                
working-storage section.                                                        

01  ftest-record.                                                               
	03  ftest-key			pic x(4).                                                      
	03  ftest-altkey1.                                                             
		05 seg1			pic x(2).                                                           
		05 seg2			pic x(2).                                                           
	03  ftest-altkey2		pic x(4).                                                   
	03  ftest-number		pic s9(6)v99.                                                
	03  ftest-info			pic x(10).                                                    
                                                                                
* limits and ranges                                                             
                                                                                
78  max-segs                            value 6.                                
                                                                                
77  ftest-status                        pic x(2).                               
77  menu-option				pic 9(2).                                                    
                                                                                
	88  next-selected		value 1.                                                    
	88  previous-selected		value 2.                                                
	88  read-selected		value 3.                                                    
	88  write-selected		value 4.                                                   
	88  delete-selected		value 5.                                                  
	88  rewrite-selected		value 6.                                                 
	88  start-1-selected		value 7.                                                 
	88  start-2-selected		value 8.                                                 
	88  start-3-selected		value 9.                                                 
	88  open-inp-selected		value 10.                                               
	88  open-out-selected		value 11.                                               
	88  open-io-selected		value 12.                                                
	88  close-selected		value 13.                                                  
	88  end-selected		value 14.    
   88  open-trans       value 20. | cccccc                                                
   88  begin-trans      value 21. | cccccc  
   88  commit-trans     value 22. | cccccc  
   88  roll-back        value 23. | cccccc
                                                                                
* the following variables are set when we call "i$io" routine. "io-function" is 
* first parameter we have to pass to "i$io". To turn on the flag, just do       
* " set function-flag( eg open-function ) to 1 .                                
*                                                                               
                                                                                
* "i$io" library functions                                                      
                                                                                
77  io-function                         pic 99 comp-x.                          
	88  open-function                   value 1.                                   
	88  close-function                  value 2.                                   
	88  make-function                   value 3.                                   
	88  info-function                   value 4.                                   
	88  read-function                   value 5.                                   
	88  next-function                   value 6.                                   
	88  previous-function               value 7.                                   
	88  start-function                  value 8.                                   
	88  write-function                  value 9.                                   
	88  rewrite-function                value 10.                                  
	88  delete-function                 value 11.                                  
	88  unlock-function                 value 12.                                  
	88  remove-function                 value 13.                                  
	88  flush-function                  value 14.                                  
	88  execute-function                value 15.                                  
   88  START-TRANSACTION-FUNCTION      VALUE 16.
   88  COMMIT-TRANSACTION-FUNCTION     VALUE 17.
   88  ROLLBACK-FUNCTION               VALUE 18.
   88  RECOVER-FUNCTION                VALUE 19.
   88  IN-TRANSACTION-FUNCTION         VALUE 21.
* standard error values                                                         
77  f-int-errno                         pic s9(4) comp-5 external.              
77  f-errno                             pic s9(4) comp-5 external.              
	88  f-in-error                      values 1 thru 99.                          
	88  e-sys-err                       value 1.                                   
	88  e-param-err                     value 2.                                   
	88  e-too-many-files                value 3.                                   
	88  e-mode-clash                    value 4.                                   
	88  e-rec-locked                    value 5.                                   
	88  e-broken                        value 6.                                   
	88  e-duplicate                     value 7.                                   
	88  e-not-found                     value 8.                                   
	88  e-undef-record                  value 9.                                   
	88  e-disk-full                     value 10.                                  
	88  e-file-locked                   value 11.                                  
	88  e-rec-changed                   value 12.                                  
	88  e-mismatch                      value 13.                                  
	88  e-no-memory                     value 14.                                  
	88  e-missing-file                  value 15.                                  
	88  e-permission                    value 16.                                  
	88  e-no-support                    value 17.                                  
	88  e-no-locks                      value 18.                                  
	88  e-interface                     value 19.                                  
	88  w-no-support                    value 100.                                 
	88  w-dup-ok                        value 101.                                 
                                                                                
77  record-size                         pic 9(4) comp-N.                        
77  start-key-size                      pic 9(4) comp-N.                        
77  key-num                             pic 9(4) comp-N.                        
                                                                                
*01  open-mode                           pic s9(4) comp-5.  | cccccc                     
01  OPEN-MODE                           SIGNED-SHORT.       | cccccc 
                                                                                
78  finput                              value 0.                                
78  foutput                             value 1.                                
78  fio                                 value 2.                                
78  fextend                             value 3.                                
78  fmulti-lock                         value 16.                               
78  fread-lock                          value 256.                              
78  fwrite-lock                         value 512.                              
78  fmass-update                        value 1536.   
78  Ftrans                              VALUE 16384.        | cccccc                          
                                                                                
* start mode and values                                                         
                                                                                
01  start-mode                          pic s9(4) comp-5.                       
	88  f-equals                        value zero.                                
	88  f-not-less                      value 1.                                   
	88  f-greater                       value 2.                                   
	88  f-less                          value 3.                                   
	88  f-not-greater                   value 4.                                   
* "info" mode and values                                                        
                                                                                
77  info-mode                           pic s9(4) comp-5.                       
	88  get-logical-params              value -1.                                  
	88  get-physical-params             value -2.                                  
	88  get-comment                     value -3.                                  
	88  get-record-count                value -4.                                  
	88  get-collating-sequence          value -5.                                  
                                                                                
* "logical" parameters layout                                                   
                                                                                
01  logical-info.                                                               
	03  max-rec-size                    pic 9(5).                                  
	03  l-comma-1                       pic x value ",".                           
	03  min-rec-size                    pic 9(5).                                  
	03  l-comma-2                       pic x value ",".                           
	03  num-keys                        pic 9(3).                                  
	03  l-end                           pic x value low-values.                    
                                                                                
* "physical" parameters layout                                                  
                                                                                
01  physical-info.                                                              
	03  block-multiple                  pic 99.                                    
	03  p-comma-1                       pic x value ",".                           
	03  pre-allocation-amount           pic 9(5).                                  
	03  p-comma-2                       pic x value ",".                           
	03  extension-amount                pic 99.                                    
	03  p-comma-3                       pic x value ",".                           
	03  compression-factor              pic 999.                                   
	03  p-comma-4                       pic x value ",".                           
	03  encryption-flag                  pic 9.                                    
	03  p-end                           pic x value low-values.                    
                                                                                
* key information layout (for 1 key)                                            
                                                                                
01  key-info.                                                                   
 	03  key-data.                                                                 
		05  num-segs                    pic 9.                                        
		05  k-comma-1                   pic x value ",".                              
		05  dups-allowed                pic 9.                                        
        	05  k-comma-2                   pic x value ",".                       
		05  key-size                    pic 9(3).                                     
		05  k-comma-3                   pic x value ",".                              
		05  key-offset                  pic 9(5).                                     
                05  k-comma-4                   pic x value",".                 
 	03  alt1-key-data.                                                            
		05  alt1-num-segs               pic 9.                                        
		05  alt1-k-comma-1              pic x value ",".                              
		05  alt1-dups-allowed            pic 9.                                       
		05  alt1-k-comma-2              pic x value ",".                              
		05  alt1-key-size               pic 9(3).                                     
		05  alt1-k-comma-3              pic x value ",".                              
		05  alt1-key-offset             pic 9(5).                                     
                05  alt1-k-comma-4              pic x value",".                 
 	03  alt2-key-data.                                                            
		05  alt2-num-segs               pic 9.                                        
		05  alt2-k-comma-1              pic x value ",".                              
		05  alt2-dups-allowed            pic 9.                                       
		05  alt2-k-comma-2              pic x value ",".                              
		05  alt2-key-size               pic 9(3).                                     
		05  alt2-k-comma-3              pic x value ",".                              
		05  alt2-key-offset             pic 9(5).                                     
	03  k-end                           pic x value low-values.                    
01  comment				    pic x value low-values.                                      
01  trans				    pic x(256) value low-values.                                   
                                                                                
01  record-count-info.                                                          
	03  number-of-records               pic 9(10).                                 
	03                                  pic x.                                     
                                                                                
* end of filesys.def                                                            
77  key-desc                                pic x(2500) value low-values.       
77  key-desc2                               pic x(2500).                        
77  input-handle                            usage pointer.                      
77  output-handle                           usage pointer.                      
                                                                                
01  file-name                               pic x(60).                          
                                                                                
01  read-status				pic s9(9).                                                   
77  indx				pic 9(4) comp-5.                                                    
77  rec-size				pic 9(4) comp-5.                                                
77  rec-count				pic s9(10).                                                    
                                                                                
01  run-information.                                                            
	05 num-arguments		pic 9(4) comp-1.                                             
	05 run-mode			pic x value "I".                                                 
		88 interactive		value "I".                                                    
		88 batch-mode		value "B".                                                     
                                                                                
78  cbl-max-rec				value 32767.                                                 
01  record-area.                                                                
 	03 occurs cbl-max-rec times	pic x.                                            
                                                                                
01 error-items.                                                                 
	03 filler pic x(20) value   "System Error".                                    
	03 filler pic x(20) value   "Parameter error".                                 
	03 filler pic x(20) value   "Too many files".                                  
	03 filler pic x(20) value   "Mode Clash".                                      
	03 filler pic x(20) value   "Record Locked".                                   
	03 filler pic x(20) value   "Broken File".                                     
	03 filler pic x(20) value   "Duplicate Key".                                   
	03 filler pic x(20) value   "Record Not Found".                                
	03 filler pic x(20) value   "Undefined Record".                                
	03 filler pic x(20) value   "Disk Full".                                       
	03 filler pic x(20) value   "File Locked".                                     
	03 filler pic x(20) value   "Record Changed".                                  
	03 filler pic x(20) value   "Mismatch".                                        
	03 filler pic x(20) value   "No Memory ".                                      
	03 filler pic x(20) value   "Missing File".                                    
	03 filler pic x(20) value   "Permission Error".                                
	03 filler pic x(20) value   "No Support".                                      
	03 filler pic x(20) value   "No Locks".                                        
	03 filler pic x(20) value   "Interface".                                       
	03 filler pic x(20) value   "No Support".                                      
	03 filler pic x(20) value   "Duplicates OK".                                   
01 error-table redefines error-items.                                           
	03 error-lit occurs 21 times pic x(20).                                        
                                                                                
*---------------------------------------------------                            
01  operation                   pic x(40).                                      
01  error-window		pic x(10).                                                    
01  error-text			pic x(80).                                                     
01  error-status.                                                               
	03 primary-error	pic x(2).                                                     
	03 secondary-error	pic x(10).                                                  
01  sql-command			pic x(75).                                                    
                                                                                
                                                                                
screen section.                                                                 
                                                                                
01  record-screen.	                                                             
	03  primary-screen.                                                            
		05  "Primary: ", line 4 column 5.                                             
		05  using ftest-key, line 4, column 14.                                       
	03  alt1-screen.                                                               
		05  "Alt1: ", line 5 ,column 5.                                               
		05  using ftest-altkey1, line 5, column 14.                                   
	03  alt2-screen.                                                               
		05  "Alt2: ", line 6 ,column 5.                                               
		05  using ftest-altkey2, line 6, column 14.                                   
	03  info-screen.                                                               
		05  "Info Field: ",line 7 column 5.                                           
		05  using ftest-info, line 7, column 17.                                      
	03  number-screen.                                                             
		05  "number Field: ",line 8 column 5.                                         
		05  using ftest-number, line 8, column 20.                                    
                                                                                
01   options-screen.                                                            
	03  "1. Next ",         line 14 column 5.                                      
	03  "2. Previous ",     line 15 column 5.                                      
	03  "3. Read ",         line 16 column 5.                                      
	03  "4. Write ",        line 17 column 5.                                      
	03  "5. Delete ",       line 18 column 5.                                      
	03  "6. Rewrite ",      line 19 column 5.                                      
	03  "7. Start 1",       line 20 column 5.                                      
                                                                                
	03  "8. Start 2",       line 14 column 25.                                     
	03  "9. Start 3",       line 15 column 25.                                     
	03  "10. Open Input",   line 16 column 25.                                     
	03  "11. Open Output",  line 17 column 25.                                     
	03  "12. Open IO",      line 18 column 25.                                     
	03  "13. Close",        line 19 column 25.                                     
	03  "14. End ",         line 20 column 25. 
	                         
   03  "20. Open trans",   line 21 column 5.  | cccccc                                    
   03  "21. Begin trans",  line 22 column 5.  | cccccc                                   
   03  "22. Commit",       line 21 column 25.  | cccccc                                     
   03  "23. Rollback",     line 22 column 25.  | cccccc 
                                     
	03  using menu-option, line 23 column 5.                                       
procedure division.                                                             
                                                                                
ftest-err-handling section.                                                     
ftest-err.                                                                      
	call "C$RERR" using error-status, error-text.                                  
	display window line 8 column 20 size 40 lines 8 ,                              
		centered title "ERROR",                                                       
		boxed, pop-up area error-window.                                              
                                                                                
	display "FILE STATUS: ",ftest-status.                                          
	display "SECONDARY ERROR: ",secondary-error.                                   
	if f-errno not = 0                                                             
		display "COBOL ERROR: ",error-lit(f-errno),bold.                              
	display "SQL ERROR: ",error-text.                                              
	accept omitted.                                                                
	close window error-window.                                                     
                                                                                
level-1 section.                                                                
main-logic.                                                                     
                                                                                
	set configuration"KEYSTROKE" to "EDIT=NEXT TERMINATE=13 ^M".                   
	display window erase.                                                          
	move all "_" to ftest-record.                                                  
	display record-screen.                                                         
	display options-screen.                                                        
	display box line 2 column 2 size 40 lines 8 , title "FTEST RECORD".            
	display box line 13 column 2 size 40 lines 12 , title "OPTIONS".               
	perform get-option with test after until end-selected.                         
	stop run.                                                                      
                                                                                
get-option.                                                                     
                                                                                
	accept options-screen.                                                         
	display omitted line 24 column 60 erase end line.                              
	evaluate true                                                                  
		when  next-selected                                                           
			perform do-next                                                              
		when  previous-selected                                                       
			perform do-previous                                                          
		when  read-selected                                                           
			perform do-read                                                              
		when  write-selected                                                          
			perform do-write                                                             
		when  delete-selected                                                         
			perform do-delete                                                            
		when  rewrite-selected                                                        
			perform do-rewrite                                                           
		when  start-1-selected                                                        
			perform do-start-1                                                           
		when  start-2-selected                                                        
			perform do-start-2                                                           
		when  start-3-selected                                                        
			perform do-start-3                                                           
		when  open-inp-selected                                                       
                        perform open-input-routine                              
		when  open-out-selected                                                       
                        perform open-output-routine                             
		when  open-io-selected                                                        
                        perform open-io-routine                                 
		when  close-selected                                                          
                        perform close-routine                  
      when open-trans                                 | cccccc                                       
                        perform open-io-trans-routine | cccccc                             
      when begin-trans
           SET START-TRANSACTION-FUNCTION TO TRUE
           CALL "I$IO" USING IO-FUNCTION                                  
      when commit-trans                               | cccccc 
           SET COMMIT-TRANSACTION-FUNCTION TO TRUE    | cccccc
           CALL "I$IO" USING IO-FUNCTION              | cccccc                                              
      when roll-back
*******     SET ROLL-BACK TO TRUE                     | cccccc  
           SET ROLLBACK-FUNCTION TO TRUE              | cccccc
           CALL "I$IO" USING IO-FUNCTION
		when  end-selected                                                            
			continue                                                                     
	end-evaluate.                                                                  
                                                                                
file-operations.                                                                
                                                                                
*===============================================================================
*                                                                               
* function do-next                                                              
*    This routine reads the next record in the sequence of records specified by 
*    current key reference. When the file is first opened, its key of reference 
*    primary key and the file positioned so that the "next" record is the first 
*    in the file.                                                               
*                                                                               
*===============================================================================
do-next.                                                                        
        set next-function to true.                                              
        call "i$io" using io-function,input-handle,record-area.                 
        if return-code not = zero                                               
		display " next successful" line 24 column 60 erase end line                   
                move record-area to ftest-record                                
	        display record-screen                                                  
        else                                                                    
                go to ftest-err                                                 
        end-if.                                                                 
                                                                                
*===============================================================================
*                                                                               
* function do-next                                                              
*    This function is designed to retrieve the previous record. File handler sho
*    the correct value. File handler is formatted at file open time.            
*                                                                               
*===============================================================================
do-previous.                                                                    
        set previous-function to true.                                          
        call "i$io" using io-function, input-handle, record-area.               
        if return-code not = zero                                               
		display "previous successful" line 24 column 60 erase end line                
                move record-area to ftest-record                                
        	display record-screen                                                  
        else                                                                    
                go to ftest-err                                                 
        end-if.                                                                 
*===============================================================================
*                                                                               
* function do-read                                                              
*    This function is designed to retrieve the record by using the primary key. 
*    key-num is the key number to read from. Key "0" is the primary key. A succe
*    "i-read" cause the curreny key of reference to be set to key-num and the fi
*    position is set to the record read.                                        
*                                                                               
*===============================================================================
do-read.                                                                        
	accept primary-screen.                                                         
        set read-function to true.                                              
        move ftest-record to record-area.                                       
        move zero to key-num.                                                   
        call "i$io" using io-function, input-handle, record-area, key-num.      
        if return-code not = zero                                               
		display "read successful" line 24 column 60 erase end line                    
                move record-area to ftest-record                                
        	display record-screen                                                  
        else                                                                    
                go to ftest-err                                                 
        end-if.                                                                 
                                                                                
*===============================================================================
*                                                                               
* function do-write                                                             
*    This routine adds a new record to the file. If record-size is zero, then th
*    record size is used. The user enters the data from the screen, and the data
*    record will write to the file.                                             
*    Note: This routine does not change the current file position or affect the 
*          key of reference.                                                    
*                                                                               
*===============================================================================
do-write.                                                                       
    move zero to read-status.                                                   
    set write-function to true.                                                 
    accept record-screen.                                                       
    move ftest-record to record-area.                                           
    move zero to record-size.                                                   
    call "i$io" using io-function, input-handle, record-area, record-size.      
    if return-code  not = zero                                                  
       display "write successful" line 24 column 60 erase end line              
       move record-area to ftest-record                                         
       display record-screen                                                    
    else                                                                        
       go to ftest-err                                                          
    end-if.                                                                     
*===============================================================================
*                                                                               
* function do-delete                                                            
*    This foutine deletes the record identified by value found in the primary ke
*    record.                                                                    
*    Note: This routine does not change the current file position or affect the 
*          key of reference.                                                    
*                                                                               
*===============================================================================
do-delete.                                                                      
	accept primary-screen.                                                         
        move ftest-record to record-area.                                       
        set delete-function to true.                                            
        call "i$io" using io-function, input-handle, record-area.               
        if return-code  not = zero                                              
           display "delete successful" line 24 column 60 erase end line         
        else                                                                    
           go to ftest-err                                                      
        end-if.                                                                 
                                                                                
*===============================================================================
*                                                                               
* function do-rewrite                                                           
*    This routine replaces an existing record in the file. Record points to the 
*    record to place in the file and size is its size. Size may be zero indicate
*    max record size for the file. The record replaced is specified by the prima
*    key value found in record.                                                 
*    Note: This routine does not change the current file position or affect the 
*          key of reference.                                                    
*                                                                               
*===============================================================================
do-rewrite.                                                                     
	accept record-screen.                                                          
        move ftest-record to record-area.                                       
        move zero to record-size.                                               
        set rewrite-function to true.                                           
        call "i$io" using io-function, input-handle, record-area, record-size.  
        if return-code  not = zero                                              
           display "rewrite successful" line 24 column 60 erase end line        
        else                                                                    
           go to ftest-err                                                      
        end-if.                                                                 
	                                                                               
*===============================================================================
*                                                                               
* function do-start-1                                                           
*    This function selects the current key of reference and positions the file p
*    for the next "i-next" or "i-previous" routine. input-handle is returned for
*    open routine. record-area must contain the key value that will be used to p
*    file. start-key-size indicates the size of the key. If start-key-size is 0,
*    entire key is used. start-mode selects how the file is to be positioned wit
*    respect to the key value defined in record.( check file system interface me
*    key-num 0 indicates use the primary key to do the search.                  
*                                                                               
*===============================================================================
do-start-1.                                                                     
	move spaces to ftest-record.                                                   
	accept primary-screen.                                                         
        move ftest-record to record-area.                                       
        set start-function to true.                                             
        move zero to key-num.                                                   
        move zero to start-key-size.                                            
        set f-not-less to true.                                                 
        call "i$io" using io-function, input-handle, record-area, key-num,      
		 start-key-size, start-mode.                                                  
        if return-code  not = zero                                              
           display "start primary successful" line 24 column 60 erase end line  
        else                                                                    
           go to ftest-err                                                      
        end-if.                                                                 
*===============================================================================
*                                                                               
* function do-start-2                                                           
*    This function selects the current key of reference and positions the file p
*    for the next "i-next" or "i-previous" routine. input-handle is returned for
*    open routine. record-area must contain the key value that will be used to p
*    file. start-key-size indicates the size of the key. If start-key-size is 0,
*    entire key is used. start-mode selects how the file is to be positioned wit
*    respect to the key value defined in record.( check file system interface me
*    key-num 1 indicates use the first alternate key to do the search.          
*                                                                               
*===============================================================================
do-start-2.                                                                     
	move spaces to ftest-record.                                                   
	accept alt1-screen.                                                            
        move ftest-record to record-area.                                       
        set start-function to true.                                             
        move 1 to key-num.                                                      
        move zero to start-key-size.                                            
        set f-not-less to true.                                                 
        call "i$io" using io-function, input-handle, record-area, key-num,      
		 start-key-size, start-mode.                                                  
        if return-code  not = zero                                              
           display "start first alt successful" line 24 column 60 erase end line
        else                                                                    
           go to ftest-err                                                      
        end-if.                                                                 
                                                                                
*===============================================================================
*                                                                               
* function do-start-3                                                           
*    This function selects the current key of reference and positions the file p
*    for the next "i-next" or "i-previous" routine. input-handle is returned for
*    open routine. record-area must contain the key value that will be used to p
*    file. start-key-size indicates the size of the key. If start-key-size is 0,
*    entire key is used. start-mode selects how the file is to be positioned wit
*    respect to the key value defined in record.( check file system interface me
*    key-num 2 indicates use the second alternate key to do the search.         
*                                                                               
*===============================================================================
do-start-3.                                                                     
	move spaces to ftest-record.                                                   
	accept alt2-screen.                                                            
        move ftest-record to record-area.                                       
        set start-function to true.                                             
        move 2 to key-num.                                                      
        move zero to start-key-size.                                            
        set f-not-less to true.                                                 
        call "i$io" using io-function, input-handle, record-area, key-num,      
		 start-key-size, start-mode.                                                  
        if return-code  not = zero                                              
          display "start second alt successful" line 24 column 60
                 erase end line
        else                                                                    
           go to ftest-err                                                      
        end-if.                                                                 
*===============================================================================
*                                                                               
* function open-input-routine / open-output-routine / open-io-routine.	         
*    This routine opens an existing indexed file. It return a file pointer that 
*    to identify if file is opened successfully. If it fails, it returns NULL.  
*    If file cannot open successfully, perform create-file routine to create a n
*    After the file is opened, the primary key is set as the current key of refe
*    and is positioned at the beginning of the file.                            
*                                                                               
*===============================================================================
open-input-routine.                                                             
        set open-function to true.                                              
*        move fio to open-mode.                                                 
        move finput to open-mode.                                               
        move "ftest.dat" to file-name.                                          
        call "i$io" using io-function, file-name, open-mode, logical-info.      
        if return-code not = zero                                               
	        display "open successful" line 24 column 60                            
		         erase end line                                                       
                move return-code to input-handle                                
        else                                                                    
                perform create-file                                             
	end-if.                                                                        
                                                                                
open-output-routine.                                                            
        set open-function to true.                                              
        move fio to open-mode.                                                  
        move "ftest.dat" to file-name.                                          
        call "i$io" using io-function, file-name, open-mode, logical-info.      
        if return-code not = zero                                               
	        display "open successful" line 24 column 60                            
		         Erase end line                                                       
                move return-code to input-handle                                
        else                                                                    
                perform create-file                                             
	end-if.                                                                            
                                                                                
open-io-trans-routine.                                                     | cccccc                                                               
        set open-function to true.                                         | cccccc                                          
        compute open-mode = fio + ftrans.                                  | cccccc                                                     
        move "ftest.dat" to file-name.                                     | cccccc                                           
        call "i$io" using io-function, file-name, open-mode, logical-info. | cccccc        
        if return-code not = zero                                          | cccccc       
	        display "open trans successful" line 24 column 60                | cccccc         
		         Erase end line                                                | cccccc                       
                move return-code to input-handle                           | cccccc           
	end-if.                                                                  | cccccc        
                                                                                
open-io-routine.                                                                
        set open-function to true.                                              
        move fio to open-mode.                                                  
        move "ftest.dat" to file-name.                                          
        call "i$io" using io-function, file-name, open-mode, logical-info.      
        if return-code not = zero                                               
	        display "open successful" line 24 column 60                            
		         Erase end line                                                       
                move return-code to input-handle                                
	end-if.                                                                        
	move spaces to menu-option.                                                    
*===============================================================================
*                                                                               
* function close-routine.                                                       
*    This routine closes an open file. The parameter input-handle is holding a f
*    address which is returned from open routines.                              
*                                                                               
*=============================================================================  
close-routine.                                                                  
        set close-function to true.                                             
        call "i$io" using io-function, input-handle.                            
        if return-code not = zero                                               
	        display "close successful" line 24 column 60                           
		         Erase end line                                                       
	end-if.                                                                        
	move spaces to menu-option.                                                    
                                                                                
*===============================================================================
*                                                                               
* function create-file.                                                         
*    When file does not open successfully, this function will create a new index
*    The C function will be called through this routine is i-make().            
*    Format physical info by default value.                                     
*    Format logical information which contains minimum and maximum record size, 
*    number of the keys in the record.                                          
*    Format key information( reference File System Interface documentation )    
*                                                                               
*===============================================================================
create-file.                                                                    
                                                                                
* physical info.                                                                
    move zero to block-multiple.                                                
    move zero to pre-allocation-amount.                                         
    move zero to extension-amount.                                              
    move zero to compression-factor.                                            
    move zero to encryption-flag.                                               
                                                                                
* logical info                                                                  
    move 30 to max-rec-size.                                                    
    move 30 to min-rec-size.                                                    
    move 3 to num-keys.                                                         
                                                                                
* keys info.                                                                    
    move 1 to num-segs.                                                         
    move zero to dups-allowed.                                                  
    move 4 to key-size.                                                         
    move zero to key-offset.                                                    
                                                                                
    move 1 to alt1-num-segs.                                                    
    move 1 to alt1-dups-allowed.                                                
    move 4 to alt1-key-size.                                                    
    move 4 to alt1-key-offset.                                                  
                                                                                
    move 1 to alt2-num-segs.                                                    
    move 1 to alt2-dups-allowed.                                                
    move 4 to alt2-key-size.                                                    
    move 8 to alt2-key-offset.                                                  
                                                                                
    inspect physical-info replacing all space by low-value.                     
    inspect logical-info replacing all space by low-value.                      
    inspect key-desc replacing all space by low-value.                          
    set make-function to true.                                                  
    move key-info to key-desc.                                                  
    call "i$io" using io-function, file-name,comment , physical-info,           
    	logical-info, key-desc.                                                    
    if return-code = zero                                                       
       display "create file error" line 24 column 60                            
         Erase end line                                                         
    end-if.                                                                     
    set open-function to true.                                                  
    move fio to open-mode.                                                      
    call "i$io" using io-function, file-name, open-mode, logical-info.          
    if return-code not = zero                                                   
       display "file open successful" line 24 column 60                         
         Erase end line                                                         
       move return-code to input-handle                                         
    end-if.                                                                     
    move spaces to menu-option.                                                 
