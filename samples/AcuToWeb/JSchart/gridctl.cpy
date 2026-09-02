      * Build menu MAIN-POPUP and return handle in MENU-HANDLE

      * Copyright (C) 1997-1998,2000 Micro Focus. All rights reserved.
      *
      * This sample code is supplied for demonstration purposes only
      * on an "as is" basis and is for use at your own risk.

      * Created by GENMENU on 06-Oct-97
      * Source file: "gridctl.mnu"

       BUILD-MAIN-POPUP.
           PERFORM GEN-MAIN-POPUP THRU GEN-MAIN-POPUP-EXIT.

       GEN-MAIN-POPUP.
           CALL "W$MENU" USING WMENU-NEW-POPUP
           IF RETURN-CODE = ZERO
               GO TO GEN-MAIN-POPUP-EXIT
           END-IF
           MOVE RETURN-CODE TO MENU-HANDLE

           CALL "W$MENU" USING WMENU-ADD, MENU-HANDLE, 0, 0,
                               "&About", 15
           CALL "W$MENU" USING WMENU-ADD, MENU-HANDLE, 0, 0,
                               "E&xit", 10
           .

       GEN-MAIN-POPUP-EXIT.
           MOVE ZERO TO RETURN-CODE.
