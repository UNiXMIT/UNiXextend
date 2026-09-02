       IDENTIFICATION DIVISION.
       PROGRAM-ID. JSONNESTEDARRAY.
       
       ENVIRONMENT DIVISION.
       
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       
       01  WS-JSON PIC X(500) VALUE '{"department":"Engineering","teams":[{"team-name":"Dev Team","members":["John","Mary","Bob"]},{"team-name":"QATeam","members":["Alice","Tom"]}]}'.
           
       01  JSON-PROCESSED PIC X(500).
       01  WS-JSON-STATUS  PIC S9(9) COMP-5.
       
       01 JSON-DATA.
           03  department PIC X(20).
           03  teams OCCURS 5 TIMES.
               05 team-name PIC X(20).
               05 members OCCURS 10 TIMES.
                  10 member-name PIC X(20).
       
       PROCEDURE DIVISION.
       
       MAIN-PROCEDURE.           
           JSON PARSE WS-JSON INTO JSON-DATA
                NAME JSON-DATA IS OMITTED

           DISPLAY department  
           DISPLAY " "
           DISPLAY team-name(1)    
           DISPLAY member-name (1, 1)
           DISPLAY member-name (1, 2)
           DISPLAY member-name (1, 3)
           DISPLAY " "
           DISPLAY team-name(2)    
           DISPLAY member-name (2, 1)
           DISPLAY member-name (2, 2)
           GOBACK.