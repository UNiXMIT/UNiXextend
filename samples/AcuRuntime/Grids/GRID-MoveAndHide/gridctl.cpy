      * Build menu MAIN-POPUP and return handle in MENU-HANDLE

      * Copyright (C) 1997-1998,2000 Micro Focus or one of its affiliates.
      *
      * The only warranties for products and services of Micro Focus
      * and its affiliates and licensors ("Micro Focus") are set
      * forth in the express warranty statements accompanying such
      * products and services. Nothing herein should be construed as
      * constituting an additional warranty. Micro Focus shall not
      * be liable for technical or editorial errors or omissions
      * contained herein. The information contained herein is
      * subject to change without notice.
      *
      * Contains Confidential Information. Except as specifically
      * indicated otherwise, a valid license is required for possession,
      * use or copying. Consistent with FAR 12.211 and 12.212,
      * Commercial Computer Software, Computer Software Documentation,
      * and Technical Data for Commercial Items are licensed to the U.S.
      * Government under vendor's standard commercial license.

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
