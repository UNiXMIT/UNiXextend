       IDENTIFICATION              DIVISION.
       PROGRAM-ID. pdfgrid.
       AUTHOR. RZack.
       DATE-WRITTEN. Tuesday, December 19, 2017 10:06:22 AM.
       REMARKS. 
           This program shows how to draw grids with C$PDF.
           It can be invoked stand-alone and will create a
           print.pdf file with a grid.
           Alternately, it can be called from a COBOL program
           that has created a PDF doc and page, and it will add
           the grid to that page.

       DATA                        DIVISION.
       FILE                        SECTION.
       WORKING-STORAGE             SECTION.
       copy "cpdf.def".

       01 cur-x
                  USAGE IS UNSIGNED-INT.
       01 cur-y
                  USAGE IS UNSIGNED-INT.
       01 disp-xy          PIC  zz9
                  USAGE IS DISPLAY.
       01 arg-count        PIC  99
                  USAGE IS COMP-1.

       LINKAGE                     SECTION.
       01 this-doc                 USAGE HANDLE.
       01 this-page                USAGE HANDLE.

       PROCEDURE DIVISION USING this-doc, this-page.

       Acu-Main-Logic.
           call "C$NARG" using Arg-Count
           if arg-count = 0
               call "C$PDF" using HPDF-New
                    giving HPDF-Doc
               if HPDF-Doc = null
                   display message "Unable to create PDF document"
                   stop run
               end-if
               call "C$PDF" using HPDF-AddPage,
                       HPDF-Doc
                   giving
                       HPDF-Page
               if HPDF-Page = null
                   call "C$PDF" using HPDF-Free,
                       HPDF-Doc
                   display message "Unable to create PDF page"
                   stop run
               end-if

               move HPDF-PRINT-SCALING-NONE to
                   HPDF-SETVIEWERPREFERENCE-VALUE
               call "C$PDF" using HPDF-SETVIEWERPREFERENCE
                   HPDF-DOC,
                   HPDF-SETVIEWERPREFERENCE-VALUE

      * Set the page size to letter and direction to portrait
               move HPDF-PAGE-SIZE-LETTER to HPDF-PAGESIZE
               move HPDF-PAGE-PORTRAIT to HPDF-PAGEDIRECTION
               call "C$PDF" using HPDF-PAGE-SETSIZE
                   HPDF-PAGE,
                   HPDF-PAGESIZE,
                   HPDF-PAGEDIRECTION
           else
               move this-doc to Hpdf-Doc
               move this-page to Hpdf-Page
           end-if

      * Get the page height
           call "C$PDF" using HPDF-PAGE-GETHEIGHT
              HPDF-PAGE,
              giving HPDF-PAGEHEIGHT-R

      * Get the page width
           call "C$PDF" using HPDF-PAGE-GETWIDTH
              HPDF-PAGE,
              giving HPDF-PAGEWIDTH-R

      * Get a font handle, and set a size
           call "C$PDF" using HPDF-GETFONT
              HPDF-DOC, "Helvetica",
              giving HPDF-GETFONT-FONT
           call "C$PDF" using HPDF-PAGE-SETFONTANDSIZE
                HPDF-PAGE, HPDF-GETFONT-FONT, 5

           call "C$PDF" using HPDF-PAGE-SETGRAYFILL
           HPDF-PAGE, 0.5
 
           call "C$PDF" using HPDF-PAGE-SETGRAYSTROKE
           HPDF-PAGE, 0.8

           perform draw-horizontal-lines
           perform draw-vertical-lines
           perform draw-horizontal-text
           perform draw-vertical-text

      * Technically, we should get the values above, and reset
      * them to their original values. But this will do for a
      * demonstration.
           call "C$PDF" using HPDF-PAGE-SETGRAYFILL
              HPDF-PAGE, 0
 
           call "C$PDF" using HPDF-PAGE-SETGRAYSTROKE
              HPDF-PAGE, 0

           if arg-count = 0
               move "pdfgrid.pdf" to HPDF-SaveFileName
               call "C$PDF" using HPDF-SaveToFile
                   HPDF-Doc,
                   HPDF-SaveFileName
               call "C$PDF" using HPDF-Free,
                   HPDF-Doc,
                   HPDF-User-Data
           end-if
           exit program
           stop run
           .

       draw-horizontal-lines.
           move 0 to Hpdf-MoveTo-X
           move 5 to Hpdf-LineTo-X
           perform varying cur-y from 0 by 5
               until cur-y >= HPDF-PAGEHEIGHT
               if $mod(cur-y, 10) = 0
                   move .5 to Hpdf-LineWidth-Line-Width
               else
                    move .25 to Hpdf-LineWidth-Line-Width
               end-if
               call "C$PDF" using HPDF-Page-SetLineWidth,
                       Hpdf-Page,
                       Hpdf-LineWidth-Line-Width
               
               move Cur-Y to Hpdf-MoveTo-Y
               call "C$PDF" using HPDF-Page-MoveTo,
                       Hpdf-Page,
                       Hpdf-MoveTo-X, Hpdf-MoveTo-Y
               call "C$PDF" using HPDF-Page-LineTo,
                       Hpdf-Page,
                       Hpdf-PageWidth, Hpdf-MoveTo-Y
               call "C$PDF" using HPDF-Page-Stroke,
                       Hpdf-Page

               if $mod(cur-y, 10) = 0 and cur-y > 0
                   move 0.5 to HPDF-X
                   call "C$PDF" using HPDF-PAGE-SETGRAYSTROKE
                           HPDF-PAGE
                           HPDF-X
                   call "C$PDF" using HPDF-Page-MoveTo,
                           Hpdf-Page,
                           Hpdf-MoveTo-X, Hpdf-MoveTo-Y
                   call "C$PDF" using HPDF-Page-LineTo,
                           Hpdf-Page,
                           Hpdf-LineTo-X, Hpdf-MoveTo-Y
                   call "C$PDF" using HPDF-Page-Stroke,
                           Hpdf-Page
                   move 0.8 to HPDF-X
                   call "C$PDF" using HPDF-PAGE-SETGRAYSTROKE
                           HPDF-PAGE
                           HPDF-X
               end-if
           end-perform
           .

       draw-vertical-lines.
           move 0 to Hpdf-MoveTo-Y
           move 5 to Hpdf-LineTo-Y
           perform varying cur-x from 0 by 5
               until cur-x >= HPDF-PAGEHEIGHT
               if $mod(cur-x, 10) = 0
                   move .5 to Hpdf-LineWidth-Line-Width
               else
                   move .25 to Hpdf-LineWidth-Line-Width
               end-if
               call "C$PDF" using HPDF-Page-SetLineWidth,
                       Hpdf-Page,
                       Hpdf-LineWidth-Line-Width
               
               move Cur-X to Hpdf-MoveTo-X
               call "C$PDF" using HPDF-Page-MoveTo,
                       Hpdf-Page,
                       Hpdf-MoveTo-X, Hpdf-MoveTo-Y
               call "C$PDF" using HPDF-Page-LineTo,
                       Hpdf-Page,
                       Hpdf-MoveTo-X, Hpdf-PageHeight
               call "C$PDF" using HPDF-Page-Stroke,
                       Hpdf-Page

               if $mod(cur-x, 10) = 0 and cur-x > 0
                   move 0.5 to HPDF-X
                   call "C$PDF" using HPDF-PAGE-SETGRAYSTROKE
                           HPDF-PAGE
                           HPDF-X
                   call "C$PDF" using HPDF-Page-MoveTo,
                           Hpdf-Page,
                           Hpdf-MoveTo-X, Hpdf-MoveTo-Y
                   call "C$PDF" using HPDF-Page-LineTo,
                           Hpdf-Page,
                           Hpdf-MoveTo-X, Hpdf-LineTo-Y
                   call "C$PDF" using HPDF-Page-Stroke,
                           Hpdf-Page
                   call "C$PDF" using HPDF-Page-MoveTo,
                           Hpdf-Page,
                           Hpdf-MoveTo-X, Hpdf-PageHeight
                   subtract 5 from Hpdf-PageHeight
                   call "C$PDF" using HPDF-Page-LineTo,
                           Hpdf-Page,
                           Hpdf-MoveTo-X, Hpdf-PageHeight
                   add 5 to Hpdf-PageHeight
                   call "C$PDF" using HPDF-Page-Stroke,
                           Hpdf-Page
                   move 0.8 to HPDF-X
                   call "C$PDF" using HPDF-PAGE-SETGRAYSTROKE
                           HPDF-PAGE
                           HPDF-X
               end-if
           end-perform
           .

       draw-horizontal-text.
           move 0 to Hpdf-MoveTo-X
           move 5 to Hpdf-LineTo-X
           perform varying cur-y from 0 by 10
               until cur-y >= HPDF-PAGEHEIGHT

               if cur-y > 0
                   subtract 2 from Cur-Y giving Hpdf-LineTo-Y
                   call "C$PDF" using HPDF-Page-BeginText,
                           Hpdf-Page
                   call "C$PDF" using HPDF-Page-MoveTextPos,
                           Hpdf-Page,
                           Hpdf-LineTo-X, Hpdf-LineTo-Y
                   subtract 2 from Cur-Y giving Disp-XY
                   call "C$PDF" using HPDF-Page-ShowText,
                           Hpdf-Page,
                           Disp-XY
                   call "C$PDF" using HPDF-Page-EndText,
                           Hpdf-Page
               end-if
           end-perform
           .

       draw-vertical-text.
           move 5 to Hpdf-LineTo-Y
           perform varying Cur-X from 0 by 50
               until Cur-X >= Hpdf-PageWidth

               if Cur-X > 0
                   move Cur-X to Hpdf-LineTo-X
                   call "C$PDF" using HPDF-Page-BeginText,
                           Hpdf-Page
                   call "C$PDF" using HPDF-Page-MoveTextPos,
                           Hpdf-Page,
                           Hpdf-LineTo-X, Hpdf-LineTo-Y
                   move Cur-X to Disp-XY
                   call "C$PDF" using HPDF-Page-ShowText,
                           Hpdf-Page,
                           Disp-XY
                   call "C$PDF" using HPDF-Page-EndText,
                           Hpdf-Page

                   call "C$PDF" using HPDF-Page-BeginText,
                           Hpdf-Page
                   subtract 10 from Hpdf-PageHeight giving Hpdf-MoveTo-Y
                   call "C$PDF" using HPDF-Page-MoveTextPos,
                           Hpdf-Page,
                           Hpdf-LineTo-X, Hpdf-MoveTo-Y
                   call "C$PDF" using HPDF-Page-ShowText,
                           Hpdf-Page,
                           Disp-XY
                   call "C$PDF" using HPDF-Page-EndText,
                           Hpdf-Page
               end-if
           end-perform
           .
