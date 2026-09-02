       Program-Id. acu-replace.
      *--------------------------------------------------------------*
150211* carlo  - Modifiche per farprivacy 2011                       *
      *--------------------------------------------------------------*
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
       FILE SECTION.
       Working-Storage Section. 
      *{Bench}acu-def
       COPY "acugui.def".
       COPY "acucobol.def".
       COPY "crtvars.def".
       COPY "showmsg.def".
      *{Bench}end
      *picture limit - inizio
       78 main-pic         value 32768.
060607*78 old-pic          value 256.
060607*78 new-pic          value 256.
150211 78 old-pic          value 10000.
.      78 new-pic          value 10000.
      *picture limit - fine
       77 main-string      pic x(main-pic). 
       77 my-buffer        pic x(main-pic).
       77 old-string       pic x(old-pic) .
       77 new-string       pic x(new-pic) . 
       77 param-size       pic 9(5).

       77 num-para         pic 9    usage comp-1.
       77 with-low-values  pic 9    value 0.
150211 77 cont-rpl         pic 9(5) value 0.
       77 cont1            pic 9(5) value 0.
       77 cont2            pic 9(5) value 0.
150211 77 str-len          pic 9(5) value 0.
       77 stringa-presente pic 9    value 0.

       77 ritorno          pic s9(5).
       78 bad-call         value -1.
       78 str-too-long     value -2.

       Linkage Section.
       77 parametro1      pic x(main-pic). 
       77 parametro2      pic x(old-pic). 
       77 parametro3      pic x(new-pic). 

       SCREEN SECTION.
      *{Bench}copy-screen
      *COPY "acu-replace.scr".
      *{Bench}end
       Procedure Division using parametro1, parametro2, parametro3.
       MAIN.
      *controlla che siano stati passati 3 parametri
           call "C$NARG" using num-para.
           if num-para < 3
              move bad-call to ritorno
              go to USCITA
           end-if. 
      *ricava il size dei parametri e valorizza working 
           call "C$PARAMSIZE" using 2 giving param-size.
           if param-size > old-pic
              move bad-call to ritorno
              go to USCITA
           else
              move parametro2(1:param-size)  to old-string
           end-if.
           call "C$PARAMSIZE" using 3 giving param-size.
           if param-size > new-pic
              move bad-call to ritorno
              go to USCITA
           else
              move parametro3(1:param-size)  to new-string
           end-if.
           call "C$PARAMSIZE" using 1 giving param-size.
           if param-size > main-pic
              move bad-call to ritorno
           else
              move parametro1(1:param-size)  to main-string
           end-if.
      *controlla se la stringa conteneva già low-values
           initialize cont1.
           inspect parametro1(1:param-size) 
                              tallying cont1 for all low-values.
           if cont1 > 0
              move 1 to with-low-values
           end-if.
      *delimita le stringhe da low-values
           inspect main-string replacing trailing spaces by low-values.
           inspect old-string  replacing trailing spaces by low-values.
           inspect new-string  replacing trailing spaces by low-values.
      *misura la lunghezza della stringa da cercare
           initialize str-len.
           inspect old-string tallying str-len for characters 
                                               before initial low-value.
      *analizza la stringa principale ed effettua le sostituzioni
           perform varying cont1 from 1 by 1 
                   until main-string(cont1:1) = low-value
                                     or cont1 > main-pic
             if main-string(cont1:1) = old-string(1:1) 
      *          perform VERIFICA-PRESENZA
                if stringa-presente = 1
                   move 0 to stringa-presente
                   add 1  to cont-rpl
                   perform EFFETTUA-REPLACE
                end-if
             end-if
           end-perform.                                                                                     

      *controlla che il risultato sia contenibile nel parametro in linkage
           initialize cont1.
           inspect main-string tallying cont1 for characters before 
                                                  initial low-value.
           if cont1 > param-size
              move str-too-long to ritorno
              go to USCITA
           end-if.

      *valorizza la linkage ed esce
161204     if with-low-values = 0
161204        inspect main-string replacing all low-values by spaces
161204     end-if.
           move main-string(1:param-size) to parametro1(1:param-size).
161204*     if with-low-values = 1
.     *        inspect parametro1 replacing all low-values by spaces
.     *     end-if.

           move cont-rpl to ritorno. 
           go to USCITA.

       VERIFICA-PRESENZA.
           move 1 to stringa-presente.  
           perform varying cont2 from 1 by 1 until cont2 > str-len
             if main-string(cont1 - 1 + cont2:1) 
                                               not = old-string(cont2:1) 
                move 0 to stringa-presente
                exit perform
             end-if
           end-perform.

       EFFETTUA-REPLACE.
           initialize my-buffer.
           if (cont1 - 1)= 0 |ci sarebbe un "reference modifier.."
              string new-string                  delimited by low-values
                     main-string(cont1 - 1 + cont2:) delimited by size
                                                     into my-buffer
           else 
              string main-string(1:cont1 - 1)    delimited by size
                     new-string                  delimited by low-values
                     main-string(cont1 - 1 + cont2:) delimited by size
                                                     into my-buffer
           end-if.

           move my-buffer to main-string
           add 10 to cont1.
           
              

       USCITA.
           exit program giving ritorno.
