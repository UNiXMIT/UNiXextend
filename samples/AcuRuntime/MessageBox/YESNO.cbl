       IDENTIFICATION DIVISION.
       PROGRAM-ID.                     YES-NO.

       ENVIRONMENT DIVISION.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  MESSAGE-BOX.
           05 MESS-MB-TYPE              PIC 9.
              88 MESS-MB-OK             VALUE 1.
              88 MESS-MB-YES-NO         VALUE 2.
              88 MESS-MB-OK-CANCEL      VALUE 3.
              88 MESS-MB-YES-NO-CANCEL  VALUE 4.
       01 mb-return		pic 9.
          
       copy acugui.def.

       PROCEDURE DIVISION.
       yes-no-start.
			
           DISPLAY MESSAGE BOX "YES or NO"
                   TYPE IS mb-yes-no
                   returning mb-return

           DISPLAY MESSAGE BOX "OK"
                   TYPE IS MB-OK
           
           EVALUATE MB-RETURN
               WHEN MB-YES
                   DISPLAY MESSAGE BOX "YES Pressed!"
               WHEN MB-NO
                   DISPLAY MESSAGE BOX "NO Pressed!"
           END-EVALUATE

           goback.