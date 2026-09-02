       IDENTIFICATION DIVISION.
       PROGRAM-ID. MANAGE-VISION-FILE-TO-XML.
       AUTHOR. CC.
       REMARKS.       
       ENVIRONMENT DIVISION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.       
       DATA DIVISION.
       FILE SECTION.       
       WORKING-STORAGE SECTION.
       COPY "acucobol.def".
       
       01 HPARSER            USAGE HANDLE.
       01 HROOT              USAGE HANDLE.       
       01 HCHILD01           USAGE HANDLE.
       77 WS-FILE-NAME       PIC X(45) VALUE SPACES.
       
       LINKAGE SECTION.    
       
       77 LNK-XML-FILE-NAME              PIC X(40).   
       
       01  LNK-FILE-OUTPUT-REC.
           05 LNK-FILMKEY.
              07 LNK-FILM-CODE      PIC  9(9) VALUE ZEROES.
           05 LNK-FILM-TITLE        PIC  X(61).
           05 LNK-FILM-DATE.
              07 FILM-YYYY          PIC  X(4).
              07 FILM-MM            PIC  X(2).
              07 FILM-DD            PIC  X(2).
           05 LNK-FILM-GENRE        PIC  X(25).  
           05 LNK-FILM-DESCRIPTION  PIC  X(100).  
      
       PROCEDURE DIVISION USING LNK-XML-FILE-NAME
                                LNK-FILE-OUTPUT-REC.
       MAIN-LOGIC.
       
            PERFORM CREATE-FILE
            PERFORM SET-ENCODING    
            PERFORM ADD-ROOT  
            PERFORM ADD-CHILDS                  
            PERFORM SAVE-FILE
       
            GOBACK.

        CREATE-FILE.         
            CALL "C$XML" USING CXML-NEW-PARSER
                 MOVE RETURN-CODE TO HPARSER.  

        SAVE-FILE.   
            INITIALIZE WS-FILE-NAME   
            STRING LNK-XML-FILE-NAME DELIMITED BY SPACES 
                   ".xml"
                   INTO WS-FILE-NAME
            CALL "C$XML" USING CXML-WRITE-FILE
                               HPARSER
                               WS-FILE-NAME
            CALL "C$XML" USING CXML-RELEASE-PARSER
                               HPARSER.                               

        SET-ENCODING.
            CALL "C$XML" USING CXML-SET-ENCODING
                 HPARSER
                 "ISO-8859-1". 
      *           "UTF-8". 
      *           "US-ASCII".       

        ADD-ROOT.
            CALL "C$XML" USING CXML-ADD-CHILD
                 HPARSER
                 LNK-XML-FILE-NAME
                 GIVING HROOT.
                 
        ADD-CHILDS.
            CALL "C$XML" USING CXML-ADD-CHILD
                 HROOT
                 "FilmKey"
                 LNK-FILM-CODE
                 9
                 GIVING HCHILD01
                 
            CALL "C$XML" USING CXML-ADD-SIBLING
                 HCHILD01
                 "FilmTitle"
                 LNK-FILM-TITLE
                 61
                 GIVING HCHILD01
                 
            CALL "C$XML" USING CXML-ADD-SIBLING
                 HCHILD01
                 "FilmDate"
                 LNK-FILM-DATE
                 8
                 GIVING HCHILD01
                 
            CALL "C$XML" USING CXML-ADD-SIBLING
                 HCHILD01
                 "FilmGenre"
                 LNK-FILM-GENRE
                 25
                 GIVING HCHILD01   
                 
            CALL "C$XML" USING CXML-ADD-SIBLING
                 HCHILD01
                 "FilmDescription"
                 LNK-FILM-DESCRIPTION
                 100
                 GIVING HCHILD01.             
                         