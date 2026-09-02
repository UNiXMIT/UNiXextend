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
       01 XML-STRING       PIC X(100) VALUE "<?xml version=""1.0""?><gro
      -                   "up1><subgroup1>data</subgroup1></group1>".
       COPY "acucobol.def".

       PROCEDURE DIVISION.
       MAIN-LOGIC.
           DISPLAY "WRITE XML..."
           INITIALIZE PARSER-HANDLE ELEMENT-HANDLE CHILD-HANDLE   

      *CREATE A NEW XML FILE 
           CALL "C$XML" USING CXML-NEW-PARSER
           MOVE RETURN-CODE TO PARSER-HANDLE.

           CALL "C$XML" USING CXML-SET-ENCODING 
                        PARSER-HANDLE
                        "UTF-8"

      *ADD A TOP ELEMENT (USING THE NAME OF THE FILE)
           CALL "C$XML" USING CXML-ADD-CHILD 
                        PARSER-HANDLE
                        "custRec" 
           MOVE RETURN-CODE TO ELEMENT-HANDLE
           

      *ADD SOME NAMESPACE INFORMATION 
           CALL "C$XML" USING CXML-ADD-ATTRIBUTE
                        ELEMENT-HANDLE
                        "xmlns:xsi"
                        "http://www.w3.org/2001/XMLSchema-instance".
                     
      *ADD THE FIRST FIELD OF THE RECORD, WHICH WILL BE A CHILD OF 
      *THE LAST ELEMENT.
           CALL "C$XML" USING CXML-ADD-CHILD 
                        ELEMENT-HANDLE
                        "cus-key"
                        "555-55-5555"
           MOVE RETURN-CODE TO ELEMENT-HANDLE.

      *ADD THE REST OF THE RECORDS
           CALL "C$XML" USING CXML-ADD-SIBLING 
                        ELEMENT-HANDLE
                        "cus-name"
                        "Acucorp"
           MOVE RETURN-CODE TO ELEMENT-HANDLE.

           CALL "C$XML" USING CXML-ADD-SIBLING 
                        ELEMENT-HANDLE
                        "cus-addr"
                        "8515 Miralani Drive"
           MOVE RETURN-CODE TO ELEMENT-HANDLE.

           CALL "C$XML" USING CXML-ADD-SIBLING 
                        ELEMENT-HANDLE
                        "cus-city"
                        "California"
           MOVE RETURN-CODE TO ELEMENT-HANDLE.

           CALL "C$XML" USING CXML-ADD-SIBLING 
                        ELEMENT-HANDLE
                        "cus-state"
                        "CA"
           MOVE RETURN-CODE TO ELEMENT-HANDLE.

           CALL "C$XML" USING CXML-ADD-SIBLING 
                        ELEMENT-HANDLE
                        "cus-zip"
                        "92126"

      *WRITE THE FILE 
           CALL "C$XML" USING CXML-WRITE-FILE,
                        PARSER-HANDLE
                         "custRec.xml". 
           CALL "C$XML" USING CXML-RELEASE-PARSER,
                        PARSER-HANDLE.
           
           DISPLAY "'custRec.xml' created"

      *PARSE XML
           DISPLAY " "
           DISPLAY "PARSE FILE..."
           DISPLAY " "
           INITIALIZE PARSER-HANDLE ELEMENT-HANDLE CHILD-HANDLE  
               
           call "C$XML" using CXML-PARSE-FILE
                        "custRec.XML"
           MOVE RETURN-CODE TO PARSER-HANDLE  
                               
      *GET HANDLE OF STARTING CHILD     
           call "C$XML" using CXML-GET-CHILD-BY-NAME
                        PARSER-HANDLE
                        "cus-key"
           MOVE RETURN-CODE TO CHILD-HANDLE

           CALL "C$XML" USING CXML-GET-DATA
                              CHILD-HANDLE
                              ITEM-NAME
                              ITEM-VALUE 
                              ITEM-VALUE-LENGTH
                              
           DISPLAY "ITEM NAME: " ITEM-NAME
           DISPLAY "ITEM VALUE: " ITEM-VALUE
           DISPLAY " "

      *LOOP TO GET NEXT RECORD IN XML
           PERFORM UNTIL WS-END = 1

               INITIALIZE ITEM-NAME
                          ITEM-VALUE
                          ITEM-VALUE-LENGTH
                      
               CALL "C$XML" USING CXML-GET-NEXT-SIBLING
                              CHILD-HANDLE
               MOVE RETURN-CODE TO CHILD-HANDLE
               
               IF RETURN-CODE = 0
                   MOVE 1 TO WS-END
               ELSE
                   CALL "C$XML" USING CXML-GET-DATA
                              CHILD-HANDLE
                              ITEM-NAME
                              ITEM-VALUE 
                              ITEM-VALUE-LENGTH
                              
                   DISPLAY "ITEM NAME: " ITEM-NAME
                   DISPLAY "ITEM VALUE: " ITEM-VALUE
                   DISPLAY " "
               END-IF
           END-PERFORM

      *PARSE STRING     
           DISPLAY "PARSE STRING..."
           DISPLAY " "
           INITIALIZE PARSER-HANDLE ELEMENT-HANDLE CHILD-HANDLE 

           CALL "C$XML" USING CXML-PARSE-STRING XML-STRING. 
           MOVE RETURN-CODE TO PARSER-HANDLE

           CALL "C$XML" USING CXML-GET-SIBLING-BY-NAME
                        PARSER-HANDLE
                        "group1"
           MOVE RETURN-CODE TO CHILD-HANDLE

           CALL "C$XML" USING CXML-GET-CHILD-BY-NAME
                        PARSER-HANDLE
                        "subgroup1"
           MOVE RETURN-CODE TO CHILD-HANDLE

           CALL "C$XML" USING CXML-GET-DATA
                              CHILD-HANDLE
                              ITEM-NAME
                              ITEM-VALUE 
                              ITEM-VALUE-LENGTH
           
           DISPLAY "ITEM NAME: " ITEM-NAME
           DISPLAY "ITEM VALUE: " ITEM-VALUE
           DISPLAY " "

           GOBACK.
