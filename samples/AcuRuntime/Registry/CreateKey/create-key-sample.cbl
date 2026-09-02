       identification division.
       program-id. create-key-sample.
       author. supportline@microfocus.com. 
       remarks.
       
       environment division.
       input-output section.         
       
       data division.       
       
       working-storage section.
       copy "acucobol.def".
       copy "acugui.def".
       
       77 REGISTRY-STATUS-CODE  PIC 999.
       77 MY-REGISTRY-HANDLE    USAGE IS HANDLE.
       77 MY-VALUE-REGISTRY-KEY PIC X(50).
       77 data-size-registry    Usage unsigned-long.
       77 ws-string-value       PIC X(50).
       
       procedure division.
       main-logic.
       
            accept terminal-abilities from terminal-info.
       
            if is-remote
      * read registry key on the CLIENT Machine
               perform REMOTE
            else 
      * read registry key on the SERVER Machine
               perform LOCAL
            end-if.
            
            stop run.
            
            
       LOCAL section.     
            call "REG_OPEN_KEY_EX" 
                 using  HKEY_CURRENT_USER,
                        "SOFTWARE\VIP PAYROLL",
                        KEY_QUERY_VALUE,
                        my-registry-handle
                 giving registry-status-code
       
            if registry-status-code = zero
              call "REG_QUERY_VALUE_EX" 
                   using  my-registry-handle,
                          "PREMIERCVSPATH",
                          REG_SZ,
                          ws-string-value,
                          data-size-registry
                   giving registry-status-code
                   
              call "REG_CLOSE_KEY" using my-registry-handle
              
              display message box "The value of the key is: "
                                   x"A0"
                                   ws-string-value   
            else
              call "REG_CREATE_KEY" 
                 using  HKEY_CURRENT_USER,
                        "SOFTWARE\VIP PAYROLL"
                        my-registry-handle
                 giving registry-status-code     
                 
              call "REG_SET_VALUE_EX"
                 using  my-registry-handle,
                        REG_SZ,
                        "C:\AcuSupport\SageVIP\Current", 
                        29,
                        "PREMIERCVSPATH"
                 giving registry-status-code
                 
                 if registry-status-code = 0
                    display message box "OK"
                 else   
                    display message box "Something went wrong."
                 end-if                         
                   
              call "REG_CLOSE_KEY" using my-registry-handle
                                               
            end-if.
              
       REMOTE section. 
            call "DISPLAY_REG_OPEN_KEY_EX" 
                 using  HKEY_CURRENT_USER,
                        "SOFTWARE\VIP PAYROLL",
                        KEY_QUERY_VALUE,
                        my-registry-handle
                 giving registry-status-code
       
            if registry-status-code = zero
              call "DISPLAY_REG_QUERY_VALUE_EX" 
                   using  my-registry-handle,
                          "PREMIERCVSPATH",
                          REG_SZ,
                          ws-string-value,
                          data-size-registry
                   giving registry-status-code
                   
              call "DISPLAY_REG_CLOSE_KEY" using my-registry-handle
              
              display message box "The value of the key is: "
                                   x"A0"
                                   ws-string-value   
            else
              call "DISPLAY_REG_CREATE_KEY" 
                 using  HKEY_CURRENT_USER,
                        "SOFTWARE\VIP PAYROLL"
                        my-registry-handle
                 giving registry-status-code     
                 
              call "DISPLAY_REG_SET_VALUE_EX"
                 using  my-registry-handle,
                        REG_SZ,
                        "C:\AcuSupport\SageVIP\Current", 
                        29,
                        "PREMIERCVSPATH"
                 giving registry-status-code
                 
                 if registry-status-code = 0
                    display message box "OK"
                 else   
                    display message box "Something went wrong."
                 end-if                         
                   
              call "DISPLAY_REG_CLOSE_KEY" using my-registry-handle
                                               
            end-if.