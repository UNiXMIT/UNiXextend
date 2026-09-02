       IDENTIFICATION DIVISION.
       PROGRAM-ID.                      CJAVA-URLENCODE.

       WORKING-STORAGE SECTION.
       01  STATUS-VAL              PIC S9(2).

      * Input string to encode
       01  WS-INPUT-URL            PIC X(32) VALUE SPACES.
      * Output: encoded result returned from Java
       01  WS-ENCODED-URL          PIC X(100) VALUE SPACES.

       COPY "JAVA.DEF".

       PROCEDURE DIVISION.

           MOVE "hello world/test?foo=bar&baz=qux" TO WS-INPUT-URL

           CALL "C$JAVA" USING
                   CJAVA-CALLSTATIC,
                   "urlEncoder"
                   "encodeUrl"
                   "(Ljava/lang/String;)Ljava/lang/String;"
                   WS-INPUT-URL
                   WS-ENCODED-URL
               GIVING STATUS-VAL

           IF STATUS-VAL NOT = 0
               DISPLAY "C$JAVA call failed, status: " STATUS-VAL
           ELSE
               DISPLAY "Encoded URL: " WS-ENCODED-URL
           END-IF
           ACCEPT OMITTED
           GOBACK.
               