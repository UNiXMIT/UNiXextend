       identification division.
       program-id.	writebooks.

      * Compile with:
      * -fa writebooks.cbl 

      * Run with:
      * -c cblconfig writebooks.acu

       environment division.
       input-output section.
       file-control.
           copy "bookfile.sl".

       data division.
       file section.
           copy "bookfile.fd".

       working-storage section.
       01  xml-bookfile-status                 pic xx.

       screen section.

       procedure division.
       main-logic.
           open output xml-bookfile.
           move "TX1" to xml-name of xml-lender
           move "77 Massachusetts Ave." to xml-street of xml-lender
           move "Cambridge" to xml-city of xml-lender
           move "MA" to xml-state of xml-lender
           move "John Doe" to xml-name of xml-borrower
           move "123 Main St." to xml-street of xml-borrower
           move "Anytown" to xml-city of xml-borrower
           move "CA" to xml-state of xml-borrower
           move "Introduction to COBOL" to xml-booktitle (1)
           move "2003" to xml-pubdate (1)
           move "79" to xml-replacementvalue (1)
           move "21" to xml-maxdaysout (1)
           move "Advanced COBOL Programming" to xml-booktitle (2)
           move "2005" to xml-pubdate (2)
           move "99" to xml-replacementvalue (2)
           move "30" to xml-maxdaysout (2)
           write xml-transaction
           close xml-bookfile.
