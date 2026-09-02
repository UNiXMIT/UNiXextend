       IDENTIFICATION DIVISION.
       PROGRAM-ID.                      winshellexecute.
       AUTHOR.  MIT. 
       REMARKS.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.

       DATA DIVISION.

       WORKING-STORAGE SECTION.
       COPY "shexec.def".

       01  SHOW                    PIC 99.
       01  VERB                    PIC X(50).
       01  FILENAME                PIC X(50).
       01  DIRECTORY               PIC X(100).
       01  PARAMETERS              PIC X(100).

       LINKAGE SECTION.

       SCREEN SECTION.

       PROCEDURE DIVISION.

      * Values for the SHOW parameter
      * Hides the window and activates another window.
      *    MOVE WSE-SW-HIDE TO SHOW
      * Activates and displays a window. If the window is minimized or
      * maximized, the system restores it to its original size and position.     
      *    MOVE WSE-SW-SHOWNORMAL TO SHOW
      * Activates the window and displays it as a minimized window.
      *    MOVE WSE-SW-SHOWMINIMIZED TO SHOW
      * Activates the window and displays it as a* maximized window.     
           MOVE WSE-SW-SHOWMAXIMIZED TO SHOW
      * Displays a window in its most recent size and position, without
      * activating the window.     
      *    MOVE WSE-SW-SHOWNOACTIVATE TO SHOW
      * Activates the window and displays it in its current size and position.     
      *    MOVE WSE-SW-SHOW TO SHOW
      * Minimizes the specified window and activates the next top-level
      * window in the Z order.
      *    MOVE WSE-SW-MINIMIZE TO SHOW
      * Displays the window as a minimized window, without activating
      * the window.
      *    MOVE WSE-SW-SHOWMINNOACTIVE TO SHOW
      * Displays the window in its current size and position, without
      * activating the window.
      *    MOVE WSE-SW-SHOWNA TO SHOW
      * Activates and displays the window, restoring it if it was minimized
      * or maximized.
      *    MOVE WSE-SW-RESTORE TO SHOW
      * Shows the window in its default state.
      *    MOVE WSE-SW-SHOWDEFAULT TO SHOW

      * Values for the VERB parameter
      * Launches an editor and opens the document for editing.
      *    MOVE WSE-VERB-EDIT TO VERB
      * Explores the folder specified by the filename parameter
           MOVE WSE-VERB-EXPLORE TO VERB
      * Initiates a search starting from the specified directory.
      *    MOVE WSE-VERB-FIND TO VERB
      * Opens the file specified by the filename parameter. The file can be
      * an executable file, a document file, or a folder.
      *    MOVE WSE-VERB-OPEN TO VERB
      * Prints the document file specified by the filename parameter.
      *    MOVE WSE-VERB-PRINT TO VERB
      * Displays the file or folder's properties.
      *    MOVE WSE-VERB-PROPERTIES TO VERB
      * Launches an application as Administrator. User Account Control (UAC)
      * will prompt the user for consent to run the application elevated or
      * enter the credentials of an administrator account used to run the
      * application.
      *    MOVE WSE-VERB-RUNAS TO VERB

           MOVE "C:\temp" TO FILENAME
      *    MOVE "C:\temp" TO DIRECTORY

           CALL "WIN$SHELLEXECUTE" USING SHOW VERB FILENAME 
                                         DIRECTORY PARAMETERS

           GOBACK.