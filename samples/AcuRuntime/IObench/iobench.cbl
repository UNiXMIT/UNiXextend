       IDENTIFICATION DIVISION.
       PROGRAM-ID.  IOBENCH.

      * Copyright (c) 1989-2014 by Micro Focus
      * Users of ACUCOBOL-GT may freely use this file.

      * This program performs various file I/O tests for benchmarking
      * purposes.  It should be compiled under ACUCOBOL-GT with the
      * following command:
      *
      *    ccbl iobench.cbl
      *
      * to use MASS-UPDATE, or with the command:
      *
      *    ccbl -Si LOCK iobench.cbl
      *
      * to use records locks for each read record.
      *
      * This program is similar to the file benchmark in the REALIA
      * comprehensive benchmark program.   It provides a test of a
      * fairly representative series of I/O operations that roughly
      * simulate various "real world" scenarios.  Both sequential and
      * random access is tested.  The two indexed files created are
      * both fairly realistic.  One contains one 10-byte key that is
      * written in strictly increasing order (sequential access).  The
      * second contains a primary 10-byte key that is written in
      * increasing order and one 40-byte alternate key that is written
      * in random order (sequential and random access).  The first
      * file is similar to a historical file or a simple line transaction
      * file.  The second is similar to most master files and multi-key
      * transaction files.

      * Date written: 2/16/89 - T. Drake Coker

      * Modification history:
      *
      * 4/13/89 - Changed summary times to reflect version 1.3B ACUCOBOL.
      * 27-Nov-95 - Comparisons to ACUCOBOL-GT v1.3 and RM/COBOL v2.01
      *    removed as they are too old to be relavent.
      * 02-Apr-96 - Write results to a file for internal record keeping.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.

      * Note: if SWITCH-1 is set, then the test is not actually run
      * This is useful when debugging the program or if you want to
      * get to the summary screen without waiting for the tests to
      * finish.

      * Note: if SWITCH-2 is set, then the results of the test are
      * are written to a flat text file, iobench.db
      * If SWITCH-3 is also set, then the results are appended to
      * an existing file.  These are useful when running the test
      * from a UNIX porting script and for saving data.

      * Note: if SWITCH-4 is set, then this program never pauses
      * to wait for user input.  This is useful when porting to
      * UNIX machines, since we run this program multiple times
      * with different versions of vision.

       SPECIAL-NAMES.
           SWITCH-1, ON STATUS IS SKIP-TEST
           SWITCH-2, ON STATUS IS WRITE-RESULTS
           SWITCH-3, ON STATUS IS APPEND-RESULTS-FILE
           SWITCH-4, ON STATUS IS NO-WAIT.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT SEQ-1-FILE
           ASSIGN TO DISK "SEQ1.DAT"
           BINARY SEQUENTIAL
           STATUS IS SEQ-1-STATUS.

           SELECT SEQ-2-FILE
           ASSIGN TO DISK "SEQ2.DAT"
           BINARY SEQUENTIAL.

           SELECT IDX-1-FILE
           ASSIGN TO DISK "IDX1.DAT"
           ORGANIZATION IS INDEXED
           ACCESS IS DYNAMIC
           RECORD KEY IS IDX-1-KEY
           STATUS IS IDX-1-STATUS.

           SELECT IDX-2-FILE
           ASSIGN TO DISK "IDX2.DAT"
           ORGANIZATION IS INDEXED
           ACCESS IS DYNAMIC
           RECORD KEY IS IDX-2-KEY
           ALTERNATE RECORD KEY IS IDX-2-ALT-KEY
               WITH DUPLICATES
           STATUS IS IDX-2-STATUS.

           SELECT SORT-FILE
           ASSIGN TO SORT.

           SELECT RESULT-FILE
           ASSIGN TO DISK "iobench.db"
           LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD  SEQ-1-FILE.
       01  SEQ-1-RECORD.
           03  SEQ-1-KEY                       PIC 9(10).
           03  SEQ-1-ALT-KEY.
               05  SEQ-1-ALT-KEY-A             PIC X(30).
               05  SEQ-1-ALT-KEY-B             PIC 9(10).
           03  SEQ-1-BODY                      PIC X(50).

       FD  SEQ-2-FILE.
       01  SEQ-2-RECORD                        PIC X(100).

       FD  IDX-1-FILE.
       01  IDX-1-RECORD.
           03  IDX-1-KEY                       PIC X(10).
           03  IDX-1-ALT-KEY.
               05  IDX-1-ALT-KEY-A             PIC X(30).
               05  IDX-1-ALT-KEY-B             PIC X(10).
           03  IDX-1-BODY                      PIC X(50).

       FD  IDX-2-FILE.
       01  IDX-2-RECORD.
           03  IDX-2-KEY                       PIC X(10).
           03  IDX-2-ALT-KEY.
               05  IDX-2-ALT-KEY-A             PIC X(30).
               05  IDX-2-ALT-KEY-B             PIC X(10).
           03  IDX-2-BODY                      PIC X(50).

       SD  SORT-FILE.
       01  SORT-RECORD.
           03  SORT-KEY                        PIC X(10).
           03  SORT-ALT-KEY                    PIC X(40).
           03  FILLER                          PIC X(50).

       FD  RESULT-FILE.
       01  RESULT-RECORD.
           03  RESULT-DESC                     PIC X(21).
           03  RESULT-TIME                     PIC X(9).


       WORKING-STORAGE SECTION.

       77  DEFAULT-HOST-VALUE                  PIC X(5) VALUE SPACES.
       77  V-VERSION-VALUE                     PIC X(5).
       77  X                                   PIC 9 VALUE 1.
       77  SEQ-1-STATUS                        PIC X(2).
       77  IDX-1-STATUS                        PIC X(2).
       77  IDX-2-STATUS                        PIC X(2).

       77  LINE-NO                             PIC 9(2).

       77  SYNC-TIME-1                         PIC 9(8).
       77  SYNC-TIME-2                         PIC 9(8).
       77  ELAPSED-TIME                        PIC ZZZZZZ.99.
       77  TOTAL-TIME                          PIC 9(7)V99 VALUE ZERO.
       77  TIME-DIFF                           PIC 9(6)V99.
       77  BEGIN-SECS                          PIC 9(6)V99.
       77  END-SECS                            PIC 9(6)V99.
       77  BEGIN-TIME                          PIC 9(8).
       01  BEGIN-TIME-FIELDS REDEFINES BEGIN-TIME.
           03  BEGIN-HOURS                     PIC 9(2).
           03  BEGIN-MINUTES                   PIC 9(2).
           03  BEGIN-SECONDS                   PIC 9(2).
           03  BEGIN-HUNDRETHS                 PIC 9(2).
       77  END-TIME                            PIC 9(8).
       01  END-TIME-FIELDS REDEFINES END-TIME.
           03  END-HOURS                       PIC 9(2).
           03  END-MINUTES                     PIC 9(2).
           03  END-SECONDS                     PIC 9(2).
           03  END-HUNDRETHS                   PIC 9(2).

       01  TIMING-TABLE.
           03  TEST-TIME OCCURS 10 TIMES       PIC ZZZZZZ.99.

       77  KEY-VALUE                           PIC 9(10).
       01  ALT-KEY-VALUE.
           03  ALT-KEY-VALUE-A                 PIC 9(15) VALUE
                                               842765989876543.
           03  ALT-KEY-VALUE-B                 PIC 9(8) VALUE
                                               62305671.
           03  ALT-KEY-VALUE-C                 PIC 9(7) VALUE
                                               2639004.
       01  ALT-KEY-VALUE-1 REDEFINES ALT-KEY-VALUE.
           03  ALT-CHAR OCCURS 30 TIMES        PIC X.

      * This table comes from the REALIA benchmark.
      * It contains a file action code and a key to operate on.
      * The file action code is "I" for "insert", "U" for "update",
      * and "D" for "delete".  For inserts and updates, a
      * random alternate key is generated.  This table is used more
      * than once by modifying the third character of the key on
      * different passes through the table.

       01  UPDATE-TABLE-VALUES.
           03  PIC X(7) VALUE 'I000001'.
           03  PIC X(7) VALUE 'I000002'.
           03  PIC X(7) VALUE 'I000003'.
           03  PIC X(7) VALUE 'I000004'.
           03  PIC X(7) VALUE 'U000010'.
           03  PIC X(7) VALUE 'I000011'.
           03  PIC X(7) VALUE 'I000012'.
           03  PIC X(7) VALUE 'I000013'.
           03  PIC X(7) VALUE 'I000014'.
           03  PIC X(7) VALUE 'I000015'.
           03  PIC X(7) VALUE 'I000016'.
           03  PIC X(7) VALUE 'I000017'.
           03  PIC X(7) VALUE 'I000018'.
           03  PIC X(7) VALUE 'I000019'.
           03  PIC X(7) VALUE 'U000020'.
           03  PIC X(7) VALUE 'D000030'.
           03  PIC X(7) VALUE 'I000035'.
           03  PIC X(7) VALUE 'U000040'.
           03  PIC X(7) VALUE 'D000050'.
           03  PIC X(7) VALUE 'I000055'.
           03  PIC X(7) VALUE 'I000061'.
           03  PIC X(7) VALUE 'I000062'.
           03  PIC X(7) VALUE 'I000063'.
           03  PIC X(7) VALUE 'I000064'.
           03  PIC X(7) VALUE 'U000070'.
           03  PIC X(7) VALUE 'I000071'.
           03  PIC X(7) VALUE 'I000072'.
           03  PIC X(7) VALUE 'I000073'.
           03  PIC X(7) VALUE 'I000074'.
           03  PIC X(7) VALUE 'I000075'.
           03  PIC X(7) VALUE 'I000076'.
           03  PIC X(7) VALUE 'I000077'.
           03  PIC X(7) VALUE 'I000078'.
           03  PIC X(7) VALUE 'I000079'.
           03  PIC X(7) VALUE 'U000080'.
           03  PIC X(7) VALUE 'D000090'.
           03  PIC X(7) VALUE 'I000091'.
           03  PIC X(7) VALUE 'I000092'.
           03  PIC X(7) VALUE 'I000093'.
           03  PIC X(7) VALUE 'I000094'.
      *
           03  PIC X(7) VALUE 'I000301'.
           03  PIC X(7) VALUE 'I000302'.
           03  PIC X(7) VALUE 'I000303'.
           03  PIC X(7) VALUE 'I000304'.
           03  PIC X(7) VALUE 'U000310'.
           03  PIC X(7) VALUE 'I000311'.
           03  PIC X(7) VALUE 'I000312'.
           03  PIC X(7) VALUE 'I000313'.
           03  PIC X(7) VALUE 'U000320'.
           03  PIC X(7) VALUE 'I000324'.
           03  PIC X(7) VALUE 'I000325'.
           03  PIC X(7) VALUE 'I000326'.
           03  PIC X(7) VALUE 'I000327'.
           03  PIC X(7) VALUE 'I000328'.
           03  PIC X(7) VALUE 'I000329'.
           03  PIC X(7) VALUE 'D000330'.
           03  PIC X(7) VALUE 'D000340'.
           03  PIC X(7) VALUE 'U000350'.
           03  PIC X(7) VALUE 'I000351'.
           03  PIC X(7) VALUE 'I000352'.
           03  PIC X(7) VALUE 'I000361'.
           03  PIC X(7) VALUE 'I000362'.
           03  PIC X(7) VALUE 'I000363'.
           03  PIC X(7) VALUE 'I000364'.
           03  PIC X(7) VALUE 'U000370'.
           03  PIC X(7) VALUE 'I000371'.
           03  PIC X(7) VALUE 'I000372'.
           03  PIC X(7) VALUE 'I000373'.
           03  PIC X(7) VALUE 'U000380'.
           03  PIC X(7) VALUE 'I000384'.
           03  PIC X(7) VALUE 'I000385'.
           03  PIC X(7) VALUE 'I000386'.
           03  PIC X(7) VALUE 'I000387'.
           03  PIC X(7) VALUE 'I000388'.
           03  PIC X(7) VALUE 'I000389'.
           03  PIC X(7) VALUE 'D000390'.
           03  PIC X(7) VALUE 'I000391'.
           03  PIC X(7) VALUE 'I000392'.
           03  PIC X(7) VALUE 'I000393'.
           03  PIC X(7) VALUE 'I000394'.
      *
           03  PIC X(7) VALUE 'I000501'.
           03  PIC X(7) VALUE 'I000502'.
           03  PIC X(7) VALUE 'I000503'.
           03  PIC X(7) VALUE 'I000504'.
           03  PIC X(7) VALUE 'U000510'.
           03  PIC X(7) VALUE 'I000517'.
           03  PIC X(7) VALUE 'I000518'.
           03  PIC X(7) VALUE 'I000519'.
           03  PIC X(7) VALUE 'U000520'.
           03  PIC X(7) VALUE 'D000530'.
           03  PIC X(7) VALUE 'D000540'.
           03  PIC X(7) VALUE 'I000551'.
           03  PIC X(7) VALUE 'I000552'.
           03  PIC X(7) VALUE 'I000553'.
           03  PIC X(7) VALUE 'I000561'.
           03  PIC X(7) VALUE 'I000565'.
           03  PIC X(7) VALUE 'I000568'.
           03  PIC X(7) VALUE 'U000580'.
           03  PIC X(7) VALUE 'D000590'.
           03  PIC X(7) VALUE 'I000595'.
           03  PIC X(7) VALUE 'I000601'.
           03  PIC X(7) VALUE 'I000602'.
           03  PIC X(7) VALUE 'I000603'.
           03  PIC X(7) VALUE 'I000604'.
           03  PIC X(7) VALUE 'U000610'.
           03  PIC X(7) VALUE 'I000617'.
           03  PIC X(7) VALUE 'I000618'.
           03  PIC X(7) VALUE 'I000619'.
           03  PIC X(7) VALUE 'U000620'.
           03  PIC X(7) VALUE 'D000630'.
           03  PIC X(7) VALUE 'D000640'.
           03  PIC X(7) VALUE 'I000651'.
           03  PIC X(7) VALUE 'I000652'.
           03  PIC X(7) VALUE 'I000653'.
           03  PIC X(7) VALUE 'I000661'.
           03  PIC X(7) VALUE 'I000665'.
           03  PIC X(7) VALUE 'I000668'.
           03  PIC X(7) VALUE 'U000680'.
           03  PIC X(7) VALUE 'D000690'.
           03  PIC X(7) VALUE 'I000695'.
      *
           03  PIC X(7) VALUE 'I000701'.
           03  PIC X(7) VALUE 'I000702'.
           03  PIC X(7) VALUE 'I000703'.
           03  PIC X(7) VALUE 'I000704'.
           03  PIC X(7) VALUE 'U000720'.
           03  PIC X(7) VALUE 'U000730'.
           03  PIC X(7) VALUE 'I000731'.
           03  PIC X(7) VALUE 'I000732'.
           03  PIC X(7) VALUE 'I000733'.
           03  PIC X(7) VALUE 'D000740'.
           03  PIC X(7) VALUE 'I000742'.
           03  PIC X(7) VALUE 'I000744'.
           03  PIC X(7) VALUE 'I000745'.
           03  PIC X(7) VALUE 'I000746'.
           03  PIC X(7) VALUE 'I000748'.
           03  PIC X(7) VALUE 'I000751'.
           03  PIC X(7) VALUE 'D000760'.
           03  PIC X(7) VALUE 'U000780'.
           03  PIC X(7) VALUE 'D000790'.
           03  PIC X(7) VALUE 'I000795'.
           03  PIC X(7) VALUE 'I000801'.
           03  PIC X(7) VALUE 'I000802'.
           03  PIC X(7) VALUE 'I000803'.
           03  PIC X(7) VALUE 'I000804'.
           03  PIC X(7) VALUE 'U000820'.
           03  PIC X(7) VALUE 'U000830'.
           03  PIC X(7) VALUE 'I000831'.
           03  PIC X(7) VALUE 'I000832'.
           03  PIC X(7) VALUE 'I000833'.
           03  PIC X(7) VALUE 'D000840'.
           03  PIC X(7) VALUE 'I000842'.
           03  PIC X(7) VALUE 'I000844'.
           03  PIC X(7) VALUE 'I000845'.
           03  PIC X(7) VALUE 'I000846'.
           03  PIC X(7) VALUE 'I000848'.
           03  PIC X(7) VALUE 'I000851'.
           03  PIC X(7) VALUE 'D000860'.
           03  PIC X(7) VALUE 'U000880'.
           03  PIC X(7) VALUE 'D000890'.
           03  PIC X(7) VALUE 'I000895'.
      *
           03  PIC X(7) VALUE 'I000901'.
           03  PIC X(7) VALUE 'I000902'.
           03  PIC X(7) VALUE 'I000903'.
           03  PIC X(7) VALUE 'I000904'.
           03  PIC X(7) VALUE 'U000910'.
           03  PIC X(7) VALUE 'I000911'.
           03  PIC X(7) VALUE 'I000912'.
           03  PIC X(7) VALUE 'I000913'.
           03  PIC X(7) VALUE 'I000914'.
           03  PIC X(7) VALUE 'I000915'.
           03  PIC X(7) VALUE 'I000916'.
           03  PIC X(7) VALUE 'I000917'.
           03  PIC X(7) VALUE 'I000918'.
           03  PIC X(7) VALUE 'I000919'.
           03  PIC X(7) VALUE 'U000920'.
           03  PIC X(7) VALUE 'I000921'.
           03  PIC X(7) VALUE 'D000930'.
           03  PIC X(7) VALUE 'D000940'.
           03  PIC X(7) VALUE 'D000950'.
           03  PIC X(7) VALUE 'I000951'.
           03  PIC X(7) VALUE 'I000952'.
           03  PIC X(7) VALUE 'I000953'.
           03  PIC X(7) VALUE 'I000954'.
           03  PIC X(7) VALUE 'I000955'.
           03  PIC X(7) VALUE 'U000960'.
           03  PIC X(7) VALUE 'I000961'.
           03  PIC X(7) VALUE 'I000962'.
           03  PIC X(7) VALUE 'I000963'.
           03  PIC X(7) VALUE 'I000964'.
           03  PIC X(7) VALUE 'I000965'.
           03  PIC X(7) VALUE 'I000966'.
           03  PIC X(7) VALUE 'I000967'.
           03  PIC X(7) VALUE 'I000968'.
           03  PIC X(7) VALUE 'I000969'.
           03  PIC X(7) VALUE 'U000970'.
           03  PIC X(7) VALUE 'D000980'.
           03  PIC X(7) VALUE 'D000990'.
           03  PIC X(7) VALUE 'I000991'.
           03  PIC X(7) VALUE 'I000992'.
           03  PIC X(7) VALUE 'I000993'.

       01  UPDATE-TABLE REDEFINES UPDATE-TABLE-VALUES.
           03  UPDATE-ENTRY OCCURS 200 TIMES.
               05  UPDATE-CODE                 PIC X.
                   88  UPDATE-WRITE            VALUE "I".
                   88  UPDATE-REWRITE          VALUE "U".
                   88  UPDATE-DELETE           VALUE "D".
               05  UPDATE-KEY.
                   07  FILLER                  PIC 9(2).
                   07  UPDATE-CHANGE           PIC 9.
                   07  FILLER                  PIC 9(3).

       77  INDX                                PIC 9(4) COMP-1.
       77  UPDATE-CHAR                         PIC 9.
       01  UPDATE-FULL-KEY.
           03  FILLER                          PIC X(4) VALUE ZEROS.
           03  UPDATE-SHORT-KEY                PIC X(6).

       PROCEDURE DIVISION.
       DECLARATIVES.
       SEQ-1-ERR-HANDLING SECTION.
           USE AFTER STANDARD ERROR PROCEDURE ON SEQ-1-FILE.
       SEQ-1-ERR.
           DISPLAY "*** FILE ERROR #", LINE 23, ERASE LINE, HIGH,
               SEQ-1-STATUS, HIGH, " ON SEQ1.DAT ***", HIGH.
           DISPLAY "*** TEST ABORTED ***", HIGH.
           STOP RUN 1.

       IDX-1-ERR-HANDLING SECTION.
           USE AFTER STANDARD ERROR PROCEDURE ON IDX-1-FILE.
       IDX-1-ERR.
           DISPLAY "*** FILE ERROR #", LINE 23, ERASE LINE, HIGH,
               IDX-1-STATUS, HIGH, " ON IDX1.DAT ***", HIGH.
           DISPLAY "*** TEST ABORTED ***", HIGH.
           STOP RUN 1.

       IDX-2-ERR-HANDLING SECTION.
           USE AFTER STANDARD ERROR PROCEDURE ON IDX-2-FILE.
       IDX-2-ERR.
           DISPLAY "*** FILE ERROR #", LINE 23, ERASE LINE, HIGH,
               IDX-2-STATUS, HIGH, " ON IDX2.DAT ***", HIGH.
           DISPLAY "*** TEST ABORTED ***", HIGH.
           STOP RUN 1.

       END DECLARATIVES.


       LEVEL-1 SECTION.
       MAIN-LOGIC.
           PERFORM INTRODUCTION.
           PERFORM SEQ-WRITE-TEST.
           PERFORM SORT-TEST.
           PERFORM LOAD-IDX-1-TEST.
           PERFORM READ-IDX-1-TEST.
           PERFORM UPDATE-IDX-1-TEST.
           PERFORM LOAD-IDX-2-TEST.
           PERFORM UPDATE-IDX-2-TEST.
           PERFORM END-TEST.
           IF WRITE-RESULTS
                   PERFORM RESULT-DATA.

           STOP RUN.

       LEVEL-2 SECTION.
       SEQ-WRITE-TEST.
           DISPLAY "Write Sequential File (3,000 100-byte records):",
                   LINE 3, POSITION 1.
           OPEN OUTPUT SEQ-1-FILE WITH LOCK.
           IF SKIP-TEST
               MOVE 1 TO TIME-DIFF
           ELSE
               PERFORM START-TIMER
               PERFORM VARYING KEY-VALUE FROM 10 BY 10
                               UNTIL KEY-VALUE IS > 30000
                   MOVE KEY-VALUE TO SEQ-1-KEY, SEQ-1-ALT-KEY-B
                   MOVE
                    "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvw"
                                               TO SEQ-1-BODY
                   PERFORM GENERATE-ALT-KEY
                   MOVE ALT-KEY-VALUE TO SEQ-1-ALT-KEY-A
                   WRITE SEQ-1-RECORD
               END-PERFORM
               PERFORM STOP-TIMER
           END-IF.
           CLOSE SEQ-1-FILE.
           ADD TIME-DIFF TO TOTAL-TIME.
           MOVE TIME-DIFF TO ELAPSED-TIME, TEST-TIME(1).
           DISPLAY ELAPSED-TIME, LINE 3, POSITION 55, " seconds".

       SORT-TEST.
           DISPLAY "Sort Sequential File (40-byte key):",
                   LINE 5, POSITION 1.
           IF SKIP-TEST
               MOVE 2 TO TIME-DIFF
           ELSE
               PERFORM START-TIMER
               SORT SORT-FILE ON ASCENDING KEY SORT-ALT-KEY
                   USING SEQ-1-FILE GIVING SEQ-2-FILE
               PERFORM STOP-TIMER
           END-IF.
           ADD TIME-DIFF TO TOTAL-TIME.
           MOVE TIME-DIFF TO ELAPSED-TIME, TEST-TIME(2).
           DISPLAY ELAPSED-TIME, LINE 5, POSITION 55, " seconds".

       LOAD-IDX-1-TEST.
           DISPLAY "Load Indexed File 1 (10-byte key):",
                   LINE 7, POSITION 1.
           OPEN INPUT SEQ-1-FILE WITH LOCK.
      *    OPEN OUTPUT IDX-1-FILE WITH LOCK.                            LOCK
           OPEN OUTPUT IDX-1-FILE WITH MASS-UPDATE.                     !LOCK
           IF SKIP-TEST
               MOVE 3 TO TIME-DIFF
           ELSE
               PERFORM START-TIMER
               READ SEQ-1-FILE RECORD
               PERFORM UNTIL SEQ-1-STATUS IS NOT = "00"
                   WRITE IDX-1-RECORD FROM SEQ-1-RECORD
                   READ SEQ-1-FILE RECORD, AT END CONTINUE END-READ
               END-PERFORM
               PERFORM STOP-TIMER
           END-IF.
           CLOSE SEQ-1-FILE, IDX-1-FILE.
           ADD TIME-DIFF TO TOTAL-TIME.
           MOVE TIME-DIFF TO ELAPSED-TIME, TEST-TIME(3).
           DISPLAY ELAPSED-TIME, LINE 7, POSITION 55, " seconds".

       READ-IDX-1-TEST.
           DISPLAY "Read Indexed File 1 (read and skip 20 times):",
                   LINE 9, POSITION 1.
           OPEN INPUT IDX-1-FILE WITH LOCK.
           IF SKIP-TEST
               MOVE 4 TO TIME-DIFF
           ELSE
               PERFORM START-TIMER
               PERFORM READ-IDX-1-PASS 20 TIMES
               PERFORM STOP-TIMER
           END-IF.
           CLOSE IDX-1-FILE.
           ADD TIME-DIFF TO TOTAL-TIME.
           MOVE TIME-DIFF TO ELAPSED-TIME, TEST-TIME(4).
           DISPLAY ELAPSED-TIME, LINE 9, POSITION 55, " seconds".

       READ-IDX-1-PASS.
            PERFORM VARYING KEY-VALUE FROM 900 BY 1000
                            UNTIL KEY-VALUE IS > 30000
               MOVE KEY-VALUE TO IDX-1-KEY
               START IDX-1-FILE KEY NOT LESS THAN IDX-1-KEY
               PERFORM 10 TIMES
                   READ IDX-1-FILE NEXT RECORD
                        AT END CONTINUE END-READ
               END-PERFORM
           END-PERFORM.

       UPDATE-IDX-1-TEST.
           DISPLAY "Update Indexed File 1 (600 updates):",
                   LINE 11, POSITION 1.
      *    OPEN I-O IDX-1-FILE WITH LOCK.                               LOCK
           OPEN I-O IDX-1-FILE WITH MASS-UPDATE.                        !LOCK
           IF SKIP-TEST
               MOVE 5 TO TIME-DIFF
           ELSE
               PERFORM START-TIMER
               PERFORM UPDATE-IDX-1-SET VARYING UPDATE-CHAR FROM ZERO
                                        BY 1 UNTIL UPDATE-CHAR IS > 2
               PERFORM STOP-TIMER
           END-IF.
           CLOSE IDX-1-FILE.
           ADD TIME-DIFF TO TOTAL-TIME.
           MOVE TIME-DIFF TO ELAPSED-TIME, TEST-TIME(5).
           DISPLAY ELAPSED-TIME, LINE 11, POSITION 55, " seconds".

       UPDATE-IDX-1-SET.
           PERFORM VARYING INDX FROM 1 BY 1 UNTIL INDX IS > 200
               MOVE UPDATE-CHAR TO UPDATE-CHANGE( INDX )
               MOVE UPDATE-KEY( INDX ) TO UPDATE-SHORT-KEY
               MOVE UPDATE-FULL-KEY TO IDX-1-KEY,
                                       IDX-1-ALT-KEY-B
               MOVE ZEROS TO IDX-1-BODY
               PERFORM GENERATE-ALT-KEY
               MOVE ALT-KEY-VALUE TO IDX-1-ALT-KEY-A
               EVALUATE UPDATE-CODE( INDX )
                 WHEN "I"    WRITE IDX-1-RECORD
                 WHEN "U"    REWRITE IDX-1-RECORD
                 WHEN "D"    DELETE IDX-1-FILE RECORD
               END-EVALUATE
           END-PERFORM.

       LOAD-IDX-2-TEST.
           DISPLAY "Load Indexed File 2 (10-byte key and 40-byte key):",
                   LINE 13, POSITION 1.
           OPEN INPUT SEQ-1-FILE WITH LOCK.
      *    OPEN OUTPUT IDX-2-FILE WITH LOCK.                            LOCK
           OPEN OUTPUT IDX-2-FILE WITH MASS-UPDATE.                     !LOCK
           IF SKIP-TEST
               MOVE 6 TO TIME-DIFF
           ELSE
               PERFORM START-TIMER
               READ SEQ-1-FILE RECORD
               PERFORM UNTIL SEQ-1-STATUS IS NOT = "00"
                   WRITE IDX-2-RECORD FROM SEQ-1-RECORD
                   READ SEQ-1-FILE RECORD, AT END CONTINUE END-READ
               END-PERFORM
               PERFORM STOP-TIMER
           END-IF.
           CLOSE SEQ-1-FILE, IDX-2-FILE.
           ADD TIME-DIFF TO TOTAL-TIME.
           MOVE TIME-DIFF TO ELAPSED-TIME, TEST-TIME(6).
           DISPLAY ELAPSED-TIME, LINE 13, POSITION 55, " seconds".

       UPDATE-IDX-2-TEST.
           DISPLAY "Update Indexed File 2 (600 updates):",
                   LINE 15, POSITION 1.
      *    OPEN I-O IDX-2-FILE WITH LOCK.                               LOCK
           OPEN I-O IDX-2-FILE WITH MASS-UPDATE.                        !LOCK
           IF SKIP-TEST
               MOVE 7 TO TIME-DIFF
           ELSE
               PERFORM START-TIMER
               PERFORM UPDATE-IDX-2-SET VARYING UPDATE-CHAR FROM ZERO
                                        BY 1 UNTIL UPDATE-CHAR IS > 2
               PERFORM STOP-TIMER
           END-IF.
           CLOSE IDX-2-FILE.
           ADD TIME-DIFF TO TOTAL-TIME.
           MOVE TIME-DIFF TO ELAPSED-TIME, TEST-TIME(7).
           DISPLAY ELAPSED-TIME, LINE 15, POSITION 55, " seconds".

       UPDATE-IDX-2-SET.
           PERFORM VARYING INDX FROM 1 BY 1 UNTIL INDX IS > 200
               MOVE UPDATE-CHAR TO UPDATE-CHANGE( INDX )
               MOVE UPDATE-KEY( INDX ) TO UPDATE-SHORT-KEY
               MOVE UPDATE-FULL-KEY TO IDX-2-KEY,
                                       IDX-2-ALT-KEY-B
               MOVE ZEROS TO IDX-2-BODY
               PERFORM GENERATE-ALT-KEY
               MOVE ALT-KEY-VALUE TO IDX-2-ALT-KEY-A
               EVALUATE UPDATE-CODE( INDX )
                 WHEN "I"    WRITE IDX-2-RECORD
                 WHEN "U"    REWRITE IDX-2-RECORD
                 WHEN "D"    DELETE IDX-2-FILE RECORD
               END-EVALUATE
           END-PERFORM.

       END-TEST.
           DISPLAY "--------" LINE 16, POSITION 56.
           DISPLAY "Total Time:" LINE 17, POSITION 1.
           MOVE TOTAL-TIME TO ELAPSED-TIME.
           DISPLAY ELAPSED-TIME, LINE 17, POSITION 55.
           DISPLAY "Test complete, press <enter> to exit: ", LINE 20.
           IF NOT NO-WAIT
               ACCEPT SEQ-1-STATUS, POSITION 0, TAB.

       RESULT-DATA.
           IF APPEND-RESULTS-FILE
               OPEN EXTEND RESULT-FILE
               MOVE SPACES TO RESULT-RECORD
               ACCEPT LINE-NO FROM CONFIGURATION "V-VERSION"
               STRING "VISION VERSION " DELIMITED BY SIZE
                      V-VERSION-VALUE(5:) DELIMITED BY SIZE
                      INTO RESULT-RECORD
               WRITE RESULT-RECORD
           ELSE
               OPEN OUTPUT RESULT-FILE
           END-IF.
           MOVE SPACES TO RESULT-RECORD.
           MOVE "bench_write_seq=" TO RESULT-DESC.
           MOVE TEST-TIME(1) TO RESULT-TIME.
           WRITE RESULT-RECORD.
           MOVE "bench_sort_seq=" TO RESULT-DESC.
           MOVE TEST-TIME(2) TO RESULT-TIME.
           WRITE RESULT-RECORD.
           MOVE "bench_load_idx1=" TO RESULT-DESC.
           MOVE TEST-TIME(3) TO RESULT-TIME.
           WRITE RESULT-RECORD.
           MOVE "bench_read_idx1=" TO RESULT-DESC.
           MOVE TEST-TIME(4) TO RESULT-TIME.
           WRITE RESULT-RECORD.
           MOVE "bench_update_idx1=" TO RESULT-DESC.
           MOVE TEST-TIME(5) TO RESULT-TIME.
           WRITE RESULT-RECORD.
           MOVE "bench_load_idx2=" TO RESULT-DESC.
           MOVE TEST-TIME(6) TO RESULT-TIME.
           WRITE RESULT-RECORD.
           MOVE "bench_update_idx2=" TO RESULT-DESC.
           MOVE TEST-TIME(7) TO RESULT-TIME.
           WRITE RESULT-RECORD.
           MOVE "bench_total=" TO RESULT-DESC.
           MOVE ELAPSED-TIME TO RESULT-TIME.
           WRITE RESULT-RECORD.
           CLOSE RESULT-FILE.

       LEVEL-99 SECTION.
       INTRODUCTION.
           ACCEPT DEFAULT-HOST-VALUE FROM CONFIGURATION "DEFAULT_HOST".
           CALL "C$TOUPPER" USING DEFAULT-HOST-VALUE VALUE 5.
           IF DEFAULT-HOST-VALUE = "VISIO" OR SPACES
                DISPLAY "FILE I/O BENCHMARK ", ERASE SCREEN, LINE 1,
                        POSITION 20, REVERSE
                ACCEPT  V-VERSION-VALUE FROM CONFIGURATION "V_VERSION"
                INSPECT V-VERSION-VALUE TALLYING X FOR LEADING ZEROS
                DISPLAY "(USING VISION VERSION "
                        LINE 1, POSITION 39, REVERSE
                DISPLAY V-VERSION-VALUE(X:)
                        LINE 1, POSITION 61, REVERSE
                DISPLAY ")"
                        LINE 1, POSITION 62, REVERSE
           ELSE
                DISPLAY "FILE I/O BENCHMARK ", ERASE SCREEN, LINE 1,
                        POSITION 30, REVERSE
           END-IF.
           DISPLAY "This program performs various file I/O",
                   LINE 5, POSITION 20.
           DISPLAY "timing tests.  It constructs a Sequential",
                   LINE 6, POSITION 20.
           DISPLAY "file containing semi-random keys and",
                   LINE 7, POSITION 20.
           DISPLAY "then sorts this file.  It then uses it",
                   LINE 8, POSITION 20.
           DISPLAY "to create two Indexed files, one with",
                   LINE 9, POSITION 20.
           DISPLAY "one 10-byte key and a second with a",
                   LINE 10, POSITION 20.
           DISPLAY "10-byte key and a 40-byte key.  Finally",
                   LINE 11, POSITION 20.
           DISPLAY "performs various updates on these files.",
                   LINE 12, POSITION 20.
           DISPLAY "Times for each portion of the test are shown.",
                   LINE 13, POSITION 20.

           DISPLAY "Press <enter> to continue: ", LINE 15, POSITION 20.
           IF NOT NO-WAIT
               ACCEPT SEQ-1-STATUS, POSITION 0, NO BEEP, TAB.

           DISPLAY SPACE, LINE 2, ERASE TO END OF SCREEN.

       GENERATE-ALT-KEY.
           MULTIPLY ALT-KEY-VALUE-B BY ALT-KEY-VALUE-C
                                    GIVING ALT-KEY-VALUE-A.
           MOVE ALT-CHAR(1) TO ALT-CHAR(29).
           MOVE ALT-CHAR(2) TO ALT-CHAR(25).
           MOVE ALT-CHAR(3) TO ALT-CHAR(20).
           MOVE ALT-CHAR(4) TO ALT-CHAR(22).
           MOVE ALT-CHAR(5) TO ALT-CHAR(17).
           MOVE ALT-CHAR(6) TO ALT-CHAR(30).
           MOVE ALT-CHAR(7) TO ALT-CHAR(23).
           MOVE ALT-CHAR(8) TO ALT-CHAR(16).

       START-TIMER.
           ACCEPT SYNC-TIME-1 FROM TIME.
           PERFORM WITH TEST AFTER UNTIL SYNC-TIME-1 NOT = SYNC-TIME-2
               ACCEPT SYNC-TIME-2 FROM TIME
           END-PERFORM.
           ACCEPT BEGIN-TIME FROM TIME.

       STOP-TIMER.
           ACCEPT END-TIME FROM TIME.
           COMPUTE BEGIN-SECS = (BEGIN-HOURS * 3600) +
               (BEGIN-MINUTES * 60) + (BEGIN-SECONDS) +
               (BEGIN-HUNDRETHS / 100).
           COMPUTE END-SECS = (END-HOURS * 3600) +
               (END-MINUTES * 60) + (END-SECONDS) +
               (END-HUNDRETHS / 100).
           IF (END-SECS < BEGIN-SECS) THEN
               ADD 86400 TO END-SECS
           END-IF.
           COMPUTE TIME-DIFF = END-SECS - BEGIN-SECS.
