       identification division.
       program-id.  tour.
       date-written.  15-Apr-97

      * Copyright (c) 1996-2014 by Micro Focus. Users of ACUCOBOL-GT
      * may freely modify and redistribute this program.

       remarks.
           This program provides a brief tour through some of the
           features of ACUCOBOL-GT.
           It is provided as a sample program.

       data division.
       working-storage section.

       copy "acucobol.def".
       copy "acugui.def".
       copy resource "gtanima.bmp".

       77  large-font                   handle of font large-font.
       77  small-font                   handle of font small-font.
       77  gt-bitmap                    pic s9(9) comp-4.

       01  combo-box-choices.
           03  pic x(20) value "Beets, Todd".
           03  pic x(20) value "McCormley, Tim".
           03  pic x(20) value "Dent, Arthur".
           03  pic x(20) value "Aardvark, Arthur A.".
           03  pic x(20) value "Coker, Drake".
           03  pic x(20) value "Madison, Dawn".
           03  pic x(20) value "Mooney, Kate".
           03  pic x(20) value "Withey, Peter".
           03  pic x(20) value "Cavanagh, Bob".
           03  pic x(20) value "Wizard, Mr.".

       78  number-of-combo-choices      value 10.

       01  combo-choice
           redefines combo-box-choices
           occurs number-of-combo-choices times
           indexed by combo-idx         pic x(20).

       77  intro-text                   pic x(200) value
           "This program demonstrates the look and feel of some of the g
      -    "raphical controls supported by ACUCOBOL-GT.  Use this progra
      -    "m as an introduction on how to program graphical controls.".

       77  check-box-data               pic 9 value zero.
       77  radio-button-data            pic 9 value zero.
       77  entry-data-1                 PIC x(10).
       77  entry-table occurs 20 times  pic x(70).
       77  combo-data                   pic x(20).
       77  date-val-1                   pic 9(8) value zero.

       77  key-status
                is special-names crt status pic 9(4).
                88  exit-button-pushed  value 13.

       screen section.
       01  screen-1.
           03  label "ACUCOBOL-GT"
               line 2 column 21 size 25
               font large-font center.

           03  bitmap graphical bitmap-handle = gt-bitmap
               size 39 bitmap-start = 1 bitmap-end = 15
               bitmap-timer = 10
               line 2 column 60.

           03  frame rimmed font small-font
               line 4 column 4 size 32 lines 8.4.

           03  label title intro-text
               font small-font
               line 5 column 5 size 30 lines 7.

           03  label "&Entry field"
               line 14.7 column 5.

           03  entry-field using entry-data-1
               column 15 size 15 3-d.

           03  label "&Scrolling entry box"
               line 17 column 5.

           03  entry-field using multiple entry-table
               line 18.5 column 8 size 50 lines 5
               max-lines = 20 vscroll-bar 3-d
               no-autosel use-return.

           03  check-box "&Check box"
               using check-box-data
               line 5, column 38.

           03  frame lowered
               line 6.5 column 37
               lines 3 size 23.

           03  radio-button "Radio &1"
               using radio-button-data
               line 7.7 column 38
               group-value = 1.

           03  radio-button "Radio &2"
               using radio-button-data
               column 49
               group-value = 2.

           03  label "&Drop-down box"
               line 10.2 column 38.

           03  combo-1 combo-box using combo-data
               line 11.7 column 38 lines 5 size 15 3-d.

           03  date-entry value date-val-1
               line 14.7 column 38 size 16.

           03  push-button "E&xit Program"
               ok-button
               line 25 column 27 size 13.

       procedure division.
       Main-Logic.

      *    SET EXCEPTION 1 TO SELECT-ALL-SELECTION.  
      *    SET EXCEPTION 3 TO COPY-SELECTION.  
      *    SET EXCEPTION 22 TO PASTE-SELECTION.  
      *    SET EXCEPTION 24 TO CUT-SELECTION.  
      *    SET EXCEPTION 26 TO UNDO.  

      *    Load the bitmap (this just fails on a character system)
           call "w$bitmap" using wbitmap-load, "gtanima.bmp",
                   giving gt-bitmap

      *    Setup a gray screen background
           display standard graphical window,
               title "Controls sample - tour.cbl"
               lines 27, size 66, background-low.

      *    Display the screen and fill-up the combo-box.

           display screen-1.
           modify combo-1, item-to-add = table combo-choice

      *    Now accept the screen.  The reason for the PERFORM loop
      *    is to prevent the user from leaving "screen-1" by using the
      *    Tab key (which is a termination key by default).  We could
      *    reconfigure the keyboard instead, but the PERFORM loop is a
      *    more general solution as it insures that the user has pushed
      *    the exit button.  Note that, since the exit button is a default
      *    button, using the Return key will also exit the screen.

           perform, with test after, until exit-button-pushed
               accept screen-1
           end-perform.

           stop run.
