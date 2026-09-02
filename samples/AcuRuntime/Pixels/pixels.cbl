       identification division.
       program-id. pixels.
       author. mturner.

       environment division.
       input-output section.
       
       data division.
       file section.
       working-storage section.
       01 window-handle    usage handle.
       01 button-handle    usage handle.
       01 button-width     pic 9(3) value zeros.
       01 button-height    pic 9(3) value zeros.
       01 button-line      pic 9(3) value zeros.
       01 button-col       pic 9(3) value zeros.
       01 pixel-width      pic 9(3) value zeros.
       01 pixel-height     pic 9(3) value zeros.
       01 pixel-line       pic 9(3) value zeros.
       01 pixel-col        pic 9(3) value zeros.

       linkage section.

       screen section.

       procedure division.

           perform display-window
           perform calculate-pixels
           goback.

       display-window.

           display standard graphical window
               size 40
               lines 22
               cell height = 10
               cell width = 10
               handle in window-handle
           
           display push-button "PIXELS" at 0617
               size 8
               lines 2
               handle in button-handle 

           display label "Button width in PIXELS = " at 1210
           display label "Button height in PIXELS = " at 1410
           display label "Button line in PIXELS = " at 1610
           display label "Button column in PIXELS = " at 1810

           accept button-handle.

       calculate-pixels.

           inquire button-handle
               size in button-width
               lines in button-height
               line in button-line
               col in button-col             
           
           compute pixel-width = button-width / 0.1
           compute pixel-height = button-height / 0.1
           compute pixel-line = button-line / 0.1
           compute pixel-col = button-col / 0.1

           display label pixel-width at 1229
           display label pixel-height at 1429
           display label pixel-line at 1629
           display label pixel-col at 1829

           modify button-handle title "CLOSE"

           accept button-handle.