        01 VA-Record.
      * record dei dati
           03 VA-Rec.
      *L=linea;C=Campo/label/Rettangoo,I=Immagine
           05 VA-Tipo-oggetto  PIC  xx.
      *spazio definito dall'utente o carattere x variante standard
           05 VA-Variante-oggetto          PIC  xx.
           05 VA-Descrizione               PIC  x(30).
      *Riga origine oggetto
           05 VA-Row-Ori                   PIC  9(2)V9(2).
      *Colonna origine oggetto
           05 VA-Col-Ori                   PIC  9(3)V9(2).
      *Larghezza oggetto
           05 VA-Larghezza                 PIC  9(3)V9(2).
      *Altezza oggetto
           05 VA-Altezza                   PIC  9(2)V9(2).
      *bordi oggetto: 0 - Nessuno, 1 - Sotto, 2 - SX + Sotto, 3 - SX + Sotto + DX, 9 - Tutti
           05 VA-Bordi                     PIC  9.
      *rotazione oggetto
           05 VA-OggRotazione              PIC  9(3).
      *esempio linee divisorie per i rettangoli
           05 VA-OggEffetto                PIC  xx.
      *Colore linea o bordo
           05 VA-OggColoreBordo            PIC  xx.
      *Colore sfondo
           05 VA-OggColoreFill             PIC  xx.
      *Spessore Linea: valore oppure 999,00-99 per valori predefiniti
           05 VA-LineaSpess                PIC  9(3)V9(2).
      *Tipo Font
           05 VA-TipoFont                  PIC  xx.
      *Dimensione Font in punti
           05 VA-DimFont                   PIC  9(3)V9(2).
      *% larghezza Font
           05 VA-LargFont                  PIC  9(3).
           05 VA-AttributiFont.
               10 VA-Grassetto             PIC  9.
               10 VA-Corsivo               PIC  9.
               10 VA-Sottolineato          PIC  9.
           05 VA-TestoColoreBordo          PIC  xx.
           05 VA-TestoColoreFill           PIC  xx.
           05 VA-Allineamento              PIC  9.
           05 VA-Editabile                 PIC  9.
           05 VA-Multilinea                PIC  9.
           05 FILLER                        PIC  x(50).
           05 VA-DatiExtra                 PIC  x(20).