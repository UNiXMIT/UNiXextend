       IDENTIFICATION DIVISION.
       PROGRAM-ID.  HTTPGET-JSON.
      * COMPILE USING   -rw id -rw icon -rw type -sl
      *
      * RUNTIME OPTIONS    -y rmnet.dll
      * COPYRIGHT (C) 2021 MICRO FOCUS. ALL RIGHTS RESERVED.
      *
      * THIS SAMPLE CODE IS SUPPLIED FOR DEMONSTRATION PURPOSES ONLY
      * ON AN "AS IS" BASIS AND IS FOR USE AT YOUR OWN RISK.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       COPY "acucobol.def".

       01  RESPONSE-PAYLOAD            USAGE POINTER.
       01  RESPONSE-LEN                PIC S9(6) VALUE ZERO.
       01  RESPONSE-STATUS             PIC 9(3) VALUE ZERO.
       01  SSL-VERIFYPEER-FLAG         PIC 9 VALUE 1.
       01  STATUS-CODE                 PIC 9(3) VALUE ZERO.
       01  POST-ADDRESS                PIC X(200) VALUE "http://api.openweathermap.org/data/2.5/weather?id=2641689&units=metric&APPID=60d4c6b22bcbee2981dc182662577568".
       01  JSON-DATA                   PIC X(1000).
       01  N                           PIC 9(3) VALUE 1.
       
       01 TOP-LEVEL.
        03 COORD.
           05 LON                      PIC S9(3)V9(4).
           05 LAT                      PIC S9(3)V9(4).
        03 BASE                        PIC X(10).
        03 MAIN.
           05 TEMP                     PIC 9(3)V9(2).
           05 FEELS_LIKE               PIC S9(3)V9(2).
           05 TEMP_MIN                 PIC 9(3)V9(2).
           05 TEMP_MAX                 PIC 9(3)V9(2).
           05 PRESSURE                 PIC 9(5).
           05 HUMIDITY                 PIC 9(3).
           05 SEA_LEVEL                PIC 9(5).
           05 GRND_LEVEL               PIC 9(5).
        03 VISIBILITY                  PIC 9(5).
        03 WIND.
           05 SPEED                    PIC 9(3)V9(2).
           05 DEG                      PIC 9(3).
           05 GUST                     PIC 9(3)V9(2).
        03 CLOUDS.
           05 ALL                      PIC 9(3).
        03 DT                          PIC 9(10).
        03 SYS. 
           05 TYPE                     PIC 9.
           05 ID                       PIC 9(7).
           05 COUNTRY                  PIC X(2).
           05 SUNRISE                  PIC 9(10).
           05 SUNSET                   PIC 9(10). 
        03 TIMEZONE                    PIC 9(4).
        03 ID                          PIC 9(7).
        03 NAME                        PIC X(40).
        03 COD                         PIC 9(3).
        03 WEATHER OCCURS 1 TO 5 DEPENDING ON N.
           05 ID                       PIC 9(3).
           05 MAIN                     PIC X(10).
           05 DESCRIPTION              PIC X(30).
           05 ICON                     PIC X(3).

       LINKAGE SECTION.
       01  RESPONSE-DATA               PIC X(12000).

       PROCEDURE DIVISION.
           PERFORM SETUP
           PERFORM HTTPGET
           PERFORM GET-RESPONSE
           GOBACK.

       SETUP.           
           CALL "NETINIT" GIVING RESPONSE-STATUS
           CALL "NETSSLVERIFYPEER" USING SSL-VERIFYPEER-FLAG 
                                   GIVING STATUS-CODE.
          
       HTTPGET.
           CALL "HTTPGET"
             USING
               POST-ADDRESS
               RESPONSE-PAYLOAD
               RESPONSE-LEN
             GIVING
               RESPONSE-STATUS.

       GET-RESPONSE.          
           SET ADDRESS OF RESPONSE-DATA TO RESPONSE-PAYLOAD  

           IF NOT RESPONSE-STATUS = 0
               DISPLAY MESSAGE BOX "RESPONSE STATUS = " RESPONSE-STATUS
           ELSE
               STRING '{"TOP-LEVEL":' RESPONSE-DATA(1:RESPONSE-LEN) '}' 
                      INTO JSON-DATA
               DISPLAY MESSAGE BOX JSON-DATA
                       TITLE "RAW JSON"
               PERFORM PARSE-JSON
           END-IF

           CALL "NETFREE" USING RESPONSE-PAYLOAD.

       PARSE-JSON.
           IF RESPONSE-DATA(1:1)="{"
               JSON PARSE JSON-DATA INTO TOP-LEVEL
                  ON EXCEPTION DISPLAY MESSAGE BOX
                               JSON-STATUS  ":" JSON-CODE
               END-JSON
               PERFORM DISPLAY-DATA
           END-IF.
        
       DISPLAY-DATA.
           DISPLAY MESSAGE BOX 
                "CITY: "NAME X"0D0A"
                "TEMP: "TEMP X"0D0A"
                "TEMP MAX: " TEMP_MAX " TEMP MIN: " TEMP_MIN X"0D0A"
                "WEATHER: "  MAIN OF WEATHER(1) X"0D0A"
                "DESCRIPTION " DESCRIPTION(1)  X"0D0A"
                "LAT:"LAT " LONG:"LON
                TITLE = "Weather"