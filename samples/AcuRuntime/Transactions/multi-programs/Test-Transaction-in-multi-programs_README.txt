Here's a sample which shows how TRANSACTIONS work with multi programs.

ccbl32 -ga test-transaction-A.cbl
ccbl32 -ga test-transaction-B.cbl

wrun32 -c cblconfi_transaction -d  test-transaction-A.acu

Test-transaction-A starts the transaction and writes 1 record per each file.
Then it calls test-transaction-B, which adds a second record for each file.
If the transaction succedes, LETTURA-CONTENUTO will show the 6 records.

In test-transaction-A, comment/uncomment the line marked with CCCCCC to activate either the COMMIT or the ROLLBACK.

When the ROLLBACK is executed, the run will finish with 3 empty files.