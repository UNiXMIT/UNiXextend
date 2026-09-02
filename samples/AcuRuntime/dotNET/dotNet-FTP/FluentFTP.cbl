       IDENTIFICATION DIVISION.
       PROGRAM-ID.                      FluentFTP.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           COPY "FluentFTP.DEF".
           .

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

       DATA DIVISION.
       FILE SECTION.

       WORKING-STORAGE SECTION.
       77 FTP-HANDLE           HANDLE OF "@FluentFTP.FtpClient".
       01 FTP-URL              PIC X(50) VALUE "URL".
       01 FTP-PORT             PIC 9(2) VALUE 21.
       01 FTP-USER             PIC X(50) VALUE "USERNAME".
       01 FTP-PASSWORD         PIC X(50) VALUE "PASSWORD".
       01 FTP-LOCAL-PATH       PIC X(50) VALUE "README.txt".
       01 FTP-REMOTE-PATH      PIC X(50) VALUE "README.txt".
      * For more information on the following parameters - https://github.com/robinrodricks/FluentFTP
      * What to do if the file already exists? Skip, overwrite or append?
       01 FTP-EXISTS           SIGNED-INT VALUE 0.
      * Create the remote directory if it does not exist. Slows down upload due to additional checks required.
       01 FTP-CREATE-REMOTEDIR PIC 9 VALUE 0.
      * Sets if checksum verification is required for a successful upload and what to do if it fails verification
       01 FTP-VERIFY           SIGNED-INT VALUE 0.
      * Provide a callback to track download progress.
       01 FTP-PROGRESS         USAGE HANDLE OF OBJECT.

       01 FTP-FILEPATH         PIC X(50) VALUE 
                                      "C:\temp\dotNet-FTP\filePath.xml".

       LINKAGE SECTION.

       SCREEN SECTION.

       PROCEDURE DIVISION.
           
           CREATE "@FluentFTP"
              NAMESPACE   IS "FluentFTP"
              CLASS-NAME  IS "FtpClient"
              CONSTRUCTOR IS CONSTRUCTOR7(FTP-URL
                                          FTP-PORT
                                          FTP-USER
                                          FTP-PASSWORD)
                   HANDLE IS FTP-HANDLE
      *            FILE-PATH IS FTP-FILEPATH
           
           MODIFY FTP-HANDLE "@Connect"()

           MODIFY FTP-HANDLE "@UploadFile"(FTP-LOCAL-PATH
                                           FTP-REMOTE-PATH     
                                           FTP-EXISTS          
                                           FTP-CREATE-REMOTEDIR
                                           FTP-VERIFY
                                           FTP-PROGRESS)         

           GOBACK.