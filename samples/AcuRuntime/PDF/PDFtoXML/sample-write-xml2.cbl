       identification division.
       program-id. sample-write-xml.
       author. supportline@microfocus.com. 
       remarks.     
       
       environment division.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.
       input-output section.
       file-control.
      *
           SELECT FILETXT ASSIGN TO RANDOM "proveXML/pdfFD.txt"
           ORGANIZATION IS BINARY SEQUENTIAL
           ACCESS MODE IS SEQUENTIAL
           FILE STATUS IS STATO.
      *
       data division.
       file section.
      *
       FD FILETXT LABEL RECORD STANDARD
          01 REC-TXT          PIC X(65526000).
       
       working-storage section.
       copy "acucobol.def".
       
      *
       01 STATO       PIC XX.
       01 W-PATH-COPY PIC X(40).
       01 ISTRUZIONE.
          05 DOSISTRU      PIC X(200) VALUE SPACES.
          05 FILLER        PIC X VALUE LOW-VALUES.
      *
       01 key-pressed pic 9(4) is special-names crt status.
       
       01 hParser     usage handle.
       01 hRoot       usage handle.       
       01 hChild01    usage handle.
       01 hSubChild01 usage handle.      
       01 hChild02    usage handle.
       01 hSubChild02 usage handle.
       01 hSchema     usage handle.
       01 hAllegati   usage handle.
       01 hAttachment usage handle.
       
       01 text-error   pic x(50).
       01 text-error-1 pic x(200).
       01 num-error    pic 9(3).
       
       01 ws-st        pic x(50).
       01 ws-lenght    pic 9(3) value 0.
       01 ws-text      pic x(100).
      *01 ws-attachment pic x(100).
       01 ws-attachment pic x(10000000).
       
       01 xml-string-doctype pic x(30).
      
       procedure division.
       main-logic.

            call "c$xml" using cxml-new-parser
            move return-code to hParser.    

********************************************************************************
      * choose the paragraph and include it in your compilation:
      *
      * ccbl32 -ga -si A -si B etc. sample-write-xml.cbl
      *
********************************************************************************  
            
      *      PERFORM ADD-STYLESHEET.                                       | B
             PERFORM SET-ENCODING.                                         | C
             PERFORM SET-STANDALONE.                                       | D
             PERFORM ADD-SCHEMA.                                           | A
      *      PERFORM ADD-DOCTYPE.                                          | E
             PERFORM ADD-ROOT.                                             | F
             PERFORM ADD-CHILD-01.                                         | G
             PERFORM ADD-CHILD-02.                                         | H
             PERFORM ADD-COMMENT.                                          | I
             PERFORM SET-RAW-DOCTYPE.                                      | L
             PERFORM ADD-PDF-ATTACHMENT.                                   | M
      
******************************************************************************** 
            PERFORM SAVE-FILE.
            goback.
            
            
        ADD-DOCTYPE.
            call "c$xml" using cxml-add-child
                 hSchema
                 '!DOCTYPE SdDataSlice SYSTEM "m2Data.dtd"'
                 giving hRoot
            if hRoot not > 0
              move "Creazione elemento ROOT" to text-error
              perform print-errors
            end-if
            .
            
            
        ADD-ROOT.
            call "c$xml" using cxml-add-child
                  hSchema
      *          hParser
                 "ROOT"
                 giving hRoot
            if hRoot not > 0
              move "Creazione elemento ROOT" to text-error
              perform print-errors
            end-if
            .

        ADD-CHILD-01.
            call "c$xml" using cxml-add-child
                 hRoot
                 "Child01"
                 giving hChild01
            if hChild01 not > 0
              move "Creazione elemento Child 01" to text-error
              perform print-errors
            end-if
            
            STRING "VALUE of Sub Child å" 
                   INTO ws-text
            MOVE LENGTH OF ws-text TO ws-lenght
            
            call "c$xml" using cxml-add-child
                           hChild01
                           "SubChild01"
                           ws-text
                           ws-lenght
                     giving hSubChild01
                     .
                     
        ADD-CHILD-02.  
            call "c$xml" using cxml-add-child
                 hRoot
                 "Child02"
                 giving hChild02
            if hChild02 not > 0
              move "Creazione elemento Child 02" to text-error
              perform print-errors
            end-if
            
            call "c$xml" using cxml-add-child
                           hChild02
                           "SubChild02"
                           "VALUE of Sub Child 02"
                           21
                     giving hSubChild02                 
            .                     
            

        SAVE-FILE.
            call "c$xml" using CXML-WRITE-FILE
                            hParser
                           "proveXML/testfile.xml"
            call "c$xml" using cxml-release-parser
                           hParser.

        print-errors.
            call "c$xml" using cxml-get-last-error 
                           text-error-1
                     giving num-error
            display message box
                text-error-1 x"0d0a" num-error
                title text-error
      *     goback
            . 

        ADD-SCHEMA.  

*******Add a top element (using the name of the file)
            call "C$XML" using CXML-ADD-CHILD 
                  hParser
                  "MySchema" 
            move return-code to hSchema. 

********Add some namespace information  
            call "C$XML" using CXML-ADD-ATTRIBUTE
                  hSchema
                  "xmlns:xsi" 
                  "http://www.w3.org/2001/XMLSchema-instance". 

        ADD-STYLESHEET.
        
********Sets the stylesheet and other processing instructions 
********for the XML file. 

            STRING "type=" x"22" "text/xsl" x"22" 
                   " href=" x"22" "MyStyleSheet.xsl" x"22" 
WARNIN             "?"                                                     | No more needed starting from runtime 10.0.0
                   INTO ws-st

            CALL "C$XML" USING CXML-SET-PROC-INSTR, 
                               hParser, 
                               50, 
                               "xml-stylesheet", 
                               ws-st      
                               .

        SET-ENCODING.
            call "C$XML" using CXML-SET-ENCODING
                 hParser
*******           "ISO-8859-1". 
                 "UTF-8". 
*******           "US-ASCII".

        SET-STANDALONE.
            call "C$XML" using CXML-SET-STANDALONE
                 hParser
                 "yes". 
*******           "no". 


        ADD-COMMENT.
            call "c$xml" using CXML-ADD-COMMENT
                     hParser
                     "This is a comment from SupportLine".
********     call "c$xml" using CXML-DELETE-COMMENT   
********             hParser.
            
        SET-RAW-DOCTYPE.
            INITIALIZE ws-st
            STRING "!DOCTYPE request SYSTEM " 
                   QUOTE
                   "http://www.metel.it/webedi/stocks/StocksRequest.dtd"
                   QUOTE
                   INTO ws-st.
                        
            call "C$XML" using CXML-SET-RAW-DOCTYPE
                 hParser
                 ws-st.         
                 
       ADD-PDF-ATTACHMENT.        
      *
      *    ACCEPT W-PATH-COPY FROM ENVIRONMENT "PATH-COPY".
           MOVE "\\slinux\public\prod58\" TO W-PATH-COPY.
           MOVE SPACES TO DOSISTRU.
           STRING W-PATH-COPY "proveXML\b64.exe@-e@" 
                  W-PATH-COPY "proveXML\pdfFD.pdf@"
                  W-PATH-COPY "proveXML\pdfFD.txt"
                    DELIMITED BY SPACES INTO DOSISTRU
           INSPECT DOSISTRU REPLACING ALL "@" BY SPACES.
           CALL "C$SYSTEM" USING ISTRUZIONE, 224.
           OPEN INPUT FILETXT.
           READ FILETXT.
           CLOSE FILETXT.
      *
      * encoding a PDF in a safe encoding such as Base64 
      
      * inserting it into an XML document as a CDATA section
            call "c$xml" using cxml-add-child
                 hRoot
                 "Allegati"
                 giving hAllegati
            if hAllegati not > 0
              move "Creazione elemento Allegati" to text-error
              perform print-errors
            end-if      
            
            call "c$xml" using cxml-add-child
                 hAllegati
                 "Attachment"
                 giving hAttachment
            if hAttachment not > 0
              move "Creazione elemento Attachment" to text-error
              perform print-errors
            end-if      
            
      *     MOVE "PDF item" TO ws-attachment
            MOVE REC-TXT TO ws-attachment
            CALL "C$XML" USING CXML-SET-DATA
                 hAttachment
                 ws-attachment
            .
