       IDENTIFICATION DIVISION.
       PROGRAM-ID.  CALCULATOR.

       DATE-WRITTEN.  25-JUN-1989 - TDC.
                      03-FEB-1991 - Fuss with the colors a little bit.
                      29-NOV-1995 - Rework for graphical interface
                      04-APR-1996 - Updated look for Windows 95
CCCCCC                06-JUL-2021 - Updates to be called in threads

      * Copyright (C) 1989,1991,1995-1996,1998-2001,2010 Micro Focus or one
      * of its affiliates.
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

      * This program implements a simple 4-function "pop up" calculator.
      * It demonstrates several unique features of ACUCOBOL-GT including
      * graphical programming and the ability to reconfigure the keyboard.

      * As implemented, this calculator allows for 12 digits before the
      * decimal point and 6 digits after.  By default, it shows 2 digits
      * after the decimal point, but it can shifted to show all 6 digits.
      * This calculator is designed to be run stand-alone or called from
      * another program.  It "pops up" over the program's screen.  As
      * long as the calculator program is not cancelled, it will retain
      * its last value and display mode.

      * The caller may optionally pass a S9(12)V9(6) data item to the
      * calculator.  If it does so, the passed item is filled in with
      * the calculator's last value when it exits.

      * The calculator accepts the normal commands: '+', '-', '*', '/'
      * and '='.  The Return key may also be used as the '=' key.
      * Other operations are available from the menu.  Additionally,
      * the push buttons on the face of the calculator are operational.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

      * To use another character as the decimal point, change the
      * following VALUE or use the DECIMAL-POINT runtime
      * configuration option.

       77  DEC-POINT                           PIC X VALUE ".".

       77  DIV-CHAR                            PIC X VALUE "/".
       77  MULT-CHAR                           PIC X VALUE "x".

      * IDs for items on the menu

       78  MENU-EXIT                           VALUE 101.
       78  MENU-CHANGE-SIGN                    VALUE 201.
       78  MENU-CLEAR-ENTRY                    VALUE 202.
       78  MENU-CLEAR-ALL                      VALUE 203.
       78  MENU-2-DIGITS                       VALUE 301.
       78  MENU-6-DIGITS                       VALUE 302.

      * Push button exception values.  In addition to these, the
      * "0" through "9" buttons are given the values 900 through 909
      * Buttons which mimic menu items use the menu item's exception
      * value listed above.

       78  BUTTON-EQUALS                       VALUE 910.
       78  BUTTON-PLUS                         VALUE 911.
       78  BUTTON-MINUS                        VALUE 912.
       78  BUTTON-MULTIPLY                     VALUE 913.
       78  BUTTON-DIVIDE                       VALUE 914.
       78  BUTTON-DEC-POINT                    VALUE 920.

       01  ANSWER                              PIC S9(12)V9(6) VALUE 0.
           88  CALC-OVERFLOW                   VALUES
                                               +999999999999.999999,
                                               -999999999999.999999.

       77  ANSWER-2-DEC                        PIC S9(12)V99.
       77  UENTRY                              PIC S9(12)V9(6).
       77  ONE-CHAR                            PIC X.
       77  ONE-CHAR-NUMERIC
           REDEFINES ONE-CHAR                  PIC 9.
       77  ALPHA-ENTRY                         PIC X(30).
       77  ENTRY-LENGTH                        PIC 99.

       01  FILLER                              PIC 9 VALUE ZERO.
           88  SHOW-FULL-PRECISION             VALUE 1, FALSE ZERO.
       01  FILLER                              PIC 9.
           88  HAVE-ENTRY                      VALUE 1, FALSE ZERO.

       01  OPERATION                           PIC 9(3).
           88  NO-OPERATION                    VALUE ZERO.
           88  OP-ADD                          VALUE 1.
           88  OP-SUBTRACT                     VALUE 2.
           88  OP-MULTIPLY                     VALUE 3.
           88  OP-DIVIDE                       VALUE 4.
           88  OP-EQUALS                       VALUE 5.

       01  NEXT-OPERATION                      PIC 9(3).
           88  NEXT-NO-OP                      VALUE ZERO.
           88  NEXT-OP-ADD                     VALUE 1.
           88  NEXT-OP-SUBTRACT                VALUE 2.
           88  NEXT-OP-MULTIPLY                VALUE 3.
           88  NEXT-OP-DIVIDE                  VALUE 4.
           88  NEXT-OP-EQUALS                  VALUE 5.
           88  EXIT-SELECTED                   VALUE MENU-EXIT.

       01  KEY-ENTERED                         PIC 9(3).

       77  NUMBER-OF-PARAMETERS                PIC 9(4) COMP-1.

CCCCCC*77  MAIN-WINDOW                         HANDLE OF WINDOW.
CCCCCC 01  CALCULATOR-WINDOW                 HANDLE OF WINDOW EXTERNAL.
       77  CALLER-CURSOR-MODE                  PIC 9.
       77  CALLER-DECIMAL-POINT                PIC X.
       77  CALLER-QUIT-MODE                    PIC S9(5).

       01  NUM-COLOR                           PIC 9(6) VALUE 0.
       01  CLEAR-COLOR                         PIC 9(6) VALUE 0.
       01  FUNC-COLOR                          PIC 9(6) VALUE 0.
       01  MISC-COLOR                          PIC 9(6) VALUE 0.
       01  ENTRY-COLOR                         PIC 9(6) VALUE 0.

       COPY "def/acucobol.def".
       COPY "def/acugui.def".

       LINKAGE SECTION.

       77  RETURN-VALUE                        PIC S9(12)V9(6).


       SCREEN SECTION.

      * This describes the calculator's face.  Note that all of the
      * buttons are self-activating (SELF-ACT).  This causes them
      * to act like function keys, returning the EXCEPTION-VALUE as
      * the key value.  The CALC-SCREEN is only DISPLAYed, it is
      * never ACCEPTed.

       01  CALC-SCREEN.
           03  ANSWER-FIELD, ENTRY-FIELD
               LINE 2, COL 3, SIZE 25 CELLS,
               COLOR ENTRY-COLOR,
               RIGHT, 3-D, READ-ONLY.

           03  PUSH-BUTTON, "1", SELF-ACT,
               LINE 4, COL 3, LINES 1.5, SIZE 4, CSIZE 1,
               EXCEPTION-VALUE = 901, COLOR NUM-COLOR.
           03  PUSH-BUTTON, "2", SELF-ACT,
               COL + 1.5, CCOL + 2, LINES 1.5, SIZE 4, CSIZE 1,
               EXCEPTION-VALUE = 902, COLOR NUM-COLOR.
           03  PUSH-BUTTON, "3", SELF-ACT,
               COL + 1.5, CCOL + 2, LINES 1.5, SIZE 4, CSIZE 1,
               EXCEPTION-VALUE = 903, COLOR NUM-COLOR.
           03  PUSH-BUTTON, "+", SELF-ACT,
               COL + 1.5, CCOL + 4, LINES 1.5, SIZE 4, CSIZE 1,
               EXCEPTION-VALUE = BUTTON-PLUS, COLOR FUNC-COLOR.
           03  PUSH-BUTTON, "C&E", SELF-ACT,
               COL + 1.5, CCOL + 2, LINES 1.5, SIZE 4, CSIZE 2,
               EXCEPTION-VALUE = MENU-CLEAR-ENTRY, COLOR CLEAR-COLOR.

           03  PUSH-BUTTON, "4", SELF-ACT,
               LINE 6, COL 3, LINES 1.5, SIZE 4, CSIZE 1,
               EXCEPTION-VALUE = 904, COLOR NUM-COLOR.
           03  PUSH-BUTTON, "5", SELF-ACT,
               COL + 1.5, CCOL + 2, LINES 1.5, SIZE 4, CSIZE 1,
               EXCEPTION-VALUE = 905, COLOR NUM-COLOR.
           03  PUSH-BUTTON, "6", SELF-ACT,
               COL + 1.5, CCOL + 2, LINES 1.5, SIZE 4, CSIZE 1,
               EXCEPTION-VALUE = 906, COLOR NUM-COLOR.
           03  PUSH-BUTTON, "-", SELF-ACT,
               COL + 1.5, CCOL + 4, LINES 1.5, SIZE 4, CSIZE 1,
               EXCEPTION-VALUE = BUTTON-MINUS, COLOR FUNC-COLOR.
           03  PUSH-BUTTON, "&C", SELF-ACT,
               COL + 1.5, CCOL + 2, LINES 1.5, SIZE 4, CSIZE 2,
               EXCEPTION-VALUE = MENU-CLEAR-ALL, COLOR CLEAR-COLOR.

           03  PUSH-BUTTON, "7", SELF-ACT,
               LINE 8, COL 3, LINES 1.5, SIZE 4, CSIZE 1,
               EXCEPTION-VALUE = 907, COLOR NUM-COLOR.
           03  PUSH-BUTTON, "8", SELF-ACT,
               COL + 1.5, CCOL + 2, LINES 1.5, SIZE 4, CSIZE 1,
               EXCEPTION-VALUE = 908, COLOR NUM-COLOR.
           03  PUSH-BUTTON, "9", SELF-ACT,
               COL + 1.5, CCOL + 2, LINES 1.5, SIZE 4, CSIZE 1,
               EXCEPTION-VALUE = 909, COLOR NUM-COLOR.
           03  PUSH-BUTTON, TITLE MULT-CHAR, SELF-ACT,
               COL + 1.5, CCOL + 4, LINES 1.5, SIZE 4, CSIZE 1,
               EXCEPTION-VALUE = BUTTON-MULTIPLY, COLOR FUNC-COLOR.

           03  PUSH-BUTTON, "0", SELF-ACT,
               LINE 10, COL 3, LINES 1.5, SIZE 4, CSIZE 1,
               EXCEPTION-VALUE = 900, COLOR NUM-COLOR.
           03  PUSH-BUTTON, DEC-POINT, SELF-ACT,
               COL + 1.5, CCOL + 2, LINES 1.5, SIZE 4, CSIZE 1,
               EXCEPTION-VALUE = BUTTON-DEC-POINT, COLOR NUM-COLOR.
           03  GRAPHICAL.
               05  PUSH-BUTTON, "+/-", SELF-ACT,
                   COL + 1.5, CCOL + 2, LINES 1.5, SIZE 4, CSIZE 3,
                   EXCEPTION-VALUE = MENU-CHANGE-SIGN,
                   COLOR MISC-COLOR.
           03  CHARACTER.
               05  PUSH-BUTTON, "&sgn", SELF-ACT,
                   COL + 1.5, CCOL + 2, LINES 1.5, SIZE 4, CSIZE 3,
                   EXCEPTION-VALUE = MENU-CHANGE-SIGN,
                   COLOR MISC-COLOR.

           03  PUSH-BUTTON, TITLE DIV-CHAR, SELF-ACT,
               COL + 1.5, CCOL + 2, LINES 1.5, SIZE 4, CSIZE 1,
               EXCEPTION-VALUE = BUTTON-DIVIDE, COLOR FUNC-COLOR.
           03  PUSH-BUTTON, "=", SELF-ACT,
               COL + 1.5, CCOL + 2, LINES 1.5, SIZE 4, CSIZE 3,
               EXCEPTION-VALUE = BUTTON-EQUALS, COLOR MISC-COLOR.

           03  CHARACTER.
               05  LABEL, "Hit <F1> for Menu"
                   LINE 11.5, CLINE 12, COL 3.


       PROCEDURE DIVISION USING RETURN-VALUE.
       MAIN-LOGIC.

           PERFORM INITIALIZE-CALCULATOR.
           PERFORM CALC-OPERATION, WITH TEST AFTER, UNTIL EXIT-SELECTED.
           PERFORM EXIT-CALCULATOR.
           GOBACK.

       INITIALIZE-CALCULATOR.

           MOVE ZERO TO OPERATION.

      * See if the runtime has been configured for a particular
      * decimal point.  If so, then use it.  Otherwise, set
      * the runtime to use the same decimal point as DEC-POINT.

           ACCEPT CALLER-DECIMAL-POINT FROM ENVIRONMENT "DECIMAL-POINT".
           IF CALLER-DECIMAL-POINT = SPACE
               SET ENVIRONMENT "DECIMAL-POINT" TO DEC-POINT
           ELSE
               MOVE CALLER-DECIMAL-POINT TO DEC-POINT
           END-IF.

      * Set colors if we are on a text-based system.

           ACCEPT TERMINAL-ABILITIES from TERMINAL-INFO.
           IF NOT HAS-GRAPHICAL-INTERFACE
               IF HAS-COLOR
                   MOVE GREEN TO NUM-COLOR
                   MOVE RED TO CLEAR-COLOR
                   MOVE MAGENTA TO FUNC-COLOR
                   MOVE BROWN TO MISC-COLOR
                   MOVE COLOR-REVERSE TO ENTRY-COLOR
               ELSE IF HAS-REVERSE
                   MOVE COLOR-REVERSE TO NUM-COLOR
                   MOVE COLOR-REVERSE TO CLEAR-COLOR
                   MOVE COLOR-REVERSE TO FUNC-COLOR
                   MOVE COLOR-REVERSE TO MISC-COLOR
                   MOVE COLOR-REVERSE TO ENTRY-COLOR
               END-IF
           END-IF.

      * Push the current keyboard configuration so that we can
      * restore it later.

           CALL "C$KEYMAP" USING 1.

      * The Windows' system font actually contains multiply and
      * divide characters, so we use those instead of "x" and "/"
      * if we are running under Windows

           ACCEPT SYSTEM-INFORMATION FROM SYSTEM-INFO.
           IF OS-IS-WINDOWS
               MOVE x"D7" TO MULT-CHAR
               MOVE x"F7" TO DIV-CHAR
           ELSE
               SET ENVIRONMENT "KEYSTROKE" TO "EDIT=MENU k1"
           END-IF.
           SET ENVIRONMENT "KEYSTROKE" TO "EXCEPTION=203 67".
           SET ENVIRONMENT "KEYSTROKE" TO "EXCEPTION=203 99".
           SET ENVIRONMENT "KEYSTROKE" TO "EXCEPTION=202 69".
           SET ENVIRONMENT "KEYSTROKE" TO "EXCEPTION=202 101".
           SET ENVIRONMENT "KEYSTROKE" TO "EXCEPTION=201 83".
           SET ENVIRONMENT "KEYSTROKE" TO "EXCEPTION=201 115".


      * Create the window.  First try to create a STANDARD window.
      * If this succeeds, then the calculator is being run as the
      * main program.  If it fails, then it is being called as a
      * subprogram and we build a FLOATING window instead.

CCCCCC*     DISPLAY STANDARD WINDOW, SIZE 29, LINES 12,
CCCCCC     DISPLAY INDEPENDENT GRAPHICAL WINDOW, SIZE 29, LINES 12,
               TITLE "Calculator", BACKGROUND-LOW,
               HANDLE IN 
CCCCCC                   CALCULATOR-WINDOW |MAIN-WINDOW
CCCCCC         BIND TO THREAD MODELESS.

CCCCCC*     IF MAIN-WINDOW = NULL
CCCCCC*         DISPLAY FLOATING WINDOW, SIZE 29, LINES 12,
CCCCCC     IF CALCULATOR-WINDOW = NULL 
               DISPLAY INDEPENDENT GRAPHICAL WINDOW, SIZE 29, LINES 12,               
                   TITLE "Calculator", BACKGROUND-LOW, |BOXED,
                   HANDLE IN 
CCCCCC                       CALCULATOR-WINDOW |MAIN-WINDOW
CCCCCC             BIND TO THREAD MODELESS.

           PERFORM BUILD-CALC-MENU.
           CALL "W$MENU" USING WMENU-SHOW, MENU-HANDLE.
           DISPLAY CALC-SCREEN.

      * Setup our environment.  Since this could be called from another
      * program, we are careful to save the caller's environment and
      * restore it when we exit.

           ACCEPT CALLER-CURSOR-MODE FROM ENVIRONMENT "CURSOR-MODE"
           SET ENVIRONMENT "CURSOR-MODE" TO "2".

           ACCEPT CALLER-QUIT-MODE FROM ENVIRONMENT "QUIT-MODE".
           SET ENVIRONMENT "QUIT-MODE" TO MENU-EXIT.

      * We process each keystroke individually.  To make this a bit
      * easier, we redefine the left-arrow, backspace and return keys
      * to be data keys instead of editing keys.

           SET ENVIRONMENT "KEYSTROKE" TO "Data=13 13"
                           "KEYSTROKE" TO "Data=8  ZB"
                           "KEYSTROKE" TO "Data=8  kl".

       CALC-OPERATION.

      * This routine handles the guts of the calculator.  Note that the
      * logic of an infix calculator is a little confusing because we
      * don't know the value of the second operand when the operation
      * is entered.  We get around this by delaying the evaluation of
      * each operation by one cycle through the loop.

           IF SHOW-FULL-PRECISION
               MODIFY ANSWER-FIELD, VALUE = ANSWER
           ELSE
               IF CALC-OVERFLOW
                   MOVE ANSWER TO ANSWER-2-DEC
               ELSE
                   COMPUTE ANSWER-2-DEC ROUNDED = ANSWER
               END-IF
               MODIFY ANSWER-FIELD, VALUE = ANSWER-2-DEC
           END-IF.

           PERFORM ACCEPT-NEXT-ENTRY.

      * Handle any immediate (ie, non-binary) operations here

           EVALUATE NEXT-OPERATION
               WHEN MENU-CLEAR-ALL
                   MOVE ZERO TO ANSWER
                   SET NO-OPERATION TO TRUE
                   EXIT PARAGRAPH
               WHEN MENU-2-DIGITS
                   SET SHOW-FULL-PRECISION TO FALSE
                   CALL "W$MENU" USING WMENU-CHECK, MENU-HANDLE,
                                       MENU-2-DIGITS
                   CALL "W$MENU" USING WMENU-UNCHECK, MENU-HANDLE,
                                       MENU-6-DIGITS
               WHEN MENU-6-DIGITS
                   SET SHOW-FULL-PRECISION TO TRUE
                   CALL "W$MENU" USING WMENU-CHECK, MENU-HANDLE,
                                       MENU-6-DIGITS
                   CALL "W$MENU" USING WMENU-UNCHECK, MENU-HANDLE,
                                       MENU-2-DIGITS
               WHEN MENU-CHANGE-SIGN
                   COMPUTE UENTRY = - UENTRY
           END-EVALUATE.

      * Handle delayed (ie, binary) operations here

           EVALUATE TRUE
               WHEN OP-ADD           ADD UENTRY TO ANSWER
                                         ON SIZE ERROR
                                             SET CALC-OVERFLOW TO TRUE
                                         END-ADD
               WHEN OP-SUBTRACT      SUBTRACT UENTRY FROM ANSWER
                                         ON SIZE ERROR
                                             SET CALC-OVERFLOW TO TRUE
                                         END-SUBTRACT
               WHEN OP-MULTIPLY      MULTIPLY UENTRY BY ANSWER
                                         ON SIZE ERROR
                                             SET CALC-OVERFLOW TO TRUE
                                         END-MULTIPLY
               WHEN OP-DIVIDE        DIVIDE UENTRY INTO ANSWER
                                         ON SIZE ERROR
                                             SET CALC-OVERFLOW TO TRUE
                                         END-DIVIDE
               WHEN OTHER            MOVE UENTRY TO ANSWER
           END-EVALUATE.

           MOVE NEXT-OPERATION TO OPERATION.


       EXIT-CALCULATOR.

           CLOSE WINDOW 
CCCCCC                  CALCULATOR-WINDOW. |MAIN-WINDOW.

      * Restore the caller's environment.

           CALL "C$KEYMAP" USING 0.
           SET ENVIRONMENT "CURSOR-MODE" TO CALLER-CURSOR-MODE
                           "DECIMAL-POINT" TO CALLER-DECIMAL-POINT
                           "QUIT-MODE" TO CALLER-QUIT-MODE.

      * See if the caller passed an argument.  If it did, then return
      * the last answer to the caller.

           CALL "C$NARG" USING NUMBER-OF-PARAMETERS.
           IF NUMBER-OF-PARAMETERS IS >= 1
               MOVE ANSWER TO RETURN-VALUE.


      * ACCEPT-NEXT-ENTRY retrieves the next number entered by the user
      * along with the terminating operation.  If no number is entered,
      * then the current answer is treated as the number entered.
      * The function accepts one character at a time and does its own
      * editing.  While this is a pain, it allows us to avoid the
      * annoying selection highlight that Windows would display in
      * the "answer" entry field.  Also, this method makes it a bit
      * easier to integrate the keyboard and the calculator's push
      * buttons.

       ACCEPT-NEXT-ENTRY.
           SET NEXT-NO-OP TO TRUE.
           SET HAVE-ENTRY TO FALSE.
           MOVE SPACES TO ALPHA-ENTRY.
           MOVE ZERO TO ENTRY-LENGTH.

           PERFORM UNTIL NOT NEXT-NO-OP
               ACCEPT ONE-CHAR, LINE 1, AUTOTERMINATE, NO-ECHO
                   ON EXCEPTION KEY-ENTERED
                       CONTINUE
                   END-ACCEPT

      * Handle exception keys here

               IF ONE-CHAR = SPACE
                   EVALUATE KEY-ENTERED
                       WHEN MENU-EXIT
                       WHEN MENU-CHANGE-SIGN
                       WHEN MENU-CLEAR-ALL
                       WHEN MENU-2-DIGITS
                       WHEN MENU-6-DIGITS
                           MOVE KEY-ENTERED TO NEXT-OPERATION
                       WHEN 900 THRU 909
                           COMPUTE ONE-CHAR-NUMERIC = KEY-ENTERED - 900
                       WHEN BUTTON-EQUALS
                           MOVE "=" TO ONE-CHAR
                       WHEN BUTTON-PLUS
                           MOVE "+" TO ONE-CHAR
                       WHEN BUTTON-MINUS
                           MOVE "-" TO ONE-CHAR
                       WHEN BUTTON-MULTIPLY
                           MOVE "*" TO ONE-CHAR
                       WHEN BUTTON-DIVIDE
                           MOVE "/" TO ONE-CHAR
                       WHEN BUTTON-DEC-POINT
                           MOVE DEC-POINT TO ONE-CHAR
                       WHEN MENU-CLEAR-ENTRY
                           MOVE "0" TO ALPHA-ENTRY
                           MOVE ZERO TO ENTRY-LENGTH
                           SET HAVE-ENTRY TO TRUE
                           MODIFY ANSWER-FIELD, VALUE ALPHA-ENTRY
                   END-EVALUATE
               END-IF

      * Handle data keys here

               EVALUATE ONE-CHAR
                   WHEN '0' THRU '9'
                   WHEN DEC-POINT
                       IF ENTRY-LENGTH < 30
                           ADD 1 TO ENTRY-LENGTH
                           MOVE ONE-CHAR TO
                                ALPHA-ENTRY( ENTRY-LENGTH : 1 )
                       END-IF
                       SET HAVE-ENTRY TO TRUE

                   WHEN x"08"
                       IF ENTRY-LENGTH > 0
                           MOVE SPACE TO ALPHA-ENTRY( ENTRY-LENGTH : 1 )
                           SUBTRACT 1 FROM ENTRY-LENGTH
                       END-IF

                   WHEN x"0D"
                   WHEN "="
                       SET NEXT-OP-EQUALS TO TRUE

                   WHEN "+"
                       SET NEXT-OP-ADD TO TRUE

                   WHEN "-"
                       SET NEXT-OP-SUBTRACT TO TRUE

                   WHEN "*"
                       SET NEXT-OP-MULTIPLY TO TRUE

                   WHEN "/"
                       SET NEXT-OP-DIVIDE TO TRUE

                   WHEN OTHER
                       EXIT PERFORM CYCLE
               END-EVALUATE

      * Handle special cases with zero and the decimal-point at the
      * beginning of the string

               IF NEXT-NO-OP
                   IF ENTRY-LENGTH = 0
                       MOVE "0" TO ALPHA-ENTRY
                   END-IF
                   IF ALPHA-ENTRY = "0"
                       MOVE ZERO TO ENTRY-LENGTH
                   END-IF
                   IF ALPHA-ENTRY = DEC-POINT
                       STRING "0", DEC-POINT, DELIMITED BY SIZE
                              INTO ALPHA-ENTRY
                       MOVE 2 TO ENTRY-LENGTH
                   END-IF
               END-IF

      * Display current entry

               MODIFY ANSWER-FIELD, VALUE ALPHA-ENTRY

           END-PERFORM.

           IF HAVE-ENTRY
               MOVE ALPHA-ENTRY TO UENTRY WITH CONVERSION
           ELSE
               MOVE ANSWER TO UENTRY
           END-IF.

           COPY "calc3.cpy".
