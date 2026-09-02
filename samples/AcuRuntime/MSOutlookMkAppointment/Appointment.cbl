       IDENTIFICATION DIVISION.
       PROGRAM-ID. MsOutlook.
      *====================
      *
      * Copyright (c) 1996-2006 by Acucorp, Inc.  Users of ACUCOBOL
      * may freely modify and redistribute this program.
      *
      *This program is provided 'as is'. It illustrates how to access
      *Microsoft Outlook from ACUCOBOL-GT, it is built based on a sample
      *visual basic code provided on msdn.microsoft.com, the vb code is
      *provided.
      *
      * Add a contact
      * Set up an appointment with that contact
      * Send an email to that contact

      * Before testing this sample there are two issues to resolve in the
      * code:
      *
      *  The "hsolo@space.com" must be set to a valid email address.
      *
      *  If this demo is ran on a non US computer, you will probably
      *  have to change the date and time field delimiters being used
      *  for the date manipulation (see end of NOW section).
      *
      * Also note that when you run this with more recent versions of
      * Microsoft Outlook, it will bring up a dialog to warn you once you
      * try to send an email. How to turn this of, is something you will
      * have to discuss with Microsoft.
      *
       ENVIRONMENT DIVISION.
       CONFIGURATION                SECTION.
       SPECIAL-NAMES.
           COPY    "MSOutlook.def".
                   .
       DATA        DIVISION.
       WORKING-STORAGE              SECTION.
       77  olApp                    HANDLE OF Application.
       77  olNs                     HANDLE OF Namespace.
       77  olItem                   HANDLE OF ContactItem.
       77  olAppt                   HANDLE OF AppointmentItem.
       77  olMail                   HANDLE OF MailItem.
       77  AddressString            PIC X(1024).
       77  TmpString                PIC X(1024).

       01  TODAYS-DATE.
           03 YEAR                  PIC 9(04).
           03 MONTH                 PIC 9(02).
           03 TODAY                 PIC 9(02).

       01  CURRENT-TIME.
           03 HOUR                  PIC 99.
           03 MINUTE                PIC 99.
           03 SECOND                PIC 99.
           03 FILLER                PIC 99.

       01  FILLER.
           03 AM-PM                 PIC X(02).

       PROCEDURE DIVISION.
       Main.
      *Open the Outlook object (hooking into, if already running)
           CREATE  Application      OF Outlook
                   HANDLE           IN olApp.
           MODIFY  olApp            GetNameSpace("MAPI")
                   GIVING           olNs.
           MODIFY  olNs             Logon().

      *Create a new contact item
           MODIFY  olApp            CreateItem(olContactItem)
                   GIVING           olItem.
           STRING  "101 Hollywood Freeway"
                   x"0d"
                   "Hollywood, CA 91608" DELIMITED BY SIZE INTO
                   AddressString.
           MODIFY  olItem
                   Fullname         = "Han Solo"
                   Birthday         = "9/15/1975"
                   CompanyName      = "Star Wars"
                   HomeTelephoneNumber = "704-555-8888"
      *You must change this into a valid email to have the email part of the
      *example work properly.
                   Email1Address    = "cheesle@online.no" | "hsolo@space.com"
                   JobTitle         = "Moviestar"
                   HomeAddress      = AddressString.
           MODIFY  olItem           Save().

      *Create a new appointment
           INQUIRE olItem           FullName IN TmpString.
           INSPECT TmpString        REPLACING TRAILING SPACES BY
                   LOW-VALUE.
           STRING  "Meeting with "  DELIMITED BY SIZE
                   TmpString        DELIMITED BY LOW-VALUE
                   " to discuss Darth Vader" DELIMITED BY SIZE
                   INTO             AddressString.
           MODIFY  olApp            CreateItem(olAppointmentItem)
                   GIVING           olAppt.
      *A note about the date handling here. The below string is formatted for
      *and will work with US settings. It is very likely that a computer set
      *up with a different codepage setting, for instance German or French,
      *will use something else for date/time separators than here ('/' and ':'
      * and certainly not use AM/PM)
      *I am not resolving this here, as a solution to this is illustrated in
      *the MSMailMerge example.

           PERFORM NOW.
      *     MODIFY  olAppt           Start = "7/16/2003 1:30:00 PM".
           MODIFY  olAppt
                   @Start           = TmpString
                   Duration         = 60
                   Subject          = "Meeting to discuss Darth Vader"
                   Body             = AddressString
                   Location         "Battlestar Galactica"
                   ReminderMinutesBeforeStart = 1
                   ReminderSet      = 1.
           MODIFY  olAppt           Save().

      *Send the invitation
           MODIFY  olApp            CreateItem(olMailItem)
                   GIVING           olMail.
           INQUIRE olItem           Email1Address IN AddressString.
           MODIFY  olMail
                   @To              AddressString.
           String  "Dear "          DELIMITED BY SIZE
                   TmpString        DELIMITED BY SPACE
                   ", "             DELIMITED BY SIZE
                   x"0d"            DELIMITED BY SIZE
                   "I'll see you in 2 minutes for our meeting!"
                                    DELIMITED BY SIZE
                   x"0d"            DELIMITED BY SIZE
                   x"0d"            DELIMITED BY SIZE
                   "Btw: I've added you to my contact list."
                                    DELIMITED BY SIZE
                   INTO             AddressString.
           MODIFY  olMail
                   Subject          "About our meeting..."
                   Body             AddressString.
           MODIFY  olMail           @Send().

           DESTROY olMail.
           DESTROY olAppt.
           DESTROY olItem.
           DESTROY olNs.
           DESTROY olApp.
           GOBACK.

       NOW SECTION.
       NOW-001.

           ACCEPT  TODAYS-DATE      FROM CENTURY-DATE.
           ACCEPT  CURRENT-TIME     FROM TIME.
           ADD     2                TO   MINUTE.

       CTRL-60-MINUTES.

           IF      MINUTE           >  59
                   SUBTRACT         60 FROM MINUTE
                   ADD              1  TO HOUR
                   GO               TO CTRL-60-MINUTES.

       CTRL-24-HOURS.

           IF      HOUR             >  23
                   SUBTRACT         24 FROM HOUR
                   ADD              1  TO TODAY
                   GO               TO CTRL-24-HOURS.

      *Making a simple test, should have paid attention to what
      *month and so, but that is not the major issue here.
       CTRL-30-DAYS.

           IF      TODAY            >  30
                   SUBTRACT         30 FROM TODAY
                   ADD              1  TO MONTH
                   GO               TO CTRL-30-DAYS.

       CTRL-12-MONTH.

           IF      MONTH            >  12
                   SUBTRACT         12 FROM MONTH
                   ADD              1  TO YEAR
                   GO               TO CTRL-12-MONTH.

      *No. This program is not year 3000 compliant!

           IF      HOUR             <  12
                   MOVE             "AM" TO AM-PM
           ELSE
                   MOVE             "PM" TO AM-PM.

           STRING  MONTH
                   "/"
                   TODAY
                   "/"
                   YEAR
                   " "
                   HOUR
                   ":"
                   MINUTE
                   ":"
                   SECOND
                   " "
                   AM-PM
                   DELIMITED        BY SIZE INTO TmpString.

       NOW-900.
       NOW-EXIT.
           EXIT.