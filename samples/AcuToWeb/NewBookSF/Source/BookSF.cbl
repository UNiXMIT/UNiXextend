      *{Bench}prg-comment
      * BookSF.cbl
      * BookSF.cbl is generated from C:\AcuSamples\BookSF\NewBookSFwithATWID\BookSF.Psf
      *{Bench}end
       IDENTIFICATION              DIVISION.
      *{Bench}prgid
       PROGRAM-ID. BookSF.
       AUTHOR. support.
       DATE-WRITTEN. Tuesday, January 12, 2021 11:32:54 AM.
       REMARKS. 
      *{Bench}end
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       SPECIAL-NAMES.
      *{Bench}activex-def
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
       COPY "fonts.def".
       COPY "showmsg.def".
      *{Bench}end

      *{Bench}copy-working
       77 Quit-Mode-Flag PIC S9(5) COMP-4 VALUE 0.
       77 Key-Status IS SPECIAL-NAMES CRT STATUS PIC 9(4) VALUE 0.
           88 Exit-Pushed VALUE 27.
           88 Message-Received VALUE 95.
           88 Event-Occurred VALUE 96.
           88 Screen-No-Input-Field VALUE 97.
           88 Screen-Time-Out VALUE 99.
      * property-defined variable

      * user-defined variable
       77 Arial10
                  USAGE IS HANDLE OF FONT VALUE NULL.
       77 Screen1-Handle
                  USAGE IS HANDLE OF WINDOW VALUE NULL.
       77 Calibri12B
                  USAGE IS HANDLE OF FONT VALUE NULL.
       77 Extend10b_937x2896-215605-png            PIC  S9(6)
                  USAGE IS COMP-4
                  VALUE IS 0.
       77 Calibri9B
                  USAGE IS HANDLE OF FONT VALUE NULL.
       77 W90-DISPLAY      PIC  X(26).
       77 Arial9B
                  USAGE IS HANDLE OF FONT VALUE NULL.
       77 ws-detail-visible            PIC  9
                  VALUE IS 1.
       77 W20-A41-3        PIC  X(21)
                  VALUE IS "Department No.".
       77 W20-A41-4        PIC  X(18)
                  VALUE IS "Sub-department No.".
       77 Screen2-Handle
                  USAGE IS HANDLE OF WINDOW VALUE NULL.
       77 Calibri-Light10
                  USAGE IS HANDLE OF FONT VALUE NULL.
       77 Trebuchet-MS10B
                  USAGE IS HANDLE OF FONT VALUE NULL.
       77 MS-Sans-Serif12B
                  USAGE IS HANDLE OF FONT VALUE NULL.
       01 Screen2-Gd-1-Record.
           05 Gd-1-Col-1       PIC  X(09).
           05 Gd-1-Col-2       PIC  X(2).
           05 Gd-1-Col-3       PIC  X(25).
           05 Gd-1-Col-4       PIC  ZZZZ,ZZ9.99.
           05 Gd-1-Col-5       PIC  ZZZZ9-.
           05 Gd-1-Col-6       PIC  X.
           05 Gd-1-Col-7       PIC  ZZZZ9-.
           05 Gd-1-Col-8       PIC  X(4).
           05 Gd-1-Col-9       PIC  X(10).
       77 2DPB-BMP         PIC  S9(6)
                  USAGE IS COMP-4
                  VALUE IS 0.
       77 CRD-bmp          PIC  S9(6)
                  USAGE IS COMP-4
                  VALUE IS 0.
       77 Arial10I
                  USAGE IS HANDLE OF FONT VALUE NULL.
       77 Arial10B
                  USAGE IS HANDLE OF FONT VALUE NULL.
       77 Depart-status    PIC  X(2).
           88 Valid-Department VALUE IS "00" THRU "09". 
       77 Books-status     PIC  X(2).
           88 Valid-Books VALUE IS "00" THRU "09". 
       77 old-Departme-key PIC  x(26).
       77 branchToKeep     PIC  x(3).
       77 ws-cursor        PIC  9(3).
       77 Default-Font
                  USAGE IS HANDLE OF FONT DEFAULT-FONT.
       77 Calibri10
                  USAGE IS HANDLE OF FONT VALUE NULL.
       77 books-jpg        PIC  S9(6)
                  USAGE IS COMP-4
                  VALUE IS 0.
       77 Extend10b-jpg    PIC  S9(6)
                  USAGE IS COMP-4
                  VALUE IS 0.
       77 AcuToWeb_resize1-jpg         PIC  S9(6)
                  USAGE IS COMP-4
                  VALUE IS 0.
       77 AcuToWeb_resize2-jpg         PIC  S9(6)
                  USAGE IS COMP-4
                  VALUE IS 0.
       77 AcuToWeb_resize3-jpg         PIC  S9(6)
                  USAGE IS COMP-4
                  VALUE IS 0.
       77 AcuToWeb_resize4-jpg         PIC  S9(6)
                  USAGE IS COMP-4
                  VALUE IS 0.
       77 Calibri11B
                  USAGE IS HANDLE OF FONT VALUE NULL.
       77 Calibri11
                  USAGE IS HANDLE OF FONT VALUE NULL.
       77 Calibri14B
                  USAGE IS HANDLE OF FONT VALUE NULL.

      *{Bench}end
       LINKAGE                     SECTION.
      *{Bench}linkage
      *{Bench}end
       SCREEN                      SECTION.
      *{Bench}copy-screen
       01 Screen1.
           03 Screen1-Frame1, Frame, 
              COL 8.90, LINE 1.00, LINES 16.50 CELLS, SIZE 89.70 CELLS, 
              ENGRAVED, FONT IS Calibri12B, ID IS 1, 
              TITLE "Library Demo", BACKGROUND-LOW, 
              ATW-CSS-ID "ATW-BookSF-Frame".
           03 Screen1-Dpt-Cb, Combo-Box, 
              COL 38.00, LINE 3.90, LINES 6.20 CELLS, SIZE 35.10 CELLS, 
              3-D, FONT IS Calibri11, ID IS 2, MASS-UPDATE 0, 
              NOTIFY-SELCHANGE, DROP-LIST, UNSORTED, 
              VALUE W90-DISPLAY, ATW-CSS-ID "ATW-BookSF-DepCombo", 
              EVENT PROCEDURE Screen1-Dpt-Cb-Event-Proc.
           03 Screen1-SubDpt-Cb, Combo-Box, 
              COL 38.00, LINE 7.80, LINES 6.20 CELLS, SIZE 35.10 CELLS, 
              3-D, FONT IS Calibri11, ID IS 4, MASS-UPDATE 0, 
              NOTIFY-SELCHANGE, DROP-LIST, UNSORTED, 
              ATW-CSS-ID "ATW-BookSF-SubDepCombo", 
              EVENT PROCEDURE Screen1-SubDpt-Cb-Event-Proc, 
              EXCEPTION PROCEDURE Screen1-SubDpt-Cb-Exception-Proc.
           03 Screen1-Dpt-La, Label, 
              COL 19.20, LINE 3.90, LINES 3.10 CELLS, SIZE 13.30 CELLS, 
              PERMANENT, FONT IS Calibri11B, ID IS 5, LABEL-OFFSET 0, 
              TITLE W20-A41-3, ATW-CSS-ID "ATW-BookSF-DepLabel".
           03 Screen1-SubDpt-La, Label, 
              COL 19.20, LINE 7.80, LINES 2.60 CELLS, SIZE 16.90 CELLS, 
              PERMANENT, FONT IS Calibri11B, ID IS 7, LABEL-OFFSET 0, 
              TITLE W20-A41-4, ATW-CSS-ID "ATW-BookSF-SubDepLabel".
           03 Screen1-Pb-1, Push-Button, 
              COL 82.30, LINE 13.20, LINES 2.90 CELLS, 
              SIZE 15.40 CELLS, 
              ID IS 3, SELF-ACT, CANCEL-BUTTON, 
              TITLE "&Exit", ATW-CSS-CLASS "exitbutton", 
              ATW-CSS-ID "ATW-BookSF-ExitButton".
           03 Screen1-Pb-1a, Push-Button, 
              COL 46.00, LINE 13.20, LINES 2.90 CELLS, 
              SIZE 15.40 CELLS, 
              EXCEPTION-VALUE 101, FONT IS Arial9B, ID IS 29, 
              TITLE "&Find", ATW-CSS-ID "ATW-BookSF-FindButton".
           03 Screen1-Bt-1, Bitmap, 
              COL 8.20, LINE 18.20, LINES 441, SIZE 906, 
              BITMAP-HANDLE AcuToWeb_resize3-jpg, BITMAP-NUMBER 1, 
              ID IS 6, ATW-CSS-ID "ATW-BookSF-JPG".
       01 Screen2.
           03 Screen2-Gd-1, Grid, 
              COL 1.00, LINE 1.40, LINES 43.60 CELLS, 
              SIZE 121.20 CELLS, 
              ADJUSTABLE-COLUMNS, 3-D, CENTERED-HEADINGS, 
              COLUMN-HEADINGS, 
              DATA-COLUMNS (1, 10, 12, 37, 48, 54, 55, 61, 65), 
              DISPLAY-COLUMNS (1, 11, 14, 39, 54, 65, 75, 83, 93), 
              ALIGNMENT ("C", "C", "L", "C", "C", "C", "C", "C", "C"), 
              SORT-TYPES ("X", "-", "X", "P", "P", "-", "X", "X", "X"), 
              SEPARATION (3, 4, 5, 5, 5, 5, 5, 5, 5), 
              CURSOR-COLOR 481, CURSOR-FRAME-WIDTH 3, DIVIDER-COLOR 6, 
              DRAG-COLOR 1, HEADING-COLOR 263, HEADING-DIVIDER-COLOR 6, 
              ID IS 1, NUM-COL-HEADINGS 1, NUM-ROWS 15, 
              RECORD-DATA Screen2-Gd-1-Record, 
              ROW-COLOR-PATTERN = (257, 513), TILED-HEADINGS, 
              VPADDING 50, VSCROLL, ATW-CSS-ID "ATW-BookSF-Grid", 
              EVENT PROCEDURE Screen2-Gd-1-Event-Proc.
           03 Screen2-Pb-1, Push-Button, 
              COL 35.30, LINE 57.20, LINES 3.40 CELLS, SIZE 9.10 CELLS, 
              EXCEPTION-VALUE 124, ID IS 2, SELF-ACT, 
              TITLE "E&xit", ATW-CSS-CLASS "exitbutton", 
              ATW-CSS-ID "ATW-BookSF-ExitButton2".
           03 Screen2-Pb-1a, Push-Button, 
              COL 53.50, LINE 57.20, LINES 3.40 CELLS, SIZE 9.10 CELLS, 
              EXCEPTION-VALUE 123, ID IS 3, SELF-ACT, 
              TITLE "&Forward", ATW-CSS-ID "ATW-BookSF-ForwardButton".
           03 Screen2-Pb-2, Push-Button, 
              COL 44.40, LINE 57.20, LINES 3.40 CELLS, SIZE 9.10 CELLS, 
              EXCEPTION-VALUE 126, ID IS 4, 
              TITLE "&Back", ATW-CSS-ID "ATW-BookSF-BackButton".
           03 Screen2-Pb-3, Push-Button, 
              COL 62.60, LINE 57.20, LINES 3.40 CELLS, SIZE 9.10 CELLS, 
              EXCEPTION-VALUE 125, ID IS 5, 
              TITLE "&New Input", 
              ATW-CSS-ID "ATW-BookSF-NewInputButton".
           03 Screen2-Bt-1, Bitmap, 
              COL 1.10, LINE 50.60, LINES 17, SIZE 117, 
              BITMAP-HANDLE 2DPB-BMP, BITMAP-NUMBER 1, 
              ID IS 9, VISIBLE 0.
           03 Screen2-Bt-1a, Bitmap, 
              COL 8.80, LINE 49.40, LINES 26, SIZE 49, 
              BITMAP-HANDLE CRD-bmp, BITMAP-NUMBER 1, 
              ID IS 6, VISIBLE 0.
           03 Screen2-La-1, Label, 
              COL 2.60, LINE 49.60, LINES 1.80 CELLS, SIZE 5.30 CELLS, 
              FONT IS Arial10I, ID IS 7, LABEL-OFFSET 0, 
              TITLE "Label", VISIBLE 0.
           03 Screen2-La-2, Label, 
              COL 6.40, LINE 49.40, LINES 1.90 CELLS, SIZE 7.80 CELLS, 
              FONT IS Arial10B, ID IS 8, LABEL-OFFSET 0, 
              TITLE "Label", VISIBLE 0.

      *{Bench}end

      *{Bench}linkpara
       PROCEDURE DIVISION.
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
           PERFORM Acu-Screen1-Routine
      *{Bench}end
           PERFORM Acu-Exit-Rtn
           .

      *{Bench}copy-procedure
       COPY "showmsg.cpy".

       Acu-Initial-Routine.
      *    Before-Init
      * get system information
           ACCEPT System-Information FROM System-Info
      * get terminal information
           ACCEPT Terminal-Abilities FROM Terminal-Info
      * set font
           PERFORM Acu-Init-Font
      * load bitmap
           PERFORM Acu-Init-Bmp
      * open file
           PERFORM Acu-Open-Files
      *    After-Init
           .

       Acu-Init-Font.
      * font setting
           INITIALIZE WFONT-DATA Arial10
           MOVE 10 TO WFONT-SIZE
           MOVE "Arial" TO WFONT-NAME
           SET WFCHARSET-DEFAULT TO TRUE
           SET WFONT-BOLD TO FALSE
           SET WFONT-ITALIC TO FALSE
           SET WFONT-UNDERLINE TO FALSE
           SET WFONT-STRIKEOUT TO FALSE
           SET WFFAMILY-DONT-CARE TO TRUE
           SET WFONT-FIXED-PITCH TO FALSE
           CALL "W$FONT" USING WFONT-GET-FONT, Arial10, WFONT-DATA
           INITIALIZE WFONT-DATA Calibri12B
           MOVE 12 TO WFONT-SIZE
           MOVE "Calibri" TO WFONT-NAME
           SET WFCHARSET-DEFAULT TO TRUE
           SET WFONT-BOLD TO TRUE
           SET WFONT-ITALIC TO FALSE
           SET WFONT-UNDERLINE TO FALSE
           SET WFONT-STRIKEOUT TO FALSE
           SET WFFAMILY-DONT-CARE TO TRUE
           SET WFONT-FIXED-PITCH TO FALSE
           CALL "W$FONT" USING WFONT-GET-FONT, Calibri12B, WFONT-DATA
           INITIALIZE WFONT-DATA Calibri11
           MOVE 11 TO WFONT-SIZE
           MOVE "Calibri" TO WFONT-NAME
           SET WFCHARSET-DEFAULT TO TRUE
           SET WFONT-BOLD TO FALSE
           SET WFONT-ITALIC TO FALSE
           SET WFONT-UNDERLINE TO FALSE
           SET WFONT-STRIKEOUT TO FALSE
           SET WFFAMILY-DONT-CARE TO TRUE
           SET WFONT-FIXED-PITCH TO FALSE
           CALL "W$FONT" USING WFONT-GET-FONT, Calibri11, WFONT-DATA
           INITIALIZE WFONT-DATA Calibri11B
           MOVE 11 TO WFONT-SIZE
           MOVE "Calibri" TO WFONT-NAME
           SET WFCHARSET-DEFAULT TO TRUE
           SET WFONT-BOLD TO TRUE
           SET WFONT-ITALIC TO FALSE
           SET WFONT-UNDERLINE TO FALSE
           SET WFONT-STRIKEOUT TO FALSE
           SET WFFAMILY-DONT-CARE TO TRUE
           SET WFONT-FIXED-PITCH TO FALSE
           CALL "W$FONT" USING WFONT-GET-FONT, Calibri11B, WFONT-DATA
           INITIALIZE WFONT-DATA Arial9B
           MOVE 9 TO WFONT-SIZE
           MOVE "Arial" TO WFONT-NAME
           SET WFCHARSET-DEFAULT TO TRUE
           SET WFONT-BOLD TO TRUE
           SET WFONT-ITALIC TO FALSE
           SET WFONT-UNDERLINE TO FALSE
           SET WFONT-STRIKEOUT TO FALSE
           SET WFFAMILY-DONT-CARE TO TRUE
           SET WFONT-FIXED-PITCH TO FALSE
           CALL "W$FONT" USING WFONT-GET-FONT, Arial9B, WFONT-DATA
           INITIALIZE WFONT-DATA Arial10I
           MOVE 10 TO WFONT-SIZE
           MOVE "Arial" TO WFONT-NAME
           SET WFCHARSET-DEFAULT TO TRUE
           SET WFONT-BOLD TO FALSE
           SET WFONT-ITALIC TO TRUE
           SET WFONT-UNDERLINE TO FALSE
           SET WFONT-STRIKEOUT TO FALSE
           SET WFFAMILY-DONT-CARE TO TRUE
           SET WFONT-FIXED-PITCH TO FALSE
           CALL "W$FONT" USING WFONT-GET-FONT, Arial10I, WFONT-DATA
           INITIALIZE WFONT-DATA Arial10B
           MOVE 10 TO WFONT-SIZE
           MOVE "Arial" TO WFONT-NAME
           SET WFCHARSET-DEFAULT TO TRUE
           SET WFONT-BOLD TO TRUE
           SET WFONT-ITALIC TO FALSE
           SET WFONT-UNDERLINE TO FALSE
           SET WFONT-STRIKEOUT TO FALSE
           SET WFFAMILY-DONT-CARE TO TRUE
           SET WFONT-FIXED-PITCH TO FALSE
           CALL "W$FONT" USING WFONT-GET-FONT, Arial10B, WFONT-DATA
           .

       Acu-Init-Bmp.
      * bitmap loading
           COPY RESOURCE "AcuToWeb_resize3.jpg".
           CALL "W$BITMAP" USING WBITMAP-LOAD "AcuToWeb_resize3.jpg", 
              GIVING AcuToWeb_resize3-jpg
           COPY RESOURCE "2DPB.BMP".
           CALL "W$BITMAP" USING WBITMAP-LOAD "2DPB.BMP", GIVING 
              2DPB-BMP
           COPY RESOURCE "CRD.bmp".
           CALL "W$BITMAP" USING WBITMAP-LOAD "CRD.bmp", GIVING CRD-bmp
           .

       Acu-Exit-Rtn.
      * destroy font
           PERFORM Acu-Exit-Font
      * destroy bitmap
           PERFORM Acu-Exit-Bmp
           PERFORM Acu-Close-Files
      *    After-Program
           EXIT PROGRAM
           STOP RUN
           .
       Acu-Exit-Font.
      * font destroy
           IF Arial10 NOT = NULL
              DESTROY Arial10
              SET Arial10 TO NULL
           END-IF
           IF Calibri12B NOT = NULL
              DESTROY Calibri12B
              SET Calibri12B TO NULL
           END-IF
           IF Calibri11 NOT = NULL
              DESTROY Calibri11
              SET Calibri11 TO NULL
           END-IF
           IF Calibri11B NOT = NULL
              DESTROY Calibri11B
              SET Calibri11B TO NULL
           END-IF
           IF Arial9B NOT = NULL
              DESTROY Arial9B
              SET Arial9B TO NULL
           END-IF
           IF Arial10I NOT = NULL
              DESTROY Arial10I
              SET Arial10I TO NULL
           END-IF
           IF Arial10B NOT = NULL
              DESTROY Arial10B
              SET Arial10B TO NULL
           END-IF
           .

       Acu-Exit-Bmp.
      * bitmap destroy
           IF AcuToWeb_resize3-jpg NOT = 0
              CALL "W$BITMAP" USING WBITMAP-DESTROY AcuToWeb_resize3-jpg
              MOVE 0 TO AcuToWeb_resize3-jpg
           END-IF
           IF 2DPB-BMP NOT = 0
              CALL "W$BITMAP" USING WBITMAP-DESTROY 2DPB-BMP
              MOVE 0 TO 2DPB-BMP
           END-IF
           IF CRD-bmp NOT = 0
              CALL "W$BITMAP" USING WBITMAP-DESTROY CRD-bmp
              MOVE 0 TO CRD-bmp
           END-IF
           .

       Acu-Open-Files.
      *    Before-Open
           PERFORM Acu-Open-Department
           PERFORM Acu-Open-Books
      *    After-Open
           .

       Acu-Open-Department.
      *    Before-Open
           OPEN I-O Department 
           IF Depart-status = "35"
              OPEN OUTPUT Department
              IF Depart-status(1:1) = "0"
                 CLOSE Department
                 OPEN I-O Department
              END-IF
           END-IF
           IF NOT Depart-status(1:1) = "0"
              PERFORM Acu-Extended-File-Status
              GO TO Acu-Exit-Rtn
           END-IF
      *    After-Open
           .

       Acu-Open-Books.
      *    Before-Open
           OPEN I-O Books 
           IF Books-status = "35"
              OPEN OUTPUT Books
              IF Books-status(1:1) = "0"
                 CLOSE Books
                 OPEN I-O Books
              END-IF
           END-IF
           IF NOT Books-status(1:1) = "0"
              PERFORM Acu-Extended-File-Status
              GO TO Acu-Exit-Rtn
           END-IF
      *    After-Open
           .

       Acu-Screen1-Routine.
      *    Before-Routine
           PERFORM Acu-Screen1-Scrn
           PERFORM Acu-Screen1-Proc
      *    After-Routine
           .

       Acu-Screen2-Routine.
      *    Before-Routine
           PERFORM Acu-Screen2-Scrn
           PERFORM Acu-Screen2-Proc
      *    After-Routine
           .

       Acu-Screen1-Scrn.
           PERFORM Acu-Screen1-Create-Win
           PERFORM Acu-Screen1-Init-Data
           .

       Acu-Screen2-Scrn.
           PERFORM Acu-Screen2-Create-Win
           PERFORM Acu-Screen2-Init-Data
           .

       Acu-Screen1-Create-Win.
      *    Before-Create
      * display screen
              DISPLAY Standard GRAPHICAL WINDOW
                 LINES 62.00, SIZE 105.00, CELL HEIGHT 10, 
                 CELL WIDTH 10, AUTO-MINIMIZE, COLOR IS 65793, 
                 CONTROL FONT Arial10, ERASE, LABEL-OFFSET 0, 
                 RESIZABLE, WITH SYSTEM MENU, 
                 TITLE 
                 "AcuToWeb - Modernize and mobilize ACUCOBOL-GT applicat
      -          "ions", TITLE-BAR, USER-GRAY, USER-WHITE, 
                 ATW-CSS-CLASS "ATW-SCREEN", 
                 EVENT PROCEDURE Screen1-Event-Proc, 
                 HANDLE IS Screen1-Handle
      * toolbar
           DISPLAY Screen1 UPON Screen1-Handle
      *    After-Create
           .

       Acu-Screen2-Create-Win.
      *    Before-Create
      * display screen
              DISPLAY Floating GRAPHICAL WINDOW
                 LINES 62.00, SIZE 122.30, CELL HEIGHT 10, 
                 CELL WIDTH 10, COLOR IS 65793, CONTROL FONT Arial10, 
                 LABEL-OFFSET 0, LINK TO THREAD, MODELESS, RESIZABLE, 
                 NO SCROLL, WITH SYSTEM MENU, 
                 TITLE 
                 "AcuToWeb - Modernize and mobilize ACUCOBOL-GT applicat
      -          "ions", TITLE-BAR, NO WRAP, 
                 ATW-CSS-CLASS "ATW-SCREEN", 
                 HANDLE IS Screen2-Handle
      * toolbar
           DISPLAY Screen2 UPON Screen2-Handle
      *    After-Create
           .

       Acu-Screen1-Init-Data.
      *    Before-Initdata
           PERFORM Acu-Screen1-Dpt-Cb-Content
           PERFORM Acu-Screen1-SubDpt-Cb-Content
           PERFORM Screen1-Aft-Initdata
           .

       Acu-Screen2-Init-Data.
      *    Before-Initdata
           PERFORM Acu-Screen2-Gd-1-Content
      *    After-Initdata
           .
      * Screen1
       Acu-Screen1-Proc.
           PERFORM UNTIL Exit-Pushed
              ACCEPT Screen1  
                 ON EXCEPTION PERFORM Acu-Screen1-Evaluate-Func
              END-ACCEPT
           END-PERFORM
           DESTROY Screen1-Handle
           INITIALIZE Key-Status
           .
      * Screen2
       Acu-Screen2-Proc.
           PERFORM UNTIL Exit-Pushed
              ACCEPT Screen2  
                 ON EXCEPTION PERFORM Acu-Screen2-Evaluate-Func
              END-ACCEPT
           END-PERFORM
           DESTROY Screen2-Handle
           INITIALIZE Key-Status
           .

      * Screen1-Dpt-Cb
       Acu-Screen1-Dpt-Cb-Content.
           .

      * Screen1-SubDpt-Cb
       Acu-Screen1-SubDpt-Cb-Content.
           .

      * Screen2-Gd-1
       Acu-Screen2-Gd-1-Content.
      * Cells Settings
           MODIFY Screen2-Gd-1, X = 1, Y = 1, CELL-DATA = "Id No", 
           MODIFY Screen2-Gd-1, X = 2, Y = 1, CELL-DATA = "Dr", 
           MODIFY Screen2-Gd-1, X = 3, Y = 1, CELL-DATA = "Title", 
           MODIFY Screen2-Gd-1, X = 4, Y = 1, CELL-DATA = "Price", 
           MODIFY Screen2-Gd-1, X = 5, Y = 1, CELL-DATA = 
              "Curr. Stock", 
           MODIFY Screen2-Gd-1, X = 6, Y = 1, CELL-DATA = "FY16 Sales", 
           MODIFY Screen2-Gd-1, X = 7, Y = 1, CELL-DATA = "Ordered", 
           MODIFY Screen2-Gd-1, X = 8, Y = 1, CELL-DATA = "Last DATE", 
           MODIFY Screen2-Gd-1, X = 9, Y = 1, CELL-DATA = "Author", 
      * Columns' Setting
           MODIFY Screen2-Gd-1, X = 1, X = 1, 
              COLUMN-FONT = Default-Font, 
           MODIFY Screen2-Gd-1, X = 2, X = 2, 
              COLUMN-FONT = Default-Font, 
           MODIFY Screen2-Gd-1, X = 3, X = 3, 
              COLUMN-FONT = Default-Font, 
           MODIFY Screen2-Gd-1, X = 4, X = 4, 
              COLUMN-FONT = Default-Font, 
           MODIFY Screen2-Gd-1, X = 5, X = 5, 
              COLUMN-FONT = Default-Font, 
           MODIFY Screen2-Gd-1, X = 6, X = 6, 
              COLUMN-FONT = Default-Font, 
           MODIFY Screen2-Gd-1, X = 7, X = 7, 
              COLUMN-FONT = Default-Font, 
           MODIFY Screen2-Gd-1, X = 8, X = 8, 
              COLUMN-FONT = Default-Font, 
           MODIFY Screen2-Gd-1, X = 9, X = 9, 
              COLUMN-FONT = Default-Font, 
           .

      * Screen1
       Acu-Screen1-Evaluate-Func.
           EVALUATE TRUE
              WHEN Exit-Pushed
                 PERFORM Acu-Screen1-Exit
              WHEN Event-Occurred
                 IF Event-Type = Cmd-Close
                    PERFORM Acu-Screen1-Exit
                 END-IF
      * Screen1-Pb-1a Link To
              WHEN Key-Status = 101
                 PERFORM Screen1-Pb-1a-Link
           END-EVALUATE
           MOVE 1 TO Accept-Control
           .

      * Screen2
       Acu-Screen2-Evaluate-Func.
           EVALUATE TRUE
              WHEN Exit-Pushed
                 PERFORM Acu-Screen2-Exit
              WHEN Event-Occurred
                 IF Event-Type = Cmd-Close
                    PERFORM Acu-Screen2-Exit
                 END-IF
      * Screen2-Pb-1 Link To
              WHEN Key-Status = 124
                 PERFORM Screen2-Pb-1-Link
      * Screen2-Pb-1a Link To
              WHEN Key-Status = 123
                 PERFORM Screen2-Pb-1a-Link
      * Screen2-Pb-2 Link To
              WHEN Key-Status = 126
                 PERFORM Screen2-Pb-2-Link
      * Screen2-Pb-3 Link To
              WHEN Key-Status = 125
                 PERFORM Screen2-Pb-3-Link
           END-EVALUATE
           MOVE 1 TO Accept-Control
           .

       Acu-Close-Files.
      *    Before-Close
           CLOSE Department
           CLOSE Books
      *    After-Close
           .

      * Department

       Acu-Department-Read.
           READ Department WITH NO LOCK KEY mkey OF Department
           .

       Acu-Department-Read-Next.
           READ Department NEXT WITH NO LOCK
           .

       Acu-Department-Read-Prev.
           READ Department PREVIOUS WITH NO LOCK
           .

       Acu-Department-Rec-Write.
           WRITE Departme-rec
           .

       Acu-Department-Rec-Rewrite.
           REWRITE Departme-rec
           .

       Acu-Department-Rec-Delete.
           DELETE Department
           .

       Acu-Department-Delete.
           DELETE FILE Department
           .

      * Books

       Acu-Books-Read.
           READ Books WITH NO LOCK KEY Books-id OF Books
           .

       Acu-Books-Read-Next.
           READ Books NEXT WITH NO LOCK
           .

       Acu-Books-Read-Prev.
           READ Books PREVIOUS WITH NO LOCK
           .

       Acu-Books-Rec-Write.
           WRITE Books-rec
           .

       Acu-Books-Rec-Rewrite.
           REWRITE Books-rec
           .

       Acu-Books-Rec-Delete.
           DELETE Books
           .

       Acu-Books-Delete.
           DELETE FILE Books
           .

       Acu-Books-Ref-Department.
           INITIALIZE Departme-rec OF Department
           MOVE Books-branch OF Books TO Departme-key OF Department
           PERFORM Acu-Department-Read
           .

       Acu-Screen1-Exit.
           SET Exit-Pushed TO TRUE
           .

       Acu-Screen2-Exit.
           SET Exit-Pushed TO TRUE
           .


       Acu-Screen1-Event-Extra.
           EVALUATE Event-Type
           WHEN Msg-Close
              PERFORM Acu-Screen1-Msg-Close
           END-EVALUATE
           .

       Acu-Screen1-Msg-Close.
           ACCEPT Quit-Mode-Flag FROM ENVIRONMENT "QUIT_MODE"
           IF Quit-Mode-Flag = ZERO
              PERFORM Acu-Screen1-Exit
              PERFORM Acu-Exit-Rtn
           END-IF
           .

       Screen1-Event-Proc.
      * 
           PERFORM Acu-Screen1-Event-Extra
           .

       Screen1-Dpt-Cb-Event-Proc.
      * 
           EVALUATE Event-Type
           WHEN Ntf-Selchange
              PERFORM Screen1-Dpt-Cb-Ev-Ntf-Selchange
           END-EVALUATE
           .

       Screen1-SubDpt-Cb-Event-Proc.
           .

       Screen1-SubDpt-Cb-Exception-Proc.
      * 
           IF Event-Occurred
              EVALUATE Event-Type
              WHEN Ntf-Selchange
                 PERFORM Screen1-SubDpt-Cb-Ev-Ntf-Selchange
              END-EVALUATE
           END-IF
           .

       Screen2-Gd-1-Event-Proc.
      * 
           EVALUATE Event-Type
           WHEN Msg-Begin-Entry
              PERFORM Screen2-Gd-1-Ev-Msg-Begin-Entry
           END-EVALUATE
           .
      ***   start event editor code   ***
      *
       Screen1-Aft-Initdata.
           read Department next
           perform until Depart-status(1:1) > "0"                 
              move Departme-key to old-departme-key
              modify Screen1-Dpt-Cb, item-to-add(Departme-key)
              perform until (Departme-key not equal to old-departme-key) 
                   or  (Depart-status(1:1) > "0")
                   read Department next
               end-perform
           end-perform
CCCCCC*     modify Screen1-Dpt-Cb, value="Fantasy" 
CCCCCC     modify Screen1-Dpt-Cb, value="Science-Fiction"
           perform Screen1-Dpt-Cb-Ev-Ntf-Selchange
           .
      *
       Screen1-Dpt-Cb-Ev-Ntf-Selchange.
           inquire Screen1-Dpt-Cb, value W90-DISPLAY 
           close DEPARTMENT
           open input DEPARTMENT           
           modify Screen1-Subdpt-Cb, reset-list = 1
           move W90-DISPLAY to Departme-key

           start DEPARTMENT key is equal to Departme-key
           end-start

           read DEPARTMENT next
           perform until (Departme-key not equal to W90-DISPLAY) or
              (Depart-status(1:1) > "0" )
              modify Screen1-SubDpt-Cb, item-to-add(Departme-sub)
              read DEPARTMENT next        
           end-perform
CCCCCC*     modify Screen1-SubDpt-Cb, value="Uchronie" 
CCCCCC     modify Screen1-SubDpt-Cb, value="Space Opera" 
           .
      *
       Screen1-SubDpt-Cb-Ev-Ntf-Selchange.
           inquire Screen1-SubDpt-Cb, value W90-DISPLAY
           move 4 to accept-control
           move 11 to control-id           
           .
      *
       Screen1-selprice-Ef-Aft-Procedure.       
            .
      
       load-grid.           
           move 1 to WS-CURSOR
           perform until (Books-branch is not equal to branchToKeep) or
                   (books-status(1:1) > "0" ) or (ws-cursor = 15)
               initialize Gd-1-Col-6
               move books-id       to  Gd-1-Col-1
               move books-dr       to  Gd-1-Col-2
               move books-title    to  Gd-1-Col-3
               move books-price    to  Gd-1-Col-4
               move books-stock    to  Gd-1-Col-5
               if books-sales = "N"
                   move books-sales    to  Gd-1-Col-6
               end-if
               move books-order    to  Gd-1-Col-7
               move books-date     to  Gd-1-Col-8
               move books-author   to  Gd-1-Col-9

               modify Screen2-Gd-1, record-to-add(Screen2-Gd-1-Record)

               perform bitmap-grid

               read BOOKS next
           end-perform
           
           .
      *
       bitmap-grid.
           INQUIRE Screen2-Gd-1, LAST-ROW IN WS-CURSOR
           modify Screen2-Gd-1, y = ws-cursor

           if books-sales = "Y" 
           then 
               modify Screen2-Gd-1, x = 6
                                   bitmap = 2DPB-BMP
                                   bitmap-number = 269
                                   bitmap-width = 16
               modify Screen2-Gd-1, x = 2
                                    cell-data = spaces
           end-if

          
           if books-dr = "AA" or books-dr = "BB"
           then 
               modify Screen2-Gd-1, x = 2
                                   bitmap = CRD-bmp
                                   bitmap-number =  1                                           
                                   bitmap-width =   24 
               modify Screen2-Gd-1, x = 2
                                    cell-data = spaces
           else if  books-dr = "CC"
                then
                modify Screen2-Gd-1, x = 2
                                   bitmap = CRD-bmp
                                   bitmap-number =  2                                           
                                   bitmap-width =   24                                     
               modify Screen2-Gd-1, x = 2
                                    cell-data = spaces
               end-if                   
           end-if        
           .

       Screen2-Pb-1-Link.
           perform Acu-Screen2-Exit      
           .
      *
       Screen2-Pb-1a-Link.
           if (( Books-branch is not equal to branchToKeep )
                OR (books-status is equal to 10))
              
               then display message box "End of Branch"
           else     
               modify Screen2-Gd-1, reset-grid 1
               perform Acu-Screen2-Gd-1-Content
               perform load-grid
           end-if
           .
      *
       Screen2-Pb-2-Link.
           modify Screen2-Gd-1, reset-grid 1
           perform Acu-Screen2-Gd-1-Content
      *     move low-values to books-id
      *     start BOOKS key is higher than books-id

           close BOOKS
           Open input books
           move branchToKeep to books-branch          
           start BOOKS key is equal to Books-branch
           end-start
           read BOOKS next

           perform load-grid 
           .
      *
       Screen2-Pb-3-Link.   
      *     display message box "Didn't you see the red button? Applicati
      *-     "cation not finished! Okay, maybe it is just a demo!"
           call "ModifyBook" using departme-rec 
           .
      *
       Screen1-Pb-1a-Link.
           inquire Screen1-SubDpt-Cb, value W90-DISPLAY
           move W90-DISPLAY to Departme-sub
           inquire Screen1-Dpt-Cb, value W90-DISPLAY
           move W90-DISPLAY to Departme-key

           close DEPARTMENT
           open input DEPARTMENT    

           start DEPARTMENT key is equal to mkey
           end-start

           read DEPARTMENT
           

           move Departme-branch to branchToKeep
                      
           perform Acu-Screen2-Create-Win
           perform Acu-Screen2-Init-Data

           move branchToKeep to Books-branch
           start BOOKS key is equal to Books-branch
           read BOOKS next

           perform Control-screen2
           .

       Control-screen2.
           perform Load-Grid
           perform Acu-Screen2-Proc 
           .                                  
      *
      
      *
       Screen2-Gd-1-Ev-Msg-Begin-Entry.
           move event-action-fail to event-action
           perform Acu-Screen2-Exit
           perform Acu-Screen1-Exit
           perform Acu-Exit-Rtn
           .

       

      *{Bench}end
       REPORT-COMPOSER SECTION.
