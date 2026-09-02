      *{Bench}prg-comment
      * treeview2-dss.cbl
      * treeview2-dss.cbl is generated from C:\AcuSamples\treeview\treeview2-dss\treeview2-dss.Psf
      *{Bench}end
       IDENTIFICATION              DIVISION.
      *{Bench}prgid
       PROGRAM-ID. treeview2-dss.
       AUTHOR. Administrator.
       DATE-WRITTEN. Tuesday, December 1, 2020 11:19:08 AM.
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
       77 Screen1-Tr-1-Value
                  USAGE IS POINTER
                  VALUE IS NULL.
       77 hidden-info      PIC  9(3).
       77 saved-parent
                  USAGE IS POINTER.
       77 ws-text          PIC  x(30).
       77 ws-item-text     PIC  x(20).
       77 ws-saved-text    PIC  x(30).
       77 ws-saved-parent-text         PIC  x(30).
       77 ws-counter       PIC  9(2).
       77 Screen1-Cb-1-Value           PIC  9
                  VALUE IS 0.
       77 Screen1-Tr-1-Pointer
                  USAGE IS POINTER
                  OCCURS 10 TIMES.
       77 Screen1-Tr-1-Pointer-Root
                  USAGE IS POINTER.
       77 item-1
                  USAGE IS POINTER.
       77 saved-selected
                  USAGE IS POINTER
                  VALUE IS null.

      *{Bench}end
       LINKAGE                     SECTION.
      *{Bench}linkage
      *{Bench}end
       SCREEN                      SECTION.
      *{Bench}copy-screen
       01 Screen1.
           03 Screen1-Tr-1, Tree-View, 
              COL 5.00, LINE 2.80, LINES 29.00 CELLS, SIZE 31.20 CELLS, 
              3-D, BUTTONS, ID IS 1, LINES-AT-ROOT, SHOW-LINES, 
              SHOW-SEL-ALWAYS, VALUE Screen1-Tr-1-Value, 
              BEFORE PROCEDURE Screen1-Tr-1-Bef-Procedure, 
              EVENT PROCEDURE Screen1-Tr-1-Event-Proc.
           03 Screen1-Cb-1, Check-Box, 
              COL 39.30, LINE 3.80, LINES 1.60 CELLS, SIZE 18.10 CELLS, 
              ID IS 2, SELF-ACT, 
              TITLE "Collapse non-selected Items", 
              VALUE Screen1-Cb-1-Value.
           03 Screen1-Pb-1, Push-Button, 
              COL 51.10, LINE 28.90, LINES 3.20 CELLS, SIZE 8.80 CELLS, 
              EXCEPTION-VALUE 123, ID IS 3, SELF-ACT, 
              TITLE "Exit".

      *{Bench}end

       PROCEDURE DIVISION 
           chaining ws-saved-text 
                    ws-saved-parent-text 
                    Screen1-Cb-1-Value
                    .

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
      * destroy font
           PERFORM Acu-Exit-Font
      * destroy bitmap
           PERFORM Acu-Exit-Bmp
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
      * display screen
              DISPLAY Standard GRAPHICAL WINDOW
                 LINES 32.80, SIZE 61.00, CELL HEIGHT 10, 
                 CELL WIDTH 10, AUTO-MINIMIZE, COLOR IS 65793, 
                 LABEL-OFFSET 0, LINK TO THREAD, MODELESS, NO SCROLL, 
                 WITH SYSTEM MENU, 
                 TITLE "Screen", TITLE-BAR, NO WRAP, 
                 EVENT PROCEDURE Screen1-Event-Proc, 
                 HANDLE IS Screen1-Handle
      * toolbar
           DISPLAY Screen1 UPON Screen1-Handle
      *    After-Create
           .

       Acu-Screen1-Init-Data.
      *    Before-Initdata
           MODIFY Screen1-Tr-1, 
              ITEM-TO-ADD = "New TreeView 2", 
                 GIVING Screen1-Tr-1-Pointer-Root, HIDDEN-DATA = "999", 
                 HAS-CHILDREN 1
           PERFORM Screen1-Aft-Initdata
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
      * Screen1-Pb-1 Link To
              WHEN Key-Status = 123
                 PERFORM Screen1-Pb-1-Link
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

       Screen1-Event-Proc.
      * 
           PERFORM Acu-Screen1-Event-Extra
           .

       Screen1-Tr-1-Event-Proc.
      * 
           EVALUATE Event-Type
           WHEN Msg-Tv-Dblclick
              PERFORM Screen1-Tr-1-Ev-Msg-Tv-Dblclick
           WHEN Msg-Tv-Expanding
              PERFORM Screen1-Tr-1-Ev-Msg-Tv-Expanding
           WHEN Msg-Tv-Selchange
              PERFORM Screen1-Tr-1-Ev-Msg-Tv-Selchange
           END-EVALUATE
           .
      ***   start event editor code   ***
      *
       Screen1-Tr-1-Ev-Msg-Tv-Expanding.
           if event-data-1 = tvflag-expand
              modify Screen1-Tr-1 (event-data-2)
                     next-item = tvni-child
                     giving item-1
              if item-1 = null
                 perform add-children
              end-if
           else
              continue
           end-if
           .

       add-children.
           inquire Screen1-Tr-1 (event-data-2)
              hidden-data in hidden-info
              item-text   in ws-item-text
           move event-data-2 to saved-parent 

           if hidden-info = 999
              perform add-main-menu
           else

              initialize ws-counter ws-text
              perform hidden-info times
                 add 1 to ws-counter
                 string ws-item-text delimited by space
                        "-Sub-Item-"
                        ws-counter
                        into ws-text
                 modify Screen1-Tr-1 (event-data-2)
                        parent = saved-parent
                        item-to-add = ws-text 
                        giving item-1
                        placement = tvplace-last
                        has-children = 0
                        hidden-data = ws-text
                 if ws-text = ws-saved-text
                    move item-1 to saved-selected
                 end-if
              end-perform

           end-if
           .

       add-main-menu.
           modify Screen1-Tr-1 (event-data-2)
                  parent = saved-parent
                  ITEM-TO-ADD = "UNO", GIVING Screen1-Tr-1-Pointer(1), 
                  HIDDEN-DATA = "1", HAS-CHILDREN 1.
           if "UNO" = ws-saved-parent-text
              move Screen1-Tr-1-Pointer(1) to saved-selected
           end-if   
           modify Screen1-Tr-1 (event-data-2)
                  parent = saved-parent
                  ITEM-TO-ADD = "DUE", GIVING Screen1-Tr-1-Pointer(2), 
                  HIDDEN-DATA = "2", HAS-CHILDREN 1.
           if "DUE" = ws-saved-parent-text
              move Screen1-Tr-1-Pointer(2) to saved-selected
           end-if    
           modify Screen1-Tr-1 (event-data-2)
                  parent = saved-parent
                  ITEM-TO-ADD = "TRE", GIVING Screen1-Tr-1-Pointer(3), 
                  HIDDEN-DATA = "3", HAS-CHILDREN 1.
           if "TRE" = ws-saved-parent-text
              move Screen1-Tr-1-Pointer(3) to saved-selected
           end-if     
           modify Screen1-Tr-1 (event-data-2)
                  parent = saved-parent
                ITEM-TO-ADD = "QUATTRO", GIVING Screen1-Tr-1-Pointer(4), 
                  HIDDEN-DATA = "4", HAS-CHILDREN 1.
           if "QUATTRO" = ws-saved-parent-text
              move Screen1-Tr-1-Pointer(4) to saved-selected
           end-if        
           modify Screen1-Tr-1 (event-data-2)
                  parent = saved-parent
                 ITEM-TO-ADD = "CINQUE", GIVING Screen1-Tr-1-Pointer(5), 
                  HIDDEN-DATA = "5", HAS-CHILDREN 1.
           if "CINQUE" = ws-saved-parent-text
              move Screen1-Tr-1-Pointer(5) to saved-selected
           end-if          
           modify Screen1-Tr-1 (event-data-2)
                  parent = saved-parent
                  ITEM-TO-ADD = "SEI", GIVING Screen1-Tr-1-Pointer(6), 
                  HIDDEN-DATA = "6", HAS-CHILDREN 1.
           if "SEI" = ws-saved-parent-text
              move Screen1-Tr-1-Pointer(6) to saved-selected
           end-if           
           modify Screen1-Tr-1 (event-data-2)
                  parent = saved-parent
                  ITEM-TO-ADD = "SETTE", GIVING Screen1-Tr-1-Pointer(7), 
                  HIDDEN-DATA = "7", HAS-CHILDREN 1.
           if "SETTE" = ws-saved-parent-text
              move Screen1-Tr-1-Pointer(7) to saved-selected
           end-if             
           modify Screen1-Tr-1 (event-data-2)
                  parent = saved-parent
                  ITEM-TO-ADD = "OTTO", GIVING Screen1-Tr-1-Pointer(8), 
                  HIDDEN-DATA = "8", HAS-CHILDREN 1.
           if "OTTO" = ws-saved-parent-text
              move Screen1-Tr-1-Pointer(8) to saved-selected
           end-if               
           modify Screen1-Tr-1 (event-data-2)
                  parent = saved-parent
                  ITEM-TO-ADD = "NOVE", GIVING Screen1-Tr-1-Pointer(9), 
                  HIDDEN-DATA = "9", HAS-CHILDREN 1.
           if "NOVE" = ws-saved-parent-text
              move Screen1-Tr-1-Pointer(9) to saved-selected
           end-if             
           modify Screen1-Tr-1 (event-data-2)
                  parent = saved-parent
                 ITEM-TO-ADD = "DIECI", GIVING Screen1-Tr-1-Pointer(10), 
                  HIDDEN-DATA = "10", HAS-CHILDREN 1.
           if "DIECI" = ws-saved-parent-text
              move Screen1-Tr-1-Pointer(10) to saved-selected
           end-if
           .
           
      *
       Screen1-Tr-1-Ev-Msg-Tv-Dblclick.
           inquire Screen1-Tr-1 (event-data-2)
              hidden-data in ws-saved-text  
           modify Screen1-Tr-1 (event-data-2)
                  next-item = tvni-parent
                  giving item-1 
           inquire Screen1-Tr-1 (item-1)
              item-text in ws-saved-parent-text   
           destroy Screen1
           |display message box ws-text
           chain "treeview2-dss-display" 
                 using ws-saved-text 
                       ws-saved-parent-text 
                       Screen1-Cb-1-Value
           .
      *
       Screen1-Tr-1-Ev-Msg-Tv-Selchange. 
           inquire Screen1-Cb-1 value in Screen1-Cb-1-Value
           if Screen1-Cb-1-Value = 1  
              modify Screen1-Tr-1 (event-data-2)
                     next-item = tvni-child
                     giving item-1
              if item-1 = null
                 modify Screen1-Tr-1 (event-data-2)
                        next-item = tvni-parent
                        giving item-1
              else
                 move event-data-2 to item-1    
              end-if    
              perform varying ws-counter from 1 by 1 
                       until ws-counter > 10
                 if Screen1-Tr-1-Pointer(ws-counter) not = item-1                  
                    modify Screen1-Tr-1 
                           item = Screen1-Tr-1-Pointer(ws-counter)
                           EXPAND = TVFLAG-COLLAPSE 
                 else               
                    modify Screen1-Tr-1 
                           item = item-1
                           EXPAND = TVFLAG-EXPAND 
                 end-if  
              end-perform
           end-if  
           .


      *
       Screen1-Aft-Initdata.  
           modify Screen1-Tr-1, item = Screen1-Tr-1-Pointer-Root 
                                EXPAND = TVFLAG-EXPAND 
           if saved-selected not = null
              modify Screen1-Tr-1 item = saved-selected    
                                  EXPAND = TVFLAG-EXPAND  
              modify Screen1-Tr-1 value = saved-selected 
           end-if
           .
      *
       Screen1-Pb-1-Link.
           stop run
           .
      *
       Screen1-Tr-1-Bef-Procedure.
           .

       

      *{Bench}end
       REPORT-COMPOSER SECTION.
