identification division.
program-id.  JavaCallingCobol.

* Copyright (C) 2005-2006,2008 Micro Focus. All rights reserved.
*
* This sample code is supplied for demonstration purposes only
* on an "as is" basis and is for use at your own risk.

data division.
working-storage section.
       COPY "../def/java.def".
01 STATUS-VAL PIC S9(02) VALUE ZERO.

linkage section.
77  string-in-out	pic x(32) value spaces.
77  int-in-out		USAGE IS SIGNED-INT.			
77  longUsageSL		USAGE IS SIGNED-LONG.			
77  double-in-out	USAGE IS DOUBLE.			
77  longPicT2		PIC S9(18) COMP-5.			
77  longPicS918Comp5	PIC S9(18) COMP-5.			
77  intArray		USAGE IS SIGNED-INT occurs 5.			
77  doubleArray		USAGE IS DOUBLE occurs 5.			

procedure division using string-in-out, int-in-out, longUsageSL,
	double-in-out, longPicT2, longPicS918Comp5,
	intArray, doubleArray.
main-logic.

       DISPLAY "COBOL LOG --> Entered JavaCallingCobol" UPON SYSERR.
       move "********************************************" to string-in-out.
       move 9999 to  int-in-out.
       move 4444444 to longUsageSL.
       move 7.77777 to double-in-out.
       move 111111111111111111 to longPicT2.
       move 222222222222222222 to longPicS918Comp5.
       move 1 to intArray(1).
       move 2 to intArray(2).
       move 3 to intArray(3).
       move 11111.11111 to doubleArray(1).
       move 22222.22222 to doubleArray(2).
       move 33333.33333 to doubleArray(3).
       DISPLAY "COBOL LOG --> Exiting JavaCallingCobol" UPON SYSERR.
       exit program.

