# Storing external documents in your Vision files


It's possible to store a PDF or file inside a Vision file and to be able to regenerate it when you need it.


Create a Vision indexed file defined like this:
```
    SELECT VISIONSTORAGE
        ASSIGN TO "FILEDEMO.dat"
        ORGANIZATION IS INDEXED
        ACCESS MODE IS DYNAMIC
        LOCK MODE IS AUTOMATIC
        FILE STATUS IS FILE-STATUS-2
        RECORD KEY IS key01 = VISION-FILE-NAME, VISION-POS
        WITH NO DUPLICATES.

    FD VISIONSTORAGE.
        01 VISION-REC.
            05 VISION-FILE-NAME PIC X(242).
            05 VISION-POS PIC 9(8).
            05 VISION-STRING PIC X(65535).
```

What we are doing is using the **–FILE-NAME** and** –POS** to be able to identify each block of a file (with the name and the position of the block on the file) and a string where we keep the file raw data.

To read the file we are going to store we use the following definition:
```
    SELECT FILETEMP
        ASSIGN TO file-name
        ORGANIZATION IS BINARY SEQUENTIAL
        ACCESS MODE IS SEQUENTIAL
        LOCK MODE IS AUTOMATIC
        FILE STATUS IS FILE-STATUS-1.

    01 FILETEMP-REC.
        05 FILETEMP-STRING PIC X(65535).
```

Sample code:
```
    ACCEPT FILE-NAME FROM ENVIRONMENT "FILE_TO_LOAD"

    OPEN INPUT FILETEMP
    OPEN OUTPUT VISIONSTORAGE

    INITIALIZE VISION-POS

    MOVE FILE-NAME TO VISION-FILE-NAME

    READ FILETEMP
    
    PERFORM UNTIL FILE-STATUS-1(1:1) NOT EQUAL "0"
        MOVE FILETEMP-STRING TO VISION-STRING
        ADD 1 TO VISION-POS
        WRITE VISION-REC
        INITIALIZE FILETEMP-STRING
        READ FILETEMP
    END-PERFORM

    CLOSE FILETEMP
    CLOSE VISIONSTORAGE
```

The issue is not reading and storing the file, but rewriting it correctly. Every bit is important. Any tiny mistake will make the file unusable. Sample code:
```
    SELECT FILETEMP
        ASSIGN TO FILE-NAME
        ORGANIZATION IS BINARY SEQUENTIAL
        ACCESS MODE IS SEQUENTIAL
        LOCK MODE IS AUTOMATIC
        FILE STATUS IS FILE-STATUS-1.

    SELECT FILETEMP2
        ASSIGN TO FILE-NAME
        ORGANIZATION IS BINARY SEQUENTIAL
        ACCESS MODE IS SEQUENTIAL
        LOCK MODE IS AUTOMATIC
        FILE STATUS IS FILE-STATUS-1.

    SELECT VISIONSTORAGE
        ASSIGN TO "FILEDEMO.DAT"
        ORGANIZATION IS INDEXED
        ACCESS MODE IS DYNAMIC
        LOCK MODE IS AUTOMATIC
        FILE STATUS IS FILE-STATUS-2
        RECORD KEY IS KEY01 = VISION-FILE-NAME VISION-POS
        WITH DUPLICATES.

    FD FILETEMP.
        01 FILETEMP-REC.
            05 FILETEMP-STRING PIC X(65535).

    FD FILETEMP2.
        01 FILETEMP-REC-2.
        05 FILETEMP-STRING-2 PIC X.

    FD VISIONSTORAGE.
        01 VISION-REC.
            05 VISION-FILE-NAME PIC X(242).
            05 VISION-POS PIC 9(8).
            05 VISION-STRING PIC X(65535).

    WORKING-STORAGE SECTION.
        77 COUNTER PIC 9(8) VALUE IS 0.
        77 FILE-STATUS-1 PIC X(2).
        77 FILE-STATUS-2 PIC X(2).
        77 FILE-NAME PIC X(242).
        77 ORIGINAL-FILE-NAME PIC X(242).
        77 FILETEMP-LEN PIC 9(9).
        77 TEMP-BUFFER PIC X(65535).
        77 TEMP-BUFFER-2 PIC X(65535).
        01 OLD-COUNTER PIC 9(9) VALUE IS 0.

    PROCEDURE DIVISION.
    MAIN SECTION.
        ACCEPT FILE-NAME FROM ENVIRONMENT "FILE_TO_UNLOAD"

        OPEN OUTPUT FILETEMP
        OPEN INPUT VISIONSTORAGE

        ACCEPT ORIGINAL-FILE-NAME FROM ENVIRONMENT
        “ORIGINAL_NAME"

        MOVE ORIGINAL-FILE-NAME TO VISION-FILE-NAME
        MOVE 1 TO VISION-POS

        START VISIONSTORAGE KEY IS EQUAL TO KEY01

        READ VISIONSTORAGE NEXT

        MOVE VISION-STRING TO TEMP-BUFFER

        PERFORM UNTIL VISION-FILE-NAME NOT EQUAL
        ORIGINAL-FILE-NAME
        OR FILE-STATUS-2(1:1) NOT EQUAL "0"

            MOVE TEMP-BUFFER TO FILETEMP-STRING

            READ VISIONSTORAGE NEXT

            IF VISION-FILE-NAME NOT EQUAL ORIGINAL-FILE-NAME
            OR FILE-STATUS-2(1:1) NOT EQUAL "0"
                THEN
                    CONTINUE
                ELSE
                    MOVE VISION-STRING TO TEMP-BUFFER
                    WRITE FILETEMP-REC
            END-IF
        END-PERFORM

        CLOSE FILETEMP
        CLOSE VISIONSTORAGE
```

The only issue is the last block. You will nearly never have to write the complete last block, but only a part of this, and to do it you will have to do it char by char.
```
    PERFORM TRAITEMENT-DER-REC

    GOBACK.

TRAITEMENT-DER-REC.
    PERFORM VARYING OLD-COUNTER FROM 65532 BY -1
    UNTIL TEMP-BUFFER(OLD-COUNTER:1) NOT = SPACES
        CONTINUE
    END-PERFORM

    OPEN EXTEND ATCHTEMP2

    PERFORM VARYING COUNTER
    FROM 1 BY 1 UNTIL COUNTER > OLD-COUNTER
        MOVE TEMP-BUFFER(COUNTER:1) TO ATCHTEMP-STRING-2
        WRITE ATCHTEMP-REC-2
    END-PERFORM
    
    CLOSE ATCHTEMP2.
```

Count trailing spaces and write only the data you have to. You may ask why we are not using a more ‘elegant’ way of counting trailing spaces... Well, it’s not through laziness. We have tried and I am sure there are some other ways, but be very careful about it.

We have found that certain files finish with bytes like x’000000’ and that certain COBOL verbs count as spaces, not as real data. The solution could work with certain extensions but not with others. We have tested it with .zip, .rar, .doc, .jpeg, .xls, .pdf. This list is by no means exhaustive, but that shows a wide enough choice of extensions as to be interesting.