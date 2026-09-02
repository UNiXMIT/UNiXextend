       identification division.
       program-id. email.

       environment division.
       configuration section.

       data division.
       working-storage section.
       copy "acucobol.def".
       copy "acugui.def".

       01 URL PIC X(50) VALUE
                          "mailto:info@acucorp.com?subject=The+Subject".

       procedure division.
           accept terminal-abilities from terminal-info.

           display web-browser
               value URL
               VISIBLE = 0

           goback.