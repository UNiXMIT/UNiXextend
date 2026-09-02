       IDENTIFICATION              DIVISION.
       PROGRAM-ID. textdemo.
       AUTHOR. RZack.
       DATE-WRITTEN. Thursday, December 14, 2017 9:19:32 AM.
       REMARKS.
           This program is a translation of the Haru PDF example
           text_demo.c
       DATA                        DIVISION.
       WORKING-STORAGE             SECTION.
       01  sample-text1        pic X(26)
                               value "abcdefgABCDEFG123!#$%&+-@?".
       01  sample-text2        pic x(44)
                               value "The quick brown fox jumps over the
      -                        " lazy dog.".
       01  page-title          pic x(9) value "Text Demo".
       01  text-description.
           03  filler          pic x(10) value "Font size ".
           03  font-size-d     pic zz9.99.
       01  page-font           handle.
       01  temp-width          pic s9(9)v999 comp-5.
       01  temp-height         pic s9(9)v999 comp-5.
       01  temp-row            pic s9(9)v999 comp-5.
       01  temp-col            pic s9(9)v999 comp-5.
       01  font-size           pic s9(9)v999 comp-5.
       01  rgb-values.
           03  rgb-r           pic s9(9)v999 comp-5.
           03  rgb-g           pic s9(9)v999 comp-5.
           03  rgb-b           pic s9(9)v999 comp-5.
       01  text-len            pic 999.
       COPY "cpdf.def".

       PROCEDURE DIVISION.
       Acu-Main-Logic.
           call "C$PDF" using HPDF-New
               giving HPDF-Doc
           if HPDF-Doc = null
               display message "Unable to create PDF document"
               stop run
           end-if

           perform setup-page
           call "pdfgrid" using HPDF-Doc, HPDF-Page
           perform outline-and-title

      * The font sizes and colors use the same text object,
      * so we create one here, and then close it after demo-font-colors
           call "C$PDF" using HPDF-Page-BeginText, HPDF-Page
           compute temp-height = HPDF-PageHeight - 60
           call "C$PDF" using HPDF-Page-MoveTextPos,
               HPDF-Page, 60, temp-height
           perform demo-font-sizes
           perform demo-font-colors
           call "C$PDF" using HPDF-Page-EndText, HPDF-Page

      * Save the final file and exit
           call "C$PDF" using HPDF-SaveToFile, HPDF-Doc,
               "textdemo.pdf"
           call "C$PDF" using HPDF-Free, HPDF-Doc
           exit program
           stop run
           .

       setup-page.
           call "C$PDF" using HPDF-SetCompressionMode,
               HPDF-Doc, HPDF-COMP-ALL.

      * Get a font handle, and set a size
           call "C$PDF" using HPDF-GETFONT
                HPDF-DOC, "Helvetica"
                giving page-font

           call "C$PDF" using HPDF-AddPage, HPDF-Doc
               giving HPDF-Page
           if HPDF-Page = null
               call "C$PDF" using HPDF-Free, HPDF-Doc
               display message "Unable to create PDF page"
               stop run
           end-if

           call "C$PDF" using HPDF-SETVIEWERPREFERENCE
                HPDF-DOC,
                HPDF-PRINT-SCALING-NONE

      * Set the page size to letter and direction to portrait
           call "C$PDF" using HPDF-PAGE-SETSIZE
                HPDF-PAGE, HPDF-PAGE-SIZE-LETTER,
                HPDF-PAGE-PORTRAIT
           .

       outline-and-title.
      * Get the page height
           call "C$PDF" using HPDF-PAGE-GETHEIGHT
              HPDF-PAGE, giving HPDF-PAGEHEIGHT-R

      * Get the page width
           call "C$PDF" using HPDF-PAGE-GETWIDTH
              HPDF-PAGE, giving HPDF-PAGEWIDTH-R

           call "C$PDF" using HPDF-Page-SetLineWidth,
               HPDF-Page, 1

           subtract 100 from Hpdf-PageWidth giving Hpdf-Rectangle-Width
           subtract 110 from Hpdf-PageHeight giving
               Hpdf-Rectangle-Height
           Call "C$PDF" using HPDF-Page-Rectangle, HPDF-Page,
               50, 50,
               Hpdf-Rectangle-Width, Hpdf-Rectangle-Height
           call "C$PDF" using Hpdf-Page-Stroke, Hpdf-Page

      * Print the title
           call "C$PDF" using HPDF-Page-SetFontAndSize,
               HPDF-Page, page-font, 24

           call "C$PDF" using HPDF-Page-TextWidth, HPDF_Page,
               page-title giving HPDF-TextWidth-R

           compute temp-width = (hpdf-pagewidth - hpdf-textwidth)/ 2
           compute temp-height = hpdf-pageheight - 50
           call "C$PDF" using HPDF-Page-BeginText, HPDF-Page
           call "C$PDF" using HPDF-Page-TextOut, HPDF-Page,
               temp-width, temp-height, page-title
           call "C$PDF" using HPDF-Page-EndText, Hpdf-Page
           .

       demo-font-sizes.
           move 8 to font-size
           perform until font-size > 60
               call "C$PDF" using HPDF-Page-SetFontAndSize,
                   HPDF-Page, page-font, font-size
               compute temp-col = -5 - font-size
               subtract 150 from hpdf-pagewidth giving temp-width
               call "C$PDF" using HPDF-Page-MoveTextPos,
                   HPDF-Page, 0, temp-col
               call "C$PDF" using HPDF-Page-MeasureText,
                   HPDF-Page, sample-text1, temp-width,
                   HPDF-False giving text-len
               call "C$PDF" using HPDF-Page-ShowText,
                   HPDF-Page, sample-text1, text-len
      * Show what we just printed
               move -10 to temp-width
               call "C$PDF" using HPDF-Page-MoveTextPos,
                   HPDF-Page, 0, temp-width
               call "C$PDF" using HPDF-Page-SetFontAndSize,
                   HPDF-Page, page-font, 8
               move font-size to font-size-d
               call "C$PDF" using HPDF-Page-ShowText,
                   HPDF-Page, text-description

               multiply 1.5 by font-size
           end-perform
           .

       demo-font-colors.
           call "C$PDF" using HPDF-Page-SetFontAndSize,
               HPDF-Page, page-font, 8
           move -30 to temp-height
           call "C$PDF" using HPDF-Page-MoveTextPos,
               HPDF-Page, 0, temp-height
           call "C$PDF" using HPDF-Page-ShowText,
               HPDF-Page, "font color"
           
           call "C$PDF" using HPDF-Page-SetFontAndSize,
               HPDF-Page, page-font, 18
           move -20 to temp-height
           call "C$PDF" using HPDF-Page-MoveTextPos,
               HPDF-Page, 0, temp-height

           perform varying text-len from 1 by 1
                   until text-len > 26 | size of sample-text1
               compute rgb-r = text-len / 26
               compute rgb-g = 1 - text-len / 26
               move 0 to rgb-b
               call "C$PDF" using HPDF-Page-SetRGBFill,
                   HPDF-Page, rgb-r, rgb-g, rgb-b
               call "C$PDF" using HPDF-Page-ShowText,
                   HPDF-Page, sample-text1(text-len:1)
           end-perform

           move -25 to temp-height
           call "C$PDF" using HPDF-Page-MoveTextPos,
               HPDF-Page, 0, temp-height

           perform varying text-len from 1 by 1
                   until text-len > 26 | size of sample-text1
               compute rgb-r = text-len / 26
               move 0 to rgb-g
               compute rgb-b = 1 - text-len / 26
               call "C$PDF" using HPDF-Page-SetRGBFill,
                   HPDF-Page, rgb-r, rgb-g, rgb-b
               call "C$PDF" using HPDF-Page-ShowText,
                   HPDF-Page, sample-text1(text-len:1)
           end-perform

           move -25 to temp-height
           call "C$PDF" using HPDF-Page-MoveTextPos,
               HPDF-Page, 0, temp-height

           perform varying text-len from 1 by 1
                   until text-len > 26 | size of sample-text1
               move 0 to rgb-r
               compute rgb-b = text-len / 26
               compute rgb-g = 1 - text-len / 26
               call "C$PDF" using HPDF-Page-SetRGBFill,
                   HPDF-Page, rgb-r, rgb-g, rgb-b
               call "C$PDF" using HPDF-Page-ShowText,
                   HPDF-Page, sample-text1(text-len:1)
           end-perform.
