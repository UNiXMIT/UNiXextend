       identification division.
       program-id. prog.
       author. supportline@microfocus.com. 
       remarks.       
       environment division.
       SPECIAL-NAMES. 
           SYSERR IS ERROR-LOG.               
       input-output section.
       file-control.
       data division.
       file section.
              
       working-storage section.

       copy "acugui.def".
	   COPY "acucobol.def".

       77  FILE-STATUS               PIC 9(3).   
       
       77  ws-errors                 pic 9 value 0.
       
       01  FILE-INFO-SERVER. 
           02  FILE-SIZE-SERVER    PIC X(8) COMP-X. 
           02  FILE-DATE-SERVER    PIC 9(8) COMP-X. 
           02  FILE-TIME-SERVER    PIC 9(8) COMP-X. 

       01  FILE-INFO-CLIENT. 
           02  FILE-SIZE-CLIENT    PIC X(8) COMP-X. 
           02  FILE-DATE-CLIENT    PIC 9(8) COMP-X. 
           02  FILE-TIME-CLIENT    PIC 9(8) COMP-X. 

       77  time-start              pic 9(8).
       77  time-end                pic 9(8).
       77  ws-size                 pic X(18).
       77  pd-handle usage handle value 0.
       77  rval pic 9(5) value 0.
	   77  EXIT-STATUS         pic 9(3).
           
       procedure division.
       main-logic.
           
           CALL "w$progressdialog" using WPROGRESSDIALOG-CREATE
		   "File Copy" "Cancel Message"
		   giving pd-handle

           perform 100-timeout
		   
		   CALL "w$progressdialog"
		   using WPROGRESSDIALOG-SET-PROGRESS
           pd-handle 10 40
		   
		   perform 110-cancel
		   
		   perform 100-timeout
		   
		   CALL "w$progressdialog"
		   using WPROGRESSDIALOG-SET-PROGRESS
           pd-handle 20 40
		   
		   perform 110-cancel
		   
		   perform 100-timeout
		   
		   CALL "w$progressdialog"
		   using WPROGRESSDIALOG-SET-PROGRESS
           pd-handle 30 40
		   
		   perform 110-cancel
		   
		   perform 100-timeout
		   
		   CALL "w$progressdialog"
		   using WPROGRESSDIALOG-SET-PROGRESS
           pd-handle 40 40
		   
		   perform 110-cancel
		   
		   stop run.
		   
		100-timeout.
		   CALL "C$SYSTEM" USING "timeout.bat",
		   CSYS-SHELL 
		   GIVING EXIT-STATUS.
		   
        110-cancel.        
           CALL "w$progressdialog"
		   using WPROGRESSDIALOG-QUERY-CANCEL
           pd-handle giving rval

           if rval = 1
		   
           CALL "w$progressdialog" using WPROGRESSDIALOG-DESTROY 
                                         pd-handle
		   end-if.
       	   