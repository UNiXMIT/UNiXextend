       program-id. pdflibraryio.

      * Copyright (C) 2017 Micro Focus. All rights reserved.
      *
      * This sample code is supplied for demonstration purposes only
      * on an "as is" basis and is for use at your own risk.

       remarks.
           This program demonstrates how to use the C$PDF library
           routine to create a PDF file on UNIX or Windows platforms.
           The output will be a file called PRINT.PDF with one line
           of text "Test Print".

       working-storage section.

       copy "cpdf.def".

       procedure division.
       main-logic.

      * Create a PDF document object
           call "C$PDF" using HPDF-NEW,
              giving HPDF-DOC
           if hpdf-doc = 0
               perform report-error
           end-if

      * Create a new page
           call "C$PDF" using HPDF-ADDPAGE,
                HPDF-DOC,
                giving HPDF-PAGE
           if hpdf-page = 0
               perform report-error
           end-if

           move 10.0 to HPDF-LEFT
           move 20.0 to HPDF-BOTTOM
           move 30 to HPDF-RIGHT
           move 40.1 to HPDF-TOP
           call "C$PDF" using HPDF-PAGE-CREATETEXTANNOT,
               HPDF-Page, HPDF-RECT,
               "This is a test", NULL

      * Set the viewer preference
           call "C$PDF" using HPDF-SETVIEWERPREFERENCE,
                HPDF-DOC, HPDF-PRINT-SCALING-NONE
           if return-code not = 0
               perform report-error
           end-if

      * Set the page size to letter and direction to portrait
           call "C$PDF" using HPDF-PAGE-SETSIZE,
                HPDF-PAGE,
                HPDF-PAGE-SIZE-LETTER,
                HPDF-PAGE-PORTRAIT
           if return-code not = 0
               perform report-error
           end-if

      * Get a font handle 
           move "Courier" to HPDF-FONTNAME 
           call "C$PDF" using HPDF-GETFONT,
                HPDF-DOC,
                HPDF-FONTNAME,
                giving HPDF-GETFONT-FONT
           if hpdf-getfont-font = 0
               perform report-error
           end-if

      * Set the font size
           call "C$PDF" using HPDF-PAGE-SETFONTANDSIZE,
                HPDF-PAGE,
                HPDF-GETFONT-FONT,
                11.0
           if return-code not = 0
               perform report-error
           end-if

      * Get the page height
           call "C$PDF" using HPDF-PAGE-GETHEIGHT,
                HPDF-PAGE,
                giving HPDF-PAGEHEIGHT-R

      * Get the page width
           call "C$PDF" using HPDF-PAGE-GETWIDTH,
                HPDF-PAGE,
                giving HPDF-PAGEWIDTH-R

      * Draw a rectangle around the entire page
           call "C$PDF" using HPDF-PAGE-SETLINEWIDTH,
                HPDF-PAGE, 1
           if return-code not = 0
               perform report-error
           end-if
      *    call "C$PDF" using HPDF-PAGE-SETDASH,
      *         HPDF-PAGE, 5, 1, 5, 2, 4, 3, 4
      *    if return-code not = 0
      *        perform report-error
      *    end-if

           move 10 to HPDF-RECTANGLE-X, HPDF-RECTANGLE-Y
           subtract 20 from HPDF-PAGEWIDTH giving HPDF-RECTANGLE-WIDTH
           subtract 20 from HPDF-PAGEHEIGHT giving HPDF-RECTANGLE-HEIGHT
           call "C$PDF" using HPDF-PAGE-RECTANGLE,
                HPDF-PAGE,
                HPDF-RECTANGLE-X,
                HPDF-RECTANGLE-Y,
                HPDF-RECTANGLE-WIDTH,
                HPDF-RECTANGLE-HEIGHT
           if return-code not = 0
               perform report-error
           end-if
           call "C$PDF" using HPDF-PAGE-STROKE,
                HPDF-PAGE
           if return-code not = 0
               perform report-error
           end-if

      * Begin a text object
           call "C$PDF" using HPDF-PAGE-BEGINTEXT,
                HPDF-PAGE
           if return-code not = 0
               perform report-error
           end-if

      * Move the text position to the top left corner
      * Note: The 0,0 coordinates are at the lower left corner
           move 10 to HPDF-X
           subtract 25 from HPDF-PAGEHEIGHT giving HPDF-Y
           call "C$PDF" using HPDF-PAGE-MOVETEXTPOS,
                HPDF-PAGE,
                HPDF-X,
                HPDF-Y
           if return-code not = 0
               perform report-error
           end-if

      * Move the text position down by the size of the font
      * before printing
           move 0.0 to HPDF-X
           move 11.0 to HPDF-Y
           if HPDF-Y is positive then
               compute HPDF-Y = (HPDF-Y * -1)
           end-if
           call "C$PDF" using HPDF-PAGE-MOVETEXTPOS,
                HPDF-PAGE,
                HPDF-X,
                HPDF-Y
           if return-code not = 0
               perform report-error
           end-if

      * Print some text at the current position
           move "Test Print" to HPDF-RECORD
           call "C$PDF" using HPDF-PAGE-SHOWTEXT,
                HPDF-PAGE,
                HPDF-RECORD
           if return-code not = 0
               perform report-error
           end-if

      * End the text object
           call "C$PDF" using HPDF-PAGE-ENDTEXT,
                HPDF-PAGE
           if return-code not = 0
               perform report-error
           end-if

      * Save the current document to a file
           move "PRINT.PDF" to HPDF-SAVEFILENAME
           call "C$PDF" using HPDF-SAVETOFILE,
                HPDF-DOC,
                HPDF-SAVEFILENAME
           if return-code not = 0
               perform report-error
           end-if

      * Free the document object and all its resources
           call "C$PDF" using HPDF-FREE,
                HPDF-DOC

           stop run.

       report-error.
           call "C$PDF" using HPDF-GETERROR, HPDF-DOC,
                   HPDF-LAST-ERROR-CODE
           stop "C$PDF error. Check return-code and hpdf-last-error-code
      -            "".
      *    stop run.
