      *{Bench}prg-comment
      * ModifyBook.cbl
      * ModifyBook.cbl is generated from C:\AcuSamples\BookSF\NewBookSFwithATWID\ModifyBook.Psf
      *{Bench}end
       IDENTIFICATION              DIVISION.
      *{Bench}prgid
       PROGRAM-ID. ModifyBook.
       AUTHOR. support.
       DATE-WRITTEN. Tuesday, January 12, 2021 11:32:55 AM.
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
       77 Key-Status IS SPECIAL-NAMES CRT STATUS PIC 9(4) VALUE 0.
           88 Exit-Pushed VALUE 27.
           88 Message-Received VALUE 95.
           88 Event-Occurred VALUE 96.
           88 Screen-No-Input-Field VALUE 97.
           88 Screen-Time-Out VALUE 99.
      * property-defined variable

      * user-defined variable
       77 Form1-Handle
                  USAGE IS HANDLE OF WINDOW VALUE NULL.
       77 Depart-status    PIC  X(2).
           88 Valid-Department VALUE IS "00" THRU "09". 
       77 Books-status     PIC  X(2).
           88 Valid-Books VALUE IS "00" THRU "09". 
       01 Lnk-Books-rec.
           05 Lnk-Books-branch PIC  x(3).
           05 Lnk-Books-id     PIC  x(9).
           05 Lnk-Books-dr     PIC  x(2).
           05 Lnk-Books-title  PIC  x(25).
           05 Lnk-Books-price  PIC  9(8)v9(2).
           05 Lnk-Books-stock  PIC  s9(6).
           05 Lnk-Books-sales  PIC  x.
           05 Lnk-Books-order  PIC  s9(6).
           05 Lnk-Books-date   PIC  x(4).
           05 Lnk-Books-author PIC  x(10).
       77 old-Departme-key PIC  x(26).
       77 branchToKeep     PIC  x(3).
       77 W90-DISPLAY      PIC  X(26).
       01 .
           03 Form1-Cm-3-Container-Item.
               05      PIC  x(2)
                          VALUE IS "AA".
               05      PIC  x(2)
                          VALUE IS "BB".
               05      PIC  x(2)
                          VALUE IS "CC".
               05      PIC  x(2)
                          VALUE IS "  ".
           78 Form1-Cm-3-Container-Num VALUE IS 4. 
           03 Form1-Cm-3-Container REDEFINES Form1-Cm-3-Container-Item  
           PIC  x(2)
                      OCCURS 4 TIMES
                      INDEXED  Form1-Cm-3-Container-Idx.
       77 AA   PIC  x(2).
       77 Form1-St-1-Handle
                  USAGE IS HANDLE OF STATUS-BAR VALUE NULL.
       77 Form1-Mn-1-Handle
                  USAGE IS HANDLE OF MENU VALUE NULL.
       77 Form1-De-1-Value PIC  X(16).

      *{Bench}end
       LINKAGE                     SECTION.
      *{Bench}linkage
       01 Lnk-Departme-rec.
           05 Lnk-Departme-key PIC  x(26).
           05 Lnk-Departme-sub PIC  x(26).
           05 Lnk-Departme-branch          PIC  x(3).
      *{Bench}end
       SCREEN                      SECTION.
      *{Bench}copy-screen
       01 Form1.
           03 Form1-Pb-1, Push-Button, 
              COL 10.80, LINE 34.80, LINES 4.00 CELLS, 
              SIZE 16.00 CELLS, 
              EXCEPTION-VALUE 101, ID IS 1, SELF-ACT, 
              TITLE "Add/Modify", ATW-CSS-ID "ATW-ModBook-AddButton".
           03 Form1-Pb-2, Push-Button, 
              COL 31.10, LINE 34.80, LINES 4.00 CELLS, 
              SIZE 16.00 CELLS, 
              ID IS 2, SELF-ACT, CANCEL-BUTTON, 
              TITLE "Cancel", ATW-CSS-ID "ATW-ModBook-CancelButton".
           03 Form1-La-4, Label, 
              COL 3.00, LINE 7.30, LINES 2.10 CELLS, SIZE 8.60 CELLS, 
              ID IS 10, LABEL-OFFSET 0, 
              TITLE "Lnk-Books-id", ATW-CSS-ID "ATW-ModBook-IdLabel".
           03 Form1-Ef-1, Entry-Field, 
              COL 15.50, LINE 7.30, LINES 2.10 CELLS, SIZE 12.80 CELLS, 
              3-D, ID IS 11, VALUE Lnk-Books-id, 
              ATW-CSS-ID "ATW-ModBook-IdEF".
           03 Form1-La-5, Label, 
              COL 3.00, LINE 10.30, LINES 2.10 CELLS, SIZE 8.70 CELLS, 
              ID IS 12, LABEL-OFFSET 0, 
              TITLE "Lnk-Books-dr", ATW-CSS-ID "ATW-ModBook-DrLabel".
           03 Form1-La-6, Label, 
              COL 3.00, LINE 13.30, LINES 2.10 CELLS, SIZE 9.80 CELLS, 
              ID IS 14, LABEL-OFFSET 0, 
              TITLE "Lnk-Books-title", 
              ATW-CSS-ID "ATW-ModBook-TitleLabel".
           03 Form1-Ef-3, Entry-Field, 
              COL 15.50, LINE 13.30, LINES 2.10 CELLS, 
              SIZE 35.20 CELLS, 
              3-D, ID IS 15, VALUE Lnk-Books-title, 
              ATW-CSS-ID "ATW-ModBook-TitleEF".
           03 Form1-La-7, Label, 
              COL 3.00, LINE 16.30, LINES 2.10 CELLS, SIZE 10.60 CELLS, 
              ID IS 16, LABEL-OFFSET 0, 
              TITLE "Lnk-Books-price", 
              ATW-CSS-ID "ATW-ModBook-PriceLabel".
           03 Form1-Ef-4, Entry-Field, 
              COL 15.50, LINE 16.30, LINES 2.10 CELLS, 
              SIZE 15.60 CELLS, 
              3-D, ID IS 17, VALUE Lnk-Books-price, 
              ATW-CSS-ID "ATW-ModBook-PriceEF".
           03 Form1-La-8, Label, 
              COL 3.00, LINE 19.30, LINES 2.10 CELLS, SIZE 10.80 CELLS, 
              ID IS 18, LABEL-OFFSET 0, 
              TITLE "Lnk-Books-stock", 
              ATW-CSS-ID "ATW-ModBook-StockLabel".
           03 Form1-Ef-5, Entry-Field, 
              COL 15.50, LINE 19.30, LINES 2.10 CELLS, 
              SIZE 10.00 CELLS, 
              3-D, ID IS 19, VALUE Lnk-Books-stock, 
              ATW-CSS-ID "ATW-ModBook-StockEF".
           03 Form1-La-9, Label, 
              COL 3.00, LINE 22.30, LINES 2.10 CELLS, SIZE 10.80 CELLS, 
              ID IS 20, LABEL-OFFSET 0, 
              TITLE "Lnk-Books-order", 
              ATW-CSS-ID "ATW-ModBook-OrderLabel".
           03 Form1-Ef-6, Entry-Field, 
              COL 15.50, LINE 22.30, LINES 2.10 CELLS, 
              SIZE 10.00 CELLS, 
              3-D, ID IS 21, VALUE Lnk-Books-order, 
              ATW-CSS-ID "ATW-ModBook-OrderEF".
           03 Form1-La-10, Label, 
              COL 3.00, LINE 25.30, LINES 2.10 CELLS, SIZE 10.20 CELLS, 
              ID IS 22, LABEL-OFFSET 0, 
              TITLE "Lnk-Books-date", 
              ATW-CSS-ID "ATW-ModBook-DateLabel".
           03 Form1-La-11, Label, 
              COL 3.00, LINE 28.30, LINES 2.10 CELLS, SIZE 11.50 CELLS, 
              ID IS 24, LABEL-OFFSET 0, 
              TITLE "Lnk-Books-author", 
              ATW-CSS-ID "ATW-ModBook-AuthorLabel".
           03 Form1-Ef-8, Entry-Field, 
              COL 15.50, LINE 28.30, LINES 2.10 CELLS, 
              SIZE 14.20 CELLS, 
              3-D, ID IS 25, VALUE Lnk-Books-author, 
              ATW-CSS-ID "ATW-ModBook-AuthorEF".
           03 Form1-La-1, Label, 
              COL 3.00, LINE 2.90, LINES 2.10 CELLS, SIZE 11.90 CELLS, 
              ID IS 3, LABEL-OFFSET 0, 
              TITLE "Lnk-Departme-key", 
              ATW-CSS-ID "ATW-ModBook-KeyLabel".
           03 Form1-Cm-1, Combo-Box, 
              COL 15.50, LINE 2.90, LINES 15.00 CELLS, 
              SIZE 11.40 CELLS, 
              3-D, EXCEPTION-VALUE 102, ID IS 4, MASS-UPDATE 0, 
              NOTIFY-SELCHANGE, DROP-LIST, UNSORTED, 
              VALUE Lnk-Departme-key, 
              ATW-CSS-ID "ATW-ModBook-KeyCombo", 
              EXCEPTION PROCEDURE Form1-Cm-2-Exception-Proc.
           03 Form1-La-2, Label, 
              COL 28.30, LINE 2.90, LINES 2.10 CELLS, SIZE 12.00 CELLS, 
              ID IS 5, LABEL-OFFSET 0, 
              TITLE "Lnk-Departme-sub", 
              ATW-CSS-ID "ATW-ModBook-SubLabel".
           03 Form1-Cm-2, Combo-Box, 
              COL 41.30, LINE 2.90, LINES 15.90 CELLS, 
              SIZE 14.00 CELLS, 
              3-D, EXCEPTION-VALUE 101, ID IS 6, MASS-UPDATE 0, 
              NOTIFY-SELCHANGE, DROP-LIST, UNSORTED, 
              VALUE Lnk-Departme-sub, 
              ATW-CSS-ID "ATW-ModBook-SubCombo", 
              EXCEPTION PROCEDURE Form1-Cm-2-Exception-Proc.
           03 Form1-Cm-3, Combo-Box, 
              COL 15.50, LINE 10.30, LINES 11.30 CELLS, 
              SIZE 6.00 CELLS, 
              3-D, ID IS 7, MASS-UPDATE 0, DROP-DOWN, UNSORTED, 
              VALUE Lnk-Books-dr, ATW-CSS-ID "ATW-ModBook-DrCombo".
           03 Form1-Fr-1, Frame, 
              COL 2.00, LINE 1.00, LINES 5.00 CELLS, SIZE 54.00 CELLS, 
              ENGRAVED, ID IS 8, 
              TITLE "Branch", BACKGROUND-LOW, 
              ATW-CSS-ID "ATW-ModBook-Frame".
           03 Form1-Cb-1, Check-Box, 
              COL 3.00, LINE 31.90, LINES 2.10 CELLS, SIZE 12.00 CELLS, 
              ID IS 13, SELF-ACT, 
              TITLE "Lnk-Books-sales", VALUE Lnk-Books-sales, 
              ATW-CSS-ID "ATW-ModBook-SalesCBox".
           03 Form1-De-1, Date-Entry, 
              COL 15.50, LINE 25.20, LINES 2.30 CELLS, 
              SIZE 10.10 CELLS, 
              ID IS 9, NOTIFY-CHANGE, VALUE-FORMAT 0, 
              VALUE Form1-De-1-Value, 
              ATW-CSS-ID "ATW-ModBook-DatePicker", 
              EVENT PROCEDURE Form1-De-1-Event-Proc.

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

       Acu-Initial-Routine.
      *    Before-Init
      * get system information
           ACCEPT System-Information FROM System-Info
      * get terminal information
           ACCEPT Terminal-Abilities FROM Terminal-Info
      * create pop-up menu
           PERFORM Acu-Init-Popup
      * open file
           PERFORM Acu-Open-Files
      *    After-Init
           .

       Acu-Init-Popup.
           PERFORM Acu-Form1-Mn-1-Menu
           MOVE Menu-Handle TO Form1-Mn-1-Handle
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
           .

       Acu-Exit-Bmp.
      * bitmap destroy
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

       Acu-Form1-Routine.
      *    Before-Routine
           PERFORM Acu-Form1-Scrn
           PERFORM Acu-Form1-Proc
      *    After-Routine
           .

       Acu-Form1-Scrn.
           PERFORM Acu-Form1-Create-Win
           PERFORM Acu-Form1-Init-Data
           .

       Acu-Form1-Create-Win.
      *    Before-Create
      * display screen
              DISPLAY Floating GRAPHICAL WINDOW
                 LINES 43.00, SIZE 56.00, CELL HEIGHT 10, 
                 CELL WIDTH 10, COLOR IS 65793, LABEL-OFFSET 0, 
                 LINK TO THREAD, MODELESS, 
                 POP-UP MENU IS Form1-Mn-1-Handle, NO SCROLL, 
                 WITH SYSTEM MENU, 
                 TITLE "Add/Modify Book", TITLE-BAR, NO WRAP, 
                 ATW-CSS-CLASS "ATW-SCREEN", 
                 EVENT PROCEDURE Form1-Event-Proc, 
                 HANDLE IS Form1-Handle
      * toolbar
      * status-bar
           DISPLAY STATUS-BAR
              PANEL-WIDTHS (20, 20, 8), 
              PANEL-STYLE (1, 2, 0), 
              PANEL-TEXT (Depart-status, Books-status, 
                 Lnk-Departme-branch), 
              GRIP, ATW-CSS-ID "ATW-ModBook-StatusBar", 
              HANDLE IS Form1-St-1-Handle
           DISPLAY Form1 UPON Form1-Handle
      *    After-Create
           .

       Acu-Form1-Init-Data.
      *    Before-Initdata
           PERFORM Acu-Form1-Cm-1-Content
           PERFORM Acu-Form1-Cm-2-Content
           PERFORM Acu-Form1-Cm-3-Content
           PERFORM Form1-Aft-Initdata
           .
      * Form1
       Acu-Form1-Proc.
           PERFORM UNTIL Exit-Pushed
              ACCEPT Form1  
                 ON EXCEPTION PERFORM Acu-Form1-Evaluate-Func
              END-ACCEPT
           END-PERFORM
           DESTROY Form1-Handle
           INITIALIZE Key-Status
           .

      * Form1-Cm-1
       Acu-Form1-Cm-1-Content.
           .

      * Form1-Cm-2
       Acu-Form1-Cm-2-Content.
           .

      * Form1-Cm-3
       Acu-Form1-Cm-3-Content.
           MODIFY Form1-Cm-3, MASS-UPDATE = 1, RESET-LIST = 1
           MODIFY Form1-Cm-3, ITEM-TO-ADD = TABLE Form1-Cm-3-Container
           MODIFY Form1-Cm-3, MASS-UPDATE = 0
           MODIFY Form1-Cm-3, VALUE Lnk-Books-dr
           .

      * Form1
       Acu-Form1-Evaluate-Func.
           EVALUATE TRUE
              WHEN Exit-Pushed
                 PERFORM Acu-Form1-Exit
              WHEN Event-Occurred
                 IF Event-Type = Cmd-Close
                    PERFORM Acu-Form1-Exit
                 END-IF
      * Form1-Pb-1 Link To
              WHEN Key-Status = 101
                 PERFORM Form1-Pb-1-Link
      * MI-OkayThisisaRealMenu Link To
              WHEN Key-Status = 1006
                 PERFORM Form1-Mn-1-MI-OkayThisisaRealMenu-Link
           END-EVALUATE
           MOVE 1 TO Accept-Control
           .

       Acu-Form1-Display-Status-Msg.
           MODIFY Form1-St-1-Handle
              PANEL-WIDTHS (20, 20, 8), 
              PANEL-STYLE (1, 2, 0), 
              PANEL-TEXT (Depart-status, Books-status, 
                 Lnk-Departme-branch), 
              GRIP, ATW-CSS-ID "ATW-ModBook-StatusBar", 
           .

       Acu-Form1-Clear-Status-Msg.
           
           MOVE SPACE TO Depart-status
           PERFORM Acu-Form1-Display-Status-Msg
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

       Acu-Form1-Exit.
           SET Exit-Pushed TO TRUE
           .

      * Form1-Mn-1
       Acu-Form1-Mn-1-Menu.
           PERFORM Acu-Form1-Mn-1
              THRU Acu-Form1-Mn-1-Exit.

       Acu-Form1-Mn-1.
           CALL "W$MENU" USING Wmenu-New-Popup GIVING Menu-Handle
           IF Menu-Handle = ZERO
              GO TO Acu-Form1-Mn-1-Exit
           END-IF
           CALL "W$MENU" USING Wmenu-New GIVING Sub-Handle-1
           IF Sub-Handle-1 = ZERO
              MOVE ZERO TO Menu-Handle
              GO TO Acu-Form1-Mn-1-EXIT
           END-IF
           CALL "W$MENU" USING WMENU-ADD, Menu-Handle, 0, 0, 
              "Test Popup Menu", 1000, Sub-Handle-1
           CALL "W$MENU" USING WMENU-ADD, Sub-Handle-1, 0, 0, 
              "We have the First Choice", 1001
           CALL "W$MENU" USING WMENU-ADD, Sub-Handle-1, 0, 0, 
              "Here is the Second", 1002
           CALL "W$MENU" USING WMENU-ADD, Sub-Handle-1, 0, 0, 
              "Okay This is a Real Menu!", 1006
           CALL "W$MENU" USING Wmenu-New GIVING Sub-Handle-1
           IF Sub-Handle-1 = ZERO
              MOVE ZERO TO Menu-Handle
              GO TO Acu-Form1-Mn-1-EXIT
           END-IF
           CALL "W$MENU" USING WMENU-ADD, Menu-Handle, 0, 0, 
              "We want another Menu test", 1003, Sub-Handle-1
           CALL "W$MENU" USING WMENU-ADD, Sub-Handle-1, 0, 0, 
              "A First Choice", 1004
           CALL "W$MENU" USING WMENU-ADD, Sub-Handle-1, 0, 0, 
              "A Second Choice", 1005
           .

       Acu-Form1-Mn-1-Exit.
           MOVE ZERO TO Return-Code.


       Form1-Event-Proc.
           .

       Form1-Cm-2-Exception-Proc.
      * 
           IF Event-Occurred
              EVALUATE Event-Type
              WHEN Ntf-Selchange
                 EVALUATE Event-Control-Id
                 WHEN 4
                    PERFORM Form1-Cm-1-Ev-Ntf-Selchange
                 WHEN 6
                    PERFORM Form1-Cm-2-Ex-Ntf-Selchange
                 END-EVALUATE
              END-EVALUATE
           END-IF
           .

       Form1-De-1-Event-Proc.
      * 
           EVALUATE Event-Type
           WHEN Ntf-Changed
              PERFORM Form1-De-1-Ev-Ntf-Changed
           END-EVALUATE
           .
      ***   start event editor code   ***
      *
       Form1-Pb-1-Link.

      *     move Departme-branch to Lnk-Books-branch
           initialize Books-rec                                         
           
           if Lnk-Books-sales equal "0" 
               move "N" to Lnk-Books-sales
               else move "Y" to Lnk-Books-sales
           end-if

           move Lnk-Books-rec to Books-rec
           move Lnk-Departme-branch to Books-branch
           write Books-rec

           if books-status(1:1) not equal "0"
               display MESSAGE Box "Books-status : " , Books-status
           end-if
            
           destroy Form1-Handle                                
           exit program
           .
      *
       Form1-Aft-Initdata.
           read Department next
           perform until Depart-status(1:1) > "0"                 
              move Departme-key to old-departme-key
              modify Form1-Cm-1, item-to-add(Departme-key)
              perform until (Departme-key not equal to old-departme-key) 
                   or  (Depart-status(1:1) > "0")
                   read Department next
               end-perform
           end-perform
           modify Form1-Cm-1, value= Lnk-Departme-key
           perform Form1-Cm-1-Ev-Ntf-Selchange
           perform  Form1-De-1-Ev-Ntf-Changed.
           .      
      *
       Form1-Cm-1-Ev-Ntf-Selchange.
           inquire Form1-Cm-1, value W90-DISPLAY 
           close DEPARTMENT
           open input DEPARTMENT           
           modify Form1-Cm-2, reset-list = 1
           move W90-DISPLAY to Departme-key

           start DEPARTMENT key is equal to Departme-key
           end-start
           read DEPARTMENT next
           
           perform until (Departme-key not equal to W90-DISPLAY) or
              (Depart-status(1:1) > "0" )
              modify Form1-Cm-2, item-to-add(Departme-sub)
              if Departme-sub = Lnk-Departme-sub
               Then  
                   move Departme-branch to Lnk-Departme-branch
               end-if
              read DEPARTMENT next        
           end-perform
           modify Form1-Cm-2, value= Lnk-Departme-Sub
           .
      *
       Form1-Cm-2-Ex-Ntf-Selchange.
           inquire Form1-Cm-2, value W90-DISPLAY
           move W90-DISPLAY to Departme-sub
           inquire Form1-Cm-1, value W90-DISPLAY
           move W90-DISPLAY to Departme-key

           close DEPARTMENT
           open input DEPARTMENT    

           start DEPARTMENT key is equal to mkey
           end-start

           read DEPARTMENT                      
           move Departme-branch to branchToKeep, Lnk-Departme-branch  
           display Form1                             
           .
      *
       Form1-Rb-1-Ev-Msg-Validate.
           continue
           .
      *
       Form1-Mn-1-MI-OkayThisisaRealMenu-Link.
           Call "WebBrowser"
           .
      *
       Form1-De-1-Ev-Ntf-Changed.
           inquire Form1-De-1, value Form1-De-1-Value
           move Form1-De-1-Value(1:4) to Lnk-Books-date
           .

       

      *{Bench}end
       REPORT-COMPOSER SECTION.
