       identification division.
       program-id. test-PDF-Spooler.
       remarks.  
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
       input-output section.
       file-control.
           select file-output 
           ASSIGN TO ws-PRINTER-spooler
           organization is LINE SEQUENTIAL.
       
       data division.
       file section.            
       FD file-output.
       01  file-output-rec.
           05 file-record           PIC  X(120).
                                     
       
       working-storage section.       

AToWeb  77 ws-PRINTER-file-name      pic x(050) value "AcuPDFPrint.pdf".
AToWeb  77 ws-PRINTER-file-path      pic x(100) value spaces.
AToWeb  77 ws-PRINTER-spooler        pic x(150) value spaces.
       
       78  max-rows                          value 18.
       
       01 grid-data-table.
         05 filler                           pic x(120)
           value "  CATEGORY        AUTHOR                  TITLE
      -    "                         PUBLISHER                 DATE".
         05 filler                           pic x(120)
           value "01Adventure       Fleming  Ian            On Her Majes
      -    "ty's Secret Service      New American Library      01/10/196
      -    "3".
         05 filler                           pic x(120)
           value "02Art             CrespelleJean-Paul      Monet
      -    "                         Studio Editions           12/25/199
      -    "3".
         05 filler                           pic x(120)
           value "03Biographical    Adamson  Joy            Born Free
      -    "                         Pantheon                  6/8/1960"
           .
         05 filler                           pic x(120)
           value "04Children        Milne    A.A.           Winnie the P
      -    "ooh                      E.P. Dutton & Co., Inc    03-23-195
      -    "6".
         05 filler                           pic x(120)
           value "05Fiction         Miller   Henry          Tropic of Ca
      -    "pricorn                  Grove Press               4/20/1961
      -    "".
         05 filler                           pic x(120)
           value "06History         Durant   Will and Ariel The Age of N
      -    "apoleon                  Simon and Schuster        04/20/197
      -    "5".
         05 filler                           pic x(120)
           value "07History         Stone    Irving         The Agony an
      -    "d the Ecstasy            Doubleday & Company, Inc  03/20/195
      -    "8".
         05 filler                           pic x(120)
           value "08History         Tuchmann Barbara        The March of
      -    " Folly                   Alfred A. Knopf, Inc      10-12-198
      -    "4".
         05 filler                           pic x(120)
           value "09Murder Mystery  Christie Agatha         Sleeping Mur
      -    "der                      The Haddon Craftsman, Inc 07-08-197
      -	   "6".
         05 filler                           pic x(120)
           value "10Reference       Matthews Peter          The Guinness
      -    " Book of Records 1996    Bantam Books              9-10-1997
      -    "".
         05 filler                           pic x(120)
           value "11Science         Macauly  David          The Way Thin
      -    "gs Work                  Houghton Mifflin, Co      09/08/198
      -    "8".
         05 filler                           pic x(120)
           value "12Science Fiction Crichton Michael        AirFrame
      -    "                         Alfred A. Knopf, Inc      01/05/199
      -    "6".
         05 filler                           pic x(120)
           value "13Science Fiction Crichton Michael        Jurassic Par
      -    "k                        Signet Fiction            001/4/199
      -    "4".
         05 filler                           pic x(120)
           value "14Science Fiction Niven    Larry          Ringworld
      -    "                         Ballantine Books          8/9/1970"
           .
         05 filler                           pic x(120)
           value "15Science Fiction Verne    Jules          A Journey to
      -    " the Center of the Earth Signet Classic            8/11/1986
      -    "".
         05 filler                           pic x(120)
           value "16Science Fiction Verne    Jules          20,000 Leagu
      -    "es Under the Sea         Signet Classic            12/8/1986
      -    "".
         05 filler                           pic x(120)
           value "17Science Fiction Wells    H.G.           The Invisibl
      -    "e Man                    Signet Classic            11/9/1986
      -    "".

       01 grid-data-tbl redefines grid-data-table.
         05 grid-record occurs max-rows times      pic x(120).
      *       
       
       77  ws-x                pic 999   value 0.
       
       procedure division.
       main-logic.
       
AToWeb     CALL "C$CHDIR" USING ws-PRINTER-file-path
AToWeb     STRING "-P PDF "                delimited by size
AToWeb               ws-PRINTER-file-path  delimited by spaces
AToWeb               "\"
AToWeb               ws-PRINTER-file-name  delimited by spaces
AToWeb               INTO ws-PRINTER-spooler           
       
           open output file-output.           

           perform with test after until ws-x = 120
              add 1 to ws-x
              if ws-x(3:1) = 0
                 move ws-x(2:1) to file-record(ws-x:1)
              else   
                 move "-" to file-record(ws-x:1)
              end-if
           end-perform
           write file-output-rec

           perform varying ws-x from 1 by 1 until ws-x > max-rows
              move grid-record(ws-x) to file-record
              write file-output-rec
           end-perform

           close file-output.
                  	   
           display message box "Print Job is completed."   
                   title "Printing your -P PDF file"   
           
AToWeb     call "PDF-web-browser" using ws-PRINTER-file-path,
AToWeb                                  ws-PRINTER-file-name          	   
                  	   
       	   stop run.
                                             