       identification division.
       program-id. PdfCobolIo.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
       input-output section.
       file-control.
           select file-output
           ASSIGN TO PRINT ws-printer
           organization is LINE SEQUENTIAL
           FILE STATUS IS FILE-STATUS.

       data division.
       file section.
       FD file-output.
       01 file-output-rec.
          05 file-record           PIC  X(132).


       working-storage section.
       copy "cpdf.def".
       77 FILE-STATUS          pic XX.

       01 WS-PRINTER           PIC X(51) VALUE spaces.

       procedure division.
       main-logic.

           move "-p pdf PRINT.PDF" to ws-printer

           open output file-output.
           call "C$PDF" using HPDF-SETPASSWORD,
                file-output, "owner-pwd", "user-pwd"
           move "Test Print" to file-record
           write file-output-rec
           close file-output.
           display "press return to exit..."
           accept omitted

           stop run.
