       IDENTIFICATION DIVISION.
       PROGRAM-ID.                      clist_directory.
       INSTALLATION.                    comment-entry.

       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  pattern       pic x(1) value "*".
       01  directory     pic x(24) value "@[DISPLAY]:C:\AcuSamples".
       01  filename      pic x(128).
       01  mydir         usage handle.

       copy "acucobol.def".

       PROCEDURE DIVISION.
       call-directory.
           call "C$LIST-DIRECTORY" 
               using listdir-open, directory, pattern
           move return-code to mydir.
           if mydir = 0
           stop run
           end-if

           perform with test after until filename = spaces
               call "C$LIST-DIRECTORY" 
                   using listdir-next, mydir, filename
           end-perform

           call "C$LIST-DIRECTORY" using listdir-close, mydir
           stop run.

       