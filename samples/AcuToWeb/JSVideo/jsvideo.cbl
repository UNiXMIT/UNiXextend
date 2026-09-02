       IDENTIFICATION              DIVISION.
       PROGRAM-ID. JSVideo.
       AUTHOR. support.
       DATE-WRITTEN. 10 December 2021 11:11:00.
       REMARKS. 
      * Compile with -sl
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       SPECIAL-NAMES.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
       DATA                        DIVISION.
       FILE                        SECTION.
       WORKING-STORAGE             SECTION.
       COPY "acugui.def".
       COPY "crtvars.def".
       77 Key-Status IS SPECIAL-NAMES CRT STATUS PIC 9(4) VALUE 0.
           88 Exit-Pushed VALUE 27.
           88 Message-Received VALUE 95.
           88 Event-Occurred VALUE 96.
           88 Screen-No-Input-Field VALUE 97.
           88 Screen-Time-Out VALUE 99.

       77 Screen1-Handle USAGE IS HANDLE OF WINDOW VALUE NULL.
       01 JSstr            PIC  X(500).

       LINKAGE                     SECTION.
       SCREEN                      SECTION.
       01 Screen1.
           03 Screen1-As-1, ATW-Script.

       PROCEDURE DIVISION.

       Main-Logic.
              DISPLAY Standard GRAPHICAL WINDOW
                 LINES 51.20, SIZE 89.70, CELL HEIGHT 10, 
                 CELL WIDTH 10, AUTO-MINIMIZE, COLOR IS 65793, 
                 LABEL-OFFSET 0, LINK TO THREAD, MODELESS, NO SCROLL, 
                 WITH SYSTEM MENU, 
                 TITLE "RickRoll", TITLE-BAR, NO WRAP,
                 ATW-CSS-ID "windowID" 
                 HANDLE IS Screen1-Handle

           DISPLAY Screen1 UPON Screen1-Handle

      *    STRING "var video = document.createElement('video');"
      *           "video.src = 'https://domain.com/video.mp4';"
      *           "video.autoplay = true;"
      *           "video.style.width = "897px";"
      *           "video.style.height = "512px";"
      *           "document.getElementById('windowID')"
      *           ".insertBefore(video, windowID_term_layer);"
      *    INTO JSstr
           STRING "var video = document.createElement('iframe');"
                  "video.setAttribute('src', 'https://www.youtube.com/embed/dQw4w9WgXcQ?controls=0&autoplay=1');"
                  "video.setAttribute('frameborder', '0');"
                  "video.setAttribute('allow', 'accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture');"
                  "video.style.width = '897px';"
                  "video.style.height = '512px';"
                  "document.getElementById('windowID').insertBefore(video, windowID_term_layer);"
           INTO JSstr
           MODIFY Screen1-As-1 EVALUATE(JSstr) 

           PERFORM UNTIL Exit-Pushed
              ACCEPT OMITTED LINE 1 COL 1  
                 ON EXCEPTION PERFORM Acu-Screen1-Evaluate-Func
              END-ACCEPT
           END-PERFORM
           DESTROY Screen1-Handle
           INITIALIZE Key-Status.           .

       Acu-Screen1-Evaluate-Func.
           EVALUATE TRUE
              WHEN Exit-Pushed
                 SET Exit-Pushed TO TRUE
              WHEN Event-Occurred
                 IF Event-Type = Cmd-Close
                    SET Exit-Pushed TO TRUE
                 END-IF
           END-EVALUATE
           MOVE 1 TO Accept-Control
           .
