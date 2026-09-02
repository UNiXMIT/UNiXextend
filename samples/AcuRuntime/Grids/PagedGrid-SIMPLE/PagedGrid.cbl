       PROGRAM-ID.  Paged-grid.

       FILE-CONTROL.
       select filegrid assign to random "grd"
              organization indexed access dynamic record key f-key.

       FILE SECTION.
       fd  filegrid.
       01  f-rec.
           03 f-key       pic x(2).
           03 f-type      pic x(13).
           03 f-author    pic x(15).
           03 f-title     pic x(20).

       WORKING-STORAGE SECTION.
       copy "acugui.def".
       copy "crtvars.def".
       77  key-status     is special-names crt status pic 9(5).
       77  i              pic 9(18).
       
       77  wk-num-cols    pic 9(2) value 4.
       
       01  wk-rec-5.
           03 wk-new         pic 9(8).
           03 wk-subrec-5.
             05 wk-key       pic x(2).
             05 wk-type      pic x(13).
             05 wk-author    pic x(15).
             05 wk-title     pic x(20).
             
       01 wk-hidden      pic x(20).

       SCREEN SECTION.
       01  main-screen.
           03 grid-1 grid 
                   paged 
                   line 2 
                   col 2 
                   size 68 
                   cells lines 4
                   data-columns (1, 3, 16, 31)
                   display-columns (1, 4, 18, 42)
                   event GRID-1-EVENT.
           03 push-button 
                   line 9.5 
                   col  2
                   size 10 
                   exception-value 101
                   title "First".
           03 push-button 
                   line 9.5 
                   col  + 1
                   size 10 
                   exception-value 102
                   title "PrevPage".
           03 push-button 
                   line 9.5 
                   col  + 1
                   size 10 
                   exception-value 103
                   title "Prev".
           03 push-button 
                   line 9.5 
                   col  + 1
                   size 10 
                   exception-value 104
                   title "Next".
           03 push-button 
                   line 9.5 
                   col  + 1
                   size 10 
                   exception-value 105
                   title "NextPage".
           03 push-button 
                   line 9.5 
                   col  + 1
                   size 10 
                   exception-value 106
                   title "Last".
           03 push-button 
                   line 11.5 
                   col  2
                   size 10 
                   exception-value 107
                   title "New Col".
           03 push-button 
                   line 11.5 
                   col  58
                   size 10 
                   exception-value 27
                   title "Esc".

       PROCEDURE DIVISION.
       MAIN-LOGIC.
           display standard graphical window background-low
                   size 70 lines 13
           open input filegrid
           display main-screen
           perform load-grid
           perform until key-status = 27
              accept main-screen on exception continue end-accept
              evaluate key-status
              when 101     modify grid-1 action = ACTION-FIRST-PAGE
              when 102     modify grid-1 action = ACTION-PREVIOUS-PAGE
              when 103     modify grid-1 action = ACTION-PREVIOUS
              when 104     modify grid-1 action = ACTION-NEXT
              when 105     modify grid-1 action = ACTION-NEXT-PAGE
              when 106     modify grid-1 action = ACTION-LAST-PAGE
              when 107     move 5 to wk-num-cols
                           perform ADD-COLUMN
                           perform LOAD-GRID
              end-evaluate
           end-perform
           close filegrid
           destroy main-screen
           goback.

      ***---
       LOAD-GRID.
           modify grid-1 action = ACTION-FIRST-PAGE.      

      ***---
       GRID-1-EVENT.
           evaluate event-type
           when MSG-PAGED-NEXT       
                perform GRID-1-NEXT
           when MSG-PAGED-PREV       
                perform GRID-1-PREV
           when MSG-PAGED-NEXTPAGE   
                continue
           when MSG-PAGED-PREVPAGE   
                continue
           when MSG-PAGED-FIRST      
                perform GRID-1-FIRST
           when MSG-PAGED-LAST       
                perform GRID-1-LAST
           WHEN MSG-BEGIN-ENTRY
                set event-action to event-action-fail
           END-EVALUATE.
        
      ***---
       GRID-1-FIRST.
           move low-value to f-key
           start filegrid key not less f-key
             invalid set event-action to event-action-fail
           end-start.

      ***---
       GRID-1-LAST.
           move high-value to f-key
           start filegrid key <= f-key
              invalid set event-action to event-action-fail
           end-start.

      ***---
       GRID-1-NEXT.
           perform event-data-2 times
              read filegrid next
                 at end set event-action to event-action-fail 
                        exit paragraph
              end-read
           end-perform
           if wk-num-cols = 4
             modify grid-1 record-to-add = f-rec
           else
             move f-rec to wk-subrec-5
             accept wk-new from time    | adding time value just to populate this column
             accept wk-hidden from date | adding date value just to populate the hidden column
             modify grid-1 record-to-add = wk-rec-5
                           hidden-data   = wk-hidden
           end-if
           .

      ***---
       GRID-1-PREV.
           perform event-data-2 times
              read filegrid previous
                 at end set event-action to event-action-fail 
                        exit paragraph
              end-read
           end-perform
           if wk-num-cols = 4
              modify grid-1 insertion-index = 1
                            record-to-add   = f-rec
           else
             move f-rec to wk-subrec-5
             accept wk-new from time    | adding time value just to populate this column
             accept wk-hidden from date | adding date value just to populate the hidden column
             modify grid-1 insertion-index = 1
                           record-to-add   = wk-rec-5
                           hidden-data     = wk-hidden
           end-if.

      ***---
       ADD-COLUMN.  
           destroy grid-1
           display grid-1
      * adding a new column at col 1, switching data-columns to the right by 8 
      * and display-columns by necessary values for data to be displayed
      * from:
      * data-columns (1, 3, 16, 31)
      * display-columns (1, 4, 18, 42)
      * to: 
           modify grid-1  
                   data-columns (1, 9, 11, 24, 39)
                   display-columns (1, 10, 14, 26, 42)
           .
                  

      ***---     
       add-hidden-column.                

