identification division.
program-id.  CobolCallingJava.

* Copyright (C) 2005-2006,2008 Micro Focus. All rights reserved.
*
* This sample code is supplied for demonstration purposes only
* on an "as is" basis and is for use at your own risk.

data division.
working-storage section.
       COPY "java.def".

01 LOGMSG 		PIC X(256).
01 STATUS-VAL 		PIC S9(02) VALUE ZERO.
01 DB-CONNECT usage is handle.
01 DB-STATEMENT usage is handle.
01 FIELD-RET USAGE IS SIGNED-INT.
01 DB-DRIVERSTR pic x(256).
01 DB-CONNECTSTR pic x(256).
01 DB-QUERY pic x(256).
01 DB-RESULTSET usage is handle.
01 FIELD-BOOLRET pic x.
01 FIELD-INT usage is SIGNED-INT.
01 FIELD-STRINGRET pic x(256).
linkage section.
		

procedure division.
main-logic.

	MOVE "net.ucanaccess.jdbc.UcanloadDriver" to DB-DRIVERSTR.

	MOVE "jdbc:ucanaccess://D:/Temp/COBOL_JDBC/test.mdb;memory=false" to DB-CONNECTSTR.

	MOVE "select * from sample where sno=101" to DB-QUERY.
    
	CALL "C$JAVA" USING CJAVA-DBCONNECT, DB-DRIVERSTR, DB-CONNECTSTR GIVING DB-CONNECT
	
	CALL "C$JAVA" USING CJAVA-DBQUERY DB-QUERY, DB-CONNECT GIVING DB-RESULTSET.
	     
	CALL "C$JAVA" USING CJAVA-CALL, DB-RESULTSET, "java/sql/ResultSet", "next", "()Z", FIELD-BOOLRET GIVING STATUS-VAL.
     
	CALL "C$JAVA" USING CJAVA-CALL, DB-RESULTSET, "java/sql/ResultSet", "getRow", "()I", FIELD-RET GIVING STATUS-VAL.
     
	MOVE 2 to FIELD-INT.
    
	CALL "C$JAVA" USING CJAVA-CALL, DB-RESULTSET, "java/sql/ResultSet", "getString", "(I)X", FIELD-INT, FIELD-STRINGRET GIVING STATUS-VAL.

	display "Reading name of 101"
	display field-stringret
	accept omitted

	move "insert into sample values(104,'COBOL',60)" to DB-QUERY
	
	CALL "C$JAVA" USING CJAVA-NEW, "java/lang/Object", "()V" GIVING DB-STATEMENT.
	
	CALL "C$JAVA" USING CJAVA-CALL, DB-CONNECT, "java/sql/Connection", "createStatement", "(V)Ljava/sql/Statement;",
		DB-STATEMENT GIVING STATUS-VAL
	
	CALL "C$JAVA" USING CJAVA-CALL, DB-STATEMENT,  "java/sql/Statement", "executeUpdate", "(X)I",
		DB-QUERY, FIELD-INT giving STATUS-VAL
		
	display "update of table with 104"
	display field-int
	accept omitted

	CALL "C$JAVA" USING CJAVA-DELETE, DB-STATEMENT GIVING STATUS-VAL.

	CALL "C$JAVA" USING CJAVA-DELETE, DB-CONNECT GIVING STATUS-VAL.

	CALL "C$JAVA" USING CJAVA-DELETE, DB-RESULTSET GIVING STATUS-VAL.
	   
	stop run.
	.
	
