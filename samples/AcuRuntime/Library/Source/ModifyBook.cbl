      *{Bench}prg-comment
      * ModifyBook.cbl
      * ModifyBook.cbl is generated from C:\COBOL\extend10.1\ModifyBook.Psf
      *{Bench}end
       IDENTIFICATION              DIVISION.
      *{Bench}prgid
       PROGRAM-ID. ModifyBook.
       AUTHOR. Admin.
       DATE-WRITTEN. vendredi 1 juillet 2016 10:52:00.
       REMARKS. 
      *{Bench}end
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       SPECIAL-NAMES.
      *{Bench}activex-def
      *{Bench}end
      *{Bench}decimal-point
      *{Bench}end
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *{Bench}file-control
       COPY "Department.sl".
       COPY "Books.sl".
      *{Bench}end
       DATA                        DIVISION.
       FILE                        SECTION.
      *{Bench}file
       COPY "Department.fd".
       COPY "Books.fd".
      *{Bench}end
       WORKING-STORAGE             SECTION.
      *{Bench}acu-def
       COPY "acugui.def".
       COPY "acucobol.def".
       COPY "crtvars.def".
       COPY "showmsg.def".
      *{Bench}end

      *{Bench}copy-working
       COPY "ModifyBook.wrk".
      *{Bench}end
       LINKAGE                     SECTION.
      *{Bench}linkage
       COPY "ModifyBook.lks".
      *{Bench}end
       SCREEN                      SECTION.
      *{Bench}copy-screen
       COPY "ModifyBook.scr".
      *{Bench}end

      *{Bench}linkpara
       PROCEDURE DIVISION USING Lnk-Departme-rec.
      *{Bench}end
      *{Bench}declarative
       DECLARATIVES.
       INPUT-ERROR SECTION.
           USE AFTER STANDARD ERROR PROCEDURE ON INPUT.
       0100-DECL.
           EXIT.
       I-O-ERROR SECTION.
           USE AFTER STANDARD ERROR PROCEDURE ON I-O.
       0200-DECL.
           EXIT.
       OUTPUT-ERROR SECTION.
           USE AFTER STANDARD ERROR PROCEDURE ON OUTPUT.
       0300-DECL.
           EXIT.
       Department-ERROR SECTION.
           USE AFTER STANDARD EXCEPTION PROCEDURE ON Department.
       Books-ERROR SECTION.
           USE AFTER STANDARD EXCEPTION PROCEDURE ON Books.
       END DECLARATIVES.
      *{Bench}end

       Acu-Main-Logic.
      *{Bench}entry-befprg
      *    Before-Program
      *{Bench}end
           PERFORM Acu-Initial-Routine
      * run main screen
      *{Bench}run-mainscr
           PERFORM Acu-Form1-Routine
      *{Bench}end
           PERFORM Acu-Exit-Rtn
           .

      *{Bench}copy-procedure
       COPY "showmsg.cpy".
       COPY "ModifyBook.prd".
       COPY "ModifyBook.mnu".
       COPY "ModifyBook.evt".
      *{Bench}end
       REPORT-COMPOSER SECTION.
