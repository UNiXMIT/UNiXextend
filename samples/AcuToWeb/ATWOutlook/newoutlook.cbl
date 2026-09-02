       IDENTIFICATION DIVISION.
       PROGRAM-ID. newoutlook.
       ENVIRONMENT DIVISION.
       CONFIGURATION                SECTION.
       SPECIAL-NAMES.
           COPY    "outlooknet.def".
                   .
       DATA        DIVISION.
       WORKING-STORAGE              SECTION.
          copy "acucobol.def".
          copy "acugui.def".
          COPY "ACTIVEX.DEF".
          COPY "WINHELP.DEF".

       77  ERROR-SOURCE             PIC X(30).
       77  ERROR-DESCRIPTION        PIC X(50).
       77  ERROR-HELP-FILE          PIC X(200).
       77  ERROR-HELP-CONTEXT       USAGE UNSIGNED-LONG.
       77  CHOICE                   PIC 9.
      *--
       77  OUTLOOK-HANDLE           HANDLE   VALUE 0.
       77  WS-VERSION               PIC X(10).
       77  NUM-PARAM                PIC 9 COMP-1.
       LINKAGE SECTION.
          COPY "MSMAPI32.INC".
      * OP indica l'operazione da eseguire: 
      *  i o I inizializa Outlook 
      *  e o E termina Outlook
      *  tutto il resto manda l'email
       01 OP PIC X.
       PROCEDURE DIVISION  USING MAIL-LNK OP.
       DECLARATIVES.
       OBJECT-EXCEPTION SECTION.
           USE     AFTER            EXCEPTION ON OBJECT.
       OBJECT-EXCEPTION-HANDLER.
           CALL    "C$EXCEPINFO"    USING
                   ERROR-INFO
                   ERROR-SOURCE
                   ERROR-DESCRIPTION
                   ERROR-HELP-FILE
                   ERROR-HELP-CONTEXT.
           EVALUATE                 TRUE
                   WHEN             ACU-E-CLASSNOTREGISTERED
                                    DISPLAY MESSAGE BOX 
                                            "Class not registered"
                   WHEN             ACU-E-INITIALSTATE
                                    DISPLAY MESSAGE BOX "INITIAL-STATE"
           END-EVALUATE.
           IF      ERROR-HELP-FILE  = SPACES
                   DISPLAY          MESSAGE BOX 
                                    ERROR-DESCRIPTION
                                    TITLE ERROR-SOURCE
                                    ICON MB-ERROR-ICON
           ELSE
                   DISPLAY          MESSAGE BOX 
                                    ERROR-DESCRIPTION h'0d'
                                    "Do you want help ?"
                                    TITLE ERROR-SOURCE
                                    ICON MB-ERROR-ICON
                                    TYPE IS MB-YES-NO
                                    DEFAULT IS MB-YES
                                    GIVING CHOICE
                   IF               CHOICE = 1
                                    CALL "$WINHELP" USING 
                                         ERROR-HELP-FILE
                                         HELP-CONTEXT
                                         ERROR-HELP-CONTEXT
                   END-IF
           END-IF.
           MOVE 99 TO MY-ERROR.
           PERFORM FREE-HANDLES THRU FREE-HANDLES-EX.
           GOBACK.
***        EXIT PROGRAM.
***        STOP RUN.
       END DECLARATIVES.


       Main.
           CALL "C$NARG" USING  NUM-PARAM
           IF NUM-PARAM = 2
              EVALUATE OP
              WHEN "I"
              WHEN "i"
                  PERFORM INITIALIZE-OUTLOOK THRU INITIALIZE-OUTLOOK-EX
              WHEN "E"
              WHEN "e"
                  PERFORM SHUTDOWN-OUTLOOK THRU SHUTDOWN-OUTLOOK-EX
              WHEN OTHER
                  PERFORM SEND-MAIL THRU SEND-MAIL-EX
              END-EVALUATE
           ELSE
             PERFORM SEND-MAIL THRU SEND-MAIL-EX
           END-IF
           GOBACK.
   
       INITIALIZE-OUTLOOK.
           CREATE "OutlookWrapper"
                NAMESPACE   IS "OutlookWrapper",
                CLASS-NAME  IS "Outlook"
                HANDLE IS OUTLOOK-HANDLE.
       INITIALIZE-OUTLOOK-EX.
           EXIT.

       SEND-MAIL.
           MODIFY OUTLOOK-HANDLE "Initialize"()
           MODIFY OUTLOOK-HANDLE "AddRecipient"(MY-RECIP-ADDR-1)

           IF MY-RECIP-ADDR-2 NOT = SPACES
              MODIFY OUTLOOK-HANDLE "AddRecipient"(MY-RECIP-ADDR-2)
           END-IF
           IF MY-ATTACH-1 NOT = SPACES
               MODIFY OUTLOOK-HANDLE 
                       "AddAttachment"(MY-ATTACH-1, "Allegato 1")
              IF MY-ATTACH-2 NOT = SPACES
                 MODIFY OUTLOOK-HANDLE 
                       "AddAttachment"(MY-ATTACH-2, "Allegato 2")
                 IF MY-ATTACH-3 NOT = SPACES
                    MODIFY OUTLOOK-HANDLE 
                       "AddAttachment"(MY-ATTACH-3, "Allegato 3")
                    IF MY-ATTACH-4 NOT = SPACES
                       MODIFY OUTLOOK-HANDLE 
                       "AddAttachment"(MY-ATTACH-4, "Allegato 4")
                       IF MY-ATTACH-5 NOT = SPACES
                          MODIFY OUTLOOK-HANDLE 
                       "AddAttachment"(MY-ATTACH-5, "Allegato 5")
                       END-IF
                    END-IF
                 END-IF
              END-IF
           else
              IF MY-ATTACH-2 NOT = SPACES
                 MODIFY OUTLOOK-HANDLE 
                       "AddAttachment"(MY-ATTACH-2, "Allegato 1")
                 IF MY-ATTACH-3 NOT = SPACES
                    MODIFY OUTLOOK-HANDLE 
                       "AddAttachment"(MY-ATTACH-3, "Allegato 2")
                    IF MY-ATTACH-4 NOT = SPACES
                       MODIFY OUTLOOK-HANDLE 
                       "AddAttachment"(MY-ATTACH-4, "Allegato 3")
                       IF MY-ATTACH-5 NOT = SPACES
                          MODIFY OUTLOOK-HANDLE 
                       "AddAttachment"(MY-ATTACH-5, "Allegato 4")
                       END-IF
                    END-IF
                 END-IF
              END-IF
           END-IF.
      * scommentando la riga seguente viene richiesta la ricevuta di lettura    
      *    MODIFY  MAIL-HANDLE      @ReadReceiptRequested = 1.
           MODIFY  OUTLOOK-HANDLE      
                   "Send"(MY-ACCOUNT, MY-TITLE, MY-BODY, MY-GRAFICA).
           MODIFY  OUTLOOK-HANDLE "Logout"().
           PERFORM FREE-HANDLES THRU FREE-HANDLES-EX.
       SEND-MAIL-EX.
           EXIT.
           
       FREE-HANDLES.
      * a non destroyed handle would cause Outlook process to not to terminate
       FREE-HANDLES-EX.
           EXIT.
           
       SHUTDOWN-OUTLOOK.
           DESTROY OUTLOOK-HANDLE.
       SHUTDOWN-OUTLOOK-EX.
           EXIT.
