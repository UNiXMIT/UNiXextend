      *
       Acu-Extended-File-Status.
           CALL "C$RERRNAME" USING Acu-Err-File
           CALL "C$RERR" USING Extend-Stat, Text-Message
              MOVE Primary-Error TO Acu-Msg-Id
              PERFORM Acu-Show-Msg
           .
       Acu-Show-Msg.
           MOVE SPACE TO Acu-Msg-1 Acu-Msg-2 Acu-Msg-3
           EVALUATE Acu-Msg-Id
           WHEN 10
              MOVE "No more data."  TO Acu-Msg-1
              MOVE Mb-Default-Icon TO Acu-Icon-Type
              MOVE Mb-Ok TO Acu-Button-Type
           WHEN 22
              MOVE "Key duplication." TO Acu-Msg-1
              MOVE Mb-Error-Icon TO Acu-Icon-Type
              MOVE Mb-Ok TO Acu-Button-Type
           WHEN 23
              MOVE "Record not found." TO Acu-Msg-1
              MOVE Mb-Warning-Icon TO Acu-Icon-Type
              MOVE Mb-Ok TO Acu-Button-Type
           WHEN 101
              MOVE "Quit?" TO Acu-Msg-1
              MOVE 4 TO Acu-Icon-Type
              MOVE Mb-Yes-No TO Acu-Button-Type
           WHEN 201
              MOVE "Add Record?" TO Acu-Msg-1
              MOVE 4 TO Acu-Icon-Type
              MOVE Mb-Yes-No TO Acu-Button-Type
           WHEN 202
              MOVE "Update Record?" TO Acu-Msg-1
              MOVE 4 TO Acu-Icon-Type
              MOVE Mb-Yes-No TO Acu-Button-Type
           WHEN 203
              MOVE "Delete Record?" TO Acu-Msg-1
              MOVE 4 TO Acu-Icon-Type
              MOVE Mb-Yes-No TO Acu-Button-Type
           WHEN 204
              MOVE "Key duplication." TO Acu-Msg-1
              MOVE Mb-Warning-Icon TO Acu-Icon-Type
              MOVE Mb-Ok TO Acu-Button-Type
           WHEN 301
              MOVE "Add Successful." TO Acu-Msg-1
              MOVE Mb-Default-Icon TO Acu-Icon-Type
              MOVE Mb-Ok TO Acu-Button-Type
           WHEN 302
              MOVE "Update Successful." TO Acu-Msg-1
              MOVE Mb-Default-Icon TO Acu-Icon-Type
              MOVE Mb-Ok TO Acu-Button-Type
           WHEN 303
              MOVE "Delete Successful." TO Acu-Msg-1
              MOVE Mb-Default-Icon TO Acu-Icon-Type
              MOVE Mb-Ok TO Acu-Button-Type
           WHEN 401
              MOVE "Shell not found." TO Acu-Msg-1
              MOVE Mb-Error-Icon TO Acu-Icon-Type
              MOVE Mb-Ok TO Acu-Button-Type
      * user-defined message
           WHEN 901
              MOVE Mb-Warning-Icon TO Acu-Icon-Type
              MOVE Mb-Ok TO Acu-Button-Type
           WHEN OTHER
              MOVE Text-Message TO Acu-Msg-1
              STRING "File:" Acu-Err-File DELIMITED BY SPACE
                 INTO Acu-Msg-2
              STRING "File status ", Primary-Error "," Secondary-Error
                 DELIMITED BY SIZE INTO Acu-Msg-3
           END-EVALUATE
           PERFORM Acu-Message-Box
           .

       Acu-Message-Box.
           MOVE 1 TO Acu-Text-Ptr
           IF Acu-Msg-1 NOT = SPACE
              MOVE 0 TO Acu-Size
              INSPECT Acu-Msg-1 TALLYING Acu-Size FOR TRAILING SPACE
              STRING Acu-Msg-1( 1 : Acu-Length - Acu-Size )
                 DELIMITED BY SIZE
                 INTO Acu-Msg-Text, POINTER Acu-Text-Ptr
           END-IF

           IF Acu-Msg-2 NOT = SPACE
              MOVE 0 TO Acu-Size
              INSPECT Acu-Msg-2 TALLYING Acu-Size FOR TRAILING SPACE
              IF ACU-Text-Ptr > 1
                 STRING X"0A" DELIMITED BY SIZE
                     INTO Acu-Msg-Text, POINTER Acu-Text-Ptr
              END-IF
              STRING Acu-Msg-2( 1 : Acu-Length - Acu-Size )
                  DELIMITED BY SIZE
                  INTO Acu-Msg-Text, POINTER Acu-Text-Ptr
           END-IF

           IF Acu-Msg-3 NOT = SPACE
              MOVE 0 TO Acu-Size
              INSPECT Acu-Msg-3 TALLYING Acu-Size FOR TRAILING SPACE
              IF Acu-Text-Ptr > 1
                 STRING X"0A" DELIMITED BY SIZE
                     INTO Acu-Msg-Text, POINTER Acu-Text-Ptr
              END-IF
              STRING Acu-Msg-3( 1 : Acu-Length - Acu-Size )
                  DELIMITED BY SIZE
                  INTO Acu-Msg-Text, POINTER Acu-Text-Ptr
           END-IF

           IF Acu-Text-Ptr = 1
             MOVE 0 TO Acu-Size
             INSPECT Acu-Msg-Text TALLYING Acu-Size FOR TRAILING SPACE
             COMPUTE Acu-Text-Ptr = Acu-Full-Len - Acu-Size + 1
           END-IF
           MOVE Low-Values TO Acu-Msg-Text( Acu-Text-Ptr : 1 )

           DISPLAY MESSAGE BOX
              Acu-Msg-Text
              TYPE IS Acu-Button-Type
              ICON IS Acu-Icon-Type
              DEFAULT IS Acu-Default-Button
              RETURNING Acu-Return-Value
           .
