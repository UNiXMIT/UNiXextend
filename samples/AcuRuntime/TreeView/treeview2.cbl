      *{Bench}prg-comment
      * treeview.cbl
      * treeview.cbl is generated from C:\AcuSamples\treeview\treeview\treeview.Psf
      *{Bench}end
       IDENTIFICATION              DIVISION.
      *{Bench}prgid
       PROGRAM-ID. treeview.
       AUTHOR. CContardi.
       DATE-WRITTEN. martedì 6 giugno 2017 10:51:03.
       REMARKS. 
      *{Bench}end
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       SPECIAL-NAMES.
      *{Bench}activex-def
      *{Bench}end
      *{Bench}decimal-point
           DECIMAL-POINT IS COMMA.
      *{Bench}end
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *{Bench}file-control
      *{Bench}end
       DATA                        DIVISION.
       FILE                        SECTION.
      *{Bench}file
      *{Bench}end
       WORKING-STORAGE             SECTION.
      *{Bench}acu-def
       COPY "acugui.def".
       COPY "acucobol.def".
       COPY "crtvars.def".
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
       77 Screen1-Handle
                  USAGE IS HANDLE OF WINDOW VALUE NULL.
       77 ws-menu          PIC  x(3).
       77 ws-exp           PIC  9(3).
       77 menu-Tree-Value
                  USAGE IS POINTER
                  VALUE IS NULL.
       77 Screen1-Tr-1-TI-1-IdPtr
                  USAGE IS POINTER.
       77 ws-posizione
                  USAGE IS POINTER.
       77 ws-posizione2
                  USAGE IS POINTER.
       77 new-pointer1
                  USAGE IS POINTER.
       77 new-pointer2
                  USAGE IS POINTER.
       77 Tree-Menu-ID-2
                  USAGE IS POINTER.
       77 Tree-Menu-ID-3
                  USAGE IS POINTER.
       77 Tree-Menu-ID-4
                  USAGE IS POINTER.
       77 Tree-Menu-ID-5
                  USAGE IS POINTER.
       77 Tree-Menu-ID-6
                  USAGE IS POINTER.
       77 Tree-Menu-ID-7
                  USAGE IS POINTER.
       77 Screen1-Tr-1-Value
                  USAGE IS POINTER
                  VALUE IS NULL.
       77 Screen1-Tr-1-TI-2-IdPtr
                  USAGE IS POINTER.
       77 Screen1-Tr-1-TI-3-IdPtr
                  USAGE IS POINTER.
       77 Screen1-Tr-1-TI-4-IdPtr
                  USAGE IS POINTER.
       77 Screen1-Tr-1-TI-5-IdPtr
                  USAGE IS POINTER.
       77 Screen1-Tr-1-TI-6-IdPtr
                  USAGE IS POINTER.
       77 Screen1-Tr-1-TI-7-IdPtr
                  USAGE IS POINTER.
       77 ID-UNO-A-Ptr
                  USAGE IS POINTER.
       77 ID-UNO-Ptr
                  USAGE IS POINTER.
       77 ID-DUE-Ptr
                  USAGE IS POINTER.
       77 ID-TRE-Ptr
                  USAGE IS POINTER.
       77 ID-UNO-B-Ptr
                  USAGE IS POINTER.
       77 ID-UNO-C-Ptr
                  USAGE IS POINTER.
       77 ID-UNO-B-1-Ptr
                  USAGE IS POINTER.
       77 ws-testo         PIC  X(30).
       77 Acucorp-bmp      PIC  S9(6)
                  USAGE IS COMP-4
                  VALUE IS 0.
       77 Screen1-Ta-1-Value           PIC  S9(1)
                  VALUE IS 1.
       77 Screen1-Pg-1-Visible         PIC  9
                  VALUE IS 0.
       77 Screen1-Pg-2-Visible         PIC  9
                  VALUE IS 0.
       77 Menu-Tree-TI-1-IdPtr
                  USAGE IS POINTER.
       77 Menu-Tree-TI-2-IdPtr
                  USAGE IS POINTER.
       77 Menu-Tree-TI-3-IdPtr
                  USAGE IS POINTER.
       77 Menu-Tree-TI-4-IdPtr
                  USAGE IS POINTER.
       77 Menu-Tree-TI-5-IdPtr
                  USAGE IS POINTER.
       77 W-NEX-ITEM-IND
                  USAGE IS POINTER.
       77 W-NOW-ITEM-IND
                  USAGE IS POINTER.
       77 W-NEX-ITEM-TREE  PIC  X(10).
       77 Menu-Tree-TI-6-IdPtr
                  USAGE IS POINTER.

      *{Bench}end
       LINKAGE                     SECTION.
      *{Bench}linkage
      *{Bench}end
       SCREEN                      SECTION.
      *{Bench}copy-screen
       01 Screen1, 
           BEFORE PROCEDURE Screen1-Bef-Procedure.
           03 Screen1-Pb-1, Push-Button, 
              COL 62,14, LINE 4,08, LINES 2,85 CELLS, SIZE 20,29 CELLS, 
              ID IS 2, 
              TITLE "Add UNO-D", 
              EXCEPTION PROCEDURE Screen1-Pb-1-Exception-Proc.
           03 Menu-Tree, Tree-View, 
              COL 5,71, LINE 3,46, LINES 13,08 CELLS, SIZE 32,71 CELLS, 
              3-D, BUTTONS, COLOR IS 482, ID IS 1, LINES-AT-ROOT, 
              SHOW-LINES, SHOW-SEL-ALWAYS, VALUE Menu-Tree-Value, 
              EVENT PROCEDURE Menu-Tree-Event-Proc.
           03 Screen1-Pb-2, Push-Button, 
              COL 41,00, LINE 8,69, LINES 2,92 CELLS, SIZE 20,14 CELLS, 
              ID IS 3, 
              TITLE "Select DUE", 
              EXCEPTION PROCEDURE Screen1-Pb-2-Exception-Proc.
           03 Screen1-Pb-2a, Push-Button, 
              COL 62,29, LINE 8,69, LINES 2,92 CELLS, SIZE 20,14 CELLS, 
              ID IS 4, 
              TITLE "Select UNO-B", 
              EXCEPTION PROCEDURE Screen1-Pb-2a-Exception-Proc.
           03 Screen1-Pb-3, Push-Button, 
              COL 41,00, LINE 4,08, LINES 3,38 CELLS, SIZE 19,86 CELLS, 
              ID IS 5, 
              TITLE "Add UNO-B-2", 
              EXCEPTION PROCEDURE Screen1-Pb-3-Exception-Proc.
           03 Screen1-Pb-4, Push-Button, 
              COL 41,00, LINE 12,92, LINES 3,62 CELLS, 
              SIZE 41,43 CELLS, 
              EXCEPTION-VALUE 1006, ID IS 6, SELF-ACT, 
              TITLE "Open menu UNO and Set focus UNO-B".
           03 Screen1-Ta-1, Tab-Control, 
              COL 4,14, LINE 22,08, LINES 14,23 CELLS, 
              SIZE 49,14 CELLS, 
              ID IS 7, VALUE Screen1-Ta-1-Value.
           03 Screen1-Pg-1, VISIBLE Screen1-Pg-1-Visible.
              05 Screen1-Tr-1, Tree-View, 
                 COL 6,57, LINE 24,69, LINES 10,31 CELLS, 
                 SIZE 39,57 CELLS, 
                 3-D, BUTTONS, ID IS 8, LINES-AT-ROOT, SHOW-LINES, 
                 SHOW-SEL-ALWAYS, VALUE Screen1-Tr-1-Value.
           03 Screen1-Pg-2, VISIBLE Screen1-Pg-2-Visible.
           03 Screen1-Pb-1a, Push-Button, 
              COL 42,43, LINE 17,92, LINES 3,08 CELLS, 
              SIZE 22,86 CELLS, 
              EXCEPTION-VALUE 1234, ID IS 9, SELF-ACT, 
              TITLE "Add FIRST".
           03 Screen1-Pb-1b, Push-Button, 
              COL 68,14, LINE 17,92, LINES 3,08 CELLS, 
              SIZE 18,57 CELLS, 
              EXCEPTION-VALUE 986, ID IS 10, SELF-ACT, 
              TITLE "Add LAST".
           03 Screen1-Pb-1c, Push-Button, 
              COL 57,14, LINE 22,62, LINES 3,46 CELLS, 
              SIZE 31,14 CELLS, 
              EXCEPTION-VALUE 3214, ID IS 11, SELF-ACT, 
              TITLE "HiddenData of Next Visible".
           03 Screen1-Pb-2b, Push-Button, 
              COL 57,57, LINE 27,69, LINES 3,38 CELLS, 
              SIZE 30,43 CELLS, 
              EXCEPTION-VALUE 3233, ID IS 12, 
              TITLE "HiddenData".

      *{Bench}end

      *{Bench}linkpara
       PROCEDURE DIVISION.
      *{Bench}end
      *{Bench}declarative
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
      *    After-Init
           .

       Acu-Exit-Rtn.
      *    After-Program
           EXIT PROGRAM
           STOP RUN
           .

       Acu-Screen1-Routine.
      *    Before-Routine
           PERFORM Acu-Screen1-Scrn
           PERFORM Acu-Screen1-Proc
      *    After-Routine
           .

       Acu-Screen1-Scrn.
           PERFORM Acu-Screen1-Create-Win
           PERFORM Acu-Screen1-Init-Data
           .

       Acu-Screen1-Create-Win.
      *    Before-Create
           MOVE 1 TO Screen1-Pg-1-Visible
      * display screen
              DISPLAY Standard GRAPHICAL WINDOW
                 LINES 36,92, SIZE 91,43, CELL HEIGHT 13, CELL WIDTH 7, 
                 AUTO-MINIMIZE, COLOR IS 65793, LABEL-OFFSET 0, 
                 LINK TO THREAD, MODELESS, NO SCROLL, WITH SYSTEM MENU, 
                 TITLE "Screen", TITLE-BAR, NO WRAP, 
                 HANDLE IS Screen1-Handle
      * toolbar
           DISPLAY Screen1 UPON Screen1-Handle
      *    After-Create
           .

       Acu-Screen1-Init-Data.
      *    Before-Initdata
           MODIFY Menu-Tree, 
              ITEM-TO-ADD = "UNO", GIVING ID-UNO-Ptr, HIDDEN-DATA = 
                 "1", 
              PARENT ID-UNO-Ptr, 
              ITEM-TO-ADD = "UNO-A", GIVING ID-UNO-A-Ptr, HIDDEN-DATA = 
                 "1a", 
              ITEM-TO-ADD = "UNO-B", GIVING ID-UNO-B-Ptr, HIDDEN-DATA = 
                 "1b", 
              PARENT ID-UNO-B-Ptr, 
              ITEM-TO-ADD = "UNO-B-1", GIVING ID-UNO-B-1-Ptr, 
                 HIDDEN-DATA = "1b1", 
              PARENT ID-UNO-Ptr, 
              ITEM-TO-ADD = "UNO-C", GIVING ID-UNO-C-Ptr, HIDDEN-DATA = 
                 "1c", 
              PARENT 0, 
              ITEM-TO-ADD = "DUE", GIVING ID-DUE-Ptr, HIDDEN-DATA = 
                 "2", 
              PARENT ID-DUE-Ptr, 
              ITEM-TO-ADD = "DUE-A", GIVING Menu-Tree-TI-1-IdPtr, 
                 HIDDEN-DATA = "2a", 
              ITEM-TO-ADD = "DUE-B", GIVING Menu-Tree-TI-2-IdPtr, 
                 HIDDEN-DATA = "2b", 
              PARENT 0, 
              ITEM-TO-ADD = "TRE", GIVING ID-TRE-Ptr, HIDDEN-DATA = 
                 "3", 
              PARENT ID-TRE-Ptr, 
              ITEM-TO-ADD = "TRE-A", GIVING Menu-Tree-TI-3-IdPtr, 
                 HIDDEN-DATA = "3a", 
              ITEM-TO-ADD = "TRE-B", GIVING Menu-Tree-TI-4-IdPtr, 
                 HIDDEN-DATA = "3b", 
              ITEM-TO-ADD = "TRE-C", GIVING Menu-Tree-TI-5-IdPtr, 
                 HIDDEN-DATA = "3c", 
              PARENT 0, 
              ITEM-TO-ADD = "QUATTRO", GIVING Menu-Tree-TI-6-IdPtr
           MODIFY Screen1-Ta-1, TAB-TO-ADD = ("Page-1", "Page-2")
           MODIFY Screen1-Ta-1, VALUE = 1
           MODIFY Screen1-Tr-1, 
              ITEM-TO-ADD = "AAA", GIVING Screen1-Tr-1-TI-1-IdPtr, 
              ITEM-TO-ADD = "BBB", GIVING Screen1-Tr-1-TI-2-IdPtr, 
              ITEM-TO-ADD = "CCC", GIVING Screen1-Tr-1-TI-3-IdPtr
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

      * Screen1
       Acu-Screen1-Evaluate-Func.
           EVALUATE TRUE
              WHEN Exit-Pushed
                 PERFORM Acu-Screen1-Exit
              WHEN Event-Occurred
                 IF Event-Type = Cmd-Close
                    PERFORM Acu-Screen1-Exit
                 END-IF
           IF Event-Control-Id = 7 AND Event-Type = Cmd-Tabchanged
              PERFORM Acu-Screen1-Ta-1-Cmd-Tabchanged
           END-IF
      * Screen1-Pb-4 Link To
              WHEN Key-Status = 1006
                 PERFORM Screen1-Pb-4-Ex-Cmd-Clicked
      * Screen1-Pb-1a Link To
              WHEN Key-Status = 1234
                 PERFORM Screen1-Pb-1-Link
      * Screen1-Pb-1b Link To
              WHEN Key-Status = 986
                 PERFORM Screen1-Pb-Last-Link
      * Screen1-Pb-1c Link To
              WHEN Key-Status = 3214
                 PERFORM Screen1-Pb-Next-Link
      * Screen1-Pb-2b Link To
              WHEN Key-Status = 3233
                 PERFORM Screen1-Pb-HD-Link
           END-EVALUATE
           MOVE 1 TO Accept-Control
           .

       Acu-Screen1-Exit.
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

       Acu-Screen1-Ta-1-Cmd-Tabchanged.
           EVALUATE Event-Type
           WHEN Cmd-Tabchanged
              MOVE Event-Data-1 TO Screen1-Ta-1-Value
              MOVE 0 TO Screen1-Pg-1-Visible, Screen1-Pg-2-Visible
              EVALUATE Event-Data-1
              WHEN 1
                 MOVE 1 TO Screen1-Pg-1-Visible
              WHEN 2
                 MOVE 1 TO Screen1-Pg-2-Visible
              END-EVALUATE
      *       Before-Tabchg-Display
              DISPLAY Screen1
      *       After-Tabchg-Display
           END-EVALUATE
           .

       Screen1-Pb-1-Exception-Proc.
      * 
           IF Event-Occurred
              EVALUATE Event-Type
              WHEN Cmd-Clicked
                 PERFORM Aggiungi-Uno-D
              END-EVALUATE
           END-IF
           .

       Menu-Tree-Event-Proc.
      * 
           EVALUATE Event-Type
           WHEN Msg-Tv-Dblclick
              PERFORM Menu-Tree-Ev-Msg-Tv-Dblclick
           WHEN Msg-Tv-Selchange
              PERFORM Menu-Tree-Ev-Msg-Tv-Selchange
           END-EVALUATE
           .

       Screen1-Pb-2-Exception-Proc.
      * 
           IF Event-Occurred
              EVALUATE Event-Type
              WHEN Cmd-Clicked
                 PERFORM Seleziona-DUE
              END-EVALUATE
           END-IF
           .

       Screen1-Pb-2a-Exception-Proc.
      * 
           IF Event-Occurred
              EVALUATE Event-Type
              WHEN Cmd-Clicked
                 PERFORM Seleziona-UNO-B
              END-EVALUATE
           END-IF
           .

       Screen1-Pb-3-Exception-Proc.
      * 
           IF Event-Occurred
              EVALUATE Event-Type
              WHEN Cmd-Clicked
                 PERFORM Aggiungi-UNO-B-2
              END-EVALUATE
           END-IF
           .
      ***   start event editor code   ***
      *
       Aggiungi-Uno-D.        

           modify menu-Tree, parent = ID-UNO-Ptr
                             ITEM-TO-ADD = "UNO-D",
                             giving new-pointer1   
           .
      *
       Seleziona-DUE.
           modify Menu-Tree, value = ID-DUE-Ptr
           .
      *
       Seleziona-UNO-B.
           modify Menu-Tree, value = ID-UNO-B-Ptr
           .
      *
       Aggiungi-UNO-B-2.

           modify Menu-Tree, parent = ID-UNO-B-Ptr
                             ITEM-TO-ADD = "UNO-B-2",
                             giving new-pointer2            

       
           .
      *
       Screen1-Pb-4-Ex-Cmd-Clicked.
           modify Menu-Tree, ITEM = ID-UNO-Ptr
                             EXPAND = TVFLAG-EXPAND

           modify Menu-Tree, value = ID-UNO-B-Ptr

           .
      *
       Screen1-Bef-Procedure.                      

           modify Menu-Tree, ITEM = ID-UNO-Ptr
                             EXPAND = TVFLAG-EXPAND 
           .
      *
       Menu-Tree-Ev-Msg-Tv-Dblclick.
           inquire Menu-Tree (event-data-2), HIDDEN-DATA in ws-menu

           display message box "this is " ws-menu   

           . 
      *
       Screen1-Pb-1-Link.                                 
           modify Menu-Tree, parent = ID-UNO-Ptr
                             PLACEMENT = ID-UNO-B-Ptr
                             ITEM-TO-ADD = "IT-FIRST" 
                             .
      *
       Screen1-Pb-Last-Link.
           modify Menu-Tree, parent = ID-UNO-Ptr
                             PLACEMENT = TVPLACE-LAST
                             ITEM-TO-ADD = "IT-LAST" 
                             .
      
       Menu-Tree-Ev-Msg-Tv-Selchange. 
           inquire Menu-Tree (event-data-2), HIDDEN-DATA in ws-menu

           evaluate ws-menu 
              when 1                                        
                 modify Menu-Tree, ITEM = ID-DUE-Ptr
                                   EXPAND = TVFLAG-COLLAPSE 
                 modify Menu-Tree, ITEM = ID-TRE-Ptr
                                   EXPAND = TVFLAG-COLLAPSE 
                 modify Menu-Tree, ITEM = ID-UNO-Ptr
                                   EXPAND = TVFLAG-EXPAND  
              when 2 
                 modify Menu-Tree, ITEM = ID-UNO-Ptr
                                   EXPAND = TVFLAG-COLLAPSE 
                 modify Menu-Tree, ITEM = ID-TRE-Ptr
                                   EXPAND = TVFLAG-COLLAPSE 
                 modify Menu-Tree, ITEM = ID-DUE-Ptr
                                   EXPAND = TVFLAG-EXPAND   
              when 3 
                 modify Menu-Tree, ITEM = ID-UNO-Ptr
                                   EXPAND = TVFLAG-COLLAPSE 
                 modify Menu-Tree, ITEM = ID-DUE-Ptr
                                   EXPAND = TVFLAG-COLLAPSE  
                 modify Menu-Tree, ITEM = ID-TRE-Ptr
                                   EXPAND = TVFLAG-EXPAND     
           end-evaluate
           .
      *
       Screen1-Pb-Next-Link.   
           initialize W-NEX-ITEM-TREE, W-NOW-ITEM-IND 
           INQUIRE Menu-Tree, ITEM in W-NOW-ITEM-IND
           MODIFY Menu-Tree (W-NOW-ITEM-IND), 
                             NEXT-ITEM = TVNI-NEXT-VISIBLE,                               
                             GIVING W-NEX-ITEM-IND
           IF W-NEX-ITEM-IND not = 0                    
              INQUIRE Menu-Tree (W-NEX-ITEM-IND),
                                 HIDDEN-DATA in W-NEX-ITEM-TREE  
              DISPLAY MESSAGE BOX "Hidden data = " W-NEX-ITEM-TREE
           ELSE
              DISPLAY MESSAGE BOX "W-NEX-ITEM-IND = 0"
           END-IF
           .
      *
       Screen1-Pb-HD-Link.             
           initialize W-NEX-ITEM-TREE, W-NOW-ITEM-IND    
           INQUIRE Menu-Tree, ITEM in W-NOW-ITEM-IND  
           INQUIRE Menu-Tree (W-NOW-ITEM-IND ),
                             HIDDEN-DATA in W-NEX-ITEM-TREE   
           DISPLAY MESSAGE BOX "Hidden data = " W-NEX-ITEM-TREE
           .

       

      *{Bench}end
       REPORT-COMPOSER SECTION.
