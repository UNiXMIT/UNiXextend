 ' Start Outlook.
 ' If it is already running, you'll use the same instance...
   Dim olApp As Outlook.Application
   Set olApp = CreateObject("Outlook.Application")

 ' Logon. Doesn't hurt if you are already running and logged on...
   Dim olNs As Outlook.NameSpace
   Set olNs = olApp.GetNamespace("MAPI")
   olNs.Logon

 ' Create and Open a new contact.
   Dim olItem As Outlook.ContactItem
   Set olItem = olApp.CreateItem(olContactItem)

 ' Setup Contact information...
   With olItem
      .FullName = "James Smith"
      .Birthday = "9/15/1975"
      .CompanyName = "Microsoft"
      .HomeTelephoneNumber = "704-555-8888"
      .Email1Address = "someone@microsoft.com"
      .JobTitle = "Developer"
      .HomeAddress = "111 Main St." & vbCr & "Charlotte, NC 28226"
   End With

 ' Save Contact...
   olItem.Save

 ' Create a new appointment.
   Dim olAppt As Outlook.AppointmentItem
   Set olAppt = olApp.CreateItem(olAppointmentItem)

 ' Set start time for 2-minutes from now...
   olAppt.Start = Now() + (2# / 24# / 60#)

 ' Setup other appointment information...
   With olAppt
      .Duration = 60
      .Subject = "Meeting to discuss plans..."
      .Body = "Meeting with " & olItem.FullName & " to discuss plans."
      .Location = "Home Office"
      .ReminderMinutesBeforeStart = 1
      .ReminderSet = True
   End With

 ' Save Appointment...
   olAppt.Save

 ' Send a message to your new contact.
   Dim olMail As Outlook.MailItem
   Set olMail = olApp.CreateItem(olMailItem)
 ' Fill out & send message...
   olMail.To = olItem.Email1Address
   olMail.Subject = "About our meeting..."
   olMail.Body = _
        "Dear " & olItem.FirstName & ", " & vbCr & vbCr & vbTab & _
        "I'll see you in 2 minutes for our meeting!" & vbCr & vbCr & _
        "Btw: I've added you to my contact list."
   olMail.Send

 ' Clean up...
   MsgBox "All done...", vbMsgBoxSetForeground
   olNS.Logoff
   Set olNs = Nothing
   Set olMail = Nothing
   Set olAppt = Nothing
   Set olItem = Nothing
   Set olApp = Nothing
