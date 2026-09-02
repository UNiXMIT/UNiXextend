       IDENTIFICATION DIVISION.
       PROGRAM-ID.	XMLPARSE.
       AUTHOR.		.
       REMARKS.
       	THIS PROGRAM DEMONSTRATES SIMPLE XML PARSING WITH THE XML PARSE
       	VERB.
       	COMPILE WITH -DW32 -CV
       
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  XML-TEXT-LEN PIC 9(9) COMP-5.
       
       PROCEDURE DIVISION.
       MAIN-PGH.
           DISPLAY WINDOW ERASE NO WRAP.
           XML PARSE
               "<?xml version=""1.0""?>
      -        "<data1>
      -        "<!-- This is a comment embedded in the XML stream -->
      -        "<data2><![CDATA[Text<>&'""]]>  xx </data2>
      -        "<data3 attr=""my&amp;attr"">&quot;ddd&quot;</data3>
      -        "</data1>"
               PROCESSING PROCEDURE IS MY-XML-PROC THRU MY-XML-PROC-END
             ON EXCEPTION
                 DISPLAY "ERROR PARSING XML"
             NOT ON EXCEPTION
                 DISPLAY "DONE"
           END-XML
           ACCEPT OMITTED
           GOBACK.
       
       MY-XML-PROC.
           DISPLAY XML-EVENT NO.
       
       MY-XML-PROC-2.
           MOVE FUNCTION LENGTH(XML-TEXT) TO XML-TEXT-LEN.
           DISPLAY XML-TEXT(1:XML-TEXT-LEN).
       
       MY-XML-PROC-END.
           EXIT.
