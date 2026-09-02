       IDENTIFICATION DIVISION.
       PROGRAM-ID. OutLookSendMail.
       ENVIRONMENT DIVISION.
       CONFIGURATION                SECTION.
       SPECIAL-NAMES.
           COPY    "MSOutlook.def".
                   .
       DATA        DIVISION.
       WORKING-STORAGE              SECTION.
       77  OUTLOOK-HANDLE           HANDLE OF APPLICATION.
       77  MAIL-HANDLE              HANDLE OF MAILITEM.
       77  WS-VERSION               PIC X(10).

       PROCEDURE DIVISION.
       Main.
           DISPLAY "Creating Application".
           CREATE  APPLICATION      OF OUTLOOK
                   HANDLE           IN OUTLOOK-HANDLE.
           INQUIRE OUTLOOK-HANDLE   VERSION IN WS-VERSION.
           DISPLAY "Version of Outlook :" WS-VERSION.
           DISPLAY "Application Created. Creating Mail".
           MODIFY  OUTLOOK-HANDLE   CREATEITEM(OlMailItem)
                   GIVING           MAIL-HANDLE.
           MODIFY  MAIL-HANDLE      SUBJECT = "COM test".
           MODIFY  MAIL-HANDLE      BODY = "Good Job this one".
           
           MODIFY  MAIL-HANDLE      @Attachment = "C:\tmp\SendMail.cbl".           
           
           MODIFY  MAIL-HANDLE      @TO = "itsupport@microfocus.com".
           MODIFY  MAIL-HANDLE      @SEND().
           DISPLAY "Attempting to close Application".
           DESTROY OUTLOOK-HANDLE.
           DISPLAY "Closed Application".
           ACCEPT  OMITTED
           GOBACK.
