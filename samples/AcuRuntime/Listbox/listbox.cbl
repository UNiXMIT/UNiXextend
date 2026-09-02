identification division.
program-id.        list-demo.

* Copyright (C) 1996-2000 Micro Focus. All rights reserved.
*
* This sample code is supplied for demonstration purposes only
* on an "as is" basis and is for use at your own risk.

remarks.
     This program illustrates the different LISTBOX control types.

**************************************************************
data division.
working-storage section.

copy "acucobol.def".
copy "acugui.def".

77  add-item                  pic x(20).
77  fast-update-flag          pic 9 value zero.
    88  fast-update           value 1, false zero.

01  list-box-choices.
    03  pic x(8) value "Lemons".
    03  pic x(8) value "Lemurs".
    03  pic x(8) value "Lyceum".
    03  pic x(8) value "Lynx".
    03  pic x(8) value "Locket".
    03  pic x(8) value "Lodge".
    03  pic x(8) value "Llamas".
    03  pic x(8) value "Lyre".
    03  pic x(8) value "Lobsters".
    03  pic x(8) value "Lyric".
    03  pic x(8) value "Lei".
78  number-of-list-choices    value 11.

01  list-choice
    redefines list-box-choices
    occurs number-of-list-choices times
    indexed by list-idx       pic x(8).

77  list-data1                pic x(11).
77  list-data2                pic x(11).
77  list-data3                pic x(11).
77  list-data4                pic x(11).

01  text-e1                   pic x(13).
01  text-v1                   pic x(13).
01  text-e2                   pic x(13).
01  text-v2                   pic x(13).
01  text-e3                   pic x(13).
01  text-v3                   pic x(13).
01  text-e4                   pic x(13).
01  text-v4                   pic x(13).

01  list-visible-1            pic 9 value 1.
    88 visible-l1             value 1 false 0.
01  list-enabled-1            pic 9 value 1.
    88 enabled-l1             value 1 false 0.
01  list-visible-2            pic 9 value 1.
    88 visible-l2             value 1 false 0.
01  list-enabled-2            pic 9 value 1.
    88 enabled-l2             value 1 false 0.
01  list-visible-3            pic 9 value 1.
    88 visible-l3             value 1 false 0.
01  list-enabled-3            pic 9 value 1.
    88 enabled-l3             value 1 false 0.
01  list-visible-4            pic 9 value 1.
    88 visible-l4             value 1 false 0.
01  list-enabled-4            pic 9 value 1.
    88 enabled-l4             value 1 false 0.

77  key-status
    is special-names crt status     pic 9(4).
    88  exit-button-pushed    value 13.

01  screen-control
    is special-names screen control.
    03  accept-control        pic 9.
        88  continue-accept   value 1.
    03  control-value         pic 999 value zero.
**************************************************************
screen section.
01  screen-1.
    03  label       "     Default"
                    line  2 column 5.

    03  list-1 list-box using list-data1
                    line 3.5 column 5  lines 5 size 9
                    notify-selchange,
                    item-to-add = add-item
                    mass-update = fast-update-flag
                    visible     = list-visible-1
                    enabled     = list-enabled-1
                    exception disp-elem .

    03  label       "Item selected:"
                    line 8 column 5.

    03  entry-field from list-data1, read-only
                    enabled 0,
                    line + 1 column 5.

    03  push-button text-e1
                    line  11.5 column 5 size 10
                    exception-value = 101
                    exception button-pushed.

    03  push-button text-v1
                    line  13 column 5 size 10
                    exception-value = 102
                    exception button-pushed.

    03  label       " UNSORTED"
                    line  2 column 20.

    03  list-2 list-box using list-data2 unsorted
                    line 3.5 column 20  lines 5 size 9
                    notify-selchange,
                    item-to-add = add-item
                    mass-update = fast-update-flag
                    visible     = list-visible-2
                    enabled     = list-enabled-2
                    exception procedure is disp-elem .

    03  label       "Item selected:"
                    line 8 column 20.

    03  entry-field from list-data2, read-only,
                    enabled 0,
                    line + 1 column 20.

    03  push-button text-e2
                    line  11.5 column 20 size 10
                    exception-value = 201
                    exception button-pushed.

    03  push-button text-v2
                    line  13 column 20 size 10
                    exception-value = 202
                    exception button-pushed.

    03  label       "    NO-BOX"
                    line  2 column 35.

    03  list-3 list-box using list-data3 no-box
                    line 3.5 column 35  lines 5 size 9
                    item-to-add = add-item
                    mass-update = fast-update-flag
                    notify-selchange,
                    visible     = list-visible-3
                    enabled     = list-enabled-3
                    exception disp-elem .

    03  label       "Item selected:"
                    line 8 column 35.

    03  entry-field from list-data3, read-only,
                    enabled 0,
                    line + 1 column 35.

    03  push-button text-e3
                    line  11.5 column 35 size 10
                    exception-value = 301
                    exception button-pushed.

    03  push-button text-v3
                    line  13 column 35 size 10
                    exception-value = 302
                    exception button-pushed.

    03  label       "      3-D"
                    line  2 column 50.

    03  list-4 list-box using list-data4 3-D
                    line 3.5 column 50  lines 5 size 9
                    notify-selchange,
                    item-to-add = add-item
                    mass-update = fast-update-flag
                    visible     = list-visible-4
                    enabled     = list-enabled-4
                    exception disp-elem .

    03  label       "Item selected:"
                    line 8 column 50.

    03  entry-field from list-data4, read-only,
                    enabled 0
                    line + 1 column 50.

    03  push-button text-e4
                    line  11.5 column 50 size 10
                    exception-value = 401
                    exception button-pushed.

    03  push-button text-v4
                    line  13 column 50 size 10
                    exception-value = 402
                    exception button-pushed.

    03  push-button "E&xit Program"
                    ok-button
                    line 16 column 27 size 13.
*****************************************************************
procedure division.
main-logic.
* Setup a gray screen background
    display standard window,
        title "List Box Sample - listbox.cbl",
        lines 18, size 65,
        background-low.

    move "Disabled" to text-e1, text-e2, text-e3, text-e4.
    move "Invisible  " to text-v1, text-v2, text-v3, text-v4.
    display screen-1.

* We load-up all four list boxes in parallel here.  First set the
* MASS-UPDATE mode so that it goes faster.   Then fill the boxes
* and finally clear MASS-UPDATE mode to display the box contents.
    set fast-update to true.
    perform varying list-idx from 1 by 1
                           until list-idx > number-of-list-choices
       move list-choice(list-idx) to add-item
       display screen-1
    end-perform.
    move spaces to add-item.
    set fast-update to false.
    display screen-1.

    perform with test after until exit-button-pushed
           accept screen-1 on exception continue end-accept
    end-perform.
    stop run.

disp-elem.
    display screen-1.

button-pushed.
     evaluate true
        when key-status = 101
             if enabled-l1       set enabled-l1    to false
                                 move "Enabled"    to text-e1
                else             set enabled-l1    to true
                                 move "Disabled"   to text-e1
             end-if
        when key-status = 102
             if visible-l1       set visible-l1    to false
                                 move "Visible"    to text-v1
                else             set visible-l1    to true
                                 move "Invisible"  to text-v1
             end-if
        when key-status = 201
             if enabled-l2       set enabled-l2    to false
                                 move "Enabled"    to text-e2
                else             set enabled-l2    to true
                                 move "Disabled"   to text-e2
             end-if
        when key-status = 202
             if visible-l2       set visible-l2    to false
                                 move "Visible"    to text-v2
                else             set visible-l2    to true
                                 move "Invisible"  to text-v2
             end-if
        when key-status = 301
             if enabled-l3       set enabled-l3    to false
                                 move "Enabled"    to text-e3
                else             set enabled-l3    to true
                                 move "Disabled"   to text-e3
             end-if
        when key-status = 302
             if visible-l3       set visible-l3    to false
                                 move "Visible"    to text-v3
                else             set visible-l3    to true
                                 move "Invisible"  to text-v3
             end-if
        when key-status = 401
             if enabled-l4       set enabled-l4    to false
                                 move "Enabled"    to text-e4
                else             set enabled-l4    to true
                                 move "Disabled"   to text-e4
             end-if
        when key-status = 402
             if visible-l4       set visible-l4    to false
                                 move "Visible"    to text-v4
                else             set visible-l4    to true
                                 move "Invisible"  to text-v4
             end-if
     end-evaluate.
     display screen-1.
     set continue-accept to true.
