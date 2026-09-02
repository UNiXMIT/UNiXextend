       identification division.
       program-id. read-key-sample.
       author. Claudio C.
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
       77 ws-key-name           PIC X(150).
       77 ws-subkey-name        PIC X(20).
       
       procedure division.
       main-logic.
 
            ACCEPT TERMINAL-ABILITIES FROM TERMINAL-INFO.
            ACCEPT ws-key-name        FROM ENVIRONMENT "ENV-KEY-NAME"
            ACCEPT ws-subkey-name     FROM ENVIRONMENT "ENV-SUBKEY-NAME"
            INSPECT ws-key-name    REPLACING TRAILING spaces 
                                   BY low-values
            INSPECT ws-subkey-name REPLACING TRAILING spaces 
                                   BY low-values
       
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
                 using  HKEY_LOCAL_MACHINE,
                        ws-key-name
*******                 key_all_access
                        KEY_QUERY_VALUE
                        my-registry-handle
                 giving registry-status-code
       
            if registry-status-code not = zero
               display message 
               "Key " ws-key-name " not found."
               
            else   
       
               call "REG_QUERY_VALUE_EX" 
                    using  my-registry-handle
                           ws-subkey-name
                           WIN32-REGISTRY-VALUE-TYPE
                           my-value-registry-key
                           data-size-registry
                    giving registry-status-code

       
               display message box "The value of the key is: "
                                   x"A0"
                                   my-value-registry-key
                                   
            end-if
       
            call "REG_CLOSE_KEY" using my-registry-handle.
            
              
       REMOTE section.     
            call "DISPLAY_REG_OPEN_KEY_EX" 
                 using  HKEY_LOCAL_MACHINE,
                        ws-key-name
*******                 key_all_access
                        KEY_QUERY_VALUE
                        my-registry-handle
                 giving registry-status-code
       
            if registry-status-code not = zero
               display message 
               "Key " ws-key-name " not found."
       
            else

               call "DISPLAY_REG_QUERY_VALUE_EX" 
                    using  my-registry-handle
                           ws-subkey-name
                           WIN32-REGISTRY-VALUE-TYPE
                           my-value-registry-key
                           data-size-registry
                    giving registry-status-code
       
               display message box "The value of the key is: "
                                   x"A0"
                                   my-value-registry-key
                                   
            end-if
       
            call "DISPLAY_REG_CLOSE_KEY" using my-registry-handle.