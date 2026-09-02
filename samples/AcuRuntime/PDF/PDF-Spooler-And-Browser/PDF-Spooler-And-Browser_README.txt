1. Edit cblconfi_PDF-Spooler.cfg, setting the local AcuToWeb URLs and cblconfi_AcuToWeb.cfg full path.
2. Edit cblconfi_AcuToWeb.cfg, if necessary to tune the timeout settings.

3. Compile programs using:
ccbl32 -ga PDF-web-browser.cbl
ccbl32 -ga test-PDF-Spooler.cbl

4. Create an alias using:
Working Directory: the folder you saved the sample into
Command Line: -c cblconfi_PDF-Spooler.cfg test-PDF-Spooler.acu

5. Execute the alias from your browser.