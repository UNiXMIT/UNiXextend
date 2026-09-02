       program-id.  testsort.
       SPECIAL-NAMES.
           ALPHABET NO-CASE IS 1 THRU 65,   'A' ALSO 'a',  
           'B' ALSO 'b',   'C' ALSO 'c',   'D' ALSO 'd',  
           'E' ALSO 'e',   'F' ALSO 'f',   'G' ALSO 'g',  
           'H' ALSO 'h',   'I' ALSO 'i',   'J' ALSO 'j',  
           'K' ALSO 'k',   'L' ALSO 'l',   'M' ALSO 'm',  
           'N' ALSO 'n',   'O' ALSO 'o',   'P' ALSO 'p',  
           'Q' ALSO 'q',   'R' ALSO 'r',   'S' ALSO 's',  
           'T' ALSO 't',   'U' ALSO 'u',   'V' ALSO 'v',  
           'W' ALSO 'w',   'X' ALSO 'x',   'Y' ALSO 'y',  
           'Z' ALSO 'z'.       
       file-control.
       SELECT SORT-FILE ASSIGN TO "DISK".               
       data division.
       file section.                      
       SD SORT-FILE.
       01 s-REC.
          03  s-NAME                 PIC X(10).
          03  s-DATA                 PIC X(10).
       working-storage section.
       01 data-table.
          03 filler pic x(20) value "Zelda     dataone   ".
          03 filler pic x(20) value "walter    datatwo   ".
          03 filler pic x(20) value "sonya     datathree ".
          03 filler pic x(20) value "veronica  datafour  ".
          03 filler pic x(20) value "daniel    datafive  ".
          03 filler pic x(20) value "anna      datasix   ".
          03 filler pic x(20) value "efren     dataseven ".
          03 filler pic x(20) value "donald    dataeight ".
          03 filler pic x(20) value "chuck     datanine  ".
          03 filler pic x(20) value "Efren     dataten   ".
          03 filler pic x(20) value "georgia   dataeleven".
          03 filler pic x(20) value "Daniel    datatwelve".
       01 working-table redefines data-table.
          03 table-item occurs 12 times pic x(20).
       01 tab-idx pic 99.
       procedure division.
       main.

           display "Executing SORT routine."
           perform sort-routine.
           display "SORT complete.".
           accept omitted.
           exit program.
           stop run.
 
       sort-routine section.
           SORT SORT-FILE
               ON ASCENDING KEY s-name
               WITH DUPLICATES IN ORDER
               COLLATING SEQUENCE NO-CASE
               INPUT  PROCEDURE IS SORT-IN
               OUTPUT PROCEDURE IS SORT-OUT.    

       end-sort-routine.
           EXIT.

   
       sort-in  section.
       a00-sort-in.
           PERFORM with test after
              VARYING tab-idx FROM 1 BY 1 UNTIL tab-idx = 12
              if table-item(tab-idx)(1:1)= "v" |skip "v" names
                 continue
              else
                 move table-item(tab-idx) to s-rec
                 RELEASE s-rec
              end-if
              
           end-perform.
           
       a00-sort-in-EXIT.
           EXIT.
          
       SORT-OUT SECTION.
       a00-process-sorted.
           perform until 1 = 2
               RETURN SORT-FILE INTO S-rec 
                   AT END exit paragraph
               end-return
               display "Return = " s-rec
           end-perform.
         
       a00-process-sorted-EXIT.
           exit.

