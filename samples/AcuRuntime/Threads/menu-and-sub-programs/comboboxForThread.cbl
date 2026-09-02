identification division.
program-id.        Combo-boxes.

* Copyright (C) 1996-2000 Micro Focus or one of its affiliates.
*
* The only warranties for products and services of Micro Focus
* and its affiliates and licensors ("Micro Focus") are set
* forth in the express warranty statements accompanying such
* products and services. Nothing herein should be construed as
* constituting an additional warranty. Micro Focus shall not
* be liable for technical or editorial errors or omissions
* contained herein. The information contained herein is
* subject to change without notice.
*
* Contains Confidential Information. Except as specifically
* indicated otherwise, a valid license is required for possession,
* use or copying. Consistent with FAR 12.211 and 12.212,
* Commercial Computer Software, Computer Software Documentation,
* and Technical Data for Commercial Items are licensed to the U.S.
* Government under vendor's standard commercial license.

remarks.
    This program illustrates the variety of COMBO BOX control type.
    06-JUL-2021 - Updates to be called in threads                          | CCCCCC

**************************************************************
data division.
working-storage section.

copy "def/acucobol.def".
copy "def/acugui.def".

*77  MAIN-WINDOW               HANDLE OF WINDOW.                           | CCCCCC
01  COMBOBOX-WINDOW           HANDLE OF WINDOW EXTERNAL.                   | CCCCCC
77  add-item                  pic x(20).
77  fast-update-flag          pic 9 value zero.
    88  fast-update           value 1, false zero.

01  combo-box-choices.
    03  pic x(9) value "Curlicue".
    03  pic x(9) value "Caballero".
    03  pic x(9) value "Cyan".
    03  pic x(9) value "Camel".
    03  pic x(9) value "Caber".
    03  pic x(9) value "Cuprit".
    03  pic x(9) value "Cabochon".
    03  pic x(9) value "Cygnet".
    03  pic x(9) value "Caboose".
    03  pic x(9) value "Curator".
    03  pic x(9) value "Cabriole".
    03  pic x(9) value "Cutwork".
78  number-of-combo-choices   value 12.

01  combo-choice
    redefines combo-box-choices
    occurs number-of-combo-choices times
    indexed by combo-idx      pic x(9).

77  combo-data1               pic x(11).
77  combo-data2               pic x(11).
77  combo-data3               pic x(11).
77  combo-data4               pic x(11).
77  combo-data5               pic x(11).
77  combo-data6               pic x(11).

01  text-e1                   pic x(11) value "Disabled".
01  text-v1                   pic x(11) value "Invisible".
01  text-e2                   pic x(11) value "Disabled".
01  text-v2                   pic x(11) value "Invisible".
01  text-e3                   pic x(11) value "Disabled".
01  text-v3                   pic x(11) value "Invisible".
01  text-e4                   pic x(11) value "Disabled".
01  text-v4                   pic x(11) value "Invisible".
01  text-e5                   pic x(11) value "Disabled".
01  text-v5                   pic x(11) value "Invisible".
01  text-e6                   pic x(11) value "Disabled".
01  text-v6                   pic x(11) value "Invisible".

01  combo-visible-1           pic 9 value 1.
    88 visible-l1             value 1 false 0.
01  combo-enabled-1           pic 9 value 1.
    88 enabled-l1             value 1 false 0.
01  combo-visible-2           pic 9 value 1.
    88 visible-l2             value 1 false 0.
01  combo-enabled-2           pic 9 value 1.
    88 enabled-l2             value 1 false 0.
01  combo-visible-3           pic 9 value 1.
    88 visible-l3             value 1 false 0.
01  combo-enabled-3           pic 9 value 1.
    88 enabled-l3             value 1 false 0.
01  combo-visible-4           pic 9 value 1.
    88 visible-l4             value 1 false 0.
01  combo-enabled-4           pic 9 value 1.
    88 enabled-l4             value 1 false 0.
01  combo-visible-5           pic 9 value 1.
    88 visible-l5             value 1 false 0.
01  combo-enabled-5           pic 9 value 1.
    88 enabled-l5             value 1 false 0.
01  combo-visible-6           pic 9 value 1.
    88 visible-l6             value 1 false 0.
01  combo-enabled-6           pic 9 value 1.
    88 enabled-l6             value 1 false 0.

77  key-status
    is special-names crt status     pic 9(4).
    88  exit-button-pushed    value 13.

01  screen-control
    is special-names screen control.
    03  accept-control        pic 9 value zero.
        88  continue-accept   value 1.
    03  control-value         pic 999.

**************************************************************
screen section.
01  screen-1.
    03  label       "    Default"
                    line  2 column 5 .

    03  combo-box using combo-data1
                    line 3.5 column 5   lines 5 size 9
                    item-to-add = add-item
                    notify-selchange,
                    mass-update = fast-update-flag
                    visible     = combo-visible-1
                    enabled     = combo-enabled-1
                    exception procedure disp-elem.

    03  label       "Item selected:"
                    line  6 col 5.

    03  entry-field from combo-data1
                    enabled 0,
                    line + 1 column 5.

    03  push-button text-e1
                    line  8.5 column 5 size 11
                    exception-value = 101
                    exception procedure button-pushed.

    03  push-button text-v1
                    line  10 column 5 size 11
                    exception-value = 102
                    exception procedure button-pushed.

    03  label       "  DROP-DOWN"
                    line  15 column 5 .

    03  combo-box using combo-data2 drop-down
                    line 16.5 column 5   lines 5 size 9
                    item-to-add = add-item
                    notify-selchange,
                    mass-update = fast-update-flag
                    visible     = combo-visible-2
                    enabled     = combo-enabled-2
                    exception procedure disp-elem.

    03  label       "Item selected:"
                    line  18 column 5.

    03  entry-field from combo-data2
                    enabled 0,
                    line + 1 column 5.

    03  push-button text-e2
                    line  20.5 column 5 size 11
                    exception-value = 201
                    exception procedure button-pushed.

    03  push-button text-v2
                    line  22 column 5 size 11
                    exception-value = 202
                    exception procedure button-pushed.

    03  label       "   UNSORTED"
                    line  2 column 25.

    03  combo-box using combo-data3 unsorted
                    line 3.5 column 25  lines 5 size 9
                    item-to-add = add-item
                    notify-selchange,
                    mass-update = fast-update-flag
                    visible     = combo-visible-3
                    enabled     = combo-enabled-3
                    exception procedure disp-elem.

    03  label       "Item selected:"
                    line  6 column 25.

    03  entry-field from combo-data3
                    enabled 0,
                    line + 1 column 25.

    03  push-button text-e3
                    line  8.5 column 25 size 11
                    exception-value = 301
                    exception procedure button-pushed.

    03  push-button text-v3
                    line  10 column 25 size 11
                    exception-value = 302
                    exception procedure button-pushed.


    03  label       "  DROP-LIST"
                    line  15 column 25.

    03  combo-box using combo-data4 unsorted
                    line 16.5 column 25  lines 5 size 9
                    item-to-add = add-item, drop-list
                    notify-selchange,
                    mass-update = fast-update-flag
                    visible     = combo-visible-4
                    enabled     = combo-enabled-4
                    exception procedure disp-elem.

    03  label       "Item selected:"
                    line  18 column 25.

    03  entry-field from combo-data4
                    enabled 0,
                    line + 1 column 25.

    03  push-button text-e4
                    line  20.5 column 25 size 11
                    exception-value = 401
                    exception procedure button-pushed.

    03  push-button text-v4
                    line  22 column 25 size 11
                    exception-value = 402
                    exception procedure button-pushed.


    03  label       "  STATIC-LIST"
                    line  2 column 45.

    03  combo-box using combo-data5 static-list
                    line 3.5 column 45  lines 4 size 12
                    item-to-add = add-item
                    notify-selchange,
                    mass-update = fast-update-flag
                    visible     = combo-visible-5
                    enabled     = combo-enabled-5
                    exception procedure disp-elem.

    03  label       "Item selected:"
                    line 7.7 column 45.

    03  entry-field from combo-data5
                    enabled 0,
                    line + 1 column 45.

    03  push-button text-e5
                    line 10.2 column 45 size 11
                    exception-value = 501
                    exception procedure button-pushed.

    03  push-button text-v5
                    line  11.7 column 45 size 11
                    exception-value = 502
                    exception procedure button-pushed.

    03  label       "      3-D"
                    line  15 column 45.

    03  combo-box using combo-data6 3-D
                    line 16.5 column 45  lines 5 size 9
                    item-to-add = add-item
                    notify-selchange,
                    mass-update = fast-update-flag
                    visible     = combo-visible-6
                    enabled     = combo-enabled-6
                    exception procedure disp-elem.

    03  label       "Item selected:"
                    line  18 column 45.

    03  entry-field from combo-data6
                    enabled 0,
                    line + 1 column 45.

    03  push-button text-e6
                    line  20.5 column 45 size 11
                    exception-value = 601
                    exception procedure button-pushed.

    03  push-button text-v6
                    line  22 column 45 size 11
                    exception-value = 602
                    exception procedure button-pushed.

    03  push-button "E&XIT"
                    ok-button
                    line 24.5 column 22 size 20.
*****************************************************************
procedure division.
main-logic.
* Setup a gray screen background
    display INDEPENDENT GRAPHICAL WINDOW,                                  | CCCCCC
           title "Combo Box Sample - combobox.cbl"
           lines 26, size 60,
           background-low
           HANDLE IN COMBOBOX-WINDOW |MAIN-WINDOW                          | CCCCCC
           BIND TO THREAD MODELESS.                                        | CCCCCC

* We load-up all six combo boxes in parallel here.  First set the
* MASS-UPDATE mode so that it goes faster.   Then fill the boxes
* and finally clear MASS-UPDATE mode to display the box contents.
    set fast-update to true.
    display screen-1.
    perform varying combo-idx from 1 by 1
                           until combo-idx > number-of-combo-choices
       move combo-choice(combo-idx) to add-item
       display screen-1
    end-perform.
    move spaces to add-item.
    set fast-update to false.
    display screen-1.

    perform with test after until exit-button-pushed
           accept screen-1 on exception continue end-accept
    end-perform.
    DESTROY screen-1                                                       | CCCCCC
    CLOSE WINDOW COMBOBOX-WINDOW |MAIN-WINDOW                              | CCCCCC
    GOBACK.                                                                | CCCCCC

* disp-elem - redisplay the screen to show the newly chosen element.
* This procedure executes each time a new element is selected in any of
* the combo-boxes.
disp-elem.
    display screen-1.

* button-pushed - called whenever one of the Enable or Visible push
* buttons is pushed.
button-pushed.
     evaluate true
        when key-status = 101
             if enabled-l1       set enabled-l1    to false
                                 move "Enabled"    to text-e1
                else             set enabled-l1    to true
                                 move "Disabled" to text-e1
             end-if
        when key-status = 102
             if visible-l1       set visible-l1    to false
                                 move "Visible"     to text-v1
                else             set visible-l1    to true
                                 move "Invisible"   to text-v1
             end-if
        when key-status = 201
             if enabled-l2       set enabled-l2    to false
                                 move "Enabled"    to text-e2
                else             set enabled-l2    to true
                                 move "Disabled" to text-e2
             end-if
        when key-status = 202
             if visible-l2       set visible-l2    to false
                                 move "Visible"     to text-v2
                else             set visible-l2    to true
                                 move "Invisible"   to text-v2
             end-if
        when key-status = 301
             if enabled-l3       set enabled-l3    to false
                                 move "Enabled"    to text-e3
                else             set enabled-l3    to true
                                 move "Disabled" to text-e3
             end-if
        when key-status = 302
             if visible-l3       set visible-l3    to false
                                 move "Visible"     to text-v3
                else             set visible-l3    to true
                                 move "Invisible"   to text-v3
             end-if
        when key-status = 401
             if enabled-l4       set enabled-l4    to false
                                 move "Enabled"    to text-e4
                else             set enabled-l4    to true
                                 move "Disabled" to text-e4
             end-if
        when key-status = 402
             if visible-l4       set visible-l4    to false
                                 move "Visible"     to text-v4
                else             set visible-l4    to true
                                 move "Invisible"   to text-v4
             end-if
        when key-status = 501
             if enabled-l5       set enabled-l5    to false
                                 move "Enabled"    to text-e5
                else             set enabled-l5    to true
                                 move "Disabled" to text-e5
             end-if
        when key-status = 502
             if visible-l5       set visible-l5    to false
                                 move "Visible"     to text-v5
                else             set visible-l5    to true
                                 move "Invisible"   to text-v5
             end-if
        when key-status = 601
             if enabled-l6       set enabled-l6    to false
                                 move "Enabled"    to text-e6
                else             set enabled-l6    to true
                                 move "Disabled" to text-e6
             end-if
        when key-status = 602
             if visible-l6       set visible-l6    to false
                                 move "Visible"     to text-v6
                else             set visible-l6    to true
                                 move "Invisible"   to text-v6
             end-if
     end-evaluate.
     display screen-1.
     set continue-accept to true.
