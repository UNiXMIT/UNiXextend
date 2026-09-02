       identification division.  
       program-id. TestNetToCobol.  
       REMARKS.    
           [ccbl32 -ga --netdll TestNetToCobol.cbl]
       environment division.  
       configuration section.  
       data division.  
       working-storage section.  
        
       linkage section.  
       77 string-in-out          pic x(32) value spaces.  
       77 int-in-out             USAGE IS SIGNED-INT.  
        
       procedure division using string-in-out, int-in-out.  
       main-logic.  
        
            move "hey whats doin" to string-in-out.  
            entry "int-only" using int-in-out.  
            move 9999 to int-in-out.  
            exit program.  