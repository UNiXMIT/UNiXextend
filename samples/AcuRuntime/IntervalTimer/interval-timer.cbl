       identification division.
       program-id. program.
       author. mturner.

       environment division.
       input-output section.
       
       data division.
       file section.
       working-storage section.
       77  start-time        double.
       77  elapsed-time      double.

       77  display-time      pic zzzz.9(4).
       77  dummy             pic 9(3)9(6).


       linkage section.

       screen section.

       procedure division.
       main-logic.

           display standard window.
           display "Running..."
     
           move function interval-timer to start-time

           perform something-long

           compute elapsed-time = function interval-timer - start-time

           move elapsed-time to display-time
           display message "Something-Long took " H"0A"
                   display-time H"0A"
                   "seconds to run" H"0A"
           accept omitted.
           
           stop run.

       something-long.
            perform 1 times
                CALL "C$SLEEP" USING 10
            end-perform.

           