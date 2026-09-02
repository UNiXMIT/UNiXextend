       IDENTIFICATION DIVISION.
       PROGRAM-ID.    CXML.
       WORKING-STORAGE SECTION.

       01 PARSER-HANDLE         USAGE IS HANDLE.
       01 ELEMENT-HANDLE        USAGE IS HANDLE.
       01 CHILD-HANDLE          USAGE HANDLE.
       01 ITEM-NAME             PIC X(50) VALUE SPACES.
       01 ITEM-VALUE            PIC X(50) VALUE SPACES.
       01 ITEM-VALUE-LENGTH     PIC 9(3) VALUE ZEROS.
       01 WS-END                PIC 9 VALUE ZERO.
       COPY "acucobol.def".

       PROCEDURE DIVISION.
           CALL "C$XML" USING CXML-OPEN-FILE 
                                   "http://13.40.27.21:3000/custRec.xml"
           DISPLAY RETURN-CODE
           ACCEPT OMITTED
           GOBACK.
